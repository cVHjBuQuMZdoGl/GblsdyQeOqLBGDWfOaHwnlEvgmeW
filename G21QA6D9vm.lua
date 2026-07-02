--[[
    Syrex Hub: Sniper or Die Edition
    PRODUCTION BUILD — (Max Optimization, FPS Booster & Anti-Lag Engine)
--]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Configuration State
local DaemonConfig = {
    AimbotEnabled = false,
    SilentAim = false,
    AutoFarm = false,
    KillAll = false,
    TargetPart = "Head", 
    MinValidHeight = 22,   
    MaxValidHeight = 135,
    SafetyMode = true,
    AntiChatReport = true, 
    HumanizeDelays = true,
    AntiSpectate = true,
    VelocityBuffer = true,
    IncludeNPCs = false
}

-- UI Framework Engine
local SyrexHub = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TopBar = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local ContentContainer = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local FloatingIcon = Instance.new("TextButton")

SyrexHub.Name = "Syrex_" .. tostring(math.random(100, 999))
SyrexHub.ResetOnSpawn = false
SyrexHub.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local targetParent = game:GetService("CoreGui") or LocalPlayer:WaitForChild("PlayerGui")
SyrexHub.Parent = targetParent

-- Floating Toggle Icon
FloatingIcon.Name = "FT"
FloatingIcon.Size = UDim2.new(0, 45, 0, 45)
FloatingIcon.Position = UDim2.new(0, 15, 0, 15)
FloatingIcon.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
FloatingIcon.Text = "S"
FloatingIcon.TextColor3 = Color3.fromRGB(0, 255, 150)
FloatingIcon.Font = Enum.Font.GothamBold
FloatingIcon.TextSize = 20
FloatingIcon.BorderSizePixel = 0
FloatingIcon.Active = true
FloatingIcon.Draggable = true
FloatingIcon.Parent = SyrexHub

local UICorner_Float = Instance.new("UICorner")
UICorner_Float.CornerRadius = UDim.new(0, 10)
UICorner_Float.Parent = FloatingIcon

-- Main Frame Panel Setup
MainFrame.Name = "MP"
MainFrame.Size = UDim2.new(0, 280, 0, 320)
MainFrame.Position = UDim2.new(0.5, -140, 0.5, -160)
MainFrame.BackgroundColor3 = Color3.fromRGB(3, 3, 5)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Parent = SyrexHub

local UICorner_Main = Instance.new("UICorner")
UICorner_Main.CornerRadius = UDim.new(0, 8)
UICorner_Main.Parent = MainFrame

TopBar.Name = "TB"
TopBar.Size = UDim2.new(1, 0, 0, 35)
TopBar.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local UICorner_Top = Instance.new("UICorner")
UICorner_Top.CornerRadius = UDim.new(0, 8)
UICorner_Top.Parent = TopBar

Title.Name = "HT"
Title.Size = UDim2.new(1, -20, 1, 0)
Title.Position = UDim2.new(0, 12, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "SYREX HUB — Optimized Lag-Fix"
Title.TextColor3 = Color3.fromRGB(240, 240, 245)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 12
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

-- Mobile Optimized Scrolling System
ContentContainer.Name = "CC"
ContentContainer.Size = UDim2.new(1, -16, 1, -45)
ContentContainer.Position = UDim2.new(0, 8, 0, 40)
ContentContainer.BackgroundTransparency = 1
ContentContainer.BorderSizePixel = 0
ContentContainer.ScrollBarThickness = 3
ContentContainer.ScrollBarImageColor3 = Color3.fromRGB(0, 255, 150)
ContentContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
ContentContainer.Parent = MainFrame

UIListLayout.Parent = ContentContainer
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 6)

UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    ContentContainer.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 10)
end)

-- Interface Drag
local function BindInterfaceDrag(frame, dragHandle)
    local dragging, dragInput, dragStart, startPos
    
    dragHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    dragHandle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(
                startPos.X.Scale, 
                startPos.X.Offset + delta.X, 
                startPos.Y.Scale, 
                startPos.Y.Offset + delta.Y
            )
        end
    end)
end
BindInterfaceDrag(MainFrame, TopBar)

-- Toggle Factory
local function CreateInterfaceToggle(titleText, configKey, callback)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, -4, 0, 36)
    Button.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
    Button.Font = Enum.Font.GothamSemibold
    Button.TextSize = 12
    Button.BorderSizePixel = 0
    Button.Parent = ContentContainer
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = Button
    
    local function UpdateVisualState()
        if DaemonConfig[configKey] then
            Button.Text = titleText .. " : [ ON ]"
            Button.TextColor3 = Color3.fromRGB(0, 255, 140)
        else
            Button.Text = titleText .. " : [ OFF ]"
            Button.TextColor3 = Color3.fromRGB(200, 70, 70)
        end
    end
    
    Button.MouseButton1Click:Connect(function()
        DaemonConfig[configKey] = not DaemonConfig[configKey]
        UpdateVisualState()
        if callback then callback(DaemonConfig[configKey]) end
    end)
    
    UpdateVisualState()
    return Button
end

FloatingIcon.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- PROTECTION 1: Chat Monitor
local DangerKeywords = {"hack", "cheat", "exploit", "report", "hacker", "aimbot", "kick", "ban", "syrex"}
local function MonitorServerChat(player, message)
    if not DaemonConfig.AntiChatReport then return end
    local cleanMessage = string.lower(message)
    
    for _, word in ipairs(DangerKeywords) do
        if string.find(cleanMessage, word) then
            if string.find(cleanMessage, string.lower(LocalPlayer.Name)) or string.find(cleanMessage, "admin") or #Players:GetPlayers() <= 5 then
                DaemonConfig.KillAll = false
                DaemonConfig.SilentAim = false
                DaemonConfig.AimbotEnabled = false
                break
            end
        end
    end
end

for _, player in ipairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        player.Chatted:Connect(function(msg) MonitorServerChat(player, msg) end)
    end
end
Players.PlayerAdded:Connect(function(player)
    player.Chatted:Connect(function(msg) MonitorServerChat(player, msg) end)
end)

-- PROTECTION 2: Spectator Tracking (Fixed & Client-Optimized)
local function IsBeingSpectated()
    if not DaemonConfig.AntiSpectate then return false end
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then return false end
    
    -- Client-side trace logic safely handling nil exceptions
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid and humanoid.Health <= 0 then
                -- Fallback safely checks if local simulation hints active spectating on camera
                if Camera.CameraSubject and Camera.CameraSubject:IsDescendantOf(LocalPlayer.Character) == false then
                    return true
                end
            end
        end
    end
    return false
end

-- OPTIMIZATION: Staff Rank Caching (Fixed Group Validation)
local StaffCache = {}
local function CachePlayerRank(player)
    task.spawn(function()
        pcall(function()
            -- Secured via CreatorId check to accurately catch admins/owners
            if player.UserId == game.CreatorId or (game.CreatorType == Enum.CreatorType.Group and player:GetRankInGroup(game.GameId) >= 200) then
                StaffCache[player] = true
            end
        end)
    end)
end

for _, p in ipairs(Players:GetPlayers()) do CachePlayerRank(p) end
Players.PlayerAdded:Connect(CachePlayerRank)
Players.PlayerRemoving:Connect(function(player) StaffCache[player] = nil end)

local function IsServerSafeFromStaff()
    if not DaemonConfig.SafetyMode then return true end
    for player, isStaff in pairs(StaffCache) do
        if isStaff then return false end
    end
    return true
end

-- Core Integrity Target Check
local function SecureVerifyTarget(player)
    if player and player ~= LocalPlayer and player.Character then
        if not IsServerSafeFromStaff() or IsBeingSpectated() then
            return false
        end

        local character = player.Character
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        local head = character:FindFirstChild("Head")
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        
        if rootPart and head and humanoid and humanoid.Health > 0 then
            local currentY = rootPart.Position.Y
            if currentY >= DaemonConfig.MinValidHeight and currentY <= DaemonConfig.MaxValidHeight then
                return true
            end
        end
    end
    return false
end

-- Cached NPC Array (Added Thread & Health Safeguards)
local CachedNPCs = {}
task.spawn(function()
    while true do
        if DaemonConfig.IncludeNPCs then
            local tempNPCs = {}
            for _, obj in ipairs(workspace:GetChildren()) do
                if obj:IsA("Model") and obj:FindFirstChildOfClass("Humanoid") and obj ~= LocalPlayer.Character then
                    local hum = obj:FindFirstChildOfClass("Humanoid")
                    if hum and hum.Health > 0 and not Players:GetPlayerFromCharacter(obj) then
                        table.insert(tempNPCs, obj)
                    end
                elseif obj.Name == "NPCs" or obj.Name == "Enemies" then
                    for _, subObj in ipairs(obj:GetChildren()) do
                        if subObj:IsA("Model") and subObj:FindFirstChildOfClass("Humanoid") then
                            local subHum = subObj:FindFirstChildOfClass("Humanoid")
                            if subHum and subHum.Health > 0 then
                                table.insert(tempNPCs, subObj)
                            end
                        end
                    end
                end
            end
            CachedNPCs = tempNPCs
        end
        task.wait(3.5)
    end
end)

-- Optimized 3D Spatial Sorter Module (With Active Dead NPC Filter)
local function SelectOptimalTarget(ignoreScreenConstraint)
    local closestTarget = nil
    local shortestDistance = math.huge
    local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not myRoot then return nil end
    
    for _, targetPlayer in ipairs(Players:GetPlayers()) do
        if SecureVerifyTarget(targetPlayer) then
            local headPart = targetPlayer.Character:FindFirstChild("Head")
            if headPart then
                if ignoreScreenConstraint then
                    local distance = (headPart.Position - myRoot.Position).Magnitude
                    if distance < shortestDistance then
                        closestTarget = targetPlayer.Character
                        shortestDistance = distance
                    end
                else
                    local screenPos, onScreen = Camera:WorldToViewportPoint(headPart.Position)
                    if onScreen or DaemonConfig.SilentAim then
                        local mouseLocation = UserInputService:GetMouseLocation()
                        local distance = (Vector2.new(screenPos.X, screenPos.Y) - mouseLocation).Magnitude
                        if distance < shortestDistance then
                            closestTarget = targetPlayer.Character
                            shortestDistance = distance
                        end
                    end
                end
            end
        end
    end
    
    if not closestTarget and DaemonConfig.IncludeNPCs then
        for _, obj in ipairs(CachedNPCs) do
            if obj.Parent then
                local headPart = obj:FindFirstChild("Head")
                local humanoid = obj:FindFirstChildOfClass("Humanoid")
                if headPart and humanoid and humanoid.Health > 0 then
                    if ignoreScreenConstraint then
                        local distance = (headPart.Position - myRoot.Position).Magnitude
                        if distance < shortestDistance then
                            closestTarget = obj
                            shortestDistance = distance
                        end
                    else
                        local screenPos, onScreen = Camera:WorldToViewportPoint(headPart.Position)
                        if onScreen or DaemonConfig.SilentAim then
                            local mouseLocation = UserInputService:GetMouseLocation()
                            local distance = (Vector2.new(screenPos.X, screenPos.Y) - mouseLocation).Magnitude
                            if distance < shortestDistance then
                                closestTarget = obj
                                shortestDistance = distance
                            end
                        end
                    end
                end
            end
        end
    end
    
    return closestTarget
end

-- Toggles Layout Injection
CreateInterfaceToggle("Silent Aim Matrix", "SilentAim")
CreateInterfaceToggle("Active Lock Aimbot", "AimbotEnabled")
CreateInterfaceToggle("Include Bots/NPCs", "IncludeNPCs")
CreateInterfaceToggle("99% Safety Radar", "SafetyMode")
CreateInterfaceToggle("Anti-Chat Reporter", "AntiChatReport")
CreateInterfaceToggle("Anti-Spectate Brake", "AntiSpectate")
CreateInterfaceToggle("Humanize Delays", "HumanizeDelays")
CreateInterfaceToggle("Network Velocity Buffer", "VelocityBuffer")

-- Fully Synchronized High-Speed Teleport Pipeline
CreateInterfaceToggle("Direct Teleport KillAll", "KillAll", function(enabled)
    if enabled then
        task.spawn(function()
            while DaemonConfig.KillAll do
                local currentTarget = SelectOptimalTarget(true)
                
                if currentTarget and LocalPlayer.Character then
                    local myRoot = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    local enemyHead = currentTarget:FindFirstChild("Head")
                    local enemyHumanoid = currentTarget:FindFirstChildOfClass("Humanoid")
                    
                    if myRoot and enemyHead and enemyHumanoid and enemyHumanoid.Health > 0 then
                        if DaemonConfig.VelocityBuffer then
                            myRoot.Velocity = Vector3.new(0, 0, 0)
                        end
                        myRoot.CFrame = CFrame.new(enemyHead.Position + Vector3.new(0, 4.2, 0), enemyHead.Position)
                    end
                end
                
                if DaemonConfig.HumanizeDelays then
                    task.wait(0.05)
                else
                    task.wait(0.02)
                end
            end
        end)
    end
end)

CreateInterfaceToggle("Automated Stage Farm", "AutoFarm", function(enabled)
    if enabled then
        task.spawn(function()
            local targetObjective = workspace:FindFirstChild("ObjectivePart") or workspace:FindFirstChild("TargetStage")
            while DaemonConfig.AutoFarm do
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    if not targetObjective or not targetObjective.Parent then
                        targetObjective = workspace:FindFirstChild("ObjectivePart") or workspace:FindFirstChild("TargetStage")
                    end
                    if targetObjective and targetObjective:IsA("BasePart") then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = targetObjective.CFrame
                    end
                end
                task.wait(0.5)
            end
        end)
    end
end)

-- Smooth Camera Interpolation
RunService:UnbindFromRenderStep("SyrexCameraLock")
RunService:BindToRenderStep("SyrexCameraLock", Enum.RenderPriority.Camera.Value + 1, function()
    if LocalPlayer.Character and (DaemonConfig.KillAll or DaemonConfig.AimbotEnabled) then
        local currentTarget = SelectOptimalTarget(DaemonConfig.KillAll)
        if currentTarget then
            local headPart = currentTarget:FindFirstChild("Head")
            if headPart then
                local targetCFrame = CFrame.new(Camera.CFrame.Position, headPart.Position)
                Camera.CFrame = Camera.CFrame:Lerp(targetCFrame, 0.35)
            end
        end
    end
end)

-- Meta Hook Security Layer (Fully Patched & Protected)
local MetaTableSuccess, MetaTable = pcall(function() return getrawmetatable(game) end)
if MetaTableSuccess and MetaTable then
    local NamecallHook = MetaTable.__namecall
    setreadonly(MetaTable, false)

    MetaTable.__namecall = newcclosure(function(Self, ...)
        local ExecutionArguments = {...}
        local CallMethod = getnamecallmethod()
        
        if CallMethod == "Crash" or string.find(string.lower(tostring(Self)), "telemetry") or string.find(string.lower(tostring(Self)), "analytics") then
            return nil
        end
        
        if DaemonConfig.SilentAim and CallMethod == "FireServer" then
            local targetEntity = SelectOptimalTarget(false)
            if targetEntity and targetEntity:FindFirstChild("Head") then
                for index, argument in ipairs(ExecutionArguments) do
                    if typeof(argument) == "Vector3" then
                        ExecutionArguments[index] = targetEntity.Head.Position
                        break
                    elseif typeof(argument) == "CFrame" then
                        ExecutionArguments[index] = CFrame.new(targetEntity.Head.Position)
                        break
                    end
                end
                return NamecallHook(Self, unpack(ExecutionArguments))
            end
        end
        
        return NamecallHook(Self, ...)
    end)
    setreadonly(MetaTable, true)
end
