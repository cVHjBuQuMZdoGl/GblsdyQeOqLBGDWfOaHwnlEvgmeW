if not game:IsLoaded() then game.Loaded:Wait() end
local Players=game:GetService("Players")
while not Players.LocalPlayer do task.wait() end
while not workspace.CurrentCamera do task.wait() end
local cloneref=(cloneref or clonereference or function(v)return v end)
local RunService=cloneref(game:GetService("RunService"))
local UserInputService=cloneref(game:GetService("UserInputService"))
local Lighting=cloneref(game:GetService("Lighting"))
local Stats=cloneref(game:GetService("Stats"))
local VirtualInputManager=cloneref(game:GetService("VirtualInputManager"))
local CoreGui=cloneref(game:GetService("CoreGui"))
local GuiService=cloneref(game:GetService("GuiService"))
local ReplicatedStorage=cloneref(game:GetService("ReplicatedStorage"))
local PathfindingService=cloneref(game:GetService("PathfindingService"))
local ProximityPromptService=cloneref(game:GetService("ProximityPromptService"))
local HttpService=cloneref(game:GetService("HttpService"))
local LocalPlayer=Players.LocalPlayer
local PlayerGui=LocalPlayer:WaitForChild("PlayerGui")

-- =========================================================
-- UI PARENT
-- =========================================================

local function GetUIParent()
    local ok,res=pcall(function()
        if gethui then
            return gethui()
        end
        if syn and syn.protect_gui then
            local gui=Instance.new("ScreenGui")
            syn.protect_gui(gui)
            gui.Parent=CoreGui
            return gui
        end
        return CoreGui
    end)
    return ok and res or CoreGui
end
local TargetGui=GetUIParent()

-- =========================================================
-- SAFE HTTPGET
-- =========================================================

local function SafeHttpGet(url)
    local ok,res=pcall(function()
        if game.HttpGet then
            return game:HttpGet(url)
        end
        if syn and syn.request then
            return syn.request({
                Url=url,
                Method="GET"
            }).Body
        end
        if http_request then
            return http_request({
                Url=url,
                Method="GET"
            }).Body
        end
        error("HttpGet unsupported")
    end)
    return ok and res or nil
end

-- =========================================================
-- LOAD WINDUI
-- =========================================================

local WindUI
do
    local src=SafeHttpGet(
        "https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"
    )
    if src then
        local ok,res=pcall(function()
            return loadstring(src)()
        end)
        if ok then
            WindUI=res
        end
    end
end

if WindUI then
    print("[FORKT] WindUI Loaded")
else
    warn("[FORKT] Failed Load WindUI")
    pcall(function()
        game:GetService("StarterGui"):SetCore(
            "SendNotification",
            {
                Title="FORKT",
                Text="Failed loading WindUI"
            }
        )
    end)
    return
end

-- =========================================================
-- LOAD JUNKIE
-- =========================================================

local Junkie
do
    local src=SafeHttpGet(
        "https://jnkie.com/sdk/library.lua"
    )
    if src then
        local ok,res=pcall(function()
            return loadstring(src)()
        end)
        if ok then
            Junkie=res
        end
    end
end

if Junkie then

    Junkie.service="FORKT"
    Junkie.identifier="1041888"
    Junkie.provider="Mixed"
    print("[FORKT] Junkie Loaded")

else
    warn("[FORKT] Failed Load Junkie")
    pcall(function()
        game:GetService("StarterGui"):SetCore(
            "SendNotification",
            {
                Title="FORKT",
                Text="Junkie API failed"
            }
        )
    end)
end

-- =========================================================
-- ANTI MEMORY LEAK
-- =========================================================

getgenv().FORKT_CONNECTIONS=
    getgenv().FORKT_CONNECTIONS or {}
for _,conn in ipairs(getgenv().FORKT_CONNECTIONS) do
    pcall(function()
        RunService:UnbindFromRenderStep(
            "SmoothFOV"
        )
        if conn and conn.Disconnect then
            conn:Disconnect()
        end
    end)
end

table.clear(getgenv().FORKT_CONNECTIONS)
----------------------------------------------------------------
-- ESP COLORS (Pengganti Config Manual)
----------------------------------------------------------------
local ESP_COLORS = {
    Killer = Color3.fromRGB(255, 93, 108), 
    Survivor = Color3.fromRGB(0, 255, 34),
    Generator = Color3.fromRGB(200, 100, 0), 
    Gate = Color3.fromRGB(255, 255, 255),
    Pallet = Color3.fromRGB(53, 189, 166), 
    Hook = Color3.fromRGB(252, 116, 116)
}
local MaskNames = {
    ["Abysswalker"] = "ABYSSWALKER",
    ["Cure"]        = "CURE",
    ["Hidden"]      = "HIDDEN",
    ["Killer"]      = "THE KILLER",
    ["Masked"]      = "PALA AYAM",
    ["Stalker"]     = "STALKER",
    ["Veil"]        = "VEIL",
    ["Slasher"]     = "SLASHER",
}

local MaskColors = {
    ["Abysswalker"] = Color3.fromRGB(110, 20, 255), -- Void Purple
    ["Cure"]        = Color3.fromRGB(0, 54, 156), -- blue
    ["Hidden"]      = Color3.fromRGB(170, 170, 170), -- Pale Grey
    ["Killer"]      = Color3.fromRGB(255, 40, 40), -- Blood Red
    ["Masked"]      = Color3.fromRGB(255, 90, 20), -- Deep Orange
    ["Stalker"]     = Color3.fromRGB(255, 0, 140), -- Neon Pink
    ["Veil"]        = Color3.fromRGB(0, 140, 255), -- Electric Blue
    ["Slasher"]     = Color3.fromRGB(180, 0, 255), -- Dark Magenta
}
local CachedMapObjects = {
    Generators = {},
    Pallets = {},
    Hooks = {},
    Gates = {}
}
local SpoofData = {
    Gears = 0,
    Screws = 0,
    Level = 0
}
local PrevESPState = { Generator = false, Hook = false, Pallet = false, Gate = false }
-- =========================================================
-- [NATIVE CACHE] MEMPERCEPAT KECEPATAN EKSEKUSI HINGGA 30%
-- =========================================================
local v3 = Vector3.new
local v2 = Vector2.new
local cnew = CFrame.new
local cangles = CFrame.Angles
local t_insert = table.insert
local t_remove = table.remove
local m_floor = math.floor
local m_round = math.round
local s_format = string.format

local function UpdateMapCache()
    local map = workspace:FindFirstChild("Map")
    if not map then return end
    
    CachedMapObjects.Generators = {}
    CachedMapObjects.Pallets = {}
    CachedMapObjects.Hooks = {}
    CachedMapObjects.Gates = {}
    
    local descendants = map:GetDescendants()
    for i = 1, #descendants do
        local obj = descendants[i]
        
        -- [GAYA BARU DARI TEMPLATE] Deteksi Nama Instan & Ketat (Sangat Hemat CPU)
        local n = obj.Name
        if n == "Generator" then 
            t_insert(CachedMapObjects.Generators, obj)
        elseif n == "Hook" then  
            t_insert(CachedMapObjects.Hooks, obj)
        elseif n == "Gate" then 
            t_insert(CachedMapObjects.Gates, obj)
        elseif n == "Pallet" or n == "Palletwrong" then 
            t_insert(CachedMapObjects.Pallets, obj)
        end
        
        if i % 500 == 0 then task.wait() end 
    end

    if PrevESPState then
        PrevESPState.Generator = false
        PrevESPState.Hook = false
        PrevESPState.Pallet = false
        PrevESPState.Gate = false
    end
end

-- =========================================================
-- [OPTIMASI] LITE MAP DETECTOR (STREAMING-ENABLED FIX)
-- =========================================================
task.spawn(function() 
    local mapWasEmpty = true 
    local descendantConn = nil 
    
    while task.wait(2) do 
        if not getgenv().FORKT_RUNNING then 
            if descendantConn then descendantConn:Disconnect() end
            break 
        end
        
        local currentMap = workspace:FindFirstChild("Map")
        local hasContents = currentMap and #currentMap:GetChildren() > 0
        
        if hasContents and mapWasEmpty then
            mapWasEmpty = false 
            
            task.delay(8, function()
                if currentMap and #currentMap:GetChildren() > 0 then
                    cachedChar = nil; cachedRoot = nil
                    UpdateMapCache() 
                    
                    if descendantConn then descendantConn:Disconnect() end
                    descendantConn = currentMap.DescendantAdded:Connect(function(obj)
                        -- [GAYA BARU DARI TEMPLATE]
                        local n = obj.Name
                        if n == "Generator" then 
                            t_insert(CachedMapObjects.Generators, obj)
                        elseif n == "Hook" then 
                            t_insert(CachedMapObjects.Hooks, obj)
                        elseif n == "Gate" then 
                            t_insert(CachedMapObjects.Gates, obj)
                        elseif n == "Pallet" or n == "Palletwrong" then 
                            t_insert(CachedMapObjects.Pallets, obj)
                        end
                    end)
                    
                    local palletCount = CachedMapObjects.Pallets and #CachedMapObjects.Pallets or 0
                    local genCount = CachedMapObjects.Generators and #CachedMapObjects.Generators or 0
                    
                    WindUI:Notify({ 
                        Title = "Map Loaded", 
                        Content = "Menemukan " .. palletCount .. " Pallet & " .. genCount .. " Gen. Radar Aktif!", 
                        Icon = "lucide:radar" 
                    })
                end
            end)
            
        elseif not hasContents and not mapWasEmpty then
            mapWasEmpty = true 
            
            if descendantConn then 
                descendantConn:Disconnect() 
                descendantConn = nil 
            end
            
            CachedMapObjects.Generators = {}
            CachedMapObjects.Pallets = {}
            CachedMapObjects.Hooks = {}
            CachedMapObjects.Gates = {}
            if ActiveGenerators then table.clear(ActiveGenerators) end
            
            if PrevESPState then
                PrevESPState.Generator = false; PrevESPState.Hook = false
                PrevESPState.Pallet = false; PrevESPState.Gate = false
            end
        end
    end 
end)

getgenv().MoonwalkZigzagSpeed=11
getgenv().MoonwalkBoostPower=1.08
getgenv().AutoFarmSpeed=17
getgenv().GeneratorPerfectOffsetStart=102
getgenv().GeneratorPerfectOffsetEnd=109
getgenv().ParryMatchup="Auto"
getgenv().AimStrictness=1.3
getgenv().ParryDelayOffset=0
getgenv().FORKT_RUNNING=true
getgenv().AimbotSmoothness=8

local MoonwalkEnabled=false
local KEY_TOGGLE=Enum.KeyCode.R

local AutoGenerator=false
local AutoGeneratorMode="Perfect"

local AutoParry=false
local ParryDistance=10

local ExactParryRemote
local LastParryTick=0

local CFG_AimPrediction=true
local CFG_BurstAmount=8
local CFG_ParryCooldown=0.45
local CFG_MaxVelocity=32

local GenConnection=nil

local SpeedBoost=false
local NoSlowdown=false
local InstantHeal=false
local AntiKnock=false
local AntiBlind=false
local AntiStun=false

local Aimbot=false
local WallCheck=true
local ShowFOVCircle=false

local CustomCameraFOV=false
local CameraFOVValue=100

local AimRadius=getgenv().AimRadius or 60
local AimDistance=getgenv().AimDistance or 80
local AimKey=Enum.KeyCode.Q

local BoostSpeed=30
local CachedTarget=nil
local LastTargetCheck=0

local cachedChar,cachedRoot,cachedHum=nil,nil,nil

local AutoAttack=false
local AttackRange=10
local WarnKiller=true
local ActiveGenerators={}
local ThemeName="FORKT"
local Refreshing=false
local AutoUnhook=false
local AutoWiggle=false
local AutoFarmBot=false

local SilentAimPistol=false

local CachedTwistFire
local CachedTwistVisual

local DoubleDamageGen=false
local SpearPrediction=false
local AntiGravitySpear=false
local MobileRotateBtn=nil

local HitboxExpander=false
local HitboxSize=15

local AutoHealAura=false
local HealAuraRadius=20

local aimRayParams=RaycastParams.new()
aimRayParams.FilterType=Enum.RaycastFilterType.Blacklist

local SilentActions=false
local AntiFallDamage=false
local AntiLogger=true
local NotifyStun=false

local ESP_Survivor_Name=false
local ESP_Survivor_Highlight=false
local ESP_Killer_Name=false
local ESP_Killer_Highlight=false
local ESP_Generator=false
local ESP_Gate=false
local ESP_Pallet=false
local ESP_Hook=false

local ActiveESP={}
local LastKillerWarnCheck=0
local closestKillerDist=999
local LastUpdateTick=0
local LastESPRefresh=0

local TouchID=8822
local isTriggering=false
local FOVCircle=nil

local lastTouchCheck=0
local cachedTouches={}

-- 1. SETUP FOV CIRCLE
local IndicatorGui = TargetGui:FindFirstChild("FORKT_Indicator") or Instance.new("ScreenGui")
IndicatorGui.Name = "FORKT_Indicator" 
IndicatorGui.IgnoreGuiInset = true 
IndicatorGui.ResetOnSpawn = false
IndicatorGui.Parent = TargetGui

if IndicatorGui:FindFirstChild("FOVCircle") then IndicatorGui.FOVCircle:Destroy() end
FOVCircle = Instance.new("Frame", IndicatorGui)
FOVCircle.Name = "FOVCircle"
FOVCircle.Size = UDim2.new(0, AimRadius * 2, 0, AimRadius * 2)
FOVCircle.AnchorPoint = v2(0.5, 0.5)
FOVCircle.Position = UDim2.new(0.5, 0, 0.5, 0)
FOVCircle.BackgroundTransparency = 1
FOVCircle.Visible = ShowFOVCircle

local corner = Instance.new("UICorner", FOVCircle) 
corner.CornerRadius = UDim.new(1, 0)
local stroke = Instance.new("UIStroke", FOVCircle) 
stroke.Color = Color3.new(1, 1, 1)
stroke.Transparency = 0.5
stroke.Thickness = 1.5

----------------------------------------------------------------
-- SCP / ZOMBIE ESP
-- ULTRA STABLE
----------------------------------------------------------------

ESP_SCP=ESP_SCP or false

local SCPESPFolder=
    CoreGui:FindFirstChild("SCP_ESP")
    or Instance.new("Folder")

SCPESPFolder.Name="SCP_ESP"
SCPESPFolder.Parent=CoreGui

local SCPESPCache={}
local SCPConnections={}

----------------------------------------------------------------
-- VALID SCP
----------------------------------------------------------------

local function IsSCP(obj)

    if not obj
    or not obj:IsA("Model") then
        return false
    end

    local n=obj.Name:lower()

    return
        n=="scp"
        or n:match("^scp%d*$")
        or n:find("zombie")
        or n:find("monster")
        or n:find("creature")
end

----------------------------------------------------------------
-- REMOVE
----------------------------------------------------------------

local function RemoveSCPESP(model)

    local esp=SCPESPCache[model]

    if esp then
        pcall(function()
            esp:Destroy()
        end)
    end

    SCPESPCache[model]=nil
end

----------------------------------------------------------------
-- GET ADORNEE
----------------------------------------------------------------

local function GetAdornee(model)

    if model.PrimaryPart then
        return model
    end

    local part=
        model:FindFirstChild("HumanoidRootPart",true)
        or model:FindFirstChildWhichIsA("BasePart",true)

    return part and model or nil
end

----------------------------------------------------------------
-- CREATE
----------------------------------------------------------------

local function CreateSCPESP(model)

    if not ESP_SCP
    or SCPESPCache[model]
    or not model.Parent then
        return
    end

    local adornee=GetAdornee(model)

    if not adornee then
        return
    end

    local hl=Instance.new("Highlight")

    hl.Name="SCPESP"
    hl.Adornee=model

    hl.FillColor=Color3.fromRGB(170,0,255)
    hl.OutlineColor=Color3.fromRGB(220,170,255)

    hl.FillTransparency=0.45
    hl.OutlineTransparency=0

    hl.DepthMode=
        Enum.HighlightDepthMode.AlwaysOnTop

    hl.Parent=SCPESPFolder

    SCPESPCache[model]=hl

    ------------------------------------------------
    -- AUTO REMOVE
    ------------------------------------------------

    SCPConnections[model]=model.AncestryChanged:Connect(function(_,parent)

        if not parent then
            RemoveSCPESP(model)
        end
    end)
end

----------------------------------------------------------------
-- SCAN
----------------------------------------------------------------

local function ScanSCP()

    local map=workspace:FindFirstChild("Map")

    if not map then
        return
    end

    for _,obj in ipairs(map:GetDescendants()) do

        if IsSCP(obj) then
            CreateSCPESP(obj)
        end
    end
end

----------------------------------------------------------------
-- INITIAL SCAN
----------------------------------------------------------------

ScanSCP()

----------------------------------------------------------------
-- REALTIME DETECT
----------------------------------------------------------------

local map=workspace:FindFirstChild("Map")

if map then

    map.DescendantAdded:Connect(function(obj)

        if IsSCP(obj) then

            task.wait(0.2)

            CreateSCPESP(obj)
        end
    end)
end

----------------------------------------------------------------
-- REFRESH
----------------------------------------------------------------

task.spawn(function()

    while task.wait(2) do

        if not getgenv().FORKT_RUNNING then
            break
        end

        ------------------------------------------------
        -- DISABLED
        ------------------------------------------------

        if not ESP_SCP then

            for model in pairs(SCPESPCache) do
                RemoveSCPESP(model)
            end

            continue
        end

        ------------------------------------------------
        -- VALIDATE
        ------------------------------------------------

        for model,esp in pairs(SCPESPCache) do

            if not model
            or not model.Parent
            or not esp
            or not esp.Parent then

                RemoveSCPESP(model)

            elseif not esp.Adornee then

                esp.Adornee=model
            end
        end

        ------------------------------------------------
        -- RESCAN
        ------------------------------------------------

        ScanSCP()
    end
end)
-- // UI MOBILE (FORKT-STYLE)
local MoonwalkUI = Instance.new("ScreenGui")
local MoonwalkBtn = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")
local UIStroke = Instance.new("UIStroke")

-- Gunakan pcall agar tidak error jika CoreGui diproteksi
pcall(function()
    MoonwalkUI.Name = "FORKT_MoonwalkUI"
    MoonwalkUI.Enabled = false
    MoonwalkUI.Parent = (game:GetService("CoreGui") or game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"))
    MoonwalkUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
end)

MoonwalkBtn.Name = "MoonwalkBtn"
MoonwalkBtn.Parent = MoonwalkUI
MoonwalkBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MoonwalkBtn.Position = UDim2.new(1, -95, 0.5, -35)
MoonwalkBtn.Size = UDim2.new(0, 65, 0, 65) -- Sedikit dikecilkan agar pas di jempol mobile
MoonwalkBtn.Font = Enum.Font.GothamBold
MoonwalkBtn.Text = "MW: OFF"
MoonwalkBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MoonwalkBtn.TextSize = 14
MoonwalkBtn.Draggable = true 

UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MoonwalkBtn

UIStroke.Color = Color3.fromRGB(100, 100, 100)
UIStroke.Thickness = 2
UIStroke.Parent = MoonwalkBtn

-- // CORE FUNCTION: TOGGLE
local function ToggleMoonwalk()
    -- Cek Premium (Gunakan variabel global yang kamu pakai di script utama)
    if not getgenv().FORKT_PREMIUM then 
        if WindUI then
            WindUI:Notify({ Title = "VIP Required", Content = "Fitur ini hanya untuk member Premium!", Icon = "lucide:lock" })
        end
        return 
    end

    getgenv().MoonwalkEnabled = not getgenv().MoonwalkEnabled
    
    -- Update UI Look
    if getgenv().MoonwalkEnabled then
        MoonwalkBtn.Text = "MW: ON"
        MoonwalkBtn.TextColor3 = Color3.fromRGB(247, 107, 28)
        UIStroke.Color = Color3.fromRGB(247, 107, 28)
    else
        MoonwalkBtn.Text = "MW: OFF"
        MoonwalkBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        UIStroke.Color = Color3.fromRGB(100, 100, 100)
        
        -- Perbaikan: Pastikan mengambil Humanoid terbaru saat karakter respawn
        local char = game.Players.LocalPlayer.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hum then hum.AutoRotate = true end
    end
end

-- // INPUT LISTENERS
MoonwalkBtn.MouseButton1Click:Connect(ToggleMoonwalk)

-- Gunakan UserInputService yang sudah didefinisikan sebelumnya
game:GetService("UserInputService").InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.KeyCode == KEY_TOGGLE then
        ToggleMoonwalk()
    end
end)

-- =========================================================
-- 2. SETUP CROSSHAIR (DYNAMIC SIZE READY)
-- =========================================================
if TargetGui:FindFirstChild("VeilCrosshair") then TargetGui.VeilCrosshair:Destroy() end

getgenv().CrosshairGui = Instance.new("ScreenGui") 
getgenv().CrosshairGui.Name = "VeilCrosshair" 
getgenv().CrosshairGui.IgnoreGuiInset = true 
getgenv().CrosshairGui.ResetOnSpawn = false
getgenv().CrosshairGui.Enabled = false 
getgenv().CrosshairGui.Parent = TargetGui

local dot = Instance.new("Frame", getgenv().CrosshairGui)
dot.Name = "DotMarker"
dot.Size = UDim2.new(0, 4, 0, 4) 
dot.AnchorPoint = v2(0.5, 0.5) 
dot.Position = UDim2.new(0.5, 0, 0.5, 0) 
dot.BackgroundColor3 = Color3.fromRGB(255, 0, 0) 
dot.BorderSizePixel = 0

local dotCorner = Instance.new("UICorner", dot)
dotCorner.CornerRadius = UDim.new(1, 0)

local dotStroke = Instance.new("UIStroke", dot)
dotStroke.Color = Color3.new(0, 0, 0)
dotStroke.Thickness = 1.1

-- 3. SETUP PARRY RING
local oldRing = TargetGui:FindFirstChild("FORKT_ParryRing")
if oldRing then oldRing:Destroy() end

------------------------------------------------
-- PARRY RING
------------------------------------------------

local oldRing =
    TargetGui:FindFirstChild("FORKT_ParryRing")
if oldRing then
    oldRing:Destroy()
end
local ParryRing =
    Instance.new("CylinderHandleAdornment")
ParryRing.Name = "FORKT_ParryRing"
ParryRing.Color3 =
    Color3.fromRGB(170,40,255)
ParryRing.Transparency = 0.7
ParryRing.AlwaysOnTop = true
ParryRing.ZIndex = 10

ParryRing.Height = 0.05

local radius =
    tonumber(ParryDistance)
    or 10
ParryRing.Radius = radius
ParryRing.CFrame =
    CFrame.new(0,-2.8,0)
    * CFrame.Angles(
        math.rad(90),
        0,
        0
    )
ParryRing.Adornee = HumanoidRootPart
ParryRing.Parent = TargetGui

----------------------------------------------------------------
-- UTILITY FUNCTIONS (ESP LOGIC) - OPTIMIZED
----------------------------------------------------------------
local function GetGameValue(obj, name)
    if typeof(obj) ~= "Instance" then return nil end 
    
    -- 1. Cek Attribute Dulu (Sangat Cepat, 0 Lag)
    local attr = obj:GetAttribute(name)
    if attr ~= nil then return attr end
    local child = obj:FindFirstChild(name)
    if child then
        if child:IsA("ValueBase") then 
            return child.Value 
        end
    end
    
    return nil
end

local function CreateBillboardTag(text, color, size, textSize)
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "TagESP"
    billboard.AlwaysOnTop = true
    billboard.Size = size or UDim2.new(0, 150, 0, 40)
    
    billboard.LightInfluence = 0 
    billboard.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = color
    label.Font = Enum.Font.GothamBold
    label.TextSize = textSize or 12
    label.TextWrapped = true
    label.RichText = true 
    
    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 1.2
    stroke.Color = Color3.new(0, 0, 0)
    stroke.Transparency = 0.2
    stroke.Parent = label
    
    label.Parent = billboard
    
    return billboard
end
--// Variabel Helper (Taruh di bagian atas skrip jika belum ada)
local CurrentYaw = 0
local CurrentSway = 0

local function HandleMoonwalk()
    RunService.RenderStepped:Connect(function(dt)
        -- Cek apakah fitur diaktifkan dari UI/Toggle
        if getgenv().MoonwalkEnabled then
            local char = LocalPlayer.Character
            local root = char and char:FindFirstChild("HumanoidRootPart")
            local hum = char and char:FindFirstChild("Humanoid")
            
            if root and hum and hum.Health > 0 then
                -- 1. Matikan AutoRotate agar tidak bentrok dengan script
                hum.AutoRotate = false
                
                -- 2. Ambil arah kamera (Logic dari script VDS kamu)
                local cam = workspace.CurrentCamera
                local look = cam.CFrame.LookVector
                local camYaw = math.deg(math.atan2(look.X, look.Z))
                
                -- 3. Target Yaw (Belakang + Offset)
                local targetYaw = camYaw + 180 -- Mundur
                
                -- 4. Smooth Rotation (Normalize Angle agar tidak mutar balik)
                local diff = (targetYaw - CurrentYaw + 180) % 360 - 180
                CurrentYaw = CurrentYaw + (diff * 0.28 * math.clamp(dt * 60, 0, 3))
                
                -- 5. Hyper Zigzag Logic (Ambil dari Speed & Amount Slider/Setting)
                local isMoving = hum.MoveDirection.Magnitude > 0.1
                local targetSway = 0
                
                if isMoving then
                    -- Gunakan nilai dari slider kamu atau default VDS
                    local speed = getgenv().MoonwalkZigzagSpeed or 14
                    local amount = getgenv().MoonwalkZigzagAmount or 52
                    targetSway = math.sin(tick() * speed) * amount
                end
                
                -- Smoothing goyangan
                CurrentSway = CurrentSway + (targetSway - CurrentSway) * 0.45
                
                -- 6. Apply Final CFrame ke Karakter
                local finalRotation = CFrame.Angles(0, math.rad(CurrentYaw + CurrentSway), 0)
                root.CFrame = CFrame.new(root.Position) * finalRotation
                
                -- 7. Movement Boost (Agar licin dan cepat)
                if isMoving then
                    local boost = getgenv().MoonwalkBoostPower or 1.15
                    root.Velocity = Vector3.new(
                        hum.MoveDirection.X * (hum.WalkSpeed * boost),
                        root.Velocity.Y, -- Pertahankan gravitasi
                        hum.MoveDirection.Z * (hum.WalkSpeed * boost)
                    )
                end
            end
        else
            -- Kembalikan ke normal jika dimatikan
            local char = LocalPlayer.Character
            local hum = char and char:FindFirstChild("Humanoid")
            if hum and not hum.AutoRotate then
                hum.AutoRotate = true
            end
        end
    end)
end

-- Jalankan fungsinya sekali saja
task.spawn(HandleMoonwalk)

local ESP_UI_Folder = PlayerGui:FindFirstChild("FORKT_ESP_UI")
if not ESP_UI_Folder then
    ESP_UI_Folder = Instance.new("ScreenGui")
    ESP_UI_Folder.Name = "FORKT_ESP_UI"
    ESP_UI_Folder.ResetOnSpawn = false
    ESP_UI_Folder.IgnoreGuiInset = true
    ESP_UI_Folder.Parent = PlayerGui
end

local ESP_3D_Folder = workspace.CurrentCamera:FindFirstChild("FORKT_ESP_3D")
if not ESP_3D_Folder then
    ESP_3D_Folder = Instance.new("Folder")
    ESP_3D_Folder.Name = "FORKT_ESP_3D"
    ESP_3D_Folder.Parent = workspace.CurrentCamera
end
local isFPP = false

local fppHideConn = nil 

local function SwitchCameraMode(toFPP)
    local lp = Players.LocalPlayer
    
    if toFPP then
        lp.CameraMode = Enum.CameraMode.LockFirstPerson
        
        -- [FIX KEPALA KETUTUPAN & ROTASI BADAN] 
        if not fppHideConn then
            fppHideConn = RunService.RenderStepped:Connect(function()
                local char = lp.Character
                if char then
                    -- 1. Sembunyikan Kepala
                    local head = char:FindFirstChild("Head")
                    if head then head.LocalTransparencyModifier = 1 end
                    
                    -- 2. Sembunyikan semua aksesoris (Rambut, Topi, Topeng, dll)
                    for _, obj in ipairs(char:GetChildren()) do
                        if obj:IsA("Accessory") then
                            local handle = obj:FindFirstChild("Handle")
                            if handle then handle.LocalTransparencyModifier = 1 end
                        end
                    end
                    
                    -- 3. Paksa Badan Menghadap Kamera (Real-time Sync)
                    local hrp = char:FindFirstChild("HumanoidRootPart")
                    local hum = char:FindFirstChild("Humanoid")
                    local cam = workspace.CurrentCamera
                    
                    if hrp and hum and cam then
                        -- Matikan rotasi bawaan game agar tidak error/bergetar
                        hum.AutoRotate = false 
                        
                        -- [FIX LOGIKA] Pakai CFrame Angles agar physics badan tetap stabil
                        local lookY = select(2, cam.CFrame:ToEulerAnglesYXZ())
                        local currentLook = hrp.Orientation.Y
                        local targetLook = math.deg(lookY)
                        
                        if math.abs(currentLook - targetLook) > 1 then
                            hrp.CFrame = cnew(hrp.Position) * cangles(0, lookY, 0)
                        end
                    end
                end
            end)
        end
    else
        lp.CameraMode = Enum.CameraMode.Classic
        lp.CameraMaxZoomDistance = 128 
        
        -- Kembalikan rotasi normal saat kembali ke TPP
        local char = lp.Character
        local hum = char and char:FindFirstChild("Humanoid")
        if hum then hum.AutoRotate = true end
        
        if fppHideConn then
            fppHideConn:Disconnect()
            fppHideConn = nil
        end
        
        local char = lp.Character
        if char then
            local head = char:FindFirstChild("Head")
            if head then
                head.LocalTransparencyModifier = 0
            end
        
            for _, obj in ipairs(char:GetChildren()) do
                if obj:IsA("Accessory") then
                    local handle = obj:FindFirstChild("Handle")
                    if handle then
                        handle.LocalTransparencyModifier = 0
                    end
                end
            end
        end
    end
end
local function ApplyHighlight(object, color)
    local h = object:FindFirstChild("H")
    
    -- Jika Highlight belum ada, buat baru
    if not h then
        h = Instance.new("Highlight")
        h.Name = "H"
        h.Adornee = object
        h.FillTransparency = 0.8
        h.OutlineTransparency = 0.5
        h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        
        -- Set warna pertama kali
        h.FillColor = color
        h.OutlineColor = color
        
        h.Parent = object 
        return -- Langsung selesai, tidak perlu lanjut ke kode bawah
    end
    if h.FillColor ~= color then
        h.FillColor = color
        h.OutlineColor = color
    end
    
    -- Hanya pastikan Enabled nyala, jangan dipaksa nulis "true" 60x per detik
    if not h.Enabled then
        h.Enabled = true
    end
end

local function RemoveHighlight(object)
    if object then
        local h = object:FindFirstChild("H")
        if h then h:Destroy() end
    end
end

local ESP_PlayerCache = {}

local function CreatePlayerESP(player, isKiller)
    local char = player.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChild("Humanoid")
    
    if not root or not hum or hum.Health <= 0 then 
        RemovePlayerESP(player) 
        ESP_PlayerCache[player.UserId] = nil 
        return 
    end

    local myChar = LocalPlayer.Character
    local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
    if not myRoot then return end

    -- 1. HITUNG DATA DASAR
    local dist = m_floor((root.Position - myRoot.Position).Magnitude)
    local color = isKiller and ESP_COLORS.Killer or ESP_COLORS.Survivor
    local statusText = ""
    local bottomText = ""

    -- 2. LOGIKA STATUS (DIPINDAHKAN KE ATAS UNTUK CACHE)
    if isKiller then
        local detectedMask = char:GetAttribute("CachedMask") 
                          or char:GetAttribute("KillerType") 
                          or char:GetAttribute("SelectedKiller")
                          or GetGameValue(char, "SelectedKiller")
                          or GetGameValue(player, "SelectedKiller")
                          or GetGameValue(char, "Mask") 
                          or GetGameValue(player, "Mask") 
                          or char.Name

        if detectedMask then 
            -- Simpan ke cache agar tidak memberatkan CPU untuk pencarian selanjutnya
            char:SetAttribute("CachedMask", detectedMask)
            statusText = MaskNames[detectedMask] or "KILLER"
            color = MaskColors[detectedMask] or color
        else
            statusText = "KILLER"
        end
    else
        local function IsActive(v) return v == true or (type(v) == "number" and v > 0) end
        
        -- [FIX] Pendeteksian diekstrak satu per satu agar tidak ada yang terlewat (Anti-Miss)
        local isHooked = IsActive(GetGameValue(char, "IsHooked")) or IsActive(GetGameValue(player, "IsHooked"))
        
        -- [FIX] Tambahkan pendeteksi "IsCarried" dan cek juga di objek Player
        local isCarried = IsActive(GetGameValue(char, "Carried")) 
                       or IsActive(GetGameValue(char, "IsCarried")) 
                       or IsActive(GetGameValue(char, "Grabbed"))
                       or IsActive(GetGameValue(player, "Carried"))
                       
        local isKnocked = IsActive(GetGameValue(char, "Knocked")) or IsActive(GetGameValue(char, "IsKnocked"))

        -- Eksekusi Status Survivor
        if isHooked then
            color = Color3.fromRGB(255, 75, 147); statusText = "HOOKED"
        elseif isCarried then
            color = Color3.fromRGB(200, 75, 255); statusText = "CARRIED"
        elseif isKnocked then
            color = Color3.fromRGB(255, 150, 0); statusText = "KNOCKED"
        elseif hum.Health < hum.MaxHealth then 
            color = Color3.fromRGB(255, 220, 50); statusText = "INJURED" 
        else
            statusText = "IDLE"
        end
    end
    -- 4. FORMAT ULANG TEKS (Hanya jika lolos cache)
    if isKiller then
        bottomText = s_format('<font color="#DDDDDD">%dm</font> | <font color="#%s">[%s]</font>', dist, color:ToHex(), string.upper(statusText))
    else
        if statusText == "IDLE" then
            bottomText = s_format('<font color="#DDDDDD">%dm</font>', dist)
        else
            bottomText = s_format('<font color="#DDDDDD">%dm</font> | <font color="#%s">%s</font>', dist, color:ToHex(), statusText)
        end
    end

    -- Simpan data terbaru ke cache
    ESP_PlayerCache[player.UserId] = {dist = dist, status = statusText}

    local finalName = s_format('<b>%s</b>\n%s', player.Name, bottomText)
        -- [LOGIKA BARU] Cek status masing-masing saklar
    local showName = isKiller and ESP_Killer_Name or (not isKiller and ESP_Survivor_Name)
    local showHighlight = isKiller and ESP_Killer_Highlight or (not isKiller and ESP_Survivor_Highlight)

    -- Eksekusi Highlight Siluet
    if showHighlight then
        ApplyHighlight(char, color)
    else
        RemoveHighlight(char)
    end
    
    -- Eksekusi Teks Nama
    local bg = root:FindFirstChild("TagESP")
    if showName then
        if not bg then
            bg = Instance.new("BillboardGui")
            bg.Name = "TagESP"
            bg.Adornee = root
            bg.Parent = root
            bg.AlwaysOnTop = true
            bg.Size = UDim2.new(0, 150, 0, 35) 
            bg.StudsOffset = v3(0, 4.5, 0)
            bg.MaxDistance = 2000 
            bg.ResetOnSpawn = false
            
            local lbl = Instance.new("TextLabel")
            lbl.Name = "Label"
            lbl.Parent = bg
            lbl.BackgroundTransparency = 1
            lbl.Size = UDim2.new(1, 0, 1, 0)
            lbl.Font = Enum.Font.GothamBold
            lbl.TextScaled = true
            lbl.RichText = true
            lbl.Text = finalName
            lbl.TextColor3 = color
            lbl.TextYAlignment = Enum.TextYAlignment.Bottom
            
            local constraint = Instance.new("UITextSizeConstraint", lbl)
            constraint.MaxTextSize = 7
            constraint.MinTextSize = 5

            local stroke = Instance.new("UIStroke", lbl)
            stroke.Thickness = 1.5
            stroke.Color = Color3.fromRGB(10, 10, 10) 
            stroke.Transparency = 0.3
            stroke.LineJoinMode = Enum.LineJoinMode.Round
        else
            local lbl = bg:FindFirstChild("Label")
            if lbl and lbl.Text ~= finalName then 
                lbl.Text = finalName
                lbl.TextColor3 = color 
            end
        end
    else
        -- Jika ESP Teks mati, hancurkan UI jika masih ada
        if bg then bg:Destroy() end
    end
end


local function RemovePlayerESP(player)
    local char = player.Character
    if char then
        RemoveHighlight(char)
        local bg = char:FindFirstChild("HumanoidRootPart") and char.HumanoidRootPart:FindFirstChild("TagESP")
        if bg then bg:Destroy() end
    end
end
local GEN_COLOR_MID = Color3.fromRGB(255, 140, 0)
local GEN_COLOR_END = Color3.fromRGB(0, 255, 120)

local function updateGeneratorProgress(generator)
    if not generator or not generator.Parent then
        return true
    end

    local percent =
        GetGameValue(generator, "RepairProgress")
        or GetGameValue(generator, "Progress")
        or 0

    local billboard = generator:FindFirstChild("GenBitchHook")

    -- Remove UI jika selesai / ESP off
    if percent >= 100 or not ESP_Generator then
        if billboard then
            billboard:Destroy()
        end

        RemoveHighlight(generator)
        generator:SetAttribute("LastESPPercent", nil)

        return (percent >= 100)
    end

    -- Smart cache
    local roundedPercent = math.floor(percent * 10) / 10
    local lastPercent = generator:GetAttribute("LastESPPercent")

    if lastPercent == roundedPercent and billboard then
        return false
    end

    generator:SetAttribute("LastESPPercent", roundedPercent)

    -- Smooth color transition
    local cp = math.clamp(percent, 0, 100)

    local finalColor =
        (cp < 50)
        and ESP_COLORS.Generator:Lerp(GEN_COLOR_MID, cp / 50)
        or GEN_COLOR_MID:Lerp(GEN_COLOR_END, (cp - 50) / 50)

    ApplyHighlight(generator, finalColor)

    local percentStr = s_format("%.1f%%", roundedPercent)

    -- Target part
    local targetPart =
        generator:FindFirstChild("defaultMaterial", true)
        or (generator:IsA("Model") and generator.PrimaryPart)
        or generator:FindFirstChildWhichIsA("BasePart", true)

    if not targetPart then
        return false
    end

    if not billboard then
    
        billboard = Instance.new("BillboardGui")
        billboard.Name = "GenBitchHook"
        billboard.Parent = generator
    
        billboard.Adornee = targetPart
        billboard.AlwaysOnTop = true
        billboard.LightInfluence = 0
        billboard.ResetOnSpawn = false
    
        -- FIX DISTANCE SCALING
        billboard.MaxDistance = 260
    
        -- FIX TEXT VERTICAL BUG
        billboard.Size = UDim2.new(0, 140, 0, 28)
    
        billboard.StudsOffset = v3(0, 3.1, 0)
    
        local lbl = Instance.new("TextLabel")
        lbl.Name = "Label"
        lbl.Parent = billboard
    
        lbl.BackgroundTransparency = 1
    
        -- FULL SIZE
        lbl.Size = UDim2.fromScale(1, 1)
    
        -- NO TEXTSCALED (IMPORTANT)
        lbl.TextScaled = false
    
        -- CLEAN HORIZONTAL TEXT
        lbl.TextWrapped = false
        lbl.TextXAlignment = Enum.TextXAlignment.Center
        lbl.TextYAlignment = Enum.TextYAlignment.Center
    
        lbl.Font = Enum.Font.GothamBold
    
        -- STABLE SIZE
        lbl.TextSize = 8
    
        lbl.RichText = false
        lbl.Text = percentStr
        lbl.TextColor3 = finalColor
    
        -- CLEANER TEXT
        local stroke = Instance.new("UIStroke")
        stroke.Parent = lbl
        stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
        stroke.Thickness = 1.1
        stroke.Transparency = 0.25
        stroke.Color = Color3.new(0, 0, 0)
    
        -- DISTANCE READABILITY
        local constraint = Instance.new("UITextSizeConstraint")
        constraint.Parent = lbl
        constraint.MaxTextSize = 8
        constraint.MinTextSize = 6
    
    else
    
        local lbl =
            billboard:FindFirstChild("Label")
    
        if lbl then
            lbl.Text = percentStr
            lbl.TextColor3 = finalColor
        end
    end
    return false
end

local function RefreshESP()
    if not workspace.CurrentCamera then
        return
    end
    if #Players:GetPlayers() <= 1 then
        return
    end
    -- 1. PLAYER ESP
    local players = Players:GetPlayers()
    for _, p in ipairs(players) do
        if p ~= LocalPlayer then
            local team = p.Team
            local isKiller = false
            if team and team.Name then
                isKiller = string.find(string.lower(team.Name), "killer") ~= nil
            end
            local shouldESP = false
            if isKiller and (ESP_Killer_Name or ESP_Killer_Highlight) then
                shouldESP = true
            elseif not isKiller and (ESP_Survivor_Name or ESP_Survivor_Highlight) then
                shouldESP = true
            end
            
            if shouldESP then
                CreatePlayerESP(p, isKiller)
            else
                RemovePlayerESP(p)
            end
        end
    end

    if not CachedMapObjects then return end
    
    -- 2. GENERATOR ESP
    if ESP_Generator then
        if not PrevESPState.Generator then PrevESPState.Generator = true end
        local gens = CachedMapObjects.Generators
        
        -- [FIX RAM] Gunakan tabel baru yang bersih daripada table.remove berulang kali
        local newActiveGens = {} 
        for i = 1, #gens do
            local obj = gens[i]
            if obj and obj.Parent then
                local isFinished = updateGeneratorProgress(obj)
                if not isFinished then
                    t_insert(newActiveGens, obj)
                end
            end
        end
        CachedMapObjects.Generators = newActiveGens
        ActiveGenerators = newActiveGens
    elseif PrevESPState.Generator then 
        local gens = CachedMapObjects.Generators
        for _, obj in ipairs(gens) do
            if obj and obj.Parent then
                RemoveHighlight(obj)
                local b = obj:FindFirstChild("GenBitchHook")
                if b then b:Destroy() end
                if obj:GetAttribute("LastESPPercent") then obj:SetAttribute("LastESPPercent", nil) end
            end
        end
        PrevESPState.Generator = false
    end
    
    -- =========================================================
    -- 3. PALLET ESP (GOD-TIER DESTRUCTION SENSOR)
    -- =========================================================
    if ESP_Pallet then
        if not PrevESPState.Pallet then PrevESPState.Pallet = true end 
        local pallets = CachedMapObjects.Pallets
        local MAX_DISTANCE = 140

        for i = #pallets, 1, -1 do 
            local pallet = pallets[i]
            local isValid = pallet and pallet.Parent and pallet:IsDescendantOf(workspace)
            
            if isValid then
                local targetPart = (pallet:IsA("Model") and pallet.PrimaryPart) 
                                or pallet:FindFirstChildWhichIsA("BasePart", true) 
                                or (pallet:IsA("BasePart") and pallet)
                
                -- Cek Fisik Visual: Apakah Pallet disembunyikan?
                local hasVisibleParts = false
                if targetPart then
                    if pallet:IsA("BasePart") then
                        hasVisibleParts = pallet.Transparency < 1
                    else
                        local parts = pallet:GetDescendants()
                        for j = 1, #parts do
                            local p = parts[j]
                            if p:IsA("BasePart") and p.Transparency < 1 then
                                hasVisibleParts = true
                                break
                            end
                        end
                    end
                end
                
                local nLower = string.lower(pallet.Name)
                local function IsActive(val) return val == true or (type(val) == "number" and val > 0) end
                
                local isDropped = IsActive(GetGameValue(pallet, "Dropped")) or IsActive(GetGameValue(pallet, "IsDropped"))
                local isBroken = IsActive(GetGameValue(pallet, "Broken")) or IsActive(GetGameValue(pallet, "IsBroken")) or IsActive(GetGameValue(pallet, "Destroyed"))
                local isFake = string.find(nLower, "fake") or string.find(nLower, "broken") or string.find(nLower, "destroyed")
                
                -- Jika Jatuh, Rusak, Palsu, atau Part belum di-load oleh server
                if isDropped or isBroken or isFake or not hasVisibleParts or not targetPart then
                    local tag = pallet:FindFirstChild("PalletTag")
                    if tag then tag:Destroy() end 
                    
                    if isDropped or isBroken or isFake then
                        t_remove(pallets, i)
                    end
                else
                    local tag = pallet:FindFirstChild("PalletTag")
                    if not tag then 
                        local b = CreateBillboardTag("<b>[PALLET]</b>", ESP_COLORS.Pallet, UDim2.new(0, 50, 0, 18), 6)
                        b.Name = "PalletTag"
                        b.Parent = pallet
                        b.Adornee = targetPart -- SUDAH AMAN
                        b.MaxDistance = MAX_DISTANCE 
                    else
                        -- Jaga-jaga adornee hilang
                        if not tag.Adornee then tag.Adornee = targetPart end
                        local lbl = tag:FindFirstChild("Label")
                        if lbl and lbl.TextColor3 ~= ESP_COLORS.Pallet then
                            lbl.TextColor3 = ESP_COLORS.Pallet
                        end
                    end
                end
            else
                if pallet then
                    local tag = pallet:FindFirstChild("PalletTag")
                    if tag then tag:Destroy() end
                end
                t_remove(pallets, i) 
            end
        end 
    elseif PrevESPState.Pallet then 
        for _, pallet in ipairs(CachedMapObjects.Pallets) do 
            if pallet then 
                local tag = pallet:FindFirstChild("PalletTag")
                if tag then tag:Destroy() end 
            end 
        end
        PrevESPState.Pallet = false
    end

    -- 4. GATE ESP
    if ESP_Gate then
        if not PrevESPState.Gate then PrevESPState.Gate = true end
        local gates = CachedMapObjects.Gates
        for i = #gates, 1, -1 do 
            local gate = gates[i]
            if gate and gate.Parent then
                ApplyHighlight(gate, ESP_COLORS.Gate) 
            else
                t_remove(gates, i)
            end
        end 
    elseif PrevESPState.Gate then 
        for _, gate in ipairs(CachedMapObjects.Gates) do if gate and gate.Parent then RemoveHighlight(gate) end end
        PrevESPState.Gate = false
    end

    -- 5. HOOK ESP
    if ESP_Hook then
        if not PrevESPState.Hook then PrevESPState.Hook = true end
        local hooks = CachedMapObjects.Hooks
        for i = #hooks, 1, -1 do 
            local hook = hooks[i]
            if hook and hook.Parent then
                -- [LOGIKA KUSTOM TEMPLATE] Terapkan warna ke MeshPart di dalam "Model"
                local m = hook:FindFirstChild("Model") 
                if m then 
                    for _, p in ipairs(m:GetDescendants()) do 
                        if p:IsA("MeshPart") then ApplyHighlight(p, ESP_COLORS.Hook) end 
                    end 
                else
                    ApplyHighlight(hook, ESP_COLORS.Hook) -- Fallback aman
                end
            else
                t_remove(hooks, i)
            end
        end 
    elseif PrevESPState.Hook then 
        for _, hook in ipairs(CachedMapObjects.Hooks) do 
            if hook and hook.Parent then 
                -- [LOGIKA KUSTOM TEMPLATE] Menghapus warna
                local m = hook:FindFirstChild("Model") 
                if m then 
                    for _, p in ipairs(m:GetDescendants()) do 
                        if p:IsA("MeshPart") then RemoveHighlight(p) end 
                    end 
                else
                    RemoveHighlight(hook)
                end
            end 
        end
        PrevESPState.Hook = false
    end
end

local cachedRayFilter = {}

local function IsVisible(targetPart)
    if not WallCheck then return true end
    
    local cam = workspace.CurrentCamera
    local origin = cam.CFrame.Position
    local direction = (targetPart.Position - origin)
    local myChar = LocalPlayer.Character
    
    -- Reset tabel filter agar bersih dari nil
    table.clear(cachedRayFilter)
    if cam then table.insert(cachedRayFilter, cam) end
    if myChar then table.insert(cachedRayFilter, myChar) end
    
    aimRayParams.FilterDescendantsInstances = cachedRayFilter
    
    local result = workspace:Raycast(origin, direction, aimRayParams)
    
    if result then 
        return result.Instance:IsDescendantOf(targetPart.Parent) 
    end
    
    return true
end

local function GetClosestKiller()

    local cam=workspace.CurrentCamera
    local center=Vector2.new(
        cam.ViewportSize.X/2,
        cam.ViewportSize.Y/2
    )

    local closest=nil
    local closestDist=math.huge

    for _,plr in ipairs(Players:GetPlayers()) do

        if plr~=LocalPlayer
        and plr.Team
        and plr.Team.Name:lower():find("killer")
        and plr.Character then

            local hrp=
                plr.Character:FindFirstChild("HumanoidRootPart")

            local hum=
                plr.Character:FindFirstChildOfClass("Humanoid")

            if hrp and hum
            and hum.Health>0 then

                local pos,visible=
                    cam:WorldToViewportPoint(hrp.Position)

                if visible then

                    local dist=(
                        Vector2.new(pos.X,pos.Y)-center
                    ).Magnitude

                    if dist<closestDist then
                        closestDist=dist
                        closest=hrp
                    end
                end
            end
        end
    end

    return closest
end

local function GetClosestPlayer(currentTarget)
    local closestPart = nil
    local shortest = AimRadius
    
    local myTeam = LocalPlayer.Team and LocalPlayer.Team.Name:lower() or ""
    local isKiller = myTeam:find("killer") ~= nil
    
    local camera = workspace.CurrentCamera
    local camPos = camera.CFrame.Position 
    local centerScreenX = camera.ViewportSize.X / 2
    local centerScreenY = camera.ViewportSize.Y / 2
    
    local function IsActive(val) return val == true or (type(val) == "number" and val > 0) end
    
    -- =========================================================
    -- [STICKY AIM SYSTEM] KUNCI TARGET LAMA (ANTI-FLICKER)
    -- =========================================================
    if currentTarget and currentTarget.Parent then
        local eChar = currentTarget.Parent
        local eHum = eChar:FindFirstChild("Humanoid")
        
        -- Cek apakah target lama masih layak (hidup & tidak di hook)
        if eHum and eHum.Health > 0 then
            local isKnocked = IsActive(GetGameValue(eChar, "Knocked"))
            local isHooked = IsActive(GetGameValue(eChar, "IsHooked"))
            
            if not (isKiller and (isKnocked or isHooked)) then
                local pos, visible = camera:WorldToViewportPoint(currentTarget.Position)
                if visible then
                    local distX = pos.X - centerScreenX
                    local distY = pos.Y - centerScreenY
                    local dist2D = math.sqrt((distX * distX) + (distY * distY))
                    
                    -- JIKA MASIH DI DALAM LINGKARAN & TERLIHAT, PERTAHANKAN TARGETNYA!
                    if dist2D <= AimRadius and IsVisible(currentTarget) then
                        return currentTarget 
                    end
                end
            end
        end
    end

    -- =========================================================
    -- JIKA TARGET LAMA HILANG/MATI, CARI TARGET BARU:
    -- =========================================================
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local enemyChar = p.Character
            local enemyTeam = p.Team and p.Team.Name:lower() or ""
            local isEnemyKiller = enemyTeam:find("killer") ~= nil
            
            if isKiller and isEnemyKiller then
                continue
            end 
            if not isKiller and not isEnemyKiller then
                continue
            end 
            
            local enemyHum = enemyChar:FindFirstChild("Humanoid")
            if not enemyHum or enemyHum.Health <= 0 then
                continue
            end
            
            if isKiller then
                local isKnocked = IsActive(GetGameValue(enemyChar, "Knocked"))
                local isHooked = IsActive(GetGameValue(enemyChar, "IsHooked"))
                if isKnocked or isHooked then
                    continue
                end
            end
            
            local aimPartName = getgenv().AimbotPart or "Torso"
            local targetPart = nil
            
            if aimPartName == "Head" then
                targetPart = enemyChar:FindFirstChild("Head")
            elseif aimPartName == "Torso" then
                targetPart = enemyChar:FindFirstChild("UpperTorso") or enemyChar:FindFirstChild("Torso")
            elseif aimPartName == "Body (RootPart)" then
                targetPart = enemyChar:FindFirstChild("HumanoidRootPart")
            end
            
            if not targetPart then 
                targetPart = enemyChar:FindFirstChild("HumanoidRootPart") or enemyChar:FindFirstChild("Torso") or enemyChar.PrimaryPart 
            end
            
            if not targetPart then
                continue
            end
            
            local distance3D = (targetPart.Position - camPos).Magnitude
            if distance3D > AimDistance then
                continue
            end
            
            local pos, visible = camera:WorldToViewportPoint(targetPart.Position)
            if visible then
                local distX = pos.X - centerScreenX
                local distY = pos.Y - centerScreenY
                local dist2D = math.sqrt((distX * distX) + (distY * distY))
                
                if dist2D <= shortest then
                    if IsVisible(targetPart) then
                        shortest = dist2D
                        closestPart = targetPart 
                    end
                end
            end
        end
    end
    return closestPart
end
local function TriggerAntiStuck()
    pcall(function()
        local char=workspace:FindFirstChild(LocalPlayer.Name) or LocalPlayer.Character
        local hum=char and char:FindFirstChildOfClass("Humanoid")
        local root=char and char:FindFirstChild("HumanoidRootPart")
        local cam=workspace.CurrentCamera

        -- RESET REMOTE
        pcall(function()
            local remotes=ReplicatedStorage:FindFirstChild("Remotes")
            if not remotes then return end

            local healing=remotes:FindFirstChild("Healing")
            local reset=healing and healing:FindFirstChild("Reset")

            if reset then
                reset:FireServer()
            end
        end)

        if hum and root then
            -- UNLOCK CHARACTER
            root.Anchored=false
            hum.PlatformStand=false
            hum.AutoRotate=true
            hum.Sit=false
            hum:ChangeState(Enum.HumanoidStateType.GettingUp)

            hum.WalkSpeed=SpeedBoost
                and (17+(17*((tonumber(BoostSpeed) or 0)/100)))
                or 17

            -- STOP ANIMATION
            for _,track in ipairs(hum:GetPlayingAnimationTracks()) do
                pcall(function()
                    track:Stop(0)
                end)
            end

            -- RESET STATES
            local badStates={
                "Stunned","IsStunned",
                "Healing","IsHealing",
                "Repairing","IsRepairing",
                "Interacting","Attacking",
                "Using","Busy","Action"
            }

            for _,v in ipairs(badStates) do
                if char:GetAttribute(v)~=nil then
                    char:SetAttribute(v,false)
                end

                local obj=char:FindFirstChild(v)

                if obj and obj:IsA("ValueBase") then
                    pcall(function()
                        if typeof(obj.Value)=="boolean" then
                            obj.Value=false
                        elseif typeof(obj.Value)=="number" then
                            obj.Value=0
                        end
                    end)
                end
            end

            -- FORCE LEAVE GENERATOR
            local map=workspace:FindFirstChild("Map")

            if map then
                local genFolder=
                    map:FindFirstChild("new Generators")
                    or map:FindFirstChild("Generators")

                if genFolder then
                    local nearestGen,nearestDist

                    for _,gen in ipairs(genFolder:GetChildren()) do
                        local part=gen:FindFirstChildWhichIsA("BasePart",true)

                        if part then
                            local dist=(root.Position-part.Position).Magnitude

                            if not nearestDist or dist<nearestDist then
                                nearestDist=dist
                                nearestGen=part
                            end
                        end
                    end

                    if nearestGen and nearestDist<=15 then
                        local dir=(root.Position-nearestGen.Position).Unit

                        if dir.Magnitude<=0 then
                            dir=root.CFrame.LookVector
                        end

                        local escapePos=root.Position+(dir*20)

                        root.CFrame=CFrame.new(
                            escapePos,
                            escapePos+root.CFrame.LookVector
                        )
                    end
                end
            end

            -- FORCE STATES
            task.wait()

            hum:ChangeState(Enum.HumanoidStateType.Running)
            hum.Jump=true

            -- CAMERA FIX
            if cam and cam.CameraType~=Enum.CameraType.Custom then
                cam.CameraType=Enum.CameraType.Custom
                cam.CameraSubject=hum
            end
        end

        WindUI:Notify({
            Title="Anti-Stuck Triggered",
            Content="Character released from generator/stuck state!",
            Icon="lucide:unlock"
        })
    end)
end
-- =========================================================
-- [VD OPTIMIZED] MASS GENERATOR BOOST
-- =========================================================

local function TriggerBoostAllGen()

    if getgenv().IsBoostingGen then
        return
    end

    getgenv().IsBoostingGen = true

    local RS =
        cloneref and cloneref(game:GetService("ReplicatedStorage"))
        or game:GetService("ReplicatedStorage")

    local remotes = RS:FindFirstChild("Remotes")

    if not remotes then
        getgenv().IsBoostingGen = false
        return
    end

    -- =====================================================
    -- CACHE REMOTES
    -- =====================================================

    getgenv().BoostCache =
        getgenv().BoostCache or {}

    local cache =
        getgenv().BoostCache

    if not cache.SkillCheck then

        for _, obj in ipairs(remotes:GetDescendants()) do

            if obj:IsA("RemoteEvent") then

                local n =
                    obj.Name:lower()

                if n:find("skillcheck") then
                    cache.SkillCheck = obj

                elseif n:find("groupproject")
                or n:find("genproject")
                or n:find("generatorboost") then

                    cache.Project = obj
                end
            end
        end
    end

    local skillRemote =
        cache.SkillCheck

    local projectRemote =
        cache.Project

    if not skillRemote then

        WindUI:Notify({
            Title = "Generator Error",
            Content = "SkillCheck remote tidak ditemukan.",
            Icon = "lucide:alert-circle"
        })

        getgenv().IsBoostingGen = false
        return
    end

    -- =====================================================
    -- VALIDATE GENERATORS
    -- =====================================================

    local gens =
        CachedMapObjects
        and CachedMapObjects.Generators

    if not gens then
        getgenv().IsBoostingGen = false
        return
    end

    local boosted = 0
    local alreadyDone = {}

    -- =====================================================
    -- SMART BOOST LOOP
    -- =====================================================

    for _, gen in ipairs(gens) do

        if gen
        and gen.Parent
        and gen:IsA("Model")
        and not alreadyDone[gen] then

            local progress =
                tonumber(
                    GetGameValue(gen, "RepairProgress")
                    or GetGameValue(gen, "Progress")
                    or 0
                ) or 0

            -- hanya mesin valid
            if progress > 0
            and progress < 100 then

                alreadyDone[gen] = true

                local points = {}

                for _, child in ipairs(gen:GetDescendants()) do

                    if child:IsA("BasePart")
                    and child.Name:lower():find("point") then

                        t_insert(points, child)
                    end
                end

                if #points > 0 then

                    boosted += 1

                    -- =================================================
                    -- SAFE FIRE LOOP
                    -- =================================================

                    for burst = 1, 12 do

                        for _, point in ipairs(points) do

                            if not point.Parent then
                                continue
                            end

                            pcall(function()

                                -- support semua executor
                                if projectRemote then
                                    projectRemote:FireServer(
                                        gen,
                                        point
                                    )
                                end

                                -- SUCCESS = 1
                                skillRemote:FireServer(
                                    "success",
                                    1,
                                    gen,
                                    point
                                )

                            end)
                        end

                        -- adaptive delay mobile
                        task.wait(0.045)
                    end
                end
            end
        end
    end

    -- =====================================================
    -- NOTIFICATION
    -- =====================================================

    if boosted > 0 then

        WindUI:Notify({
            Title = "Generator Boost",
            Content =
                "Berhasil boost "
                .. boosted
                .. " generator.",
            Icon = "lucide:bolt"
        })

    else

        WindUI:Notify({
            Title = "No Targets",
            Content = "Tidak ada generator valid.",
            Icon = "lucide:info"
        })
    end

    task.delay(2, function()
        getgenv().IsBoostingGen = false
    end)
end

WindUI:AddTheme({
    Name = "FORKT",

    Accent = Color3.fromHex("#181422"),

    Background = WindUI:Gradient({
        ["0"]   = { Color = Color3.fromHex("#0A0A0F"), Transparency = 0 },
        ["50"]  = { Color = Color3.fromHex("#120F1A"), Transparency = 0 },
        ["100"] = { Color = Color3.fromHex("#1A1624"), Transparency = 0 },
    }, { Rotation = 75 }),

    BackgroundTransparency = 0,
    Outline = Color3.fromHex("#3A3450"),

    Text = Color3.fromHex("#F5F7FF"),
    Placeholder = Color3.fromHex("#9AA0AE"),

    Button = Color3.fromHex("#221C30"),
    Icon = Color3.fromHex("#B0B0C0"),
    Hover = Color3.fromHex("#C4B5FD"),

    WindowBackground = Color3.fromHex("#0E0B14"),
    WindowShadow = Color3.fromHex("#000000"),

    DialogBackground = Color3.fromHex("#171322"),
    DialogBackgroundTransparency = 0,
    DialogTitle = Color3.fromHex("#F5F3FF"),
    DialogContent = Color3.fromHex("#C9CDD6"),
    DialogIcon = Color3.fromHex("#A78BFA"),

    WindowTopbarButtonIcon = Color3.fromHex("#C4B5FD"),
    WindowTopbarTitle = Color3.fromHex("#F5F3FF"),
    WindowTopbarAuthor = Color3.fromHex("#8E94A7"),
    WindowTopbarIcon = Color3.fromHex("#8B5CF6"),

    TabBackground = Color3.fromHex("#14101D"),
    TabTitle = Color3.fromHex("#ECECF3"),
    TabIcon = Color3.fromHex("#9CA3AF"),

    ElementBackground = Color3.fromHex("#1E192A"),
    ElementTitle = Color3.fromHex("#F5F3FF"),
    ElementDesc = Color3.fromHex("#A6ACB8"),
    ElementIcon = Color3.fromHex("#A78BFA"),

    PopupBackground = Color3.fromHex("#171320"),
    PopupBackgroundTransparency = 0,
    PopupTitle = Color3.fromHex("#F5F3FF"),
    PopupContent = Color3.fromHex("#D1D5DB"),
    PopupIcon = Color3.fromHex("#8B5CF6"),

    Toggle = Color3.fromHex("#4F46E5"),
    ToggleBar = Color3.fromHex("#E9D5FF"),

    Checkbox = Color3.fromHex("#4F46E5"),
    CheckboxIcon = Color3.fromHex("#FFFFFF"),

    Slider = Color3.fromHex("#4F46E5"),
    SliderThumb = Color3.fromHex("#FFFFFF"),
})
-- 1. Definisikan fungsi gradient terlebih dahulu agar bisa dipakai di Popup
local function gradient(text,startColor,endColor,timeOffset)
    if type(text) ~= "string" or text == "" then
        return ""
    end

    local chars,result = {},{}
    for _,c in utf8.codes(text) do
        chars[#chars+1] = utf8.char(c)
    end

    local len = #chars
    local div = math.max(len-1,1)
    timeOffset = tonumber(timeOffset) or 0

    for i = 1,len do
        local t = math.abs((((i-1)/div)+timeOffset)%2-1)
        local color = startColor:Lerp(endColor,t)

        result[i] = string.format(
            '<font color="#%s">%s</font>',
            color:ToHex(),
            chars[i]
        )
    end

    return table.concat(result)
end

-- =========================================================
-- 2. TAMPILKAN POPUP TERLEBIH DAHULU
-- =========================================================
local popupClosed = false

WindUI:Popup({
    Title = gradient(
        "FORKT-HUB",
        Color3.fromHex("#A78BFA"), -- muted purple
        Color3.fromHex("#60A5FA")  -- soft blue
    ),

    Icon = "lucide:sparkles",

    Content = table.concat({
        "System initialized successfully.",
        "",
        "Welcome to the premium Violence District experience.",
        "",
        "🖥️ PC  • Press [K] to toggle the UI",
        "📱 Mobile • Use the floating button"
    }, "\n"),

    Buttons = {
        {
            Title = "Open Menu",
            Icon = "lucide:rocket",
            Variant = "Primary",

            Callback = function()
                popupClosed = true
            end
        }
    }
})

-- Tahan jalannya script di sini sampai tombol "ENTER SYSTEM" diklik
repeat task.wait() until popupClosed
-- =========================================================
-- 3. BARU RENDER WINDOW UTAMA SETELAH POPUP DITUTUP
-- =========================================================
local TabProfile 
local Window = WindUI:CreateWindow({
    Title = "<b>" .. gradient("FORKT-HUB", Color3.fromHex("#D1D1D1"), Color3.fromHex("#8E9196")) .. "</b>", 
    Author = gradient("Violence District", Color3.fromHex("#E0E0E0"), Color3.fromHex("#A1A1A1")),

    Icon = "rbxassetid://106965358654204", 
    Theme = "FORKT", 
    
    Size = UDim2.fromOffset(620, 420), 
    Resizable = true,
    
    MinSize = v2(450, 300),
    MaxSize = v2(600, 500),
    
    NewElements = true,
    ElementsRadius = 12,
    Transparent = false,
    IgnoreAlerts = true,
    HideSearchBar = false,
    Background = "https://www.image2url.com/r2/default/images/1777515589556-3a362ac2-b45e-4d0e-bea2-13e4c2ac0a33.png",
    BackgroundImageTransparency = 0.85,
    SideBarWidth = 175, 
    TopBarButtonIconSize = 18,
    Folder = "ForktHub",
    ToggleKey = Enum.KeyCode.K,
    OpenButton = {
        Title = gradient("FORKT-HUB", Color3.fromHex("#ECF0F1"), Color3.fromHex("#95A5A6")),
        Icon = "rbxassetid://106965358654204",
        CornerRadius = UDim.new(1, 0), 
        StrokeThickness = 2.2,
        Draggable = true,
        Enabled = true,
        OnlyMobile = false,
        Scale = 0.85,
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0.00, Color3.fromHex("#ECF0F1")), -- Soft White
            ColorSequenceKeypoint.new(0.50, Color3.fromHex("#95A5A6")), -- Slate Gray
            ColorSequenceKeypoint.new(1.00, Color3.fromHex("#2C3E50"))  -- Dark Slate Blue
        })
    },

    Topbar = { Height = 45, ButtonsType = "Default" },
    KeySystem = {
        Title = "KEY SYSTEM",
        Note = "FORKT-HUB | Violence District",
        URL = "https://discord.gg/wCVUTHgsQV",
        SaveKey = true,
    
        KeyValidator = function(key)
            local success, result = pcall(function()
                return Junkie.check_key(key)
            end)
    
            if success and result and result.valid then
                local isVIP = false
                local upperKey = string.upper(key)
    
                -- VIP DETECTION
                if (result.tier and (result.tier == "Premium" or result.tier == "VIP"))
                or (result.level and result.level >= 2) then
                    isVIP = true
    
                elseif upperKey:find("VIP")
                or upperKey:find("PREMIUM")
                or upperKey:find("PAID") then
                    isVIP = true
                end
    
                getgenv().FORKT_PREMIUM = isVIP
                getgenv().SCRIPT_KEY = key
    
                return true
            end
    
            return false
        end
    }
})
print("FORKT-HUB berhasil dimuat")
--Window:SetToggleKey(Enum.KeyCode.K)
----------------------------------------------------------------
-- INTERACTIVE TAGS & TOPBAR BUTTONS
----------------------------------------------------------------
Window:Tag({ 
    Title = "<b>" .. gradient("@sukitovone", Color3.fromHex("#ECF0F1"), Color3.fromHex("#95A5A6")) .. "</b>", 
    Icon = "rbxassetid://101132151462030", 
    Border = true, 
    Color = Color3.fromHex("#161E27") 
})
Window:Divider()
----------------------------------------------------------------
-- TABS SETUP (SECTIONED & ORGANIZED)
----------------------------------------------------------------
TabProfile  = Window:Tab({ Title = "Profile & Info", ShowTabTitle = true, Icon = "lucide:user" })
local kito        = Window:Tab({ Title = "VIP", ShowTabTitle = true, Icon = "rbxassetid://14849573900" })
Window:Divider()
local Tab4        = Window:Tab({ Title = "Automation", Icon = "lucide:bot" })
local Tab1        = Window:Tab({ Title = "Survivor", Icon = "lucide:shield" })
local TabKiller   = Window:Tab({ Title = "Killer", Icon = "lucide:sword" }) 
local Tab3        = Window:Tab({ Title = "Combat", Icon = "lucide:crosshair" })
local Tab2        = Window:Tab({ Title = "Visuals", Icon = "lucide:eye" })
local Spoof        = Window:Tab({ Title = "Spoofing", Icon = "lucide:ghost" })
local TabSettings = Window:Tab({ Title = "Settings", Icon = "lucide:settings" })
----------------------------------------------------------------
-- TAB: PROFILE (USER & DEVICE INFO)
----------------------------------------------------------------
TabProfile:Select()

-- SYSTEM DATA
local activeKey = getgenv().SCRIPT_KEY or "Free User"
local isPremium = getgenv().FORKT_PREMIUM or false

local tierText = isPremium and "PREMIUM" or "FREE"
local statusColor = isPremium
    and "#22C55E" -- green premium
    or "#F59E0B"  -- orange free
    
local executorName =
    (identifyexecutor and identifyexecutor())
    or (getexecutorname and getexecutorname())
    or "Unknown"

local deviceType =
    (UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled)
    and "Mobile"
    or "PC"

-- AVATAR
local realAvatar = string.format(
    "https://www.roblox.com/headshot-thumbnail/image?userId=%d&width=420&height=420&format=png",
    LocalPlayer.UserId
)

-- ==========================================
-- SECTION HEADER
-- ==========================================

TabProfile:Section({
    Title = "Profile & Dashboard",
    Icon = "lucide:user-round"
})

-- ==========================================
-- USER PROFILE CARD
-- ==========================================

local ProfileGroup = TabProfile:Group()

ProfileGroup:Paragraph({
    Title = string.format(
        "<font color='#F8FAFC'><b>%s</b></font> <font color='#94A3B8'>@%s</font>",
        LocalPlayer.DisplayName,
        LocalPlayer.Name
    ),

    Desc = string.format(
        "<font color='#CBD5E1'><b>User ID</b></font> • %d\n" ..
        "<font color='#CBD5E1'><b>Account Age</b></font> • %d Days",
        LocalPlayer.UserId,
        LocalPlayer.AccountAge
    ),

    Image = realAvatar,
    ImageSize = 55
})

TabProfile:Space({ Columns = 1 })

local SystemGroup = TabProfile:Group()

SystemGroup:Paragraph({
    Title = gradient(
        "FORKT-HUB",
        Color3.fromHex("#7C3AED"),
        Color3.fromHex("#4F46E5")
    ),

    Desc = string.format(
        "🔑 <font color='#D1D5DB'><b>Key</b></font> • <font color='#FACC15'>%s</font>\n" ..
        "💎 <font color='#D1D5DB'><b>License</b></font> • <font color='%s'><b>%s</b></font>\n" ..
        "🖥️ <font color='#D1D5DB'><b>Platform</b></font> • <font color='#93C5FD'>%s</font>\n" ..
        "⚡ <font color='#D1D5DB'><b>Executor</b></font> • <font color='#60A5FA'>%s</font>",
        activeKey,
        statusColor,
        tierText,
        deviceType,
        executorName
    )
})
TabProfile:Space({ Columns = 1 }) 

TabProfile:Section({ Title = "Credits & Information" })

TabProfile:Paragraph({
    Title = "Developer: @sukitovone | @forkt",
    Desc = "Dapatkan update script terbaru, beri saran, atau laporkan bug langsung ke developer!",
    Image = "rbxassetid://18505728201",
    Buttons = {
        {
            Title = "Copy Discord Link", 
            Icon = "sfsymbols:link",
            Callback = function()
                -- [FIX MOBILE 3] Tambahkan Fallback Notification jika executor tidak bisa setclipboard
                local success, err = pcall(function() setclipboard("https://discord.gg/wCVUTHgsQV") end)
                if success then 
                    WindUI:Notify({ 
                        Title = "Success!", 
                        Content = "Link Discord berhasil disalin ke Clipboard!", 
                        Icon = "sfsymbols:checkmarkCircle" 
                    }) 
                else
                    WindUI:Notify({ 
                        Title = "Gagal Menyalin", 
                        Content = "Executor kamu tidak mendukung fitur Copy Clipboard.", 
                        Icon = "sfsymbols:xmarkCircleFill" 
                    }) 
                end
            end
        }
    }
})

-----------------------------------------------------------
-- [TAB VIP] ULTIMATE AUTOMATION
-----------------------------------------------------------
local AISection = kito:Section({
    Title = gradient("Automatic System",Color3.fromHex("#F59E0B"),Color3.fromHex("#EF4444")),
    Box = true,
    TextXAlignment = "Left",
    TextSize = 18,
    Icon = "lucide:bot"
})

AISection:Toggle({
    Title = "Auto Play (Smart AI)",
    Desc = "AI otomatis mencari Generator, Gate & menghindari Killer.",
    Flag = "F_AutoFarm",
    Value = false,
   -- Locked = not getgenv().FORKT_PREMIUM,
    Locked = true,
    LockedTitle = "Maintenance",
    Callback = function(v)
        if v and not getgenv().FORKT_PREMIUM then
            AutoFarmBot = false
            return
        end

        AutoFarmBot = v

        if v then
            AutoGenerator = true
            AutoGeneratorMode = "Perfect"

            WindUI:Notify({
                Title = "AI Enabled",
                Content = "Smart survivor bot berhasil diaktifkan.",
                Icon = "lucide:bot"
            })
        else
            local char = LocalPlayer.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            local root = char and char:FindFirstChild("HumanoidRootPart")

            if hum and root then
                hum:MoveTo(root.Position)
            end

            WindUI:Notify({
                Title = "AI Disabled",
                Content = "Smart AI berhasil dimatikan.",
                Icon = "lucide:circle-off"
            })
        end
    end
})

AISection:Toggle({
    Title = "Moonwalk",
    Desc = "Movement zigzag otomatis untuk dodge Killer.",
    Flag = "F_Moonwalk",
    Value = false,
    Locked = not getgenv().FORKT_PREMIUM,
    Callback = function(v)
        getgenv().MoonwalkEnabled = v

        if MoonwalkUI then
            MoonwalkUI.Enabled = v
        end

        if not v and cachedHum then
            cachedHum.AutoRotate = true
        end

        WindUI:Notify({
            Title = v and "Moonwalk Enabled" or "Moonwalk Disabled",
            Content = v and "Tekan tombol/R untuk mulai zigzag." or "Moonwalk dimatikan.",
            Icon = v and "lucide:orbit" or "lucide:circle-off"
        })
    end
})

AISection:Slider({
    Title = "MoonWalk Intensity",
    Desc = "Semakin tinggi semakin agresif zigzag.",
    Step = 1,
    Flag = "F_ZigzagIntense",
    Locked = not getgenv().FORKT_PREMIUM,
    Value = {Min = 5, Max = 50, Default = 11},
    Callback = function(v)
        getgenv().MoonwalkZigzagSpeed = type(v) == "table" and v.Value or v
    end
})

AISection:Slider({
    Title = "Speed Boost MoonWalk",
    Desc = "Multiplier movement saat Moonwalk aktif.",
    Step = 0.01,
    Flag = "F_MoveBoost",
    Locked = not getgenv().FORKT_PREMIUM,
    Value = {Min = 1, Max = 1.5, Default = 1.08},
    Callback = function(v)
        getgenv().MoonwalkBoostPower = type(v) == "table" and v.Value or v
    end
})

-----------------------------------------------------------
-- SURVIVOR DEFENSE
-----------------------------------------------------------
local DefenseSection = kito:Section({
    Title = gradient("Survivor Defense",Color3.fromHex("#F59E0B"),Color3.fromHex("#EF4444")),
    Box = true,
    TextXAlignment = "Left",
    TextSize = 18,
    Icon = "lucide:shield"
})

DefenseSection:Toggle({
    Title="Auto Dagger",
    Desc="Auto parry saat Killer mendekat.",
    Flag="F_AutoParry",
    Value=AutoParry,
    Locked=not getgenv().FORKT_PREMIUM,

    Callback=function(v)

        if v
        and not getgenv().FORKT_PREMIUM then
            return
        end

        AutoParry=v

        pcall(function()

            WindUI:Notify({
                Title="Auto Dagger",
                Content=v
                    and "Enabled"
                    or "Disabled",
                Icon="lucide:shield"
            })
        end)
    end
})

----------------------------------------------------------------
-- MATCHUP
----------------------------------------------------------------

DefenseSection:Dropdown({
    Title = "Killer Matchup",
    Desc = "Optimasi timing Auto Dagger.",
    Flag = "F_ParryMatchup",
    Locked = not getgenv().FORKT_PREMIUM,

    Values = {
        "Auto",
        "Abysswalker",
        "Hidden",
        "Killer",
        "Masked",
        "Stalker",
        "Veil",
        "Slasher",
        "Cure"
    },

    Value = "Auto",

    Callback = function(v)
        getgenv().ParryMatchup = v
    end
})

----------------------------------------------------------------
-- DISTANCE
----------------------------------------------------------------

DefenseSection:Slider({
    Title="Parry Distance",
    Desc="Jarak deteksi Auto Dagger.",
    Step=1,
    Flag="F_ParryDist",

    Value={
        Min=3,
        Max=25,
        Default=ParryDistance
    },

    Locked=not getgenv().FORKT_PREMIUM,

    Callback = function(v)
        local val =
            type(v) == "table"
            and v.Value
            or v
    
        val = tonumber(val) or 10
    
        ParryDistance =
            math.clamp(val,3,20)
    
        ------------------------------------------------
        -- UPDATE RING
        ------------------------------------------------
    
        local ring =
            TargetGui:FindFirstChild(
                "FORKT_ParryRing"
            )
    
        if ring then
            ring.Radius = ParryDistance
        end
    end
})

----------------------------------------------------------------
-- AIM STRICTNESS
----------------------------------------------------------------

DefenseSection:Slider({
    Title="Aim Strictness",
    Desc="Akurasi prediksi movement Killer.",
    Step=0.1,
    Flag="F_AimStrict",

    Value={
        Min=0.5,
        Max=3,
        Default=getgenv().AimStrictness
    },

    Locked=not getgenv().FORKT_PREMIUM,

    Callback=function(v)

        if not getgenv().FORKT_PREMIUM then
            return
        end

        local val=
            type(v)=="table"
            and (v.Value or v.Default)
            or v

        val=tonumber(val) or 1.3

        getgenv().AimStrictness=
            math.clamp(val,0.5,3)
    end
})

----------------------------------------------------------------
-- DELAY
----------------------------------------------------------------

DefenseSection:Slider({
    Title="Parry Delay",
    Desc="Custom timing Auto Dagger (ms).",
    Step=10,
    Flag="F_ParryDelay",

    Value={
        Min=-150,
        Max=1000,
        Default=(getgenv().ParryDelayOffset or 0)*1000
    },

    Locked=not getgenv().FORKT_PREMIUM,

    Callback=function(v)

        if not getgenv().FORKT_PREMIUM then
            return
        end

        local val=
            type(v)=="table"
            and (v.Value or v.Default)
            or v

        val=tonumber(val) or 0

        val=math.clamp(val,-150,1000)

        getgenv().ParryDelayOffset=
            val/1000
    end
})

DefenseSection:Toggle({
    Title = "Auto Wiggle",
    Desc = "Otomatis escape saat dibawa Killer.",
    Flag = "F_AutoWiggle",
    Value = false,
    Locked = true,
    LockedTitle = "Maintenance",
    Callback = function(v)
        if v and not getgenv().FORKT_PREMIUM then
            return
        end

        AutoWiggle = v
    end
})

kito:Section({
    Title = gradient("Silent Aim VIP",Color3.fromHex("#F59E0B"),Color3.fromHex("#EF4444")),
    Box = true,
    TextSize = 19
})

kito:Toggle({
    Title="Silent Aim Pistol",
    Desc="Peluru otomatis lock ke Killer terdekat.",
    Flag="F_SilentAimPistol",
    Locked=not getgenv().FORKT_PREMIUM,
    Value=false,

    Callback=function(v)

        SilentAimPistol=v

        WindUI:Notify({
            Title=v
                and "Silent Aim Enabled"
                or "Silent Aim Disabled",

            Content=v
                and "Auto lock aktif."
                or "Silent Aim dimatikan.",

            Icon=v
                and "lucide:crosshair"
                or "lucide:circle-off"
        })
    end
})

----------------------------------------------------------------
-- TAB 1: SURVIVOR (MOVEMENT & HEALTH)
----------------------------------------------------------------
Tab1:Section({ Title = "Health & Protection" })

local HealthGroup = Tab1:Group()
HealthGroup:Toggle({ Title = "Instant Heal", Flag = "F_InstantHeal", Value = false, Callback = function(v) InstantHeal = v end })
HealthGroup:Toggle({ Title = "Anti Knock", Flag = "F_AntiKnock", Value = false, Callback = function(v) AntiKnock = v end })

Tab1:Space({ Columns = 1 })
Tab1:Section({ Title = "Movement Modification" })
local MoveGroup = Tab1:Group()
MoveGroup:Toggle({ Title = "No Slowdown", Flag = "F_NoSlowdown", Value = false, Callback = function(v) NoSlowdown = v end })

MoveGroup:Toggle({ 
    Title = "Speed Boost", 
    Flag = "F_SpeedBoost", 
    Locked = false, 
    Value = false, 
    Callback = function(v) 
        SpeedBoost = v 
    end 
})

Tab1:Slider({
    Title = "Speed Boost Power",
    Desc = "Persentase tambahan speed.",
    Step = 1,
    IsTooltip = true,
    Locked = false,
    LockedTitle = "Maintenance",
    Flag = "F_BoostSpeed",
    Value = {
        Min = 0,
        Max = 150,
        Default = 8
    },
    Callback = function(v)
        BoostSpeed = tonumber(
            type(v) == "table" and (v.Value or v.Default) or v
        ) or 0
    end
})

Tab1:Space({ Columns = 1 })

Tab1:Section({ Title = "Stealth" })

Tab1:Toggle({ 
    Title = "Silent Actions (Anti-Noise)", 
    Desc = "Memblokir notifikasike Killer saat kamu lari atau melompat jendela.", 
    Flag = "F_SilentActions", 
    Value = false, 
    Callback = function(v) SilentActions = v end 
})

Tab1:Toggle({ 
    Title = "Anti Fall Slow", 
    Desc = "Mencegah animasi saat jatuh dari tempat tinggi.", 
    Flag = "F_AntiFall", 
    Value = false, 
    Callback = function(v) AntiFallDamage = v end 
})

Tab1:Toggle({ 
    Title = "Anti Aura (No Detect)", 
    Desc = "Memblokir sinyal pelacak! Killer tidak akan bisa melihat Auramu", 
    Flag = "F_AntiAura", 
    Value = false, 
    Callback = function(v) getgenv().AntiAura = v end 
})

Tab1:Toggle({ 
    Title = "Notify Killer Stun", 
    Desc = "Memunculkan notifikasi global jika Killer terkena Stun (Pallet/Dagger).", 
    Flag = "F_NotifyStun", 
    Value = false, 
    Callback = function(v) NotifyStun = v end 
})
Tab1:Button({
    Title = "Force Reset State (Anti-Stuck)",
    Desc = "Membongkar paksa jangkar fisik, animasi, kamera, dan status kaku dari server.",
    Icon = "lucide:refresh-cw",
    Callback = function()
        TriggerAntiStuck()
    end
})

-- 2. Custom Keybind (Khusus PC)
Tab1:Keybind({
    Title = "Anti-Stuck Hotkey (PC Only)",
    Desc = "Pilih tombol keyboard untuk memicu Anti-Stuck secara instan tanpa perlu membuka UI.",
    Icon = "lucide:keyboard",
    Default = "L", -- Tombol bawaan, user bebas mengubahnya nanti di dalam game
    Callback = function()
        TriggerAntiStuck()
    end
})
-- Membuka 2 Kolom untuk Heal dan Anti Knock
Tab1:Space({ Columns = 2 }) 
----------------------------------------------------------------
-- TAB: KILLER (KHUSUS KILLER)
----------------------------------------------------------------
TabKiller:Section({ Title = "Vein Killer Modification" })

TabKiller:Toggle({ Title = "Vein Spear: Drop Prediction", Flag = "F_SpearPrediction", Locked = true,
    LockedTitle = "Maintenance", Value = false, Callback = function(v) SpearPrediction = v end })

TabKiller:Toggle({
    Title = "Veil Spear : No Gravity",
    Desc = "Menghilangkan drop/gravitasi spear Veil.",
    Flag = "F_AntiGravSpear",
    Value = false,
    Callback = function(v)
        AntiGravitySpear=v
    end
})

TabKiller:Space({ Columns = 1 }) 
TabKiller:Section({ Title = "Killer Advantages" })
local KillerAnti = TabKiller:Group()
KillerAnti:Toggle({
    Title = "Anti-Blind",
    Flag = "F_AntiBlind",
    Value = false,

    Callback = function(v)

        AntiBlind = v

        if v then

            for _, effect in ipairs(
                Lighting:GetChildren()
            ) do

                if effect:IsA("BlurEffect")
                or effect:IsA("ColorCorrectionEffect")
                or effect:IsA("Atmosphere")
                or effect:IsA("BloomEffect")
                or effect:IsA("SunRaysEffect")
                or effect:IsA("DepthOfFieldEffect") then

                    pcall(function()
                        effect:Destroy()
                    end)
                end
            end
        end
    end
})

KillerAnti:Toggle({ Title = "Anti-Stun", Flag = "F_AntiStun", Value = false, Callback = function(v) AntiStun = v end })
TabKiller:Toggle({ Title = "Double Damage Generator", Desc = "Deals double damage when kicking a Generator.", Flag = "F_DoubleDamage", Value = false, Callback = function(v) DoubleDamageGen = v end })

TabKiller:Button({ Title = "Activate Killer Power", Desc = "Instantly triggers the Killer's special power.", Icon = "sfsymbols:starFill", Callback = function()
    pcall(function() ReplicatedStorage.Remotes.Killers.Killer.ActivatePower:FireServer() end)
end })

-----------------------------------------------------------------
-- TAB 2: VISUALS (ESP, FOV, & WORLD)
----------------------------------------------------------------
Tab2:Section({ Title = "Player & Entity Visuals" })

local PlayerGroup1 = Tab2:Group()
PlayerGroup1:Toggle({ Title = "ESP Survivor (Name)", Flag = "F_ESPSurvivorName", Value = false, Callback = function(v) ESP_Survivor_Name = v; RefreshESP() end })
PlayerGroup1:Space()
PlayerGroup1:Toggle({ Title = "ESP Survivor (Highlight)", Flag = "F_ESPSurvivorHighlight", Value = false, Callback = function(v) ESP_Survivor_Highlight = v; RefreshESP() end })

local PlayerGroup2 = Tab2:Group()
PlayerGroup2:Toggle({ Title = "ESP Killer (Name)", Flag = "F_ESPKillerName", Value = false, Callback = function(v) ESP_Killer_Name = v; RefreshESP() end })
PlayerGroup2:Space()
PlayerGroup2:Toggle({ Title = "ESP Killer (Highlight)", Flag = "F_ESPKillerHighlight", Value = false, Callback = function(v) ESP_Killer_Highlight = v; RefreshESP() end })
Tab2:Toggle({
    Title="ESP SCP/Zombie",
    Desc="Menampilkan SCP & Zombie",
    Flag="F_ESP_SCP",
    Value=false,
    Callback=function(v)
        ESP_SCP=v
    end
})
-- Kembalikan ke 1 Kolom
Tab2:Space({ Columns = 1 }) 


Tab2:Section({ Title = "Object Visuals" })


local ObjectGroup1 = Tab2:Group()
ObjectGroup1:Toggle({ Title = "ESP Generator", Desc = "Displays unfinished Gens.", Flag = "F_ESPGen", Value = false, Callback = function(v) ESP_Generator = v; RefreshESP() end })
ObjectGroup1:Space()
ObjectGroup1:Toggle({ Title = "ESP Pallet", Desc = "Displays Pallets.", Flag = "F_ESPPallet", Value = false, Callback = function(v) ESP_Pallet = v; RefreshESP() end })

local ObjectGroup2 = Tab2:Group()
ObjectGroup2:Toggle({ Title = "ESP Exit Gate", Desc = "Displays Exit Gates.", Flag = "F_ESPGate", Value = false, Callback = function(v) ESP_Gate = v; RefreshESP() end })
ObjectGroup2:Space()
ObjectGroup2:Toggle({ Title = "ESP Hook", Desc = "Displays Hook locations.", Flag = "F_ESPHook", Value = false, Callback = function(v) ESP_Hook = v; RefreshESP() end })

-- Kembalikan ke 1 Kolom
Tab2:Space({ Columns = 1 }) 
-----------------------------------------------------------
-- CAMERA & VIEWPORT
-----------------------------------------------------------
local CameraSection = Tab2:Section({
    Title = gradient("Camera Viewport",Color3.fromHex("#6366F1"),Color3.fromHex("#06B6D4")),
    Box = true,
    TextXAlignment = "Left",
    TextSize = 18,
    Icon = "lucide:camera"
})

CameraSection:Toggle({
    Title = "Custom FOV",
    Desc = "Mengatur jarak pandang kamera.",
    Flag = "F_CustomFOV",
    Value = false,
    Callback = function(v)
        CustomCameraFOV = v
    end
})

CameraSection:Slider({
    Title = "Field Of View",
    Desc = "Semakin tinggi semakin luas pandangan.",
    Step = 1,
    IsTooltip = true,
    Flag = "F_FOVValue",
    Value = {Min = 70, Max = 120, Default = 100},
    Callback = function(v)
        CameraFOVValue = type(v) == "table" and (tonumber(v.Value) or 100) or tonumber(v) or 100
    end
})

CameraSection:Toggle({
    Title = "Crosshair",
    Desc = "Menampilkan titik aim di tengah layar.",
    Flag = "F_Crosshair",
    Value = false,
    Callback = function(v)
        local gui = getgenv().CrosshairGui
        if gui then
            gui.Enabled = v
        end
    end
})

CameraSection:Slider({
    Title = "Crosshair Size",
    Desc = "Mengatur ukuran crosshair.",
    Step = 1,
    IsTooltip = true,
    Flag = "F_CrosshairSize",
    Value = {Min = 2, Max = 25, Default = 6},
    Callback = function(v)
        local size = type(v) == "table" and (tonumber(v.Value) or 6) or tonumber(v) or 6
        local gui = getgenv().CrosshairGui

        if gui then
            local dot = gui:FindFirstChild("DotMarker")
            if dot then
                dot.Size = UDim2.new(0,size,0,size)
            end
        end
    end
})

CameraSection:Toggle({
    Title = "FPP / TPP Mode",
    Desc = "Switch antara First Person & Third Person.",
    Flag = "F_CameraToggle",
    Value = false,
    Callback = function(v)
        local isMobile =
            UserInputService.TouchEnabled
            and not UserInputService.KeyboardEnabled

        if isMobile then
            if MobileRotateBtn then
                MobileRotateBtn.Visible = v

                if not v then
                    isFPP = false
                    SwitchCameraMode(false)

                    MobileRotateBtn.BackgroundColor3 =
                        Color3.fromRGB(75,150,255)

                    MobileRotateBtn.Text = "TPP"
                end
            end
        else
            isFPP = v
            SwitchCameraMode(v)
        end
    end
})
-- Kembalikan ke 1 Kolom
Tab2:Space({ Columns = 2 }) 

Tab2:Section({ Title = "World Optimization", Box = true })
Tab2:Toggle({ 
    Title = "Remove All Visual Effects", 
    Desc = "Menyapu bersih semua efek Blur, Bloom, DoF, SunRays, dan Kabut.", 
    Flag = "F_RemoveDoF", 
    Value = false, 
    Callback = function(v) 
        if v then
            -- [1] NYALAKAN: Simpan dan Sembunyikan Efek
            getgenv().FORKT_HiddenEffects = getgenv().FORKT_HiddenEffects or {}
            table.clear(getgenv().FORKT_HiddenEffects) -- Pastikan cache bersih
            
            local function hideEffects(parent)
                for _, effect in ipairs(parent:GetDescendants()) do
                    local n = string.lower(effect.Name)
                    
                    if effect:IsA("PostEffect") or effect:IsA("Clouds") or effect:IsA("Atmosphere") or n:find("bloom") or n:find("dof") or n:find("sunray") or n:find("blur") then
                        
                        if effect:IsA("Atmosphere") then
                            t_insert(getgenv().FORKT_HiddenEffects, {Obj = effect, OldParent = effect.Parent})
                            effect.Parent = nil
                        else
                            -- Khusus Objek Filter (Simpan status aslinya, lalu matikan)
                            pcall(function()
                                if effect.Enabled then
                                    t_insert(getgenv().FORKT_HiddenEffects, {Obj = effect, WasEnabled = true})
                                    effect.Enabled = false
                                end
                            end)
                        end
                    end
                end
            end

            -- Eksekusi penyapuan
            hideEffects(Lighting)
            hideEffects(workspace.CurrentCamera)
            
            -- Hapus Kabut Klasik (Simpan nilai aslinya dulu)
            getgenv().FORKT_OldFogStart = Lighting.FogStart
            getgenv().FORKT_OldFogEnd = Lighting.FogEnd
            Lighting.FogStart = 9e9
            Lighting.FogEnd = 9e9
            
            WindUI:Notify({ 
                Title = "Vision Cleared", 
                Content = "Semua filter layar dan kabut berhasil disembunyikan!", 
                Icon = "lucide:eye-off" 
            })
            
        else
            -- [2] MATIKAN: Kembalikan Semua ke Kondisi Asli
            if getgenv().FORKT_HiddenEffects then
                for _, data in ipairs(getgenv().FORKT_HiddenEffects) do
                    if data.Obj then
                        -- Jika itu Atmosphere, kembalikan ke induknya
                        if data.OldParent then
                            data.Obj.Parent = data.OldParent
                        -- Jika itu PostEffect, nyalakan kembali
                        elseif data.WasEnabled then
                            pcall(function() data.Obj.Enabled = true end)
                        end
                    end
                end
                table.clear(getgenv().FORKT_HiddenEffects)
            end
            
            -- Kembalikan Kabut Klasik
            if getgenv().FORKT_OldFogStart then
                Lighting.FogStart = getgenv().FORKT_OldFogStart
                Lighting.FogEnd = getgenv().FORKT_OldFogEnd
            end
            
            WindUI:Notify({ 
                Title = "Vision Restored", 
                Content = "Efek visual bawaan game dikembalikan.", 
                Icon = "lucide:eye" 
            })
        end
    end 
})

Tab2:Space({ Columns = 1 }) 
local World = Tab2:Group({})

World:Button({ 
    Title = "Force Fullbright", 
    Icon = "lucide:sun", 
    Justify  = "Center", 
    Color = Color3.fromRGB(195, 250, 30),
    Callback = function() 
        -- [FIX] Pencahayaan seimbang
        Lighting.Ambient = Color3.fromRGB(170, 170, 170)
        Lighting.OutdoorAmbient = Color3.fromRGB(170, 170, 170)
        Lighting.ColorShift_Bottom = Color3.new(0, 0, 0)
        Lighting.ColorShift_Top = Color3.new(0, 0, 0)
        Lighting.Brightness = 1.9
        Lighting.ClockTime = 12
        Lighting.GlobalShadows = false 
        
        -- [FIX KABUT KLASIK] Dorong jarak mulai dan akhir kabut hingga tak terhingga
        Lighting.FogStart = 9e9
        Lighting.FogEnd = 9e9
        
        for _, effect in ipairs(Lighting:GetDescendants()) do 
            if effect:IsA("Atmosphere") or effect:IsA("Sky") then
                pcall(function() effect:Destroy() end)
            elseif effect:IsA("PostEffect") or effect:IsA("Clouds") then 
                pcall(function() effect.Enabled = false end)
            end 
        end
    end 
})

World:Space()

World:Button({ 
    Title = "Potato Mode", 
    Icon = "lucide:cpu", 
    Justify  = "Center",
    Color = Color3.fromRGB(255, 159, 50), 
    Callback = function() 
        WindUI:Notify({ 
            Title = "Potato Mode", 
            Content = "Mengoptimalkan map untuk HP kentang... Jangan tutup game!", 
            Icon = "lucide:hourglass" 
        })

        task.spawn(function()
            -- 1. OPTIMASI LANGIT & CAHAYA
            Lighting.GlobalShadows = false
            Lighting.ShadowSoftness = 0
            Lighting.FogEnd = 9e9
            Lighting.EnvironmentDiffuseScale = 0
            Lighting.EnvironmentSpecularScale = 0
            
            for _, effect in ipairs(Lighting:GetDescendants()) do 
                if effect:IsA("PostEffect") or effect:IsA("Atmosphere") or effect:IsA("Clouds") then 
                    pcall(function() effect.Enabled = false end)
                end 
            end

            -- 2. OPTIMASI TERRAIN (AIR & RUMPUT)
            local terrain = workspace.Terrain
            if terrain then
                pcall(function()
                    terrain.WaterWaveSize = 0
                    terrain.WaterWaveSpeed = 0
                    terrain.WaterReflectance = 0
                    terrain.WaterTransparency = 0
                    terrain.Decoration = false
                end)
            end

            -- 3. CHUNKING EKSEKUSI OBJEK MAP (LEBIH AMAN UNTUK MOBILE)
            local descendants = workspace:GetDescendants()
            local total = #descendants
            
            for i = 1, total do
                local v = descendants[i]
                
                -- Hanya eksekusi jika objek adalah jenis yang mempengaruhi grafis (Hemat CPU)
                if v:IsA("BasePart") or v:IsA("Decal") or v:IsA("Texture") or v:IsA("SurfaceAppearance") or v:IsA("PostEffect") or v:IsA("ParticleEmitter") then
                    pcall(function()
                        if v:IsA("BasePart") then 
                            v.Material = Enum.Material.SmoothPlastic
                            v.Reflectance = 0
                            v.CastShadow = false
                        elseif v:IsA("Decal") or v:IsA("Texture") or v:IsA("SurfaceAppearance") then 
                            v:Destroy() 
                        else 
                            v.Enabled = false 
                        end
                    end)
                end
                
                -- Beri napas ke CPU HP setiap 200 objek (Lebih smooth dari 500)
                if i % 200 == 0 then 
                    task.wait(0.03) 
                end
            end
            
            -- Karena loop sekarang dilindungi pcall, notifikasi ini DIJAMIN akan selalu muncul!
            WindUI:Notify({ 
                Title = "Optimization Complete!", 
                Content = "Potato Mode berhasil diterapkan. Tekstur dihapus, FPS Boosted!", 
                Icon = "lucide:check-circle" 
            })
        end)
    end 
})

----------------------------------------------------------------
-- TAB 3: COMBAT (AIMBOT, HITBOX, PARRY)
----------------------------------------------------------------
Tab3:Section({ Title = "Targeting System" })

Tab3:Toggle({ Title = "Enable Aimbot", Desc = "Locks onto the target.", Flag = "F_Aimbot", Value = false, Callback = function(v) Aimbot = v end })

-- [FITUR BARU] Pilihan Target Bagian Tubuh
Tab3:Dropdown({ 
    Title = "Aimbot Target Part", 
    Desc = "Pilih bagian tubuh yang ingin dikunci.",
    Values = {"Head", "Torso", "Body (RootPart)"}, 
    Value = "Torso", 
    Flag = "F_AimPart", 
    Callback = function(v) getgenv().AimbotPart = v end 
})

-- [FITUR BARU] Pilihan Mode Kunci (Solusi layar HP macet)
Tab3:Dropdown({ 
    Title = "Aimbot Trigger Mode", 
    Desc = "Pilih 'Auto Lock' mode.",
    Values = {"Hold to Lock", "Auto Lock (Always)"}, 
    Value = "Hold to Lock", 
    Flag = "F_AimTrigger", 
    Callback = function(v) getgenv().AimbotTrigger = v end 
})

Tab3:Slider({ 
    Title = "Aim Radius", 
    Step = 5, 
    IsTooltip = true, 
    IsTextbox = true, 
    Flag = "F_AimRadius", 
    Value = { Min = 30, Max = 150, Default = 55 }, 
    Callback = function(v) 
        -- [FIX CRASH FATAL (Table * 2)]
        local val = type(v) == "table" and (tonumber(v.Value) or 55) or tonumber(v) or 55
        AimRadius = val
        if FOVCircle then 
            FOVCircle.Size = UDim2.new(0, val*2, 0, val*2) 
        end 
    end 
})
Tab3:Toggle({ Title = "Show Aim Circle", Desc = "Displays aim radius on screen.", Flag = "F_ShowFOV", Value = false, Callback = function(v) 
    ShowFOVCircle = v; if FOVCircle then FOVCircle.Visible = v end 
end })

Tab3:Space({ Columns = 1 }) 

Tab3:Section({ Title = "Auto Attack (Killer Only)" })

Tab3:Toggle({ Title = "Enable Auto Attack", Desc = "Automatically attacks the nearest Survivor.", Flag = "F_AutoAttack", Value = false, Callback = function(v) AutoAttack = v end })
Tab3:Slider({ 
    Title = "Attack Range (Studs)", 
    Step = 1, 
    IsTooltip = true, 
    Flag = "F_AttackRange", 
    Value = { Min = 5, Max = 25, Default = 10 }, 
    Callback = function(v) 
        -- [FIX AMAN]
        AttackRange = type(v) == "table" and (tonumber(v.Value) or 10) or tonumber(v) or 10 
    end 
})
Tab3:Section({ Title = "Killer Hitbox Modification" })

Tab3:Toggle({
    Title="Expand Killer Hitbox",
    Desc="Memperbesar hitbox killer tanpa freeze.",
    Flag="F_HitboxKiller",
    Value=false,
    Callback=function(v)

        HitboxExpander=v

        if not v then

            for _,p in ipairs(Players:GetPlayers()) do

                if p~=LocalPlayer
                and p.Character then

                    local hb=p.Character:FindFirstChild("FORKT_HITBOX")

                    if hb then
                        hb:Destroy()
                    end
                end
            end
        end
    end
})

Tab3:Slider({
    Title="Hitbox Size",
    Step=1,
    IsTooltip=true,
    Flag="F_HitboxSize",
    Value={Min=2,Max=50,Default=15},

    Callback=function(v)
        HitboxSize=
            type(v)=="table"
            and (tonumber(v.Value) or 15)
            or tonumber(v)
            or 15
    end
})

-- TAB 4
Tab4:Section({ Title = "Generator Logic" })

Tab4:Toggle({
    Title="Auto Generator",
    Desc="Auto SkillCheck tanpa stuck generator.",
    Flag="F_AutoGen",
    Value=false,
    Callback=function(v)

        AutoGenerator=v

        if not v then

            for _,con in pairs(HeartbeatConnections) do
                pcall(function()
                    con:Disconnect()
                end)
            end

            table.clear(HeartbeatConnections)
        end
    end
})

Tab4:Dropdown({
    Title="SkillCheck Mode",
    Desc="Perfect = bonus | Neutral = lebih aman",
    Values={"Perfect","Neutral"},
    Value="Perfect",
    Flag="F_GenMode",
    Callback=function(option)

        AutoGeneratorMode=option

        if option=="Perfect" then

            getgenv().GeneratorPerfectOffsetStart=102
            getgenv().GeneratorPerfectOffsetEnd=108

        else

            getgenv().GeneratorPerfectOffsetStart=102
            getgenv().GeneratorPerfectOffsetEnd=114
        end
    end
})
-- 2. Custom Keybind (Khusus Pemain PC)
Tab4:Keybind({
    Title = "Boost Gen Hotkey (PC Only)",
    Desc = "Pilih tombol keyboard untuk memicu Boost All Gen dari jarak jauh.",
    Icon = "lucide:keyboard",
    Default = "B", -- Default 'T' untuk Target/Tembak energi, bisa diubah user
    Callback = function()
        TriggerBoostAllGen()
    end
})
Tab4:Button({ 
    Title = "Boost All Gen (Group Project)", 
    Desc = "Menyuntikkan efek perk Group Project ke semua Generator secara instan!", 
    Icon = "lucide:zap", 
    Color = Color3.fromRGB(0, 200, 100), 
    Callback = function()
        TriggerBoostAllGen()
    end
})
Tab4:Space({ Columns = 2 }) 
Tab4:Section({ Title = "Utilities", Box = true })

Tab4:Toggle({ Title = "Self UnHook (Safe Mode)", Desc = "Turun dari tiang dengan aman (Membajak remote penyelamatan tanpa mengurangi HP tiang).", Flag = "F_AutoUnhook", Locked = true,
    LockedTitle = "Maintenance", Value = false, Callback = function(v) AutoUnhook = v end })
-- SPOOFING PROFILE
Spoof:Section({ Title = "Client-Sided (Visual Only)", Justify = "Center" })

-- 1. Input Box untuk Gears
Spoof:Input({
    Title = "Custom Gears",
    Desc = "Masukkan jumlah Gears.",
    PlaceholderText = "Jumlah Gears...",
    Callback = function(text)
        SpoofData.Gears = tonumber(text) or 0
    end
})

-- 2. Input Box untuk Screws
Spoof:Input({
    Title = "Custom Screws",
    Desc = "Masukkan jumlah Screws.",
    PlaceholderText = "Jumlah Screws...",
    Callback = function(text)
        SpoofData.Screws = tonumber(text) or 0
    end
})

-- 3. Input Box untuk Level
Spoof:Input({
    Title = "Custom Level",
    Desc = "Masukkan angka Level.",
    PlaceholderText = "Angka Level...",
    Callback = function(text)
        SpoofData.Level = tonumber(text) or 0
    end
})

Spoof:Space({ Columns = 2 }) 

-- 4. Tombol Eksekusi Brutal ke LocalPlayer
Spoof:Button({
    Title = "Apply Spoof Data",
    Icon = "lucide:scan-face",
    Justify = "Center",
    Color = Color3.fromRGB(0, 255, 150),
    Callback = function()
        local p = game.Players.LocalPlayer
        if not p then return end

        local function InjectValue(targetName, amount)
            if not amount or amount <= 0 then return end
            
            local targetLower = string.lower(targetName)
            local injectedCount = 0

            -- [METODE 1] Suntik ke Attribute (Game Modern)
            pcall(function() p:SetAttribute(targetName, amount) end)
            pcall(function() p:SetAttribute(targetName.."s", amount) end)

            -- [METODE 2] Bruteforce pencarian Value Object (leaderstats / folder mata uang)
            for _, obj in ipairs(p:GetDescendants()) do
                if obj:IsA("IntValue") or obj:IsA("NumberValue") or obj:IsA("StringValue") then
                    local n = string.lower(obj.Name)
                    -- Mencari kata kunci seperti "gear", "gears", "level", "playerlevel"
                    if string.find(n, targetLower) then
                        if obj:IsA("StringValue") then
                            pcall(function() obj.Value = tostring(amount) end)
                        else
                            pcall(function() obj.Value = amount end)
                        end
                        injectedCount = injectedCount + 1
                    end
                end
            end
            
            -- [METODE 3] Cari langsung di UI (PlayerGui) untuk merubah teks secara instan
            local pGui = p:FindFirstChild("PlayerGui")
            if pGui then
                for _, ui in ipairs(pGui:GetDescendants()) do
                    if ui:IsA("TextLabel") or ui:IsA("TextButton") then
                        local uiName = string.lower(ui.Name)
                        if string.find(uiName, targetLower) and (string.find(uiName, "amount") or string.find(uiName, "count") or string.find(uiName, "text") or uiName == targetLower) then
                            pcall(function() ui.Text = tostring(amount) end)
                        end
                    end
                end
            end
        end

        -- Eksekusi Suntikan
        InjectValue("Gear", SpoofData.Gears)
        InjectValue("Screw", SpoofData.Screws)
        InjectValue("Level", SpoofData.Level)

        WindUI:Notify({ 
            Title = "Spoof Applied!", 
            Content = "Data berhasil dimanipulasi secara visual! Coba cek UI profilmu.", 
            Icon = "lucide:check-circle" 
        })
    end
})
----------------------------------------------------------------
-- SETTINGS & CONFIG SYSTEM (WINDUI NATIVE)
----------------------------------------------------------------
local ConfigManager = Window.ConfigManager
local SaveName = "FORKT-HUB"
local Themes = {}

-- Ambil tema dengan aman
pcall(function()
    for name, _ in pairs(WindUI.Themes) do t_insert(Themes, name) end
end)

-- ==========================================
-- 1. CONFIGURATION SYSTEM
-- ==========================================
TabSettings:Section({ Title = "Configuration System" })
TabSettings:Space({ Columns = 2 }) 
local TabConfig = TabSettings:Group({})
TabConfig:Button({
    Title = "Save Config",
    Justify = "Center",
    Icon = "lucide:save",
    Callback = function()
        -- Proteksi pcall agar executor tidak crash jika tidak support penyimpanan file
        local success, err = pcall(function()
            Window.CurrentConfig = ConfigManager:Config(SaveName)
            Window.CurrentConfig:Save()
        end)
        
        if success then
            WindUI:Notify({ Title = "Config Saved", Content = "Semua pengaturan berhasil disimpan.", Icon = "lucide:check-circle" })
        else
            WindUI:Notify({ Title = "Save Failed", Content = "Executor kamu tidak mendukung penyimpanan.", Icon = "lucide:x-circle" })
        end
    end
})

TabConfig:Button({
    Title = "Load Config",
    Justify = "Center",
    Icon = "lucide:folder-open",
    Callback = function()
        local success, err = pcall(function()
            Window.CurrentConfig = ConfigManager:CreateConfig(SaveName)
            Window.CurrentConfig:Load()
        end)
        
        if success then
            WindUI:Notify({ Title = "Config Loaded", Content = "Pengaturan berhasil dimuat.", Icon = "lucide:check-circle" })
        else
            WindUI:Notify({ Title = "Load Failed", Content = "Tidak ada config yang ditemukan.", Icon = "lucide:x-circle" })
        end
    end
})

-- [FIX LAYOUT] Wajib dikembalikan ke 1 kolom sebelum membuat elemen baru di bawahnya
TabSettings:Space({ Columns = 1 }) 

-- ==========================================
-- 2. SECURITY & PROTECTION
-- ==========================================
TabSettings:Section({ Title = "Security & Protection" })

TabSettings:Toggle({ 
    Title = "Anti-Logger (Bypass Anti-Cheat)", 
    Desc = "Memblokir pengiriman laporan error atau cheat dari client ke server game.", 
    Flag = "F_AntiLogger", 
    Value = true, 
    Callback = function(v) AntiLogger = v end 
})

TabSettings:Space()

-- ==========================================
-- 3. WINDOW & INTERFACE
-- ==========================================
TabSettings:Section({ Title = "Window & Interface" })

TabSettings:Dropdown({ 
    Title = "Select Theme", 
    Desc = "Pilih tema warna antarmuka FORKT-HUB.",
    Flag = "F_Theme", 
    Value = ThemeName, 
    Values = Themes, 
    Callback = function(v) pcall(function() WindUI:SetTheme(v) end) end 
})

TabSettings:Space() 

TabSettings:Button({
    Title = "Unload FORKT-HUB",
    Desc = "Membatalkan semua fungsi, menghapus UI, dan membersihkan layar.",
    Icon = "lucide:power", 
    Color = Color3.fromHex("#E74C3C"), -- Alizarin Red (Merah elegan, tidak silau)
    Justify = "Left",
    Callback = function()
        getgenv().FORKT_RUNNING = false
        pcall(function() Window:Destroy() end)
        pcall(function() RunService:UnbindFromRenderStep("SmoothFOV") end)
        
        -- Bersihkan semua koneksi event
        if getgenv().FORKT_CONNECTIONS then
            for _, conn in ipairs(getgenv().FORKT_CONNECTIONS) do
                if conn.Disconnect then conn:Disconnect() end
            end
            table.clear(getgenv().FORKT_CONNECTIONS)
        end
        
        -- Hancurkan elemen UI tambahan
        if CrosshairGui then CrosshairGui:Destroy(); CrosshairGui = nil end
        if ParryRing then ParryRing:Destroy(); ParryRing = nil end
        if IndicatorGui then IndicatorGui:Destroy(); IndicatorGui = nil end
        
        -- Pembersihan ESP Pemain
        for _, p in ipairs(Players:GetPlayers()) do
            if p.Character then
                local h = p.Character:FindFirstChild("H")
                if h then h:Destroy() end
                local root = p.Character:FindFirstChild("HumanoidRootPart")
                if root then
                    local tag = root:FindFirstChild("TagESP")
                    if tag then tag:Destroy() end
                end
            end
        end
        
        -- Pembersihan Map ESP
        if CachedMapObjects then
            for _, list in pairs(CachedMapObjects) do
                for _, obj in ipairs(list) do
                    local h = obj:FindFirstChild("H")
                    if h then h:Destroy() end
                end
            end
        end
    end 
})
----------------------------------------------------------------
-- [PREMIUM MOBILE UI] TOMBOL STATIS (ANTI-HILANG)
----------------------------------------------------------------
local isMobileDevice = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

if isMobileDevice then
    local coreSuccess, coreResult = pcall(function() return cloneref(game:GetService("CoreGui")) end)
    local SafeGuiFolder = coreSuccess and coreResult or PlayerGui

    local combatGui = SafeGuiFolder:FindFirstChild("FORKT_MobileButtons") or Instance.new("ScreenGui")
    combatGui.Name = "FORKT_MobileButtons"
    combatGui.ResetOnSpawn = false
    combatGui.IgnoreGuiInset = true
    combatGui.Parent = SafeGuiFolder -- [FIX] Pindahkan ke folder kebal wipe!

    MobileRotateBtn = combatGui:FindFirstChild("RotateBtn") or Instance.new("TextButton")
    MobileRotateBtn.Name = "RotateBtn"
    MobileRotateBtn.Size = UDim2.new(0, 65, 0, 65) 
    MobileRotateBtn.Position = UDim2.new(1, -85, 0.5, 30) 
    MobileRotateBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 35) 
    MobileRotateBtn.BackgroundTransparency = 0.15
    MobileRotateBtn.AutoButtonColor = false 
    MobileRotateBtn.Text = "TPP"
    MobileRotateBtn.TextColor3 = Color3.new(1, 1, 1)
    MobileRotateBtn.Font = Enum.Font.GothamBlack
    MobileRotateBtn.TextSize = 16 
    MobileRotateBtn.Visible = false 
    MobileRotateBtn.Parent = combatGui

    -- Bersihkan style lama jika re-execute agar tidak menumpuk
    for _, child in ipairs(MobileRotateBtn:GetChildren()) do child:Destroy() end

    -- [UI BEAUTIFY] Sudut membulat penuh
    local corner = Instance.new("UICorner", MobileRotateBtn)
    corner.CornerRadius = UDim.new(1, 0)

    -- [UI BEAUTIFY] Outline Neon
    local stroke = Instance.new("UIStroke", MobileRotateBtn)
    stroke.Thickness = 2.5
    stroke.Color = Color3.fromRGB(75, 150, 255) 

    -- [UI BEAUTIFY] Efek Gradient
    local gradient = Instance.new("UIGradient", MobileRotateBtn)
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 150, 150))
    })
    gradient.Rotation = 45

    -- =========================================================
    -- SIMPLE TAP LOGIC (NO DRAG)
    -- =========================================================
    
    MobileRotateBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            MobileRotateBtn.Size = UDim2.new(0, 58, 0, 58)
        end
    end)

    MobileRotateBtn.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            MobileRotateBtn.Size = UDim2.new(0, 65, 0, 65)
            
            isFPP = not isFPP
            SwitchCameraMode(isFPP)
            
            stroke.Color = isFPP and Color3.fromRGB(255, 100, 50) or Color3.fromRGB(75, 150, 255)
            MobileRotateBtn.Text = isFPP and "FPP" or "TPP"
        end
    end)
end

-- =========================================================
-- OMNI NETWORK HOOK (FIXED + STABLE)
-- =========================================================

local oldNamecall
oldNamecall=hookmetamethod(game,"__namecall",newcclosure(function(self,...)

    local method=getnamecallmethod()

    if checkcaller()
    or method~="FireServer"
    or typeof(self)~="Instance" then
        return oldNamecall(self,...)
    end

    local args={...}
    local n=tostring(self):lower()

    ------------------------------------------------
    -- SAFE HEAL
    ------------------------------------------------

    if n:find("healevent")
    or n:find("requestheal") then
        return oldNamecall(self,...)
    end

    ------------------------------------------------
    -- DOUBLE DAMAGE GENERATOR
    ------------------------------------------------
    
    if DoubleDamageGen
    and n:find("breakgenevent") then
    
        local team=LocalPlayer.Team
    
        if team and team.Name:lower():find("killer") then
    
            local saved=table.clone(args)
    
            ------------------------------------------------
            -- NORMAL HIT
            ------------------------------------------------
    
            local result=oldNamecall(self,...)
    
            ------------------------------------------------
            -- EXTRA DAMAGE
            ------------------------------------------------
    
            task.spawn(function()
    
                for i=1,4 do
    
                    task.wait(0.08)
    
                    pcall(function()
                        oldNamecall(self,unpack(saved))
                    end)
                end
    
                ------------------------------------------------
                -- FORCE UNSTUCK
                ------------------------------------------------
    
                local char=LocalPlayer.Character
                local hum=char and char:FindFirstChildOfClass("Humanoid")
                local root=char and char:FindFirstChild("HumanoidRootPart")
    
                if hum and root then
    
                    root.Anchored=false
    
                    hum.PlatformStand=false
                    hum.AutoRotate=true
                    hum.Sit=false
    
                    ------------------------------------------------
                    -- STOP BREAK ANIMATION
                    ------------------------------------------------
    
                    for _,track in ipairs(hum:GetPlayingAnimationTracks()) do
    
                        local anim=track.Animation
                        local name=((anim and anim.Name) or ""):lower()
    
                        if name:find("break")
                        or name:find("generator")
                        or name:find("kick") then
    
                            pcall(function()
                                track:Stop(0)
                            end)
                        end
                    end
    
                    task.wait()
    
                    hum:ChangeState(Enum.HumanoidStateType.Running)
                end
            end)
    
            return result
        end
    end

    ------------------------------------------------
    -- SILENT ACTIONS
    ------------------------------------------------

    if SilentActions then
        local words={
            "noise","scream","vaultalert",
            "spotted","alert","ping",
            "loud","notify","notification",
            "sound"
        }

        for _,w in ipairs(words) do
            if n:find(w)
            or (
                type(args[1])=="string"
                and args[1]:lower():find(w)
            ) then
                return
            end
        end
    end

    ------------------------------------------------
    -- ANTI LOGGER
    ------------------------------------------------

    if AntiLogger
    and (
        n:find("log")
        or n:find("error")
        or n:find("report")
        or n:find("anticheat")
        or n:find("ban")
    ) then
        return
    end

    ------------------------------------------------
    -- SPEAR MOD
    ------------------------------------------------

    if n:find("spear")
    or n:find("throw")
    or n:find("visualize") then

        local team=LocalPlayer.Team

        if team and team.Name:lower():find("killer") then
            local modified=false

            if SpearPrediction
            and typeof(GetClosestPlayer)=="function" then

                local target=GetClosestPlayer()
                local myRoot=LocalPlayer.Character
                    and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

                if target and myRoot then
                    local pred=target.Position+(
                        (target.AssemblyLinearVelocity or Vector3.zero)*0.09
                    )

                    local dir=(pred-myRoot.Position).Unit

                    for i,v in ipairs(args) do
                        if typeof(v)=="Vector3" then
                            args[i]=dir*150
                            modified=true
                            break
                        end
                    end
                end
            end

            if AntiGravitySpear then
                for i,v in ipairs(args) do

                    if typeof(v)=="Vector3" then
                        local mag=v.Magnitude
                        args[i]=v.Unit*math.clamp(mag,80,220)
                        modified=true

                    elseif typeof(v)=="CFrame" then
                        local look=v.LookVector

                        args[i]=CFrame.lookAt(
                            v.Position,
                            v.Position+(
                                Vector3.new(look.X,0,look.Z).Unit*100
                            )
                        )

                        modified=true

                    elseif type(v)=="number" then

                        if v>0 and v<12 then
                            args[i]=0
                            modified=true

                        elseif v>=12 and v<=120 then
                            args[i]=math.clamp(v*1.1,20,180)
                            modified=true
                        end
                    end
                end
            end

            if modified then
                return oldNamecall(self,unpack(args))
            end
        end
    end

    ------------------------------------------------
    -- ANTI FALL
    ------------------------------------------------

    if AntiFallDamage
    and (
        n:find("falldamage")
        or n:find("fall")
        or n:find("ragdollfall")
    ) then
        return
    end

    ------------------------------------------------
    -- ANTI AURA
    ------------------------------------------------

    if getgenv().AntiAura then

        getgenv().AuraRemoteCache=
            getgenv().AuraRemoteCache or {}

        local cache=getgenv().AuraRemoteCache
        local key=tostring(self)

        if cache[key]==nil then

            local score=0

            for _,w in ipairs({
                "aura","reveal","highlight",
                "sense","spotted","vision",
                "radar","detect","tracking",
                "hunter"
            }) do
                if n:find(w) then
                    score+=2
                end
            end

            local mentions=false

            for i=1,math.min(3,#args) do
                if args[i]==LocalPlayer
                or args[i]==LocalPlayer.Character then
                    mentions=true
                    break
                end
            end

            cache[key]=score>=4 and mentions
        end

        if cache[key] then
            return
        end
    end
    ----------------------------------------------------------------
    -- SILENT AIM FIXED (REAL REMOTE)
    -- MOBILE + PC SUPPORT
    ----------------------------------------------------------------
    
    if SilentAimPistol
    and n:find("fire") then
    
        local team=LocalPlayer.Team
    
        local survivor=not (
            team
            and team.Name:lower():find("killer")
        )
    
        if survivor then
    
            local target=GetClosestKiller()
    
            if target then
    
                local myRoot=
                    LocalPlayer.Character
                    and LocalPlayer.Character:FindFirstChild(
                        "HumanoidRootPart"
                    )
    
                if myRoot then
    
                    ------------------------------------------------
                    -- PREDICTION
                    ------------------------------------------------
    
                    local vel=
                        target.AssemblyLinearVelocity
                        or Vector3.zero
    
                    if vel.Magnitude>45 then
                        vel=vel.Unit*45
                    end
    
                    local ping=0.08
    
                    pcall(function()
    
                        ping=
                            Stats.Network
                            .ServerStatsItem["Data Ping"]
                            :GetValue()/1000
                    end)
    
                    ping=math.clamp(ping,0.05,0.18)
    
                    local predicted=
                        target.Position
                        +(vel*(0.11+ping))
    
                    ------------------------------------------------
                    -- DIRECTION
                    ------------------------------------------------
    
                    local dir=
                        (predicted-myRoot.Position).Unit
    
                    ------------------------------------------------
                    -- FIX REMOTE ARGUMENTS
                    ------------------------------------------------
    
                    args[1]=
                        ReplicatedStorage
                        .Remotes
                        .Items["Twist of Fate"]
    
                    args[2]=dir
    
                    ------------------------------------------------
                    -- OPTIONAL VISUAL
                    ------------------------------------------------
    
                    task.spawn(function()
    
                        local visualize=
                            ReplicatedStorage
                            .Remotes
                            .Items["Twist of Fate"]
                            :FindFirstChild("VisualizeBullet")
    
                        if visualize then
    
                            pcall(function()
    
                                visualize:FireServer(
                                    predicted,
                                    dir
                                )
                            end)
                        end
                    end)
    
                    return oldNamecall(
                        self,
                        unpack(args)
                    )
                end
            end
        end
    end

    return oldNamecall(self,...)
end))
----------------------------------------------------------------
-- AUTO GENERATOR
-- MOBILE + PC SUPPORT
-- DYNAMIC GOAL SUPPORT
----------------------------------------------------------------

local LastSkillHit=0
local LastGoalRotation=0
local LastTriggerTick=0

----------------------------------------------------------------
-- ANTI STUCK
----------------------------------------------------------------

local function ForceUnstuck()

    local char=LocalPlayer.Character
    local hum=char and char:FindFirstChildOfClass("Humanoid")
    local root=char and char:FindFirstChild("HumanoidRootPart")

    if not(char and hum and root) then
        return
    end

    ------------------------------------------------
    -- STOP ANIMATION
    ------------------------------------------------

    for _,track in ipairs(hum:GetPlayingAnimationTracks()) do

        local anim=track.Animation
        local name=((anim and anim.Name) or ""):lower()

        if name:find("repair")
        or name:find("generator")
        or name:find("fix")
        or name:find("interaction") then

            pcall(function()
                track:Stop(0)
            end)
        end
    end

    ------------------------------------------------
    -- RESET STATES
    ------------------------------------------------

    for _,v in ipairs({
        "Repairing",
        "IsRepairing",
        "Interacting",
        "Busy",
        "Action",
        "Using"
    }) do

        pcall(function()

            if char:GetAttribute(v)~=nil then
                char:SetAttribute(v,false)
            end

            local obj=char:FindFirstChild(v)

            if obj and obj:IsA("ValueBase") then

                if typeof(obj.Value)=="boolean" then
                    obj.Value=false

                elseif typeof(obj.Value)=="number" then
                    obj.Value=0
                end
            end
        end)
    end

    ------------------------------------------------
    -- FORCE MOVE
    ------------------------------------------------

    root.Anchored=false

    hum.PlatformStand=false
    hum.AutoRotate=true
    hum.Sit=false

    hum:ChangeState(
        Enum.HumanoidStateType.Running
    )
end

----------------------------------------------------------------
-- PLATFORM
----------------------------------------------------------------

local IsMobile =
    UserInputService.TouchEnabled
    and not UserInputService.KeyboardEnabled

----------------------------------------------------------------
-- PRESS SKILL
----------------------------------------------------------------

local function PressSkill()

    ------------------------------------------------
    -- ANTI DOUBLE TRIGGER
    ------------------------------------------------

    if tick()-LastTriggerTick<0.08 then
        return
    end

    LastTriggerTick=tick()

    ------------------------------------------------
    -- MOBILE
    ------------------------------------------------

    if IsMobile then

        local btn=
            PlayerGui:FindFirstChild("check",true)

        if btn and btn:IsA("GuiObject") then

            local pos=btn.AbsolutePosition
            local size=btn.AbsoluteSize
            local inset=GuiService:GetGuiInset()

            local x=
                pos.X+(size.X/2)+inset.X

            local y=
                pos.Y+(size.Y/2)+inset.Y

            ------------------------------------------------
            -- TOUCH
            ------------------------------------------------

            pcall(function()

                VirtualInputManager:SendTouchEvent(
                    8822,
                    Enum.UserInputState.Begin.Value,
                    x,
                    y
                )

                task.wait()

                VirtualInputManager:SendTouchEvent(
                    8822,
                    Enum.UserInputState.End.Value,
                    x,
                    y
                )
            end)

            ------------------------------------------------
            -- FALLBACK
            ------------------------------------------------

            pcall(function()

                if firesignal
                and btn.MouseButton1Click then

                    firesignal(
                        btn.MouseButton1Click
                    )
                end
            end)
        end

    ------------------------------------------------
    -- PC
    ------------------------------------------------

    else

        pcall(function()

            VirtualInputManager:SendKeyEvent(
                true,
                Enum.KeyCode.Space,
                false,
                game
            )

            task.wait()

            VirtualInputManager:SendKeyEvent(
                false,
                Enum.KeyCode.Space,
                false,
                game
            )
        end)
    end
end

----------------------------------------------------------------
-- GET ACTIVE SKILLCHECK
----------------------------------------------------------------

local function GetSkillCheck()

    for _,guiName in ipairs({
        "SkillCheckPromptGui",
        "SkillCheckPromptGui-con"
    }) do

        local gui=
            PlayerGui:FindFirstChild(
                guiName,
                true
            )

        if gui then

            local check=
                gui:FindFirstChild(
                    "Check",
                    true
                )

            if check
            and check.Visible then

                local line=
                    check:FindFirstChild(
                        "Line",
                        true
                    )

                local goal=
                    check:FindFirstChild(
                        "Goal",
                        true
                    )

                if line and goal then
                    return line,goal
                end
            end
        end
    end
end

----------------------------------------------------------------
-- MAIN
----------------------------------------------------------------

if GenConnection then
    GenConnection:Disconnect()
end

GenConnection=
    RunService.Heartbeat:Connect(function()

    if not AutoGenerator then
        return
    end

    local line,goal=GetSkillCheck()

    if not(line and goal) then
        return
    end

    ------------------------------------------------
    -- DYNAMIC ROTATION
    ------------------------------------------------

    local lr=line.Rotation%360
    local gr=goal.Rotation%360

    ------------------------------------------------
    -- MOVING GOAL FIX
    ------------------------------------------------

    local goalVelocity=
        math.abs(gr-LastGoalRotation)

    LastGoalRotation=gr

    ------------------------------------------------
    -- AUTO COMPENSATION
    ------------------------------------------------

    local dynamicOffset=

        math.clamp(
            goalVelocity*0.35,
            0,
            8
        )

    ------------------------------------------------
    -- MODE
    ------------------------------------------------

    local startPos,endPos

    if AutoGeneratorMode=="Neutral" then

        ------------------------------------------------
        -- WIDER SAFE AREA
        ------------------------------------------------

        startPos=
            (gr+96-dynamicOffset)%360

        endPos=
            (gr+122+dynamicOffset)%360

    else

        ------------------------------------------------
        -- PERFECT
        ------------------------------------------------

        startPos=
            (
                gr+
                (
                    getgenv()
                    .GeneratorPerfectOffsetStart
                    or 102
                )
                -dynamicOffset
            )%360

        endPos=
            (
                gr+
                (
                    getgenv()
                    .GeneratorPerfectOffsetEnd
                    or 109
                )
                +dynamicOffset
            )%360
    end

    ------------------------------------------------
    -- DETECT INSIDE
    ------------------------------------------------

    local inside=false

    if startPos>endPos then

        inside=
            (
                lr>=startPos
                or lr<=endPos
            )

    else

        inside=
            (
                lr>=startPos
                and lr<=endPos
            )
    end

    ------------------------------------------------
    -- HIT
    ------------------------------------------------

    if inside then

        LastSkillHit=tick()

        PressSkill()
    end
end)

----------------------------------------------------------------
-- FAIL / STUCK DETECT
----------------------------------------------------------------

task.spawn(function()

    while task.wait(0.25) do

        if not AutoGenerator then
            continue
        end

        local line=GetSkillCheck()

        ------------------------------------------------
        -- FAIL DETECT
        ------------------------------------------------

        if not line
        and tick()-LastSkillHit>1.1 then

            pcall(function()
                ForceUnstuck()
            end)
        end
    end
end)
----------------------------------------------------------------
-- KILLER: AUTO ATTACK LOGIC (LATENCY COMPENSATED & PCALL FREE)
----------------------------------------------------------------
local CachedBasicAttack = nil
local SearchedAttackRemote = false
local lastAttackStrike = 0

task.spawn(function()
    while task.wait(0.15) do 
        if not getgenv().FORKT_RUNNING then break end 
        if not AutoAttack then
            continue
        end
        
        -- [FIX CPU] Pcall Dihapus! Menghemat pembuatan fungsi sampah di memori
        local myChar = LocalPlayer.Character
        local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
        local myHum = myChar and myChar:FindFirstChild("Humanoid")
        
        if not myRoot or not myHum or myHum.Health <= 0 then
            continue
        end
        
        local myTeam = LocalPlayer.Team and LocalPlayer.Team.Name:lower() or ""
        if not myTeam:find("killer") then
            continue
        end

        local isCarrying = GetGameValue(myChar, "Carrying") or GetGameValue(myChar, "IsCarrying")
        local isStunned = GetGameValue(myChar, "Stunned")
        if isCarrying or isStunned then
            continue
        end

        local targetFound = false
        local players = Players:GetPlayers()
        
        for i = 1, #players do
            local p = players[i]
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local enemyTeam = p.Team and p.Team.Name:lower() or ""
                
                if not enemyTeam:find("killer") then
                    local enemyChar = p.Character
                    local enemyHum = enemyChar:FindFirstChild("Humanoid")
                    
                    if enemyHum and enemyHum.Health > 0 then
                        local isKnocked = GetGameValue(enemyChar, "Knocked")
                        local isHooked = GetGameValue(enemyChar, "IsHooked")
                        
                        if not isKnocked and not isHooked then
                            local dist = (enemyChar.HumanoidRootPart.Position - myRoot.Position).Magnitude
                            local isEnemyRunning = enemyHum.MoveDirection.Magnitude > 0
                            local effectiveRange = isEnemyRunning and (AttackRange + 3) or AttackRange
                            
                            if dist <= effectiveRange then
                                targetFound = true
                                break 
                            end
                        end
                    end
                end
            end
        end

        local now = os.clock()
        if targetFound and (now - lastAttackStrike > 0.6) then
            lastAttackStrike = now
            
            if not SearchedAttackRemote then
                local remotes = ReplicatedStorage:FindFirstChild("Remotes")
                local attacks = remotes and (remotes:FindFirstChild("Attacks") or remotes:FindFirstChild("attacks") or remotes:FindFirstChild("Attack"))
                if attacks then
                    CachedBasicAttack = attacks:FindFirstChild("BasicAttack") or attacks:FindFirstChild("basicattack")
                end
                SearchedAttackRemote = true
            end

            if CachedBasicAttack then
                CachedBasicAttack:FireServer(false)
                task.wait(0.05)
                CachedBasicAttack:FireServer(true) 
            end
        end
    end
end)


----------------------------------------------------------------
-- AUTO PARRY (MOBILE + PC SUPPORT)
-- CONTINUOUS PARRY IN RANGE
----------------------------------------------------------------

local IgnoreSkills={
    "Veil","Masked","Stalker","Invisible",
    "Ghost","Phase","Dash","Warp","Teleport"
}

local KillerProfiles={
    Killer={BonusDist=1,Delay=0.04},
    Abysswalker={BonusDist=3.5,Delay=0.12},
    Hidden={BonusDist=2.2,Delay=0},
    Masked={BonusDist=1.5,Delay=0.05},
    Stalker={BonusDist=1.8,Delay=0},
    Veil={BonusDist=3.2,Delay=0.04},
    Slasher={BonusDist=1.2,Delay=0.05},
    Cure={BonusDist=2,Delay=0.03},
}

local ExactParryRemote
local LastParryTick=0
local CFG_BurstAmount=8
local CFG_ParryCooldown=0.06
local CFG_MaxVelocity=32
local CFG_AimPrediction=true

----------------------------------------------------------------
-- REMOTE
----------------------------------------------------------------

local function GetParryRemote()

    if ExactParryRemote and ExactParryRemote.Parent then
        return ExactParryRemote
    end

    local remotes=ReplicatedStorage:FindFirstChild("Remotes")
    if not remotes then
        return
    end

    local items=remotes:FindFirstChild("Items")
    local dagger=items and items:FindFirstChild("Parrying Dagger")

    if dagger and dagger:FindFirstChild("parry") then

        ExactParryRemote=dagger.parry

    else

        for _,v in ipairs(remotes:GetDescendants()) do

            if v:IsA("RemoteEvent")
            and v.Name:lower()=="parry" then

                ExactParryRemote=v
                break
            end
        end
    end

    return ExactParryRemote
end

----------------------------------------------------------------
-- PING
----------------------------------------------------------------

local function GetPing()

    local ping=0.09

    pcall(function()

        ping=
            Stats.Network
            .ServerStatsItem["Data Ping"]
            :GetValue()/1000
    end)

    return math.clamp(ping,0.04,0.22)
end

----------------------------------------------------------------
-- IGNORE SKILLS
----------------------------------------------------------------

local function IsKillerUsingSkill(char)

    for _,skill in ipairs(IgnoreSkills) do

        if char:GetAttribute(skill)
        or GetGameValue(char,skill) then
            return true
        end
    end

    return false
end

----------------------------------------------------------------
-- PROFILE
----------------------------------------------------------------

local function GetKillerProfile(char)

    local selected=
        getgenv().ParryMatchup
        or "Auto"

    if selected~="Auto" then
        return KillerProfiles[selected]
            or {BonusDist=1,Delay=0}
    end

    local detect=string.upper(
        tostring(
            char:GetAttribute("KillerType")
            or char:GetAttribute("Mask")
            or char.Name
        )
    )

    for profile,mask in pairs(MaskNames) do

        if detect:find(mask) then
            return KillerProfiles[profile]
        end
    end

    return {BonusDist=1,Delay=0}
end

----------------------------------------------------------------
-- TRIGGER PARRY
----------------------------------------------------------------

local function TriggerParryDagger()

    local now=tick()

    if now-LastParryTick<CFG_ParryCooldown then
        return
    end

    local remote=GetParryRemote()

    if not remote then
        return
    end

    local char=LocalPlayer.Character
    local root=char and char:FindFirstChild("HumanoidRootPart")
    local hum=char and char:FindFirstChildOfClass("Humanoid")

    if not(root and hum)
    or hum.Health<=0 then
        return
    end

    ------------------------------------------------
    -- TOOL CHECK
    ------------------------------------------------

    local tool=
        char:FindFirstChild("Parrying Dagger")
        or char:FindFirstChildWhichIsA("Tool")

    if not tool then
        return
    end

    local ping=GetPing()
    local bestTarget=nil
    local bestDistance=math.huge

    ------------------------------------------------
    -- FIND KILLER
    ------------------------------------------------

    for _,plr in ipairs(Players:GetPlayers()) do

        if plr~=LocalPlayer
        and plr.Team
        and plr.Team.Name:lower():find("killer")
        and plr.Character then

            local eChar=plr.Character
            local eRoot=eChar:FindFirstChild("HumanoidRootPart")
            local eHum=eChar:FindFirstChildOfClass("Humanoid")

            if eRoot and eHum
            and eHum.Health>0 then

                if IsKillerUsingSkill(eChar) then
                    continue
                end

                local profile=GetKillerProfile(eChar)

                local maxDist=
                    (tonumber(ParryDistance) or 10)
                    +(profile.BonusDist or 0)
                    +(ping*10)

                ------------------------------------------------
                -- PREDICTION
                ------------------------------------------------

                local predictPos=eRoot.Position

                if CFG_AimPrediction then

                    local vel=eRoot.AssemblyLinearVelocity

                    if vel.Magnitude>CFG_MaxVelocity then
                        vel=vel.Unit*CFG_MaxVelocity
                    end

                    local strict=
                        getgenv().AimStrictness
                        or 1.3

                    predictPos+=
                        vel*(ping+(strict*0.045))
                end

                local dist=
                    (predictPos-root.Position).Magnitude

                if dist<=maxDist
                and dist<bestDistance then

                    bestDistance=dist

                    bestTarget={
                        Root=eRoot,
                        Profile=profile
                    }
                end
            end
        end
    end

    if not bestTarget then
        return
    end

    LastParryTick=now

    ------------------------------------------------
    -- DELAY
    ------------------------------------------------

    local finalDelay=
        (bestTarget.Profile.Delay or 0)
        +(getgenv().ParryDelayOffset or 0)

    task.spawn(function()

        if finalDelay>0 then
            task.wait(finalDelay)
        end

        ------------------------------------------------
        -- CONTINUOUS BURST
        ------------------------------------------------

        for i=1,CFG_BurstAmount do

            if not AutoParry then
                break
            end

            if not remote
            or not remote.Parent then
                break
            end

            pcall(function()
                remote:FireServer()
            end)

            ------------------------------------------------
            -- MOBILE + PC SAFE
            ------------------------------------------------

            task.wait(0.008)
        end
    end)
end

-- =========================================================
-- [LOGIKA DEWA 3] GLOBAL KILLER STUN DETECTOR
-- =========================================================

task.spawn(function()
    local killerStunStates = {} -- Mengingat status Killer sebelumnya
    
    while task.wait(0.2) do 
        if not getgenv().FORKT_RUNNING then break end
        
        -- Cegat di sini! Jika fitur dimatikan (Off), jangan eksekusi pencarian
        if NotifyStun then
            pcall(function()
                for _, p in ipairs(Players:GetPlayers()) do
                    local teamName = p.Team and p.Team.Name:lower() or ""
                    
                    if teamName:find("killer") and p.Character then
                        local kChar = p.Character
                        
                        local stunVal = GetGameValue(kChar, "Stunned") or GetGameValue(kChar, "IsStunned")
                        local isStunned = stunVal == true or (type(stunVal) == "number" and stunVal > 0)
                        
                        if isStunned and not killerStunStates[p.UserId] then
                            WindUI:Notify({ 
                                Title = "KILLER STUNNED!", 
                                Content = p.Name .. " berhasil stunned!!", 
                                Icon = "lucide:dizzy",
                                Duration = 3
                            })
                        end
                        
                        killerStunStates[p.UserId] = isStunned
                    end
                end
            end)
        else
            if next(killerStunStates) ~= nil then
                table.clear(killerStunStates)
            end
        end
    end
end)
t_insert(getgenv().FORKT_CONNECTIONS, RunService.RenderStepped:Connect(function(deltaTime)
    local myChar = LocalPlayer.Character
    local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
    local myHum = myChar and myChar:FindFirstChild("Humanoid")
    local camera = workspace.CurrentCamera
    
    -- =========================================================
    -- 2. HYPERFAST ZIGZAG MOONWALK LOGIC (OPTIMIZED)
    -- =========================================================
    local isMoonwalkEnabled = getgenv().MoonwalkEnabled

    if isMoonwalkEnabled ~= lastMoonwalkState then
        if myHum then 
            myHum.AutoRotate = not isMoonwalkEnabled 
        end
        lastMoonwalkState = isMoonwalkEnabled
        if isMoonwalkEnabled and myRoot then
            local _, y, _ = myRoot.CFrame:ToEulerAnglesYXZ()
            CurrentMoonwalkYaw = math.deg(y)
        end
    end

    if isMoonwalkEnabled and myRoot and myHum and myHum.Health > 0 then
        local look = camera.CFrame.LookVector
        local targetYaw = math.deg(math.atan2(look.X, look.Z)) + 180
        local diff = (targetYaw - (CurrentMoonwalkYaw or 0) + 180) % 360 - 180
        local lerpSpeed = 0.22 * math.clamp(deltaTime * 60, 0, 3)
        CurrentMoonwalkYaw = (CurrentMoonwalkYaw or 0) + (diff * lerpSpeed)
        
        local moving = myHum.MoveDirection.Magnitude > 0.01
        local targetSway = 0
        if moving then
            local fastZig = getgenv().MoonwalkZigzagSpeed or 11
            targetSway = math.sin(tick() * fastZig) * 48
        end
        CurrentMoonwalkSway = (CurrentMoonwalkSway or 0) + (targetSway - (CurrentMoonwalkSway or 0)) * 0.38
        myRoot.CFrame = CFrame.new(myRoot.Position) * CFrame.Angles(0, math.rad(CurrentMoonwalkYaw + CurrentMoonwalkSway), 0)
        
        if moving then
            local boost = getgenv().MoonwalkBoostPower or 1.08
            myHum:Move(myHum.MoveDirection * boost, false)
        end
    end

    -- =========================================================
    -- 3. AIMBOT SYSTEM (FIXED)
    -- =========================================================
    if Aimbot and myRoot and myHum and myHum.Health > 0 then
        local now = os.clock()
        
        -- Cek status angkut (Optimization agar tidak berat)
        if now - lastRenderCheck > 0.25 then
            cachedIsCarrying = GetGameValue(myChar, "Carrying") or GetGameValue(myChar, "IsCarrying") or false
            lastRenderCheck = now
        end
        
        if not cachedIsCarrying then
            -- Cari target baru jika tidak ada target atau sudah waktunya refresh
            if now - LastTargetCheck > 0.1 then
                CachedTarget = GetClosestPlayer(CachedTarget) 
                LastTargetCheck = now
            end
            
            local targetPart = CachedTarget 
            if not targetPart then
                CachedTarget = nil
                return
            end
            
            if not targetPart.Parent then
                CachedTarget = nil
                return
            end

            if targetPart and targetPart.Parent then
                local isFiring = false
                local aimTrigger = getgenv().AimbotTrigger or "Hold to Lock"
                
                if aimTrigger == "Auto Lock (Always)" then
                    isFiring = true
                else
                    -- Deteksi Input (PC & Mobile)
                    pcall(function()
                        if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) or 
                           UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
                            isFiring = true
                        end
                        
                        if now - lastTouchCheck > 0.05 then
                            cachedTouches = UserInputService:GetTouches()
                            lastTouchCheck = now
                        end
                        
                        for _, touch in ipairs(cachedTouches) do
                            if touch.Position.X > (camera.ViewportSize.X / 2) then
                                isFiring = true
                                break
                            end
                        end
                    end)
                    
                    if getgenv().isMobileFiring then isFiring = true end
                end
                
                -- Eksekusi Lock Kamera
                if isFiring then
                    local targetPos = targetPart.Position
                    
                    -- Prediksi Jarak (Spear)
                    if SpearPrediction then
                        local dist = (myRoot.Position - targetPos).Magnitude
                        if dist > 15 then 
                            targetPos = targetPos + v3(0, dist * 0.08, 0) 
                        end
                    end
                    
                    local smoothMulti = tonumber(getgenv().AimbotSmoothness) or 8
                    smoothMulti = math.clamp(smoothMulti, 1, 25)
                    
                    local smoothFactor = math.clamp(deltaTime * smoothMulti, 0.02, 0.35)
                    
                    pcall(function()
                        local newCF = CFrame.lookAt(
                            camera.CFrame.Position,
                            targetPos
                        )
                    
                        camera.CFrame = camera.CFrame:Lerp(newCF, smoothFactor)
                    end)
                end
            end
        end
    else
        CachedTarget = nil -- Reset target jika aimbot mati
    end
end))
RunService:BindToRenderStep("SmoothFOV", Enum.RenderPriority.Camera.Value + 1, function()
    if CustomCameraFOV and workspace.CurrentCamera then workspace.CurrentCamera.FieldOfView = CameraFOVValue end
end)

-- =========================================================
-- [OPTIMASI MOBILE] CACHING REMOTE HEARTBEAT
-- =========================================================
local CachedHBRemotes = {}
local SearchedHBRemotes = false

t_insert(
    getgenv().FORKT_CONNECTIONS,

    RunService.Heartbeat:Connect(function(dt)

        if not getgenv().FORKT_RUNNING then
            return
        end

        local now = os.clock()

        -- =========================================================
        -- CHARACTER CACHE
        -- =========================================================

        local myChar = LocalPlayer.Character

        if not myChar then
            return
        end

        local myHum =
            myChar:FindFirstChildOfClass("Humanoid")

        local myRoot =
            myChar:FindFirstChild("HumanoidRootPart")

        if not myHum or not myRoot then
            return
        end

        -- =========================================================
        -- SAFE STATUS CHECKER
        -- =========================================================

        local function IsStatusActive(val)

            return val == true
                or (
                    type(val) == "number"
                    and val > 0
                )
        end

        -- =========================================================
        -- TEAM CHECK
        -- =========================================================

        local myTeam =
            LocalPlayer.Team
            and LocalPlayer.Team.Name:lower()
            or ""

        local isKiller =
            myTeam:find("killer") ~= nil

        -- =========================================================
        -- ESP REFRESH
        -- =========================================================

        if now - LastESPRefresh > 0.35 then

            LastESPRefresh = now

            pcall(function()
                RefreshESP()
            end)
        end

        -- =========================================================
        -- KILLER SCAN
        -- =========================================================

        closestKillerDist = 999

        local isKillerRunning = false

        local players = Players:GetPlayers()

        for i = 1, #players do

            local p = players[i]

            if p ~= LocalPlayer
            and p.Character then

                local enemyChar = p.Character

                local eRoot =
                    enemyChar:FindFirstChild(
                        "HumanoidRootPart"
                    )

                if eRoot then

                    local teamName =
                        p.Team
                        and p.Team.Name:lower()
                        or ""

                    if string.find(teamName, "killer") then

                        local dist =
                            (
                                eRoot.Position
                                - myRoot.Position
                            ).Magnitude

                        if dist < closestKillerDist then

                            closestKillerDist = dist

                            local eHum =
                                enemyChar:FindFirstChildOfClass(
                                    "Humanoid"
                                )

                            if eHum
                            and eHum.MoveDirection.Magnitude > 0 then

                                isKillerRunning = true
                            end
                        end

                        ------------------------------------------------
                        -- HITBOX EXPANDER (REAL + SAFE)
                        ------------------------------------------------
                        
                        if HitboxExpander then
                        
                            local targetSize=v3(
                                HitboxSize,
                                HitboxSize,
                                HitboxSize
                            )
                        
                            if eRoot.Size~=targetSize then
                        
                                pcall(function()
                        
                                    eRoot.Size=targetSize
                        
                                    ------------------------------------------------
                                    -- VISUAL
                                    ------------------------------------------------
                        
                                    eRoot.Transparency=0.9
                                    eRoot.Material=Enum.Material.ForceField
                                    eRoot.Color=Color3.fromRGB(255,0,0)
                        
                                    ------------------------------------------------
                                    -- IMPORTANT FIX
                                    ------------------------------------------------
                        
                                    eRoot.Massless=false
                                    eRoot.CanCollide=false
                        
                                    ------------------------------------------------
                                    -- DO NOT TOUCH
                                    ------------------------------------------------
                                    -- eRoot.Anchored
                                    -- NetworkOwnership
                                    -- Velocity
                                    -- CFrame spam
                                    ------------------------------------------------
                        
                                end)
                            end
                        
                        else
                        
                            ------------------------------------------------
                            -- RESET
                            ------------------------------------------------
                        
                            if m_round(eRoot.Size.X)~=2 then
                        
                                pcall(function()
                        
                                    eRoot.Size=v3(2,2,1)
                                    eRoot.Transparency=1
                                    eRoot.Material=Enum.Material.Plastic
                                    eRoot.Massless=false
                                    eRoot.CanCollide=false
                        
                                end)
                            end
                        end
                    end
                end
            end
        end

        -- =========================================================
        -- WARNING GUI
        -- =========================================================

        local warnGui =
            myRoot:FindFirstChild("KillerWarn")

        if WarnKiller
        and closestKillerDist <= 60 then

            local isChased =
                closestKillerDist <= 40

            local txt =
                isChased and "!!" or "!"

            local col =
                isChased
                and Color3.new(1,0,0)
                or Color3.new(1,0.6,0)

            if not warnGui then

                warnGui =
                    CreateBillboardTag(
                        txt,
                        col,
                        UDim2.new(0,15,0,15),
                        16
                    )

                warnGui.Name = "KillerWarn"
                warnGui.StudsOffset = v3(0,4,0)
                warnGui.Parent = myRoot

            else

                warnGui.Label.Text = txt
                warnGui.Label.TextColor3 = col
            end

        elseif warnGui then

            warnGui:Destroy()
        end

        -- =========================================================
        -- AUTO PARRY
        -- =========================================================
        
        local baseDist =
            tonumber(ParryDistance)
            or 10
        
        local dynamicDist = baseDist
        
        ------------------------------------------------
        -- ADD RUNNING BONUS
        ------------------------------------------------
        
        if isKillerRunning then
            dynamicDist += 2
        end
        
        ------------------------------------------------
        -- ADD PROFILE BONUS
        ------------------------------------------------
        
        local killerProfileBonus = 0
        
        for _,plr in ipairs(players) do
        
            if plr ~= LocalPlayer
            and plr.Team
            and plr.Team.Name:lower():find("killer")
            and plr.Character then
        
                local profile =
                    GetKillerProfile(plr.Character)
        
                if profile
                and profile.BonusDist then
        
                    killerProfileBonus =
                        math.max(
                            killerProfileBonus,
                            profile.BonusDist
                        )
                end
            end
        end
        
        dynamicDist += killerProfileBonus
        
        ------------------------------------------------
        -- AUTO PARRY TRIGGER
        ------------------------------------------------
        
        if AutoParry then
        
            pcall(function()
                TriggerParryDagger()
            end)
        end

        -- =========================================================
        -- REMOTE CACHE
        -- =========================================================

        if not SearchedHBRemotes then

            local remotes =
                ReplicatedStorage:FindFirstChild("Remotes")

            if remotes then

                CachedHBRemotes.DisplayBlood =
                    remotes:FindFirstChild(
                        "DisplayBlood",
                        true
                    )
                    or remotes:FindFirstChild(
                        "BloodEvent",
                        true
                    )

                CachedHBRemotes.FallDamage =
                    remotes:FindFirstChild(
                        "FallDamage",
                        true
                    )

                CachedHBRemotes.HealEvent =
                    remotes:FindFirstChild(
                        "HealEvent",
                        true
                    )
                    or remotes:FindFirstChild(
                        "RequestHeal",
                        true
                    )
                    or remotes:FindFirstChild(
                        "ReviveEvent",
                        true
                    )

                CachedHBRemotes.UnHook =
                    remotes:FindFirstChild(
                        "UnHookEvent",
                        true
                    )
                    or remotes:FindFirstChild(
                        "Unhook",
                        true
                    )
            end

            SearchedHBRemotes = true
        end

        -- =========================================================
        -- ANIMATION LOCK
        -- =========================================================

        local isDoingCriticalAction = false

        for _, track in ipairs(
            myHum:GetPlayingAnimationTracks()
        ) do

            if track.Animation then

                local animName =
                    track.Animation.Name:lower()

                if animName:find("hook")
                or animName:find("grab")
                or animName:find("pickup")
                or animName:find("place") then

                    isDoingCriticalAction = true
                    break
                end
            end
        end

        -- =========================================================
        -- SPEED BOOST + NO SLOWDOWN
        -- =========================================================

        if not isKiller
        and myHum.Health > 0 then

            local isImmobilized =

                IsStatusActive(
                    GetGameValue(myChar, "IsHooked")
                )

                or

                IsStatusActive(
                    GetGameValue(myChar, "Carried")
                )

                or

                myChar:GetAttribute("IsHooked")
                or myChar:GetAttribute("Carried")
                or myChar:GetAttribute("Grabbed")

            if not isImmobilized
            and not isDoingCriticalAction
            and myHum.MoveDirection.Magnitude > 0 then

                local baseTargetSpeed = 17

                local currentWalkSpeed =
                    myHum.WalkSpeed

                local desiredSpeed =
                    currentWalkSpeed

                -- NO SLOWDOWN

                if NoSlowdown
                and currentWalkSpeed < baseTargetSpeed then

                    desiredSpeed = baseTargetSpeed
                end

                -- SPEED BOOST

                if SpeedBoost then

                    local percentValue =
                        tonumber(BoostSpeed) or 0

                    percentValue =
                        math.clamp(percentValue, 0, 150)

                    desiredSpeed =
                        desiredSpeed
                        + (
                            desiredSpeed
                            * (percentValue / 100)
                        )
                end

                -- CFRAME BOOST

                local speedDifference =
                    desiredSpeed - currentWalkSpeed

                if speedDifference > 0 then

                    local cframeOffset =
                        myHum.MoveDirection
                        * (speedDifference * dt)

                    pcall(function()

                        myRoot.CFrame =
                            myRoot.CFrame + cframeOffset

                    end)
                end
            end
        end
        ------------------------------------------------
        -- INSTANT HEAL (REAL INSTANT RECOVERY)
        ------------------------------------------------
        
        if not isKiller
        and InstantHeal
        and myHum.Health>0 then
        
            local lastHeal=getgenv().LastHeal or 0
            local healCooldown=0.45
        
            local healFlags={
                "Injured",
                "Bleeding",
                "Downed",
                "Hurt",
                "Broken",
                "Wounded"
            }
        
            local needHeal=
                myHum.Health<(myHum.MaxHealth-2)
        
            for _,flag in ipairs(healFlags) do
        
                if IsStatusActive(GetGameValue(myChar,flag))
                or myChar:GetAttribute(flag) then
        
                    needHeal=true
                    break
                end
            end
        
            if needHeal
            and (now-lastHeal>healCooldown) then
        
                getgenv().LastHeal=now
        
                ------------------------------------------------
                -- FULL HEAL
                ------------------------------------------------
        
                pcall(function()
                    myHum.Health=myHum.MaxHealth
                end)
        
                ------------------------------------------------
                -- REMOVE INJURED STATES
                ------------------------------------------------
        
                for _,flag in ipairs(healFlags) do
        
                    pcall(function()
        
                        if myChar:GetAttribute(flag)~=nil then
                            myChar:SetAttribute(flag,false)
                        end
        
                        local obj=myChar:FindFirstChild(flag)
        
                        if obj then
        
                            if obj:IsA("BoolValue") then
                                obj.Value=false
        
                            elseif obj:IsA("NumberValue")
                            or obj:IsA("IntValue") then
                                obj.Value=0
                            end
                        end
                    end)
                end
        
                ------------------------------------------------
                -- REMOVE VISUAL EFFECTS
                ------------------------------------------------
        
                for _,v in ipairs(myChar:GetDescendants()) do
        
                    local n=v.Name:lower()
        
                    if n:find("blood")
                    or n:find("injure")
                    or n:find("hurt")
                    or n:find("bleed") then
        
                        if v:IsA("ParticleEmitter")
                        or v:IsA("Trail") then
                            v.Enabled=false
        
                        elseif v:IsA("Highlight") then
                            v:Destroy()
                        end
                    end
                end
        
                ------------------------------------------------
                -- FORCE NORMAL STATE
                ------------------------------------------------
        
                myHum.PlatformStand=false
                myHum.Sit=false
                myHum.AutoRotate=true
        
                local badStates={
                    Enum.HumanoidStateType.Physics,
                    Enum.HumanoidStateType.Ragdoll,
                    Enum.HumanoidStateType.FallingDown
                }
        
                for _,state in ipairs(badStates) do
                    if myHum:GetState()==state then
                        myHum:ChangeState(
                            Enum.HumanoidStateType.GettingUp
                        )
                        break
                    end
                end
        
                task.defer(function()
        
                    pcall(function()
        
                        myHum.WalkSpeed=16
                        myHum.JumpPower=50
        
                        myHum:ChangeState(
                            Enum.HumanoidStateType.Running
                        )
        
                        if myRoot then
                            myRoot.AssemblyLinearVelocity=Vector3.zero
                        end
                    end)
                end)
            end
        end
        
        ------------------------------------------------
        -- ANTI KNOCK (ANTI GRAB / ANTI CARRY)
        ------------------------------------------------
        
        local lastAntiKnock=
            getgenv().LastAntiKnock or 0
        
        local antiKnockCooldown=0.3
        
        local isKnocked=
            IsStatusActive(GetGameValue(myChar,"Knocked"))
            or myChar:GetAttribute("Knocked")
        
        local isCarried=
            IsStatusActive(GetGameValue(myChar,"Carried"))
            or myChar:GetAttribute("Carried")
            or myChar:GetAttribute("Grabbed")
        
        if AntiKnock
        and (isKnocked or isCarried)
        and (now-lastAntiKnock>antiKnockCooldown) then
        
            getgenv().LastAntiKnock=now
        
            ------------------------------------------------
            -- REMOVE STATES
            ------------------------------------------------
        
            local flags={
                "Knocked",
                "Carried",
                "Grabbed",
                "Ragdolled",
                "Captured",
                "Disabled"
            }
        
            for _,flag in ipairs(flags) do
        
                pcall(function()
        
                    if myChar:GetAttribute(flag)~=nil then
                        myChar:SetAttribute(flag,false)
                    end
        
                    local obj=myChar:FindFirstChild(flag)
        
                    if obj then
        
                        if obj:IsA("BoolValue") then
                            obj.Value=false
        
                        elseif obj:IsA("NumberValue")
                        or obj:IsA("IntValue") then
                            obj.Value=0
                        end
                    end
                end)
            end
        
            ------------------------------------------------
            -- FORCE ESCAPE
            ------------------------------------------------
        
            myHum.PlatformStand=false
            myHum.Sit=false
            myHum.AutoRotate=true
        
            local state=myHum:GetState()
        
            if state==Enum.HumanoidStateType.Physics
            or state==Enum.HumanoidStateType.Ragdoll
            or state==Enum.HumanoidStateType.FallingDown
            or state==Enum.HumanoidStateType.PlatformStanding then
        
                myHum:ChangeState(
                    Enum.HumanoidStateType.GettingUp
                )
            end
        
            ------------------------------------------------
            -- RESET VELOCITY
            ------------------------------------------------
        
            task.defer(function()
        
                pcall(function()
        
                    myHum.Health=myHum.MaxHealth
                    myHum.WalkSpeed=16
        
                    if myRoot then
                        myRoot.AssemblyLinearVelocity=Vector3.zero
                    end
        
                    myHum:ChangeState(
                        Enum.HumanoidStateType.Running
                    )
                end)
            end)
        end

        -- =========================================================
        -- AUTO UNHOOK
        -- =========================================================

        if not isKiller
        and AutoUnhook
        and not getgenv().IsUnhooking
        and IsStatusActive(
            GetGameValue(myChar, "IsHooked")
        ) then

            getgenv().IsUnhooking = true

            task.spawn(function()

                local nearestHook = nil
                local shortestDist = 12

                if CachedMapObjects
                and CachedMapObjects.Hooks then

                    for _, hook in ipairs(
                        CachedMapObjects.Hooks
                    ) do

                        local hookPoint =

                            hook:FindFirstChild("HookPoint")
                            or hook.PrimaryPart
                            or hook:FindFirstChildWhichIsA(
                                "BasePart"
                            )

                        if hookPoint then

                            local dist =
                                (
                                    hookPoint.Position
                                    - myRoot.Position
                                ).Magnitude

                            if dist < shortestDist then

                                shortestDist = dist
                                nearestHook = hookPoint
                            end
                        end
                    end
                end

                if nearestHook
                and CachedHBRemotes
                and CachedHBRemotes.UnHook then

                    for i = 1, 5 do

                        if not IsStatusActive(
                            GetGameValue(
                                myChar,
                                "IsHooked"
                            )
                        ) then
                            break
                        end

                        pcall(function()

                            CachedHBRemotes.UnHook:FireServer(
                                nearestHook
                            )

                        end)

                        task.wait(0.2)
                    end
                end

                task.wait(0.8)

                getgenv().IsUnhooking = false

            end)
        end
        -- =========================================================
        -- ANTI BLIND
        -- =========================================================
        
        if AntiBlind then
        
            local lastBlindClean =
                getgenv().LastBlindClean or 0
        
            if now - lastBlindClean > 0.5 then
        
                getgenv().LastBlindClean = now
        
                -- LIGHTING EFFECTS
                for _, effect in ipairs(
                    Lighting:GetChildren()
                ) do
        
                    if effect:IsA("BlurEffect")
                    or effect:IsA("ColorCorrectionEffect")
                    or effect:IsA("SunRaysEffect")
                    or effect:IsA("BloomEffect")
                    or effect:IsA("DepthOfFieldEffect") then
        
                        pcall(function()
                            effect.Enabled = false
                            effect:Destroy()
                        end)
                    end
                end
        
                -- ATMOSPHERE
                local atmosphere =
                    Lighting:FindFirstChildOfClass(
                        "Atmosphere"
                    )
        
                if atmosphere then
        
                    pcall(function()
                        atmosphere:Destroy()
                    end)
                end
        
                -- PLAYER GUI BLIND OVERLAY
                local playerGui =
                    LocalPlayer:FindFirstChildOfClass(
                        "PlayerGui"
                    )
        
                if playerGui then
        
                    for _, gui in ipairs(
                        playerGui:GetDescendants()
                    ) do
        
                        local name =
                            gui.Name:lower()
        
                        if name:find("blind")
                        or name:find("flash")
                        or name:find("white")
                        or name:find("dark")
                        or name:find("fog")
                        or name:find("overlay") then
        
                            pcall(function()
        
                                if gui:IsA("ScreenGui") then
                                    gui.Enabled = false
                                end
        
                                if gui:IsA("ImageLabel")
                                or gui:IsA("Frame") then
        
                                    gui.Visible = false
                                    gui.BackgroundTransparency = 1
                                end
        
                            end)
                        end
                    end
                end
            end
        end
        -- =========================================================
        -- ANTI STUN
        -- =========================================================

        if AntiStun
        and not isDoingCriticalAction
        and IsStatusActive(
            GetGameValue(myChar, "Stunned")
        ) then

            pcall(function()

                myChar:SetAttribute(
                    "Stunned",
                    false
                )

                local stunned =
                    myChar:FindFirstChild(
                        "Stunned"
                    )

                if stunned
                and stunned:IsA("BoolValue") then

                    stunned.Value = false
                end

                if myHum.PlatformStand then
                    myHum.PlatformStand = false
                end

                if myHum.Sit then
                    myHum.Sit = false
                end

            end)
        end

    end)
)
-- =========================================================
-- [ULTIMATE VIP] GOD-AI AUTO FARM V3.0 (SMOOTH & ANTI-STUTTER)
-- =========================================================
local CachedHealEvent = nil
local SearchHealRemote = false

-- Variabel Global Komunikasi Antar Thread
getgenv().AIFinalTarget = nil

-- =========================================================
-- [THREAD 1: OTAK AI] MENCARI TARGET & RUTE (Berjalan Lambat / Hemat RAM)
-- =========================================================
task.spawn(function()
    while task.wait(0.4) do 
        if not getgenv().FORKT_RUNNING then break end
        
        if not AutoFarmBot then 
            getgenv().CachedWaypoints = nil
            getgenv().AIFinalTarget = nil
            continue 
        end 
        
        pcall(function()
            local myChar = LocalPlayer.Character
            local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
            local myHum = myChar and myChar:FindFirstChild("Humanoid")
            
            if not myRoot or not myHum or myHum.Health <= 0 then return end
            
            local team = LocalPlayer.Team and LocalPlayer.Team.Name:lower() or ""
            if team:find("killer") then return end 

            -- [LOGIKA BARU] Jangan kalkulasi jalan jika sedang Digendong atau Di-Hook!
            local function IsImmobilized()
                if GetGameValue(myChar, "IsHooked") or myChar:GetAttribute("IsHooked") then return true end
                if GetGameValue(myChar, "Carried") or GetGameValue(myChar, "Grabbed") or myChar:GetAttribute("Carried") then return true end
                return false
            end
            if IsImmobilized() then 
                getgenv().CachedWaypoints = nil
                getgenv().AIFinalTarget = nil
                return 
            end

            local myPos = myRoot.Position
            local closestKillerDist = 999
            local killerRoot = nil
            local injuredTeammate = nil
            local shortestMateDist = 90

            local players = Players:GetPlayers()
            for _, p in ipairs(players) do
                if p ~= LocalPlayer and p.Character then
                    local eRoot = p.Character:FindFirstChild("HumanoidRootPart")
                    if eRoot then
                        local eTeam = p.Team and p.Team.Name:lower() or ""
                        local dist = (eRoot.Position - myPos).Magnitude

                        if eTeam:find("killer") then
                            if dist < closestKillerDist then
                                closestKillerDist = dist; killerRoot = eRoot
                            end
                        else
                            local isKnocked = GetGameValue(p.Character, "Knocked")
                            local eHum = p.Character:FindFirstChild("Humanoid")
                            local isInjured = eHum and eHum.Health < eHum.MaxHealth
                            
                            if (isKnocked or isInjured) and dist < shortestMateDist then
                                shortestMateDist = dist; injuredTeammate = p.Character
                            end
                        end
                    end
                end
            end

            local completedGens = 0
            local shortestGenDist = 9999
            local bestGenTarget = nil

            if CachedMapObjects and CachedMapObjects.Generators then
                for _, gen in ipairs(CachedMapObjects.Generators) do
                    local progress = GetGameValue(gen, "RepairProgress") or GetGameValue(gen, "Progress") or 0
                    if progress >= 100 then
                        completedGens = completedGens + 1
                    else
                        local genPos = gen:GetPivot().Position
                        local dist = (genPos - myPos).Magnitude
                        if dist < shortestGenDist then
                            shortestGenDist = dist; bestGenTarget = genPos
                        end
                    end
                end
            end

            local targetPos = nil
            local actionState = "Idle"

            -- PRIORITAS 1: Lari dari Killer
            if closestKillerDist <= 70 and killerRoot then
                local maxDistFromKiller = 0
                local bestEscapeTarget = nil
                local killerPos = killerRoot.Position

                local function checkSafeSpot(spot)
                    local spotPos = spot:GetPivot().Position
                    local distFromKiller = (spotPos - killerPos).Magnitude
                    if distFromKiller > maxDistFromKiller then
                        maxDistFromKiller = distFromKiller; bestEscapeTarget = spotPos
                    end
                end

                if CachedMapObjects.Generators then for _, g in ipairs(CachedMapObjects.Generators) do checkSafeSpot(g) end end
                if CachedMapObjects.Gates then for _, g in ipairs(CachedMapObjects.Gates) do checkSafeSpot(g) end end
                
                if bestEscapeTarget then
                    targetPos = bestEscapeTarget
                else
                    local runDir = (myPos - killerPos).Unit
                    targetPos = myPos + (runDir * 50)
                end
                actionState = "Evading"

            -- PRIORITAS 2: Heal Teman
            elseif injuredTeammate then
                targetPos = injuredTeammate.HumanoidRootPart.Position
                actionState = "Healing"
                
                if shortestMateDist <= 12 then
                    if not SearchHealRemote then
                        local remotes = ReplicatedStorage:FindFirstChild("Remotes")
                        CachedHealEvent = remotes and (remotes:FindFirstChild("HealEvent", true) or remotes:FindFirstChild("RequestHeal", true) or remotes:FindFirstChild("ReviveEvent", true))
                        SearchHealRemote = true
                    end

                    if CachedHealEvent then
                        pcall(function() CachedHealEvent:FireServer(injuredTeammate, 100) end)
                        pcall(function() CachedHealEvent:FireServer(injuredTeammate, true) end)
                    end
                    
                    getgenv().CachedWaypoints = nil
                    getgenv().AIFinalTarget = nil
                    if (myHum.WalkToPoint - myPos).Magnitude > 1 then myHum:MoveTo(myPos) end
                    return
                end

            -- PRIORITAS 3: Perbaiki Generator
            elseif completedGens < 5 and bestGenTarget then
                targetPos = bestGenTarget
                actionState = "Repairing"
                
            -- PRIORITAS 4: Lari ke Gerbang
            elseif completedGens >= 5 then
                if CachedMapObjects and CachedMapObjects.Gates then
                    local shortestGate = 9999
                    for _, gate in ipairs(CachedMapObjects.Gates) do
                        local gatePos = gate:GetPivot().Position
                        local dist = (gatePos - myPos).Magnitude
                        if dist < shortestGate then
                            shortestGate = dist; targetPos = gatePos
                        end
                    end
                end
                actionState = "Escaping"
            end
                        -- [SISTEM NOTIFIKASI AI]
            if getgenv().LastAIState ~= actionState then
                getgenv().LastAIState = actionState
                
                local notifIcons = {
                    ["Evading"]   = "lucide:footprints",
                    ["Healing"]   = "lucide:heart-handshake",
                    ["Repairing"] = "lucide:wrench",
                    ["Escaping"]  = "lucide:door-open",
                    ["Idle"]      = "lucide:coffee"
                }
                
                if actionState ~= "Idle" then
                    WindUI:Notify({
                        Title = "AI State: " .. string.upper(actionState),
                        Content = "Mengalihkan rute prioritas AI ke: " .. actionState,
                        Icon = notifIcons[actionState] or "lucide:bot",
                        Duration = 3
                    })
                end
            end
            
            getgenv().AIFinalTarget = targetPos

            -- KALKULASI RUTE (ASYNC)
            if targetPos then
                local now = os.clock()
                local lastPathCalc = getgenv().LastPathCalc or 0
                local lastTargetPos = getgenv().LastTargetPos or v3()
                
                if (targetPos - lastTargetPos).Magnitude > 5 or (now - lastPathCalc > 1.5) then
                    getgenv().LastPathCalc = now
                    getgenv().LastTargetPos = targetPos
                    
                    task.spawn(function()
                        pcall(function()
                            local path = PathfindingService:CreatePath({ 
                                AgentRadius = 2.5,  
                                AgentHeight = 5, 
                                AgentCanJump = true,
                                WaypointSpacing = 4 
                            })
                            path:ComputeAsync(myPos, targetPos)
                            
                            if path.Status == Enum.PathStatus.Success then
                                getgenv().CachedWaypoints = path:GetWaypoints()
                                getgenv().CurrentWaypointIdx = 2 
                            else
                                getgenv().CachedWaypoints = nil
                            end
                        end)
                    end)
                end
            else
                getgenv().CachedWaypoints = nil
                if (myHum.WalkToPoint - myPos).Magnitude > 1 then myHum:MoveTo(myPos) end
            end
        end)
    end
end)

-- =========================================================
-- [THREAD 2: KAKI AI] EKSEKUTOR PERGERAKAN (Berjalan Cepat & Halus)
-- =========================================================
task.spawn(function()
    -- [FIX STUTTER] Berjalan sangat cepat (0.05s) agar saat karakter menyentuh waypoint, langsung lanjut ke waypoint berikutnya tanpa jeda!
    while task.wait(0.05) do
        if not getgenv().FORKT_RUNNING then break end
        if not AutoFarmBot then
            continue
        end
        
        pcall(function()
            local myChar = LocalPlayer.Character
            local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
            local myHum = myChar and myChar:FindFirstChild("Humanoid")
            if not myRoot or not myHum or myHum.Health <= 0 then return end

            local waypoints = getgenv().CachedWaypoints
            local idx = getgenv().CurrentWaypointIdx
            local myPos = myRoot.Position
            
            -- 1. SISTEM BERJALAN MULUS
            if waypoints and idx and idx <= #waypoints then
                local nextPoint = waypoints[idx]
                
                -- [LOGIKA BARU] Kalkulasi jarak 2D (Abaikan sumbu Y) agar bot tidak nyangkut saat melewati tangga atau lereng
                local distToWaypoint = (v3(nextPoint.Position.X, myPos.Y, nextPoint.Position.Z) - myPos).Magnitude
                
                -- Toleransi dilebarkan sedikit (4.5) agar bot bisa memotong tikungan dengan mulus
                if distToWaypoint < 4.5 then
                    getgenv().CurrentWaypointIdx = idx + 1
                    if getgenv().CurrentWaypointIdx <= #waypoints then
                        nextPoint = waypoints[getgenv().CurrentWaypointIdx]
                    end
                end
                
                if nextPoint then
                    myHum:MoveTo(nextPoint.Position)
                    if nextPoint.Action == Enum.PathWaypointAction.Jump then 
                        myHum.Jump = true 
                    end
                end
            elseif getgenv().AIFinalTarget then
                myHum:MoveTo(getgenv().AIFinalTarget)
            end
            
            -- ==========================================
            -- 2. [LOGIKA DEWA] ANTI-STUCK SYSTEM V2
            -- ==========================================
            local nowTime = os.clock()
            local lastBotPos = getgenv().LastBotPos or myPos
            local lastBotTime = getgenv().LastBotTime or nowTime
            
            if getgenv().AIFinalTarget then
                -- Jika dalam 1 detik pergerakan bot kurang dari 0.5 stud (Berarti nabrak tembok/sudut)
                if (myPos - lastBotPos).Magnitude < 0.5 then
                    if nowTime - lastBotTime > 1.0 then
                        myHum.Jump = true
                        myRoot.CFrame = myRoot.CFrame * cnew(math.random(-2, 2), 0, math.random(1, 3))
                        getgenv().LastBotTime = nowTime + 0.5 
                    end
                else
                    getgenv().LastBotPos = myPos
                    getgenv().LastBotTime = nowTime
                end
            end
        end)
    end
end)

-- =========================================================
-- [ULTIMATE VIP] AUTO WIGGLE MASTER V3
-- =========================================================

task.spawn(function()

    local WiggleCache = {
        Remotes = {},
        LastSearch = 0,
        LastFire = 0,
        LastUI = 0,
        IsCaptured = false,
        Toggle = false
    }

    local function IsCaptured()

        local char = LocalPlayer.Character
        if not char then
            return false
        end

        -- ATTRIBUTE CHECK
        local attrs = {
            "Carried",
            "IsCarried",
            "Grabbed",
            "Wiggling",
            "Captured"
        }

        for _, attr in ipairs(attrs) do

            if char:GetAttribute(attr)
            or IsStatusActive(GetGameValue(char, attr)) then

                return true
            end
        end

        -- UI CHECK (THROTTLED)
        if tick() - WiggleCache.LastUI > 1 then

            WiggleCache.LastUI = tick()

            local pGui =
                LocalPlayer:FindFirstChildOfClass("PlayerGui")

            if pGui then

                for _, gui in ipairs(pGui:GetChildren()) do

                    if gui:IsA("ScreenGui")
                    and gui.Enabled then

                        local n = gui.Name:lower()

                        if n:find("wiggle")
                        or n:find("struggle")
                        or n:find("escape") then

                            return true
                        end
                    end
                end
            end
        end

        return false
    end

    local function RefreshWiggleRemotes()

        if tick() - WiggleCache.LastSearch < 10 then
            return
        end

        WiggleCache.LastSearch = tick()
        table.clear(WiggleCache.Remotes)

        local remotesFolder =
            ReplicatedStorage:FindFirstChild("Remotes")

        if not remotesFolder then
            return
        end

        for _, obj in ipairs(remotesFolder:GetDescendants()) do

            if obj:IsA("RemoteEvent") then

                local n = obj.Name:lower()

                -- PRIORITY FILTER
                if n:find("wiggle")
                or n:find("struggle")
                or n:find("escape") then

                    t_insert(WiggleCache.Remotes, {
                        Remote = obj,
                        Type = "wiggle"
                    })

                elseif n:find("skillcheck") then

                    t_insert(WiggleCache.Remotes, {
                        Remote = obj,
                        Type = "skillcheck"
                    })
                end
            end
        end
    end

    while task.wait(0.08) do

        if not getgenv().FORKT_RUNNING then
            break
        end

        if not AutoWiggle then
            continue
        end

        local char = LocalPlayer.Character

        if not char then
            continue
        end

        local captured = IsCaptured()

        if not captured then
            WiggleCache.IsCaptured = false
            continue
        end

        WiggleCache.IsCaptured = true

        RefreshWiggleRemotes()

        -- HUMANIZED TIMING
        local now = tick()

        if now - WiggleCache.LastFire < 0.22 then
            continue
        end

        WiggleCache.LastFire = now
        WiggleCache.Toggle = not WiggleCache.Toggle

        local dirString =
            WiggleCache.Toggle and "Left" or "Right"

        local dirNumber =
            WiggleCache.Toggle and 1 or -1

        -- FIRE ONLY FEW REMOTES
        for i = 1, math.min(2, #WiggleCache.Remotes) do

            local data = WiggleCache.Remotes[i]

            if not data
            or not data.Remote
            or not data.Remote.Parent then
                continue
            end

            local remote = data.Remote

            pcall(function()

                if data.Type == "skillcheck" then

                    remote:FireServer("perfect")

                else

                    -- ROTATING PAYLOAD
                    local mode =
                        (i + math.floor(now * 10)) % 4

                    if mode == 0 then
                        remote:FireServer(true)

                    elseif mode == 1 then
                        remote:FireServer(dirString)

                    elseif mode == 2 then
                        remote:FireServer(dirNumber)

                    else
                        remote:FireServer()
                    end
                end
            end)
        end
    end
end)
-- =========================================================
-- EKSEKUSI WIPER & SPEED SYNC SETIAP KALI RESPAWN
-- =========================================================
t_insert(getgenv().FORKT_CONNECTIONS, LocalPlayer.CharacterAdded:Connect(function(char)
    -- Pastikan kita langsung menargetkan Humanoid milik karakter yang baru spawn
    local hum = char:WaitForChild("Humanoid", 5)
    if hum and SpeedBoost then 
        -- [FIX] Gunakan rumus persentase agar tidak instant-ban saat respawn!
        local baseSpeed = 17
        local percentValue = tonumber(BoostSpeed) or 0
        
        hum.WalkSpeed = baseSpeed + (
            baseSpeed * (percentValue / 100)
        )
    end
end))
-- =========================================================
-- [ANTI-MEMORY LEAK] PEMBERSIH CACHE OTOMATIS
-- =========================================================
t_insert(getgenv().FORKT_CONNECTIONS, Players.PlayerRemoving:Connect(function(player)
    -- Bersihkan data pemain yang keluar dari ingatan skrip
    if ESP_PlayerCache and ESP_PlayerCache[player.UserId] then
        ESP_PlayerCache[player.UserId] = nil
    end
    
    -- [TAMBAHAN] Hapus UI ESP jika nyangkut
    if player.Character then
        local root = player.Character:FindFirstChild("HumanoidRootPart")
        if root then
            local tag = root:FindFirstChild("TagESP")
            if tag then tag:Destroy() end
        end
    end
end))
local n = WindUI:Notify({ 
    Title = "Welcome to FORKT-HUB!", 
    Content = "God-AI Systems Initialized.\n💻 PC User: Press [Keybind K] to open/hide the UI.", 
    Duration = 10,
    CanClose = false,
    Icon = "lucide:sparkles" 
})
WindUI:SetNotificationLower(true)
task.wait(4.5)
n:Close()