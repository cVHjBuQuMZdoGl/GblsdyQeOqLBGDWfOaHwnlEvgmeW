loadstring([[
    function LPH_NO_VIRTUALIZE(f) return f end;
]])();
 
 
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
 
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
 
 
getgenv().Rake = {
    Settings = {
        Prediction = 0.04,
        JumpOffSet = 0.06,
        ByEzTerminals = nil,
        Resolver = false,
        AimPart = "Head",
        Misc = {
            AutoReload = true,
            AutoClicker = false,
            ForceHit = true,
            Whitelist = {
                UserWhitelist = false,
                HwidWhitelist = false
            },
            AdvancedMisc = {
                Desync = false,
                AutoShoot = false,
                AutoToxic = false
            }
        },
        Premium = {
            BlackList = false
        },
        AutoKick = {
            Kick = false
        },
        Important = {
            LookAt = false
        },
        AutoAir = {
            AutoAir = false,
            Delay = 0.1
        },
        AntiGroundShots = false
    }
}
 
local enabled = true
local whitelist = {"","","",""}
 
local function AntiGround(Velocity)
    return math.clamp(Velocity.Y * getgenv().Rake.Settings.Prediction, 0.15, math.huge)
end
 
local function findNearestEnemy()
    local LocalPlayer = game.Players.LocalPlayer
    local ClosestDistance, ClosestPlayer, ClosestPart = math.huge, nil, nil
    for _, Player in pairs(game.Players:GetPlayers()) do
        if Player ~= LocalPlayer then
            local Character = Player.Character
            if Character and Character:FindFirstChild("Humanoid") and Character.Humanoid.Health > 0 then
                local Part = Character:FindFirstChild(getgenv().Rake.Settings.AimPart)
                if Part then
                    local Position = game:GetService("Workspace").CurrentCamera:WorldToViewportPoint(Part.Position)
                    if Position then
                        local Distance = (LocalPlayer.Character[getgenv().Rake.Settings.AimPart].Position - Part.Position).Magnitude
                        if Distance < ClosestDistance then
                            ClosestPlayer = Player
                            ClosestPart = Part
                            ClosestDistance = Distance
                        end
                    end
                end
            end
        end
    end
    return ClosestPlayer, ClosestPart
end
 
 
 
local function highlight(plr)
    if plr and plr.Character then
        for _, player in pairs(game.Players:GetPlayers()) do
            if player.Character then
                for _, obj in pairs(player.Character:GetChildren()) do
                    if obj:IsA("Highlight") then
                        obj:Destroy()
                    end
                end
            end
        end
        for _, obj in pairs(plr.Character:GetChildren()) do
            if obj:IsA("Highlight") then
                obj:Destroy()
            end
        end
        local highlight = Instance.new("Highlight")
        highlight.Parent = plr.Character
        highlight.FillColor = Color3.new(0.411765, 0.501961, 1.000000)
        highlight.OutlineColor = Color3.new(0.031373, 0.031373, 0.031373)
        highlight.FillTransparency = 0.6
        highlight.OutlineTransparency = 0
    end
end
 
local Sigmaballs = Instance.new("ScreenGui")
local ImageButton = Instance.new("ImageButton")
local Ui2corner = Instance.new("UICorner")
 
Sigmaballs.Name = "Sigmaballs"
Sigmaballs.Parent = game.CoreGui
Sigmaballs.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Sigmaballs.ResetOnSpawn = false
 
ImageButton.Name = "ImageButton"
ImageButton.Parent = Sigmaballs
ImageButton.Active = true
ImageButton.Draggable = true
ImageButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ImageButton.BackgroundTransparency = 0.35
ImageButton.Size = UDim2.new(0, 90, 0, 90)
ImageButton.Image = "rbxassetid://11322415498"
ImageButton.Position = UDim2.new(0.5, -45, 0.5, -45)
 
Ui2corner.CornerRadius = UDim.new(0.2, 0)
Ui2corner.Parent = ImageButton
 
ImageButton.MouseButton1Click:Connect(function()
    enabled = not enabled
    if enabled then
        ImageButton.Image = "rbxassetid://11322415498"
        Plr, ClosestPart = findNearestEnemy()
        highlight(Plr)
    else
        ImageButton.Image = "rbxassetid://134820707156642"
        if Plr and Plr.Character then
            for _, obj in pairs(Plr.Character:GetChildren()) do
                if obj:IsA("Highlight") then
                    obj:Destroy()
                end
            end
        end
        Plr, ClosestPart = nil, nil
    end
end)
 
 RunService.Heartbeat:Connect(function()
    if getgenv().Rake.Settings.Misc.ForceHit then
 
        if ClosestPart then
            local LocalPlayer = Players.LocalPlayer
            local CurrentPosition = LocalPlayer.Character.HumanoidRootPart.Position
            local ShootDirection = LocalPlayer.Character.HumanoidRootPart.CFrame.LookVector
            local ShootPosition = CurrentPosition + ShootDirection * 10
            local Normal = ShootDirection.unit
            local Offset = Normal * 0.5
 
            local Args = {
                [1] = "Shoot",
                [2] = {
                    [1] = {
                        [1] = {
                            ["Instance"] = ClosestPart,
                            ["Normal"] = Normal,
                            ["Position"] = CurrentPosition
                        }
                    },
                    [2] = {
                        [1] = {
                            ["thePart"] = ClosestPart,
                            ["theOffset"] = CFrame.new(Offset)
                        }
                    },
                    [3] = ShootPosition,
                    [4] = CurrentPosition,
                    [5] = tick()
                }
            }
 
            ReplicatedStorage.MainEvent:FireServer(unpack(Args))
        end
    end
end)
 
local mt = getrawmetatable(game)
local old = mt.__index
setreadonly(mt, false)
 
local PredictionValue = getgenv().Rake.Settings.Prediction
 
old = hookmetamethod(game, "__index", LPH_NO_VIRTUALIZE( function(t, k)
mt.__index = newcclosure(function(self, key)
    if not checkcaller() and enabled and typeof(self) == "Instance" and self:IsA("Mouse") and key == "Hit" then
        if Plr and Plr.Character and Plr.Character:FindFirstChild(getgenv().Rake.Settings.AimPart) then
            local target = Plr.Character[getgenv().Rake.Settings.AimPart]
            local Position = target.Position + (Plr.Character.Head.Velocity * PredictionValue)
            return CFrame.new(Position)
        end
    end
    return old(self, key)
end)
end ))loadstring([[
    function LPH_NO_VIRTUALIZE(f) return f end;
]])();
 
 
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
 
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
 
 
getgenv().Rake = {
    Settings = {
        Prediction = 0.04,
        JumpOffSet = 0.06,
        ByEzTerminals = nil,
        Resolver = false,
        AimPart = "Head",
        Misc = {
            AutoReload = true,
            AutoClicker = false,
            ForceHit = true,
            Whitelist = {
                UserWhitelist = false,
                HwidWhitelist = false
            },
            AdvancedMisc = {
                Desync = false,
                AutoShoot = false,
                AutoToxic = false
            }
        },
        Premium = {
            BlackList = false
        },
        AutoKick = {
            Kick = false
        },
        Important = {
            LookAt = false
        },
        AutoAir = {
            AutoAir = false,
            Delay = 0.1
        },
        AntiGroundShots = false
    }
}
 
local enabled = true
local whitelist = {"","","",""}
 
local function AntiGround(Velocity)
    return math.clamp(Velocity.Y * getgenv().Rake.Settings.Prediction, 0.15, math.huge)
end
 
local function findNearestEnemy()
    local LocalPlayer = game.Players.LocalPlayer
    local ClosestDistance, ClosestPlayer, ClosestPart = math.huge, nil, nil
    for _, Player in pairs(game.Players:GetPlayers()) do
        if Player ~= LocalPlayer then
            local Character = Player.Character
            if Character and Character:FindFirstChild("Humanoid") and Character.Humanoid.Health > 0 then
                local Part = Character:FindFirstChild(getgenv().Rake.Settings.AimPart)
                if Part then
                    local Position = game:GetService("Workspace").CurrentCamera:WorldToViewportPoint(Part.Position)
                    if Position then
                        local Distance = (LocalPlayer.Character[getgenv().Rake.Settings.AimPart].Position - Part.Position).Magnitude
                        if Distance < ClosestDistance then
                            ClosestPlayer = Player
                            ClosestPart = Part
                            ClosestDistance = Distance
                        end
                    end
                end
            end
        end
    end
    return ClosestPlayer, ClosestPart
end
 
 
 
local function highlight(plr)
    if plr and plr.Character then
        for _, player in pairs(game.Players:GetPlayers()) do
            if player.Character then
                for _, obj in pairs(player.Character:GetChildren()) do
                    if obj:IsA("Highlight") then
                        obj:Destroy()
                    end
                end
            end
        end
        for _, obj in pairs(plr.Character:GetChildren()) do
            if obj:IsA("Highlight") then
                obj:Destroy()
            end
        end
        local highlight = Instance.new("Highlight")
        highlight.Parent = plr.Character
        highlight.FillColor = Color3.new(0.411765, 0.501961, 1.000000)
        highlight.OutlineColor = Color3.new(0.031373, 0.031373, 0.031373)
        highlight.FillTransparency = 0.6
        highlight.OutlineTransparency = 0
    end
end
 
local Sigmaballs = Instance.new("ScreenGui")
local ImageButton = Instance.new("ImageButton")
local Ui2corner = Instance.new("UICorner")
 
Sigmaballs.Name = "Sigmaballs"
Sigmaballs.Parent = game.CoreGui
Sigmaballs.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Sigmaballs.ResetOnSpawn = false
 
ImageButton.Name = "ImageButton"
ImageButton.Parent = Sigmaballs
ImageButton.Active = true
ImageButton.Draggable = true
ImageButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ImageButton.BackgroundTransparency = 0.35
ImageButton.Size = UDim2.new(0, 90, 0, 90)
ImageButton.Image = "rbxassetid://11322415498"
ImageButton.Position = UDim2.new(0.5, -45, 0.5, -45)
 
Ui2corner.CornerRadius = UDim.new(0.2, 0)
Ui2corner.Parent = ImageButton
 
ImageButton.MouseButton1Click:Connect(function()
    enabled = not enabled
    if enabled then
        ImageButton.Image = "rbxassetid://11322415498"
        Plr, ClosestPart = findNearestEnemy()
        highlight(Plr)
    else
        ImageButton.Image = "rbxassetid://134820707156642"
        if Plr and Plr.Character then
            for _, obj in pairs(Plr.Character:GetChildren()) do
                if obj:IsA("Highlight") then
                    obj:Destroy()
                end
            end
        end
        Plr, ClosestPart = nil, nil
    end
end)
 
 RunService.Heartbeat:Connect(function()
    if getgenv().Rake.Settings.Misc.ForceHit then
 
        if ClosestPart then
            local LocalPlayer = Players.LocalPlayer
            local CurrentPosition = LocalPlayer.Character.HumanoidRootPart.Position
            local ShootDirection = LocalPlayer.Character.HumanoidRootPart.CFrame.LookVector
            local ShootPosition = CurrentPosition + ShootDirection * 10
            local Normal = ShootDirection.unit
            local Offset = Normal * 0.5
 
            local Args = {
                [1] = "Shoot",
                [2] = {
                    [1] = {
                        [1] = {
                            ["Instance"] = ClosestPart,
                            ["Normal"] = Normal,
                            ["Position"] = CurrentPosition
                        }
                    },
                    [2] = {
                        [1] = {
                            ["thePart"] = ClosestPart,
                            ["theOffset"] = CFrame.new(Offset)
                        }
                    },
                    [3] = ShootPosition,
                    [4] = CurrentPosition,
                    [5] = tick()
                }
            }
 
            ReplicatedStorage.MainEvent:FireServer(unpack(Args))
        end
    end
end)
 
local mt = getrawmetatable(game)
local old = mt.__index
setreadonly(mt, false)
 
local PredictionValue = getgenv().Rake.Settings.Prediction
 
old = hookmetamethod(game, "__index", LPH_NO_VIRTUALIZE( function(t, k)
mt.__index = newcclosure(function(self, key)
    if not checkcaller() and enabled and typeof(self) == "Instance" and self:IsA("Mouse") and key == "Hit" then
        if Plr and Plr.Character and Plr.Character:FindFirstChild(getgenv().Rake.Settings.AimPart) then
            local target = Plr.Character[getgenv().Rake.Settings.AimPart]
            local Position = target.Position + (Plr.Character.Head.Velocity * PredictionValue)
            return CFrame.new(Position)
        end
    end
    return old(self, key)
end)
end ))