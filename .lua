-- [[ EXZET HUB - FULL UI & SMART PROMPT EGG STEALER ]] --

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

local isAutoStealActive = false
local myBasePosition = nil

-- Clean Old GUI if exists
if CoreGui:FindFirstChild("ExzetHubUI") then
    CoreGui.ExzetHubUI:Destroy()
end

local ExzetHubUI = Instance.new("ScreenGui")
ExzetHubUI.Name = "ExzetHubUI"
ExzetHubUI.Parent = CoreGui
ExzetHubUI.ResetOnSpawn = false

-------------------------------------------------------------------
-- FLOATING MINIMIZE BUTTON ("XZ")
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
-- MAIN HUB FRAME
-------------------------------------------------------------------
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ExzetHubUI
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.BackgroundTransparency = 0.15
MainFrame.Position = UDim2.new(0.5, -210, 0.5, -150)
MainFrame.Size = UDim2.new(0, 420, 0, 300)
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
Title.Text = "Exzet Hub - SmartPrompt Auto Steal"
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
-- CONTENT PAGE & CONTROLS
-------------------------------------------------------------------
local ContentPage = Instance.new("Frame")
ContentPage.Parent = MainFrame
ContentPage.BackgroundTransparency = 1
ContentPage.Position = UDim2.new(0, 15, 0, 50)
ContentPage.Size = UDim2.new(1, -30, 1, -60)

local CreatorLabel = Instance.new("TextLabel")
CreatorLabel.Parent = ContentPage
CreatorLabel.BackgroundTransparency = 1
CreatorLabel.Size = UDim2.new(1, 0, 0, 20)
CreatorLabel.Font = Enum.Font.GothamBold
CreatorLabel.Text = "Pembuat: exzet | Status: Siap Digunakan"
CreatorLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
CreatorLabel.TextSize = 12
CreatorLabel.TextXAlignment = Enum.TextXAlignment.Left

-- BASE BUTTONS
local SetBaseBtn = Instance.new("TextButton")
SetBaseBtn.Parent = ContentPage
SetBaseBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
SetBaseBtn.Position = UDim2.new(0, 0, 0, 35)
SetBaseBtn.Size = UDim2.new(0, 185, 0, 36)
SetBaseBtn.Font = Enum.Font.GothamBold
SetBaseBtn.Text = "1. Set Posisi Base"
SetBaseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SetBaseBtn.TextSize = 12

local SetBaseCorner = Instance.new("UICorner")
SetBaseCorner.CornerRadius = UDim.new(0, 6)
SetBaseCorner.Parent = SetBaseBtn

local TPBaseBtn = Instance.new("TextButton")
TPBaseBtn.Parent = ContentPage
TPBaseBtn.BackgroundColor3 = Color3.fromRGB(150, 50, 0)
TPBaseBtn.Position = UDim2.new(0, 205, 0, 35)
TPBaseBtn.Size = UDim2.new(0, 185, 0, 36)
TPBaseBtn.Font = Enum.Font.GothamBold
TPBaseBtn.Text = "TP Ke Base"
TPBaseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TPBaseBtn.TextSize = 12

local TPBaseCorner = Instance.new("UICorner")
TPBaseCorner.CornerRadius = UDim.new(0, 6)
TPBaseCorner.Parent = TPBaseBtn

-- STATUS LABEL
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Parent = ContentPage
StatusLabel.BackgroundTransparency = 1
StatusLabel.Position = UDim2.new(0, 0, 0, 85)
StatusLabel.Size = UDim2.new(1, 0, 0, 25)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.Text = "Status: Nonaktif"
StatusLabel.TextColor3 = Color3.fromRGB(255, 220, 100)
StatusLabel.TextSize = 12
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left

-- AUTO STEAL TOGGLE BUTTON
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Parent = ContentPage
ToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ToggleBtn.Position = UDim2.new(0, 0, 0, 120)
ToggleBtn.Size = UDim2.new(0, 390, 0, 48)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.Text = "AUTO STEAL EGG: OFF"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.TextSize = 14

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 6)
ToggleCorner.Parent = ToggleBtn

-------------------------------------------------------------------
-- BUTTON LOGIC & ACTIONS
-------------------------------------------------------------------
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
            StatusLabel.Text = "❌ Harap Set Posisi Base Terlebih Dahulu!"
            isAutoStealActive = false
            return
        end
        ToggleBtn.Text = "AUTO STEAL EGG: ON"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
    else
        ToggleBtn.Text = "AUTO STEAL EGG: OFF"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        StatusLabel.Text = "Status: Nonaktif"
    end
end)

-------------------------------------------------------------------
-- SCANNER KHUSUS SMARTPROMPTPART
-------------------------------------------------------------------
local function GetSmartPromptEggs()
    local eggs = {}
    local objectsFolder = Workspace:FindFirstChild("__OBJECTS")
    local searchRoot = objectsFolder or Workspace
    
    for _, obj in pairs(searchRoot:GetDescendants()) do
        if obj.Name == "SmartPromptPart" and obj:IsA("BasePart") then
            table.insert(eggs, obj)
        end
    end
    return eggs
end

-------------------------------------------------------------------
-- AUTO STEAL LOOP
-------------------------------------------------------------------
task.spawn(function()
    while task.wait(0.3) do
        if isAutoStealActive and myBasePosition then
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("Humanoid") then
                local hrp = char.HumanoidRootPart
                local hum = char.Humanoid

                if hum.Health > 0 then
                    local targetEggs = GetSmartPromptEggs()

                    if #targetEggs > 0 then
                        local targetPart = targetEggs[1]
                        StatusLabel.Text = "Mencuri Telur di Map..."

                        -- 1. Teleport ke atas SmartPromptPart
                        hrp.CFrame = targetPart.CFrame + Vector3.new(0, 3, 0)
                        task.wait(0.25)

                        -- 2. Simulasi interaksi sentuh part
                        if firetouchinterest then
                            firetouchinterest(hrp, targetPart, 0)
                            task.wait(0.05)
                            firetouchinterest(hrp, targetPart, 1)
                        end

                        task.wait(0.2)

                        -- 3. Teleport kilat kembali ke base secara bertahap
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
                        task.wait(0.5)
                    else
                        StatusLabel.Text = "Mencari SmartPromptPart di Map..."
                        if (hrp.Position - myBasePosition).Magnitude > 10 then
                            hrp.CFrame = CFrame.new(myBasePosition + Vector3.new(0, 3, 0))
                        end
                    end
                end
            end
        end
    end
end)
