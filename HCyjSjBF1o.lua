local runservice = game:GetService("RunService")
local camera = workspace.CurrentCamera
local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local localplayer = players.LocalPlayer


local repo = 'https://raw.githubusercontent.com/LionTheGreatRealFrFr/MobileLinoriaLib/main/'

local library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local thememanager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local savemanager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()



local game_name = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name

local window = library:CreateWindow({
 Title = 'AREX.CC | PAID |  ' .. game_name,
 Center = true,
 AutoShow = true
})

library:Notify("Script Executed on " .. game_name, 2)

local tabs = {
  combat = window:AddTab('Combat'),
  visuals = window:AddTab('Visuals'),
  config = window:AddTab('Config')
}

getgenv().camlock = {
   target_part = "HumanoidRootPart",
   prediction = {
       enabled = true,
       amount = 0.11
   },
   resolver = false,
   smoothing = 0.4,
   easing = {
       style = Enum.EasingStyle.Sine,
       direction = Enum.EasingDirection.InOut
   },
   shake = {
       x = 0,
       y = 0,
       z = 0
   },
   fov = {
       visible = false,
       radius = 30,
       transparency = 1,
       thickness = 0.7,
       color = Color3.fromRGB(126, 72, 163)
   }
}

getgenv().autoair = {
  enabled = false,
  delay = false,
  delay_amount = 0.2,
  state = "Jump"
}

getgenv().hit = {
  detection = true,
  logs = true,
  notify_duration = 1,
  sound_enabled = true,
  sound_id = "Skeet",
  sound_volume = 1
}

getgenv().strafe = {
  enabled = false,
  speed = 2,
  height = 0,
  distance = 10
}

getgenv().cframewalk = {
  enabled = false,
  speed = 1 
}

getgenv().velocity_desync = {
  enabled = false,
  velocity = 16384,
  flag_rate = 1000,
  render_wait = true
}

getgenv().anti_aim = {
  enabled = false,
  x = 100,
  y = 100, 
  z = 100,
  render_wait = true
}

getgenv().prediction_break = {
  enabled = false,
  x = 0,
  y = 0,
  z = 0,
  render_wait = true,
  use_custom_velocity = false
}

getgenv().gun_module = {
  enabled = false,
  max_ammo = 60000,
  current_ammo = 50000,
  auto_refill = true
}

getgenv().crosshair = {
  enabled = true,
  refreshrate = 0,
  mode = 'center', -- center, mouse, custom
  position = Vector2.new(0,0), -- custom position

  width = 1.5,
  length = 10,
  radius = 11,
  color = Color3.fromRGB(143, 48, 167),

  spin = true, -- animate the rotation
  spin_speed = 150,
  spin_max = 340,
  spin_style = Enum.EasingStyle.Circular, -- Linear for normal smooth spin

  resize = true, -- animate the length
  resize_speed = 150,
  resize_min = 5,
  resize_max = 22,

}

local old; old = hookfunction(Drawing.new, function(class, properties)
  local drawing = old(class)
  for i,v in next, properties or {} do
      drawing[i] = v
  end
  return drawing
end)

local runservice = game:GetService('RunService')
local inputservice = game:GetService('UserInputService')
local tweenservice = game:GetService('TweenService')
local camera = workspace.CurrentCamera

local last_render = 0

local drawings = {
  crosshair = {},
  text = {
      Drawing.new('Text', {Size = 13, Font = 2, Outline = true, Text = 'Arex', Color = Color3.new(103, 89, 179)}),
      Drawing.new('Text', {Size = 13, Font = 2, Outline = true, Text = ".cc"}),

  }
}

for idx = 1, 4 do
  drawings.crosshair[idx] = Drawing.new('Line')
  drawings.crosshair[idx + 4] = Drawing.new('Line')
end

function solve(angle, radius)
  return Vector2.new(
      math.sin(math.rad(angle)) * radius,
      math.cos(math.rad(angle)) * radius
  )
end

runservice.PostSimulation:Connect(function()

  local _tick = tick()

  if _tick - last_render > crosshair.refreshrate then
      last_render = _tick

      local position = (
          crosshair.mode == 'center' and camera.ViewportSize / 2 or
          crosshair.mode == 'mouse' and inputservice:GetMouseLocation() or
          crosshair.position
      )

      local text_1 = drawings.text[1]
      local text_2 = drawings.text[2]

      text_1.Visible = crosshair.enabled
      text_2.Visible = crosshair.enabled

      if crosshair.enabled then

          local text_x = text_1.TextBounds.X + text_2.TextBounds.X

          text_1.Position = position + Vector2.new(-text_x / 2, crosshair.radius + (crosshair.resize and crosshair.resize_max or crosshair.length) + 15)
          text_2.Position = text_1.Position + Vector2.new(text_1.TextBounds.X)
          text_2.Color = crosshair.color
          
          for idx = 1, 4 do
              local outline = drawings.crosshair[idx]
              local inline = drawings.crosshair[idx + 4]
  
              local angle = (idx - 1) * 90
              local length = crosshair.length
  
              if crosshair.spin then
                  local spin_angle = -_tick * crosshair.spin_speed % crosshair.spin_max
                  angle = angle + tweenservice:GetValue(spin_angle / 360, crosshair.spin_style, Enum.EasingDirection.InOut) * 360
              end
  
              if crosshair.resize then
                  local resize_length = tick() * crosshair.resize_speed % 180
                  length = crosshair.resize_min + math.sin(math.rad(resize_length)) * crosshair.resize_max
              end
  
              inline.Visible = true
              inline.Color = crosshair.color
              inline.From = position + solve(angle, crosshair.radius)
              inline.To = position + solve(angle, crosshair.radius + length)
              inline.Thickness = crosshair.width
  
              outline.Visible = true
              outline.From = position + solve(angle, crosshair.radius - 1)
              outline.To = position + solve(angle, crosshair.radius + length + 1)
              outline.Thickness = crosshair.width + 1.5    
          end
      else
          for idx = 1, 4 do
              drawings.crosshair[idx].Visible = false
              drawings.crosshair[idx + 4].Visible = false
          end
      end

  end
end)


local HitSoundId = {
  Bameware = "rbxassetid://3124331820",
  Bell = "rbxassetid://6534947240",
  Bubble = "rbxassetid://6534947588",
  Pick = "rbxassetid://1347140027",
  Pop = "rbxassetid://198598793",
  Rust = "rbxassetid://1255040462",
  Sans = "rbxassetid://3188795283",
  Fart = "rbxassetid://130833677",
  Big = "rbxassetid://5332005053",
  Vine = "rbxassetid://5332680810",
  Bruh = "rbxassetid://4578740568",
  Skeet = "rbxassetid://5633695679",
  Neverlose = "rbxassetid://6534948092",
  Fatality = "rbxassetid://6534947869",
  Bonk = "rbxassetid://5766898159",
  Minecraft = "rbxassetid://4018616850"
}

local hitSoundsNames = {"Bameware", "Bubble", "Pick", "Pop", "Rust", "Sans", "Fart", "Big", "Vine", "Bruh", "Skeet", "Neverlose", "Fatality", "Bonk","Minecraft"}

local fov_circle = Drawing.new("Circle")
fov_circle.Transparency = camlock.fov.transparency
fov_circle.Thickness = camlock.fov.thickness
fov_circle.Color = camlock.fov.color
fov_circle.Filled = false

local gui = Instance.new("ScreenGui")
local lock_button = Instance.new("ImageButton")
local button_corner = Instance.new("UICorner")
local target = nil
local locking = false

gui.Name = "ExtortGUI"
gui.Parent = game.CoreGui
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.ResetOnSpawn = false

lock_button.Name = "LockButton"
lock_button.Parent = gui
lock_button.Active = true
lock_button.Draggable = true
lock_button.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
lock_button.BackgroundTransparency = 0.350
lock_button.Size = UDim2.new(0, 90, 0, 90)
lock_button.Image = "rbxassetid://134820707156642"
lock_button.Position = UDim2.new(0.5, -25, 0.5, -25)

button_corner.CornerRadius = UDim.new(0.2, 0)
button_corner.Parent = lock_button

local main = tabs.combat:AddLeftGroupbox('Main Settings')
local fov = tabs.combat:AddLeftGroupbox('FOV Settings')
local air = tabs.combat:AddRightGroupbox('Air Settings')
local cframe_group = tabs.combat:AddRightGroupbox('Cframe')
local hit_group = tabs.combat:AddLeftGroupbox('Hit Settings')
local strafe_group = tabs.visuals:AddRightGroupbox('Target Strafe')
local crosshair = tabs.visuals:AddLeftGroupbox('Crosshair')

crosshair:AddToggle('enabled', {
  Text = 'Enabled',
  Default = getgenv().crosshair.enabled,
  Callback = function(value) getgenv().crosshair.enabled = value end
})

local crosshair = tabs.visuals:AddLeftGroupbox('Crosshair')

crosshair:AddDropdown('crosshair_mode', {
    Values = {'Center', 'Mouse', 'Custom'},
    Default = 'Center',
    Text = 'Crosshair Mode',
    Callback = function(value)
        if value == 'Center' then
            getgenv().crosshair.mode = 'center'
        elseif value == 'Mouse' then
            getgenv().crosshair.mode = 'mouse'
        elseif value == 'Custom' then
            getgenv().crosshair.mode = 'custom'
        end
    end
})


main:AddDropdown('target_part', {
  Values = {'HumanoidRootPart', 'UpperTorso', 'LowerTorso', 'Head'},
  Default = camlock.target_part,
  Text = 'Target Part',
  Callback = function(value) camlock.target_part = value end
})

main:AddToggle('prediction', {
  Text = 'Index + Camlock Combo',
  Default = camlock.prediction.enabled,
  Callback = function(value) camlock.prediction.enabled = value end
})

main:AddToggle('prediction', {
  Text = 'Prediction',
  Default = camlock.prediction.enabled,
  Callback = function(value) camlock.prediction.enabled = value end
})

main:AddInput('prediction_amount', {
  Default = camlock.prediction.amount,
  Text = 'Prediction Amount', 
  Callback = function(value) camlock.prediction.amount = tonumber(value) or 0.1 end
})

main:AddInput('smoothing', {
  Default = camlock.smoothing,
  Text = 'Smoothing',
  Callback = function(value) camlock.smoothing = tonumber(value) or 1 end
})

main:AddDropdown('easing_style', {
  Values = {'Linear', 'Sine', 'Back', 'Quad', 'Quart', 'Quint', 'Bounce', 'Elastic'},
  Default = 'Sine',
  Text = 'Easing Style',
  Callback = function(value) camlock.easing.style = Enum.EasingStyle[value] end
})

main:AddDropdown('easing_direction', {
  Values = {'In', 'Out', 'InOut'},
  Default = 'InOut',
  Text = 'Easing Direction',
  Callback = function(value) camlock.easing.direction = Enum.EasingDirection[value] end
})

main:AddToggle('resolver', {
  Text = 'Resolver',
  Default = camlock.resolver,
  Callback = function(value) camlock.resolver = value end
})

fov:AddToggle('fov_visible', {
   Text = 'FOV Visible',
   Default = camlock.fov.visible,
   Callback = function(value) camlock.fov.visible = value end
})

fov:AddInput('fov_radius', {
   Default = camlock.fov.radius,
   Text = 'FOV Radius',
   Callback = function(value) camlock.fov.radius = tonumber(value) or 30 end
})

fov:AddInput('fov_transparency', {
   Default = camlock.fov.transparency,
   Text = 'FOV Transparency',
   Callback = function(value)
       camlock.fov.transparency = tonumber(value) or 1
       fov_circle.Transparency = camlock.fov.transparency
   end
})

fov:AddInput('fov_thickness', {
   Default = camlock.fov.thickness,
   Text = 'FOV Thickness',
   Callback = function(value)
       camlock.fov.thickness = tonumber(value) or 0.7
       fov_circle.Thickness = camlock.fov.thickness
   end
})

air:AddToggle('enabled', {
  Text = 'Auto Air',
  Default = autoair.enabled,
  Callback = function(value) autoair.enabled = value end
})


air:AddInput('delay_amount', {
  Default = autoair.delay_amount,
  Text = 'Delay Amount',
  Callback = function(value) autoair.delay_amount = tonumber(value) or 0.2 end
})

air:AddDropdown('state', {
  Values = {'Jump', 'Freefall'},
  Default = autoair.state,
  Text = 'Auto Air State',
  Callback = function(value) autoair.state = value end
})

hit_group:AddToggle('detection', {
  Text = 'Hit Detection',
  Default = hit.detection,
  Callback = function(value) hit.detection = value end
})

hit_group:AddToggle('logs', {
  Text = 'Hit Logs',
  Default = hit.logs,
  Callback = function(value) hit.logs = value end
})

hit_group:AddToggle('sound_enabled', {
  Text = 'Hit Sound',
  Default = hit.sound_enabled,
  Callback = function(value) hit.sound_enabled = value end
})

hit_group:AddInput('notify_duration', {
  Default = hit.notify_duration,
  Text = 'Notify Duration',
  Callback = function(value) hit.notify_duration = tonumber(value) or 1 end
})

hit_group:AddDropdown('sounds', {
  Values = hitSoundsNames,
  Default = hit.sound_id,
  Text = 'Target Part',
  Callback = function(value) hit.sound_id = value end
})

hit_group:AddInput('sound_volume', {
  Default = hit.sound_volume,
  Text = 'Sound Volume',
  Callback = function(value) hit.sound_volume = tonumber(value) or 1 end
})

strafe_group:AddToggle('enabled', {
  Text = 'Enabled',
  Default = strafe.enabled,
  Callback = function(value) strafe.enabled = value end
})

strafe_group:AddInput('speed', {
  Default = strafe.speed,
  Text = 'Speed',
  Callback = function(value) strafe.speed = tonumber(value) or 2 end
})

strafe_group:AddInput('height', {
  Default = strafe.height,
  Text = 'Height',
  Callback = function(value) strafe.height = tonumber(value) or 0 end
})

strafe_group:AddInput('distance', {
  Default = strafe.distance,
  Text = 'Distance',
  Callback = function(value) strafe.distance = tonumber(value) or 10 end
})

cframe_group:AddToggle('enabled', {
  Text = 'Enabled', 
  Default = cframewalk.enabled,
  Callback = function(value) cframewalk.enabled = value end
})

cframe_group:AddToggle('enabled', {
  Text = 'Show Button', 
  Default = cframewalk.enabled,
  Callback = function(value) cframewalk.enabled = value end
})

cframe_group:AddInput('speed', {
  Default = cframewalk.speed,
  Text = 'Cframe Speed',
  Callback = function(value) cframewalk.speed = tonumber(value) or 1 end
})



local remote
local argument 
local firesignal_args = {}
local last_health = {}
local hit_sound = Instance.new("Sound")
hit_sound.Parent = game.CoreGui

local function update_fov_circle()
   if not fov_circle then return end
   fov_circle.Position = Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y/2)
   fov_circle.Visible = camlock.fov.visible
   fov_circle.Radius = camlock.fov.radius * 3.067
end

local function calculate_velocity(target_part)
  if camlock.resolver then
      local old_pos = target_part.Position
      local new_pos = target_part.Position
      local delta = tick()
      return (new_pos - old_pos) / delta
  else
      return target_part.Velocity
  end
end

local function get_closest()
   local closest = nil
   local max_dist = math.huge
   local mouse_pos = Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y/2)

   for _, player in pairs(players:GetPlayers()) do
       if player ~= localplayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
           local screen_pos, on_screen = camera:WorldToViewportPoint(player.Character.HumanoidRootPart.Position)
           if on_screen then
               local dist = (Vector2.new(screen_pos.X, screen_pos.Y) - mouse_pos).Magnitude
               if dist < max_dist and dist <= camlock.fov.radius * 3.067 then
                   closest = player
                   max_dist = dist
               end
           end
       end
   end
   return closest
end

local function tool_activated()
   if locking and target and target.Character and remote and argument then
       local target_part = target.Character[camlock.target_part]
       if target_part then
           local position = target_part.Position
           local args = {unpack(firesignal_args)}
           
           local target_position = position
           if camlock.prediction.enabled then
               target_position = position + (calculate_velocity(target_part) * camlock.prediction.amount)
           end
           
           if typeof(args[argument]) == "Vector3" then
               args[argument] = target_position
           elseif typeof(args[argument]) == "CFrame" then
               args[argument] = CFrame.new(target_position)
           end
           
           remote:FireServer(unpack(args))
       end
   end
end

local function modify_gun(tool)
  if not gun_module.enabled or not tool:IsA("Tool") then return end
  
  local script = tool:WaitForChild("Script", 2)
  if not script then return end
  
  local max_ammo = script:FindFirstChild("MaxAmmo")
  local ammo = script:FindFirstChild("Ammo")
  
  if max_ammo then 
      max_ammo.Value = gun_module.max_ammo
  end
  
  if ammo then
      ammo.Value = gun_module.current_ammo
      
      if gun_module.auto_refill then
          ammo:GetPropertyChangedSignal("Value"):Connect(function()
              ammo.Value = gun_module.current_ammo
          end)
      end
  end
end

local function handle_tool(tool)
  if gun_module.enabled then
      modify_gun(tool)
  end
end

local function handle_character_added(char)
   char.ChildAdded:Connect(function(child)
       if child:IsA("Tool") then
           child.Activated:Connect(tool_activated)
       end
   end)
end

lock_button.MouseButton1Click:Connect(function()
  if locking then
      lock_button.Image = "rbxassetid://134820707156642"
      locking = false
      target = nil
      library:Notify("Stopped Targeting", 2)
  else
      target = get_closest()
      if target then
          locking = true
          lock_button.Image = "rbxassetid://78342062013795"
          library:Notify("Targeting " .. target.DisplayName, 2)
      end
  end
end)

runservice.Heartbeat:Connect(function()
   if strafe.enabled and target and target.Character and localplayer.Character then
       local root = localplayer.Character.HumanoidRootPart
       local current_time = tick()
       local strafe_cframe = CFrame.new(target.Character.HumanoidRootPart.Position) * 
                    CFrame.Angles(0, 2 * math.pi * current_time * strafe.speed % (2 * math.pi), 0) * 
                    CFrame.new(0, strafe.height, strafe.distance)
       root.CFrame = strafe_cframe
   end
   
   if cframewalk.enabled and localplayer.Character then
       local root = localplayer.Character.HumanoidRootPart
       local humanoid = localplayer.Character:FindFirstChild("Humanoid")
       local move_dir = humanoid.MoveDirection
       root.CFrame = root.CFrame + (move_dir * cframewalk.speed)
   end
   
   if velocity_desync.enabled and localplayer.Character then
       local root = localplayer.Character.HumanoidRootPart
       local set = not set
       local old_vel = root.Velocity
       
       sethiddenproperty(root, "NetworkIsSleeping", set)
       setfflag("S2PhysicsSenderRate", velocity_desync.flag_rate)
       root.Velocity = Vector3.new(0,0,0)
       
       if velocity_desync.render_wait then
           runservice.RenderStepped:Wait()
       end
       
       root.Velocity = old_vel
       root.Parent.Humanoid:ChangeState(Enum.HumanoidStateType.None)
       setfflag("S2PhysicsSenderRate", 2)
       sethiddenproperty(root, "NetworkIsSleeping", not set)
       root.Velocity = Vector3.new(-velocity_desync.velocity, -velocity_desync.velocity, -velocity_desync.velocity)
       
       if velocity_desync.render_wait then
           runservice.RenderStepped:Wait()
       end
       
       root.Parent.Humanoid:ChangeState(Enum.HumanoidStateType.None)
       root.Velocity = old_vel
   end
   
   if anti_aim.enabled and localplayer.Character then
       local root = localplayer.Character.HumanoidRootPart
       local old_vel = root.Velocity
       root.Velocity = Vector3.new(anti_aim.x, anti_aim.y, anti_aim.z)
       
       if anti_aim.render_wait then
           runservice.RenderStepped:Wait()
       end
       
       root.Velocity = old_vel
   end
   
   if prediction_break.enabled and localplayer.Character then
       local root = localplayer.Character.HumanoidRootPart
       local old_vel = root.Velocity
       
       if prediction_break.use_custom_velocity then
           root.Velocity = Vector3.new(prediction_break.x, prediction_break.y, prediction_break.z)
       else
           root.Velocity = Vector3.new(0, 0, 0)
       end
       
       if prediction_break.render_wait then
           runservice.RenderStepped:Wait()
       end
       
       root.Velocity = old_vel
   end
end)

task.spawn(function()
   while task.wait() do
       update_fov_circle()
   end
end)

runservice.PostSimulation:Connect(function()
   if locking and target and target.Character then
       local humanoid = target.Character:FindFirstChild("Humanoid")
       
       if hit.detection and humanoid then
           local current_health = humanoid.Health
           if not last_health[target.UserId] then
               last_health[target.UserId] = current_health
           end
           
           if current_health < last_health[target.UserId] then
               if hit.sound_enabled then
                  local SoundName = hit.sound_id
                   hit_sound.SoundId = HitSoundId[SoundName]
                   hit_sound.Volume = hit.sound_volume
                   hit_sound:Play()
               end
               
               if hit.logs then
                   library:Notify("Hit " .. target.DisplayName, hit.notify_duration)
               end
           end
           
           last_health[target.UserId] = current_health
       end
       
       local target_part = target.Character[camlock.target_part]
       if target_part then
           local position = target_part.Position
           
           if camlock.prediction.enabled then
               position = position + (calculate_velocity(target_part) * camlock.prediction.amount)
           end
           
           position = position + Vector3.new(
               camlock.shake.x,
               camlock.shake.y,
               camlock.shake.z
           )
           
           local target_cf = CFrame.lookAt(camera.CFrame.Position, position)
           camera.CFrame = camera.CFrame:Lerp(
               target_cf,
               camlock.smoothing,
               camlock.easing.style,
               camlock.easing.direction
           )
           
local framework = localplayer.PlayerGui:WaitForChild("Framework", math.huge)
if framework then
    local env = getsenv(framework)
    if env._G then
        env._G.MOUSE_POSITION = position
    end
end
       end
   end
end)



runservice.RenderStepped:Connect(function()
  if autoair.enabled then
    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
        local humanoid = target.Character:FindFirstChild("Humanoid")
        
        if humanoid then
            local state = humanoid:GetState()
            local playerCharacter = game.Players.LocalPlayer.Character
            local tool = localplayer.Character and localplayer.Character:FindFirstChildOfClass("Tool")
            
            if (state == Enum.HumanoidStateType.Jumping or state == Enum.HumanoidStateType.Freefall) then
                if tool then
                  task.wait(autoair.delay_amount)
                    tool:Activate()
                end
            end
        end
    end
  end
end)



local mt = getrawmetatable(game)
local old = mt.__namecall
setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
   local args = {...}
   local method = getnamecallmethod()
   
   if locking and not checkcaller() and method == "FireServer" then
       for i,v in pairs(args) do
           if typeof(v) == "Vector3" or typeof(v) == "CFrame" then
               remote = self
               argument = i
               firesignal_args = args
           end
       end
   end
   
   return old(self, ...)
end)

setreadonly(mt, true)

localplayer.CharacterAdded:Connect(handle_character_added)
if localplayer.Character then
   handle_character_added(localplayer.Character)
end

localplayer.Backpack.ChildAdded:Connect(handle_tool)

savemanager:SetLibrary(library)
thememanager:SetLibrary(library)
thememanager:SetFolder('camlock')
savemanager:SetFolder('camlock')
thememanager:ApplyToTab(tabs.config)
savemanager:BuildConfigSection(tabs.config)