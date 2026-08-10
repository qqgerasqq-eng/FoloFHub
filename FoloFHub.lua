-- FoloF Hub: Ultimate Edition (ESP, Speed, Jump, Fly, Noclip, Player List, Pro Fling, FPS & Ping Counter, Ultra FPS Boost + Smooth Loading)
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

-- Создание GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FoloFHubModern"
ScreenGui.Parent = CoreGui

-- ==================== ОКНО ЗАГРУЗКИ (LOADING SCREEN) ====================
local LoadingFrame = Instance.new("Frame", ScreenGui)
LoadingFrame.Size = UDim2.new(0, 320, 0, 160)
LoadingFrame.Position = UDim2.new(0.5, -160, 0.5, -80)
LoadingFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
LoadingFrame.BackgroundTransparency = 1
LoadingFrame.BorderSizePixel = 0
Instance.new("UICorner", LoadingFrame).CornerRadius = UDim.new(0, 12)

local LoadingStroke = Instance.new("UIStroke", LoadingFrame)
LoadingStroke.Color = Color3.fromRGB(90, 70, 200)
LoadingStroke.Transparency = 1
LoadingStroke.Thickness = 1.5

local LoadTitle = Instance.new("TextLabel", LoadingFrame)
LoadTitle.Size = UDim2.new(1, 0, 0, 30)
LoadTitle.Position = UDim2.new(0, 0, 0, 25)
LoadTitle.BackgroundTransparency = 1
LoadTitle.Text = "🐺 FoloF Hub 🐺"
LoadTitle.TextColor3 = Color3.new(1, 1, 1)
LoadTitle.TextSize, LoadTitle.Font = 18, Enum.Font.GothamBold
LoadTitle.TextTransparency = 1

local LoadStatus = Instance.new("TextLabel", LoadingFrame)
LoadStatus.Size = UDim2.new(1, 0, 0, 20)
LoadStatus.Position = UDim2.new(0, 0, 0, 60)
LoadStatus.BackgroundTransparency = 1
LoadStatus.Text = "Initializing..."
LoadStatus.TextColor3 = Color3.fromRGB(170, 170, 180)
LoadStatus.TextSize, LoadStatus.Font = 12, Enum.Font.GothamMedium
LoadStatus.TextTransparency = 1

-- Шкала загрузки (бар)
local BarBackground = Instance.new("Frame", LoadingFrame)
BarBackground.Size = UDim2.new(0, 260, 0, 8)
BarBackground.Position = UDim2.new(0.5, -130, 0, 105)
BarBackground.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
BarBackground.BackgroundTransparency = 1
BarBackground.BorderSizePixel = 0
Instance.new("UICorner", BarBackground).CornerRadius = UDim.new(1, 0)

local BarFill = Instance.new("Frame", BarBackground)
BarFill.Size = UDim2.new(0, 0, 1, 0)
BarFill.BackgroundColor3 = Color3.fromRGB(90, 70, 200)
BarFill.BackgroundTransparency = 1
BarFill.BorderSizePixel = 0
Instance.new("UICorner", BarFill).CornerRadius = UDim.new(1, 0)

-- Главный фрейм (скрыт во время загрузки)
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 280, 0, 760)
MainFrame.Position = UDim2.new(0, 100, 0, 100)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
MainFrame.BackgroundTransparency = 1
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = false

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)
local UIStroke = Instance.new("UIStroke", MainFrame)
UIStroke.Color = Color3.fromRGB(90, 70, 200)
UIStroke.Thickness = 1.5

-- Плавное появление экрана загрузки
TweenService:Create(LoadingFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0.2}):Play()
TweenService:Create(LoadingStroke, TweenInfo.new(0.4), {Transparency = 0}):Play()
TweenService:Create(LoadTitle, TweenInfo.new(0.4), {TextTransparency = 0}):Play()
TweenService:Create(LoadStatus, TweenInfo.new(0.4), {TextTransparency = 0}):Play()
TweenService:Create(BarBackground, TweenInfo.new(0.4), {BackgroundTransparency = 0}):Play()
TweenService:Create(BarFill, TweenInfo.new(0.4), {BackgroundTransparency = 0}):Play()

-- Имитация процесса загрузки
task.spawn(function()
    task.wait(0.2)
    LoadStatus.Text = "Loading modules..."
    TweenService:Create(BarFill, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0.6, 0, 1, 0)}):Play()
    
    task.wait(0.7)
    LoadStatus.Text = "Configuring interface..."
    TweenService:Create(BarFill, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(1, 0, 1, 0)}):Play()
    
    task.wait(0.6)
    LoadStatus.Text = "Done!"
    
    task.wait(0.3)
    -- Плавное исчезновение экрана загрузки
    TweenService:Create(LoadingFrame, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()
    TweenService:Create(LoadingStroke, TweenInfo.new(0.4), {Transparency = 1}):Play()
    TweenService:Create(LoadTitle, TweenInfo.new(0.4), {TextTransparency = 1}):Play()
    TweenService:Create(LoadStatus, TweenInfo.new(0.4), {TextTransparency = 1}):Play()
    TweenService:Create(BarBackground, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()
    TweenService:Create(BarFill, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()
    task.wait(0.4)
    LoadingFrame:Destroy()

    -- Плавное появление главного меню с эффектом увеличения (Scale-In)
    MainFrame.Visible = true
    MainFrame.Size = UDim2.new(0, 220, 0, 550)
    MainFrame.BackgroundTransparency = 1
    
    TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 280, 0, 760),
        BackgroundTransparency = 0.25
    }):Play()
end)

-- ==================== ИНТЕРФЕЙС И ФУНКЦИОНАЛ ====================

-- Header
local TopBar = Instance.new("Frame", MainFrame)
TopBar.Size = UDim2.new(1, 0, 0, 45)
TopBar.BackgroundTransparency = 1

local Title = Instance.new("TextLabel", TopBar)
Title.Size, Title.Position = UDim2.new(1, -120, 1, 0), UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text, Title.TextColor3 = "🐺 FoloF Hub 🐺", Color3.new(1, 1, 1)
Title.TextSize, Title.Font = 15, Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Кнопки управления
local CloseButton = Instance.new("TextButton", TopBar)
CloseButton.Size, CloseButton.Position = UDim2.new(0, 28, 0, 28), UDim2.new(1, -35, 0, 8)
CloseButton.BackgroundColor3, CloseButton.Text = Color3.fromRGB(30, 30, 38), "X"
CloseButton.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", CloseButton).CornerRadius = UDim.new(0, 6)
CloseButton.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

local MinimizeButton = Instance.new("TextButton", TopBar)
MinimizeButton.Size, MinimizeButton.Position = UDim2.new(0, 28, 0, 28), UDim2.new(1, -68, 0, 8)
MinimizeButton.BackgroundColor3, MinimizeButton.Text = Color3.fromRGB(30, 30, 38), "—"
MinimizeButton.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", MinimizeButton).CornerRadius = UDim.new(0, 6)

-- Кнопка информации (?)
local InfoButton = Instance.new("TextButton", TopBar)
InfoButton.Size, InfoButton.Position = UDim2.new(0, 28, 0, 28), UDim2.new(1, -101, 0, 8)
InfoButton.BackgroundColor3, InfoButton.Text = Color3.fromRGB(30, 30, 38), "?"
InfoButton.TextColor3 = Color3.new(1, 1, 1)
InfoButton.TextSize, InfoButton.Font = 14, Enum.Font.GothamBold
Instance.new("UICorner", InfoButton).CornerRadius = UDim.new(0, 6)

-- Окно информации с аватаркой
local InfoFrame = Instance.new("Frame", ScreenGui)
InfoFrame.Size = UDim2.new(0, 240, 0, 195)
InfoFrame.Position = UDim2.new(0, 390, 0, 100)
InfoFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
InfoFrame.Visible = false
InfoFrame.Active = true
InfoFrame.Draggable = true
Instance.new("UICorner", InfoFrame).CornerRadius = UDim.new(0, 10)
local InfoStroke = Instance.new("UIStroke", InfoFrame)
InfoStroke.Color = Color3.fromRGB(90, 70, 200)
InfoStroke.Thickness = 1.5

local InfoTitle = Instance.new("TextLabel", InfoFrame)
InfoTitle.Size, InfoTitle.Position = UDim2.new(1, 0, 0, 30), UDim2.new(0, 0, 0, 5)
InfoTitle.BackgroundTransparency = 1
InfoTitle.Text, InfoTitle.TextColor3 = "Information", Color3.new(1, 1, 1)
InfoTitle.TextSize, InfoTitle.Font = 14, Enum.Font.GothamBold

-- Картинка аватара игрока
local AvatarImage = Instance.new("ImageLabel", InfoFrame)
AvatarImage.Size = UDim2.new(0, 64, 0, 64)
AvatarImage.Position = UDim2.new(0.5, -32, 0, 35)
AvatarImage.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
AvatarImage.Image = ""
Instance.new("UICorner", AvatarImage).CornerRadius = UDim.new(1, 0)
local AvatarStroke = Instance.new("UIStroke", AvatarImage)
AvatarStroke.Color = Color3.fromRGB(90, 70, 200)
AvatarStroke.Thickness = 1.5

-- Автоматическая загрузка аватарки по нику hxhdjdhiqi
task.spawn(function()
    local success, userId = pcall(function()
        return Players:GetUserIdFromNameAsync("hxhdjdhiqi")
    end)
    if success and userId then
        local thumbType = Enum.ThumbnailType.HeadShot
        local thumbSize = Enum.ThumbnailSize.Size420x420
        local content, isReady = Players:GetUserThumbnailAsync(userId, thumbType, thumbSize)
        if content then
            AvatarImage.Image = content
        end
    end
end)

local InfoDesc = Instance.new("TextLabel", InfoFrame)
InfoDesc.Size, InfoDesc.Position = UDim2.new(1, -20, 0, 45), UDim2.new(0, 10, 0, 105)
InfoDesc.BackgroundTransparency = 1
InfoDesc.Text = "Creator: hxhdjdhiqi\nFoloF Hub Ultimate Edition"
InfoDesc.TextColor3 = Color3.fromRGB(200, 200, 210)
InfoDesc.TextSize, InfoDesc.Font = 12, Enum.Font.GothamMedium
InfoDesc.TextWrapped = true

local CloseInfoBtn = Instance.new("TextButton", InfoFrame)
CloseInfoBtn.Size, CloseInfoBtn.Position = UDim2.new(0, 100, 0, 26), UDim2.new(0.5, -50, 1, -32)
CloseInfoBtn.BackgroundColor3, CloseInfoBtn.Text = Color3.fromRGB(90, 70, 200), "Close"
CloseInfoBtn.TextColor3, CloseInfoBtn.TextSize, CloseInfoBtn.Font = Color3.new(1, 1, 1), 12, Enum.Font.GothamBold
Instance.new("UICorner", CloseInfoBtn).CornerRadius = UDim.new(0, 6)

CloseInfoBtn.MouseButton1Click:Connect(function()
    InfoFrame.Visible = false
end)

InfoButton.MouseButton1Click:Connect(function()
    InfoFrame.Visible = not InfoFrame.Visible
end)

local minimized = false
MinimizeButton.MouseButton1Click:Connect(function()
    minimized = not minimized
    local targetSize = minimized and UDim2.new(0, 280, 0, 45) or UDim2.new(0, 280, 0, 760)
    TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = targetSize}):Play()
    for _, child in ipairs(MainFrame:GetChildren()) do
        if child ~= TopBar and not child:IsA("UICorner") and not child:IsA("UIStroke") then
            child.Visible = not minimized
        end
    end
end)

-- Контейнер
local Container = Instance.new("ScrollingFrame", MainFrame)
Container.Size, Container.Position = UDim2.new(1, 0, 1, -45), UDim2.new(0, 0, 0, 45)
Container.BackgroundTransparency, Container.CanvasSize = 1, UDim2.new(0, 0, 0, 670)
Container.ScrollBarThickness = 3

-- Секции
local function createSection(name, pos)
    local Frame = Instance.new("Frame", Container)
    Frame.Size, Frame.Position = UDim2.new(1, -30, 0, 45), pos
    Frame.BackgroundColor3, Frame.BackgroundTransparency = Color3.fromRGB(25, 25, 32), 0.2
    Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 8)
    local Label = Instance.new("TextLabel", Frame)
    Label.Size, Label.Position, Label.Text = UDim2.new(1, -130, 1, 0), UDim2.new(0, 12, 0, 0), name
    Label.BackgroundTransparency, Label.TextColor3 = 1, Color3.new(1, 1, 1)
    Label.Font = Enum.Font.GothamMedium
    Label.TextSize = 14
    Label.TextXAlignment = Enum.TextXAlignment.Left
    return Frame
end

local ESPSection = createSection("ESP Players", UDim2.new(0, 15, 0, 10))
local SpeedSection = createSection("WalkSpeed", UDim2.new(0, 15, 0, 60))
local JumpSection = createSection("Jump Power", UDim2.new(0, 15, 0, 110))
local FlySection = createSection("Fly Mode", UDim2.new(0, 15, 0, 160))
local NoclipSection = createSection("Noclip", UDim2.new(0, 15, 0, 210))
local FPSSection = createSection("FPS & Ping Counter", UDim2.new(0, 15, 0, 260))
local BoostSection = createSection("FPS Boost (Ultra)", UDim2.new(0, 15, 0, 310))

local function createToggle(parent)
    local Toggle = Instance.new("TextButton", parent)
    Toggle.Size, Toggle.Position = UDim2.new(0, 42, 0, 22), UDim2.new(1, -52, 0.5, -11)
    Toggle.BackgroundColor3, Toggle.Text = Color3.fromRGB(45, 45, 55), ""
    Instance.new("UICorner", Toggle).CornerRadius = UDim.new(1, 0)
    local Circle = Instance.new("Frame", Toggle)
    Circle.Size, Circle.Position = UDim2.new(0, 16, 0, 16), UDim2.new(0, 3, 0.5, -8)
    Circle.BackgroundColor3 = Color3.fromRGB(150, 150, 160)
    Instance.new("UICorner", Circle).CornerRadius = UDim.new(1, 0)
    return Toggle, Circle
end

local ESPToggle, ESPCircle = createToggle(ESPSection)
local SpeedToggle, SpeedCircle = createToggle(SpeedSection)
local JumpToggle, JumpCircle = createToggle(JumpSection)
local FlyToggle, FlyCircle = createToggle(FlySection)
local NoclipToggle, NoclipCircle = createToggle(NoclipSection)
local FPSToggle, FPSCircle = createToggle(FPSSection)
local BoostToggle, BoostCircle = createToggle(BoostSection)

local function createInput(parent)
    local Box = Instance.new("TextBox", parent)
    Box.Size, Box.Position = UDim2.new(0, 45, 0, 24), UDim2.new(1, -105, 0.5, -12)
    Box.BackgroundColor3, Box.Text = Color3.fromRGB(35, 35, 45), "50"
    Box.TextColor3, Box.TextSize = Color3.new(1, 1, 1), 12
    Box.Font = Enum.Font.GothamBold
    Instance.new("UICorner", Box).CornerRadius = UDim.new(0, 5)
    return Box
end

local SpeedBox = createInput(SpeedSection)
local JumpBox = createInput(JumpSection)
local FlyBox = createInput(FlySection)

-- Переменные цвета ESP
local ESPColor = Color3.fromRGB(140, 0, 255)
local hsvHue, hsvSat, hsvVal = 0.77, 1, 1

-- Кнопка открытия палитры цветов ESP
local ColorBtn = Instance.new("TextButton", ESPSection)
ColorBtn.Size, ColorBtn.Position = UDim2.new(0, 22, 0, 22), UDim2.new(1, -80, 0.5, -11)
ColorBtn.BackgroundColor3, ColorBtn.Text = ESPColor, ""
Instance.new("UICorner", ColorBtn).CornerRadius = UDim.new(1, 0)

-- Полноценное окно палитры
local PaletteFrame = Instance.new("Frame", ScreenGui)
PaletteFrame.Size = UDim2.new(0, 220, 0, 280)
PaletteFrame.Position = UDim2.new(0, 390, 0, 100)
PaletteFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
PaletteFrame.Visible = false
PaletteFrame.Active = true
PaletteFrame.Draggable = true
Instance.new("UICorner", PaletteFrame).CornerRadius = UDim.new(0, 10)
local PaletteStroke = Instance.new("UIStroke", PaletteFrame)
PaletteStroke.Color = Color3.fromRGB(90, 70, 200)
PaletteStroke.Thickness = 1.5

-- Цветовая матрица (Saturation / Value)
local SVBox = Instance.new("TextButton", PaletteFrame)
SVBox.Size, SVBox.Position = UDim2.new(1, -20, 0, 140), UDim2.new(0, 10, 0, 15)
SVBox.BackgroundColor3 = Color3.fromHSV(hsvHue, 1, 1)
SVBox.AutoButtonColor = false
SVBox.Text = ""
Instance.new("UICorner", SVBox).CornerRadius = UDim.new(0, 6)

local SVWhiteOverlay = Instance.new("Frame", SVBox)
SVWhiteOverlay.Size = UDim2.new(1, 0, 1, 0)
SVWhiteOverlay.BackgroundTransparency = 0
SVWhiteOverlay.BackgroundColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", SVWhiteOverlay).CornerRadius = UDim.new(0, 6)
local WhiteGrad = Instance.new("UIGradient", SVWhiteOverlay)
WhiteGrad.Color = ColorSequence.new(Color3.new(1, 1, 1), Color3.new(1, 1, 1))
WhiteGrad.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1)})

local SVBlackOverlay = Instance.new("Frame", SVBox)
SVBlackOverlay.Size = UDim2.new(1, 0, 1, 0)
SVBlackOverlay.BackgroundTransparency = 0
SVBlackOverlay.BackgroundColor3 = Color3.new(0, 0, 0)
Instance.new("UICorner", SVBlackOverlay).CornerRadius = UDim.new(0, 6)
local BlackGrad = Instance.new("UIGradient", SVBlackOverlay)
BlackGrad.Color = ColorSequence.new(Color3.new(0, 0, 0), Color3.new(0, 0, 0))
BlackGrad.Rotation = 90
BlackGrad.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0)})

local SVCursor = Instance.new("Frame", SVBox)
SVCursor.Size = UDim2.new(0, 8, 0, 8)
SVCursor.AnchorPoint = Vector2.new(0.5, 0.5)
SVCursor.BackgroundColor3 = Color3.new(1, 1, 1)
SVCursor.BorderSizePixel = 0
Instance.new("UICorner", SVCursor).CornerRadius = UDim.new(1, 0)
local SVCursorStroke = Instance.new("UIStroke", SVCursor)
SVCursorStroke.Color = Color3.new(0, 0, 0)
SVCursorStroke.Thickness = 1.5

-- Ползунок оттенка (Hue Slider)
local HueSlider = Instance.new("TextButton", PaletteFrame)
HueSlider.Size, HueSlider.Position = UDim2.new(1, -20, 0, 16), UDim2.new(0, 10, 0, 165)
HueSlider.BackgroundColor3 = Color3.new(1, 1, 1)
HueSlider.AutoButtonColor = false
HueSlider.Text = ""
Instance.new("UICorner", HueSlider).CornerRadius = UDim.new(0, 4)

local HueGrad = Instance.new("UIGradient", HueSlider)
HueGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
    ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 255, 0)),
    ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
    ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 0, 255)),
    ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 0, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
})

local HueCursor = Instance.new("Frame", HueSlider)
HueCursor.Size = UDim2.new(0, 4, 1, 4)
HueCursor.AnchorPoint = Vector2.new(0.5, 0.5)
HueCursor.Position = UDim2.new(hsvHue, 0, 0.5, 0)
HueCursor.BackgroundColor3 = Color3.new(1, 1, 1)
HueCursor.BorderSizePixel = 0
Instance.new("UICorner", HueCursor).CornerRadius = UDim.new(0, 2)
local HueCursorStroke = Instance.new("UIStroke", HueCursor)
HueCursorStroke.Color = Color3.new(0, 0, 0)
HueCursorStroke.Thickness = 1.5

local HexBox = Instance.new("TextBox", PaletteFrame)
HexBox.Size, HexBox.Position = UDim2.new(0, 120, 0, 28), UDim2.new(0, 10, 0, 195)
HexBox.BackgroundColor3, HexBox.Text = Color3.fromRGB(35, 35, 45), "8800FF"
HexBox.TextColor3, HexBox.TextSize, HexBox.Font = Color3.new(1, 1, 1), 12, Enum.Font.GothamBold
Instance.new("UICorner", HexBox).CornerRadius = UDim.new(0, 6)

local ApplyBtn = Instance.new("TextButton", PaletteFrame)
ApplyBtn.Size, ApplyBtn.Position = UDim2.new(0, 70, 0, 28), UDim2.new(0, 140, 0, 195)
ApplyBtn.BackgroundColor3, ApplyBtn.Text = Color3.fromRGB(90, 70, 200), "Apply"
ApplyBtn.TextColor3, ApplyBtn.TextSize, ApplyBtn.Font = Color3.new(1, 1, 1), 12, Enum.Font.GothamBold
Instance.new("UICorner", ApplyBtn).CornerRadius = UDim.new(0, 6)

local function updateCursors()
    SVCursor.Position = UDim2.new(hsvSat, 0, 1 - hsvVal, 0)
    HueCursor.Position = UDim2.new(hsvHue, 0, 0.5, 0)
end

local function updateESPColor()
    ESPColor = Color3.fromHSV(hsvHue, hsvSat, hsvVal)
    ColorBtn.BackgroundColor3 = ESPColor
    SVBox.BackgroundColor3 = Color3.fromHSV(hsvHue, 1, 1)
    HexBox.Text = ESPColor:ToHex()
    updateCursors()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local h = p.Character:FindFirstChild("ESPHighlight")
            if h then h.FillColor = ESPColor end
        end
    end
end

-- Интерактив для палитры
local draggingSV, draggingHue = false, false

SVBox.MouseButton1Down:Connect(function()
    draggingSV = true
    local mousePos = UserInputService:GetMouseLocation()
    local absPos = SVBox.AbsolutePosition
    local absSize = SVBox.AbsoluteSize
    local insetY = GuiService:GetGuiInset().Y
    hsvSat = math.clamp((mousePos.X - absPos.X) / absSize.X, 0, 1)
    hsvVal = math.clamp(1 - ((mousePos.Y - insetY - absPos.Y) / absSize.Y), 0, 1)
    updateESPColor()
end)

HueSlider.MouseButton1Down:Connect(function()
    draggingHue = true
    local mousePos = UserInputService:GetMouseLocation()
    local absPos = HueSlider.AbsolutePosition
    local absSize = HueSlider.AbsoluteSize
    hsvHue = math.clamp((mousePos.X - absPos.X) / absSize.X, 0, 1)
    updateESPColor()
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingSV = false
        draggingHue = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        local mousePos = UserInputService:GetMouseLocation()
        local insetY = GuiService:GetGuiInset().Y
        
        if draggingSV then
            local absPos = SVBox.AbsolutePosition
            local absSize = SVBox.AbsoluteSize
            hsvSat = math.clamp((mousePos.X - absPos.X) / absSize.X, 0, 1)
            hsvVal = math.clamp(1 - ((mousePos.Y - insetY - absPos.Y) / absSize.Y), 0, 1)
            updateESPColor()
        elseif draggingHue then
            local absPos = HueSlider.AbsolutePosition
            local absSize = HueSlider.AbsoluteSize
            hsvHue = math.clamp((mousePos.X - absPos.X) / absSize.X, 0, 1)
            updateESPColor()
        end
    end
end)

HexBox.FocusLost:Connect(function()
    local success, newColor = pcall(function()
        return Color3.fromHex(HexBox.Text)
    end)
    if success and newColor then
        hsvHue, hsvSat, hsvVal = Color3.toHSV(newColor)
        updateESPColor()
    else
        HexBox.Text = ESPColor:ToHex()
    end
end)

ApplyBtn.MouseButton1Click:Connect(function()
    PaletteFrame.Visible = false
end)

ColorBtn.MouseButton1Click:Connect(function()
    PaletteFrame.Visible = not PaletteFrame.Visible
    updateCursors()
end)

-- СТАБИЛЬНАЯ ЛОГИКА ESP
local espEnabled = false

local function setupCharacterESP(char)
    if not char then return end
    local old = char:FindFirstChild("ESPHighlight")
    if old then old:Destroy() end

    if espEnabled then
        local h = Instance.new("Highlight")
        h.Name = "ESPHighlight"
        h.FillColor = ESPColor
        h.OutlineColor = Color3.new(1, 1, 1)
        h.OutlineTransparency = 0.5
        h.Adornee = char
        h.Parent = char
    end
end

RunService.Heartbeat:Connect(function()
    if not espEnabled then return end
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local char = p.Character
            if not char:FindFirstChild("ESPHighlight") and char:FindFirstChild("HumanoidRootPart") then
                setupCharacterESP(char)
            end
        end
    end
end)

ESPToggle.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    ESPCircle:TweenPosition(espEnabled and UDim2.new(0, 23, 0.5, -8) or UDim2.new(0, 3, 0.5, -8), "Out", "Quad", 0.15, true)
    ESPCircle.BackgroundColor3 = espEnabled and Color3.new(1, 1, 1) or Color3.fromRGB(150, 150, 160)
    ESPToggle.BackgroundColor3 = espEnabled and Color3.fromRGB(90, 70, 200) or Color3.fromRGB(45, 45, 55)
    
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            if p.Character then
                setupCharacterESP(p.Character)
            end
        end
    end
end)

Players.PlayerAdded:Connect(function(p)
    p.CharacterAdded:Connect(function(char)
        task.wait(0.5)
        if espEnabled then
            setupCharacterESP(char)
        end
    end)
end)

for _, p in ipairs(Players:GetPlayers()) do
    if p ~= LocalPlayer then
        p.CharacterAdded:Connect(function(char)
            task.wait(0.5)
            if espEnabled then
                setupCharacterESP(char)
            end
        end)
    end
end

-- ЛОГИКА FPS И ПИНГ СЧЕТЧИКА
local fpsEnabled = false
local fpsLabel = Instance.new("TextLabel", ScreenGui)
fpsLabel.Size = UDim2.new(0, 160, 0, 30)
fpsLabel.Position = UDim2.new(0, 15, 0, 15)
fpsLabel.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
fpsLabel.BackgroundTransparency = 0.4
fpsLabel.TextColor3 = Color3.new(1, 1, 1)
fpsLabel.TextSize = 13
fpsLabel.Font = Enum.Font.GothamBold
fpsLabel.Text = "FPS: 0 | Ping: 0ms"
fpsLabel.Visible = false
Instance.new("UICorner", fpsLabel).CornerRadius = UDim.new(0, 6)
local fpsStroke = Instance.new("UIStroke", fpsLabel)
fpsStroke.Color = Color3.fromRGB(90, 70, 200)
fpsStroke.Thickness = 1

local fpsConnection
FPSToggle.MouseButton1Click:Connect(function()
    fpsEnabled = not fpsEnabled
    FPSCircle:TweenPosition(fpsEnabled and UDim2.new(0, 23, 0.5, -8) or UDim2.new(0, 3, 0.5, -8), "Out", "Quad", 0.15, true)
    FPSCircle.BackgroundColor3 = fpsEnabled and Color3.new(1, 1, 1) or Color3.fromRGB(150, 150, 160)
    FPSToggle.BackgroundColor3 = fpsEnabled and Color3.fromRGB(90, 70, 200) or Color3.fromRGB(45, 45, 55)
    
    fpsLabel.Visible = fpsEnabled
    
    if fpsEnabled then
        local lastTick = tick()
        local frameCount = 0
        fpsConnection = RunService.RenderStepped:Connect(function()
            frameCount = frameCount + 1
            local currentTick = tick()
            if currentTick - lastTick >= 1 then
                local fps = math.floor(frameCount / (currentTick - lastTick))
                local ping = 0
                pcall(function()
                    ping = math.floor(LocalPlayer:GetNetworkPing() * 1000)
                end)
                fpsLabel.Text = "FPS: " .. fps .. " | Ping: " .. ping .. "ms"
                frameCount = 0
                lastTick = currentTick
            end
        end)
    else
        if fpsConnection then
            fpsConnection:Disconnect()
            fpsConnection = nil
        end
    end
end)

-- ==================== ЛОГИКА ULTRA FPS BOOST ====================
local boostEnabled = false

BoostToggle.MouseButton1Click:Connect(function()
    boostEnabled = not boostEnabled
    BoostCircle:TweenPosition(boostEnabled and UDim2.new(0, 23, 0.5, -8) or UDim2.new(0, 3, 0.5, -8), "Out", "Quad", 0.15, true)
    BoostCircle.BackgroundColor3 = boostEnabled and Color3.new(1, 1, 1) or Color3.fromRGB(150, 150, 160)
    BoostToggle.BackgroundColor3 = boostEnabled and Color3.fromRGB(90, 70, 200) or Color3.fromRGB(45, 45, 55)

    if boostEnabled then
        -- 1. Полное отключение теней и тяжелых графических эффектов мира
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 999999
        Lighting.Brightness = 2
        
        for _, v in ipairs(Lighting:GetChildren()) do
            if v:IsA("PostEffect") or v:IsA("Sky") or v:IsA("Atmosphere") or v:IsA("Clouds") or v:IsA("DepthOfFieldEffect") or v:IsA("BloomEffect") or v:IsA("BlurEffect") or v:IsA("SunRaysEffect") then
                v.Enabled = false
            end
        end

        -- 2. Замена всех сложных текстур и материалов на SmoothPlastic с сохранением изначального цвета
        for _, v in ipairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") and not v:IsDescendantOf(LocalPlayer.Character) then
                v.Material = Enum.Material.SmoothPlastic
                v.Reflectance = 0
                v.CastShadow = false
            elseif v:IsA("Decal") or v:IsA("Texture") or v:IsA("SpecialMesh") then
                v.Transparency = 1
            elseif v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Fire") or v:IsA("Smoke") or v:IsA("Sparkles") or v:IsA("Beam") then
                v.Enabled = false
            end
        end
    else
        -- Возвращаем стандартные настройки при выключении
        Lighting.GlobalShadows = true
        for _, v in ipairs(Lighting:GetChildren()) do
            if v:IsA("PostEffect") or v:IsA("Sky") or v:IsA("Atmosphere") or v:IsA("Clouds") then
                v.Enabled = true
            end
        end
    end
end)

-- Скорость и Прыжок
local function updateHumanoid()
    local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
    if hum then
        hum.WalkSpeed = SpeedToggle.BackgroundColor3 == Color3.fromRGB(90, 70, 200) and (tonumber(SpeedBox.Text) or 16) or 16
        hum.JumpPower = JumpToggle.BackgroundColor3 == Color3.fromRGB(90, 70, 200) and (tonumber(JumpBox.Text) or 50) or 50
    end
end

local function toggleLogic(toggle, circle, enabled)
    circle:TweenPosition(enabled and UDim2.new(0, 23, 0.5, -8) or UDim2.new(0, 3, 0.5, -8), "Out", "Quad", 0.15, true)
    circle.BackgroundColor3 = enabled and Color3.new(1, 1, 1) or Color3.fromRGB(150, 150, 160)
    toggle.BackgroundColor3 = enabled and Color3.fromRGB(90, 70, 200) or Color3.fromRGB(45, 45, 55)
    updateHumanoid()
end

SpeedToggle.MouseButton1Click:Connect(function() toggleLogic(SpeedToggle, SpeedCircle, SpeedToggle.BackgroundColor3 ~= Color3.fromRGB(90, 70, 200)) end)
JumpToggle.MouseButton1Click:Connect(function() toggleLogic(JumpToggle, JumpCircle, JumpToggle.BackgroundColor3 ~= Color3.fromRGB(90, 70, 200)) end)
SpeedBox.FocusLost:Connect(updateHumanoid)
JumpBox.FocusLost:Connect(updateHumanoid)

-- СТАБИЛЬНАЯ ЛОГИКА ПОЛЕТА (SMOOTH FLY)
local flyEnabled = false
local flyConnection

FlyToggle.MouseButton1Click:Connect(function()
    flyEnabled = not flyEnabled
    FlyCircle:TweenPosition(flyEnabled and UDim2.new(0, 23, 0.5, -8) or UDim2.new(0, 3, 0.5, -8), "Out", "Quad", 0.15, true)
    FlyCircle.BackgroundColor3 = flyEnabled and Color3.new(1, 1, 1) or Color3.fromRGB(150, 150, 160)
    FlyToggle.BackgroundColor3 = flyEnabled and Color3.fromRGB(90, 70, 200) or Color3.fromRGB(45, 45, 55)

    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChild("Humanoid")

    if flyEnabled then
        if hrp and hum then
            hum.PlatformStand = true

            local bv = Instance.new("BodyVelocity")
            bv.Name = "FlyVelocity"
            bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            bv.Velocity = Vector3.zero
            bv.Parent = hrp

            local bg = Instance.new("BodyGyro")
            bg.Name = "FlyGyro"
            bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
            bg.P = 20000
            bg.D = 1000
            bg.Parent = hrp

            flyConnection = RunService.RenderStepped:Connect(function()
                if not char or not hrp or not hum or hum.Health <= 0 then return end
                local cam = workspace.CurrentCamera
                local speed = tonumber(FlyBox.Text) or 50
                local moveDir = Vector3.zero

                if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + cam.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - cam.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - cam.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + cam.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDir = moveDir + Vector3.new(0, 1, 0) end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then moveDir = moveDir - Vector3.new(0, 1, 0) end

                bv.Velocity = moveDir * speed
                bg.CFrame = cam.CFrame
            end)
        end
    else
        if flyConnection then
            flyConnection:Disconnect()
            flyConnection = nil
        end
        if hrp then
            if hrp:FindFirstChild("FlyVelocity") then hrp.FlyVelocity:Destroy() end
            if hrp:FindFirstChild("FlyGyro") then hrp.FlyGyro:Destroy() end
        end
        if hum then hum.PlatformStand = false end
    end
end)

-- ЛОГИКА НОУКЛИПА (NOCLIP)
local noclipEnabled = false
local noclipConnection

NoclipToggle.MouseButton1Click:Connect(function()
    noclipEnabled = not noclipEnabled
    NoclipCircle:TweenPosition(noclipEnabled and UDim2.new(0, 23, 0.5, -8) or UDim2.new(0, 3, 0.5, -8), "Out", "Quad", 0.15, true)
    NoclipCircle.BackgroundColor3 = noclipEnabled and Color3.new(1, 1, 1) or Color3.fromRGB(150, 150, 160)
    NoclipToggle.BackgroundColor3 = noclipEnabled and Color3.fromRGB(90, 70, 200) or Color3.fromRGB(45, 45, 55)

    if noclipEnabled then
        noclipConnection = RunService.Stepped:Connect(function()
            local char = LocalPlayer.Character
            if char then
                for _, part in ipairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = false end
                end
            end
        end)
    else
        if noclipConnection then
            noclipConnection:Disconnect()
            noclipConnection = nil
        end
        local char = LocalPlayer.Character
        if char then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = true end
            end
        end
    end
end)

LocalPlayer.CharacterAdded:Connect(function(char)
    task.wait(0.5)
    updateHumanoid()
    if flyEnabled then
        flyEnabled = false
        FlyCircle:TweenPosition(UDim2.new(0, 3, 0.5, -8), "Out", "Quad", 0.15, true)
        FlyCircle.BackgroundColor3 = Color3.fromRGB(150, 150, 160)
        FlyToggle.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
        if flyConnection then
            flyConnection:Disconnect()
            flyConnection = nil
        end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then hum.PlatformStand = false end
    end
    if noclipEnabled then
        noclipEnabled = false
        NoclipCircle:TweenPosition(UDim2.new(0, 3, 0.5, -8), "Out", "Quad", 0.15, true)
        NoclipCircle.BackgroundColor3 = Color3.fromRGB(150, 150, 160)
        NoclipToggle.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
        if noclipConnection then
            noclipConnection:Disconnect()
            noclipConnection = nil
        end
    end
end)

-- Список игроков
local SelectedTarget = nil

local PlayerListFrame = Instance.new("ScrollingFrame", Container)
PlayerListFrame.Size, PlayerListFrame.Position = UDim2.new(1, -30, 0, 130), UDim2.new(0, 15, 0, 360)
PlayerListFrame.BackgroundColor3 = Color3.fromRGB(14, 14, 18)
PlayerListFrame.BackgroundTransparency = 0.3
PlayerListFrame.BorderSizePixel = 0
PlayerListFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
PlayerListFrame.ScrollBarThickness = 3
Instance.new("UICorner", PlayerListFrame).CornerRadius = UDim.new(0, 8)
Instance.new("UIStroke", PlayerListFrame).Color = Color3.fromRGB(40, 40, 50)

local function updateList()
    for _, child in ipairs(PlayerListFrame:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end
    local count = 0
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            count = count + 1
            local btn = Instance.new("TextButton", PlayerListFrame)
            btn.Size, btn.Position = UDim2.new(1, -6, 0, 32), UDim2.new(0, 3, 0, (count - 1) * 34 + 3)
            btn.BackgroundColor3 = Color3.fromRGB(28, 28, 36)
            btn.Text = "  " .. p.Name
            btn.TextColor3 = Color3.new(1, 1, 1)
            btn.TextSize = 13
            btn.Font = Enum.Font.GothamMedium
            btn.TextXAlignment = Enum.TextXAlignment.Left
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
            
            btn.MouseButton1Click:Connect(function()
                SelectedTarget = p
                Title.Text = "🐺 Target: " .. p.Name .. " 🐺"
                for _, b in ipairs(PlayerListFrame:GetChildren()) do
                    if b:IsA("TextButton") then b.BackgroundColor3 = Color3.fromRGB(28, 28, 36) end
                end
                btn.BackgroundColor3 = Color3.fromRGB(90, 70, 200)
            end)
        end
    end
    PlayerListFrame.CanvasSize = UDim2.new(0, 0, 0, count * 34 + 6)
end

Players.PlayerAdded:Connect(updateList)
Players.PlayerRemoving:Connect(updateList)
updateList()

-- Кнопка Флинга
local FlingBtn = Instance.new("TextButton", Container)
FlingBtn.Size, FlingBtn.Position = UDim2.new(1, -30, 0, 38), UDim2.new(0, 15, 0, 500)
FlingBtn.BackgroundColor3, FlingBtn.Text = Color3.fromRGB(90, 70, 200), "START PRO FLING"
FlingBtn.TextColor3, FlingBtn.TextSize, FlingBtn.Font = Color3.new(1, 1, 1), 13, Enum.Font.GothamBold
Instance.new("UICorner", FlingBtn).CornerRadius = UDim.new(0, 8)

FlingBtn.MouseButton1Click:Connect(function()
    if not SelectedTarget or not SelectedTarget.Character or not SelectedTarget.Character:FindFirstChild("HumanoidRootPart") then return end
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local hrp = char.HumanoidRootPart
    local startCFrame = hrp.CFrame

    local startT = tick()
    local conn
    conn = RunService.Heartbeat:Connect(function()
        if tick() - startT < 1.5 then
            local targetHrp = SelectedTarget.Character and SelectedTarget.Character:FindFirstChild("HumanoidRootPart")
            if targetHrp and hrp then
                local offset = math.sin(tick() * 60) * 0.8
                hrp.CFrame = targetHrp.CFrame * CFrame.new(offset, 0, 0)
                hrp.Velocity = Vector3.new(99999, 99999, 99999)
                hrp.RotVelocity = Vector3.new(0, 99999, 0)
            end
        else
            hrp.Velocity = Vector3.zero
            hrp.RotVelocity = Vector3.zero
            hrp.Anchored = true
            hrp.CFrame = startCFrame
            task.wait(0.5)
            hrp.Anchored = false
            conn:Disconnect()
        end
    end)
end)
