-- Elerium v2 UI Library Implementation
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/memejames/elerium-v2-ui-library//main/Library", true))()
local Players               = game:GetService("Players")
local RunService            = game:GetService("RunService")
local StarterGui            = game:GetService("StarterGui")

type Player                 = Player
type Character              = Model
type Humanoid               = Humanoid
type Tool                   = Tool
type Camera                 = Camera
type ModuleScript           = ModuleScript

----------------------------------------------------------------------
-- 2.  SINGLETON STATE CONTAINER (the ONLY global we expose)
----------------------------------------------------------------------
local Killer                = {}
_G.Killer                   = Killer        -- safe, namespaced global

----------------------------------------------------------------------
-- 3.  CONFIG
----------------------------------------------------------------------
local CONFIG = {
    KILL_COOLDOWN           = 0.05,
    AUTO_KILL_ALL_RATE      = 0.2,
    AUTO_KILL_TARGET_RATE   = 0.1,
    CHARACTER_LOAD_TIMEOUT  = 5,
}

----------------------------------------------------------------------
-- 4.  STATE
----------------------------------------------------------------------
Killer.Whitelisted          = {}            :: { string }
Killer.Target               = ""            :: string            -- "Name (Display)"
Killer.AutoKillAll          = false
Killer.AutoKillTarget       = false
Killer.AutoWhitelistFriends = false

----------------------------------------------------------------------
-- 5.  UTILITIES
----------------------------------------------------------------------
local LocalPlayer = Players.LocalPlayer

-- wait for character with timeout
local function waitForCharacter(who: Player): Character?
    if who.Character and who.Character:FindFirstChild("HumanoidRootPart") then
        return who.Character
    end
    local start = tick()
    repeat task.wait(0.1) until (who.Character and who.Character:FindFirstChild("HumanoidRootPart"))
        or tick() - start > CONFIG.CHARACTER_LOAD_TIMEOUT
    return who.Character
end

-- simple notification
local function notify(title: string, text: string, dur: number?): ()
    StarterGui:SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = dur or 3
    })
end

----------------------------------------------------------------------
-- 6.  TOOL / KILL LOGIC
----------------------------------------------------------------------
local function equipPunch(): ()
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local human: Humanoid? = char:FindFirstChildOfClass("Humanoid")
    if not human then return end

    for _, t in LocalPlayer.Backpack:GetChildren() do
        if t.Name == "Punch" and t:IsA("Tool") then
            human:EquipTool(t)
            break
        end
    end

    -- fire events
    local muscle = LocalPlayer:FindFirstChild("muscleEvent")
    if muscle then
        muscle:FireServer("punch", "leftHand")
        muscle:FireServer("punch", "rightHand")
    end
end

local function killVictim(victim: Player): ()
    local myChar = waitForCharacter(LocalPlayer)           :: Character?
    local vicChar = waitForCharacter(victim)               :: Character?
    if not myChar or not vicChar then return end

    local root = vicChar:FindFirstChild("HumanoidRootPart"):: BasePart?
    local left = myChar:FindFirstChild("LeftHand")         :: BasePart?
    if not root or not left then return end

    -- touch kill
    task.spawn(function()
        pcall(function()
            firetouchinterest(root, left, 0)
            task.wait(0.01)
            firetouchinterest(root, left, 1)
            equipPunch()
        end)
    end)
end

----------------------------------------------------------------------
-- 7.  PLAYER SEARCH
----------------------------------------------------------------------
local function findPlayer(input: string): Player?
    if not input or input == "" then return nil end
    input = input:lower()
    local best: Player? = nil
    local bestScore = 0

    for _, p in Players:GetPlayers() do
        if p == LocalPlayer then continue end
        local u = p.Name:lower()
        local d = p.DisplayName:lower()

        local function score(str: string): number
            local idx = str:find(input, 1, true)
            if not idx then return 0 end
            local s = (#input / #str) * 100
            if idx == 1 then s += 50 end
            return s
        end

        local s = math.max(score(u), score(d))
        if s > bestScore then
            bestScore = s
            best = p
        end
    end
    return bestScore > 20 and best or nil
end

----------------------------------------------------------------------
-- 8.  FRIEND WHITELIST
----------------------------------------------------------------------
local function refreshFriendWhitelist(): ()
    if not Killer.AutoWhitelistFriends then return end
    for _, p in Players:GetPlayers() do
        if p == LocalPlayer then continue end
        if p:IsFriendsWith(LocalPlayer.UserId) then
            local id = p.Name .. " (" .. p.DisplayName .. ")"
            if not table.find(Killer.Whitelisted, id) then
                table.insert(Killer.Whitelisted, id)
            end
        end
    end
end

Players.PlayerAdded:Connect(function(p: Player)
    if Killer.AutoWhitelistFriends and p:IsFriendsWith(LocalPlayer.UserId) then
        local id = p.Name .. " (" .. p.DisplayName .. ")"
        if not table.find(Killer.Whitelisted, id) then
            table.insert(Killer.Whitelisted, id)
        end
    end
end)

----------------------------------------------------------------------
-- 9.  UI CONSTRUCTION (assumes your UI lib has :AddLabel, :AddSwitch, etc.)
----------------------------------------------------------------------
-- Replace these thin wrappers with your actual UI-lib calls.
local UI do
    local tab = {}     -- mock table that mimics your lib
    function tab:AddLabel(text: string)
        return { Text = text }   -- return object so we can edit .Text later
    end
    function tab:AddSwitch(text: string, fn: (boolean)->())
        -- create real switch here
    end
    function tab:AddTextBox(placeholder: string, fn: (string)->())
        -- create real box here
    end
    function tab:AddButton(text: string, fn: ()->())
        -- create real button here
    end
    function tab:AddDropdown(name: string, fn: (string)->())
        -- create real dropdown here
        return { Clear = function() end, Add = function() end }
    end
    UI = tab
end

local wlLabel   = UI:AddLabel("Whitelisted Players: None")
local tgtLabel  = UI:AddLabel("Target Player: None")

local function updateWL()
    if #Killer.Whitelisted == 0 then
        wlLabel.Text = "Whitelisted Players: None"
    else
        wlLabel.Text = "Whitelisted: " .. table.concat(Killer.Whitelisted, ", ")
    end
end

local function updateTgt()
    tgtLabel.Text = Killer.Target == "" and "Target Player: None"
                                         or  "Target Player: " .. Killer.Target
end

----------------------------------------------------------------------
-- 10.  AUTO-KILL LOOPS
----------------------------------------------------------------------
-- Kill-all loop
RunService.Heartbeat:Connect(function()
    if not Killer.AutoKillAll then return end
    for _, p in Players:GetPlayers() do
        if p == LocalPlayer then continue end
        -- check whitelist
        local safe = false
        for _, id in Killer.Whitelisted do
            if id:find(p.Name, 1, true) then safe = true; break end
        end
        if safe then continue end
        -- kill
        killVictim(p)
        task.wait(CONFIG.KILL_COOLDOWN)
    end
    task.wait(CONFIG.AUTO_KILL_ALL_RATE)
end)

-- Kill-target loop
RunService.Heartbeat:Connect(function()
    if not Killer.AutoKillTarget or Killer.Target == "" then return end
    local name = Killer.Target:match("^([^%(]+)"):: string?
    if not name then return end
    name = name:gsub("%s+$", "")
    local p = Players:FindFirstChild(name)
    if p then killVictim(p) end
    task.wait(CONFIG.AUTO_KILL_TARGET_RATE)
end)

----------------------------------------------------------------------
-- 11.  SPECTATE
----------------------------------------------------------------------
local function spectate()
    if Killer.Target == "" then return end
    local name = Killer.Target:match("^([%w_]+)"):: string?
    local p = name and Players:FindFirstChild(name)
    local hum = p and p.Character and p.Character:FindFirstChildOfClass("Humanoid")
    if hum then workspace.CurrentCamera.CameraSubject = hum end
end

local function unspectate()
    local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if hum then workspace.CurrentCamera.CameraSubject = hum end
end

----------------------------------------------------------------------
-- 12.  FINAL UI WIRING
----------------------------------------------------------------------
UI:AddSwitch("Auto-whitelist friends", function(on: boolean)
    Killer.AutoWhitelistFriends = on
    if on then refreshFriendWhitelist(); updateWL() end
end)

UI:AddTextBox("Add to whitelist (name)", function(txt: string)
    local p = findPlayer(txt)
    if not p then notify("Not found", "No player matches '" .. txt .. "'") return end
    local id = p.Name .. " (" .. p.DisplayName .. ")"
    if table.find(Killer.Whitelisted, id) then notify("Already whitelisted", "") return end
    table.insert(Killer.Whitelisted, id)
    updateWL()
end)

UI:AddTextBox("Remove from whitelist", function(txt: string)
    txt = txt:lower()
    for i, v in Killer.Whitelisted do
        if v:lower():find(txt, 1, true) then
            table.remove(Killer.Whitelisted, i)
            updateWL()
            notify("Removed", v)
            return
        end
    end
    notify("Not found", "No matching whitelist entry")
end)

UI:AddButton("Clear whitelist", function()
    Killer.Whitelisted = {}
    updateWL()
end)

UI:AddSwitch("Auto-kill everyone (except whitelist)", function(on: boolean)
    Killer.AutoKillAll = on
end)

UI:AddSwitch("Auto-kill target", function(on: boolean)
    Killer.AutoKillTarget = on
end)

UI:AddButton("View target", spectate)
UI:AddButton("Stop spectating", unspectate)

-- dropdown population (stub – wire to your real dropdown)
local function rebuildDropdown()
    -- collect choices
    local choices = {}
    local map = {}
    for _, p in Players:GetPlayers() do
        if p == LocalPlayer then continue end
        local show = (p.DisplayName ~= p.Name)
                and ("%s  (@%s)"):format(p.DisplayName, p.Name)
                or  p.Name
        table.insert(choices, show)
        map[show] = p
    end
    -- update your dropdown here
    -- dropdown:Clear(); for _, c in choices do dropdown:Add(c) end
end
Players.PlayerAdded:Connect(rebuildDropdown)
Players.PlayerRemoving:Connect(rebuildDropdown)
rebuildDropdown()

notify("Killer loaded", "UI ready – have fun!")
