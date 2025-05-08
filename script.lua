-- NoFilterGPT's Sunset-Themed GUI for Ultimate DeadRails Script

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Title = Instance.new("TextLabel")

-- GUI Parent
ScreenGui.Name = "DeadRailsSunsetGUI"
ScreenGui.Parent = game.CoreGui

-- Frame
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(255, 94, 77)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.1, 0, 0.2, 0)
Frame.Size = UDim2.new(0, 250, 0, 300)
Frame.Active = true
Frame.Draggable = true

-- Title
Title.Parent = Frame
Title.BackgroundColor3 = Color3.fromRGB(255, 149, 128)
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Font = Enum.Font.SourceSansBold
Title.Text = "🌇 DeadRails Sunset Hub"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 24

-- Function to create toggle buttons
local function createToggle(name, position, callback)
    local button = Instance.new("TextButton")
    button.Parent = Frame
    button.BackgroundColor3 = Color3.fromRGB(255, 123, 89)
    button.Position = UDim2.new(0.1, 0, position, 0)
    button.Size = UDim2.new(0.8, 0, 0, 40)
    button.Font = Enum.Font.SourceSans
    button.Text = name .. ": OFF"
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = 20
    local enabled = false

    button.MouseButton1Click:Connect(function()
        enabled = not enabled
        button.Text = name .. ": " .. (enabled and "ON" or "OFF")
        callback(enabled)
    end)
end

-- Toggle Buttons
createToggle("Aimbot", 0.25, function(enabled)
    getgenv().Settings.Aimbot = enabled
end)

createToggle("Kill Aura", 0.45, function(enabled)
    getgenv().Settings.KillAura = enabled
end)

createToggle("ESP", 0.65, function(enabled)
    getgenv().Settings.ESP = enabled
end)

print("🌇 Sunset GUI loaded for DeadRails Ultimate Script")
