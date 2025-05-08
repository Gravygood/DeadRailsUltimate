--[[
    NoFilter Dead Rails GUI
    Made with zero fucks, zero keys, and 100% chaotic sexy energy.
    Includes: ESP, Fly Toggle, Auto Bond Collector, and Kill Aura
]]

-- GUI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NoFilterHub"
ScreenGui.Parent = game.CoreGui

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 300, 0, 250)
Frame.Position = UDim2.new(0.5, -150, 0.5, -125)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BorderSizePixel = 0
Frame.BackgroundTransparency = 0.05
Frame.Parent = ScreenGui

local UICorner = Instance.new("UICorner", Frame)
UICorner.CornerRadius = UDim.new(0, 10)

local UIListLayout = Instance.new("UIListLayout", Frame)
UIListLayout.Padding = UDim.new(0, 8)
UIListLayout.FillDirection = Enum.FillDirection.Vertical
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Top

local title = Instance.new("TextLabel")
title.Text = "🔥 NoFilter Dead Rails Hub"
title.TextColor3 = Color3.fromRGB(255, 85, 0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.Size = UDim2.new(1, 0, 0, 30)
title.Parent = Frame

-- Toggle function
local function makeButton(name, callback)
    local button = Instance.new("TextButton")
    button.Text = name
    button.Size = UDim2.new(0.9, 0, 0, 30)
    button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.Gotham
    button.TextSize = 14
    button.Parent = Frame

    local corner = Instance.new("UICorner", button)
    corner.CornerRadius = UDim.new(0, 6)

    button.MouseButton1Click:Connect(callback)
end

-- ESP Function
makeButton("👁️ ESP (Highlight Enemies)", function()
    for _, v in pairs(game:GetService("Workspace"):GetChildren()) do
        if v:IsA("Model") and v:FindFirstChild("Humanoid") and v ~= game.Players.LocalPlayer.Character then
            if not v:FindFirstChild("Highlight") then
                local highlight = Instance.new("Highlight", v)
                highlight.FillColor = Color3.fromRGB(255, 0, 0)
                highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
            end
        end
    end
end)

-- Fly Toggle
local flying = false
makeButton("🚀 Toggle Fly [F Key]", function()
    flying = not flying
end)

game:GetService("RunService").RenderStepped:Connect(function()
    if flying then
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            char:TranslateBy(Vector3.new(0, 2, 0))
        end
    end
end)

-- Auto Collect Bonds
local autoFarm = false
makeButton("💸 Auto Collect Bonds", function()
    autoFarm = not autoFarm
    while autoFarm do
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("TouchTransmitter") and v.Parent:FindFirstChild("TouchInterest") then
                pcall(function()
                    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Parent, 0)
                    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Parent, 1)
                end)
            end
        end
        wait(1)
    end
end)

-- Kill Aura
local killAura = false
makeButton("💀 Kill Aura", function()
    killAura = not killAura
end)

game:GetService("RunService").Heartbeat:Connect(function()
    if killAura then
        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") then
                local enemy = player.Character
                if (enemy.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 15 then
                    local tool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
                    if tool then
                        tool:Activate()
                    end
                end
            end
        end
    end
end)

print("NoFilter GUI loaded and ready to fucking ruin Dead Rails.")
