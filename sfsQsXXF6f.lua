-- [[ KHIZAR HUB V10.6: PART 1 - UI & DATABASE ]] --

local Configs_HUB = {
  Cor_Hub = Color3.fromRGB(12, 12, 14),
  Cor_Options = Color3.fromRGB(20, 20, 25),
  Cor_Stroke = Color3.fromRGB(255, 0, 100), 
  Cor_Text = Color3.fromRGB(245, 245, 245),
  Cor_DarkText = Color3.fromRGB(130, 130, 130),
  Corner_Radius = UDim.new(0, 8),
  Text_Font = Enum.Font.FredokaOne
}

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

if CoreGui:FindFirstChild("KhizarChestUI") then 
    CoreGui.KhizarChestUI:Destroy() 
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KhizarChestUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 360, 0, 510) 
MainFrame.Position = UDim2.new(0.5, -180, 0.5, -255)
MainFrame.BackgroundColor3 = Configs_HUB.Cor_Hub
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ZIndex = 1

local MCorner = Instance.new("UICorner", MainFrame)
MCorner.CornerRadius = Configs_HUB.Corner_Radius
local MStroke = Instance.new("UIStroke", MainFrame)
MStroke.Color = Configs_HUB.Cor_Stroke
MStroke.Thickness = 1.5

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "KHIZAR HUB V10.6 [SYNTAX STABLE]"
Title.TextColor3 = Color3.fromRGB(245, 245, 245)
Title.TextSize = 13
Title.Font = Enum.Font.GothamBold
Title.BackgroundTransparency = 1
Title.ZIndex = 2

local Line = Instance.new("Frame", MainFrame)
Line.Size = UDim2.new(1, 0, 0, 1)
Line.Position = UDim2.new(0, 0, 0, 40)
Line.BackgroundColor3 = Configs_HUB.Cor_Stroke
Line.BorderSizePixel = 0
Line.ZIndex = 2

local function buildOptionButton(text, index)
    local btn = Instance.new("TextButton", MainFrame)
    btn.Size = UDim2.new(0, 300, 0, 38)
    btn.Position = UDim2.new(0.5, -150, 0, 48 + (index * 44))
    btn.BackgroundColor3 = Configs_HUB.Cor_Options
    btn.Text = text .. " [OFF]"
    btn.TextColor3 = Color3.fromRGB(255, 75, 75)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 11
    btn.ZIndex = 3
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    local stroke = Instance.new("UIStroke", btn)
    stroke.Color = Color3.fromRGB(255, 75, 75)
    stroke.Thickness = 1.2
    return btn, stroke
end

LevelToggleFrame, LevelStroke = buildOptionButton("START AUTO FARM LEVEL", 0)
ToggleFrame, BTNStroke = buildOptionButton("START DIRECT CHEST FARM", 1)
HopToggleFrame, HopBTNStroke = buildOptionButton("AUTO SERVER HOP", 2)
ESPToggleFrame, ESPBTNStroke = buildOptionButton("CHEST ESP NAME", 3)
FruitESPToggle, FruitESPStroke = buildOptionButton("FRUIT ESP NAME", 4)
TeleportFruitToggle, TPFruitStroke = buildOptionButton("TWEEN TO SPAWNED FRUIT", 5)

StatusLabel = Instance.new("TextLabel", MainFrame)
StatusLabel.Size = UDim2.new(1, -20, 0, 22)
StatusLabel.Position = UDim2.new(0, 10, 0, 415)
StatusLabel.Text = "Status: Idle (Waiting for Start)"
StatusLabel.TextColor3 = Configs_HUB.Cor_DarkText
StatusLabel.TextSize = 11
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.BackgroundTransparency = 1
StatusLabel.ZIndex = 2

local CounterLabel = Instance.new("TextLabel", MainFrame)
CounterLabel.Size = UDim2.new(1, -20, 0, 22)
CounterLabel.Position = UDim2.new(0, 10, 0, 440)
CounterLabel.Text = "Chests Looted in Current Cycle: 0/5"
CounterLabel.TextColor3 = Configs_HUB.Cor_Stroke
CounterLabel.TextSize = 12
CounterLabel.Font = Enum.Font.GothamBold
CounterLabel.BackgroundTransparency = 1
CounterLabel.ZIndex = 2

local TotalLabel = Instance.new("TextLabel", MainFrame)
TotalLabel.Size = UDim2.new(1, -20, 0, 22)
TotalLabel.Position = UDim2.new(0, 10, 0, 465)
TotalLabel.Text = "Total Session Chests Looted: 0"
TotalLabel.TextColor3 = Color3.fromRGB(245, 245, 245)
TotalLabel.TextSize = 11
TotalLabel.Font = Enum.Font.Gotham
TotalLabel.BackgroundTransparency = 1
TotalLabel.ZIndex = 2

local ToggleButton = Instance.new("TextButton", ScreenGui)
ToggleButton.Size = UDim2.new(0, 45, 0, 45)
ToggleButton.Position = UDim2.new(0.05, 0, 0.2, 0)
ToggleButton.BackgroundColor3 = Configs_HUB.Cor_Hub
ToggleButton.Text = "K"
ToggleButton.TextColor3 = Configs_HUB.Cor_Stroke
ToggleButton.TextSize = 20
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.Draggable = true
ToggleButton.Active = true
Instance.new("UICorner", ToggleButton).CornerRadius = UDim.new(1, 0)
local TStroke = Instance.new("UIStroke", ToggleButton)
TStroke.Color = Configs_HUB.Cor_Stroke

ToggleButton.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

_G.Level = false
_G.ChestFarmActive = false
_G.AutoServerHop = false 
_G.ChestESPActive = false
_G.FruitESPActive = false
_G.TeleportFruitActive = false
_G.SelectWeapon = "Melee"
_G.BringMobs = true
_G.TweenFruitSpeed = 250

chestCount = 0
totalLooted = 0
ChestCache = {}
BlacklistedModels = {}
PosMon = nil
CurrentFruitPicked = false
FruitTargetCFrame = nil

function getActiveQuestDetails()
    local a = (LocalPlayer:FindFirstChild("Data") and LocalPlayer.Data:FindFirstChild("Level")) and LocalPlayer.Data.Level.Value or 1
    local Mon, Qdata, Qname, NameMon, PosQ, PosM
    
    if a >= 1 and a < 10 then
        Mon="Bandit";Qdata=1;Qname="BanditQuest1";NameMon="Bandit";PosQ=CFrame.new(1060, 16, 1548);PosM=CFrame.new(1060, 16, 1548)
    elseif a >= 10 and a < 15 then
        Mon="Monkey";Qdata=1;Qname="JungleQuest";NameMon="Monkey";PosQ=CFrame.new(-1598, 36, 153);PosM=CFrame.new(-1598, 36, 153)
    elseif a == 2025 or a <= 2049 then 
        Mon="Demonic Soul";Qdata=1;Qname="HauntedQuest2";NameMon="Demonic Soul";PosQ=CFrame.new(-9516.99316,172.017181,6078.46533,0,0,-1,0,1,0,1,0,0);PosM=CFrame.new(-9505.8720703125,172.1048,6194.123)
    elseif a == 2050 or a <= 2074 then 
        Mon="Posessed Mummy";Qdata=2;Qname="HauntedQuest2";NameMon="Posessed Mummy";PosQ=CFrame.new(-9516.99316,172.017181,6078.46533,0,0,-1,0,1,0,1,0,0);PosM=CFrame.new(-9579.321,6.214,6194.541)
    elseif a == 2075 or a <= 2099 then 
        Mon="Peanut Scout";Qdata=1;Qname="NutsQuest";NameMon="Peanut Scout";PosQ=CFrame.new(-2104.312,38.125,-10156.214);PosM=CFrame.new(-1993.421,187.321,-10103.541)
    elseif a == 2100 or a <= 2124 then 
        Mon="Peanut President";Qdata=2;Qname="NutsQuest";NameMon="Peanut President";PosQ=CFrame.new(-2104.312,38.125,-10156.214);PosM=CFrame.new(-2215.114,159.432,-10474.125)
    elseif a == 2125 or a <= 2149 then 
        Mon="Ice Cream Chef";Qdata=1;Qname="IceCreamQuest";NameMon="Ice Cream Chef";PosQ=CFrame.new(-1152.612,14.214,-10824.115);PosM=CFrame.new(-877.312,118.521,-11032.614)
    elseif a == 2150 or a <= 2199 then 
        Mon="Ice Cream Commander";Qdata=2;Qname="IceCreamQuest";NameMon="Ice Cream Commander";PosQ=CFrame.new(-1152.612,14.214,-10824.115);PosM=CFrame.new(-877.514,118.621,-11032.114)
    elseif a == 2200 or a <= 2224 then 
        Mon="Cookie Crafter";Qdata=1;Qname="CakeQuest1";NameMon="Cookie Crafter";PosQ=CFrame.new(-1887.214,38.225,-12154.124);PosM=CFrame.new(-2021.432,38.612,-12028.514)
    elseif a == 2225 or a <= 2249 then 
        Mon="Cake Guard";Qdata=2;Qname="CakeQuest1";NameMon="Cake Guard";PosQ=CFrame.new(-1887.214,38.225,-12154.124);PosM=CFrame.new(-2024.125,38.412,-12026.312)
    elseif a == 2250 or a <= 2299 then 
        Mon="Baking Staff";Qdata=1;Qname="CakeQuest2";NameMon="Baking Staff";PosQ=CFrame.new(-1887.512,38.115,-12154.612);PosM=CFrame.new(-1932.124,38.514,-12848.612)
    elseif a == 2300 or a <= 2324 then 
        Mon="Head Baker";Qdata=2;Qname="CakeQuest2";NameMon="Head Baker";PosQ=CFrame.new(-1887.512,38.115,-12154.612);PosM=CFrame.new(-1932.612,38.125,-12848.114)
    elseif a == 2325 or a <= 2349 then 
        Mon="Cocoa Warrior";Qdata=1;Qname="CocoaQuest";NameMon="Cocoa Warrior";PosQ=CFrame.new(231.114,24.512,-12198.312);PosM=CFrame.new(95.431,73.114,-12309.214)
    elseif a == 2350 or a <= 2399 then 
        Mon="Chocolate Bar Battler";Qdata=2;Qname="CocoaQuest";NameMon="Chocolate Bar Battler";PosQ=CFrame.new(231.114,24.512,-12198.312);PosM=CFrame.new(647.512,42.612,-12401.432)
    elseif a == 2400 or a <= 2424 then 
        Mon="Sweet Thief";Qdata=1;Qname="CandyQuest";NameMon="Sweet Thief";PosQ=CFrame.new(132.612,24.412,-12764.115);PosM=CFrame.new(116.512,36.214,-12478.612)
    elseif a == 2425 or a <= 2449 then 
        Mon="Candy Rebel";Qdata=2;Qname="CandyQuest";NameMon="Candy Rebel";PosQ=CFrame.new(132.612,24.412,-12764.115);PosM=CFrame.new(47.124,61.512,-12889.312)
    elseif a == 2450 or a <= 2499 then 
        Mon="Sunfire Envoy";Qdata=1;Qname="TikiQuest1";NameMon="Sunfire Envoy";PosQ=CFrame.new(-2254.12,45.21,-16421.5);PosM=CFrame.new(-2341.6,52.31,-16214.8)
    elseif a >= 2500 then 
        Mon="Island Outcast";Qdata=2;Qname="TikiQuest1";NameMon="Island Outcast";PosQ=CFrame.new(-2254.12,45.21,-16421.5);PosM=CFrame.new(-2512.4,61.82,-16541.2)
    else
        local targetEnemy = workspace:FindFirstChild("Enemies") and workspace.Enemies:FindFirstChildOfClass("Model")
        if targetEnemy and targetEnemy:FindFirstChild("HumanoidRootPart") then
            return {targetEnemy.Name, 1, "CurrentQuest", targetEnemy.HumanoidRootPart.CFrame, targetEnemy.Name, targetEnemy.HumanoidRootPart.CFrame}
        end
        return {"Bandit", 1, "BanditQuest1", CFrame.new(1060, 16, 1548), "Bandit", CFrame.new(1060, 16, 1548)}
    end
    return {Mon, Qdata, Qname, PosM, NameMon, PosQ}
end
print("Khizar Hub V10.6: Part 1 Loaded Successfully!")
-- [[ KHIZAR HUB V10.6: PART 2 - ENGINES & LOOPS ]] --

local platform = nil
function createTempPlatform(cframe)
    if not platform or not platform.Parent then
        platform = Instance.new("Part")
        platform.Size = Vector3.new(18, 1, 18)
        platform.Transparency = 1
        platform.Anchored = true
        platform.Parent = workspace
    end
    platform.CFrame = cframe * CFrame.new(0, -3.5, 0)
end

function removePlatform() if platform then platform.CFrame = CFrame.new(0, 99999, 0) end end

function stableTweenTP(targetCFrame)
    local character = LocalPlayer.Character
    local hrp = character and character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    if not hrp:FindFirstChild("BypassVelocity") then
        local bv = Instance.new("BodyVelocity", hrp)
        bv.Name = "BypassVelocity"
        bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bv.Velocity = Vector3.new(0, 0, 0)
    end
    
    createTempPlatform(targetCFrame)
    local distance = (hrp.Position - targetCFrame.Position).Magnitude
    local duration = distance / _G.TweenFruitSpeed
    
    local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear)
    local tween = game:GetService("TweenService"):Create(hrp, tweenInfo, {CFrame = targetCFrame})
    tween:Play()
    return tween
end

function stableDirectTP(targetCFrame)
    local character = LocalPlayer.Character
    local hrp = character and character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    if not hrp:FindFirstChild("BypassVelocity") then
        local bv = Instance.new("BodyVelocity", hrp)
        bv.Name = "BypassVelocity"
        bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bv.Velocity = Vector3.new(0, 0, 0)
    end
    createTempPlatform(targetCFrame)
    hrp.CFrame = targetCFrame
end

function cleanBypass()
    removePlatform()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        if LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BypassVelocity") then
            LocalPlayer.Character.HumanoidRootPart.BypassVelocity:Destroy()
        end
    end
end

function EquipWeapon(weaponType)
    local bp = LocalPlayer:FindFirstChild("Backpack")
    local char = LocalPlayer.Character
    if not bp or not char then return end
    for _, tool in pairs(bp:GetChildren()) do
        if tool:IsA("Tool") and (tool.ToolTip == weaponType or string.find(tool.Name, weaponType) or (weaponType == "Melee" and (tool.ToolTip == "Combat" or tool.ToolTip == "Martial Arts"))) then
            tool.Parent = char
            break
        end
    end
end

function BringEnemy()
    if not _G.BringMobs or not PosMon or not workspace:FindFirstChild("Enemies") then return end
    for _, v in pairs(workspace.Enemies:GetChildren()) do
        if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart") then
            if (v.HumanoidRootPart.Position - PosMon).Magnitude <= 250 then
                v.HumanoidRootPart.CFrame = CFrame.new(PosMon)
                v.HumanoidRootPart.CanCollide = false
                v.Humanoid.WalkSpeed = 0
                v.Humanoid.JumpPower = 0
                if v.Humanoid:FindFirstChild("Animator") then v.Humanoid.Animator:Destroy() end
                LocalPlayer.SimulationRadius = math.huge
            end
        end
    end
end

local Attack = {}
Attack.Kill = function(model, Success)
    if model and Success and model:FindFirstChild("HumanoidRootPart") and model:FindFirstChild("Humanoid") then
        if not model:GetAttribute("Locked") then 
            model:SetAttribute("Locked", model.HumanoidRootPart.CFrame) 
        end
        PosMon = model:GetAttribute("Locked").Position
        
        BringEnemy() 
        EquipWeapon(_G.SelectWeapon)
        
        local char = LocalPlayer.Character
        local equippedTool = char and char:FindFirstChildOfClass("Tool")
        local toolTip = equippedTool and equippedTool.ToolTip or "Melee"
        
        if toolTip == "Blox Fruit" then 
            stableDirectTP(model.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0) * CFrame.Angles(0, math.rad(90), 0)) 
        else 
            stableDirectTP(model.HumanoidRootPart.CFrame * CFrame.new(0, 22, 0) * CFrame.Angles(0, math.rad(180), 0))
        end
        
        pcall(function()
            local VirtualUser = game:GetService("VirtualUser")
            VirtualUser:CaptureController()
            VirtualUser:Button1Down(Vector2.new(1,1))
        end)
    end
end

task.spawn(function()
    while true do
        task.wait(0.2)
        if _G.Level and not _G.ChestFarmActive and not _G.TeleportFruitActive then
            pcall(function()
                local mainGui = LocalPlayer.PlayerGui:FindFirstChild("Main")
                local hasQuest = mainGui and mainGui.Quest.Visible
                local questData = getActiveQuestDetails()
                
                if hasQuest then
                    local QuestTitle = mainGui.Quest.Container.QuestTitle.Title.Text
                    if not string.find(QuestTitle, questData[5]) then 
                        ReplicatedStorage.Remotes.CommF_:InvokeServer("AbandonQuest")
                    end 
                    
                    if workspace:FindFirstChild("Enemies") and workspace.Enemies:FindFirstChild(questData[1]) then 
                        for _, v in pairs(workspace.Enemies:GetChildren()) do 
                            if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v.Name == questData[1] then 
                                if string.find(QuestTitle, questData[5]) then 
                                    StatusLabel.Text = "Status: ⚔️ Farming " .. questData[1]
                                    repeat task.wait() 
                                        Attack.Kill(v, _G.Level)
                                    until not _G.Level or v.Humanoid.Health <= 0 or not v.Parent or mainGui.Quest.Visible == false 
                                else 
                                    ReplicatedStorage.Remotes.CommF_:InvokeServer("AbandonQuest") 
                                end 
                            end 
                        end 
                    else 
                        StatusLabel.Text = "Status: 🛰️ Teleporting to Spawner Location"
                        stableDirectTP(questData[4])
                        if ReplicatedStorage:FindFirstChild(questData[1]) then 
                            stableDirectTP(ReplicatedStorage:FindFirstChild(questData[1]).HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
                        end 
                    end 
                else
                    StatusLabel.Text = "Status: 📜 Taking Quest -> " .. questData[3]
                    stableDirectTP(questData[6]) 
                    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    if hrp and (hrp.Position - questData[6].Position).Magnitude <= 15 then 
                        task.wait(0.1)
                        ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest", questData[3], questData[2])
                    end 
                end
            end)
        end
    end
end)

function getSpawnedFruit()
    local items = workspace:GetDescendants()
    for i = 1, #items do
        local v = items[i]
        if v:IsA("TouchTransmitter") and v.Parent and v.Parent.Name == "Handle" then
            local root = v.Parent.Parent
            if root and (root:IsA("Tool") or root:IsA("Model")) and string.find(root.Name, "Fruit") then 
                return v.Parent, root, root.Name 
            end
        end
    end
    return nil, nil, nil
end

task.spawn(function()
    while true do
        task.wait(0.2)
        if _G.TeleportFruitActive then
            local fruitPart, fruitModel, fruitName = getSpawnedFruit()
            if fruitPart and not CurrentFruitPicked then
                StatusLabel.Text = "Status: 🛰️ Tweening -> " .. fruitName
                FruitTargetCFrame = fruitPart.CFrame * CFrame.new(0, 1.5, 0)
                local activeTween = stableTweenTP(FruitTargetCFrame)
                
                repeat 
                    task.wait() 
                until not _G.TeleportFruitActive or not fruitPart.Parent or (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and (LocalPlayer.Character.HumanoidRootPart.Position - FruitTargetCFrame.Position).Magnitude <= 4)
                
                if activeTween then activeTween:Cancel() end
                if not fruitPart.Parent or (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and (LocalPlayer.Character.HumanoidRootPart.Position - FruitTargetCFrame.Position).Magnitude <= 4) then
                    CurrentFruitPicked = true
                    StatusLabel.Text = "Status: ✅ Fruit Secured!"
                end
            elseif CurrentFruitPicked and FruitTargetCFrame then
                stableDirectTP(FruitTargetCFrame)
            else
                StatusLabel.Text = "Status: ❌ No Fruit Found"
                cleanBypass()
            end
        else
            if not _G.Level and not _G.ChestFarmActive then
                cleanBypass()
                StatusLabel.Text = "Status: Idle (Waiting for Start)"
            end
        end
    end
end)

function updateUIState(btn, stroke, state, prefixText)
    if state then
        btn.Text = prefixText .. " [ON]"
        btn.TextColor3 = Color3.fromRGB(0, 255, 150)
        stroke.Color = Color3.fromRGB(0, 255, 150)
    else
        btn.Text = prefixText .. " [OFF]"
        btn.TextColor3 = Color3.fromRGB(255, 75, 75)
        stroke.Color = Color3.fromRGB(255, 75, 75)
    end
end

LevelToggleFrame.MouseButton1Click:Connect(function()
    _G.Level = not _G.Level
    updateUIState(LevelToggleFrame, LevelStroke, _G.Level, "START AUTO FARM LEVEL")
    if _G.Level then
        _G.ChestFarmActive = false
        _G.TeleportFruitActive = false
        updateUIState(ToggleFrame, BTNStroke, false, "START DIRECT CHEST FARM")
        updateUIState(TeleportFruitToggle, TPFruitStroke, false, "TWEEN TO SPAWNED FRUIT")
    end
end)

ToggleFrame.MouseButton1Click:Connect(function()
    _G.ChestFarmActive = not _G.ChestFarmActive
    updateUIState(ToggleFrame, BTNStroke, _G.ChestFarmActive, "START DIRECT CHEST FARM")
    if _G.ChestFarmActive then
        _G.Level = false
        _G.TeleportFruitActive = false
        updateUIState(LevelToggleFrame, LevelStroke, false, "START AUTO FARM LEVEL")
        updateUIState(TeleportFruitToggle, TPFruitStroke, false, "TWEEN TO SPAWNED FRUIT")
    end
end)

TeleportFruitToggle.MouseButton1Click:Connect(function()
    _G.TeleportFruitActive = not _G.TeleportFruitActive
    updateUIState(TeleportFruitToggle, TPFruitStroke, _G.TeleportFruitActive, "TWEEN TO SPAWNED FRUIT")
    if _G.TeleportFruitActive then
        _G.Level = false
        _G.ChestFarmActive = false
        CurrentFruitPicked = false
        updateUIState(LevelToggleFrame, LevelStroke, false, "START AUTO FARM LEVEL")
        updateUIState(ToggleFrame, BTNStroke, false, "START DIRECT CHEST FARM")
    else
        cleanBypass()
    end
end)
print("Khizar Hub V10.6: Part 2 Loaded & Active!")
