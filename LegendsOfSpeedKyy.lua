loadstring(game:HttpGet("https://raw.githubusercontent.com/Kyypie69/Library.UI/refs/heads/main/LOS.LIB.lua"))()

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")

local LocalPlayer = Players.LocalPlayer

local race = nil
local gifts = nil
local chest = nil
local spinWheel = nil
local raceTarget = nil
local racing = false
local smoothRacing = false
local fillRace = nil
local hoop = nil
local rebirth = nil
local rebirthTarget = nil
local enhanceConnection = nil
local instantRebirthAmount = nil
local rebirthCooldown = nil
local rebirthTargetAmount = nil
local rebirthTargetCooldown = nil
local min = nil
local max = nil
local raceInProgress = false

race.Changed:Connect(function()
end)

raceStarted.Changed:Connect(function()
end)

local function LowestPlayer()
end

local function Rejoin()
end

local function Serverhop()
end

local Yellow_Orb = "Yellow Orb"
local Orange_Orb = "Orange Orb"
local Blue_Orb = "Blue Orb"
local Red_Orb = "Red Orb"
local Ethereal_Orb = "Ethereal Orb"
local Gem = "Gem"
local Infernal_Gem = "Infernal Gem"

local City = "City"
local Snow_City = "Snow City"
local Magma_City = "Magma City"
local Legends_Highway = "Legends Highway"
local Speed_Jungle = "Speed Jungle"
local Space = "Space"
local Desert = "Desert"

local active = false
local orb = nil
local city = nil
local speed = nil
local cooldown = nil
local settings = {}

settings.primary = {
    active = false,
    orb = nil,
    city = nil,
    speed = nil,
    cooldown = nil
}

settings.secondary = {
    active = false,
    orb = nil,
    city = nil,
    speed = nil,
    cooldown = nil
}

settings.third = {
    active = false,
    orb = nil,
    city = nil,
    speed = nil,
    cooldown = nil
}

local Desynced = CreateWindow("Desynced", "Legends Of Speed")
createNotification("The script for Legends Of Speed has been successfully loaded.")

local Universal_Tools = CreateTab("Universal Tools", 96221607452840)
local Auto_Farming = CreateTab("Auto Farming", 103858677733367)
local Pet_Hatching = CreateTab("Pet Hatching", 84773625854784)
local Pet_Evolution = CreateTab("Pet Evolution", 84773625854784)
local Crystal_Farming = CreateTab("Crystal Farming", 114902365269370)
local Trail_Hatching = CreateTab("Trail Hatching", 88426869189754)
local Ultimates = CreateTab("Ultimates", 88426869189754)
local Teleportation = CreateTab("Teleportation", 140134362123695)
local Rebirth_System = CreateTab("Rebirth System", 98702116897863)
local Rebirth_Calculator = CreateTab("Rebirth Calculator", 71239076961795)
local Script_Settings = CreateTab("Script Settings", 139117814373418)
local Player_Statistics = CreateTab("Player Statistics", 133249606271733)

CreateSection("Miscellaneous")
CreateButton("Join Desynced Discord")
CreateToggle("Safe Lock")
CreateBox("Enter FPS Cap")

CreateSection("Network Optimization")
CreateToggle("Enable Ping Stabilizer")
CreateToggle("Connection Enhancer")

CreateSection("Race Farming")
CreateDropdown("Racing Mode", {"Teleport", "Smooth"})
CreateToggle("Auto Fill Race")
CreateBox("Race Target")
CreateToggle("Enable Auto Racing")

CreateSection("Hoop Farming")
CreateButton("Clear Hoops")
CreateToggle("Enable Auto Hoops")

CreateSection("Extra Farming Options")
CreateToggle("Enable Auto Gifts")
CreateToggle("Auto Claim Chests")
CreateToggle("Auto Spin Wheel")
CreateButton("Claim All Codes")

CreateSection("Trading")
CreateToggle("Enable Trading")
CreateBox("Trade Target Username")
CreateButton("Send Trade Request")

CreateSection("Primary Auto Farm")
CreateDropdown("Orb Type", {})
CreateDropdown("Target City", {})
CreateDropdown("Collection Rate", {
    "x800 Orbs",
    "x900 Orbs",
    "x1000 Orbs",
    "x1100 Orbs",
    "x1200 Orbs",
    "x1300 Orbs",
    "x1400 Orbs",
    "x1500 Orbs",
    "x1600 Orbs",
    "x1800 Orbs"
})
CreateBox("Orb Collection Cooldown")
CreateToggle("Enable Auto Orb Collection")

CreateSection("Secondary Auto Farm")
CreateDropdown("Orb Type", {})
CreateDropdown("Target City", {})
CreateDropdown("Collection Rate", {
    "x800 Orbs",
    "x900 Orbs",
    "x1000 Orbs",
    "x1100 Orbs",
    "x1200 Orbs",
    "x1300 Orbs",
    "x1400 Orbs",
    "x1500 Orbs",
    "x1600 Orbs",
    "x1800 Orbs"
})
CreateBox("Orb Collection Cooldown")
CreateToggle("Enable Auto Orb Collection")

CreateSection("Third Auto Farm")
CreateDropdown("Orb Type", {})
CreateDropdown("Target City", {})
CreateDropdown("Collection Rate", {
    "x800 Orbs",
    "x900 Orbs",
    "x1000 Orbs",
    "x1100 Orbs",
    "x1200 Orbs",
    "x1300 Orbs",
    "x1400 Orbs",
    "x1500 Orbs",
    "x1600 Orbs",
    "x1800 Orbs"
})
CreateBox("Orb Collection Cooldown")
CreateToggle("Enable Auto Orb Collection")

local selectedbasicpettohatch = nil
function hatchBasicPets()
end

local selectedadvancedpettohatch = nil
function hatchAdvancedPets()
end

local selectedrarepettohatch = nil
function hatchRarePets()
end

local selectedepicpettohatch = nil
function hatchEpicPets()
end

local selecteduniquepettohatch = nil
function hatchUniquePets()
end

local selectedomegapettohatch = nil
function hatchOmegaPets()
end

local selectedbasicpettoevolve = nil
function evolveBasicPets()
end

local selectedadvancedpettoevolve = nil
function evolveAdvancedPets()
end

local selectedrarepettoevolve = nil
function evolveRarePets()
end

local selectedepicpettoevolve = nil
function evolveEpicPets()
end

local selecteduniquepettoevolve = nil
function evolveUniquePets()
end

local selectedomegapettoevolve = nil
function evolveOmegaPets()
end

local Red_Crystal = "Red Crystal"
local Lightning_Crystal = "Lightning Crystal"
local Yellow_Crystal = "Yellow Crystal"
local Purple_Crystal = "Purple Crystal"
local Blue_Crystal = "Blue Crystal"
local Snow_Crystal = "Snow Crystal"
local Lava_Crystal = "Lava Crystal"
local Inferno_Crystal = "Inferno Crystal"
local Electro_Legends_Crystal = "Electro Legends Crystal"
local Jungle_Crystal = "Jungle Crystal"
local Space_Crystal = "Space Crystal"
local Alien_Crystal = "Alien Crystal"
local Desert_Crystal = "Desert Crystal"
local Electro_Crystal = "Electro Crystal"

local selectedCityCrystal = nil
function autoOpenCityCrystal()
end

local selectedSpaceCrystal = nil
function autoOpenSpaceCrystal()
end

local selectedDesertCrystal = nil
function autoOpenDesertCrystal()
end

local trails = {
    "1-5",
    "1st Trail",
    "2nd Trail",
    "Third Trail",
    "Fourth Trail",
    "Fifth Trail",
    "B",
    "BG Speed",
    "Blue & Green",
    "Blue Coin",
    "Blue Gem",
    "Blue Lightning",
    "Blue Snow",
    "Blue Soul",
    "Blue Sparks",
    "Blue Storm",
    "Blue Trail",
    "D",
    "Dragonfire",
    "G",
    "Golden Lightning",
    "Green & Orange",
    "Green Coin",
    "Green Gem",
    "Green Lightning",
    "Green Snow",
    "Green Soul",
    "Green Sparks",
    "Green Storm",
    "Green Trail",
    "H",
    "Hyperblast",
    "O",
    "OG Speed",
    "Orange Coin",
    "Orange Gem",
    "Orange Lightning",
    "Orange Snow",
    "Orange Soul",
    "Orange Sparks",
    "Orange Storm",
    "Orange Trail",
    "P",
    "PP Speed",
    "Pink Gem",
    "Pink Lightning",
    "Pink Snow",
    "Pink Soul",
    "Pink Sparks",
    "Pink Storm",
    "Pink Trail",
    "Purple & Pink",
    "Purple Coin",
    "Purple Gem",
    "Purple Lightning",
    "Purple Soul",
    "Purple Sparks",
    "Purple Storm",
    "Purple Trail",
    "R",
    "RB Speed",
    "Rainbow Lightning",
    "Rainbow Soul",
    "Rainbow Sparks",
    "Rainbow Speed",
    "Rainbow Steps",
    "Rainbow Storm",
    "Rainbow Trail",
    "Red & Blue",
    "Red Coin",
    "Red Gem",
    "Red Lightning",
    "Red Snow",
    "Red Soul",
    "Red Sparks",
    "Red Storm",
    "Red Trail",
    "W",
    "White Snow",
    "Y",
    "YB Speed",
    "Yellow & Blue",
    "Yellow Soul",
    "Yellow Sparks",
    "Yellow Trail"
}

CreateLabel("You will lose rebirths by using these upgrades!")

CreateSection("Rebirth Pets")
CreateButton("Magzor")
CreateButton("Crowd Surfer")
CreateButton("Sorenzo")

CreateSection("Game Upgrades")
CreateButton("x2 Trail Boosts")
CreateButton("+1 Pet Slot")
CreateButton("+10 Item Capacity")
CreateButton("+1 Daily Spin")
CreateButton("x2 Chest Rewards")
CreateButton("x2 Quest Rewards")

CreateSection("Enhancements")
CreateButton("Gem Booster")
CreateButton("Step Booster")
CreateButton("Infernal Gems")
CreateButton("Ethereal Orbs")
CreateButton("Demon Hoops")
CreateButton("Divine Rebirth")

CreateSection("Main Teleports")
local cityCFrame = CFrame.new()
local snowCityCFrame = CFrame.new()
local magmaCityCFrame = CFrame.new()
local legendsHighwayCFrame = CFrame.new()
local speedJungleCFrame = CFrame.new()

local mainLocations = {
    "City",
    "Snow City",
    "Magma City",
    "Legends Highway",
    "Speed Jungle"
}
CreateDropdown("Select Main Location", mainLocations)

CreateSection("Race & Other Areas")
local desertRaceCFrame = CFrame.new()
local grasslandRaceCFrame = CFrame.new()
local magmaRaceCFrame = CFrame.new()
local spaceWorldCFrame = CFrame.new()
local desertWorldCFrame = CFrame.new()

local raceAreas = {
    "Desert Race",
    "Grassland Race",
    "Magma Race",
    "Space World",
    "Desert World"
}
CreateDropdown("Select Race/Area", raceAreas)

CreateSection("Space Teleports")
local hoop1000CFrame = CFrame.new()
local starwayRaceCFrame = CFrame.new()

local spaceLocations = {
    "+1000 Hoop",
    "Starway Race"
}
CreateDropdown("Select Space Location", spaceLocations)

CreateSection("Desert Teleports")
local hoop8000CFrame = CFrame.new()
local speedwayRaceCFrame = CFrame.new()
local secondIslandCFrame = CFrame.new()

local desertLocations = {
    "+8000 Hoop",
    "Speedway Race",
    "Second Island"
}
CreateDropdown("Select Desert Location", desertLocations)

CreateSection("World Teleports")
local worlds = {
    "City",
    "Outer Space",
    "Speed Desert"
}
CreateDropdown("Select World", worlds)

CreateSection("Server Teleports")
local serverOptions = {
    "Lowest Player Count",
    "Server Hop",
    "Rejoin"
}
CreateDropdown("Server Options", serverOptions)

CreateSection("Rebirth Farming")
CreateBox("Rebirth Cooldown (sec)")
CreateToggle("Auto Rebirth")

CreateSection("Targeted Rebirth Farming")
CreateBox("Rebirth Target Amount")
CreateBox("Target Rebirth Cooldown (sec)")
CreateToggle("Targeted Auto Rebirth")

CreateSection("Instant Rebirth Farming")
CreateBox("Rebirths to Perform")
CreateButton("Start Rebirth")

CreateSection("Rebirth Calculator")
CreateLabel("Credits to byt3c0de_net and pb_cryo")

local petRarities = {
    "Basic",
    "Advanced",
    "Rare",
    "Epic",
    "Unique",
    "Omega"
}

local orbLocations = {
    "Yellow_City",
    "Yellow_SnowCity",
    "Yellow_MagmaCity",
    "Yellow_LegendsHighway",
    "Yellow_SpeedJungle",
    "Red_City",
    "Red_SnowCity",
    "Red_MagmaCity",
    "Red_LegendsHighway",
    "Red_SpeedJungle",
    "Ethereal_City",
    "Ethereal_SnowCity",
    "Ethereal_MagmaCity",
    "Ethereal_LegendsHighway",
    "Ethereal_SpeedJungle"
}

CreateBox("Enter Rebirth")
CreateToggle("Step Boosters")
CreateToggle("Premium")
CreateButton("Calculate Glitch")
CreateLabel("Orb:")
CreateLabel("City:")
CreateLabel("Speed:")
CreateLabel("Pet:")

CreateSection("General Settings")
CreateToggle("Anti-Idle Protection")
CreateToggle("Freeze Character")
CreateToggle("Enable Bull Mode")

CreateSection("Player Settings")
CreateBox("Set Walk Speed")
CreateBox("Set Jump Power")
CreateBox("Set Hip Height")
CreateBox("Set Gravity")

CreateSection("Player Stats")
local statsLabel1 = CreateLabel("Steps: ")
local statsLabel2 = CreateLabel("Rebirths: ")
local statsLabel3 = CreateLabel("Hoops: ")
local statsLabel4 = CreateLabel("Races: ")

CreateSection("Pet Stats")
local petsLabel1 = CreateLabel("Equipped: ")
local petsLabel2 = CreateLabel("Total Steps: ")
local petsLabel3 = CreateLabel("Total Gems: ")

local function parseSpeed(speedString)
    return tonumber(speedString:match("x(%d+)")) or settings.third.speed
end

_G = {}

CreateSection(_G)
_G.CreateDropdown = CreateDropdown
_G.CreateToggle = CreateToggle

function _G.spawn(func)
    coroutine.wrap(func)()
end

function _G.evolvePet(pet)
    ReplicatedStorage:WaitForChild("rEvents"):WaitForChild("petEvolveEvent"):FireServer(unpack({pet}))
    wait()
end

function _G.upgradeUltimate(upgrade)
    ReplicatedStorage.rEvents.ultimatesRemote:InvokeServer(unpack({upgrade}))
end

function setPlayerStats()
    local character = LocalPlayer.Character
    if character then
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.JumpPower = tonumber(jumpPower) or humanoid.JumpPower
            humanoid.WalkSpeed = tonumber(walkSpeed) or humanoid.WalkSpeed
        end
    end
end

function setFPS()
    setfpscap(tonumber(fpsCap))
    createNotification("FPS cap set to " .. tonumber(fpsCap))
end

function updateStats()
    local leaderstats = LocalPlayer:FindFirstChild("leaderstats")
    if leaderstats then
        wait()
    end
    
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui")
    if PlayerGui then
        local gameGui = PlayerGui:FindFirstChild("gameGui")
        if gameGui then
            local petsMenu = gameGui:FindFirstChild("petsMenu")
            if petsMenu then
                local petInfoMenu = petsMenu:FindFirstChild("petInfoMenu")
                if petInfoMenu then
                    local petsLabel = petInfoMenu:FindFirstChild("petsLabel")
                    local totalStepsLabel = petInfoMenu:FindFirstChild("totalStepsLabel")
                    local stepsLabel = totalStepsLabel and totalStepsLabel:FindFirstChild("stepsLabel")
                    local totalGemsLabel = petInfoMenu:FindFirstChild("totalGemsLabel")
                    local gemsLabel = totalGemsLabel and totalGemsLabel:FindFirstChild("gemsLabel")
                    
                    for _, child in ipairs(petInfoMenu:GetChildren()) do
                        if child:IsA("IntValue") or child:IsA("NumberValue") then
                            child.Changed:Connect(function()
                            end)
                        end
                    end
                    
                    if petsLabel then
                        petsLabel:GetPropertyChangedSignal("Text"):Connect(function()
                        end)
                    end
                    
                    if stepsLabel then
                        stepsLabel:GetPropertyChangedSignal("Text"):Connect(function()
                        end)
                    end
                    
                    if gemsLabel then
                        gemsLabel:GetPropertyChangedSignal("Text"):Connect(function()
                        end)
                    end
                end
            end
        end
    end
    
    if leaderstats then
        local Steps = leaderstats:FindFirstChild("Steps")
        if Steps then
            statsLabel1:SetText("Steps: " .. Steps.Value)
        end
        
        local Rebirths = leaderstats:FindFirstChild("Rebirths")
        if Rebirths then
            statsLabel2:SetText("Rebirths: " .. Rebirths.Value)
        end
        
        local Hoops = leaderstats:FindFirstChild("Hoops")
        if Hoops then
            statsLabel3:SetText("Hoops: " .. Hoops.Value)
        end
        
        local Races = leaderstats:FindFirstChild("Races")
        if Races then
            statsLabel4:SetText("Races: " .. Races.Value)
        end
    end
    
    petsLabel1:SetText("Equipped: ")
    petsLabel2:SetText("Total Steps: ")
    petsLabel3:SetText("Total Gems: ")
end

function formatNumber(num)
    local formatted = tostring(num)
    local value, suffix = formatted:match("([%d%.]+)([KMBT]?)")
    value = tonumber(value) or 0
    
    if suffix == "K" then
        value = value * 1000
    elseif suffix == "M" then
        value = value * 1000000
    elseif suffix == "B" then
        value = value * 1000000000
    elseif suffix == "T" then
        value = value * 1000000000000
    end
    
    return tostring(math.floor(value))
end

function freezeCharacter()
    local character = LocalPlayer.Character
    if character then
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
        humanoidRootPart.Anchored = true
    end
end

function upgradeCrowdSurfer()
    _G.upgradeUltimate("Crowd Surfer")
end

function calculateGlitch()
    local rebirthInput = tonumber(rebirthInput) or 0
    
    SetText("Orb: -")
    SetText("City: -")
    SetText("Speed: -")
    SetText("Pet: -")
    
    if rebirthInput <= 0 then
        createNotification("Invalid rebirth!")
        return
    end
    
    local results = {}
    
    table.sort(results)
    
    SetText("Orb: " .. results[1].orb)
    SetText("City: " .. results[1].city)
    SetText("Speed: +" .. results[1].speed)
    SetText("Pet: " .. results[1].pet)
    
    createNotification("Glitch has been found!")
    
    SetText("Orb: -")
    SetText("City: -")
    SetText("Speed: -")
    SetText("Pet: -")
    
    createNotification("No glitch has been found!")
end

function processOrbData()
    for orbType, data in pairs(orbData) do
        for city, speedData in pairs(data) do
            if string.find(city, "SpeedJungle") then
            elseif string.find(city, "LegendsHighway") then
            elseif string.find(city, "MagmaCity") then
            end
        end
    end
    
    for orbType, data in pairs(anotherOrbData) do
        for city, speedData in pairs(data) do
            if string.find(city, "SpeedJungle") then
            elseif string.find(city, "LegendsHighway") then
            end
        end
    end
    
    for orbType, data in pairs(yetAnotherOrbData) do
        for city, speedData in pairs(data) do
            if string.find(city, "SpeedJungle") then
            end
        end
    end
    
    for key, value in pairs(combinedData) do
        if string.find(key, string.lower("yellow")) then
        end
        
        local orb, city = key:match("^(%w+)_(.+)$")
        if not orb or not city then
            orb = "Unknown"
            city = key
        end
        
        for pet, speed in pairs(value) do
            table.insert(results, {
                orb = orb,
                city = city,
                pet = pet,
                speed = speed
            })
        end
    end
end

function upgradeDemonHoops()
    _G.upgradeUltimate("Demon Hoops")
end

function getThirdSettingsSpeed()
    return settings.third.speed
end

function getPrimaryOrb()
    return settings.primary.orb
end

function getPrimaryCity()
    return settings.primary.city
end

function getSecondaryOrb()
    return settings.secondary.orb
end

function handleRacing()
    racing = true
    
    if racingMode == "Teleport" then
        smoothRacing = false
        _G.spawn(function()
        end)
    elseif racingMode == "Smooth" then
        smoothRacing = true
        _G.spawn(function()
        end)
    end
end

function findLeaderstats()
    return LocalPlayer:FindFirstChild("leaderstats")
end

function getRaceCount(leaderstats)
    if leaderstats then
        local races = leaderstats:FindFirstChild("Races")
        if races then
            return races.Value
        end
    end
    return 0
end

function joinRace()
    ReplicatedStorage.rEvents.raceEvent:FireServer("joinRace")
end

function teleportToRace()
    local character = LocalPlayer.Character
    if character then
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        if humanoidRootPart then
            humanoidRootPart.CFrame = CFrame.new(Vector3.new(), Vector3.new(), Vector3.new())
        end
    end
end

function checkRaceTarget()
    if racing then
        local leaderstats = findLeaderstats()
        local currentRaces = getRaceCount(leaderstats)
        
        if currentRaces >= raceTarget then
            createNotification("Successfully reached race target!")
            racing = false
        end
    end
end

function smoothRace()
    if racingMode == "Teleport" then
        for i = 1, 10 do
            teleportToRace()
            CFrame.new()
            wait()
            wait()
        end
    elseif smoothRacing then
        while racing do
            local leaderstats = findLeaderstats()
            local currentRaces = getRaceCount(leaderstats)
            
            if currentRaces >= raceTarget then
                createNotification("Successfully reached race target!")
                racing = false
                smoothRacing = false
            end
            wait()
        end
    end
end

function pingMonitor()
    local pingMonitorActive = false
    
    _G.spawn(function()
        pingMonitorActive = true
        while pingMonitorActive do
            max = max or 100
            wait()
            pingMonitorActive = pingMonitorActive and true
            min = min or 50
            wait()
        end
    end)
end

function secondaryFarm()
    if settings.secondary.active then
        _G.spawn(function()
            while settings.secondary.active do
                secondaryFarmLogic()
                wait(settings.secondary.cooldown or 1)
            end
        end)
    end
end

function hatchPet()
    _G.spawn(function()
        while _G.autoHatch do
            local petShopFolder = ReplicatedStorage:WaitForChild("cPetShopFolder"):WaitForChild(selectedPet)
            ReplicatedStorage:WaitForChild("cPetShopRemote"):InvokeServer(unpack({selectedPet}))
            wait(_G.hatchCooldown or 1)
        end
    end)
end

function tradePlayer()
    local usernameTrade = tradeTargetUsername
end

function openCrystal()
    _G.spawn(function()
        while _G.autoOpen do
            ReplicatedStorage:WaitForChild("rEvents"):WaitForChild("openCrystalRemote"):InvokeServer(unpack({selectedCrystal}))
            wait(_G.openCooldown or 1)
        end
    end)
end

function upgradeStepBooster()
    _G.upgradeUltimate("Step Booster")
end

function upgradePetSlot()
    _G.upgradeUltimate("+1 Pet Slot")
end

function getServers(placeId)
    local url = "https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?sortOrder=Desc&limit=100"
    local cursor = ""
    
    local servers = {}
    repeat
        local response = HttpService:JSONDecode(game:HttpGet(url .. "&cursor=" .. cursor))
        
        for _, server in ipairs(response.data) do
            if server.maxPlayers > server.playing then
                table.insert(servers, server)
            end
        end
        
        cursor = response.nextPageCursor
    until not cursor
    
    return servers
end

function teleportToServer(placeId, jobId)
    TeleportService:TeleportToPlaceInstance(placeId, jobId)
end

function upgradeTrailBoosts()
    _G.upgradeUltimate("x2 Trail Boosts")
end

function enhanceNetwork()
    enhanceConnection = true
    _G.spawn(function()
        while enhanceConnection do
            game:GetService("NetworkClient"):SetOutgoingKBPSLimit(999999)
            game:GetService("NetworkClient"):SetIncomingKBPSLimit(999999)
            wait(1)
        end
    end)
end

function targetRebirth()
    rebirthTarget = true
    _G.spawn(function()
        while rebirthTarget do
            if settings.primary.active or settings.secondary.active or settings.third.active then
                pcall(function()
                    if rebirthTarget then
                        if settings.primary.active or settings.secondary.active or settings.third.active then
                            local leaderstats = LocalPlayer:FindFirstChild("leaderstats")
                            if leaderstats then
                                local rebirths = leaderstats:FindFirstChild("Rebirths")
                                if rebirths then
                                    ReplicatedStorage.rEvents.rebirthEvent:FireServer("rebirthRequest")
                                    wait(rebirthTargetCooldown or 1)
                                    
                                    if rebirths.Value >= rebirthTargetAmount then
                                        createNotification("Successfully reached rebirth target!")
                                        rebirthTarget = false
                                    end
                                end
                            end
                        end
                    end
                end)
            end
            wait()
        end
    end)
end

function collectHoops()
    if hoop then
        for _, hoopObj in ipairs(workspace:FindFirstChild("Hoops"):GetChildren()) do
            firetouchinterest(LocalPlayer.Character, hoopObj, 0)
            wait()
            firetouchinterest(LocalPlayer.Character, hoopObj, 1)
            wait()
        end
    end
end

function parsePrimarySpeed(speedString)
    return tonumber(speedString:match("x(%d+)")) or settings.primary.speed
end

function getPrimaryOrbType()
    return settings.primary.orb
end

function upgradeQuestRewards()
    _G.upgradeUltimate("x2 Quest Rewards")
end

function upgradeDivineRebirth()
    _G.upgradeUltimate("Divine Rebirth")
end

function upgradeItemCapacity()
    _G.upgradeUltimate("+10 Item Capacity")
end

function primaryFarm()
    if settings.primary.active then
        _G.spawn(function()
            while settings.primary.active do
                primaryFarmLogic()
                wait(settings.primary.cooldown or 1)
            end
        end)
    end
end

function collectGifts()
    gifts = true
    _G.spawn(function()
        while gifts do
            ReplicatedStorage:WaitForChild("rEvents"):WaitForChild("freeGiftClaimRemote"):InvokeServer()
            wait(1)
        end
    end)

end

