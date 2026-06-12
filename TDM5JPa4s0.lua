-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- Variables
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

-- Local UI States & Configuration
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
    DistanceESP = false,
    DistanceColor = Color3.fromRGB(255, 255, 255),
    
    -- Crosshair Configurations
    CrosshairEnabled = false,
    CrosshairMode = 'mouse', -- 'center', 'mouse', 'target'
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
}

-- Screen-space UI Container for Classic ESP Assets
local EspGui = Instance.new("ScreenGui")
EspGui.Name = "BleedClassicESPHub"
EspGui.ResetOnSpawn = false
EspGui.IgnoreGuiInset = true
if syn and syn.protect_gui then syn.protect_gui(EspGui) end
EspGui.Parent = CoreGui or LocalPlayer:WaitForChild("PlayerGui")

-- Load Active UI Libraries (SaveManager Retained, ThemeManager Completely Stripped)
local repo = 'https://raw.githubusercontent.com/yuvic123/testsub/refs/heads/main/'
local Library = loadstring(game:HttpGet(repo .. 'ttest'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'save'))()

-- Configure UI Style (Hardcoded Crimson Red Theme Setup)
Library.AccentColor = Color3.fromRGB(172, 0, 0)
Library.AccentColorDark = Color3.fromRGB(100, 0, 0)
Library.ShowCustomCursor = true

-- Initialize Main Windows & Tabs
local Window = Library:CreateWindow({
    Title = "bleed.cc | discord.gg/NsaJqDXfbM",
    Center = true,
    AutoShow = true
})

local MainTab = Window:AddTab("Silent")
local VisualsTab = Window:AddTab("Esp")
local ConfigTab = Window:AddTab("Settings")

-- Layout Groupboxes
local MainGroup = MainTab:AddLeftGroupbox("Silent aim")
local FiltersGroup = MainTab:AddLeftGroupbox("Checks")
local PredictionGroup = MainTab:AddRightGroupbox("Prediction")

-- Visuals Groupbox Containers
local VisualsGroup = VisualsTab:AddLeftGroupbox("Target Visualizer")
local ESPGroup = VisualsTab:AddRightGroupbox("Player ESP")
local CrosshairGroup = VisualsTab:AddRightGroupbox("Crosshair")

-- Settings Left Column Groupbox
local MenuGroupBox = ConfigTab:AddLeftGroupbox("Menu Settings")

-- Create FOV Visual Elements using Drawing API
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

-- Create Native Global Target Highlight
local TargetHighlight = Instance.new("Highlight")
TargetHighlight.Name = "BleedTargetElement"
TargetHighlight.FillColor = Color3.fromRGB(172, 0, 0)
TargetHighlight.OutlineColor = Color3.fromRGB(255, 255, 255)
TargetHighlight.FillTransparency = 0.5
TargetHighlight.OutlineTransparency = 0
TargetHighlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
TargetHighlight.Enabled = false
TargetHighlight.Parent = CoreGui

-- Runtime Loop variables
local TargetPlayer = nil
local CurrentTargetPart = nil
local CurrentTargetPosition = Vector3.new(0, 0, 0)
local CentralHue = 0
local ESPCache = {}

-- Hook Drawing.new to auto-assign properties safely
local old; old = hookfunction(Drawing.new, function(class, properties)
    local drawing = old(class)
    for i, v in next, properties or {} do
        drawing[i] = v
    end
    return drawing
end)

-- Initialize Crosshair Component Elements
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

-- Thread-Safe Background Friend Cache Matrix
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

-- Universal Knocked / Downed Validation Engine
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

-- High-Performance Raycast Wall Check
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

-- Precise Bounding Frame Size Transformations
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

-- Returned to Classic Full 2D Box Framework Configuration (With Integrated Gradient Inner Element)
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
    
    -- Integrated Animated Gradient Framework Elements
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
    healthLabel.Font = Enum.Font.RobotoMono -- Updated font to RobotoMono
    healthLabel.TextSize = 13
    healthLabel.TextStrokeTransparency = 0
    healthLabel.Parent = container
    
    local distanceLabel = Instance.new("TextLabel")
    distanceLabel.Name = "DistanceLabel"
    distanceLabel.BackgroundTransparency = 1
    distanceLabel.Position = UDim2.new(0.5, 0, 1, 3)
    distanceLabel.AnchorPoint = Vector2.new(0.5, 0)
    distanceLabel.Size = UDim2.new(0, 100, 0, 15)
    distanceLabel.Font = Enum.Font.RobotoMono -- Updated font to RobotoMono
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
        DistanceLabel = distanceLabel,
        CurrentPos = nil, 
        CurrentSize = nil 
    }
end

-- Frame-Perfect Render Pipeline Loop (Fully updates box tracking without latency)
RunService.RenderStepped:Connect(function(dt)
    local _tick = tick()
    
    -- 1. Unthrottled Frame-Perfect Crosshair Loop
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

    -- 2. Performance-Scaled Active Player Full 2D Box Transformation Matrix (Zero Lag)
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
                -- Smoother positional alignment calculations to eradicate visual delays
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
                
                -- Full Box Visual Updates
                elements.Box.Visible = Config.BoxESP
                elements.Stroke.Color = Config.BoxColor
                
                -- Animated Gradient Processing
                if Config.GradientESP and Config.BoxESP then
                    elements.GradientBox.Visible = true
                    elements.UiGradient.Color = ColorSequence.new(Config.GradientColor1, Config.GradientColor2)
                    elements.UiGradient.Rotation = gradientRotation
                else
                    elements.GradientBox.Visible = false
                end
                
                -- Top-Facing Health Text
                if Config.HealthESP then
                    elements.HealthLabel.Visible = true
                    local health = math.clamp(humanoid.Health, 0, humanoid.MaxHealth)
                    elements.HealthLabel.Text = math.floor(health) .. " HP"
                    
                    local factor = health / humanoid.MaxHealth
                    elements.HealthLabel.TextColor3 = Color3.fromRGB(255 * (1 - factor), 255 * factor, 0)
                else
                    elements.HealthLabel.Visible = false
                end
                
                -- Distance Computations
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

    -- 3. Target Tracking Selection Computations
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

-- Baseline Framework Initialization Iterators
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

for _, player in pairs(Players:GetPlayers()) do CreateESP(player) end
Players.PlayerAdded:Connect(CreateESP)

Players.PlayerRemoving:Connect(function(plr)
    if ESPCache[plr] then
        pcall(function() ESPCache[plr].Container:Destroy() end)
        ESPCache[plr] = nil
    end
end)

-- Metatable Hook (Universal Namecall Redirector Matrix)
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

-- UI Controls: Silent Aim Tab Groupboxes
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

-- UI Controls: Visuals Tab Groupboxes
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

-- UI Controls: Balanced Player ESP Interface Setup (Full Box & Gradient Controls Integrated)
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

ESPGroup:AddToggle("DistanceEspToggle", {
    Text = "Distance Display",
    Default = false,
    Callback = function(state) Config.DistanceESP = state end
}):AddColorPicker("DistanceEspColor", {
    Default = Color3.fromRGB(255, 255, 255),
    Title = "Distance Str Color",
    Callback = function(color) Config.DistanceColor = color end
})

-- UI Controls: Custom Crosshair Tab Setup
CrosshairGroup:AddToggle("ChEnabledToggle", {
    Text = "Crosshair",
    Default = false,
    Callback = function(state) Config.CrosshairEnabled = state end
}):AddColorPicker("ChColor", {
    Default = Color3.fromRGB(172, 0, 0), -- Updated default menu configuration to Crimson Red
    Title = "Crosshair Core Color",
    Callback = function(color) Config.CrosshairColor = color end
})

CrosshairGroup:AddDropdown("ChModeDropdown", {
    Values = { "center", "mouse", "target" },
    Default = 1,
    Multi = false,
    Text = "Crosshair Position Mode",
    Callback = function(value) Config.CrosshairMode = value end
})

CrosshairGroup:AddToggle("ChSpinToggle", {
    Text = "Enable Spin",
    Default = false,
    Callback = function(state) Config.CrosshairSpin = state end
})

CrosshairGroup:AddToggle("ChResizeToggle", {
    Text = "Enable Resizing",
    Default = false,
    Callback = function(state) Config.CrosshairResize = state end
})

-- UI Controls: Settings Panel Setup
MenuGroupBox:AddLabel("Menu bind"):AddKeyPicker("MenuBindKey", {
    Default = "RightShift",
    NoUI = true,
    Text = "Toggle Menu",
    Callback = function() Library:Toggle() end
})

MenuGroupBox:AddButton("Unload System", function()
    if OriginalNamecallHook then
        hookmetamethod(game, "__namecall", OriginalNamecallHook)
        OriginalNamecallHook = nil
    end
    FOVCircle:Remove()
    TracerLine:Remove()
    if TargetHighlight then TargetHighlight:Destroy() end
    if EspGui then EspGui:Destroy() end
    for _, drawing in pairs(drawings.crosshair) do drawing:Remove() end
    for _, text in pairs(drawings.text) do text:Remove() end
    Library:Unload()
end)

-- SaveManager Configuration Infrastructure Initializations
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings() -- Completely ignores saving any theme values so it cannot force save blue
SaveManager:SetFolder("BleedRewrite/Configs")

-- Build config options cleanly into settings page
SaveManager:BuildConfigSection(ConfigTab)

-- Auto load parameters safely on launch
SaveManager:LoadAutoloadConfig()
