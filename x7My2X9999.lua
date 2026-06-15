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
EspGui.Parent = CoreGui or LocalPlayer:WaitForChild("PlayerGui")

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
local VisualsTab = Window:AddTab("Esp")
local HvHTab = Window:AddTab("Rage")
local MiscTab = Window:AddTab("Misc")
local ConfigTab = Window:AddTab("Settings")

local MainGroup = MainTab:AddLeftGroupbox("Silent aim")
local FiltersGroup = MainTab:AddLeftGroupbox("Checks")
local PredictionGroup = MainTab:AddRightGroupbox("Prediction")

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
TargetHighlight.Parent = CoreGui

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
    raycastParams.FilterDescendantsInstances = {LocalPlayer.Character, character, CoreGui}
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

-- Transparency Storage Cache to prevent gray hitboxes/parts from spawning
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

    -- Camera look vector extraction without vertical tilting properties
    local lookVector = Camera.CFrame.LookVector
    local flatLookVector = Vector3.new(lookVector.X, 0, lookVector.Z).Unit

    humanoidRootPart.CFrame = CFrame.new(currentPosition, currentPosition + flatLookVector)
end

local changingMacro = false
function SetMacroState(state)
    if changingMacro then return end
    changingMacro = true
    Config.MacroEnabled = state
    
    -- Macro Loop connection assignment
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
            return OriginalNamecallHook(unpack(args))
        end

        if (method == "FindPartOnRay" or method == "FindPartOnRayWithIgnoreList" or method == "FindPartOnRayWithWhitelist") and args[2] then
            local ray = args[2]
            local newDirection = (CurrentTargetPosition - ray.Origin).Unit * 9999
            args[2] = Ray.new(ray.Origin, newDirection)
            return OriginalNamecallHook(unpack(args))
        end

        if (method == "ScreenPointToRay" or method == "ViewportPointToRay") and self == Camera and args[2] then
            return Ray.new(Camera.CFrame.Position, (CurrentTargetPosition - Camera.CFrame.Position).Unit)
        end
    end

    return OriginalNamecallHook(...)
end))

-- UI Controls
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

We'll go with this no removing any thing just add anothee tab and make that the 2nd tab and name it trigger bot and add a toggle to enable the trigger bot then a prediction input then a delay input then on this next part add another group box in the trigger bot tab and name that new group box checks this checks for knife check, ammo check, knocked check, Here's the trigger bot code just take the things i said

local vu1 = game:GetService("Players")
local vu2 = vu1.LocalPlayer
local vu3 = workspace.CurrentCamera
local v4 = game:GetService("RunService")
local vu5 = game:GetService("UserInputService")
local vu6 = game:GetService("HttpService")
local v7 = game:GetService("ContentProvider")
local vu8 = vu2:WaitForChild("PlayerGui", 30):FindFirstChild("TriggerbotData")
if not vu8 then
    vu8 = Instance.new("Folder")
    vu8.Name = "TriggerbotData"
    vu8.Parent = vu2.PlayerGui
end
local function vu13(p9)
    local v10, v11 = pcall(vu6.JSONEncode, vu6, p9)
    if v10 then
        local v12 = vu8:FindFirstChild("ConfigJson") or Instance.new("StringValue")
        v12.Name = "ConfigJson"
        v12.Parent = vu8
        v12.Value = v11
    end
end
local vu14 = {
    Enabled = false,
    Delay = 0.03,
    Prediction = 0,
    Keybind = "",
    Checks = {
        KnifeCheck = false,
        ForcefieldCheck = false,
        KnockedCheck = false,
        AmmoCheck = false
    }
}
local v18 = (function()
    local v15 = vu8:FindFirstChild("ConfigJson")
    if v15 and v15.Value ~= "" then
        local v16, v17 = pcall(vu6.JSONDecode, vu6, v15.Value)
        if v16 and type(v17) == "table" then
            return v17
        end
    end
    return nil
end)()
if v18 then
    local v19, v20, v21 = pairs(v18)
    while true do
        local v22
        v21, v22 = v19(v20, v21)
        if v21 == nil then
            break
        end
        if vu14[v21] ~= nil and typeof(v22) == typeof(vu14[v21]) then
            vu14[v21] = v22
        end
    end
end
local function v32(pu23)
    local vu24 = nil
    local vu25 = nil
    local vu26 = nil
    local vu27 = nil
    pu23.InputBegan:Connect(function(pu28)
        if pu28.UserInputType == Enum.UserInputType.MouseButton1 or pu28.UserInputType == Enum.UserInputType.Touch then
            vu25 = true
            vu27 = pu28.Position
            vu24 = pu23.Position
            pu28.Changed:Connect(function()
                if pu28.UserInputState == Enum.UserInputState.End then
                    vu25 = false
                end
            end)
        end
    end)
    pu23.InputChanged:Connect(function(p29)
        if p29.UserInputType == Enum.UserInputType.MouseMovement or p29.UserInputType == Enum.UserInputType.Touch then
            vu26 = p29
        end
    end)
    vu5.InputChanged:Connect(function(p30)
        if p30 == vu26 and vu25 then
            local v31 = p30.Position - vu27
            pu23.Position = UDim2.new(vu24.X.Scale, vu24.X.Offset + v31.X, vu24.Y.Scale, vu24.Y.Offset + v31.Y)
        end
    end)
end
local function v36(p33, p34)
    local v35 = Instance.new("UICorner")
    v35.CornerRadius = UDim.new(0, p34)
    v35.Parent = p33
end
local function v41(p37, p38, p39)
    local v40 = Instance.new("UIStroke")
    v40.Color = p38
    v40.Thickness = p39 or 2
    v40.Transparency = 0.3
    v40.Parent = p37
end
local v42 = Instance.new("ScreenGui")
v42.Name = "TriggerbotGUI"
v42.ResetOnSpawn = false
v42.Parent = vu2:WaitForChild("PlayerGui", 30)
local v43 = Instance.new("TextButton", v42)
v43.Size = UDim2.new(0, 50, 0, 50)
v43.Position = UDim2.new(0.05, 0, 0.4, 0)
v43.BackgroundColor3 = Color3.new(0, 0, 0)
v43.BackgroundTransparency = 1
v43.Text = ""
v43.ZIndex = 1
v43.Active = true
v36(v43, 12)
v32(v43)
local v44 = Instance.new("ImageLabel", v43)
v44.Size = UDim2.new(0, 160, 0, 160)
v44.AnchorPoint = Vector2.new(0.5, 0.5)
v44.Position = UDim2.new(0.5, 0, 0.5, 0)
v44.BackgroundTransparency = 1
v44.Image = "rbxthumb://type=Asset&id=81227241386663&w=420&h=420"
v44.ScaleType = Enum.ScaleType.Fit
v44.ZIndex = 2
v7:PreloadAsync({
    v44.Image
})
v36(v44, 12)
local vu45 = Instance.new("Frame", v42)
vu45.Size = UDim2.new(0, 460, 0, 235)
vu45.Position = UDim2.new(0.05, 0, 0.55, 0)
vu45.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
vu45.BackgroundTransparency = 0.2
vu45.Visible = false
vu45.ZIndex = 1
v36(vu45, 10);
(function(p46)
    local v47 = Instance.new("UIGradient")
    v47.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 30, 30)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 100, 200))
    })
    v47.Rotation = 45
    v47.Parent = p46
end)(vu45)
v41(vu45, Color3.fromRGB(0, 170, 255), 3)
v32(vu45)
local v48 = Instance.new("Frame", vu45)
v48.Size = UDim2.new(0, 220, 0, 180)
v48.Position = UDim2.new(0, 5, 0, 5)
v48.BackgroundTransparency = 1
v48.ZIndex = 2
local v49 = Instance.new("UIListLayout", v48)
v49.SortOrder = Enum.SortOrder.LayoutOrder
v49.Padding = UDim.new(0, 8)
local v50 = Instance.new("Frame", vu45)
v50.Size = UDim2.new(0, 220, 0, 180)
v50.Position = UDim2.new(0, 235, 0, 5)
v50.BackgroundTransparency = 1
v50.ZIndex = 2
local v51 = Instance.new("UIListLayout", v50)
v51.SortOrder = Enum.SortOrder.LayoutOrder
v51.Padding = UDim.new(0, 12)
local vu52 = Instance.new("TextButton", v48)
vu52.Size = UDim2.new(0, 220, 0, 31)
vu52.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
vu52.TextColor3 = Color3.new(1, 1, 1)
vu52.Text = vu14.Enabled and "Enabled" or "Disabled"
vu52.Font = Enum.Font.GothamBlack
vu52.TextSize = 17
vu52.LayoutOrder = 1
v36(vu52, 8)
v41(vu52, Color3.fromRGB(0, 170, 255), 2)
vu52.MouseEnter:Connect(function()
    vu52.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
end)
vu52.MouseLeave:Connect(function()
    vu52.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
end)
local v53 = Instance.new("TextLabel", v48)
v53.Size = UDim2.new(0, 220, 0, 17)
v53.BackgroundTransparency = 1
v53.Text = "Delay:"
v53.TextColor3 = Color3.fromRGB(0, 170, 255)
v53.Font = Enum.Font.GothamBlack
v53.TextSize = 17
v53.TextXAlignment = Enum.TextXAlignment.Left
v53.LayoutOrder = 2
local vu54 = Instance.new("TextBox", v48)
vu54.Size = UDim2.new(0, 220, 0, 31)
vu54.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
vu54.TextColor3 = Color3.new(1, 1, 1)
vu54.PlaceholderText = "Enter Delay"
vu54.PlaceholderColor3 = Color3.fromRGB(100, 200, 255)
vu54.Text = v18 and v18.Delay and (tostring(v18.Delay) or "") or ""
vu54.Font = Enum.Font.GothamBlack
vu54.TextSize = 17
vu54.ClearTextOnFocus = false
vu54.LayoutOrder = 3
v36(vu54, 8)
v41(vu54, Color3.fromRGB(0, 170, 255), 2)
vu54.MouseEnter:Connect(function()
    vu54.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
end)
vu54.MouseLeave:Connect(function()
    vu54.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
end)
local v55 = Instance.new("TextLabel", v48)
v55.Size = UDim2.new(0, 220, 0, 17)
v55.BackgroundTransparency = 1
v55.Text = "Prediction:"
v55.TextColor3 = Color3.fromRGB(0, 170, 255)
v55.Font = Enum.Font.GothamBlack
v55.TextSize = 17
v55.TextXAlignment = Enum.TextXAlignment.Left
v55.LayoutOrder = 4
local vu56 = Instance.new("TextBox", v48)
vu56.Size = UDim2.new(0, 220, 0, 31)
vu56.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
vu56.TextColor3 = Color3.new(1, 1, 1)
vu56.PlaceholderText = "Enter Prediction"
vu56.PlaceholderColor3 = Color3.fromRGB(100, 200, 255)
vu56.Text = v18 and (v18.Prediction and tostring(v18.Prediction)) or ""
vu56.Font = Enum.Font.GothamBlack
vu56.TextSize = 17
vu56.ClearTextOnFocus = false
vu56.LayoutOrder = 5
v36(vu56, 8)
v41(vu56, Color3.fromRGB(0, 170, 255), 2)
vu56.MouseEnter:Connect(function()
    vu56.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
end)
vu56.MouseLeave:Connect(function()
    vu56.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
end)
local v57 = Instance.new("TextLabel", v48)
v57.Size = UDim2.new(0, 220, 0, 17)
v57.BackgroundTransparency = 1
v57.Text = "Keybind:"
v57.TextColor3 = Color3.fromRGB(0, 170, 255)
v57.Font = Enum.Font.GothamBlack
v57.TextSize = 17
v57.TextXAlignment = Enum.TextXAlignment.Left
v57.LayoutOrder = 6
local vu58 = Instance.new("TextBox", v48)
vu58.Size = UDim2.new(0, 220, 0, 31)
vu58.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
vu58.TextColor3 = Color3.new(1, 1, 1)
vu58.PlaceholderText = "Enter Keybind"
vu58.PlaceholderColor3 = Color3.fromRGB(100, 200, 255)
vu58.Text = ""
vu58.Font = Enum.Font.GothamBlack
vu58.TextSize = 17
vu58.ClearTextOnFocus = false
vu58.LayoutOrder = 7
v36(vu58, 8)
v41(vu58, Color3.fromRGB(0, 170, 255), 2)
vu58.MouseEnter:Connect(function()
    vu58.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
end)
vu58.MouseLeave:Connect(function()
    vu58.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
end)
local vu59 = Instance.new("TextButton", v50)
vu59.Size = UDim2.new(0, 220, 0, 31)
vu59.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
vu59.TextColor3 = Color3.new(1, 1, 1)
vu59.Text = vu14.Checks.KnifeCheck and "Knife Check: ON" or "Knife Check: OFF"
vu59.Font = Enum.Font.GothamBlack
vu59.TextSize = 17
vu59.LayoutOrder = 1
v36(vu59, 8)
v41(vu59, Color3.fromRGB(0, 170, 255), 2)
vu59.MouseEnter:Connect(function()
    vu59.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
end)
vu59.MouseLeave:Connect(function()
    vu59.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
end)
local vu60 = Instance.new("TextButton", v50)
vu60.Size = UDim2.new(0, 220, 0, 31)
vu60.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
vu60.TextColor3 = Color3.new(1, 1, 1)
vu60.Text = vu14.Checks.ForcefieldCheck and "Forcefield Check: ON" or "Forcefield Check: OFF"
vu60.Font = Enum.Font.GothamBlack
vu60.TextSize = 17
vu60.LayoutOrder = 2
v36(vu60, 8)
v41(vu60, Color3.fromRGB(0, 170, 255), 2)
vu60.MouseEnter:Connect(function()
    vu60.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
end)
vu60.MouseLeave:Connect(function()
    vu60.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
end)
local vu61 = Instance.new("TextButton", v50)
vu61.Size = UDim2.new(0, 220, 0, 31)
vu61.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
vu61.TextColor3 = Color3.new(1, 1, 1)
vu61.Text = vu14.Checks.KnockedCheck and "Knocked Check: ON" or "Knocked Check: OFF"
vu61.Font = Enum.Font.GothamBlack
vu61.TextSize = 17
vu61.LayoutOrder = 3
v36(vu61, 8)
v41(vu61, Color3.fromRGB(0, 170, 255), 2)
vu61.MouseEnter:Connect(function()
    vu61.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
end)
vu61.MouseLeave:Connect(function()
    vu61.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
end)
local vu62 = Instance.new("TextButton", v50)
vu62.Size = UDim2.new(0, 220, 0, 31)
vu62.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
vu62.TextColor3 = Color3.new(1, 1, 1)
vu62.Text = vu14.Checks.AmmoCheck and "Ammo Check: ON" or "Ammo Check: OFF"
vu62.Font = Enum.Font.GothamBlack
vu62.TextSize = 17
vu62.LayoutOrder = 4
v36(vu62, 8)
v41(vu62, Color3.fromRGB(0, 170, 255), 2)
vu62.MouseEnter:Connect(function()
    vu62.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
end)
vu62.MouseLeave:Connect(function()
    vu62.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
end)
local function vu63()
    vu14.Enabled = not vu14.Enabled
    vu52.Text = vu14.Enabled and "Enabled" or "Disabled"
    vu13(vu14)
end
v43.MouseButton1Click:Connect(function()
    vu45.Visible = not vu45.Visible
end)
vu52.MouseButton1Click:Connect(vu63)
vu58.FocusLost:Connect(function(p64)
    if p64 then
        local v65 = vu58.Text:upper()
        if # v65 ~= 1 or not v65:match("%a") then
            vu58.Text = vu14.Keybind
        else
            vu14.Keybind = v65
            vu58.Text = v65
            vu13(vu14)
        end
    end
end)
vu5.InputBegan:Connect(function(p66, p67)
    if not p67 then
        if p66.UserInputType == Enum.UserInputType.Keyboard and vu14.Keybind ~= "" and p66.KeyCode.Name:upper() == vu14.Keybind then
            vu63()
        end
    end
end)
local function vu68()
    vu13(vu14)
end
vu54.FocusLost:Connect(function(p69)
    if p69 then
        local v70 = tonumber(vu54.Text)
        if v70 and 0 <= v70 then
            vu14.Delay = v70
            vu54.Text = tostring(v70)
            vu68()
        else
            vu54.Text = ""
        end
    end
end)
vu56.FocusLost:Connect(function(p71)
    if p71 then
        local v72 = tonumber(vu56.Text)
        if v72 and 0 <= v72 then
            vu14.Prediction = v72
            vu56.Text = tostring(v72)
            vu68()
        else
            vu56.Text = ""
        end
    end
end)
vu59.MouseButton1Click:Connect(function()
    vu14.Checks.KnifeCheck = not vu14.Checks.KnifeCheck
    vu59.Text = vu14.Checks.KnifeCheck and "Knife Check: ON" or "Knife Check: OFF"
    vu68()
end)
vu60.MouseButton1Click:Connect(function()
    vu14.Checks.ForcefieldCheck = not vu14.Checks.ForcefieldCheck
    vu60.Text = vu14.Checks.ForcefieldCheck and "Forcefield Check: ON" or "Forcefield Check: OFF"
    vu68()
end)
vu61.MouseButton1Click:Connect(function()
    vu14.Checks.KnockedCheck = not vu14.Checks.KnockedCheck
    vu61.Text = vu14.Checks.KnockedCheck and "Knocked Check: ON" or "Knocked Check: OFF"
    vu68()
end)
vu62.MouseButton1Click:Connect(function()
    vu14.Checks.AmmoCheck = not vu14.Checks.AmmoCheck
    vu62.Text = vu14.Checks.AmmoCheck and "Ammo Check: ON" or "Ammo Check: OFF"
    vu68()
end)
local vu73 = {
    [93579217841822] = true
}
local vu74 = RaycastParams.new()
vu74.FilterType = Enum.RaycastFilterType.Blacklist
vu74.IgnoreWater = true
local vu75 = 0
local function vu81()
    local v76 = vu2.Character
    if v76 then
        v76 = vu2.Character:FindFirstChildOfClass("Tool")
    end
    if v76 then
        local v77 = v76:FindFirstChild("CurrentAmmo")
        local v78 = v76:FindFirstChild("Clip")
        local v79 = v76:FindFirstChild("Mag")
        local v80 = v76:FindFirstChild("Ammo")
        if v77 and v77:IsA("IntValue") then
            return v77.Value > 0
        elseif v78 and v78:IsA("IntValue") then
            return v78.Value > 0
        elseif v79 and v79:IsA("IntValue") then
            return v79.Value > 0
        else
            return not (v80 and v80:IsA("IntValue")) and true or v80.Value > 0
        end
    else
        return false
    end
end
local function vu88(p82)
    if not p82 then
        return false
    end
    local v83 = p82:FindFirstChildOfClass("Humanoid")
    if not v83 or v83.Health <= 0 or vu1:GetPlayerFromCharacter(p82) == vu2 then
        return false
    end
    if vu14.Checks.KnifeCheck then
        local v84 = vu2.Character
        if v84 then
            v84 = vu2.Character:FindFirstChildOfClass("Tool")
        end
        if v84 and (v84.Name:lower():find("knife") or (v84.Name:lower():find("blade") or (v84.Name:lower():find("dagger") or (v84.Name:lower():find("combat") or (v84.Name:lower():find("melee") or (v84.Name:lower():find("sword") or (v84.ClassName:lower():find("knife") or v84.ClassName:lower():find("blade")))))))) then
            return false
        end
    end
    if vu14.Checks.ForcefieldCheck and (p82:FindFirstChildOfClass("ForceField") or (p82:GetAttribute("Shield") or p82:GetAttribute("Protected"))) then
        return false
    end
    if vu14.Checks.KnockedCheck then
        local v85 = false
        local v86
        if p82:FindFirstChild("BodyEffects") then
            local v87 = p82.BodyEffects
            v86 = v87:FindFirstChild("K.O") and v87["K.O"].Value and true or (v87:FindFirstChild("Dead") and v87.Dead.Value and true or v85)
        else
            v86 = v83.Health < 4 and true or v85
        end
        if v86 then
            return false
        end
    end
    return (not vu14.Checks.AmmoCheck or vu81()) and true or false
end
local function vu90()
    local v89 = vu2.Character
    if v89 then
        v89 = vu2.Character:FindFirstChildOfClass("Tool")
    end
    if v89 then
        v89:Activate()
    end
end
v4.RenderStepped:Connect(function()
    if vu14.Enabled then
        vu74.FilterDescendantsInstances = {
            vu2.Character
        }
        local v91 = vu3:ViewportPointToRay(vu3.ViewportSize.X / 2, vu3.ViewportSize.Y / 2)
        local v92 = v91.Origin
        local v93 = v91.Direction
        local v94 = workspace:Raycast(v92, v93 * 1000, vu74)
        if v94 and v94.Instance then
            local v95 = v94.Instance:FindFirstAncestorOfClass("Model")
            if vu88(v95) then
                local v96 = v94.Position
                if vu14.Prediction > 0 then
                    local v97 = v95:FindFirstChild("HumanoidRootPart") or (v95:FindFirstChild("Torso") or v95:FindFirstChild("UpperTorso"))
                    if v97 then
                        v96 = v97.Position + v97.Velocity * vu14.Prediction
                    end
                end
                local v98 = (v96 - v92).Unit
                local v99 = workspace:Raycast(v92, v98 * 1000, vu74)
                if v99 and v99.Instance and (v99.Instance:IsDescendantOf(v95) and tick() - vu75 >= vu14.Delay) then
                    if vu73[game.PlaceId] then
                        local v100 = vu2.Character:FindFirstChildOfClass("Tool")
                        if v100 then
                            v100:Activate()
                        end
                    else
                        vu90()
                    end
                    vu75 = tick()
                end
            end
        end
    end
end)