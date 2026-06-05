-- [[ SAFE SERVICE RESOLUTION CORES ]]
local function getService(serviceName)
    local success, res = pcall(function() 
        return cloneref(game:GetService(serviceName)) 
    end)
    if success and res then return res end
    local regularSuccess, regularRes = pcall(function() return game:GetService(serviceName) end)
    if regularSuccess then return regularRes end
    return nil
end

local Workspace = getService("Workspace")
local RunService = getService("RunService")
local Players = getService("Players")
local TweenService = getService("TweenService")
local UserInputService = getService("UserInputService")
local Stats = getService("Stats")
local Debris = getService("Debris") or game:GetService("Debris")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

-- [[ INITIALIZE RADICAL GLOBAL VALUES ]]
getgenv().Colors = getgenv().Colors or {
    Accent = Color3.fromRGB(255, 0, 40),      
    AccentMuted = Color3.fromRGB(98, 3, 10),   
    Background = Color3.fromRGB(0, 0, 0),
    TextPrimary = Color3.fromRGB(245, 245, 245),
    TextSecondary = Color3.fromRGB(240, 240, 240)
}

getgenv().BleedSettings = getgenv().BleedSettings or {
    PredictionMode = "Standard", 
    StandardDelayCoefficient = 0.00155, 
    StandardDelayCoefficientY = 0.00118, 
    ZeroDelayValue = 0.035,
    ZeroDelayValueY = 0.026, 
    PredictionX = 0.1,       
    PredictionY = 0.1,       
    WallCheck = false,          
    ResolverActive = true,
    MaxRealisticVelocity = 120,          
    AntiGroundShot = true,
    MinHeightAboveGround = 2.5,          
    JumpOffset = 0,            
    FallOffset = 0,
    TargetPart = "HumanoidRootPart",
    PriorityTarget = "None"
}

getgenv().ESP = getgenv().ESP or {
    Enabled = false, 
    MaxDistance = 500, 
    FontSize = 11,
    FadeOut = { OnDistance = true },
    Options = { Friendcheck = true },
    Drawing = {
        Chams = { Enabled = true, Thermal = true, FillRGB = getgenv().Colors.Accent, Fill_Transparency = 100, OutlineRGB = getgenv().Colors.Accent, Outline_Transparency = 100, VisibleCheck = true },
        Names = { Enabled = true },
        Distances = { Position = "Text" },
        Weapons = { Enabled = true, Gradient = false, GradientRGB1 = getgenv().Colors.TextPrimary, GradientRGB2 = getgenv().Colors.Accent },
        Healthbar = { Enabled = true, HealthText = true, Gradient = true, Width = 2.5, GradientRGB1 = Color3.fromRGB(200, 0, 0), GradientRGB2 = getgenv().Colors.AccentMuted, GradientRGB3 = getgenv().Colors.Accent },
        Boxes = { Animate = true, RotationSpeed = 300, Gradient = false, GradientRGB1 = getgenv().Colors.Accent, GradientRGB2 = getgenv().Colors.Background, GradientFill = true, GradientFillRGB1 = getgenv().Colors.Accent, GradientFillRGB2 = getgenv().Colors.Background, Filled = { Enabled = true, Transparency = 0.75 }, Full = { Enabled = true }, Corner = { Enabled = true } }
    }
}

-- [[ AUDIO SYSTEM REGISTRY ]]
local hitsounds = {
    ["None"]               = "",
    ["Rust Headshot"]      = "rbxassetid://138750331387064",
    ["Neverlose"]          = "rbxassetid://110168723447153",
    ["Bubble"]             = "rbxassetid://6534947588",
    ["Laser"]              = "rbxassetid://7837461331",
    ["Steve"]              = "rbxassetid://4965083997",
    ["Call of Duty"]       = "rbxassetid://5952120301",
    ["Bat"]                = "rbxassetid://3333907347",
    ["TF2 Critical"]       = "rbxassetid://296102734",
    ["Saber"]              = "rbxassetid://8415678813",
    ["Bameware"]           = "rbxassetid://3124331820",
    ["Money"]              = "rbxassetid://13956013041",
    ["Notif"]              = "rbxassetid://6696469190",
    ["Shutter"]            = "rbxassetid://10066921516",
    ["RIFK7"]              = "rbxassetid://9102080552",
    ["LazerBeam"]          = "rbxassetid://130791043",
    ["WindowsXPError"]     = "rbxassetid://160715357",
    ["TF2Hitsound"]        = "rbxassetid://3455144981",
    ["BowHit"]             = "rbxassetid://1053296915",
    ["OSU"]                = "rbxassetid://7147454322",
    ["Rust"]               = "rbxassetid://6565371338",
    ["Mario"]              = "rbxassetid://5709456554",
    ["Bell"]               = "rbxassetid://6534947240",
    ["Pop"]                = "rbxassetid://198598793",
    ["Sans"]               = "rbxassetid://3188795283",
    ["Vine"]               = "rbxassetid://5332680810",
    ["Bruh"]               = "rbxassetid://4578740568",
    ["Skeet"]              = "rbxassetid://5633695679",
    ["Fatality"]           = "rbxassetid://6534947869",
    ["Bonk"]               = "rbxassetid://5766898159",
    ["Minecraft"]          = "8415678813",
    ["Gamesense"]          = "rbxassetid://4817809188",
    ["Blood SFX"]          = "rbxassetid://8164951181",
    ["Blood Burst"]        = "rbxassetid://3781479909",
    ["Blood Hit"]          = "rbxassetid://429400881",
}

local selectedHitSound = "None"
local function playHitSound()
    local assetId = hitsounds[selectedHitSound]
    if assetId and assetId ~= "" then
        local soundObj = Instance.new("Sound")
        soundObj.SoundId = assetId
        soundObj.Volume = 1.5
        soundObj.Parent = Workspace
        soundObj:Play()
        Debris:AddItem(soundObj, 2)
    end
end

-- [[ LOAD LINORIA LIB INITIAL STAGES ]]
local repo = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"
local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()

local Options = Library.Options
local Toggles = Library.Toggles

local Window = Library:CreateWindow({
	Title = "bleed.cc Engine integration",
	Footer = "Architecture: LinoriaLib Fixed Framework",
	Icon = 95816097006870,
	NotifySide = "Right",
	ShowCustomCursor = true,
})

-- [[ LAYOUT MATRIX TAB SETTINGS ]]
local Tabs = {
	Main = Window:AddTab("Main", "crosshair"),
    Visuals = Window:AddTab("Visuals", "eye"),
    Misc = Window:AddTab("Misc", "sliders"),
	["UI Settings"] = Window:AddTab("UI Settings", "settings"),
}

-- [[ CORE SYSTEM INTERNAL UTILITY ENGINES ]]
local UIBuilder = {}
function UIBuilder:FadeOutOnDist(element, distance)
    local transparency = math.max(0.1, 1 - (distance / getgenv().ESP.MaxDistance))
    if element:IsA("TextLabel") then element.TextTransparency = 1 - transparency
    elseif element:IsA("ImageLabel") then element.ImageTransparency = 1 - transparency
    elseif element:IsA("UIStroke") then element.Transparency = 1 - transparency
    elseif element:IsA("Frame") then element.BackgroundTransparency = 1 - transparency
    elseif element:IsA("Highlight") then element.FillTransparency = 1 - transparency element.OutlineTransparency = 1 - transparency end
end

local function checkVisibility(targetChar)
    if not targetChar then return false end
    local targetPart = targetChar:FindFirstChild(getgenv().BleedSettings.TargetPart) or targetChar:FindFirstChild("HumanoidRootPart")
    if not targetPart then return false end
    
    local myChar = LocalPlayer.Character
    if not myChar then return false end
    
    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude
    raycastParams.FilterDescendantsInstances = {myChar, Camera}
    raycastParams.IgnoreWater = true
    
    local origin = Camera.CFrame.Position
    local targetPos = targetPart.Position
    local direction = targetPos - origin
    
    local result = Workspace:Raycast(origin, direction, raycastParams)
    if result then return result.Instance:IsDescendantOf(targetChar) end
    return true
end

local isLocked = false
local targetEntity = nil

local function getClosestTargetToCenter()
    local closestTarget = nil
    local shortestDistance = math.huge
    local viewportCenter = Camera.ViewportSize / 2
    local candidates = {}
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            table.insert(candidates, { Character = player.Character, DisplayName = player.DisplayName, IsPlayer = true, Player = player })
        end
    end
    
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("Model") and obj ~= LocalPlayer.Character then
            if obj:FindFirstChild("HumanoidRootPart") and obj:FindFirstChildOfClass("Humanoid") then
                if not Players:GetPlayerFromCharacter(obj) then
                    table.insert(candidates, { Character = obj, DisplayName = "[BOT] " .. obj.Name, IsPlayer = false })
                end
            end
        end
    end
    
    local priorityName = getgenv().BleedSettings.PriorityTarget
    if priorityName and priorityName ~= "None" then
        for _, target in ipairs(candidates) do
            if target.IsPlayer and target.DisplayName == priorityName then
                if target.Character and (target.Character:FindFirstChild(getgenv().BleedSettings.TargetPart) or target.Character:FindFirstChild("HumanoidRootPart")) then
                    return target
                end
            end
        end
    end

    for _, target in ipairs(candidates) do
        local part = target.Character:FindFirstChild(getgenv().BleedSettings.TargetPart) or target.Character.HumanoidRootPart
        local screenPos, onScreen = Camera:WorldToViewportPoint(part.Position)
        if onScreen then
            local isVisible = not getgenv().BleedSettings.WallCheck or checkVisibility(target.Character)
            if isVisible then
                local distance = (Vector2.new(screenPos.X, screenPos.Y) - viewportCenter).Magnitude
                if distance < shortestDistance then 
                    shortestDistance = distance 
                    closestTarget = target 
                end
            end
        end
    end
    return closestTarget
end

local trackedVelocity = Vector3.new()
local currentTrackedEntity = nil

local function calculatePrediction(targetChar, isPlayer)
    if not targetChar then return nil end
    local corePart = targetChar:FindFirstChild(getgenv().BleedSettings.TargetPart) or targetChar:FindFirstChild("HumanoidRootPart")
    if not corePart then return nil end
    
    local humanoid = targetChar:FindFirstChildOfClass("Humanoid")
    local currentPosition = corePart.Position
    
    if currentTrackedEntity ~= targetChar then
        currentTrackedEntity = targetChar
        trackedVelocity = corePart.AssemblyLinearVelocity or corePart.Velocity or Vector3.new()
    else
        local rawVelocity = corePart.AssemblyLinearVelocity or corePart.Velocity or Vector3.new()
        trackedVelocity = trackedVelocity:Lerp(rawVelocity, 0.22)
    end
    
    local velocity = trackedVelocity
    local scaleX = getgenv().BleedSettings.PredictionX
    local scaleY = getgenv().BleedSettings.PredictionY
    
    if getgenv().BleedSettings.ResolverActive then
        if humanoid and humanoid.MoveDirection.Magnitude > 0 then
            velocity = humanoid.MoveDirection * (humanoid.WalkSpeed or 16)
        else
            velocity = Vector3.new(0, 0, 0)
        end
        if math.abs(velocity.Y) > 60 then velocity = Vector3.new(velocity.X, 0, velocity.Z) end
    end
    
    local PredPos = currentPosition + (velocity * Vector3.new(scaleX, scaleY, scaleX))
    
    if humanoid and (humanoid.FloorMaterial == Enum.Material.Air or humanoid:GetState() == Enum.HumanoidStateType.Freefall or humanoid:GetState() == Enum.HumanoidStateType.Jumping) then
        local jumpOffset = tonumber(getgenv().BleedSettings.JumpOffset) or 0
        local fallOffset = tonumber(getgenv().BleedSettings.FallOffset) or 0
        if velocity.Y > 0 then PredPos = PredPos + Vector3.new(0, jumpOffset, 0) else PredPos = PredPos + Vector3.new(0, fallOffset, 0) end
    end
    
    if getgenv().BleedSettings.AntiGroundShot then
        local raycastParams = RaycastParams.new()
        raycastParams.FilterType = Enum.RaycastFilterType.Exclude
        raycastParams.FilterDescendantsInstances = {targetChar, LocalPlayer.Character, Camera}
        raycastParams.IgnoreWater = true
        
        local rayOrigin = PredPos + Vector3.new(0, 5, 0)
        local rayDirection = Vector3.new(0, -15, 0)
        local raycastResult = Workspace:Raycast(rayOrigin, rayDirection, raycastParams)
        
        if raycastResult then
            local minHeight = getgenv().BleedSettings.MinHeightAboveGround or 2.5
            local floorLevelY = raycastResult.Position.Y
            local currentDeltaFloor = PredPos.Y - floorLevelY
            
            if currentDeltaFloor < minHeight then
                PredPos = Vector3.new(PredPos.X, floorLevelY + minHeight, PredPos.Z)
            end
        end
    end
    
    return PredPos
end

-- [[ ENGINE VISUALIZER CORE INTERFACE MANAGEMENT ]]
local activeESP = nil
local gethui = gethui or function() return nil end
local coreGui = pcall(function() return game:GetService("CoreGui") end) and game:GetService("CoreGui")
local UIParent = gethui() or coreGui or LocalPlayer:WaitForChild("PlayerGui", 5)

-- FIXED: Standard Luau layout instantiation instead of dictionary property assignment
local ESPHolderGui = Instance.new("ScreenGui")
ESPHolderGui.Parent = UIParent
ESPHolderGui.Name = "UniversalTargetESPHolder"

local function clearTargetESP()
    if activeESP then activeESP.Container:Destroy() activeESP = nil end
end

local function buildTargetESP(char)
    clearTargetESP()
    
    -- FIXED: Standard implementation
    local Container = Instance.new("Folder")
    Container.Name = "ActiveTargetStructure"
    Container.Parent = ESPHolderGui
    
    local elements = {
        Container = Container,
        Name = Instance.new("TextLabel"), Distance = Instance.new("TextLabel"), Weapon = Instance.new("TextLabel"),
        Box = Instance.new("Frame"), Healthbar = Instance.new("Frame"), BehindHealthbar = Instance.new("Frame"),
        HealthText = Instance.new("TextLabel"), Chams = Instance.new("Highlight"), WeaponIcon = Instance.new("ImageLabel"),
        LeftTop = Instance.new("Frame"), LeftSide = Instance.new("Frame"), RightTop = Instance.new("Frame"),
        RightSide = Instance.new("Frame"), BottomSide = Instance.new("Frame"), BottomDown = Instance.new("Frame"),
        BottomRightSide = Instance.new("Frame"), BottomRightDown = Instance.new("Frame"),
        Flag1 = Instance.new("TextLabel"), Flag2 = Instance.new("TextLabel")
    }

    for name, ins in pairs(elements) do
        if name ~= "Container" then
            ins.Parent = Container
            if ins:IsA("TextLabel") then
                ins.AnchorPoint = Vector2.new(0.5, 0.5)
                ins.BackgroundTransparency = 1
                ins.TextColor3 = getgenv().Colors.TextPrimary
                ins.Font = Enum.Font.Code
                ins.TextSize = getgenv().ESP.FontSize
                ins.TextStrokeTransparency = 0
                ins.TextStrokeColor3 = getgenv().Colors.Background
                ins.RichText = true
            elseif ins:IsA("Frame") and name ~= "Box" then
                ins.BorderSizePixel = 0
                ins.BackgroundColor3 = getgenv().Colors.Accent
            end
        end
    end

    elements.Box.BackgroundColor3 = getgenv().Colors.Background
    elements.Box.BackgroundTransparency = 0.75
    elements.Box.BorderSizePixel = 0

    elements.Chams.FillTransparency = 1
    elements.Chams.OutlineTransparency = 0
    elements.Chams.OutlineColor = getgenv().Colors.Accent
    elements.Chams.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop

    -- FIXED: Refactored dictionary injection format inside standard Instance configurations
    elements.Gradient1 = Instance.new("UIGradient")
    elements.Gradient1.Parent = elements.Box
    elements.Gradient1.Enabled = getgenv().ESP.Drawing.Boxes.GradientFill
    elements.Gradient1.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, getgenv().ESP.Drawing.Boxes.GradientFillRGB1 or getgenv().Colors.Accent), ColorSequenceKeypoint.new(1, getgenv().ESP.Drawing.Boxes.GradientFillRGB2 or getgenv().Colors.Background)}

    elements.Outline = Instance.new("UIStroke")
    elements.Outline.Parent = elements.Box
    elements.Outline.Enabled = getgenv().ESP.Drawing.Boxes.Gradient
    elements.Outline.Transparency = 0
    elements.Outline.Color = getgenv().Colors.TextPrimary
    elements.Outline.LineJoinMode = Enum.LineJoinMode.Miter

    elements.Gradient2 = Instance.new("UIGradient")
    elements.Gradient2.Parent = elements.Outline
    elements.Gradient2.Enabled = getgenv().ESP.Drawing.Boxes.Gradient
    elements.Gradient2.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, getgenv().Colors.Accent), ColorSequenceKeypoint.new(1, getgenv().Colors.Background)}

    elements.HealthbarGradient = Instance.new("UIGradient")
    elements.HealthbarGradient.Parent = elements.Healthbar
    elements.HealthbarGradient.Enabled = getgenv().ESP.Drawing.Healthbar.Gradient
    elements.HealthbarGradient.Rotation = -90
    elements.HealthbarGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, getgenv().ESP.Drawing.Healthbar.GradientRGB1), ColorSequenceKeypoint.new(0.5, getgenv().ESP.Drawing.Healthbar.GradientRGB2), ColorSequenceKeypoint.new(1, getgenv().ESP.Drawing.Healthbar.GradientRGB3)}
    
    activeESP = elements
end

local function hideActiveElements()
    if not activeESP then return end local ae = activeESP
    ae.Box.Visible = false; ae.Name.Visible = false; ae.Distance.Visible = false; ae.Weapon.Visible = false; ae.Healthbar.Visible = false; ae.BehindHealthbar.Visible = false; ae.HealthText.Visible = false; ae.WeaponIcon.Visible = false; ae.LeftTop.Visible = false; ae.LeftSide.Visible = false; ae.BottomSide.Visible = false; ae.BottomDown.Visible = false; ae.RightTop.Visible = false; ae.RightSide.Visible = false; ae.BottomRightSide.Visible = false; ae.BottomRightDown.Visible = false; ae.Flag1.Visible = false; ae.Chams.Enabled = false; ae.Flag2.Visible = false
end

-- [[ BUILD INTERFACE TABS SECTION ]]

-- ==================== MAIN TAB ====================
local LockGroup = Tabs.Main:AddLeftGroupbox("Target Lock Control")

LockGroup:AddToggle("MasterLock", {
    Text = "Enable Tracking Engine",
    Default = false,
    Tooltip = "Engages system tracking calculations targeting players inside the current instance.",
    Callback = function(Value)
        isLocked = Value
        if isLocked then
            targetEntity = getClosestTargetToCenter()
            if targetEntity then
                Library:Notify("Locked tracking sequence to: " .. targetEntity.DisplayName)
                playHitSound()
            else
                Toggles.MasterLock:SetValue(false)
                Library:Notify("Scan operation failed: No prospective entities visible.")
            end
        else
            targetEntity = nil
            clearTargetESP()
        end
    end
}):AddKeyPicker("LockBind", { Default = "E", SyncToggleState = true, Mode = "Toggle", Text = "Target Lock Activation Key" })

LockGroup:AddDropdown("TargetPartSelection", {
    Values = {"HumanoidRootPart", "Head", "UpperTorso", "LowerTorso"},
    Default = 1,
    Multi = false,
    Text = "Target Hitpart Focus",
    Callback = function(Value)
        getgenv().BleedSettings.TargetPart = Value
    end
})

LockGroup:AddToggle("WallCheckActive", {
    Text = "Enable Wall Check",
    Default = false,
    Callback = function(Value) getgenv().BleedSettings.WallCheck = Value end
})

LockGroup:AddToggle("ResolverActiveToggle", {
    Text = "Enable MoveDirection Resolver",
    Default = true,
    Callback = function(Value) getgenv().BleedSettings.ResolverActive = Value end
})

-- Dynamic Runtime Priority Registry Dropdown
local priorityDropdown = LockGroup:AddDropdown("PriorityPlayerSelection", {
    Values = {"None"},
    Default = 1,
    Multi = false,
    Text = "Priority Target Allocation",
    Callback = function(Value)
        getgenv().BleedSettings.PriorityTarget = Value
    end
})

LockGroup:AddButton({
    Text = "Refresh Client Lists",
    Func = function()
        local pool = {"None"}
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer then table.insert(pool, p.DisplayName) end
        end
        priorityDropdown:SetValues(pool)
    end
})

-- MAIN TAB RIGHT SIDE: PREDICTION MATH PARAMETERS
local PredGroup = Tabs.Main:AddRightGroupbox("Physics & Prediction Parameters")

PredGroup:AddDropdown("PredCalibMode", {
    Values = {"Standard", "Zero-Delay Mode"},
    Default = 1,
    Multi = false,
    Text = "Prediction Algorithm Mode",
    Callback = function(Value) getgenv().BleedSettings.PredictionMode = (Value == "Zero-Delay Mode") and "Zero-Delay" or "Standard" end
})

PredGroup:AddToggle("AutoPredictionEngine", {
    Text = "Enable Live Ping Calibration",
    Default = false,
    Tooltip = "Automatically overwrites manual latency calculation adjustments based on ping telemetry data."
})

PredGroup:AddInput("ManualXField", {
    Default = "0.1",
    Numeric = true,
    Finished = true,
    Text = "Manual Latitude Prediction (X Axis)",
    Callback = function(Value)
        if not Toggles.AutoPredictionEngine.Value then getgenv().BleedSettings.PredictionX = tonumber(Value) or 0.1 end
    end
})

PredGroup:AddInput("ManualYField", {
    Default = "0.1",
    Numeric = true,
    Finished = true,
    Text = "Manual Altitude Prediction (Y Axis)",
    Callback = function(Value)
        if not Toggles.AutoPredictionEngine.Value then getgenv().BleedSettings.PredictionY = tonumber(Value) or 0.1 end
    end
})

PredGroup:AddDivider()

PredGroup:AddToggle("AntiGroundShotActive", {
    Text = "Prevent Ground Collision (Anti-Ground Shot)",
    Default = true,
    Callback = function(Value) getgenv().BleedSettings.AntiGroundShot = Value end
})

PredGroup:AddSlider("GroundDeltaMin", {
    Text = "Minimum Safe Ground Offset",
    Default = 2.5, Min = 1, Max = 10, Rounding = 1,
    Callback = function(Value) getgenv().BleedSettings.MinHeightAboveGround = Value end
})


-- ==================== VISUALS TAB ====================
local EspGroup = Tabs.Visuals:AddLeftGroupbox("Visualizer Core Overlay")

EspGroup:AddToggle("GlobalEspToggle", {
    Text = "Enable Target Visualizer (ESP)",
    Default = false,
    Callback = function(Value) 
        getgenv().ESP.Enabled = Value 
        if not Value then clearTargetESP() end
    end
})

EspGroup:AddSlider("EspDistanceCutoff", {
    Text = "Maximum Draw Distance Boundary",
    Default = 500, Min = 50, Max = 2500, Rounding = 0,
    Callback = function(Value) getgenv().ESP.MaxDistance = Value end
})

EspGroup:AddToggle("EspDrawNames", {
    Text = "Render Identifier Tags (Names)",
    Default = true,
    Callback = function(Value) getgenv().ESP.Drawing.Names.Enabled = Value end
})

EspGroup:AddDropdown("EspDistLabelMode", {
    Values = {"Text Profile Layout", "Bottom Frame Standard Alignment"},
    Default = 1,
    Text = "Distance Metrics Layout Style",
    Callback = function(Value) getgenv().ESP.Drawing.Distances.Position = (Value == "Text Profile Layout") and "Text" or "Bottom" end
})

EspGroup:AddToggle("EspBoxFull", {
    Text = "Draw Complete Bounding Boxes",
    Default = true,
    Callback = function(Value) getgenv().ESP.Drawing.Boxes.Full.Enabled = Value end
})

EspGroup:AddToggle("EspBoxCorners", {
    Text = "Render Structural Corner Framing",
    Default = true,
    Callback = function(Value) getgenv().ESP.Drawing.Boxes.Corner.Enabled = Value end
})

EspGroup:AddToggle("EspBoxAnimate", {
    Text = "Enable Box Gradient Alternations",
    Default = true,
    Callback = function(Value) getgenv().ESP.Drawing.Boxes.Animate = Value end
})

-- VISUALS RIGHT SIDE: CHAMS SETTINGS
local ChamGroup = Tabs.Visuals:AddRightGroupbox("Direct Depth Interception Chams")

ChamGroup:AddToggle("ChamActiveToggle", {
    Text = "Render Chams Architecture",
    Default = true,
    Callback = function(Value) getgenv().ESP.Drawing.Chams.Enabled = Value end
})

ChamGroup:AddToggle("ChamThermalModulation", {
    Text = "Apply Thermal Breathe Modulation Effects",
    Default = true,
    Callback = function(Value) getgenv().ESP.Drawing.Chams.Thermal = Value end
})

ChamGroup:AddToggle("ChamOccludeVisibility", {
    Text = "Apply Obstruction Occlusion Filters",
    Default = true,
    Callback = function(Value) getgenv().ESP.Drawing.Chams.VisibleCheck = Value end
})


-- ==================== MISC TAB ====================
local MiscGroup = Tabs.Misc:AddLeftGroupbox("Audio Verification System")

local soundList = {}
for name, _ in pairs(hitsounds) do table.insert(soundList, name) end
table.sort(soundList)

MiscGroup:AddDropdown("HitSoundSelected", {
    Values = soundList,
    Default = 1,
    Multi = false,
    Text = "Verification Audio Track",
    Callback = function(Value) selectedHitSound = Value end
})

MiscGroup:AddButton({
    Text = "Execute Test Audio Sample",
    Func = function() playHitSound() end
})


-- [[ LOAD STANDARD SYSTEM COMPONENT MANAGER SECTIONS ]]
local MenuGroup = Tabs["UI Settings"]:AddLeftGroupbox("Menu Settings Config")
MenuGroup:AddToggle("KeybindMenuOpen", { Default = Library.KeybindFrame.Visible, Text = "Open Keybind Menu", Callback = function(value) Library.KeybindFrame.Visible = value end })
MenuGroup:AddLabel("Menu bind"):AddKeyPicker("MenuKeybind", { Default = "RightShift", NoUI = true, Text = "Menu keybind" })
Library.ToggleKeybind = Options.MenuKeybind

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ "MenuKeybind" })
ThemeManager:SetFolder("BleedEngineHub")
SaveManager:SetFolder("BleedEngineHub/TargetLockConfigs")
SaveManager:BuildConfigSection(Tabs["UI Settings"])
ThemeManager:ApplyToTab(Tabs["UI Settings"])
SaveManager:LoadAutoloadConfig()


-- [[ ENGINE OPERATIONAL RUNTIME RUNLOOPS ]]
local function generateRandomString(length)
    local s = "" for i = 1, length do s = s .. string.char(math.random(33, 126)) end return s
end

local function generatePredictionsFromPing(pingValue)
    local basePing = pingValue - (pingValue % 100)
    local standardPredictions = "-- [ STANDARD DELAY PREDICTIONS ] --\n"
    local zeroDelayPredictions = "-- [ 0-DELAY PREDICTIONS ] --\n"
    
    for pingMin = basePing, basePing + 100, 10 do
        local averagePing = (pingMin + (pingMin + 10)) / 2
        local standardVal = (averagePing * getgenv().BleedSettings.StandardDelayCoefficient) + (math.random(-5, 5) / 10000)
        standardPredictions = standardPredictions .. string.format("ping%d_%d = %.4f,\n", pingMin, pingMin + 10, standardVal)
        local zeroVal = getgenv().BleedSettings.ZeroDelayValue + (math.random(-2, 2) / 10000)
        zeroDelayPredictions = zeroDelayPredictions .. string.format("ping%d_%d = %.4f,\n", pingMin, pingMin + 10, zeroVal)
    end
    
    return string.format(
        "-- Prediction Profiles\n-- Target Ping: %dms\n-- Generated: %s\n-- Hash: %s\n\n%s\n%s",
        pingValue, os.date("%Y-%m-%d %H:%M:%S"), generateRandomString(12), standardPredictions:sub(1, -2), zeroDelayPredictions:sub(1, -2)
    )
end

-- Telemetry Analysis Calibration Task Loop
task.spawn(function()
    while true do
        local currentPing = 100
        pcall(function()
            local networkItem = Stats and Stats:FindFirstChild("Network")
            local serverStats = networkItem and networkItem:FindFirstChild("ServerStatsItem")
            local pingItem = serverStats and serverStats:FindFirstChild("Data Ping")
            if pingItem then
                local parsedPing = tonumber(pingItem:GetValueString():match("%d+"))
                if parsedPing then currentPing = parsedPing end
            end
        end)
        
        pcall(function() if writefile then writefile("prediction_values.txt", generatePredictionsFromPing(currentPing)) end end)
        
        if Toggles.AutoPredictionEngine and Toggles.AutoPredictionEngine.Value then
            local liveStandardX = (currentPing * getgenv().BleedSettings.StandardDelayCoefficient)
            local liveStandardY = (currentPing * getgenv().BleedSettings.StandardDelayCoefficientY)
            local resolvedCalculatedX = (getgenv().BleedSettings.PredictionMode == "Standard") and liveStandardX or getgenv().BleedSettings.ZeroDelayValue
            local resolvedCalculatedY = (getgenv().BleedSettings.PredictionMode == "Standard") and liveStandardY or getgenv().BleedSettings.ZeroDelayValueY
            
            getgenv().BleedSettings.PredictionX = resolvedCalculatedX
            getgenv().BleedSettings.PredictionY = resolvedCalculatedY
            
            if Options.ManualXField and Options.ManualYField then
                Options.ManualXField:SetValue(string.format("%.5f", resolvedCalculatedX))
                Options.ManualYField:SetValue(string.format("%.5f", resolvedCalculatedY))
            end
        end
        task.wait(3) 
    end
end)

-- Main Structural Frame Update Core Operations Loop
local RotationAngle, Tick = -45, tick()

RunService.RenderStepped:Connect(function()
    if isLocked and targetEntity then
        if targetEntity.IsPlayer and targetEntity.Player then
            if not targetEntity.Player.Parent then
                isLocked = false targetEntity = nil clearTargetESP()
                Toggles.MasterLock:SetValue(false)
                Library:Notify("Tracked client left instance scope.")
                return
            end
            targetEntity.Character = targetEntity.Player.Character
        end

        local char = targetEntity.Character
        local corePart = char and (char:FindFirstChild(getgenv().BleedSettings.TargetPart) or char:FindFirstChild("HumanoidRootPart"))
        local humanoid = char and char:FindFirstChildOfClass("Humanoid")
        
        if not char or not char.Parent or not corePart or (humanoid and humanoid.Health <= 0) then
            hideActiveElements() return
        end
        
        local isStillVisible = not getgenv().BleedSettings.WallCheck or checkVisibility(char)
        if isStillVisible then
            local targetPosition = calculatePrediction(char, targetEntity.IsPlayer)
            if targetPosition then Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, targetPosition) end
        end
        
        if getgenv().ESP.Enabled then
            if not activeESP then buildTargetESP(char) end
            local Pos, OnScreen = Camera:WorldToScreenPoint(corePart.Position)
            local Dist = (Camera.CFrame.Position - corePart.Position).Magnitude / 3.5714
            
            if OnScreen and Dist <= getgenv().ESP.MaxDistance then
                local ae = activeESP
                local scaleFactor = (corePart.Size.Y * Camera.ViewportSize.Y) / (Pos.Z * 2)
                local w, h = 3 * scaleFactor, 4.5 * scaleFactor
                
                if getgenv().ESP.FadeOut.OnDistance then
                    UIBuilder:FadeOutOnDist(ae.Box, Dist); UIBuilder:FadeOutOnDist(ae.Name, Dist); UIBuilder:FadeOutOnDist(ae.Distance, Dist); UIBuilder:FadeOutOnDist(ae.Weapon, Dist); UIBuilder:FadeOutOnDist(ae.Healthbar, Dist); UIBuilder:FadeOutOnDist(ae.BehindHealthbar, Dist); UIBuilder:FadeOutOnDist(ae.HealthText, Dist); UIBuilder:FadeOutOnDist(ae.WeaponIcon, Dist); UIBuilder:FadeOutOnDist(ae.LeftTop, Dist); UIBuilder:FadeOutOnDist(ae.LeftSide, Dist); UIBuilder:FadeOutOnDist(ae.BottomSide, Dist); UIBuilder:FadeOutOnDist(ae.BottomDown, Dist); UIBuilder:FadeOutOnDist(ae.RightTop, Dist); UIBuilder:FadeOutOnDist(ae.RightSide, Dist); UIBuilder:FadeOutOnDist(ae.BottomRightSide, Dist); UIBuilder:FadeOutOnDist(ae.BottomRightDown, Dist); UIBuilder:FadeOutOnDist(ae.Chams, Dist); UIBuilder:FadeOutOnDist(ae.Flag1, Dist); UIBuilder:FadeOutOnDist(ae.Flag2, Dist)
                end
                
                ae.Chams.Adornee = char; ae.Chams.Enabled = getgenv().ESP.Drawing.Chams.Enabled; ae.Chams.FillColor = getgenv().ESP.Drawing.Chams.FillRGB; ae.Chams.OutlineColor = getgenv().ESP.Drawing.Chams.OutlineRGB
                if getgenv().ESP.Drawing.Chams.Thermal then
                    local breathe_effect = math.atan(math.sin(tick() * 2)) * 2 / math.pi
                    ae.Chams.FillTransparency = 0.5 * breathe_effect + 0.5; ae.Chams.OutlineTransparency = 0.5 * breathe_effect + 0.5
                end
                ae.Chams.DepthMode = getgenv().ESP.Drawing.Chams.VisibleCheck and Enum.HighlightDepthMode.Occluded or Enum.HighlightDepthMode.AlwaysOnTop
                
                ae.LeftTop.OriginalSize = UDim2.new(0, w / 5, 0, 1)
                ae.LeftTop.Visible = getgenv().ESP.Drawing.Boxes.Corner.Enabled; ae.LeftTop.Position = UDim2.new(0, Pos.X - w / 2, 0, Pos.Y - h / 2); ae.LeftTop.Size = UDim2.new(0, w / 5, 0, 1)
                ae.LeftSide.Visible = getgenv().ESP.Drawing.Boxes.Corner.Enabled; ae.LeftSide.Position = UDim2.new(0, Pos.X - w / 2, 0, Pos.Y - h / 2); ae.LeftSide.Size = UDim2.new(0, 1, 0, h / 5)
                ae.BottomSide.Visible = getgenv().ESP.Drawing.Boxes.Corner.Enabled; ae.BottomSide.Position = UDim2.new(0, Pos.X - w / 2, 0, Pos.Y + h / 2); ae.BottomSide.Size = UDim2.new(0, 1, 0, h / 5); ae.BottomSide.AnchorPoint = Vector2.new(0, 1)
                ae.BottomDown.Visible = getgenv().ESP.Drawing.Boxes.Corner.Enabled; ae.BottomDown.Position = UDim2.new(0, Pos.X - w / 2, 0, Pos.Y + h / 2); ae.BottomDown.Size = UDim2.new(0, w / 5, 0, 1); ae.BottomDown.AnchorPoint = Vector2.new(0, 1)
                ae.RightTop.Visible = getgenv().ESP.Drawing.Boxes.Corner.Enabled; ae.RightTop.Position = UDim2.new(0, Pos.X + w / 2, 0, Pos.Y - h / 2); ae.RightTop.Size = UDim2.new(0, w / 5, 0, 1); ae.RightTop.AnchorPoint = Vector2.new(1, 0)
                ae.RightSide.Visible = getgenv().ESP.Drawing.Boxes.Corner.Enabled; ae.RightSide.Position = UDim2.new(0, Pos.X + w / 2 - 1, 0, Pos.Y - h / 2); ae.RightSide.Size = UDim2.new(0, 1, 0, h / 5); ae.RightSide.AnchorPoint = Vector2.new(0, 0)
                ae.BottomRightSide.Visible = getgenv().ESP.Drawing.Boxes.Corner.Enabled; ae.BottomRightSide.Position = UDim2.new(0, Pos.X + w / 2, 0, Pos.Y + h / 2); ae.BottomRightSide.Size = UDim2.new(0, 1, 0, h / 5); ae.BottomRightSide.AnchorPoint = Vector2.new(1, 1)
                ae.BottomRightDown.Visible = getgenv().ESP.Drawing.Boxes.Corner.Enabled; ae.BottomRightDown.Position = UDim2.new(0, Pos.X + w / 2, 0, Pos.Y + h / 2); ae.BottomRightDown.Size = UDim2.new(0, w / 5, 0, 1); ae.BottomRightDown.AnchorPoint = Vector2.new(1, 1)                                                            

                ae.Box.Position = UDim2.new(0, Pos.X - w / 2, 0, Pos.Y - h / 2); ae.Box.Size = UDim2.new(0, w, 0, h); ae.Box.Visible = getgenv().ESP.Drawing.Boxes.Full.Enabled
                
                RotationAngle = RotationAngle + (tick() - Tick) * getgenv().ESP.Drawing.Boxes.RotationSpeed * math.cos(math.pi / 4 * tick() - math.pi / 2)
                if getgenv().ESP.Drawing.Boxes.Animate then ae.Gradient1.Rotation = RotationAngle ae.Gradient2.Rotation = RotationAngle else ae.Gradient1.Rotation = -45 ae.Gradient2.Rotation = -45 end
                Tick = tick()

                local health = humanoid and (humanoid.Health / humanoid.MaxHealth) or 1
                ae.Healthbar.Position = UDim2.new(0, Pos.X - w / 2 - 6, 0, Pos.Y - h / 2 + h * (1 - health)); ae.Healthbar.Size = UDim2.new(0, getgenv().ESP.Drawing.Healthbar.Width, 0, h * health); ae.Healthbar.Visible = getgenv().ESP.Drawing.Healthbar.Enabled
                ae.BehindHealthbar.Position = UDim2.new(0, Pos.X - w / 2 - 6, 0, Pos.Y - h / 2); ae.BehindHealthbar.Size = UDim2.new(0, getgenv().ESP.Drawing.Healthbar.Width, 0, h); ae.BehindHealthbar.Visible = getgenv().ESP.Drawing.Healthbar.Enabled

                if getgenv().ESP.Drawing.Healthbar.HealthText and humanoid then
                    local healthPercentage = math.floor(health * 100)
                    ae.HealthText.Position = UDim2.new(0, Pos.X - w / 2 - 6, 0, Pos.Y - h / 2 + h * (1 - healthPercentage / 100) + 3)
                    ae.HealthText.Text = tostring(healthPercentage)
                    ae.HealthText.Visible = humanoid.Health < humanoid.MaxHealth
                else ae.HealthText.Visible = false end                        

                ae.Name.Visible = getgenv().ESP.Drawing.Names.Enabled
                local identityTag, tagColor = "P", "rgb(255,0,40)"
                if targetEntity.IsPlayer then
                    local playerInstance = Players:GetPlayerFromCharacter(char)
                    if playerInstance and LocalPlayer:IsFriendsWith(playerInstance.UserId) then identityTag = "F" tagColor = "rgb(0,255,0)" end
                else identityTag = "B" tagColor = "rgb(200,160,255)" end
                
                if getgenv().ESP.Drawing.Distances.Position == "Bottom" then
                    ae.Weapon.Position = UDim2.new(0, Pos.X, 0, Pos.Y + h / 2 + 18); ae.WeaponIcon.Position = UDim2.new(0, Pos.X - 21, 0, Pos.Y + h / 2 + 15)
                    ae.Distance.Position = UDim2.new(0, Pos.X, 0, Pos.Y + h / 2 + 7); ae.Distance.Text = string.format("%d meters", math.floor(Dist)); ae.Distance.Visible = true
                    ae.Name.Text = string.format('(<font color="%s">%s</font>) %s', tagColor, identityTag, targetEntity.DisplayName)
                elseif getgenv().ESP.Drawing.Distances.Position == "Text" then
                    ae.Weapon.Position = UDim2.new(0, Pos.X, 0, Pos.Y + h / 2 + 8); ae.WeaponIcon.Position = UDim2.new(0, Pos.X - 21, 0, Pos.Y + h / 2 + 5); ae.Distance.Visible = false
                    ae.Name.Text = string.format('(<font color="%s">%s</font>) %s [%d]', tagColor, identityTag, targetEntity.DisplayName, math.floor(Dist))
                end
                ae.Weapon.Text = "none" ae.Weapon.Visible = getgenv().ESP.Drawing.Weapons.Enabled
            else hideActiveElements() end
        else hideActiveElements() end
    else clearTargetESP() end
end)

-- [[ METATABLE Interception LAYER (SILENT AIM CORE) ]]
local rawMetatable = getrawmetatable(game)
local originalIndex = rawMetatable.__index
setreadonly(rawMetatable, false)

rawMetatable.__index = newcclosure(function(self, index)
    if not checkcaller() and isLocked and targetEntity and targetEntity.Character then
        local char = targetEntity.Character
        local hitPart = char:FindFirstChild(getgenv().BleedSettings.TargetPart) or char:FindFirstChild("HumanoidRootPart")
        if hitPart and (index == "Hit" or index == "Target") then
            local predictedPos = calculatePrediction(char, targetEntity.IsPlayer)
            if predictedPos then
                if index == "Hit" then return CFrame.new(predictedPos) elseif index == "Target" then return hitPart end
            end
        end
    end
    return originalIndex(self, index)
end)
setreadonly(rawMetatable, true)
