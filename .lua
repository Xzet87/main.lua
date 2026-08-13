-- [[ EXZET HUB V4 - PLACE / ZONE EGG FINDER + AUTO COLLECT + PERMANENT SPEED ]] --

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

-- Global State
local customSpeed = 16
local defaultSpeed = 16
local isSpeedActive = false

local isAutoCollectActive = false
local myBasePosition = nil
local scannedEggsList = {}
local filteredEggsList = {}

-- Daftar Pilihan Zona / Tempat
local zonesList = {"ALL Zones", "Zone 1 / Spawn", "Zone 2", "Zone 3", "Zone 4", "Secret / Island"}
local selectedZoneIndex = 1

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
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -165)
MainFrame.Size = UDim2.new(0, 450, 0, 330)
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
Title.Size = UDim2.new(0, 200, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "Exzet Hub - Zone Collector"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 15
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
-- SPEED BYPASS (PERMANENT ENGINE)
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
-- PLACE / ZONE FILTER + AUTO COLLECT
-------------------------------------------------------------------
local ZoneSelectBtn = Instance.new("TextButton")
ZoneSelectBtn.Parent = MainPage
ZoneSelectBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
ZoneSelectBtn.Position = UDim2.new(0, 0, 0, 48)
ZoneSelectBtn.Size = UDim2.new(0, 276, 0, 25)
ZoneSelectBtn.Font = Enum.Font.GothamBold
ZoneSelectBtn.Text = "Lokasi Egg: [ ALL Zones ]"
ZoneSelectBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ZoneSelectBtn.TextSize = 11

local SetBaseBtn = Instance.new("TextButton")
SetBaseBtn.Parent = MainPage
SetBaseBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
SetBaseBtn.Position = UDim2.new(0, 0, 0, 78)
SetBaseBtn.Size = UDim2.new(0, 133, 0, 25)
SetBaseBtn.Font = Enum.Font.GothamBold
SetBaseBtn.Text = "1. Set Posisi Base"
SetBaseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SetBaseBtn.TextSize = 10

local TPBaseDirectBtn = Instance.new("TextButton")
TPBaseDirectBtn.Parent = MainPage
TPBaseDirectBtn.BackgroundColor3 = Color3.fromRGB(150, 50, 0)
TPBaseDirectBtn.Position = UDim2.new(0, 138, 0, 78)
TPBaseDirectBtn.Size = UDim2.new(0, 138, 0, 25)
TPBaseDirectBtn.Font = Enum.Font.GothamBold
TPBaseDirectBtn.Text = "TP Ke Base"
TPBaseDirectBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TPBaseDirectBtn.TextSize = 10

local DisplayEggLabel = Instance.new("TextLabel")
DisplayEggLabel.Parent = MainPage
DisplayEggLabel.BackgroundTransparency = 1
DisplayEggLabel.Position = UDim2.new(0, 0, 0, 108)
DisplayEggLabel.Size = UDim2.new(1, 0, 0, 16)
DisplayEggLabel.Font = Enum.Font.Gotham
DisplayEggLabel.Text = "Status: Auto Collect Nonaktif"
DisplayEggLabel.TextColor3 = Color3.fromRGB(255, 220, 100)
DisplayEggLabel.TextSize = 10
DisplayEggLabel.TextXAlignment = Enum.TextXAlignment.Left

local ToggleAutoCollectBtn = Instance.new("TextButton")
ToggleAutoCollectBtn.Parent = MainPage
ToggleAutoCollectBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ToggleAutoCollectBtn.Position = UDim2.new(0, 0, 0, 130)
ToggleAutoCollectBtn.Size = UDim2.new(0, 276, 0, 32)
ToggleAutoCollectBtn.Font = Enum.Font.GothamBold
ToggleAutoCollectBtn.Text = "AUTO COLLECT LOKASI INI: OFF"
ToggleAutoCollectBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleAutoCollectBtn.TextSize = 11

-------------------------------------------------------------------
-- SCANNER LOGIC BERDASARKAN LOKASI / PLACE
-------------------------------------------------------------------
local function ScanAndFilterByZone()
    scannedEggsList = {}
    filteredEggsList = {}
    local currentZoneFilter = zonesList[selectedZoneIndex]

    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("Model") or obj:IsA("BasePart") then
            local n = string.lower(obj.Name)
            local pN = string.lower(obj.Parent.Name)
            local gpN = string.lower(obj.Parent.Parent and obj.Parent.Parent.Name or "")

            -- Deteksi bahwa objek adalah Egg / Spawn Point Telur
            if (string.find(n, "egg") or string.find(n, "spawn") or string.find(pN, "egg")) and not string.find(pN, "ui") then
                table.insert(scannedEggsList, obj)

                if currentZoneFilter == "ALL Zones" then
                    table.insert(filteredEggsList, obj)
                else
                    -- Filter lokasi berdasarkan nama folder / area tempat egg berada
                    local zoneKeyword = ""
                    if currentZoneFilter == "Zone 1 / Spawn" then zoneKeyword = "zone1"
                    elseif currentZoneFilter == "Zone 2" then zoneKeyword = "zone2"
                    elseif currentZoneFilter == "Zone 3" then zoneKeyword = "zone3"
                    elseif currentZoneFilter == "Zone 4" then zoneKeyword = "zone4"
                    elseif currentZoneFilter == "Secret / Island" then zoneKeyword = "secret" end

                    if string.find(n, zoneKeyword) or string.find(pN, zoneKeyword) or string.find(gpN, zoneKeyword) then
                        table.insert(filteredEggsList, obj)
                    elseif currentZoneFilter == "Zone 1 / Spawn" and (string.find(pN, "spawn") or string.find(gpN, "spawn")) then
                        table.insert(filteredEggsList, obj)
                    end
                end
            end
        end
    end
    
    -- Jika di zona spesifik tidak ada kata kunci khusus, tampilkan semua egg terdekat dari zona tersebut
    if #filteredEggsList == 0 and currentZoneFilter ~= "ALL Zones" then
        filteredEggsList = scannedEggsList
    end
end

ZoneSelectBtn.MouseButton1Click:Connect(function()
    selectedZoneIndex = selectedZoneIndex + 1
    if selectedZoneIndex > #zonesList then selectedZoneIndex = 1 end
    ZoneSelectBtn.Text = "Lokasi Egg: [ " .. zonesList[selectedZoneIndex] .. " ]"
    ScanAndFilterByZone()
end)

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

ToggleAutoCollectBtn.MouseButton1Click:Connect(function()
    isAutoCollectActive = not isAutoCollectActive
    if isAutoCollectActive then
        ToggleAutoCollectBtn.Text = "AUTO COLLECT LOKASI INI: ON"
        ToggleAutoCollectBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
    else
        ToggleAutoCollectBtn.Text = "AUTO COLLECT LOKASI INI: OFF"
        ToggleAutoCollectBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        DisplayEggLabel.Text = "Status: Auto Collect Nonaktif"
    end
end)

-- AUTO COLLECT MAIN LOOP ENGINE
task.spawn(function()
    while task.wait(0.35) do
        if isAutoCollectActive then
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local hrp = char.HumanoidRootPart
                ScanAndFilterByZone()

                if #filteredEggsList > 0 then
                    local targetEgg = filteredEggsList[1]
                    DisplayEggLabel.Text = "Sedang Ambil: " .. targetEgg.Name .. " [" .. zonesList[selectedZoneIndex] .. "]"

                    local targetCFrame = nil
                    if targetEgg:IsA("BasePart") then targetCFrame = targetEgg.CFrame
                    elseif targetEgg:IsA("Model") and targetEgg.PrimaryPart then targetCFrame = targetEgg.PrimaryPart.CFrame
                    elseif targetEgg:IsA("Model") and targetEgg:FindFirstChildWhichIsA("BasePart") then targetCFrame = targetEgg:FindFirstChildWhichIsA("BasePart").CFrame end

                    if targetCFrame then
                        -- 1. Teleport ke Telur
                        hrp.CFrame = targetCFrame + Vector3.new(0, 2.5, 0)

                        -- 2. Ambil Egg (Tekan ProximityPrompt / E)
                        for _, prompt in pairs(targetEgg:GetDescendants()) do
                            if prompt:IsA("ProximityPrompt") then
                                fireproximityprompt(prompt)
                            end
                        end
                        task.wait(0.3)

                        -- 3. Teleport Langsung Balik ke Base
                        if myBasePosition and isAutoCollectActive then
                            hrp.CFrame = CFrame.new(myBasePosition + Vector3.new(0, 3, 0))
                            task.wait(0.35)
                        end
                    end
                else
                    DisplayEggLabel.Text = "Mencari Egg di " .. zonesList[selectedZoneIndex] .. "..."
                end
            end
        end
    end
end)

-------------------------------------------------------------------
-- PERMANENT SPEED BYPASS (PERSISTENT ON DEATH)
-------------------------------------------------------------------
RunService.Heartbeat:Connect(function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("Humanoid") then
        local hum = char.Humanoid
        local hrp = char.HumanoidRootPart

        if isSpeedActive and hum.MoveDirection.Magnitude > 0 then
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
