local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local HideAllEnabled = false
local UIFrames = {}
local LocalPlayer = Players.LocalPlayer
local Mouse = game.Players.LocalPlayer:GetMouse()
local CamlockState = false
local GuiCreated = false
local ResolverEnabled = false
local Prediction = 0.1768521
local Resolving = false
local PlayerData = {}
local LastDownTarget = nil
local HorizontalPrediction = 0.111076110
local VerticalPrediction = 0.11034856
local XPrediction = 20
local YPrediction = 20
local AutoAirEnabled = false

if game.CoreGui:FindFirstChild("Vascal") then
	game.CoreGui.Vascal:Destroy()
end

if game.CoreGui:FindFirstChild("Vascal_Notifications") then
	game.CoreGui.Vascal_Notifications:Destroy()
end

if game.Players.LocalPlayer:FindFirstChild("PlayerGui") then
	local pg = game.Players.LocalPlayer.PlayerGui
	if pg:FindFirstChild("SimpleHUD") then
		pg.SimpleHUD:Destroy()
	end
end

-- NOTIFICATION SYSTEM
local TweenService = game:GetService("TweenService")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "Vascal_Notifications"

local Holder = Instance.new("Frame")
Holder.BackgroundTransparency = 1
Holder.Size = UDim2.new(1, 0, 0, 200)
Holder.Position = UDim2.new(0, 0, 0, 20)
Holder.Parent = ScreenGui

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 6)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = Holder

local function Notify(text, duration)
	duration = duration or 2.5

	local notif = Instance.new("Frame")
	notif.Size = UDim2.new(0, 260, 0, 35)
	notif.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	notif.BackgroundTransparency = 1
	notif.Parent = Holder

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 8)
	corner.Parent = notif

	local stroke = Instance.new("UIStroke")
	stroke.Color = Color3.fromRGB(255, 255, 255)
	stroke.Transparency = 0.9
	stroke.Parent = notif

	local label = Instance.new("TextLabel")
	label.BackgroundTransparency = 1
	label.Size = UDim2.new(1, -12, 1, 0)
	label.Position = UDim2.new(0, 10, 0, 0)
	label.Text = text
	label.TextColor3 = Color3.fromRGB(255, 255, 255)
	label.TextTransparency = 1
	label.Font = Enum.Font.GothamMedium
	label.TextSize = 14
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = notif

	-- start position (slightly left + invisible)
	notif.Position = UDim2.new(0, -15, 0, 0)

	-- fade + slide in
	local tIn1 = TweenService:Create(notif, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
		BackgroundTransparency = 0.15,
		Position = UDim2.new(0, 0, 0, 0)
	})

	local tIn2 = TweenService:Create(label, TweenInfo.new(0.25), {
		TextTransparency = 0
	})

	tIn1:Play()
	tIn2:Play()

	-- small "settle bounce"
	task.delay(0.25, function()
		TweenService:Create(notif, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
			Position = UDim2.new(0, 0, 0, 2)
		}):Play()

		task.wait(0.15)

		TweenService:Create(notif, TweenInfo.new(0.15), {
			Position = UDim2.new(0, 0, 0, 0)
		}):Play()
	end)

	-- fade out
	task.delay(duration, function()
		local out1 = TweenService:Create(notif, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
			BackgroundTransparency = 1,
			Position = UDim2.new(0, 0, 0, -10)
		})

		local out2 = TweenService:Create(label, TweenInfo.new(0.2), {
			TextTransparency = 1
		})

		out1:Play()
		out2:Play()

		out1.Completed:Wait()
		notif:Destroy()
	end)
end

local TweenService = game:GetService("TweenService")
local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local NotifyGui = Instance.new("ScreenGui")
NotifyGui.Name = "SimpleHUD"
NotifyGui.ResetOnSpawn = false
NotifyGui.Parent = PlayerGui

local Holder = Instance.new("Frame")
Holder.BackgroundTransparency = 1
Holder.Size = UDim2.new(1, 0, 1, 0)
Holder.Parent = NotifyGui

local function CamlockNotify(text)
	local label = Instance.new("TextLabel")
	label.BackgroundTransparency = 1
	label.Size = UDim2.new(0, 260, 0, 22)

	-- 📍 THIS IS THE KEY FIX: bottom-center anchored above hotbar
	label.AnchorPoint = Vector2.new(0.5, 1)
	label.Position = UDim2.new(0.5, 0, 1, -120) 
	-- 👆 -120 = ABOVE ROBLOX ITEM BAR

	label.Text = text
	label.TextColor3 = Color3.fromRGB(255, 255, 255)
	label.TextTransparency = 1
	label.Font = Enum.Font.Arcade
	label.TextSize = 14
	label.TextXAlignment = Enum.TextXAlignment.Center
	label.Parent = Holder

	-- subtle clean outline (NOT AI UI LOOK)
	local stroke = Instance.new("UIStroke")
	stroke.Thickness = 1
	stroke.Transparency = 0.75
	stroke.Color = Color3.fromRGB(180, 180, 180)
	stroke.Parent = label

	-- fade in + slight lift
	label.Position = label.Position + UDim2.new(0, 0, 0, 10)

	game:GetService("TweenService"):Create(label, TweenInfo.new(0.25), {
		TextTransparency = 0,
		Position = label.Position
	}):Play()

	task.delay(1.6, function()
		local tween = game:GetService("TweenService"):Create(label, TweenInfo.new(0.25), {
			TextTransparency = 1,
			Position = label.Position + UDim2.new(0, 0, 0, -10)
		})
		tween:Play()
		tween.Completed:Wait()
		label:Destroy()
	end)
end

local function CreateResolverTool()
	local tool = Instance.new("Tool")
	tool.Name = "Vascal Resolver😈"
	tool.RequiresHandle = false
	tool.Parent = LocalPlayer.Backpack

	tool.Activated:Connect(function()
		ResolverEnabled = not ResolverEnabled

		if ResolverEnabled then
			Notify("Resolver ON: ano tara?", 3)
		else
			Notify("Resolver OFF: ano tara?", 3)
		end
	end)
end

CreateResolverTool()

LocalPlayer.CharacterAdded:Connect(function()
task.wait(1)
CreateResolverTool()
end)

function FindNearestEnemy()
    local ClosestDistance, ClosestPlayer = math.huge, nil
    local CenterPosition = Vector2.new(
        game:GetService("GuiService"):GetScreenResolution().X / 2,
        game:GetService("GuiService"):GetScreenResolution().Y / 2
    )

    for _, Player in ipairs(game:GetService("Players"):GetPlayers()) do
        if Player ~= LocalPlayer then
            local Character = Player.Character
            if Character and Character:FindFirstChild("HumanoidRootPart") and Character.Humanoid.Health > 0 then
                local Position, IsVisibleOnViewport =
                    game:GetService("Workspace").CurrentCamera:WorldToViewportPoint(Character.HumanoidRootPart.Position)

                if IsVisibleOnViewport then
                    local Distance = (CenterPosition - Vector2.new(Position.X, Position.Y)).Magnitude
                    if Distance < ClosestDistance then
                        ClosestPlayer = Character.HumanoidRootPart
                        ClosestDistance = Distance
                    end
                end
            end
        end
    end

    return ClosestPlayer
end

local PlayerData = {}

local function CalculateVelocity(part)
	if not part then return Vector3.new(0,0,0) end

	local character = part:FindFirstAncestorOfClass("Model")
	if not character then return Vector3.new(0,0,0) end

	if not PlayerData[character] then
		PlayerData[character] = {
			LastPos = part.Position
		}
	end

	local data = PlayerData[character]

	local current = part.Position
	local last = data.LastPos

	local vel = (current - last) / RunService.Heartbeat:Wait()

	data.LastPos = current

	return vel
end

local enemy = nil
local LastDownTarget = nil

RunService.Heartbeat:Connect(function()
	if not CamlockState then return end
	if not enemy then return end

	local character = enemy:FindFirstAncestorOfClass("Model")
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")

	-- ❌ invalid target
	if not character or not humanoid then
		CamlockState = false
		enemy = nil
		return
	end

	-- 💀 DOWN CHECK (INSIDE LOOP)
	local isDown =
		humanoid.Health <= 0
		or humanoid:GetState() == Enum.HumanoidStateType.Dead
		or humanoid.PlatformStand == true

	if isDown then
		if LastDownTarget ~= character then
			LastDownTarget = character
			Notify(" R.I.P bading :sob:")
		end

		CamlockState = false
		enemy = nil
		return
	end

	-- 🔧 velocity
	local velocity
	if ResolverEnabled then
		velocity = CalculateVelocity(enemy)
	else
		velocity = enemy.Velocity
	end

	-- 🎯 camlock
local camera = workspace.CurrentCamera
camera.CFrame = CFrame.new(
camera.CFrame.Position,
enemy.Position + velocity * Prediction
)
end)

local ResolverEnabled = false

UserInputService.InputBegan:Connect(function(input, gp)
	if gp then return end

	if input.KeyCode == Enum.KeyCode.N then
		ResolverEnabled = not ResolverEnabled
		print("Resolver:", ResolverEnabled)
	end
end)

local Vascal = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Logo = Instance.new("ImageLabel")
local TextButton = Instance.new("TextButton")
local UICorner_2 = Instance.new("UICorner")

Logo.Name = "Logo"
Logo.Parent = Frame
Logo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Logo.BackgroundTransparency = 5.000
Logo.BorderColor3 = Color3.fromRGB(0, 0, 0)
Logo.BorderSizePixel = 0
Logo.Position = UDim2.new(0.326732665, 0, 0, 0)
Logo.Size = UDim2.new(0, 70, 0, 70)
Logo.Image = "rbxthumb://type=Asset&id=117761317770889&w=150&h=150"
Logo.ImageTransparency = 0.2

Vascal.Name = "Vascal"
Vascal.Parent = game.CoreGui
Vascal.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Frame.Parent = Vascal
Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.133798108, 0, 0.20107238, 0)
Frame.Size = UDim2.new(0, 202, 0, 70)
Frame.Active = true
Frame.Draggable = true

local function TopContainer()
    Frame.Position = UDim2.new(0.5, -Frame.AbsoluteSize.X / 2, 0, -Frame.AbsoluteSize.Y / 2)
end

TopContainer()
Frame:GetPropertyChangedSignal("AbsoluteSize"):Connect(TopContainer)

UICorner.Parent = Frame

local function Rainbow()
    local rainbowColors = {
        Color3.fromRGB(255, 0, 0),
        Color3.fromRGB(255, 127, 0),
        Color3.fromRGB(255, 255, 0),
        Color3.fromRGB(0, 255, 0),
        Color3.fromRGB(0, 0, 255),
        Color3.fromRGB(75, 0, 130),
        Color3.fromRGB(148, 0, 211)
    }
    local interval = 0.2
    local index = 1
    while true do
        TextButton.TextColor3 = rainbowColors[index]
        index = index % #rainbowColors + 1
        wait(interval)
    end
end

coroutine.wrap(Rainbow)()

TextButton.Parent = Frame
TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextButton.BackgroundTransparency = 5.000
TextButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextButton.BorderSizePixel = 0
TextButton.Position = UDim2.new(0.0792079195, 0, 0.18571429, 0)
TextButton.Size = UDim2.new(0, 170, 0, 44)
TextButton.Font = Enum.Font.Arcade
TextButton.Text = ""
TextButton.TextScaled = true
TextButton.TextSize = 11.000
TextButton.TextWrapped = true

local state = true
TextButton.MouseButton1Click:Connect(function()
	state = not state

	if not state then
		CamlockState = true
		enemy = FindNearestEnemy()

		if enemy then
			CamlockNotify("Camlock Enabled", 2)
		else
			CamlockNotify("No Target Found", 2)
		end

	else
		CamlockState = false
		enemy = nil
		CamlockNotify("Camlock Disabled", 2)
	end
end)

UICorner_2.Parent = TextButton

local Sound = Instance.new("Sound", game:GetService("SoundService"))
Sound.SoundId = "rbxassetid://"
Sound:Play()
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = ("Vascal made this script"),
    Text = "subscribe to Vascal",
    Icon = "rbxassetid://117761317770889"
})
Duration = 60

-- ===== VASCAL PREDICTION GUI (CLEAN STYLE) =====

local PredFrame = Instance.new("Frame")
PredFrame.Parent = Vascal
PredFrame.ClipsDescendants = true
PredFrame.Size = UDim2.new(0, 200, 0, 170)
PredFrame.Position = UDim2.new(0.65, 0, 0.55, 0)
PredFrame.BackgroundColor3 = Color3.fromRGB(18,18,18)
PredFrame.BorderSizePixel = 0
PredFrame.Active = true
PredFrame.Draggable = true

table.insert(UIFrames, PredFrame)

local Corner = Instance.new("UICorner", PredFrame)
Corner.CornerRadius = UDim.new(0,8)

local Stroke = Instance.new("UIStroke", PredFrame)
Stroke.Color = Color3.fromRGB(60, 120, 255)
Stroke.Transparency = 0.4
Stroke.Thickness = 1

-- TITLE
local Title = Instance.new("TextLabel")
Title.Parent = PredFrame
Title.Size = UDim2.new(1, 0, 0, 18)
Title.BackgroundTransparency = 1
Title.Text = "Vascal Prediction"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 11
Title.TextColor3 = Color3.fromRGB(180, 200, 255)

-- INPUT CREATOR (WITH LABEL)
local function createInput(y, name, default)
	local label = Instance.new("TextLabel")
	label.Parent = PredFrame
	label.Size = UDim2.new(1, -8, 0, 12)
	label.Position = UDim2.new(0, 4, 0, y)
	label.BackgroundTransparency = 1
	label.Text = name
	label.Font = Enum.Font.Gotham
	label.TextSize = 9
	label.TextColor3 = Color3.fromRGB(160,160,160)
	label.TextXAlignment = Enum.TextXAlignment.Left

	local box = Instance.new("TextBox")
	box.Parent = PredFrame
	box.Size = UDim2.new(1, -8, 0, 14)
	box.Position = UDim2.new(0, 4, 0, y + 12)
	box.BackgroundColor3 = Color3.fromRGB(28,28,28)
	box.TextColor3 = Color3.fromRGB(255,255,255)
	box.Font = Enum.Font.RobotoMono
	box.TextSize = 10
	box.Text = tostring(default)

	local c = Instance.new("UICorner", box)
	c.CornerRadius = UDim.new(0,4)

	return box
end

-- INPUTS WITH REAL NAMES
local HBox = createInput(18, "Horizontal Prediction", HorizontalPrediction)
local VBox = createInput(40, "Vertical Prediction", VerticalPrediction)
local XBox = createInput(62, "X Prediction", XPrediction)
local YBox = createInput(84, "Y Prediction", YPrediction)
local AirDelayBox = createInput(106, "Auto Air Delay", 0.12)

-- APPLY BUTTON
local Apply = Instance.new("TextButton")
Apply.Parent = PredFrame
Apply.Size = UDim2.new(1, -8, 0, 16)
Apply.Position = UDim2.new(0, 4, 1, -18)
Apply.BackgroundColor3 = Color3.fromRGB(35,35,35)
Apply.Text = "Apply"
Apply.Font = Enum.Font.GothamBold
Apply.TextSize = 10
Apply.TextColor3 = Color3.fromRGB(120, 200, 255)

local BtnCorner = Instance.new("UICorner", Apply)
BtnCorner.CornerRadius = UDim.new(0,5)

-- APPLY FUNCTION
Apply.MouseButton1Click:Connect(function()
	local h = tonumber(HBox.Text)
	local v = tonumber(VBox.Text)
	local x = tonumber(XBox.Text)
	local y = tonumber(YBox.Text)

	if h then HorizontalPrediction = h end
	if v then VerticalPrediction = v end
	if x then XPrediction = x end
	if y then YPrediction = y end
end)

-- ===== SMALL + DRAGGABLE AUTO AIR =====

local AutoAirFrame = Instance.new("Frame")
AutoAirFrame.Parent = Vascal
AutoAirFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
AutoAirFrame.BorderSizePixel = 0
AutoAirFrame.Size = UDim2.new(0, 95, 0, 28)
AutoAirFrame.Position = UDim2.new(0.02, 0, 0.32, 0)
AutoAirFrame.Active = true
AutoAirFrame.Draggable = true

table.insert(UIFrames, AutoAirFrame)

local AutoCorner = Instance.new("UICorner")
AutoCorner.CornerRadius = UDim.new(0, 8)
AutoCorner.Parent = AutoAirFrame

local Stroke = Instance.new("UIStroke")
Stroke.Color = Color3.fromRGB(60, 60, 60)
Stroke.Thickness = 1
Stroke.Transparency = 0.2
Stroke.Parent = AutoAirFrame

-- BUTTON (slightly smaller inside so frame can drag)
local AutoAirButton = Instance.new("TextButton")
AutoAirButton.Parent = AutoAirFrame
AutoAirButton.BackgroundTransparency = 1
AutoAirButton.Size = UDim2.new(1, -6, 1, -6)
AutoAirButton.Position = UDim2.new(0, 3, 0, 3)
AutoAirButton.Font = Enum.Font.GothamBold
AutoAirButton.TextScaled = true
AutoAirButton.Text = "AUTO AIR OFF"
AutoAirButton.TextColor3 = Color3.fromRGB(255, 80, 80)

-- IMPORTANT: allow dragging through button
AutoAirButton.Active = false

local Glow = Instance.new("UIStroke")
Glow.Thickness = 2
Glow.Transparency = 0.6
Glow.Color = Color3.fromRGB(255, 80, 80)
Glow.Parent = AutoAirButton

AutoAirButton.MouseButton1Click:Connect(function()
    AutoAirEnabled = not AutoAirEnabled

    if AutoAirEnabled then
        AutoAirButton.Text = "AUTO AIR ON"
        AutoAirButton.TextColor3 = Color3.fromRGB(100, 255, 100)
        Glow.Color = Color3.fromRGB(100, 255, 100)
    else
        AutoAirButton.Text = "AUTO AIR OFF"
        AutoAirButton.TextColor3 = Color3.fromRGB(255, 80, 80)
        Glow.Color = Color3.fromRGB(255, 80, 80)
    end
end)

-- smooth glow
task.spawn(function()
    while true do
        for i = 0.6, 0.9, 0.02 do
            Glow.Transparency = i
            task.wait(0.01)
        end
        for i = 0.9, 0.6, -0.02 do
            Glow.Transparency = i
            task.wait(0.01)
        end
    end
end)

local RunService = game:GetService("RunService")

local lastTrigger = 0
local cooldown = 0.35

RunService.Heartbeat:Connect(function()
	if not AutoAirEnabled then return end
	if not CamlockState then return end
	if not enemy or not enemy.Parent then return end

	local character = enemy:FindFirstAncestorOfClass("Model")
	if not character then return end

	local root = character:FindFirstChild("HumanoidRootPart")
	if not root then return end

	-- 🚀 detect REAL jump (strong upward motion)
	if root.Velocity.Y > 25 then
		if tick() - lastTrigger > cooldown then
			lastTrigger = tick()

			-- ⏱ small delay like veerve (THIS IS THE MAGIC)
			task.wait(tonumber(AirDelayBox.Text) or 0.12)

			-- 🎯 slight prediction (your style)
			local predicted = root.Position + (root.Velocity * 0.10)

			workspace.CurrentCamera.CFrame = CFrame.new(
				workspace.CurrentCamera.CFrame.Position,
				predicted
			)

			-- 💥 shoot
			local tool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")
				if tool then
				tool:Activate()
			end
		end
	end
end)

-- PC support: Keybind for toggling Camlock and Auto Air
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end

    -- T key for toggling Camlock
    if input.KeyCode == Enum.KeyCode.Q then
        state = not state
        if not state then
            TextButton.Text = "Vascal V2 ON"
            CamlockState = true
            enemy = FindNearestEnemy()
        else
            TextButton.Text = "Vascal V2 OFF"
            CamlockState = false
            enemy = nil
        end
    end

    -- R key for toggling Auto Air
    if input.KeyCode == Enum.KeyCode.V then
        AutoAirEnabled = not AutoAirEnabled
        AutoAirButton.Text = AutoAirEnabled and "Auto Air: ON" or "Auto Air: OFF"
    end
end)

-- ===== MINI PREDICTION GUI (SMALL + CLEAN) =====

local PredFrame = Instance.new("Frame")
PredFrame.Parent = Vascal
PredFrame.Size = UDim2.new(0, 95, 0, 40) -- smaller
PredFrame.Position = UDim2.new(0.5, -45, 0.55, 0)
PredFrame.BackgroundColor3 = Color3.fromRGB(18,18,18)
PredFrame.BorderSizePixel = 0
PredFrame.Active = true
PredFrame.Draggable = true

table.insert(UIFrames, PredFrame)

local PredCorner = Instance.new("UICorner", PredFrame)
PredCorner.CornerRadius = UDim.new(0,6)

local Stroke = Instance.new("UIStroke", PredFrame)
Stroke.Color = Color3.fromRGB(60,60,60)
Stroke.Thickness = 1
Stroke.Transparency = 0.3

-- INPUT (smaller)
local PredBox = Instance.new("TextBox")
PredBox.Parent = PredFrame
PredBox.Size = UDim2.new(1, -6, 0.5, -2)
PredBox.Position = UDim2.new(0,3,0,3)
PredBox.BackgroundColor3 = Color3.fromRGB(25,25,25)
PredBox.TextColor3 = Color3.fromRGB(255,0,0)
PredBox.TextScaled = true
PredBox.Font = Enum.Font.RobotoMono
PredBox.PlaceholderText = "pred"
PredBox.Text = tostring(Prediction)

local BoxCorner = Instance.new("UICorner", PredBox)
BoxCorner.CornerRadius = UDim.new(0,4)

local Glow = Instance.new("UIStroke")
Glow.Thickness = 2
Glow.Transparency = 0.6
Glow.Color = Color3.fromRGB(255, 80, 80)
Glow.Parent = PredBox

-- APPLY BUTTON (tiny)
local ApplyBtn = Instance.new("TextButton")
ApplyBtn.Parent = PredFrame
ApplyBtn.Size = UDim2.new(1, -6, 0.5, -4)
ApplyBtn.Position = UDim2.new(0,3,0.5,2)
ApplyBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
ApplyBtn.Text = "SET"
ApplyBtn.TextScaled = true
ApplyBtn.Font = Enum.Font.GothamBold
ApplyBtn.TextColor3 = Color3.fromRGB(120,200,255)

local BtnCorner = Instance.new("UICorner", ApplyBtn)
BtnCorner.CornerRadius = UDim.new(0,4)

-- smooth glow
task.spawn(function()
    while true do
        for i = 0.6, 0.9, 0.02 do
            Glow.Transparency = i
            task.wait(0.01)
        end
        for i = 0.9, 0.6, -0.02 do
            Glow.Transparency = i
            task.wait(0.01)
        end
    end
end)

-- APPLY FUNCTION
ApplyBtn.MouseButton1Click:Connect(function()
	local val = tonumber(PredBox.Text)
	if val then
		Prediction = val
	end
end)

PredBox.Active = false
ApplyBtn.Active = false

-- ===== MINI AUTO PRED + PING VIEW =====

local Stats = game:GetService("Stats")

local AutoPredEnabled = false

local APFrame = Instance.new("Frame")
APFrame.Parent = Vascal
APFrame.Size = UDim2.new(0, 100, 0, 45) -- small but usable
APFrame.Position = UDim2.new(0.65, 0, 0.55, 0)
APFrame.BackgroundColor3 = Color3.fromRGB(18,18,18)
APFrame.BorderSizePixel = 0
APFrame.Active = true
APFrame.Draggable = true

table.insert(UIFrames, APFrame)

local APCorner = Instance.new("UICorner", APFrame)
APCorner.CornerRadius = UDim.new(0,6)

local Stroke = Instance.new("UIStroke", APFrame)
Stroke.Color = Color3.fromRGB(60,60,60)
Stroke.Thickness = 1
Stroke.Transparency = 0.4

-- PING TEXT
local PingLabel = Instance.new("TextLabel")
PingLabel.Parent = APFrame
PingLabel.Size = UDim2.new(1,0,0.5,0)
PingLabel.BackgroundTransparency = 1
PingLabel.Font = Enum.Font.RobotoMono
PingLabel.TextScaled = true
PingLabel.TextColor3 = Color3.fromRGB(180,180,180)
PingLabel.Text = "Ping: ..."

-- TOGGLE BUTTON
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Parent = APFrame
ToggleBtn.Size = UDim2.new(1, -6, 0.5, -4)
ToggleBtn.Position = UDim2.new(0,3,0.5,2)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextScaled = true
ToggleBtn.Text = "auto prediction: OFF"
ToggleBtn.TextColor3 = Color3.fromRGB(255,80,80)

local BtnCorner = Instance.new("UICorner", ToggleBtn)
BtnCorner.CornerRadius = UDim.new(0,4)

-- TOGGLE LOGIC
ToggleBtn.MouseButton1Click:Connect(function()
	AutoPredEnabled = not AutoPredEnabled
	
	if AutoPredEnabled then
		ToggleBtn.Text = "auto prediction: ON"
		ToggleBtn.TextColor3 = Color3.fromRGB(100,255,100)
	else
		ToggleBtn.Text = "auto prediction: OFF"
		ToggleBtn.TextColor3 = Color3.fromRGB(255,80,80)
	end
end)

-- PREDICTION BASED ON PING
local CurrentPrediction = Prediction

local PredTable = {
	[20] = 0.12588,
	[30] = 0.11,
	[40] = 0.125,
	[50] = 0.127668,
	[60] = 0.12731,
	[70] = 0.119,
	[80] = 0.1347,
	[90] = 0.136,
	[100] = 0.13034,
	[110] = 0.1455,
	[120] = 0.14376,
	[130] = 0.156692,
	[140] = 0.1223333,
	[150] = 0.15,
	[160] = 0.16,
	[170] = 0.1923111,
	[180] = 0.19284,
	[190] = 0.166547,
	[200] = 0.16942,
	[210] = 0.165566,
	[220] = 0.165566,
	[230] = 0.15692,
	[240] = 0.16780,
	[250] = 0.1651,
	[260] = 0.175566,
	[270] = 0.195566,
	[280] = 0.16780,
	[300] = 0.284638
}

local function getPredictionFromPing(ping)
	local closest = nil
	local diff = math.huge

	for k, v in pairs(PredTable) do
		local d = math.abs(ping - k)
		if d < diff then
			diff = d
			closest = v
		end
	end

	return closest or 0.15
end

-- UPDATE LOOP
task.spawn(function()
	while true do
		local pingStr = Stats.Network.ServerStatsItem["Data Ping"]:GetValueString()
		local ping = tonumber(string.match(pingStr, "%d+")) or 0
		
		PingLabel.Text = "Ping: "..ping.."ms"
		
		if AutoPredEnabled then
			local targetPred = getPredictionFromPing(ping)

			-- 🔥 SMOOTH TRANSITION (no snapping)
			CurrentPrediction = CurrentPrediction + (targetPred - CurrentPrediction) * 0.2
			
			Prediction = CurrentPrediction
		end
		
		task.wait(0.1)
	end
end)

local HideFrame = Instance.new("Frame")
HideFrame.Parent = Vascal
HideFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
HideFrame.Size = UDim2.new(0, 95, 0, 28)
HideFrame.Position = UDim2.new(0.3, 0, 0.75, 0)
HideFrame.Active = true
HideFrame.Draggable = true

local Corner = Instance.new("UICorner", HideFrame)
Corner.CornerRadius = UDim.new(0, 8)

local Stroke = Instance.new("UIStroke", HideFrame)
Stroke.Color = Color3.fromRGB(60, 60, 60)
Stroke.Thickness = 1
Stroke.Transparency = 0.2

local HideButton = Instance.new("TextButton")
HideButton.Parent = HideFrame
HideButton.BackgroundTransparency = 1
HideButton.Size = UDim2.new(1, -4, 1, -4)
HideButton.Position = UDim2.new(0, 2, 0, 2)
HideButton.Font = Enum.Font.GothamBold
HideButton.TextScaled = true
HideButton.Text = "HIDE UI"
HideButton.TextColor3 = Color3.fromRGB(255, 80, 80)
HideButton.Active = false

HideButton.MouseButton1Click:Connect(function()
	HideAllEnabled = not HideAllEnabled

	HideButton.Text = HideAllEnabled and "SHOW UI" or "HIDE UI"

	-- ONLY hide registered UI frames (NOT camlock)
	for _, frame in ipairs(UIFrames) do
		if frame then
			frame.Visible = not HideAllEnabled
		end
	end

	-- always keep hide button visible
	HideFrame.Visible = true
end)

local AkaliNotif = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/Dynissimo/main/Scripts/AkaliNotif.lua"))();
local Notify = AkaliNotif.Notify;
Notify({
Description = "For pc the keybind is Auto air = V Camlock = Q";
Title = "Vascal v2 and V3 is on my discord";
Duration = 10;
});
mouse = game.Players.LocalPlayer:GetMouse()



		-- ÃƒÂ°Ã…Â¸Ã…â€™Ã‹â€  RAINBOW + HIGHLIGHT ONLY (NO RING)

local hue = 0
local highlight = nil
local textLabel = nil
local lastHP = {}

RunService.Heartbeat:Connect(function(dt)
	if CamlockState and enemy and enemy.Parent then
		local char = enemy.Parent

		-- ÃƒÂ°Ã…Â¸Ã…â€™Ã‹â€  RAINBOW HIGHLIGHT (cleaner)
		if not highlight then
			highlight = Instance.new("Highlight")
			highlight.FillTransparency = 0.35
			highlight.OutlineTransparency = 0
			highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
			highlight.Parent = char
		end

		hue = (hue + dt * 0.3) % 1
		highlight.FillColor = Color3.fromHSV(hue, 1, 1)
		highlight.OutlineColor = Color3.fromRGB(0,0,0)
		
-- ÃƒÂ°Ã…Â¸Ã¢â‚¬â„¢Ã‚Â¥ HIT EFFECT (RAINBOW HOLOGRAM FIXED)
local SoundService = game:GetService("SoundService")

local HitSound = Instance.new("Sound")
HitSound.SoundId = "rbxassetid://136561900676276" -- you can change this later
HitSound.Volume = 5
HitSound.Parent = SoundService

		local hum = char:FindFirstChild("Humanoid")
		if hum then
			lastHP[hum] = lastHP[hum] or hum.Health

			if hum.Health < lastHP[hum] then
			HitSound:Play()
				local count = 0
for _,v in ipairs(char:GetDescendants()) do
    if v:IsA("BasePart") then
        count += 1
        if count > 5 then break end -- LIMIT PARTS

						local ghost = Instance.new("Part")
						ghost.Size = v.Size
						ghost.CFrame = v.CFrame
						ghost.Anchored = true
						ghost.CanCollide = false
						ghost.Material = Enum.Material.Neon
						ghost.Color = Color3.fromHSV(math.random(), 1, 1)
						ghost.Transparency = 0.4
						ghost.Parent = workspace

						task.spawn(function()
							for i = 1, 18 do
								ghost.Transparency += 0.04
								task.wait(0.05)
							end
							ghost:Destroy()
						end)
					end
				end
			end

			lastHP[hum] = hum.Health
		end

	else
		-- cleanup
		if highlight then highlight:Destroy() highlight = nil end
		if textLabel then textLabel:Destroy() textLabel = nil end
		lastHP = {}
	end
end)

local function ToggleAnim(button, enabled, glow)
    -- color
    local targetColor = enabled and Color3.fromRGB(100,255,100) or Color3.fromRGB(255,80,80)

        -- tween color
    game:GetService("TweenService"):Create(
        button,
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {TextColor3 = targetColor}
    ):Play()

    glow.Color = targetColor

    -- little "pop" animation
    button.Size = UDim2.new(1, -6, 1, -6)
    button:TweenSize(
        UDim2.new(1, -2, 1, -2),
        Enum.EasingDirection.Out,
        Enum.EasingStyle.Quad,
        0.1,
        true,
        function()
            button:TweenSize(
                UDim2.new(1, -6, 1, -6),
                Enum.EasingDirection.Out,
                Enum.EasingStyle.Quad,
                0.1,
                true
            )
        end
    )
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

-- =========================
-- STATES
-- =========================
local AutoReloadEnabled = false
local AutoStompEnabled = false

-- =========================
-- AUTO RELOAD UI
-- =========================
local ReloadFrame = Instance.new("Frame")
ReloadFrame.Parent = Vascal
ReloadFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ReloadFrame.BorderSizePixel = 0
ReloadFrame.Size = UDim2.new(0, 95, 0, 28)
ReloadFrame.Position = UDim2.new(0.02, 0, 0.39, 0)
ReloadFrame.Active = true
ReloadFrame.Draggable = true

table.insert(UIFrames, ReloadFrame)

local ReloadCorner = Instance.new("UICorner", ReloadFrame)
ReloadCorner.CornerRadius = UDim.new(0, 8)

local ReloadStroke = Instance.new("UIStroke", ReloadFrame)
ReloadStroke.Color = Color3.fromRGB(60, 60, 60)
ReloadStroke.Thickness = 1
ReloadStroke.Transparency = 0.2

local ReloadButton = Instance.new("TextButton")
ReloadButton.Parent = ReloadFrame
ReloadButton.BackgroundTransparency = 1
ReloadButton.Size = UDim2.new(1, -6, 1, -6)
ReloadButton.Position = UDim2.new(0, 3, 0, 3)
ReloadButton.Font = Enum.Font.GothamBold
ReloadButton.TextScaled = true
ReloadButton.Text = "AUTO RELOAD OFF"
ReloadButton.TextColor3 = Color3.fromRGB(255, 80, 80)
ReloadButton.Active = false

local ReloadGlow = Instance.new("UIStroke", ReloadButton)
ReloadGlow.Thickness = 2
ReloadGlow.Transparency = 0.6
ReloadGlow.Color = Color3.fromRGB(255, 80, 80)

ReloadButton.MouseButton1Click:Connect(function()
	AutoReloadEnabled = not AutoReloadEnabled

	if AutoReloadEnabled then
		ReloadButton.Text = "AUTO RELOAD ON"
	else
		ReloadButton.Text = "AUTO RELOAD OFF"
	end

	ToggleAnim(ReloadButton, AutoReloadEnabled, ReloadGlow)
end)

task.spawn(function()
	while true do
		for i = 0.6, 0.9, 0.02 do
			ReloadGlow.Transparency = i
			task.wait(0.01)
		end
		for i = 0.9, 0.6, -0.02 do
			ReloadGlow.Transparency = i
			task.wait(0.01)
		end
	end
end)

-- =========================
-- AUTO STOMP UI
-- =========================
local StompFrame = Instance.new("Frame")
StompFrame.Parent = Vascal
StompFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
StompFrame.BorderSizePixel = 0
StompFrame.Size = UDim2.new(0, 95, 0, 28)
StompFrame.Position = UDim2.new(0.02, 0, 0.46, 0)
StompFrame.Active = true
StompFrame.Draggable = true

table.insert(UIFrames, StompFrame)

local StompCorner = Instance.new("UICorner", StompFrame)
StompCorner.CornerRadius = UDim.new(0, 8)

local StompStroke = Instance.new("UIStroke", StompFrame)
StompStroke.Color = Color3.fromRGB(60, 60, 60)
StompStroke.Thickness = 1
StompStroke.Transparency = 0.2

local StompButton = Instance.new("TextButton")
StompButton.Parent = StompFrame
StompButton.BackgroundTransparency = 1
StompButton.Size = UDim2.new(1, -6, 1, -6)
StompButton.Position = UDim2.new(0, 3, 0, 3)
StompButton.Font = Enum.Font.GothamBold
StompButton.TextScaled = true
StompButton.Text = "AUTO STOMP OFF"
StompButton.TextColor3 = Color3.fromRGB(255, 80, 80)
StompButton.Active = false

local StompGlow = Instance.new("UIStroke", StompButton)
StompGlow.Thickness = 2
StompGlow.Transparency = 0.6
StompGlow.Color = Color3.fromRGB(255, 80, 80)

StompButton.MouseButton1Click:Connect(function()
	AutoStompEnabled = not AutoStompEnabled

	if AutoStompEnabled then
		StompButton.Text = "AUTO STOMP ON"
	else
		StompButton.Text = "AUTO STOMP OFF"
	end

	ToggleAnim(StompButton, AutoStompEnabled, StompGlow)
end)

task.spawn(function()
	while true do
		for i = 0.6, 0.9, 0.02 do
			StompGlow.Transparency = i
			task.wait(0.01)
		end
		for i = 0.9, 0.6, -0.02 do
			StompGlow.Transparency = i
			task.wait(0.01)
		end
	end
end)

-- =========================
-- AUTO FUNCTIONS (your logic kept)
-- =========================

RunService.RenderStepped:Connect(function()

	-- AUTO RELOAD
	if AutoReloadEnabled then
		local plr = game.Players.LocalPlayer
		if plr.Character then
			local tool = plr.Character:FindFirstChildWhichIsA("Tool")
			if tool then
				local ammo = tool:FindFirstChild("AMMO")
				if ammo and ammo.Value <= 0 then
					if tool:FindFirstChild("rl") then
						tool.rl:FireServer()
					end
				end
			end
		end
	end

	-- AUTO STOMP
	if AutoStompEnabled then
		local remote = game.ReplicatedStorage:FindFirstChild("MAINEVENT")
		if remote then
			remote:FireServer("STOMP")
		end
	end
	
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")
end)

loadstring(game:HttpGet("https://pastebin.com/raw/9qmED6EV",true))()