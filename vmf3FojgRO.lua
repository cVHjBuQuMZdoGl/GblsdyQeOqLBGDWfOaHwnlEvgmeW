-- Showtime Coins Display
-- Place this script in a GUI element or run it in a LocalScript

local player = game.Players.LocalPlayer
local currencyName = "Showtime Coins"

-- Create the main GUI container
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ShowtimeCoinsGUI"
screenGui.Parent = player.PlayerGui

-- Create the frame for the currency display
local currencyFrame = Instance.new("Frame")
currencyFrame.Name = "CurrencyFrame"
currencyFrame.Size = UDim2.new(0, 200, 0, 50)
currencyFrame.Position = UDim2.new(1, -210, 0, 10) -- Top right corner
currencyFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
currencyFrame.BackgroundTransparency = 0.2
currencyFrame.BorderSizePixel = 0
currencyFrame.Parent = screenGui

-- Add corner rounding (optional, but looks nicer)
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = currencyFrame

-- Create the icon (optional - you can replace with your own image)
local icon = Instance.new("ImageLabel")
icon.Name = "CurrencyIcon"
icon.Size = UDim2.new(0, 40, 0, 40)
icon.Position = UDim2.new(0, 5, 0, 5)
icon.BackgroundTransparency = 1
icon.Image = "rbxassetid://123456789" -- Replace with your coin icon ID
icon.Parent = currencyFrame

-- Create the text label for the currency amount
local currencyText = Instance.new("TextLabel")
currencyText.Name = "CurrencyText"
currencyText.Size = UDim2.new(1, -50, 1, 0)
currencyText.Position = UDim2.new(0, 50, 0, 0)
currencyText.BackgroundTransparency = 1
currencyText.Text = "0"
currencyText.TextColor3 = Color3.fromRGB(255, 215, 0) -- Gold color
currencyText.TextSize = 24
currencyText.TextXAlignment = Enum.TextXAlignment.Right
currencyText.TextYAlignment = Enum.TextYAlignment.Center
currencyText.Font = Enum.Font.GothamBold
currencyText.Parent = currencyFrame

-- Create the currency name label
local currencyNameLabel = Instance.new("TextLabel")
currencyNameLabel.Name = "CurrencyName"
currencyNameLabel.Size = UDim2.new(0, 150, 0, 20)
currencyNameLabel.Position = UDim2.new(1, -155, 0, 5)
currencyNameLabel.BackgroundTransparency = 1
currencyNameLabel.Text = currencyName
currencyNameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
currencyNameLabel.TextSize = 12
currencyNameLabel.TextXAlignment = Enum.TextXAlignment.Right
currencyNameLabel.TextYAlignment = Enum.TextYAlignment.Top
currencyNameLabel.Font = Enum.Font.Gotham
currencyNameLabel.Parent = currencyFrame

-- Function to update the currency display
local function updateCurrencyDisplay()
    -- Check if player has a leaderstats folder
    local leaderstats = player:FindFirstChild("leaderstats")
    
    if leaderstats then
        -- If you have a "ShowtimeCoins" value in leaderstats
        local currencyValue = leaderstats:FindFirstChild("ShowtimeCoins")
        
        if currencyValue then
            -- Format the number with commas
            local formattedAmount = string.format("%d", currencyValue.Value)
            formattedAmount = reverseString(formattedAmount)
            formattedAmount = string.gsub(formattedAmount, "(%d%d%d)", "%1,")
            formattedAmount = reverseString(formattedAmount)
            formattedAmount = string.gsub(formattedAmount, "^,", "")
            
            currencyText.Text = formattedAmount
        else
            -- Alternative: check for IntValue elsewhere
            local currencyValue = player:FindFirstChild("ShowtimeCoins")
            if currencyValue then
                local formattedAmount = string.format("%d", currencyValue.Value)
                formattedAmount = reverseString(formattedAmount)
                formattedAmount = string.gsub(formattedAmount, "(%d%d%d)", "%1,")
                formattedAmount = reverseString(formattedAmount)
                formattedAmount = string.gsub(formattedAmount, "^,", "")
                
                currencyText.Text = formattedAmount
            else
                currencyText.Text = "0"
            end
        end
    else
        -- If no leaderstats exists, check for a value in the player
        local currencyValue = player:FindFirstChild("ShowtimeCoins")
        if currencyValue then
            local formattedAmount = string.format("%d", currencyValue.Value)
            formattedAmount = reverseString(formattedAmount)
            formattedAmount = string.gsub(formattedAmount, "(%d%d%d)", "%1,")
            formattedAmount = reverseString(formattedAmount)
            formattedAmount = string.gsub(formattedAmount, "^,", "")
            
            currencyText.Text = formattedAmount
        else
            currencyText.Text = "0"
        end
    end
end

-- Helper function to reverse a string (for formatting numbers with commas)
function reverseString(str)
    local reversed = ""
    for i = #str, 1, -1 do
        reversed = reversed .. str:sub(i, i)
    end
    return reversed
end

-- Function to animate the currency gain (optional)
local function animateCurrencyGain(amount)
    local originalColor = currencyText.TextColor3
    currencyText.TextColor3 = Color3.fromRGB(100, 255, 100) -- Flash green
    
    -- Create a temporary popup text for gain
    local gainText = Instance.new("TextLabel")
    gainText.Size = UDim2.new(0, 100, 0, 30)
    gainText.Position = UDim2.new(0.5, -50, 0, -20)
    gainText.BackgroundTransparency = 1
    gainText.Text = "+" .. tostring(amount)
    gainText.TextColor3 = Color3.fromRGB(0, 255, 0)
    gainText.TextSize = 18
    gainText.TextXAlignment = Enum.TextXAlignment.Center
    gainText.Font = Enum.Font.GothamBold
    gainText.Parent = currencyFrame
    
    -- Animate the gain text
    spawn(function()
        for i = 1, 30 do
            gainText.Position = UDim2.new(0.5, -50, 0, -20 - i)
            wait(0.05)
        end
        gainText:Destroy()
    end)
    
    wait(0.2)
    currencyText.TextColor3 = originalColor
end

-- Connect to currency value changes
local function connectToCurrencyValue()
    -- Check for leaderstats
    local leaderstats = player:FindFirstChild("leaderstats")
    local currencyObject = nil
    
    if leaderstats then
        currencyObject = leaderstats:FindFirstChild("ShowtimeCoins")
    end
    
    if not currencyObject then
        currencyObject = player:FindFirstChild("ShowtimeCoins")
    end
    
    if currencyObject then
        -- Store the previous value for animation
        local lastValue = currencyObject.Value
        
        currencyObject.Changed:Connect(function(newValue)
            updateCurrencyDisplay()
            
            -- Optional: animate when currency increases
            if newValue > lastValue then
                animateCurrencyGain(newValue - lastValue)
            end
            
            lastValue = newValue
        end)
    end
end

-- Initial update
updateCurrencyDisplay()
connectToCurrencyValue()

-- Also check for leaderstats being added later
player.ChildAdded:Connect(function(child)
    if child.Name == "leaderstats" then
        wait(0.5) -- Wait for values to populate
        updateCurrencyDisplay()
        connectToCurrencyValue()
    end
end)

-- Keep checking if the currency value gets added later
local checkInterval = 5
spawn(function()
    while wait(checkInterval) do
        updateCurrencyDisplay()
        connectToCurrencyValue()
    end
end)