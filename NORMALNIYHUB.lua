local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local tornadoAngle = 0
local tornadoActive = false

-- Конфигурация кнопок
local SCRIPTS_DATA = {
	{Name = "Bot Script", Url = "https://raw.githubusercontent.com/doloword-hash/botscr54iptts.lua/refs/heads/main/bosa.lua"},
	{Name = "Infinity Yield", Url = "https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"},
	{Name = "Rostickk Hub", Url = "https://raw.githubusercontent.com/doloword-hash/botscr54iptts.lua/refs/heads/main/SHEDEVR.lua"},
	{Name = "Normalniy MM2", Url = "https://raw.githubusercontent.com/doloword-hash/botscr54iptts.lua/refs/heads/main/MMAGM%232"},
	{Name = "Teleport (TAB)", Url = "https://raw.githubusercontent.com/doloword-hash/botscr54iptts.lua/refs/heads/main/Thdfeleposr.lua"}
}

local function createModernGui()
	local sg = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
	sg.Name = "GreenNeon_V4"
	sg.ResetOnSpawn = false

	local frame = Instance.new("Frame", sg)
	frame.Name = "MainFrame"
	frame.Size = UDim2.new(0, 280, 0, 480) -- Увеличил высоту
	frame.Position = UDim2.new(0.5, -140, 0.5, -240)
	frame.BackgroundColor3 = Color3.fromRGB(10, 15, 10)
	frame.BackgroundTransparency = 0.1
	Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 14)
	local mainStroke = Instance.new("UIStroke", frame)
	mainStroke.Thickness = 2.5; mainStroke.Color = Color3.fromRGB(0, 255, 120); mainStroke.Transparency = 0.4

	-- Заголовок
	local title = Instance.new("TextLabel", frame)
	title.Text = "  NORMALNIY EXE [v1]"; title.Size = UDim2.new(1, 0, 0, 45)
	title.BackgroundTransparency = 1; title.TextColor3 = Color3.fromRGB(0, 255, 120)
	title.Font = "GothamBold"; title.TextSize = 14; title.TextXAlignment = "Left"

	local list = Instance.new("ScrollingFrame", frame)
	list.Size = UDim2.new(1, -20, 1, -100); list.Position = UDim2.new(0, 10, 0, 50)
	list.BackgroundTransparency = 1; list.CanvasSize = UDim2.new(0,0,0,500); list.ScrollBarThickness = 0
	local layout = Instance.new("UIListLayout", list); layout.Padding = UDim.new(0, 8)

	-- Функция создания кнопок
	local function makeBtn(name, callback)
		local btn = Instance.new("TextButton", list)
		btn.Size = UDim2.new(1, 0, 0, 40); btn.BackgroundColor3 = Color3.fromRGB(255,255,255); btn.BackgroundTransparency = 0.94
		btn.Text = name; btn.TextColor3 = Color3.fromRGB(200,200,200); btn.Font = "GothamMedium"; btn.TextSize = 13
		Instance.new("UICorner", btn)
		btn.MouseButton1Click:Connect(callback)
		return btn
	end

	-- Генерация стандартных кнопок
	for _, data in pairs(SCRIPTS_DATA) do
		makeBtn(data.Name, function()
			loadstring(game:HttpGet(data.Url))()
		end)
	end

	-- КНОПКА ДЛЯ СВОЕЙ ССЫЛКИ
	local customInput = Instance.new("TextBox", frame)
	customInput.Size = UDim2.new(1, -20, 0, 30); customInput.Position = UDim2.new(0, 10, 1, -80)
	customInput.PlaceholderText = "Paste script URL here..."; customInput.Text = ""
	customInput.BackgroundColor3 = Color3.fromRGB(20, 30, 20); customInput.TextColor3 = Color3.new(1,1,1)
	Instance.new("UICorner", customInput)

	local runCustom = Instance.new("TextButton", frame)
	runCustom.Size = UDim2.new(1, -20, 0, 35); runCustom.Position = UDim2.new(0, 10, 1, -45)
	runCustom.BackgroundColor3 = Color3.fromRGB(0, 150, 80); runCustom.Text = "RUN FROM URL"
	runCustom.TextColor3 = Color3.new(1,1,1); Instance.new("UICorner", runCustom)
	
	runCustom.MouseButton1Click:Connect(function()
		if customInput.Text ~= "" then
			pcall(function() loadstring(game:HttpGet(customInput.Text))() end)
		end
	end)

	-- Логика перетаскивания
	local dragging, dragStart, startPos
	title.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging, dragStart, startPos = true, i.Position, frame.Position end end)
	UserInputService.InputChanged:Connect(function(i) if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = i.Position - dragStart
		frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end end)
	UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end)

	-- Скрытие на F1
	UserInputService.InputBegan:Connect(function(i, g) if not g and i.KeyCode == Enum.KeyCode.F1 then frame.Visible = not frame.Visible end end)
end

createModernGui()
