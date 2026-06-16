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
local EquippedToolName = nil

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

-- Track Local Player Inventory Items
LocalPlayer.CharacterAdded:Connect(function(character)
    character.ChildAdded:Connect(function(child)
        if child:IsA("Tool") then EquippedToolName = child.Name end
    end)
    character.CharacterRemoved:Connect(function(child) -- Fixed event name here safely
        if child:IsA("Tool") then EquippedToolName = nil end
    end)
end)

if LocalPlayer.Character then
    for _, child in ipairs(LocalPlayer.Character:GetChildren()) do
        if child:IsA("Tool") then
            EquippedToolName = child.Name
            break
        end
    end
end

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
        return c