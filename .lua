-- [[ EXZET HUB - ADVANCED INDEX/RARITY SYNCED AUTO STEAL ]] --

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

-- Global Variables
local customSpeed = 16
local defaultSpeed = 16
local isSpeedActive = false

local isAutoStealActive = false
local myBasePosition = nil
local selectedTargetRarity = "Common" -- Default target rarity

-- Clean Old GUI
if CoreGui:FindFirstChild("ExzetHubUI") then
    CoreGui.ExzetHubUI:Destroy()
end

local ExzetHubUI = Instance.new("ScreenGui")
ExzetHubUI.Name = "ExzetHubUI"
ExzetHubUI.Parent = CoreGui
ExzetHubUI.ResetOnSpawn = false

-------------------------------------------------------------------
-- 1. FLOATING MINIMIZE BUTTON ("XZ")
-------------------------------------------------------------------
local ToggleIconBtn = Instance.new("TextButton")
ToggleIconBtn.Name = "ToggleIconBtn"
ToggleIconBtn.Parent = ExzetHubUI
ToggleIconBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
ToggleIconBtn.Position = UDim2.new(0.05, 0, 0.15, 0)
ToggleIconBtn.Size = UDim2.new(0, 45, 0, 45)
ToggleIconBtn.Font = Enum.Font.GothamBold
ToggleIconBtn.Text = "XZ"
ToggleIconBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleIconBtn.TextSize = 18
ToggleIconBtn.Visible = false
ToggleIconBtn.Active = true
ToggleIconBtn.Draggable = true

local IconCorner = Instance.new("UICorner")
IconCorner.CornerRadius = UDim.new(0, 10)
IconCorner.Parent = ToggleIconBtn

local IconStroke = Instance.new("UIStroke")
IconStroke.Parent = ToggleIconBtn
IconStroke.Color = Color3.fromRGB(255, 255, 255)
IconStroke.Thickness = 1.5

-------------------------------------------------------------------
-- 2. MAIN HUB FRAME
-------------------------------------------------------------------
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ExzetHubUI
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.BackgroundTransparency = 0.15
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -185)
MainFrame.Size = UDim2.new(0, 450, 0, 385)
MainFrame.Active = true
MainFrame.Draggable = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

local MainGradient = Instance.new("UIGradient")
MainGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(150, 0, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 15))
}
MainGradient.Rotation = 45
MainGradient.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Parent = MainFrame
MainStroke.Color = Color3.fromRGB(255, 40, 40)
MainStroke.Thickness = 1.5

-- TOPBAR
local Topbar = Instance.new("Frame")
Topbar.Name = "Topbar"
Topbar.Parent = MainFrame
Topbar.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Topbar.BackgroundTransparency = 0.4
Topbar.BorderSizePixel = 0
Topbar.Size = UDim2.new(1, 0, 0, 38)

local TopbarCorner = Instance.new("UICorner")
TopbarCorner.CornerRadius = UDim.new(0, 10)
TopbarCorner.Parent = Topbar

local Title = Instance.new("TextLabel")
Title.Parent = Topbar
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 12, 0, 0)
Title.Size = UDim2.new(0, 300, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "Exzet Hub - Index Rarity Synced Steal"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 13
Title.TextXAlignment = Enum.TextXAlignment.Left

-- MINIMIZE & CLOSE BUTTONS
local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Parent = Topbar
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MinimizeBtn.Position = UDim2.new(1, -70, 0, 6)
MinimizeBtn.Size = UDim2.new(0, 26, 0, 26)
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.Text = "-"
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeBtn.TextSize = 16

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 6)
MinCorner.Parent = MinimizeBtn

local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = Topbar
CloseBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
CloseBtn.Position = UDim2.new(1, -36, 0, 6)
CloseBtn.Size = UDim2.new(0, 26, 0, 26)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 14

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseBtn

MinimizeBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    ToggleIconBtn.Visible = true
end)

ToggleIconBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    ToggleIconBtn.Visible = false
end)

CloseBtn.MouseButton1Click:Connect(function()
    ExzetHubUI:Destroy()
end)

-------------------------------------------------------------------
-- TAB NAVIGATION
-------------------------------------------------------------------
local TabBar = Instance.new("Frame")
TabBar.Parent = MainFrame
TabBar.BackgroundTransparency = 1
TabBar.Position = UDim2.new(0, 8, 0, 45)
TabBar.Size = UDim2.new(0, 100, 1, -50)

local InfoTabBtn = Instance.new("TextButton")
InfoTabBtn.Parent = TabBar
InfoTabBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
InfoTabBtn.Size = UDim2.new(1, 0, 0, 32)
InfoTabBtn.Font = Enum.Font.GothamBold
InfoTabBtn.Text = "Info"
InfoTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
InfoTabBtn.TextSize = 13

local InfoCorner = Instance.new("UICorner")
InfoCorner.CornerRadius = UDim.new(0, 6)
InfoCorner.Parent = InfoTabBtn

local MainTabBtn = Instance.new("TextButton")
MainTabBtn.Parent = TabBar
MainTabBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MainTabBtn.Position = UDim2.new(0, 0, 0, 40)
MainTabBtn.Size = UDim2.new(1, 0, 0, 32)
MainTabBtn.Font = Enum.Font.GothamBold
MainTabBtn.Text = "Main"
MainTabBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
MainTabBtn.TextSize = 13

local MainTabCorner = Instance.new("UICorner")
MainTabCorner.CornerRadius = UDim.new(0, 6)
MainTabCorner.Parent = MainTabBtn

-- PAGES
local ContentContainer = Instance.new("Frame")
ContentContainer.Parent = MainFrame
ContentContainer.BackgroundTransparency = 1
ContentContainer.Position = UDim2.new(0, 115, 0, 45)
ContentContainer.Size = UDim2.new(1, -125, 1, -50)

local InfoPage = Instance.new("Frame")
InfoPage.Parent = ContentContainer
InfoPage.BackgroundTransparency = 1
InfoPage.Size = UDim2.new(1, 0, 1, 0)

local CreatorLabel = Instance.new("TextLabel")
CreatorLabel.Parent = InfoPage
CreatorLabel.BackgroundTransparency = 1
CreatorLabel.Position = UDim2.new(0, 0, 0, 5)
CreatorLabel.Size = UDim2.new(1, 0, 0, 20)
CreatorLabel.Font = Enum.Font.GothamBold
CreatorLabel.Text = "Pembuat: exzet"
CreatorLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
CreatorLabel.TextSize = 14
CreatorLabel.TextXAlignment = Enum.TextXAlignment.Left

local MainPage = Instance.new("Frame")
MainPage.Parent = ContentContainer
MainPage.BackgroundTransparency = 1
MainPage.Size = UDim2.new(1, 0, 1, 0)
MainPage.Visible = false

-------------------------------------------------------------------
-- SPEED CONTROL
-------------------------------------------------------------------
local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Parent = MainPage
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Position = UDim2.new(0, 0, 0, 0)
SpeedLabel.Size = UDim2.new(1, 0, 0, 15)
SpeedLabel.Font = Enum.Font.GothamBold
SpeedLabel.Text = "Kecepatan Jalan:"
SpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedLabel.TextSize = 11
SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left

local SpeedInput = Instance.new("TextBox")
SpeedInput.Parent = MainPage
SpeedInput.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
SpeedInput.Position = UDim2.new(0, 0, 0, 16)
SpeedInput.Size = UDim2.new(0, 90, 0, 22)
SpeedInput.Font = Enum.Font.Gotham
SpeedInput.PlaceholderText = "300"
SpeedInput.Text = ""
SpeedInput.TextColor3 = Color3.fromRGB(255, 255, 255)

local SpeedApplyBtn = Instance.new("TextButton")
SpeedApplyBtn.Parent = MainPage
SpeedApplyBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
SpeedApplyBtn.Position = UDim2.new(0, 95, 0, 16)
SpeedApplyBtn.Size = UDim2.new(0, 75, 0, 22)
SpeedApplyBtn.Font = Enum.Font.GothamBold
SpeedApplyBtn.Text = "Set Speed"
SpeedApplyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedApplyBtn.TextSize = 10

local SpeedResetBtn = Instance.new("TextButton")
SpeedResetBtn.Parent = MainPage
SpeedResetBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
SpeedResetBtn.Position = UDim2.new(0, 174, 0, 16)
SpeedResetBtn.Size = UDim2.new(0, 102, 0, 22)
SpeedResetBtn.Font = Enum.Font.GothamBold
SpeedResetBtn.Text = "Reset"
SpeedResetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedResetBtn.TextSize = 10

SpeedApplyBtn.MouseButton1Click:Connect(function()
    local num = tonumber(SpeedInput.Text)
    if num then customSpeed = num; isSpeedActive = true end
end)

SpeedResetBtn.MouseButton1Click:Connect(function()
    isSpeedActive = false
    customSpeed = defaultSpeed
    SpeedInput.Text = ""
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = defaultSpeed
    end
end)

-------------------------------------------------------------------
-- STEAL EGG & DYNAMIC INDEX/RARITY SELECTOR CONTROLS
-------------------------------------------------------------------
local SetBaseBtn = Instance.new("TextButton")
SetBaseBtn.Parent = MainPage
SetBaseBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
SetBaseBtn.Position = UDim2.new(0, 0, 0, 45)
SetBaseBtn.Size = UDim2.new(0, 133, 0, 26)
SetBaseBtn.Font = Enum.Font.GothamBold
SetBaseBtn.Text = "1. Set Posisi Base"
SetBaseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SetBaseBtn.TextSize = 10

local TPBaseDirectBtn = Instance.new("TextButton")
TPBaseDirectBtn.Parent = MainPage
TPBaseDirectBtn.BackgroundColor3 = Color3.fromRGB(150, 50, 0)
TPBaseDirectBtn.Position = UDim2.new(0, 138, 0, 45)
TPBaseDirectBtn.Size = UDim2.new(0, 138, 0, 26)
TPBaseDirectBtn.Font = Enum.Font.GothamBold
TPBaseDirectBtn.Text = "TP Ke Base"
TPBaseDirectBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TPBaseDirectBtn.TextSize = 10

-- RARITY / INDEX SELECTOR BUTTONS
local RarityLabel = Instance.new("TextLabel")
RarityLabel.Parent = MainPage
RarityLabel.BackgroundTransparency = 1
RarityLabel.Position = UDim2.new(0, 0, 0, 78)
RarityLabel.Size = UDim2.new(1, 0, 0, 15)
RarityLabel.Font = Enum.Font.GothamBold
RarityLabel.Text = "Pilih Rarity Index Target:"
RarityLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
RarityLabel.TextSize = 11
RarityLabel.TextXAlignment = Enum.TextXAlignment.Left

local rarities = {"Common", "Uncommon", "Rare", "Epic", "Legendary"}
local rarityButtons = {}

for i, rarityName in ipairs(rarities) do
    local btn = Instance.new("TextButton")
    btn.Parent = MainPage
    btn.BackgroundColor3 = (rarityName == "Common") and Color3.fromRGB(180, 0, 0) or Color3.fromRGB(45, 45, 45)
    btn.Position = UDim2.new(0, (i - 1) * 56, 0, 96)
    btn.Size = UDim2.new(0, 54, 0, 22)
    btn.Font = Enum.Font.GothamBold
    btn.Text = rarityName
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 9
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 4)
    corner.Parent = btn

    btn.MouseButton1Click:Connect(function()
        selectedTargetRarity = rarityName
        for _, b in pairs(rarityButtons) do
            b.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        end
        btn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
    end)
    table.insert(rarityButtons, btn)
end

local DisplayEggLabel = Instance.new("TextLabel")
DisplayEggLabel.Parent = MainPage
DisplayEggLabel.BackgroundTransparency = 1
DisplayEggLabel.Position = UDim2.new(0, 0, 0, 126)
DisplayEggLabel.Size = UDim2.new(1, 0, 0, 16)
DisplayEggLabel.Font = Enum.Font.Gotham
DisplayEggLabel.Text = "Status: Nonaktif"
DisplayEggLabel.TextColor3 = Color3.fromRGB(255, 220, 100)
DisplayEggLabel.TextSize = 10
DisplayEggLabel.TextXAlignment = Enum.TextXAlignment.Left

local ToggleAutoStealBtn = Instance.new("TextButton")
ToggleAutoStealBtn.Parent = MainPage
ToggleAutoStealBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ToggleAutoStealBtn.Position = UDim2.new(0, 0, 0, 148)
ToggleAutoStealBtn.Size = UDim2.new(0, 276, 0, 32)
ToggleAutoStealBtn.Font = Enum.Font.GothamBold
ToggleAutoStealBtn.Text = "AUTO STEAL EGG: OFF"
ToggleAutoStealBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleAutoStealBtn.TextSize = 11

SetBaseBtn.MouseButton1Click:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        myBasePosition = LocalPlayer.Character.HumanoidRootPart.Position
        SetBaseBtn.Text = "Base Tersimpan!"
        task.wait(1)
        SetBaseBtn.Text = "1. Set Posisi Base"
    end
end)

TPBaseDirectBtn.MouseButton1Click:Connect(function()
    if myBasePosition and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(myBasePosition + Vector3.new(0, 3, 0))
    end
end)

ToggleAutoStealBtn.MouseButton1Click:Connect(function()
    isAutoStealActive = not isAutoStealActive
    if isAutoStealActive then
        if not myBasePosition then
            DisplayEggLabel.Text = "❌ Harap Set Posisi Base Dulu!"
            isAutoStealActive = false
            return
        end
        ToggleAutoStealBtn.Text = "AUTO STEAL EGG: ON"
        ToggleAutoStealBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
    else
        ToggleAutoStealBtn.Text = "AUTO STEAL EGG: OFF"
        ToggleAutoStealBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        DisplayEggLabel.Text = "Status: Nonaktif"
    end
end)

-------------------------------------------------------------------
-- STRICT INDEX/RARITY MAPPING ENGINE
-------------------------------------------------------------------
-- Fungsi mendeteksi index rarity berdasarkan hierarki tempat/parent atau nama asset di Workspace
local function GetValidStealableEggs()
    local validEggs = {}

    for _, prompt in pairs(Workspace:GetDescendants()) do
        if prompt:IsA("ProximityPrompt") and prompt.Enabled then
            local actionText = string.lower(prompt.ActionText or "")
            local objectText = string.lower(prompt.ObjectText or "")
            local parentInstance = prompt.Parent
            local parentName = string.lower(parentInstance and parentInstance.Name or "")
            
            -- Ambil semua nama struktur dari folder/model di atasnya sampai beberapa tingkat ke atas
            local fullHierarchyText = actionText .. " " .. objectText .. " " .. parentName
            local currentObj = parentInstance
            for i = 1, 4 do
                if currentObj and currentObj.Parent then
                    currentObj = currentObj.Parent
                    fullHierarchyText = fullHierarchyText .. " " .. string.lower(currentObj.Name)
                else
                    break
                end
            end

            -- 1. Harus mengandung kata kunci telur/egg
            local isEggItem = string.find(fullHierarchyText, "egg") or string.find(fullHierarchyText, "telur")

            -- 2. Dilarang keras mengambil DNA, Pet, Mesin, Fuse, Shop, dll
            local isForbidden = string.find(fullHierarchyText, "dna") or 
                                string.find(fullHierarchyText, "pet") or 
                                string.find(fullHierarchyText, "fuse") or 
                                string.find(fullHierarchyText, "craft") or 
                                string.find(fullHierarchyText, "shop") or 
                                string.find(fullHierarchyText, "upgrade") or 
                                string.find(fullHierarchyText, "reborn") or
                                string.find(fullHierarchyText, "machine")

            -- 3. Harus berstatus bisa diambil/dicuri
            local isStealable = string.find(fullHierarchyText, "steal") or string.find(fullHierarchyText, "take") or string.find(fullHierarchyText, "grab") or isEggItem

            if isEggItem and isStealable and not isForbidden then
                -- Pastikan bukan milik player lain (Humanoid character)
                local charAncestor = prompt:FindFirstAncestorOfClass("Model")
                if not (charAncestor and Players:GetPlayerFromCharacter(charAncestor)) then
                    
                    -- Filter ketat sesuai tombol Index Rarity yang sedang dipilih user
                    local matchTarget = string.find(fullHierarchyText, string.lower(selectedTargetRarity))

                    if matchTarget then
                        table.insert(validEggs, prompt)
                    end
                end
            end
        end
    end

    return validEggs
end

-------------------------------------------------------------------
-- REAL AUTOMATIC STEAL & 100% HOLD LOOP FROM BASE
-------------------------------------------------------------------
task.spawn(function()
    while task.wait(0.2) do
        if isAutoStealActive and myBasePosition then
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("Humanoid") then
                local hrp = char.HumanoidRootPart
                local hum = char.Humanoid

                if hum.Health > 0 then
                    local eggPrompts = GetValidStealableEggs()

                    if #eggPrompts > 0 then
                        local selectedPrompt = eggPrompts[1]
                        local targetPart = selectedPrompt.Parent
                        
                        DisplayEggLabel.Text = "Mencuri [" .. selectedTargetRarity .. "]: " .. targetPart.Name

                        local targetCFrame = targetPart:IsA("BasePart") and targetPart.CFrame or (targetPart:IsA("Model") and targetPart:GetPivot() or hrp.CFrame)

                        -- 1. Teleport instan dari base langsung ke lokasi telur target
                        hrp.CFrame = targetCFrame + Vector3.new(0, 3, 0)
                        task.wait(0.12)

                        -- 2. EKSEKUSI HOLD 100% PROXIMITY PROMPT SECARA PAKSA
                        if fireproximityprompt then
                            fireproximityprompt(selectedPrompt)
                        end
                        
                        if selectedPrompt.InputHoldBegin then
                            selectedPrompt:InputHoldBegin()
                            -- Tahan sesuai durasi asli prompt game ditambah jeda aman agar hold 100% tuntas
                            local holdTime = (selectedPrompt.HoldDuration and selectedPrompt.HoldDuration > 0) and selectedPrompt.HoldDuration or 0.3
                            task.wait(holdTime + 0.15)
                            if selectedPrompt.InputHoldEnd then
                                selectedPrompt:InputHoldEnd()
                            end
                        else
                            task.wait(0.3)
                        end

                        task.wait(0.1)

                        -- 3. Teleport Cepat (Blink) kembali ke Base agar bawaan telur tidak terlepas di jalan
                        local startPos = hrp.Position
                        local endPos = myBasePosition
                        local dist = (endPos - startPos).Magnitude
                        local steps = math.clamp(math.floor(dist / 20), 3, 10)

                        for i = 1, steps do
                            if not isAutoStealActive then break end
                            hrp.CFrame = CFrame.new(startPos:Lerp(endPos, i / steps) + Vector3.new(0, 2.5, 0))
                            task.wait(0.02)
                        end

                        hrp.CFrame = CFrame.new(myBasePosition + Vector3.new(0, 3, 0))
                        task.wait(0.5) -- Jeda waktu agar telur masuk/deposit dengan sempurna di base
                    else
                        DisplayEggLabel.Text = "Mencari Rarity [" .. selectedTargetRarity .. "] di Map..."
                        -- Jika belum ketemu atau sedang kosong, posisikan player tetap di base agar aman
                        if (hrp.Position - myBasePosition).Magnitude > 15 then
                            hrp.CFrame = CFrame.new(myBasePosition + Vector3.new(0, 3, 0))
                        end
                    end
                end
            end
        end
    end
end)

-------------------------------------------------------------------
-- PERMANENT SPEED ENGINE
-------------------------------------------------------------------
RunService.Heartbeat:Connect(function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("Humanoid") then
        local hum = char.Humanoid
        local hrp = char.HumanoidRootPart

        if isSpeedActive and hum.Health > 0 and hum.MoveDirection.Magnitude > 0 then
            local speedMultiplier = (customSpeed / 16) - 1
            if speedMultiplier > 0 then
                hrp.CFrame = hrp.CFrame + (hum.MoveDirection * (speedMultiplier * 0.28))
            end
        end
    end
end)

-- TAB NAVIGATION SWITCH
InfoTabBtn.MouseButton1Click:Connect(function()
    InfoPage.Visible = true; MainPage.Visible = false
    InfoTabBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
    MainTabBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
end)

MainTabBtn.MouseButton1Click:Connect(function()
    InfoPage.Visible = false; MainPage.Visible = true
    MainTabBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
    InfoTabBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
end)
