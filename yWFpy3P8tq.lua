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

    local repo = 'https://raw.githubusercontent.com/yuvic123/testsub/refs/heads/main/'

    local Library = loadstring(game:HttpGet(repo .. 'ttest'))()
    local ThemeManager = loadstring(game:HttpGet(repo .. 'manage'))()
    local SaveManager = loadstring(game:HttpGet(repo .. 'save'))()

    local Window = Library:CreateWindow({
        Title = 'Extract.cc | @eu3.d',
        Center = true,
        AutoShow = true,
        TabPadding = 8,
        MenuFadeTime = 0.2
    })

    -- [ SERVICES ] --
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local Lighting = game:GetService("Lighting")
    local LocalPlayer = Players.LocalPlayer
    local Camera = workspace.CurrentCamera
    local Mouse = LocalPlayer:GetMouse()

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
    
    local OriginalMats = {} -- For ForceField Chams
    local LagTicks = 0 -- For Fake Lag
    local TargetNotified = nil -- To track notifications

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

    -- [ TABS ] --
    local Tabs = {
        Aimlock = Window:AddTab('--1'),
        Visuals = Window:AddTab('--2'),
        Legit = Window:AddTab('--3'),
        Rage = Window:AddTab('--4'),
        ['Settings'] = Window:AddTab('--5'),
    }

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

    -- [[ AIMLOCK GROUP ]] --
    local MainGroup = Tabs.Aimlock:AddLeftGroupbox('Aimlock')

    MainGroup:AddButton({
        Text = 'Spawn Lock Button',
        Func = function()
            local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
            
            -- Main Button (Larger 75x75 size, Pixelated E, Transparent Dark Grey Background)
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
            
            -- Smooth background edges (Adjust 10 to change roundness intensity)
            local uiCorner = Instance.new("UICorner")
            uiCorner.CornerRadius = UDim.new(0, 10)
            uiCorner.Parent = Btn
            
            -- Adding a stroke so the E is visible against bright game backgrounds
            local textStroke = Instance.new("UIStroke", Btn)
            textStroke.Thickness = 3
            textStroke.Color = Color3.new(0, 0, 0)
            textStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual

            -- Handle Toggled Styling States with precise notification matching
            Btn.MouseButton1Click:Connect(function()
                LockActive = not LockActive
                
                -- Change the text color based on lock state (Red when locked)
                Btn.TextColor3 = LockActive and Color3.fromRGB(255, 40, 100) or Color3.fromRGB(255, 255, 255)
                
                if not LockActive then
                    if TargetNotified then
                        Library:Notify("speared " .. TargetNotified.Name)
                    elseif CurrentTarget then
                        Library:Notify("speared " .. CurrentTarget.Name)
                    end
                    CurrentTarget = nil
                    TargetNotified = nil
                else
                    local initialTarget = GetClosestToCrosshair(false)
                    if initialTarget then
                        Library:Notify("locked on " .. initialTarget.Name)
                        CurrentTarget = initialTarget
                        TargetNotified = initialTarget
                    else
                        Library:Notify("No target in sight")
                        CurrentTarget = nil
                        TargetNotified = nil
                    end
                end
            end)
        end
    })

    -- Replaced Auto Air Button with a standard Toggle
    MainGroup:AddToggle('AutoAirToggle', { Text = 'Auto Air', Default = false })
    MainGroup:AddDropdown('TargetType', { Values = { 'Players', 'NPCs', 'Both' }, Default = 1, Text = 'Target Entity' })
    MainGroup:AddToggle('Camlock', { Text = 'Camlock', Default = true })
    MainGroup:AddToggle('LookAtPlayer', { Text = 'Look At Player', Default = false })
    MainGroup:AddToggle('PredVisualizer', { Text = 'Prediction Visualizer', Default = false }) 
    MainGroup:AddToggle('AntiGroundShot', { Text = 'Anti Ground Shot', Default = false })
    MainGroup:AddInput('JumpOffset', { Default = '0.27', Text = 'Jump Offset' })
    MainGroup:AddInput('FallOffset', { Default = '0.27', Text = 'Fall Offset' }) -- New Fall Offset
    MainGroup:AddInput('AirDelay', { Default = '0.23', Text = 'Auto Air Delay' })

    -- [[ VISUALS TAB - WORLD & SELF ]] --
    local WorldGroup = Tabs.Visuals:AddLeftGroupbox('World Visuals')
    WorldGroup:AddToggle('WorldTimeToggle', { Text = 'Modify Time', Default = false })
    WorldGroup:AddSlider('WorldTime', { Text = 'Time of Day', Default = 12, Min = 0, Max = 24, Rounding = 1 })
    WorldGroup:AddToggle('WorldAmbientToggle', { Text = 'Modify Ambient', Default = false }):AddColorPicker('AmbientColor', { Default = Color3.new(1,1,1) })
    WorldGroup:AddSlider('WorldBrightness', { Text = 'Brightness', Default = 2, Min = 0, Max = 10, Rounding = 1 })

    local SelfGroup = Tabs.Visuals:AddRightGroupbox('Self Visuals')
    SelfGroup:AddToggle('FFChams', { Text = 'ForceField Chams', Default = false }):AddColorPicker('FFColor', { Default = Color3.fromRGB(180, 0, 255) })

    -- [[ VISUALS TAB - NEW SPINNING CROSSHAIR GROUP ]] --
    local CrosshairGroupBox = Tabs.Visuals:AddLeftGroupbox('Crosshair')
    CrosshairGroupBox:AddToggle('CrosshairToggle', { Text = 'Crosshair Enabled', Default = false }):AddColorPicker('CrosshairColor', { Default = Color3.fromRGB(199, 110, 255) })
    CrosshairGroupBox:AddToggle('CrosshairSpinToggle', { Text = 'Crosshair Spin', Default = false })
    CrosshairGroupBox:AddToggle('CrosshairResizeToggle', { Text = 'Crosshair Resizing', Default = false })
    CrosshairGroupBox:AddToggle('CrosshairStickToggle', { Text = 'Stick to Target', Default = false })
    CrosshairGroupBox:AddDropdown('CrosshairMode', { Values = { 'Center', 'Mouse' }, Default = 1, Text = 'Placement Position' })

    -- [[ VISUALS TAB - ESP & SOUNDS ]] --
    local ESPGroup = Tabs.Visuals:AddLeftGroupbox('Player Visuals')
    ESPGroup:AddToggle('TargetOnly', { Text = 'Target Only', Default = false })
    ESPGroup:AddToggle('BoxESP', { Text = 'Box ESP', Default = false }):AddColorPicker('BoxColor', { Default = Color3.new(1, 1, 1) })
    ESPGroup:AddToggle('TracerESP', { Text = 'Tracer ESP', Default = false }):AddColorPicker('TracerColor', { Default = Color3.new(1, 1, 1) })
    ESPGroup:AddToggle('NameESP', { Text = 'Name ESP', Default = false }):AddColorPicker('NameColor', { Default = Color3.new(1, 1, 1) })
    ESPGroup:AddToggle('DistESP', { Text = 'Distance ESP', Default = false }):AddColorPicker('DistColor', { Default = Color3.new(1, 1, 1) })
    ESPGroup:AddToggle('ToolESP', { Text = 'Tool ESP', Default = false }):AddColorPicker('ToolColor', { Default = Color3.new(1, 1, 1) })

    local HitSoundGroup = Tabs.Visuals:AddRightGroupbox('Hit Sounds')
    HitSoundGroup:AddToggle('HitSoundToggle', { Text = 'Hit Sounds', Default = false })
    
    local soundNames = {}
    for name, _ in pairs(HitSoundId) do table.insert(soundNames, name) end
    table.sort(soundNames)
    HitSoundGroup:AddDropdown('SelectedHitSound', { Values = soundNames, Default = 1, Text = 'Sound Selection' })

    local function PlayHitSound()
        if Toggles.HitSoundToggle.Value then
            local sound = Instance.new("Sound")
            sound.SoundId = HitSoundId[Options.SelectedHitSound.Value]
            sound.Volume = 3; sound.Parent = game:GetService("SoundService")
            sound:Play(); game:GetService("Debris"):AddItem(sound, 2)
        end
    end

    -- [[ LEGIT TAB - AIM VIEWER & SPECTATE ]] --
    local ViewerGroup = Tabs.Legit:AddRightGroupbox('Aim Viewer')
    ViewerGroup:AddDropdown('AimViewerTarget', { Values = {"None"}, Default = 1, Text = 'Select Player' })
    ViewerGroup:AddButton('Refresh Players', function()
        local list = {}
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer then table.insert(list, p.Name) end
        end
        if #list == 0 then table.insert(list, "None") end
        Options.AimViewerTarget:SetValues(list)
    end)
    ViewerGroup:AddToggle('AimViewerToggle', { Text = 'Aim Viewer', Default = false })
    ViewerGroup:AddToggle('SpectateToggle', { Text = 'Spectate Player', Default = false })

    -- [[ LEGIT TAB - SILENT AIM GROUP ]] --
    local SilentGroup = Tabs.Legit:AddLeftGroupbox('Silent Aim')
    SilentGroup:AddToggle('SilentEnabled', { Text = 'Silent Aim', Default = false })
    SilentGroup:AddToggle('ShowFOV', { Text = 'FOV Circle', Default = false }):AddColorPicker('FOVColor', { Default = Color3.new(1, 1, 1) })
    SilentGroup:AddSlider('FOVSize', { Text = 'FOV Radius', Default = 100, Min = 1, Max = 500, Rounding = 0 })
    SilentGroup:AddDropdown('SilentPart', { Values = { 'Head', 'UpperTorso', 'Torso', 'LowerTorso', 'HumanoidRootPart' }, Default = 1, Text = 'Target Part' })
    SilentGroup:AddInput('SilentX', { Default = '0.1', Text = 'Prediction X' })
    SilentGroup:AddInput('SilentY', { Default = '0.1', Text = 'Prediction Y' })
    SilentGroup:AddToggle('SilentCamlock', { Text = 'Camlock', Default = false })
    SilentGroup:AddInput('SilentSmoothness', { Default = '0.1', Text = 'Cam Smoothness' })
    SilentGroup:AddToggle('SilentVisualizer', { Text = 'Prediction Visualizer', Default = false })

    local ShakeGroup = Tabs.Legit:AddRightGroupbox('Shake')
    ShakeGroup:AddSlider('ShakeX', { Text = 'Shake X', Default = 0, Min = 0, Max = 1, Rounding = 2 })
    ShakeGroup:AddSlider('ShakeY', { Text = 'Shake Y', Default = 0, Min = 0, Max = 1, Rounding = 2 })
    ShakeGroup:AddSlider('ShakeZ', { Text = 'Shake Z', Default = 0, Min = 0, Max = 1, Rounding = 2 })

    -- [[ RAGE TAB - RESOLVER GROUP ]] --
    local ResolverGroup = Tabs.Rage:AddLeftGroupbox('Resolver')
    ResolverGroup:AddToggle('ResolverToggle', { Text = 'Resolver', Default = false })
    ResolverGroup:AddDropdown('ResolverMethod', { Values = { 'Recalculate', 'Velocity Null', 'LookVector' }, Default = 1, Text = 'Method' })

    -- [[ RAGE TAB - HVH / ANTI-AIM ]] --
    local HVHGroup = Tabs.Rage:AddRightGroupbox('HVH / Small(for now)')
    HVHGroup:AddToggle('FakeLagToggle', { Text = 'Fake Lag', Default = false })
    HVHGroup:AddSlider('LagTicks', { Text = 'Lag Ticks', Default = 5, Min = 1, Max = 15, Rounding = 0 })
    HVHGroup:AddToggle('TriggerbotToggle', { Text = 'Triggerbot', Default = false })
    
    -- [[ RAGE TAB - ANTILOCK GROUP ]] --
    local AntiGroup = Tabs.Rage:AddLeftGroupbox('Antilock')
    AntiGroup:AddButton({
        Text = 'Antilock',
        Func = function()
            local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
            local Btn = Instance.new("TextButton", ScreenGui)
            Btn.Size = UDim2.new(0, 180, 0, 50)
            Btn.Position = UDim2.new(0.5, -90, 0.20, 0)
            StylePixelText(Btn, "Antilock")
            Btn.Active, Btn.Draggable = true, true
            
            Btn.MouseButton1Click:Connect(function()
                AntiLockActive = not AntiLockActive
                Btn.TextColor3 = AntiLockActive and Color3.fromRGB(255, 0, 0) or Color3.new(1, 1, 1)
            end)
        end
    })
    AntiGroup:AddDropdown('AntiMethod', { Values = { 'Sky', 'Shake', 'Underground', 'Back' }, Default = 1, Text = 'Method Selection' })

    -- [[ RAGE TAB - SPINBOT GROUP ]] --
    local SpinbotGroup = Tabs.Rage:AddLeftGroupbox('Spinbot')
    SpinbotGroup:AddToggle('SpinbotToggle', { Text = 'Spinbot', Default = false, Callback = function(Value) SpinbotActive = Value end })
    SpinbotGroup:AddSlider('SpinSpeed', { Text = 'Speed', Default = 50, Min = 0, Max = 100, Rounding = 1 })

    -- [[ RAGE TAB - ORBIT GROUP ]] --
    local OrbitGroup = Tabs.Rage:AddLeftGroupbox('Orbit')
    OrbitGroup:AddButton({
        Text = 'Orbit',
        Func = function()
            local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
            local Btn = Instance.new("TextButton", ScreenGui)
            Btn.Size = UDim2.new(0, 180, 0, 50)
            Btn.Position = UDim2.new(0.5, -90, 0.55, 0)
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
    OrbitGroup:AddSlider('OrbitSpeed', { Text = 'Speed', Default = 1, Min = 1, Max = 100, Rounding = 1 })
    OrbitGroup:AddSlider('OrbitDistance', { Text = 'Distance', Default = 5, Min = 1, Max = 100, Rounding = 1 })
    OrbitGroup:AddSlider('OrbitHeight', { Text = 'Height', Default = 0, Min = 0, Max = 100, Rounding = 1 })

    -- [[ RAGE TAB - CFRAME GROUP ]] --
    local CFrameGroup = Tabs.Rage:AddRightGroupbox('CFrame')
    CFrameGroup:AddButton({
        Text = 'CFrame',
        Func = function()
            local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
            local Btn = Instance.new("TextButton", ScreenGui)
            Btn.Size = UDim2.new(0, 180, 0, 50)
            Btn.Position = UDim2.new(0.5, -90, 0.68, 0)
            StylePixelText(Btn, "Cframe")
            Btn.Active, Btn.Draggable = true, true
            
            Btn.MouseButton1Click:Connect(function()
                CFrameActive = not CFrameActive
                Btn.TextColor3 = CFrameActive and Color3.fromRGB(255, 0, 0) or Color3.new(1, 1, 1)
            end)
        end
    })
    CFrameGroup:AddSlider('CFrameSpeed', { Text = 'Speed', Default = 1, Min = 1, Max = 100, Rounding = 1 })

    -- [[ CHECKS GROUP ]] --
    local ChecksGroup = Tabs.Aimlock:AddLeftGroupbox('Checks')
    ChecksGroup:AddToggle('WallCheck', { Text = 'Wall Check', Default = false })
    ChecksGroup:AddToggle('KOCheck', { Text = 'KO Check', Default = false })
    ChecksGroup:AddToggle('TeamCheck', { Text = 'Team Check', Default = false })
    ChecksGroup:AddToggle('AutoUnlock', { Text = 'Auto Unlock', Default = false })

    -- [[ HITPART GROUP ]] --
    local HitpartGroup = Tabs.Aimlock:AddLeftGroupbox('Hitpart')
    HitpartGroup:AddDropdown('TargetPart', { Values = { 'Head', 'UpperTorso', 'Torso', 'LowerTorso', 'HumanoidRootPart' }, Default = 5, Text = 'Body Part Selection' })

    -- [[ PREDICTION GROUP ]] --
    local PredGroup = Tabs.Aimlock:AddRightGroupbox('Prediction')
    PredGroup:AddInput('XPred', { Default = '0.1', Text = 'X Prediction' })
    PredGroup:AddInput('YPred', { Default = '0.1', Text = 'Y Prediction' })
    PredGroup:AddInput('Smoothness', { Default = '0.9', Text = 'Cam Smoothness' })
    
    -- Replaced old dropdown with Easing Style and Easing Direction dropdowns configured under Cam Smoothness
    PredGroup:AddDropdown('EasingStyle', { Values = { 'Linear', 'Sine', 'Back', 'Quad', 'Quart', 'Quint', 'Bounce', 'Elastic', 'Exponential', 'Circular', 'Cubic' }, Default = 1, Text = 'Easing Style' })
    PredGroup:AddDropdown('EasingDirection', { Values = { 'In', 'Out', 'InOut' }, Default = 3, Text = 'Easing Direction' })
    
    PredGroup:AddDropdown('Method', { Values = { 'Index', 'Namecall' }, Default = 1, Text = 'Method' })

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

    -- ORIGINAL LIGHTING CACHE
    local originalLighting = {
        ClockTime = Lighting.ClockTime,
        Ambient = Lighting.Ambient,
        Brightness = Lighting.Brightness
    }

    -- [[ MAIN LOOP ]] --
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
                    AimViewerLine.Visible = true
                    AimViewerLine.From = Vector2.new(headScreen.X, headScreen.Y)
                    AimViewerLine.To = Vector2.new(lookScreen.X, lookScreen.Y)
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
            SilentCircle.Visible = true
            SilentCircle.Radius = Options.FOVSize.Value
            SilentCircle.Color = Options.FOVColor.Value
            SilentCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
        else
            SilentCircle.Visible = false
        end

        -- Silent Aim Updates
        if Toggles.SilentEnabled.Value then
            SilentTarget = GetSilentTarget()
            if SilentTarget and SilentTarget.Character then
                local sPart = SilentTarget.Character:FindFirstChild(Options.SilentPart.Value) or SilentTarget.Character:FindFirstChild("HumanoidRootPart")
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
                else
                    SilentVisualizerDot.Visible = false
                end
            else
                SilentVisualizerDot.Visible = false
            end
        else
            SilentTarget = nil; SilentVisualizerDot.Visible = false
        end

        -- Hit Detection Sound
        if LockActive and CurrentTarget and CurrentTarget.Character then
            local hum = CurrentTarget.Character:FindFirstChildOfClass("Humanoid")
            if hum then
                local currentHealth = hum.Health
                local previousHealth = lastHealths[CurrentTarget.Character] or currentHealth
                if currentHealth < previousHealth then PlayHitSound() end
                lastHealths[CurrentTarget.Character] = currentHealth
            end
        end

        -- DYNAMIC ESP RENDERING
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
                        drawing.Name.Text = ent.Name
                        drawing.Name.Position = Vector2.new(pPos.X, pPos.Y - (boxHeight/2) - 18)
                        drawing.Name.Color = Options.NameColor.Value
                    end

                    drawing.Dist.Visible = Toggles.DistESP.Value
                    if drawing.Dist.Visible and root then
                        drawing.Dist.Text = math.floor((root.Position - pRoot.Position).Magnitude) .. "m"
                        drawing.Dist.Position = Vector2.new(pPos.X, pPos.Y + (boxHeight/2) + 5)
                        drawing.Dist.Color = Options.DistColor.Value
                    end

                    drawing.Tool.Visible = Toggles.ToolESP.Value
                    if drawing.Tool.Visible then
                        local tool = ent.Character:FindFirstChildOfClass("Tool")
                        drawing.Tool.Text = tool and tool.Name or "None"
                        drawing.Tool.Position = Vector2.new(pPos.X, pPos.Y + (boxHeight/2) + 18)
                        drawing.Tool.Color = Options.ToolColor.Value
                    end
                end
            end
        end

        -- Spinbot, Anti-Lock, CFrame
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
            if hum and hum.MoveDirection.Magnitude > 0 then
                root.CFrame = root.CFrame + (hum.MoveDirection * Options.CFrameSpeed.Value * dt)
            end
        end

        -- Orbit Movement Logic
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

        -- Aimlock / Prediction Logic & Unified Notification Management
        local CalculatedCrosshairPos = nil
        if LockActive then
            if CurrentTarget then
                local tChar = CurrentTarget.Character
                local tHum = tChar and tChar:FindFirstChildOfClass("Humanoid")
                
                -- Check for Target Death, Despawn, or AutoUnlock knock out
                if not tChar or not tChar.Parent or (Toggles.AutoUnlock.Value and GetKnockStatus(CurrentTarget)) or (tHum and tHum.Health <= 0) then
                    if tHum and tHum.Health <= 0 then
                        Library:Notify(CurrentTarget.Name .. " Died LOL")
                    else
                        Library:Notify("speared " .. CurrentTarget.Name)
                    end
                    CurrentTarget = nil
                    TargetNotified = nil
                end
            end

            -- Target Acquisition & Swapping Sequence
            if not CurrentTarget then 
                CurrentTarget = GetClosestToCrosshair(false) 
                if CurrentTarget then
                    Library:Notify("locked on " .. CurrentTarget.Name)
                    TargetNotified = CurrentTarget
                end
            elseif CurrentTarget ~= TargetNotified then
                -- Target automatically shifted to a different player/NPC
                if TargetNotified then
                    Library:Notify("speared " .. TargetNotified.Name)
                end
                Library:Notify("locked on " .. CurrentTarget.Name)
                TargetNotified = CurrentTarget
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
                            ResolvedVelocity = (TargetPart.Position - lastPos) / dt
                            targetPosHistory[CurrentTarget.Character] = TargetPart.Position
                        elseif method == "Velocity Null" then
                            ResolvedVelocity = Vector3.new(math.clamp(ResolvedVelocity.X, -70, 70), math.clamp(ResolvedVelocity.Y, -70, 70), math.clamp(ResolvedVelocity.Z, -70, 70))
                        elseif method == "LookVector" then
                            ResolvedVelocity = TargetPart.CFrame.LookVector * TargetPart.Velocity.Magnitude
                        end
                    end
                    
                    if Toggles.AntiGroundShot.Value and ResolvedVelocity.Y < -10 then
                        ResolvedVelocity = Vector3.new(ResolvedVelocity.X, 0, ResolvedVelocity.Z)
                    end

                    local predX, predY = tonumber(Options.XPred.Value) or 0.1, tonumber(Options.YPred.Value) or 0.1
                    local PredPos = TargetPart.Position + (ResolvedVelocity * Vector3.new(predX, predY, predX))

                    -- Jump / Fall Offset Logic 
                    if currentHum and (currentHum.FloorMaterial == Enum.Material.Air or currentHum:GetState() == Enum.HumanoidStateType.Freefall or currentHum:GetState() == Enum.HumanoidStateType.Jumping) then
                        if TargetPart.Velocity.Y > 0 then
                            -- Moving up (Jumping)
                            PredPos = PredPos + Vector3.new(0, tonumber(Options.JumpOffset.Value) or 0, 0)
                        else
                            -- Moving down (Falling)
                            PredPos = PredPos + Vector3.new(0, tonumber(Options.FallOffset.Value) or 0, 0)
                        end
                    end

                    local visible = IsVisible(TargetPart)
                    
                    -- Capture the lock-on viewport coordinates for crosshair targeting
                    local cScrPos, cOnScr = Camera:WorldToViewportPoint(PredPos)
                    if cOnScr then
                        CalculatedCrosshairPos = Vector2.new(cScrPos.X, cScrPos.Y)
                    end

                    if Toggles.PredVisualizer.Value then
                        local screenPos, onScreen = Camera:WorldToViewportPoint(PredPos)
                        local partPos, partOnScreen = Camera:WorldToViewportPoint(TargetPart.Position)
                        
                        if onScreen and partOnScreen then
                            PredictionTracer.Visible = true; PredictionTracer.From = Vector2.new(partPos.X, partPos.Y); PredictionTracer.To = Vector2.new(screenPos.X, screenPos.Y)
                            PredictionDot.Visible = true; PredictionDot.Position = Vector2.new(screenPos.X, screenPos.Y)
                        else
                            PredictionTracer.Visible = false; PredictionDot.Visible = false
                        end
                    else
                        PredictionTracer.Visible = false; PredictionDot.Visible = false
                    end

                    SharedShake = Vector3.new(
                        (math.random(-100, 100) / 250) * Options.ShakeX.Value,
                        (math.random(-100, 100) / 250) * Options.ShakeY.Value,
                        (math.random(-100, 100) / 250) * Options.ShakeZ.Value
                    )

                    if Toggles.LookAtPlayer.Value and (not Toggles.WallCheck.Value or visible) then
                        root.CFrame = CFrame.new(root.Position, Vector3.new(PredPos.X, root.Position.Y, PredPos.Z))
                    end

                    -- [ CAMLOCK WITH ROBLOX TWEENSERVICE EASING STYLES ] --
                    if Toggles.Camlock.Value and (not Toggles.WallCheck.Value or visible) then
                        local smoothBase = tonumber(Options.Smoothness.Value) or 0.1
                        
                        local currentLook = Camera.CFrame.LookVector
                        local targetLook = (PredPos + SharedShake - Camera.CFrame.Position).Unit
                        local dotProduct = currentLook:Dot(targetLook)
                        local angleDiff = math.acos(math.clamp(dotProduct, -1, 1))
                        
                        -- Normalize angular distance (up to ~28 degrees) to act as progress alpha
                        local progress = math.clamp(angleDiff / 0.5, 0, 1)
                        
                        local TweenService = game:GetService("TweenService")
                        local success, easedFactor = pcall(function()
                            return TweenService:GetValue(
                                progress, 
                                Enum.EasingStyle[Options.EasingStyle.Value], 
                                Enum.EasingDirection[Options.EasingDirection.Value]
                            )
                        end)
                        
                        if not success or not easedFactor then 
                            easedFactor = progress 
                        end
                        
                        local adjustedSmooth = smoothBase * easedFactor
                        Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, PredPos + SharedShake), math.clamp(adjustedSmooth, 0, 1))
                    end
                    
                    -- Classic State-based Auto Air Logic mapped to our new Toggle
                    if Toggles.AutoAirToggle.Value and visible and currentHum and (currentHum.FloorMaterial == Enum.Material.Air or currentHum:GetState() == Enum.HumanoidStateType.Freefall or currentHum:GetState() == Enum.HumanoidStateType.Jumping) then
                        if tick() - lastShot >= (tonumber(Options.AirDelay.Value) or 0.15) then
                            lastShot = tick()
                            local tool = char:FindFirstChildOfClass("Tool")
                            if tool then tool:Activate() end
                        end
                    end
                end
            else
                PredictionTracer.Visible = false; PredictionDot.Visible = false
            end
        else
            SharedShake = Vector3.zero
            PredictionTracer.Visible = false; PredictionDot.Visible = false
        end

        -- [[ SPINNING CROSSHAIR POST-SIMULATION WORKER ]] --
        local _tick = tick()
        if _tick - last_render > crosshair.refreshrate then
            last_render = _tick

            -- Position assignment matching new dropdown + sticking properties
            local position = Camera.ViewportSize / 2
            if Toggles.CrosshairStickToggle.Value and CalculatedCrosshairPos then
                position = CalculatedCrosshairPos
            elseif Options.CrosshairMode.Value == 'Mouse' then
                position = inputservice:GetMouseLocation()
            end

            local text_x = drawings.text[1].TextBounds.X + drawings.text[2].TextBounds.X

            drawings.text[1].Visible = Toggles.CrosshairToggle.Value
            drawings.text[2].Visible = Toggles.CrosshairToggle.Value

            if Toggles.CrosshairToggle.Value then
                drawings.text[1].Position = position + Vector2.new(-text_x / 2, crosshair.radius + (Toggles.CrosshairResizeToggle.Value and crosshair.resize_max or crosshair.length) + 15)
                drawings.text[2].Position = drawings.text[1].Position + Vector2.new(drawings.text[1].TextBounds.X)
                drawings.text[2].Color = Options.CrosshairColor.Value
                
                for idx = 1, 4 do
                    local outline = drawings.crosshair[idx]
                    local inline = drawings.crosshair[idx + 4]
        
                    local angle = (idx - 1) * 90
                    local length = crosshair.length
        
                    if Toggles.CrosshairSpinToggle.Value then
                        local spin_angle = -_tick * crosshair.spin_speed % crosshair.spin_max
                        angle = angle + tweenservice:GetValue(spin_angle / 360, crosshair.spin_style, Enum.EasingDirection.InOut) * 360
                    end
        
                    if Toggles.CrosshairResizeToggle.Value then
                        local resize_length = tick() * crosshair.resize_speed % 180
                        length = crosshair.resize_min + math.sin(math.rad(resize_length)) * crosshair.resize_max
                    end
        
                    inline.Visible = true
                    inline.Color = Options.CrosshairColor.Value
                    inline.From = position + solve(angle, crosshair.radius)
                    inline.To = position + solve(angle, crosshair.radius + length)
                    inline.Thickness = crosshair.width
        
                    outline.Visible = true
                    outline.From = position + solve(angle, crosshair.radius - 1)
                    outline.To = position + solve(angle, crosshair.radius + length + 1)
                    outline.Thickness = crosshair.width + 1.5    
                end
            else
                for idx = 1, 8 do
                    drawings.crosshair[idx].Visible = false
                end
                drawings.text[1].Visible = false
                drawings.text[2].Visible = false
            end
        end
    end)

    -- [[ SILENT AIM HOOKS ]] --
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
                        if Toggles.AntiGroundShot.Value and sVel.Y < -10 then
                            sVel = Vector3.new(sVel.X, 0, sVel.Z)
                        end
                        local pos = sPart.Position + (sVel * Vector3.new(pX, pY, pX)) + SharedShake
                        
                        -- Silent Aim Jump / Fall Offset Support
                        if sHum and (sHum.FloorMaterial == Enum.Material.Air or sHum:GetState() == Enum.HumanoidStateType.Freefall) then
                            if sPart.Velocity.Y > 0 then
                                pos = pos + Vector3.new(0, tonumber(Options.JumpOffset.Value) or 0, 0)
                            else
                                pos = pos + Vector3.new(0, tonumber(Options.FallOffset.Value) or 0, 0)
                            end
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

                    if Toggles.AntiGroundShot.Value and ResolvedVelocity.Y < -10 then
                        ResolvedVelocity = Vector3.new(ResolvedVelocity.X, 0, ResolvedVelocity.Z)
                    end

                    local PredPos = TargetPart.Position + (ResolvedVelocity * Vector3.new(predX, predY, predX))
                    
                    -- Jump / Fall Offset Support
                    if cHum and (cHum.FloorMaterial == Enum.Material.Air or cHum:GetState() == Enum.HumanoidStateType.Freefall) then
                        if TargetPart.Velocity.Y > 0 then
                            PredPos = PredPos + Vector3.new(0, tonumber(Options.JumpOffset.Value) or 0, 0)
                        else
                            PredPos = PredPos + Vector3.new(0, tonumber(Options.FallOffset.Value) or 0, 0)
                        end
                    end

                    return (index == "Hit" and CFrame.new(PredPos) or TargetPart)
                end
            end
        end
        return oldIndex(self, index)
    end)
    setreadonly(mt, true)

    -- [[ FINAL LOAD SEQUENCE ]] --
    ThemeManager:SetLibrary(Library); SaveManager:SetLibrary(Library)
    SaveManager:BuildConfigSection(Tabs['Settings']); ThemeManager:ApplyToTab(Tabs['Settings'])
    Library:Notify('Extract.cc | Beta v4.2 Loaded')
end

getgenv().ExtractCC()
