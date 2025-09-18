--[[
    Made by MTP_hello
    https://github.com/MTP_hello
]] 

local readfile = pcall(function()
    return readfile
end) and readfile or nil

local function fetchJSON(path)
    local fileContent
    if readfile then
        fileContent = readfile(path)
    else
        local file = io.open(path, "r")
        if not file then
            return nil, "Could not open file: " .. path
        end
        fileContent = file:read("*a")
        file:close()
    end
    local ok, result = pcall(function()
        return game:GetService("HttpService"):JSONDecode(fileContent)
    end)
    if not ok then
        return nil, "Failed to parse JSON from: " .. path .. "\nError: " .. tostring(result)
    end
    return result
end

local function fetchJSONRaw(url)
    local ok, content = pcall(function()
        return game:HttpGet(url)
    end)
    if not ok then
        return nil, "Could not fetch: " .. url
    end
    local success, result = pcall(function()
        return game:GetService("HttpService"):JSONDecode(content)
    end)
    if not success then
        return nil, "Failed to parse JSON from: " .. url .. "\nError: " .. tostring(result)
    end
    return result
end

local function fetchModuleRaw(url)
    local ok, src = pcall(function()
        return game:HttpGet(url)
    end)
    if not ok then
        warn("Failed to fetch module: " .. url)
        return nil
    end
    local chunk, err = loadstring(src)
    if not chunk then
        warn("Failed to load module: " .. url .. "\n" .. tostring(err))
        return nil
    end
    return chunk()
end

local Config = {
    WindowTitle = "Muscle Legends V1 Loader",
    SubTitle = "by @iamvyxon",
    Theme = "Dark",
    TabWidth = 160,
    WindowSize = {580, 460},
    Acrylic = true,
    Features = {
        AutoEgg = true,
        AutoKillSpecificPlayer = true,
        AutoItems = true,
        AutoKillerEveryone = true,
        AutoPunch = true,
        AutoKing = true,
        AutoRebirth = true,
        AutoRep = true,
        AutoRocks = true,
        AutoShake = true,
        DeletePackPets = true,
        GetClientID = true,
        GodMode = true,
        HookKick = true,
        InteractSeat = true,
        JoinBrawl = true,
        LockClientPosition = true,
        MaxUltimates = true,
        NoPunchAnimation = true,
        PackRebirth = true,
        PetsSpin = true,
        RandomNamer = true,
        RemoveUIs = true,
        ServerHop = true,
        SetSize = true,
        SetSpeed = true,
        SpectatePlayer = true,
        SpoofItems = true,
        SpoofLeaderboardStats = true,
        SpoofRarity = true,
        SpoofSpins = true,
        StatsSpoof = true,
        StatsViewer = true,
        SwitchPets = true,
        TeleportToGyms = true,
        TeleportToPlayer = true
    }
}

local RAW_BASE = "https://raw.githubusercontent.com/iamvyxon/muscle-legends-loader/main/"
local configURL = RAW_BASE .. "config/config.json"
local config, err = fetchJSONRaw(configURL)
if not config then
    warn("Config load failed: " .. tostring(err) .. "\nUsing fallback config table.")
    config = Config
end

local Fluent
local ok, result = pcall(function()
    return loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
end)
if ok then
    Fluent = result
else
    warn("Failed to load Fluent UI library: " .. tostring(result))
    return
end

local modules = {
    AutoEgg = {
        path = "src/funcAutoEgg.luau",
        tab = "Main",
        title = "Auto Egg"
    },
    AutoItems = {
        path = "src/funcAutoItems.luau",
        tab = "Main",
        title = "Auto Use Items"
    },
    AutoPunch = {
        path = "src/funcAutoPunch.luau",
        tab = "Main",
        title = "Auto Punch"
    },
    AutoRocks = {
        path = "src/funcAutoRocks.luau",
        tab = "Main",
        title = "Auto Rocks"
    },
    AutoShake = {
        path = "src/funcAutoShake.luau",
        tab = "Main",
        title = "Auto Shake"
    },
    AutoRebirth = {
        path = "src/funcAutoRebirth.luau",
        tab = "Main",
        title = "Auto Rebirth"
    },
    AutoRep = {
        path = "src/funcAutoRep.luau",
        tab = "Main",
        title = "Auto Rep"
    },
    AutoKing = {
        path = "src/funcAutoKing.luau",
        tab = "Main",
        title = "Auto King"
    },
    AutoKillSpecificPlayer = {
        path = "src/funcAutoKillSpecificPlayer.luau",
        tab = "Player",
        title = "Auto Kill Player"
    },
    AutoKillerEveryone = {
        path = "src/funcAutoKillerEveryone.luau",
        tab = "Player",
        title = "Auto Kill Everyone"
    },
    SpectatePlayer = {
        path = "src/funcSpectatePlayer.luau",
        tab = "Player",
        title = "Spectate Player"
    },
    TeleportToPlayer = {
        path = "src/funcTeleportToPlayer.luau",
        tab = "Player",
        title = "Teleport To Player"
    },
    DeletePackPets = {
        path = "src/funcDeletePackPets.luau",
        tab = "Pets",
        title = "Delete Pack Pets"
    },
    PetsSpin = {
        path = "src/funcPetsSpin.luau",
        tab = "Pets",
        title = "Pets Spin"
    },
    SwitchPets = {
        path = "src/funcSwitchPets.luau",
        tab = "Pets",
        title = "Switch Pets"
    },
    StatsViewer = {
        path = "src/funcStatsViewer.luau",
        tab = "Stats",
        title = "Stats Viewer"
    },
    StatsSpoof = {
        path = "src/funcStatsSpoof.luau",
        tab = "Stats",
        title = "Stats Spoof"
    },
    SpoofItems = {
        path = "src/funcSpoofItems.luau",
        tab = "Stats",
        title = "Spoof Items"
    },
    SpoofLeaderboardStats = {
        path = "src/funcSpoofLeaderboardStats.luau",
        tab = "Stats",
        title = "Spoof Leaderboard Stats"
    },
    SpoofRarity = {
        path = "src/funcSpoofRarity.luau",
        tab = "Stats",
        title = "Spoof Rarity"
    },
    SpoofSpins = {
        path = "src/funcSpoofSpins.luau",
        tab = "Stats",
        title = "Spoof Spins"
    },
    GetClientID = {
        path = "src/funcGetClientID.luau",
        tab = "Utility",
        title = "Get Client ID"
    },
    GodMode = {
        path = "src/funcGodMode.luau",
        tab = "Utility",
        title = "God Mode"
    },
    HookKick = {
        path = "src/funcHookKick.luau",
        tab = "Utility",
        title = "Hook Kick"
    },
    InteractSeat = {
        path = "src/funcInteractSeat.luau",
        tab = "Utility",
        title = "Interact Seat"
    },
    JoinBrawl = {
        path = "src/funcJoinBrawl.luau",
        tab = "Utility",
        title = "Join Brawl"
    },
    LockClientPosition = {
        path = "src/funcLockClientPosition.luau",
        tab = "Utility",
        title = "Lock Client Position"
    },
    MaxUltimates = {
        path = "src/funcMaxUltimates.luau",
        tab = "Utility",
        title = "Max Ultimates"
    },
    NoPunchAnimation = {
        path = "src/funcNoPunchAnimation.luau",
        tab = "Utility",
        title = "No Punch Animation"
    },
    PackRebirth = {
        path = "src/funcPackRebirth.luau",
        tab = "Utility",
        title = "Pack Rebirth"
    },
    RandomNamer = {
        path = "src/funcRandomNamer.luau",
        tab = "Utility",
        title = "Random Namer"
    },
    RemoveUIs = {
        path = "src/funcRemoveUIs.luau",
        tab = "Utility",
        title = "Remove UIs"
    },
    ServerHop = {
        path = "src/funcServerHop.luau",
        tab = "Utility",
        title = "Server Hop"
    },
    SetSize = {
        path = "src/funcSetSize.luau",
        tab = "Utility",
        title = "Set Size"
    },
    SetSpeed = {
        path = "src/funcSetSpeed.luau",
        tab = "Utility",
        title = "Set Speed"
    },
    TeleportToGyms = {
        path = "src/funcTeleportToGyms.luau",
        tab = "Utility",
        title = "Teleport To Gyms"
    }
}

local UIManager = {}
UIManager.__index = UIManager

function UIManager.new()
    local self = setmetatable({}, UIManager)
    self:createWindowAndTabs()
    return self
end

function UIManager:createWindowAndTabs()
    self.Window = Fluent:CreateWindow({
        Title = config.WindowTitle or "Muscle Legends V1 Loader",
        SubTitle = config.SubTitle or "",
        TabWidth = config.TabWidth or 160,
        Size = UDim2.fromOffset(unpack(config.WindowSize or {580, 460})),
        Acrylic = config.Acrylic ~= false,
        Theme = config.Theme or "Dark",
        MinimizeKey = Enum.KeyCode.LeftControl
    })
    self.Tabs = {
        Main = self.Window:AddTab({
            Title = "Main",
            Icon = ""
        }),
        Player = self.Window:AddTab({
            Title = "Player",
            Icon = "user"
        }),
        Pets = self.Window:AddTab({
            Title = "Pets",
            Icon = "paw"
        }),
        Stats = self.Window:AddTab({
            Title = "Stats",
            Icon = "bar_chart"
        }),
        Utility = self.Window:AddTab({
            Title = "Utility",
            Icon = "tool"
        }),
        Settings = self.Window:AddTab({
            Title = "Settings",
            Icon = "settings"
        })
    }
    self.Tabs.Main:AddParagraph({
        Title = "Watermark",
        Content = "Made by iamvyxon | github.com/iamvyxon | Discord: @iamvyxon | Telgram: @vyxooo"
    })
end

function UIManager:setup()
    local Tabs = self.Tabs
    Tabs.Main:AddParagraph({
        Title = "Welcome",
        Content = "Welcome to the Loader V1!\nMade by iamvyxon"
    })
    Tabs.Main:AddParagraph({
        Title = "Version",
        Content = "Script Version: 1.0.0"
    })

    self.ModuleInstances = {}

    for feature, data in pairs(modules) do
        local enabled = config.Features and config.Features[feature]
        local module = fetchModuleRaw(RAW_BASE .. data.path)
        if module and module.new then
            self.ModuleInstances[feature] = module.new(Tabs[data.tab])
        else
            Tabs[data.tab]:AddToggle("Toggle_" .. feature, {
                Title = data.title .. (not module and " (Module Missing)" or ""),
                Default = enabled,
                Disabled = not module,
                Tooltip = not module and "Module failed to load." or nil,
                Callback = function(state)
                    if not module then
                        Fluent:Notify({
                            Title = "Module Error",
                            Content = "Module for '" .. feature .. "' failed to load.",
                            Duration = 4
                        })
                        return
                    end
                    if state then
                        if module.new then
                            self.ModuleInstances[feature] = module.new(Tabs[data.tab])
                            if self.ModuleInstances[feature].Start then
                                self.ModuleInstances[feature]:Start()
                            end
                        elseif module.Start then
                            self.ModuleInstances[feature] = module
                            module:Start()
                        end
                    else
                        local instance = self.ModuleInstances[feature]
                        if instance and instance.Stop then
                            instance:Stop()
                        end
                    end
                end
            })
        end
    end
end

function UIManager:addSettings()
    local Tabs = self.Tabs
    Tabs.Settings:AddButton({
        Title = "Reload Config",
        Callback = function()
            local newConfig, err = fetchJSONRaw(configURL)
            if newConfig then
                config = newConfig
                self:setup()
                self:addSettings()
                self.Window:SelectTab(1)
                Fluent:Notify({
                    Title = "Config Reloaded",
                    Content = "Configuration reloaded successfully.",
                    Duration = 3
                })
            else
                Fluent:Notify({
                    Title = "Reload Failed",
                    Content = "Failed to reload config: " .. tostring(err),
                    Duration = 4
                })
            end
        end
    })
    Tabs.Settings:AddButton({
        Title = "Copy Discord",
        Callback = function()
            setclipboard("https://discord.gg/yourserver")
            Fluent:Notify({
                Title = "Discord",
                Content = "Discord invite copied to clipboard!",
                Duration = 3
            })
        end
    })
    Tabs.Settings:AddParagraph({
        Title = "Credits",
        Content = "Script by iamvyxon\nUI by Dawid"
    })
end

local ui = UIManager.new()
ui:setup()
ui:addSettings()
ui.Window:SelectTab(1)
Fluent:Notify({
    Title = config.WindowTitle or "Muscle Legends",
    Content = "Script loaded!\nMade by iamvyxon",
    Duration = 5
})
