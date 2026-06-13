local Services = {
    Players = game:GetService("Players")
}
Services.LocalPlayer = Services.Players.LocalPlayer

getgenv().ChinaHatSettings = {
    enabled = true, 
    hatColor = Color3.fromRGB(0, 170, 255),      -- Azul neon
    lightColor = Color3.fromRGB(0, 170, 255), 
    lightBrightness = 0, 
    lightRange = 12, 
    scale = Vector3.new(1.7, 1.1, 1.7), 
}

local function CreateHat(Character)
    local Head = Character:FindFirstChild("Head")
    if not Head then return end 

    local Cone = Instance.new("Part")
    Cone.Size = Vector3.new(1, 1, 1)
    Cone.BrickColor = BrickColor.new("Bright blue")
    Cone.Material = Enum.Material.Neon
    Cone.Transparency = 0.2
    Cone.Anchored = false
    Cone.CanCollide = false
    Cone.Color = getgenv().ChinaHatSettings.hatColor 

    local Mesh = Instance.new("SpecialMesh")
    Mesh.MeshType = Enum.MeshType.FileMesh
    Mesh.MeshId = "rbxassetid://1033714"
    Mesh.Scale = getgenv().ChinaHatSettings.scale 
    Mesh.Parent = Cone

    local Weld = Instance.new("Weld")
    Weld.Part0 = Head
    Weld.Part1 = Cone
    Weld.C0 = CFrame.new(0, 0.9, 0)
    Weld.Parent = Cone

    -- Luz removida completamente

    Cone.Parent = Character
end

local function OnCharacterAdded(Character)
    if getgenv().ChinaHatSettings.enabled then
        Character:WaitForChild("Head")
        CreateHat(Character)
    end
end

Services.LocalPlayer.CharacterAdded:Connect(OnCharacterAdded)

if Services.LocalPlayer.Character then
    OnCharacterAdded(Services.LocalPlayer.Character)
end