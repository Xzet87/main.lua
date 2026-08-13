-- [[ EXZET HUB V8 - WISHHUB AUTO STEAL REPLICA + RARITY FILTER ]] --

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

-- Rarities Settings
local raritiesList = {"ALL RARITIES", "Secret", "Mythic", "Legendary", "Rare", "Uncommon", "Common"}
local selectedRarityIndex = 1

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
-- 2. MAIN HUB FRAME (WISHHUB STYLE UI)
-------------------------------------------------------------------
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ExzetHubUI
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 16, 22)
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -170)
MainFrame.Size = UDim2.new(0, 450, 0, 340)
MainFrame.Active = true
MainFrame.Draggable = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Parent = MainFrame
MainStroke.Color = Color3.fromRGB(140, 60, 220)
MainStroke.Thickness = 1.5

-- TOPBAR
local Topbar = Instance.new("Frame")
Topbar.Name = "Topbar"
Topbar.Parent = MainFrame
Topbar.BackgroundColor3 = Color3.fromRGB(10, 8, 14)
Topbar.BorderSizePixel = 0
Topbar.Size = UDim2.new(1, 0, 0, 38)

local TopbarCorner = Instance.new("UICorner")
TopbarCorner.CornerRadius = UDim.new(0, 10)
TopbarCorner.Parent = Topbar

local Title = Instance.new("TextLabel")
Title.Parent = Topbar
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 12, 0, 0)
Title.Size = UDim2.new(0, 240, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "Exzet Hub - Auto Stealer (WishHub V8)"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 13
Title.TextXAlignment = Enum.TextXAlignment.Left

-- MINIMIZE & CLOSE BUTTONS
local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Parent = Topbar
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
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

local MainTabBtn = Instance.new("TextButton")
MainTabBtn.Parent = TabBar
MainTabBtn.BackgroundColor3 = Color3.fromRGB(120, 40, 200)
MainTabBtn.Size = UDim2.new(1, 0, 0, 32)
MainTabBtn.Font = Enum.Font.GothamBold
MainTabBtn.Text = "Eggs"
MainTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MainTabBtn.TextSize = 13

local MainTabCorner = Instance.new("UICorner")
MainTabCorner.CornerRadius = UDim.new(0, 6)
MainTabCorner.Parent = MainTabBtn

local InfoTabBtn = Instance.new("TextButton")
InfoTabBtn.Parent = TabBar
InfoTabBtn.BackgroundColor3 = Color3.fromRGB(30, 25, 35)
InfoTabBtn.Position = UDim2.new(0, 0, 0, 40)
InfoTabBtn.Size = UDim2.new(1, 0, 0, 32)
InfoTabBtn.Font = Enum.Font.GothamBold
InfoTabBtn.Text = "Info"
InfoTabBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
InfoTabBtn.TextSize = 13

local InfoCorner = Instance.new("UICorner")
InfoCorner.CornerRadius = UDim.new(0, 6)
InfoCorner.Parent = InfoTabBtn

-- PAGES CONTAINER
local ContentContainer = Instance.new("Frame")
ContentContainer.Parent = MainFrame
ContentContainer.BackgroundTransparency = 1
ContentContainer.Position = UDim2.new(0, 115, 0, 45)
ContentContainer.Size = UDim2.new(1, -125, 1, -50)

local MainPage = Instance.new("Frame")
MainPage.Parent = ContentContainer
MainPage.BackgroundTransparency = 1
MainPage.Size = UDim2.new(1, 0, 1, 0)

local InfoPage = Instance.new("Frame")
InfoPage.Parent = ContentContainer
InfoPage.BackgroundTransparency = 1
InfoPage.Size = UDim2.new(1, 0, 1, 0)
InfoPage.Visible = false

local CreatorLabel = Instance.new("TextLabel")
CreatorLabel.Parent = InfoPage
CreatorLabel.BackgroundTransparency = 1
CreatorLabel.Position = UDim2.new(0, 0, 0, 5)
CreatorLabel.Size = UDim2.new(1, 0, 0, 20)
CreatorLabel.Font = Enum.Font.GothamBold
CreatorLabel.Text = "Pembuat: exzet (Replica WishHub)"
CreatorLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
CreatorLabel.TextSize = 13
CreatorLabel.TextXAlignment = Enum.TextXAlignment.Left

-------------------------------------------------------------------
-- SPEED CONTROLS
-------------------------------------------------------------------
local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Parent = MainPage
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Position = UDim2.new(0, 0, 0, 0)
SpeedLabel.Size = UDim2.new(1, 0, 0, 15)
SpeedLabel.Font = Enum.Font.GothamBold
SpeedLabel.Text = "Speed Engine (Permanent):"
SpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedLabel.TextSize = 11
SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left

local SpeedInput = Instance.new("TextBox")
SpeedInput.Parent = MainPage
SpeedInput.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
SpeedInput.Position = UDim2.new(0, 0, 0, 16)
SpeedInput.Size = UDim2.new(0, 90, 0, 22)
SpeedInput.Font = Enum.Font.Gotham
SpeedInput.PlaceholderText = "300"
SpeedInput.Text = ""
SpeedInput.TextColor3 = Color3.fromRGB(255, 255, 255)

local SpeedApplyBtn = Instance.new("TextButton")
SpeedApplyBtn.Parent = MainPage
SpeedApplyBtn.BackgroundColor3 = Color3.fromRGB(120, 40, 200)
SpeedApplyBtn.Position = UDim2.new(0, 95, 0, 16)
SpeedApplyBtn.Size = UDim2.new(0, 75, 0, 22)
SpeedApplyBtn.Font = Enum.Font.GothamBold
SpeedApplyBtn.Text = "Set Speed"
SpeedApplyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedApplyBtn.TextSize = 10

local SpeedResetBtn = Instance.new("TextButton")
SpeedResetBtn.Parent = MainPage
SpeedResetBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
SpeedResetBtn.Position = UDim2.new(0, 174, 0, 16)
SpeedResetBtn.Size = UDim2.new(0, 102, 0, 22)
SpeedResetBtn.Font = Enum.Font.GothamBold
SpeedResetBtn.Text = "Reset Speed"
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
-- WISHHUB STEAL EGG CONTROLS
-------------------------------------------------------------------
local RaritySelectBtn = Instance.new("TextButton")
RaritySelectBtn.Parent = MainPage
RaritySelectBtn.BackgroundColor3 = Color3.fromRGB(25, 20, 35)
RaritySelectBtn.Position = UDim2.new(0, 0, 0, 48)
RaritySelectBtn.Size = UDim2.new(0, 276, 0, 26)
RaritySelectBtn.Font = Enum.Font.GothamBold
RaritySelectBtn.Text = "Rarities: [ ALL RARITIES ]"
RaritySelectBtn.TextColor3 = Color3.fromRGB(200, 160, 255)
RaritySelectBtn.TextSize = 11

local SetBaseBtn = Instance.new("TextButton")
SetBaseBtn.Parent = MainPage
SetBaseBtn.BackgroundColor3 = Color3.fromRGB(120, 40, 200)
SetBaseBtn.Position = UDim2.new(0, 0, 0, 80)
SetBaseBtn.Size = UDim2.new(0, 133, 0, 26)
SetBaseBtn.Font = Enum.Font.GothamBold
SetBaseBtn.Text = "1. Set Pen / Base"
SetBaseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SetBaseBtn.TextSize = 10

local TPBaseDirectBtn = Instance.new("TextButton")
TPBaseDirectBtn.Parent = MainPage
TPBaseDirectBtn.BackgroundColor3 = Color3.fromRGB(60, 40, 90)
TPBaseDirectBtn.Position = UDim2.new(0, 138, 0, 80)
TPBaseDirectBtn.Size = UDim2.new(0, 138, 0, 26)
TPBaseDirectBtn.Font = Enum.Font.GothamBold
TPBaseDirectBtn.Text = "TP Ke Pen/Base"
TPBaseDirectBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TPBaseDirectBtn.TextSize = 10

local DisplayEggLabel = Instance.new("TextLabel")
DisplayEggLabel.Parent = MainPage
DisplayEggLabel.BackgroundTransparency = 1
DisplayEggLabel.Position = UDim2.new(0, 0, 0, 112)
DisplayEggLabel.Size = UDim2.new(1, 0, 0, 16)
DisplayEggLabel.Font = Enum.Font.Gotham
DisplayEggLabel.Text = "Status: Nonaktif"
DisplayEggLabel.TextColor3 = Color3.fromRGB(255, 220, 100)
DisplayEggLabel.TextSize = 10
DisplayEggLabel.TextXAlignment = Enum.TextXAlignment.Left

local ToggleAutoStealBtn = Instance.new("TextButton")
ToggleAutoStealBtn.Parent = MainPage
ToggleAutoStealBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
ToggleAutoStealBtn.Position = UDim2.new(0, 0, 0, 135)
ToggleAutoStealBtn.Size = UDim2.new(0, 276, 0, 32)
ToggleAutoStealBtn.Font = Enum.Font.GothamBold
ToggleAutoStealBtn.Text = "Auto Steal: OFF"
ToggleAutoStealBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleAutoStealBtn.TextSize = 12

RaritySelectBtn.MouseButton1Click:Connect(function()
    selectedRarityIndex = selectedRarityIndex + 1
    if selectedRarityIndex > #raritiesList then selectedRarityIndex = 1 end
    RaritySelectBtn.Text = "Rarities: [ " .. raritiesList[selectedRarityIndex] .. " ]"
end)

SetBaseBtn.MouseButton1Click:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        myBasePosition = LocalPlayer.Character.HumanoidRootPart.Position
        SetBaseBtn.Text = "Pen/Base Tersimpan!"
        task.wait(1)
        SetBaseBtn.Text = "1. Set Pen / Base"
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
            DisplayEggLabel.Text = "❌ Harap Set Pen / Base Dulu!"
            isAutoStealActive = false
            return
        end
        ToggleAutoStealBtn.Text = "Auto Steal: ON"
        ToggleAutoStealBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 80)
    else
        ToggleAutoStealBtn.Text = "Auto Steal: OFF"
        ToggleAutoStealBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
        DisplayEggLabel.Text = "Status: Nonaktif"
    end
end)

-------------------------------------------------------------------
-- WISHHUB ENGINE (SMALL HOPS TELEPORT RETURN & RARITY SCANNER)
-------------------------------------------------------------------

-- Function 1: Check Rarity Match
local function MatchesSelectedRarity(obj)
    local targetRarity = raritiesList[selectedRarityIndex]
    if targetRarity == "ALL RARITIES" then return true end

    local fullStr = string.lower(obj.Name)
    
    -- Cek jika ada Attributes / Child Rarity
    for _, child in pairs(obj:GetChildren()) do
        fullStr = fullStr .. " " .. string.lower(child.Name)
        if child:IsA("StringValue") then fullStr = fullStr .. " " .. string.lower(child.Value) end
    end
    
    if obj:GetAttributes() then
        for k, v in pairs(obj:GetAttributes()) do
            fullStr = fullStr .. " " .. string.lower(tostring(k)) .. " " .. string.lower(tostring(v))
        end
    end

    return string.find(fullStr, string.lower(targetRarity)) ~= nil
end

-- Function 2: Scan Real Target Eggs & Prompts
local function GetTargetEggs()
    local resultList = {}

    for _, prompt in pairs(Workspace:GetDescendants()) do
        if prompt:IsA("ProximityPrompt") and prompt.Enabled then
            local eggContainer = prompt.Parent
            
            -- Pastikan bukan milik player lain
            local isPlayer = eggContainer:FindFirstAncestorOfClass("Model") and Players:GetPlayerFromCharacter(eggContainer:FindFirstAncestorOfClass("Model"))
            if not isPlayer then
                if MatchesSelectedRarity(eggContainer) or MatchesSelectedRarity(prompt) then
                    table.insert(resultList, {prompt = prompt, egg = eggContainer})
                end
            end
        end
    end

    return resultList
end

-- Function 3: WishHub Small Hops / Blink Back Return (Prevent Drop Egg)
local function BlinkReturnToBase(hrp, startPos, targetPos)
    local distance = (targetPos - startPos).Magnitude
    local steps = math.clamp(math.floor(distance / 25), 3, 12) -- Membagi jarak menjadi lompatan kecil cepat
    
    for i = 1, steps do
        if not isAutoStealActive then break end
        local lerpPos = startPos:Lerp(targetPos, i / steps)
        hrp.CFrame = CFrame.new(lerpPos + Vector3.new(0, 2.5, 0))
        task.wait(0.04) -- Blink cepat agar tidak kedeteksi drop egg oleh server
    end
    
    hrp.CFrame = CFrame.new(targetPos + Vector3.new(0, 3, 0))
end

-- MAIN STEAL LOOP ENGINE
task.spawn(function()
    while task.wait(0.25) do
        if isAutoStealActive and myBasePosition then
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("Humanoid") then
                local hrp = char.HumanoidRootPart
                local hum = char.Humanoid

                if hum.Health > 0 then
                    local eggTargets = GetTargetEggs()

                    if #eggTargets > 0 then
                        local targetData = eggTargets[1]
                        local prompt = targetData.prompt
                        local eggObj = targetData.egg
                        
                        local targetCFrame = eggObj:IsA("BasePart") and eggObj.CFrame or (eggObj:IsA("Model") and eggObj:GetPivot() or hrp.CFrame)

                        DisplayEggLabel.Text = "Teleporting: " .. eggObj.Name
                        
                        -- 1. Teleport ke Egg
                        hrp.CFrame = targetCFrame + Vector3.new(0, 3.2, 0)
                        task.wait(0.15)

                        -- 2. Steal Egg (Fire Prompt)
                        DisplayEggLabel.Text = "Grabbing Egg..."
                        if fireproximityprompt then
                            fireproximityprompt(prompt)
                        end
                        
                        if prompt.HoldDuration > 0 then
                            if prompt.InputHoldBegin then prompt:InputHoldBegin() end
                            task.wait(prompt.HoldDuration)
                            if prompt.InputHoldEnd then prompt:InputHoldEnd() end
                        end

                        task.wait(0.2)

                        -- 3. Blink Return Back to Pen/Base (WishHub Style - Anti Egg Drop)
                        DisplayEggLabel.Text = "Returning to Pen..."
                        BlinkReturnToBase(hrp, hrp.Position, myBasePosition)
                        
                        task.wait(0.5) -- Deposit Time
                    else
                        DisplayEggLabel.Text = "Mencari Egg [" .. raritiesList[selectedRarityIndex] .. "]..."
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

-- TAB SWITCH
MainTabBtn.MouseButton1Click:Connect(function()
    MainPage.Visible = true; InfoPage.Visible = false
    MainTabBtn.BackgroundColor3 = Color3.fromRGB(120, 40, 200)
    InfoTabBtn.BackgroundColor3 = Color3.fromRGB(30, 25, 35)
end)

InfoTabBtn.MouseButton1Click:Connect(function()
    MainPage.Visible = false; InfoPage.Visible = true
    InfoTabBtn.BackgroundColor3 = Color3.fromRGB(120, 40, 200)
    MainTabBtn.BackgroundColor3 = Color3.fromRGB(30, 25, 35)
end)
