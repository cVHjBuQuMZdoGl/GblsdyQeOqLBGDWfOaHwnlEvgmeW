-- ============================================================
--   LUA_HUB - FULL BUILD
--   RAGE: Auto-Shoot + Underground (Non-FFA) / ONTOP (FFA)
-- ============================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local Stats = game:GetService("Stats")
local Workspace = game:GetService("Workspace")
local Debris = game:GetService("Debris")

local player = Players.LocalPlayer
local camera = Workspace.CurrentCamera

-- ============================================================
-- MODULES / REMOTES
-- ============================================================

local modules = {}
pcall(function()
    local m = ReplicatedStorage:FindFirstChild("Modules")
    if m then
        pcall(function() modules.fighter = require(m:FindFirstChild("Fighter")) end)
        pcall(function() modules.utility = require(m:FindFirstChild("Utility")) end)
        pcall(function() modules.enums = require(m:FindFirstChild("Enums")) end)
    end
end)

local Remotes = {}
local function findRemotes()
    local replication = ReplicatedStorage:FindFirstChild("Remotes")
    if replication then
        local fighter = replication:FindFirstChild("Fighter")
        if fighter then
            Remotes.UseItem = fighter:FindFirstChild("UseItem")
        end
        local v = replication:FindFirstChild("VoidEvent")
        if not v then
            v = ReplicatedStorage:FindFirstChild("VoidEvent")
        end
        Remotes.VoidEvent = v
    end
end
findRemotes()

-- ============================================================
-- STATE
-- ============================================================

local state = {
    -- Auto-shoot / combat
    autoshoot = false,
    hitpart = "Head",
    shootAttempts = 1,
    immune = false,
    
    -- Prediction
    prediction = {
        enabled = true,
        multiplier = 1.2,
        velocity = Vector3.new(0,0,0),
        lastpos = nil,
        lasttime = tick(),
    },
    
    -- Rage modes
    rage = {
        enabled = false,
        mode = "Underground",  -- "Underground" or "Ontop"
    },
    
    -- Void
    voidspam = {
        enabled = false,
        delay = 0.1,
    },
    
    -- Target
    target = {
        character = nil,
    },
}

-- ============================================================
-- UTILITY FUNCTIONS
-- ============================================================

local function getClosestTarget()
    local char = player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return nil end
    local hrp = char.HumanoidRootPart
    local closest, closestDist = nil, math.huge
    
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local dist = (hrp.Position - plr.Character.HumanoidRootPart.Position).Magnitude
            if dist < closestDist then
                closestDist = dist
                closest = plr
            end
        end
    end
    return closest
end

local function resolveHitPart(character, partname)
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

local function isValidChar(c)
    return c and c:FindFirstChild("Humanoid") and c:FindFirstChild("HumanoidRootPart")
end

local function getWeapon()
    local vms = workspace:FindFirstChild("ViewModels")
    if not vms then return nil end
    local fp = vms:FindFirstChild("FirstPerson")
    if not fp then return nil end
    for _, child in ipairs(fp:GetChildren()) do
        local parts = {}
        for part in child.Name:gmatch("[^-]+") do
            table.insert(parts, part:match("^%s*(.-)%s*$"))
        end
        if #parts >= 2 then return parts[2] end
    end
    return nil
end

local function isSling(wep)
    if not wep then return false end
    return wep:lower():find("sling") ~= nil
end

-- ============================================================
-- PREDICTION
-- ============================================================

local function updatePrediction()
    if not state.target.character or not state.prediction.enabled then
        state.prediction.velocity = Vector3.new(0,0,0)
        state.prediction.lastpos = nil
        return
    end
    local root = state.target.character:FindFirstChild("HumanoidRootPart")
    if not root then return end
    local now = tick()
    local dt = now - state.prediction.lasttime
    if dt > 0 and dt < 0.1 then
        local cur = root.Position
        if state.prediction.lastpos then
            local vel = (cur - state.prediction.lastpos) / dt
            state.prediction.velocity = state.prediction.velocity:Lerp(vel, 0.6)
        end
        state.prediction.lastpos = cur
        state.prediction.lasttime = now
    end
end

local function predictPos(hitPart, origin)
    if not state.prediction.enabled or not hitPart then
        return hitPart and hitPart.Position or Vector3.new()
    end
    local base = hitPart.Position
    local dist = (base - origin).Magnitude
    local ping = 0
    pcall(function()
        ping = Stats.Network.ServerStatsItem["Data Ping"]:GetValue() / 1000
    end)
    local travel = dist / 3000
    local total = (travel + ping) * state.prediction.multiplier
    return base + (state.prediction.velocity * total)
end

-- ============================================================
-- AUTO-SHOOT (from the first script's engine)
-- ============================================================

local function autoShoot()
    if not state.autoshoot then return end
    if not state.target.character or not isValidChar(state.target.character) then return end
    if state.immune then return end
    
    local lf = modules.fighter and modules.fighter.LocalFighter
    if not lf or not lf.EquippedItem then return end
    
    local hitPart = resolveHitPart(state.target.character, state.hitpart)
    if not hitPart then return end
    
    local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    local shootPos = root and root.Position or Vector3.new()
    local targetPos = predictPos(hitPart, shootPos)
    
    if not modules.utility or not modules.enums then return end
    
    local data = {
        [utf8.char(1)] = {
            [utf8.char(0)] = modules.utility:EncodeCFrame(CFrame.new(shootPos, targetPos)),
            [utf8.char(1)] = modules.utility:EncodeCFrame(CFrame.new(shootPos, targetPos)),
            [utf8.char(2)] = hitPart,
            [utf8.char(3)] = modules.utility:EncodeCFrame(CFrame.new(0.43, 0.25, 0.42)),
        },
    }
    
    local equipped = lf.EquippedItem
    if equipped and equipped:Get("ObjectID") and Remotes.UseItem then
        local attempts = math.clamp(math.floor(tonumber(state.shootAttempts) or 1), 1, 3)
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

-- ============================================================
-- RAGE MODES
-- ============================================================

-- RAGE: UNDERGROUND (Non-FFA)
-- Teleports you under the map in a ragdolled/prone position on your back
local undergroundCFrame = nil  -- cached underground position

local function doRageUnderground()
    if not state.rage.enabled or state.rage.mode ~= "Underground" then return end
    if not state.target.character then return end
    
    local char = player.Character
    if not char then return end
    
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if not hrp or not humanoid then return end
    
    -- Get target position to stay relative to them
    local targetHrp = state.target.character:FindFirstChild("HumanoidRootPart")
    if not targetHrp then return end
    
    -- Position: directly below the target, 50 studs underground
    -- Rotation: on your back (face up, ragdoll position)
    local undergroundPos = targetHrp.Position + Vector3.new(0, -50, 0)
    
    hrp.CFrame = CFrame.new(undergroundPos) * CFrame.Angles(math.rad(90), 0, 0)
    hrp.Velocity = Vector3.new(0, 0, 0)
    hrp.RotVelocity = Vector3.new(0, 0, 0)
    
    -- Force ragdoll state (prone/on back)
    humanoid.PlatformStand = true
    humanoid.AutoRotate = false
    humanoid.Sit = true
    
    -- Lock camera to target
    if camera then
        camera.CFrame = CFrame.new(camera.CFrame.Position, targetHrp.Position)
    end
end

-- RAGE: ONTOP (FFA)
local function doRageOntop()
    if not state.rage.enabled or state.rage.mode ~= "Ontop" then return end
    if not state.target.character then return end
    
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    local targetHrp = state.target.character:FindFirstChild("HumanoidRootPart")
    if hrp and targetHrp then
        hrp.CFrame = CFrame.new(targetHrp.Position + Vector3.new(0, 8, 0))
        hrp.Velocity = Vector3.new(0, 0, 0)
        hrp.RotVelocity = Vector3.new(0, 0, 0)
        
        -- Lock camera to target
        if camera then
            camera.CFrame = CFrame.new(camera.CFrame.Position, targetHrp.Position)
        end
    end
end

-- ============================================================
-- VOID SPAM
-- ============================================================

local function doVoidSpam()
    if not state.voidspam.enabled then return end
    pcall(function()
        if Remotes.VoidEvent then
            Remotes.VoidEvent:FireServer()
        end
    end)
    pcall(function()
        local ability = ReplicatedStorage.Remotes and ReplicatedStorage.Remotes:FindFirstChild("Ability")
        if ability then ability:FireServer("Void") end
    end)
end

-- ============================================================
-- MAIN LOOP (Heartbeat)
-- ============================================================

local voidTimer = 0

RunService.Heartbeat:Connect(function(dt)
    -- Update closest target
    local t = getClosestTarget()
    state.target.character = t and t.Character or nil
    
    if state.target.character then
        -- Update prediction
        updatePrediction()
        
        -- Auto-shoot
        if state.autoshoot then
            autoShoot()
        end
        
        -- Rage mode
        if state.rage.enabled then
            if state.rage.mode == "Underground" then
                doRageUnderground()
            elseif state.rage.mode == "Ontop" then
                doRageOntop()
            end
        end
        
        -- Void spam timer
        voidTimer = voidTimer + dt
        if state.voidspam.enabled and voidTimer >= state.voidspam.delay then
            voidTimer = 0
            doVoidSpam()
        end
    end
end)

-- ============================================================
-- PLAYER REMOVAL CLEANUP
-- ============================================================

Players.PlayerRemoving:Connect(function(plr)
    if state.target.character and state.target.character == plr.Character then
        state.target.character = nil
    end
end)

-- ============================================================
-- LINORIA UI
-- ============================================================

spawn(function()
    local repo = "https://raw.githubusercontent.com/mstudio45/LinoriaLib/main/"
    
    local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
    local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
    local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()
    
    local Options = Library.Options
    local Toggles = Library.Toggles
    
    Library.ShowToggleFrameInKeybinds = true
    Library.ShowCustomCursor = true
    
    local Window = Library:CreateWindow({
        Title = "LUA_HUB",
        Center = true,
        AutoShow = true,
        Resizable = true,
        ShowCustomCursor = true,
    })
    
    local Tabs = {
        Main = Window:AddTab("Main"),
        Rage = Window:AddTab("Rage"),
        Misc = Window:AddTab("Misc"),
        ["UI Settings"] = Window:AddTab("UI Settings"),
    }
    
    -- ============ COMBAT TAB ============
    local CombatGroup = Tabs.Main:AddLeftGroupbox("Combat")
    
    CombatGroup:AddToggle("AutoShoot", {
        Text = "Auto Shoot",
        Default = false,
        Tooltip = "Auto-shoots the closest target",
        Callback = function(v) state.autoshoot = v end
    })
    
    CombatGroup:AddDropdown("HitPart", {
        Text = "Hit Part",
        Default = "Head",
        Values = {"Head", "HumanoidRootPart", "UpperTorso", "Closest", "Random"},
        Callback = function(v) state.hitpart = v end
    })
    
    CombatGroup:AddSlider("ShootAttempts", {
        Text = "Shoot Attempts",
        Default = 1,
        Min = 1,
        Max = 3,
        Rounding = 0,
        Callback = function(v) state.shootAttempts = v end
    })
    
    CombatGroup:AddToggle("AntiImmune", {
        Text = "Anti Immunity",
        Default = false,
        Tooltip = "Skip immune targets",
        Callback = function(v) state.immune = not v end
    })
    
    CombatGroup:AddDivider()
    CombatGroup:AddLabel("Prediction")
    
    CombatGroup:AddToggle("PredictionToggle", {
        Text = "Velocity Prediction",
        Default = true,
        Callback = function(v) state.prediction.enabled = v end
    })
    
    CombatGroup:AddSlider("PredictionMult", {
        Text = "Prediction Multiplier",
        Default = 1.2,
        Min = 0.1,
        Max = 3,
        Rounding = 1,
        Callback = function(v) state.prediction.multiplier = v end
    })
    
    -- ============ RAGE TAB ============
    local RageGroup = Tabs.Rage:AddLeftGroupbox("Rage Configuration")
    
    RageGroup:AddToggle("RageToggle", {
        Text = "Rage Mode",
        Default = false,
        Tooltip = "Enables rage (aimbot + position manipulation)",
        Callback = function(v) state.rage.enabled = v end
    })
    
    RageGroup:AddDropdown("RageMode", {
        Text = "Rage Mode",
        Default = "Underground",
        Values = {"Underground", "Ontop"},
        Tooltip = "Underground: you go under map on your back | Ontop: FFA ontop",
        Callback = function(v) state.rage.mode = v end
    })
    
    RageGroup:AddLabel("")
    RageGroup:AddLabel("Underground (Non-FFA): Puts you below the map on your back")
    RageGroup:AddLabel("Ontop (FFA): Teleports you above the target")
    
    RageGroup:AddDivider()
    
    RageGroup:AddKeyPicker("RageKeybind", {
        Text = "Rage Toggle Key",
        Default = "Q",
        NoUI = false,
        Callback = function(key)
            UserInputService.InputBegan:Connect(function(input, gp)
                if gp then return end
                if input.KeyCode == Enum.KeyCode[key] then
                    state.rage.enabled = not state.rage.enabled
                    Toggles.RageToggle:SetValue(state.rage.enabled)
                end
            end)
        end
    })
    
    -- ============ MISC TAB ============
    local MiscGroup = Tabs.Misc:AddLeftGroupbox("Abilities")
    
    MiscGroup:AddToggle("VoidSpam", {
        Text = "Void Spam",
        Default = false,
        Tooltip = "Spams void ability",
        Callback = function(v) state.voidspam.enabled = v end
    })
    
    MiscGroup:AddSlider("VoidDelay", {
        Text = "Void Spam Delay",
        Default = 0.1,
        Min = 0.01,
        Max = 1,
        Suffix = "s",
        Rounding = 2,
        Callback = function(v) state.voidspam.delay = v end
    })
    
    MiscGroup:AddKeyPicker("VoidKeybind", {
        Text = "Void Spam Toggle Key",
        Default = "V",
        NoUI = false,
        Callback = function(key)
            UserInputService.InputBegan:Connect(function(input, gp)
                if gp then return end
                if input.KeyCode == Enum.KeyCode[key] then
                    state.voidspam.enabled = not state.voidspam.enabled
                    Toggles.VoidSpam:SetValue(state.voidspam.enabled)
                end
            end)
        end
    })
    
    -- ============ UI SETTINGS ============
    local MenuGroup = Tabs["UI Settings"]:AddLeftGroupbox("Menu")
    
    MenuGroup:AddToggle("KeybindMenuOpen", {
        Default = Library.KeybindFrame.Visible,
        Text = "Open Keybind Menu",
        Callback = function(v) Library.KeybindFrame.Visible = v end
    })
    
    MenuGroup:AddToggle("ShowCustomCursor", {
        Text = "Custom Cursor",
        Default = true,
        Callback = function(v) Library.ShowCustomCursor = v end
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
    
    -- Watermark
    Library:SetWatermarkVisibility(true)
    
    local frameTimer = tick()
    local frameCount = 0
    local FPS = 60
    local pingFunc = function()
        return math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
    end
    local pingOk = pcall(function() return pingFunc() end)
    
    RunService.RenderStepped:Connect(function()
        frameCount = frameCount + 1
        if tick() - frameTimer >= 1 then
            FPS = frameCount
            frameTimer = tick()
            frameCount = 0
        end
        if pingOk then
            Library:SetWatermark(("LUA_HUB | %d fps | %d ms"):format(FPS, pingFunc()))
        else
            Library:SetWatermark(("LUA_HUB | %d fps"):format(FPS))
        end
    end)
    
    Library:OnUnload(function()
        state.autoshoot = false
        state.rage.enabled = false
        state.voidspam.enabled = false
        
        -- Reset character physics
        local char = player.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then
                hum.PlatformStand = false
                hum.AutoRotate = true
                hum.Sit = false
            end
        end
        print("LUA_HUB Unloaded!")
    end)
    
    ThemeManager:SetLibrary(Library)
    SaveManager:SetLibrary(Library)
    SaveManager:IgnoreThemeSettings()
    SaveManager:SetIgnoreIndexes({"MenuKeybind"})
    ThemeManager:SetFolder("LuaHub")
    SaveManager:SetFolder("LuaHub/specific-game")
    SaveManager:SetSubFolder("specific-place")
    SaveManager:BuildConfigSection(Tabs["UI Settings"])
    ThemeManager:ApplyToTab(Tabs["UI Settings"])
    SaveManager:LoadAutoloadConfig()
    
    print("LUA_HUB Loaded! Rage Underground/Ontop ready.")
end)