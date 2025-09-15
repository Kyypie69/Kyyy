
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
local Main = window:AddTab("Main")
local farmPlusTab = window:AddTab("Farm")

Main:AddLabel("Local Player")

local walkSpeedValue = 16
Main:AddTextBox("WalkSpeed", function(text)
    local speed = tonumber(text)
    if speed and speed >= 1 and speed <= 500 then
        walkSpeedValue = speed
    end
end)

local setSpeed = false
Main:AddSwitch("Set Speed", function(state)
    setSpeed = state
    while setSpeed do
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = walkSpeedValue
        task.wait(0.1)
    end
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
end)

local jumpPowerValue = 50
Main:AddTextBox("JumpPower", function(text)
    local jump = tonumber(text)
    if jump then
        jumpPowerValue = jump
    end
end)

local applyJumpPower = false
Main:AddSwitch("Apply JumpPower", function(state)
    applyJumpPower = state
    local humanoid = game.Players.LocalPlayer.Character.Humanoid
    humanoid.UseJumpPower = true
    humanoid.JumpPower = applyJumpPower and jumpPowerValue or 50
end)

local sizeValue = 1
Main:AddTextBox("Size", function(text)
    local size = tonumber(text)
    if size and size >= 1 and size <= 100 then
        sizeValue = size
    end
end)

local setSize = false
Main:AddSwitch("Set Sizes", function(state)
    setSize = state
    local char = game.Players.LocalPlayer.Character
    if char then
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if humanoid then
            for _, scale in pairs({"BodyDepthScale", "BodyHeightScale", "BodyWidthScale", "HeadScale"}) do
                local scaleInstance = humanoid:FindFirstChild(scale)
                if scaleInstance then
                    scaleInstance.Value = state and sizeValue or 1
                end
            end
        end
    end
end)

-- Free AutoLift Gamepass Button
farmPlusTab:AddButton("Unlock AutoLift Gamepass", function()
    local gamepassFolder = game:GetService("ReplicatedStorage").gamepassIds
    local player = game:GetService("Players").LocalPlayer
    for _, gamepass in pairs(gamepassFolder:GetChildren()) do
        local value = Instance.new("IntValue")
        value.Name = gamepass.Name
        value.Value = gamepass.Value
        value.Parent = player.ownedGamepasses
    end
end, "Unlock the AutoLift Game Pass for free")
local autoEquipToolsFolder = farmPlusTab:AddFolder("Auto Equip Tools")

-- Auto Weight Toggle
autoEquipToolsFolder:AddSwitch("Auto Weight", function(Value)
    _G.AutoWeight = Value
    
    if Value then
        local weightTool = game.Players.LocalPlayer.Backpack:FindFirstChild("Weight")
        if weightTool then
            game.Players.LocalPlayer.Character.Humanoid:EquipTool(weightTool)
        end
    else
        local character = game.Players.LocalPlayer.Character
        local equipped = character:FindFirstChild("Weight")
        if equipped then
            equipped.Parent = game.Players.LocalPlayer.Backpack
        end
    end
    
    task.spawn(function()
        while _G.AutoWeight do
            if not _G.AutoWeight then break end
            game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep")
            task.wait(0.1)
        end
    end)
end, "Do lifting automatically")

-- Auto Pushups Toggle
autoEquipToolsFolder:AddSwitch("Auto Pushups", function(Value)
    _G.AutoPushups = Value
    
    if Value then
        local pushupsTool = game.Players.LocalPlayer.Backpack:FindFirstChild("Pushups")
        if pushupsTool then
            game.Players.LocalPlayer.Character.Humanoid:EquipTool(pushupsTool)
        end
    else
        local character = game.Players.LocalPlayer.Character
        local equipped = character:FindFirstChild("Pushups")
        if equipped then
            equipped.Parent = game.Players.LocalPlayer.Backpack
        end
    end
    
    task.spawn(function()
        while _G.AutoPushups do
            if not _G.AutoPushups then break end
            game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep")
            task.wait(0.1)
        end
    end)
end, "Do push-ups automatically")

-- Auto Handstands Toggle
autoEquipToolsFolder:AddSwitch("Auto Handstands", function(Value)
    _G.AutoHandstands = Value
    
    if Value then
        local handstandsTool = game.Players.LocalPlayer.Backpack:FindFirstChild("Handstands")
        if handstandsTool then
            game.Players.LocalPlayer.Character.Humanoid:EquipTool(handstandsTool)
        end
    else
        local character = game.Players.LocalPlayer.Character
        local equipped = character:FindFirstChild("Handstands")
        if equipped then
            equipped.Parent = game.Players.LocalPlayer.Backpack
        end
    end
    
    task.spawn(function()
        while _G.AutoHandstands do
            if not _G.AutoHandstands then break end
            game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep")
            task.wait(0.1)
        end
    end)
end, "Do hand-stands automatically")

-- Auto Situps Toggle
autoEquipToolsFolder:AddSwitch("Auto Situps", function(Value)
    _G.AutoSitups = Value
    
    if Value then
        local situpsTool = game.Players.LocalPlayer.Backpack:FindFirstChild("Situps")
        if situpsTool then
            game.Players.LocalPlayer.Character.Humanoid:EquipTool(situpsTool)
        end
    else
        local character = game.Players.LocalPlayer.Character
        local equipped = character:FindFirstChild("Situps")
        if equipped then
            equipped.Parent = game.Players.LocalPlayer.Backpack
        end
    end
    
    task.spawn(function()
        while _G.AutoSitups do
            if not _G.AutoSitups then break end
            game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep")
            task.wait(0.1)
        end
    end)
end, "Do sit-ups automatically")

-- Auto Punch Toggle
autoEquipToolsFolder:AddSwitch("Auto Punch", function(Value)
    _G.fastHitActive = Value
    
    if Value then
        -- Function to equip and modify punch
        task.spawn(function()
            while _G.fastHitActive do
                if not _G.fastHitActive then break end
                
                local player = game.Players.LocalPlayer
                local punch = player.Backpack:FindFirstChild("Punch")
                if punch then
                    punch.Parent = player.Character
                    if punch:FindFirstChild("attackTime") then
                        punch.attackTime.Value = 0
                    end
                end
                task.wait(0.1)
            end
        end)
        
        -- Function for rapid punching
        task.spawn(function()
            while _G.fastHitActive do
                if not _G.fastHitActive then break end
                
                local player = game.Players.LocalPlayer
                player.muscleEvent:FireServer("punch", "rightHand")
                player.muscleEvent:FireServer("punch", "leftHand")
                
                local character = player.Character
                if character then
                    local punchTool = character:FindFirstChild("Punch")
                    if punchTool then
                        punchTool:Activate()
                    end
                end
                task.wait(0)
            end
        end)
    else
        local character = game.Players.LocalPlayer.Character
        local equipped = character:FindFirstChild("Punch")
        if equipped then
            equipped.Parent = game.Players.LocalPlayer.Backpack
        end
    end
end, "Hits automatically")

-- Fast Tools Toggle
autoEquipToolsFolder:AddSwitch("Fast Tools", function(Value)
    _G.FastTools = Value
    
    local defaultSpeeds = {
        {
            "Punch",
            "attackTime",
            Value and 0 or 0.35
        },
        {
            "Ground Slam",
            "attackTime",
            Value and 0 or 6
        },
        {
            "Stomp",
            "attackTime",
            Value and 0 or 7
        },
        {
            "Handstands",
            "repTime",
            Value and 0 or 1
        },
        {
            "Pushups",
            "repTime",
            Value and 0 or 1
        },
        {
            "Weight",
            "repTime",
            Value and 0 or 1
        },
        {
            "Situps",
            "repTime",
            Value and 0 or 1
        }
    }
    
    local player = game.Players.LocalPlayer
    local backpack = player:WaitForChild("Backpack")
    
    for _, toolInfo in ipairs(defaultSpeeds) do
        local tool = backpack:FindFirstChild(toolInfo[1])
        if tool and tool:FindFirstChild(toolInfo[2]) then
            tool[toolInfo[2]].Value = toolInfo[3]
        end
        
        local equippedTool = player.Character and player.Character:FindFirstChild(toolInfo[1])
        if equippedTool and equippedTool:FindFirstChild(toolInfo[2]) then
            equippedTool[toolInfo[2]].Value = toolInfo[3]
        end
    end
end, "Accelerates all tools")

-- Inicializar variables de seguimiento
local sessionStartTime = os.time()
local sessionStartStrength = 0
local sessionStartDurability = 0
local sessionStartKills = 0
local sessionStartRebirths = 0
local sessionStartBrawls = 0
local hasStartedTracking = false

local jungleGymFolder = farmPlusTab:AddFolder("Jungle Gym")

-- Cache services for faster access
local VIM = game:GetService("VirtualInputManager")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Helper functions for Jungle Gym
local function pressE()
    VIM:SendKeyEvent(true, "E", false, game)
    task.wait(0.1)
    VIM:SendKeyEvent(false, "E", false, game)
end

local function autoLift()
    while getgenv().working do
        LocalPlayer.muscleEvent:FireServer("rep")
        task.wait() -- More efficient than task.wait(0) or task.wait(small number)
    end
end

local function teleportAndStart(machineName, position)
    local character = LocalPlayer.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        character.HumanoidRootPart.CFrame = position
        task.wait(0.1)
        pressE()
        task.spawn(autoLift) -- Use task.spawn to prevent UI freezing
    end
end

-- Jungle Gym Bench Press
jungleGymFolder:AddSwitch("Jungle Bench Press", function(bool)
    if getgenv().working and not bool then
        getgenv().working = false
        return
    end
    
    getgenv().working = bool
    if bool then
        teleportAndStart("Bench Press", CFrame.new(-8173, 64, 1898))
    end
end)

-- Jungle Gym Squat
jungleGymFolder:AddSwitch("Jungle Squat", function(bool)
    if getgenv().working and not bool then
        getgenv().working = false
        return
    end
    
    getgenv().working = bool
    if bool then
        teleportAndStart("Squat", CFrame.new(-8352, 34, 2878))
    end
end)

-- Jungle Gym Pull Up
jungleGymFolder:AddSwitch("Jungle Pull Ups", function(bool)
    if getgenv().working and not bool then
        getgenv().working = false
        return
    end
    
    getgenv().working = bool
    if bool then
        teleportAndStart("Pull Up", CFrame.new(-8666, 34, 2070))
    end
end)

-- Jungle Gym Boulder
jungleGymFolder:AddSwitch("Jungle Boulder", function(bool)
    if getgenv().working and not bool then
        getgenv().working = false
        return
    end
    
    getgenv().working = bool
    if bool then
        teleportAndStart("Boulder", CFrame.new(-8621, 34, 2684))
    end
end)

-- NEW: Farm Gyms Folder
local farmGymsFolder = farmPlusTab:AddFolder("Gym Workouts")

-- Workout positions data
local workoutPositions = {
    ["Bench Press"] = {
        ["Eternal Gym"] = CFrame.new(-7176.19141, 45.394104, -1106.31421),
        ["Legend Gym"] = CFrame.new(4111.91748, 1020.46674, -3799.97217),
        ["Muscle King Gym"] = CFrame.new(-8590.06152, 46.0167427, -6043.34717)
    },
    ["Squat"] = {
        ["Eternal Gym"] = CFrame.new(-7176.19141, 45.394104, -1106.31421),
        ["Legend Gym"] = CFrame.new(4304.99023, 987.829956, -4124.2334),
        ["Muscle King Gym"] = CFrame.new(-8940.12402, 13.1642084, -5699.13477)
    },
    ["Deadlift"] = {
        ["Eternal Gym"] = CFrame.new(-7176.19141, 45.394104, -1106.31421),
        ["Legend Gym"] = CFrame.new(4304.99023, 987.829956, -4124.2334),
        ["Muscle King Gym"] = CFrame.new(-8940.12402, 13.1642084, -5699.13477)
    },
    ["Pull Up"] = {
        ["Eternal Gym"] = CFrame.new(-7176.19141, 45.394104, -1106.31421),
        ["Legend Gym"] = CFrame.new(4304.99023, 987.829956, -4124.2334),
        ["Muscle King Gym"] = CFrame.new(-8940.12402, 13.1642084, -5699.13477)
    }
}

-- Workout types
local workoutTypes = {
    "Bench Press",
    "Squat",
    "Deadlift",
    "Pull Up"
}

-- Gym locations (only the three requested)
local gymLocations = {
    "Eternal Gym",
    "Legend Gym",
    "Muscle King Gym"
}

-- Spanish translations for workout types
local workoutTranslations = {
    ["Bench Press"] = "Bench Press",
    ["Squat"] = "Squat",
    ["Deadlift"] = "Dead Lift",
    ["Pull Up"] = "Pull Up"
}

-- Store references to toggle objects
local gymToggles = {}

-- Create dropdowns and toggles for each workout type
for _, workoutType in ipairs(workoutTypes) do
    -- Create dropdown for gym selection
    local dropdownName = workoutType .. "GymDropdown"
    local spanishWorkoutName = workoutTranslations[workoutType]
    
    -- Create the dropdown with the correct format
    local dropdown = farmGymsFolder:AddDropdown(spanishWorkoutName .. " - Gym", function(selected)
        _G["selected" .. string.gsub(workoutType, " ", "") .. "Gym"] = selected
    end)
    
    -- Add gym locations to the dropdown
    for _, gymName in ipairs(gymLocations) do
        dropdown:Add(gymName)
    end
    
    -- Create toggle for workout
    local toggleName = workoutType .. "GymToggle"
    local toggle = farmGymsFolder:AddSwitch(spanishWorkoutName, function(bool)
        getgenv().workingGym = bool
        getgenv().currentWorkoutType = workoutType
        
        if bool then
            local selectedGym = _G["selected" .. string.gsub(workoutType, " ", "") .. "Gym"] or gymLocations[1]
            
            -- Make sure we have a valid position
            if workoutPositions[workoutType] and workoutPositions[workoutType][selectedGym] then
                -- Stop any other workout that might be running
                for otherType, otherToggle in pairs(gymToggles) do
                    if otherType ~= workoutType and otherToggle then
                        otherToggle:Set(false)
                    end
                end
                
                -- Start the workout
                teleportAndStart(workoutType, workoutPositions[workoutType][selectedGym])
            else
                -- Notify user if position is not found
                game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = "Error",
                    Text = "Position not found for " .. workoutType .. " in " .. selectedGym,
                    Duration = 5
                })
            end
        end
    end)
    
    -- Store reference to toggle
    gymToggles[workoutType] = toggle
end

local serverTab = window:AddTab("Server")

serverTab:AddLabel("Server Options")

-- Add ad removal button to Misc 1
serverTab:AddButton("Remove Portals", function()
    -- Remove existing ad portals
    for _, portal in pairs(game:GetDescendants()) do
        if portal.Name == "RobloxForwardPortals" then
            portal:Destroy()
        end
    end
    
    -- Set up connection to remove future ad portals
    if _G.AdRemovalConnection then
        _G.AdRemovalConnection:Disconnect()
    end
    
    _G.AdRemovalConnection = game.DescendantAdded:Connect(function(descendant)
        if descendant.Name == "RobloxForwardPortals" then
            descendant:Destroy()
        end
    end)
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Ads Removed",
        Text = "Roblox ads have been removed",
        Duration = 0
    })
end)

serverTab:AddButton("Anti AFK", function()
     loadstring(game:HttpGet("https://raw.githubusercontent.com/SLH-Seth/SLHV3-ANTI-AFK/refs/heads/main/Lua"))()
end)

serverTab:AddButton("Less Lag", function()
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("ParticleEmitter") or v:IsA("Smoke") or v:IsA("Fire") or v:IsA("Sparkles") then
            v.Enabled = false
        end
    end
 
    local lighting = game:GetService("Lighting")
    lighting.GlobalShadows = false
    lighting.FogEnd = 9e9
    lighting.Brightness = 0
 
    settings().Rendering.QualityLevel = 1
 
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("Decal") or v:IsA("Texture") then
            v.Transparency = 1
        elseif v:IsA("BasePart") and not v:IsA("MeshPart") then
            v.Material = Enum.Material.SmoothPlastic
            if v.Parent and (v.Parent:FindFirstChild("Humanoid") or v.Parent.Parent:FindFirstChild("Humanoid")) then
            else
                v.Reflectance = 0
            end
        end
    end
 
    for _, v in pairs(lighting:GetChildren()) do
        if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("BloomEffect") or v:IsA("DepthOfFieldEffect") then
            v.Enabled = false
        end
    end
 
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Optimization",
        Text = "Full optimization applied!",
        Duration = 5
    })
end)

serverTab:AddButton("Rejoin Server", function()
    local ts = game:GetService("TeleportService")
    local p = game:GetService("Players").LocalPlayer
    ts:Teleport(game.PlaceId, p)
end)
 
local joinLowPlayerServerSwitch = serverTab:AddSwitch("Join Low Player Server", function(bool)
    if bool then
        local module = loadstring(game:HttpGet("https://raw.githubusercontent.com/LeoKholYt/roblox/main/lk_serverhop.lua"))()
        module:Teleport(game.PlaceId, "Lowest")
    end
end)

local rebirthTab = window:AddTab("Rebirth")

-- Target rebirth input - direct text input
rebirthTab:AddTextBox("Rebirth Target", function(text)
    local newValue = tonumber(text)
    if newValue and newValue > 0 then
        targetRebirthValue = newValue
        updateStats() -- Call the stats update function
        
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Updated Objective",
            Text = "New goal: " .. tostring(targetRebirthValue) .. " rebirth",
            Duration = 0
        })
    else
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Invalid Entry",
            Text = "Please enter a valid number",
            Duration = 0
        })
    end
end)

-- Create toggle switches
local infiniteSwitch -- Forward declaration

local targetSwitch = rebirthTab:AddSwitch("Auto Rebirth Target", function(bool)
    _G.targetRebirthActive = bool
    
    if bool then
        -- Turn off infinite rebirth if it's on
        if _G.infiniteRebirthActive and infiniteSwitch then
            infiniteSwitch:Set(false)
            _G.infiniteRebirthActive = false
        end
        
        -- Start target rebirth loop
        spawn(function()
            while _G.targetRebirthActive and wait(0.1) do
                local currentRebirths = game.Players.LocalPlayer.leaderstats.Rebirths.Value
                
                if currentRebirths >= targetRebirthValue then
                    targetSwitch:Set(false)
                    _G.targetRebirthActive = false
                    
                    game:GetService("StarterGui"):SetCore("SendNotification", {
                        Title = "Goal Achieved!!",
                        Text = "You have reached " .. tostring(targetRebirthValue) .. " rebirth",
                        Duration = 5
                    })
                    
                    break
                end
                
                game:GetService("ReplicatedStorage").rEvents.rebirthRemote:InvokeServer("rebirthRequest")
            end
        end)
    end
end, "Automatic rebirth until the goal is reached")

-- Fast Weight toggle with auto-weight functionality and persistent equipping
rebirthTab:AddSwitch("Auto Weight", function(bool)
    _G.FastWeight = bool
    
    if bool then
        -- Continuously equip and modify weight tool
        spawn(function()
            while _G.FastWeight do
                local player = game.Players.LocalPlayer
                local character = player.Character
                
                -- Check if tool is not equipped
                if character and not character:FindFirstChild("Weight") then
                    local weightTool = player.Backpack:FindFirstChild("Weight")
                    if weightTool then
                        if weightTool:FindFirstChild("repTime") then
                            weightTool.repTime.Value = 0
                        end
                        character.Humanoid:EquipTool(weightTool)
                    end
                elseif character and character:FindFirstChild("Weight") then
                    -- Make sure equipped tool is modified
                    local equipped = character:FindFirstChild("Weight")
                    if equipped:FindFirstChild("repTime") then
                        equipped.repTime.Value = 0
                    end
                end
                
                wait(0.1)
            end
        end)
        
        -- Auto do weight lifting
        spawn(function()
            while _G.FastWeight do
                game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep")
                task.wait(0)
            end
        end)
    else
        -- Unequip and reset tool
        local character = game.Players.LocalPlayer.Character
        local equipped = character:FindFirstChild("Weight")
        if equipped then
            if equipped:FindFirstChild("repTime") then
                equipped.repTime.Value = 1
            end
            equipped.Parent = game.Players.LocalPlayer.Backpack
        end
        
        -- Also reset the backpack tool
        local backpackTool = game.Players.LocalPlayer.Backpack:FindFirstChild("Weight")
        if backpackTool and backpackTool:FindFirstChild("repTime") then
            backpackTool.repTime.Value = 1
        end
    end
end)

local sizeSwitch = rebirthTab:AddSwitch("Auto Size 1", function(bool)
    _G.autoSizeActive = bool
    
    if bool then
        spawn(function()
            while _G.autoSizeActive and wait() do
                game:GetService("ReplicatedStorage").rEvents.changeSpeedSizeRemote:InvokeServer("changeSize", 0)
            end
        end)
    end
end, "Auto Set Size 1")


local teleportSwitch = rebirthTab:AddSwitch("Auto Teleport to Muscle King", function(bool)
    _G.teleportActive = bool
    
    if bool then
        spawn(function()
            while _G.teleportActive and wait() do
                if game.Players.LocalPlayer.Character then
                    game.Players.LocalPlayer.Character:MoveTo(Vector3.new(-8646, 17, -5738))
                end
            end
        end)
    end
end, "Continuous teleportation to Muscle King")

rebirthTab:AddLabel(">RMPG Op Stuffs<")

local function unequipAllPets()
    local petsFolder = player.petsFolder
    for _, folder in pairs(petsFolder:GetChildren()) do
        if folder:IsA("Folder") then
            for _, pet in pairs(folder:GetChildren()) do
                ReplicatedStorage.rEvents.equipPetEvent:FireServer("unequipPet", pet)
            end
        end
    end
    task.wait(0.1)
end

local function equipUniquePet(petName)
    unequipAllPets()
    task.wait(0.01)
    for _, pet in pairs(player.petsFolder.Unique:GetChildren()) do
        if pet.Name == petName then
            ReplicatedStorage.rEvents.equipPetEvent:FireServer("equipPet", pet)
        end
    end
end

local function findMachine(machineName)
    local machine = workspace.machinesFolder:FindFirstChild(machineName)
    if not machine then
        for _, folder in pairs(workspace:GetChildren()) do
            if folder:IsA("Folder") and folder.Name:find("machines") then
                machine = folder:FindFirstChild(machineName)
                if machine then break end
            end
        end
    end
    return machine
end

local function pressE()
    local vim = game:GetService("VirtualInputManager")
    vim:SendKeyEvent(true, "E", false, game)
    task.wait(0.1)
    vim:SendKeyEvent(false, "E", false, game)
end

local function useOneEgg()
    ReplicatedStorage.rEvents.proteinEggEvent:FireServer("useEgg")
end

local packFarm = rebirthTab:AddSwitch("Fast Rebirth", function(bool)
    isRunning = bool
    
    task.spawn(function()
        while isRunning do
            local currentRebirths = player.leaderstats.Rebirths.Value
            local rebirthCost = 10000 + (5000 * currentRebirths)
            
            if player.ultimatesFolder:FindFirstChild("Golden Rebirth") then
                local goldenRebirths = player.ultimatesFolder["Golden Rebirth"].Value
                rebirthCost = math.floor(rebirthCost * (1 - (goldenRebirths * 0.1)))
            end
            unequipAllPets()
            task.wait(0.1)
            equipUniquePet("Swift Samurai")
            
            while isRunning and player.leaderstats.Strength.Value < rebirthCost do
                for i = 1, 10 do
                    player.muscleEvent:FireServer("rep")
                end
                task.wait()
            end
            unequipAllPets()
            task.wait(0.1)
            equipUniquePet("Tribal Overlord")
            local machine = findMachine("Jungle Bar Lift")
            if machine and machine:FindFirstChild("interactSeat") then
                player.Character.HumanoidRootPart.CFrame = machine.interactSeat.CFrame * CFrame.new(0, 3, 0)
                repeat
                    task.wait(0.1)
                    pressE()
                until player.Character.Humanoid.Sit
            end
            local initialRebirths = player.leaderstats.Rebirths.Value
            repeat
                ReplicatedStorage.rEvents.rebirthRemote:InvokeServer("rebirthRequest")
                task.wait(0.1)
            until player.leaderstats.Rebirths.Value > initialRebirths
            if not isRunning then break end
            task.wait()
        end
    end)
end)

local speedGrind = rebirthTab:AddSwitch("Fast Strength", function(bool)
    local isGrinding = bool
    
    if not bool then
        unequipAllPets()
        return
    end
    
    equipUniquePet("Swift Samurai")
    
    for i = 1, 10 do
        task.spawn(function()
            while isGrinding do
                player.muscleEvent:FireServer("rep")
                task.wait()
            end
        end)
    end
end)

local frameToggle = rebirthTab:AddSwitch("Hide Frames", function(bool)
    local rSto = game:GetService("ReplicatedStorage")
    for _, obj in pairs(rSto:GetChildren()) do
        if obj.Name:match("Frame$") then
            obj.Visible = not bool
        end
    end
end)

rebirthTab:AddSwitch("Hide Pets", function(State)
    if State then
        game:GetService("ReplicatedStorage").rEvents.showPetsEvent:FireServer("hidePets")
    else
        game:GetService("ReplicatedStorage").rEvents.showPetsEvent:FireServer("showPets")
    end
end)

local autoRockTab = window:AddTab("Auto Rock")

autoRockTab:AddLabel(">RMPG PAID ROCKV1<")

-- Define the gettool function first
function gettool()
    for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        if v.Name == "Punch" and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
            game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
        end
    end
    game:GetService("Players").LocalPlayer.muscleEvent:FireServer("punch", "leftHand")
    game:GetService("Players").LocalPlayer.muscleEvent:FireServer("punch", "rightHand")
end

-- Add all rock farming toggles to the Auto Rock folder
autoRockTab:AddSwitch("Auto Punch Tiny Rock (0)", function(Value)
    selectrock = "Tiny Island Rock"
    getgenv().autoFarm = Value
    
    task.spawn(function()
        while getgenv().autoFarm do
            task.wait()
            if not getgenv().autoFarm then break end
            
            if game:GetService("Players").LocalPlayer.Durability.Value >= 0 then
                for i, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
                    if v.Name == "neededDurability" and v.Value == 0 and game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 0)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 1)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 0)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 1)
                        gettool()
                    end
                end
            end
        end
    end)
end)

autoRockTab:AddSwitch("Auto Punch Starter Rock (100)", function(Value)
    selectrock = "Starter Island Rock"
    getgenv().autoFarm = Value
    
    task.spawn(function()
        while getgenv().autoFarm do
            task.wait()
            if not getgenv().autoFarm then break end
            
            if game:GetService("Players").LocalPlayer.Durability.Value >= 100 then
                for i, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
                    if v.Name == "neededDurability" and v.Value == 100 and game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 0)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 1)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 0)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 1)
                        gettool()
                    end
                end
            end
        end
    end)
end)

autoRockTab:AddSwitch("Auto Punch Legend Beach Rock (5K)", function(Value)
    selectrock = "Legend Beach Rock"
    getgenv().autoFarm = Value
    
    task.spawn(function()
        while getgenv().autoFarm do
            task.wait()
            if not getgenv().autoFarm then break end
            
            if game:GetService("Players").LocalPlayer.Durability.Value >= 5000 then
                for i, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
                    if v.Name == "neededDurability" and v.Value == 5000 and game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 0)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 1)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 0)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 1)
                        gettool()
                    end
                end
            end
        end
    end)
end)

autoRockTab:AddSwitch("Auto Punch Frozen Rock (150K)", function(Value)
    selectrock = "Frost Gym Rock"
    getgenv().autoFarm = Value
    
    task.spawn(function()
        while getgenv().autoFarm do
            task.wait()
            if not getgenv().autoFarm then break end
            
            if game:GetService("Players").LocalPlayer.Durability.Value >= 150000 then
                for i, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
                    if v.Name == "neededDurability" and v.Value == 150000 and game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 0)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 1)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 0)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 1)
                        gettool()
                    end
                end
            end
        end
    end)
end)

autoRockTab:AddSwitch("Auto Punch Mythical Rock (400K)", function(Value)
    selectrock = "Mythical Gym Rock"
    getgenv().autoFarm = Value
    
    task.spawn(function()
        while getgenv().autoFarm do
            task.wait()
            if not getgenv().autoFarm then break end
            
            if game:GetService("Players").LocalPlayer.Durability.Value >= 400000 then
                for i, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
                    if v.Name == "neededDurability" and v.Value == 400000 and game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 0)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 1)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 0)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 1)
                        gettool()
                    end
                end
            end
        end
    end)
end)

autoRockTab:AddSwitch("Auto Punch Inferno Rock (750K)", function(Value)
    selectrock = "Inferno Gym Rock"
    getgenv().autoFarm = Value
    
    task.spawn(function()
        while getgenv().autoFarm do
            task.wait()
            if not getgenv().autoFarm then break end
            
            if game:GetService("Players").LocalPlayer.Durability.Value >= 750000 then
                for i, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
                    if v.Name == "neededDurability" and v.Value == 750000 and game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 0)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 1)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 0)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 1)
                        gettool()
                    end
                end
            end
        end
    end)
end)

autoRockTab:AddSwitch("Auto Punch Legend Rock (1M)", function(Value)
    selectrock = "Legend Gym Rock"
    getgenv().autoFarm = Value
    
    task.spawn(function()
        while getgenv().autoFarm do
            task.wait()
            if not getgenv().autoFarm then break end
            
            if game:GetService("Players").LocalPlayer.Durability.Value >= 1000000 then
                for i, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
                    if v.Name == "neededDurability" and v.Value == 1000000 and game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 0)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 1)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 0)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 1)
                        gettool()
                    end
                end
            end
        end
    end)
end)

autoRockTab:AddSwitch("Auto Punch Muscle King Rock (5M)", function(Value)
    selectrock = "Muscle King Gym Rock"
    getgenv().autoFarm = Value
    
    task.spawn(function()
        while getgenv().autoFarm do
            task.wait()
            if not getgenv().autoFarm then break end
            
            if game:GetService("Players").LocalPlayer.Durability.Value >= 5000000 then
                for i, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
                    if v.Name == "neededDurability" and v.Value == 5000000 and game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 0)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 1)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 0)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 1)
                        gettool()
                    end
                end
            end
        end
    end)
end)

autoRockTab:AddSwitch("Auto Punch Jungle Rock (10M)", function(Value)
    selectrock = "Ancient Jungle Rock"
    getgenv().autoFarm = Value
    
    task.spawn(function()
        while getgenv().autoFarm do
            task.wait()
            if not getgenv().autoFarm then break end
            
            if game:GetService("Players").LocalPlayer.Durability.Value >= 10000000 then
                for i, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
                    if v.Name == "neededDurability" and v.Value == 10000000 and game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 0)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 1)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 0)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 1)
                        gettool()
                    end
                end
            end
        end
    end)
end)

local autoRockV2Tab = window:AddTab("AutoRockV2")

-- AutoRockV2 Tab: Each toggle teleports to the rock, locks your position, and auto fast punches (NOT too fast).

local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Lock Position Function (No GUI, immediate lock)
local function lockPosition()
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    -- Remove previous body movers if any
    for _, obj in ipairs(humanoidRootPart:GetChildren()) do
        if obj:IsA("BodyPosition") or obj:IsA("BodyGyro") then
            obj:Destroy()
        end
    end
    local lockedCFrame = humanoidRootPart.CFrame
    local bodyPosition = Instance.new("BodyPosition")
    bodyPosition.MaxForce = Vector3.new(1e9, 1e9, 1e9)
    bodyPosition.Position = lockedCFrame.Position
    bodyPosition.D = 1000
    bodyPosition.P = 1e5
    bodyPosition.Parent = humanoidRootPart
    local bodyGyro = Instance.new("BodyGyro")
    bodyGyro.MaxTorque = Vector3.new(1e9, 1e9, 1e9)
    bodyGyro.CFrame = lockedCFrame
    bodyGyro.D = 1000
    bodyGyro.P = 1e5
    bodyGyro.Parent = humanoidRootPart
    -- Return cleanup function
    return function()
        if bodyPosition then pcall(function() bodyPosition:Destroy() end) end
        if bodyGyro then pcall(function() bodyGyro:Destroy() end) end
    end
end

-- Auto Fast Punch Function (a little slower)
local function startAutoFastPunch(stopSignal)
    local running = true
    -- Equip punch tool and modify attack time
    local punchTask = task.spawn(function()
        while running and not stopSignal() do
            local character = player.Character
            if character and not character:FindFirstChild("Punch") then
                local punch = player.Backpack:FindFirstChild("Punch")
                if punch then
                    if punch:FindFirstChild("attackTime") then
                        punch.attackTime.Value = 0
                    end
                    character.Humanoid:EquipTool(punch)
                end
            elseif character and character:FindFirstChild("Punch") then
                local equipped = character:FindFirstChild("Punch")
                if equipped:FindFirstChild("attackTime") then
                    equipped.attackTime.Value = 0
                end
            end
            task.wait(0.1)
        end
    end)
    local fastPunchTask = task.spawn(function()
        while running and not stopSignal() do
            local character = player.Character
            if character then
                local punchTool = character:FindFirstChild("Punch")
                if punchTool then
                    punchTool:Activate()
                end
            end
            player.muscleEvent:FireServer("punch", "rightHand")
            player.muscleEvent:FireServer("punch", "leftHand")
            task.wait(0.15) -- SLOWER: 0.15 seconds per punch
        end
    end)
    -- return cleanup
    return function()
        running = false
    end
end

-- Rock Data (Name, Target CFrame)
local rocks = {
    { name = "Tiny Rock",              cframe = CFrame.new(15.166, 8.524, 2095.036, -0.996226, 0, -0.086796, 0, 1, 0, 0.086796, 0, -0.996226) },
    { name = "Muscle Rock",            cframe = CFrame.new(-8964.373, 9.663, -6134.546, -0.999739, 0, -0.022827, 0, 1, 0, 0.022827, 0, -0.999739) },
    { name = "Mystic Rock",            cframe = CFrame.new(2171.710, 7.793, 1289.757, 0.945463, 0, -0.325730, 0, 1, 0, 0.325730, 0, 0.945463) },
    { name = "Legend Rock",            cframe = CFrame.new(4182.626, 992.000, -4054.639, 0.511141, 0, 0.859497, 0, 1, 0, -0.859497, 0, 0.511141) },
    { name = "Eternal Rock",           cframe = CFrame.new(-7283.623, 7.793, -1297.459, -0.900332, 0, -0.435205, 0, 1, 0, 0.435205, 0, -0.900332) },
    { name = "Frozen Rock",            cframe = CFrame.new(-2579.328, 8.782, -272.074, -0.951082, 0, -0.308940, 0, 1, 0, 0.308940, 0, -0.951082) },
    { name = "Punching Rock",          cframe = CFrame.new(-154.469, 7.793, 407.537, -0.973748, 0, -0.227630, 0, 1, 0, 0.227630, 0, -0.973748) },
    { name = "Large Rock",             cframe = CFrame.new(160.409, 7.793, -137.992, 0.857985, 0, -0.513674, 0, 1, 0, 0.513674, 0, 0.857985) },
    { name = "Golden Rock",            cframe = CFrame.new(310.492, 7.791, -560.009, 0.989373, 0, -0.145400, 0, 1, 0, 0.145400, 0, 0.989373) },
    { name = "Ancient Jungle Rock",    cframe = CFrame.new(-7691.660, 7.272, 2862.824, -0.432285, 0, -0.901737, 0, 1, 0, 0.901737, 0, -0.432285) },
}

-- Only one toggle runs at a time
local currentToggleIndex = nil
local cleanupFuncs = {}

autoRockV2Tab:AddLabel("---RMPG Auto Rock V2---")

for idx, rock in ipairs(rocks) do
    autoRockV2Tab:AddSwitch("Auto Farm " .. rock.name, function(enabled)
        if enabled then
            -- Turn off all other toggles
            for i, c in pairs(cleanupFuncs) do
                if c and i ~= idx then c() cleanupFuncs[i] = nil end
            end
            currentToggleIndex = idx

            -- Teleport character
            local character = player.Character or player.CharacterAdded:Wait()
            local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
            humanoidRootPart.CFrame = rock.cframe
            task.wait(0.1)

            -- Lock position
            local cleanupLock = lockPosition()

            -- Start slower punch
            local stopSignal = function() return currentToggleIndex ~= idx end
            local cleanupPunch = startAutoFastPunch(stopSignal)

            -- Store cleanup for this toggle
            cleanupFuncs[idx] = function()
                cleanupLock()
                cleanupPunch()
            end
        else
            if cleanupFuncs[idx] then
                cleanupFuncs[idx]()
                cleanupFuncs[idx] = nil
            end
            if currentToggleIndex == idx then
                currentToggleIndex = nil
            end
        end
    end)
end

local Crystal = window:AddTab("Pet Shop")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local selectedCrystal = "Galaxy Oracle Crystal"
local autoCrystalRunning = false

local dropdown = Crystal:AddDropdown("Select Crystal", function(text)
    selectedCrystal = text
end)

local crystalNames = {
    "Blue Crystal", "Green Crystal", "Frozen Crystal", "Mythical Crystal",
    "Inferno Crystal", "Legends Crystal", "Muscle Elite Crystal",
    "Galaxy Oracle Crystal", "Sky Eclipse Crystal", "Jungle Crystal"
}

for _, name in ipairs(crystalNames) do
    dropdown:Add(name)
end

local function autoOpenCrystal()
    while autoCrystalRunning do
        game:GetService("ReplicatedStorage"):WaitForChild("rEvents"):WaitForChild("openCrystalRemote"):InvokeServer("openCrystal", selectedCrystal)
        wait(0.1)
    end
end

local switch = Crystal:AddSwitch("Auto Crystal", function(state)
    autoCrystalRunning = state

    if autoCrystalRunning then
        task.spawn(autoOpenCrystal)
    end
end)

Crystal:AddLabel("PETS")

local selectedPet = "Neon Guardian" 
local petDropdown = Crystal:AddDropdown("Select Pet", function(text)
    selectedPet = text
    print("Selected pet: " .. text)
end)

petDropdown:Add("Neon Guardian")
petDropdown:Add("Blue Birdie")
petDropdown:Add("Blue Bunny")
petDropdown:Add("Blue Firecaster")
petDropdown:Add("Blue Pheonix")
petDropdown:Add("Crimson Falcon")
petDropdown:Add("Cybernetic Showdown Dragon")
petDropdown:Add("Dark Golem")
petDropdown:Add("Dark Legends Manticore")
petDropdown:Add("Dark Vampy")
petDropdown:Add("Darkstar Hunter")
petDropdown:Add("Eternal Strike Leviathan")
petDropdown:Add("Frostwave Legends Penguin")
petDropdown:Add("Gold Warrior")
petDropdown:Add("Golden Pheonix")
petDropdown:Add("Golden Viking")
petDropdown:Add("Green Butterfly")
petDropdown:Add("Green Firecaster")
petDropdown:Add("Infernal Dragon")
petDropdown:Add("Lightning Strike Phantom")
petDropdown:Add("Magic Butterfly")
petDropdown:Add("Muscle Sensei")
petDropdown:Add("Orange Hedgehog")
petDropdown:Add("Orange Pegasus")
petDropdown:Add("Phantom Genesis Dragon")
petDropdown:Add("Purple Dragon")
petDropdown:Add("Purple Falcon")
petDropdown:Add("Red Dragon")
petDropdown:Add("Red Firecaster")
petDropdown:Add("Red Kitty")
petDropdown:Add("Silver Dog")
petDropdown:Add("Ultimate Supernova Pegasus")
petDropdown:Add("Ultra Birdie")
petDropdown:Add("White Pegasus")
petDropdown:Add("White Pheonix")
petDropdown:Add("Yellow Butterfly")
 
-- Auto open pet toggle
Crystal:AddSwitch("Auto Open Pet", function(bool)
    _G.AutoHatchPet = bool
 
    if bool then
        spawn(function()
            while _G.AutoHatchPet and selectedPet ~= "" do
                local petToOpen = ReplicatedStorage.cPetShopFolder:FindFirstChild(selectedPet)
                if petToOpen then
                    ReplicatedStorage.cPetShopRemote:InvokeServer(petToOpen)
                end
                task.wait(1)
            end
        end)
    end
end)
 
-- Aura section
Crystal:AddLabel("AURAS")
 
-- Create aura dropdown with the correct format
local selectedAura = "Blue Aura" -- Default selection
local auraDropdown = Crystal:AddDropdown("Select Aura", function(text)
    selectedAura = text
    print("Selected aura: " .. text)
end)
 
-- Add aura options
auraDropdown:Add("Astral Electro")
auraDropdown:Add("Azure Tundra")
auraDropdown:Add("Blue Aura")
auraDropdown:Add("Dark Electro")
auraDropdown:Add("Dark Lightning")
auraDropdown:Add("Dark Storm")
auraDropdown:Add("Electro")
auraDropdown:Add("Enchanted Mirage")
auraDropdown:Add("Entropic Blast")
auraDropdown:Add("Eternal Megastrike")
auraDropdown:Add("Grand Supernova")
auraDropdown:Add("Green Aura")
auraDropdown:Add("Inferno")
auraDropdown:Add("Lightning")
auraDropdown:Add("Muscle King")
auraDropdown:Add("Power Lightning")
auraDropdown:Add("Purple Aura")
auraDropdown:Add("Purple Nova")
auraDropdown:Add("Red Aura")
auraDropdown:Add("Supernova")
auraDropdown:Add("Ultra Inferno")
auraDropdown:Add("Ultra Mirage")
auraDropdown:Add("Unstable Mirage")
auraDropdown:Add("Yellow Aura")

Crystal:AddSwitch("Auto Open Aura", function(bool)
    _G.AutoHatchAura = bool
 
    if bool then
        spawn(function()
            while _G.AutoHatchAura and selectedAura ~= "" do
                local auraToOpen = ReplicatedStorage.cPetShopFolder:FindFirstChild(selectedAura)
                if auraToOpen then
                    ReplicatedStorage.cPetShopRemote:InvokeServer(auraToOpen)
                end
                task.wait(1)
            end
        end)
    end
end)

-- Create the Misc tab
local miscTab = window:AddTab("Misc")

local misc1Folder = miscTab:AddFolder("Misc 1")

-- Fast Punch toggle with auto-punch functionality and persistent equipping
misc1Folder:AddSwitch("Auto Punch", function(bool)
    _G.FastPunch = bool
    
    if bool then
        -- Function to continuously equip and modify punch
        spawn(function()
            while _G.FastPunch do
                local player = game.Players.LocalPlayer
                local character = player.Character
                
                -- Check if tool is not equipped
                if character and not character:FindFirstChild("Punch") then
                    local punch = player.Backpack:FindFirstChild("Punch")
                    if punch then
                        if punch:FindFirstChild("attackTime") then
                            punch.attackTime.Value = 0
                        end
                        character.Humanoid:EquipTool(punch)
                    end
                elseif character and character:FindFirstChild("Punch") then
                    -- Make sure equipped tool is modified
                    local equipped = character:FindFirstChild("Punch")
                    if equipped:FindFirstChild("attackTime") then
                        equipped.attackTime.Value = 0
                    end
                end
                
                wait(0.1)
            end
        end)
        
        -- Function to rapidly punch
        spawn(function()
            while _G.FastPunch do
                local player = game.Players.LocalPlayer
                player.muscleEvent:FireServer("punch", "rightHand")
                player.muscleEvent:FireServer("punch", "leftHand")
                local character = player.Character
                if character then
                    local punchTool = character:FindFirstChild("Punch")
                    if punchTool then
                        punchTool:Activate()
                    end
                end
                wait(0)
            end
        end)
    else
        -- Unequip and reset tool
        local character = game.Players.LocalPlayer.Character
        local equipped = character:FindFirstChild("Punch")
        if equipped then
            if equipped:FindFirstChild("attackTime") then
                equipped.attackTime.Value = 0.35
            end
            equipped.Parent = game.Players.LocalPlayer.Backpack
        end
        
        -- Also reset the backpack tool
        local backpackTool = game.Players.LocalPlayer.Backpack:FindFirstChild("Punch")
        if backpackTool and backpackTool:FindFirstChild("attackTime") then
            backpackTool.attackTime.Value = 0.35
        end
    end
end)

-- Fast Weight toggle with auto-weight functionality and persistent equipping
misc1Folder:AddSwitch("Auto Weight", function(bool)
    _G.FastWeight = bool
    
    if bool then
        -- Continuously equip and modify weight tool
        spawn(function()
            while _G.FastWeight do
                local player = game.Players.LocalPlayer
                local character = player.Character
                
                -- Check if tool is not equipped
                if character and not character:FindFirstChild("Weight") then
                    local weightTool = player.Backpack:FindFirstChild("Weight")
                    if weightTool then
                        if weightTool:FindFirstChild("repTime") then
                            weightTool.repTime.Value = 0
                        end
                        character.Humanoid:EquipTool(weightTool)
                    end
                elseif character and character:FindFirstChild("Weight") then
                    -- Make sure equipped tool is modified
                    local equipped = character:FindFirstChild("Weight")
                    if equipped:FindFirstChild("repTime") then
                        equipped.repTime.Value = 0
                    end
                end
                
                wait(0.1)
            end
        end)
        
        -- Auto do weight lifting
        spawn(function()
            while _G.FastWeight do
                game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep")
                task.wait(0)
            end
        end)
    else
        -- Unequip and reset tool
        local character = game.Players.LocalPlayer.Character
        local equipped = character:FindFirstChild("Weight")
        if equipped then
            if equipped:FindFirstChild("repTime") then
                equipped.repTime.Value = 1
            end
            equipped.Parent = game.Players.LocalPlayer.Backpack
        end
        
        -- Also reset the backpack tool
        local backpackTool = game.Players.LocalPlayer.Backpack:FindFirstChild("Weight")
        if backpackTool and backpackTool:FindFirstChild("repTime") then
            backpackTool.repTime.Value = 1
        end
    end
end)

-- Fast Pushups toggle with auto-pushups functionality and persistent equipping
misc1Folder:AddSwitch("Auto Pushups", function(bool)
    _G.FastPushups = bool
    
    if bool then
        -- Continuously equip and modify pushups tool
        spawn(function()
            while _G.FastPushups do
                local player = game.Players.LocalPlayer
                local character = player.Character
                
                -- Check if tool is not equipped
                if character and not character:FindFirstChild("Pushups") then
                    local pushupsTool = player.Backpack:FindFirstChild("Pushups")
                    if pushupsTool then
                        if pushupsTool:FindFirstChild("repTime") then
                            pushupsTool.repTime.Value = 0
                        end
                        character.Humanoid:EquipTool(pushupsTool)
                    end
                elseif character and character:FindFirstChild("Pushups") then
                    -- Make sure equipped tool is modified
                    local equipped = character:FindFirstChild("Pushups")
                    if equipped:FindFirstChild("repTime") then
                        equipped.repTime.Value = 0
                    end
                end
                
                wait(0.1)
            end
        end)
        
        -- Auto do pushups
        spawn(function()
            while _G.FastPushups do
                game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep")
                task.wait(0)
            end
        end)
    else
        -- Unequip and reset tool
        local character = game.Players.LocalPlayer.Character
        local equipped = character:FindFirstChild("Pushups")
        if equipped then
            if equipped:FindFirstChild("repTime") then
                equipped.repTime.Value = 1
            end
            equipped.Parent = game.Players.LocalPlayer.Backpack
        end
        
        -- Also reset the backpack tool
        local backpackTool = game.Players.LocalPlayer.Backpack:FindFirstChild("Pushups")
        if backpackTool and backpackTool:FindFirstChild("repTime") then
            backpackTool.repTime.Value = 1
        end
    end
end)

-- Fast Handstands toggle with auto-handstands functionality and persistent equipping
misc1Folder:AddSwitch("Auto Handstands", function(bool)
    _G.FastHandstands = bool
    
    if bool then
        -- Continuously equip and modify handstands tool
        spawn(function()
            while _G.FastHandstands do
                local player = game.Players.LocalPlayer
                local character = player.Character
                
                -- Check if tool is not equipped
                if character and not character:FindFirstChild("Handstands") then
                    local handstandsTool = player.Backpack:FindFirstChild("Handstands")
                    if handstandsTool then
                        if handstandsTool:FindFirstChild("repTime") then
                            handstandsTool.repTime.Value = 0
                        end
                        character.Humanoid:EquipTool(handstandsTool)
                    end
                elseif character and character:FindFirstChild("Handstands") then
                    -- Make sure equipped tool is modified
                    local equipped = character:FindFirstChild("Handstands")
                    if equipped:FindFirstChild("repTime") then
                        equipped.repTime.Value = 0
                    end
                end
                
                wait(0.1)
            end
        end)
        
        -- Auto do handstands
        spawn(function()
            while _G.FastHandstands do
                game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep")
                task.wait(0)
            end
        end)
    else
        -- Unequip and reset tool
        local character = game.Players.LocalPlayer.Character
        local equipped = character:FindFirstChild("Handstands")
        if equipped then
            if equipped:FindFirstChild("repTime") then
                equipped.repTime.Value = 1
            end
            equipped.Parent = game.Players.LocalPlayer.Backpack
        end
        
        -- Also reset the backpack tool
        local backpackTool = game.Players.LocalPlayer.Backpack:FindFirstChild("Handstands")
        if backpackTool and backpackTool:FindFirstChild("repTime") then
            backpackTool.repTime.Value = 1
        end
    end
end)

-- Create the first folder
local misc2Folder = miscTab:AddFolder("Misc 2")

-- Add Auto Spin Wheel toggle
misc2Folder:AddSwitch("Auto Spin Wheel", function(bool)
    _G.AutoSpinWheel = bool
    
    if bool then
        spawn(function()
            while _G.AutoSpinWheel and wait(1) do
                game:GetService("ReplicatedStorage").rEvents.openFortuneWheelRemote:InvokeServer("openFortuneWheel", game:GetService("ReplicatedStorage").fortuneWheelChances["Fortune Wheel"])
            end
        end)
    end
end)

-- Add Auto Claim Gifts toggle
misc2Folder:AddSwitch("Auto Claim Gifts", function(bool)
    _G.AutoClaimGifts = bool
    
    if bool then
        spawn(function()
            while _G.AutoClaimGifts and wait(1) do
                for i = 1, 8 do
                    game:GetService("ReplicatedStorage").rEvents.freeGiftClaimRemote:InvokeServer("claimGift", i)
                end
            end
        end)
    end
end)

-- Add position lock toggle
misc2Folder:AddSwitch("Lock Position", function(bool)
    if bool then
        -- Get current position and lock it
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local currentPosition = player.Character.HumanoidRootPart.CFrame
            lockPlayerPosition(currentPosition)
        end
    else
        -- Unlock position
        unlockPlayerPosition()
    end
end)

local frameToggle = misc2Folder:AddSwitch("Hide Frames", function(bool)
    local rSto = game:GetService("ReplicatedStorage")
    for _, obj in pairs(rSto:GetChildren()) do
        if obj.Name:match("Frame$") then
            obj.Visible = not bool
        end
    end
end)

-- Auto Eat Eggs Feature
misc2Folder:AddSwitch("Auto Eat Eggs", function(enabled)
    _G.AutoEgg = enabled
    if enabled then
        task.spawn(function()
            while _G.AutoEgg do
                local proteinEgg = player.Backpack:FindFirstChild("Protein Egg")
                if proteinEgg then
                    proteinEgg.Parent = player.Character
                    for i = 1, 5 do
                        VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 1)
                        task.wait()
                        VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 1)
                        task.wait(0.1)
                    end
                end
                task.wait(1)
            end
        end)
    end
end)

-- Auto Eat Tropical Shake (Pineapple) Feature
misc2Folder:AddSwitch("Auto Eat Pineapple", function(enabled)
    _G.AutoPineapple = enabled
    if enabled then
        task.spawn(function()
            while _G.AutoPineapple do
                local tropicalShake = player.Backpack:FindFirstChild("Tropical Shake")
                if tropicalShake then
                    tropicalShake.Parent = player.Character
                     for i = 1, 5 do
                        VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 1)
                        task.wait()
                        VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 1)
                        task.wait(0.1)
                    end
                end
                task.wait(1)
            end
        end)
    end
end)

misc2Folder:AddSwitch("Hide Pets", function(State)
    if State then
        game:GetService("ReplicatedStorage").rEvents.showPetsEvent:FireServer("hidePets")
    else
        game:GetService("ReplicatedStorage").rEvents.showPetsEvent:FireServer("showPets")
    end
end)


misc2Folder:AddSwitch("Unable Trade", function(State)
    if State then
        game:GetService("ReplicatedStorage").rEvents.tradingEvent:FireServer("disableTrading")
    else
        game:GetService("ReplicatedStorage").rEvents.tradingEvent:FireServer("enableTrading")
    end
end)

-- Protein Items Definitions
local proteinItems = {
    {"toughBar", "TOUGH Bar"},
    {"proteinBar", "Protein Bar"},
    {"energyBar", "Energy Bar"},
    {"proteinShake", "Protein Shake"},
    {"ultraShake", "ULTRA Shake"}, -- <-- Changed here
    {"energyShake", "Energy Shake"}
}
local proteinEgg = {"proteinEgg", "Protein Egg"}

-- Auto Eat Proteins Toggle
local autoEatProteins = false
local autoEatProteinsConn
misc2Folder:AddSwitch("Auto Eat Proteins", function(enabled)
    autoEatProteins = enabled
    if autoEatProteinsConn then autoEatProteinsConn:Disconnect() autoEatProteinsConn = nil end
    if enabled then
        autoEatProteinsConn = game:GetService("RunService").Heartbeat:Connect(function()
            local player = game.Players.LocalPlayer
            local char = player.Character
            local ev = player:FindFirstChild("muscleEvent")
            if not char or not ev then return end
            for _, pair in ipairs(proteinItems) do
                local id, displayName = pair[1], pair[2]
                for _, item in ipairs(player.Backpack:GetChildren()) do
                    if item.Name == displayName then
                        item.Parent = char
                        ev:FireServer(id, item)
                    end
                end
                for _, item in ipairs(char:GetChildren()) do
                    if item:IsA("Tool") and item.Name == displayName then
                        ev:FireServer(id, item)
                    end
                end
            end
        end)
    end
end, "Automatically eat all protein items repeatedly")

-- Auto Eat Protein Egg Toggle
local autoEatEgg = false
local autoEatEggConn
misc2Folder:AddSwitch("Auto Eat Protein Egg", function(enabled)
    autoEatEgg = enabled
    if autoEatEggConn then autoEatEggConn:Disconnect() autoEatEggConn = nil end
    if enabled then
        autoEatEggConn = game:GetService("RunService").Heartbeat:Connect(function()
            local player = game.Players.LocalPlayer
            local char = player.Character
            local ev = player:FindFirstChild("muscleEvent")
            if not char or not ev then return end
            local id, displayName = proteinEgg[1], proteinEgg[2]
            for _, item in ipairs(player.Backpack:GetChildren()) do
                if item.Name == displayName then
                    item.Parent = char
                    ev:FireServer(id, item)
                end
            end
            for _, item in ipairs(char:GetChildren()) do
                if item:IsA("Tool") and item.Name == displayName then
                    ev:FireServer(id, item)
                end
            end
        end)
    end
end, "Automatically eat Protein Egg repeatedly")

-- Create the first folder
local misc3Folder = miscTab:AddFolder("Misc 3")

local godModeToggle = false
misc3Folder:AddSwitch("God Mode (Brawl)", function(State)
    godModeToggle = State
    if State then
        task.spawn(function()
            while godModeToggle do
                game:GetService("ReplicatedStorage").rEvents.brawlEvent:FireServer("joinBrawl")
                task.wait(0)
            end
        end)
    end
end)

local autoJoinToggle = false
misc3Folder:AddSwitch("Auto Join Brawl", function(State)
    autoJoinToggle = State
    if State then
        task.spawn(function()
            while autoJoinToggle do
                game:GetService("ReplicatedStorage").rEvents.brawlEvent:FireServer("joinBrawl")
                task.wait(2)
            end
        end)
    end
end)

-- Walk on Water feature
local parts = {}
local partSize = 2048
local totalDistance = 50000
local startPosition = Vector3.new(-2, -9.5, -2)
local numberOfParts = math.ceil(totalDistance / partSize)

local function createParts()
    for x = 0, numberOfParts - 1 do
        for z = 0, numberOfParts - 1 do
            local newPartSide = Instance.new("Part")
            newPartSide.Size = Vector3.new(partSize, 1, partSize)
            newPartSide.Position = startPosition + Vector3.new(x * partSize, 0, z * partSize)
            newPartSide.Anchored = true
            newPartSide.Transparency = 1
            newPartSide.CanCollide = true
            newPartSide.Name = "Part_Side_" .. x .. "_" .. z
            newPartSide.Parent = workspace
            table.insert(parts, newPartSide)
            
            local newPartLeftRight = Instance.new("Part")
            newPartLeftRight.Size = Vector3.new(partSize, 1, partSize)
            newPartLeftRight.Position = startPosition + Vector3.new(-x * partSize, 0, z * partSize)
            newPartLeftRight.Anchored = true
            newPartLeftRight.Transparency = 1
            newPartLeftRight.CanCollide = true
            newPartLeftRight.Name = "Part_LeftRight_" .. x .. "_" .. z
            newPartLeftRight.Parent = workspace
            table.insert(parts, newPartLeftRight)
            
            local newPartUpLeft = Instance.new("Part")
            newPartUpLeft.Size = Vector3.new(partSize, 1, partSize)
            newPartUpLeft.Position = startPosition + Vector3.new(-x * partSize, 0, -z * partSize)
            newPartUpLeft.Anchored = true
            newPartUpLeft.Transparency = 1
            newPartUpLeft.CanCollide = true
            newPartUpLeft.Name = "Part_UpLeft_" .. x .. "_" .. z
            newPartUpLeft.Parent = workspace
            table.insert(parts, newPartUpLeft)
            
            local newPartUpRight = Instance.new("Part")
            newPartUpRight.Size = Vector3.new(partSize, 1, partSize)
            newPartUpRight.Position = startPosition + Vector3.new(x * partSize, 0, -z * partSize)
            newPartUpRight.Anchored = true
            newPartUpRight.Transparency = 1
            newPartUpRight.CanCollide = true
            newPartUpRight.Name = "Part_UpRight_" .. x .. "_" .. z
            newPartUpRight.Parent = workspace
            table.insert(parts, newPartUpRight)
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

local function makePartsSolid()
    for _, part in ipairs(parts) do
        if part and part.Parent then
            part.CanCollide = true
        end
    end
end

-- Add Walk on Water toggle
misc3Folder:AddSwitch("Walk on Water", function(bool)
    if bool then
        createParts()
    else
        makePartsWalkthrough()
    end
end)

-- Add No-Clip toggle
misc3Folder:AddSwitch("No-Clip", function(bool)
    _G.NoClip = bool
    
    if bool then
        local noclipLoop
        noclipLoop = game:GetService("RunService").Stepped:Connect(function()
            if _G.NoClip then
                for _, part in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") and part.CanCollide then
                        part.CanCollide = false
                    end
                end
            else
                noclipLoop:Disconnect()
            end
        end)
        
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "No-Clip",
            Text = "Tatagos ka ba",
            Duration = 0
        })
    end
end)

-- Add Infinite Jump toggle
misc3Folder:AddSwitch("Jumpy Infinite", function(bool)
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
        
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "High na High",
            Text = "Sumakses ka eh",
            Duration = 0
        })
    end
end)

local timeDropdown = misc3Folder:AddDropdown("Change Time", function(selection)
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
        Text = "La hora del día ha sido cambiada a: " .. selection,
        Duration = 0
    })
end)

-- Add time options
timeDropdown:Add("Night")
timeDropdown:Add("Day")
timeDropdown:Add("Midnight")

local ProteinFolder = miscTab:AddFolder("Auto Proteins")

ProteinFolder:AddButton("Eat All Proteins", function()
    local player = game.Players.LocalPlayer
    local char = player.Character
    local ev = player:FindFirstChild("muscleEvent")
    if not char or not ev then return end
    for _, pair in ipairs(proteinItems) do
        local id, displayName = pair[1], pair[2]
        for _, item in ipairs(player.Backpack:GetChildren()) do
            if item.Name == displayName then
                item.Parent = char
                ev:FireServer(id, item)
            end
        end
        for _, item in ipairs(char:GetChildren()) do
            if item:IsA("Tool") and item.Name == displayName then
                ev:FireServer(id, item)
            end
        end
    end
end, "Eat all protein items in your backpack/character once")

-- Individual Eat Buttons for each Protein
for _, pair in ipairs(proteinItems) do
    local id, displayName = pair[1], pair[2]
    ProteinFolder:AddButton("Eat " .. displayName, function()
        local player = game.Players.LocalPlayer
        local char = player.Character
        local ev = player:FindFirstChild("muscleEvent")
        if not char or not ev then return end
        local item = player.Backpack:FindFirstChild(displayName) or (char and char:FindFirstChild(displayName))
        if item then
            item.Parent = char
            ev:FireServer(id, item)
        end
    end, "Eat one " .. displayName)
end

-- Single Eat Button for Protein Egg
ProteinFolder:AddButton("Eat Protein Egg", function()
    local player = game.Players.LocalPlayer
    local char = player.Character
    local ev = player:FindFirstChild("muscleEvent")
    if not char or not ev then return end
    local id, displayName = proteinEgg[1], proteinEgg[2]
    local item = player.Backpack:FindFirstChild(displayName) or (char and char:FindFirstChild(displayName))
    if item then
        item.Parent = char
        ev:FireServer(id, item)
    end
end, "Eat one Protein Egg")

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

local statsTab = window:AddTab("Stats")

statsTab:AddLabel("Status")

local StatisticFolder = statsTab:AddFolder("Statistic")

local labels = {  
    RebirthsGainedLabel = StatisticFolder:AddLabel("Rebirths Gained In 1 Minute: ..."),  
    RebirthsPerMinuteLabel = StatisticFolder:AddLabel("Rebirths Per Minute: ..."),  
    RebirthsPerHourLabel = StatisticFolder:AddLabel("Rebirths Per Hour: ..."),  
    RebirthsPerDayLabel = StatisticFolder:AddLabel("Rebirths Per Day: ..."),  
    RebirthsPerWeekLabel = StatisticFolder:AddLabel("Rebirths Per Week: ...")  
}  

local player = game:GetService("Players").LocalPlayer  
local leaderstats = player:FindFirstChild("leaderstats")  
local rebirthStat = leaderstats and leaderstats:FindFirstChild("Rebirths")  

local function abbreviateNumber(num)  
    if num >= 1e9 then  
        return string.format("%.2fB", num / 1e9)  
    elseif num >= 1e6 then  
        return string.format("%.2fM", num / 1e6)  
    elseif num >= 1e3 then  
        return string.format("%.2fK", num / 1e3)  
    else  
        return tostring(num)  
    end  
end  

local lastRebirthCount = rebirthStat and rebirthStat.Value or 0  

task.spawn(function()  
    while task.wait(60) do  
        local currentRebirthCount = rebirthStat and rebirthStat.Value or 0  
        local rebirthsGained = math.max(0, currentRebirthCount - lastRebirthCount)  
        lastRebirthCount = currentRebirthCount  

        labels.RebirthsGainedLabel.Text = "Rebirths Gained In 1 Minute: " .. abbreviateNumber(rebirthsGained)  
        labels.RebirthsPerMinuteLabel.Text = "Rebirths Per Minute: " .. abbreviateNumber(rebirthsGained)  
        labels.RebirthsPerHourLabel.Text = "Rebirths Per Hour: " .. abbreviateNumber(rebirthsGained * 60)  
        labels.RebirthsPerDayLabel.Text = "Rebirths Per Day: " .. abbreviateNumber(rebirthsGained * 1440)  
        labels.RebirthsPerWeekLabel.Text = "Rebirths Per Week: " .. abbreviateNumber(rebirthsGained * 10080)  
    end  
end)

local gainedstatsFolder = statsTab:AddFolder("Gained Stats")

local function abbreviateNumber(value)
    if value >= 1e15 then
        return string.format("%.1fQa", value / 1e15)
    elseif value >= 1e12 then
        return string.format("%.1fT", value / 1e12)
    elseif value >= 1e9 then
        return string.format("%.1fB", value / 1e9)
    elseif value >= 1e6 then
        return string.format("%.1fM", value / 1e6)
    elseif value >= 1e3 then
        return string.format("%.1fK", value / 1e3)
    else
        return tostring(value)
    end
end

local labels = {
    TimeSpentLabel = gainedstatsFolder:AddLabel("Time spent in this server: 00:00"),
    StrengthGainedLabel = gainedstatsFolder:AddLabel("Amount of strength gained in this server: 0"),
    DurabilityGainedLabel = gainedstatsFolder:AddLabel("Amount of durability gained in this server: 0"),
    AgilityGainedLabel = gainedstatsFolder:AddLabel("Amount of agility gained in this server: 0"),
    KillsGainedLabel = gainedstatsFolder:AddLabel("Amount of kills gained in this server: 0"),
    EvilKarmaGainedLabel = gainedstatsFolder:AddLabel("Amount of Evil Karma gained in this server: 0"),
    GoodKarmaGainedLabel = gainedstatsFolder:AddLabel("Amount of Good Karma gained in this server: 0")
}

local function createMyLabels()
    local player = game.Players.LocalPlayer
    if not player then return end

    local leaderstats = player:WaitForChild("leaderstats")
    if not leaderstats then return end

    local strengthStat = leaderstats:WaitForChild("Strength")
    local durabilityStat = player:WaitForChild("Durability")
    local agilityStat = player:WaitForChild("Agility")
    local killsStat = leaderstats:WaitForChild("Kills")
    local evilKarmaStat = player:WaitForChild("evilKarma")
    local goodKarmaStat = player:WaitForChild("goodKarma")

    local initialStrength = strengthStat.Value or 0
    local initialDurability = durabilityStat.Value or 0
    local initialAgility = agilityStat.Value or 0
    local initialKills = killsStat.Value or 0
    local initialEvilKarma = evilKarmaStat.Value or 0
    local initialGoodKarma = goodKarmaStat.Value or 0

    local startTime = tick()

    local function updateLabels()
        local strengthGained = strengthStat.Value - initialStrength
        local durabilityGained = durabilityStat.Value - initialDurability
        local agilityGained = agilityStat.Value - initialAgility
        local killsGained = killsStat.Value - initialKills
        local evilKarmaGained = evilKarmaStat.Value - initialEvilKarma
        local goodKarmaGained = goodKarmaStat.Value - initialGoodKarma

        labels.StrengthGainedLabel.Text = "Amount of strength gained in this server: " .. abbreviateNumber(strengthGained)
        labels.DurabilityGainedLabel.Text = "Amount of durability gained in this server: " .. abbreviateNumber(durabilityGained)
        labels.AgilityGainedLabel.Text = "Amount of agility gained in this server: " .. abbreviateNumber(agilityGained)
        labels.KillsGainedLabel.Text = "Amount of kills gained in this server: " .. abbreviateNumber(killsGained)
        labels.EvilKarmaGainedLabel.Text = "Amount of Evil Karma gained in this server: " .. abbreviateNumber(evilKarmaGained)
        labels.GoodKarmaGainedLabel.Text = "Amount of Good Karma gained in this server: " .. abbreviateNumber(goodKarmaGained)
    end

    local function updateTimeSpent()
        local timeSpent = tick() - startTime
        local minutes = math.floor(timeSpent / 60)
        local seconds = math.floor(timeSpent % 60)
        labels.TimeSpentLabel.Text = string.format("Time spent in this server: %02d:%02d", minutes, seconds)
    end

    strengthStat.Changed:Connect(updateLabels)
    durabilityStat.Changed:Connect(updateLabels)
    agilityStat.Changed:Connect(updateLabels)
    killsStat.Changed:Connect(updateLabels)
    evilKarmaStat.Changed:Connect(updateLabels)
    goodKarmaStat.Changed:Connect(updateLabels)

    game:GetService("RunService").Heartbeat:Connect(updateTimeSpent)

    updateLabels()
end

createMyLabels()

local viewstatsFolder = statsTab:AddFolder("View Stats")

local targetPlayer = nil
local initialStats = {}

local textbox = viewstatsFolder:AddTextBox("Target Name", function(text)
    local player = game.Players:FindFirstChild(text)
    if player then
        targetPlayer = player
        storeInitialStats()
    else
        targetPlayer = nil
        resetTargetStats()
    end
end)

local labels = {
    ViewStats = viewstatsFolder:AddLabel("View Stats:"),
    StrengthLabel = viewstatsFolder:AddLabel("Strength: 0"),
    DurabilityLabel = viewstatsFolder:AddLabel("Durability: 0"),
    AgilityLabel = viewstatsFolder:AddLabel("Agility: 0"),
    RebirthsLabel = viewstatsFolder:AddLabel("Rebirths: 0"),
    KillsLabel = viewstatsFolder:AddLabel("Kills: 0"),
    EvilKarmaLabel = viewstatsFolder:AddLabel("Evil Karma: 0"),
    GoodKarmaLabel = viewstatsFolder:AddLabel("Good Karma: 0"),
    StatsGainedLabel = viewstatsFolder:AddLabel("Stats Gained In Server:"),
    StrengthGainedLabel = viewstatsFolder:AddLabel("Strength: 0"),
    DurabilityGainedLabel = viewstatsFolder:AddLabel("Durability: 0"),
    AgilityGainedLabel = viewstatsFolder:AddLabel("Agility: 0"),
    RebirthsGainedLabel = viewstatsFolder:AddLabel("Rebirths: 0"),
    KillsGainedLabel = viewstatsFolder:AddLabel("Kills: 0"),
    EvilKarmaGainedLabel = viewstatsFolder:AddLabel("Evil Karma: 0"),
    GoodKarmaGainedLabel = viewstatsFolder:AddLabel("Good Karma: 0"),
}

local function storeInitialStats()
    if not targetPlayer then return end

    local leaderstats = targetPlayer:FindFirstChild("leaderstats")
    initialStats = {
        Strength = leaderstats and leaderstats:FindFirstChild("Strength") and leaderstats.Strength.Value or 0,
        Durability = targetPlayer:FindFirstChild("Durability") and targetPlayer.Durability.Value or 0,
        Agility = targetPlayer:FindFirstChild("Agility") and targetPlayer.Agility.Value or 0,
        Rebirths = leaderstats and leaderstats:FindFirstChild("Rebirths") and leaderstats.Rebirths.Value or 0,
        Kills = leaderstats and leaderstats:FindFirstChild("Kills") and leaderstats.Kills.Value or 0,
        EvilKarma = targetPlayer:FindFirstChild("evilKarma") and targetPlayer.evilKarma.Value or 0,
        GoodKarma = targetPlayer:FindFirstChild("goodKarma") and targetPlayer.goodKarma.Value or 0,
    }
end

local function updateTargetStats()
    if not targetPlayer then return end

    local leaderstats = targetPlayer:FindFirstChild("leaderstats")
    local goodKarma = targetPlayer:FindFirstChild("goodKarma")
    local evilKarma = targetPlayer:FindFirstChild("evilKarma")

    if leaderstats then
        labels.StrengthLabel.Text = "Strength: " .. abbreviateNumber(leaderstats:FindFirstChild("Strength") and leaderstats.Strength.Value or 0)
        labels.DurabilityLabel.Text = "Durability: " .. abbreviateNumber(targetPlayer:FindFirstChild("Durability") and targetPlayer.Durability.Value or 0)
        labels.AgilityLabel.Text = "Agility: " .. abbreviateNumber(targetPlayer:FindFirstChild("Agility") and targetPlayer.Agility.Value or 0)
        labels.RebirthsLabel.Text = "Rebirths: " .. abbreviateNumber(leaderstats:FindFirstChild("Rebirths") and leaderstats.Rebirths.Value or 0)
        labels.KillsLabel.Text = "Kills: " .. abbreviateNumber(leaderstats:FindFirstChild("Kills") and leaderstats.Kills.Value or 0)
    end

    labels.EvilKarmaLabel.Text = "Evil Karma: " .. abbreviateNumber(evilKarma and evilKarma.Value or 0)
    labels.GoodKarmaLabel.Text = "Good Karma: " .. abbreviateNumber(goodKarma and goodKarma.Value or 0)

    if initialStats then
        labels.StrengthGainedLabel.Text = "Strength: " .. abbreviateNumber((leaderstats and leaderstats:FindFirstChild("Strength") and leaderstats.Strength.Value or 0) - initialStats.Strength)
        labels.DurabilityGainedLabel.Text = "Durability: " .. abbreviateNumber((targetPlayer:FindFirstChild("Durability") and targetPlayer.Durability.Value or 0) - initialStats.Durability)
        labels.AgilityGainedLabel.Text = "Agility: " .. abbreviateNumber((targetPlayer:FindFirstChild("Agility") and targetPlayer.Agility.Value or 0) - initialStats.Agility)
        labels.RebirthsGainedLabel.Text = "Rebirths: " .. abbreviateNumber((leaderstats and leaderstats:FindFirstChild("Rebirths") and leaderstats.Rebirths.Value or 0) - initialStats.Rebirths)
        labels.KillsGainedLabel.Text = "Kills: " .. abbreviateNumber((leaderstats and leaderstats:FindFirstChild("Kills") and leaderstats.Kills.Value or 0) - initialStats.Kills)
        labels.EvilKarmaGainedLabel.Text = "Evil Karma: " .. abbreviateNumber((targetPlayer:FindFirstChild("evilKarma") and targetPlayer.evilKarma.Value or 0) - initialStats.EvilKarma)
        labels.GoodKarmaGainedLabel.Text = "Good Karma: " .. abbreviateNumber((targetPlayer:FindFirstChild("goodKarma") and targetPlayer.goodKarma.Value or 0) - initialStats.GoodKarma)
    end
end

local function resetTargetStats()
    labels.StrengthLabel.Text = "Strength: 0"
    labels.DurabilityLabel.Text = "Durability: 0"
    labels.AgilityLabel.Text = "Agility: 0"
    labels.RebirthsLabel.Text = "Rebirths: 0"
    labels.KillsLabel.Text = "Kills: 0"
    labels.EvilKarmaLabel.Text = "Evil Karma: 0"
    labels.GoodKarmaLabel.Text = "Good Karma: 0"
    labels.StrengthGainedLabel.Text = "Strength: 0"
    labels.DurabilityGainedLabel.Text = "Durability: 0"
    labels.AgilityGainedLabel.Text = "Agility: 0"
    labels.RebirthsGainedLabel.Text = "Rebirths: 0"
    labels.KillsGainedLabel.Text = "Kills: 0"
    labels.EvilKarmaGainedLabel.Text = "Evil Karma: 0"
    labels.GoodKarmaGainedLabel.Text = "Good Karma: 0"
end

task.spawn(function()
    while task.wait(0.1) do
        if targetPlayer then
            updateTargetStats()
        end
    end
end)

local teleportTab = window:AddTab("Teleport")

teleportTab:AddButton("Spawn", function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    humanoidRootPart.CFrame = CFrame.new(2, 8, 115)
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Teletransporte",
        Text = "Teletransportado al Inicio",
        Duration = 0
    })
end)

teleportTab:AddButton("Secret Area", function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    humanoidRootPart.CFrame = CFrame.new(1947, 2, 6191)
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Teletransporte",
        Text = "Teletransportado al Área Secreta",
        Duration = 0
    })
end)

teleportTab:AddButton("Tiny Island", function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    humanoidRootPart.CFrame = CFrame.new(-34, 7, 1903)
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Teletransporte",
        Text = "Teletransportado al Área Diminuta",
        Duration = 0
    })
end)

teleportTab:AddButton("Teleport Frozen", function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    humanoidRootPart.CFrame = CFrame.new(- 2600.00244, 3.67686558, - 403.884369, 0.0873617008, 1.0482899e-09, 0.99617666, 3.07204253e-08, 1, - 3.7464023e-09, - 0.99617666, 3.09302628e-08, 0.0873617008)
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Teletransporte",
        Text = "Teletransportado al Área Congelada",
        Duration = 0
    })
end)

teleportTab:AddButton("Mythical", function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    humanoidRootPart.CFrame = CFrame.new(2255, 7, 1071)
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Teletransporte",
        Text = "Teletransportado al Área Mítica",
        Duration = 0
    })
end)

teleportTab:AddButton("Inferno", function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    humanoidRootPart.CFrame = CFrame.new(-6768, 7, -1287)
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Teletransporte",
        Text = "Teletransportado al Infierno",
        Duration = 0
    })
end)

teleportTab:AddButton("Legend", function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    humanoidRootPart.CFrame = CFrame.new(4604, 991, -3887)
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Teletransporte",
        Text = "Teletransportado a Leyenda",
        Duration = 0
    })
end)

teleportTab:AddButton("Muscle King Gym", function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    humanoidRootPart.CFrame = CFrame.new(-8646, 17, -5738)
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Teletransporte",
        Text = "Teletransportado al Rey Musculoso",
        Duration = 0
    })
end)

teleportTab:AddButton("Jungle", function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    humanoidRootPart.CFrame = CFrame.new(-8659, 6, 2384)
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Teletransporte",
        Text = "Teletransportado a la Jungla",
        Duration = 0
    })
end)

teleportTab:AddButton("Brawl Lava", function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    humanoidRootPart.CFrame = CFrame.new(4471, 119, -8836)
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Teletransporte",
        Text = "Teletransportado al Combate de Lava",
        Duration = 0
    })
end)

teleportTab:AddButton("Brawl Desert", function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    humanoidRootPart.CFrame = CFrame.new(960, 17, -7398)
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Teletransporte",
        Text = "Teletransportado al Combate del Desierto",
        Duration = 0
    })
end)

teleportTab:AddButton("Brawl Regular", function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    humanoidRootPart.CFrame = CFrame.new(-1849, 20, -6335)
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Teletransporte",
        Text = "Teletransportado al Combate de Playa",
        Duration = 0
    })
end)

-- PAID TAB FIXED: All features are shown and organized

-- Create the Paid Tab
local paidTab = window:AddTab("Paid")

-- Folder for REP Speed controls
local repSpeedFolder = paidTab:AddFolder("REP Speed")

local totalReps = 20
local threadCount = 1
local durationSeconds = 2
local pingLimit = 350
local repsPerTick = 1

local isFarmingActive = false
local farmingThreads = {}

local function getPing()
    local stats = game:GetService("Stats")
    local perfStats = stats:FindFirstChild("PerformanceStats")
    local pingStat = perfStats and perfStats:FindFirstChild("Ping")
    return pingStat and pingStat:GetValue() or 0
end

local function updateRepsPerTick()
    local ticksPerSecond = 30
    local totalTicks = durationSeconds * ticksPerSecond
    local repsPerThread = totalReps / threadCount
    repsPerTick = repsPerThread / totalTicks
    if repsPerTick < 1 then
        repsPerTick = 1
    else
        repsPerTick = math.floor(repsPerTick)
    end
end

updateRepsPerTick()

local muscleEvent = game.Players.LocalPlayer.muscleEvent

local function repWorker(duration)
    local startTime = os.clock()
    while os.clock() - startTime < duration and isFarmingActive do
        for i = 1, repsPerTick do
            muscleEvent:FireServer("rep")
        end
        task.wait()
    end
end

local function startFarming()
    if isFarmingActive then return end
    isFarmingActive = true
    farmingThreads = {}

    for _ = 1, threadCount do
        local thread = task.spawn(function()
            while isFarmingActive do
                if getPing() < pingLimit then
                    repWorker(durationSeconds)
                else
                    warn("high ping > " .. pingLimit)
                    repeat task.wait(1) until getPing() < pingLimit or not isFarmingActive
                end
                while getPing() >= pingLimit and isFarmingActive do
                    task.wait(1)
                end
            end
        end)
        table.insert(farmingThreads, thread)
    end
end

local function stopFarming()
    isFarmingActive = false
    farmingThreads = {}
end

repSpeedFolder:AddTextBox("Rep Remotes per Tick", function(value)
    local num = tonumber(value)
    if num and num > 0 then
        totalReps = num
        updateRepsPerTick()
    end
end, { placeholder = tostring(totalReps) })

repSpeedFolder:AddTextBox("Threads Per Tick", function(value)
    local num = tonumber(value)
    if num and num > 0 then
        threadCount = math.floor(num)
        updateRepsPerTick()
    end
end, { placeholder = tostring(threadCount) })

repSpeedFolder:AddTextBox("REPS Per Tick", function(value)
    local num = tonumber(value)
    if num and num > 0 then
        durationSeconds = num
        updateRepsPerTick()
    end
end, { placeholder = tostring(durationSeconds) })

repSpeedFolder:AddSwitch("Auto Grind", function(state)
    if state then
        startFarming()
    else
        stopFarming()
    end
end)

-- Jungle Squat Button
paidTab:AddButton("Jungle Squat", function()
    local player = game.Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    hrp.CFrame = CFrame.new(-8371.43359375, 6.79806327, 2858.88525390)
    task.wait(0.2)
    game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.E, false, game)
    task.wait(0.05)
    game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.E, false, game)
end)

-- Anti Lag Button
paidTab:AddButton("Anti Lag", function()
    local player = game.Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")
    local lighting = game:GetService("Lighting")

    for _, gui in pairs(playerGui:GetChildren()) do
        if gui:IsA("ScreenGui") then
            gui:Destroy()
        end
    end

    local function darkenSky()
        for _, v in pairs(lighting:GetChildren()) do
            if v:IsA("Sky") then
                v:Destroy()
            end
        end

        local darkSky = Instance.new("Sky")
        darkSky.Name = "DarkSky"
        darkSky.SkyboxBk = "rbxassetid://0"
        darkSky.SkyboxDn = "rbxassetid://0"
        darkSky.SkyboxFt = "rbxassetid://0"
        darkSky.SkyboxLf = "rbxassetid://0"
        darkSky.SkyboxRt = "rbxassetid://0"
        darkSky.SkyboxUp = "rbxassetid://0"
        darkSky.Parent = lighting

        lighting.Brightness = 0
        lighting.ClockTime = 0
        lighting.TimeOfDay = "00:00:00"
        lighting.OutdoorAmbient = Color3.new(0, 0, 0)
        lighting.Ambient = Color3.new(0, 0, 0)
        lighting.FogColor = Color3.new(0, 0, 0)
        lighting.FogEnd = 100

        task.spawn(function()
            while true do
                wait(5)
                if not lighting:FindFirstChild("DarkSky") then
                    darkSky:Clone().Parent = lighting
                end
                lighting.Brightness = 0
                lighting.ClockTime = 0
                lighting.OutdoorAmbient = Color3.new(0, 0, 0)
                lighting.Ambient = Color3.new(0, 0, 0)
                lighting.FogColor = Color3.new(0, 0, 0)
                lighting.FogEnd = 100
            end
        end)
    end

    local function removeParticleEffects()
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("ParticleEmitter") then
                obj:Destroy()
            end
        end
    end

    local function removeLightSources()
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("PointLight") or obj:IsA("SpotLight") or obj:IsA("SurfaceLight") then
                obj:Destroy()
            end
        end
    end

    removeParticleEffects()
    removeLightSources()
    darkenSky()
end)

-- Pet Equip functions for Paid Tab
local Player = game.Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local function unequipPets()
    for _, folder in pairs(Player.petsFolder:GetChildren()) do
        if folder:IsA("Folder") then
            for _, pet in pairs(folder:GetChildren()) do
                ReplicatedStorage.rEvents.equipPetEvent:FireServer("unequipPet", pet)
            end
        end
    end
    task.wait(0.1)
end

local function equipPetsByName(name)
    unequipPets()
    task.wait(0.01)
    for _, pet in pairs(Player.petsFolder.Unique:GetChildren()) do
        if pet.Name == name then
            ReplicatedStorage.rEvents.equipPetEvent:FireServer("equipPet", pet)
        end
    end
end

paidTab:AddButton("Equip Swift Samurai", function()
    unequipPets()
    equipPetsByName("Swift Samurai")
end)

-- In your Paid tab, you get the following rambled farming features:

-- Fast Rebirth: 
-- Automates the process of rebirthing. Equips your best pets for grinding, calculates the required strength, 
-- lifts until you reach the rebirth threshold, interacts with the Jungle Bar Lift, and triggers rebirths in a loop.
paidTab:AddSwitch("Fast Rebirth", function(bool)
    fastRebirth = bool
    if fastRebirth then
        spawn(function()
            local ReplicatedStorage = game:GetService("ReplicatedStorage")
            local Players = game:GetService("Players")
            local player = Players.LocalPlayer

            local function unequipAllPets()
                local petsFolder = player.petsFolder
                for _, folder in pairs(petsFolder:GetChildren()) do
                    if folder:IsA("Folder") then
                        for _, pet in pairs(folder:GetChildren()) do
                            ReplicatedStorage.rEvents.equipPetEvent:FireServer("unequipPet", pet)
                        end
                    end
                end
                task.wait(0.1)
            end

            local function equipUniquePet(petName)
                unequipAllPets()
                task.wait(0.01)
                for _, pet in pairs(player.petsFolder.Unique:GetChildren()) do
                    if pet.Name == petName then
                        ReplicatedStorage.rEvents.equipPetEvent:FireServer("equipPet", pet)
                    end
                end
            end

            local function findMachine(machineName)
                local machine = workspace.machinesFolder:FindFirstChild(machineName)
                if not machine then
                    for _, folder in pairs(workspace:GetChildren()) do
                        if folder:IsA("Folder") and folder.Name:find("machines") then
                            machine = folder:FindFirstChild(machineName)
                            if machine then break end
                        end
                    end
                end
                return machine
            end

            local function pressE()
                local VIM = game:GetService("VirtualInputManager")
                VIM:SendKeyEvent(true, "E", false, game)
                task.wait(0.1)
                VIM:SendKeyEvent(false, "E", false, game)
            end

            while fastRebirth do
                local rebirths = player.leaderstats.Rebirths.Value
                local rebirthCost = 10000 + (5000 * rebirths)
                if player.ultimatesFolder:FindFirstChild("Golden Rebirth") then
                    local goldenRebirths = player.ultimatesFolder["Golden Rebirth"].Value
                    rebirthCost = math.floor(rebirthCost * (1 - (goldenRebirths * 0.1)))
                end

                unequipAllPets()
                task.wait(0.1)
                equipUniquePet("Swift Samurai")

                while player.leaderstats.Strength.Value < rebirthCost do
                    for i = 1, 10 do
                        player.muscleEvent:FireServer("rep")
                    end
                    task.wait()
                end

                unequipAllPets()
                task.wait(0.1)
                equipUniquePet("Tribal Overlord")

                local machine = findMachine("Jungle Bar Lift")
                if machine and machine:FindFirstChild("interactSeat") then
                    player.Character.HumanoidRootPart.CFrame = machine.interactSeat.CFrame * CFrame.new(0, 3, 0)
                    repeat
                        task.wait(0.1)
                        pressE()
                    until player.Character.Humanoid.Sit
                end

                local initialRebirths = player.leaderstats.Rebirths.Value
                repeat
                    ReplicatedStorage.rEvents.rebirthRemote:InvokeServer("rebirthRequest")
                    task.wait(0.1)
                until player.leaderstats.Rebirths.Value > initialRebirths

                task.wait()
            end
        end)
    end
end)

-- Lock Position (Enable After Fast Rebirth): 
-- Locks your character at its current spot. Useful for AFKing after a rebirth run.
paidTab:AddSwitch("Lock Position (Enable After Fast Rebirth)", function(state)
    lockPosition = state
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:FindFirstChild("Humanoid")
    local hrp = character:FindFirstChild("HumanoidRootPart")

    if state and humanoid and hrp then
        savedPosition = hrp.Position
        humanoid.WalkSpeed = 0
        task.spawn(function()
            while lockPosition do
                if (hrp.Position - savedPosition).magnitude > 0.1 then
                    hrp.CFrame = CFrame.new(savedPosition)
                end
                task.wait(0.05)
            end
        end)
    else
        if humanoid then humanoid.WalkSpeed = 16 end
    end
end)

-- Fast Strength: 
-- Spams the rep event across 30 threads for lightning-fast strength gain. 
paidTab:AddSwitch("Fast Strength", function(Value)
    getgenv().isGrinding = Value
    if not Value then return end
    for _ = 1, 30 do
        task.spawn(function()
            while getgenv().isGrinding do
                game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep")
                task.wait(0.01)
            end
        end)
    end
end)

-- Ultimate Fast Strength: 
-- Like Fast Strength, but with 3000 crazy threads. Max grind mode.
paidTab:AddSwitch("Ultimate Fast Strength", function(Value)
    getgenv().isGrinding = Value
    if not Value then return end
    for _ = 1, 3000 do
        task.spawn(function()
            while getgenv().isGrinding do
                game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep")
                task.wait(0.01)
            end
        end)
    end
end)

-- Hide Frame: 
-- Hides stat frames from your UI for a cleaner grind.
paidTab:AddSwitch("Hide Frame", function(bool)
    for _, frameName in ipairs({"strengthFrame", "durabilityFrame", "agilityFrame"}) do
        local frame = game:GetService("ReplicatedStorage"):FindFirstChild(frameName)
        if frame and frame:IsA("GuiObject") then
            frame.Visible = not bool
        end
    end
end)

-- Auto Punch: 
-- Equips and activates Punch tool, punching non-stop for as long as you want.
paidTab:AddSwitch("Auto Punch", function(toggleState)
    if toggleState then
        local player = game.Players.LocalPlayer
        local playerName = player.Name
        local punchTool =
            player.Backpack:FindFirstChild("Punch") or
            game.Workspace:FindFirstChild(playerName):FindFirstChild("Punch")

        _G.punchanim = true

        while _G.punchanim do
            if punchTool then
                if punchTool.Parent ~= game.Workspace:FindFirstChild(playerName) then
                    punchTool.Parent = game.Workspace:FindFirstChild(playerName)
                end
                punchTool:Activate()
                wait()
            else
                warn("Punch tool not found")
                _G.punchanim = false
            end
        end
    else
        _G.punchanim = false
    end
end)

-- Fast Punch: 
-- Sets your Punch tool to zero attack speed for instant punches, reverts when off.
paidTab:AddSwitch("Fast Punch", function(toggleState)
    local player = game.Players.LocalPlayer
    local punch = player.Backpack:FindFirstChild("Punch")
    local character = game.Workspace:FindFirstChild(player.Name)
    local punch1
    if character then
        punch1 = character:FindFirstChild("Punch")
    end
    if toggleState then
        if punch and punch:FindFirstChild("attackTime") then
            punch.attackTime.Value = 0
        elseif punch1 and punch1:FindFirstChild("attackTime") then
            punch1.attackTime.Value = 0
        end
    else
        if punch and punch:FindFirstChild("attackTime") then
            punch.attackTime.Value = 0.35
        elseif punch1 and punch1:FindFirstChild("attackTime") then
            punch1.attackTime.Value = 0.35
        end
    end
end)

-- Gain Strength: 
-- Auto-equips Weight tool and fires reps for strength, unequips on stop.
paidTab:AddSwitch("Gain Strength", function(toggleState)
    isAutoStrength = toggleState
    local player = game.Players.LocalPlayer
    local backpack = player:FindFirstChild("Backpack")
    while isAutoStrength do
        wait(0.01)
        if backpack then
            local Weight = backpack:FindFirstChild("Weight")
            if Weight then
                player.Character.Humanoid:EquipTool(Weight)
            end
        end
        local args = {[1] = "rep"}
        game:GetService("Players").LocalPlayer.muscleEvent:FireServer(unpack(args))
    end
    if not isAutoStrength then
        local equippedTool = player.Character:FindFirstChildOfClass("Tool")
        if equippedTool and equippedTool.Name == "Weight" then
            equippedTool.Parent = backpack
        end
    end
end)

-- Auto Pushups: 
-- Auto-equips Pushups tool and fires reps for as long as you want.
paidTab:AddSwitch("Auto Pushups", function(toggleState)
    isAutoPushups = toggleState
    local player = game.Players.LocalPlayer
    local backpack = player:FindFirstChild("Backpack")
    while isAutoPushups do
        wait(0.01)
        if backpack then
            local Pushups = backpack:FindFirstChild("Pushups")
            if Pushups then
                player.Character.Humanoid:EquipTool(Pushups)
            end
        end
        local args = {[1] = "rep"}
        game:GetService("Players").LocalPlayer.muscleEvent:FireServer(unpack(args))
    end
    if not isAutoPushups then
        local equippedTool = player.Character:FindFirstChildOfClass("Tool")
        if equippedTool and equippedTool.Name == "Pushups" then
            equippedTool.Parent = backpack
        end
    end
end)

-- Auto Situps: 
-- Auto-equips Situps tool and fires reps for as long as you want.
paidTab:AddSwitch("Auto Situps", function(toggleState)
    isAutoSitups = toggleState
    local player = game.Players.LocalPlayer
    local backpack = player:FindFirstChild("Backpack")
    while isAutoSitups do
        wait(0.01)
        if backpack then
            local Situps = backpack:FindFirstChild("Situps")
            if Situps then
                player.Character.Humanoid:EquipTool(Situps)
            end
        end
        local args = {[1] = "rep"}
        game:GetService("Players").LocalPlayer.muscleEvent:FireServer(unpack(args))
    end
    if not isAutoSitups then
        local equippedTool = player.Character:FindFirstChildOfClass("Tool")
        if equippedTool and equippedTool.Name == "Situps" then
            equippedTool.Parent = backpack
        end
    end
end)

-- Auto Handstands: 
-- Auto-equips Handstands tool and fires reps for as long as you want.
paidTab:AddSwitch("Auto Handstands", function(toggleState)
    isAutoHandstands = toggleState
    local player = game.Players.LocalPlayer
    local backpack = player:FindFirstChild("Backpack")
    while isAutoHandstands do
        wait(0.01)
        if backpack then
            local Handstands = backpack:FindFirstChild("Handstands")
            if Handstands then
                player.Character.Humanoid:EquipTool(Handstands)
            end
        end
        local args = {[1] = "rep"}
        game:GetService("Players").LocalPlayer.muscleEvent:FireServer(unpack(args))
    end
    if not isAutoHandstands then
        local equippedTool = player.Character:FindFirstChildOfClass("Tool")
        if equippedTool and equippedTool.Name == "Handstands" then
            equippedTool.Parent = backpack
        end
    end
end)

paidTab:AddButton("Anti Lag", function()
    -- Disable particles, smoke, fire, sparkles
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("ParticleEmitter") or v:IsA("Smoke") or v:IsA("Fire") or v:IsA("Sparkles") or v:IsA("Trail") then
            v.Enabled = false
        end
    end

    -- Set Lighting to low quality
    local lighting = game:GetService("Lighting")
    lighting.GlobalShadows = false
    lighting.FogEnd = 1e9
    lighting.Brightness = 0

    -- Lower rendering quality
    pcall(function()
        settings().Rendering.QualityLevel = 1
    end)

    -- Hide decals and textures
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("Decal") or v:IsA("Texture") then
            v.Transparency = 1
        elseif v:IsA("BasePart") and not v:IsA("MeshPart") then
            v.Material = Enum.Material.SmoothPlastic
            if v.Parent and (v.Parent:FindFirstChild("Humanoid") or v.Parent.Parent:FindFirstChild("Humanoid")) then
            else
                v.Reflectance = 0
            end
        end
    end

    -- Disable post-processing effects
    for _, v in pairs(lighting:GetChildren()) do
        if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("BloomEffect") or v:IsA("DepthOfFieldEffect") then
            v.Enabled = false
        end
    end

    -- Optional: Notify user
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Optimization",
        Text = "Full anti-lag applied!",
        Duration = 5
    })
end)

-- That's the full rambled suite of FarmV1 features, now inside your Paid tab!
-- You can grind rebirths, lock position, spam reps for strength, auto punch, and automate every training tool—all in one place.

-- CALCULATOR TAB FIXED: All features display properly, session tracking works, stats update, and controls/buttons work as intended.

local calculatortab = window:AddTab("Calculator")

local currentStatsFolder = calculatortab:AddFolder("Current Statistics")
currentStatsFolder:AddLabel(string.rep("тХР", 40))

local strengthLabel = currentStatsFolder:AddLabel("> Strength      [ Loading...        ] -=- [ --- ]")
local durabilityLabel = currentStatsFolder:AddLabel("> Durability    [ Loading...        ] -=- [ --- ]")
local agilityLabel = currentStatsFolder:AddLabel("> Agility       [ Loading...        ] -=- [ --- ]")
local rebirthsLabel = currentStatsFolder:AddLabel("> Rebirths      [ Loading...        ] -=- [ --- ]")
local killsLabel = currentStatsFolder:AddLabel("> Kills         [ Loading...        ] -=- [ --- ]")
local brawlsLabel = currentStatsFolder:AddLabel("> Brawls        [ Loading...        ] -=- [ --- ]")
local gemsLabel = currentStatsFolder:AddLabel("> Gems          [ Loading...        ] -=- [ --- ]")

currentStatsFolder:AddLabel(string.rep("тХР", 40))

-- Session Progress Section
local sessionFolder = calculatortab:AddFolder("Session Progress")
sessionFolder:AddLabel(string.rep("тХР", 40))

local sessionTimeLabel = sessionFolder:AddLabel("> Session Time  [ 00:00:00          ] -=- [ Active ]")

sessionFolder:AddLabel(string.rep("тФА", 40))
sessionFolder:AddLabel("Session Gains:")

local sessionStrengthLabel = sessionFolder:AddLabel("> Strength      [ +0               ] -=- [ +0 ]")
local sessionDurabilityLabel = sessionFolder:AddLabel("> Durability    [ +0               ] -=- [ +0 ]")
local sessionAgilityLabel = sessionFolder:AddLabel("> Agility       [ +0               ] -=- [ +0 ]")
local sessionRebirthsLabel = sessionFolder:AddLabel("> Rebirths      [ +0               ] -=- [ +0 ]")
local sessionKillsLabel = sessionFolder:AddLabel("> Kills         [ +0               ] -=- [ +0 ]")
local sessionBrawlsLabel = sessionFolder:AddLabel("> Brawls        [ +0               ] -=- [ +0 ]")
local sessionGemsLabel = sessionFolder:AddLabel("> Gems          [ +0               ] -=- [ +0 ]")

sessionFolder:AddLabel(string.rep("тХР", 40))

-- Control Buttons
local controlsFolder = calculatortab:AddFolder("Session Controls")

-- Session tracking state
local Session = {
    isActive = false,
    startTime = 0,
    baseline = {}
}
local CONFIG = {
    AUTO_UPDATE = true,
    UPDATE_INTERVAL = 1
}

function getPlayerStat(player, statName)
    local leaderstats = player:FindFirstChild("leaderstats")
    if leaderstats and leaderstats:FindFirstChild(statName) then
        return leaderstats[statName].Value
    elseif player:FindFirstChild(statName) then
        return player[statName].Value
    end
    return 0
end

function formatDetailedNumber(v)
    if type(v) ~= "number" then return tostring(v) end
    if v >= 1e15 then return string.format("%.2fQa", v / 1e15)
    elseif v >= 1e12 then return string.format("%.2fT", v / 1e12)
    elseif v >= 1e9 then return string.format("%.2fB", v / 1e9)
    elseif v >= 1e6 then return string.format("%.2fM", v / 1e6)
    elseif v >= 1e3 then return string.format("%.2fK", v / 1e3)
    else return tostring(v)
    end
end

function formatSessionTime(seconds)
    local h = math.floor(seconds / 3600)
    local m = math.floor((seconds % 3600) / 60)
    local s = math.floor(seconds % 60)
    return string.format("%02d:%02d:%02d", h, m, s)
end

function createStatDisplay(stat, value)
    return string.format("> %-12s [ %-18s ] -=- [ %s ]", stat, formatDetailedNumber(value), "---")
end

function createGainDisplay(stat, gain, positive)
    local prefix = positive and "+" or ""
    return string.format("> %-12s [ %s%-15s ] -=- [ %s%s ]", stat, prefix, formatDetailedNumber(gain), prefix, formatDetailedNumber(gain))
end

function initializeSession()
    local player = game.Players.LocalPlayer
    Session.isActive = true
    Session.startTime = os.time()
    Session.baseline = {
        Strength = getPlayerStat(player, "Strength"),
        Durability = getPlayerStat(player, "Durability"),
        Agility = getPlayerStat(player, "Agility"),
        Rebirths = getPlayerStat(player, "Rebirths"),
        Kills = getPlayerStat(player, "Kills"),
        Brawls = getPlayerStat(player, "Brawls"),
        Gems = getPlayerStat(player, "Gems")
    }
end

function resetSessionData()
    initializeSession()
end

controlsFolder:AddButton("Reset Session Statistics", function()
    resetSessionData()
end)

controlsFolder:AddButton("Export Statistics Report", function()
    local player = game.Players.LocalPlayer
    if not player then return end
    local report = {}
    table.insert(report, string.rep("тХР", 40))
    table.insert(report, "тХС            MUSCLE LEGENDS STATS REPORT          тХС")
    table.insert(report, string.rep("тХР", 40))
    table.insert(report, "тХС CURRENT STATISTICS                              тХС")
    table.insert(report, string.rep("тФА", 40))

    local stats = {
        {"Strength", getPlayerStat(player, "Strength")},
        {"Durability", getPlayerStat(player, "Durability")},
        {"Agility", getPlayerStat(player, "Agility")},
        {"Rebirths", getPlayerStat(player, "Rebirths")},
        {"Kills", getPlayerStat(player, "Kills")},
        {"Brawls", getPlayerStat(player, "Brawls")},
        {"Gems", getPlayerStat(player, "Gems")}
    }

    for _, stat in ipairs(stats) do
        local line = string.format("тХС %-12s: %20s тХС", stat[1], formatDetailedNumber(stat[2]))
        table.insert(report, line)
    end

    if Session.isActive then
        table.insert(report, string.rep("тФА", 40))
        table.insert(report, "тХС SESSION PROGRESS                                 тХС")
        table.insert(report, string.rep("тФА", 40))
        local elapsed = os.time() - Session.startTime
        local timeLine = string.format("тХС Session Time: %27s тХС", formatSessionTime(elapsed))
        table.insert(report, timeLine)
        table.insert(report, string.rep("тФА", 40))

        for _, stat in ipairs(stats) do
            local baseline = Session.baseline[stat[1]] or 0
            local gain = stat[2] - baseline
            if gain ~= 0 then
                local prefix = gain > 0 and "+" or ""
                local line = string.format("тХС %s %-9s: %19s тХС", prefix, stat[1], formatDetailedNumber(gain))
                table.insert(report, line)
            end
        end
    end

    table.insert(report, string.rep("тХР", 40))

    setclipboard(table.concat(report, "\n"))
end)

-- Settings
local settingsFolder = calculatortab:AddFolder("Settings")

local autoUpdateToggle = settingsFolder:AddSwitch("Auto-Update Statistics", function(enabled)
    CONFIG.AUTO_UPDATE = enabled
end)
autoUpdateToggle:Set(true)

-- ============================================================================
-- UPDATE SYSTEM
-- ============================================================================

local function updateDisplay()
    local player = game.Players.LocalPlayer
    if not player then return end

    if not Session.isActive then
        initializeSession()
    end

    -- Update current stats
    local strength = getPlayerStat(player, "Strength")
    local durability = getPlayerStat(player, "Durability")
    local agility = getPlayerStat(player, "Agility")
    local rebirths = getPlayerStat(player, "Rebirths")
    local kills = getPlayerStat(player, "Kills")
    local brawls = getPlayerStat(player, "Brawls")
    local gems = getPlayerStat(player, "Gems")

    strengthLabel.Text = createStatDisplay("Strength", strength)
    durabilityLabel.Text = createStatDisplay("Durability", durability)
    agilityLabel.Text = createStatDisplay("Agility", agility)
    rebirthsLabel.Text = createStatDisplay("Rebirths", rebirths)
    killsLabel.Text = createStatDisplay("Kills", kills)
    brawlsLabel.Text = createStatDisplay("Brawls", brawls)
    gemsLabel.Text = createStatDisplay("Gems", gems)

    -- Update session tracking
    if Session.isActive then
        local elapsed = os.time() - Session.startTime
        sessionTimeLabel.Text = string.format("> Session Time  [ %-15s ] -=- [ Active ]", formatSessionTime(elapsed))

        local strengthGain = strength - (Session.baseline.Strength or 0)
        local durabilityGain = durability - (Session.baseline.Durability or 0)
        local agilityGain = agility - (Session.baseline.Agility or 0)
        local rebirthsGain = rebirths - (Session.baseline.Rebirths or 0)
        local killsGain = kills - (Session.baseline.Kills or 0)
        local brawlsGain = brawls - (Session.baseline.Brawls or 0)
        local gemsGain = gems - (Session.baseline.Gems or 0)

        sessionStrengthLabel.Text = createGainDisplay("Strength", strengthGain, strengthGain >= 0)
        sessionDurabilityLabel.Text = createGainDisplay("Durability", durabilityGain, durabilityGain >= 0)
        sessionAgilityLabel.Text = createGainDisplay("Agility", agilityGain, agilityGain >= 0)
        sessionRebirthsLabel.Text = createGainDisplay("Rebirths", rebirthsGain, rebirthsGain >= 0)
        sessionKillsLabel.Text = createGainDisplay("Kills", killsGain, killsGain >= 0)
        sessionBrawlsLabel.Text = createGainDisplay("Brawls", brawlsGain, brawlsGain >= 0)
        sessionGemsLabel.Text = createGainDisplay("Gems", gemsGain, gemsGain >= 0)
    end
end

updateDisplay()

spawn(function()
    while true do
        if CONFIG.AUTO_UPDATE then
            updateDisplay()
        end
        wait(CONFIG.UPDATE_INTERVAL)
    end
end)
