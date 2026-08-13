-- [[ EXZET HUB - AUTO STEAL WITH RARITY FILTER ]] --

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

local isAutoStealActive = false
local myBasePosition = nil
local selectedRarity = "All" -- Pilihan default

if CoreGui:FindFirstChild("ExzetHubRarityUI") then
    CoreGui.ExzetHubRarityUI:Destroy()
end

local ExzetHubUI = Instance.new("ScreenGui")
ExzetHubUI.Name = "ExzetHubRarityUI"
ExzetHubUI.Parent = CoreGui
ExzetHubUI.ResetOnSpawn = false

-- MAIN FRAME
local MainFrame = Instance.new("Frame")
MainFrame.Parent = ExzetHubUI
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.Position = UDim2.new(0.5, -210, 0.5, -160)
MainFrame.Size = UDim2.new(0, 420, 0, 320)
MainFrame.Active = true
MainFrame.Draggable = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 15, 0, 10)
Title.Size = UDim2.new(1, -30, 0, 30)
Title.Font = Enum.Font.GothamBold
Title.Text = "Exzet Hub - Auto Steal by Rarity"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left

-- SET BASE BUTTON
local SetBaseBtn = Instance.new("TextButton")
SetBaseBtn.Parent = MainFrame
SetBaseBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
SetBaseBtn.Position = UDim2.new(0, 15, 0, 50)
SetBaseBtn.Size = UDim2.new(0, 185, 0, 35)
SetBaseBtn.Font = Enum.Font.GothamBold
SetBaseBtn.Text = "1. Set Posisi Base"
SetBaseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SetBaseBtn.TextSize = 12

local SetBaseCorner = Instance.new("UICorner")
SetBaseCorner.CornerRadius = UDim.new(0, 6)
SetBaseCorner.Parent = SetBaseBtn

-- TP BASE BUTTON
local TPBaseBtn = Instance.new("TextButton")
TPBaseBtn.Parent = MainFrame
TPBaseBtn.BackgroundColor3 = Color3.fromRGB(150, 50, 0)
TPBaseBtn.Position = UDim2.new(0, 210, 0, 50)
TPBaseBtn.Size = UDim2.new(0, 185, 0, 35)
TPBaseBtn.Font = Enum.Font.GothamBold
TPBaseBtn.Text = "TP Ke Base"
TPBaseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TPBaseBtn.TextSize = 12

local TPBaseCorner = Instance.new("UICorner")
TPBaseCorner.CornerRadius = UDim.new(0, 6)
TPBaseCorner.Parent = TPBaseBtn

-- RARITY LABEL & DROPDOWN SIMULATION BUTTONS
local RarityLabel = Instance.new("TextLabel")
RarityLabel.Parent = MainFrame
RarityLabel.BackgroundTransparency = 1
RarityLabel.Position = UDim2.new(0, 15, 0, 95)
RarityLabel.Size = UDim2.new(1, -30, 0, 20)
RarityLabel.Font = Enum.Font.GothamBold
RarityLabel.Text = "Pilih Target Rarity: [ All ]"
RarityLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
RarityLabel.TextSize:getmetatable = nil
RarityLabel.TextSize = 12
RarityLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Tombol Pilihan Rarity (All, Epic, Legendary, Mythic)
local rarities = {"All", "Epic", "Legendary", "Mythic"}
for i, rarityName in ipairs(rarities) do
    local rBtn = Instance.new("TextButton")
    rBtn.Parent = MainFrame
    rBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    rBtn.Position = UDim2.new(0, 15 + ((i-1) * 95), 0, 120)
    rBtn.Size = UDim2.new(0, 90, 0, 30)
    rBtn.Font = Enum.Font.GothamBold
    rBtn.Text = rarityName
    rBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    rBtn.TextSize = 11

    local rCorner = Instance.new("UICorner")
    rCorner.CornerRadius = UDim.new(0, 5)
    rCorner.Parent = rBtn

    rBtn.MouseButton1Click:Connect(function()
        selectedRarity = rarityName
        RarityLabel.Text = "Pilih Target Rarity: [ " .. rarityName .. " ]"
    end)
end

-- STATUS LABEL
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Parent = MainFrame
StatusLabel.BackgroundTransparency = 1
StatusLabel.Position = UDim2.new(0, 15, 0, 165)
StatusLabel.Size = UDim2.new(1, -30, 0, 25)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.Text = "Status: Nonaktif"
StatusLabel.TextColor3 = Color3.fromRGB(255, 220, 100)
StatusLabel.TextSize = 12
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left

-- AUTO STEAL TOGGLE BUTTON
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Parent = MainFrame
ToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ToggleBtn.Position = UDim2.new(0, 15, 0, 200)
ToggleBtn.Size = UDim2.new(0, 380, 0, 45)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.Text = "AUTO STEAL RARITY: OFF"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.TextSize = 13

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 6)
ToggleCorner.Parent = ToggleBtn

-- LOGIC TOMBOL DASAR
SetBaseBtn.MouseButton1Click:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        myBasePosition = LocalPlayer.Character.HumanoidRootPart.Position
        SetBaseBtn.Text = "Base Tersimpan!"
        task.wait(1)
        SetBaseBtn.Text = "1. Set Posisi Base"
    end
end)

TPBaseBtn.MouseButton1Click:Connect(function()
    if myBasePosition and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(myBasePosition + Vector3.new(0, 3, 0))
    end
end)

ToggleBtn.MouseButton1Click:Connect(function()
    isAutoStealActive = not isAutoStealActive
    if isAutoStealActive then
        if not myBasePosition then
            StatusLabel.Text = "❌ Set Posisi Base Dulu!"
            isAutoStealActive = false
            return
        end
        ToggleBtn.Text = "AUTO STEAL RARITY: ON"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
    else
        ToggleBtn.Text = "AUTO STEAL RARITY: OFF"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        StatusLabel.Text = "Status: Nonaktif"
    end
end)

-- FILTER SCANNER BERDASARKAN RARITY DAN SMARTPROMPT
local function GetFilteredEggs()
    local eggs = {}
    local objectsFolder = Workspace:FindFirstChild("__OBJECTS")
    local searchRoot = objectsFolder or Workspace
    
    for _, obj in pairs(searchRoot:GetDescendants()) do
        if obj.Name == "SmartPromptPart" and obj:IsA("BasePart") then
            -- Cek nama parent atau atribut untuk mencocokkan rarity
            local parentName = obj.Parent and obj.Parent.Name:lower() or ""
            local matchesRarity = false

            if selectedRarity == "All" then
                matchesRarity = true
            elseif string.find(parentName, selectedRarity:lower()) then
                matchesRarity = true
            else
                -- Cek apakah ada teks rarity di dalam model/folder terkait
                for _, child in pairs(obj.Parent:GetDescendants()) do
                    if child:IsA("TextLabel") and string.find(child.Text:lower(), selectedRarity:lower()) then
                        matchesRarity = true
                        break
                    end
                end
            end

            if matchesRarity then
                table.insert(eggs, obj)
            end
        end
    end
    return eggs
end

-- AUTO LOOP EKsekusi PENCURIAN OTOMATIS
task.spawn(function()
    while task.wait(0.3) do
        if isAutoStealActive and myBasePosition then
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("Humanoid") then
                local hrp = char.HumanoidRootPart
                local hum = char.Humanoid

                if hum.Health > 0 then
                    local targetEggs = GetFilteredEggs()

                    if #targetEggs > 0 then
                        local targetPart = targetEggs[1]
                        StatusLabel.Text = "Mencuri Telur Rarity: " .. selectedRarity

                        -- 1. Teleport otomatis ke target telur
                        hrp.CFrame = targetPart.CFrame + Vector3.new(0, 3, 0)
                        task.wait(0.25)

                        -- 2. Simulasi interaksi touch
                        if firetouchinterest then
                            firetouchinterest(hrp, targetPart, 0)
                            task.wait(0.05)
                            firetouchinterest(hrp, targetPart, 1)
                        end

                        task.wait(0.2)

                        -- 3. Teleport balik otomatis ke base
                        hrp.CFrame = CFrame.new(myBasePosition + Vector3.new(0, 3, 0))
                        task.wait(0.8)
                    else
                        StatusLabel.Text = "Menunggu Telur " .. selectedRarity .. " Muncul..."
                    end
                end
            end
        end
    end
end)
