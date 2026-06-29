repeat wait() until game:IsLoaded() and game:FindFirstChild("CoreGui") and pcall(function() return game.CoreGui end) [cite: 28]

getgenv().jinkX = getgenv().jinkX or {}
local _function = {
    ["block_executor"] = function()
        local blockedExecutors = {
            "xeno",
            "solara",
            "velocity" [cite: 28]
        }
        if identifyexecutor then [cite: 28]
            local current = identifyexecutor():lower() [cite: 29]
            for _, name in ipairs(blockedExecutors) do [cite: 29]
                if current:find(name) then [cite: 29]
                    return true [cite: 29]
                end
            end
        end
        return false [cite: 30]
    end,
    ["getid"] = function()
        local g = game.GameId [cite: 30]
        if getgenv().jinkX and getgenv().jinkX["Fish It"] and getgenv().jinkX["Fish It"]["Enabled"] then return "0708c0109bad431c5513f6d2dcc9b9e5" end [cite: 30]

        if g == 9051406594 then return "d73b977af0e75026f30f65e1e6c27538" [cite: 30]
        elseif g == 9186719164 then return "a8973c6c4f93baab43a01d8141581e89" [cite: 30]
        end
    end,
    ["gamename"] = function() [cite: 30, 31]
        local g = game.GameId [cite: 31]
        if g == 9051406594 then return "Dueling Grounds" [cite: 31]
        elseif g == 9186719164 then return "Sailor Piece" [cite: 31]
        end
    end,
}

local script_id, game_name, block_executor = _function.getid(), _function.gamename(), _function.block_executor() [cite: 31]

if block_executor then 
    game.Players.LocalPlayer:Kick("JinkX\nUnsupported executor detected.") [cite: 31, 32]
    return 
end

if script_id then
    game.StarterGui:SetCore(
        "SendNotification",
        {
            Title = "JinkX Loaded!",
            Text = (game_name or "Global") .. " Script Loaded! (Keyless Bypass Active)",
            Icon = "rbxassetid://79605757154544",
            Duration = 5
        } [cite: 32, 33]
    )
    
    --// KEY SYSTEM PERMANENTLY BYPASSED & REMOVED
    -- Seedha Luarmor file ko execute kar rahe hain bina kisi GitHub Key verification ke
    pcall(function()
        loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/" .. script_id .. ".lua"))()
    end)
else
    warn("JinkX: This game is not supported.") [cite: 33]
end