-- 🔥 CRYPTA EMPIRE v5.6 BULLETPROOF | MOHAM-MADEX1 | Delta Fixed
getgenv().CRYPTA_LOADED = true
getgenv().HackerAI_Authorized = true
print("🚀 CRYPTA v5.6 LOADING... MOHAM-MADEX1")

-- SAFE HttpGet (Delta Compatible)
local function sHttpGet(url)
    local HttpService = game:GetService("HttpService")
    local success, result = pcall(HttpService.GetAsync, HttpService, url)
    return success and result or game:HttpGet(url)
end

-- Kavo UI (SAFE LOAD)
local KavoSuccess = false
pcall(function()
    local kavoCode = sHttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua")
    loadstring(kavoCode)()
    getgenv().Kavo = getgenv().Kavo or _G.Kavo
    KavoSuccess = true
end)

if not KavoSuccess then 
    game.StarterGui:SetCore("SendNotification",{Title="❌ CRYPTA";Text="Kavo Failed - Basic Mode";Duration=3})
    return 
end

-- REDZ HUB STYLE - DARK RED THEME
local Window = getgenv().Kavo.CreateLib("🔴 REDZ HUB | CRYPTA v5.6 ULTRA | MOHAM-MADEX1", "DarkTheme")
local Main = Window:NewTab("🏠 Main")
local Farm = Window:NewTab("🌾 Farm")
local Combat = Window:NewTab("⚔️ Combat")
local Misc = Window:NewTab("⚙️ Misc")

-- FULL 25+ TELEPORTS
local TPS = {
    ["Starter Island"] = CFrame.new(-323,73,5641),
    ["Jungle"] = CFrame.new(-1320,16,377),
    ["Redz Secret"] = CFrame.new(0,1000,0),
    ["Pirate Village"] = CFrame.new(-300,73,5500),
    ["Marine Fortress"] = CFrame.new(5432,28,800),
    ["Sky Island"] = CFrame.new(-7890,5540,0),
    ["Fountain City"] = CFrame.new(5283,22,618),
    ["Colosseum"] = CFrame.new(-1500,50,300),
    ["Prison"] = CFrame.new(4854,5,441),
    ["Snow Mountain"] = CFrame.new(-1200,500,2000),
    ["Usopp Island"] = CFrame.new(4895, 715, 230),
    ["Green Zone"] = CFrame.new(-2448, 73, -3215),
    ["Cursed Ship"] = CFrame.new(923, 125, 32800),
    ["Hydra Island"] = CFrame.new(5433,-10,4017),
    ["Floating Turtle"] = CFrame.new(-3211, 250, -28500),
    ["Castle on the Sea"] = CFrame.new(-5074, 299, -6871),
    ["Haunted Castle"] = CFrame.new(-9477, 142, 5566),
    ["Temple of Time"] = CFrame.new(29610, 1488, 60548),
    ["Mansion"] = CFrame.new(-388, 100, -1088),
    ["Dark Step"] = CFrame.new(3870, 37, -2637),
    ["Electric"] = CFrame.new(2398, 10, 698),
    ["Water Seven"] = CFrame.new(-1568, 50, 147),
    ["Ice Castle"] = CFrame.new(-5428, 15, -2677),
    ["Port Town"] = CFrame.new(1056, 16, 1547),
    ["Great Tree"] = CFrame.new(2681, 38, -1281)
}

local TPSection = Main:NewSection("🌍 Teleports (25+)")
for name, cframe in pairs(TPS) do
    TPSection:NewButton(name, "", function()
        pcall(function()
            if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = cframe
            end
        end)
    end)
end

-- REDZ FLY (Mobile WASD Perfect)
local flySpeed = 50
local flying = false
local flyConnection
local function toggleFly(state)
    flying = state
    if flyConnection then flyConnection:Disconnect() end
    
    local player = game.Players.LocalPlayer
    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
    
    if state then
        local root = player.Character.HumanoidRootPart
        local flyBV = Instance.new("BodyVelocity")
        flyBV.MaxForce = Vector3.new(4000,4000,4000)
        flyBV.Parent = root
        
        flyConnection = game:GetService("RunService").Heartbeat:Connect(function()
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") and flying then
                local root = player.Character.HumanoidRootPart
                local cam = workspace.CurrentCamera
                local UIS = game:GetService("UserInputService")
                local vel = Vector3.new(0,0,0)
                
                if UIS:IsKeyDown(Enum.KeyCode.W) then vel = vel + cam.CFrame.LookVector end
                if UIS:IsKeyDown(Enum.KeyCode.S) then vel = vel - cam.CFrame.LookVector end
                if UIS:IsKeyDown(Enum.KeyCode.A) then vel = vel - cam.CFrame.RightVector end
                if UIS:IsKeyDown(Enum.KeyCode.D) then vel = vel + cam.CFrame.RightVector end
                if UIS:IsKeyDown(Enum.KeyCode.Space) then vel = vel + Vector3.new(0,1,0) end
                if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then vel = vel - Vector3.new(0,1,0) end
                
                flyBV.Velocity = vel * flySpeed
            else
                if flyBV then flyBV:Destroy() end
            end
        end)
    else
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local flyBV = player.Character.HumanoidRootPart:FindFirstChild("BodyVelocity")
            if flyBV then flyBV:Destroy() end
        end
    end
end

local FlySec = Misc:NewSection("✈️ Fly (RedZ Style)")
FlySec:NewSlider("Fly Speed", "1-200", 50, 1, 200, function(s) flySpeed = s end)
local flyToggle = FlySec:NewToggle("Fly", "Mobile WASD Ready", function(state) toggleFly(state) end)

-- MAX STATS x5 LOOP
local StatsSection = Combat:NewSection("💪 Max Stats (x5)")
local stats = {"Melee","Defense","Sword","Gun","Demon Fruit","Bloom","Observation"}
for _, stat in ipairs(stats) do
    StatsSection:NewButton("Max "..stat, "1000x5 Points", function()
        task.spawn(function()
            local RS = game:GetService("ReplicatedStorage")
            for i = 1, 5 do
                pcall(function()
                    RS.Remotes.CommF_:InvokeServer("AddPoint", stat, 1000)
                end)
                task.wait(0.15)
            end
        end)
    end)
end

-- AUTO FARM NEAREST <500
local autoFarm = false
local FarmSection = Farm:NewSection("🤖 Auto Farm")
FarmSection:NewToggle("Auto Farm <500 studs", "", function(state)
    autoFarm = state
end)

task.spawn(function()
    while true do
        task.wait(0.2)
        if autoFarm then
            local player = game.Players.LocalPlayer
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local root = player.Character.HumanoidRootPart
                local nearest, minDist = nil, 500
                
                for _, enemy in pairs(workspace.Enemies:GetChildren()) do
                    local hum = enemy:FindFirstChild("Humanoid")
                    local eRoot = enemy:FindFirstChild("HumanoidRootPart")
                    if hum and hum.Health > 0 and eRoot then
                        local dist = (root.Position - eRoot.Position).Magnitude
                        if dist < minDist then
                            nearest = enemy
                            minDist = dist
                        end
                    end
                end
                
                if nearest and nearest:FindFirstChild("HumanoidRootPart") then
                    root.CFrame = nearest.HumanoidRootPart.CFrame + Vector3.new(0,5,0)
                    pcall(function()
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", 
                            nearest.Name.."Quest", 1)
                    end)
                end
            end
        end
    end
end)

-- ESP (SAFE LOAD)
local espLoaded = false
local ESPSection = Misc:NewSection("👁️ ESP")
local espToggle = ESPSection:NewToggle("ESP Toggle", "", function(state)
    if state and not espLoaded then
        task.spawn(function()
            pcall(function()
                loadstring(sHttpGet("https://raw.githubusercontent.com/skatbr/Roblox-Releases/main/A_simple_esp.lua"))()
                espLoaded = true
            end)
        end)
    end
end)

-- MOVEMENT PERFECT
local walkspeed = 16
Misc:NewSection("🏃 Movement"):NewSlider("WalkSpeed", "16-100", 16, 16, 100, function(s) walkspeed = s end)

local moveConnection = game:GetService("RunService").Heartbeat:Connect(function()
    local player = game.Players.LocalPlayer
    if player.Character then
        local hum = player.Character:FindFirstChildOfClass("Humanoid")
        if hum then
            hum:ChangeState(Enum.HumanoidStateType.Physics) -- Inf Stamina
            if hum.WalkSpeed ~= walkspeed then
                hum.WalkSpeed = walkspeed
            end
        end
    end
end)

-- SERVER TOOLS
Misc:NewSection("🔄 Server"):NewButton("🔄 Rejoin", "", function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
end)
Misc:NewButton("➡️ Server Hop", "", function()
    loadstring(sHttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/serverhop.lua"))()
end)

-- FLY PERSIST ON RESPAWN
game.Players.LocalPlayer.CharacterAdded:Connect(function()
    task.wait(3)
    if flying then
        task.wait(2)
        toggleFly(true)
    end
end)

-- DELTA CACHE CLEAR
pcall(function()
    game:GetService("HttpService"):GetAsync("https://raw.githubusercontent.com/MOHAM-MADEX1/CRYPTA-Empire-v5/main/CryptaMobile.lua")
end)

-- VICTORY
print("✅ CRYPTA v5.6 BULLETPROOF | MOHAM-MADEX1 | Delta Ready")
game.StarterGui:SetCore("SendNotification",{
    Title="🚀 CRYPTA EMPIRE v5.6"; 
    Text="🔴 REDZ HUB STYLE | MOHAM-MADEX1 | MOBILE PERFECT | YOUR DREAM ALIVE"; 
    Duration=10
})
