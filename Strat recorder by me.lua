--[[
TO-DO:
retries if tower id not found for 5s
support for hardcore
support for autochain, autosellfarms, auto medic, etc.
idk? abi cooldown check?
success check for upgrades
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
local PGui = game.Players.LocalPlayer.PlayerGui
writefile('TDS_AutoStrat\\'..game.ReplicatedStorage.State.Map.Value..' Recorder.txt', "")

--Gui
w = UI:CreateWindow('Recorder..?')
w:Section('Last Log:')
w:Section('Loading...')
local gui = CGui.ScreenGui
gui.Parent = PGui
gui.ResetOnSpawn = false
for i,v in pairs(PGui:GetDescendants()) do
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
   local wave = game.Players.LocalPlayer.PlayerGui.GameGui.Health.Wave.Text
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
   Log('Tower not found!')
   return nil
end
local function GetNextPlacedTower(timeout)
   if not timeout then timeout = 5 end
   local t = workspace.Towers.ChildAdded:Wait()
   local o = t:WaitForChild('Owner')
   if o.Value == game.Players.LocalPlayer.UserId then
      return t
   end
   --[[
   wait(timeout)
   Log('Error! Tower not placed correctly!')
   return nil
   ]]
end
local function AppFile(method, args)
   local final = 'TDS:'..method..'('..table.concat(args, ', ')..')\n'
   appendfile('TDS_AutoStrat\\'..game.ReplicatedStorage.State.Map.Value..' Recorder.txt', final)
   Log(method..' '..args[1]) 
end
--Initialization
Log('Loaded!')
appendfile('TDS_AutoStrat\\'..game.ReplicatedStorage.State.Map.Value..' Recorder.txt', 'local TDS = loadstring(game:HttpGet("https://raw.githubusercontent.com/banbuskox/dfhtyxvzexrxgfdzgzfdvfdz/main/ckmhjvskfkmsStratFun2", true))()\n')
for TowerName, Tower in next, game.ReplicatedStorage.RemoteFunction:InvokeServer("Session", "Search", "Inventory.Troops") do
   if (Tower.Equipped) then
      table.insert(TowersE, '"'..TowerName..'"')
   end
end
AppFile('Loadout', {table.concat(TowersE, ', ')})
AppFile('Map', {'"'..game.ReplicatedStorage.State.Map.Value..'"', 'true', "'Survival'"}) --HC support add later
-- Remote logger
local OldFunc = nil
OldFunc = hookmetamethod(game, '__namecall',function(Self, ...)
   local Args = {...}
   local NamecallMethod = getnamecallmethod()
   spawn(function()
      if Self == event and NamecallMethod == "InvokeServer" then
         if Args[1] == 'Troops' then
            if Args[2] == 'Place' then
                  local tower = GetNextPlacedTower()
                  local pos, rot = Args[4]['Position'], Args[4]['Rotation']
                  if tower then
                     print("test")
                     insert(towers, tower)
                     AppFile(Args[2], {'"'..Args[3]..'"', tostring(pos.x), tostring(pos.y), tostring(pos.z), getTime()[1], getTime()[2], getTime()[3], 'true', tostring(rot.x), tostring(rot.y), tostring(rot.z), isInbetween()})
                  else
                     Log("Tower failed to place for whatever reason!")
                  end
            elseif Args[2] == 'Upgrade' then
               local tower = Args[4]['Troop']
               local id = GetIdFromTower(tower)
               if id then
                  AppFile(Args[2], {tostring(id), getTime()[1], getTime()[2], getTime()[3], isInbetween()})
               else
                  Log('Error! Upgrade failed because tower not found')
               end
            elseif Args[2] == 'Sell' then
               local tower = Args[3]['Troop']
               local id = GetIdFromTower(tower)
               if id then
                  towers[id] = nil
                  AppFile(Args[2], {tostring(id), getTime()[1], getTime()[2], getTime()[3], isInbetween()})
               else
                  Log('Error! Sell failed because tower not found')
               end
            elseif Args[2] == 'Abilities' then
               local tower = Args[4]['Troop']
               local AbiName = Args[4]['Name']
               local id = GetIdFromTower(tower)
               if id then
                  AppFile(Args[2], {tostring(id), '"'..AbiName..'"', getTime()[1], getTime()[2], getTime()[3], isInbetween()})
               else
                  Log('Error! Ability failed because tower not found')
               end
            end
         elseif Args[1] == 'Waves' then
            AppFile('Skip', {getTime()[1], getTime()[2], getTime()[3], isInbetween()})
         elseif Args[1] == 'Difficulty' then
            AppFile('Mode', {'"'..Args[3]..'"'})
         end
      end
   end)
   return OldFunc(Self, ...)
end)