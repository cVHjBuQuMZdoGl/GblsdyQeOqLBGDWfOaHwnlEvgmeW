-- Modern Blue Tech Key System: APEX PREMIUM
-- Protected by 4X OBF

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer

-- Valid Keys Configuration
local validKeys = {
    ["6767"] = true,
    ["Owner"] = true
}

-- Create ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ApexPremiumKeySystem"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = CoreGui -- Places it over standard game UI

-- Main Frame (Modern Dark/Blue Tech Aesthetic)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 400, 0, 250)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -125)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 18, 26)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

-- Modern Rounded Corners
local FrameCorner = Instance.new("UICorner")
FrameCorner.CornerRadius = UDim.new(0, 12)
FrameCorner.Parent = MainFrame

-- Tech Blue Border Effect
local UIStroke = Instance.new("UIStroke")
UIStroke.Thickness = 2
UIStroke.Color = Color3.fromRGB(0, 162, 255)
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke.Parent = MainFrame

-- Title Text
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.Text = "APEX PREMIUM KEY SYSTEM"
Title.TextColor3 = Color3.fromRGB(0, 162, 255)
Title.TextSize = 18
Title.Parent = MainFrame

-- Subtitle / Protection Info
local Subtitle = Instance.new("TextLabel")
Subtitle.Name = "Subtitle"
Subtitle.Size = UDim2.new(1, 0, 0, 20)
Subtitle.Position = UDim2.new(0, 0, 0, 40)
Subtitle.BackgroundTransparency = 1
Subtitle.Font = Enum.Font.GothamSemibold
Subtitle.Text = "PROTECTED BY 4X OBF"
Subtitle.TextColor3 = Color3.fromRGB(100, 110, 130)
Subtitle.TextSize = 11
Subtitle.Parent = MainFrame

-- Key Input Box
local KeyInput = Instance.new("TextBox")
KeyInput.Name = "KeyInput"
KeyInput.Size = UDim2.new(0, 300, 0, 45)
KeyInput.Position = UDim2.new(0.5, -150, 0.45, -22)
KeyInput.BackgroundColor3 = Color3.fromRGB(25, 30, 44)
KeyInput.Font = Enum.Font.Gotham
KeyInput.PlaceholderText = "Enter Premium Key Here..."
KeyInput.PlaceholderColor3 = Color3.fromRGB(80, 90, 110)
KeyInput.Text = ""
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.TextSize = 14
KeyInput.Parent = MainFrame

local InputCorner = Instance.new("UICorner")
InputCorner.CornerRadius = UDim.new(0, 8)
InputCorner.Parent = KeyInput

local InputStroke = Instance.new("UIStroke")
InputStroke.Thickness = 1
InputStroke.Color = Color3.fromRGB(40, 50, 70)
InputStroke.Parent = KeyInput

-- Submit Button
local SubmitBtn = Instance.new("TextButton")
SubmitBtn.Name = "SubmitBtn"
SubmitBtn.Size = UDim2.new(0, 300, 0, 40)
SubmitBtn.Position = UDim2.new(0.5, -150, 0.75, -20)
SubmitBtn.BackgroundColor3 = Color3.fromRGB(0, 110, 255)
SubmitBtn.Font = Enum.Font.GothamBold
SubmitBtn.Text = "SUBMIT"
SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitBtn.TextSize = 14
SubmitBtn.Parent = MainFrame

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 8)
BtnCorner.Parent = SubmitBtn

-- Loading Overlay Components (Hidden Intially)
local LoadingLabel = Instance.new("TextLabel")
LoadingLabel.Size = UDim2.new(1, 0, 0, 30)
LoadingLabel.Position = UDim2.new(0, 0, 0.4, -15)
LoadingLabel.BackgroundTransparency = 1
LoadingLabel.Font = Enum.Font.GothamSemibold
LoadingLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
LoadingLabel.TextSize = 14
LoadingLabel.Visible = false
LoadingLabel.Parent = MainFrame

local ProgressBackground = Instance.new("Frame")
ProgressBackground.Size = UDim2.new(0, 300, 0, 6)
ProgressBackground.Position = UDim2.new(0.5, -150, 0.6, -3)
ProgressBackground.BackgroundColor3 = Color3.fromRGB(25, 30, 44)
ProgressBackground.BorderSizePixel = 0
ProgressBackground.Visible = false
ProgressBackground.Parent = MainFrame

local ProgressBackgroundCorner = Instance.new("UICorner")
ProgressBackgroundCorner.CornerRadius = UDim.new(0, 3)
ProgressBackgroundCorner.Parent = ProgressBackground

local ProgressBar = Instance.new("Frame")
ProgressBar.Size = UDim2.new(0, 0, 1, 0)
ProgressBar.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
ProgressBar.BorderSizePixel = 0
ProgressBar.Parent = ProgressBackground

local ProgressBarCorner = Instance.new("UICorner")
ProgressBarCorner.CornerRadius = UDim.new(0, 3)
ProgressBarCorner.Parent = ProgressBar

-- Button Interaction Animations
SubmitBtn.MouseEnter:Connect(function()
    TweenService:Create(SubmitBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 140, 255)}):Play()
end)

SubmitBtn.MouseLeave:Connect(function()
    TweenService:Create(SubmitBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 110, 255)}):Play()
end)

-- Core Functionality Logic
SubmitBtn.MouseButton1Click:Connect(function()
    local enteredKey = KeyInput.Text
    
    if validKeys[enteredKey] then
        -- Clean up Key inputs UI
        KeyInput.Visible = false
        SubmitBtn.Visible = false
        
        -- Reveal Loading components
        LoadingLabel.Visible = true
        ProgressBackground.Visible = true
        
        -- Phase 1: Loading Resources (0s - 3s)
        LoadingLabel.Text = "Loading Resources..."
        local tween1 = TweenService:Create(ProgressBar, TweenInfo.new(3, Enum.EasingStyle.Linear), {Size = UDim2.new(0.35, 0, 1, 0)})
        tween1:Play()
        tween1.Completed:Wait()
        
        -- Phase 2: Checking UNC (3s - 5.5s)
        LoadingLabel.Text = "Checking UNC..."
        local tween2 = TweenService:Create(ProgressBar, TweenInfo.new(2.5, Enum.EasingStyle.Linear), {Size = UDim2.new(0.70, 0, 1, 0)})
        tween2:Play()
        tween2.Completed:Wait()
        
        -- Phase 3: Executing (5.5s - 8s)
        LoadingLabel.Text = "Executing..."
        local tween3 = TweenService:Create(ProgressBar, TweenInfo.new(2.5, Enum.EasingStyle.Linear), {Size = UDim2.new(1, 0, 1, 0)})
        tween3:Play()
        tween3.Completed:Wait()
        
        -- Destroy UI smoothly and execute script
        TweenService:Create(MainFrame, TweenInfo.new(0.3), {BackgroundTransparency = 1, Size = UDim2.new(0,0,0,0)}):Play()
        task.wait(0.3)
        ScreenGui:Destroy()
        
        -- Safe Execution wrapper
        local success, err = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/CodeE4X-dev/vex.cc/refs/heads/main/Main.lua"))()
        end)
        if not success then
            warn("Execution Error: " .. tostring(err))
        end
        
    else
        -- Wrong Key Action: Instantly kick user with logs warning
        player:Kick("WRONG KEY, IP, DEVICE ID IS LOGGED CONTACT 4X SUPPORT")
    end
end)