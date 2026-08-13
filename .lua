-- [[ EXZET HUB - FULL CODE (UNIVERSAL BYPASS & STABLE UI) ]] --

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

-- Status State untuk Fitur
local customSpeed = 16
local isSpeedActive = false
local customJump = 50
local isJumpActive = false
local isAutoEggActive = false
local myBasePosition = nil -- Menyimpan titik koordinat rumah/garden kamu

-- Matikan Topbar/Header Bawaan Roblox Agar Bar Hitam Tidak Muncul
pcall(function()
    StarterGui:SetCore("TopbarEnabled", false)
end)

-- Hapus UI lama jika ada
if CoreGui:FindFirstChild("ExzetHubUI") then
    CoreGui.ExzetHubUI:Destroy()
end

-- ScreenGui Utama
local ExzetHubUI = Instance.new("ScreenGui")
ExzetHubUI.Name = "ExzetHubUI"
ExzetHubUI.Parent = CoreGui
ExzetHubUI.ResetOnSpawn = false

-- Frame Utama (Window)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ExzetHubUI
MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
MainFrame.BackgroundTransparency = 0.25
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -130)
MainFrame.Size = UDim2.new(0, 450, 0, 300)
MainFrame.Active = true
MainFrame.Draggable = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

local MainGradient = Instance.new("UIGradient")
MainGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(150, 0, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 10, 10))
}
MainGradient.Rotation = 45
MainGradient.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Parent = MainFrame
MainStroke.Color = Color3.fromRGB(255, 30, 30)
MainStroke.Thickness = 1.5

-------------------------------------------------------------------
-- TOPBAR / HEADER UI
-------------------------------------------------------------------
local Topbar = Instance.new("Frame")
Topbar.Name = "Topbar"
Topbar.Parent = MainFrame
Topbar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Topbar.BackgroundTransparency = 0.5
Topbar.BorderSizePixel = 0
Topbar.Size = UDim2.new(1, 0, 0, 40)
Topbar.ZIndex = 2

local TopbarCorner = Instance.new("UICorner")
TopbarCorner.CornerRadius = UDim.new(0, 12)
TopbarCorner.Parent = Topbar

local TopbarBottomFill = Instance.new("Frame")
TopbarBottomFill.Name = "BottomFill"
TopbarBottomFill.Parent = Topbar
TopbarBottomFill.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
TopbarBottomFill.BackgroundTransparency = 0.5
TopbarBottomFill.BorderSizePixel = 0
TopbarBottomFill.Position = UDim2.new(0, 0, 0, 20)
TopbarBottomFill.Size = UDim2.new(1, 0, 0, 20)
TopbarBottomFill.ZIndex = 2

local Title = Instance.new("TextLabel")
Title.Parent = Topbar
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 15, 0, 0)
Title.Size = UDim2.new(0, 200, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "Exzet Hub"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.ZIndex = 3

-------------------------------------------------------------------
-- NAVIGATION / TAB BUTTONS
-------------------------------------------------------------------
local TabBar = Instance.new("Frame")
TabBar.Parent = MainFrame
TabBar.BackgroundTransparency = 1
TabBar.Position = UDim2.new(0, 10, 0, 45)
TabBar.Size = UDim2.new(0, 100, 1, -55)
TabBar.ZIndex = 2

local InfoTabBtn = Instance.new("TextButton")
InfoTabBtn.Parent = TabBar
InfoTabBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
InfoTabBtn.BackgroundTransparency = 0.4
InfoTabBtn.Size = UDim2.new(1, 0, 0, 35)
InfoTabBtn.Font = Enum.Font.GothamBold
InfoTabBtn.Text = "Info"
InfoTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
InfoTabBtn.TextSize = 14

local InfoBtnCorner = Instance.new("UICorner")
InfoBtnCorner.CornerRadius = UDim.new(0, 6)
InfoBtnCorner.Parent = InfoTabBtn

local MainTabBtn = Instance.new("TextButton")
MainTabBtn.Parent = TabBar
MainTabBtn.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
MainTabBtn.BackgroundTransparency = 0.6
MainTabBtn.Position = UDim2.new(0, 0, 0, 45)
MainTabBtn.Size = UDim2.new(1, 0, 0, 35)
MainTabBtn.Font = Enum.Font.GothamBold
MainTabBtn.Text = "Main"
MainTabBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
MainTabBtn.TextSize = 14

local MainBtnCorner = Instance.new("UICorner")
MainBtnCorner.CornerRadius = UDim.new(0, 6)
MainBtnCorner.Parent = MainTabBtn

-------------------------------------------------------------------
-- CONTAINER CONTENT (PAGES)
-------------------------------------------------------------------
local ContentContainer = Instance.new("Frame")
ContentContainer.Parent = MainFrame
ContentContainer.BackgroundTransparency = 1
ContentContainer.Position = UDim2.new(0, 120, 0, 45)
ContentContainer.Size = UDim2.new(1, -130, 1, -55)
ContentContainer.ZIndex = 2

-- PAGE 1: INFO
local InfoPage = Instance.new("Frame")
InfoPage.Parent = ContentContainer
InfoPage.BackgroundTransparency = 1
InfoPage.Size = UDim2.new(1, 0, 1, 0)
InfoPage.Visible = true

local CreatorLabel = Instance.new("TextLabel")
CreatorLabel.Parent = InfoPage
CreatorLabel.BackgroundTransparency = 1
CreatorLabel.Position = UDim2.new(0, 0, 0, 10)
CreatorLabel.Size = UDim2.new(1, 0, 0, 25)
CreatorLabel.Font = Enum.Font.GothamBold
CreatorLabel.Text = "Pembuat: exzet"
CreatorLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
CreatorLabel.TextSize = 16
CreatorLabel.TextXAlignment = Enum.TextXAlignment.Left

local DiscordDesc = Instance.new("TextLabel")
DiscordDesc.Parent = InfoPage
DiscordDesc.BackgroundTransparency = 1
DiscordDesc.Position = UDim2.new(0, 0, 0, 40)
DiscordDesc.Size = UDim2.new(1, 0, 0, 40)
DiscordDesc.Font = Enum.Font.Gotham
DiscordDesc.Text = "Join Discord resmi untuk mendapatkan link sc!"
DiscordDesc.TextColor3 = Color3.fromRGB(200, 200, 200)
DiscordDesc.TextSize = 13
DiscordDesc.TextWrapped = true
DiscordDesc.TextXAlignment = Enum.TextXAlignment.Left

local DiscordBtn = Instance.new("TextButton")
DiscordBtn.Parent = InfoPage
DiscordBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
DiscordBtn.Position = UDim2.new(0, 0, 0, 90)
DiscordBtn.Size = UDim2.new(0, 180, 0, 35)
DiscordBtn.Font = Enum.Font.GothamBold
DiscordBtn.Text = "Salin Link Discord"
DiscordBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
DiscordBtn.TextSize = 13

local DiscCorner = Instance.new("UICorner")
DiscCorner.CornerRadius = UDim.new(0, 6)
DiscCorner.Parent = DiscordBtn

DiscordBtn.MouseButton1Click:Connect(function()
    setclipboard("https://discord.gg/yourlinkhere")
    DiscordBtn.Text = "Link Tersalin!"
    task.wait(2)
    DiscordBtn.Text = "Salin Link Discord"
end)

-- PAGE 2: MAIN (WALKSPEED, JUMP, & STEAL AN EGG)
local MainPage = Instance.new("Frame")
MainPage.Parent = ContentContainer
MainPage.BackgroundTransparency = 1
MainPage.Size = UDim2.new(1, 0, 1, 0)
MainPage.Visible = false

-------------------------------------------------------------------
-- FITUR WALKSPEED
-------------------------------------------------------------------
local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Parent = MainPage
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Position = UDim2.new(0, 0, 0, 5)
SpeedLabel.Size = UDim2.new(1, 0, 0, 20)
SpeedLabel.Font = Enum.Font.GothamBold
SpeedLabel.Text = "Kecepatan Jalan (Speed Bypass):"
SpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedLabel.TextSize = 13
SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left

local SpeedInput = Instance.new("TextBox")
SpeedInput.Parent = MainPage
SpeedInput.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
SpeedInput.Position = UDim2.new(0, 0, 0, 28)
SpeedInput.Size = UDim2.new(0, 120, 0, 28)
SpeedInput.Font = Enum.Font.Gotham
SpeedInput.PlaceholderText = "Misal: 30 / 50"
SpeedInput.Text = ""
SpeedInput.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedInput.TextSize = 12

local SpeedInputCorner = Instance.new("UICorner")
SpeedInputCorner.CornerRadius = UDim.new(0, 6)
SpeedInputCorner.Parent = SpeedInput

local SpeedApplyBtn = Instance.new("TextButton")
SpeedApplyBtn.Parent = MainPage
SpeedApplyBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
SpeedApplyBtn.Position = UDim2.new(0, 130, 0, 28)
SpeedApplyBtn.Size = UDim2.new(0, 80, 0, 28)
SpeedApplyBtn.Font = Enum.Font.GothamBold
SpeedApplyBtn.Text = "Set Speed"
SpeedApplyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedApplyBtn.TextSize = 12

local SpeedApplyCorner = Instance.new("UICorner")
SpeedApplyCorner.CornerRadius = UDim.new(0, 6)
SpeedApplyCorner.Parent = SpeedApplyBtn

local SpeedResetBtn = Instance.new("TextButton")
SpeedResetBtn.Parent = MainPage
SpeedResetBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
SpeedResetBtn.Position = UDim2.new(0, 218, 0, 28)
SpeedResetBtn.Size = UDim2.new(0, 70, 0, 28)
SpeedResetBtn.Font = Enum.Font.GothamBold
SpeedResetBtn.Text = "Reset"
SpeedResetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedResetBtn.TextSize = 12

local SpeedResetCorner = Instance.new("UICorner")
SpeedResetCorner.CornerRadius = UDim.new(0, 6)
SpeedResetCorner.Parent = SpeedResetBtn

SpeedApplyBtn.MouseButton1Click:Connect(function()
    local num = tonumber(SpeedInput.Text)
    if num then
        customSpeed = num
        isSpeedActive = true
    end
end)

SpeedResetBtn.MouseButton1Click:Connect(function()
    isSpeedActive = false
    SpeedInput.Text = ""
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = 16
    end
end)

-------------------------------------------------------------------
-- FITUR JUMPHEIGHT
-------------------------------------------------------------------
local JumpLabel = Instance.new("TextLabel")
JumpLabel.Parent = MainPage
JumpLabel.BackgroundTransparency = 1
JumpLabel.Position = UDim2.new(0, 0, 0, 65)
JumpLabel.Size = UDim2.new(1, 0, 0, 20)
JumpLabel.Font = Enum.Font.GothamBold
JumpLabel.Text = "Tinggi Lompatan (JumpHeight):"
JumpLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
JumpLabel.TextSize = 13
JumpLabel.TextXAlignment = Enum.TextXAlignment.Left

local JumpInput = Instance.new("TextBox")
JumpInput.Parent = MainPage
JumpInput.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
JumpInput.Position = UDim2.new(0, 0, 0, 88)
JumpInput.Size = UDim2.new(0, 120, 0, 28)
JumpInput.Font = Enum.Font.Gotham
JumpInput.PlaceholderText = "Default: 50"
JumpInput.Text = ""
JumpInput.TextColor3 = Color3.fromRGB(255, 255, 255)
JumpInput.TextSize = 12

local JumpInputCorner = Instance.new("UICorner")
JumpInputCorner.CornerRadius = UDim.new(0, 6)
JumpInputCorner.Parent = JumpInput

local JumpApplyBtn = Instance.new("TextButton")
JumpApplyBtn.Parent = MainPage
JumpApplyBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
JumpApplyBtn.Position = UDim2.new(0, 130, 0, 88)
JumpApplyBtn.Size = UDim2.new(0, 80, 0, 28)
JumpApplyBtn.Font = Enum.Font.GothamBold
JumpApplyBtn.Text = "Set Jump"
JumpApplyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
JumpApplyBtn.TextSize = 12

local JumpApplyCorner = Instance.new("UICorner")
JumpApplyCorner.CornerRadius = UDim.new(0, 6)
JumpApplyCorner.Parent = JumpApplyBtn

local JumpResetBtn = Instance.new("TextButton")
JumpResetBtn.Parent = MainPage
JumpResetBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
JumpResetBtn.Position = UDim2.new(0, 218, 0, 88)
JumpResetBtn.Size = UDim2.new(0, 70, 0, 28)
JumpResetBtn.Font = Enum.Font.GothamBold
JumpResetBtn.Text = "Reset"
JumpResetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
JumpResetBtn.TextSize = 12

local JumpResetCorner = Instance.new("UICorner")
JumpResetCorner.CornerRadius = UDim.new(0, 6)
JumpResetCorner.Parent = JumpResetBtn

JumpApplyBtn.MouseButton1Click:Connect(function()
    local num = tonumber(JumpInput.Text)
    if num then
        customJump = num
        isJumpActive = true
    end
end)

JumpResetBtn.MouseButton1Click:Connect(function()
    isJumpActive = false
    JumpInput.Text = ""
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        local hum = LocalPlayer.Character.Humanoid
        hum.UseJumpPower = true
        hum.JumpPower = 50
        hum.JumpHeight = 7.2
    end
end)

-------------------------------------------------------------------
-- FITUR STEAL AN EGG (UI BUTTONS)
-------------------------------------------------------------------
local EggLabel = Instance.new("TextLabel")
EggLabel.Parent = MainPage
EggLabel.BackgroundTransparency = 1
EggLabel.Position = UDim2.new(0, 0, 0, 125)
EggLabel.Size = UDim2.new(1, 0, 0, 20)
EggLabel.Font = Enum.Font.GothamBold
EggLabel.Text = "Fitur Steal an Egg:"
EggLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
EggLabel.TextSize = 13
EggLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Tombol Simpan Base
local SetBaseBtn = Instance.new("TextButton")
SetBaseBtn.Parent = MainPage
SetBaseBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
SetBaseBtn.Position = UDim2.new(0, 0, 0, 148)
SetBaseBtn.Size = UDim2.new(0, 130, 0, 32)
SetBaseBtn.Font = Enum.Font.GothamBold
SetBaseBtn.Text = "Simpan Posisi Base"
SetBaseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SetBaseBtn.TextSize = 11

local SetBaseCorner = Instance.new("UICorner")
SetBaseCorner.CornerRadius = UDim.new(0, 6)
SetBaseCorner.Parent = SetBaseBtn

-- Tombol Toggle Auto Egg
local ToggleEggBtn = Instance.new("TextButton")
ToggleEggBtn.Parent = MainPage
ToggleEggBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ToggleEggBtn.Position = UDim2.new(0, 138, 0, 148)
ToggleEggBtn.Size = UDim2.new(0, 150, 0, 32)
ToggleEggBtn.Font = Enum.Font.GothamBold
ToggleEggBtn.Text = "Auto Egg: OFF"
ToggleEggBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleEggBtn.TextSize = 11

local ToggleEggCorner = Instance.new("UICorner")
ToggleEggCorner.CornerRadius = UDim.new(0, 6)
ToggleEggCorner.Parent = ToggleEggBtn

-- Event Listener Tombol Base & Auto Egg
SetBaseBtn.MouseButton1Click:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        myBasePosition = LocalPlayer.Character.HumanoidRootPart.Position
        SetBaseBtn.Text = "Base Tersimpan!"
        task.wait(1.5)
        SetBaseBtn.Text = "Simpan Posisi Base"
    end
end)

ToggleEggBtn.MouseButton1Click:Connect(function()
    isAutoEggActive = not isAutoEggActive
    if isAutoEggActive then
        ToggleEggBtn.Text = "Auto Egg: ON"
        ToggleEggBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
    else
        ToggleEggBtn.Text = "Auto Egg: OFF"
        ToggleEggBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    end
end)

-------------------------------------------------------------------
-- ENGINE BYPASS (VELOCITY METHOD - ANTI RUBBERBAND)
-------------------------------------------------------------------
RunService.Heartbeat:Connect(function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("Humanoid") then
        local hrp = char.HumanoidRootPart
        local hum = char.Humanoid

        -- BYPASS WALKSPEED MENGGUNAKAN ASSEMBLY LINEAR VELOCITY
        if isSpeedActive and hum.MoveDirection.Magnitude > 0 then
            local currentY = hrp.AssemblyLinearVelocity.Y
            local moveDir = hum.MoveDirection
            
            hrp.AssemblyLinearVelocity = Vector3.new(
                moveDir.X * customSpeed,
                currentY,
                moveDir.Z * customSpeed
            )
        end

        -- BYPASS JUMP
        if isJumpActive then
            hum.UseJumpPower = true
            hum.JumpPower = customJump
            hum.JumpHeight = customJump
        end
    end
end)

-------------------------------------------------------------------
-- STEAL AN EGG - SAFE EGG COLLECTOR ENGINE
-------------------------------------------------------------------
local function FindSpawnedEggs()
    local detectedEggs = {}
    
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("Model") or obj:IsA("BasePart") then
            if string.find(string.lower(obj.Name), "egg") and not string.find(string.lower(obj.Parent.Name), "ui") then
                table.insert(detectedEggs, obj)
            end
        end
    end
    return detectedEggs
end

task.spawn(function()
    while task.wait(1) do
        if isAutoEggActive then
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("Humanoid") and char:FindFirstChild("HumanoidRootPart") then
                local hum = char.Humanoid
                
                local eggsFound = FindSpawnedEggs()
                
                if #eggsFound > 0 then
                    local targetEgg = eggsFound[1]
                    local targetPos = nil
                    
                    if targetEgg:IsA("BasePart") then
                        targetPos = targetEgg.Position
                    elseif targetEgg:IsA("Model") and targetEgg.PrimaryPart then
                        targetPos = targetEgg.PrimaryPart.Position
                    elseif targetEgg:IsA("Model") and targetEgg:FindFirstChildWhichIsA("BasePart") then
                        targetPos = targetEgg:FindFirstChildWhichIsA("BasePart").Position
                    end
                    
                    if targetPos then
                        -- A. Lari Alami ke Lokasi Egg (Aman Anti-Ban)
                        hum:MoveTo(targetPos)
                        hum.MoveToFinished:Wait()
                        
                        task.wait(0.5) -- Delay sebentar untuk mengambil egg
                        
                        -- B. Lari Balik ke Base / Garden
                        if myBasePosition and isAutoEggActive then
                            hum:MoveTo(myBasePosition)
                            hum.MoveToFinished:Wait()
                        end
                    end
                end
            end
        end
    end
end)

-------------------------------------------------------------------
-- TAB SWITCHING LOGIC
-------------------------------------------------------------------
InfoTabBtn.MouseButton1Click:Connect(function()
    InfoPage.Visible = true
    MainPage.Visible = false
    InfoTabBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    InfoTabBtn.BackgroundTransparency = 0.4
    InfoTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    MainTabBtn.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
    MainTabBtn.BackgroundTransparency = 0.6
    MainTabBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
end)

MainTabBtn.MouseButton1Click:Connect(function()
    InfoPage.Visible = false
    MainPage.Visible = true
    MainTabBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    MainTabBtn.BackgroundTransparency = 0.4
    MainTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    InfoTabBtn.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
    InfoTabBtn.BackgroundTransparency = 0.6
    InfoTabBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
end)

-------------------------------------------------------------------
-- CONTROL BUTTONS (MINIMIZE & CLOSE)
-------------------------------------------------------------------
local MinimizeBox = Instance.new("TextButton")
MinimizeBox.Name = "MinimizeBox"
MinimizeBox.Parent = ExzetHubUI
MinimizeBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
MinimizeBox.Position = UDim2.new(0.02, 0, 0.2, 0)
MinimizeBox.Size = UDim2.new(0, 42, 0, 42)
MinimizeBox.Text = "" 
MinimizeBox.Active = true
MinimizeBox.Draggable = true
MinimizeBox.Visible = false

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 8)
MinCorner.Parent = MinimizeBox

local MinGradient = Instance.new("UIGradient")
MinGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(220, 0, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 0, 0))
}
MinGradient.Rotation = 45
MinGradient.Parent = MinimizeBox

local MinStroke = Instance.new("UIStroke")
MinStroke.Parent = MinimizeBox
MinStroke.Color = Color3.fromRGB(255, 50, 50)
MinStroke.Thickness = 1.5

local MinText = Instance.new("TextLabel")
MinText.Name = "MinText"
MinText.Parent = MinimizeBox
MinText.BackgroundTransparency = 1
MinText.Size = UDim2.new(1, 0, 1, 0)
MinText.Font = Enum.Font.GothamBold
MinText.Text = "XZ"
MinText.TextColor3 = Color3.fromRGB(255, 255, 255)
MinText.TextSize = 16
MinText.ZIndex = 999

-- Tombol Minimize (-)
local MinBtn = Instance.new("TextButton")
MinBtn.Parent = Topbar
MinBtn.BackgroundTransparency = 1
MinBtn.Position = UDim2.new(1, -70, 0, 0)
MinBtn.Size = UDim2.new(0, 30, 1, 0)
MinBtn.Font = Enum.Font.GothamBold
MinBtn.Text = "-"
MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinBtn.TextSize = 20
MinBtn.ZIndex = 3

MinBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    MinimizeBox.Visible = true
end)

MinimizeBox.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    MinimizeBox.Visible = false
end)

-- Tombol Close (X)
local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = Topbar
CloseBtn.BackgroundTransparency = 1
CloseBtn.Position = UDim2.new(1, -35, 0, 0)
CloseBtn.Size = UDim2.new(0, 35, 1, 0)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 60, 60)
CloseBtn.TextSize = 16
CloseBtn.ZIndex = 3

-- Pop-up Konfirmasi Close
local ConfirmFrame = Instance.new("Frame")
ConfirmFrame.Parent = MainFrame
ConfirmFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
ConfirmFrame.Position = UDim2.new(0.15, 0, 0.25, 0)
ConfirmFrame.Size = UDim2.new(0.7, 0, 0.5, 0)
ConfirmFrame.Visible = false
ConfirmFrame.ZIndex = 10

local ConfirmCorner = Instance.new("UICorner")
ConfirmCorner.CornerRadius = UDim.new(0, 8)
ConfirmCorner.Parent = ConfirmFrame

local ConfirmStroke = Instance.new("UIStroke")
ConfirmStroke.Parent = ConfirmFrame
ConfirmStroke.Color = Color3.fromRGB(255, 0, 0)

local ConfirmText = Instance.new("TextLabel")
ConfirmText.Parent = ConfirmFrame
ConfirmText.BackgroundTransparency = 1
ConfirmText.Position = UDim2.new(0, 10, 0, 10)
ConfirmText.Size = UDim2.new(1, -20, 0, 60)
ConfirmText.Font = Enum.Font.GothamBold
ConfirmText.Text = "Peringatan!\nJika di-close, Anda harus re-execute script agar berjalan kembali."
ConfirmText.TextColor3 = Color3.fromRGB(255, 255, 255)
ConfirmText.TextSize = 12
ConfirmText.TextWrapped = true
ConfirmText.ZIndex = 11

local YesBtn = Instance.new("TextButton")
YesBtn.Parent = ConfirmFrame
YesBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
YesBtn.Position = UDim2.new(0.1, 0, 0.65, 0)
YesBtn.Size = UDim2.new(0.35, 0, 0, 30)
YesBtn.Font = Enum.Font.GothamBold
YesBtn.Text = "Tutup UI"
YesBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
YesBtn.TextSize = 13
YesBtn.ZIndex = 11

local YesCorner = Instance.new("UICorner")
YesCorner.CornerRadius = UDim.new(0, 6)
YesCorner.Parent = YesBtn

local NoBtn = Instance.new("TextButton")
NoBtn.Parent = ConfirmFrame
NoBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
NoBtn.Position = UDim2.new(0.55, 0, 0.65, 0)
NoBtn.Size = UDim2.new(0.35, 0, 0, 30)
NoBtn.Font = Enum.Font.GothamBold
NoBtn.Text = "Batal"
NoBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
NoBtn.TextSize = 13
NoBtn.ZIndex = 11

local NoCorner = Instance.new("UICorner")
NoCorner.CornerRadius = UDim.new(0, 6)
NoCorner.Parent = NoBtn

CloseBtn.MouseButton1Click:Connect(function()
    ConfirmFrame.Visible = true
end)

NoBtn.MouseButton1Click:Connect(function()
    ConfirmFrame.Visible = false
end)

YesBtn.MouseButton1Click:Connect(function()
    ExzetHubUI:Destroy()
end)
