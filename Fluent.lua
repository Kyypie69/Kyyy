local Library = loadstring(game:HttpGetAsync("https://github.com/ActualMasterOogway/Fluent-Renewed/releases/latest/download/Fluent.luau"))()
local SaveManager = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/ActualMasterOogway/Fluent-Renewed/master/Addons/SaveManager.luau"))()
local InterfaceManager = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/ActualMasterOogway/Fluent-Renewed/master/Addons/InterfaceManager.luau"))()
-- 🏠 Creation
local Window = Library:CreateWindow{
    Title = "Muscle Legends | KYY HUB",
    SubTitle = "AI GENERATED",
    TabWidth = 125,
    Size = UDim2.fromOffset(600, 325),
    Resize = false,
    Acrylic = true,
    Theme = "Viow Neon",
    MinimizeKey = Enum.KeyCode.RightControl
}local Tabs = {
	Main = Window:CreateTab{
		Title = "Killing Machine",
		Icon = "phosphor-users-bold"
	}
}
        
-- ======================================================================
--  MUSCLE LEGENDS – AUTO-KILL & SPY
-- ======================================================================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Muscle Legends remotes we need
local PunchEvent = ReplicatedStorage:WaitForChild("Events"):WaitForChild("Punch")
local TrainEvent = ReplicatedStorage:WaitForChild("Events"):WaitForChild("Training") -- used to refresh strength

local killAllLoop, killTargetLoop, spyLoop
local targetDropdown
local espHighlight

------------------------------------------------------------------------
-- Helper: kill a player with the legit punch remote
------------------------------------------------------------------------
local function muscleKill(victim)
    if not victim.Character then return end
    -- make sure we have a valid humanoid root part
    local root = victim.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end

    -- fire punch remote 5 times (insta-ko in most cases)
    for i = 1, 5 do
        PunchEvent:FireServer(victim.Character.Humanoid, root.CFrame.Position)
    end
end

------------------------------------------------------------------------
-- Auto-Kill ALL
------------------------------------------------------------------------
local function startKillAll()
    if killAllLoop then return end
    killAllLoop = RunService.Heartbeat:Connect(function()
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer then
                muscleKill(plr)
            end
        end
    end)
end
local function stopKillAll()
    if killAllLoop then killAllLoop:Disconnect(); killAllLoop = nil end
end

------------------------------------------------------------------------
-- Auto-Kill TARGET
------------------------------------------------------------------------
local function startKillTarget()
    if killTargetLoop then return end
    killTargetLoop = RunService.Heartbeat:Connect(function()
        local victim = targetDropdown and Players:FindFirstChild(targetDropdown.Value)
        if victim then muscleKill(victim) end
    end)
end
local function stopKillTarget()
    if killTargetLoop then killTargetLoop:Disconnect(); killTargetLoop = nil end
end

------------------------------------------------------------------------
-- Spy Player (teleport behind + highlight)
------------------------------------------------------------------------
local function startSpy()
    if spyLoop then return end
    espHighlight = Instance.new("Highlight")
    espHighlight.Name = "MLSpy"
    espHighlight.FillTransparency = .5
    espHighlight.OutlineTransparency = 0
    espHighlight.FillColor = Color3.fromRGB(0, 255, 140)

    spyLoop = RunService.Heartbeat:Connect(function()
        local target = targetDropdown and Players:FindFirstChild(targetDropdown.Value)
        if not target or not target.Character then espHighlight.Parent = nil; return end
        local root = target.Character:FindFirstChild("HumanoidRootPart")
        if not root then return end

        -- teleport 5 studs behind
        local behind = root.CFrame * CFrame.new(0, 0, 5)
        LocalPlayer.Character:PivotTo(behind)

        -- camera look-at
        workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, root.Position)

        espHighlight.Parent = target.Character
    end)
end
local function stopSpy()
    if spyLoop then spyLoop:Disconnect(); spyLoop = nil end
    if espHighlight then espHighlight.Parent = nil end
end

------------------------------------------------------------------------
-- GUI controls
------------------------------------------------------------------------
-- 1) Target picker dropdown
targetDropdown = Tabs.Main:AddDropdown("TargetDropdown", {
    Title   = "Select Target",
    Values  = {},
    Default = 1,
    Multi   = false
})
local function refreshDropdown()
    local names = {}
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then table.insert(names, plr.Name) end
    end
    targetDropdown:SetValues(names)
    if #names > 0 then targetDropdown:SetValue(names[1]) end
end
refreshDropdown()
Players.PlayerAdded:Connect(refreshDropdown)
Players.PlayerRemoving:Connect(refreshDropdown)

-- 2) Toggles
Tabs.Main:AddToggle("KillAll", {
    Title       = "Auto-Kill All",
    Default     = false,
    Description = "Loop-KO everyone in the server"
}):OnChanged(function(v) if v then startKillAll() else stopKillAll() end end)

Tabs.Main:AddToggle("KillTarget", {
    Title       = "Auto-Kill Target",
    Default     = false,
    Description = "Loop-KO selected player"
}):OnChanged(function(v) if v then startKillTarget() else stopKillTarget() end end)

Tabs.Main:AddToggle("SpyPlayer", {
    Title       = "Spy Player",
    Default     = false,
    Description = "Teleport behind + ESP on selected player"
}):OnChanged(function(v) if v then startSpy() else stopSpy() end end)
