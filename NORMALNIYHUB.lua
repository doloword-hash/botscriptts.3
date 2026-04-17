-- Скрипт в Workspace (Server Side)
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- Конфигурация: теперь 5 кнопок (1-я по ссылке, остальные настраивай сам)
local SCRIPTS_DATA = {
	{
		Name = "Bot Script", 
		Url = "https://raw.githubusercontent.com/doloword-hash/botscr54iptts.lua/refs/heads/main/bosa.lua"
	},
	{
		Name = "Infinity Yield", 
		Url = "https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"
	},
	{
		Name = "Rostickk Hub", 
		Url = "https://raw.githubusercontent.com/doloword-hash/botscr54iptts.lua/refs/heads/main/SHEDEVR.lua"
	},
	{
		Name = "Noclip", 
		Url = "https://raw.githubusercontent.com/doloword-hash/botscr54iptts.lua/refs/heads/main/Noclip.lua"
	},
	{
		Name = "Script Slot 5", 
		Url = "https://raw.githubusercontent.com/ссылка_тут"
	}
}

local function createModernGui(player)
	local sg = Instance.new("ScreenGui")
	sg.Name = "GreenNeon_V4"
	sg.ResetOnSpawn = false
	sg.IgnoreGuiInset = true
	sg.Parent = player:WaitForChild("PlayerGui")

	-- Главное окно
	local frame = Instance.new("Frame")
	frame.Name = "MainFrame"
	frame.Size = UDim2.new(0, 280, 0, 400) -- Увеличил высоту для 5 кнопок
	frame.Position = UDim2.new(0, 30, 0, 30)
	frame.BackgroundColor3 = Color3.fromRGB(10, 15, 10) -- Тёмно-зеленый оттенок
	frame.BackgroundTransparency = 0.2 -- Прозрачность
	frame.BorderSizePixel = 0
	frame.Visible = false
	frame.Parent = sg

	Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 14)

	-- Зеленая неоновая обводка
	local mainStroke = Instance.new("UIStroke")
	mainStroke.Thickness = 2.5
	mainStroke.Color = Color3.fromRGB(0, 255, 120) -- Ярко-зеленый неон
	mainStroke.Transparency = 0.4
	mainStroke.Parent = frame

	-- Верхняя панель (Header)
	local header = Instance.new("Frame")
	header.Size = UDim2.new(1, 0, 0, 45)
	header.BackgroundTransparency = 1
	header.Parent = frame

	local title = Instance.new("TextLabel")
	title.Text = "  NORMALNIY EXE [v1]"
	title.Size = UDim2.new(1, -50, 1, 0)
	title.BackgroundTransparency = 1
	title.TextColor3 = Color3.fromRGB(0, 255, 120)
	title.Font = Enum.Font.GothamBold
	title.TextSize = 14
	title.TextXAlignment = Enum.TextXAlignment.Left
	title.Parent = header

	-- Кнопка закрытия (Исправленный крестик)
	local destroyBtn = Instance.new("TextButton")
	destroyBtn.Text = "X"
	destroyBtn.Size = UDim2.new(0, 35, 0, 35)
	destroyBtn.Position = UDim2.new(1, -40, 0, 5)
	destroyBtn.BackgroundTransparency = 1
	destroyBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
	destroyBtn.Font = Enum.Font.GothamBold
	destroyBtn.TextSize = 20
	destroyBtn.Parent = header

	-- Декоративная зеленая линия
	local line = Instance.new("Frame")
	line.Size = UDim2.new(1, -30, 0, 1)
	line.Position = UDim2.new(0, 15, 0, 45)
	line.BackgroundColor3 = Color3.fromRGB(0, 255, 120)
	line.Transparency = 0.7
	line.BorderSizePixel = 0
	line.Parent = frame

	-- Список для кнопок
	local list = Instance.new("Frame")
	list.Size = UDim2.new(1, -24, 1, -65)
	list.Position = UDim2.new(0, 12, 0, 55)
	list.BackgroundTransparency = 1
	list.Parent = frame

	local layout = Instance.new("UIListLayout")
	layout.Padding = UDim.new(0, 8)
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.Parent = list

	-- Генерация 5 кнопок
	for i, data in pairs(SCRIPTS_DATA) do
		local btn = Instance.new("TextButton")
		btn.Name = "ActionBtn"
		btn.Size = UDim2.new(1, 0, 0, 48)
		btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		btn.BackgroundTransparency = 0.94
		btn.BorderSizePixel = 0
		btn.Text = data.Name
		btn.TextColor3 = Color3.fromRGB(220, 220, 220)
		btn.Font = Enum.Font.GothamMedium
		btn.TextSize = 14
		btn.AutoButtonColor = false
		btn.Parent = list

		Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
		
		local bStroke = Instance.new("UIStroke")
		bStroke.Thickness = 1
		bStroke.Color = Color3.fromRGB(0, 255, 120)
		bStroke.Transparency = 0.8
		bStroke.Parent = btn

		-- Эффекты при наведении
		btn.MouseEnter:Connect(function()
			TweenService:Create(btn, TweenInfo.new(0.3), {BackgroundTransparency = 0.88, TextColor3 = Color3.new(1,1,1)}):Play()
			TweenService:Create(bStroke, TweenInfo.new(0.3), {Transparency = 0.3}):Play()
		end)
		btn.MouseLeave:Connect(function()
			TweenService:Create(btn, TweenInfo.new(0.3), {BackgroundTransparency = 0.94, TextColor3 = Color3.fromRGB(200,200,200)}):Play()
			TweenService:Create(bStroke, TweenInfo.new(0.3), {Transparency = 0.8}):Play()
		end)

		-- Логика нажатия
		btn.MouseButton1Click:Connect(function()
			btn.Text = "⌛ Loading..."
			local success, err = pcall(function()
				loadstring(game:HttpGet(data.Url))()
			end)
			task.wait(0.4)
			btn.Text = success and "✅ Executed!" or "❌ Error"
			task.wait(1)
			btn.Text = data.Name
		end)
	end

	-- Передвижение (Dragging)
	local dragging, dragStart, startPos
	header.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPos = frame.Position
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			local delta = input.Position - dragStart
			frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)
	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
	end)

	-- Открытие/Закрытие на F1
	UserInputService.InputBegan:Connect(function(input, processed)
		if not processed and input.KeyCode == Enum.KeyCode.F1 then
			frame.Visible = not frame.Visible
		end
	end)

	-- Полное удаление
	destroyBtn.MouseButton1Click:Connect(function()
		sg:Destroy()
	end)
end

Players.PlayerAdded:Connect(createModernGui)
for _, p in pairs(Players:GetPlayers()) do createModernGui(p) end
