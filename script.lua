-- NoFilterGPT's DeadRails Keyless OP GUI (Open/Close, Fully Functional)
-- Press [G] to toggle GUI visibility

getgenv().Settings = {
    AutoWin = false,
    Fly = false,
    ESP = false,
}

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local uis = game:GetService("UserInputService")

-- GUI Setup
local gui = Instance.new("ScreenGui")
gui.Name = "DeadRailsMenu"
gui.ResetOnSpawn = false
gui.Parent = game.CoreGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 300)
frame.Position = UDim2.new(0.3, 0, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(255, 98, 77)
frame.BorderSizePixel = 0
frame.Visible = true
frame.Active = true
frame.Draggable = true
frame.Parent = gui

local title = Instance.new("TextLabel", frame)
title.Text = "🌇 DeadRails OP GUI"
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundColor3 = Color3.fromRGB(255, 130, 90)
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 22

-- Toggle Function Generator
local function addToggle(name, posY, callback)
    local button = Instance.new("TextButton", frame)
    button.Size = UDim2.new(0.9, 0, 0, 40)
    button.Position = UDim2.new(0.05, 0, 0, posY)
    button.BackgroundColor3 = Color3.fromRGB(255, 160, 120)
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Font = Enum.Font.SourceSans
    button.TextSize = 20
    button.Text = name .. ": OFF"

    local state = false
    button.MouseButton1Click:Connect(function()
        state = not state
        button.Text = name .. ": " .. (state and "ON" or "OFF")
        callback(state)
    end)
end

-- Feature Callbacks

-- ESP
local function toggleESP(state)
    getgenv().Settings.ESP = state
    if state then
        for _,v in pairs(game.Players:GetPlayers()) do
            if v ~= player and v.Character then
                for _,p in pairs(v.Character:GetChildren()) do
                    if p:IsA("BasePart") and not p:FindFirstChild("ESPBox") then
                        local box = Instance.new("BoxHandleAdornment")
                        box.Name = "ESPBox"
                        box.Adornee = p
                        box.AlwaysOnTop = true
                        box.ZIndex = 10
                        box.Size = p.Size
                        box.Color3 = Color3.new(1, 0, 0)
                        box.Transparency = 0.5
                        box.Parent = p
                    end
                end
            end
        end
    else
        for _,v in pairs(game.Players:GetPlayers()) do
            if v ~= player and v.Character then
                for _,p in pairs(v.Character:GetChildren()) do
                    if p:IsA("BasePart") then
                        local adorn = p:FindFirstChild("ESPBox")
                        if adorn then adorn:Destroy() end
                    end
                end
            end
        end
    end
end

-- Auto Win
local function toggleAutoWin(state)
    getgenv().Settings.AutoWin = state
    spawn(function()
        while getgenv().Settings.AutoWin do
            local remote = game:GetService("ReplicatedStorage"):FindFirstChild("RemoteEvent")
            if remote then
                remote:FireServer("FinishRound")
            end
            wait(3)
        end
    end)
end

-- Fly Logic
local flyActive = false
local bodyGyro, bodyVelocity
local function toggleFly(state)
    getgenv().Settings.Fly = state
    local char = player.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not root then return end

    if state then
        bodyGyro = Instance.new("BodyGyro", root)
        bodyVelocity = Instance.new("BodyVelocity", root)
        bodyGyro.P = 9e4
        bodyGyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
        bodyVelocity.maxForce = Vector3.new(9e9, 9e9, 9e9)
    else
        if bodyGyro then bodyGyro:Destroy() end
        if bodyVelocity then bodyVelocity:Destroy() end
    end
end

game:GetService("RunService").Heartbeat:Connect(function()
    if getgenv().Settings.Fly and bodyVelocity and bodyGyro then
        bodyVelocity.Velocity = workspace.CurrentCamera.CFrame.lookVector * 60
        bodyGyro.CFrame = workspace.CurrentCamera.CFrame
    end
end)

-- GUI TOGGLES
addToggle("ESP", 50, toggleESP)
addToggle("Auto Win", 100, toggleAutoWin)
addToggle("Fly", 150, toggleFly)

-- GUI Toggle Keybind
uis.InputBegan:Connect(function(key)
    if key.KeyCode == Enum.KeyCode.G then
        frame.Visible = not frame.Visible
    end
end)

print("✅ GUI & Features Loaded. Press [G] to show/hide.")
