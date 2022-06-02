repeat
    wait()
until game:IsLoaded()
getgenv().SkipStratMaintance = true
wait()
local P = {}
if not getgenv().ExecutedAlr then
    if syn and not getgenv().IsMultiStrat and not getgenv().ExecDis and not getgenv().Multiplayer then
        syn.queue_on_teleport('loadstring(readfile("TDS_AutoStrat/LastStrat.txt"))()')
    elseif not getgenv().IsMultiStrat and not getgenv().ExecDis and not getgenv().Multiplayer then
        queue_on_teleport('loadstring(readfile("TDS_AutoStrat/LastStrat.txt"))()')
    end
    getgenv().ExecutedAlr = true
    getgenv().MapUsed = false
    loadstring(
        game:HttpGet(
            "https://raw.githubusercontent.com/TacoCatBackWardsIsTacoCat/scripts/main/Auto%20strat%20old%20main"
        )--Edited main file, older version of thje script
    )()
    loadstring(game:HttpGet("https://banbusscripts.netlify.app/Scripts/IsAutoStratMain"))()
    if getgenv().StratMaintance == true and not getgenv().SkipStratMaintance == true then
        repeat
            wait()
            loadstring(game:HttpGet("https://banbusscripts.netlify.app/Scripts/IsAutoStratMain"))()
            getgenv().status = "Script in maintenance, waiting..."
            wait(1)
        until getgenv().StratMaintance == false 
    end
    getgenv().status = "Loading"
    getgenv().count = 0
    if game.PlaceId == 5591597781 then
        game:GetService("Workspace").Towers.ChildAdded:Connect(
            function(a)
                getgenv().count = getgenv().count + 1
            end
        )
    end
    if not isfile("TDS_AutoStrat/UseCount.txt") then
        writefile("TDS_AutoStrat/UseCount.txt", "1")
    else
        local a = readfile("TDS_AutoStrat/UseCount.txt")
        a = tonumber(a) + 1
        writefile("TDS_AutoStrat/UseCount.txt", tostring(a))
    end
    local b = nil
    local U = game:WaitForChild("ReplicatedStorage")
    local T = U:WaitForChild("RemoteFunction")
    local b = U:WaitForChild("RemoteEvent")
    function S()
        if game.PlaceId == 5591597781 then
            return true
        else
            return false
        end
    end
    spawn(
        function()
            wait(10)
            if S() and #game.Players:GetChildren() > 1 and getgenv().Multiplayer == false then
                game:GetService("TeleportService"):Teleport(3260590327, game:GetService("Players").LocalPlayer)
            else
                if
                    S() and getgenv().Multiplayer and #game.Players:GetChildren() > getgenv().PlayerNumber and
                        getgenv().PlayerType == "Host"
                 then
                    local a = math.huge
                    local c = game:GetService("HttpService")
                    local b = game:GetService("TeleportService")
                    local f, g
                    local d = math.huge
                    local e = 0
                    repeat
                        local b =
                            "https://games.roblox.com/v1/games/" ..
                            game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
                        if (f) then
                            b = b .. "&cursor=" .. f
                        end
                        local b = c:JSONDecode(game:HttpGet(b))
                        if (b) then
                            f = b.nextPageCursor or nil
                            e = e + 1
                            for a, a in pairs(b.data) do
                                a.playing = a.playing or math.huge
                                a.id = a.id or ""
                                if a.id ~= game.JobId and a.playing <= d then
                                    d = a.playing
                                    g = a.id
                                end
                            end
                        end
                    until (not f) or (e >= a)
                    if (g) then
                        getgenv().Connection:Send('{"client":"Host","action":"Teleport","jobid":"' .. g .. '"}')
                        b:TeleportToPlaceInstance(3260590327, g)
                    end
                end
            end
        end
    )
    if S() and getgenv().PotatoPC then
        spawn(
            function()
                wait(3)
                for a, a in pairs(game.Workspace.Map:GetChildren()) do
                    if a.Name ~= "Paths" then
                        a:Remove()
                    end
                end
                local a = game.Workspace.Terrain
                a.Transparency = 0
                a.WaterReflectance = 0
                a.WaterTransparency = 0
                a.WaterWaveSize = 0
                a.WaterWaveSpeed = 0
            end
        )
    end
    if S() then
        spawn(
            function()
                wait(3)
                for a, a in pairs(game:GetService("Lighting"):GetChildren()) do
                    if a.Name ~= "Sky" then
                        a:Remove()
                    end
                end
                game.Lighting.FogStart = 10000000
                game.Lighting.FogEnd = 10000000
                game.Lighting.Brightness = 1
                local b
                if getgenv().CameraSys == true then
                    b = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0, 50, 0)
                else
                    b = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0, 20, 0)
                end
                local k = Instance.new("Part")
                k.Transparency = 1
                k.Anchored = true
                k.CanCollide = true
                k.Parent = game.Workspace
                k.CFrame = b
                if getgenv().CameraSys == true then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0, 55, 0)
                else
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0, 25, 0)
                end
                if game.CoreGui:FindFirstChild("AutoStratsLogger") then
                    game.CoreGui:FindFirstChild("AutoStratsLogger"):Remove()
                end
                local b = Instance.new("ScreenGui")
                local m = Instance.new("Frame")
                local n = Instance.new("ImageLabel")
                local k = Instance.new("Frame")
                local l = Instance.new("TextLabel")
                local o = Instance.new("ScrollingFrame")
                b.Name = "AutoStratsLogger"
                b.Parent = game:WaitForChild("CoreGui")
                b.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
                m.Name = "Main"
                m.Parent = b
                m.BackgroundColor3 = Color3.fromRGB(23, 21, 30)
                m.BorderSizePixel = 0
                m.Position = UDim2.new(0.544935644, 0, 0.355803162, 0)
                m.Size = UDim2.new(0, 500, 0, 400)
                n.Name = "Glow"
                n.Parent = m
                n.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                n.BackgroundTransparency = 1.000
                n.BorderSizePixel = 0
                n.Position = UDim2.new(0, -15, 0, -15)
                n.Size = UDim2.new(1, 30, 1, 30)
                n.ZIndex = 0
                n.Image = "rbxassetid://4996891970"
                n.ImageColor3 = Color3.fromRGB(15, 15, 15)
                n.ScaleType = Enum.ScaleType.Slice
                n.SliceCenter = Rect.new(20, 20, 280, 280)
                k.Name = "Top_Container"
                k.Parent = m
                k.AnchorPoint = Vector2.new(0.5, 0)
                k.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                k.BackgroundTransparency = 1.000
                k.Position = UDim2.new(0.5, 0, 0, 18)
                k.Size = UDim2.new(1, -40, 0, 20)
                l.Name = "Title"
                l.Parent = k
                l.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                l.BackgroundTransparency = 1.000
                l.Position = UDim2.new(0.00764120743, 0, -0.400000006, 0)
                l.Size = UDim2.new(0.981785059, 0, 1.45000005, 0)
                l.Font = Enum.Font.GothamBlack
                l.Text = "AUTOSTRATS LOGGER"
                l.TextColor3 = Color3.fromRGB(255, 255, 255)
                l.TextSize = 30.000
                l.TextXAlignment = Enum.TextXAlignment.Left
                o.Name = "Scroll"
                o.Parent = m
                o.Active = true
                o.AnchorPoint = Vector2.new(0.5, 0)
                o.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                o.BackgroundTransparency = 1.000
                o.BorderSizePixel = 0
                o.Position = UDim2.new(0.5, 4, 0, 59)
                o.Size = UDim2.new(1, -20, 1, -67)
                o.BottomImage = "rbxassetid://5234388158"
                o.CanvasSize = UDim2.new(200, 0, 100, 0)
                o.MidImage = "rbxassetid://5234388158"
                o.ScrollBarThickness = 8
                o.TopImage = "rbxassetid://5234388158"
                o.VerticalScrollBarInset = Enum.ScrollBarInset.Always
                o.ChildAdded:Connect(
                    function()
                        if #o:GetChildren() > 16 then
                            o.CanvasPosition = Vector2.new(0, o.CanvasPosition.Y + 20)
                        end
                    end
                )
                local function b()
                    local a = Instance.new("LocalScript", m)
                    a.Name = "Dragify"
                    local b = game:GetService("UserInputService")
                    function h(c)
                        C = nil
                        v = nil
                        u = nil
                        local a = nil
                        function i(a)
                            local a = a.Position - u
                            local a = UDim2.new(F.X.Scale, F.X.Offset + a.X, F.Y.Scale, F.Y.Offset + a.Y)
                            game:GetService("TweenService"):Create(c, TweenInfo.new(0.1), {Position = a}):Play()
                        end
                        c.InputBegan:Connect(
                            function(a)
                                if
                                    (a.UserInputType == Enum.UserInputType.MouseButton1 or
                                        a.UserInputType == Enum.UserInputType.Touch) and
                                        b:GetFocusedTextBox() == nil
                                 then
                                    C = true
                                    u = a.Position
                                    F = c.Position
                                    a.Changed:Connect(
                                        function()
                                            if a.UserInputState == Enum.UserInputState.End then
                                                C = false
                                            end
                                        end
                                    )
                                end
                            end
                        )
                        c.InputChanged:Connect(
                            function(a)
                                if
                                    a.UserInputType == Enum.UserInputType.MouseMovement or
                                        a.UserInputType == Enum.UserInputType.Touch
                                 then
                                    v = a
                                end
                            end
                        )
                        game:GetService("UserInputService").InputChanged:Connect(
                            function(a)
                                if a == v and C then
                                    i(a)
                                end
                            end
                        )
                    end
                    h(a.Parent)
                end
                b()
                local function b()
                    local a = Instance.new("LocalScript", m)
                    a.Name = "Positioning"
                    a.Parent:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), "Out", "Quad", 1)
                    a.Parent.Draggable = true
                end
                b()
                local h = -0.0073
                writefile("TDS_AutoStrat/LastLog.txt", "--[START OF LOG]--")
                function Q(a)
                    if a <= 9 then
                        local a = "0" .. a
                        return a
                    else
                        return a
                    end
                end
                getgenv().output = function(d)
                    local c = os.date("*t")["hour"]
                    local b = os.date("*t")["min"]
                    local e = os.date("*t")["sec"]
                    local a = Color3.fromRGB(255, 255, 255)
                    local f = Instance.new("TextLabel", o)
                    f.Text = "[" .. Q(c) .. ":" .. Q(b) .. ":" .. Q(e) .. "] " .. d
                    appendfile("TDS_AutoStrat/LastLog.txt", "\n[" .. Q(c) .. ":" .. Q(b) .. ":" .. Q(e) .. "] " .. d)
                    f.Size = UDim2.new(0.005, 0, 0.001, 0)
                    f.Position = UDim2.new(0, 0, .007 + h, 0)
                    f.Font = Enum.Font.SourceSansSemibold
                    f.TextColor3 = a
                    f.TextStrokeTransparency = 0
                    f.BackgroundTransparency = 1
                    f.BackgroundColor3 = Color3.new(0, 0, 0)
                    f.BorderSizePixel = 0
                    f.BorderColor3 = Color3.new(0, 0, 0)
                    f.FontSize = "Size14"
                    f.TextXAlignment = Enum.TextXAlignment.Left
                    f.ClipsDescendants = true
                    h = h + 0.0005
                end
                spawn(
                    function()
                        local h = false
                        h = not h
                        game.Players.LocalPlayer.Character.Humanoid.PlatformStand = true
                        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
                        p = Enum.KeyCode.LeftShift
                        g = game.Players.LocalPlayer
                        N = game.Workspace.CurrentCamera
                        O = g:GetMouse()
                        K = game:GetService("UserInputService")
                        J = Vector2.new(0, 0)
                        d = Vector3.new(0, 0, 0)
                        E = J
                        A = Vector2.new(0, 0)
                        B = false
                        D = 70
                        z = false
                        e = 3
                        x = {}
                        r = {
                            [Enum.KeyCode.D] = Vector3.new(1, 0, 0),
                            [Enum.KeyCode.A] = Vector3.new(-1, 0, 0),
                            [Enum.KeyCode.S] = Vector3.new(0, 0, 1),
                            [Enum.KeyCode.W] = Vector3.new(0, 0, -1),
                            [Enum.KeyCode.E] = Vector3.new(0, 1, 0),
                            [Enum.KeyCode.Q] = Vector3.new(0, -1, 0)
                        }
                        f = function(b, a, c)
                            if c == 1 then
                                return a
                            else
                                if tonumber(b) then
                                    return b * (1 - c) + (a * c)
                                else
                                    return b:Lerp(a, c)
                                end
                            end
                        end
                        a = function(b, a, c)
                            return Vector3.new(
                                math.clamp(b.X, a.X, c.X),
                                math.clamp(b.Y, a.Y, c.Y),
                                math.clamp(b.Z, a.Z, c.Z)
                            )
                        end
                        K.InputChanged:connect(
                            function(a)
                                if a.UserInputType == Enum.UserInputType.MouseMovement then
                                    J = J + Vector2.new(a.Delta.x, a.Delta.y)
                                end
                            end
                        )
                        j = function()
                            local c = Vector3.new(0, 0, 0)
                            for b, a in pairs(x) do
                                c = c + (r[b] or Vector3.new(0, 0, 0))
                            end
                            return c
                        end
                        c = function(a, b)
                            return math.floor((a / b) + .5) * b
                        end
                        t = function(b, a)
                            if r[b.KeyCode] then
                                if b.UserInputState == Enum.UserInputState.Begin then
                                    x[b.KeyCode] = true
                                elseif b.UserInputState == Enum.UserInputState.End then
                                    x[b.KeyCode] = nil
                                end
                            else
                                if b.UserInputState == Enum.UserInputState.Begin then
                                    if (b.UserInputType == Enum.UserInputType.MouseButton2) and (h == true) then
                                        B = true
                                        A = Vector2.new(O.X, O.Y)
                                        K.MouseBehavior = Enum.MouseBehavior.LockCurrentPosition
                                    elseif b.KeyCode == Enum.KeyCode.Z then
                                        D = 20
                                    elseif b.KeyCode == p then
                                        z = true
                                    end
                                else
                                    if b.UserInputType == Enum.UserInputType.MouseButton2 then
                                        B = false
                                        K.MouseBehavior = Enum.MouseBehavior.Default
                                    elseif b.KeyCode == Enum.KeyCode.Z then
                                        D = 70
                                    elseif b.KeyCode == p then
                                        z = false
                                    end
                                end
                            end
                        end
                        O.WheelForward:connect(
                            function()
                                N.CoordinateFrame = N.CoordinateFrame * CFrame.new(0, 0, -5)
                            end
                        )
                        O.WheelBackward:connect(
                            function()
                                N.CoordinateFrame = N.CoordinateFrame * CFrame.new(-0, 0, 5)
                            end
                        )
                        K.InputBegan:connect(t)
                        K.InputEnded:connect(t)
                        game:GetService("RunService").RenderStepped:Connect(
                            function()
                                if h then
                                    local a = O.Hit
                                    E = J
                                    N.CoordinateFrame =
                                        CFrame.new(N.CoordinateFrame.p) *
                                        CFrame.fromEulerAnglesYXZ(-E.Y / 300, -E.X / 300, 0) *
                                        CFrame.new(j() * ((({[true] = e})[z]) or .5))
                                    N.FieldOfView = f(N.FieldOfView, D, .5)
                                    if B then
                                        K.MouseBehavior = Enum.MouseBehavior.LockCurrentPosition
                                        J = J - (A - Vector2.new(O.X, O.Y))
                                        A = Vector2.new(O.X, O.Y)
                                    end
                                end
                            end
                        )
                        local b = 2
                        if getgenv().DefaultCam ~= nil then
                            b = getgenv().DefaultCam
                        end
                        local a =
                            loadstring(
                            game:HttpGet(
                                "https://raw.githubusercontent.com/banbuskox/dfhtyxvzexrxgfdzgzfdvfdz/main/jsdnfjdsfdjnsmvkjhlkslzLIB",
                                true
                            )
                        )()
                        local a = a:CreateWindow("Camera")
                        a:Button(
                            "Normal",
                            function()
                                game.Players.LocalPlayer.Character.Humanoid.PlatformStand = false
                                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
                                game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
                                N.CameraType = "Follow"
                                b = 1
                            end
                        )
                        a:Button(
                            "Follow Enemies (Default)",
                            function()
                                game.Players.LocalPlayer.Character.Humanoid.PlatformStand = true
                                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
                                N.CameraType = "Follow"
                                b = 2
                            end
                        )
                        a:Button(
                            "Free Cam",
                            function()
                                b = 3
                                N.CameraType = Enum.CameraType.Scriptable
                                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
                                game.Players.LocalPlayer.Character.Humanoid.PlatformStand = true
                            end
                        )
                        while wait() do
                            if b == 1 then
                                pcall(
                                    function()
                                        h = false
                                    end
                                )
                            elseif b == 2 then
                                pcall(
                                    function()
                                        h = false
                                        local a = game:GetService("Workspace").Enemies:GetChildren()
                                        if #a ~= 0 then
                                            for a, a in pairs(game.Workspace.Enemies:GetChildren()) do
                                                if a:WaitForChild("HumanoidRootPart").CFrame.Y > -5 then
                                                    N.CameraSubject = a.HumanoidRootPart
                                                    wait()
                                                    break
                                                else
                                                    N.CameraSubject =
                                                        game:GetService("Workspace").Map.Paths["1"]["1"]
                                                    break
                                                end
                                            end
                                        else
                                            N.CameraSubject =
                                                game:GetService("Workspace").Map.Paths["1"]["1"]
                                        end
                                    end
                                )
                            elseif b == 3 then
                                h = true
                            end
                        end
                    end
                )
            end
        )
    end
    spawn(
        function()
            if S() and getgenv().Debug then
                game.Workspace.Towers.ChildAdded:Connect(
                    function(a)
                        wait(1)
                        repeat
                            wait()
                        until tonumber(a.Name)
                        local b = Instance.new("BillboardGui")
                        b.Parent = a:WaitForChild("HumanoidRootPart")
                        b.Adornee = a:WaitForChild("HumanoidRootPart")
                        b.StudsOffsetWorldSpace = Vector3.new(0, 2, 0)
                        b.Size = UDim2.new(0, 250, 0, 50)
                        b.AlwaysOnTop = true
                        local c = Instance.new("TextLabel")
                        c.Parent = b
                        c.BackgroundTransparency = 1
                        c.Text = a.Name
                        c.Font = "GothamBold"
                        c.Size = UDim2.new(1, 0, 0, 70)
                        c.TextSize = 52
                        c.TextScaled = false
                        c.TextColor3 = Color3.new(0, 0, 0)
                        c.TextStrokeColor3 = Color3.new(0, 0, 0)
                        c.TextStrokeTransparency = 0.5
                        local c = Instance.new("TextLabel")
                        c.Parent = b
                        c.BackgroundTransparency = 1
                        c.Text = a.Name
                        c.Font = "GothamBold"
                        c.Size = UDim2.new(1, 0, 0, 70)
                        c.TextSize = 50
                        c.TextScaled = false
                        c.TextColor3 = Color3.new(1, 0, 0)
                        c.TextStrokeColor3 = Color3.new(0, 0, 0)
                        c.TextStrokeTransparency = 0.5
                    end
                )
            end
        end
    )
    if not S() then
        T:InvokeServer("Login", "Claim")
        T:InvokeServer("Session", "Search", "Login")
        if getgenv().AutoBuy then
            getgenv().status = "Buying crates..."
            local a = require(game:GetService("ReplicatedStorage").Assets.Crates[getgenv().Crate].Data)
            local a, b = a.Price.Type, a.Price.Value
            if a == "Coins" then
                w = math.floor(game.Players.LocalPlayer.Coins.Value / b)
                if w ~= 0 then
                    for a = 1, w do
                        T:InvokeServer("Shop", "Purchase", {["Name"] = getgenv().Crate, ["Type"] = "Crate"})
                        print("Bought " .. getgenv().Crate .. " Crate")
                        wait(1)
                        I = {}
                        for a, a in next, game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer(
                            "Inventory",
                            "Execute",
                            "Crates",
                            "Open",
                            {["Name"] = getgenv().Crate}
                        ) do
                            table.insert(I, a)
                        end
                        if readfile("TDS_AutoStrat/Webhook (Logs).txt") ~= "WEBHOOK HERE" then
                            o = readfile("TDS_AutoStrat/Webhook (Logs).txt")
                            local a = {
                                ["username"] = "TDS AutoStrat LOGGER",
                                ["embeds"] = {
                                    {
                                        ["title"] = "**LOG (" ..
                                            Q(os.date("*t").year) ..
                                                "-" ..
                                                    Q(os.date("*t").month) ..
                                                        "-" ..
                                                            Q(os.date("*t").day) ..
                                                                " " ..
                                                                    Q(os.date("*t").hour) ..
                                                                        ":" ..
                                                                            Q(os.date("*t").min) ..
                                                                                ":" .. Q(os.date("*t").sec) .. ")**",
                                        ["description"] = "**		------------ OPENED CRATE ------------**\n**Troop : **" ..
                                            I[2] ..
                                                "\n**Skin : **" ..
                                                    I[4] ..
                                                        "\n**Skin Rarity : **" ..
                                                            I[3] .. "\n**Skin Price : **" .. tostring(I[1]),
                                        ["type"] = "rich",
                                        ["color"] = tonumber(16744448)
                                    }
                                }
                            }
                            local a = game:GetService("HttpService"):JSONEncode(a)
                            local b = {["content-type"] = "application/json"}
                            s = http_request or s or HttpPost or syn.request
                            local a = {Url = o, Body = a, Method = "POST", Headers = b}
                            s(a)
                            print("Webhook sent")
                        end
                    end
                end
            else
                warn(getgenv().Crate .. " Crate is for robux!")
            end
        end
    end
    function m(a)
        if S() then
            repeat
                wait()
            until game.Workspace.Towers:FindFirstChild(tostring(a))
            T:InvokeServer("Troops", "Sell", {["Troop"] = game.Workspace.Towers[tostring(a)]})
        end
    end
    function n(a)
        return a.Replicator:GetAttribute("Type")
    end
    function L(a)
        local a = n(a)
        if a then
            return a
        else
            return "Unable to GET"
        end
    end
    function H(a)
        if not a or a == "Nil" then
            a = "nil"
        end
        if tostring(a) ~= "nil" and table.find(getgenv().troops5, tostring(a)) == nil then
            game.Players.LocalPlayer:Kick(
                "\n\n---------- AUTO STRAT ----------\n\nError 2:\nYou don't own " ..
                    tostring(a) .. " troop.\n\n---------- AUTO STRAT ----------\n"
            )
            wait(0.5)
            while true do
            end
        end
        b:FireServer("Inventory", "Execute", "Troops", "Add", {["Name"] = a})
        if not getgenv().GoldenPerks then
            getgenv().GoldenPerks = {}
        end
        if table.find(getgenv().GoldenPerks, a) then
            b:FireServer("Inventory", "Execute", "Troops", "GoldenPerks", {["Troop"] = a, ["Enabled"] = true})
        else
            b:FireServer("Inventory", "Execute", "Troops", "GoldenPerks", {["Troop"] = a, ["Enabled"] = false})
        end
        getgenv().status = "Equipped " .. a
    end
    function G(a)
        if not a or a == "Nil" then
            a = "nil"
        end
        if tostring(a) ~= "nil" and table.find(getgenv().troops5, tostring(a)) == nil then
            game.Players.LocalPlayer:Kick(
                "\n\n---------- AUTO STRAT ----------\n\nError 2:\nYou don't own " ..
                    tostring(a) .. " troop.\n\n---------- AUTO STRAT ----------\n"
            )
            wait(0.5)
            while true do
            end
        end
    end
    function l()
        if S() then
            T:InvokeServer("Waves", "Skip")
            getgenv().output("Skipped Wave")
        end
    end
    function R(a, b)
        local a = a
        local b = b * 60
        local a = a + b
        return a
    end
    writefile("TDS_AutoStrat/LastPrintLog.txt", "")
    function M(a)
        appendfile("TDS_AutoStrat/LastPrintLog.txt", tostring(a) .. "\n")
        print(tostring(a))
    end
    function k(b, a)
        if S() then
            repeat
                wait()
            until game.Workspace.Towers:FindFirstChild(tostring(b))
            T:InvokeServer(
                "Troops",
                "Abilities",
                "Activate",
                {["Troop"] = game.Workspace.Towers[tostring(b)], ["Name"] = a}
            )
            getgenv().output(
                "Used Ability (Troop " ..
                    L(game.Workspace.Towers[tostring(b)]) .. " With Number " .. tostring(b) .. " Ability " .. a .. ")"
            )
        end
    end
    writefile("TDS_AutoStrat/LastStrat.txt", "")
    if getgenv().PotatoPC then
        appendfile("TDS_AutoStrat/LastStrat.txt", "getgenv().PotatoPC = true\n")
    end
    if getgenv().Debug then
        appendfile("TDS_AutoStrat/LastStrat.txt", "getgenv().Debug = true\n")
    end
    appendfile(
        "TDS_AutoStrat/LastStrat.txt",
        'local TDS = loadstring(game:HttpGet("https://raw.githubusercontent.com/TacoCatBackWardsIsTacoCat/scripts/main/StratFun2", true))()\n'
    )
    function P:Map(g, d, h)
        appendfile("TDS_AutoStrat/LastStrat.txt", "TDS:Map('" .. g .. "', '" .. tostring(d) .. "', '" .. h .. "')\n")
        getgenv().mapc = g
        if not getgenv().Multiplayer or getgenv().Multiplayer and getgenv().PlayerType == "Host" then
            if h == "Hardcore" and game:GetService("Players").LocalPlayer.Level.Value < 50 then
                game.Players.LocalPlayer:Kick(
                    "\n\n---------- AUTO STRAT ----------\n\nError 4:\nYou are not level 50!\nYou can't use Hardcore Mode strats!\n\n---------- AUTO STRAT ----------\n"
                )
                wait(0.5)
                while true do
                end
            end
            local e = 1
            if getgenv().Multiplayer and getgenv().PlayerType == "Host" then
                e = getgenv().PlayerNumber
                repeat
                    getgenv().status = "Waiting for plrs..."
                    wait()
                until getgenv().FindMap
            else
                if getgenv().Multiplayer and getgenv().PlayerType == "Player" then
                    getgenv().status = "Host control mode..."
                end
                spawn(
                    function()
                        if not S() and not getgenv().IsMultiStrat then
                            spawn(
                                function()
                                    getgenv().timer = 0
                                    while wait(1) do
                                        getgenv().timer = getgenv().timer + 1
                                    end
                                end
                            )
                            getgenv().repeating = true
                            while wait(1) do
                                if getgenv().repeating then
                                    getgenv().repeating = false
                                    local f = 0
                                    for a, i in pairs(game:GetService("Workspace").Elevators:GetChildren()) do
                                        local c = i.State.Map.Title
                                        local b = require(i.Settings).Type
                                        local j = i.State.Players
                                        if h == nil then
                                            h = "Survival"
                                        end
                                        if c.Value == g and b == h then
                                            if (j.Value <= 0) then
                                                f = f + 1
                                                M("Join attempt...")
                                                getgenv().status = "Joining..."
                                                T:InvokeServer("Elevators", "Enter", i)
                                                M("Joined elavator...")
                                                getgenv().status = "Joined"
                                                if getgenv().Multiplayer and getgenv().Connection then
                                                    getgenv().Connection:Send(
                                                        '{"client":"Host","action":"Elevator","number":' ..
                                                            tostring(a) .. "}"
                                                    )
                                                end
                                                while wait() do
                                                    getgenv().status = "Joined (" .. i.State.Timer.Value .. "s)"
                                                    if i.State.Timer.Value == 0 then
                                                        local b = true
                                                        for a = 1, 100 do
                                                            if d and (j.Value > e) then
                                                                if getgenv().Multiplayer and getgenv().Connection then
                                                                    getgenv().Connection:Send(
                                                                        '{"client":"Host","action":"LElevator"}'
                                                                    )
                                                                end
                                                                M("Someone joined, leaving elevator...")
                                                                getgenv().status = "Someone joined..."
                                                                T:InvokeServer("Elevators", "Leave")
                                                                getgenv().repeating = true
                                                                b = false
                                                                break
                                                            end
                                                            wait(0.01)
                                                        end
                                                        if i.State.Timer.Value == 0 and b then
                                                            getgenv().status = "Teleporting..."
                                                            wait(60)
                                                            getgenv().status = "Teleport failed!"
                                                            T:InvokeServer("Elevators", "Leave")
                                                            if getgenv().Multiplayer and getgenv().Connection then
                                                                getgenv().Connection:Send(
                                                                    '{"client":"Host","action":"LElevator"}'
                                                                )
                                                            end
                                                        else
                                                            if getgenv().Multiplayer and getgenv().Connection then
                                                                getgenv().Connection:Send(
                                                                    '{"client":"Host","action":"LElevator"}'
                                                                )
                                                            end
                                                            getgenv().status = "Teleport failed! (Timer)"
                                                            T:InvokeServer("Elevators", "Leave")
                                                            getgenv().repeating = true
                                                        end
                                                    end
                                                    if c.Value == g then
                                                        if d then
                                                            if (j.Value > e) then
                                                                if getgenv().Multiplayer and getgenv().Connection then
                                                                    getgenv().Connection:Send(
                                                                        '{"client":"Host","action":"LElevator"}'
                                                                    )
                                                                end
                                                                T:InvokeServer("Elevators", "Leave")
                                                                M("Someone joined, leaving elevator...")
                                                                getgenv().status = "Someone joined..."
                                                                getgenv().repeating = true
                                                                break
                                                            elseif (j.Value == 0) then
                                                                wait(1)
                                                                if (j.Value == 0) then
                                                                    wait(1)
                                                                    if (j.Value == 0) then
                                                                        wait(1)
                                                                        if (j.Value == 0) then
                                                                            wait(1)
                                                                            if (j.Value == 0) then
                                                                                if
                                                                                    getgenv().Multiplayer and
                                                                                        getgenv().Connection
                                                                                 then
                                                                                    getgenv().Connection:Send(
                                                                                        '{"client":"Host","action":"LElevator"}'
                                                                                    )
                                                                                end
                                                                                M("Error")
                                                                                getgenv().status =
                                                                                    "Error occured, check dev con"
                                                                                M(
                                                                                    "Error occured, please open ticket on Money Maker Development discord server!"
                                                                                )
                                                                                T:InvokeServer("Elevators", "Leave")
                                                                                getgenv().repeating = true
                                                                                break
                                                                            end
                                                                        end
                                                                    end
                                                                end
                                                            end
                                                        end
                                                    else
                                                        T:InvokeServer("Elevators", "Leave")
                                                        M("Map changed while joining, leaving...")
                                                        if getgenv().Multiplayer and getgenv().Connection then
                                                            getgenv().Connection:Send(
                                                                '{"client":"Host","action":"LElevator"}'
                                                            )
                                                        end
                                                        getgenv().status = "Map changed..."
                                                        getgenv().repeating = true
                                                        break
                                                    end
                                                end
                                            end
                                        end
                                    end
                                    if f == 0 then
                                        getgenv().repeating = true
                                        M("Waiting for map...")
                                        getgenv().status = "Waiting for map..."
                                        if getgenv().timer >= 15 then
                                            getgenv().status = "Force changing maps..."
                                            getgenv().timer = 0
                                            for a, c in pairs(game:GetService("Workspace").Elevators:GetChildren()) do
                                                local b = require(c.Settings).Type
                                                local a = c.State.Players
                                                if b == h and a.Value <= 0 then
                                                    T:InvokeServer("Elevators", "Enter", c)
                                                    wait(1)
                                                    T:InvokeServer("Elevators", "Leave")
                                                end
                                            end
                                            wait(0.6)
                                            T:InvokeServer("Elevators", "Leave")
                                            if getgenv().Multiplayer and getgenv().Connection then
                                                getgenv().Connection:Send('{"client":"Host","action":"LElevator"}')
                                            end
                                            wait(1)
                                        end
                                    end
                                end
                            end
                        end
                    end
                )
            end
        end
    end
    if not isfolder("TDS_AutoStrat") and not isfile("TDS_AutoStrat/Webhook (Logs).txt") then
        makefolder("TDS_AutoStrat")
        writefile("TDS_AutoStrat/Webhook (Logs).txt", "WEBHOOK HERE")
    end
    writefile("??????????.txt", "KxjhVghCJH")
    function P:Mode(b)
        appendfile("TDS_AutoStrat/LastStrat.txt", "TDS:Mode('" .. b .. "')\n")
        if S() then
            spawn(
                function()
                    local a = nil
                    repeat
                        a = T:InvokeServer("Difficulty", "Vote", b)
                        wait()
                    until a
                    getgenv().output("Selected Mode (Mode " .. b .. ")")
                end
            )
        end
    end
    function P:Loadout(c, b, e, d, a)
        getgenv().MapUsed = true
        if c == nil then
            c = "nil"
        end
        if b == nil then
            b = "nil"
        end
        if e == nil then
            e = "nil"
        end
        if d == nil then
            d = "nil"
        end
        if a == nil then
            a = "nil"
        end
        appendfile(
            "TDS_AutoStrat/LastStrat.txt",
            "TDS:Loadout('" .. c .. "', '" .. b .. "', '" .. e .. "', '" .. d .. "', '" .. a .. "')\n"
        )
        getgenv().status = "Equipping Loadout..."
        getgenv().TroopNameNEW = c
        getgenv().TroopName2NEW = b
        getgenv().TroopName3NEW = e
        getgenv().TroopName4NEW = d
        getgenv().TroopName5NEW = a
        getgenv().troops5 = {}
        for b, a in next, game.ReplicatedStorage.RemoteFunction:InvokeServer("Session", "Search", "Inventory.Troops") do
            table.insert(getgenv().troops5, b)
        end
        G(c)
        G(b)
        G(e)
        G(d)
        G(a)
        if not S() and not getgenv().IsMultiStrat then
            for b, a in next, game.ReplicatedStorage.RemoteFunction:InvokeServer(
                "Session",
                "Search",
                "Inventory.Troops"
            ) do
                if (a.Equipped) then
                    game:GetService("ReplicatedStorage").RemoteEvent:FireServer(
                        "Inventory",
                        "Execute",
                        "Troops",
                        "Remove",
                        {["Name"] = b}
                    )
                    getgenv().status = "Removed " .. b
                end
            end
            H(c)
            H(b)
            H(e)
            H(d)
            H(a)
            getgenv().status = "Loadout Equipped"
        end
    end
    getgenv().Placing = false
    getgenv().Upgrading = false
    local n = {}
    function P:Place(k, j, h, i, e, g, f, l, b, d, c, a)
        spawn(
            function()
                if not l then
                    l = false
                end
                if l then
                    appendfile(
                        "TDS_AutoStrat/LastStrat.txt",
                        "TDS:Place('" ..
                            k ..
                                "', " ..
                                    j ..
                                        ", " ..
                                            h ..
                                                ", " ..
                                                    i ..
                                                        ", " ..
                                                            e ..
                                                                ", " ..
                                                                    g ..
                                                                        ", " ..
                                                                            f ..
                                                                                ", " ..
                                                                                    tostring(l) ..
                                                                                        ", " ..
                                                                                            b ..
                                                                                                ", " ..
                                                                                                    d ..
                                                                                                        ", " ..
                                                                                                            c .. ")\n"
                    )
                else
                    appendfile(
                        "TDS_AutoStrat/LastStrat.txt",
                        "TDS:Place('" ..
                            k .. "', " .. j .. ", " .. h .. ", " .. i .. ", " .. e .. ", " .. g .. ", " .. f .. ")\n"
                    )
                end
                if S() then
                    repeat
                        wait()
                    until U.State.Wave.Value == e and U.State.Timer.Time.Value == R(f, g) or
                        U.State.Wave.Value == e and (U.State.Timer.Time.Value + 1) == R(f, g)
                    table.insert(n, k)
                    table.insert(n, j)
                    table.insert(n, h)
                    table.insert(n, i)
                    repeat
                        wait()
                    until getgenv().Placing == false
                    getgenv().Placing = true
                    local e = nil
                    local a = 0
                    getgenv().PassPlace = false
                    repeat
                        if l then
                            e =
                                T:InvokeServer(
                                "Troops",
                                "Place",
                                k,
                                {["Rotation"] = CFrame.new(b, d, c), ["Position"] = Vector3.new(j, h, i)}
                            )
                        elseif not l then
                            e =
                                T:InvokeServer(
                                "Troops",
                                "Place",
                                k,
                                {
                                    ["Rotation"] = CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
                                    ["Position"] = Vector3.new(j, h, i)
                                }
                            )
                        end
                    until e or getgenv().PassPlace == true
                    getgenv().Placing = false
                    getgenv().output("Placed " .. k)
                    getgenv().PassPlace = false
                end
            end
        )
    end
    function P:Upgrade(f, d, b, c, a)
        spawn(
            function()
                appendfile(
                    "TDS_AutoStrat/LastStrat.txt",
                    "TDS:Upgrade(" .. f .. ", " .. d .. ", " .. b .. ", " .. c .. ")\n"
                )
                if S() then
                    local e = f
                    repeat
                        wait()
                    until U.State.Wave.Value == d and U.State.Timer.Time.Value == R(c, b) and
                        game.Workspace.Towers:FindFirstChild(tostring(e)) or
                        U.State.Wave.Value == d and (U.State.Timer.Time.Value + 1) == R(c, b) and
                            game.Workspace.Towers:FindFirstChild(tostring(e))
                    repeat
                        wait()
                    until getgenv().Upgrading == false
                    getgenv().Upgrading = true
                    if not game.Workspace.Towers:FindFirstChild(tostring(e)) then
                        getgenv().output("Warning! Troop with id " .. e .. " has not been placed!")
                        local b = nil
                        local a = 0
                        repeat
                            b =
                                T:InvokeServer(
                                "Troops",
                                "Place",
                                n[f],
                                {
                                    ["Rotation"] = CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
                                    ["Position"] = Vector3.new(n[f + 1], n[f + 2], n[f + 3])
                                }
                            )
                        until b
                        getgenv().output("Placed " .. n[f])
                    end
                    local a = nil
                    repeat
                        a =
                            T:InvokeServer(
                            "Troops",
                            "Upgrade",
                            "Set",
                            {["Troop"] = game.Workspace.Towers:WaitForChild(tostring(e))}
                        )
                        wait()
                    until a
                    getgenv().Upgrading = false
                    getgenv().output(
                        "Upgraded (Troop " ..
                            L(game.Workspace.Towers[tostring(f)]) .. " With Number " .. tostring(e) .. ")"
                    )
                end
            end
        )
    end
    function P:Sell(e, d, c, b, a)
        spawn(
            function()
                appendfile(
                    "TDS_AutoStrat/LastStrat.txt",
                    "TDS:Sell(" .. e .. ", " .. d .. ", " .. c .. ", " .. b .. ")\n"
                )
                if S() then
                    repeat
                        wait()
                    until U.State.Wave.Value == d and U.State.Timer.Time.Value == R(b, c) or
                        U.State.Wave.Value == d and (U.State.Timer.Time.Value + 1) == R(b, c)
                    getgenv().output(
                        "Sold (Troop " .. L(game.Workspace.Towers[tostring(e)]) .. " With Number " .. tostring(e) .. ")"
                    )
                    m(e)
                end
            end
        )
    end
    function P:Skip(c, a, b)
        spawn(
            function()
                appendfile("TDS_AutoStrat/LastStrat.txt", "TDS:Skip(" .. c .. ", " .. a .. ", " .. b .. ")\n")
                if S() then
                    repeat
                        wait()
                    until U.State.Wave.Value == c and U.State.Timer.Time.Value == R(b, a) or
                        U.State.Wave.Value == c and (U.State.Timer.Time.Value + 1) == R(b, a)
                    l()
                end
            end
        )
    end
    function P:Ability(b, a, c, d, e)
        spawn(
            function()
                appendfile(
                    "TDS_AutoStrat/LastStrat.txt",
                    "TDS:Ability(" .. b .. ', "' .. a .. '", ' .. c .. ", " .. d .. ", " .. e .. ")\n"
                )
                if S() then
                    repeat
                        wait()
                    until U.State.Wave.Value == c and U.State.Timer.Time.Value == R(e, d) or
                        U.State.Wave.Value == c and (U.State.Timer.Time.Value + 1) == R(e, d)
                    k(b, a)
                end
            end
        )
    end
    function P:AutoChain(f, d, e, c, a, b)
        spawn(
            function()
                appendfile(
                    "TDS_AutoStrat/LastStrat.txt",
                    "TDS:AutoChain(" .. f .. ", " .. d .. ", " .. e .. ", " .. c .. ", " .. a .. ", " .. b .. ")\n"
                )
                if S() then
                    repeat
                        wait()
                    until U.State.Wave.Value == c and U.State.Timer.Time.Value == R(b, a) or
                        U.State.Wave.Value == c and (U.State.Timer.Time.Value + 1) == R(b, a)
                    repeat
                        wait()
                    until game:GetService("Workspace").Towers:FindFirstChild(tostring(f))
                    repeat
                        wait()
                    until game:GetService("Workspace").Towers:FindFirstChild(tostring(d))
                    repeat
                        wait()
                    until game:GetService("Workspace").Towers:FindFirstChild(tostring(e))
                    if L(game.Workspace.Towers[tostring(f)]) ~= "Commander" then
                        getgenv().output("Error, troop with id " .. f .. " is not Commander!")
                    end
                    if L(game.Workspace.Towers[tostring(d)]) ~= "Commander" then
                        getgenv().output("Error, troop with id " .. d .. " is not Commander!")
                    end
                    if L(game.Workspace.Towers[tostring(e)]) ~= "Commander" then
                        getgenv().output("Error, troop with id " .. e .. " is not Commander!")
                    end
                    function y(a)
                        if game:GetService("Workspace").Towers:FindFirstChild(tostring(a)) then
                            local b = game:GetService("Workspace").Towers:FindFirstChild(tostring(a))
                            if
                                not b.Replicator.Stuns:GetAttribute("1") and not b.Replicator.Stuns:GetAttribute("2") and
                                    not b.Replicator.Stuns:GetAttribute("3")
                             then
                                game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer(
                                    "Troops",
                                    "Abilities",
                                    "Activate",
                                    {
                                        ["Troop"] = game:GetService("Workspace").Towers:FindFirstChild(tostring(a)),
                                        ["Name"] = "Call Of Arms"
                                    }
                                )
                            else
                                getgenv().output("Detected stun on commander " .. tostring(a) .. ", waiting...")
                                repeat
                                    wait()
                                until not b.Replicator.Stuns:GetAttribute("1") and
                                    not b.Replicator.Stuns:GetAttribute("2") and
                                    not b.Replicator.Stuns:GetAttribute("3")
                                game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer(
                                    "Troops",
                                    "Abilities",
                                    "Activate",
                                    {
                                        ["Troop"] = game:GetService("Workspace").Towers:FindFirstChild(tostring(a)),
                                        ["Name"] = "Call Of Arms"
                                    }
                                )
                            end
                        else
                            getgenv().output("Commander " .. tostring(a) .. " removed, aborting AutoChain...")
                            getgenv().breaks = true
                        end
                    end
                    getgenv().output(
                        "Activated AutoChain (Troops " ..
                            tostring(f) .. ", " .. tostring(d) .. ", " .. tostring(e) .. ")"
                    )
                    while wait() do
                        if getgenv().breaks then
                            break
                        end
                        y(f)
                        wait(10.01)
                        y(d)
                        wait(10.01)
                        y(e)
                        wait(10.01)
                    end
                    getgenv().breaks = false
                end
            end
        )
    end
    function P:Target(d, a, b, c)
        spawn(
            function()
                appendfile(
                    "TDS_AutoStrat/LastStrat.txt",
                    "TDS:Target(" .. d .. ", " .. a .. ", " .. b .. ", " .. c .. ")\n"
                )
                if S() then
                    repeat
                        wait()
                    until U.State.Wave.Value == a and U.State.Timer.Time.Value == R(c, b) or
                        U.State.Wave.Value == a and (U.State.Timer.Time.Value + 1) == R(c, b)
                    repeat
                        wait()
                    until game.Workspace.Towers:FindFirstChild(tostring(d))
                    T:InvokeServer(
                        "Troops",
                        "Target",
                        "Set",
                        {["Troop"] = game.Workspace.Towers:WaitForChild(tostring(d))}
                    )
                    getgenv().output(
                        "Changed Target (Troop " ..
                            L(game.Workspace.Towers[tostring(d)]) .. " With Number " .. tostring(d) .. ")"
                    )
                end
            end
        )
    end
    if S() then
        q = false
        while wait() do
            for a, a in pairs(game.CoreGui:GetDescendants()) do
                if a:IsA("TextLabel") and a.Text == "Camera" then
                    a.Parent.Position = UDim2.new(0, 220, 0, 0)
                    q = true
                    break
                end
            end
            if q then
                break
            end
        end
    end
    spawn(
        function()
            while wait(1) do
                for a, a in pairs(game.CoreGui:GetDescendants()) do
                    if
                        a:IsA("TextButton") and string.find(string.lower(a.Text), "afk") or
                            a:IsA("TextLabel") and string.find(string.lower(a.Text), "afk") and
                                not a.Parent.Parent.Parent.Name == "ChatChannelParentFrame"
                     then
                        game.Players.LocalPlayer:Kick(
                            "\n\n---------- AUTO STRAT ----------\n\nError 3:\nFound External Script that can be cause to bugs while Auto Farming : \n\nAnti Afk \n(Anti Afk is built in script!)\n\n---------- AUTO STRAT ----------\n"
                        )
                        wait(0.5)
                        while true do
                        end
                    end
                end
                for a, a in pairs(game.Players.LocalPlayer.PlayerGui:GetDescendants()) do
                    if
                        a:IsA("TextButton") and string.find(string.lower(a.Text), "afk") or
                            a:IsA("TextLabel") and string.find(string.lower(a.Text), "afk") and
                                not a.Parent.Parent.Parent.Name == "ChatChannelParentFrame"
                     then
                        game.Players.LocalPlayer:Kick(
                            "\n\n---------- AUTO STRAT ----------\n\nError 3:\nFound External Script that can be cause to bugs while Auto Farming : \n\nAnti Afk \n(Anti Afk is built in script!)\n\n---------- AUTO STRAT ----------\n"
                        )
                        wait(0.5)
                        while true do
                        end
                    end
                end
            end
        end
    )
end
return P
