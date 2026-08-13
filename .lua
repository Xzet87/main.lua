-- [[ EXZET HUB - FIXED MINIMIZE "XZ" & ANTI-RUBBERBAND SPEED ]] --

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
local defaultJump = 50
local customJump = 50
local isJumpActive = false

local isAutoEggActive = false
local myBasePosition = nil
local scannedEggsList = {}
local selectedEggIndex = 1

-- Destroy Old UI
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
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -160)
MainFrame.Size = UDim2.new(0, 450, 0, 320)
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

-- TOPBAR / HEADER
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

-- LOGIKA TOGGLE MINIMIZE & RESTORE ("XZ")
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
    StarterGui:SetCore("SendNotification", {
        Title = "Exzet Hub",
        Text = "UI Ditutup! Silakan re-execute jika ingin membuka kembali.",
        Duration = 4
    })
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

-------------------------------------------------------------------
-- FITUR SPEED BYPASS (ANTI-RUBBERBAND / ANTI MUNDUR)
-------------------------------------------------------------------
local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Parent = MainPage
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Position = UDim2.new(0, 0, 0, 0)
SpeedLabel.Size = UDim2.new(1, 0, 0, 16)
SpeedLabel.Font = Enum.Font.GothamBold
SpeedLabel.Text = "Kecepatan Jalan (Speed Bypass):"
SpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedLabel.TextSize = 11
SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left

local SpeedInput = Instance.new("TextBox")
SpeedInput.Parent = MainPage
SpeedInput.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
SpeedInput.Position = UDim2.new(0, 0, 0, 18)
SpeedInput.Size = UDim2.new(0, 90, 0, 24)
SpeedInput.Font = Enum.Font.Gotham
SpeedInput.PlaceholderText = "300"
SpeedInput.Text = ""
SpeedInput.TextColor3 = Color3.fromRGB(255, 255, 255)

local SpeedApplyBtn = Instance.new("TextButton")
SpeedApplyBtn.Parent = MainPage
SpeedApplyBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
SpeedApplyBtn.Position = UDim2.new(0, 95, 0, 18)
SpeedApplyBtn.Size = UDim2.new(0, 75, 0, 24)
SpeedApplyBtn.Font = Enum.Font.GothamBold
SpeedApplyBtn.Text = "Set Speed"
SpeedApplyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedApplyBtn.TextSize = 10

local SpeedResetBtn = Instance.new("TextButton")
SpeedResetBtn.Parent = MainPage
SpeedResetBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
SpeedResetBtn.Position = UDim2.new(0, 174, 0, 18)
SpeedResetBtn.Size = UDim2.new(0, 102, 0, 24)
SpeedResetBtn.Font = Enum.Font.GothamBold
SpeedResetBtn.Text = "Reset Speed"
SpeedResetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedResetBtn.TextSize = 10

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
-- JUMP HEIGHT
-------------------------------------------------------------------
local JumpLabel = Instance.new("TextLabel")
JumpLabel.Parent = MainPage
JumpLabel.BackgroundTransparency = 1
JumpLabel.Position = UDim2.new(0, 0, 0, 46)
JumpLabel.Size = UDim2.new(1, 0, 0, 16)
JumpLabel.Font = Enum.Font.GothamBold
JumpLabel.Text = "Tinggi Lompatan (JumpHeight):"
JumpLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
JumpLabel.TextSize = 11
JumpLabel.TextXAlignment = Enum.TextXAlignment.Left

local JumpInput = Instance.new("TextBox")
JumpInput.Parent = MainPage
JumpInput.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
JumpInput.Position = UDim2.new(0, 0, 0, 64)
JumpInput.Size = UDim2.new(0, 90, 0, 24)
JumpInput.Font = Enum.Font.Gotham
JumpInput.PlaceholderText = "Default: 50"
JumpInput.Text = ""
JumpInput.TextColor3 = Color3.fromRGB(255, 255, 255)

local JumpApplyBtn = Instance.new("TextButton")
JumpApplyBtn.Parent = MainPage
JumpApplyBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
JumpApplyBtn.Position = UDim2.new(0, 95, 0, 64)
JumpApplyBtn.Size = UDim2.new(0, 75, 0, 24)
JumpApplyBtn.Font = Enum.Font.GothamBold
JumpApplyBtn.Text = "Set Jump"
JumpApplyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
JumpApplyBtn.TextSize = 10

local JumpResetBtn = Instance.new("TextButton")
JumpResetBtn.Parent = MainPage
JumpResetBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
JumpResetBtn.Position = UDim2.new(0, 174, 0, 64)
JumpResetBtn.Size = UDim2.new(0, 102, 0, 24)
JumpResetBtn.Font = Enum.Font.GothamBold
JumpResetBtn.Text = "Reset Jump"
JumpResetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
JumpResetBtn.TextSize = 10

JumpApplyBtn.MouseButton1Click:Connect(function()
    local num = tonumber(JumpInput.Text)
    if num then customJump = num; isJumpActive = true end
end)

JumpResetBtn.MouseButton1Click:Connect(function()
    isJumpActive = false
    JumpInput.Text = ""
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.JumpPower = 50
        LocalPlayer.Character.Humanoid.JumpHeight = 7.2
    end
end)

-------------------------------------------------------------------
-- STEAL AN EGG & TELEPORT ENGINE
-------------------------------------------------------------------
local SetBaseBtn = Instance.new("TextButton")
SetBaseBtn.Parent = MainPage
SetBaseBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
SetBaseBtn.Position = UDim2.new(0, 0, 0, 95)
SetBaseBtn.Size = UDim2.new(0, 130, 0, 26)
SetBaseBtn.Font = Enum.Font.GothamBold
SetBaseBtn.Text = "1. Simpan Base"
SetBaseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SetBaseBtn.TextSize = 10

local ScanBtn = Instance.new("TextButton")
ScanBtn.Parent = MainPage
ScanBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
ScanBtn.Position = UDim2.new(0, 136, 0, 95)
ScanBtn.Size = UDim2.new(0, 140, 0, 26)
ScanBtn.Font = Enum.Font.GothamBold
ScanBtn.Text = "2. Pindai Telur (Scan)"
ScanBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ScanBtn.TextSize = 10

local DisplayEggLabel = Instance.new("TextLabel")
DisplayEggLabel.Parent = MainPage
DisplayEggLabel.BackgroundTransparency = 1
DisplayEggLabel.Position = UDim2.new(0, 0, 0, 125)
DisplayEggLabel.Size = UDim2.new(1, 0, 0, 16)
DisplayEggLabel.Font = Enum.Font.Gotham
DisplayEggLabel.Text = "Target: [ Belum Dipindai ]"
DisplayEggLabel.TextColor3 = Color3.fromRGB(255, 220, 100)
DisplayEggLabel.TextSize = 10
DisplayEggLabel.TextXAlignment = Enum.TextXAlignment.Left

local SelectTargetBtn = Instance.new("TextButton")
SelectTargetBtn.Parent = MainPage
SelectTargetBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
SelectTargetBtn.Position = UDim2.new(0, 0, 0, 144)
SelectTargetBtn.Size = UDim2.new(0, 276, 0, 25)
SelectTargetBtn.Font = Enum.Font.GothamBold
SelectTargetBtn.Text = "Ganti Target Telur (Klik)"
SelectTargetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SelectTargetBtn.TextSize = 10

local TPBaseDirectBtn = Instance.new("TextButton")
TPBaseDirectBtn.Parent = MainPage
TPBaseDirectBtn.BackgroundColor3 = Color3.fromRGB(150, 50, 0)
TPBaseDirectBtn.Position = UDim2.new(0, 0, 0, 174)
TPBaseDirectBtn.Size = UDim2.new(0, 133, 0, 26)
TPBaseDirectBtn.Font = Enum.Font.GothamBold
TPBaseDirectBtn.Text = "TP Langsung Ke Base"
TPBaseDirectBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TPBaseDirectBtn.TextSize = 10

local ToggleEggBtn = Instance.new("TextButton")
ToggleEggBtn.Parent = MainPage
ToggleEggBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ToggleEggBtn.Position = UDim2.new(0, 138, 0, 174)
ToggleEggBtn.Size = UDim2.new(0, 138, 0, 26)
ToggleEggBtn.Font = Enum.Font.GothamBold
ToggleEggBtn.Text = "Auto Egg Loop: OFF"
ToggleEggBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleEggBtn.TextSize = 10

-------------------------------------------------------------------
-- SCANNER & TELEPORT LOGIC ENGINE
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

SetBaseBtn.MouseButton1Click:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        myBasePosition = LocalPlayer.Character.HumanoidRootPart.Position
        SetBaseBtn.Text = "Base Tersimpan!"
        task.wait(1.2)
        SetBaseBtn.Text = "1. Simpan Base"
    end
end)

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

TPBaseDirectBtn.MouseButton1Click:Connect(function()
    if myBasePosition and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(myBasePosition + Vector3.new(0, 3, 0))
    end
end)

ToggleEggBtn.MouseButton1Click:Connect(function()
    isAutoEggActive = not isAutoEggActive
    if isAutoEggActive then
        ToggleEggBtn.Text = "Auto Egg Loop: ON"
        ToggleEggBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
    else
        ToggleEggBtn.Text = "Auto Egg Loop: OFF"
        ToggleEggBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    end
end)

-- AUTO EGG TELEPORT LOOP (SAFE ANTI-TEMBUS)
task.spawn(function()
    while task.wait(0.6) do
        if isAutoEggActive then
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local hrp = char.HumanoidRootPart
                if #scannedEggsList == 0 then ScanWorkspaceForEggs() end
                
                local targetEgg = scannedEggsList[selectedEggIndex]
                if targetEgg and targetEgg.Parent then
                    local targetCFrame = nil
                    if targetEgg:IsA("BasePart") then targetCFrame = targetEgg.CFrame
                    elseif targetEgg:IsA("Model") and targetEgg.PrimaryPart then targetCFrame = targetEgg.PrimaryPart.CFrame
                    elseif targetEgg:IsA("Model") and targetEgg:FindFirstChildWhichIsA("BasePart") then targetCFrame = targetEgg:FindFirstChildWhichIsA("BasePart").CFrame end
                    
                    if targetCFrame then
                        -- Safe Teleport ke Telur
                        hrp.CFrame = targetCFrame + Vector3.new(0, 2.5, 0)
                        
                        for _, child in pairs(targetEgg:GetDescendants()) do
                            if child:IsA("ProximityPrompt") then fireproximityprompt(child) end
                        end
                        task.wait(0.4)
                        
                        -- Safe Teleport Balik Ke Base
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
-- CFrame SPEED BYPASS ENGINE (ANTI-RUBBERBAND / MUNDUR)
-------------------------------------------------------------------
RunService.Heartbeat:Connect(function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("Humanoid") then
        local hum = char.Humanoid
        local hrp = char.HumanoidRootPart
        
        -- WalkSpeed Bypass Engine (CFrame offset)
        if isSpeedActive and hum.MoveDirection.Magnitude > 0 then
            local speedMultiplier = (customSpeed / 16) - 1
            if speedMultiplier > 0 then
                hrp.CFrame = hrp.CFrame + (hum.MoveDirection * (speedMultiplier * 0.28))
            end
        end
        
        -- Jump Power Engine
        if isJumpActive then
            hum.UseJumpPower = true
            hum.JumpPower = customJump
        end
    end
end)

-------------------------------------------------------------------
-- TAB LOGIC
-------------------------------------------------------------------
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
