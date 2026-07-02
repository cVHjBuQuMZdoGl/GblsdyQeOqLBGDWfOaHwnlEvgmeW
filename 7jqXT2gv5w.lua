local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local remote = ReplicatedStorage.Remotes.Trainer.KilledBot

local function getClosestBot()
    local character = player.Character
    local hrp = character and character:FindFirstChild("HumanoidRootPart")
    if not hrp then return nil end

    local closestBot
    local shortestDistance = math.huge

    for _, bot in ipairs(workspace.Bots:GetChildren()) do
        local botPart = bot:FindFirstChild("HumanoidRootPart") or bot.PrimaryPart
        if botPart then
            local distance = (hrp.Position - botPart.Position).Magnitude
            if distance < shortestDistance then
                shortestDistance = distance
                closestBot = bot
            end
        end
    end

    return closestBot
end

-- Função que mata o bot mais próximo
local function killClosestBot()
    local closestBot = getClosestBot()
    if closestBot then
        remote:FireServer(closestBot)
    end
end

-- ==================== DETECÇÃO DE PEGAR ITEM ====================

-- Método 1: Detecta quando um item é adicionado no Backpack (mais confiável)
player.Backpack.ChildAdded:Connect(function(item)
    killClosestBot()
end)

-- Método 2: Detecta quando você equipa um item (Tool)
player.CharacterAdded:Connect(function(char)
    char.ChildAdded:Connect(function(child)
        if child:IsA("Tool") then
            killClosestBot()
        end
    end)
end)

-- Método 3: (Opcional) Detecta toque em itens no chão
local function setupTouchDetection()
    if not player.Character then return end
    
    player.Character.ChildAdded:Connect(function(part)
        if part:IsA("BasePart") then
            part.Touched:Connect(function(hit)
                if hit and hit.Parent then
                    -- Você pode adicionar filtro aqui se quiser (ex: nome do item)
                    killClosestBot()
                end
            end)
        end
    end)
end

player.CharacterAdded:Connect(setupTouchDetection)
if player.Character then
    setupTouchDetection()
end

print("forcehit enabled")