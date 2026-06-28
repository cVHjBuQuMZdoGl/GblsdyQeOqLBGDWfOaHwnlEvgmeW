--// Services
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

--// ============================================================================
--// 1. NUCLEAR ANTI-CHEAT BYPASS LAYER (Season 2 Hardened)
--// ============================================================================
local function NuclearBypass()
    local _getrawmetatable = getrawmetatable or debug.getmetatable
    local _setreadonly = setreadonly or make_writeable
    local _checkcaller = checkcaller or function() return false end
    local _newcclosure = newcclosure or function(f) return f end
    
    if not _getrawmetatable then return end
    
    local mt = _getrawmetatable(game)
    local old_namecall = mt.__namecall
    local old_index = mt.__index
    local old_newindex = mt.__newindex
    
    _setreadonly(mt, false)
    
    mt.__namecall = _newcclosure(function(self, ...)
        if not _checkcaller() then
            local remote_name = tostring(self):lower()
            if remote_name:find("ban") or remote_name:find("kick") or remote_name:find("cheat") or remote_name:find("ac") or remote_name:find("detection") then
                return nil
            end
        end
        return old_namecall(self, ...)
    end)
    
    mt.__index = _newcclosure(function(self, key)
        if not _checkcaller() then
            if key == "CoreGui" or tostring(self) == "CoreGui" or key == "RobloxGui" then
                return nil
            end
        end
        return old_index(self, key)
    end)

    mt.__newindex = _newcclosure(function(self, key, value)
        if not _checkcaller() and (key == "__namecall" or key == "__index") then
            return nil
        end
        return old_newindex(self, key, value)
    end)
    
    _setreadonly(mt, true)
    
    if getfenv and setfenv then
        local safe_env = setmetatable({}, {
            __index = function(_, k)
                if k == "game" then return game end
                return getgenv()[k] or _G[k] or shared[k]
            end
        })
        setfenv(1, safe_env)
    end
end

pcall(NuclearBypass)

--// ============================================================================
--// 2. CONFIGURATION VARIABLES
--// ============================================================================
local ESP_Enabled = false
local Max_ESP_Distance = 1000 -- Default distance limit (studs)
local TargetFolder = Instance.new("Folder")
TargetFolder.Name = "Secure_Cham_Storage"
TargetFolder.Parent = CoreGui

--// Dragging Functionality Helper
local function MakeDraggable(guiObject)
    local dragging, dragInput, dragStart, startPos
    
    guiObject.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = guiObject.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    guiObject.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            guiObject.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

--// ============================================================================
--// 3. MODERN PREMIUM GUI CREATION
--// ============================================================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CircuitCham_Hub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

-- Main Panel
local MainPanel = Instance.new("Frame")
MainPanel.Name = "MainPanel"
MainPanel.Size = UDim2.new(0, 260, 0, 180)
MainPanel.Position = UDim2.new(0.5, -130, 0.4, -90)
MainPanel.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
MainPanel.BorderSizePixel = 0
MainPanel.Visible = true
MainPanel.Parent = ScreenGui

local MainUICorner = Instance.new("UICorner")
MainUICorner.CornerRadius = UDim.new(0, 10)
MainUICorner.Parent = MainPanel

-- Title Bar
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
Title.Text = "  AIRDROP ARENA CHAMS (S2)"
Title.TextColor3 = Color3.fromRGB(255, 60, 60)
Title.TextSize = 14
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = MainPanel

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = Title

MakeDraggable(MainPanel)

-- Toggle Button (ON / OFF)
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 220, 0, 35)
ToggleBtn.Position = UDim2.new(0, 20, 0, 60)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40) -- Starting Red (OFF)
ToggleBtn.Text = "CHAMS: DISABLED"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 14
ToggleBtn.Parent = MainPanel

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 6)
BtnCorner.Parent = ToggleBtn

-- Distance Label
local DistLabel = Instance.new("TextLabel")
DistLabel.Size = UDim2.new(0, 130, 0, 35)
DistLabel.Position = UDim2.new(0, 20, 0, 115)
DistLabel.BackgroundTransparency = 1
DistLabel.Text = "Max Distance (Studs):"
DistLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
DistLabel.Font = Enum.Font.Gotham
DistLabel.TextSize = 12
DistLabel.TextXAlignment = Enum.TextXAlignment.Left
DistLabel.Parent = MainPanel

-- Distance Input Box
local DistanceInput = Instance.new("TextBox")
DistanceInput.Size = UDim2.new(0, 80, 0, 35)
DistanceInput.Position = UDim2.new(0, 160, 0, 115)
DistanceInput.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
DistanceInput.Text = tostring(Max_ESP_Distance)
DistanceInput.TextColor3 = Color3.fromRGB(255, 255, 255)
DistanceInput.Font = Enum.Font.GothamBold
DistanceInput.TextSize = 14
DistanceInput.BorderSizePixel = 0
DistanceInput.Parent = MainPanel

local BoxCorner = Instance.new("UICorner")
BoxCorner.CornerRadius = UDim.new(0, 6)
BoxCorner.Parent = DistanceInput

--// ============================================================================
--// 4. FLOATING LOGO ICON (DRAGGABLE & TOGGLE VISIBILITY)
--// ============================================================================
local FloatIcon = Instance.new("TextButton")
FloatIcon.Name = "FloatIcon"
FloatIcon.Size = UDim2.new(0, 50, 0, 50)
FloatIcon.Position = UDim2.new(0, 15, 0.5, -25)
FloatIcon.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
FloatIcon.Text = "CHAM"
FloatIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
FloatIcon.Font = Enum.Font.GothamBold
FloatIcon.TextSize = 14
FloatIcon.Parent = ScreenGui

local IconCorner = Instance.new("UICorner")
IconCorner.CornerRadius = UDim.new(1, 0)
IconCorner.Parent = FloatIcon

local IconStroke = Instance.new("UIStroke")
IconStroke.Thickness = 2
IconStroke.Color = Color3.fromRGB(255, 255, 255)
IconStroke.Parent = FloatIcon

MakeDraggable(FloatIcon)

FloatIcon.MouseButton1Click:Connect(function()
    MainPanel.Visible = not MainPanel.Visible
end)

DistanceInput.FocusLost:Connect(function(enterPressed)
    local num = tonumber(DistanceInput.Text)
    if num then
        Max_ESP_Distance = num
    else
        DistanceInput.Text = tostring(Max_ESP_Distance)
    end
end)

--// ============================================================================
--// 5. SECURE PURE CHAMS FUNCTIONALITY (NO NAMES, NO DISTANCE TEXT)
--// ============================================================================
local function CreateChams(player)
    if player == LocalPlayer then return end

    local function ApplyHighlight()
        local character = player.Character or player.CharacterAdded:Wait()
        
        if character and not character:FindFirstChild("SecureCham_Tag") then
            -- Create Hidden Tag to mark player
            local tagFolder = Instance.new("Folder")
            tagFolder.Name = "SecureCham_Tag"
            tagFolder.Parent = character
            
            -- Pure Chams Effect (Only Highlight, No BillboardGuis)
            local highlight = Instance.new("Highlight")
            highlight.Name = "ESP_Cham"
            highlight.FillColor = Color3.fromRGB(255, 60, 60) -- Neon Red Cham
            highlight.FillTransparency = 0.4 -- Kitna solid chamkega (0 = poora solid, 1 = transparent)
            highlight.OutlineColor = Color3.fromRGB(255, 255, 255) -- White border line
            highlight.OutlineTransparency = 0
            highlight.Adornee = character
            highlight.Parent = TargetFolder

            -- Distance Check Loop
            local connection
            connection = RunService.RenderStepped:Connect(function()
                if not character:IsDescendantOf(workspace) or not ESP_Enabled then
                    highlight:Destroy()
                    if tagFolder then tagFolder:Destroy() end
                    connection:Disconnect()
                    return
                end
                
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and character:FindFirstChild("HumanoidRootPart") then
                    local distance = (LocalPlayer.Character.HumanoidRootPart.Position - character.HumanoidRootPart.Position).Magnitude
                    
                    -- Distance ke andar hoga toh chamkega, warna band ho jayega
                    if distance <= Max_ESP_Distance then
                        highlight.Enabled = true
                    else
                        highlight.Enabled = false
                    end
                else
                    highlight.Enabled = false
                end
            end)
        end
    end
    
    player.CharacterAdded:Connect(ApplyHighlight)
    if player.Character then task.spawn(ApplyHighlight) end
end

-- Toggle Trigger Logic
ToggleBtn.MouseButton1Click:Connect(function()
    ESP_Enabled = not ESP_Enabled
    if ESP_Enabled then
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 180, 40) -- Green
        ToggleBtn.Text = "CHAMS: ENABLED"
        
        for _, p in pairs(Players:GetPlayers()) do
            task.spawn(CreateChams, p)
        end
    else
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40) -- Red
        ToggleBtn.Text = "CHAMS: DISABLED"
        TargetFolder:ClearAllChildren()
    end
end)

-- Handle New Players Joining
Players.PlayerAdded:Connect(function(player)
    if ESP_Enabled then
        CreateChams(player)
    end
end)

-- Cleanup on leave
Players.PlayerRemoving:Connect(function(player)
    if player.Character and player.Character:FindFirstChild("SecureCham_Tag") then
        player.Character.SecureCham_Tag:Destroy()
    end
end)