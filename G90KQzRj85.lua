local vu1 = game:GetService("Players")
local vu2 = vu1.LocalPlayer
local vu3 = workspace.CurrentCamera
local v4 = game:GetService("RunService")
local vu5 = game:GetService("UserInputService")
local vu6 = game:GetService("HttpService")
local v7 = game:GetService("ContentProvider")
local vu8 = vu2:WaitForChild("PlayerGui", 30):FindFirstChild("TriggerbotData")
if not vu8 then
    vu8 = Instance.new("Folder")
    vu8.Name = "TriggerbotData"
    vu8.Parent = vu2.PlayerGui
end
local function vu13(p9)
    local v10, v11 = pcall(vu6.JSONEncode, vu6, p9)
    if v10 then
        local v12 = vu8:FindFirstChild("ConfigJson") or Instance.new("StringValue")
        v12.Name = "ConfigJson"
        v12.Parent = vu8
        v12.Value = v11
    end
end
local vu14 = {
    Enabled = false,
    Delay = 0.03,
    Prediction = 0,
    Keybind = "",
    Checks = {
        KnifeCheck = false,
        ForcefieldCheck = false,
        KnockedCheck = false,
        AmmoCheck = false
    }
}
local v18 = (function()
    local v15 = vu8:FindFirstChild("ConfigJson")
    if v15 and v15.Value ~= "" then
        local v16, v17 = pcall(vu6.JSONDecode, vu6, v15.Value)
        if v16 and type(v17) == "table" then
            return v17
        end
    end
    return nil
end)()
if v18 then
    local v19, v20, v21 = pairs(v18)
    while true do
        local v22
        v21, v22 = v19(v20, v21)
        if v21 == nil then
            break
        end
        if vu14[v21] ~= nil and typeof(v22) == typeof(vu14[v21]) then
            vu14[v21] = v22
        end
    end
end
local function v32(pu23)
    local vu24 = nil
    local vu25 = nil
    local vu26 = nil
    local vu27 = nil
    pu23.InputBegan:Connect(function(pu28)
        if pu28.UserInputType == Enum.UserInputType.MouseButton1 or pu28.UserInputType == Enum.UserInputType.Touch then
            vu25 = true
            vu27 = pu28.Position
            vu24 = pu23.Position
            pu28.Changed:Connect(function()
                if pu28.UserInputState == Enum.UserInputState.End then
                    vu25 = false
                end
            end)
        end
    end)
    pu23.InputChanged:Connect(function(p29)
        if p29.UserInputType == Enum.UserInputType.MouseMovement or p29.UserInputType == Enum.UserInputType.Touch then
            vu26 = p29
        end
    end)
    vu5.InputChanged:Connect(function(p30)
        if p30 == vu26 and vu25 then
            local v31 = p30.Position - vu27
            pu23.Position = UDim2.new(vu24.X.Scale, vu24.X.Offset + v31.X, vu24.Y.Scale, vu24.Y.Offset + v31.Y)
        end
    end)
end
local function v36(p33, p34)
    local v35 = Instance.new("UICorner")
    v35.CornerRadius = UDim.new(0, p34)
    v35.Parent = p33
end
local function v41(p37, p38, p39)
    local v40 = Instance.new("UIStroke")
    v40.Color = p38
    v40.Thickness = p39 or 2
    v40.Transparency = 0.3
    v40.Parent = p37
end
local v42 = Instance.new("ScreenGui")
v42.Name = "TriggerbotGUI"
v42.ResetOnSpawn = false
v42.Parent = vu2:WaitForChild("PlayerGui", 30)
local v43 = Instance.new("TextButton", v42)
v43.Size = UDim2.new(0, 50, 0, 50)
v43.Position = UDim2.new(0.05, 0, 0.4, 0)
v43.BackgroundColor3 = Color3.new(0, 0, 0)
v43.BackgroundTransparency = 1
v43.Text = ""
v43.ZIndex = 1
v43.Active = true
v36(v43, 12)
v32(v43)
local v44 = Instance.new("ImageLabel", v43)
v44.Size = UDim2.new(0, 160, 0, 160)
v44.AnchorPoint = Vector2.new(0.5, 0.5)
v44.Position = UDim2.new(0.5, 0, 0.5, 0)
v44.BackgroundTransparency = 1
v44.Image = "rbxthumb://type=Asset&id=81227241386663&w=420&h=420"
v44.ScaleType = Enum.ScaleType.Fit
v44.ZIndex = 2
v7:PreloadAsync({
    v44.Image
})
v36(v44, 12)
local vu45 = Instance.new("Frame", v42)
vu45.Size = UDim2.new(0, 460, 0, 235)
vu45.Position = UDim2.new(0.05, 0, 0.55, 0)
vu45.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
vu45.BackgroundTransparency = 0.2
vu45.Visible = false
vu45.ZIndex = 1
v36(vu45, 10);
(function(p46)
    local v47 = Instance.new("UIGradient")
    v47.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 30, 30)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 100, 200))
    })
    v47.Rotation = 45
    v47.Parent = p46
end)(vu45)
v41(vu45, Color3.fromRGB(0, 170, 255), 3)
v32(vu45)
local v48 = Instance.new("Frame", vu45)
v48.Size = UDim2.new(0, 220, 0, 180)
v48.Position = UDim2.new(0, 5, 0, 5)
v48.BackgroundTransparency = 1
v48.ZIndex = 2
local v49 = Instance.new("UIListLayout", v48)
v49.SortOrder = Enum.SortOrder.LayoutOrder
v49.Padding = UDim.new(0, 8)
local v50 = Instance.new("Frame", vu45)
v50.Size = UDim2.new(0, 220, 0, 180)
v50.Position = UDim2.new(0, 235, 0, 5)
v50.BackgroundTransparency = 1
v50.ZIndex = 2
local v51 = Instance.new("UIListLayout", v50)
v51.SortOrder = Enum.SortOrder.LayoutOrder
v51.Padding = UDim.new(0, 12)
local vu52 = Instance.new("TextButton", v48)
vu52.Size = UDim2.new(0, 220, 0, 31)
vu52.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
vu52.TextColor3 = Color3.new(1, 1, 1)
vu52.Text = vu14.Enabled and "Enabled" or "Disabled"
vu52.Font = Enum.Font.GothamBlack
vu52.TextSize = 17
vu52.LayoutOrder = 1
v36(vu52, 8)
v41(vu52, Color3.fromRGB(0, 170, 255), 2)
vu52.MouseEnter:Connect(function()
    vu52.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
end)
vu52.MouseLeave:Connect(function()
    vu52.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
end)
local v53 = Instance.new("TextLabel", v48)
v53.Size = UDim2.new(0, 220, 0, 17)
v53.BackgroundTransparency = 1
v53.Text = "Delay:"
v53.TextColor3 = Color3.fromRGB(0, 170, 255)
v53.Font = Enum.Font.GothamBlack
v53.TextSize = 17
v53.TextXAlignment = Enum.TextXAlignment.Left
v53.LayoutOrder = 2
local vu54 = Instance.new("TextBox", v48)
vu54.Size = UDim2.new(0, 220, 0, 31)
vu54.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
vu54.TextColor3 = Color3.new(1, 1, 1)
vu54.PlaceholderText = "Enter Delay"
vu54.PlaceholderColor3 = Color3.fromRGB(100, 200, 255)
vu54.Text = v18 and v18.Delay and (tostring(v18.Delay) or "") or ""
vu54.Font = Enum.Font.GothamBlack
vu54.TextSize = 17
vu54.ClearTextOnFocus = false
vu54.LayoutOrder = 3
v36(vu54, 8)
v41(vu54, Color3.fromRGB(0, 170, 255), 2)
vu54.MouseEnter:Connect(function()
    vu54.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
end)
vu54.MouseLeave:Connect(function()
    vu54.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
end)
local v55 = Instance.new("TextLabel", v48)
v55.Size = UDim2.new(0, 220, 0, 17)
v55.BackgroundTransparency = 1
v55.Text = "Prediction:"
v55.TextColor3 = Color3.fromRGB(0, 170, 255)
v55.Font = Enum.Font.GothamBlack
v55.TextSize = 17
v55.TextXAlignment = Enum.TextXAlignment.Left
v55.LayoutOrder = 4
local vu56 = Instance.new("TextBox", v48)
vu56.Size = UDim2.new(0, 220, 0, 31)
vu56.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
vu56.TextColor3 = Color3.new(1, 1, 1)
vu56.PlaceholderText = "Enter Prediction"
vu56.PlaceholderColor3 = Color3.fromRGB(100, 200, 255)
vu56.Text = v18 and (v18.Prediction and tostring(v18.Prediction)) or ""
vu56.Font = Enum.Font.GothamBlack
vu56.TextSize = 17
vu56.ClearTextOnFocus = false
vu56.LayoutOrder = 5
v36(vu56, 8)
v41(vu56, Color3.fromRGB(0, 170, 255), 2)
vu56.MouseEnter:Connect(function()
    vu56.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
end)
vu56.MouseLeave:Connect(function()
    vu56.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
end)
local v57 = Instance.new("TextLabel", v48)
v57.Size = UDim2.new(0, 220, 0, 17)
v57.BackgroundTransparency = 1
v57.Text = "Keybind:"
v57.TextColor3 = Color3.fromRGB(0, 170, 255)
v57.Font = Enum.Font.GothamBlack
v57.TextSize = 17
v57.TextXAlignment = Enum.TextXAlignment.Left
v57.LayoutOrder = 6
local vu58 = Instance.new("TextBox", v48)
vu58.Size = UDim2.new(0, 220, 0, 31)
vu58.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
vu58.TextColor3 = Color3.new(1, 1, 1)
vu58.PlaceholderText = "Enter Keybind"
vu58.PlaceholderColor3 = Color3.fromRGB(100, 200, 255)
vu58.Text = ""
vu58.Font = Enum.Font.GothamBlack
vu58.TextSize = 17
vu58.ClearTextOnFocus = false
vu58.LayoutOrder = 7
v36(vu58, 8)
v41(vu58, Color3.fromRGB(0, 170, 255), 2)
vu58.MouseEnter:Connect(function()
    vu58.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
end)
vu58.MouseLeave:Connect(function()
    vu58.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
end)
local vu59 = Instance.new("TextButton", v50)
vu59.Size = UDim2.new(0, 220, 0, 31)
vu59.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
vu59.TextColor3 = Color3.new(1, 1, 1)
vu59.Text = vu14.Checks.KnifeCheck and "Knife Check: ON" or "Knife Check: OFF"
vu59.Font = Enum.Font.GothamBlack
vu59.TextSize = 17
vu59.LayoutOrder = 1
v36(vu59, 8)
v41(vu59, Color3.fromRGB(0, 170, 255), 2)
vu59.MouseEnter:Connect(function()
    vu59.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
end)
vu59.MouseLeave:Connect(function()
    vu59.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
end)
local vu60 = Instance.new("TextButton", v50)
vu60.Size = UDim2.new(0, 220, 0, 31)
vu60.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
vu60.TextColor3 = Color3.new(1, 1, 1)
vu60.Text = vu14.Checks.ForcefieldCheck and "Forcefield Check: ON" or "Forcefield Check: OFF"
vu60.Font = Enum.Font.GothamBlack
vu60.TextSize = 17
vu60.LayoutOrder = 2
v36(vu60, 8)
v41(vu60, Color3.fromRGB(0, 170, 255), 2)
vu60.MouseEnter:Connect(function()
    vu60.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
end)
vu60.MouseLeave:Connect(function()
    vu60.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
end)
local vu61 = Instance.new("TextButton", v50)
vu61.Size = UDim2.new(0, 220, 0, 31)
vu61.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
vu61.TextColor3 = Color3.new(1, 1, 1)
vu61.Text = vu14.Checks.KnockedCheck and "Knocked Check: ON" or "Knocked Check: OFF"
vu61.Font = Enum.Font.GothamBlack
vu61.TextSize = 17
vu61.LayoutOrder = 3
v36(vu61, 8)
v41(vu61, Color3.fromRGB(0, 170, 255), 2)
vu61.MouseEnter:Connect(function()
    vu61.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
end)
vu61.MouseLeave:Connect(function()
    vu61.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
end)
local vu62 = Instance.new("TextButton", v50)
vu62.Size = UDim2.new(0, 220, 0, 31)
vu62.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
vu62.TextColor3 = Color3.new(1, 1, 1)
vu62.Text = vu14.Checks.AmmoCheck and "Ammo Check: ON" or "Ammo Check: OFF"
vu62.Font = Enum.Font.GothamBlack
vu62.TextSize = 17
vu62.LayoutOrder = 4
v36(vu62, 8)
v41(vu62, Color3.fromRGB(0, 170, 255), 2)
vu62.MouseEnter:Connect(function()
    vu62.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
end)
vu62.MouseLeave:Connect(function()
    vu62.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
end)
local function vu63()
    vu14.Enabled = not vu14.Enabled
    vu52.Text = vu14.Enabled and "Enabled" or "Disabled"
    vu13(vu14)
end
v43.MouseButton1Click:Connect(function()
    vu45.Visible = not vu45.Visible
end)
vu52.MouseButton1Click:Connect(vu63)
vu58.FocusLost:Connect(function(p64)
    if p64 then
        local v65 = vu58.Text:upper()
        if # v65 ~= 1 or not v65:match("%a") then
            vu58.Text = vu14.Keybind
        else
            vu14.Keybind = v65
            vu58.Text = v65
            vu13(vu14)
        end
    end
end)
vu5.InputBegan:Connect(function(p66, p67)
    if not p67 then
        if p66.UserInputType == Enum.UserInputType.Keyboard and vu14.Keybind ~= "" and p66.KeyCode.Name:upper() == vu14.Keybind then
            vu63()
        end
    end
end)
local function vu68()
    vu13(vu14)
end
vu54.FocusLost:Connect(function(p69)
    if p69 then
        local v70 = tonumber(vu54.Text)
        if v70 and 0 <= v70 then
            vu14.Delay = v70
            vu54.Text = tostring(v70)
            vu68()
        else
            vu54.Text = ""
        end
    end
end)
vu56.FocusLost:Connect(function(p71)
    if p71 then
        local v72 = tonumber(vu56.Text)
        if v72 and 0 <= v72 then
            vu14.Prediction = v72
            vu56.Text = tostring(v72)
            vu68()
        else
            vu56.Text = ""
        end
    end
end)
vu59.MouseButton1Click:Connect(function()
    vu14.Checks.KnifeCheck = not vu14.Checks.KnifeCheck
    vu59.Text = vu14.Checks.KnifeCheck and "Knife Check: ON" or "Knife Check: OFF"
    vu68()
end)
vu60.MouseButton1Click:Connect(function()
    vu14.Checks.ForcefieldCheck = not vu14.Checks.ForcefieldCheck
    vu60.Text = vu14.Checks.ForcefieldCheck and "Forcefield Check: ON" or "Forcefield Check: OFF"
    vu68()
end)
vu61.MouseButton1Click:Connect(function()
    vu14.Checks.KnockedCheck = not vu14.Checks.KnockedCheck
    vu61.Text = vu14.Checks.KnockedCheck and "Knocked Check: ON" or "Knocked Check: OFF"
    vu68()
end)
vu62.MouseButton1Click:Connect(function()
    vu14.Checks.AmmoCheck = not vu14.Checks.AmmoCheck
    vu62.Text = vu14.Checks.AmmoCheck and "Ammo Check: ON" or "Ammo Check: OFF"
    vu68()
end)
local vu73 = {
    [93579217841822] = true
}
local vu74 = RaycastParams.new()
vu74.FilterType = Enum.RaycastFilterType.Blacklist
vu74.IgnoreWater = true
local vu75 = 0
local function vu81()
    local v76 = vu2.Character
    if v76 then
        v76 = vu2.Character:FindFirstChildOfClass("Tool")
    end
    if v76 then
        local v77 = v76:FindFirstChild("CurrentAmmo")
        local v78 = v76:FindFirstChild("Clip")
        local v79 = v76:FindFirstChild("Mag")
        local v80 = v76:FindFirstChild("Ammo")
        if v77 and v77:IsA("IntValue") then
            return v77.Value > 0
        elseif v78 and v78:IsA("IntValue") then
            return v78.Value > 0
        elseif v79 and v79:IsA("IntValue") then
            return v79.Value > 0
        else
            return not (v80 and v80:IsA("IntValue")) and true or v80.Value > 0
        end
    else
        return false
    end
end
local function vu88(p82)
    if not p82 then
        return false
    end
    local v83 = p82:FindFirstChildOfClass("Humanoid")
    if not v83 or v83.Health <= 0 or vu1:GetPlayerFromCharacter(p82) == vu2 then
        return false
    end
    if vu14.Checks.KnifeCheck then
        local v84 = vu2.Character
        if v84 then
            v84 = vu2.Character:FindFirstChildOfClass("Tool")
        end
        if v84 and (v84.Name:lower():find("knife") or (v84.Name:lower():find("blade") or (v84.Name:lower():find("dagger") or (v84.Name:lower():find("combat") or (v84.Name:lower():find("melee") or (v84.Name:lower():find("sword") or (v84.ClassName:lower():find("knife") or v84.ClassName:lower():find("blade")))))))) then
            return false
        end
    end
    if vu14.Checks.ForcefieldCheck and (p82:FindFirstChildOfClass("ForceField") or (p82:GetAttribute("Shield") or p82:GetAttribute("Protected"))) then
        return false
    end
    if vu14.Checks.KnockedCheck then
        local v85 = false
        local v86
        if p82:FindFirstChild("BodyEffects") then
            local v87 = p82.BodyEffects
            v86 = v87:FindFirstChild("K.O") and v87["K.O"].Value and true or (v87:FindFirstChild("Dead") and v87.Dead.Value and true or v85)
        else
            v86 = v83.Health < 4 and true or v85
        end
        if v86 then
            return false
        end
    end
    return (not vu14.Checks.AmmoCheck or vu81()) and true or false
end
local function vu90()
    local v89 = vu2.Character
    if v89 then
        v89 = vu2.Character:FindFirstChildOfClass("Tool")
    end
    if v89 then
        v89:Activate()
    end
end
v4.RenderStepped:Connect(function()
    if vu14.Enabled then
        vu74.FilterDescendantsInstances = {
            vu2.Character
        }
        local v91 = vu3:ViewportPointToRay(vu3.ViewportSize.X / 2, vu3.ViewportSize.Y / 2)
        local v92 = v91.Origin
        local v93 = v91.Direction
        local v94 = workspace:Raycast(v92, v93 * 1000, vu74)
        if v94 and v94.Instance then
            local v95 = v94.Instance:FindFirstAncestorOfClass("Model")
            if vu88(v95) then
                local v96 = v94.Position
                if vu14.Prediction > 0 then
                    local v97 = v95:FindFirstChild("HumanoidRootPart") or (v95:FindFirstChild("Torso") or v95:FindFirstChild("UpperTorso"))
                    if v97 then
                        v96 = v97.Position + v97.Velocity * vu14.Prediction
                    end
                end
                local v98 = (v96 - v92).Unit
                local v99 = workspace:Raycast(v92, v98 * 1000, vu74)
                if v99 and v99.Instance and (v99.Instance:IsDescendantOf(v95) and tick() - vu75 >= vu14.Delay) then
                    if vu73[game.PlaceId] then
                        local v100 = vu2.Character:FindFirstChildOfClass("Tool")
                        if v100 then
                            v100:Activate()
                        end
                    else
                        vu90()
                    end
                    vu75 = tick()
                end
            end
        end
    end
end)