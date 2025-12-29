-- Fixed SilenceLib version with proper structure
local SilenceLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kyypie69/Library.UI/refs/heads/main/SilenceLib.lua"))()

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")

local LocalPlayer = Players.LocalPlayer

-- Initialize variables
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

-- Orb and location definitions
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

-- Settings tables
local settings = {
    primary = {
        active = false,
        orb = nil,
        city = nil,
        speed = nil,
        cooldown = nil
    },
    secondary = {
        active = false,
        orb = nil,
        city = nil,
        speed = nil,
        cooldown = nil
    },
    third = {
        active = false,
        orb = nil,
        city = nil,
        speed = nil,
        cooldown = nil
    }
}

-- Create main window using SilenceLib
local window = SilenceLib:AddWindow("Silence | Farming", {
    main_color = Color3.fromRGB(138, 0, 0),
    min_size = Vector2.new(600, 600),
    can_resize = false
})

local function createNotification(text)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Silence",
        Text = text,
        Duration = 3
    })
end

-- Create tabs
local Universal_Tools = window:AddTab("Universal Tools")
local Auto_Farming = window:AddTab("Auto Farming")
local Pet_Hatching = window:AddTab("Pet Hatching")
local Pet_Evolution = window:AddTab("Pet Evolution")
local Crystal_Farming = window:AddTab("Crystal Farming")
local Trail_Hatching = window:AddTab("Trail Hatching")
local Ultimates = window:AddTab("Ultimates")
local Teleportation = window:AddTab("Teleportation")
local Rebirth_System = window:AddTab("Rebirth System")
local Rebirth_Calculator = window:AddTab("Rebirth Calculator")
local Script_Settings = window:AddTab("Script Settings")
local Player_Statistics = window:AddTab("Player Statistics")

-- Universal Tools Tab
Universal_Tools:AddLabel("Miscellaneous")
Universal_Tools:AddButton("Join Desynced Discord", function()
    createNotification("Discord functionality not implemented")
end)

local safeLockToggle = false
Universal_Tools:AddSwitch("Safe Lock", function(value)
    safeLockToggle = value
    createNotification("Safe Lock: " .. tostring(value))
end)

Universal_Tools:AddTextBox("Enter FPS Cap", function(value)
    if tonumber(value) then
        setfpscap(tonumber(value))
        createNotification("FPS cap set to " .. value)
    end
end)

Universal_Tools:AddLabel("Network Optimization")
local pingStabilizer = false
Universal_Tools:AddSwitch("Enable Ping Stabilizer", function(value)
    pingStabilizer = value
    createNotification("Ping Stabilizer: " .. tostring(value))
end)

local connectionEnhancer = false
Universal_Tools:AddSwitch("Connection Enhancer", function(value)
    connectionEnhancer = value
    if value then
        enhanceNetwork()
    else
        enhanceConnection = false
    end
    createNotification("Connection Enhancer: " .. tostring(value))
end)

-- Auto Farming Tab
Auto_Farming:AddLabel("Race Farming")
local racingMode = "Teleport"
local racingModeDropdown = Auto_Farming:AddDropdown("Racing Mode", function(value)
    racingMode = value
    createNotification("Racing Mode: " .. value)
end)
racingModeDropdown:Add("Teleport")
racingModeDropdown:Add("Smooth")

local autoFillRace = false
Auto_Farming:AddSwitch("Auto Fill Race", function(value)
    autoFillRace = value
    createNotification("Auto Fill Race: " .. tostring(value))
end)

Auto_Farming:AddTextBox("Race Target", function(value)
    raceTarget = tonumber(value)
    createNotification("Race Target set to: " .. tostring(raceTarget))
end)

local enableAutoRacing = false
Auto_Farming:AddSwitch("Enable Auto Racing", function(value)
    enableAutoRacing = value
    if value then
        racing = true
        handleRacing()
    else
        racing = false
    end
    createNotification("Auto Racing: " .. tostring(value))
end)

Auto_Farming:AddLabel("Hoop Farming")
Auto_Farming:AddButton("Clear Hoops", function()
    createNotification("Clearing hoops...")
    -- Clear hoops functionality
end)

local enableAutoHoops = false
Auto_Farming:AddSwitch("Enable Auto Hoops", function(value)
    enableAutoHoops = value
    if value then
        hoop = true
        collectHoops()
    else
        hoop = false
    end
    createNotification("Auto Hoops: " .. tostring(value))
end)

Auto_Farming:AddLabel("Extra Farming Options")
local autoGifts = false
Auto_Farming:AddSwitch("Enable Auto Gifts", function(value)
    autoGifts = value
    if value then
        gifts = true
        collectGifts()
    else
        gifts = false
    end
    createNotification("Auto Gifts: " .. tostring(value))
end)

local autoClaimChests = false
Auto_Farming:AddSwitch("Auto Claim Chests", function(value)
    autoClaimChests = value
    createNotification("Auto Claim Chests: " .. tostring(value))
end)

local autoSpinWheel = false
Auto_Farming:AddSwitch("Auto Spin Wheel", function(value)
    autoSpinWheel = value
    createNotification("Auto Spin Wheel: " .. tostring(value))
end)

Auto_Farming:AddButton("Claim All Codes", function()
    createNotification("Claiming all codes...")
    -- Claim codes functionality
end)

-- Primary Auto Farm Section
Auto_Farming:AddLabel("Primary Auto Farm")
local primaryOrb = nil
local primaryOrbDropdown = Auto_Farming:AddDropdown("Orb Type", function(value)
    primaryOrb = value
    settings.primary.orb = value
    createNotification("Primary Orb: " .. tostring(value))
end)
primaryOrbDropdown:Add(Yellow_Orb)
primaryOrbDropdown:Add(Orange_Orb)
primaryOrbDropdown:Add(Blue_Orb)
primaryOrbDropdown:Add(Red_Orb)
primaryOrbDropdown:Add(Ethereal_Orb)

local primaryCity = nil
local primaryCityDropdown = Auto_Farming:AddDropdown("Target City", function(value)
    primaryCity = value
    settings.primary.city = value
    createNotification("Primary City: " .. tostring(value))
end)
primaryCityDropdown:Add(City)
primaryCityDropdown:Add(Snow_City)
primaryCityDropdown:Add(Magma_City)
primaryCityDropdown:Add(Legends_Highway)
primaryCityDropdown:Add(Speed_Jungle)

local primarySpeed = nil
local primarySpeedDropdown = Auto_Farming:AddDropdown("Collection Rate", function(value)
    primarySpeed = parseSpeed(value)
    settings.primary.speed = primarySpeed
    createNotification("Primary Speed: " .. tostring(primarySpeed))
end)
for i = 8, 18 do
    primarySpeedDropdown:Add("x" .. (i * 100) .. " Orbs")
end

Auto_Farming:AddTextBox("Orb Collection Cooldown", function(value)
    settings.primary.cooldown = tonumber(value) or 1
    createNotification("Primary Cooldown: " .. tostring(settings.primary.cooldown))
end)

local primaryAutoFarm = false
Auto_Farming:AddSwitch("Enable Auto Orb Collection", function(value)
    primaryAutoFarm = value
    settings.primary.active = value
    if value then
        primaryFarm()
    end
    createNotification("Primary Auto Farm: " .. tostring(value))
end)

-- Helper functions
function parseSpeed(speedString)
    local speed = tonumber(speedString:match("x(%d+)")) or 1000
    return speed
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

function enhanceNetwork()
    enhanceConnection = true
    coroutine.wrap(function()
        while enhanceConnection do
            pcall(function()
                game:GetService("NetworkClient"):SetOutgoingKBPSLimit(999999)
                game:GetService("NetworkClient"):SetIncomingKBPSLimit(999999)
            end)
            wait(1)
        end
    end)()
end

function collectHoops()
    coroutine.wrap(function()
        while hoop and enableAutoHoops do
            pcall(function()
                local hoops = workspace:FindFirstChild("Hoops")
                if hoops then
                    for _, hoopObj in ipairs(hoops:GetChildren()) do
                        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                            firetouchinterest(LocalPlayer.Character.HumanoidRootPart, hoopObj, 0)
                            wait()
                            firetouchinterest(LocalPlayer.Character.HumanoidRootPart, hoopObj, 1)
                            wait(0.1)
                        end
                    end
                end
            end)
            wait(1)
        end
    end)()
end

function collectGifts()
    coroutine.wrap(function()
        while gifts and autoGifts do
            pcall(function()
                ReplicatedStorage:WaitForChild("rEvents"):WaitForChild("freeGiftClaimRemote"):InvokeServer()
            end)
            wait(1)
        end
    end)()
end

function primaryFarm()
    coroutine.wrap(function()
        while settings.primary.active do
            pcall(function()
                -- Primary farm logic here
                -- This would need to be implemented based on your specific game mechanics
                createNotification("Farming primary orbs...")
            end)
            wait(settings.primary.cooldown or 1)
        end
    end)()
end

function handleRacing()
    coroutine.wrap(function()
        while racing and enableAutoRacing do
            pcall(function()
                -- Racing logic here
                createNotification("Handling racing...")
            end)
            wait(1)
        end
    end)()
end

function hatchPet(petType)
    coroutine.wrap(function()
        while autoHatchBasic and selectedBasicPet do
            pcall(function()
                local petShopFolder = ReplicatedStorage:WaitForChild("cPetShopFolder")
                if petShopFolder:FindFirstChild(selectedBasicPet) then
                    ReplicatedStorage:WaitForChild("cPetShopRemote"):InvokeServer(selectedBasicPet)
                    createNotification("Hatching " .. selectedBasicPet)
                end
            end)
            wait(1)
        end
    end)()
end

-- Initialize the script
createNotification("Silence Farming script loaded successfully!")

-- Make the window visible
SilenceLib:FormatWindows()
