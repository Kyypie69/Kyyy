-- ===================================================================
--  Doca V1  |  Fluent-Renewed Edition  |  2025-09-13
-- ===================================================================
-- 1.  Load Fluent, SaveManager & InterfaceManager
local Fluent = loadstring(game:HttpGetAsync("https://github.com/ActualMasterOogway/Fluent-Renewed/releases/latest/download/Fluent.luau"))()
local SaveManager = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/ActualMasterOogway/Fluent-Renewed/master/Addons/SaveManager.luau"))()
local InterfaceManager = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/ActualMasterOogway/Fluent-Renewed/master/Addons/InterfaceManager.luau"))()

-- 2.  Create the main window
local Window = Fluent:CreateWindow({
    Title = "KYY",
    TabWidth = 125,
    Size = UDim2.fromOffset(600, 325),
    Position = UDim2.fromOffset(50, 50),
    Resize = false,
    Acrylic = true,
    Theme = "Amethyst Dark",               -- “Dark” | “Light” | “Aqua” ...
    MinimizeKey = Enum.KeyCode.LeftControl -- optional
})

-- 3.  Helper: quickly add a toggle + loop
local function AddToggle(Tab, text, flag, func)
    local Toggle = Tab:AddToggle({Title = text, Default = false, Callback = function(v)
        getgenv()[flag] = v
        if v then
            task.spawn(function()
                while getgenv()[flag] and game:GetService("Players").LocalPlayer.Character do
                    func()
                    task.wait()
                end
            end)
        end
    end})
    return Toggle
end

-- 4.  Services & shortcuts
local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local RS = game:GetService("ReplicatedStorage")
local WS = game:GetService("Workspace")

-- ===================================================================
-- TABS
-- ===================================================================
local Tabs = {
    Main     = Window:CreateTab({Title = "Main",     Icon = "home"}),
    Killing  = Window:CreateTab({Title = "Killing",  Icon = "sword"}),
    Stats    = Window:CreateTab({Title = "Stats",    Icon = "chart-line"}),
    FarmPlus = Window:CreateTab({Title = "Farming",   Icon = "dumbbell"}),
    Server   = Window:CreateTab({Title = "Server",   Icon = "server"}),
    Eggs     = Window:CreateTab({Title = "Eggs",     Icon = "egg"}),
    Players  = Window:CreateTab({Title = "Players",  Icon = "user"}),
    Credits  = Window:CreateTab({Title = "Credits",  Icon = "info-circle"}),
    Paid     = Window:CreateTab({Title = "Paid Tab", Icon = "crown"})
}

-- ===================================================================
-- MAIN TAB
-- ===================================================================
do
    local Toggle = Tabs.Main:CreateToggle({Title = "Auto Eat Protein Egg Every 30 Minutes", Default = false})
    autoEat30:OnChanged(function(v)
        getgenv().autoEatProteinEggActive = v
        if v then
            task.spawn(function()
                while getgenv().autoEatProteinEggActive and LP.Character do
                    local egg = LP.Backpack:FindFirstChild("Protein Egg") or LP.Character:FindFirstChild("Protein Egg")
                    if egg then egg.Parent = LP.Character; RS.muscleEvent:FireServer("rep") end
                    task.wait(1800)
                end
            end)
        end
    end)

    local Toggle = Tabs.Main:CreateToggle({Title = "Auto Eat Protein Egg Every 1 Hour", Default = false})
    autoEat1h:OnChanged(function(v)
        getgenv().autoEatProteinEggHourly = v
        if v then
            task.spawn(function()
                while getgenv().autoEatProteinEggHourly and LP.Character do
                    local egg = LP.Backpack:FindFirstChild("Protein Egg") or LP.Character:FindFirstChild("Protein Egg")
                    if egg then egg.Parent = LP.Character; RS.muscleEvent:FireServer("rep") end
                    task.wait(3600)
                end
            end)
        end
    end)

    Tabs.Main:AddToggle({Title = "Auto Farm (Equip Any Tool)", Default = false}):OnChanged(function(v)
        getgenv().autoFarm = v
        if v then
            task.spawn(function()
                while getgenv().autoFarm and LP.Character do
                    for _,tool in ipairs(LP.Backpack:GetChildren()) do
                        if tool:IsA("Tool") then
                            tool.Parent = LP.Character
                            RS.muscleEvent:FireServer("rep")
                            task.wait(0.1)
                        end
                    end
                    task.wait()
                end
            end)
        end
    end)

    Tabs.Main:AddLabel("Script Hub")
    Tabs.Main:AddButton({Title = "Permanent ShiftLock", Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/MiniNoobie/ShiftLockx/main/Shiftlock-MiniNoobie"))()
    end})

    Tabs.Main:AddLabel("---Time---")
    Tabs.Main:AddButton({Title = "Night",   Callback = function() game.Lighting.ClockTime = 0  end})
    Tabs.Main:AddButton({Title = "Morning", Callback = function() game.Lighting.ClockTime = 6  end})
    Tabs.Main:AddButton({Title = "Day",     Callback = function() game.Lighting.ClockTime = 12 end})

    Tabs.Main:AddLabel("----Farming----")
end

-- ===================================================================
-- KILLING TAB
-- ===================================================================
do
    Tabs.Killing:AddToggle({Title = "Auto Equip Punch", Default = false}):OnChanged(function(v)
        getgenv().autoEquipPunch = v
        if v then
            task.spawn(function()
                while getgenv().autoEquipPunch and LP.Character do
                    local punch = LP.Backpack:FindFirstChild("Punch") or LP.Character:FindFirstChild("Punch")
                    if punch then punch.Parent = LP.Character end
                    task.wait(0.5)
                end
            end)
        end
    end)

    Tabs.Killing:AddToggle({Title = "Auto Punch", Default = false}):OnChanged(function(v)
        getgenv().autopunch = v
        if v then
            task.spawn(function()
                while getgenv().autopunch and LP.Character do
                    if LP.Character:FindFirstChild("Punch") then
                        RS.muscleEvent:FireServer("punch","rightHand")
                        RS.muscleEvent:FireServer("punch","leftHand")
                    end
                    task.wait(0.1)
                end
            end)
        end
    end)

    Tabs.Killing:AddToggle({Title = "Unlock Fast Punch", Default = false}):OnChanged(function(v)
        getgenv().fastPunch = v
        if v then
            task.spawn(function()
                while getgenv().fastPunch and LP.Character do
                    if LP.Character:FindFirstChild("Punch") then
                        RS.muscleEvent:FireServer("punch","rightHand")
                        RS.muscleEvent:FireServer("punch","leftHand")
                    end
                    task.wait(0.05)
                end
            end)
        end
    end)

    local whitelistInput = Tabs.Killing:AddInput({Title = "Whitelist Player", Placeholder = "Username"})
    whitelistInput:OnChanged(function(name)
        getgenv().whitelist = getgenv().whitelist or {}
        table.insert(getgenv().whitelist, name)
    end)
    Tabs.Killing:AddButton({Title = "Clear Whitelist", Callback = function() getgenv().whitelist = {} end})

    Tabs.Killing:AddToggle({Title = "Auto Kill", Default = false}):OnChanged(function(v)
        getgenv().autokill = v
        if v then
            task.spawn(function()
                while getgenv().autokill and LP.Character do
                    for _,plr in ipairs(Players:GetPlayers()) do
                        if plr ~= LP and not table.find(getgenv().whitelist or {}, plr.Name) and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                            LP.Character.HumanoidRootPart.CFrame = CFrame.new(plr.Character.HumanoidRootPart.Position)
                            RS.muscleEvent:FireServer("punch","rightHand")
                            RS.muscleEvent:FireServer("punch","leftHand")
                        end
                    end
                    task.wait(0.1)
                end
            end)
        end
    end)
end

-- ===================================================================
-- STATS TAB
-- ===================================================================
do
    Tabs.Stats:AddButton({Title = "Show Kills Gui", Callback = function()
        local ls = LP:FindFirstChild("leaderstats")
        if not ls then return end
        local killsL = Tabs.Stats:AddLabel("Kills: "..(ls.Kills and ls.Kills.Value or 0))
        local strL   = Tabs.Stats:AddLabel("Strength: "..(ls.Strength and math.ceil(ls.Strength.Value) or 0))
        local durL   = Tabs.Stats:AddLabel("Durability: "..(ls.Durability and ls.Durability.Value or 0))
        if ls.Kills      then ls.Kills.Changed:Connect(function(v) killsL:SetText("Kills: "..v) end) end
        if ls.Strength   then ls.Strength.Changed:Connect(function(v) strL:SetText("Strength: "..math.ceil(v)) end) end
        if ls.Durability then ls.Durability.Changed:Connect(function(v) durL:SetText("Durability: "..v) end) end
    end})

    Tabs.Stats:AddLabel("Rebirth tracker running in background…")
end

-- ===================================================================
-- FARM++ TAB
-- ===================================================================
do
    local gym = Tabs.FarmPlus:AddSection({Title = "Auto Jungle Gym"})
    for _,name in ipairs({"Jungle Bench","Jungle Bar Lift","Jungle Boulder","Jungle Squat"}) do
        local flag = "auto"..name:gsub(" ","")
        AddToggle(Tabs.FarmPlus, "Auto "..name, flag, function()
            local machine = WS.machinesFolder:FindFirstChild(name)
            if machine then
                LP.Character.HumanoidRootPart.CFrame = CFrame.new(machine.interactSeat.Position)
                RS.rEvents.machineInteractRemote:InvokeServer("useMachine", machine)
                RS.muscleEvent:FireServer("rep")
            end
            task.wait(0.1)
        end)
    end

    local eq = Tabs.FarmPlus:AddSection({Title = "Auto Equip Weight Tools"})
    for _,tool in ipairs({"Handstands","Weight","Pushups","Situps"}) do
        AddToggle(Tabs.FarmPlus, "Auto "..tool, "auto"..tool, function()
            local t = LP.Backpack:FindFirstChild(tool) or LP.Character:FindFirstChild(tool)
            if t then t.Parent = LP.Character; RS.muscleEvent:FireServer("rep") end
            task.wait(0.5)
        end)
    end
end

-- ===================================================================
-- SERVER TAB
-- ===================================================================
do
    AddToggle(Tabs.Server, "Fast Rebirths | Requires New Packs", "fastRebirths", function()
        RS.rEvents.rebirthRemote:InvokeServer("rebirthRequest")
        task.wait(0.1)
    end)

    AddToggle(Tabs.Server, "Fast Gain", "fastGain", function()
        RS.muscleEvent:FireServer("rep")
        task.wait(0.05)
    end)

    AddToggle(Tabs.Server, "Hide Frames", "hideFrames", function()
        for _,f in ipairs(game:GetService("CoreGui"):GetDescendants()) do
            if f:IsA("Frame") then f.Visible = false end
        end
        task.wait(0.1)
    end)
end

-- ===================================================================
-- EGGS TAB
-- ===================================================================
do
    local petInput = Tabs.Eggs:AddInput({Title = "Select Pet", Placeholder = "Pet name"})
    petInput:OnChanged(function(v) getgenv().selectedPet = v end)

    Tabs.Eggs:AddToggle({Title = "Auto Buy Pet", Default = false}):OnChanged(function(v)
        getgenv().autoBuyPet = v
        if v then
            task.spawn(function()
                while getgenv().autoBuyPet and LP.Character do
                    if getgenv().selectedPet then
                        RS.rEvents.equipPetEvent:FireServer("equipPet", getgenv().selectedPet)
                        task.wait(0.1)
                        RS.rEvents.buyPetEvent:FireServer(getgenv().selectedPet)
                    end
                    task.wait(1)
                end
            end)
        end
    end)

    local crystals = {
        "Blue Crystal","Green Crystal","Frozen Crystal","Mythical Crystal","Inferno Crystal",
        "Legends Crystal","Dark Nebula Crystal","Muscle Elite Crystal","Galaxy Oracle Crystal",
        "Battle Legends Crystal","Sky Eclipse Crystal","Jungle Crystal"
    }
    local crystalDrop = Tabs.Eggs:AddDropdown({Title = "Select Crystal", Values = crystals, Multi = false})
    crystalDrop:OnChanged(function(v) getgenv().crystal = v end)

    Tabs.Eggs:AddToggle({Title = "Auto Hatch Crystal", Default = false}):OnChanged(function(v)
        getgenv().autoHatchCrystal = v
        if v then
            task.spawn(function()
                while getgenv().autoHatchCrystal and LP.Character do
                    if getgenv().crystal then
                        RS.rEvents.openCrystalRemote:InvokeServer("openCrystal", getgenv().crystal)
                    end
                    task.wait(1)
                end
            end)
        end
    end)
end

-- ===================================================================
-- PLAYERS TAB
-- ===================================================================
do
    local Toggle = Tabs.Players:AddInput({Title = "Walkspeed", Placeholder = "16"})
    wsInput:OnChanged(function(v)
        getgenv().walkspeed = math.clamp(tonumber(v) or 16, 0, 1000)
        if LP.Character and LP.Character:FindFirstChild("Humanoid") then
            LP.Character.Humanoid.WalkSpeed = getgenv().walkspeed
        end
    end)

    local Toggle = Tabs.Players:AddInput({Title = "JumpPower", Placeholder = "50"})
    jpInput:OnChanged(function(v)
        getgenv().jumpPower = math.clamp(tonumber(v) or 50, 0, 500)
        if LP.Character and LP.Character:FindFirstChild("Humanoid") then
            LP.Character.Humanoid.JumpPower = getgenv().jumpPower
        end
    end)

    local Toggle = Tabs.Players:AddInput({Title = "HipHeight", Placeholder = "0"})
    hhInput:OnChanged(function(v)
        getgenv().hipHeight = math.clamp(tonumber(v) or 0, -10, 100)
        if LP.Character and LP.Character:FindFirstChild("Humanoid") then
            LP.Character.Humanoid.HipHeight = getgenv().hipHeight
        end
    end)

    Tabs.Players:AddButton({Title = "Anti-AFK", Callback = function()
        game:GetService("VirtualUser"):CaptureController()
        game:GetService("VirtualUser"):ClickButton2(Vector2.new())
        game:GetService("VirtualUser").Idled:Connect(function()
            game:GetService("VirtualUser"):ClickButton2(Vector2.new())
        end)
    end})

    Tabs.Players:AddButton({Title = "Noclip (Toggle)", Callback = function()
        getgenv().noclip = not getgenv().noclip
        if getgenv().noclip then
            getgenv().noclipConn = game:GetService("RunService").Stepped:Connect(function()
                for _,p in ipairs(LP.Character:GetDescendants()) do
                    if p:IsA("BasePart") then p.CanCollide = false end
                end
            end)
        else
            if getgenv().noclipConn then getgenv().noclipConn:Disconnect() end
        end
    end})
end

-- ===================================================================
-- CREDITS TAB
-- ===================================================================
do
    Tabs.Credits:AddLabel("Script by Markyy")
    Tabs.Credits:AddLabel("Roblox: Markyy_0311")
    Tabs.Credits:AddLabel("Discord: markyy11")
    Tabs.Credits:AddButton({Title = "Copy Discord Invite", Callback = function()
        setclipboard("https://discord.gg/CCUdkJWP")
    end})
end

-- ===================================================================
-- PAID TAB
-- ===================================================================
do
    local Toggle = Tabs.Paid:AddSection({Title = "Fast Glitch"})
    local rocks = {
        {Title = "Tiny Rock",          Name = "TinyIslandRock",      Dur = 0},
        {Title = "Punching Rock",      Name = "PunchingIslandRock",  Dur = 10},
        {Title = "Large Rock",         Name = "LargeIslandRock",     Dur = 100},
        {Title = "Golden Rock",        Name = "GoldenBeachRock",     Dur = 5000},
        {Title = "Frost Rock",         Name = "FrostGymRock",        Dur = 150000},
        {Title = "Mythical Rock",      Name = "MythicalGymRock",     Dur = 400000},
        {Title = "Inferno Rock",       Name = "InfernoGymRock",      Dur = 750000},
        {Title = "Legends Rock",       Name = "LegendsGymRock",      Dur = 1000000},
        {Title = "Muscle King Rock",   Name = "MuscleKingGymRock",   Dur = 5000000},
        {Title = "Ancient Jungle Rock",Name = "AncientJungleRock",   Dur = 10000000}
    }
    for _,r in ipairs(rocks) do
        AddToggle(Tabs.Paid, r.Title, "fg_"..r.Name, function()
            if LP:FindFirstChild("Durability") and LP.Durability.Value >= r.Dur then
                local rock = WS:FindFirstChild(r.Name)
                if rock then
                    firetouchinterest(rock.Rock, LP.Character.RightHand, 0)
                    firetouchinterest(rock.Rock, LP.Character.LeftHand, 0)
                    task.wait()
                    firetouchinterest(rock.Rock, LP.Character.RightHand, 1)
                    firetouchinterest(rock.Rock, LP.Character.LeftHand, 1)
                    RS.muscleEvent:FireServer("punch","rightHand")
                    RS.muscleEvent:FireServer("punch","leftHand")
                end
            end
            task.wait(0.05)
        end)
    end
end

-- ===================================================================
-- 5.  SaveManager & InterfaceManager
-- ===================================================================
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:BuildConfigSection(Tabs.Credits)
InterfaceManager:BuildInterfaceSection(Tabs.Credits)

-- ===================================================================
-- 6.  Character re-application
-- ===================================================================
LP.CharacterAdded:Connect(function(char)
    task.wait(0.2)
    if getgenv().walkspeed  and char:FindFirstChild("Humanoid") then char.Humanoid.WalkSpeed  = getgenv().walkspeed  end
    if getgenv().jumpPower  and char:FindFirstChild("Humanoid") then char.Humanoid.JumpPower  = getgenv().jumpPower  end
    if getgenv().hipHeight   and char:FindFirstChild("Humanoid") then char.Humanoid.HipHeight   = getgenv().hipHeight   end
end)
