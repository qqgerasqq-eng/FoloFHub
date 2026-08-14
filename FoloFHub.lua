-- FoloF Hub: Hard Locked Aimbot (No FOV, Pure Closest Target, Team Check, Max Distance, Anti-Self, Powerful FPS Boost)
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local Terrain = workspace:FindFirstChildOfClass("Terrain")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Безопасное создание GUI в PlayerGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FoloFHubScrollable"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 300, 0, 430)
MainFrame.Position = UDim2.new(0, 100, 0, 100)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
MainFrame.BackgroundTransparency = 0.25
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)
local UIStroke = Instance.new("UIStroke", MainFrame)
UIStroke.Color = Color3.fromRGB(90, 70, 200)
UIStroke.Thickness = 1.5

-- Header
local TopBar = Instance.new("Frame", MainFrame)
TopBar.Size = UDim2.new(1, 0, 0, 45)
TopBar.BackgroundTransparency = 1

local Title = Instance.new("TextLabel", TopBar)
Title.Size = UDim2.new(1, -140, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "🐺 FoloF Hub 🐺"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextSize = 15
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Кнопки управления в шапке
local CloseButton = Instance.new("TextButton", TopBar)
CloseButton.Size = UDim2.new(0, 26, 0, 26)
CloseButton.Position = UDim2.new(1, -31, 0, 9)
CloseButton.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.new(1, 1, 1)
CloseButton.TextSize = 12
CloseButton.Font = Enum.Font.GothamBold
Instance.new("UICorner", CloseButton).CornerRadius = UDim.new(0, 6)
CloseButton.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

local MinimizeButton = Instance.new("TextButton", TopBar)
MinimizeButton.Size = UDim2.new(0, 26, 0, 26)
MinimizeButton.Position = UDim2.new(1, -61, 0, 9)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
MinimizeButton.Text = "—"
MinimizeButton.TextColor3 = Color3.new(1, 1, 1)
MinimizeButton.TextSize = 12
MinimizeButton.Font = Enum.Font.GothamBold
Instance.new("UICorner", MinimizeButton).CornerRadius = UDim.new(0, 6)

local SettingsButton = Instance.new("TextButton", TopBar)
SettingsButton.Size = UDim2.new(0, 26, 0, 26)
SettingsButton.Position = UDim2.new(1, -91, 0, 9)
SettingsButton.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
SettingsButton.Text = "⚙"
SettingsButton.TextColor3 = Color3.new(1, 1, 1)
SettingsButton.TextSize = 14
SettingsButton.Font = Enum.Font.GothamBold
Instance.new("UICorner", SettingsButton).CornerRadius = UDim.new(0, 6)

local InfoButton = Instance.new("TextButton", TopBar)
InfoButton.Size = UDim2.new(0, 26, 0, 26)
InfoButton.Position = UDim2.new(1, -121, 0, 9)
InfoButton.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
InfoButton.Text = "?"
InfoButton.TextColor3 = Color3.new(1, 1, 1)
InfoButton.TextSize = 14
InfoButton.Font = Enum.Font.GothamBold
Instance.new("UICorner", InfoButton).CornerRadius = UDim.new(0, 6)

local minimized = false
MinimizeButton.MouseButton1Click:Connect(function()
    minimized = not minimized
    local targetSize = minimized and UDim2.new(0, MainFrame.AbsoluteSize.X, 0, 45) or UDim2.new(0, MainFrame.AbsoluteSize.X, 0, 430)
    TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = targetSize}):Play()
    for _, child in ipairs(MainFrame:GetChildren()) do
        if child ~= TopBar and not child:IsA("UICorner") and not child:IsA("UIStroke") then
            child.Visible = not minimized
        end
    end
end)

-- Окно НАСТРОЕК
local SettingsFrame = Instance.new("Frame", ScreenGui)
SettingsFrame.Size = UDim2.new(0, 220, 0, 130)
SettingsFrame.Position = UDim2.new(0, 420, 0, 100)
SettingsFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
SettingsFrame.Visible = false
SettingsFrame.Active = true
SettingsFrame.Draggable = true
Instance.new("UICorner", SettingsFrame).CornerRadius = UDim.new(0, 10)
local SettingsStroke = Instance.new("UIStroke", SettingsFrame)
SettingsStroke.Color = Color3.fromRGB(90, 70, 200)
SettingsStroke.Thickness = 1.5

local SettingsTitle = Instance.new("TextLabel", SettingsFrame)
SettingsTitle.Size = UDim2.new(1, 0, 0, 30)
SettingsTitle.Position = UDim2.new(0, 0, 0, 5)
SettingsTitle.BackgroundTransparency = 1
SettingsTitle.Text = "Settings: GUI Scale"
SettingsTitle.TextColor3 = Color3.new(1, 1, 1)
SettingsTitle.TextSize = 13
SettingsTitle.Font = Enum.Font.GothamBold

local ResizeSliderBg = Instance.new("Frame", SettingsFrame)
ResizeSliderBg.Size = UDim2.new(1, -30, 0, 18)
ResizeSliderBg.Position = UDim2.new(0, 15, 0, 50)
ResizeSliderBg.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
Instance.new("UICorner", ResizeSliderBg).CornerRadius = UDim.new(1, 0)

local ResizeFill = Instance.new("Frame", ResizeSliderBg)
ResizeFill.Size = UDim2.new(0.5, 0, 1, 0)
ResizeFill.BackgroundColor3 = Color3.fromRGB(90, 70, 200)
Instance.new("UICorner", ResizeFill).CornerRadius = UDim.new(1, 0)

local ResizeBtn = Instance.new("TextButton", ResizeSliderBg)
ResizeBtn.Size = UDim2.new(1, 0, 1, 0)
ResizeBtn.BackgroundTransparency = 1
ResizeBtn.Text = ""

local draggingResize = false
ResizeBtn.MouseButton1Down:Connect(function() draggingResize = true end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then draggingResize = false end
end)

UserInputService.InputChanged:Connect(function(input)
    if draggingResize and input.UserInputType == Enum.UserInputType.MouseMovement then
        local mousePos = UserInputService:GetMouseLocation()
        local absPos = ResizeSliderBg.AbsolutePosition
        local absSize = ResizeSliderBg.AbsoluteSize
        local p = math.clamp((mousePos.X - absPos.X) / absSize.X, 0, 1)
        ResizeFill.Size = UDim2.new(p, 0, 1, 0)
        
        local newWidth = math.floor(240 + (p * 260))
        local newHeight = math.floor(320 + (p * 250))
        MainFrame.Size = UDim2.new(0, newWidth, 0, newHeight)
    end
end)

local CloseSettingsBtn = Instance.new("TextButton", SettingsFrame)
CloseSettingsBtn.Size = UDim2.new(0, 100, 0, 26)
CloseSettingsBtn.Position = UDim2.new(0.5, -50, 1, -35)
CloseSettingsBtn.BackgroundColor3 = Color3.fromRGB(90, 70, 200)
CloseSettingsBtn.Text = "Close"
CloseSettingsBtn.TextColor3 = Color3.new(1, 1, 1)
CloseSettingsBtn.TextSize = 12
CloseSettingsBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", CloseSettingsBtn).CornerRadius = UDim.new(0, 6)

CloseSettingsBtn.MouseButton1Click:Connect(function() SettingsFrame.Visible = false end)
SettingsButton.MouseButton1Click:Connect(function() SettingsFrame.Visible = not SettingsFrame.Visible end)

-- Окно ИНФОРМАЦИИ
local InfoFrame = Instance.new("Frame", ScreenGui)
InfoFrame.Size = UDim2.new(0, 240, 0, 175)
InfoFrame.Position = UDim2.new(0, 420, 0, 100)
InfoFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
InfoFrame.Visible = false
InfoFrame.Active = true
InfoFrame.Draggable = true
Instance.new("UICorner", InfoFrame).CornerRadius = UDim.new(0, 10)
local InfoStroke = Instance.new("UIStroke", InfoFrame)
InfoStroke.Color = Color3.fromRGB(90, 70, 200)
InfoStroke.Thickness = 1.5

local InfoTitle = Instance.new("TextLabel", InfoFrame)
InfoTitle.Size = UDim2.new(1, 0, 0, 30)
InfoTitle.Position = UDim2.new(0, 0, 0, 5)
InfoTitle.BackgroundTransparency = 1
InfoTitle.Text = "Information"
InfoTitle.TextColor3 = Color3.new(1, 1, 1)
InfoTitle.TextSize = 14
InfoTitle.Font = Enum.Font.GothamBold

local InfoDesc = Instance.new("TextLabel", InfoFrame)
InfoDesc.Size = UDim2.new(1, -20, 0, 80)
InfoDesc.Position = UDim2.new(0, 10, 0, 40)
InfoDesc.BackgroundTransparency = 1
InfoDesc.Text = "FoloF Hub Ultimate Edition\nPure Closest Target Lock (No FOV)\nPress 'B' to toggle Aimbot!"
InfoDesc.TextColor3 = Color3.fromRGB(200, 200, 210)
InfoDesc.TextSize = 12
InfoDesc.Font = Enum.Font.GothamMedium
InfoDesc.TextWrapped = true

local CloseInfoBtn = Instance.new("TextButton", InfoFrame)
CloseInfoBtn.Size = UDim2.new(0, 100, 0, 26)
CloseInfoBtn.Position = UDim2.new(0.5, -50, 1, -32)
CloseInfoBtn.BackgroundColor3 = Color3.fromRGB(90, 70, 200)
CloseInfoBtn.Text = "Close"
CloseInfoBtn.TextColor3 = Color3.new(1, 1, 1)
CloseInfoBtn.TextSize = 12
CloseInfoBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", CloseInfoBtn).CornerRadius = UDim.new(0, 6)

CloseInfoBtn.MouseButton1Click:Connect(function() InfoFrame.Visible = false end)
InfoButton.MouseButton1Click:Connect(function() InfoFrame.Visible = not InfoFrame.Visible end)

-- Главный скролл всех функций
local Container = Instance.new("ScrollingFrame", MainFrame)
Container.Size = UDim2.new(1, 0, 1, -45)
Container.Position = UDim2.new(0, 0, 0, 45)
Container.BackgroundTransparency = 1
Container.CanvasSize = UDim2.new(0, 0, 0, 840)
Container.ScrollBarThickness = 4

local function createSection(name, posY)
    local Frame = Instance.new("Frame", Container)
    Frame.Size = UDim2.new(1, -20, 0, 45)
    Frame.Position = UDim2.new(0, 10, 0, posY)
    Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
    Frame.BackgroundTransparency = 0.2
    Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 8)
    
    local Label = Instance.new("TextLabel", Frame)
    Label.Size = UDim2.new(1, -130, 1, 0)
    Label.Position = UDim2.new(0, 12, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Color3.new(1, 1, 1)
    Label.Font = Enum.Font.GothamMedium
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left
    return Frame
end

local ESPSection = createSection("ESP Players", 10)
local SpeedSection = createSection("WalkSpeed", 60)
local JumpSection = createSection("Jump Power", 110)
local FlySection = createSection("Fly Mode", 160)
local NoclipSection = createSection("Noclip", 210)
local FPSSection = createSection("FPS Counter", 260)
local AimbotSection = createSection("Aimbot (Head Lock)", 310)
local BoostSection = createSection("Powerful FPS Boost", 360)

-- Переключатели
local function createToggle(parent)
    local Toggle = Instance.new("TextButton", parent)
    Toggle.Size = UDim2.new(0, 42, 0, 22)
    Toggle.Position = UDim2.new(1, -52, 0.5, -11)
    Toggle.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    Toggle.Text = ""
    Instance.new("UICorner", Toggle).CornerRadius = UDim.new(1, 0)
    
    local Circle = Instance.new("Frame", Toggle)
    Circle.Size = UDim2.new(0, 16, 0, 16)
    Circle.Position = UDim2.new(0, 3, 0.5, -8)
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
local AimToggle, AimCircle = createToggle(AimbotSection)
local BoostToggle, BoostCircle = createToggle(BoostSection)

-- Поля ввода
local function createInput(parent, defaultText, posX)
    local Box = Instance.new("TextBox", parent)
    Box.Size = UDim2.new(0, 45, 0, 24)
    Box.Position = UDim2.new(1, posX or -105, 0.5, -12)
    Box.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    Box.Text = defaultText or "50"
    Box.TextColor3 = Color3.new(1, 1, 1)
    Box.TextSize = 12
    Box.Font = Enum.Font.GothamBold
    Instance.new("UICorner", Box).CornerRadius = UDim.new(0, 5)
    return Box
end

local SpeedBox = createInput(SpeedSection, "50")
local JumpBox = createInput(JumpSection, "50")
local FlyBox = createInput(FlySection, "50")
local DistanceBox = createInput(AimbotSection, "500")

-- ESP Логика
local ESPColor = Color3.fromRGB(140, 0, 255)
local ColorBtn = Instance.new("TextButton", ESPSection)
ColorBtn.Size = UDim2.new(0, 22, 0, 22)
ColorBtn.Position = UDim2.new(1, -80, 0.5, -11)
ColorBtn.BackgroundColor3 = ESPColor
ColorBtn.Text = ""
Instance.new("UICorner", ColorBtn).CornerRadius = UDim.new(1, 0)

local espEnabled = false
local function setupCharacterESP(char)
    if not char then return end
    local old = char:FindFirstChild("ESPHighlight")
    if old then old:Destroy() end
    local oldBillboard = char:FindFirstChild("ESPBillboard")
    if oldBillboard then oldBillboard:Destroy() end

    if espEnabled then
        local h = Instance.new("Highlight")
        h.Name = "ESPHighlight"
        h.FillColor = ESPColor
        h.OutlineColor = Color3.new(1, 1, 1)
        h.OutlineTransparency = 0.5
        h.Adornee = char
        h.Parent = char

        local head = char:WaitForChild("Head", 2)
        if head then
            local billboard = Instance.new("BillboardGui")
            billboard.Name = "ESPBillboard"
            billboard.Size = UDim2.new(0, 100, 0, 30)
            billboard.StudsOffset = Vector3.new(0, 2.5, 0)
            billboard.AlwaysOnTop = true
            billboard.Adornee = head

            local textLabel = Instance.new("TextLabel", billboard)
            textLabel.Name = "DistanceText"
            textLabel.Size = UDim2.new(1, 0, 1, 0)
            textLabel.BackgroundTransparency = 1
            textLabel.TextColor3 = ESPColor
            textLabel.TextStrokeTransparency = 0.2
            textLabel.TextSize = 12
            textLabel.Font = Enum.Font.GothamBold
            textLabel.Text = "0m"
            billboard.Parent = char
        end
    end
end

RunService.Heartbeat:Connect(function()
    if not espEnabled then return end
    local localHrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local char = p.Character
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if not char:FindFirstChild("ESPHighlight") and hrp then
                setupCharacterESP(char)
            elseif hrp and localHrp then
                local billboard = char:FindFirstChild("ESPBillboard")
                if billboard then
                    local textLabel = billboard:FindFirstChild("DistanceText")
                    if textLabel then
                        local dist = math.floor((hrp.Position - localHrp.Position).Magnitude)
                        textLabel.Text = dist .. "m"
                    end
                end
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
        if p ~= LocalPlayer and p.Character then setupCharacterESP(p.Character) end
    end
end)

-- FPS Counter
local fpsEnabled = false
local fpsLabel = Instance.new("TextLabel", ScreenGui)
fpsLabel.Size = UDim2.new(0, 110, 0, 26)
fpsLabel.Position = UDim2.new(0, 15, 0, 15)
fpsLabel.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
fpsLabel.BackgroundTransparency = 0.4
fpsLabel.TextColor3 = Color3.new(1, 1, 1)
fpsLabel.TextSize = 13
fpsLabel.Font = Enum.Font.GothamBold
fpsLabel.Text = "FPS: 0"
fpsLabel.Visible = false
Instance.new("UICorner", fpsLabel).CornerRadius = UDim.new(0, 6)

local fpsConnection
FPSToggle.MouseButton1Click:Connect(function()
    fpsEnabled = not fpsEnabled
    FPSCircle:TweenPosition(fpsEnabled and UDim2.new(0, 23, 0.5, -8) or UDim2.new(0, 3, 0.5, -8), "Out", "Quad", 0.15, true)
    FPSCircle.BackgroundColor3 = fpsEnabled and Color3.new(1, 1, 1) or Color3.fromRGB(150, 150, 160)
    FPSToggle.BackgroundColor3 = fpsEnabled and Color3.fromRGB(90, 70, 200) or Color3.fromRGB(45, 45, 55)
    fpsLabel.Visible = fpsEnabled
    if fpsEnabled then
        local lastTick, frameCount = tick(), 0
        fpsConnection = RunService.RenderStepped:Connect(function()
            frameCount = frameCount + 1
            local currentTick = tick()
            if currentTick - lastTick >= 1 then
                fpsLabel.Text = "FPS: " .. math.floor(frameCount / (currentTick - lastTick))
                frameCount = 0
                lastTick = currentTick
            end
        end)
    else
        if fpsConnection then fpsConnection:Disconnect(); fpsConnection = nil end
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

-- Чистый Aimbot (на ближайшего врага с лимитом дистанции, без фова и исключая себя)
local aimbotActive = false
local lockedTarget = nil

local function isEnemy(player)
    -- Исключаем самого себя
    if player == LocalPlayer then return false end
    -- Исключаем тиммейтов (если они есть)
    if player.Team and LocalPlayer.Team and player.Team == LocalPlayer.Team then
        return false
    end
    return true
end

local function getClosestTarget()
    local localHrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not localHrp then return nil end
    
    local closestHead = nil
    local maxDist = tonumber(DistanceBox.Text) or 500
    local shortestDist = maxDist
    
    for _, p in ipairs(Players:GetPlayers()) do
        -- Дополнительная проверка: p ~= LocalPlayer гарантирует, что мы не выберем себя
        if p ~= LocalPlayer and isEnemy(p) and p.Character then
            local hum = p.Character:FindFirstChild("Humanoid")
            local head = p.Character:FindFirstChild("Head")
            local hrp = p.Character:FindFirstChild("HumanoidRootPart")
            
            if hum and head and hrp and hum.Health > 0 then
                local dist = (hrp.Position - localHrp.Position).Magnitude
                if dist < shortestDist then
                    shortestDist = dist
                    closestHead = head
                end
            end
        end
    end
    
    return closestHead
end

local function setAimbotState(state)
    aimbotActive = state
    if not state then 
        lockedTarget = nil 
    else
        lockedTarget = getClosestTarget()
    end
    AimCircle:TweenPosition(aimbotActive and UDim2.new(0, 23, 0.5, -8) or UDim2.new(0, 3, 0.5, -8), "Out", "Quad", 0.15, true)
    AimToggle.BackgroundColor3 = aimbotActive and Color3.fromRGB(90, 70, 200) or Color3.fromRGB(45, 45, 55)
    AimCircle.BackgroundColor3 = aimbotActive and Color3.new(1, 1, 1) or Color3.fromRGB(150, 150, 160)
end

AimToggle.MouseButton1Click:Connect(function()
    setAimbotState(not aimbotActive)
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.B then
        setAimbotState(not aimbotActive)
    end
end)

RunService.RenderStepped:Connect(function()
    if aimbotActive then
        if not lockedTarget or not lockedTarget.Parent or not lockedTarget.Parent:FindFirstChild("Humanoid") or lockedTarget.Parent.Humanoid.Health <= 0 then
            lockedTarget = getClosestTarget()
        end
        
        -- Двойная защита: если цель случайно оказалась нашим собственным персонажем, сбрасываем её
        if lockedTarget and lockedTarget:IsDescendantOf(LocalPlayer.Character) then
            lockedTarget = nil
        end
        
        if lockedTarget then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, lockedTarget.Position)
        end
    else
        lockedTarget = nil
    end
end)

-- Мощный FPS Boost (Удаление теней, текстур, уменьшение графики)
local boostEnabled = false
BoostToggle.MouseButton1Click:Connect(function()
    boostEnabled = not boostEnabled
    BoostCircle:TweenPosition(boostEnabled and UDim2.new(0, 23, 0.5, -8) or UDim2.new(0, 3, 0.5, -8), "Out", "Quad", 0.15, true)
    BoostCircle.BackgroundColor3 = boostEnabled and Color3.new(1, 1, 1) or Color3.fromRGB(150, 150, 160)
    BoostToggle.BackgroundColor3 = boostEnabled and Color3.fromRGB(90, 70, 200) or Color3.fromRGB(45, 45, 55)
    
    if boostEnabled then
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 9e9
        for _, v in ipairs(Lighting:GetChildren()) do
            if v:IsA("PostEffect") or v:IsA("Sky") then
                v.Enabled = false
            end
        end
        if Terrain then
            Terrain.WaterWaveSize = 0
            Terrain.WaterWaveTransparency = 1
            Terrain.WaterTransparency = 1
            Terrain.WaterReflectance = 0
        end
        for _, part in ipairs(workspace:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Material = Enum.Material.SmoothPlastic
                part.Reflectance = 0
            elseif part:IsA("Decal") or part:IsA("Texture") then
                part.Transparency = 1
            end
        end
    end
end)

-- Fly
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
            local bv = Instance.new("BodyVelocity", hrp)
            bv.Name, bv.MaxForce, bv.Velocity = "FlyVelocity", Vector3.new(9e9, 9e9, 9e9), Vector3.zero
            local bg = Instance.new("BodyGyro", hrp)
            bg.Name, bg.MaxTorque, bg.P, bg.D = "FlyGyro", Vector3.new(9e9, 9e9, 9e9), 20000, 1000
            flyConnection = RunService.RenderStepped:Connect(function()
                local cam = workspace.CurrentCamera
                local speed = tonumber(FlyBox.Text) or 50
                local moveDir = Vector3.zero
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + cam.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - cam.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - cam.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + cam.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDir = moveDir + Vector3.new(0, 1, 0) end
                bv.Velocity = moveDir * speed
                bg.CFrame = cam.CFrame
            end)
        end
    else
        if flyConnection then flyConnection:Disconnect() end
        if hrp then
            if hrp:FindFirstChild("FlyVelocity") then hrp.FlyVelocity:Destroy() end
            if hrp:FindFirstChild("FlyGyro") then hrp.FlyGyro:Destroy() end
        end
        if hum then hum.PlatformStand = false end
    end
end)

-- Noclip
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
        if noclipConnection then noclipConnection:Disconnect() end
    end
end)

-- Список игроков и Fling
local SelectedTarget = nil
local PlayerListFrame = Instance.new("ScrollingFrame", Container)
PlayerListFrame.Size = UDim2.new(1, -20, 0, 130)
PlayerListFrame.Position = UDim2.new(0, 10, 0, 480)
PlayerListFrame.BackgroundColor3 = Color3.fromRGB(14, 14, 18)
PlayerListFrame.BackgroundTransparency = 0.3
PlayerListFrame.BorderSizePixel = 0
PlayerListFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
PlayerListFrame.ScrollBarThickness = 3
Instance.new("UICorner", PlayerListFrame).CornerRadius = UDim.new(0, 8)

local function updateList()
    for _, child in ipairs(PlayerListFrame:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end
    local count = 0
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            count = count + 1
            local btn = Instance.new("TextButton", PlayerListFrame)
            btn.Size = UDim2.new(1, -6, 0, 30)
            btn.Position = UDim2.new(0, 3, 0, (count - 1) * 32 + 3)
            btn.BackgroundColor3 = Color3.fromRGB(28, 28, 36)
            btn.Text = "  " .. p.Name
            btn.TextColor3 = Color3.new(1, 1, 1)
            btn.TextSize = 12
            btn.Font = Enum.Font.GothamMedium
            btn.TextXAlignment = Enum.TextXAlignment.Left
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
            btn.MouseButton1Click:Connect(function()
                SelectedTarget = p
                Title.Text = "🐺 Target: " .. p.Name
                for _, b in ipairs(PlayerListFrame:GetChildren()) do
                    if b:IsA("TextButton") then b.BackgroundColor3 = Color3.fromRGB(28, 28, 36) end
                end
                btn.BackgroundColor3 = Color3.fromRGB(90, 70, 200)
            end)
        end
    end
    PlayerListFrame.CanvasSize = UDim2.new(0, 0, 0, count * 32 + 6)
end

Players.PlayerAdded:Connect(updateList)
Players.PlayerRemoving:Connect(updateList)
updateList()

local FlingBtn = Instance.new("TextButton", Container)
FlingBtn.Size = UDim2.new(1, -20, 0, 36)
FlingBtn.Position = UDim2.new(0, 10, 0, 620)
FlingBtn.BackgroundColor3 = Color3.fromRGB(90, 70, 200)
FlingBtn.Text = "START PRO FLING"
FlingBtn.TextColor3 = Color3.new(1, 1, 1)
FlingBtn.TextSize = 12
FlingBtn.Font = Enum.Font.GothamBold
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
                hrp.CFrame = targetHrp.CFrame * CFrame.new(math.sin(tick() * 60) * 0.8, 0, 0)
                hrp.Velocity = Vector3.new(99999, 99999, 99999)
            end
        else
            hrp.Velocity = Vector3.zero
            hrp.CFrame = startCFrame
            conn:Disconnect()
        end
    end)
end)
