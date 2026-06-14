local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/NIcoGabrielRealYtr/Solix-Hub-Library/refs/heads/retard/Source"))()

local Window = Library:Window({
    Name = "Example Hub",
    Size = UDim2.new(0, 500, 0, 300),
    FadeSpeed = 0.25
})

local Watermark = Library:Watermark("Example Hub | v1.0")
local KeybindList = Library:KeybindList()

local MainPage = Window:Page({
    Name = "Main",
    Columns = 2
})

local CombatSection = MainPage:Section({
    Name = "Combat",
    Side = 1
})

CombatSection:Toggle({
    Name = "Silent Aim",
    Flag = "SilentAim",
    Default = false,
    Callback = function(Value)
        print("Silent Aim:", Value)
    end
}):Keybind({
    Flag = "SilentAimKey",
    Default = Enum.KeyCode.X,
    Mode = "Toggle"
})

CombatSection:Slider({
    Name = "FOV",
    Flag = "FOVSlider",
    Min = 1,
    Max = 360,
    Default = 90,
    Decimals = 1,
    Suffix = "°",
    Callback = function(Value)
        print("FOV:", Value)
    end
})

CombatSection:Dropdown({
    Name = "Hit Part",
    Flag = "HitPart",
    Items = {"Head", "Torso", "Random"},
    Default = "Head",
    Callback = function(Value)
        print("Hit Part:", Value)
    end
})

local VisualSection = MainPage:Section({
    Name = "Visuals",
    Side = 2
})

VisualSection:Checkbox({
    Name = "ESP",
    Flag = "ESP",
    Default = false,
    Callback = function(Value)
        print("ESP:", Value)
    end
}):Colorpicker({
    Flag = "ESPColor",
    Default = Color3.fromRGB(255, 0, 0),
    Alpha = 0,
    Callback = function(Color, Alpha)
        print("ESP Color:", Color, Alpha)
    end
})

local ChamsToggle = VisualSection:Toggle({
    Name = "Chams",
    Flag = "Chams",
    Default = false,
    Callback = function(Value)
        print("Chams:", Value)
    end
})

ChamsToggle:Colorpicker({
    Flag = "ChamsColor",
    Default = Color3.fromRGB(0, 255, 0),
    Alpha = 0
})

VisualSection:Textbox({
    Name = "Custom Text",
    Flag = "CustomText",
    Placeholder = "Enter text...",
    Callback = function(Value)
        print("Text:", Value)
    end
})

local ButtonRow = VisualSection:Button()
ButtonRow:Add("Teleport", function()
    print("Teleporting...")
end)
ButtonRow:Add("Reset", function()
    print("Resetting...")
end)

VisualSection:Label("Made by Example", "Center")

local PlayerPage = Window:Page({
    Name = "Player",
    Columns = 2
})

local PlayerSection = PlayerPage:Section({
    Name = "Player",
    Side = 1
})

PlayerSection:Slider({
    Name = "Walk Speed",
    Flag = "WalkSpeed",
    Min = 16,
    Max = 500,
    Default = 16,
    Decimals = 1,
    Suffix = " ws",
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end
})

PlayerSection:Slider({
    Name = "Jump Power",
    Flag = "JumpPower",
    Min = 50,
    Max = 500,
    Default = 50,
    Decimals = 1,
    Suffix = " jp",
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
    end
})

Library:CreateSettingsPage(Window, Watermark, KeybindList)
Library:CheckForAutoLoad()

Watermark:SetVisible(false)
KeybindList:SetVisible(false)

Library:Notification("Welcome!", "Example Hub loaded.", 5)