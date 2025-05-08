--[[🔥 DEADRAILS ULTIMATE MOD MENU 🔥]]--
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")
local camera = workspace.CurrentCamera

local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "DeadRailsGodMenu"

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 250, 0, 600)
MainFrame.Position = UDim2.new(0.03, 0, 0.25, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0

local function createButton(name, y, func)
	local btn = Instance.new("TextButton", MainFrame)
	btn.Size = UDim2.new(1, -10, 0, 40)
	btn.Position = UDim2.new(0, 5, 0, y)
	btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	btn.TextColor3 = Color3.new(1,1,1)
	btn.Font = Enum.Font.SourceSansBold
	btn.TextSize = 16
	btn.Text = name
	btn.MouseButton1Click:Connect(func)
end

-- Features
local espEnabled, itemEspEnabled, flyEnabled, infJumpEnabled, noclipEnabled, silentAimEnabled, killAuraEnabled = false, false, false, false, false, false, false

-- ESP
local function toggleESP()
	espEnabled = not espEnabled
	for _, v in pairs(game.Players:GetPlayers()) do
		if v ~= player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
			if espEnabled then
				local billboard = Instance.new("BillboardGui", v.Character.HumanoidRootPart)
				billboard.Name = "ESPTag"
				billboard.Size = UDim2.new(0, 100, 0, 40)
				billboard.AlwaysOnTop = true
				local tag = Instance.new("TextLabel", billboard)
				tag.Size = UDim2.new(1, 0, 1, 0)
				tag.BackgroundTransparency = 1
				tag.Text = v.Name
				tag.TextColor3 = Color3.fromRGB(255, 0, 255)
				tag.TextScaled = true
			else
				if v.Character.HumanoidRootPart:FindFirstChild("ESPTag") then
					v.Character.HumanoidRootPart.ESPTag:Destroy()
				end
			end
		end
	end
end

-- Speed / Jump
local function speedBoost() humanoid.WalkSpeed = 60 end
local function jumpBoost() humanoid.JumpPower = 120 end

-- Fly
local function toggleFly()
	flyEnabled = not flyEnabled
	local hrp = char:FindFirstChild("HumanoidRootPart")
	if flyEnabled then
		local bv = Instance.new("BodyVelocity")
		bv.Name = "FlyVelocity"
		bv.Velocity = Vector3.new(0, 0, 0)
		bv.MaxForce = Vector3.new(0, math.huge, 0)
		bv.Parent = hrp
		game:GetService("RunService").Heartbeat:Connect(function()
			if flyEnabled and bv and bv.Parent then
				bv.Velocity = Vector3.new(0, 50, 0)
			end
		end)
	else
		if hrp:FindFirstChild("FlyVelocity") then hrp.FlyVelocity:Destroy() end
	end
end

-- Kill Aura
local function toggleKillAura()
	killAuraEnabled = not killAuraEnabled
	if killAuraEnabled then
		spawn(function()
			while killAuraEnabled do
				for _, v in pairs(game.Players:GetPlayers()) do
					if v ~= player and v.Character and v.Character:FindFirstChild("Humanoid") then
						local dist = (v.Character.HumanoidRootPart.Position - char.HumanoidRootPart.Position).Magnitude
						if dist < 10 then
							local hum = v.Character:FindFirstChild("Humanoid")
							if hum then
								hum:TakeDamage(50)
							end
						end
					end
				end
				wait(0.5)
			end
		end)
	end
end

-- TP to Player
local function tpToClosest()
	local closest, dist = nil, math.huge
	for _, v in pairs(game.Players:GetPlayers()) do
		if v ~= player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
			local d = (v.Character.HumanoidRootPart.Position - char.HumanoidRootPart.Position).Magnitude
			if d < dist then
				closest, dist = v, d
			end
		end
	end
	if closest then char:SetPrimaryPartCFrame(closest.Character.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0)) end
end

-- Silent Aim
local function toggleSilentAim()
	silentAimEnabled = not silentAimEnabled
	game:GetService("RunService").Heartbeat:Connect(function()
		if silentAimEnabled then
			local closest, dist = nil, math.huge
			for _, v in pairs(game.Players:GetPlayers()) do
				if v ~= player and v.Character and v.Character:FindFirstChild("Head") then
					local screenPos, visible = camera:WorldToViewportPoint(v.Character.Head.Position)
					local dx = screenPos.X - mouse.X
					local dy = screenPos.Y - mouse.Y
					local mag = math.sqrt(dx * dx + dy * dy)
					if mag < dist then
						closest, dist = v, mag
					end
				end
			end
			if closest and closest.Character and closest.Character:FindFirstChild("Head") then
				mouse.TargetFilter = workspace
				mouse.Hit = closest.Character.Head.CFrame
			end
		end
	end)
end

-- Infinite Jump
game:GetService("UserInputService").JumpRequest:Connect(function()
	if infJumpEnabled then
		char:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
	end
end)

-- Noclip
local function toggleNoclip()
	noclipEnabled = not noclipEnabled
	game:GetService("RunService").Stepped:Connect(function()
		if noclipEnabled then
			for _, part in pairs(char:GetDescendants()) do
				if part:IsA("BasePart") and part.CanCollide then
					part.CanCollide = false
				end
			end
		end
	end)
end

-- Super Dash
local function superDash()
	local hrp = char:FindFirstChild("HumanoidRootPart")
	if hrp then
		hrp.Velocity = hrp.CFrame.lookVector * 200
	end
end

-- Item ESP
local function toggleItemESP()
	itemEspEnabled = not itemEspEnabled
	for _, v in pairs(workspace:GetDescendants()) do
		if v:IsA("Tool") and not v:FindFirstChild("ESP") then
			if itemEspEnabled then
				local tag = Instance.new("BillboardGui", v)
				tag.Name = "ESP"
				tag.Size = UDim2.new(0, 100, 0, 40)
				tag.AlwaysOnTop = true
				local label = Instance.new("TextLabel", tag)
				label.Size = UDim2.new(1, 0, 1, 0)
				label.BackgroundTransparency = 1
				label.Text = v.Name
				label.TextColor3 = Color3.new(0, 1, 0)
				label.TextScaled = true
			else
				if v:FindFirstChild("ESP") then v.ESP:Destroy() end
			end
		end
	end
end

-- Dead ESP
local function deadESP()
	for _, v in pairs(workspace:GetDescendants()) do
		if v:IsA("Model") and v:FindFirstChild("Humanoid") and v.Humanoid.Health <= 0 and not v:FindFirstChild("DeadTag") then
			local tag = Instance.new("BillboardGui", v:FindFirstChild("HumanoidRootPart") or v:FindFirstChildWhichIsA("BasePart"))
			tag.Name = "DeadTag"
			tag.Size = UDim2.new(0, 100, 0, 40)
			tag.AlwaysOnTop = true
			local label = Instance.new("TextLabel", tag)
			label.Size = UDim2.new(1, 0, 1, 0)
			label.BackgroundTransparency = 1
			label.Text = "💀 DEAD 💀"
			label.TextColor3 = Color3.new(1, 0, 0)
			label.TextScaled = true
		end
	end
end

-- Buttons
createButton("ESP Toggle", 10, toggleESP)
createButton("Speed Boost", 60, speedBoost)
createButton("Jump Boost", 110, jumpBoost)
createButton("Fly Toggle", 160, toggleFly)
createButton("Kill Aura", 210, toggleKillAura)
createButton("TP to Closest", 260, tpToClosest)
createButton("Silent Aim", 310, toggleSilentAim)
createButton("Infinite Jump", 360, function() infJumpEnabled = not infJumpEnabled end)
createButton("Noclip", 410, toggleNoclip)
createButton("Super Dash", 460, superDash)
createButton("Item ESP", 510, toggleItemESP)
createButton("Dead Locator", 560, deadESP)
