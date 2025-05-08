--[[
    NoFilter Dead Rails GUI – DRAGGABLE & TOGGLEABLE EDITION
    Clean, keyless, and now fucking mobile with your damn mouse.
]]

local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local Plr = game.Players.LocalPlayer
local Char = Plr.Character or Plr.CharacterAdded:Wait()

-- GUI Setup
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "NoFilterHub"

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 250)
frame.Position = UDim2.new(0.5, -150, 0.5, -125)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = gui

local uiCorner = Instance.new("UICorner", frame)
uiCorner.CornerRadius = UDim.new(0, 10)

local layout = Instance.new("UIListLayout", frame)
layout.Padding = UDim.new(0, 8)
layout.FillDirection = Enum.FillDirection.Vertical
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.VerticalAlignment = Enum.VerticalAlignment.Top

local title = Instance.new("TextLabel")
title.Text = "🔥 NoFilter Hub – Sexy & Dragable"
title.TextColor3 = Color3.fromRGB(255, 85, 0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.Size = UDim2.new(1, 0, 0, 30)
title.Parent = frame

-- Toggle GUI Visibility with RightShift
local visible = true
UIS.InputBegan:Connect(function(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.RightShift and not gameProcessed then
        visible = not visible
        gui.Enabled = visible
    end
end)

-- Button Maker
local function makeButton(text, callback)
    local button = Instance.new("TextButton")
    button.Text = text
    button.Size = UDim2.new(0.9, 0, 0, 30)
    button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.Gotham
    button.TextSize = 14
    button.AutoButtonColor = true
    button.Parent = frame

    local corner = Instance.new("UICorner", button)
    corner.CornerRadius = UDim.new(0, 6)

    button.MouseButton1Click:Connect(callback)
end

-- ESP
makeButton("👁️ ESP", function()
    for _, v in pairs(workspace:GetChildren()) do
        if v:IsA("Model") and v:FindFirstChild("Humanoid") and v ~= Char then
            if not v:FindFirstChild("Highlight") then
                local hl = Instance.new("Highlight", v)
                hl.FillColor = Color3.fromRGB(255, 0, 0)
                hl.OutlineColor = Color3.fromRGB(255, 255, 255)
            end
        end
    end
end)

-- Fly
local flying = false
makeButton("🚀 Toggle Fly (F)", function()
    flying = not flying
end)

RS.RenderStepped:Connect(function()
    if flying and Char and Char:FindFirstChild("HumanoidRootPart") then
        Char:TranslateBy(Vector3.new(0, 2, 0))
    end
end)

-- Auto Bond Grabber
local autoFarm = false
makeButton("💸 Toggle Auto Bond Grab", function()
    autoFarm = not autoFarm
    while autoFarm do
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("TouchTransmitter") and v.Parent:FindFirstChild("TouchInterest") then
                pcall(function()
                    firetouchinterest(Char.HumanoidRootPart, v.Parent, 0)
                    firetouchinterest(Char.HumanoidRootPart, v.Parent, 1)
                end)
            end
        end
        wait(1)
    end
end)

-- Kill Aura
local aura = false
makeButton("💀 Toggle Kill Aura", function()
    aura = not aura
end)

RS.Heartbeat:Connect(function()
    if aura then
        for _, pl in pairs(game.Players:GetPlayers()) do
            if pl ~= Plr and pl.Character and pl.Character:FindFirstChild("HumanoidRootPart") then
                local dist = (pl.Character.HumanoidRootPart.Position - Char.HumanoidRootPart.Position).Magnitude
                if dist <= 15 then
                    local tool = Char:FindFirstChildOfClass("Tool")
                    if tool then tool:Activate() end
                end
            end
        end
    end
end)

print("🔥 Loaded: NoFilter Dead Rails GUI with drag, toggle, and enough filth to crash your ethics.")
