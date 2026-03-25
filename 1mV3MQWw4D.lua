if not skidware then
    return
end
--[[
Func: skidware.GetInfo()
return: target (Instance), positionaim (Vector3), hitpart (string), airhitpart (string)

Func: skidware.BuyItem(item, delay)
Example: skidware.BuyItem("brownbag", 0.4)

Func: skidware.Is_Reloading
return: boolean

Func: skidware.Is_Death(player)
example: skidware.Is_Death(game.Players.LocalPlayer)
return: boolean

Func: skidware.Is_KO(player)
example: skidware.Is_KO(game.Players.LocalPlayer)
return: boolean
]]
local Plugin = skidware.AddLeftGroupbox("Example")

Plugin:AddToggle("Toggle 1", {
    Text = "Toggle 1",
    Default = false,
    Callback = function(v)
        print("Toggle:", v)
    end
})

Plugin:AddToggle("Toggle 2", {
    Text = "Toggle 2",
    Default = false,
    Callback = function(v)
        print("Toggle:", v)
    end
}):AddColorPicker("test", {
    Default = Color3.fromRGB(255,0,0),
    Title = "Pick a color",
    Callback = function(c)
        print("Color:", c)
    end
})

Plugin:AddDropdown("Mode", {
    Values = {"A","B","C"},
    Default = 1,
    Multi = false,
    Text = "Select Mode",
    Callback = function(v)
        print("Mode:", v)
    end
})

Plugin:AddLabel('Color'):AddColorPicker("Color", {
    Default = Color3.fromRGB(255,0,0),
    Title = "Pick a color",
    Callback = function(c)
        print("Color:", c)
    end
})

Plugin:AddLabel('Keybind'):AddKeyPicker("Key", {
    Default = "F",
    SyncToggleState = false,
    Mode = "Toggle",
    Text = "Select Keybind",
    Callback = function(v)
        print("Keybind:", v)
    end
})

Plugin:AddSlider("Slider", {
    Text = "Slider",
    Default = 50,
    Min = 0,
    Max = 100,
    Rounding = 0,
    Callback = function(v)
        print("Slider:", v)
    end
})

Plugin:AddButton("Button", function()
    print("hello")
end)

Plugin:AddButton("Print Info", function()
    local currenttarget, positionaim, hitpart, airhitpart = skidware.GetInfo()
    print(currenttarget, positionaim, hitpart, airhitpart)
end)

Plugin:AddButton("Notify", function()
    skidware.Notify("hi", 5)
end)