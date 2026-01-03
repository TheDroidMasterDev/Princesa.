-- [[ PRINCESA HUB - HUD EXCLUSIVO COM MINIMIZAR ]]
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PrincesaHub_System"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

-- --- CONFIGURAÇÃO DA JANELA PRINCIPAL ---
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Size = UDim2.new(0, 220, 0, 280)
MainFrame.Position = UDim2.new(0.5, -110, 0.5, -140)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true -- Pode arrastar pelo celular

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 10)
Corner.Parent = MainFrame

local Stroke = Instance.new("UIStroke")
Stroke.Thickness = 2
Stroke.Color = Color3.fromRGB(255, 0, 0)
Stroke.Parent = MainFrame

-- Efeito RGB na Borda
spawn(function()
    while task.wait() do
        local color = Color3.fromHSV(tick() % 5 / 5, 1, 1)
        Stroke.Color = color
    end
end)

-- TÍTULO
local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.Size = UDim2.new(1, -35, 0, 35)
Title.BackgroundTransparency = 1
Title.Text = "PRINCESA HUB 👑"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextSize = 18
Title.Font = Enum.Font.SourceSansBold

-- BOTÃO X (MINIMIZAR)
local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = MainFrame
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -32, 0, 2)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.new(1, 0, 0)
CloseBtn.TextSize = 20
CloseBtn.Font = Enum.Font.SourceSansBold

-- --- BOTÃO FLUTUANTE (BOLINHA COM COROA) ---
local OpenBtn = Instance.new("ImageButton")
OpenBtn.Name = "BolinhaCoroa"
OpenBtn.Parent = ScreenGui
OpenBtn.Size = UDim2.new(0, 50, 0, 50)
OpenBtn.Position = UDim2.new(0.1, 0, 0.5, 0)
OpenBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
OpenBtn.Image = "rbxassetid://10633345441" -- ID de uma coroa (ou troque por outra de sua preferência)
OpenBtn.Visible = false
OpenBtn.Active = true
OpenBtn.Draggable = true

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(1, 0)
BtnCorner.Parent = OpenBtn

local BtnStroke = Instance.new("UIStroke")
BtnStroke.Thickness = 2
BtnStroke.Color = Color3.new(1, 1, 1)
BtnStroke.Parent = OpenBtn

-- LÓGICA DE MINIMIZAR / ABRIR
CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    OpenBtn.Visible = true
end)

OpenBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    OpenBtn.Visible = false
end)

-- --- CONTAINER DE BOTÕES ---
local Container = Instance.new("ScrollingFrame")
Container.Parent = MainFrame
Container.Position = UDim2.new(0, 5, 0, 40)
Container.Size = UDim2.new(1, -10, 1, -45)
Container.BackgroundTransparency = 1
Container.CanvasSize = UDim2.new(0, 0, 1.5, 0)
Container.ScrollBarThickness = 0

local Layout = Instance.new("UIListLayout")
Layout.Parent = Container
Layout.Padding = UDim.new(0, 5)
Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local function AddButton(name, color, func)
    local b = Instance.new("TextButton")
    b.Parent = Container
    b.Size = UDim2.new(0.9, 0, 0, 40)
    b.BackgroundColor3 = color
    b.Text = name
    b.TextColor3 = Color3.new(1, 1, 1)
    b.Font = Enum.Font.SourceSansSemibold
    b.TextSize = 14
    local c = Instance.new("UICorner", b)
    c.CornerRadius = UDim.new(0, 8)
    b.MouseButton1Click:Connect(func)
end

-- --- FUNÇÕES ---
AddButton("PEGAR TODAS ARMAS", Color3.fromRGB(46, 204, 113), function()
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("Tool") then v:Clone().Parent = game.Players.LocalPlayer.Backpack end
    end
end)

AddButton("DELETAR MAPA (CLONES)", Color3.fromRGB(231, 76, 60), function()
    local function Striker(offset)
        task.spawn(function()
            for i = 1, 150 do
                local p = Instance.new("Part", workspace)
                p.Size = Vector3.new(40, 4, 40)
                p.Transparency = 1
                p.Anchored = true
                p.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(offset, -7, -i*2.5)
                p.Touched:Connect(function(h)
                    if h:IsA("BasePart") and not h:IsDescendantOf(game.Players.LocalPlayer.Character) then
                        h.Anchored = false
                        h.Velocity = Vector3.new(0, -1000, 0)
                    end
                end)
                task.wait(0.04)
                p:Destroy()
            end
        end)
    end
    Striker(-12)
    Striker(12)
end)

AddButton("DROP TUDO", Color3.fromRGB(241, 194, 50), function()
    for _, t in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do t.Parent = workspace end
end)

AddButton("ATIVAR VOO", Color3.fromRGB(52, 152, 219), function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiRoblox/main/FlyGuiScript.lua"))()
end)
