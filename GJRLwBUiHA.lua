Zenbladi (LEAK)


--// Silent Aim Configuration
getgenv().Silent = {
    Settings = {
        Toggled = true,
        AimPart = "UpperTorso",
        HitChance = 9999,
        Prediction = {
            Toggled = true,
            Value = 0.13322,
            AutoPred = true,
            JumpOffset = 0.08,
            AntiGroundShots = true,
            Resolve = true,
        },
        Circle = {
            Visible = false,
            Transparency = 0.5,
            Thickness = 3,
            NumSides = 100,
            Radius = 54.50,
            Filled = false,
        },
        WallCheck = true,
        AutoShoot = true,
    }
}

--// Intro GUI & Sound
local player = game:GetService("Players").LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Parent = game:GetService("CoreGui") -- Hide from detection

local imageLabel = Instance.new("ImageLabel")
imageLabel.Parent = gui
imageLabel.Size = UDim2.new(0, 150, 0, 150)
imageLabel.Position = UDim2.new(0.5, -75, 0.5, -75)
imageLabel.Image = "rbxassetid://119910084495895"
imageLabel.BackgroundTransparency = 1
imageLabel.ScaleType = Enum.ScaleType.Fit

local sound = Instance.new("Sound")
sound.Parent = gui
sound.SoundId = "rbxassetid://130809871712701"
sound:Play()

task.wait(3)
imageLabel:Destroy()
sound:Stop()
sound:Destroy()

--// Load External Silent Aim Script
pcall(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/hi999999-max/silent-aim/refs/heads/main/Better-Silent-Aim", true))()
end)

--// Remove Jump Delay
game:GetService("Players").LocalPlayer.CharacterAdded:Connect(function(character)
    local humanoid = character:WaitForChild("Humanoid")
    humanoid.Changed:Connect(function()
        if humanoid:GetState() == Enum.HumanoidStateType.Physics then
            humanoid:Move(Vector3.new(0, 0, 0))
        end
    end)
end)

--// No-Delay Aiming System
local function noDelayAim(target)
    if target then
        local camera = workspace.CurrentCamera
        camera.CFrame = CFrame.new(camera.CFrame.Position, target.Position)
    end
end

--// Targeting Logic
local function getClosestTarget()
    local players = game:GetService("Players")
    local localPlayer = players.LocalPlayer
    local closestTarget = nil
    local shortestDistance = math.huge

    for _, player in pairs(players:GetPlayers()) do
        if player ~= localPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local distance = (player.Character.HumanoidRootPart.Position - localPlayer.Character.HumanoidRootPart.Position).Magnitude
            if distance < shortestDistance then
                shortestDistance = distance
                closestTarget = player.Character.HumanoidRootPart
            end
        end
    end

    return closestTarget
end

--// Constantly Update Aim
game:GetService("RunService").Heartbeat:Connect(function()
    local target = getClosestTarget()
    noDelayAim(target)
end)
