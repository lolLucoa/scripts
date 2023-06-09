-- DJ Music Gui, Made by MintTea#9260
-- Defining functions and variables
local DJ
local function getDJ()
    if not DJ then
        for i,v in pairs(workspace.Towers:GetChildren()) do
            local Repl = v:FindFirstChild("Replicator")
            local Owner = v:FindFirstChild("Owner")
            if Repl and Repl:GetAttribute("Type") == "DJ Booth" and Owner and Owner.Value == game.Players.LocalPlayer.UserId then
                DJ = v
            end
        end
    end
end
local function Play(id)
    getDJ()
    if not DJ then return end
    local response = game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer("Troops", "Execute", {Data = {[1] = id}, Name = "Music", Tower = DJ})
    if not response then
        game.StarterGui:SetCore("SendNotification", {
            Title = "DJ Music Gui",
            Text = "You don't have the DJ Music Gamepass! The Audio will only play for you...";
            Duration = 3;
        })
        local hrp = DJ:WaitForChild("HumanoidRootPart")
        if hrp then
            hrp:FindFirstChild("Music").SoundId = "rbxassetid://"..tostring(id)
        end
    end
end

-- Initialization
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/TacoCatBackWardsIsTacoCat/scripts/main/TwinkLib.lua", true))() -- A modification of twink library
local UI = library.Load("TDS DJ Music Gui [Must have custom music gamepass]")

-- Pages
local TDSAudios = UI.AddPage("TDS Originals")
local Popular = UI.AddPage("Popular Music")
local Meme = UI.AddPage("Meme Sounds")
local Roblox = UI.AddPage("Roblox Music")
local MonsterCat = UI.AddPage("MonsterCat")
local Custom = UI.AddPage("Settings")

-- Audio Ids 
-- To add an Id, append ["Name"] = id to the dictionary below!!
local TDSIds = {
    ['Plushie DJ'] = 11580212035,
    ['Neko DJ'] = 5229282080,
    ['Default DJ'] = 3780415070,
    ['Neon Rave DJ'] = 4459639238,
    ['Smug Emote'] = 9166993097,
    ['ManRobotics Emote'] = 9166993858,
    ['Transcendence'] = 9166996324,
    ['Solar Lobby Theme'] = 7653200934,
    ['Turret Fire (troll)'] = 4743347100,
    ['Triumph!'] = 8013047518,
    ['Ghost DJ'] = 5994058479
}
local PopularIds = {
    ['Crab Rave'] = 5410086218,
    ["It's raining tacos"] = 142376088,
    ['Chicken Nugget DreamLand'] = 9245561450,
    ['TacoBoy 3000'] = 9245552700,
    ['Chair De Lune'] = 1838457617,
    ['Jingle Bells'] = 9046954223,
    ['Uptown'] = 1845554017,
    ['Backrooms'] = 7910582982,
    ['8 bit kitty - Underscore'] = 9039445224,
    ['Phantom at the Opera'] = 1843463175
}
local MemeIds = {
    ['Rickrolled'] = 7363412529,
    ['Amogus'] = 6425216149,
    ['COCA COLA ESPUMA'] = 5693336619,
    ['WHOS THAT POKEMON'] = 130767090,
    ['Everybody do the flop'] = 130778839,
    ['Sad Violin'] = 135308045,
    ['Windows XP shutdown'] = 784747919,
    ['FEED ME'] = 130766856,
    ['I have fallen and I cant get up'] = 130768088,
    ['WHAT ARE YOU DOING IN MY SWAMP'] = 130767645,
    ['Minions - BEDOBEDOBEDO'] = 130844390,
    ['THIS IS SPARTA'] = 130781067,
    ['THATS MY PURSE'] = 130760834,
    ['Ohhhh my gawd'] = 7632147717,
    ['Im Batman'] = 130769318,
    ['Minecraft death sound'] = 2607544190,
    ["John's laugh"] = 130759239,
    ['ITS FREE'] = 130771265,
    ['I can smell you'] = 130767611,
    ['Mhmm Chezburger'] = 1495409522,
    ['Can you hear me? [LOUD]'] = 4769589095,
    ['HOTEL HOTEL HOTEL'] = 2752862458,
    ['The rock eyebrow meme'] = 8987546731
}
local RobloxIds = {
    ['Time Goes By'] = 9047104919,
    ['Friends'] = 9039768700,
    ['When you coming back'] = 1837871067,
    ['Musical Box (A)'] = 1840493961,
    ['Robotic Dance C'] = 1847853099,
    ['Night Vision'] = 1837849285,
    ['Solar Flares'] = 1836842889,
    ['Stepping up'] = 1837324424,
    ['Light Dreamer'] = 9047107124,
    ['Lofi Dreams Hip Hop'] = 9047050075
}
local MonsterCatIds = {
    ['Shiawase'] = 5409360995,
    ['Destroy Me'] = 7023617400,
    ['Tokyo Machine - Play'] = 5410085763,
    ['Tokyo Machine - Epic'] = 5410085694,
    ['Protostar - New Horizons'] = 7028518546,
    ['Sapporo'] = 7028877251
}
-- Main Code   
for i,v in next, TDSIds do
    TDSAudios.AddButton(i, function()
        Play(v)
    end)
end
for i,v in next, PopularIds do
    Popular.AddButton(i, function()
        Play(v)
    end)
end
for i,v in next, MemeIds do
    Meme.AddButton(i, function()
        Play(v)
    end)
end
for i,v in next, RobloxIds do
    Roblox.AddButton(i, function()
        Play(v)
    end)
end
for i,v in pairs(MonsterCatIds) do
    MonsterCat.AddButton(i, function()
        Play(v)
    end)
end
Custom.AddTextBox("Audio Id", {}, function(v)
    local id = tonumber(v)
    if id then
        Play(id)
    end
end)
Custom.AddLabel("Client Sided Settings")
Custom.AddSlider("DJ Volume", {Min=0, Max=10, Def=1}, function(value)
    getDJ()
    if not DJ then return end
    local hrp = DJ:WaitForChild("HumanoidRootPart")
    if hrp then
        hrp:FindFirstChild("Music").Volume = value    
    end
end)
