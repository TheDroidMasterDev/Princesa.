local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("SHURIKEN RGB - ULTRA COLLECTOR", "DarkScene")

-- LOOP RGB
spawn(function()
    while task.wait() do
        local Color = Color3.fromHSV(tick() % 5 / 5, 1, 1)
        Library:ChangeColor(Color)
    end
end)

-- ABA: COLETOR SUPREMO
local CollTab = Window:NewTab("Coletor")
local CollSec = CollTab:NewSection("Puxar Armas (Até não fabricadas)")

CollSec:NewButton("Forçar Spawn de Todas as Armas", "Busca em pastas ocultas do Servidor", function()
    -- Procura em todo o jogo, não só no chão
    local locations = {game.Workspace, game.ReplicatedStorage, game.Lighting}
    
    for _, location in pairs(locations) do
        for _, item in pairs(location:GetDescendants()) do
            if item:IsA("Tool") or item:IsA("HopperBin") then
                -- Clona o item se ele for um "modelo" ou move se for real
                local tool = item:Clone()
                tool.Parent = game.Players.LocalPlayer.Backpack
            end
        end
    end
    print("Busca completa em pastas ocultas!")
end)

-- ABA: DESTRUIÇÃO (SERVER SIDE)
local DestTab = Window:NewTab("Destruição")
local DestSec = DestTab:NewSection("Bombardeio de Shurikens")

DestSec:NewButton("Ativar 2 Clones (Apagar Mapa)", "Destrói o chão para todos", function()
    local function CreateStriker(side)
        local clone = Instance.new("Part")
        clone.Size = Vector3.new(1, 1, 1)
        clone.Transparency = 0.6
        clone.Anchored = true
        clone.CanCollide = false
        clone.Parent = game.Workspace
        
        task.spawn(function()
            for i = 1, 200 do
                local bomb = Instance.new("Part")
                bomb.Parent = game.Workspace
                bomb.Size = Vector3.new(35, 3, 35) -- Área gigante
                bomb.Transparency = 1
                bomb.CanCollide = false
                bomb.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(side, -6, -i*2)
                
                bomb.Touched:Connect(function(hit)
                    if hit:IsA("BasePart") and not hit:IsDescendantOf(game.Players.LocalPlayer.Character) then
                        hit.Anchored = false
                        hit.Velocity = Vector3.new(0, -1500, 0) -- Joga pro vácuo
                    end
                end)
                task.wait(0.03)
                bomb:Destroy()
                clone.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(side, 0, 0)
            end
            clone:Destroy()
        end)
    end
    CreateStriker(-10)
    CreateStriker(10)
end)

-- ABA: ITENS
local ItemTab = Window:NewTab("Inventário")
local ItemSec = ItemTab:NewSection("Drop & Restaurar")

ItemSec:NewButton("Drop All (Limpar Tudo)", "Joga armas no chão", function()
    for _, t in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        t.Parent = game.Workspace
    end
end)

-- ABA: JOGADOR
local PlayTab = Window:NewTab("Jogador")
local PlaySec = PlayTab:NewSection("Status")

PlaySec:NewSlider("Velocidade", "Correr", 500, 16, function(s)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end)

PlaySec:NewButton("Ativar Voo", "Voe para apagar o mapa", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiRoblox/main/FlyGuiScript.lua"))()
end)
