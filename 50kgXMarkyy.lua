local Library = loadstring(game:HttpGetAsync("https://github.com/ActualMasterOogway/Fluent-Renewed/releases/latest/download/Fluent.luau"))()
local SaveManager = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/ActualMasterOogway/Fluent-Renewed/master/Addons/SaveManager.luau"))()
local InterfaceManager = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/ActualMasterOogway/Fluent-Renewed/master/Addons/InterfaceManager.luau"))()
-- 🏠 Creation
local Window = Library:CreateWindow{
    Title = "Muscle Legends | KYY HUB",
    SubTitle = "KYYY ON TOP",
    TabWidth = 125,
    Size = UDim2.fromOffset(600, 325),
    Resize = false,
    Acrylic = true,
    Theme = "Viow Neon",
    MinimizeKey = Enum.KeyCode.RightControl
}local Tabs = {
	Main = Window:CreateTab{
		Title = "Home | Packs",
		Icon = "phosphor-users-bold"
	},
	AutoFarm = Window:CreateTab{
		Title = "Auto Farm Tools",
		Icon = "phosphor-robot-bold"
	},
   	IslandFarm = Window:CreateTab{
		Title = "Island Rock Punch",
		Icon = "phosphor-map-pin-bold"
    	},
	Rebirth = Window:CreateTab{
		Title = "Rebirth",
		Icon = "phosphor-arrows-clockwise-bold"
	},
	Killing = Window:CreateTab{
		Title = "Killing",
		Icon = "skull"
	},
	Stats = Window:CreateTab{
		Title = "Stats",
		Icon = "phosphor-sparkle-bold"
	},
	Misc = Window:CreateTab{
		Title = "Misc",
		Icon = "phosphor-map-pin-bold"
	},
	Settings = Window:CreateTab{
		Title = "Settings",
		Icon = "phosphor-sliders-bold"
	},
	SkyChanger = Window:CreateTab{
		Title = "Sky Changer",
		Icon = "island"
	}
}

local Options = Library.Options  
local MainSection = Tabs.Main:CreateSection("PACKS ONLY")
local selectedSize = "2"


	Tabs.Main:AddButton({
        Title = "Packs Farm Rebirth",
        Description = "230K+ A DAY",
        Callback = function()
            Window:Dialog({
                Title = "Fast Rebirth",
                Content = "DO **NOT** EXECUTE IF YOU DONT WANNA REBIRTH",
                Buttons = {
                    {
                        Title = "Confirm",
                        Callback = function()
                            local a=game:GetService("ReplicatedStorage")local b=game:GetService("Players")local c=b.LocalPlayer;local d=function(e)local f=c.petsFolder;for g,h in pairs(f:GetChildren())do if h:IsA("Folder")then for i,j in pairs(h:GetChildren())do a.rEvents.equipPetEvent:FireServer("unequipPet",j)end end end;task.wait(.1)end;local k=function(l)d()task.wait(.01)for m,n in pairs(c.petsFolder.Unique:GetChildren())do if n.Name==l then a.rEvents.equipPetEvent:FireServer("equipPet",n)end end end;local o=function(p)local q=workspace.machinesFolder:FindFirstChild(p)if not q then for r,s in pairs(workspace:GetChildren())do if s:IsA("Folder")and s.Name:find("machines")then q=s:FindFirstChild(p)if q then break end end end end;return q end;local t=function()local u=game:GetService("VirtualInputManager")u:SendKeyEvent(true,"E",false,game)task.wait(.1)u:SendKeyEvent(false,"E",false,game)end;task.spawn(function()while true do local v=c.leaderstats.Rebirths.Value;local w=10000+(5000*v)if c.ultimatesFolder:FindFirstChild("Golden Rebirth")then local x=c.ultimatesFolder["Golden Rebirth"].Value;w=math.floor(w*(1-(x*0.1)))end;d()task.wait(.1)k("Swift Samurai")while c.leaderstats.Strength.Value<w do for y=1,10 do c.muscleEvent:FireServer("rep")end;task.wait()end;d()task.wait(.1)k("Tribal Overlord")local z=o("Jungle Bar Lift")if z and z:FindFirstChild("interactSeat")then c.Character.HumanoidRootPart.CFrame=z.interactSeat.CFrame*CFrame.new(0,3,0)repeat task.wait(.1)t()until c.Character.Humanoid.Sit end;local A=c.leaderstats.Rebirths.Value;repeat a.rEvents.rebirthRemote:InvokeServer("rebirthRequest")task.wait(.1)until c.leaderstats.Rebirths.Value>A;task.wait()end end)
                    end
                    },
                    {
                        Title = "Cancel",
                        Callback = function()
                            print("Cancelled the dialog.")
                        end
                    }
                }
            })
        end
    })


Tabs.Main:AddButton({
        Title = "Fast Grind",
        Description = "Super Speed (With Swifts)",
        Callback = function()
            Window:Dialog({
                Title = "Super Speed",
                Content = "Speed Grind",
                Buttons = {
                    {
                        Title = "Confirm",
                        Callback = function()
                          local a = game:GetService("ReplicatedStorage")
local b = game:GetService("Players")
local c = b.LocalPlayer
 
-- Fun??o para equipar apenas o "Swift Samurai" (sem desequipar nada antes)
local function k()
    for m, n in pairs(c.petsFolder.Unique:GetChildren()) do
        if n.Name == "Swift Samurai" then
            a.rEvents.equipPetEvent:FireServer("equipPet", n)
        end
    end
end
 
-- Loop principal focado apenas em ganhar Strength rapidamente
task.spawn(function()
    k() -- Equipa o Swift Samurai no come?o e n?o troca mais
 
    while true do
        -- Farm de Strength (agora com 0.001s de delay)
        for y = 1, 20 do
            c.muscleEvent:FireServer("rep")
        end
        task.wait(0.001) -- Super rápido
    end
end)
                    end
                    },
                    {
                        Title = "Cancel",
                        Callback = function()
                            print("Cancelled the dialog.")
                        end
                    }
                }
            })
        end
    })


local Toggle = Tabs.AutoFarm:CreateToggle("Weight", {
	Title = "Auto Weight",
	Description = "Auto Lift Weight",
	Default = false,
	Callback = function(Value)
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
		while _G.AutoWeight do
			game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep")
			task.wait(0)
		end
	end
})

local Toggle = Tabs.AutoFarm:CreateToggle("Pushups", {
	Title = "Auto Pushups",
	Description = "Auto Lift Pushups",
	Default = false,
	Callback = function(Value)
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
		while _G.AutoPushups do
			game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep")
			task.wait(0)
		end
	end
})

local Toggle = Tabs.AutoFarm:CreateToggle("Handstands", {
	Title = "Auto Handstands",
	Description = "Auto Lift Handstands",
	Default = false,
	Callback = function(Value)
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
		while _G.AutoHandstands do
			game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep")
			task.wait(0)
		end
	end
})

local Toggle = Tabs.AutoFarm:CreateToggle("Situps", {
	Title = "Auto Situps",
	Description = "Auto Lift Situps",
	Default = false,
	Callback = function(Value)
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
		while _G.AutoSitups do
			game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep")
			task.wait(0)
		end
	end
})

local Toggle = Tabs.AutoFarm:CreateToggle("Punch", {
	Title = "Auto Punch",
	Description = "Auto Punch",
	Default = false,
	Callback = function(Value)
		_G.fastHitActive = Value
		if Value then
			local function equipAndModifyPunch()
				while _G.fastHitActive do
					local player = game.Players.LocalPlayer
					local punch = player.Backpack:FindFirstChild("Punch")
					if punch then
						punch.Parent = player.Character
						if punch:FindFirstChild("attackTime") then
							punch.attackTime.Value = 0
						end
					end
					wait(0)
				end
			end
			local function rapidPunch()
				while _G.fastHitActive do
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
			end
			coroutine.wrap(equipAndModifyPunch)()
			coroutine.wrap(rapidPunch)()
		else
			local character = game.Players.LocalPlayer.Character
			local equipped = character:FindFirstChild("Punch")
			if equipped then
				equipped.Parent = game.Players.LocalPlayer.Backpack
			end
		end
	end
})
local Toggle = Tabs.AutoFarm:CreateToggle("ToolSpeed", {
	Title = "Fast Tools",
	Description = "Fast Tools",
	Default = false,
	Callback = function(Value)
		_G.FastTools = Value
		local defaultSpeeds = {
			{
				"Punch",
				"attackTime",
				Value and 0 or 0.35
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
	end
})

local RockSection = Tabs.IslandFarm:CreateSection("Rock Farm")
local selectrock = ""
local Toggle = Tabs.IslandFarm:CreateToggle("LegendGymRock", {
	Title = "Farm Legend Gym Rock",
	Description = "Farm rocks at Legend Gym",
	Default = false,
	Callback = function(Value)
		selectrock = "Legend Gym Rock"
		getgenv().autoFarm = Value
		while getgenv().autoFarm do
			task.wait()
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
	end
})

function gettool()
	for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
		if v.Name == "Punch" and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
			game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
		end
	end
	game:GetService("Players").LocalPlayer.muscleEvent:FireServer("punch", "leftHand")
	game:GetService("Players").LocalPlayer.muscleEvent:FireServer("punch", "rightHand")
end

local Toggle = Tabs.IslandFarm:CreateToggle("MuscleKingGymRock", {
	Title = "Farm Muscle King Gym Rock",
	Description = "Farm rocks at Muscle King Gym",
	Default = false,
	Callback = function(Value)
		selectrock = "Muscle King Gym Rock"
		getgenv().autoFarm = Value
		while getgenv().autoFarm do
			task.wait()
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
	end
})

local Toggle = Tabs.IslandFarm:CreateToggle("AncientJungleRock", {
	Title = "Farm Ancient Jungle Rock",
	Description = "Farm rocks at Ancient Jungle",
	Default = false,
	Callback = function(Value)
		selectrock = "Ancient Jungle Rock"
		getgenv().autoFarm = Value
		while getgenv().autoFarm do
			task.wait()
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
	end
})

local Section = Tabs.Rebirth:CreateSection("AutoRebirth")

local targetRebirthValue = 1
local initialRebirths = game.Players.LocalPlayer.leaderstats.Rebirths.Value

local Paragraph = Tabs.Rebirth:CreateParagraph("RebirthStats", {
	Title = "Rebirth Stats",
	Content = "Loading Stats",
	TitleAlignment = "Left",
	ContentAlignment = Enum.TextXAlignment.Left
})

local function updateStats()
	local currentRebirths = game.Players.LocalPlayer.leaderstats.Rebirths.Value
	local gained = currentRebirths - initialRebirths
	Paragraph:SetContent(string.format("Target Rebirth: %d\nCurrent Rebirths: %d\nRebirths Gained: %d", targetRebirthValue, currentRebirths, gained))
end

game.Players.LocalPlayer.leaderstats.Rebirths.Changed:Connect(updateStats)
updateStats()

local targetInput = Tabs.Rebirth:CreateInput("TargetRebirth", {
	Title = "Target Rebirth",
	Description = "Enter target rebirth",
	Default = "",
	Placeholder = "Enter amount",
	Numeric = true,
	Finished = true,
	Callback = function(Value)
		targetRebirthValue = tonumber(Value) or 1
		updateStats()
	end
})
-------------------------------------------
-- GUI  (Misc tab)
-------------------------------------------
local Misc = Tabs.Misc

local Toggle = Tabs.Misc:AddToggle("AutoWheel", {
	Title = "Auto Spin Wheel",
	Default = false,
	Callback = function(v)
		while v do
			game:GetService("ReplicatedStorage").rEvents.openFortuneWheelRemote:InvokeServer("openFortuneWheel", game:GetService("ReplicatedStorage").fortuneWheelChances["Fortune Wheel"])
			task.wait(1)
		end
	end
})

Tabs.Misc:CreateButton{
	Title = "Low Graphics / Anti-Crashed",
	Description = "Optimize Performance",
	Callback = function()
		for _, v in pairs(game:GetDescendants()) do
			if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke") or v:IsA("Fire") or v:IsA("Sparkles") then
				v.Enabled = false
			end
		end
		local lighting = game:GetService("Lighting")
		lighting.GlobalShadows = false
		lighting.FogEnd = 9e9
		for _, v in pairs(workspace:GetDescendants()) do
			if v:IsA("BasePart") and not v.Parent:FindFirstChild("Humanoid") then
				v.Material = Enum.Material.SmoothPlastic
				if v:IsA("Texture") then
					v:Destroy()
				end
			end
		end
		settings().Rendering.QualityLevel = 1
	end
}

local Toggle = Tabs.Misc:CreateToggle("FrameToggle", {
	Title = "Hide All Frames",
	Description = "Hide all game frames",
	Default = false,
	Callback = function(Value)
		local rSto = game:GetService("ReplicatedStorage")
		for _, obj in pairs(rSto:GetChildren()) do
			if obj.Name:match("Frame$") then
				obj.Visible = not Value
			end
		end
	end
})

Tabs.Misc:AddButton({
        Title = "Protein Egg",
        Description = "Auto Eat Egg",
        Callback = function()
            Window:Dialog({
                Title = "Protein Egg",
                Content = "DO **NOT** EXECUTE IF YOU DONT WANNA EAT",
                Buttons = {
                    {
                        Title = "Confirm",
                        Callback = function()
				local LocalPlayer = game:GetService("Players").LocalPlayer local muscleEvent = LocalPlayer:WaitForChild("muscleEvent") while true do wait(1800) muscleEvent:FireServer("proteinEgg", LocalPlayer.Backpack:FindFirstChild("Protein Egg")) end				
                    end
                    },
                    {
                        Title = "Cancel",
                        Callback = function()
                            print("Cancelled the dialog.")
                        end
                    }
                }
            })
        end
    })

Tabs.Misc:AddButton({
        Title = "Tropical Shake",
        Description = "Auto Drink Shake",
        Callback = function()
            Window:Dialog({
                Title = "Tropical Shake",
                Content = "DO **NOT** EXECUTE IF YOU DONT WANNA DRINK",
                Buttons = {
                    {
                        Title = "Confirm",
                        Callback = function()
				local LocalPlayer = game:GetService("Players").LocalPlayer local muscleEvent = LocalPlayer:WaitForChild("muscleEvent") while true do wait(7) muscleEvent:FireServer("tropicalShake", LocalPlayer.Backpack:FindFirstChild("Tropical Shake")) end				
                    end
                    },
                    {
                        Title = "Cancel",
                        Callback = function()
                            print("Cancelled the dialog.")
                        end
                    }
                }
            })
        end
    })

local targetRebirthLoop = nil
local targetToggle = Tabs.Rebirth:CreateToggle("AutoRebirthTarget", {
	Title = "Auto Rebirth [Target]",
	Description = "Automatically rebirth until target is reached",
	Default = false,
	Callback = function(Value)
		if Value then
			targetRebirthLoop = task.spawn(function()
				while task.wait(0.1) do
					if game.Players.LocalPlayer.leaderstats.Rebirths.Value >= targetRebirthValue then
						targetToggle:SetValue(false)
						break
					end
					game:GetService("ReplicatedStorage").rEvents.rebirthRemote:InvokeServer("rebirthRequest")
				end
			end)
		else
			if targetRebirthLoop then
				task.cancel(targetRebirthLoop)
				targetRebirthLoop = nil
			end
		end
	end
})

local infiniteRebirthLoop = nil
local infiniteToggle = Tabs.Rebirth:CreateToggle("AutoRebirthInfinite", {
	Title = "Auto Rebirth [Infinite]",
	Description = "Continuously rebirth without stopping",
	Default = false,
	Callback = function(Value)
		if Value then
			infiniteRebirthLoop = task.spawn(function()
				while task.wait(0.1) do
					game:GetService("ReplicatedStorage").rEvents.rebirthRemote:InvokeServer("rebirthRequest")
				end
			end)
		else
			if infiniteRebirthLoop then
				task.cancel(infiniteRebirthLoop)
				infiniteRebirthLoop = nil
			end
		end
	end
})

local teleportLoop = nil
local kingTeleportToggle = Tabs.IslandFarm:CreateToggle("MuscleKingTeleport", {
	Title = "Auto Teleport (MuscleKing)",
	Description = "Continuously",
	Default = false,
	Callback = function(Value)
		if Value then
			teleportLoop = task.spawn(function()
				while task.wait(0) do
					if game.Players.LocalPlayer.Character then
						game.Players.LocalPlayer.Character:MoveTo(Vector3.new(-8646, 17, -5738))
					end
				end
			end)
		else
			if teleportLoop then
				task.cancel(teleportLoop)
				teleportLoop = nil
			end
		end
	end
})

-- Auto Punch Toggle (No Animation)
local Toggle = Tabs.Killing:CreateToggle("AutoPunchNoAnim", {Title = "Auto Punch (No Anim)", Default = false})
Toggle:OnChanged(function(state)
    while state and Toggle.Value do
        local player = game.Players.LocalPlayer
        local char = game.Workspace:FindFirstChild(player.Name)
        local punchTool = player.Backpack:FindFirstChild("Punch") or (char and char:FindFirstChild("Punch"))

        if punchTool then
            if punchTool.Parent ~= char then
                punchTool.Parent = char -- Equip
            end

            player.muscleEvent:FireServer("punch", "rightHand")
            player.muscleEvent:FireServer("punch", "leftHand")
        else
            warn("Punch tool not found")
            Toggle:SetValue(false) -- Stop if tool not found
        end
        task.wait()
    end
end)

-- Speed Punch Button
Tabs.Killing:CreateButton({
    Title = "Fast Punch",
    Callback = function()
        local player = game.Players.LocalPlayer
        local punch = player.Backpack:FindFirstChild("Punch") or (game.Workspace:FindFirstChild(player.Name) and game.Workspace[player.Name]:FindFirstChild("Punch"))
        if punch and punch:FindFirstChild("attackTime") then
            punch.attackTime.Value = 0.065
        end
    end
})

-- Normal Punch Button
Tabs.Killing:CreateButton({
    Title = "Normal Punch",
    Callback = function()
        local player = game.Players.LocalPlayer
        local punch = player.Backpack:FindFirstChild("Punch") or (game.Workspace:FindFirstChild(player.Name) and game.Workspace[player.Name]:FindFirstChild("Punch"))
        if punch and punch:FindFirstChild("attackTime") then
            punch.attackTime.Value = 0.35
        end
    end
})

	-- Whitelist Table
local whitelist = {}
local playerList = {}

-- Create Dropdown
local Dropdown = Tabs.Killing:AddDropdown("Whitelist", {
    Title = "Whitelist Player(s)",
    Values = {},
    Multi = true,
    Default = {},
})

-- Populate initially
for _, player in ipairs(game.Players:GetPlayers()) do
    table.insert(playerList, player.Name)
end
Dropdown:SetValues(playerList)

-- Update on PlayerAdded
game.Players.PlayerAdded:Connect(function(player)
    table.insert(playerList, player.Name)
    Dropdown:SetValues(playerList)
end)

-- Update on PlayerRemoving
game.Players.PlayerRemoving:Connect(function(player)
    for i, name in ipairs(playerList) do
        if name == player.Name then
            table.remove(playerList, i)
            break
        end
    end
    Dropdown:SetValues(playerList)
end)

-- Sync whitelist
Dropdown:OnChanged(function(selectedPlayers)
    table.clear(whitelist)
    for _, name in ipairs(selectedPlayers) do
        whitelist[name] = true
    end
    print("Whitelisted:", selectedPlayers)
end)

local AutokillToggle = Tabs.Killing:CreateToggle("AutoKill", {Title = "Auto Kill", Default = false})
AutokillToggle:OnChanged(function(state)
    while state and AutokillToggle.Value do
        local player = game.Players.LocalPlayer

        -- Auto punch setup
        local punch = player.Backpack:FindFirstChild("Punch") or (player.Character and player.Character:FindFirstChild("Punch"))
        if punch and punch:FindFirstChild("attackTime") then
            punch.attackTime.Value = 0.065
        end

        -- Auto kill logic
        for _, target in ipairs(game.Players:GetPlayers()) do
            if target ~= player and not whitelist[target.Name] then
                local root = target.Character and target.Character:FindFirstChild("HumanoidRootPart")
                local rHand = player.Character and player.Character:FindFirstChild("RightHand")
                local lHand = player.Character and player.Character:FindFirstChild("LeftHand")

                if root and rHand and lHand then
                    firetouchinterest(rHand, root, 1)
                    firetouchinterest(lHand, root, 1)
                    firetouchinterest(rHand, root, 0)
                    firetouchinterest(lHand, root, 0)
                end
            end
        end

        task.wait(0.1)
    end
end)

-- Target Kill
-- Target Kill (Dropdown en lugar de Input)
local targetPlayerName = nil

-- Dropdown dinámico
local targetPlayerList = {}
local TargetDropdown = Tabs.Killing:AddDropdown("TargetList", {
    Title = "Target Player",
    Values = {},
    Multi = false, -- solo uno
    Default = {}
})

-- Llenar inicialmente
for _, player in ipairs(game.Players:GetPlayers()) do
    table.insert(targetPlayerList, player.Name)
end
TargetDropdown:SetValues(targetPlayerList)

-- Actualizar al entrar jugador
game.Players.PlayerAdded:Connect(function(player)
    table.insert(targetPlayerList, player.Name)
    TargetDropdown:SetValues(targetPlayerList)
end)

-- Actualizar al salir jugador
game.Players.PlayerRemoving:Connect(function(player)
    for i, name in ipairs(targetPlayerList) do
        if name == player.Name then
            table.remove(targetPlayerList, i)
            break
        end
    end
    TargetDropdown:SetValues(targetPlayerList)
end)

-- Guardar el jugador seleccionado
TargetDropdown:OnChanged(function(selected)
    targetPlayerName = selected
    print("Target set to:", targetPlayerName)
end)

-- Auto Kill Target
local Toggle = Tabs.Killing:CreateToggle("AutoKillTarget", {Title = "Auto Kill Player", Default = false})
Toggle:OnChanged(function(state)
    while state and Toggle.Value do
        local player = game.Players.LocalPlayer
        local target = game.Players:FindFirstChild(targetPlayerName)

        if target and target ~= player then
            local root = target.Character and target.Character:FindFirstChild("HumanoidRootPart")
            local rHand = player.Character and player.Character:FindFirstChild("RightHand")
            local lHand = player.Character and player.Character:FindFirstChild("LeftHand")

            if root and rHand and lHand then
                firetouchinterest(rHand, root, 1)
                firetouchinterest(lHand, root, 1)
                firetouchinterest(rHand, root, 0)
                firetouchinterest(lHand, root, 0)
            end
        end
        task.wait(0.1)
    end
end)

-- Spectate Player (Dropdown + Botón de volver)
local spectateTarget = nil
local spectatePlayerList = {}
local Camera = workspace.CurrentCamera
local LocalPlayer = game.Players.LocalPlayer

-- Dropdown
local SpectateDropdown = Tabs.Killing:AddDropdown("SpectateList", {
    Title = "Spectate Player",
    Values = {},
    Multi = false,
    Default = {}
})

-- Llenar inicialmente con nombres
for _, player in ipairs(game.Players:GetPlayers()) do
    if player ~= LocalPlayer then
        table.insert(spectatePlayerList, player.Name)
    end
end
SpectateDropdown:SetValues(spectatePlayerList)

-- Actualizar al entrar
game.Players.PlayerAdded:Connect(function(player)
    if player ~= LocalPlayer then
        table.insert(spectatePlayerList, player.Name)
        SpectateDropdown:SetValues(spectatePlayerList)
    end
end)

-- Actualizar al salir
game.Players.PlayerRemoving:Connect(function(player)
    for i, name in ipairs(spectatePlayerList) do
        if name == player.Name then
            table.remove(spectatePlayerList, i)
            break
        end
    end
    SpectateDropdown:SetValues(spectatePlayerList)

    if spectateTarget == player.Name then
        spectateTarget = nil
        local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
        if hum then
            Camera.CameraSubject = hum
        end
    end
end)

-- Guardar seleccionado
SpectateDropdown:OnChanged(function(selected)
    spectateTarget = selected
    print("Spectating:", spectateTarget or "None")
end)

-- Botón para volver a ti
Tabs.Killing:CreateButton({
    Title = "View Player",
    Callback = function()
        spectateTarget = nil
        local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
        if hum then
            Camera.CameraSubject = hum
        end
        print("Stopped spectating, returned to self")
    end
})

-- Seguir al jugador
game:GetService("RunService").RenderStepped:Connect(function()
    if spectateTarget then
        local target = game.Players:FindFirstChild(spectateTarget)
        if target and target.Character then
            local hum = target.Character:FindFirstChild("Humanoid")
            if hum then
                Camera.CameraSubject = hum
            end
        end
    end
end)

-- Teleport / Follow Player
local followTarget = nil
local following = false
local Camera = workspace.CurrentCamera
local LocalPlayer = game.Players.LocalPlayer

-- Dropdown de TP
local TeleportDropdown = Tabs.Killing:AddDropdown("TeleportDropdown", {
    Title = "Teleport To Player",
    Values = {},
    Multi = false,
    Default = {}
})

-- Lista dinámica de jugadores
local tpPlayerList = {}
for _, player in ipairs(game.Players:GetPlayers()) do
    if player ~= LocalPlayer then
        table.insert(tpPlayerList, player.Name)
    end
end
TeleportDropdown:SetValues(tpPlayerList)

game.Players.PlayerAdded:Connect(function(player)
    if player ~= LocalPlayer then
        table.insert(tpPlayerList, player.Name)
        TeleportDropdown:SetValues(tpPlayerList)
    end
end)

game.Players.PlayerRemoving:Connect(function(player)
    for i, name in ipairs(tpPlayerList) do
        if name == player.Name then
            table.remove(tpPlayerList, i)
            break
        end
    end
    TeleportDropdown:SetValues(tpPlayerList)
    if followTarget == player.Name then
        followTarget = nil
        following = false
    end
end)

-- Función auxiliar: teletransportar cerca
local function teleportNear(targetPlayer)
    local targetChar = targetPlayer.Character
    if not (targetChar and targetChar:FindFirstChild("HumanoidRootPart")) then return end
    local targetHRP = targetChar.HumanoidRootPart
    local myChar = LocalPlayer.Character
    if not (myChar and myChar:FindFirstChild("HumanoidRootPart")) then return end

    local offset = Vector3.new(5, 3, 5)
    myChar.HumanoidRootPart.CFrame = CFrame.new(targetHRP.Position + offset)
end

-- Al seleccionar jugador -> TP instantáneo
TeleportDropdown:OnChanged(function(selected)
    if selected and selected ~= "" then
        local target = game.Players:FindFirstChild(selected)
        if target then
            teleportNear(target)
            print("Teleported to:", target.Name)
        end
    end
end)

-- Toggle para seguir
local followToggle = Tabs.Killing:CreateToggle("FollowToggle", {Title = "Follow Selected Player", Default = false})
followToggle:OnChanged(function(state)
    following = state
    followTarget = state and TeleportDropdown.Value or nil
end)

-- Botón para dejar de seguir
Tabs.Killing:CreateButton({
    Title = "↩ Stop Following",
    Callback = function()
        following = false
        followTarget = nil
        followToggle:SetValue(false)
        print("Stopped following")
    end
})

-- Loop para seguir
task.spawn(function()
    while true do
        task.wait(0.2)
        if following and followTarget then
            local target = game.Players:FindFirstChild(followTarget)
            if target then
                teleportNear(target)
            else
                following = false
                followTarget = nil
            end
        end
    end
end)
	
local IntSection = Tabs.Stats:CreateSection("Player Stats")
local RunService = game:GetService("RunService")
local player = game.Players.LocalPlayer

local startTime = 0
local sessionStartTime = os.time()
local timerRunning = false

local strengthGained = 0
local lastStrengthValue = nil
local rebirthsGained = 0
local lastRebirthsValue = nil
local killsGained = 0
local lastKillsValue = nil
local brawlsGained = 0
local lastBrawlsValue = nil
local goodKarmaGained = 0
local lastGoodKarmaValue = nil
local evilKarmaGained = 0
local lastEvilKarmaValue = nil
local durabilityGained = 0
local lastDurabilityValue = nil
local agilityGained = 0
local lastAgilityValue = nil
local muscleKingTimeGained = 0
local lastMuscleKingTimeValue = nil

local TimerParagraph = Tabs.Stats:CreateParagraph("SessionTimer", {
	Title = "Elapsed Time",
	Content = "0 Day, 0 Hours, 0 Minutes, 0 Seconds",
	TitleAlignment = "Left",
	ContentAlignment = Enum.TextXAlignment.Left
})

local LeaderParagraph = Tabs.Stats:CreateParagraph("LeaderStats", {
	Title = "Current Stats             |             Gained Stats",
	Content = "Loading Stats",
	TitleAlignment = "Left",
	ContentAlignment = Enum.TextXAlignment.Left
})

local IntParagraph = Tabs.Stats:CreateParagraph("IntStats", {
	Title = "Kill & Brawl Stats",
	Content = "Loading Stats",
	TitleAlignment = "Left",
	ContentAlignment = Enum.TextXAlignment.Left
})


local function formatNumber(number)
	local formatted = tostring(math.floor(number))
	local k
	while true do
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
		if k == 0 then
			break
		end
	end
	return formatted
end

local function formatTime(seconds)
	local days = math.floor(seconds / 86400)
	local hours = math.floor((seconds % 86400) / 3600)
	local minutes = math.floor((seconds % 3600) / 60)
	local secs = seconds % 60
	return string.format("%dd %dh %dm %ds", days, hours, minutes, secs)
end

local function debugPrint(message, value)
	print(string.format("[DEBUG] %s: %s", message, tostring(value)))
end

repeat
	task.wait()
until game:IsLoaded()
debugPrint("")

if not player.Character then
	player.CharacterAdded:Wait()
end
debugPrint("Character Loaded", "Success")

repeat
	task.wait()
until player:FindFirstChild("leaderstats") and player:FindFirstChild("goodKarma")
debugPrint("")

RunService.RenderStepped:Connect(function()
	local sessionTime = os.time() - sessionStartTime
	TimerParagraph:SetContent(formatTime(sessionTime))
	if timerRunning then
		local elapsed = os.time() - startTime
		CustomTimerParagraph:SetContent(formatTime(elapsed))
	end
	local currentStrength = player.leaderstats.Strength.Value
	local currentRebirths = player.leaderstats.Rebirths.Value
	local currentKills = player.leaderstats.Kills.Value
	local currentBrawls = player.leaderstats.Brawls.Value
	local currentDurability = player.Durability.Value
	local currentAgility = player.Agility.Value
	if lastStrengthValue == nil then
		lastStrengthValue = currentStrength
	elseif currentStrength > lastStrengthValue then
		strengthGained = strengthGained + (currentStrength - lastStrengthValue)
	end
	lastStrengthValue = currentStrength
	if lastRebirthsValue == nil then
		lastRebirthsValue = currentRebirths
	elseif currentRebirths > lastRebirthsValue then
		rebirthsGained = rebirthsGained + (currentRebirths - lastRebirthsValue)
	end
	lastRebirthsValue = currentRebirths
	if lastKillsValue == nil then
		lastKillsValue = currentKills
	elseif currentKills > lastKillsValue then
		killsGained = killsGained + (currentKills - lastKillsValue)
	end
	lastKillsValue = currentKills
	if lastBrawlsValue == nil then
		lastBrawlsValue = currentBrawls
	elseif currentBrawls > lastBrawlsValue then
		brawlsGained = brawlsGained + (currentBrawls - lastBrawlsValue)
	end
	lastBrawlsValue = currentBrawls
	if lastDurabilityValue == nil then
		lastDurabilityValue = currentDurability
	elseif currentDurability > lastDurabilityValue then
		durabilityGained = durabilityGained + (currentDurability - lastDurabilityValue)
	end
	lastDurabilityValue = currentDurability
	if lastAgilityValue == nil then
		lastAgilityValue = currentAgility
	elseif currentAgility > lastAgilityValue then
		agilityGained = agilityGained + (currentAgility - lastAgilityValue)
	end
	lastAgilityValue = currentAgility
	LeaderParagraph:SetContent(string.format("Strength: %s     Strength Gained: %s\nRebirths: %s     Rebirths Gained: %s\nDurability: %s     Durability Gained: %s\nAgility: %s     Agility Gained: %s", formatNumber(currentStrength), formatNumber(strengthGained), formatNumber(currentRebirths), formatNumber(rebirthsGained), formatNumber(currentDurability), formatNumber(durabilityGained), formatNumber(currentAgility), formatNumber(agilityGained)))
	IntParagraph:SetContent(string.format("Kills: %s     Kills Gained: %s\nBrawls: %s      Brawls Gained: %s", formatNumber(currentKills), formatNumber(killsGained), formatNumber(currentBrawls), formatNumber(brawlsGained)))
end)

local leaderStats = {
	"Strength",
	"Rebirths",
	"Durability",
    "Agility"
}

local intStats = {
	"Kills",
	"Brawls"
}


Tabs.Settings:AddButton({
        Title = "Anti-AFK",
        Description = "Touch some grass",
        Callback = function()
            Window:Dialog({
                Title = "Anti-AFK",
                Content = "EXECUTE IF YOU DONT WANNA KICKED",
                Buttons = {
                    {
                        Title = "Confirm",
                        Callback = function()
        local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local player = Players.LocalPlayer
 
local gui = Instance.new("ScreenGui", player:FindFirstChildOfClass("PlayerGui"))
 
local textLabel = Instance.new("TextLabel", gui)
textLabel.Size = UDim2.new(0, 200, 0, 50)
textLabel.Position = UDim2.new(0.5, -100, 0, -50)
textLabel.TextColor3 = Color3.fromRGB(50, 255, 50)
textLabel.Font = Enum.Font.GothamBold
textLabel.TextSize = 20
textLabel.BackgroundTransparency = 1
textLabel.TextTransparency = 1
 
local timerLabel = Instance.new("TextLabel", gui)
timerLabel.Size = UDim2.new(0, 200, 0, 30)
timerLabel.Position = UDim2.new(0.5, -100, 0, -20)
timerLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
timerLabel.Font = Enum.Font.GothamBold
timerLabel.TextSize = 18
timerLabel.BackgroundTransparency = 1
timerLabel.TextTransparency = 1
timerLabel.Text = "00:00:00"
 
local startTime = tick()
 
task.spawn(function()
    while true do
        local elapsed = tick() - startTime
        local hours = math.floor(elapsed / 3600)
        local minutes = math.floor((elapsed % 3600) / 60)
        local seconds = math.floor(elapsed % 60)
        timerLabel.Text = string.format("%02d:%02d:%02d", hours, minutes, seconds)
        task.wait(1)
    end
end)
 
task.spawn(function()
    while true do
        for i = 0, 1, 0.01 do
            textLabel.TextTransparency = 1 - i
            timerLabel.TextTransparency = 1 - i
            task.wait(0.015)
        end
        task.wait(1.5)
        for i = 0, 1, 0.01 do
            textLabel.TextTransparency = i
            timerLabel.TextTransparency = i
            task.wait(0.015)
        end
        task.wait(0.8)
    end
end)
 
player.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
    print("AFK prevention completed!")
end)
 
textLabel.Text = "ANTI AFK"
		end
                    },
                    {
                        Title = "Cancel",
                        Callback = function()
                            print("Cancelled the dialog.")
                        end
                    }
                }
            })
        end
    })
    

Window:SelectTab(1)

Library:Notify{
	Title = "Muscle Legends Script",
	Content = "KYY Hub",
	Duration = 5
}

SaveManager:LoadAutoloadConfig()

local TrackingParagraph = Tabs.Stats:CreateParagraph("TrackingStats", {
	Title = "Track Player",
	Content = "No player selected",
	TitleAlignment = "Left",
	ContentAlignment = Enum.TextXAlignment.Left
})

local PlayerInput = Tabs.Stats:CreateInput("PlayerTracker", {
	Title = "Track Player Stats",
	Description = "Enter username",
	Default = "",
	Placeholder = "Enter player name",
	Numeric = false,
	Finished = true,
	Callback = function(Value)
		targetPlayer = Value
	end
})

Tabs.Stats:CreateButton{
	Title = "Track Player",
	Description = "Player's stats",
	Callback = function()
		local foundPlayer = nil
		for _, player in pairs(game.Players:GetPlayers()) do
			local nameLower = player.Name:lower()
			local displayLower = player.DisplayName:lower()
			local searchLower = targetPlayer:lower()
			if nameLower:find(searchLower) or displayLower:find(searchLower) then
				foundPlayer = player
				break
			end
		end
		if foundPlayer then
			local content = string.format("Strength: %s\nRebirths: %s\nKills: %s\nBrawls: %s\nGood Karma: %s\nEvil Karma: %s\nDurability: %s\nAgility: %s", formatNumber(foundPlayer.leaderstats.Strength.Value), formatNumber(foundPlayer.leaderstats.Rebirths.Value), formatNumber(foundPlayer.leaderstats.Kills.Value), formatNumber(foundPlayer.leaderstats.Brawls.Value), formatNumber(foundPlayer.goodKarma.Value), formatNumber(foundPlayer.evilKarma.Value), formatNumber(foundPlayer.Durability.Value), formatNumber(foundPlayer.Agility.Value))
			TrackingParagraph:SetContent(content)
			TrackingParagraph:SetTitle("Track Player" .. foundPlayer.Name)
		end
	end
}

local Toggle = Tabs.Settings:CreateToggle("ToggleName", {
	Title = "Lock Pos",
	Description = "The Man Who Can't Be Moved",
	Default = false,
	Callback = function(Value)
		if Value then
			local currentPos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
			getgenv().posLock = game:GetService("RunService").Heartbeat:Connect(function()
				if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = currentPos
				end
			end)
		else
			if getgenv().posLock then
				getgenv().posLock:Disconnect()
			end
		end
	end
})

local Dropdown = Tabs.Settings:CreateDropdown("TimeControl", {
	Title = "Time Changer",
	Description = "Change Day",
	Values = {
		"Morning",
		"Day",
		"Afternoon",
		"Night"
	},
	Multi = false,
	Default = "Default",
	Callback = function(Value)
		local times = {
			["Morning"] = 2.9,
			["Day"] = 12.9,
			["Afternoon"] = 17.9,
			["Night"] = 0
		}
		game:GetService("Lighting").ClockTime = times[Value]
	end
})

-------------------------------------------------
--  SOFT-WINTER 5-D  (warmer & gentler revision)
-------------------------------------------------
local L = game.Lighting

-- 1.  Base light – lower contrast, warmer sun, gentler shadows
L.Ambient = Color3.fromRGB(200, 205, 215)        -- lifted + warmer
L.Brightness = 0.9                               -- pulled down 0.2
L.ColorShift_Top    = Color3.fromRGB(255, 248, 240)  -- warm sky
L.ColorShift_Bottom = Color3.fromRGB(210, 215, 225)  -- warm bounce
L.OutdoorAmbient = Color3.fromRGB(205, 210, 220)
L.ShadowSoftness = 0.25                          -- was 0.05
L.GlobalShadows = true
L.GeographicLatitude = 68                        -- dropped 7° → lower sun
L.ExposureCompensation = 0.08                    -- slight darken to taste

-- 2.  PBR scales – dial back a touch for velvet surfaces
L.EnvironmentDiffuseScale  = 0.35                -- was 0.45
L.EnvironmentSpecularScale = 0.75                -- was 0.9

-- 3.  “Diamond sparkle” bloom – keep, but softer
local bloom = L:FindFirstChild("BloomEffect") or Instance.new("BloomEffect", L)
bloom.Enabled   = true
bloom.Intensity = 0.55                           -- was 0.75
bloom.Size      = 2400
bloom.Threshold = 0.5                            -- raised → less fire

-- 4.  Crushed-ice grade – less bleach, more cream
local cc = L:FindFirstChild("ColorCorrectionEffect") or Instance.new("ColorCorrectionEffect", L)
cc.Brightness  = 0.06                            -- halved
cc.Contrast    = 0.25                            -- halved
cc.Saturation  = -0.25                           -- eased back
cc.TintColor   = Color3.fromRGB(235, 240, 250)   -- cream-white tint

-- 5.  Volumetric haze – thinner, warmer
local fog = L:FindFirstChild("Atmosphere") or Instance.new("Atmosphere", L)
fog.Density = 0.22                               -- was 0.35
fog.Offset  = 30                                 -- push haze further
fog.Color   = Color3.fromRGB(230, 235, 245)      -- warm fog
fog.Decay   = Color3.fromRGB(200, 210, 225)
fog.Glare   = 0.45                               -- was 0.6

-- 6.  Micro-pulse (kept exactly as-is for 5-D emotion)
local pulse = L:FindFirstChild("Pulse") or Instance.new("BloomEffect", L)
pulse.Name = "Pulse"
pulse.Enabled = true
pulse.Size  = 3200
game:GetService("RunService").Heartbeat:Connect(function(t)
    pulse.Intensity = 0.15 + 0.04 * math.sin(t * 1.6)
end)

Tabs.Settings:CreateButton{
	Title = "Rejoin",
	Description = "Instantly rejoin the same server",
	Callback = function()
		game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
	end
}

Tabs.SkyChanger:AddButton({
    Title = "Full Night Sky",
    Callback = function()
        getgenv().Kitten = 5
        local acrylic = "http://www.roblox.com/asset/?id=17055447520"
  local sky = Instance.new("Sky")
 
  sky.Parent = game.Lighting
 
  sky.CelestialBodiesShown = false
  sky.SkyboxBk = acrylic
  sky.SkyboxDn = acrylic
  sky.SkyboxFt = acrylic
  sky.SkyboxLf = acrylic
  sky.SkyboxRt = acrylic
  sky.SkyboxUp = acrylic
    end
  })
 
 
  Tabs.SkyChanger:AddButton({
    Title = "Vibe Sky",
    Callback = function()
              getgenv().Kitten = 10
  local Lighting = game.Lighting
 
  local sky = Instance.new("Sky")
  sky.Parent = Lighting
  sky.CelestialBodiesShown = false
  sky.MoonTextureId = "rbxasset://sky/moon.jpg"
  sky.SkyboxBk = "rbxassetid://159067838"
  sky.SkyboxDn = "rbxassetid://159067646"
  sky.SkyboxFt = "rbxassetid://159067838"
  sky.SkyboxLf = "rbxassetid://159067744"
  sky.SkyboxRt = "rbxassetid://159067744"
  sky.SkyboxUp = "rbxassetid://159067921"
  sky.StarCount = "3000"
  sky.SunAngularSize = "21"
    sky.SunTextureId = "rbxasset://sky/sun.jpg"
 
  local Atmosphere = Instance.new("Atmosphere")
  Atmosphere.Parent = Lighting
  Atmosphere.Color = Color3.new(250, 250, 250)
    Atmosphere.Decay = Color3.new(255, 255, 255)
 
  local Bloom = Instance.new("BloomEffect")
  Bloom.Parent = Lighting
  Bloom.Enabled = true
  Bloom.Intensity = "0.4"
  Bloom.Size = "24"
    Bloom.Threshold = "0.95"
 
  local Blur = Instance.new("BlurEffect")
  Blur.Parent = Lighting
  Blur.Enabled = true
    Blur.Size = "1.7"
 
  local DepthofField = Instance.new("DepthOfFieldEffect")
  DepthofField.Parent = Lighting
  DepthofField.Enabled = true
  DepthofField.FarIntensity = "0.1"
  DepthofField.FocusDistance = "0.05"
  DepthofField.InFocusRadius = "39"
    DepthofField.NearIntensity = "0.75"
 
  local SunRays = Instance.new("SunRaysEffect")
  SunRays.Parent = Lighting
  SunRays.Enabled = true
  SunRays.Intensity = "0.25"
  SunRays.Spread = "1"
 
  Lighting.ClockTime = "14.5"
  Lighting.GeographicLatitude = "0"
  Lighting.TimeOfDay = "14:30:00"
  Lighting.ExposureCompensation = "0"
 
      end    
  })
 
 
 
 
 
  Tabs.SkyChanger:AddButton({
    Title = "Black Hole",
    Callback = function()
        getgenv().Kitten = 5
        local texture = "http://www.roblox.com/asset/?id=17108753749"
  local sky = Instance.new("Sky")
 
  sky.Parent = game.Lighting
 
  sky.CelestialBodiesShown = false
  sky.SkyboxBk = texture
  sky.SkyboxDn = texture
  sky.SkyboxFt = texture
  sky.SkyboxLf = texture
  sky.SkyboxRt = texture
  sky.SkyboxUp = texture
    end
  })
 
 
  Tabs.SkyChanger:AddButton({
    Title = "Neptune",
    Callback = function()
        getgenv().Kitten = 5
        local texture = "http://www.roblox.com/asset/?id=17108745046"
  local sky = Instance.new("Sky")
 
  sky.Parent = game.Lighting
 
  sky.CelestialBodiesShown = false
  sky.SkyboxBk = texture
  sky.SkyboxDn = texture
  sky.SkyboxFt = texture
  sky.SkyboxLf = texture
  sky.SkyboxRt = texture
  sky.SkyboxUp = texture
    end
  })
 
 
 
 
  Tabs.SkyChanger:AddButton({
    Title = "Lofy Sky",
    Callback = function()
        getgenv().Kitten = 5
  local texture = "http://www.roblox.com/asset/?id=17108732394"
  local sky = Instance.new("Sky")
 
  sky.Parent = game.Lighting
 
  sky.CelestialBodiesShown = false
  sky.SkyboxBk = texture
  sky.SkyboxDn = texture
  sky.SkyboxFt = texture
  sky.SkyboxLf = texture
  sky.SkyboxRt = texture
  sky.SkyboxUp = texture
    end
  })
 
 
  Tabs.SkyChanger:AddButton({
    Title = "Aurora Borealis",
    Callback = function()
        getgenv().Kitten = 5
  local texture = "http://www.roblox.com/asset/?id=17108721907"
  local sky = Instance.new("Sky")
 
  sky.Parent = game.Lighting
 
  sky.CelestialBodiesShown = false
  sky.SkyboxBk = texture
  sky.SkyboxDn = texture
  sky.SkyboxFt = texture
  sky.SkyboxLf = texture
  sky.SkyboxRt = texture
  sky.SkyboxUp = texture
    end
  })
 
 
 
  
  Tabs.SkyChanger:AddButton({
    Title = "Sakura Pink Sky",
    Callback = function()
        local skybox = Instance.new("Sky")
        function sakurapinksky()
        skybox.Parent = game.Lighting
        skybox.SkyboxBk = "http://www.roblox.com/asset/?id=271042516"
        skybox.SkyboxDn = "http://www.roblox.com/asset/?id=271077243"
        skybox.SkyboxFt = "http://www.roblox.com/asset/?id=271042556"
        skybox.SkyboxLf = "http://www.roblox.com/asset/?id=271042310"
        skybox.SkyboxRt = "http://www.roblox.com/asset/?id=271042467"
        skybox.SkyboxUp = "http://www.roblox.com/asset/?id=271077958"
        skybox.StarCount = 5000
        end
 
        sakurapinksky()
    end
  })
 
 
 
 
  Tabs.SkyChanger:AddButton({
    Title = "Spooky Sky",
    Callback = function()
              getgenv().Kitten = 10
  imageOne = "http://www.roblox.com/asset/?id=169585459"
  imageTwo = "http://www.roblox.com/asset/?id=169585475"
  imageThree = "http://www.roblox.com/asset/?id=169585485"
  imageFour = "http://www.roblox.com/asset/?id=169585502"
  imageFive = "http://www.roblox.com/asset/?id=169585515"
  imageSix = "http://www.roblox.com/asset/?id=169585502"
  imageSeven = "http://www.roblox.com/asset/?id=169585485"
  imageEight = "http://www.roblox.com/asset/?id=169585475"
 
  Spooky = Instance.new("Sound", workspace)
  Spooky.Name = "Spooky"
  Spooky.SoundId = "rbxassetid://200519201"
  Spooky.Volume = 0
  Spooky.Looped = true
  Spooky:Play()
 
  Sky = Instance.new("Sky", game.Lighting)
  Sky.SkyboxBk = imageOne
  Sky.SkyboxDn = imageOne
  Sky.SkyboxFt = imageOne
  Sky.SkyboxLf = imageOne
  Sky.SkyboxRt = imageOne
  Sky.SkyboxUp = imageOne
 
 
  while true do
    Sky.SkyboxBk = imageOne
    Sky.SkyboxDn = imageOne
    Sky.SkyboxFt = imageOne
    Sky.SkyboxLf = imageOne
    Sky.SkyboxRt = imageOne
    Sky.SkyboxUp = imageOne
    wait(0.15)
    Sky.SkyboxBk = imageTwo
    Sky.SkyboxDn = imageTwo
    Sky.SkyboxFt = imageTwo
    Sky.SkyboxLf = imageTwo
    Sky.SkyboxRt = imageTwo
    Sky.SkyboxUp = imageTwo
    wait(0.15)
    Sky.SkyboxBk = imageThree
    Sky.SkyboxDn = imageThree
    Sky.SkyboxFt = imageThree
    Sky.SkyboxLf = imageThree
    Sky.SkyboxRt = imageThree
    Sky.SkyboxUp = imageThree
    wait(0.15)
    Sky.SkyboxBk = imageFour
    Sky.SkyboxDn = imageFour
    Sky.SkyboxFt = imageFour
    Sky.SkyboxLf = imageFour
    Sky.SkyboxRt = imageFour
    Sky.SkyboxUp = imageFour
    wait(0.15)
    Sky.SkyboxBk = imageFive
    Sky.SkyboxDn = imageFive
    Sky.SkyboxFt = imageFive
    Sky.SkyboxLf = imageFive
    Sky.SkyboxRt = imageFive
    Sky.SkyboxUp = imageFive
    wait(0.15)
    Sky.SkyboxBk = imageSix
    Sky.SkyboxDn = imageSix
    Sky.SkyboxFt = imageSix
    Sky.SkyboxLf = imageSix
    Sky.SkyboxRt = imageSix
    Sky.SkyboxUp = imageSix
    wait(0.15)
    Sky.SkyboxBk = imageSeven
    Sky.SkyboxDn = imageSeven
    Sky.SkyboxFt = imageSeven
    Sky.SkyboxLf = imageSeven
    Sky.SkyboxRt = imageSeven
    Sky.SkyboxUp = imageSeven
    wait(0.15)
    Sky.SkyboxBk = imageEight
    Sky.SkyboxDn = imageEight
    Sky.SkyboxFt = imageEight
    Sky.SkyboxLf = imageEight
    Sky.SkyboxRt = imageEight
    Sky.SkyboxUp = imageEight
    wait(0.15)
 
  end
  local rekt = Instance.new('ColorCorrectionEffect', game.Lighting)
  rekt.TintColor = Color3.new(125, 1, 0)
  rekt.Brightness = 0.2
  rekt.Contrast = 1
  rekt.Saturation = 1
  local topkek = Instance.new('BlurEffect', game.Lighting)
  topkek.Size = 10
  local bloom = Instance.new('BloomEffect', game.Lighting)
  bloom.Intensity = 0.4
  bloom.Size = 16
  bloom.Threshold = 1
 
           game.Lighting.TimeOfDay=0;
            game.Lighting.Brightness=0;
            game.Lighting.ShadowColor=Color3.new(0,0,0);
            game.Lighting.Ambient=Color3.new(1,0,0);
            game.Lighting.FogEnd=100;
            game.Lighting.FogColor=Color3.new(1,0,0);
      end    
  })
