getgenv().KK = {
    Camlock = {
        Enable = true,
        Smooth = 0.41,
    },
    Target = {
        Esp_Elip = false,
        Tracer = false,
    },
    Part = {"HumanoidRootPart", "Head", "HumanoidRootPart"}
}

local Keybind = Enum.KeyCode.Q
local knockCheckEnabled = true

local _Players = game:GetService('Players')
local _RunService = game:GetService('RunService')
local _StarterGui = game:GetService('StarterGui')
local _UserInputService = game:GetService('UserInputService')
local _HttpService = game:GetService('HttpService')
local _Workspace = game:GetService('Workspace')
local _LocalPlayer = _Players.LocalPlayer
local _Character = _LocalPlayer.Character or _LocalPlayer.CharacterAdded:Wait()
local _CurrentCamera = _Workspace.CurrentCamera

local SHOTGUN_WEAPONS = {
    ["Double Barrel"] = true,
    ["Tactical Shotgun"] = true,
    ["[Double-Barrel SG]"] = true,
    ["[TacticalShotgun]"] = true
}

local RAYCAST_VALIDATOR = {
    ArgCountRequired = 3,
    Args = {
        'Instance',
        'Vector3',
        'Vector3',
        'RaycastParams',
    },
}

local function LoadPositions()
    if not isfile('camlockpos.txt') then return {} end
    local ok, data = pcall(function()
        return _HttpService:JSONDecode(readfile('camlockpos.txt'))
    end)
    if ok and data then return data end
    return {}
end

local function SavePosition(name, pos)
    local data = LoadPositions()
    data[name] = {
        X = { Scale = pos.X.Scale, Offset = pos.X.Offset },
        Y = { Scale = pos.Y.Scale, Offset = pos.Y.Offset }
    }
    writefile('camlockpos.txt', _HttpService:JSONEncode(data))
end

local function GetSavedPos(name, default)
    local saved = LoadPositions()
    if saved[name] then
        local s = saved[name]
        return UDim2.new(s.X.Scale, s.X.Offset, s.Y.Scale, s.Y.Offset)
    end
    return default
end

local gui = Instance.new("ScreenGui")
gui.Name = "CamlockGui"
gui.Parent = game:GetService("CoreGui")
gui.ResetOnSpawn = false

local TextButton = Instance.new("TextButton")
TextButton.Text = "meow"
TextButton.TextSize = 24
TextButton.TextColor3 = Color3.new(1, 1, 1)
TextButton.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
TextButton.BorderColor3 = Color3.new(255, 0, 0)
TextButton.BorderSizePixel = 4
TextButton.BackgroundTransparency = 1
TextButton.Font = Enum.Font.Code
TextButton.Size = UDim2.new(0.2, 0, 0.2, 0)
TextButton.Position = GetSavedPos('meow', UDim2.new(0, 0.9, 0.3, 1))
TextButton.Parent = gui
TextButton.Draggable = true

local cornerUI = Instance.new("UICorner")
cornerUI.CornerRadius = UDim.new(0, 4)
cornerUI.Parent = TextButton

local RageButton = Instance.new("TextButton")
RageButton.Text = "rage"
RageButton.TextSize = 24
RageButton.TextColor3 = Color3.new(1, 1, 1)
RageButton.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
RageButton.BorderColor3 = Color3.new(255, 165, 0)
RageButton.BorderSizePixel = 4
RageButton.BackgroundTransparency = 1
RageButton.Font = Enum.Font.Code
RageButton.Size = UDim2.new(0.2, 0, 0.2, 0)
RageButton.Position = GetSavedPos('rage', UDim2.new(0, 0.9, 0.55, 1))
RageButton.Parent = gui
RageButton.Draggable = true

local cornerUI2 = Instance.new("UICorner")
cornerUI2.CornerRadius = UDim.new(0, 4)
cornerUI2.Parent = RageButton

TextButton:GetPropertyChangedSignal('Position'):Connect(function()
    SavePosition('meow', TextButton.Position)
end)

RageButton:GetPropertyChangedSignal('Position'):Connect(function()
    SavePosition('rage', RageButton.Position)
end)

local tracerLine = Drawing.new("Line")
tracerLine.Thickness = 2
tracerLine.Transparency = 1
tracerLine.Color = Color3.fromRGB(255, 255, 255)
tracerLine.Visible = false

local espCylinder = nil
local espHighlight = nil
local targetPlayer = nil
local targetPart = nil
local currentWeapon = nil
local rainbowHue = 0
local camlockEnabled = false
local characterConnections = {}

local frameCount = 0
local ESP_UPDATE_RATE = 3
local KNOCK_CHECK_RATE = 10

local rageEnabled = false

local function GetTargetPart(character)
    if not character then return nil end
    local parts = getgenv().KK.Part
    local partName
    if type(parts) == "table" then
        partName = parts[math.random(1, #parts)]
    else
        partName = parts or "HumanoidRootPart"
    end
    local part = character:FindFirstChild(partName)
    if not part then
        part = character:FindFirstChild("HumanoidRootPart")
    end
    return part
end

local function SendNotification(title, text, duration)
    pcall(function()
        _StarterGui:SetCore("SendNotification", {
            Title = title,
            Text = text,
            Duration = duration or 3,
        })
    end)
end

local function CalculateDirection(origin, target, spread)
    local dir = (target - origin)
    local dist = dir.Magnitude
    local unit = dir.Unit
    if spread and spread > 0 then
        local s = spread * (dist / 100)
        unit = (target + Vector3.new(
            math.random(-s*950, s*950)/950,
            math.random(-s*950, s*950)/950,
            math.random(-s*950, s*950)/950
        ) - origin).Unit
    end
    return dist * unit
end

local function ValidateRaycastArgs(args, validator)
    if #args < validator.ArgCountRequired then
        return false
    end
    local count = 0
    for index, arg in pairs(args) do
        if typeof(arg) == validator.Args[index] then
            count = count + 1
        end
    end
    return count >= validator.ArgCountRequired
end

local function FindClosestPlayerToCenter()
    local closestPlayer = nil
    local closestDistance = math.huge
    local screenCenter = Vector2.new(_CurrentCamera.ViewportSize.X / 2, _CurrentCamera.ViewportSize.Y / 2)

    for _, player in ipairs(_Players:GetPlayers()) do
        if player ~= _LocalPlayer and player.Character then
            local character = player.Character
            local part = character:FindFirstChild("UpperTorso") or character:FindFirstChild("HumanoidRootPart")
            local humanoid = character:FindFirstChild("Humanoid")

            if part and humanoid and humanoid.Health > 0 then
                local position, onScreen = _CurrentCamera:WorldToViewportPoint(part.Position)
                if onScreen then
                    local distance = (screenCenter - Vector2.new(position.X, position.Y)).Magnitude
                    if distance < closestDistance then
                        closestPlayer = player
                        closestDistance = distance
                    end
                end
            end
        end
    end

    return closestPlayer
end

local function CleanupESP()
    if espCylinder then
        espCylinder:Destroy()
        espCylinder = nil
        espHighlight = nil
    end
end

local function SetupESP()
    CleanupESP()
    if not getgenv().KK.Target.Esp_Elip then return end

    espCylinder = Instance.new('Part')
    espCylinder.Name = 'TargetCylinder'
    espCylinder.Shape = Enum.PartType.Cylinder
    espCylinder.Size = Vector3.new(0.1, 4, 4)
    espCylinder.Material = Enum.Material.Plastic
    espCylinder.Anchored = true
    espCylinder.CanCollide = false
    espCylinder.Parent = workspace

    espHighlight = Instance.new('Highlight')
    espHighlight.Name = 'CylinderHighlight'
    espHighlight.Adornee = espCylinder
    espHighlight.FillTransparency = 0.5
    espHighlight.OutlineTransparency = 0
    espHighlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    espHighlight.Parent = espCylinder
end

local function DisableRage()
    rageEnabled = false
    RageButton.TextColor3 = Color3.new(1, 1, 1)
end

local function EnableRage()
    rageEnabled = true
    RageButton.TextColor3 = Color3.fromRGB(255, 165, 0)
end

local function ToggleRage()
    if rageEnabled then DisableRage() else EnableRage() end
end

local function DisableCamlock()
    targetPlayer = nil
    targetPart = nil
    camlockEnabled = false
    TextButton.TextColor3 = Color3.new(1, 1, 1)
    tracerLine.Visible = false
    CleanupESP()
end

local function ToggleCamlock()
    if targetPlayer then
        DisableCamlock()
    else
        targetPlayer = FindClosestPlayerToCenter()
        if targetPlayer then
            camlockEnabled = true
            SetupESP()
            TextButton.TextColor3 = Color3.new(1, 0, 0)
        end
    end
end

local function DisconnectCharacterConnections()
    for _, connection in pairs(characterConnections) do
        if connection then
            connection:Disconnect()
        end
    end
    characterConnections = {}
end

local function SetupCharacterConnections(character)
    DisconnectCharacterConnections()

    characterConnections.childAdded = character.ChildAdded:Connect(function(child)
        if child:IsA('Tool') then
            currentWeapon = child.Name
        end
    end)

    characterConnections.childRemoved = character.ChildRemoved:Connect(function(child)
        if child:IsA('Tool') then
            currentWeapon = nil
        end
    end)

    for _, child in pairs(character:GetChildren()) do
        if child:IsA('Tool') then
            currentWeapon = child.Name
            break
        end
    end
end

_UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Keybind then
        ToggleCamlock()
    end
end)

_LocalPlayer.Chatted:Connect(function(message)
    local command = message:lower()

    if command:match("^/e%s+keybind%s*=%s*%w$") then
        local newKey = command:match("keybind%s*=%s*(%w)")
        if newKey then
            newKey = newKey:upper()
            if Enum.KeyCode[newKey] then
                Keybind = Enum.KeyCode[newKey]
                SendNotification("bad lock", "keybind changed to: " .. newKey, 3)
            else
                SendNotification("bad lock", "invalid keybind: " .. newKey, 3)
            end
        end
    elseif command:match("^/e%s+knock%s+") then
        local value = command:match("knock%s+(%w+)")
        if value == "true" then
            knockCheckEnabled = true
            SendNotification("bad lock", "knock check: enabled", 3)
        elseif value == "false" then
            knockCheckEnabled = false
            SendNotification("bad lock", "knock check: disabled", 3)
        else
            SendNotification("bad lock", "use: /e knock true or false", 3)
        end
    end
end)

TextButton.MouseButton1Click:Connect(function()
    ToggleCamlock()
end)

RageButton.MouseButton1Click:Connect(function()
    ToggleRage()
end)

_LocalPlayer.CharacterAdded:Connect(function(character)
    task.wait(0.5)
    _Character = character
    SetupCharacterConnections(character)
end)

_Players.PlayerRemoving:Connect(function(player)
    if player == targetPlayer then
        DisableCamlock()
    end
end)

SetupCharacterConnections(_Character)

_RunService.RenderStepped:Connect(function()
    if getgenv().KK.Camlock.Enable and camlockEnabled and targetPlayer and targetPlayer.Character then
        local part = targetPlayer.Character:FindFirstChild("UpperTorso")
            or targetPlayer.Character:FindFirstChild("HumanoidRootPart")
        if part then
            local currentCFrame = _CurrentCamera.CFrame
            local targetCFrame = CFrame.new(currentCFrame.Position, part.Position)
            _CurrentCamera.CFrame = currentCFrame:Lerp(targetCFrame, getgenv().KK.Camlock.Smooth)
        end
    end

    if rageEnabled and camlockEnabled and targetPlayer and targetPlayer.Character and _Character then
        local tgt = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
            or targetPlayer.Character:FindFirstChild("UpperTorso")
        local hrp = _Character:FindFirstChild("HumanoidRootPart")

        if tgt and hrp then
            local t = tick() * 20
            local radius = 7
            local x = math.sin(t * 1.7) * radius
            local z = math.cos(t * 2.3) * radius
            local y = math.sin(t * 4) * 1.5 + 2
            hrp.CFrame = CFrame.new(tgt.Position + Vector3.new(x, y, z), tgt.Position)
        end
    end
end)

_RunService.Heartbeat:Connect(function()
    frameCount = frameCount + 1
    rainbowHue = rainbowHue + 0.005
    if rainbowHue >= 1 then rainbowHue = 0 end

    if frameCount % KNOCK_CHECK_RATE == 0 then
        if knockCheckEnabled and targetPlayer and targetPlayer.Character then
            local hum = targetPlayer.Character:FindFirstChild('Humanoid')
            if hum and hum.Health <= 1 then
                DisableCamlock()
                return
            end
        end
    end

    if frameCount % ESP_UPDATE_RATE ~= 0 then return end

    if targetPlayer and targetPlayer.Character then
        local part = GetTargetPart(targetPlayer.Character)

        if part then
            targetPart = part

            if espCylinder and getgenv().KK.Target.Esp_Elip then
                espCylinder.CFrame = CFrame.new(part.Position - Vector3.new(0, part.Size.Y / 2 + 0.5, 0)) * CFrame.Angles(0, 0, math.rad(90))
                if espHighlight then
                    espHighlight.FillColor = Color3.fromHSV(rainbowHue, 1, 1)
                    espHighlight.OutlineColor = Color3.fromHSV(rainbowHue, 1, 0.8)
                end
            end

            if getgenv().KK.Target.Tracer then
                local targetPos, onScreen = _CurrentCamera:WorldToViewportPoint(part.Position)
                if onScreen and _Character and _Character:FindFirstChild("Head") then
                    local myHeadPos = _CurrentCamera:WorldToViewportPoint(_Character.Head.Position)
                    tracerLine.From = Vector2.new(myHeadPos.X, myHeadPos.Y)
                    tracerLine.To = Vector2.new(targetPos.X, targetPos.Y)
                    tracerLine.Color = Color3.fromHSV(rainbowHue, 1, 1)
                    tracerLine.Visible = true
                else
                    tracerLine.Visible = false
                end
            else
                tracerLine.Visible = false
            end
        else
            targetPart = nil
            tracerLine.Visible = false
        end
    else
        targetPart = nil
        tracerLine.Visible = false
        CleanupESP()
    end
end)

local originalNamecall
originalNamecall = hookmetamethod(game, "__namecall", newcclosure(function(...)
    local method = getnamecallmethod()
    local args = {...}

    if checkcaller() then
        return originalNamecall(...)
    end

    if not targetPlayer or not targetPart then
        return originalNamecall(...)
    end

    if method == "Raycast" then
        if typeof(args[2]) == "Vector3" and typeof(args[3]) == "Vector3" then
            local origin = args[2]
            local targetPosition = targetPart.Position

            if SHOTGUN_WEAPONS[currentWeapon] then
                args[3] = CalculateDirection(origin, targetPosition, 6)
            else
                args[3] = CalculateDirection(origin, targetPosition)
            end

            local result = originalNamecall(unpack(args))
            return result
        end
    end

    if method == "FindPartOnRay"
    or method == "FindPartOnRayWithIgnoreList"
    or method == "FindPartOnRayWithWhitelist" then
        local ray = args[2]
        if typeof(ray) == "Ray" then
            local origin = ray.Origin
            local targetPosition = targetPart.Position

            if SHOTGUN_WEAPONS[currentWeapon] then
                args[2] = Ray.new(origin, CalculateDirection(origin, targetPosition, 6))
            else
                args[2] = Ray.new(origin, CalculateDirection(origin, targetPosition))
            end

            return originalNamecall(unpack(args))
        end
    end

    return originalNamecall(...)
end))