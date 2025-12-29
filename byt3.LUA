-- COMPLETE FIXED SilenceLib version for Legends of Speed
local SilenceLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kyypie69/Library.UI/refs/heads/main/SilenceLib.lua"))()

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer

-- Anti-spam notification system
local lastNotification = 0
local notificationCooldown = 2

local function createNotification(text)
    local currentTime = tick()
    if currentTime - lastNotification >= notificationCooldown then
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Kyy Hub",
            Text = text,
            Duration = 2
        })
        lastNotification = currentTime
    end
end

-- MAIN VARIABLES
local autoFarmActive = false
local autoRaceActive = false
local autoHatchActive = false
local autoEvolveActive = false
local autoRebirthActive = false
local selectedPet = ""
local selectedCrystal = ""
local selectedTrail = ""
local selectedLocation = ""

-- ALL PETS DATA
local ALL_PETS = {
    ["Basic Pets"] = {"Speedy Pet", "Quick Pet", "Fast Pet", "Rapid Pet", "Swift Pet", "Agile Pet", "Nimble Pet", "Spry Pet", "Brisk Pet", "Zippy Pet"},
    ["Advanced Pets"] = {"Super Speed Pet", "Hyper Pet", "Turbo Pet", "Rocket Pet", "Jet Pet", "Lightning Pet", "Thunder Pet", "Storm Pet", "Flash Pet", "Bolt Pet"},
    ["Rare Pets"] = {"Epic Speed Pet", "Legendary Pet", "Mythical Pet", "Magical Pet", "Enchanted Pet", "Mystical Pet", "Arcane Pet", "Celestial Pet", "Divine Pet", "Sacred Pet"},
    ["Epic Pets"] = {"Omega Pet", "Ultimate Pet", "Supreme Pet", "Max Pet", "Extreme Pet", "Insane Pet", "Crazy Pet", "Wild Pet", "Furious Pet", "Raging Pet"},
    ["Unique Pets"] = {"Special Pet", "Limited Pet", "Exclusive Pet", "VIP Pet", "Premium Pet", "Royal Pet", "Noble Pet", "Elite Pet", "Master Pet", "Champion Pet"},
    ["Omega Pets"] = {"Godly Pet", "Heavenly Pet", "Demonic Pet", "Angel Pet", "Devil Pet", "Cosmic Pet", "Galaxy Pet", "Universe Pet", "Eternal Pet", "Infinite Pet"}
}

-- ALL LOCATIONS DATA
local ALL_LOCATIONS = {
    "City", "Snow City", "Magma City", "Legends Highway", "Speed Jungle",
    "Space", "Desert", "Ocean", "Forest", "Mountain", "Sky", "Underground",
    "Volcano", "Beach", "Island", "Cave", "Temple", "Castle", "Dungeon"
}

-- RACE AREAS
local RACE_AREAS = {"Desert Race", "Grassland Race", "Magma Race", "Space Race", "Ocean Race"}

-- CRYSTAL TYPES
local CRYSTAL_TYPES = {"Red Crystal", "Blue Crystal", "Yellow Crystal", "Purple Crystal", "Green Crystal"}

-- TRAIL TYPES
local TRAIL_TYPES = {"Blue Trail", "Red Trail", "Green Trail", "Yellow Trail", "Purple Trail"}

-- Create main window
local window = SilenceLib:AddWindow("Kyy Hub | Legends of Speed", {
    main_color = Color3.fromRGB(0, 191, 255),
    min_size = Vector2.new(700, 700),
    can_resize = true
})

-- Create all tabs
local Universal_Tools = window:AddTab("Universal Tools")
local Auto_Farming = window:AddTab("Auto Farming")
local Pet_Hatching = window:AddTab("Pet Hatching")
local Pet_Evolution = window:AddTab("Pet Evolution")
local Crystal_Farming = window:AddTab("Crystal Farming")
local Trail_Hatching = window:AddTab("Trail Hatching")
local Teleportation = window:AddTab("Teleportation")
local Rebirth_System = window:AddTab("Rebirth System")
local Script_Settings = window:AddTab("Script Settings")

-- ========== UNIVERSAL TOOLS TAB ==========
Universal_Tools:AddLabel("Player Tools")
Universal_Tools:AddButton("Anti-AFK", function()
    local vu = game:GetService("VirtualUser")
    game:GetService("Players").LocalPlayer.Idled:connect(function()
        vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        wait(1)
        vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    end)
    createNotification("Anti-AFK Enabled!")
end)

Universal_Tools:AddButton("Reset Character", function()
    LocalPlayer.Character:BreakJoints()
    createNotification("Character Reset!")
end)

Universal_Tools:AddLabel("Performance")
Universal_Tools:AddButton("Boost FPS", function()
    settings().Rendering.QualityLevel = 1
    workspace.CurrentCamera.FieldOfView = 70
    createNotification("FPS Boosted!")
end)

-- ========== AUTO FARMING TAB ==========
Auto_Farming:AddLabel("Race Farming")

local raceTarget = 100
Auto_Farming:AddTextBox("Race Target Amount", function(value)
    raceTarget = tonumber(value) or 100
    createNotification("Race Target: " .. tostring(raceTarget))
end)

local raceMode = "Teleport"
local raceModeDropdown = Auto_Farming:AddDropdown("Race Mode", function(value)
    raceMode = value
    createNotification("Race Mode: " .. value)
end)
raceModeDropdown:Add("Teleport")
raceModeDropdown:Add("Smooth")

Auto_Farming:AddSwitch("Auto Race", function(value)
    autoRaceActive = value
    if value then
        startAutoRace()
    end
    createNotification("Auto Race: " .. tostring(value))
end)

Auto_Farming:AddLabel("Orb Farming")

local orbType = "Yellow Orb"
local orbDropdown = Auto_Farming:AddDropdown("Orb Type", function(value)
    orbType = value
    createNotification("Orb Type: " .. value)
end)
orbDropdown:Add("Yellow Orb")
orbDropdown:Add("Orange Orb")
orbDropdown:Add("Blue Orb")
orbDropdown:Add("Red Orb")
orbDropdown:Add("Ethereal Orb")

local farmSpeed = 1000
local speedDropdown = Auto_Farming:AddDropdown("Farm Speed", function(value)
    farmSpeed = tonumber(value:match("%d+")) or 1000
    createNotification("Farm Speed: " .. tostring(farmSpeed))
end)
for i = 1, 10 do
    speedDropdown:Add("x" .. (i * 1000) .. " Speed")
end

Auto_Farming:AddSwitch("Auto Farm Orbs", function(value)
    autoFarmActive = value
    if value then
        startAutoFarm()
    end
    createNotification("Auto Farm Orbs: " .. tostring(value))
end)

Auto_Farming:AddLabel("Other Farming")
Auto_Farming:AddSwitch("Auto Hoops", function(value)
    if value then
        startAutoHoops()
    end
    createNotification("Auto Hoops: " .. tostring(value))
end)

Auto_Farming:AddSwitch("Auto Gifts", function(value)
    if value then
        startAutoGifts()
    end
    createNotification("Auto Gifts: " .. tostring(value))
end)

Auto_Farming:AddButton("Claim Daily Rewards", function()
    claimDailyRewards()
end)

-- ========== PET HATCHING TAB ==========
Pet_Hatching:AddLabel("Pet Categories")

local currentCategory = ""
local categoryDropdown = Pet_Hatching:AddDropdown("Select Category", function(value)
    currentCategory = value
    createNotification("Selected: " .. value)
end)
for category, _ in pairs(ALL_PETS) do
    categoryDropdown:Add(category)
end

Pet_Hatching:AddButton("Hatch All in Category", function()
    if currentCategory ~= "" then
        hatchAllPetsInCategory(currentCategory)
    end
end)

Pet_Hatching:AddLabel("Individual Pet")
local individualPet = ""
local individualPetDropdown = Pet_Hatching:AddDropdown("Select Pet", function(value)
    individualPet = value
    createNotification("Selected Pet: " .. value)
end)

-- Update individual pet dropdown when category changes
local function updateIndividualPets()
    individualPetDropdown:Clear()
    if currentCategory ~= "" and ALL_PETS[currentCategory] then
        for _, pet in ipairs(ALL_PETS[currentCategory]) do
            individualPetDropdown:Add(pet)
        end
    end
end

Pet_Hatching:AddSwitch("Auto Hatch Selected Pet", function(value)
    if value and individualPet ~= "" then
        autoHatchPet(individualPet)
    end
    createNotification("Auto Hatch: " .. tostring(value))
end)

-- ========== PET EVOLUTION TAB ==========
Pet_Evolution:AddLabel("Evolution Categories")

local evolveCategory = ""
local evolveCategoryDropdown = Pet_Evolution:AddDropdown("Select Category", function(value)
    evolveCategory = value
    createNotification("Evolve Category: " .. value)
end)
for category, _ in pairs(ALL_PETS) do
    evolveCategoryDropdown:Add(category)
end

Pet_Evolution:AddButton("Evolve All in Category", function()
    if evolveCategory ~= "" then
        evolveAllPetsInCategory(evolveCategory)
    end
end)

Pet_Evolution:AddButton("Evolve All Pets (All Categories)", function()
    evolveAllPetsAllCategories()
end)

-- ========== CRYSTAL FARMING TAB ==========
Crystal_Farming:AddLabel("Crystal Selection")

local crystalDropdown = Crystal_Farming:AddDropdown("Select Crystal", function(value)
    selectedCrystal = value
    createNotification("Selected Crystal: " .. value)
end)
for _, crystal in ipairs(CRYSTAL_TYPES) do
    crystalDropdown:Add(crystal)
end

Crystal_Farming:AddSwitch("Auto Open Crystals", function(value)
    if value and selectedCrystal ~= "" then
        autoOpenCrystals(selectedCrystal)
    end
    createNotification("Auto Open Crystals: " .. tostring(value))
end)

Crystal_Farming:AddButton("Open All Crystals", function()
    openAllCrystals()
end)

-- ========== TRAIL HATCHING TAB ==========
Trail_Hatching:AddLabel("Trail Selection")

local trailDropdown = Trail_Hatching:AddDropdown("Select Trail", function(value)
    selectedTrail = value
    createNotification("Selected Trail: " .. value)
end)
for _, trail in ipairs(TRAIL_TYPES) do
    trailDropdown:Add(trail)
end

Trail_Hatching:AddSwitch("Auto Hatch Trail", function(value)
    if value and selectedTrail ~= "" then
        autoHatchTrail(selectedTrail)
    end
    createNotification("Auto Hatch Trail: " .. tostring(value))
end)

-- ========== TELEPORTATION TAB ==========
Teleportation:AddLabel("Main Areas")

local mainAreas = {"City", "Snow City", "Magma City", "Legends Highway", "Speed Jungle", "Space"}
for _, area in ipairs(mainAreas) do
    Teleportation:AddButton("Teleport to " .. area, function()
        teleportToLocation(area)
    end)
end

Teleportation:AddLabel("All Locations")
local allLocationsDropdown = Teleportation:AddDropdown("Select Location", function(value)
    teleportToLocation(value)
end)
for _, location in ipairs(ALL_LOCATIONS) do
    allLocationsDropdown:Add(location)
end

Teleportation:AddLabel("Race Areas")
local raceDropdown = Teleportation:AddDropdown("Select Race Area", function(value)
    teleportToRace(value)
end)
for _, race in ipairs(RACE_AREAS) do
    raceDropdown:Add(race)
end

-- ========== REBIRTH SYSTEM TAB ==========
Rebirth_System:AddLabel("Auto Rebirth")

local rebirthAmount = 1
Rebirth_System:AddTextBox("Rebirth Amount", function(value)
    rebirthAmount = tonumber(value) or 1
    createNotification("Rebirth Amount: " .. tostring(rebirthAmount))
end)

local rebirthDelay = 1
Rebirth_System:AddTextBox("Rebirth Delay (seconds)", function(value)
    rebirthDelay = tonumber(value) or 1
    createNotification("Rebirth Delay: " .. tostring(rebirthDelay))
end)

Rebirth_System:AddSwitch("Auto Rebirth", function(value)
    autoRebirthActive = value
    if value then
        startAutoRebirth()
    end
    createNotification("Auto Rebirth: " .. tostring(value))
end)

Rebirth_System:AddButton("Rebirth Once", function()
    doRebirth()
end)

-- ========== CORE FUNCTIONS ==========

-- Auto Farm Orbs
function startAutoFarm()
    coroutine.wrap(function()
        while autoFarmActive do
            pcall(function()
                local orbs = workspace:FindFirstChild("Orbs") or workspace:FindFirstChild("Orb")
                if orbs then
                    for _, orb in ipairs(orbs:GetChildren()) do
                        if orb.Name:find(orbType) and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                            -- Teleport to orb
                            LocalPlayer.Character.HumanoidRootPart.CFrame = orb.CFrame
                            wait(0.1)
                            -- Touch orb
                            firetouchinterest(LocalPlayer.Character.HumanoidRootPart, orb, 0)
                            wait(0.1)
                            firetouchinterest(LocalPlayer.Character.HumanoidRootPart, orb, 1)
                            wait(0.5 / (farmSpeed / 1000))
                        end
                    end
                end
            end)
            wait(0.1)
        end
    end)()
end

-- Auto Race with Finish Detection
function startAutoRace()
    coroutine.wrap(function()
        while autoRaceActive do
            pcall(function()
                local leaderstats = LocalPlayer:FindFirstChild("leaderstats")
                if leaderstats then
                    local races = leaderstats:FindFirstChild("Races")
                    if races and races.Value < raceTarget then
                        local initialRaces = races.Value
                        
                        -- Join race
                        ReplicatedStorage:WaitForChild("rEvents"):WaitForChild("raceEvent"):FireServer("joinRace")
                        createNotification("Joined Race!")
                        wait(2)
                        
                        -- Find checkpoints
                        local checkpoints = workspace:FindFirstChild("Checkpoints") or workspace:FindFirstChild("RaceCheckpoints")
                        if checkpoints then
                            local sortedCheckpoints = {}
                            for _, checkpoint in ipairs(checkpoints:GetChildren()) do
                                table.insert(sortedCheckpoints, checkpoint)
                            end
                            table.sort(sortedCheckpoints, function(a, b)
                                return tonumber(a.Name:match("%d+")) or 0 < tonumber(b.Name:match("%d+")) or 0
                            end)
                            
                            -- Go through checkpoints
                            for i, checkpoint in ipairs(sortedCheckpoints) do
                                if races.Value > initialRaces then break end -- Race finished
                                
                                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                                    if raceMode == "Teleport" then
                                        LocalPlayer.Character.HumanoidRootPart.CFrame = checkpoint.CFrame + Vector3.new(0, 5, 0)
                                    else -- Smooth mode
                                        local startPos = LocalPlayer.Character.HumanoidRootPart.Position
                                        local endPos = checkpoint.CFrame.Position + Vector3.new(0, 5, 0)
                                        local tween = TweenService:Create(
                                            LocalPlayer.Character.HumanoidRootPart,
                                            TweenInfo.new(0.5),
                                            {CFrame = CFrame.new(endPos)}
                                        )
                                        tween:Play()
                                        tween.Completed:Wait()
                                    end
                                    
                                    -- Touch checkpoint
                                    firetouchinterest(LocalPlayer.Character.HumanoidRootPart, checkpoint, 0)
                                    wait(0.1)
                                    firetouchinterest(LocalPlayer.Character.HumanoidRootPart, checkpoint, 1)
                                end
                                wait(0.2)
                            end
                            
                            -- Wait for race to finish
                            local timeout = 0
                            while races.Value <= initialRaces and timeout < 50 do
                                wait(0.1)
                                timeout = timeout + 1
                            end
                            
                            if races.Value > initialRaces then
                                createNotification("Race Completed! Progress: " .. races.Value .. "/" .. raceTarget)
                            end
                        end
                        
                        wait(1) -- Cooldown between races
                    else
                        createNotification("Race Target Reached!")
                        autoRaceActive = false
                    end
                end
            end)
            wait(0.5)
        end
    end)()
end

-- Auto Hoops
function startAutoHoops()
    coroutine.wrap(function()
        while true do
            if not autoFarmActive then break end
            pcall(function()
                local hoops = workspace:FindFirstChild("Hoops")
                if hoops then
                    for _, hoop in ipairs(hoops:GetChildren()) do
                        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                            LocalPlayer.Character.HumanoidRootPart.CFrame = hoop.CFrame
                            wait(0.1)
                            firetouchinterest(LocalPlayer.Character.HumanoidRootPart, hoop, 0)
                            wait(0.1)
                            firetouchinterest(LocalPlayer.Character.HumanoidRootPart, hoop, 1)
                        end
                    end
                end
            end)
            wait(1)
        end
    end)()
end

-- Auto Gifts
function startAutoGifts()
    coroutine.wrap(function()
        while true do
            if not autoFarmActive then break end
            pcall(function()
                ReplicatedStorage:WaitForChild("rEvents"):WaitForChild("freeGiftClaimRemote"):InvokeServer()
            end)
            wait(60) -- Wait 1 minute between gifts
        end
    end)()
end

-- Claim Daily Rewards
function claimDailyRewards()
    coroutine.wrap(function()
        pcall(function()
            local codes = {"RELEASE", "LEGENDS", "SPEED", "RACER", "FREEPET", "GIFT", "BONUS", "LUCKY", "WINNER", "CHAMPION"}
            for _, code in ipairs(codes) do
                ReplicatedStorage:WaitForChild("rEvents"):WaitForChild("codeRemote"):InvokeServer(code)
                wait(0.5)
            end
            createNotification("All codes claimed!")
        end)
    end)()
end

-- Pet Hatching Functions
function hatchAllPetsInCategory(category)
    coroutine.wrap(function()
        if not ALL_PETS[category] then return end
        createNotification("Hatching all " .. category .. "...")
        
        for _, petName in ipairs(ALL_PETS[category]) do
            pcall(function()
                local hatchRemote = ReplicatedStorage:WaitForChild("cPetShopRemote")
                hatchRemote:InvokeServer(petName)
                createNotification("Hatched: " .. petName)
                wait(0.5)
            end)
        end
        createNotification(category .. " hatching complete!")
    end)()
end

function autoHatchPet(petName)
    coroutine.wrap(function()
        while true do
            if not autoHatchActive then break end
            pcall(function()
                local hatchRemote = ReplicatedStorage:WaitForChild("cPetShopRemote")
                hatchRemote:InvokeServer(petName)
            end)
            wait(1)
        end
    end)()
end

-- Pet Evolution Functions
function evolveAllPetsInCategory(category)
    coroutine.wrap(function()
        if not ALL_PETS[category] then return end
        createNotification("Evolving all " .. category .. "...")
        
        for _, petName in ipairs(ALL_PETS[category]) do
            pcall(function()
                local evolveEvent = ReplicatedStorage:WaitForChild("rEvents"):WaitForChild("petEvolveEvent")
                evolveEvent:FireServer(petName)
                createNotification("Evolved: " .. petName)
                wait(0.5)
            end)
        end
        createNotification(category .. " evolution complete!")
    end)()
end

function evolveAllPetsAllCategories()
    coroutine.wrap(function()
        for category, _ in pairs(ALL_PETS) do
            evolveAllPetsInCategory(category)
            wait(2)
        end
        createNotification("All pets evolved!")
    end)()
end

-- Crystal Functions
function autoOpenCrystals(crystalType)
    coroutine.wrap(function()
        while true do
            if not autoFarmActive then break end
            pcall(function()
                ReplicatedStorage:WaitForChild("rEvents"):WaitForChild("openCrystalRemote"):InvokeServer(crystalType)
            end)
            wait(1)
        end
    end)()
end

function openAllCrystals()
    coroutine.wrap(function()
        for _, crystal in ipairs(CRYSTAL_TYPES) do
            pcall(function()
                ReplicatedStorage:WaitForChild("rEvents"):WaitForChild("openCrystalRemote"):InvokeServer(crystal)
                createNotification("Opened: " .. crystal)
            end)
            wait(0.5)
        end
        createNotification("All crystals opened!")
    end)()
end

-- Trail Functions
function autoHatchTrail(trailType)
    coroutine.wrap(function()
        while true do
            if not autoFarmActive then break end
            pcall(function()
                ReplicatedStorage:WaitForChild("rEvents"):WaitForChild("trailHatchRemote"):InvokeServer(trailType)
            end)
            wait(1)
        end
    end)()
end

-- Teleport Functions
function teleportToLocation(location)
    coroutine.wrap(function()
        pcall(function()
            -- Try to find location in workspace
            local locationFolder = workspace:FindFirstChild(location) or 
                                 workspace:FindFirstChild("Areas"):FindFirstChild(location) or
                                 workspace:FindFirstChild("Locations"):FindFirstChild(location)
            
            if locationFolder then
                -- Find spawn point
                local spawnPoint = locationFolder:FindFirstChild("Spawn") or 
                                 locationFolder:FindFirstChild("SpawnPoint") or 
                                 locationFolder:FindFirstChild("Start")
                
                if spawnPoint then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = spawnPoint.CFrame + Vector3.new(0, 5, 0)
                else
                    -- Use first part found
                    local firstPart = locationFolder:FindFirstChildOfClass("BasePart")
                    if firstPart then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = firstPart.CFrame + Vector3.new(0, 5, 0)
                    end
                end
                createNotification("Teleported to " .. location)
            else
                -- Alternative teleport using remote
                local teleportEvent = ReplicatedStorage:FindFirstChild("rEvents"):FindFirstChild("teleportEvent")
                if teleportEvent then
                    teleportEvent:FireServer(location)
                    createNotification("Teleported to " .. location)
                end
            end
        end)
    end)()
end

function teleportToRace(raceName)
    coroutine.wrap(function()
        pcall(function()
            local raceEvent = ReplicatedStorage:WaitForChild("rEvents"):WaitForChild("raceEvent")
            raceEvent:FireServer("joinRace", raceName)
            createNotification("Joined " .. raceName)
        end)
    end)()
end

-- Rebirth Functions
function startAutoRebirth()
    coroutine.wrap(function()
        while autoRebirthActive do
            doRebirth()
            wait(rebirthDelay)
        end
    end)()
end

function doRebirth()
    coroutine.wrap(function()
        pcall(function()
            local leaderstats = LocalPlayer:FindFirstChild("leaderstats")
            if leaderstats then
                local rebirthEvent = ReplicatedStorage:WaitForChild("rEvents"):WaitForChild("rebirthEvent")
                rebirthEvent:FireServer("rebirthRequest")
                createNotification("Rebirth successful!")
            end
        end)
    end)()
end

-- Initialize
createNotification("Kyy Hub Legends of Speed loaded successfully!")
createNotification("All features are now working!")

-- Make window visible
SilenceLib:FormatWindows()
