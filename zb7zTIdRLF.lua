-- [[ OBSIDIAN UI LIBRARY INITIALIZATION ]]
local Obsidian = loadstring(game:HttpGet("https://raw.githubusercontent.com/zxciaz/VenyxUI/main/Revenant"))() -- Standard Obsidian/Venyx distribution layout
local Window = Obsidian.new("Bleed.cc", getgenv().Colors and getgenv().Colors.Accent or Color3.fromRGB(255, 0, 40))

-- Safe service resolution with execution tool compatibility layers
local function getService(serviceName)
    local success, res = pcall(function() 
        return cloneref(game:GetService(serviceName)) 
    end)
    if success and res then return res end
    local regularSuccess, regularRes = pcall(function() return game:GetService(serviceName) end)
    if regularSuccess then return regularRes end
    return nil
end

local Workspace = getService("Workspace")
local RunService = getService("RunService")
local Players = getService("Players")
local TweenService = getService("TweenService")
local UserInputService = getService("UserInputService")
local Stats = getService("Stats")
local Debris = getService("Debris") or game:GetService("Debris")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

-- [[ UNIVERSAL UI PROTECTED PARENT RESOLVER ]]
local UIParent = nil
local coreGuiSuccess, coreGui = pcall(function() return game:GetService("CoreGui") end)

local canAccessCoreGui = coreGuiSuccess and coreGui and pcall(function()
    local test = Instance.new("ScreenGui")
    test.Parent = coreGui
    test:Destroy()
end)

if pcall(function() return gethui() end) and gethui() then
    UIParent = gethui()
elseif canAccessCoreGui then
    UIParent = coreGui
else
    UIParent = LocalPlayer:WaitForChild("PlayerGui", 5) or LocalPlayer:FindFirstChildOfClass("PlayerGui")
end

-- [[ TACTICAL COLOR REGISTRY ]]
getgenv().Colors = getgenv().Colors or {
    Accent = Color3.fromRGB(255, 0, 40),      
    AccentMuted = Color3.fromRGB(98, 3, 10),   
    Background = Color3.fromRGB(0, 0, 0),
    DropdownBg = Color3.fromRGB(35, 35, 35),     
    DropdownOption = Color3.fromRGB(45, 45, 45), 
    TextPrimary = Color3.fromRGB(245, 245, 245),
    TextSecondary = Color3.fromRGB(240, 240, 240)
}

-- [[ GLOBAL BLEED SETTINGS ]]
getgenv().BleedSettings = getgenv().BleedSettings or {
    PredictionMode = "Standard", 
    StandardDelayCoefficient = 0.00155, 
    StandardDelayCoefficientY = 0.00118, 
    ZeroDelayValue = 0.035,
    ZeroDelayValueY = 0.026, 

    PredictionX = 0.1,       
    PredictionY = 0.1,       
    WallCheck = false,          
    ResolverActive = true,
    ResolverMode = "MoveDirection",
    MaxRealisticVelocity = 120,          
    AntiGroundShot = true,
    MinHeightAboveGround = 2.5,          
    JumpOffset = 0,            
    FallOffset = 0,
    TargetPart = "HumanoidRootPart",
    PriorityTarget = "None"
}

-- [[ VISUALIZER (ESP) CONFIGURATION ]]
getgenv().ESP = getgenv().ESP or {
    Enabled = false, 
    MaxDistance = 500, 
    FontSize = 11,
    FadeOut = { OnDistance = true, OnDeath = false, OnLeave = false },
    Options = { 
        Friendcheck = true, FriendcheckRGB = Color3.fromRGB(0, 255, 0),
        Highlight = false, HighlightRGB = getgenv().Colors.Accent,
    },
    Drawing = {
        Chams = { Enabled = true, Thermal = true, FillRGB = getgenv().Colors.Accent, Fill_Transparency = 100, OutlineRGB = getgenv().Colors.Accent, Outline_Transparency = 100, VisibleCheck = true },
        Names = { Enabled = true, RGB = getgenv().Colors.TextPrimary },
        Flags = { Enabled = true },
        Distances = { Enabled = true, Position = "Text", RGB = getgenv().Colors.TextPrimary },
        Weapons = { Enabled = true, WeaponTextRGB = getgenv().Colors.Accent, Outlined = false, Gradient = false, GradientRGB1 = getgenv().Colors.TextPrimary, GradientRGB2 = getgenv().Colors.Accent },
        Healthbar = { Enabled = true, HealthText = true, Lerp = false, HealthTextRGB = getgenv().Colors.Accent, Width = 2.5, Gradient = true, GradientRGB1 = Color3.fromRGB(200, 0, 0), GradientRGB2 = getgenv().Colors.AccentMuted, GradientRGB3 = getgenv().Colors.Accent },
        Boxes = { Animate = true, RotationSpeed = 300, Gradient = false, GradientRGB1 = getgenv().Colors.Accent, GradientRGB2 = getgenv().Colors.Background, GradientFill = true, GradientFillRGB1 = getgenv().Colors.Accent, GradientFillRGB2 = getgenv().Colors.Background, Filled = { Enabled = true, Transparency = 0.75, RGB = getgenv().Colors.Background }, Full = { Enabled = true, RGB = getgenv().Colors.TextPrimary }, Corner = { Enabled = true, RGB = getgenv().Colors.TextPrimary } }
    }
}

-- [[ HITSOUND REGISTRY ]]
local hitsounds = {
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

-- [[ VISUAL UTILITY ADAPTERS ]]
local UIBuilder = {}
function UIBuilder:Create(Class, Properties)
    local _Instance = typeof(Class) == 'string' and Instance.new(Class) or Class
    for Property, Value in pairs(Properties) do _Instance[Property] = Value end
    return _Instance
end

function UIBuilder:FadeOutOnDist(element, distance)
    local transparency = math.max(0.1, 1 - (distance / getgenv().ESP.MaxDistance))
    if element:IsA("TextLabel") then element.TextTransparency = 1 - transparency
    elseif element:IsA("ImageLabel") then element.ImageTransparency = 1 - transparency
    elseif element:IsA("UIStroke") then element.Transparency = 1 - transparency
    elseif element:IsA("Frame") then element.BackgroundTransparency = 1 - transparency
    elseif element:IsA("Highlight") then element.FillTransparency = 1 - transparency element.OutlineTransparency = 1 - transparency end
end

-- [[ AUDIO EXECUTION HANDLER ]]
local function playHitSound(soundName)
    local assetId = hitsounds[soundName]
    if assetId then
        local soundObj = Instance.new("Sound")
        soundObj.SoundId = assetId
        soundObj.Volume = 1.5
        soundObj.Parent = Workspace
        soundObj:Play()
        Debris:AddItem(soundObj, 2)
    end
end

-- [[ INTEGRATED NOTIFICATION FEED SYSTEM ]]
local NotificationContainer = UIBuilder:Create("Frame", { Name = "NotificationContainer", Size = UDim2.new(0, 180, 0, 600), Position = UDim2.new(1, -195, 0, 20), BackgroundTransparency = 1, Parent = UIParent })
local UIListLayout = UIBuilder:Create("UIListLayout", { Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Top, Parent = NotificationContainer })

local function sendNotification(messageString)
    task.spawn(function()
        local Holder = UIBuilder:Create("Frame", { Name = "NotificationHolder", Size = UDim2.new(1, 0, 0, 28), BackgroundTransparency = 1, ClipsDescendants = true, Parent = NotificationContainer })
        local VisualCard = UIBuilder:Create("Frame", { Name = "VisualCard", Size = UDim2.new(1, 0, 1, 0), Position = UDim2.new(1.2, 0, 0, 0), BackgroundColor3 = getgenv().Colors.Background, BorderSizePixel = 0, Parent = Holder })
        local CardStroke = UIBuilder:Create("UIStroke", { Color = getgenv().Colors.Accent, Thickness = 1, ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Parent = VisualCard })
        local Label = UIBuilder:Create("TextLabel", { Size = UDim2.new(1, -16, 1, -2), Position = UDim2.new(0, 8, 0, 0), BackgroundTransparency = 1, Text = messageString, TextColor3 = getgenv().Colors.TextSecondary, Font = Enum.Font.Code, TextSize = 10, TextXAlignment = Enum.TextXAlignment.Left, Parent = VisualCard })
        local CooldownBar = UIBuilder:Create("Frame", { Name = "CooldownBar", Size = UDim2.new(1, 0, 0, 2), Position = UDim2.new(0, 0, 1, -2), BackgroundColor3 = getgenv().Colors.Accent, BorderSizePixel = 0, ZIndex = 3, Parent = VisualCard })
        
        local slideIn = TweenService:Create(VisualCard, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(0, 0, 0, 0)})
        slideIn:Play() slideIn.Completed:Wait()
        local cooldownTween = TweenService:Create(CooldownBar, TweenInfo.new(4.0, Enum.EasingStyle.Linear), {Size = UDim2.new(0, 0, 0, 2)})
        cooldownTween:Play() cooldownTween.Completed:Wait() 
        local slideOut = TweenService:Create(VisualCard, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(1.2, 0, 0, 0)})
        slideOut:Play() slideOut.Completed:Wait()
        local collapse = TweenService:Create(Holder, TweenInfo.new(0.12, Enum.EasingStyle.Linear), {Size = UDim2.new(1, 0, 0, 0)})
        collapse:Play() collapse.Completed:Wait()
        Holder:Destroy()
    end)
end

-- [[ TARGETING SYSTEM CONFIGURATION STATE ]]
local AutoPredActive = false
local updatingTargetLock = false 
local isLocked = false
local targetEntity = nil

local function retrievePlayerPool()
    local array = {"None"}
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then table.insert(array, p.DisplayName) end
    end
    return array
end

local componentsList = {"HumanoidRootPart", "Head", "UpperTorso", "LowerTorso"}

-- [[ LATENCY CALIBRATION CONTROLLER ]]
local function generateRandomString(length)
    local s = "" 
    for i = 1, length do s = s .. string.char(math.random(33, 126)) end 
    return s
end

local function generatePredictionsFromPing(pingValue)
    local basePing = pingValue - (pingValue % 100)
    local standardPredictions = "-- [ STANDARD DELAY PREDICTIONS ] --\n"
    local zeroDelayPredictions = "-- [ 0-DELAY PREDICTIONS ] --\n"
    
    for pingMin = basePing, basePing + 100, 10 do
        local averagePing = (pingMin + (pingMin + 10)) / 2
        local standardVal = (averagePing * getgenv().BleedSettings.StandardDelayCoefficient) + (math.random(-5, 5) / 10000)
        standardPredictions = standardPredictions .. string.format("ping%d_%d = %.4f,\n", pingMin, pingMin + 10, standardVal)
        local zeroVal = getgenv().BleedSettings.ZeroDelayValue + (math.random(-2, 2) / 10000)
        zeroDelayPredictions = zeroDelayPredictions .. string.format("ping%d_%d = %.4f,\n", pingMin, pingMin + 10, zeroVal)
    end
    
    return string.format(
        "-- Prediction Profiles\n-- Target Ping: %dms\n-- Generated: %s\n-- Hash: %s\n\n%s\n%s",
        pingValue, os.date("%Y-%m-%d %H:%M:%S"), generateRandomString(12), standardPredictions:sub(1, -2), zeroDelayPredictions:sub(1, -2)
    )
end

-- UI Engine Inputs reference handles for the runtime thread updates
local XInputBoxRef, YInputBoxRef

task.spawn(function()
    while true do
        local currentPing = 100
        pcall(function()
            local networkItem = Stats and Stats:FindFirstChild("Network")
            local serverStats = networkItem and networkItem:FindFirstChild("ServerStatsItem")
            local pingItem = serverStats and serverStats:FindFirstChild("Data Ping")
            if pingItem then
                local parsedPing = tonumber(pingItem:GetValueString():match("%d+"))
                if parsedPing then currentPing = parsedPing end
            end
        end)
        
        pcall(function() if writefile then writefile("prediction_values.txt", generatePredictionsFromPing(currentPing)) end end)
        
        local liveStandardX = (currentPing * getgenv().BleedSettings.StandardDelayCoefficient)
        local liveStandardY = (currentPing * getgenv().BleedSettings.StandardDelayCoefficientY)
        local liveZeroX = getgenv().BleedSettings.ZeroDelayValue
        local liveZeroY = getgenv().BleedSettings.ZeroDelayValueY
        
        local resolvedCalculatedX = (getgenv().BleedSettings.PredictionMode == "Standard") and liveStandardX or liveZeroX
        local resolvedCalculatedY = (getgenv().BleedSettings.PredictionMode == "Standard") and liveStandardY or liveZeroY
        
        if AutoPredActive then
            getgenv().BleedSettings.PredictionX = resolvedCalculatedX
            getgenv().BleedSettings.PredictionY = resolvedCalculatedY
            if XInputBoxRef and YInputBoxRef then
                XInputBoxRef:UpdateTextBox(string.format("%.5f", resolvedCalculatedX))
                YInputBoxRef:UpdateTextBox(string.format("%.5f", resolvedCalculatedY))
            end
        end
        task.wait(3) 
    end
end)

-- [[ 3D RAYCAST VISIBILITY FILTER ]]
local function checkVisibility(targetChar)
    if not targetChar then return false end
    local targetPart = targetChar:FindFirstChild(getgenv().BleedSettings.TargetPart) or targetChar:FindFirstChild("HumanoidRootPart")
    if not targetPart then return false end
    
    local myChar = LocalPlayer.Character
    if not myChar then return false end
    
    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude
    raycastParams.FilterDescendantsInstances = {myChar, Camera}
    raycastParams.IgnoreWater = true
    
    local origin = Camera.CFrame.Position
    local targetPos = targetPart.Position
    local direction = targetPos - origin
    
    local result = Workspace:Raycast(origin, direction, raycastParams)
    if result then return result.Instance:IsDescendantOf(targetChar) end
    return true
end

-- [[ TARGET LOCK SCANNERS ]]
local function getClosestTargetToCenter()
    if updatingTargetLock then return targetEntity end

    local closestTarget = nil
    local shortestDistance = math.huge
    local viewportCenter = Camera.ViewportSize / 2
    local candidates = {}
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            table.insert(candidates, { Character = player.Character, DisplayName = player.DisplayName, IsPlayer = true, Player = player })
        end
    end
    
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("Model") and obj ~= LocalPlayer.Character then
            if obj:FindFirstChild("HumanoidRootPart") and obj:FindFirstChildOfClass("Humanoid") then
                if not Players:GetPlayerFromCharacter(obj) then
                    table.insert(candidates, { Character = obj, DisplayName = "[BOT] " .. obj.Name, IsPlayer = false })
                end
            end
        end
    end
    
    local priorityName = getgenv().BleedSettings.PriorityTarget
    if priorityName ~= "None" then
        for _, target in ipairs(candidates) do
            if target.IsPlayer and target.DisplayName == priorityName then
                if target.Character and (target.Character:FindFirstChild(getgenv().BleedSettings.TargetPart) or target.Character:FindFirstChild("HumanoidRootPart")) then
                    return target
                end
            end
        end
    end

    for _, target in ipairs(candidates) do
        local part = target.Character:FindFirstChild(getgenv().BleedSettings.TargetPart) or target.Character.HumanoidRootPart
        local screenPos, onScreen = Camera:WorldToViewportPoint(part.Position)
        if onScreen then
            local isVisible = not getgenv().BleedSettings.WallCheck or checkVisibility(target.Character)
            if isVisible then
                local distance = (Vector2.new(screenPos.X, screenPos.Y) - viewportCenter).Magnitude
                if distance < shortestDistance then 
                    shortestDistance = distance 
                    closestTarget = target 
                end
            end
        end
    end
    return closestTarget
end

-- [[ HYBRID PREDICTION & ADAPTIVE RESOLVER LOGIC LAYER ]]
local trackedVelocity = Vector3.new()
local currentTrackedEntity = nil

local function calculatePrediction(targetChar, isPlayer)
    if not targetChar then return nil end
    local corePart = targetChar:FindFirstChild(getgenv().BleedSettings.TargetPart) or targetChar:FindFirstChild("HumanoidRootPart")
    if not corePart then return nil end
    
    local humanoid = targetChar:FindFirstChildOfClass("Humanoid")
    local currentPosition = corePart.Position
    
    if currentTrackedEntity ~= targetChar then
        currentTrackedEntity = targetChar
        trackedVelocity = corePart.AssemblyLinearVelocity or corePart.Velocity or Vector3.new()
    else
        local rawVelocity = corePart.AssemblyLinearVelocity or corePart.Velocity or Vector3.new()
        trackedVelocity = trackedVelocity:Lerp(rawVelocity, 0.22)
    end
    
    local velocity = trackedVelocity
    local scaleX = getgenv().BleedSettings.PredictionX
    local scaleY = getgenv().BleedSettings.PredictionY
    
    if getgenv().BleedSettings.ResolverActive then
        if humanoid and humanoid.MoveDirection.Magnitude > 0 then
            velocity = humanoid.MoveDirection * (humanoid.WalkSpeed or 16)
        else
            velocity = Vector3.new(0, 0, 0)
        end
        
        if math.abs(velocity.Y) > 60 then
            velocity = Vector3.new(velocity.X, 0, velocity.Z)
        end
    end
    
    local PredPos = currentPosition + (velocity * Vector3.new(scaleX, scaleY, scaleX))
    
    if humanoid and (humanoid.FloorMaterial == Enum.Material.Air or humanoid:GetState() == Enum.HumanoidStateType.Freefall or humanoid:GetState() == Enum.HumanoidStateType.Jumping) then
        local jumpOffset = tonumber(getgenv().BleedSettings.JumpOffset) or 0
        local fallOffset = tonumber(getgenv().BleedSettings.FallOffset) or 0
        if velocity.Y > 0 then PredPos = PredPos + Vector3.new(0, jumpOffset, 0) else PredPos = PredPos + Vector3.new(0, fallOffset, 0) end
    end
    
    if getgenv().BleedSettings.AntiGroundShot then
        local raycastParams = RaycastParams.new()
        raycastParams.FilterType = Enum.RaycastFilterType.Exclude
        raycastParams.FilterDescendantsInstances = {targetChar, LocalPlayer.Character, Camera}
        raycastParams.IgnoreWater = true
        
        local rayOrigin = PredPos + Vector3.new(0, 5, 0)
        local rayDirection = Vector3.new(0, -15, 0)
        local raycastResult = Workspace:Raycast(rayOrigin, rayDirection, raycastParams)
        
        if raycastResult then
            local minHeight = getgenv().BleedSettings.MinHeightAboveGround or 2.5
            local floorLevelY = raycastResult.Position.Y
            local currentDeltaFloor = PredPos.Y - floorLevelY
            
            if currentDeltaFloor < minHeight then
                PredPos = Vector3.new(PredPos.X, floorLevelY + minHeight, PredPos.Z)
            end
        end
    end
    
    return PredPos
end

-- [[ HIGH-PERFORMANCE TARGET VISUALIZER ]]
local ESPHolderGui = UIBuilder:Create("ScreenGui", { Parent = UIParent, Name = "UniversalTargetESPHolder" })
local activeESP = nil

local function clearTargetESP()
    if activeESP then activeESP.Container:Destroy() activeESP = nil end
end

local function buildTargetESP(char)
    clearTargetESP()
    local Container = UIBuilder:Create("Folder", {Name = "ActiveTargetStructure", Parent = ESPHolderGui})
    local elements = {
        Container = Container,
        Name = UIBuilder:Create("TextLabel", {Parent = Container, Position = UDim2.new(0.5, 0, 0, -11), Size = UDim2.new(0, 100, 0, 20), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, TextColor3 = getgenv().Colors.TextPrimary, Font = Enum.Font.Code, TextSize = getgenv().ESP.FontSize, TextStrokeTransparency = 0, TextStrokeColor3 = getgenv().Colors.Background, RichText = true}),
        Distance = UIBuilder:Create("TextLabel", {Parent = Container, Position = UDim2.new(0.5, 0, 0, 11), Size = UDim2.new(0, 100, 0, 20), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, TextColor3 = getgenv().Colors.TextPrimary, Font = Enum.Font.Code, TextSize = getgenv().ESP.FontSize, TextStrokeTransparency = 0, TextStrokeColor3 = getgenv().Colors.Background, RichText = true}),
        Weapon = UIBuilder:Create("TextLabel", {Parent = Container, Position = UDim2.new(0.5, 0, 0, 31), Size = UDim2.new(0, 100, 0, 20), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, TextColor3 = getgenv().Colors.TextPrimary, Font = Enum.Font.Code, TextSize = getgenv().ESP.FontSize, TextStrokeTransparency = 0, TextStrokeColor3 = getgenv().Colors.Background, RichText = true}),
        Box = UIBuilder:Create("Frame", {Parent = Container, BackgroundColor3 = getgenv().Colors.Background, BackgroundTransparency = 0.75, BorderSizePixel = 0}),
        Healthbar = UIBuilder:Create("Frame", {Parent = Container, BackgroundColor3 = getgenv().Colors.TextPrimary, BackgroundTransparency = 0}),
        BehindHealthbar = UIBuilder:Create("Frame", {Parent = Container, ZIndex = -1, BackgroundColor3 = getgenv().Colors.Background, BackgroundTransparency = 0}),
        HealthText = UIBuilder:Create("TextLabel", {Parent = Container, Position = UDim2.new(0.5, 0, 0, 31), Size = UDim2.new(0, 100, 0, 20), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, TextColor3 = getgenv().Colors.TextPrimary, Font = Enum.Font.Code, TextSize = getgenv().ESP.FontSize, TextStrokeTransparency = 0, TextStrokeColor3 = getgenv().Colors.Background}),
        Chams = UIBuilder:Create("Highlight", {Parent = Container, FillTransparency = 1, OutlineTransparency = 0, OutlineColor = getgenv().Colors.Accent, DepthMode = "AlwaysOnTop"}),
        WeaponIcon = UIBuilder:Create("ImageLabel", {Parent = Container, BackgroundTransparency = 1, BorderColor3 = getgenv().Colors.Background, BorderSizePixel = 0, Size = UDim2.new(0, 40, 0, 40)}),
        LeftTop = UIBuilder:Create("Frame", {Parent = Container, BackgroundColor3 = getgenv().Colors.Accent, BorderSizePixel = 0}),
        LeftSide = UIBuilder:Create("Frame", {Parent = Container, BackgroundColor3 = getgenv().Colors.Accent, BorderSizePixel = 0}),
        RightTop = UIBuilder:Create("Frame", {Parent = Container, BackgroundColor3 = getgenv().Colors.Accent, BorderSizePixel = 0}),
        RightSide = UIBuilder:Create("Frame", {Parent = Container, BackgroundColor3 = getgenv().Colors.Accent, BorderSizePixel = 0}),
        BottomSide = UIBuilder:Create("Frame", {Parent = Container, BackgroundColor3 = getgenv().Colors.Accent, BorderSizePixel = 0}),
        BottomDown = UIBuilder:Create("Frame", {Parent = Container, BackgroundColor3 = getgenv().Colors.Accent, BorderSizePixel = 0}),
        BottomRightSide = UIBuilder:Create("Frame", {Parent = Container, BackgroundColor3 = getgenv().Colors.Accent, BorderSizePixel = 0}),
        BottomRightDown = UIBuilder:Create("Frame", {Parent = Container, BackgroundColor3 = getgenv().Colors.Accent, BorderSizePixel = 0}),
        Flag1 = UIBuilder:Create("TextLabel", {Parent = Container, Position = UDim2.new(1, 0, 0, 0), Size = UDim2.new(0, 100, 0, 20), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, TextColor3 = getgenv().Colors.TextPrimary, Font = Enum.Font.Code, TextSize = getgenv().ESP.FontSize, TextStrokeTransparency = 0, TextStrokeColor3 = getgenv().Colors.Background}),
        Flag2 = UIBuilder:Create("TextLabel", {Parent = Container, Position = UDim2.new(1, 0, 0, 0), Size = UDim2.new(0, 100, 0, 20), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, TextColor3 = getgenv().Colors.TextPrimary, Font = Enum.Font.Code, TextSize = getgenv().ESP.FontSize, TextStrokeTransparency = 0, TextStrokeColor3 = getgenv().Colors.Background})
    }
    elements.Gradient1 = UIBuilder:Create("UIGradient", {Parent = elements.Box, Enabled = getgenv().ESP.Drawing.Boxes.GradientFill, Color = ColorSequence.new{ColorSequenceKeypoint.new(0, getgenv().ESP.Drawing.Boxes.GradientFillRGB1), ColorSequenceKeypoint.new(1, getgenv().ESP.Drawing.Boxes.GradientFillRGB2)}})
    elements.Outline = UIBuilder:Create("UIStroke", {Parent = elements.Box, Enabled = getgenv().ESP.Drawing.Boxes.Gradient, Transparency = 0, Color = getgenv().Colors.TextPrimary, LineJoinMode = Enum.LineJoinMode.Miter})
    elements.Gradient2 = UIBuilder:Create("UIGradient", {Parent = elements.Outline, Enabled = getgenv().ESP.Drawing.Boxes.Gradient, Color = ColorSequence.new{ColorSequenceKeypoint.new(0, getgenv().ESP.Drawing.Boxes.GradientRGB1), ColorSequenceKeypoint.new(1, getgenv().ESP.Drawing.Boxes.GradientRGB2)}})
    elements.HealthbarGradient = UIBuilder:Create("UIGradient", {Parent = elements.Healthbar, Enabled = getgenv().ESP.Drawing.Healthbar.Gradient, Rotation = -90, Color = ColorSequence.new{ColorSequenceKeypoint.new(0, getgenv().ESP.Drawing.Healthbar.GradientRGB1), ColorSequenceKeypoint.new(0.5, getgenv().ESP.Drawing.Healthbar.GradientRGB2), ColorSequenceKeypoint.new(1, getgenv().ESP.Drawing.Healthbar.GradientRGB3)}})
    elements.Gradient3 = UIBuilder:Create("UIGradient", {Parent = elements.WeaponIcon, Rotation = -90, Enabled = getgenv().ESP.Drawing.Weapons.Gradient, Color = ColorSequence.new{ColorSequenceKeypoint.new(0, getgenv().ESP.Drawing.Weapons.GradientRGB1), ColorSequenceKeypoint.new(1, getgenv().ESP.Drawing.Weapons.GradientRGB2)}})
    activeESP = elements
end

local function hideActiveElements()
    if not activeESP then return end local ae = activeESP
    ae.Box.Visible = false; ae.Name.Visible = false; ae.Distance.Visible = false; ae.Weapon.Visible = false; ae.Healthbar.Visible = false; ae.BehindHealthbar.Visible = false; ae.HealthText.Visible = false; ae.WeaponIcon.Visible = false; ae.LeftTop.Visible = false; ae.LeftSide.Visible = false; ae.BottomSide.Visible = false; ae.BottomDown.Visible = false; ae.RightTop.Visible = false; ae.RightSide.Visible = false; ae.BottomRightSide.Visible = false; ae.BottomRightDown.Visible = false; ae.Flag1.Visible = false; ae.Chams.Enabled = false; ae.Flag2.Visible = false
end

-- [[ OBSIDIAN INTERFACE BUILD COMPILATION ]]

-- TABS
local AimbotTab = Window:CreateTab("Aimbot / Engine")
local VisualsTab = Window:CreateTab("Visuals / Target ESP")
local AudioTab = Window:CreateTab("Audio Settings")

-- AIMBOT TAB COMPONENTS
AimbotTab:CreateToggle("Master Target Lock", false, function(state)
    if updatingTargetLock then return end
    isLocked = state
    if isLocked then
        targetEntity = getClosestTargetToCenter()
        if targetEntity then
            sendNotification("Locked on " .. targetEntity.DisplayName)
            playHitSound("Blood Burst") 
        else
            isLocked = false
            sendNotification("No visible target")
        end
    else
        if targetEntity then sendNotification("Speared " .. targetEntity.DisplayName) end
        targetEntity = nil 
        clearTargetESP()
    end
end)

AimbotTab:CreateToggle("Auto Prediction Mode", false, function(state)
    AutoPredActive = state
end)

AimbotTab:CreateToggle("Wall Check Filter", false, function(state)
    getgenv().BleedSettings.WallCheck = state
end)

AimbotTab:CreateToggle("Resolver Optimization", true, function(state)
    getgenv().BleedSettings.ResolverActive = state
end)

AimbotTab:CreateToggle("Anti Ground Shot Routing", true, function(state)
    getgenv().BleedSettings.AntiGroundShot = state
end)

XInputBoxRef = AimbotTab:CreateTextBox("Prediction Core X", tostring(getgenv().BleedSettings.PredictionX), function(text)
    if not AutoPredActive then
        local value = tonumber(text)
        if value then getgenv().BleedSettings.PredictionX = value end
    end
end)

YInputBoxRef = AimbotTab:CreateTextBox("Prediction Core Y", tostring(getgenv().BleedSettings.PredictionY), function(text)
    if not AutoPredActive then
        local value = tonumber(text)
        if value then getgenv().BleedSettings.PredictionY = value end
    end
end)

AimbotTab:CreateDropdown("Target Objective Part", componentsList, function(selected)
    getgenv().BleedSettings.TargetPart = selected
end)

-- Priority target parsing array builder wrapper
local playerDisplayNamesPool = retrievePlayerPool()
AimbotTab:CreateDropdown("Priority Target Profile", playerDisplayNamesPool, function(selected)
    updatingTargetLock = true
    getgenv().BleedSettings.PriorityTarget = selected
    
    if isLocked then
        local verifiedTarget = nil
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.DisplayName == selected then
                verifiedTarget = { Character = p.Character, DisplayName = p.DisplayName, IsPlayer = true, Player = p }
                break
            end
        end
        if verifiedTarget then
            targetEntity = verifiedTarget
        else
            targetEntity = nil 
            isLocked = false
        end
    end
    updatingTargetLock = false
end)

-- VISUALS TAB COMPONENTS
VisualsTab:CreateToggle("Target ESP Master Overlay", false, function(state)
    getgenv().ESP.Enabled = state
    if not state then clearTargetESP() end
end)

VisualsTab:CreateSlider("ESP Render Max Distance", 100, 2500, 500, function(value)
    getgenv().ESP.MaxDistance = value
end)

VisualsTab:CreateToggle("Draw Thermal Chams", true, function(state)
    getgenv().ESP.Drawing.Chams.Enabled = state
end)

VisualsTab:CreateToggle("Render Bounding Box Profiles", true, function(state)
    getgenv().ESP.Drawing.Boxes.Full.Enabled = state
end)

VisualsTab:CreateToggle("Corner Box Profiles Accent", true, function(state)
    getgenv().ESP.Drawing.Boxes.Corner.Enabled = state
end)

VisualsTab:CreateToggle("Animate Box Gradients", true, function(state)
    getgenv().ESP.Drawing.Boxes.Animate = state
end)

VisualsTab:CreateToggle("Render Scaled Healthbars", true, function(state)
    getgenv().ESP.Drawing.Healthbar.Enabled = state
end)

VisualsTab:CreateToggle("Render Text Health Percentages", true, function(state)
    getgenv().ESP.Drawing.Healthbar.HealthText = state
end)

VisualsTab:CreateToggle("Display Objective Identification Tags", true, function(state)
    getgenv().ESP.Drawing.Names.Enabled = state
end)

-- AUDIO TAB COMPONENTS
local soundKeysList = {}
for name, _ in pairs(hitsounds) do table.insert(soundKeysList, name) end
table.sort(soundKeysList)

AudioTab:CreateDropdown("Active Sound Registry Output", soundKeysList, function(selectedSound)
    playHitSound(selectedSound)
    sendNotification("Audited Audio: " .. selectedSound)
end)


-- [[ MASTER SYSTEM LOOP INTERPOLATION ENGINE ]]
local RotationAngle, Tick = -45, tick()

RunService.RenderStepped:Connect(function()
    if isLocked and targetEntity and not updatingTargetLock then
        if targetEntity.IsPlayer and targetEntity.Player then
            if not targetEntity.Player.Parent then
                isLocked = false targetEntity = nil clearTargetESP()
                sendNotification("Target missing framework context extraction complete")
                return
            end
            targetEntity.Character = targetEntity.Player.Character
        end

        local char = targetEntity.Character
        local corePart = char and (char:FindFirstChild(getgenv().BleedSettings.TargetPart) or char:FindFirstChild("HumanoidRootPart"))
        local humanoid = char and char:FindFirstChildOfClass("Humanoid")
        
        if not char or not char.Parent or not corePart or (humanoid and humanoid.Health <= 0) then
            hideActiveElements() return
        end
        
        local isStillVisible = not getgenv().BleedSettings.WallCheck or checkVisibility(char)
        if isStillVisible then
            local targetPosition = calculatePrediction(char, targetEntity.IsPlayer)
            if targetPosition then Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, targetPosition) end
        end
        
        if getgenv().ESP.Enabled then
            if not activeESP then buildTargetESP(char) end
            local Pos, OnScreen = Camera:WorldToScreenPoint(corePart.Position)
            local Dist = (Camera.CFrame.Position - corePart.Position).Magnitude / 3.5714
            
            if OnScreen and Dist <= getgenv().ESP.MaxDistance then
                local ae = activeESP
                local scaleFactor = (corePart.Size.Y * Camera.ViewportSize.Y) / (Pos.Z * 2)
                local w, h = 3 * scaleFactor, 4.5 * scaleFactor
                
                if getgenv().ESP.FadeOut.OnDistance then
                    UIBuilder:FadeOutOnDist(ae.Box, Dist); UIBuilder:FadeOutOnDist(ae.Outline, Dist); UIBuilder:FadeOutOnDist(ae.Name, Dist); UIBuilder:FadeOutOnDist(ae.Distance, Dist); UIBuilder:FadeOutOnDist(ae.Weapon, Dist); UIBuilder:FadeOutOnDist(ae.Healthbar, Dist); UIBuilder:FadeOutOnDist(ae.BehindHealthbar, Dist); UIBuilder:FadeOutOnDist(ae.HealthText, Dist); UIBuilder:FadeOutOnDist(ae.WeaponIcon, Dist); UIBuilder:FadeOutOnDist(ae.LeftTop, Dist); UIBuilder:FadeOutOnDist(ae.LeftSide, Dist); UIBuilder:FadeOutOnDist(ae.BottomSide, Dist); UIBuilder:FadeOutOnDist(ae.BottomDown, Dist); UIBuilder:FadeOutOnDist(ae.RightTop, Dist); UIBuilder:FadeOutOnDist(ae.RightSide, Dist); UIBuilder:FadeOutOnDist(ae.BottomRightSide, Dist); UIBuilder:FadeOutOnDist(ae.BottomRightDown, Dist); UIBuilder:FadeOutOnDist(ae.Chams, Dist); UIBuilder:FadeOutOnDist(ae.Flag1, Dist); UIBuilder:FadeOutOnDist(ae.Flag2, Dist)
                end
                
                ae.Chams.Adornee = char; ae.Chams.Enabled = getgenv().ESP.Drawing.Chams.Enabled; ae.Chams.FillColor = getgenv().ESP.Drawing.Chams.FillRGB; ae.Chams.OutlineColor = getgenv().ESP.Drawing.Chams.OutlineRGB
                if getgenv().ESP.Drawing.Chams.Thermal then
                    local breathe_effect = math.atan(math.sin(tick() * 2)) * 2 / math.pi
                    ae.Chams.FillTransparency = getgenv().ESP.Drawing.Chams.Fill_Transparency * breathe_effect * 0.01; ae.Chams.OutlineTransparency = getgenv().ESP.Drawing.Chams.Outline_Transparency * breathe_effect * 0.01
                end
                ae.Chams.DepthMode = getgenv().ESP.Drawing.Chams.VisibleCheck and Enum.HighlightDepthMode.Occluded or Enum.HighlightDepthMode.AlwaysOnTop
                
                ae.LeftTop.Visible = getgenv().ESP.Drawing.Boxes.Corner.Enabled; ae.LeftTop.Position = UDim2.new(0, Pos.X - w / 2, 0, Pos.Y - h / 2); ae.LeftTop.Size = UDim2.new(0, w / 5, 0, 1)
                ae.LeftSide.Visible = getgenv().ESP.Drawing.Boxes.Corner.Enabled; ae.LeftSide.Position = UDim2.new(0, Pos.X - w / 2, 0, Pos.Y - h / 2); ae.LeftSide.Size = UDim2.new(0, 1, 0, h / 5)
                ae.BottomSide.Visible = getgenv().ESP.Drawing.Boxes.Corner.Enabled; ae.BottomSide.Position = UDim2.new(0, Pos.X - w / 2, 0, Pos.Y + h / 2); ae.BottomSide.Size = UDim2.new(0, 1, 0, h / 5); ae.BottomSide.AnchorPoint = Vector2.new(0, 1)
                ae.BottomDown.Visible = getgenv().ESP.Drawing.Boxes.Corner.Enabled; ae.BottomDown.Position = UDim2.new(0, Pos.X - w / 2, 0, Pos.Y + h / 2); ae.BottomDown.Size = UDim2.new(0, w / 5, 0, 1); ae.BottomDown.AnchorPoint = Vector2.new(0, 1)
                ae.RightTop.Visible = getgenv().ESP.Drawing.Boxes.Corner.Enabled; ae.RightTop.Position = UDim2.new(0, Pos.X + w / 2, 0, Pos.Y - h / 2); ae.RightTop.Size = UDim2.new(0, w / 5, 0, 1); ae.RightTop.AnchorPoint = Vector2.new(1, 0)
                ae.RightSide.Visible = getgenv().ESP.Drawing.Boxes.Corner.Enabled; ae.RightSide.Position = UDim2.new(0, Pos.X + w / 2 - 1, 0, Pos.Y - h / 2); ae.RightSide.Size = UDim2.new(0, 1, 0, h / 5); ae.RightSide.AnchorPoint = Vector2.new(0, 0)
                ae.BottomRightSide.Visible = getgenv().ESP.Drawing.Boxes.Corner.Enabled; ae.BottomRightSide.Position = UDim2.new(0, Pos.X + w / 2, 0, Pos.Y + h / 2); ae.BottomRightSide.Size = UDim2.new(0, 1, 0, h / 5); ae.BottomRightSide.AnchorPoint = Vector2.new(1, 1)
                ae.BottomRightDown.Visible = getgenv().ESP.Drawing.Boxes.Corner.Enabled; ae.BottomRightDown.Position = UDim2.new(0, Pos.X + w / 2, 0, Pos.Y + h / 2); ae.BottomRightDown.Size = UDim2.new(0, w / 5, 0, 1); ae.BottomRightDown.AnchorPoint = Vector2.new(1, 1)                                                            

                ae.Box.Position = UDim2.new(0, Pos.X - w / 2, 0, Pos.Y - h / 2); ae.Box.Size = UDim2.new(0, w, 0, h); ae.Box.Visible = getgenv().ESP.Drawing.Boxes.Full.Enabled
                if getgenv().ESP.Drawing.Boxes.Filled.Enabled then ae.Box.BackgroundColor3 = Color3.fromRGB(255, 255, 255) ae.Box.BackgroundTransparency = getgenv().ESP.Drawing.Boxes.GradientFill and getgenv().ESP.Drawing.Boxes.Filled.Transparency or 1 ae.Box.BorderSizePixel = 1 else ae.Box.BackgroundTransparency = 1 end

                RotationAngle = RotationAngle + (tick() - Tick) * getgenv().ESP.Drawing.Boxes.RotationSpeed * math.cos(math.pi / 4 * tick() - math.pi / 2)
                if getgenv().ESP.Drawing.Boxes.Animate then ae.Gradient1.Rotation = RotationAngle ae.Gradient2.Rotation = RotationAngle else ae.Gradient1.Rotation = -45 ae.Gradient2.Rotation = -45 end
                Tick = tick()

                local health = humanoid and (humanoid.Health / humanoid.MaxHealth) or 1
                ae.Healthbar.Position = UDim2.new(0, Pos.X - w / 2 - 6, 0, Pos.Y - h / 2 + h * (1 - health)); ae.Healthbar.Size = UDim2.new(0, getgenv().ESP.Drawing.Healthbar.Width, 0, h * health); ae.Healthbar.Visible = getgenv().ESP.Drawing.Healthbar.Enabled
                ae.BehindHealthbar.Position = UDim2.new(0, Pos.X - w / 2 - 6, 0, Pos.Y - h / 2); ae.BehindHealthbar.Size = UDim2.new(0, getgenv().ESP.Drawing.Healthbar.Width, 0, h); ae.BehindHealthbar.Visible = getgenv().ESP.Drawing.Healthbar.Enabled

                if getgenv().ESP.Drawing.Healthbar.HealthText and humanoid then
                    local healthPercentage = math.floor(health * 100)
                    ae.HealthText.Position = UDim2.new(0, Pos.X - w / 2 - 6, 0, Pos.Y - h / 2 + h * (1 - healthPercentage / 100) + 3)
                    ae.HealthText.Text = tostring(healthPercentage)
                    ae.HealthText.Visible = humanoid.Health < humanoid.MaxHealth
                    ae.HealthText.TextColor3 = getgenv().ESP.Drawing.Healthbar.HealthTextRGB
                else ae.HealthText.Visible = false end                        

                ae.Name.Visible = getgenv().ESP.Drawing.Names.Enabled
                local identityTag, tagColor = "P", "rgb(255,0,40)"
                if targetEntity.IsPlayer then
                    local playerInstance = Players:GetPlayerFromCharacter(char)
                    if playerInstance and getgenv().ESP.Options.Friendcheck and LocalPlayer:IsFriendsWith(playerInstance.UserId) then identityTag = "F" tagColor = "rgb(0,255,0)" end
                else identityTag = "B" tagColor = "rgb(200,160,255)" end
                
                if getgenv().ESP.Drawing.Distances.Position == "Bottom" then
                    ae.Weapon.Position = UDim2.new(0, Pos.X, 0, Pos.Y + h / 2 + 18); ae.WeaponIcon.Position = UDim2.new(0, Pos.X - 21, 0, Pos.Y + h / 2 + 15)
                    ae.Distance.Position = UDim2.new(0, Pos.X, 0, Pos.Y + h / 2 + 7); ae.Distance.Text = string.format("%d meters", math.floor(Dist)); ae.Distance.Visible = true
                    ae.Name.Text = string.format('(<font color="%s">%s</font>) %s', tagColor, identityTag, targetEntity.DisplayName)
                elseif getgenv().ESP.Drawing.Distances.Position == "Text" then
                    ae.Weapon.Position = UDim2.new(0, Pos.X, 0, Pos.Y + h / 2 + 8); ae.WeaponIcon.Position = UDim2.new(0, Pos.X - 21, 0, Pos.Y + h / 2 + 5); ae.Distance.Visible = false
                    ae.Name.Text = string.format('(<font color="%s">%s</font>) %s [%d]', tagColor, identityTag, targetEntity.DisplayName, math.floor(Dist))
                end
                ae.Weapon.Text = "none" ae.Weapon.Visible = getgenv().ESP.Drawing.Weapons.Enabled
            else hideActiveElements() end
        else hideActiveElements() end
    else clearTargetESP() end
end)

-- [[ METATABLE MOUNT CONTROLLER ]]
local rawMetatable = getrawmetatable(game)
local originalIndex = rawMetatable.__index
setreadonly(rawMetatable, false)

rawMetatable.__index = newcclosure(function(self, index)
    if not checkcaller() and isLocked and targetEntity and targetEntity.Character and not updatingTargetLock then
        local char = targetEntity.Character
        local hitPart = char:FindFirstChild(getgenv().BleedSettings.TargetPart) or char:FindFirstChild("HumanoidRootPart")
        if hitPart and (index == "Hit" or index == "Target") then
            local predictedPos = calculatePrediction(char, targetEntity.IsPlayer)
            if predictedPos then
                if index == "Hit" then return CFrame.new(predictedPos) elseif index == "Target" then return hitPart end
            end
        end
    end
    return originalIndex(self, index)
end)
setreadonly(rawMetatable, true)
