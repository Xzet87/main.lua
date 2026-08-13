-- [[ EXZET HUB - STEAL AN EGG (3-STEP SIMPLE AUTO STEAL) ]] --

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

local isAutoStealActive = false
local myBasePosition = nil
local selectedRarity = "Common"

-- Clean Old GUI
if CoreGui:FindFirstChild("ExzetHubUI") then
    CoreGui.ExzetHubUI:Destroy()
end

local ExzetHubUI = Instance.new("ScreenGui")
ExzetHubUI.Name = "ExzetHubUI"
ExzetHubUI.Parent = CoreGui
ExzetHubUI.ResetOnSpawn = false

-- MAIN FRAME
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ExzetHubUI
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -140)
MainFrame.Size = UDim2.new(0, 400, 0, 280)
MainFrame.Active = true
MainFrame.Draggable = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Parent = MainFrame
MainStroke.Color = Color3.fromRGB(255, 40, 40)
MainStroke.Thickness = 1.5

-- TOPBAR
local Topbar = Instance.new("Frame")
Topbar.Parent = MainFrame
Topbar.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Topbar.BorderSizePixel = 0
Topbar.Size = UDim2.new(1, 0, 0, 35)

local TopbarCorner = Instance.new("UICorner")
TopbarCorner.CornerRadius = UDim.new(0, 10)
TopbarCorner.Parent = Topbar

local Title = Instance.new("TextLabel")
Title.Parent = Topbar
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 12, 0, 0)
Title.Size = UDim2.new(0, 300, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "Exzet Hub - Simple Hold Auto Steal"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 13
Title.TextXAlignment = Enum.TextXAlignment.Left

-- CONTENT
local Content = Instance.new("Frame")
Content.Parent = MainFrame
Content.BackgroundTransparency = 1
Content.Position = UDim2.new(0, 15, 0, 45)
Content.Size = UDim2.new(1, -30, 1, -55)

-- 1. SET BASE BUTTON
local SetBaseBtn = Instance.new("TextButton")
SetBaseBtn.Parent = Content
SetBaseBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
SetBaseBtn.Size = UDim2.new(1, 0, 0, 32)
SetBaseBtn.Font = Enum.Font.GothamBold
SetBaseBtn.Text = "1. Set Posisi Base"
SetBaseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SetBaseBtn.TextSize = 12

local BaseCorner = Instance.new("UICorner")
BaseCorner.CornerRadius = UDim.new(0, 6)
BaseCorner.Parent = SetBaseBtn

-- 2. SELECT RARITY BUTTONS
local RarityLabel = Instance.new("TextLabel")
RarityLabel.Parent = Content
RarityLabel.BackgroundTransparency = 1
RarityLabel.Position = UDim2.new(0, 0, 0, 42)
RarityLabel.Size = UDim2.new(1, 0, 0, 20)
RarityLabel.Font = Enum.Font.GothamBold
RarityLabel.Text = "2. Pilih Rarity Target (Current: Common)"
RarityLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
RarityLabel.TextSize = 11
RarityLabel.TextXAlignment = Enum.TextXAlignment.Left

local rarities = {"Common", "Rare", "Epic", "Legendary", "Mythic"}
local rarityButtons = {}

for i, rarity in ipairs(rarities) do
    local btn = Instance.new("TextButton")
    btn.Parent = Content
    btn.BackgroundColor3 = (rarity == "Common") and Color3.fromRGB(180, 0, 0) or Color3.fromRGB(40, 40, 40)
    btn.Position = UDim2.new(0, (i-1) * 75, 0, 66)
    btn.Size = UDim2.new(0, 72, 0, 28)
    btn.Font = Enum.Font.GothamBold
    btn.Text = rarity
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 10
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 5)
    corner.Parent = btn
    
    btn.MouseButton1Click:Connect(function()
        selectedRarity = rarity
        RarityLabel.Text = "2. Pilih Rarity Target (Current: " .. rarity .. ")"
        for _, b in pairs(rarityButtons) do
            b.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        end
        btn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
    end)
    
    table.insert(rarityButtons, btn)
end

-- STATUS
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Parent = Content
StatusLabel.BackgroundTransparency = 1
StatusLabel.Position = UDim2.new(0, 0, 0, 105)
StatusLabel.Size = UDim2.new(1, 0, 0, 20)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.Text = "Status: Menunggu diaktifkan..."
StatusLabel.TextColor3 = Color3.fromRGB(255, 220, 100)
StatusLabel.TextSize = 11
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left

-- 3. AUTO STEAL TOGGLE
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Parent = Content
ToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ToggleBtn.Position = UDim2.new(0, 0, 0, 132)
ToggleBtn.Size = UDim2.new(1, 0, 0, 38)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.Text = "3. AUTO STEAL: OFF"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.TextSize = 12

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 6)
ToggleCorner.Parent = ToggleBtn

-- LOGIC BUTTONS
SetBaseBtn.MouseButton1Click:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        myBasePosition = LocalPlayer.Character.HumanoidRootPart.Position
        SetBaseBtn.Text = "Base Tersimpan!"
        task.wait(1)
        SetBaseBtn.Text = "1. Set Posisi Base"
    end
end)

ToggleBtn.MouseButton1Click:Connect(function()
    isAutoStealActive = not isAutoStealActive
    if isAutoStealActive then
        if not myBasePosition then
            StatusLabel.Text = "❌ Set Posisi Base Terlebih Dahulu!"
            isAutoStealActive = false
            return
        end
        ToggleBtn.Text = "3. AUTO STEAL: ON"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
    else
        ToggleBtn.Text = "3. AUTO STEAL: OFF"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        StatusLabel.Text = "Status: Dimatikan"
    end
end)

-- SCANNER & HOLD LOGIC
local function GetTargetEggPrompt()
    for _, prompt in pairs(Workspace:GetDescendants()) do
        if prompt:IsA("ProximityPrompt") and prompt.Enabled then
            local actionText = string.lower(prompt.ActionText or "")
            local objectText = string.lower(prompt.ObjectText or "")
            local parentName = string.lower(prompt.Parent.Name or "")
            local fullText = actionText .. " " .. objectText .. " " .. parentName

            local isEgg = string.find(fullText, "egg") or string.find(fullText, "telur")
            local isSteal = string.find(fullText, "steal") or string.find(fullText, "take") or string.find(fullText, "grab")

            if isEgg and isSteal then
                -- Filter pencocokan berdasarkan rarity yang dipilih
                if string.find(fullText, string.lower(selectedRarity)) then
                    local charAncestor = prompt:FindFirstAncestorOfClass("Model")
                    local isPlayerOwned = (charAncestor and Players:GetPlayerFromCharacter(charAncestor)) ~= nil
                    if not isPlayerOwned then
                        return prompt
                    end
                end
            end
        end
    end
    return nil
end

-- LOOP UTAMA (TELEPORT -> HOLD SAMPAI TANGAN -> BALIK BASE)
task.spawn(function()
    while task.wait(0.4) do
        if isAutoStealActive and myBasePosition then
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local hrp = char.HumanoidRootPart

                StatusLabel.Text = "Mencari Telur [" .. selectedRarity .. "]..."
                local prompt = GetTargetEggPrompt()

                if prompt then
                    local targetPart = prompt.Parent
                    local targetCFrame = targetPart:IsA("BasePart") and targetPart.CFrame or (targetPart:IsA("Model") and targetPart:GetPivot() or hrp.CFrame)

                    -- 1. Teleport ke Telur
                    StatusLabel.Text = "Teleport ke Telur..."
                    hrp.CFrame = targetCFrame + Vector3.new(0, 3, 0)
                    task.wait(0.25)

                    -- 2. Tahan ProximityPrompt (Sistem Hold Sampai Masuk Tangan)
                    StatusLabel.Text = "Menahan/Hold Telur..."
                    if fireproximityprompt then
                        fireproximityprompt(prompt)
                    end

                    if prompt.InputHoldBegin then
                        prompt:InputHoldBegin()
                        local holdTime = prompt.HoldDuration > 0 and prompt.HoldDuration or 0.5
                        task.wait(holdTime + 0.2) -- Menunggu persis sampai proses hold selesai
                        prompt:InputHoldEnd()
                    else
                        task.wait(0.5)
                    end

                    task.wait(0.2)

                    -- 3. Teleport Balik ke Base setelah Telur di tangan
                    StatusLabel.Text = "Membawa Telur ke Base..."
                    hrp.CFrame = CFrame.new(myBasePosition + Vector3.new(0, 3, 0))
                    task.wait(0.8)
                end
            end
        end
    end
end)
