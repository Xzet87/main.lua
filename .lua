-- [[ EXZET HUB - FIXED UI & ADVANCED EGG SCANNER ]] --

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

-- State Variables
local defaultSpeed = 16
local customSpeed = 16
local isSpeedActive = false
local isAutoEggActive = false
local myBasePosition = nil

-- Data Scan Telur
local scannedEggsList = {}
local selectedEggIndex = 1

-- Hapus UI lama jika ada
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
MainFrame.BackgroundTransparency = 0.15
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -170)
MainFrame.Size = UDim2.new(0, 450, 0, 350)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = false

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

-- TOPBAR / HEADER
local Topbar = Instance.new("Frame")
Topbar.Name = "Topbar"
Topbar.Parent = MainFrame
Topbar.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Topbar.BackgroundTransparency = 0.3
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
Title.Text = "Exzet Hub"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left

-- TOMBOL MINIMIZE (-) & CLOSE (X)
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

-- LOGIK TOMBOL MINIMIZE & CLOSE
local isMinimized = false
MinimizeBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        MainFrame:TweenSize(UDim2.new(0, 450, 0, 38), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.3, true)
    else
        MainFrame:TweenSize(UDim2.new(0, 450, 0, 350), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.3, true)
    end
end)

CloseBtn.MouseButton1Click:Connect(function()
    ExzetHubUI:Destroy()
    StarterGui:SetCore("SendNotification", {
        Title = "Exzet Hub",
        Text = "UI Ditutup! Silakan re-execute script untuk memunculkan kembali.",
        Duration = 5
    })
end)

-- TAB NAVIGATION
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

-- CONTENT CONTAINER
local ContentContainer = Instance.new("Frame")
ContentContainer.Parent = MainFrame
ContentContainer.BackgroundTransparency = 1
ContentContainer.Position = UDim2.new(0, 115, 0, 45)
ContentContainer.Size = UDim2.new(1, -125, 1, -50)

-- PAGE 1: INFO
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

-- PAGE 2: MAIN
local MainPage = Instance.new("Frame")
MainPage.Parent = ContentContainer
MainPage.BackgroundTransparency = 1
MainPage.Size = UDim2.new(1, 0, 1, 0)
MainPage.Visible = false

-- FITUR SPEED + TOMBOL RESET SPEED
local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Parent = MainPage
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Position = UDim2.new(0, 0, 0, 0)
SpeedLabel.Size = UDim2.new(1, 0, 0, 18)
SpeedLabel.Font = Enum.Font.GothamBold
SpeedLabel.Text = "Speed Bypass:"
SpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedLabel.TextSize = 12
SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left

local SpeedInput = Instance.new("TextBox")
SpeedInput.Parent = MainPage
SpeedInput.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
SpeedInput.Position = UDim2.new(0, 0, 0, 20)
SpeedInput.Size = UDim2.new(0, 90, 0, 25)
SpeedInput.Font = Enum.Font.Gotham
SpeedInput.PlaceholderText = "16"
SpeedInput.Text = ""
SpeedInput.TextColor3 = Color3.fromRGB(255, 255, 255)

local SpeedApplyBtn = Instance.new("TextButton")
SpeedApplyBtn.Parent = MainPage
SpeedApplyBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
SpeedApplyBtn.Position = UDim2.new(0, 96, 0, 20)
SpeedApplyBtn.Size = UDim2.new(0, 75, 0, 25)
SpeedApplyBtn.Font = Enum.Font.GothamBold
SpeedApplyBtn.Text = "Set Speed"
SpeedApplyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedApplyBtn.TextSize = 11

local SpeedResetBtn = Instance.new("TextButton")
SpeedResetBtn.Parent = MainPage
SpeedResetBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
SpeedResetBtn.Position = UDim2.new(0, 176, 0, 20)
SpeedResetBtn.Size = UDim2.new(0, 102, 0, 25)
SpeedResetBtn.Font = Enum.Font.GothamBold
SpeedResetBtn.Text = "Reset Speed"
SpeedResetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedResetBtn.TextSize = 11

local ResetCorner = Instance.new("UICorner")
ResetCorner.CornerRadius = UDim.new(0, 4)
ResetCorner.Parent = SpeedResetBtn

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
-- STEAL AN EGG - AUTOMATIC SCANNER ENGINE
-------------------------------------------------------------------
local EggLabel = Instance.new("TextLabel")
EggLabel.Parent = MainPage
EggLabel.BackgroundTransparency = 1
EggLabel.Position = UDim2.new(0, 0, 0, 55)
EggLabel.Size = UDim2.new(1, 0, 0, 18)
EggLabel.Font = Enum.Font.GothamBold
EggLabel.Text = "Steal An Egg Engine:"
EggLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
EggLabel.TextSize = 12
EggLabel.TextXAlignment = Enum.TextXAlignment.Left

-- 1. Tombol Simpan Base
local SetBaseBtn = Instance.new("TextButton")
SetBaseBtn.Parent = MainPage
SetBaseBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
SetBaseBtn.Position = UDim2.new(0, 0, 0, 78)
SetBaseBtn.Size = UDim2.new(0, 130, 0, 28)
SetBaseBtn.Font = Enum.Font.GothamBold
SetBaseBtn.Text = "1. Simpan Base"
SetBaseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SetBaseBtn.TextSize = 11

local BaseCorner = Instance.new("UICorner")
BaseCorner.CornerRadius = UDim.new(0, 6)
BaseCorner.Parent = SetBaseBtn

SetBaseBtn.MouseButton1Click:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        myBasePosition = LocalPlayer.Character.HumanoidRootPart.Position
        SetBaseBtn.Text = "Base Tersimpan!"
        task.wait(1.2)
        SetBaseBtn.Text = "1. Simpan Base"
    end
end)

-- 2. Tombol Scan Workspace Telur
local ScanBtn = Instance.new("TextButton")
ScanBtn.Parent = MainPage
ScanBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
ScanBtn.Position = UDim2.new(0, 138, 0, 78)
ScanBtn.Size = UDim2.new(0, 140, 0, 28)
ScanBtn.Font = Enum.Font.GothamBold
ScanBtn.Text = "2. Pindai Telur (Scan)"
ScanBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ScanBtn.TextSize = 11

local ScanCorner = Instance.new("UICorner")
ScanCorner.CornerRadius = UDim.new(0, 6)
ScanCorner.Parent = ScanBtn

-- Label Target Egg
local DisplayEggLabel = Instance.new("TextLabel")
DisplayEggLabel.Parent = MainPage
DisplayEggLabel.BackgroundTransparency = 1
DisplayEggLabel.Position = UDim2.new(0, 0, 0, 112)
DisplayEggLabel.Size = UDim2.new(1, 0, 0, 18)
DisplayEggLabel.Font = Enum.Font.Gotham
DisplayEggLabel.Text = "Target: [ Belum Dipindai ]"
DisplayEggLabel.TextColor3 = Color3.fromRGB(255, 220, 100)
DisplayEggLabel.TextSize = 11
DisplayEggLabel.TextXAlignment = Enum.TextXAlignment.Left

-- 3. Tombol Pilih / Switch Target Telur
local SelectTargetBtn = Instance.new("TextButton")
SelectTargetBtn.Parent = MainPage
SelectTargetBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
SelectTargetBtn.Position = UDim2.new(0, 0, 0, 133)
SelectTargetBtn.Size = UDim2.new(0, 278, 0, 28)
SelectTargetBtn.Font = Enum.Font.GothamBold
SelectTargetBtn.Text = "Ganti Target Telur (Klik)"
SelectTargetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SelectTargetBtn.TextSize = 11

local SelCorner = Instance.new("UICorner")
SelCorner.CornerRadius = UDim.new(0, 6)
SelCorner.Parent = SelectTargetBtn

-- 4. Tombol Auto Egg Toggle
local ToggleEggBtn = Instance.new("TextButton")
ToggleEggBtn.Parent = MainPage
ToggleEggBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ToggleEggBtn.Position = UDim2.new(0, 0, 0, 168)
ToggleEggBtn.Size = UDim2.new(0, 278, 0, 32)
ToggleEggBtn.Font = Enum.Font.GothamBold
ToggleEggBtn.Text = "3. Auto Egg Teleport: OFF"
ToggleEggBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleEggBtn.TextSize = 12

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 6)
ToggleCorner.Parent = ToggleEggBtn

-------------------------------------------------------------------
-- LOGIKA PEMINDAIAN & SCANNER
-------------------------------------------------------------------
local function ScanWorkspaceForEggs()
    scannedEggsList = {}
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("Model") or obj:IsA("BasePart") then
            local n = string.lower(obj.Name)
            local pN = string.lower(obj.Parent.Name)
            
            if (string.find(n, "egg") or string.find(n, "spawn") or string.find(pN, "egg")) and not string.find(pN, "ui") then
                table.insert(scannedEggsList, obj)
            end
        end
    end
    
    if #scannedEggsList > 0 then
        selectedEggIndex = 1
        DisplayEggLabel.Text = "Target (#1/" .. #scannedEggsList .. "): " .. scannedEggsList[1].Name
    else
        DisplayEggLabel.Text = "Target: [ Tidak Ada Telur Ditemukan ]"
    end
end

ScanBtn.MouseButton1Click:Connect(function()
    ScanWorkspaceForEggs()
    ScanBtn.Text = "Dipindai (" .. #scannedEggsList .. ")"
    task.wait(1)
    ScanBtn.Text = "2. Pindai Telur (Scan)"
end)

SelectTargetBtn.MouseButton1Click:Connect(function()
    if #scannedEggsList > 0 then
        selectedEggIndex = selectedEggIndex + 1
        if selectedEggIndex > #scannedEggsList then
            selectedEggIndex = 1
        end
        local currentObj = scannedEggsList[selectedEggIndex]
        if currentObj and currentObj.Parent then
            DisplayEggLabel.Text = "Target (#" .. selectedEggIndex .. "/" .. #scannedEggsList .. "): " .. currentObj.Name
        else
            ScanWorkspaceForEggs()
        end
    else
        ScanWorkspaceForEggs()
    end
end)

ToggleEggBtn.MouseButton1Click:Connect(function()
    isAutoEggActive = not isAutoEggActive
    if isAutoEggActive then
        ToggleEggBtn.Text = "3. Auto Egg Teleport: ON"
        ToggleEggBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
    else
        ToggleEggBtn.Text = "3. Auto Egg Teleport: OFF"
        ToggleEggBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    end
end)

-------------------------------------------------------------------
-- LOOP TELEPORT AUTO EGG
-------------------------------------------------------------------
task.spawn(function()
    while task.wait(0.6) do
        if isAutoEggActive then
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local hrp = char.HumanoidRootPart
                
                if #scannedEggsList == 0 then
                    ScanWorkspaceForEggs()
                end
                
                local targetEgg = scannedEggsList[selectedEggIndex]
                
                if targetEgg and targetEgg.Parent then
                    local targetCFrame = nil
                    
                    if targetEgg:IsA("BasePart") then
                        targetCFrame = targetEgg.CFrame
                    elseif targetEgg:IsA("Model") and targetEgg.PrimaryPart then
                        targetCFrame = targetEgg.PrimaryPart.CFrame
                    elseif targetEgg:IsA("Model") and targetEgg:FindFirstChildWhichIsA("BasePart") then
                        targetCFrame = targetEgg:FindFirstChildWhichIsA("BasePart").CFrame
                    end
                    
                    if targetCFrame then
                        -- 1. Teleport ke Telur
                        hrp.CFrame = targetCFrame + Vector3.new(0, 2, 0)
                        
                        for _, child in pairs(targetEgg:GetDescendants()) do
                            if child:IsA("ProximityPrompt") then
                                fireproximityprompt(child)
                            end
                        end
                        
                        task.wait(0.4)
                        
                        -- 2. Teleport Balik Ke Base
                        if myBasePosition and isAutoEggActive then
                            hrp.CFrame = CFrame.new(myBasePosition + Vector3.new(0, 3, 0))
                            task.wait(0.4)
                        end
                    end
                else
                    ScanWorkspaceForEggs()
                end
            end
        end
    end
end)

-------------------------------------------------------------------
-- SPEED BYPASS ENGINE & TAB SWITCHING
-------------------------------------------------------------------
RunService.Heartbeat:Connect(function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("Humanoid") then
        if isSpeedActive and char.Humanoid.MoveDirection.Magnitude > 0 then
            local moveDir = char.Humanoid.MoveDirection
            char.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(
                moveDir.X * customSpeed,
                char.HumanoidRootPart.AssemblyLinearVelocity.Y,
                moveDir.Z * customSpeed
            )
        end
    end
end)

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
