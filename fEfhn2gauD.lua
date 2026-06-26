--// Services
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")

--// Main Script to Load
local MainScript = [[
loadstring(game:HttpGet("https://raw.githubusercontent.com/dreadheadscripts/ScriptHub/refs/heads/main/Aimbot-Script/Base-Gui.lua"))()
]]

--// Notification Utility
local function notify(title, text)
	pcall(function()
		StarterGui:SetCore("SendNotification", {
			Title = title,
			Text = text,
			Duration = 3
		})
	end)
end

--// Direct Execution (Bypassing Key System)
notify("Access Granted", "Key System Bypassed! Loading script...")
task.wait(0.5)

local ok, err = pcall(function()
	loadstring(MainScript)()
end)

if not ok then
	warn("Script load karne mein error aaya: ", err)
	notify("Error", "Script load nahi ho saki.")
end
