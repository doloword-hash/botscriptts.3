-- Скрипт в Workspace (Server Side)
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- Конфигурация кнопок и ссылок
local SCRIPTS_DATA = {
	{
		Name = "Bot Script", 
		Url = "https://raw.githubusercontent.com/doloword-hash/botscr54iptts.lua/refs/heads/main/bosa.lua"
	},
	{
		Name = "Infinity yeld", 
		Url = "https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"
	},
	{
		Name = "Rostickk", 
		Url = "https://raw.githubusercontent.com/ссылка_тут"
	}
}

local function createModernGui(player)
	local sg = Instance.new("ScreenGui")
	sg.Name = "UltraHub_V2"
	sg.ResetOnSpawn = false
	sg.IgnoreGuiInset = true
	sg.Parent = player:WaitForChild("PlayerGui")

	-- Главное окно
	local frame = Instance.new("Frame")
	frame.Name = "MainFrame"
	frame.Size = UDim2.new(0, 280, 0, 320)
	frame.Position = UDim2.new(0, 40, 0, 40) -- Сверху слева
	frame.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
	frame.BackgroundTransparency = 0.1
	frame.BorderSizePixel = 0
	frame.Visible = false
	frame.Parent = sg

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 12)
	corner.Parent = frame

	local stroke = Instance.new("UIStroke")
	stroke.Thickness = 1.8
	stroke.Color = Color3.fromRGB(45, 45, 55)
	stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	stroke.Parent = frame

	-- Верхняя панель (Header)
	local header = Instance.new("Frame")
	header.Size = UDim2.new(1, 0, 0, 40)
	header.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	header.BackgroundTransparency = 0.95
	header.BorderSizePixel = 0
	header.Parent = frame

	local hCorner = Instance.new("UICorner")
	hCorner.CornerRadius = UDim.new(0, 12)
	hCorner.Parent = header

	local title = Instance.new("TextLabel")
	title.Text = "NORMALNIY EXECUTOR"
	title.Size = UDim2.new(1, -45, 1, 0)
	title.BackgroundTransparency = 1
	title.TextColor3 = Color3.fromRGB(255, 255, 255)
	title.Font = Enum.Font.GothamBold
	title.TextSize = 13
	title.TextXAlignment = Enum.TextXAlignment.Left
	title.Parent = header

	-- Кнопка Х (Удалить)
	local destroyBtn = Instance.new("TextButton")
	destroyBtn.Text = "X"
	destroyBtn.Size = UDim2.new(0, 35, 0, 35)
	destroyBtn.Position = UDim2.new(1, -38, 0, 2)
	destroyBtn.BackgroundTransparency = 1
	destroyBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
	destroyBtn.Font = Enum.Font.GothamBold
	destroyBtn.TextSize = 16
	destroyBtn.Parent = header

	-- Список для кнопок
	local list = Instance.new("Frame")
	list.Size = UDim2.new(1, -20, 1, -60)
	list.Position = UDim2.new(0, 10, 0, 50)
	list.BackgroundTransparency = 1
	list.Parent = frame

	local layout = Instance.new("UIListLayout")
	layout.Padding = UDim.new(0, 10)
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.Parent = list

	-- Функция создания кнопок
	for i, data in pairs(SCRIPTS_DATA) do
		local btn = Instance.new("TextButton")
		btn.Name = "ActionBtn"
		btn.Size = UDim2.new(1, 0, 0, 45)
		btn.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
		btn.BorderSizePixel = 0
		btn.Text = data.Name
		btn.TextColor3 = Color3.fromRGB(200, 200, 200)
		btn.Font = Enum.Font.GothamMedium
		btn.TextSize = 14
		btn.AutoButtonColor = false
		btn.Parent = list

		local bCorner = Instance.new("UICorner")
		bCorner.CornerRadius = UDim.new(0, 8)
		bCorner.Parent = btn
		
		local bStroke = Instance.new("UIStroke")
		bStroke.Thickness = 1
		bStroke.Color = Color3.fromRGB(50, 50, 60)
		bStroke.Parent = btn

		-- Эффекты
		btn.MouseEnter:Connect(function()
			TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 55), TextColor3 = Color3.new(1,1,1)}):Play()
		end)
		btn.MouseLeave:Connect(function()
			TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 30, 35), TextColor3 = Color3.fromRGB(200,200,200)}):Play()
		end)

		-- ЛОГИКА ЗАГРУЗКИ (loadstring)
		btn.MouseButton1Click:Connect(function()
			btn.Text = "⌛ Loading..."
			local success, err = pcall(function()
				-- Работает только в эксплойтах с поддержкой HttpGet
				loadstring(game:HttpGet(data.Url))()
			end)
			task.wait(0.5)
			btn.Text = success and "✅ Done!" or "❌ Error"
			task.wait(1)
			btn.Text = data.Name
		end)
	end

	-- Передвижение (Dragging)
	local dragging, dragInput, dragStart, startPos
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

	-- Открытие на F1
	UserInputService.InputBegan:Connect(function(input, processed)
		if not processed and input.KeyCode == Enum.KeyCode.F1 then
			frame.Visible = not frame.Visible
			if frame.Visible then
				frame.GroupTransparency = 1
				TweenService:Create(frame, TweenInfo.new(0.3), {GroupTransparency = 0}):Play()
			end
		end
	end)

	-- Полное удаление
	destroyBtn.MouseButton1Click:Connect(function()
		sg:Destroy()
	end)
end

-- Авто-раздача скрипта всем игрокам
Players.PlayerAdded:Connect(createModernGui)
for _, p in pairs(Players:GetPlayers()) do createModernGui(p) end
