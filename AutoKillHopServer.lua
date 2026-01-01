local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local Debris = game:GetService("Debris")

local Player = Players.LocalPlayer
local PlaceId = 3623096087

local function HopServer()
    local Success, Servers = pcall(function()
        return HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/ "..PlaceId.."/servers/Public?sortOrder=Asc&limit=100")).data
    end)

    if Success then
        for _, v in pairs(Servers) do
            if v.playing < v.maxPlayers and v.id ~= game.JobId then
                TeleportService:TeleportToPlaceInstance(PlaceId, v.id)
                return
            end
        end
    end
    TeleportService:Teleport(PlaceId)
end

local function OnCharacterAdded(Char)
    local Humanoid = Char:WaitForChild("Humanoid")
    local Root = Char:WaitForChild("HumanoidRootPart")

    Humanoid.WalkSpeed = math.huge
    Humanoid.JumpPower = math.huge

    spawn(function()
        while Char.Parent do
            for _, plr in pairs(Players:GetPlayers()) do
                if plr ~= Player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and plr.Character:FindFirstChild("Humanoid").Health > 0 then
                    local target = plr.Character.HumanoidRootPart

                    Root.CFrame = target.CFrame * CFrame.new(0, 10, 0)

                    -- Hypothetical game-specific functions with error handling
                    local success, err = pcall(function()
                        if game:GetService("ReplicatedStorage"):FindFirstChild("EquipFastPunch") then
                            game:GetService("ReplicatedStorage").EquipFastPunch:FireServer()
                        end

                        if game:GetService("ReplicatedStorage"):FindFirstChild("AttackPlayer") then
                            game:GetService("ReplicatedStorage").AttackPlayer:FireServer(plr.Character)
                        end
                    end)

                    if not success then
                        warn("Error in attacking player: ", err)
                    end

                    task.wait(0.02)
                end
            end
            task.wait(0.2)
        end
    end)
end

if Player.Character then OnCharacterAdded(Player.Character) end
Player.CharacterAdded:Connect(OnCharacterAdded)

spawn(function()
    while task.wait(40) do
        HopServer()
    end
end)

spawn(function()
    while task.wait(300) do
        if Player.Character then
            Player.Character:FindFirstChildOfClass("Humanoid").Jump = true
        end
    end
end)

print("Kyy Farm Kill LOADED - Killing everything, hopping every 40s")
