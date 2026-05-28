-- Blazed - Ultimate Edition (Clean)
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local VirtualInput = game:GetService("VirtualInputManager")

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/alebinh60/asmobile/refs/heads/main/Library.lua"))()
local Window = Library:CreateWindow({
    Title = "Blazed X",
    Footer = "blazed.cc | Ultimate Edition | Press RIGHT SHIFT",
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
-- Combat
local SilentEnabled = false
local SilentHitPart = "Head"
local SilentFOV = 150
local AimlockEnabled = false
local AimlockSmoothing = 0.2
local AimlockPart = "Head"
local WallCheckEnabled = true
local TriggerBotEnabled = false
local TriggerBotDelay = 0.1
local TriggerBotKey = "MouseButton2"
local PredictionEnabled = false
local PredictionAmount = 0.15
local TeamCheckEnabled = false

-- Visuals
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
local NoCameraShake = false

-- ESP
local EspEnabled = false
local TracersEnabled = false
local HealthBarEnabled = true
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

-- Movement
local JumpPowerEnabled = false
local JumpPowerValue = 50
local NoclipEnabled = false
local FlyEnabled = false
local FlySpeed = 50
local InfiniteJumpEnabled = false
local SpeedBoostEnabled = false
local SpeedBoostAmount = 1.5

-- Misc
local AntiAFKEnabled = false
local AutoRejoinEnabled = false
local AutoRespawnEnabled = false
local ChatSpamEnabled = false
local ChatSpamMessage = "Blazed X is the best!"
local ChatSpamDelay = 5
local NameStealEnabled = false
local CustomName = "Blazed_User"
local PingDisplayEnabled = false
local FPSDisplayEnabled = false

-- ESP Storage
local espBoxes = {}
local espTracers = {}
local espNames = {}
local espHealthBars = {}
local espWeapons = {}
local espSkeletons = {}
local espChams = {}

-- Menu Toggle
local MenuOpen = true
local isFlying = false
local lastFlyToggle = 0
local ping = 0
local fps = 60

-- Get the actual GUI frame
local GuiFrame = nil
for _, child in pairs(Window.Gui:GetChildren()) do
    if child:IsA("Frame") and child.Name ~= "TopBar" then
        GuiFrame = child
        break
    end
end

-- Toggle menu function
local function ToggleMenu()
    MenuOpen = not MenuOpen
    if GuiFrame then
        GuiFrame.Visible = MenuOpen
    end
    Library:Notify(MenuOpen and "Menu Opened" or "Menu Hidden", 2)
end

-- RIGHT SHIFT KEY - FIXED
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.RightShift then
        ToggleMenu()
    end
end)

-- Also support Left Shift if needed
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.LeftShift then
        -- Optional: you can add Left Shift too
        -- ToggleMenu()
    end
end)

-- ==================== HELPER FUNCTIONS ====================
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
    if not TeamCheckEnabled then return false end
    return player.Team == LocalPlayer.Team
end

local function isVisible(target)
    if not WallCheckEnabled then return true end
    local localChar = LocalPlayer.Character
    local targetChar = target.Character
    if not localChar or not targetChar then return false end
    local root = localChar:FindFirstChild("HumanoidRootPart")
    local tpart = targetChar:FindFirstChild(SilentHitPart) or targetChar:FindFirstChild("Head")
    if not root or not tpart then return false end
    local dir = (tpart.Position - root.Position)
    local params = RaycastParams.new()
    params.FilterDescendantsInstances = {localChar, targetChar}
    params.FilterType = Enum.RaycastFilterType.Blacklist
    local res = workspace:Raycast(root.Position, dir.Unit * dir.Magnitude, params)
    return res == nil
end

local function getPredictedPosition(part)
    if not PredictionEnabled then return part.Position end
    local velocity = part.AssemblyLinearVelocity or Vector3.new()
    return part.Position + (velocity * PredictionAmount)
end

local function getClosestTarget()
    local closest, shortest = nil, SilentFOV
    local mouse = UserInputService:GetMouseLocation()
    for _, plr in Players:GetPlayers() do
        if plr ~= LocalPlayer and plr.Character and not isTeammate(plr) then
            local hum = plr.Character:FindFirstChild("Humanoid")
            if hum and hum.Health > 0 then
                local part = plr.Character:FindFirstChild(SilentHitPart) or plr.Character:FindFirstChild("Head")
                if part then
                    local predictedPos = getPredictedPosition(part)
                    local pos, onScreen = Camera:WorldToViewportPoint(predictedPos)
                    if onScreen then
                        local d = (Vector2.new(pos.X, pos.Y) - mouse).Magnitude
                        if d < shortest and isVisible(plr) then
                            shortest = d
                            closest = plr
                        end
                    end
                end
            end
        end
    end
    return closest
end

-- Hitmarker
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

-- Damage Indicator
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

-- Aimlock
local function updateAimlock()
    if not AimlockEnabled then return end
    local target = getClosestTarget()
    if target and target.Character then
        local part = target.Character:FindFirstChild(AimlockPart) or target.Character:FindFirstChild("Head")
        if part then
            local predictedPos = getPredictedPosition(part)
            local goal = CFrame.new(Camera.CFrame.Position, predictedPos)
            Camera.CFrame = Camera.CFrame:Lerp(goal, AimlockSmoothing)
        end
    end
end

-- Trigger Bot
local function checkTrigger()
    if not TriggerBotEnabled then return end
    local target = getClosestTarget()
    if target and isVisible(target) then
        task.wait(TriggerBotDelay)
        if TriggerBotKey == "MouseButton2" then
            VirtualInput:SendMouseButtonEvent(Enum.UserInputType.MouseButton2, 0, true, false, Vector2.new(0, 0), 0)
            task.wait(0.05)
            VirtualInput:SendMouseButtonEvent(Enum.UserInputType.MouseButton2, 0, false, false, Vector2.new(0, 0), 0)
        elseif TriggerBotKey == "MouseButton1" then
            VirtualInput:SendMouseButtonEvent(Enum.UserInputType.MouseButton1, 0, true, false, Vector2.new(0, 0), 0)
            task.wait(0.05)
            VirtualInput:SendMouseButtonEvent(Enum.UserInputType.MouseButton1, 0, false, false, Vector2.new(0, 0), 0)
        end
        createHitmarker()
    end
end

-- Chams
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

-- Skeleton ESP
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

-- Weapon ESP
local function getPlayerWeapon(player)
    local char = player.Character
    if not char then return "Unknown" end
    local tool = char:FindFirstChildWhichIsA("Tool")
    return tool and tool.Name or "None"
end

-- Anti AFK
local function antiAFK()
    if not AntiAFKEnabled then return end
    local vu = game:GetService("VirtualUser")
    vu:Button2Down(Vector2.new(0, 0))
    task.wait(0.1)
    vu:Button2Up(Vector2.new(0, 0))
end

-- Chat Spam
local function chatSpam()
    if not ChatSpamEnabled then return end
    local args = {
        [1] = ChatSpamMessage,
        [2] = "All"
    }
    local success, err = pcall(function()
        game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest"):FireServer(unpack(args))
    end)
    if not success then
        -- Chat might not be supported in this game
    end
end

-- Name Steal
local function stealName()
    if not NameStealEnabled then return end
    local success, err = pcall(function()
        game:GetService("Players").LocalPlayer.Name = CustomName
    end)
    if not success then
        Library:Notify("Name steal not supported in this game", 3)
    end
end

-- Infinite Jump
UserInputService.JumpRequest:Connect(function()
    if InfiniteJumpEnabled then
        local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
        if hum then
            hum:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

-- Fly System
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

-- Noclip
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

-- FOV Changer
local function updateFOV()
    if FovChangerEnabled then
        Camera.FieldOfView = FovValue
    else
        Camera.FieldOfView = 70
    end
end

-- Ping Display
local function updatePingDisplay()
    if not PingDisplayEnabled then return end
    local stats = game:GetService("Stats")
    local pingStat = stats.Network:FindFirstChild("ServerStatsItem")
    if pingStat then
        ping = math.floor(pingStat:GetValueString())
    end
end

-- FPS Display
local function updateFPSDisplay()
    if not FPSDisplayEnabled then return end
    fps = math.floor(1 / RunService.RenderStepped:Wait())
end

-- Auto Respawn
local function autoRespawn()
    if not AutoRespawnEnabled then return end
    LocalPlayer.CharacterAdded:Wait()
end

-- ESP Update
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
            espNames[player].Text = nameText
            espNames[player].Position = Vector2.new(headPos.X, headPos.Y - 35)
            espNames[player].Visible = EspEnabled
            espNames[player].Color = NameColor
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
                espBoxes[player][i].Color = playerColor
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

-- Visuals update
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

-- Crosshair
local crosshair = nil
local function updateCrosshair()
    if CrosshairEnabled and not crosshair then
        crosshair = Drawing.new("Circle")
        crosshair.Radius = 3
        crosshair.Filled = true
        crosshair.Thickness = 2
        crosshair.Color = Color3.fromRGB(255, 255, 255)
        crosshair.Visible = true
    elseif not CrosshairEnabled and crosshair then
        crosshair.Visible = false
    end
    
    if crosshair and CrosshairEnabled then
        local mousePos = UserInputService:GetMouseLocation()
        crosshair.Position = mousePos
        crosshair.Visible = true
    end
end

-- Main Loops
RunService.RenderStepped:Connect(function()
    updateESP()
    updateAimlock()
    updateCrosshair()
    updateVisuals()
    updateNoclip()
    updatePingDisplay()
    updateFPSDisplay()
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
-- Combat Tab
local CombatGroup = Tabs.Combat:AddLeftGroupbox("Combat Settings")
CombatGroup:AddToggle("SilentAim", {Text = "Silent Aim", Callback = function(v) SilentEnabled = v end})
CombatGroup:AddToggle("Aimlock", {Text = "Aimlock", Callback = function(v) AimlockEnabled = v end})
CombatGroup:AddToggle("TriggerBot", {Text = "Trigger Bot", Callback = function(v) TriggerBotEnabled = v end})
CombatGroup:AddToggle("Prediction", {Text = "Prediction", Callback = function(v) PredictionEnabled = v end})
CombatGroup:AddToggle("TeamCheck", {Text = "Team Check", Callback = function(v) TeamCheckEnabled = v end})
CombatGroup:AddToggle("WallCheck", {Text = "Wall Check", Default = true, Callback = function(v) WallCheckEnabled = v end})

local CombatAdvanced = Tabs.Combat:AddRightGroupbox("Advanced Combat")
CombatAdvanced:AddDropdown("AimPart", {
    Text = "Aim Part",
    Values = {"Head", "HumanoidRootPart", "Torso", "UpperTorso"},
    Default = "Head",
    Callback = function(v) 
        SilentHitPart = v
        AimlockPart = v
    end
})
CombatAdvanced:AddSlider("AimFOV", {Text = "Aim FOV", Min = 30, Max = 500, Default = 150, Callback = function(v) SilentFOV = v end})
CombatAdvanced:AddSlider("AimSmoothing", {Text = "Aim Smoothing", Min = 0.05, Max = 0.5, Default = 0.2, Callback = function(v) AimlockSmoothing = v end})
CombatAdvanced:AddSlider("TriggerDelay", {Text = "Trigger Delay", Min = 0, Max = 0.5, Default = 0.1, Callback = function(v) TriggerBotDelay = v end})
CombatAdvanced:AddSlider("PredictionAmount", {Text = "Prediction Amount", Min = 0.05, Max = 0.5, Default = 0.15, Callback = function(v) PredictionAmount = v end})
CombatAdvanced:AddDropdown("TriggerKey", {
    Text = "Trigger Key",
    Values = {"MouseButton1", "MouseButton2"},
    Default = "MouseButton2",
    Callback = function(v) TriggerBotKey = v end
})

-- Visuals Tab
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

-- Movement Tablocal MovementSpeed = Tabs.Movement:AddLeftGroupbox("Movement Speed")
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

-- Misc Tab
local MiscGroup = Tabs.Misc:AddLeftGroupbox("Anti-System")
MiscGroup:AddToggle("AntiAFK", {Text = "Anti AFK", Callback = function(v) AntiAFKEnabled = v end})
MiscGroup:AddToggle("AutoRejoin", {Text = "Auto Rejoin", Callback = function(v) AutoRejoinEnabled = v end})
MiscGroup:AddToggle("AutoRespawn", {Text = "Auto Respawn", Callback = function(v) AutoRespawnEnabled = v end})

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

print("✅ Blazed X Ultimate Loaded!")
print("⚠️ Press RIGHT SHIFT to open/close the menu!")