local users = {
    {username = "test", password = "test", discord_nickname = "", hwid = "", subscription = "true" },
    {username = "ch111", password = "ch111", discord_nickname = "trlessless", hwid = "B189165D-B889-4FD5-BE1A-AB0B6C4FE674", subscription = "true"},
    {username = "admin", password = "admin123", discord_nickname = "love_gitler", hwid = "95DC1493-4ED1-436F-B563-CC545354CD8B", subscription = "true" },
    {username = "i pidor", password = "sam ti pidor", discord_nickname = "byblik_v_smetane", hwid = "", subscription = "false"},
    {username = "Fatal", password = "Dofamania123321", discord_nickname = "kleef.", hwid = "41C35432-7B9B-46B6-854F-8598F40C8610", subscription = "true"},
    {username = "Rinarik", password = "Riso15", discord_nickname = "rinarya", hwid = "", subscription = "true"},
    {username = "asdasdasd", password = "sadasdasd", discord_nickname = "love_gitler", hwid = "", subscription = "false"}
}


local Loader = {}
Loader.ui = {}
Loader.config = { vars = {} }

local function ChekerFatality(name, func)
    local obj, timeout, startTime = func(), 5, tick()
    while not obj and tick() - startTime < timeout do task.wait() obj = func() end
    return obj or warn("Не удалось получить " .. name)
end

local HttpService = ChekerFatality("HttpService", function() return game:GetService("HttpService") end)
local UserInputService = ChekerFatality("UserInputService", function() return game:GetService("UserInputService") end)
local CoreGui = ChekerFatality("CoreGui", function() return game:GetService("CoreGui") end)
local Camera = ChekerFatality("CurrentCamera", function() return game.Workspace.CurrentCamera end)
local TweenService = ChekerFatality("TweenService", function() return game:GetService("TweenService") end)
local RbxAnalyticsService = ChekerFatality("RbxAnalyticsService", function() return game:GetService("RbxAnalyticsService") end)
local hwid = RbxAnalyticsService and RbxAnalyticsService:GetClientId() or (HttpService and HttpService:GetUserId() or "unknown")

local success, errorMessage = pcall(function()
    if not isfolder("Fatality") then
        makefolder("Fatality")
    end
    writefile("Fatality/HWID.lua", hwid)
end)

if not success then
    warn("Failed to create HWID.lua: " .. errorMessage)
end

local LoaderGui = Instance.new("ScreenGui")
LoaderGui.IgnoreGuiInset = true
LoaderGui.ResetOnSpawn = false
LoaderGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
LoaderGui.Parent = CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 250, 0, 250)
MainFrame.BackgroundColor3 = Color3.fromRGB(16, 14, 34)
MainFrame.ZIndex = 100
MainFrame.Parent = LoaderGui
MainFrame.BackgroundTransparency = 1

local function centerMainFrame()
    local viewportSize = Camera.ViewportSize
    MainFrame.Position = UDim2.new(0.5, -125, 0.5, -125)
end

centerMainFrame()
Camera:GetPropertyChangedSignal("ViewportSize"):Connect(centerMainFrame)

local tweenInfoAppear = TweenInfo.new(0.65, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local tweenAppear = TweenService:Create(MainFrame, tweenInfoAppear, {BackgroundTransparency = 0})
tweenAppear:Play()

local TopFrame = Instance.new("Frame")
TopFrame.Size = UDim2.new(1, 0, 0.15, 0)
TopFrame.BackgroundColor3 = Color3.fromRGB(29, 23, 60)
TopFrame.Parent = MainFrame
TopFrame.ZIndex = 101
TopFrame.BackgroundTransparency = 1

local tweenTopFrame = TweenService:Create(TopFrame, tweenInfoAppear, {BackgroundTransparency = 0})
tweenTopFrame:Play()

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(0.9, 0, 1.1, 0)
TitleLabel.Position = UDim2.new(0.05, 0, -0.05, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "FATALITY LOADER"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = 20
TitleLabel.TextScaled = true
TitleLabel.ZIndex = 102
TitleLabel.Parent = TopFrame
TitleLabel.TextTransparency = 1

local tweenTitleLabel = TweenService:Create(TitleLabel, tweenInfoAppear, {TextTransparency = 0})
tweenTitleLabel:Play()

local Stroke = Instance.new("UIStroke")
Stroke.Thickness = 2
Stroke.Color = Color3.fromRGB(0, 0, 255)
Stroke.Parent = TitleLabel
local TweenInfoStroke = TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)
local TweenStroke = TweenService:Create(Stroke, TweenInfoStroke, {Color = Color3.fromRGB(128, 0, 128)})
TweenStroke:Play()

local GradientFrame = Instance.new("Frame")
GradientFrame.Size = UDim2.new(1, 0, 0.01, 0)
GradientFrame.Position = UDim2.new(0, 0, 0.15, 0)
GradientFrame.BackgroundTransparency = 0
GradientFrame.ZIndex = 101
GradientFrame.Parent = MainFrame

local Gradient = Instance.new("UIGradient")
Gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 200)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 95, 145))
})
Gradient.Parent = GradientFrame
local TweenInfoGradient = TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)
local TweenGradient = TweenService:Create(GradientFrame, TweenInfoGradient, {BackgroundTransparency = 0.3})
TweenGradient:Play()

local function shakeMainFrame()
    local currentPosition = MainFrame.Position
    local tweenInfoShake = TweenInfo.new(0.05, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 2, true)
    local tweenShake1 = TweenService:Create(MainFrame, tweenInfoShake, {Position = UDim2.new(currentPosition.X.Scale, currentPosition.X.Offset + 10, currentPosition.Y.Scale, currentPosition.Y.Offset)})
    local tweenShake2 = TweenService:Create(MainFrame, tweenInfoShake, {Position = UDim2.new(currentPosition.X.Scale, currentPosition.X.Offset - 10, currentPosition.Y.Scale, currentPosition.Y.Offset)})
    tweenShake1.Completed:Connect(function()
        tweenShake2:Play()
    end)
    tweenShake2.Completed:Connect(function()
        MainFrame.Position = currentPosition
    end)
    tweenShake1:Play()
end

local dragging = false
local dragInput, dragStart, offset
local function updateDrag(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(offset.X.Scale, offset.X.Offset + delta.X, offset.Y.Scale, offset.Y.Offset + delta.Y)
end
TopFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        offset = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)
TopFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        updateDrag(input)
    end
end)

local function TextEntry(name, varName, parent)
    local textEntryFrame = Instance.new("Frame")
    textEntryFrame.Size = UDim2.new(0, 241, 0, 58)
    textEntryFrame.BackgroundTransparency = 1
    textEntryFrame.ZIndex = 100
    textEntryFrame.Parent = parent

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, 0, 0.3, 0)
    titleLabel.Position = UDim2.new(0, 0, -0.025, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = name
    titleLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 12.5
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.ZIndex = 100
    titleLabel.Parent = textEntryFrame
    titleLabel.TextTransparency = 1

    local tweenTitleLabel = TweenService:Create(titleLabel, tweenInfoAppear, {TextTransparency = 0})
    tweenTitleLabel:Play()

    local textBoxBorder = Instance.new("Frame")
    textBoxBorder.Size = UDim2.new(0.75, 23, 0.45, 2)
    textBoxBorder.Position = UDim2.new(0, -2, 0.3, -1)
    textBoxBorder.BackgroundTransparency = 1
    textBoxBorder.ZIndex = 101
    textBoxBorder.Parent = textEntryFrame

    local borderStroke = Instance.new("UIStroke")
    borderStroke.Thickness = 1
    borderStroke.Color = Color3.fromRGB(29, 23, 60)
    borderStroke.Parent = textBoxBorder
    borderStroke.Transparency = 1

    local tweenBorderStroke = TweenService:Create(borderStroke, tweenInfoAppear, {Transparency = 0})
    tweenBorderStroke:Play()

    local textBox = Instance.new("TextBox")
    textBox.Size = UDim2.new(0.81, 0, 0.35, 0)
    textBox.Position = UDim2.new(0.01, 0, 0.35, 0)
    textBox.BackgroundColor3 = Color3.fromRGB(29, 23, 60)
    textBox.TextColor3 = Color3.fromRGB(220, 220, 220)
    textBox.Font = Enum.Font.GothamBold
    textBox.TextSize = 15
    textBox.TextXAlignment = Enum.TextXAlignment.Left
    textBox.Text = Loader.config.vars[varName] or ""
    textBox.PlaceholderText = ""
    textBox.PlaceholderColor3 = Color3.fromRGB(100, 100, 100)
    textBox.ClearTextOnFocus = false
    textBox.TextTruncate = Enum.TextTruncate.AtEnd
    textBox.ClipsDescendants = true
    textBox.ZIndex = 100
    textBox.Parent = textEntryFrame
    textBox.BackgroundTransparency = 1
    textBox.TextTransparency = 1

    local tweenTextBoxBg = TweenService:Create(textBox, tweenInfoAppear, {BackgroundTransparency = 0})
    local tweenTextBoxText = TweenService:Create(textBox, tweenInfoAppear, {TextTransparency = 0})
    tweenTextBoxBg:Play()
    tweenTextBoxText:Play()

    local textPadding = Instance.new("UIPadding")
    textPadding.PaddingLeft = UDim.new(0, 8)
    textPadding.Parent = textBox

    if Loader.config.vars[varName] == nil then
        Loader.config.vars[varName] = ""
    end

    local isHovering = false
    local isFocused = false

    local function updateVisual()
        local targetColor = (isHovering or isFocused) and Color3.fromRGB(255, 95, 145) or Color3.fromRGB(29, 23, 60)
        local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tween = TweenService:Create(borderStroke, tweenInfo, {Color = targetColor})
        tween:Play()
    end

    updateVisual()

    textBoxBorder.MouseEnter:Connect(function()
        isHovering = true
        updateVisual()
    end)

    textBoxBorder.MouseLeave:Connect(function()
        isHovering = false
        updateVisual()
    end)

    textBox.Focused:Connect(function()
        isFocused = true
        textBox.TextTruncate = Enum.TextTruncate.None
        textBox.CursorPosition = #textBox.Text + 1
        updateVisual()
    end)

    textBox.FocusLost:Connect(function(enterPressed)
        isFocused = false
        textBox.TextTruncate = Enum.TextTruncate.AtEnd
        updateVisual()
        if enterPressed then
            Loader.config.vars[varName] = textBox.Text
        end
    end)

    textBox:GetPropertyChangedSignal("Text"):Connect(function()
        if isFocused then
            textBox.CursorPosition = #textBox.Text + 1
        end
    end)

    if not Loader.ui.AllTextEntries then
        Loader.ui.AllTextEntries = {}
    end
    table.insert(Loader.ui.AllTextEntries, function()
        textBox.Text = Loader.config.vars[varName] or ""
        if not isFocused then
            textBox.TextTruncate = Enum.TextTruncate.AtEnd
        end
    end)

    return textEntryFrame, textBox
end

local UsernameFrame, UsernameInput = TextEntry("Username", "username", MainFrame)
UsernameFrame.Position = UDim2.new(0.1, 0, 0.225, 0)

local PasswordFrame, PasswordInput = TextEntry("Password", "password", MainFrame)
PasswordFrame.Position = UDim2.new(0.1, 0, 0.45, 0)

local LoginButton = Instance.new("TextButton")
LoginButton.Size = UDim2.new(0.4, 0, 0.15, 0)
LoginButton.Position = UDim2.new(0.3, 0, 0.725, 0)
LoginButton.BackgroundColor3 = Color3.fromRGB(195, 44, 95)
LoginButton.Text = "Login"
LoginButton.TextColor3 = Color3.fromRGB(255, 255, 255)
LoginButton.Font = Enum.Font.GothamBold
LoginButton.TextSize = 16
LoginButton.ZIndex = 102
LoginButton.Parent = MainFrame
LoginButton.BackgroundTransparency = 1
LoginButton.TextTransparency = 1

local tweenLoginButtonBg = TweenService:Create(LoginButton, tweenInfoAppear, {BackgroundTransparency = 0})
local tweenLoginButtonText = TweenService:Create(LoginButton, tweenInfoAppear, {TextTransparency = 0})
tweenLoginButtonBg:Play()
tweenLoginButtonText:Play()

local ButtonStroke = Instance.new("UIStroke")
ButtonStroke.Thickness = 1
ButtonStroke.Color = Color3.fromRGB(29, 23, 60)
ButtonStroke.Parent = LoginButton
ButtonStroke.Transparency = 1

local tweenButtonStroke = TweenService:Create(ButtonStroke, tweenInfoAppear, {Transparency = 0})
tweenButtonStroke:Play()

local function tweenBackground(frame, color)
    local tween = TweenService:Create(frame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = color})
    tween:Play()
end

LoginButton.MouseEnter:Connect(function()
    tweenBackground(LoginButton, Color3.fromRGB(150, 34, 73))
end)
LoginButton.MouseLeave:Connect(function()
    tweenBackground(LoginButton, Color3.fromRGB(195, 44, 95))
end)

local function checkUser(username, password)
    local hwid = game:GetService("RbxAnalyticsService"):GetClientId()
    for _, user in ipairs(users) do
        if user.username == username and user.password == password then
            if user.hwid == hwid and user.subscription == "true" then
                return true
            end
        end
    end
    return false
end

LoginButton.MouseButton1Click:Connect(function()
    local username = UsernameInput.Text
    local password = PasswordInput.Text
    if username == "" or password == "" then
        shakeMainFrame()
    else
        if checkUser(username, password) then
            LoaderGui:Destroy()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/AgentZuza/labdapdap/refs/heads/main/networked.lua"))()
        else
            shakeMainFrame()
        end
    end
end)