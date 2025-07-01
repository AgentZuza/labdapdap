local Fatality = {}
Fatality.tabs = {}
Fatality.ui = {}
Fatality.config = { vars = {}, binds = {}, colors = {} }
local security = true

local function ChekerFatality(name, func)
    local obj, timeout, startTime = func(), 5, tick()
    while not obj and tick() - startTime < timeout do task.wait() obj = func() end
    return obj or warn("Не удалось получить " .. name) and nil
end

Fatality.LocalPlayer = ChekerFatality("LocalPlayer", function()
    local p = game:GetService("Players").LocalPlayer
    if p then return p end
    local c c = game:GetService("Players").PlayerAdded:Connect(function(plr) if plr == game:GetService("Players").LocalPlayer then p = plr c:Disconnect() end end)
    return p
end)

Fatality.gui = Instance.new("ScreenGui")
Fatality.UserInputService = ChekerFatality("UserInputService", function() return game:GetService("UserInputService") end)
Fatality.gui.IgnoreGuiInset = true
Fatality.gradient = Instance.new("UIGradient")
Fatality.gui.Parent = ChekerFatality("CoreGui", function() return game:GetService("CoreGui") end)
Fatality.gui.ResetOnSpawn = false
Fatality.LocalCamera = ChekerFatality("CurrentCamera", function() return game.Workspace.CurrentCamera end)
Fatality.Players = ChekerFatality("Players", function() return game:GetService("Players") end)
Fatality.RunService = ChekerFatality("RunService", function() return game:GetService("RunService") end)
Fatality.TweenService = ChekerFatality("TweenService", function() return game:GetService("TweenService") end)
Fatality.Lighting = ChekerFatality("Lighting", function() return game:GetService("Lighting") end)
Fatality.Terrain = ChekerFatality("Terrain", function() return game.Workspace:FindFirstChildOfClass("Terrain") end)
Fatality.HttpService = ChekerFatality("HttpService", function() return game:GetService("HttpService") end)
Fatality.TextChatService = ChekerFatality("TextChatService", function() return game:GetService("TextChatService") end)

local Menuframe = Instance.new("Frame")
Menuframe.Size = UDim2.new(0.0, 1056, 0.0, 767)
Menuframe.Position = UDim2.new(0.225, 0, 0.1, 0)
Menuframe.BackgroundColor3 = Color3.fromRGB(16, 14, 34)
Menuframe.Parent = Fatality.gui
Menuframe.Visible = false 
---------------------------------------------------Config
Fatality.config.vars["FOVValue"] = 50
Fatality.config.vars["TargetPriority"] = "FOV"
Fatality.config.colors["HealthPlayerCol"] = Color3.new(0, 1, 0)
Fatality.config.colors["HealthPlayerCol2"] = Color3.new(1, 0, 0)
Fatality.config.binds["Test"] = Enum.KeyCode.Space
Fatality.config.binds["Test1"] = Enum.UserInputType.MouseButton1
Fatality.config.vars["SpeedHackSlider"] = 100
Fatality.config.vars["DistanceESP"] = 1000
Fatality.config.vars["JumpBloxSlider"] = 5
Fatality.config.vars["SpeedBloxSlider"] = 5 
Fatality.config.vars["DistanceAntiKnife"] = 1000
Fatality.config.vars["BoxStyle"] = "Default"
Fatality.config.vars["FOVViewSlider"] = Fatality.LocalCamera.FieldOfView
Fatality.config.vars["ESPUpdateInterval"] = 35
Fatality.config.vars["TargetSelection"] = 1
Fatality.config.vars["GlowOutlineMax"] = 1
Fatality.config.vars["SoundValume"] = 1

---------------------------------------------------UI
local function StartupAnimation()
    local startupGui = Instance.new("ScreenGui")
    startupGui.Name = "FatalityStartupGui"
    startupGui.IgnoreGuiInset = true
    startupGui.ResetOnSpawn = false
    startupGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
    startupGui.Parent = game:GetService("CoreGui")

    local gradientSquare = Instance.new("Frame")
    gradientSquare.Size = UDim2.new(0, 150, 0, 150)
    gradientSquare.Position = UDim2.new(0.5, -75, 0.5, -75)
    gradientSquare.BackgroundColor3 = Color3.new(1, 1, 1)
    gradientSquare.BackgroundTransparency = 1
    gradientSquare.ZIndex = 10000
    gradientSquare.Parent = startupGui

    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(128, 0, 128)),      
        ColorSequenceKeypoint.new(0.3, Color3.fromRGB(150, 22, 111)),  
        ColorSequenceKeypoint.new(0.6, Color3.fromRGB(172, 33, 103)),  
        ColorSequenceKeypoint.new(1, Color3.fromRGB(195, 44, 95))      
    })
    gradient.Rotation = 45
    gradient.Parent = gradientSquare

    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(0, 300, 0, 300)
    textLabel.Position = UDim2.new(0.5, -150, 0.5, -150)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = "F"
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.TextSize = 150
    textLabel.TextScaled = false
    textLabel.TextTransparency = 1
    textLabel.ZIndex = 10001
    textLabel.Parent = gradientSquare

    local tweenService = Fatality.TweenService
    local gradientTweenInfo = TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)
    local gradientTween = tweenService:Create(gradient, gradientTweenInfo, {
        Offset = Vector2.new(0.5, 0.5),
        Rotation = 90 
    })
    gradientTween:Play()

    local squareFadeInInfo = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
    local squareFadeIn = tweenService:Create(gradientSquare, squareFadeInInfo, {BackgroundTransparency = 0})
    squareFadeIn:Play()

    squareFadeIn.Completed:Wait()
    task.wait(0.5)

    local textFadeInInfo = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
    local textFadeIn = tweenService:Create(textLabel, textFadeInInfo, {TextTransparency = 0})
    textFadeIn:Play()

    textFadeIn.Completed:Wait()

    local fullText = "FATALITY.WIN"
    local textTransitionTweenInfo = TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
    local squareExpand = tweenService:Create(gradientSquare, textTransitionTweenInfo, {
        Size = UDim2.new(0, 640, 0, 150),
        Position = UDim2.new(0.5, -320, 0.5, -75)
    })
    local textScaleUp = tweenService:Create(textLabel, textTransitionTweenInfo, {
        Size = UDim2.new(0, 360, 0, 80),
        Position = UDim2.new(0.5, -180, 0.5, -40),
    })
    squareExpand:Play()
    textScaleUp:Play()

    task.spawn(function()
        for i = 1, #fullText do
            textLabel.Text = string.sub(fullText, 1, i)
            task.wait(2 / #fullText)
        end
    end)

    squareExpand.Completed:Wait()
    task.wait(1)
    task.wait(1)

    local fadeOutTweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
    local squareFadeOut = tweenService:Create(gradientSquare, fadeOutTweenInfo, {BackgroundTransparency = 1})
    local textFadeOut = tweenService:Create(textLabel, fadeOutTweenInfo, {TextTransparency = 1})
    squareFadeOut:Play()
    textFadeOut:Play()

    squareFadeOut.Completed:Connect(function()
        if Menuframe then
            Menuframe.Visible = true
        end
        gradientSquare:Destroy()
        textLabel:Destroy()
        startupGui:Destroy()
    end)
end

StartupAnimation()

local function toggleMenu()
    Menuframe.Visible = not Menuframe.Visible
    
    if Menuframe.Visible then
        if not security then
            Fatality.LocalCamera.CameraType = Enum.CameraType.Scriptable
            Fatality.LocalCamera.CFrame = camera.CFrame 
        end
        Fatality.UserInputService.MouseBehavior = Enum.MouseBehavior.Default 
        Fatality.UserInputService.MouseIconEnabled = true
    else 
        if not security then
            Fatality.LocalCamera.CameraType = Enum.CameraType.Custom
            Fatality.UserInputService.MouseBehavior = Enum.MouseBehavior.Default 
        end
        if Fatality.config.vars["FreeCamera"] then
            Fatality.UserInputService.MouseIconEnabled = false
        end
        Fatality.UserInputService.MouseIconEnabled = true
    end
end

Fatality.RunService.RenderStepped:Connect(function()
    if Menuframe.Visible then
        Fatality.UserInputService.MouseIconEnabled = true
        Fatality.UserInputService.MouseBehavior = Enum.MouseBehavior.Default
    end
end)

Fatality.UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
	if not gameProcessedEvent and input.KeyCode == Enum.KeyCode.Delete then
		toggleMenu()
	end
end)

local label = Instance.new("TextLabel")
label.Text = "FATALITY"
label.Font = Enum.Font.GothamBold
label.TextSize = 25
label.TextColor3 = Color3.fromRGB(255, 255, 255)
label.TextScaled = true
label.Size = UDim2.new(0.25, 0, 0.1, 0)
label.BackgroundTransparency = 1
label.Position = UDim2.new(0.01, 0, 0.08, 0)
label.ZIndex = 22.5
label.Parent = Menuframe
local stroke = Instance.new("UIStroke")
stroke.Thickness = 2
stroke.Transparency = 0
stroke.Color = Color3.fromRGB(0, 0, 255)
stroke.Parent = label
local tweenInfo = TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)
local tween = Fatality.TweenService:Create(stroke, tweenInfo, {Color = Color3.fromRGB(128, 0, 128)})
tween:Play()

local topFrame = Instance.new("Frame")
topFrame.Size = UDim2.new(1, 0, 0.05, 0)
topFrame.Position = UDim2.new(0, 0, 0, 0)
topFrame.BackgroundColor3 = Color3.fromRGB(29, 23, 60)
topFrame.Parent = Menuframe
topFrame.ZIndex = 21

local dragging = false
local dragInput, dragStart, offset

local function tytytytytyty(input)
    local delta = input.Position - dragStart
    Menuframe.Position = UDim2.new(offset.X.Scale, offset.X.Offset + delta.X,offset.Y.Scale, offset.Y.Offset + delta.Y) --Menuframe.Position = UDim2.new(0, offset.X + delta.X, 0, offset.Y + delta.Y)
end

topFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        offset = Menuframe.Position --offset = Menuframe.AbsolutePosition

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

topFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

Fatality.UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        tytytytytyty(input)
    end
end)

local headerFrame = Instance.new("Frame")
headerFrame.Size = UDim2.new(1, 0, 0.15, 0)
headerFrame.Position = UDim2.new(0, 0, 0.06, 0)
headerFrame.BackgroundColor3 = Color3.fromRGB(29, 23, 60)
headerFrame.Parent = Menuframe
headerFrame.ZIndex = 21

local gradientframe = Instance.new("Frame")
gradientframe.Size = UDim2.new(1, 0, 0.01, 0)
gradientframe.Position = UDim2.new(0, 0, 0.05, 0)
gradientframe.BackgroundTransparency = 0.0 
gradientframe.Parent = Menuframe
gradientframe.ZIndex = 21

Fatality.gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 200)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(195, 44, 95))
})
Fatality.gradient.Parent = gradientframe

local tweenInfoGradient = TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)
local tween = Fatality.TweenService:Create(gradientframe, tweenInfoGradient, {BackgroundTransparency = 0.3})
tween:Play()

local TabButtonsFrame = Instance.new("Frame")
TabButtonsFrame.Size = UDim2.new(1, 0, 0.1, 0)
TabButtonsFrame.Position = UDim2.new(0.3, 0, 0.09, 0)
TabButtonsFrame.BackgroundTransparency = 1
TabButtonsFrame.Parent = Menuframe

local tabList = Instance.new("UIListLayout")
tabList.FillDirection = Enum.FillDirection.Horizontal
tabList.Padding = UDim.new(0, 30)
tabList.SortOrder = Enum.SortOrder.LayoutOrder
tabList.Parent = TabButtonsFrame

function Fatality.ui.CheckBox(name, varName, parent)
    local checkBoxFrame = Instance.new("Frame")
    checkBoxFrame.Size = UDim2.new(0, 240, 0.0, 24)
    checkBoxFrame.BackgroundTransparency = 1
    checkBoxFrame.ZIndex = 100
    checkBoxFrame.Position = UDim2.new(0.025, 0, 0.025, 0)
    checkBoxFrame.Parent = parent

    local checkBoxBorder = Instance.new("Frame")
    checkBoxBorder.Size = UDim2.new(0.1, 0, 0.95, 0)
    checkBoxBorder.Position = UDim2.new(0.0, 0, -0.025, 0)
    checkBoxBorder.BackgroundTransparency = 1
    checkBoxBorder.ZIndex = 99
    checkBoxBorder.Parent = checkBoxFrame

    local borderStroke = Instance.new("UIStroke")
    borderStroke.Thickness = 1
    borderStroke.Color = Color3.fromRGB(29, 23, 60)
    borderStroke.Parent = checkBoxBorder

    local checkBox = Instance.new("TextButton")
    checkBox.Size = UDim2.new(0.075, 0, 0.7, 0)
    checkBox.BackgroundColor3 = Color3.fromRGB(29, 23, 60)
    checkBox.Position = UDim2.new(0.0125, 0, 0.1, 0)
    checkBox.Text = ""
    checkBox.ZIndex = 100
    checkBox.Parent = checkBoxFrame

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.85, 0, 1, 0)
    label.Position = UDim2.new(0.15, 0, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = Color3.fromRGB(220, 220, 220)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 12.5
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 100
    label.Parent = checkBoxFrame

    local touchZone = Instance.new("TextButton")
    touchZone.Size = UDim2.new(1, 0, 1, 0)
    touchZone.Position = UDim2.new(0, 0, 0, 0)
    touchZone.BackgroundTransparency = 1
    touchZone.Text = ""
    touchZone.ZIndex = 100
    touchZone.Parent = checkBoxBorder

    if Fatality.config.vars[varName] == nil then
        Fatality.config.vars[varName] = false
    end

    local isHovering = false

    local function updateVisual()
        if Fatality.config.vars[varName] then
            local tween = Fatality.TweenService:Create(borderStroke, TweenInfo.new(0.25), {Color = Color3.fromRGB(195, 44, 95)})
            tween:Play()
            checkBox.BackgroundColor3 = Color3.fromRGB(195, 44, 95)
        elseif isHovering then
            local tween = Fatality.TweenService:Create(borderStroke, TweenInfo.new(0.25), {Color = Color3.fromRGB(195, 44, 95)})
            tween:Play()
            checkBox.BackgroundColor3 = Color3.fromRGB(29, 23, 60)
        else
            local tween = Fatality.TweenService:Create(borderStroke, TweenInfo.new(0.25), {Color = Color3.fromRGB(29, 23, 60)})
            tween:Play()
            checkBox.BackgroundColor3 = Color3.fromRGB(29, 23, 60)
        end
    end

    updateVisual()

    local function toggleCheckBox()
        if Fatality.ui.ColorPanel then return end
        Fatality.config.vars[varName] = not Fatality.config.vars[varName]
        updateVisual()
    end

    checkBox.MouseButton1Click:Connect(toggleCheckBox)

    touchZone.MouseButton1Click:Connect(toggleCheckBox) 

    touchZone.MouseEnter:Connect(function()
        if Fatality.ui.ColorPanel then return end 
        isHovering = true
        updateVisual()
    end)

    touchZone.MouseLeave:Connect(function()
        isHovering = false
        updateVisual()
    end)

    if not Fatality.ui.AllCheckBoxes then
        Fatality.ui.AllCheckBoxes = {}
    end
    table.insert(Fatality.ui.AllCheckBoxes, updateVisual)

    return checkBoxFrame
end

function Fatality.ui.ComboBox(name, varName, options, parent, moresave)
    if moresave == nil then
        moresave = false
    end
    local comboFrame = Instance.new("Frame")
    comboFrame.Size = UDim2.new(0, 272, 0.0, 48)
    comboFrame.Position = UDim2.new(0.03, 0, 0, 0)
    comboFrame.BackgroundTransparency = 1
    comboFrame.ZIndex = 101
    comboFrame.Parent = parent

    local outlineframe = Instance.new("Frame")
    outlineframe.Size = UDim2.new(0.675, 0, 0.63, 0)
    outlineframe.Position = UDim2.new(0.0, 0, 0.3, 0)
    outlineframe.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
    outlineframe.BackgroundTransparency = 1
    outlineframe.ZIndex = 100
    outlineframe.Parent = comboFrame

    local borderStroke = Instance.new("UIStroke")
    borderStroke.Thickness = 1
    borderStroke.Color = Color3.fromRGB(29, 23, 60)
    borderStroke.Parent = outlineframe

    local isHovering = false
    local isOpen = false

    local function tweenColor(stroke, targetColor)
        local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tween = Fatality.TweenService:Create(stroke, tweenInfo, {Color = targetColor})
        tween:Play()
    end

    local function updateStrokeColor()
        if isHovering or isOpen then
            tweenColor(borderStroke, Color3.fromRGB(195, 44, 95))
        else
            tweenColor(borderStroke, Color3.fromRGB(29, 23, 60))
        end
    end

    outlineframe.MouseEnter:Connect(function()
        if Fatality.ui.ColorPanel then return end
        isHovering = true
        updateStrokeColor()
    end)
    outlineframe.MouseLeave:Connect(function()
        isHovering = false
        updateStrokeColor()
    end)

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.5, 0, 0.85, 0)
    label.Position = UDim2.new(0.005, 0, -0.3, 0)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = Color3.fromRGB(220, 220, 220)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 12.5
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 101
    label.Parent = comboFrame

    local dropdown = Instance.new("TextButton")
    dropdown.Size = UDim2.new(0.65, 0, 0.5, 0)
    dropdown.Position = UDim2.new(0.01, 0, 0.37, 0)
    dropdown.BackgroundColor3 = Color3.fromRGB(29, 23, 60)
    dropdown.Font = Enum.Font.GothamBold
    dropdown.TextColor3 = Color3.fromRGB(220, 220, 220)
    dropdown.TextSize = 15
    dropdown.TextXAlignment = Enum.TextXAlignment.Left
    dropdown.ZIndex = 101
    dropdown.Parent = comboFrame

    local arrowBackground = Instance.new("Frame")
    arrowBackground.Size = UDim2.new(0.16, 0, 1, 0)
    arrowBackground.Position = UDim2.new(0.85, 0, 0.0, 0)
    arrowBackground.BackgroundTransparency = 0
    arrowBackground.BackgroundColor3 = Color3.fromRGB(195, 44, 95)
    arrowBackground.ZIndex = 103
    arrowBackground.Parent = dropdown

    local arrow = Instance.new("TextLabel")
    arrow.Size = UDim2.new(1, 0, 1, 0)
    arrow.Position = UDim2.new(0, 0, -0.1, 0)
    arrow.BackgroundTransparency = 1
    arrow.Text = "▼"
    arrow.TextColor3 = Color3.fromRGB(220, 220, 220)
    arrow.Font = Enum.Font.GothamBold
    arrow.TextSize = 25
    arrow.ZIndex = 104
    arrow.Parent = arrowBackground

    if Fatality.config.vars[varName] == nil then
        if moresave then
            Fatality.config.vars[varName] = {}
        else
            Fatality.config.vars[varName] = options[1]
        end
    end

    local blackSquare = Instance.new("Frame")
    blackSquare.Size = UDim2.new(0.3, 0, 1, 0)
    blackSquare.Position = UDim2.new(0.65, 0, 0, 0)
    blackSquare.Visible = false
    blackSquare.ZIndex = 102
    blackSquare.Parent = dropdown

    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 25, 25)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
    })
    gradient.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(1, 0)
    })
    gradient.Parent = blackSquare

    local function anpassText(text, maxWidth, filler)
        local textWidth = game:GetService("TextService"):GetTextSize(text, 13, Enum.Font.GothamBold, Vector2.new(math.huge, 15)).X
        if textWidth <= maxWidth then 
            return "  " .. text, false 
        end
        for i = #text, 1, -1 do
            local shortened = text:sub(1, i) .. filler
            if game:GetService("TextService"):GetTextSize(shortened, 13, Enum.Font.GothamBold, Vector2.new(math.huge, 15)).X <= maxWidth then
                return "  " .. shortened, true
            end
        end
        return "  " .. filler, true
    end

    local optionButtons = {}

    local function updateDisplay()
        local displayText, isShortened
        if moresave then
            local selectedOptions = Fatality.config.vars[varName]
            if #selectedOptions == 0 then
                displayText = "  -"
                isShortened = false
            else
                displayText = table.concat(selectedOptions, ", ")
                displayText, isShortened = anpassText(displayText, dropdown.AbsoluteSize.X * 0.75, "...")
            end
        else
            displayText, isShortened = anpassText(Fatality.config.vars[varName], dropdown.AbsoluteSize.X * 0.8, " ")
        end

        dropdown.Text = displayText
        blackSquare.Visible = isShortened

        for _, btn in ipairs(optionButtons) do
            local opt = btn:GetAttribute("Option")
            local isSelected = moresave and table.find(Fatality.config.vars[varName], opt) or (opt == Fatality.config.vars[varName])
            btn.TextColor3 = isSelected and Color3.fromRGB(195, 44, 95) or Color3.fromRGB(220, 220, 220)
        end
    end

    updateDisplay()

    local optionsFrame = Instance.new("Frame")
    optionsFrame.Size = UDim2.new(0.6575, 0, 0.25, 0)
    optionsFrame.Position = UDim2.new(0.0175, 0, 0.93, 0)
    optionsFrame.BackgroundColor3 = Color3.fromRGB(20, 15, 45)
    optionsFrame.Visible = false
    optionsFrame.ZIndex = 103
    optionsFrame.BackgroundTransparency = 1
    optionsFrame.Parent = comboFrame

    local FoptionsFrame = Instance.new("Frame")
    FoptionsFrame.Size = UDim2.new(0.6575, 0, #options * 0.56, 0)
    FoptionsFrame.Position = UDim2.new(0.0175, 0, 0.93, 0)
    FoptionsFrame.BackgroundColor3 = Color3.fromRGB(21, 15, 45)
    FoptionsFrame.Visible = false
    FoptionsFrame.ZIndex = 104
    FoptionsFrame.Parent = comboFrame

    local layout = Instance.new("UIListLayout")
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = optionsFrame

    for _, opt in ipairs(options) do
        local optButton = Instance.new("TextButton")
        optButton.Size = UDim2.new(1, 0, 2.25, 0)
        optButton.BackgroundTransparency = 0.5
        optButton.BackgroundColor3 = Color3.fromRGB(20, 15, 45)
        optButton.Font = Enum.Font.GothamBold
        optButton.TextSize = 13
        optButton.TextXAlignment = Enum.TextXAlignment.Left
        optButton.ClipsDescendants = true
        optButton.ZIndex = 105
        optButton.Parent = optionsFrame
        optButton:SetAttribute("Option", opt)
        optButton.Text = anpassText(opt, optButton.AbsoluteSize.X * 0.95, "...")

        local function updateButtonStyle()
            local selected = Fatality.config.vars[varName]
            local isSelected = moresave and table.find(selected, opt) or (opt == selected)
            optButton.TextColor3 = isSelected and Color3.fromRGB(195, 44, 95) or Color3.fromRGB(220, 220, 220)
        end

        updateButtonStyle()

        optButton.MouseEnter:Connect(function()
            if Fatality.ui.ColorPanel then return end
            local selected = Fatality.config.vars[varName]
            local isSelected = moresave and table.find(selected, opt) or (opt == selected)
            if isSelected then
                optButton.TextColor3 = Color3.fromRGB(150, 22, 49)
            else
                optButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            end
        end)

        optButton.MouseLeave:Connect(function()
            updateButtonStyle()
        end)

        optButton.MouseButton1Click:Connect(function()
            if Fatality.ui.ColorPanel then return end
            if moresave then
                local selected = Fatality.config.vars[varName]
                local index = table.find(selected, opt)
                if index then
                    table.remove(selected, index)
                else
                    table.insert(selected, opt)
                end
            else
                Fatality.config.vars[varName] = opt
            end
            updateDisplay()
            optionsFrame.Visible = false
            FoptionsFrame.Visible = false
            optionsFrame.Parent = comboFrame
            FoptionsFrame.Parent = comboFrame
            isOpen = false
            updateStrokeColor()
            arrow.Text = "▼"
        end)

        table.insert(optionButtons, optButton)
    end

    if not Fatality.ui.DropdownContainer then
        local screenGui = parent
        while screenGui and not screenGui:IsA("ScreenGui") do
            screenGui = screenGui.Parent
        end
        if screenGui then
            Fatality.ui.DropdownContainer = Instance.new("Frame")
            Fatality.ui.DropdownContainer.Size = UDim2.new(1, 0, 1, 0)
            Fatality.ui.DropdownContainer.Position = UDim2.new(0, 0, 0, 0)
            Fatality.ui.DropdownContainer.BackgroundTransparency = 1
            Fatality.ui.DropdownContainer.ClipsDescendants = false
            Fatality.ui.DropdownContainer.ZIndex = 99
            Fatality.ui.DropdownContainer.Name = "DropdownContainer"
            Fatality.ui.DropdownContainer.Parent = screenGui
        end
    end

    local function updateDropdownPosition()
        if isOpen and Fatality.ui.DropdownContainer then
            local comboAbsPos = comboFrame.AbsolutePosition
            local comboAbsSize = comboFrame.AbsoluteSize
            local offsetX = comboAbsPos.X + (comboAbsSize.X * 0.013)
            local offsetY = comboAbsPos.Y + (comboAbsSize.Y * 2.1)
            local optionsWidth = comboAbsSize.X * 0.6575
            local optionsHeight = comboAbsSize.Y * 0.25
            local fOptionsHeight = comboAbsSize.Y * (#options * 0.56)

            optionsFrame.Size = UDim2.new(0, optionsWidth, 0, optionsHeight)
            FoptionsFrame.Size = UDim2.new(0, optionsWidth, 0, fOptionsHeight)
            optionsFrame.Position = UDim2.new(0, offsetX, 0, offsetY)
            FoptionsFrame.Position = UDim2.new(0, offsetX, 0, offsetY)
            optionsFrame.Visible = isOpen
            FoptionsFrame.Visible = isOpen
        end
    end

    if not Fatality.ui.ActiveComboBoxes then
        Fatality.ui.ActiveComboBoxes = {}
    end

    local function closeComboBox()
        if isOpen then
            optionsFrame.Visible = false
            FoptionsFrame.Visible = false
            optionsFrame.Parent = comboFrame
            FoptionsFrame.Parent = comboFrame
            optionsFrame.Size = UDim2.new(0.6575, 0, 0.25, 0)
            FoptionsFrame.Size = UDim2.new(0.6575, 0, #options * 0.56, 0)
            optionsFrame.Position = UDim2.new(0.0175, 0, 0.93, 0)
            FoptionsFrame.Position = UDim2.new(0.0175, 0, 0.93, 0)
            isOpen = false
            arrow.Text = "▼"
            updateStrokeColor()
        end
    end

    local comboBoxData = {
        comboFrame = comboFrame,
        isOpen = function() return isOpen end,
        setOpen = function(value) isOpen = value end,
        optionsFrame = optionsFrame,
        FoptionsFrame = FoptionsFrame,
        arrow = arrow,
        updateStrokeColor = updateStrokeColor,
        close = closeComboBox
    }
    table.insert(Fatality.ui.ActiveComboBoxes, comboBoxData)

    dropdown.MouseButton1Click:Connect(function()
        if Fatality.ui.ColorPanel then return end
        for _, otherComboBox in ipairs(Fatality.ui.ActiveComboBoxes) do
            if otherComboBox.comboFrame ~= comboFrame and otherComboBox.isOpen() then
                otherComboBox.close()
            end
        end

        isOpen = not isOpen
        if isOpen and Fatality.ui.DropdownContainer then
            optionsFrame.Parent = Fatality.ui.DropdownContainer
            FoptionsFrame.Parent = Fatality.ui.DropdownContainer
            updateDropdownPosition()
        else
            optionsFrame.Parent = comboFrame
            FoptionsFrame.Parent = comboFrame
            optionsFrame.Size = UDim2.new(0.6575, 0, 0.25, 0)
            FoptionsFrame.Size = UDim2.new(0.6575, 0, #options * 0.56, 0)
            optionsFrame.Position = UDim2.new(0.0175, 0, 0.93, 0)
            FoptionsFrame.Position = UDim2.new(0.0175, 0, 0.93, 0)
            optionsFrame.Visible = false
            FoptionsFrame.Visible = false
        end
        arrow.Text = isOpen and "▲" or "▼"
        updateStrokeColor()
    end)

    local scrollFrame = comboFrame.Parent
    if scrollFrame and scrollFrame:IsA("ScrollingFrame") then
        scrollFrame:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
            if isOpen then
                optionsFrame.Visible = false
                FoptionsFrame.Visible = false
                isOpen = false
                arrow.Text = "▼"
                updateStrokeColor()
            end
        end)
    end

    if Menuframe then
        Menuframe:GetPropertyChangedSignal("Visible"):Connect(function()
            if isOpen and not Menuframe.Visible then
                optionsFrame.Visible = false
                FoptionsFrame.Visible = false
                optionsFrame.Parent = comboFrame
                FoptionsFrame.Parent = comboFrame
                optionsFrame.Size = UDim2.new(0.6575, 0, 0.25, 0)
                FoptionsFrame.Size = UDim2.new(0.6575, 0, #options * 0.56, 0)
                optionsFrame.Position = UDim2.new(0.0175, 0, 0.93, 0)
                FoptionsFrame.Position = UDim2.new(0.0175, 0, 0.93, 0)
                isOpen = false
                arrow.Text = "▼"
                updateStrokeColor()
            end
        end)
    end

    if not Fatality.ui.AllComboBoxes then
        Fatality.ui.AllComboBoxes = {}
    end
    table.insert(Fatality.ui.AllComboBoxes, updateDisplay)
    return comboFrame
end

function Fatality.ui.ColorPicker(name, varName, parent)
    local pickerFrame = Instance.new("Frame")
    pickerFrame.Size = UDim2.new(0, 289, 0.0, 48)
    pickerFrame.BackgroundTransparency = 1
    pickerFrame.ZIndex = 103
    pickerFrame.Parent = parent

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.5, 0, 1, 0)
    label.Position = UDim2.new(0, 0, -0.05, 0)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = Color3.new(1, 1, 1)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 12.5
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 103
    label.Parent = pickerFrame

    if not Fatality.config.colors[varName] or typeof(Fatality.config.colors[varName]) ~= "Color3" then
        Fatality.config.colors[varName] = Color3.new(1, 1, 1)
    end
    if not Fatality.config.colors.alpha then
        Fatality.config.colors.alpha = {}
    end
    if not Fatality.config.colors.alpha[varName] then
        Fatality.config.colors.alpha[varName] = 1
    end

    local colorButton = Instance.new("TextButton")
    colorButton.Size = UDim2.new(0.2, 0, 0.4, 0)
    colorButton.Position = UDim2.new(0.85, 0, 0.25, 0)
    colorButton.BackgroundColor3 = Fatality.config.colors[varName]
    colorButton.BackgroundTransparency = 1 - Fatality.config.colors.alpha[varName]
    colorButton.Text = ""
    colorButton.ZIndex = 103
    colorButton.Parent = pickerFrame

    local function updateDisplay()
        if not Fatality.config.colors[varName] or typeof(Fatality.config.colors[varName]) ~= "Color3" then
            Fatality.config.colors[varName] = Color3.new(1, 1, 1)
        end
        if not Fatality.config.colors.alpha[varName] then
            Fatality.config.colors.alpha[varName] = 1
        end
        colorButton.BackgroundColor3 = Fatality.config.colors[varName]
        colorButton.BackgroundTransparency = 1 - Fatality.config.colors.alpha[varName]
        if Fatality.ui.ColorPanel then
            Fatality.ui.ColorPanel:Destroy()
            Fatality.ui.ColorPanel = nil
        end
        if Fatality.ui.ColorPanelBG then
            Fatality.ui.ColorPanelBG:Destroy()
            Fatality.ui.ColorPanelBG = nil
        end
    end

    updateDisplay()

    if not Fatality.ui.AllColorPickers then
        Fatality.ui.AllColorPickers = {}
    end
    table.insert(Fatality.ui.AllColorPickers, { updateDisplay = updateDisplay, frameStroke = nil, varName = varName })

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.221, 0, 0.555, 0)
    frame.Position = UDim2.new(0.84, 0, 0.17, 0)
    frame.BackgroundColor3 = Color3.fromRGB(29, 23, 60)
    frame.BackgroundTransparency = 1
    frame.ZIndex = 102
    frame.Parent = pickerFrame

    local frameStroke = Instance.new("UIStroke")
    frameStroke.Thickness = 1
    frameStroke.Color = Color3.fromRGB(29, 23, 60)
    frameStroke.Parent = frame
    Fatality.ui.AllColorPickers[#Fatality.ui.AllColorPickers].frameStroke = frameStroke

    local function animateStrokeColor(targetColor)
        local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tween = Fatality.TweenService:Create(frameStroke, tweenInfo, { Color = targetColor })
        tween:Play()
    end

    local function resetOtherPickers()
        for _, picker in ipairs(Fatality.ui.AllColorPickers) do
            if picker.frameStroke and picker.frameStroke ~= frameStroke then
                local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                local tween = Fatality.TweenService:Create(picker.frameStroke, tweenInfo, { Color = Color3.fromRGB(29, 23, 60) })
                tween:Play()
            end
        end
    end

    frame.MouseEnter:Connect(function()
        if not Fatality.ui.ColorPanel then
            animateStrokeColor(Color3.fromRGB(195, 44, 95))
        end
    end)

    frame.MouseLeave:Connect(function()
        if not Fatality.ui.ColorPanel then
            animateStrokeColor(Color3.fromRGB(29, 23, 60))
        end
    end)

    colorButton.MouseButton1Click:Connect(function()
        if Fatality.ui.ColorPanel and Fatality.ui.ActiveColorPicker == varName then
            Fatality.ui.ColorPanel:Destroy()
            Fatality.ui.ColorPanel = nil
            if Fatality.ui.ColorPanelBG then
                Fatality.ui.ColorPanelBG:Destroy()
                Fatality.ui.ColorPanelBG = nil
            end
            animateStrokeColor(Color3.fromRGB(29, 23, 60))
            Fatality.ui.ActiveColorPicker = nil
            return
        end

        if Fatality.ui.ColorPanel then
            Fatality.ui.ColorPanel:Destroy()
            Fatality.ui.ColorPanel = nil
        end
        if Fatality.ui.ColorPanelBG then
            Fatality.ui.ColorPanelBG:Destroy()
            Fatality.ui.ColorPanelBG = nil
        end

        for _, comboBox in ipairs(Fatality.ui.ActiveComboBoxes) do
            if comboBox.isOpen() then
                comboBox.close()
            end
        end

        resetOtherPickers()

        Fatality.ui.ActiveColorPicker = varName

        local btnPos = colorButton.AbsolutePosition
        local menuPos = Menuframe.AbsolutePosition
        local relX = btnPos.X - menuPos.X
        local relY = btnPos.Y - menuPos.Y

        local colorPanelBG = Instance.new("Frame")
        colorPanelBG.Size = UDim2.new(0, 241, 0, 264)
        colorPanelBG.Position = UDim2.new(0, relX + colorButton.AbsoluteSize.X + 2, 0, relY - 5)
        colorPanelBG.BackgroundColor3 = Color3.fromRGB(29, 23, 60)
        colorPanelBG.BorderSizePixel = 0
        colorPanelBG.ZIndex = 103
        colorPanelBG.Parent = Menuframe 
        Fatality.ui.ColorPanelBG = colorPanelBG

        colorPanelBG.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
            end
        end)

        local colorPanel = Instance.new("Frame")
        colorPanel.Size = UDim2.new(0, 235, 0, 258)
        colorPanel.Position = UDim2.new(0, relX + colorButton.AbsoluteSize.X + 5, 0, relY -2)
        colorPanel.BackgroundColor3 = Color3.fromRGB(35, 30, 71)
        colorPanel.BorderSizePixel = 0
        colorPanel.ZIndex = 104
        colorPanel.Parent = Menuframe 
        Fatality.ui.ColorPanel = colorPanel

        animateStrokeColor(Color3.fromRGB(195, 44, 95))

        local currentHue, currentSat, currentVal = Fatality.config.colors[varName]:ToHSV()
        local currentAlpha = Fatality.config.colors.alpha[varName]

        local brightnessSlider = Instance.new("Frame")
        brightnessSlider.Size = UDim2.new(0, 30, 0, 238)
        brightnessSlider.Position = UDim2.new(0, 10, 0, 10)
        brightnessSlider.BackgroundColor3 = Color3.new(1, 1, 1)
        brightnessSlider.BorderSizePixel = 0
        brightnessSlider.ZIndex = 105
        brightnessSlider.Parent = colorPanel

        local brightnessGradient = Instance.new("UIGradient")
        brightnessGradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromHSV(currentHue, currentSat, 1)),
            ColorSequenceKeypoint.new(1, Color3.fromHSV(currentHue, currentSat, 0))
        })
        brightnessGradient.Rotation = 90
        brightnessGradient.Parent = brightnessSlider

        local brightnessMarker = Instance.new("Frame")
        brightnessMarker.Size = UDim2.new(1, 0, 0, 4)
        brightnessMarker.BackgroundColor3 = Color3.fromRGB(195, 44, 95)
        brightnessMarker.BorderSizePixel = 0
        brightnessMarker.ZIndex = 106
        brightnessMarker.Parent = brightnessSlider

        local colorCube = Instance.new("Frame")
        colorCube.Size = UDim2.new(0, 175, 0, 175)
        colorCube.Position = UDim2.new(0, 50, 0, 10)
        colorCube.BackgroundColor3 = Color3.new(1, 1, 1)
        colorCube.BorderSizePixel = 0
        colorCube.ZIndex = 105
        colorCube.Parent = colorPanel

        local gradient = Instance.new("UIGradient")
        gradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromHSV(0, 1, 1)),
            ColorSequenceKeypoint.new(0.17, Color3.fromHSV(0.17, 1, 1)),
            ColorSequenceKeypoint.new(0.33, Color3.fromHSV(0.33, 1, 1)),
            ColorSequenceKeypoint.new(0.5, Color3.fromHSV(0.5, 1, 1)),
            ColorSequenceKeypoint.new(0.67, Color3.fromHSV(0.67, 1, 1)),
            ColorSequenceKeypoint.new(0.83, Color3.fromHSV(0.83, 1, 1)),
            ColorSequenceKeypoint.new(1, Color3.fromHSV(1, 1, 1))
        })
        gradient.Rotation = 0
        gradient.Parent = colorCube

        local overlay = Instance.new("Frame")
        overlay.Size = UDim2.new(1, 0, 1, 0)
        overlay.Position = UDim2.new(0, 0, 0, 0)
        overlay.BackgroundColor3 = Color3.new(1, 1, 1)
        overlay.BorderSizePixel = 0
        overlay.ZIndex = 106
        overlay.Parent = colorCube

        local overlayGradient = Instance.new("UIGradient")
        overlayGradient.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1),
            NumberSequenceKeypoint.new(1, 0)
        })
        overlayGradient.Rotation = 90
        overlayGradient.Parent = overlay

        local selectionMarker = Instance.new("Frame")
        selectionMarker.Size = UDim2.new(0, 8, 0, 8)
        selectionMarker.BackgroundTransparency = 0.3
        selectionMarker.BackgroundColor3 = Color3.fromRGB(195, 44, 95)
        selectionMarker.BorderSizePixel = 2
        selectionMarker.BorderColor3 = Color3.fromRGB(29, 23, 60)
        selectionMarker.ZIndex = 107
        selectionMarker.Parent = colorCube

        local alphalider = Instance.new("Frame")
        alphalider.Size = UDim2.new(0, 175, 0, 20)
        alphalider.Position = UDim2.new(0, 50, 0, 192)
        alphalider.BackgroundColor3 = Fatality.config.colors[varName]
        alphalider.BorderSizePixel = 0
        alphalider.ZIndex = 105
        alphalider.Parent = colorPanel

        local alphaGradient = Instance.new("UIGradient")
        alphaGradient.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1),
            NumberSequenceKeypoint.new(1, 0)
        })
        alphaGradient.Parent = alphalider

        local alphaMarker = Instance.new("Frame")
        alphaMarker.Size = UDim2.new(0, 4, 1, 0)
        alphaMarker.BackgroundColor3 = Color3.fromRGB(195, 44, 95)
        alphaMarker.BorderSizePixel = 0
        alphaMarker.ZIndex = 106
        alphaMarker.Parent = alphalider

        local colorTextEntry = Instance.new("TextBox")
        colorTextEntry.Size = UDim2.new(0, 175, 0, 25)
        colorTextEntry.Position = UDim2.new(0, 50, 0, 222)
        colorTextEntry.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
        colorTextEntry.TextColor3 = Color3.new(1, 1, 1)
        colorTextEntry.Font = Enum.Font.GothamBold
        colorTextEntry.TextSize = 14
        colorTextEntry.TextXAlignment = Enum.TextXAlignment.Center
        colorTextEntry.PlaceholderText = "R,G,B,A (0-255)"
        colorTextEntry.ZIndex = 105
        colorTextEntry.Parent = colorPanel
        colorTextEntry.ClearTextOnFocus = false

        local function updateTextEntry()
            local r = math.floor(Fatality.config.colors[varName].R * 255)
            local g = math.floor(Fatality.config.colors[varName].G * 255)
            local b = math.floor(Fatality.config.colors[varName].B * 255)
            local a = math.floor(Fatality.config.colors.alpha[varName] * 255)
            colorTextEntry.Text = string.format("%d,%d,%d,%d", r, g, b, a)
        end

        updateTextEntry()

        local function updateSelectionMarker()
            local selectedColor = Fatality.config.colors[varName]
            local h, s, v = selectedColor:ToHSV()
            local relX = h
            local relY = 1 - s
            selectionMarker.Position = UDim2.new(relX, -0, relY, -8)
        end

        local function updateBrightnessMarker()
            brightnessMarker.Position = UDim2.new(0, 0, 1 - currentVal, -0)
        end

        local function updateAlphaMarker()
            alphaMarker.Position = UDim2.new(currentAlpha, -4, 0, 0)
        end

        local function updateColor()
            local newColor = Color3.fromHSV(currentHue, currentSat, currentVal)
            Fatality.config.colors[varName] = newColor
            Fatality.config.colors.alpha[varName] = currentAlpha
            colorButton.BackgroundColor3 = newColor
            colorButton.BackgroundTransparency = 1 - Fatality.config.colors.alpha[varName]
            alphalider.BackgroundColor3 = newColor
            brightnessGradient.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromHSV(currentHue, currentSat, 1)),
                ColorSequenceKeypoint.new(1, Color3.fromHSV(currentHue, currentSat, 0))
            })
            updateSelectionMarker()
            updateBrightnessMarker()
            updateAlphaMarker()
            updateTextEntry()
        end

        local function parseTextEntry()
            local input = colorTextEntry.Text
            if input == "" then
                updateTextEntry()
                return
            end
            local r, g, b, a = input:match("^(%d+),(%d+),(%d+),(%d+)$")
            if r and g and b and a then
                r, g, b, a = tonumber(r), tonumber(g), tonumber(b), tonumber(a)
                if r >= 0 and r <= 255 and g >= 0 and g <= 255 and b >= 0 and b <= 255 and a >= 0 and a <= 255 then
                    Fatality.config.colors[varName] = Color3.fromRGB(r, g, b)
                    Fatality.config.colors.alpha[varName] = a / 255
                    currentHue, currentSat, currentVal = Fatality.config.colors[varName]:ToHSV()
                    currentAlpha = Fatality.config.colors.alpha[varName]
                    updateColor()
                    return
                end
            end
            updateTextEntry()
        end

        colorTextEntry.Focused:Connect(function()
            updateTextEntry()
        end)

        colorTextEntry.FocusLost:Connect(function(enterPressed)
            parseTextEntry()
        end)

        local brightnessDragging = false
        brightnessSlider.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                brightnessDragging = true
                local absPos = brightnessSlider.AbsolutePosition
                local absSize = brightnessSlider.AbsoluteSize
                local relY = math.clamp((input.Position.Y - absPos.Y) / absSize.Y, 0, 1)
                currentVal = 1 - relY
                updateColor()
            end
        end)
        brightnessSlider.InputChanged:Connect(function(input)
            if brightnessDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                local absPos = brightnessSlider.AbsolutePosition
                local absSize = brightnessSlider.AbsoluteSize
                local relY = math.clamp((input.Position.Y - absPos.Y) / absSize.Y, 0, 1)
                currentVal = 1 - relY
                updateColor()
            end
        end)
        brightnessSlider.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                brightnessDragging = false
            end
        end)

        local alphaDragging = false
        alphalider.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                alphaDragging = true
                local absPos = alphalider.AbsolutePosition
                local absSize = alphalider.AbsoluteSize
                local relX = math.clamp((input.Position.X - absPos.X) / absSize.X, 0, 1)
                currentAlpha = relX
                Fatality.config.colors.alpha[varName] = currentAlpha
                updateColor()
            end
        end)
        alphalider.InputChanged:Connect(function(input)
            if alphaDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                local absPos = alphalider.AbsolutePosition
                local absSize = alphalider.AbsoluteSize
                local relX = math.clamp((input.Position.X - absPos.X) / absSize.X, 0, 1)
                currentAlpha = relX
                Fatality.config.colors.alpha[varName] = currentAlpha
                updateColor()
            end
        end)
        alphalider.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                alphaDragging = false
            end
        end)

        local function pickColor(inputPos)
            local absPos = colorCube.AbsolutePosition
            local absSize = colorCube.AbsoluteSize
            local relX = math.clamp((inputPos.X - absPos.X) / absSize.X, 0, 1)
            local relY = math.clamp((inputPos.Y - absPos.Y) / absSize.Y, 0, 1)
            currentHue = relX
            currentSat = 1 - relY
            updateColor()
        end

        local cubeDragging = false
        colorCube.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                cubeDragging = true
                pickColor(input.Position)
            end
        end)
        colorCube.InputChanged:Connect(function(input)
            if cubeDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                pickColor(input.Position)
            end
        end)
        colorCube.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                cubeDragging = false
            end
        end)

        updateSelectionMarker()
        updateBrightnessMarker()
        updateAlphaMarker()
    end)

    if Menuframe then
        Menuframe:GetPropertyChangedSignal("Visible"):Connect(function()
            if not Menuframe.Visible then
                if Fatality.ui.ColorPanel then
                    Fatality.ui.ColorPanel:Destroy()
                    Fatality.ui.ColorPanel = nil
                end
                if Fatality.ui.ColorPanelBG then
                    Fatality.ui.ColorPanelBG:Destroy()
                    Fatality.ui.ColorPanelBG = nil
                end
                animateStrokeColor(Color3.fromRGB(29, 23, 60))
                Fatality.ui.ActiveColorPicker = nil
            end
        end)
    end

    return pickerFrame
end

function Fatality.ui.Slider(name, varName, min, max, dec, onChange, parent)
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Size = UDim2.new(0, 241, 0.0, 58)
    sliderFrame.BackgroundTransparency = 1
    sliderFrame.ZIndex = 100
    sliderFrame.Parent = parent

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
    titleLabel.Parent = sliderFrame

    local minusButton = Instance.new("TextButton")
    minusButton.Size = UDim2.new(0, 15, 0, 15)
    minusButton.Position = UDim2.new(0.64, 0, 0.025, 0) 
    minusButton.BackgroundTransparency = 1 
    minusButton.Text = "-"
    minusButton.TextColor3 = Color3.fromRGB(220, 220, 220) 
    minusButton.Font = Enum.Font.GothamBold
    minusButton.TextSize = 16
    minusButton.ZIndex = 100
    minusButton.Parent = sliderFrame

    local plusButton = Instance.new("TextButton")
    plusButton.Size = UDim2.new(0, 15, 0, 15)
    plusButton.Position = UDim2.new(0.71, 0, 0.025, 0) 
    plusButton.BackgroundTransparency = 1
    plusButton.Text = "+"
    plusButton.TextColor3 = Color3.fromRGB(220, 220, 220) 
    plusButton.Font = Enum.Font.GothamBold
    plusButton.TextSize = 16
    plusButton.ZIndex = 100
    plusButton.Parent = sliderFrame

    local track = Instance.new("Frame")
    track.Size = UDim2.new(0.73, 0, 0.3, 0)
    track.Position = UDim2.new(0.01, 0, 0.35, 0)
    track.BackgroundColor3 = Color3.fromRGB(29, 23, 60)
    track.BorderSizePixel = 0
    track.ZIndex = 100
    track.Parent = sliderFrame

    local sliderBorder = Instance.new("Frame")
    sliderBorder.Size = UDim2.new(0.75, 0, 0.40, 0)
    sliderBorder.Position = UDim2.new(0, 0, 0.3, 0)
    sliderBorder.BackgroundTransparency = 1
    sliderBorder.ZIndex = track.ZIndex - 1
    sliderBorder.Parent = sliderFrame

    local borderStroke = Instance.new("UIStroke")
    borderStroke.Thickness = 1
    borderStroke.Color = Color3.fromRGB(29, 23, 60)
    borderStroke.Parent = sliderBorder

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new(0, 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(195, 44, 95)
    fill.BorderSizePixel = 0
    fill.ZIndex = 101
    fill.Parent = track

    local valueLabel = Instance.new("TextLabel")
    valueLabel.Size = UDim2.new(0, 40, 0, 40)
    valueLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    valueLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
    valueLabel.BackgroundTransparency = 1
    valueLabel.Text = tostring(min)
    valueLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
    valueLabel.Font = Enum.Font.GothamBold
    valueLabel.TextSize = 12.5
    valueLabel.TextXAlignment = Enum.TextXAlignment.Center
    valueLabel.ZIndex = 102
    valueLabel.Parent = track

    if Fatality.config.vars[varName] == nil then
        Fatality.config.vars[varName] = min
    end

    local function updateDisplay(val)
        if not min or not max or type(min) ~= "number" or type(max) ~= "number" then
            return
        end
        if not val or type(val) ~= "number" then
            val = min
            Fatality.config.vars[varName] = min
        end
        local norm = (val - min) / (max - min)
        fill.Size = UDim2.new(norm, 0, 1, 0)
        valueLabel.Text = string.format("%." .. (dec or 0) .. "f", val)
    end

    updateDisplay(Fatality.config.vars[varName])

    local dragging = false
    local hovering = false

    local function updateValue(input)
        if Fatality.ui.ColorPanel then return end 
        local mouseX = input.Position.X - track.AbsolutePosition.X
        local width = track.AbsoluteSize.X
        local norm = math.clamp(mouseX / width, 0, 1)
        local newValue = min + norm * (max - min)
        newValue = math.floor(newValue * (10 ^ dec) + 0.5) / (10 ^ dec)
        Fatality.config.vars[varName] = newValue
        updateDisplay(newValue)
        if onChange then
            onChange(newValue)
        end
    end

    local function adjustValue(delta)
        if Fatality.ui.ColorPanel then return end 
        local range = max - min
        local step = range * 0.01
        local currentValue = Fatality.config.vars[varName]
        local newValue = currentValue + delta * step
        newValue = math.floor(newValue * (10 ^ dec) + 0.5) / (10 ^ dec)
        if dec == 0 and newValue == currentValue then
            newValue = math.clamp(currentValue + delta, min, max)
        else
            newValue = math.clamp(newValue, min, max)
        end
        Fatality.config.vars[varName] = newValue
        updateDisplay(newValue)
        if onChange then
            onChange(newValue)
        end
    end

    minusButton.MouseButton1Click:Connect(function()
        if Fatality.ui.ColorPanel then return end 
        adjustValue(-1)
    end)

    plusButton.MouseButton1Click:Connect(function()
        if Fatality.ui.ColorPanel then return end 
        adjustValue(1)
    end)

    local function animateBorderColor(targetColor)
        if Fatality.ui.ColorPanel then return end 
        local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tween = Fatality.TweenService:Create(borderStroke, tweenInfo, {Color = targetColor})
        tween:Play()
    end

    track.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 and not Fatality.ui.ColorPanel then
            dragging = true
            animateBorderColor(Color3.fromRGB(195, 44, 95))
            updateValue(input)
        end
    end)

    Fatality.UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 and dragging then
            dragging = false
            if not hovering then
                animateBorderColor(Color3.fromRGB(29, 23, 60))
            end
        end
    end)

    Fatality.UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement and not Fatality.ui.ColorPanel then
            updateValue(input)
        end
    end)

    track.MouseEnter:Connect(function()
        hovering = true
        if not dragging then
            animateBorderColor(Color3.fromRGB(195, 44, 95))
        end
    end)

    track.MouseLeave:Connect(function()
        hovering = false
        if not dragging then
            animateBorderColor(Color3.fromRGB(29, 23, 60))
        end
    end)

    if not Fatality.ui.AllSliders then
        Fatality.ui.AllSliders = {}
    end
    table.insert(Fatality.ui.AllSliders, function()
        updateDisplay(Fatality.config.vars[varName])
    end)

    return sliderFrame
end

function Fatality.ui.Bind(name, varName, parent)
    local bindFrame = Instance.new("Frame")
    bindFrame.Size = UDim2.new(0, 241, 0, 58)
    bindFrame.BackgroundTransparency = 1
    bindFrame.ZIndex = 100
    bindFrame.Parent = parent

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, 0, 0.3, 0)
    titleLabel.Position = UDim2.new(0, 0, 0.1, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = name
    titleLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 12.5
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.ZIndex = 100
    titleLabel.Parent = bindFrame

    local bindButton = Instance.new("TextButton")
    bindButton.Size = UDim2.new(0.22, 0, 0.3, 0)
    bindButton.Position = UDim2.new(1.025, 0, 0.1, 0)
    bindButton.BackgroundColor3 = Color3.fromRGB(29, 23, 60)
    bindButton.TextColor3 = Color3.fromRGB(220, 220, 220)
    bindButton.Text = "NONE"
    bindButton.ZIndex = 100
    bindButton.Parent = bindFrame

    local border = Instance.new("Frame")
    border.Size = bindButton.Size + UDim2.new(0.025, 0, 0.11, 0)
    border.Position = bindButton.Position - UDim2.new(0.012, 0, 0.05, 0)
    border.BackgroundTransparency = 1
    border.ZIndex = bindButton.ZIndex - 1
    border.Parent = bindFrame

    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 1
    stroke.Color = Color3.fromRGB(29, 23, 60)
    stroke.Parent = border

    local function animateBorderColor(color)
        local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tween = Fatality.TweenService:Create(stroke, tweenInfo, {Color = color})
        tween:Play()
    end

    local function updateBind()
        local key = Fatality.config.binds[varName]
        if key then
            local keyName = key.Name
            if keyName:match("Keypad") then
                if keyName == "KeypadZero" then
                    bindButton.Text = "NUM0"
                elseif keyName == "KeypadOne" then
                    bindButton.Text = "NUM1"
                elseif keyName == "KeypadTwo" then
                    bindButton.Text = "NUM2"
                elseif keyName == "KeypadThree" then
                    bindButton.Text = "NUM3"
                elseif keyName == "KeypadFour" then
                    bindButton.Text = "NUM4"
                elseif keyName == "KeypadFive" then
                    bindButton.Text = "NUM5"
                elseif keyName == "KeypadSix" then
                    bindButton.Text = "NUM6"
                elseif keyName == "KeypadSeven" then
                    bindButton.Text = "NUM7"
                elseif keyName == "KeypadEight" then
                    bindButton.Text = "NUM8"
                elseif keyName == "KeypadNine" then
                    bindButton.Text = "NUM9"
                else
                    bindButton.Text = keyName
                end
            elseif keyName == "MouseButton1" then
                bindButton.Text = "MB1"
            elseif keyName == "MouseButton2" then
                bindButton.Text = "MB2"
            elseif keyName == "MouseButton3" then
                bindButton.Text = "MB3"
            elseif keyName == "MouseButton4" then
                bindButton.Text = "MB4"
            elseif keyName == "MouseButton5" then
                bindButton.Text = "MB5"
            else
                bindButton.Text = keyName
            end
        else
            bindButton.Text = "NONE"
        end
    end

    updateBind()

    local binding = false
    local hovering = false
    local animating = false

    local function startDotAnimation()
        if animating then return end
        animating = true
        task.spawn(function()
            local dots = {".", "..", "..."}
            local index = 1
            while binding do
                bindButton.Text = dots[index]
                index = index % #dots + 1
                task.wait(0.5)
            end
            if not binding then
                updateBind()
            end
            animating = false
        end)
    end

    bindButton.MouseEnter:Connect(function()
        hovering = true
        if not binding then
            animateBorderColor(Color3.fromRGB(195, 44, 95))
        end
    end)

    bindButton.MouseLeave:Connect(function()
        hovering = false
        if not binding then
            animateBorderColor(Color3.fromRGB(29, 23, 60))
        end
    end)

    bindButton.MouseButton1Click:Connect(function()
        if binding then return end
        binding = true
        animateBorderColor(Color3.fromRGB(195, 44, 95))
        startDotAnimation()
        local conn
        conn = Fatality.UserInputService.InputBegan:Connect(function(input, gameProcessed)
            if binding then
                if input.UserInputType == Enum.UserInputType.Keyboard then
                    local key = input.KeyCode
                    Fatality.config.binds[varName] = key
                    binding = false
                    updateBind()
                    local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                    local tween = Fatality.TweenService:Create(stroke, tweenInfo, {Color = hovering and Color3.fromRGB(195, 44, 95) or Color3.fromRGB(29, 23, 60)})
                    tween:Play()
                    conn:Disconnect()
                elseif input.UserInputType == Enum.UserInputType.MouseButton1 or
                       input.UserInputType == Enum.UserInputType.MouseButton2 or
                       input.UserInputType == Enum.UserInputType.MouseButton3 or
                       input.UserInputType == Enum.UserInputType.MouseButton4 or
                       input.UserInputType == Enum.UserInputType.MouseButton5 then
                    local key = input.UserInputType
                    Fatality.config.binds[varName] = key
                    binding = false
                    updateBind()
                    local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                    local tween = Fatality.TweenService:Create(stroke, tweenInfo, {Color = hovering and Color3.fromRGB(195, 44, 95) or Color3.fromRGB(29, 23, 60)})
                    tween:Play()
                    conn:Disconnect()
                end
            end
        end)
    end)

    bindButton.MouseButton2Click:Connect(function()
        Fatality.config.binds[varName] = nil
        binding = false
        updateBind()
        animateBorderColor(hovering and Color3.fromRGB(195, 44, 95) or Color3.fromRGB(29, 23, 60))
    end)

    Fatality.UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        local currentBind = Fatality.config.binds[varName]
        if currentBind and (input.KeyCode == currentBind or input.UserInputType == currentBind) then
            if Fatality.ui.AllCheckBoxes then
                for _, updateCheckbox in ipairs(Fatality.ui.AllCheckBoxes) do
                    updateCheckbox()
                end
            end
        end
    end)

    if not Fatality.ui.AllBinds then
        Fatality.ui.AllBinds = {}
    end
    table.insert(Fatality.ui.AllBinds, updateBind)

    return bindFrame
end

local function encodeColor(color, alpha)
    return { r = color.R, g = color.G, b = color.B, a = alpha }
end

local function decodeColor(colorTable)
    return Color3.new(colorTable.r, colorTable.g, colorTable.b), colorTable.a or 1
end

function Fatality.ui.ConfigManager(parent)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 291, 1, 0)
    frame.BackgroundTransparency = 1
    frame.ZIndex = 100
    frame.ClipsDescendants = true
    frame.Parent = parent

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0.2, 0)
    title.Position = UDim2.new(-0.28, 0, -0.05, 0)
    title.Text = "Config Manager"
    title.TextColor3 = Color3.new(1, 1, 1)
    title.Font = Enum.Font.SourceSansBold
    title.TextSize = 18
    title.BackgroundTransparency = 1
    title.ZIndex = 100
    title.Parent = frame

    local nameInput = Instance.new("TextBox")
    nameInput.Size = UDim2.new(0.75, 0, 0.08, 0)
    nameInput.Position = UDim2.new(0.0, 0, 0.1, 0)
    nameInput.Text = "default"
    nameInput.PlaceholderText = "Введите имя конфига"
    nameInput.TextColor3 = Color3.new(1, 1, 1)
    nameInput.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
    nameInput.Font = Enum.Font.GothamBold
    nameInput.TextSize = 18
    nameInput.ClearTextOnFocus = false
    nameInput.TextTruncate = Enum.TextTruncate.AtEnd
    nameInput.ZIndex = 100
    nameInput.Parent = frame

    local saveButton = Instance.new("TextButton")
    saveButton.Size = UDim2.new(0.2, 0, 0.08, 0)
    saveButton.Position = UDim2.new(0.8, 0, 0.1, 0)
    saveButton.Text = "Save"
    saveButton.BackgroundColor3 = Color3.fromRGB(40, 80, 40)
    saveButton.Font = Enum.Font.GothamBold
    saveButton.TextSize = 18
    saveButton.TextColor3 = Color3.new(1, 1, 1)
    saveButton.ZIndex = 100
    saveButton.Parent = frame

    saveButton.MouseButton1Click:Connect(function()
        local configName = nameInput.Text
        if configName and configName ~= "" then
            local folderPath = "Fatality"
            if not isfolder(folderPath) then
                makefolder(folderPath)
            end
            local path = folderPath .. "/" .. configName .. ".json"

            local configCopy = {}
            for key, value in pairs(Fatality.config) do
                if type(value) == "table" then
                    configCopy[key] = {}
                    for subkey, subvalue in pairs(value) do
                        configCopy[key][subkey] = subvalue
                    end
                else
                    configCopy[key] = value
                end
            end

            if configCopy.colors then
                local colorCopy = {}
                for key, color in pairs(configCopy.colors) do
                    if typeof(color) == "Color3" then
                        local alpha = configCopy.colors.alpha and configCopy.colors.alpha[key] or 1
                        colorCopy[key] = encodeColor(color, alpha)
                    else
                        colorCopy[key] = color
                    end
                end
                configCopy.colors = colorCopy
                configCopy.colors.alpha = configCopy.colors.alpha or {}
            end

            if configCopy.binds then
                local bindCopy = {}
                for key, bind in pairs(configCopy.binds) do
                    if typeof(bind) == "EnumItem" then
                        bindCopy[key] = bind.Name
                    else
                        bindCopy[key] = bind
                    end
                end
                configCopy.binds = bindCopy
            end

            local configData = Fatality.HttpService:JSONEncode(configCopy)
            writefile(path, configData)
        else
            warn("Введите корректное имя конфига!")
        end
    end)

    local dropdown = Instance.new("TextButton")
    dropdown.Size = UDim2.new(0.75, 0, 0.08, 0)
    dropdown.Position = UDim2.new(0.0, 0, 0.2, 0)
    dropdown.Text = "Выберите конфиг"
    dropdown.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
    dropdown.Font = Enum.Font.GothamBold
    dropdown.TextSize = 18
    dropdown.TextColor3 = Color3.new(1, 1, 1)
    dropdown.TextTruncate = Enum.TextTruncate.AtEnd
    dropdown.ZIndex = 100
    dropdown.Parent = frame

    local configListFrame = Instance.new("Frame")
    configListFrame.Size = UDim2.new(0.75, 0, 0.055, 0)
    configListFrame.Position = UDim2.new(0.0, 0, 0.28, 0)
    configListFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
    configListFrame.Visible = false
    configListFrame.ZIndex = 101
    configListFrame.Parent = frame

    local listLayout = Instance.new("UIListLayout")
    listLayout.Parent = configListFrame
    listLayout.Padding = UDim.new(0, 1)
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder

    dropdown.MouseButton1Click:Connect(function()
        configListFrame.Visible = not configListFrame.Visible
        if configListFrame.Visible then
            for _, child in ipairs(configListFrame:GetChildren()) do
                if child:IsA("TextButton") then
                    child:Destroy()
                end
            end
            if isfolder("Fatality") then
                local files = listfiles("Fatality")
                for _, file in ipairs(files) do
                    local configName = file:match("([^/\\]+)%.json$")
                    if configName then
                        local btn = Instance.new("TextButton")
                        btn.Size = UDim2.new(1, 0, 0, 25)
                        btn.BackgroundColor3 = Color3.fromRGB(35, 35, 55)
                        btn.Text = configName
                        btn.Font = Enum.Font.GothamBold
                        btn.TextSize = 16
                        btn.TextColor3 = Color3.new(1, 1, 1)
                        btn.ZIndex = 101
                        btn.Parent = configListFrame
                        btn.MouseButton1Click:Connect(function()
                            dropdown.Text = configName
                            configListFrame.Visible = false
                        end)
                    end
                end
            else
                dropdown.Text = "Папка не найдена"
            end
        end
    end)

    local loadButton = Instance.new("TextButton")
    loadButton.Size = UDim2.new(0.2, 0, 0.08, 0)
    loadButton.Position = UDim2.new(0.8, 0, 0.2, 0)
    loadButton.Text = "Load"
    loadButton.BackgroundColor3 = Color3.fromRGB(80, 40, 40)
    loadButton.Font = Enum.Font.GothamBold
    loadButton.TextSize = 18
    loadButton.TextColor3 = Color3.new(1, 1, 1)
    loadButton.ZIndex = 100
    loadButton.Parent = frame

    loadButton.MouseButton1Click:Connect(function()
        local selectedConfig = dropdown.Text
        if selectedConfig and selectedConfig ~= "Выберите конфиг" then
            local path = "Fatality/" .. selectedConfig .. ".json"
            if isfile(path) then
                local data = readfile(path)
                local loadedConfig = Fatality.HttpService:JSONDecode(data)

                if loadedConfig.colors then
                    local colorTable = {}
                    local alphaTable = loadedConfig.colors.alpha or {}
                    for key, color in pairs(loadedConfig.colors) do
                        if type(color) == "table" and color.r and color.g and color.b then
                            local decodedColor, decodedAlpha = decodeColor(color)
                            colorTable[key] = decodedColor
                            alphaTable[key] = decodedAlpha
                        else
                            colorTable[key] = color
                        end
                    end
                    loadedConfig.colors = colorTable
                    loadedConfig.colors.alpha = alphaTable
                end

                if loadedConfig.binds then
                    for key, bind in pairs(loadedConfig.binds) do
                        if type(bind) == "string" then
                            if bind:match("MouseButton") then
                                loadedConfig.binds[key] = Enum.UserInputType[bind]
                            else
                                loadedConfig.binds[key] = Enum.KeyCode[bind] or nil
                            end
                        end
                    end
                end

                Fatality.config = loadedConfig

                if Fatality.ui.AllComboBoxes then
                    for _, updateDisplay in ipairs(Fatality.ui.AllComboBoxes) do
                        updateDisplay()
                    end
                end
                if Fatality.ui.AllSliders then
                    for _, updateSlider in ipairs(Fatality.ui.AllSliders) do
                        updateSlider()
                    end
                end
                if Fatality.ui.AllCheckBoxes then
                    for _, updateCheckbox in ipairs(Fatality.ui.AllCheckBoxes) do
                        updateCheckbox()
                    end
                end
                if Fatality.ui.AllColorPickers then
                    for _, picker in ipairs(Fatality.ui.AllColorPickers) do
                        picker.updateDisplay()
                    end
                end
                if Fatality.ui.AllBinds then
                    for _, updateBind in ipairs(Fatality.ui.AllBinds) do
                        updateBind()
                    end
                end
                if Fatality.ui.AllTextEntries then
                    for _, updateTextEntry in ipairs(Fatality.ui.AllTextEntries) do
                        updateTextEntry()
                    end
                end
            else
                warn("Конфиг не найден!")
            end
        else
            warn("Выберите конфиг для загрузки!")
        end
    end)

    return frame
end

function Fatality.ui.TextEntry(name, varName, parent)
    local textEntryFrame = Instance.new("Frame")
    textEntryFrame.Size = UDim2.new(0, 241, 0.0, 58)
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

    local textBoxBorder = Instance.new("Frame")
    textBoxBorder.Size = UDim2.new(0.75, 0, 0.45, 0)
    textBoxBorder.Position = UDim2.new(0, 0, 0.3, 0)
    textBoxBorder.BackgroundTransparency = 1
    textBoxBorder.ZIndex = 99
    textBoxBorder.Parent = textEntryFrame

    local borderStroke = Instance.new("UIStroke")
    borderStroke.Thickness = 1
    borderStroke.Color = Color3.fromRGB(29, 23, 60)
    borderStroke.Parent = textBoxBorder

    local textBox = Instance.new("TextBox")
    textBox.Size = UDim2.new(0.73, 0, 0.35, 0)
    textBox.Position = UDim2.new(0.01, 0, 0.35, 0)
    textBox.BackgroundColor3 = Color3.fromRGB(29, 23, 60)
    textBox.TextColor3 = Color3.fromRGB(220, 220, 220)
    textBox.Font = Enum.Font.GothamBold
    textBox.TextSize = 15
    textBox.TextXAlignment = Enum.TextXAlignment.Left
    textBox.Text = Fatality.config.vars[varName] or ""
    textBox.PlaceholderText = ""
    textBox.PlaceholderColor3 = Color3.fromRGB(100, 100, 100)
    textBox.ClearTextOnFocus = false
    textBox.TextTruncate = Enum.TextTruncate.AtEnd 
    textBox.ClipsDescendants = true 
    textBox.ZIndex = 100
    textBox.Parent = textEntryFrame

    local textPadding = Instance.new("UIPadding")
    textPadding.PaddingLeft = UDim.new(0, 8) 
    textPadding.Parent = textBox

    if Fatality.config.vars[varName] == nil then
        Fatality.config.vars[varName] = ""
    end

    local isHovering = false
    local isFocused = false

    local function updateVisual()
        local targetColor = (isHovering or isFocused) and Color3.fromRGB(195, 44, 95) or Color3.fromRGB(29, 23, 60)
        local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tween = Fatality.TweenService:Create(borderStroke, tweenInfo, {Color = targetColor})
        tween:Play()
    end

    updateVisual()

    textBox.MouseEnter:Connect(function()
        isHovering = true
        updateVisual()
    end)

    textBox.MouseLeave:Connect(function()
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
            Fatality.config.vars[varName] = textBox.Text
        end
    end)

    textBox:GetPropertyChangedSignal("Text"):Connect(function()
        if isFocused then
            textBox.CursorPosition = #textBox.Text + 1
        end
    end)

    if not Fatality.ui.AllTextEntries then
        Fatality.ui.AllTextEntries = {}
    end
    table.insert(Fatality.ui.AllTextEntries, function()
        textBox.Text = Fatality.config.vars[varName] or ""
        if not isFocused then
            textBox.TextTruncate = Enum.TextTruncate.AtEnd
        end
    end)

    return textEntryFrame
end

function Fatality.ui.ModelViewer(name, parent)
    local viewerFrame = Instance.new("Frame")
    viewerFrame.Size = UDim2.new(0, 241, 0, 200)
    viewerFrame.BackgroundTransparency = 1
    viewerFrame.ZIndex = 100
    viewerFrame.Parent = parent

    local viewport = Instance.new("ViewportFrame")
    viewport.Size = UDim2.new(1.05, 0, 1.85, 0)
    viewport.Position = UDim2.new(0.1, 2, 0.275, 4)
    viewport.BackgroundColor3 = Color3.fromRGB(29, 23, 60)
    viewport.ZIndex = 100
    viewport.Parent = viewerFrame

    local espFrame = Instance.new("Frame")
    espFrame.Size = UDim2.new(1.215, 0, 2, 0)
    espFrame.Position = UDim2.new(0.025, 0, 0.225, 0)
    espFrame.BackgroundTransparency = 1
    espFrame.ZIndex = 101
    espFrame.Parent = viewerFrame

    local nameLabel = Instance.new("TextLabel")
    nameLabel.BackgroundTransparency = 1
    nameLabel.TextColor3 = Fatality.config.colors["NameCol"]
    nameLabel.TextTransparency = 1 - (Fatality.config.colors.alpha["NameCol"] or 1)
    nameLabel.TextStrokeTransparency = 0
    nameLabel.TextSize = 11
    nameLabel.Font = Enum.Font.Ubuntu
    nameLabel.Visible = Fatality.config.vars["Name"]
    nameLabel.Size = UDim2.new(1, 0, 0.2, 0)
    nameLabel.Position = UDim2.new(0, 0, -0.15, 0)
    nameLabel.TextXAlignment = Enum.TextXAlignment.Center
    nameLabel.ZIndex = 101
    nameLabel.Text = name
    nameLabel.Parent = espFrame

    local teamLabel = Instance.new("TextLabel")
    teamLabel.BackgroundTransparency = 1
    teamLabel.TextColor3 = Fatality.config.colors["TeamCol"]
    teamLabel.TextTransparency = 1 - (Fatality.config.colors.alpha["TeamCol"] or 1)
    teamLabel.TextStrokeTransparency = 0
    teamLabel.TextSize = 11
    teamLabel.Font = Enum.Font.Ubuntu
    teamLabel.Visible = Fatality.config.vars["TeamPlayer"]
    teamLabel.Size = UDim2.new(0.5, 0, 0.2, 0)
    teamLabel.Position = UDim2.new(0.87, 1, 0, -25)
    teamLabel.TextXAlignment = Fatality.config.vars["TeamPos"] ~= 3 and Enum.TextXAlignment.Center or Enum.TextXAlignment.Left
    teamLabel.ZIndex = 101
    teamLabel.Text = "No Team"
    teamLabel.Parent = espFrame

    local weaponLabel = Instance.new("TextLabel")
    weaponLabel.BackgroundTransparency = 1
    weaponLabel.TextColor3 = Fatality.config.colors["WepPlayerCol"]
    weaponLabel.TextTransparency = 1 - (Fatality.config.colors.alpha["WepPlayerCol"] or 1)
    weaponLabel.TextStrokeTransparency = 0
    weaponLabel.TextSize = 11
    weaponLabel.Font = Enum.Font.Ubuntu
    weaponLabel.Visible = Fatality.config.vars["WeaponPlayer"]
    weaponLabel.Size = UDim2.new(1, 0, 0.2, 0)
    weaponLabel.Position = UDim2.new(0, 0, 0.94, 0)
    weaponLabel.TextXAlignment = Fatality.config.vars["WepPlayerPos"] ~= 3 and Enum.TextXAlignment.Center or Enum.TextXAlignment.Left
    weaponLabel.ZIndex = 101
    weaponLabel.Text = "No Tool"
    weaponLabel.Parent = espFrame

    local distanceLabel = Instance.new("TextLabel")
    distanceLabel.BackgroundTransparency = 1
    distanceLabel.TextColor3 = Fatality.config.colors["DistancePlayerCol"]
    distanceLabel.TextTransparency = 1 - (Fatality.config.colors.alpha["DistancePlayerCol"] or 1)
    distanceLabel.TextStrokeTransparency = 0
    distanceLabel.TextSize = 11
    distanceLabel.Font = Enum.Font.Ubuntu
    distanceLabel.Visible = Fatality.config.vars["DistancePlayer"]
    distanceLabel.Size = UDim2.new(1, 0, 0.2, 0)
    distanceLabel.Position = UDim2.new(0, 0, 0.99, 0)
    distanceLabel.TextXAlignment = Fatality.config.vars["DistancePlayerPos"] ~= 3 and Enum.TextXAlignment.Center or Enum.TextXAlignment.Left
    distanceLabel.ZIndex = 101
    distanceLabel.Text = "150m"
    distanceLabel.Parent = espFrame

    local healthLabel = Instance.new("TextLabel")
    healthLabel.BackgroundTransparency = 1
    healthLabel.TextColor3 = Fatality.config.colors["HealthPlayerCol"]
    healthLabel.TextTransparency = 1 - (Fatality.config.colors.alpha["HealthPlayerCol"] or 1)
    healthLabel.TextStrokeTransparency = 0
    healthLabel.TextSize = 11
    healthLabel.Font = Enum.Font.Ubuntu
    healthLabel.Visible = Fatality.config.vars["HealthPlayer"]
    healthLabel.Size = UDim2.new(0.345, 0, 0.05, 0)
    healthLabel.TextXAlignment = Fatality.config.vars["HealthPos"] ~= 3 and Enum.TextXAlignment.Center or Enum.TextXAlignment.Left
    healthLabel.ZIndex = 101
    healthLabel.Text = "100"
    healthLabel.Parent = espFrame

    local healthSliderBG = Instance.new("Frame")
    healthSliderBG.BackgroundColor3 = Color3.fromRGB(56, 56, 56)
    healthSliderBG.BackgroundTransparency = 1 - (Fatality.config.colors.alpha["HealthPlayerCol"] or 1)
    healthSliderBG.Visible = Fatality.config.vars["HealthPlayer"]
    healthSliderBG.Size = UDim2.new(0, 5, 0, 0)
    healthSliderBG.Position = UDim2.new(0, 0, 0, 0)
    healthSliderBG.ZIndex = 101
    healthSliderBG.Parent = espFrame

    local healthSlider = Instance.new("Frame")
    healthSlider.BackgroundColor3 = Fatality.config.colors["HealthPlayerCol"]
    healthSlider.BackgroundTransparency = 1 - (Fatality.config.colors.alpha["HealthPlayerCol"] or 1)
    healthSlider.Visible = Fatality.config.vars["HealthPlayer"]
    healthSlider.Size = UDim2.new(0, 5, 0, 0)
    healthSlider.Position = UDim2.new(0, 0, 0, 0)
    healthSlider.ZIndex = 102
    healthSlider.Parent = espFrame

    local espStroke = Instance.new("UIStroke")
    espStroke.Thickness = 2
    espStroke.Color = Fatality.config.colors["EspCol"]
    espStroke.Transparency = 1 - Fatality.config.colors.alpha["EspCol"]
    espStroke.Enabled = Fatality.config.vars["EspBox"] and (Fatality.config.vars["BoxStyle"] == "Default" or Fatality.config.vars["BoxStyle"] == "Box 3D")
    espStroke.Parent = espFrame

    local cornerLines = {
        TopLeft = Instance.new("Frame"),
        TopRight = Instance.new("Frame"),
        BottomLeft = Instance.new("Frame"),
        BottomRight = Instance.new("Frame"),
        LeftTop = Instance.new("Frame"),
        RightTop = Instance.new("Frame"),
        LeftBottom = Instance.new("Frame"),
        RightBottom = Instance.new("Frame")
    }
    for _, line in pairs(cornerLines) do
        line.BackgroundColor3 = Fatality.config.colors["EspCol"]
        line.BackgroundTransparency = 1 - Fatality.config.colors.alpha["EspCol"]
        line.Visible = false
        line.ZIndex = 101
        line.Parent = espFrame
    end

    local worldModel = Instance.new("WorldModel")
    worldModel.Parent = viewport

    local camera = Instance.new("Camera")
    camera.CFrame = CFrame.new(Vector3.new(0, 2, 4.8), Vector3.new(0, 2, 0))
    viewport.CurrentCamera = camera

    local cachedConfig = {
        EspBox = Fatality.config.vars["EspBox"],
        BoxStyle = Fatality.config.vars["BoxStyle"],
        EspCol = Fatality.config.colors["EspCol"],
        EspColAlpha = Fatality.config.colors.alpha["EspCol"],
        Name = Fatality.config.vars["Name"],
        NameCol = Fatality.config.colors["NameCol"],
        NameColAlpha = Fatality.config.colors.alpha["NameCol"],
        TeamPlayer = Fatality.config.vars["TeamPlayer"],
        TeamCol = Fatality.config.colors["TeamCol"],
        TeamColAlpha = Fatality.config.colors.alpha["TeamCol"],
        WeaponPlayer = Fatality.config.vars["WeaponPlayer"],
        WepPlayerCol = Fatality.config.colors["WepPlayerCol"],
        WepPlayerColAlpha = Fatality.config.colors.alpha["WepPlayerCol"],
        DistancePlayer = Fatality.config.vars["DistancePlayer"],
        DistancePlayerCol = Fatality.config.colors["DistancePlayerCol"],
        DistancePlayerColAlpha = Fatality.config.colors.alpha["DistancePlayerCol"],
        HealthPlayer = Fatality.config.vars["HealthPlayer"],
        HealthPlayerCol = Fatality.config.colors["HealthPlayerCol"],
        HealthPlayerColAlpha = Fatality.config.colors.alpha["HealthPlayerCol"],
        HealthPlayerCol2 = Fatality.config.colors["HealthPlayerCol2"],
        HealthPlayerCol2Alpha = Fatality.config.colors.alpha["HealthPlayerCol2"],
        HealthPos = Fatality.config.vars["HealthPos"]
    }

    local function updateEspStroke()
        local isEspEnabled = Fatality.config.vars["EspBox"]
        local boxStyle = Fatality.config.vars["BoxStyle"]
        espStroke.Enabled = isEspEnabled and (boxStyle == "Default" or boxStyle == "Box 3D")
        nameLabel.Visible = Fatality.config.vars["Name"]
        teamLabel.Visible = Fatality.config.vars["TeamPlayer"]
        weaponLabel.Visible = Fatality.config.vars["WeaponPlayer"]
        distanceLabel.Visible = Fatality.config.vars["DistancePlayer"]
        healthLabel.Visible = Fatality.config.vars["HealthPlayer"]
        healthSliderBG.Visible = Fatality.config.vars["HealthPlayer"]
        healthSlider.Visible = Fatality.config.vars["HealthPlayer"]
        for _, line in pairs(cornerLines) do
            line.Visible = isEspEnabled and boxStyle == "Corner"
        end

        espStroke.Color = Fatality.config.colors["EspCol"]
        espStroke.Transparency = 1 - (Fatality.config.colors.alpha["EspCol"] or 1)
        nameLabel.TextColor3 = Fatality.config.colors["NameCol"]
        nameLabel.TextTransparency = 1 - (Fatality.config.colors.alpha["NameCol"] or 1)
        teamLabel.TextColor3 = Fatality.config.colors["TeamCol"]
        teamLabel.TextTransparency = 1 - (Fatality.config.colors.alpha["TeamCol"] or 1)
        weaponLabel.TextColor3 = Fatality.config.colors["WepPlayerCol"]
        weaponLabel.TextTransparency = 1 - (Fatality.config.colors.alpha["WepPlayerCol"] or 1)
        distanceLabel.TextColor3 = Fatality.config.colors["DistancePlayerCol"]
        distanceLabel.TextTransparency = 1 - (Fatality.config.colors.alpha["DistancePlayerCol"] or 1)
        for _, line in pairs(cornerLines) do
            line.BackgroundColor3 = Fatality.config.colors["EspCol"]
            line.BackgroundTransparency = 1 - (Fatality.config.colors.alpha["EspCol"] or 1)
        end

        local fov = camera.FieldOfView
        local scale = math.clamp(70 / fov, 0.5, 1)
        espFrame.Size = UDim2.new(1.05 * scale, 0, 1.85 * scale, 0)
        espFrame.Position = UDim2.new(0.1 + 0.5 * (1.05 - 1.05 * scale), 2, 0.275 + 0.5 * (1.85 - 1.85 * scale), 4)

        if isEspEnabled and boxStyle == "Corner" then
            local boxWidth = viewport.AbsoluteSize.X * scale
            local boxHeight = viewport.AbsoluteSize.Y * scale
            local cornerLengthX = boxWidth * 0.25
            local cornerLengthY = boxHeight * 0.25
            local thickness = 2

            cornerLines.TopLeft.Size = UDim2.new(0, cornerLengthX, 0, thickness)
            cornerLines.TopLeft.Position = UDim2.new(0, 0, 0, 0)
            cornerLines.TopRight.Size = UDim2.new(0, cornerLengthX, 0, thickness)
            cornerLines.TopRight.Position = UDim2.new(0, boxWidth - cornerLengthX, 0, 0)
            cornerLines.BottomLeft.Size = UDim2.new(0, cornerLengthX, 0, thickness)
            cornerLines.BottomLeft.Position = UDim2.new(0, 0, 0, boxHeight - thickness)
            cornerLines.BottomRight.Size = UDim2.new(0, cornerLengthX, 0, thickness)
            cornerLines.BottomRight.Position = UDim2.new(0, boxWidth - cornerLengthX, 0, boxHeight - thickness)
            cornerLines.LeftTop.Size = UDim2.new(0, thickness, 0, cornerLengthY)
            cornerLines.LeftTop.Position = UDim2.new(0, 0, 0, 0)
            cornerLines.RightTop.Size = UDim2.new(0, thickness, 0, cornerLengthY)
            cornerLines.RightTop.Position = UDim2.new(0, boxWidth - thickness, 0, 0)
            cornerLines.LeftBottom.Size = UDim2.new(0, thickness, 0, cornerLengthY)
            cornerLines.LeftBottom.Position = UDim2.new(0, 0, 0, boxHeight - cornerLengthY)
            cornerLines.RightBottom.Size = UDim2.new(0, thickness, 0, cornerLengthY)
            cornerLines.RightBottom.Position = UDim2.new(0, boxWidth - thickness, 0, boxHeight - cornerLengthY)
        end

        cachedConfig.EspBox = Fatality.config.vars["EspBox"]
        cachedConfig.BoxStyle = Fatality.config.vars["BoxStyle"]
        cachedConfig.EspCol = Fatality.config.colors["EspCol"]
        cachedConfig.EspColAlpha = Fatality.config.colors.alpha["EspCol"]
        cachedConfig.Name = Fatality.config.vars["Name"]
        cachedConfig.NameCol = Fatality.config.colors["NameCol"]
        cachedConfig.NameColAlpha = Fatality.config.colors.alpha["NameCol"]
        cachedConfig.TeamPlayer = Fatality.config.vars["TeamPlayer"]
        cachedConfig.TeamCol = Fatality.config.colors["TeamCol"]
        cachedConfig.TeamColAlpha = Fatality.config.colors.alpha["TeamCol"]
        cachedConfig.WeaponPlayer = Fatality.config.vars["WeaponPlayer"]
        cachedConfig.WepPlayerCol = Fatality.config.colors["WepPlayerCol"]
        cachedConfig.WepPlayerColAlpha = Fatality.config.colors.alpha["WepPlayerCol"]
        cachedConfig.DistancePlayer = Fatality.config.vars["DistancePlayer"]
        cachedConfig.DistancePlayerCol = Fatality.config.colors["DistancePlayerCol"]
        cachedConfig.DistancePlayerColAlpha = Fatality.config.colors.alpha["DistancePlayerCol"]
        cachedConfig.HealthPlayer = Fatality.config.vars["HealthPlayer"]
        cachedConfig.HealthPlayerCol = Fatality.config.colors["HealthPlayerCol"]
        cachedConfig.HealthPlayerColAlpha = Fatality.config.colors.alpha["HealthPlayerCol"]
        cachedConfig.HealthPlayerCol2 = Fatality.config.colors["HealthPlayerCol2"]
        cachedConfig.HealthPlayerCol2Alpha = Fatality.config.colors.alpha["HealthPlayerCol2"]
        cachedConfig.HealthPos = Fatality.config.vars["HealthPos"]
    end

    local function checkConfigChanges()
        if cachedConfig.EspBox ~= Fatality.config.vars["EspBox"] or
           cachedConfig.BoxStyle ~= Fatality.config.vars["BoxStyle"] or
           cachedConfig.EspCol ~= Fatality.config.colors["EspCol"] or
           cachedConfig.EspColAlpha ~= Fatality.config.colors.alpha["EspCol"] or
           cachedConfig.Name ~= Fatality.config.vars["Name"] or
           cachedConfig.NameCol ~= Fatality.config.colors["NameCol"] or
           cachedConfig.NameColAlpha ~= Fatality.config.colors.alpha["NameCol"] or
           cachedConfig.TeamPlayer ~= Fatality.config.vars["TeamPlayer"] or
           cachedConfig.TeamCol ~= Fatality.config.colors["TeamCol"] or
           cachedConfig.TeamColAlpha ~= Fatality.config.colors.alpha["TeamCol"] or
           cachedConfig.WeaponPlayer ~= Fatality.config.vars["WeaponPlayer"] or
           cachedConfig.WepPlayerCol ~= Fatality.config.colors["WepPlayerCol"] or
           cachedConfig.WepPlayerColAlpha ~= Fatality.config.colors.alpha["WepPlayerCol"] or
           cachedConfig.DistancePlayer ~= Fatality.config.vars["DistancePlayer"] or
           cachedConfig.DistancePlayerCol ~= Fatality.config.colors["DistancePlayerCol"] or
           cachedConfig.DistancePlayerColAlpha ~= Fatality.config.colors.alpha["DistancePlayerCol"] or
           cachedConfig.HealthPlayer ~= Fatality.config.vars["HealthPlayer"] or
           cachedConfig.HealthPlayerCol ~= Fatality.config.colors["HealthPlayerCol"] or
           cachedConfig.HealthPlayerColAlpha ~= Fatality.config.colors.alpha["HealthPlayerCol"] or
           cachedConfig.HealthPlayerCol2 ~= Fatality.config.colors["HealthPlayerCol2"] or
           cachedConfig.HealthPlayerCol2Alpha ~= Fatality.config.colors.alpha["HealthPlayerCol2"] or
           cachedConfig.HealthPos ~= Fatality.config.vars["HealthPos"] then
            updateEspStroke()
        end
    end

    local function updateHealthAnimation()
        if not Fatality.config.vars["HealthPlayer"] then return end
        local time = tick()
        local healthPerc = (math.sin(time * math.pi / 2) + 1) / 2
        healthLabel.Text = tostring(math.floor(healthPerc * 100))
        local color1 = Fatality.config.colors["HealthPlayerCol"]
        local color2 = Fatality.config.colors["HealthPlayerCol2"] or Color3.new(0, 0, 0)
        local alpha1 = Fatality.config.colors.alpha["HealthPlayerCol"] or 1
        local alpha2 = Fatality.config.colors.alpha["HealthPlayerCol2"] or 1
        local r = color1.R + (color2.R - color1.R) * (1 - healthPerc)
        local g = color1.G + (color2.G - color1.G) * (1 - healthPerc)
        local b = color1.B + (color2.B - color1.B) * (1 - healthPerc)
        local alpha = alpha1 + (alpha2 - alpha1) * (1 - healthPerc)
        local interpolatedColor = Color3.new(r, g, b)
        healthLabel.TextColor3 = interpolatedColor
        healthLabel.TextTransparency = 1 - alpha
        healthSlider.BackgroundColor3 = interpolatedColor
        healthSlider.BackgroundTransparency = 1 - alpha
        healthSliderBG.BackgroundTransparency = 1 - alpha

        local xOffset = Fatality.config.vars["HealthPos"] ~= 3 and -50 or 0
        local height = espFrame.AbsoluteSize.Y
        local sliderWidth, margin = 5, 5
        local minX = -sliderWidth - margin
        healthSliderBG.Position = UDim2.new(0, minX, 0, 0)
        healthSliderBG.Size = UDim2.new(0, sliderWidth, 0, height)
        local sliderHeight = height * healthPerc
        local sliderY = height - sliderHeight
        healthSlider.Position = UDim2.new(0, minX, 0, sliderY)
        healthSlider.Size = UDim2.new(0, sliderWidth, 0, sliderHeight)
        local healthY = sliderY - 5
        healthLabel.Position = UDim2.new(0, minX + xOffset, 0, healthY)
    end

    Fatality.RunService.RenderStepped:Connect(checkConfigChanges)
    Fatality.RunService.RenderStepped:Connect(updateHealthAnimation)
    camera:GetPropertyChangedSignal("FieldOfView"):Connect(updateEspStroke)

    local modelViewerFrame = Instance.new("Frame")
    modelViewerFrame.Size = UDim2.new(0, 272, 0, 48)
    modelViewerFrame.Position = UDim2.new(0.25, 0, -0.1, 0)
    modelViewerFrame.BackgroundTransparency = 1
    modelViewerFrame.ZIndex = 101
    modelViewerFrame.Parent = viewerFrame

    local outlineframe = Instance.new("Frame")
    outlineframe.Size = UDim2.new(0.675, 1, 0.63, 0)
    outlineframe.Position = UDim2.new(0.0, 0, 0.3, 0)
    outlineframe.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
    outlineframe.BackgroundTransparency = 1
    outlineframe.ZIndex = 100
    outlineframe.Parent = modelViewerFrame

    local borderStroke = Instance.new("UIStroke")
    borderStroke.Thickness = 1
    borderStroke.Color = Color3.fromRGB(29, 23, 60)
    borderStroke.Parent = outlineframe

    local isHovering = false
    local isOpen = false

    local function tweenColor(stroke, targetColor)
        local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tween = Fatality.TweenService:Create(stroke, tweenInfo, {Color = targetColor})
        tween:Play()
    end

    local function updateStrokeColor()
        if isHovering or isOpen then
            tweenColor(borderStroke, Color3.fromRGB(195, 44, 95))
        else
            tweenColor(borderStroke, Color3.fromRGB(29, 23, 60))
        end
    end

    outlineframe.MouseEnter:Connect(function()
        if Fatality.ui.ColorPanel then return end
        isHovering = true
        updateStrokeColor()
    end)
    outlineframe.MouseLeave:Connect(function()
        isHovering = false
        updateStrokeColor()
    end)

    local dropdown = Instance.new("TextButton")
    dropdown.Size = UDim2.new(0.65, 0, 0.5, 0)
    dropdown.Position = UDim2.new(0.01, 0, 0.37, 0)
    dropdown.BackgroundColor3 = Color3.fromRGB(29, 23, 60)
    dropdown.Font = Enum.Font.GothamBold
    dropdown.TextColor3 = Color3.fromRGB(220, 220, 220)
    dropdown.TextSize = 15
    dropdown.TextXAlignment = Enum.TextXAlignment.Left
    dropdown.ZIndex = 101
    dropdown.Parent = modelViewerFrame

    local arrowBackground = Instance.new("Frame")
    arrowBackground.Size = UDim2.new(0.16, 0, 1, 0)
    arrowBackground.Position = UDim2.new(0.85, 0, 0.0, 0)
    arrowBackground.BackgroundTransparency = 0
    arrowBackground.BackgroundColor3 = Color3.fromRGB(195, 44, 95)
    arrowBackground.ZIndex = 103
    arrowBackground.Parent = dropdown

    local arrow = Instance.new("TextLabel")
    arrow.Size = UDim2.new(1, 0, 1, 0)
    arrow.Position = UDim2.new(0, 0, -0.1, 0)
    arrow.BackgroundTransparency = 1
    arrow.Text = "▼"
    arrow.TextColor3 = Color3.fromRGB(220, 220, 220)
    arrow.Font = Enum.Font.GothamBold
    arrow.TextSize = 25
    arrow.ZIndex = 104
    arrow.Parent = arrowBackground

    local options = {"Enemy", "Entity"}
    local selectedMode = options[1]

    local blackSquare = Instance.new("Frame")
    blackSquare.Size = UDim2.new(0.3, 0, 1, 0)
    blackSquare.Position = UDim2.new(0.65, 0, 0, 0)
    blackSquare.Visible = false
    blackSquare.ZIndex = 102
    blackSquare.Parent = dropdown

    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 25, 25)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
    })
    gradient.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(1, 0)
    })
    gradient.Parent = blackSquare

    local function anpassText(text, maxWidth, filler)
        local textWidth = game:GetService("TextService"):GetTextSize(text, 13, Enum.Font.GothamBold, Vector2.new(math.huge, 15)).X
        if textWidth <= maxWidth then
            return "  " .. text, false
        end
        for i = #text, 1, -1 do
            local shortened = text:sub(1, i) .. filler
            if game:GetService("TextService"):GetTextSize(shortened, 13, Enum.Font.GothamBold, Vector2.new(math.huge, 15)).X <= maxWidth then
                return "  " .. shortened, true
            end
        end
        return "  " .. filler, true
    end

    local optionButtons = {}

    local function updateModel(mode)
        for _, child in ipairs(worldModel:GetChildren()) do
            if child:IsA("Model") then
                child:Destroy()
            end
        end
        for _, child in ipairs(viewport:GetChildren()) do
            if child:IsA("TextLabel") and child ~= espFrame then
                child:Destroy()
            end
        end
        local success, result = pcall(function()
            local modelClone
            local displayName = name
            local teamName = "No Team"
            local weaponName = "No Tool"
            if mode == "Enemy" then
                local players = game.Players:GetPlayers()
                local otherPlayers = {}
                for _, p in ipairs(players) do
                    if p ~= game.Players.LocalPlayer and p.Character then
                        table.insert(otherPlayers, p)
                    end
                end
                if #otherPlayers > 0 then
                    local randomPlayer = otherPlayers[math.random(1, #otherPlayers)]
                    local character = randomPlayer.Character
                    if character then
                        if not character:FindFirstChildOfClass("Humanoid") or not character.PrimaryPart then
                            return
                        end
                        local wasArchivable = character.Archivable
                        character.Archivable = true
                        modelClone = character:Clone()
                        character.Archivable = wasArchivable
                        if modelClone then
                            modelClone.Parent = worldModel
                            local humanoid = modelClone:FindFirstChildOfClass("Humanoid")
                            if humanoid then
                                humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
                                if modelClone.PrimaryPart then
                                    modelClone:SetPrimaryPartCFrame(CFrame.new(Vector3.new(0, 2.2, 0), Vector3.new(0, 2, 4.8)))
                                end
                            else
                                modelClone:Destroy()
                                modelClone = nil
                            end
                            displayName = randomPlayer.Name
                            teamName = randomPlayer.Team and randomPlayer.Team.Name or "No Team"
                            local tool = character:FindFirstChildOfClass("Tool")
                            weaponName = tool and tool.Name or "No Tool"
                        end
                    end
                end
            elseif mode == "Entity" then
                local entityTemplate = game.ReplicatedStorage:FindFirstChild("Entities") and game.ReplicatedStorage.Entities:FindFirstChild("DefaultEntity")
                if entityTemplate then
                    modelClone = entityTemplate:Clone()
                    if modelClone then
                        modelClone.Parent = worldModel
                        local humanoid = modelClone:FindFirstChildOfClass("Humanoid")
                        if humanoid then
                            humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
                        end
                        if modelClone.PrimaryPart then
                            modelClone:SetPrimaryPartCFrame(CFrame.new(Vector3.new(0, 2.2, 0), Vector3.new(0, 2, 4.8)))
                        else
                            modelClone:Destroy()
                            modelClone = nil
                        end
                        displayName = "Entity"
                        teamName = "No Team"
                        weaponName = "No Tool"
                    end
                end
            end
            nameLabel.Text = displayName or name
            teamLabel.Text = teamName
            weaponLabel.Text = weaponName
            if modelClone and modelClone.PrimaryPart then
                local modelCFrame, modelSize = modelClone:GetBoundingBox()
                local maxSize = math.max(modelSize.X, modelSize.Y, modelSize.Z)
                local viewportSize = viewport.AbsoluteSize
                local aspectRatio = viewportSize.X / viewportSize.Y
                local fov = math.deg(2 * math.atan(maxSize * 2 / (2 * 4.8) * aspectRatio))
                camera.FieldOfView = math.clamp(fov, 10, 150)
                updateEspStroke()
            else
                local notFoundLabel = Instance.new("TextLabel")
                notFoundLabel.Size = UDim2.new(0.9, 0, 0.5, 0)
                notFoundLabel.Position = UDim2.new(0.05, 0, 0.25, 0)
                notFoundLabel.BackgroundTransparency = 1
                notFoundLabel.Text = "Model Not Found"
                notFoundLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                notFoundLabel.Font = Enum.Font.GothamBold
                notFoundLabel.TextSize = 16
                notFoundLabel.ZIndex = 101
                notFoundLabel.Parent = viewport
                nameLabel.Text = name
                teamLabel.Text = "No Team"
                weaponLabel.Text = "No Tool"
            end
        end)
    end

    local function updateDisplay()
        local displayText, isShortened = anpassText(selectedMode, dropdown.AbsoluteSize.X * 0.8, " ")
        dropdown.Text = displayText
        blackSquare.Visible = isShortened
        for _, btn in ipairs(optionButtons) do
            local opt = btn:GetAttribute("Option")
            local isSelected = (opt == selectedMode)
            btn.TextColor3 = isSelected and Color3.fromRGB(195, 44, 95) or Color3.fromRGB(220, 220, 220)
        end
        updateModel(selectedMode)
    end

    updateDisplay()

    local optionsFrame = Instance.new("Frame")
    optionsFrame.Size = UDim2.new(0.6575, 0, 0.25, 0)
    optionsFrame.Position = UDim2.new(0.0175, 0, 0.93, 0)
    optionsFrame.BackgroundColor3 = Color3.fromRGB(20, 15, 45)
    optionsFrame.Visible = false
    optionsFrame.ZIndex = 103
    optionsFrame.BackgroundTransparency = 1
    optionsFrame.Parent = modelViewerFrame

    local FoptionsFrame = Instance.new("Frame")
    FoptionsFrame.Size = UDim2.new(0.6575, 0, #options * 0.56, 0)
    FoptionsFrame.Position = UDim2.new(0.0175, 0, 0.93, 0)
    FoptionsFrame.BackgroundColor3 = Color3.fromRGB(21, 15, 45)
    FoptionsFrame.Visible = false
    FoptionsFrame.ZIndex = 104
    FoptionsFrame.Parent = modelViewerFrame

    local layout = Instance.new("UIListLayout")
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = optionsFrame

    for _, opt in ipairs(options) do
        local optButton = Instance.new("TextButton")
        optButton.Size = UDim2.new(1, 0, 2.25, 0)
        optButton.BackgroundTransparency = 0.5
        optButton.BackgroundColor3 = Color3.fromRGB(20, 15, 45)
        optButton.Font = Enum.Font.GothamBold
        optButton.TextSize = 13
        optButton.TextXAlignment = Enum.TextXAlignment.Left
        optButton.ClipsDescendants = true
        optButton.ZIndex = 105
        optButton.Parent = optionsFrame
        optButton:SetAttribute("Option", opt)
        optButton.Text = anpassText(opt, optButton.AbsoluteSize.X * 0.95, "...")

        local function updateButtonStyle()
            local isSelected = (opt == selectedMode)
            optButton.TextColor3 = isSelected and Color3.fromRGB(195, 44, 95) or Color3.fromRGB(220, 220, 220)
        end

        updateButtonStyle()

        optButton.MouseEnter:Connect(function()
            if Fatality.ui.ColorPanel then return end
            local isSelected = (opt == selectedMode)
            if isSelected then
                optButton.TextColor3 = Color3.fromRGB(150, 22, 49)
            else
                optButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            end
        end)

        optButton.MouseLeave:Connect(function()
            updateButtonStyle()
        end)

        optButton.MouseButton1Click:Connect(function()
            if Fatality.ui.ColorPanel then return end
            selectedMode = opt
            updateDisplay()
            optionsFrame.Visible = false
            FoptionsFrame.Visible = false
            optionsFrame.Parent = modelViewerFrame
            FoptionsFrame.Parent = modelViewerFrame
            isOpen = false
            updateStrokeColor()
            arrow.Text = "▼"
        end)

        table.insert(optionButtons, optButton)
    end

    if not Fatality.ui.DropdownContainer then
        local screenGui = parent
        while screenGui and not screenGui:IsA("ScreenGui") do
            screenGui = screenGui.Parent
        end
        if screenGui then
            Fatality.ui.DropdownContainer = Instance.new("Frame")
            Fatality.ui.DropdownContainer.Size = UDim2.new(1, 0, 1, 0)
            Fatality.ui.DropdownContainer.Position = UDim2.new(0, 0, 0, 0)
            Fatality.ui.DropdownContainer.BackgroundTransparency = 1
            Fatality.ui.DropdownContainer.ClipsDescendants = false
            Fatality.ui.DropdownContainer.ZIndex = 99
            Fatality.ui.DropdownContainer.Name = "DropdownContainer"
            Fatality.ui.DropdownContainer.Parent = screenGui
        end
    end

    local function updateDropdownPosition()
        if isOpen and Fatality.ui.DropdownContainer then
            local comboAbsPos = modelViewerFrame.AbsolutePosition
            local comboAbsSize = modelViewerFrame.AbsoluteSize
            local offsetX = comboAbsPos.X + (comboAbsSize.X * 0.013)
            local offsetY = comboAbsPos.Y + (comboAbsSize.Y * 2.1)
            local optionsWidth = comboAbsSize.X * 0.6575
            local optionsHeight = comboAbsSize.Y * 0.25
            local fOptionsHeight = comboAbsSize.Y * (#options * 0.56)

            optionsFrame.Size = UDim2.new(0, optionsWidth, 0, optionsHeight)
            FoptionsFrame.Size = UDim2.new(0, optionsWidth, 0, fOptionsHeight)
            optionsFrame.Position = UDim2.new(0, offsetX, 0, offsetY)
            FoptionsFrame.Position = UDim2.new(0, offsetX, 0, offsetY)
            optionsFrame.Visible = isOpen
            FoptionsFrame.Visible = isOpen
        end
    end

    if not Fatality.ui.ActiveComboBoxes then
        Fatality.ui.ActiveComboBoxes = {}
    end

    local function closeComboBox()
        if isOpen then
            optionsFrame.Visible = false
            FoptionsFrame.Visible = false
            optionsFrame.Parent = modelViewerFrame
            FoptionsFrame.Parent = modelViewerFrame
            optionsFrame.Size = UDim2.new(0.6575, 0, 0.25, 0)
            FoptionsFrame.Size = UDim2.new(0.6575, 0, #options * 0.56, 0)
            optionsFrame.Position = UDim2.new(0.0175, 0, 0.93, 0)
            FoptionsFrame.Position = UDim2.new(0.0175, 0, 0.93, 0)
            isOpen = false
            arrow.Text = "▼"
            updateStrokeColor()
        end
    end

    local comboBoxData = {
        comboFrame = modelViewerFrame,
        isOpen = function() return isOpen end,
        setOpen = function(value) isOpen = value end,
        optionsFrame = optionsFrame,
        FoptionsFrame = FoptionsFrame,
        arrow = arrow,
        updateStrokeColor = updateStrokeColor,
        close = closeComboBox
    }
    table.insert(Fatality.ui.ActiveComboBoxes, comboBoxData)

    dropdown.MouseButton1Click:Connect(function()
        if Fatality.ui.ColorPanel then return end
        for _, otherComboBox in ipairs(Fatality.ui.ActiveComboBoxes) do
            if otherComboBox.comboFrame ~= modelViewerFrame and otherComboBox.isOpen() then
                otherComboBox.close()
            end
        end

        isOpen = not isOpen
        if isOpen and Fatality.ui.DropdownContainer then
            optionsFrame.Parent = Fatality.ui.DropdownContainer
            FoptionsFrame.Parent = Fatality.ui.DropdownContainer
            updateDropdownPosition()
        else
            optionsFrame.Parent = modelViewerFrame
            FoptionsFrame.Parent = modelViewerFrame
            optionsFrame.Size = UDim2.new(0.6575, 0, 0.25, 0)
            FoptionsFrame.Size = UDim2.new(0.6575, 0, #options * 0.56, 0)
            optionsFrame.Position = UDim2.new(0.0175, 0, 0.93, 0)
            FoptionsFrame.Position = UDim2.new(0.0175, 0, 0.93, 0)
            optionsFrame.Visible = false
            FoptionsFrame.Visible = false
        end
        arrow.Text = isOpen and "▲" or "▼"
        updateStrokeColor()
    end)

    local scrollFrame = viewerFrame.Parent
    if scrollFrame and scrollFrame:IsA("ScrollingFrame") then
        scrollFrame:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
            if isOpen then
                optionsFrame.Visible = false
                FoptionsFrame.Visible = false
                isOpen = false
                arrow.Text = "▼"
                updateStrokeColor()
            end
        end)
    end

    if Menuframe then
        Menuframe:GetPropertyChangedSignal("Visible"):Connect(function()
            if isOpen and not Menuframe.Visible then
                optionsFrame.Visible = false
                FoptionsFrame.Visible = false
                optionsFrame.Parent = modelViewerFrame
                FoptionsFrame.Parent = modelViewerFrame
                optionsFrame.Size = UDim2.new(0.6575, 0, 0.25, 0)
                FoptionsFrame.Size = UDim2.new(0.6575, 0, #options * 0.56, 0)
                optionsFrame.Position = UDim2.new(0.0175, 0, 0.93, 0)
                FoptionsFrame.Position = UDim2.new(0.0175, 0, 0.93, 0)
                isOpen = false
                arrow.Text = "▼"
                updateStrokeColor()
            end
        end)
    end

    if not Fatality.ui.AllComboBoxes then
        Fatality.ui.AllComboBoxes = {}
    end
    table.insert(Fatality.ui.AllComboBoxes, updateDisplay)
    return viewerFrame
end

function Fatality.ui.TextList(parent)
    local help_text = (
        "Инструкция по функциям Fatality\n\n" ..
        "Общие понятия:\n" ..
        "Чит-меню открывается и закрывается клавишей DEL\n" ..
        "Bind можно сбросить нажатием ПКМ\n" ..
        "Везде, где есть Bind, необходимо включить соответствующую функцию, чтобы он работал, есть исключения\n" ..
        "TextEntry — поле для ввода текста, чтобы применить текст, введите его и нажмите Enter\n\n" ..

        "1. Вкладка Aimbot:\n" ..
        "   - Target Priority\n" ..
        "     FOV ищет цель, ближайшую к центру экрана в заданном радиусе\n" ..
        "     Distance выбирает ближайшего игрока от локалного\n\n" ..
        "   - Ignores:\n" ..
        "     Walls игнорирует стены, по умолчанию проверяется видимость головы противника\n" ..
        "     Teammates игнорирует своих тимейтов\n" ..
        "     God time игнорирует игрока у которого есть щит при спавне\n" ..
        "     Friends Roblox игнорирует игроков которые есть в друзьях\n\n" ..
        "   - Blox Strike:\n" ..
        "     Все ниже перечисленное работает ТОЛЬКО В Blox Strike\n" ..        
        "     NoRecoil убирает любую отдачу\n" ..
        "     MoreAmmo дает много патронов при покупке оружия\n" ..
        "     DoubleTap дает 2 выстрела, работает при покупке оружия, понижает FPS\n\n" ..
        "   - Hit Sound:\n" ..
        "     Воспроизводит или не воспроизводит звук при нанесении урона\n" ..
        "     Sound only kill звук воспроизводится когда вы убиваете игрока а не наносите урон\n\n" ..
        "   - Show FOV:\n" ..
        "     Показывает FOV если он включен, не показывается менюшка Fatality\n\n" ..

        "2. Вкладка Visual:\n" ..
        "   - ESP:\n" ..
        "     Update ESP задает скорость обновления ESP в мс, чем больше значение, тем реже обновление и выше FPS\n\n" ..
        "   - View:\n" ..
        "     Free Camera чтоб она работала нормально используйте bind и выходите из менюшки\n\n" ..
        "   - Third Person:\n" ..
        "     3 лицо, если доступно игроку 3 лицо не включайте, использовать по bind\n\n" ..
        "   - FullBright:\n" ..
        "     Отключает тени и освещение и делает все белым\n\n" ..
        "   - Xray:\n" ..
        "     Делает все объекты прозрычными\n\n" ..
        "     Chams:\n" ..
        "     AlwaysOnTop включает отображение сквозь стены\n" ..
        "     Pulsating задает минимальное значение пульсации, максимальное определяется альфа-каналом в Color\n" ..
        "     Glow Outline Min минимальный возможный Alpha канал Glow\n" ..
        "     Glow Outline Max максимальный возможный Alpha канал Glow\n\n" ..

        "3. Вкладка Combat:\n" ..
        "   - LocalPlayer:\n" ..
        "     Speed Setting Velocity изменяет скорость игрока через его параметры\n" ..
        "     Speed Setting CFrame изменяет координаты игрока, есть шанс провалиться сквозь карту\n\n" ..
        "   - Noclip:\n" ..
        "     Просто полет\n\n" ..
        "   - NoCollision:\n" ..
        "     отключение коллизии локального игрока\n\n" ..
        "   - Logo Chat:\n" ..
        "     Пишет в чат Fatality.win\n\n" ..
        "     Taunt Spam:\n" ..
        "     Проигрывает анимации на локальном игроке\n" ..
        "     Работает не со всеми моделями\n" ..
        "     TauntCustom нужен для кастомных анимаций, пример(rbxassetid://507771955)\n\n" ..
        "     Blox:\n" ..
        "     HackWeapons работает только в Blox Strike, делает из пушки пулемет\n" ..
        "     Itachi Mod телепортирует игрока вокруг цели при выборе Distance или внутрь цели при выборе In The Player\n" ..
        "     Distance для Itachi определяет самого дальнего игрока и телепортирует к нему\n" ..
        "     Team Teleport игнорирует союзников в Itachi\n" ..
        "     Camera Teleport телепортирует камеру к противнику\n" ..
        "     Camera Teleport Team игнорирует тимейтов"
    )

    local backgroundFrame = Instance.new("Frame")
    backgroundFrame.Size = UDim2.new(0, 304, 0, 461)
    backgroundFrame.Position = UDim2.new(0.025, 0, 0.035, 0)
    backgroundFrame.BackgroundTransparency = 0
    backgroundFrame.BackgroundColor3 = Color3.fromRGB(29, 23, 60)
    backgroundFrame.BorderSizePixel = 0
    backgroundFrame.ZIndex = 109
    backgroundFrame.Parent = parent

    local scrollFrame = Instance.new("ScrollingFrame")
    scrollFrame.Size = UDim2.new(0, 304, 0, 453)
    scrollFrame.Position = UDim2.new(0.025, 0, 0.025, 0)
    scrollFrame.BackgroundTransparency = 1
    scrollFrame.BorderSizePixel = 0
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    scrollFrame.ScrollBarThickness = 0
    scrollFrame.ZIndex = 110
    scrollFrame.Parent = parent

    local function createTextLabel(text, size, yOffset)
        local textLabel = Instance.new("TextLabel")
        textLabel.Size = UDim2.new(1, -10, 0, 0)
        textLabel.Position = UDim2.new(0, 5, 0, yOffset)
        textLabel.BackgroundTransparency = 1
        textLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
        textLabel.Font = Enum.Font.GothamBold
        textLabel.TextSize = size
        textLabel.TextXAlignment = Enum.TextXAlignment.Left
        textLabel.TextYAlignment = Enum.TextYAlignment.Top
        textLabel.TextWrapped = true
        textLabel.ZIndex = 111
        textLabel.Text = text or ""
        textLabel.Parent = scrollFrame

        local textSize = game:GetService("TextService"):GetTextSize(textLabel.Text, textLabel.TextSize, textLabel.Font, Vector2.new(math.max(scrollFrame.AbsoluteSize.X - 10, 1), math.huge))
        textLabel.Size = UDim2.new(1, -10, 0, textSize.Y)
        return textLabel, textSize.Y
    end

    local lines = {}
    for line in help_text:gmatch("(.-)\n") do
        table.insert(lines, line)
    end
    if help_text:match("[^\n]+$") then
        table.insert(lines, help_text:match("[^\n]+$"))
    end

    local totalHeight = 0
    local yOffset = -3
    for i, line in ipairs(lines) do
        if line == "" then
            yOffset = yOffset + 10
            totalHeight = totalHeight + 10
        else
            local _, height = createTextLabel(line, 12.5, yOffset)
            yOffset = yOffset + height
            totalHeight = totalHeight + height
        end
    end

    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, math.max(totalHeight, 460))

    return scrollFrame
end

function createItemPanelSystem(parent, itemPanels)
    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(1, 0, 0, 58)
    bg.Position = UDim2.new(0, 0, 0, 0)
    bg.BackgroundColor3 = Color3.fromRGB(35, 30, 71)
    bg.ZIndex = 23
    bg.Parent = parent

    local itemPanelListFrame = Instance.new("Frame")
    itemPanelListFrame.Size = UDim2.new(1, 0, 0.2, 0)
    itemPanelListFrame.Position = UDim2.new(0.005, 0, 0.015, 0)
    itemPanelListFrame.BackgroundTransparency = 1
    itemPanelListFrame.ZIndex = 23
    itemPanelListFrame.Parent = parent

    local listLayout = Instance.new("UIListLayout")
    listLayout.FillDirection = Enum.FillDirection.Horizontal
    listLayout.Padding = UDim.new(0, -5)
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    listLayout.Parent = itemPanelListFrame

    local contentContainer = Instance.new("Frame")
    contentContainer.Size = UDim2.new(1, 0, 0.75, 0)
    contentContainer.Position = UDim2.new(0, 0, 0.1, 0)
    contentContainer.BackgroundColor3 = Color3.fromRGB(29, 23, 60)
    contentContainer.ZIndex = 22
    contentContainer.ClipsDescendants = false
    contentContainer.Parent = parent

    local itemPanelContentFrames = {}
    local itemPanelButtons = {}

    local function closeAllPopups()
        for _, comboBox in ipairs(Fatality.ui.ActiveComboBoxes or {}) do
            comboBox.close()
        end
        if Fatality.ui.ColorPanel then
            Fatality.ui.ColorPanel:Destroy()
            Fatality.ui.ColorPanel = nil
        end
        if Fatality.ui.ColorPanelBG then
            Fatality.ui.ColorPanelBG:Destroy()
            Fatality.ui.ColorPanelBG = nil
        end
        for _, picker in ipairs(Fatality.ui.AllColorPickers or {}) do
            if picker.frameStroke then
                local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                local tween = Fatality.TweenService:Create(picker.frameStroke, tweenInfo, { Color = Color3.fromRGB(29, 23, 60) })
                tween:Play()
            end
        end
    end

    for i, panelData in ipairs(itemPanels) do
        local itemPanelButton = Instance.new("TextButton")
        itemPanelButton.Size = UDim2.new(0, 100, 0, 40)
        itemPanelButton.BackgroundTransparency = 1
        itemPanelButton.Text = panelData.Name
        itemPanelButton.Font = Enum.Font.GothamBold
        itemPanelButton.TextSize = 25
        itemPanelButton.TextColor3 = Color3.fromRGB(220, 220, 220)
        itemPanelButton.ZIndex = 23
        itemPanelButton.Parent = itemPanelListFrame

        local contentFrame = Instance.new("Frame")
        contentFrame.Size = UDim2.new(1, 0, 1, 0)
        contentFrame.BackgroundColor3 = Color3.fromRGB(29, 23, 60)
        contentFrame.Visible = false
        contentFrame.ZIndex = 22
        contentFrame.ClipsDescendants = false
        contentFrame.Parent = contentContainer

        local columnFrames = {
            [1] = Instance.new("Frame"),
            [2] = Instance.new("Frame"),
            [3] = Instance.new("Frame")
        }
        local panelsByPal = { [1] = {}, [2] = {}, [3] = {} }
        for pal = 1, 3 do
            columnFrames[pal].Size = UDim2.new(0.31, 0, 1, 0)
            columnFrames[pal].Position = UDim2.new(0.015 + (0.33 * (pal - 1)), 0, 0.05, 0)
            columnFrames[pal].BackgroundTransparency = 1
            columnFrames[pal].ZIndex = 23
            columnFrames[pal].ClipsDescendants = false
            columnFrames[pal].Parent = contentFrame

            local columnLayout = Instance.new("UIListLayout")
            columnLayout.FillDirection = Enum.FillDirection.Vertical
            columnLayout.Padding = UDim.new(0, -63)
            columnLayout.SortOrder = Enum.SortOrder.LayoutOrder
            columnLayout.Parent = columnFrames[pal]
        end

        for panelIndex, itemPanel in ipairs(panelData.ItemPanels or {}) do
            table.insert(panelsByPal[itemPanel.Pal], { Index = panelIndex, Panel = itemPanel })
        end

        for pal = 1, 3 do
            for idx, panelInfo in ipairs(panelsByPal[pal]) do
                local itemPanel = panelInfo.Panel
                local panelIndex = panelInfo.Index
                local isLastPanel = idx == #panelsByPal[pal]

                local titleFrame = Instance.new("Frame")
                titleFrame.Size = UDim2.new(0, 241, 0, 58)
                titleFrame.BackgroundTransparency = 1
                titleFrame.ZIndex = 25
                titleFrame.LayoutOrder = panelIndex * 2 - 1
                titleFrame.Parent = columnFrames[itemPanel.Pal]

                local titleLabel = Instance.new("TextLabel")
                titleLabel.Size = UDim2.new(1, 0, 1, 0)
                titleLabel.TextXAlignment = Enum.TextXAlignment.Left
                titleLabel.Position = UDim2.new(0, 10, 0, -35)
                titleLabel.BackgroundTransparency = 1
                titleLabel.Text = itemPanel.Name
                titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                titleLabel.Font = Enum.Font.SourceSansBold
                titleLabel.TextSize = 18
                titleLabel.ZIndex = 25
                titleLabel.TextTruncate = Enum.TextTruncate.AtEnd
                titleLabel.Parent = titleFrame

                local itemPanelFrame = Instance.new("ScrollingFrame")
                itemPanelFrame.Size = UDim2.new(1, 0, 0, itemPanel.Height or 180)
                itemPanelFrame.BackgroundColor3 = Color3.fromRGB(35, 30, 71)
                itemPanelFrame.BorderSizePixel = 0
                itemPanelFrame.ZIndex = 23
                itemPanelFrame.ScrollBarThickness = 0
                itemPanelFrame.ScrollingEnabled = true
                itemPanelFrame.ScrollingDirection = Enum.ScrollingDirection.Y
                itemPanelFrame.ClipsDescendants = true
                itemPanelFrame.LayoutOrder = panelIndex * 2
                itemPanelFrame.Parent = columnFrames[itemPanel.Pal]

                titleLabel.TextTransparency = 0
                itemPanelFrame:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
                    local canvasY = itemPanelFrame.CanvasPosition.Y
                    if canvasY > 0 then
                        titleLabel.TextTransparency = 1
                        closeAllPopups()
                    else
                        titleLabel.TextTransparency = 0
                    end
                end)

                if not isLastPanel then
                    local spacerFrame = Instance.new("Frame")
                    spacerFrame.Size = UDim2.new(1, 0, 0, 151)
                    spacerFrame.BackgroundTransparency = 1
                    spacerFrame.LayoutOrder = panelIndex * 2 + 1
                    spacerFrame.Parent = columnFrames[itemPanel.Pal]
                else
                    local spacerFrame = Instance.new("Frame")
                    spacerFrame.Size = UDim2.new(1, 0, 0, 10)
                    spacerFrame.BackgroundTransparency = 1
                    spacerFrame.LayoutOrder = panelIndex * 2 + 1
                    spacerFrame.Parent = columnFrames[itemPanel.Pal]
                end

                local yOffset = 25
                for _, item in ipairs(itemPanel.Items or {}) do
                    local currentYOffset = yOffset
                    if item.Type == "CheckBox" then
                        local checkboxElement = Fatality.ui.CheckBox(item.Text, item.Var, itemPanelFrame)
                        checkboxElement.Position = UDim2.new(0.025, 0, 0, currentYOffset)
                        if item.colpicker then
                            local colorElement = Fatality.ui.ColorPicker("", item.colpicker, itemPanelFrame)
                            colorElement.Position = UDim2.new(0.025, 0, 0, currentYOffset - 10)
                        end
                        if item.colpicker2 then
                            local colorElement2 = Fatality.ui.ColorPicker("", item.colpicker2, itemPanelFrame)
                            colorElement2.Position = UDim2.new(-0.2, 0, 0, currentYOffset - 10)
                        elseif item.bind then
                            local bindElement = Fatality.ui.Bind("", item.bind, itemPanelFrame)
                            bindElement.Position = UDim2.new(0.025, 0, 0, currentYOffset)
                        end
                    elseif item.Type == "ComboBox" then
                        local comboElement = Fatality.ui.ComboBox(item.Text, item.Var, item.Options, itemPanelFrame, item.moresave)
                        comboElement.Position = UDim2.new(0.025, 0, 0, currentYOffset)
                        if item.colpicker then
                            local colorElement = Fatality.ui.ColorPicker("", item.colpicker, itemPanelFrame)
                            colorElement.Position = UDim2.new(0.025, 0, 0, currentYOffset + 9)
                            yOffset = yOffset + 30
                        elseif item.bind then
                            local bindElement = Fatality.ui.Bind("", item.bind, itemPanelFrame)
                            bindElement.Position = UDim2.new(0.025, 0, 0, currentYOffset)
                        end
                    elseif item.Type == "ColorPicker" then
                        local colorPickerElement = Fatality.ui.ColorPicker(item.Text, item.Var, itemPanelFrame)
                        colorPickerElement.Position = UDim2.new(0.025, 0, 0, currentYOffset)
                    elseif item.Type == "Slider" then
                        local sliderElement = Fatality.ui.Slider(item.Text, item.Var, item.Min, item.Max, item.Dec or 0, nil, itemPanelFrame)
                        sliderElement.Position = UDim2.new(0.025, 0, 0, currentYOffset)
                    elseif item.Type == "Bind" then
                        local bindElement = Fatality.ui.Bind(item.Text, item.Var, itemPanelFrame)
                        bindElement.Position = UDim2.new(0.025, 0, 0, currentYOffset)
                    elseif item.Type == "ConfigManager" then
                        local configManagerElement = Fatality.ui.ConfigManager(itemPanelFrame)
                        configManagerElement.Position = UDim2.new(0.025, 0, 0, currentYOffset)
                    elseif item.Type == "TextEntry" then
                        local textEntryElement = Fatality.ui.TextEntry(item.Text, item.Var, itemPanelFrame)
                        textEntryElement.Position = UDim2.new(0.025, 0, 0, currentYOffset)
                    elseif item.Type == "ModelViewer" then
                        local viewerElement = Fatality.ui.ModelViewer(item.Text, itemPanelFrame)
                        viewerElement.Position = UDim2.new(0.025, 0, 0, currentYOffset)
                    elseif item.Type == "TextList" then
                        local textListElement = Fatality.ui.TextList(itemPanelFrame)
                        textListElement.Position = UDim2.new(0.025, 0, 0, currentYOffset)
                    end
                    yOffset = currentYOffset + 30
                    if item.Type == "ComboBox" then
                        yOffset = yOffset + 25
                    elseif item.Type == "Slider" then
                        yOffset = yOffset + 20
                    elseif item.Type == "ColorPicker" then
                        yOffset = yOffset + 10
                    elseif item.Type == "ConfigManager" then
                        yOffset = yOffset + 100
                    elseif item.Type == "TextEntry" then
                        yOffset = yOffset + 20
                    elseif item.Type == "ModelViewer" then
                        yOffset = yOffset + 170
                    elseif item.Type == "TextList" then
                        yOffset = yOffset + 110
                    end
                end
                itemPanelFrame.CanvasSize = UDim2.new(0, 0, 0, yOffset + 10)
            end
        end

        itemPanelContentFrames[i] = contentFrame
        itemPanelButtons[i] = itemPanelButton

        local activeLine = Instance.new("Frame")
        activeLine.Name = "ActiveLine"
        activeLine.Size = UDim2.new(0, 0, 0, 2)
        activeLine.Position = UDim2.new(0.5, -itemPanelButton.TextBounds.X / 2, 1, 0)
        activeLine.BackgroundColor3 = Color3.fromRGB(195, 44, 95)
        activeLine.ZIndex = 24
        activeLine.Parent = itemPanelButton

        itemPanelButton.MouseButton1Click:Connect(function()
            if contentFrame.Visible then
                return
            end
            closeAllPopups()
            for _, frame in ipairs(itemPanelContentFrames) do
                frame.Visible = false
            end
            for _, btn in ipairs(itemPanelListFrame:GetChildren()) do
                if btn:IsA("TextButton") then
                    btn.TextColor3 = Color3.fromRGB(220, 220, 220)
                    local line = btn:FindFirstChild("ActiveLine")
                    if line then
                        local shrinkTween = Fatality.TweenService:Create(line, TweenInfo.new(0.3), {Size = UDim2.new(0, 0, 0, 2), Position = UDim2.new(0.5, 0, 1, 0), Transparency = 1})
                        shrinkTween:Play()
                        shrinkTween.Completed:Connect(function()
                            line:Destroy()
                        end)
                    end
                end
            end
            contentFrame.Visible = true
            itemPanelButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            local newActiveLine = Instance.new("Frame")
            newActiveLine.Name = "ActiveLine"
            newActiveLine.Size = UDim2.new(0, 0, 0, 2)
            newActiveLine.AnchorPoint = Vector2.new(0.5, 0)
            newActiveLine.Position = UDim2.new(0.5, 0, 1, 0)
            newActiveLine.BackgroundColor3 = Color3.fromRGB(195, 44, 95)
            newActiveLine.ZIndex = itemPanelButton.ZIndex + 1
            newActiveLine.Parent = itemPanelButton
            local expandTween = Fatality.TweenService:Create(newActiveLine, TweenInfo.new(0.4), {Size = UDim2.new(0, itemPanelButton.TextBounds.X, 0, 2), Transparency = 0})
            expandTween:Play()
        end)
    end

    if #itemPanelContentFrames > 0 then
        itemPanelContentFrames[1].Visible = true
        itemPanelButtons[1].TextColor3 = Color3.fromRGB(255, 255, 255)
        local firstLine = itemPanelButtons[1]:FindFirstChild("ActiveLine")
        if firstLine then
            firstLine.Size = UDim2.new(0, itemPanelButtons[1].TextBounds.X, 0, 2)
            firstLine.Position = UDim2.new(0.5, -itemPanelButtons[1].TextBounds.X / 2, 1, 0)
            firstLine.Transparency = 0
            firstLine.Visible = true
        end
    end
end

local function createTab(tabName, itemPanels)
    local tabButton = Instance.new("TextButton")
    tabButton.AutomaticSize = Enum.AutomaticSize.X
    tabButton.Size = UDim2.new(0, 0, 1, 0)
    tabButton.BackgroundTransparency = 1
    tabButton.Text = tabName
    tabButton.TextColor3 = Color3.fromRGB(220, 220, 220)
    tabButton.Font = Enum.Font.GothamBold
    tabButton.TextSize = 35
    tabButton.ZIndex = 24
    tabButton.Parent = TabButtonsFrame

    local tabContent = Instance.new("Frame")
    tabContent.Name = tabName
    tabContent.Size = UDim2.new(0.98, 0, 0.75, 0)
    tabContent.Position = UDim2.new(0.01, 0, 0.23, 0)
    tabContent.BackgroundColor3 = Color3.fromRGB(29, 23, 60)
    tabContent.Visible = false
    tabContent.ZIndex = 23
    tabContent.Parent = Menuframe

    table.insert(Fatality.tabs, tabContent)

    tabButton.MouseButton1Click:Connect(function()
        if tabContent.Visible then
            return
        end
        for _, comboBox in ipairs(Fatality.ui.ActiveComboBoxes or {}) do
            comboBox.close()
        end
        if Fatality.ui.ColorPanel then
            Fatality.ui.ColorPanel:Destroy()
            Fatality.ui.ColorPanel = nil
        end
        if Fatality.ui.ColorPanelBG then
            Fatality.ui.ColorPanelBG:Destroy()
            Fatality.ui.ColorPanelBG = nil
        end
        for _, tab in ipairs(Fatality.tabs) do
            tab.Visible = false
        end
        for _, btn in ipairs(TabButtonsFrame:GetChildren()) do
            if btn:IsA("TextButton") then
                btn.TextColor3 = Color3.fromRGB(220, 220, 220)
                local line = btn:FindFirstChild("ActiveLine")
                if line then
                    local shrinkTween = Fatality.TweenService:Create(line, TweenInfo.new(0.3), {Size = UDim2.new(0, 0, 0, 3), Position = UDim2.new(0.5, 0, 0.8, 0), Transparency = 1})
                    shrinkTween:Play()
                    shrinkTween.Completed:Connect(function()
                        line:Destroy()
                    end)
                end
            end
        end
        tabContent.Visible = true
        tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        local activeLine = Instance.new("Frame")
        activeLine.Name = "ActiveLine"
        activeLine.Size = UDim2.new(0, 0, 0, 4)
        activeLine.Position = UDim2.new(0.5, 0, 0.8, 0)
        activeLine.BackgroundColor3 = Color3.fromRGB(195, 44, 95)
        activeLine.ZIndex = tabButton.ZIndex + 1
        activeLine.Parent = tabButton
        local expandTween = Fatality.TweenService:Create(activeLine, TweenInfo.new(0.4), {Size = UDim2.new(1, 0, 0, 3), Position = UDim2.new(0, 0, 0.8, 0)})
        expandTween:Play()
    end)

    if itemPanels then
        createItemPanelSystem(tabContent, itemPanels)
    end
end

local aimbotItemPanels = {
    {
        Name = "Aimbot",
        ItemPanels = {
            {
                Name = "Main",
                Height = 486,
                Pal = 1,
                Items = {
                    { Type = "CheckBox", Text = "Enable Aimbot", Var = "enableAimbot", bind = "enableAimbotBind" },
                    --{ Type = "CheckBox", Text = "Auto fire", Var = "AutoFire" },
                    { Type = "Slider", Text = "FOV", Var = "FOVValue", Min = 0, Max = 360, Dec = 0 },
                    { Type = "ComboBox", Text = "Target priority", Var = "TargetPriority", Options = {"Distance", "FOV"} },
                    { Type = "ComboBox", Text = "Ignores", Var = "IgnoresAimbot", Options = {"Walls", "Teammates", "God time", "Friends Roblox"}, moresave = true },
                    { Type = "ComboBox", Text = "Blox Strike", Var = "BloxStrikeAimbot", Options = {"NoRecoil", "MoreAmmo", "DoubleTap"}, moresave = true },
                    { Type = "ComboBox", Text = "Hit Sound", Var = "HitSound", Options = {"None", "Metalic", "Fatality", "Exp", "Rust", "Bell"} },
                    { Type = "CheckBox", Text = "Sound only kill", Var = "HitSoundKill"},
                    { Type = "Slider", Text = "Sound Valume", Var = "SoundValume", Min = 0, Max = 2, Dec = 1 },
                    --[[
                    { Type = "CheckBox", Text = "No Recoil(Blox)", Var = "NoRecoil" },
                    { Type = "CheckBox", Text = "More Ammo(Blox)", Var = "MoreAmmo" },
                    { Type = "CheckBox", Text = "Double Tap(Blox)", Var = "DoubleTap" }
                    --]]
                }
            },
            {
                Name = "Visual",
                Height = 233,
                Pal = 2,
                Items = {
                    { Type = "CheckBox", Text = "Show FOV", Var = "ShowFOV", colpicker = "ShowFOVCol"},
                    --{ Type = "CheckBox", Text = "Snapline", Var = "AimbotSnapline", colpicker = "AimbotSnaplineCol" },
                }
            }
        }
    }
}

local VisualItemPanels = {
    {
        Name = "Visual",
        ItemPanels = {
            {
                Name = "ESP",
                Height = 233,
                Pal = 1,
                Items = {
                    { Type = "CheckBox", Text = "Box", Var = "EspBox", colpicker = "EspCol" },
                    { Type = "CheckBox", Text = "Name", Var = "Name", colpicker = "NameCol" },
                    { Type = "CheckBox", Text = "Health", Var = "HealthPlayer", colpicker = "HealthPlayerCol", colpicker2 = "HealthPlayerCol2" },
                    { Type = "CheckBox", Text = "Team", Var = "TeamPlayer", colpicker = "TeamCol" },
                    { Type = "CheckBox", Text = "Weapon", Var = "WeaponPlayer", colpicker = "WepPlayerCol" },
                    { Type = "CheckBox", Text = "Distance", Var = "DistancePlayer", colpicker = "DistancePlayerCol" },
                    { Type = "ComboBox", Text = "Box Style", Var = "BoxStyle", Options = {"Default", "Corner", "Box 3D"} },
                    { Type = "Slider", Text = "Distance", Var = "DistanceESP", Min = 0, Max = 10000, Dec = 0 },
                    { Type = "Slider", Text = "Update Esp", Var = "ESPUpdateInterval", Min = 0, Max = 80, Dec = 0 }
                }
            },
            {
                Name = "ESP Entity",
                Height = 233,
                Pal = 1,
                Items = {
                }
            },
            {
                Name = "View",
                Height = 486,
                Pal = 2,
                Items = {
                    { Type = "CheckBox", Text = "Free camera", Var = "FreeCamera", bind = "FreeCameraBind" },
                    { Type = "Slider", Text = "Free camera Speed", Var = "FreeCameraSpeed", Min = 1, Max = 50, Dec = 0 },
                    { Type = "CheckBox", Text = "Third Person", Var = "Thirdperson", bind = "ThirdpersonBind" },
                    { Type = "Slider", Text = "Third Person Distance", Var = "ThirdpersonSlider", Min = 5, Max = 25, Dec = 0 },
                    { Type = "CheckBox", Text = "Че ты ебать,типо китаец?", Var = "ChinaHat", colpicker = "ChinaHatCol" },
                    { Type = "Slider", Text = "FOV Setting", Var = "FOVViewSlider", Min = 0, Max = 120, Dec = 0 },
                    { Type = "CheckBox", Text = "Crosshair", Var = "Crosshair" },
                    { Type = "ComboBox", Text = "Style", Var = "CrosshairStyle", Options = {"Swastika", "Cross", "Gays)"} },
                    { Type = "CheckBox", Text = "FullBright", Var = "FullBright", bind = "FullBrightBind" },
                    { Type = "CheckBox", Text = "Xray", Var = "Xray", bind = "XrayBind" },
                    --{ Type = "CheckBox", Text = "Player Line", Var = "PlayerLine"},
                    --{ Type = "ComboBox", Text = "Line Style", Var = "PlayerLineStyle", Options = {"RGB Lenta", "⚧Slave⚧"} },
                }
            },
            {
                Name = "Model Viewer",
                Height = 486,
                Pal = 3,
                Items = {
                    { Type = "ModelViewer", Text = "Player Model" }
                }
            }
        }
    },
    {
        Name = "Chams",
        ItemPanels = {
            {
                Name = "Enemy",
                Height = 486,
                Pal = 1,
                Items = {
                    { Type = "CheckBox", Text = "Chams", Var = "ChamsEnemy", colpicker = "VisibleChamsCol" },
                    { Type = "CheckBox", Text = "AlwaysOnTop", Var = "ChamsEnemyAlwaysOnTop" },
                    { Type = "ComboBox", Text = "Chams Materials", Var = "ChamsMaterials", Options = {"Flat", "Outline", "Glow", "Pulsating"} },
                    { Type = "CheckBox", Text = "Chams InVisible(NOT STABLE)", Var = "ChamsEnemyInv", colpicker = "InvisibleChamsCol" },
                    { Type = "ComboBox", Text = "Chams Materials Inv", Var = "ChamsMaterialsInv", Options = {"Flat", "Outline", "Glow", "Pulsating"} },
                    { Type = "Slider", Text = "Pulsating", Var = "PulsatingSlider", Min = 0, Max = 1, Dec = 1 },
                    { Type = "Slider", Text = "Glow Outline Min", Var = "GlowOutlineMin", Min = 0, Max = 1, Dec = 1 },
                    { Type = "Slider", Text = "Glow Outline Max", Var = "GlowOutlineMax", Min = 0, Max = 1, Dec = 1 }
                }
            },
        }
    }
}

local CombatlItemPanels = {
    {
        Name = "Exploit",
        ItemPanels = {
            {
                Name = "LocalPlayer",
                Height = 486,
                Pal = 1,
                Items = {
                    { Type = "CheckBox", Text = "Speed Hack", Var = "SpeedHack" },
                    { Type = "Slider", Text = "Speed", Var = "SpeedHackSlider", Min = 0, Max = 300, Dec = 0 },
                    { Type = "ComboBox", Text = "Speed Setting", Var = "SpeedVers", Options = {"Velocity", "CFrame"} },
                    { Type = "CheckBox", Text = "Noclip", Var = "Noclip" },
                    { Type = "CheckBox", Text = "No Collusion", Var = "NoCollision" },
                    { Type = "CheckBox", Text = "Logo Chat", Var = "LogoChat" },
                    { Type = "CheckBox", Text = "Fast Spin", Var = "FastSpin", bind = "FastSpinBind" },
                    { Type = "ComboBox", Text = "Taunt Spam", Var = "TauntSpam", Options = {"None", "Dance", "Point", "Laugh", "Cheer", "Custom"} },
                    { Type = "TextEntry", Text = "Taunt Custom", Var = "TauntCustom" }
                }
            },
            {
                Name = "Blox",
                Height = 233,
                Pal = 3,
                Items = {
                    { Type = "CheckBox", Text = "Hack Weapons", Var = "HackWeapons" },
                    { Type = "CheckBox", Text = "Itachi Mod", Var = "AntiKnife", bind = "AntiKnifeBind" },
                    { Type = "ComboBox", Text = "Itachi Mod Setting", Var = "AntiKnifeVars", Options = {"Distance", "In The Player"} },                    
                    { Type = "Slider", Text = "Distance", Var = "DistanceAntiKnife", Min = 0, Max = 1000, Dec = 0 },
                    { Type = "CheckBox", Text = "Team Teleport", Var = "TeamTeleport" },
                    { Type = "CheckBox", Text = "Camera Teleport", Var = "CameraTeleport", bind = "CameraTeleportBind" },
                    { Type = "CheckBox", Text = "Camera Teleport Team", Var = "CameraTeleportTeam" },
                }
            }
        }
    }
}

local ConfiglItemPanels = {
    {
        Name = "Config",
        ItemPanels = {
            {
                Name = "Main",
                Height = 486,
                Pal = 1,
                Items = {
                    { Type = "ConfigManager" }
                }
            }
        }
    },
    {
        Name = "test",
        ItemPanels = {
            {
                Name = "Main",
                Height = 486,
                Pal = 1,
                Items = {
                    { Type = "ComboBox", Text = "Target priority ", Var = "werter", Options = {"Distance", "ыфвфывфывфывфывфывфывыфв"} },
                    { Type = "CheckBox", Text = "No Recoil", Var = "sadwasdyasd" },
                    { Type = "ComboBox", Text = "Target priority", Var = "vfvfvfasd", Options = {"Distance", "FOV", "povs", "pisapopa"}, moresave = true },
                    { Type = "ColorPicker", Text = "Auto fire", Var = "tyerwew" },
                    { Type = "Bind", Text = "Auto fire", Var = "awdw" },
                    { Type = "TextEntry", Text = "test", Var = "testEntry" },
                    { Type = "CheckBox", Text = "No Recoil", Var = "sadwasdyasd" },
                    { Type = "CheckBox", Text = "No Recoil", Var = "sadwasdyasd" },
                    { Type = "CheckBox", Text = "No Recoil", Var = "sadwasdyasd" },
                    { Type = "CheckBox", Text = "No Recoil", Var = "sadwasdyasd" },
                    { Type = "CheckBox", Text = "No Recoil", Var = "sadwasdyasd" },
                    { Type = "CheckBox", Text = "No Recoil", Var = "sadwasdyasd" },
                    { Type = "CheckBox", Text = "No Recoil", Var = "sadwasdyasd" },
                    { Type = "CheckBox", Text = "No Recoil", Var = "sadwasdyasd" },
                    { Type = "CheckBox", Text = "No Recoil", Var = "sadwasdyasd" },
                    { Type = "CheckBox", Text = "No Recoil", Var = "sadwasdyasd" },
                    { Type = "CheckBox", Text = "No Recoil", Var = "sadwasdyasd" },
                    { Type = "CheckBox", Text = "No Recoil", Var = "sadwasdyasd" },
                    { Type = "CheckBox", Text = "No Recoil", Var = "sadwasdyasd" },
                    { Type = "CheckBox", Text = "No Recoil", Var = "sadwasdyasd" },
                    { Type = "CheckBox", Text = "No Recoil", Var = "sadwasdyasd" },
                    { Type = "CheckBox", Text = "No Recoil", Var = "sadwasdyasd" },
                    { Type = "CheckBox", Text = "No Recoil", Var = "sadwasdyasd" },
                    { Type = "CheckBox", Text = "No Recoil", Var = "sadwasdyasd" },
                    { Type = "CheckBox", Text = "No Recoil", Var = "sadwasdyasd" },
                    { Type = "CheckBox", Text = "No Recoil", Var = "sadwasdyasd" },
                    { Type = "CheckBox", Text = "No Recoil", Var = "sadwasdyasd" },
                    { Type = "CheckBox", Text = "No Recoil", Var = "sadwasdyasd" },
                    { Type = "CheckBox", Text = "No Recoil", Var = "sadwasdyasd" }
                }
            }
        }
    },
    {
        Name = "Help",
        ItemPanels = {
            {
                Name = "Ru Help",
                Height = 486,
                Pal = 1,
                Items = {
                    { Type = "TextList" }
                }
            },
            {
                Name = "Eng Help",
                Height = 486,
                Pal = 2,
                Items = {

                }
            }
        }
    }
}
--[[
486 это фуловая таблица,как бы да.Это для Height pal
233 это половина таблицы,будете на 3 делить сами давай те там

--]]
createTab("Aimbot", aimbotItemPanels)
createTab("Visual", VisualItemPanels)
createTab("Combat", CombatlItemPanels)
createTab("Misc")
createTab("Config", ConfiglItemPanels)
---------------------------------------------------Combat
local player = Fatality.LocalPlayer
local userInput = Fatality.UserInputService
local camera = Fatality.LocalCamera
local repStorage = game:GetService("ReplicatedStorage")
local defaultWalkSpeed
local speedhackConnection

local function updateSpeed()
    local character = player.Character
    if character and character:FindFirstChild("Humanoid") then
        local humanoid = character.Humanoid
        if not defaultWalkSpeed then
            defaultWalkSpeed = humanoid.WalkSpeed
        end
        local movementSpeed = player:FindFirstChild("MovementSpeed")
        if not movementSpeed then
            movementSpeed = Instance.new("IntValue")
            movementSpeed.Name = "MovementSpeed"
            movementSpeed.Parent = player
            movementSpeed.Value = defaultWalkSpeed  
            movementSpeed:GetPropertyChangedSignal("Value"):Connect(updateSpeed)
        end
        local movementSpeedValue = movementSpeed.Value or defaultWalkSpeed
        if Fatality.config.vars["SpeedHack"] and Fatality.config.vars["SpeedVers"] == "Velocity" then
            humanoid.WalkSpeed = Fatality.config.vars["SpeedHackSlider"] or movementSpeedValue
        else
            humanoid.WalkSpeed = movementSpeedValue
        end
        local huInfo = repStorage:FindFirstChild("HUInfo")
        if huInfo and huInfo:FindFirstChild("WalkSpeed") then
            huInfo.WalkSpeed.Value = humanoid.WalkSpeed
        end
    end
end

local function SpeedhackCFrame()
    if not (Fatality.config.vars["SpeedHack"] and Fatality.config.vars["SpeedVers"] == "CFrame") then return end
    if speedhackConnection then return end
    local targetLookVector = nil
    speedhackConnection = Fatality.RunService.RenderStepped:Connect(function(deltaTime)
        local character = player.Character
        if not character then return end
        local hrp = character:FindFirstChild("HumanoidRootPart")
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if not hrp or not humanoid then return end
        local currentPos = hrp.Position
        local moveDir = Vector3.new(0, 0, 0)
        if userInput:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + camera.CFrame.LookVector end
        if userInput:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - camera.CFrame.LookVector end
        if userInput:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - camera.CFrame.RightVector end
        if userInput:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + camera.CFrame.RightVector end
        moveDir = Vector3.new(moveDir.X, 0, moveDir.Z)
        local verticalDelta = 0
        if userInput:IsKeyDown(Enum.KeyCode.Space) and humanoid.FloorMaterial ~= Enum.Material.Air then
            verticalDelta = Fatality.config.vars["JumpBloxSlider"] * deltaTime
            humanoid.JumpHeight = Fatality.config.vars["JumpBloxSlider"] 
            humanoid.Jump = true
        elseif userInput:IsKeyDown(Enum.KeyCode.LeftControl) then
            verticalDelta = -20 * deltaTime
            humanoid.JumpHeight = 0
        else
            humanoid.JumpHeight = 0
        end
        if moveDir.Magnitude > 0 then
            moveDir = moveDir.Unit
            local speed = Fatality.config.vars["SpeedHackSlider"] 
            local horizontalDelta = moveDir * speed * deltaTime
            local newPos = Vector3.new(currentPos.X + horizontalDelta.X, currentPos.Y + verticalDelta, currentPos.Z + horizontalDelta.Z)
            targetLookVector = targetLookVector and targetLookVector:Lerp(moveDir, 0.05) or moveDir
            local newCFrame = CFrame.new(newPos, newPos + targetLookVector)
            hrp.CFrame = hrp.CFrame:Lerp(newCFrame, 0.4)
            humanoid.WalkSpeed = player:FindFirstChild("MovementSpeed") and player.MovementSpeed.Value or defaultWalkSpeed 
        else
            targetLookVector = nil
            humanoid.WalkSpeed = player:FindFirstChild("MovementSpeed") and player.MovementSpeed.Value or defaultWalkSpeed
            humanoid.JumpHeight = Fatality.config.vars["JumpBloxSlider"] 
            if userInput:IsKeyDown(Enum.KeyCode.Space) and humanoid.FloorMaterial ~= Enum.Material.Air then
                humanoid.Jump = true
            end
        end
    end)
end

local function stopSpeedhack()
    if speedhackConnection then
        speedhackConnection:Disconnect()
        speedhackConnection = nil
    end
end

local function HandleSpeedSystem()
    if Fatality.config.vars["SpeedHack"] then
        if Fatality.config.vars["SpeedVers"] == "Velocity" then
            updateSpeed()
            stopSpeedhack()
        elseif Fatality.config.vars["SpeedVers"] == "CFrame" then
            SpeedhackCFrame()
        else
            stopSpeedhack()
            updateSpeed()
        end
    else
        stopSpeedhack()
        updateSpeed()
    end
end
player.CharacterAdded:Connect(function()
    defaultWalkSpeed = nil
    HandleSpeedSystem()
end)
local existingMovementSpeed = player:FindFirstChild("MovementSpeed")
if existingMovementSpeed then
    existingMovementSpeed:GetPropertyChangedSignal("Value"):Connect(updateSpeed)
end

player.ChildAdded:Connect(function(child)
    if child.Name == "MovementSpeed" and child:IsA("IntValue") then
        child:GetPropertyChangedSignal("Value"):Connect(updateSpeed)
        updateSpeed()
    end
end)
Fatality.RunService.Heartbeat:Connect(HandleSpeedSystem)



local flying = false
local flyConnection = nil
local bodyVelocity = nil
local bodyGyro = nil 
local function disableFly()
    if not flying then return end
    flying = false
    local character = player.Character
    if not character then return end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.PlatformStand = false
    end
    if flyConnection then 
        flyConnection:Disconnect() 
    end
    if bodyVelocity then 
        bodyVelocity:Destroy() 
    end
    if bodyGyro then 
        bodyGyro:Destroy() 
    end
    flyConnection, bodyVelocity, bodyGyro = nil, nil, nil
end
local function enableFly()
    if flying then return end
    local character = player.Character
    if not character then return end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoid or not rootPart then return end
    flying = true
    humanoid.PlatformStand = true
    bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge) 
    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    bodyVelocity.Parent = rootPart
    bodyGyro = Instance.new("BodyGyro")
    bodyGyro.MaxTorque = Vector3.new(math.huge, 0, math.huge) 
    bodyGyro.P = 10000
    bodyGyro.D = 500
    bodyGyro.Parent = rootPart
    flyConnection = Fatality.RunService.RenderStepped:Connect(function()
        if not bodyGyro or not bodyGyro.Parent or not bodyVelocity or not bodyVelocity.Parent then
            disableFly() 
            return
        end
        local moveDirection = Vector3.new(0, 0, 0)
        local camera = Fatality.LocalCamera
        bodyGyro.CFrame = CFrame.new(Vector3.new(0, 0, 0), camera.CFrame.LookVector * Vector3.new(1, 0, 1))
        if Fatality.UserInputService:IsKeyDown(Enum.KeyCode.W) then 
            moveDirection = moveDirection + camera.CFrame.LookVector 
        end
        if Fatality.UserInputService:IsKeyDown(Enum.KeyCode.S) then 
            moveDirection = moveDirection - camera.CFrame.LookVector 
        end
        if Fatality.UserInputService:IsKeyDown(Enum.KeyCode.A) then 
            moveDirection = moveDirection - camera.CFrame.RightVector 
        end
        if Fatality.UserInputService:IsKeyDown(Enum.KeyCode.D) then 
            moveDirection = moveDirection + camera.CFrame.RightVector 
        end
        if Fatality.UserInputService:IsKeyDown(Enum.KeyCode.Space) then 
            moveDirection = moveDirection + Vector3.new(0, 1, 0) 
        end
        if Fatality.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then 
            moveDirection = moveDirection - Vector3.new(0, 1, 0) 
        end
        local currentSpeed = humanoid.WalkSpeed
        if moveDirection.Magnitude > 0 then
            bodyVelocity.Velocity = moveDirection.Unit * currentSpeed
        else
            bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        end
    end)
end
local function checkNoclip()
    if Fatality.config.vars["Noclip"] then
        enableFly()
    else
        disableFly()
    end
end
player.CharacterAdded:Connect(function(character)
    flying = false
    checkNoclip()
end)
Fatality.RunService.Heartbeat:Connect(checkNoclip)



local affectedParts = {}
local lastUpdateTime = 0
local updateInterval = 0.5 
local function updateCharacterCollisions(character)
    for _, part in ipairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = not Fatality.config.vars["NoCollision"]
        end
    end
    local descendantConnection
    descendantConnection = character.DescendantAdded:Connect(function(part)
        if part:IsA("BasePart") then
            part.CanCollide = not Fatality.config.vars["NoCollision"]
        end
    end)
    character.AncestryChanged:Connect(function()
        if not character:IsDescendantOf(game) then
            descendantConnection:Disconnect()
        end
    end)
end
local function updateCollisions(character)
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end
    local overlapParams = OverlapParams.new()
    overlapParams.FilterDescendantsInstances = {character} 
    overlapParams.FilterType = Enum.RaycastFilterType.Blacklist
    local parts = workspace:GetPartsInPart(humanoidRootPart, overlapParams)
    for _, part in ipairs(parts) do
        if part:IsA("BasePart") and part ~= humanoidRootPart then
            if Fatality.config.vars["NoCollision"] then
                if part.CanCollide then
                    affectedParts[part] = true
                    part.CanCollide = false
                end
            end
        end
    end
end
local function restoreCollisions()
    for part, _ in pairs(affectedParts) do
        if part.Parent then
            part.CanCollide = true
        end
    end
    affectedParts = {}
end
player.CharacterAdded:Connect(function(character)
    character:WaitForChild("Humanoid")
end)
local lastNoCollision = Fatality.config.vars["NoCollision"]
Fatality.RunService.Heartbeat:Connect(function()
    if lastNoCollision ~= Fatality.config.vars["NoCollision"] then
        lastNoCollision = Fatality.config.vars["NoCollision"]
        if player.Character then
            updateCharacterCollisions(player.Character)
            if not Fatality.config.vars["NoCollision"] then
                restoreCollisions()
            else
                updateCollisions(player.Character)
            end
        end
    end
    if Fatality.config.vars["NoCollision"] and player.Character then
        local currentTime = tick()
        if currentTime - lastUpdateTime >= updateInterval then
            lastUpdateTime = currentTime
            updateCollisions(player.Character)
        end
    end
end)



local player = Fatality.LocalPlayer
local spinning = false
local teleporting = false
local spinConnection = nil
local bodyAngularVelocity = nil
local spinSpeed = 100
local originalMass = {}

local function setMyCollision(character, canCollide)
    if character then
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") and part ~= character:FindFirstChild("HumanoidRootPart") then
                part.CanCollide = canCollide
            end
        end
    end
end

local function saveOriginalMass(character)
    if character then
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                originalMass[part] = part.Mass
            end
        end
    end
end

local function setMass(character, multiplier)
    if character then
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                if multiplier == 1 then
                    part.CustomPhysicalProperties = PhysicalProperties.new(originalMass[part] or part.Mass)
                else
                    part.CustomPhysicalProperties = PhysicalProperties.new((originalMass[part] or part.Mass) * multiplier)
                end
            end
        end
    end
end

local function handleSpin()
    if not Fatality.config.vars["FastSpin"] then
        if spinning then
            spinning = false
            if spinConnection then
                spinConnection:Disconnect()
                spinConnection = nil
            end
            if bodyAngularVelocity then
                bodyAngularVelocity:Destroy()
                bodyAngularVelocity = nil
            end
            local character = player.Character
            if character then
                local humanoid = character:FindFirstChildOfClass("Humanoid")
                local rootPart = character:FindFirstChild("HumanoidRootPart")
                if humanoid and rootPart then
                    humanoid.PlatformStand = false
                    rootPart.Anchored = false
                    if not Fatality.config.vars["AntiKnife"] then
                        setMyCollision(character, true)
                        setMass(character, 1)
                    end
                end
            end
        end
        return
    end
    if not spinning then
        spinning = true
        local character = player.Character
        if not character or not character:FindFirstChildOfClass("Humanoid") then return end
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        if not rootPart then return end
        humanoid.PlatformStand = false
        rootPart.Anchored = false
        setMyCollision(character, Fatality.config.vars["AntiKnife"])
        if Fatality.config.vars["AntiKnife"] then
            setMass(character, 10)
        else
            setMass(character, 1)
        end
        bodyAngularVelocity = Instance.new("BodyAngularVelocity")
        bodyAngularVelocity.MaxTorque = Vector3.new(0, math.huge, 0)
        bodyAngularVelocity.AngularVelocity = Vector3.new(0, spinSpeed, 0)
        bodyAngularVelocity.Parent = rootPart
        spinConnection = Fatality.RunService.RenderStepped:Connect(function()
            if not Fatality.config.vars["FastSpin"] then return end
            local character = player.Character
            if not character or not character:FindFirstChildOfClass("Humanoid") then return end
        end)
    end
end

local function getClosestPlayer()
    local closestPlayer = nil
    local closestDistance = Fatality.config.vars["DistanceAntiKnife"]
    local localPos = Fatality.LocalPlayer.Character and Fatality.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and Fatality.LocalPlayer.Character.HumanoidRootPart.Position

    if not localPos then return nil end

    for _, player in pairs(Fatality.Players:GetPlayers()) do
        if player ~= Fatality.LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
            if Fatality.config.vars["TeamTeleport"] and player.Team == Fatality.LocalPlayer.Team then
                continue 
            end
            local distance = (player.Character.HumanoidRootPart.Position - localPos).Magnitude
            if distance > closestDistance then
                closestPlayer = player
                closestDistance = distance
            end
        end
    end

    return closestPlayer
end

Fatality.RunService.Heartbeat:Connect(function()
    if not Fatality.config.vars["AntiKnife"] then
        if teleporting then
            teleporting = false
            local character = player.Character
            if character and not Fatality.config.vars["FastSpin"] then
                setMyCollision(character, true)
                setMass(character, 1)
            end
        end
    else
        if not teleporting then
            teleporting = true
            local character = player.Character
            if character then
                setMyCollision(character, Fatality.config.vars["FastSpin"])
                if Fatality.config.vars["FastSpin"] then
                    setMass(character, 10)
                else
                    setMass(character, 1)
                end
            end
        end

        local targetPlayer = getClosestPlayer()

        if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") and targetPlayer.Character:FindFirstChild("Humanoid") and targetPlayer.Character.Humanoid.Health > 0 then
            local localCharacter = Fatality.LocalPlayer.Character
            if localCharacter and localCharacter:FindFirstChild("HumanoidRootPart") then
                if Fatality.config.vars["AntiKnifeVars"] == "Distance" then
                    local teleportRadius = 10 
                    local angle = math.random() * 2 * math.pi
                    local offset = Vector3.new(math.cos(angle) * teleportRadius, 0, math.sin(angle) * teleportRadius)
                    local targetPos = targetPlayer.Character.HumanoidRootPart.Position + offset
                    localCharacter.HumanoidRootPart.CFrame = CFrame.new(targetPos)
                elseif Fatality.config.vars["AntiKnifeVars"] == "In The Player" then
                    local targetPos = targetPlayer.Character.HumanoidRootPart.Position
                    localCharacter.HumanoidRootPart.CFrame = CFrame.new(targetPos)
                end
            end
        end
    end

    handleSpin()
end)

Fatality.UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if Fatality.config.binds["FastSpinBind"] then
        if (input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Fatality.config.binds["FastSpinBind"]) or
           (input.UserInputType ~= Enum.UserInputType.Keyboard and input.UserInputType == Fatality.config.binds["FastSpinBind"]) then
            Fatality.config.vars["FastSpin"] = not Fatality.config.vars["FastSpin"]
            handleSpin()
        end
    end
    if Fatality.config.binds["AntiKnifeBind"] then
        if (input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Fatality.config.binds["AntiKnifeBind"]) or
           (input.UserInputType ~= Enum.UserInputType.Keyboard and input.UserInputType == Fatality.config.binds["AntiKnifeBind"]) then
            Fatality.config.vars["AntiKnife"] = not Fatality.config.vars["AntiKnife"]
        end
    end
end)

player.CharacterAdded:Connect(function(character)
    spinning = false
    teleporting = false
    saveOriginalMass(character)
    handleSpin()
end)



local generalChannel = Fatality.TextChatService.TextChannels:WaitForChild("RBXGeneral")
local player = game.Players.LocalPlayer
local message = "FATALITY.WIN"
local delayTime = 2
local messageIndex = 1
local MINECRAFT_list = {".", "/", ",", "-", "+", "_", "=", ":", ";", "!", "@", "#", "$", "%", "^", "&", "*", "(", ")", "[", "]", "{", "}", "|", "\\", "<", ">", "?", "`", "~"}  --{"ᔑ", "ʖ", "ᓵ", "↸", "ᒷ", "⊣", "⍑", "╎", "⋮", "ꖌ", "ꖎ"}
local isPaused = false
local timeSinceLastSend = 0

local function getRandomSGA()
    return MINECRAFT_list[math.random(1, #MINECRAFT_list)]
end

local function sendMessage()
    if not Fatality.config.vars["LogoChat"] or isPaused then
        return
    end

    local character = player.Character
    if character and character.Parent == game.Workspace then
        if messageIndex <= #message then
            local partial = string.sub(message, 1, messageIndex)
            local num_SGA = math.max(0, 11 - messageIndex)
            local random_SGAs = ""
            for i = 1, num_SGA do
                random_SGAs = random_SGAs .. getRandomSGA()
            end
            generalChannel:SendAsync(partial .. random_SGAs)
            messageIndex = messageIndex + 1
        else
            messageIndex = 1
        end
    end
end

generalChannel.MessageReceived:Connect(function(textChatMessage)
    if textChatMessage.TextSource and textChatMessage.TextSource.UserId == player.UserId then
        if textChatMessage.Text == "" or textChatMessage.Text == " " then
            isPaused = true
            task.wait(60)
            isPaused = false
        end
    end
end)

Fatality.RunService.Heartbeat:Connect(function(deltaTime)
    if isPaused then
        return
    end
    timeSinceLastSend = timeSinceLastSend + deltaTime
    if timeSinceLastSend >= delayTime then
        sendMessage()
        timeSinceLastSend = 0
    end
end)



local currentTauntTrack = nil
local lastTaunt = nil

local function playTaunt(animId)
    local character = Fatality.LocalPlayer.Character
    if not character or not character:FindFirstChild("Humanoid") then return end
    local humanoid = character.Humanoid
    local animator = humanoid:FindFirstChildOfClass("Animator")
    if not animator then return end

    if currentTauntTrack then
        currentTauntTrack:Stop()
        currentTauntTrack:Destroy()
        currentTauntTrack = nil
    end

    local success, result = pcall(function()
        local animation = Instance.new("Animation")
        animation.AnimationId = animId
        currentTauntTrack = animator:LoadAnimation(animation)
        currentTauntTrack.Looped = true
        currentTauntTrack:Play()
        return true
    end)

    if not success then
        return false
    end
    return true
end

local function stopTaunt()
    if currentTauntTrack then
        currentTauntTrack:Stop()
        currentTauntTrack:Destroy()
        currentTauntTrack = nil
    end
end

Fatality.LocalPlayer.CharacterAdded:Connect(function()
    stopTaunt()
    lastTaunt = nil
end)

Fatality.RunService.Heartbeat:Connect(function()
    if Fatality.config.vars["TauntSpam"] == "None" then
        stopTaunt()
        lastTaunt = nil
        return
    end

    if Fatality.config.vars["TauntSpam"] ~= lastTaunt then
        stopTaunt()
        local animId
        if Fatality.config.vars["TauntSpam"] == "Dance" then
            animId = "rbxassetid://507771955"
        elseif Fatality.config.vars["TauntSpam"] == "Point" then
            animId = "rbxassetid://507770453"
        elseif Fatality.config.vars["TauntSpam"] == "Laugh" then
            animId = "rbxassetid://507770818"
        elseif Fatality.config.vars["TauntSpam"] == "Cheer" then
            animId = "rbxassetid://507770239"
        elseif Fatality.config.vars["TauntSpam"] == "Custom" then
            animId = Fatality.config.vars["TauntCustom"] ~= "" and Fatality.config.vars["TauntCustom"] or nil
        end

        if animId and playTaunt(animId) then
            lastTaunt = Fatality.config.vars["TauntSpam"]
        else
            lastTaunt = nil
            stopTaunt()
        end
    end
end)



local originalTransparencies = {}
local isXrayActive = false
local isBindHeld = false

local function setTransparency(part, transparency)
    if part:IsA("BasePart") and not part:IsA("Terrain") then
        if not originalTransparencies[part] then
            originalTransparencies[part] = part.Transparency
        end
        part.Transparency = transparency
    end
end

local function applyXray(enable)
    if enable then
        for _, part in ipairs(game.Workspace:GetDescendants()) do
            setTransparency(part, 0.5)
        end
        isXrayActive = true
    else
        for part, originalTransparency in pairs(originalTransparencies) do
            if part.Parent then
                part.Transparency = originalTransparency
            end
        end
        originalTransparencies = {}
        isXrayActive = false
    end
end

local function onPartAdded(part)
    if isXrayActive and part:IsA("BasePart") and not part:IsA("Terrain") then
        setTransparency(part, 0.5)
    end
end

Fatality.UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and Fatality.config.binds["XrayBind"] and Fatality.config.vars["Xray"] then
        local bind = Fatality.config.binds["XrayBind"]
        if (input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == bind) or
           (input.UserInputType ~= Enum.UserInputType.Keyboard and input.UserInputType == bind) then
            isBindHeld = true
            if not isXrayActive then
                applyXray(true)
            end
        end
    end
end)

Fatality.UserInputService.InputEnded:Connect(function(input, gameProcessed)
    if not gameProcessed and Fatality.config.binds["XrayBind"] then
        local bind = Fatality.config.binds["XrayBind"]
        if (input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == bind) or
           (input.UserInputType ~= Enum.UserInputType.Keyboard and input.UserInputType == bind) then
            isBindHeld = false
            if not Fatality.config.vars["Xray"] and isXrayActive then
                applyXray(false)
            else
                if isXrayActive then
                    applyXray(false)
                end
            end
        end
    end
end)

Fatality.RunService.Heartbeat:Connect(function()
    local hasBind = Fatality.config.binds["XrayBind"] ~= nil
    local isXrayOn = Fatality.config.vars["Xray"]

    if isXrayOn then
        if hasBind then
            if isBindHeld then
                if not isXrayActive then
                    applyXray(true)
                end
            else
                if isXrayActive then
                    applyXray(false)
                end
            end
        else
            if not isXrayActive then
                applyXray(true)
            end
        end
    else
        if isXrayActive then
            applyXray(false)
        end
    end
end)

game.Workspace.DescendantAdded:Connect(onPartAdded)

Fatality.LocalPlayer.CharacterAdded:Connect(function()
    if isXrayActive then
        task.wait()
        applyXray(true)
    end
end)

--]]
---------------------------------------------------Aimbot
local chamsCharacters = {}
local holdingAimbotKey = false
local currentTarget = nil
local lastHealth = {}

local fovCircle = Drawing.new("Circle")
fovCircle.Visible = false
fovCircle.Transparency = 1
fovCircle.Thickness = 1
fovCircle.Color = Color3.new(1, 1, 1)
fovCircle.Filled = false

--[[
local snapLine = Drawing.new("Line")
snapLine.Visible = false
snapLine.Thickness = 1
snapLine.Color = Color3.new(1, 0, 0)
--]]

local function playHitSound()
    if Fatality.config.vars["HitSound"] == "None" then return end
    local sound = Instance.new("Sound")
    sound.Parent = game.Workspace
    sound.Volume = Fatality.config.vars["SoundValume"]
    if Fatality.config.vars["HitSound"] == "Metalic" then
        sound.SoundId = "rbxassetid://96599967895283" 
    elseif Fatality.config.vars["HitSound"] == "Fatality" then
        sound.SoundId = "rbxassetid://106299430307590"
    elseif Fatality.config.vars["HitSound"] == "Exp" then
        sound.SoundId = "rbxassetid://80611228518495"
    elseif Fatality.config.vars["HitSound"] == "Rust" then
        sound.SoundId = "rbxassetid://4764109000"
    elseif Fatality.config.vars["HitSound"] == "Bell" then
        sound.SoundId = "rbxassetid://96481309571950"
    end
    sound:Play()
    sound.Ended:Connect(function()
        sound:Destroy()
    end)
end

local function HeadVisible(head)
    if not head or not Fatality.LocalPlayer.Character then return false end
    local myHead = Fatality.LocalPlayer.Character:FindFirstChild("Head")
    if not myHead then return false end
    local origin = myHead.Position
    local target = head.Position
    local ignoreList = {Fatality.LocalPlayer.Character, head.Parent}
    for _, model in pairs(chamsCharacters) do
        if model and model:IsDescendantOf(workspace) then
            table.insert(ignoreList, model)
        end
    end
    local parts = Fatality.LocalCamera:GetPartsObscuringTarget({target}, ignoreList)
    return #parts == 0
end

local function IsValidTarget(player, head, myTeam, myUserId, ignoresAimbot)
    if not player.Character or not head then return false end
    local humanoid = player.Character:FindFirstChild("Humanoid")
    if not humanoid or humanoid.Health <= 0 then return false end
    local isGod = table.find(ignoresAimbot, "God time") and player.Character:FindFirstChild("ForceField") ~= nil
    local isSameTeam = table.find(ignoresAimbot, "Teammates") and player.Team == myTeam
    local isFriend = table.find(ignoresAimbot, "Friends Roblox") and Fatality.Players.LocalPlayer:IsFriendsWith(player.UserId)
    return not isGod and not isSameTeam and not isFriend
end

local function Aimbot()
    if not Fatality.LocalPlayer.Character or not Fatality.LocalPlayer.Character:FindFirstChild("Head") then
        currentTarget = nil
        return nil
    end
    local myHeadPos = Fatality.LocalPlayer.Character.Head.Position
    local myTeam = Fatality.LocalPlayer.Team
    local myUserId = Fatality.LocalPlayer.UserId
    local candidates = {}
    local cameraCFrame = Fatality.LocalCamera.CFrame
    local cameraForward = cameraCFrame.LookVector
    local maxFOV = Fatality.config.vars["FOVValue"] / 2
    local maxTargets = Fatality.config.vars["TargetSelection"] 
    local ignoresAimbot = Fatality.config.vars["IgnoresAimbot"]
    local targetPriority = Fatality.config.vars["TargetPriority"] 

    if targetPriority == "FOV" and currentTarget and currentTarget.Parent then
        local player = Fatality.Players:GetPlayerFromCharacter(currentTarget.Parent)
        if player and IsValidTarget(player, currentTarget, myTeam, myUserId, ignoresAimbot) then
            if table.find(ignoresAimbot, "Walls") or HeadVisible(currentTarget) then
                return currentTarget
            end
        end
        currentTarget = nil
    else
        currentTarget = nil
    end

    for _, player in ipairs(Fatality.Players:GetPlayers()) do
        if player ~= Fatality.LocalPlayer and player.Character then
            local enemyHead = player.Character:FindFirstChild("Head")
            if IsValidTarget(player, enemyHead, myTeam, myUserId, ignoresAimbot) then
                local headPos = enemyHead.Position
                local metric
                if targetPriority == "Distance" then
                    metric = (headPos - myHeadPos).Magnitude
                elseif targetPriority == "FOV" then
                    local vectorToHead = (headPos - myHeadPos).Unit
                    local angle = math.deg(math.acos(vectorToHead:Dot(cameraForward)))
                    if maxFOV >= 360 or angle <= maxFOV / 2 then
                        metric = angle
                    else
                        metric = math.huge
                    end
                end
                if metric < math.huge then
                    table.insert(candidates, {head = enemyHead, metric = metric, player = player})
                end
            end
        end
    end

    table.sort(candidates, function(a, b) return a.metric < b.metric end)

    if #candidates > 0 then
        for i = 1, math.min(maxTargets, #candidates) do
            if table.find(ignoresAimbot, "Walls") or HeadVisible(candidates[i].head) then
                currentTarget = candidates[i].head
                break
            end
        end
    end

    return currentTarget
end

--[[
local function GetSnaplineTarget()
    if not Fatality.LocalPlayer.Character or not Fatality.LocalPlayer.Character:FindFirstChild("Head") then
        return nil
    end
    local myHeadPos = Fatality.LocalPlayer.Character.Head.Position
    local myTeam = Fatality.LocalPlayer.Team
    local myUserId = Fatality.LocalPlayer.UserId
    local cameraCFrame = Fatality.LocalCamera.CFrame
    local cameraForward = cameraCFrame.LookVector
    local maxFOV = Fatality.config.vars["FOVValue"]
    local maxTargets = Fatality.config.vars["TargetSelection"] or 1
    local ignoresAimbot = Fatality.config.vars["IgnoresAimbot"] or {}
    local targetPriority = Fatality.config.vars["TargetPriority"]
    local candidates = {}

    for _, player in ipairs(Fatality.Players:GetPlayers()) do
        if player ~= Fatality.LocalPlayer and player.Character then
            local enemyHead = player.Character:FindFirstChild("Head")
            if IsValidTarget(player, enemyHead, myTeam, myUserId, ignoresAimbot) then
                if table.find(ignoresAimbot, "Walls") or HeadVisible(enemyHead) then
                    local headPos = enemyHead.Position
                    local metric
                    if targetPriority == "Distance" then
                        metric = (headPos - myHeadPos).Magnitude
                    elseif targetPriority == "FOV" then
                        local vectorToHead = (headPos - myHeadPos).Unit
                        local angle = math.deg(math.acos(vectorToHead:Dot(cameraForward)))
                        if maxFOV >= 360 or angle <= maxFOV / 2 then
                            metric = angle
                        else
                            metric = math.huge
                        end
                    end
                    if metric < math.huge then
                        table.insert(candidates, {head = enemyHead, metric = metric, player = player})
                    end
                end
            end
        end
    end

    table.sort(candidates, function(a, b) return a.metric < b.metric end)

    if #candidates > 0 then
        for i = 1, math.min(maxTargets, #candidates) do
            if table.find(ignoresAimbot, "Walls") or HeadVisible(candidates[i].head) then
                return candidates[i].head
            end
        end
    end

    return nil
end
--]]

Fatality.UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if Fatality.config.vars["enableAimbot"] and Fatality.config.binds["enableAimbotBind"] then
        if (input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Fatality.config.binds["enableAimbotBind"]) or
           (input.UserInputType ~= Enum.UserInputType.Keyboard and input.UserInputType == Fatality.config.binds["enableAimbotBind"]) then
            holdingAimbotKey = true
        end
    end
end)

Fatality.UserInputService.InputEnded:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if Fatality.config.vars["enableAimbot"] and Fatality.config.binds["enableAimbotBind"] then
        if (input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Fatality.config.binds["enableAimbotBind"]) or
           (input.UserInputType ~= Enum.UserInputType.Keyboard and input.UserInputType == Fatality.config.binds["enableAimbotBind"]) then
            holdingAimbotKey = false
            currentTarget = nil
        end
    end
end)

local lapdapdap = {}

local function KillerSound(character)
    local humanoid = character:WaitForChild("Humanoid")
    if not lapdapdap[character] then
        lapdapdap[character] = humanoid.Died:Connect(function()
            local killer = humanoid:FindFirstChild("creator")
            if killer and killer.Value == Fatality.LocalPlayer then
                local victim = Fatality.Players:GetPlayerFromCharacter(character)
                if victim then
                    playHitSound()
                end
            end
            lapdapdap[character]:Disconnect()
            lapdapdap[character] = nil
        end)
    end
end

local function setupAllPlayers()
    for _, otherPlayer in pairs(Fatality.Players:GetPlayers()) do
        if otherPlayer ~= Fatality.LocalPlayer and otherPlayer.Character then
            KillerSound(otherPlayer.Character)
        end
        if not lapdapdap[otherPlayer] then
            lapdapdap[otherPlayer] = otherPlayer.CharacterAdded:Connect(KillerSound)
        end
    end
end

setupAllPlayers()

Fatality.Players.PlayerAdded:Connect(function(newPlayer)
    if not lapdapdap[newPlayer] then
        lapdapdap[newPlayer] = newPlayer.CharacterAdded:Connect(KillerSound)
    end
    if newPlayer.Character then
        KillerSound(newPlayer.Character)
    end
end)



local originalValues = {}
local originalWeaponValues = {}
local originalAmmoValues = {}

local function processWeapon(weapon)
    local spread = weapon:FindFirstChild("Spread")
    
    if spread and not originalValues[weapon] then
        originalValues[weapon] = {Spread = spread.Value}
        for _, child in ipairs(spread:GetChildren()) do
            if child:IsA("NumberValue") then
                originalValues[weapon][child] = child.Value
            end
        end
    end

    if spread then
        for _, child in ipairs(spread:GetChildren()) do
            if child:IsA("NumberValue") then
                if table.find(Fatality.config.vars["BloxStrikeAimbot"], "NoRecoil") then
                    child.Value = 0
                else
                    child.Value = originalValues[weapon][child]
                end
            end
        end
        if table.find(Fatality.config.vars["BloxStrikeAimbot"], "NoRecoil") then
            spread.Value = 0
        else
            spread.Value = originalValues[weapon].Spread
        end
    end
end

local function processWeaponHack(weapon)
    local auto = weapon:FindFirstChild("Auto")
    local dmg = weapon:FindFirstChild("DMG")
    local equipTime = weapon:FindFirstChild("EquipTime")
    local fireRate = weapon:FindFirstChild("FireRate")
    local reloadTime = weapon:FindFirstChild("ReloadTime")
    local penetration = weapon:FindFirstChild("Penetration")
    local killAward = weapon:FindFirstChild("KillAward")
    --local dropmefps = weapon:FindFirstChild("BulletPerTrail")
    local dropmefps1 = weapon:FindFirstChild("Bullets")

    if not originalWeaponValues[weapon] then
        originalWeaponValues[weapon] = {}
        if auto then originalWeaponValues[weapon].Auto = auto.Value end
        if dmg then originalWeaponValues[weapon].DMG = dmg.Value end
        if equipTime then originalWeaponValues[weapon].EquipTime = equipTime.Value end
        if fireRate then originalWeaponValues[weapon].FireRate = fireRate.Value end
        if reloadTime then originalWeaponValues[weapon].ReloadTime = reloadTime.Value end
        if penetration then originalWeaponValues[weapon].Penetration = penetration.Value end
        if killAward then originalWeaponValues[weapon].KillAward = killAward.Value end
        --if dropmefps then originalWeaponValues[weapon].dropmefps = dropmefps.Value end
        if dropmefps1 then originalWeaponValues[weapon].dropmefps1 = dropmefps1.Value end
    end

    if Fatality.config.vars["HackWeapons"] then
        if auto then auto.Value = true end
        if dmg then dmg.Value = 1000 end
        if equipTime then equipTime.Value = 0.01 end
        if fireRate then fireRate.Value = 0 end
        if reloadTime then reloadTime.Value = 0.01 end
        if penetration then penetration.Value = 99999 end
        if killAward then killAward.Value = 99999 end
        --if dropmefps then dropmefps.Value = 9999 end
        --if dropmefps1 then dropmefps1.Value = 9999 end 
    else
        if auto and originalWeaponValues[weapon].Auto ~= nil then auto.Value = originalWeaponValues[weapon].Auto end
        if dmg and originalWeaponValues[weapon].DMG ~= nil then dmg.Value = originalWeaponValues[weapon].DMG end
        if equipTime and originalWeaponValues[weapon].EquipTime ~= nil then equipTime.Value = originalWeaponValues[weapon].EquipTime end
        if fireRate and originalWeaponValues[weapon].FireRate ~= nil then fireRate.Value = originalWeaponValues[weapon].FireRate end
        if reloadTime and originalWeaponValues[weapon].ReloadTime ~= nil then reloadTime.Value = originalWeaponValues[weapon].ReloadTime end
        if penetration and originalWeaponValues[weapon].Penetration ~= nil then penetration.Value = originalWeaponValues[weapon].Penetration end
        if killAward and originalWeaponValues[weapon].KillAward ~= nil then killAward.Value = originalWeaponValues[weapon].KillAward end
        --if dropmefps and originalWeaponValues[weapon].dropmefps ~= nil then dropmefps.Value = originalWeaponValues[weapon].dropmefps end
        --if dropmefps1 and originalWeaponValues[weapon].dropmefps1 ~= nil then dropmefps1.Value = originalWeaponValues[weapon].dropmefps1 end
    end

    if table.find(Fatality.config.vars["BloxStrikeAimbot"], "DoubleTap") then
        if dropmefps1 then dropmefps1.Value = 2 end
    else
        if dropmefps1 and originalWeaponValues[weapon].dropmefps1 ~= nil then dropmefps1.Value = originalWeaponValues[weapon].dropmefps1 end
    end

    return {
        Auto = auto and auto.Value,
        DMG = dmg and dmg.Value,
        EquipTime = equipTime and equipTime.Value,
        FireRate = fireRate and fireRate.Value,
        ReloadTime = reloadTime and reloadTime.Value,
        Penetration = penetration and penetration.Value,
        KillAward = killAward and killAward.Value,
        --dropmefps = dropmefps and dropmefps.Value,
        dropmefps1 = dropmefps1 and dropmefps1.Value
    }
end

local function processWeaponAmmo(weapon)
    local ammo = weapon:FindFirstChild("Ammo")
    local storedAmmo = weapon:FindFirstChild("StoredAmmo")
    if (ammo or storedAmmo) and not originalAmmoValues[weapon] then
        originalAmmoValues[weapon] = {
            Ammo = ammo and ammo.Value or nil,
            StoredAmmo = storedAmmo and storedAmmo.Value or nil
        }
    end
    if table.find(Fatality.config.vars["BloxStrikeAimbot"], "MoreAmmo") then
        if ammo then ammo.Value = 99999 end
        if storedAmmo then storedAmmo.Value = 99999 end
    else
        if ammo and originalAmmoValues[weapon] and originalAmmoValues[weapon].Ammo ~= nil then
            ammo.Value = originalAmmoValues[weapon].Ammo
        end
        if storedAmmo and originalAmmoValues[weapon] and originalAmmoValues[weapon].StoredAmmo ~= nil then
            storedAmmo.Value = originalAmmoValues[weapon].StoredAmmo
        end
    end
end

local WeaponsFolder = repStorage:FindFirstChild("Weapons")

local function updateAll()
    if not WeaponsFolder then return end 
    for _, weapon in ipairs(WeaponsFolder:GetChildren()) do
        if weapon:IsA("Folder") then
            processWeapon(weapon)
            processWeaponHack(weapon)
            processWeaponAmmo(weapon)
        end
    end
end

updateAll()

if WeaponsFolder then
    WeaponsFolder.ChildAdded:Connect(function(child)
        if child:IsA("Folder") then
            processWeapon(child)
            processWeaponHack(child)
            processWeaponAmmo(child)
        end
    end)

    WeaponsFolder.ChildRemoved:Connect(function(child)
        originalValues[child] = nil
        originalWeaponValues[child] = nil
        originalAmmoValues[child] = nil
    end)
end

repStorage.ChildAdded:Connect(function(child)
    if child.Name == "Weapons" then
        WeaponsFolder = child
        updateAll()
        WeaponsFolder.ChildAdded:Connect(function(weapon)
            if weapon:IsA("Folder") then
                processWeapon(weapon)
                processWeaponHack(weapon)
                processWeaponAmmo(weapon)
            end
        end)
        WeaponsFolder.ChildRemoved:Connect(function(weapon)
            originalValues[weapon] = nil
            originalWeaponValues[weapon] = nil
            originalAmmoValues[weapon] = nil
        end)
    end
end)

local lastConfig = {BloxStrikeAimbot = Fatality.config.vars["BloxStrikeAimbot"] or {}, HackWeapons = Fatality.config.vars["HackWeapons"]}
Fatality.RunService.Heartbeat:Connect(function()
    local currentConfig = {BloxStrikeAimbot = Fatality.config.vars["BloxStrikeAimbot"] or {}, HackWeapons = Fatality.config.vars["HackWeapons"]}
    if currentConfig.BloxStrikeAimbot ~= lastConfig.BloxStrikeAimbot or currentConfig.HackWeapons ~= lastConfig.HackWeapons then
        if (table.find(currentConfig.BloxStrikeAimbot, "NoRecoil") ~= nil) ~= (table.find(lastConfig.BloxStrikeAimbot, "NoRecoil") ~= nil) then
            if WeaponsFolder then 
                for _, weapon in ipairs(WeaponsFolder:GetChildren()) do
                    if weapon:IsA("Folder") then
                        processWeapon(weapon)
                    end
                end
            end
        end
        if currentConfig.HackWeapons ~= lastConfig.HackWeapons then
            if WeaponsFolder then 
                for _, weapon in ipairs(WeaponsFolder:GetChildren()) do
                    if weapon:IsA("Folder") then
                        processWeaponHack(weapon)
                    end
                end
            end
        end
        if (table.find(currentConfig.BloxStrikeAimbot, "MoreAmmo") ~= nil) ~= (table.find(lastConfig.BloxStrikeAimbot, "MoreAmmo") ~= nil) then
            if WeaponsFolder then 
                for _, weapon in ipairs(WeaponsFolder:GetChildren()) do
                    if weapon:IsA("Folder") then
                        processWeaponAmmo(weapon)
                    end
                end
            end
        end
        if (table.find(currentConfig.BloxStrikeAimbot, "DoubleTap") ~= nil) ~= (table.find(lastConfig.BloxStrikeAimbot, "DoubleTap") ~= nil) then
            if WeaponsFolder then 
                for _, weapon in ipairs(WeaponsFolder:GetChildren()) do
                    if weapon:IsA("Folder") then
                        processWeaponHack(weapon)
                    end
                end
            end
        end
        lastConfig = currentConfig
    end
end)



local camera = Fatality.LocalCamera
local originalCameraType
local originalCameraSubject
local CameraTeleportActive = false
local distance = 3

local function CameraTeleport()
    if not Fatality.LocalPlayer.Character or not Fatality.LocalPlayer.Character:FindFirstChild("Head") then
        return nil
    end
    local myHeadPos = Fatality.LocalPlayer.Character.Head.Position
    local myTeam = Fatality.LocalPlayer.Team 
    local closestHead, closestDistance = nil, math.huge
    for _, player in ipairs(Fatality.Players:GetPlayers()) do
        if player ~= Fatality.LocalPlayer and player.Character then
            local humanoid = player.Character:FindFirstChild("Humanoid")
            local enemyHead = player.Character:FindFirstChild("Head")
            if humanoid and humanoid.Health > 0 and enemyHead and enemyHead:IsA("BasePart") then
                if not (Fatality.config.vars["CameraTeleportTeam"] and myTeam and player.Team == myTeam) then
                    local distance = (enemyHead.Position - myHeadPos).Magnitude
                    if distance < closestDistance then
                        closestDistance = distance
                        closestHead = enemyHead
                    end
                end
            end
        end
    end
    return closestHead
end

Fatality.UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and Fatality.config.binds["CameraTeleportBind"] then
        local bind = Fatality.config.binds["CameraTeleportBind"]
        if (input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == bind) or
           (input.UserInputType ~= Enum.UserInputType.Keyboard and input.UserInputType == bind) then
            if Fatality.config.vars["Thirdperson"] then
                Fatality.config.vars["Thirdperson"] = false
            end
            if Fatality.config.vars["FreeCamera"] then
                Fatality.config.vars["FreeCamera"] = false
            end
            Fatality.config.vars["CameraTeleport"] = not Fatality.config.vars["CameraTeleport"]
        end
    end
end)

Fatality.LocalPlayer.CharacterAdded:Connect(function()
    if CameraTeleportActive then
        camera.CameraType = originalCameraType
        camera.CameraSubject = originalCameraSubject
        CameraTeleportActive = false
        Fatality.config.vars["CameraTeleport"] = false
    end
end)

Fatality.RunService.RenderStepped:Connect(function()
    if Fatality.config.vars["CameraTeleport"] then
        if not CameraTeleportActive then
            originalCameraType = camera.CameraType
            originalCameraSubject = camera.CameraSubject
            CameraTeleportActive = true
        end
        local targetHead = CameraTeleport()
        if targetHead then
            local offsetDirection = (targetHead.Position - Fatality.LocalPlayer.Character.Head.Position).Unit
            local cameraPosition = targetHead.Position + offsetDirection * distance
            camera.CameraType = Enum.CameraType.Scriptable
            camera.CFrame = CFrame.new(cameraPosition, targetHead.Position)
            local character = Fatality.LocalPlayer.Character
            local tool = character:FindFirstChildOfClass("Tool")
            if tool then
                local handle = tool:FindFirstChild("Handle") or tool:FindFirstChildWhichIsA("BasePart")
                if handle then
                    handle.CFrame = camera.CFrame * CFrame.new(0, -1, -2)
                end
            end
        else
            camera.CameraType = originalCameraType
            camera.CameraSubject = originalCameraSubject
        end
    else
        if CameraTeleportActive then
            camera.CameraType = originalCameraType
            camera.CameraSubject = originalCameraSubject
            CameraTeleportActive = false
        end
    end
end)
--]]
---------------------------------------------------Esp
local Players = Fatality.Players
local RunService = Fatality.RunService
local LocalPlayer = Fatality.LocalPlayer
local Camera = Fatality.LocalCamera
local gui = Fatality.gui 

Fatality.config.vars["HealthPos"] = 4
Fatality.config.vars["NamePos"] = 1
Fatality.config.vars["TeamPos"] = 3
Fatality.config.vars["WepPlayerPos"] = 2
Fatality.config.vars["DistancePlayerPos"] = 2

local ESP_Boxes = {}
local parts = {"Head", "HumanoidRootPart", "Torso", "UpperTorso", "LowerTorso", "Left Leg", "Right Leg", "Left Arm", "Right Arm", "LeftFoot", "LeftUpperArm", "LeftUpperLeg", "RightFoot", "RightUpperArm", "RightUpperLeg"}
--Все хитбоксы одной из моделей "LeftFoot","LeftHand","LeftLowerArm","LeftLowerLeg","LeftUpperArm","LeftUpperLeg","LowerTorso","LeftLowerLeg","LeftUpperLeg","LowerTorso","RightFoot","RightHand","RightLowerArm","RightLowerLeg","RightUpperArm","RightUpperLeg","UpperTorso"

local function GetBoundingBox(character)
    if not character then return nil end
    local min, max = Vector3.new(math.huge, math.huge, math.huge), Vector3.new(-math.huge, -math.huge, -math.huge)
    local found = false
    for _, partName in ipairs(parts) do
        local part = character:FindFirstChild(partName)
        if part and part:IsA("BasePart") then
            local pos, size = part.Position, part.Size / 2
            min = min:Min(pos - size)
            max = max:Max(pos + size)
            found = true
        end
    end
    if not found then return nil end
    return min, max
end

local function WorldToScreenBox(min, max)
    local corners = {
        Vector3.new(min.X, min.Y, min.Z), Vector3.new(min.X, min.Y, max.Z),
        Vector3.new(min.X, max.Y, min.Z), Vector3.new(min.X, max.Y, max.Z),
        Vector3.new(max.X, min.Y, min.Z), Vector3.new(max.X, min.Y, max.Z),
        Vector3.new(max.X, max.Y, min.Z), Vector3.new(max.X, max.Y, max.Z)
    }
    local minX, maxX, minY, maxY = math.huge, -math.huge, math.huge, -math.huge
    local anyOnScreen = false
    local screenCorners = {}
    for i, corner in ipairs(corners) do
        local pos, onScreen = Camera:WorldToViewportPoint(corner)
        if onScreen then
            anyOnScreen = true
            minX = math.min(minX, pos.X)
            maxX = math.max(maxX, pos.X)
            minY = math.min(minY, pos.Y)
            maxY = math.max(maxY, pos.Y)
            screenCorners[i] = Vector2.new(pos.X, pos.Y)
        else
            screenCorners[i] = nil
        end
    end
    return anyOnScreen and {minX = minX, maxX = maxX, minY = minY, maxY = maxY, corners = screenCorners} or nil
end

local function GetTextPositions(minX, minY, maxX, maxY, types, enabled, textContents)
    local grouped = {}
    for i, posType in ipairs(types) do
        if enabled[i] and textContents[i] and textContents[i] ~= "" then
            grouped[posType] = grouped[posType] or {}
            table.insert(grouped[posType], i)
        end
    end
    local positions = {}
    for posType, indices in pairs(grouped) do
        for i, index in ipairs(indices) do
            local offset = (i - 1) * 25
            if posType == 1 then
                positions[index] = Vector2.new((minX + maxX) / 2, minY - 30 - offset)
            elseif posType == 2 then
                positions[index] = Vector2.new((minX + maxX) / 2, maxY + 5 + offset)
            elseif posType == 3 then
                positions[index] = Vector2.new(maxX + 10, minY + offset)
            elseif posType == 4 then
                positions[index] = Vector2.new(minX - 25, minY + offset)
            end
        end
    end
    return positions
end

local function CreateESPBox(player)
    if player == LocalPlayer then return end
    local box = {TopLeft = Drawing.new("Line"),TopRight = Drawing.new("Line"),BottomLeft = Drawing.new("Line"),BottomRight = Drawing.new("Line"),Left = Drawing.new("Line"),Right = Drawing.new("Line"),Top = Drawing.new("Line"),Bottom = Drawing.new("Line"),BackTopLeft = Drawing.new("Line"),BackTopRight = Drawing.new("Line"),BackBottomLeft = Drawing.new("Line"),BackBottomRight = Drawing.new("Line")}
    for _, line in pairs(box) do
        line.Visible = false
        line.Color = Fatality.config.colors["EspCol"] 
        line.Transparency = Fatality.config.colors.alpha["EspCol"]
        line.Thickness = 2
        line.ZIndex = 2
    end
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "ESP_" .. player.Name
    screenGui.Parent = gui
    screenGui.IgnoreGuiInset = true

    local nameLabel = Instance.new("TextLabel")
    nameLabel.BackgroundTransparency = 1
    nameLabel.TextColor3 = Fatality.config.colors["NameCol"] 
    nameLabel.TextTransparency = 1 - Fatality.config.colors.alpha["NameCol"]
    nameLabel.TextStrokeTransparency = 0
    nameLabel.TextSize = 14
    nameLabel.Font = Enum.Font.Ubuntu
    nameLabel.Size = UDim2.new(0, 100, 0, 20)
    nameLabel.Visible = false
    nameLabel.TextXAlignment = Fatality.config.vars["NamePos"] ~= 3 and Enum.TextXAlignment.Center or Enum.TextXAlignment.Left
    nameLabel.Parent = screenGui

    local healthLabel = Instance.new("TextLabel")
    healthLabel.BackgroundTransparency = 1
    healthLabel.TextColor3 = Fatality.config.colors["HealthPlayerCol"] 
    healthLabel.TextTransparency = 1 - Fatality.config.colors.alpha["HealthPlayerCol"] 
    healthLabel.TextStrokeTransparency = 0
    healthLabel.TextSize = 14
    healthLabel.Font = Enum.Font.Ubuntu
    healthLabel.Size = UDim2.new(0, 100, 0, 20)
    healthLabel.Visible = false
    healthLabel.TextXAlignment = Fatality.config.vars["HealthPos"] ~= 3 and Enum.TextXAlignment.Center or Enum.TextXAlignment.Left
    healthLabel.Parent = screenGui

    local teamLabel = Instance.new("TextLabel")
    teamLabel.BackgroundTransparency = 1
    teamLabel.TextColor3 = Fatality.config.colors["TeamCol"] 
    teamLabel.TextTransparency = 1 - Fatality.config.colors.alpha["TeamCol"]
    teamLabel.TextStrokeTransparency = 0
    teamLabel.TextSize = 14
    teamLabel.Font = Enum.Font.Ubuntu
    teamLabel.Size = UDim2.new(0, 100, 0, 20)
    teamLabel.Visible = false
    teamLabel.TextXAlignment = Fatality.config.vars["TeamPos"] ~= 3 and Enum.TextXAlignment.Center or Enum.TextXAlignment.Left
    teamLabel.Parent = screenGui

    local weaponLabel = Instance.new("TextLabel")
    weaponLabel.BackgroundTransparency = 1
    weaponLabel.TextColor3 = Fatality.config.colors["WepPlayerCol"] 
    weaponLabel.TextTransparency = 1 - Fatality.config.colors.alpha["WepPlayerCol"]
    weaponLabel.TextStrokeTransparency = 0
    weaponLabel.TextSize = 14
    weaponLabel.Font = Enum.Font.Ubuntu
    weaponLabel.Size = UDim2.new(0, 100, 0, 20)
    weaponLabel.Visible = false
    weaponLabel.TextXAlignment = Fatality.config.vars["WepPlayerPos"] ~= 3 and Enum.TextXAlignment.Center or Enum.TextXAlignment.Left
    weaponLabel.Parent = screenGui

    local distanceLabel = Instance.new("TextLabel")
    distanceLabel.BackgroundTransparency = 1
    distanceLabel.TextColor3 = Fatality.config.colors["DistancePlayerCol"] 
    distanceLabel.TextTransparency = 1 - Fatality.config.colors.alpha["DistancePlayerCol"]
    distanceLabel.TextStrokeTransparency = 0
    distanceLabel.TextSize = 14
    distanceLabel.Font = Enum.Font.Ubuntu
    distanceLabel.Size = UDim2.new(0, 100, 0, 20)
    distanceLabel.Visible = false
    distanceLabel.TextXAlignment = Fatality.config.vars["DistancePlayerPos"] ~= 3 and Enum.TextXAlignment.Center or Enum.TextXAlignment.Left
    distanceLabel.Parent = screenGui

    local healthSliderBG = Instance.new("Frame")
    healthSliderBG.BackgroundColor3 = Color3.fromRGB(56, 56, 56)
    healthSliderBG.BackgroundTransparency = 1 - Fatality.config.colors.alpha["HealthPlayerCol"]
    healthSliderBG.Visible = false
    healthSliderBG.Size = UDim2.new(0, 5, 0, 0)
    healthSliderBG.Position = UDim2.new(0, 0, 0, 0)
    healthSliderBG.ZIndex = 1
    healthSliderBG.Parent = screenGui

    local healthSlider = Instance.new("Frame")
    healthSlider.BackgroundColor3 = Fatality.config.colors["HealthPlayerCol"] 
    healthSlider.BackgroundTransparency = 1 - Fatality.config.colors.alpha["HealthPlayerCol"]
    healthSlider.Visible = false
    healthSlider.Size = UDim2.new(0, 5, 0, 0)
    healthSlider.Position = UDim2.new(0, 0, 0, 0)
    healthSlider.ZIndex = 2
    healthSlider.Parent = screenGui

    ESP_Boxes[player] = {box = box,screenGui = screenGui,nameLabel = nameLabel,healthLabel = healthLabel,teamLabel = teamLabel,weaponLabel = weaponLabel,distanceLabel = distanceLabel,healthSlider = healthSlider,healthSliderBG = healthSliderBG,lastName = "",lastTeam = "",lastWeapon = "",lastDistance = "",lastHealth = ""}
end

local lastCameraCFrame = nil
local headYOffset = nil

local function UpdateESP()
    local lastUpdate = tick()
    RunService.RenderStepped:Connect(function(deltaTime)
        if not Fatality.LocalCamera or not Fatality.LocalPlayer then return end
        local cameraFOV = Fatality.LocalCamera.FieldOfView
        local viewportSize = Fatality.LocalCamera.ViewportSize
        local maxFOV = Fatality.config.vars["FOVValue"] / 2
        local fovRadius = 0
        if maxFOV < 360 then
            local vFOVRad = math.rad(maxFOV)
            fovRadius = (viewportSize.Y / 2) * math.tan(vFOVRad / 2) / math.tan(math.rad(cameraFOV) / 2)
        else
            fovRadius = math.max(viewportSize.X, viewportSize.Y) * 0.7
        end
        fovCircle.Position = Vector2.new(viewportSize.X / 2, viewportSize.Y / 2)
        fovCircle.Radius = fovRadius
        fovCircle.Color = Fatality.config.colors["ShowFOVCol"]
        fovCircle.Transparency = Fatality.config.colors.alpha["ShowFOVCol"]
        local aimbotActive = Fatality.config.vars["enableAimbot"]
        if Fatality.config.binds["enableAimbotBind"] then
            aimbotActive = aimbotActive and holdingAimbotKey
        end
        fovCircle.Visible = aimbotActive and Fatality.config.vars["ShowFOV"] and maxFOV < 180 and Fatality.config.vars["TargetPriority"] == "FOV" and not Fatality.config.vars["FreeCamera"] and Menuframe.Visible == false 
        --[[
        snapLine.Color = Fatality.config.colors["AimbotSnaplineCol"] or Color3.new(1, 0, 0)
        snapLine.Transparency = Fatality.config.colors.alpha["AimbotSnaplineCol"] or 1
        snapLine.Visible = false
        if Fatality.config.vars["AimbotSnapline"] and Fatality.LocalPlayer.Character and Fatality.LocalPlayer.Character:FindFirstChild("Head") then
            local snapTarget = GetSnaplineTarget()
            if snapTarget then
                local targetPos = Fatality.LocalCamera:WorldToViewportPoint(snapTarget.Position)
                if targetPos.Z > 0 then
                    snapLine.From = Vector2.new(viewportSize.X / 2, viewportSize.Y / 2)
                    snapLine.To = Vector2.new(targetPos.X, targetPos.Y)
                    snapLine.Visible = true
                end
            end
        end
        --]]
        if aimbotActive and not Fatality.config.vars["CameraTeleport"] and not Fatality.config.vars["FreeCamera"] then
            local targetHead = Aimbot()
            if targetHead and Fatality.LocalPlayer.Character and Fatality.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and Fatality.LocalPlayer.Character:FindFirstChild("Head") then
                local myRootPos = Fatality.LocalPlayer.Character.HumanoidRootPart.Position
                if not headYOffset then
                    headYOffset = Fatality.LocalPlayer.Character.Head.Position.Y - myRootPos.Y
                end
                local cameraPos = Vector3.new(myRootPos.X, myRootPos.Y + headYOffset, myRootPos.Z)
                local targetCFrame = CFrame.new(cameraPos, targetHead.Position)
                local currentPos = Fatality.LocalCamera.CFrame.Position
                local targetPos = targetCFrame.Position
                local distance = (currentPos - targetPos).Magnitude
                if distance > 0.1 then
                    local newPos = currentPos:Lerp(targetPos, 0.1)
                    Fatality.LocalCamera.CFrame = CFrame.new(newPos, targetHead.Position)
                else
                    Fatality.LocalCamera.CFrame = targetCFrame
                end
                lastCameraCFrame = Fatality.LocalCamera.CFrame
                local player = Fatality.Players:GetPlayerFromCharacter(targetHead.Parent)
                if player then
                    local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                    if humanoid then
                        if not lastHealth[player] then
                            lastHealth[player] = humanoid.Health
                        elseif not Fatality.config.vars["HitSoundKill"] and humanoid.Health < lastHealth[player] then
                            playHitSound()
                        end
                        lastHealth[player] = humanoid.Health
                    end
                end
                if Fatality.config.vars["AutoFire"] then
                    AutoFire()
                end
            else
                lastCameraCFrame = nil
                headYOffset = nil
            end
        else
            lastCameraCFrame = nil
            headYOffset = nil
        end

        local updateInterval = Fatality.config.vars["ESPUpdateInterval"] / 1000
        if not (Fatality.config.vars["EspBox"] or Fatality.config.vars["Name"] or Fatality.config.vars["HealthPlayer"] or Fatality.config.vars["WeaponPlayer"] or Fatality.config.vars["TeamPlayer"] or Fatality.config.vars["DistancePlayer"]) then
            for _, elements in pairs(ESP_Boxes) do
                for _, line in pairs(elements.box) do line.Visible = false end
                elements.nameLabel.Visible = false
                elements.healthLabel.Visible = false
                elements.teamLabel.Visible = false
                elements.weaponLabel.Visible = false
                elements.distanceLabel.Visible = false
                elements.healthSlider.Visible = false
                elements.healthSliderBG.Visible = false
            end
            return
        end
        local currentTime = tick()
        if currentTime - lastUpdate < updateInterval then return end
        lastUpdate = currentTime
        local localCharacter = LocalPlayer.Character
        local localRoot = localCharacter and localCharacter:FindFirstChild("HumanoidRootPart")
        for player, elements in pairs(ESP_Boxes) do
            local box = elements.box
            local nameLabel = elements.nameLabel
            local healthLabel = elements.healthLabel
            local teamLabel = elements.teamLabel
            local weaponLabel = elements.weaponLabel
            local distanceLabel = elements.distanceLabel
            local healthSlider = elements.healthSlider
            local healthSliderBG = elements.healthSliderBG
            local function HideEsp()
                for _, line in pairs(box) do line.Visible = false end
                nameLabel.Visible = false
                healthLabel.Visible = false
                teamLabel.Visible = false
                weaponLabel.Visible = false
                distanceLabel.Visible = false
                healthSlider.Visible = false
                healthSliderBG.Visible = false
            end
            if player == LocalPlayer or not player.Parent then
                HideEsp()
                continue
            end
            local character = player.Character
            local humanoid = character and character:FindFirstChildOfClass("Humanoid")
            local playerRoot = character and character:FindFirstChild("HumanoidRootPart")
            if not (character and humanoid and playerRoot) or humanoid.Health <= 0 then
                HideEsp()
                continue
            end
            local _, onScreen = Camera:WorldToViewportPoint(playerRoot.Position)
            if not onScreen then
                HideEsp()
                continue
            end
            if Fatality.config.vars["DistanceESP"] and localRoot and playerRoot then
                local distance = (localRoot.Position - playerRoot.Position).Magnitude
                if distance > Fatality.config.vars["DistanceESP"] then
                    HideEsp()
                    continue
                end
            end
            local min, max = GetBoundingBox(character)
            if not min or not max then
                HideEsp()
                continue
            end
            local screenBox = WorldToScreenBox(min, max)
            if not screenBox then
                HideEsp()
                continue
            end
            if Fatality.config.vars["EspBox"] then
                local boxWidth = screenBox.maxX - screenBox.minX
                local boxHeight = screenBox.maxY - screenBox.minY
                local boxPosition = Vector2.new(screenBox.minX, screenBox.minY)
                local boxColor = Fatality.config.colors["EspCol"] 
                local boxAlpha = Fatality.config.colors.alpha["EspCol"] 
                for _, line in pairs(box) do line.Visible = false end
                if Fatality.config.vars["BoxStyle"] == "Box 3D" then
                    local front = {
                        TL = screenBox.corners[4],
                        TR = screenBox.corners[8],
                        BL = screenBox.corners[2],
                        BR = screenBox.corners[6]
                    }
                    local back = {
                        TL = screenBox.corners[3],
                        TR = screenBox.corners[7],
                        BL = screenBox.corners[1],
                        BR = screenBox.corners[5]
                    }
                    if front.TL and front.TR and front.BL and front.BR and
                       back.TL and back.TR and back.BL and back.BR then
                        box.TopLeft.From = front.TL
                        box.TopLeft.To = front.TR
                        box.TopLeft.Visible = true
                        box.TopRight.From = front.TR
                        box.TopRight.To = front.BR
                        box.TopRight.Visible = true
                        box.BottomLeft.From = front.BL
                        box.BottomLeft.To = front.BR
                        box.BottomLeft.Visible = true
                        box.BottomRight.From = front.TL
                        box.BottomRight.To = front.BL
                        box.BottomRight.Visible = true
                        box.Left.From = back.TL
                        box.Left.To = back.TR
                        box.Left.Visible = true
                        box.Right.From = back.TR
                        box.Right.To = back.BR
                        box.Right.Visible = true
                        box.Top.From = back.BL
                        box.Top.To = back.BR
                        box.Top.Visible = true
                        box.Bottom.From = back.TL
                        box.Bottom.To = back.BL
                        box.Bottom.Visible = true
                        box.BackTopLeft.From = front.TL
                        box.BackTopLeft.To = back.TL
                        box.BackTopLeft.Visible = true
                        box.BackTopRight.From = front.TR
                        box.BackTopRight.To = back.TR
                        box.BackTopRight.Visible = true
                        box.BackBottomLeft.From = front.BL
                        box.BackBottomLeft.To = back.BL
                        box.BackBottomLeft.Visible = true
                        box.BackBottomRight.From = front.BR
                        box.BackBottomRight.To = back.BR
                        box.BackBottomRight.Visible = true
                    end
                elseif Fatality.config.vars["BoxStyle"] == "Corner" then
                    local cornerSize = boxWidth * 0.2
                    box.TopLeft.From = boxPosition
                    box.TopLeft.To = boxPosition + Vector2.new(cornerSize, 0)
                    box.TopLeft.Visible = true
                    box.TopRight.From = boxPosition + Vector2.new(boxWidth, 0)
                    box.TopRight.To = boxPosition + Vector2.new(boxWidth - cornerSize, 0)
                    box.TopRight.Visible = true
                    box.BottomLeft.From = boxPosition + Vector2.new(0, boxHeight)
                    box.BottomLeft.To = boxPosition + Vector2.new(cornerSize, boxHeight)
                    box.BottomLeft.Visible = true
                    box.BottomRight.From = boxPosition + Vector2.new(boxWidth, boxHeight)
                    box.BottomRight.To = boxPosition + Vector2.new(boxWidth - cornerSize, boxHeight)
                    box.BottomRight.Visible = true
                    box.Left.From = boxPosition
                    box.Left.To = boxPosition + Vector2.new(0, cornerSize)
                    box.Left.Visible = true
                    box.Right.From = boxPosition + Vector2.new(boxWidth, 0)
                    box.Right.To = boxPosition + Vector2.new(boxWidth, cornerSize)
                    box.Right.Visible = true
                    box.Top.From = boxPosition + Vector2.new(0, boxHeight)
                    box.Top.To = boxPosition + Vector2.new(0, boxHeight - cornerSize)
                    box.Top.Visible = true
                    box.Bottom.From = boxPosition + Vector2.new(boxWidth, boxHeight)
                    box.Bottom.To = boxPosition + Vector2.new(boxWidth, boxHeight - cornerSize)
                    box.Bottom.Visible = true
                elseif Fatality.config.vars["BoxStyle"] == "Default" then
                    box.Left.From = boxPosition
                    box.Left.To = boxPosition + Vector2.new(0, boxHeight)
                    box.Left.Visible = true
                    box.Right.From = boxPosition + Vector2.new(boxWidth, 0)
                    box.Right.To = boxPosition + Vector2.new(boxWidth, boxHeight)
                    box.Right.Visible = true
                    box.Top.From = boxPosition
                    box.Top.To = boxPosition + Vector2.new(boxWidth, 0)
                    box.Top.Visible = true
                    box.Bottom.From = boxPosition + Vector2.new(0, boxHeight)
                    box.Bottom.To = boxPosition + Vector2.new(boxWidth, boxHeight)
                    box.Bottom.Visible = true
                    box.TopLeft.Visible = false
                    box.TopRight.Visible = false
                    box.BottomLeft.Visible = false
                    box.BottomRight.Visible = false
                end
                for _, line in pairs(box) do
                    if line.Visible then
                        line.Color = boxColor
                        line.Transparency = boxAlpha
                        line.Thickness = 2
                    end
                end
            else
                for _, line in pairs(box) do line.Visible = false end
            end
            local types = {Fatality.config.vars["NamePos"],Fatality.config.vars["HealthPos"],Fatality.config.vars["WepPlayerPos"],Fatality.config.vars["TeamPos"],Fatality.config.vars["DistancePlayerPos"]}
            local enabled = {Fatality.config.vars["Name"],Fatality.config.vars["HealthPlayer"],Fatality.config.vars["WeaponPlayer"],Fatality.config.vars["TeamPlayer"],Fatality.config.vars["DistancePlayer"]}
            local textContents = {"", "", "", "", ""}
            if enabled[1] then
                textContents[1] = player.Name or ""
            end
            if enabled[2] and humanoid then
                textContents[2] = tostring(math.floor(humanoid.Health))
            end
            if enabled[3] then
                local weaponName = ""
                local playerModel = game.Workspace:FindFirstChild(player.Name)
                if playerModel and playerModel:IsA("Model") then
                    local equippedTool = playerModel:FindFirstChild("EquippedTool")
                    if equippedTool and equippedTool:IsA("StringValue") and equippedTool.Value ~= "" then
                        weaponName = equippedTool.Value
                    elseif character then
                        local tool = character:FindFirstChildOfClass("Tool")
                        if tool then
                            weaponName = tool.Name
                        end
                    end
                end
                textContents[3] = weaponName
            end
            if enabled[4] then
                textContents[4] = player.Team and player.Team.Name or "No Team"
            end
            if enabled[5] and localRoot and playerRoot then
                textContents[5] = tostring(math.floor((localRoot.Position - playerRoot.Position).Magnitude)) .. "m"
            end
            local textPositions = GetTextPositions(screenBox.minX, screenBox.minY, screenBox.maxX, screenBox.maxY, types, enabled, textContents)
            if enabled[1] and textPositions[1] and textContents[1] ~= "" then
                if elements.lastName ~= textContents[1] then
                    nameLabel.Text = textContents[1]
                    elements.lastName = textContents[1]
                end
                local xOffset = Fatality.config.vars["NamePos"] ~= 3 and -50 or 0
                nameLabel.Position = UDim2.new(0, textPositions[1].X + xOffset, 0, textPositions[1].Y)
                nameLabel.TextColor3 = Fatality.config.colors["NameCol"] 
                nameLabel.TextTransparency = 1 - Fatality.config.colors.alpha["NameCol"]
                nameLabel.Visible = true
            else
                nameLabel.Visible = false
            end
            if enabled[2] and textPositions[2] and textContents[2] ~= "" and humanoid then
                if elements.lastHealth ~= textContents[2] then
                    healthLabel.Text = textContents[2]
                    elements.lastHealth = textContents[2]
                end
                local healthPerc = math.clamp(humanoid.Health / humanoid.MaxHealth, 0, 1)
                local color1 = Fatality.config.colors["HealthPlayerCol"] 
                local color2 = Fatality.config.colors["HealthPlayerCol2"]
                local alpha1 = Fatality.config.colors.alpha["HealthPlayerCol"] 
                local alpha2 = Fatality.config.colors.alpha["HealthPlayerCol2"] 
                local r = color1.R + (color2.R - color1.R) * (1 - healthPerc)
                local g = color1.G + (color2.G - color1.G) * (1 - healthPerc)
                local b = color1.B + (color2.B - color1.B) * (1 - healthPerc)
                local alpha = alpha1 + (alpha2 - alpha1) * (1 - healthPerc)
                local interpolatedColor = Color3.new(r, g, b)
                healthLabel.TextColor3 = interpolatedColor
                healthLabel.TextTransparency = 1 - alpha
                local xOffset = Fatality.config.vars["HealthPos"] ~= 3 and -50 or 0
                local height = screenBox.maxY - screenBox.minY
                local sliderWidth, margin = 5, 5
                healthSliderBG.Position = UDim2.new(0, screenBox.minX - sliderWidth - margin, 0, screenBox.minY)
                healthSliderBG.Size = UDim2.new(0, sliderWidth, 0, height)
                healthSliderBG.BackgroundTransparency = 1 - alpha
                healthSliderBG.Visible = true
                local sliderHeight = height * healthPerc
                local sliderY = screenBox.minY + (height - sliderHeight)
                healthSlider.Position = UDim2.new(0, screenBox.minX - sliderWidth - margin, 0, sliderY)
                healthSlider.Size = UDim2.new(0, sliderWidth, 0, sliderHeight)
                healthSlider.BackgroundColor3 = interpolatedColor
                healthSlider.BackgroundTransparency = 1 - alpha
                healthSlider.Visible = true
                local healthY = sliderY - 5
                healthLabel.Position = UDim2.new(0, textPositions[2].X + xOffset, 0, healthY)
                healthLabel.Visible = true
            else
                healthLabel.Visible = false
                healthSlider.Visible = false
                healthSliderBG.Visible = false
            end
            if enabled[3] and textPositions[3] and textContents[3] ~= "" then
                if elements.lastWeapon ~= textContents[3] then
                    weaponLabel.Text = textContents[3]
                    elements.lastWeapon = textContents[3]
                end
                local xOffset = Fatality.config.vars["WepPlayerPos"] ~= 3 and -50 or 0
                weaponLabel.Position = UDim2.new(0, textPositions[3].X + xOffset, 0, textPositions[3].Y)
                weaponLabel.TextColor3 = Fatality.config.colors["WepPlayerCol"] 
                weaponLabel.TextTransparency = 1 - Fatality.config.colors.alpha["WepPlayerCol"]
                weaponLabel.Visible = true
            else
                weaponLabel.Visible = false
            end
            if enabled[4] and textPositions[4] and textContents[4] ~= "" then
                if elements.lastTeam ~= textContents[4] then
                    teamLabel.Text = textContents[4]
                    elements.lastTeam = textContents[4]
                end
                local xOffset = Fatality.config.vars["TeamPos"] ~= 3 and -50 or 0
                teamLabel.Position = UDim2.new(0, textPositions[4].X + xOffset, 0, textPositions[4].Y)
                teamLabel.TextColor3 = Fatality.config.colors["TeamCol"] 
                teamLabel.TextTransparency = 1 - Fatality.config.colors.alpha["TeamCol"]
                teamLabel.Visible = true
            else
                teamLabel.Visible = false
            end
            if enabled[5] and textPositions[5] and textContents[5] ~= "" then
                if elements.lastDistance ~= textContents[5] then
                    distanceLabel.Text = textContents[5]
                    elements.lastDistance = textContents[5]
                end
                local xOffset = Fatality.config.vars["DistancePlayerPos"] ~= 3 and -50 or 0
                distanceLabel.Position = UDim2.new(0, textPositions[5].X + xOffset, 0, textPositions[5].Y)
                distanceLabel.TextColor3 = Fatality.config.colors["DistancePlayerCol"] 
                distanceLabel.TextTransparency = 1 - Fatality.config.colors.alpha["DistancePlayerCol"]
                distanceLabel.Visible = true
            else
                distanceLabel.Visible = false
            end
        end
    end)
end

for _, player in ipairs(Players:GetPlayers()) do
    CreateESPBox(player)
end

Players.PlayerAdded:Connect(CreateESPBox)
Players.PlayerRemoving:Connect(function(player)
    local elements = ESP_Boxes[player]
    if elements then
        for _, line in pairs(elements.box) do
            line:Remove()
        end
        elements.screenGui:Destroy()
        ESP_Boxes[player] = nil
    end
end)

UpdateESP()



local chamsData = {}

local function clearChams(character)
    if chamsData[character] then
        if chamsData[character].model then
            chamsData[character].model:Destroy()
        end
        if chamsData[character].highlightAlways then
            chamsData[character].highlightAlways:Destroy()
        end
        if chamsData[character].highlightOccluded then
            chamsData[character].highlightOccluded:Destroy()
        end
        for _, clone in pairs(chamsData[character].clonedParts or {}) do
            if clone then
                clone:Destroy()
            end
        end
        chamsData[character] = nil
        chamsCharacters[character] = nil
    end
end

local function applyChams(character)
    if not character or chamsData[character] or character == Fatality.LocalPlayer.Character then return end
    if not (Fatality.config.vars["ChamsEnemy"] or Fatality.config.vars["ChamsEnemyInv"]) then return end

    local model
    local highlightAlways
    local highlightOccluded
    local clonedParts = {}

    if Fatality.config.vars["ChamsEnemyInv"] then
        model = Instance.new("Model")
        model.Name = character.Name .. "_invchams"
        model.Parent = workspace

        highlightAlways = Instance.new("Highlight")
        highlightAlways.Name = "cham_always"
        highlightAlways.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        highlightAlways.FillColor = Fatality.config.colors["InvisibleChamsCol"]
        highlightAlways.FillTransparency = 1 - Fatality.config.colors.alpha["InvisibleChamsCol"]
        highlightAlways.OutlineTransparency = 1
        highlightAlways.Enabled = true
        highlightAlways.Parent = model 

        for _, v in ipairs(character:GetChildren()) do
            if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" and v.Name ~= "HeadHB" and v.Name ~= "BackC4" then
                local clone = v:Clone()
                for _, child in ipairs(clone:GetChildren()) do
                    if not child:IsA("SpecialMesh") then
                        child:Destroy()
                    else
                        child.TextureId = ""
                    end
                end
                pcall(function()
                    clone.Size = v.Size * 0.95
                    clone.CanCollide = false
                    clone.Transparency = 1
                    clone.Parent = model
                    clone.Material = Enum.Material.SmoothPlastic
                    clone.CastShadow = false
                    clone.SurfaceAppearance = nil
                end)
                clonedParts[v] = clone
            end
        end
    end

    if Fatality.config.vars["ChamsEnemy"] then
        highlightOccluded = Instance.new("Highlight")
        highlightOccluded.Name = "cham_occluded"
        highlightOccluded.DepthMode = Fatality.config.vars["ChamsEnemyAlwaysOnTop"] and not Fatality.config.vars["ChamsEnemyInv"] and Enum.HighlightDepthMode.AlwaysOnTop or Enum.HighlightDepthMode.Occluded
        highlightOccluded.FillColor = Fatality.config.colors["VisibleChamsCol"]
        highlightOccluded.FillTransparency = 1 - Fatality.config.colors.alpha["VisibleChamsCol"]
        highlightOccluded.OutlineTransparency = 1
        highlightOccluded.Enabled = true
        highlightOccluded.Parent = character 
    end

    chamsData[character] = {model = model, highlightAlways = highlightAlways, highlightOccluded = highlightOccluded, clonedParts = clonedParts}
    chamsCharacters[character] = model or character
end

local lastPulseUpdate = 0
local pulseValue = 0

local function updateChams()
    if not Fatality.config.vars["ChamsEnemy"] and not Fatality.config.vars["ChamsEnemyInv"] then
        for character, data in pairs(chamsData) do
            if data.highlightAlways then data.highlightAlways.Enabled = false end
            if data.highlightOccluded then data.highlightOccluded.Enabled = false end
        end
        return
    end

    local currentTime = tick()
    if currentTime - lastPulseUpdate >= 0.05 then
        pulseValue = 0.5 + 0.5 * math.sin(currentTime * 2)
        lastPulseUpdate = currentTime
    end

    local localPlayerCharacter = Fatality.LocalPlayer.Character
    local localRoot = localPlayerCharacter and localPlayerCharacter:FindFirstChild("HumanoidRootPart")

    for character, data in pairs(chamsData) do
        if not character.Parent or not character:IsDescendantOf(workspace) or not character:FindFirstChild("Head") or not character:FindFirstChild("HumanoidRootPart") then
            clearChams(character)
            continue
        end

        local withinDistance = true
        if localRoot and character:FindFirstChild("HumanoidRootPart") then
            local distance = (localRoot.Position - character:FindFirstChild("HumanoidRootPart").Position).Magnitude
            withinDistance = distance <= (Fatality.config.vars["DistanceESP"] or 1000)
        end

        if Fatality.config.vars["ChamsEnemyInv"] and data.highlightAlways then
            data.highlightAlways.Enabled = withinDistance
            data.highlightAlways.FillColor = Fatality.config.colors["InvisibleChamsCol"]
            for original, clone in pairs(data.clonedParts or {}) do
                if original:IsDescendantOf(workspace) then
                    clone.CFrame = original.CFrame
                    clone.Size = original.Size * 0.95
                    clone.Color = Fatality.config.colors["InvisibleChamsCol"]
                    clone.Transparency = withinDistance and 0 or 1
                else
                    clone:Destroy()
                    data.clonedParts[original] = nil
                end
            end
        elseif data.highlightAlways then
            data.highlightAlways.Enabled = false
            for _, clone in pairs(data.clonedParts or {}) do
                clone.Transparency = 1
            end
        end

        if Fatality.config.vars["ChamsEnemy"] and data.highlightOccluded then
            data.highlightOccluded.Enabled = withinDistance
            data.highlightOccluded.FillColor = Fatality.config.colors["VisibleChamsCol"]
            data.highlightOccluded.DepthMode = Fatality.config.vars["ChamsEnemyAlwaysOnTop"] and not Fatality.config.vars["ChamsEnemyInv"] and Enum.HighlightDepthMode.AlwaysOnTop or Enum.HighlightDepthMode.Occluded
        elseif data.highlightOccluded then
            data.highlightOccluded.Enabled = false
        end

        local material = Fatality.config.vars["ChamsMaterials"]
        local materialInv = Fatality.config.vars["ChamsMaterialsInv"]
        local alphaInv = Fatality.config.colors.alpha["InvisibleChamsCol"]
        local alphaVis = Fatality.config.colors.alpha["VisibleChamsCol"]

        if materialInv == "Flat" and data.highlightAlways then
            data.highlightAlways.FillTransparency = 1 - alphaInv
            data.highlightAlways.OutlineTransparency = 1
        elseif materialInv == "Outline" and data.highlightAlways then
            data.highlightAlways.FillTransparency = 1
            data.highlightAlways.OutlineTransparency = 0
            data.highlightAlways.OutlineColor = Fatality.config.colors["InvisibleChamsCol"]
        elseif materialInv == "Glow" and data.highlightAlways then
            data.highlightAlways.FillTransparency = 1 - alphaInv
            local maxTransparency = Fatality.config.vars["GlowOutlineMax"]
            local minTransparency = Fatality.config.vars["GlowOutlineMin"]
            local interpolatedTransparency = minTransparency + (maxTransparency - minTransparency) * pulseValue
            data.highlightAlways.OutlineTransparency = 1 - interpolatedTransparency
            data.highlightAlways.OutlineColor = Fatality.config.colors["InvisibleChamsCol"]
        elseif materialInv == "Pulsating" and data.highlightAlways then
            local maxTransparency = alphaInv
            local interpolatedTransparency = Fatality.config.vars["PulsatingSlider"] + (maxTransparency - Fatality.config.vars["PulsatingSlider"]) * pulseValue
            data.highlightAlways.FillTransparency = 1 - interpolatedTransparency
            data.highlightAlways.OutlineTransparency = 1
        end

        if material == "Flat" and data.highlightOccluded then
            data.highlightOccluded.FillTransparency = 1 - alphaVis
            data.highlightOccluded.OutlineTransparency = 1
        elseif material == "Outline" and data.highlightOccluded then
            data.highlightOccluded.FillTransparency = 1
            data.highlightOccluded.OutlineTransparency = 0
            data.highlightOccluded.OutlineColor = Fatality.config.colors["VisibleChamsCol"]
        elseif material == "Glow" and data.highlightOccluded then
            data.highlightOccluded.FillTransparency = 1 - alphaVis
            local maxTransparency = Fatality.config.vars["GlowOutlineMax"] 
            local minTransparency = Fatality.config.vars["GlowOutlineMin"] 
            local interpolatedTransparency = minTransparency + (maxTransparency - minTransparency) * pulseValue
            data.highlightOccluded.OutlineTransparency = 1 - interpolatedTransparency
            data.highlightOccluded.OutlineColor = Fatality.config.colors["VisibleChamsCol"]
        elseif material == "Pulsating" and data.highlightOccluded then
            local maxTransparency = alphaVis
            local interpolatedTransparency = Fatality.config.vars["PulsatingSlider"] + (maxTransparency - Fatality.config.vars["PulsatingSlider"]) * pulseValue
            data.highlightOccluded.FillTransparency = 1 - interpolatedTransparency
            data.highlightOccluded.OutlineTransparency = 1
        end
    end
end

local connection
local lastChamsState = { ChamsEnemy = false, ChamsEnemyInv = false, ChamsEnemyAlwaysOnTop = false }

local function toggleUpdate()
    if Fatality.config.vars["ChamsEnemy"] or Fatality.config.vars["ChamsEnemyInv"] then
        if not connection then
            connection = Fatality.RunService.RenderStepped:Connect(updateChams)
        end
        if game.Players then
            for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
                if player ~= Fatality.LocalPlayer then
                    local character = player.Character
                    if character then
                        clearChams(character)
                        applyChams(character)
                    end
                end
            end
        end
    else
        if connection then
            connection:Disconnect()
            connection = nil
        end
        for character, data in pairs(chamsData) do
            if data.highlightAlways then data.highlightAlways.Enabled = false end
            if data.highlightOccluded then data.highlightOccluded.Enabled = false end
            for _, clone in pairs(data.clonedParts or {}) do
                clone.Transparency = 1
            end
            clearChams(character)
        end
    end
end

if chamsData[Fatality.LocalPlayer.Character] then
    clearChams(Fatality.LocalPlayer.Character)
end

local function handlePlayer(player)
    if player ~= Fatality.LocalPlayer then
        if player.Character then
            if Fatality.config.vars["ChamsEnemy"] or Fatality.config.vars["ChamsEnemyInv"] then
                task.wait(0.1)
                applyChams(player.Character)
            end
        end
        player.CharacterAdded:Connect(function(char)
            task.wait(0.1)
            if player ~= Fatality.LocalPlayer and (Fatality.config.vars["ChamsEnemy"] or Fatality.config.vars["ChamsEnemyInv"]) then
                applyChams(char)
            end
        end)
    end
end

if game.Players then
    for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
        handlePlayer(player)
    end
    Fatality.Players.PlayerAdded:Connect(handlePlayer)
end

Fatality.RunService.Heartbeat:Connect(function()
    local currentChamsEnemy = Fatality.config.vars["ChamsEnemy"] or false
    local currentChamsEnemyInv = Fatality.config.vars["ChamsEnemyInv"] or false
    local currentChamsEnemyAlwaysOnTop = Fatality.config.vars["ChamsEnemyAlwaysOnTop"] or false
    if currentChamsEnemy ~= lastChamsState.ChamsEnemy or 
       currentChamsEnemyInv ~= lastChamsState.ChamsEnemyInv or 
       currentChamsEnemyAlwaysOnTop ~= lastChamsState.ChamsEnemyAlwaysOnTop then
        lastChamsState.ChamsEnemy = currentChamsEnemy
        lastChamsState.ChamsEnemyInv = currentChamsEnemyInv
        lastChamsState.ChamsEnemyAlwaysOnTop = currentChamsEnemyAlwaysOnTop
        toggleUpdate()
    end
end)

toggleUpdate()



local player = Fatality.LocalPlayer
local camera = Fatality.LocalCamera
local horizontalAngle = 0
local verticalAngle = 0
local sensitivity = 0.005
local wasThirdPerson = false
local originalCameraType
local originalCameraMode
local originalCameraSubject
local function enableThirdPerson()
    if not wasThirdPerson then
        originalCameraType = camera.CameraType
        originalCameraMode = player.CameraMode
        originalCameraSubject = camera.CameraSubject
        local direction = camera.CFrame.lookVector
        horizontalAngle = math.atan2(direction.X, direction.Z)
        verticalAngle = math.atan2(-direction.Y, Vector3.new(direction.X, 0, direction.Z).Magnitude)
        wasThirdPerson = true
    end
    camera.CameraType = Enum.CameraType.Scriptable
    local character = player.Character
    if character then
        local humanoidRootPart = character:FindFirstChild("Head") -- HumanoidRootPart
        if humanoidRootPart then
            local distance = Fatality.config.vars["ThirdpersonSlider"] or 5
            local rotationCFrame = CFrame.Angles(0, horizontalAngle, 0) * CFrame.Angles(verticalAngle, 0, 0)
            local offset = rotationCFrame * Vector3.new(0, 0, distance)
            local cameraPosition = humanoidRootPart.Position - offset
            camera.CFrame = CFrame.new(cameraPosition, humanoidRootPart.Position)
        end
    end
end
local function disableThirdPerson()
    if wasThirdPerson then
        camera.CameraType = originalCameraType
        player.CameraMode = originalCameraMode
        camera.CameraSubject = originalCameraSubject
        wasThirdPerson = false
    end
end
local function updateCamera()
    if Fatality.config.vars["Thirdperson"] and not Fatality.config.vars["FreeCamera"] then
        enableThirdPerson()
    elseif not Fatality.config.vars["FreeCamera"] then
        disableThirdPerson()
    end
end
local function onInputChanged(input)
    if Fatality.config.vars["Thirdperson"] and not Fatality.config.vars["FreeCamera"] and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Delta
        horizontalAngle = horizontalAngle - delta.X * sensitivity
        verticalAngle = math.clamp(verticalAngle + delta.Y * sensitivity, -math.rad(79), math.rad(79))
    end
end
local function onInputBegan(input)
    if Fatality.config.vars["Thirdperson"] and not Fatality.config.vars["FreeCamera"] and input.UserInputType == Enum.UserInputType.Keyboard then
        local key = input.KeyCode
        if key == Enum.KeyCode.W or key == Enum.KeyCode.A or key == Enum.KeyCode.S or key == Enum.KeyCode.D then
            local character = player.Character
            if character then
                local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                if humanoidRootPart then
                    local horizontalForward = Vector3.new(math.sin(horizontalAngle), 0, math.cos(horizontalAngle))
                    humanoidRootPart.CFrame = CFrame.new(humanoidRootPart.Position, humanoidRootPart.Position + horizontalForward)
                end
            end
        end
    end
end
local function onCharacterAdded(character)
    if Fatality.config.vars["Thirdperson"] then
        Fatality.config.vars["Thirdperson"] = false 
        disableThirdPerson() 
    end
end
player.CharacterAdded:Connect(onCharacterAdded)
Fatality.UserInputService.InputChanged:Connect(onInputChanged)
Fatality.UserInputService.InputBegan:Connect(onInputBegan)
Fatality.RunService.RenderStepped:Connect(updateCamera)
Fatality.UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and Fatality.config.binds["ThirdpersonBind"] then
        local bind = Fatality.config.binds["ThirdpersonBind"]
        if (input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == bind) or (input.UserInputType ~= Enum.UserInputType.Keyboard and input.UserInputType == bind) then
            if Fatality.config.vars["FreeCamera"] then
                Fatality.config.vars["FreeCamera"] = false
            end
            Fatality.config.vars["Thirdperson"] = not Fatality.config.vars["Thirdperson"]
        end
    end
end)



local function createCone(character)
    if not Fatality.config.vars["ChinaHat"] then return end
    local head = character:FindFirstChild("Head")
    if not head then return end
    local cone = Instance.new("Part")
    cone.Size = Vector3.new(1, 1, 1)
    cone.Transparency = 1 - Fatality.config.colors.alpha["ChinaHatCol"]
    cone.Anchored = false
    cone.CanCollide = false
    cone.Name = "ChinaHat"
    local mesh = Instance.new("SpecialMesh", cone)
    mesh.MeshType = Enum.MeshType.FileMesh
    mesh.MeshId = "rbxassetid://1033714"
    mesh.Scale = Vector3.new(1.7, 1.2, 1.7)
    local weld = Instance.new("Weld")
    weld.Part0 = head
    weld.Part1 = cone
    weld.C0 = CFrame.new(0, 1.1, 0) -- pos
    local highlight = Instance.new("Highlight", cone)
    highlight.FillColor = Fatality.config.colors["ChinaHatCol"]
    highlight.FillTransparency = 1 - Fatality.config.colors.alpha["ChinaHatCol"]
    highlight.OutlineColor = Color3.new(math.max(0, Fatality.config.colors["ChinaHatCol"].R * 0.7),math.max(0, Fatality.config.colors["ChinaHatCol"].G * 0.7),math.max(0, Fatality.config.colors["ChinaHatCol"].B * 0.7))
    highlight.OutlineTransparency = math.clamp((1 - Fatality.config.colors.alpha["ChinaHatCol"]) + 0.2, 0, 1) 
    highlight.DepthMode = Enum.HighlightDepthMode.Occluded
    cone.Parent = character
    weld.Parent = cone
    return cone
end

local function onCharacterAdded(character)
    character:WaitForChild("Head")
    local oldCone = character:FindFirstChild("ChinaHat")
    if oldCone then
        oldCone:Destroy()
    end
    createCone(character)
end

local function updateHat()
    local character = Fatality.LocalPlayer.Character
    if not character then return end
    local existingCone = character:FindFirstChild("ChinaHat")
    if Fatality.config.vars["ChinaHat"] then
        if not existingCone then
            createCone(character)
        else
            local highlight = existingCone:FindFirstChildOfClass("Highlight")
            if highlight then
                highlight.FillColor = Fatality.config.colors["ChinaHatCol"]
                highlight.FillTransparency = 1 - Fatality.config.colors.alpha["ChinaHatCol"] 
                highlight.OutlineColor = Color3.new(math.max(0, Fatality.config.colors["ChinaHatCol"].R * 0.7),math.max(0, Fatality.config.colors["ChinaHatCol"].G * 0.7),math.max(0, Fatality.config.colors["ChinaHatCol"].B * 0.7))
                highlight.OutlineTransparency = math.clamp((1 - Fatality.config.colors.alpha["ChinaHatCol"]) + 0.2, 0, 1) 
            end
            existingCone.Transparency = 1 - Fatality.config.colors.alpha["ChinaHatCol"]
        end
    elseif existingCone then
        existingCone:Destroy()
    end
end

Fatality.LocalPlayer.CharacterAdded:Connect(onCharacterAdded)
if Fatality.LocalPlayer.Character then
    onCharacterAdded(Fatality.LocalPlayer.Character)
end
Fatality.RunService.RenderStepped:Connect(function()
    updateHat()
end)



local camera = Fatality.LocalCamera
local lastFOVSlider = Fatality.config.vars["FOVViewSlider"] 

camera.FieldOfView = lastFOVSlider

Fatality.RunService.RenderStepped:Connect(function()
    local currentFOVSlider = Fatality.config.vars["FOVViewSlider"]
    if currentFOVSlider ~= lastFOVSlider then
        camera.FieldOfView = currentFOVSlider
        lastFOVSlider = currentFOVSlider
    end
end)



local CrosshairFrame = Instance.new("TextLabel")
CrosshairFrame.Size = UDim2.new(0, 30, 0, 30)
CrosshairFrame.BackgroundTransparency = 1
CrosshairFrame.TextColor3 = Color3.new(1, 1, 1)
CrosshairFrame.TextScaled = true
CrosshairFrame.Parent = Fatality.gui
CrosshairFrame.Visible = false
CrosshairFrame.ZIndex = 10
CrosshairFrame.AnchorPoint = Vector2.new(0.5, 0.5)
CrosshairFrame.Position = UDim2.new(0.5, 0, 0.5, 0)

local Stroke = Instance.new("UIStroke")
Stroke.Color = Color3.new(0, 0, 0)
Stroke.Thickness = 2
Stroke.Parent = CrosshairFrame

local CrosshairGradient = Instance.new("UIGradient")
CrosshairGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
    ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 255, 0)),
    ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
    ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 0, 255)),
    ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 0, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
})
CrosshairGradient.Parent = CrosshairFrame

local function UpdateCrosshair()
    if Fatality.config.vars["Crosshair"] then
        if Fatality.config.vars["CrosshairStyle"] == "Swastika" then
            CrosshairFrame.Text = "卐"
        elseif Fatality.config.vars["CrosshairStyle"] == "Cross" then
            CrosshairFrame.Text = "+"
        elseif Fatality.config.vars["CrosshairStyle"] == "Gays)" then
            CrosshairFrame.Text = "♥"
        else
            CrosshairFrame.Text = ""
        end
        CrosshairFrame.Visible = CrosshairFrame.Text ~= ""
        CrosshairFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    else
        CrosshairFrame.Text = ""
        CrosshairFrame.Visible = false
    end
end

Fatality.RunService.Heartbeat:Connect(function(deltaTime)
    UpdateCrosshair()
    if CrosshairFrame.Visible then
        CrosshairGradient.Rotation = (CrosshairGradient.Rotation + deltaTime * 90) % 360
        CrosshairFrame.Rotation = (CrosshairFrame.Rotation + deltaTime * 90) % 360
    end
end)



local player = Fatality.LocalPlayer
local camera = Fatality.LocalCamera
local horizontalAngle = 0
local verticalAngle = 0
local sensitivity = 0.005
local FreeCameraEnabled = false
local originalCameraType
local originalCameraSubject
local originalMovementMode
local originalMouseBehavior
local originalMouseIconEnabled
local cameraPosition = Vector3.new()
local lastHorizontalAngle = 0
local lastVerticalAngle = 0
local lastCameraPosition = Vector3.new()
local savedThirdPersonState = false
local savedThirdPersonHorizontalAngle = 0
local savedThirdPersonVerticalAngle = 0

Fatality.UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and Fatality.config.binds["FreeCameraBind"] then
        local bind = Fatality.config.binds["FreeCameraBind"]
        if (input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == bind)
        or (input.UserInputType ~= Enum.UserInputType.Keyboard and input.UserInputType == bind) then
            Fatality.config.vars["FreeCamera"] = not Fatality.config.vars["FreeCamera"]
        end
    end
end)

Fatality.UserInputService.InputChanged:Connect(function(input)
    if Fatality.config.binds["FreeCameraBind"] and FreeCameraEnabled and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Delta
        horizontalAngle = horizontalAngle - delta.X * sensitivity
        verticalAngle = math.clamp(verticalAngle - delta.Y * sensitivity, -math.rad(80), math.rad(80))
    end
end)

Fatality.LocalPlayer.CharacterAdded:Connect(function()
    if FreeCameraEnabled then
        camera.CameraType = originalCameraType
        camera.CameraSubject = originalCameraSubject
        player.DevComputerMovementMode = originalMovementMode
        Fatality.UserInputService.MouseBehavior = originalMouseBehavior
        Fatality.UserInputService.MouseIconEnabled = originalMouseIconEnabled
        FreeCameraEnabled = false
        Fatality.config.vars["FreeCamera"] = false
    end
end)

Fatality.RunService.RenderStepped:Connect(function(dt)
    if Fatality.config.vars["FreeCamera"] then
        local speed = Fatality.config.vars["FreeCameraSpeed"] * 10
        if not FreeCameraEnabled then
            originalCameraType = camera.CameraType
            originalCameraSubject = camera.CameraSubject
            originalMovementMode = player.DevComputerMovementMode
            originalMouseBehavior = Fatality.UserInputService.MouseBehavior
            originalMouseIconEnabled = Fatality.UserInputService.MouseIconEnabled
            if Fatality.config.vars["Thirdperson"] then
                savedThirdPersonState = true
                savedThirdPersonHorizontalAngle = horizontalAngle
                savedThirdPersonVerticalAngle = verticalAngle
            else
                savedThirdPersonState = false
            end
            Fatality.UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
            Fatality.UserInputService.MouseIconEnabled = false
            player.DevComputerMovementMode = Enum.DevComputerMovementMode.Scriptable
            if lastCameraPosition.Magnitude > 0 then
                cameraPosition = lastCameraPosition
                horizontalAngle = lastHorizontalAngle
                verticalAngle = lastVerticalAngle
            else
                cameraPosition = camera.CFrame.Position
                horizontalAngle = math.atan2(camera.CFrame.LookVector.X, camera.CFrame.LookVector.Z)
                verticalAngle = math.asin(camera.CFrame.LookVector.Y)
            end
            FreeCameraEnabled = true
        end
        local delta = Fatality.UserInputService:GetMouseDelta()
        horizontalAngle = horizontalAngle - delta.X * sensitivity
        verticalAngle = math.clamp(verticalAngle - delta.Y * sensitivity, -math.rad(80), math.rad(80))
        local rot = CFrame.Angles(0, horizontalAngle, 0) * CFrame.Angles(verticalAngle, 0, 0)
        local forward = rot.LookVector
        local right = rot.RightVector
        local dir = Vector3.new()
        if Fatality.UserInputService:IsKeyDown(Enum.KeyCode.W) then dir = dir + forward end
        if Fatality.UserInputService:IsKeyDown(Enum.KeyCode.S) then dir = dir - forward end
        if Fatality.UserInputService:IsKeyDown(Enum.KeyCode.A) then dir = dir - right end
        if Fatality.UserInputService:IsKeyDown(Enum.KeyCode.D) then dir = dir + right end
        if Fatality.UserInputService:IsKeyDown(Enum.KeyCode.Space) then dir = dir + Vector3.new(0, 1, 0) end
        if Fatality.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then dir = dir - Vector3.new(0, 1, 0) end
        if dir.Magnitude > 0 then
            dir = dir.Unit
            cameraPosition = cameraPosition + dir * speed * dt
        end
        local cf = CFrame.new(cameraPosition, cameraPosition + rot.LookVector)
        camera.CameraType = Enum.CameraType.Scriptable
        camera.CFrame = cf
        lastCameraPosition = cameraPosition
        lastHorizontalAngle = horizontalAngle
        lastVerticalAngle = verticalAngle
    else
        if FreeCameraEnabled then
            camera.CameraType = originalCameraType
            camera.CameraSubject = originalCameraSubject
            player.DevComputerMovementMode = originalMovementMode
            Fatality.UserInputService.MouseBehavior = originalMouseBehavior
            Fatality.UserInputService.MouseIconEnabled = originalMouseIconEnabled
            lastCameraPosition = cameraPosition
            lastHorizontalAngle = horizontalAngle
            lastVerticalAngle = verticalAngle
            FreeCameraEnabled = false
            if savedThirdPersonState and Fatality.config.vars["Thirdperson"] then
                horizontalAngle = savedThirdPersonHorizontalAngle
                verticalAngle = savedThirdPersonVerticalAngle
            end
        end
    end
end)
--]]
---------------------------------------------------World
local originalLighting = {
    Brightness = Fatality.Lighting.Brightness,
    Ambient = Fatality.Lighting.Ambient,
    OutdoorAmbient = Fatality.Lighting.OutdoorAmbient,
    GlobalShadows = Fatality.Lighting.GlobalShadows
}
local function updateFullBright()
    if Fatality.config.vars["FullBright"] then
        Fatality.Lighting.GlobalShadows = false
        Fatality.Lighting.Brightness = 5
        Fatality.Lighting.Ambient = Color3.new(1, 1, 1)
        Fatality.Lighting.OutdoorAmbient = Color3.new(1, 1, 1)

        local sky = Fatality.Lighting:FindFirstChildOfClass("Sky")
        if sky then sky:Destroy() end
        local atmosphere = Fatality.Lighting:FindFirstChildOfClass("Atmosphere")
        if atmosphere then atmosphere:Destroy() end
    else
        Fatality.Lighting.Brightness = originalLighting.Brightness
        Fatality.Lighting.Ambient = originalLighting.Ambient
        Fatality.Lighting.OutdoorAmbient = originalLighting.OutdoorAmbient
        Fatality.Lighting.GlobalShadows = originalLighting.GlobalShadows
    end
end
updateFullBright()
Fatality.UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if Fatality.config.binds["FullBrightBind"] then
        if (input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Fatality.config.binds["FullBrightBind"]) or
           (input.UserInputType ~= Enum.UserInputType.Keyboard and input.UserInputType == Fatality.config.binds["FullBrightBind"]) then
            Fatality.config.vars["FullBright"] = not Fatality.config.vars["FullBright"]
            updateFullBright()
        end
    end
end)
local lastFullBright = Fatality.config.vars["FullBright"]
Fatality.RunService.Heartbeat:Connect(function()
    if lastFullBright ~= Fatality.config.vars["FullBright"] then
        lastFullBright = Fatality.config.vars["FullBright"]
        updateFullBright()
    end
end)