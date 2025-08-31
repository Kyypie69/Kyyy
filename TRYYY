-- Main script, Rayfield UI, feature loops, and modular glue

-- REQUIRE MODULES
local PlayerUtils = loadstring(readfile("PlayerUtils.lua"))()
local WhitelistManager = loadstring(readfile("WhitelistManager.lua"))()
local ESPManager = loadstring(readfile("ESPManager.lua"))()

-- LOAD RAYFIELD (make sure Rayfield is in your workspace or loadstring it here)
local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Rayfield/main/source"))()

-- SERVICES
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- STATE
local autoKill, targetMode, autoFarm, godmodeEnabled, antiAfkEnabled = false, false, false, false, false
local targetPlayer = nil

-- Functions
local function KillPlayer(player)
    local myChar = LocalPlayer.Character
    if not myChar then return end
    local myHand = myChar:FindFirstChild("LeftHand") or myChar:FindFirstChild("RightHand")
    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and myHand then
        firetouchinterest(player.Character.HumanoidRootPart, myHand, 0)
        firetouchinterest(player.Character.HumanoidRootPart, myHand, 1)
    end
end

-- UI Construction
local Window = Rayfield:CreateWindow({
    Name = "Advanced Kill GUI (Rayfield Edition)",
    LoadingTitle = "Initializing...",
    LoadingSubtitle = "by Kyypie69",
})

-- Player List Helper
local function GetPlayerOptions()
    local opts = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            table.insert(opts, p.Name .. " (" .. p.DisplayName .. ")")
        end
    end
    return opts
end

-- Tabs
local CombatTab = Window:CreateTab("Combat", 4483345998)
local UtilityTab = Window:CreateTab("Utility", 4483345998)
local WhitelistTab = Window:CreateTab("Whitelist", 4483345998)
local ESPTab = Window:CreateTab("ESP", 4483345998)

-- Combat Features
CombatTab:CreateToggle({
    Name = "Auto Kill (Except Whitelisted)",
    CurrentValue = false,
    Callback = function(Value)
        autoKill = Value
    end
})

CombatTab:CreateToggle({
    Name = "Target Kill Mode",
    CurrentValue = false,
    Callback = function(Value)
        targetMode = Value
    end
})

CombatTab:CreateDropdown({
    Name = "Target Player",
    Options = GetPlayerOptions(),
    CurrentOption = nil,
    Callback = function(Option)
        targetPlayer = PlayerUtils.GetPlayerByNameOrDisplay(Option:match("^(.-) %("))
        ESPManager:Refresh(WhitelistManager, targetPlayer)
    end
})

-- Utility Features
UtilityTab:CreateToggle({
    Name = "Auto Farm",
    CurrentValue = false,
    Callback = function(Value)
        autoFarm = Value
    end
})

UtilityTab:CreateToggle({
    Name = "Godmode",
    CurrentValue = false,
    Callback = function(Value)
        godmodeEnabled = Value
    end
})

UtilityTab:CreateToggle({
    Name = "Anti-AFK",
    CurrentValue = false,
    Callback = function(Value)
        antiAfkEnabled = Value
        if Value then
            LocalPlayer.Idled:Connect(function()
                game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
                wait(0.5)
                game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
            end)
        end
    end
})

-- ESP Features
ESPTab:CreateToggle({
    Name = "Enable ESP",
    CurrentValue = false,
    Callback = function(Value)
        ESPManager.Enabled = Value
        ESPManager:Refresh(WhitelistManager, targetPlayer)
    end
})

Players.PlayerAdded:Connect(function()
    ESPManager:Refresh(WhitelistManager, targetPlayer)
end)
Players.PlayerRemoving:Connect(function()
    ESPManager:Refresh(WhitelistManager, targetPlayer)
end)

-- Whitelist UI
WhitelistTab:CreateInput({
    Name = "Add Player by Name",
    PlaceholderText = "Username or DisplayName",
    RemoveTextAfterFocusLost = true,
    Callback = function(Value)
        local p = PlayerUtils.GetPlayerByNameOrDisplay(Value)
        if p then
            WhitelistManager:Add(p.Name)
            ESPManager:Refresh(WhitelistManager, targetPlayer)
            Rayfield:Notify({Title="Whitelist", Content="Added "..p.Name.." to whitelist"})
        else
            Rayfield:Notify({Title="Whitelist", Content="Player not found"})
        end
    end
})

WhitelistTab:CreateDropdown({
    Name = "Remove Player from Whitelist",
    Options = WhitelistManager:List(),
    CurrentOption = nil,
    Callback = function(Name)
        WhitelistManager:Remove(Name)
        ESPManager:Refresh(WhitelistManager, targetPlayer)
        Rayfield:Notify({Title="Whitelist", Content="Removed "..Name.." from whitelist"})
    end
})

WhitelistTab:CreateButton({
    Name = "Clear All Whitelisted",
    Callback = function()
        WhitelistManager:Clear()
        ESPManager:Refresh(WhitelistManager, targetPlayer)
        Rayfield:Notify({Title="Whitelist", Content="Whitelist cleared"})
    end
})

WhitelistTab:CreateParagraph({Title="Current Whitelist", Content=function()
    local list = WhitelistManager:List()
    return #list > 0 and table.concat(list, "\n") or "None"
end})

-- Combat/Utility Loops
task.spawn(function()
    while true do
        -- Kill Aura
        if autoKill then
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and not WhitelistManager:IsWhitelisted(player) then
                    if player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
                        KillPlayer(player)
                    end
                end
            end
        elseif targetMode and targetPlayer then
            if targetPlayer ~= LocalPlayer and not WhitelistManager:IsWhitelisted(targetPlayer) then
                if targetPlayer.Character and targetPlayer.Character:FindFirstChild("Humanoid") and targetPlayer.Character.Humanoid.Health > 0 then
                    KillPlayer(targetPlayer)
                end
            end
        end
        wait(0.15)
    end
end)

task.spawn(function()
    while true do
        -- Auto Farm loop
        if autoFarm then
            for _, tool in ipairs(LocalPlayer.Backpack:GetChildren()) do
                if tool:IsA("Tool") then
                    LocalPlayer.Character.Humanoid:EquipTool(tool)
                    wait(0.1)
                    pcall(function() tool:Activate() end)
                end
            end
        end
        wait(0.5)
    end
end)

task.spawn(function()
    while true do
        if godmodeEnabled then
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("Humanoid") then
                char.Humanoid.Health = char.Humanoid.MaxHealth
                if char:FindFirstChild("BreakJointsOnDeath") then
                    char.BreakJointsOnDeath = false
                end
                if char.Humanoid:GetState() == Enum.HumanoidStateType.Dead then
                    char.Humanoid.Health = char.Humanoid.MaxHealth
                end
            end
        end
        wait(0.1)
    end
end)

Rayfield:Notify({Title = "Loaded!", Content = "Advanced Kill GUI (Rayfield Edition) loaded."})
