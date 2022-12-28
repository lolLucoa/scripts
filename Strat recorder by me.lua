--[[
   OMG THANKS blissel#9994 for saving my life with the coroutine fix!!!!
TO-DO:
retries if tower id not found for 5s --not needed
support for hardcore and other modes --fixed
support for gperks --fixed
support for auto medic, etc. --autochain and sellfarms done
idk? abi cooldown check? --done
success check for upgrades --done
maintain tower order, can be used by using separate loop to get them (in order)
debug mode lmfao 
]]
repeat task.wait() until game:IsLoaded() == true
local UI = loadstring(game:HttpGet("https://raw.githubusercontent.com/banbuskox/dfhtyxvzexrxgfdzgzfdvfdz/main/jsdnfjdsfdjnsmvkjhlkslzLIB", true))()
getgenv().towersE = {}
local Players = game:GetService('Players')
local repS = game:GetService("ReplicatedStorage")
local rF = repS:WaitForChild('RemoteFunction')
local insert = table.insert
local remove = table.remove
if not getgenv().towers then
   getgenv().towers = {}
end
local status = nil
local CGui = game:GetService("CoreGui")
local lPlayer = game.Players.LocalPlayer
local PGui = lPlayer.PlayerGui
local state = repS:WaitForChild('State')
local timer = state:WaitForChild('Timer')
local WaveL = PGui:WaitForChild('GameGui'):WaitForChild('Health'):WaitForChild('Wave')
local GoldenPerks = {}
local Cwave, timem, times, timems
local aS, aSP = false, state:WaitForChild('Voting'):WaitForChild("Enabled")
writefile(state.Map.Value..' Recorder.txt', "")

--Gui
local w = UI:CreateWindow('Recorder..?')
w:Section('Last Log:')
w:Section('Loading...')
for i,v in pairs(CGui:GetDescendants()) do
    if v:IsA("TextLabel") and v.Text == "Loading..." then
        status = v
    end
end
--local functions
local function Log(text)
   print(text)
   if status then
      status.Text = text
   end
end
local function isInbetween()
   if timer.Time.Value<=5 and workspace:FindFirstChild('PathArrow') then
      return 'true'
   else
      return 'false'
   end
end
local function updateTime()
   Cwave = string.sub(WaveL.Text, 6, #WaveL.Text)
   local timet = timer.Time.Value
   timem = math.floor(timet/60)
   times = timet%60
   timems = tick()
end
updateTime()
timer.Time.Changed:Connect(updateTime)
local function getTime()
   local timediff = 1 - (tick()-timems)
   return {Cwave, tostring(timem), string.format("%.1f", times + timediff)--[[decimal place changer]], isInbetween()}
end
local function GetIdFromTower(tower)
   for i,v in pairs(getgenv().towers) do
      if v == tower then
         return i
      end
   end
   return nil
end
local function AppFile(method, args)
   local final = 'TDS:'..method..'('..table.concat(args, ', ')..')\n'
   appendfile(repS.State.Map.Value..' Recorder.txt', final)
   Log(method..' '..args[1]) 
end
local function processArgs(Args, result, cTime)
   if Args[1] == 'Troops' then
      if Args[2] == 'Place' then
         local tower = result
         local pos, rot = Args[4]['Position'], Args[4]['Rotation']
         if tower and type(tower) ~= 'string' then
            insert(getgenv().towers, tower)
            AppFile(Args[2], {'"'..Args[3]..'"', tostring(pos.x), tostring(pos.y), tostring(pos.z), cTime[1], cTime[2], cTime[3], 'true', tostring(rot.x), tostring(rot.y), tostring(rot.z), isInbetween()})
         else
            Log("Tower not placed!")
         end
      elseif Args[2] == 'Upgrade' then
         local tower = Args[4]['Troop']
         local id = GetIdFromTower(tower)
         local price = result --returns upgrade price, true if maxed, ? if no cash
         local maxxed = tower:GetAttribute('Maxxed')
         if id and price and not maxxed then
            if type(price) == 'boolean' then
               tower:SetAttribute('Maxxed', 0)
            end
            AppFile(Args[2], {tostring(id), unpack(cTime)})
         else
            Log('Upgrade failed')
         end
      elseif Args[2] == 'Sell' and #Args <= 3 then 
         local tower = Args[3]['Troop']
         local id = GetIdFromTower(tower)
         if id then
            getgenv().towers[id] = false --so insert doesn't override it
            AppFile(Args[2], {tostring(id), unpack(cTime)})
         else
            Log('Sell failed')
         end
      elseif Args[2] == 'Abilities' and not Args[4]['AutoChain'] then
         local tower = Args[4]['Troop']
         local AbiName = Args[4]['Name']
         local id = GetIdFromTower(tower)
         local suc = result --true if success, false if not
         if id and suc then
            AppFile('Ability', {tostring(id), '"'..AbiName..'"', unpack(cTime)})
         else
            Log('Ability use failed')
         end
      elseif Args[2] == 'Target' then
         local tower = Args[4]['Troop']
         local id = GetIdFromTower(tower)
         if id then
            AppFile(Args[2], {tostring(id), unpack(cTime)})
         else
            Log('Target change failed')
         end
      end
   elseif Args[1] == 'Waves' and Args[2] == 'Skip' then
      AppFile('Skip', cTime)
   elseif Args[1] == 'Difficulty' then
      AppFile('Mode', {'"'..Args[3]..'"'})
   end
end

--Buttons
w:Button('Activate AutoChain', function()
   local cTime = getTime()
   local commanders = {}
   for i,v in pairs(workspace.Towers:GetChildren()) do
      if v and v.Replicator:GetAttribute("Type") == "Commander" and v.Owner.Value == lPlayer.UserId then
         insert(commanders, GetIdFromTower(v))
      end
   end
   if #commanders >= 3 then
      AppFile("AutoChain", {commanders[1], commanders[2], commanders[3], unpack(cTime)})
      loadstring(game:HttpGet("https://banbus.cf/scripts/tdsautochain"))()
   else
      Log('Not enough commanders!')
   end
end)
w:Button('Sell All Farms', function()
   local cTime = getTime()
   AppFile("SellAllFarms", {unpack(cTime)})
   for i,v in pairs(workspace.Towers:GetChildren()) do
      if v and v.Replicator:GetAttribute("Type") == "Farm" and v.Owner.Value == lPlayer.UserId then
         rF:InvokeServer('Troops', 'Sell', {Troop = v}, "Ignore") --5th true to silence
      end
   end
end)
w:Toggle('Auto Skip', {flag = "as"}, function(v) aS = v end)
aSP:GetPropertyChangedSignal("Value"):Connect(function() if aS and aSP.Value then wait(.15) rF:InvokeServer('Waves', 'Skip') end end)
--Gui settings
local gui = CGui:FindFirstChild("ScreenGui")
gui.Parent = PGui
gui.ResetOnSpawn = false
--Initialization
Log('Loaded!')
for TowerName, Tower in next, game.ReplicatedStorage.RemoteFunction:InvokeServer("Session", "Search", "Inventory.Troops") do
   if (Tower.Equipped) then
      table.insert(getgenv().towersE, '"'..TowerName..'"')
      if (Tower.GoldenPerks) then
         table.insert(GoldenPerks, '"'..TowerName..'"')
      end
   end
end
if #GoldenPerks > 0 then
   appendfile(game.ReplicatedStorage.State.Map.Value..' Recorder.txt', 'getgenv().GoldenPerks = {'..table.concat(GoldenPerks, ', ')..'}\n')
end
appendfile(game.ReplicatedStorage.State.Map.Value..' Recorder.txt', 'local TDS = loadstring(game:HttpGet("https://raw.githubusercontent.com/banbuskox/dfhtyxvzexrxgfdzgzfdvfdz/main/ckmhjvskfkmsStratFun2", true))()\n')
AppFile('Loadout', {table.concat(getgenv().towersE, ', ')})
local difficulty = state.Difficulty.Value
if difficulty == 'Hardcore' then
   AppFile('Map', {'"'..game.ReplicatedStorage.State.Map.Value..'"', 'true', "'Hardcore'"}) --HC support add later
else
   AppFile('Map', {'"'..game.ReplicatedStorage.State.Map.Value..'"', 'true', "'Survival'"}) --HC support add later
end


-- Remote logger
local namecall;namecall = hookmetamethod(game,"__namecall",newcclosure(function(self,...)
   local Args = {...}
   if self == rF and getnamecallmethod() == "InvokeServer" then
       local thread = coroutine.running()
       coroutine.wrap(function(self,...)    
           local cTime = getTime()
           local a = self.InvokeServer(self,...)
           processArgs(Args, a, cTime)
           coroutine.resume(thread,a)
       end)(self,...)
       return coroutine.yield()
   end
   return namecall(self,...)
end))
--Autoskip Recorder (to be added)

