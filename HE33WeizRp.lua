-- ============================================================
--   LUA_HUB - FULL BUILD
-- ============================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Stats = game:GetService("Stats")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

-- ============================================================
-- AUTOSHOOT ENGINE
-- ============================================================

local prediction = {
    enabled = true,
    multiplier = 1.2,
    velocity = Vector3.new(0, 0, 0),
    lastposition = nil,
    lasttime = tick(),
}

local targetState = {
    character = nil,
    hitpart = "Head",
    immune = false,
    autoshoot = false,
    enabled = true,
    shootAttempts = 1,
}

-- Rage mode
local rage = {
    enabled = false,
    fov = 180,
}

-- Void Spam
local voidSpam = {
    enabled = false,
    delay = 0.1,
}

local modules = {}
pcall(function()
    local m = ReplicatedStorage:FindFirstChild("Modules")
    if m then
        pcall(function() modules.fighter = require(m:FindFirstChild("Fighter")) end)
        pcall(function() modules.utility = require(m:FindFirstChild("Utility")) end)
        pcall(function() modules.enums = require(m:FindFirstChild("Enums")) end)
    end
end)

-- Find remotes properly
local Remotes = {}
local function findRemotes()
    local replication = ReplicatedStorage:FindFirstChild("Remotes")
    if replication then
        local fighter = replication:FindFirstChild("Fighter")
        if fighter then
            Remotes.UseItem = fighter:FindFirstChild("UseItem")
        end
    end
end
findRemotes()

local function getClosestTarget()
    local character = player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return nil end
    local hrp = character.HumanoidRootPart
    local closest, closestDist = nil, math.huge
    
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local dist = (hrp.Position - plr.Character.HumanoidRootPart.Position).Magnitude
            
            -- Rage mode: only target if within FOV
            if rage.enabled then
                local lookVector = hrp.CFrame.LookVector
                local toTarget = (plr.Character.HumanoidRootPart.Position - hrp.Position).Unit
                local angle = math.deg(math.acos(math.clamp(lookVector:Dot(toTarget), -1, 1)))
                if angle > rage.fov then continue end
            end
            
            if dist < closestDist then
                closestDist = dist
                closest = plr
            end
        end
    end
    return closest
end

local function hitpartfromname(character, partname)
    if not character then return nil end
    if partname == "Closest" then
        local myhrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        if not myhrp then return character:FindFirstChild("Head") end
        local closest, dist = nil, math.huge
        for _, part in pairs(character:GetChildren()) do
            if part:IsA("BasePart") then
                local d = (part.Position - myhrp.Position).Magnitude
                if d < dist then dist = d; closest = part end
            end
        end
        return closest or character:FindFirstChild("Head")
    elseif partname == "Random" then
        local parts = {"Head", "HumanoidRootPart", "UpperTorso"}
        return character:FindFirstChild(parts[math.random(#parts)]) or character:FindFirstChild("Head")
    else
        return character:FindFirstChild(partname) or character:FindFirstChild("Head")
    end
end

local function updatevel()
    if not targetState.character or not prediction.enabled then
        prediction.velocity = Vector3.new(0, 0, 0)
        prediction.lastposition = nil
        return
    end
    local root = targetState.character:FindFirstChild("HumanoidRootPart")
    if not root then return end
    local now = tick()
    local dt = now - prediction.lasttime
    if dt > 0 and dt < 0.1 then
        local currentpos = root.Position
        if prediction.lastposition then
            local instantvel = (currentpos - prediction.lastposition) / dt
            prediction.velocity = prediction.velocity:Lerp(instantvel, 0.6)
        end
        prediction.lastposition = currentpos
        prediction.lasttime = now
    end
end

local function predict(targetpart, origin)
    if not prediction.enabled or not targetpart then
        return targetpart and targetpart.Position or Vector3.new()
    end
    local basepos = targetpart.Position
    local distance = (basepos - origin).Magnitude
    local ping = 0
    pcall(function()
        ping = Stats.Network.ServerStatsItem["Data Ping"]:GetValue() / 1000
    end)
    local traveltime = distance / 3000
    local totaltime = (traveltime + ping) * prediction.multiplier
    return basepos + (prediction.velocity * totaltime)
end

local function valid(c)
    return c and c:FindFirstChild("Humanoid") and c:FindFirstChild("HumanoidRootPart")
end

local function autoshoot()
    if not targetState.enabled or not targetState.character or not targetState.autoshoot then return end
    if targetState.immune then return end

    local lf = modules.fighter and modules.fighter.LocalFighter
    if not lf or not lf.EquippedItem then return end

    local targetChar = targetState.character
    if not valid(targetChar) then return end

    local hitPart = hitpartfromname(targetChar, targetState.hitpart)
    if not hitPart then return end

    local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    local shootPos = root and root.Position or Vector3.new()
    local targetPos = predict(hitPart, shootPos)

    if not modules.utility or not modules.enums then return end

    local data = {
        [1] = {
            [1] = modules.utility:EncodeCFrame(CFrame.new(shootPos, targetPos)),
            [2] = modules.utility:EncodeCFrame(CFrame.new(shootPos, targetPos)),
            [3] = hitPart,
            [4] = modules.utility:EncodeCFrame(CFrame.new(0.43, 0.25, 0.42)),
        },
    }

    local equipped = lf.EquippedItem
    if equipped and equipped:Get("ObjectID") and Remotes.UseItem then
        local attempts = math.clamp(math.floor(tonumber(targetState.shootAttempts) or 1), 1, 3)
        for _ = 1, attempts do
            pcall(function()
                Remotes.UseItem:FireServer(
                    equipped:Get("ObjectID"),
                    modules.enums:ToEnum("StartShooting"),
                    data,
                    nil
                )
            end)
        end
    end
end

-- Void Spam function
local function doVoidSpam()
    if not voidSpam.enabled then return end
    pcall(function()
        local void = ReplicatedStorage:FindFirstChild("VoidEvent")
        if void then void:FireServer() end
    end)
    pcall(function()
        local ability = ReplicatedStorage.Remotes and ReplicatedStorage.Remotes:FindFirstChild("Ability")
        if ability then ability:FireServer("Void") end
    end)
end

-- Heartbeat: update target + run autoshoot
RunService.Heartbeat:Connect(function()
    local t = getClosestTarget()
    if not t or not t.Character then
        targetState.character = nil
        return
    end
    targetState.character = t.Character
    if targetState.autoshoot then
        updatevel()
        autoshoot()
    end
    if voidSpam.enabled then
        doVoidSpam()
    end
end)

-- ============================================================
-- GUI
-- ============================================================

local function loadMainScript()
    local repo = "https://raw.githubusercontent.com/mstudio45/LinoriaLib/main/"
    
    local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
    local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
    local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()
    
    local Options = Library.Options
    local Toggles = Library.Toggles
    
    Library.ShowToggleFrameInKeybinds = true
    Library.ShowCustomCursor = true
    Library.NotifySide = "Left"
    
    local Window = Library:CreateWindow({
        Title = "LUA_HUB",
        Center = true,
        AutoShow = true,
        Resizable = true,
        ShowCustomCursor = true,
        UnlockMouseWhileOpen = true,
        NotifySide = "Left",
        TabPadding = 8,
        MenuFadeTime = 0.2
    })
    
    local Tabs = {
        Main = Window:AddTab("Main"),
        Visual = Window:AddTab("Visual"),
        Misc = Window:AddTab("Misc"),
        ["UI Settings"] = Window:AddTab("UI Settings"),
    }
    
    -- ===== COMBAT TAB =====
    local CombatGroup = Tabs.Main:AddLeftGroupbox("Combat")

    CombatGroup:AddToggle("AutoShoot", {
        Text = "Auto Shoot",
        Default = false,
        Tooltip = "Auto shoots nearest target",
        Callback = function(value)
            targetState.autoshoot = value
        end
    })

    CombatGroup:AddToggle("AntiImmunity", {
        Text = "Anti Immunity",
        Default = false,
        Tooltip = "Detect and skip immune targets",
        Callback = function(value)
            targetState.immune = not value
        end
    })

    CombatGroup:AddDropdown("HitPart", {
        Text = "Hit Part",
        Default = "Head",
        Values = {"Head", "HumanoidRootPart", "UpperTorso", "Closest", "Random"},
        Callback = function(value)
            targetState.hitpart = value
        end
    })

    CombatGroup:AddSlider("ShootAttempts", {
        Text = "Shoot Attempts",
        Default = 1,
        Min = 1,
        Max = 3,
        Rounding = 0,
        Callback = function(value)
            targetState.shootAttempts = value
        end
    })

    CombatGroup:AddSlider("PredictionMultiplier", {
        Text = "Prediction Multiplier",
        Default = 1.2,
        Min = 0.1,
        Max = 3,
        Rounding = 1,
        Callback = function(value)
            prediction.multiplier = value
        end
    })

    CombatGroup:AddToggle("Prediction", {
        Text = "Velocity Prediction",
        Default = true,
        Callback = function(value)
            prediction.enabled = value
        end
    })

    -- ===== RAGE =====
    local RageGroup = Tabs.Main:AddRightGroupbox("Rage")

    RageGroup:AddToggle("Rage", {
        Text = "Rage Mode",
        Default = false,
        Tooltip = "Only targets within FOV cone",
        Callback = function(value)
            rage.enabled = value
        end
    })

    RageGroup:AddSlider("RageFOV", {
        Text = "Rage FOV",
        Default = 180,
        Min = 10,
        Max = 360,
        Unit = "°",
        Rounding = 0,
        Callback = function(value)
            rage.fov = value
        end
    })

    RageGroup:AddKeyPicker("RageKeybind", {
        Text = "Rage Toggle Key",
        Default = "Q",
        NoUI = false,
        Callback = function(value)
            UserInputService.InputBegan:Connect(function(input, gP)
                if gP then return end
                if input.KeyCode == Enum.KeyCode[value] then
                    rage.enabled = not rage.enabled
                    Toggles.Rage:SetValue(rage.enabled)
                end
            end)
        end
    })

    -- ===== VOID SPAM =====
    local MiscGroup = Tabs.Misc:AddLeftGroupbox("Abilities")

    MiscGroup:AddToggle("VoidSpam", {
        Text = "Void Spam",
        Default = false,
        Tooltip = "Spams void ability",
        Callback = function(value)
            voidSpam.enabled = value
        end
    })

    MiscGroup:AddSlider("VoidDelay", {
        Text = "Void Spam Delay",
        Default = 0.1,
        Min = 0.01,
        Max = 1,
        Suffix = "s",
        Rounding = 2,
        Callback = function(value)
            voidSpam.delay = value
        end
    })

    MiscGroup:AddKeyPicker("VoidKeybind", {
        Text = "Void Spam Toggle Key",
        Default = "V",
        NoUI = false,
        Callback = function(value)
            UserInputService.InputBegan:Connect(function(input, gP)
                if gP then return end
                if input.KeyCode == Enum.KeyCode[value] then
                    voidSpam.enabled = not voidSpam.enabled
                    Toggles.VoidSpam:SetValue(voidSpam.enabled)
                end
            end)
        end
    })

    -- ===== VISUAL TAB (FIXED - no broken color picker) =====
    local VisualGroup = Tabs.Visual:AddLeftGroupbox("Visuals")
    
    VisualGroup:AddToggle("ESP", {
        Text = "ESP",
        Default = false,
        Tooltip = "See players through walls"
    })
    
    VisualGroup:AddToggle("Chams", {
        Text = "Chams",
        Default = false,
        Tooltip = "Colored player models"
    })
    
    VisualGroup:AddToggle("Tracers", {
        Text = "Tracers",
        Default = false,
        Tooltip = "Lines to players"
    })
    
    VisualGroup:AddDivider()
    VisualGroup:AddLabel("ESP Color:")
    
    local colorOptions = {
        {Color3.fromRGB(255, 0, 0), "Red"},
        {Color3.fromRGB(0, 255, 0), "Green"},
        {Color3.fromRGB(0, 0, 255), "Blue"},
        {Color3.fromRGB(255, 255, 0), "Yellow"},
        {Color3.fromRGB(255, 0, 255), "Purple"},
        {Color3.fromRGB(0, 255, 255), "Cyan"},
        {Color3.fromRGB(255, 255, 255), "White"},
    }
    
    local colorNames = {}
    for _, v in ipairs(colorOptions) do table.insert(colorNames, v[2]) end
    
    VisualGroup:AddDropdown("ESPColor", {
        Text = "Color",
        Default = "Red",
        Values = colorNames,
    })

    VisualGroup:AddDivider()
    VisualGroup:AddLabel("Weapon Glow:")
    
    VisualGroup:AddToggle("WeaponGlow", {
        Text = "Enable Glow",
        Default = false,
    })
    
    VisualGroup:AddDropdown("GlowColor", {
        Text = "Glow Color",
        Default = "Red",
        Values = colorNames,
    })

    -- ===== UI SETTINGS =====
    local MenuGroup = Tabs["UI Settings"]:AddLeftGroupbox("Menu")
    
    MenuGroup:AddToggle("KeybindMenuOpen", {
        Default = Library.KeybindFrame.Visible,
        Text = "Open Keybind Menu",
        Callback = function(value) Library.KeybindFrame.Visible = value end
    })
    
    MenuGroup:AddToggle("ShowCustomCursor", {
        Text = "Custom Cursor",
        Default = true,
        Callback = function(Value) Library.ShowCustomCursor = Value end
    })
    
    MenuGroup:AddDivider()
    MenuGroup:AddLabel("Menu bind"):AddKeyPicker("MenuKeybind", {
        Default = "RightShift",
        NoUI = true,
        Text = "Menu keybind"
    })
    
    MenuGroup:AddButton("Unload", function()
        Library:Unload()
    end)
    
    Library.ToggleKeybind = Options.MenuKeybind
    
    Library:SetWatermarkVisibility(true)
    
    local FrameTimer = tick()
    local FrameCounter = 0
    local FPS = 60
    local GetPing = (function() return math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()) end)
    local CanDoPing = pcall(function() return GetPing() end)
    
    local WatermarkConnection = game:GetService("RunService").RenderStepped:Connect(function()
        FrameCounter = FrameCounter + 1
        if (tick() - FrameTimer) >= 1 then
            FPS = FrameCounter
            FrameTimer = tick()
            FrameCounter = 0
        end
        if CanDoPing then
            Library:SetWatermark(("LUA_HUB | %d fps | %d ms"):format(math.floor(FPS), GetPing()))
        else
            Library:SetWatermark(("LUA_HUB | %d fps"):format(math.floor(FPS)))
        end
    end)
    
    Library:OnUnload(function()
        WatermarkConnection:Disconnect()
        targetState.autoshoot = false
        voidSpam.enabled = false
        print("LUA_HUB Unloaded!")
        Library.Unloaded = true
    end)
    
    ThemeManager:SetLibrary(Library)
    SaveManager:SetLibrary(Library)
    SaveManager:IgnoreThemeSettings()
    SaveManager:SetIgnoreIndexes({ "MenuKeybind" })
    ThemeManager:SetFolder("LuaHub")
    SaveManager:SetFolder("LuaHub/specific-game")
    SaveManager:SetSubFolder("specific-place")
    SaveManager:BuildConfigSection(Tabs["UI Settings"])
    ThemeManager:ApplyToTab(Tabs["UI Settings"])
    SaveManager:LoadAutoloadConfig()
    
    print("LUA_HUB Loaded successfully!")
end

loadMainScript()