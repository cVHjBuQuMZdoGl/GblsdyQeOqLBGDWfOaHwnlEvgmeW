--// SERVICES
local player = game.Players.LocalPlayer  
local char = player.Character or player.CharacterAdded:Wait()  

local UIS = game:GetService("UserInputService")  
local RunService = game:GetService("RunService")  
local TweenService = game:GetService("TweenService")

--// DEFAULTS  
local defaultSpeed = 16  
local defaultJump = 50  

--// STATE  
local wsEnabled = false  
local jpEnabled = false  
local wsValue = 16  
local jpValue = 50  

--// GUI  
local gui = Instance.new("ScreenGui")  
gui.Parent = player:WaitForChild("PlayerGui")  

----------------------------------------------------
-- DRAG SYSTEM
----------------------------------------------------
local function makeDraggable(obj)
	local dragging = false
	local dragStart
	local startPos

	obj.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = obj.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	UIS.InputChanged:Connect(function(input)
		if not dragging then return end
		if input.UserInputType ~= Enum.UserInputType.MouseMovement and input.UserInputType ~= Enum.UserInputType.Touch then return end

		local delta = input.Position - dragStart

		obj.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end)
end

----------------------------------------------------
-- MAIN FRAME
----------------------------------------------------
local main = Instance.new("Frame")
main.Parent = gui
main.Size = UDim2.new(0, 280, 0, 140)
main.Position = UDim2.new(0.5, -140, 0.5, -70)
main.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
main.BackgroundTransparency = 0.25
main.BorderSizePixel = 0
main.Visible = false

Instance.new("UICorner", main).CornerRadius = UDim.new(0, 16)

makeDraggable(main)

----------------------------------------------------
-- SHADOW
----------------------------------------------------
local shadow = Instance.new("Frame")
shadow.Parent = gui
shadow.Size = main.Size
shadow.Position = main.Position
shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
shadow.BackgroundTransparency = 1
shadow.ZIndex = 0
shadow.Visible = false

Instance.new("UICorner", shadow).CornerRadius = UDim.new(0, 16)

----------------------------------------------------
-- TOPBAR
----------------------------------------------------
local topbar = Instance.new("Frame")
topbar.Parent = main
topbar.Size = UDim2.new(1, 0, 0, 32)
topbar.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
topbar.BorderSizePixel = 0

Instance.new("UICorner", topbar).CornerRadius = UDim.new(0, 16)

local grad = Instance.new("UIGradient")
grad.Parent = topbar
grad.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(28, 28, 28)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(38, 38, 38)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(22, 22, 22))
})

task.spawn(function()
	while topbar.Parent do
		for i = 0, 360, 1 do
			grad.Rotation = i
			task.wait(0.03)
		end
	end
end)

----------------------------------------------------
-- TITLE
----------------------------------------------------
local title = Instance.new("TextLabel")
title.Parent = topbar
title.Size = UDim2.new(1, -12, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.Text = "eu3.d ws & jp"

title.Font = Enum.Font.GothamBlack
title.TextSize = 15
title.TextXAlignment = Enum.TextXAlignment.Left
title.TextColor3 = Color3.fromRGB(170, 80, 80)

local titleGrad = Instance.new("UIGradient")
titleGrad.Parent = title
titleGrad.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(140, 50, 50)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(220, 120, 120))
})

----------------------------------------------------
-- CREDIT TEXT (DARKER FIX)
----------------------------------------------------
local credit = Instance.new("TextLabel")
credit.Parent = topbar
credit.Size = UDim2.new(1, -12, 1, 0)
credit.Position = UDim2.new(0, 0, 0, 0)
credit.BackgroundTransparency = 1

credit.Text = "som😭💔"
credit.Font = Enum.Font.GothamMedium
credit.TextSize = 10
credit.TextXAlignment = Enum.TextXAlignment.Right

credit.TextColor3 = Color3.fromRGB(100, 30, 30)
credit.TextTransparency = 0.2

----------------------------------------------------
-- INPUT STYLE
----------------------------------------------------
local function styleInput(box)
	box.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	box.TextColor3 = Color3.fromRGB(255,255,255)
	box.BorderSizePixel = 0

	box.Font = Enum.Font.Gotham
	box.TextSize = 14

	local corner = Instance.new("UICorner", box)
	corner.CornerRadius = UDim.new(0, 8)

	local stroke = Instance.new("UIStroke", box)
	stroke.Thickness = 1
	stroke.Color = Color3.fromRGB(120, 40, 40)
	stroke.Transparency = 0.35

	local pad = Instance.new("UIPadding", box)
	pad.PaddingLeft = UDim.new(0, 6)
end

----------------------------------------------------
-- INPUTS
----------------------------------------------------
local wsBox = Instance.new("TextBox")
wsBox.Parent = main
wsBox.Size = UDim2.new(0.35, 0, 0, 28)
wsBox.Position = UDim2.new(0.1, 0, 0.5, 0)
wsBox.Text = "16"
styleInput(wsBox)

local jpBox = Instance.new("TextBox")
jpBox.Parent = main
jpBox.Size = UDim2.new(0.35, 0, 0, 28)
jpBox.Position = UDim2.new(0.55, 0, 0.5, 0)
jpBox.Text = "50"
styleInput(jpBox)

wsBox.FocusLost:Connect(function()
	local v = tonumber(wsBox.Text)
	if v then wsValue = v end
end)

jpBox.FocusLost:Connect(function()
	local v = tonumber(jpBox.Text)
	if v then jpValue = v end
end)

----------------------------------------------------
-- BUTTON SYSTEM
----------------------------------------------------
local function makeToggleButton(text, pos)
	local holder = Instance.new("Frame")
	holder.Parent = gui
	holder.Size = UDim2.new(0, 120, 0, 42)
	holder.Position = pos
	holder.BackgroundTransparency = 1

	local btn = Instance.new("TextButton")
	btn.Parent = holder
	btn.Size = UDim2.new(1, -8, 1, -8)
	btn.Position = UDim2.new(0, 4, 0, 4)
	btn.Text = text
	btn.BackgroundColor3 = Color3.fromRGB(25,25,25)
	btn.TextColor3 = Color3.fromRGB(255,255,255)

	btn.Font = Enum.Font.GothamMedium
	btn.TextSize = 13

	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)

	makeDraggable(holder)

	return btn
end

----------------------------------------------------
-- HUD POSITION
----------------------------------------------------
local guiButton = makeToggleButton("GUI: ON", UDim2.new(0.5, -190, 1, -110))
local wsButton  = makeToggleButton("WS: OFF", UDim2.new(0.5, -60, 1, -110))
local jpButton  = makeToggleButton("JP: OFF", UDim2.new(0.5, 70, 1, -110))

----------------------------------------------------
-- STABLE TOGGLE (FIXED SHADOW RESTORE)
----------------------------------------------------
local busy = false

local function toggleMain()
	if busy then return end
	busy = true

	local opening = not main.Visible

	if opening then
		main.Visible = true
		shadow.Visible = true

		shadow.Position = main.Position
		shadow.Size = main.Size
		shadow.BackgroundTransparency = 1

		main.Size = UDim2.new(0, 0, 0, 0)
		main.BackgroundTransparency = 1

		TweenService:Create(main, TweenInfo.new(0.25), {
			Size = UDim2.new(0, 280, 0, 140),
			BackgroundTransparency = 0.25
		}):Play()

		TweenService:Create(shadow, TweenInfo.new(0.25), {
			BackgroundTransparency = 0.65
		}):Play()
	else
		local t1 = TweenService:Create(main, TweenInfo.new(0.2), {
			Size = UDim2.new(0, 0, 0, 0),
			BackgroundTransparency = 1
		})

		local t2 = TweenService:Create(shadow, TweenInfo.new(0.2), {
			BackgroundTransparency = 1
		})

		t1:Play()
		t2:Play()

		t1.Completed:Wait()

		main.Visible = false
		shadow.Visible = false
	end

	guiButton.Text = opening and "GUI: ON" or "GUI: OFF"

	busy = false
end

----------------------------------------------------
-- BUTTON LOGIC
----------------------------------------------------
wsButton.MouseButton1Click:Connect(function()
	wsEnabled = not wsEnabled
	wsButton.Text = wsEnabled and "WS: ON" or "WS: OFF"
end)

jpButton.MouseButton1Click:Connect(function()
	jpEnabled = not jpEnabled
	jpButton.Text = jpEnabled and "JP: ON" or "JP: OFF"
end)

guiButton.MouseButton1Click:Connect(toggleMain)

----------------------------------------------------
-- MOVEMENT (R6 + R15 FIX)
----------------------------------------------------
local function getHumanoid()
	if not char then return nil end
	return char:FindFirstChildOfClass("Humanoid")
end

local function applyMovement()
	local hum = getHumanoid()
	if not hum then return end

	hum.UseJumpPower = true
	hum.WalkSpeed = wsEnabled and wsValue or defaultSpeed
	hum.JumpPower = jpEnabled and jpValue or defaultJump
end

RunService.RenderStepped:Connect(applyMovement)

----------------------------------------------------
-- RESPAWN FIX
----------------------------------------------------
player.CharacterAdded:Connect(function(c)
	char = c
	task.wait(0.2)

	for i = 1, 3 do
		task.wait(0.1)
		applyMovement()
	end
end)