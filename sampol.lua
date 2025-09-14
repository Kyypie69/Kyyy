-- =============================================================================
--  MUSCLE LEGENDS – MEGA HUB  (AutoKillCode + sampol  in  ONE  library)
-- =============================================================================
-- 1.  Load the Elerium v2 UI library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/memejames/elerium-v2-ui-library/main/Library", true))()

-- =============================================================================
-- 2.  Fast aliases
-- =============================================================================
local RS  = game:GetService("ReplicatedStorage")
local WS  = game:GetService("Workspace")
local LG  = game:GetService("Lighting")
local UIS = game:GetService("UserInputService")
local VU  = game:GetService("VirtualUser")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- =============================================================================
-- 3.  Create ONE main window
-- =============================================================================
local Window = Library:AddWindow("KYY  MEGA  HUB", {
    main_color = Color3.fromRGB(255,0,0),
    min_size   = Vector2.new(600, 400),
    can_resize = true
})

-- =============================================================================
-- 4.  Helper  functions  (used everywhere)
-- =============================================================================
local function notify(title, text, dur)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = title, Text = text, Duration = dur or 3
    })
end

local function getTool(name)   -- equip if in backpack
    local tool = LocalPlayer.Backpack:FindFirstChild(name)
    if tool and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid:EquipTool(tool)
    end
    return tool
end

local function fireRep()
    RS.muscleEvent:FireServer("rep")
end

local function punchBoth()
    RS.muscleEvent:FireServer("punch","rightHand")
    RS.muscleEvent:FireServer("punch","leftHand")
end

-- =============================================================================
-- 5.  TAB  –  Main  (Anti-AFK + Auto Brawls + Anti-KB)
-- =============================================================================
local mainTab = Window:AddTab("Main")

-- Anti-AFK
local antiAFKEnabled = true
local function setupAntiAFK()
    LocalPlayer.Idled:Connect(function()
        VU:CaptureController()
        VU:ClickButton2(Vector2.new())
    end)
    notify("Anti-AFK","Enabled")
end
setupAntiAFK()

mainTab:AddSwitch("Anti-AFK System", function(bool)
    antiAFKEnabled = bool
    if bool then setupAntiAFK() end
end, true)

-- Auto Brawls folder
local brawlF = mainTab:AddFolder("Auto Brawls")
brawlF:AddSwitch("Auto Win Brawl", function(s)
    getgenv().autoWinBrawl = s
    while getgenv().autoWinBrawl do
        if LocalPlayer.PlayerGui.gameGui.brawlJoinLabel.Visible then
            RS.rEvents.brawlEvent:FireServer("joinBrawl")
            LocalPlayer.PlayerGui.gameGui.brawlJoinLabel.Visible = false
        end
        task.wait(.5)
    end
end)

-- Anti KB
local akF = mainTab:AddFolder("Anti Knockback")
akF:AddSwitch("Anti Knockback", function(v)
    local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end
    if v then
        Instance.new("BodyVelocity", root).Velocity = Vector3.zero
    else
        local bv = root:FindFirstChild("BodyVelocity")
        if bv then bv:Destroy() end
    end
end)

-- =============================================================================
-- 6.  TAB  –  Farm Rock  (merged rocks + gyms + tools)
-- =============================================================================
local farmTab = Window:AddTab("Farm Rock")

-- 6a.  Auto Rock  (from sampol fast-glitch)
local rockFolder = farmTab:AddFolder("Auto Rock")
local rocks = {
    {n="Tiny Island Rock",  d=0},
    {n="Starter Island Rock",d=100},
    {n="Legend Beach Rock",  d=5000},
    {n="Frost Gym Rock",     d=150000},
    {n="Mythical Gym Rock",  d=400000},
    {n="Eternal Gym Rock",   d=750000},
    {n="Legend Gym Rock",    d=1e6},
    {n="Muscle King Gym Rock",d=5e6},
    {n="Ancient Jungle Rock",d=10e6}
}
for _,r in ipairs(rocks) do
    rockFolder:AddSwitch(r.n, function(s)
        getgenv()[r.n] = s
        while getgenv()[r.n] do
            if LocalPlayer.Durability.Value >= r.d then
                local rock = WS.machinesFolder:FindFirstChild(r.n)
                if rock then
                    firetouchinterest(rock.Rock, LocalPlayer.Character.RightHand,0)
                    firetouchinterest(rock.Rock, LocalPlayer.Character.RightHand,1)
                    firetouchinterest(rock.Rock, LocalPlayer.Character.LeftHand,0)
                    firetouchinterest(rock.Rock, LocalPlayer.Character.LeftHand,1)
                    getTool("Punch"); punchBoth()
                end
            end
            task.wait(.05)
        end
    end)
end

-- 6b.  Auto Gym  (from sampol)
local gymFolder = farmTab:AddFolder("Auto Gym")
local gyms = {"Jungle Bench","Jungle Bar Lift","Jungle Boulder","Jungle Squat"}
for _,g in ipairs(gyms) do
    gymFolder:AddSwitch("Auto "..g, function(s)
        getgenv()[g] = s
        while getgenv()[g] do
            local m = WS.machinesFolder:FindFirstChild(g)
            if m and m:FindFirstChild("interactSeat") then
                LocalPlayer.Character.HumanoidRootPart.CFrame = m.interactSeat.CFrame + Vector3.new(0,3,0)
                RS.rEvents.machineInteractRemote:InvokeServer("useMachine",m)
                fireRep()
            end
            task.wait(.1)
        end
    end)
end

-- 6c.  Auto Equip Tools  (Weight / Pushups / Situps / Handstands)
local toolFolder = farmTab:AddFolder("Auto Equip Tools")
local tools = {"Weight","Pushups","Situps","Handstands"}
for _,t in ipairs(tools) do
    toolFolder:AddSwitch("Auto "..t, function(s)
        getgenv()[t] = s
        while getgenv()[t] do
            getTool(t); fireRep()
            task.wait(.5)
        end
    end)
end

-- =============================================================================
-- 7.  TAB  –  Rebirths
-- =============================================================================
local rebTab = Window:AddTab("Rebirths")
local rebF = rebTab:AddFolder("Rebirth")
local target = 0
rebF:AddTextBox("Target Rebirth", function(txt)
    target = tonumber(txt) or 0
end)
rebF:AddSwitch("Auto Rebirth Until Target", function(s)
    getgenv().rebTar = s
    while getgenv().rebTar do
        if LocalPlayer.leaderstats.Rebirths.Value >= target then getgenv().rebTar=false notify("Target reached!") break end
        RS.rEvents.rebirthRemote:InvokeServer("rebirthRequest")
        task.wait(.1)
    end
end)
rebF:AddSwitch("Auto Rebirth (Infinite)", function(s)
    getgenv().infReb = s
    while getgenv().infReb do
        RS.rEvents.rebirthRemote:InvokeServer("rebirthRequest")
        task wait(.1)
    end
end)

-- =============================================================================
-- 8.  TAB  –  Killer  (kill everyone / single / aura / whitelist)
-- =============================================================================
local killTab = Window:AddTab("Killer")
getgenv().whitelist = getgenv().whitelist or {}

local function kill(plr)
    if not plr or not plr.Character then return end
    LocalPlayer.Character.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame
    punchBoth()
end

killTab:AddSwitch("Auto Kill Everyone (No Whitelist)", function(s)
    getgenv().killAll = s
    while getgenv().killAll do
        for _,p in ipairs(Players:GetPlayers()) do
            if p~=LocalPlayer and not table.find(getgenv().whitelist,p.Name) then
                kill(p)
            end
        end
        task wait(.1)
    end
end)

killTab:AddTextBox("Whitelist Player", function(n)
    if n~="" and not table.find(getgenv().whitelist,n) then table.insert(getgenv().whitelist,n) end
end)
killTab:AddButton("Clear Whitelist", function() getgenv().whitelist={} end)

-- Single target
killTab:AddTextBox("Kill Single Player", function(n)
    local t = Players:FindFirstChild(n)
    if t then
        spawn(function()
            while t and t.Character do kill(t); task wait(.1) end
        end)
    end
end)

-- =============================================================================
-- 9.  TAB  –  Misc  (walkspeed / jumppower / noclip / etc.)
-- =============================================================================
local miscTab = Window:AddTab("Misc")
local miscF = miscTab:AddFolder("Character")
miscF:AddTextBox("Walkspeed", function(v)
    getgenv().ws = tonumber(v) or 16
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = getgenv().ws
    end
end)
miscF:AddTextBox("JumpPower", function(v)
    getgenv().jp = tonumber(v) or 50
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.JumpPower = getgenv().jp
    end
end)
miscF:AddSwitch("Noclip", function(s)
    getgenv().noclip = s
    if s then
        getgenv().nc = game:GetService("RunService").Stepped:Connect(function()
            if LocalPlayer.Character then
                for _,p in ipairs(LocalPlayer.Character:GetDescendants()) do
                    if p:IsA("BasePart") then p.CanCollide = false end
                end
            end
        end)
    else
        if getgenv().nc then getgenv().nc:Disconnect() end
    end
end)
miscF:AddButton("Anti-AFK", function()
    VU:CaptureController()
    LocalPlayer.Idled:Connect(function() VU:ClickButton2(Vector2.new()) end)
    notify("Anti-AFK","Enabled")
end)

-- =============================================================================
-- 10.  TAB  –  Stats  (simple real-time labels)
-- =============================================================================
local statsTab = Window:AddTab("Stats")
local statsF = statsTab:AddFolder("Real Time")
local ls = LocalPlayer:WaitForChild("leaderstats")
local labels = {
    kills  = statsF:AddLabel("Kills: 0"),
    str    = statsF:AddLabel("Strength: 0"),
    reb    = statsF:AddLabel("Rebirths: 0"),
    dur    = statsF:AddLabel("Durability: 0")
}
spawn(function()
    while true do
        labels.kills.Text = "Kills: "..(ls.Kills.Value or 0)
        labels.str.Text   = "Strength: "..math.floor(ls.Strength.Value or 0)
        labels.reb.Text   = "Rebirths: "..(ls.Rebirths.Value or 0)
        labels.dur.Text   = "Durability: "..(LocalPlayer.Durability.Value or 0)
        task wait(1)
    end
end)

-- =============================================================================
-- 11.  TAB  –  Credits
-- =============================================================================
local credTab = Window:AddTab("Credits")
credTab:AddLabel("KYY PIE – Combined Mega Hub")
credTab:AddLabel("Discord:  markyy11")
credTab:AddButton("Copy Discord Invite", function()
    setclipboard("https://discord.gg/CCUdkJWP")
    notify("Copied","Discord invite link saved to clipboard")
end)

-- =============================================================================
-- 12.  Auto-equip Punch on spawn  (quality-of-life)
-- =============================================================================
LocalPlayer.CharacterAdded:Connect(function(char)
    char:WaitForChild("Humanoid")
    task.wait(.5)
    getTool("Punch")
    if getgenv().ws then char.Humanoid.WalkSpeed = getgenv().ws end
    if getgenv().jp then char.Humanoid.JumpPower = getgenv().jp end
end)

notify("KYY MEGA HUB","All features loaded – enjoy!")
