local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local runService = game:GetService("RunService")
local Players = game:GetService("Players")
local SoundService = game:GetService("SoundService")
local HttpService = game:GetService("HttpService")
local MarketplaceService = game:GetService("MarketplaceService")
local username = Players.LocalPlayer.Name

if game.CoreGui:FindFirstChild("Library") then
    game.CoreGui:FindFirstChild("Library"):Destroy()
end

_G.SafeLock = false

local KyyfiiiLibrary = {}

local Library = Instance.new("ScreenGui")
Library.Name = "Library"
Library.Parent = game.CoreGui
Library.Enabled = true

local activeNotifications = {}
local notificationSpacing = 10
local notificationHeight = 90

-- // BLACK, WHITE, NAVY BLUE & DEEP PURPLE THEME PALETTE
local PALETTE = {
    Background         = Color3.fromRGB(  0,   0,   0), -- pure black
    Surface            = Color3.fromRGB( 20,  20,  40), -- navy blue
    Elevated           = Color3.fromRGB( 35,  15,  35), -- deep purple
    Accent             = Color3.fromRGB(255, 255, 255), -- white accent
    TextPrimary        = Color3.fromRGB(  0,   0,   0), -- deep black text
    TextSecondary      = Color3.fromRGB(  0,   0,   0), -- deep black text
    TextDisabled       = Color3.fromRGB( 60,  60,  60), -- dark gray
    Glow               = Color3.fromRGB(255, 255, 255), -- white glow
    TextStrokeColor    = Color3.fromRGB(255, 255, 255), -- pure white stroke for glow
    TextStrokeTransparency = 0.1, -- low transparency for strong glow effect
}

-- Helper function to add glowing UIStroke to text labels
local function addTextStroke(textLabel)
    local stroke = Instance.new("UIStroke")
    stroke.Color = PALETTE.TextStrokeColor
    stroke.Thickness = 3 -- Thicker stroke for prominent glow
    stroke.Transparency = PALETTE.TextStrokeTransparency
    stroke.LineJoinMode = Enum.LineJoinMode.Round
    stroke.Parent = textLabel
end

-- // NOTIFICATION
function KyyfiiiLibrary:createNotification(desc)
    local Notification = Instance.new("Frame")
    local bg = Instance.new("ImageLabel")
    local corner1 = Instance.new("UICorner")
    local corner2 = Instance.new("UICorner")
    local title = Instance.new("TextLabel")
    local descLbl = Instance.new("TextLabel")

    Notification.Name = "Notification"
    Notification.Parent = Library
    Notification.AnchorPoint = Vector2.new(1,1)
    Notification.BackgroundColor3 = PALETTE.Background
    Notification.BackgroundTransparency = .1
    Notification.BorderSizePixel = 0
    Notification.Position = UDim2.new(1,-10,1,10)
    Notification.Size = UDim2.new(0,235,0,82)
    Notification.ClipsDescendants = true

    bg.Name = "Background"
    bg.Parent = Notification
    bg.BackgroundTransparency = 1
    bg.Size = UDim2.new(1,0,1,0)
    bg.Image = "https://www.roblox.com/Thumbs/Asset.ashx?width=420&height=420&assetId=123093571305491"
    bg.ImageTransparency = .5
    bg.ImageColor3 = PALETTE.Accent

    corner1.Parent = bg
    corner1.CornerRadius = UDim.new(0,10)
    corner2.Parent = Notification
    corner2.CornerRadius = UDim.new(0,10)

    title.Name = "Title"
    title.Parent = Notification
    title.BackgroundTransparency = 1
    title.Size = UDim2.new(1,0,0,30)
    title.Font = Enum.Font.Jura
    title.RichText = true
    title.Text = "<b>NavyPurple  |</b>  Notification"
    title.TextColor3 = PALETTE.TextPrimary
    title.TextSize = 15
    title.TextXAlignment = Enum.TextXAlignment.Left
    addTextStroke(title) -- Add glowing white border
    Instance.new("UIPadding", title).PaddingLeft = UDim.new(0,10)

    descLbl.Name = "Description"
    descLbl.Parent = Notification
    descLbl.BackgroundTransparency = 1
    descLbl.Position = UDim2.new(0,0,.37,0)
    descLbl.Size = UDim2.new(1,0,0,40)
    descLbl.Font = Enum.Font.Jura
    descLbl.RichText = true
    descLbl.Text = desc
    descLbl.TextColor3 = PALETTE.TextPrimary
    descLbl.TextSize = 15
    descLbl.TextWrapped = true
    descLbl.TextXAlignment = Enum.TextXAlignment.Left
    descLbl.TextYAlignment = Enum.TextYAlignment.Top
    addTextStroke(descLbl) -- Add glowing white border
    local pad = Instance.new("UIPadding", descLbl)
    pad.PaddingLeft = UDim.new(0,10)
    pad.PaddingRight = UDim.new(0,10)
    pad.PaddingTop = UDim.new(0,2)

    local idx = #activeNotifications + 1
    table.insert(activeNotifications, Notification)

    local targetY = -((notificationHeight + notificationSpacing)*(idx-1)) - 10
    TweenService:Create(Notification, TweenInfo.new(.4,Enum.EasingStyle.Sine,Enum.EasingDirection.Out),
        {Position = UDim2.new(1,-10,1,targetY)}):Play()

    task.delay(4, function()
        local tOut = TweenService:Create(Notification, TweenInfo.new(.5),
            {Position = UDim2.new(1,300,1,targetY)})
        tOut:Play()
        tOut.Completed:Wait()
        Notification:Destroy()
        table.remove(activeNotifications, table.find(activeNotifications, Notification))
        for i, notif in ipairs(activeNotifications) do
            local newY = -((notificationHeight + notificationSpacing)*(i-1)) - 10
            TweenService:Create(notif, TweenInfo.new(.3), {Position = UDim2.new(1,-10,1,newY)}):Play()
        end
    end)
end

-- // WINDOW
function KyyfiiiLibrary:CreateWindow(Title, Description)
    local uiOpen = true

    local Main = Instance.new("Frame")
    local Background = Instance.new("ImageLabel")
    local cornerM = Instance.new("UICorner")
    local cornerB = Instance.new("UICorner")
    local Topbar = Instance.new("Frame")
    local TitleLbl = Instance.new("TextLabel")
    local Tabs = Instance.new("Frame")
    local TabsHolder = Instance.new("ScrollingFrame")
    local UIList = Instance.new("UIListLayout")
    local ElementsHolder = Instance.new("Frame")
    local UserBar = Instance.new("Frame")
    local UserIcon = Instance.new("ImageLabel")
    local UserText = Instance.new("TextLabel")

    Main.Name = "Main"
    Main.Parent = Library
    Main.AnchorPoint = Vector2.new(.5,.5)
    Main.BackgroundColor3 = PALETTE.Background
    Main.BackgroundTransparency = .1
    Main.BorderSizePixel = 0
    Main.Position = UDim2.new(.5,0,2,0)
    Main.Size = UDim2.new(0,530,0,300)
    Main.ClipsDescendants = true
    Main.Active = true

    Background.Name = "Background"
    Background.Parent = Main
    Background.BackgroundTransparency = 1
    Background.Size = UDim2.new(1,0,1,0)
    Background.Image = "https://www.roblox.com/Thumbs/Asset.ashx?width=420&height=420&assetId=123093571305491"
    Background.ImageTransparency = .55
    Background.ImageColor3 = PALETTE.Accent
    cornerB.Parent = Background
    cornerB.CornerRadius = UDim.new(0,10)

    cornerM.Parent = Main
    cornerM.CornerRadius = UDim.new(0,10)

    Topbar.Name = "Topbar"
    Topbar.Parent = Main
    Topbar.BackgroundTransparency = 1
    Topbar.Size = UDim2.new(0,530,0,30)
    Topbar.ZIndex = 2

    TitleLbl.Name = "Title"
    TitleLbl.Parent = Topbar
    TitleLbl.BackgroundTransparency = 1
    TitleLbl.Size = UDim2.new(0,400,0,30)
    TitleLbl.Font = Enum.Font.Jura
    TitleLbl.RichText = true
    TitleLbl.Text = "<b>"..Title.."  |</b>  "..Description
    TitleLbl.TextColor3 = PALETTE.TextPrimary
    TitleLbl.TextSize = 15
    TitleLbl.TextXAlignment = Enum.TextXAlignment.Left
    addTextStroke(TitleLbl) -- Add glowing white border
    Instance.new("UIPadding", TitleLbl).PaddingLeft = UDim.new(0,10)

    Tabs.Name = "Tabs"
    Tabs.Parent = Main
    Tabs.BackgroundTransparency = 1
    Tabs.Position = UDim2.new(0,0,.1,0)
    Tabs.Size = UDim2.new(0,170,0,220)
    Tabs.ZIndex = 2

    TabsHolder.Parent = Tabs
    TabsHolder.Active = true
    TabsHolder.BackgroundTransparency = 1
    TabsHolder.Size = UDim2.new(0,170,0,220)
    TabsHolder.AutomaticCanvasSize = Enum.AutomaticSize.Y
    TabsHolder.ScrollBarImageTransparency = 1
    TabsHolder.ScrollingDirection = Enum.ScrollingDirection.Y

    UIList.Parent = TabsHolder
    UIList.Padding = UDim.new(0,6)
    UIList.SortOrder = Enum.SortOrder.LayoutOrder

    ElementsHolder.Name = "ElementsHolder"
    ElementsHolder.Parent = Main
    ElementsHolder.BackgroundTransparency = 1
    ElementsHolder.Position = UDim2.new(.345,0,.1,0)
    ElementsHolder.Size = UDim2.new(0,340,0,260)
    ElementsHolder.ZIndex = 2
    ElementsHolder.ClipsDescendants = true

    UserBar.Name = "User"
    UserBar.Parent = Main
    UserBar.BackgroundColor3 = PALETTE.Surface
    UserBar.BackgroundTransparency = .2
    UserBar.BorderSizePixel = 0
    UserBar.Position = UDim2.new(0,8,.87,0)
    UserBar.Size = UDim2.new(0,160,0,30)
    UserBar.ZIndex = 2
    Instance.new("UICorner", UserBar).CornerRadius = UDim.new(0,6)

    UserIcon.Name = "UserIcon"
    UserIcon.Parent = UserBar
    UserIcon.AnchorPoint = Vector2.new(0,.5)
    UserIcon.BackgroundTransparency = 1
    UserIcon.Position = UDim2.new(0,8,.5,0)
    UserIcon.Size = UDim2.new(0,18,0,18)
    UserIcon.Image = "rbxassetid://73054449943371"
    UserIcon.ImageColor3 = PALETTE.TextPrimary

    UserText.Name = "UserText"
    UserText.Parent = UserBar
    UserText.BackgroundTransparency = 1
    UserText.Size = UDim2.new(0,160,0,30)
    UserText.Font = Enum.Font.Jura
    UserText.RichText = true
    UserText.Text = "<b>"..username.."</b>"
    UserText.TextColor3 = PALETTE.TextSecondary
    UserText.TextSize = 14
    UserText.TextXAlignment = Enum.TextXAlignment.Left
    UserText.ClipsDescendants = true
    UserText.TextTruncate = Enum.TextTruncate.AtEnd
    addTextStroke(UserText) -- Add glowing white border
    Instance.new("UIPadding", UserText).PaddingLeft = UDim.new(0,36)

    -- // DRAG
    local dragging, dragInput, dragStart, startPos
    local lastMouse, lastGoal
    local DRAG_SPEED = 10

    function Lerp(a,b,m) return a + (b-a)*m end
    function Update(dt)
        if not startPos then return end
        if not dragging and lastGoal then
            Main.Position = UDim2.new(startPos.X.Scale, Lerp(Main.Position.X.Offset, lastGoal.X.Offset, dt*DRAG_SPEED),
                                      startPos.Y.Scale, Lerp(Main.Position.Y.Offset, lastGoal.Y.Offset, dt*DRAG_SPEED))
            return
        end
        local delta = lastMouse - UserInputService:GetMouseLocation()
        local xGoal = startPos.X.Offset - delta.X
        local yGoal = startPos.Y.Offset - delta.Y
        lastGoal = UDim2.new(startPos.X.Scale, xGoal, startPos.Y.Scale, yGoal)
        Main.Position = UDim2.new(startPos.X.Scale, Lerp(Main.Position.X.Offset, xGoal, dt*DRAG_SPEED),
                                  startPos.Y.Scale, Lerp(Main.Position.Y.Offset, yGoal, dt*DRAG_SPEED))
    end
    Main.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            dragging = true; dragStart = inp.Position; startPos = Main.Position; lastMouse = UserInputService:GetMouseLocation()
            inp.Changed:Connect(function() if inp.UserInputState == Enum.UserInputState.End then dragging = false end end)
        end
    end)
    Main.InputChanged:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch then
            dragInput = inp
        end
    end)
    runService.Heartbeat:Connect(Update)

    -- // TOGGLE VISIBILITY
    UserInputService.InputBegan:Connect(function(inp,gP)
        if not gP and inp.KeyCode == Enum.KeyCode.LeftAlt then Library.Enabled = not Library.Enabled end
    end)

    -- // UI-TOGGLER BUTTON
    local toggleHolder = Instance.new("Frame")
    local toggleBtn = Instance.new("ImageButton")
    local toggleLogo = Instance.new("ImageLabel")
    toggleHolder.Name = "UITogglerHolder"
    toggleHolder.Parent = Library
    toggleHolder.AnchorPoint = Vector2.new(.5,.5)
    toggleHolder.BackgroundColor3 = PALETTE.Background
    toggleHolder.BackgroundTransparency = .1
    toggleHolder.BorderSizePixel = 0
    toggleHolder.Position = UDim2.new(.5,0,-.5,0)
    toggleHolder.Size = UDim2.new(0,36,0,36)
    toggleHolder.ClipsDescendants = true
    Instance.new("UICorner", toggleHolder).CornerRadius = UDim.new(0,8)

    toggleBtn.Name = "UIToggler"
    toggleBtn.Parent = toggleHolder
    toggleBtn.Active = true
    toggleBtn.BackgroundTransparency = 1
    toggleBtn.Size = UDim2.new(0,36,0,36)
    toggleBtn.ZIndex = 2
    toggleBtn.Image = "rbxassetid://131129943627373"
    toggleBtn.ImageTransparency = .45
    toggleBtn.ImageColor3 = PALETTE.Accent

    toggleLogo.Name = "UITogglerLogo"
    toggleLogo.Parent = toggleHolder
    toggleLogo.AnchorPoint = Vector2.new(.5,.5)
    toggleLogo.BackgroundTransparency = 1
    toggleLogo.Position = UDim2.new(.5,0,.5,0)
    toggleLogo.Size = UDim2.new(0,30,0,30)
    toggleLogo.ZIndex = 2
    toggleLogo.Image = "https://www.roblox.com/Thumbs/Asset.ashx?width=420&height=420&assetId=123093571305491"
    toggleLogo.ImageColor3 = PALETTE.TextPrimary

    toggleBtn.MouseButton1Click:Connect(function()
        if uiOpen then
            uiOpen = false
            TweenService:Create(Main, TweenInfo.new(.8,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                {Position = UDim2.new(.5,0,2,0)}):Play()
            dragging = false; lastGoal = nil; startPos = nil
        else
            uiOpen = true
            TweenService:Create(Main, TweenInfo.new(.5,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                {Position = UDim2.new(.5,0,.5,0)}):Play()
            dragging = false; lastGoal = nil; startPos = nil
        end
    end)

    -- // OPEN ANIMS
    TweenService:Create(toggleHolder, TweenInfo.new(.5,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
        {Position = UDim2.new(.5,0,.015,0)}):Play()
    TweenService:Create(Main, TweenInfo.new(.5,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
        {Position = UDim2.new(.5,0,.5,0)}):Play()

    -- // TABS
    local Tabs = {}
    local allTitles, allIcons, allTabs = {}, {}, {}
    local currentTab, currentIcon, currentTabIndex = nil, nil, nil
    local first = true

    function Tabs:CreateTab(Title, Icon)
        local TabHolder = Instance.new("Frame")
        local corner = Instance.new("UICorner")
        local TabBtn = Instance.new("TextButton")
        local TabIco = Instance.new("ImageLabel")
        local Elements = Instance.new("Frame")
        local Items = Instance.new("ScrollingFrame")
        local UIList = Instance.new("UIListLayout")

        TabHolder.Name = "TabHolder"
        TabHolder.Parent = TabsHolder
        TabHolder.BackgroundColor3 = PALETTE.Surface
        TabHolder.BackgroundTransparency = .8
        TabHolder.BorderSizePixel = 0
        TabHolder.Size = UDim2.new(0,160,0,30)
        corner.CornerRadius = UDim.new(0,6)
        corner.Parent = TabHolder

        TabBtn.Name = "TabTitle"
        TabBtn.Parent = TabHolder
        TabBtn.BackgroundTransparency = 1
        TabBtn.Size = UDim2.new(0,160,0,30)
        TabBtn.Font = Enum.Font.Jura
        TabBtn.RichText = true
        TabBtn.Text = "<b>"..Title.."</b>"
        TabBtn.TextColor3 = PALETTE.TextSecondary
        TabBtn.TextSize = 14
        TabBtn.TextXAlignment = Enum.TextXAlignment.Left
        addTextStroke(TabBtn) -- Add glowing white border
        Instance.new("UIPadding", TabBtn).PaddingLeft = UDim.new(0,36)

        TabIco.Name = "TabIcon"
        TabIco.Parent = TabHolder
        TabIco.AnchorPoint = Vector2.new(0,.5)
        TabIco.BackgroundTransparency = 1
        TabIco.Position = UDim2.new(0,8,.5,0)
        TabIco.Size = UDim2.new(0,18,0,18)
        TabIco.Image = "rbxassetid://"..Icon
        TabIco.ImageColor3 = PALETTE.TextSecondary

        Elements.Name = "Elements"
        Elements.Parent = ElementsHolder
        Elements.BackgroundTransparency = 1
        Elements.Size = UDim2.new(0,340,0,260)

        Items.Name = "Items"
        Items.Parent = Elements
        Items.Active = true
        Items.BackgroundTransparency = 1
        Items.Size = UDim2.new(0,340,0,260)
        Items.ClipsDescendants = true
        Items.AutomaticCanvasSize = Enum.AutomaticSize.Y
        Items.ScrollBarImageTransparency = 1
        Items.ScrollingDirection = Enum.ScrollingDirection.Y

        UIList.Parent = Items
        UIList.Padding = UDim.new(0,6)
        UIList.SortOrder = Enum.SortOrder.LayoutOrder
        Instance.new("UIPadding", Items).PaddingTop = UDim.new(0,4)

        table.insert(allTitles, TabBtn)
        table.insert(allIcons, TabIco)
        table.insert(allTabs, Elements)

        if first then
            first = false
            Elements.Visible = true; Elements.Position = UDim2.new(0,0,0,0)
            currentTab = TabBtn; currentIcon = TabIco; currentTabIndex = 1
            TabBtn.TextColor3 = PALETTE.TextPrimary
            TabIco.ImageColor3 = PALETTE.TextPrimary
        else
            Elements.Visible = false
            TabBtn.TextColor3 = PALETTE.TextDisabled
            TabIco.ImageColor3 = PALETTE.TextDisabled
        end

        TabBtn.MouseButton1Click:Connect(function()
            if currentTab == TabBtn then return end
            local newIdx = table.find(allTitles, TabBtn)
            if not newIdx then return end
            local dir = (newIdx > currentTabIndex) and 1 or -1
            local curFrm = allTabs[currentTabIndex]
            local newFrm = allTabs[newIdx]

            if currentTab and currentIcon then
                TweenService:Create(currentTab, TweenInfo.new(.2), {TextColor3 = PALETTE.TextDisabled}):Play()
                TweenService:Create(currentIcon, TweenInfo.new(.2), {ImageColor3 = PALETTE.TextDisabled}):Play()
            end
            TweenService:Create(TabBtn, TweenInfo.new(.2), {TextColor3 = PALETTE.TextPrimary}):Play()
            TweenService:Create(TabIco, TweenInfo.new(.2), {ImageColor3 = PALETTE.TextPrimary}):Play()

            newFrm.Position = UDim2.new(dir,0,0,0); newFrm.Visible = true
            local tOut = TweenService:Create(curFrm, TweenInfo.new(.25), {Position = UDim2.new(-dir,0,0,0)})
            local tIn = TweenService:Create(newFrm, TweenInfo.new(.25), {Position = UDim2.new(0,0,0,0)})
            tOut:Play(); tIn:Play()
            tOut.Completed:Connect(function() curFrm.Visible = false end)

            currentTab = TabBtn; currentIcon = TabIco; currentTabIndex = newIdx
        end)

        -- // ELEMENTS
        local Elements = {}

        function Elements:CreateSection(Title)
            local Section = Instance.new("Frame")
            local SectionTitle = Instance.new("TextLabel")
            Section.Name = "Section"
            Section.Parent = Items
            Section.BackgroundTransparency = 1
            Section.BorderSizePixel = 0
            Section.Size = UDim2.new(0,336,0,28)
            SectionTitle.Parent = Section
            SectionTitle.BackgroundTransparency = 1
            SectionTitle.Size = UDim2.new(0,336,0,28)
            SectionTitle.Font = Enum.Font.Jura
            SectionTitle.RichText = true
            SectionTitle.Text = "<b>"..Title.."</b>"
            SectionTitle.TextColor3 = PALETTE.TextSecondary
            SectionTitle.TextSize = 14
            SectionTitle.TextXAlignment = Enum.TextXAlignment.Left
            addTextStroke(SectionTitle) -- Add glowing white border
            Instance.new("UIPadding", SectionTitle).PaddingLeft = UDim.new(0,2)
            
            -- Return object with UpdateText method
            return {
                UpdateText = function(self, newText)
                    SectionTitle.Text = "<b>"..newText.."</b>"
                end
            }
        end

        function Elements:CreateLabel(Title)
            local Label = Instance.new("Frame")
            local corner = Instance.new("UICorner")
            local LabelTitle = Instance.new("TextLabel")
            Label.Name = "Label"
            Label.Parent = Items
            Label.BackgroundColor3 = PALETTE.Surface
            Label.BackgroundTransparency = .8
            Label.BorderSizePixel = 0
            Label.Size = UDim2.new(0,336,0,28)
            corner.CornerRadius = UDim.new(0,6)
            corner.Parent = Label
            LabelTitle.Parent = Label
            LabelTitle.BackgroundTransparency = 1
            LabelTitle.Size = UDim2.new(0,336,0,28)
            LabelTitle.Font = Enum.Font.Jura
            LabelTitle.RichText = true
            LabelTitle.Text = "<b>"..Title.."</b>"
            LabelTitle.TextColor3 = PALETTE.TextPrimary
            LabelTitle.TextSize = 14
            addTextStroke(LabelTitle) -- Add glowing white border
            
            -- Return object with UpdateText method
            return {
                UpdateText = function(self, newText)
                    LabelTitle.Text = "<b>"..newText.."</b>"
                end
            }
        end

        function Elements:CreateButton(Title, Callback)
            local Button = Instance.new("Frame")
            local corner = Instance.new("UICorner")
            local Btn = Instance.new("TextButton")
            Button.Name = "Button"
            Button.Parent = Items
            Button.BackgroundColor3 = PALETTE.Surface
            Button.BackgroundTransparency = .8
            Button.BorderSizePixel = 0
            Button.Size = UDim2.new(0,336,0,34)
            corner.CornerRadius = UDim.new(0,6)
            corner.Parent = Button
            Btn.Parent = Button
            Btn.BackgroundTransparency = 1
            Btn.Size = UDim2.new(0,336,0,34)
            Btn.Font = Enum.Font.Jura
            Btn.RichText = true
            Btn.Text = "<b>"..Title.."</b>"
            Btn.TextColor3 = PALETTE.TextSecondary
            Btn.TextSize = 14
            Btn.TextXAlignment = Enum.TextXAlignment.Left
            addTextStroke(Btn) -- Add glowing white border
            Instance.new("UIPadding", Btn).PaddingLeft = UDim.new(0,16)

            Btn.MouseButton1Click:Connect(function()
                if _G.SafeLock then
                    KyyfiiiLibrary:createNotification("Safe Lock on! Disable to use features.")
                    return
                end
                local t1 = TweenService:Create(Btn, TweenInfo.new(.1), {TextColor3 = PALETTE.TextPrimary})
                t1:Play()
                t1.Completed:Connect(function()
                    TweenService:Create(Btn, TweenInfo.new(.2), {TextColor3 = PALETTE.TextSecondary}):Play()
                end)
                Callback()
            end)
            
            -- Return object with UpdateText method
            return {
                UpdateText = function(self, newText)
                    Btn.Text = "<b>"..newText.."</b>"
                end
            }
        end

        function Elements:CreateToggle(Title, Callback)
            Callback = Callback or function() end
            local toggled = false
            local debounce = false

            local Toggle = Instance.new("Frame")
            local corner = Instance.new("UICorner")
            local ToggleTitle = Instance.new("TextLabel")
            local TogglerHolder = Instance.new("Frame")
            local Toggler = Instance.new("TextButton")

            Toggle.Name = "Toggle"
            Toggle.Parent = Items
            Toggle.BackgroundColor3 = PALETTE.Surface
            Toggle.BackgroundTransparency = .8
            Toggle.BorderSizePixel = 0
            Toggle.Size = UDim2.new(0,336,0,34)
            corner.CornerRadius = UDim.new(0,6)
            corner.Parent = Toggle

            ToggleTitle.Name = "ToggleTitle"
            ToggleTitle.Parent = Toggle
            ToggleTitle.BackgroundTransparency = 1
            ToggleTitle.Size = UDim2.new(0,240,0,34)
            ToggleTitle.Font = Enum.Font.Jura
            ToggleTitle.RichText = true
            ToggleTitle.Text = "<b>"..Title.."</b>"
            ToggleTitle.TextColor3 = PALETTE.TextSecondary
            ToggleTitle.TextSize = 14
            ToggleTitle.TextXAlignment = Enum.TextXAlignment.Left
            addTextStroke(ToggleTitle) -- Add glowing white border
            Instance.new("UIPadding", ToggleTitle).PaddingLeft = UDim.new(0,16)

            TogglerHolder.Name = "TogglerHolder"
            TogglerHolder.Parent = Toggle
            TogglerHolder.AnchorPoint = Vector2.new(0,.5)
            TogglerHolder.BackgroundColor3 = PALETTE.Background
            TogglerHolder.BackgroundTransparency = .25
            TogglerHolder.BorderSizePixel = 0
            TogglerHolder.Position = UDim2.new(0,300,.5,0)
            TogglerHolder.Size = UDim2.new(0,22,0,22)
            Instance.new("UICorner", TogglerHolder).CornerRadius = UDim.new(0,6)

            Toggler.Name = "Toggler"
            Toggler.Parent = TogglerHolder
            Toggler.Active = true
            Toggler.BackgroundTransparency = 1
            Toggler.Size = UDim2.new(0,22,0,22)
            Toggler.Font = Enum.Font.SourceSans
            Toggler.Text = ""
            Toggler.TextSize = 14

            Toggler.MouseButton1Click:Connect(function()
                if _G.SafeLock then
                    if ToggleTitle.Text == "<b>Safe Lock</b>" then
                        _G.SafeLock = false
                        TweenService:Create(TogglerHolder, tweenInfo, {BackgroundColor3 = PALETTE.Background}):Play()
                        TweenService:Create(ToggleTitle, tweenInfo, {TextColor3 = PALETTE.TextSecondary}):Play()
                        KyyfiiiLibrary:createNotification("Safe Lock disabled! All inputs unlocked.")
                        return
                    else
                        KyyfiiiLibrary:createNotification("Safe Lock on! Disable to use features.")
                        return
                    end
                else
                    if ToggleTitle.Text == "<b>Safe Lock</b>" then
                        _G.SafeLock = true
                        TweenService:Create(TogglerHolder, tweenInfo, {BackgroundColor3 = PALETTE.Accent}):Play()
                        TweenService:Create(ToggleTitle, tweenInfo, {TextColor3 = PALETTE.TextPrimary}):Play()
                        KyyfiiiLibrary:createNotification("Safe Lock enabled! All inputs locked.")
                        return
                    end
                end
                if debounce then return end
                debounce = true
                local ti = TweenInfo.new(.2)
                if not toggled then
                    TweenService:Create(TogglerHolder, ti, {BackgroundColor3 = PALETTE.Accent}):Play()
                    TweenService:Create(ToggleTitle, ti, {TextColor3 = PALETTE.TextPrimary}):Play()
                    toggled = true
                else
                    TweenService:Create(TogglerHolder, ti, {BackgroundColor3 = PALETTE.Background}):Play()
                    TweenService:Create(ToggleTitle, ti, {TextColor3 = PALETTE.TextSecondary}):Play()
                    toggled = false
                end
                pcall(Callback, toggled)
                debounce = false
            end)
            
            -- Return object with UpdateText method
            return {
                UpdateText = function(self, newText)
                    ToggleTitle.Text = "<b>"..newText.."</b>"
                end
            }
        end

        function Elements:CreateBox(Title, Callback)
            local Box = Instance.new("Frame")
            local corner = Instance.new("UICorner")
            local BoxTitle = Instance.new("TextLabel")
            local TextBoxHolder = Instance.new("Frame")
            local TextBox = Instance.new("TextBox")

            Box.Name = "Box"
            Box.Parent = Items
            Box.BackgroundColor3 = PALETTE.Surface
            Box.BackgroundTransparency = .8
            Box.BorderSizePixel = 0
            Box.Size = UDim2.new(0,336,0,34)
            corner.CornerRadius = UDim.new(0,6)
            corner.Parent = Box

            BoxTitle.Name = "BoxTitle"
            BoxTitle.Parent = Box
            BoxTitle.BackgroundTransparency = 1
            BoxTitle.Size = UDim2.new(0,240,0,34)
            BoxTitle.Font = Enum.Font.Jura
            BoxTitle.RichText = true
            BoxTitle.Text = "<b>"..Title.."</b>"
            BoxTitle.TextColor3 = PALETTE.TextSecondary
            BoxTitle.TextSize = 14
            BoxTitle.TextXAlignment = Enum.TextXAlignment.Left
            addTextStroke(BoxTitle) -- Add glowing white border
            Instance.new("UIPadding", BoxTitle).PaddingLeft = UDim.new(0,16)

            TextBoxHolder.Name = "TextBoxHolder"
            TextBoxHolder.Parent = Box
            TextBoxHolder.AnchorPoint = Vector2.new(0,.5)
            TextBoxHolder.BackgroundColor3 = PALETTE.Background
            TextBoxHolder.BackgroundTransparency = .25
            TextBoxHolder.BorderSizePixel = 0
            TextBoxHolder.Position = UDim2.new(-0.178571433,300,.5,0)
            TextBoxHolder.Size = UDim2.new(0,82,0,22)
            Instance.new("UICorner", TextBoxHolder).CornerRadius = UDim.new(0,6)

            TextBox.Parent = TextBoxHolder
            TextBox.Active = true
            TextBox.BackgroundTransparency = 1
            TextBox.Size = UDim2.new(0,82,0,22)
            TextBox.ClipsDescendants = true
            TextBox.Font = Enum.Font.Jura
            TextBox.PlaceholderColor3 = PALETTE.TextDisabled
            TextBox.PlaceholderText = "..."
            TextBox.Text = ""
            TextBox.TextEditable = true
            TextBox.ClearTextOnFocus = false
            TextBox.TextColor3 = PALETTE.TextPrimary
            TextBox.TextSize = 14
            TextBox.TextTruncate = Enum.TextTruncate.AtEnd
            TextBox.TextXAlignment = Enum.TextXAlignment.Right
            addTextStroke(TextBox) -- Add glowing white border
            local pad = Instance.new("UIPadding", TextBox)
            pad.PaddingLeft = UDim.new(0,8)
            pad.PaddingRight = UDim.new(0,8)

            TextBox.Focused:Connect(function()
                if _G.SafeLock then
                    TextBox.TextEditable = false
                    KyyfiiiLibrary:createNotification("Safe Lock on! Disable to use features.")
                    return
                end
                TextBox.TextEditable = true
                TweenService:Create(BoxTitle, TweenInfo.new(.1), {TextColor3 = PALETTE.TextPrimary}):Play()
            end)
            TextBox.FocusLost:Connect(function()
                if _G.SafeLock then return end
                Callback(TextBox.Text)
                TweenService:Create(BoxTitle, TweenInfo.new(.2), {TextColor3 = PALETTE.TextSecondary}):Play()
            end)
            
            -- Return object with UpdateText method for the BoxTitle
            return {
                UpdateText = function(self, newText)
                    BoxTitle.Text = "<b>"..newText.."</b>"
                end
            }
        end

        function Elements:CreateDropdown(Title, Options, Callback)
            local Dropdown = Instance.new("Frame")
            local corner = Instance.new("UICorner")
            local A_Dropdown = Instance.new("Frame")
            local DropdownBarHolder = Instance.new("Frame")
            local SelectedText = Instance.new("TextLabel")
            local DropdownToggler = Instance.new("ImageButton")
            local DropdownTitle = Instance.new("TextLabel")
            local B_Dropdown = Instance.new("Frame")

            Dropdown.Name = "Dropdown"
            Dropdown.Parent = Items
            Dropdown.AutomaticSize = Enum.AutomaticSize.Y
            Dropdown.BackgroundColor3 = PALETTE.Surface
            Dropdown.BackgroundTransparency = .8
            Dropdown.BorderSizePixel = 0
            Dropdown.Size = UDim2.new(0,336,0,34)
            corner.CornerRadius = UDim.new(0,6)
            corner.Parent = Dropdown

            A_Dropdown.Name = "A_Dropdown"
            A_Dropdown.Parent = Dropdown
            A_Dropdown.AutomaticSize = Enum.AutomaticSize.Y
            A_Dropdown.BackgroundTransparency = 1
            A_Dropdown.Size = UDim2.new(0,336,0,34)

            DropdownBarHolder.Name = "DropdownBarHolder"
            DropdownBarHolder.Parent = A_Dropdown
            DropdownBarHolder.AnchorPoint = Vector2.new(0,.5)
            DropdownBarHolder.BackgroundColor3 = PALETTE.Background
            DropdownBarHolder.BackgroundTransparency = .25
            DropdownBarHolder.BorderSizePixel = 0
            DropdownBarHolder.Position = UDim2.new(-0.327380955,300,.5,0)
            DropdownBarHolder.Size = UDim2.new(0,132,0,22)
            Instance.new("UICorner", DropdownBarHolder).CornerRadius = UDim.new(0,6)

            SelectedText.Name = "SelectedText"
            SelectedText.Parent = DropdownBarHolder
            SelectedText.BackgroundTransparency = 1
            SelectedText.Size = UDim2.new(0,100,0,22)
            SelectedText.ClipsDescendants = true
            SelectedText.Font = Enum.Font.Jura
            SelectedText.RichText = true
            SelectedText.Text = "None"
            SelectedText.TextColor3 = PALETTE.TextPrimary
            SelectedText.TextSize = 14
            SelectedText.TextTruncate = Enum.TextTruncate.AtEnd
            SelectedText.TextXAlignment = Enum.TextXAlignment.Right
            addTextStroke(SelectedText) -- Add glowing white border
            Instance.new("UIPadding", SelectedText).PaddingRight = UDim.new(0,2)

            DropdownToggler.Name = "DropdownToggler"
            DropdownToggler.Parent = DropdownBarHolder
            DropdownToggler.Active = true
            DropdownToggler.AnchorPoint = Vector2.new(0,.5)
            DropdownToggler.BackgroundTransparency = 1
            DropdownToggler.Position = UDim2.new(0.819999993,0,.5,0)
            DropdownToggler.Rotation = 180
            DropdownToggler.Size = UDim2.new(0,12,0,12)
            DropdownToggler.Image = "rbxassetid://128993416980283"
            DropdownToggler.ImageColor3 = PALETTE.TextPrimary

            DropdownTitle.Name = "DropdownTitle"
            DropdownTitle.Parent = A_Dropdown
            DropdownTitle.BackgroundTransparency = 1
            DropdownTitle.Size = UDim2.new(0,190,0,34)
            DropdownTitle.Font = Enum.Font.Jura
            DropdownTitle.RichText = true
            DropdownTitle.Text = "<b>"..Title.."</b>"
            DropdownTitle.TextColor3 = PALETTE.TextSecondary
            DropdownTitle.TextSize = 14
            DropdownTitle.TextXAlignment = Enum.TextXAlignment.Left
            addTextStroke(DropdownTitle) -- Add glowing white border
            Instance.new("UIPadding", DropdownTitle).PaddingLeft = UDim.new(0,16)

            B_Dropdown.Name = "B_Dropdown"
            B_Dropdown.Parent = Dropdown
            B_Dropdown.AutomaticSize = Enum.AutomaticSize.Y
            B_Dropdown.BackgroundTransparency = 1
            B_Dropdown.Size = UDim2.new(0,336,0,34)
            B_Dropdown.Visible = false

            Instance.new("UIListLayout", B_Dropdown).Padding = UDim.new(0,6)
            local pad = Instance.new("UIPadding", B_Dropdown)
            pad.PaddingBottom = UDim.new(0,8)
            pad.PaddingLeft = UDim.new(0,13)
            pad.PaddingTop = UDim.new(0,2)

            local isOpen = false
            local function Toggle()
                if _G.SafeLock then
                    KyyfiiiLibrary:createNotification("Safe Lock on! Disable to use features.")
                    return
                end
                isOpen = not isOpen
                local rot = isOpen and 90 or 180
                TweenService:Create(DropdownToggler, TweenInfo.new(.2,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),
                    {Rotation = rot}):Play()
                B_Dropdown.Visible = isOpen
                local tc = isOpen and PALETTE.TextPrimary or PALETTE.TextSecondary
                TweenService:Create(DropdownTitle, TweenInfo.new(isOpen and .1 or .2), {TextColor3 = tc}):Play()
            end
            DropdownToggler.MouseButton1Click:Connect(Toggle)

            for _, opt in ipairs(Options) do
                local optFrm = Instance.new("Frame")
                local optCorner = Instance.new("UICorner")
                local optBtn = Instance.new("TextButton")
                optFrm.Name = "OptionFrame"
                optFrm.Parent = B_Dropdown
                optFrm.BackgroundColor3 = PALETTE.Background
                optFrm.BackgroundTransparency = .25
                optFrm.BorderSizePixel = 0
                optFrm.Size = UDim2.new(0,310,0,28)
                optCorner.CornerRadius = UDim.new(0,6)
                optCorner.Parent = optFrm
                optBtn.Parent = optFrm
                optBtn.BackgroundTransparency = 1
                optBtn.Size = UDim2.new(0,310,0,28)
                optBtn.Font = Enum.Font.Jura
                optBtn.RichText = true
                optBtn.Text = "<b>"..opt.."</b>"
                optBtn.TextColor3 = PALETTE.TextSecondary
                optBtn.TextSize = 14
                optBtn.TextXAlignment = Enum.TextXAlignment.Right
                addTextStroke(optBtn) -- Add glowing white border
                Instance.new("UIPadding", optBtn).PaddingRight = UDim.new(0,14)

                optBtn.MouseButton1Click:Connect(function()
                    if _G.SafeLock then
                        KyyfiiiLibrary:createNotification("Safe Lock on! Disable to use features.")
                        return
                    end
                    SelectedText.Text = opt
                    Callback(opt)
                    Toggle()
                end)
            end
            
            -- Return object with UpdateText method for the DropdownTitle
            return {
                UpdateText = function(self, newText)
                    DropdownTitle.Text = "<b>"..newText.."</b>"
                end
            }
        end

        return Elements
    end
    return Tabs
end

return KyyfiiiLibrary
