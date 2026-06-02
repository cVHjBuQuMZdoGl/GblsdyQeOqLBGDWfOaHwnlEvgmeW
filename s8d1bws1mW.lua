local Library = loadstring(game:HttpGet("https://pastebin.com/raw/kpLzpNXc"))()  

settings = {
   enabled = false; -- / true / false
   minCameraDistance = 1; -- / any number
   hatTransparency = .35; -- / 0 - 1 (0 being invisible)
   circleTransparency = 1; -- / 0 - 1 (0 being invisible)
   height = .75; -- / any number
   radius = 1; -- /-- any number
   sides = 25; -- / any number
   rainbow = false; -- / true / false
   color = Color3.fromRGB(128,18,255); -- / 0-255,0-255,0-255
   offset = Vector3.new(0,.75,0); -- / number,number,number (studs offset from head center)
}

local runservice = game:GetService('RunService');
local lplr = game:GetService('Players').LocalPlayer
local camera = workspace.CurrentCamera;
local tau = math.pi*2
local drawings = {};

for i = 1,settings.sides do
   drawings[i] = {Drawing.new('Line'),Drawing.new('Triangle')}
   drawings[i][1].ZIndex = 2;
   drawings[i][1].Thickness = 2;
   drawings[i][2].ZIndex = 1;
   drawings[i][2].Filled = true;
end

runservice.RenderStepped:Connect(function()
   local pass = settings.enabled and lplr.Character and lplr.Character:FindFirstChild('Head') ~= nil and (camera.CFrame.p - camera.Focus.p).magnitude > settings.minCameraDistance and lplr.Character.Humanoid.Health > 0
   for i = 1,#drawings do
       local line,triangle = drawings[i][1], drawings[i][2];
       if pass then
           local color = settings.rainbow and Color3.fromHSV((tick() % 5 / 5 - (i / #drawings)) % 1,.5,1) or settings.color;
           local pos = lplr.Character.Head.Position + settings.offset;
           local topWorld = pos + Vector3.new(0,settings.height,0);

           local last, next = (i/settings.sides)*tau, ((i+1)/settings.sides)*tau;
           local lastWorld = pos + (Vector3.new(math.cos(last),0,math.sin(last))*settings.radius);
           local nextWorld = pos + (Vector3.new(math.cos(next),0,math.sin(next))*settings.radius);
           local lastScreen = camera:WorldToViewportPoint(lastWorld);
           local nextScreen = camera:WorldToViewportPoint(nextWorld);
           local topScreen = camera:WorldToViewportPoint(topWorld);

           line.From = Vector2.new(lastScreen.X,lastScreen.Y);
           line.To = Vector2.new(nextScreen.X,nextScreen.Y);
           line.Color = color;
           line.Transparency = settings.circleTransparency;
           line.Visible = true;

           triangle.PointA = Vector2.new(topScreen.X,topScreen.Y);
           triangle.PointB = line.From;
           triangle.PointC = line.To;
           triangle.Color = color;
           triangle.Transparency = settings.hatTransparency;
           triangle.Visible = true;
       else
           line.Visible = false;
           triangle.Visible = false;
       end
   end
end)

getgenv().LuaHVH = {
    target = {
        Enabled = false,
        Locking,
        JumpOffset = 0.06,
        RealJumpOffset = 0.06,
        Prediction = 0.13322,
        Notifications = false,
        Part = 'HumanoidRootPart',
        RandomHP = false,
        UnlockedOnKnocked = false,
        Forcefield = false,
        FakeHitbox = false,
        Dot = false,
        Tracer = false,
        LookAt = false,
        VisibleCheck = false,
        Key = 'c',
        healthonplr = false,
        AutoSetup = false,
        Ben = false,
        GoTo = false,
        Highlight = false,
        HighlightFill = Color3.fromRGB(255,255,255),
        HighlightOutline = Color3.fromRGB(251,255,255),
        ffcolor = Color3.fromRGB(255,255,255),
        fhbcolor = Color3.fromRGB(255,255,255),
        dotcolor = Color3.fromRGB(255,255,255), 
        tracercolor = Color3.fromRGB(255,255,255),
        speed = 0,
        height = 0,
        distance = 0,
        target_strafe = false
},
  CamLock = {
    Enabled = false,
    Prediction = 0.1413,
    AutoPrediction = false,
    Resolver = false,
    Smoothness = 0,
    ShakeValue = 12,
    Part = "Head",
    RandomHP = false,
    AutoSetup = false,
    Wallcheck = false,
    GrabbedCheck = false,
    KnockedCheck = false,
    VisibleCheck = false
    },
    RageBot = {
        Enabled = false,
        Distance = 50, 
        AimPart = "Head",
        LookAt  = false, 
        Resolver = false
    },
  Misc = {
   Speed = false,
   SpeedType = "BHop",
   LolSpeed = 50,
   Spinbot = false,
   SpinSpeed = 50,
   AntiBag = false, 
   AutoReload = false,
   PickUpMoney = false, 
   AntiStomp = false,
   Bhop = false,
   FakeMacro = false, -- // Kinda Legit
   CustomGunSFX = false, 
   ID = "rbxassetid://6607204501",
   Volume = 10
    }, 
  Visual = {
   LocalCham = true,
   GunCham = true,
   GunColor = Color3.fromRGB(255,255,255),
   Highlight = true,
   HighlightFillColor = Color3.fromRGB(255,0,0),
   HighlightOutlineColor = Color3.fromRGB(255,255,255),
   CloneChams = false,
   CloneColor = Color3.fromRGB(255,255,255),
   CloneMaterial = "ForceField",
   CloneDuration = 0.2,
   TrailColor = Color3.fromRGB(255,255,251),
   CustomFOV = false,
   FOV = 100,
   Ratio = false,
   RatioValue = 24,
   CustomAmbient = false,
   Ambient = Color3.fromRGB(255,255,255),
   OutdoorAmbient = Color3.fromRGB(255,255,255)
  },
  Cursor = {
   Spinning = false,
   Rainbow = false, 
   SpinSpeed = 1
   },
}

local LuaHVH_visuals = { 
    Forcefield = { 
        Color = Color3.fromRGB(255,255,255),
        Size = Vector3.new(14, 14, 14),
        Material = 'ForceField'
    },

    Dot = { 
        Color = Color3.fromRGB(255,255,255),
        Size = Vector3.new(0.9, 1.2, 0.9),
        DotOrigin = 'LowerTorso',
        Material = 'Neon'
    },
    FakeHitbox = { 
        Color = Color3.fromRGB(255,255,255),
        Size = Vector3.new(5, 5, 5),
        Material = 'ForceField'
    },

    Tracer = { 
        TracerThickness = 3.5,
        TracerTransparency = 1,
        TracerColor = Color3.fromRGB(255,255,255)
    }
}

local LocalPlayer = game.Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local CurrentCamera = workspace.CurrentCamera 
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LuaHVH_victim = nil
local Inset = game:GetService("GuiService"):GetGuiInset().Y
local Line = Drawing.new("Line")
local LuaHVH_aimbot_victim

 -- parent is workspace :GHASP:
local Forcefield = Instance.new("Part", game.Workspace)

Forcefield.Size = LuaHVH_visuals.Forcefield.Size 
Forcefield.CanCollide = false 
Forcefield.Anchored = true
Forcefield.Shape = Enum.PartType.Ball
Forcefield.Transparency = 1
Forcefield.Name = "beg"


local Dot = Instance.new("Part", game.Workspace)

Dot.Size = LuaHVH_visuals.Dot.Size
Dot.CanCollide = false
Dot.Anchored = true
Dot.Shape = Enum.PartType.Ball 
Dot.Name = "LorisKJiggaboo"

local Hitbox = Instance.new("Part", game.Workspace)

Hitbox.Size = LuaHVH_visuals.FakeHitbox.Size
Hitbox.CanCollide = false 
Hitbox.Anchored = true
Hitbox.Shape = Enum.PartType.Block 
Hitbox.Name = "LorisNigger"

spawn(function()
    RunService.Stepped:Connect(function()
        Forcefield.Material = LuaHVH_visuals.Forcefield.Material 
        Dot.Material = LuaHVH_visuals.Dot.Material
        Hitbox.Material = LuaHVH_visuals.FakeHitbox.Material
    end)
end)

spawn(function()
    RunService.Heartbeat:Connect(function()
        if LuaHVH.target.Enabled and LuaHVH.target.Locking and LuaHVH.target.Forcefield then
            Forcefield.Transparency = 0 
        else
            Forcefield.Transparency = 1
        end
    
        if LuaHVH.target.Enabled and LuaHVH.target.Forcefield and LuaHVH.target.Locking then
            Forcefield.CFrame = CFrame.new(LuaHVH_victim.Character[LuaHVH.target.Part].Position)
        else
            Forcefield.CFrame = CFrame.new(0, 0, 0)
        end
        
        Forcefield.Color = LuaHVH.target.ffcolor
    
    
        if LuaHVH.target.Enabled and LuaHVH.target.Locking and LuaHVH.target.Dot then
            Dot.Transparency = 0
        else
            Dot.Transparency = 1 
        end
    
        if LuaHVH.target.Enabled and LuaHVH.target.Locking and LuaHVH.target.Dot then
            Dot.CFrame = CFrame.new(LuaHVH_victim.Character[LuaHVH.target.Part].Position + (LuaHVH_victim.Character[LuaHVH.target.Part].Velocity * LuaHVH.target.Prediction))
        end
    
        Dot.Color = LuaHVH.target.dotcolor
    
        if LuaHVH.target.Enabled and LuaHVH.target.Locking and LuaHVH.target.Tracer then
            local heyloris = CurrentCamera:WorldToViewportPoint(LuaHVH_victim.Character[LuaHVH.target.Part].Position + LuaHVH_victim.Character.HumanoidRootPart.Velocity * LuaHVH.target.Prediction)
    
    
            Line.Color = LuaHVH.target.tracercolor
            Line.Thickness = LuaHVH_visuals.Tracer.TracerThickness
            Line.From = Vector2.new(Mouse.X, Mouse.Y + Inset)
            Line.To = Vector2.new(heyloris.X, heyloris.Y)
            Line.Visible = true
        else
            Line.Visible = false
        end
    
        
    
        if LuaHVH.target.Enabled and LuaHVH.target.Locking and LuaHVH.target.FakeHitbox then
            Hitbox.Transparency = 0
        else
            Hitbox.Transparency = 1
        end
    
        
    
        if LuaHVH.target.Enabled and LuaHVH.target.FakeHitbox and LuaHVH.target.Locking then
            Hitbox.CFrame = CFrame.new(LuaHVH_victim.Character[LuaHVH.target.Part].Position)
        else
            Hitbox.CFrame = CFrame.new(0,0,0)
        end
    
        Hitbox.Color = LuaHVH.target.fhbcolor
    
        if LuaHVH.target.Enabled and LuaHVH.target.LookAt and LuaHVH.target.Locking then          
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(LocalPlayer.Character.HumanoidRootPart.Position, Vector3.new(LuaHVH_victim.Character.HumanoidRootPart.CFrame.X, LocalPlayer.Character.HumanoidRootPart.CFrame.Position.Y, LuaHVH_victim.Character.HumanoidRootPart.CFrame.Z))
        end
    
    
        if LuaHVH.target.Enabled and LuaHVH.target.Locking and LuaHVH.target.target_strafe then 
            -- speed, distance, height, target
            target_strafe(LuaHVH.target.speed, LuaHVH.target.distance, LuaHVH.target.height, LuaHVH_victim)
        end
    end)
end)


--// Mouse Function (User Input Detection Nigga)

spawn(function()
    Mouse.KeyDown:Connect(function(keypressed)
        if (keypressed == LuaHVH.target.Key) then
            if LuaHVH.target.Enabled then
                if LuaHVH.target.Locking then 
                    LuaHVH.target.Locking = not LuaHVH.target.Locking 
                    
                    if LuaHVH.target.Highlight then
                   LocalHL.Parent = game.CoreGui
                   end
                   
                   if LuaHVH.target.Ben then
                      local ben = Instance.new("Sound")
                        ben.Name = "no"
                        ben.Volume = 0.2
                        ben.SoundId = "rbxassetid://8819782435"
                        ben.Parent = game:GetService("SoundService")
                        ben.Playing = true
                        delay(3,function()
                            ben:Destroy()
                        end)
                    end
                    
                    if LuaHVH.target.Notifications then
                        game.StarterGui:SetCore("SendNotification", { 
                            Title = "LuaHVH On TOP",
                            Text = "Unlocked"
                        })
                    end
                else
                    LuaHVH.target.Locking = true 
                    LuaHVH_victim = GetClosestPlayer()
                    
                    if LuaHVH.target.GoTo then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = LuaHVH_victim.Character.HumanoidRootPart.CFrame
                    end
                    
                    if LuaHVH.target.Highlight == true then
                    LocalHL.Parent = LuaHVH_victim.Character
                             LocalHL.FillColor = LuaHVH.target.HighlightFill
                             LocalHL.OutlineColor = LuaHVH.target.HighlightOutline
                        else
                             LocalHL.Parent = game.CoreGui
                        end 
                        
                          if LuaHVH.target.Ben then
            local ben = Instance.new("Sound")
                        ben.Name = "yes"
                        ben.Volume = 0.2
                        ben.SoundId = "rbxassetid://8819783960"
                        ben.Parent = game:GetService("SoundService")
                        ben.Playing = true
                        delay(3,function()
                            ben:Destroy()
                        end)
                    end 
                    
                    if LuaHVH.target.Notifications then
                        game.StarterGui:SetCore("SendNotification", { 
                            Title = "LuaHVH On ToP",
                            Text = "Targeting: " .. tostring(LuaHVH_victim.Character.Humanoid.DisplayName)
                        })
                    end
                end
            end
        end
    end)
end)




--// GetClosestPlayer 

function GetClosestPlayer()
    local LuaHVH_target
    local studs = math.huge 

    for i,v in pairs(game.Players:GetPlayers()) do
        if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character.Humanoid.Health ~= 0 then
            local primarypos, IsVisibleOnViewPort = CurrentCamera:WorldToViewportPoint(v.Character.PrimaryPart.Position)

                if (not LuaHVH.target.VisibleCheck or IsVisibleOnViewPort) then

                    local magnitude = (Vector2.new(primarypos.X, primarypos.Y) - Vector2.new(Mouse.X, Mouse.Y)).magnitude

                    if magnitude < studs then
                        LuaHVH_target = v 
                        studs = magnitude
                    end
                end
            end
        end
    return LuaHVH_target, studs
end

local Health = Drawing.new("Text")
Health.Size = 21
Health.Font = Drawing.Fonts.Monospace


spawn(function()
    RunService.Stepped:Connect(function()
        if LuaHVH.target.Enabled and LuaHVH.target.Locking and LuaHVH.target.healthonplr then
            local Vector = CurrentCamera:WorldToViewportPoint(LuaHVH_victim.Character[LuaHVH.target.Part].Position)
            Health.Visible = true 
            Health.Position = Vector2.new(Vector.X,Vector.Y)
            Health.Text = (tostring(math.floor(LuaHVH_victim.Character.Humanoid.Health)))
            if LuaHVH_victim.Character.Humanoid.Health <= 50 then
                Health.Color = Color3.fromRGB(255, 0, 0)
            else
                Health.Color = Color3.fromRGB(0,255,0)
            end
        else
            Health.Visible = false
        end
        
        if LuaHVH.target.Enabled and LuaHVH.target.Locking and LuaHVH_victim.Character.Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
			LuaHVH.target.RealJumpOffset = LuaHVH.target.JumpOffset
		else
			LuaHVH.target.RealJumpOffset = 0
		end
        
        if LuaHVH.target.Enabled and LuaHVH.target.Locking and LuaHVH.target.UnlockedOnKnocked then
            if LuaHVH_victim.Character.Humanoid.Health < 1.52 then
                print("Knocked")
                LuaHVH.target.Locking = false
                LuaHVH_victim = nil 
                Forcefield.Transparency = 1 
                Hitbox.Transparency = 1
                Dot.Transparency = 1 
                Line.Visible = false
            end
        end
        
        if LuaHVH.target.AutoSetup == true then
        pingvalue = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()
                split = string.split(pingvalue,'(')
                ping = tonumber(split[1])
                if ping < 360 then
                    LuaHVH.target.Prediction = 0.16537
                elseif ping < 270 then
                    LuaHVH.target.Prediction = 0.195566
                elseif ping < 260 then
                    LuaHVH.target.Prediction = 0.175566
                elseif ping < 250 then
                    LuaHVH.target.Prediction = 0.1651
                elseif ping < 240 then
                    LuaHVH.target.Prediction = 0.16780
                elseif ping < 230 then
                    LuaHVH.target.Prediction = 0.15692
                elseif ping < 220 then
                    LuaHVH.target.Prediction = 0.165566
                elseif ping < 210 then
                    LuaHVH.target.Prediction = 0.16780
                elseif ping < 200 then
                    LuaHVH.target.Prediction = 0.165566
                elseif ping < 190 then
                    LuaHVH.target.Prediction = 0.166547
                elseif ping < 180 then
                    LuaHVH.target.Prediction = 0.19284
                elseif ping < 170 then
                    LuaHVH.target.Prediction = 0.1923111 
                elseif ping < 160 then
                    LuaHVH.target.Prediction = 0.16
                elseif ping < 150 then
                    LuaHVH.target.Prediction = 0.15
                elseif ping < 140 then
                    LuaHVH.target.Prediction = 0.1223333
                elseif ping < 130 then
                    LuaHVH.target.Prediction = 0.156692
                elseif ping < 120 then
                    LuaHVH.target.Prediction = 0.143765
                elseif ping < 110 then
                    LuaHVH.target.Prediction = 0.1455
                elseif ping < 100 then
                    LuaHVH.target.Prediction = 0.130340
                elseif ping < 90 then
                    LuaHVH.target.Prediction = 0.136
                elseif ping < 80 then
                    LuaHVH.target.Prediction = 0.1347
                elseif ping < 70 then
                    LuaHVH.target.Prediction = 0.119
                elseif ping < 60 then
                    LuaHVH.target.Prediction = 0.12731
                elseif ping < 50 then
                    LuaHVH.target.Prediction = 0.127668
                elseif ping < 40 then
                    LuaHVH.target.Prediction = 0.125
                elseif ping < 30 then
                    LuaHVH.target.Prediction = 0.11
                elseif ping < 20 then
                    LuaHVH.target.Prediction = 0.12588
                elseif ping < 10 then
                    LuaHVH.target.Prediction = 0.9
                end
            end
    end)
end)

--// target strafe

speed_1 = 0 
local player = game.Players.LocalPlayer

target_strafe = function(speed, distance, height, target)
    speed_1 = speed_1 + speed
    player.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(speed_1), 0) * CFrame.new(0, height, distance)
end

local gmt = getrawmetatable(game)
setreadonly(gmt, false)
local old = gmt.__namecall 

gmt.__namecall = newcclosure(function(...)
    local args = { ... }
    local method = getnamecallmethod()

    if method == "FireServer" and args[2] == "UpdateMousePos" and LuaHVH_victim ~= nil and LuaHVH.target.Locking then 
        args[3] = LuaHVH_victim.Character[LuaHVH.target.Part].Position + Vector3.new(0.01, LuaHVH.target.JumpOffset, 0.01) + (LuaHVH_victim.Character[LuaHVH.target.Part].Velocity * LuaHVH.target.Prediction)
        return old(unpack(args))
    end
    return old(...)
end)


local old 

old = hookmetamethod(game, "__namecall", function(...)
    local crack_crystal_meth = getnamecallmethod()
    local args = { ... }

    if not checkcaller() and crack_crystal_meth == "FireServer" and args[2] == "GetMousePos" and LuaHVH_victim ~= nil and LuaHVH.target.Locking then 
        args[3] = LuaHVH_victim.Character[LuaHVH.target.Part].Position + (LuaHVH_victim.Character[LuaHVH.target.Part].Velocity * LuaHVH.target.Prediction)
        return old(unpack(args))
    end
    return old(...)
end)

local GetPartsObscuringTarget = CurrentCamera.GetPartsObscuringTarget

function Wallcheck(OriginPart, Part)
    if game.Players.LocalPlayer.Character.HumanoidRootPart then 
        local IgnoreList = { CurrentCamera, LocalPlayer.Character, OriginPart.Parent }
        local Parts =
        CurrentCamera:GetPartsObscuringTarget(
            {
                OriginPart.Position,
                Part.Position
            },
            IgnoreList
        )

        for i, v in pairs(Parts) do
            if v.Transparency >= 0.3 then
                Storage.Instance[#Storage.Instance + 1] = v
            end

            if v.Material == Enum.Material.Glass then
                Storage.Instance[#Storage.Instance + 1] = v
            end
        end

        return #Parts == 0
    end
    return true
end





    function Wallcheck(target)
    local ray = Ray.new(LocalPlayer.Character.Head.Position, (target.Position - LocalPlayer.Character.Head.Position).Unit * 300)
    local part, position = game:GetService("Workspace"):FindPartOnRayWithIgnoreList(ray, {LocalPlayer.Character}, false, true)
    if part then 
        local humanoid = part.Parent:FindFirstChildOfClass("Humanoid")
        if not humanoid then 
            humanoid = part.Parent.Parent:FindFirstChildOfClass("Humanoid")
        end
        if humanoid and target and humanoid.Parent == target.Parent then 
            local pos, visible = CurrentCamera:WorldToScreenPoint(target.Position)
            if visible then 
                return true 
            end
        end
    end
end



--// Aimbot


function GetClosestPlr()
    local target
    local studs = math.huge 

    for i,v in pairs(game.Players:GetPlayers()) do
        if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character.Humanoid.Health ~= 0 then

            local IsNotKnocked = v.Character:WaitForChild("BodyEffects")["K.O"].Value ~= true
            local IsNotGrabbed = v.Character:FindFirstChild("GRABBING_COINSTRAINT") == nil


            local primarypos, IsVisibleOnViewPort = CurrentCamera:WorldToViewportPoint(v.Character.PrimaryPart.Position)

                if (not LuaHVH.CamLock.VisibleCheck or IsVisibleOnViewPort) then

                    local magnitude = (Vector2.new(primarypos.X, primarypos.Y) - Vector2.new(Mouse.X, Mouse.Y)).magnitude


                    if magnitude < studs then
                        if (not LuaHVH.CamLock.Wallcheck or Wallcheck(v.Character.Head)) and (not LuaHVH.CamLock.KnockedCheck or IsNotKnocked) and (not LuaHVH.CamLock.GrabbedCheck or IsNotGrabbed) then
                        target = v 
                        studs = magnitude
                    end
                    end
            end
        end
    
end
return target, studs
end

Library.theme.topheight = 50
Library.theme.accentcolor = Color3.fromRGB(149,0,255)
Library.theme.accentcolor2 = Color3.fromRGB(149,0,255)
Library.theme.fontsize = 15
Library.theme.titlesize = 17
Library.theme.cursor = true


getgenv().CamLocking = false

_G.FakeAnim1 = game.Players.LocalPlayer.Character.Animate.idle.Animation1.AnimationId
_G.FakeAnim2 = game.Players.LocalPlayer.Character.Animate.run.RunAnim.AnimationId
_G.FakeAnim3 = game.Players.LocalPlayer.Character.Animate.walk.WalkAnim.AnimationId

local CursorPath = Instance.new("ScreenGui")
local Swastika = Instance.new("TextLabel")


CursorPath.Name = "CursorPath"
CursorPath.Parent = game.CoreGui
CursorPath.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Swastika.Name = "Swastika"
Swastika.Parent = CursorPath
Swastika.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Swastika.BackgroundTransparency = 1.000
Swastika.BorderSizePixel = 2
Swastika.Position = UDim2.new(0, 0, 0, 0)
Swastika.Size = UDim2.new(0, 93, 0, 84)
Swastika.Font = Enum.Font.SourceSans
Swastika.Text = "卍"
Swastika.TextColor3 = Color3.fromRGB(0, 0, 0)
Swastika.TextSize = 46.000
Swastika.TextTransparency =  0
Swastika.Rotation = 45 
Swastika.Visible = false 

local Animations = game.ReplicatedStorage.ClientAnimations

local LeanAnimation = Instance.new("Animation", Animations)
LeanAnimation.Name = "Lean"
LeanAnimation.AnimationId = "rbxassetid://3152375249"

local LayAnimation = Instance.new("Animation", Animations)
LayAnimation.Name = "Lay"
LayAnimation.AnimationId = "rbxassetid://3152378852"

local Dance1Animation = Instance.new("Animation", Animations)
Dance1Animation.Name = "Dance1"
Dance1Animation.AnimationId = "rbxassetid://3189773368"

local Dance2Animation = Instance.new("Animation", Animations)
Dance2Animation.Name = "Dance2"
Dance2Animation.AnimationId = "rbxassetid://3189776546"

local GreetAnimation = Instance.new("Animation", Animations)
GreetAnimation.Name = "Greet"
GreetAnimation.AnimationId = "rbxassetid://3189777795"

local ChestPumpAnimation = Instance.new("Animation", Animations)
ChestPumpAnimation.Name = "Chest Pump"
ChestPumpAnimation.AnimationId = "rbxassetid://3189779152"

local PrayingAnimation = Instance.new("Animation", Animations)
PrayingAnimation.Name = "Praying"
PrayingAnimation.AnimationId = "rbxassetid://3487719500"

local LuaHVH = getgenv().LuaHVH

function CheckWall(head)
   if v == LocalPlayer then return false end
      

       local castPoints = {LocalPlayer.Character.Head.Position, head.Position}
       local ignoreList = {LocalPlayer.Character,head.Parent}
       a = workspace.CurrentCamera:GetPartsObscuringTarget(castPoints, ignoreList)
       if #a == 0 then return false end

   return true
end

local BodyParts = {"Head", "HumanoidRootPart", "Torso", "UpperTorso", "LowerTorso", "RightHand", "LeftLowerArm", "RightLowerArm", "RightUpperArm", "LeftLowerLeg", "LeftUpperLeg", "LeftFoot", "RightFoot", "RightUpperLeg", "RightLowerLeg"}
local materials = {"Neon", "Brick", "Glass", "ForceField"}
local parts = {"Head", "UpperTorso", "HumanoidRootPart", "LowerTorso", "RightFoot", "LeftFoot"}

local Window = Library:CreateWindow("LuaHVH Pro", Vector2.new(460, 460), Enum.KeyCode.V)

local AimingTab = Window:CreateTab("Aiming") 
local MiscTab = Window:CreateTab("Misc") 
local VisualTab = Window:CreateTab("Visual")
local SettingTab = Window:CreateTab("Settings") 


local target = AimingTab:CreateSector("Aim Lock", "left")

local enable = target:AddToggle('Enable', false, function(State)
    LuaHVH.target.Enabled = State
end)

enable:AddKeybind(Enum.KeyCode.L)

target:AddTextbox("Key", "q", function(Text)
    LuaHVH.target.Key = Text
end)

target:AddTextbox("Prediction", "0.135", function(Text)
    LuaHVH.target.Prediction = Text
end)

target:AddTextbox("Jump Offset", "0.06", function(Text)
    LuaHVH.target.JumpOffset = Text
    LuaHVH.target.RealJumpOffset = Text
end)

target:AddDropdown('Aim Part', parts, "HumanoidRootPart", false, function(Option)
    LuaHVH.target.Part = Option
end)

local nigga5 = target:AddToggle('Random Aim Part', false, function(State)
    LuaHVH.target.RandomHP = State
end) 

local notif = target:AddToggle('Notify On Locked', false, function(State)
    LuaHVH.target.Notifications = State
end)

local unok = target:AddToggle('Unlock On Knocked', false, function(State)
    LuaHVH.target.UnlockedOnKnocked = State
end)

local nigga4 = target:AddToggle('Look At', false, function(State)
    LuaHVH.target.LookAt = State
end)

local nigga6 = target:AddToggle('Go To', false, function(State)
    LuaHVH.target.GoTo = State
end)

local nigga5 = target:AddToggle('Visible Check', false, function(State)
    LuaHVH.target.VisibleCheck = State
end)

local nigga6 = target:AddToggle('Health Indicator', false, function(State)
    LuaHVH.target.healthonplr = State
end)

local nigga6 = target:AddToggle('Ben', false, function(State)
    LuaHVH.target.Ben = State
end)

local nigga6 = target:AddToggle('Highlight', false, function(State)
    LuaHVH.target.Highlight = State
end)

nigga6:AddColorpicker(Color3.fromRGB(255,255,255), function(Color)
LuaHVH.target.HighlightFill = Color
end)

nigga6:AddColorpicker(Color3.fromRGB(255,255,255), function(Color)
LuaHVH.target.HighlightOutline = Color
end)

local nigga7 = target:AddToggle('Auto Setup', false, function(State)
LuaHVH.target.AutoSetup = State
end)

local target = AimingTab:CreateSector("Aimlock Settings", "left")

local nigga = target:AddToggle('Forcefield', false, function(State)
    LuaHVH.target.Forcefield = State
end)nigga:AddColorpicker(Color3.fromRGB(255, 255, 255), function(Color)
LuaHVH.target.ffcolor = Color
end)

target:AddDropdown('ForceField Material', materials, "ForceField", false, function(Option)
    LuaHVH_visuals.Forcefield.Material = Option
end)

local nigga1 = target:AddToggle('Visualize Hitbox', false, function(State)
    LuaHVH.target.FakeHitbox = State
end)nigga1:AddColorpicker(Color3.fromRGB(255, 255, 255), function(Color)
hitler.target.fhbcolor = Color
end)

target:AddDropdown('Hitbox Material', materials, "ForceField", false, function(Option)
LuaHVH_visuals.FakeHitbox.Material = Option
end)

local nigga2 = target:AddToggle('Dot (Part)', false, function(State)
    LuaHVH.target.Dot = State
end)nigga2:AddColorpicker(Color3.fromRGB(255, 255, 255), function(Color)
LuaHVH.target.dotcolor = Color
end)

target:AddDropdown('Dot Material', materials, "Neon", false, function(Option)
    LuaHVH_visuals.Dot.Material = Option
end)

local nigga3 = target:AddToggle('Tracer', false, function(State)
    LuaHVH.target.Tracer = State
end)nigga3:AddColorpicker(Color3.fromRGB(255, 255, 255), function(Color)
LuaHVH.target.tracercolor = Color
end)

local targstrafe = AimingTab:CreateSector("Target Strafe", "left")

targstrafe:AddToggle('Target Strafe', false, function(State)
    LuaHVH.target.target_strafe = State
end)

targstrafe:AddSlider("Speed", 1,0,10,100, function(State)
    LuaHVH.target.speed = State
end)

targstrafe:AddSlider("Height", 1,0,10,100, function(State)
    LuaHVH.target.height = State
end)

targstrafe:AddSlider("Distance", 1,0,10,100, function(State)
    LuaHVH.target.distance = State
end)

local testSection = AimingTab:CreateSector("Camlock", "right") 

testSection:AddToggle("Enabled", false, function(first)
LuaHVH.CamLock.Enabled = first
end)

local Cum = testSection:AddToggle("Keybind", false, function(state)
getgenv().CamLocking = state

    if getgenv().CamLocking and LuaHVH.CamLock.Enabled == true then 
        getgenv().CLT = GetClosestPlr()
    end 
end)Cum:AddKeybind()

testSection:AddTextbox("CamLock Prediction", nil, function(Text)
LuaHVH.CamLock.Prediction = Text
end) 

testSection:AddDropdown('Camlock Part', {"Head", "HumanoidRootPart", "UpperTorso", "LowerTorso"}, "Head", false, function(Option)
    LuaHVH.CamLock.Part = Option
end)

testSection:AddToggle("Random Part", false, function(first)
LuaHVH.CamLock.RandomHP = first
end)

testSection:AddToggle("Auto Setup", false, function(first)
LuaHVH.CamLock.AutoSetup = first
end)

testSection:AddToggle("Wall Check", false, function(first)
LuaHVH.CamLock.WallCheck = first
end)

testSection:AddToggle("Grabbed Check Check", false, function(first)
LuaHVH.CamLock.GrabbedCheck = first
end)

testSection:AddToggle("Knocked Check", false, function(first)
LuaHVH.CamLock.KnockedCheck = first
end)

testSection:AddToggle("Visible Check", false, function(first)
LuaHVH.CamLock.VisibleCheck = first
end)

testSection:AddSlider("Smoothness", 0, 100, 100, 1, function(Value)
    LuaHVH.CamLock.Smoothness = Value / 100   
end)

testSection:AddSlider("Shake", 0, 100, 100, 1, function(Value)
LuaHVH.CamLock.ShakeValus = Value
end)

testSection:AddToggle('Resolver', false, function(state)
   LuaHVH.CamLock.Resolver = state
end)

local testSection = AimingTab:CreateSector("Rage Bot LOL", "right") 

local RageLOL = testSection:AddToggle('RageBot', false, function(Boolean)
    LuaHVH.RageBot.Enabled = Boolean
end)RageLOL:AddKeybind()

testSection:AddToggle('LookAt', false, function(Boolean)
    LuaHVH.RageBot.LookAt = Boolean
end)

testSection:AddToggle('Resolver', false, function(Boolean)
    LuaHVH.RageBot.Resolver = Boolean
end)

testSection:AddSlider("Distance", 0, 50, 200, 1, function(Value)
    LuaHVH.RageBot.Distance = Value
end)

circle = Drawing.new("Circle")
circle.Color = Color3.fromRGB(255,255,255)
circle.Thickness = 0
circle.NumSides = 732
circle.Radius = 732
circle.Thickness = 0
circle.Transparency = 0.9
circle.Visible = false
circle.Filled = false


RunService.RenderStepped:Connect(function()
    circle.Position = Vector2.new(Mouse.X,Mouse.Y + Inset)
end)

local testSection = AimingTab:CreateSector("FOV", "right") 

testSection:AddToggle('Visible', false, function(Boolean)
    circle.Visible = Boolean
end)

testSection:AddToggle('Filled', false, function(Boolean)
    circle.Filled = Boolean
end)

testSection:AddSlider("Size", 25, 100, 500, 1, function(Value)
circle.Radius = Value
end)

testSection:AddSlider("Round", 2.5, 100, 500, 1, function(Value)
circle.NumSides = Value
end)

testSection:AddSlider("Transparency", 0, 5, 10, 1, function(Value)
circle.Transparency = tonumber("0." .. Value)
end)

testSection:AddColorpicker("Color", Color3.fromRGB(255,255,255), function(Color)
cicle.Color = Color
end)

local testSection = MiscTab:CreateSector("Misc", "left") 

local SpeedBindLOL = testSection:AddToggle("Speed", false, function(first)
LuaHVH.Misc.Speed = first
end)SpeedBindLOL:AddKeybind()

testSection:AddDropdown('Speed Type', {"CFSpeed", "BHop"}, "CFSpeed", false, function(Option)
LuaHVH.Misc.SpeedType = Option

if Option ~= "BHop" then 
        LocalPlayer.Character.Humanoid.UseJumpPower = true
    end 
end)

testSection:AddSlider("Speed", 1,0,5000,100, function(State)
LuaHVH.Misc.LolSpeed = State
end)

local SpinBindLOL = testSection:AddToggle("Spinbot", false, function(first)
LuaHVH.Misc.Spinbot = first
end)

SpinBindLOL:AddKeybind()

testSection:AddSlider("Speed", 1,0,5000,100, function(State)
LuaHVH.Misc.SpinSpeed = State
end)

local FlightBindxdxd = testSection:AddToggle("Flight", false, function(parameter)
    if parameter then
        FlyLoop = game:GetService("RunService").Stepped:Connect(function()
            spawn(function()
                pcall(function()
                    local speed = FlySpeed
                    local velocity = Vector3.new(0, 1, 0)
                    local UserInputService = game:GetService("UserInputService")
    
                    if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                        velocity = velocity + (workspace.CurrentCamera.CoordinateFrame.lookVector * speed)
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                        velocity = velocity + (workspace.CurrentCamera.CoordinateFrame.rightVector * -speed)
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                        velocity = velocity + (workspace.CurrentCamera.CoordinateFrame.lookVector * -speed)
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                        velocity = velocity + (workspace.CurrentCamera.CoordinateFrame.rightVector * speed)
                    end
                    
                    LocalPlayer.Character.HumanoidRootPart.Velocity = velocity
                    LocalPlayer.Character.Humanoid:ChangeState("Freefall")
                end)
            end)
        end)
    elseif parameter == false and FlyLoop then
        FlyLoop:Disconnect()
        LocalPlayer.Character.Humanoid:ChangeState("Landing")
    end
end)

FlightBindxdxd:AddKeybind()

testSection:AddSlider("Speed", 1,1,5000,1, function(State)
    FlySpeed = State/1000*50
end)

testSection:AddSeperator"Other"

testSection:AddToggle("Auto Stomp", false, function(first)
LuaHVH.Misc.AutoStomp = first
end)

testSection:AddToggle("Anti Fling", false, function(first)
LocalPlayer.Character.HumanoidRootPart.Anchored = first
end)

testSection:AddToggle("Auto Pick Up Money", false, function(first)
LuaHVH.Misc.PickUpMoney = first
end)

testSection:AddToggle("Auto Reload", false, function(first)
LuaHVH.Misc.AutoReload = first
end) 

testSection:AddToggle("Anti Bag", false, function(first)
LuaHVH.Misc.AntiBag = first
end)

testSection:AddToggle("Anti Stomp", false, function(first)
LuaHVH.Misc.AntiStomp = first
end)

testSection:AddToggle("Remove Snow", false, function(first)
LocalPlayer.PlayerGui.MainScreenGui.SNOWBALLFRAME.Visible = first
if first then 
        workspace.Ignored.SnowBlock.Parent = ReplicatedStorage
    else
        if game.ReplicatedStorage:FindFirstChild("SnowBlock") then
        game.ReplicatedStorage.SnowBlock.Parent = workspace.Ignored
        end
    end 
end)

testSection:AddToggle("Remove Chairs", false, function(first)
for i,v in pairs(game.Workspace:GetDescendants()) do
        if v:IsA("Seat") then
            v.Disabled = first
        end
    end
 end)
 
 testSection:AddToggle("Infinity Zoom", false, function(first)
 if first == true then
        LocalPlayer.CameraMaxZoomDistance = math.huge
    else 
        LocalPlayer.CameraMaxZoomDistance = 35
    end
end)

testSection:AddToggle("Show Chat", false, function(state)
   if state == true then
    local chatFrame = LocalPlayer.PlayerGui.Chat.Frame
        chatFrame.ChatChannelParentFrame.Visible = true
        chatFrame.ChatBarParentFrame.Position = chatFrame.ChatChannelParentFrame.Position+UDim2.new(UDim.new(),chatFrame.ChatChannelParentFrame.Size.Y)
   end

   if state == false then 
    local chatFrame = LocalPlayer.PlayerGui.Chat.Frame
            chatFrame.ChatChannelParentFrame.Visible = false
            chatFrame.ChatBarParentFrame.Position = chatFrame.ChatChannelParentFrame.Position+UDim2.new(0,0,0)
   end
end)

local MacroLMAO = testSection:AddToggle("Fake Macro", false, function(Boolean)
LuaHVH.Misc.FakeMacro = Boolean
    
    if LuaHVH.Misc.FakeMacro then 
        local Dance = game:GetService("ReplicatedStorage").ClientAnimations.Crouching
        LoadedAnim = LocalPlayer.Character.Humanoid:LoadAnimation(Dance)
        LoadedAnim:Play()
        else 
        pcall(function()
            LoadedAnim:Stop()
        end)
    end 
    
    while LuaHVH.Misc.FakeMacro == true do 
    task.wait()
    LocalPlayer.Character.HumanoidRootPart.Velocity = LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector * 190
    end     
end)MacroLMAO:AddKeybind() 

testSection:AddSeperator"Shoot Sound"

testSection:AddToggle("Enable", false, function(first)
LuaHVH.Misc.CustomGunSFX = first
end)

testSection:AddTextbox("ID", nil, function(Text)
    LuaHVH.Misc.ID = "rbxassetid://" .. Text .. ""
end)

testSection:AddSlider("Volume", 0, 5, 10, 1, function(Value)
    LuaHVH.Misc.Volume = Value 
end)

local AASec = MiscTab:CreateSector("Anti Lock", "right")

AASec:AddSeperator("Animation") 

local AALOL = AASec:AddToggle("Bicycle", false, function(Boolean)
        if Boolean then 
        local Dance = game:GetService("ReplicatedStorage").ClientAnimations.Bicycling
        LoadedAnim = LocalPlayer.Character.Humanoid:LoadAnimation(Dance)
        LoadedAnim:Play()
        else 
        pcall(function()
            LoadedAnim:Stop()
        end)
    end 
end)AALOL:AddKeybind()

local ALOL = AASec:AddToggle("Block", false, function(Boolean)
if Boolean then 
        local Dance = game:GetService("ReplicatedStorage").ClientAnimations.Block
        LoadedAnim = LocalPlayer.Character.Humanoid:LoadAnimation(Dance)
        LoadedAnim:Play()
        else 
        pcall(function()
            LoadedAnim:Stop()
        end)
    end 
 end)ALOL:AddKeybind()
 
 local LayLOL = AASec:AddToggle("Lay", false, function(Boolean)
 if Boolean then 
        local Dance = game:GetService("ReplicatedStorage").ClientAnimations.Block
        LoadedAnim = LocalPlayer.Character.Humanoid:LoadAnimation(Dance)
        LoadedAnim:Play()
        else 
        pcall(function()
            LoadedAnim:Stop()
        end)
    end 
 end)LayLOL:AddKeybind()

local LeanLOL = AASec:AddToggle("Lean", false, function(Boolean)
if Boolean then 
        local Dance = LeanAnimation
        LoadedAnim = LocalPlayer.Character.Humanoid:LoadAnimation(Dance)
        LoadedAnim:Play()
        else 
        pcall(function()
            LoadedAnim:Stop()
        end)
    end 
 end)LeanLOL:AddKeybind()
 
 local Huh = AASec:AddToggle("Dance1Animation", false, function(Boolean)
 if Boolean then 
        local Dance = Dance1Animation
        LoadedAnim = LocalPlayer.Character.Humanoid:LoadAnimation(Dance)
        LoadedAnim:Play()
        else 
        pcall(function()
            LoadedAnim:Stop()
        end)
    end 
end)Huh:AddKeybind()

 local Huh2 = AASec:AddToggle("Dance2Animation", false, function(Boolean)
     if Boolean then 
        local Dance = Dance2Animation
        LoadedAnim = LocalPlayer.Character.Humanoid:LoadAnimation(Dance)
        LoadedAnim:Play()
        else 
        pcall(function()
            LoadedAnim:Stop()
        end)
    end 
end)Huh2:AddKeybind()

AASec:AddSeperator("Fake Animations") 

AASec:AddToggle("MoonWalk (1)", false, function(LOL)
if LOL == true then
game.Players.LocalPlayer.Character.Animate.idle.Animation1.AnimationId =
                        "rbxassetid://696096087"
                    game.Players.LocalPlayer.Character.Animate.run.RunAnim.AnimationId =
                        "rbxassetid://696096087"
                    game.Players.LocalPlayer.Character.Animate.walk.WalkAnim.AnimationId =
                        "rbxassetid://696096087"
                elseif LOL == false then
                    game.Players.LocalPlayer.Character.Animate.idle.Animation1.AnimationId = _G.FakeAnim1
                    game.Players.LocalPlayer.Character.Animate.run.RunAnim.AnimationId = _G.FakeAnim2
                    game.Players.LocalPlayer.Character.Animate.walk.WalkAnim.AnimationId = _G.FakeAnim3
                end
end)

AASec:AddToggle("MoonWalk (2)", false, function(CUM) 
if CUM == true then
game.Players.LocalPlayer.Character.Animate.idle.Animation1.AnimationId =
                        ""
                    game.Players.LocalPlayer.Character.Animate.run.RunAnim.AnimationId =
                        ""
                    game.Players.LocalPlayer.Character.Animate.walk.WalkAnim.AnimationId =
                        ""
                elseif CUM  == false then
                    game.Players.LocalPlayer.Character.Animate.idle.Animation1.AnimationId = _G.FakeAnim1
                    game.Players.LocalPlayer.Character.Animate.run.RunAnim.AnimationId = _G.FakeAnim2
                    game.Players.LocalPlayer.Character.Animate.walk.WalkAnim.AnimationId = _G.FakeAnim3
                end
   end)
   
   AASec:AddToggle("HeadshotWalk", false, function(LOL)
   if LOL == true then
   game.Players.LocalPlayer.Character.Animate.idle.Animation1.AnimationId =
                        "http://www.roblox.com/asset/?id=1083222527"
                    game.Players.LocalPlayer.Character.Animate.run.RunAnim.AnimationId =
                        "http://www.roblox.com/asset/?id=1083222527"
                    game.Players.LocalPlayer.Character.Animate.walk.WalkAnim.AnimationId =
                        "http://www.roblox.com/asset/?id=1083222527"
                elseif LOL == false then
                    game.Players.LocalPlayer.Character.Animate.idle.Animation1.AnimationId = _G.FakeAnim1
                    game.Players.LocalPlayer.Character.Animate.run.RunAnim.AnimationId = _G.FakeAnim2
                    game.Players.LocalPlayer.Character.Animate.walk.WalkAnim.AnimationId = _G.FakeAnim3
                end
            end)
            
            AASec:AddToggle("Arm Spread", false, function(LOL)
            if LOL == true then
            game.Players.LocalPlayer.Character.Animate.idle.Animation1.AnimationId =
                        "rbxassetid://754656200"
                    game.Players.LocalPlayer.Character.Animate.run.RunAnim.AnimationId =
                        "rbxassetid://754656200"
                    game.Players.LocalPlayer.Character.Animate.walk.WalkAnim.AnimationId =
                        "rbxassetid://754656200"
                elseif LOL == false then
                    game.Players.LocalPlayer.Character.Animate.idle.Animation1.AnimationId = _G.FakeAnim1
                    game.Players.LocalPlayer.Character.Animate.run.RunAnim.AnimationId = _G.FakeAnim2
                    game.Players.LocalPlayer.Character.Animate.walk.WalkAnim.AnimationId = _G.FakeAnim3
                end
             end)
             
            AASec:AddToggle("FlossWalk", false, function(LOL)
            if LOL == true then
            game.Players.LocalPlayer.Character.Animate.idle.Animation1.AnimationId =
                        "http://www.roblox.com/asset/?id=5917459365"
                    game.Players.LocalPlayer.Character.Animate.run.RunAnim.AnimationId =
                        "http://www.roblox.com/asset/?id=5917459365"
                    game.Players.LocalPlayer.Character.Animate.walk.WalkAnim.AnimationId =
                        "http://www.roblox.com/asset/?id=5917459365"
                elseif LOL == false then
                    game.Players.LocalPlayer.Character.Animate.idle.Animation1.AnimationId = _G.FakeAnim1
                    game.Players.LocalPlayer.Character.Animate.run.RunAnim.AnimationId = _G.FakeAnim2
                    game.Players.LocalPlayer.Character.Animate.walk.WalkAnim.AnimationId = _G.FakeAnim3
                end
           end)
           
-- // Yes I Pasted Azure AntiLock Cry Abt It

AASec:AddSeperator("Main Antilock") 

AASec:AddButton("Force Reset",function()
    for _,parts in pairs(player.Character:GetChildren()) do
        if parts:IsA("BasePart") then
            parts:Destroy()
        end
    end
end)

local AABindLOL = AASec:AddToggle("Enable", false, function(parameter)
    aaenabled = parameter
end)

AABindLOL:AddKeybind()

AASec:AddDropdown("Mode", {"Custom","Prediction Changer","Upside Down","Unhittable","Prediction Disabler","Up","Down","AirOrthodox","Prediction Multiplier", "Spinbot Desync"}, "Custom", false, function(dropdown)
    aamodex = dropdown
end)

AASec:AddSlider("Custom X", -10000,10000,10000,1, function(State)
    x_val = State
end)

AASec:AddSlider("Custom Y", -10000,10000,10000,1, function(State)
    y_val = State
end)

AASec:AddSlider("Custom Z", -10000,10000,10000,1, function(State)
    z_val = State
end)
AASec:AddLabel""
AASec:AddSlider("Prediction Changer", -20,5,20,1, function(State)
    Custom123 = State
end)

AASec:AddLabel""

AASec:AddSlider("Desync Angles", -1000,1000,1000,1, function(State)
    DesyncAngles = State
end)

local heartbeat = game:GetService("RunService").Heartbeat
local renderstepped = game:GetService("RunService").RenderStepped
local stepped = game:GetService("RunService").Stepped
local v3 = Vector3.new
local players = game:GetService("Players")
local player = players.LocalPlayer
local hrp = game.Players.LocalPlayer.Character.HumanoidRootPart
local lp = game.Players.LocalPlayer

spawn(function()
    heartbeat:Connect(function()
        if player.Character.Humanoid.Health <= 10 then
            AABindLOL:Set(false)
        end
    end)
end)

spawn(function()
    local hrp, c, vel, movel = nil, nil, nil, 0.1
    c = lp.Character
    hrp = lp.Character.HumanoidRootPart
    while true do
        heartbeat:Wait()
        while aaenabled and not (c and c.Parent and hrp and hrp.Parent) do
            heartbeat:Wait()
            c = lp.Character
            hrp = lp.Character.HumanoidRootPart
        end
        if aaenabled and c and c.Parent and hrp and hrp.Parent and aamodex == "Custom" then
            vel = hrp.Velocity
            hrp.Velocity = vel*-0+v3(x_val,y_val,z_val)
            renderstepped:Wait()
            hrp.Velocity = vel
            stepped:Wait()
            if c and c.Parent and hrp and hrp.Parent then
                hrp.Velocity = vel + v3(0, movel, 0)
                movel = movel * -1
            end
          elseif aaenabled and c and c.Parent and hrp and hrp.Parent and aamodex == "Prediction Changer" then
            vel = hrp.Velocity
            hrp.Velocity = vel*Custom123+v3(0,0,0)
            renderstepped:Wait()
            hrp.Velocity = vel
            stepped:Wait()
            if c and c.Parent and hrp and hrp.Parent then
                hrp.Velocity = vel + v3(0, movel, 0)
                movel = movel * -1
            end

        elseif aaenabled and c and c.Parent and hrp and hrp.Parent and aamodex == "Prediction Disabler" then
            vel = hrp.Velocity
            hrp.Velocity = vel*-0+v3(-0,-0,-0)
            renderstepped:Wait()
            hrp.Velocity = vel
            stepped:Wait()
            if c and c.Parent and hrp and hrp.Parent then
                hrp.Velocity = vel + v3(0, movel, 0)
                movel = movel * -1
            end
        elseif aaenabled and c and c.Parent and hrp and hrp.Parent and aamodex == "Up" then
            vel = hrp.Velocity
            hrp.Velocity = vel*-0+v3(-0,10000000000000000000,-0)
            renderstepped:Wait()
            hrp.Velocity = vel
            stepped:Wait()
            if c and c.Parent and hrp and hrp.Parent then
                hrp.Velocity = vel + v3(0, movel, 0)
                movel = movel * -1
            end
        elseif aaenabled and c and c.Parent and hrp and hrp.Parent and aamodex == "Down" then
            vel = hrp.Velocity
            hrp.Velocity = vel*-0+v3(-0,-10000000000000000000,-0)
            renderstepped:Wait()
            hrp.Velocity = vel
            stepped:Wait()
            if c and c.Parent and hrp and hrp.Parent then
                hrp.Velocity = vel + v3(0, movel, 0)
                movel = movel * -1
            end
            elseif aaenabled and c and c.Parent and hrp and hrp.Parent and aamodex == "AirOrthodox" then
            vel = hrp.Velocity
            hrp.Velocity = vel*1+v3(77,77,77)
            renderstepped:Wait()
            hrp.Velocity = vel
            stepped:Wait()
            if c and c.Parent and hrp and hrp.Parent then
                hrp.Velocity = vel + v3(0, movel, 0)
                movel = movel * -1
            end
                        elseif aaenabled and c and c.Parent and hrp and hrp.Parent and aamodex == "Prediction Multiplier" then
            vel = hrp.Velocity
            hrp.Velocity = vel*7+v3(0,0,0)
            renderstepped:Wait()
            hrp.Velocity = vel
            stepped:Wait()
            if c and c.Parent and hrp and hrp.Parent then
                hrp.Velocity = vel + v3(0, movel, 0)
                movel = movel * -1
            end
        elseif aaenabled and aamodex == "Upside Down" then
        LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0,0,math.rad(-180)) 
        elseif aaenabled and aamodex == "Unhittable" then
        LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(1,1,1) * -(2^16)
            LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0,0.0001,0)
        elseif aaenabled and c and c.Parent and hrp and hrp.Parent and aamodex == "Spinbot Desync" then
            vel = hrp.Velocity
            hrp.Velocity = vel * 0 + v3(0,10000000000000000000,0)
            renderstepped:Wait()
            if c and c.Parent and hrp and hrp.Parent then
                hrp.Velocity = vel
            end
            player.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(DesyncAngles), 0)
        end
    end
end)

local testSection = VisualTab:CreateSector("Self Visual", "left") 

testSection:AddToggle("Self Chams", false, function(e)
LuaHVH.Visual.LocalCham = e
end)

task.spawn(function ()
            while true do
                wait()
                if LuaHVH.Visual.LocalCham then
                    for i,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                        if v:IsA("BasePart") then
                            v.Material = "ForceField"
                        end
                    end
                else
                    for i,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                        if v:IsA("BasePart") then
                            v.Material = "Plastic"
                        end
                    end
                end
            end
    end)
       
local Skid = testSection:AddToggle("Gun Chams", false, function(e)
LuaHVH.Visual.GunCham = e
end)

Skid:AddColorpicker(Color3.fromRGB(255,255,255), function(ztx)
LuaHVH.Visual.GunColor = ztx
end)

task.spawn(function ()
            while true do
                wait()
                if LuaHVH.Visual.GunCham then
                    if game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Tool") then
                        game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Tool").Default.Material = "ForceField"
                        game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Tool").Default.Color = LuaHVH.Visual.GunColor
                    end
                else
                    if game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Tool") then
                        game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Tool").Default.Material = "Plastic"
                    end
                end
            end
        end)
        
local Skid = testSection:AddToggle("Radio Chams", false, function(state)
while state == true do 
task.wait()
game.Players.LocalPlayer.Character.Radio.Material = Enum.Material.ForceField
end 
end)

Skid:AddColorpicker(Color3.fromRGB(255,255,255), function(ztx)
game.Players.LocalPlayer.Character.Radio.Color = ztx
end)
        
        local LocalHL = Instance.new("Highlight")

local Skid = testSection:AddToggle("Highlight Self", false, function(e)
LuaHVH.Visual.Highlight = e
end)

Skid:AddColorpicker(Color3.fromRGB(255,0,0), function(ztx)
LuaHVH.Visual.HighlightFillColor = ztx
end)

Skid:AddColorpicker(Color3.fromRGB(255,255,255), function(ztx)
LuaHVH.Visual.HighlightOutlineColor = ztx
end)

task.spawn(function ()
            while true do
                wait()
                if LuaHVH.Visual.Highlight then
                    LocalHL.Parent = LocalPlayer.Character
                    LocalHL.FillColor = LuaHVH.Visual.HighlightFillColor
                    LocalHL.OutlineColor = LuaHVH.Visual.HighlightOutlineColor
                else
                    LocalHL.Parent = game.CoreGui
                end
            end
        end)
         
        
   local Skid = testSection:AddToggle("Trail", false, function(x)
   if x then
        local trail = Instance.new'Trail'
        trail.FaceCamera = true
        trail.LightEmission = 1
        trail.LightInfluence = 1
        trail.Texture = 'http://www.roblox.com/asset/?id=446111271'
        trail.TextureMode = 'Static'
        trail.Transparency = NumberSequence.new(0, 0.5, 0, 1, 0.5, 0)
        trail.Lifetime = 1.6
        trail.WidthScale = NumberSequence.new(0,1,0,0.053616,0,0,1,1,0)
        trail.Color = ColorSequence.new(LuaHVH.Visual.TrailColor)
        trail.Name = 'Trail'
        local c = game.Players.LocalPlayer.Character
		local root = c:WaitForChild("HumanoidRootPart")
		local att0 = Instance.new("Attachment", root)
		local att1 = Instance.new("Attachment", root)
		att0.Name = 'A0'
		att1.Name = 'A1'
		att0.Position = Vector3.new(0, root.Size.Y/1.5, 0)
		att1.Position = Vector3.new(0, -root.Size.Y/1.5, 0)
		local trail = trail:Clone()
		trail.Parent = c:WaitForChild("HumanoidRootPart")
		trail.Attachment0 = att0
		trail.Attachment1 = att1
    end

    if not x then
        if game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild('A0') then
            game.Players.LocalPlayer.Character.HumanoidRootPart.A0:Destroy()
            game.Players.LocalPlayer.Character.HumanoidRootPart.A1:Destroy()
            game.Players.LocalPlayer.Character.HumanoidRootPart.Trail:Destroy()
        end
    end
end)

Skid:AddColorpicker(Color3.fromRGB(168,122,207), function(ztx)
LuaHVH.Visual.TrailColor = ztx
end)

local Skid = testSection:AddToggle("Clone Chams", false, function(e)
LuaHVH.Visual.CloneChams = e
end)

Skid:AddColorpicker(Color3.fromRGB(255,255,255), function(ztx)
LuaHVH.Visual.CloneColor = ztx
end)

testSection:AddDropdown('Clone Material', {"Neon", "ForceField", "Plastic"}, "ForceField", false, function(Option)
LuaHVH.Visual.CloneMaterial = Option
end)

testSection:AddSlider("Clone Duration", 0.1, 0.1, 3, 2, function(Value)
LuaHVH.Visual.CloneDuration = Value
end)

task.spawn(function ()
            while true do
                wait()
                if LuaHVH.Visual.CloneChams then
                    repeat
                        game.Players.LocalPlayer.Character.Archivable = true
                        local Clone = game.Players.LocalPlayer.Character:Clone()
                        for _,Obj in next, Clone:GetDescendants() do
                        if Obj.Name == "HumanoidRootPart" or Obj:IsA("Humanoid") or Obj:IsA("LocalScript") or Obj:IsA("Script") or Obj:IsA("Decal") then
                            Obj:Destroy()
                        elseif Obj:IsA("BasePart") or Obj:IsA("Meshpart") or Obj:IsA("Part") then
                            if Obj.Transparency == 1 then
                            Obj:Destroy()
                            else
                            Obj.CanCollide = false
                            Obj.Anchored = true
                            Obj.Material = LuaHVH.Visual.CloneMaterial
                            Obj.Color = LuaHVH.Visual.CloneColor
                            Obj.Transparency = 0
                            Obj.Size = Obj.Size + Vector3.new(0.03, 0.03, 0.03)   
                        end
                    end
                        pcall(function()
                            Obj.CanCollide = false
                        end)
                    end
                    Clone.Parent = game.Workspace
                    wait(LuaHVH.Visual.CloneDuration)
                    Clone:Destroy()  
                    until LuaHVH.Visual.CloneChams == false
                end
            end
        end)
        
local testSection = VisualTab:CreateSector("ESP", "left") 
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/ImHaalfi/random-trash-project/main/Taffy%20ESP.txt"))()

local ColorToggle = testSection:AddToggle("Boxes", false, function(e)
getgenv().taffy_esp.box.enabled = e
end)

ColorToggle:AddColorpicker(Color3.fromRGB(255,255,255), function(ztx)
   getgenv().taffy_esp.box.color1  = ztx
end)

local ColorToggle = testSection:AddToggle("Healthbar", false, function(e)
getgenv().taffy_esp.box.healthbar = e
end)

ColorToggle:AddColorpicker(Color3.fromRGB(4, 0, 255),function(ztx)
   getgenv().taffy_esp.box.healthbarcolor  = ztx
end)

local ColorToggle = testSection:AddToggle("Tracer", false, function(e)
getgenv().taffy_esp.tracer.enabled = e
end)

ColorToggle:AddColorpicker(Color3.fromRGB(255,255,255), function(ztx)
getgenv().taffy_esp.tracer.color  = ztx
end)

local ColorToggle = testSection:AddToggle("Name", false, function(e)
getgenv().taffy_esp.name.enabled = e
end)

ColorToggle:AddColorpicker(Color3.fromRGB(255,255,255), function(ztx)
   getgenv().taffy_esp.name.color  = ztx
end)

local ColorToggle = testSection:AddToggle("Show Tool", false, function(e)
getgenv().taffy_esp.Toolsshow.enable = e
end)

ColorToggle:AddColorpicker(Color3.fromRGB(147,39,161), function(ztx)
   getgenv().taffy_esp.Toolsshow.color  = ztx
end)

local BroSection = VisualTab:CreateSector("Character", "left") 

BroSection:AddToggle("Korblox", false, function(first)
if first then
game.Players.LocalPlayer.Character.RightFoot.MeshId = "http://www.roblox.com/asset/?id=902942093"
			game.Players.LocalPlayer.Character.RightLowerLeg.MeshId = "http://www.roblox.com/asset/?id=902942093"
			game.Players.LocalPlayer.Character.RightUpperLeg.MeshId = "http://www.roblox.com/asset/?id=902942096"
			game.Players.LocalPlayer.Character.RightUpperLeg.TextureID = "http://roblox.com/asset/?id=902843398"
			game.Players.LocalPlayer.Character.RightFoot.Transparency = 1
			game.Players.LocalPlayer.Character.RightLowerLeg.Transparency = 1
		else
			game.Players.LocalPlayer.Character.RightFoot.MeshId = Storage.RightFootMeshID
			game.Players.LocalPlayer.Character.RightLowerLeg.MeshId = Storage.RightLowerLegMeshID
			game.Players.LocalPlayer.Character.RightUpperLeg.MeshId = Storage.RightUpperLegMeshID
			game.Players.LocalPlayer.Character.RightUpperLeg.TextureID = Storage.RightUpperLegMeshID
			game.Players.LocalPlayer.Character.RightFoot.Transparency = Storage.RightFootTransparency
			game.Players.LocalPlayer.Character.RightLowerLeg.Transparency = Storage.RightLowerLegTransparency
		end
	end)
	
	BroSection:AddToggle("Blizzard Beast Mode", false, function(first)
	if first then
	pcall(
				function()
					game.Players.LocalPlayer.Character.Head.face.Texture = "rbxassetid://209712379"
				end
			)
		else
			pcall(
				function()
					game.Players.LocalPlayer.Character.Head.face.Texture = Storage.Face
				end
			)
		end
	end)
	
	BroSection:AddToggle("SSHF", false, function(first)
	if first then
	pcall(
				function()
					game.Players.LocalPlayer.Character.Head.face.Texture = "rbxassetid://494290547"
				end
			)
		else
			pcall(
				function()
					game.Players.LocalPlayer.Character.Head.face.Texture = Storage.Face
				end
			)
		end
	end) 
	
	BroSection:AddToggle("Beast Mode", false, function(first)
	if first then
	pcall(
				function()
					game.Players.LocalPlayer.Character.Head.face.Texture = "rbxassetid://127959433"
				end
			)
		else
			pcall(
				function()
					game.Players.LocalPlayer.Character.Head.face.Texture = Storage.Face
				end
			)
		end
	end)
	
	BroSection:AddToggle("Playful Vampire", false, function(v)
	if v then
pcall(
				function()
					game.Players.LocalPlayer.Character.Head.face.Texture = "rbxassetid://2409281591"
				end
			)
		else
			pcall(
				function()
					game.Players.LocalPlayer.Character.Head.face.Texture = Storage.Face
				end
			)
		end
	end)

local testSection = VisualTab:CreateSector("China Hat", "left") 

local ColorToggle = testSection:AddToggle("Enable", false, function(gay)
settings.enabled = gay
end)

ColorToggle:AddColorpicker(Color3.fromRGB(128,18,255), function(ztx)
settings.color = ztx
end)

testSection:AddToggle("Rainbow", false, function(first)
settings.rainbow = first
end)

testSection:AddSlider("Radius",1,1,5,1, function(State)
settings.radius = State
end)

testSection:AddSlider("Sides",1,25,100,1, function(State)
settings.sides = State
end)

local testSection = VisualTab:CreateSector("Other", "right") 

testSection:AddSeperator"World"

testSection:AddColorpicker("Ambient", Color3.new(1,1,1), function(Color)
game:GetService("Lighting").OutdoorAmbient  = Color
end)

testSection:AddColorpicker("Fog Color", Color3.new(1,1,1), function(Color)
game:GetService("Lighting").FogColor  = Color
end)

testSection:AddColorpicker("Tint Color", Color3.new(1,1,1), function(Color)
game:GetService("Lighting").ColorCorrection.TintColor = Color
end)

testSection:AddColorpicker("ColorShift Color", Color3.new(1,1,1), function(Color)
game:GetService("Lighting").ColorShift_Top = Color
game:GetService("Lighting").ColorShift_Bottom = Color
end)

testSection:AddSlider("Brightness",1,1,50,1, function(State)
game.Lighting.Brightness =  State
end) 

testSection:AddSlider("Saturation",0.10000000149012,0.10000000149012,10,1, function(State)
game.Lighting.ColorCorrection.Saturation = State
end)

testSection:AddSlider("Contrast",1,1,50,1, function(State)
game.Lighting.ColorCorrection.Contrast =  State
end) 

testSection:AddToggle('Enable Fog', false, function(e)
if e then
            game.Lighting.FogEnd = 9999
        else
            game.Lighting.FogEnd = 500
        end 
end)

testSection:AddToggle('Global Shadows', false, function(e)
game:GetService("Lighting").GlobalShadows = e 
end)

testSection:AddSlider("Day Time (Hours)",1,13,24,1, function(State)
game:GetService("Lighting").ClockTime = State
end)

testSection:AddSeperator"Custom Character"

function Weld(x,y)
       local W = Instance.new("Weld")
       W.Part0 = x
       W.Part1 = y
       local CJ = CFrame.new(x.Position)
       local C0 = x.CFrame:inverse()*CJ
       local C1 = y.CFrame:inverse()*CJ
       W.C0 = C0
       W.C1 = C1
       W.Parent = x
end

testSection:AddToggle('Custom Character', false, function(state)
    if state then 
        for i,v in pairs(LocalPlayer.Character:GetDescendants()) do 
            if v:IsA("BasePart") or v:IsA("Decal") then 
                v.Transparency = 1 
            end 
        end 
        
getgenv().Custom = LocalPlayer.Character:WaitForChild("Humanoid").Died:Connect(function()
fuc:Destroy()
wait(5)
fuc = Instance.new("Part",workspace) 
fuc.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame
fuc.CanCollide = false
fuck = Instance.new("SpecialMesh")
fuck.Parent = fuc
fuck.MeshType ="FileMesh"
    if getgenv().CharacterType  == "AmongUs" then 
        fuck.Scale=Vector3.new(0.2,0.2,0.2) 
        fuck.TextureId="http://www.roblox.com/asset/?id=6686375937" 
        fuck.MeshId="http://www.roblox.com/asset/?id=6686375902"
    elseif getgenv().CharacterType  == "Super Sonic" then 
        fuck.Scale=Vector3.new(1,1,1) 
        fuck.TextureId="http://www.roblox.com/asset/?id=825513852"
        fuck.MeshId="http://www.roblox.com/asset/?id=825513834" 
    elseif getgenv().CharacterType  == "Tornado" then 
    fuck.Scale=Vector3.new(10,10,10) 
        fuck.TextureId="http://www.roblox.com/asset/?id=38426946"
        fuck.MeshId="http://www.roblox.com/asset/?id=2196834758"  
    elseif getgenv().CharacterType == "Titan Cameraman" then
    fuck.Scale=Vector3.new(1,1,1) 
        fuck.TextureId="http://www.roblox.com/asset/?id=14138793643"
        fuck.MeshId="http://www.roblox.com/asset/?id=14138793791"  
    elseif getgenv().CharacterType  == "Sonic" then 
        fuck.Scale=Vector3.new(0.1,0.1,0.1) 
        fuck.TextureId="http://www.roblox.com/asset/?id=6901422268"
        fuck.MeshId="http://www.roblox.com/asset/?id=6901422170"
    elseif getgenv().CharacterType  == "Chicken" then     
        fuck.Scale=Vector3.new(3,3,3) 
        fuck.TextureId="http://www.roblox.com/asset/?id=2114220248" 
        fuck.MeshId="http://www.roblox.com/asset/?id=2114220154" 
end 

    Weld(LocalPlayer.Character.HumanoidRootPart,fuc)

    for i,v in pairs(LocalPlayer.Character:GetDescendants()) do 
        if v:IsA("BasePart") or v:IsA("Decal") then 
            v.Transparency = 1
        end 
    end 

end)
        
        fuc = Instance.new("Part",workspace) 
        fuc.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame
        fuc.CanCollide = false
        fuck = Instance.new("SpecialMesh")
        fuck.Parent = fuc
        fuck.MeshType ="FileMesh"

        if getgenv().CharacterType  == "AmongUs" then 
        fuck.Scale=Vector3.new(0.2,0.2,0.2) --sizerbxassetid://6901422268
        fuck.TextureId="http://www.roblox.com/asset/?id=6686375937" --Texture / Skin
        fuck.MeshId="http://www.roblox.com/asset/?id=6686375902" -- Mesh Id
    elseif getgenv().CharacterType  == "Super Sonic" then 
        fuck.Scale=Vector3.new(1,1,1) --sizerbxassetid://6901422268
        fuck.TextureId="http://www.roblox.com/asset/?id=825513852" --Texture / Skin
        fuck.MeshId="http://www.roblox.com/asset/?id=825513834" -- Mesh Id
     elseif getgenv().CharacterType  == "Tornado" then 
    fuck.Scale=Vector3.new(10,10,10) 
        fuck.TextureId="http://www.roblox.com/asset/?id=38426946"
        fuck.MeshId="http://www.roblox.com/asset/?id=2196834758" 
    elseif getgenv().CharacterType == "Titan Cameraman" then
    fuck.Scale=Vector3.new(1,1,1) 
        fuck.TextureId="http://www.roblox.com/asset/?id=14138793643"
        fuck.MeshId="http://www.roblox.com/asset/?id=14138793791"  
    elseif getgenv().CharacterType  == "Sonic" then 
        fuck.Scale=Vector3.new(0.1,0.1,0.1) --sizerbxassetid://6901422268
        fuck.TextureId="http://www.roblox.com/asset/?id=6901422268" --Texture / Skin
        fuck.MeshId="http://www.roblox.com/asset/?id=6901422170"
    elseif getgenv().CharacterType  == "Chicken" then     
        fuck.Scale=Vector3.new(3,3,3) --sizerbxassetid://6901422268
        fuck.TextureId="http://www.roblox.com/asset/?id=2114220248" --Texture / Skin
        fuck.MeshId="http://www.roblox.com/asset/?id=2114220154" -- Mesh Id
    end 

        Weld(LocalPlayer.Character.HumanoidRootPart,fuc)
        else 
        fuc:Destroy()
        
        for i,v in pairs(LocalPlayer.Character:GetDescendants()) do 
            if v:IsA("BasePart") or v:IsA("Decal") then 
                v.Transparency = 0 
            end 
        end 
        
        getgenv().Custom:Disconnect()
        
        LocalPlayer.Character.HumanoidRootPart.Transparency = 1
    end 
end) 

testSection:AddDropdown("Character Type", {"AmongUs", "Super Sonic", "Tornado", "Titan Cameraman", "Sonic", "Chicken"}, "AmongUs", false, function(Option)
    getgenv().CharacterType = Option
    
    if Option == "AmongUs" then 
        fuck.Scale=Vector3.new(0.2,0.2,0.2) --sizerbxassetid://6901422268
        fuck.TextureId="http://www.roblox.com/asset/?id=6686375937" --Texture / Skin
        fuck.MeshId="http://www.roblox.com/asset/?id=6686375902" -- Mesh Id
    elseif Option == "Super Sonic" then 
        fuck.Scale=Vector3.new(1,1,1) --sizerbxassetid://6901422268
        fuck.TextureId="http://www.roblox.com/asset/?id=825513852" --Texture / Skin
        fuck.MeshId="http://www.roblox.com/asset/?id=825513834" -- Mesh Id
      elseif Option  == "Tornado" then 
    fuck.Scale=Vector3.new(10,10,10) 
        fuck.TextureId="http://www.roblox.com/asset/?id=38426946"
        fuck.MeshId="http://www.roblox.com/asset/?id=2196834758" 
    elseif Option == "Titan Cameraman" then
    fuck.Scale=Vector3.new(1,1,1) 
        fuck.TextureId="http://www.roblox.com/asset/?id=14138793643"
        fuck.MeshId="http://www.roblox.com/asset/?id=14138793791"  
    elseif Option == "Sonic" then 
        fuck.Scale=Vector3.new(0.25,0.25,0.25) --sizerbxassetid://6901422268
        fuck.TextureId="http://www.roblox.com/asset/?id=6901422268" --Texture / Skin
        fuck.MeshId="http://www.roblox.com/asset/?id=6901422170"
    elseif Option == "Chicken" then     
        fuck.Scale=Vector3.new(3,3,3) --sizerbxassetid://6901422268
        fuck.TextureId="http://www.roblox.com/asset/?id=2114220248" --Texture / Skin
        fuck.MeshId="http://www.roblox.com/asset/?id=2114220154" -- Mesh Id
    end 
end)  

testSection:AddSeperator"Bullet Tracers"

testSection:AddToggle('Bullet Tracers', false, function(Boolean)
    BulletTracers = Boolean
end):AddColorpicker(Color3.fromRGB(255,0,0), function(Color)
    BulletTracerColor = Color
end)

testSection:AddSlider("Bullet Thickness", 0, 5, 10, 1, function(Value)
    BulletWidth = Value 
end)

testSection:AddSeperator"Custom Skybox"

local skybox = Instance.new("Sky")
skybox.Parent = game.Lighting
skybox.SkyboxBk = "rbxassetid://600830446" 
skybox.SkyboxDn = "rbxassetid://600831635" 
skybox.SkyboxFt = "rbxassetid://600832720" 
skybox.SkyboxLf = "rbxassetid://600886090" 
skybox.SkyboxRt = "rbxassetid://600833862" 
skybox.SkyboxUp = "rbxassetid://600835177" 

testSection:AddToggle('Custom Skyboxes', false, function(Boolean)
    getgenv().Skybox = Boolean
    
    if not getgenv().Skybox then 
        skybox.SkyboxBk = "rbxassetid://600830446" 
        skybox.SkyboxDn = "rbxassetid://600831635" 
        skybox.SkyboxFt = "rbxassetid://600832720" 
        skybox.SkyboxLf = "rbxassetid://600886090" 
        skybox.SkyboxRt = "rbxassetid://600833862" 
        skybox.SkyboxUp = "rbxassetid://600835177" 
    end 
end)

testSection:AddDropdown("Skybox", {"Normal", "DoomSpire", "CatGirl", "Vibe", "Blue Aurora"}, "Normal", false, function(Option)
    getgenv().SkyBoxOption = Option
   
    if getgenv().Skybox then 
        if getgenv().SkyBoxOption == "DoomSpire" then 
        skybox.SkyboxBk = "rbxassetid://6050664592" 
        skybox.SkyboxDn = "rbxassetid://6050648475" 
        skybox.SkyboxFt = "rbxassetid://6050644331" 
        skybox.SkyboxLf = "rbxassetid://6050649245" 
        skybox.SkyboxRt = "rbxassetid://6050649718" 
        skybox.SkyboxUp = "rbxassetid://6050650083" 
        elseif  getgenv().SkyBoxOption == "Normal" then 
        skybox.SkyboxBk = "rbxassetid://600830446" 
        skybox.SkyboxDn = "rbxassetid://600831635" 
        skybox.SkyboxFt = "rbxassetid://600832720" 
        skybox.SkyboxLf = "rbxassetid://600886090" 
        skybox.SkyboxRt = "rbxassetid://600833862" 
        skybox.SkyboxUp = "rbxassetid://600835177" 
        elseif  getgenv().SkyBoxOption == "CatGirl" then 
        skybox.SkyboxBk = "rbxassetid://444167615" 
        skybox.SkyboxDn = "rbxassetid://444167615" 
        skybox.SkyboxFt = "rbxassetid://444167615" 
        skybox.SkyboxLf = "rbxassetid://444167615" 
        skybox.SkyboxRt = "rbxassetid://444167615" 
        skybox.SkyboxUp = "rbxassetid://444167615" 
        elseif  getgenv().SkyBoxOption == "Vibe" then 
        skybox.SkyboxBk = "rbxassetid://1417494030" 
        skybox.SkyboxDn = "rbxassetid://1417494146" 
        skybox.SkyboxFt = "rbxassetid://1417494253" 
        skybox.SkyboxLf = "rbxassetid://1417494402" 
        skybox.SkyboxRt = "rbxassetid://1417494499" 
        skybox.SkyboxUp = "rbxassetid://1417494643" 
        elseif  getgenv().SkyBoxOption == "Blue Aurora" then 
        skybox.SkyboxBk = "rbxassetid://12064107" 
        skybox.SkyboxDn = "rbxassetid://12064152" 
        skybox.SkyboxFt = "rbxassetid://12064121" 
        skybox.SkyboxLf = "rbxassetid://12063984" 
        skybox.SkyboxRt = "rbxassetid://12064115" 
        skybox.SkyboxUp = "rbxassetid://12064131"
        end 
    end 
end)

testSection:AddSeperator"Camera"

testSection:AddToggle('Custom FOV', false, function(Boolean)
LuaHVH.Visual.CustomFOV = Boolean
end)

testSection:AddSlider("FOV Amount", 1, 60, 120, 1, function(Value)
LuaHVH.Visual.FOV = Value
end)

testSection:AddSeperator"Cursor"

local TopCursorToggle = testSection:AddToggle('Top', true, function(Boolean)
game:GetService('Players').LocalPlayer.PlayerGui.MainScreenGui.Aim.Top.Visible = Boolean
end)

local TopCursorColor = TopCursorToggle:AddColorpicker(Color3.fromRGB(255, 255, 255), function(color)
    game:GetService('Players').LocalPlayer.PlayerGui.MainScreenGui.Aim.Top.BackgroundColor3 = color
end)

local MiddleCursorToggle = testSection:AddToggle('Middle', true, function(Boolean)
    game:GetService('Players').LocalPlayer.PlayerGui.MainScreenGui.Aim.Visible = Boolean
end)

local MiddleCursorColor = MiddleCursorToggle:AddColorpicker(Color3.fromRGB(255, 255, 255), function(color)
    game:GetService('Players').LocalPlayer.PlayerGui.MainScreenGui.Aim.BackgroundColor3 = color
end)

local BottomCursorToggle = testSection:AddToggle('Bottom', true, function(Boolean)
    game:GetService('Players').LocalPlayer.PlayerGui.MainScreenGui.Aim.Bottom.Visible = Boolean
end)

local BottomCursorColor = BottomCursorToggle:AddColorpicker(Color3.fromRGB(255, 255, 255), function(color)
    game:GetService('Players').LocalPlayer.PlayerGui.MainScreenGui.Aim.Bottom.BackgroundColor3 = color
end)

local LeftCursorToggle = testSection:AddToggle('Left', true, function(Boolean)
    game:GetService('Players').LocalPlayer.PlayerGui.MainScreenGui.Aim.Left.Visible = Boolean
end)

local LeftCursorColor = LeftCursorToggle:AddColorpicker(Color3.fromRGB(255, 255, 255), function(color)
    game:GetService('Players').LocalPlayer.PlayerGui.MainScreenGui.Aim.Left.BackgroundColor3 = color
end)

local RightCursorToggle = testSection:AddToggle('Right', true, function(Boolean)
    game:GetService('Players').LocalPlayer.PlayerGui.MainScreenGui.Aim.Right.Visible = Boolean
end)

local RightCursorColor = RightCursorToggle:AddColorpicker(Color3.fromRGB(255, 255, 255), function(color)
    game:GetService('Players').LocalPlayer.PlayerGui.MainScreenGui.Aim.Right.BackgroundColor3 = color
end)

local Spin = testSection:AddToggle('Spin', false, function(Boolean)
    getgenv().SpinningCursor = Boolean
end)

testSection:AddSlider("Spinning Cursor Speed", 0, 1, 50, 1, function(Value)
    getgenv().SpinPower = Value
end)

testSection:AddToggle('Swastika', false, function(Boolean)
    Swastika.Visible = Boolean
end):AddColorpicker(Color3.fromRGB(255,255,255), function(Color)
    Swastika.TextColor3 = Color 
end)

testSection:AddToggle('Rainbow', false, function(Boolean)
    LuaHVH.Cursor.Rainbow = Boolean 
end)

testSection:AddToggle('Spinning Swastika', false, function(Boolean)
    LuaHVH.Cursor.Spin = Boolean 
end)

testSection:AddSlider("Swastika Spin Speed", 0, 1, 50, 1, function(Value)
   LuaHVH.Cursor.SpinSpeed = Value  
end)

SettingTab:CreateConfigSystem("left")

local LibrarySettings = SettingTab:CreateSector("Other", "right") 

LibrarySettings:AddLabel"Script : LuaHVH"
LibrarySettings:AddLabel"Version : 0.0.2 Trial"

LibrarySettings:AddButton("Copy Discord Invite Link", function(IhateGayPeople)
setclipboard("https://discord.gg/VYh3pJZqCP")
game.StarterGui:SetCore(
            "SendNotification",
            {
                Title = "LuaHVH On Top",
                Text = "Copied discord invite"
            }
        )
end)

LibrarySettings:AddToggle('No FPS Cap', true, function(Boolean)
    if Boolean then 
        setfpscap(99999)
    end 
end)

LibrarySettings:AddTextbox("FPS Cap", nil, function(Text)
    setfpscap(Text)
end)

LibrarySettings:AddButton("Kill Roblox", function()
game:Shutdown()
end)

LibrarySettings:AddButton("Copy JobId", function()
setclipboard(game.JobId)
end)

LibrarySettings:AddButton("Copy Game Id", function()
setclipboard(game.GameId)
end)

LibrarySettings:AddButton("Copy Game Invite", function()
setclipboard('Roblox.GameLauncher.joinGameInstance('..game.PlaceId..',"'..game.JobId..'")')
end)

LibrarySettings:AddButton("Low GFX", function()
for _,v in pairs(workspace:GetDescendants()) do
    if v.ClassName == "Part"
    or v.ClassName == "SpawnLocation"
    or v.ClassName == "WedgePart"
    or v.ClassName == "Terrain"
    or v.ClassName == "MeshPart" then
    v.Material = "Plastic"
    end
end
end)

LibrarySettings:AddButton("Rejoin", function()
game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId)
end)

RunService.Heartbeat:connect(function()

if LuaHVH.RageBot.Enabled then 
    
    
        
    if game:GetService("Players").LocalPlayer.Character:FindFirstChildWhichIsA("Tool") ~= nil then
        if game:GetService("Players").LocalPlayer.Character:FindFirstChildWhichIsA("Tool"):FindFirstChild("Ammo") then
            if game:GetService("Players").LocalPlayer.Character:FindFirstChildWhichIsA("Tool"):FindFirstChild("Ammo").Value <= 0 then
                game:GetService("ReplicatedStorage").MainEvent:FireServer(
                "Reload",
                game:GetService("Players").LocalPlayer.Character:FindFirstChildWhichIsA("Tool")
                )
            end
        end
    end
        
    for _,q in pairs (game:GetService("Players"):GetPlayers()) do 
        if q ~= LocalPlayer and q and q.Character  then
            local RageBotD = (LocalPlayer.Character.HumanoidRootPart.Position - q.Character.HumanoidRootPart.Position).Magnitude
            if LuaHVH.RageBot.Distance > RageBotD and not CheckWall(q.Character.Head) then
                if q.Character.BodyEffects["K.O"].Value == false then
                    getgenv().RBTarget = q
                    
                    if getgenv().RBTarget ~= nil then 
                        LocalPlayer.Character:FindFirstChildOfClass("Tool"):Activate()
                    end 
                end 
            end
        end
    end
end

if getgenv().RBTarget ~= nil and LocalPlayer.Character:FindFirstChildWhichIsA("Tool") ~= nil then  
    if LocalPlayer.Information.Armory[tostring(LocalPlayer.Character:FindFirstChildWhichIsA("Tool"))].Ammo.Normal.Value > 0 and getgenv().RBTarget ~= nil then 
    if getgenv().RBTarget ~= nil then 
    LocalPlayer.Character:FindFirstChildOfClass("Tool"):Activate()
end 
end
end


if LuaHVH.RageBot.LookAt and getgenv().RBTarget ~= nil then 
            local OldCframe = LocalPlayer.Character.PrimaryPart
            local NearestRoot = getgenv().RBTarget.Character.HumanoidRootPart
            local NearestPos = CFrame.new(LocalPlayer.Character.PrimaryPart.Position, Vector3.new(NearestRoot.Position.X, OldCframe.Position.Y, NearestRoot.Position.Z))
            LocalPlayer.Character:SetPrimaryPartCFrame(NearestPos)
            LocalPlayer.Character.Humanoid.AutoRotate = false 
end 
    
    if LuaHVH.CamLock.AutoSetup == true then
    local pingvalue = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()
    local split = string.split(pingvalue,'(')
    local ping = tonumber(split[1])
    if ping < 130 then
        LuaHVH.CamLock.Prediction = 0.151
    elseif ping < 125 then
        LuaHVH.CamLock.Prediction = 0.149
    elseif ping < 110 then
        LuaHVH.CamLock.Prediction = 0.146
    elseif ping < 105 then
        LuaHVH.CamLock.Prediction = 0.138
    elseif ping < 90 then
        LuaHVH.CamLock.Prediction = 0.136
    elseif ping < 80 then
        LuaHVH.CamLock.Prediction = 0.134379
    elseif ping < 70 then
        LuaHVH.CamLock.Prediction = 0.129762
    elseif ping < 60 then
        LuaHVH.CamLock.Prediction = 0.1248976
    elseif ping < 50 then
        LuaHVH.CamLock.Prediction = 0.1245
    elseif ping < 40 then
        LuaHVH.CamLock.Prediction = 0.13232
            end 
    end  

if LuaHVH.target.RandomHP then 
    LuaHVH.target.Part = BodyParts[math.random(0,#BodyParts)]
end

if LuaHVH.CamLock.RandomHP then 
    LuaHVH.CamLock.Part = BodyParts[math.random(0,#BodyParts)]
end

if getgenv().CamLocking then 
    if getgenv().CLT ~= nil then
        if LuaHVH.CamLock.Enabled then 
            if LuaHVH.CamLock.Resolver then 
            getgenv().Main = CFrame.new(CurrentCamera.CFrame.p, getgenv().CLT.Character[LuaHVH.CamLock.Part].Position + (getgenv().CLT.Character.Humanoid.MoveDirection * 3 +
            Vector3.new(
                math.random(-LuaHVH.CamLock.ShakeValue, LuaHVH.CamLock.ShakeValue),
                math.random(-LuaHVH.CamLock.ShakeValue, LuaHVH.CamLock.ShakeValue),
                math.random(-LuaHVH.CamLock.ShakeValue, LuaHVH.CamLock.ShakeValue)
            ) * 0.1))
            CurrentCamera.CFrame = CurrentCamera.CFrame:Lerp(getgenv().Main, LuaHVH.CamLock.Smoothness, Enum.EasingStyle.Elastic, Enum.EasingDirection.InOut)
            else 
            getgenv().Main = CFrame.new(CurrentCamera.CFrame.p, getgenv().CLT.Character[LuaHVH.CamLock.Part].Position + (getgenv().CLT.Character.HumanoidRootPart.Velocity * LuaHVH.CamLock.Prediction +
            Vector3.new(
                math.random(-LuaHVH.CamLock.ShakeValue, LuaHVH.CamLock.ShakeValue),
                math.random(-LuaHVH.CamLock.ShakeValue, LuaHVH.CamLock.ShakeValue),
                math.random(-LuaHVH.CamLock.ShakeValue, LuaHVH.CamLock.ShakeValue)
            ) * 0.1))
            CurrentCamera.CFrame = CurrentCamera.CFrame:Lerp(getgenv().Main, LuaHVH.CamLock.Smoothness, Enum.EasingStyle.Elastic, Enum.EasingDirection.InOut)
            end 
        end 
    end 
end 

if LuaHVH.Misc.AutoReload then 
    if game:GetService("Players").LocalPlayer.Character:FindFirstChildWhichIsA("Tool") ~= nil then
        if game:GetService("Players").LocalPlayer.Character:FindFirstChildWhichIsA("Tool"):FindFirstChild("Ammo") then
            if game:GetService("Players").LocalPlayer.Character:FindFirstChildWhichIsA("Tool"):FindFirstChild("Ammo").Value <= 0 then
                game:GetService("ReplicatedStorage").MainEvent:FireServer(
                "Reload",
                game:GetService("Players").LocalPlayer.Character:FindFirstChildWhichIsA("Tool")
                )
            end
        end
    end
end 

if LuaHVH.Misc.CustomGunSFX then 
    for i,v in pairs(LocalPlayer.Character:GetDescendants()) do 
        if v:IsA("Sound") and v.Name == "ShootSound" then 
            v.SoundId = LuaHVH.Misc.ID
            v.Volume  = LuaHVH.Misc.Volume
        end 
    end 
end 

if LuaHVH.Misc.PickUpMoney then 
    for __,v in pairs(game:GetService("Workspace").Ignored.Drop:GetChildren()) do 
        if v.Name == "MoneyDrop" then 
            if (v.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 25 then 
                fireclickdetector(v.ClickDetector)
            end 
        end 
    end 
end 

if Swastika.Visible then 
    CursorPath.Swastika.Position = UDim2.fromOffset(Mouse.X - 43, Mouse.Y - 39)

    if LuaHVH.Cursor.Rainbow then 
        CursorPath.Swastika.TextColor3 = Color3.fromHSV(tick() % 6 / 6, 1, 1)
    end 

    if LuaHVH.Cursor.Spin == true then 
        CursorPath.Swastika.Rotation = CursorPath.Swastika.Rotation +  LuaHVH.Cursor.SpinSpeed
    end 
end 
  
  if LuaHVH.Misc.AntiStomp then 
    if LocalPlayer.Character.Humanoid.Health < 50 then 
        for __,v in pairs(LocalPlayer.Character:GetDescendants()) do 
            if v:IsA("BasePart") then 
                v:Destroy()
            end 
        end 
    end 
end 

  if LuaHVH.Misc.AutoStomp then 
    game.ReplicatedStorage.MainEvent:FireServer("Stomp")
end 

       if LuaHVH.Misc.Speed then
       if LuaHVH.Misc.SpeedType == "CFSpeed" then
            LocalPlayer.Character.HumanoidRootPart.CFrame =
                LocalPlayer.Character.HumanoidRootPart.CFrame +
                LocalPlayer.Character.Humanoid.MoveDirection * LuaHVH.Misc.LolSpeed
                
        elseif LuaHVH.Misc.SpeedType == "BHop" then
        LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame + LocalPlayer.Character.Humanoid.MoveDirection * LuaHVH.Misc.LolSpeed
        if LocalPlayer.Character.Humanoid.MoveDirection.Magnitude > 0 and LocalPlayer.Character.Humanoid:GetState() ~= Enum.HumanoidStateType.Freefall then 
            LocalPlayer.Character.Humanoid.UseJumpPower = false 
            LocalPlayer.Character.Humanoid:ChangeState("Jumping")
            end
        end
   end

        if LuaHVH.Misc.Spinbot then
            LocalPlayer.Character.HumanoidRootPart.CFrame =
            LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(LuaHVH.Misc.SpinSpeed), 0)
        end
	
	if getgenv().SpinningCursor then
game:GetService("Players").LocalPlayer.PlayerGui.MainScreenGui.Aim.Rotation = game:GetService("Players").LocalPlayer.PlayerGui.MainScreenGui.Aim.Rotation + getgenv().SpinPower
end

if LuaHVH.Visual.CustomFOV then
CurrentCamera.FieldOfView = LuaHVH.Visual.FOV
end

if getgenv().TeleportBypass then 
        local lvle = LocalPlayer.Character.HumanoidRootPart.Velocity
        local lcf = LocalPlayer.Character.HumanoidRootPart.CFrame
        LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(1,1,1) * -(2^10)
        LocalPlayer.Character.HumanoidRootPart.CFrame = lcf * CFrame.Angles(0,0.001,0)
        RunService.RenderStepped:Wait()
        LocalPlayer.Character.HumanoidRootPart.Velocity = lvle
end 

if BulletTracers then 
    local ColourSequence = ColorSequence.new({
    ColorSequenceKeypoint.new(0,  BulletTracerColor),
    ColorSequenceKeypoint.new(1,  BulletTracerColor),
})

    for _,v in pairs(game:GetService("Workspace").Ignored:GetDescendants()) do 
        if v.Name == "BULLET_RAYS" then 
            if 100 > (v.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude then 
            v.GunBeam.Texture = "http://www.roblox.com/asset/?id=9150561638"
            v.GunBeam.Width0 = BulletWidth
            v.GunBeam.Width1 = BulletWidth
            v.GunBeam.Color = ColourSequence
        end 
        end 
end 
end
        end)
   
   
   
	local rawmetatable = getrawmetatable(game)
local old = rawmetatable.__namecall
setreadonly(rawmetatable, false)
rawmetatable.__namecall = newcclosure(function(...)
    local args = {...}
        if LuaHVH.RageBot.Enabled and getnamecallmethod() == "FireServer"  and args[2] == "UpdateMousePos" and getgenv().RBTarget ~= nil then
                if LuaHVH.RageBot.Resolver == false  then 
                args[3] = getgenv().RBTarget.Character[LuaHVH.RageBot.AimPart].Position + (getgenv().RBTarget.Character[LuaHVH.RageBot.AimPart].Velocity * LuaHVH.target.Prediction)
                else
                args[3] = getgenv().RBTarget.Character[LuaHVH.RageBot.AimPart].Position + (getgenv().RBTarget.Character.Humanoid.MoveDirection * 3)
        end 
            return old(unpack(args))
        end
    return old(...)
end)