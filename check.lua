--[[  FLUENT-RENEWED BOILERPLATE  ]]
local Library      = loadstring(game:HttpGetAsync("https://github.com/ActualMasterOogway/Fluent-Renewed/releases/latest/download/Fluent.luau"))()
local SaveManager  = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/ActualMasterOogway/Fluent-Renewed/master/Addons/SaveManager.luau"))()
local InterfaceManager = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/ActualMasterOogway/Fluent-Renewed/master/Addons/InterfaceManager.luau"))()

local Window = Library:CreateWindow({
    Title    = "Doca V1 | Paid Version",
    Size     = UDim2.new(0, 550, 0, 650),
    MinSize  = UDim2.new(0, 500, 0, 600),
    MaxSize  = UDim2.new(0, 1200, 0, 1000),
    MainColor = Color3.fromRGB(255,0,0),
    Theme    = "Dark",
    Center   = true,
    Resizable = true
})

SaveManager:SetLibrary(Library)
InterfaceManager:SetLibrary(Library)
SaveManager:BuildConfigSection(Window)
InterfaceManager:BuildInterfaceSection(Window)

--[[  HELPERS  ]]
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")

--[[  TABS  ]]
local Tabs = {
    Main   = Window:AddTab({ Title = "Main",   Icon = "home" }),
    Kill   = Window:AddTab({ Title = "Killing", Icon = "sword" }),
    Stats  = Window:AddTab({ Title = "Stats",  Icon = "chart" }),
    Farm   = Window:AddTab({ Title = "Farm++", Icon = "wrench" }),
    Serv   = Window:AddTab({ Title = "Server", Icon = "server" }),
    Eggs   = Window:AddTab({ Title = "Eggs",   Icon = "egg" }),
    Ply    = Window:AddTab({ Title = "Players",Icon = "user" }),
    Cred   = Window:AddTab({ Title = "Credits",Icon = "info" }),
    Paid   = Window:AddTab({ Title = "Paid",   Icon = "star" }),
    Kill2  = Window:AddTab({ Title = "Killing V2", Icon = "shield-sword" })
}

--[[  MAIN  ]]
do
    local loc = Tabs.Main:AddSection({ Title = "Local Players", Side = "Left" })
    loc:AddToggle("Auto Eat Protein Egg 30m", false, function(v)
        getgenv().autoEatProteinEggActive = v
        while v and LocalPlayer.Character do
            local egg = LocalPlayer.Backpack:FindFirstChild("Protein Egg") or LocalPlayer.Character:FindFirstChild("Protein Egg")
            if egg then egg.Parent = LocalPlayer.Character; ReplicatedStorage.muscleEvent:FireServer("rep") end
            task.wait(1800)
        end
    end)
    loc:AddToggle("Auto Eat Protein Egg 1h", false, function(v)
        getgenv().autoEatProteinEggHourly = v
        while v and LocalPlayer.Character do
            local egg = LocalPlayer.Backpack:FindFirstChild("Protein Egg") or LocalPlayer.Character:FindFirstChild("Protein Egg")
            if egg then egg.Parent = LocalPlayer.Character; ReplicatedStorage.muscleEvent:FireServer("rep") end
            task.wait(3600)
        end
    end)

    local misc = Tabs.Main:AddSection({ Title = "Misc", Side = "Right" })
    misc:AddToggle("Auto Farm (Equip Any tool)", false, function(v)
        getgenv().autoFarm = v
        while v and LocalPlayer.Character do
            for _,t in ipairs(LocalPlayer.Backpack:GetChildren()) do
                if t:IsA("Tool") then t.Parent = LocalPlayer.Character; ReplicatedStorage.muscleEvent:FireServer("rep"); task.wait(.1) end
            end; task.wait()
        end
    end)
    misc:AddLabel("---Script Hub---")
    misc:AddButton("Permanent ShiftLock", function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/MiniNoobie/ShiftLockx/main/Shiftlock-MiniNoobie"))()
    end)
    misc:AddLabel("---Time---")
    misc:AddButton("Night",   function() Lighting.ClockTime = 0 end)
    misc:AddButton("Morning", function() Lighting.ClockTime = 6 end)
    misc:AddButton("Day",     function() Lighting.ClockTime = 12 end)
    misc:AddLabel("----Farming----")

    local br = Tabs.Main:AddSection({ Title = "Auto Brawl", Side = "Left" })
    br:AddToggle("Auto Win Brawl", false, function(v)
        getgenv().autoWinBrawl = v
        while v and LocalPlayer.Character do ReplicatedStorage.rEvents.joinBrawl:FireServer("Win"); task.wait(1) end
    end)
    br:AddToggle("Auto Join Brawl (Farm)", false, function(v)
        getgenv().autoBrawlFarm = v
        while v and LocalPlayer.Character do ReplicatedStorage.rEvents.joinBrawl:FireServer("Farm"); task.wait(1) end
    end)

    local op = Tabs.Main:AddSection({ Title = "Op stuff (for farm)", Side = "Right" })
    op:AddToggle("Anti Knockback", false, function(v)
        getgenv().antiKnockback = v
        LocalPlayer.CharacterAdded:Connect(function(ch)
            if v then ch.HumanoidRootPart.Anchored = true; task.wait(.1); ch.HumanoidRootPart.Anchored = false end
        end)
    end)
    op:AddToggle("Auto Pushups 10M + Auto Punch", false, function(v)
        getgenv().autoPushups10M = v
        while v and LocalPlayer.Character do
            local p = LocalPlayer.Backpack:FindFirstChild("Pushups") or LocalPlayer.Character:FindFirstChild("Pushups")
            if p then
                p.Parent = LocalPlayer.Character
                ReplicatedStorage.muscleEvent:FireServer("rep")
                local rock = Workspace.machinesFolder:FindFirstChild("Ancient Jungle Rock")
                if rock and LocalPlayer:FindFirstChild("Durability") and LocalPlayer.Durability.Value >= 1e7 then
                    firetouchinterest(rock.Rock, LocalPlayer.Character.RightHand, 0)
                    firetouchinterest(rock.Rock, LocalPlayer.Character.LeftHand, 0)
                    task.wait()
                    firetouchinterest(rock.Rock, LocalPlayer.Character.RightHand, 1)
                    firetouchinterest(rock.Rock, LocalPlayer.Character.LeftHand, 1)
                    ReplicatedStorage.muscleEvent:FireServer("punch", "rightHand")
                    ReplicatedStorage.muscleEvent:FireServer("punch", "leftHand")
                end
            end
            task.wait(.1)
        end
    end)
    op:AddToggle("Free AutoLift Gamepass", false, function(v)
        getgenv().autoLiftGamepass = v
        while v and LocalPlayer.Character do
            local gp = ReplicatedStorage:FindFirstChild("gamepassIds")
            if gp then
                local owned = LocalPlayer:FindFirstChild("ownedGamepasses") or Instance.new("Folder", LocalPlayer)
                owned.Name = "ownedGamepasses"
                local al = owned:FindFirstChild("AutoLift") or Instance.new("IntValue", owned)
                al.Name, al.Value = "AutoLift", 1
            end
            task.wait(1)
        end
    end)
    op:AddToggle("Walk on Water", false, function(v)
        getgenv().walkOnWater = v
        if v then
            local pt = Instance.new("Part")
            pt.Size = Vector3.new(1000,1,1000); pt.Position = Vector3.new(0,0,0); pt.Anchored = true; pt.Transparency = .5; pt.CanCollide = true; pt.Parent = Workspace
            getgenv().waterPart = pt
        else
            if getgenv().waterPart then getgenv().waterPart:Destroy(); getgenv().waterPart = nil end
        end
    end)
    op:AddButton("Remove Ad Portal", function()
        for _,v in ipairs(Workspace:GetDescendants()) do if v.Name:match("AdPortal") then v:Destroy() end end
    end)
end

--[[  KILLING  ]]
do
    local s = Tabs.Kill:AddSection({ Title = "Killing", Side = "Left" })
    s:AddToggle("Auto Equip Punch", false, function(v)
        getgenv().autoEquipPunch = v
        while v and LocalPlayer.Character do
            local p = LocalPlayer.Backpack:FindFirstChild("Punch") or LocalPlayer.Character:FindFirstChild("Punch")
            if p then p.Parent = LocalPlayer.Character else LocalPlayer.Character.Humanoid:UnequipTools(); local bp = LocalPlayer.Backpack:FindFirstChild("Punch"); if bp then bp.Parent = LocalPlayer.Character end end
            task.wait(.5)
        end
    end)
    s:AddToggle("Auto Punch {With Movement}", false, function(v)
        getgenv().autoPunchMove = v
        while v and LocalPlayer.Character do
            local p = LocalPlayer.Character:FindFirstChild("Punch")
            if p then
                ReplicatedStorage.muscleEvent:FireServer("punch", "rightHand")
                ReplicatedStorage.muscleEvent:FireServer("punch", "leftHand")
                LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame + LocalPlayer.Character.Humanoid.MoveDirection * .5
            end
            task.wait(.1)
        end
    end)
    s:AddToggle("Auto Punch", false, function(v)
        getgenv().autopunch = v
        while v and LocalPlayer.Character do
            local p = LocalPlayer.Character:FindFirstChild("Punch")
            if p then ReplicatedStorage.muscleEvent:FireServer("punch", "rightHand"); ReplicatedStorage.muscleEvent:FireServer("punch", "leftHand") end
            task wait(.1)
        end
    end)
  
    s:AddToggle("Unlock Fast Punch", false, function(v)
        getgenv().fastPunch = v
        while v and LocalPlayer.Character do
            local p = LocalPlayer.Character:FindFirstChild("Punch")
            if p then ReplicatedStorage.muscleEvent:FireServer("punch", "rightHand"); ReplicatedStorage.muscleEvent:FireServer("punch", "leftHand") end
            task.wait(.05)
        end
    end)
    s:AddInput("Whitelist Player", "", function(t) getgenv().whitelist = getgenv().whitelist or {}; table.insert(getgenv().whitelist, t) end)
    s:AddButton("Clear Whitelist", function() getgenv().whitelist = {} end)
    s:AddToggle("Auto Kill", false, function(v)
        getgenv().autokill = v
        while v and LocalPlayer.Character do
            for _,pl in ipairs(Players:GetPlayers()) do
                if pl ~= LocalPlayer and not table.find(getgenv().whitelist or {}, pl.Name) and pl.Character and pl.Character:FindFirstChild("HumanoidRootPart") then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(pl.Character.HumanoidRootPart.Position)
                    ReplicatedStorage.muscleEvent:FireServer("punch", "rightHand")
                    ReplicatedStorage.muscleEvent:FireServer("punch", "leftHand")
                end
            end
            task.wait(.1)
        end
    end)
    s:AddToggle("Auto Kill Players", false, function(v)
        getgenv().autoKillActive = v
        local function hook(pl)
            if v and pl ~= LocalPlayer and not table.find(getgenv().whitelist or {}, pl.Name) then
                task.spawn(function()
                    while getgenv().autoKillActive and pl.Character and LocalPlayer.Character do
                        if pl.Character:FindFirstChild("HumanoidRootPart") then
                            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(pl.Character.HumanoidRootPart.Position)
                            ReplicatedStorage.muscleEvent:FireServer("punch", "rightHand")
                            ReplicatedStorage.muscleEvent:FireServer("punch", "leftHand")
                        end
                        task.wait(.1)
                    end
                end)
            end
        end
        Players.PlayerAdded:Connect(hook)
        for _,pl in ipairs(Players:GetPlayers()) do hook(pl) end
    end)
    local dropdown = s:AddDropdown("Players", { Default = LocalPlayer.Name, Values = {LocalPlayer.Name}, Multi = false, Callback = function() end })
    local function refreshPlrs()
        local t = {LocalPlayer.Name}
        for _,pl in ipairs(Players:GetPlayers()) do if pl ~= LocalPlayer then table.insert(t, pl.Name) end end
        dropdown.Values = t
    end
    Players.PlayerAdded:Connect(refreshPlrs); Players.PlayerRemoving:Connect(refreshPlrs); refreshPlrs()
    s:AddInput("Kill Player", "", function(name)
        local target = Players:FindFirstChild(name)
        if target and target.Character and LocalPlayer.Character then
            task.spawn(function()
                while target.Character and LocalPlayer.Character do
                    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(target.Character.HumanoidRootPart.Position)
                    ReplicatedStorage.muscleEvent:FireServer("punch", "rightHand")
                    ReplicatedStorage.muscleEvent:FireServer("punch", "leftHand")
                    task.wait(.1)
                end
            end)
        end
    end)
    s:AddLabel("---------------")
    s:AddInput("View Player", "", function(name)
        local target = Players:FindFirstChild(name)
        if target and target.Character then Workspace.CurrentCamera.CameraSubject = target.Character.Humanoid end
    end)
    s:AddButton("Unview Player", function()
        if LocalPlayer.Character then Workspace.CurrentCamera.CameraSubject = LocalPlayer.Character.Humanoid end
    end)
end

--[[  STATS  ]]
do
    local st = Tabs.Stats:AddSection({ Title = "Stats", Side = "Left" })
    st:AddButton("Show Kills Gui", function()
        local ls = LocalPlayer:FindFirstChild("leaderstats"); if not ls then return end
        local kl = st:AddLabel("Kills: "..(ls.Kills and ls.Kills.Value or 0))
        local sl = st:AddLabel("Strength: "..(ls.Strength and math.ceil(ls.Strength.Value) or 0))
        local dl = st:AddLabel("Durability: "..(ls.Durability and ls.Durability.Value or 0))
        if ls.Kills then ls.Kills.Changed:Connect(function(v) kl.Text = "Kills: "..v end) end
        if ls.Strength then ls.Strength.Changed:Connect(function(v) sl.Text = "Strength: "..math.ceil(v) end) end
        if ls.Durability then ls.Durability.Changed:Connect(function(v) dl.Text = "Durability: "..v end) end
        LocalPlayer.CharacterAdded:Connect(function() kl:Destroy(); sl:Destroy(); dl:Destroy() end)
    end)

    Tabs.Stats:AddSection({ Title = "Stats Gained", Side = "Right" })
    local rb = Tabs.Stats:AddSection({ Title = "Rebirth Calculation", Side = "Right" })
    local rl = {
        rb:AddLabel("Rebirths Gained In 1 Minute: ..."),
        rb:AddLabel("Rebirths Per Minute: ..."),
        rb:AddLabel("Rebirths Per Hour: ..."),
        rb:AddLabel("Rebirths Per Day: ..."),
        rb:AddLabel("Rebirths Per Week: ...")
    }
    task.spawn(function()
        local start, reb0 = os.time(), 0
        while true do
            local ls = LocalPlayer:FindFirstChild("leaderstats")
            if ls and ls.Rebirths then
                local reb = ls.Rebirths.Value
                local elapsed = os.time() - start
                if elapsed > 0 then
                    local pm = (reb - reb0) / (elapsed / 60)
                    rl[1].Text = "Rebirths Gained In 1 Minute: "..math.ceil(pm)
                    rl[2].Text = "Rebirths Per Minute: "..string.format("%.2f", pm)
                    rl[3].Text = "Rebirths Per Hour: "..string.format("%.2f", pm * 60)
                    rl[4].Text = "Rebirths Per Day: "..string.format("%.2f", pm * 60 * 24)
                    rl[5].Text = "Rebirths Per Week: "..string.format("%.2f", pm * 60 * 24 * 7)
                end
            end
            task.wait(10)
        end
    end)

    local spy = Tabs.Stats:AddSection({ Title = "Spy stats", Side = "Left" })
    local targetName = ""
    spy:AddInput("Target Name", "", function(t) targetName = t end)
    local spl = {
        spy:AddLabel("View Stats:"),
        spy:AddLabel("Strength: 0"),
        spy:AddLabel("Durability: 0"),
        spy:AddLabel("Agility: 0"),
        spy:AddLabel("Rebirths: 0"),
        spy:AddLabel("Kills: 0"),
        spy:AddLabel("Evil Karma: 0"),
        spy:AddLabel("Good Karma: 0"),
        spy:AddLabel("Target Equipped Pets: N/A")
    }
    task.spawn(function()
        while true do
            if targetName ~= "" then
                local t = Players:FindFirstChild(targetName)
                if t then
                    local ls = t:FindFirstChild("leaderstats")
                    if ls then
                        spl[2].Text = "Strength: "..(ls.Strength and string.format("%.2f", math.ceil(ls.Strength.Value)) or 0)
                        spl[3].Text = "Durability: "..(ls.Durability and ls.Durability.Value or 0)
                        spl[4].Text = "Agility: "..(ls.Agility and ls.Agility.Value or 0)
                        spl[5].Text = "Rebirths: "..(ls.Rebirths and ls.Rebirths.Value or 0)
                        spl[6].Text = "Kills: "..(ls.Kills and ls.Kills.Value or 0)
                        spl[7].Text = "Evil Karma: "..(ls.EvilKarma and ls.EvilKarma.Value or 0)
                        spl[8].Text = "Good Karma: "..(ls.GoodKarma and ls.GoodKarma.Value or 0)
                    end
                    local pets = ""
                    local pf = t:FindFirstChild("petsFolder")
                    if pf then
                        for _,folder in ipairs(pf:GetChildren()) do
                            if folder:IsA("Folder") then
                                for _,pet in ipairs(folder:GetChildren()) do pets = pets .. pet.Name .. ", " end
                            end
                        end
                    end
                    spl[9].Text = "Target Equipped Pets: "..(pets ~= "" and pets:sub(1, -3) or "N/A")
                end
            end
            task.wait(1)
        end
    end)
end

--[[  FARM++  ]]
do
    local jg = Tabs.Farm:AddSection({ Title = "Auto Gym - Jungle", Side = "Left" })
    local jm = { ["Jungle Bench"] = "autoJungleBench", ["Jungle Bar Lift"] = "autoJungleBarLift", ["Jungle Boulder"] = "autoJungleBoulder", ["Jungle Squat"] = "autoJungleSquat" }
    for name, var in pairs(jm) do
        jg:AddToggle("Auto "..name, false, function(v)
            getgenv()[var] = v
            while getgenv()[var] and LocalPlayer.Character do
                local mach = Workspace.machinesFolder:FindFirstChild(name)
                if mach then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(mach.interactSeat.Position)
                    ReplicatedStorage.rEvents.machineInteractRemote:InvokeServer("useMachine", mach)
                    ReplicatedStorage.muscleEvent:FireServer("rep")
                end
                task.wait(.1)
            end
        end)
    end

    local aq = Tabs.Farm:AddSection({ Title = "Auto Equip Weight Tools", Side = "Right" })
    local tl = { ["Auto Handstands"] = "Handstands", ["Auto Weight"] = "Weight", ["Auto Pushups"] = "Pushups", ["Auto Situps"] = "Situps" }
    for lab, tool in pairs(tl) do
        aq:AddToggle(lab, false, function(v)
            getgenv()[lab] = v
            while getgenv()[lab] and LocalPlayer.Character do
                local t = LocalPlayer.Backpack:FindFirstChild(tool) or LocalPlayer.Character:FindFirstChild(tool)
                if t then t.Parent = LocalPlayer.Character; ReplicatedStorage.muscleEvent:FireServer("rep") end
                task.wait(.5)
            end
        end)
    end
end

--[[  SERVER  ]]
do
    local sv = Tabs.Serv:AddSection({ Title = "Server", Side = "Left" })
    sv:AddToggle("Auto Kill Good Karma", false, function(v)
        getgenv().autoKillGoodKarma = v
        while v and LocalPlayer.Character do
            for _,pl in ipairs(Players:GetPlayers()) do
                if pl ~= LocalPlayer and pl.Character and pl.Character:FindFirstChild("GoodKarma") and pl.Character.GoodKarma.Value > 0 then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(pl.Character.HumanoidRootPart.Position)
                    ReplicatedStorage.muscleEvent:FireServer("punch", "rightHand")
                    ReplicatedStorage.muscleEvent:FireServer("punch", "leftHand")
                end
            end
            task.wait(.1)
        end
    end)
    sv:AddToggle("Auto Kill Evil Karma", false, function(v)
        getgenv().autoKillEvilKarma = v
        while v and LocalPlayer.Character do
            for _,pl in ipairs(Players:GetPlayers()) do
                if pl ~= LocalPlayer and pl.Character and pl.Character:FindFirstChild("EvilKarma") and pl.Character.EvilKarma.Value > 0 then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(pl.Character.HumanoidRootPart.Position)
                    ReplicatedStorage.muscleEvent:FireServer("punch", "rightHand")
                    ReplicatedStorage.muscleEvent:FireServer("punch", "leftHand")
                end
            end
            task.wait(.1)
        end
    end)
    sv:AddLabel("Ring Aura")
    sv:AddInput("Whitelist Player", "", function(t) getgenv().whitelist = getgenv().whitelist or {}; table.insert(getgenv().whitelist, t) end)
    sv:AddButton("Clear Whitelist", function() getgenv().whitelist = {} end)
    sv:AddInput("Ring Aura Color (RGB)", "255,0,0", function(v)
        local r, g, b = v:match("(%d+),(%d+),(%d+)")
        getgenv().ringAuraColor = Color3.fromRGB(tonumber(r) or 255, tonumber(g) or 0, tonumber(b) or 0)
    end)
    sv:AddInput("Ring Aura Radius", "10", function(v) getgenv().ringAuraRadius = math.clamp(tonumber(v) or 10, 1, 100) end)
    sv:AddToggle("Ring Aura", false, function(v)
        getgenv().ringAura = v
        while v and LocalPlayer.Character do
            for _,pl in ipairs(Players:GetPlayers()) do
                if pl ~= LocalPlayer and not table.find(getgenv().whitelist or {}, pl.Name) and pl.Character and pl.Character:FindFirstChild("HumanoidRootPart") then
                    local dist = (LocalPlayer.Character.HumanoidRootPart.Position - pl.Character.HumanoidRootPart.Position).Magnitude
                    if dist <= (getgenv().ringAuraRadius or 10) then
                        ReplicatedStorage.muscleEvent:FireServer("punch", "rightHand")
                        ReplicatedStorage.muscleEvent:FireServer("punch", "leftHand")
                    end
                end
            end
            task.wait(.1)
        end
    end)
    sv:AddLabel("Fast Rebirths")
    sv:AddToggle("Fast Rebirths | Required New Packs |", false, function(v)
        getgenv().fastRebirths = v
        while v and LocalPlayer.Character do ReplicatedStorage.rEvents.rebirthRemote:InvokeServer("rebirthRequest"); task.wait(.1) end
    end)
    sv:AddToggle("Fast Gain", false, function(v)
        getgenv().fastGain = v
        while v and LocalPlayer.Character do ReplicatedStorage.muscleEvent:FireServer("rep"); task.wait(.05) end
    end)
    sv:AddToggle("Hide Frames", false, function(v)
        getgenv().hideFrames = v
        while v do
            for _,fr in ipairs(game:GetService("CoreGui"):GetDescendants()) do if fr:IsA("Frame") then fr.Visible = false end end
            task.wait(.1)
        end
    end)
end

--[[  EGGS  ]]
do
    local e = Tabs.Eggs:AddSection({ Title = "Eggs", Side = "Left" })
    e:AddInput("Select Pet", "", function(t) getgenv().selectedPet = t end)
    e:AddToggle("Auto Buy Pet", false, function(v)
        getgenv().autoBuyPet = v
        while v and LocalPlayer.Character do
            if getgenv().selectedPet then
                ReplicatedStorage.rEvents.equipPetEvent:FireServer("equipPet", getgenv().selectedPet)
                task.wait(.1)
                ReplicatedStorage.rEvents.buyPetEvent:FireServer(getgenv().selectedPet)
            end
            task.wait(1)
        end
    end)
    local crystals = {
        "Blue Crystal", "Green Crystal", "Frozen Crystal", "Mythical Crystal", "Inferno Crystal",
        "Legends Crystal", "Dark Nebula Crystal", "Muscle Elite Crystal", "Galaxy Oracle Crystal",
        "Battle Legends Crystal", "Sky Eclipse Crystal", "Jungle Crystal"
    }
    e:AddDropdown("Select Crystal", { Default = "Blue Crystal", Values = crystals, Multi = false }, function(v) getgenv().crystal = v end)
    e:AddToggle("Auto Hatch Crystal", false, function(v)
        getgenv().autoHatchCrystal = v
        while v and LocalPlayer.Character do
            if getgenv().crystal then ReplicatedStorage.rEvents.openCrystalRemote:InvokeServer("openCrystal", getgenv().crystal) end
            task.wait(1)
        end
    end)
end

--[[  PLAYERS  ]]
do
    local p = Tabs.Ply:AddSection({ Title = "Players", Side = "Left" })
    p:AddInput("Walkspeed", "16", function(v) getgenv().walkspeed = math.clamp(tonumber(v) or 16, 0, 1000) end)
    p:AddToggle("Set Walkspeed", false, function(v)
        getgenv().setWalkspeed = v
        while v and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") do
            LocalPlayer.Character.Humanoid.WalkSpeed = getgenv().walkspeed or 16
            task.wait()
        end
    end)
    p:AddInput("JumpPower", "50", function(v)
        getgenv().jumpPower = math.clamp(tonumber(v) or 50, 0, 500)
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then LocalPlayer.Character.Humanoid.JumpPower = getgenv().jumpPower end
    end)
    p:AddInput("HipHeight", "0", function(v)
        getgenv().hipHeight = math.clamp(tonumber(v) or 0, -10, 100)
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then LocalPlayer.Character.Humanoid.HipHeight = getgenv().hipHeight end
    end)
    p:AddInput("Max Zoom Distance", "128", function(v) LocalPlayer.CameraMaxZoomDistance = math.clamp(tonumber(v) or 128, 0, 1000) end)
    p:AddLabel("--------")
    p:AddToggle("Lock Client Position", false, function(v)
        getgenv().lockPosition = v
        if v then
            getgenv().lockedPos = LocalPlayer.Character.HumanoidRootPart.CFrame
            getgenv().lockConnection = RunService.Heartbeat:Connect(function()
                if LocalPlayer.Character and LocalPlayer.Character.HumanoidRootPart then LocalPlayer.Character.HumanoidRootPart.CFrame = getgenv().lockedPos end
            end)
        else
            if getgenv().lockConnection then getgenv().lockConnection:Disconnect() end
        end
    end)
    p:AddButton("Remove Punch", function()
        local punch = LocalPlayer.Backpack:FindFirstChild("Punch") or LocalPlayer.Character:FindFirstChild("Punch")
        if punch then punch:Destroy() end
    end)
    p:AddButton("Recover Punch", function() ReplicatedStorage.rEvents.giveTool:FireServer("Punch") end)
    p:AddToggle("Infinite Jump", false, function(v)
        getgenv().infiniteJump = v
        game:GetService("UserInputService").JumpRequest:Connect(function()
            if getgenv().infiniteJump and LocalPlayer.Character then LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end
        end)
    end)
    p:AddToggle("Noclip", false, function(v)
        getgenv().noclip = v
        if v then
            getgenv().noclipConnection = RunService.Stepped:Connect(function()
                if LocalPlayer.Character then
                    for _,pt in ipairs(LocalPlayer.Character:GetDescendants()) do if pt:IsA("BasePart") then pt.CanCollide = false end end
                end
            end)
        else
            if getgenv().noclipConnection then getgenv().noclipConnection:Disconnect() end
        end
    end)
    p:AddButton("Anti AFK", function()
        game:GetService("VirtualUser").CaptureController:ClickButton2(Vector2.new())
        game:GetService("VirtualUser").Idled:Connect(function() game:GetService("VirtualUser").CaptureController:ClickButton2(Vector2.new()) end)
    end)
    p:AddButton("Anti Lag", function()
        for _,v in ipairs(Workspace:GetDescendants()) do
            if v:IsA("BasePart") and not v.Parent:IsA("Model") then v.Material = Enum.Material.SmoothPlastic; v.Reflectance = 0 end
        end
    end)
    p:AddButton("ChatSpy", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/CAXAP26BKyCH/ChatSpy/main/ChatSpy"))() end)
end

--[[  CREDITS  ]]
do
    local c = Tabs.Cred:AddSection({ Title = "Credits", Side = "Left" })
    c:AddLabel("This Script made by Doca")
    c:AddLabel("Roblox: Xx_GPWArka")
    c:AddLabel("Discord: itsdocas_60003")
    c:AddButton("Copy Discord Invite link", function() setclipboard("https://discord.gg/itsdocas_60003") end)
end

--[[  PAID  ]]
do
    local fg = Tabs.Paid:AddSection({ Title = "Fast Glitch", Side = "Left" })
    local rocks = {
        {n = "TinyIslandRock",      ttl = "Tiny Rock",                      d = 0},
        {n = "PunchingIslandRock",  ttl = "Punching Rock",                  d = 10},
        {n = "LargeIslandRock",     ttl = "Large Rock",                     d = 100},
        {n = "GoldenBeachRock",     ttl = "Golden Rock",                    d = 5000},
        {n = "FrostGymRock",        ttl = "Frost Rock",                     d = 150000},
        {n = "MythicalGymRock",     ttl = "Mythical Rock",                  d = 400000},
        {n = "InfernoGymRock",      ttl = "Inferno Rock",                   d = 750000},
        {n = "LegendsGymRock",      ttl = "Legends Rock",                   d = 1000000},
        {n = "MuscleKingGymRock",   ttl = "Muscle King Gym Rock",           d = 5000000},
        {n = "AncientJungleRock",   ttl = "Ancient Jungle Rock",            d = 10000000}
    }
    for _,r in ipairs(rocks) do
        fg:AddToggle(r.ttl, false, function(v)
            getgenv().fastGlitch = getgenv().fastGlitch or {}
            getgenv().fastGlitch[r.n] = v
            while getgenv().fastGlitch[r.n] and LocalPlayer.Character do
                if LocalPlayer:FindFirstChild("Durability") and LocalPlayer.Durability.Value >= r.d then
                    local rock = Workspace:FindFirstChild(r.n)
                    if rock then
                        firetouchinterest(rock.Rock, LocalPlayer.Character.RightHand, 0)
                        firetouchinterest(rock.Rock, LocalPlayer.Character.LeftHand, 0)
                        task.wait()
                        firetouchinterest(rock.Rock, LocalPlayer.Character.RightHand, 1)
                        firetouchinterest(rock.Rock, LocalPlayer.Character.LeftHand, 1)
                        ReplicatedStorage.muscleEvent:FireServer("punch", "rightHand")
                        ReplicatedStorage.muscleEvent:FireServer("punch", "leftHand")
                    end
                end
                task.wait(.05)
            end
        end)
    end

    local fg2 = Tabs.Paid:AddSection({ Title = "Fast Glitch V2", Side = "Right" })
    local g2 = {
        ["Tiny Rock Fast Glitch"]       = "Tiny Island Rock",
        ["Punching Rock Fast Glitch"]   = "Punching Rock",
        ["Large Rock Fast Glitch"]      = "Large Island Rock",
        ["Golden Fast Glitch"]          = "Golden Rock",
        ["Frost Rock Fast Glitch"]      = "Frost Gym Rock",
        ["Mythical Rock Fast Glitch"]   = "Mythical Gym Rock",
        ["Eternal Rock Fast Glitch"]    = "Eternal Gym Rock",
        ["Legends Rock Fast Glitch"]    = "Legend Gym Rock",
        ["Muscle King Fast Glitch"]     = "Muscle King Gym Rock",
        ["Ancient Jungle Fast Glitch"]  = "Ancient Jungle Rock"
    }
    for ttl, rock in pairs(g2) do
        fg2:AddToggle(ttl, false, function(v)
            getgenv().fastGlitchV2 = getgenv().fastGlitchV2 or {}
            getgenv().fastGlitchV2[rock] = v
            while getgenv().fastGlitchV2[rock] and LocalPlayer.Character do
                local rockObj = Workspace.machinesFolder:FindFirstChild(rock)
                if rockObj then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(rockObj.Rock.Position + Vector3.new(0, 5, 0))
                    ReplicatedStorage.muscleEvent:FireServer("punch", "rightHand")
                    ReplicatedStorage.muscleEvent:FireServer("punch", "leftHand")
                end
                task.wait(.05)
            end
        end)
    end
end

--[[  KILLING V2  ]]
do
    local k2 = Tabs.Kill2:AddSection({ Title = "Killing V2", Side = "Left" })
    k2:AddToggle("Auto Punch", false, function(v)
        getgenv().autopunch = v
        while v and LocalPlayer.Character do
            local p = LocalPlayer.Character:FindFirstChild("Punch")
            if not p then p = LocalPlayer.Backpack:FindFirstChild("Punch"); if p then LocalPlayer.Character.Humanoid:EquipTool(p) end end
            if p then ReplicatedStorage.muscleEvent:FireServer("punch", "rightHand"); ReplicatedStorage.muscleEvent:FireServer("punch", "leftHand") end
            task.wait(.1)
        end
    end)
    k2:AddToggle("Fast Punch", false, function(v)
        getgenv().fastPunch = v
        while v and LocalPlayer.Character do
            local p = LocalPlayer.Character:FindFirstChild("Punch")
            if not p then p = LocalPlayer.Backpack:FindFirstChild("Punch"); if p then LocalPlayer.Character.Humanoid:EquipTool(p) end end
            if p then ReplicatedStorage.muscleEvent:FireServer("punch", "rightHand"); ReplicatedStorage.muscleEvent:FireServer("punch", "leftHand") end
            task.wait(.05)
        end
    end)
    k2:AddToggle("Auto Kill Everyone", false, function(v)
        getgenv().autoKillActive = v
        while v and LocalPlayer.Character do
            for _,pl in ipairs(Players:GetPlayers()) do
                if pl ~= LocalPlayer and not table.find(getgenv().whitelist or {}, pl.Name) and pl.Character and pl.Character:FindFirstChild("HumanoidRootPart") then
                    if getgenv().killMethod == "Teleport" then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(pl.Character.HumanoidRootPart.Position)
                    end
                    ReplicatedStorage.muscleEvent:FireServer("punch", "rightHand")
                    ReplicatedStorage.muscleEvent:FireServer("punch", "leftHand")
                end
            end
            task.wait(.1)
        end
    end)
    k2:AddDropdown("Select Kill Method", { Default = "Teleport", Values = { "Teleport", "Non-Teleport" }, Multi = false }, function(m) getgenv().killMethod = m end)
    local wldd = k2:AddDropdown("Whitelist Players", { Default = LocalPlayer.Name, Values = {LocalPlayer.Name}, Multi = true }, function(sel)
        getgenv().whitelist = getgenv().whitelist or {}
        for _,name in ipairs(sel) do
            if name ~= LocalPlayer.Name and not table.find(getgenv().whitelist, name) then
                table.insert(getgenv().whitelist, name)
            end
        end
    end)
    local function refreshW()
        local t = {LocalPlayer.Name}
        for _,pl in ipairs(Players:GetPlayers()) do if pl ~= LocalPlayer then table.insert(t, pl.Name) end end
        wldd.Values = t
    end
    Players.PlayerAdded:Connect(refreshW); Players.PlayerRemoving:Connect(refreshW); refreshW()
    k2:AddToggle("Fast Kill Aura", false, function(v)
        getgenv().fastKillAura = v
        while v and LocalPlayer.Character do
            for _,pl in ipairs(Players:GetPlayers()) do
                if pl ~= LocalPlayer and not table.find(getgenv().whitelist or {}, pl.Name) and pl.Character and pl.Character:FindFirstChild("HumanoidRootPart") then
                    local dist = (LocalPlayer.Character.HumanoidRootPart.Position - pl.Character.HumanoidRootPart.Position).Magnitude
                    if dist <= (getgenv().ringAuraRadius or 10) then
                        ReplicatedStorage.muscleEvent:FireServer("punch", "rightHand")
                        ReplicatedStorage.muscleEvent:FireServer("punch", "leftHand")
                    end
                end
            end
            task.wait(.05)
        end
    end)
    k2:AddLabel("---Single Kill---")
    k2:AddInput("Player Username", "", function(t) getgenv().targetPlayerName = t end)
    k2:AddToggle("Auto Fast Kill Player", false, function(v)
        getgenv().autoFastKillPlayer = v
        while v and LocalPlayer.Character and getgenv().targetPlayerName do
            local target = Players:FindFirstChild(getgenv().targetPlayerName)
            if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                if getgenv().killMethod == "Teleport" then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(target.Character.HumanoidRootPart.Position)
                end
                ReplicatedStorage.muscleEvent:FireServer("punch", "rightHand")
                ReplicatedStorage.muscleEvent:FireServer("punch", "leftHand")
            end
            task.wait(.05)
        end
    end)
    k2:AddToggle("Spy Player", false, function(v)
        getgenv().spyPlayer = v
        while v and getgenv().targetPlayerName do
            local target = Players:FindFirstChild(getgenv().targetPlayerName)
            if target and target.Character then Workspace.CurrentCamera.CameraSubject = target.Character.Humanoid end
            task.wait(1)
        end
        if LocalPlayer.Character then Workspace.CurrentCamera.CameraSubject = LocalPlayer.Character.Humanoid end
    end)
end

--[[  CHARACTER ADDED REBUILDS  ]]
LocalPlayer.CharacterAdded:Connect(function(char)
    if getgenv().setWalkspeed and getgenv().walkspeed then char.Humanoid.WalkSpeed = getgenv().walkspeed end
    if getgenv().jumpPower then char.Humanoid.JumpPower = getgenv().jumpPower end
    if getgenv().hipHeight then char.Humanoid.HipHeight = getgenv().hipHeight end
end)
