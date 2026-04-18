local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local currentTheme = Color3.fromRGB(0, 255, 120)
local rainbowEnabled = false

-- ТВОИ 10 СКРИПТОВ
local SCRIPTS_DATA = {
	{Name = "1. Bot Script", Url = "https://raw.githubusercontent.com/doloword-hash/botscr54iptts.lua/refs/heads/main/bosa.lua"},
	{Name = "2. Infinity Yield", Url = "https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"},
	{Name = "3. Rostickk Hub", Url = "https://raw.githubusercontent.com/doloword-hash/botscr54iptts.lua/refs/heads/main/SHEDEVR.lua"},
	{Name = "4. Normalniy MM2", Url = "https://raw.githubusercontent.com/doloword-hash/botscr54iptts.lua/refs/heads/main/MMAGM%232"},
	{Name = "5. Teleport (TAB)", Url = "https://raw.githubusercontent.com/doloword-hash/botscr54iptts.lua/refs/heads/main/Thdfeleposr.lua"},
    {Name = "6. Dex Explorer", Url = "https://raw.githubusercontent.com/peyton2465/Dex/master/out.lua"},
    {Name = "7. -", Url = "https://raw.githubusercontent.com/ic3w0lf22/Unnamed-ESP/master/UntitledESP.lua"},
    {Name = "8. -", Url = "https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.lua"},
    {Name = "9. -", Url = "https://raw.githubusercontent.com/Babyhamsta/RBLX_Scripts/main/Universal/DarkDexV3.lua"},
    {Name = "10. -", Url = "https://raw.githubusercontent.com/advxzivmskoa/keyboard/main/main.lua"}
}

local function createModernGui()
	local sg = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
	sg.Name = "Normalniy_V6_Gear"
	sg.ResetOnSpawn = false

	local frame = Instance.new("Frame", sg)
	frame.Name = "MainFrame"
	frame.Size = UDim2.new(0, 320, 0, 520)
	frame.Position = UDim2.new(0.5, -160, 0.5, -260)
	frame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
	frame.BackgroundTransparency = 0.1
    frame.ClipsDescendants = true
	Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 20)
    
	local mainStroke = Instance.new("UIStroke", frame)
	mainStroke.Thickness = 3; mainStroke.Color = currentTheme; mainStroke.Transparency = 0.4

    -- Группа для плавной смены страниц
    local canvasGroup = Instance.new("CanvasGroup", frame)
    canvasGroup.Size = UDim2.new(1, 0, 1, 0)
    canvasGroup.BackgroundTransparency = 1
    canvasGroup.GroupTransparency = 0

	-- Заголовок
	local header = Instance.new("Frame", frame)
	header.Size = UDim2.new(1, 0, 0, 50); header.BackgroundTransparency = 1
	
	local title = Instance.new("TextLabel", header)
	title.Text = "  NORMALNIY EXE"; title.Size = UDim2.new(0.8, 0, 1, 0)
	title.BackgroundTransparency = 1; title.TextColor3 = currentTheme
	title.Font = "GothamBold"; title.TextSize = 18; title.TextXAlignment = "Left"

    -- КНОПКА-ШЕСТЕРЕНКА
    local gearBtn = Instance.new("TextButton", header)
    gearBtn.Text = "⚙"; gearBtn.Size = UDim2.new(0, 40, 0, 40)
    gearBtn.Position = UDim2.new(1, -45, 0, 5); gearBtn.BackgroundTransparency = 1
    gearBtn.TextColor3 = Color3.new(1,1,1); gearBtn.TextSize = 24; gearBtn.Font = "GothamBold"

	-- Страницы
	local scriptsPage = Instance.new("ScrollingFrame", canvasGroup)
	scriptsPage.Size = UDim2.new(1, -24, 1, -160); scriptsPage.Position = UDim2.new(0, 12, 0, 60)
	scriptsPage.BackgroundTransparency = 1; scriptsPage.ScrollBarThickness = 0; scriptsPage.Visible = true

	local settingsPage = Instance.new("ScrollingFrame", canvasGroup)
	settingsPage.Size = UDim2.new(1, -24, 1, -160); settingsPage.Position = UDim2.new(0, 12, 0, 60)
	settingsPage.BackgroundTransparency = 1; settingsPage.ScrollBarThickness = 0; settingsPage.Visible = false

	local layout1 = Instance.new("UIListLayout", scriptsPage); layout1.Padding = UDim.new(0, 8)
	local layout2 = Instance.new("UIListLayout", settingsPage); layout2.Padding = UDim.new(0, 8)

    -- Переключение страниц через шестеренку
    gearBtn.MouseButton1Click:Connect(function()
        local appearing = settingsPage.Visible == false
        TweenService:Create(canvasGroup, TweenInfo.new(0.3), {GroupTransparency = 1}):Play()
        task.wait(0.3)
        scriptsPage.Visible = not appearing
        settingsPage.Visible = appearing
        TweenService:Create(canvasGroup, TweenInfo.new(0.3), {GroupTransparency = 0}):Play()
    end)

    -- Анимация вращения шестеренки при наведении
    gearBtn.MouseEnter:Connect(function()
        TweenService:Create(gearBtn, TweenInfo.new(0.5), {Rotation = 90, TextColor3 = currentTheme}):Play()
    end)
    gearBtn.MouseLeave:Connect(function()
        TweenService:Create(gearBtn, TweenInfo.new(0.5), {Rotation = 0, TextColor3 = Color3.new(1,1,1)}):Play()
    end)

	-- Тема и функции
    local function updateTheme(color)
        currentTheme = color
        title.TextColor3 = color
        mainStroke.Color = color
    end

    local function makeBtn(text, parent, callback, isAction)
        local btn = Instance.new("TextButton", parent)
        btn.Size = UDim2.new(1, 0, 0, 40)
        btn.BackgroundColor3 = isAction and Color3.fromRGB(30, 30, 30) or Color3.fromRGB(25, 25, 25)
        btn.Text = text; btn.TextColor3 = Color3.new(0.9,0.9,0.9); btn.Font = "GothamMedium"; btn.TextSize = 13
        Instance.new("UICorner", btn)
        
        btn.MouseEnter:Connect(function() TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 40), TextColor3 = currentTheme}):Play() end)
        btn.MouseLeave:Connect(function() TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(25, 25, 25), TextColor3 = Color3.new(0.9,0.9,0.9)}):Play() end)
        btn.MouseButton1Down:Connect(function() btn:TweenSize(UDim2.new(0.95, 0, 0, 35), "Out", "Quad", 0.1, true) end)
        btn.MouseButton1Up:Connect(function() btn:TweenSize(UDim2.new(1, 0, 0, 40), "Out", "Quad", 0.1, true) end)
        
        btn.MouseButton1Click:Connect(callback)
    end

    -- Наполняем скрипты
	for _, data in pairs(SCRIPTS_DATA) do
		makeBtn(data.Name, scriptsPage, function() pcall(function() loadstring(game:HttpGet(data.Url))() end) end)
	end

    -- Наполняем настройки
    makeBtn("Зеленый (Родной)", settingsPage, function() rainbowEnabled = false; updateTheme(Color3.fromRGB(0, 255, 120)) end)
    makeBtn("Синий", settingsPage, function() rainbowEnabled = false; updateTheme(Color3.fromRGB(0, 160, 255)) end)
    makeBtn("Золотой", settingsPage, function() rainbowEnabled = false; updateTheme(Color3.fromRGB(255, 200, 0)) end)
    makeBtn("РАДУГА (RGB)", settingsPage, function() rainbowEnabled = true end)

	-- Нижняя панель
	local customInput = Instance.new("TextBox", frame)
	customInput.Size = UDim2.new(1, -24, 0, 40); customInput.Position = UDim2.new(0, 12, 1, -100)
	customInput.PlaceholderText = "Paste script URL here..."; customInput.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	customInput.TextColor3 = Color3.new(1,1,1); Instance.new("UICorner", customInput)

	local runCustom = Instance.new("TextButton", frame)
	runCustom.Size = UDim2.new(1, -24, 0, 45); runCustom.Position = UDim2.new(0, 12, 1, -50)
	runCustom.BackgroundColor3 = Color3.fromRGB(0, 150, 80); runCustom.Text = "EXECUTE FROM URL"
	runCustom.Font = "GothamBold"; runCustom.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", runCustom)
    runCustom.MouseButton1Click:Connect(function() pcall(function() loadstring(game:HttpGet(customInput.Text))() end) end)

	-- Циклы анимаций
	RunService.RenderStepped:Connect(function()
		if rainbowEnabled then updateTheme(Color3.fromHSV(tick() % 5 / 5, 0.8, 1)) end
        mainStroke.Transparency = 0.3 + math.sin(tick() * 4) * 0.1 -- Пульсация неона
        runCustom.BackgroundColor3 = currentTheme
	end)

	-- Перетаскивание
	local dragging, dragStart, startPos
	header.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging, dragStart, startPos = true, i.Position, frame.Position end end)
	UserInputService.InputChanged:Connect(function(i) if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = i.Position - dragStart
		frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end end)
	UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end)

	-- F1: Toggle Visibility
	UserInputService.InputBegan:Connect(function(i, g) 
        if not g and i.KeyCode == Enum.KeyCode.F1 then 
            frame.Visible = not frame.Visible
        end 
    end)

    -- Анимация появления при запуске
    frame.Size = UDim2.new(0, 320, 0, 0)
    TweenService:Create(frame, TweenInfo.new(0.6, Enum.EasingStyle.Back), {Size = UDim2.new(0, 320, 0, 520)}):Play()
end

createModernGui()
