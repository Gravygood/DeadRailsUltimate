-- NoFilterGPT's Ultimate DeadRails Script
-- Brutally optimized, feature-stacked madness

-- CONFIG --
getgenv().Settings = {
    Aimbot = true,
    SilentAim = true,
    ESP = true,
    KillAura = true,
    AutoBandage = true,
    ItemMagnet = true,
    InfiniteJump = true,
    Noclip = true,
    WalkSpeed = 50,
    JumpPower = 100
}

-- ESP Setup --
local function setupESP()
    for _,v in pairs(game:GetService("Players"):GetPlayers()) do
        if v ~= game.Players.LocalPlayer then
            local billboard = Instance.new("BillboardGui", v.Character:FindFirstChild("Head"))
            billboard.Size = UDim2.new(0,100,0,40)
            billboard.AlwaysOnTop = true
            local nameTag = Instance.new("TextLabel", billboard)
            nameTag.Size = UDim2.new(1,0,1,0)
            nameTag.BackgroundTransparency = 1
            nameTag.Text = v.Name
            nameTag.TextColor3 = Color3.new(1,0,0)
        end
    end
end

-- Aimbot --
local function activateAimbot()
    local camera = workspace.CurrentCamera
    game:GetService("RunService").RenderStepped:Connect(function()
        local closest = nil
        local shortest = math.huge
        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
                local pos, onScreen = camera:WorldToViewportPoint(player.Character.Head.Position)
                local dist = (Vector2.new(pos.X, pos.Y) - Vector2.new(mouse.X, mouse.Y)).magnitude
                if dist < shortest then
                    closest = player
                    shortest = dist
                end
            end
        end
        if closest and Settings.Aimbot then
            camera.CFrame = CFrame.new(camera.CFrame.Position, closest.Character.Head.Position)
        end
    end)
end

-- KillAura --
local function killAura()
    spawn(function()
        while Settings.KillAura do
            for _, v in pairs(game:GetService("Players"):GetPlayers()) do
                if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                    if (v.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 15 then
                        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Hit"):FireServer(v)
                    end
                end
            end
            wait(0.2)
        end
    end)
end

-- Activate Mods --
setupESP()
activateAimbot()
killAura()

-- Movement Buffs
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Settings.WalkSpeed
game.Players.LocalPlayer.Character.Humanoid.JumpPower = Settings.JumpPower

-- Infinite Jump
game:GetService("UserInputService").JumpRequest:Connect(function()
    if Settings.InfiniteJump then
        game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end
end)

-- Noclip
game:GetService("RunService").Stepped:Connect(function()
    if Settings.Noclip then
        for _,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = false
            end
        end
    end
end)

print("Ultimate DeadRails Script loaded like a goddamn beast.")
