-- 💀 ULTRA DEAD RAILS SCRIPT v3 - Part 1
-- GUI Setup, Olive Green Styling, Rounded Edges, Toggle with RightShift

local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ws = game:GetService("Workspace")
local char = lp.Character or lp.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")

local gui = Instance.new("ScreenGui", lp:WaitForChild("PlayerGui"))
gui.Name = "UltraDRGui"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 420, 0, 620)
frame.Position = UDim2.new(0.5, -210, 0.5, -310)
frame.BackgroundColor3 = Color3.fromRGB(107, 142, 35)
frame.Active = true
frame.Draggable = true

local corner = Instance.new("UICorner", frame)
corner.CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "💀 ULTRA DEAD RAILS PANEL v3"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.SourceSansBold
title.TextSize = 22

UIS.InputBegan:Connect(function(i)
    if i.KeyCode == Enum.KeyCode.RightShift then
        frame.Visible = not frame.Visible
    end
end)

local function makeButton(text, y, callback)
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.Position = UDim2.new(0.05, 0, 0, y)
    btn.BackgroundColor3 = Color3.fromRGB(88, 113, 20)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Text = text
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 18
    btn.MouseButton1Click:Connect(callback)
    local round = Instance.new("UICorner", btn)
    round.CornerRadius = UDim.new(0, 8)
end
-- 🛡 GOD MODE
makeButton("🛡 God Mode", 50, function()
    for _, v in pairs(char:GetDescendants()) do
        if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then
            v.CanCollide = false
            v.Transparency = 1
        end
    end
    hum.Name = "God"
    hum.MaxHealth = math.huge
    hum.Health = math.huge
    if hum:FindFirstChild("HealthChanged") then
        hum.HealthChanged:Connect(function()
            hum.Health = math.huge
        end)
    end
end)

-- 🔫 GUN BUFFS
makeButton("🔫 Infinite Ammo & Buffs", 100, function()
    for _, tool in ipairs(lp.Backpack:GetDescendants()) do
        if tool:IsA("NumberValue") then
            local name = tool.Name:lower()
            if name:match("ammo") then tool.Value = math.huge end
            if name:match("recoil") then tool.Value = 0 end
            if name:match("firerate") then tool.Value = 0.05 end
        end
    end
end)

-- ⚡ SPEED BOOST
makeButton("⚡ Speed Boost", 150, function()
    hum.WalkSpeed = 18
    hum.JumpPower = 18
end)
