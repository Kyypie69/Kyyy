--Deobsfucated by Sen---]

local Library = loadstring(game:HttpGetAsync("https://github.com/ActualMasterOogway/Fluent-Renewed/releases/latest/download/Fluent.luau"))()
local SaveManager = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/ActualMasterOogway/Fluent-Renewed/master/Addons/SaveManager.luau"))()
local InterfaceManager = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/ActualMasterOogway/Fluent-Renewed/master/Addons/InterfaceManager.luau"))()

local Window = Library:AddWindow("Doca V1 | Paid Version", {
    main_color = Color3.fromRGB(255, 0, 0),
    min_size = Vector2.new(500, 600),
    can_resize = true
})

local MainTab = Window:AddTab("Main")
local LocalPlayersFolder = MainTab:AddFolder("Local Players")
LocalPlayersFolder:AddSwitch("Auto Eat Protein Egg Every 30 Minutes", function(state)
    getgenv().autoEatProteinEggActive = state
    task.spawn(function()
        while getgenv().autoEatProteinEggActive and LocalPlayer.Character do
            local egg = LocalPlayer.Backpack:FindFirstChild("Protein Egg") or LocalPlayer.Character:FindFirstChild("Protein Egg")
            if egg then
                egg.Parent = LocalPlayer.Character
                ReplicatedStorage.muscleEvent:FireServer("rep")
            end
            task.wait(1800)
        end
    end)
end)
LocalPlayersFolder:AddSwitch("Auto Eat Protein Egg Every 1 hour", function(state)
    getgenv().autoEatProteinEggHourly = state
    task.spawn(function()
        while getgenv().autoEatProteinEggHourly and LocalPlayer.Character do
            local egg = LocalPlayer.Backpack:FindFirstChild("Protein Egg") or LocalPlayer.Character:FindFirstChild("Protein Egg")
            if egg then
                egg.Parent = LocalPlayer.Character
                ReplicatedStorage.muscleEvent:FireServer("rep")
            end
            task.wait(3600)
        end
    end)
end)
-- Rest of the script remains the same
