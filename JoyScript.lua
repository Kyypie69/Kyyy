local Material = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kyypie69/Library.UI/refs/heads/main/LosV2Lib.lua  "))()

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local userId = player.UserId
local thumbType = Enum.ThumbnailType.HeadShot
local thumbSize = Enum.ThumbnailSize.Size420x420
local content, isReady = Players:GetUserThumbnailAsync(userId, thumbType, thumbSize)

game:GetService("StarterGui"):SetCore("SendNotification",{  
    Title = "JOY HUB",     
    Text = "Welcome",
    Icon = "",
    Duration = 3,
    Color = "Success"
})

wait(3)

game:GetService("StarterGui"):SetCore("SendNotification",{  
    Title = "Hello",     
    Text = player.Name,
    Icon = content,
    Duration = 2,
    Color = "Info"
})

wait(1)
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Joy HUB", 
    Text = "Script Loaded..", 
    Duration = 6
})

wait(5)

local X = Material.Load({
    Title = "🌺 JOY 🌺 - Legends Of Speed",
    Style = 3,
    SizeX = 500,
    SizeY = 300,
    Theme = "DarkPink",
    ColorOverrides = {
        MainFrame = Color3.fromRGB(255, 20, 147), -- Bright hot pink
        Glow = Color3.fromRGB(255, 105, 180), -- Secondary pink glow
        GlowIntensity = 0.8, -- Adjust glow strength
    }
})

-- Create all tabs
local mainTab = X.New({
    Title = "Main"
})

local farmTab = X.New({
    Title = "Auto Farm"
})

local teleportTab = X.New({
    Title = "Teleport"
})

local raceTab = X.New({
    Title = "Race"
})

local crystalTab = X.New({
    Title = "Crystal"
})

local miscTab = X.New({
    Title = "Misc"
})

local creditsTab = X.New({
    Title = "Credits"
})

-- MAIN TAB
mainTab.Label({
    Text = "Main Features"
})

mainTab.Button({
    Text = "Claim All Chest [Coming Soon]",
    Callback = function()
        print("Claim All Chest - Coming Soon")
    end
})

mainTab.Toggle({
    Text = "Auto Rebirth",
    Callback = function(Value)
        _G.Rebirth = Value
        if Value then
            spawn(function()
                while _G.Rebirth do
                    wait()
                    game.ReplicatedStorage.rEvents.rebirthEvent:FireServer("rebirthRequest")
                end
            end)
        end
    end,
    Enabled = false
})

mainTab.Button({
    Text = "Disable Trading",
    Callback = function()
        game:GetService("ReplicatedStorage").rEvents.tradingEvent:FireServer("disableTrading")
    end
})

mainTab.Button({
    Text = "Enable Trading",
    Callback = function()
        game:GetService("ReplicatedStorage").rEvents.tradingEvent:FireServer("enableTrading")
    end
})

mainTab.Toggle({
    Text = "Spam Chat (Joy Hub)",
    Callback = function(Value)
        _G.Chat = Value
        if Value then
            spawn(function()
                while _G.Chat do
                    wait(1)
                    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Joy On Top", "All")
                end
            end)
        end
    end,
    Enabled = false
})

-- Player List for Teleport
local playerList = {}
for i,v in pairs(game:GetService("Players"):GetPlayers()) do
    if v ~= player then
        table.insert(playerList, v.Name)
    end
end

mainTab.Dropdown({
    Text = "Teleport To Player",
    Callback = function(Value)
        if game.Players:FindFirstChild(Value) then
            player.Character.HumanoidRootPart.CFrame = game.Players[Value].Character.HumanoidRootPart.CFrame * CFrame.new(0,2,1)
        end
    end,
    Options = playerList
})

mainTab.Slider({
    Text = "Walk Speed",
    Callback = function(Value)
        player.Character.Humanoid.WalkSpeed = Value
    end,
    Min = 16,
    Max = 1000,
    Def = 16
})

mainTab.Slider({
    Text = "Jump Power",
    Callback = function(Value)
        player.Character.Humanoid.JumpPower = Value
    end,
    Min = 50,
    Max = 1000,
    Def = 50
})

-- AUTO FARM TAB
farmTab.Label({
    Text = "Auto Farm Settings"
})

local selectedOrb = ""
local selectedFarmLocation = "City"

farmTab.Dropdown({
    Text = "Select Orbs",
    Callback = function(Value)
        selectedOrb = Value
    end,
    Options = {"Red Orbs", "Yellow Orbs", "Gems", "Hoops", "Ethereal Orbs"}
})

farmTab.Dropdown({
    Text = "Select Location",
    Callback = function(Value)
        selectedFarmLocation = Value
    end,
    Options = {"City", "Snow City", "Magma City", "Jungle City", "Speed City"}
})

farmTab.Toggle({
    Text = "Farm Selected Orbs",
    Callback = function(Value)
        _G.FarmOrbs = Value
        if Value and selectedOrb ~= "" then
            spawn(function()
                while _G.FarmOrbs do
                    wait()
                    for i = 1, 50 do
                        if selectedOrb == "Red Orbs" then
                            game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Red Orb", selectedFarmLocation)
                        elseif selectedOrb == "Yellow Orbs" then
                            game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Yellow Orb", selectedFarmLocation)
                        elseif selectedOrb == "Gems" then
                            game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Gem", selectedFarmLocation)
                        elseif selectedOrb == "Ethereal Orbs" then
                            game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Ethereal Orb", selectedFarmLocation)
                        elseif selectedOrb == "Hoops" then
                            local children = workspace.Hoops:GetChildren()
                            for i, child in ipairs(children) do
                                if child.Name == "Hoop" then
                                    child.CFrame = player.Character.HumanoidRootPart.CFrame
                                end
                            end
                        end
                    end
                end
            end)
        end
    end,
    Enabled = false
})

-- RACE TAB (NEW CODE)
raceTab.Label({
    Text = "Auto Race Settings"
})

-- Set default race method
_G.RaceMethod = "Teleport"

raceTab.Dropdown({
    Text = "Race Method",
    Callback = function(Value)
        _G.RaceMethod = Value
    end,
    Options = {"Teleport", "Smooth"}
})

raceTab.Toggle({
    Text = "Auto Race",
    Callback = function(Value)
        _G.AutoRace = Value
        if Value then
            spawn(function()
                local raceFired = false
                local teleported = false
                while _G.AutoRace do
                    wait()
                    local raceTimer = game:GetService("ReplicatedStorage"):FindFirstChild("raceTimer")
                    local raceStarted = game:GetService("ReplicatedStorage"):FindFirstChild("raceStarted")
                    
                    if _G.RaceMethod == "Teleport" then
                        local char = game.Players.LocalPlayer.Character
                        if char and char:FindFirstChild("HumanoidRootPart") then
                            char:MoveTo(Vector3.new(1686.07, 36.31, -5946.63))
                            wait(0.1)
                            char:MoveTo(Vector3.new(48.31, 36.31, -8680.45))
                            wait(0.1)
                            char:MoveTo(Vector3.new(1001.33, 36.31, -10986.21))
                            wait(0.1)
                        end
                        if raceTimer and raceTimer:IsA("IntValue") and raceTimer.Value <= 0 then
                            wait(0.5)
                            game:GetService("ReplicatedStorage"):WaitForChild("rEvents"):WaitForChild("raceEvent"):FireServer("joinRace")
                        end
                    elseif _G.RaceMethod == "Smooth" then
                        if raceTimer and raceTimer:IsA("IntValue") and raceTimer.Value <= 0 and not raceFired then
                            wait(0.5)
                            game:GetService("ReplicatedStorage"):WaitForChild("rEvents"):WaitForChild("raceEvent"):FireServer("joinRace")
                            raceFired = true
                            teleported = false
                        end
                        
                        if raceStarted and raceStarted:IsA("BoolValue") and raceStarted.Value == true and not teleported then
                            local finishParts = workspace:GetDescendants()
                            local closestPart = nil
                            local minDist = math.huge
                            local char = game.Players.LocalPlayer.Character
                            if char and char:FindFirstChild("HumanoidRootPart") then
                                for _, part in ipairs(finishParts) do
                                    if part:IsA("BasePart") and part.Name == "finishPart" then
                                        local dist = (char.HumanoidRootPart.Position - part.Position).Magnitude
                                        if dist < minDist then
                                            minDist = dist
                                            closestPart = part
                                        end
                                    end
                                end
                                if closestPart then
                                    char:MoveTo(closestPart.Position)
                                    teleported = true
                                end
                            end
                        end
                        
                        if raceStarted and raceStarted:IsA("BoolValue") and raceStarted.Value == false then
                            raceFired = false
                        end
                    end
                    
                    wait(0.05)
                end
            end)
        end
    end,
    Enabled = false
})

raceTab.Toggle({
    Text = "Auto Fill Race",
    Callback = function(Value)
        _G.AutoFillRace = Value
        if Value then
            spawn(function()
                local raceEvent = game:GetService("ReplicatedStorage").rEvents.raceEvent
                while _G.AutoFillRace do
                    wait(0.01)
                    raceEvent:FireServer("joinRace")
                end
            end)
        end
    end,
    Enabled = false
})

-- TELEPORT TAB
teleportTab.Label({
    Text = "Location Teleports"
})

local locations = {
    ["City"] = Vector3.new(-9687.1923828125, 59.072853088378906, 3096.58837890625),
    ["Snow City"] = Vector3.new(-9677.6640625, 59.072853088378906, 3783.736572265625),
    ["Magma City"] = Vector3.new(-11053.3837890625, 217.0328369140625, 4896.10986328125),
    ["Legends Highway"] = Vector3.new(-13097.8583984375, 217.0328369140625, 5904.84716796875),
    ["Space"] = Vector3.new(-336.0252380371094, 3.942866802215576, 592.1419067382812),
    ["Desert"] = Vector3.new(2508.404296875, 14.834074974060059, 4352.73388671875)
}

for locationName, position in pairs(locations) do
    teleportTab.Button({
        Text = locationName,
        Callback = function()
            player.Character:MoveTo(position)
        end
    })
end

-- CRYSTAL TAB
crystalTab.Label({
    Text = "Crystal Opening"
})

local selectedCrystal = ""
crystalTab.Dropdown({
    Text = "Select Crystal",
    Callback = function(Value)
        selectedCrystal = Value
    end,
    Options = {"Electro Legends Crystal", "Lava Crystal", "Inferno Crystal", "Snow Crystal", "Electro Crystal", "Space Crystal", "Desert Crystal"}
})

crystalTab.Toggle({
    Text = "Auto Open Crystal",
    Callback = function(Value)
        _G.AutoCrystal = Value
        if Value and selectedCrystal ~= "" then
            spawn(function()
                while _G.AutoCrystal do
                    wait()
                    game:GetService("ReplicatedStorage").rEvents.openCrystalRemote:InvokeServer("openCrystal", selectedCrystal)
                end
            end)
        end
    end,
    Enabled = false
})

-- MISC TAB
miscTab.Label({
    Text = "Miscellaneous Features"
})

miscTab.Button({
    Text = "Disable Jump",
    Callback = function()
        player.Character.Humanoid.JumpPower = 0
    end
})

miscTab.Button({
    Text = "Enable Jump",
    Callback = function()
        player.Character.Humanoid.JumpPower = 50
    end
})

miscTab.Button({
    Text = "Anti AFK",
    Callback = function()
        local vu = game:GetService("VirtualUser")
        game:GetService("Players").LocalPlayer.Idled:connect(function()
            vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
            wait(1)
            vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        end)
    end
})

miscTab.Button({
    Text = "FPS Boost",
    Callback = function()
        local decalsyeeted = true
        local g = game
        local w = g.Workspace
        local l = g.Lighting
        local t = w.Terrain
        t.WaterWaveSize = 0
        t.WaterWaveSpeed = 0
        t.WaterReflectance = 0
        t.WaterTransparency = 0
        l.GlobalShadows = false
        l.FogEnd = 9e9
        l.Brightness = 0
        settings().Rendering.QualityLevel = "Level01"
        for i, v in pairs(g:GetDescendants()) do
            if v:IsA("Part") or v:IsA("Union") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
                v.Material = "Plastic"
                v.Reflectance = 0
            elseif v:IsA("Decal") or v:IsA("Texture") and decalsyeeted then
                v.Transparency = 1
            elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                v.Lifetime = NumberRange.new(0)
            elseif v:IsA("Explosion") then
                v.BlastPressure = 1
                v.BlastRadius = 1
            elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") then
                v.Enabled = false
            elseif v:IsA("MeshPart") then
                v.Material = "Plastic"
                v.Reflectance = 0
                v.TextureID = 10385902758728957
            end
        end
        for i, e in pairs(l:GetChildren()) do
            if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
                e.Enabled = false
            end
        end
    end
})

miscTab.Button({
    Text = "Infinite Jump",
    Callback = function()
        game:GetService("UserInputService").JumpRequest:connect(function()
            game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")
        end)
    end
})

miscTab.Button({
    Text = "Destroy GUI",
    Callback = function()
        for i,v in pairs(game.CoreGui:GetChildren()) do
            if v.Name:find("Material") then
                v:Destroy()
            end
        end
    end
})

-- CREDITS TAB
creditsTab.Label({Text = "Credits: Markyy"})
creditsTab.Label({Text = "Discord: KYY"})
creditsTab.Button({
    Text = "Copy Discord Link",
    Callback = function()
        setclipboard('https://discord.gg/WMAHNafHqZ  ')
    end
})

creditsTab.Label({Text = "Roblox: KYYY"})
creditsTab.Button({
    Text = "Copy Roblox Profile Link",
    Callback = function()
        setclipboard("https://www.roblox.com/users/2815154822/profile  ")
    end
})

print("Joy HUB Loaded Successfully!")
