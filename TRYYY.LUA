-- 50kg Muscle Legends | Fluent GUI Loader + PACK MODE
-- loadstring(game:HttpGet("https://pastebin.com/raw/YOUR_PASTEBIN_HERE"))()

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/download/v1.0.0/Fluent.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "50kg Muscle Legends | Fluent PACK MODE",
    SubTitle = "Fast Rebirth & Grinding for Pack Users",
    TabWidth = 160,
    Size = UDim2.fromOffset(600, 500),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "home" }),
    Farm = Window:AddTab({ Title = "Farm", Icon = "hammer" }),
    Pets = Window:AddTab({ Title = "Pets", Icon = "paw" }),
    Packs = Window:AddTab({ Title = "Packs", Icon = "cube" }),
    Killer = Window:AddTab({ Title = "Kill Aura", Icon = "sword" }),
    Teleports = Window:AddTab({ Title = "Teleports", Icon = "map" }),
    Misc = Window:AddTab({ Title = "Misc", Icon = "settings" }),
    Stats = Window:AddTab({ Title = "Stats", Icon = "chart" }),
    ESP = Window:AddTab({ Title = "ESP", Icon = "eye" })
}

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

-- Utility
local function Notify(Title, Text)
    Fluent:Notify({ Title = Title, Content = Text, Duration = 3 })
end

-- Anti-AFK
player.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

-- PACK PETS
local packPets = {"Swift Samurai", "Tribal Overlord", "Mighty Monster", "Wild Wizard"}

local function EquipPackPet()
    local petsFolder = player:FindFirstChild("petsFolder")
    if not petsFolder then return end

    for _, petName in ipairs(packPets) do
        for _, folder in ipairs(petsFolder:GetChildren()) do
            if folder:IsA("Folder") then
                for _, pet in ipairs(folder:GetChildren()) do
                    if pet.Name == petName then
                        ReplicatedStorage.rEvents.equipPetEvent:FireServer("unequipPet", pet)
                        task.wait(0.1)
                        ReplicatedStorage.rEvents.equipPetEvent:FireServer("equipPet", pet)
                        Notify("Pack Pet Equipped", petName)
                        return true
                    end
                end
            end
        end
    end
    return false
end

-- TABS.PACKS
Tabs.Packs:AddToggle("FastRebirthPack", {
    Title = "Fast Rebirth (Pack Mode)",
    Default = false,
    Callback = function(Value)
        getgenv().fastRebirthPack = Value
        while getgenv().fastRebirthPack do
            if not EquipPackPet() then
                Notify("Pack Mode", "No pack pets found. Stopping.")
                getgenv().fastRebirthPack = false
                break
            end

            local rebirthCost = 10000 + (5000 * player.leaderstats.Rebirths.Value)
            if player.ultimatesFolder:FindFirstChild("Golden Rebirth") then
                local golden = player.ultimatesFolder["Golden Rebirth"].Value
                rebirthCost = math.floor(rebirthCost * (1 - (golden * 0.1)))
            end

            while player.leaderstats.Strength.Value < rebirthCost and getgenv().fastRebirthPack do
                for i = 1, 10 do
                    player.muscleEvent:FireServer("rep")
                end
                task.wait()
            end

            local oldRebirths = player.leaderstats.Rebirths.Value
            repeat
                ReplicatedStorage.rEvents.rebirthRemote:InvokeServer("rebirthRequest")
                task.wait(0.1)
            until player.leaderstats.Rebirths.Value > oldRebirths

            task.wait(0.5)
        end
    end
})

Tabs.Packs:AddToggle("FastGrindPack", {
    Title = "Fast Grinding (Pack Mode)",
    Default = false,
    Callback = function(Value)
        getgenv().fastGrindPack = Value
        if Value then
            if not EquipPackPet() then
                Notify("Pack Mode", "No pack pets found.")
                getgenv().fastGrindPack = false
                return
            end

            for i = 1, 14 do
                task.spawn(function()
                    while getgenv().fastGrindPack do
                        player.muscleEvent:FireServer("rep")
                        task.wait()
                    end
                end)
            end
        end
    end
})

Tabs.Packs:AddButton({
    Title = "Equip Best Pack Pet",
    Callback = EquipPackPet
})

-- ESP (same as before)
local espEnabled = false
local espCache = {}

local function CreateESP(target)
    if espCache[target] then return end
    local bill = Instance.new("BillboardGui")
    bill.Name = "ESP"
    bill.Size = UDim2.new(0, 200, 0, 50)
    bill.StudsOffset = Vector3.new(0, 3, 0)
    bill.Adornee = target.Character:WaitForChild("Head")
    bill.Parent = target.Character

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.Text = string.format("%s\nHP: %s\n%.1f studs", target.DisplayName, target.Character.Humanoid.Health, (target.Character.Head.Position - player.Character.Head.Position).Magnitude)
    label.TextColor3 = Color3.fromRGB(0, 255, 0)
    label.BackgroundTransparency = 1
    label.TextStrokeTransparency = 0
    label.Font = Enum.Font.SourceSansBold
    label.TextSize = 14
    label.Parent = bill

    espCache[target] = bill
end

local function RemoveESP(target)
    if espCache[target] then
        espCache[target]:Destroy()
        espCache[target] = nil
    end
end

local function UpdateESP()
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= player and p.Character and p.Character:FindFirstChild("Head") then
            if espEnabled then
                CreateESP(p)
                local bill = espCache[p]
                if bill then
                    bill.TextLabel.Text = string.format("%s\nHP: %s\n%.1f studs", p.DisplayName, p.Character.Humanoid.Health, (p.Character.Head.Position - player.Character.Head.Position).Magnitude)
                end
            else
                RemoveESP(p)
            end
        end
    end
end

Tabs.ESP:AddToggle("EnableESP", {
    Title = "Enable Player ESP",
    Default = false,
    Callback = function(Value)
        espEnabled = Value
        if not Value then
            for _, v in pairs(espCache) do
                v:Destroy()
            end
            espCache = {}
        end
    end
})

RunService.RenderStepped:Connect(UpdateESP)

-- SaveManager
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})
InterfaceManager:SetFolder("50kgMuscleLegends")
SaveManager:SetFolder("50kgMuscleLegends/config")
InterfaceManager:BuildInterfaceSection(Tabs.Misc)
SaveManager:BuildConfigSection(Tabs.Misc)

Window:SelectTab(1)
Notify("Loaded", "50kg Muscle Legends Fluent Loader + PACK MODE Loaded!")
