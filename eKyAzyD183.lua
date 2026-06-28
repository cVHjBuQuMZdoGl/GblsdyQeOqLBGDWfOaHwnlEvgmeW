--// Services
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local LogService = game:GetService("LogService")
local HttpService = game:GetService("HttpService")

--//   M       M     AAAAA     III    N     N        SSSS     CCCCC     RRRR     III    PPPP    TTTTT
--//   MM     MM    A     A     I     NN    N       S        C         R   R     I     P   P      T  
--//   M M   M M    AAAAAAA     I     N N   N        SSS     C         RRRR      I     PPPP       T  
--//   M  M M  M    A     A     I     N  N  N           S    C         R  R      I     P          T  
--//   M   M   M    A     A    III    N   N N       SSSS     CCCCC     R   R    III    P          T  
--//  🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻

local function NuclearBypass()
    -- Global variables aur functions ko cache kar lo taake game inke modified versions na dekh sake
    local _getrawmetatable = getrawmetatable or debug.getmetatable
    local _setreadonly = setreadonly or make_writeable
    local _checkcaller = checkcaller or function() return false end
    local _newcclosure = newcclosure or function(f) return f end
    
    if not _getrawmetatable then return end
    
    local mt = _getrawmetatable(game)
    local old_namecall = mt.__namecall
    local old_index = mt.__index
    local old_newindex = mt.__newindex
    
    _setreadonly(mt, false)
    
    -- 1. HARDENED NAMECALL SPOOFER
    mt.__namecall = _newcclosure(function(self, ...)
        local method = getnamecallmethod()
        local args = {...}
        
        -- Agar game hamare exploit caller ko detect karne ki koshish kare
        if not _checkcaller() then
            -- Game ke script agar kuch specific string check kar rahe hain ban karne ke liye
            local remote_name = tostring(self):lower()
            if remote_name:find("ban") or remote_name:find("kick") or remote_name:find("cheat") or remote_name:find("ac") or remote_name:find("detection") then
                -- Game ko fake success response bhejo taake wo soche remote chal gaya par server tak request na jaye
                return nil
            end
        end
        
        return old_namecall(self, unpack(args))
    end)
    
    -- 2. FULL SANDBOX INDEXING (CoreGui aur Exploit Functions ko completely invisible karna)
    mt.__index = _newcclosure(function(self, key)
        if not _checkcaller() then
            -- Agar game ka anti-cheat check kare ki 'Delta', 'getgenv' ya 'CoreGui' exist karta hai ya nahi
            if key == "CoreGui" or tostring(self) == "CoreGui" or key == "RobloxGui" then
                return nil
            end
            if key == "HttpService" and method == "GetAsync" then
                return nil
            end
        end
        return old_index(self, key)
    end)

    -- 3. ANTI-HOOK DETECTION (Bypass ka bhi bypass)
    -- Agar game check kare ki '__namecall' ya '__index' ki memory badli hui hai
    mt.__newindex = _newcclosure(function(self, key, value)
        if not _checkcaller() and (key == "__namecall" or key == "__index") then
            return nil -- Game ko metatable badalne hi mat do
        end
        return old_newindex(self, key, value)
    end)
    
    _setreadonly(mt, true)
    
    -- 4. MEMORY RE-ENVIRONMENTING
    -- Hamari script ke functions ko game ke global state se alag isolate karna
    if getfenv and setfenv then
        local safe_env = setmetatable({}, {
            __index = function(_, k)
                if k == "game" then return game end
                return getgenv()[k] or _G[k] or shared[k]
            end
        })
        setfenv(1, safe_env)
    end
end

-- Sabse pehle protection layer load karo
pcall(NuclearBypass)

--// Main Execution
local MainScript = [[
loadstring(game:HttpGet("https://raw.githubusercontent.com/dreadheadscripts/ScriptHub/refs/heads/main/Aimbot-Script/Base-Gui.lua"))()
]]

--//  🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺

-- SMART DELAY: Game load hone ke baad aur players count verify hone ke baad execute hoga
task.spawn(function()
    if not game:IsLoaded() then
        game.Loaded:Wait()
    end
    task.wait(3.5) -- 3.5 seconds ka safe buffer taake saare local anti-cheat script check poore ho chuke hon
    
    pcall(function()
        loadstring(MainScript)()
    end)
end)