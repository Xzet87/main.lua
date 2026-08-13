-- [[ EXZET HUB - ULTIMATE FLEXIBLE EGG STEALER ]] --

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
local selectedTarget = "All" -- Bisa All, Egg 1, Egg 2, dll

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
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -190)
MainFrame.Size = UDim2.new(0, 450, 0, 380)
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
Title.Size = UDim2.new(0, 280, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "Exzet Hub - Flexible Stealer Fix"
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
SpeedLabel.Text = "Kecepatan Jalan (Permanent No-Reset):"
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
-- SELECTOR TARGET EGG (FLEXIBLE)
-------------------------------------------------------------------
local targets = {"All", "Area 1", "Area 2", "Area 3", "Area 4"}
local currentIndex = 1

local TargetBtn = Instance.new("TextButton")
TargetBtn.Parent = MainPage
TargetBtn.BackgroundColor3 = Color3.fromRGB(40, 50, 70)
TargetBtn.Position = UDim2.new(0, 0, 0, 48)
TargetBtn.Size = UDim2.new(0, 276, 0, 26)
TargetBtn.Font = Enum.Font.GothamBold
TargetBtn.Text = "Target Filter: [ All Eggs ] (Klik Ganti)"
TargetBtn.TextColor3 = Color3.fromRGB(0, 230, 255)
TargetBtn.TextSize = 10

local TPEggPlaceBtn = Instance.new("TextButton")
TPEggPlaceBtn.Parent = MainPage
TPEggPlaceBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 180)
TPEggPlaceBtn.Position = UDim2.new(0, 0, 0, 78)
TPEggPlaceBtn.Size = UDim2.new(0, 276, 0, 26)
TPEggPlaceBtn.Font = Enum.Font.GothamBold
TPEggPlaceBtn.Text = "TP Ke Lokasi Egg Terdekat"
TPEggPlaceBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TPEggPlaceBtn.TextSize = 10

TargetBtn.MouseButton1Click:Connect(function()
    currentIndex = currentIndex + 1
    if currentIndex > #targets then
        currentIndex = 1
    end
    selectedTarget = targets[currentIndex]
    TargetBtn.Text = "Target Filter: [ " .. selectedTarget .. " ] (Klik Ganti)"
end)

-------------------------------------------------------------------
-- STEAL EGG CONTROLS & BASE SETUP
-------------------------------------------------------------------
local SetBaseBtn = Instance.new("TextButton")
SetBaseBtn.Parent = MainPage
SetBaseBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
SetBaseBtn.Position = UDim2.new(0, 0, 0, 110)
SetBaseBtn.Size = UDim2.new(0, 133, 0, 26)
SetBaseBtn.Font = Enum.Font.GothamBold
SetBaseBtn.Text = "1. Set Posisi Base"
SetBaseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SetBaseBtn.TextSize = 10

local TPBaseDirectBtn = Instance.new("TextButton")
TPBaseDirectBtn.Parent = MainPage
TPBaseDirectBtn.BackgroundColor3 = Color3.fromRGB(150, 50, 0)
TPBaseDirectBtn.Position = UDim2.new(0, 138, 0, 110)
TPBaseDirectBtn.Size = UDim2.new(0, 138, 0, 26)
TPBaseDirectBtn.Font = Enum.Font.GothamBold
TPBaseDirectBtn.Text = "TP Ke Base"
TPBaseDirectBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TPBaseDirectBtn.TextSize = 10

local DisplayEggLabel = Instance.new("TextLabel")
DisplayEggLabel.Parent = MainPage
DisplayEggLabel.BackgroundTransparency = 1
DisplayEggLabel.Position = UDim2.new(0, 0, 0, 142)
DisplayEggLabel.Size = UDim2.new(1, 0, 0, 16)
DisplayEggLabel.Font = Enum.Font.Gotham
DisplayEggLabel.Text = "Status: Nonaktif"
DisplayEggLabel.TextColor3 = Color3.fromRGB(255, 220, 100)
DisplayEggLabel.TextSize = 10
DisplayEggLabel.TextXAlignment = Enum.TextXAlignment.Left

local ToggleAutoStealBtn = Instance.new("TextButton")
ToggleAutoStealBtn.Parent = MainPage
ToggleAutoStealBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ToggleAutoStealBtn.Position = UDim2.new(0, 0, 0, 164)
ToggleAutoStealBtn.Size = UDim2.new(0, 276, 0, 32)
ToggleAutoStealBtn.Font = Enum.Font.GothamBold
ToggleAutoStealBtn.Text = "AUTO STEAL & RETURN: OFF"
ToggleAutoStealBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleAutoStealBtn.TextSize = 10

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
        ToggleAutoStealBtn.Text = "AUTO STEAL & RETURN: ON"
        ToggleAutoStealBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
    else
        ToggleAutoStealBtn.Text = "AUTO STEAL & RETURN: OFF"
        ToggleAutoStealBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        DisplayEggLabel.Text = "Status: Nonaktif"
    end
end)

-------------------------------------------------------------------
-- FLEXIBLE EGG DETECTOR (PILIH SEMUA SMARTPROMPT STEAL EGG)
-------------------------------------------------------------------
local function GetValidStealableEggs()
    local validEggs = {}

    for _, prompt in pairs(Workspace:GetDescendants()) do
        if prompt:IsA("ProximityPrompt") and prompt.Enabled then
            local actionText = string.lower(prompt.ActionText or "")
            local objectText = string.lower(prompt.ObjectText or "")
            local parentName = string.lower(prompt.Parent.Name or "")

            -- Deteksi utama berdasarkan SmartPromptPart atau aksi Steal/Egg
            local isSteal = string.find(actionText, "steal")
            local isEggObj = string.find(objectText, "egg") or string.find(parentName, "smartpromptpart")

            if isSteal and isEggObj then
                -- Pastikan bukan milik pemain lain
                local charAncestor = prompt:FindFirstAncestorOfClass("Model")
                if not (charAncestor and Players:GetPlayerFromCharacter(charAncestor)) then
                    
                    -- Jika menggunakan filter area (misal Area 1, Area 2, dll)
                    local passArea = true
                    if selectedTarget ~= "All" then
                        local ancestorName = string.lower(prompt:GetFullName())
                        local areaNum = string.match(selectedTarget, "%d+")
                        if areaNum and not string.find(ancestorName, "area" .. areaNum) and not string.find(ancestorName, "zone" .. areaNum) then
                            passArea = false
                        end
                    end

                    if passArea then
                        table.insert(validEggs, prompt)
                    end
                end
            end
        end
    end

    return validEggs
end

-- Tombol Manual Teleport Ke Egg
TPEggPlaceBtn.MouseButton1Click:Connect(function()
    local eggs = GetValidStealableEggs()
    if #eggs > 0 then
        local targetPrompt = eggs[1]
        local targetPart = targetPrompt.Parent
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local targetCFrame = targetPart:IsA("BasePart") and targetPart.CFrame or (targetPart:IsA("Model") and targetPart:GetPivot() or LocalPlayer.Character.HumanoidRootPart.CFrame)
            LocalPlayer.Character.HumanoidRootPart.CFrame = targetCFrame + Vector3.new(0, 3, 0)
            DisplayEggLabel.Text = "Berhasil TP ke Egg!"
        end
    else
        DisplayEggLabel.Text = "Telur tidak ditemukan di area ini!"
    end
end)

-------------------------------------------------------------------
-- 100% GUARANTEED STEAL ENGINE (DENGAN KONFIRMASI)
-------------------------------------------------------------------
local function Execute100PercentSteal(prompt)
    if not prompt or not prompt.Parent or not prompt.Enabled then return false end
    local char = LocalPlayer.Character
    if not char then return false end

    DisplayEggLabel.Text = "Mencuri Telur... (Menunggu Masuk)"
    local holdDuration = prompt.HoldDuration > 0 and prompt.HoldDuration or 0.2
    local startTime = tick()
    local isSuccess = false

    while (tick() - startTime) < (holdDuration + 2.5) do
        if not isAutoStealActive then break end

        if fireproximityprompt then
            fireproximityprompt(prompt)
        end

        if prompt.InputHoldBegin then
            prompt:InputHoldBegin()
            task.wait(holdDuration + 0.1)
            prompt:InputHoldEnd()
        else
            task.wait(0.1)
        end

        -- Cek apakah telur sudah masuk inventory/dipegang atau prompt sudah nonaktif
        local holdingTool = char:FindFirstChildOfClass("Tool")
        if holdingTool or not prompt.Parent or not prompt.Enabled then
            isSuccess = true
            break
        end

        task.wait(0.1)
    end

    task.wait(0.2)
    return isSuccess
end

-------------------------------------------------------------------
-- MAIN LOOP (AUTO STEAL + RETURN TO BASE)
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
                        local targetCFrame = targetPart:IsA("BasePart") and targetPart.CFrame or (targetPart:IsA("Model") and targetPart:GetPivot() or hrp.CFrame)

                        -- 1. Teleport ke Telur
                        hrp.CFrame = targetCFrame + Vector3.new(0, 3, 0)
                        task.wait(0.15)

                        -- 2. Steal 100% Pasti Masuk
                        local stoleSuccessfully = Execute100PercentSteal(selectedPrompt)

                        -- 3. Teleport Balik Ke Base Begitu Sukses
                        if stoleSuccessfully then
                            DisplayEggLabel.Text = "Telur Aman! Pulang ke Base..."
                            hrp.CFrame = CFrame.new(myBasePosition + Vector3.new(0, 3, 0))
                            task.wait(0.8)
                            DisplayEggLabel.Text = "Sukses Menyimpan Telur!"
                        end
                    else
                        DisplayEggLabel.Text = "Mencari Telur (" .. selectedTarget .. ")..."
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
