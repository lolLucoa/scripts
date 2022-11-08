--Credits to Thomas Andrew#8787 for some of the core functions, such as troop detection
--[[
    TODO - Add distance check to medic (stunned tower in range)
]] 
local suc, err = pcall(function()
--Functions
if getgenv().AlrExecMAC then
	game.StarterGui:SetCore("SendNotification", {
	Title = "Auto Medic",
	Text = "Script Already Executed.";
	Duration = 6;
	})
	return
elseif game.PlaceId ~= 5591597781 then
    game.StarterGui:SetCore("SendNotification", {
        Title = "Auto Medic",
        Text = "Not in game! Killing script...";
        Duration = 6;
        })
        return
end
getgenv().AlrExecMAC = true
--Constants/Variables
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Sigmanic/ROBLOX/main/ModificationWallyUi", true))() --Wally UI Loadstring by Thomas Andrew#8787
local Medics = {}
local enabled = false
local microing = false
local useAb = false
local status
--Medic chain function
local w = library:CreateWindow("Auto Medic Ability")
w:Toggle("Auto Medic Abilities", {flag='enabled'}, function() enabled = w.flags.enabled end)
w:Toggle("Auto Micro Medics", {flag='microing'}, function() microing = w.flags.microing end)
w:Button("Delete Gui",function()
    for i,v in pairs(game:GetService("CoreGui"):GetDescendants()) do
        if v:IsA("Frame") and v.Name == "Auto Medic Ability" then
            v.Parent.Parent:Destroy()
        end
    end
    getgenv().TowerAdded:Disconnect()
    getgenv().TowerRemoved:Disconnect()
    StatusTable = nil
    getgenv().AlrExecMAC = false
end)
w:Section('Loading...')
for i,v in pairs(game:GetService("CoreGui"):GetDescendants()) do
    if v:IsA("TextLabel") and v.Text == "Loading..." then
        status = v
    end
end
--Functions
local function MedicAbi(tower)
    game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer("Troops","Abilities","Activate",{Troop = tower,Name = "Cleansing"})
end
local function tFuncs(tower,operation, arg) -- 1 - place 2 - upgrade 3 - sell 
    if operation == 1 then --place
        local t = game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer("Troops","Place",tower,{Rotation = arg.Rotation,Position = arg.Position})
        return t
    elseif operation == 2 then
        if arg == nil then arg = 1 warn("No Level Provided!") end
        warn("Attempting to upgrade medic to level ",arg)
        for i = 1, arg do
        game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer("Troops","Upgrade","Set",{Troop = tower})
        wait(0.1)
        end
    elseif operation == 3 then
        game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer("Troops","Sell",{Troop = tower})
    end
end
local function checkStun(tower)
    local stuns = tower.Replicator.Stuns
    local r = false
    for i,v in pairs(stuns:GetAttributes()) do
        if v == true then
            r = true
            warn("Detected Stun!")
        end
    end
    return r
end
local function microTower(tower,statuss)
    if statuss then
        status.Text = statuss
    end
    local frame = tower.HumanoidRootPart.CFrame
    local tname = tower.Replicator:GetAttribute("Type")
    local upgrade = tower.Replicator:GetAttribute("Upgrade")
    --sell tower
    warn("[Debug] Selling tower...")
    tFuncs(tower,3)
    wait()
    --Place tower
    tower = tFuncs(tname,1,frame)
    warn("[Debug] Placing Tower...")
    wait()
    --Upgrade tower
    tFuncs(tower,2,upgrade)
    warn("[Debug] Upgraded tower!")
    wait()
end
--Detects medic
for i,v in pairs(game:GetService("Workspace").Towers:GetChildren()) do
    if v:FindFirstChild("Owner").Value and v:FindFirstChild("Owner"). Value == game:GetService("Players").LocalPlayer.UserId and v.Replicator:GetAttribute("Type") == "Medic" then
            table.insert(Medics,v)
            status.Text = "Detected Medic!"
            warn("Found Medic!")
    else    
            if checkStun(v) then
                useAb = true
            end
            v.Replicator.Stuns.Changed:Connect(function()
                if checkStun(v) then
                    useAb = true
                end
            end)
    end
end
getgenv().TowerAdded = game:GetService("Workspace").Towers.ChildAdded:Connect(function(v)
    wait(.25)
    if not v:FindFirstChild("Replicator") then
        repeat wait() until v:FindFirstChild("Replicator")
    end
    if v:FindFirstChild("Owner").Value and v:FindFirstChild("Owner").Value == game:GetService("Players").LocalPlayer.UserId and v.Replicator:GetAttribute("Type") == "Medic" then
            table.insert(Medics,v)
            status.Text = "Detected new medic placed!"
    else
            v.Replicator.Stuns.Changed:Connect(function()
                if checkStun(v) then
                    useAb = true
                end
            end)
    end
end)
getgenv().TowerRemoved = game:GetService("Workspace").Towers.ChildRemoved:Connect(function(v)
    if v:FindFirstChild("Owner").Value and v:FindFirstChild("Owner").Value == game:GetService("Players").LocalPlayer.UserId and v.Replicator:GetAttribute("Type") == "Medic" then
        for i,t in next,Medics do
            if t == v then
                table.remove(Medics,i)
                status.Text = "Medic Removed!"
            end
        end
    end
    task.wait()
end)
wait(.5)
status.Text = "Loaded! "..tostring(#Medics).." Medic(s) found!"
local index = 0
    while wait() do
        if enabled and #Medics > 0 then
            index = index + 1
            if index > #Medics then
                index = 1
            end
            repeat 
            if Medics[index].Replicator:GetAttribute("Upgrade") < 5 then
                index = index + 1
                if index > #Medics then
                    index = 1
                end
                status.Text = "Waiting for max medic..."
                wait(.1)
            end
            until Medics[index].Replicator:GetAttribute("Upgrade") == 5 or (#Medics < 1)
            repeat wait(.1) status.Text = "Waiting for stun..." until useAb==true or (#Medics < 1) 
            wait(1)--slight delay to wait til towers are properly stunned
            if #Medics > 0 then
                warn("Detected stun! Using ability...")
                MedicAbi(Medics[index])
                status.Text = "Activated Medic Ability"
                if microing then
                    warn("[Debug] Microing medic...")
                    microTower(Medics[index], "Microing Medic...")
                end
            end
            useAb = false
        elseif #Medics < 1 then
                status.Text = 'Waiting for Medics...'
        end
    
    end     

end)
if not suc then warn(err) end
