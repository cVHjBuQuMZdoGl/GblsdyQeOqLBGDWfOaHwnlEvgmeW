--// Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

--// State Variables
local AimbotEnabled = false
local ClosestPlayerEnabled = false
local ESPEnabled = false
local Max_ESP_Distance = 1000

local ChamFolder = Instance.new("Folder")
ChamFolder.Name = "Secure_Khizar_Chams"
ChamFolder.Parent = CoreGui

--// Dragging Functionality Helper
local function MakeDraggable(guiObject)
    local dragging, dragInput, dragStart, startPos
    guiObject.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = guiObject.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    guiObject.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            guiObject.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

--// ============================================================================
--// UI DESIGN
--// ============================================================================
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "KhizarRemoteSuite"
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 250, 0, 270)
MainFrame.Position = UDim2.new(0.5, -125, 0.4, -135)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
MainFrame.BorderSizePixel = 0

local MainUICorner = Instance.new("UICorner")
MainUICorner.CornerRadius = UDim.new(0, 10)
MainUICorner.Parent = MainFrame

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 45)
Title.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
Title.Text = "  KHIZAR REMOTE SUITE (S2)"
Title.TextColor3 = Color3.fromRGB(255, 60, 60)
Title.TextSize = 14
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = Title

MakeDraggable(MainFrame)

local function createButton(text, pos, callback)
    local btn = Instance.new("TextButton", MainFrame)
    btn.Size = UDim2.new(0, 210, 0, 35)
    btn.Position = pos
    btn.Text = text
    btn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = btn
    
    btn.MouseButton1Click:Connect(function() callback(btn) end)
    return btn
end

local createESP

local AimbotBtn = createButton("AIMBOT: OFF", UDim2.new(0, 20, 0, 65), function(btn)
    AimbotEnabled = not AimbotEnabled
    btn.Text = AimbotEnabled and "AIMBOT: ON" or "AIMBOT: OFF"
    btn.BackgroundColor3 = AimbotEnabled and Color3.fromRGB(40, 180, 40) or Color3.fromRGB(180, 40, 40)
end)

local ClosestBtn = createButton("CLOSEST LOCK: OFF", UDim2.new(0, 20, 0, 110), function(btn)
    ClosestPlayerEnabled = not ClosestPlayerEnabled
    btn.Text = ClosestPlayerEnabled and "CLOSEST LOCK: ON" or "CLOSEST LOCK: OFF"
    btn.BackgroundColor3 = ClosestPlayerEnabled and Color3.fromRGB(40, 180, 40) or Color3.fromRGB(180, 40, 40)
end)

local ESPBtn = createButton("PURE CHAMS: OFF", UDim2.new(0, 20, 0, 155), function(btn)
    ESPEnabled = not ESPEnabled
    btn.Text = ESPEnabled and "PURE CHAMS: ON" or "PURE CHAMS: OFF"
    btn.BackgroundColor3 = ESPEnabled and Color3.fromRGB(40, 180, 40) or Color3.fromRGB(180, 40, 40)
    
    if not ESPEnabled then 
        ChamFolder:ClearAllChildren() 
    else
        for _, p in pairs(Players:GetPlayers()) do task.spawn(createESP, p) end
    end
end)

local DistLabel = Instance.new("TextLabel", MainFrame)
DistLabel.Size = UDim2.new(0, 120, 0, 35)
DistLabel.Position = UDim2.new(0, 20, 0, 210)
DistLabel.BackgroundTransparency = 1
DistLabel.Text = "Chams Max Distance:"
DistLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
DistLabel.Font = Enum.Font.Gotham
DistLabel.TextSize = 11
DistLabel.TextXAlignment = Enum.TextXAlignment.Left

local DistanceInput = Instance.new("TextBox", MainFrame)
DistanceInput.Size = UDim2.new(0, 80, 0, 35)
DistanceInput.Position = UDim2.new(0, 150, 0, 210)
DistanceInput.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
DistanceInput.Text = tostring(Max_ESP_Distance)
DistanceInput.TextColor3 = Color3.fromRGB(255, 255, 255)
DistanceInput.Font = Enum.Font.GothamBold
DistanceInput.TextSize = 13
DistanceInput.BorderSizePixel = 0

local BoxCorner = Instance.new("UICorner")
BoxCorner.CornerRadius = UDim.new(0, 6)
BoxCorner.Parent = DistanceInput

DistanceInput.FocusLost:Connect(function()
    local num = tonumber(DistanceInput.Text)
    if num then Max_ESP_Distance = num else DistanceInput.Text = tostring(Max_ESP_Distance) end
end)

local FloatIcon = Instance.new("TextButton", ScreenGui)
FloatIcon.Name = "KhizarFloat"
FloatIcon.Size = UDim2.new(0, 65, 0, 65)
FloatIcon.Position = UDim2.new(0, 20, 0.5, -32)
FloatIcon.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
FloatIcon.Text = "Khizar"
FloatIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
FloatIcon.Font = Enum.Font.GothamBold
FloatIcon.TextSize = 14

local IconCorner = Instance.new("UICorner")
IconCorner.CornerRadius = UDim.new(1, 0)
IconCorner.Parent = FloatIcon

MakeDraggable(FloatIcon)
FloatIcon.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

--// ============================================================================
--// CHAMS LOGIC
--// ============================================================================
createESP = function(player)
    if player == LocalPlayer then return end

    local function ApplyHighlight()
        local character = player.Character or player.CharacterAdded:Wait()
        if not character then return end
        
        local existingCham = ChamFolder:FindFirstChild(player.Name .. "_Cham")
        if existingCham then existingCham:Destroy() end
        
        if not character:FindFirstChild("KhizarCham_Tag") then
            local tag = Instance.new("Folder", character)
            tag.Name = "KhizarCham_Tag"
            
            local highlight = Instance.new("Highlight")
            highlight.Name = player.Name .. "_Cham"
            highlight.FillColor = Color3.fromRGB(255, 60, 60)
            highlight.FillTransparency = 0.4
            highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
            highlight.Adornee = character
            highlight.Parent = ChamFolder

            local connection
            connection = RunService.RenderStepped:Connect(function()
                if not character:IsDescendantOf(workspace) or not ESPEnabled then
                    highlight:Destroy()
                    if tag then tag:Destroy() end
                    connection:Disconnect()
                    return
                end
                
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and character:FindFirstChild("HumanoidRootPart") then
                    local distance = (LocalPlayer.Character.HumanoidRootPart.Position - character.HumanoidRootPart.Position).Magnitude
                    highlight.Enabled = (distance <= Max_ESP_Distance)
                else
                    highlight.Enabled = false
                end
            end)
        end
    end
    player.CharacterAdded:Connect(ApplyHighlight)
    if player.Character then task.spawn(ApplyHighlight) end
end

Players.PlayerAdded:Connect(createESP)

--// ============================================================================
--// DISTANCE BASED TARGET FINDER
--// ============================================================================
local function getAbsoluteClosestPlayer()
    local closestPlayer = nil
    local shortestDistance = math.huge
    
    local myCharacter = LocalPlayer.Character
    if not myCharacter or not myCharacter:FindFirstChild("HumanoidRootPart") then return nil end
    local myPos = myCharacter.HumanoidRootPart.Position

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
            
            local targetPos = player.Character.HumanoidRootPart.Position
            local actualDistance = (targetPos - myPos).Magnitude
            
            if actualDistance < shortestDistance then
                closestPlayer = player
                shortestDistance = actualDistance
            end
        end
    end
    return closestPlayer
end

--// ============================================================================
--// FREEZE-FREE CAMERA CONTROLLER (No Custom Type Blocking)
--// ============================================================================
RunService.RenderStepped:Connect(function()
    -- Hamesha Camera Type Custom rakhein taake player controls freeze na hon
    if Camera.CameraType ~= Enum.CameraType.Custom then
        Camera.CameraType = Enum.CameraType.Custom
    end

    if AimbotEnabled then
        local target = getAbsoluteClosestPlayer()
        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            local targetHead = target.Character:FindFirstChild("Head") or target.Character.HumanoidRootPart
            local targetPos = targetHead.Position
            
            if ClosestPlayerEnabled then
                -- Direct Instant CFrame rotation (Hard Lock but player can walk freely)
                Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, targetPos)
            else
                -- Smooth Lerp (Soft Assist)
                Camera.CFrame = Camera.CFrame:Lerp(CFrame.lookAt(Camera.CFrame.Position, targetPos), 0.15)
            end
        end
    end
end)