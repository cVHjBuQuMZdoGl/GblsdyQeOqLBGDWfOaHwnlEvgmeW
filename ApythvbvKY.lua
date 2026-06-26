-- [[ SCRIPT MANIAC HUB: PART 1 ]] --
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local Camera = workspace.CurrentCamera

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

_G.Tabs = {}
_G.CurrentAimbotTarget = nil
_G.AimOn = false
_G.NoRecoilOn = false
_G.CrosshairOn = true
_G.EspOn = false 
_G.InvinceTrack = false
_G.AutoShootOn = false
_G.TargetByClosest3D = true 
_G.RevengeMode = true 
_G.MovableAim = true 

local LastLocalHealth = 100
local RevengeTargetPlayer = nil
local IsMovingMouse = false
local LastMouseInput = 0
local AIMBOT_FOV = 250
local crosshairSize = 6
local crosshairGap = 2
local crosshairThickness = 1

local gui = Instance.new("ScreenGui", PlayerGui)
gui.Name = "ScriptManiacHubFixed"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true

local mainFrame = Instance.new("Frame", gui)
mainFrame.Size = UDim2.new(0, 420, 0, 320)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 10)
-- [[ SCRIPT MANIAC HUB: PART 2 ]] --
local function makeDraggable(frame, isIcon, callback)
    local dragging, dragInput, dragStart, startPos = false, nil, nil, nil
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true; dragStart = input.Position; startPos = frame.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end
makeDraggable(mainFrame, false)

local function createToggle(parentTab, text, globalVar, callback)
    local b = Instance.new("TextButton", parentTab)
    b.Size = UDim2.new(1, 0, 0, 35); b.BackgroundColor3 = _G[globalVar] and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(45, 45, 50)
    b.TextColor3 = Color3.new(1,1,1); b.Text = text .. ": " .. (_G[globalVar] and "ON" or "OFF")
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    b.MouseButton1Click:Connect(function()
        _G[globalVar] = not _G[globalVar]; b.Text = text .. ": " .. (_G[globalVar] and "ON" or "OFF")
        b.BackgroundColor3 = _G[globalVar] and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(45, 45, 50)
        if callback then callback(_G[globalVar]) end
    end)
end

local function isEnemy(p)
    if p == LocalPlayer or not p.Character or not p.Character:FindFirstChild("HumanoidRootPart") then return false end
    local hum = p.Character:FindFirstChildOfClass("Humanoid")
    if not hum or hum.Health <= 0 then return false end
    return true
end

UserInputService.InputChanged:Connect(function(input)
    if _G.MovableAim and (input.UserInputType == Enum.UserInputType.MouseMovement) then
        if input.Delta.Magnitude > 1.2 then IsMovingMouse = true; LastMouseInput = tick() end
    end
end)
-- [[ INSERT THIS BETWEEN PART 2 AND PART 3 TO SHOW UI BUTTONS ]] --

-- Tab Containers Definition
local tabButtons = Instance.new("Frame", mainFrame)
tabButtons.Size = UDim2.new(1, 0, 0, 35)
tabButtons.Position = UDim2.new(0, 0, 0, 40)
tabButtons.BackgroundTransparency = 1

local tabLayout = Instance.new("UIListLayout", tabButtons)
tabLayout.FillDirection = Enum.FillDirection.Horizontal
tabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
tabLayout.Padding = UDim.new(0, 5)

local tabContent = Instance.new("Frame", mainFrame)
tabContent.Size = UDim2.new(1, -20, 1, -90)
tabContent.Position = UDim2.new(0, 10, 0, 85)
tabContent.BackgroundTransparency = 1

local tabs = { Combat = Instance.new("ScrollingFrame"), Player = Instance.new("ScrollingFrame"), Config = Instance.new("ScrollingFrame") }
_G.Tabs = tabs

for name, frame in pairs(tabs) do
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundTransparency = 1
    frame.Visible = (name == "Combat")
    frame.Parent = tabContent
    Instance.new("UIListLayout", frame).Padding = UDim.new(0, 6)
end

-- Instantiating Features onto UI
createToggle(tabs.Combat, "Op Aimbot", "AimOn")
createToggle(tabs.Combat, "Auto Shoot Engine", "AutoShootOn")
createToggle(tabs.Combat, "Target Closest Player", "TargetByClosest3D")
createToggle(tabs.Combat, "Prioritize Attacker", "RevengeMode")
createToggle(tabs.Combat, "Enable Movable Aim", "MovableAim")

-- [[ SCRIPT MANIAC HUB: PART 3 (FINAL ENGINE) ]] --

-- Crosshair Setup Mechanics
local crosshair = { top = Drawing.new("Line"), bottom = Drawing.new("Line"), left = Drawing.new("Line"), right = Drawing.new("Line") }
for _, l in pairs(crosshair) do l.Color = Color3.new(1,0,0); l.Thickness = crosshairThickness; l.Visible = _G.CrosshairOn end

LocalPlayer.CharacterAdded:Connect(function(char)
    RevengeTargetPlayer = nil
    LastLocalHealth = 100
end)

-- Runtime Calculations and Tracking Engine
RunService.RenderStepped:Connect(function()
    local myHRP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    local myHum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    local center = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    
    if IsMovingMouse and tick() - LastMouseInput > 0.15 then
        IsMovingMouse = false
    end

    -- Hit-Detection & Revenge Check
    if myHum and _G.RevengeMode then
        if myHum.Health < LastLocalHealth and myHum.Health > 0 then
            local maxAttackerDist = math.huge
            for _, attacker in ipairs(Players:GetPlayers()) do
                if isEnemy(attacker) and attacker.Character and attacker.Character:FindFirstChild("HumanoidRootPart") then
                    local currentTool = attacker.Character:FindFirstChildOfClass("Tool")
                    if currentTool then 
                        local worldDist = (myHRP.Position - attacker.Character.HumanoidRootPart.Position).Magnitude
                        if worldDist < maxAttackerDist then
                            maxAttackerDist = worldDist
                            RevengeTargetPlayer = attacker
                        end
                    end
                end
            end
        end
        LastLocalHealth = myHum.Health
        
        if RevengeTargetPlayer and (not isEnemy(RevengeTargetPlayer) or myHum.Health <= 0) then
            RevengeTargetPlayer = nil
        end
    end

    -- Crosshair Line Updates
    if _G.CrosshairOn then
        crosshair.top.From = Vector2.new(center.X, center.Y - crosshairGap - crosshairSize)
        crosshair.top.To = Vector2.new(center.X, center.Y - crosshairGap)
        crosshair.bottom.From = Vector2.new(center.X, center.Y + crosshairGap)
        crosshair.bottom.To = Vector2.new(center.X, center.Y + crosshairGap + crosshairSize)
        crosshair.left.From = Vector2.new(center.X - crosshairGap - crosshairSize, center.Y)
        crosshair.left.To = Vector2.new(center.X - crosshairGap)
        crosshair.right.From = Vector2.new(center.X + crosshairGap, center.Y)
        crosshair.right.To = Vector2.new(center.X + crosshairGap + crosshairSize, center.Y)
    end

    -- Target Scan Loop
    local bestTarget = nil
    local minScreenDist = math.huge
    local minWorldDist = math.huge

    if _G.RevengeMode and RevengeTargetPlayer and isEnemy(RevengeTargetPlayer) and RevengeTargetPlayer.Character and RevengeTargetPlayer.Character:FindFirstChild("Head") then
        local _, onScreen = Camera:WorldToViewportPoint(RevengeTargetPlayer.Character.Head.Position)
        if onScreen then
            bestTarget = RevengeTargetPlayer
        end
    end

    for _, player in ipairs(Players:GetPlayers()) do
        if not bestTarget and myHRP and isEnemy(player) and player.Character and player.Character:FindFirstChild("Head") and player.Character:FindFirstChild("HumanoidRootPart") then
            local enemyHRP = player.Character.HumanoidRootPart
            local screenPos, onScreen = Camera:WorldToViewportPoint(player.Character.Head.Position)
            
            if onScreen then
                local screenDist = (Vector2.new(screenPos.X, screenPos.Y) - center).Magnitude
                if screenDist <= AIMBOT_FOV then
                    if _G.TargetByClosest3D then
                        local worldDist = (myHRP.Position - enemyHRP.Position).Magnitude
                        if worldDist < minWorldDist then
                            minWorldDist = worldDist; bestTarget = player
                        end
                    else
                        if screenDist < minScreenDist then
                            minScreenDist = screenDist; bestTarget = player
                        end
                    end
                end
            end
        end
    end

    _G.CurrentAimbotTarget = bestTarget

    -- Smooth Movement Look Lock
    if _G.AimOn and _G.CurrentAimbotTarget and _G.CurrentAimbotTarget.Character then
        if not (_G.MovableAim and IsMovingMouse) then
            local lockPart = _G.CurrentAimbotTarget.Character:FindFirstChild("Head") or _G.CurrentAimbotTarget.Character:FindFirstChild("HumanoidRootPart")
            if lockPart then
                Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, lockPart.Position)
            end
        end
    end
end)

-- Dedicated Async Fast Shoot Loop
task.spawn(function()
    while true do
        task.wait(0.08)
        if _G.AutoShootOn and _G.CurrentAimbotTarget then
            local x, y = Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2
            VirtualInputManager:SendMouseButtonEvent(x, y, 0, true, game, 0)
            task.wait(0.01)
            VirtualInputManager:SendMouseButtonEvent(x, y, 0, false, game, 0)
        end
    end
end)

print("Maniac Hub Loaded Completely!")
