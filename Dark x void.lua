-- #################################
-- ⚡ DARK X BLACKHOLE MULTI-HACK v6.9
-- 🔥 ARSENAL + BLOX FRUITS ALL-IN-ONE
-- 🔒 SYSTEM KEY: DARKHOLE-4000-2000
-- #################################

if not game:IsLoaded() then game.Loaded:Wait() end
if not cloneref then getgenv().cloneref = function(ref) return ref end end

-- Load Kavo UI Engine (Mirror Anti-Ban 2026)
local Success, KavoLib = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
end)
if not Success then
    game.Players.LocalPlayer:Kick("[DARK_X] UI Engine Failed | Rejoin & Try Again")
    return
end

local Window = KavoLib.CreateLib("⚡ DARK X BLACKHOLE v6.9", "DarkTheme")

-- ================================
-- SECTION 1: CDK KEY VERIFICATION
-- ================================
local KeyTab = Window:NewTab("🔐 KEY SYSTEM")
local KeySection = KeyTab:NewSection("MASUKIN KEY CUY | Format: DARKHOLE-XXXX-XXXX")

local ValidKeys = {
    ["DARKHOLE-4000-2000"] = {Access = "FULL", Expire = os.time() + 86400},
    ["DARKHOLE-TRIAL-2026"] = {Access = "TRIAL", Expire = os.time() + 7200},
}

local KeyInput = KeySection:NewTextBox("KEY INPUT", "Contoh: DARKHOLE-4000-2000", function(InputKey)
    if ValidKeys[InputKey] then
        if os.time() < ValidKeys[InputKey].Expire then
            getgenv().DARKX_ACCESS = ValidKeys[InputKey].Access
            getgenv().KEY_EXPIRE = ValidKeys[InputKey].Expire
            KeySection:NewLabel("✅ KEY VALID | Akses: "..ValidKeys[InputKey].Access)
            KeySection:NewLabel("⏰ Expire: "..os.date("%H:%M %d/%m", ValidKeys[InputKey].Expire))
            task.wait(1)
            KeySection:NewButton("🔄 LOAD MAIN MENU", "Klik Setelah Key Valid", function()
                loadstring(game:HttpGet("https://pastebin.com/raw/YourMainScriptHere"))() -- Ganti dengan link script utama lu
            end)
        else
            game.Players.LocalPlayer:Kick("⛔ KEY EXPIRED | Beli Key Baru!")
        end
    else
        game.Players.LocalPlayer:Kick("⛔ KEY INVALID | Jangan Asal Cuy!")
    end
end)

-- ================================
-- SECTION 2: ARSENAL FEATURES
-- ================================
local ArsenalTab = Window:NewTab("🔫 ARSENAL OP")
local AimbotSec = ArsenalTab:NewSection("AIMBOT GILA [FOV + PREDICT]")

-- Advanced Aimbot with FOV Circle
getgenv().AimbotSettings = {
    FOV = 120,
    Smoothness = 0.4,
    Predict = 0.12,
    TargetPart = "Head"
}

AimbotSec:NewToggle("🔫 AIMBOT SILENT", "Auto Lock Head", function(State)
    getgenv().AimbotActive = State
    if State then
        local RunService = game:GetService("RunService")
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local Camera = workspace.CurrentCamera
        
        RunService.RenderStepped:Connect(function()
            if not getgenv().AimbotActive then return end
            local ClosestTarget, ClosestDistance = nil, math.huge
            for _, Player in pairs(Players:GetPlayers()) do
                if Player ~= LocalPlayer and Player.Character and Player.Character:FindFirstChild("Head") then
                    local Char = Player.Character
                    local HeadPos = Char.Head.Position
                    local ScreenPos, OnScreen = Camera:WorldToViewportPoint(HeadPos)
                    local Distance = (Vector2.new(ScreenPos.X, ScreenPos.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
                    
                    if OnScreen and Distance < ClosestDistance and Distance < getgenv().AimbotSettings.FOV then
                        ClosestDistance = Distance
                        ClosestTarget = Char
                    end
                end
            end
            if ClosestTarget then
                local Prediction = ClosestTarget[getgenv().AimbotSettings.TargetPart].Velocity * getgenv().AimbotSettings.Predict
                Camera.CFrame = CFrame.new(Camera.CFrame.Position, ClosestTarget[getgenv().AimbotSettings.TargetPart].Position + Prediction)
            end
        end)
    end
end)

AimbotSec:NewSlider("🎯 AIMBOT FOV", "Radius Lock", 500, 50, function(Value)
    getgenv().AimbotSettings.FOV = Value
end)

-- Fly System
local MovementSec = ArsenalTab:NewSection("MOVEMENT HACK")
MovementSec:NewToggle("🚀 FLY NGEBUT", "WSAD + Space / Ctrl", function(State)
    getgenv().FlyEnabled = State
    if State then
        local BodyVelocity = Instance.new("BodyVelocity")
        BodyVelocity.Velocity = Vector3.new(0,0,0)
        BodyVelocity.MaxForce = Vector3.new(1e9,1e9,1e9)
        BodyVelocity.Parent = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
        
        local UserInput = game:GetService("UserInputService")
        UserInput.InputBegan:Connect(function(Input)
            if not getgenv().FlyEnabled then return end
            if Input.KeyCode == Enum.KeyCode.Space then
                BodyVelocity.Velocity = Vector3.new(0, 100, 0)
            elseif Input.KeyCode == Enum.KeyCode.LeftControl then
                BodyVelocity.Velocity = Vector3.new(0, -100, 0)
            end
        end)
        
        game:GetService("RunService").Heartbeat:Connect(function()
            if not getgenv().FlyEnabled then return end
            local Camera = workspace.CurrentCamera
            BodyVelocity.Velocity = Camera.CFrame.LookVector * 80
        end)
    else
        for _, Obj in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
            if Obj:IsA("BodyVelocity") then
                Obj:Destroy()
            end
        end
    end
end)

-- ================================
-- SECTION 3: BLOX FRUITS FEATURES
-- ================================
local BloxTab = Window:NewTab("🍊 BLOX FRUITS")
local AutoFarmSec = BloxTab:NewSection("AUTO FARM & CHEAT")

-- Auto Farm Mob dengan Aimbot
AutoFarmSec:NewToggle("🤖 AUTO FARM MOBS", "Auto Kill + Collect Drops", function(State)
    getgenv().AutoFarm = State
    if State then
        spawn(function()
            while getgenv().AutoFarm and task.wait(0.3) do
                pcall(function()
                    local ClosestMob, MinDistance = nil, math.huge
                    for _, Mob in pairs(workspace.Enemies:GetChildren()) do
                        if Mob:FindFirstChild("Humanoid") and Mob.Humanoid.Health > 0 then
                            local Distance = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Mob.HumanoidRootPart.Position).Magnitude
                            if Distance < MinDistance and Distance < 500 then
                                MinDistance = Distance
                                ClosestMob = Mob
                            end
                        end
                    end
                    if ClosestMob then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = ClosestMob.HumanoidRootPart.CFrame * CFrame.new(0, 0, 5)
                        game:GetService("ReplicatedStorage").Remotes.Combat:FireServer()
                    end
                end)
            end
        end)
    end
end)

-- Auto Collect Fruits
AutoFarmSec:NewToggle("🍎 AUTO COLLECT FRUITS", "Teleport ke Semua Fruit", function(State)
    getgenv().AutoFruit = State
    if State then
        spawn(function()
            while getgenv().AutoFruit and task.wait(1) do
                pcall(function()
                    for _, Fruit in pairs(workspace:GetChildren()) do
                        if Fruit.Name:find("Fruit") and Fruit:IsA("Part") then
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Fruit.CFrame
                            task.wait(0.2)
                        end
                    end
                end)
            end
        end)
    end
end)

-- Redeem CDK Script (HANYA untuk kode yang sudah ada di database)
local CDKSec = BloxTab:NewSection("Redeem CDK (Script Auto Input)")
CDKSec:NewTextBox("MASUKIN CDK YANG UDAH ADA", "Contoh: KITT_RESET", function(CDK_Input)
    if game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Codes") then
        local Remote = game:GetService("ReplicatedStorage").Remotes.RedeemCode
        Remote:InvokeServer(CDK_Input)
        KavoLib:Notify("✅ CDK REDEEMED", "Check Inventory!", 5)
    else
        KavoLib:Notify("❌ GUI CODES NOT FOUND", "Open Code Menu First", 5)
    end
end)

-- ================================
-- SECTION 4: UTILITIES
-- ================================
local UtilTab = Window:NewTab("⚙️ UTILITIES")
local VisualSec = UtilTab:NewSection("VISUAL & ESP")

VisualSec:NewToggle("👁️ ESP PLAYER", "See Through Walls", function(State)
    getgenv().ESPEnabled = State
    if State then
        for _, Player in pairs(game.Players:GetPlayers()) do
            if Player ~= game.Players.LocalPlayer then
                local Highlight = Instance.new("Highlight")
                Highlight.FillColor = Color3.fromRGB(255, 0, 0)
                Highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                Highlight.Parent = Player.Character or Player.CharacterAdded:Wait()
            end
        end
    else
        for _, Obj in pairs(workspace:GetChildren()) do
            if Obj:IsA("Highlight") then
                Obj:Destroy()
            end
        end
    end
end)

-- ================================
-- EXECUTION & LOAD
-- ================================
KavoLib:Notify("⚡ DARK X BLACKHOLE LOADED", "Key System Active | Get Key First!", 10)
print([[
=======================================
   DARK X BLACKHOLE v6.9 INJECTED
   Access Level: FULL
   Game Detected: ]]..game.PlaceId..[[
   Key System: ACTIVE
=======================================
]])
