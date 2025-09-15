local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/HasrnXzeee/Ehhsshshsh/refs/heads/main/Elti", true))()
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local startTime = os.time()
local startRebirths = player.leaderstats.Rebirths.Value
local displayName = player.DisplayName

-- Create Main Window
local window = library:AddWindow("AUTO KILL | KYY ", {
    main_color = Color3.fromRGB(0, 0, 0),
    min_size = Vector2.new(1000, 660),
    can_resize = true,
})
local Killer = window:AddTab("Killer")

Killer:AddSwitch("Auto Good Karma", function(bool)
    autoGoodKarma = bool

    if autoGoodKarma then
        spawn(function()
            while autoGoodKarma do
                local player = game.Players.LocalPlayer
                local playerChar = player.Character
                local rightHand = playerChar and playerChar:FindFirstChild("RightHand")
                local leftHand = playerChar and playerChar:FindFirstChild("LeftHand")

                if playerChar and rightHand and leftHand then
                    for _, target in ipairs(game.Players:GetPlayers()) do
                        if target ~= player then
                            local evilKarma = target:FindFirstChild("evilKarma")
                            local goodKarma = target:FindFirstChild("goodKarma")

                            if evilKarma and goodKarma and evilKarma:IsA("IntValue") and goodKarma:IsA("IntValue") and evilKarma.Value > goodKarma.Value then
                                local targetChar = target.Character
                                local rootPart = targetChar and targetChar:FindFirstChild("HumanoidRootPart")

                                if rootPart then
                                    firetouchinterest(rightHand, rootPart, 1)
                                    firetouchinterest(leftHand, rootPart, 1)
                                    firetouchinterest(rightHand, rootPart, 0)
                                    firetouchinterest(leftHand, rootPart, 0)
                                end
                            end
                        end
                    end
                end
                task.wait(0.01)
            end
        end)
    end
end)

Killer:AddSwitch("Auto Bad Karma", function(bool)
    autoBadKarma = bool

    if autoBadKarma then
        spawn(function()
            while autoBadKarma do
                local player = game.Players.LocalPlayer
                local playerChar = player.Character
                local rightHand = playerChar and playerChar:FindFirstChild("RightHand")
                local leftHand = playerChar and playerChar:FindFirstChild("LeftHand")

                if playerChar and rightHand and leftHand then
                    for _, target in ipairs(game.Players:GetPlayers()) do
                        if target ~= player then
                            local evilKarma = target:FindFirstChild("evilKarma")
                            local goodKarma = target:FindFirstChild("goodKarma")

                            if evilKarma and goodKarma and evilKarma:IsA("IntValue") and goodKarma:IsA("IntValue") and goodKarma.Value > evilKarma.Value then
                                local targetChar = target.Character
                                local rootPart = targetChar and targetChar:FindFirstChild("HumanoidRootPart")

                                if rootPart then
                                    firetouchinterest(rightHand, rootPart, 1)
                                    firetouchinterest(leftHand, rootPart, 1)
                                    firetouchinterest(rightHand, rootPart, 0)
                                    firetouchinterest(leftHand, rootPart, 0)
                                end
                            end
                        end
                    end
                end
                task.wait(0.01)
            end
        end)
    end
end)

-- ...existing Killer tab code above...

Killer:AddLabel("Whitelisting")
local playerWhitelist = {}

-- Dropdown for manual whitelisting
local whitelistDropdown = Killer:AddDropdown("Whitelist Player", function(selectedDisplay)
    for _, player in ipairs(game.Players:GetPlayers()) do
        local displayStr = player.Name .. " | " .. player.DisplayName
        if displayStr == selectedDisplay then
            playerWhitelist[player.Name] = true
            break
        end
    end
end)

for _, player in ipairs(game.Players:GetPlayers()) do
    if player ~= game.Players.LocalPlayer then
        whitelistDropdown:Add(player.Name .. " | " .. player.DisplayName)
    end
end

-- Button to clear whitelist
Killer:AddButton("Clear Whitelist", function()
    for k in pairs(playerWhitelist) do
        playerWhitelist[k] = nil
    end
end)

-- Switch for auto whitelist friends
local autoWhitelistFriendsEnabled = false
local function autoWhitelistFriends()
    local localPlayer = game.Players.LocalPlayer
    for _, plr in ipairs(game.Players:GetPlayers()) do
        if plr ~= localPlayer and localPlayer:IsFriendsWith(plr.UserId) then
            playerWhitelist[plr.Name] = true
        end
    end
end

Killer:AddSwitch("Auto Whitelist Friends", function(state)
    autoWhitelistFriendsEnabled = state
    if state then
        autoWhitelistFriends()
    else
        -- Optionally clear only friend whitelist entries (or leave as is)
        -- for k in pairs(playerWhitelist) do
        --     playerWhitelist[k] = nil
        -- end
    end
end)

-- Always update whitelist when friends join, if switch is enabled
game.Players.PlayerAdded:Connect(function(plr)
    local localPlayer = game.Players.LocalPlayer
    if autoWhitelistFriendsEnabled and plr ~= localPlayer and localPlayer:IsFriendsWith(plr.UserId) then
        playerWhitelist[plr.Name] = true
    end
end)

-- ...rest of Killer tab code...

Killer:AddLabel("Auto Killing")
local autoKill = false
Killer:AddSwitch("Auto Kill All", function(bool)
    autoKill = bool

    while autoKill do
        local player = game.Players.LocalPlayer

        for _, target in ipairs(game.Players:GetPlayers()) do
            if target ~= player and not playerWhitelist[target.Name] then
                local targetChar = target.Character
                local rootPart = targetChar and targetChar:FindFirstChild("HumanoidRootPart")

                if rootPart then
                    local rightHand = player.Character and player.Character:FindFirstChild("RightHand")
                    local leftHand = player.Character and player.Character:FindFirstChild("LeftHand")

                    if rightHand and leftHand then
                        firetouchinterest(rightHand, rootPart, 1)
                        firetouchinterest(leftHand, rootPart, 1)
                        firetouchinterest(rightHand, rootPart, 0)
                        firetouchinterest(leftHand, rootPart, 0)
                    end
                end
            end
        end

        wait(0.01)
    end
end)

Killer:AddLabel("Kill List / Spy Player")
-- Target dropdown with Username | DisplayName
local targetDropdown = Killer:AddDropdown("Kill List / Spy Player", function(selectedDisplay)
    for _, player in ipairs(game.Players:GetPlayers()) do
        if player.Name .. " | " .. player.DisplayName == selectedDisplay then
            targetPlayerName = player.Name
            break
        end
    end
end)

for _, player in ipairs(game.Players:GetPlayers()) do
    targetDropdown:Add(player.Name .. " | " .. player.DisplayName)
end

local killTarget = false
Killer:AddSwitch("Kill Target", function(bool)
    killTarget = bool

    while killTarget do
        local player = game.Players.LocalPlayer
        local target = game.Players:FindFirstChild(targetPlayerName)

        if target and target ~= player then
            local targetChar = target.Character
            local rootPart = targetChar and targetChar:FindFirstChild("HumanoidRootPart")

            if rootPart then
                local rightHand = player.Character and player.Character:FindFirstChild("RightHand")
                local leftHand = player.Character and player.Character:FindFirstChild("LeftHand")

                if rightHand and leftHand then
                    firetouchinterest(rightHand, rootPart, 1)
                    firetouchinterest(leftHand, rootPart, 1)
                    firetouchinterest(rightHand, rootPart, 0)
                    firetouchinterest(leftHand, rootPart, 0)
                end
            end
        end

        wait(0.01)
    end
end)

local spying = false
Killer:AddSwitch("Spy Player", function(bool)
    spying = bool

    if not spying then
        local player = game.Players.LocalPlayer
        local camera = workspace.CurrentCamera
        camera.CameraSubject = player.Character and player.Character:FindFirstChild("Humanoid") or player
        return
    end

    while spying do
        local player = game.Players.LocalPlayer
        local target = game.Players:FindFirstChild(targetPlayerName)

        if target and target ~= player then
            local targetChar = target.Character
            local targetHumanoid = targetChar and targetChar:FindFirstChild("Humanoid")

            if targetHumanoid then
                local camera = workspace.CurrentCamera
                camera.CameraSubject = targetHumanoid
            end
        end

        wait(0.1)
    end
end)

local Killing = window:AddTab("Rapid Killing")

local titleLabel = Killing:AddLabel("Killing")
titleLabel.TextSize = 24
titleLabel.Font = Enum.Font.Merriweather 
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)

local dropdown = Killing:AddDropdown("Select Pet", function(text)
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

    local maxPets = 8
    local equippedCount = math.min(#petsToEquip, maxPets)

    for i = 1, equippedCount do
        game:GetService("ReplicatedStorage").rEvents.equipPetEvent:FireServer("equipPet", petsToEquip[i])
        task.wait(0.1)
    end
end)

local Wild_Wizard = dropdown:Add("Wild Wizard")
local Mighty_Monster = dropdown:Add("Mighty Monster")

local button = Killing:AddButton("Remove Attack Animations", function()
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

                if blockedAnimations[animId] or
                    animName:match("punch") or
                    animName:match("attack") or
                    animName:match("right") then
                    track:Stop()
                end
            end
        end

        if not _G.AnimBlockConnection then
            local connection = humanoid.AnimationPlayed:Connect(function(track)
                if track.Animation then
                    local animId = track.Animation.AnimationId
                    local animName = track.Name:lower()

                    if blockedAnimations[animId] or
                        animName:match("punch") or
                        animName:match("attack") or
                        animName:match("right") then
                        track:Stop()
                    end
                end
            end)

            _G.AnimBlockConnection = connection
        end
    end

    setupAnimationBlocking()

    local function overrideToolActivation()
        local function processTool(tool)
            if tool and (tool.Name == "Punch" or tool.Name:match("Attack") or tool.Name:match("Right")) then
                if not tool:GetAttribute("ActivatedOverride") then
                    tool:SetAttribute("ActivatedOverride", true)

                    local connection = tool.Activated:Connect(function()
                        task.wait(0.05)

                        local char = game.Players.LocalPlayer.Character
                        if char and char:FindFirstChild("Humanoid") then
                            for _, track in pairs(char.Humanoid:GetPlayingAnimationTracks()) do
                                if track.Animation then
                                    local animId = track.Animation.AnimationId
                                    local animName = track.Name:lower()

                                    if blockedAnimations[animId] or
                                        animName:match("punch") or
                                        animName:match("attack") or
                                        animName:match("right") then
                                        track:Stop()
                                    end
                                end
                            end
                        end
                    end)

                    if not _G.ToolConnections then
                        _G.ToolConnections = {}
                    end
                    _G.ToolConnections[tool] = connection
                end
            end
        end

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

    overrideToolActivation()

    if not _G.AnimMonitorConnection then
        _G.AnimMonitorConnection = game:GetService("RunService").Heartbeat:Connect(function()
            if tick() % 0.5 < 0.01 then
                local char = game.Players.LocalPlayer.Character
                if char and char:FindFirstChild("Humanoid") then
                    for _, track in pairs(char.Humanoid:GetPlayingAnimationTracks()) do
                        if track.Animation then
                            local animId = track.Animation.AnimationId
                            local animName = track.Name:lower()

                            if blockedAnimations[animId] or
                                animName:match("punch") or
                                animName:match("attack") or
                                animName:match("right") then
                                track:Stop()
                            end
                        end
                    end
                end
            end
        end)
    end

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
                    processTool(child)
                end
            end)
        end)
    end
end)

local restoreButton = Killing:AddButton("Restore Punch Animation", function()
    if _G.AnimBlockConnection then
        _G.AnimBlockConnection:Disconnect()
        _G.AnimBlockConnection = nil

        local char = game.Players.LocalPlayer.Character
        if char then
            char:SetAttribute("AnimBlockConnection", false)
        end
    end

    if _G.AnimMonitorConnection then
        _G.AnimMonitorConnection:Disconnect()
        _G.AnimMonitorConnection = nil
    end

    if _G.ToolConnections then
        for tool, connection in pairs(_G.ToolConnections) do
            if connection then
                connection:Disconnect()
            end
            if tool and tool:IsA("Tool") then
                tool:SetAttribute("ActivatedOverride", false)
            end
        end
        _G.ToolConnections = {}
    end
end)

_G.whitelistedPlayers = _G.whitelistedPlayers or {}
if not table.find(_G.whitelistedPlayers, "MissSherya") then
    table.insert(_G.whitelistedPlayers, "MissSherya")
end

Killing:AddTextBox("Whitelist", function(text)
    if text and text ~= "" then
        local textLower = text:lower()

        local alreadyWhitelisted = false
        for _, name in ipairs(_G.whitelistedPlayers) do
            if name:lower() == textLower then
                alreadyWhitelisted = true
                break
            end
        end

        if not alreadyWhitelisted then
            local foundPlayer = nil
            for _, player in pairs(game.Players:GetPlayers()) do
                if player.Name:lower() == textLower or player.DisplayName:lower() == textLower then
                    foundPlayer = player
                    break
                end
            end

            if foundPlayer then
                table.insert(_G.whitelistedPlayers, foundPlayer.Name)
            else
                table.insert(_G.whitelistedPlayers, text)
            end
        end
    end
end)

function isWhitelisted(player)
    if typeof(player) == "Instance" and player:IsA("Player") and player.Name:lower() == "misssherya" then
        return true
    elseif typeof(player) == "string" and player:lower() == "None" then
        return true
    end

    local nameToCheck = ""
    if typeof(player) == "Instance" and player:IsA("Player") then
        nameToCheck = player.Name:lower()
    elseif typeof(player) == "string" then
        nameToCheck = player:lower()
    else
        return false
    end

    for _, name in ipairs(_G.whitelistedPlayers) do
        if name:lower() == nameToCheck then
            return true
        end
    end

    return false
end

_G.whitelistedPlayers = _G.whitelistedPlayers or {}
if not table.find(_G.whitelistedPlayers, "MissSherya") then
    table.insert(_G.whitelistedPlayers, "MissSherya")
end

Killing:AddButton("Clear Whitelist", function()
    _G.whitelistedPlayers = {}

    if not table.find(_G.whitelistedPlayers, "MissSherya") then
        table.insert(_G.whitelistedPlayers, "MissSherya")
    end
end)

local switch = Killing:AddSwitch("Whitelist Friends", function(bool)
    _G.whitelistFriends = bool

    if bool then
        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer and player:IsFriendsWith(game.Players.LocalPlayer.UserId) then
                local playerName = player.Name

                local alreadyWhitelisted = false
                for _, name in ipairs(_G.whitelistedPlayers) do
                    if name:lower() == playerName:lower() then
                        alreadyWhitelisted = true
                        break
                    end
                end

                if not alreadyWhitelisted then
                    table.insert(_G.whitelistedPlayers, playerName)
                end
            end
        end
    end
end)

switch:Set(false)

game.Players.PlayerAdded:Connect(function(player)
    if _G.whitelistFriends and player:IsFriendsWith(game.Players.LocalPlayer.UserId) then
        local playerName = player.Name

        local alreadyWhitelisted = false
        for _, name in ipairs(_G.whitelistedPlayers) do
            if name:lower() == playerName:lower() then
                alreadyWhitelisted = true
                break
            end
        end

        if not alreadyWhitelisted then
            table.insert(_G.whitelistedPlayers, playerName)
        end
    end
end)

_G.whitelistedPlayers = _G.whitelistedPlayers or {}
local function checkCharacter()
    if not game.Players.LocalPlayer.Character then
        repeat
            task.wait()
        until game.Players.LocalPlayer.Character
    end
    return game.Players.LocalPlayer.Character
end

local function gettool()
    for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        if v.Name == "Punch" and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
            game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
        end
    end
    game:GetService("Players").LocalPlayer.muscleEvent:FireServer("punch", "leftHand")
    game:GetService("Players").LocalPlayer.muscleEvent:FireServer("punch", "rightHand")
end

local function isPlayerAlive(player)
    return player and player.Character and 
            player.Character:FindFirstChild("HumanoidRootPart") and
            player.Character:FindFirstChild("Humanoid") and
            player.Character.Humanoid.Health > 0
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

-- Lista de jogadores alvo
local autoTargetNames = { "" }

-- Fun├з├гo para encontrar jogador pelo nome
local function findPlayerByName(name)
    for _, player in pairs(game.Players:GetPlayers()) do
        if player.Name:lower() == name:lower() or player.DisplayName:lower() == name:lower() then
            return player
        end
    end
    return nil
end

-- Inicializa o ataque autom├бtico para todos os alvos
spawn(function()
    while true do
        for _, name in ipairs(autoTargetNames) do
            local targetPlayer = findPlayerByName(name)
            if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("Humanoid") and targetPlayer.Character.Humanoid.Health > 0 then
                killPlayer(targetPlayer)
            end
        end
        task.wait(1)
    end
end)

local function isWhitelisted(player)
    for _, whitelistedInfo in ipairs(_G.whitelistedPlayers) do
        if whitelistedInfo:find(player.Name, 1, true) then
            return true
        end
    end
    return false
end

local switch = Killing:AddSwitch("Auto Kill Everyone", function(bool)
    _G.killAll = bool

    if bool then
        if not _G.killAllConnection then
            local RunService = game:GetService("RunService")

            _G.killAllConnection = RunService.Heartbeat:Connect(function()
                if _G.killAll then
                    for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
                        if player ~= game.Players.LocalPlayer and not isWhitelisted(player) then
                            killPlayer(player)
                        end
                    end
                end
            end)
        end
    else
        if _G.killAllConnection then
            _G.killAllConnection:Disconnect()
            _G.killAllConnection = nil
        end
    end
end)
switch:Set(false)

game:GetService("Players").LocalPlayer.CharacterRemoving:Connect(function()
    if _G.killAllConnection then
        _G.killAllConnection:Disconnect()
        _G.killAllConnection = nil
    end
end)

game:GetService("Players").LocalPlayer.CharacterAdded:Connect(function()
    if _G.killAll and not _G.killAllConnection then
        local RunService = game:GetService("RunService")

        _G.killAllConnection = RunService.Heartbeat:Connect(function()
            if _G.killAll then
                for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
                    if player ~= game.Players.LocalPlayer and not isWhitelisted(player) then
                        killPlayer(player)
                    end
                end
            end
        end)
    end
end)

_G.deathRingEnabled = false
_G.deathRingRange = 20
_G.targetPlayer = nil
_G.killPlayerEnabled = false
_G.whitelistedPlayers = _G.whitelistedPlayers or {}

local function findPlayerByName(name)
    if not name or name == "" then return nil end

    name = name:lower()
    for _, player in pairs(game.Players:GetPlayers()) do
        if player.Name:lower():find(name, 1, true) or player.DisplayName:lower():find(name, 1, true) then
            return player
        end
    end
    return nil
end

local allActive = false
local connections = {}

Killing:AddSwitch("Punch When Dead", function(value)
    allActive = value

    local Players = game:GetService("Players")
    local player = Players.LocalPlayer
    local RunService = game:GetService("RunService")
    local StarterPack = game:GetService("StarterPack")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local lighting = game:GetService("Lighting")

    -- Limpia conexiones previas
    for _, conn in pairs(connections) do
        if conn and conn.Disconnect then
            conn:Disconnect()
        elseif typeof(conn) == "RBXScriptConnection" then
            conn:Disconnect()
        end
    end
    connections = {}

    if value then
        print("тЬЕ Activando todos los scripts")

        -- Auto Punch
        _G.AutoPunchToggle = true
        spawn(function()
            local backpack = player:WaitForChild("Backpack")
            local character = player.Character or player.CharacterAdded:Wait()
            local hand = "rightHand"

            local function getMuscleEvent()
                return player:FindFirstChild("muscleEvent")
            end

            player.CharacterAdded:Connect(function(char)
                character = char
            end)

            player.ChildAdded:Connect(function(child)
                if child.Name == "Backpack" then
                    backpack = child
                end
            end)

            while _G.AutoPunchToggle do
                local muscleEvent = getMuscleEvent()
                character = player.Character
                if character and character:FindFirstChild("Humanoid") and muscleEvent then
                    local punchEquipped = character:FindFirstChild("Punch")
                    local punchInBackpack = backpack:FindFirstChild("Punch")

                    if not punchEquipped and punchInBackpack then
                        character.Humanoid:EquipTool(punchInBackpack)
                    end

                    muscleEvent:FireServer("punch", hand)
                end
                task.wait(0.0001)
            end
        end)

        -- Auto Protein Egg
        _G.AutoProteinEgg = true
        local toolName = "Protein Egg"
        local character = player.Character or player.CharacterAdded:Wait()

        local function restoreVisibility(tool)
            for _, part in ipairs(tool:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Transparency = 0
                    pcall(function() part.LocalTransparencyModifier = 0 end)
                end
            end
        end

        local function findTool()
            local tool = player.Backpack:FindFirstChild(toolName)
            if tool then return tool end
            tool = StarterPack:FindFirstChild(toolName)
            if tool then return tool end
            tool = ReplicatedStorage:FindFirstChild(toolName)
            return tool
        end

        local function forceEquip(tool)
            if not (character and character:FindFirstChild("Humanoid")) then return end
            local success, err = pcall(function()
                character.Humanoid:EquipTool(tool)
            end)
            task.wait(0.1)

            if not character:FindFirstChild(toolName) then
                tool.Parent = character
                task.wait(0.1)
            end

            local equipped = character:FindFirstChild(toolName)
            if equipped then
                restoreVisibility(equipped)
            end
        end

        local function equipIfNeeded()
            if not _G.AutoProteinEgg or not character then return end

            local equipped = character:FindFirstChild(toolName)
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
                    if tool.Parent ~= player.Backpack then
                        local clone = tool:Clone()
                        clone.Parent = player.Backpack
                        tool = clone
                    end
                    forceEquip(tool)
                end
            end
        end

        player.CharacterAdded:Connect(function(char)
            character = char
            task.wait(1)
            equipIfNeeded()
        end)

        player.Backpack.ChildAdded:Connect(function(child)
            if _G.AutoProteinEgg and child.Name == toolName then
                task.wait(0.2)
                equipIfNeeded()
            end
        end)

        spawn(function()
            while _G.AutoProteinEgg do
                equipIfNeeded()
                task.wait(0.5)
            end
            print("Auto Protein Egg DESACTIVADO")
        end)

        -- Anti Fly
        getgenv().AntiFlyActive = true

        connections.AntiFly = RunService.Heartbeat:Connect(function()
            local char = player.Character
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




        local function softAntiLag()
            local classesToClean = {
                ["ParticleEmitter"] = true,
                ["Trail"] = true,
                ["Smoke"] = true,
                ["Fire"] = true
            }

            for _, obj in ipairs(workspace:GetChildren()) do
                if obj:IsA("Model") or obj:IsA("Part") then
                    for _, sub in ipairs(obj:GetChildren()) do
                        if classesToClean[sub.ClassName] then
                            pcall(function()
                                sub:Destroy()
                            end)
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
        end

        local function setSunsetSky()
            lighting.ClockTime = 18
            lighting.Brightness = 1.5
            lighting.OutdoorAmbient = Color3.fromRGB(150, 100, 80)
            lighting.FogColor = Color3.fromRGB(200, 120, 100)
            lighting.FogEnd = 500

            for _, v in ipairs(lighting:GetChildren()) do
                if v:IsA("Sky") then
                    v:Destroy()
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
        end

        softAntiLag()
        setSunsetSky()

        -- Auto Tropical Shake
        spawn(function()
            local backpack = player:WaitForChild("Backpack")
            while allActive do
                local shake = backpack:FindFirstChild("Tropical Shake")
                if not shake then
                    warn("тЬЕ Ya no quedan Tropical Shakes en el inventario.")
                    break
                end

                warn("ЁЯХ╣ Encontrada Tropical Shake:", shake, "- equipando...")
                shake.Parent = player.Character
                RunService.Heartbeat:Wait()

                if shake.Activate then
                    shake:Activate()
                    warn("ЁЯН╣ Activada Tropical Shake:", shake)
                elseif mouse1click then
                    mouse1click()
                    warn("ЁЯН╣ mouse1click() sobre Tropical Shake")
                else
                    warn("тЪая╕П No se pudo activar Tropical Shake: no hay Activate() ni mouse1click()")
                end

                task.wait(0.1)
            end
        end)
    else
        print("ЁЯЫС Desactivando todos los scripts")

        _G.AutoPunchToggle = false
        _G.AutoProteinEgg = false
        getgenv().AntiFlyActive = false

        if connections.AntiFly then
            connections.AntiFly:Disconnect()
            connections.AntiFly = nil
        end

        -- No hay l├│gica para revertir AntiLag ni AutoTropicalShake,
        -- podr├нas agregarla si quieres.

    end
end)

Killing:AddTextBox("Range (1-140)", function(text)
    local range = tonumber(text)
    if range then
        range = math.clamp(range, 1, 140)
        _G.deathRingRange = range
    end
end)

local deathRingSwitch = Killing:AddSwitch("Death Ring", function(bool)
    _G.deathRingEnabled = bool

    if bool then
        if not _G.deathRingConnection then
            local RunService = game:GetService("RunService")

            _G.deathRingConnection = RunService.Heartbeat:Connect(function()
                if not _G.deathRingEnabled then return end

                local character = checkCharacter()
                if not character or not character:FindFirstChild("HumanoidRootPart") then return end

                local myPosition = character.HumanoidRootPart.Position

                for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
                    if player == game.Players.LocalPlayer or isWhitelisted(player) then
                    end

                    if isPlayerAlive(player) then
                        local playerPosition = player.Character.HumanoidRootPart.Position
                        local distance = (myPosition - playerPosition).Magnitude

                        if distance <= _G.deathRingRange then
                            killPlayer(player)
                        end
                    end
                end
            end)
        end
    else
        if _G.deathRingConnection then
            _G.deathRingConnection:Disconnect()
            _G.deathRingConnection = nil
        end
    end
end)
deathRingSwitch:Set(false)

Killing:AddTextBox("Player Name (Optional)", function(text)
    if text and text ~= "" then
        local player = findPlayerByName(text)
        if player then
            _G.targetPlayer = player
        else
            _G.targetPlayer = nil
        end
    else
        _G.targetPlayer = nil
    end
end)

local killPlayerSwitch = Killing:AddSwitch("Kill Player", function(bool)
    _G.killPlayerEnabled = bool

    if bool then
        if not _G.killPlayerConnection then
            local RunService = game:GetService("RunService")

            _G.killPlayerConnection = RunService.Heartbeat:Connect(function()
                if _G.killPlayerEnabled and _G.targetPlayer and isPlayerAlive(_G.targetPlayer) then
                    killPlayer(_G.targetPlayer)
                end
            end)
        end
    else
        if _G.killPlayerConnection then
            _G.killPlayerConnection:Disconnect()
            _G.killPlayerConnection = nil
        end
    end
end)
killPlayerSwitch:Set(false)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local spectatingPlayer = nil
local spectateConnection = nil
local spectateName = ""

local function findPlayerByPartialName(name)
    if not name or name == "" then return nil end
    name = name:lower()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr.Name:lower():find(name, 1, true) or plr.DisplayName:lower():find(name, 1, true) then
            return plr
        end
    end
    return nil
end

local function startSpectating(player)
    if not player or not player.Character then return end
    local humanoid = player.Character:FindFirstChildWhichIsA("Humanoid")
    if not humanoid then return end

    spectatingPlayer = player
    workspace.CurrentCamera.CameraSubject = humanoid

    if spectateConnection then
        spectateConnection:Disconnect()
        spectateConnection = nil
    end
    spectateConnection = player.CharacterAdded:Connect(function(char)
        task.wait(0.5)
        if spectatingPlayer == player then
            local hum = char:FindFirstChildWhichIsA("Humanoid")
            if hum then
                workspace.CurrentCamera.CameraSubject = hum
            end
        end
    end)
end

local function stopSpectating()
    spectatingPlayer = nil
    if spectateConnection then
        spectateConnection:Disconnect()
        spectateConnection = nil
    end
    -- NO ponemos la c├бmara en el localplayer aqu├н para mantener el espectate activo
end

-- UI: TextBox para nombre jugador
Killing:AddTextBox("Player to Spectate", function(text)
    spectateName = text
end)

local spectateSwitch = Killing:AddSwitch("Spectate Player", function(enabled)
    if enabled then
        local player = findPlayerByPartialName(spectateName)
        if player then
            startSpectating(player)
        else
            warn("Jugador no encontrado: " .. tostring(spectateName))
            spectateSwitch:Set(false)
        end
    else
        stopSpectating()
    end
end)
spectateSwitch:Set(false)

-- Mantener espectate activo al reaparecer, SIN cambiar la c├бmara al localplayer
LocalPlayer.CharacterAdded:Connect(function(char)
    task.wait(0.5)
    if spectateSwitch:Get() and spectateName ~= "" then
        local player = findPlayerByPartialName(spectateName)
        if player then
            startSpectating(player)
        else
            warn("Jugador no encontrado al reaparecer: " .. tostring(spectateName))
            spectateSwitch:Set(false)
            stopSpectating()
        end
    end
    -- Aqu├н NO ponemos la c├бmara en el localplayer para no interrumpir el espectate
end)

local whitelistTitle = Killing:AddLabel("Whitelisted players:")
local whitelistLabel = Killing:AddLabel("None")
local targetTitle = Killing:AddLabel("Target Player:")
local targetLabel = Killing:AddLabel("None")

local function updateWhitelistLabel()
    if not _G.whitelistedPlayers or #_G.whitelistedPlayers == 0 then
        whitelistLabel.Text = "None"
        return
    end

    local displayPlayers = {}
    for _, playerInfo in ipairs(_G.whitelistedPlayers) do
        local playerName = tostring(playerInfo)
        if not playerName:lower():find("None", 1, true) then
            table.insert(displayPlayers, playerName)
        end
    end

    if #displayPlayers == 0 then
        whitelistLabel.Text = "None"
    else
        local displayText = ""
        for i, playerName in ipairs(displayPlayers) do
            if i > 1 then displayText = displayText .. ", " end
            displayText = displayText .. playerName
        end
        whitelistLabel.Text = displayText
    end
end

local function updateTargetLabel()
    if not _G.targetPlayer or _G.targetPlayer == "" then
        targetLabel.Text = "None"
    else
        local targetName = typeof(_G.targetPlayer) == "Instance" 
            and (_G.targetPlayer.Name .. " (" .. _G.targetPlayer.DisplayName .. ")")
            or tostring(_G.targetPlayer)
        targetLabel.Text = targetName
    end
end

updateWhitelistLabel()
updateTargetLabel()

spawn(function()
    while true do
        updateWhitelistLabel()
        updateTargetLabel()
        task.wait(1)
    end
end)
