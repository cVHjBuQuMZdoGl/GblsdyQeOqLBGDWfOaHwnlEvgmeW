-- [[ GET OUT OFF HERE SKIDDER ]]

-- Safe service resolution
local function getService(serviceName)
    local success, res = pcall(function() 
        return cloneref(game:GetService(serviceName)) 
    end)
    if success and res then return res end
    local regularSuccess, regularRes = pcall(function() return game:GetService(serviceName) end)
    if regularSuccess then return regularRes end
    return nil
end

local TweenService = getService("TweenService")
local Players = getService("Players")
local RunService = getService("RunService")
local Workspace = getService("Workspace")
local CoreGui = getService("CoreGui")
local UserInputService = getService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

-- UI Protected Parent Resolver
local UIParent = nil
local coreGuiSuccess, coreGui = pcall(function() return game:GetService("CoreGui") end)
local canAccessCoreGui = coreGuiSuccess and coreGui and pcall(function()
    local test = Instance.new("ScreenGui")
    test.Parent = coreGui
    test:Destroy()
end)

if pcall(function() return gethui() end) and gethui() then
    UIParent = gethui()
elseif canAccessCoreGui then
    UIParent = coreGui
else
    UIParent = LocalPlayer:WaitForChild("PlayerGui", 5) or LocalPlayer:FindFirstChildOfClass("PlayerGui")
end

-- Tactical Color Configuration
local Colors = {
    Accent = Color3.fromRGB(255, 0, 40),      
    Background = Color3.fromRGB(0, 0, 0),
    TextSecondary = Color3.fromRGB(240, 240, 240)
}

-- Interface Generation Engine
local UIBuilder = {}
function UIBuilder:Create(Class, Properties)
    local _Instance = typeof(Class) == 'string' and Instance.new(Class) or Class
    for Property, Value in pairs(Properties) do _Instance[Property] = Value end
    return _Instance
end

-- [[ CORE SYSTEM HUBS & CONFIGURATION ]]
local Config = {
    Enabled = false,
    Highlight = false,
    Tracers = false,
    ShowFOV = false,
    FOVRadius = 100,
    HitPart = "HumanoidRootPart",
    PredictionX = 0.1,
    PredictionY = 0.1,
    WallCheck = false,
    FriendCheck = false,
    KoCheck = false,
    
    -- Triggerbot Configuration Hub
    TriggerbotEnabled = false,
    TriggerbotDelay = 0.03,
    TriggerbotPrediction = 0,
    TbKnifeCheck = false,
    TbAmmoCheck = false,
    TbKnockedCheck = false,
    
    -- ESP Configurations
    BoxESP = false,
    BoxColor = Color3.fromRGB(172, 0, 0),
    GradientESP = false,
    GradientColor1 = Color3.fromRGB(172, 0, 0),
    GradientColor2 = Color3.fromRGB(0, 0, 0),
    GradientSpeed = 1.5,
    HealthESP = false,
    NameESP = false,
    NameColor = Color3.fromRGB(255, 255, 255),
    DistanceESP = false,
    DistanceColor = Color3.fromRGB(255, 255, 255),
    
    -- Crosshair Configurations
    CrosshairEnabled = false,
    CrosshairMode = 'center', 
    CrosshairColor = Color3.fromRGB(172, 0, 0),
    CrosshairSpin = false,
    CrosshairSpinSpeed = 150,
    CrosshairSpinMax = 340,
    CrosshairResize = false,
    CrosshairResizeSpeed = 150,
    CrosshairResizeMin = 5,
    CrosshairResizeMax = 22,
    CrosshairWidth = 1.5,
    CrosshairLength = 10,
    CrosshairRadius = 11,

    -- HvH Configurations
    AntiLockEnabled = false,
    AntiLockMode = "Sky",
    
    ResolverEnabled = false,
    ResolverMode = "Look Vector",
    
    -- Movement HvH Configurations
    CFrameSpeedEnabled = false,
    CFrameSpeed = 50,
    FlyEnabled = false,
    FlySpeed = 50,
    NoclipEnabled = false,
    InvisibleEnabled = false,
    NoDelayJumpEnabled = false,

    -- Auto Reload Configuration Master State
    AutoReloadEnabled = false,
    
    -- Da Hood Macro State
    MacroEnabled = false
}

-- Screen-space UI Container for Classic ESP & Custom Spawners
local EspGui = Instance.new("ScreenGui")
EspGui.Name = "BleedClassicESPHub"
EspGui.ResetOnSpawn = false
EspGui.IgnoreGuiInset = true
if syn and syn.protect_gui then syn.protect_gui(EspGui) end
EspGui.Parent = UIParent -- Fixed: Swapped hardcoded CoreGui to dynamic resolver

-- Multi-Instance Global Spawner Dynamic Storage Tables
local SpawnedCFrameButtons = {}
local SpawnedInvisButtons = {}
local SpawnedFlyButtons = {}
local SpawnedMacroButtons = {}

local SetCFrameSpeedState 
local SetInvisibleState 
local SetFlyState 
local SetMacroState
local macroConnection = nil

local function SetupDraggableAction(button)
    local dragging, dragInput, dragStart, startPos
    button.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = button.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    button.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            button.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

local function CreateCustomCFrameFloatingButton()
    local index = #SpawnedCFrameButtons + 1
    local btn = Instance.new("TextButton")
    btn.Name = "CustomCFrameFloatingToggle_" .. index
    btn.Size = UDim2.new(0, 150, 0, 45)
    btn.Position = UDim2.new(0, 40 + (index * 8), 0, 125 + (index * 4))
    btn.BackgroundTransparency = 1          
    btn.Text = Config.CFrameSpeedEnabled and "Cframe: ON" or "Cframe: OFF"
    btn.Font = Enum.Font.GothamBold         
    btn.TextSize = 15
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Parent = EspGui
    
    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 8)
    uiCorner.Parent = btn
    
    local uiStroke = Instance.new("UIStroke")
    uiStroke.Thickness = 4 
    uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    uiStroke.LineJoinMode = Enum.LineJoinMode.Round
    uiStroke.Parent = btn
    
    local strokeGrad = Instance.new("UIGradient")
    local currentCrimson = Config.CFrameSpeedEnabled and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(130, 0, 0)
    strokeGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, currentCrimson),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 0, 0)),
        ColorSequenceKeypoint.new(1, currentCrimson)
    })
    strokeGrad.Parent = uiStroke
    
    local textGrad = Instance.new("UIGradient")
    textGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 0, 0)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
    })
    textGrad.Parent = btn
    
    SetupDraggableAction(btn)
    
    btn.MouseButton1Click:Connect(function()
        local nextState = not Config.CFrameSpeedEnabled
        SetCFrameSpeedState(nextState)
    end)
    
    table.insert(SpawnedCFrameButtons, { Button = btn, StrokeGradient = strokeGrad, TextGradient = textGrad })
end

local function CreateCustomFloatingButton()
    local index = #SpawnedInvisButtons + 1
    local btn = Instance.new("TextButton")
    btn.Name = "CustomInvisFloatingToggle_" .. index
    btn.Size = UDim2.new(0, 150, 0, 45)
    btn.Position = UDim2.new(0, 40 + (index * 8), 0, 180 + (index * 4))
    btn.BackgroundTransparency = 1          
    btn.Text = Config.InvisibleEnabled and "Invis: ON" or "Invis: OFF"
    btn.Font = Enum.Font.GothamBold         
    btn.TextSize = 15
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Parent = EspGui
    
    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 8)
    uiCorner.Parent = btn
    
    local uiStroke = Instance.new("UIStroke")
    uiStroke.Thickness = 4 
    uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    uiStroke.LineJoinMode = Enum.LineJoinMode.Round
    uiStroke.Parent = btn
    
    local strokeGrad = Instance.new("UIGradient")
    local currentCrimson = Config.InvisibleEnabled and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(130, 0, 0)
    strokeGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, currentCrimson),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 0, 0)),
        ColorSequenceKeypoint.new(1, currentCrimson)
    })
    strokeGrad.Parent = uiStroke
    
    local textGrad = Instance.new("UIGradient")
    textGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 0, 0)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
    })
    textGrad.Parent = btn
    
    SetupDraggableAction(btn)
    
    btn.MouseButton1Click:Connect(function()
        local nextState = not Config.InvisibleEnabled
        SetInvisibleState(nextState)
    end)
    
    table.insert(SpawnedInvisButtons, { Button = btn, StrokeGradient = strokeGrad, TextGradient = textGrad })
end

local function CreateCustomFlyFloatingButton()
    local index = #SpawnedFlyButtons + 1
    local btn = Instance.new("TextButton")
    btn.Name = "CustomFlyFloatingToggle_" .. index
    btn.Size = UDim2.new(0, 150, 0, 45)
    btn.Position = UDim2.new(0, 40 + (index * 8), 0, 235 + (index * 4))
    btn.BackgroundTransparency = 1          
    btn.Text = Config.FlyEnabled and "Fly: ON" or "Fly: OFF"
    btn.Font = Enum.Font.GothamBold         
    btn.TextSize = 15
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Parent = EspGui
    
    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 8)
    uiCorner.Parent = btn
    
    local uiStroke = Instance.new("UIStroke")
    uiStroke.Thickness = 4 
    uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    uiStroke.LineJoinMode = Enum.LineJoinMode.Round
    uiStroke.Parent = btn
    
    local strokeGrad = Instance.new("UIGradient")
    local currentCrimson = Config.FlyEnabled and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(130, 0, 0)
    strokeGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, currentCrimson),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 0, 0)),
        ColorSequenceKeypoint.new(1, currentCrimson)
    })
    strokeGrad.Parent = uiStroke
    
    local textGrad = Instance.new("UIGradient")
    textGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 0, 0)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
    })
    textGrad.Parent = btn
    
    SetupDraggableAction(btn)
    
    btn.MouseButton1Click:Connect(function()
        local nextState = not Config.FlyEnabled
        SetFlyState(nextState)
    end)
    
    table.insert(SpawnedFlyButtons, { Button = btn, StrokeGradient = strokeGrad, TextGradient = textGrad })
end

local function CreateCustomMacroFloatingButton()
    local index = #SpawnedMacroButtons + 1
    local btn = Instance.new("TextButton")
    btn.Name = "CustomMacroFloatingToggle_" .. index
    btn.Size = UDim2.new(0, 150, 0, 45)
    btn.Position = UDim2.new(0, 40 + (index * 8), 0, 290 + (index * 4))
    btn.BackgroundTransparency = 1          
    btn.Text = Config.MacroEnabled and "Macro: ON" or "Macro: OFF"
    btn.Font = Enum.Font.GothamBold         
    btn.TextSize = 15
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Parent = EspGui
    
    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 8)
    uiCorner.Parent = btn
    
    local uiStroke = Instance.new("UIStroke")
    uiStroke.Thickness = 4 
    uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    uiStroke.LineJoinMode = Enum.LineJoinMode.Round
    uiStroke.Parent = btn
    
    local strokeGrad = Instance.new("UIGradient")
    local currentCrimson = Config.MacroEnabled and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(130, 0, 0)
    strokeGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, currentCrimson),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 0, 0)),
        ColorSequenceKeypoint.new(1, currentCrimson)
    })
    strokeGrad.Parent = uiStroke
    
    local textGrad = Instance.new("UIGradient")
    textGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 0, 0)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
    })
    textGrad.Parent = btn
    
    SetupDraggableAction(btn)
    
    btn.MouseButton1Click:Connect(function()
        local nextState = not Config.MacroEnabled
        SetMacroState(nextState)
    end)
    
    table.insert(SpawnedMacroButtons, { Button = btn, StrokeGradient = strokeGrad, TextGradient = textGrad })
end

-- Flight Controls mapping Setup
local FlyBeganConn, FlyEndedConn
local FlyControls = { Up = 0, Down = 0 }

FlyBeganConn = UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    local code = input.KeyCode
    if code == Enum.KeyCode.Space then FlyControls.Up = 1
    elseif code == Enum.KeyCode.LeftControl then FlyControls.Down = -1
    end
end)

FlyEndedConn = UserInputService.InputEnded:Connect(function(input)
    local code = input.KeyCode
    if code == Enum.KeyCode.Space then FlyControls.Up = 0
    elseif code == Enum.KeyCode.LeftControl then FlyControls.Down = 0
    end
end)

-- Custom Integrated Auto Reload Engine Framework
local function runAutoReloadScript()
    pcall(function()
        local playerGui = LocalPlayer:WaitForChild("PlayerGui")
        local guiElement = playerGui:WaitForChild("gui")
        local ammoFrame = guiElement:WaitForChild("AmmoFrame")
        local ammoText = ammoFrame:WaitForChild("AmmoText")

        local function checkAndFire()
            if not Config.AutoReloadEnabled then return end
            
            if ammoText.Text == "0" then
                local character = LocalPlayer.Character
                if character then
                    local tool = character:FindFirstChildOfClass("Tool")
                    if tool then
                        local rl = tool:FindFirstChild("rl")
                        if rl and rl:IsA("RemoteEvent") then
                            rl:FireServer()
                        end
                    end
                end
            end
        end

        ammoText:GetPropertyChangedSignal("Text"):Connect(checkAndFire)

        LocalPlayer.CharacterAppearanceLoaded:Connect(function(char)
            char.ChildAdded:Connect(function(child)
                if child:IsA("Tool") then
                    checkAndFire()
                end
            end)
        end)
        
        checkAndFire()
    end)
end

LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1)
    runAutoReloadScript()
end)

if LocalPlayer.Character then
    task.spawn(function()
        task.wait(1)
        runAutoReloadScript()
    end)
end

-- Load Active UI Libraries
local repo = 'https://raw.githubusercontent.com/yuvic123/testsub/refs/heads/main/'
local Library = loadstring(game:HttpGet(repo .. 'ttest'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'save'))()

Library.AccentColor = Color3.fromRGB(172, 0, 0)
Library.AccentColorDark = Color3.fromRGB(100, 0, 0)
Library.ShowCustomCursor = false 

local Window = Library:CreateWindow({
    Title = "bleed.cc | discord.gg/NsaJqDXfbM",
    Center = true,
    AutoShow = true
})

local MainTab = Window:AddTab("Silent")
local TriggerbotTab = Window:AddTab("Triggerbot")
local VisualsTab = Window:AddTab("Esp")
local HvHTab = Window:AddTab("Rage")
local MiscTab = Window:AddTab("Misc")
local ConfigTab = Window:AddTab("Settings")

local MainGroup = MainTab:AddLeftGroupbox("Silent aim")
local FiltersGroup = MainTab:AddLeftGroupbox("Checks")
local PredictionGroup = MainTab:AddRightGroupbox("Prediction")

-- Triggerbot Tab Groupboxes Setup
local TbMainGroup = TriggerbotTab:AddLeftGroupbox("Triggerbot Settings")
local TbChecksGroup = TriggerbotTab:AddRightGroupbox("Checks")

local VisualsGroup = VisualsTab:AddLeftGroupbox("Target Visualizer")
local ESPGroup = VisualsTab:AddRightGroupbox("Player ESP")
local CrosshairGroup = VisualsTab:AddRightGroupbox("Crosshair")

local AntiLockGroup = HvHTab:AddLeftGroupbox("Anti Locks")
local ResolverGroup = HvHTab:AddLeftGroupbox("Resolver")
local MovementGroup = HvHTab:AddRightGroupbox("Movement")
local MiscGroup = MiscTab:AddLeftGroupbox("Misc")
local WeaponUtilsGroup = MiscTab:AddRightGroupbox("Weapon Utilities")
local MenuGroupBox = ConfigTab:AddLeftGroupbox("Menu Settings")

local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 2
FOVCircle.Color = Library.AccentColor
FOVCircle.Transparency = 1
FOVCircle.Filled = false
FOVCircle.Visible = false

local TracerLine = Drawing.new("Line")
TracerLine.Thickness = 1.5
TracerLine.Color = Library.AccentColor
TracerLine.Transparency = 1
TracerLine.Visible = false

local TargetHighlight = Instance.new("Highlight")
TargetHighlight.Name = "BleedTargetElement"
TargetHighlight.FillColor = Color3.fromRGB(172, 0, 0)
TargetHighlight.OutlineColor = Color3.fromRGB(255, 255, 255)
TargetHighlight.FillTransparency = 0.5
TargetHighlight.OutlineTransparency = 0
TargetHighlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
TargetHighlight.Enabled = false
TargetHighlight.Parent = UIParent -- Fixed: Swapped hardcoded CoreGui to dynamic resolver

local TargetPlayer = nil
local CurrentTargetPart = nil
local CurrentTargetPosition = Vector3.new(0, 0, 0)
local CentralHue = 0
local ESPCache = {}

local old; old = hookfunction(Drawing.new, function(class, properties)
    local drawing = old(class)
    for i, v in next, properties or {} do
        drawing[i] = v
    end
    return drawing
end)

local drawings = {
    crosshair = {},
    text = {
        Drawing.new('Text', {Size = 13, Font = 2, Outline = true, Text = '.', Color = Color3.new(1, 1, 1)}),
        Drawing.new('Text', {Size = 13, Font = 2, Outline = true, Text = "bleed.cc"})
    },
}

for idx = 1, 8 do
    drawings.crosshair[idx] = Drawing.new('Line')
end

local function solve(angle, radius)
    return Vector2.new(
        math.sin(math.rad(angle)) * radius,
        math.cos(math.rad(angle)) * radius
    )
end

local FriendCache = {}
local function IsFriend(player)
    if not Config.FriendCheck then return false end
    if FriendCache[player.UserId] ~= nil then 
        return FriendCache[player.UserId] 
    end
    
    task.spawn(function()
        local success, result = pcall(function()
            return LocalPlayer:IsFriendsWith(player.UserId)
        end)
        if success then 
            FriendCache[player.UserId] = result 
        end
    end)
    return FriendCache[player.UserId] or false
end

local function IsKnocked(player)
    if not Config.KoCheck then return false end
    local char = player.Character
    if not char then return false end
    
    if char:FindFirstChild("BodyEffects") and char.BodyEffects:FindFirstChild("KO") then
        return char.BodyEffects.KO.Value
    end
    if char:FindFirstChild("Knocked") or char:FindFirstChild("Downed") or char:FindFirstChild("KO") then
        return true
    end
    if player:GetAttribute("Knocked") or player:GetAttribute("Downed") or char:GetAttribute("Knocked") then
        return true
    end
    
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum and hum.PlatformStand and hum.Health < 15 then
        return true
    end
    
    return false
end

local function IsBehindWall(targetPart, character)
    if not Config.WallCheck then return false end
    
    local origin = Camera.CFrame.Position
    local direction = targetPart.Position - origin
    
    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude
    raycastParams.FilterDescendantsInstances = {LocalPlayer.Character, character, UIParent}
    raycastParams.IgnoreWater = true
    
    local raycastResult = Workspace:Raycast(origin, direction, raycastParams)
    return raycastResult ~= nil
end

local function GetBoundingBox(character)
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then return nil end
    
    local topPos, onScreen = Camera:WorldToViewportPoint((hrp.CFrame * CFrame.new(0, 3, 0)).Position)
    local bottomPos = Camera:WorldToViewportPoint((hrp.CFrame * CFrame.new(0, -3.5, 0)).Position)
    
    if not onScreen then return nil end
    
    local height = math.abs(topPos.Y - bottomPos.Y)
    local width = height * 0.65
    
    local x = topPos.X - (width / 2)
    local y = topPos.Y
    
    return Vector2.new(x, y), Vector2.new(width, height)
end

local function CreateESP(plr)
    if plr == LocalPlayer then return end
    if ESPCache[plr] then return end
    
    local container = Instance.new("Frame")
    container.BackgroundTransparency = 1
    container.Visible = false
    container.Parent = EspGui
    
    local box = Instance.new("Frame")
    box.Name = "OuterBox"
    box.BackgroundTransparency = 1
    box.Size = UDim2.new(1, 0, 1, 0)
    box.Parent = container
    
    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 1.5
    stroke.Color = Config.BoxColor
    stroke.Parent = box
    
    local gradientBox = Instance.new("Frame")
    gradientBox.Name = "GradientBox"
    gradientBox.Size = UDim2.new(1, 0, 1, 0)
    gradientBox.BackgroundTransparency = 0.6
    gradientBox.BorderSizePixel = 0
    gradientBox.Parent = container
    
    local uiGradient = Instance.new("UIGradient")
    uiGradient.Color = ColorSequence.new(Config.GradientColor1, Config.GradientColor2)
    uiGradient.Rotation = 0
    uiGradient.Parent = gradientBox
    
    local healthLabel = Instance.new("TextLabel")
    healthLabel.Name = "HealthLabel"
    healthLabel.BackgroundTransparency = 1
    healthLabel.Position = UDim2.new(0.5, 0, 0, -18)
    healthLabel.AnchorPoint = Vector2.new(0.5, 0)
    healthLabel.Size = UDim2.new(0, 100, 0, 15)
    healthLabel.Font = Enum.Font.RobotoMono
    healthLabel.TextSize = 13
    healthLabel.TextStrokeTransparency = 0
    healthLabel.Parent = container
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Name = "NameLabel"
    nameLabel.BackgroundTransparency = 1
    nameLabel.Position = UDim2.new(0.5, 0, 1, 3) 
    nameLabel.AnchorPoint = Vector2.new(0.5, 0)
    nameLabel.Size = UDim2.new(0, 100, 0, 15)
    nameLabel.Font = Enum.Font.RobotoMono
    nameLabel.TextSize = 13
    nameLabel.TextStrokeTransparency = 0
    nameLabel.Parent = container
    
    local distanceLabel = Instance.new("TextLabel")
    distanceLabel.Name = "DistanceLabel"
    distanceLabel.BackgroundTransparency = 1
    distanceLabel.Position = UDim2.new(0.5, 0, 1, 18) 
    distanceLabel.AnchorPoint = Vector2.new(0.5, 0)
    distanceLabel.Size = UDim2.new(0, 100, 0, 15)
    distanceLabel.Font = Enum.Font.RobotoMono
    distanceLabel.TextSize = 13
    distanceLabel.TextStrokeTransparency = 0
    distanceLabel.Parent = container
    
    ESPCache[plr] = {
        Container = container,
        Box = box,
        Stroke = stroke,
        GradientBox = gradientBox,
        UiGradient = uiGradient,
        HealthLabel = healthLabel,
        NameLabel = nameLabel,
        DistanceLabel = distanceLabel,
        CurrentPos = nil, 
        CurrentSize = nil 
    }
end

RunService.RenderStepped:Connect(function(dt)
    local _tick = tick()
    
    local rotationSpeed = (_tick * 130) % 360
    for _, item in ipairs(SpawnedCFrameButtons) do
        if item.Button and item.Button.Parent then
            item.StrokeGradient.Rotation = rotationSpeed
            item.TextGradient.Rotation = rotationSpeed
        end
    end
    for _, item in ipairs(SpawnedInvisButtons) do
        if item.Button and item.Button.Parent then
            item.StrokeGradient.Rotation = rotationSpeed
            item.TextGradient.Rotation = rotationSpeed
        end
    end
    for _, item in ipairs(SpawnedFlyButtons) do
        if item.Button and item.Button.Parent then
            item.StrokeGradient.Rotation = rotationSpeed
            item.TextGradient.Rotation = rotationSpeed
        end
    end
    for _, item in ipairs(SpawnedMacroButtons) do
        if item.Button and item.Button.Parent then
            item.StrokeGradient.Rotation = rotationSpeed
            item.TextGradient.Rotation = rotationSpeed
        end
    end
    
    local position = Vector2.new(0, 0)
    if Config.CrosshairMode == 'center' then
        position = Camera.ViewportSize / 2
    elseif Config.CrosshairMode == 'mouse' then
        position = UserInputService:GetMouseLocation()
    elseif Config.CrosshairMode == 'target' then
        if CurrentTargetPart then
            local screenPos, onScreen = Camera:WorldToViewportPoint(CurrentTargetPart.Position)
            if onScreen then
                position = Vector2.new(screenPos.X, screenPos.Y)
            else
                position = Camera.ViewportSize / 2
            end
        else
            position = Camera.ViewportSize / 2
        end
    else
        position = Camera.ViewportSize / 2
    end

    local text_x = drawings.text[1].TextBounds.X + drawings.text[2].TextBounds.X

    drawings.text[1].Visible = Config.CrosshairEnabled
    drawings.text[2].Visible = Config.CrosshairEnabled

    if Config.CrosshairEnabled then
        drawings.text[1].Position = position + Vector2.new(-text_x / 2, Config.CrosshairRadius + (Config.CrosshairResize and Config.CrosshairResizeMax or Config.CrosshairLength) + 15)
        drawings.text[2].Position = drawings.text[1].Position + Vector2.new(drawings.text[1].TextBounds.X)
        drawings.text[2].Color = Config.CrosshairColor
        
        for idx = 1, 4 do
            local outline = drawings.crosshair[idx]
            local inline = drawings.crosshair[idx + 4]

            local angle = (idx - 1) * 90
            local length = Config.CrosshairLength

            if Config.CrosshairSpin then
                local spin_angle = -_tick * Config.CrosshairSpinSpeed % Config.CrosshairSpinMax
                angle = angle + TweenService:GetValue(spin_angle / 360, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut) * 360
            end

            if Config.CrosshairResize then
                local resize_length = tick() * Config.CrosshairResizeSpeed % 180
                length = Config.CrosshairResizeMin + math.sin(math.rad(resize_length)) * Config.CrosshairResizeMax
            end

            inline.Visible = true
            inline.Color = Config.CrosshairColor
            inline.From = position + solve(angle, Config.CrosshairRadius)
            inline.To = position + solve(angle, Config.CrosshairRadius + length)
            inline.Thickness = Config.CrosshairWidth

            outline.Visible = true
            outline.From = position + solve(angle, Config.CrosshairRadius - 1)
            outline.To = position + solve(angle, Config.CrosshairRadius + length + 1)
            outline.Thickness = Config.CrosshairWidth + 1.5    
        end
    else
        for idx = 1, 8 do
            drawings.crosshair[idx].Visible = false
        end
    end

    local gradientRotation = (_tick * Config.GradientSpeed * 50) % 360
    
    for player, elements in pairs(ESPCache) do
        local character = player.Character
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")
        local hrp = character and character:FindFirstChild("HumanoidRootPart")
        
        if not character or not humanoid or not hrp or humanoid.Health <= 0 then
            elements.Container.Visible = false
            elements.CurrentPos = nil
            elements.CurrentSize = nil
        else
            local pos, size = GetBoundingBox(character)
            if pos and size then
                if not elements.CurrentPos or not elements.Container.Visible then
                    elements.CurrentPos = pos
                    elements.CurrentSize = size
                else
                    local lerpFactor = 1 - math.exp(-48 * dt)
                    elements.CurrentPos = elements.CurrentPos:Lerp(pos, lerpFactor)
                    elements.CurrentSize = elements.CurrentSize:Lerp(size, lerpFactor)
                end
                
                elements.Container.Visible = true
                elements.Container.Position = UDim2.new(0, elements.CurrentPos.X, 0, elements.CurrentPos.Y)
                elements.Container.Size = UDim2.new(0, elements.CurrentSize.X, 0, elements.CurrentSize.Y)
                
                elements.Box.Visible = Config.BoxESP
                elements.Stroke.Color = Config.BoxColor
                
                if Config.GradientESP and Config.BoxESP then
                    elements.GradientBox.Visible = true
                    elements.UiGradient.Color = ColorSequence.new(Config.GradientColor1, Config.GradientColor2)
                    elements.UiGradient.Rotation = gradientRotation
                else
                    elements.GradientBox.Visible = false
                end
                
                if Config.HealthESP then
                    elements.HealthLabel.Visible = true
                    local health = math.clamp(humanoid.Health, 0, humanoid.MaxHealth)
                    elements.HealthLabel.Text = math.floor(health) .. " HP"
                    
                    local factor = health / humanoid.MaxHealth
                    elements.HealthLabel.TextColor3 = Color3.fromRGB(255 * (1 - factor), 255 * factor, 0)
                else
                    elements.HealthLabel.Visible = false
                end
                
                if Config.NameESP then
                    elements.NameLabel.Visible = true
                    elements.NameLabel.Text = player.Name
                    elements.NameLabel.TextColor3 = Config.NameColor
                else
                    elements.NameLabel.Visible = false
                end
                
                if Config.DistanceESP then
                    elements.DistanceLabel.Visible = true
                    local distance = math.floor((hrp.Position - Camera.CFrame.Position).Magnitude)
                    elements.DistanceLabel.Text = string.format("[%d Studs]", distance)
                    elements.DistanceLabel.TextColor3 = Config.DistanceColor
                else
                    elements.DistanceLabel.Visible = false
                end
            else
                elements.Container.Visible = false
            end
        end
    end

    if not Config.Enabled then 
        TargetPlayer = nil
        CurrentTargetPart = nil
        CurrentTargetPosition = Vector3.new(0, 0, 0)
        TargetHighlight.Enabled = false
        TargetHighlight.Adornee = nil
    else
        local closestDistance = math.huge
        local viewportCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
        
        local newTarget = nil
        local newPart = nil

        local allPlayers = Players:GetPlayers()
        for i = 1, #allPlayers do
            local player = allPlayers[i]
            if player ~= LocalPlayer and player.Character then
                local character = player.Character
                
                if IsFriend(player) or IsKnocked(player) then 
                    continue 
                end

                local targetPart = character:FindFirstChild(Config.HitPart) 
                    or character:FindFirstChild("Head") 
                    or character:FindFirstChild("HumanoidRootPart")
                    
                local humanoid = character:FindFirstChild("Humanoid")

                if targetPart and humanoid and humanoid.Health > 0 then
                    local screenPos, onScreen = Camera:WorldToViewportPoint(targetPart.Position)
                    if onScreen then
                        local screenMagnitude = (Vector2.new(screenPos.X, screenPos.Y) - viewportCenter).Magnitude
                        
                        if screenMagnitude < closestDistance and (Config.FOVRadius == 0 or screenMagnitude <= Config.FOVRadius) then
                            if not IsBehindWall(targetPart, character) then
                                closestDistance = screenMagnitude
                                newTarget = player
                                newPart = targetPart
                            end
                        end
                    end
                end
            end
        end

        TargetPlayer = newTarget
        CurrentTargetPart = newPart

        if TargetPlayer and CurrentTargetPart then
            local rootPart = TargetPlayer.Character:FindFirstChild("HumanoidRootPart")
            if rootPart then
                local velocity = rootPart.AssemblyLinearVelocity
                
                if Config.ResolverEnabled then
                    if Config.ResolverMode == "Look Vector" then
                        velocity = rootPart.CFrame.LookVector * velocity.Magnitude
                    elseif Config.ResolverMode == "Move Direction" then
                        local targetHum = TargetPlayer.Character:FindFirstChildOfClass("Humanoid")
                        if targetHum and targetHum.MoveDirection.Magnitude > 0 then
                            velocity = targetHum.MoveDirection * velocity.Magnitude
                        else
                            velocity = Vector3.new(0, 0, 0)
                        end
                    elseif Config.ResolverMode == "Recalculate" then
                        if velocity.Magnitude > 200 then
                            velocity = rootPart.CFrame.LookVector * math.clamp(velocity.Magnitude, 0, 50)
                        end
                    end
                end

                local xOffset = velocity.X * Config.PredictionX
                local yOffset = velocity.Y * Config.PredictionY
                local zOffset = velocity.Z * Config.PredictionX
                
                CurrentTargetPosition = CurrentTargetPart.Position + Vector3.new(xOffset, yOffset, zOffset)
            else
                CurrentTargetPosition = CurrentTargetPart.Position
            end
        else
            CurrentTargetPosition = Vector3.new(0, 0, 0)
        end

        if Config.Highlight and TargetPlayer and TargetPlayer.Character then
            TargetHighlight.Adornee = TargetPlayer.Character
            TargetHighlight.Enabled = true
        else
            TargetHighlight.Enabled = false
            TargetHighlight.Adornee = nil
        end
    end
end)

RunService.Heartbeat:Connect(function(dt)
    CentralHue = (CentralHue + dt * 0.15) % 1

    local viewportCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    FOVCircle.Position = viewportCenter
    FOVCircle.Radius = Config.FOVRadius
    FOVCircle.Visible = Config.ShowFOV and (Config.FOVRadius > 0)

    if Config.Tracers and CurrentTargetPart then
        local screenPos, onScreen = Camera:WorldToViewportPoint(CurrentTargetPart.Position)
        if onScreen then
            TracerLine.From = viewportCenter
            TracerLine.To = Vector2.new(screenPos.X, screenPos.Y)
            TracerLine.Visible = true
        else
            TracerLine.Visible = false
        end
    else
        TracerLine.Visible = false
    end
end)

local AlternationToggle = false
RunService.Heartbeat:Connect(function()
    if not Config.AntiLockEnabled then return end
    
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    
    if not char or not hrp or not hum or hum.Health <= 0 then return end
    
    local oldVelocity = hrp.AssemblyLinearVelocity
    AlternationToggle = not AlternationToggle
    
    if Config.AntiLockMode == "Sky" then
        if AlternationToggle then
            hrp.AssemblyLinearVelocity = Vector3.new(0, 999999, 0)
        else
            hrp.AssemblyLinearVelocity = Vector3.new(0, -999999, 0)
        end
        
    elseif Config.AntiLockMode == "Underground" then
        if AlternationToggle then
            hrp.AssemblyLinearVelocity = Vector3.new(0, -999999, 0)
        else
            hrp.AssemblyLinearVelocity = Vector3.new(0, 999999, 0)
        end
        
    elseif Config.AntiLockMode == "Behind" then
        local backwardVector = -hrp.CFrame.LookVector * 999999
        if AlternationToggle then
            hrp.AssemblyLinearVelocity = backwardVector
        else
            hrp.AssemblyLinearVelocity = -backwardVector
        end
        
    elseif Config.AntiLockMode == "Random/Shake" then
        hrp.AssemblyLinearVelocity = Vector3.new(
            math.random(-999999, 999999),
            math.random(-999999, 999999),
            math.random(-999999, 999999)
        )
    end
    
    RunService.RenderStepped:Wait()
    if hrp and hrp.Parent then
        hrp.AssemblyLinearVelocity = oldVelocity
    end
end)

RunService.Heartbeat:Connect(function(dt)
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if not hrp or not hum or hum.Health <= 0 then return end

    if Config.CFrameSpeedEnabled and hum.MoveDirection.Magnitude > 0 then
        hrp.CFrame = hrp.CFrame + (hum.MoveDirection * (Config.CFrameSpeed * dt))
    end

    if Config.FlyEnabled then
        hum:ChangeState(Enum.HumanoidStateType.Physics) 
        
        local bV = hrp:FindFirstChild("BleedFlyBV")
        if not bV then
            bV = Instance.new("BodyVelocity")
            bV.Name = "BleedFlyBV"
            bV.MaxForce = Vector3.new(9e9, 9e9, 9e9)
            bV.Parent = hrp
        end
        
        local bG = hrp:FindFirstChild("BleedFlyBG")
        if not bG then
            bG = Instance.new("BodyGyro")
            bG.Name = "BleedFlyBG"
            bG.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
            bG.Parent = hrp
        end
        
        local camCFrame = Camera.CFrame
        bG.CFrame = camCFrame
        
        local moveVector = Vector3.new(0, 0, 0)
        
        if hum.MoveDirection.Magnitude > 0 then
            local flatLook = Vector3.new(camCFrame.LookVector.X, 0, camCFrame.LookVector.Z).Unit
            local flatRight = Vector3.new(camCFrame.RightVector.X, 0, camCFrame.RightVector.Z).Unit
            
            local forwardVelocity = hum.MoveDirection:Dot(flatLook)
            local rightVelocity = hum.MoveDirection:Dot(flatRight)
            
            moveVector = (camCFrame.LookVector * forwardVelocity) + (camCFrame.RightVector * rightVelocity)
        end
        
        local verticalState = FlyControls.Up + FlyControls.Down
        if verticalState ~= 0 then
            moveVector = moveVector + Vector3.new(0, verticalState, 0)
        end
        
        if moveVector.Magnitude > 0 then
            bV.Velocity = moveVector.Unit * Config.FlySpeed
        else
            bV.Velocity = Vector3.new(0, 0, 0)
        end
    else
        local bV = hrp:FindFirstChild("BleedFlyBV")
        if bV then bV:Destroy() end
        
        local bG = hrp:FindFirstChild("BleedFlyBG")
        if bG then bG:Destroy() end
        
        if hum:GetState() == Enum.HumanoidStateType.Physics then
            hum:ChangeState(Enum.HumanoidStateType.GettingUp)
        end
        
        FlyControls.Up = 0; FlyControls.Down = 0
    end
end)

RunService.Stepped:Connect(function()
    if not Config.NoclipEnabled then return end
    local char = LocalPlayer.Character
    if char then
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then
                part.CanCollide = false
            end
        end
    end
end)

local SurfaceCFrame = nil

RunService:BindToRenderStep("InvisibleCameraFix", Enum.RenderPriority.Camera.Value - 1, function()
    if not Config.InvisibleEnabled then return end
    
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    
    if hrp and SurfaceCFrame then
        hrp.CFrame = SurfaceCFrame
    end
end)

RunService.Stepped:Connect(function()
    if not Config.InvisibleEnabled then return end
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if hrp and SurfaceCFrame then
        hrp.CFrame = SurfaceCFrame
    end
end)

RunService.Heartbeat:Connect(function()
    if not Config.InvisibleEnabled then return end
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if not hrp or not hum or hum.Health <= 0 then return end
    
    local safeSkyY = 50000
    
    if hrp.Position.Y < 25000 then
        SurfaceCFrame = hrp.CFrame
    end
    
    if SurfaceCFrame then
        hrp.CFrame = CFrame.new(SurfaceCFrame.Position.X, safeSkyY, SurfaceCFrame.Position.Z) * SurfaceCFrame.Rotation
    end
end)

local changingCFrameSpeed = false
function SetCFrameSpeedState(state)
    if changingCFrameSpeed then return end
    changingCFrameSpeed = true
    Config.CFrameSpeedEnabled = state
    
    for _, item in ipairs(SpawnedCFrameButtons) do
        if item.Button and item.Button.Parent then
            item.Button.Text = state and "Cframe: ON" or "Cframe: OFF"
            local crimsonColor = state and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(130, 0, 0)
            item.StrokeGradient.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, crimsonColor),
                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 0, 0)),
                ColorSequenceKeypoint.new(1, crimsonColor)
            })
        end
    end
    
    local toggle = Toggles and Toggles.CFrameSpeedToggle
    if toggle and toggle.Value ~= state then
        toggle:SetValue(state)
    end
    changingCFrameSpeed = false
end

local savedTransparencies = {}
local changingInvis = false
function SetInvisibleState(state)
    if changingInvis then return end
    changingInvis = true
    Config.InvisibleEnabled = state
    
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if hrp then
        if state then
            SurfaceCFrame = hrp.CFrame
            savedTransparencies[char] = {}
            for _, part in pairs(char:GetDescendants()) do
                if (part:IsA("BasePart") and part.Name ~= "HumanoidRootPart") or part:IsA("Decal") or part:IsA("Texture") then
                    if part.Transparency < 1 then
                        savedTransparencies[char][part] = part.Transparency
                        part.Transparency = 0.5
                    end
                end
            end
        else
            if SurfaceCFrame then
                hrp.CFrame = SurfaceCFrame
                SurfaceCFrame = nil
            end
            
            local saved = savedTransparencies[char]
            if saved then
                for part, originalValue in pairs(saved) do
                    if part and part.Parent then
                        part.Transparency = originalValue
                    end
                end
                savedTransparencies[char] = nil
            else
                for _, part in pairs(char:GetDescendants()) do
                    if (part:IsA("BasePart") and part.Name ~= "HumanoidRootPart") or part:IsA("Decal") then
                        if part.Transparency ~= 1 then
                            part.Transparency = 0
                        end
                    end
                end
            end
        end
    end
    
    for _, item in ipairs(SpawnedInvisButtons) do
        if item.Button and item.Button.Parent then
            item.Button.Text = state and "Invis: ON" or "Invis: OFF"
            local crimsonColor = state and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(130, 0, 0)
            item.StrokeGradient.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, crimsonColor),
                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 0, 0)),
                ColorSequenceKeypoint.new(1, crimsonColor)
            })
        end
    end
    
    local toggle = Toggles and Toggles.InvisibleToggle
    if toggle and toggle.Value ~= state then
        toggle:SetValue(state)
    end
    changingInvis = false
end

local changingFly = false
function SetFlyState(state)
    if changingFly then return end
    changingFly = true
    Config.FlyEnabled = state
    
    for _, item in ipairs(SpawnedFlyButtons) do
        if item.Button and item.Button.Parent then
            item.Button.Text = state and "Fly: ON" or "Fly: OFF"
            local crimsonColor = state and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(130, 0, 0)
            item.StrokeGradient.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, crimsonColor),
                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 0, 0)),
                ColorSequenceKeypoint.new(1, crimsonColor)
            })
        end
    end
    
    local toggle = Toggles and Toggles.FlyToggle
    if toggle and toggle.Value ~= state then
        toggle:SetValue(state)
    end
    changingFly = false
end

local function faceForward()
    if not Config.MacroEnabled then return end
    local character = LocalPlayer.Character
    if not character then return end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end

    local currentPosition = humanoidRootPart.Position
    local lookVector = Camera.CFrame.LookVector
    local flatLookVector = Vector3.new(lookVector.X, 0, lookVector.Z).Unit

    humanoidRootPart.CFrame = CFrame.new(currentPosition, currentPosition + flatLookVector)
end

local changingMacro = false
function SetMacroState(state)
    if changingMacro then return end
    changingMacro = true
    Config.MacroEnabled = state
    
    if state then
        if macroConnection then macroConnection:Disconnect() end
        macroConnection = RunService.RenderStepped:Connect(faceForward)
    else
        if macroConnection then
            macroConnection:Disconnect()
            macroConnection = nil
        end
    end
    
    for _, item in ipairs(SpawnedMacroButtons) do
        if item.Button and item.Button.Parent then
            item.Button.Text = state and "Macro: ON" or "Macro: OFF"
            local crimsonColor = state and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(130, 0, 0)
            item.StrokeGradient.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, crimsonColor),
                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 0, 0)),
                ColorSequenceKeypoint.new(1, crimsonColor)
            })
        end
    end
    
    local toggle = Toggles and Toggles.MacroToggle
    if toggle and toggle.Value ~= state then
        toggle:SetValue(state)
    end
    changingMacro = false
end

for _, player in pairs(Players:GetPlayers()) do CreateESP(player) end
Players.PlayerAdded:Connect(CreateESP)

Players.PlayerRemoving:Connect(function(plr)
    if ESPCache[plr] then
        pcall(function() ESPCache[plr].Container:Destroy() end)
        ESPCache[plr] = nil
    end
end)

local IsA = game.IsA
local newindex; newindex = hookmetamethod(game, "__newindex", function(self, Index, Value)
    if Config.NoDelayJumpEnabled and not checkcaller() and IsA(self, "Humanoid") and Index == "JumpPower" then 
        return
    end
    return newindex(self, Index, Value)
end)

local OriginalNamecallHook
OriginalNamecallHook = hookmetamethod(game, "__namecall", newcclosure(function(...)
    local method = getnamecallmethod()
    local args = {...}
    local self = args[1]

    if not checkcaller() and Config.Enabled and CurrentTargetPart then
        if method == "Raycast" and self == Workspace and args[2] and args[3] then
            local origin = args[2]
            args[3] = (CurrentTargetPosition - origin).Unit * args[3].Magnitude
            return OriginalNamecallHook(table.unpack(args)) -- Fixed: Swapped to table.unpack
        end

        if (method == "FindPartOnRay" or method == "FindPartOnRayWithIgnoreList" or method == "FindPartOnRayWithWhitelist") and args[2] then
            local ray = args[2]
            local newDirection = (CurrentTargetPosition - ray.Origin).Unit * 9999
            args[2] = Ray.new(ray.Origin, newDirection)
            return OriginalNamecallHook(table.unpack(args)) -- Fixed: Swapped to table.unpack
        end

        if (method == "ScreenPointToRay" or method == "ViewportPointToRay") and self == Camera and args[2] then
            return Ray.new(Camera.CFrame.Position, (CurrentTargetPosition - Camera.CFrame.Position).Unit)
        end
    end

    return OriginalNamecallHook(...)
end))

-- UI Controls - Tab 1
MainGroup:AddToggle("EnabledToggle", {
    Text = "Silent Aim",
    Default = false,
    Callback = function(state) Config.Enabled = state end
})

MainGroup:AddDropdown("HitPartDropdown", {
    Values = { "Head", "UpperTorso", "Torso", "LowerTorso", "HumanoidRootPart" },
    Default = 5,
    Multi = false,
    Text = "Hitpart",
    Callback = function(value) Config.HitPart = value end
})

FiltersGroup:AddToggle("WallCheckToggle", {
    Text = "Wall Check",
    Default = false,
    Callback = function(state) Config.WallCheck = state end
})

FiltersGroup:AddToggle("FriendCheckToggle", {
    Text = "Friend Check",
    Default = false,
    Callback = function(state) Config.FriendCheck = state end
})

FiltersGroup:AddToggle("KoCheckToggle", {
    Text = "Knocked Check",
    Default = false,
    Callback = function(state) Config.KoCheck = state end
})

PredictionGroup:AddInput("PredictionXInput", {
    Text = "X prediction",
    Default = "0.1",
    Callback = function(value) Config.PredictionX = tonumber(value) or 0 end
})

PredictionGroup:AddInput("PredictionYInput", {
    Text = "Y prediction",
    Default = "0.1",
    Callback = function(value) Config.PredictionY = tonumber(value) or 0 end
})

-- UI Controls - Tab 2 (Triggerbot)
TbMainGroup:AddToggle("TbEnabledToggle", {
    Text = "Triggerbot Enabled",
    Default = false,
    Callback = function(state) Config.TriggerbotEnabled = state end
})

TbMainGroup:AddInput("TbPredictionInput", {
    Text = "Prediction",
    Default = "0",
    Callback = function(value) Config.TriggerbotPrediction = tonumber(value) or 0 end
})

TbMainGroup:AddInput("TbDelayInput", {
    Text = "Delay",
    Default = "0.03",
    Callback = function(value) Config.TriggerbotDelay = tonumber(value) or 0 end
})

TbChecksGroup:AddToggle("TbKnifeCheckToggle", {
    Text = "Knife Check",
    Default = false,
    Callback = function(state) Config.TbKnifeCheck = state end
})

TbChecksGroup:AddToggle("TbAmmoCheckToggle", {
    Text = "Ammo Check",
    Default = false,
    Callback = function(state) Config.TbAmmoCheck = state end
})

TbChecksGroup:AddToggle("TbKnockedCheckToggle", {
    Text = "Knocked Check",
    Default = false,
    Callback = function(state) Config.TbKnockedCheck = state end
})

-- UI Controls - Remaining Original Elements
VisualsGroup:AddToggle("HighlightToggle", {
    Text = "Highlight Target",
    Default = false,
    Callback = function(state) Config.Highlight = state end
})

VisualsGroup:AddToggle("TracersToggle", {
    Text = "Target Tracer",
    Default = false,
    Callback = function(state) Config.Tracers = state end
})

VisualsGroup:AddToggle("ShowFOVToggle", {
    Text = "Circle",
    Default = false,
    Callback = function(state) Config.ShowFOV = state end
})

VisualsGroup:AddSlider("FOVRadiusSlider", {
    Text = "Circle Size",
    Min = 0,
    Max = 300,
    Default = 100,
    Rounding = 0,
    Callback = function(value) Config.FOVRadius = value end
})

ESPGroup:AddToggle("BoxEspToggle", {
    Text = "Box ESP",
    Default = false,
    Callback = function(state) Config.BoxESP = state end
}):AddColorPicker("BoxEspColor", {
    Default = Color3.fromRGB(172, 0, 0),
    Title = "Box Color",
    Callback = function(color) Config.BoxColor = color end
})

ESPGroup:AddToggle("GradientEspToggle", {
    Text = "Gradient Box Fill",
    Default = false,
    Callback = function(state) Config.GradientESP = state end
}):AddColorPicker("GradColorPicker1", {
    Default = Color3.fromRGB(172, 0, 0),
    Title = "Gradient Start",
    Callback = function(color) Config.GradientColor1 = color end
}):AddColorPicker("GradColorPicker2", {
    Default = Color3.fromRGB(0, 0, 0),
    Title = "Gradient End",
    Callback = function(color) Config.GradientColor2 = color end
})

ESPGroup:AddSlider("GradientSpeedSlider", {
    Text = "Gradient Shift Speed",
    Min = 0,
    Max = 10,
    Default = 1.5,
    Rounding = 1,
    Callback = function(value) Config.GradientSpeed = value end
})

ESPGroup:AddToggle("HealthEspToggle", {
    Text = "Health Indicator",
    Default = false,
    Callback = function(state) Config.HealthESP = state end
})

ESPGroup:AddToggle("NameEspToggle", {
    Text = "Name ESP",
    Default = false,
    Callback = function(state) Config.NameESP = state end
}):AddColorPicker("NameEspColor", {
    Default = Color3.fromRGB(255, 255, 255),
    Title = "Name Color",
    Callback = function(color) Config.NameColor = color end
})

ESPGroup:AddToggle("DistanceEspToggle", {
    Text = "Distance Display",
    Default = false,
    Callback = function(state) Config.DistanceESP = state end
}):AddColorPicker("DistanceEspColor", {
    Default = Color3.fromRGB(255, 255, 255),
    Title = "Distance Str Color",
    Callback = function(color) Config.DistanceColor = color end
})

CrosshairGroup:AddToggle("ChEnabledToggle", {
    Text = "Crosshair",
    Default = false,
    Callback = function(state) Config.CrosshairEnabled = state end
}):AddColorPicker("ChColor", {
    Default = Color3.fromRGB(172, 0, 0),
    Title = "Crosshair Color",
    Callback = function(color) Config.CrosshairColor = color end
})

CrosshairGroup:AddDropdown("ChModeDropdown", {
    Values = { 'center', 'mouse', 'target' },
    Default = 1,
    Multi = false,
    Text = "Crosshair Placement",
    Callback = function(value) Config.CrosshairMode = value end
})

CrosshairGroup:AddToggle("ChSpinToggle", {
    Text = "Crosshair Spin",
    Default = false,
    Callback = function(state) Config.CrosshairSpin = state end
})

CrosshairGroup:AddToggle("ChResizeToggle", {
    Text = "Crosshair Resize",
    Default = false,
    Callback = function(state) Config.CrosshairResize = state end
})

AntiLockGroup:AddToggle("AntiLockToggle", {
    Text = "AntiLock",
    Default = false,
    Callback = function(state) Config.AntiLockEnabled = state end
})

AntiLockGroup:AddDropdown("AntiLockModeDropdown", {
    Values = { "Sky", "Underground", "Behind", "Random/Shake" },
    Default = 1,
    Multi = false,
    Text = "Antilock",
    Callback = function(value) Config.AntiLockMode = value end
})

ResolverGroup:AddToggle("ResolverToggle", {
    Text = "Resolver",
    Default = false,
    Callback = function(state) Config.ResolverEnabled = state end
})

ResolverGroup:AddDropdown("ResolverModeDropdown", {
    Values = { "Look Vector", "Move Direction", "Recalculate" },
    Default = 1,
    Multi = false,
    Text = "Resolver",
    Callback = function(value) Config.ResolverMode = value end
})

MovementGroup:AddToggle("CFrameSpeedToggle", {
    Text = "CFrame",
    Default = false,
    Callback = function(state) SetCFrameSpeedState(state) end
})

MovementGroup:AddSlider("CFrameSpeedSlider", {
    Text = "CFrame Speed",
    Min = 16,
    Max = 150,
    Default = 50,
    Rounding = 0,
    Callback = function(value) Config.CFrameSpeed = value end
})

MovementGroup:AddButton({
    Text = "Spawn CFrame Button",
    Func = CreateCustomCFrameFloatingButton
})

MovementGroup:AddToggle("FlyToggle", {
    Text = "Fly",
    Default = false,
    Callback = function(state) SetFlyState(state) end
})

MovementGroup:AddSlider("FlySpeedSlider", {
    Text = "Flight Speed",
    Min = 10,
    Max = 200,
    Default = 50,
    Rounding = 0,
    Callback = function(value) Config.FlySpeed = value end
})

MovementGroup:AddButton({
    Text = "Spawn Fly Button",
    Func = CreateCustomFlyFloatingButton
})

MovementGroup:AddToggle("InvisibleToggle", {
    Text = "Invisibility",
    Default = false,
    Callback = function(state) SetInvisibleState(state) end
})

MovementGroup:AddButton({
    Text = "Spawn Invis Button",
    Func = CreateCustomFloatingButton
})

MiscGroup:AddToggle("NoclipToggle", {
    Text = "Noclip",
    Default = false,
    Callback = function(state) Config.NoclipEnabled = state end
})

MiscGroup:AddToggle("NoDelayJumpToggle", {
    Text = "No Jump Cooldown",
    Default = false,
    Callback = function(state) Config.NoDelayJumpEnabled = state end
})

MiscGroup:AddToggle("MacroToggle", {
    Text = "Fix Orientation Macro",
    Default = false,
    Callback = function(state) SetMacroState(state) end
})

MiscGroup:AddButton({
    Text = "Spawn Macro Button",
    Func = CreateCustomMacroFloatingButton
})

WeaponUtilsGroup:AddToggle("AutoReloadToggle", {
    Text = "Auto Reload",
    Default = false,
    Callback = function(state) 
        Config.AutoReloadEnabled = state 
        if state then
            pcall(function()
                local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
                local ammoText = playerGui and playerGui:FindFirstChild("gui") and playerGui.gui:FindFirstChild("AmmoFrame") and playerGui.gui.AmmoFrame:FindFirstChild("AmmoText")
                if ammoText and ammoText.Text == "0" then
                    local character = LocalPlayer.Character
                    local tool = character and character:FindFirstChildOfClass("Tool")
                    local rl = tool and tool:FindFirstChild("rl")
                    if rl and rl:IsA("RemoteEvent") then
                        rl:FireServer()
                    end
                end
            end)
        end
    end
})

MenuGroupBox:AddButton('Unload Script', function() 
    pcall(function()
        if FlyBeganConn then FlyBeganConn:Disconnect() end
        if FlyEndedConn then FlyEndedConn:Disconnect() end
        if macroConnection then macroConnection:Disconnect() end
        
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if hrp then
            local bV = hrp:FindFirstChild("BleedFlyBV")
            if bV then bV:Destroy() end
            local bG = hrp:FindFirstChild("BleedFlyBG")
            if bG then bG:Destroy() end
        end
        
        Camera.FieldOfView = 70
        
        for _, item in ipairs(SpawnedCFrameButtons) do pcall(function() item.Button:Destroy() end) end
        for _, item in ipairs(SpawnedInvisButtons) do pcall(function() item.Button:Destroy() end) end
        for _, item in ipairs(SpawnedFlyButtons) do pcall(function() item.Button:Destroy() end) end
        for _, item in ipairs(SpawnedMacroButtons) do pcall(function() item.Button:Destroy() end) end
        
        FOVCircle:Destroy()
        TracerLine:Destroy()
        TargetHighlight:Destroy()
        EspGui:Destroy()
        
        for idx = 1, 8 do
            drawings.crosshair[idx]:Destroy()
        end
        drawings.text[1]:Destroy()
        drawings.text[2]:Destroy()
        
        Library:Unload()
    end)
end)

MenuGroupBox:AddLabel('Menu Bind'):AddKeyPicker('MenuKeybind', { Default = 'End', NoUI = true, Text = 'Menu Open Key' })
Library.ToggleKeybind = Toggles.MenuKeybind

SaveManager:SetLibrary(Library)
SaveManager:SetFolder('bleedcc/configs')
SaveManager:BuildConfigSection(ConfigTab)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })
SaveManager:LoadAutoloadConfig()

-- [[ INTEGRATED TRIGGERBOT BACKEND EXECUTION LOGIC ]]
local tbLastShot = 0
local tbRaycastParams = RaycastParams.new()
tbRaycastParams.FilterType = Enum.RaycastFilterType.Exclude
tbRaycastParams.IgnoreWater = true

local function checkTriggerbotAmmo()
    local tool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")
    if tool then
        local currentAmmo = tool:FindFirstChild("CurrentAmmo") or tool:FindFirstChild("Clip") or tool:FindFirstChild("Mag") or tool:FindFirstChild("Ammo")
        if currentAmmo and currentAmmo:IsA("IntValue") then
            return currentAmmo.Value > 0
        end
        return true
    end
    return false
end

local function validateTriggerbotTarget(model)
    if not model then return false end
    local humanoid = model:FindFirstChildOfClass("Humanoid")
    if not humanoid or humanoid.Health <= 0 or Players:GetPlayerFromCharacter(model) == LocalPlayer then
        return false
    end
    
    if Config.TbKnifeCheck then
        local tool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")
        if tool and (tool.Name:lower():find("knife") or tool.Name:lower():find("blade") or tool.Name:lower():find("dagger") or tool.Name:lower():find("combat") or tool.Name:lower():find("melee") or tool.Name:lower():find("sword")) then
            return false
        end
    end
    
    if Config.TbKnockedCheck then
        local isKnocked = false
        if model:FindFirstChild("BodyEffects") then
            local bodyEffects = model.BodyEffects
            isKnocked = (bodyEffects:FindFirstChild("K.O") and bodyEffects["K.O"].Value) or (bodyEffects:FindFirstChild("Dead") and bodyEffects.Dead.Value)
        else
            isKnocked = humanoid.Health < 4
        end
        if isKnocked then return false end
    end
    
    if Config.TbAmmoCheck and not checkTriggerbotAmmo() then
        return false
    end
    
    return true
end

RunService.RenderStepped:Connect(function()
    if not Config.TriggerbotEnabled then return end
    
    tbRaycastParams.FilterDescendantsInstances = { LocalPlayer.Character, UIParent, EspGui }
    
    local viewportRay = Camera:ViewportPointToRay(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    local castOrigin = viewportRay.Origin
    local castDirection = viewportRay.Direction
    
    local primaryHit = workspace:Raycast(castOrigin, castDirection * 1000, tbRaycastParams)
    if primaryHit and primaryHit.Instance then
        local hitTargetModel = primaryHit.Instance:FindFirstAncestorOfClass("Model")
        if validateTriggerbotTarget(hitTargetModel) then
            local firePosition = primaryHit.Position
            
            if Config.TriggerbotPrediction > 0 then
                local hitRoot = hitTargetModel:FindFirstChild("HumanoidRootPart") or hitTargetModel:FindFirstChild("Torso") or hitTargetModel:FindFirstChild("UpperTorso")
                if hitRoot then
                    firePosition = hitRoot.Position + (hitRoot.AssemblyLinearVelocity * Config.TriggerbotPrediction)
                end
            end
            
            local secondaryDirection = (firePosition - castOrigin).Unit
            local confirmationHit = workspace:Raycast(castOrigin, secondaryDirection * 1000, tbRaycastParams)
            
            if confirmationHit and confirmationHit.Instance and confirmationHit.Instance:IsDescendantOf(hitTargetModel) then
                if (tick() - tbLastShot) >= Config.TriggerbotDelay then
                    local tool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")
                    if tool then
                        tool:Activate()
                    end
                    tbLastShot = tick()
                end
            end
        end
    end
end)
