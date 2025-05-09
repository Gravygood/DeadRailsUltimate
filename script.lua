-- DEADRAILS MAXED MOD MENU BY LUA GOD 💻🔥

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local Mouse = LocalPlayer:GetMouse()
local Camera = workspace.CurrentCamera
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")

-- GUI
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "DeadRailsGodGUI"

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 250, 0, 640)
Frame.Position = UDim2.new(0.03, 0, 0.25, 0)
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)

local spacing = 0
local function createButton(text, callback)
	local btn = Instance.new("TextButton", Frame)
	btn.Size = UDim2.new(1, -10, 0, 40)
	btn.Position = UDim2.new(0, 5, 0, spacing)
	btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.Font = Enum.Font.SourceSansBold
	btn.TextSize = 16
	btn.Text = text
	btn.MouseButton1Click:Connect(callback)
	spacing += 45
end

-- Flags
local fly, infJump, noclip, esp, itemEsp, npcEsp = false, false, false, false, false, false
local espFolder = Instance.new("Folder", workspace)
espFolder.Name = "ESP_Objects"

-- Cleanup ESP
local function clearESP()
	for _, v in pairs(espFolder:GetChildren()) do
		if v:IsA("BillboardGui") then
			v:Destroy()
		end
	end
end

-- Player/NPC ESP Core
local function refreshESP()
	clearESP()
	if not esp and not npcEsp then return end

	for _, obj in pairs(workspace:GetDescendants()) do
		local isPlayer = Players:GetPlayerFromCharacter(obj)
		if obj:IsA("Model") and obj:FindFirstChild("Humanoid") and obj:FindFirstChild("HumanoidRootPart") then
			if (esp and isPlayer ~= nil and obj ~= Character) or (npcEsp and isPlayer == nil) then
				local gui = Instance.new("BillboardGui", espFolder)
				gui.Name = "ESP"
				gui.Size = UDim2.new(0, 100, 0, 40)
				gui.AlwaysOnTop = true
				gui.Adornee = obj.HumanoidRootPart

				local lbl = Instance.new("TextLabel", gui)
				lbl.Size = UDim2.new(1, 0, 1, 0)
				lbl.BackgroundTransparency = 1
				lbl.Text = obj.Name
				lbl.TextColor3 = isPlayer and Color3.new(1, 0, 1) or Color3.new(1, 1, 0)
				lbl.TextScaled = true
			end
		end
	end
end

-- Auto refresh every 3s
task.spawn(function()
	while true do
		refreshESP()
		task.wait(3)
	end
end)

-- Mod Functions
local function speedBoost() Humanoid.WalkSpeed = 60 end
local function jumpBoost() Humanoid.JumpPower = 120 end

local function toggleFly()
	fly = not fly
	local hrp = Character:FindFirstChild("HumanoidRootPart")
	if fly then
		local bv = Instance.new("BodyVelocity", hrp)
		bv.Name = "FlyVelocity"
		bv.MaxForce = Vector3.new(0, math.huge, 0)
		bv.Velocity = Vector3.zero
		RS:BindToRenderStep("Flying", 1, function()
			if fly and bv and bv.Parent then
				bv.Velocity = Vector3.new(0, 60, 0)
			end
		end)
	else
		RS:UnbindFromRenderStep("Flying")
		if hrp:FindFirstChild("FlyVelocity") then hrp.FlyVelocity:Destroy() end
	end
end

-- Infinite Jump
UIS.JumpRequest:Connect(function()
	if infJump then
		Humanoid:ChangeState("Jumping")
	end
end)

-- Noclip
RS.Stepped:Connect(function()
	if noclip then
		for _, v in pairs(Character:GetDescendants()) do
			if v:IsA("BasePart") then
				v.CanCollide = false
			end
		end
	end
end)

-- TP to Closest Player
local function tpToClosest()
	local minDist, target = math.huge, nil
	for _, p in pairs(Players:GetPlayers()) do
		if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
			local d = (p.Character.HumanoidRootPart.Position - Character.HumanoidRootPart.Position).Magnitude
			if d < minDist then
				minDist = d
				target = p
			end
		end
	end
	if target then
		Character:SetPrimaryPartCFrame(target.Character.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0))
	end
end

-- Super Dash
local function dash()
	local hrp = Character:FindFirstChild("HumanoidRootPart")
	if hrp then
		hrp.Velocity = hrp.CFrame.LookVector * 200
	end
end

-- Dead ESP
local function deadESP()
	for _, model in pairs(workspace:GetDescendants()) do
		if model:IsA("Model") and model:FindFirstChild("Humanoid") and model.Humanoid.Health <= 0 and model:FindFirstChild("HumanoidRootPart") then
			if not model.HumanoidRootPart:FindFirstChild("DeadTag") then
				local gui = Instance.new("BillboardGui", model.HumanoidRootPart)
				gui.Name = "DeadTag"
				gui.Size = UDim2.new(0, 100, 0, 40)
				gui.AlwaysOnTop = true
				local lbl = Instance.new("TextLabel", gui)
				lbl.Size = UDim2.new(1, 0, 1, 0)
				lbl.BackgroundTransparency = 1
				lbl.Text = "💀 DEAD 💀"
				lbl.TextColor3 = Color3.new(1, 0, 0)
				lbl.TextScaled = true
			end
		end
	end
end

-- Buttons
createButton("ESP Toggle", function() esp = not esp refreshESP() end)
createButton("NPC ESP", function() npcEsp = not npcEsp refreshESP() end)
createButton("Speed Boost", speedBoost)
createButton("Jump Boost", jumpBoost)
createButton("Fly Toggle", toggleFly)
createButton("Infinite Jump", function() infJump = not infJump end)
createButton("Noclip Toggle", function() noclip = not noclip end)
createButton("TP Closest Player", tpToClosest)
createButton("Super Dash", dash)
createButton("Dead Locator", deadESP)
