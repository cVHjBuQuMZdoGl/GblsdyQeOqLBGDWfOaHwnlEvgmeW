local Menu = loadstring(game:HttpGet("https://raw.githubusercontent.com/khenn791/library/refs/heads/main/cuh.txt",true))()

task.spawn(function()
    Menu:NameUpdate(0.6, 'Cactus', '.GG [khen.cc]')
end)


local Script = {
        Functions = {},
        Folders = {},
        Parts = {},
        Locals = {
            Target = nil,
            Targeting = false,
            Resolver = {
                OldTick = tick(),
                OldPos = Vector3.new(0, 0, 0),
                ResolvedVelocity = Vector3.new(0, 0, 0)
            },
            AutoSelectTick = tick(),
            AntiAimViewer = {
                MouseRemoteFound = false,
                MouseRemote = nil,
                MouseRemoteArgs = nil,
                MouseRemotePositionIndex = nil
            },
           GunTP = { 
                Enabled = false,
                Anchor = false,
                Offset = {0,-1,0},
           },
           Aura = { 
                Enabled = true,
                Color = Color3.fromRGB(0,0,67),
           },
           RocketTP = {
                Enabled = false,
           },
           GrenadeTP = {
                Enabled = false,
           },
           KnifeAbilityTest = {
               TargetPart = "HumanoidRootPart",
               Radius = 90,
               Visible = false
            },
            HitEffect = {
                ["Nova Impact"] = nil,
                ["Crescent Slash"] = nil,
                ["Crescent Slash"] = nil,
                ["Coom"] = nil,
                ["Cosmic Explosion"] = nil,
                ["Slash"] = nil,
                ["Atomic Slash"] = nil,
            },
            Gun = {
                PreviousGun = nil,
                PreviousAmmo = 999,
                Shotguns = {"[Double-Barrel SG]", "[TacticalShotgun]", "[Shotgun]"}
            },
            PlayerHealth = {},
            JumpOffset = 0,
            BulletPath = {
                [4312377180] = Workspace:FindFirstChild("MAP") and Workspace.MAP:FindFirstChild("Ignored") or nil,
                [1008451066] = Workspace:FindFirstChild("Ignored") and Workspace.Ignored:FindFirstChild("Siren") and Workspace.Ignored.Siren:FindFirstChild("Radius") or nil,
                [3985694250] = Workspace and Workspace:FindFirstChild("Ignored") or nil,
                [5106782457] = Workspace and Workspace:FindFirstChild("Ignored") or nil,
                [4937639028] = Workspace and Workspace:FindFirstChild("Ignored") or nil,
                [1958807588] = Workspace and Workspace:FindFirstChild("Ignored") or nil
            },
            SavedCFrame = nil,
            NetworkPreviousTick = tick(),
            NetworkShouldSleep = false,
            FFlags = {
      }
            ,OriginalVelocity = {},
            RotationAngle = 0
        },
        Utility = {
            Drawings = {},
            EspCache = {}
        },
        Connections = {
            GunConnections = {}
        },
        AuraIgnoreFolder = Instance.new("Folder", game:GetService("Workspace"))
    }

    local Settings = {
        Combat = {
            Enabled = false,
            Skibidi = true,
            Spectate = true,
            AimPart = "HumanoidRootPart",
            ESP = true,
            Silent = false,
            BetaAirshot = false,
            TriggerBot = {
                Enabled = false,
                Delay = 0,
                TargeyOnly = false,
                FOV = {
                    Show = true,
                    Size = 80
                }
            },
            TargetInfo = false,
            Camera = false,
            EasingStyle = "Sine",
            EasingDirection = "Out",
            Alerts = true,
            LookAt = false,
            Spectate = false,
            PingBased = false,
            UseIndex = false,
            AntiAimViewer = false,
            AutoSelect = {
                Enabled = false,
                Cooldown = {
                    Enabled = false,
                    Amount = 0.5
                }
            },
            Checks = {
                Enabled = false,
                Knocked = false,
                Crew = false,
                Wall = false,
                Grabbed = false,
                Vehicle = false
            },
            Smoothing = {
                Horizontal = 1,
                Vertical = 1
            },
            Prediction = {
                Horizontal = 0.134,
                Vertical = 0.134
            },
            Resolver = {
                Enabled = false,
                RefreshRate = 190
            },
            Fov = {
                Visualize = {
                    Enabled = false,
                    Color = Color3.new(1, 1, 1)
                },
                Radius = 80
            },
            Visuals = {
                Enabled = true,
                Tracer = {
                    Enabled = false,
                    Color = Color3.new(1, 1, 1),
                    Thickness = 2
                },
                Dot = {
                    Enabled = false,
                    Color = Color3.new(1, 1, 1),
                    Filled = true,
                    Size = 6
                },
                Chams = {
                    Enabled = false,
                    Fill = {
                        Color = Color3.fromRGB(255,209,220),
                        Transparency = 0.5
                    },
                    Outline = {
                        Color = Color3.new(255,255,255),
                        Transparency = 0
                    }
                }
            },
            Air = {
                Enabled = true,
                AirAimPart = {
                    Enabled = false,
                    HitPart = "LowerTorso"
                },
                JumpOffset = {
                    Enabled = false,
                    Offset = 0
                }
            }
        },
        Visuals = {
            Backtrack = {
                Enabled = true,
                Color = Color3.fromRGB(255,255,255),
                Method = "Folllow",
                Transparency = 0.5,
                Material = "Plastic",
            },
            BulletTracers = {
                Enabled = false,
                Color = {
                    Gradient1 = Color3.new(1, 1, 1),
                    Gradient2 = Color3.new(0, 0, 0)
                },
                Duration = 1,
                Fade = {
                    Enabled = false,
                    Duration = 0.5
                }
            },
            BulletImpacts = {
                Enabled = false,
                Color = Color3.new(1, 1, 1),
                Duration = 1,
                Size = 1,
                Material = "SmoothPlastic",
                Fade = {
                    Enabled = false,
                    Duration = 0.5
                }
            },
            OnHit = {
                Enabled = false,
                Effect = {
                    Enabled = false,
                    Color = Color3.new(1, 1, 1)
                },
                Sound = {
                    Enabled = false,
                    Volume = 5,
                    Value = "hentai4.wav"
                },
                Chams = {
                    Enabled = false,
                    Color = Color3.fromRGB(255,209,220),
                    Material = "ForceField",
                    Duration = 1
                }
            },
            World = {
                Enabled = false,
                Fog = {
                    Enabled = false,
                    Color = Color3.fromRGB(255,209,220),
                    End = 1000,
                    Start = 10000
                },
                Ambient = {
                    Enabled = false,
                    Color = Color3.fromRGB(255,209,220)
                },
                Brightness = {
                    Enabled = false,
                    Value = 0
                },
                ClockTime = {
                    Enabled = false,
                    Value = 24
                },
                WorldExposure = {
                    Enabled = false,
                    Value = -0.1
                }
            },
            Crosshair = {
                Enabled = false,
                StickToTarget = false,
                Color = Color3.new(1, 1, 1),
                Size = 10,
                Gap = 2,
                Rotation = {
                    Enabled = false,
                    Speed = 1
                }
            }
        },
        AntiAim = {
            DaCoolBoyDesync = false,
            DaCoolBoyDesync2 = false,
            DaCoolBoyDesync3 = false,
            VelocitySpoofer = {
                Enabled = false,
                Visualize = {
                    Enabled = false,
                    Color = Color3.fromRGB(255,209,220),
                    Prediction = 0.134
                },
                Type = "Underground",
                Roll = 0,
                Pitch = 0,
                Yaw = 0
            },
            CSync = {
                Enabled = false,
                Spoof = false,
                Type = "Target Strafe",
                Visualize = {
                    Enabled = false,
                    Color = Color3.fromRGB(255,209,220)
                },
                RandomDistance = 10,
                Custom = {
                    X = 0,
                    Y = 0,
                    Z = 0
                },
                TargetStrafe = {
                    Speed = 1,
                    Distance = 1,
                    Height = 1
                }
            },
            Network = {
                Enabled = false,
                WalkingCheck = false,
                Amount = 0.05
            },
            VelocityDesync = {
                Enabled = false,
                Range = 1
            },
            FFlagDesync = {
                Enabled = false,
                SetNew = false,
                FFlags = {"S2PhysicsSenderRate"}, 
                SetNewAmount = 1,
                Amount = 1
            },
        },
        Misc = {
            Movement = {
                Macro = {
                    Enabled = false,
                    Speed = 0.1,
                },
                Speed = {
                    Enabled = false,
                    Amount = 1
                },
            },
            Exploits = {
                Enabled = false,
                NoRecoil = false,
                NoJumpCooldown = false,
                NoSlowDown = false
            }
        }
    }

getgenv().Sentinel = {
    Enabled = true,
    HorizontalPrediction = 0.045,
    VerticalPrediction = 0.1,
    jumpoffset2 = -1,
    jumpoffset = 0,
    ResolverEnabled = false,
    SelectedPart = "HumanoidRootPart",
    AutoPrediction = true,
    AutoPredMode = "PingBased", 
    ShootDelay = 0.22,
    NoGroundShot = true,
    AutoAir = true,
    LookAt = true,
    smoothness = 0.900,
    TracerEnabled = true,
    NearestPart = false,
    speedvalue = 1,
    MacroSpeed = 0.1,
    Camera = false,
    easingStyle = "Sine",
    easingDirection = "Out",
    JumpBreak = false,
    network = false
}




local GrenadeTP = false
local RocketTP = false
getgenv().Desync = false
getgenv().AntiLockType = "Behind"
getgenv().Direction = Vector3.new(0, 0, -1)


local player = game.Players.LocalPlayer
local character = player.Character
local hrp = character and character:FindFirstChild("HumanoidRootPart")

if hrp then
    local a0 = Instance.new("Attachment", hrp)
    local a1 = Instance.new("Attachment", hrp)

    a0.Position = Vector3.new(0, -0.5, -1)
    a1.Position = Vector3.new(0, -0.5, 1)

    local trail = Instance.new("Trail", hrp)
    trail.Color = ColorSequence.new(Color3.new(0, 0.717, 0.964), Color3.new(1, 0.717, 0.964))
    trail.Lifetime = 5
    trail.LightEmission = 1
    trail.LightInfluence = 1
    trail.Texture = "rbxassetid://2443461141"
    trail.Transparency = NumberSequence.new(0, 0, 0.352468, 0.48125, 1)
    trail.WidthScale = NumberSequence.new(0, 2, 0.499426, 2, 0)

    trail.Attachment0 = a0
    trail.Attachment1 = a1
end

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextButton = Instance.new("TextButton")
local UITextSizeConstraint = Instance.new("UITextSizeConstraint")

--Properties:

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local Ui22 = Instance.new("ScreenGui")
Ui22.Name = "Ui22"
Ui22.Parent = game.CoreGui
Ui22.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Ui22.ResetOnSpawn = false

local Image3 = Instance.new("ImageButton")
Image3.Name = "Image3"
Image3.Parent = Ui22
Image3.Active = false
Image3.Draggable = true
Image3.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Image3.BackgroundTransparency = 1
Image3.Size = UDim2.new(0, 90, 0, 90)
Image3.Image = "rbxassetid://126818107683779"
Image3.Position = UDim2.new(1, -95, 0, 5)

local Ui2corner = Instance.new("UICorner")
Ui2corner.CornerRadius = UDim.new(0.2, 0)
Ui2corner.Parent = Image3

local Blur = Instance.new("BlurEffect", game:GetService("Lighting"))
Blur.Enabled = false

local butj = Instance.new("ImageLabel")
butj.Size = UDim2.new(0, 200, 0, 200)

local elementWidth = butj.Size.X.Offset
local elementHeight = butj.Size.Y.Offset

butj.Position = UDim2.new(0.5, -elementWidth / 2, 0.5, -elementHeight / 2)
butj.Active = false
butj.BackgroundTransparency = 1
butj.ImageTransparency = 1
butj.Parent = Ui22
butj.Image = "rbxassetid://126818107683779"

local Open = true
Menu:SetVisible(false)

local function ToggleMenu()
    if Open == true then
        Blur.Enabled = true
        butj.ImageTransparency = 0
        Menu:SetVisible(true)
    else
        Blur.Enabled = false
        Menu:SetVisible(false)
        for i = 0, 1, 0.1 do
            butj.ImageTransparency = i
            task.wait(0.05)
        end
    end
end



Image3.MouseButton1Click:Connect(function()
    Open = not Open
    print("khen.cc")
    ToggleMenu()
end)




UITextSizeConstraint.Parent = TextButton
UITextSizeConstraint.MaxTextSize = 30

local player = game.Players.LocalPlayer

-- Function to show the GUI when the character respawns
local function onCharacterAdded(character)
    ScreenGui.Parent = player.PlayerGui
end

-- Function to connect character respawn event
local function connectCharacterAdded()
    player.CharacterAdded:Connect(onCharacterAdded)
end


connectCharacterAdded()


player.CharacterRemoving:Connect(function()
    ScreenGui.Parent = nil
end) 

local hitsounds = {
    ["RIFK7"] = "rbxassetid://9102080552",
    ["Bubble"] = "rbxassetid://9102092728",
    ["Minecraft"] = "rbxassetid://5869422451",
    ["Cod"] = "rbxassetid://160432334",
    ["Bameware"] = "rbxassetid://6565367558",
    ["Neverlose"] = "rbxassetid://6565370984",
    ["Gamesense"] = "rbxassetid://4817809188",
    ["Rust"] = "rbxassetid://6565371338",
    ["BlackPencil"] = "https://github.com/khenn791/script-khen/raw/refs/heads/main/bananapencil.mp3%20(1).mp3"
}



local TargetAimbot = {
    Enabled = true, 
    Keybind = Enum.KeyCode.Q,
    Autoselect = false,
    Prediction = 0.145, 
    RealPrediction = 0.145, 
    Resolver = false, 
    ResolverType = "Recalculate", 
    JumpOffset = 0.06, 
    RealJumpOffset = 0.09, 
    HitParts = {"HumanoidRootPart"}, 
    RealHitPart = "HumanoidRootPart", 
    KoCheck = false, 
    LookAt = false,
    CSync = {
        Enabled = false,
        Type = "Orbit",
        Distance = 10,
        Height = 2,
        Speed = 10,
        RandomAmount = 10,
        Color = Color3.fromRGB(255, 255, 255),
    },
    ViewAt = false,
    Tracer = true,
    Highlight = true,
    HighlightColor1 =Color3.fromRGB(255, 255, 255),
    HighlightColor2 =Color3.fromRGB(255, 255, 255),
    Stats = false, 
    UseFov = false,
    HitEffect = true,
    HitEffectType = "Coom", -- Nova, Crescent Slash, Coom, Cosmic Explosion, Slash, Atomic Slash
    HitEffectColor = Color3.fromRGB(255, 255, 255),
    HitSounds = true,
    HitSound = "Bameware",
    HitChams = true,
    HitChamsMaterial = Enum.Material.Neon,
    HitChamsDuration = 1,
    HitChamsColor = Color3.fromRGB(173, 216, 230)
}

local  Highlight = false

local Players = game:GetService("Players")
local Attachment = Instance.new("Attachment")

-- Spike Aura ------
    local SPIKES = Instance.new("ParticleEmitter")
    SPIKES.Name = "SPIKES"
    SPIKES.Acceleration = Vector3.new(0, 100, 0)
    SPIKES.Color = ColorSequence.new(Color3.new(0, 1, 0), Color3.new(0, 1, 0))
    SPIKES.Drag = 3
    SPIKES.EmissionDirection = Enum.NormalId.Right
    SPIKES.Lifetime = NumberRange.new(0.25, 0.5)
    SPIKES.LightEmission = 1
    SPIKES.Orientation = Enum.ParticleOrientation.VelocityParallel
    SPIKES.Rate = 100
    SPIKES.Rotation = NumberRange.new(-90, -90)
    SPIKES.Size = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 2, 0),
        NumberSequenceKeypoint.new(0.25, 3, 0.25),
        NumberSequenceKeypoint.new(0.653846, 2.0625, 0.164957),
        NumberSequenceKeypoint.new(1, 0, 0)
    })
    SPIKES.Speed = NumberRange.new(10, 25)
    SPIKES.SpreadAngle = Vector2.new(0, 180)
    SPIKES.Squash = NumberSequence.new({
        NumberSequenceKeypoint.new(0, -0.25),
        NumberSequenceKeypoint.new(1, 0.5),
        NumberSequenceKeypoint.new(1, 0.25)
    })
    SPIKES.Texture = "rbxassetid://7451697448"
    SPIKES.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(0.25, 0),
        NumberSequenceKeypoint.new(1, 1)
    })
    SPIKES.Enabled = false
    SPIKES.Parent = Attachment

    local SPECKS = Instance.new("ParticleEmitter")
    SPECKS.Name = "SPECKS"
    SPECKS.Acceleration = Vector3.new(0, -25, 0)
    SPECKS.Brightness = 2
    SPECKS.Color = ColorSequence.new(Color3.new(0, 1, 0), Color3.new(0, 1, 0))
    SPECKS.Drag = 5
    SPECKS.Lifetime = NumberRange.new(0.375, 0.625)
    SPECKS.LightEmission = 1
    SPECKS.Rate = 100
    SPECKS.RotSpeed = NumberRange.new(-45, 45)
    SPECKS.Rotation = NumberRange.new(-360, 360)
    SPECKS.Size = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.25),
        NumberSequenceKeypoint.new(1, 0)
    })
    SPECKS.Speed = NumberRange.new(25, 50)
    SPECKS.SpreadAngle = Vector2.new(45, 45)
    SPECKS.Squash = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(1, 1)
    })
    SPECKS.Texture = "rbxassetid://4509687978"
    SPECKS.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(0.25, 0.2),
        NumberSequenceKeypoint.new(1, 1)
    })
    SPECKS.Enabled = false
    SPECKS.Parent = Attachment

    local GLOW = Instance.new("ParticleEmitter")
    GLOW.Name = "GLOW"
    GLOW.Acceleration = Vector3.new(0, 5, 0)
    GLOW.Color = ColorSequence.new(Color3.new(0, 1, 0), Color3.new(0, 1, 0))
    GLOW.Lifetime = NumberRange.new(0.5, 1)
    GLOW.LightEmission = 1
    GLOW.Rate = 50
    GLOW.Rotation = NumberRange.new(-360, 360)
    GLOW.Size = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 8),
        NumberSequenceKeypoint.new(1, 3)
    })
    GLOW.Speed = NumberRange.new(10, 25)
    GLOW.Texture = "rbxassetid://4509687978"
    GLOW.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(0.5, 0.95),
        NumberSequenceKeypoint.new(1, 1)
    })
    GLOW.ZOffset = -1
    GLOW.Enabled = false
    GLOW.Parent = Attachment



-- Electric --------------
    local ELECTRIC1 = Instance.new('ParticleEmitter')
    ELECTRIC1.Name = "ELECTRIC1"
    ELECTRIC1.Brightness = 5
    ELECTRIC1.Color = ColorSequence.new(Color3.fromRGB(0, 134, 199))
    ELECTRIC1.FlipbookLayout = Enum.ParticleFlipbookLayout.Grid8x8
    ELECTRIC1.FlipbookMode = Enum.ParticleFlipbookMode.OneShot
    ELECTRIC1.Lifetime = NumberRange.new(1)
    ELECTRIC1.LightEmission = 1
    ELECTRIC1.Rate = 5
    ELECTRIC1.Size = NumberSequence.new(2)
    ELECTRIC1.Speed = NumberRange.new(0)
    ELECTRIC1.SpreadAngle = Vector2.new(-360, 360)
    ELECTRIC1.Texture = "http://www.roblox.com/asset/?id=12390063093"
    ELECTRIC1.Transparency = NumberSequence.new(0, 1)
    ELECTRIC1.Enabled = false
    ELECTRIC1.Parent = Attachment

    local ELECTRIC2 = Instance.new('ParticleEmitter')
    ELECTRIC2.Name = "ELECTRIC2"
    ELECTRIC2.Color = ColorSequence.new(Color3.fromRGB(0, 134, 199))
    ELECTRIC2.FlipbookLayout = Enum.ParticleFlipbookLayout.Grid8x8
    ELECTRIC2.FlipbookMode = Enum.ParticleFlipbookMode.OneShot
    ELECTRIC2.Lifetime = NumberRange.new(0.25, 0.5)
    ELECTRIC2.LightEmission = 1
    ELECTRIC2.Rate = 25
    ELECTRIC2.Rotation = NumberRange.new(-360, 360)
    ELECTRIC2.Size = NumberSequence.new(2)
    ELECTRIC2.Speed = NumberRange.new(0)
    ELECTRIC2.SpreadAngle = Vector2.new(-360, 360)
    ELECTRIC2.Texture = "http://www.roblox.com/asset/?id=12390081661"
    ELECTRIC2.Transparency = NumberSequence.new(0, 1)
    ELECTRIC2.Enabled = false
    ELECTRIC2.Parent = Attachment

    local ELECTRIC3 = Instance.new('ParticleEmitter')
    ELECTRIC3.Name = "ELECTRIC3"
    ELECTRIC3.Color = ColorSequence.new(Color3.fromRGB(0, 134, 199))
    ELECTRIC3.FlipbookLayout = Enum.ParticleFlipbookLayout.Grid8x8
    ELECTRIC3.FlipbookMode = Enum.ParticleFlipbookMode.OneShot
    ELECTRIC3.Lifetime = NumberRange.new(0.25, 0.5)
    ELECTRIC3.LightEmission = 1
    ELECTRIC3.Rate = 25
    ELECTRIC3.Rotation = NumberRange.new(-360, 360)
    ELECTRIC3.Size = NumberSequence.new(2)
    ELECTRIC3.Speed = NumberRange.new(0)
    ELECTRIC3.SpreadAngle = Vector2.new(-360, 360)
    ELECTRIC3.Texture = "http://www.roblox.com/asset/?id=12390081661"
    ELECTRIC3.Transparency = NumberSequence.new(0, 1)
    ELECTRIC3.Enabled = false
    ELECTRIC3.Parent = Attachment

    local Wave1 = Instance.new('ParticleEmitter')
    Wave1.Name = "Wave1"
    Wave1.Brightness = 10
    Wave1.Color = ColorSequence.new(Color3.fromRGB(0, 170, 255))
    Wave1.Lifetime = NumberRange.new(1)
    Wave1.LightEmission = 0.4
    Wave1.Orientation = Enum.ParticleOrientation.VelocityPerpendicular
    Wave1.Rate = 10
    Wave1.RotSpeed = NumberRange.new(200, 400)
    Wave1.Rotation = NumberRange.new(-180, 180)
    Wave1.Size = NumberSequence.new(3)
    Wave1.Speed = NumberRange.new(1, 3)
    Wave1.SpreadAngle = Vector2.new(10, -10)
    Wave1.Texture = "rbxassetid://8047533775"
    Wave1.Transparency = NumberSequence.new(0, 1)
    Wave1.Enabled = false
    Wave1.Parent = Attachment

    local ELECTRIC4 = Instance.new('ParticleEmitter')
    ELECTRIC4.Name = "ELECTRIC4"
    ELECTRIC4.Color = ColorSequence.new(Color3.fromRGB(0, 134, 199))
    ELECTRIC4.FlipbookLayout = Enum.ParticleFlipbookLayout.Grid8x8
    ELECTRIC4.FlipbookMode = Enum.ParticleFlipbookMode.OneShot
    ELECTRIC4.Lifetime = NumberRange.new(0.25, 0.5)
    ELECTRIC4.LightEmission = 1
    ELECTRIC4.Rate = 25
    ELECTRIC4.Rotation = NumberRange.new(-360, 360)
    ELECTRIC4.Size = NumberSequence.new(2)
    ELECTRIC4.Speed = NumberRange.new(0)
    ELECTRIC4.SpreadAngle = Vector2.new(-360, 360)
    ELECTRIC4.Texture = "http://www.roblox.com/asset/?id=12390081661"
    ELECTRIC4.Transparency = NumberSequence.new(0, 1)
    ELECTRIC4.Enabled = false
    ELECTRIC4.Parent = Attachment


-- Swirl ------
local swirl = Instance.new("ParticleEmitter")
swirl.Name = "swirl"
swirl.Color = ColorSequence.new(Color3.fromRGB(66, 60, 255), Color3.fromRGB(66, 60, 255)) 
swirl.Lifetime = NumberRange.new(2, 2)
swirl.LightEmission = 1
swirl.Orientation = Enum.ParticleOrientation.VelocityPerpendicular
swirl.Rate = 150
swirl.RotSpeed = NumberRange.new(200, 200)
swirl.Size = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 7),
    NumberSequenceKeypoint.new(1, 7)
})
swirl.Speed = NumberRange.new(0.01, 0.01)
swirl.SpreadAngle = Vector2.new(-360, 360)
swirl.Squash = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 0),
    NumberSequenceKeypoint.new(0.163934, 1),
    NumberSequenceKeypoint.new(1, 0)
})
swirl.Texture = "rbxassetid://10558425570"
swirl.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 0),
    NumberSequenceKeypoint.new(0.500623, 0.5),
    NumberSequenceKeypoint.new(1, 1)
})
swirl.ZOffset = -1
swirl.Enabled = false
swirl.Parent = Attachment



-- aura burst ------ ass
local auraburst2 = Instance.new("ParticleEmitter")
auraburst2.Name = "auraburst2"
auraburst2.Brightness = 25
auraburst2.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 0))
})
auraburst2.EmissionDirection = Enum.NormalId.Top
auraburst2.Enabled = false
auraburst2.FlipbookFramerate = NumberRange.new(289.311, 289.311)
auraburst2.FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4
auraburst2.FlipbookMode = Enum.ParticleFlipbookMode.OneShot
auraburst2.Lifetime = NumberRange.new(0.500, 0.500)
auraburst2.LightEmission = 1
auraburst2.LightInfluence = 0.15
auraburst2.Orientation = Enum.ParticleOrientation.VelocityParallel
auraburst2.Rate = 6.615
auraburst2.Rotation = NumberRange.new(360, 360)
auraburst2.Size = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 8.7832),
    NumberSequenceKeypoint.new(1, 8.7832)
})
auraburst2.Speed = NumberRange.new(0.00973265, 0.00973265)
auraburst2.Squash = NumberSequence.new({
    NumberSequenceKeypoint.new(0, -0.5),
    NumberSequenceKeypoint.new(1, -0.5)
})
auraburst2.Texture = "rbxassetid://17282066926"
auraburst2.ZOffset = -1
auraburst2.Parent = Attachment




local Players = game:GetService("Players")

local HitEffectModule = {
Locals = {
HitEffect = {
Type = {}
}
}
}


HitEffectModule.Locals.HitEffect.Type["Skibidi RedRizz"] = Attachment

local MainColor = Color3.fromRGB(143, 48, 167)

local emitter = Instance.new('ParticleEmitter')
emitter.Name = "emitter"
emitter.LightEmission = 3
emitter.Transparency = NumberSequence.new(0)
emitter.Color = ColorSequence.new(MainColor)
emitter.Size = NumberSequence.new{NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 6, 1.2)}
emitter.Rotation = NumberRange.new(0)
emitter.RotSpeed = NumberRange.new(0)
emitter.Enabled = false
emitter.Rate = 50
emitter.Lifetime = NumberRange.new(0.25)
emitter.Speed = NumberRange.new(0.1)
emitter.Squash = NumberSequence.new(0)
emitter.ZOffset = 1
emitter.Texture = "rbxassetid://2916153928"
emitter.Orientation = Enum.ParticleOrientation.VelocityParallel
emitter.Shape = 'Box'
emitter.ShapeInOut = 'Outward'
emitter.ShapeStyle = 'Volume'
emitter.Parent = Attachment

local skum = Instance.new('ParticleEmitter')
skum.Name = "skum"
skum.LightEmission = 3
skum.Transparency = NumberSequence.new(0)
skum.Color = ColorSequence.new(MainColor)
skum.Size = NumberSequence.new{NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 6, 1.2)}
skum.Rotation = NumberRange.new(0)
skum.RotSpeed = NumberRange.new(0)
skum.Enabled = false
skum.Rate = 50
skum.Lifetime = NumberRange.new(0.25)
skum.Speed = NumberRange.new(0.1)
skum.Squash = NumberSequence.new(0)
skum.ZOffset = 1
skum.Texture = "rbxassetid://1084991215"
skum.Orientation = Enum.ParticleOrientation.VelocityParallel
skum.Shape = 'Box'
skum.ShapeInOut = 'Outward'
skum.ShapeStyle = 'Volume'
skum.Parent = Attachment

local Shards = Instance.new("ParticleEmitter")
Shards.Name = "Shards"
Shards.Lifetime = NumberRange.new(0.19, 0.7)
Shards.SpreadAngle = Vector2.new(-90, 90)
Shards.Color = ColorSequence.new(Color3.fromRGB(108, 184, 255))
Shards.Drag = 10
Shards.VelocitySpread = -90
Shards.Squash = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5705521, 0.4125001), NumberSequenceKeypoint.new(1, -0.9375)})
Shards.Speed = NumberRange.new(97.7530136, 146.9970093)
Shards.Brightness = 4
Shards.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.284774, 1.2389833, 0.1534118), NumberSequenceKeypoint.new(1, 0)})
Shards.Enabled = false
Shards.Acceleration = Vector3.new(0, -56.961341857910156, 0)
Shards.ZOffset = 0.5705321
Shards.Rate = 50
Shards.Texture = "rbxassetid://8030734851"
Shards.Rotation = NumberRange.new(90, 90)
Shards.Orientation = Enum.ParticleOrientation.VelocityParallel
Shards.Parent = Attachment

local ShardsDark = Instance.new("ParticleEmitter")
ShardsDark.Name = "ShardsDark"
ShardsDark.Lifetime = NumberRange.new(0.19, 0.35)
ShardsDark.SpreadAngle = Vector2.new(-90, 90)
ShardsDark.Color = ColorSequence.new(Color3.fromRGB(108, 184, 255))
ShardsDark.Drag = 10
ShardsDark.VelocitySpread = -90
ShardsDark.Squash = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5705521, 0.4125001), NumberSequenceKeypoint.new(1, -0.9375)})
ShardsDark.Speed = NumberRange.new(97.7530136, 146.9970093)
ShardsDark.Brightness = 4
ShardsDark.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.290774, 0.6734411, 0.1534118), NumberSequenceKeypoint.new(1, 0)})
ShardsDark.Enabled = false
ShardsDark.ZOffset = 0.5705321
ShardsDark.Rate = 50
ShardsDark.Texture = "rbxassetid://8030734851"
ShardsDark.Rotation = NumberRange.new(90, 90)
ShardsDark.Orientation = Enum.ParticleOrientation.VelocityParallel
ShardsDark.Parent = Attachment

local large_shard = Instance.new("ParticleEmitter")
large_shard.Name = "large_shard"
large_shard.Lifetime = NumberRange.new(0.19, 0.28)
large_shard.SpreadAngle = Vector2.new(-90, 90)
large_shard.Color = ColorSequence.new(Color3.fromRGB(108, 184, 255))
large_shard.Drag = 10
large_shard.VelocitySpread = -90
large_shard.Squash = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5705521, 0.4125001), NumberSequenceKeypoint.new(1, -0.9375)})
large_shard.Speed = NumberRange.new(97.7530136, 146.9970093)
large_shard.Brightness = 4
large_shard.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.260774, 3.515605, 0.1534118), NumberSequenceKeypoint.new(1, 0)})
large_shard.Enabled = false
large_shard.ZOffset = 0.5705321
large_shard.Rate = 50
large_shard.Texture = "rbxassetid://8030734851"
large_shard.Rotation = NumberRange.new(90, 90)
large_shard.Orientation = Enum.ParticleOrientation.VelocityParallel
large_shard.Parent = Attachment

local Crescents = Instance.new("ParticleEmitter")
Crescents.Name = "Crescents"
Crescents.Lifetime = NumberRange.new(0.19, 0.38)
Crescents.SpreadAngle = Vector2.new(-360, 360)
Crescents.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.1932907, 0), NumberSequenceKeypoint.new(0.778754, 0), NumberSequenceKeypoint.new(1, 1)})
Crescents.LightEmission = 1
Crescents.Color = ColorSequence.new(Color3.fromRGB(92, 161, 252))
Crescents.VelocitySpread = -360
Crescents.Speed = NumberRange.new(0.0826858, 0.0826858)
Crescents.Brightness = 20
Crescents.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.398774, 8.8026266, 2.2834616), NumberSequenceKeypoint.new(1, 11.477972, 1.860431)})
Crescents.Enabled = false
Crescents.ZOffset = 0.4542207
Crescents.Rate = 50
Crescents.Texture = "rbxassetid://12509373457"
Crescents.RotSpeed = NumberRange.new(800, 1000)
Crescents.Rotation = NumberRange.new(-360, 360)
Crescents.Orientation = Enum.ParticleOrientation.VelocityPerpendicular
Crescents.Parent = Attachment




Menu:SetSize(500, 400)
Menu.Notify("Script Loaded.", 2)

local CombatTab = Menu.Tab("Main")



local TargetAimSection = Menu.Container("Main", "Target Aim", "Left") do

Menu.CheckBox("Main", "Target Aim", "Enabled", getgenv().Sentinel.Enabled, function(a)
        getgenv().Sentinel.Enabled = a
end)


    Menu.CheckBox("Main", "Target Aim", "Look At", getgenv().Sentinel.LookAt, function(a)
        getgenv().Sentinel.LookAt = a 
    end)
    Menu.CheckBox("Main", "Target Aim", "Highlight", getgenv().Sentinel.Highlight, function(a)
        Highlight = a
    end)
    Menu.CheckBox("Main", "Target Aim", "Auto Air", getgenv().Sentinel.AutoAir, function(a)
        getgenv().Sentinel.AutoAir = a
    end)
    Menu.CheckBox("Main", "Target Aim", "Resolver", getgenv().Sentinel.ResolverEnabled, function(a)
        getgenv().Sentinel.ResolverEnabled = a
    end)
end       

local HvHTab = Menu.Tab("HvH")
local TeleportSection = Menu.Container("HvH", "Teleports", "Left") do

Menu.CheckBox("HvH", "Teleports", "Grenade Tp", GrenadeTP, function(a)
        Script.Locals.GrenadeTP.Enabled = a
end)
    Menu.CheckBox("HvH", "Teleports", "Rocket Tp", RocketTP, function(a)
        Script.Locals.RocketTP.Enabled = a
end)
end



    local BulletTaP = Menu.Container("HvH", "Bullet-TP", "Left") do
Menu.CheckBox("HvH", "Bullet-TP", "Bullet Gyatt", RocketTP, function(a) 
Script.Locals.GunTP.Enabled = a
end)

Menu.CheckBox("HvH", "Bullet-TP", "Anchor", RocketTP, function(a) 
Script.Locals.GunTP.Anchor = a
end)


    Menu.TextBox("HvH", "Bullet-TP", "X", "0", function(a) Script.Locals.GunTP.Offset[1] = a end)

    Menu.TextBox("HvH", "Bullet-TP", "Y", "-0.5", function(a) Script.Locals.GunTP.Offset[2] = a end)

    Menu.TextBox("HvH", "Bullet-TP", "Z", "0", function(a) Script.Locals.GunTP.Offset[3] = a end)

    end


    local HitPartSection = Menu.Container("Main", "HitPart", "Left") do
        Menu.CheckBox("Main", "HitPart", "NearestPart", getgenv().Sentinel.NearestPart, function(a) 
getgenv().Sentinel.NearestPart = a
end)
Menu.ComboBox("Main", "HitPart", "BodyPart", "Body Part", {
    "Head", "UpperTorso", "LowerTorso", "HumanoidRootPart", 
    "LeftUpperArm", "LeftLowerArm", "LeftHand", 
    "RightUpperArm", "RightLowerArm", "RightHand", 
    "LeftUpperLeg", "LeftLowerLeg", "LeftFoot", 
    "RightUpperLeg", "RightLowerLeg", "RightFoot"
}, function(a)
    getgenv().Sentinel.SelectedPart = a
end)       
    end

    local Hitnotify = false
local PredictionSection = Menu.Container("Main", "Prediction", "Left") do
        Menu.CheckBox("Main", "Prediction", "Auto Prediction", true, function(a)
            getgenv().Sentinel.AutoPrediction = a
        end)
 Menu.ComboBox("Main","Prediction","LockType", getgenv().Sentinel.LockType, {"Namecall","Index"},
function(a)
 getgenv().Sentinel.LockType = a
end)
        Menu.TextBox("Main", "Prediction", "Horizontal", tostring(getgenv().Sentinel.HorizontalPrediction), function(a)
            getgenv().Sentinel.HorizontalPrediction2 = tonumber(a)
        end)

    end

local CameraContainer = Menu.Container("Main", "Camera", "Right") do
Menu.CheckBox("Main", "Camera", "Enabled", getgenv().Sentinel.Camera, function(a)
        getgenv().Sentinel.Camera = a
    end)
Menu.TextBox("Main", "Camera", "Smoothness", tostring(getgenv().Sentinel.smoothness), function(a)
            getgenv().Sentinel.smoothness= tonumber(a)
        end)
Menu.ComboBox("Main", "Camera", "Easing Style", getgenv().Sentinel.easingStyle, {
    "Linear",
    "Quad",
    "Cubic",
    "Quart",
    "Quint",
    "Sine",
    "Exponential",
    "Circular",
    "Back",
    "Bounce",
    "Elastic"
}, function(Cock)
    getgenv().Sentinel.easingStyle = Cock
end)
Menu.ComboBox("Main", "Camera", "Easing Direction", getgenv().Sentinel.easingDirection, {
    "In",
    "Out",
    "InOut"
}, function(Cock)
    getgenv().Sentinel.easingDirection = Cock
end)
end

local Visuals = Menu.Tab("Visuals")
 local HitDetectionSection = Menu.Container("Visuals", "Hit Detection", "Left") do
    Menu.CheckBox("Visuals", "Hit Detection", "Hit Effect", TargetAimbot.HitEffect, function(a) 
        TargetAimbot.HitEffect = a
    end)
    Menu.CheckBox("Visuals", "Hit Detection", "Hit Sound", TargetAimbot.HitSounds, function(a)
        TargetAimbot.HitSounds = a
    end)
    Menu.CheckBox("Visuals", "Hit Detection", "Notify", false, function(a) 
        Hitnotify = a
    end)
    Menu.ComboBox("Visuals", "Hit Detection", "Effect Type", TargetAimbot.HitEffectType, {"Atomic Slash", "Crescent Slash", "Coom", "Nova", "Cosmic Explosion", "Circle Shot", "Bolt","Aura","Electric","Shock","Thunder"}, function(a)
        TargetAimbot.HitEffectType = a
    end)
    Menu.ComboBox("Visuals", "Hit Detection", "Sound Type", TargetAimbot.HitSound, {"RIFK7", "Bubble", "Minecraft", "Cod", "Bameware", "Neverlose", "Gamesense", "Rust", "BlackPencil"}, function(a)
        TargetAimbot.HitSound = a
    end)
    Menu.ColorPicker("Visuals", "Hit Detection", "Highlight fill", Color3.fromRGB(144, 238, 144), 0, function(a)
        TargetAimbot.HighlightColor1 = a
    end)
    Menu.ColorPicker("Visuals", "Hit Detection", "Highlight Outline", Color3.fromRGB(144, 238, 144), 0, function(a)
        TargetAimbot.HighlightColor2 = a
    end)
    Menu.ColorPicker("Visuals", "Hit Detection", "Hit Effect Color", Color3.fromRGB(144, 238, 144), 0, function(a)
        TargetAimbot.HitEffectColor = a
    end)
    Menu.ColorPicker("Visuals", "Hit Detection", "Visualizer", Color3.fromRGB(144, 238, 144), 0, function(a)
        TargetAimbot.CSync.Color = a
    end)
end
   
    local CSyncSection = Menu.Container("HvH", "CSync", "Right") do
        Menu.CheckBox("HvH", "CSync", "Enabled", TargetAimbot.CSync.Enabled, function(a)
            TargetAimbot.CSync.Enabled = a
        end)
        Menu.ComboBox("HvH", "CSync", "Type", TargetAimbot.CSync.Type, {"Orbit", "Random"}, function(a)
            TargetAimbot.CSync.Type = a
        end)
        Menu.Slider("HvH", "CSync", "Distance", 0, 20, TargetAimbot.CSync.Distance, '', 1, function(a)
            TargetAimbot.CSync.Distance = a
        end)
        Menu.Slider("HvH", "CSync", "Height", 0, 10, TargetAimbot.CSync.Height, '', 1, function(a)
            TargetAimbot.CSync.Height = a
        end)
        Menu.Slider("HvH", "CSync", "Speed", 0, 20, TargetAimbot.CSync.Speed, '', 1, function(a)
            TargetAimbot.CSync.Speed = a
        end)
        Menu.Slider("HvH", "CSync", "Random Amount", 0, 20, TargetAimbot.CSync.RandomAmount, '', 1, function(a)
            TargetAimbot.CSync.RandomAmount = a
        end)
    end
local MiscTab = Menu.Tab("Misc") do
  
 local MTSection1 = Menu.Container("Misc", "Prediction Breaker", "Left") 

Menu.CheckBox("Misc", "Prediction Breaker", "Jump Prediction", getgenv().Sentinel.JumpBreak, function(a)
    getgenv().Sentinel.JumpBreak = a
end)

Menu.CheckBox("Misc", "Prediction Breaker", "Enable Anti Lock", getgenv().Desync, function(a)
    getgenv().Desync = a
end)

Menu.ComboBox("Misc", "Prediction Breaker", "Anti Lock Type", getgenv().AntiLockType, {
    "Behind",
    "Down",
    "ForWard",
    "Left",
    "One",
    "Right",
    "Up",
    "Zero"
}, function(a)
    getgenv().AntiLockType = a
end)

            local MTSection2 = Menu.Container("Misc", "CFrame Speed", "Right") do
                Menu.CheckBox("Misc", "CFrame Speed", "Enabled", false, function(a)
                    getgenv().Sentinel.cframespeedtoggle = a
                end)
                Menu.Slider("Misc", "CFrame Speed", "Speed", 0, 10, 3, '%', 1, function(a)
                getgenv().Sentinel.speedvalue = a
                end)
            end
            
            
            local MTSectionS = Menu.Container("Misc", "Macro", "Right") do
            Menu.Button("Misc", "Macro", "Load Macro", function()
    if MacroAlreadLoaded then
        print("hi")
        return
    end
    MacroAlreadLoaded = true
    
    local MobileCameraFramework = {}
    local players = game:GetService("Players")
    local runservice = game:GetService("RunService")
    local player = players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local root = character:WaitForChild("HumanoidRootPart")
    local humanoid = character.Humanoid
    local camera = workspace.CurrentCamera
    local MAX_LENGTH = 900000
    local active = false
    local ENABLED_OFFSET = CFrame.new(0, 0, 0)
    local DISABLED_OFFSET = CFrame.new(0, 0, 0)
    local rootPos = Vector3.new(0, 0, 0)

    -- GUI Setup
    local ScreenGui = Instance.new("ScreenGui")
    local Frame = Instance.new("Frame")
    local TextButton = Instance.new("ImageLabel")
    local TextLabel = Instance.new("TextButton")
    local UITextSizeConstraint = Instance.new("UITextSizeConstraint")

    ScreenGui.Parent = player.PlayerGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    Frame.Parent = ScreenGui
    Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Frame.BackgroundTransparency = 0.5
    Frame.Position = UDim2.new(1, -128, 0, 0)
    Frame.Size = UDim2.new(0, 90, 0, 32)

    TextButton.Parent = Frame
    TextButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    TextButton.BackgroundTransparency = 1
    TextButton.Size = UDim2.new(0, 26, 0, 26)
    TextButton.AnchorPoint = Vector2.new(0, 0.5)
    TextButton.Position = UDim2.new(0.05, 0, 0.5, 0)
    TextButton.Image = "rbxassetid://10734923214"

    TextLabel.Parent = Frame
    TextLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    TextLabel.BackgroundTransparency = 1
    TextLabel.Size = UDim2.new(0, 52, 0, 26)
    TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    TextLabel.Position = UDim2.new(0.65, 0, 0.5, 0)
    TextLabel.Font = Enum.Font.Arimo
    TextLabel.Text = "Macro"
    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.TextScaled = true
    TextLabel.TextSize = 35
    TextLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    TextLabel.TextStrokeTransparency = 1

    local uiCorner = Instance.new("UICorner", Frame)
    uiCorner.CornerRadius = UDim.new(0, 8)

    local MCenabled = false
    TextLabel.MouseButton1Down:Connect(function()
        MCenabled = not MCenabled
        print(MCenabled)
        if MCenabled then
            TextButton.Image = "rbxassetid://10735024209"
        else
            TextButton.Image = "rbxassetid://10734923214"
            DisableShiftlock()
        end
    end)

    UITextSizeConstraint.Parent = TextLabel
    UITextSizeConstraint.MaxTextSize = 30

    player.CharacterAdded:Connect(function(character)
        ScreenGui.Parent = player.PlayerGui
    end)

    player.CharacterRemoving:Connect(function()
        ScreenGui.Parent = nil
    end)

    local function UpdatePos()
        if player.Character and player.Character:FindFirstChildOfClass("Humanoid") and player.Character:FindFirstChildOfClass("Humanoid").RootPart then
            rootPos = player.Character:FindFirstChildOfClass("Humanoid").RootPart.Position
        end
    end

    local function UpdateAutoRotate(BOOL)
        if player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
            player.Character:FindFirstChildOfClass("Humanoid").AutoRotate = BOOL
        end
    end

    local function GetUpdatedCameraCFrame()
        if game:GetService("Workspace").CurrentCamera then
            return CFrame.new(rootPos, Vector3.new(game:GetService("Workspace").CurrentCamera.CFrame.LookVector.X * MAX_LENGTH, rootPos.Y, game:GetService("Workspace").CurrentCamera.CFrame.LookVector.Z * MAX_LENGTH))
        end
    end

    local function EnableShiftlock()
        UpdatePos()
        UpdateAutoRotate(false)
        if player.Character and player.Character:FindFirstChildOfClass("Humanoid") and player.Character:FindFirstChildOfClass("Humanoid").RootPart then
            player.Character:FindFirstChildOfClass("Humanoid").RootPart.CFrame = GetUpdatedCameraCFrame()
        end
        if game:GetService("Workspace").CurrentCamera then
            game:GetService("Workspace").CurrentCamera.CFrame = camera.CFrame * ENABLED_OFFSET
        end
    end

    local function DisableShiftlock()
        UpdatePos()
        UpdateAutoRotate(true)
        if game:GetService("Workspace").CurrentCamera then
            game:GetService("Workspace").CurrentCamera.CFrame = camera.CFrame * DISABLED_OFFSET
        end
        pcall(function()
            active:Disconnect()
            active = nil
        end)
    end

    local dragging = false
    local dragInput
    local dragStart
    local startPos

    local function update(input)
        local delta = input.Position - dragStart
        Frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    Frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = Frame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    Frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if dragging and input == dragInput then
            update(input)
        end
    end)

    function ShiftLock()
        if MCenabled then
            if not active then
                active = runservice.RenderStepped:Connect(function()
                    EnableShiftlock()
                end)
            else
                DisableShiftlock()
            end
        end
    end

    while task.wait(getgenv().Sentinel.MacroSpeed) do
        ShiftLock()
    end
end, "Click to toggle the macro")
Menu.TextBox("Misc", "Macro", "Speed", tostring(getgenv().Sentinel.MacroSpeed), function(a)
            getgenv().Sentinel.MacroSpeed = tonumber(a)
        end)
    end

local aurasec2 = Menu.Container("Misc", "Aura", "Right") do
Menu.CheckBox("Misc", "Aura", "Enabled", false, function(y)
     if y then
       spawn()
     else 
       disconnect()
     end
local player = game.Players.LocalPlayer

player.CharacterAdded:Connect(function(character)
    if y then
        spawn()
    end
end)
end)
end


            
            local MTSection3 = Menu.Container("Misc", "Fly", "Right") do
                Menu.CheckBox("Misc", "Fly", "Enabled", false, function(a)
                    
                end)
                Menu.Hotkey("Misc", "Fly", "Keybind", Enum.KeyCode.X, function(a)
                    
                end)
                Menu.CheckBox("Misc", "Fly", "Notification", false, function(a)
                    
                end)
                Menu.Slider("Misc", "Fly", "Speed", 0, 30, 5, '%', 1, function(a)
                    
                end)
            end
  
local MTSection4 = Menu.Container("Misc", "Network Anti", "Left") do
                Menu.CheckBox("Misc", "Network Anti", "Enabled", getgenv().Sentinel.network, function(a)
                    getgenv().Sentinel.network = a
                end)
end    
            local MTSection4 = Menu.Container("Misc", "Trash Talk", "Left") do
                Menu.CheckBox("Misc", "Trash Talk", "Enabled", false, function(a)
                    
                end)
                Menu.CheckBox("Misc", "Trash Talk", "Target", false, function(a)
                    
                end)
                Menu.CheckBox("Misc", "Trash Talk", "Notification", false, function(a)
                    
                end)
                Menu.CheckBox("Misc", "Trash Talk", "Use Keybind", false, function(a)
                    
                end)
                Menu.Hotkey("Misc", "Trash Talk", "Keybind", Enum.KeyCode.B, function(a)
                    
                end)
            end

  local HitChamsSection = Menu.Container("Visuals", "Hit Chams", "Right") do
        Menu.CheckBox("Visuals", "Hit Chams", "Enabled", TargetAimbot.HitChams, function(a)
            TargetAimbot.HitChams = a
        end)
        Menu.ColorPicker("Visuals", "Hit Chams", "Color", TargetAimbot.HitChamsColor, 0, function(a)
            TargetAimbot.HitChamsColor = a
        end)
        Menu.Slider("Visuals", "Hit Chams", "Duration", 0, 5, TargetAimbot.HitChamsDuration, '', 1, function(a)
            TargetAimbot.HitChamsDuration = a
        end)
        Menu.ComboBox("Visuals", "Hit Chams", "Material", TargetAimbot.HitChamsMaterial.Name, {Enum.Material.Neon.Name, Enum.Material.SmoothPlastic.Name}, function(a)
            TargetAimbot.HitChamsMaterial = Enum.Material[a]
        end)
    end
end

Menu:SetTitle("Nigger.Lua")
Menu:SetVisible(true)
Menu:Init()







Script.Functions.Connection = function(ConnectionType: any, Function: any)
                local Connection = ConnectionType:Connect(Function)
                return Connection
end




Script.Functions.VisualizeMovement = function()
                if Settings.Combat.Skibidi then
                  local Character = game.Players.LocalPlayer and (game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait())
                  local RootPart = Character and Character.HumanoidRootPart
                  local Ball = Instance.new('Part') do
                      Ball.Anchored = true
                      Ball.Size = Vector3.new(0.5, 0.5, 0.5)
                      Ball.Transparency = -0.5
                      Ball.Shape = Enum.PartType.Ball
                      Ball.Color = Color3.fromRGB(98,0,67)
                      Ball.Material = Enum.Material.ForceField
                      Ball.Parent = Workspace
                      Ball.CFrame = RootPart.CFrame
                      Ball.CanCollide = false
                      local highlight = Instance.new("Highlight")
                      highlight.Adornee = Ball
                      highlight.FillColor = Color3.fromRGB(98,0,67)
                      highlight.OutlineColor = Color3.fromRGB(255,255,255)
                      highlight.Parent = Ball
                  end;
                  Debris:AddItem(Ball, 2)
          end
   end

local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Stats = game:GetService("Stats")
local CoreGui = game:GetService("CoreGui")
local StarterGui = game:GetService("StarterGui")
local SoundService = game:GetService("SoundService")
local Stas = game:GetService("Stats")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local TargBindEnabled = true
local TargetPlr
local TargResolvePos

local hitsounds = {
    ["RIFK7"] = "rbxassetid://9102080552",
    ["Bubble"] = "rbxassetid://9102092728",
    ["Minecraft"] = "rbxassetid://5869422451",
    ["Cod"] = "rbxassetid://160432334",
    ["Bameware"] = "rbxassetid://6565367558",
    ["Neverlose"] = "rbxassetid://6565370984",
    ["Gamesense"] = "rbxassetid://4817809188",
    ["Rust"] = "rbxassetid://6565371338",
    ["BlackPencil"] = "https://github.com/khenn791/script-khen/raw/refs/heads/main/bananapencil.mp3%20(1).mp3"
}



local TargHighlight = Instance.new("Highlight")
TargHighlight.Parent = CoreGui
TargHighlight.FillColor = TargetAimbot.HighlightColor1
TargHighlight.OutlineColor = TargetAimbot.HighlightColor2
TargHighlight.FillTransparency = 0.5
TargHighlight.OutlineTransparency = 0
TargHighlight.Enabled = false

local Tracer = Drawing.new("Line")
Tracer.Visible = false
Tracer.Color = Color3.fromRGB(154, 7, 250)
Tracer.Thickness = 1
Tracer.Transparency = 1

local HitEffectModule = {
    Locals = {
        Type = {
            ["Nova"] = nil,
            ["Crescent Slash"] = nil,
            ["Coom"] = nil,
            ["Cosmic Explosion"] = nil,
            ["Slash"] = nil,
            ["Atomic Slash"] = nil,
        },
    },
    Functions = {},
    Settings = {HitEffect = {Color = TargetAimbot.HitEffectColor}}
}

local HitChamsFolder = Instance.new("Folder")
HitChamsFolder.Name = "HitChamsFolder"
HitChamsFolder.Parent = Workspace

--// Crescent Slash


game:GetService("RunService").Heartbeat:Connect(function()
    if getgenv().Sentinel.cframespeedtoggle  then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame +
            game.Players.LocalPlayer.Character.Humanoid.MoveDirection * getgenv().Sentinel.speedvalue / 0.5
    end


end)

do
local Insane = Instance.new("Part")
Insane.Parent = ReplicatedStorage

local Attachment = Instance.new("Attachment")
Attachment.Name = "Attachment"
Attachment.Parent = Insane

HitEffectModule.Locals.Type["Crescent Slash"] = Attachment

local Glow = Instance.new("ParticleEmitter")
Glow.Name = "Glow"
Glow.Lifetime = NumberRange.new(0.16, 0.16)
Glow.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.1421725, 0.6182796), NumberSequenceKeypoint.new(1, 1)})
Glow.Color = ColorSequence.new(Color3.fromRGB(91, 177, 252))
Glow.Speed = NumberRange.new(0, 0)
Glow.Brightness = 5
Glow.Size = NumberSequence.new(9.1873131, 16.5032349)
Glow.Enabled = false
Glow.ZOffset = -0.0565939
Glow.Rate = 50
Glow.Texture = "rbxassetid://8708637750"

local Gradient1 = Instance.new("ParticleEmitter")
Gradient1.Name = "Gradient1"
Gradient1.Lifetime = NumberRange.new(0.3, 0.3)
Gradient1.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.15, 0.3), NumberSequenceKeypoint.new(1, 1)})
Gradient1.Color = ColorSequence.new(Color3.fromRGB(115, 201, 255))
Gradient1.Speed = NumberRange.new(0, 0)
Gradient1.Brightness = 6
Gradient1.Size = NumberSequence.new(0, 11.6261358)
Gradient1.Enabled = false
Gradient1.ZOffset = 0.9187313
Gradient1.Rate = 50
Gradient1.Texture = "rbxassetid://8196169974"
Gradient1.Parent = Attachment

local Shards = Instance.new("ParticleEmitter")
Shards.Name = "Shards"
Shards.Lifetime = NumberRange.new(0.19, 0.7)
Shards.SpreadAngle = Vector2.new(-90, 90)
Shards.Color = ColorSequence.new(Color3.fromRGB(108, 184, 255))
Shards.Drag = 10
Shards.VelocitySpread = -90
Shards.Squash = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5705521, 0.4125001), NumberSequenceKeypoint.new(1, -0.9375)})
Shards.Speed = NumberRange.new(97.7530136, 146.9970093)
Shards.Brightness = 4
Shards.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.284774, 1.2389833, 0.1534118), NumberSequenceKeypoint.new(1, 0)})
Shards.Enabled = false
Shards.Acceleration = Vector3.new(0, -56.961341857910156, 0)
Shards.ZOffset = 0.5705321
Shards.Rate = 50
Shards.Texture = "rbxassetid://8030734851"
Shards.Rotation = NumberRange.new(90, 90)
Shards.Orientation = Enum.ParticleOrientation.VelocityParallel
Shards.Parent = Attachment

local ShardsDark = Instance.new("ParticleEmitter")
ShardsDark.Name = "ShardsDark"
ShardsDark.Lifetime = NumberRange.new(0.19, 0.35)
ShardsDark.SpreadAngle = Vector2.new(-90, 90)
ShardsDark.Color = ColorSequence.new(Color3.fromRGB(108, 184, 255))
ShardsDark.Drag = 10
ShardsDark.VelocitySpread = -90
ShardsDark.Squash = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5705521, 0.4125001), NumberSequenceKeypoint.new(1, -0.9375)})
ShardsDark.Speed = NumberRange.new(97.7530136, 146.9970093)
ShardsDark.Brightness = 4
ShardsDark.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.290774, 0.6734411, 0.1534118), NumberSequenceKeypoint.new(1, 0)})
ShardsDark.Enabled = false
ShardsDark.ZOffset = 0.5705321
ShardsDark.Rate = 50
ShardsDark.Texture = "rbxassetid://8030734851"
ShardsDark.Rotation = NumberRange.new(90, 90)
ShardsDark.Orientation = Enum.ParticleOrientation.VelocityParallel
ShardsDark.Parent = Attachment

local Specs = Instance.new("ParticleEmitter")
Specs.Name = "Specs"
Specs.Lifetime = NumberRange.new(0.33, 1.4)
Specs.SpreadAngle = Vector2.new(360, -1000)
Specs.Color = ColorSequence.new(Color3.fromRGB(98, 174, 255))
Specs.Drag = 10
Specs.VelocitySpread = 360
Specs.Speed = NumberRange.new(36.7492523, 146.9970093)
Specs.Brightness = 7
Specs.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.200774, 2.0311937, 0.4363973), NumberSequenceKeypoint.new(1, 0)})
Specs.Enabled = false
Specs.Acceleration = Vector3.new(0, 36.74925231933594, 0)
Specs.Rate = 50
Specs.Texture = "rbxassetid://8030760338"
Specs.EmissionDirection = Enum.NormalId.Right
Specs.Parent = Attachment

local Specs1 = Instance.new("ParticleEmitter")
Specs1.Name = "Specs"
Specs1.Lifetime = NumberRange.new(0.33, 1.75)
Specs1.SpreadAngle = Vector2.new(90, -90)
Specs1.Color = ColorSequence.new(Color3.fromRGB(106, 171, 255))
Specs1.Drag = 9
Specs1.VelocitySpread = 90
Specs1.Speed = NumberRange.new(42.2616425, 73.4985046)
Specs1.Brightness = 6
Specs1.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.210774, 0.3978962, 0.1855686), NumberSequenceKeypoint.new(1, 0)})
Specs1.Enabled = false
Specs1.Acceleration = Vector3.new(0, -20.21208953857422, 0)
Specs1.ZOffset = 0.5144895
Specs1.Rate = 50
Specs1.Texture = "rbxassetid://8030760338"
Specs1.Parent = Attachment

local Specs2 = Instance.new("ParticleEmitter")
Specs2.Name = "Specs"
Specs2.Lifetime = NumberRange.new(0.19, 1.2)
Specs2.SpreadAngle = Vector2.new(360, -1000)
Specs2.Color = ColorSequence.new(Color3.fromRGB(98, 174, 255))
Specs2.Drag = 10
Specs2.VelocitySpread = 360
Specs2.Speed = NumberRange.new(36.7492523, 146.9970093)
Specs2.Brightness = 7
Specs2.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.200774, 2.0311937, 0.4363973), NumberSequenceKeypoint.new(1, 0)})
Specs2.Enabled = false
Specs2.Acceleration = Vector3.new(0, 36.74925231933594, 0)
Specs2.Rate = 50
Specs2.Texture = "rbxassetid://8030760338"
Specs2.EmissionDirection = Enum.NormalId.Right
Specs2.Parent = Attachment

local Specs21 = Instance.new("ParticleEmitter")
Specs21.Name = "Specs2"
Specs21.Lifetime = NumberRange.new(0.19, 1.35)
Specs21.SpreadAngle = Vector2.new(90, -90)
Specs21.Color = ColorSequence.new(Color3.fromRGB(106, 171, 255))
Specs21.Drag = 12
Specs21.VelocitySpread = 90
Specs21.Speed = NumberRange.new(42.2616425, 73.4985046)
Specs21.Brightness = 6
Specs21.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.216774, 0.5721694, 0.1855686), NumberSequenceKeypoint.new(1, 0)})
Specs21.Enabled = false
Specs21.Acceleration = Vector3.new(0, -20.21208953857422, 0)
Specs21.ZOffset = 0.5144895
Specs21.Rate = 50
Specs21.Texture = "rbxassetid://8030760338"
Specs21.Parent = Attachment

local ddddddddddddddddddd = Instance.new("ParticleEmitter")
ddddddddddddddddddd.Name = "ddddddddddddddddddd"
ddddddddddddddddddd.Lifetime = NumberRange.new(0.19, 0.37)
ddddddddddddddddddd.SpreadAngle = Vector2.new(90, -90)
ddddddddddddddddddd.LockedToPart = true
ddddddddddddddddddd.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.6429392, 0), NumberSequenceKeypoint.new(1, 0)})
ddddddddddddddddddd.LightEmission = 1
ddddddddddddddddddd.Color = ColorSequence.new(Color3.fromRGB(90, 184, 255), Color3.fromRGB(165, 251, 255))
ddddddddddddddddddd.Drag = 6
ddddddddddddddddddd.TimeScale = 0.7
ddddddddddddddddddd.VelocitySpread = 90
ddddddddddddddddddd.Speed = NumberRange.new(81.5833435, 110.2477646)
ddddddddddddddddddd.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.410774, 0.6711507, 0.3356177), NumberSequenceKeypoint.new(1, 0)})
ddddddddddddddddddd.Enabled = false
ddddddddddddddddddd.Acceleration = Vector3.new(0, -81.58334350585938, 0)
ddddddddddddddddddd.ZOffset = 0.8345273
ddddddddddddddddddd.Rate = 50
ddddddddddddddddddd.Texture = "rbxassetid://1053546634"
ddddddddddddddddddd.RotSpeed = NumberRange.new(-444, 166)
ddddddddddddddddddd.Rotation = NumberRange.new(-360, 360)
ddddddddddddddddddd.Parent = Attachment

local large_shard = Instance.new("ParticleEmitter")
large_shard.Name = "large_shard"
large_shard.Lifetime = NumberRange.new(0.19, 0.28)
large_shard.SpreadAngle = Vector2.new(-90, 90)
large_shard.Color = ColorSequence.new(Color3.fromRGB(108, 184, 255))
large_shard.Drag = 10
large_shard.VelocitySpread = -90
large_shard.Squash = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5705521, 0.4125001), NumberSequenceKeypoint.new(1, -0.9375)})
large_shard.Speed = NumberRange.new(97.7530136, 146.9970093)
large_shard.Brightness = 4
large_shard.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.260774, 3.515605, 0.1534118), NumberSequenceKeypoint.new(1, 0)})
large_shard.Enabled = false
large_shard.ZOffset = 0.5705321
large_shard.Rate = 50
large_shard.Texture = "rbxassetid://8030734851"
large_shard.Rotation = NumberRange.new(90, 90)
large_shard.Orientation = Enum.ParticleOrientation.VelocityParallel
large_shard.Parent = Attachment

local out_Specs = Instance.new("ParticleEmitter")
out_Specs.Name = "out_Specs"
out_Specs.Lifetime = NumberRange.new(0.19, 1)
out_Specs.SpreadAngle = Vector2.new(44, -1000)
out_Specs.Color = ColorSequence.new(Color3.fromRGB(98, 174, 255))
out_Specs.Drag = 10
out_Specs.VelocitySpread = 44
out_Specs.Speed = NumberRange.new(36.7492523, 146.9970093)
out_Specs.Brightness = 7
out_Specs.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.244774, 0.5469525, 0.1433053), NumberSequenceKeypoint.new(1, 0)})
out_Specs.Enabled = false
out_Specs.Acceleration = Vector3.new(0, -3.215559720993042, 0)
out_Specs.Rate = 50
out_Specs.Texture = "rbxassetid://8030760338"
out_Specs.EmissionDirection = Enum.NormalId.Right
out_Specs.Parent = Attachment

local Effect = Instance.new("ParticleEmitter")
Effect.Name = "Effect"
Effect.Lifetime = NumberRange.new(0.4, 0.7)
Effect.FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4
Effect.SpreadAngle = Vector2.new(360, -360)
Effect.LockedToPart = true
Effect.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.1070999, 0.19375), NumberSequenceKeypoint.new(0.7761194, 0.88125), NumberSequenceKeypoint.new(1, 1)})
Effect.LightEmission = 1
Effect.Color = ColorSequence.new(Color3.fromRGB(92, 161, 252))
Effect.Drag = 1
Effect.VelocitySpread = 360
Effect.Speed = NumberRange.new(0.0036749, 0.0036749)
Effect.Brightness = 2.0999999
Effect.Size = NumberSequence.new(6.9680691, 9.9213123)
Effect.Enabled = false
Effect.ZOffset = 0.4777403
Effect.Rate = 50
Effect.Texture = "rbxassetid://9484012464"
Effect.RotSpeed = NumberRange.new(-150, -150)
Effect.FlipbookMode = Enum.ParticleFlipbookMode.OneShot
Effect.Rotation = NumberRange.new(50, 50)
Effect.Orientation = Enum.ParticleOrientation.VelocityPerpendicular
Effect.Parent = Attachment

local Crescents = Instance.new("ParticleEmitter")
Crescents.Name = "Crescents"
Crescents.Lifetime = NumberRange.new(0.19, 0.38)
Crescents.SpreadAngle = Vector2.new(-360, 360)
Crescents.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.1932907, 0), NumberSequenceKeypoint.new(0.778754, 0), NumberSequenceKeypoint.new(1, 1)})
Crescents.LightEmission = 1
Crescents.Color = ColorSequence.new(Color3.fromRGB(92, 161, 252))
Crescents.VelocitySpread = -360
Crescents.Speed = NumberRange.new(0.0826858, 0.0826858)
Crescents.Brightness = 20
Crescents.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.398774, 8.8026266, 2.2834616), NumberSequenceKeypoint.new(1, 11.477972, 1.860431)})
Crescents.Enabled = false
Crescents.ZOffset = 0.4542207
Crescents.Rate = 50
Crescents.Texture = "rbxassetid://12509373457"
Crescents.RotSpeed = NumberRange.new(800, 1000)
Crescents.Rotation = NumberRange.new(-360, 360)
Crescents.Orientation = Enum.ParticleOrientation.VelocityPerpendicular
Crescents.Parent = Attachment

Insane.Parent = workspace
end

do --// Cosmic Explosion

local Part = Instance.new("Part")

Part.Parent = ReplicatedStorage

local Attachment = Instance.new("Attachment")
Attachment.Name = "Attachment"
Attachment.Parent = Part

HitEffectModule.Locals.Type["Cosmic Explosion"] = Attachment

local Glow = Instance.new("ParticleEmitter")
Glow.Name = "Glow"
Glow.Lifetime = NumberRange.new(0.16, 0.16)
Glow.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.1421725, 0.6182796), NumberSequenceKeypoint.new(1, 1)})
Glow.Color = ColorSequence.new(Color3.fromRGB(173, 82, 252))
Glow.Speed = NumberRange.new(0, 0)
Glow.Brightness = 5
Glow.Size = NumberSequence.new(9.1873131, 16.5032349)
Glow.Enabled = false
Glow.ZOffset = -0.0565939
Glow.Rate = 50
Glow.Texture = "rbxassetid://8708637750"
Glow.Parent = Attachment

local Effect = Instance.new("ParticleEmitter")
Effect.Name = "Effect"
Effect.Lifetime = NumberRange.new(0.4, 0.7)
Effect.FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4
Effect.SpreadAngle = Vector2.new(360, -360)
Effect.LockedToPart = true
Effect.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.1070999, 0.19375), NumberSequenceKeypoint.new(0.7761194, 0.88125), NumberSequenceKeypoint.new(1, 1)})
Effect.LightEmission = 1
Effect.Color = ColorSequence.new(Color3.fromRGB(173, 82, 252))
Effect.Drag = 1
Effect.VelocitySpread = 360
Effect.Speed = NumberRange.new(0.0036749, 0.0036749)
Effect.Brightness = 2.0999999
Effect.Size = NumberSequence.new(6.9680691, 9.9213123)
Effect.Enabled = false
Effect.ZOffset = 0.4777403
Effect.Rate = 50
Effect.Texture = "rbxassetid://9484012464"
Effect.RotSpeed = NumberRange.new(-150, -150)
Effect.FlipbookMode = Enum.ParticleFlipbookMode.OneShot
Effect.Rotation = NumberRange.new(50, 50)
Effect.Orientation = Enum.ParticleOrientation.VelocityPerpendicular
Effect.Parent = Attachment

local Gradient1 = Instance.new("ParticleEmitter")
Gradient1.Name = "Gradient1"
Gradient1.Lifetime = NumberRange.new(0.3, 0.3)
Gradient1.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.15, 0.3), NumberSequenceKeypoint.new(1, 1)})
Gradient1.Color = ColorSequence.new(Color3.fromRGB(173, 82, 252))
Gradient1.Speed = NumberRange.new(0, 0)
Gradient1.Brightness = 6
Gradient1.Size = NumberSequence.new(0, 11.6261358)
Gradient1.Enabled = false
Gradient1.ZOffset = 0.9187313
Gradient1.Rate = 50
Gradient1.Texture = "rbxassetid://8196169974"
Gradient1.Parent = Attachment

local Shards = Instance.new("ParticleEmitter")
Shards.Name = "Shards"
Shards.Lifetime = NumberRange.new(0.19, 0.7)
Shards.SpreadAngle = Vector2.new(-90, 90)
Shards.Color = ColorSequence.new(Color3.fromRGB(173, 82, 252))
Shards.Drag = 10
Shards.VelocitySpread = -90
Shards.Squash = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5705521, 0.4125001), NumberSequenceKeypoint.new(1, -0.9375)})
Shards.Speed = NumberRange.new(97.7530136, 146.9970093)
Shards.Brightness = 4
Shards.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.284774, 1.2389833, 0.1534118), NumberSequenceKeypoint.new(1, 0)})
Shards.Enabled = false
Shards.Acceleration = Vector3.new(0, -56.961341857910156, 0)
Shards.ZOffset = 0.5705321
Shards.Rate = 50
Shards.Texture = "rbxassetid://8030734851"
Shards.Rotation = NumberRange.new(90, 90)
Shards.Orientation = Enum.ParticleOrientation.VelocityParallel
Shards.Parent = Attachment

local Crescents = Instance.new("ParticleEmitter")
Crescents.Name = "Crescents"
Crescents.Lifetime = NumberRange.new(0.19, 0.38)
Crescents.SpreadAngle = Vector2.new(-360, 360)
Crescents.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.1932907, 0), NumberSequenceKeypoint.new(0.778754, 0), NumberSequenceKeypoint.new(1, 1)})
Crescents.LightEmission = 10
Crescents.Color = ColorSequence.new(Color3.fromRGB(160, 96, 255))
Crescents.VelocitySpread = -360
Crescents.Speed = NumberRange.new(0.0826858, 0.0826858)
Crescents.Brightness = 4
Crescents.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.398774, 8.8026266, 2.2834616), NumberSequenceKeypoint.new(1, 11.477972, 1.860431)})
Crescents.Enabled = false
Crescents.ZOffset = 0.4542207
Crescents.Rate = 50
Crescents.Texture = "rbxassetid://12509373457"
Crescents.RotSpeed = NumberRange.new(800, 1000)
Crescents.Rotation = NumberRange.new(-360, 360)
Crescents.Orientation = Enum.ParticleOrientation.VelocityPerpendicular
Crescents.Parent = Attachment

local ParticleEmitter2 = Instance.new("ParticleEmitter")
ParticleEmitter2.Name = "ParticleEmitter2"
ParticleEmitter2.FlipbookFramerate = NumberRange.new(20, 20)
ParticleEmitter2.Lifetime = NumberRange.new(0.19, 0.38)
ParticleEmitter2.FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4
ParticleEmitter2.SpreadAngle = Vector2.new(360, 360)
ParticleEmitter2.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.209842, 0.5), NumberSequenceKeypoint.new(0.503842, 0.263333), NumberSequenceKeypoint.new(0.799842, 0.5), NumberSequenceKeypoint.new(1, 1)})
ParticleEmitter2.LightEmission = 1
ParticleEmitter2.Color = ColorSequence.new(Color3.fromRGB(173, 82, 252))
ParticleEmitter2.VelocitySpread = 360
ParticleEmitter2.Speed = NumberRange.new(0.0161231, 0.0161231)
ParticleEmitter2.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 4.3125), NumberSequenceKeypoint.new(0.3985056, 7.9375), NumberSequenceKeypoint.new(1, 10)})
ParticleEmitter2.Enabled = false
ParticleEmitter2.ZOffset = 0.15
ParticleEmitter2.Rate = 100
ParticleEmitter2.Texture = "http://www.roblox.com/asset/?id=12394566430"
ParticleEmitter2.FlipbookMode = Enum.ParticleFlipbookMode.OneShot
ParticleEmitter2.Rotation = NumberRange.new(39, 999)
ParticleEmitter2.Orientation = Enum.ParticleOrientation.VelocityParallel
ParticleEmitter2.Parent = Attachment

Part.Parent = workspace
end

do --// Coom

local Part = Instance.new("Part")

Part.Parent = ReplicatedStorage

local Attachment = Instance.new("Attachment")
Attachment.Parent = Part

HitEffectModule.Locals.Type["Coom"] = Attachment

local Foam = Instance.new("ParticleEmitter")
Foam.Name = "Foam"
Foam.LightInfluence = 0.5
Foam.Lifetime = NumberRange.new(1, 1)
Foam.SpreadAngle = Vector2.new(360, -360)
Foam.VelocitySpread = 360
Foam.Squash = NumberSequence.new(1)
Foam.Speed = NumberRange.new(20, 20)
Foam.Brightness = 2.5
Foam.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.1016692, 0.6508875, 0.6508875), NumberSequenceKeypoint.new(0.6494689, 1.4201183, 0.4127519), NumberSequenceKeypoint.new(1, 0)})
Foam.Enabled = false
Foam.Acceleration = Vector3.new(0, -66.04029846191406, 0)
Foam.Rate = 100
Foam.Texture = "rbxassetid://8297030850"
Foam.Rotation = NumberRange.new(-90, -90)
Foam.Orientation = Enum.ParticleOrientation.VelocityParallel
Foam.Parent = Attachment

Part.Parent = workspace
end

do --// Slash
local Part = Instance.new("Part")
Part.Parent = ReplicatedStorage

local Attachment = Instance.new("Attachment")
Attachment.Parent = Part

HitEffectModule.Locals.Type["Slash"] = Attachment

local Crescents = Instance.new("ParticleEmitter")
Crescents.Name = "Crescents"
Crescents.Lifetime = NumberRange.new(0.19, 0.38)
Crescents.SpreadAngle = Vector2.new(-360, 360)
Crescents.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.1932907, 0), NumberSequenceKeypoint.new(0.778754, 0), NumberSequenceKeypoint.new(1, 1)})
Crescents.LightEmission = 10
Crescents.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(160, 96, 255)), ColorSequenceKeypoint.new(0.3160622, Color3.fromRGB(160, 96, 255)), ColorSequenceKeypoint.new(0.5146805, Color3.fromRGB(154, 82, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(160, 96, 255))})
Crescents.VelocitySpread = -360
Crescents.Speed = NumberRange.new(0.0826858, 0.0826858)
Crescents.Brightness = 4
Crescents.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.398774, 8.8026266, 2.2834616), NumberSequenceKeypoint.new(1, 11.477972, 1.860431)})
Crescents.Enabled = false
Crescents.ZOffset = 0.4542207
Crescents.Rate = 50
Crescents.Texture = "rbxassetid://12509373457"
Crescents.RotSpeed = NumberRange.new(800, 1000)
Crescents.Rotation = NumberRange.new(-360, 360)
Crescents.Orientation = Enum.ParticleOrientation.VelocityPerpendicular
Crescents.Parent = Attachment

Part.Parent = workspace
end

do --// Atomic Slash

local Part = Instance.new("Part")

Part.Parent = ReplicatedStorage

local Attachment = Instance.new("Attachment")
Attachment.Parent = Part

HitEffectModule.Locals.Type["Atomic Slash"] = Attachment

local Crescents = Instance.new("ParticleEmitter")
Crescents.Name = "Crescents"
Crescents.Lifetime = NumberRange.new(0.19, 0.38)
Crescents.SpreadAngle = Vector2.new(-360, 360)
Crescents.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.1932907, 0), NumberSequenceKeypoint.new(0.778754, 0), NumberSequenceKeypoint.new(1, 1)})
Crescents.LightEmission = 10
Crescents.Color = ColorSequence.new(Color3.fromRGB(160, 96, 255))
Crescents.VelocitySpread = -360
Crescents.Speed = NumberRange.new(0.0826858, 0.0826858)
Crescents.Brightness = 4
Crescents.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.398774, 8.8026266, 2.2834616), NumberSequenceKeypoint.new(1, 11.477972, 1.860431)})
Crescents.Enabled = false
Crescents.ZOffset = 0.4542207
Crescents.Rate = 50
Crescents.Texture = "rbxassetid://12509373457"
Crescents.RotSpeed = NumberRange.new(800, 1000)
Crescents.Rotation = NumberRange.new(-360, 360)
Crescents.Orientation = Enum.ParticleOrientation.VelocityPerpendicular
Crescents.Parent = Attachment

local Glow = Instance.new("ParticleEmitter")
Glow.Name = "Glow"
Glow.Lifetime = NumberRange.new(0.16, 0.16)
Glow.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.1421725, 0.6182796), NumberSequenceKeypoint.new(1, 1)})
Glow.Color = ColorSequence.new(Color3.fromRGB(173, 82, 252))
Glow.Speed = NumberRange.new(0, 0)
Glow.Brightness = 5
Glow.Size = NumberSequence.new(9.1873131, 16.5032349)
Glow.Enabled = false
Glow.ZOffset = -0.0565939
Glow.Rate = 50
Glow.Texture = "rbxassetid://8708637750"
Glow.Parent = Attachment

local Effect = Instance.new("ParticleEmitter")
Effect.Name = "Effect"
Effect.Lifetime = NumberRange.new(0.4, 0.7)
Effect.FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4
Effect.SpreadAngle = Vector2.new(360, -360)
Effect.LockedToPart = true
Effect.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.1070999, 0.19375), NumberSequenceKeypoint.new(0.7761194, 0.88125), NumberSequenceKeypoint.new(1, 1)})
Effect.LightEmission = 1
Effect.Color = ColorSequence.new(Color3.fromRGB(173, 82, 252))
Effect.Drag = 1
Effect.VelocitySpread = 360
Effect.Speed = NumberRange.new(0.0036749, 0.0036749)
Effect.Brightness = 2.0999999
Effect.Size = NumberSequence.new(6.9680691, 9.9213123)
Effect.Enabled = false
Effect.ZOffset = 0.4777403
Effect.Rate = 50
Effect.Texture = "rbxassetid://9484012464"
Effect.RotSpeed = NumberRange.new(-150, -150)
Effect.FlipbookMode = Enum.ParticleFlipbookMode.OneShot
Effect.Rotation = NumberRange.new(50, 50)
Effect.Orientation = Enum.ParticleOrientation.VelocityPerpendicular
Effect.Parent = Attachment

local Gradient1 = Instance.new("ParticleEmitter")
Gradient1.Name = "Gradient1"
Gradient1.Lifetime = NumberRange.new(0.3, 0.3)
Gradient1.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.15, 0.3), NumberSequenceKeypoint.new(1, 1)})
Gradient1.Color = ColorSequence.new(Color3.fromRGB(173, 82, 252))
Gradient1.Speed = NumberRange.new(0, 0)
Gradient1.Brightness = 6
Gradient1.Size = NumberSequence.new(0, 11.6261358)
Gradient1.Enabled = false
Gradient1.ZOffset = 0.9187313
Gradient1.Rate = 50
Gradient1.Texture = "rbxassetid://8196169974"
Gradient1.Parent = Attachment

local Shards = Instance.new("ParticleEmitter")
Shards.Name = "Shards"
Shards.Lifetime = NumberRange.new(0.19, 0.7)
Shards.SpreadAngle = Vector2.new(-90, 90)
Shards.Color = ColorSequence.new(Color3.fromRGB(179, 145, 253))
Shards.Drag = 10
Shards.VelocitySpread = -90
Shards.Squash = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5705521, 0.4125001), NumberSequenceKeypoint.new(1, -0.9375)})
Shards.Speed = NumberRange.new(97.7530136, 146.9970093)
Shards.Brightness = 4
Shards.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.284774, 1.2389833, 0.1534118), NumberSequenceKeypoint.new(1, 0)})
Shards.Enabled = false
Shards.Acceleration = Vector3.new(0, -56.961341857910156, 0)
Shards.ZOffset = 0.5705321
Shards.Rate = 50
Shards.Texture = "rbxassetid://8030734851"
Shards.Rotation = NumberRange.new(90, 90)
Shards.Orientation = Enum.ParticleOrientation.VelocityParallel
Shards.Parent = Attachment

Part.Parent = workspace
end
do
local Players = game:GetService("Players")
local Attachment = Instance.new("Attachment")

getgenv().AuraT = "Swirl"
getgenv().Aura = true

do --// AuraZ

local Part = Instance.new("Part")

Part.Parent = ReplicatedStorage

local Attachment = Instance.new("Attachment")
Attachment.Parent = Part

HitEffectModule.Locals.Type["Aura"] = Attachment
-- Spike Aura ------
    local SPIKES = Instance.new("ParticleEmitter")
    SPIKES.Name = "SPIKES"
    SPIKES.Acceleration = Vector3.new(0, 100, 0)
    SPIKES.Color = ColorSequence.new(Color3.new(0, 1, 0), Color3.new(0, 1, 0))
    SPIKES.Drag = 3
    SPIKES.EmissionDirection = Enum.NormalId.Right
    SPIKES.Lifetime = NumberRange.new(0.25, 0.5)
    SPIKES.LightEmission = 1
    SPIKES.Orientation = Enum.ParticleOrientation.VelocityParallel
    SPIKES.Rate = 100
    SPIKES.Rotation = NumberRange.new(-90, -90)
    SPIKES.Size = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 2, 0),
        NumberSequenceKeypoint.new(0.25, 3, 0.25),
        NumberSequenceKeypoint.new(0.653846, 2.0625, 0.164957),
        NumberSequenceKeypoint.new(1, 0, 0)
    })
    SPIKES.Speed = NumberRange.new(10, 25)
    SPIKES.SpreadAngle = Vector2.new(0, 180)
    SPIKES.Squash = NumberSequence.new({
        NumberSequenceKeypoint.new(0, -0.25),
        NumberSequenceKeypoint.new(1, 0.5),
        NumberSequenceKeypoint.new(1, 0.25)
    })
    SPIKES.Texture = "rbxassetid://7451697448"
    SPIKES.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(0.25, 0),
        NumberSequenceKeypoint.new(1, 1)
    })
    SPIKES.Enabled = false
    SPIKES.Parent = Attachment
end


    local SPECKS = Instance.new("ParticleEmitter")
    SPECKS.Name = "SPECKS"
    SPECKS.Acceleration = Vector3.new(0, -25, 0)
    SPECKS.Brightness = 2
    SPECKS.Color = ColorSequence.new(Color3.new(0, 1, 0), Color3.new(0, 1, 0))
    SPECKS.Drag = 5
    SPECKS.Lifetime = NumberRange.new(0.375, 0.625)
    SPECKS.LightEmission = 1
    SPECKS.Rate = 100
    SPECKS.RotSpeed = NumberRange.new(-45, 45)
    SPECKS.Rotation = NumberRange.new(-360, 360)
    SPECKS.Size = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.25),
        NumberSequenceKeypoint.new(1, 0)
    })
    SPECKS.Speed = NumberRange.new(25, 50)
    SPECKS.SpreadAngle = Vector2.new(45, 45)
    SPECKS.Squash = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(1, 1)
    })
    SPECKS.Texture = "rbxassetid://4509687978"
    SPECKS.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(0.25, 0.2),
        NumberSequenceKeypoint.new(1, 1)
    })
    SPECKS.Enabled = false
    SPECKS.Parent = Attachment

    local GLOW = Instance.new("ParticleEmitter")
    GLOW.Name = "GLOW"
    GLOW.Acceleration = Vector3.new(0, 5, 0)
    GLOW.Color = ColorSequence.new(Color3.new(0, 1, 0), Color3.new(0, 1, 0))
    GLOW.Lifetime = NumberRange.new(0.5, 1)
    GLOW.LightEmission = 1
    GLOW.Rate = 50
    GLOW.Rotation = NumberRange.new(-360, 360)
    GLOW.Size = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 8),
        NumberSequenceKeypoint.new(1, 3)
    })
    GLOW.Speed = NumberRange.new(10, 25)
    GLOW.Texture = "rbxassetid://4509687978"
    GLOW.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(0.5, 0.95),
        NumberSequenceKeypoint.new(1, 1)
    })
    GLOW.ZOffset = -1
    GLOW.Enabled = false
    GLOW.Parent = Attachment
end
--- Spike Aura End

-- Electric --------------
do --// Coom

local Part = Instance.new("Part")

Part.Parent = ReplicatedStorage

local Attachment = Instance.new("Attachment")
Attachment.Parent = Part

HitEffectModule.Locals.Type["Electric"] = Attachment
    local ELECTRIC1 = Instance.new('ParticleEmitter')
    ELECTRIC1.Name = "ELECTRIC1"
    ELECTRIC1.Brightness = 5
    ELECTRIC1.Color = ColorSequence.new(Color3.fromRGB(0, 134, 199))
    ELECTRIC1.FlipbookLayout = Enum.ParticleFlipbookLayout.Grid8x8
    ELECTRIC1.FlipbookMode = Enum.ParticleFlipbookMode.OneShot
    ELECTRIC1.Lifetime = NumberRange.new(1)
    ELECTRIC1.LightEmission = 1
    ELECTRIC1.Rate = 5
    ELECTRIC1.Size = NumberSequence.new(2)
    ELECTRIC1.Speed = NumberRange.new(0)
    ELECTRIC1.SpreadAngle = Vector2.new(-360, 360)
    ELECTRIC1.Texture = "http://www.roblox.com/asset/?id=12390063093"
    ELECTRIC1.Transparency = NumberSequence.new(0, 1)
    ELECTRIC1.Enabled = false
    ELECTRIC1.Parent = Attachment

    local ELECTRIC2 = Instance.new('ParticleEmitter')
    ELECTRIC2.Name = "ELECTRIC2"
    ELECTRIC2.Color = ColorSequence.new(Color3.fromRGB(0, 134, 199))
    ELECTRIC2.FlipbookLayout = Enum.ParticleFlipbookLayout.Grid8x8
    ELECTRIC2.FlipbookMode = Enum.ParticleFlipbookMode.OneShot
    ELECTRIC2.Lifetime = NumberRange.new(0.25, 0.5)
    ELECTRIC2.LightEmission = 1
    ELECTRIC2.Rate = 25
    ELECTRIC2.Rotation = NumberRange.new(-360, 360)
    ELECTRIC2.Size = NumberSequence.new(2)
    ELECTRIC2.Speed = NumberRange.new(0)
    ELECTRIC2.SpreadAngle = Vector2.new(-360, 360)
    ELECTRIC2.Texture = "http://www.roblox.com/asset/?id=12390081661"
    ELECTRIC2.Transparency = NumberSequence.new(0, 1)
    ELECTRIC2.Enabled = false
    ELECTRIC2.Parent = Attachment

    local ELECTRIC3 = Instance.new('ParticleEmitter')
    ELECTRIC3.Name = "ELECTRIC3"
    ELECTRIC3.Color = ColorSequence.new(Color3.fromRGB(0, 134, 199))
    ELECTRIC3.FlipbookLayout = Enum.ParticleFlipbookLayout.Grid8x8
    ELECTRIC3.FlipbookMode = Enum.ParticleFlipbookMode.OneShot
    ELECTRIC3.Lifetime = NumberRange.new(0.25, 0.5)
    ELECTRIC3.LightEmission = 1
    ELECTRIC3.Rate = 25
    ELECTRIC3.Rotation = NumberRange.new(-360, 360)
    ELECTRIC3.Size = NumberSequence.new(2)
    ELECTRIC3.Speed = NumberRange.new(0)
    ELECTRIC3.SpreadAngle = Vector2.new(-360, 360)
    ELECTRIC3.Texture = "http://www.roblox.com/asset/?id=12390081661"
    ELECTRIC3.Transparency = NumberSequence.new(0, 1)
    ELECTRIC3.Enabled = false
    ELECTRIC3.Parent = Attachment

    local Wave1 = Instance.new('ParticleEmitter')
    Wave1.Name = "Wave1"
    Wave1.Brightness = 10
    Wave1.Color = ColorSequence.new(Color3.fromRGB(0, 170, 255))
    Wave1.Lifetime = NumberRange.new(1)
    Wave1.LightEmission = 0.4
    Wave1.Orientation = Enum.ParticleOrientation.VelocityPerpendicular
    Wave1.Rate = 10
    Wave1.RotSpeed = NumberRange.new(200, 400)
    Wave1.Rotation = NumberRange.new(-180, 180)
    Wave1.Size = NumberSequence.new(3)
    Wave1.Speed = NumberRange.new(1, 3)
    Wave1.SpreadAngle = Vector2.new(10, -10)
    Wave1.Texture = "rbxassetid://8047533775"
    Wave1.Transparency = NumberSequence.new(0, 1)
    Wave1.Enabled = false
    Wave1.Parent = Attachment

    local ELECTRIC4 = Instance.new('ParticleEmitter')
    ELECTRIC4.Name = "ELECTRIC4"
    ELECTRIC4.Color = ColorSequence.new(Color3.fromRGB(0, 134, 199))
    ELECTRIC4.FlipbookLayout = Enum.ParticleFlipbookLayout.Grid8x8
    ELECTRIC4.FlipbookMode = Enum.ParticleFlipbookMode.OneShot
    ELECTRIC4.Lifetime = NumberRange.new(0.25, 0.5)
    ELECTRIC4.LightEmission = 1
    ELECTRIC4.Rate = 25
    ELECTRIC4.Rotation = NumberRange.new(-360, 360)
    ELECTRIC4.Size = NumberSequence.new(2)
    ELECTRIC4.Speed = NumberRange.new(0)
    ELECTRIC4.SpreadAngle = Vector2.new(-360, 360)
    ELECTRIC4.Texture = "http://www.roblox.com/asset/?id=12390081661"
    ELECTRIC4.Transparency = NumberSequence.new(0, 1)
    ELECTRIC4.Enabled = false
    ELECTRIC4.Parent = Attachment
end
----- Electric End

-- Swirl ------
do --// Coom

local Part = Instance.new("Part")

Part.Parent = ReplicatedStorage

local Attachment = Instance.new("Attachment")
Attachment.Parent = Part

HitEffectModule.Locals.Type["swirl"] = Attachment
local swirl = Instance.new("ParticleEmitter")
swirl.Name = "swirl"
swirl.Color = ColorSequence.new(Color3.fromRGB(66, 60, 255), Color3.fromRGB(66, 60, 255))
swirl.Lifetime = NumberRange.new(2, 2)
swirl.LightEmission = 1
swirl.Orientation = Enum.ParticleOrientation.VelocityPerpendicular
swirl.Rate = 150
swirl.RotSpeed = NumberRange.new(200, 200)
swirl.Size = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 7),
    NumberSequenceKeypoint.new(1, 7)
})
swirl.Speed = NumberRange.new(0.01, 0.01)
swirl.SpreadAngle = Vector2.new(-360, 360)
swirl.Squash = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 0),
    NumberSequenceKeypoint.new(0.163934, 1),
    NumberSequenceKeypoint.new(1, 0)
})
swirl.Texture = "rbxassetid://10558425570"
swirl.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 0),
    NumberSequenceKeypoint.new(0.500623, 0.5),
    NumberSequenceKeypoint.new(1, 1)
})
swirl.ZOffset = -1
swirl.Enabled = false
swirl.Parent = Attachment
swirl.Enabled = true
end
-------------- swirl end here


do --// Coom

local Part = Instance.new("Part")

Part.Parent = ReplicatedStorage

local Attachment = Instance.new("Attachment")
Attachment.Parent = Part

HitEffectModule.Locals.Type["AuraBurst"] = Attachment
-- aura burst ------ ass
local auraburst2 = Instance.new("ParticleEmitter")
auraburst2.Name = "auraburst2"
auraburst2.Brightness = 25
auraburst2.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 0))
})
auraburst2.EmissionDirection = Enum.NormalId.Top
auraburst2.Enabled = false
auraburst2.FlipbookFramerate = NumberRange.new(289.311, 289.311)
auraburst2.FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4
auraburst2.FlipbookMode = Enum.ParticleFlipbookMode.OneShot
auraburst2.Lifetime = NumberRange.new(0.500, 0.500)
auraburst2.LightEmission = 1
auraburst2.LightInfluence = 0.15
auraburst2.Orientation = Enum.ParticleOrientation.VelocityParallel
auraburst2.Rate = 6.615
auraburst2.Rotation = NumberRange.new(360, 360)
auraburst2.Size = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 8.7832),
    NumberSequenceKeypoint.new(1, 8.7832)
})
auraburst2.Speed = NumberRange.new(0.00973265, 0.00973265)
auraburst2.Squash = NumberSequence.new({
    NumberSequenceKeypoint.new(0, -0.5),
    NumberSequenceKeypoint.new(1, -0.5)
})
auraburst2.Texture = "rbxassetid://17282066926"
auraburst2.ZOffset = -1
auraburst2.Parent = Attachment
end
------- aura burst end here

---- Shocks - - - - - 

do --// Coom

local Part = Instance.new("Part")

Part.Parent = ReplicatedStorage

local Attachment = Instance.new("Attachment")
Attachment.Parent = Part

HitEffectModule.Locals.Type["Shock3"] = Attachment

local Shock3 = Instance.new('ParticleEmitter')
Shock3.Name = "Shock3"
Shock3.Brightness = 2
Shock3.Color = ColorSequence.new(Color3.fromRGB(0, 193, 85), Color3.fromRGB(0, 193, 85))
Shock3.Enabled = true
Shock3.Lifetime = NumberRange.new(0.3, 0.5)
Shock3.LightEmission = 1
Shock3.Orientation = Enum.ParticleOrientation.VelocityPerpendicular
Shock3.Rate = 7
Shock3.RotSpeed = NumberRange.new(-50, 50)
Shock3.Rotation = NumberRange.new(0, 360)
Shock3.Size = NumberSequence.new(0, 0, 0, 0.2, 5, 0, 0.5, 8, 0, 1, 10, 0)
Shock3.Speed = NumberRange.new(0.001, 0.001)
Shock3.SpreadAngle = Vector2.new(180, 180)
Shock3.Texture = "rbxassetid://9533206597"
Shock3.Transparency = NumberSequence.new(0, 0, 0, 1, 1, 0)
Shock3.Parent = Attachment

local Shock4 = Instance.new('ParticleEmitter')
Shock4.Name = "Shock4"
Shock4.Brightness = 2
Shock4.Color = ColorSequence.new(Color3.fromRGB(0, 193, 85), Color3.fromRGB(0, 193, 85))
Shock4.Enabled = true
Shock4.FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4
Shock4.FlipbookMode = Enum.ParticleFlipbookMode.OneShot
Shock4.Lifetime = NumberRange.new(0.3, 0.5)
Shock4.LightEmission = 1
Shock4.Rate = 7
Shock4.RotSpeed = NumberRange.new(-10, 10)
Shock4.Rotation = NumberRange.new(0, 360)
Shock4.Size = NumberSequence.new(0, 20, 0, 1, 20, 0)
Shock4.Speed = NumberRange.new(0, 0)
Shock4.Texture = "rbxassetid://10198434999"
Shock4.Transparency = NumberSequence.new(0, 0, 0, 0.5, 0.2, 0, 1, 1, 0)
Shock4.Parent = Attachment

local Shock5 = Instance.new('ParticleEmitter')
Shock5.Name = "Shock5"
Shock5.Brightness = 2
Shock5.Color = ColorSequence.new(Color3.fromRGB(0, 193, 85), Color3.fromRGB(0, 193, 85))
Shock5.Enabled = true
Shock5.FlipbookMode = Enum.ParticleFlipbookMode.OneShot
Shock5.Lifetime = NumberRange.new(0.3, 0.5)
Shock5.LightEmission = 1
Shock5.Rate = 7
Shock5.RotSpeed = NumberRange.new(-50, 50)
Shock5.Rotation = NumberRange.new(0, 360)
Shock5.Size = NumberSequence.new(0, 10, 0, 0.5, 2, 0, 1, 0, 0)
Shock5.Speed = NumberRange.new(0, 0)
Shock5.Texture = "rbxassetid://7216849703"
Shock5.ZOffset = 1
Shock5.Parent = Attachment
end


----Thunser-----
do --// Coom

local Part = Instance.new("Part")

Part.Parent = ReplicatedStorage

local Attachment = Instance.new("Attachment")
Attachment.Parent = Part

HitEffectModule.Locals.Type["Thunder"] = Attachment
local RESIDUE = Instance.new('ParticleEmitter')
RESIDUE.Name = "RESIDUE"
RESIDUE.Acceleration = Vector3.new(0, -25, 0)
RESIDUE.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 105, 170)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 105, 170))
}
RESIDUE.Drag = 2
RESIDUE.Lifetime = NumberRange.new(0.25, 0.5)
RESIDUE.LightEmission = 1
RESIDUE.Orientation = Enum.ParticleOrientation.VelocityParallel
RESIDUE.Rate = 100
RESIDUE.Rotation = NumberRange.new(90, 90)
RESIDUE.Size = NumberSequence.new{
    NumberSequenceKeypoint.new(0, 2),
    NumberSequenceKeypoint.new(1, 0)
}
RESIDUE.Speed = NumberRange.new(25, 50)
RESIDUE.SpreadAngle = Vector2.new(-90, 90)
RESIDUE.Squash = NumberSequence.new{
    NumberSequenceKeypoint.new(0, 1),
    NumberSequenceKeypoint.new(1, 0)
}
RESIDUE.Texture = "rbxassetid://4509687978"
RESIDUE.Transparency = NumberSequence.new{
    NumberSequenceKeypoint.new(0, 0),
    NumberSequenceKeypoint.new(0.25, 1),
    NumberSequenceKeypoint.new(1, 1)
}

setclipboard("https://discord.gg/UgQAPcBtpy")


local ELECTRIC = Instance.new('ParticleEmitter')
ELECTRIC.Name = "ELECTRIC"
ELECTRIC.Brightness = 3
ELECTRIC.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 134, 199)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 134, 199))
}
ELECTRIC.FlipbookLayout = Enum.ParticleFlipbookLayout.Grid8x8
ELECTRIC.FlipbookMode = Enum.ParticleFlipbookMode.OneShot
ELECTRIC.Lifetime = NumberRange.new(0.5, 1)
ELECTRIC.LightEmission = 2
ELECTRIC.Orientation = Enum.ParticleOrientation.FacingCameraWorldUp
ELECTRIC.Rate = 12
ELECTRIC.Size = NumberSequence.new{
    NumberSequenceKeypoint.new(0, 25),
    NumberSequenceKeypoint.new(1, 0)
}
ELECTRIC.Speed = NumberRange.new(0, 0)
ELECTRIC.SpreadAngle = Vector2.new(-360, 360)
ELECTRIC.Texture = "rbxassetid://10547286472"
ELECTRIC.Transparency = NumberSequence.new{
    NumberSequenceKeypoint.new(0, 0),
    NumberSequenceKeypoint.new(0.25, 1),
    NumberSequenceKeypoint.new(1, 1)
}

RESIDUE.Parent = Attachment
RESIDUE.Enabled = true

ELECTRIC.Parent = Attachment
ELECTRIC.Enabled = true
local SMOKE = Instance.new("ParticleEmitter")

SMOKE.Name = "SMOKE"
SMOKE.Acceleration = Vector3.new(0, 5, 1)
SMOKE.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.new(0.196078, 0.196078, 0.196078)), 
    ColorSequenceKeypoint.new(1, Color3.new(0.196078, 0.196078, 0.196078))
})
SMOKE.Drag = 1
SMOKE.FlipbookFramerate = NumberRange.new(25, 25)
SMOKE.FlipbookLayout = Enum.ParticleFlipbookLayout.Grid8x8
SMOKE.LightInfluence = 1
SMOKE.Rate = 10
SMOKE.RotSpeed = NumberRange.new(-15, 15)
SMOKE.Rotation = NumberRange.new(-360, 360)
SMOKE.Size = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 4, 0), 
    NumberSequenceKeypoint.new(1, 8, 2)
})
SMOKE.Speed = NumberRange.new(1, 1)
SMOKE.Texture = "rbxassetid://8073306083"
SMOKE.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 1, 0), 
    NumberSequenceKeypoint.new(0.5, 0.75, 0), 
    NumberSequenceKeypoint.new(1, 1, 0)
})

SMOKE.Parent = Attachment
SMOKE.Enabled = true
end


--- Explostin---
--[[


local EXPLOSION01 = Instance.new("ParticleEmitter")
EXPLOSION01.Name = "EXPLOSION01"
EXPLOSION01.Brightness = 5
EXPLOSION01.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 117, 37)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 117, 37))
}
EXPLOSION01.Drag = 20
EXPLOSION01.FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4
EXPLOSION01.FlipbookMode = Enum.ParticleFlipbookMode.OneShot
EXPLOSION01.Lifetime = NumberRange.new(0.5, 1)
EXPLOSION01.LightEmission = 1
EXPLOSION01.Rate = 100
EXPLOSION01.RotSpeed = NumberRange.new(-45, 45)
EXPLOSION01.Rotation = NumberRange.new(-360, 360)
EXPLOSION01.Size = NumberSequence.new{
    NumberSequenceKeypoint.new(0, 9),
    NumberSequenceKeypoint.new(1, 9)
}
EXPLOSION01.Speed = NumberRange.new(100, 250)
EXPLOSION01.SpreadAngle = Vector2.new(180, 180)
EXPLOSION01.Texture = "http://www.roblox.com/asset/?id=11534281007"
EXPLOSION01.Transparency = NumberSequence.new{
    NumberSequenceKeypoint.new(0, 0),
    NumberSequenceKeypoint.new(0.25, 1),
    NumberSequenceKeypoint.new(0.5, 0),
    NumberSequenceKeypoint.new(1, 1)
}
print("khen.cc on top")


EXPLOSION01.ZOffset = 1
EXPLOSION01.Enabled = true
EXPLOSION01.Parent = Attachment

local EXPLOSION02 = Instance.new("ParticleEmitter")
EXPLOSION02.Name = "EXPLOSION02"
EXPLOSION02.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 139, 62)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 139, 62))
}
EXPLOSION02.Drag = 20
EXPLOSION02.Lifetime = NumberRange.new(0.5, 1.5)
EXPLOSION02.LightEmission = 1
EXPLOSION02.Rate = 100
EXPLOSION02.Size = NumberSequence.new{
    NumberSequenceKeypoint.new(0, 25),
    NumberSequenceKeypoint.new(1, 0)
}
EXPLOSION02.Speed = NumberRange.new(150, 300)
EXPLOSION02.SpreadAngle = Vector2.new(-180, 180)
EXPLOSION02.Texture = "rbxassetid://4509687978"
EXPLOSION02.Transparency = NumberSequence.new{
    NumberSequenceKeypoint.new(0, 0),
    NumberSequenceKeypoint.new(0.25, 1),
    NumberSequenceKeypoint.new(0.9, 0),
    NumberSequenceKeypoint.new(1, 1)
}
EXPLOSION02.ZOffset = -2
EXPLOSION02.Enabled = true
EXPLOSION02.Parent = Attachment

local EXPLOSION03 = Instance.new("ParticleEmitter")
EXPLOSION03.Name = "EXPLOSION03"
EXPLOSION03.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(125, 125, 125)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 25, 25))
}
EXPLOSION03.Drag = 12
EXPLOSION03.FlipbookLayout = Enum.ParticleFlipbookLayout.Grid8x8
EXPLOSION03.FlipbookMode = Enum.ParticleFlipbookMode.OneShot
EXPLOSION03.Lifetime = NumberRange.new(2, 4)
EXPLOSION03.Rate = 100
EXPLOSION03.RotSpeed = NumberRange.new(-15, 15)
EXPLOSION03.Rotation = NumberRange.new(-360, 360)
EXPLOSION03.Size = NumberSequence.new{
    NumberSequenceKeypoint.new(0, 25),
    NumberSequenceKeypoint.new(1, 0)
}
EXPLOSION03.Speed = NumberRange.new(100, 200)
EXPLOSION03.SpreadAngle = Vector2.new(180, 180)
EXPLOSION03.Texture = "rbxassetid://8073306083"
EXPLOSION03.Transparency = NumberSequence.new{
    NumberSequenceKeypoint.new(0, 0),
    NumberSequenceKeypoint.new(0.25, 1),
    NumberSequenceKeypoint.new(0.75, 0),
    NumberSequenceKeypoint.new(1, 1)
}
EXPLOSION03.ZOffset = -3
EXPLOSION03.Enabled = true
EXPLOSION03.Parent = Attachment

local EXPLOSION04 = Instance.new("ParticleEmitter")
EXPLOSION04.Name = "EXPLOSION04"
EXPLOSION04.Acceleration = Vector3.new(0, -50, 0)
EXPLOSION04.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 158, 93)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 158, 93))
}
EXPLOSION04.Drag = 5
EXPLOSION04.Lifetime = NumberRange.new(0.5, 1)
EXPLOSION04.LightEmission = 1
EXPLOSION04.Orientation = Enum.ParticleOrientation.VelocityParallel
EXPLOSION04.Rate = 100
EXPLOSION04.Rotation = NumberRange.new(-90, -90)
EXPLOSION04.Size = NumberSequence.new{
    NumberSequenceKeypoint.new(0, 4),
    NumberSequenceKeypoint.new(1, 0)
}
EXPLOSION04.Speed = NumberRange.new(100, 200)
EXPLOSION04.SpreadAngle = Vector2.new(-180, 180)
EXPLOSION04.Squash = NumberSequence.new{
    NumberSequenceKeypoint.new(0, 1),
    NumberSequenceKeypoint.new(1, 0)
}
EXPLOSION04.Texture = "rbxassetid://6763809313"
EXPLOSION04.Transparency = NumberSequence.new{
    NumberSequenceKeypoint.new(0, 0),
    NumberSequenceKeypoint.new(0.25, 1),
    NumberSequenceKeypoint.new(1, 1)
}
EXPLOSION04.Enabled = true
EXPLOSION04.Parent = Attachment
]] 


-- idk 
do --// Coom

local Part = Instance.new("Part")

Part.Parent = ReplicatedStorage

local Attachment = Instance.new("Attachment")
Attachment.Parent = Part

HitEffectModule.Locals.Type["IDK"] = Attachment
local Traces = Instance.new("ParticleEmitter")
Traces.Name = "Traces"
Traces.Brightness = 4.89
Traces.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
    ColorSequenceKeypoint.new(1, Color3.new(0.219608, 0.792157, 1))
})
Traces.Lifetime = NumberRange.new(0.2, 0.2)
Traces.LightEmission = 1
Traces.Orientation = Enum.ParticleOrientation.VelocityParallel
Traces.Rate = 30
Traces.Rotation = NumberRange.new(-90, -90)
Traces.Size = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 0),
    NumberSequenceKeypoint.new(1, 5.375)
})
Traces.Speed = NumberRange.new(50, 50)
Traces.SpreadAngle = Vector2.new(-360, 360)
Traces.Squash = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 0.4),
    NumberSequenceKeypoint.new(1, 0.4)
})
Traces.Texture = "rbxassetid://8099322194"
Traces.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 1),
    NumberSequenceKeypoint.new(1, 0)
})
Traces.Parent = Attachment
Traces.Enabled = true
end

do --// Coom

local Part = Instance.new("Part")

Part.Parent = ReplicatedStorage

local Attachment = Instance.new("Attachment")
Attachment.Parent = Part

HitEffectModule.Locals.Type["Circle"] = Attachment

local Circle = Instance.new("ParticleEmitter")
Circle.Name = "Circle"
Circle.Brightness = 9.335
Circle.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.new(0.6, 0.894118, 1)),
    ColorSequenceKeypoint.new(1, Color3.new(0.472546, 0.227451, 0.858824))
})
Circle.Lifetime = NumberRange.new(0.3, 0.3)
Circle.LightEmission = 1
Circle.Rate = 4
Circle.RotSpeed = NumberRange.new(4, 4)
Circle.Rotation = NumberRange.new(-360, 360)
Circle.ShapeInOut = Enum.ParticleEmitterShapeInOut.Inward
Circle.Size = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 0),
    NumberSequenceKeypoint.new(1, 5.8125)
})
Circle.Speed = NumberRange.new(0, 0)
Circle.Texture = "rbxassetid://8096254696"
Circle.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 1),
    NumberSequenceKeypoint.new(1, 0)
})
Circle.Parent = Attachment
Circle.Enabled = true

local Center2 = Instance.new("ParticleEmitter")
Center2.Name = "Center2"
Center2.Brightness = 9.335
Center2.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.new(0.6, 0.894118, 1)),
    ColorSequenceKeypoint.new(1, Color3.new(0.472546, 0.227451, 0.858824))
})
Center2.Lifetime = NumberRange.new(0.2, 0.2)
Center2.LightEmission = 1
Center2.Rate = 1
Center2.RotSpeed = NumberRange.new(4, 4)
Center2.Rotation = NumberRange.new(-360, 360)
Center2.ShapeInOut = Enum.ParticleEmitterShapeInOut.Inward
Center2.Size = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 2.4375),
    NumberSequenceKeypoint.new(1, 5.88)
})
Center2.Speed = NumberRange.new(0, 0)
Center2.Texture = "rbxassetid://8096224517"
Center2.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 1),
    NumberSequenceKeypoint.new(1, 0)
})
Center2.Parent = Attachment
Center2.Enabled = true

local Circle = Instance.new("ParticleEmitter")

Circle.Name = "Circle"
Circle.Brightness = 9.335
Circle.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.new(0.6, 0.894118, 1)),
    ColorSequenceKeypoint.new(1, Color3.new(0.472546, 0.227451, 0.858824))
})
Circle.Lifetime = NumberRange.new(0.3, 0.3)
Circle.LightEmission = 1
Circle.Rate = 4
Circle.RotSpeed = NumberRange.new(4, 4)
Circle.Rotation = NumberRange.new(-360, 360)
Circle.ShapeInOut = Enum.ParticleEmitterShapeInOut.Inward
Circle.Size = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 0),
    NumberSequenceKeypoint.new(0.600223, 5.75),
    NumberSequenceKeypoint.new(1, 5.8125)
})
Circle.Speed = NumberRange.new(0, 0)
Circle.Texture = "rbxassetid://8096254696"
Circle.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 1),
    NumberSequenceKeypoint.new(0.518931, 0),
    NumberSequenceKeypoint.new(0.699332, 0),
    NumberSequenceKeypoint.new(1, 0)
})

Circle.Parent = Attachment
Circle.Enabled = true

local Beams = Instance.new("ParticleEmitter")

Beams.Name = "Beams"
Beams.Brightness = 9.335
Beams.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.new(0.6, 0.894118, 1)),
    ColorSequenceKeypoint.new(1, Color3.new(0.472546, 0.227451, 0.858824))
})
Beams.Lifetime = NumberRange.new(0.15, 0.15)
Beams.LightEmission = 1
Beams.Rate = 4
Beams.RotSpeed = NumberRange.new(4, 4)
Beams.Rotation = NumberRange.new(-360, 360)
Beams.ShapeInOut = Enum.ParticleEmitterShapeInOut.Inward
Beams.Size = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 0),
    NumberSequenceKeypoint.new(0.598552, 5.0625),
    NumberSequenceKeypoint.new(1, 10)
})
Beams.Speed = NumberRange.new(0, 0)
Beams.Texture = "rbxassetid://8096273877"
Beams.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 1),
    NumberSequenceKeypoint.new(0.518931, 0),
    NumberSequenceKeypoint.new(0.699332, 0),
    NumberSequenceKeypoint.new(1, 0)
})

Beams.Parent = Attachment
Beams.Enabled = true

local HITPE = Instance.new("ParticleEmitter")

HITPE.Name = "HITPE"
HITPE.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.new(1, 0.666667, 1)),
    ColorSequenceKeypoint.new(1, Color3.new(1, 0.666667, 1))
})
HITPE.Drag = 5
HITPE.Lifetime = NumberRange.new(0.3, 0.3)
HITPE.LightEmission = 1
HITPE.Orientation = Enum.ParticleOrientation.VelocityPerpendicular
HITPE.Rate = 30
HITPE.RotSpeed = NumberRange.new(-720, 720)
HITPE.Rotation = NumberRange.new(-720, 720)
HITPE.Size = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 1),
    NumberSequenceKeypoint.new(1, 4)
})
HITPE.Speed = NumberRange.new(0, 1)
HITPE.SpreadAngle = Vector2.new(180, 180)
HITPE.Texture = "http://www.roblox.com/asset/?id=7015983157"
HITPE.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 0),
    NumberSequenceKeypoint.new(1, 1)
})
HITPE.ZOffset = 1

HITPE.Parent = Attachment
HITPE.Enabled = true

local ParticleEmitter = Instance.new("ParticleEmitter")

ParticleEmitter.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.new(1, 0.980392, 0.670588)),
    ColorSequenceKeypoint.new(1, Color3.new(1, 0.980392, 0.670588))
})
ParticleEmitter.Lifetime = NumberRange.new(0.128, 0.128)
ParticleEmitter.LightEmission = 1
ParticleEmitter.Rate = 5
ParticleEmitter.Rotation = NumberRange.new(-360, 360)
ParticleEmitter.Size = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 0),
    NumberSequenceKeypoint.new(1, 5.75)
})
ParticleEmitter.Speed = NumberRange.new(0, 0)
ParticleEmitter.Texture = "http://www.roblox.com/asset/?id=7016047535"
ParticleEmitter.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 0),
    NumberSequenceKeypoint.new(0.629005, 0.83125),
    NumberSequenceKeypoint.new(1, 1)
})
ParticleEmitter.ZOffset = 1.5

ParticleEmitter.Parent = Attachment
ParticleEmitter.Enabled = true

local ParticleEmitter33 = Instance.new("ParticleEmitter")

ParticleEmitter33.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.new(1, 0.980392, 0.670588)),
    ColorSequenceKeypoint.new(1, Color3.new(1, 0.980392, 0.670588))
})
ParticleEmitter33.Lifetime = NumberRange.new(0.128, 0.128)
ParticleEmitter33.LightEmission = 1
ParticleEmitter33.Rate = 5
ParticleEmitter33.Rotation = NumberRange.new(-360, 360)
ParticleEmitter33.Size = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 0),
    NumberSequenceKeypoint.new(1, 5.75)
})
ParticleEmitter33.Speed = NumberRange.new(0, 0)
ParticleEmitter33.Texture = "http://www.roblox.com/asset/?id=7016047535"
ParticleEmitter33.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 0),
    NumberSequenceKeypoint.new(0.629005, 0.83125),
    NumberSequenceKeypoint.new(1, 1)
})
ParticleEmitter33.ZOffset = 1.5

ParticleEmitter33.Parent = Attachment
ParticleEmitter33.Enabled = true
end


do
    local part = Instance.new("Part")
    part.Parent = ReplicatedStorage
    local attachment = Instance.new("Attachment")
    attachment.Name = "Attachment"
    attachment.Parent = part
    HitEffectModule.Locals.Type["Nova"] = attachment

    local function createParticleEmitter(acceleration)
        local emitter = Instance.new("ParticleEmitter")
        emitter.Name = "ParticleEmitter"
        emitter.Acceleration = acceleration
        emitter.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
            ColorSequenceKeypoint.new(0.495, HitEffectModule.Settings.HitEffect.Color),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
        })
        emitter.Lifetime = NumberRange.new(0.5, 0.5)
        emitter.LightEmission = 1
        emitter.LockedToPart = true
        emitter.Rate = 1
        emitter.Rotation = NumberRange.new(0, 360)
        emitter.Size = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1),
            NumberSequenceKeypoint.new(1, 10),
            NumberSequenceKeypoint.new(1, 1)
        })
        emitter.Speed = NumberRange.new(0, 0)
        emitter.Texture = "rbxassetid://1084991215"
        emitter.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0),
            NumberSequenceKeypoint.new(0, 0.1),
            NumberSequenceKeypoint.new(0.534, 0.25),
            NumberSequenceKeypoint.new(1, 0.5),
            NumberSequenceKeypoint.new(1, 0)
        })
        emitter.ZOffset = 1
        emitter.Parent = attachment
        return emitter
    end

    createParticleEmitter(Vector3.new(0, 0, 1))
    local perpendicularEmitter = createParticleEmitter(Vector3.new(0, 1, -0.001))
    perpendicularEmitter.Orientation = Enum.ParticleOrientation.VelocityPerpendicular
end

HitEffectModule.Functions.Effect = function(character, color)
    if not character then return end
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end

    local effectAttachment = HitEffectModule.Locals.Type[TargetAimbot.HitEffectType]:Clone()
    effectAttachment.Parent = humanoidRootPart

    for _, emitter in pairs(effectAttachment:GetChildren()) do
        if emitter:IsA("ParticleEmitter") then
            emitter.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
                ColorSequenceKeypoint.new(0.495, TargetAimbot.HitEffectColor),
                ColorSequenceKeypoint.new(1, TargetAimbot.HitEffectColor)
            })
            
            if TargetAimbot.HitEffect then
                emitter:Emit()
            end
        end
    end

    task.delay(2, function()
        effectAttachment:Destroy()
    end)
end

local function PlayHitSound()
    if TargetAimbot.HitSounds and hitsounds[TargetAimbot.HitSound] then
        local sound = Instance.new("Sound")
        sound.SoundId = hitsounds[TargetAimbot.HitSound]
        sound.Parent = SoundService
        sound:Play()
        sound.Ended:Connect(function()
            sound:Destroy()
        end)
    end
end

local TweenService = game:GetService("TweenService")

local function HitChams(Player)
    if not TargetAimbot.HitChams then return end

    if Player and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
        Player.Character.Archivable = true
        local Cloned = Player.Character:Clone()
        Cloned.Name = "Player Clone"

        local BodyParts = {
            "Head", "UpperTorso", "LowerTorso",
            "LeftUpperArm", "LeftLowerArm", "LeftHand",
            "RightUpperArm", "RightLowerArm", "RightHand",
            "LeftUpperLeg", "LeftLowerLeg", "LeftFoot",
            "RightUpperLeg", "RightLowerLeg", "RightFoot"
        }

        for _, Part in ipairs(Cloned:GetChildren()) do
            if Part:IsA("BasePart") then
                local PartValid = false
                for _, validPart in ipairs(BodyParts) do
                    if Part.Name == validPart then
                        PartValid = true
                        break
                    end
                end
                
                if not PartValid then
                    Part:Destroy()
                end
            elseif Part:IsA("Accessory") or Part:IsA("Tool") or Part.Name == "face" or Part:IsA("Shirt") or Part:IsA("Pants") or Part:IsA("Hat") then
                Part:Destroy()
            end
        end

        if Cloned:FindFirstChild("Humanoid") then
            Cloned.Humanoid:Destroy()
        end

        for _, BodyPart in ipairs(Cloned:GetChildren()) do
            if BodyPart:IsA("BasePart") then
                BodyPart.CanCollide = false
                BodyPart.Anchored = true
                BodyPart.Transparency = TargetAimbot.HitChamsTransparency
                BodyPart.Color = TargetAimbot.HitChamsColor
                BodyPart.Material = TargetAimbot.HitChamsMaterial
            end
        end

        if Cloned:FindFirstChild("Head") then
            local Head = Cloned.Head
            Head.Transparency = TargetAimbot.HitChamsTransparency
            Head.Color = TargetAimbot.HitChamsColor
            Head.Material = TargetAimbot.HitChamsMaterial

            if Head:FindFirstChild("face") then
                Head.face:Destroy()
            end
        end

        Cloned.Parent = game.Workspace

        local tweenInfo = TweenInfo.new(
            TargetAimbot.HitChamsDuration,
            Enum.EasingStyle.Sine,
            Enum.EasingDirection.InOut,
            0,
            true
        )

        for _, BodyPart in ipairs(Cloned:GetChildren()) do
            if BodyPart:IsA("BasePart") then
                local tween = TweenService:Create(BodyPart, tweenInfo, { Transparency = 1 })
                tween:Play()
            end
        end

        task.delay(TargetAimbot.HitChamsDuration, function()
            if Cloned and Cloned.Parent then
                Cloned:Destroy()
            end
        end)
    end
end

local target_health = nil

local function updatetarget_health()
    if TargBindEnabled and TargetPlr and TargetPlr.Character then
        local humanoid = TargetPlr.Character:FindFirstChild("Humanoid")
        if humanoid then
            local currentHealth = humanoid.Health
            if currentHealth < target_health then
                if Hitnotify then
                    Menu.Notify('Cactus<font color="#90EE90">.GG [khen.cc]</font>  >  ' .. '+1 Hit | ' .. tostring(getgenv().Sentinel.SelectedPart) .. ' | Target : ' .. TargetPlr.DisplayName, 1.5)
                end
                
                PlayHitSound()
                HitEffectModule.Functions.Effect(TargetPlr.Character)
                HitChams(TargetPlr)
            end
            target_health = currentHealth
        end
    end
end


RunService.RenderStepped:Connect(function()
    if TargetAimbot.Enabled and TargBindEnabled and TargetAimbot.Highlight and TargetPlr and TargetPlr.Character and Highlight then
        TargHighlight.FillColor = TargetAimbot.HighlightColor1
TargHighlight.OutlineColor = TargetAimbot.HighlightColor2
TargHighlight.Adornee = TargetPlr.Character
        TargHighlight.Enabled = true
    else
        TargHighlight.Adornee = nil
        TargHighlight.Enabled = false
    end
end)




local Saved
local Client = game.Players.LocalPlayer
local Camera = workspace.CurrentCamera
local nigga = {}
local IgnoreFolder = Instance.new("Folder", game:GetService("Workspace"))
local desync_setback = Instance.new("Part")
desync_setback.Name = "im a skibidi rizzler";
desync_setback.Parent = workspace;
desync_setback.Size = Client.Character.Humanoid.RootPart.Size;
desync_setback.CanCollide = false; 
desync_setback.Anchored = true; 
desync_setback.Transparency = 1; 
 nigga["CFrameVisualize"] = game:GetObjects("rbxassetid://9474737816")[1]; nigga["CFrameVisualize"].Head.Face:Destroy(); for _, v in pairs(nigga["CFrameVisualize"]:GetChildren()) do v.Transparency = v.Name == "HumanoidRootPart" and 1 or 0.70; v.Material = "Neon"; v.Color = Color3.fromRGB(153,0,153); v.CanCollide = false; v.Anchored = false end
game:GetService('RunService').Heartbeat:Connect(function()
 nigga["CFrameVisualize"].Parent = TargetAimbot.CSync.Enabled and IgnoreFolder or nil
    if TargetAimbot.CSync.Enabled and TargetPlr then
        local FakeCFrame = Client.Character.HumanoidRootPart.CFrame
        Saved = Client.Character.HumanoidRootPart.CFrame
        if TargBindEnabled and TargetAimbot.CSync.Type == "Random" then
            FakeCFrame = CFrame.new(TargetPlr.Character.HumanoidRootPart.Position + Vector3.new(math.random(-TargetAimbot.CSync.RandomAmount, TargetAimbot.CSync.RandomAmount), math.random(-0, TargetAimbot.CSync.RandomAmount), math.random(-TargetAimbot.CSync.RandomAmount, TargetAimbot.CSync.RandomAmount))) * CFrame.Angles(math.rad(math.random(0, 360)), math.rad(math.random(0, 360)), math.rad(math.random(0, 360)))
        elseif TargBindEnabled and TargetAimbot.CSync.Type == "Orbit" then
        local CurrentTime = tick()
            FakeCFrame = CFrame.new(TargetPlr.Character.HumanoidRootPart.Position) * CFrame.Angles(0, 2 * math.pi * CurrentTime * TargetAimbot.CSync.Speed % (2 * math.pi), 0) * CFrame.new(0, TargetAimbot.CSync.Height, TargetAimbot.CSync.Distance)
        end

        nigga["CFrameVisualize"]:SetPrimaryPartCFrame(FakeCFrame)

        for _, Part in pairs(nigga["CFrameVisualize"]:GetChildren()) do
            Part.Color = TargetAimbot.CSync.Color
            print("leak by khen.cc")
        end

        Client.Character.HumanoidRootPart.CFrame = FakeCFrame

        game:GetService("RunService").RenderStepped:Wait()

        desync_setback.Position = Saved.Position + Vector3.new(0, 1.5, 0)
        
        if TargBindEnabled then
            Camera.CameraSubject = desync_setback
        else
            Camera.CameraSubject = LocalPlayer.Character.Humanoid
        end
        Client.Character.HumanoidRootPart.CFrame = Saved
        print("khen.cc")
    end
end)


local FOV43 = Drawing.new("Circle")
FOV43.Transparency = 0.5
FOV43.Thickness = 2
FOV43.Color = Color3.new(1, 0, 0)
FOV43.Filled = false
FOV43.Radius = 250
FOV43.Position = Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y / 2)
FOV43.Visible = false


local Sigmaballs = Instance.new("ScreenGui")
Sigmaballs.Name = "Sigmaballs"
Sigmaballs.Parent = game.CoreGui
Sigmaballs.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Sigmaballs.ResetOnSpawn = false

local Button = Instance.new("TextButton")
Button.Name = "FlyButton"
Button.Parent = Sigmaballs
Button.Active = true
Button.Draggable = true
Button.BackgroundColor3 = Color3.fromRGB(28, 28, 48)
Button.BackgroundTransparency = 0
Button.BorderSizePixel = 0
Button.Size = UDim2.new(0, 150, 0, 50)
Button.Position = UDim2.new(0.5, -75, 0.5, -25)
Button.Font = Enum.Font.ArialBold
Button.Text = "Lock: " .. "<font color='rgb(255, 0, 0)'>OFF</font>"
Button.TextColor3 = Color3.fromRGB(255, 255, 255)
Button.TextSize = 25
Button.RichText = true
Button.TextStrokeTransparency = 0.5

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = Button

local UIStroke = Instance.new("UIStroke")
UIStroke.Parent = Button
UIStroke.Thickness = 2
UIStroke.Color = Color3.fromRGB(16, 16, 32)


local stk = Instance.new("UIStroke")
stk.Parent = Button
stk.Thickness = 3
stk.Color = Color3.fromRGB(16, 16, 32)
stk.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    



function SigmaOhioPlayer()
    local closestPlayer
    local shortestDistance = math.huge
    local player = game.Players.LocalPlayer
    local CC = game:GetService("Workspace").CurrentCamera
    local screenCenter = Vector2.new(CC.ViewportSize.X / 2, CC.ViewportSize.Y / 2)
    local fovRadius = FOV43.Radius
    local viewportSize = CC.ViewportSize

    for i, v in pairs(game.Players:GetPlayers()) do
        if v ~= player and v.Character and v.Character:FindFirstChild("Humanoid") 
           and v.Character.Humanoid.Health > 0 and v.Character:FindFirstChild("HumanoidRootPart") then
            local pos, onScreen = CC:WorldToViewportPoint(v.Character.PrimaryPart.Position)
            
            if onScreen and pos.X > 0 and pos.Y > 0 
               and pos.X < viewportSize.X and pos.Y < viewportSize.Y then
                local magnitude = (Vector2.new(pos.X, pos.Y) - screenCenter).magnitude
                if magnitude < fovRadius and magnitude < shortestDistance then
                    closestPlayer = v
                    shortestDistance = magnitude
                end
            end
        end
    end
    
    return closestPlayer
end



local enabled = false


toggle_lock = function()
    if TargetAimbot.Enabled then
        local closest = SigmaOhioPlayer()
        if TargBindEnabled and TargetPlr then
            TargBindEnabled = false
            target_health = nil
            TargetPlr = nil
            Workspace.CurrentCamera.CameraSubject = LocalPlayer.Character.Humanoid
            if TargetAimbot.LookAt then
                LocalPlayer.Character.Humanoid.AutoRotate = true
            end
            Button.Text = "Lock: " .. "<font color='rgb(255, 0, 0)'>OFF</font>"
            Menu.Notify("Untargeted", 2)
        else
            TargBindEnabled = true
            TargetPlr = closest
            if TargetPlr.Character and TargetPlr.Character:FindFirstChild("Humanoid") then
                target_health = TargetPlr.Character.Humanoid.Health
            else
                return
            end
            Button.Text = "Lock: " .. "<font color='rgb(0, 255, 0)'>ON</font>"
            Menu.Notify("Target Locked: " .. tostring(TargetPlr.DisplayName), 2)
        end
    end
end

Button.MouseButton1Click:Connect(toggle_lock)


UserInputService.InputBegan:Connect(function(input, processed)
    if not processed and input.KeyCode == Enum.KeyCode.DPadDown then
        toggleLock()
    end
end)



getgenv().Sentinel.LockType = "Namecall"
getgenv().Sentinel.RESOLVER = "MoveDirection"

local game_support = loadstring(game:HttpGet("https://raw.githubusercontent.com/khenn791/script-khen/refs/heads/main/Argument.txt",true))()

local function getRemoteInfo()
    local placeId = game.PlaceId
    return game_support[placeId] or {Remote = "MainEvent", Argument = "UpdateMousePos"}
end

local function predictedposition()
    local selectedPart = getgenv().Sentinel.SelectedPart
    local targetPart = TargetPlr.Character[selectedPart]

    if targetPart then
        local velocity
        if not getgenv().Sentinel.ResolverEnabled then
            velocity = targetPart.Velocity
        else
            if getgenv().Sentinel.RESOLVER == "MoveDirection" then
                velocity = TargetPlr.Character.Humanoid.MoveDirection * TargetPlr.Character.Humanoid.WalkSpeed
            elseif getgenv().Sentinel.RESOLVER == "LookVector" then
                velocity = targetPart.CFrame.LookVector * getgenv().Sentinel.HorizontalPrediction * 1.2
            else
                velocity = targetPart.Velocity
            end
        end

        local horizontalPrediction = getgenv().Sentinel.HorizontalPrediction

        local predictedPosition = Vector3.new(
            targetPart.Position.X + (velocity.X * horizontalPrediction),
            targetPart.Position.Y,
            targetPart.Position.Z + (velocity.Z * horizontalPrediction)
        )

        return predictedPosition
    end
end

RunService.PostSimulation:Connect(function(DeltaTime)
    if Sentinel.Enabled then
        if Sentinel.LockType == "Index" then
            local LocalPlayer = game.Players.LocalPlayer
            local LocalFramework = LocalPlayer.PlayerGui:WaitForChild("Framework", 1e9)

            if LocalFramework then
                local FrameworkEnvironment = getsenv(LocalFramework)

                if FrameworkEnvironment._G and FrameworkEnvironment._G.MOUSE_POSITION then
                    if TargetPlr then
                        FrameworkEnvironment._G.MOUSE_POSITION = predictedposition() 
                    end
                end
            end
        end
    end
end)


local remoteInfo = getRemoteInfo()
local mt = getrawmetatable(game)
local old = mt.__namecall
setreadonly(mt, false)

local Vect3 = Vector3.new


do -- // Hooking
    __namecall = hookmetamethod(game, "__namecall", newcclosure(function(Self, ...)
        local args, method = {...}, tostring(getnamecallmethod())

        if not checkcaller() and method == "FireServer" then
            for i, arg in pairs(args) do
                if typeof(arg) == "Vector3" then
                    if TargetPlr and getgenv().Sentinel.Enabled and getgenv().Sentinel.LockType == "Namecall" then
                        local selectedPart = getgenv().Sentinel.SelectedPart
                        local targetPart = TargetPlr.Character[selectedPart]

                        if targetPart then
                            local velocity
                            if getgenv().Sentinel.ResolverEnabled then
                                if getgenv().Sentinel.RESOLVER == "MoveDirection" then
                                    velocity = TargetPlr.Character.Humanoid.MoveDirection * TargetPlr.Character.Humanoid.WalkSpeed
                                elseif getgenv().Sentinel.RESOLVER == "LookVector" then
                                    velocity = targetPart.CFrame.LookVector * getgenv().Sentinel.HorizontalPrediction * 1.0
                                else
                                    velocity = targetPart.Velocity
                                end
                            else
                                velocity = targetPart.Velocity
                            end

                            local horizontalPrediction = getgenv().Sentinel.HorizontalPrediction

                            args[i] = targetPart.Position + (targetPart.Velocity * horizontalPrediction)
                        end
                    end
                    return __namecall(Self, unpack(args))
                elseif type(arg) == "table" then
                    for index, element in ipairs(arg) do
                        if typeof(element) == "Vector3" then
                            if TargetPlr and getgenv().Sentinel.Enabled and getgenv().Sentinel.LockType == "Namecall" then
                                local selectedPart = getgenv().Sentinel.SelectedPart
                                local targetPart = TargetPlr.Character[selectedPart]

                                if targetPart then
                                    local velocity
                                    if getgenv().Sentinel.ResolverEnabled then
                                        if getgenv().Sentinel.RESOLVER == "MoveDirection" then
                                            velocity = TargetPlr.Character.Humanoid.MoveDirection * TargetPlr.Character.Humanoid.WalkSpeed
                                        elseif getgenv().Sentinel.RESOLVER == "LookVector" then
                                            velocity = targetPart.CFrame.LookVector * getgenv().Sentinel.HorizontalPrediction * 1.0
                                        else
                                            velocity = targetPart.Velocity
                                        end
                                    else
                                        velocity = targetPart.Velocity
                                    end

                                    local horizontalPrediction = getgenv().Sentinel.HorizontalPrediction

                                    arg[index] = targetPart.Position + (targetPart.Velocity * horizontalPrediction)
                                end
                            end
                        end
                    end
                end
            end
            return __namecall(Self, unpack(args))
        end

        return __namecall(Self, ...)
    end))
end



local players = game:GetService("Players")
local client = players.LocalPlayer
local function AutoShoot()
    if TargetPlr then
        local character = client.Character
        if character then
            local tool = character:FindFirstChildOfClass("Tool")
            if tool and tool:IsA("Tool") then
                tool:Activate()
            end
        end
    end
end



local targetSigm99928 = getgenv().Sentinel.ShootDelay 
local targetSigmaPOBALLs = nil
local Shot2ing = false

local function checkTarget()
    if TargetPlr and TargetPlr.Character then
        local humanoid = TargetPlr.Character:FindFirstChildOfClass("Humanoid")
        local humanoidRootPart = TargetPlr.Character:FindFirstChild("HumanoidRootPart")

        if humanoid and humanoidRootPart then
            local SigmaAir = humanoid:GetState() == Enum.HumanoidStateType.Freefall

            if SigmaAir and getgenv().Sentinel.AutoAir then
                if not targetSigmaPOBALLs then
                    targetSigmaPOBALLs = tick()
                else
                    local airDuration = tick() - targetSigmaPOBALLs
                    if airDuration >= targetSigm99928 then
                        if not Shot2ing then
                            Shot2ing = true
                            while TargetPlr and TargetPlr.Character and SigmaAir do
                                AutoShoot()
                                wait(0.001)

                                SigmaAir = humanoid:GetState() == Enum.HumanoidStateType.Freefall

                                if not SigmaAir then
                                    Shot2ing = false
                                    targetSigmaPOBALLs = nil -- Reset the start time
                                    break
                                end
                            end
                            Shot2ing = false
                        end
                    end
                end
            else
                targetSigmaPOBALLs = nil
                Shot2ing = false
            end
        end
    end
end


local predictionTable =  {
    {20, 0.08960952},
    {30, 0.11252476},
    {50, 0.13544},
    {65, 0.1264236},
    {70, 0.12533},
    {80, 0.139340},
    {100, 0.141987},
    {110, 0.144634},
    {120, 0.147281},
    {130, 0.149928},
    {140, 0.152575},
    {150, 0.155222},
    {160, 0.157869},
    {170, 0.160516},
    {180, 0.163163},
    {190, 0.165810},
    {200, 0.168457},
    {210, 0.171104},
    {220, 0.173751},
    {230, 0.176398},
    {240, 0.179045},
    {250, 0.181692},
    {260, 0.184339},
    {270, 0.186986},
    {280, 0.189633},
    {290, 0.192280},
    {300, 0.194927}
}

local sigma_table = {
    {0, 0.04070},
    {30, 0.05078}
}
local function updatePredictionValue()
    if getgenv().Sentinel.AutoPrediction then
        local pingValue = Stas.Network.ServerStatsItem["Data Ping"]:GetValueString()
        local split = string.split(pingValue, '(')
        local ping = tonumber(split[1])

        if ping then
            if getgenv().Sentinel.AutoPredMode == "PingBased" then
                local closestPingDiff = math.huge
                local closestValue = nil

                for i = 1, #predictionTable do
                    local tablePing = predictionTable[i][1]
                    local tableValue = predictionTable[i][2]

                    local pingDiff = math.abs(ping - tablePing)

                    if pingDiff < closestPingDiff then
                        closestPingDiff = pingDiff
                        closestValue = tableValue
                    end
                end

                if closestValue then
                    getgenv().Sentinel.HorizontalPrediction = closestValue
                    getgenv().Sentinel.VerticalPrediction = closestValue * 0.8
                end
            end
        end
    end
end

function LookAtPlayer(Target)
    local localChar = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
    local localHumanoidRootPart = localChar:FindFirstChild("HumanoidRootPart")

    if localHumanoidRootPart then
        if getgenv().Sentinel and getgenv().Sentinel.LookAt and not MCenabled then
            if Target and Target.Character and Target.Character:FindFirstChild("HumanoidRootPart") then
                local targetHumanoidRootPart = Target.Character.HumanoidRootPart
                
                local targetPosition = targetHumanoidRootPart.Position
                local localPosition = localHumanoidRootPart.Position
                
                local horizontalDirection = Vector3.new(targetPosition.X - localPosition.X, 0, targetPosition.Z - localPosition.Z).unit
                
                localHumanoidRootPart.CFrame = CFrame.new(localPosition, localPosition + horizontalDirection)
                localChar.Humanoid.AutoRotate = false
            end
        else
            localChar.Humanoid.AutoRotate = true
        end
    end
    
    if not (Target and Target.Character and Target.Character:FindFirstChild("HumanoidRootPart")) then
        localChar.Humanoid.AutoRotate = true
    end
end

local function NearestPart(TargetPlr)
    local BodyParts = {
        "Head", "UpperTorso", "LowerTorso", 
        "LeftUpperArm", "LeftLowerArm", "LeftHand", 
        "RightUpperArm", "RightLowerArm", "RightHand", 
        "LeftUpperLeg", "LeftLowerLeg", "LeftFoot", 
        "RightUpperLeg", "RightLowerLeg", "RightFoot"
    }

    local selectedPartName = getgenv().Sentinel.SelectedPart

    if TargetPlr and TargetPlr.Character then
        if getgenv().Sentinel.NearestPart then
            local minDistance = math.huge
            local nearestPart = nil
            
            for _, partName in pairs(BodyParts) do
                local part = TargetPlr.Character:FindFirstChild(partName)
                if part then
                    local distance = (part.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                    if distance < minDistance then
                        minDistance = distance
                        nearestPart = part
                    end
                end
            end
            
            if nearestPart then
                getgenv().Sentinel.SelectedPart = nearestPart.Name
            end
        else
            getgenv().Sentinel.SelectedPart = selectedPartName
        end
    end
end


function inAir()
    if TargetPlr and TargetPlr.Character and TargetPlr.Character:FindFirstChild("Humanoid") then
        local SigmaTuah = TargetPlr.Character.Humanoid:GetState() == Enum.HumanoidStateType.Freefall
        if SigmaTuah then
            getgenv().Sentinel.jumpoffset = getgenv().Sentinel.jumpoffset2
        else
            getgenv().Sentinel.jumpoffset = 0
        end
    end
end



RunService.Stepped:Connect(function()
    updatePredictionValue()
    checkTarget()
    updatetarget_health()
    LookAtPlayer(TargetPlr)
    NearestPart(TargetPlr)
    inAir()
    if not getgenv().Sentinel.AutoPrediction then
        getgenv().Sentinel.HorizontalPrediction2 = getgenv().Sentinel.HorizontalPrediction2
        getgenv().Sentinel.VerticalPrediction = getgenv().Sentinel.HorizontalPrediction2
    end
end)

RunService.Heartbeat:Connect(function()
    if Script.Locals.GrenadeTP.Enabled and TargetPlr and TargetPlr.Character and workspace:FindFirstChild("Ignored") then
        if workspace.Ignored:FindFirstChild("Handle") then
            workspace.Ignored.Handle.Position = TargetPlr.Character[getgenv().Sentinel.SelectedPart].Position + (TargetPlr.Character[getgenv().Sentinel.SelectedPart].Velocity * getgenv().Sentinel.HorizontalPrediction)
        end
    end
end)

if workspace:FindFirstChild("Ignored") then
    workspace.Ignored.ChildAdded:Connect(function(object)
        if Script.Locals.RocketTP.Enabled and 
           TargetPlr and 
           TargetPlr.Character and 
           (object.Name == "Model" or object.Name == "GrenadeLauncherAmmo") then
            
            local SkibidiGrenadeLauncher = object.Name == "GrenadeLauncherAmmo"
            local part = SkibidiGrenadeLauncher and object:WaitForChild("Main") or object:WaitForChild("Launcher")
            
            part.CFrame = CFrame.new(1, 1, 1)
            
            if not SkibidiGrenadeLauncher then
                part.BodyVelocity:Destroy()
                part.TouchInterest:Destroy()
            end
            
            local connection
            connection = RunService.PostSimulation:Connect(function()
                if TargetPlr and TargetPlr.Character then
                    part.CFrame = TargetPlr.Character.HumanoidRootPart.CFrame
                    part.Velocity = Vector3.new(0, 0.001, 0)
                end
            end)
            
            object.Destroying:Connect(function()
                connection:Disconnect()
            end)
        end
    end)
end

RunService.Heartbeat:Connect(function()
    if getgenv().Sentinel.Camera and TargetPlr and TargetPlr.Character and getgenv().Sentinel.SelectedPart then
        local camera = Workspace.CurrentCamera
        local selectedPart = getgenv().Sentinel.SelectedPart
        local targetPart = TargetPlr.Character[selectedPart]

        if targetPart then
            local velocity
            if getgenv().Sentinel.ResolverEnabled then
                if getgenv().Sentinel.RESOLVER == "MoveDirection" then
                    velocity = TargetPlr.Character.Humanoid.MoveDirection * TargetPlr.Character.Humanoid.WalkSpeed
                elseif getgenv().Sentinel.RESOLVER == "LookVector" then
                    velocity = targetPart.CFrame.LookVector * getgenv().Sentinel.HorizontalPrediction * 1.0
                else
                    velocity = targetPart.Velocity
                end
            else
                velocity = targetPart.Velocity
            end

            local jumpOffset = getgenv().Sentinel.jumpoffset or 0
            local fallOffset = getgenv().Sentinel.FallOffset or 0

            local verticalVelocity = velocity.Y
            local appliedVerticalOffset = verticalVelocity > 0 and jumpOffset or (verticalVelocity < 0 and -fallOffset or 0)

            local horizontalPrediction = getgenv().Sentinel.HorizontalPrediction
            local verticalPrediction = getgenv().Sentinel.VerticalPrediction

            local targetPosition = Vector3.new(
                targetPart.Position.X + (velocity.X * horizontalPrediction),
                targetPart.Position.Y + (velocity.Y * verticalPrediction) + appliedVerticalOffset,
                targetPart.Position.Z + (velocity.Z * horizontalPrediction)
            )

            local smoothness = getgenv().Sentinel.smoothness or 0.1
            local easingStyle = Enum.EasingStyle[getgenv().Sentinel.easingStyle] or Enum.EasingStyle.Quad
            local easingDirection = Enum.EasingDirection[getgenv().Sentinel.easingDirection] or Enum.EasingDirection.In

            camera.CFrame = camera.CFrame:Lerp(CFrame.new(camera.CFrame.Position, targetPosition), smoothness, easingStyle, easingDirection)
        end
    end
end)

local Plr = game.Players.LocalPlayer

Plr.Character:WaitForChild("Humanoid").StateChanged:Connect(function(old, new)
    if getgenv().Sentinel.JumpBreak and new == Enum.HumanoidStateType.Freefall then
        wait(0.27)
        Plr.Character.HumanoidRootPart.Velocity = Vector3.new(0, -15, 0)
    end
end)


game:GetService("RunService").heartbeat:Connect(function()
    if getgenv().Desync == true then
        local abc = game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity

        if getgenv().AntiLockType == "Behind" then
            getgenv().Direction = Vector3.new(0, 0, -1)
        elseif getgenv().AntiLockType == "Down" then
            getgenv().Direction = Vector3.new(0, -1, 0)
        elseif getgenv().AntiLockType == "ForWard" then
            getgenv().Direction = Vector3.new(0, 0, 1)
        elseif getgenv().AntiLockType == "Left" then
            getgenv().Direction = Vector3.new(-1, 0, 0)
        elseif getgenv().AntiLockType == "One" then
            getgenv().Direction = Vector3.new(1, 1, 1)
        elseif getgenv().AntiLockType == "Right" then
            getgenv().Direction = Vector3.new(1, 0, 0)
        elseif getgenv().AntiLockType == "Up" then
            getgenv().Direction = Vector3.new(0, 1, 0)
        elseif getgenv().AntiLockType == "Zero" then
            getgenv().Direction = Vector3.new(0, 0, 0)
        end
        
        game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = getgenv().Direction * (2^16)
        game:GetService("RunService").RenderStepped:Wait()
        game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = abc
    end
end)

local Client = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local boolattp = true
local cframe_to_offset = function(origin, target)
    local actual_origin = origin * CFrame.new(Script.Locals.GunTP.Offset[1], Script.Locals.GunTP.Offset[2], Script.Locals.GunTP.Offset[3], 1, 0, 0, 0, 0, 1, 0, -1, 0)
    return actual_origin:ToObjectSpace(target):inverse();
end

local something_tp = function(Tool)
    local old_grip = Tool.Grip
    if TargetPlr and TargetPlr.Character then
        Tool.Parent = Client.Backpack
        Client.Character.RightHand.Anchored = false
        Tool.Grip = cframe_to_offset(Client.Character.RightHand.CFrame, TargetPlr.Character.HumanoidRootPart.CFrame)
        Client.Character.RightHand.Anchored = true
        Tool.Parent = Client.Character
        RunService.RenderStepped:Wait()
        Tool.Parent = Client.Backpack
        Client.Character.RightHand.Anchored = false
        Tool.Grip = old_grip
        Tool.Parent = Client.Character
    end
end

local bullet_teleport = function(Character)
    Character.ChildAdded:Connect(function(Child)
        if Script.Locals.GunTP.Enabled then
            if Child:IsA("Tool") then
                local Connection
                Connection = Child.Activated:Connect(function()
                    something_tp(Child)
                end)

                Character.ChildRemoved:Connect(function(RemovedChild)
                    if RemovedChild == Child then
                        Connection:Disconnect()
                    end
                end)
            end
        end
    end)
end

bullet_teleport(Client.Character)

Client.CharacterAdded:Connect(function()
bullet_teleport(Client.Character)
end)

game:GetService("RunService").RenderStepped:Connect(
    function()
        if Settings.Combat.Spectate and TargetPlr then
game.Workspace.CurrentCamera.CameraSubject = TargetPlr.Character
   else
game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
       end;
end);

RunService.Heartbeat:Connect(function()
    if Plr.Character and Plr.Character:FindFirstChild("HumanoidRootPart") then
        if getgenv().Sentinel and getgenv().Sentinel.network then
            sethiddenproperty(Plr.Character.HumanoidRootPart, "NetworkIsSleeping", true)
            task.wait()
            sethiddenproperty(Plr.Character.HumanoidRootPart, "NetworkIsSleeping", false)
            setfflag("S2PhysicsSenderRate", 2)
        else
            setfflag("S2PhysicsSenderRate", 13)
            sethiddenproperty(Plr.Character.HumanoidRootPart, "NetworkIsSleeping", false)
        end
    end
end)