-- ===================================================
--        HASHIR HUB - DRIVE EMPIRE AUTO-FARM        
--         🎉 HAPPY BIRTHDAY HASHIR EDITION 🎉       
-- ===================================================

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- ===================================================
--               SUPER PROTECTION LAYER               
-- ===================================================
local gmt = getrawmetatable and getrawmetatable(game)
if gmt and setreadonly then
    setreadonly(gmt, false)
    local oldNamecall = gmt.__namecall
    local oldIndex = gmt.__index
    
    -- 1. Anti-Kick & Remote Check Hook
    gmt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        local args = {...}
        
        if method == "Kick" or method == "kick" or method == "Crash" then
            return nil -- Game ko kick ya crash karne se rokega
        end
        
        -- Drive Empire ke dangerous detection remotes ko block karna
        local remoteName = tostring(self)
        if remoteName:lower():find("cheat") or remoteName:lower():find("ban") or remoteName:lower():find("kick") or remoteName:lower():find("detection") then
            return nil
        end
        
        return oldNamecall(self, unpack(args))
    end)
    
    -- 2. Speed / Humanoid State Protection Hook
    gmt.__index = newcclosure(function(self, key)
        if tostring(self) == "Humanoid" and (key == "WalkSpeed" or key == "Walkspeed") then
            return 16 -- Anti-cheat agar real speed check kare toh usay normal lagega
        end
        return oldIndex(self, key)
    end)
    
    setreadonly(gmt, true)
end

-- Variables for farming
local farmToggle = false
local farmConnection

-- ===================================================
--                  HASHIR HUB UI                     
-- ===================================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HashirHub_DriveEmpire"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- 1. Floating Icon (HASHIR Button)
local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "HashirIcon"
ToggleButton.Size = UDim2.new(0, 85, 0, 45)
ToggleButton.Position = UDim2.new(0, 20, 0, 20)
ToggleButton.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
ToggleButton.Text = "HASHIR"
ToggleButton.TextColor3 = Color3.fromRGB(255, 215, 0) -- Gold Text for Birthday Theme
ToggleButton.TextSize = 16
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.Parent = ScreenGui

-- Rounded Borders for Floating Icon
local UICornerIcon = Instance.new("UICorner")
UICornerIcon.CornerRadius = UDim.new(0, 12)
UICornerIcon.Parent = ToggleButton

local UIBorderIcon = Instance.new("UIStroke")
UIBorderIcon.Color = Color3.fromRGB(255, 215, 0)
UIBorderIcon.Thickness = 1.5
UIBorderIcon.Parent = ToggleButton

-- 2. Main Frame (Draggable UI)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 320, 0, 240)
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -120)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.Visible = true
MainFrame.Parent = ScreenGui

local UICornerMain = Instance.new("UICorner")
UICornerMain.CornerRadius = UDim.new(0, 12)
UICornerMain.Parent = MainFrame

-- Neon Border for Premium Look
local UIBorderMain = Instance.new("UIStroke")
UIBorderMain.Color = Color3.fromRGB(255, 60, 100)
UIBorderMain.Thickness = 2
UIBorderMain.Parent = MainFrame

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 45)
Title.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
Title.Text = "🎉 HASHIR HUB V2 - PROTECTED 🎉"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.Font = Enum.Font.SourceSansBold
Title.Parent = MainFrame

local UICornerTitle = Instance.new("UICorner")
UICornerTitle.CornerRadius = UDim.new(0, 12)
UICornerTitle.Parent = Title

-- Birthday Sub-Text / Status
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, 0, 0, 25)
StatusLabel.Position = UDim2.new(0, 0, 0, 50)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "Shield: MAXIMUM | Anti-Ban: ACTIVE"
StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
StatusLabel.TextSize = 13
StatusLabel.Font = Enum.Font.SourceSansItalic
StatusLabel.Parent = MainFrame

-- Draggable Script for Mobile & PC
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

-- 3. Advanced Auto Farm Button
local FarmButton = Instance.new("TextButton")
FarmButton.Size = UDim2.new(0, 220, 0, 55)
FarmButton.Position = UDim2.new(0.5, -110, 0.6, 0)
FarmButton.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
FarmButton.Text = "Safe Auto Farm: OFF"
FarmButton.TextColor3 = Color3.fromRGB(255, 75, 75)
FarmButton.TextSize = 18
FarmButton.Font = Enum.Font.SourceSansBold
FarmButton.Parent = MainFrame

local UICornerButton = Instance.new("UICorner")
UICornerButton.CornerRadius = UDim.new(0, 10)
UICornerButton.Parent = FarmButton

-- ===================================================
--               SAFE AUTO FARM LOGIC                  
-- ===================================================
local function startFarming()
    local direction = true
    local lastTick = tick()
    
    farmConnection = RunService.Heartbeat:Connect(function()
        if not farmToggle then return end
        
        -- Randomized delay loop (Anti-Pattern Recognition)
        local randomDelay = math.random(5, 8) / 100 -- 0.05s se 0.08s tak badalta rahega
        if tick() - lastTick < randomDelay then return end
        lastTick = tick()
        
        local character = LocalPlayer.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            local vehicle = humanoid and humanoid.SeatPart and humanoid.SeatPart.Parent
            local target = (vehicle and vehicle:IsA("Model") and vehicle.PrimaryPart) or character.HumanoidRootPart
            
            if target then
                -- Layer 3: Randomized Distance Offset (Bypasses Distance Checks)
                local randomDistance = math.random(12, 18) 
                
                if direction then
                    target.CFrame = target.CFrame * CFrame.new(0, 0, randomDistance)
                else
                    target.CFrame = target.CFrame * CFrame.new(0, 0, -randomDistance)
                end
                
                -- Instant Velocity Neutralization (Anti-Rubberbanding)
                if target:IsA("BasePart") then
                    target.Velocity = Vector3.new(0, 0, 0)
                    target.RotVelocity = Vector3.new(0, 0, 0)
                end
                
                direction = not direction
            end
        end
    end)
end

-- Toggle Button Connection
FarmButton.MouseButton1Click:Connect(function()
    farmToggle = not farmToggle
    if farmToggle then
        FarmButton.Text = "Safe Auto Farm: ON"
        FarmButton.TextColor3 = Color3.fromRGB(75, 255, 75)
        startFarming()
    else
        FarmButton.Text = "Safe Auto Farm: OFF"
        FarmButton.TextColor3 = Color3.fromRGB(255, 75, 75)
        if farmConnection then
            farmConnection:Disconnect()
        end
    end
end)
