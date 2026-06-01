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
    WallCheck = true,          
    PriorityPlayer = nil,      
    HitPart = "HumanoidRootPart", 
    HitChance = 100,           
    ResolverActive = true,
    AntiGroundShot = true,
    JumpOffset = 0,            
    FallOffset = 0
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

-- [[ HELPER INTERFACE GENERATION ENGINE ]]
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

-- [[ OBJECT HITPART COMPOSITION RESOLVER ]]
local function getHitPart(char)
    if not char then return nil end
    local selected = getgenv().BleedSettings.HitPart or "HumanoidRootPart"
    
    if selected == "Random" then
        local parts = {}
        for _, partName in ipairs({"Head", "UpperTorso", "Torso", "LowerTorso", "HumanoidRootPart"}) do
            local found = char:FindFirstChild(partName)
            if found then table.insert(parts, found) end
        end
        if #parts > 0 then return parts[math.random(1, #parts)] end
    elseif selected == "Torso" then
        local torso = char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")
        if torso then return torso end
    else
        local part = char:FindFirstChild(selected)
        if part then return part end
    end
    return char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Head") or char:FindFirstChildOfClass("Part")
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

-- [[ INTERFACE INITIALIZATION ]]
local ScreenGui = UIBuilder:Create("ScreenGui", { Name = "BleedLockGui", ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling, Parent = UIParent })
local ButtonFrame = UIBuilder:Create("Frame", { Name = "ButtonFrame", Size = UDim2.new(0, 190, 0, 60), Position = UDim2.new(0.5, -95, 0.75, -30), BackgroundColor3 = getgenv().Colors.Background, BorderSizePixel = 0, ClipsDescendants = true, Active = true, Parent = ScreenGui })
local UIStroke = UIBuilder:Create("UIStroke", { Color = getgenv().Colors.Accent, Thickness = 1, ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Parent = ButtonFrame })

-- Re-engineered Rain and Blood Layer
local RainContainer = UIBuilder:Create("Frame", { Name = "RainContainer", Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, ClipsDescendants = true, ZIndex = 1, Parent = ButtonFrame })
local TextButton = UIBuilder:Create("TextButton", { Name = "TextButton", Size = UDim2.new(1, -12, 1, -12), Position = UDim2.new(0, 6, 0, 6), BackgroundTransparency = 1, Text = "Bleed.cc", TextColor3 = getgenv().Colors.TextPrimary, Font = Enum.Font.Code, TextSize = 17, ZIndex = 3, Parent = ButtonFrame })
local NotificationContainer = UIBuilder:Create("Frame", { Name = "NotificationContainer", Size = UDim2.new(0, 180, 0, 600), Position = UDim2.new(1, -195, 0, 20), BackgroundTransparency = 1, Parent = ScreenGui })
local UIListLayout = UIBuilder:Create("UIListLayout", { Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Top, Parent = NotificationContainer })

-- [[ RETRIEVED DYNAMIC ATMOSPHERIC & FLUID DYNAMICS ENGINE ]]
task.spawn(function()
    while task.wait(0.04) do
        if not ButtonFrame or not ButtonFrame.Parent then break end
        
        local dropType = math.random(1, 4)
        local pDrop = Instance.new("Frame")
        pDrop.BorderSizePixel = 0
        pDrop.ZIndex = 2
        pDrop.Parent = RainContainer
        
        local initialX = math.random(0, 100) / 100
        local speed = math.random(4, 8) / 10
        
        if dropType == 1 then
            -- Elongating Dynamic Blood Drip
            pDrop.Name = "BloodDrip"
            pDrop.Size = UDim2.new(0, math.random(2, 3), 0, 2)
            pDrop.BackgroundColor3 = Color3.fromRGB(140, 0, 5)
            pDrop.Position = UDim2.new(initialX, 0, -0.1, 0)
            
            -- Stretching effect as it runs down
            TweenService:Create(pDrop, TweenInfo.new(speed, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
                Position = UDim2.new(initialX + (math.random(-3, 3)/100), 0, 0.92, 0),
                Size = UDim2.new(0, math.random(1, 2), 0, math.random(14, 24)),
                BackgroundTransparency = 0.1
            }):Play()
            
            -- Fluid Pooling Mechanics upon hitting the bottom layer
            task.delay(speed, function()
                if pDrop and pDrop.Parent then
                    pDrop.AnchorPoint = Vector2.new(0.5, 1)
                    TweenService:Create(pDrop, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Size = UDim2.new(0, math.random(8, 14), 0, math.random(2, 4)),
                        BackgroundColor3 = Color3.fromRGB(90, 0, 2),
                        BackgroundTransparency = 0.4
                    }):Play()
                    Debris:AddItem(pDrop, 0.25)
                end
            end)
            
        elseif dropType == 2 then
            -- High-Velocity Atmospheric Rain Streak
            pDrop.Name = "RainStreak"
            pDrop.Size = UDim2.new(0, 1, 0, math.random(15, 26))
            pDrop.BackgroundColor3 = Color3.fromRGB(220, 225, 235)
            pDrop.BackgroundTransparency = math.random(6, 8) / 10
            pDrop.Position = UDim2.new(initialX, 0, -0.2, 0)
            
            TweenService:Create(pDrop, TweenInfo.new(speed * 0.5, Enum.EasingStyle.Linear), {
                Position = UDim2.new(initialX + 0.08, 0, 1.2, 0)
            }):Play()
            Debris:AddItem(pDrop, speed * 0.5)
            
        elseif dropType == 3 then
            -- Micro Splatter Impact Particle
            pDrop.Name = "Splatter"
            pDrop.Size = UDim2.new(0, math.random(2, 4), 0, math.random(2, 4))
            pDrop.BackgroundColor3 = Color3.fromRGB(175, 0, 12)
            pDrop.Position = UDim2.new(initialX, 0, math.random(10, 90) / 100, 0)
            pDrop.BackgroundTransparency = 0.2
            
            local burstX = (math.random(-25, 25) / 100)
            local burstY = (math.random(-25, 25) / 100)
            
            TweenService:Create(pDrop, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Position = UDim2.new(pDrop.Position.X.Scale + burstX, 0, pDrop.Position.Y.Scale + burstY, 0),
                BackgroundTransparency = 1,
                Size = UDim2.new(0, 1, 0, 1)
            }):Play()
            Debris:AddItem(pDrop, 0.4)
        else
            pDrop:Destroy()
        end
    end
end)

-- [[ SORTED & CLEAN PREDICTION CONFIGURATION PANEL ]]
local normalPanelSize = UDim2.new(0, 190, 0, 205) 
local retractedPanelSize = UDim2.new(0, 190, 0, 0) 
local dropdownExpandedHeight = 84
local hitPartDropdownExpandedHeight = 94
local isDropdownOpen = false
local isHitPartDropdownOpen = false
local uiIsExpanded = false

local function getTargetPanelSize()
    if not uiIsExpanded then return retractedPanelSize end
    local baseline = 205
    if isHitPartDropdownOpen then baseline = baseline + hitPartDropdownExpandedHeight end
    if isDropdownOpen then baseline = baseline + dropdownExpandedHeight end
    return UDim2.new(0, 190, 0, baseline)
end

local PredictionPanel = UIBuilder:Create("Frame", { Name = "PredictionPanel", Size = retractedPanelSize, Position = ButtonFrame.Position, BackgroundColor3 = Color3.fromRGB(115, 0, 5), BackgroundTransparency = 0.5, BorderSizePixel = 0, ZIndex = ButtonFrame.ZIndex - 1, Visible = false, ClipsDescendants = true, Parent = ScreenGui })
local PanelCorner = UIBuilder:Create("UICorner", { CornerRadius = UDim.new(0, 8), Parent = PredictionPanel })
local PanelLayout = UIBuilder:Create("UIListLayout", { Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder, HorizontalAlignment = Enum.HorizontalAlignment.Center, VerticalAlignment = Enum.VerticalAlignment.Center, Parent = PredictionPanel })

local AutoPredActive = false

-- Category Order Layout Registry 
-- [1] AUTOMATION LAYER
local AutoPredToggle = UIBuilder:Create("TextButton", { Name = "AutoPredToggle", Size = UDim2.new(0.9, 0, 0, 22), BackgroundColor3 = Color3.fromRGB(115, 20, 25), Text = "Auto Prediction: OFF", TextColor3 = Color3.fromRGB(255, 255, 255), Font = Enum.Font.Code, TextSize = 11, LayoutOrder = 1, Parent = PredictionPanel })
UIBuilder:Create("UICorner", { CornerRadius = UDim.new(0, 5), Parent = AutoPredToggle })

-- [2] CALIBRATION INPUT LAYER
local InputsContainer = UIBuilder:Create("Frame", { Name = "InputsContainer", Size = UDim2.new(0.9, 0, 0, 22), BackgroundTransparency = 1, LayoutOrder = 2, Parent = PredictionPanel })
UIBuilder:Create("UIListLayout", { Padding = UDim.new(0, 5), FillDirection = Enum.FillDirection.Horizontal, SortOrder = Enum.SortOrder.LayoutOrder, HorizontalAlignment = Enum.HorizontalAlignment.Center, Parent = InputsContainer })

local XInput = UIBuilder:Create("TextBox", { Name = "XInput", Size = UDim2.new(0.48, -2, 1, 0), BackgroundColor3 = Color3.fromRGB(25, 25, 25), Text = tostring(getgenv().BleedSettings.PredictionX), PlaceholderText = "X Pred", TextColor3 = Color3.fromRGB(255, 255, 255), Font = Enum.Font.Code, TextSize = 11, LayoutOrder = 1, Parent = InputsContainer })
UIBuilder:Create("UICorner", { CornerRadius = UDim.new(0, 4), Parent = XInput })

local YInput = UIBuilder:Create("TextBox", { Name = "YInput", Size = UDim2.new(0.48, -2, 1, 0), BackgroundColor3 = Color3.fromRGB(25, 25, 25), Text = tostring(getgenv().BleedSettings.PredictionY), PlaceholderText = "Y Pred", TextColor3 = Color3.fromRGB(255, 255, 255), Font = Enum.Font.Code, TextSize = 11, LayoutOrder = 2, Parent = InputsContainer })
UIBuilder:Create("UICorner", { CornerRadius = UDim.new(0, 4), Parent = YInput })

-- [3] PROBABILISTIC SLIDER LAYER
local SliderContainer = UIBuilder:Create("Frame", { Name = "SliderContainer", Size = UDim2.new(0.9, 0, 0, 32), BackgroundTransparency = 1, LayoutOrder = 3, Parent = PredictionPanel })
local SliderLabel = UIBuilder:Create("TextLabel", { Size = UDim2.new(1, 0, 0, 14), BackgroundTransparency = 1, Text = "Hit Chance: " .. getgenv().BleedSettings.HitChance .. "%", TextColor3 = Color3.fromRGB(255, 255, 255), Font = Enum.Font.Code, TextSize = 10, TextXAlignment = Enum.TextXAlignment.Left, Parent = SliderContainer })
local SliderTrack = UIBuilder:Create("TextButton", { Size = UDim2.new(1, 0, 0, 8), Position = UDim2.new(0, 0, 0, 18), BackgroundColor3 = Color3.fromRGB(25, 25, 25), Text = "", AutoButtonColor = false, Parent = SliderContainer })
UIBuilder:Create("UICorner", { CornerRadius = UDim.new(0, 3), Parent = SliderTrack })
local SliderFill = UIBuilder:Create("Frame", { Size = UDim2.new(getgenv().BleedSettings.HitChance / 100, 0, 1, 0), BackgroundColor3 = getgenv().Colors.Accent, BorderSizePixel = 0, Parent = SliderTrack })
UIBuilder:Create("UICorner", { CornerRadius = UDim.new(0, 3), Parent = SliderFill })

local holdingSlider = false
local function handleSliderProcessing(input)
    local totalWidth = SliderTrack.AbsoluteSize.X
    if totalWidth <= 0 then return end
    local relativeX = input.Position.X - SliderTrack.AbsolutePosition.X
    local percent = math.clamp(relativeX / totalWidth, 0, 1)
    local probability = math.round(percent * 99) + 1 
    
    getgenv().BleedSettings.HitChance = probability
    SliderLabel.Text = "Hit Chance: " .. probability .. "%"
    SliderFill.Size = UDim2.new(percent, 0, 1, 0)
end

SliderTrack.InputBegan:Connect(function(input)
    if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
        holdingSlider = true
        handleSliderProcessing(input)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if holdingSlider and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        handleSliderProcessing(input)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
        holdingSlider = false
    end
end)

-- [4] SKELETAL TARGET SELECTION LAYER
local HitPartHeader = UIBuilder:Create("TextButton", { Name = "HitPartHeader", Size = UDim2.new(0.9, 0, 0, 22), BackgroundColor3 = Color3.fromRGB(25, 25, 25), Text = "Hitpart: " .. getgenv().BleedSettings.HitPart, TextColor3 = Color3.fromRGB(255, 255, 255), Font = Enum.Font.Code, TextSize = 11, LayoutOrder = 4, Parent = PredictionPanel })
UIBuilder:Create("UICorner", { CornerRadius = UDim.new(0, 5), Parent = HitPartHeader })

local HitPartScroll = UIBuilder:Create("ScrollingFrame", { Name = "HitPartScroll", Size = UDim2.new(0.9, 0, 0, 0), BackgroundColor3 = Color3.fromRGB(15, 15, 15), BackgroundTransparency = 0.15, CanvasSize = UDim2.new(0, 0, 0, 0), ScrollBarThickness = 4, Visible = false, LayoutOrder = 5, Parent = PredictionPanel })
UIBuilder:Create("UICorner", { CornerRadius = UDim.new(0, 5), Parent = HitPartScroll })
local HitPartLayout = UIBuilder:Create("UIListLayout", { Padding = UDim.new(0, 3), SortOrder = Enum.SortOrder.LayoutOrder, HorizontalAlignment = Enum.HorizontalAlignment.Center, Parent = HitPartScroll })

-- [5] TARGET PRIORITY ASSIGNMENT LAYER
local DropdownHeader = UIBuilder:Create("TextButton", { Name = "DropdownHeader", Size = UDim2.new(0.9, 0, 0, 22), BackgroundColor3 = Color3.fromRGB(25, 25, 25), Text = "Priority: None", TextColor3 = Color3.fromRGB(255, 255, 255), Font = Enum.Font.Code, TextSize = 11, LayoutOrder = 6, Parent = PredictionPanel })
UIBuilder:Create("UICorner", { CornerRadius = UDim.new(0, 5), Parent = DropdownHeader })

local DropdownScroll = UIBuilder:Create("ScrollingFrame", { Name = "DropdownScroll", Size = UDim2.new(0.9, 0, 0, 0), BackgroundColor3 = Color3.fromRGB(15, 15, 15), BackgroundTransparency = 0.15, CanvasSize = UDim2.new(0, 0, 0, 0), ScrollBarThickness = 4, Visible = false, LayoutOrder = 7, Parent = PredictionPanel })
UIBuilder:Create("UICorner", { CornerRadius = UDim.new(0, 5), Parent = DropdownScroll })
local DropdownLayout = UIBuilder:Create("UIListLayout", { Padding = UDim.new(0, 3), SortOrder = Enum.SortOrder.LayoutOrder, HorizontalAlignment = Enum.HorizontalAlignment.Center, Parent = DropdownScroll })

-- [6] SECURITY & VERIFICATION LAYER
local WallCheckToggle = UIBuilder:Create("TextButton", { Name = "WallCheckToggle", Size = UDim2.new(0.9, 0, 0, 22), BackgroundColor3 = getgenv().BleedSettings.WallCheck and Color3.fromRGB(40, 150, 45) or Color3.fromRGB(115, 20, 25), Text = "Wall Check: " .. (getgenv().BleedSettings.WallCheck and "ON" or "OFF"), TextColor3 = Color3.fromRGB(255, 255, 255), Font = Enum.Font.Code, TextSize = 11, LayoutOrder = 8, Parent = PredictionPanel })
UIBuilder:Create("UICorner", { CornerRadius = UDim.new(0, 5), Parent = WallCheckToggle })

-- [7] VISUALIZATION ENVIRONMENT LAYER
local VisualizerToggle = UIBuilder:Create("TextButton", { Name = "VisualizerToggle", Size = UDim2.new(0.9, 0, 0, 22), BackgroundColor3 = getgenv().ESP.Enabled and Color3.fromRGB(40, 150, 45) or Color3.fromRGB(115, 20, 25), Text = "Visualizer ESP: " .. (getgenv().ESP.Enabled and "ON" or "OFF"), TextColor3 = Color3.fromRGB(255, 255, 255), Font = Enum.Font.Code, TextSize = 11, LayoutOrder = 9, Parent = PredictionPanel })
UIBuilder:Create("UICorner", { CornerRadius = UDim.new(0, 5), Parent = VisualizerToggle })

local ArrowCircle = UIBuilder:Create("TextButton", { Name = "ArrowCircle", Size = UDim2.new(0, 18, 0, 18), BackgroundColor3 = getgenv().Colors.Background, Text = "▼", TextColor3 = getgenv().Colors.TextPrimary, Font = Enum.Font.Code, TextSize = 10, ZIndex = ButtonFrame.ZIndex + 4, Parent = ScreenGui })
UIBuilder:Create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = ArrowCircle })
local CircleStroke = UIBuilder:Create("UIStroke", { Color = getgenv().Colors.Accent, Thickness = 1, Parent = ArrowCircle })

local currentPanelOffset = UDim2.new(0, 0, 0, 0)
local targetPanelOffset = UDim2.new(0, 0, 0, 0)

local activeESP = nil
local function clearTargetESP()
    if activeESP then activeESP.Container:Destroy() activeESP = nil end
end

-- Skeletal options including customized bones
local hitpartOptions = {"Head", "UpperTorso", "Torso", "LowerTorso", "HumanoidRootPart", "Random"}
HitPartScroll.CanvasSize = UDim2.new(0, 0, 0, #hitpartOptions * 21)
for _, partName in ipairs(hitpartOptions) do
    local partBtn = UIBuilder:Create("TextButton", { Name = partName .. "_Choice", Size = UDim2.new(0.95, 0, 0, 18), BackgroundColor3 = Color3.fromRGB(45, 45, 45), Text = partName, TextColor3 = Color3.fromRGB(255, 255, 255), Font = Enum.Font.Code, TextSize = 10, Parent = HitPartScroll })
    UIBuilder:Create("UICorner", { CornerRadius = UDim.new(0, 3), Parent = partBtn })
    
    partBtn.MouseButton1Click:Connect(function()
        getgenv().BleedSettings.HitPart = partName
        HitPartHeader.Text = "Hitpart: " .. partName
        isHitPartDropdownOpen = false
        TweenService:Create(HitPartScroll, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0.9, 0, 0, 0)}):Play()
        task.delay(0.2, function() if not isHitPartDropdownOpen then HitPartScroll.Visible = false end end)
        TweenService:Create(PredictionPanel, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = getTargetPanelSize()}):Play()
    end)
end

local function updateDropdownList()
    for _, child in ipairs(DropdownScroll:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end
    
    local noneBtn = UIBuilder:Create("TextButton", { Name = "NoneBtn", Size = UDim2.new(0.95, 0, 0, 18), BackgroundColor3 = Color3.fromRGB(35, 35, 35), Text = "Clear Priority", TextColor3 = Color3.fromRGB(200, 200, 200), Font = Enum.Font.Code, TextSize = 10, Parent = DropdownScroll })
    UIBuilder:Create("UICorner", { CornerRadius = UDim.new(0, 3), Parent = noneBtn })
    noneBtn.MouseButton1Click:Connect(function()
        getgenv().BleedSettings.PriorityPlayer = nil
        DropdownHeader.Text = "Priority: None"
        isDropdownOpen = false
        TweenService:Create(DropdownScroll, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0.9, 0, 0, 0)}):Play()
        task.delay(0.2, function() if not isDropdownOpen then DropdownScroll.Visible = false end end)
        TweenService:Create(PredictionPanel, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = getTargetPanelSize()}):Play()
    end)

    local totalItems = 1
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            totalItems = totalItems + 1
            local itemBtn = UIBuilder:Create("TextButton", { Name = player.Name .. "_Choice", Size = UDim2.new(0.95, 0, 0, 18), BackgroundColor3 = Color3.fromRGB(45, 45, 45), Text = player.DisplayName, TextColor3 = Color3.fromRGB(255, 255, 255), Font = Enum.Font.Code, TextSize = 10, Parent = DropdownScroll })
            UIBuilder:Create("UICorner", { CornerRadius = UDim.new(0, 3), Parent = itemBtn })
            
            itemBtn.MouseButton1Click:Connect(function()
                getgenv().BleedSettings.PriorityPlayer = player
                DropdownHeader.Text = "Priority: " .. player.DisplayName
                isDropdownOpen = false
                TweenService:Create(DropdownScroll, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0.9, 0, 0, 0)}):Play()
                task.delay(0.2, function() if not isDropdownOpen then DropdownScroll.Visible = false end end)
                TweenService:Create(PredictionPanel, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = getTargetPanelSize()}):Play()
            end)
        end
    end
    DropdownScroll.CanvasSize = UDim2.new(0, 0, 0, totalItems * 21)
end

ArrowCircle.MouseButton1Click:Connect(function()
    uiIsExpanded = not uiIsExpanded
    targetPanelOffset = uiIsExpanded and UDim2.new(0, 0, 0, 64) or UDim2.new(0, 0, 0, 0)
    ArrowCircle.Text = uiIsExpanded and "▲" or "▼"
    
    if not uiIsExpanded then
        isDropdownOpen = false
        isHitPartDropdownOpen = false
        DropdownScroll.Visible = false
        DropdownScroll.Size = UDim2.new(0.9, 0, 0, 0)
        HitPartScroll.Visible = false
        HitPartScroll.Size = UDim2.new(0.9, 0, 0, 0)
    end
    
    local targetSize = getTargetPanelSize()
    TweenService:Create(PredictionPanel, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = targetSize}):Play()
    
    if uiIsExpanded then
        PredictionPanel.Visible = true
    end
end)

AutoPredToggle.MouseButton1Click:Connect(function()
    AutoPredActive = not AutoPredActive
    if AutoPredActive then
        AutoPredToggle.BackgroundColor3 = Color3.fromRGB(40, 150, 45)
        AutoPredToggle.Text = "Auto Prediction: ON"
    else
        AutoPredToggle.BackgroundColor3 = Color3.fromRGB(115, 20, 25)
        AutoPredToggle.Text = "Auto Prediction: OFF"
        XInput.Text = tostring(getgenv().BleedSettings.PredictionX)
        YInput.Text = tostring(getgenv().BleedSettings.PredictionY)
    end
end)

VisualizerToggle.MouseButton1Click:Connect(function()
    getgenv().ESP.Enabled = not getgenv().ESP.Enabled
    if getgenv().ESP.Enabled then
        VisualizerToggle.BackgroundColor3 = Color3.fromRGB(40, 150, 45)
        VisualizerToggle.Text = "Visualizer ESP: ON"
    else
        VisualizerToggle.BackgroundColor3 = Color3.fromRGB(115, 20, 25)
        VisualizerToggle.Text = "Visualizer ESP: OFF"
        clearTargetESP()
    end
end)

-- Button click sound overlay additions
local choiceButtons = {AutoPredToggle, VisualizerToggle}
for _, btn in ipairs(choiceButtons) do
    btn.MouseButton1Click:Connect(function()
        playHitSound("Click")
    end)
end

WallCheckToggle.MouseButton1Click:Connect(function()
    getgenv().BleedSettings.WallCheck = not getgenv().BleedSettings.WallCheck
    WallCheckToggle.BackgroundColor3 = getgenv().BleedSettings.WallCheck and Color3.fromRGB(40, 150, 45) or Color3.fromRGB(115, 20, 25)
    WallCheckToggle.Text = "Wall Check: " .. (getgenv().BleedSettings.WallCheck and "ON" or "OFF")
    playHitSound("Click")
end)

HitPartHeader.MouseButton1Click:Connect(function()
    if not uiIsExpanded then return end
    isHitPartDropdownOpen = not isHitPartDropdownOpen
    playHitSound("Click")
    if isHitPartDropdownOpen then
        HitPartScroll.Visible = true
        TweenService:Create(HitPartScroll, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0.9, 0, 0, hitPartDropdownExpandedHeight)}):Play()
    else
        TweenService:Create(HitPartScroll, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0.9, 0, 0, 0)}):Play()
        task.delay(0.22, function() if not isHitPartDropdownOpen then HitPartScroll.Visible = false end end)
    end
    TweenService:Create(PredictionPanel, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = getTargetPanelSize()}):Play()
end)

DropdownHeader.MouseButton1Click:Connect(function()
    if not uiIsExpanded then return end
    isDropdownOpen = not isDropdownOpen
    playHitSound("Click")
    if isDropdownOpen then
        updateDropdownList()
        DropdownScroll.Visible = true
        TweenService:Create(DropdownScroll, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0.9, 0, 0, dropdownExpandedHeight)}):Play()
    else
        TweenService:Create(DropdownScroll, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0.9, 0, 0, 0)}):Play()
        task.delay(0.22, function() if not isDropdownOpen then DropdownScroll.Visible = false end end)
    end
    TweenService:Create(PredictionPanel, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = getTargetPanelSize()}):Play()
end)

local function assignManualPredictionHook(box, settingKey)
    box.FocusLost:Connect(function()
        if not AutoPredActive then
            local value = tonumber(box.Text)
            if value then
                getgenv().BleedSettings[settingKey] = value
            else
                box.Text = tostring(getgenv().BleedSettings[settingKey])
            end
        end
    end)
end
assignManualPredictionHook(XInput, "PredictionX")
assignManualPredictionHook(YInput, "PredictionY")

-- [[ NOTIFICATION FEED SYSTEM ]]
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

-- [[ LATENCY CALIBRATION LOOPS WITH WORKSPACE LOGGING ]]
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
            XInput.Text = string.format("%.5f", resolvedCalculatedX)
            getgenv().BleedSettings.PredictionY = resolvedCalculatedY
            YInput.Text = string.format("%.5f", resolvedCalculatedY)
        end
        
        task.wait(3) 
    end
end)

-- [[ INTERFACE DRAG HANDLING ]]
local dragToggle, dragStart, startPos = false, Vector3.new(), UDim2.new()
local targetDragPosition = ButtonFrame.Position

ButtonFrame.InputBegan:Connect(function(input)
    if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
        dragToggle = true dragStart = input.Position startPos = ButtonFrame.Position
        local releaseConnection
        releaseConnection = input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragToggle = false releaseConnection:Disconnect() end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragToggle and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        targetDragPosition = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- [[ 3D RAYCAST VISIBILITY FILTER ]]
local function checkVisibility(targetChar)
    local targetPart = getHitPart(targetChar)
    if not targetChar or not targetPart then return false end
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

-- [[ TARGET LOCK MATHEMATICS AND UNIVERSAL SCANNER ]]
local isLocked = false
local targetEntity = nil

local function getClosestTargetToCenter()
    local priorityPlayer = getgenv().BleedSettings.PriorityPlayer
    if priorityPlayer and priorityPlayer.Parent and priorityPlayer.Character then
        local targetPart = getHitPart(priorityPlayer.Character)
        if targetPart then
            local humanoid = priorityPlayer.Character:FindFirstChildOfClass("Humanoid")
            if humanoid and humanoid.Health > 0 then
                local isVisible = not getgenv().BleedSettings.WallCheck or checkVisibility(priorityPlayer.Character)
                if isVisible then return { Character = priorityPlayer.Character, DisplayName = priorityPlayer.DisplayName, IsPlayer = true, Player = priorityPlayer } end
            end
        end
    end

    local closestTarget = nil
    local shortestDistance = math.huge
    local viewportCenter = Camera.ViewportSize / 2
    local candidates = {}
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and getHitPart(player.Character) then
            table.insert(candidates, { Character = player.Character, DisplayName = player.DisplayName, IsPlayer = true, Player = player })
        end
    end
    
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("Model") and obj ~= LocalPlayer.Character then
            if getHitPart(obj) and obj:FindFirstChildOfClass("Humanoid") then
                if not Players:GetPlayerFromCharacter(obj) then
                    table.insert(candidates, { Character = obj, DisplayName = "[BOT] " .. obj.Name, IsPlayer = false })
                end
            end
        end
    end
    
    for _, target in ipairs(candidates) do
        local root = getHitPart(target.Character)
        if root then
            local screenPos, onScreen = Camera:WorldToViewportPoint(root.Position)
            if onScreen then
                local isVisible = not getgenv().BleedSettings.WallCheck or checkVisibility(target.Character)
                if isVisible then
                    local distance = (Vector2.new(screenPos.X, screenPos.Y) - viewportCenter).Magnitude
                    if distance < shortestDistance then shortestDistance = distance closestTarget = target end
                end
            end
        end
    end
    return closestTarget
end

-- [[ HYBRID PREDICTION LOGIC LAYER ]]
local trackedVelocity = Vector3.new()
local currentTrackedEntity = nil

local function calculatePrediction(targetChar, isPlayer)
    local root = getHitPart(targetChar)
    if not targetChar or not root then return nil end
    
    local humanoid = targetChar:FindFirstChildOfClass("Humanoid")
    local currentPosition = root.Position
    
    if currentTrackedEntity ~= targetChar then
        currentTrackedEntity = targetChar
        trackedVelocity = root.AssemblyLinearVelocity or root.Velocity or Vector3.new()
    else
        local rawVelocity = root.AssemblyLinearVelocity or root.Velocity or Vector3.new()
        trackedVelocity = trackedVelocity:Lerp(rawVelocity, 0.22)
    end
    
    local velocity = trackedVelocity
    local scaleX = getgenv().BleedSettings.PredictionX
    local scaleY = getgenv().BleedSettings.PredictionY
    
    if getgenv().BleedSettings.ResolverActive and humanoid then
        if velocity.Magnitude > 95 then
            velocity = root.CFrame.LookVector * humanoid.WalkSpeed
        elseif getgenv().BleedSettings.AntiGroundShot and velocity.Y == 0 then
            velocity = Vector3.new(velocity.X, 0, velocity.Z)
        end
    end
    
    local PredPos = currentPosition + (velocity * Vector3.new(scaleX, scaleY, scaleX))
    
    if humanoid and (humanoid.FloorMaterial == Enum.Material.Air or humanoid:GetState() == Enum.HumanoidStateType.Freefall or humanoid:GetState() == Enum.HumanoidStateType.Jumping) then
        local jumpOffset = tonumber(getgenv().BleedSettings.JumpOffset) or 0
        local fallOffset = tonumber(getgenv().BleedSettings.FallOffset) or 0
        if velocity.Y > 0 then PredPos = PredPos + Vector3.new(0, jumpOffset, 0) else PredPos = PredPos + Vector3.new(0, fallOffset, 0) end
    end
    
    return PredPos
end

-- [[ HIGH-PERFORMANCE TARGET VISUALIZER ]]
local ESPHolderGui = UIBuilder:Create("ScreenGui", { Parent = UIParent, Name = "UniversalTargetESPHolder" })

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

-- [[ RE-ENGINEERED BUTTON TRIGGERS WITH DEFORMATION EFFECTS ]]
TextButton.MouseButton1Click:Connect(function()
    isLocked = not isLocked
    
    -- Dynamic Physical Button Squash/Impact Animation
    ButtonFrame.ClipsDescendants = false
    local baseSize = UDim2.new(0, 190, 0, 60)
    local compressedSize = UDim2.new(0, 178, 0, 54)
    
    local compression = TweenService:Create(ButtonFrame, TweenInfo.new(0.08, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = compressedSize})
    local expansion = TweenService:Create(ButtonFrame, TweenInfo.new(0.18, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {Size = baseSize})
    
    compression:Play()
    task.delay(0.08, function() 
        expansion:Play() 
        ButtonFrame.ClipsDescendants = true
    end)

    if isLocked then
        targetEntity = getClosestTargetToCenter()
        if targetEntity then
            TextButton.TextSize = 13 
            TextButton.Text = "bleed on " .. string.upper(targetEntity.DisplayName)
            sendNotification("Locked on " .. targetEntity.DisplayName)
            
            -- Specialized Lock Trigger Effects
            playHitSound("Blood Burst") 
            playHitSound("Blood SFX")
            
            UIStroke.Color = Color3.fromRGB(255, 255, 255)
            UIStroke.Thickness = 3
            TweenService:Create(UIStroke, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Color = getgenv().Colors.Accent,
                Thickness = 1
            }):Play()
        else
            TextButton.TextSize = 17 TextButton.Text = "Bleed.cc" isLocked = false
            sendNotification("No visible target")
            playHitSound("WindowsXPError")
        end
    else
        -- Specialized Release Trigger Effects
        if targetEntity then 
            sendNotification("Speared " .. targetEntity.DisplayName) 
            playHitSound("Blood Hit")
        else
            playHitSound("Click")
        end
        targetEntity = nil 
        clearTargetESP() 
        TextButton.TextSize = 17 
        TextButton.Text = "Bleed.cc"
    end
end)

-- [[ COMBINED MASTER RUN ENGINE LOOP ]]
local RotationAngle, Tick = -45, tick()

RunService.RenderStepped:Connect(function()
    if ButtonFrame and ButtonFrame.Parent then ButtonFrame.Position = ButtonFrame.Position:Lerp(targetDragPosition, 0.24) end
    
    currentPanelOffset = currentPanelOffset:Lerp(targetPanelOffset, 0.2)
    if PredictionPanel and PredictionPanel.Parent then
        PredictionPanel.Position = ButtonFrame.Position + currentPanelOffset
        if not uiIsExpanded and PredictionPanel.Size.Y.Offset < 1 then PredictionPanel.Visible = false end
    end
    
    if ArrowCircle and ArrowCircle.Parent then
        ArrowCircle.Position = ButtonFrame.Position + UDim2.new(0, ButtonFrame.Size.X.Offset - ArrowCircle.Size.X.Offset - 6, 0, 6)
    end

    if isLocked then
        local priorityPlayer = getgenv().BleedSettings.PriorityPlayer
        if priorityPlayer and priorityPlayer.Parent and priorityPlayer.Character then
            local humanoid = priorityPlayer.Character:FindFirstChildOfClass("Humanoid")
            if humanoid and humanoid.Health > 0 then
                local isVisible = not getgenv().BleedSettings.WallCheck or checkVisibility(priorityPlayer.Character)
                if isVisible and (not targetEntity or targetEntity.Player ~= priorityPlayer) then
                    targetEntity = { Character = priorityPlayer.Character, DisplayName = priorityPlayer.DisplayName, IsPlayer = true, Player = priorityPlayer }
                    TextButton.TextSize = 13 
                    TextButton.Text = "bleed on " .. string.upper(targetEntity.DisplayName)
                end
            end
        end

        if targetEntity then
            if targetEntity.IsPlayer and targetEntity.Player then
                if not targetEntity.Player.Parent then
                    isLocked = false targetEntity = nil clearTargetESP()
                    TextButton.TextSize = 17 TextButton.Text = "Bleed.cc"
                    sendNotification("clown left LOL")
                    return
                end
                targetEntity.Character = targetEntity.Player.Character
            end

            local char = targetEntity.Character
            local hrp = getHitPart(char)
            local humanoid = char and char:FindFirstChildOfClass("Humanoid")
            
            if not char or not char.Parent or not hrp or (humanoid and humanoid.Health <= 0) then
                hideActiveElements() return
            end
            
            local isStillVisible = not getgenv().BleedSettings.WallCheck or checkVisibility(char)
            if isStillVisible then
                local targetPosition = calculatePrediction(char, targetEntity.IsPlayer)
                if targetPosition then Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, targetPosition) end
            end
            
            if getgenv().ESP.Enabled then
                if not activeESP then buildTargetESP(char) end
                
                local Pos, OnScreen = Camera:WorldToScreenPoint(hrp.Position)
                local Dist = (Camera.CFrame.Position - hrp.Position).Magnitude / 3.5714
                
                if OnScreen and Dist <= getgenv().ESP.MaxDistance then
                    local ae = activeESP
                    local Size = hrp.Size.Y
                    local scaleFactor = (Size * Camera.ViewportSize.Y) / (Pos.Z * 2)
                    local w, h = 3 * scaleFactor, 4.5 * scaleFactor
                    
                    if getgenv().ESP.FadeOut.OnDistance then
                        UIBuilder:FadeOutOnDist(ae.Box, Dist); UIBuilder:FadeOutOnDist(ae.Outline, Dist); UIBuilder:FadeOutOnDist(ae.Name, Dist); UIBuilder:FadeOutOnDist(ae.Distance, Dist); UIBuilder:FadeOutOnDist(ae.Weapon, Dist); UIBuilder:FadeOutOnDist(ae.Healthbar, Dist); UIBuilder:FadeOutOnDist(ae.BehindHealthbar, Dist); UIBuilder:FadeOutOnDist(ae.HealthText, Dist); UIBuilder:FadeOutOnDist(ae.WeaponIcon, Dist); UIBuilder:FadeOutOnDist(ae.LeftTop, Dist); UIBuilder:FadeOutOnDist(ae.LeftSide, Dist); UIBuilder:FadeOutOnDist(ae.BottomSide, Dist); UIBuilder:FadeOutOnDist(ae.BottomDown, Dist); UIBuilder:FadeOutOnDist(ae.RightTop, Dist); UIBuilder:FadeOutOnDist(ae.RightSide, Dist); UIBuilder:FadeOutOnDist(ae.BottomRightSide, Dist); UIBuilder:FadeOutOnDist(ae.BottomRightDown, Dist); UIBuilder:FadeOutOnDist(ae.Chams, Dist); UIBuilder:FadeOutOnDist(ae.Flag1, Dist); UIBuilder:FadeOutOnDist(ae.Flag2, Dist)
                    end
                    
                    ae.Chams.Adornee = char
                    ae.Chams.Enabled = getgenv().ESP.Drawing.Chams.Enabled
                    ae.Chams.FillColor = getgenv().ESP.Drawing.Chams.FillRGB
                    ae.Chams.OutlineColor = getgenv().ESP.Drawing.Chams.OutlineRGB
                    
                    if getgenv().ESP.Drawing.Chams.Thermal then
                        local breathe_effect = math.atan(math.sin(tick() * 2)) * 2 / math.pi
                        ae.Chams.FillTransparency = getgenv().ESP.Drawing.Chams.Fill_Transparency * breathe_effect * 0.01
                        ae.Chams.OutlineTransparency = getgenv().ESP.Drawing.Chams.Outline_Transparency * breathe_effect * 0.01
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

                    ae.Box.Position = UDim2.new(0, Pos.X - w / 2, 0, Pos.Y - h / 2)
                    ae.Box.Size = UDim2.new(0, w, 0, h)
                    ae.Box.Visible = getgenv().ESP.Drawing.Boxes.Full.Enabled

                    if getgenv().ESP.Drawing.Boxes.Filled.Enabled then
                        ae.Box.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        ae.Box.BackgroundTransparency = getgenv().ESP.Drawing.Boxes.GradientFill and getgenv().ESP.Drawing.Boxes.Filled.Transparency or 1
                        ae.Box.BorderSizePixel = 1
                    else
                        ae.Box.BackgroundTransparency = 1
                    end

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
                    else
                        ae.HealthText.Visible = false
                    end                        

                    ae.Name.Visible = getgenv().ESP.Drawing.Names.Enabled
                    local identityTag, tagColor = "P", "rgb(255,0,40)"
                    
                    if targetEntity.IsPlayer then
                        local playerInstance = Players:GetPlayerFromCharacter(char)
                        if playerInstance and getgenv().ESP.Options.Friendcheck and LocalPlayer:IsFriendsWith(playerInstance.UserId) then identityTag = "F" tagColor = "rgb(0,255,0)" end
                    else
                        identityTag = "B" tagColor = "rgb(200,160,255)" 
                    end
                    
                    if getgenv().ESP.Drawing.Distances.Position == "Bottom" then
                        ae.Weapon.Position = UDim2.new(0, Pos.X, 0, Pos.Y + h / 2 + 18); ae.WeaponIcon.Position = UDim2.new(0, Pos.X - 21, 0, Pos.Y + h / 2 + 15)
                        ae.Distance.Position = UDim2.new(0, Pos.X, 0, Pos.Y + h / 2 + 7); ae.Distance.Text = string.format("%d meters", math.floor(Dist)); ae.Distance.Visible = true
                        ae.Name.Text = string.format('(<font color="%s">%s</font>) %s', tagColor, identityTag, targetEntity.DisplayName)
                    elseif getgenv().ESP.Drawing.Distances.Position == "Text" then
                        ae.Weapon.Position = UDim2.new(0, Pos.X, 0, Pos.Y + h / 2 + 8); ae.WeaponIcon.Position = UDim2.new(0, Pos.X - 21, 0, Pos.Y + h / 2 + 5); ae.Distance.Visible = false
                        ae.Name.Text = string.format('(<font color="%s">%s</font>) %s [%d]', tagColor, identityTag, targetEntity.DisplayName, math.floor(Dist))
                    end
                    ae.Weapon.Text = "none" ae.Weapon.Visible = getgenv().ESP.Drawing.Weapons.Enabled
                else
                    hideActiveElements()
                end
            else
                hideActiveElements()
            end
        else
            clearTargetESP()
        end
    else
        clearTargetESP()
    end
end)

-- [[ UNIVERSAL METATABLE HOOK ENGINE ]]
local rawMetatable = getrawmetatable(game)
local originalIndex = rawMetatable.__index
setreadonly(rawMetatable, false)

rawMetatable.__index = newcclosure(function(self, index)
    if not checkcaller() and isLocked and targetEntity and targetEntity.Character then
        local char = targetEntity.Character
        local hitPart = getHitPart(char)
        
        if hitPart and (index == "Hit" or index == "Target") then
            local rollLimit = getgenv().BleedSettings.HitChance or 100
            if rollLimit < 100 and math.random(1, 100) > rollLimit then return originalIndex(self, index) end

            local predictedPos = calculatePrediction(char, targetEntity.IsPlayer)
            if predictedPos then
                if index == "Hit" then return CFrame.new(predictedPos) elseif index == "Target" then return hitPart end
            end
        end
    end
    return originalIndex(self, index)
end)

setreadonly(rawMetatable, true)
