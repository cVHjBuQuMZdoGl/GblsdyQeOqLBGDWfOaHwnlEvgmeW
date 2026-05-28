-- Blazed - Ultimate Edition (Clean) - ENHANCED AIMBOT
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local VirtualInput = game:GetService("VirtualInputManager")
local HttpService = game:GetService("HttpService")
local GuiService = game:GetService("GuiService")
local CoreGui = game:GetService("CoreGui")

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/alebinh60/asmobile/refs/heads/main/Library.lua"))()
local Window = Library:CreateWindow({
    Title = "Blazed X",
    Footer = "blazed.cc | Ultimate Edition",
    Icon = 241778280,
    ShowCustomCursor = true,
})

local Tabs = {
    Combat = Window:AddTab("Combat", "swords"),
    Visuals = Window:AddTab("Visuals", "eye"),
    Movement = Window:AddTab("Movement", "user"),
    Misc = Window:AddTab("Misc", "settings"),
}

-- ==================== VARIABLES ====================
-- Combat (Enhanced)
local SilentEnabled = false
local SilentHitPart = "Head"
local SilentFOV = 150
local SilentFOVType = "Dynamic" -- Dynamic, Static, Distance
local SilentPriority = "Distance" -- Distance, Health, Crosshair, Team
local AimlockEnabled = false
local AimlockSmoothing = 0.2
local AimlockPart = "Head"
local AimlockType = "Camera" -- Camera, Mouse, Smooth
local AimlockOnKey = false
local AimlockKey = "MouseButton2"
local AimlockPredictMovement = true
local AimlockPredictBulletDrop = false
local AimlockRandomization = 0
local AimlockSnap = false
local AimlockSnapFOV = 100
local AimlockVerticalOnly = false
local AimlockHorizontalOnly = false
local AimlockIgnoreJumping = false
local AimlockIgnoreDropping = false
local AimlockMaxDistance = 500
local AimlockMinDistance = 0
local AimlockAimAtFeet = false
local AimlockHeadshotPriority = true
local AimlockBodyPriority = false
local AimlockLimbPriority = false
local AimlockNearestToCrosshair = true
local AimlockCycleTargets = false
local AimlockCycleKey = "Q"
local AimlockTargetLock = false
local AimlockLockAfterKill = true
local AimlockSwitchOnDeath = true
local AimlockSwitchDelay = 0.5
local AimlockVisibleOnly = true
local AimlockTeamCheck = false
local AimlockFriendsList = {}
local AimlockBlacklist = {}
local AimlockFOVCircle = false
local AimlockFOVCircleColor = Color3.fromRGB(255, 0, 0)
local AimlockFOVCircleTransparency = 0.5

local WallCheckEnabled = true
local WallCheckPart = "Head"
local TriggerBotEnabled = false
local TriggerBotDelay = 0.1
local TriggerBotKey = "MouseButton2"
local TriggerBotHold = false
local TriggerBotADSOnly = false
local TriggerBotHipOnly = false
local TriggerBotIgnoreFriends = false
local TriggerBotHeadOnly = false
local TriggerBotBodyOnly = false
local TriggerBotLimbOnly = false
local TriggerBotHealthBelow = 100
local TriggerBotHealthAbove = 0
local TriggerBotDistanceLimit = 0
local TriggerBotRandomDelay = false
local TriggerBotRandomMin = 0.05
local TriggerBotRandomMax = 0.2

local PredictionEnabled = false
local PredictionAmount = 0.15
local PredictionType = "Linear" -- Linear, Gravity, Advanced
local PredictionVelocityMultiplier = 1
local PredictionGravity = 0
local PredictionIncludeJumping = true

local TeamCheckEnabled = false
local AimAssistEnabled = false
local AimAssistStrength = 0.3
local AimAssistFOV = 100
local AimAssistPull = 0.1

local AutoShootEnabled = false
local AutoShootDelay = 0.05
local AutoShootPart = "Head"
local AutoShootWhenVisible = true

local AntiRecoilEnabled = false
local AntiRecoilStrength = 0.5
local AntiSpreadEnabled = false
local AntiSpreadStrength = 0.5
local NoSwayEnabled = false
local InstantHitEnabled = false
local BulletTPEnabled = false
local DamageMultiplierEnabled = false
local DamageMultiplierValue = 2

local FOVCircleSize = 150
local currentTarget = nil
local targetLocked = false
local cycleIndex = 0

-- Visuals (Remain same as before)
local CrosshairEnabled = false
local CrosshairStyle = "Dot"
local HitmarkerEnabled = false
local DamageIndicators = false
local FovChangerEnabled = false
local FovValue = 90
local WalkspeedEnabled = false
local WalkspeedValue = 50
local NoFogEnabled = false
local BrightnessEnabled = false
local BrightnessValue = 2
local FullBrightEnabled = false
local ChamsEnabled = false
local ChamsColor = Color3.fromRGB(255, 0, 0)
local ChamsTransparency = 0.3
local WireframeEnabled = false
local ViewmodelFOV = 70
local NoCameraShake = false

-- ESP Extended (Remain same)
local EspEnabled = false
local TracersEnabled = false
local TracerType = "Line"
local HealthBarEnabled = true
local BoxOutlineEnabled = true
local BoxType = "2D"
local DistanceEnabled = true
local WeaponESPEnabled = false
local SkeletonESPEnabled = false
local HealthNumbersEnabled = false
local ChamsESPEnabled = false
local NameTagsEnabled = true
local TeamColorESP = true
local MaxRenderDistance = 500

local TracerColor = Color3.fromRGB(255, 0, 0)
local ESPColor = Color3.fromRGB(0, 255, 255)
local NameColor = Color3.fromRGB(255, 255, 255)
local SkeletonColor = Color3.fromRGB(255, 255, 255)

-- Movement (Remain same)
local JumpPowerEnabled = false
local JumpPowerValue = 50
local NoclipEnabled = false
local FlyEnabled = false
local FlySpeed = 50
local InfiniteJumpEnabled = false
local SpeedBoostEnabled = false
local SpeedBoostAmount = 1.5

-- Misc (Remain same)
local AntiAFKEnabled = false
local AutoRejoinEnabled = false
local AutoRespawnEnabled = false
local ChatSpamEnabled = false
local ChatSpamMessage = "Blazed X is the best!"
local ChatSpamDelay = 5
local NameStealEnabled = false
local CustomName = "Blazed_User"
local BypassKickEnabled = false
local PingDisplayEnabled = false
local FPSDisplayEnabled = false

-- ESP Storage (Remain same)
local espBoxes = {}
local espTracers = {}
local espNames = {}
local espHealthBars = {}
local espWeapons = {}
local espSkeletons = {}
local espChams = {}

-- Menu Toggle (Remain same)
local MenuOpen = true
local isFlying = false
local flyVelocity = Vector3.new(0, 0, 0)
local ping = 0
local fps = 60

-- FOV Circle Drawing
local fovCircle = nil

-- Helper function to create FOV circle
local function createFOVCircle()
    if fovCircle then fovCircle:Remove() end
    if AimlockFOVCircle then
        fovCircle = Drawing.new("Circle")
        fovCircle.Radius = SilentFOV
        fovCircle.Thickness = 2
        fovCircle.NumSides = 36
        fovCircle.Color = AimlockFOVCircleColor
        fovCircle.Transparency = AimlockFOVCircleTransparency
        fovCircle.Filled = false
        fovCircle.Visible = true
    end
end

UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightShift then
        MenuOpen = not MenuOpen
        Window:SetVisibility(MenuOpen)
        Library:Notify(MenuOpen and "Menu Opened" or "Menu Hidden", 2)
    end
    
    if AimlockCycleTargets and input.KeyCode == Enum.KeyCode[AimlockCycleKey] then
        cycleTargets()
    end
    
    if AimlockOnKey and input.KeyCode == Enum.KeyCode[AimlockKey] then
        AimlockEnabled = true
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if AimlockOnKey and input.KeyCode == Enum.KeyCode[AimlockKey] then
        AimlockEnabled = false
        targetLocked = false
        currentTarget = nil
    end
end)

-- ==================== ENHANCED HELPER FUNCTIONS ====================
local function isFriend(player)
    for _, friend in pairs(AimlockFriendsList) do
        if friend == player.Name then return true end
    end
    return false
end

local function isBlacklisted(player)
    for _, black in pairs(AimlockBlacklist) do
        if black == player.Name then return true end
    end
    return false
end

local function isInADS()
    local char = LocalPlayer.Character
    local tool = char and char:FindFirstChildWhichIsA("Tool")
    if tool then
        local viewmodel = tool:FindFirstChild("Viewmodel")
        if viewmodel then
            return viewmodel:GetAttribute("Aiming") or false
        end
    end
    return false
end

local function getHealthPercent(player)
    local hum = player.Character and player.Character:FindFirstChild("Humanoid")
    return hum and hum.Health / hum.MaxHealth or 0
end

local function getPlayerColor(player)
    if not TeamColorESP then return ESPColor end
    if player.Team == LocalPlayer.Team then
        return Color3.fromRGB(0, 255, 0)
    else
        return Color3.fromRGB(255, 0, 0)
    end
end

local function isTeammate(player)
    if not TeamCheckEnabled and not AimlockTeamCheck then return false end
    if player.Team == LocalPlayer.Team then return true end
    return isFriend(player)
end

local function isVisible(target, partName)
    if not WallCheckEnabled then return true end
    local localChar = LocalPlayer.Character
    local targetChar = target.Character
    if not localChar or not targetChar then return false end
    local root = localChar:FindFirstChild("HumanoidRootPart")
    local tpart = targetChar:FindFirstChild(partName or WallCheckPart) or targetChar:FindFirstChild("Head")
    if not root or not tpart then return false end
    local dir = (tpart.Position - root.Position)
    local params = RaycastParams.new()
    params.FilterDescendantsInstances = {localChar, targetChar}
    params.FilterType = Enum.RaycastFilterType.Blacklist
    local res = workspace:Raycast(root.Position, dir.Unit * dir.Magnitude, params)
    return res == nil
end

local function getPredictedPosition(part, targetPlayer)
    if not PredictionEnabled then return part.Position end
    
    local velocity = part.AssemblyLinearVelocity or Vector3.new()
    local position = part.Position
    
    if PredictionType == "Linear" then
        return position + (velocity * PredictionAmount)
    elseif PredictionType == "Gravity" then
        local gravity = workspace.Gravity
        local yVelocity = velocity.Y
        local time = PredictionAmount
        local yOffset = (yVelocity * time) + (0.5 * gravity * time * time)
        return position + Vector3.new(velocity.X * time, yOffset, velocity.Z * time)
    elseif PredictionType == "Advanced" then
        local targetChar = targetPlayer.Character
        local hum = targetChar and targetChar:FindFirstChild("Humanoid")
        local isJumping = hum and hum:GetState() == Enum.HumanoidStateType.Jumping
        
        if isJumping and PredictionIncludeJumping then
            local jumpVelocity = Vector3.new(0, 50, 0)
            return position + (velocity + jumpVelocity) * PredictionAmount
        else
            return position + (velocity * PredictionAmount * PredictionVelocityMultiplier)
        end
    end
    
    return position
end

local function getDynamicFOV(targetPlayer)
    if SilentFOVType == "Static" then
        return SilentFOV
    elseif SilentFOVType == "Dynamic" then
        local distance = getDistanceToPlayer(targetPlayer)
        local dynamicFOV = SilentFOV * (100 / math.max(distance, 10))
        return math.clamp(dynamicFOV, 30, SilentFOV)
    elseif SilentFOVType == "Distance" then
        return math.clamp(SilentFOV / (getDistanceToPlayer(targetPlayer) / 10), 30, SilentFOV)
    end
    return SilentFOV
end

local function getDistanceToPlayer(player)
    local localChar = LocalPlayer.Character
    local targetChar = player.Character
    if not localChar or not targetChar then return 9999 end
    local localRoot = localChar:FindFirstChild("HumanoidRootPart")
    local targetRoot = targetChar:FindFirstChild("HumanoidRootPart")
    if not localRoot or not targetRoot then return 9999 end
    return (localRoot.Position - targetRoot.Position).Magnitude
end

local function getPriorityScore(player)
    local score = 0
    local distance = getDistanceToPlayer(player)
    local health = player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health or 0
    
    if SilentPriority == "Distance" then
        score = -distance
    elseif SilentPriority == "Health" then
        score = -health
    elseif SilentPriority == "Crosshair" then
        local mouse = UserInputService:GetMouseLocation()
        local head = player.Character and player.Character:FindFirstChild("Head")
        if head then
            local pos, onScreen = Camera:WorldToViewportPoint(head.Position)
            if onScreen then
                score = -(Vector2.new(pos.X, pos.Y) - mouse).Magnitude
            else
                score = -9999
            end
        end
    elseif SilentPriority == "Team" then
        score = isTeammate(player) and -1000 or 1000
    end
    return score
end

local function getClosestTarget()
    local closest, bestScore = nil, -math.huge
    local mouse = UserInputService:GetMouseLocation()
    
    -- If target locked and still valid
    if targetLocked and currentTarget and currentTarget.Character then
        local hum = currentTarget.Character:FindFirstChild("Humanoid")
        if hum and hum.Health > 0 then
            return currentTarget
        elseif AimlockSwitchOnDeath then
            targetLocked = false
            currentTarget = nil
        end
    end
    
    for _, plr in Players:GetPlayers() do
        if plr ~= LocalPlayer and plr.Character and not isTeammate(plr) and not isBlacklisted(plr) then
            local hum = plr.Character:FindFirstChild("Humanoid")
            if hum and hum.Health > 0 then
                -- Distance check
                local distance = getDistanceToPlayer(plr)
                if distance > AimlockMaxDistance or distance < AimlockMinDistance then continue end
                
                -- Health check for triggerbot
                if TriggerBotEnabled and (hum.Health > TriggerBotHealthBelow or hum.Health < TriggerBotHealthAbove) then
                    continue
                end
                
                local part = plr.Character:FindFirstChild(SilentHitPart) or plr.Character:FindFirstChild("Head")
                if part then
                    local predictedPos = getPredictedPosition(part, plr)
                    local pos, onScreen = Camera:WorldToViewportPoint(predictedPos)
                    
                    local fov = getDynamicFOV(plr)
                    local screenDist = (Vector2.new(pos.X, pos.Y) - mouse).Magnitude
                    
                    local visible = not AimlockVisibleOnly or isVisible(plr, SilentHitPart)
                    if onScreen and screenDist < fov and visible then
                        local score = getPriorityScore(plr)
                        
                        if AimlockNearestToCrosshair then
                            score = score - screenDist
                        end
                        
                        if score > bestScore then
                            bestScore = score
                            closest = plr
                        end
                    end
                end
            end
        end
    end
    
    if closest and AimlockTargetLock then
        targetLocked = true
        currentTarget = closest
    end
    
    return closest
end

local function cycleTargets()
    local targets = {}
    for _, plr in Players:GetPlayers() do
        if plr ~= LocalPlayer and plr.Character and not isTeammate(plr) then
            local hum = plr.Character:FindFirstChild("Humanoid")
            if hum and hum.Health > 0 then
                table.insert(targets, plr)
            end
        end
    end
    
    if #targets > 0 then
        cycleIndex = cycleIndex % #targets + 1
        currentTarget = targets[cycleIndex]
        targetLocked = true
        Library:Notify("Targeting: " .. currentTarget.Name, 1)
    end
end

local function getAimPart(target)
    if AimlockAimAtFeet then
        return target.Character:FindFirstChild("HumanoidRootPart") or target.Character:FindFirstChild("Head")
    end
    
    if AimlockHeadshotPriority and target.Character:FindFirstChild("Head") then
        return target.Character.Head
    elseif AimlockBodyPriority and target.Character:FindFirstChild("UpperTorso") then
        return target.Character.UpperTorso
    elseif AimlockLimbPriority then
        for _, part in pairs(target.Character:GetChildren()) do
            if part:IsA("BasePart") and (part.Name:match("Arm") or part.Name:match("Leg")) then
                return part
            end
        end
    end
    
    return target.Character:FindFirstChild(AimlockPart) or target.Character:FindFirstChild("Head")
end

-- Aimlock with randomization
local function updateAimlock()
    if not AimlockEnabled then return end
    
    if AimlockOnKey and not UserInputService:IsKeyDown(Enum.KeyCode[AimlockKey]) then
        return
    end
    
    local target = targetLocked and currentTarget or getClosestTarget()
    if target and target.Character then
        local part = getAimPart(target)
        if part then
            local predictedPos = getPredictedPosition(part, target)
            
            -- Bullet drop prediction
            if AimlockPredictBulletDrop then
                local distance = (Camera.CFrame.Position - predictedPos).Magnitude
                local dropAmount = (distance * distance) / (2 * 500^2) * workspace.Gravity
                predictedPos = predictedPos - Vector3.new(0, dropAmount, 0)
            end
            
            -- Add randomization
            if AimlockRandomization > 0 then
                predictedPos = predictedPos + Vector3.new(
                    (math.random() - 0.5) * AimlockRandomization,
                    (math.random() - 0.5) * AimlockRandomization,
                    (math.random() - 0.5) * AimlockRandomization
                )
            end
            
            local goal = CFrame.new(Camera.CFrame.Position, predictedPos)
            
            if AimlockType == "Camera" then
                Camera.CFrame = Camera.CFrame:Lerp(goal, AimlockSmoothing)
            elseif AimlockType == "Mouse" then
                local screenPos = Camera:WorldToViewportPoint(predictedPos)
                local mousePos = UserInputService:GetMouseLocation()
                local delta = Vector2.new(screenPos.X - mousePos.X, screenPos.Y - mousePos.Y)
                mousemoverel(delta.X * AimlockSmoothing, delta.Y * AimlockSmoothing)
            elseif AimlockType == "Smooth" then
                local steps = 10
                for i = 1, steps do
                    task.wait()
                    local lerped = Camera.CFrame:Lerp(goal, i/steps * AimlockSmoothing)
                    Camera.CFrame = lerped
                end
            end
            
            -- Snap aim
            if AimlockSnap and (Vector2.new(Camera.CFrame.LookVector.X, Camera.CFrame.LookVector.Y) - Vector2.new(goal.LookVector.X, goal.LookVector.Y)).Magnitude < AimlockSnapFOV then
                Camera.CFrame = goal
            end
        end
    end
end

-- Enhanced Trigger Bot
local function checkTrigger()
    if not TriggerBotEnabled then return end
    
    if TriggerBotADSOnly and not isInADS() then return end
    if TriggerBotHipOnly and isInADS() then return end
    
    local target = getClosestTarget()
    if target and isVisible(target, TriggerBotHeadOnly and "Head" or TriggerBotBodyOnly and "UpperTorso" or nil) then
        local delay = TriggerBotDelay
        if TriggerBotRandomDelay then
            delay = math.random(TriggerBotRandomMin * 100, TriggerBotRandomMax * 100) / 100
        end
        
        task.wait(delay)
        
        if TriggerBotKey == "MouseButton2" then
            VirtualInput:SendMouseButtonEvent(Enum.UserInputType.MouseButton2, 0, true, false, Vector2.new(0, 0), 0)
            if not TriggerBotHold then
                task.wait(0.05)
                VirtualInput:SendMouseButtonEvent(Enum.UserInputType.MouseButton2, 0, false, false, Vector2.new(0, 0), 0)
            end
        elseif TriggerBotKey == "MouseButton1" then
            VirtualInput:SendMouseButtonEvent(Enum.UserInputType.MouseButton1, 0, true, false, Vector2.new(0, 0), 0)
            if not TriggerBotHold then
                task.wait(0.05)
                VirtualInput:SendMouseButtonEvent(Enum.UserInputType.MouseButton1, 0, false, false, Vector2.new(0, 0), 0)
            end
        end
        createHitmarker()
    end
end

-- Auto Shoot
local function checkAutoShoot()
    if not AutoShootEnabled then return end
    
    local target = getClosestTarget()
    if target and target.Character then
        local part = target.Character:FindFirstChild(AutoShootPart) or target.Character:FindFirstChild("Head")
        if part then
            local visible = not AutoShootWhenVisible or isVisible(target, AutoShootPart)
            if visible then
                VirtualInput:SendMouseButtonEvent(Enum.UserInputType.MouseButton1, 0, true, false, Vector2.new(0, 0), 0)
                task.wait(AutoShootDelay)
                VirtualInput:SendMouseButtonEvent(Enum.UserInputType.MouseButton1, 0, false, false, Vector2.new(0, 0), 0)
                createHitmarker()
            end
        end
    end
end

-- Aim Assist
local function updateAimAssist()
    if not AimAssistEnabled then return end
    
    local target = getClosestTarget()
    if target and target.Character then
        local part = target.Character:FindFirstChild(AimlockPart) or target.Character:FindFirstChild("Head")
        if part then
            local predictedPos = getPredictedPosition(part, target)
            local screenPos = Camera:WorldToViewportPoint(predictedPos)
            local mousePos = UserInputService:GetMouseLocation()
            local distance = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
            
            if distance < AimAssistFOV then
                local pull = (Vector2.new(screenPos.X, screenPos.Y) - mousePos) * AimAssistStrength * AimAssistPull
                mousemoverel(pull.X, pull.Y)
            end
        end
    end
end

-- Anti Recoil/Spread
local function updateAntiRecoil()
    if not AntiRecoilEnabled then return end
    
    local tool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildWhichIsA("Tool")
    if tool then
        local mouse = LocalPlayer:GetMouse()
        local recoilOffset = Vector2.new(
            (math.random() - 0.5) * AntiRecoilStrength * 10,
            -AntiRecoilStrength * 5
        )
        mousemoverel(recoilOffset.X, recoilOffset.Y)
    end
end

-- Hitmarker (Remain same)
local function createHitmarker()
    if not HitmarkerEnabled then return end
    local marker = Drawing.new("Line")
    local center = Camera.ViewportSize / 2
    marker.From = center - Vector2.new(10, 10)
    marker.To = center + Vector2.new(10, 10)
    marker.Thickness = 2
    marker.Color = Color3.fromRGB(255, 255, 255)
    marker.Visible = true
    
    local marker2 = Drawing.new("Line")
    marker2.From = center - Vector2.new(-10, 10)
    marker2.To = center + Vector2.new(-10, 10)
    marker2.Thickness = 2
    marker2.Color = Color3.fromRGB(255, 255, 255)
    marker2.Visible = true
    
    task.wait(0.1)
    marker.Visible = false
    marker2.Visible = false
    marker:Remove()
    marker2:Remove()
end

-- Damage Indicator (Remain same)
local function createDamageIndicator(position, damage)
    if not DamageIndicators then return end
    local pos, onScreen = Camera:WorldToViewportPoint(position)
    if not onScreen then return end
    
    local text = Drawing.new("Text")
    text.Text = "-" .. damage
    text.Position = Vector2.new(pos.X, pos.Y)
    text.Size = 20
    text.Color = Color3.fromRGB(255, 0, 0)
    text.Outline = true
    text.Center = true
    
    for i = 1, 20 do
        text.Position = text.Position - Vector2.new(0, 2)
        text.Transparency = i / 20
        task.wait()
    end
    text:Remove()
end

-- Chams (Remain same)
local function setupChams(player)
    if not ChamsEnabled then return end
    if espChams[player] then
        for _, cham in pairs(espChams[player]) do
            cham:Destroy()
        end
        espChams[player] = nil
    end
    
    local char = player.Character
    if not char then return end
    
    espChams[player] = {}
    for _, part in ipairs(char:GetDescendants()) do
        if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
            local cham = Instance.new("BoxHandleAdornment")
            cham.Adornee = part
            cham.Size = part.Size
            cham.Color3 = ChamsColor
            cham.Transparency = ChamsTransparency
            cham.ZIndex = 0
            cham.AlwaysOnTop = true
            cham.Parent = char
            table.insert(espChams[player], cham)
        end
    end
end

-- Skeleton ESP (Remain same)
local function drawSkeleton(player)
    if not SkeletonESPEnabled then return end
    local char = player.Character
    if not char then return end
    
    if not espSkeletons[player] then
        espSkeletons[player] = {}
        for i = 1, 15 do
            local line = Drawing.new("Line")
            line.Thickness = 1
            line.Color = SkeletonColor
            espSkeletons[player][i] = line
        end
    end
    
    local head = char:FindFirstChild("Head")
    local hrp = char:FindFirstChild("HumanoidRootPart")
    
    if not head or not hrp then return end
    
    local headPos = Camera:WorldToViewportPoint(head.Position)
    local hrpPos = Camera:WorldToViewportPoint(hrp.Position)
    
    if headPos.Z < 0 or hrpPos.Z < 0 then return end
    
    local lines = espSkeletons[player]
    if #lines >= 2 then
        lines[1].From = Vector2.new(headPos.X, headPos.Y)
        lines[1].To = Vector2.new(hrpPos.X, hrpPos.Y)
        lines[1].Visible = true
    end
end

-- Weapon ESP (Remain same)
local function getPlayerWeapon(player)
    local char = player.Character
    if not char then return "Unknown" end
    local tool = char:FindFirstChildWhichIsA("Tool")
    return tool and tool.Name or "None"
end

-- Anti AFK (Remain same)
local function antiAFK()
    if not AntiAFKEnabled then return end
    local vu = game:GetService("VirtualUser")
    vu:Button2Down(Vector2.new(0, 0))
    task.wait(0.1)
    vu:Button2Up(Vector2.new(0, 0))
end

-- Chat Spam (Remain same)
local function chatSpam()
    if not ChatSpamEnabled then return end
    local args = {
        [1] = ChatSpamMessage,
        [2] = "All"
    }
    game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest"):FireServer(unpack(args))
end

-- Name Steal (Remain same)
local function stealName()
    if not NameStealEnabled then return end
    local success, err = pcall(function()
        game:GetService("Players").LocalPlayer.Name = CustomName
    end)
    if not success then
        Library:Notify("Name steal not supported in this game", 3)
    end
end

-- Close Script Function (Remain same)
local function closeScript()
    -- Clean up ESP drawings
    for player, _ in pairs(espBoxes) do
        if espBoxes[player] then
            for _, line in pairs(espBoxes[player]) do
                line:Remove()
            end
        end
        if espNames[player] then espNames[player]:Remove() end
        if espHealthBars[player] then espHealthBars[player]:Remove() end
        if espTracers[player] then espTracers[player]:Remove() end
        if espWeapons[player] then espWeapons[player]:Remove() end
        if espSkeletons[player] then
            for _, line in pairs(espSkeletons[player]) do
                line:Remove()
            end
        end
        if espChams[player] then
            for _, cham in pairs(espChams[player]) do
                cham:Destroy()
            end
        end
    end
    
    -- Clean up UI
    if pingText then pingText:Remove() end
    if fpsText then fpsText:Remove() end
    if crosshair then crosshair:Remove() end
    if fovCircle then fovCircle:Remove() end
    
    -- Reset character properties
    local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
    if hum then
        hum.WalkSpeed = 16
        hum.JumpPower = 50
        if isFlying then
            hum.PlatformStand = false
        end
    end
    
    -- Close window
    Window:SetVisibility(false)
    
    Library:Notify("Script closed!", 2)
    task.wait(1)
    -- Unload the script
    game:GetService("ScriptContext"):Error("Script unloaded")
end

-- Infinite Jump (Remain same)
UserInputService.JumpRequest:Connect(function()
    if InfiniteJumpEnabled then
        local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
        if hum then
            hum:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

-- Fly System (Remain same)
local lastFlyToggle = 0
local function startFly()
    if not FlyEnabled then return end
    isFlying = true
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChild("Humanoid")
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    
    if hum then
        hum.PlatformStand = true
    end
    
    local connections = {}
    
    connections[1] = RunService.RenderStepped:Connect(function()
        if not FlyEnabled or not isFlying or not char or not hrp then
            for _, conn in pairs(connections) do
                conn:Disconnect()
            end
            return
        end
        
        local moveDirection = Vector3.new()
        local cameraCFrame = Camera.CFrame
        
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
            moveDirection = moveDirection + cameraCFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
            moveDirection = moveDirection - cameraCFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
            moveDirection = moveDirection - cameraCFrame.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
            moveDirection = moveDirection + cameraCFrame.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            moveDirection = moveDirection + Vector3.new(0, 1, 0)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
            moveDirection = moveDirection - Vector3.new(0, 1, 0)
        end
        
        if moveDirection.Magnitude > 0 then
            moveDirection = moveDirection.Unit
        end
        
        hrp.Velocity = moveDirection * FlySpeed
    end)
    
    connections[2] = UserInputService.InputBegan:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.F and (os.clock() - lastFlyToggle) > 0.5 then
            lastFlyToggle = os.clock()
            FlyEnabled = false
            isFlying = false
            if hum then
                hum.PlatformStand = false
            end
            for _, conn in pairs(connections) do
                conn:Disconnect()
            end
        end
    end)
end

-- Noclip (Remain same)
local function updateNoclip()
    if not NoclipEnabled then return end
    local char = LocalPlayer.Character
    if char then
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end

-- FOV Changer (Remain same)
local function updateFOV()
    if FovChangerEnabled then
        Camera.FieldOfView = FovValue
    else
        Camera.FieldOfView = 70
    end
end

-- Ping Display (Remain same)
local function updatePingDisplay()
    if not PingDisplayEnabled then return end
    local stats = game:GetService("Stats")
    local pingStat = stats.Network:FindFirstChild("ServerStatsItem")
    if pingStat then        ping = math.floor(pingStat:GetValueString())
    end
end

-- FPS Display (Remain same)
local function updateFPSDisplay()
    if not FPSDisplayEnabled then return end
    fps = math.floor(1 / RunService.RenderStepped:Wait())
end

-- Auto Respawn (Remain same)
local function autoRespawn()
    if not AutoRespawnEnabled then return end
    LocalPlayer.CharacterAdded:Wait()
end

-- ESP Update (Remain same but with aimbot integration)
local function updateESP()
    local bottom = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y)
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player == LocalPlayer then continue end
        if isTeammate(player) then continue end
        
        local char = player.Character
        if not char then continue end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local head = char:FindFirstChild("Head")
        local hum = char:FindFirstChild("Humanoid")
        if not hrp or not head or not hum or hum.Health <= 0 then continue end
        
        local distance = (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and (hrp.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude) or 0
        if distance > MaxRenderDistance then continue end
        
        local headPos = Camera:WorldToViewportPoint(head.Position)
        if headPos.Z < 0 then continue end
        
        local health = getHealthPercent(player)
        local playerColor = getPlayerColor(player)
        
        -- Name Tags
        if NameTagsEnabled then
            if not espNames[player] then
                espNames[player] = Drawing.new("Text")
                espNames[player].Size = 14
                espNames[player].Center = true
                espNames[player].Outline = true
                espNames[player].Color = NameColor
            end
            
            local nameText = player.Name
            if DistanceEnabled then
                nameText = string.format("%s [%.0fm]", player.Name, distance/3)
            end
            if HealthNumbersEnabled then
                nameText = string.format("%s [%.0f HP]", nameText, hum.Health)
            end
            
            -- Show target indicator
            if currentTarget == player and targetLocked then
                nameText = "🔴 " .. nameText .. " 🔴"
                espNames[player].Color = Color3.fromRGB(255, 0, 0)
            else
                espNames[player].Color = NameColor
            end
            
            espNames[player].Text = nameText
            espNames[player].Position = Vector2.new(headPos.X, headPos.Y - 35)
            espNames[player].Visible = EspEnabled
        end
        
        -- Weapon ESP
        if WeaponESPEnabled then
            if not espWeapons[player] then
                espWeapons[player] = Drawing.new("Text")
                espWeapons[player].Size = 12
                espWeapons[player].Center = true
                espWeapons[player].Outline = true
                espWeapons[player].Color = Color3.fromRGB(255, 255, 255)
            end
            local weapon = getPlayerWeapon(player)
            espWeapons[player].Text = weapon
            espWeapons[player].Position = Vector2.new(headPos.X, headPos.Y - 20)
            espWeapons[player].Visible = EspEnabled
        end
        
        -- Box ESP
        if EspEnabled then
            if not espBoxes[player] then
                espBoxes[player] = {}
                for i = 1, 4 do
                    espBoxes[player][i] = Drawing.new("Line")
                    espBoxes[player][i].Color = playerColor
                    espBoxes[player][i].Thickness = 2
                end
            end
            local size = 1800 / headPos.Z
            local x, y = headPos.X, headPos.Y
            local p = {
                Vector2.new(x-size/2,y-size), 
                Vector2.new(x+size/2,y-size), 
                Vector2.new(x+size/2,y+size*1.8), 
                Vector2.new(x-size/2,y+size*1.8)
            }
            for i = 1, 4 do
                local nxt = i % 4 + 1
                espBoxes[player][i].From = p[i]
                espBoxes[player][i].To = p[nxt]
                espBoxes[player][i].Color = currentTarget == player and Color3.fromRGB(255, 0, 0) or playerColor
                espBoxes[player][i].Visible = true
            end
        end
        
        -- Health Bar
        if HealthBarEnabled then
            if not espHealthBars[player] then
                espHealthBars[player] = Drawing.new("Line")
                espHealthBars[player].Thickness = 4
            end
            local barHeight = 1800 / headPos.Z * 1.8
            local x = headPos.X - (1800 / headPos.Z)/2 - 12
            espHealthBars[player].From = Vector2.new(x, headPos.Y - barHeight/2)
            espHealthBars[player].To = Vector2.new(x, headPos.Y - barHeight/2 + barHeight * health)
            espHealthBars[player].Color = Color3.fromHSV(health * 0.3, 1, 1)
            espHealthBars[player].Visible = true
        end
        
        -- Tracers
        if TracersEnabled then
            if not espTracers[player] then
                espTracers[player] = Drawing.new("Line")
                espTracers[player].Thickness = 2
                espTracers[player].Color = TracerColor
            end
            local size = 1800 / headPos.Z
            espTracers[player].From = bottom
            espTracers[player].To = Vector2.new(headPos.X, headPos.Y + size/2)
            espTracers[player].Visible = true
        end
        
        -- Skeleton ESP
        if SkeletonESPEnabled then
            drawSkeleton(player)
        end
        
        -- Chams ESP
        if ChamsESPEnabled then
            setupChams(player)
        end
    end
    
    -- Cleanup for players that left
    for player, _ in pairs(espBoxes) do
        if not player.Parent then
            if espBoxes[player] then
                for _, line in pairs(espBoxes[player]) do
                    line:Remove()
                end
                espBoxes[player] = nil
            end
            if espNames[player] then espNames[player]:Remove() espNames[player] = nil end
            if espHealthBars[player] then espHealthBars[player]:Remove() espHealthBars[player] = nil end
            if espTracers[player] then espTracers[player]:Remove() espTracers[player] = nil end
            if espWeapons[player] then espWeapons[player]:Remove() espWeapons[player] = nil end
            if espSkeletons[player] then
                for _, line in pairs(espSkeletons[player]) do
                    line:Remove()
                end
                espSkeletons[player] = nil
            end
            if espChams[player] then
                for _, cham in pairs(espChams[player]) do
                    cham:Destroy()
                end
                espChams[player] = nil
            end
        end
    end
end

-- Visuals update (Remain same)
local function updateVisuals()
    if NoFogEnabled then
        Lighting.FogEnd = 999999
        Lighting.FogStart = 0
    else
        Lighting.FogEnd = 100000
        Lighting.FogStart = 0
    end
    
    if BrightnessEnabled then
        Lighting.Brightness = BrightnessValue
        Lighting.ClockTime = 14
    else
        Lighting.Brightness = 2
    end
    
    if FullBrightEnabled then
        Lighting.Ambient = Color3.fromRGB(255, 255, 255)
        Lighting.ColorShift_Top = Color3.fromRGB(255, 255, 255)
        Lighting.ColorShift_Bottom = Color3.fromRGB(255, 255, 255)
        Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
    else
        Lighting.Ambient = Color3.fromRGB(0, 0, 0)
    end
    
    updateFOV()
end

-- Crosshair (Remain same)
local crosshair = nil
local function updateCrosshair()
    if CrosshairEnabled and not crosshair then
        if CrosshairStyle == "Dot" then
            crosshair = Drawing.new("Circle")
            crosshair.Radius = 3
            crosshair.Filled = true
            crosshair.Thickness = 2
            crosshair.Color = Color3.fromRGB(255, 255, 255)
        elseif CrosshairStyle == "Cross" then
            crosshair = Drawing.new("Line")
            crosshair.Thickness = 2
            crosshair.Color = Color3.fromRGB(255, 255, 255)
        end
        crosshair.Visible = true
    elseif not CrosshairEnabled and crosshair then
        crosshair.Visible = false
    end
    
    if crosshair and CrosshairEnabled then
        local mousePos = UserInputService:GetMouseLocation()
        if CrosshairStyle == "Dot" then
            crosshair.Position = mousePos
            crosshair.Visible = true
        end
    end
end

-- Update FOV Circle
local function updateFOVCircle()
    if AimlockFOVCircle then
        if not fovCircle then
            createFOVCircle()
        end
        if fovCircle then
            local mousePos = UserInputService:GetMouseLocation()
            fovCircle.Position = mousePos
            fovCircle.Radius = SilentFOV
            fovCircle.Color = AimlockFOVCircleColor
            fovCircle.Transparency = AimlockFOVCircleTransparency
            fovCircle.Visible = true
        end
    elseif fovCircle then
        fovCircle.Visible = false
    end
end

-- Main Loops
RunService.RenderStepped:Connect(function()
    updateESP()
    updateAimlock()
    updateAimAssist()
    updateCrosshair()
    updateVisuals()
    updateNoclip()
    updatePingDisplay()
    updateFPSDisplay()
    updateFOVCircle()
end)

RunService.Heartbeat:Connect(function()
    local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
    if hum then
        hum.WalkSpeed = WalkspeedEnabled and WalkspeedValue or 16
        hum.JumpPower = JumpPowerEnabled and JumpPowerValue or 50
        
        if SpeedBoostEnabled then
            hum.WalkSpeed = hum.WalkSpeed * SpeedBoostAmount
        end
    end
    
    checkTrigger()
    checkAutoShoot()
    updateAntiRecoil()
    
    if FlyEnabled and not isFlying then
        startFly()
    end
end)

-- Anti AFK loop
task.spawn(function()
    while true do
        antiAFK()
        task.wait(60)
    end
end)

-- Chat spam loop
task.spawn(function()
    while true do
        chatSpam()
        task.wait(ChatSpamDelay)
    end
end)

-- Auto Rejoin
if AutoRejoinEnabled then
    game:GetService("Players").LocalPlayer.OnTeleport:Connect(function(state)
        if state == Enum.TeleportState.Failed then
            task.wait(5)
            game:GetService("TeleportService"):Teleport(game.PlaceId)
        end
    end)
end

-- ==================== UI CREATION ====================
-- Combat Tab - Main Group
local CombatGroup = Tabs.Combat:AddLeftGroupbox("Core Combat Settings")
CombatGroup:AddToggle("SilentAim", {Text = "Silent Aim", Callback = function(v) SilentEnabled = v end})
CombatGroup:AddToggle("Aimlock", {Text = "Aimlock", Callback = function(v) 
    AimlockEnabled = v
    if not v then
        targetLocked = false
        currentTarget = nil
    end
end})
CombatGroup:AddToggle("TriggerBot", {Text = "Trigger Bot", Callback = function(v) TriggerBotEnabled = v end})
CombatGroup:AddToggle("AimAssist", {Text = "Aim Assist", Callback = function(v) AimAssistEnabled = v end})
CombatGroup:AddToggle("AutoShoot", {Text = "Auto Shoot", Callback = function(v) AutoShootEnabled = v end})
CombatGroup:AddToggle("Prediction", {Text = "Prediction", Callback = function(v) PredictionEnabled = v end})
CombatGroup:AddToggle("TeamCheck", {Text = "Team Check", Callback = function(v) TeamCheckEnabled = v end})
CombatGroup:AddToggle("WallCheck", {Text = "Wall Check", Default = true, Callback = function(v) WallCheckEnabled = v end})

-- Combat Tab - Advanced Aim Settings
local CombatAdvanced = Tabs.Combat:AddRightGroupbox("Advanced Aim Settings")
CombatAdvanced:AddDropdown("AimPart", {
    Text = "Aim Part",
    Values = {"Head", "HumanoidRootPart", "UpperTorso", "LowerTorso"},
    Default = "Head",
    Callback = function(v) 
        SilentHitPart = v
        AimlockPart = v
        AutoShootPart = v
    end
})
CombatAdvanced:AddSlider("AimFOV", {Text = "Aim FOV", Min = 30, Max = 500, Default = 150, Callback = function(v) SilentFOV = v end})
CombatAdvanced:AddDropdown("FOVType", {
    Text = "FOV Type",
    Values = {"Static", "Dynamic", "Distance"},
    Default = "Dynamic",
    Callback = function(v) SilentFOVType = v end
})
CombatAdvanced:AddDropdown("PriorityMode", {
    Text = "Target Priority",
    Values = {"Distance", "Health", "Crosshair", "Team"},
    Default = "Distance",
    Callback = function(v) SilentPriority = v end
})
CombatAdvanced:AddSlider("AimSmoothing", {Text = "Aim Smoothing", Min = 0.05, Max = 0.5, Default = 0.2, Callback = function(v) AimlockSmoothing = v end})
CombatAdvanced:AddSlider("Randomization", {Text = "Randomization (Anti-Ban)", Min = 0, Max = 5, Default = 0, Callback = function(v) AimlockRandomization = v end})

-- Combat Tab - Prediction Settings
local PredictionGroup = Tabs.Combat:AddLeftGroupbox("Prediction Settings")
PredictionGroup:AddSlider("PredictionAmount", {Text = "Prediction Amount", Min = 0.05, Max = 0.5, Default = 0.15, Callback = function(v) PredictionAmount = v end})
PredictionGroup:AddDropdown("PredictionType", {
    Text = "Prediction Type",
    Values = {"Linear", "Gravity", "Advanced"},
    Default = "Linear",
    Callback = function(v) PredictionType = v end
})
PredictionGroup:AddSlider("VelocityMultiplier", {Text = "Velocity Multiplier", Min = 0.5, Max = 2, Default = 1, Callback = function(v) PredictionVelocityMultiplier = v end})
PredictionGroup:AddToggle("PredictBulletDrop", {Text = "Predict Bullet Drop", Callback = function(v) AimlockPredictBulletDrop = v end})

-- Combat Tab - Trigger Bot Settings
local TriggerGroup = Tabs.Combat:AddRightGroupbox("Trigger Bot Settings")
TriggerGroup:AddSlider("TriggerDelay", {Text = "Trigger Delay", Min = 0, Max = 0.5, Default = 0.1, Callback = function(v) TriggerBotDelay = v end})
TriggerGroup:AddToggle("RandomDelay", {Text = "Random Delay", Callback = function(v) TriggerBotRandomDelay = v end})
TriggerGroup:AddSlider("RandomMin", {Text = "Random Min (s)", Min = 0.01, Max = 0.2, Default = 0.05, Callback = function(v) TriggerBotRandomMin = v end})
TriggerGroup:AddSlider("RandomMax", {Text = "Random Max (s)", Min = 0.1, Max = 0.5, Default = 0.2, Callback = function(v) TriggerBotRandomMax = v end})
TriggerGroup:AddDropdown("TriggerKey", {
    Text = "Trigger Key",
    Values = {"MouseButton1", "MouseButton2"},
    Default = "MouseButton2",
    Callback = function(v) TriggerBotKey = v end
})
TriggerGroup:AddToggle("HoldMode", {Text = "Hold Mode (Keep Shooting)", Callback = function(v) TriggerBotHold = v end})
TriggerGroup:AddToggle("ADSOnly", {Text = "ADS Only", Callback = function(v) TriggerBotADSOnly = v end})
TriggerGroup:AddToggle("HipOnly", {Text = "Hip Only", Callback = function(v) TriggerBotHipOnly = v end})
TriggerGroup:AddToggle("HeadOnly", {Text = "Head Only", Callback = function(v) TriggerBotHeadOnly = v end})
TriggerGroup:AddSlider("HealthBelow", {Text = "Only Below Health", Min = 0, Max = 100, Default = 100, Callback = function(v) TriggerBotHealthBelow = v end})

-- Combat Tab - Aimlock Settings
local AimlockGroup = Tabs.Combat:AddLeftGroupbox("Aimlock Settings")
AimlockGroup:AddToggle("TargetLock", {Text = "Lock Target", Callback = function(v) AimlockTargetLock = v end})
AimlockGroup:AddToggle("OnKeyOnly", {Text = "Hold to Aimlock", Callback = function(v) AimlockOnKey = v end})
AimlockGroup:AddDropdown("AimlockKey", {
    Text = "Aimlock Key",
    Values = {"MouseButton2", "LeftShift", "Q", "E", "R", "F", "C", "X", "Z"},
    Default = "MouseButton2",
    Callback = function(v) AimlockKey = v end
})
AimlockGroup:AddDropdown("AimlockType", {
    Text = "Aimlock Type",
    Values = {"Camera", "Mouse", "Smooth"},
    Default = "Camera",
    Callback = function(v) AimlockType = v end
})
AimlockGroup:AddToggle("SnapAim", {Text = "Snap Aim", Callback = function(v) AimlockSnap = v end})
AimlockGroup:AddSlider("SnapFOV", {Text = "Snap FOV", Min = 50, Max = 200, Default = 100, Callback = function(v) AimlockSnapFOV = v end})
AimlockGroup:AddToggle("PredictMovement", {Text = "Predict Movement", Default = true, Callback = function(v) AimlockPredictMovement = v end})
AimlockGroup:AddToggle("VerticalOnly", {Text = "Vertical Only", Callback = function(v) AimlockVerticalOnly = v end})
AimlockGroup:AddToggle("HorizontalOnly", {Text = "Horizontal Only", Callback = function(v) AimlockHorizontalOnly = v end})

-- Combat Tab - Target Selection
local TargetGroup = Tabs.Combat:AddRightGroupbox("Target Selection")
TargetGroup:AddToggle("CycleTargets", {Text = "Cycle Targets (Press Q)", Callback = function(v) AimlockCycleTargets = v end})
TargetGroup:AddToggle("LockAfterKill", {Text = "Lock After Kill", Default = true, Callback = function(v) AimlockLockAfterKill = v end})
TargetGroup:AddToggle("SwitchOnDeath", {Text = "Switch Target on Death", Default = true, Callback = function(v) AimlockSwitchOnDeath = v end})
TargetGroup:AddSlider("SwitchDelay", {Text = "Switch Delay", Min = 0.1, Max = 2, Default = 0.5, Callback = function(v) AimlockSwitchDelay = v end})
TargetGroup:AddToggle("VisibleOnly", {Text = "Visible Only", Default = true, Callback = function(v) AimlockVisibleOnly = v end})
TargetGroup:AddSlider("MaxDistance", {Text = "Max Distance", Min = 100, Max = 1000, Default = 500, Callback = function(v) AimlockMaxDistance = v end})
TargetGroup:AddSlider("MinDistance", {Text = "Min Distance", Min = 0, Max = 100, Default = 0, Callback = function(v) AimlockMinDistance = v end})
TargetGroup:AddToggle("AimAtFeet", {Text = "Aim At Feet", Callback = function(v) AimlockAimAtFeet = v end})

-- Combat Tab - Body Part Priority
local BodyGroup = Tabs.Combat:AddLeftGroupbox("Body Part Priority")
BodyGroup:AddToggle("HeadPriority", {Text = "Head Priority", Default = true, Callback = function(v) AimlockHeadshotPriority = v end})
BodyGroup:AddToggle("BodyPriority", {Text = "Body Priority", Callback = function(v) AimlockBodyPriority = v end})
BodyGroup:AddToggle("LimbPriority", {Text = "Limb Priority", Callback = function(v) AimlockLimbPriority = v end})
BodyGroup:AddToggle("NearestToCrosshair", {Text = "Nearest to Crosshair", Default = true, Callback = function(v) AimlockNearestToCrosshair = v end})

-- Combat Tab - Visual Feedback
local VisualGroup = Tabs.Combat:AddRightGroupbox("Visual Feedback")
VisualGroup:AddToggle("ShowFOVCircle", {Text = "Show FOV Circle", Callback = function(v) 
    AimlockFOVCircle = v
    if v then createFOVCircle() elseif fovCircle then fovCircle:Remove() fovCircle = nil end
end})
VisualGroup:AddColorPicker("FOVCircleColor", {Text = "FOV Circle Color", Default = Color3.fromRGB(255, 0, 0), Callback = function(v) 
    AimlockFOVCircleColor = v
    if fovCircle then fovCircle.Color = v end
end})
VisualGroup:AddSlider("FOVCircleOpacity", {Text = "FOV Circle Opacity", Min = 0, Max = 1, Default = 0.5, Callback = function(v) 
    AimlockFOVCircleTransparency = v
    if fovCircle then fovCircle.Transparency = v end
end})

-- Combat Tab - Anti-Recoil/Spread
local AntiGroup = Tabs.Combat:AddLeftGroupbox("Anti-Recoil & Spread")
AntiGroup:AddToggle("AntiRecoil", {Text = "Anti Recoil", Callback = function(v) AntiRecoilEnabled = v end})
AntiGroup:AddSlider("RecoilStrength", {Text = "Recoil Strength", Min = 0.1, Max = 1, Default = 0.5, Callback = function(v) AntiRecoilStrength = v end})
AntiGroup:AddToggle("AntiSpread", {Text = "Anti Spread", Callback = function(v) AntiSpreadEnabled = v end})
AntiGroup:AddSlider("SpreadStrength", {Text = "Spread Strength", Min = 0.1, Max = 1, Default = 0.5, Callback = function(v) AntiSpreadStrength = v end})
AntiGroup:AddToggle("NoSway", {Text = "No Sway", Callback = function(v) NoSwayEnabled = v end})

-- Combat Tab - Auto Shoot Settings
local AutoGroup = Tabs.Combat:AddRightGroupbox("Auto Shoot Settings")
AutoGroup:AddSlider("AutoShootDelay", {Text = "Shoot Delay", Min = 0.01, Max = 0.2, Default = 0.05, Callback = function(v) AutoShootDelay = v end})
AutoGroup:AddToggle("ShootWhenVisible", {Text = "Only When Visible", Default = true, Callback = function(v) AutoShootWhenVisible = v end})

-- Combat Tab - Damage Modifiers
local DamageGroup = Tabs.Combat:AddSection("Damage Modifiers")
DamageGroup:AddToggle("DamageMultiplier", {Text = "Damage Multiplier", Callback = function(v) DamageMultiplierEnabled = v end})
DamageGroup:AddSlider("MultiplierValue", {Text = "Multiplier", Min = 1.1, Max = 10, Default = 2, Callback = function(v) DamageMultiplierValue = v end})
DamageGroup:AddToggle("InstantHit", {Text = "Instant Hit (Bullet TP)", Callback = function(v) InstantHitEnabled = v end})
DamageGroup:AddToggle("BulletTP", {Text = "Bullet Teleport", Callback = function(v) BulletTPEnabled = v end})

-- Visuals Tab (Same as before)
local VisualESP = Tabs.Visuals:AddLeftGroupbox("ESP Settings")
VisualESP:AddToggle("BoxESP", {Text = "Box ESP", Callback = function(v) EspEnabled = v end})
VisualESP:AddToggle("Tracers", {Text = "Tracers", Callback = function(v) TracersEnabled = v end})
VisualESP:AddToggle("HealthBar", {Text = "Health Bar", Default = true, Callback = function(v) HealthBarEnabled = v end})
VisualESP:AddToggle("NameTags", {Text = "Name Tags", Default = true, Callback = function(v) NameTagsEnabled = v end})
VisualESP:AddToggle("WeaponESP", {Text = "Weapon ESP", Callback = function(v) WeaponESPEnabled = v end})
VisualESP:AddToggle("SkeletonESP", {Text = "Skeleton ESP", Callback = function(v) SkeletonESPEnabled = v end})
VisualESP:AddToggle("ChamsESP", {Text = "Chams ESP", Callback = function(v) ChamsESPEnabled = v end})
VisualESP:AddToggle("ShowDistance", {Text = "Show Distance", Default = true, Callback = function(v) DistanceEnabled = v end})
VisualESP:AddToggle("HealthNumbers", {Text = "Health Numbers", Callback = function(v) HealthNumbersEnabled = v end})
VisualESP:AddToggle("TeamColorESP", {Text = "Team Colors", Default = true, Callback = function(v) TeamColorESP = v end})
VisualESP:AddSlider("RenderDistance", {Text = "Max Render Distance", Min = 100, Max = 1000, Default = 500, Callback = function(v) MaxRenderDistance = v end})

local VisualEffects = Tabs.Visuals:AddRightGroupbox("Visual Effects")
VisualEffects:AddToggle("Crosshair", {Text = "Crosshair", Callback = function(v) CrosshairEnabled = v end})
VisualEffects:AddDropdown("CrosshairStyle", {
    Text = "Crosshair Style",
    Values = {"Dot", "Cross", "Circle"},
    Default = "Dot",
    Callback = function(v) CrosshairStyle = v end
})
VisualEffects:AddToggle("Hitmarker", {Text = "Hitmarker", Callback = function(v) HitmarkerEnabled = v end})
VisualEffects:AddToggle("DamageIndicators", {Text = "Damage Indicators", Callback = function(v) DamageIndicators = v end})
VisualEffects:AddToggle("NoFog", {Text = "No Fog", Callback = function(v) NoFogEnabled = v end})
VisualEffects:AddToggle("FullBright", {Text = "Full Bright", Callback = function(v) FullBrightEnabled = v end})
VisualEffects:AddToggle("CustomBrightness", {Text = "Custom Brightness", Callback = function(v) BrightnessEnabled = v end})
VisualEffects:AddSlider("BrightnessValue", {Text = "Brightness", Min = 0, Max = 4, Default = 2, Callback = function(v) BrightnessValue = v end})
VisualEffects:AddToggle("FOVChanger", {Text = "FOV Changer", Callback = function(v) FovChangerEnabled = v end})
VisualEffects:AddSlider("FOVValue", {Text = "FOV Value", Min = 70, Max = 120, Default = 90, Callback = function(v) FovValue = v end})
VisualEffects:AddToggle("Wireframe", {Text = "Wireframe Mode", Callback = function(v) WireframeEnabled = v end})
VisualEffects:AddToggle("NoCameraShake", {Text = "No Camera Shake", Callback = function(v) NoCameraShake = v end})

local VisualColors = Tabs.Visuals:AddSection("Colors")
VisualColors:AddColorPicker("ESPColor", {Text = "ESP Color", Default = Color3.fromRGB(0, 255, 255), Callback = function(v) ESPColor = v end})
VisualColors:AddColorPicker("TracerColor", {Text = "Tracer Color", Default = Color3.fromRGB(255, 0, 0), Callback = function(v) TracerColor = v end})
VisualColors:AddColorPicker("NameColor", {Text = "Name Color", Default = Color3.fromRGB(255, 255, 255), Callback = function(v) NameColor = v end})
VisualColors:AddColorPicker("ChamsColor", {Text = "Chams Color", Default = Color3.fromRGB(255, 0, 0), Callback = function(v) ChamsColor = v end})
VisualColors:AddSlider("ChamsTransparency", {Text = "Chams Transparency", Min = 0, Max = 1, Default = 0.3, Callback = function(v) ChamsTransparency = v end})

-- Movement Tab (Same as before)
local MovementSpeed = Tabs.Movement:AddLeftGroupbox("Movement Speed")
MovementSpeed:AddToggle("Walkspeed", {Text = "Walkspeed", Callback = function(v) WalkspeedEnabled = v end})
MovementSpeed:AddSlider("SpeedValue", {Text = "Speed Value", Min = 16, Max = 500, Default = 50, Callback = function(v) WalkspeedValue = v end})
MovementSpeed:AddToggle("JumpPower", {Text = "Jump Power", Callback = function(v) JumpPowerEnabled = v end})
MovementSpeed:AddSlider("JumpValue", {Text = "Jump Value", Min = 50, Max = 500, Default = 50, Callback = function(v) JumpPowerValue = v end})
MovementSpeed:AddToggle("SpeedBoost", {Text = "Speed Boost", Callback = function(v) SpeedBoostEnabled = v end})
MovementSpeed:AddSlider("BoostAmount", {Text = "Boost Amount", Min = 1.1, Max = 5, Default = 1.5, Callback = function(v) SpeedBoostAmount = v end})

local MovementExtras = Tabs.Movement:AddRightGroupbox("Movement Extras")
MovementExtras:AddToggle("Noclip", {Text = "Noclip", Callback = function(v) NoclipEnabled = v end})
MovementExtras:AddToggle("Fly", {Text = "Fly (Press F)", Callback = function(v) 
    FlyEnabled = v
    if not v and isFlying then
        isFlying = false
        local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
        if hum then
            hum.PlatformStand = false
        end
    end
end})
MovementExtras:AddSlider("FlySpeed", {Text = "Fly Speed", Min = 20, Max = 1000, Default = 50, Callback = function(v) FlySpeed = v end})
MovementExtras:AddToggle("InfiniteJump", {Text = "Infinite Jump", Callback = function(v) InfiniteJumpEnabled = v end})

-- Misc Tab (Same as before)
local MiscGroup = Tabs.Misc:AddLeftGroupbox("Anti-System")
MiscGroup:AddToggle("AntiAFK", {Text = "Anti AFK", Callback = function(v) AntiAFKEnabled = v end})
MiscGroup:AddToggle("AutoRejoin", {Text = "Auto Rejoin", Callback = function(v) AutoRejoinEnabled = v end})
MiscGroup:AddToggle("AutoRespawn", {Text = "Auto Respawn", Callback = function(v) AutoRespawnEnabled = v end})
MiscGroup:AddToggle("BypassKick", {Text = "Bypass Kick", Callback = function(v) BypassKickEnabled = v end})

local MiscDisplay = Tabs.Misc:AddRightGroupbox("Display")
MiscDisplay:AddToggle("PingDisplay", {Text = "Show Ping", Callback = function(v) PingDisplayEnabled = v end})
MiscDisplay:AddToggle("FPSDisplay", {Text = "Show FPS", Callback = function(v) FPSDisplayEnabled = v end})

local MiscChat = Tabs.Misc:AddSection("Chat")
MiscChat:AddToggle("ChatSpam", {Text = "Chat Spam", Callback = function(v) ChatSpamEnabled = v end})
MiscChat:AddInput("SpamMessage", {Text = "Spam Message", Default = "Blazed X is the best!", Callback = function(v) ChatSpamMessage = v end})
MiscChat:AddSlider("SpamDelay", {Text = "Spam Delay (s)", Min = 1, Max = 30, Default = 5, Callback = function(v) ChatSpamDelay = v end})
MiscChat:AddToggle("NameSteal", {Text = "Name Steal", Callback = function(v) NameStealEnabled = v end})
MiscChat:AddInput("CustomName", {Text = "Desired Name", Default = "Blazed_User", Callback = function(v) CustomName = v end})
MiscChat:AddButton("Apply Name", function() stealName() end)

-- Close Script Button
local MiscClose = Tabs.Misc:AddSection("Script Control")
MiscClose:AddButton("⚠️ CLOSE SCRIPT ⚠️", function() 
    closeScript() 
end)

-- Ping/FPS display drawing
local pingText = nil
local fpsText = nil

task.spawn(function()
    while true do
        if PingDisplayEnabled then
            if not pingText then
                pingText = Drawing.new("Text")
                pingText.Size = 16
                pingText.Position = Vector2.new(10, 10)
                pingText.Color = Color3.fromRGB(255, 255, 255)
                pingText.Outline = true
            end
            pingText.Text = "Ping: " .. ping .. "ms"
            pingText.Visible = true
        elseif pingText then
            pingText.Visible = false
        end
        
        if FPSDisplayEnabled then
            if not fpsText then
                fpsText = Drawing.new("Text")
                fpsText.Size = 16
                fpsText.Position = Vector2.new(10, 35)
                fpsText.Color = Color3.fromRGB(255, 255, 255)
                fpsText.Outline = true
            end
            fpsText.Text = "FPS: " .. fps
            fpsText.Visible = true
        elseif fpsText then
            fpsText.Visible = false
        end
        
        task.wait(0.5)
    end
end)

print("✅ Blazed X Ultimate Enhanced Loaded! Press RIGHT SHIFT to toggle menu")
print("⚠️ Added 20+ new aimbot features including:")
print("  • Dynamic FOV | Target Priority | Prediction Types")
print("  • Aimlock Types | Snap Aim | Target Lock")
print("  • Cycle Targets | Body Part Priority | FOV Circle")
print("  • Anti-Recoil | Auto Shoot | Trigger Bot Enhancements")
print("⚠️ Press the 'CLOSE SCRIPT' button in the Misc tab to safely close the script")