local LIB_URL = "https://raw.githubusercontent.com/Kyypie69/Library.UI/refs/heads/main/KyypieUI.lua"


-- Attempt to load the remote library
local ok, a, b, c = pcall(function()
	local source = game:HttpGet(LIB_URL)
	local fn = loadstring(source)
	return fn()
end)

local Library, SaveManager, InterfaceManager
if ok then
	Library, SaveManager, InterfaceManager = a, b, c
else
	if getgenv and getgenv().Fluent then
		Library = getgenv().Fluent
		warn("Loaded library from getgenv().Fluent as fallback.")
	else
		error("Failed to load UI library from URL: " .. tostring(a))
	end
end

local Window = Library:CreateWindow({
	Title = " KYY HUB ",
	SubTitle = "Version 6.9 | by Markyy",
	Size = UDim2.fromOffset(500, 335),
	TabWidth = 150,
	Theme = "Blurple",
	Acrylic = false,
})


-- TABS
local Home = Window:AddTab({ Title = "Home / Packs", Icon = "home" })
local farmingTab = Window:AddTab({ Title = "Farming", Icon = "leaf" })
local Rebirths = Window:AddTab({ Title = "Rebirths", Icon = "repeat" })
local Killer = Window:AddTab({ Title = "Killer", Icon = "skull" })
local Shop = Window:AddTab({ Title = "Crystals", Icon = "shopping-cart" })
local Misc = Window:AddTab({ Title = "Miscellaneous", Icon = "menu" })
local Settings = Window:AddTab({ Title = "save", Icon = "" })

Home:AddButton({
    Title = "KYYY Discord Link | Press to Copy |",
    Callback = function()
        setclipboard("https://discord.gg/SZQhNQpC")
        Library:Notify({
            Title = "Copied!",
            Content = "Discord link copied to clipboard.",
            Duration = 3
        })
    end
})


local selectedSpeed = 125

Home:AddInput("SpeedInput", {
	Title = "Speed",
	Default = "125",
	Placeholder = "Enter Speed...",
	Callback = function(val)
		selectedSpeed = tonumber(val) or 125
		if getgenv().AutoSpeed and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
			game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = selectedSpeed
		end
	end,
})

Home:AddToggle("AutoSpeed", {
	Title = "Set Speed",
	Default = false,
	Callback = function(state)
		getgenv().AutoSpeed = state
		while getgenv().AutoSpeed do
			if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
				game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = selectedSpeed
			end
			task.wait()
		end
	end,
})

game.Players.LocalPlayer.CharacterAdded:Connect(function(char)
	if getgenv().AutoSpeed then
		local humanoid = char:WaitForChild("Humanoid")
		humanoid.WalkSpeed = selectedSpeed
	end
end)

-- Size changer
local selectedSize = 2

Home:AddInput("SizeInput", {
	Title = "Size",
	Default = "2",
	Placeholder = "Enter Size...",
	Callback = function(val)
		selectedSize = tonumber(val) or 2
		if getgenv().AutoSize then
			game:GetService("ReplicatedStorage").rEvents.changeSpeedSizeRemote:InvokeServer("changeSize", selectedSize)
		end
	end,
})

Home:AddToggle("AutoSize", {
	Title = "Set Size",
	Default = false,
	Callback = function(state)
		getgenv().AutoSize = state
		while getgenv().AutoSize do
			game:GetService("ReplicatedStorage").rEvents.changeSpeedSizeRemote:InvokeServer("changeSize", selectedSize)
			task.wait(0.1)
		end
	end,
})

-- Anti-AFK
local antiAFKEnabled = true
local antiAFKConnection

local function setupAntiAFK()
	if antiAFKConnection then return end
	local vu = game:GetService("VirtualUser")
	antiAFKConnection = game.Players.LocalPlayer.Idled:Connect(function()
		vu:Button2Down(Vector2.new(), workspace.CurrentCamera.CFrame)
		task.wait(1)
		vu:Button2Up(Vector2.new(), workspace.CurrentCamera.CFrame)
	end)
end

if antiAFKEnabled then
	setupAntiAFK()
end

Home:AddToggle("AntiAFK", {
	Title = "Anti AFK",
	Default = true,
	Callback = function(bool)
		antiAFKEnabled = bool
		if bool then
			setupAntiAFK()
		else
			if antiAFKConnection then
				antiAFKConnection:Disconnect()
				antiAFKConnection = nil
			end
		end
	end,
})

-- Walk on Water
local parts = {}
local partSize = 2048
local totalDistance = 50000
local startPosition = Vector3.new(-2, -9.5, -2)
local numberOfParts = math.ceil(totalDistance / partSize)

local function createParts()
	for x = 0, numberOfParts - 1 do
		for z = 0, numberOfParts - 1 do
			local positions = {
				Vector3.new(x, 0, z),
				Vector3.new(-x, 0, z),
				Vector3.new(-x, 0, -z),
				Vector3.new(x, 0, -z),
			}
			for _, offset in ipairs(positions) do
				local p = Instance.new("Part")
				p.Size = Vector3.new(partSize, 1, partSize)
				p.Position = startPosition + Vector3.new(offset.X * partSize, offset.Y, offset.Z * partSize)
				p.Anchored = true
				p.Transparency = 1
				p.CanCollide = true
				p.Parent = workspace
				table.insert(parts, p)
			end
		end
	end
end

local function makePartsWalkthrough()
	for _, p in ipairs(parts) do
		if p and p.Parent then p.CanCollide = false end
	end
end

Home:AddToggle("WalkOnWater", {
	Title = "Walk On Water",
	Default = false,
	Callback = function(state)
		if state then
			createParts()
		else
			makePartsWalkthrough()
		end
	end,
})

-- Hide Pets
Home:AddToggle("HidePets", {
	Title = "Hide Pets",
	Default = false,
	Callback = function(state)
		local event = game:GetService("ReplicatedStorage").rEvents.showPetsEvent
		if state then
			event:FireServer("hidePets")
		else
			event:FireServer("showPets")
		end
	end,
})

-- Disable Trades
Home:AddToggle("DisableTrades", {
	Title = "Disable Trades",
	Default = false,
	Callback = function(state)
		local event = game:GetService("ReplicatedStorage").rEvents.tradingEvent
		if state then
			event:FireServer("disableTrading")
		else
			event:FireServer("enableTrading")
		end
	end,
})

-- Infinite Jump
local infJumpEnabled = false
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

player.CharacterAdded:Connect(function(char)
	character = char
	humanoid = char:WaitForChild("Humanoid")
end)

game:GetService("UserInputService").JumpRequest:Connect(function()
	if infJumpEnabled and humanoid then
		humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
	end
end)

Home:AddToggle("InfJump", {
	Title = "Infinite Jump",
	Default = false,
	Callback = function(state)
		infJumpEnabled = state
	end,
})

-- Noclip
Home:AddToggle("NoClip", {
	Title = "No Clip",
	Default = false,
	Callback = function(state)
		_G.NoClip = state
		if state then
			local conn
			conn = game:GetService("RunService").Stepped:Connect(function()
				if _G.NoClip then
					for _, part in pairs(player.Character:GetDescendants()) do
						if part:IsA("BasePart") then part.CanCollide = false end
					end
				else
					conn:Disconnect()
				end
			end)
		end
	end,
})

-- Anti Knockback
Home:AddToggle("AntiKnockback", {
	Title = "Anti Knockback",
	Default = false,
	Callback = function(state)
		local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
		if not root then return end
		if state then
			local bv = Instance.new("BodyVelocity")
			bv.MaxForce = Vector3.new(100000, 0, 100000)
			bv.Velocity = Vector3.new(0, 0, 0)
			bv.P = 1250
			bv.Parent = root
		else
			local bv = root:FindFirstChildOfClass("BodyVelocity")
			if bv then bv:Destroy() end
		end
	end,
})

-- Lock Position
Home:AddToggle("LockPosition", {
	Title = "Lock Position",
	Default = false,
	Callback = function(state)
		if state then
			local currentPos = player.Character.HumanoidRootPart.CFrame
			getgenv().posLock = game:GetService("RunService").Heartbeat:Connect(function()
				if player.Character:FindFirstChild("HumanoidRootPart") then
					player.Character.HumanoidRootPart.CFrame = currentPos
				end
			end)
		else
			if getgenv().posLock then
				getgenv().posLock:Disconnect()
				getgenv().posLock = nil
			end
		end
	end,
})

--// Player & Stats
local player = game.Players.LocalPlayer
local leaderstats = player:WaitForChild("leaderstats")
local strengthStat = leaderstats:WaitForChild("Strength")
local rebirthsStat = leaderstats:WaitForChild("Rebirths")
local durabilityStat = player:WaitForChild("Durability")
local killsStat = leaderstats:WaitForChild("Kills")
local agilityStat = player:WaitForChild("Agility")
local evilKarmaStat = player:WaitForChild("evilKarma")
local goodKarmaStat = player:WaitForChild("goodKarma")
local brawlsStat = leaderstats:WaitForChild("Brawls")

--// Helper function
local function AbbrevNumber(num)
    local abbrev = {"", "K", "M", "B", "T", "Qa", "Qi"}
    local i = 1
    while num >= 1000 and i < #abbrev do
        num = num / 1000
        i = i + 1
    end
    return string.format("%.2f%s", num, abbrev[i])
end

--// GUI Creation
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")
screenGui.Name = "StatsUI"
screenGui.Enabled = false -- start hidden

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 500, 0, 350)
mainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

-- Draggable title bar
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 30)
titleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
titleBar.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 1, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Session Stats"
titleLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.TextSize = 20
titleLabel.Parent = titleBar

mainFrame.Active = true
mainFrame.Draggable = true

-- Scrollable container
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, 0, 1, -30)
scrollFrame.Position = UDim2.new(0, 0, 0, 30)
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollFrame.ScrollBarThickness = 8
scrollFrame.BackgroundTransparency = 1
scrollFrame.Parent = mainFrame

local uiListLayout = Instance.new("UIListLayout")
uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
uiListLayout.Padding = UDim.new(0, 5)
uiListLayout.Parent = scrollFrame

--// Add Labels helper
local function AddLabel(text, textSize)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -10, 0, textSize + 5)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(0, 255, 0)
    label.Font = Enum.Font.SourceSans
    label.TextSize = textSize
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = scrollFrame
    return label
end

--// Add Button helper
local function AddButton(text, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -10, 0, 30)
    button.BackgroundColor3 = Color3.fromRGB(0, 50, 0)
    button.TextColor3 = Color3.fromRGB(0, 255, 0)
    button.Font = Enum.Font.SourceSansBold
    button.TextSize = 18
    button.Text = text
    button.Parent = scrollFrame
    button.MouseButton1Click:Connect(callback)
    return button
end

--// Create UI
AddLabel("⏱️ Session Statistics", 24)
local stopwatchLabel = AddLabel("Start Time: 0d 0h 0m 0s", 18)
local customTimerLabel = AddLabel("Timer: Not started", 18)

local isCustomRunning = false
local customStart = 0
local customElapsed = 0

AddButton("Start/Stop Timer", function()
    if not isCustomRunning then
        isCustomRunning = true
        customStart = tick() - customElapsed
    else
        isCustomRunning = false
        customElapsed = tick() - customStart
    end
end)

AddButton("Reset Timer", function()
    isCustomRunning = false
    customStart = 0
    customElapsed = 0
    customTimerLabel.Text = "Custom Timer: Not started"
end)

local resetSession = false
AddButton("Reset Session Stats", function()
    resetSession = true
end)

AddLabel("------------------", 14)
AddLabel("Projected Stats", 24)
local projectedStrengthLabel = AddLabel("Strength Pace: -", 18)
local projectedDurabilityLabel = AddLabel("Durability Pace: -", 18)
local projectedRebirthsLabel = AddLabel("Rebirth Pace: -", 18)

AddLabel("------------------", 14)
AddLabel("Leaderboard Stats", 24)
local strengthLabel = AddLabel("Strength: -", 18)
local rebirthsLabel = AddLabel("Rebirths: -", 18)
local killsLabel = AddLabel("Kills: -", 18)
local brawlsLabel = AddLabel("Brawls: -", 18)

AddLabel("------------------", 14)
AddLabel("Player Stats", 24)
local goodKarmaLabel = AddLabel("Good Karma: -", 18)
local evilKarmaLabel = AddLabel("Evil Karma: -", 18)
local durabilityLabel = AddLabel("Durability: -", 18)
local agilityLabel = AddLabel("Agility: -", 18)

--// Initial Stats
local startTime = tick()
local initialStrength = strengthStat.Value
local initialDurability = durabilityStat.Value
local initialRebirths = rebirthsStat.Value
local initialKills = killsStat.Value
local initialAgility = agilityStat.Value
local initialEvilKarma = evilKarmaStat.Value
local initialGoodKarma = goodKarmaStat.Value
local initialBrawls = brawlsStat.Value

--// Update loop
task.spawn(function()
    local lastUpdate = 0
    while task.wait(0.2) do
        local elapsedTime = tick() - startTime
        local days = math.floor(elapsedTime / (24 * 3600))
        local hours = math.floor((elapsedTime % (24 * 3600)) / 3600)
        local minutes = math.floor((elapsedTime % 3600) / 60)
        local seconds = math.floor(elapsedTime % 60)
        stopwatchLabel.Text = string.format("Session Time: %dd %dh %dm %ds", days, hours, minutes, seconds)

        if isCustomRunning then
            customElapsed = tick() - customStart
        end
        if customElapsed > 0 then
            local d = math.floor(customElapsed / (24 * 3600))
            local h = math.floor((customElapsed % (24 * 3600)) / 3600)
            local m = math.floor((customElapsed % 3600) / 60)
            local s = math.floor(customElapsed % 60)
            customTimerLabel.Text = string.format("Custom Timer: %dd %dh %dm %ds", d, h, m, s)
        end

        if resetSession then
            startTime = tick()
            initialStrength = strengthStat.Value
            initialDurability = durabilityStat.Value
            initialRebirths = rebirthsStat.Value
            initialKills = killsStat.Value
            initialAgility = agilityStat.Value
            initialEvilKarma = evilKarmaStat.Value
            initialGoodKarma = goodKarmaStat.Value
            initialBrawls = brawlsStat.Value
            resetSession = false
        end

        local cStr = strengthStat.Value
        local cReb = rebirthsStat.Value
        local cDur = durabilityStat.Value
        local cKills = killsStat.Value
        local cAgi = agilityStat.Value
        local cEvil = evilKarmaStat.Value
        local cGood = goodKarmaStat.Value
        local cBrawl = brawlsStat.Value

        local dStr = cStr - initialStrength
        local dDur = cDur - initialDurability
        local dReb = cReb - initialRebirths
        local dKills = cKills - initialKills
        local dAgi = cAgi - initialAgility
        local dEvil = cEvil - initialEvilKarma
        local dGood = cGood - initialGoodKarma
        local dBrawl = cBrawl - initialBrawls

        strengthLabel.Text = "Strength: " .. AbbrevNumber(cStr) .. " | +" .. AbbrevNumber(dStr)
        rebirthsLabel.Text = "Rebirths: " .. AbbrevNumber(cReb) .. " | +" .. AbbrevNumber(dReb)
        killsLabel.Text = "Kills: " .. AbbrevNumber(cKills) .. " | +" .. AbbrevNumber(dKills)
        brawlsLabel.Text = "Brawls: " .. AbbrevNumber(cBrawl) .. " | +" .. AbbrevNumber(dBrawl)

        goodKarmaLabel.Text = "Good Karma: " .. AbbrevNumber(cGood) .. " | +" .. AbbrevNumber(dGood)
        evilKarmaLabel.Text = "Evil Karma: " .. AbbrevNumber(cEvil) .. " | +" .. AbbrevNumber(dEvil)
        durabilityLabel.Text = "Durability: " .. AbbrevNumber(cDur) .. " | +" .. AbbrevNumber(dDur)
        agilityLabel.Text = "Agility: " .. AbbrevNumber(cAgi) .. " | +" .. AbbrevNumber(dAgi)

        -- projected stats every 6 seconds
        if tick() - lastUpdate >= 6 then
            lastUpdate = tick()
            local sSec = dStr / elapsedTime
            local dSec = dDur / elapsedTime
            local rSec = dReb / elapsedTime

            local h = 3600
            local d = 86400

            projectedStrengthLabel.Text = "Strength Pace: " .. AbbrevNumber(math.floor(sSec * h)) .. "/h | " .. AbbrevNumber(math.floor(sSec * d)) .. "/d"
            projectedDurabilityLabel.Text = "Durability Pace: " .. AbbrevNumber(math.floor(dSec * h)) .. "/h | " .. AbbrevNumber(math.floor(dSec * d)) .. "/d"
            projectedRebirthsLabel.Text = "Rebirth Pace: " .. AbbrevNumber(math.floor(rSec * h)) .. "/h | " .. AbbrevNumber(math.floor(rSec * d)) .. "/d"
        end

        scrollFrame.CanvasSize = UDim2.new(0, 0, 0, uiListLayout.AbsoluteContentSize.Y + 10)
    end
end)

--// Show Stats Toggle
Home:AddToggle("ShowStats", {
    Title = "Show Stats",
    Default = false,
    Callback = function(state)
        screenGui.Enabled = state
    end
})

-- Block Rebirths
Home:AddButton({
	Title = "Block Rebirths",
	Callback = function()
		local old
		old = hookmetamethod(game, "__namecall", function(self, ...)
			local args = { ... }
			if self.Name == "rebirthRemote" and args[1] == "rebirthRequest" then
				return
			end
			return old(self, unpack(args))
		end)
	end,
})

-- Block Trades
Home:AddButton({
	Title = "Block Trades",
	Callback = function()
		game:GetService("ReplicatedStorage").rEvents.tradingEvent:FireServer("disableTrading")
	end,
})

--------------------------------------------------------------------
-- KILLER TAB (All features merged and polished)
--------------------------------------------------------------------
-- Header label
Killer:AddParagraph({
	Title = "Kill Aura",
	Content = "All Killer features: Karma, Whitelist, Auto Kill, Targeting, View Player, Punch Mods, Anim blocking, and recovery.",
})

-- Core variables
local PlayersService = game:GetService("Players")
local LocalPlayer = PlayersService.LocalPlayer
local playerWhitelist = {}
local targetPlayerNames = {}
local autoGoodKarma = false
local autoBadKarma = false
local autoKill = false
local killTarget = false
local spying = false
local autoEquipPunch = false
local autoPunchNoAnim = false
local targetDropdownItems = {}
local availableTargets = {}
local spyTargetName = nil

-- Utility to safely get character parts
local function getRootCharacter(plr)
	if not plr then return nil end
	local c = plr.Character
	if not c then return nil end
	return c:FindFirstChild("HumanoidRootPart")
end

--------------------------------------------------------------------
-- Karma automation section
--------------------------------------------------------------------
Killer:AddToggle("AutoGoodKarma", {
	Title = "Auto Good Karma",
	Default = false,
	Description = "Touch players with more evil than good to increase their good karma.",
	Callback = function(state)
		autoGoodKarma = state
		task.spawn(function()
			while autoGoodKarma do
				local playerChar = LocalPlayer.Character
				local rightHand = playerChar and (playerChar:FindFirstChild("RightHand") or playerChar:FindFirstChild("Right Arm"))
				local leftHand = playerChar and (playerChar:FindFirstChild("LeftHand") or playerChar:FindFirstChild("Left Arm"))
				if playerChar and rightHand and leftHand then
					for _, target in ipairs(PlayersService:GetPlayers()) do
						if target ~= LocalPlayer and not playerWhitelist[target.Name] then
							local evilKarma = target:FindFirstChild("evilKarma")
							local goodKarma = target:FindFirstChild("goodKarma")
							if evilKarma and goodKarma and evilKarma:IsA("IntValue") and goodKarma:IsA("IntValue") and evilKarma.Value > goodKarma.Value then
								local rootPart = getRootCharacter(target)
								if rootPart then
									pcall(function()
										firetouchinterest(rightHand, rootPart, 1)
										firetouchinterest(leftHand, rootPart, 1)
										firetouchinterest(rightHand, rootPart, 0)
										firetouchinterest(leftHand, rootPart, 0)
									end)
								end
							end
						end
					end
				end
				task.wait(0.01)
			end
		end)
	end,
})

Killer:AddToggle("AutoBadKarma", {
	Title = "Auto Bad Karma",
	Default = false,
	Description = "Touch players with more good than evil to build their evil karma.",
	Callback = function(state)
		autoBadKarma = state
		task.spawn(function()
			while autoBadKarma do
				local playerChar = LocalPlayer.Character
				local rightHand = playerChar and (playerChar:FindFirstChild("RightHand") or playerChar:FindFirstChild("Right Arm"))
				local leftHand = playerChar and (playerChar:FindFirstChild("LeftHand") or playerChar:FindFirstChild("Left Arm"))
				if playerChar and rightHand and leftHand then
					for _, target in ipairs(PlayersService:GetPlayers()) do
						if target ~= LocalPlayer and not playerWhitelist[target.Name] then
							local evilKarma = target:FindFirstChild("evilKarma")
							local goodKarma = target:FindFirstChild("goodKarma")
							if evilKarma and goodKarma and evilKarma:IsA("IntValue") and goodKarma:IsA("IntValue") and goodKarma.Value > evilKarma.Value then
								local rootPart = getRootCharacter(target)
								if rootPart then
									pcall(function()
										firetouchinterest(rightHand, rootPart, 1)
										firetouchinterest(leftHand, rootPart, 1)
										firetouchinterest(rightHand, rootPart, 0)
										firetouchinterest(leftHand, rootPart, 0)
									end)
								end
							end
						end
					end
				end
				task.wait(0.01)
			end
		end)
	end,
})

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterPack = game:GetService("StarterPack")
local lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer

-- State & connection tracking
local comboActive = false
local connections = {} -- map keys -> RBXScriptConnection / task.thread
local loops = {} -- store coroutine/thread references to allow safe stopping

local function safeDisconnect(key)
	local conn = connections[key]
	if not conn then return end
	pcall(function()
		if typeof(conn) == "RBXScriptConnection" and conn.Disconnect then
			conn:Disconnect()
		elseif type(conn) == "table" and conn.Disconnect then
			conn:Disconnect()
		end
	end)
	connections[key] = nil
end

local function stopLoops()
	for k, thr in pairs(loops) do
		-- threads are task.spawn threads; we mark them nil and rely on loop checks to exit
		loops[k] = nil
	end
end

local function cleanupAll()
	-- stop global flags
	_G.AutoPunchToggle = false
	_G.AutoProteinEgg = false
	getgenv().AntiFlyActive = false

	-- disconnect connections
	for k, _ in pairs(connections) do
		safeDisconnect(k)
	end
	connections = {}

	-- stop loops
	stopLoops()
end

-- respawn helper
local function respawnPlayer()
	pcall(function()
		if LocalPlayer and LocalPlayer:IsA("Player") then
			-- preferred method
			if pcall(function() LocalPlayer:LoadCharacter() end) then return end
			-- fallback attempt (may not work in exploits)
			pcall(function()
				local StarterGui = game:GetService("StarterGui")
				StarterGui:SetCore("ResetButtonCallback", true)
			end)
		end
	end)
end

-- apply Size NaN (best-effort)
local function applySizeNaN()
	pcall(function()
		local events = ReplicatedStorage:FindFirstChild("rEvents")
		if events then
			local change = events:FindFirstChild("changeSpeedSizeRemote")
			if change and change.InvokeServer then
				pcall(function()
					change:InvokeServer("changeSize", 0/0)
				end)
			end
		end
	end)
end

-- Auto Punch loop
local function startAutoPunch()
	_G.AutoPunchToggle = true
	local id = "AutoPunch"
	loops[id] = true
	task.spawn(function()
		local backpack = LocalPlayer:WaitForChild("Backpack")
		local hand = "rightHand"
		local function getMuscleEvent() return LocalPlayer:FindFirstChild("muscleEvent") end

		-- keep references updated
		safeDisconnect("CharAddedForAutoPunch")
		connections.CharAddedForAutoPunch = LocalPlayer.CharacterAdded:Connect(function(char)
			-- nothing special here; character used via LocalPlayer.Character each loop
			if comboActive and connections.HumanoidResetHook == nil then
				-- hook death for auto-reset on the new character (if combo active)
				local hum = char:FindFirstChildOfClass("Humanoid")
				if hum then
					safeDisconnect("ResetDeath")
					connections.ResetDeath = hum.Died:Connect(function()
						task.wait(0.5)
						-- auto-respawn
						respawnPlayer()
					end)
				end
			end
		end)

		-- update backpack reference when re-added
		safeDisconnect("BackpackChildForAutoPunch")
		connections.BackpackChildForAutoPunch = LocalPlayer.ChildAdded:Connect(function(child)
			if child.Name == "Backpack" then
				backpack = child
			end
		end)

		while _G.AutoPunchToggle and loops[id] do
			local muscleEvent = getMuscleEvent()
			local character = LocalPlayer.Character
			if character and character:FindFirstChild("Humanoid") and muscleEvent then
				local punchEquipped = character:FindFirstChild("Punch")
				local punchInBackpack = (LocalPlayer:FindFirstChild("Backpack") and LocalPlayer.Backpack:FindFirstChild("Punch"))
				if not punchEquipped and punchInBackpack then
					pcall(function() character.Humanoid:EquipTool(punchInBackpack) end)
				end
				pcall(function() muscleEvent:FireServer("punch", hand) end)
			end
			task.wait(0.0001)
		end
	end)
end

-- Protein Egg equip and sanitization
local function startProteinEggLogic()
	_G.AutoProteinEgg = true
	local id = "ProteinEgg"
	loops[id] = true
	task.spawn(function()
		local toolName = "Protein Egg"
		local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

		local function restoreVisibility(tool)
			for _, part in ipairs(tool:GetDescendants()) do
				if part:IsA("BasePart") then
					pcall(function() part.Transparency = 0 end)
					pcall(function() part.LocalTransparencyModifier = 0 end)
				end
			end
		end

		local function findTool()
			local tool = (LocalPlayer:FindFirstChild("Backpack") and LocalPlayer.Backpack:FindFirstChild(toolName))
			if tool then return tool end
			tool = StarterPack:FindFirstChild(toolName)
			if tool then return tool end
			tool = ReplicatedStorage:FindFirstChild(toolName)
			return tool
		end

		local function forceEquip(tool)
			if not (character and character:FindFirstChild("Humanoid")) then return end
			pcall(function() character.Humanoid:EquipTool(tool) end)
			task.wait(0.1)
			if not character:FindFirstChild(toolName) then
				pcall(function() tool.Parent = character end)
				task.wait(0.1)
			end
			local equipped = character:FindFirstChild(toolName)
			if equipped then restoreVisibility(equipped) end
		end

		local function sanitizeTool(tool)
			for _, desc in ipairs(tool:GetDescendants()) do
				if desc:IsA("Script") then
					pcall(function() desc:Destroy() end)
				elseif desc:IsA("LocalScript") then
					pcall(function() desc.Disabled = true end)
				end
				if desc:IsA("RemoteEvent") then
					pcall(function() desc.FireServer = function() end end)
				end
			end
		end

		local function equipIfNeeded()
			if not _G.AutoProteinEgg then return end
			character = LocalPlayer.Character
			local equipped = character and character:FindFirstChild(toolName)
			local needEquip = false
			if not equipped then
				needEquip = true
			else
				for _, part in ipairs(equipped:GetDescendants()) do
					if part:IsA("BasePart") and part.Transparency > 0 then
						needEquip = true
						break
					end
				end
			end
			if needEquip then
				local tool = findTool()
				if tool then
					-- ensure a backpack copy exists
					if tool.Parent ~= (LocalPlayer:FindFirstChild("Backpack") and LocalPlayer.Backpack) then
						local clone = tool:Clone()
						clone.Parent = LocalPlayer:FindFirstChild("Backpack") or LocalPlayer
						tool = clone
					end
					sanitizeTool(tool)
					forceEquip(tool)
				end
			end
		end

		local function monitorToolContainer(container)
			if not container then return end
			for _, tool in ipairs(container:GetChildren()) do
				if tool:IsA("Tool") and tool.Name == toolName then
					sanitizeTool(tool)
				end
			end
			local conn = container.ChildAdded:Connect(function(child)
				if child:IsA("Tool") and child.Name == toolName then
					task.defer(function()
						sanitizeTool(child)
					end)
				end
			end)
			return conn
		end

		-- initial monitors
		safeDisconnect("MonitorBackpack")
		safeDisconnect("MonitorCharacter")
		connections.MonitorBackpack = monitorToolContainer(LocalPlayer:FindFirstChild("Backpack") or LocalPlayer:WaitForChild("Backpack"))
		connections.MonitorCharacter = monitorToolContainer(LocalPlayer.Character)

		-- CharacterAdded handler
		safeDisconnect("CharacterAddedProtein")
		connections.CharacterAddedProtein = LocalPlayer.CharacterAdded:Connect(function(char)
			character = char
			task.wait(1)
			safeDisconnect("MonitorBackpack")
			safeDisconnect("MonitorCharacter")
			connections.MonitorBackpack = monitorToolContainer(LocalPlayer:FindFirstChild("Backpack") or LocalPlayer:WaitForChild("Backpack"))
			connections.MonitorCharacter = monitorToolContainer(char)
			equipIfNeeded()
		end)

		-- Backpack ChildAdded
		safeDisconnect("BackpackChildProtein")
		connections.BackpackChildProtein = LocalPlayer:WaitForChild("Backpack").ChildAdded:Connect(function(child)
			if _G.AutoProteinEgg and child.Name == toolName then
				task.wait(0.2)
				equipIfNeeded()
			end
		end)

		-- periodic equip
		while _G.AutoProteinEgg and loops[id] do
			pcall(equipIfNeeded)
			task.wait(0.5)
		end
	end)
end

-- AntiFly
local function startAntiFly()
	getgenv().AntiFlyActive = true
	safeDisconnect("AntiFly")
	connections.AntiFly = RunService.Heartbeat:Connect(function()
		local char = LocalPlayer.Character
		if not char then return end
		local root = char:FindFirstChild("HumanoidRootPart")
		if not root then return end
		local humanoid = char:FindFirstChildOfClass("Humanoid")
		if not humanoid then return end
		local ray = Ray.new(root.Position, Vector3.new(0, -500, 0))
		local hit, position = workspace:FindPartOnRay(ray, char)
		if hit then
			local groundY = position.Y
			local currentY = root.Position.Y
			if currentY - groundY > 0.5 then
				root.CFrame = CFrame.new(root.Position.X, groundY + 0.5, root.Position.Z)
				humanoid.PlatformStand = true
				humanoid.PlatformStand = false
			end
		end
	end)
end

-- Soft anti-lag & sunset sky
local function softAntiLagAndSunset()
	pcall(function()
		local classesToClean = {["ParticleEmitter"]=true, ["Trail"]=true, ["Smoke"]=true, ["Fire"]=true}
		for _, obj in ipairs(workspace:GetChildren()) do
			if obj:IsA("Model") or obj:IsA("Part") then
				for _, sub in ipairs(obj:GetChildren()) do
					if classesToClean[sub.ClassName] then
						pcall(function() sub:Destroy() end)
					end
				end
			end
		end
		local terrain = workspace:FindFirstChildOfClass("Terrain")
		if terrain then
			terrain.WaterWaveSize = 0
			terrain.WaterReflectance = 0
			terrain.WaterTransparency = 1
		end
	end)
	pcall(function()
		lighting.ClockTime = 18
		lighting.Brightness = 1.5
		lighting.OutdoorAmbient = Color3.fromRGB(150, 100, 80)
		lighting.FogColor = Color3.fromRGB(200, 120, 100)
		lighting.FogEnd = 500
		for _, v in ipairs(lighting:GetChildren()) do
			if v:IsA("Sky") then
				pcall(function() v:Destroy() end)
			end
		end
		local sky = Instance.new("Sky")
		sky.Name = "SunsetSky"
		sky.SkyboxBk = "rbxassetid://131889017"
		sky.SkyboxDn = "rbxassetid://131889017"
		sky.SkyboxFt = "rbxassetid://131889017"
		sky.SkyboxLf = "rbxassetid://131889017"
		sky.SkyboxRt = "rbxassetid://131889017"
		sky.SkyboxUp = "rbxassetid://131889017"
		sky.SunAngularSize = 10
		sky.MoonAngularSize = 0
		sky.SunTextureId = "rbxassetid://644432992"
		sky.Parent = lighting
	end)
end

-- Hook death on a character for auto-reset
local function hookResetOnCharacter(char)
	if not char then return end
	local humanoid = char:FindFirstChildOfClass("Humanoid")
	if not humanoid then return end
	safeDisconnect("ResetDeath")
	connections.ResetDeath = humanoid.Died:Connect(function()
		task.wait(0.5)
		respawnPlayer()
	end)
end

Killer:AddToggle("Punch_When_Dead_Combo", {
	Title = "Punch When Dead | Combo (Protein Egg)",
	Default = false,
	Description = "Single toggle: NaN size, AutoPunch, Protein Egg, AntiFly, soft anti-lag, and auto-reset on death.",
	Callback = function(state)
		comboActive = state

		-- first cleanup any previous run
		cleanupAll()

		if state then
			-- apply NaN size
			applySizeNaN()

			-- start main features
			startAutoPunch()
			startProteinEggLogic()
			startAntiFly()
			softAntiLagAndSunset()

			-- hook reset on current character and future ones
			if LocalPlayer.Character then
				hookResetOnCharacter(LocalPlayer.Character)
			end
			safeDisconnect("CharacterAddedReset")
			connections.CharacterAddedReset = LocalPlayer.CharacterAdded:Connect(function(char)
				task.wait(0.5)
				hookResetOnCharacter(char)
			end)
		else
			-- disable everything and cleanup
			cleanupAll()
		end
	end,
})

--------------------------------------------------------------------
-- Friend whitelist (auto & manual)
--------------------------------------------------------------------
local friendWhitelistActive = false

Killer:AddToggle("AutoWhitelistFriends", {
	Title = "Auto Whitelist Friends",
	Default = false,
	Description = "Automatically whitelist your Roblox friends.",
	Callback = function(state)
		friendWhitelistActive = state
		if state then
			for _, player in ipairs(PlayersService:GetPlayers()) do
				if player ~= LocalPlayer and LocalPlayer:IsFriendsWith(player.UserId) then
					playerWhitelist[player.Name] = true
				end
			end

			PlayersService.PlayerAdded:Connect(function(player)
				if friendWhitelistActive and player ~= LocalPlayer and LocalPlayer:IsFriendsWith(player.UserId) then
					playerWhitelist[player.Name] = true
				end
			end)
		else
			for name in pairs(playerWhitelist) do
				local friend = PlayersService:FindFirstChild(name)
				if friend and LocalPlayer:IsFriendsWith(friend.UserId) then
					playerWhitelist[name] = nil
				end
			end
		end
	end,
})

Killer:AddInput("WhitelistAdd", {
	Title = "Whitelist Player",
	Default = "",
	Placeholder = "PlayerName",
	Callback = function(text)
		local target = PlayersService:FindFirstChild(text)
		if target then
			playerWhitelist[target.Name] = true
			Library:Notify({Title="Whitelist", Content = target.Name .. " added to whitelist.", Duration = 3})
		else
			Library:Notify({Title="Whitelist", Content = "Player not found: " .. tostring(text), Duration = 3})
		end
	end,
})

Killer:AddInput("WhitelistRemove", {
	Title = "UnWhitelist Player",
	Default = "",
	Placeholder = "PlayerName",
	Callback = function(text)
		local target = PlayersService:FindFirstChild(text)
		if target then
			playerWhitelist[target.Name] = nil
			Library:Notify({Title="Whitelist", Content = target.Name .. " removed from whitelist.", Duration = 3})
		else
			Library:Notify({Title="Whitelist", Content = "Player not found: " .. tostring(text), Duration = 3})
		end
	end,
})

--------------------------------------------------------------------
-- Auto Kill (Aura) and target-selection
--------------------------------------------------------------------
Killer:AddToggle("AutoKill", {
	Title = "Auto Kill (Aura)",
	Default = false,
	Description = "Automatically touches other players to 'kill' them if applicable.",
	Callback = function(state)
		autoKill = state
		task.spawn(function()
			while autoKill do
				local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
				local rightHand = character:FindFirstChild("RightHand") or character:FindFirstChild("Right Arm")
				local leftHand = character:FindFirstChild("LeftHand") or character:FindFirstChild("Left Arm")

				local punch = LocalPlayer.Backpack and LocalPlayer.Backpack:FindFirstChild("Punch")
				if punch and not character:FindFirstChild("Punch") then
					pcall(function() punch.Parent = character end)
				end

				if rightHand and leftHand then
					for _, target in ipairs(PlayersService:GetPlayers()) do
						if target ~= LocalPlayer and not playerWhitelist[target.Name] then
							local targetChar = target.Character
							local rootPart = targetChar and (targetChar:FindFirstChild("HumanoidRootPart") or targetChar:FindFirstChild("Torso"))
							if rootPart then
								pcall(function()
									firetouchinterest(rightHand, rootPart, 1)
									firetouchinterest(leftHand, rootPart, 1)
									firetouchinterest(rightHand, rootPart, 0)
									firetouchinterest(leftHand, rootPart, 0)
								end)
							end
						end
					end
				end

				task.wait(0.05)
			end
		end)
	end,
})

-- Dropdown for manual target selection (supports dynamic additions)
local targetDropdown = Killer:AddDropdown("SelectTarget", {
	Title = "Select Target (add to list)",
	Values = {}, -- start empty; we'll add dynamically
	Default = nil,
	Callback = function(name)
		if name and not table.find(targetPlayerNames, name) then
			table.insert(targetPlayerNames, name)
			Library:Notify({Title="Target", Content = name .. " added to target list.", Duration = 2})
		end
	end,
})

Killer:AddInput("RemoveTargetInput", {
	Title = "Remove Target From List",
	Default = "",
	Placeholder = "PlayerName",
	Callback = function(name)
		for i, v in ipairs(targetPlayerNames) do
			if v == name then
				table.remove(targetPlayerNames, i)
				Library:Notify({Title="Target", Content = name .. " removed.", Duration = 2})
				break
			end
		end
	end,
})

-- keep the dropdown values synced with players
local function refreshTargetDropdown()
	-- if the dropdown object exposes Clear/Add, use them; otherwise re-create values
	if targetDropdown and type(targetDropdown.Clear) == "function" then
		targetDropdown:Clear()
		for _, plr in ipairs(PlayersService:GetPlayers()) do
			if plr ~= LocalPlayer then
				targetDropdown:Add(plr.Name)
			end
		end
	else
		-- attempt to set values via internal API (some libs use SetValues)
		local vals = {}
		for _, plr in ipairs(PlayersService:GetPlayers()) do
			if plr ~= LocalPlayer then table.insert(vals, plr.Name) end
		end
		-- best-effort: try to replace the dropdown by rebuilding (if API supported)
		-- If not supported, this is non-fatal.
		pcall(function()
			if targetDropdown and targetDropdown.SetValues then
				targetDropdown:SetValues(vals)
			end
		end)
	end
end

refreshTargetDropdown()

PlayersService.PlayerAdded:Connect(function(player)
	if player ~= LocalPlayer then
		if targetDropdown and type(targetDropdown.Add) == "function" then
			pcall(function() targetDropdown:Add(player.Name) end)
		else
			refreshTargetDropdown()
		end
	end
end)

PlayersService.PlayerRemoving:Connect(function(player)
	if targetDropdown and type(targetDropdown.Clear) == "function" then
		pcall(function()
			targetDropdown:Clear()
			for _, plr in ipairs(PlayersService:GetPlayers()) do
				if plr ~= LocalPlayer then
					targetDropdown:Add(plr.Name)
				end
			end
		end)
	else
		refreshTargetDropdown()
	end

	for i = #targetPlayerNames, 1, -1 do
		if targetPlayerNames[i] == player.Name then
			table.remove(targetPlayerNames, i)
		end
	end
end)

Killer:AddToggle("StartKillTarget", {
	Title = "Start Kill Target(s)",
	Default = false,
	Description = "Attack players listed in the target list.",
	Callback = function(state)
		killTarget = state
		task.spawn(function()
			while killTarget do
				local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

				local punch = LocalPlayer.Backpack:FindFirstChild("Punch")
				if punch and not character:FindFirstChild("Punch") then
					pcall(function() punch.Parent = character end)
				end

				local rightHand = character:WaitForChild("RightHand", 5) or character:FindFirstChild("Right Arm")
				local leftHand = character:WaitForChild("LeftHand", 5) or character:FindFirstChild("Left Arm")

				if rightHand and leftHand then
					for _, name in ipairs(targetPlayerNames) do
						local target = PlayersService:FindFirstChild(name)
						if target and target ~= LocalPlayer then
							local rootPart = getRootCharacter(target)
							if rootPart then
								pcall(function()
									firetouchinterest(rightHand, rootPart, 1)
									firetouchinterest(leftHand, rootPart, 1)
									firetouchinterest(rightHand, rootPart, 0)
									firetouchinterest(leftHand, rootPart, 0)
								end)
							end
						end
					end
				end

				task.wait(0.05)
			end
		end)
	end,
})

--------------------------------------------------------------------
-- View / Spy Player (camera subject)
--------------------------------------------------------------------
-- Dropdown for selecting player to view
local spyDropdown = Killer:AddDropdown("SelectViewTarget", {
	Title = "Select View Target",
	Values = {},
	Default = nil,
	Callback = function(name)
		spyTargetName = name
		Library:Notify({Title="Spy", Content = "Selected " .. tostring(name) .. " for viewing.", Duration = 2})
	end,
})

-- populate spy dropdown initially
local function refreshSpyDropdown()
	if spyDropdown and type(spyDropdown.Clear) == "function" then
		spyDropdown:Clear()
		for _, plr in ipairs(PlayersService:GetPlayers()) do
			if plr ~= LocalPlayer then spyDropdown:Add(plr.Name) end
		end
	else
		local vals = {}
		for _, plr in ipairs(PlayersService:GetPlayers()) do if plr ~= LocalPlayer then table.insert(vals, plr.Name) end end
		pcall(function() if spyDropdown and spyDropdown.SetValues then spyDropdown:SetValues(vals) end end)
	end
end

refreshSpyDropdown()

PlayersService.PlayerAdded:Connect(function(plr)
	if plr ~= LocalPlayer then
		if spyDropdown and type(spyDropdown.Add) == "function" then
			pcall(function() spyDropdown:Add(plr.Name) end)
		else
			refreshSpyDropdown()
		end
	end
end)

PlayersService.PlayerRemoving:Connect(function(plr)
	refreshSpyDropdown()
end)

Killer:AddToggle("ViewPlayer", {
	Title = "View Player",
	Default = false,
	Description = "Switch camera to follow selected player.",
	Callback = function(bool)
		spying = bool
		local cam = workspace.CurrentCamera
		if not spying then
			pcall(function()
				cam.CameraSubject = (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")) or LocalPlayer
			end)
			return
		end
		task.spawn(function()
			while spying do
				local target = PlayersService:FindFirstChild(spyTargetName)
				if target and target ~= LocalPlayer then
					local humanoid = target.Character and target.Character:FindFirstChild("Humanoid")
					if humanoid then
						pcall(function() workspace.CurrentCamera.CameraSubject = humanoid end)
					end
				end
				task.wait(0.1)
			end
		end)
	end,
})

--------------------------------------------------------------------
-- Punch Animations / Blocker / Recovery / AutoPunch features
--------------------------------------------------------------------
-- Blocked animation ids set (example ids used earlier)
local blockedAnimations = {
	["rbxassetid://3638729053"] = true,
	["rbxassetid://3638767427"] = true,
}

local function stopMatchingTracks(humanoid)
	if not humanoid then return end
	for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
		if track.Animation then
			local animId = track.Animation.AnimationId or ""
			local animName = (track.Name or ""):lower()
			if blockedAnimations[animId] or animName:match("punch") or animName:match("attack") or animName:match("right") then
				pcall(function() track:Stop() end)
			end
		end
	end
end

local function setupAnimationBlocking()
	local char = game.Players.LocalPlayer.Character
	if not char or not char:FindFirstChild("Humanoid") then return end
	local humanoid = char:FindFirstChild("Humanoid")

	-- Stop existing playing tracks that match
	stopMatchingTracks(humanoid)

	if not _G.AnimBlockConnection then
		_G.AnimBlockConnection = humanoid.AnimationPlayed:Connect(function(track)
			if track and track.Animation then
				local animId = track.Animation.AnimationId or ""
				local animName = (track.Name or ""):lower()
				if blockedAnimations[animId] or animName:match("punch") or animName:match("attack") or animName:match("right") then
					pcall(function() track:Stop() end)
				end
			end
		end)
	end
end

-- override tool activation to immediately stop animation if it's a punch/attack tool
local function overrideToolActivation()
	local function processTool(tool)
		if not tool then return end
		if tool.Name == "Punch" or tool.Name:match("Attack") or tool.Name:match("Right") then
			if not tool:GetAttribute("ActivatedOverride") then
				tool:SetAttribute("ActivatedOverride", true)
				local connection = tool.Activated:Connect(function()
					task.wait(0.05)
					local char = game.Players.LocalPlayer.Character
					if char and char:FindFirstChild("Humanoid") then
						stopMatchingTracks(char.Humanoid)
					end
				end)
				if not _G.ToolConnections then _G.ToolConnections = {} end
				_G.ToolConnections[tool] = connection
			end
		end
	end

	-- process existing backpack tools
	for _, tool in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
		processTool(tool)
	end

	-- process character tools
	local char = game.Players.LocalPlayer.Character
	if char then
		for _, tool in pairs(char:GetChildren()) do
			if tool:IsA("Tool") then processTool(tool) end
		end
	end

	-- connections for future tools
	if not _G.BackpackAddedConnection then
		_G.BackpackAddedConnection = game.Players.LocalPlayer.Backpack.ChildAdded:Connect(function(child)
			if child:IsA("Tool") then
				task.wait(0.1)
				processTool(child)
			end
		end)
	end

	if not _G.CharacterToolAddedConnection and char then
		_G.CharacterToolAddedConnection = char.ChildAdded:Connect(function(child)
			if child:IsA("Tool") then
				task.wait(0.1)
				processTool(child)
			end
		end)
	end
end

-- Button: Remove Punch Anim (sets up blocking and override)
Killer:AddButton({
	Title = "Remove Punch Anim",
	Description = "Block punch animations and override tool activation.",
	Callback = function()
		setupAnimationBlocking()
		overrideToolActivation()

		if not _G.AnimMonitorConnection then
			_G.AnimMonitorConnection = game:GetService("RunService").Heartbeat:Connect(function()
				-- periodically ensure animations are stopped
				if tick() % 0.5 < 0.01 then
					local char = game.Players.LocalPlayer.Character
					if char and char:FindFirstChild("Humanoid") then
						stopMatchingTracks(char.Humanoid)
					end
				end
			end)
		end

		-- handle character re-add
		if not _G.CharacterAddedConnection then
			_G.CharacterAddedConnection = game.Players.LocalPlayer.CharacterAdded:Connect(function(newChar)
				task.wait(1)
				setupAnimationBlocking()
				overrideToolActivation()

				if _G.CharacterToolAddedConnection then
					_G.CharacterToolAddedConnection:Disconnect()
				end

				_G.CharacterToolAddedConnection = newChar.ChildAdded:Connect(function(child)
					if child:IsA("Tool") then
						task.wait(0.1)
						-- processTool is local to overrideToolActivation; re-run override
						overrideToolActivation()
					end
				end)
			end)
		end
	end,
})

-- Recovery function to disconnect all hooks/connections created by the anim blocker
local function RecoveryPunch()
	if _G.AnimBlockConnection then
		pcall(function() _G.AnimBlockConnection:Disconnect() end)
		_G.AnimBlockConnection = nil
	end
	if _G.AnimMonitorConnection then
		pcall(function() _G.AnimMonitorConnection:Disconnect() end)
		_G.AnimMonitorConnection = nil
	end
	if _G.ToolConnections then
		for _, conn in pairs(_G.ToolConnections) do
			if conn then pcall(function() conn:Disconnect() end) end
		end
		_G.ToolConnections = nil
	end
	if _G.BackpackAddedConnection then
		pcall(function() _G.BackpackAddedConnection:Disconnect() end)
		_G.BackpackAddedConnection = nil
	end
	if _G.CharacterToolAddedConnection then
		pcall(function() _G.CharacterToolAddedConnection:Disconnect() end)
		_G.CharacterToolAddedConnection = nil
	end
	if _G.CharacterAddedConnection then
		pcall(function() _G.CharacterAddedConnection:Disconnect() end)
		_G.CharacterAddedConnection = nil
	end
end

Killer:AddButton({
	Title = "Recover Punch Anim",
	Description = "Disconnect animation blocking and restore normal behavior.",
	Callback = function()
		RecoveryPunch()
		Library:Notify({Title="Recovery", Content="Punch animation blocking removed.", Duration = 3})
	end,
})

-- Auto Equip Punch
Killer:AddToggle("AutoEquipPunch", {
	Title = "Auto Equip Punch",
	Default = false,
	Callback = function(state)
		autoEquipPunch = state
		task.spawn(function()
			while autoEquipPunch do
				local punch = LocalPlayer.Backpack:FindFirstChild("Punch")
				if punch and LocalPlayer and LocalPlayer.Character then
					pcall(function() punch.Parent = LocalPlayer.Character end)
				end
				task.wait(0.1)
			end
		end)
	end,
})

-- Auto Punch [No Animation] - fires server events used in game
Killer:AddToggle("AutoPunchNoAnim", {
	Title = "Auto Punch [No Animation]",
	Default = false,
	Callback = function(state)
		autoPunchNoAnim = state
		task.spawn(function()
			while autoPunchNoAnim do
				local punch = LocalPlayer.Backpack:FindFirstChild("Punch") or (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Punch"))
				if punch then
					if punch.Parent ~= LocalPlayer.Character then
						pcall(function() punch.Parent = LocalPlayer.Character end)
					end
					-- fire the muscleEvent if available (game-specific)
					pcall(function()
						if LocalPlayer:FindFirstChild("muscleEvent") and type(LocalPlayer.muscleEvent.FireServer) == "function" then
							LocalPlayer.muscleEvent:FireServer("punch", "rightHand")
							LocalPlayer.muscleEvent:FireServer("punch", "leftHand")
						end
					end)
				else
					autoPunchNoAnim = false
				end
				task.wait(0.01)
			end
		end)
	end,
})

-- Auto Punch (fast activation without animation)
Killer:AddToggle("AutoPunch", {
	Title = "Auto Punch (Fast)",
	Default = false,
	Callback = function(state)
		_G.fastHitActive = state
		if state then
			task.spawn(function()
				while _G.fastHitActive do
					local punch = LocalPlayer.Backpack:FindFirstChild("Punch")
					if punch then
						pcall(function()
							punch.Parent = LocalPlayer.Character
							if punch:FindFirstChild("attackTime") then
								punch.attackTime.Value = 0
							end
						end)
					end
					task.wait(0.1)
				end
			end)
			task.spawn(function()
				while _G.fastHitActive do
					local punch = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Punch")
					if punch and type(punch.Activate) == "function" then
						pcall(function() punch:Activate() end)
					end
					task.wait(0.1)
				end
			end)
		else
			local punch = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Punch")
			if punch then
				pcall(function() punch.Parent = LocalPlayer.Backpack end)
			end
		end
	end,
})

-- Fast Punch (another variant)
Killer:AddToggle("FastPunch", {
	Title = "Fast Punch (Alt)",
	Default = false,
	Callback = function(state)
		_G.autoPunchActive = state
		if state then
			task.spawn(function()
				while _G.autoPunchActive do
					local punch = LocalPlayer.Backpack:FindFirstChild("Punch")
					if punch then
						pcall(function()
							punch.Parent = LocalPlayer.Character
							if punch:FindFirstChild("attackTime") then
								punch.attackTime.Value = 0
							end
						end)
					end
					task.wait()
				end
			end)
			task.spawn(function()
				while _G.autoPunchActive do
					local punch = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Punch")
					if punch and type(punch.Activate) == "function" then
						pcall(function() punch:Activate() end)
					end
					task.wait()
				end
			end)
		else
			local punch = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Punch")
			if punch then
				pcall(function() punch.Parent = LocalPlayer.Backpack end)
			end
		end
	end,
})

--------------------------------------------------------------------
-- Helper: populate dropdown initial lists for both target dropdowns
--------------------------------------------------------------------
-- initial population for targetDropdown and spyDropdown
task.spawn(function()
	for _, plr in ipairs(PlayersService:GetPlayers()) do
		if plr ~= LocalPlayer then
			if targetDropdown and type(targetDropdown.Add) == "function" then pcall(function() targetDropdown:Add(plr.Name) end) end
			if spyDropdown and type(spyDropdown.Add) == "function" then pcall(function() spyDropdown:Add(plr.Name) end) end
		end
	end
end)

-- Farming Tab

local mainSection = farmingTab:AddSection("Auto Farming")
local toolsSection = farmingTab:AddSection("Auto Tools")
local rocksSection = farmingTab:AddSection("Auto Rocks")

-- Services & locals
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local VIM = game:GetService("VirtualInputManager")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")
local Workspace = game:GetService("Workspace")

-- State variables (globals used originally)
getgenv().working = false
getgenv().autoFarm = false
_G.targetRebirthActive = false
_G.infiniteRebirthActive = false
_G.autoSizeActive = false
_G.teleportActive = false
_G.AutoWeight = false
_G.AutoPushups = false

local selectedMachine = nil
local selectedRock = nil
local targetRebirthValue = 1
local autoEquipPunch = false

-- helper functions
local function pressE()
	-- Send E press via VirtualInputManager (some executors use this)
	if VIM and VIM.SendKeyEvent then
		pcall(function()
			VIM:SendKeyEvent(true, "E", false, game)
			task.wait(0.1)
			VIM:SendKeyEvent(false, "E", false, game)
		end)
	end
end

local function autoLift()
	while getgenv().working do
		pcall(function()
			if LocalPlayer and LocalPlayer:FindFirstChild("muscleEvent") then
				LocalPlayer.muscleEvent:FireServer("rep")
			end
		end)
		task.wait()
	end
end

local function teleportAndStart(positionCFrame)
	local character = LocalPlayer.Character
	if character and character:FindFirstChild("HumanoidRootPart") then
		character.HumanoidRootPart.CFrame = positionCFrame
		task.wait(0.1)
		pressE()
		task.spawn(autoLift)
	end
end

-- workout positions (copied & normalized from original)
local workoutPositions = {
	["Jungle Gym - Jungle Bench Press"] = CFrame.new(-8173, 64, 1898),
	["Jungle Gym - Jungle Squat"] = CFrame.new(-8352, 34, 2878),
	["Jungle Gym - Jungle Pull Ups"] = CFrame.new(-8666, 34, 2070),
	["Jungle Gym - Jungle Boulder"] = CFrame.new(-8621, 34, 2684),
	["Eternal Gym - Bench Press"] = CFrame.new(-7176.19141, 45.394104, -1106.31421),
	["Legend Gym - Bench Press"] = CFrame.new(4111.91748, 1020.46674, -3799.97217),
	["Muscle King Gym - Bench Press"] = CFrame.new(-8590.06152, 46.0167427, -6043.34717),
	["Eternal Gym - Squat"] = CFrame.new(-7176.19141, 45.394104, -1106.31421),
	["Legend Gym - Squat"] = CFrame.new(4304.99023, 987.829956, -4124.2334),
	["Muscle King Gym - Squat"] = CFrame.new(-8940.12402, 13.1642084, -5699.13477),
	["Eternal Gym - Deadlift"] = CFrame.new(-7176.19141, 45.394104, -1106.31421),
	["Legend Gym - Deadlift"] = CFrame.new(4304.99023, 987.829956, -4124.2334),
	["Muscle King Gym - Deadlift"] = CFrame.new(-8940.12402, 13.1642084, -5699.13477),
	["Eternal Gym - Pull Up"] = CFrame.new(-7176.19141, 45.394104, -1106.31421),
	["Legend Gym - Pull Up"] = CFrame.new(4304.99023, 987.829956, -4124.2334),
	["Muscle King Gym - Pull Up"] = CFrame.new(-8940.12402, 13.1642084, -5699.13477)
}

-- ROCK data
local rockData = {
	["Tiny Rock"] = {Name = "Tiny Island Rock", Durability = 0},
	["Starter Rock"] = {Name = "Starter Island Rock", Durability = 100},
	["Legend Beach Rock"] = {Name = "Legend Beach Rock", Durability = 5000},
	["Frozen Rock"] = {Name = "Frost Gym Rock", Durability = 150000},
	["Mythical Rock"] = {Name = "Mythical Gym Rock", Durability = 400000},
	["Eternal Rock"] = {Name = "Eternal Gym Rock", Durability = 750000},
	["Legend Rock"] = {Name = "Legend Gym Rock", Durability = 1000000},
	["Muscle King Rock"] = {Name = "Muscle King Gym Rock", Durability = 5000000},
	["Jungle Rock"] = {Name = "Ancient Jungle Rock", Durability = 10000000},
}

-- UI BUILD: Main Farming controls
mainSection:AddParagraph({
	Title = "Auto Machines",
	Content = "Select a machine and toggle Start to teleport and auto lift at that location.",
})

-- Machine dropdown (Veinyx style)
local machineValues = {}
for name, _ in pairs(workoutPositions) do
	table.insert(machineValues, name)
end

local machineDropdownKey = "Farming_Machine"
mainSection:AddDropdown(machineDropdownKey, {
	Title = "Select Machine",
	Description = "Choose the machine to farm",
	Values = machineValues,
	Default = machineValues[1],
	Callback = function(val)
		selectedMachine = val
	end,
})

-- Start toggle for machine auto-lift + teleport
mainSection:AddToggle("Farming_StartMachine", {
	Title = "Start Auto Machine",
	Default = false,
	Description = "Teleport to the selected machine and auto-lift (sends 'rep').",
	Callback = function(state)
		if getgenv().working and not state then
			getgenv().working = false
			return
		end

		getgenv().working = state
		if state and selectedMachine and workoutPositions[selectedMachine] then
			teleportAndStart(workoutPositions[selectedMachine])
			Library:Notify({ Title = "Auto Machine", Content = "Teleported to: "..tostring(selectedMachine), Duration = 3 })
		end
	end,
})

-- TOOLS section (weight, pushups, punch)
toolsSection:AddParagraph({
	Title = "Auto Tools",
	Content = "Automatically equip/use tools like Weight, Pushups, Punch.",
})

-- Auto Weight toggle
toolsSection:AddToggle("Farming_AutoWeight", {
	Title = "Auto Weight",
	Default = false,
	Description = "Equip Weight tool and auto rep.",
	Callback = function(enabled)
		_G.AutoWeight = enabled

		if enabled then
			-- equip if available
			pcall(function()
				local weightTool = LocalPlayer.Backpack:FindFirstChild("Weight")
				if weightTool and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
					LocalPlayer.Character.Humanoid:EquipTool(weightTool)
				end
			end)

			task.spawn(function()
				while _G.AutoWeight do
					task.wait(0.1)
					pcall(function()
						if LocalPlayer and LocalPlayer:FindFirstChild("muscleEvent") then
							LocalPlayer.muscleEvent:FireServer("rep")
						end
					end)
				end
			end)
		else
			-- unequip (move back to backpack)
			pcall(function()
				local char = LocalPlayer.Character
				if char and char:FindFirstChild("Weight") then
					char.Weight.Parent = LocalPlayer.Backpack
				end
			end)
		end
	end,
})

-- Auto Pushups toggle
toolsSection:AddToggle("Farming_AutoPushups", {
	Title = "Auto Pushups",
	Default = false,
	Description = "Equip Pushups tool and auto rep.",
	Callback = function(enabled)
		_G.AutoPushups = enabled

		if enabled then
			pcall(function()
				local pushupsTool = LocalPlayer.Backpack:FindFirstChild("Pushups")
				if pushupsTool and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
					LocalPlayer.Character.Humanoid:EquipTool(pushupsTool)
				end
			end)

			task.spawn(function()
				while _G.AutoPushups do
					task.wait(0.1)
					pcall(function()
						if LocalPlayer and LocalPlayer:FindFirstChild("muscleEvent") then
							LocalPlayer.muscleEvent:FireServer("rep")
						end
					end)
				end
			end)
		else
			pcall(function()
				local char = LocalPlayer.Character
				if char and char:FindFirstChild("Pushups") then
					char.Pushups.Parent = LocalPlayer.Backpack
				end
			end)
		end
	end,
})

-- Auto Punch (keeps Punch tool in character)
toolsSection:AddToggle("Farming_AutoPunchEquip", {
	Title = "Auto Punch Equip",
	Default = false,
	Description = "Continuously move Punch from backpack to character.",
	Callback = function(enabled)
		autoEquipPunch = enabled
		if autoEquipPunch then
			task.spawn(function()
				while autoEquipPunch do
					task.wait(0.1)
					pcall(function()
						local punch = LocalPlayer.Backpack:FindFirstChild("Punch")
						if punch and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
							punch.Parent = LocalPlayer.Character
						end
					end)
				end
			end)
		end
	end,
})

-- ROCKS section build
rocksSection:AddParagraph({
	Title = "Auto Rocks",
	Content = "Select which rock to hit and toggle Start to farm it.",
})

local rockValues = {}
for k, _ in pairs(rockData) do
	table.insert(rockValues, k)
end

rocksSection:AddDropdown("Farming_RockDropdown", {
	Title = "Select Rock",
	Description = "Choose rock to farm",
	Values = rockValues,
	Default = rockValues[1],
	Callback = function(val)
		selectedRock = val
	end,
})

-- helper to equip punch & punch actions (mimic original gettool)
local function equipAndPunch()
	pcall(function()
		for _, v in pairs(LocalPlayer.Backpack:GetChildren()) do
			if v.Name == "Punch" and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
				LocalPlayer.Character.Humanoid:EquipTool(v)
			end
		end
		-- call server punch events (original used muscleEvent:FireServer("punch", "leftHand") etc.)
		if LocalPlayer and LocalPlayer:FindFirstChild("muscleEvent") then
			pcall(function() LocalPlayer.muscleEvent:FireServer("punch", "leftHand") end)
			pcall(function() LocalPlayer.muscleEvent:FireServer("punch", "rightHand") end)
		end
	end)
end

-- Start Auto Rocks toggle
rocksSection:AddToggle("Farming_StartRocks", {
	Title = "Start Auto Rocks",
	Default = false,
	Description = "Auto interact with selected rock when durability threshold is met.",
	Callback = function(state)
		getgenv().autoFarm = state
		task.spawn(function()
			while getgenv().autoFarm do
				task.wait()
				if not getgenv().autoFarm or not selectedRock then break end

				local data = rockData[selectedRock]
				if data then
					local durabilityOK = false
					pcall(function()
						if LocalPlayer and LocalPlayer:FindFirstChild("Durability") and LocalPlayer.Durability.Value >= data.Durability then
							durabilityOK = true
						end
					end)

					if durabilityOK then
						-- iterate machinesFolder to find matching neededDurability
						pcall(function()
							if Workspace:FindFirstChild("machinesFolder") then
								for _, v in pairs(Workspace.machinesFolder:GetDescendants()) do
									if v.Name == "neededDurability" and v.Value == data.Durability and v.Parent and v.Parent:FindFirstChild("Rock") then
										-- fire touch events for both hands
										local char = LocalPlayer.Character
										if char and char:FindFirstChild("LeftHand") and char:FindFirstChild("RightHand") then
											firetouchinterest(v.Parent.Rock, char.RightHand, 0)
											firetouchinterest(v.Parent.Rock, char.RightHand, 1)
											firetouchinterest(v.Parent.Rock, char.LeftHand, 0)
											firetouchinterest(v.Parent.Rock, char.LeftHand, 1)
											equipAndPunch()
										end
									end
								end
							end
						end)
					end
				end
			end
		end)
	end,
})


local player = game.Players.LocalPlayer
local muscleEvent = player:WaitForChild("muscleEvent")
local runFastRep = false
local repsPerTick = 1

-- Create the Fast Rep section inside your farmingTab
local FastRepSection = farmingTab:AddSection("⚡ Fast Rep")

-- Rep Speed Dropdown (1–30)
local RepSpeedDropdown = FastRepSection:AddDropdown("FastRep_Speed", {
	Title = "Rep Speed",
	Description = "Choose how many reps per tick (1–30)",
	Values = {},
	Default = "1",
	Callback = function(value)
		repsPerTick = tonumber(value) or 1
	end,
})

-- Fill dropdown values dynamically
for i = 1, 30 do
	table.insert(RepSpeedDropdown.Values, tostring(i))
end
RepSpeedDropdown:SetValue("1") -- Set default display value

-- Fast Rep Loop Function
local function fastRepLoop()
	while runFastRep do
		for i = 1, repsPerTick do
			muscleEvent:FireServer("rep")
		end
		task.wait(0.02)
	end
end

-- Fast Rep Toggle
FastRepSection:AddToggle("FastRep_Toggle", {
	Title = "Fast Rep",
	Description = "Rapidly performs reps using muscleEvent",
	Default = false,
	Callback = function(state)
		runFastRep = state
		if runFastRep then
			task.spawn(fastRepLoop)
		end
	end,
})

local autoEat30 = false
local autoEat60 = false
local player = game.Players.LocalPlayer
local backpack = player:WaitForChild("Backpack")

-- Function to eat Protein Egg
local function eatProteinEgg()
	local character = player.Character or player.CharacterAdded:Wait()
	local egg = backpack:FindFirstChild("Protein Egg")
	if egg then
		egg.Parent = character
		pcall(function()
			egg:Activate()
		end)
	end
end

-- Auto Eat 30 Minutes
task.spawn(function()
	while true do
		if autoEat30 then
			eatProteinEgg()
			task.wait(1800) -- 30 minutes
		else
			task.wait(1)
		end
	end
end)

FastRepSection:AddToggle("Auto_Eat_Egg_30", {
	Title = "Auto Eat Egg || 30 Minutes",
	Description = "Automatically eats Protein Egg every 30 minutes",
	Default = false,
	Callback = function(state)
		autoEat30 = state
	end,
})

-- Auto Eat 60 Minutes
task.spawn(function()
	while true do
		if autoEat60 then
			eatProteinEgg()
			task.wait(3600) -- 60 minutes
		else
			task.wait(1)
		end
	end
end)

FastRepSection:AddToggle("Auto_Eat_Egg_60", {
	Title = "Auto Eat Egg || 60 Minutes",
	Description = "Automatically eats Protein Egg every 60 minutes",
	Default = false,
	Callback = function(state)
		autoEat60 = state
	end,
})

local rSto = game:GetService("ReplicatedStorage")

local HideFramesSection = farmingTab:AddSection("Hide Features")

HideFramesSection:AddToggle("Hide_Frames", {
	Title = "Hide Frames",
	Description = "Toggle to hide or show all objects ending with 'Frame' in ReplicatedStorage.",
	Default = false,
	Callback = function(state)
		for _, obj in pairs(rSto:GetChildren()) do
			if obj:IsA("Instance") and obj.Name:match("Frame$") and obj:FindFirstChildWhichIsA("GuiObject") then
				for _, child in pairs(obj:GetDescendants()) do
					if child:IsA("GuiObject") then
						child.Visible = not state
					end
				end
			elseif obj:IsA("GuiObject") and obj.Name:match("Frame$") then
				obj.Visible = not state
			end
		end
	end,
})

HideFramesSection:AddToggle("HidePets", {
	Title = "Hide Pets",
	Default = false,
	Callback = function(state)
		local event = game:GetService("ReplicatedStorage").rEvents.showPetsEvent
		if state then
			event:FireServer("hidePets")
		else
			event:FireServer("showPets")
		end
	end,
})


-- Rebirths

local rebirthSection = Rebirths:AddSection("Auto Rebirth / Size / Teleport")

rebirthSection:AddParagraph({
	Title = "Auto Rebirths",
	Content = "Set target rebirth count or use infinite rebirths.",
})

rebirthSection:AddInput("Rebirth_TargetInput", {
	Title = "Rebirth Target",
	Placeholder = "Enter target rebirths (number)",
	Default = tostring(targetRebirthValue),
	Callback = function(text)
		local newValue = tonumber(text)
		if newValue and newValue > 0 then
			targetRebirthValue = newValue
			Library:Notify({ Title = "Target Updated", Content = "New rebirth target: "..tostring(targetRebirthValue), Duration = 3 })
		else
			Library:Notify({ Title = "Invalid Value", Content = "Enter a number greater than 0", Duration = 3 })
		end
	end,
})

-- Target rebirth toggle
rebirthSection:AddToggle("Farming_TargetRebirth", {
	Title = "Auto Rebirth Until Target",
	Default = false,
	Description = "Automatically invoke rebirth until reaching the target value.",
	Callback = function(enabled)
		_G.targetRebirthActive = enabled

		if enabled then
			-- disable infinite if active
			if _G.infiniteRebirthActive then
				_G.infiniteRebirthActive = false
				-- if SaveManager supports toggles persistence this will be handled on load
			end

			task.spawn(function()
				while _G.targetRebirthActive do
					task.wait(0.1)
					local success, current = pcall(function()
						return LocalPlayer and LocalPlayer:FindFirstChild("leaderstats") and LocalPlayer.leaderstats:FindFirstChild("Rebirths") and LocalPlayer.leaderstats.Rebirths.Value
					end)
					if success and current and current >= targetRebirthValue then
						_G.targetRebirthActive = false
						Library:Notify({ Title = "Target Reached", Content = "Reached "..tostring(targetRebirthValue).." rebirths.", Duration = 4 })
						break
					end

					-- attempt rebirth invoke (original used rEvents.rebirthRemote:InvokeServer("rebirthRequest"))
					pcall(function()
						if ReplicatedStorage:FindFirstChild("rEvents") and ReplicatedStorage.rEvents:FindFirstChild("rebirthRemote") then
							ReplicatedStorage.rEvents.rebirthRemote:InvokeServer("rebirthRequest")
						end
					end)
				end
			end)
		end
	end,
})

-- Infinite rebirth toggle
rebirthSection:AddToggle("Farming_InfiniteRebirth", {
	Title = "Auto Rebirth (Infinite)",
	Default = false,
	Description = "Continuously send rebirth requests.",
	Callback = function(enabled)
		_G.infiniteRebirthActive = enabled

		if enabled then
			_G.targetRebirthActive = false -- disable target mode
			task.spawn(function()
				while _G.infiniteRebirthActive do
					task.wait(0.1)
					pcall(function()
						if ReplicatedStorage:FindFirstChild("rEvents") and ReplicatedStorage.rEvents:FindFirstChild("rebirthRemote") then
							ReplicatedStorage.rEvents.rebirthRemote:InvokeServer("rebirthRequest")
						end
					end)
				end
			end)
		end
	end,
})

-- Auto Size 1 toggle (changeSize remote)
rebirthSection:AddToggle("Farming_AutoSize1", {
	Title = "Auto Size 1",
	Default = false,
	Description = "Continuously request size 1.",
	Callback = function(enabled)
		_G.autoSizeActive = enabled
		if enabled then
			task.spawn(function()
				while _G.autoSizeActive do
					task.wait()
					pcall(function()
						if ReplicatedStorage:FindFirstChild("rEvents") and ReplicatedStorage.rEvents:FindFirstChild("changeSpeedSizeRemote") then
							ReplicatedStorage.rEvents.changeSpeedSizeRemote:InvokeServer("changeSize", 1)
						end
					end)
				end
			end)
		end
	end,
})

-- Teleport to Muscle King toggle (teleport loop)
rebirthSection:AddToggle("Farming_TeleportToMK", {
	Title = "Auto Teleport to Muscle King",
	Default = false,
	Description = "Continuously MoveTo the Muscle King position.",
	Callback = function(enabled)
		_G.teleportActive = enabled
		if enabled then
			task.spawn(function()
				while _G.teleportActive do
					task.wait()
					if LocalPlayer.Character then
						pcall(function()
							LocalPlayer.Character:MoveTo(Vector3.new(-8646, 17, -5738))
						end)
					end
				end
			end)
		end
	end,
})

-- ⚡ Fast Rebirth (Veinyx UI Version)

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = game.Players.LocalPlayer

-- Section for Auto Farming / Rebirth
local AutoRebirthSection = Rebirths:AddSection("Op Fast Rebirthing")

AutoRebirthSection:AddToggle("Fast_Rebirth", {
	Title = "Fast Rebirth",
	Description = "Automatically farm strength and perform rebirths",
	Default = false,
	Callback = function(state)
		getgenv().AutoFarming = state

		if state then
			warn("⚡ AutoFarming ACTIVADO")

			task.spawn(function()
				while getgenv().AutoFarming do
					local requiredStrength = getStrengthRequiredForRebirth()
					print("Necesario para renacer:", requiredStrength)

					-- Fase de farmeo
					unequipAllPets()
					equipPetByName(FarmPet)

					while LocalPlayer.leaderstats.Strength.Value < requiredStrength and getgenv().AutoFarming do
						for _ = 1, 10 do
							LocalPlayer.muscleEvent:FireServer("rep")
						end
						task.wait()
					end

					if not getgenv().AutoFarming then break end

					-- Fase de renacimiento
					unequipAllPets()
					equipPetByName(RebirthPet)

					local oldRebirths = LocalPlayer.leaderstats.Rebirths.Value
					repeat
						ReplicatedStorage.rEvents.rebirthRemote:InvokeServer("rebirthRequest")
						task.wait(0.1)
					until LocalPlayer.leaderstats.Rebirths.Value > oldRebirths or not getgenv().AutoFarming

					print("Renacimiento hecho. Reiniciando ciclo.")
				end

				print("🛑 AutoFarming DETENIDO")
			end)
		else
			warn("🛑 AutoFarming DESACTIVADO")
		end
	end,
})

local autoEat30 = false
local autoEat60 = false
local player = game.Players.LocalPlayer
local backpack = player:WaitForChild("Backpack")

-- Function to eat Protein Egg
local function eatProteinEgg()
	local character = player.Character or player.CharacterAdded:Wait()
	local egg = backpack:FindFirstChild("Protein Egg")
	if egg then
		egg.Parent = character
		pcall(function()
			egg:Activate()
		end)
	end
end

-- Auto Eat 30 Minutes
task.spawn(function()
	while true do
		if autoEat30 then
			eatProteinEgg()
			task.wait(1800) -- 30 minutes
		else
			task.wait(1)
		end
	end
end)

AutoRebirthSection:AddToggle("Auto_Eat_Egg_30", {
	Title = "Auto Eat Egg || 30 Minutes",
	Description = "Automatically eats Protein Egg every 30 minutes",
	Default = false,
	Callback = function(state)
		autoEat30 = state
	end,
})

-- Auto Eat 60 Minutes
task.spawn(function()
	while true do
		if autoEat60 then
			eatProteinEgg()
			task.wait(3600) -- 60 minutes
		else
			task.wait(1)
		end
	end
end)

AutoRebirthSection:AddToggle("Auto_Eat_Egg_60", {
	Title = "Auto Eat Egg || 60 Minutes",
	Description = "Automatically eats Protein Egg every 60 minutes",
	Default = false,
	Callback = function(state)
		autoEat60 = state
	end,
})

--- Pet Shop

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PetsSection = Shop:AddSection("🐾 Pets & Auras")

-- ===== Pets Dropdown =====
local selectedPet = "Neon Guardian" -- Default pet
local petDropdown = PetsSection:AddDropdown("Select Pet", {
	Title = "Select Pet",
	Description = "Choose the pet you want to auto hatch",
	Values = { 
		"Neon Guardian","Blue Birdie","Blue Bunny","Blue Firecaster","Blue Pheonix","Crimson Falcon",
		"Cybernetic Showdown Dragon","Dark Golem","Dark Legends Manticore","Dark Vampy","Darkstar Hunter",
		"Eternal Strike Leviathan","Frostwave Legends Penguin","Gold Warrior","Golden Pheonix","Golden Viking",
		"Green Butterfly","Green Firecaster","Infernal Dragon","Lightning Strike Phantom","Magic Butterfly",
		"Muscle Sensei","Orange Hedgehog","Orange Pegasus","Phantom Genesis Dragon","Purple Dragon",
		"Purple Falcon","Red Dragon","Red Firecaster","Red Kitty","Silver Dog","Ultimate Supernova Pegasus",
		"Ultra Birdie","White Pegasus","White Pheonix","Yellow Butterfly"
	},
	Default = selectedPet,
	Callback = function(value)
		selectedPet = value
		print("Selected pet: " .. value)
	end,
})

-- Auto Open Pet Toggle
PetsSection:AddToggle("Auto_Open_Pet", {
	Title = "Auto Open Pet",
	Description = "Automatically opens the selected pet",
	Default = false,
	Callback = function(state)
		_G.AutoHatchPet = state
		if state then
			task.spawn(function()
				while _G.AutoHatchPet and selectedPet ~= "" do
					local petToOpen = ReplicatedStorage.cPetShopFolder:FindFirstChild(selectedPet)
					if petToOpen then
						ReplicatedStorage.cPetShopRemote:InvokeServer(petToOpen)
					end
					task.wait(1)
				end
			end)
		end
	end,
})

-- ===== Auras Dropdown =====
local selectedAura = "Blue Aura" -- Default aura
local auraDropdown = PetsSection:AddDropdown("Select Aura", {
	Title = "Select Aura",
	Description = "Choose the aura you want to auto hatch",
	Values = {
		"Astral Electro","Azure Tundra","Blue Aura","Dark Electro","Dark Lightning","Dark Storm",
		"Electro","Enchanted Mirage","Entropic Blast","Eternal Megastrike","Grand Supernova","Green Aura",
		"Inferno","Lightning","Muscle King","Power Lightning","Purple Aura","Purple Nova","Red Aura",
		"Supernova","Ultra Inferno","Ultra Mirage","Unstable Mirage","Yellow Aura"
	},
	Default = selectedAura,
	Callback = function(value)
		selectedAura = value
		print("Selected aura: " .. value)
	end,
})

-- Auto Open Aura Toggle
PetsSection:AddToggle("Auto_Open_Aura", {
	Title = "Auto Open Aura",
	Description = "Automatically opens the selected aura",
	Default = false,
	Callback = function(state)
		_G.AutoHatchAura = state
		if state then
			task.spawn(function()
				while _G.AutoHatchAura and selectedAura ~= "" do
					local auraToOpen = ReplicatedStorage.cPetShopFolder:FindFirstChild(selectedAura)
					if auraToOpen then
						ReplicatedStorage.cPetShopRemote:InvokeServer(auraToOpen)
					end
					task.wait(1)
				end
			end)
		end
	end,
})

------------Misc-------------

-- Anti AFK Toggle
local antiAFKEnabled = false
Misc:AddToggle("AntiAFK", {
    Title = "Anti AFK",
    Default = false,
    Callback = function(state)
        antiAFKEnabled = state
        if state then
            setupAntiAFK()
        else
            if antiAFKConnection then
                antiAFKConnection:Disconnect()
                antiAFKConnection = nil
                print("Anti-AFK system disabled")
            end
        end
    end
})

-- Lock Position Toggle
Misc:AddToggle("LockPosition", {
    Title = "Lock Position",
    Default = false,
    Callback = function(Value)
        if Value then
            local currentPos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
            getgenv().posLock = game:GetService("RunService").Heartbeat:Connect(function()
                local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    hrp.CFrame = currentPos
                end
            end)
        else
            if getgenv().posLock then
                getgenv().posLock:Disconnect()
                getgenv().posLock = nil
            end
        end
    end
})

-- Anti Knockback Toggle
Misc:AddToggle("AntiKnockback", {
    Title = "Anti Knockback",
    Default = false,
    Callback = function(Value)
        local playerName = game.Players.LocalPlayer.Name
        local rootPart = game.Workspace:FindFirstChild(playerName):FindFirstChild("HumanoidRootPart")
        if Value then
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.MaxForce = Vector3.new(100000, 0, 100000)
            bodyVelocity.Velocity = Vector3.new(0, 0, 0)
            bodyVelocity.P = 1250
            bodyVelocity.Parent = rootPart
        else
            local existingVelocity = rootPart:FindFirstChild("BodyVelocity")
            if existingVelocity and existingVelocity.MaxForce == Vector3.new(100000, 0, 100000) then
                existingVelocity:Destroy()
            end
        end
    end
})

-- Remove Portals Button
Misc:AddButton({
    Title = "Remove Portals",
    Callback = function()
        for _, portal in pairs(game:GetDescendants()) do
            if portal.Name == "RobloxForwardPortals" then
                portal:Destroy()
            end
        end

        if _G.AdRemovalConnection then
            _G.AdRemovalConnection:Disconnect()
        end

        _G.AdRemovalConnection = game.DescendantAdded:Connect(function(descendant)
            if descendant.Name == "RobloxForwardPortals" then
                descendant:Destroy()
            end
        end)

        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Anuncios Eliminados",
            Text = "Los anuncios de Roblox han sido eliminados",
            Duration = 5
        })
    end
})

-- Change Time Dropdown
local timeDropdown = Misc:AddDropdown("ChangeTime", {
    Title = "Change Time",
    Values = {"Night", "Day", "Midnight"},
    Default = "Day",
    Callback = function(selection)
        local lighting = game:GetService("Lighting")
        if selection == "Night" then
            lighting.ClockTime = 0
        elseif selection == "Day" then
            lighting.ClockTime = 12
        elseif selection == "Midnight" then
            lighting.ClockTime = 6
        end
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Hora Cambiada",
            Text = "La hora ha sido cambiada a: " .. selection,
            Duration = 5
        })
    end
})

-- Auto Fortune Wheel Toggle
Misc:AddToggle("AutoFortuneWheel", {
    Title = "Auto Fortune Wheel",
    Default = false,
    Callback = function(Value)
        _G.autoFortuneWheelActive = Value
        if Value then
            task.spawn(function()
                while _G.autoFortuneWheelActive do
                    local args = {
                        [1] = "openFortuneWheel",
                        [2] = game:GetService("ReplicatedStorage"):WaitForChild("fortuneWheelChances"):WaitForChild("Fortune Wheel")
                    }
                    game:GetService("ReplicatedStorage"):WaitForChild("rEvents"):WaitForChild("openFortuneWheelRemote"):InvokeServer(unpack(args))
                    task.wait(0)
                end
            end)
        else
            _G.autoFortuneWheelActive = false
        end
    end
})

-- God Mode (Brawl) Toggle
local godModeToggle = false
Misc:AddToggle("GodModeBrawl", {
    Title = "God Mode (Brawl)",
    Default = false,
    Callback = function(State)
        godModeToggle = State
        if State then
            task.spawn(function()
                while godModeToggle do
                    game:GetService("ReplicatedStorage").rEvents.brawlEvent:FireServer("joinBrawl")
                    task.wait(0)
                end
            end)
        end
    end
})

-- Full Walk on Water Toggle
local parts = {}
local partSize = 2048
local totalDistance = 50000
local startPosition = Vector3.new(-2, -9.5, -2)
local numberOfParts = math.ceil(totalDistance / partSize)

local function createParts()
    for x = 0, numberOfParts - 1 do
        for z = 0, numberOfParts - 1 do
            local partNames = {"Side", "LeftRight", "UpLeft", "UpRight"}
            local positions = {
                Vector3.new(x * partSize, 0, z * partSize),
                Vector3.new(-x * partSize, 0, z * partSize),
                Vector3.new(-x * partSize, 0, -z * partSize),
                Vector3.new(x * partSize, 0, -z * partSize)
            }
            for i = 1, 4 do
                local p = Instance.new("Part")
                p.Size = Vector3.new(partSize,1,partSize)
                p.Position = startPosition + positions[i]
                p.Anchored = true
                p.Transparency = 1
                p.CanCollide = true
                p.Name = "Part_"..partNames[i].."_"..x.."_"..z
                p.Parent = workspace
                table.insert(parts, p)
            end
        end
    end
end

local function makePartsWalkthrough()
    for _, part in ipairs(parts) do
        if part and part.Parent then
            part.CanCollide = false
        end
    end
end

Misc:AddToggle("FullWalkOnWater", {
    Title = "Full Walk on Water",
    Default = false,
    Callback = function(bool)
        if bool then
            createParts()
        else
            makePartsWalkthrough()
        end
    end
})

-- Auto Clear Inventory / Eat Boosts Toggle
local autoEatBoostsEnabled = false
local boostsList = {"ULTRA Shake","TOUGH Bar","Protein Shake","Energy Shake","Protein Bar","Energy Bar","Tropical Shake"}

local function eatAllBoosts()
    local player = game.Players.LocalPlayer
    local backpack = player:WaitForChild("Backpack")
    local character = player.Character or player.CharacterAdded:Wait()
    for _, boostName in ipairs(boostsList) do
        local boost = backpack:FindFirstChild(boostName)
        while boost do
            boost.Parent = character
            pcall(function() boost:Activate() end)
            task.wait(0)
            boost = backpack:FindFirstChild(boostName)
        end
    end
end

task.spawn(function()
    while true do
        if autoEatBoostsEnabled then
            eatAllBoosts()
            task.wait(2)
        else
            task.wait(1)
        end
    end
end)

Misc:AddToggle("AutoClearInventory", {
    Title = "Auto Clear Inventory",
    Default = false,
    Callback = function(state)
        autoEatBoostsEnabled = state
    end
})

