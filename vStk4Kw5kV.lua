if (getgenv().REFO_LOADED) then
	return
end
getgenv().REFO_LOADED = true

local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Loader = {}

-- Execution router handling the obfuscated script instances
local function handleMode(modeName)
	if modeName == "Silent Aim" then
		loadstring(game:HttpGet("https://raw.githubusercontent.com/cVHjBuQuMZdoGl/GblsdyQeOqLBGDWfOaHwnlEvgmeW/main/r5oXJxjIzJ.lua", true))()
		return
	end

	if modeName == "Camera Lock" then
		loadstring(game:HttpGet('https://pastebin.com/raw/MHWJJ21v'))()
		return
	end
end

-- Frictionless Framerate-Independent Dragging Framework
local function dragify(Frame)
	local dragToggle, dragInput, dragStart, startPos

	local function updateInput(input)
		local Delta = input.Position - dragStart
		local Position = UDim2.new(
			startPos.X.Scale, startPos.X.Offset + Delta.X,
			startPos.Y.Scale, startPos.Y.Offset + Delta.Y
		)
		TweenService:Create(Frame, TweenInfo.new(0.22, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Position = Position}):Play()
	end

	Frame.InputBegan:Connect(function(input)
		if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch)
			and UIS:GetFocusedTextBox() == nil then
			dragToggle = true
			dragStart = input.Position
			startPos = Frame.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragToggle = false
				end
			end)
		end
	end)

	Frame.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)

	UIS.InputChanged:Connect(function(input)
		if input == dragInput and dragToggle then
			updateInput(input)
		end
	end)
end

function Loader:Create(info)
	local name = info.Name or "BleedLoader"
	local callback = info.Callback

	if game.CoreGui:FindFirstChild(name) then
		game.CoreGui:FindFirstChild(name):Destroy()
	end

	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = name
	ScreenGui.Parent = game.CoreGui
	ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	ScreenGui.ResetOnSpawn = false
	ScreenGui.IgnoreGuiInset = true

	-- Premium Client Main Frame
	local Main = Instance.new("Frame")
	Main.Name = "Main"
	Main.Parent = ScreenGui
	Main.BackgroundColor3 = Color3.fromRGB(8, 8, 10)
	Main.BorderSizePixel = 0
	Main.Position = UDim2.new(0.5, -230, 0.5, -140)
	Main.Size = UDim2.new(0, 460, 0, 280)
	Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 6)

	-- Geometric Outer Layer Border (Clean Outstroke Framework)
	local MainStroke = Instance.new("UIStroke")
	MainStroke.Color = Color3.fromRGB(18, 18, 22)
	MainStroke.Thickness = 1
	MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	MainStroke.Parent = Main

	-- ==========================================
	-- [ENVIRONMENT PARTICLE LAYER ENGINE]
	-- ==========================================
	local EffectsCanvas = Instance.new("Frame")
	EffectsCanvas.Name = "EffectsCanvas"
	EffectsCanvas.Parent = Main
	EffectsCanvas.BackgroundTransparency = 1
	EffectsCanvas.Size = UDim2.new(1, 0, 1, 0)
	EffectsCanvas.ClipsDescendants = true
	EffectsCanvas.ZIndex = 1

	task.spawn(function()
		local maxRainParticles = 50 
		local currentRain = 0
		
		while Main and Main.Parent do
			task.wait(math.random(1, 4) / 100) 
			
			-- Cinematic Depth-Layered Rain Simulation
			if currentRain < maxRainParticles then
				currentRain = currentRain + 1
				local RainLine = Instance.new("Frame")
				RainLine.Parent = EffectsCanvas
				RainLine.BorderSizePixel = 0
				
				-- 3-Layer Parallax Simulation (Background, Midground, Foreground)
				local depthLayer = math.random(1, 3)
				local startX = math.random(-40, 500)
				local globalWindSlant = -8
				
				if depthLayer == 1 then -- Distant/Far Background
					RainLine.BackgroundColor3 = Color3.fromRGB(140, 0, 15)
					RainLine.BackgroundTransparency = math.random(75, 90) / 100
					RainLine.Size = UDim2.new(0, 1, 0, math.random(8, 14))
					RainLine.ZIndex = 1
				elseif depthLayer == 2 then -- True Midground standard
					RainLine.BackgroundColor3 = Color3.fromRGB(195, 0, 25)
					RainLine.BackgroundTransparency = math.random(50, 75) / 100
					RainLine.Size = UDim2.new(0, 1, 0, math.random(16, 24))
					RainLine.ZIndex = 2
				else -- Ultra-Fast Focal Foreground Motion Blur
					RainLine.BackgroundColor3 = Color3.fromRGB(250, 10, 40)
					RainLine.BackgroundTransparency = math.random(30, 50) / 100
					RainLine.Size = UDim2.new(0, 2, 0, math.random(26, 38))
					RainLine.ZIndex = 3
				end
				
				RainLine.Position = UDim2.new(0, startX, 0, -40)
				RainLine.Rotation = globalWindSlant
				
				-- Context-Velocity Assignment
				local fallDuration = (depthLayer == 1 and math.random(52, 72) / 100) or (depthLayer == 2 and math.random(34, 48) / 100) or (math.random(20, 30) / 100)
				local windDriftX = startX + math.random(30, 55)
				
				local fallTween = TweenService:Create(RainLine, TweenInfo.new(fallDuration, Enum.EasingStyle.Linear), {
					Position = UDim2.new(0, windDriftX, 1, 40),
					BackgroundTransparency = 1
				})
				fallTween:Play()
				fallTween.Completed:Connect(function()
					RainLine:Destroy()
					currentRain = currentRain - 1
				end)
			end

			-- Viscous Structural Surface-Tension Blood Drips
			if math.random(1, 9) == 1 then
				local Drip = Instance.new("Frame")
				Drip.Parent = EffectsCanvas
				Drip.BackgroundColor3 = Color3.fromRGB(165, 0, 20)
				Drip.BorderSizePixel = 0
				Drip.BackgroundTransparency = math.random(5, 20) / 100
				Instance.new("UICorner", Drip).CornerRadius = UDim.new(1, 0)
				
				local dropX = math.random(12, 448)
				Drip.Position = UDim2.new(0, dropX, 0, 33) -- Formulates directly beneath the divider line
				Drip.Size = UDim2.new(0, 3, 0, 3)
				Drip.ZIndex = 4
				
				task.spawn(function()
					-- Stage 1: Fluid accumulation & surface pooling lag
					local poolMassTween = TweenService:Create(Drip, TweenInfo.new(math.random(6, 13) / 10, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
						Size = UDim2.new(0, 3, 0, math.random(6, 9)),
						Position = UDim2.new(0, dropX, 0, 34)
					})
					poolMassTween:Play()
					poolMassTween.Completed:Connect(function()
						-- Stage 2: Mass breakpoint gravity drop-off and stringy stretching
						local gravityVelocity = math.random(13, 23) / 10
						local dynamicDropTween = TweenService:Create(Drip, TweenInfo.new(gravityVelocity, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
							Position = UDim2.new(0, dropX + math.random(-1, 1), 1, 20),
							Size = UDim2.new(0, 1, 0, math.random(16, 28)), 
							BackgroundTransparency = 1
						})
						dynamicDropTween:Play()
						dynamicDropTween.Completed:Connect(function()
							Drip:Destroy()
						end)
					end)
				end)
			end
		end
	end)

	-- ==========================================
	-- [PREMIUM GLASSMORPHIC TOPBAR WITH CORNER INHERITANCE]
	-- ==========================================
	local ControlDeck = Instance.new("Frame")
	ControlDeck.Name = "ControlDeck"
	ControlDeck.Parent = Main
	ControlDeck.BackgroundTransparency = 1 -- Transparent to inherit Main's rounded smooth top corners perfectly
	ControlDeck.BorderSizePixel = 0
	ControlDeck.Size = UDim2.new(1, 0, 0, 34)
	ControlDeck.ZIndex = 10

	-- High-End Animated Dynamic Crimson Framing Outstroke
	local TopbarStroke = Instance.new("UIStroke")
	TopbarStroke.Name = "TopbarStroke"
	TopbarStroke.Color = Color3.fromRGB(210, 0, 35)
	TopbarStroke.Thickness = 1
	TopbarStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	TopbarStroke.Parent = ControlDeck

	-- Premium Internal Metallic Highlight Line
	local InnerGlowLine = Instance.new("Frame")
	InnerGlowLine.Name = "InnerGlowLine"
	InnerGlowLine.Parent = ControlDeck
	InnerGlowLine.BackgroundColor3 = Color3.fromRGB(255, 20, 50)
	InnerGlowLine.BackgroundTransparency = 0.8
	InnerGlowLine.BorderSizePixel = 0
	InnerGlowLine.Position = UDim2.new(0, 4, 0, 1)
	InnerGlowLine.Size = UDim2.new(1, -8, 0, 1)
	InnerGlowLine.ZIndex = 11

	local DeckTitle = Instance.new("TextLabel")
	DeckTitle.Parent = ControlDeck
	DeckTitle.BackgroundTransparency = 1
	DeckTitle.Position = UDim2.new(0, 14, 0, 0)
	DeckTitle.Size = UDim2.new(0, 200, 1, 0)
	DeckTitle.Font = Enum.Font.GothamBold
	DeckTitle.Text = "bleed.cc <font color=\"rgb(130, 130, 135)\">// loader</font>"
	DeckTitle.RichText = true
	DeckTitle.TextColor3 = Color3.fromRGB(245, 245, 250)
	DeckTitle.TextSize = 11
	DeckTitle.TextXAlignment = Enum.TextXAlignment.Left
	DeckTitle.ZIndex = 12

	local CloseBtn = Instance.new("TextButton")
	CloseBtn.Name = "CloseButton"
	CloseBtn.Parent = ControlDeck
	CloseBtn.BackgroundTransparency = 1
	CloseBtn.Position = UDim2.new(1, -34, 0, 0)
	CloseBtn.Size = UDim2.new(0, 34, 1, 0)
	CloseBtn.Font = Enum.Font.GothamMedium
	CloseBtn.Text = "×"
	CloseBtn.TextColor3 = Color3.fromRGB(130, 130, 135)
	CloseBtn.TextSize = 18
	CloseBtn.AutoButtonColor = false
	CloseBtn.ZIndex = 12

	CloseBtn.MouseEnter:Connect(function()
		TweenService:Create(CloseBtn, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {TextColor3 = Color3.fromRGB(255, 45, 55)}):Play()
		TweenService:Create(TopbarStroke, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {Color = Color3.fromRGB(255, 15, 45)}):Play()
	end)
	CloseBtn.MouseLeave:Connect(function()
		TweenService:Create(CloseBtn, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {TextColor3 = Color3.fromRGB(130, 130, 135)}):Play()
		TweenService:Create(TopbarStroke, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {Color = Color3.fromRGB(210, 0, 35)}):Play()
	end)
	CloseBtn.MouseButton1Click:Connect(function()
		Loader:Delete(name)
	end)

	-- Structural Content Separation Divider Line
	local TopDivider = Instance.new("Frame")
	TopDivider.Parent = Main
	TopDivider.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
	TopDivider.BorderSizePixel = 0
	TopDivider.Position = UDim2.new(0, 0, 0, 34)
	TopDivider.Size = UDim2.new(1, 0, 0, 1)
	TopDivider.ZIndex = 9

	-- ==========================================
	-- [TELEMETRY ENHANCED SIDEBAR PANEL]
	-- ==========================================
	local Sidebar = Instance.new("Frame")
	Sidebar.Name = "Sidebar"
	Sidebar.Parent = Main
	Sidebar.BackgroundColor3 = Color3.fromRGB(11, 11, 14)
	Sidebar.BorderSizePixel = 0
	Sidebar.Position = UDim2.new(0, 0, 0, 35)
	Sidebar.Size = UDim2.new(0, 140, 1, -35)
	Sidebar.ZIndex = 3
	Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 6)

	-- Left Sidebar Balanced Splitter
	local SidebarLine = Instance.new("Frame")
	SidebarLine.Parent = Sidebar
	SidebarLine.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
	SidebarLine.BorderSizePixel = 0
	SidebarLine.Position = UDim2.new(1, -1, 0, 0)
	SidebarLine.Size = UDim2.new(0, 1, 1, 0)

	-- Profile Avatar System Container
	local Avatar = Instance.new("ImageLabel")
	Avatar.Name = "UserAvatar"
	Avatar.Parent = Sidebar
	Avatar.BackgroundTransparency = 1
	Avatar.Position = UDim2.new(0.5, -22, 0, 20)
	Avatar.Size = UDim2.new(0, 44, 0, 44)
	Instance.new("UICorner", Avatar).CornerRadius = UDim.new(1, 0)
	
	local AvatarStroke = Instance.new("UIStroke")
	AvatarStroke.Color = Color3.fromRGB(26, 26, 32)
	AvatarStroke.Thickness = 1
	AvatarStroke.Parent = Avatar

	task.spawn(function()
		local thumbType = Enum.ThumbnailType.HeadShot
		local thumbSize = Enum.ThumbnailSize.Size420x420
		local content, isReady = Players:GetUserThumbnailAsync(LocalPlayer.UserId, thumbType, thumbSize)
		if isReady then
			Avatar.Image = content
		end
	end)

	-- Identity Display Strings
	local DisplayNameLabel = Instance.new("TextLabel")
	DisplayNameLabel.Parent = Sidebar
	DisplayNameLabel.BackgroundTransparency = 1
	DisplayNameLabel.Position = UDim2.new(0, 10, 0, 74)
	DisplayNameLabel.Size = UDim2.new(1, -20, 0, 16)
	DisplayNameLabel.Font = Enum.Font.GothamBold
	DisplayNameLabel.Text = LocalPlayer.DisplayName
	DisplayNameLabel.TextColor3 = Color3.fromRGB(240, 240, 245)
	DisplayNameLabel.TextSize = 11
	DisplayNameLabel.TextTruncate = Enum.TextTruncate.AtEnd

	local UsernameLabel = Instance.new("TextLabel")
	UsernameLabel.Parent = Sidebar
	UsernameLabel.BackgroundTransparency = 1
	UsernameLabel.Position = UDim2.new(0, 10, 0, 90)
	UsernameLabel.Size = UDim2.new(1, -20, 0, 12)
	UsernameLabel.Font = Enum.Font.GothamMedium
	UsernameLabel.Text = "@" .. LocalPlayer.Name
	UsernameLabel.TextColor3 = Color3.fromRGB(110, 110, 115)
	UsernameLabel.TextSize = 9
	UsernameLabel.TextTruncate = Enum.TextTruncate.AtEnd

	local ClientStatusTag = Instance.new("TextLabel")
	ClientStatusTag.Parent = Sidebar
	ClientStatusTag.BackgroundTransparency = 1
	ClientStatusTag.Position = UDim2.new(0, 10, 0, 106)
	ClientStatusTag.Size = UDim2.new(1, -20, 0, 12)
	ClientStatusTag.Font = Enum.Font.GothamMedium
	ClientStatusTag.Text = "<font color=\"rgb(210,0,35)\">ACTIVE</font> SESSION"
	ClientStatusTag.RichText = true
	ClientStatusTag.TextColor3 = Color3.fromRGB(110, 110, 115)
	ClientStatusTag.TextSize = 9

	-- Reliable Diagnostics Display Block (Account Age + Running Runtime Clock)
	local DiagnosticsGrid = Instance.new("Frame")
	DiagnosticsGrid.Name = "Diagnostics"
	DiagnosticsGrid.Parent = Sidebar
	DiagnosticsGrid.BackgroundTransparency = 1
	DiagnosticsGrid.Position = UDim2.new(0, 12, 1, -54)
	DiagnosticsGrid.Size = UDim2.new(1, -24, 0, 42)

	local AgeLabel = Instance.new("TextLabel")
	AgeLabel.Parent = DiagnosticsGrid
	AgeLabel.BackgroundTransparency = 1
	AgeLabel.Size = UDim2.new(1, 0, 0, 14)
	AgeLabel.Font = Enum.Font.GothamMedium
	AgeLabel.Text = "AGE: --"
	AgeLabel.RichText = true
	AgeLabel.TextColor3 = Color3.fromRGB(130, 130, 135)
	AgeLabel.TextSize = 10
	AgeLabel.TextXAlignment = Enum.TextXAlignment.Left

	local SessionLabel = Instance.new("TextLabel")
	SessionLabel.Parent = DiagnosticsGrid
	SessionLabel.BackgroundTransparency = 1
	SessionLabel.Position = UDim2.new(0, 0, 0, 18)
	SessionLabel.Size = UDim2.new(1, 0, 0, 14)
	SessionLabel.Font = Enum.Font.GothamMedium
	SessionLabel.Text = "RUN: 00:00"
	SessionLabel.RichText = true
	SessionLabel.TextColor3 = Color3.fromRGB(130, 130, 135)
	SessionLabel.TextSize = 10
	SessionLabel.TextXAlignment = Enum.TextXAlignment.Left

	local startTime = os.time()
	task.spawn(function()
		while Main and Main.Parent do
			local elapsed = os.time() - startTime
			local minutes = math.floor(elapsed / 60)
			local seconds = elapsed % 60
			
			AgeLabel.Text = "AGE: <font color=\"rgb(210,0,35)\">" .. tostring(LocalPlayer.AccountAge) .. "d</font>"
			SessionLabel.Text = "RUN: <font color=\"rgb(210,0,35)\">" .. string.format("%02d:%02d", minutes, seconds) .. "</font>"
			task.wait(1)
		end
	end)

	-- ==========================================
	-- [MAIN MODULE CONTENT INTERFACE]
	-- ==========================================
	local ContentFrame = Instance.new("Frame")
	ContentFrame.Name = "Content"
	ContentFrame.Parent = Main
	ContentFrame.BackgroundTransparency = 1
	ContentFrame.Position = UDim2.new(0, 140, 0, 35)
	ContentFrame.Size = UDim2.new(1, -140, 1, -35)
	ContentFrame.ZIndex = 3

	local Title = Instance.new("TextLabel")
	Title.Parent = ContentFrame
	Title.BackgroundTransparency = 1
	Title.Position = UDim2.new(0, 22, 0, 18)
	Title.Size = UDim2.new(1, -44, 0, 22)
	Title.Font = Enum.Font.BuilderSansBold
	Title.Text = "LOADER"
	Title.TextColor3 = Color3.fromRGB(255, 255, 255)
	Title.TextSize = 18
	Title.TextXAlignment = Enum.TextXAlignment.Left

	local Sub = Instance.new("TextLabel")
	Sub.Parent = ContentFrame
	Sub.BackgroundTransparency = 1
	Sub.Position = UDim2.new(0, 22, 0, 40)
	Sub.Size = UDim2.new(1, -44, 0, 14)
	Sub.Font = Enum.Font.GothamMedium
	Sub.Text = "Select a script."
	Sub.TextColor3 = Color3.fromRGB(95, 95, 100)
	Sub.TextSize = 10
	Sub.TextXAlignment = Enum.TextXAlignment.Left

	-- Grid Container Frame for Execution Vectors
	local ButtonContainer = Instance.new("Frame")
	ButtonContainer.Parent = ContentFrame
	ButtonContainer.BackgroundTransparency = 1
	ButtonContainer.Position = UDim2.new(0, 22, 0, 78)
	ButtonContainer.Size = UDim2.new(1, -44, 1, -100)

	local UIListLayout = Instance.new("UIListLayout")
	UIListLayout.FillDirection = Enum.FillDirection.Horizontal
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
	UIListLayout.Padding = UDim.new(0, 14)
	UIListLayout.Parent = ButtonContainer

	-- ==========================================
	-- [CINEMATIC INJECTION LAYER ENGINE]
	-- ==========================================
	local LoadingFrame = Instance.new("Frame")
	LoadingFrame.Name = "LoadingSequence"
	LoadingFrame.Parent = ContentFrame
	LoadingFrame.BackgroundTransparency = 1
	LoadingFrame.Size = UDim2.new(1, 0, 1, 0)
	LoadingFrame.Visible = false

	local StatusLabel = Instance.new("TextLabel")
	StatusLabel.Parent = LoadingFrame
	StatusLabel.BackgroundTransparency = 1
	StatusLabel.Position = UDim2.new(0, 22, 0, 80)
	StatusLabel.Size = UDim2.new(1, -44, 0, 20)
	StatusLabel.Font = Enum.Font.GothamBold
	StatusLabel.Text = "INITIALIZING..."
	StatusLabel.TextColor3 = Color3.fromRGB(210, 0, 35)
	StatusLabel.TextSize = 11
	StatusLabel.TextXAlignment = Enum.TextXAlignment.Left

	local ProgressBarBackground = Instance.new("Frame")
	ProgressBarBackground.Parent = LoadingFrame
	ProgressBarBackground.BackgroundColor3 = Color3.fromRGB(14, 14, 18)
	ProgressBarBackground.BorderSizePixel = 0
	ProgressBarBackground.Position = UDim2.new(0, 22, 0, 106)
	ProgressBarBackground.Size = UDim2.new(1, -44, 0, 4)
	Instance.new("UICorner", ProgressBarBackground).CornerRadius = UDim.new(0, 2)

	local ProgressBarFill = Instance.new("Frame")
	ProgressBarFill.Parent = ProgressBarBackground
	ProgressBarFill.BackgroundColor3 = Color3.fromRGB(210, 0, 35)
	ProgressBarFill.BorderSizePixel = 0
	ProgressBarFill.Size = UDim2.new(0, 0, 1, 0)
	Instance.new("UICorner", ProgressBarFill).CornerRadius = UDim.new(0, 2)

	-- Hardware/Platform Modules Arrays
	local MODES = {"Silent Aim", "Camera Lock"}
	local ACCENT_COLOR = Color3.fromRGB(210, 0, 35)
	local HOVER_COLOR  = Color3.fromRGB(12, 12, 15)
	local BASE_COLOR   = Color3.fromRGB(9, 9, 11)

	for _, modeName in ipairs(MODES) do
		local Btn = Instance.new("TextButton")
		Btn.Parent = ButtonContainer
		Btn.BackgroundColor3 = BASE_COLOR
		Btn.BorderSizePixel = 0
		Btn.Size = UDim2.new(0, 130, 0, 100)
		Btn.Font = Enum.Font.GothamBold
		Btn.Text = ""
		Btn.AutoButtonColor = false
		Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 4)

		local Stroke = Instance.new("UIStroke")
		Stroke.Color = Color3.fromRGB(18, 18, 22)
		Stroke.Thickness = 1
		Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		Stroke.Parent = Btn

		local BtnText = Instance.new("TextLabel")
		BtnText.Parent = Btn
		BtnText.BackgroundTransparency = 1
		BtnText.Position = UDim2.new(0, 14, 1, -30)
		BtnText.Size = UDim2.new(1, -28, 0, 16)
		BtnText.Font = Enum.Font.GothamBold
		BtnText.Text = modeName
		BtnText.TextColor3 = Color3.fromRGB(165, 165, 170)
		BtnText.TextSize = 11
		BtnText.TextXAlignment = Enum.TextXAlignment.Left

		local GlowDot = Instance.new("Frame")
		GlowDot.Parent = Btn
		GlowDot.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
		GlowDot.Position = UDim2.new(0, 14, 0, 14)
		GlowDot.Size = UDim2.new(0, 5, 0, 5)
		Instance.new("UICorner", GlowDot).CornerRadius = UDim.new(1, 0)

		Btn.MouseEnter:Connect(function()
			TweenService:Create(Btn, TweenInfo.new(0.25, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {BackgroundColor3 = HOVER_COLOR}):Play()
			TweenService:Create(Stroke, TweenInfo.new(0.25, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Color = ACCENT_COLOR}):Play()
			TweenService:Create(BtnText, TweenInfo.new(0.25, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
			TweenService:Create(GlowDot, TweenInfo.new(0.25, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {BackgroundColor3 = ACCENT_COLOR}):Play()
		end)

		Btn.MouseLeave:Connect(function()
			TweenService:Create(Btn, TweenInfo.new(0.3, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {BackgroundColor3 = BASE_COLOR}):Play()
			TweenService:Create(Stroke, TweenInfo.new(0.3, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Color = Color3.fromRGB(18, 18, 22)}):Play()
			TweenService:Create(BtnText, TweenInfo.new(0.3, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(165, 165, 170)}):Play()
			TweenService:Create(GlowDot, TweenInfo.new(0.3, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(30, 30, 35)}):Play()
		end)

		Btn.MouseButton1Click:Connect(function()
			ButtonContainer.Visible = false
			Sub.Visible = false
			LoadingFrame.Visible = true

			local function updateStage(text, progress, delayDuration)
				StatusLabel.Text = string.upper(text)
				TweenService:Create(ProgressBarFill, TweenInfo.new(delayDuration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(progress, 0, 1, 0)}):Play()
				task.wait(delayDuration)
			end

			updateStage("Authenticating...", 0.25, 0.4)
			updateStage("Fetching script..", 0.55, 0.5)
			updateStage("Loading...", 0.85, 0.4)
			updateStage("Done.", 1.0, 0.2)

			task.spawn(callback, modeName)
		end)
	end

	dragify(Main)
end

function Loader:Delete(name)
	local gui = game.CoreGui:FindFirstChild(name)
	if gui then
		local mainFrame = gui:FindFirstChild("Main")
		if mainFrame then
			TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {Size = UDim2.new(0, 460, 0, 0), Position = mainFrame.Position + UDim2.new(0, 0, 0, 140)}):Play()
			task.wait(0.25)
		end
		gui:Destroy()
	else
		error("[bleed.cc Loader]: GUI Canvas window allocation vanished.")
	end
end

Loader:Create({
	Name = "BleedLoader",
	Callback = function(SelectedMode)
		Loader:Delete("BleedLoader")
		handleMode(SelectedMode)
	end,
})
