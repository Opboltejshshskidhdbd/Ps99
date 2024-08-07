-- UI Library Code
local UI = {}

-- Function to create the main frame
function UI:createMain(title)
    local ScreenGui = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local TabsContainer = Instance.new("Frame")
    local ContentFrame = Instance.new("Frame")
    local UIListLayout = Instance.new("UIListLayout")
    local TitleLabel = Instance.new("TextLabel")
    local UICorner = Instance.new("UICorner")

    ScreenGui.Parent = game.CoreGui  -- Use CoreGui for exploit purposes
    ScreenGui.ResetOnSpawn = false

    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    MainFrame.Position = UDim2.new(0.05, 0, 0.27, 0)
    MainFrame.Size = UDim2.new(0, 600, 0, 400)
    MainFrame.ClipsDescendants = true

    TabsContainer.Parent = MainFrame
    TabsContainer.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    TabsContainer.BorderSizePixel = 0
    TabsContainer.Position = UDim2.new(0.01, 0, 0.05, 0)
    TabsContainer.Size = UDim2.new(0, 120, 0, 370)
    TabsContainer.ClipsDescendants = true

    ContentFrame.Parent = MainFrame
    ContentFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    ContentFrame.BorderSizePixel = 0
    ContentFrame.Position = UDim2.new(0.22, 0, 0.05, 0)
    ContentFrame.Size = UDim2.new(0, 460, 0, 370)
    ContentFrame.ClipsDescendants = true

    UIListLayout.Parent = TabsContainer
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 10)

    TitleLabel.Parent = MainFrame
    TitleLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    TitleLabel.BackgroundTransparency = 1.0
    TitleLabel.LayoutOrder = 5
    TitleLabel.Position = UDim2.new(0.01, 0, 0.02, 0)
    TitleLabel.Size = UDim2.new(0, 275, 0, 40)
    TitleLabel.ZIndex = 2
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.Text = title
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.TextScaled = true
    TitleLabel.TextSize = 14.0
    TitleLabel.TextWrapped = true

    UICorner.CornerRadius = UDim.new(0.05, 0)
    UICorner.Parent = MainFrame

    local function enableDragging()
        local script = Instance.new('LocalScript', MainFrame)
        script.Parent.Active = true
        script.Parent.Draggable = true
    end
    coroutine.wrap(enableDragging)()

    local MainAPI = {}
    MainAPI.tabs = {}

    function MainAPI:createTab(name, iconId)
        local TabButton = Instance.new("TextButton")
        TabButton.Parent = TabsContainer
        TabButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        TabButton.BorderSizePixel = 0
        TabButton.Size = UDim2.new(0, 100, 0, 50)
        TabButton.Font = Enum.Font.SourceSansBold
        TabButton.Text = name
        TabButton.TextColor3 = Color3.fromRGB(235, 235, 235)
        TabButton.TextScaled = true
        TabButton.TextSize = 14.0
        TabButton.TextWrapped = true

        local UICornerTab = Instance.new("UICorner")
        UICornerTab.CornerRadius = UDim.new(0.1, 0)
        UICornerTab.Parent = TabButton

        local TabFrame = Instance.new("Frame")
        TabFrame.Parent = ContentFrame
        TabFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        TabFrame.BorderSizePixel = 0
        TabFrame.Size = UDim2.new(0, 460, 0, 370)
        TabFrame.Visible = false
        TabFrame.ClipsDescendants = true

        local Icon = Instance.new("ImageLabel")
        Icon.Parent = TabFrame
        Icon.BackgroundTransparency = 1.0
        Icon.Position = UDim2.new(0.05, 0, 0.05, 0)
        Icon.Size = UDim2.new(0, 50, 0, 50)
        Icon.Image = "rbxassetid://" .. iconId

        local function switchToTab()
            for _, tab in pairs(MainAPI.tabs) do
                tab.Frame.Visible = false
            end
            TabFrame.Visible = true
        end

        TabButton.MouseButton1Click:Connect(switchToTab)

        local TabAPI = {}
        TabAPI.Frame = TabFrame

        function TabAPI:createButton(name, callback)
            local Button = Instance.new("TextButton")
            Button.Parent = TabFrame
            Button.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
            Button.BorderSizePixel = 0
            Button.Size = UDim2.new(0, 200, 0, 50)
            Button.Font = Enum.Font.SourceSansBold
            Button.Text = name
            Button.TextColor3 = Color3.fromRGB(235, 235, 235)
            Button.TextScaled = true
            Button.TextSize = 14.0
            Button.TextWrapped = true

            local UICornerButton = Instance.new("UICorner")
            UICornerButton.CornerRadius = UDim.new(0.1, 0)
            UICornerButton.Parent = Button

            Button.MouseButton1Click:Connect(function()
                local success, errorMsg = pcall(callback)
                if not success then
                    warn("Button callback error: " .. errorMsg)
                end
            end)
        end

        function TabAPI:createToggle(name, default, callback)
            local ToggleFrame = Instance.new("Frame")
            local ToggleButton = Instance.new("TextButton")
            local ToggleLabel = Instance.new("TextLabel")
            local ToggleState = default or false

            ToggleFrame.Parent = TabFrame
            ToggleFrame.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
            ToggleFrame.BorderSizePixel = 0
            ToggleFrame.Size = UDim2.new(0, 200, 0, 50)

            local UICornerToggleFrame = Instance.new("UICorner")
            UICornerToggleFrame.CornerRadius = UDim.new(0.1, 0)
            UICornerToggleFrame.Parent = ToggleFrame

            ToggleButton.Parent = ToggleFrame
            ToggleButton.BackgroundColor3 = ToggleState and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
            ToggleButton.BorderSizePixel = 0
            ToggleButton.Position = UDim2.new(0.8, 0, 0.1, 0)
            ToggleButton.Size = UDim2.new(0, 30, 0, 30)
            ToggleButton.Font = Enum.Font.SourceSansBold
            ToggleButton.Text = ""
            ToggleButton.TextScaled = true

            ToggleLabel.Parent = ToggleFrame
            ToggleLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ToggleLabel.BackgroundTransparency = 1.0
            ToggleLabel.Size = UDim2.new(0.75, 0, 1, 0)
            ToggleLabel.Font = Enum.Font.SourceSansBold
            ToggleLabel.Text = name
            ToggleLabel.TextColor3 = Color3.fromRGB(235, 235, 235)
            ToggleLabel.TextScaled = true
            ToggleLabel.TextSize = 14.0
            ToggleLabel.TextWrapped = true

            ToggleButton.MouseButton1Click:Connect(function()
                ToggleState = not ToggleState
                ToggleButton.BackgroundColor3 = ToggleState and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
                local success, errorMsg = pcall(callback, ToggleState)
                if not success then
                    warn("Toggle callback error: " .. errorMsg)
                end
            end)
        end

        table.insert(MainAPI.tabs, { Button = TabButton, Frame = TabFrame })
        return TabAPI
    end

    return MainAPI
end

return UI