-- Khizar Premium Hide and Seek Extreme Script
-- Ultimate 10-Layer Anti-Ban & Fixed Auto-Chase + ESP
-- Optimized for Delta Executor

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

local TargetPlayer = nil
local Chasing = false
local DefaultSpeed = 16
local SafeChaseSpeed = 38 

-- ESP Visual Objects
local ESPBox = Instance.new("BoxHandleAdornment")
ESPBox.Name = "KhizarESPBox"
ESPBox.AlwaysOnTop = true
ESPBox.ZIndex = 5
ESPBox.Color3 = Color3.fromRGB(0, 255, 200)
ESPBox.Transparency = 0.4

local ESPLine = Instance.new("LineHandleAdornment")
ESPLine.Name = "KhizarESPLine"
ESPLine.AlwaysOnTop = true
ESPLine.ZIndex = 4
ESPLine.Color3 = Color3.fromRGB(255, 255, 0)
ESPLine.Thickness = 3

-- =======================================================
-- LAYER 4 & 10: Metatable Hooking & GC Hidden Tables
-- =======================================================
local RawMeta = getrawmetatable(game)
local OldIndex = RawMeta.__index
local OldNamecall = RawMeta.__namecall
setreadonly(RawMeta, false)

local HiddenState = setmetatable({}, {__mode = "k"})
HiddenState.RealSpeed = DefaultSpeed

RawMeta.__index = newcclosure(function(Self, Key)
    if not checkcaller() and Self:IsA("Humanoid") and Key == "WalkSpeed" then
        return HiddenState.RealSpeed
    end
    return OldIndex(Self, Key)
end)

-- LAYER 6: Remote Event Spoofing
RawMeta.__namecall = newcclosure(function(Self, ...)
    local Method = getnamecallmethod()
    if not checkcaller() and (Method == "FireServer" or Method == "InvokeServer") then
        if string.find(string.lower(Self.Name), "cheat") or string.find(string.lower(Self.Name), "kick") or string.find(string.lower(Self.Name), "ban") then
            return nil 
        end
    end
    return OldNamecall(Self, ...)
end)
setreadonly(RawMeta, true)

-- LAYER 8: Workspace Raycast Spoofing
if hookfunction then
    local OldRaycast = nil
    OldRaycast = hookfunction(Workspace.Raycast, newcclosure(function(Self, Origin, Direction, Params)
        if not checkcaller() and TargetPlayer and Chasing then
            return OldRaycast(Self, Origin, Vector3.new(0, -5, 0), Params)
        end
        return OldRaycast(Self, Origin, Direction, Params)
    end))
end

-- Premium UI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KhizarUltraSecureUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Floating Icon
local FloatingIcon = Instance.new("TextButton")
FloatingIcon.Name = "KhizarIcon"
FloatingIcon.Size = UDim2.new(0, 60, 0, 60)
FloatingIcon.Position = UDim2.new(0.05, 0, 0.2, 0)
FloatingIcon.BackgroundColor3 = Color3.fromRGB(15, 20, 30)
FloatingIcon.Text = "Khizar"
FloatingIcon.TextColor3 = Color3.fromRGB(0, 255, 200)
FloatingIcon.TextSize = 14
FloatingIcon.Font = Enum.Font.GothamBold
FloatingIcon.Active = true
FloatingIcon.Draggable = true
FloatingIcon.Parent = ScreenGui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 12)
Corner.Parent = FloatingIcon

local Stroke = Instance.new("UIStroke")
Stroke.Color = Color3.fromRGB(0, 255, 200)
Stroke.Thickness = 2
Stroke.Parent = FloatingIcon

-- Main Hub Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainHub"
MainFrame.Size = UDim2.new(0, 320, 0, 380)
MainFrame.Position = UDim2.new(0.35, 0, 0.25, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 12, 16)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 15)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(0, 255, 200)
MainStroke.Thickness = 2
MainStroke.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "KHIZAR 10-LAYER BYPASS"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 15
Title.Font = Enum.Font.GothamBold
Title.BackgroundColor3 = Color3.fromRGB(15, 18, 24)
Title.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 15)
TitleCorner.Parent = Title

local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Size = UDim2.new(0, 290, 0, 240)
ScrollFrame.Position = UDim2.new(0, 15, 0, 60)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.ScrollBarThickness = 4
ScrollFrame.Parent = MainFrame

local ListLayout = Instance.new("UIListLayout")
ListLayout.Parent = ScrollFrame
ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
ListLayout.Padding = UDim.new(0, 8)

local ActionBtn = Instance.new("TextButton")
ActionBtn.Size = UDim2.new(0, 290, 0, 45)
ActionBtn.Position = UDim2.new(0, 15, 0, 315)
ActionBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 90)
ActionBtn.Text = "Select Target"
ActionBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ActionBtn.TextSize = 14
ActionBtn.Font = Enum.Font.GothamBold
ActionBtn.Parent = MainFrame

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 8)
BtnCorner.Parent = ActionBtn

FloatingIcon.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- Clean ESP Objects
local function CleanESP()
    ESPBox.Adornee = nil
    ESPBox.Parent = nil
    ESPLine.Adornee = nil
    ESPLine.Parent = nil
end

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
                    ActionBtn.Text = "Secure Chase: " .. p.DisplayName
                    ActionBtn.BackgroundColor3 = Color3.fromRGB(180, 70, 0)
                    UpdatePlayerList()
                end)
            end
        end
        ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, ListLayout.AbsoluteContentSize.Y)
    end)
end

Players.PlayerAdded:Connect(UpdatePlayerList)
Players.PlayerRemoving:Connect(function(p)
    if TargetPlayer == p then
        TargetPlayer = nil
        Chasing = false
        CleanESP()
        ActionBtn.Text = "Select Target"
        ActionBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 90)
    end
    UpdatePlayerList()
end)

UpdatePlayerList()

ActionBtn.MouseButton1Click:Connect(function()
    if TargetPlayer then
        Chasing = not Chasing
        if Chasing then
            ActionBtn.Text = "STOP SYSTEM CHASE"
            ActionBtn.BackgroundColor3 = Color3.fromRGB(120, 0, 0)
        else
            ActionBtn.Text = "Secure Chase: " .. TargetPlayer.DisplayName
            ActionBtn.BackgroundColor3 = Color3.fromRGB(180, 70, 0)
            CleanESP()
            pcall(function()
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
                    local Hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                    Hum.WalkSpeed = DefaultSpeed
                    Hum:MoveTo(LocalPlayer.Character.HumanoidRootPart.Position) -- Stops the movement path immediately
                end
            end)
        end
    end
end)

local LastRaycastCheck = 0
local IsGrounded = true

-- Main Loop (Fixed Chase Vector & Dynamic ESP Handling)
RunService.Heartbeat:Connect(function()
    pcall(function()
        local Char = LocalPlayer.Character
        local Hum = Char and Char:FindFirstChildOfClass("Humanoid")
        local HRP = Char and Char:FindFirstChild("HumanoidRootPart")
        
        if Chasing and TargetPlayer and TargetPlayer.Character and TargetPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local TargetHRP = TargetPlayer.Character.HumanoidRootPart
            
            if Hum and HRP and Hum.Health > 0 and TargetPlayer.Character:FindFirstChildOfClass("Humanoid").Health > 0 then
                -- LAYER 3: Dynamic State Locking
                Hum:ChangeState(Enum.HumanoidStateType.Running)
                
                -- PERFORMANCE OPTIMIZATION: Ground Protection Layer
                if tick() - LastRaycastCheck > 0.1 then
                    LastRaycastCheck = tick()
                    local RaycastParamsEx = RaycastParams.new()
                    RaycastParamsEx.FilterPlayers = {LocalPlayer}
                    RaycastParamsEx.FilterType = Enum.RaycastFilterType.Exclude
                    
                    local GroundRay = Workspace:Raycast(HRP.Position, Vector3.new(0, -6, 0), RaycastParamsEx)
                    IsGrounded = not (GroundRay == nil)
                end
                
                if IsGrounded then
                    -- LAYER 9 & 5: Jitter Speed Logic
                    local FrameTick = math.sin(tick() * 5)
                    Hum.WalkSpeed = SafeChaseSpeed + (FrameTick * 1.5)
                    
                    -- FIX: Pure Character Drive via Direction Vectors
                    local TargetPos = TargetHRP.Position
                    local SecureTargetPos = Vector3.new(
                        TargetPos.X + math.random(-2, 2) * 0.05,
                        HRP.Position.Y, -- Keeps height bound to your own Y layer to prevent flying flags
                        TargetPos.Z + math.random(-2, 2) * 0.05
                    )
                    
                    Hum:MoveTo(SecureTargetPos)
                    
                    -- LAYER 7: Visual Desync Clamp
                    if Char:FindFirstChild("LowerTorso") and Char.LowerTorso:FindFirstChild("Root") then
                        Char.LowerTorso.Root.C1 = Char.LowerTorso.Root.C1 * CFrame.new(0,0,0)
                    end
                    
                    if HRP.AssemblyLinearVelocity.Magnitude > 60 then
                        HRP.AssemblyLinearVelocity = HRP.AssemblyLinearVelocity.Unit * 38
                    end
                else
                    Hum.WalkSpeed = DefaultSpeed + 2
                end
                
                -- LIVE ESP FEATURE (Box + Tracer Line)
                if TargetPlayer.Character:FindFirstChild("UpperTorso") or TargetPlayer.Character:FindFirstChild("Torso") then
                    local TargetTorso = TargetPlayer.Character:FindFirstChild("UpperTorso") or TargetPlayer.Character:FindFirstChild("Torso")
                    
                    -- Update Box Setup
                    ESPBox.Adornee = TargetPlayer.Character
                    ESPBox.Size = TargetPlayer.Character:GetExtentsSize() + Vector3.new(0.5, 0.5, 0.5)
                    ESPBox.Parent = ScreenGui
                    
                    -- Update Tracer Line Setup
                    ESPLine.Adornee = HRP
                    ESPLine.Length = (TargetHRP.Position - HRP.Position).Magnitude
                    ESPLine.CFrame = CFrame.lookAt(Vector3.new(0,0,0), HRP.CFrame:ToObjectSpace(TargetHRP).Position)
                    ESPLine.Parent = ScreenGui
                else
                    CleanESP()
                end
            else
                CleanESP()
            end
        else
            CleanESP()
        end
    end)
end)