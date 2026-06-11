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

function UIBuilder:CreateGroupBox(parent, title, layoutOrder)
    local boxFrame = UIBuilder:Create("Frame", { Name = title .. "GroupBox", Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1, LayoutOrder = layoutOrder, Parent = parent })
    local titleLabel = UIBuilder:Create("TextLabel", { Name = "BoxTitle", Size = UDim2.new(1, 0, 0, 14), Text = "  " .. title:upper(), TextColor3 = Color3.fromRGB(225, 50, 65), Font = Enum.Font.Code, TextSize = 9, TextXAlignment = Enum.TextXAlignment.Left, Parent = boxFrame })
    local contentContainer = UIBuilder:Create("Frame", { Name = "Content", Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1, Parent = boxFrame })
    UIBuilder:Create("UIListLayout", { Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder, HorizontalAlignment = Enum.HorizontalAlignment.Center, Parent = contentContainer })
    return contentContainer
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
local RainContainer = UIBuilder:Create("Frame", { Name = "RainContainer", Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, ClipsDescendants = true, ZIndex = 1, Parent = ButtonFrame })
local TextButton = UIBuilder:Create("TextButton", { Name = "TextButton", Size = UDim2.new(1, -12, 1, -12), Position = UDim2.new(0, 6, 0, 6), BackgroundTransparency = 1, Text = "Bleed.cc", TextColor3 = getgenv().Colors.TextPrimary, Font = Enum.Font.Code, TextSize = 17, ZIndex = 3, Parent = ButtonFrame })
local NotificationContainer = UIBuilder:Create("Frame", { Name = "NotificationContainer", Size = UDim2.new(0, 180, 0, 600), Position = UDim2.new(1, -195, 0, 20), BackgroundTransparency = 1, Parent = ScreenGui })
local UIListLayout = UIBuilder:Create("UIListLayout", { Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Top, Parent = NotificationContainer })

-- [[ RETRACTABLE PREDICTION PANEL ENGINE WITH TAB MODULES ]]
local PredictionPanel = UIBuilder:Create("Frame", { Name = "PredictionPanel", Size = UDim2.new(0, 190, 0, 0), Position = ButtonFrame.Position, BackgroundColor3 = Color3.fromRGB(115, 0, 5), BackgroundTransparency = 0.5, BorderSizePixel = 0, ZIndex = ButtonFrame.ZIndex - 1, Visible = false, ClipsDescendants = true, Parent = ScreenGui })
local PanelCorner = UIBuilder:Create("UICorner", { CornerRadius = UDim.new(0, 8), Parent = PredictionPanel })
local PanelLayout = UIBuilder:Create("UIListLayout", { Padding = UDim.new(0, 5), SortOrder = Enum.SortOrder.LayoutOrder, HorizontalAlignment = Enum.HorizontalAlignment.Center, VerticalAlignment = Enum.VerticalAlignment.Top, Parent = PredictionPanel })
local PanelPadding = UIBuilder:Create("UIPadding", { PaddingTop = UDim.new(0, 6), PaddingBottom = UDim.new(0, 6), Parent = PredictionPanel })

-- [[ MULTI-TAB ENGINE CONTROLLER NAVIGATION HEADERS ]]
local TabSystemBar = UIBuilder:Create("Frame", { Name = "TabSystemBar", Size = UDim2.new(0, 171, 0, 22), BackgroundTransparency = 1, LayoutOrder = 1, Parent = PredictionPanel })
UIBuilder:Create("UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder, Parent = TabSystemBar })

local MainTabBtn = UIBuilder:Create("TextButton", { Name = "MainTabBtn", Size = UDim2.new(0.5, -2, 1, 0), BackgroundColor3 = Color3.fromRGB(135, 10, 15), Text = "Main", TextColor3 = Color3.fromRGB(255, 255, 255), Font = Enum.Font.Code, TextSize = 11, LayoutOrder = 1, Parent = TabSystemBar })
UIBuilder:Create("UICorner", { CornerRadius = UDim.new(0, 4), Parent = MainTabBtn })
local SettingsTabBtn = UIBuilder:Create("TextButton", { Name = "SettingsTabBtn", Size = UDim2.new(0.5, -2, 1, 0), BackgroundColor3 = Color3.fromRGB(75, 5, 8), Text = "Settings", TextColor3 = Color3.fromRGB(180, 180, 180), Font = Enum.Font.Code, TextSize = 11, LayoutOrder = 2, Parent = TabSystemBar })
UIBuilder:Create("UICorner", { CornerRadius = UDim.new(0, 4), Parent = SettingsTabBtn })

-- TAB SUB-PAGE CONTAINERS
local MainTabPage = UIBuilder:Create("Frame", { Name = "MainTabPage", Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1, LayoutOrder = 2, Visible = true, Parent = PredictionPanel })
UIBuilder:Create("UIListLayout", { Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder, HorizontalAlignment = Enum.HorizontalAlignment.Center, Parent = MainTabPage })

local SettingsTabPage = UIBuilder:Create("Frame", { Name = "SettingsTabPage", Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1, LayoutOrder = 3, Visible = false, Parent = PredictionPanel })
UIBuilder:Create("UIListLayout", { Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder, HorizontalAlignment = Enum.HorizontalAlignment.Center, Parent = SettingsTabPage })

-- GENERATE TAB 1 CONFIGURATION GROUPS
local Group1_Combat = UIBuilder:CreateGroupBox(MainTabPage, "Core Combat System", 1)
local Group2_Prediction = UIBuilder:CreateGroupBox(MainTabPage, "Camera Prediction Vector", 2)
local Group3_Hitmapping = UIBuilder:CreateGroupBox(MainTabPage, "Target Alignment Mapping", 3)

-- GENERATE TAB 2 CONFIGURATION GROUPS
local Group4_Visualizer = UIBuilder:CreateGroupBox(SettingsTabPage, "System Tracking Modules", 1)

local AutoPredActive = false
local updatingTargetLock = false 
local hitpartDropdownOpen = false
local priorityDropdownOpen = false
local ActiveUINavigationTab = "Main"

-- [[ GROUPBOX 1: COMBAT ACTUATORS ]]
local ButtonSpawnerBtn = UIBuilder:Create("TextButton", { Name = "ButtonSpawnerBtn", Size = UDim2.new(0, 171, 0, 22), BackgroundColor3 = Color3.fromRGB(115, 20, 25), Text = "Toggle Anchor Button", TextColor3 = Color3.fromRGB(255, 255, 255), Font = Enum.Font.Code, TextSize = 11, LayoutOrder = 1, Parent = Group1_Combat })
UIBuilder:Create("UICorner", { CornerRadius = UDim.new(0, 5), Parent = ButtonSpawnerBtn })

local AntiGroundToggle = UIBuilder:Create("TextButton", { Name = "AntiGroundToggle", Size = UDim2.new(0, 171, 0, 22), BackgroundColor3 = getgenv().BleedSettings.AntiGroundShot and Color3.fromRGB(40, 150, 45) or Color3.fromRGB(115, 20, 25), Text = "Anti Ground Shot: " .. (getgenv().BleedSettings.AntiGroundShot and "ON" or "OFF"), TextColor3 = Color3.fromRGB(255, 255, 255), Font = Enum.Font.Code, TextSize = 11, LayoutOrder = 2, Parent = Group1_Combat })
UIBuilder:Create("UICorner", { CornerRadius = UDim.new(0, 5), Parent = AntiGroundToggle })

local ResolverToggle = UIBuilder:Create("TextButton", { Name = "ResolverToggle", Size = UDim2.new(0, 171, 0, 22), BackgroundColor3 = getgenv().BleedSettings.ResolverActive and Color3.fromRGB(40, 150, 45) or Color3.fromRGB(115, 20, 25), Text = "Resolver Matrix: " .. (getgenv().BleedSettings.ResolverActive and "ON" or "OFF"), TextColor3 = Color3.fromRGB(255, 255, 255), Font = Enum.Font.Code, TextSize = 11, LayoutOrder = 3, Parent = Group1_Combat })
UIBuilder:Create("UICorner", { CornerRadius = UDim.new(0, 5), Parent = ResolverToggle })

-- [[ GROUPBOX 2: PREDICTION INPUT LAYELS ]]
local InputsContainer = UIBuilder:Create("Frame", { Name = "InputsContainer", Size = UDim2.new(0, 171, 0, 22), BackgroundTransparency = 1, LayoutOrder = 1, Parent = Group2_Prediction })
UIBuilder:Create("UIListLayout", { Padding = UDim.new(0, 5), FillDirection = Enum.FillDirection.Horizontal, SortOrder = Enum.SortOrder.LayoutOrder, HorizontalAlignment = Enum.HorizontalAlignment.Center, Parent = InputsContainer })

local XInput = UIBuilder:Create("TextBox", { Name = "XInput", Size = UDim2.new(0.48, -2, 1, 0), BackgroundColor3 = getgenv().Colors.DropdownBg, Text = tostring(getgenv().BleedSettings.PredictionX), PlaceholderText = "X Pred", TextColor3 = Color3.fromRGB(255, 255, 255), Font = Enum.Font.Code, TextScaled = true, LayoutOrder = 1, Parent = InputsContainer })
UIBuilder:Create("UICorner", { CornerRadius = UDim.new(0, 4), Parent = XInput })
UIBuilder:Create("UITextSizeConstraint", { MaxTextSize = 11, Parent = XInput })

local YInput = UIBuilder:Create("TextBox", { Name = "YInput", Size = UDim2.new(0.48, -2, 1, 0), BackgroundColor3 = getgenv().Colors.DropdownBg, Text = tostring(getgenv().BleedSettings.PredictionY), PlaceholderText = "Y Pred", TextColor3 = Color3.fromRGB(255, 255, 255), Font = Enum.Font.Code, TextScaled = true, LayoutOrder = 2, Parent = InputsContainer })
UIBuilder:Create("UICorner", { CornerRadius = UDim.new(0, 4), Parent = YInput })
UIBuilder:Create("UITextSizeConstraint", { MaxTextSize = 11, Parent = YInput })

local AutoPredToggle = UIBuilder:Create("TextButton", { Name = "AutoPredToggle", Size = UDim2.new(0, 171, 0, 22), BackgroundColor3 = Color3.fromRGB(115, 20, 25), Text = "Auto Prediction: OFF", TextColor3 = Color3.fromRGB(255, 255, 255), Font = Enum.Font.Code, TextSize = 11, LayoutOrder = 2, Parent = Group2_Prediction })
UIBuilder:Create("UICorner", { CornerRadius = UDim.new(0, 5), Parent = AutoPredToggle })

-- [[ GROUPBOX 3: TARGET SELECTION INTERACTION LAYER ]]
local HitpartContainer = UIBuilder:Create("Frame", { Name = "HitpartContainer", Size = UDim2.new(0, 171, 0, 22), BackgroundTransparency = 1, ClipsDescendants = true, LayoutOrder = 1, Parent = Group3_Hitmapping })
local HitpartLayout = UIBuilder:Create("UIListLayout", { Padding = UDim.new(0, 2), SortOrder = Enum.SortOrder.LayoutOrder, Parent = HitpartContainer })
local HitpartToggle = UIBuilder:Create("TextButton", { Name = "HitpartToggle", Size = UDim2.new(1, 0, 0, 22), BackgroundColor3 = getgenv().Colors.DropdownBg, Text = "Hitpart: " .. getgenv().BleedSettings.TargetPart .. " ▾", TextColor3 = Color3.fromRGB(255, 255, 255), Font = Enum.Font.Code, TextSize = 11, LayoutOrder = 1, Parent = HitpartContainer })
UIBuilder:Create("UICorner", { CornerRadius = UDim.new(0, 5), Parent = HitpartToggle })

-- [[ ORIGINAL CORE ARCHITECTURE (TAB 2 REDIRECTS) ]]
local VisualizerToggle = UIBuilder:Create("TextButton", { Name = "VisualizerToggle", Size = UDim2.new(0, 171, 0, 22), BackgroundColor3 = getgenv().ESP.Enabled and Color3.fromRGB(40, 150, 45) or Color3.fromRGB(115, 20, 25), Text = "Visualizer ESP: " .. (getgenv().ESP.Enabled and "ON" or "OFF"), TextColor3 = Color3.fromRGB(255, 255, 255), Font = Enum.Font.Code, TextSize = 11, LayoutOrder = 1, Parent = Group4_Visualizer })
UIBuilder:Create("UICorner", { CornerRadius = UDim.new(0, 5), Parent = VisualizerToggle })

local WallCheckToggle = UIBuilder:Create("TextButton", { Name = "WallCheckToggle", Size = UDim2.new(0, 171, 0, 22), BackgroundColor3 = getgenv().BleedSettings.WallCheck and Color3.fromRGB(40, 150, 45) or Color3.fromRGB(115, 20, 25), Text = "Wall Check: " .. (getgenv().BleedSettings.WallCheck and "ON" or "OFF"), TextColor3 = Color3.fromRGB(255, 255, 255), Font = Enum.Font.Code, TextSize = 11, LayoutOrder = 2, Parent = Group4_Visualizer })
UIBuilder:Create("UICorner", { CornerRadius = UDim.new(0, 5), Parent = WallCheckToggle })

local PriorityContainer = UIBuilder:Create("Frame", { Name = "PriorityContainer", Size = UDim2.new(0, 171, 0, 22), BackgroundTransparency = 1, ClipsDescendants = true, LayoutOrder = 3, Parent = Group4_Visualizer })
local PriorityLayout = UIBuilder:Create("UIListLayout", { Padding = UDim.new(0, 2), SortOrder = Enum.SortOrder.LayoutOrder, Parent = PriorityContainer })
local PriorityToggle = UIBuilder:Create("TextButton", { Name = "PriorityToggle", Size = UDim2.new(1, 0, 0, 22), BackgroundColor3 = getgenv().Colors.DropdownBg, Text = "Priority: " .. getgenv().BleedSettings.PriorityTarget .. " ▾", TextColor3 = Color3.fromRGB(255, 255, 255), Font = Enum.Font.Code, TextSize = 10, LayoutOrder = 1, Parent = PriorityContainer })
UIBuilder:Create("UICorner", { CornerRadius = UDim.new(0, 5), Parent = PriorityToggle })

local PriorityScroll = UIBuilder:Create("ScrollingFrame", { Name = "PriorityScroll", Size = UDim2.new(1, 0, 0, 0), BackgroundTransparency = 1, BorderSizePixel = 0, ScrollBarThickness = 3, ScrollBarImageColor3 = getgenv().Colors.Accent, CanvasSize = UDim2.new(0, 0, 0, 0), LayoutOrder = 2, Visible = false, Parent = PriorityContainer })
local PriorityScrollLayout = UIBuilder:Create("UIListLayout", { Padding = UDim.new(0, 2), SortOrder = Enum.SortOrder.LayoutOrder, Parent = PriorityScroll })

-- SYSTEM ARROW CONTROL MECHANICS
local ArrowCircle = UIBuilder:Create("TextButton", { Name = "ArrowCircle", Size = UDim2.new(0, 18, 0, 18), BackgroundColor3 = getgenv().Colors.Background, Text = "▼", TextColor3 = getgenv().Colors.TextPrimary, Font = Enum.Font.Code, TextSize = 10, ZIndex = ButtonFrame.ZIndex + 4, Parent = ScreenGui })
UIBuilder:Create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = ArrowCircle })
local CircleStroke = UIBuilder:Create("UIStroke", { Color = getgenv().Colors.Accent, Thickness = 1, Parent = ArrowCircle })

local uiIsExpanded = false
local currentPanelOffset = UDim2.new(0, 0, 0, 0)
local targetPanelOffset = UDim2.new(0, 0, 0, 0)

local activeESP = nil
local function clearTargetESP()
    if activeESP then activeESP.Container:Destroy() activeESP = nil end
end

local componentsList = {"HumanoidRootPart", "Head", "UpperTorso", "LowerTorso"}
local function retrievePlayerPool()
    local array = {"None"}
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then table.insert(array, p.DisplayName) end
    end
    return array
end

-- [[ INTERFACE TAB SWAP AND DYNAMIC HEIGHT RECALCULATOR ENGINE ]]
local function updatePanelHeight()
    if not uiIsExpanded then 
        TweenService:Create(PredictionPanel, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 190, 0, 0)}):Play()
        return 
    end
    
    local calculatedHeight = 40 -- Top padding base buffer
    
    if ActiveUINavigationTab == "Main" then
        local hPartHeight = hitpartDropdownOpen and (22 + (#componentsList * 20)) or 22
        calculatedHeight = calculatedHeight + 82 -- Core toggles + header label
        calculatedHeight = calculatedHeight + 62 -- Predictions + header label
        calculatedHeight = calculatedHeight + hPartHeight + 14 -- Target mapping base
    elseif ActiveUINavigationTab == "Settings" then
        local currentPool = retrievePlayerPool()
        local pTargetHeight = 22
        if priorityDropdownOpen then
            pTargetHeight = 22 + math.min(#currentPool * 20, 100) + 4
        end
        calculatedHeight = calculatedHeight + 22 + 22 + pTargetHeight + 20 -- Safety margin
    end
    
    TweenService:Create(PredictionPanel, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 190, 0, calculatedHeight)}):Play()
end

-- TAB NAVIGATION BUTTON CONTROLLER MAPPINGS
MainTabBtn.MouseButton1Click:Connect(function()
    ActiveUINavigationTab = "Main"
    MainTabBtn.BackgroundColor3 = Color3.fromRGB(135, 10, 15)
    MainTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    SettingsTabBtn.BackgroundColor3 = Color3.fromRGB(75, 5, 8)
    SettingsTabBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
    MainTabPage.Visible = true
    SettingsTabPage.Visible = false
    updatePanelHeight()
end)

SettingsTabBtn.MouseButton1Click:Connect(function()
    ActiveUINavigationTab = "Settings"
    SettingsTabBtn.BackgroundColor3 = Color3.fromRGB(135, 10, 15)
    SettingsTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    MainTabBtn.BackgroundColor3 = Color3.fromRGB(75, 5, 8)
    MainTabBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
    MainTabPage.Visible = false
    SettingsTabPage.Visible = true
    updatePanelHeight()
end)

ButtonSpawnerBtn.MouseButton1Click:Connect(function()
    ButtonFrame.Visible = not ButtonFrame.Visible
end)

AntiGroundToggle.MouseButton1Click:Connect(function()
    getgenv().BleedSettings.AntiGroundShot = not getgenv().BleedSettings.AntiGroundShot
    if getgenv().BleedSettings.AntiGroundShot then
        AntiGroundToggle.BackgroundColor3 = Color3.fromRGB(40, 150, 45)
        AntiGroundToggle.Text = "Anti Ground Shot: ON"
    else
        AntiGroundToggle.BackgroundColor3 = Color3.fromRGB(115, 20, 25)
        AntiGroundToggle.Text = "Anti Ground Shot: OFF"
    end
end)

ResolverToggle.MouseButton1Click:Connect(function()
    getgenv().BleedSettings.ResolverActive = not getgenv().BleedSettings.ResolverActive
    if getgenv().BleedSettings.ResolverActive then
        ResolverToggle.BackgroundColor3 = Color3.fromRGB(40, 150, 45)
        ResolverToggle.Text = "Resolver Matrix: ON"
    else
        ResolverToggle.BackgroundColor3 = Color3.fromRGB(115, 20, 25)
        ResolverToggle.Text = "Resolver Matrix: OFF"
    end
end)

ArrowCircle.MouseButton1Click:Connect(function()
    uiIsExpanded = not uiIsExpanded
    targetPanelOffset = uiIsExpanded and UDim2.new(0, 0, 0, 64) or UDim2.new(0, 0, 0, 0)
    ArrowCircle.Text = uiIsExpanded and "▲" or "▼"
    
    if not uiIsExpanded then
        updatingTargetLock = true
        hitpartDropdownOpen = false
        priorityDropdownOpen = false
        HitpartToggle.Text = "Hitpart: " .. getgenv().BleedSettings.TargetPart .. " ▾"
        PriorityToggle.Text = "Priority: " .. getgenv().BleedSettings.PriorityTarget .. " ▾"
        
        TweenService:Create(HitpartContainer, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 171, 0, 22)}):Play()
        TweenService:Create(PriorityContainer, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 171, 0, 22)}):Play()
        TweenService:Create(PriorityScroll, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(1, 0, 0, 0)}):Play()
        local t3 = TweenService:Create(PredictionPanel, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 190, 0, 0)})
        
        t3:Play()
        task.spawn(function()
            t3.Completed:Wait()
            PriorityScroll.Visible = false
            updatingTargetLock = false
        end)
    else
        PredictionPanel.Visible = true
        updatePanelHeight()
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
        VisualizerToggle.Text = "Target ESP: ON"
    else
        VisualizerToggle.BackgroundColor3 = Color3.fromRGB(115, 20, 25)
        VisualizerToggle.Text = "Target ESP: OFF"
        clearTargetESP()
    end
end)

WallCheckToggle.MouseButton1Click:Connect(function()
    getgenv().BleedSettings.WallCheck = not getgenv().BleedSettings.WallCheck
    if getgenv().BleedSettings.WallCheck then
        WallCheckToggle.BackgroundColor3 = Color3.fromRGB(40, 150, 45)
        WallCheckToggle.Text = "Wall Check: ON"
    else
        WallCheckToggle.BackgroundColor3 = Color3.fromRGB(115, 20, 25)
        WallCheckToggle.Text = "Wall Check: OFF"
    end
end)

-- [[ HITPART DROPDOWN ENGINE ]]
local activeHitpartButtons = {}
local function clearHitpartDropdown()
    for _, btn in ipairs(activeHitpartButtons) do btn:Destroy() end
    table.clear(activeHitpartButtons)
end

HitpartToggle.MouseButton1Click:Connect(function()
    hitpartDropdownOpen = not hitpartDropdownOpen
    if hitpartDropdownOpen then
        HitpartToggle.Text = "Hitpart: " .. getgenv().BleedSettings.TargetPart .. " ▴"
        clearHitpartDropdown()
        for i, partName in ipairs(componentsList) do
            local optionBtn = UIBuilder:Create("TextButton", { Name = "Option_" .. partName, Size = UDim2.new(1, 0, 0, 18), BackgroundColor3 = getgenv().Colors.DropdownOption, Text = partName, TextColor3 = Color3.fromRGB(225, 225, 225), Font = Enum.Font.Code, TextSize = 10, LayoutOrder = i + 1, Parent = HitpartContainer })
            UIBuilder:Create("UICorner", { CornerRadius = UDim.new(0, 4), Parent = optionBtn })
            
            optionBtn.MouseButton1Click:Connect(function()
                updatingTargetLock = true
                getgenv().BleedSettings.TargetPart = partName
                HitpartToggle.Text = "Hitpart: " .. partName .. " ▾"
                hitpartDropdownOpen = false
                
                local t = TweenService:Create(HitpartContainer, TweenInfo.new(0.18, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 171, 0, 22)})
                t:Play()
                updatePanelHeight()
                task.spawn(function()
                    t.Completed:Wait()
                    clearHitpartDropdown()
                    updatingTargetLock = false
                end)
            end)
            table.insert(activeHitpartButtons, optionBtn)
        end
        local targetSizeY = 22 + (#componentsList * 20)
        TweenService:Create(HitpartContainer, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 171, 0, targetSizeY)}):Play()
    else
        HitpartToggle.Text = "Hitpart: " .. getgenv().BleedSettings.TargetPart .. " ▾"
        local t = TweenService:Create(HitpartContainer, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 171, 0, 22)})
        t:Play()
        task.spawn(function()
            t.Completed:Wait()
            if not hitpartDropdownOpen then clearHitpartDropdown() end
        end)
    end
    updatePanelHeight()
end)

-- [[ HIGH CAPACITY SCROLLABLE PRIORITY SELECTION MODULE ]]
local activePriorityButtons = {}
local function clearPriorityDropdown()
    for _, btn in ipairs(activePriorityButtons) do btn:Destroy() end
    table.clear(activePriorityButtons)
end

PriorityToggle.MouseButton1Click:Connect(function()
    priorityDropdownOpen = not priorityDropdownOpen
    if priorityDropdownOpen then
        PriorityToggle.Text = "Priority: " .. getgenv().BleedSettings.PriorityTarget .. " ▴"
        clearPriorityDropdown()
        local pool = retrievePlayerPool()
        
        PriorityScroll.Visible = true
        PriorityScroll.CanvasSize = UDim2.new(0, 0, 0, #pool * 20)
        
        for i, playerName in ipairs(pool) do
            local optionBtn = UIBuilder:Create("TextButton", { Name = "Option_" .. playerName, Size = UDim2.new(1, -6, 0, 18), BackgroundColor3 = getgenv().Colors.DropdownOption, Text = playerName, TextColor3 = Color3.fromRGB(225, 225, 225), Font = Enum.Font.Code, TextSize = 10, LayoutOrder = i, Parent = PriorityScroll })
            UIBuilder:Create("UICorner", { CornerRadius = UDim.new(0, 4), Parent = optionBtn })
            
            optionBtn.MouseButton1Click:Connect(function()
                updatingTargetLock = true 
                getgenv().BleedSettings.PriorityTarget = playerName
                PriorityToggle.Text = "Priority: " .. playerName .. " ▾"
                priorityDropdownOpen = false
                
                if isLocked then
                    local verifiedTarget = nil
                    for _, p in ipairs(Players:GetPlayers()) do
                        if p ~= LocalPlayer and p.DisplayName == playerName then
                            verifiedTarget = { Character = p.Character, DisplayName = p.DisplayName, IsPlayer = true, Player = p }
                            break
                        end
                    end
                    if verifiedTarget then
                        targetEntity = verifiedTarget
                        TextButton.Text = "bleed on " .. string.upper(targetEntity.DisplayName)
                    else
                        targetEntity = nil 
                        TextButton.TextSize = 17 TextButton.Text = "Bleed.cc" isLocked = false
                    end
                end
                
                local t = TweenService:Create(PriorityContainer, TweenInfo.new(0.18, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 171, 0, 22)})
                local ts = TweenService:Create(PriorityScroll, TweenInfo.new(0.18, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(1, 0, 0, 0)})
                t:Play() ts:Play()
                
                updatePanelHeight()
                
                task.spawn(function()
                    t.Completed:Wait()
                    PriorityScroll.Visible = false
                    clearPriorityDropdown()
                    updatingTargetLock = false
                end)
            end)
            table.insert(activePriorityButtons, optionBtn)
        end
        
        local scrollTargetHeight = math.min(#pool * 20, 100)
        local targetSizeY = 22 + scrollTargetHeight + 4
        
        TweenService:Create(PriorityContainer, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 171, 0, targetSizeY)}):Play()
        TweenService:Create(PriorityScroll, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(1, 0, 0, scrollTargetHeight)}):Play()
    else
        PriorityToggle.Text = "Priority: " .. getgenv().BleedSettings.PriorityTarget .. " ▾"
        local t = TweenService:Create(PriorityContainer, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 171, 0, 22)})
        local ts = TweenService:Create(PriorityScroll, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(1, 0, 0, 0)})
        t:Play() ts:Play()
        task.spawn(function()
            t.Completed:Wait()
            if not priorityDropdownOpen then 
                PriorityScroll.Visible = false
                clearPriorityDropdown() 
            end
        end)
    end
    updatePanelHeight()
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

-- [[ ATMOSPHERIC ENVIRONMENT ENGINE ]]
local function spawnRainDrop()
    if not ButtonFrame or not ButtonFrame.Parent then return end
    local depthFactor = math.random() 
    local drop = Instance.new("Frame")
    drop.Size = UDim2.new(0, depthFactor > 0.85 and 1.5 or 1, 0, 8 + (depthFactor * 16))
    local startX = math.random(-15, 125) / 100
    drop.Position = UDim2.new(startX, 0, -0.3, 0)
    drop.BackgroundColor3 = Color3.fromRGB(215, 230, 245)
    drop.BorderSizePixel = 0
    drop.BackgroundTransparency = 0.45 + (depthFactor * 0.4)
    drop.ZIndex = 1
    drop.Parent = RainContainer
    
    local fallTween = TweenService:Create(drop, TweenInfo.new(0.22 + (depthFactor * 0.18), Enum.EasingStyle.Linear), {Position = UDim2.new(startX - 0.16, 0, 1.3, 0)})
    fallTween:Play() fallTween.Completed:Connect(function() drop:Destroy() end)
end

local function spawnBloodDrip()
    if not ButtonFrame or not ButtonFrame.Parent then return end
    local startX = math.random(4, 96) / 100
    local baseWidth = math.random(3, 5)
    local dynamicBloodColors = {Color3.fromRGB(90, 2, 6), Color3.fromRGB(118, 4, 12), Color3.fromRGB(75, 0, 2)}
    local bloodColor = dynamicBloodColors[math.random(1, #dynamicBloodColors)]
    
    local dripGroup = Instance.new("Frame")
    dripGroup.Size = UDim2.new(0, 16, 1, 0)
    dripGroup.Position = UDim2.new(startX, -8, 0, 0)
    dripGroup.BackgroundTransparency = 1
    dripGroup.ZIndex = 2
    dripGroup.Parent = RainContainer
    
    local stem = Instance.new("Frame")
    stem.Size = UDim2.new(0, baseWidth, 0, 3)
    stem.Position = UDim2.new(0.5, -baseWidth/2, 0, 0)
    stem.BackgroundColor3 = bloodColor
    stem.BorderSizePixel = 0
    stem.Parent = dripGroup
    
    local bulb = Instance.new("Frame")
    local bulbSize = baseWidth + math.random(2, 3)
    bulb.Size = UDim2.new(0, bulbSize, 0, bulbSize)
    bulb.Position = UDim2.new(0.5, -bulbSize/2, 0, 0)
    bulb.BackgroundColor3 = bloodColor
    bulb.BorderSizePixel = 0
    bulb.Visible = false
    bulb.Parent = dripGroup

    local c1 = Instance.new("UICorner") c1.CornerRadius = UDim.new(1, 0) c1.Parent = bulb
    local c2 = Instance.new("UICorner") c2.CornerRadius = UDim.new(0, 2) c2.Parent = stem

    task.spawn(function()
        task.wait(math.random(3, 10) / 10)
        if not bulb or not stem or not dripGroup.Parent then return end
        
        bulb.Visible = true
        local targetLength = math.random(14, 34)
        
        local elongateTween = TweenService:Create(stem, TweenInfo.new(1.6, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {Size = UDim2.new(0, baseWidth - 0.5, 0, targetLength)})
        local bulbFollowTween = TweenService:Create(bulb, TweenInfo.new(1.6, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {Position = UDim2.new(0.5, -bulbSize/2, 0, targetLength - 1)})
        
        elongateTween:Play() bulbFollowTween:Play() elongateTween.Completed:Wait()
        if not bulb or not stem then return end
        
        local fallTween = TweenService:Create(bulb, TweenInfo.new(0.26, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(0.5, -bulbSize/2, 0.94, 0)})
        local retractTween = TweenService:Create(stem, TweenInfo.new(0.9, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, baseWidth + 0.5, 0, targetLength * 0.25), BackgroundTransparency = 0.65})
        
        fallTween:Play() retractTween:Play() fallTween.Completed:Wait()
        if bulb then bulb:Destroy() end
        
        local splattersCount = math.random(4, 7)
        for i = 1, splattersCount do
            local pSize = math.random(2, 4)
            local particle = Instance.new("Frame")
            particle.Size = UDim2.new(0, pSize, 0, pSize)
            particle.Position = UDim2.new(startX, 0, 0.94, 0)
            particle.BackgroundColor3 = bloodColor
            particle.BorderSizePixel = 0
            local pc = Instance.new("UICorner") pc.CornerRadius = UDim.new(1, 0) pc.Parent = particle
            particle.Parent = RainContainer
            
            local spreadX = math.random(-30, 30) / 100
            local spreadY = math.random(-15, 2) / 100
            
            local scatterTween = TweenService:Create(particle, TweenInfo.new(math.random(20, 40) / 100, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Position = UDim2.new(startX + spreadX, 0, 0.94 + spreadY, 0), BackgroundTransparency = 1, Size = UDim2.new(0, pSize * 0.2, 0, pSize * 0.2)
            })
            scatterTween:Play() Debris:AddItem(particle, 0.45)
        end
        task.wait(0.9) 
        if dripGroup then dripGroup:Destroy() end
    end)
end

task.spawn(function() while true do task.wait(0.02) spawnRainDrop() end end)
task.spawn(function() while true do task.wait(math.random(0.6, 1.9)) task.spawn(spawnBloodDrip) end end)

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
local isLocked = false
local targetEntity = nil

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
    
    -- [[ MODIFIED PRIORITY TARGET INTERACTION PROFILE ]]
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
    
    -- Extract fallback base physics velocity
    local rawVelocity = corePart.AssemblyLinearVelocity or corePart.Velocity or Vector3.new()
    
    -- [[ SMOOTHED MOVEDIRECTION RESOLVER RECALCULATION ]]
    if getgenv().BleedSettings.ResolverActive and humanoid then
        if humanoid.MoveDirection.Magnitude > 0 then
            local moveIntentVelocity = humanoid.MoveDirection * (humanoid.WalkSpeed or 16)
            -- Blend the target's explicit walking direction intent with physics vectors 
            rawVelocity = rawVelocity:Lerp(moveIntentVelocity, 0.30)
        else
            -- If they stop moving keys, decay the velocity organically instead of dropping to 0 instantly
            rawVelocity = rawVelocity:Lerp(Vector3.new(0, rawVelocity.Y, 0), 0.25)
        end
        
        -- Filter vertical anti-aim/exploit jitters
        if math.abs(rawVelocity.Y) > 60 then
            rawVelocity = Vector3.new(rawVelocity.X, 0, rawVelocity.Z)
        end
    end
    
    -- [[ MASTER ANTI-SNAP DAMPENING BUFFER ]]
    if currentTrackedEntity ~= targetChar then
        currentTrackedEntity = targetChar
        trackedVelocity = rawVelocity
    else
        -- 0.22 weights the tracking perfectly between instant response and frame-rate independent smoothness
        trackedVelocity = trackedVelocity:Lerp(rawVelocity, 0.22)
    end
    
    local velocity = trackedVelocity
    local scaleX = getgenv().BleedSettings.PredictionX
    local scaleY = getgenv().BleedSettings.PredictionY
    
    local PredPos = currentPosition + (velocity * Vector3.new(scaleX, scaleY, scaleX))
    
    -- Airbone offsetting checks
    if humanoid and (humanoid.FloorMaterial == Enum.Material.Air or humanoid:GetState() == Enum.HumanoidStateType.Freefall or humanoid:GetState() == Enum.HumanoidStateType.Jumping) then
        local jumpOffset = tonumber(getgenv().BleedSettings.JumpOffset) or 0
        local fallOffset = tonumber(getgenv().BleedSettings.FallOffset) or 0
        if velocity.Y > 0 then PredPos = PredPos + Vector3.new(0, jumpOffset, 0) else PredPos = PredPos + Vector3.new(0, fallOffset, 0) end
    end
    
    -- [[ STRUCTURAL ANTI-GROUND SHOT RE-ROUTING RAYCASTER ]]
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

-- [[ BUTTON TRIGGERS ]]
TextButton.MouseButton1Click:Connect(function()
    if updatingTargetLock then return end
    isLocked = not isLocked
    if isLocked then
        targetEntity = getClosestTargetToCenter()
        if targetEntity then
            TextButton.TextSize = 13 
            TextButton.Text = "bleed on " .. string.upper(targetEntity.DisplayName)
            sendNotification("Locked on " .. targetEntity.DisplayName)
            playHitSound("Blood Burst") 
            UIStroke.Color = Color3.fromRGB(255, 255, 255)
            TweenService:Create(UIStroke, TweenInfo.new(0.3), {Color = getgenv().Colors.Accent}):Play()
        else
            TextButton.TextSize = 17 TextButton.Text = "Bleed.cc" isLocked = false
            sendNotification("No visible target")
        end
    else
        if targetEntity then sendNotification("Speared " .. targetEntity.DisplayName) end
        targetEntity = nil clearTargetESP() TextButton.TextSize = 17 TextButton.Text = "Bleed.cc"
    end
end)

-- [[ MASTER LOOP ]]
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

    if isLocked and targetEntity and not updatingTargetLock then
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

-- [[ METATABLE MOUNT ]]
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
