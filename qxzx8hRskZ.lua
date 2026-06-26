-- [[ SCRIPT MANIAC HUB: PERFECT REVENGE SYSTEM ]] --

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local Camera = workspace.CurrentCamera

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Global Controls Definition
_G.Tabs = {}
_G.CurrentAimbotTarget = nil
_G.AimOn = false
_G.NoRecoilOn = false
_G.CrosshairOn = true
_G.EspOn = false 
_G.InvinceTrack = false
_G.AutoShootOn = false
_G.TargetByClosest3D = true 
_G.RevengeMode = true -- True = Priority to player attacking you

-- Perfect Revenge Tracking Variables
local LastLocalHealth = 100
local RevengeTargetPlayer = nil

local AIMBOT_FOV = 250
local crosshairSize = 6
local crosshairGap = 2
local crosshairThickness = 1

--// CORE SYSTEM INTERFACE (GUI GENERATION)
local gui = Instance.new("ScreenGui", PlayerGui)
gui.Name = "khizargamerz"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true

local mainFrame = Instance.new("Frame", gui)
mainFrame.Size = UDim2.new(0, 420, 0, 320)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 10)

-- Helper function to make frames draggable
local function makeDraggable(frame, isIcon, clickCallback)
	local dragging, dragInput, dragStart, startPos
	local dragMoved = false

	frame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragMoved = false
			dragStart = input.Position
			startPos = frame.Position
			
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
					if isIcon and not dragMoved and clickCallback then
						clickCallback()
					end
				end
			end)
		end
	end)

	frame.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if dragging and input == dragInput then
			local delta = input.Position - dragStart
			if delta.Magnitude > 5 then
				dragMoved = true
			end
			frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)
end

makeDraggable(mainFrame, false)

-- Floating Icon Setup
local openButton = Instance.new("TextButton", gui)
openButton.Size = UDim2.new(0, 55, 0, 55)
openButton.Position = UDim2.new(0.1, 0, 0.1, 0)
openButton.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
openButton.Text = "K"
openButton.TextColor3 = Color3.fromRGB(255, 255, 255)
openButton.TextSize = 24
openButton.Visible = false
Instance.new("UICorner", openButton).CornerRadius = UDim.new(1, 0)

makeDraggable(openButton, true, function()
	mainFrame.Visible = true
	openButton.Visible = false
end)

local closeButton = Instance.new("TextButton", mainFrame)
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -35, 0, 5)
closeButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", closeButton).CornerRadius = UDim.new(0, 6)
closeButton.MouseButton1Click:Connect(function() 
	mainFrame.Visible = false
	openButton.Visible = true 
end)

local title = Instance.new("TextLabel", mainFrame)
title.Size = UDim2.new(1, -40, 0, 40)
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.Text = "Script Maniac Hub (V5 Revenge)"
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextXAlignment = Enum.TextXAlignment.Left

-- Tab Container Setup
local tabButtons = Instance.new("Frame", mainFrame)
tabButtons.Size = UDim2.new(1, 0, 0, 35)
tabButtons.Position = UDim2.new(0, 0, 0, 40)
tabButtons.BackgroundTransparency = 1

local tabLayout = Instance.new("UIListLayout", tabButtons)
tabLayout.FillDirection = Enum.FillDirection.Horizontal
tabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
tabLayout.Padding = UDim.new(0, 5)

local tabContent = Instance.new("Frame", mainFrame)
tabContent.Size = UDim2.new(1, -20, 1, -90)
tabContent.Position = UDim2.new(0, 10, 0, 85)
tabContent.BackgroundTransparency = 1

local tabs = { Combat = Instance.new("ScrollingFrame"), Player = Instance.new("ScrollingFrame"), Config = Instance.new("ScrollingFrame") }
_G.Tabs = tabs

local function switchTo(tabName)
	for name, frame in pairs(tabs) do frame.Visible = (name == tabName) end
	for _, b in ipairs(tabButtons:GetChildren()) do
		if b:IsA("TextButton") then b.BackgroundColor3 = (b.Name == tabName .. "Button") and Color3.fromRGB(80, 80, 90) or Color3.fromRGB(40, 40, 40) end
	end
end

for name, frame in pairs(tabs) do
	frame.Size = UDim2.new(1, 0, 1, 0)
	frame.BackgroundTransparency = 1
	frame.Visible = false
	frame.CanvasSize = UDim2.new(0, 0, 0, 300)
	frame.ScrollBarThickness = 2
	frame.Parent = tabContent
	
	local layout = Instance.new("UIListLayout", frame)
	layout.Padding = UDim.new(0, 6)

	local btn = Instance.new("TextButton", tabButtons)
	btn.Name = name .. "Button"
	btn.Size = UDim2.new(0, 120, 1, 0)
	btn.Text = name
	btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.Font = Enum.Font.GothamBold
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
	btn.MouseButton1Click:Connect(function() switchTo(name) end)
end
switchTo("Combat")

--// FRAMEWORK UTILITIES (BUTTON CREATORS)
local function createToggle(parentTab, text, globalVar, callback)
	local b = Instance.new("TextButton", parentTab)
	b.Size = UDim2.new(1, 0, 0, 35)
	b.BackgroundColor3 = _G[globalVar] and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(45, 45, 50)
	b.TextColor3 = Color3.new(1,1,1)
	b.Font = Enum.Font.GothamBold
	b.TextSize = 15
	b.Text = text .. ": " .. (_G[globalVar] and "ON" or "OFF")
	Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
	
	b.MouseButton1Click:Connect(function()
		_G[globalVar] = not _G[globalVar]
		b.Text = text .. ": " .. (_G[globalVar] and "ON" or "OFF")
		b.BackgroundColor3 = _G[globalVar] and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(45, 45, 50)
		if callback then callback(_G[globalVar]) end
	end)
	return b
end

--// ENGINE MECHANICS
local function isEnemy(p)
	if p == LocalPlayer or not p.Character or not p.Character:FindFirstChild("HumanoidRootPart") then return false end
	local hum = p.Character:FindFirstChildOfClass("Humanoid")
	if not hum or hum.Health <= 0 then return false end
	if not _G.InvinceTrack and p.Character:FindFirstChildOfClass("ForceField") then return false end
	if LocalPlayer.Team and p.Team and LocalPlayer.Team == p.Team then return false end
	return true
end

-- Toggles Allocation
createToggle(tabs.Combat, "Op Aimbot", "AimOn")
createToggle(tabs.Combat, "Nullify Gun Recoil", "NoRecoilOn")
createToggle(tabs.Combat, "Auto Shoot Engine", "AutoShootOn")
createToggle(tabs.Combat, "Target Closest Player", "TargetByClosest3D")
createToggle(tabs.Combat, "Prioritize Attacker", "RevengeMode")

-- ESP Toggle Added to Config
createToggle(tabs.Config, "Player ESP Box", "EspOn")

local crosshair = { top = Drawing.new("Line"), bottom = Drawing.new("Line"), left = Drawing.new("Line"), right = Drawing.new("Line") }
for _, l in pairs(crosshair) do l.Color = Color3.new(1,0,0); l.Thickness = crosshairThickness; l.Visible = _G.CrosshairOn end
createToggle(tabs.Config, "Screen Crosshair", "CrosshairOn", function(state)
	for _, l in pairs(crosshair) do l.Visible = state end
end)

createToggle(tabs.Config, "Target Spawn Protection", "InvinceTrack")

-- RESET LOGIC: Reset target on LocalPlayer Death/Spawn
LocalPlayer.CharacterAdded:Connect(function(char)
	RevengeTargetPlayer = nil
	LastLocalHealth = 100
end)

--// ADVANCED ESP STORAGE & GENERATION SYSTEM
local espObjects = {}

local function createEsp(player)
	if espObjects[player] then return end
	
	local box = Drawing.new("Square")
	box.Visible = false
	box.Color = Color3.fromRGB(255, 0, 50)
	box.Thickness = 1.5
	box.Filled = false

	local text = Drawing.new("Text")
	text.Visible = false
	text.Color = Color3.fromRGB(255, 255, 255)
	text.Size = 14
	text.Center = true
	text.Outline = true

	espObjects[player] = {Box = box, Text = text}
end

local function removeEsp(player)
	if espObjects[player] then
		espObjects[player].Box:Destroy()
		espObjects[player].Text:Destroy()
		espObjects[player] = nil
	end
end

Players.PlayerAdded:Connect(createEsp)
Players.PlayerRemoving:Connect(removeEsp)
for _, p in ipairs(Players:GetPlayers()) do if p ~= LocalPlayer then createEsp(p) end end

-- Teleport Subsystem
local selectedPlayer = nil
local dropdown = Instance.new("TextButton", tabs.Player)
dropdown.Size = UDim2.new(1, 0, 0, 35)
dropdown.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
dropdown.TextColor3 = Color3.new(1,1,1)
dropdown.Text = "Select Target Player"
dropdown.Font = Enum.Font.Gotham
Instance.new("UICorner", dropdown)

local scroll = Instance.new("ScrollingFrame", dropdown)
scroll.Size = UDim2.new(1, 0, 0, 100)
scroll.Position = UDim2.new(0, 0, 1, 5)
scroll.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
scroll.Visible = false
scroll.CanvasSize = UDim2.new(0,0,0,0)
local scrollLayout = Instance.new("UIListLayout", scroll)

local function refreshDropdown()
	scroll:ClearAllChildren()
	Instance.new("UIListLayout", scroll)
	local y = 0
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= LocalPlayer then
			local op = Instance.new("TextButton", scroll)
			op.Size = UDim2.new(1, 0, 0, 25)
			op.Text = p.Name
			op.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
			op.TextColor3 = Color3.new(1,1,1)
			op.MouseButton1Click:Connect(function()
				selectedPlayer = p
				dropdown.Text = "Target: " .. p.Name
				scroll.Visible = false
			end)
			y = y + 25
		end
	end
	scroll.CanvasSize = UDim2.new(0,0,0,y)
end
dropdown.MouseButton1Click:Connect(function() scroll.Visible = not scroll.Visible; refreshDropdown() end)

local tpBtn = Instance.new("TextButton", tabs.Player)
tpBtn.Size = UDim2.new(1, 0, 0, 35)
tpBtn.BackgroundColor3 = Color3.fromRGB(35, 120, 70)
tpBtn.Text = "Teleport To Selection"
tpBtn.TextColor3 = Color3.new(1,1,1)
tpBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", tpBtn)
tpBtn.MouseButton1Click:Connect(function()
	if selectedPlayer and selectedPlayer.Character and selectedPlayer.Character:FindFirstChild("HumanoidRootPart") then
		local myHRP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
		if myHRP then myHRP.CFrame = selectedPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0) end
	end
end)

--// RUNTIME CALCULATIONS LOOP (RENDERSTEPPED)
RunService.RenderStepped:Connect(function()
	local myHRP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	local myHum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
	local center = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
	
	-- FIXED ACTION: Accurate Hit-Detection 
	if myHum and _G.RevengeMode then
		if myHum.Health < LastLocalHealth and myHum.Health > 0 then
			local maxAttackerDist = math.huge
			for _, attacker in ipairs(Players:GetPlayers()) do
				if isEnemy(attacker) and attacker.Character and attacker.Character:FindFirstChild("HumanoidRootPart") then
					local currentTool = attacker.Character:FindFirstChildOfClass("Tool")
					if currentTool then 
						local worldDist = (myHRP.Position - attacker.Character.HumanoidRootPart.Position).Magnitude
						if worldDist < maxAttackerDist then
							maxAttackerDist = worldDist
							RevengeTargetPlayer = attacker
						end
					end
				end
			end
		end
		LastLocalHealth = myHum.Health
		
		-- FIXED ACTION: Zero target if attacker dies OR if you die
		if RevengeTargetPlayer and (not isEnemy(RevengeTargetPlayer) or myHum.Health <= 0) then
			RevengeTargetPlayer = nil
		end
	end

	-- Crosshair Calculation
	if _G.CrosshairOn then
		crosshair.top.From = Vector2.new(center.X, center.Y - crosshairGap - crosshairSize)
		crosshair.top.To = Vector2.new(center.X, center.Y - crosshairGap)
		crosshair.bottom.From = Vector2.new(center.X, center.Y + crosshairGap)
		crosshair.bottom.To = Vector2.new(center.X, center.Y + crosshairGap + crosshairSize)
		crosshair.left.From = Vector2.new(center.X - crosshairGap - crosshairSize, center.Y)
		crosshair.left.To = Vector2.new(center.X - crosshairGap)
		crosshair.right.From = Vector2.new(center.X + crosshairGap, center.Y)
		crosshair.right.To = Vector2.new(center.X + crosshairGap + crosshairSize, center.Y)
	end

	-- Target Scanning Logic & ESP Update Loop
	local bestTarget = nil
	local minScreenDist = math.huge
	local minWorldDist = math.huge

	-- Force Attacker Lock Override
	if _G.RevengeMode and RevengeTargetPlayer and isEnemy(RevengeTargetPlayer) and RevengeTargetPlayer.Character and RevengeTargetPlayer.Character:FindFirstChild("Head") then
		local _, onScreen = Camera:WorldToViewportPoint(RevengeTargetPlayer.Character.Head.Position)
		if onScreen then
			bestTarget = RevengeTargetPlayer
		end
	end

	for _, player in ipairs(Players:GetPlayers()) do
		local data = espObjects[player]
		if data then
			if _G.EspOn and isEnemy(player) and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Head") then
				local hrp = player.Character.HumanoidRootPart
				local head = player.Character.Head
				
				local hrpPos, hrpOnScreen = Camera:WorldToViewportPoint(hrp.Position)
				local headPos, headOnScreen = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0))
				local legPos, legOnScreen = Camera:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3, 0))

				if hrpOnScreen then
					local height = math.abs(headPos.Y - legPos.Y)
					local width = height / 1.5

					data.Box.Size = Vector2.new(width, height)
					data.Box.Position = Vector2.new(hrpPos.X - width / 2, headPos.Y)
					
					if _G.RevengeMode and player == RevengeTargetPlayer then
						data.Box.Color = Color3.fromRGB(255, 215, 0) -- Yellow Box
						data.Text.Text = "⚠️ [ATTACKER] " .. player.Name .. " [" .. math.round((myHRP.Position - hrp.Position).Magnitude) .. "m]"
					else
						data.Box.Color = Color3.fromRGB(255, 0, 50) -- Red Box
						data.Text.Text = player.Name .. " [" .. math.round((myHRP.Position - hrp.Position).Magnitude) .. "m]"
					end
					
					data.Box.Visible = true
					data.Text.Position = Vector2.new(hrpPos.X, headPos.Y - 20)
					data.Text.Visible = true
				else
					data.Box.Visible = false
					data.Text.Visible = false
				end
			else
				data.Box.Visible = false
				data.Text.Visible = false
			end
		end

		-- Standard Targeting (runs only if nobody is actively shooting you)
		if not bestTarget and myHRP and isEnemy(player) and player.Character and player.Character:FindFirstChild("Head") and player.Character:FindFirstChild("HumanoidRootPart") then
			local enemyHRP = player.Character.HumanoidRootPart
			local screenPos, onScreen = Camera:WorldToViewportPoint(player.Character.Head.Position)
			
			if onScreen then
				local screenDist = (Vector2.new(screenPos.X, screenPos.Y) - center).Magnitude
				
				if screenDist <= AIMBOT_FOV then
					if _G.TargetByClosest3D then
						local worldDist = (myHRP.Position - enemyHRP.Position).Magnitude
						if worldDist < minWorldDist then
							minWorldDist = worldDist
							bestTarget = player
						end
					else
						if screenDist < minScreenDist then
							minScreenDist = screenDist
							bestTarget = player
						end
					end
				end
			end
		end
	end

	_G.CurrentAimbotTarget = bestTarget

	-- LookAt Aimbot Execution
	if _G.AimOn and _G.CurrentAimbotTarget and _G.CurrentAimbotTarget.Character then
		local lockPart = _G.CurrentAimbotTarget.Character:FindFirstChild("Head") or _G.CurrentAimbotTarget.Character:FindFirstChild("HumanoidRootPart")
		if lockPart then
			Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, lockPart.Position)
		end
	end

	-- Recoil Override Logic
	if _G.NoRecoilOn then
		local recoilScript = Camera:FindFirstChild("CameraShake") or Camera:FindFirstChild("Recoil") or Camera:FindFirstChild("Kick")
		if recoilScript then pcall(function() recoilScript:Destroy() end) end
		
		local currentTool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")
		if currentTool and currentTool:FindFirstChild("Configuration") then
			for _, val in ipairs(currentTool.Configuration:GetChildren()) do
				if val:IsA("NumberValue") or val:IsA("IntValue") then
					if string.find(string.lower(val.Name), "recoil") or string.find(string.lower(val.Name), "kick") then
						val.Value = 0
					end
				end
			end
		end
	end
end)

-- Dedicated Auto Shoot Thread Loop
task.spawn(function()
	while true do
		task.wait(0.08)
		if _G.AutoShootOn and _G.CurrentAimbotTarget then
			local x, y = Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2
			VirtualInputManager:SendMouseButtonEvent(x, y, 0, true, game, 0)
			task.wait(0.01)
			VirtualInputManager:SendMouseButtonEvent(x, y, 0, false, game, 0)
		end
	end
end)

print("Combat Clean Revenge Added.")
