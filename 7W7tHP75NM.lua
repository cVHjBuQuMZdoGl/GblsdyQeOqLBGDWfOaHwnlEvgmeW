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
        Title = 'Extract.cc | Beta test v3.6',
        Center = true,
        AutoShow = true,
        TabPadding = 8,
        MenuFadeTime = 0.2
    })


    -- [ SERVICES ] --
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local LocalPlayer = Players.LocalPlayer
    local Camera = workspace.CurrentCamera
    local Mouse = LocalPlayer:GetMouse()

    -- [ VARIABLES ] --
    local LockActive, AutoAirActive = false, false
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

    -- [ HITSOUND DATA ] --
    local HitSoundId = {
        Bameware = "rbxassetid://3124331820",
        Bell = "rbxassetid://6534947240",
        Bubble = "rbxassetid://6534947588",
        Pick = "rbxassetid://1347140027",
        Pop = "rbxassetid://198598793",
        Rust = "rbxassetid://1255040462",
        Sans = "rbxassetid://3188795283",
        Fart = "rbxassetid://130833677",
        Big = "rbxassetid://5332005053",
        Vine = "rbxassetid://5332680810",
        Bruh = "rbxassetid://4578740568",
        Skeet = "rbxassetid://5633695679",
        Neverlose = "rbxassetid://6534948092",
        Fatality = "rbxassetid://6534947869",
        Bonk = "rbxassetid://5766898159",
        Minecraft = "rbxassetid://4018616850"
    }

    -- [ DRAWING SETUP - WHITE THEME ] --
    local PredictionTracer = Drawing.new("Line")
    PredictionTracer.Visible = false
    PredictionTracer.Color = Color3.fromRGB(255, 255, 255)
    PredictionTracer.Thickness = 1.5
    PredictionTracer.Transparency = 1

    local PredictionDot = Drawing.new("Circle")
    PredictionDot.Visible = false
    PredictionDot.Color = Color3.fromRGB(255, 255, 255)
    PredictionDot.Thickness = 1
    PredictionDot.Radius = 4
    PredictionDot.Filled = true

    local SilentCircle = Drawing.new("Circle")
    SilentCircle.Visible = false
    SilentCircle.Color = Color3.fromRGB(255, 255, 255)
    SilentCircle.Thickness = 1
    SilentCircle.Filled = false

    local SilentVisualizerDot = Drawing.new("Circle")
    SilentVisualizerDot.Visible = false
    SilentVisualizerDot.Color = Color3.fromRGB(255, 0, 0)
    SilentVisualizerDot.Thickness = 1
    SilentVisualizerDot.Radius = 4
    SilentVisualizerDot.Filled = true

    -- [ TABS ] --
    local Tabs = {
        Aimlock = Window:AddTab('Aimlock'),
        Visuals = Window:AddTab('Visuals'),
        Legit = Window:AddTab('Legit'),
        Rage = Window:AddTab('Rage'),
        ['Settings'] = Window:AddTab('Settings'),
    }

    -- [[ PIXEL TEXT STYLING ]] --
    local function StylePixelText(btn, text)
        btn.BackgroundTransparency = 1
        btn.BorderSizePixel = 0
        btn.Font = Enum.Font.Arcade 
        btn.Text = "  " .. text .. "  "
        btn.TextSize = 28
        btn.TextColor3 = Color3.new(1, 1, 1)

        local textStroke = Instance.new("UIStroke", btn)
        textStroke.Thickness = 2.5
        textStroke.Color = Color3.new(0, 0, 0)
        textStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
    end

    -- [[ AIMLOCK GROUP ]] --
    local MainGroup = Tabs.Aimlock:AddLeftGroupbox('Aimlock')

    MainGroup:AddButton({
        Text = 'Extract.cc',
        Func = function()
            local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
            local Btn = Instance.new("TextButton", ScreenGui)
            Btn.Size = UDim2.new(0, 200, 0, 50)
            Btn.Position = UDim2.new(0.5, -100, 0.30, 0)
            StylePixelText(Btn, "EXTRACT.CC")
            Btn.Active, Btn.Draggable = true, true
            Btn.MouseButton1Click:Connect(function()
                LockActive = not LockActive
                Btn.TextColor3 = LockActive and Color3.fromRGB(180, 0, 255) or Color3.new(1, 1, 1)
            end)
        end
    })

    MainGroup:AddButton({
        Text = 'Auto Air',
        Func = function()
            local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
            local Btn = Instance.new("TextButton", ScreenGui)
            Btn.Size = UDim2.new(0, 180, 0, 50)
            Btn.Position = UDim2.new(0.5, -90, 0.42, 0)
            StylePixelText(Btn, "Auto air")
            Btn.Active, Btn.Draggable = true, true
            Btn.MouseButton1Click:Connect(function()
                AutoAirActive = not AutoAirActive
                Btn.TextColor3 = AutoAirActive and Color3.fromRGB(180, 0, 255) or Color3.new(1, 1, 1)
            end)
        end
    })

    MainGroup:AddDropdown('TargetType', {
        Values = { 'Players', 'NPCs', 'Both' },
        Default = 1,
        Text = 'Target Entity',
    })

    MainGroup:AddToggle('Camlock', { Text = 'Camlock', Default = true })
    MainGroup:AddToggle('LookAtPlayer', { Text = 'Look At Player', Default = false })
    MainGroup:AddToggle('PredVisualizer', { Text = 'Prediction Visualizer', Default = false }) 
    MainGroup:AddToggle('AntiGroundShot', { Text = 'Anti Ground Shot', Default = false })
    MainGroup:AddInput('AirDelay', { Default = '0.22', Text = 'Auto Air Delay (ms)' })

    -- [[ VISUALS TAB ]] --
    local ESPGroup = Tabs.Visuals:AddLeftGroupbox('Player Visuals')

    ESPGroup:AddToggle('TargetOnly', { Text = 'Target Only', Default = false })
    ESPGroup:AddToggle('BoxESP', { Text = 'Box ESP', Default = false }):AddColorPicker('BoxColor', { Default = Color3.new(1, 1, 1) })
    ESPGroup:AddToggle('TracerESP', { Text = 'Tracer ESP', Default = false }):AddColorPicker('TracerColor', { Default = Color3.new(1, 1, 1) })
    ESPGroup:AddToggle('NameESP', { Text = 'Name ESP', Default = false }):AddColorPicker('NameColor', { Default = Color3.new(1, 1, 1) })
    ESPGroup:AddToggle('DistESP', { Text = 'Distance ESP', Default = false }):AddColorPicker('DistColor', { Default = Color3.new(1, 1, 1) })
    ESPGroup:AddToggle('ToolESP', { Text = 'Tool ESP', Default = false }):AddColorPicker('ToolColor', { Default = Color3.new(1, 1, 1) })

    -- [[ VISUALS TAB - HITSOUNDS ]] --
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
            sound.Volume = 3 
            sound.Parent = game:GetService("SoundService")
            sound:Play()
            game:GetService("Debris"):AddItem(sound, 2)
        end
    end

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

    -- [[ LEGIT TAB - SHAKE GROUP ]] --
    local ShakeGroup = Tabs.Legit:AddRightGroupbox('Shake')
    ShakeGroup:AddSlider('ShakeX', { Text = 'Shake X', Default = 0, Min = 0, Max = 1, Rounding = 2 })
    ShakeGroup:AddSlider('ShakeY', { Text = 'Shake Y', Default = 0, Min = 0, Max = 1, Rounding = 2 })
    ShakeGroup:AddSlider('ShakeZ', { Text = 'Shake Z', Default = 0, Min = 0, Max = 1, Rounding = 2 })

    -- [[ RAGE TAB - RESOLVER GROUP ]] --
    local ResolverGroup = Tabs.Rage:AddLeftGroupbox('Resolver')
    ResolverGroup:AddToggle('ResolverToggle', { Text = 'Resolver', Default = false })
    ResolverGroup:AddDropdown('ResolverMethod', { Values = { 'Recalculate', 'Velocity Null', 'LookVector' }, Default = 1, Text = 'Method' })

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
                    
                    -- SPECTATE LOGIC APPLIED ONCE UPON ACTIVATION
                    if OrbitTarget and OrbitTarget.Character then
                        local tHum = OrbitTarget.Character:FindFirstChildOfClass("Humanoid")
                        if tHum then
                            Camera.CameraSubject = tHum
                        end
                    end
                else
                    OrbitTarget = nil
                    
                    -- RESET SPECTATE LOGIC WHEN DEACTIVATED
                    if LocalPlayer.Character then
                        local myHum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                        if myHum then
                            Camera.CameraSubject = myHum
                        end
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
                        if not Players:GetPlayerFromCharacter(v) then
                            table.insert(npcs, v)
                        end
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

    -- [[ DYNAMIC ESP SETUP ]] --
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

    -- [[ MAIN LOOP ]] --
    RunService.Heartbeat:Connect(function(dt)
        local char = LocalPlayer.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        
        -- Update FOV Circle
        if Toggles.ShowFOV and Toggles.ShowFOV.Value then
            SilentCircle.Visible = true
            SilentCircle.Radius = Options.FOVSize.Value
            SilentCircle.Color = Options.FOVColor.Value
            SilentCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
        else
            SilentCircle.Visible = false
        end

        -- Update Silent Target and Visualizer/Camlock
        if Toggles.SilentEnabled and Toggles.SilentEnabled.Value then
            SilentTarget = GetSilentTarget()
            if SilentTarget and SilentTarget.Character then
                local sPart = SilentTarget.Character:FindFirstChild(Options.SilentPart.Value) or SilentTarget.Character:FindFirstChild("HumanoidRootPart")
                if sPart then
                    local pX, pY = tonumber(Options.SilentX.Value) or 0.1, tonumber(Options.SilentY.Value) or 0.1
                    local sVel = sPart.Velocity
                    if Toggles.AntiGroundShot and Toggles.AntiGroundShot.Value and sVel.Y < -10 then sVel = Vector3.new(sVel.X, 0, sVel.Z) end
                    local pos = sPart.Position + (sVel * Vector3.new(pX, pY, pX)) + SharedShake
                    
                    if Toggles.SilentCamlock.Value then
                        local smooth = tonumber(Options.SilentSmoothness.Value) or 0.1
                        Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, pos), smooth)
                    end

                    if Toggles.SilentVisualizer.Value then
                        local screenPos, onScreen = Camera:WorldToViewportPoint(pos)
                        if onScreen then
                            SilentVisualizerDot.Visible = true
                            SilentVisualizerDot.Position = Vector2.new(screenPos.X, screenPos.Y)
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
            SilentTarget = nil
            SilentVisualizerDot.Visible = false
        end

        -- Hit Detection Logic
        if LockActive and CurrentTarget and CurrentTarget.Character then
            local hum = CurrentTarget.Character:FindFirstChildOfClass("Humanoid")
            if hum then
                local currentHealth = hum.Health
                local previousHealth = lastHealths[CurrentTarget.Character] or currentHealth
                if currentHealth < previousHealth then PlayHitSound() end
                lastHealths[CurrentTarget.Character] = currentHealth
            end
        end

        -- DYNAMIC ESP RENDERING LOOP
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
            if Toggles.SilentEnabled and Toggles.SilentEnabled.Value then
                isTarget = (SilentTarget and SilentTarget.Character == ent.Character)
            else
                isTarget = (CurrentTarget and CurrentTarget.Character == ent.Character)
            end
            
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

        -- Spinbot Logic
        if SpinbotActive and root then root.CFrame = root.CFrame * CFrame.Angles(0, math.rad(Options.SpinSpeed.Value), 0) end

        -- Anti-Lock Logic
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

        -- CFrame Speed
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

        -- Aimlock / Prediction Logic
        if LockActive then
            if CurrentTarget and (not CurrentTarget.Character.Parent or (Toggles.AutoUnlock.Value and GetKnockStatus(CurrentTarget))) then
                CurrentTarget = nil
            end

            if not CurrentTarget then CurrentTarget = GetClosestToCrosshair(false) end

            if CurrentTarget and CurrentTarget.Character then
                local TargetPart = CurrentTarget.Character:FindFirstChild(Options.TargetPart.Value) or CurrentTarget.Character:FindFirstChild("HumanoidRootPart")
                
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
                    local visible = IsVisible(TargetPart)
                    
                    if Toggles.PredVisualizer.Value then
                        local screenPos, onScreen = Camera:WorldToViewportPoint(PredPos)
                        local partPos, partOnScreen = Camera:WorldToViewportPoint(TargetPart.Position)
                        
                        if onScreen and partOnScreen then
                            PredictionTracer.Visible = true
                            PredictionTracer.From = Vector2.new(partPos.X, partPos.Y)
                            PredictionTracer.To = Vector2.new(screenPos.X, screenPos.Y)
                            PredictionDot.Visible = true
                            PredictionDot.Position = Vector2.new(screenPos.X, screenPos.Y)
                        else
                            PredictionTracer.Visible = false
                            PredictionDot.Visible = false
                        end
                    else
                        PredictionTracer.Visible = false
                        PredictionDot.Visible = false
                    end

                    SharedShake = Vector3.new(
                        (math.random(-100, 100) / 250) * Options.ShakeX.Value,
                        (math.random(-100, 100) / 250) * Options.ShakeY.Value,
                        (math.random(-100, 100) / 250) * Options.ShakeZ.Value
                    )

                    if Toggles.LookAtPlayer.Value and (not Toggles.WallCheck.Value or visible) then
                        root.CFrame = CFrame.new(root.Position, Vector3.new(PredPos.X, root.Position.Y, PredPos.Z))
                    end

                    if Toggles.Camlock.Value and (not Toggles.WallCheck.Value or visible) then
                        local smooth = tonumber(Options.Smoothness.Value) or 0.1
                        Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, PredPos + SharedShake), smooth)
                    end
                    
                    local currentHum = CurrentTarget.Character:FindFirstChildOfClass("Humanoid")
                    if AutoAirActive and visible and currentHum and currentHum.FloorMaterial == Enum.Material.Air then
                        if tick() - lastShot >= (tonumber(Options.AirDelay.Value) or 0.22) then
                            lastShot = tick()
                            local tool = char:FindFirstChildOfClass("Tool")
                            if tool then tool:Activate() end
                        end
                    end
                end
            else
                PredictionTracer.Visible = false
                PredictionDot.Visible = false
            end
        else
            CurrentTarget = nil
            SharedShake = Vector3.zero
            PredictionTracer.Visible = false
            PredictionDot.Visible = false
        end
    end)

    -- [[ SILENT AIM HOOKS ]] --
    local mt = getrawmetatable(game)
    local oldIndex = mt.__index
    setreadonly(mt, false)

    mt.__index = newcclosure(function(self, index)
        if not checkcaller() and self == Mouse and (index == "Hit" or index == "Target") then
            if Toggles.SilentEnabled and Toggles.SilentEnabled.Value then
                local sTarget = SilentTarget
                if sTarget and sTarget.Character then
                    local sPart = sTarget.Character:FindFirstChild(Options.SilentPart.Value) or sTarget.Character:FindFirstChild("HumanoidRootPart")
                    if sPart then
                        local pX, pY = tonumber(Options.SilentX.Value) or 0.1, tonumber(Options.SilentY.Value) or 0.1
                        local sVel = sPart.Velocity
                        if Toggles.AntiGroundShot and Toggles.AntiGroundShot.Value and sVel.Y < -10 then
                            sVel = Vector3.new(sVel.X, 0, sVel.Z)
                        end
                        local pos = sPart.Position + (sVel * Vector3.new(pX, pY, pX)) + SharedShake
                        return (index == "Hit" and CFrame.new(pos) or sPart)
                    end
                end
            end

            if LockActive and CurrentTarget and Options.Method.Value == "Index" then
                local TargetPart = CurrentTarget.Character:FindFirstChild(Options.TargetPart.Value) or CurrentTarget.Character:FindFirstChild("HumanoidRootPart")
                if TargetPart then
                    local predX, predY = tonumber(Options.XPred.Value) or 0.1, tonumber(Options.YPred.Value) or 0.1
                    local ResolvedVelocity = TargetPart.Velocity
                    
                    if Toggles.ResolverToggle and Toggles.ResolverToggle.Value then
                        if Options.ResolverMethod.Value == "Velocity Null" then
                            ResolvedVelocity = Vector3.new(math.clamp(ResolvedVelocity.X, -70, 70), math.clamp(ResolvedVelocity.Y, -70, 70), math.clamp(ResolvedVelocity.Z, -70, 70))
                        end
                    end

                    if Toggles.AntiGroundShot and Toggles.AntiGroundShot.Value and ResolvedVelocity.Y < -10 then
                        ResolvedVelocity = Vector3.new(ResolvedVelocity.X, 0, ResolvedVelocity.Z)
                    end

                    local PredPos = TargetPart.Position + (ResolvedVelocity * Vector3.new(predX, predY, predX))
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
    Library:Notify('Extract.cc | Beta v3.6 Loaded')
end

-- Auto-execute the function
getgenv().ExtractCC()

