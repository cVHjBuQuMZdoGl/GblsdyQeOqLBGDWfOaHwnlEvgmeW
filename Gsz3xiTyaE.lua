-- Decompiled from MoonSec V3 disassembly
-- (best-effort; control flow may need minor manual cleanup)
-- By ZeroVector101
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local localPlayer = Players.LocalPlayer
local v = Workspace.CurrentCamera
local v2 = Workspace.CurrentCamera

if not (localPlayer.Character) then
    local v3 = localPlayer.CharacterAdded:Wait()
end

if not (v3:FindFirstChild("HumanoidRootPart")) then
    local v4 = v3:WaitForChild("HumanoidRootPart")
end

if Elisium.Loaded then
    notify("Already Loaded")

    return

end

Elisium.Loaded = true
local RunService2 = game:GetService("RunService")
local _upv0 = nil
local _upv1 = false
RunService2.RenderStepped:Connect(function(p0)
    if Elisium.Camlock.Spectate and _upv0 then

        if _upv0.Character then

            if not (_upv1) then
                game.Workspace.CurrentCamera.CameraSubject = _upv0.Character.Humanoid
                _upv1 = true
            end

            local v = game.Workspace.CurrentCamera.CFrame.Position
            local v2 = _upv0.Character.HumanoidRootPart.Position
            game.Workspace.CurrentCamera.CFrame = CFrame.new(v, Vector3.new(v2.X, v.Y, v2.Z))
        else
            if _upv1 then
                game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
                _upv1 = false
            end
        end

        return

    end
end)
local v5 = Drawing.new("Circle")
v5.Visible = Elisium.Fov.Visible
v5.Color = Elisium.Fov.Color
v5.Transparency = Elisium.Fov.Transparency
v5.Thickness = 1
v5.NumSides = 1000000
v5.Radius = Elisium.Fov.Size
v5.Filled = Elisium.Fov.Filled
v5.Position = Vector2.new(v.ViewportSize.X / 2, v.ViewportSize.Y / 2)
local screenGui = Instance.new("ScreenGui")
local frame = Instance.new("Frame")
local uIListLayout = Instance.new("UIListLayout")
local TweenService = game:GetService("TweenService")
local RunService3 = game:GetService("RunService")

for v6, v7 in pairs(getgc(true)) do

    if type(v7) == "table" then
        setreadonly(v7, false)
        local v8 = rawget(v7, "indexInstance")

        if type(v8) == "table" then

            if v8[1] == "kick" then
                setreadonly(v8, false)
                local config = {"kick", function()
                    coroutine.yield()
                end}
                rawset(v7, "Table", config)
                warn("\n---[ INFO ]---\nBypassed Adonis Anti-Cheat/Anti-Exploit.\nBypass Method: Preventing Script Table From Communicating With The Server.")
            else
            end
        end

        screenGui.Name = "Notification"
        screenGui.Parent = game.CoreGui
        screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        frame.Name = "Holder"
        frame.Parent = screenGui
        frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        frame.BackgroundTransparency = 1
        frame.Position = UDim2.new(1, -10, 0, 10)
        frame.AnchorPoint = Vector2.new(1, 0)
        frame.Size = UDim2.new(0, 243, 0, 240)
        uIListLayout.Parent = frame
        uIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        uIListLayout.Padding = UDim.new(0, 4)
        notify = function(p0, p1)
            if p1 <= 0 then
                warn("Notification duration must be greater than 0")

                return

            end

            local v, v2, v3 = func_cb735e87(p0, p1)
            local v4 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            TweenService:Create(v, v4, {
                Transparency = 0,
            }):Play()
            TweenService:Create(v2, v4, config):Play()
            TweenService:Create(v3, v4, config):Play()
            local _upv0 = 0
            local _upv4 = nil
        end
        local RunService4 = game:GetService("RunService")
        RunService4.Heartbeat:Connect(func_3946778b)
        func_3946778b()
        local _upv0 = nil
        func_be45db8e()
        func_8a50aace()
        local UserInputService = game:GetService("UserInputService")

        if Elisium.Camlock.Mode == "Tool" then
            local tool = Instance.new("Tool")
            tool.RequiresHandle = false
            tool.Name = "Lock Tool "
            tool.Parent = localPlayer.Backpack
            tool.Activated:Connect(func_9ba4bc64)
        else
            if Elisium.Camlock.Mode == "Pc" then
                localPlayer:GetMouse().KeyDown:Connect(function(p0)
                    if p0 == "c" then
                        func_9ba4bc64()
                    end
                end)
            else
                if Elisium.Camlock.Mode == "Button" then
                    local _upv0 = localPlayer:WaitForChild("PlayerGui")
                    func_26236bfb()
                    localPlayer.CharacterAdded:Connect(function()
                        func_26236bfb()
                    end)
                else
                    if Elisium.Camlock.Mode == "Controller" then
                        UserInputService.InputBegan:Connect(function(p0, p1)
                            if not (p1) and p0.KeyCode == Enum.KeyCode.DPadDown then
                                func_9ba4bc64()
                            end
                        end)
                    end
                end
            end
        end

        local _upv0 = nil
        RunService3.RenderStepped:Connect(function(...)
            if _upv0 and _upv0.Character and _upv0.Character:FindFirstChild(Elisium.Camlock.AimPart) then
                local v = _upv0.Character[Elisium.Camlock.AimPart]
                v2.CFrame = v2.CFrame:Lerp(CFrame.new(v2.CFrame.p, v.Position + v.Velocity * Elisium.Camlock.Prediction), Elisium.Camlock.Smoothness, Elisium.Easing.EasingStyle, Elisium.Easing.EasingDirection)

                if Elisium.Strafe.Enabled then
                    local v2 = _upv0.Character.HumanoidRootPart.Position

                    if Elisium.Strafe.Mode == "Random" then
                    else
                    end

                    local v3 = v2 + Vector3.new(math.cos(tick() * Elisium.Strafe.StrafeSpeed) * Elisium.Strafe.StrafeRadius, Elisium.Strafe.StrafeHeight, math.sin(tick() * Elisium.Strafe.StrafeSpeed) * Elisium.Strafe.StrafeRadius)
                    localPlayer.Character:SetPrimaryPartCFrame()
                    localPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(localPlayer.Character.HumanoidRootPart.CFrame.Position, Vector3.new(v2.X, localPlayer.Character.HumanoidRootPart.CFrame.Position.Y, v2.Z))
                end
            end
        end)
        local _upv0 = nil
        RunService3.RenderStepped:Connect(function(p0)
            if Elisium.AutoAir.Enabled and _upv0 and _upv0.Character and _upv0.Character:FindFirstChild("HumanoidRootPart") then
                local v = _upv0.Character:FindFirstChild("Humanoid")

                if v then
                    local v2 = v:GetState()
                    local localPlayer = game.Players.LocalPlayer.Character
                    -- [!] UNRESOLVED BRANCH: TestSet logic failed here
                else
                    local v3 = localPlayer:FindFirstChildOfClass("Tool")
                end

                if v2 ~= Enum.HumanoidStateType.Jumping then

                    if v2 == Enum.HumanoidStateType.Freefall and v3 and v3.Name ~= "Lock Tool" then

                        task.wait(Elisium.AutoAir.Delay)
                        v3:Activate()
                    end

                    if Elisium.Strafe.Mode == "Random" then
                        RunService3.RenderStepped:Connect(function()
                            if Elisium.Strafe.Enabled and _upv0 and _upv0.Character and _upv0.Character:FindFirstChild("HumanoidRootPart") then
                                local v = _upv0.Character.HumanoidRootPart
                                v.CFrame = v.CFrame + Vector3.new(math.random(-1, 1) * Elisium.Strafe.StrafeRadius, Elisium.Strafe.StrafeHeight, math.random(-1, 1) * Elisium.Strafe.StrafeRadius)
                            end
                        end)
                    end

                    return

                end
            end
        end)
        RunService3.RenderStepped:Connect(func_be45db8e)
        local _upv1 = v3:WaitForChild("Humanoid")
        local _upv3 = nil
        RunService3.Heartbeat:Connect(function(p0)
            if Elisium.Camlock.Enabled and Elisium.Strafe.Enabled and Elisium.Strafe.Mode == "CSync" and v3 and _upv1 and v4 and _upv3 then
                local v = tick() * Elisium.Strafe.StrafeSpeed
                local v2 = Vector3.new(math.cos(v) * Elisium.Strafe.StrafeRadius, Elisium.Strafe.StrafeHeight, math.sin(v) * Elisium.Strafe.StrafeRadius)
                playerHumanoidRootPartCFrame = v4.CFrame
                _upv1.AutoRotate = true
                v4.CFrame = CFrame.new(_upv3.Character.HumanoidRootPart.Position + v2)
                v4.CFrame = CFrame.lookAt(v4.Position, Vector3.new(_upv3.Character.HumanoidRootPart.Position.X, v4.Position.Y, _upv3.Character.HumanoidRootPart.Position.Z))
                func_3946778b()

                if playerClone and playerClone:FindFirstChild("HumanoidRootPart") then
                    playerClone.HumanoidRootPart.CFrame = CFrame.new(_upv3.Character.HumanoidRootPart.Position + v2)
                    playerClone.HumanoidRootPart.CFrame = CFrame.lookAt(playerClone.HumanoidRootPart.Position, Vector3.new(_upv3.Character.HumanoidRootPart.Position.X, playerClone.HumanoidRootPart.Position.Y, _upv3.Character.HumanoidRootPart.Position.Z))
                end

                if Elisium.Strafe.Spoof then
                    RunService3.RenderStepped:Wait()
                    v4.CFrame = playerHumanoidRootPartCFrame
                    playerHumanoidRootPartCFrame = v4.CFrame
                else
                    if playerClone then
                        playerClone:Destroy()
                        playerClone = nil
                    end
                end

                return

            end
        end)
        local _upv0 = nil
        local _upv3 = nil

        spawn(function()
            RunService3.Heartbeat:Connect(function()
                if Elisium.Cframe.enabled then
                    localPlayer.Character.HumanoidRootPart.CFrame = localPlayer.Character.HumanoidRootPart.CFrame + localPlayer.Character.Humanoid.MoveDirection * Elisium.Cframe.speed
                end
            end)
        end)

        for v9, v10 in pairs(getconnections(v2.Changed)) do
            v10:Disable()
        end

        local v11 = "CFrame"

        for v12, v13 in pairs(getconnections(v2:GetPropertyChangedSignal(v11))) do
            v13:Disable()
        end

        local v14 = getrawmetatable(game)
        setreadonly(v14, false)
        local _upv0 = nil
        local _upv1 = v14.__namecall
        v14.__namecall = newcclosure(function(p0, p1)
            local config = {}

            if not (checkcaller()) and getnamecallmethod() == "FireServer" and Elisium.TargetAim.Enabled then

                for v, v2 in ipairs(config) do

                    if typeof(v2) == "Vector3" and _upv0 and _upv0.Character then
                        config[v] = _upv0.Character[Elisium.TargetAim.AimPart].Position + _upv0.Character[Elisium.TargetAim.AimPart].Velocity * Elisium.TargetAim.Prediction
                        local v3 = p0
                        local v4 = unpack(config)
                        -- [57] TailCall: return R9()

                        return _upv1

                    end
                end
            end

            -- [64] TailCall: return R4()

            return _upv1
        end)
        setreadonly(v14, true)
        RunService3.Heartbeat:Connect(function(p0)
            if Elisium.AutoPred.Enabled and Elisium.AutoPred.Mode == "Ping" then
                local Stats = game:GetService("Stats")
                local v = tonumber(Stats.Network.ServerStatsItem["Data Ping"]:GetValueString():match("%d+"))

                if v then

                    if 225 < v then
                        Elisium.Camlock.prediction = 0.166547
                    else
                        if 215 < v then
                            Elisium.Camlock.prediction = 0.15692
                        else
                            if 205 < v then
                                Elisium.Camlock.prediction = 0.165732
                            else
                                if 190 < v then
                                    Elisium.Camlock.prediction = 0.169
                                else
                                    if 185 < v then
                                        Elisium.Camlock.prediction = 0.1235666
                                    else
                                        if 180 < v then
                                            Elisium.Camlock.prediction = 0.16779123
                                        else
                                            if 175 < v then
                                                Elisium.Camlock.prediction = 0.165455312399999
                                            else
                                                if 170 < v then
                                                    Elisium.Camlock.prediction = 0.16
                                                else
                                                    if 165 < v then
                                                        Elisium.Camlock.prediction = 0.15
                                                    else
                                                        if 160 < v then
                                                            Elisium.Camlock.prediction = 0.1223333
                                                        else
                                                            if 155 < v then
                                                                Elisium.Camlock.prediction = 0.125333
                                                            else
                                                                if 150 < v then
                                                                    Elisium.Camlock.prediction = 0.1652131
                                                                else
                                                                    if 145 < v then
                                                                        Elisium.Camlock.prediction = 0.129934
                                                                    else
                                                                        if 140 < v then
                                                                            Elisium.Camlock.prediction = 0.1659921
                                                                        else
                                                                            if 135 < v then
                                                                                Elisium.Camlock.prediction = 0.1659921
                                                                            else
                                                                                if 130 < v then
                                                                                    Elisium.Camlock.prediction = 0.12399
                                                                                else
                                                                                    if 125 < v then
                                                                                        Elisium.Camlock.prediction = 0.15465
                                                                                    else
                                                                                        if 110 < v then
                                                                                            Elisium.Camlock.prediction = 0.142199
                                                                                        else
                                                                                            if 105 < v then
                                                                                                Elisium.Camlock.prediction = 0.141199
                                                                                            else
                                                                                                if 100 < v then
                                                                                                    Elisium.Camlock.prediction = 0.134143
                                                                                                else
                                                                                                    if 90 < v then
                                                                                                        Elisium.Camlock.prediction = 0.1433333333392
                                                                                                    else
                                                                                                        if 80 < v then
                                                                                                            Elisium.Camlock.prediction = 0.1332241241231
                                                                                                        else
                                                                                                            if 70 < v then
                                                                                                                Elisium.Camlock.prediction = 0.1513989
                                                                                                            else
                                                                                                                if 60 < v then
                                                                                                                    Elisium.Camlock.prediction = 0.133
                                                                                                                else
                                                                                                                    if 50 < v then
                                                                                                                        Elisium.Camlock.prediction = 0.12118333
                                                                                                                    else
                                                                                                                        if 40 < v then
                                                                                                                            Elisium.Camlock.prediction = 0.12588244444444
                                                                                                                        else
                                                                                                                            if 35 < v then
                                                                                                                                Elisium.Camlock.prediction = 0.12565
                                                                                                                            else
                                                                                                                                if 30 < v then
                                                                                                                                    Elisium.Camlock.prediction = 0.1419283
                                                                                                                                else
                                                                                                                                    if 25 < v then
                                                                                                                                        Elisium.Camlock.prediction = 0.12948111
                                                                                                                                    else
                                                                                                                                        if 20 < v then
                                                                                                                                            Elisium.Camlock.prediction = 0.1211928
                                                                                                                                        end
                                                                                                                                    end
                                                                                                                                end
                                                                                                                            end
                                                                                                                        end
                                                                                                                    end
                                                                                                                end
                                                                                                            end
                                                                                                        end
                                                                                                    end
                                                                                                end
                                                                                            end
                                                                                        end
                                                                                    end
                                                                                end
                                                                            end
                                                                        end
                                                                    end
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end)
        local _upv0 = nil
        RunService3.Heartbeat:Connect(function(p0)
            if Elisium.AutoPred.Enabled and Elisium.AutoPred.Mode == "Advanced" then
                local Stats = game:GetService("Stats")
                local v = tonumber(Stats.Network.ServerStatsItem["Data Ping"]:GetValueString():match("%d+"))

                if _upv0 and _upv0.Character and _upv0.Character:FindFirstChild("HumanoidRootPart") then
                    local v2 = _upv0.Character.HumanoidRootPart
                    local v3 = v2.Position
                    local v4 = v3 - v2.CFrame.Position.magnitude
                    local v5, v6 = workspace:FindPartOnRay(Ray.new(v2.CFrame.Position, v3 - v2.CFrame.Position.unit * v4), v2.Parent)

                    if v and 0 < v then
                        local v7 = math.clamp(v / 1000, 0, 0.3) + math.clamp(v4 / 1000, 0, 0.5) + v2.Velocity.magnitude / 500 + math.random() * 0.1 - 0.05 + 0.1
                        Elisium.Camlock.Prediction = v7
                        Elisium.TargetAim.Prediction = v7
                    end
                end
            end
        end)

        if Elisium.ConfiguresOFTEXTURES.ON then
            local _upv1 = workspace.DescendantAdded:Connect(func_36992f17)

            task.spawn(function()
                func_a302914a()

                task.wait(30)

                if _upv1 then
                    _upv1:Disconnect()
                end
            end)

            task.spawn(function()
                while true do

                    if Elisium.ConfiguresOFTEXTURES.ON then
                        func_a302914a()

                        task.wait(60)
                    end
                end
            end)
        end

        if Elisium.Intro.Enabled then
            func_005e514a()
        end

        if Elisium.Macro.Enabled then
            func_369c9665()
            game.Players.LocalPlayer.CharacterAdded:Connect(function()
            end)
        end

        RunService3.Heartbeat:Connect(function(...)
            if Elisium.NoDelay.Enabled then
                local CorePackages = game:GetService("CorePackages")
                CorePackages.Packages:Destroy()
            end

            if Elisium.Mouse_TP.Enabled and not (Elisium.Mouse_TP.UsePrediction) then

                if Elisiumtarget then
                else
                    if Elisium.Mouse_TP.UsePrediction and Elisiumtarget then
                        local v = CFrame.new(workspace.CurrentCamera.CFrame.Position + Target.Character[Elisium.Mouse_TP.Part].Velocity * Elisium.Mouse_TP.Prediction)
                    end
                end

                if Elisiumtarget and Elisiumtarget.Character.Humanoid.Health == Elisium.Mouse_TP.Health_Value then

                    if Elisium.Mouse_TP.Method == "Health" then
                        workspace.CC.CFrame(v)
                    else
                        if Elisiumtarget and JumpState and Elisium.Mouse_TP.Method == "Jumping" then
                            wait(Elisium.Mouse_TP.Jump_Wait)
                            workspace.CC.CFrame(v)
                        end
                    end

                    if getgenv().Elisium.Offsets.Enabled and humanoid then

                        if humanoid:GetState() == Enum.HumanoidStateType.Jumping then
                            targetPos = targetPos + Vector3.new(0, getgenv().Elisium.Offsets.jumpOffset, 0)
                        else
                            if humanoid:GetState() == Enum.HumanoidStateType.Freefall then
                                targetPos = targetPos + Vector3.new(0, getgenv().Elisium.Offsets.fallOffset, 0)
                            end
                        end
                    end

                    v2.CFrame = v2.CFrame:Lerp(CFrame.new(v2.CFrame.Position, targetPos), Elisium.camlock.smoothness)
                    cloneref(Game)
                    LocalPlayer.CharacterAdded:Connect(function(p0)
                        LocalCharacter = p0
                        PlayerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
                    end)

                    if getgenv().Elisium.Resolver.Enabled and getgenv().Elisium.Resolver.Method == "RecalculateVelocity" then
                        local v2 = tick()

                        if lastPosition and Elisiumtarget.Character:FindFirstChild(getgenv().Elisium.Resolver.PredictionSettings.HitPart) then
                            lastPosition = Elisiumtarget.Character[getgenv().Elisium.Resolver.PredictionSettings.HitPart].Position
                            lastUpdateTime = v2

                            return Elisiumtarget.Character[getgenv().Elisium.Resolver.PredictionSettings.HitPart].Position - lastPosition / v2 - lastUpdateTime

                        end

                        lastPosition = Elisiumtarget.Character[getgenv().Elisium.Resolver.PredictionSettings.HitPart].Position
                        lastUpdateTime = v2
                    end

                    return Elisiumtarget.Character[getgenv().Elisium.Resolver.PredictionSettings.HitPart].Velocity

                end
            end
        end)

        return

    end
end

local function func_26236bfb(...)

    if not (_upv0:FindFirstChild("LockScreenGui")) then
        local screenGui = Instance.new("ScreenGui")
        local v = screenGui
        v.Name = "LockScreenGui"
        v.Parent = _upv0
    end

    if not (v:FindFirstChild("LockButton")) then
        local imageButton = Instance.new("ImageButton")
        local v2 = imageButton
        v2.Name = "LockButton"
        v2.Size = UDim2.new(0, 100, 0, 50)
        v2.Position = UDim2.new(1, -100, 0, 20)
        v2.Image = "rbxassetid://72683839590930"
        v2.ImageTransparency = 0
        v2.BackgroundTransparency = 1
        v2.Parent = v
        v2.Active = true
        v2.Draggable = true
        local uICorner = Instance.new("UICorner")
        uICorner.CornerRadius = UDim.new(0, 25)
        uICorner.Parent = v2
        v2.MouseButton1Click:Connect(function()
            func_9ba4bc64()
        end)
    end

    return

end

local function func_8a50aace()

    if getgenv().Elisium.LineTrail.Enabled then
        local localPlayer = game.Players.LocalPlayer.Character

        if localPlayer then
            local v = localPlayer:FindFirstChild("HumanoidRootPart")

            if v then
                local attachment = Instance.new("Attachment")
                attachment.Parent = v
                attachment.Name = "TrailStart"
                local attachment2 = Instance.new("Attachment")
                attachment2.Parent = v
                attachment2.Position = Vector3.new(0, -3, 0)
                attachment2.Name = "TrailEnd"
                local trail = Instance.new("Trail")
                trail.Parent = v
                trail.Attachment0 = attachment
                trail.Attachment1 = attachment2
                trail.Color = ColorSequence.new(getgenv().Elisium.LineTrail.Color)
                local config = {}
                NumberSequenceKeypoint.new(0, getgenv().Elisium.LineTrail.TransparencyStart)
                trail.Transparency = NumberSequence.new(config)
                trail.Lifetime = getgenv().Elisium.LineTrail.Speed
                trail.MinLength = getgenv().Elisium.LineTrail.MinLength
                trail.FaceCamera = true
                trail.WidthScale = NumberSequence.new(getgenv().Elisium.LineTrail.Width)
                v.Material = Enum.Material[getgenv().Elisium.LineTrail.Material]
            end
        end
    end

    return

end

local function func_81770a87(...)

    for v, v2 in ipairs(Players:GetPlayers()) do

        if v2 ~= localPlayer and v2.Character then

            for v3, v4 in ipairs(v2.Character:GetChildren()) do

                if v4:IsA("BasePart") and v4.Transparency ~= 1 then
                    local v5, v6 = v2:WorldToViewportPoint(v4.Position)
                    local v7 = Vector2.new(v5.X, v5.Y) - v5.Position.Magnitude

                end
            end
        end
    end

    return v2

end

local function func_9ba4bc64()

    if Elisium.Camlock.Enabled then

        if _upv0 then
            notify("Lock: Unlocked!", 5)
            _upv0 = nil
        else
            _upv0 = func_81770a87()

            if _upv0 then
                notify("Lock: Locked onto " .. tostring(_upv0.Name), 5)
            else
                notify("Lock: No target found", 5)
                notify("Lock not enabled", 5)
            end
        end

        return

    end
end

local function func_369c9665()

    if game.Players.LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("ScreenGui") then

        return

    end

    local screenGui = Instance.new("ScreenGui")
    local frame = Instance.new("Frame")
    local textButton = Instance.new("TextButton")
    screenGui.Name = "ScreenGui"
    screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    screenGui.ResetOnSpawn = false
    frame.Name = "OutlineFrame"
    frame.Parent = screenGui
    frame.Position = UDim2.new(0, 10, 0, 10)
    frame.Size = UDim2.new(0, 120, 0, 60)
    frame.BackgroundTransparency = 1
    frame.BorderSizePixel = 2
    frame.BorderColor3 = Color3.fromRGB(255, 165, 0)
    textButton.Name = "Macro"
    textButton.Parent = frame
    textButton.Size = UDim2.new(0, 100, 0, 50)
    textButton.Position = UDim2.new(0, 5, 0, 5)
    textButton.Text = "Macro"
    textButton.BackgroundColor3 = Color3.fromRGB(51, 51, 51)
    textButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    textButton.Font = Enum.Font.Gotham
    textButton.TextSize = 24
    local uICorner = Instance.new("UICorner")
    uICorner.CornerRadius = UDim.new(0, 12)
    uICorner.Parent = textButton
    textButton.MouseEnter:Connect(function()
        textButton.BackgroundColor3 = Color3.fromRGB(255, 128, 0)
        textButton.TextColor3 = Color3.fromRGB(0, 0, 0)
    end)
    textButton.MouseLeave:Connect(function()
        textButton.BackgroundColor3 = Color3.fromRGB(51, 51, 51)
        textButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    end)
    textButton.MouseButton1Click:Connect(function()
        textButton.BackgroundColor3 = Color3.fromRGB(255, 128, 0)
        wait(0.1)
        textButton.BackgroundColor3 = Color3.fromRGB(51, 51, 51)
    end)
    local RunService = game:GetService("RunService")
    local v = false
    local _upv0 = game.Players.LocalPlayer
    local _upv1 = game.Workspace.CurrentCamera
    textButton.MouseButton1Click:Connect(function()
        v = not v

        if v then
            textButton.Text = "Macro"
            func_be40c6fc()
        else
            textButton.Text = "Macro"
        end
    end)
    local v2 = nil
    local v3 = nil
    local v4 = nil
    local v5 = nil
    textButton.InputBegan:Connect(function(p0)
        if p0.UserInputType ~= Enum.UserInputType.MouseButton1 then

            if p0.UserInputType == Enum.UserInputType.Touch then
                v2 = true
                v4 = p0.Position
                v5 = textButton.Position
                p0.Changed:Connect(function(...)
                    if p0.UserInputState == Enum.UserInputState.End then
                        v2 = false
                    end
                end)
            end

            return

        end
    end)
    textButton.InputChanged:Connect(function(p0)
        if p0.UserInputType ~= Enum.UserInputType.MouseMovement then

            if p0.UserInputType == Enum.UserInputType.Touch then
                v3 = p0
            end

            return

        end
    end)
    textButton.InputChanged:Connect(function(p0)
        if p0 == v3 and v2 then
            local v = p0.Position - v4
            textButton.Position = UDim2.new(v5.X.Scale, v5.X.Offset + v.X, v5.Y.Scale, v5.Y.Offset + v.Y)
        end
    end)

    return

end

local function func_be40c6fc()

    return

end

local function func_32ea2dee(v0)

    if v then
        func_e8b9ac84()
    else
        v0:Disconnect()
    end

    return

end

local function func_e8b9ac84()

    local v = _upv0.CharacterAdded:Wait():WaitForChild("HumanoidRootPart")
    local v2 = v.Position
    local v3 = _upv1.CFrame.LookVector
    v.CFrame = CFrame.new(v2, v2 + Vector3.new(v3.X, 0, v3.Z).Unit)

    return

end

local function func_a302914a(...)

    for v, v2 in ipairs(workspace:GetDescendants()) do
        func_36992f17(v2)

        if v % 500 == 0 then

            task.wait()
        end
    end

    return

end

local function func_07c7ae1b()
    local localPlayer = game.Players.LocalPlayer.Character

    if localPlayer then
        func_26ab3a96(localPlayer)
    end

    return

end

local function func_26ab3a96(p0)

    if getgenv().Elisium.BallTrail.Enabled then
        local v = p0:FindFirstChild("HumanoidRootPart")

        if v then

            while true do

                if getgenv().Elisium.BallTrail.Enabled then
                    local part = Instance.new("Part")
                    part.Shape = Enum.PartType.Ball
                    part.Size = getgenv().Elisium.BallTrail.Size
                    part.Color = getgenv().Elisium.BallTrail.Color
                    part.Material = Enum.Material[getgenv().Elisium.BallTrail.Material]
                    part.Anchored = true
                    part.CanCollide = false
                    part.CFrame = v.CFrame
                    part.Parent = workspace
                    local TweenService = game:GetService("TweenService")
                    TweenService:Create(part, TweenInfo.new(getgenv().Elisium.BallTrail.Lifetime, Enum.EasingStyle.Linear), {
                        Transparency = getgenv().Elisium.BallTrail.TransparencyEnd,
                    }):Play()
                    game.Debris:AddItem(part, getgenv().Elisium.BallTrail.Lifetime)
                    wait(getgenv().Elisium.BallTrail.Speed)
                end
            end
        end
    end

    return

end

local function func_62fefb0b(p0, p1, p2)
    local v, v2 = pcall(function()
        p0[p1] = p2
    end)

    return v

end

local function func_005e514a()
    local screenGui = Instance.new("ScreenGui")
    local frame = Instance.new("Frame")
    local imageLabel = Instance.new("ImageLabel")
    local sound = Instance.new("Sound")
    local blurEffect = Instance.new("BlurEffect")
    screenGui.Name = "IntroScreen"
    screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    frame.Name = "IntroFrame"
    frame.Parent = screenGui
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundTransparency = 1
    imageLabel.Name = "IntroImage"
    imageLabel.Parent = frame
    imageLabel.Size = UDim2.new(0.4, 0, 0.4, 0)
    imageLabel.Position = UDim2.new(0.3, 0, 0.3, 0)
    imageLabel.Image = "rbxassetid://72683839590930"
    imageLabel.BackgroundTransparency = 1
    imageLabel.ImageTransparency = 0.5
    sound.Name = "IntroSound"
    sound.Parent = frame
    sound.SoundId = "rbxassetid://135573970738247"
    sound.Volume = 10
    sound:Play()
    blurEffect.Parent = game.Lighting
    blurEffect.Size = 24
    imageLabel.ImageTransparency = 1
    local TweenService = game:GetService("TweenService")
    local v = TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 1)
    local v2 = TweenService:Create(imageLabel, v, {
        ImageTransparency = 0.5,
    })
    local v3 = TweenService:Create(imageLabel, v, {
        ImageTransparency = 1,
    })
    v2:Play()
    v2.Completed:Wait()
    wait(2)
    v3:Play()
    local v4 = TweenService:Create(blurEffect, TweenInfo.new(3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = 0,
    })
    v4:Play()
    v4.Completed:Wait()
    blurEffect:Destroy()
    v3.Completed:Wait()
    screenGui:Destroy()

    return

end

local function func_36992f17(p0)

    if p0:IsA("BasePart") then

        if not (p0:IsDescendantOf(game.Players.LocalPlayer.Character)) then
            func_62fefb0b(p0, "Material", Elisium.ConfiguresOFTEXTURES.Material)
            func_62fefb0b(p0, "Color", Elisium.ConfiguresOFTEXTURES.Color)
        else
            if not (p0:IsA("Texture")) then

                if p0:IsA("Decal") then
                    pcall(function()
                        p0.Transparency = 1
                    end)
                end

                return

            end
        end
    end
end

local function func_be45db8e(...)

    if getgenv().Elisium.Selfcham.Enabled and v3 then

        for v, v2 in ipairs(v3:GetChildren()) do

            if v2:IsA("MeshPart") then
                v2.Color = getgenv().Elisium.Selfcham.Color
                v2.Material = Enum.Material[getgenv().Elisium.Selfcham.Material]
                v2.CanCollide = false

                if v2.Name == "Head" and v2:FindFirstChild("face") then
                    v2:FindFirstChild("face"):Destroy()
                end
            end
        end
    end

    return

end

local function func_3946778b(...)

    if getgenv().Elisium.Visualizer.Enabled then

        if not (workspace:FindFirstChild("PlayerClones")) then
            local folder = Instance.new("Folder")
            local v = folder
            v.Name = "PlayerClones"
            v.Parent = workspace
        end

        if v3 then

            if not (playerClone) then
                v3.Archivable = true
                playerClone = v3:Clone()
                playerClone.Parent = v
                playerClone.Name = "LocalPlayer Clone"
                playerClone:FindFirstChild("HumanoidRootPart").Anchored = true
                playerClone:FindFirstChild("HumanoidRootPart").CanCollide = false

                for v2, v3 in ipairs(playerClone:GetChildren()) do

                    if v3:IsA("MeshPart") then

                        if v3.Name == "Head" and v3:FindFirstChild("face") then
                            v3:FindFirstChild("face"):Destroy()
                        end

                        v3.Color = getgenv().Elisium.Visualizer.Color
                        v3.Material = Enum.Material[getgenv().Elisium.Visualizer.Material]
                        v3.CanCollide = false
                    end

                    if not (v3:IsA("MeshPart")) and v3.Name ~= "HumanoidRootPart" then
                        v3:Destroy()
                    end
                end
            else
                if playerClone then
                    playerClone:Destroy()
                    playerClone = nil
                end
            end
        end

        return

    end
end

local function func_16b32176(p0, p1)

    if Elisium.Strafe.Enabled and Elisium.Strafe.Spoof and not (checkcaller()) and _upv0 and v3 and v4 and p0 == v4 and p1 == "CFrame" then

        return playerHumanoidRootPartCFrame

    end

    -- [33] TailCall: return R2(R3, R4)

    return _upv3

end

local function func_cb735e87(p0, p1)
    local frame = Instance.new("Frame")
    local frame2 = Instance.new("Frame")
    local textLabel = Instance.new("TextLabel")
    frame.Name = p0
    frame.Parent = frame
    frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    frame.BorderSizePixel = 0
    frame.Size = UDim2.new(1, 0, 0, 22)
    frame.Transparency = 1
    frame2.Name = "ColorBar"
    frame2.Parent = frame
    frame2.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    frame2.BorderSizePixel = 0
    frame2.Size = UDim2.new(0, 2, 0, 22)
    frame2.Transparency = 1
    textLabel.Parent = frame
    textLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.BorderSizePixel = 0
    textLabel.Position = UDim2.new(0, 8, 0, 0)
    textLabel.Size = UDim2.new(1, -10, 0, 22)
    textLabel.Font = Enum.Font.Code
    textLabel.Text = p0 .. " [" .. p1 .. "s]"
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.TextSize = 12
    textLabel.TextStrokeTransparency = 0
    textLabel.TextXAlignment = Enum.TextXAlignment.Left
    textLabel.Transparency = 1

    return frame, frame2, textLabel

end

local function func_1638013f(p0)
    _upv0 = _upv0 + p0
    local v = math.max(0, p1 - _upv0)
    v3.Text = p0 .. " [" .. string.format("%.1f", v) .. "s]"

    if v <= 0 then
        _upv4:Disconnect()
        local v2 = TweenService:Create(v, v4, {
            Transparency = 1,
        })
        v2:Play()
        v2.Completed:Wait()
        v:Destroy()
    end

    return

end
