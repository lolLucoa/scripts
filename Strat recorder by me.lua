--[[
   OMG THANKS blissel#9994 for saving my life with the coroutine fix!!!!
TO-DO:
retries if tower id not found for 5s
support for hardcore
support for auto medic, etc. --autochain and sellfarms done
idk? abi cooldown check? --done
success check for upgrades --done
maintain tower order, can be used by using separate loop to get them (in order)
debug mode lmfao 
]]
repeat task.wait() until game:IsLoaded() == true
local UI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Sigmanic/ROBLOX/main/ModificationWallyUi", true))()
local TowersE = {}
local Players = game:GetService('Players')
local event = game:GetService("ReplicatedStorage").RemoteFunction
local insert = table.insert
local remove = table.remove
local towers = {}
local status = nil
local CGui = game:GetService("CoreGui")
local lPlayer = game.Players.LocalPlayer
local PGui = lPlayer.PlayerGui
writefile(game.ReplicatedStorage.State.Map.Value..' Recorder.txt', "")

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
local function getTime()
   local wave = lPlayer.PlayerGui.GameGui.Health.Wave.Text
   wave = string.sub(wave, 6, #wave)
   local timet = game.ReplicatedStorage.State.Timer.Time.Value
   local timem = math.floor(timet/60)
   local times = timet%60
   return {wave, tostring(timem), tostring(times)}
end
local function isInbetween()
   if game.ReplicatedStorage.State.Timer.Time.Value<=5 and workspace:FindFirstChild('PathArrow') then
      return 'true'
   else
      return 'false'
   end
end
local function GetIdFromTower(tower)
   for i,v in pairs(towers) do
      if v == tower then
         return i
      end
   end
   return nil
end
local function GetNextPlacedTower()
   local t = workspace.Towers.ChildAdded:Wait()
   local o = t:WaitForChild('Owner')
   if o.Value == lPlayer.UserId then
      return t
   end
end
local function AppFile(method, args)
   local final = 'TDS:'..method..'('..table.concat(args, ', ')..')\n'
   appendfile(game.ReplicatedStorage.State.Map.Value..' Recorder.txt', final)
   Log(method..' '..args[1]) 
end
local function processArgs(Args, result, cTime)
   if Args[1] == 'Troops' then
      if Args[2] == 'Place' then
         local tower = result
         local pos, rot = Args[4]['Position'], Args[4]['Rotation']
         if tower and type(tower) ~= 'string' then
            insert(towers, tower)
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
            AppFile(Args[2], {tostring(id), cTime[1], cTime[2], cTime[3], isInbetween()})
         else
            Log('Upgrade failed')
         end
      elseif Args[2] == 'Sell' and #Args <= 3 then 
         local tower = Args[3]['Troop']
         local id = GetIdFromTower(tower)
         if id then
            towers[id] = false --so insert doesn't override it
            AppFile(Args[2], {tostring(id), cTime[1], cTime[2], cTime[3], isInbetween()})
         else
            Log('Sell failed')
         end
      elseif Args[2] == 'Abilities' and not table.find(Args[4], 'AutoChain') then
         local tower = Args[4]['Troop']
         local AbiName = Args[4]['Name']
         local id = GetIdFromTower(tower)
         local suc = result --true if success, false if not
         if id and suc then
            AppFile('Ability', {tostring(id), '"'..AbiName..'"', cTime[1], cTime[2], cTime[3], isInbetween()})
         else
            Log('Ability use failed')
         end
      elseif Args[2] == 'Target' then
         local tower = Args[4]['Troop']
         local id = GetIdFromTower(tower)
         if id then
            AppFile(Args[2], {tostring(id), cTime[1], cTime[2], cTime[3], isInbetween()})
         else
            Log('Target change failed')
         end
      end
   elseif Args[1] == 'Waves' then
      AppFile('Skip', {cTime[1], cTime[2], cTime[3], isInbetween()})
   elseif Args[1] == 'Difficulty' then
      AppFile('Mode', {'"'..Args[3]..'"'})
   end
end
--Buttons
w:Button('Activate AutoChain', function()
   local commanders = {}
   for i,v in pairs(workspace.Towers:GetChildren()) do
      if v and v.Replicator:GetAttribute("Type") == "Commander" and v.Owner.Value == lPlayer.UserId then
         insert(commanders, GetIdFromTower(v))
      end
   end
   if #commanders >= 3 then
      AppFile("AutoChain", {commanders[1], commanders[2], commanders[3], cTime[1], cTime[2], cTime[3], isInbetween()})
      loadstring(game:HttpGet("https://banbus.cf/scripts/tdsautochain"))()
   end
end)
w:Button('Sell All Farms', function()
   AppFile("SellAllFarms", {cTime[1], cTime[2], cTime[3], isInbetween()})
   for i,v in pairs(workspace.Towers:GetChildren()) do
      if v and v.Replicator:GetAttribute("Type") == "Farm" and v.Owner.Value == lPlayer.UserId then
         event:InvokeServer('Troops', 'Sell', {Troop = v}, "Ignore") --5th true to silence
      end
   end
end)
local gui = CGui:FindFirstChild("ScreenGui")
gui.Parent = PGui
gui.ResetOnSpawn = false
--Initialization
Log('Loaded!')
appendfile(game.ReplicatedStorage.State.Map.Value..' Recorder.txt', 'local TDS = loadstring(game:HttpGet("https://raw.githubusercontent.com/banbuskox/dfhtyxvzexrxgfdzgzfdvfdz/main/ckmhjvskfkmsStratFun2", true))()\n')
for TowerName, Tower in next, game.ReplicatedStorage.RemoteFunction:InvokeServer("Session", "Search", "Inventory.Troops") do
   if (Tower.Equipped) then
      table.insert(TowersE, '"'..TowerName..'"')
   end
end
AppFile('Loadout', {table.concat(TowersE, ', ')})
AppFile('Map', {'"'..game.ReplicatedStorage.State.Map.Value..'"', 'true', "'Survival'"}) --HC support add later

-- Remote logger
local OldFunc = nil
local namecall;namecall = hookmetamethod(game,"__namecall",function(self,...)
   local Args = {...}
   if self == event and getnamecallmethod() == "InvokeServer" then
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
end)