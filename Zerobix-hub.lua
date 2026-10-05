-- =================================================================
-- ✨ ZEROBIX GODLY HUB v8.0 (BAGIAN 1: TOTAL CONFIG & FPS BOOST) ✨
-- =================================================================

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")

-- Proteksi Duplikasi UI
pcall(function()
    local search = PlayerGui:FindFirstChild("Zerobix_Gacor_Hub_Official") or game:GetService("CoreGui"):FindFirstChild("Zerobix_Gacor_Hub_Official")
    if search then search:Destroy() end
end)

-- 🔥 ENGINE FPS BOOST SUPER ENTENG UNTUK HP KENTANG (RAM SAVER)
pcall(function()
    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 9e9
    for _, effect in pairs(Lighting:GetChildren()) do
        if effect:IsA("BlurEffect") or effect:IsA("SunRaysEffect") or effect:IsA("ColorCorrectionEffect") or effect:IsA("BloomEffect") then
            effect:Destroy()
        end
    end
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("BasePart") or obj:IsA("MeshPart") or obj:IsA("Part") then
            obj.Material = Enum.Material.SmoothPlastic
            obj.Reflectance = 0
            obj.CastShadow = false
        elseif obj:IsA("Decal") or obj:IsA("Texture") then
            obj:Destroy()
        elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Sparkles") then
            obj.Enabled = false
        end
    end
end)

-- 🔍 DYNAMIC REMOTE SCANNER (Anti-Update)
local GameRemotes = {}
local function ScanRemotes()
    for _, item in pairs(ReplicatedStorage:GetDescendants()) do
        if item:IsA("RemoteEvent") then
            local nameLower = item.Name:lower()
            if nameLower:find("egg") or nameLower:find("collect") or nameLower:find("steal") then
                GameRemotes["Egg"] = item
            elseif nameLower:find("tread") or nameLower:find("train") or nameLower:find("gym") then
                GameRemotes["Train"] = item
            elseif nameLower:find("upgrade") or nameLower:find("buy") then
                GameRemotes["Upgrade"] = item
            elseif nameLower:find("pet") or nameLower:find("equip") then
                GameRemotes["Pet"] = item
            end
        end
    end
end
ScanRemotes()

-- Data Kelangkaan & Biome Asli Game
getgenv().EggRarities = {
    {Name = "Divine", Color = Color3.fromRGB(255, 0, 127), Rank = 1},
    {Name = "Eternal", Color = Color3.fromRGB(255, 69, 0), Rank = 2},
    {Name = "Secret", Color = Color3.fromRGB(139, 0, 139), Rank = 3},
    {Name = "Cosmic", Color = Color3.fromRGB(0, 255, 255), Rank = 4},
    {Name = "Mythic", Color = Color3.fromRGB(255, 0, 255), Rank = 5},
    {Name = "Legendary", Color = Color3.fromRGB(255, 215, 0), Rank = 6}
}

getgenv().BiomesList = {"All Map", "Forest", "Lake", "Desert", "Jungle", "Snow", "Volcano", "Abyss Ocean", "Prehistoric", "Cosmic", "Cherry Blossom", "Titan Temple", "Angels and Demons"}
getgenv().FloorList = {"Legendary", "Mythic", "Cosmic", "Secret", "Eternal", "Divine"}

-- Pengaturan Awal Hub
getgenv().AutoSteal = false
getgenv().AutoTrain = false
getgenv().AutoUpgradeAll = false
getgenv().AutoHatch = false
getgenv().AutoEquip = false
getgenv().ActiveBiome = "All Map"
getgenv().RarityFloorIndex = 6
getgenv().PriorityTarget = nil
-- =================================================================
-- ✨ ZEROBIX GODLY HUB v8.0 (BAGIAN 2: FILTERED STEAL LOOPS) ✨
-- =================================================================

task.spawn(function()
    while task.wait(0.03) do -- Delay super ngebut & gacor
        pcall(function()
            local remote = GameRemotes["Egg"] or ReplicatedStorage:FindFirstChild("EggEvent")
            if remote then
                -- Opsi 1: Tombol bintang prioritas panel kanan ditekan
                if getgenv().PriorityTarget and getgenv().PriorityTarget.Parent then
                    remote:FireServer("Collect", getgenv().PriorityTarget)
                    remote:FireServer("Steal", getgenv().PriorityTarget)
                -- Opsi 2: Auto Steal Global Aktif (Nyedot berdasarkan Filter Biome & Rarity)
                elseif getgenv().AutoSteal then
                    for _, obj in pairs(Workspace:GetDescendants()) do
                        if obj:IsA("Model") and (obj.Name:lower():find("egg") or obj:FindFirstChild("TouchTransmitter")) then
                            local nameLower = obj.Name:lower()
                            local currentBiomeLower = getgenv().ActiveBiome:lower()
                            
                            -- A. Cek kecocokan wilayah / Biome
                            local isInSelectedBiome = obj:FindFirstAncestor(getgenv().ActiveBiome) or nameLower:find(currentBiomeLower)
                            if currentBiomeLower == "all map" or isInSelectedBiome then
                                
                                -- B. Cek kecocokan Rarity Floor Index
                                for _, rarity in ipairs(getgenv().EggRarities) do
                                    if nameLower:find(rarity.Name:lower()) then
                                        if rarity.Rank <= getgenv().RarityFloorIndex then
                                            remote:FireServer("Collect", obj)
                                            remote:FireServer("Steal", obj)
                                        end
                                        break
                                    end
                                end
                                
                            end
                        end
                    end
                end
            else
                ScanRemotes()
            end
        end)
    end
end)

-- LOOP TRAINING GYM, UPGRADE, HATCH, & EQUIP PET
task.spawn(function()
    while task.wait(0.2) do
        pcall(function()
            if getgenv().AutoTrain and GameRemotes["Train"] then GameRemotes["Train"]:FireServer("Train") end
            if getgenv().AutoUpgradeAll and GameRemotes["Upgrade"] then 
                GameRemotes["Upgrade"]:FireServer("Treadmill") 
                GameRemotes["Upgrade"]:FireServer("Trail") 
            end
        end)
    end
end)

task.spawn(function()
    while task.wait(0.4) do
        pcall(function()
            if getgenv().AutoHatch and GameRemotes["Egg"] then GameRemotes["Egg"]:FireServer("HatchAll") end
            if getgenv().AutoEquip and GameRemotes["Pet"] then GameRemotes["Pet"]:FireServer("EquipBest") end
        end)
    end
end)
-- =================================================================
-- ✨ ZEROBIX GODLY HUB v8.0 (BAGIAN 3: ADVANCED DUAL GUI) ✨
-- =================================================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Zerobix_Gacor_Hub_Official"
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false

-- 👑 1. Tombol Ikon Mahkota (Menu Utama) -> Bisa digeser bebas
local CrownIcon = Instance.new("TextButton")
CrownIcon.Name = "CrownIcon"
CrownIcon.Parent = ScreenGui
CrownIcon.Position = UDim2.new(0.05, 0, 0.15, 0)
CrownIcon.Size = UDim2.new(0, 55, 0, 55)
CrownIcon.Text = "👑"
CrownIcon.TextSize = 32
CrownIcon.BackgroundColor3 = Color3.fromRGB(15, 10, 25)
CrownIcon.TextColor3 = Color3.fromRGB(255, 215, 0)
CrownIcon.Active = true
CrownIcon.Draggable = true
Instance.new("UICorner", CrownIcon).CornerRadius = UDim.new(1, 0)
Instance.new("UIStroke", CrownIcon).Color = Color3.fromRGB(255, 215, 0)

-- 🎯 2. Tombol Ikon Panel (Steal Panel) -> Diam di tempat di atas tombol egg bawaan game kanan
local StealIcon = Instance.new("TextButton")
StealIcon.Name = "StealIcon"
StealIcon.Parent = ScreenGui
StealIcon.AnchorPoint = Vector2.new(1, 0)
StealIcon.Position = UDim2.new(0.95, 0, 0.28, 0) 
StealIcon.Size = UDim2.new(0, 50, 0, 50)
StealIcon.Text = "🔮"
StealIcon.TextSize = 26
StealIcon.BackgroundColor3 = Color3.fromRGB(20, 10, 35)
StealIcon.TextColor3 = Color3.fromRGB(186, 85, 211)
StealIcon.Active = true
StealIcon.Draggable = false -- Terkunci rapat
Instance.new("UICorner", StealIcon).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", StealIcon).Color = Color3.fromRGB(138, 43, 226)

-- 📜 FRAME WINDOW: MENU UTAMA (Menampung Toggle Otomasi, Pilihan Biome & Rarity)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(12, 8, 22)
MainFrame.Size = UDim2.new(0, 260, 0, 390)
MainFrame.Position = UDim2.new(0.15, 0, 0.22, 0)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = false
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)
local StrokeMain = Instance.new("UIStroke", MainFrame)
StrokeMain.Color = Color3.fromRGB(255, 215, 0)

local MainLayout = Instance.new("UIListLayout", MainFrame)
MainLayout.Padding = UDim.new(0, 7)
MainLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local MainTitle = Instance.new("TextLabel")
MainTitle.Size = UDim2.new(0.9, 0, 0, 35)
MainTitle.Text = "👑 ZEROBIX MAIN MENU 👑"
MainTitle.TextColor3 = Color3.fromRGB(255, 215, 0)
MainTitle.Font = Enum.Font.SourceSansBold
MainTitle.TextSize = 14
MainTitle.BackgroundTransparency = 1
MainTitle.Parent = MainFrame

-- 📜 FRAME WINDOW: STEAL PANEL LIST (Di kanan samping tombol '🔮')
local StealFrame = Instance.new("Frame")
StealFrame.Name = "StealFrame"
StealFrame.Parent = ScreenGui
StealFrame.BackgroundColor3 = Color3.fromRGB(12, 8, 22)
StealFrame.Size = UDim2.new(0, 320, 0, 380)
StealFrame.AnchorPoint = Vector2.new(1, 0)
StealFrame.Position = UDim2.new(0.93, -10, 0.28, 0)
StealFrame.Active = true
StealFrame.Draggable = true
StealFrame.Visible = false
Instance.new("UICorner", StealFrame).CornerRadius = UDim.new(0, 10)
local StrokeSteal = Instance.new("UIStroke", StealFrame)
StrokeSteal.Color = Color3.fromRGB(138, 43, 226)
-- =================================================================
-- ✨ ZEROBIX GODLY HUB v8.0 (BAGIAN 4: DROP-MENUS & FINAL CONTROLS) ✨
-- =================================================================

-- 1. TOMBOL KLIK SIKLUS DAFTAR WILAYAH (BIOME DROPDOWN SYSTEM)
local BiomeMenu = Instance.new("TextButton")
BiomeMenu.Size = UDim2.new(0.88, 0, 0, 36)
BiomeMenu.Text = "🗺️ Biome: All Map ↓"
BiomeMenu.TextColor3 = Color3.fromRGB(255, 255, 255)
BiomeMenu.BackgroundColor3 = Color3.fromRGB(38, 22, 60)
BiomeMenu.Font = Enum.Font.SourceSansBold
BiomeMenu.TextSize = 13
BiomeMenu.Parent = MainFrame
Instance.new("UICorner", BiomeMenu).CornerRadius = UDim.new(0, 6)
Instance.new("UIStroke", BiomeMenu).Color = Color3.fromRGB(138, 43, 226)

local curBiomeIdx = 1
BiomeMenu.MouseButton1Click:Connect(function()
    curBiomeIdx = curBiomeIdx + 1
    if curBiomeIdx > #getgenv().BiomesList then curBiomeIdx = 1 end
    getgenv().ActiveBiome = getgenv().BiomesList[curBiomeIdx]
    BiomeMenu.Text = "🗺️ Biome: " .. getgenv().ActiveBiome .. " ↓"
end)

-- 2. TOMBOL KLIK SIKLUS AMBANG KELANGKAAN (RARITY DROPDOWN SYSTEM)
local RarityMenu = Instance.new("TextButton")
RarityMenu.Size = UDim2.new(0.88, 0, 0, 36)
RarityMenu.Text = "🥚 Floor: Legendary ↓"
RarityMenu.TextColor3 = Color3.fromRGB(255, 255, 255)
RarityMenu.BackgroundColor3 = Color3.fromRGB(38, 22, 60)
RarityMenu.Font = Enum.Font.SourceSansBold
RarityMenu.TextSize = 13
RarityMenu.Parent = MainFrame
Instance.new("UICorner", RarityMenu).CornerRadius = UDim.new(0, 6)
Instance.new("UIStroke", RarityMenu).Color = Color3.fromRGB(138, 43, 226)

local curFloorIdx = 1
RarityMenu.MouseButton1Click:Connect(function()
    curFloorIdx = curFloorIdx + 1
    if curFloorIdx > #getgenv().FloorList then curFloorIdx = 1 end
    local selectedFloorName = getgenv().FloorList[curFloorIdx]
    RarityMenu.Text = "🥚 Floor: " .. selectedFloorName .. " ↓"
    for _, rarity in ipairs(getgenv().EggRarities) do
        if rarity.Name == selectedFloorName then getgenv().RarityFloorIndex = rarity.Rank break end
    end
end)

-- 3. TOMBOL FITUR OTOMATISASI DI MENU UTAMA
local function CreateMainToggle(text, varName)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.88, 0, 0, 36)
    btn.Text = text .. " 🔴"
    btn.TextColor3 = Color3.fromRGB(255, 90, 90)
    btn.BackgroundColor3 = Color3.fromRGB(24, 16, 38)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 12
    btn.Parent = MainFrame
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    local s = Instance.new("UIStroke", btn)
    s.Color = Color3.fromRGB(60, 40, 90)
    
    btn.MouseButton1Click:Connect(function()
        getgenv()[varName] = not getgenv()[varName]
        if getgenv()[varName] then
            btn.Text = text .. " 🟢"
            btn.TextColor3 = Color3.fromRGB(90, 255, 90)
            s.Color = Color3.fromRGB(0, 200, 0)
        else
            btn.Text = text .. " 🔴"
            btn.TextColor3 = Color3.fromRGB(255, 90, 90)
            s.Color = Color3.fromRGB(60, 40, 90)
        end
    end)
end

CreateMainToggle("⚡ AUTO STEAL GLOBAL", "AutoSteal")
CreateMainToggle("🏋️‍♂️ AUTO AFK TRAIN GYM", "AutoTrain")
CreateMainToggle("⚙️ AUTO BUY ALL UPGRADES", "AutoUpgradeAll")
CreateMainToggle("🥚 AUTO HATCH ALL EGGS", "AutoHatch")
CreateMainToggle("🐾 AUTO EQUIP BEST PETS", "AutoEquip")

-- Komponen Atas Steal Panel Kanan
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, -20, 0, 35)
Header.Position = UDim2.new(0, 10, 0, 5)
Header.BackgroundTransparency = 1
Header.Parent = StealFrame

local StealTitle = Instance.new("TextLabel")
StealTitle.Size = UDim2.new(0.9, 0, 1, 0)
StealTitle.Text = "Steal Panel (Real-time Objects)"
StealTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
StealTitle.Font = Enum.Font.SourceSansBold
StealTitle.TextSize = 16
StealTitle.TextXAlignment = Enum.TextXAlignment.Left
StealTitle.BackgroundTransparency = 1
StealTitle.Parent = Header

-- Wadah List Item Bergulir Steal Panel
local ItemScrollList = Instance.new("ScrollingFrame")
ItemScrollList.Size = UDim2.new(1, -20, 1, -55)
ItemScrollList.Position = UDim2.new(0, 10, 0, 40)
ItemScrollList.BackgroundColor3 = Color3.fromRGB(18, 14, 32)
ItemScrollList.BorderSizePixel = 0
ItemScrollList.CanvasSize = UDim2.new(0, 0, 0, 500)
ItemScrollList.ScrollBarThickness = 3
ItemScrollList.Parent = StealFrame
Instance.new("UICorner", ItemScrollList).CornerRadius = UDim.new(0, 6)

local ListLayout = Instance.new("UIListLayout", ItemScrollList)
ListLayout.Padding = UDim.new(0, 5)
ListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- LOOP SCANNER BARIS LIST PANEL KANAN (1.5 DETIK - SANGAT RINGAN)
task.spawn(function()
    while task.wait(1.5) do
        pcall(function()
            for _, child in pairs(ItemScrollList:GetChildren()) do
                if child:IsA("Frame") then child:Destroy() end
            end
            local FoundItems = {}
            for _, obj in pairs(game:GetService("Workspace"):GetDescendants()) do
                if obj:IsA("Model") and (obj.Name:lower():find("egg") or obj:FindFirstChild("TouchTransmitter")) then
                    local nameLower = obj.Name:lower()
                    local currentBiomeLower = getgenv().ActiveBiome:lower()
                    
                    local isInSelectedBiome = obj:FindFirstAncestor(getgenv().ActiveBiome) or nameLower:find(currentBiomeLower)
                    if currentBiomeLower == "all map" or isInSelectedBiome then
                        local itemColor = Color3.fromRGB(255, 255, 255)
                        for _, rarity in ipairs(getgenv().EggRarities) do
                            if nameLower:find(rarity.Name:lower()) then itemColor = rarity.Color break end
                        end
                        table.insert(FoundItems, {Instance = obj, Name = obj.Name, Color = itemColor})
                    end
                end
            end
            for _, data in ipairs(FoundItems) do
                local RowFrame = Instance.new("Frame")
                RowFrame.Size = UDim2.new(0.96, 0, 0, 38)
                RowFrame.BackgroundColor3 = Color3.fromRGB(26, 20, 48)
                RowFrame.Parent = ItemScrollList
                Instance.new("UICorner", RowFrame).CornerRadius = UDim.new(0, 6)
                
                local ItemLabel = Instance.new("TextLabel")
                ItemLabel.Size = UDim2.new(0.65, 0, 1, 0)
                ItemLabel.Position = UDim2.new(0, 8, 0, 0)
                ItemLabel.Text = data.Name
                ItemLabel.TextColor3 = data.Color
                ItemLabel.Font = Enum.Font.SourceSansBold
                ItemLabel.TextSize = 11
                ItemLabel.TextXAlignment = Enum.TextXAlignment.Left
                ItemLabel.BackgroundTransparency = 1
                ItemLabel.Parent = RowFrame
                
                local StealItemBtn = Instance.new("TextButton")
                StealItemBtn.Size = UDim2.new(0.28, 0, 0, 26)
                StealItemBtn.Position = UDim2.new(0.7, 0, 0, 6)
                StealItemBtn.Text = "Steal ⭐️"
                StealItemBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                StealItemBtn.BackgroundColor3 = Color3.fromRGB(34, 139, 34)
                StealItemBtn.Font = Enum.Font.SourceSansBold
                StealItemBtn.TextSize = 11
                StealItemBtn.Parent = RowFrame
                Instance.new("UICorner", StealItemBtn).CornerRadius = UDim.new(0, 5)
                
                StealItemBtn.MouseButton1Click:Connect(function()
                    StealItemBtn.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
                    getgenv().PriorityTarget = data.Instance
                    task.wait(0.15)
                    StealItemBtn.BackgroundColor3 = Color3.fromRGB(34, 139, 34)
                end)
            end
        end)
    end
end)

-- KENDALI KLIK HUD TERPISAH
local mainOpen = false
CrownIcon.MouseButton1Click:Connect(function()
    mainOpen = not mainOpen
    MainFrame.Visible = mainOpen
end)

local stealOpen = false
StealIcon.MouseButton1Click:Connect(function()
    stealOpen = not stealOpen
    StealFrame.Visible = stealOpen
end)

print("[Zerobix Hub]: Biome & Floor Rarity Version Successfully Activated!")
