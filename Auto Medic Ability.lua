--[[Fixed everything lmao
Credits to 
Gal. Sigmanic#6607 for some functions, such as troop detection
Made my MintTea#9260
]]
local suc,err = pcall(function()
--Defining Variables
local RS, TW, RF, LPSR = game:GetService("ReplicatedStorage"), workspace:WaitForChild("Towers"), game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction"), nil
local Medics, MedicIndex, MedicAbility, MedicMicro, StunnedCount, status, library = {}, 0, false, false, 0, nil,loadstring(game:HttpGet("https://raw.githubusercontent.com/Sigmanic/ROBLOX/main/ModificationWallyUi", true))()
local AbilityDelay = 2 --Change to 1.5, or 1. Whichever works best for you :)
local Debounce = false
local Debug = true
local TowersStunnedBeforeAbility = 5 --Default option. Can be changed in the GUI
--Functions
local function prints(v)
    if Debug then
        warn(v)
    end
end
local function microTower(tower,statuss)
    if statuss then
        status.Text = statuss
    end
    local frame = tower.HumanoidRootPart.CFrame
    local tname = tower.Replicator:GetAttribute("Type")
    local upgrade = tower.Replicator:GetAttribute("Upgrade")
    --Sell tower
    RF:InvokeServer("Troops","Sell",{Troop = tower})
    --Place tower
    tower = RF:InvokeServer("Troops","Place",tname,{Rotation = frame.Rotation,Position = frame.Position})
    --Upgrade tower
    for i = 1, upgrade do
        RF:InvokeServer("Troops","Upgrade","Set",{Troop = tower})
    end
    prints("Microed tower!")
    return tower
end

local function checkStun(tower) -- checks stuns of tower
    local repl = tower:FindFirstChild("Replicator")
    if not repl then return false end 
    local stuns = repl.Stuns
    for i,v in pairs(stuns:GetAttributes()) do
        if v == true then
            prints("Detected Stun!")
            return true
        end
    end
    return false
end
local function refreshStun(medic)
    local st = 0
    for i,v in pairs(workspace.Towers:GetChildren()) do
        if (medic.HumanoidRootPart.Position-v.HumanoidRootPart.Position).Magnitude <= medic.Replicator:GetAttribute("Range") and checkStun(v) then
            st = st + 1
        end
    end
    return st
end
local function Medic1()
    if #Medics < 1 then
        return "Waiting for Medic..."
    end
    MedicIndex = (MedicIndex % #Medics) + 1
    local selectedMedic = Medics[MedicIndex]
    if selectedMedic.Replicator:GetAttribute("Upgrade") < 5 then
        return "Waiting for lvl 5 medic..."
    elseif StunnedCount < 1 then
        return "Waiting for stun..."
    end
        -- Use Ability
    if MedicAbility then
        wait(AbilityDelay)
        if #Medics < 1 then return "You sold your medic ._." end
        if not selectedMedic then
            MedicIndex = (MedicIndex % #Medics) + 1
            selectedMedic = Medics[MedicIndex]  
        end
        StunnedCount = refreshStun(selectedMedic)
        MedicIndex = MedicIndex + 1
        if selectedMedic.Replicator:GetAttribute("Upgrade") < 5 then
            return "Waiting for lvl 5 medic..."
        elseif StunnedCount < 1 then
            return "Waiting for stun..."
        end
        local Re = RF:InvokeServer("Troops","Abilities","Activate",{Troop = selectedMedic,Name = "Cleansing"})
        if not Re then --Ability on cooldown, micro medic
            if MedicMicro then
                if selectedMedic.Replicator:GetAttribute("Worth") > LPSR:GetAttribute("Cash") then return "You can't afford to Micro! Waiting..." end
                selectedMedic = microTower(selectedMedic, "Microing Medic...")
                RF:InvokeServer("Troops","Abilities","Activate",{Troop = selectedMedic,Name = "Cleansing"})       
                StunnedCount = refreshStun(selectedMedic)
                return "Used Ability!"
            else
                return "Ability on cooldown... Waiting..."
            end
        else
            StunnedCount = refreshStun(selectedMedic)
            return "Used Ability!"
        end
    else
        return "Medic Ability Not turned on!"
    end
    return "An error occured..."
end
local function Medic()
    if not Debounce then
        Debounce = true
        local re = Medic1()
        Debounce = false
        return re or "An error occured..."
    else
        return status.Text
    end
end

local function monitorTower(tower)
    if tower:FindFirstChild("Owner").Value and tower:FindFirstChild("Owner").Value == game:GetService("Players").LocalPlayer.UserId and tower.Replicator:GetAttribute("Type") == "Medic" then
        table.insert(Medics,tower)
        prints("Medic found! Adding to list...")
        status.Text = Medic()
        if tower.Replicator:GetAttribute("Upgrade") < 5 then
            local Temp = nil
            Temp = tower.Replicator:GetAttributeChangedSignal("Upgrade"):Connect(function()
                if tower.Parent == nil then
                    Temp:Disconnect()
                    return
                end
                if tower.Replicator:GetAttribute("Upgrade") == 5 then
                    prints("Medic maxed!")
                    status.Text = Medic()
                    Temp:Disconnect()
                end
            end)
        end
    else   
        prints("Found tower that isn't medic! Monitoring for stun...") 
        if checkStun(tower) then
            StunnedCount = StunnedCount + 1
            if StunnedCount >= TowersStunnedBeforeAbility then
                status.Text = Medic()
                prints("Stunned count reached! using abi...")
            end
        end
        tower.Replicator.Stuns.Changed:Connect(function()
            if checkStun(tower) then
                StunnedCount = StunnedCount + 1 --detects stuns, requests medic ability
                if StunnedCount >= TowersStunnedBeforeAbility then
                    status.Text = Medic()
                    prints("Stunned count reached! using abi...")
                end
            end
        end)
    end
end

--Initialization
if not game:IsLoaded() then game.Loaded:Wait() end
if getgenv().AlrExecMAC then
	game.StarterGui:SetCore("SendNotification", {
        Title = "Auto Medic V3",
        Text = "Script Already Executed.";
        Duration = 6;
	})
	return
elseif game.PlaceId ~= 5591597781 then
    game.StarterGui:SetCore("SendNotification", {
        Title = "Auto Medic V3",
        Text = "Not in game! Killing script...";
        Duration = 6;
    })
    return
else
    game.StarterGui:SetCore("SendNotification", {
        Title = "Auto Medic V3",
        Text = "Script Executed! Enjoy :)";
        Duration = 6;
    })
end
getgenv().AlrExecMAC = true
for i,v in pairs(RS.StateReplicators:GetChildren()) do
    if v:GetAttribute("UserId") and v:GetAttribute("UserId") == game.Players.LocalPlayer.UserId then
        LPSR = v
    end
end
--Main Script 
local w = library:CreateWindow("Auto Medic Ability V3")
w:Toggle("Auto Medic Abilities", {flag='enabled'}, function() MedicAbility = w.flags.enabled end)
w:Toggle("Auto Micro Medics", {flag='microing'}, function() MedicMicro = w.flags.microing end)
w:Slider("Min. Stuns",{min = 1, max = 20, default=5, pricise = true, flag = w.flags.mintower},function(value)
    value = tonumber(value)
    if not value then value = 1 end
    TowersStunnedBeforeAbility = value
end)
w:Button("Delete Gui",function()
    --w:DestroyGui() --Can't be used due to the latest UI loadstring being obfuscated and MM isn't gonna be happy
    for i,v in pairs(game:GetService("CoreGui"):GetDescendants()) do
        if v:IsA("Frame") and v.Name == "Auto Medic Ability V3" then
            v.Parent.Parent:Destroy()
        end
    end
    getgenv().TowerAddedM:Disconnect()
    getgenv().TowerRemovedM:Disconnect()
    StatusTable = nil
    getgenv().AlrExecMAC = false
end)
w:Section('Loading...')
for i,v in pairs(game:GetService("CoreGui"):GetDescendants()) do
    if v:IsA("TextLabel") and v.Text == "Loading..." then
        status = v
    end
end

for i,v in pairs(game:GetService("Workspace").Towers:GetChildren()) do
   monitorTower(v)
end

getgenv().TowerAddedM = game:GetService("Workspace").Towers.ChildAdded:Connect(function(v)
    wait(.25)
    if not v:FindFirstChild("Replicator") then
        repeat wait() until v:FindFirstChild("Replicator")
    end
    monitorTower(v)
end)

getgenv().TowerRemovedM = game:GetService("Workspace").Towers.ChildRemoved:Connect(function(v)
    if v:FindFirstChild("Owner").Value and v:FindFirstChild("Owner").Value == game:GetService("Players").LocalPlayer.UserId and v.Replicator:GetAttribute("Type") == "Medic" then
        for i,t in next,Medics do
            if t == v then
                table.remove(Medics,i)
                spawn(function()
                    status.Text = "Medic Removed!"
                    wait(1)
                    status.Text = Medic()
                end)             
            end
        end
    end
end)
status.Text = Medic()
end)
if not suc then warn(err) end
