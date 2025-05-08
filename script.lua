
-- 🌿 MEGA Dead Rails Script | Full Feature Packed | Olive Green GUI | Rounded Edges | Toggleable Menu
-- Made by NoFilterGPT for Gravygood | May 2025

local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ws = game:GetService("Workspace")
local char = lp.Character or lp.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")

-- 🌿 GUI Setup
local gui = Instance.new("ScreenGui", lp:WaitForChild("PlayerGui"))
gui.Name = "MegaDRGui"

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 400, 0, 600)
frame.Position = UDim2.new(0.5, -200, 0.5, -300)
frame.BackgroundColor3 = Color3.fromRGB(107, 142, 35) -- Olive green
frame.Visible = true
frame.Parent = gui
frame.Active = true
frame.Draggable = true

local corner = Instance.new("UICorner", frame)
corner.CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "🌿 Mega Dead Rails Panel"
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.SourceSansBold
title.TextSize = 22

-- Toggle Menu Keybind
local open = true
UIS.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightShift then
        open = not open
        frame.Visible = open
    end
end)

-- Button Generator
local function makeButton(text, y, callback)
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.Position = UDim2.new(0.05, 0, 0, y)
    btn.BackgroundColor3 = Color3.fromRGB(88, 113, 20)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 18
    btn.Text = text
    btn.MouseButton1Click:Connect(callback)
    local round = Instance.new("UICorner", btn)
    round.CornerRadius = UDim.new(0, 8)
end

-- Features
makeButton("⚡ Boost Speed & Jump", 50, function()
    hum.WalkSpeed = 120
    hum.JumpPower = 180
end)

makeButton("👁 ESP (Players/NPCs)", 100, function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= lp and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local gui = Instance.new("BillboardGui", p.Character.HumanoidRootPart)
            gui.Size = UDim2.new(0, 100, 0, 40)
            gui.AlwaysOnTop = true
            local label = Instance.new("TextLabel", gui)
            label.Size = UDim2.new(1, 0, 1, 0)
            label.Text = p.Name
            label.TextColor3 = Color3.new(1, 0, 0)
            label.BackgroundTransparency = 1
            label.TextScaled = true
        end
    end
end)

makeButton("☠ Kill Aura", 150, function()
    RunService.RenderStepped:Connect(function()
        for _, mob in pairs(ws:GetDescendants()) do
            if mob:IsA("Model") and mob:FindFirstChild("Humanoid") and not Players:GetPlayerFromCharacter(mob) then
                if (char.HumanoidRootPart.Position - mob.HumanoidRootPart.Position).Magnitude < 20 then
                    mob.Humanoid.Health = 0
                end
            end
        end
    end)
end)

makeButton("💰 AutoFarm Loop", 200, function()
    while true do
        for _, mob in pairs(ws:GetDescendants()) do
            if mob:IsA("Model") and mob:FindFirstChild("Humanoid") and not Players:GetPlayerFromCharacter(mob) then
                mob.Humanoid.Health = 0
            end
        end
        wait(1)
    end
end)

makeButton("📍 TP to Spawn", 250, function()
    char:MoveTo(Vector3.new(0, 10, 0))
end)

makeButton("📍 TP to Sniper Tower", 300, function()
    char:MoveTo(Vector3.new(300, 200, -500))
end)

makeButton("🔫 Buff Guns (Infinite Ammo)", 350, function()
    for _, tool in ipairs(lp.Backpack:GetChildren()) do
        if tool:IsA("Tool") and tool:FindFirstChild("GunStats") then
            local stats = tool.GunStats
            if stats:FindFirstChild("Ammo") then stats.Ammo.Value = math.huge end
            if stats:FindFirstChild("Recoil") then stats.Recoil.Value = 0 end
            if stats:FindFirstChild("FireRate") then stats.FireRate.Value = 0.05 end
        end
    end
end)

makeButton("🛡 God Mode", 400, function()
    pcall(function()
        hum.MaxHealth = math.huge
        hum.Health = math.huge
        hum.Name = "GodHumanoid"
    end)
end)

makeButton("🛑 Close GUI", 500, function()
    gui:Destroy()
end)

print("✅ Mega Dead Rails Script Loaded | Toggle with Right Shift")

