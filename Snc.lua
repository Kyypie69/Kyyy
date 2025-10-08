--[[
    Copyright (c) 2025 imhenne187
    Open Sourced
    made by Henne
]]

local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local url = "" --[[ make an luau on a github file and paste the raw link here. Lua list example:

return {
    ["user"] = true,
    ["user"] = false
}

]]

local success, bannedList = pcall(function()
    local src = game:HttpGet(url)
    return loadstring(src)()
end)

if not success then
    bannedList = {}
end


local bannedDict = {}
for _, name in ipairs(bannedList) do
    bannedDict[name] = true
end


if bannedDict[game.Players.LocalPlayer.Name] then
    ReplicatedStorage.rEvents.rebirthRemote:InvokeServer("rebirthRequest")
    task.wait(2)
    localPlayer:Kick("Scum")
    task.wait(3)
    game:Shutdown()
end

-- simple Blacklist (was made for lazer :D)

local function formatNumber(num)
    if num >= 1e15 then return string.format("%.2f Qa", num/1e15) end
    if num >= 1e12 then return string.format("%.2f T", num/1e12) end
    if num >= 1e9 then return string.format("%.2f B", num/1e9) end
    if num >= 1e6 then return string.format("%.2f M", num/1e6) end
    if num >= 1e3 then return string.format("%.2f K", num/1e3) end
    return string.format("%.0f", num)
end

local serverUrl = "look at the /webhook/tutorial.md"

local function sendStats()
    local leaderstats = localPlayer:WaitForChild("leaderstats")
    local stats = {
        strength = leaderstats.Strength.Value,
        rebirths = leaderstats.Rebirths.Value,
        kills = leaderstats.Kills.Value,
        brawls = leaderstats.Brawls.Value,
        durability = localPlayer:WaitForChild("Durability").Value,
        agility = localPlayer:WaitForChild("Agility").Value
    }

local payload = {
    name = localPlayer.DisplayName,
    username = localPlayer.Name,
    stats = {
        strength = formatNumber(leaderstats.Strength.Value),
        rebirths = formatNumber(leaderstats.Rebirths.Value),
        kills = formatNumber(leaderstats.Kills.Value),
        brawls = formatNumber(leaderstats.Brawls.Value),
        durability = formatNumber(localPlayer.Durability.Value),
        agility = formatNumber(localPlayer.Agility.Value)
    }
}

    local req = request or http_request or (syn and syn.request)
    if not req then
        return
    end

    local success, err = pcall(function()
        req({
            Url = serverUrl,
            Method = "POST",
            Headers = { ["Content-Type"] = "application/json" },
            Body = HttpService:JSONEncode(payload)
        })
    end)
end

sendStats()


local VirtualUser = game:GetService("VirtualUser")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local muscleEvent = Player:WaitForChild("muscleEvent")
local display = Player.DisplayName


local library = loadstring(game:HttpGet("https://gitea.com/157fl/blabla/raw/branch/main/blabla.lua", true))()

local window = library:AddWindow("Silence | Public - Hello "..display, {
    main_color = Color3.fromRGB(255, 0, 0),
    min_size = Vector2.new(650, 700),
    can_resize = false,
})

local antiAFKConnection
local function setupAntiAFK()
    if antiAFKConnection then
        antiAFKConnection:Disconnect()
    end

    antiAFKConnection = Player.Idled:Connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)
end
setupAntiAFK()

local function removePortals()
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
end
removePortals()

local MainTab = window:AddTab("Main")
local KillingTab = window:AddTab("Killing")
local SpecsTab = window:AddTab("Specs")
local FarmingTab = window:AddTab("Farming")
local FastFarmingTab = window:AddTab("Fast Farming")
local InventoryTab = window:AddTab("Inventory")
local PetsTab = window:AddTab("Pet Shop")
local TeleportTab = window:AddTab("Teleports")
local infoTab = window:AddTab("Info")

MainTab:AddLabel("Settings:").TextSize = 22

local changeSpeedSizeRemote = ReplicatedStorage.rEvents.changeSpeedSizeRemote

local userSize = 2
local sizeActive = false

MainTab:AddTextBox("Size", function(text)
	text = string.gsub(text, "%s+", "")
	local value = tonumber(text)
	if value and value > 0 then
		userSize = value
	end
end)

local setsizeswitch = MainTab:AddSwitch("Set Size", function(bool)
	sizeActive = bool
end)

setsizeswitch:Set(false)

task.spawn(function()
	while true do
		if sizeActive then
			local character = Players.LocalPlayer.Character
			if character then
				local humanoid = character:FindFirstChildOfClass("Humanoid")
				if humanoid then
					changeSpeedSizeRemote:InvokeServer("changeSize", userSize)
				end
			end
		end
		task.wait(0.15)
	end
end)

local userSpeed = 120
local speedActive = false

MainTab:AddTextBox("Speed", function(text)
	text = string.gsub(text, "%s+", "")
	local value = tonumber(text)
	if value and value > 0 then
		userSpeed = value
	end
end)

local setspeedswitch = MainTab:AddSwitch("Set Speed", function(bool)
	speedActive = bool
end)

setspeedswitch:Set(false)

task.spawn(function()
	while true do
		if speedActive then
			local character = Players.LocalPlayer.Character
			if character then
				local humanoid = character:FindFirstChildOfClass("Humanoid")
				if humanoid then
					changeSpeedSizeRemote:InvokeServer("changeSpeed", userSpeed)
				end
			end
		end
		task.wait(0.15)
	end
end)

MainTab:AddLabel("Important:").TextSize = 22

local antiKnockbackSwitch = MainTab:AddSwitch("Anti Fling", function(bool)
    if bool then
        local playerName = game.Players.LocalPlayer.Name
        local character = game.Workspace:FindFirstChild(playerName)
        if character then
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            if rootPart then
                local bodyVelocity = Instance.new("BodyVelocity")
                bodyVelocity.MaxForce = Vector3.new(100000, 0, 100000)
                bodyVelocity.Velocity = Vector3.new(0, 0, 0)
                bodyVelocity.P = 1250
                bodyVelocity.Parent = rootPart
            end
        end
    else
        local playerName = game.Players.LocalPlayer.Name
        local character = game.Workspace:FindFirstChild(playerName)
        if character then
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            if rootPart then
                local existingVelocity = rootPart:FindFirstChild("BodyVelocity")
                if existingVelocity and existingVelocity.MaxForce == Vector3.new(100000, 0, 100000) then
                    existingVelocity:Destroy()
                end
            end
        end
    end
end)
antiKnockbackSwitch:Set(true)

local lockRunning = false
local lockThread = nil

local lockSwitch = MainTab:AddSwitch("Lock Position", function(state)
    lockRunning = state
    if lockRunning then
        local player = game.Players.LocalPlayer
        local char = player.Character or player.CharacterAdded:Wait()
        local hrp = char:WaitForChild("HumanoidRootPart")
        local lockPosition = hrp.Position

        lockThread = coroutine.create(function()
            while lockRunning do
                hrp.Velocity = Vector3.new(0, 0, 0)
                hrp.RotVelocity = Vector3.new(0, 0, 0)
                hrp.CFrame = CFrame.new(lockPosition)
                wait(0.05) 
            end
        end)

        coroutine.resume(lockThread)
    end
end)
lockSwitch:Set(false)

local showpetsswitch = MainTab:AddSwitch("Show Pets", function(bool)
    local player = game:GetService("Players").LocalPlayer
    if player:FindFirstChild("hidePets") then
        player.hidePets.Value = bool
    end
end)
showpetsswitch:Set(false)

local showotherpetsswitch = MainTab:AddSwitch("Show Other Pets", function(bool)
    local player = game:GetService("Players").LocalPlayer
    if player:FindFirstChild("showOtherPetsOn") then
        player.showOtherPetsOn.Value = bool
    end
end)
showotherpetsswitch:Set(false)

local blockedFrames = {
    "strengthFrame",
    "durabilityFrame",
    "agilityFrame",
    "evilKarmaFrame",
    "goodKarmaFrame"
}

local frameSwitch = MainTab:AddSwitch("Hide All Frames", function(bool)
    if bool then
        -- Frames ausblenden
        for _, name in ipairs(blockedFrames) do
            local frame = ReplicatedStorage:FindFirstChild(name)
            if frame and frame:IsA("GuiObject") then
                frame.Visible = false
            end
        end
        
        if not _G.frameMonitorConnection then
            _G.frameMonitorConnection = ReplicatedStorage.ChildAdded:Connect(function(child)
                for _, name in ipairs(blockedFrames) do
                    if child.Name == name and child:IsA("GuiObject") then
                        child.Visible = false
                    end
                end
            end)
        end
    else
        for _, name in ipairs(blockedFrames) do
            local frame = ReplicatedStorage:FindFirstChild(name)
            if frame and frame:IsA("GuiObject") then
                frame.Visible = true
            end
        end
        
        if _G.frameMonitorConnection then
            _G.frameMonitorConnection:Disconnect()
            _G.frameMonitorConnection = nil
        end
    end
end)
frameSwitch:Set(false)


MainTab:AddLabel("Misc:").TextSize = 22

MainTab:AddSwitch("Infinite Jump", function(bool)
    _G.InfiniteJump = bool
    
    if bool then
        local InfiniteJumpConnection
        InfiniteJumpConnection = game:GetService("UserInputService").JumpRequest:Connect(function()
            if _G.InfiniteJump then
                game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
            else
                InfiniteJumpConnection:Disconnect()
            end
        end)
    end
end)


local parts = {}
local partSize = 2048
local totalDistance = 50000
local startPosition = Vector3.new(-2, -9.5, -2)

local function createAllParts()
    local numberOfParts = math.ceil(totalDistance / partSize)
    
    for x = 0, numberOfParts - 1 do
        for z = 0, numberOfParts - 1 do
            local function createPart(pos, name)
                local part = Instance.new("Part")
                part.Size = Vector3.new(partSize, 1, partSize)
                part.Position = pos
                part.Anchored = true
                part.Transparency = 1
                part.CanCollide = true
                part.Name = name
                part.Parent = workspace
                return part
            end
            
            table.insert(parts, createPart(startPosition + Vector3.new(x*partSize,0,z*partSize), "Part_Side_"..x.."_"..z))
            table.insert(parts, createPart(startPosition + Vector3.new(-x*partSize,0,z*partSize), "Part_LeftRight_"..x.."_"..z))
            table.insert(parts, createPart(startPosition + Vector3.new(-x*partSize,0,-z*partSize), "Part_UpLeft_"..x.."_"..z))
            table.insert(parts, createPart(startPosition + Vector3.new(x*partSize,0,-z*partSize), "Part_UpRight_"..x.."_"..z))
        end
    end
end
task.spawn(createAllParts)

local walkonwaterSwicth =MainTab:AddSwitch("Walk on Water", function(bool)
    for _, part in ipairs(parts) do
        if part and part.Parent then
            part.CanCollide = bool
        end
    end
end)
walkonwaterSwicth:Set(true)

local spinwheelSwitch = MainTab:AddSwitch("Spin Fortune Wheel", function(bool)
    _G.AutoSpinWheel = bool
    
    if bool then
        spawn(function()
            while _G.AutoSpinWheel and wait(1) do
                game:GetService("ReplicatedStorage").rEvents.openFortuneWheelRemote:InvokeServer("openFortuneWheel", game:GetService("ReplicatedStorage").fortuneWheelChances["Fortune Wheel"])
            end
        end)
    end
end)

local timeDropdown = MainTab:AddDropdown("Change Time", function(selection)
    local lighting = game:GetService("Lighting")
    
    if selection == "Night" then
        lighting.ClockTime = 0
    elseif selection == "Day" then
        lighting.ClockTime = 12
    elseif selection == "Midnight" then
        lighting.ClockTime = 6
    end
end)

timeDropdown:Add("Night")
timeDropdown:Add("Day")
timeDropdown:Add("Midnight")


local function checkCharacter()
    if not game.Players.LocalPlayer.Character then
        repeat task.wait() until game.Players.LocalPlayer.Character
    end
    return game.Players.LocalPlayer.Character
end

local function gettool()
    for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        if v.Name == "Punch" and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
            game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
        end
    end
    game.Players.LocalPlayer.muscleEvent:FireServer("punch", "leftHand")
    game.Players.LocalPlayer.muscleEvent:FireServer("punch", "rightHand")
end

local function isPlayerAlive(player)
    return player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and
           player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0
end

local function killPlayer(target)
    if not isPlayerAlive(target) then return end
    local character = checkCharacter()
    if character and character:FindFirstChild("LeftHand") then
        pcall(function()
            firetouchinterest(target.Character.HumanoidRootPart, character.LeftHand, 0)
            firetouchinterest(target.Character.HumanoidRootPart, character.LeftHand, 1)
            gettool()
        end)
    end
end

KillingTab:AddLabel("Misc:").TextSize = 22


local dropdown = KillingTab:AddDropdown("Select Pack Pets", function(text)
    local petsFolder = game.Players.LocalPlayer.petsFolder
    for _, folder in pairs(petsFolder:GetChildren()) do
        if folder:IsA("Folder") then
            for _, pet in pairs(folder:GetChildren()) do
                game:GetService("ReplicatedStorage").rEvents.equipPetEvent:FireServer("unequipPet", pet)
            end
        end
    end
    task.wait(0.2)

    local petName = text
    local petsToEquip = {}

    for _, pet in pairs(game.Players.LocalPlayer.petsFolder.Unique:GetChildren()) do
        if pet.Name == petName then
            table.insert(petsToEquip, pet)
        end
    end

    for i = 1, math.min(8, #petsToEquip) do
        game:GetService("ReplicatedStorage").rEvents.equipPetEvent:FireServer("equipPet", petsToEquip[i])
        task.wait(0.1)
    end
end)
dropdown:Add("Wild Wizard")
dropdown:Add("Mighty Monster")
dropdown:Add("Chaos Sorcerer")
dropdown:Add("Small Fry")

local switch = KillingTab:AddSwitch("Remove Attack Animations", function(bool)
    if bool then
        local blockedAnimations = {
            ["rbxassetid://3638729053"] = true,
            ["rbxassetid://3638767427"] = true,
        }

        local function setupAnimationBlocking()
            local char = game.Players.LocalPlayer.Character
            if not char or not char:FindFirstChild("Humanoid") then return end

            local humanoid = char:FindFirstChild("Humanoid")

            for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
                if track.Animation then
                    local animId = track.Animation.AnimationId
                    local animName = track.Name:lower()

                    if blockedAnimations[animId] or animName:match("punch") or animName:match("attack") or animName:match("right") then
                        track:Stop()
                    end
                end
            end

            _G.AnimBlockConnection = humanoid.AnimationPlayed:Connect(function(track)
                if track.Animation then
                    local animId = track.Animation.AnimationId
                    local animName = track.Name:lower()

                    if blockedAnimations[animId] or animName:match("punch") or animName:match("attack") or animName:match("right") then
                        track:Stop()
                    end
                end
            end)
        end

        local function processTool(tool)
            if tool and (tool.Name == "Punch" or tool.Name:match("Attack") or tool.Name:match("Right")) then
                if not tool:GetAttribute("ActivatedOverride") then
                    tool:SetAttribute("ActivatedOverride", true)

                    _G.ToolConnections = _G.ToolConnections or {}
                    _G.ToolConnections[tool] = tool.Activated:Connect(function()
                        task.wait(0.05)
                        local char = game.Players.LocalPlayer.Character
                        if char and char:FindFirstChild("Humanoid") then
                            for _, track in pairs(char.Humanoid:GetPlayingAnimationTracks()) do
                                if track.Animation then
                                    local animId = track.Animation.AnimationId
                                    local animName = track.Name:lower()

                                    if blockedAnimations[animId] or animName:match("punch") or animName:match("attack") or animName:match("right") then
                                        track:Stop()
                                    end
                                end
                            end
                        end
                    end)
                end
            end
        end

        local function overrideToolActivation()
            for _, tool in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                processTool(tool)
            end

            local char = game.Players.LocalPlayer.Character
            if char then
                for _, tool in pairs(char:GetChildren()) do
                    if tool:IsA("Tool") then
                        processTool(tool)
                    end
                end
            end

            _G.BackpackAddedConnection = game.Players.LocalPlayer.Backpack.ChildAdded:Connect(function(child)
                if child:IsA("Tool") then
                    task.wait(0.1)
                    processTool(child)
                end
            end)

            if char then
                _G.CharacterToolAddedConnection = char.ChildAdded:Connect(function(child)
                    if child:IsA("Tool") then
                        task.wait(0.1)
                        processTool(child)
                    end
                end)
            end
        end

        _G.AnimMonitorConnection = game:GetService("RunService").Heartbeat:Connect(function()
            if tick() % 0.5 < 0.01 then
                local char = game.Players.LocalPlayer.Character
                if char and char:FindFirstChild("Humanoid") then
                    for _, track in pairs(char.Humanoid:GetPlayingAnimationTracks()) do
                        if track.Animation then
                            local animId = track.Animation.AnimationId
                            local animName = track.Name:lower()

                            if blockedAnimations[animId] or animName:match("punch") or animName:match("attack") or animName:match("right") then
                                track:Stop()
                            end
                        end
                    end
                end
            end
        end)

        _G.CharacterAddedConnection = game.Players.LocalPlayer.CharacterAdded:Connect(function(newChar)
            task.wait(1)
            setupAnimationBlocking()
            overrideToolActivation()

            if _G.CharacterToolAddedConnection then
    
