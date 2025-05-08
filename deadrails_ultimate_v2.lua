
-- 💀 ULTIMATE DEAD RAILS SCRIPT V2 - All In One Weapon of Mass Fucking Destruction
-- Features: ESP, KillAura, AutoFarm, Teleport, Gun Mods, UI Control, God Mode

local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local char = lp.Character or lp.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ws = game:GetService("Workspace")

-- 🧱 GUI Setup
local gui = Instance.new("ScreenGui", lp:WaitForChild("PlayerGui"))
gui.Name = "DeadRailsUltimateGUI"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 400, 0, 550)
frame.Position = UDim2.new(0.5, -200, 0.5, -275)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "💀 Dead Rails ULTIMATE GUI v2"
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.SourceSansBold
title.TextSize = 22

local function makeButton(text, y, callback)
    local b = Instance.new("TextButton", frame)
    b.Size = UDim2.new(0.9, 0, 0, 40)
    b.Position = UDim2.new(0.05, 0, 0, y)
    b.BackgroundColor3 = Color3.fromRGB(35,35,35)
    b.TextColor3 = Color3.new(1,1,1)
    b.Text = text
    b.Font = Enum.Font.SourceSansBold
    b.TextSize = 18
    b.MouseButton1Click:Connect(callback)
end

-- ✅ ESP for Players, Items, Enemies
makeButton("👁 ESP (Players/NPCs)", 50, function()
    for _, obj in pairs(Players:GetPlayers()) do
        if obj ~= lp and obj.Character and obj.Character:FindFirstChild("HumanoidRootPart") then
            local esp = Instance.new("BillboardGui", obj.Character.HumanoidRootPart)
            esp.Size = UDim2.new(0, 100, 0, 40)
            esp.AlwaysOnTop = true
            local label = Instance.new("TextLabel", esp)
            label.Size = UDim2.new(1, 0, 1, 0)
            label.Text = obj.Name
            label.TextColor3 = Color3.new(1,0,0)
            label.TextScaled = true
            label.BackgroundTransparency = 1
        end
    end
    for _, npc in pairs(ws:GetDescendants()) do
        if npc:IsA("Model") and npc:FindFirstChild("Humanoid") and not Players:GetPlayerFromCharacter(npc) then
            local hrp = npc:FindFirstChild("HumanoidRootPart")
            if hrp and not hrp:FindFirstChild("ESP") then
                local esp = Instance.new("BillboardGui", hrp)
                esp.Size = UDim2.new(0, 100, 0, 40)
                esp.AlwaysOnTop = true
                esp.Name = "ESP"
                local label = Instance.new("TextLabel", esp)
                label.Size = UDim2.new(1, 0, 1, 0)
                label.Text = "Enemy"
                label.TextColor3 = Color3.new(1, 1, 0)
                label.TextScaled = true
                label.BackgroundTransparency = 1
            end
        end
    end
end)

-- ✅ KillAura
makeButton("☠ Kill Aura", 100, function()
    RunService.RenderStepped:Connect(function()
        for _, mob in pairs(ws:GetDescendants()) do
            if mob:IsA("Model") and mob:FindFirstChild("Humanoid") and not Players:GetPlayerFromCharacter(mob) then
                local h = mob.Humanoid
                if h.Health > 0 and (char.HumanoidRootPart.Position - mob.HumanoidRootPart.Position).Magnitude < 20 then
                    h.Health = 0
                end
            end
        end
    end)
end)

-- ✅ AutoFarm
makeButton("💰 AutoFarm Enemies", 150, function()
    while true do
        for _, mob in pairs(ws:GetDescendants()) do
            if mob:IsA("Model") and mob:FindFirstChild("Humanoid") and not Players:GetPlayerFromCharacter(mob) then
                mob.Humanoid.Health = 0
                wait(0.1)
            end
        end
        wait(1)
    end
end)

-- ✅ Teleport Buttons
makeButton("📍 Teleport: Spawn", 200, function()
    char:MoveTo(Vector3.new(0, 10, 0))
end)

makeButton("📍 Teleport: Tower", 250, function()
    char:MoveTo(Vector3.new(300, 200, -500)) -- Replace with actual coordinates from your map
end)

-- ✅ Gun Mods
makeButton("🔫 Gun Mods (Infinite Ammo)", 300, function()
    for _, tool in ipairs(lp.Backpack:GetChildren()) do
        if tool:IsA("Tool") and tool:FindFirstChild("GunStats") then
            local stats = tool.GunStats
            if stats:FindFirstChild("Ammo") then stats.Ammo.Value = math.huge end
            if stats:FindFirstChild("Recoil") then stats.Recoil.Value = 0 end
            if stats:FindFirstChild("FireRate") then stats.FireRate.Value = 0.05 end
        end
    end
end)

-- ✅ God Mode / Anti-Kick
makeButton("🛡 God Mode", 350, function()
    pcall(function()
        hum.Name = "Godified"
        hum.MaxHealth = math.huge
        hum.Health = math.huge
    end)
end)

-- ✅ Close GUI
makeButton("🛑 Close", 450, function()
    gui:Destroy()
end)

print("✅ Dead Rails Ultimate V2 loaded.")
