local library = loadstring(
    game:HttpGet(
        'https://raw.githubusercontent.com/vuInerability/thugsense/refs/heads/main/library.lua'
    )
)()
local flags = library.flags

local Window = Library:Window({
    Name = 'you can change the name here',
    --Size = UDim2.new(0, 600, 0, 400),
    FadeSpeed = 0.25,
})

local Watermark = Library:Watermark(
    'thugsense ~ '
        .. os.date('%b %d %Y')
        .. ' ~ '
        .. game:GetService('MarketplaceService')
            :GetProductInfo(game.PlaceId).Name
)
local KeybindList = Library:KeybindList()

Watermark:SetVisibility(false)
KeybindList:SetVisibility(false)

local CombatTab = Window:Page({ Name = 'Combat', Columns = 2, Subtabs = false })
local MiscTab = Window:Page({ Name = 'Misc', Columns = 2, Subtabs = false })
local VisualsTab =
    Window:Page({ Name = 'Visuals', Columns = 2, Subtabs = false })
local SettingsTab =
    Window:Page({ Name = 'Settings', Columns = 2, Subtabs = false })

do -- Combat Tab
    local CharacterSection = CombatTab:Section({ Name = 'Character', Side = 2 })

    CharacterSection:Toggle({
        Name = 'follow target',
        Flag = 'Enabled',
        Default = false,
        Callback = function(Value)
            print(Value)
        end,
    })

    CharacterSection:Toggle({
        Name = 'void spam',
        Flag = 'void spam',
        Default = false,
        Callback = function(Value)
            print(Value)
        end,
    })

    CharacterSection:Toggle({
        Name = 'destroy',
        Flag = 'destroy',
        Default = false,
        Callback = function(Value)
            print(Value)
        end,
    })

    CharacterSection:Toggle({
        Name = 'cheater desync',
        Flag = 'cheater desync',
        Default = false,
        Callback = function(Value)
            print(Value)
        end,
    })

    CharacterSection:Toggle({
        Name = 'fake position',
        Flag = 'fake position',
        Default = false,
        Callback = function(Value)
            print(Value)
        end,
    }):Keybind({
        Name = 'Hotkey',
        Flag = 'Hotkey',
        Default = Enum.KeyCode.J,
        Mode = 'Toggle',
        Callback = function(Value)
            print(Value)
        end,
    })

    local Divider = CharacterSection:Divider()

    CharacterSection:Slider({
        Name = 'ticks',
        Min = 120,
        Max = 300,
        Default = 160,
        Suffix = '',
        Decimals = 1,
        Compact = true,
        Flag = 'ticks',
        Callback = function(Value)
            print(Value)
        end,
    })
end

-- Target aim section

local TargetAimSection = CombatTab:Section({ Name = 'TargetAim', Side = 1 })

TargetAimSection:Toggle({
    Name = 'Enabled',
    Flag = 'Enabled',
    Default = false,
    Callback = function(Value)
        print(Value)
    end,
})

local Divider = TargetAimSection:Divider()

TargetAimSection:Toggle({
    Name = 'target aim',
    Flag = 'target aim',
    Default = false,
    Callback = function(Value)
        print(Value)
    end,
}):Keybind({
    Name = 'Hotkey',
    Flag = 'Hotkey',
    Default = Enum.KeyCode.C,
    Mode = 'Toggle',
    Callback = function(Value)
        print(Value)
    end,
})

TargetAimSection:Toggle({
    Name = 'bullet tp',
    Flag = 'bullet tp',
    Default = false,
    Callback = function(Value)
        print(Value)
    end,
})

TargetAimSection:Toggle({
    Name = 'view target',
    Flag = 'view target',
    Default = false,
    Callback = function(Value)
        print(Value)
    end,
})

TargetAimSection:Toggle({
    Name = 'tracer',
    Flag = 'tracer',
    Default = false,
    Callback = function(Value)
        print(Value)
    end,
}):Colorpicker({
    Name = 'tracer color',
    Flag = 'tracer color',
    Default = Color3.fromRGB(0, 255, 255),
    Callback = function(Value, Alpha)
        print(Value, Alpha)
    end,
})

TargetAimSection:Toggle({
    Name = 'dot',
    Flag = 'dot',
    Default = false,
    Callback = function(Value)
        print(Value)
    end,
}):Colorpicker({
    Name = 'dot color',
    Flag = 'dot color',
    Default = Color3.fromRGB(255, 255, 0),
    Callback = function(Value, Alpha)
        print(Value, Alpha)
    end,
})

TargetAimSection:Toggle({
    Name = 'highlight',
    Flag = 'hightlight',
    Default = false,
    Callback = function(Value)
        print(Value)
    end,
}):Colorpicker({
    Name = 'highlight color',
    Flag = 'highlight color',
    Default = Color3.fromRGB(255, 0, 255),
    Callback = function(Value, Alpha)
        print(Value, Alpha)
    end,
})

local Divider = TargetAimSection:Divider()

TargetAimSection:Toggle({
    Name = 'Forcehit',
    Flag = 'Forcehit',
    Default = false,
    Callback = function(Value)
        print(Value)
    end,
}):Keybind({
    Name = 'Hotkey',
    Flag = 'Hotkey',
    Default = Enum.KeyCode.T,
    Mode = 'Toggle',
    Callback = function(Value)
        print(Value)
    end,
})

local Divider = TargetAimSection:Divider()

TargetAimSection:Toggle({
    Name = 'forcefield check',
    Flag = 'forcefield check',
    Default = false,
    Callback = function(Value)
        print(Value)
    end,
})

TargetAimSection:Toggle({
    Name = 'wall check',
    Flag = 'wall check',
    Default = false,
    Callback = function(Value)
        print(Value)
    end,
})

TargetAimSection:Toggle({
    Name = 'prefire forcefield',
    Flag = 'prefire forcefield',
    Default = false,
    Callback = function(Value)
        print(Value)
    end,
})

TargetAimSection:Slider({
    Name = 'prefire seconds',
    Min = 0,
    Max = 5,
    Default = 1.5,
    Decimals = 0.1,
    Flag = 'prefire seconds',
    Callback = function(Value)
        print(Value)
    end,
})

local AutoSection = CombatTab:Section({ Name = 'Auto', Side = 2 })

AutoSection:Toggle({
    Name = 'auto reload',
    Flag = 'auto reload',
    Default = false,
    Callback = function(Value)
        print(Value)
    end,
})

AutoSection:Toggle({
    Name = 'auto armor',
    Flag = 'auto armor',
    Default = false,
    Callback = function(Value)
        print(Value)
    end,
})

AutoSection:Toggle({
    Name = 'auto stomp',
    Flag = 'auto stomp',
    Default = false,
    Callback = function(Value)
        print(Value)
    end,
})

AutoSection:Toggle({
    Name = 'anti stomp',
    Flag = 'anti stomp',
    Default = false,
    Callback = function(Value)
        print(Value)
    end,
})

--
do
    local EspSection = VisualsTab:Section({ Name = 'esp', Side = 1 })
    EspSection:Toggle({
        Name = 'box',
        Flag = 'box',
        Default = false,
        Callback = function(Value)
            print(Value)
        end,
    })

    EspSection:Toggle({
        Name = 'box fill',
        Flag = 'box fill',
        Default = false,
        Callback = function(Value)
            print(Value)
        end,
    }):Colorpicker({
        Name = 'color',
        Flag = 'box fill color',
        Default = Color3.fromRGB(255, 255, 255),
        Callback = function(Value)
            print(Value)
        end,
    })

    EspSection:Slider({
        Name = 'box transparency',
        Min = 0,
        Max = 100,
        Default = 100,
        Suffix = '%',
        Decimals = 1,
        Compact = true,
        Flag = 'box transparency',
        Callback = function(Value)
            print(Value)
        end,
    })

    EspSection:Toggle({
        Name = 'health bar',
        Flag = 'health bar',
        Default = false,
        Callback = function(Value)
            print(Value)
        end,
    })

    EspSection:Toggle({
        Name = 'armor bar',
        Flag = 'armor bar',
        Default = false,
        Callback = function(Value)
            print(Value)
        end,
    })

    EspSection:Toggle({
        Name = 'names',
        Flag = 'names',
        Default = false,
        Callback = function(Value)
            print(Value)
        end,
    })

    EspSection:Slider({
        Name = 'distance',
        Min = 200,
        Max = 10000,
        Default = 500,
        Suffix = '%',
        Decimals = 1,
        Compact = true,
        Flag = 'distance',
        Callback = function(Value)
            print(Value)
        end,
    })

    EspSection:Toggle({
        Name = 'weapon text',
        Flag = 'weapon text',
        Default = false,
        Callback = function(Value)
            print(Value)
        end,
    })

    EspSection:Toggle({
        Name = 'chams',
        Flag = 'chams',
        Default = false,
        Callback = function(Value)
            print(Value)
        end,
    })

    EspSection:Slider({
        Name = 'chams transparency',
        Min = 0,
        Max = 100,
        Default = 100,
        Suffix = '%',
        Decimals = 1,
        Compact = true,
        Flag = 'chams transparency',
        Callback = function(Value)
            print(Value)
        end,
    })

    local VisualsSection =
        VisualsTab:Section({ Name = 'I dont know what to name it', Side = 2 })

    VisualsSection:Toggle({
        Name = 'china hat',
        Flag = 'china hat',
        Default = false,
        Callback = function(Value)
            print(Value)
        end,
    })

    VisualsSection:Toggle({
        Name = 'gun material',
        Flag = 'gun material',
        Default = false,
        Callback = function(Value)
            print(Value)
        end,
    }):Colorpicker({
        Name = 'gun color',
        Flag = 'gun color',
        Default = Color3.fromRGB(255, 255, 255),
        Callback = function(Value, Alpha)
            print(Value, Alpha)
        end,
    })

    VisualsSection:Dropdown({
        Name = 'gun material',
        Flag = 'gun material',
        Default = 'neon',
        Items = { 'neon', 'Forcefield' },
        Callback = function(Value)
            print(Value)
        end,
    })

    local Divider = VisualsSection:Divider()

    VisualsSection:Toggle({
        Name = 'indicator',
        Flag = 'indicator',
        Default = false,
        Callback = function(Value)
            print(Value)
        end,
    }):Colorpicker({
        Name = 'Color',
        Flag = 'Highlight Color',
        Default = Color3.fromRGB(255, 255, 255),
        Callback = function(Value)
            print(Value)
        end,
    })

    local PlayerVisualsSection =
        VisualsTab:Section({ Name = 'Player Visuals', Side = 2 })

    PlayerVisualsSection:Toggle({
        Name = 'hit chams',
        Flag = 'hit chams',
        Default = false,
        Callback = function(Value)
            print(Value)
        end,
    })

    PlayerVisualsSection:Slider({
        Name = 'hit chams duration',
        Min = 0,
        Max = 5,
        Default = 1,
        Suffix = '',
        Decimals = 0.1,
        Compact = true,
        Flag = 'Hit Chance',
        Callback = function(Value)
            print(Value)
        end,
    })

    PlayerVisualsSection:Slider({
        Name = 'hit chams transparency',
        Min = 0,
        Max = 100,
        Default = 100,
        Suffix = '%',
        Decimals = 0.1,
        Compact = true,
        Flag = 'hit chams transparency',
        Callback = function(Value)
            print(Value)
        end,
    })

    local Divider = PlayerVisualsSection:Divider()

    PlayerVisualsSection:Toggle({
        Name = 'hit effect',
        Flag = 'hit effect',
        Default = false,
        Callback = function(Value)
            print(Value)
        end,
    })

    PlayerVisualsSection:Dropdown({
        Name = 'hit effect',
        Flag = 'hit effect',
        Default = 'option 1',
        Items = { 'option 1', 'option 2', 'option 3', 'option 4', 'option 5' },
        Callback = function(Value)
            print(Value)
        end,
    })

    local CrosshairSection =
        VisualsTab:Section({ Name = 'Crosshair', Side = 1 })

    CrosshairSection:Toggle({
        Name = 'crosshair',
        Flag = 'crosshair',
        Default = false,
        Callback = function(Value)
            print(Value)
        end,
    })

    CrosshairSection:Toggle({
        Name = 'remove default crosshair',
        Flag = 'remove default crosshair',
        Default = false,
        Callback = function(Value)
            print(Value)
        end,
    })

    CrosshairSection:Toggle({
        Name = 'animations',
        Flag = 'animations',
        Default = false,
        Callback = function(Value)
            print(Value)
        end,
    })

    local Divider = CrosshairSection:Divider()

    CrosshairSection:Slider({
        Name = 'crosshair size',
        Min = 0,
        Max = 10,
        Default = 1,
        Suffix = '',
        Decimals = 1,
        Compact = true,
        Flag = 'crosshair size',
        Callback = function(Value)
            print(Value)
        end,
    })

    CrosshairSection:Slider({
        Name = 'crosshair gap',
        Min = 0,
        Max = 10,
        Default = 1,
        Suffix = '',
        Decimals = 1,
        Compact = true,
        Flag = 'crosshair gap',
        Callback = function(Value)
            print(Value)
        end,
    })

    CrosshairSection:Slider({
        Name = 'crosshair thickness',
        Min = 0,
        Max = 5,
        Default = 1,
        Suffix = '',
        Decimals = 1,
        Compact = true,
        Flag = 'crosshair thickness',
        Callback = function(Value)
            print(Value)
        end,
    })

    CrosshairSection:Slider({
        Name = 'outline thickness',
        Min = 0,
        Max = 5,
        Default = 1,
        Suffix = '',
        Decimals = 1,
        Compact = true,
        Flag = 'outline thickness',
        Callback = function(Value)
            print(Value)
        end,
    })

    CrosshairSection:Slider({
        Name = 'rotation speed',
        Min = 0,
        Max = 10,
        Default = 1,
        Suffix = '',
        Decimals = 1,
        Compact = true,
        Flag = 'rotation speed',
        Callback = function(Value)
            print(Value)
        end,
    })
end

do
    local MovementSection = MiscTab:Section({ Name = 'Movement', Side = 1 })
    local EmoteSection = MiscTab:Section({ Name = 'Emotes', Side = 2 })

    MovementSection:Toggle({
        Name = 'cframe speed',
        Flag = 'cframe speed',
        Default = false,
        Callback = function(Value)
            print(Value)
        end,
    }):Keybind({
        Name = 'Hotkey',
        Flag = 'Hotkey',
        Default = Enum.KeyCode.Z,
        Mode = 'Toggle',
        Callback = function(Value)
            print(Value)
        end,
    })

    MovementSection:Toggle({
        Name = 'cframe fly',
        Flag = 'cframe fly',
        Default = false,
        Callback = function(Value)
            print(Value)
        end,
    }):Keybind({
        Name = 'Hotkey',
        Flag = 'Hotkey',
        Default = Enum.KeyCode.X,
        Mode = 'Toggle',
        Callback = function(Value)
            print(Value)
        end,
    })

    MovementSection:Toggle({
        Name = 'noclip',
        Flag = 'noclip',
        Default = false,
        Callback = function(Value)
            print(Value)
        end,
    })

    local Divider = MovementSection:Divider()

    MovementSection:Slider({
        Name = 'cframe speed',
        Min = 0,
        Max = 1000,
        Default = 100,
        Decimals = 1,
        Flag = 'cframe speed',
        Callback = function(Value)
            print(Value)
        end,
    })

    MovementSection:Slider({
        Name = 'fly speed',
        Min = 0,
        Max = 1000,
        Default = 100,
        Decimals = 1,
        Flag = 'fly speed',
        Callback = function(Value)
            print(Value)
        end,
    })

    EmoteSection:Toggle({
        Name = 'Enabled',
        Flag = 'Enabled',
        Default = false,
        Callback = function(Value)
            print(Value)
        end,
    })

    local Divider = EmoteSection:Divider()

    EmoteSection:Dropdown({
        Name = 'Emotes',
        Flag = 'Emotes',
        Default = { 'Floss' },
        Multi = false,
        Items = { 'Floss', 'yungblud happier jump' },
        Callback = function(Value)
            print(Value)
        end,
    })
end

do -- Settings Tab
    local SettingsSection = SettingsTab:Section({ Name = 'Settings', Side = 2 })
    local ConfigsSection = SettingsTab:Section({ Name = 'Profiles', Side = 1 })

    for Index, Value in Library.Theme do
        SettingsSection:Label({ Name = Index, Alignment = 'Left' })
            :Colorpicker({
                Name = Index,
                Default = Value,
                Flag = 'Theme' .. Index,
                Callback = function(Color)
                    Library.Theme[Index] = Color
                    Library:ChangeTheme(Index, Color)
                end,
            })
    end

    SettingsSection:Label({ Name = 'Menu Keybind', Alignment = 'Left' })
        :Keybind({
            Name = 'Menu Keybind',
            Flag = 'Menu Keybind',
            Default = Enum.KeyCode.RightControl,
            Mode = 'Toggle',
            Callback = function(Value)
                Library.MenuKeybind = Library.Flags['Menu Keybind'].Key
            end,
        })

    SettingsSection:Toggle({
        Name = 'Watermark',
        Flag = 'Watermark',
        Default = false,
        Callback = function(Value)
            Watermark:SetVisibility(Value)
        end,
    })

    SettingsSection:Toggle({
        Name = 'Keybind List',
        Flag = 'Keybind List',
        Default = false,
        Callback = function(Value)
            KeybindList:SetVisibility(Value)
        end,
    })

    SettingsSection:Dropdown({
        Name = 'Tweening Style',
        Flag = 'Tweening Style',
        Default = 'Exponential',
        Items = {
            'Linear',
            'Sine',
            'Quad',
            'Cubic',
            'Quart',
            'Quint',
            'Exponential',
            'Circular',
            'Back',
            'Elastic',
            'Bounce',
        },
        Callback = function(Value)
            Library.Tween.Style = Enum.EasingStyle[Value]
        end,
    })

    SettingsSection:Dropdown({
        Name = 'Tweening Direction',
        Flag = 'Tweening Direction',
        Default = 'Out',
        Items = { 'In', 'Out', 'InOut' },
        Callback = function(Value)
            Library.Tween.Direction = Enum.EasingDirection[Value]
        end,
    })

    SettingsSection:Slider({
        Name = 'Tweening Time',
        Min = 0,
        Max = 5,
        Default = 0.25,
        Decimals = 0.01,
        Flag = 'Tweening Time',
        Callback = function(Value)
            Library.Tween.Time = Value
        end,
    })

    SettingsSection:Button({
        Name = 'Notification test',
        Callback = function()
            Library:Notification(
                'This is a notification This is a notification This is a notification This is a notification',
                5,
                Color3.fromRGB(
                    math.random(0, 255),
                    math.random(0, 255),
                    math.random(0, 255)
                )
            )
        end,
    })

    SettingsSection:Button({
        Name = 'Unload library',
        Callback = function()
            Library:Unload()
        end,
    })

    local ConfigName
    local ConfigSelected

    local ConfigsListbox = ConfigsSection:Listbox({
        Items = {},
        Name = 'Configs',
        Flag = 'Configs List',
        Callback = function(Value)
            ConfigSelected = Value
        end,
    })

    ConfigsSection:Textbox({
        Name = 'Config Name',
        Placeholder = '. .',
        Flag = 'Config Name',
        Callback = function(Value)
            ConfigName = Value
        end,
    })

    ConfigsSection:Button({
        Name = 'Create Config',
        Callback = function()
            if
                not isfile(
                    Library.Folders.Configs .. '/' .. ConfigName .. '.json'
                )
            then
                writefile(
                    Library.Folders.Configs .. '/' .. ConfigName .. '.json',
                    Library:GetConfig()
                )

                Library:RefreshConfigsList(ConfigsListbox)
            else
                Library:Notification(
                    "Config '" .. ConfigName .. ".json' already exists",
                    3,
                    Color3.FromR(255, 0, 0)
                )
                return
            end
        end,
    })

    ConfigsSection:Button({
        Name = 'Load Config',
        Callback = function()
            if ConfigSelected then
                Library:LoadConfig(
                    readfile(Library.Folders.Configs .. '/' .. ConfigSelected)
                )
            end

            Library:Thread(function()
                task.wait(0.1)

                for Index, Value in Library.Theme do
                    Library.Theme[Index] = Library.Flags['Theme' .. Index].Color
                    Library:ChangeTheme(
                        Index,
                        Library.Flags['Theme' .. Index].Color
                    )
                end
            end)
        end,
    })

    ConfigsSection:Button({
        Name = 'Delete Config',
        Callback = function()
            if ConfigSelected then
                Library:DeleteConfig(ConfigSelected)

                Library:RefreshConfigsList(ConfigsListbox)
            end
        end,
    })

    ConfigsSection:Button({
        Name = 'Save Config',
        Callback = function()
            if ConfigSelected then
                Library:SaveConfig(ConfigSelected)
            end
        end,
    })

    ConfigsSection:Button({
        Name = 'Refresh Configs',
        Callback = function()
            Library:RefreshConfigsList(ConfigsListbox)
        end,
    })

    Library:RefreshConfigsList(ConfigsListbox)
end

--

getgenv().Library = Library
return Library