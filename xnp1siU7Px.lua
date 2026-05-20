getgenv().ExtractCC = function()
    if getgenv().ExtractLoaded then 
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Extract.cc",
            Text = "Extract.cc is Already loaded!",
            Duration = 5
        })
        return 
    end
    getgenv().ExtractLoaded = true

    -- [[ OBSIDIAN UI LIBRARY INITIALIZATION ]] --
    local Obsidian = loadstring(game:HttpGet("https://raw.githubusercontent.com/bhowizt/obsidian/main/source.lua"))()
    
    local Window = Obsidian:CreateWindow({
        Title = "Extract.cc",
        Subtitle = "@eu3.d | Beta v4.2",
        Link = "docs.mspaint.cc/obsidian"
    })

    -- [ SERVICES ] --
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local Lighting = game:GetService("Lighting")
    local LocalPlayer = Players.LocalPlayer
    local Camera = workspace.CurrentCamera
    local Mouse = LocalPlayer:GetMouse()
    local Debris = game:GetService("Debris")

    -- [ VARIABLES & COMBAT STATES ] --
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

    -- [[ COMPATIBILITY STATE BRIDGE ]] --
    -- Replicates Linoria's global tables so your main loops don't break
    local Toggles = {}
    local Options = {}

    local function RegisterToggle(id, default)
        Toggles[id] = { Value = default }
    end

    local function RegisterOption(id, default)
        Options[id] = { Value = default }
    end

    -- Pre-registering internal configuration keys
    RegisterToggle('AutoAirToggle', false)
    RegisterOption('TargetType', 'Players')
    RegisterToggle('Camlock', true)
    RegisterToggle('LookAtPlayer', false)
    RegisterToggle('PredVisualizer', false)
    RegisterToggle('AntiGroundShot', false)
    RegisterOption('JumpOffset', '0.27')
    RegisterOption('FallOffset', '0.27')
    RegisterOption('AirDelay', '0.23')
    RegisterToggle('WorldTimeToggle', false)
    RegisterOption('WorldTime', 12)
    RegisterToggle('WorldAmbientToggle', false)
    RegisterOption('AmbientColor', Color3.new(1,1,1))
    RegisterOption('WorldBrightness', 2)
    RegisterToggle('FFChams', false)
    RegisterOption('FFColor', Color3.fromRGB(180, 0, 255))
    RegisterToggle('CharacterTrail', false)
    RegisterOption('TrailColor', Color3.fromRGB(255, 255, 255))
    RegisterToggle('AuraToggle', false)
    RegisterOption('SelectedAura', 'Glow Aura')
    RegisterToggle('HitParticlesToggle', false)
    RegisterOption('SelectedHitEffect', 'coom hit effects')
    RegisterToggle('HitChamsToggle', false)
    RegisterOption('HitChamsColor', Color3.fromRGB(255, 0, 75))
    RegisterOption('HitChamsDuration', 1.5)
    RegisterOption('HitChamsTransparency', 0.4)
    RegisterToggle('HitShakeToggle', false)
    RegisterOption('HitShakeIntensity', 'Medium')
    RegisterToggle('CrosshairToggle', false)
    RegisterOption('CrosshairColor', Color3.fromRGB(199, 110, 255))
    RegisterToggle('CrosshairSpinToggle', false)
    RegisterToggle('CrosshairResizeToggle', false)
    RegisterToggle('CrosshairStickToggle', false)
    RegisterOption('CrosshairMode', 'Center')
    RegisterToggle('TargetOnly', false)
    RegisterToggle('BoxESP', false)
    RegisterOption('BoxColor', Color3.new(1,1,1))
    RegisterToggle('TracerESP', false)
    RegisterOption('TracerColor', Color3.new(1,1,1))
    RegisterToggle('NameESP', false)
    RegisterOption('NameColor', Color3.new(1,1,1))
    RegisterToggle('DistESP', false)
    RegisterOption('DistColor', Color3.new(1,1,1))
    RegisterToggle('ToolESP', false)
    RegisterOption('ToolColor', Color3.new(1,1,1))
    RegisterToggle('HitSoundToggle', false)
    RegisterOption('SelectedHitSound', 'Default')
    RegisterOption('AimViewerTarget', 'None')
    RegisterToggle('AimViewerToggle', false)
    RegisterToggle('SpectateToggle', false)
    RegisterToggle('SilentEnabled', false)
    RegisterToggle('ShowFOV', false)
    RegisterOption('FOVSize', 100)
    RegisterOption('FOVColor', Color3.new(1,1,1))
    RegisterOption('SilentPart', 'Head')
    RegisterOption('SilentX', '0.1')
    RegisterOption('SilentY', '0.1')
    RegisterToggle('SilentCamlock', false)
    RegisterOption('SilentSmoothness', '0.1')
    RegisterToggle('SilentVisualizer', false)
    RegisterOption('ShakeX', 0)
    RegisterOption('ShakeY', 0)
    RegisterOption('ShakeZ', 0)
    RegisterToggle('ResolverToggle', false)
    RegisterOption('ResolverMethod', 'Recalculate')
    RegisterToggle('FakeLagToggle', false)
    RegisterOption('LagTicks', 5)
    RegisterToggle('TriggerbotToggle', false)
    RegisterOption('AntiMethod', 'Sky')
    RegisterToggle('SpinbotToggle', false)
    RegisterOption('SpinSpeed', 50)
    RegisterOption('OrbitSpeed', 1)
    RegisterOption('OrbitDistance', 5)
    RegisterOption('OrbitHeight', 0)
    RegisterOption('CFrameSpeed', 1)
    RegisterToggle('WallCheck', false)
    RegisterToggle('KOCheck', false)
    RegisterToggle('TeamCheck', false)
    RegisterToggle('AutoUnlock', false)
    RegisterOption('TargetPart', 'HumanoidRootPart')
    RegisterOption('XPred', '0.1')
    RegisterOption('YPred', '0.1')
    RegisterOption('Smoothness', '0.9')
    RegisterOption('EasingStyle', 'Linear')
    RegisterOption('EasingDirection', 'InOut')
    RegisterOption('Method', 'Index')

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

    -- [ DRAWING OBJECTS ] --
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
        refreshrate = 0, position = Vector2.new(0, 0), width = 1.5, length = 10, radius = 11,
        color = Color3.fromRGB(199, 110, 255), spin = true, spin_speed = 150, spin_max = 340,
        spin_style = Enum.EasingStyle.Sine, resize = true, resize_speed = 150, resize_min = 5, resize_max = 22,
    }

    local old; old = hookfunction(Drawing.new, function(class, properties)
        local drawing = old(class)
        for i, v in next, properties or {} do drawing[i] = v end
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
    for idx = 1, 8 do drawings.crosshair[idx] = Drawing.new('Line') end

    local function solve(angle, radius)
        return Vector2.new(math.sin(math.rad(angle)) * radius, math.cos(math.rad(angle)) * radius)
    end

    -- [[ OBSIDIAN TAB GENERATION ]] --
    local AimlockTab = Window:CreateTab({ Name = "Aimlock" })
    local VisualsTab = Window:CreateTab({ Name = "Visuals" })
    local LegitTab   = Window:CreateTab({ Name = "Legit" })
    -- Note: Obsidian groups options smoothly inside sequential sections
    local RageTab    = Window:CreateTab({ Name = "Rage" })

    -- [[ AIMLOCK SECTIONS ]] --
    local AimlockMainSec = AimlockTab:CreateSection({ Name = "Main Settings" })
    
    AimlockMainSec:CreateButton({
        Name = 'Spawn Lock Button',
        Callback = function()
            local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
            local Btn = Instance.new("TextButton", ScreenGui)
            Btn.Size = UDim2.new(0, 75, 0, 75)
            Btn.Position = UDim2.new(0.5, 150, 0.5, -37)
            Btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            Btn.BackgroundTransparency = 0.4
            Btn.Text = "E"
            Btn.Font = Enum.Font.Arcade
            Btn.TextSize = 55
            Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            Btn.Active, Btn.Draggable = true, true
            
            local uiCorner = Instance.new("UICorner", Btn)
            uiCorner.CornerRadius = UDim.new(0, 10)
            
            local textStroke = Instance.new("UIStroke", Btn)
            textStroke.Thickness = 3; textStroke.Color = Color3.new(0, 0, 0)

            Btn.MouseButton1Click:Connect(function()
                LockActive = not LockActive
                Btn.TextColor3 = LockActive and Color3.fromRGB(255, 40, 100) or Color3.fromRGB(255, 255, 255)
                
                if not LockActive then
                    if TargetNotified then Window:Notify("speared " .. TargetNotified.Name) end
                    CurrentTarget = nil; TargetNotified = nil
                else
                    local initialTarget = GetClosestToCrosshair(false)
                    if initialTarget then
                        Window:Notify("locked on " .. initialTarget.Name)
                        CurrentTarget = initialTarget; TargetNotified = initialTarget
                    else
                        Window:Notify("No target in sight")
                        CurrentTarget = nil; TargetNotified = nil
                    end
                end
            end)
        end
    })

    AimlockMainSec:CreateToggle({
        Name = 'Auto Air', Value = false,
        Callback = function(val) Toggles.AutoAirToggle.Value = val end
    })
    AimlockMainSec:CreateDropdown({
        Name = 'Target Entity', Options = { 'Players', 'NPCs', 'Both' }, Default = 'Players',
        Callback = function(val) Options.TargetType.Value = val end
    })
    AimlockMainSec:CreateToggle({
        Name = 'Camlock', Value = true,
        Callback = function(val) Toggles.Camlock.Value = val end
    })
    AimlockMainSec:CreateToggle({
        Name = 'Look At Player', Value = false,
        Callback = function(val) Toggles.LookAtPlayer.Value = val end
    })
    AimlockMainSec:CreateToggle({
        Name = 'Prediction Visualizer', Value = false,
        Callback = function(val) Toggles.PredVisualizer.Value = val end
    })
    AimlockMainSec:CreateToggle({
        Name = 'Anti Ground Shot', Value = false,
        Callback = function(val) Toggles.AntiGroundShot.Value = val end
    })
    AimlockMainSec:CreateTextBox({
        Name = 'Jump Offset', Default = '0.27', Placeholder = 'Offset',
        Callback = function(val) Options.JumpOffset.Value = val end
    })
    AimlockMainSec:CreateTextBox({
        Name = 'Fall Offset', Default = '0.27', Placeholder = 'Offset',
        Callback = function(val) Options.FallOffset.Value = val end
    })
    AimlockMainSec:CreateTextBox({
        Name = 'Auto Air Delay', Default = '0.23', Placeholder = 'ms',
        Callback = function(val) Options.AirDelay.Value = val end
    })

    local ChecksSec = AimlockTab:CreateSection({ Name = "Checks & Targets" })
    ChecksSec:CreateToggle({ Name = 'Wall Check', Value = false, Callback = function(val) Toggles.WallCheck.Value = val end })
    ChecksSec:CreateToggle({ Name = 'KO Check', Value = false, Callback = function(val) Toggles.KOCheck.Value = val end })
    ChecksSec:CreateToggle({ Name = 'Team Check', Value = false, Callback = function(val) Toggles.TeamCheck.Value = val end })
    ChecksSec:CreateToggle({ Name = 'Auto Unlock', Value = false, Callback = function(val) Toggles.AutoUnlock.Value = val end })
    ChecksSec:CreateDropdown({
        Name = 'Body Part Selection', Options = { 'Head', 'UpperTorso', 'Torso', 'LowerTorso', 'HumanoidRootPart' }, Default = 'HumanoidRootPart',
        Callback = function(val) Options.TargetPart.Value = val end
    })

    local PredSec = AimlockTab:CreateSection({ Name = "Prediction & Easing" })
    PredSec:CreateTextBox({ Name = 'X Prediction', Default = '0.1', Callback = function(val) Options.XPred.Value = val end })
    PredSec:CreateTextBox({ Name = 'Y Prediction', Default = '0.1', Callback = function(val) Options.YPred.Value = val end })
    PredSec:CreateTextBox({ Name = 'Cam Smoothness', Default = '0.9', Callback = function(val) Options.Smoothness.Value = val end })
    PredSec:CreateDropdown({
        Name = 'Easing Style', Options = { 'Linear', 'Sine', 'Back', 'Quad', 'Quart', 'Quint', 'Bounce', 'Elastic', 'Exponential', 'Circular', 'Cubic' }, Default = 'Linear',
        Callback = function(val) Options.EasingStyle.Value = val end
    })
    PredSec:CreateDropdown({
        Name = 'Easing Direction', Options = { 'In', 'Out', 'InOut' }, Default = 'InOut',
        Callback = function(val) Options.EasingDirection.Value = val end
    })
    PredSec:CreateDropdown({
        Name = 'Method', Options = { 'Index', 'Namecall' }, Default = 'Index',
        Callback = function(val) Options.Method.Value = val end
    })

    -- [[ VISUALS SECTIONS ]] --
    local WorldSec = VisualsTab:CreateSection({ Name = "World Modification" })
    WorldSec:CreateToggle({ Name = 'Modify Time', Value = false, Callback = function(val) Toggles.WorldTimeToggle.Value = val end })
    WorldSec:CreateSlider({ Name = 'Time of Day', Min = 0, Max = 24, Default = 12, Callback = function(val) Options.WorldTime.Value = val end })
    WorldSec:CreateToggle({ Name = 'Modify Ambient', Value = false, Callback = function(val) Toggles.WorldAmbientToggle.Value = val end })
    WorldSec:CreateColorPicker({ Name = 'Ambient Color', Default = Color3.new(1,1,1), Callback = function(val) Options.AmbientColor.Value = val end })
    WorldSec:CreateSlider({ Name = 'Brightness', Min = 0, Max = 10, Default = 2, Callback = function(val) Options.WorldBrightness.Value = val end })

    local SelfSec = VisualsTab:CreateSection({ Name = "Self Visuals" })
    SelfSec:CreateToggle({ Name = 'ForceField Chams', Value = false, Callback = function(val) Toggles.FFChams.Value = val end })
    SelfSec:CreateColorPicker({ Name = 'Chams Color', Default = Color3.fromRGB(180, 0, 255), Callback = function(val) Options.FFColor.Value = val end })
    SelfSec:CreateToggle({ Name = 'Character Trail', Value = false, Callback = function(val) Toggles.CharacterTrail.Value = val end })
    SelfSec:CreateColorPicker({ Name = 'Trail Color', Default = Color3.fromRGB(255, 255, 255), Callback = function(val) Options.TrailColor.Value = val end })
    SelfSec:CreateToggle({ Name = 'Aura Enabled', Value = false, Callback = function(val) Toggles.AuraToggle.Value = val end })
    SelfSec:CreateDropdown({ Name = 'Aura Type', Options = { 'Glow Aura', 'Rings Aura', 'Electric Aura' }, Default = 'Glow Aura', Callback = function(val) Options.SelectedAura.Value = val end })

    local EffectsSec = VisualsTab:CreateSection({ Name = "Combat Hit Effects" })
    EffectsSec:CreateToggle({ Name = 'Hit Particles', Value = false, Callback = function(val) Toggles.HitParticlesToggle.Value = val end })
    EffectsSec:CreateDropdown({ Name = 'Particle Style', Options = { 'coom hit effects', 'nova hit effects', 'bubble hit effect' }, Default = 'coom hit effects', Callback = function(val) Options.SelectedHitEffect.Value = val end })
    EffectsSec:CreateToggle({ Name = 'Hit Chams', Value = false, Callback = function(val) Toggles.HitChamsToggle.Value = val end })
    EffectsSec:CreateColorPicker({ Name = 'Hit Chams Color', Default = Color3.fromRGB(255, 0, 75), Callback = function(val) Options.HitChamsColor.Value = val end })
    EffectsSec:CreateSlider({ Name = 'Chams Duration', Min = 0.1, Max = 5, Default = 1.5, Callback = function(val) Options.HitChamsDuration.Value = val end })
    EffectsSec:CreateSlider({ Name = 'Chams Transparency', Min = 0, Max = 1, Default = 0.4, Callback = function(val) Options.HitChamsTransparency.Value = val end })
    EffectsSec:CreateToggle({ Name = 'Hit Camera Shake', Value = false, Callback = function(val) Toggles.HitShakeToggle.Value = val end })
    EffectsSec:CreateDropdown({ Name = 'Shake Impact Force', Options = { 'Light', 'Medium', 'Heavy' }, Default = 'Medium', Callback = function(val) Options.HitShakeIntensity.Value = val end })

    local CrosshairSec = VisualsTab:CreateSection({ Name = "Crosshair Customization" })
    CrosshairSec:CreateToggle({ Name = 'Crosshair Enabled', Value = false, Callback = function(val) Toggles.CrosshairToggle.Value = val end })
    CrosshairSec:CreateColorPicker({ Name = 'Crosshair Color', Default = Color3.fromRGB(199, 110, 255), Callback = function(val) Options.CrosshairColor.Value = val end })
    CrosshairSec:CreateToggle({ Name = 'Crosshair Spin', Value = false, Callback = function(val) Toggles.CrosshairSpinToggle.Value = val end })
    CrosshairSec:CreateToggle({ Name = 'Crosshair Resizing', Value = false, Callback = function(val) Toggles.CrosshairResizeToggle.Value = val end })
    CrosshairSec:CreateToggle({ Name = 'Stick to Target', Value = false, Callback = function(val) Toggles.CrosshairStickToggle.Value = val end })
    CrosshairSec:CreateDropdown({ Name = 'Placement Position', Options = { 'Center', 'Mouse' }, Default = 'Center', Callback = function(val) Options.CrosshairMode.Value = val end })

    local ESPSec = VisualsTab:CreateSection({ Name = "ESP Engine" })
    ESPSec:CreateToggle({ Name = 'Target Only', Value = false, Callback = function(val) Toggles.TargetOnly.Value = val end })
    ESPSec:CreateToggle({ Name = 'Box ESP', Value = false, Callback = function(val) Toggles.BoxESP.Value = val end })
    ESPSec:CreateColorPicker({ Name = 'Box Color', Default = Color3.new(1,1,1), Callback = function(val) Options.BoxColor.Value = val end })
    ESPSec:CreateToggle({ Name = 'Tracer ESP', Value = false, Callback = function(val) Toggles.TracerESP.Value = val end })
    ESPSec:CreateColorPicker({ Name = 'Tracer Color', Default = Color3.new(1,1,1), Callback = function(val) Options.TracerColor.Value = val end })
    ESPSec:CreateToggle({ Name = 'Name ESP', Value = false, Callback = function(val) Toggles.NameESP.Value = val end })
    ESPSec:CreateColorPicker({ Name = 'Name Color', Default = Color3.new(1,1,1), Callback = function(val) Options.NameColor.Value = val end })
    ESPSec:CreateToggle({ Name = 'Distance ESP', Value = false, Callback = function(val) Toggles.DistESP.Value = val end })
    ESPSec:CreateColorPicker({ Name = 'Distance Color', Default = Color3.new(1,1,1), Callback = function(val) Options.DistColor.Value = val end })
    ESPSec:CreateToggle({ Name = 'Tool ESP', Value = false, Callback = function(val) Toggles.ToolESP.Value = val end })
    ESPSec:CreateColorPicker({ Name = 'Tool Color', Default = Color3.new(1,1,1), Callback = function(val) Options.ToolColor.Value = val end })

    local SoundSec = VisualsTab:CreateSection({ Name = "Acoustics" })
    SoundSec:CreateToggle({ Name = 'Hit Sounds', Value = false, Callback = function(val) Toggles.HitSoundToggle.Value = val end })
    
    local soundNames = {}
    for name, _ in pairs(HitSoundId) do table.insert(soundNames, name) end
    table.sort(soundNames)
    SoundSec:CreateDropdown({ Name = 'Sound Selection', Options = soundNames, Default = 'Default', Callback = function(val) Options.SelectedHitSound.Value = val end })

    -- [[ LEGIT SECTIONS ]] --
    local SilentSec = LegitTab:CreateSection({ Name = "Silent Aim Engine" })
    SilentSec:CreateToggle({ Name = 'Silent Aim', Value = false, Callback = function(val) Toggles.SilentEnabled.Value = val end })
    SilentSec:CreateToggle({ Name = 'FOV Circle', Value = false, Callback = function(val) Toggles.ShowFOV.Value = val end })
    SilentSec:CreateSlider({ Name = 'FOV Radius', Min = 1, Max = 500, Default = 100, Callback = function(val) Options.FOVSize.Value = val end })
    SilentSec:CreateColorPicker({ Name = 'FOV Color', Default = Color3.new(1,1,1), Callback = function(val) Options.FOVColor.Value = val end })
    SilentSec:CreateDropdown({ Name = 'Target Part', Options = { 'Head', 'UpperTorso', 'Torso', 'LowerTorso', 'HumanoidRootPart' }, Default = 'Head', Callback = function(val) Options.SilentPart.Value = val end })
    SilentSec:CreateTextBox({ Name = 'Prediction X', Default = '0.1', Callback = function(val) Options.SilentX.Value = val end })
    SilentSec:CreateTextBox({ Name = 'Prediction Y', Default = '0.1', Callback = function(val) Options.SilentY.Value = val end })
    SilentSec:CreateToggle({ Name = 'Camlock Link', Value = false, Callback = function(val) Toggles.SilentCamlock.Value = val end })
    SilentSec:CreateTextBox({ Name = 'Cam Smoothness', Default = '0.1', Callback = function(val) Options.SilentSmoothness.Value = val end })
    SilentSec:CreateToggle({ Name = 'Prediction Visualizer', Value = false, Callback = function(val) Toggles.SilentVisualizer.Value = val end })

    local ShakeSec = LegitTab:CreateSection({ Name = "Mathematical Shake dispersion" })
    -- Note: Obsidian handles decimals comfortably inside structural callbacks
    if not Options.ShakeX then RegisterOption('ShakeX', 0) end
    if not Options.ShakeY then RegisterOption('ShakeY', 0) end
    if not Options.ShakeZ then RegisterOption('ShakeZ', 0) end
    ShakeSec:CreateSlider({ Name = 'Shake X', Min = 0, Max = 1, Default = 0, Callback = function(val) Options.ShakeX.Value = val end })
    ShakeSec:CreateSlider({ Name = 'Shake Y', Min = 0, Max = 1, Default = 0, Callback = function(val) Options.ShakeY.Value = val end })
    ShakeSec:CreateSlider({ Name = 'Shake Z', Min = 0, Max = 1, Default = 0, Callback = function(val) Options.ShakeZ.Value = val end })

    local ViewSec = LegitTab:CreateSection({ Name = "Utility View vectors" })
    local viewerDropdown = ViewSec:CreateDropdown({ Name = 'Select Player', Options = {"None"}, Default = 'None', Callback = function(val) Options.AimViewerTarget.Value = val end })
    ViewSec:CreateButton({
        Name = 'Refresh Players',
        Callback = function()
            local list = {}
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LocalPlayer then table.insert(list, p.Name) end
            end
            if #list == 0 then table.insert(list, "None") end
            viewerDropdown:SetOptions(list)
        end
    })
    ViewSec:CreateToggle({ Name = 'Aim Viewer', Value = false, Callback = function(val) Toggles.AimViewerToggle.Value = val end })
    ViewSec:CreateToggle({ Name = 'Spectate Player', Value = false, Callback = function(val) Toggles.SpectateToggle.Value = val end })

    -- [[ RAGE SECTIONS ]] --
    local ResSec = RageTab:CreateSection({ Name = "Calculated Resolver" })
    ResSec:CreateToggle({ Name = 'Resolver', Value = false, Callback = function(val) Toggles.ResolverToggle.Value = val end })
    ResSec:CreateDropdown({ Name = 'Method', Options = { 'Recalculate', 'Velocity Null', 'LookVector' }, Default = 'Recalculate', Callback = function(val) Options.ResolverMethod.Value = val end })

    local HvhSec = RageTab:CreateSection({ Name = "HvH Systems" })
    HvhSec:CreateToggle({ Name = 'Fake Lag', Value = false, Callback = function(val) Toggles.FakeLagToggle.Value = val end })
    HvhSec:CreateSlider({ Name = 'Lag Ticks', Min = 1, Max = 15, Default = 5, Callback = function(val) Options.LagTicks.Value = val end })
    HvhSec:CreateToggle({ Name = 'Triggerbot', Value = false, Callback = function(val) Toggles.TriggerbotToggle.Value = val end })

    local AntiSec = RageTab:CreateSection({ Name = "Anti-Aim Lock Simulation" })
    AntiSec:CreateButton({
        Name = 'Toggle Antilock Status',
        Callback = function()
            AntiLockActive = not AntiLockActive
            Window:Notify("Antilock: " .. (AntiLockActive and "ENABLED" or "DISABLED"))
        end
    })
    AntiSec:CreateDropdown({ Name = 'Method Selection', Options = { 'Sky', 'Shake', 'Underground', 'Back' }, Default = 'Sky', Callback = function(val) Options.AntiMethod.Value = val end })

    local SpinSec = RageTab:CreateSection({ Name = "Kinematic Rotation Engine" })
    SpinSec:CreateToggle({ Name = 'Spinbot', Value = false, Callback = function(val) SpinbotActive = val; Toggles.SpinbotToggle.Value = val end })
    SpinSec:CreateSlider({ Name = 'Speed', Min = 0, Max = 100, Default = 50, Callback = function(val) Options.SpinSpeed.Value = val end })

    local OrbSec = RageTab:CreateSection({ Name = "Orbit Interceptor Vectors" })
    OrbSec:CreateButton({
        Name = 'Toggle Intercept Orbit',
        Callback = function()
            OrbitActive = not OrbitActive
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
        end
    })
    OrbSec:CreateSlider({ Name = 'Speed', Min = 1, Max = 100, Default = 1, Callback = function(val) Options.OrbitSpeed.Value = val end })
    OrbSec:CreateSlider({ Name = 'Distance', Min = 1, Max = 100, Default = 5, Callback = function(val) Options.OrbitDistance.Value = val end })
    OrbSec:CreateSlider({ Name = 'Height', Min = 0, Max = 100, Default = 0, Callback = function(val) Options.OrbitHeight.Value = val end })

    local CfSec = RageTab:CreateSection({ Name = "CFrame Linear Transports" })
    CfSec:CreateButton({
        Name = 'Toggle CFrame Move',
        Callback = function() CFrameActive = not CFrameActive end
    })
    CfSec:CreateSlider({ Name = 'Speed', Min = 1, Max = 100, Default = 1, Callback = function(val) Options.CFrameSpeed.Value = val end })

    -- [[ END OF UI INTERFACE DEF ]] --

    local function PlayHitSound()
        if Toggles.HitSoundToggle.Value then
            local sound = Instance.new("Sound")
            sound.SoundId = HitSoundId[Options.SelectedHitSound.Value]
            sound.Volume = 3; sound.Parent = game:GetService("SoundService")
            sound:Play(); Debris:AddItem(sound, 2)
        end
    end

    local function SpawnHitEffects(position, character)
        if Toggles.HitParticlesToggle.Value and position then
            local part = Instance.new("Part")
            part.Size = Vector3.new(0.1, 0.1, 0.1)
            part.Position = position; part.Anchored = true; part.CanCollide = false; part.Transparency = 1; part.Parent = workspace

            local emitter = Instance.new("ParticleEmitter")
            emitter.Rate = 0; emitter.Speed = NumberRange.new(5, 15); emitter.Lifetime = NumberRange.new(0.5, 1.2); emitter.Parent = part

            local style = Options.SelectedHitEffect.Value
            if style == "coom hit effects" then
                emitter.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255))
                emitter.LightEmission = 0.2; emitter.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.8), NumberSequenceKeypoint.new(1, 0)})
                emitter.Texture = "rbxassetid://242293495"
            elseif style == "nova hit effects" then
                emitter.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 100, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 0, 255))})
                emitter.LightEmission = 0.9; emitter.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.2, 2.5), NumberSequenceKeypoint.new(1, 0)})
                emitter.Texture = "rbxassetid://244221447"
            elseif style == "bubble hit effect" then
                emitter.Color = ColorSequence.new(Color3.fromRGB(0, 200, 255))
                emitter.LightEmission = 0.4; emitter.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.4), NumberSequenceKeypoint.new(1, 1.5)})
                emitter.Texture = "rbxassetid://6534947588"
            end
            emitter:Emit(35); Debris:AddItem(part, 2)
        end

        if Toggles.HitChamsToggle.Value and character then
            local highlight = Instance.new("Highlight")
            highlight.FillColor = Options.HitChamsColor.Value; highlight.OutlineColor = Options.HitChamsColor.Value
            highlight.FillTransparency = Options.HitChamsTransparency.Value; highlight.OutlineTransparency = Options.HitChamsTransparency.Value
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
                if dist < closest then target = ent; closest = dist end
            end
        end
        return target
    end

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

    local originalLighting = { ClockTime = Lighting.ClockTime, Ambient = Lighting.Ambient, Brightness = Lighting.Brightness }

    -- [[ SIMULATION ENGINE INTERACTION RUN LOOP ]] --
    RunService.Heartbeat:Connect(function(dt)
        local char = LocalPlayer.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        
        if Toggles.WorldTimeToggle.Value then Lighting.ClockTime = Options.WorldTime.Value else Lighting.ClockTime = originalLighting.ClockTime end
        if Toggles.WorldAmbientToggle.Value then Lighting.Ambient = Options.AmbientColor.Value; Lighting.Brightness = Options.WorldBrightness.Value else Lighting.Ambient = originalLighting.Ambient; Lighting.Brightness = originalLighting.Brightness end

        if char then
            if Toggles.FFChams.Value then
                for _, part in ipairs(char:GetDescendants()) do
                    if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                        if not OriginalMats[part] then OriginalMats[part] = { Material = part.Material, Color = part.Color } end
                        part.Material = Enum.Material.ForceField; part.Color = Options.FFColor.Value
                    end
                end
            else
                for part, data in pairs(OriginalMats) do if part and part.Parent then part.Material = data.Material; part.Color = data.Color end end
                OriginalMats = {}
            end
        end

        if char and root then
            if Toggles.CharacterTrail.Value then
                if not MyTrail or not MyTrail.Parent or MyTrail.Parent ~= root then
                    if MyTrail then MyTrail:Destroy() end
                    if TrailAtt0 then TrailAtt0:Destroy() end
                    if TrailAtt1 then TrailAtt1:Destroy() end

                    TrailAtt0 = Instance.new("Attachment", root); TrailAtt0.Name = "TrailAttachment0"; TrailAtt0.Position = Vector3.new(0, 1.4, 0)
                    TrailAtt1 = Instance.new("Attachment", root); TrailAtt1.Name = "TrailAttachment1"; TrailAtt1.Position = Vector3.new(0, -1.4, 0)

                    MyTrail = Instance.new("Trail", root); MyTrail.Name = "SelfMovementTrail"; MyTrail.Attachment0 = TrailAtt0; MyTrail.Attachment1 = TrailAtt1
                    MyTrail.FaceCamera = true; MyTrail.Lifetime = 0.5
                    MyTrail.WidthScale = NumberSequence.new({NumberSequenceKeypoint.new(0, 1.2), NumberSequenceKeypoint.new(0.5, 0.6), NumberSequenceKeypoint.new(1, 0)})
                    MyTrail.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.1), NumberSequenceKeypoint.new(1, 1)})
                    MyTrail.LightEmission = 0.85; MyTrail.Texture = "rbxassetid://4011115456"
                end
                if MyTrail then MyTrail.Color = ColorSequence.new(Options.TrailColor.Value) end
            else
                if MyTrail then MyTrail:Destroy(); MyTrail = nil end
                if TrailAtt0 then TrailAtt0:Destroy(); TrailAtt0 = nil end
                if TrailAtt1 then TrailAtt1:Destroy(); TrailAtt1 = nil end
            end
        end

        if char and root then
            if Toggles.AuraToggle.Value then
                local selected = Options.SelectedAura.Value
                if not ActiveAuraParticles[selected] or not ActiveAuraParticles[selected].Parent then
                    for _, instance in pairs(ActiveAuraParticles) do instance:Destroy() end
                    ActiveAuraParticles = {}

                    local container = Instance.new("Attachment", root); container.Name = "AuraContainerAttachment"
                    local emitter = Instance.new("ParticleEmitter", container); emitter.Rate = 45

                    if selected == "Glow Aura" then
                        emitter.Texture = "rbxassetid://244221447"; emitter.Size = NumberSequence.new(3.5); emitter.Lifetime = NumberRange.new(0.6); emitter.Speed = NumberRange.new(0); emitter.Color = ColorSequence.new(Color3.fromRGB(190, 0, 255)); emitter.LightEmission = 0.8
                    elseif selected == "Rings Aura" then
                        emitter.Texture = "rbxassetid://1084991219"; emitter.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 4)}); emitter.Lifetime = NumberRange.new(0.8); emitter.Speed = NumberRange.new(1, 3); emitter.Color = ColorSequence.new(Color3.fromRGB(0, 255, 200)); emitter.RotSpeed = NumberRange.new(90)
                    elseif selected == "Electric Aura" then
                        emitter.Texture = "rbxassetid://281983280"; emitter.Size = NumberSequence.new(2); emitter.Lifetime = NumberRange.new(0.3); emitter.Speed = NumberRange.new(2, 6); emitter.Color = ColorSequence.new(Color3.fromRGB(255, 230, 0)); emitter.LightEmission = 0.9
                    end
                    ActiveAuraParticles[selected] = container
                end
            else
                for k, instance in pairs(ActiveAuraParticles) do instance:Destroy() end; ActiveAuraParticles = {}
            end
        end

        if Toggles.FakeLagToggle.Value and root then
            LagTicks = LagTicks + 1
            if LagTicks >= Options.LagTicks.Value then
                root.Anchored = not root.Anchored; LagTicks = 0
            end
        elseif root and root.Anchored and not Toggles.FakeLagToggle.Value then
            root.Anchored = false
        end

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

        if Toggles.AimViewerToggle.Value and Options.AimViewerTarget.Value ~= "None" then
            local tPlayer = Players:FindFirstChild(Options.AimViewerTarget.Value)
            if tPlayer and tPlayer.Character and tPlayer.Character:FindFirstChild("Head") then
                local tHead = tPlayer.Character.Head
                local lookPos = tHead.Position + (tHead.CFrame.LookVector * 10)
                local headScreen, headOnScreen = Camera:WorldToViewportPoint(tHead.Position)
                local lookScreen, lookOnScreen = Camera:WorldToViewportPoint(lookPos)

                if headOnScreen or lookOnScreen then
                    AimViewerLine.Visible = true; AimViewerLine.From = Vector2.new(headScreen.X, headScreen.Y); AimViewerLine.To = Vector2.new(lookScreen.X, lookScreen.Y)
                else AimViewerLine.Visible = false end
            else AimViewerLine.Visible = false end
        else AimViewerLine.Visible = false end

        if Toggles.SpectateToggle.Value and Options.AimViewerTarget.Value ~= "None" then
            local tPlayer = Players:FindFirstChild(Options.AimViewerTarget.Value)
            if tPlayer and tPlayer.Character and tPlayer.Character:FindFirstChild("Humanoid") then Camera.CameraSubject = tPlayer.Character.Humanoid end
        elseif not OrbitActive and char and char:FindFirstChild("Humanoid") then
            if Camera.CameraSubject ~= char.Humanoid and not Toggles.SpectateToggle.Value then Camera.CameraSubject = char.Humanoid end
        end

        if Toggles.ShowFOV.Value then
            SilentCircle.Visible = true; SilentCircle.Radius = Options.FOVSize.Value; SilentCircle.Color = Options.FOVColor.Value; SilentCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
        else SilentCircle.Visible = false end

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
                        else SilentVisualizerDot.Visible = false end
                    else SilentVisualizerDot.Visible = false end

                    if sHum then
                        local currentHealth = sHum.Health
                        local previousHealth = lastHealths[SilentTarget.Character] or currentHealth
                        if currentHealth < previousHealth then
                            PlayHitSound(); SpawnHitEffects(sPart.Position, SilentTarget.Character)
                        end
                        lastHealths[SilentTarget.Character] = currentHealth
                    end
                else SilentVisualizerDot.Visible = false end
            else SilentVisualizerDot.Visible = false end
        else SilentTarget = nil; SilentVisualizerDot.Visible = false end

        if LockActive and CurrentTarget and CurrentTarget.Character then
            local hum = CurrentTarget.Character:FindFirstChildOfClass("Humanoid")
            local tPart = CurrentTarget.Character:FindFirstChild("HumanoidRootPart")
            if hum then
                local currentHealth = hum.Health
                local previousHealth = lastHealths[CurrentTarget.Character] or currentHealth
                if currentHealth < previousHealth then 
                    PlayHitSound() 
                    if tPart then SpawnHitEffects(tPart.Position, CurrentTarget.Character) end
                end
                lastHealths[CurrentTarget.Character] = currentHealth
            end
        end

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
                local pRoot = ent.Character.HumanoidRootPart
                local pPos, onScreen = Camera:WorldToViewportPoint(pRoot.Position)
                
                if onScreen then
                    local drawing = GetESP(ent.Character)
                    local boxHeight = (Camera:WorldToViewportPoint(pRoot.Position - Vector3.new(0, 3.5, 0)).Y - Camera:WorldToViewportPoint(pRoot.Position + Vector3.new(0, 3, 0)).Y)
                    
                    drawing.Box.Visible = Toggles.BoxESP.Value
                    if drawing.Box.Visible then
                        drawing.Box.Size = Vector2.new(boxHeight * 0.6, boxHeight)
                        drawing.Box.Position = Vector2.new(pPos.X - drawing.Box.Size.X / 2, pPos.Y - drawing.Box.Size.Y / 2)
                        drawing.Box.Color = Options.BoxColor.Value
                    end

                    drawing.Tracer.Visible = Toggles.TracerESP.Value
                    if drawing.Tracer.Visible then
                        drawing.Tracer.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
                        drawing.Tracer.To = Vector2.new(pPos.X, pPos.Y)
                        drawing.Tracer.Color = Options.TracerColor.Value
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

        if SpinbotActive and root then root.CFrame = root.CFrame * CFrame.Angles(0, math.rad(Options.SpinSpeed.Value), 0) end
        if AntiLockActive and root then
            local method = Options.AntiMethod.Value
            local oldVelo = root.Velocity
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

        if OrbitActive and OrbitTarget and OrbitTarget.Character then
            local tRoot = OrbitTarget.Character:FindFirstChild("HumanoidRootPart")
            if tRoot and root then
                OrbitAngle = OrbitAngle + (Options.OrbitSpeed.Value * dt)
                local cos, sin = math.cos(OrbitAngle), math.sin(OrbitAngle)
                local offset = Vector3.new(cos * Options.OrbitDistance.Value, Options.OrbitHeight.Value, sin * Options.OrbitDistance.Value)
                root.CFrame = CFrame.new(tRoot.Position + offset, tRoot.Position); root.Velocity = Vector3.zero
            end
        end

        local CalculatedCrosshairPos = nil
        if LockActive then
            if CurrentTarget then
                local tChar = CurrentTarget.Character
                local tHum = tChar and tChar:FindFirstChildOfClass("Humanoid")
                if not tChar or not tChar.Parent or (Toggles.AutoUnlock.Value and GetKnockStatus(CurrentTarget)) or (tHum and tHum.Health <= 0) then
                    if tHum and tHum.Health <= 0 then Window:Notify(CurrentTarget.Name .. " Died LOL") else Window:Notify("speared " .. CurrentTarget.Name) end
                    CurrentTarget = nil; TargetNotified = nil
                end
            end

            if not CurrentTarget then 
                CurrentTarget = GetClosestToCrosshair(false) 
                if CurrentTarget then Window:Notify("locked on " .. CurrentTarget.Name); TargetNotified = CurrentTarget end
            elseif CurrentTarget ~= TargetNotified then
                if TargetNotified then Window:Notify("speared " .. TargetNotified.Name) end
                Window:Notify("locked on " .. CurrentTarget.Name); TargetNotified = CurrentTarget
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

                    local visible = IsVisible(TargetPart)
                    local cScrPos, cOnScr = Camera:WorldToViewportPoint(PredPos)
                    if cOnScr then CalculatedCrosshairPos = Vector2.new(cScrPos.X, cScrPos.Y) end

                    if Toggles.PredVisualizer.Value then
                        local screenPos, onScreen = Camera:WorldToViewportPoint(PredPos)
                        local partPos, partOnScreen = Camera:WorldToViewportPoint(TargetPart.Position)
                        if onScreen and partOnScreen then
                            PredictionTracer.Visible = true; PredictionTracer.From = Vector2.new(partPos.X, partPos.Y); PredictionTracer.To = Vector2.new(screenPos.X, screenPos.Y)
                            PredictionDot.Visible = true; PredictionDot.Position = Vector2.new(screenPos.X, screenPos.Y)
                        else PredictionTracer.Visible = false; PredictionDot.Visible = false end
                    else PredictionTracer.Visible = false; PredictionDot.Visible = false end

                    SharedShake = Vector3.new(
                        (math.random(-100, 100) / 250) * Options.ShakeX.Value,
                        (math.random(-100, 100) / 250) * Options.ShakeY.Value,
                        (math.random(-100, 100) / 250) * Options.ShakeZ.Value
                    )

                    if Toggles.LookAtPlayer.Value and (not Toggles.WallCheck.Value or visible) then root.CFrame = CFrame.new(root.Position, Vector3.new(PredPos.X, root.Position.Y, PredPos.Z)) end

                    if Toggles.Camlock.Value and (not Toggles.WallCheck.Value or visible) then
                        local smoothBase = tonumber(Options.Smoothness.Value) or 0.1
                        local currentLook = Camera.CFrame.LookVector
                        local targetLook = (PredPos + SharedShake - Camera.CFrame.Position).Unit
                        local dotProduct = currentLook:Dot(targetLook)
                        local angleDiff = math.acos(math.clamp(dotProduct, -1, 1))
                        local progress = math.clamp(angleDiff / 0.5, 0, 1)
                        
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
                            lastShot = tick()
                            local tool = char:FindFirstChildOfClass("Tool")
                            if tool then tool:Activate() end
                        end
                    end
                end
            else PredictionTracer.Visible = false; PredictionDot.Visible = false end
        else SharedShake = Vector3.zero; PredictionTracer.Visible = false; PredictionDot.Visible = false end

        -- [[ SPINNING CROSSHAIR ENGINE ]] --
        local _tick = tick()
        if _tick - last_render > crosshair.refreshrate then
            last_render = _tick

            local position = Camera.ViewportSize / 2
            if Toggles.CrosshairStickToggle.Value and CalculatedCrosshairPos then position = CalculatedCrosshairPos
            elseif Options.CrosshairMode.Value == 'Mouse' then position = inputservice:GetMouseLocation() end

            local text_x = drawings.text[1].TextBounds.X + drawings.text[2].TextBounds.X
            drawings.text[1].Visible = Toggles.CrosshairToggle.Value
            drawings.text[2].Visible = Toggles.CrosshairToggle.Value

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
        
                    inline.Visible = true; inline.Color = Options.CrosshairColor.Value; inline.From = position + solve(angle, crosshair.radius); inline.To = position + solve(angle, crosshair.radius + length); inline.Thickness = crosshair.width
                    outline.Visible = true; outline.From = position + solve(angle, crosshair.radius - 1); outline.To = position + solve(angle, crosshair.radius + length + 1); outline.Thickness = crosshair.width + 1.5    
                end
            else
                for idx = 1, 8 do drawings.crosshair[idx].Visible = false end
                drawings.text[1].Visible = false; drawings.text[2].Visible = false
            end
        end
    end)

    -- [[ METATABLE AIM SUBSYSTEM ]] --
    local mt = getrawmetatable(game)
    local oldIndex = mt.__index
    setreadonly(mt, false)

    mt.__index = newcclosure(function(self, index)
        if not checkcaller() and self == Mouse and (index == "Hit" or index == "Target") then
            if Toggles.SilentEnabled.Value then
                local sTarget = SilentTarget
                if sTarget and sTarget.Character then
                    local sPart = sTarget.Character:FindFirstChild(Options.SilentPart.Value) or sTarget.Character:FindFirstChild("HumanoidRootPart")
                    local sHum = sTarget.Character:FindFirstChildOfClass("Humanoid")
                    if sPart then
                        local pX, pY = tonumber(Options.SilentX.Value) or 0.1, tonumber(Options.SilentY.Value) or 0.1
                        local sVel = sPart.Velocity
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
                    local predX, predY = tonumber(Options.XPred.Value) or 0.1, tonumber(Options.YPred.Value) or 0.1
                    local ResolvedVelocity = TargetPart.Velocity
                    
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

    Window:Notify('Extract.cc | Adapted to Obsidian UI Successfully')
end

getgenv().ExtractCC()
