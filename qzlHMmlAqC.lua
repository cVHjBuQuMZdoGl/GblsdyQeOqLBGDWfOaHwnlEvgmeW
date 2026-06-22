local Players = game:GetService("Players")

local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "UEBanner"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Parent = gui
frame.Size = UDim2.new(0, 380, 0, 38)
frame.Position = UDim2.new(0.5, -190, 0, 12)
frame.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
frame.BorderSizePixel = 0

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = frame

local stroke = Instance.new("UIStroke")
stroke.Parent = frame
stroke.Color = Color3.fromRGB(255, 0, 0)
stroke.Thickness = 2

local label = Instance.new("TextLabel")
label.Parent = frame
label.Size = UDim2.new(1, -10, 1, 0)
label.Position = UDim2.new(0, 5, 0, 0)
label.BackgroundTransparency = 1
label.Font = Enum.Font.GothamBold
label.TextSize = 14
label.TextColor3 = Color3.fromRGB(0, 0, 0)
label.TextStrokeTransparency = 0.5
label.Text = "https://discord.gg/meowwc has the best configs and lua🤓☝️"

task.spawn(function()
	local glow = 0
	while true do
		glow += 0.05
		stroke.Transparency = 0.25 + math.abs(math.sin(glow)) * 0.5
		task.wait()
	end
end)