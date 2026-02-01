-- #################################
-- ⚡ DARK X BLACKHOLE v7.0 - ULTIMATE GUI
-- 🔥 ARSENAL + BLOX FRUITS | FULL CONTROL
-- 🔒 KEY: DARKHOLE-4000-2000
-- #################################

if not game:IsLoaded() then game.Loaded:Wait() end
local Player = game:GetService("Players").LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- ================================
-- LOAD OCEAN UI (Lightweight + Drag)
-- ================================
local Ocean = loadstring(game:HttpGet("https://raw.githubusercontent.com/ElPumpo/Ocean-Library/main/Source.lua"))()
local Window = Ocean:CreateWindow({
    Name = "⚡ DARK X BLACKHOLE v7.0",
    Theme = "Dark",
    Size = UDim2.new(0, 500, 0, 400),
    Position = UDim2.new(0.5, -250, 0.5, -200) -- Center screen
})

-- ================================
-- GUI CONTROL BUTTONS (Show/Hide/Close/Minimize)
-- ================================
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 30)
TopBar.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
TopBar.BorderSizePixel = 0
TopBar.Parent = Window.Main

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -30, 0, 0)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 50, 50)
CloseBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
CloseBtn.BorderSizePixel = 0
CloseBtn.Parent = TopBar
CloseBtn.MouseButton1Click:Connect(function()
    Window.Main.Visible = false
    Ocean:Notify("GUI Hidden", "Press [RightShift] to show again", 3)
end)

local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 30, 0, 30)
MinBtn.Position = UDim2.new(1, -60, 0, 0)
MinBtn.Text = "-"
MinBtn.TextColor3 = Color3.fromRGB(255, 255, 100)
MinBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
MinBtn.BorderSizePixel = 0
MinBtn.Parent = TopBar
MinBtn.MouseButton1Click:Connect(function()
    Window.Main.Size = UDim2.new(0, 500, 0, 40) -- Minimize to top bar only
end)

local ShowBtn = Instance.new("TextButton")
ShowBtn.Size = UDim2.new(0, 80, 0, 30)
ShowBtn.Position = UDim2.new(0, 10, 0, 0)
ShowBtn.Text = "SHOW GUI"
ShowBtn.TextColor3 = Color3.fromRGB(100, 255, 100)
ShowBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
ShowBtn.BorderSizePixel = 0
ShowBtn.Parent = TopBar
ShowBtn.MouseButton1Click:Connect(function()
    Window.Main.Size = UDim2.new(0, 500, 0, 400) -- Restore full size
end)

-- Drag functionality
local dragging, dragInput, dragStart, startPos
TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = Window.Main.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)
TopBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)
UIS.InputChanged:Connect(function(input)
    if dragging and input == dragInput then
        local delta = input.Position - dragStart
        Window.Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Toggle GUI with RightShift
UIS.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.RightShift then
        Window.Main.Visible = not Window.Main.Visible
    end
end)

-- ================================
-- KEY SYSTEM TAB
-- ================================
local KeyTab = Window:CreateTab({Name = "🔐 KEY SYSTEM"})
local KeySection = KeyTab:CreateSection({Name = "MASUKIN KEY CUY", Side = "Left"})

local KeyBox = KeySection:CreateInput({
    Name = "KEY INPUT",
    Placeholder = "DARKHOLE-4000-2000",
    Callback = function(key)
        if key == "DARKHOLE-4000-2000" then
            getgenv().DARKX_ACCESS = "FULL"
            Ocean:Notify("KEY VALID", "All Features Unlocked!", 5)
        else
            Player:Kick("❌ KEY SALAH | Jangan Asal Cuy!")
        end
    end
})

-- ================================
-- ARSENAL FEATURES TAB
-- ================================
local ArsenalTab = Window:CreateTab({Name = "🔫 ARSENAL OP"})
local AimSection = ArsenalTab:CreateSection({Name = "AIMBOT PRO", Side = "Left"})

-- Aimbot dengan FOV Circle Visual
local AimToggle = AimSection:CreateToggle({
    Name = "🎯 AIMBOT SILENT",
    Callback = function(state)
        getgenv().AimbotActive = state
        if state then
            local Circle = Drawing.new("Circle")
            Circle.Visible = true
            Circle.Radius = 120
            Circle.Color = Color3.fromRGB(255, 0, 0)
            Circle.Thickness = 2
            Circle.Position = Vector2.new(UIS:GetMouseLocation().X, UIS:GetMouseLocation().Y)

            RunService.RenderStepped:Connect(function()
                if not getgenv().AimbotActive then Circle:Remove() return end
                local closest, dist = nil, math.huge
                for _, target in pairs(game:GetService("Players"):GetPlayers()) do
                    if target ~= Player and target.Character and target.Character:FindFirstChild("Head") then
                        local headPos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(target.Character.Head.Position)
                        if onScreen then
                            local mousePos = UIS:GetMouseLocation()
                            local magnitude = (Vector2.new(headPos.X, headPos.Y) - mousePos).Magnitude
                            if magnitude < dist and magnitude < Circle.Radius then
                                dist = magnitude
                                closest = target.Character.Head
                            end
                        end
                    end
                end
                if closest then
                    workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, closest.Position)
                end
            end)
        end
    end
})

AimSection:CreateSlider({
    Name = "AIMBOT FOV",
    Min = 50,
    Max = 300,
    Default = 120,
    Callback = function(val)
        -- FOV slider logic here
    end
})

-- ================================
-- ADVANCED FLY SYSTEM (FULL CONTROL)
-- ================================
local FlySection = ArsenalTab:CreateSection({Name = "🚀 FLY SYSTEM (FULL CONTROL)", Side = "Right"})

local FlyToggle = FlySection:CreateToggle({
    Name = "ACTIVATE FLY",
    Callback = function(state)
        getgenv().Flying = state
        if state then
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.Velocity = Vector3.new(0, 0, 0)
            bodyVelocity.MaxForce = Vector3.new(1e9, 1e9, 1e9)
            bodyVelocity.Parent = Player.Character:WaitForChild("HumanoidRootPart")

            -- Fly control loop
            local flyConnection
            flyConnection = RunService.Heartbeat:Connect(function()
                if not getgenv().Flying or not Player.Character then
                    bodyVelocity:Destroy()
                    flyConnection:Disconnect()
                    return
                end

                local cam = workspace.CurrentCamera
                local moveDir = Vector3.new(0, 0, 0)
                local speed = 100

                -- WASD Movement
                if UIS:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + cam.CFrame.LookVector end
                if UIS:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - cam.CFrame.LookVector end
                if UIS:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - cam.CFrame.RightVector end
                if UIS:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + cam.CFrame.RightVector end

                -- Up/Down (Space/Ctrl)
                if UIS:IsKeyDown(Enum.KeyCode.Space) then moveDir = moveDir + Vector3.new(0, 1, 0) end
                if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then moveDir = moveDir + Vector3.new(0, -1, 0) end

                if moveDir.Magnitude > 0 then
                    bodyVelocity.Velocity = moveDir.Unit * speed
                else
                    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
                end
            end)

            Ocean:Notify("FLY ACTIVATED", "WASD + Space/Ctrl to move", 4)
        else
            Ocean:Notify("FLY DEACTIVATED", "", 2)
        end
    end
})

FlySection:CreateSlider({
    Name = "FLY SPEED",
    Min = 50,
    Max = 300,
    Default = 100,
    Callback = function(val)
        getgenv().FlySpeed = val
    end
})

-- ================================
-- BLOX FRUITS AUTO FARM TAB
-- ================================
local BloxTab = Window:CreateTab({Name = "🍊 BLOX FRUITS"})
local FarmSection = BloxTab:CreateSection({Name = "🤖 AUTO FARM SYSTEM", Side = "Left"})

FarmSection:CreateToggle({
    Name = "AUTO FARM MOBS",
    Callback = function(state)
        getgenv().AutoFarm = state
        while getgenv().AutoFarm do
            task.wait(0.5)
            -- Auto farm logic here
        end
    end
})

-- ================================
-- UTILITIES TAB
-- ================================
local UtilTab = Window:CreateTab({Name = "⚙️ UTILITIES"})
local VisualSection = UtilTab:CreateSection({Name = "👁️ VISUAL MODS", Side = "Left"})

VisualSection:CreateToggle({
    Name = "PLAYER ESP",
    Callback = function(state)
        -- ESP logic here
    end
})

-- ================================
-- INITIALIZE
-- ================================
Ocean:Notify("⚡ DARK X BLACKHOLE v7.0 LOADED", "GUI Controls Active | Use RightShift to hide/show", 6)
print([[
=======================================
   DARK X BLACKHOLE v7.0 INJECTED
   GUI Controls: [X] Close | [-] Minimize | [SHOW] Restore
   Fly System: WASD + Space/Ctrl
   Toggle GUI: RightShift
=======================================
]])
