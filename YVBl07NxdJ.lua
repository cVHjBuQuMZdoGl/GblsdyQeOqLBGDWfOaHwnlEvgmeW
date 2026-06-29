-- ====================================================================
-- ██╗  ██╗ █████╗ ███████╗██╗  ██╗██╗██████╗     ██╗  ██╗██╗   ██╗██████╗ 
-- ██║  ██║██╔══██╗██╔════╝██║  ██║██║██╔══██╗    ██║  ██║██║   ██║██╔══██╗
-- ███████║███████║███████╗███████║██║██████╔╝    ███████║██║   ██║██████╔╝
-- ██╔══██║██╔══██║╚════██║██╔══██║██║██╔══██╗    ██╔══██║██║   ██║██╔══██╗
-- ██║  ██║██║  ██║███████║██║  ██║██║██║  ██║    ██║  ██║╚██████╔╝██████╔╝
-- ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝╚═╝  ╚═╝    ╚═╝  ╚═╝ ╚═════╝ ╚═════╝ 
-- ====================================================================
--                  🎉 HASHIR BIRTHDAY COMPETITION EDITION 🎉
--                     DRIVE EMPIRE ULTIMATE SCRIPT HUB
-- ====================================================================

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")

-- Global State Management (Heavy Core Object)
local HashirHubConfig = {
    Version = "v12.4.2",
    Farming = false,
    AutoRace = false,
    VelocityBypass = true,
    AntiLog = true,
    RefreshRate = 0.05,
    TargetDistance = 15,
    SelectedLocation = "Spawn",
    Locations = {
        ["Main Dealership"] = Vector3.new(-380.2, 5.4, 120.8),
        ["Highway Entrance"] = Vector3.new(1200.5, 8.2, -450.3),
        ["Drag Strip Start"] = Vector3.new(-1800.4, 4.1, 3200.1),
        ["Race Track Pit"] = Vector3.new(2500.6, 6.7, -1500.9),
        ["Tuning Custom Shop"] = Vector3.new(-150.8, 4.3, -890.2),
        ["VIP Area Lounge"] = Vector3.new(3100.2, 12.5, 4100.6)
    }
}

-- ====================================================================
--                      ADVANCED EXECUTOR SHIELD
-- ====================================================================
local gmt = getrawmetatable and getrawmetatable(game)
if gmt and setreadonly then
    setreadonly(gmt, false)
    local oldNamecall = gmt.__namecall
    local oldIndex = gmt.__index
    
    gmt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        local args = {...}
        
        if method == "Kick" or method == "kick" or method == "Crash" then
            return nil
        end
        
        local rName = tostring(self)
        if rName:lower():find("cheat") or rName:lower():find("ban") or rName:lower():find("detection") or rName:lower():find("webhook") then
            return nil
        end
        return oldNamecall(self, unpack(args))
    end)
    
    gmt.__index = newcclosure(function(self, key)
        if tostring(self) == "Humanoid" and (key == "WalkSpeed" or key == "Walkspeed") then
            return 16
        end
        return oldIndex(self, key)
    end)
    setreadonly(gmt, true)
end

-- Hook detection counter-measure
if hookmetamethod then
    hookmetamethod(game, "__namecall", function(self, ...)
        if getnamecallmethod() == "Kick" then return nil end
        return oldNamecall(self, ...)
    end)
end

-- ====================================================================
--                        UI CONSTRUCT ENGINE
-- ====================================================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HashirHub_DriveEmpire_Premium"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- 1. Floating Icon (HASHIR Text Theme)
local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "HashirIcon"
ToggleButton.Size = UDim2.new(0, 95, 0, 45)
ToggleButton.Position = UDim2.new(0, 25, 0, 25)
ToggleButton.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
ToggleButton.Text = "★ HASHIR ★"
ToggleButton.TextColor3 = Color3.fromRGB(255, 215, 0)
ToggleButton.TextSize = 14
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.Parent = ScreenGui

local UICornerIcon = Instance.new("UICorner")
UICornerIcon.CornerRadius = UDim.new(0, 12)
UICornerIcon.Parent = ToggleButton

local UIBorderIcon = Instance.new("UIStroke")
UIBorderIcon.Color = Color3.fromRGB(255, 215, 0)
UIBorderIcon.Thickness = 2
UIBorderIcon.Parent = ToggleButton

-- 2. Heavy Main UI Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 420, 0, 380)
MainFrame.Position = UDim2.new(0.5, -210, 0.5, -190)
MainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
MainFrame.Visible = true
MainFrame.Parent = ScreenGui

local UICornerMain = Instance.new("UICorner")
UICornerMain.CornerRadius = UDim.new(0, 14)
UICornerMain.Parent = MainFrame

local UIBorderMain = Instance.new("UIStroke")
UIBorderMain.Color = Color3.fromRGB(255, 60, 110)
UIBorderMain.Thickness = 2.5
UIBorderMain.Parent = MainFrame

-- Premium Header
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 50)
Header.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
Header.Parent = MainFrame

local UICornerHeader = Instance.new("UICorner")
UICornerHeader.CornerRadius = UDim.new(0, 14)
UICornerHeader.Parent = Header

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -20, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "🚀 HASHIR HUB V12 - COMPETITION EDITION 🚀"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 15
Title.Font = Enum.Font.SourceSansBold
Title.Parent = Header

-- Info Banner
local InfoBanner = Instance.new("TextLabel")
InfoBanner.Size = UDim2.new(1, -20, 0, 20)
InfoBanner.Position = UDim2.new(0, 10, 0, 55)
InfoBanner.BackgroundTransparency = 1
InfoBanner.Text = "Bypass Engine Status: EXTREME SHIELD ACTIVE"
InfoBanner.TextColor3 = Color3.fromRGB(0, 255, 170)
InfoBanner.TextSize = 12
InfoBanner.Font = Enum.Font.SourceSansItalic
InfoBanner.Parent = MainFrame

-- Container for Scrollable Features
local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Size = UDim2.new(1, -20, 1, -95)
ScrollingFrame.Position = UDim2.new(0, 10, 0, 85)
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 480)
ScrollingFrame.ScrollBarThickness = 4
ScrollingFrame.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 10)
UIListLayout.Parent = ScrollingFrame

-- Helper Function to Create Buttons Inside Frame
local function CreateMenuButton(text, color, order)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, -10, 0, 45)
    Btn.BackgroundColor3 = Color3.fromRGB(26, 26, 36)
    Btn.Text = text
    Btn.TextColor3 = color
    Btn.TextSize = 16
    Btn.Font = Enum.Font.SourceSansBold
    Btn.LayoutOrder = order
    Btn.Parent = ScrollingFrame
    
    local Round = Instance.new("UICorner")
    Round.CornerRadius = UDim.new(0, 8)
    Round.Parent = Btn
    
    return Btn
end

-- Creating All 5 Feature Buttons
local AutoDriveBtn = CreateMenuButton("Auto Drive Miles Farm: OFF", Color3.fromRGB(255, 75, 75), 1)
local AutoRaceBtn = CreateMenuButton("Auto Race Circuit Loop: OFF", Color3.fromRGB(255, 75, 75), 2)
local AntiTumbleBtn = CreateMenuButton("Vehicle Stabilization: ON", Color3.fromRGB(0, 255, 150), 3)
local TeleportSelectBtn = CreateMenuButton("Select Destination: Main Dealership", Color3.fromRGB(240, 240, 240), 4)
local ActionTeleportBtn = CreateMenuButton("Execute Direct Teleportation", Color3.fromRGB(255, 215, 0), 5)

-- Draggable Engine Initialization
local dragging, dragInput, dragStart, startPos
local function update(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseBehavior or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then update(input) end
end)

ToggleButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- ====================================================================
--                       CORE RUNTIME MODULES
-- ====================================================================
local driveConnection
local raceConnection
local stabilizationConnection = true

-- Feature 1: Miles Driving Farm
local function InitMilesFarm()
    local toggleDir = true
    local lastExecution = tick()
    
    driveConnection = RunService.Heartbeat:Connect(function()
        if not HashirHubConfig.Farming then return end
        
        local rDelay = math.random(4, 7) / 100
        if tick() - lastExecution < rDelay then return end
        lastExecution = tick()
        
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local hum = char:FindFirstChildOfClass("Humanoid")
            local car = hum and hum.SeatPart and hum.SeatPart.Parent
            local root = (car and car:IsA("Model") and car.PrimaryPart) or char.HumanoidRootPart
            
            if root then
                local rDist = math.random(HashirHubConfig.TargetDistance - 3, HashirHubConfig.TargetDistance + 3)
                if toggleDir then
                    root.CFrame = root.CFrame * CFrame.new(0, 0, rDist)
                else
                    root.CFrame = root.CFrame * CFrame.new(0, 0, -rDist)
                end
                
                if root:IsA("BasePart") then
                    root.Velocity = Vector3.new(0, 0, 0)
                    root.RotVelocity = Vector3.new(0, 0, 0)
                end
                toggleDir = not toggleDir
            end
        end
    end)
end

AutoDriveBtn.MouseButton1Click:Connect(function()
    HashirHubConfig.Farming = not HashirHubConfig.Farming
    if HashirHubConfig.Farming then
        AutoDriveBtn.Text = "Auto Drive Miles Farm: ON"
        AutoDriveBtn.TextColor3 = Color3.fromRGB(75, 255, 75)
        InitMilesFarm()
    else
        AutoDriveBtn.Text = "Auto Drive Miles Farm: OFF"
        AutoDriveBtn.TextColor3 = Color3.fromRGB(255, 75, 75)
        if driveConnection then driveConnection:Disconnect() end
    end
end)

-- Feature 2: Simulated Race Loop
AutoRaceBtn.MouseButton1Click:Connect(function()
    HashirHubConfig.AutoRace = not HashirHubConfig.AutoRace
    if HashirHubConfig.AutoRace then
        AutoRaceBtn.Text = "Auto Race Circuit Loop: ON"
        AutoRaceBtn.TextColor3 = Color3.fromRGB(75, 255, 75)
        
        raceConnection = RunService.Heartbeat:Connect(function()
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum and hum.SeatPart then
                    -- Keep vehicle actively engaged in data tracking pipeline
                    hum.SeatPart.Parent:TranslateBy(Vector3.new(0.01, 0, 0))
                end
            end
        end)
    else
        AutoRaceBtn.Text = "Auto Race Circuit Loop: OFF"
        AutoRaceBtn.TextColor3 = Color3.fromRGB(255, 75, 75)
        if raceConnection then raceConnection:Disconnect() end
    end
end)

-- Feature 3: Stabilization Anti-Flip
RunService.Stepped:Connect(function()
    if not stabilizationConnection then return end
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local hum = char:FindFirstChildOfClass("Humanoid")
        local car = hum and hum.SeatPart and hum.SeatPart.Parent
        if car and car:IsA("Model") and car.PrimaryPart then
            -- Reset tilting to avoid server anti-cheat flags due to crazy angles
            local rx, ry, rz = car.PrimaryPart.CFrame:ToOrientation()
            car.PrimaryPart.CFrame = CFrame.new(car.PrimaryPart.CFrame.Position) * CFrame.fromOrientation(0, ry, 0)
        end
    end
end)

AntiTumbleBtn.MouseButton1Click:Connect(function()
    stabilizationConnection = not stabilizationConnection
    if stabilizationConnection then
        AntiTumbleBtn.Text = "Vehicle Stabilization: ON"
        AntiTumbleBtn.TextColor3 = Color3.fromRGB(0, 255, 150)
    else
        AntiTumbleBtn.Text = "Vehicle Stabilization: OFF"
        AntiTumbleBtn.TextColor3 = Color3.fromRGB(255, 75, 75)
    end
end)

-- Feature 4 & 5: Location Cycler and Teleport Execution
local locKeys = {"Main Dealership", "Highway Entrance", "Drag Strip Start", "Race Track Pit", "Tuning Custom Shop", "VIP Area Lounge"}
local currentLocIndex = 1

TeleportSelectBtn.MouseButton1Click:Connect(function()
    currentLocIndex = currentLocIndex + 1
    if currentLocIndex > #locKeys then currentLocIndex = 1 end
    HashirHubConfig.SelectedLocation = locKeys[currentLocIndex]
    TeleportSelectBtn.Text = "Select Destination: " .. HashirHubConfig.SelectedLocation
end)

ActionTeleportBtn.MouseButton1Click:Connect(function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local hum = char:FindFirstChildOfClass("Humanoid")
        local car = hum and hum.SeatPart and hum.SeatPart.Parent
        local root = (car and car:IsA("Model") and car.PrimaryPart) or char.HumanoidRootPart
        
        local targetPos = HashirHubConfig.Locations[HashirHubConfig.SelectedLocation]
        if root and targetPos then
            -- Direct Safe Teleport Action
            root.CFrame = CFrame.new(targetPos + Vector3.new(0, 2, 0))
            if root:IsA("BasePart") then
                root.Velocity = Vector3.new(0, 0, 0)
            end
        end
    end
end)