getgenv().ExtractCC = function()
    -- Check if already running to prevent double loading
    if getgenv().ExtractLoaded then 
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Extract.cc",
            Text = "Extract.cc is Already loaded!",
            Duration = 5
        })
        return 
    end
    getgenv().ExtractLoaded = true

    -- [ UI LIBRARY INITIALIZATION ] --
    local Obsidian = loadstring(game:HttpGet("https://raw.githubusercontent.com/v1ncentw/Obsidian/main/ObsidianMain.lua"))()
    local Window = Obsidian:CreateWindow({
        Title = "Extract.cc | @eu3.d",
        Theme = "Dark"
    })

    -- [ SERVICES ] --
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local Lighting = game:GetService("Lighting")
    local LocalPlayer = Players.LocalPlayer
    local Camera = workspace.CurrentCamera
    local Mouse = LocalPlayer:GetMouse()
    local Debris = game:GetService("Debris")

    -- [ CORE STATE STORAGE ] --
    local Toggles = {
        AutoAirToggle = { Value = false },
        Camlock = { Value = true },
        LookAtPlayer = { Value = false },
        PredVisualizer = { Value = false },
        AntiGroundShot = { Value = false },
        WorldTimeToggle = { Value = false },
        WorldAmbientToggle = { Value = false },
        FFChams = { Value = false },
        CharacterTrail = { Value = false },
        AuraToggle = { Value = false },
        HitParticlesToggle = { Value = false },
        HitChamsToggle = { Value = false },
        HitShakeToggle = { Value = false },
        CrosshairToggle = { Value = false },
        CrosshairSpinToggle = { Value = false },
        CrosshairResizeToggle = { Value = false },
        CrosshairStickToggle = { Value = false },
        TargetOnly = { Value = false },
        BoxESP = { Value = false },
        TracerESP = { Value = false },
        NameESP = { Value = false },
        DistESP = { Value = false },
        ToolESP = { Value = false },
        HitSoundToggle = { Value = false },
        SilentEnabled = { Value = false },
        ShowFOV = { Value = false },
        SilentCamlock = { Value = false },
        SilentVisualizer = { Value = false },
        ResolverToggle = { Value = false },
        FakeLagToggle = { Value = false },
        TriggerbotToggle = { Value = false },
        SpinbotToggle = { Value = false },
        WallCheck = { Value = false },
        KOCheck = { Value = false },
        TeamCheck = { Value = false },
        AutoUnlock = { Value = false }
    }

    local Options = {
        TargetType = { Value = "Players" },
        JumpOffset = { Value = "0.27" },
        FallOffset = { Value = "0.27" },
        AirDelay = { Value = "0.23" },
        WorldTime = { Value = 12 },
        AmbientColor = { Value = Color3.new(1,1,1) },
        WorldBrightness = { Value = 2 },
        FFColor = { Value = Color3.fromRGB(180, 0, 255) },
        TrailColor = { Value = Color3.fromRGB(255, 255, 255) },
        SelectedAura = { Value = "Glow Aura" },
        SelectedHitEffect = { Value = "coom hit effects" },
        HitChamsColor = { Value = Color3.fromRGB(255, 0, 75) },
        HitChamsDuration = { Value = 1.5 },
        HitChamsTransparency = { Value = 0.4 },
        HitShakeIntensity = { Value = "Medium" },
        CrosshairColor = { Value = Color3.fromRGB(199, 110, 255) },
        CrosshairMode = { Value = "Center" },
        SelectedHitSound = { Value = "Default" },
        AimViewerTarget = { Value = "None" },
        FOVSize = { Value = 100 },
        FOVColor = { Value = Color3.new(1,1,1) },
        SilentPart = { Value = "Head" },
        SilentX = { Value = "0.1" },
        SilentY = { Value = "0.1" },
        SilentSmoothness = { Value = "0.1" },
        ShakeX = { Value = 0 },
        ShakeY = { Value = 0 },
        ShakeZ = { Value = 0 },
        ResolverMethod = { Value = "Recalculate" },
        LagTicks = { Value = 5 },
        AntiMethod = { Value = "Sky" },
        SpinSpeed = { Value = 50 },
        OrbitSpeed = { Value = 1 },
        OrbitDistance = { Value = 5 },
        OrbitHeight = { Value = 0 },
        CFrameSpeed = { Value = 1 },
        TargetPart = { Value = "HumanoidRootPart" },
        XPred = { Value = "0.1" },
        YPred = { Value = "0.1" },
        Smoothness = { Value = "0.9" },
        EasingStyle = { Value = "Linear" },
        EasingDirection = { Value = "InOut" },
        Method = { Value = "Index" }
    }

    -- [ VARIABLES ] --
    local LockActive = false
    local OrbitActive, CFrameActive, AntiLockActive = false, false
    local SpinbotActive = false
    local CurrentTarget = nil
    local SilentTarget = nil
    local OrbitTarget = nil
    local lastShot = 0
    local OrbitAngle = 0
    local SharedShake = Vector3.zero
    local ESP_Table = {}
    local lastHealths = {}
    local targetPosHistory = {}
    
    local OriginalMats = {} 
    local LagTicks = 0 
    local TargetNotified = nil 
    local MyTrail, TrailAtt0, TrailAtt1 
    local ActiveAuraParticles = {} 

    -- [ HITSOUND DATA ] --
    local HitSoundId = {
        ["Rust Headshot"]      = "rbxassetid://138750331387064",
        ["Neverlose"]          = "rbxassetid://110168723447153",
        ["Bubble"]             = "rbxassetid://6534947588",
        ["Laser"]              = "rbxassetid://7837461331",
        ["Steve"]              = "rbxassetid://4965083997",
        ["Call of Duty"]       = "rbxassetid://5952120301",
        ["Bat"]                = "rbxassetid://3333907347",
        ["TF2 Critical"]       = "rbxassetid://296102734",
        ["Saber"]              = "rbxassetid://8415678813",
        ["Bameware"]           = "rbxassetid://3124331820",
        ["Money"]              = "rbxassetid://13956013041",
        ["Notif"]              = "rbxassetid://6696469190",
        ["Shutter"]            = "rbxassetid://10066921516",
        ["RIFK7"]              = "rbxassetid://9102080552",
        ["LazerBeam"]          = "rbxassetid://130791043",
        ["WindowsXPError"]     = "rbxassetid://160715357",
        ["TF2Hitsound"]        = "rbxassetid://3455144981",
        ["TF2Bat"]             = "rbxassetid://3333907347",
        ["BowHit"]             = "rbxassetid://1053296915",
        ["Bow"]                = "rbxassetid://3442683707",
        ["OSU"]                = "rbxassetid://7147454322",
        ["OneNN"]              = "rbxassetid://7349055654",
        ["Rust"]               = "rbxassetid://6565371338",
        ["TF2Pan"]             = "rbxassetid://3431749479",
        ["Mario"]              = "rbxassetid://5709456554",
        ["Bell"]               = "rbxassetid://6534947240",
        ["Pick"]               = "rbxassetid://1347140027",
        ["Pop"]                = "rbxassetid://198598793",
        ["Sans"]               = "rbxassetid://3188795283",
        ["Fart"]               = "rbxassetid://130833677",
        ["Big"]                = "rbxassetid://5332005053",
        ["Vine"]               = "rbxassetid://5332680810",
        ["Bruh"]               = "rbxassetid://4578740568",
        ["Skeet"]              = "rbxassetid://5633695679",
        ["Fatality"]           = "rbxassetid://6534947869",
        ["Bonk"]               = "rbxassetid://5766898159",
        ["Minecraft"]          = "rbxassetid://5869422451",
        ["Gamesense"]          = "rbxassetid://4817809188",
        ["Bamboo"]             = "rbxassetid://3769434519",
        ["Crowbar"]            = "rbxassetid://546410481",
        ["Weeb"]               = "rbxassetid://6442965016",
        ["Beep"]               = "rbxassetid://8177256015",
        ["Bambi"]              = "rbxassetid://8437203821",
        ["Stone"]              = "rbxassetid://3581383408",
        ["Old Fatality"]       = "rbxassetid://6607142036",
        ["Click"]              = "rbxassetid://8053704437",
        ["Ding"]               = "rbxassetid://7149516994",
        ["Snow"]               = "rbxassetid://6455527632",
        ["Osu"]                = "rbxassetid://7149255551",
        ["TF2"]                = "rbxassetid://2868331684",
        ["Slime"]              = "rbxassetid://6916371803",
        ["Among Us"]           = "rbxassetid://5700183626",
        ["One"]                = "rbxassetid://7380502345",
        ["BulletDeflect"]      = "rbxassetid://1657157666",
        ["Default"]            = "rbxassetid://330595293",
        ["UwU"]                = "rbxassetid://8679659744",
        ["Cod"]                = "rbxassetid://160432334",
        ["Blood SFX"]          = "rbxassetid://8164951181",
        ["Blood Burst"]        = "rbxassetid://3781479909",
        ["Blood Hit"]          = "rbxassetid://429400881",
    }

    -- [ DRAWING SETUP - WHITE THEME ] --
    local PredictionTracer = Drawing.new("Line")
    PredictionTracer.Visible = false; PredictionTracer.Color = Color3.fromRGB(255, 255, 255)
    PredictionTracer.Thickness = 1.5; PredictionTracer.Transparency = 1

    local PredictionDot = Drawing.new("Circle")
    PredictionDot.Visible = false; PredictionDot.Color = Color3.fromRGB(255, 255, 255)
    PredictionDot.Thickness = 1; PredictionDot.Radius = 4; PredictionDot.Filled = true

    local SilentCircle = Drawing.new("Circle")
    SilentCircle.Visible = false; SilentCircle.Color = Color3.fromRGB(255, 255, 255)
    SilentCircle.Thickness = 1; SilentCircle.Filled = false

    local SilentVisualizerDot = Drawing.new("Circle")
    SilentVisualizerDot.Visible = false; SilentVisualizerDot.Color = Color3.fromRGB(255, 0, 0)
    SilentVisualizerDot.Thickness = 1; SilentVisualizerDot.Radius = 4; SilentVisualizerDot.Filled = true

    local AimViewerLine = Drawing.new("Line")
    AimViewerLine.Visible = false; AimViewerLine.Color = Color3.fromRGB(255, 0, 0)
    AimViewerLine.Thickness = 2; AimViewerLine.Transparency = 1

    -- [ SPINNING CROSSHAIR MODULE SETUP ] --
    getgenv().crosshair = {
        refreshrate = 0,
        position = Vector2.new(0, 0),
        width = 1.5,
        length = 10,
        radius = 11,
        color = Color3.fromRGB(199, 110, 255),
        spin = true,
        spin_speed = 150,
        spin_max = 340,
        spin_style = Enum.EasingStyle.Sine,
        resize = true,
        resize_speed = 150,
        resize_min = 5,
        resize_max = 22,
    }

    local old; old = hookfunction(Drawing.new, function(class, properties)
        local drawing = old(class)
        for i, v in next, properties or {} do
            drawing[i] = v
        end
        return drawing
    end)

    local inputservice = game:GetService('UserInputService')
    local tweenservice = game:GetService('TweenService')
    local last_render = 0

    local drawings = {
        crosshair = {},
        text = {
            Drawing.new('Text', {Size = 13, Font = 2, Outline = true, Text = '.', Color = Color3.new(1, 1, 1)}),
            Drawing.new('Text', {Size = 13, Font = 2, Outline = true, Text = "Extract.cc"}),
        },
    }

    for idx = 1, 8 do
        drawings.crosshair[idx] = Drawing.new('Line')
    end

    local function solve(angle, radius)
        return Vector2.new(
            math.sin(math.rad(angle)) * radius,
            math.cos(math.rad(angle)) * radius
        )
    end

    -- [ TABS CREATION ] --
    local TabAimlock = Window:AddTab("Aimlock")
    local TabVisuals = Window:AddTab("Visuals")
    local TabLegit   = Window:AddTab("Legit")
    local TabRage    = Window:AddTab("Rage")
    local TabSettings = Window:AddTab("Settings")

    -- [[ PIXEL TEXT STYLING ]] --
    local function StylePixelText(btn, text)
        btn.BackgroundTransparency = 1; btn.BorderSizePixel = 0
        btn.Font = Enum.Font.Arcade; btn.Text = "  " .. text .. "  "
        btn.TextSize = 28; btn.TextColor3 = Color3.new(1, 1, 1)

        local textStroke = Instance.new("UIStroke", btn)
        textStroke.Thickness = 2.5; textStroke.Color = Color3.new(0, 0, 0)
        textStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
    end
    
    -- Forward declaration for targeting
    local GetClosestToCrosshair

    -- [[ AIMLOCK CONFIGURATION ]] --
    TabAimlock:AddButton({
        Title = "Spawn Lock Button",
        Callback = function()
            local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
            local Btn = Instance.new("TextButton", ScreenGui)
            Btn.Size = UDim2.new(0, 75, 0, 75)
            Btn.Position = UDim2.new(0.5, 150, 0.5, -37)
            Btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            Btn.BackgroundTransparency = 0.4
            Btn.BorderSizePixel = 0
            Btn.Text = "E"
            Btn.Font = Enum.Font.Arcade
            Btn.TextSize = 55
            Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            Btn.Active, Btn.Draggable = true, true
            
            local uiCorner = Instance.new("UICorner")
            uiCorner.CornerRadius = UDim.new(0, 10)
            uiCorner.Parent = Btn
            
            local textStroke = Instance.new("UIStroke", Btn)
            textStroke.Thickness = 3; textStroke.Color = Color3.new(0, 0, 0)
            textStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual

            Btn.MouseButton1Click:Connect(function()
                LockActive = not LockActive
                Btn.TextColor3 = LockActive and Color3.fromRGB(255, 40, 100) or Color3.fromRGB(255, 255, 255)
                
                if not LockActive then
                    if TargetNotified then
                        print("speared " .. TargetNotified.Name)
                    elseif CurrentTarget then
                        print("speared " .. CurrentTarget.Name)
                    end
                    CurrentTarget = nil
                    TargetNotified = nil
                else
                    local initialTarget = GetClosestToCrosshair(false)
                    if initialTarget then
                        print("locked on " .. initialTarget.Name)
                        CurrentTarget = initialTarget
                        TargetNotified = initialTarget
                    else
                        print("No target in sight")
                        CurrentTarget = nil
                        TargetNotified = nil
                    end
                end
            end)
        end
    })

    TabAimlock:AddToggle({ Title = "Auto Air", Default = false, Callback = function(v) Toggles.AutoAirToggle.Value = v end })
    TabAimlock:AddDropdown({ Title = "Target Entity", Options = { 'Players', 'NPCs', 'Both' }, Default = "Players", Callback = function(v) Options.TargetType.Value = v end })
    TabAimlock:AddToggle({ Title = "Camlock", Default = true, Callback = function(v) Toggles.Camlock.Value = v end })
    TabAimlock:AddToggle({ Title = "Look At Player", Default = false, Callback = function(v) Toggles.LookAtPlayer.Value = v end })
    TabAimlock:AddToggle({ Title = "Prediction Visualizer", Default = false, Callback = function(v) Toggles.PredVisualizer.Value = v end })
    TabAimlock:AddToggle({ Title = "Anti Ground Shot", Default = false, Callback = function(v) Toggles.AntiGroundShot.Value = v end })
    TabAimlock:AddTextBox({ Title = "Jump Offset", Default = "0.27", Callback = function(v) Options.JumpOffset.Value = v end })
    TabAimlock:AddTextBox({ Title = "Fall Offset", Default = "0.27", Callback = function(v) Options.FallOffset.Value = v end })
    TabAimlock:AddTextBox({ Title = "Auto Air Delay", Default = "0.23", Callback = function(v) Options.AirDelay.Value = v end })
    
    TabAimlock:AddToggle({ Title = "Wall Check", Default = false, Callback = function(v) Toggles.WallCheck.Value = v end })
    TabAimlock:AddToggle({ Title = "KO Check", Default = false, Callback = function(v) Toggles.KOCheck.Value = v end })
    TabAimlock:AddToggle({ Title = "Team Check", Default = false, Callback = function(v) Toggles.TeamCheck.Value = v end })
    TabAimlock:AddToggle({ Title = "Auto Unlock", Default = false, Callback = function(v) Toggles.AutoUnlock.Value = v end })
    TabAimlock:AddDropdown({ Title = "Body Part Selection", Options = { 'Head', 'UpperTorso', 'Torso', 'LowerTorso', 'HumanoidRootPart' }, Default = "HumanoidRootPart", Callback = function(v) Options.TargetPart.Value = v end })
    
    TabAimlock:AddTextBox({ Title = "X Prediction", Default = "0.1", Callback = function(v) Options.XPred.Value = v end })
    TabAimlock:AddTextBox({ Title = "Y Prediction", Default = "0.1", Callback = function(v) Options.YPred.Value = v end })
    TabAimlock:AddTextBox({ Title = "Cam Smoothness", Default = "0.9", Callback = function(v) Options.Smoothness.Value = v end })
    TabAimlock:AddDropdown({ Title = "Easing Style", Options = { 'Linear', 'Sine', 'Back', 'Quad', 'Quart', 'Quint', 'Bounce', 'Elastic', 'Exponential', 'Circular', 'Cubic' }, Default = "Linear", Callback = function(v) Options.EasingStyle.Value = v end })
    TabAimlock:AddDropdown({ Title = "Easing Direction", Options = { 'In', 'Out', 'InOut' }, Default = "InOut", Callback = function(v) Options.EasingDirection.Value = v end })
    TabAimlock:AddDropdown({ Title = "Method", Options = { 'Index', 'Namecall' }, Default = "Index", Callback = function(v) Options.Method.Value = v end })

    -- [[ VISUALS CONFIGURATION ]] --
    TabVisuals:AddToggle({ Title = "Modify Time", Default = false, Callback = function(v) Toggles.WorldTimeToggle.Value = v end })
    TabVisuals:AddSlider({ Title = "Time of Day", Min = 0, Max = 24, Default = 12, Callback = function(v) Options.WorldTime.Value = v end })
    TabVisuals:AddToggle({ Title = "Modify Ambient", Default = false, Callback = function(v) Toggles.WorldAmbientToggle.Value = v end })
    TabVisuals:AddColorPicker({ Title = "Ambient Color", Default = Color3.new(1,1,1), Callback = function(v) Options.AmbientColor.Value = v end })
    TabVisuals:AddSlider({ Title = "Brightness", Min = 0, Max = 10, Default = 2, Callback = function(v) Options.WorldBrightness.Value = v end })

    TabVisuals:AddToggle({ Title = "ForceField Chams", Default = false, Callback = function(v) Toggles.FFChams.Value = v end })
    TabVisuals:AddColorPicker({ Title = "FF Color", Default = Color3.fromRGB(180, 0, 255), Callback = function(v) Options.FFColor.Value = v end })
    TabVisuals:AddToggle({ Title = "Character Trail", Default = false, Callback = function(v) Toggles.CharacterTrail.Value = v end })
    TabVisuals:AddColorPicker({ Title = "Trail Color", Default = Color3.fromRGB(255, 255, 255), Callback = function(v) Options.TrailColor.Value = v end })
    TabVisuals:AddToggle({ Title = "Aura Enabled", Default = false, Callback = function(v) Toggles.AuraToggle.Value = v end })
    TabVisuals:AddDropdown({ Title = "Aura Type", Options = { 'Glow Aura', 'Rings Aura', 'Electric Aura' }, Default = "Glow Aura", Callback = function(v) Options.SelectedAura.Value = v end })

    -- [ HIT EFFECTS ] --
    TabVisuals:AddToggle({ Title = "Hit Particles", Default = false, Callback = function(v) Toggles.HitParticlesToggle.Value = v end })
    TabVisuals:AddDropdown({ Title = "Particle Style", Options = { 'coom hit effects', 'nova hit effects', 'bubble hit effect' }, Default = "coom hit effects", Callback = function(v) Options.SelectedHitEffect.Value = v end })
    TabVisuals:AddToggle({ Title = "Hit Chams", Default = false, Callback = function(v) Toggles.HitChamsToggle.Value = v end })
    TabVisuals:AddColorPicker({ Title = "Hit Chams Color", Default = Color3.fromRGB(255, 0, 75), Callback = function(v) Options.HitChamsColor.Value = v end })
    TabVisuals:AddSlider({ Title = "Chams Duration", Min = 0.1, Max = 5, Default = 1.5, Callback = function(v) Options.HitChamsDuration.Value = v end })
    TabVisuals:AddSlider({ Title = "Chams Transparency", Min = 0, Max = 1, Default = 0.4, Callback = function(v) Options.HitChamsTransparency.Value = v end })
    TabVisuals:AddToggle({ Title = "Hit Camera Shake", Default = false, Callback = function(v) Toggles.HitShakeToggle.Value = v end })
    TabVisuals:AddDropdown({ Title = "Shake Impact Force", Options = { 'Light', 'Medium', 'Heavy' }, Default = "Medium", Callback = function(v) Options.HitShakeIntensity.Value = v end })

    -- [ SPINNING CROSSHAIR ] --
    TabVisuals:AddToggle({ Title = "Crosshair Enabled", Default = false, Callback = function(v) Toggles.CrosshairToggle.Value = v end })
    TabVisuals:AddColorPicker({ Title = "Crosshair Color", Default = Color3.fromRGB(199, 110, 255), Callback = function(v) Options.CrosshairColor.Value = v end })
    TabVisuals:AddToggle({ Title = "Crosshair Spin", Default = false, Callback = function(v) Toggles.CrosshairSpinToggle.Value = v end })
    TabVisuals:AddToggle({ Title = "Crosshair Resizing", Default = false, Callback = function(v) Toggles.CrosshairResizeToggle.Value = v end })
    TabVisuals:AddToggle({ Title = "Stick to Target", Default = false, Callback = function(v) Toggles.CrosshairStickToggle.Value = v end })
    TabVisuals:AddDropdown({ Title = "Placement Position", Options = { 'Center', 'Mouse' }, Default = "Center", Callback = function(v) Options.CrosshairMode.Value = v end })

    -- [ ESP STYLING ] --
    TabVisuals:AddToggle({ Title = "Target Only", Default = false, Callback = function(v) Toggles.TargetOnly.Value = v end })
    TabVisuals:AddToggle({ Title = "Box ESP", Default = false, Callback = function(v) Toggles.BoxESP.Value = v end })
    TabVisuals:AddColorPicker({ Title = "Box Color", Default = Color3.new(1, 1, 1), Callback = function(v) Options.BoxColor.Value = v end })
    TabVisuals:AddToggle({ Title = "Tracer ESP", Default = false, Callback = function(v) Toggles.TracerESP.Value = v end })
    TabVisuals:AddColorPicker({ Title = "Tracer Color", Default = Color3.new(1, 1, 1), Callback = function(v) Options.TracerColor.Value = v end })
    TabVisuals:AddToggle({ Title = "Name ESP", Default = false, Callback = function(v) Toggles.NameESP.Value = v end })
    TabVisuals:AddColorPicker({ Title = "Name Color", Default = Color3.new(1, 1, 1), Callback = function(v) Options.NameColor.Value = v end })
    TabVisuals:AddToggle({ Title = "Distance ESP", Default = false, Callback = function(v) Toggles.DistESP.Value = v end })
    TabVisuals:AddColorPicker({ Title = "Distance Color", Default = Color3.new(1, 1, 1), Callback = function(v) Options.DistColor.Value = v end })
    TabVisuals:AddToggle({ Title = "Tool ESP", Default = false, Callback = function(v) Toggles.ToolESP.Value = v end })
    TabVisuals:AddColorPicker({ Title = "Tool Color", Default = Color3.new(1, 1, 1), Callback = function(v) Options.ToolColor.Value = v end })

    -- [ HIT SOUNDS ] --
    TabVisuals:AddToggle({ Title = "Hit Sounds", Default = false, Callback = function(v) Toggles.HitSoundToggle.Value = v end })
    local soundNames = {}
    for name, _ in pairs(HitSoundId) do table.insert(soundNames, name) end
    table.sort(soundNames)
    TabVisuals:AddDropdown({ Title = "Sound Selection", Options = soundNames, Default = "Default", Callback = function(v) Options.SelectedHitSound.Value = v end })

    local function PlayHitSound()
        if Toggles.HitSoundToggle.Value then
            local sound = Instance.new("Sound")
            sound.SoundId = HitSoundId[Options.SelectedHitSound.Value]
            sound.Volume = 3; sound.Parent = game:GetService("SoundService")
            sound:Play(); Debris:AddItem(sound, 2)
        end
    end

    -- [[ DYNAMIC EFFECTS UTILITY ENGINE ]] --
    local function SpawnHitEffects(position, character)
        if Toggles.HitParticlesToggle.Value and position then
            local part = Instance.new("Part")
            part.Size = Vector3.new(0.1, 0.1, 0.1)
            part.Position = position
            part.Anchored = true; part.CanCollide = false; part.Transparency = 1
            part.Parent = workspace

            local emitter = Instance.new("ParticleEmitter")
            emitter.Rate = 0; emitter.Speed = NumberRange.new(5, 15); emitter.Lifetime = NumberRange.new(0.5, 1.2)
            emitter.Parent = part

            local style = Options.SelectedHitEffect.Value
            if style == "coom hit effects" then
                emitter.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255))
                emitter.LightEmission = 0.2
                emitter.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.8), NumberSequenceKeypoint.new(1, 0)})
                emitter.Texture = "rbxassetid://242293495"
            elseif style == "nova hit effects" then
                emitter.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 100, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 0, 255))})
                emitter.LightEmission = 0.9
                emitter.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.2, 2.5), NumberSequenceKeypoint.new(1, 0)})
                emitter.Texture = "rbxassetid://244221447"
            elseif style == "bubble hit effect" then
                emitter.Color = ColorSequence.new(Color3.fromRGB(0, 200, 255))
                emitter.LightEmission = 0.4
                emitter.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.4), NumberSequenceKeypoint.new(1, 1.5)})
                emitter.Texture = "rbxassetid://6534947588"
            end

            emitter:Emit(35)
            Debris:AddItem(part, 2)
        end

        if Toggles.HitChamsToggle.Value and character then
            local highlight = Instance.new("Highlight")
            highlight.FillColor = Options.HitChamsColor.Value
            highlight.OutlineColor = Options.HitChamsColor.Value
            highlight.FillTransparency = Options.HitChamsTransparency.Value
            highlight.OutlineTransparency = Options.HitChamsTransparency.Value
            highlight.Adornee = character; highlight.Parent = character
            Debris:AddItem(highlight, Options.HitChamsDuration.Value)
        end

        if Toggles.HitShakeToggle.Value then
            task.spawn(function()
                local mult = 1
                if Options.HitShakeIntensity.Value == "Light" then mult = 0.3
                elseif Options.HitShakeIntensity.Value == "Heavy" then mult = 2.2 end
                
                for i = 1, 6 do
                    local shake = Vector3.new(math.random(-10, 10)/100, math.random(-10, 10)/100, math.random(-10, 10)/100) * mult
                    Camera.CFrame = Camera.CFrame * CFrame.new(shake)
                    task.wait(0.02)
                end
            end)
        end
    end

    -- [[ LEGIT SYSTEM SETUPS ]] --
    local PlayerDropdown = TabLegit:AddDropdown({ Title = "Select Player", Options = {"None"}, Default = "None", Callback = function(v) Options.AimViewerTarget.Value = v end })
    
    TabLegit:AddButton({
        Title = "Refresh Players",
        Callback = function()
            local list = {}
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LocalPlayer then table.insert(list, p.Name) end
            end
            if #list == 0 then table.insert(list, "None") end
            if PlayerDropdown and PlayerDropdown.Refresh then
                PlayerDropdown:Refresh(list)
            elseif PlayerDropdown and PlayerDropdown.Update then
                PlayerDropdown:Update(list)
            end
        end
    })

    TabLegit:AddToggle({ Title = "Aim Viewer", Default = false, Callback = function(v) Toggles.AimViewerToggle.Value = v end })
    TabLegit:AddToggle({ Title = "Spectate Player", Default = false, Callback = function(v) Toggles.SpectateToggle.Value = v end })
    TabLegit:AddToggle({ Title = "Silent Aim", Default = false, Callback = function(v) Toggles.SilentEnabled.Value = v end })
    TabLegit:AddToggle({ Title = "FOV Circle", Default = false, Callback = function(v) Toggles.ShowFOV.Value = v end })
    TabLegit:AddColorPicker({ Title = "FOV Color", Default = Color3.new(1,1,1), Callback = function(v) Options.FOVColor.Value = v end })
    TabLegit:AddSlider({ Title = "FOV Radius", Min = 1, Max = 500, Default = 100, Callback = function(v) Options.FOVSize.Value = v end })
    TabLegit:AddDropdown({ Title = "Target Part", Options = { 'Head', 'UpperTorso', 'Torso', 'LowerTorso', 'HumanoidRootPart' }, Default = "Head", Callback = function(v) Options.SilentPart.Value = v end })
    TabLegit:AddTextBox({ Title = "Prediction X", Default = "0.1", Callback = function(v) Options.SilentX.Value = v end })
    TabLegit:AddTextBox({ Title = "Prediction Y", Default = "0.1", Callback = function(v) Options.SilentY.Value = v end })
    TabLegit:AddToggle({ Title = "Camlock (Silent)", Default = false, Callback = function(v) Toggles.SilentCamlock.Value = v end })
    TabLegit:AddTextBox({ Title = "Cam Smoothness", Default = "0.1", Callback = function(v) Options.SilentSmoothness.Value = v end })
    TabLegit:AddToggle({ Title = "Prediction Visualizer (Silent)", Default = false, Callback = function(v) Toggles.SilentVisualizer.Value = v end })
    
    TabLegit:AddSlider({ Title = "Shake X", Min = 0, Max = 1, Default = 0, Callback = function(v) Options.ShakeX.Value = v end })
    TabLegit:AddSlider({ Title = "Shake Y", Min = 0, Max = 1, Default = 0, Callback = function(v) Options.ShakeY.Value = v end })
    TabLegit:AddSlider({ Title = "Shake Z", Min = 0, Max = 1, Default = 0, Callback = function(v) Options.ShakeZ.Value = v end })

    -- [[ RAGE SYSTEM SETUPS ]] --
    TabRage:AddToggle({ Title = "Resolver", Default = false, Callback = function(v) Toggles.ResolverToggle.Value = v end })
    TabRage:AddDropdown({ Title = "Method", Options = { 'Recalculate', 'Velocity Null', 'LookVector' }, Default = "Recalculate", Callback = function(v) Options.ResolverMethod.Value = v end })
    TabRage:AddToggle({ Title = "Fake Lag", Default = false, Callback = function(v) Toggles.FakeLagToggle.Value = v end })
    TabRage:AddSlider({ Title = "Lag Ticks", Min = 1, Max = 15, Default = 5, Callback = function(v) Options.LagTicks.Value = v end })
    TabRage:AddToggle({ Title = "Triggerbot", Default = false, Callback = function(v) Toggles.TriggerbotToggle.Value = v end })

    TabRage:AddButton({
        Title = "Antilock Toggle Button",
        Callback = function()
            local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
            local Btn = Instance.new("TextButton", ScreenGui)
            Btn.Size = UDim2.new(0, 180, 0, 50); Btn.Position = UDim2.new(0.5, -90, 0.20, 0)
            StylePixelText(Btn, "Antilock")
            Btn.Active, Btn.Draggable = true, true
            
            Btn.MouseButton1Click:Connect(function()
                AntiLockActive = not AntiLockActive
                Btn.TextColor3 = AntiLockActive and Color3.fromRGB(255, 0, 0) or Color3.new(1, 1, 1)
            end)
        end
    })
    TabRage:AddDropdown({ Title = "Antilock Method", Options = { 'Sky', 'Shake', 'Underground', 'Back' }, Default = "Sky", Callback = function(v) Options.AntiMethod.Value = v end })

    TabRage:AddToggle({ Title = "Spinbot", Default = false, Callback = function(v) Toggles.SpinbotToggle.Value = v; SpinbotActive = v end })
    TabRage:AddSlider({ Title = "Spin Speed", Min = 0, Max = 100, Default = 50, Callback = function(v) Options.SpinSpeed.Value = v end })

    TabRage:AddButton({
        Title = "Orbit Toggle Button",
        Callback = function()
            local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
            local Btn = Instance.new("TextButton", ScreenGui)
            Btn.Size = UDim2.new(0, 180, 0, 50); Btn.Position = UDim2.new(0.5, -90, 0.55, 0)
            StylePixelText(Btn, "Orbit")
            Btn.Active, Btn.Draggable = true, true
            
            Btn.MouseButton1Click:Connect(function()
                OrbitActive = not OrbitActive
                Btn.TextColor3 = OrbitActive and Color3.fromRGB(255, 0, 0) or Color3.new(1, 1, 1)
                
                if OrbitActive then
                    OrbitTarget = GetClosestToCrosshair(true) 
                    if OrbitTarget and OrbitTarget.Character then
                        local tHum = OrbitTarget.Character:FindFirstChildOfClass("Humanoid")
                        if tHum then Camera.CameraSubject = tHum end
                    end
                else
                    OrbitTarget = nil
                    if not Toggles.SpectateToggle.Value and LocalPlayer.Character then
                        local myHum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                        if myHum then Camera.CameraSubject = myHum end
                    end
                end
            end)
        end
    })
    TabRage:AddSlider({ Title = "Orbit Speed", Min = 1, Max = 100, Default = 1, Callback = function(v) Options.OrbitSpeed.Value = v end })
    TabRage:AddSlider({ Title = "Orbit Distance", Min = 1, Max = 100, Default = 5, Callback = function(v) Options.OrbitDistance.Value = v end })
    TabRage:AddSlider({ Title = "Orbit Height", Min = 0, Max = 100, Default = 0, Callback = function(v) Options.OrbitHeight.Value = v end })

    TabRage:AddButton({
        Title = "CFrame Toggle Button",
        Callback = function()
            local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
            local Btn = Instance.new("TextButton", ScreenGui)
            Btn.Size = UDim2.new(0, 180, 0, 50); Btn.Position = UDim2.new(0.5, -90, 0.68, 0)
            StylePixelText(Btn, "Cframe")
            Btn.Active, Btn.Draggable = true, true
            
            Btn.MouseButton1Click:Connect(function()
                CFrameActive = not CFrameActive
                Btn.TextColor3 = CFrameActive and Color3.fromRGB(255, 0, 0) or Color3.new(1, 1, 1)
            end)
        end
    })
    TabRage:AddSlider({ Title = "CFrame Speed", Min = 1, Max = 100, Default = 1, Callback = function(v) Options.CFrameSpeed.Value = v end })

    -- [[ SETTINGS ]] --
    TabSettings:AddLabel("Configuration Engine Loaded Successfully.")

    -- [[ ENTITY CACHING SYSTEM FOR NPCS ]] --
    local CachedNPCs = {}
    task.spawn(function()
        while task.wait(3) do
            local npcs = {}
            for _, v in ipairs(workspace:GetDescendants()) do
                if v:IsA("Model") and v ~= LocalPlayer.Character then
                    local hum = v:FindFirstChildOfClass("Humanoid")
                    local root = v:FindFirstChild("HumanoidRootPart")
                    if hum and root and hum.Health > 0 then
                        if not Players:GetPlayerFromCharacter(v) then table.insert(npcs, v) end
                    end
                end
            end
            CachedNPCs = npcs
        end
    end)

    local function GetEntities()
        local entities = {}
        local mode = Options.TargetType.Value

        if mode == 'Players' or mode == 'Both' then
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    table.insert(entities, { Type = "Player", Character = p.Character, Name = p.Name, Team = p.Team })
                end
            end
        end

        if mode == 'NPCs' or mode == 'Both' then
            for _, npc in ipairs(CachedNPCs) do
                if npc and npc.Parent and npc:FindFirstChild("HumanoidRootPart") then
                    local hum = npc:FindFirstChildOfClass("Humanoid")
                    if hum and hum.Health > 0 then
                        table.insert(entities, { Type = "NPC", Character = npc, Name = npc.Name, Team = nil })
                    end
                end
            end
        end
        return entities
    end

    -- [[ LOGIC HELPERS ]] --
    local function GetKnockStatus(ent)
        if not ent or not ent.Character then return false end
        local hum = ent.Character:FindFirstChildOfClass("Humanoid")
        if hum and hum.Health <= 5 then return true end
        local be = ent.Character:FindFirstChild("BodyEffects")
        if be then
            local ko = be:FindFirstChild("K.O") or be:FindFirstChild("KO")
            if ko and ko.Value then return true end
        end
        return false
    end

    local function IsVisible(part)
        if not Toggles.WallCheck.Value then return true end
        local params = RaycastParams.new()
        params.FilterType = Enum.RaycastFilterType.Exclude
        params.FilterDescendantsInstances = {LocalPlayer.Character, part.Parent, Camera}
        local result = workspace:Raycast(Camera.CFrame.Position, (part.Position - Camera.CFrame.Position), params)
        return result == nil
    end

    function GetClosestToCrosshair(ignoreWallsAndKnock)
        local target, closest = nil, math.huge
        local center = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
        for _, ent in ipairs(GetEntities()) do
            if Toggles.TeamCheck.Value and ent.Type == "Player" and ent.Team == LocalPlayer.Team then continue end
            if not ignoreWallsAndKnock and GetKnockStatus(ent) then continue end

            local root = ent.Character.HumanoidRootPart
            local screenPos, onScreen = Camera:WorldToViewportPoint(root.Position)
            if onScreen then
                local dist = (Vector2.new(screenPos.X, screenPos.Y) - center).Magnitude
                if dist < closest then
                    if ignoreWallsAndKnock or IsVisible(root) then
                        closest = dist; target = ent
                    end
                end
            end
        end
        return target
    end

    local function GetSilentTarget()
        local target, closest = nil, Options.FOVSize.Value
        local center = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
        for _, ent in ipairs(GetEntities()) do
            if Toggles.TeamCheck.Value and ent.Type == "Player" and ent.Team == LocalPlayer.Team then continue end
            if Toggles.KOCheck.Value and GetKnockStatus(ent) then continue end
            local root = ent.Character.HumanoidRootPart
            local screenPos, onScreen = Camera:WorldToViewportPoint(root.Position)
            if onScreen and IsVisible(root) then
                local dist = (Vector2.new(screenPos.X, screenPos.Y) - center).Magnitude
                if dist < closest then 
                    target = ent; closest = dist 
                end
            end
        end
        return target
    end

    -- DYNAMIC ESP SETUP
    local function GetESP(char)
        if not ESP_Table[char] then
            ESP_Table[char] = { Box = Drawing.new("Square"), Tracer = Drawing.new("Line"), Name = Drawing.new("Text"), Dist = Drawing.new("Text"), Tool = Drawing.new("Text") }
            for _, v in pairs(ESP_Table[char]) do
                v.Visible = false
                if v.Size ~= nil and typeof(v.Size) == "number" then v.Size = 14 v.Center = true v.Outline = true end
                if v.Filled ~= nil then v.Filled = false end
            end
        end
        return ESP_Table[char]
    end

    local originalLighting = {
        ClockTime = Lighting.ClockTime,
        Ambient = Lighting.Ambient,
        Brightness = Lighting.Brightness
    }

    -- [[ MAIN ENGINE SIMULATION LOOP ]] --
    RunService.Heartbeat:Connect(function(dt)
        local char = LocalPlayer.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        
        -- World Visuals
        if Toggles.WorldTimeToggle.Value then
            Lighting.ClockTime = Options.WorldTime.Value
        else
            Lighting.ClockTime = originalLighting.ClockTime
        end

        if Toggles.WorldAmbientToggle.Value then
            Lighting.Ambient = Options.AmbientColor.Value
            Lighting.Brightness = Options.WorldBrightness.Value
        else
            Lighting.Ambient = originalLighting.Ambient
            Lighting.Brightness = originalLighting.Brightness
        end

        -- Self ForceField Chams
        if char then
            if Toggles.FFChams.Value then
                for _, part in ipairs(char:GetDescendants()) do
                    if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                        if not OriginalMats[part] then
                            OriginalMats[part] = { Material = part.Material, Color = part.Color }
                        end
                        part.Material = Enum.Material.ForceField
                        part.Color = Options.FFColor.Value
                    end
                end
            else
                for part, data in pairs(OriginalMats) do
                    if part and part.Parent then
                        part.Material = data.Material
                        part.Color = data.Color
                    end
                end
                OriginalMats = {}
            end
        end

        -- Character Trail Engine Loop
        if char and root then
            if Toggles.CharacterTrail.Value then
                if not MyTrail or not MyTrail.Parent or MyTrail.Parent ~= root then
                    if MyTrail then MyTrail:Destroy() end
                    if TrailAtt0 then TrailAtt0:Destroy() end
                    if TrailAtt1 then TrailAtt1:Destroy() end

                    TrailAtt0 = Instance.new("Attachment")
                    TrailAtt0.Name = "TrailAttachment0"; TrailAtt0.Position = Vector3.new(0, 1.4, 0); TrailAtt0.Parent = root
                    TrailAtt1 = Instance.new("Attachment")
                    TrailAtt1.Name = "TrailAttachment1"; TrailAtt1.Position = Vector3.new(0, -1.4, 0); TrailAtt1.Parent = root

                    MyTrail = Instance.new("Trail")
                    MyTrail.Name = "SelfMovementTrail"; MyTrail.Attachment0 = TrailAtt0; MyTrail.Attachment1 = TrailAtt1
                    MyTrail.FaceCamera = true; MyTrail.Lifetime = 0.5
                    
                    MyTrail.WidthScale = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1.2), NumberSequenceKeypoint.new(0.5, 0.6), NumberSequenceKeypoint.new(1, 0) })
                    MyTrail.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.1), NumberSequenceKeypoint.new(1, 1) })
                    MyTrail.LightEmission = 0.85; MyTrail.Texture = "rbxassetid://4011115456"; MyTrail.Parent = root
                end
                if MyTrail then MyTrail.Color = ColorSequence.new(Options.TrailColor.Value) end
            else
                if MyTrail then MyTrail:Destroy(); MyTrail = nil end
                if TrailAtt0 then TrailAtt0:Destroy(); TrailAtt0 = nil end
                if TrailAtt1 then TrailAtt1:Destroy(); TrailAtt1 = nil end
            end
        else
            if MyTrail then MyTrail:Destroy(); MyTrail = nil end
            if TrailAtt0 then TrailAtt0:Destroy(); TrailAtt0 = nil end
            if TrailAtt1 then TrailAtt1:Destroy(); TrailAtt1 = nil end
        end

        -- Aura Particle Management
        if char and root then
            if Toggles.AuraToggle.Value then
                local selected = Options.SelectedAura.Value
                if not ActiveAuraParticles[selected] or not ActiveAuraParticles[selected].Parent then
                    for _, instance in pairs(ActiveAuraParticles) do instance:Destroy() end
                    ActiveAuraParticles = {}

                    local container = Instance.new("Attachment")
                    container.Name = "AuraContainerAttachment"; container.Parent = root

                    local emitter = Instance.new("ParticleEmitter")
                    emitter.Rate = 45; emitter.Parent = container

                    if selected == "Glow Aura" then
                        emitter.Texture = "rbxassetid://244221447"; emitter.Size = NumberSequence.new(3.5); emitter.Lifetime = NumberRange.new(0.6); emitter.Speed = NumberRange.new(0)
                        emitter.Color = ColorSequence.new(Color3.fromRGB(190, 0, 255)); emitter.LightEmission = 0.8
                    elseif selected == "Rings Aura" then
                        emitter.Texture = "rbxassetid://1084991219"; emitter.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 4)}); emitter.Lifetime = NumberRange.new(0.8)
                        emitter.Speed = NumberRange.new(1, 3); emitter.Color = ColorSequence.new(Color3.fromRGB(0, 255, 200)); emitter.RotSpeed = NumberRange.new(90)
                    elseif selected == "Electric Aura" then
                        emitter.Texture = "rbxassetid://281983280"; emitter.Size = NumberSequence.new(2); emitter.Lifetime = NumberRange.new(0.3); emitter.Speed = NumberRange.new(2, 6)
                        emitter.Color = ColorSequence.new(Color3.fromRGB(255, 230, 0)); emitter.LightEmission = 0.9
                    end
                    ActiveAuraParticles[selected] = container
                end
            else
                for k, instance in pairs(ActiveAuraParticles) do instance:Destroy() end
                ActiveAuraParticles = {}
            end
        else
            for k, instance in pairs(ActiveAuraParticles) do instance:Destroy() end
            ActiveAuraParticles = {}
        end

        -- Fake Lag Logic
        if Toggles.FakeLagToggle.Value and root then
            LagTicks = LagTicks + 1
            if LagTicks >= Options.LagTicks.Value then
                if root.Anchored then root.Anchored = false else root.Anchored = true end
                LagTicks = 0
            end
        elseif root and root.Anchored and not Toggles.FakeLagToggle.Value then
            root.Anchored = false
        end

        -- Triggerbot Logic
        if Toggles.TriggerbotToggle.Value then
            local target = Mouse.Target
            if target and target.Parent and target.Parent:FindFirstChild("Humanoid") then
                local tPlayer = Players:GetPlayerFromCharacter(target.Parent)
                if tPlayer and tPlayer ~= LocalPlayer then
                    if not Toggles.TeamCheck.Value or tPlayer.Team ~= LocalPlayer.Team then
                        local tool = char:FindFirstChildOfClass("Tool")
                        if tool then tool:Activate() end
                    end
                end
            end
        end

        -- Aim Viewer Logic
        if Toggles.AimViewerToggle.Value and Options.AimViewerTarget.Value ~= "None" then
            local tPlayer = Players:FindFirstChild(Options.AimViewerTarget.Value)
            if tPlayer and tPlayer.Character and tPlayer.Character:FindFirstChild("Head") then
                local tHead = tPlayer.Character.Head
                local lookPos = tHead.Position + (tHead.CFrame.LookVector * 10)
                local headScreen, headOnScreen = Camera:WorldToViewportPoint(tHead.Position)
                local lookScreen, lookOnScreen = Camera:WorldToViewportPoint(lookPos)

                if headOnScreen or lookOnScreen then
                    AimViewerLine.Visible = true; AimViewerLine.From = Vector2.new(headScreen.X, headScreen.Y); AimViewerLine.To = Vector2.new(lookScreen.X, lookScreen.Y)
                else
                    AimViewerLine.Visible = false
                end
            else
                AimViewerLine.Visible = false
            end
        else
            AimViewerLine.Visible = false
        end

        -- Spectate Logic
        if Toggles.SpectateToggle.Value and Options.AimViewerTarget.Value ~= "None" then
            local tPlayer = Players:FindFirstChild(Options.AimViewerTarget.Value)
            if tPlayer and tPlayer.Character and tPlayer.Character:FindFirstChild("Humanoid") then
                Camera.CameraSubject = tPlayer.Character.Humanoid
            end
        elseif not OrbitActive and char and char:FindFirstChild("Humanoid") then
            if Camera.CameraSubject ~= char.Humanoid and not Toggles.SpectateToggle.Value then
                Camera.CameraSubject = char.Humanoid
            end
        end

        -- FOV Update
        if Toggles.ShowFOV.Value then
            SilentCircle.Visible = true; SilentCircle.Radius = Options.FOVSize.Value; SilentCircle.Color = Options.FOVColor.Value
            SilentCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
        else
            SilentCircle.Visible = false
        end

        -- Silent Aim Framework Updates
        if Toggles.SilentEnabled.Value then
            SilentTarget = GetSilentTarget()
            if SilentTarget and SilentTarget.Character then
                local sPart = SilentTarget.Character:FindFirstChild(Options.SilentPart.Value) or SilentTarget.Character:FindFirstChild("HumanoidRootPart")
                local sHum = SilentTarget.Character:FindFirstChildOfClass("Humanoid")
                if sPart then
                    local pX, pY = tonumber(Options.SilentX.Value) or 0.1, tonumber(Options.SilentY.Value) or 0.1
                    local sVel = sPart.Velocity
                    if Toggles.AntiGroundShot.Value and sVel.Y < -10 then sVel = Vector3.new(sVel.X, 0, sVel.Z) end
                    local pos = sPart.Position + (sVel * Vector3.new(pX, pY, pX)) + SharedShake
                    
                    if Toggles.SilentCamlock.Value then
                        local smooth = tonumber(Options.SilentSmoothness.Value) or 0.1
                        Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, pos), smooth)
                    end

                    if Toggles.SilentVisualizer.Value then
                        local screenPos, onScreen = Camera:WorldToViewportPoint(pos)
                        if onScreen then
                            SilentVisualizerDot.Visible = true; SilentVisualizerDot.Position = Vector2.new(screenPos.X, screenPos.Y)
                        else
                            SilentVisualizerDot.Visible = false
                        end
                    else
                        SilentVisualizerDot.Visible = false
                    end

                    if sHum then
                        local currentHealth = sHum.Health; local previousHealth = lastHealths[SilentTarget.Character] or currentHealth
                        if currentHealth < previousHealth then PlayHitSound(); SpawnHitEffects(sPart.Position, SilentTarget.Character) end
                        lastHealths[SilentTarget.Character] = currentHealth
                    end
                else
                    SilentVisualizerDot.Visible = false
                end
            else
                SilentVisualizerDot.Visible = false
            end
        else
            SilentTarget = nil; SilentVisualizerDot.Visible = false
        end

        -- Target Damage Hook Detection (Aimlock Focus)
        if LockActive and CurrentTarget and CurrentTarget.Character then
            local hum = CurrentTarget.Character:FindFirstChildOfClass("Humanoid"); local tPart = CurrentTarget.Character:FindFirstChild("HumanoidRootPart")
            if hum then
                local currentHealth = hum.Health; local previousHealth = lastHealths[CurrentTarget.Character] or currentHealth
                if currentHealth < previousHealth then PlayHitSound(); if tPart then SpawnHitEffects(tPart.Position, CurrentTarget.Character) end end
                lastHealths[CurrentTarget.Character] = currentHealth
            end
        end

        -- ESP Rendering Pipelines
        for espChar, drawing in pairs(ESP_Table) do
            if not espChar or not espChar.Parent then
                for _, v in pairs(drawing) do v:Remove() end
                ESP_Table[espChar] = nil
            else
                for _, v in pairs(drawing) do v.Visible = false end
            end
        end

        for _, ent in ipairs(GetEntities()) do
            local isTarget = false
            if Toggles.SilentEnabled.Value then isTarget = (SilentTarget and SilentTarget.Character == ent.Character)
            else isTarget = (CurrentTarget and CurrentTarget.Character == ent.Character) end
            
            local allowed = Toggles.TargetOnly.Value and isTarget or not Toggles.TargetOnly.Value
            
            if allowed and ent.Character and ent.Character:FindFirstChild("HumanoidRootPart") then
                local pRoot = ent.Character.HumanoidRootPart; local pPos, onScreen = Camera:WorldToViewportPoint(pRoot.Position)
                
                if onScreen then
                    local drawing = GetESP(ent.Character); local boxHeight = (Camera:WorldToViewportPoint(pRoot.Position - Vector3.new(0, 3.5, 0)).Y - Camera:WorldToViewportPoint(pRoot.Position + Vector3.new(0, 3, 0)).Y)
                    
                    drawing.Box.Visible = Toggles.BoxESP.Value
                    if drawing.Box.Visible then
                        drawing.Box.Size = Vector2.new(boxHeight * 0.6, boxHeight); drawing.Box.Position = Vector2.new(pPos.X - drawing.Box.Size.X / 2, pPos.Y - drawing.Box.Size.Y / 2); drawing.Box.Color = Options.BoxColor.Value
                    end

                    drawing.Tracer.Visible = Toggles.TracerESP.Value
                    if drawing.Tracer.Visible then
                        drawing.Tracer.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2); drawing.Tracer.To = Vector2.new(pPos.X, pPos.Y); drawing.Tracer.Color = Options.TracerColor.Value
                    end

                    drawing.Name.Visible = Toggles.NameESP.Value
                    if drawing.Name.Visible then
                        drawing.Name.Text = ent.Name; drawing.Name.Position = Vector2.new(pPos.X, pPos.Y - (boxHeight/2) - 18); drawing.Name.Color = Options.NameColor.Value
                    end

                    drawing.Dist.Visible = Toggles.DistESP.Value
                    if drawing.Dist.Visible and root then
                        drawing.Dist.Text = math.floor((root.Position - pRoot.Position).Magnitude) .. "m"; drawing.Dist.Position = Vector2.new(pPos.X, pPos.Y + (boxHeight/2) + 5); drawing.Dist.Color = Options.DistColor.Value
                    end

                    drawing.Tool.Visible = Toggles.ToolESP.Value
                    if drawing.Tool.Visible then
                        local tool = ent.Character:FindFirstChildOfClass("Tool")
                        drawing.Tool.Text = tool and tool.Name or "None"; drawing.Tool.Position = Vector2.new(pPos.X, pPos.Y + (boxHeight/2) + 18); drawing.Tool.Color = Options.ToolColor.Value
                    end
                end
            end
        end

        -- Spinbot, Anti-Lock, CFrame Math Loops
        if SpinbotActive and root then root.CFrame = root.CFrame * CFrame.Angles(0, math.rad(Options.SpinSpeed.Value), 0) end
        if AntiLockActive and root then
            local method = Options.AntiMethod.Value; local oldVelo = root.Velocity
            if method == 'Sky' then root.Velocity = Vector3.new(0, 9999, 0)
            elseif method == 'Shake' then root.Velocity = Vector3.new(math.random(-9999, 9999), math.random(-9999, 9999), math.random(-9999, 9999))
            elseif method == 'Underground' then root.Velocity = Vector3.new(0, -9999, 0)
            elseif method == 'Back' then root.Velocity = root.CFrame.LookVector * -9999 end
            RunService.RenderStepped:Wait() 
            if root then root.Velocity = oldVelo end 
        end
        if CFrameActive and root then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum and hum.MoveDirection.Magnitude > 0 then root.CFrame = root.CFrame + (hum.MoveDirection * Options.CFrameSpeed.Value * dt) end
        end

        -- Orbit Vector Mechanics
        if OrbitActive and OrbitTarget and OrbitTarget.Character then
            local tRoot = OrbitTarget.Character:FindFirstChild("HumanoidRootPart")
            if tRoot and root then
                OrbitAngle = OrbitAngle + (Options.OrbitSpeed.Value * dt)
                local cos, sin = math.cos(OrbitAngle), math.sin(OrbitAngle)
                local offset = Vector3.new(cos * Options.OrbitDistance.Value, Options.OrbitHeight.Value, sin * Options.OrbitDistance.Value)
                root.CFrame = CFrame.new(tRoot.Position + offset, tRoot.Position)
                root.Velocity = Vector3.zero
            end
        end

        -- Aimlock Optimization / Tween Tracking Sequences
        local CalculatedCrosshairPos = nil
        if LockActive then
            if CurrentTarget then
                local tChar = CurrentTarget.Character; local tHum = tChar and tChar:FindFirstChildOfClass("Humanoid")
                
                if not tChar or not tChar.Parent or (Toggles.AutoUnlock.Value and GetKnockStatus(CurrentTarget)) or (tHum and tHum.Health <= 0) then
                    if tHum and tHum.Health <= 0 then print(CurrentTarget.Name .. " Died LOL") else print("speared " .. CurrentTarget.Name) end
                    CurrentTarget = nil; TargetNotified = nil
                end
            end

            if not CurrentTarget then 
                CurrentTarget = GetClosestToCrosshair(false) 
                if CurrentTarget then print("locked on " .. CurrentTarget.Name); TargetNotified = CurrentTarget end
            elseif CurrentTarget ~= TargetNotified then
                if TargetNotified then print("speared " .. TargetNotified.Name) end
                print("locked on " .. CurrentTarget.Name); TargetNotified = CurrentTarget
            end

            if CurrentTarget and CurrentTarget.Character then
                local TargetPart = CurrentTarget.Character:FindFirstChild(Options.TargetPart.Value) or CurrentTarget.Character:FindFirstChild("HumanoidRootPart")
                local currentHum = CurrentTarget.Character:FindFirstChildOfClass("Humanoid")
                
                if TargetPart then
                    local ResolvedVelocity = TargetPart.Velocity
                    
                    if Toggles.ResolverToggle.Value then
                        local method = Options.ResolverMethod.Value
                        if method == "Recalculate" then
                            local lastPos = targetPosHistory[CurrentTarget.Character] or TargetPart.Position
                            ResolvedVelocity = (TargetPart.Position - lastPos) / dt; targetPosHistory[CurrentTarget.Character] = TargetPart.Position
                        elseif method == "Velocity Null" then
                            ResolvedVelocity = Vector3.new(math.clamp(ResolvedVelocity.X, -70, 70), math.clamp(ResolvedVelocity.Y, -70, 70), math.clamp(ResolvedVelocity.Z, -70, 70))
                        elseif method == "LookVector" then
                            ResolvedVelocity = TargetPart.CFrame.LookVector * TargetPart.Velocity.Magnitude
                        end
                    end
                    
                    if Toggles.AntiGroundShot.Value and ResolvedVelocity.Y < -10 then ResolvedVelocity = Vector3.new(ResolvedVelocity.X, 0, ResolvedVelocity.Z) end

                    local predX, predY = tonumber(Options.XPred.Value) or 0.1, tonumber(Options.YPred.Value) or 0.1
                    local PredPos = TargetPart.Position + (ResolvedVelocity * Vector3.new(predX, predY, predX))

                    if currentHum and (currentHum.FloorMaterial == Enum.Material.Air or currentHum:GetState() == Enum.HumanoidStateType.Freefall or currentHum:GetState() == Enum.HumanoidStateType.Jumping) then
                        if TargetPart.Velocity.Y > 0 then PredPos = PredPos + Vector3.new(0, tonumber(Options.JumpOffset.Value) or 0, 0)
                        else PredPos = PredPos + Vector3.new(0, tonumber(Options.FallOffset.Value) or 0, 0) end
                    end

                    local visible = IsVisible(TargetPart); local cScrPos, cOnScr = Camera:WorldToViewportPoint(PredPos)
                    if cOnScr then CalculatedCrosshairPos = Vector2.new(cScrPos.X, cScrPos.Y) end

                    if Toggles.PredVisualizer.Value then
                        local screenPos, onScreen = Camera:WorldToViewportPoint(PredPos); local partPos, partOnScreen = Camera:WorldToViewportPoint(TargetPart.Position)
                        if onScreen and partOnScreen then
                            PredictionTracer.Visible = true; PredictionTracer.From = Vector2.new(partPos.X, partPos.Y); PredictionTracer.To = Vector2.new(screenPos.X, screenPos.Y)
                            PredictionDot.Visible = true; PredictionDot.Position = Vector2.new(screenPos.X, screenPos.Y)
                        else
                            PredictionTracer.Visible = false; PredictionDot.Visible = false
                        end
                    else
                        PredictionTracer.Visible = false; PredictionDot.Visible = false
                    end

                    SharedShake = Vector3.new((math.random(-100, 100) / 250) * Options.ShakeX.Value, (math.random(-100, 100) / 250) * Options.ShakeY.Value, (math.random(-100, 100) / 250) * Options.ShakeZ.Value)

                    if Toggles.LookAtPlayer.Value and (not Toggles.WallCheck.Value or visible) then
                        root.CFrame = CFrame.new(root.Position, Vector3.new(PredPos.X, root.Position.Y, PredPos.Z))
                    end

                    if Toggles.Camlock.Value and (not Toggles.WallCheck.Value or visible) then
                        local smoothBase = tonumber(Options.Smoothness.Value) or 0.1; local currentLook = Camera.CFrame.LookVector
                        local targetLook = (PredPos + SharedShake - Camera.CFrame.Position).Unit; local dotProduct = currentLook:Dot(targetLook)
                        local angleDiff = math.acos(math.clamp(dotProduct, -1, 1)); local progress = math.clamp(angleDiff / 0.5, 0, 1)
                        
                        local TweenService = game:GetService("TweenService")
                        local success, easedFactor = pcall(function()
                            return TweenService:GetValue(progress, Enum.EasingStyle[Options.EasingStyle.Value], Enum.EasingDirection[Options.EasingDirection.Value])
                        end)
                        if not success or not easedFactor then easedFactor = progress end
                        
                        local adjustedSmooth = smoothBase * easedFactor
                        Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, PredPos + SharedShake), math.clamp(adjustedSmooth, 0, 1))
                    end
                    
                    if Toggles.AutoAirToggle.Value and visible and currentHum and (currentHum.FloorMaterial == Enum.Material.Air or currentHum:GetState() == Enum.HumanoidStateType.Freefall or currentHum:GetState() == Enum.HumanoidStateType.Jumping) then
                        if tick() - lastShot >= (tonumber(Options.AirDelay.Value) or 0.15) then
                            lastShot = tick(); local tool = char:FindFirstChildOfClass("Tool")
                            if tool then tool:Activate() end
                        end
                    end
                end
            else
                PredictionTracer.Visible = false; PredictionDot.Visible = false
            end
        else
            SharedShake = Vector3.zero; PredictionTracer.Visible = false; PredictionDot.Visible = false
        end

        -- [[ SPINNING CROSSHAIR ENGINE WORKER ]] --
        local _tick = tick()
        if _tick - last_render > crosshair.refreshrate then
            last_render = _tick

            local position = Camera.ViewportSize / 2
            if Toggles.CrosshairStickToggle.Value and CalculatedCrosshairPos then position = CalculatedCrosshairPos
            elseif Options.CrosshairMode.Value == 'Mouse' then position = inputservice:GetMouseLocation() end

            local text_x = drawings.text[1].TextBounds.X + drawings.text[2].TextBounds.X
            drawings.text[1].Visible = Toggles.CrosshairToggle.Value; drawings.text[2].Visible = Toggles.CrosshairToggle.Value

            if Toggles.CrosshairToggle.Value then
                drawings.text[1].Position = position + Vector2.new(-text_x / 2, crosshair.radius + (Toggles.CrosshairResizeToggle.Value and crosshair.resize_max or crosshair.length) + 15)
                drawings.text[2].Position = drawings.text[1].Position + Vector2.new(drawings.text[1].TextBounds.X); drawings.text[2].Color = Options.CrosshairColor.Value
                
                for idx = 1, 4 do
                    local outline = drawings.crosshair[idx]; local inline = drawings.crosshair[idx + 4]
                    local angle = (idx - 1) * 90; local length = crosshair.length
        
                    if Toggles.CrosshairSpinToggle.Value then
                        local spin_angle = -_tick * crosshair.spin_speed % crosshair.spin_max
                        angle = angle + tweenservice:GetValue(spin_angle / 360, crosshair.spin_style, Enum.EasingDirection.InOut) * 360
                    end
        
                    if Toggles.CrosshairResizeToggle.Value then
                        local resize_length = tick() * crosshair.resize_speed % 180
                        length = crosshair.resize_min + math.sin(math.rad(resize_length)) * crosshair.resize_max
                    end
        
                    inline.Visible = true; inline.Color = Options.CrosshairColor.Value
                    inline.From = position + solve(angle, crosshair.radius); inline.To = position + solve(angle, crosshair.radius + length); inline.Thickness = crosshair.width
        
                    outline.Visible = true; outline.From = position + solve(angle, crosshair.radius - 1); outline.To = position + solve(angle, crosshair.radius + length + 1); outline.Thickness = crosshair.width + 1.5    
                end
            else
                for idx = 1, 8 do drawings.crosshair[idx].Visible = false end
                drawings.text[1].Visible = false; drawings.text[2].Visible = false
            end
        end
    end)

    -- [[ SILENT AIM HOOKS ]] --
    local mt = getrawmetatable(game); local oldIndex = mt.__index
    setreadonly(mt, false)

    mt.__index = newcclosure(function(self, index)
        if not checkcaller() and self == Mouse and (index == "Hit" or index == "Target") then
            if Toggles.SilentEnabled.Value then
                local sTarget = SilentTarget
                if sTarget and sTarget.Character then
                    local sPart = sTarget.Character:FindFirstChild(Options.SilentPart.Value) or sTarget.Character:FindFirstChild("HumanoidRootPart")
                    local sHum = sTarget.Character:FindFirstChildOfClass("Humanoid")
                    
                    if sPart then
                        local pX, pY = tonumber(Options.SilentX.Value) or 0.1, tonumber(Options.SilentY.Value) or 0.1; local sVel = sPart.Velocity
                        if Toggles.AntiGroundShot.Value and sVel.Y < -10 then sVel = Vector3.new(sVel.X, 0, sVel.Z) end
                        local pos = sPart.Position + (sVel * Vector3.new(pX, pY, pX)) + SharedShake
                        
                        if sHum and (sHum.FloorMaterial == Enum.Material.Air or sHum:GetState() == Enum.HumanoidStateType.Freefall) then
                            if sPart.Velocity.Y > 0 then pos = pos + Vector3.new(0, tonumber(Options.JumpOffset.Value) or 0, 0)
                            else pos = pos + Vector3.new(0, tonumber(Options.FallOffset.Value) or 0, 0) end
                        end
                        return (index == "Hit" and CFrame.new(pos) or sPart)
                    end
                end
            end

            if LockActive and CurrentTarget and Options.Method.Value == "Index" then
                local TargetPart = CurrentTarget.Character:FindFirstChild(Options.TargetPart.Value) or CurrentTarget.Character:FindFirstChild("HumanoidRootPart")
                local cHum = CurrentTarget.Character:FindFirstChildOfClass("Humanoid")

                if TargetPart then
                    local predX, predY = tonumber(Options.XPred.Value) or 0.1, tonumber(Options.YPred.Value) or 0.1; local ResolvedVelocity = TargetPart.Velocity
                    
                    if Toggles.ResolverToggle.Value then
                        if Options.ResolverMethod.Value == "Velocity Null" then
                            ResolvedVelocity = Vector3.new(math.clamp(ResolvedVelocity.X, -70, 70), math.clamp(ResolvedVelocity.Y, -70, 70), math.clamp(ResolvedVelocity.Z, -70, 70))
                        end
                    end

                    if Toggles.AntiGroundShot.Value and ResolvedVelocity.Y < -10 then ResolvedVelocity = Vector3.new(ResolvedVelocity.X, 0, ResolvedVelocity.Z) end
                    local PredPos = TargetPart.Position + (ResolvedVelocity * Vector3.new(predX, predY, predX))
                    
                    if cHum and (cHum.FloorMaterial == Enum.Material.Air or cHum:GetState() == Enum.HumanoidStateType.Freefall) then
                        if TargetPart.Velocity.Y > 0 then PredPos = PredPos + Vector3.new(0, tonumber(Options.JumpOffset.Value) or 0, 0)
                        else PredPos = PredPos + Vector3.new(0, tonumber(Options.FallOffset.Value) or 0, 0) end
                    end
                    return (index == "Hit" and CFrame.new(PredPos) or TargetPart)
                end
            end
        end
        return oldIndex(self, index)
    end)
    setreadonly(mt, true)

    print("Extract.cc | Beta v4.2 Loaded into Obsidian UI Lib")
end

getgenv().ExtractCC()
