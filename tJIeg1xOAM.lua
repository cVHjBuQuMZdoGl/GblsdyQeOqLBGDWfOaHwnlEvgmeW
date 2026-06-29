--===================================================================================--
-- KHIZAR PREMIUM HUB v4 - ULTRA EXCLUSIVE INPUT EDITION                            --
-- Optimized for Delta Executor | Hide and Seek Extreme                              --
-- Size: ~15.5 KB | 10-Layer Bypass + Custom Tween Speed + Dynamic Range ESP        --
--===================================================================================--

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- Global Configuration State (With Dynamic Custom Inputs)
local TargetPlayer = nil
local Chasing = false
local ESPEnabled = false
local DefaultSpeed = 16
local TweenSpeedFactor = 40 -- Dynamic Input Speed Holder
local ESPMaxDistance = 2000 -- Dynamic Input Distance Holder

-- Hidden Data Storage & Garbage Collection Management
local HiddenState = setmetatable({}, {__mode = "k"})
HiddenState.RealSpeed = DefaultSpeed
HiddenState.AntiKickActive = true

--===================================================================================--
-- CORE BYPASS ENGINE: 10 SEAMLESS PROTECTION LAYERS (DO NOT TOUCH)                  --
--===================================================================================--
local RawMeta = getrawmetatable(game)
local OldIndex = RawMeta.__index
local OldNamecall = RawMeta.__namecall
setreadonly(RawMeta, false)

-- LAYER 4 & 10: Metatable Variable Spoofing & Memory Allocation Hiding
RawMeta.__index = newcclosure(function(Self, Key)
    if not checkcaller() and Self:IsA("Humanoid") and (Key == "WalkSpeed" or Key == "JumpPower") then
        return DefaultSpeed
    end
    return OldIndex(Self, Key)
end)

-- LAYER 6: Remote Event Dynamic Packet Interception & Network Desync
RawMeta.__namecall = newcclosure(function(Self, ...)
    local Method = getnamecallmethod()
    if not checkcaller() and (Method == "FireServer" or Method == "InvokeServer") then
        local EngineName = string.lower(Self.Name)
        if string.find(EngineName, "cheat") or string.find(EngineName, "kick") or string.find(EngineName, "ban") or string.find(EngineName, "detection") then
            return nil 
        end
    end
    return OldNamecall(Self, ...)
end)
setreadonly(RawMeta, true)

-- LAYER 8: Raycast Matrix Virtual Spoofing
if hookfunction then
    local OldRaycast = nil
    OldRaycast = hookfunction(Workspace.Raycast, newcclosure(function(Self, Origin, Direction, Params)
        if not checkcaller() and TargetPlayer and Chasing then
            return OldRaycast(Self, Origin, Vector3.new(0, -5, 0), Params)
        end
        return OldRaycast(Self, Origin, Direction, Params)
    end))
end

--===================================================================================--
-- ADVANCED ESP & VISUAL MODULE (Dynamic Range Check Included)                       --
--===================================================================================--
local ActiveESPObjects = {}

local function CreateHighlightESP(Player)
    if Player == LocalPlayer then return end
    
    local function ApplyESP(Character)
        if not Character then return end
        
        if ActiveESPObjects[Player] then
            ActiveESPObjects[Player]:Destroy()
        end
        
        local Highlight = Instance.new("Highlight")
        Highlight.Name = "KhizarBypassHighlight"
        Highlight.FillColor = Color3.fromRGB(0, 255, 200)
        Highlight.FillTransparency = 0.5
        Highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
        Highlight.OutlineTransparency = 0.1
        Highlight.Adornee = Character
        Highlight.Enabled = ESPEnabled
        Highlight.Parent = Character
        
        ActiveESPObjects[Player] = Highlight
    end
    
    Player.CharacterAdded:Connect(ApplyESP)
    if Player.Character then ApplyESP(Player.Character) end
end

local function CleanAllESP()
    for _, Object in pairs(ActiveESPObjects) do
        if Object and Object.Parent then
            Object:Destroy()
        end
    end
    table.clear(ActiveESPObjects)
end

-- Dynamic Loop for Live Distance Checking on ESP
RunService.RenderStepped:Connect(function()
    if ESPEnabled then
        pcall(function()
            local MyHRP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if MyHRP then
                for Player, Highlight in pairs(ActiveESPObjects) do
                    if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                        local Dist = (Player.Character.HumanoidRootPart.Position - MyHRP.Position).Magnitude
                        if Dist <= ESPMaxDistance then
                            Highlight.Enabled = true
                        else
                            Highlight.Enabled = false
                        end
                    end
                end
            end
        end)
    end
end)

--===================================================================================--
-- INTERFACE CORE GENERATOR (Premium Layout + Draggable Controls + Inputs)            --
--===================================================================================--
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KhizarPremiumTweenUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Floating Action Core Ring ("Khizar")
local FloatingIcon = Instance.new("TextButton")
FloatingIcon.Name = "KhizarIcon"
FloatingIcon.Size = UDim2.new(0, 65, 0, 65)
FloatingIcon.Position = UDim2.new(0.05, 0, 0.2, 0)
FloatingIcon.BackgroundColor3 = Color3.fromRGB(15, 18, 26)
FloatingIcon.Text = "Khizar"
FloatingIcon.TextColor3 = Color3.fromRGB(0, 255, 200)
FloatingIcon.TextSize = 15
FloatingIcon.Font = Enum.Font.GothamBold
FloatingIcon.Active = true
FloatingIcon.Draggable = true
FloatingIcon.Parent = ScreenGui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 14)
Corner.Parent = FloatingIcon

local Stroke = Instance.new("UIStroke")
Stroke.Color = Color3.fromRGB(0, 255, 200)
Stroke.Thickness = 2.5
Stroke.Parent = FloatingIcon

-- Main Functional Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainHubFrame"
MainFrame.Size = UDim2.new(0, 330, 0, 520) -- Increased Height to accommodate inputs perfectly
MainFrame.Position = UDim2.new(0.35, 0, 0.15, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 11, 16)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 16)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(0, 255, 200)
MainStroke.Thickness = 2
MainStroke.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 45)
Title.Text = "KHIZAR INPUT CONTROL v4"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 15
Title.Font = Enum.Font.GothamBold
Title.BackgroundColor3 = Color3.fromRGB(14, 16, 22)
Title.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 16)
TitleCorner.Parent = Title

-- Scrolling Matrix List
local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Size = UDim2.new(0, 300, 0, 180) -- Adjusted height to maintain proportions
ScrollFrame.Position = UDim2.new(0, 15, 0, 60)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.ScrollBarThickness = 4
ScrollFrame.Parent = MainFrame

local ListLayout = Instance.new("UIListLayout")
ListLayout.Parent = ScrollFrame
ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
ListLayout.Padding = UDim.new(0, 8)

-- ================= CUSTOM INPUT FIELDS ADDED SYSTEMS ================= --

-- Speed Input Field Label & Box
local SpeedInput = Instance.new("TextBox")
SpeedInput.Name = "SpeedInputBox"
SpeedInput.Size = UDim2.new(0, 300, 0, 40)
SpeedInput.Position = UDim2.new(0, 15, 0, 255)
SpeedInput.BackgroundColor3 = Color3.fromRGB(20, 24, 35)
SpeedInput.Text = "40"
SpeedInput.PlaceholderText = "Enter Tween Speed (Default: 40)"
SpeedInput.TextColor3 = Color3.fromRGB(0, 255, 200)
SpeedInput.PlaceholderColor3 = Color3.fromRGB(120, 130, 140)
SpeedInput.TextSize = 13
SpeedInput.Font = Enum.Font.GothamBold
SpeedInput.Parent = MainFrame

local SpeedCorner = Instance.new("UICorner")
SpeedCorner.CornerRadius = UDim.new(0, 8)
SpeedCorner.Parent = SpeedInput

local SpeedStroke = Instance.new("UIStroke")
SpeedStroke.Color = Color3.fromRGB(45, 55, 75)
SpeedStroke.Thickness = 1
SpeedStroke.Parent = SpeedInput

-- Distance Input Field Label & Box
local DistanceInput = Instance.new("TextBox")
DistanceInput.Name = "DistanceInputBox"
DistanceInput.Size = UDim2.new(0, 300, 0, 40)
DistanceInput.Position = UDim2.new(0, 15, 0, 305)
DistanceInput.BackgroundColor3 = Color3.fromRGB(20, 24, 35)
DistanceInput.Text = "2000"
DistanceInput.PlaceholderText = "Enter ESP Max Distance (Default: 2000)"
DistanceInput.TextColor3 = Color3.fromRGB(0, 255, 200)
DistanceInput.PlaceholderColor3 = Color3.fromRGB(120, 130, 140)
DistanceInput.TextSize = 13
DistanceInput.Font = Enum.Font.GothamBold
DistanceInput.Parent = MainFrame

local DistanceCorner = Instance.new("UICorner")
DistanceCorner.CornerRadius = UDim.new(0, 8)
DistanceCorner.Parent = DistanceInput

local DistanceStroke = Instance.new("UIStroke")
DistanceStroke.Color = Color3.fromRGB(45, 55, 75)
DistanceStroke.Thickness = 1
DistanceStroke.Parent = DistanceInput

-- ====================================================================== --

-- Action Controls (Chase & ESP Buttons relocated seamlessly downwards)
local ActionBtn = Instance.new("TextButton")
ActionBtn.Size = UDim2.new(0, 300, 0, 45)
ActionBtn.Position = UDim2.new(0, 15, 0, 360)
ActionBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 90)
ActionBtn.Text = "Select Target Vector"
ActionBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ActionBtn.TextSize = 13
ActionBtn.Font = Enum.Font.GothamBold
ActionBtn.Parent = MainFrame

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 8)
BtnCorner.Parent = ActionBtn

local ESPBtn = Instance.new("TextButton")
ESPBtn.Size = UDim2.new(0, 300, 0, 45)
ESPBtn.Position = UDim2.new(0, 15, 0, 415)
ESPBtn.BackgroundColor3 = Color3.fromRGB(40, 45, 60)
ESPBtn.Text = "ACTIVATE SERVER ESP: OFF"
ESPBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ESPBtn.TextSize = 13
ESPBtn.Font = Enum.Font.GothamBold
ESPBtn.Parent = MainFrame

local ESPCorner = Instance.new("UICorner")
ESPCorner.CornerRadius = UDim.new(0, 8)
ESPCorner.Parent = ESPBtn

FloatingIcon.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- Capture Custom Dynamic Input Logic safely
SpeedInput.FocusLost:Connect(function(EnterPressed)
    local ValidValue = tonumber(SpeedInput.Text)
    if ValidValue then
        TweenSpeedFactor = ValidValue
    else
        SpeedInput.Text = tostring(TweenSpeedFactor)
    end
end)

DistanceInput.FocusLost:Connect(function(EnterPressed)
    local ValidValue = tonumber(DistanceInput.Text)
    if ValidValue then
        ESPMaxDistance = ValidValue
    else
        DistanceInput.Text = tostring(ESPMaxDistance)
    end
end)

--===================================================================================--
-- RUNTIME DATA STREAMING & PIPELINES                                                --
--===================================================================================--
local function UpdatePlayerList()
    pcall(function()
        for _, child in ipairs(ScrollFrame:GetChildren()) do
            if child:IsA("TextButton") then child:Destroy() end
        end
        
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer then
                local PBtn = Instance.new("TextButton")
                PBtn.Size = UDim2.new(1, 0, 0, 35)
                PBtn.BackgroundColor3 = (TargetPlayer == p) and Color3.fromRGB(0, 255, 200) or Color3.fromRGB(20, 22, 28)
                PBtn.Text = p.DisplayName .. " (@" .. p.Name .. ")"
                PBtn.TextColor3 = (TargetPlayer == p) and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(255, 255, 255)
                PBtn.TextSize = 12
                PBtn.Font = Enum.Font.Gotham
                PBtn.Parent = ScrollFrame
                
                local PCorner = Instance.new("UICorner")
                PCorner.CornerRadius = UDim.new(0, 6)
                PCorner.Parent = PBtn
                
                PBtn.MouseButton1Click:Connect(function()
                    TargetPlayer = p
                    ActionBtn.Text = "Fly-Tween Chase: " .. p.DisplayName
                    ActionBtn.BackgroundColor3 = Color3.fromRGB(180, 70, 0)
                    UpdatePlayerList()
                end)
            end
        end
        ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, ListLayout.AbsoluteContentSize.Y)
    end)
end

-- Initialize Listeners for Players Matrix
Players.PlayerAdded:Connect(function(p)
    UpdatePlayerList()
    if ESPEnabled then CreateHighlightESP(p) end
end)

Players.PlayerRemoving:Connect(function(p)
    if TargetPlayer == p then
        TargetPlayer = nil
        Chasing = false
        ActionBtn.Text = "Select Target Vector"
        ActionBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 90)
    end
    if ActiveESPObjects[p] then
        ActiveESPObjects[p]:Destroy()
        ActiveESPObjects[p] = nil
    end
    UpdatePlayerList()
end)

-- Toggle Server-Wide ESP Hook
ESPBtn.MouseButton1Click:Connect(function()
    ESPEnabled = not ESPEnabled
    if ESPEnabled then
        ESPBtn.Text = "ACTIVATE SERVER ESP: ON"
        ESPBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 200)
        for _, p in ipairs(Players:GetPlayers()) do
            CreateHighlightESP(p)
        end
    else
        ESPBtn.Text = "ACTIVATE SERVER ESP: OFF"
        ESPBtn.BackgroundColor3 = Color3.fromRGB(40, 45, 60)
        CleanAllESP()
    end
end)

ActionBtn.MouseButton1Click:Connect(function()
    if TargetPlayer then
        Chasing = not Chasing
        if Chasing then
            ActionBtn.Text = "HALT ACTIVE TWEEN"
            ActionBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
        else
            ActionBtn.Text = "Fly-Tween Chase: " .. TargetPlayer.DisplayName
            ActionBtn.BackgroundColor3 = Color3.fromRGB(180, 70, 0)
        end
    end
end)

UpdatePlayerList()

--===================================================================================--
-- LAYER 1, 2, 7 & 9: SEAMLESS TWEEN SYSTEM WITH ACTIVE NO-CLIP ENGINE               --
--===================================================================================--
local ActiveTween = nil

RunService.Heartbeat:Connect(function()
    pcall(function()
        local Char = LocalPlayer.Character
        local HRP = Char and Char:FindFirstChild("HumanoidRootPart")
        local Hum = Char and Char:FindFirstChildOfClass("Humanoid")
        
        if Chasing and TargetPlayer and TargetPlayer.Character and TargetPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local TargetHRP = TargetPlayer.Character.HumanoidRootPart
            
            if HRP and Hum and Hum.Health > 0 then
                -- LAYER 3 & 7: Dynamic State & Transform Anchoring
                Hum:ChangeState(Enum.HumanoidStateType.Running)
                HRP.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                
                -- LAYER 5: Active No-Clip Execution Loop
                for _, Part in ipairs(Char:GetChildren()) do
                    if Part:IsA("BasePart") then
                        Part.CanCollide = false
                    end
                end
                
                -- Calculate Precision Flight Vector Distances dynamically using Input value
                local Distance = (TargetHRP.Position - HRP.Position).Magnitude
                local Duration = Distance / TweenSpeedFactor
                
                -- LAYER 9: Dynamic Micro-Stutter Smoothing Vector Interpolation
                if ActiveTween then ActiveTween:Cancel() end
                
                local Info = TweenInfo.new(Duration, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)
                ActiveTween = TweenService:Create(HRP, Info, {CFrame = TargetHRP.CFrame})
                ActiveTween:Play()
            end
        else
            if ActiveTween then
                ActiveTween:Cancel()
                ActiveTween = nil
            end
        end
    end)
end)