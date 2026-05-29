-- Blazed - Full Working Script (Aimlock Fixed & Included)
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/alebinh60/asmobile/refs/heads/main/Library.lua"))()
local Window = Library:CreateWindow({
    Title = "Blazed",
    Footer = "blazed.cc",
    Icon = 241778280,
    ShowCustomCursor = true,
})

local Tabs = {
    Combat = Window:AddTab("Combat", "swords"),
    Visuals = Window:AddTab("Visuals", "eye"),
    Movement = Window:AddTab("Movement", "user"),
    Misc = Window:AddTab("Misc", "settings"),
}

-- ==================== VARIABLES ====================
local MainEvent = ReplicatedStorage:FindFirstChild("MainEvent") or ReplicatedStorage:FindFirstChild("MAINEVENT")

local SilentEnabled = false
local SilentHitPart = "Head"
local SilentFOV = 150
local AimlockEnabled = false
local AimlockSmoothing = 0.2
local AimlockPart = "Head"
local WallCheckEnabled = true

local CrosshairEnabled = false
local WalkspeedEnabled = false
local WalkspeedValue = 50

-- ESP
local EspEnabled = false
local TracersEnabled = false
local HealthBarEnabled = true
local TracerColor = Color3.fromRGB(255, 0, 0)
local ESPColor = Color3.fromRGB(0, 255, 255)

local espBoxes = {}
local espTracers = {}
local espNames = {}
local espHealthBars = {}

-- Menu Toggle (Right Shift)
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightShift then
        pcall(function() Window:SetVisibility(not Window.Visible) end)
        Library:Notify(Window.Visible and "Menu Shown" or "Menu Hidden", 2)
    end
end)

-- ==================== HELPERS ====================
local function getHealthPercent(player)
    local hum = player.Character and player.Character:FindFirstChild("Humanoid")
    return hum and hum.Health / hum.MaxHealth or 0
end

local function isVisible(target)
    if not WallCheckEnabled then return true end
    local localChar = LocalPlayer.Character
    local targetChar = target.Character
    if not localChar or not targetChar then return false end
    local root = localChar:FindFirstChild("HumanoidRootPart")
    local tpart = targetChar:FindFirstChild(SilentHitPart) or targetChar:FindFirstChild("Head")
    if not root or not tpart then return false end
    local dir = (tpart.Position - root.Position)
    local params = RaycastParams.new()
    params.FilterDescendantsInstances = {localChar, targetChar}
    params.FilterType = Enum.RaycastFilterType.Blacklist
    local res = workspace:Raycast(root.Position, dir.Unit * dir.Magnitude, params)
    return res == nil
end

local function getClosestTarget()
    local closest, shortest = nil, SilentFOV
    local mouse = UserInputService:GetMouseLocation()
    for _, plr in Players:GetPlayers() do
        if plr ~= LocalPlayer and plr.Character then
            local hum = plr.Character:FindFirstChild("Humanoid")
            if hum and hum.Health > 0 then
                local part = plr.Character:FindFirstChild(SilentHitPart) or plr.Character:FindFirstChild("Head")
                if part then
                    local pos, onScreen = Camera:WorldToViewportPoint(part.Position)
                    if onScreen then
                        local d = (Vector2.new(pos.X, pos.Y) - mouse).Magnitude
                        if d < shortest and isVisible(plr) then
                            shortest = d
                            closest = plr
                        end
                    end
                end
            end
        end
    end
    return closest
end

-- ==================== AIMLOCK ====================
local function updateAimlock()
    if not AimlockEnabled then return end
    local target = getClosestTarget()
    if target and target.Character then
        local part = target.Character:FindFirstChild(AimlockPart) or target.Character:FindFirstChild("Head")
        if part then
            local goal = CFrame.new(Camera.CFrame.Position, part.Position)
            Camera.CFrame = Camera.CFrame:Lerp(goal, AimlockSmoothing)
        end
    end
end

-- ==================== ESP ====================
local function updateESP()
    local bottom = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y)
    for _, player in ipairs(Players:GetPlayers()) do
        if player == LocalPlayer then continue end
        local char = player.Character
        if not char then continue end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local head = char:FindFirstChild("Head")
        local hum = char:FindFirstChild("Humanoid")
        if not hrp or not head or not hum or hum.Health <= 0 then continue end

        local headPos = Camera:WorldToViewportPoint(head.Position)
        if headPos.Z < 0 then continue end

        local distance = (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and (hrp.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude) or 0
        local health = getHealthPercent(player)

        -- Name + Distance
        if not espNames[player] then
            espNames[player] = Drawing.new("Text")
            espNames[player].Size = 14
            espNames[player].Center = true
            espNames[player].Outline = true
            espNames[player].Color = ESPColor
        end
        espNames[player].Text = string.format("%s [%d]", player.Name, math.floor(distance))
        espNames[player].Position = Vector2.new(headPos.X, headPos.Y - 35)
        espNames[player].Visible = EspEnabled

        -- Box ESP
        if EspEnabled then
            if not espBoxes[player] then
                espBoxes[player] = {}
                for i = 1, 4 do
                    espBoxes[player][i] = Drawing.new("Line")
                    espBoxes[player][i].Color = ESPColor
                    espBoxes[player][i].Thickness = 2
                end
            end
            local size = 1800 / headPos.Z
            local x, y = headPos.X, headPos.Y
            local p = {
                Vector2.new(x - size/2, y - size),
                Vector2.new(x + size/2, y - size),
                Vector2.new(x + size/2, y + size * 1.8),
                Vector2.new(x - size/2, y + size * 1.8)
            }
            for i = 1, 4 do
                local nxt = i % 4 + 1
                espBoxes[player][i].From = p[i]
                espBoxes[player][i].To = p[nxt]
                espBoxes[player][i].Visible = true
            end
        end

        -- Health Bar
        if HealthBarEnabled then
            if not espHealthBars[player] then
                espHealthBars[player] = Drawing.new("Line")
                espHealthBars[player].Thickness = 4
            end
            local barHeight = 1800 / headPos.Z * 1.8
            local x = headPos.X - (1800 / headPos.Z)/2 - 12
            espHealthBars[player].From = Vector2.new(x, headPos.Y - barHeight/2)
            espHealthBars[player].To = Vector2.new(x, headPos.Y - barHeight/2 + barHeight * health)
            espHealthBars[player].Color = Color3.fromHSV(health * 0.3, 1, 1)
            espHealthBars[player].Visible = true
        end

        -- Tracers
        if TracersEnabled then
            if not espTracers[player] then
                espTracers[player] = Drawing.new("Line")
                espTracers[player].Thickness = 2
                espTracers[player].Color = TracerColor
            end
            espTracers[player].From = bottom
            espTracers[player].To = Vector2.new(headPos.X, headPos.Y)
            espTracers[player].Visible = true
        end
    end
end

-- ==================== MAIN LOOP ====================
RunService.RenderStepped:Connect(function()
    updateESP()
    updateAimlock()   -- Aimlock is now properly called
end)

-- Walkspeed
RunService.Heartbeat:Connect(function()
    local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
    if hum then
        hum.WalkSpeed = WalkspeedEnabled and WalkspeedValue or 16
    end
end)

-- ==================== UI ====================
local Combat = Tabs.Combat:AddLeftGroupbox("Combat")
Combat:AddToggle("SilentAim", {Text = "Silent Aim", Callback = function(v) SilentEnabled = v end})
Combat:AddToggle("Aimlock", {Text = "Aimlock", Callback = function(v) AimlockEnabled = v end})
Combat:AddSlider("Smoothing", {Text = "Aimlock Smoothing", Min = 0.05, Max = 0.5, Default = 0.2, Callback = function(v) AimlockSmoothing = v end})
Combat:AddToggle("WallCheck", {Text = "Wall Check", Default = true, Callback = function(v) WallCheckEnabled = v end})

local Visuals = Tabs.Visuals:AddLeftGroupbox("Visuals")
Visuals:AddToggle("BoxESP", {Text = "Box ESP", Callback = function(v) EspEnabled = v end})
Visuals:AddToggle("Tracers", {Text = "Tracers", Callback = function(v) TracersEnabled = v end})
Visuals:AddToggle("HealthBar", {Text = "Health Bar", Default = true, Callback = function(v) HealthBarEnabled = v end})
Visuals:AddToggle("Crosshair", {Text = "Crosshair", Callback = function(v) CrosshairEnabled = v end})

local Movement = Tabs.Movement:AddLeftGroupbox("Movement")
Movement:AddToggle("Walkspeed", {Text = "Walkspeed", Callback = function(v) WalkspeedEnabled = v end})
Movement:AddSlider("Speed", {Text = "Speed Value", Min = 16, Max = 200, Default = 50, Callback = function(v) WalkspeedValue = v end})

local Misc = Tabs.Misc:AddLeftGroupbox("Misc")
Misc:AddButton("Join Discord", function()
    setclipboard("https://discord.gg/B2RyvjJwV")
    Library:Notify("Discord link copied!", 3)
end)

print("✅ Blazed Loaded Successfully! Press Right Shift to toggle menu.")