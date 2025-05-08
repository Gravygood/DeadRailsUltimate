-- NoFilterGPT's Full-Body ESP for DeadRails (Sunset GUI included)

getgenv().Settings = {
    Aimbot = false,
    KillAura = false,
    ESP = false
}

-- UI Setup
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Title = Instance.new("TextLabel")

ScreenGui.Name = "DeadRailsSunsetGUI"
ScreenGui.Parent = game.CoreGui

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(255, 94, 77)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.1, 0, 0.2, 0)
Frame.Size = UDim2.new(0, 250, 0, 300)
Frame.Active = true
Frame.Draggable = true

Title.Parent = Frame
Title.BackgroundColor3 = Color3.fromRGB(255, 149, 128)
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Font = Enum.Font.SourceSansBold
Title.Text = "🌇 DeadRails Sunset Hub"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 24

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

-- FULL BODY ESP
local function setupFullBodyESP()
    for _,v in pairs(game:GetService("Players"):GetPlayers()) do
        if v ~= game.Players.LocalPlayer and v.Character then
            for _, part in pairs(v.Character:GetChildren()) do
                if part:IsA("BasePart") and not part:FindFirstChild("ESPBox") then
                    local box = Instance.new("BoxHandleAdornment")
                    box.Name = "ESPBox"
                    box.Adornee = part
                    box.AlwaysOnTop = true
                    box.ZIndex = 10
                    box.Size = part.Size
                    box.Color3 = Color3.fromRGB(255, 0, 0)
                    box.Transparency = 0.7
                    box.Parent = part
                end
            end
        end
    end
end

-- Aimbot
local function aimbot()
    local camera = workspace.CurrentCamera
    local run = game:GetService("RunService")
    run.RenderStepped:Connect(function()
        if getgenv().Settings.Aimbot then
            local closest, dist = nil, math.huge
            for _,v in pairs(game.Players:GetPlayers()) do
                if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Head") then
                    local screenPos, onScreen = camera:WorldToViewportPoint(v.Character.Head.Position)
                    local diff = (Vector2.new(screenPos.X, screenPos.Y) - Vector2.new(mouse.X, mouse.Y)).magnitude
                    if diff < dist then
                        dist = diff
                        closest = v
                    end
                end
            end
            if closest then
                camera.CFrame = CFrame.new(camera.CFrame.Position, closest.Character.Head.Position)
            end
        end
    end)
end

-- Kill Aura
local function killAura()
    spawn(function()
        while true do
            if getgenv().Settings.KillAura then
                for _,v in pairs(game.Players:GetPlayers()) do
                    if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                        if (v.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 15 then
                            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Hit"):FireServer(v)
                        end
                    end
                end
            end
            wait(0.2)
        end
    end)
end

-- Hook GUI Toggles
createToggle("Aimbot", 0.25, function(state) getgenv().Settings.Aimbot = state end)
createToggle("Kill Aura", 0.45, function(state) getgenv().Settings.KillAura = state end)
createToggle("ESP", 0.65, function(state)
    getgenv().Settings.ESP = state
    if state then
        setupFullBodyESP()
    end
end)

aimbot()
killAura()

print("✅ Full-Body ESP & Hacks Loaded - DeadRails Sunset Edition")
