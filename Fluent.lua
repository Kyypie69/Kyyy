local Library = loadstring(game:HttpGetAsync("https://github.com/ActualMasterOogway/Fluent-Renewed/releases/latest/download/Fluent.luau"))()
local SaveManager = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/ActualMasterOogway/Fluent-Renewed/master/Addons/SaveManager.luau"))()
local InterfaceManager = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/ActualMasterOogway/Fluent-Renewed/master/Addons/InterfaceManager.luau"))()
--------------------------------------------------------------------
-- 1.  Quick refs
--------------------------------------------------------------------
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local VirtualUser = game:GetService("VirtualUser")
local LocalPlayer = Players.LocalPlayer
local RS = game:GetService("ReplicatedStorage")

local PunchEvent = RS:WaitForChild("Events"):WaitForChild("Punch")
local TrainEvent = RS:WaitForChild("Events"):WaitForChild("Training")

--------------------------------------------------------------------
-- 2.  Window
--------------------------------------------------------------------
local Window = Library:CreateWindow({
    Title = "Muscle Legends | KYY HUB",
    SubTitle = "Renewed Edition",
    TabWidth = 130,
    Size = UDim2.fromOffset(620, 400),
    Resize = false,
    Acrylic = true,
    Theme = "Viow Neon",
    MinimizeKey = Enum.KeyCode.RightControl
})

local Tabs = {
    Killer = Window:CreateTab({ Title = "Combat",   Icon = "phosphor-sword-bold" }),
    Visual = Window:CreateTab({ Title = "Visuals",  Icon = "phosphor-eye-bold" }),
    Misc   = Window:CreateTab({ Title = "Misc",     Icon = "phosphor-gear-bold" }),
    Config = Window:CreateTab({ Title = "Settings", Icon = "phosphor-floppy-disk-bold" })
}

--------------------------------------------------------------------
-- 3.  State
--------------------------------------------------------------------
local Loops = {
    killAll   = nil,
    killTarg  = nil,
    spy       = nil,
    stamina   = nil,
    afk       = nil,
    fly       = nil
}

local Highlights = {}         -- player → Highlight
local FlyParts = {}           -- noclip bricks
local PanicDebounce = false

--------------------------------------------------------------------
-- 4.  Helpers
--------------------------------------------------------------------
local function notify(msg) Fluent:Notify({ Title = "KYY", Content = msg, Duration = 3 }) end

local function muscleKill(victim)
    if not victim.Character then return end
    local root = victim.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end
    for _ = 1, 5 do PunchEvent:FireServer(victim.Character.Humanoid, root.CFrame.Position) end
end

local function getTarget(name) return name and Players:FindFirstChild(name) end

local function safeTeleport(cf)
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    char:PivotTo(cf)
end

--------------------------------------------------------------------
-- 5.  Combat tab
--------------------------------------------------------------------
local KillerS = Tabs.Killer:CreateSection("Killing")
local targetDropdown = Tabs.Killer:AddDropdown("Target", {
    Title = "Select Target", Values = {}, Multi = false
})
local function refreshTargets()
    local t = {}
    for _, p in ipairs(Players:GetPlayers()) do if p ~= LocalPlayer then table.insert(t, p.Name) end end
    targetDropdown:SetValues(t)
    if #t > 0 then targetDropdown:SetValue(t[1]) end
end
refreshTargets()
Players.PlayerAdded:Connect(refreshTargets)
Players.PlayerRemoving:Connect(refreshTargets)

Tabs.Killer:CreateToggle("KillAll", {
    Title = "Auto-Kill All", Default = false
}):OnChanged(function(v)
    if v then
        Loops.killAll = RunService.Heartbeat:Connect(function()
            for _, p in ipairs(Players:GetPlayers()) do if p ~= LocalPlayer then muscleKill(p) end end
        end)
    else
        if Loops.killAll then Loops.killAll:Disconnect(); Loops.killAll = nil end
    end
end)

Tabs.Killer:CreateToggle("KillTarget", {
    Title = "Auto-Kill Target", Default = false
}):OnChanged(function(v)
    if v then
        Loops.killTarg = RunService.Heartbeat:Connect(function()
            muscleKill(getTarget(targetDropdown.Value))
        end)
    else
        if Loops.killTarg then Loops.killTarg:Disconnect(); Loops.killTarg = nil end
    end
end)

--------------------------------------------------------------------
-- 6.  Spy
--------------------------------------------------------------------
Tabs.Killer:CreateToggle("Spy", {
    Title = "Spy Target", Default = false
}):OnChanged(function(v)
    if v then
        Loops.spy = RunService.Heartbeat:Connect(function()
            local t = getTarget(targetDropdown.Value)
            if not (t and t.Character) then return end
            local root = t.Character:FindFirstChild("HumanoidRootPart")
            if not root then return end
            safeTeleport(root.CFrame * CFrame.new(0, 0, 5))
            workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, root.Position)
            if not Highlights[t] then
                local h = Instance.new("Highlight")
                h.FillColor = Color3.fromRGB(0, 255, 140)
                h.Parent = t.Character
                Highlights[t] = h
            end
        end)
    else
        if Loops.spy then Loops.spy:Disconnect(); Loops.spy = nil end
        for _, h in pairs(Highlights) do h:Destroy() end; table.clear(Highlights)
    end
end)

--------------------------------------------------------------------
-- 7.  Visuals tab
--------------------------------------------------------------------
local VisualS = Tabs.Visual:CreateSection("ESP")
local espColour = Color3.fromRGB(255, 255, 0)
local espDistance = 250
local espToggle = Tabs.Visual:CreateToggle("ESP", {
    Title = "Player ESP", Default = false
})
local espColourPicker = Tabs.Visual:AddColorPicker("ESPClr", {
    Title = "ESP Colour", Default = espColour
})
espColourPicker:OnChanged(function(c) espColour = c end)
local espDistSlider = Tabs.Visual:AddSlider("ESPDist", {
    Title = "Max Distance", Default = 250, Min = 50, Max = 5000, Rounded = false
})
espDistSlider:OnChanged(function(v) espDistance = v end)

local espLoop
espToggle:OnChanged(function(v)
    if v then
        espLoop = RunService.Heartbeat:Connect(function()
            for _, p in ipairs(Players:GetPlayers()) do
                if p == LocalPlayer then continue end
                local char = p.Character
                if not char then continue end
                local root = char:FindFirstChild("HumanoidRootPart")
                if not root then continue end
                if (root.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > espDistance then
                    if Highlights[p] then Highlights[p]:Destroy(); Highlights[p] = nil end
                    continue
                end
                if not Highlights[p] then
                    local h = Instance.new("Highlight")
                    h.FillColor = espColour
                    h.Parent = char
                    Highlights[p] = h
                else
                    Highlights[p].FillColor = espColour
                end
            end
        end)
    else
        if espLoop then espLoop:Disconnect(); espLoop = nil end
        for _, h in pairs(Highlights) do h:Destroy() end; table.clear(Highlights)
    end
end)

--------------------------------------------------------------------
-- 8.  Misc tab
--------------------------------------------------------------------
local MiscS = Tabs.Misc:CreateSection("Movement")
local flySpeed = 1
local flyKey = Enum.KeyCode.F
local noclipToggle = Tabs.Misc:CreateToggle("Noclip", {
    Title = "Noclip / Fly", Default = false
})
local flySpeedSlider = Tabs.Misc:AddSlider("FlySpd", {
    Title = "Fly Speed", Default = 1, Min = 0.2, Max = 5, Rounded = true
})
flySpeedSlider:OnChanged(function(v) flySpeed = v end)

noclipToggle:OnChanged(function(v)
    if v then
        local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        for _, p in ipairs(char:GetDescendants()) do
            if p:IsA("BasePart") and p.CanCollide then
                p.CanCollide = false
                table.insert(FlyParts, p)
            end
        end
        Loops.fly = RunService.Stepped:Connect(function()
            local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if hum then
                local move = Vector3.zero
                if Fluent:IsKeyDown(Enum.KeyCode.W) then move = move + Vector3.zAxis end
                if Fluent:IsKeyDown(Enum.KeyCode.S) then move = move - Vector3.zAxis end
                if Fluent:IsKeyDown(Enum.KeyCode.D) then move = move + Vector3.xAxis end
                if Fluent:IsKeyDown(Enum.KeyCode.A) then move = move - Vector3.xAxis end
                if Fluent:IsKeyDown(Enum.KeyCode.Space) then move = move + Vector3.yAxis end
                if Fluent:IsKeyDown(Enum.KeyCode.LeftShift) then move = move - Vector3.yAxis end
                if move.Magnitude > 0 then
                    LocalPlayer.Character:TranslateBy(move.Unit * flySpeed)
                end
            end
        end)
    else
        if Loops.fly then Loops.fly:Disconnect(); Loops.fly = nil end
        for _, p in ipairs(FlyParts) do p.CanCollide = true end; table.clear(FlyParts)
    end
end)

-- infinite stamina
Tabs.Misc:CreateToggle("Stamina", {
    Title = "Infinite Stamina", Default = false
}):OnChanged(function(v)
    if v then
        Loops.stamina = RunService.Heartbeat:Connect(function()
            TrainEvent:FireServer()
        end)
    else
        if Loops.stamina then Loops.stamina:Disconnect(); Loops.stamina = nil end
    end
end)

-- anti-afk
Loops.afk = LocalPlayer.Idled:Connect(function()
    VirtualUser:CaptureController(); VirtualUser:ClickButton2(Vector2.zero)
end)

-- server hop
Tabs.Misc:CreateButton("ServerHop", {
    Title = "Server Hop"
}):OnClick(function()
    notify("Hopping…")
    TeleportService:Teleport(game.PlaceId)
end)

--------------------------------------------------------------------
-- 9.  Panic
--------------------------------------------------------------------
local PanicPlace = CFrame.new(0, 1000, 0) -- safe void
UserInputService.InputBegan:Connect(function(i, gp)
    if gp then return end
    if i.KeyCode == Enum.KeyCode.RightShift and not PanicDebounce then
        PanicDebounce = true
        notify("PANIC – unloading!")
        -- stop all loops
        for _, c in pairs(Loops) do if c then c:Disconnect() end end
        for _, h in pairs(Highlights) do h:Destroy() end
        safeTeleport(PanicPlace)
        Window:Destroy()
        script:Destroy()
    end
end)

--------------------------------------------------------------------
-- 10.  Settings tab
--------------------------------------------------------------------
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})
InterfaceManager:SetFolder("KYY_Hub")
SaveManager:SetFolder("KYY_Hub/muscle-legends")
Tabs.Config:CreateButton("SaveCfg", { Title = "Save Settings" }):OnClick(function() SaveManager:Save() notify("Saved!") end)
Tabs.Config:CreateButton("LoadCfg", { Title = "Load Settings" }):OnClick(function() SaveManager:Load() notify("Loaded!") end)
InterfaceManager:BuildInterfaceSection(Tabs.Config, "Themes", "UI")

--------------------------------------------------------------------
-- 11.  Finalise
--------------------------------------------------------------------
SaveManager:Load() -- auto-load last config
notify("KYY Hub loaded – Right-Shift to panic!")
