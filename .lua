local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- Clean Old GUI
if CoreGui:FindFirstChild("ExzetHubUI") then
    CoreGui.ExzetHubUI:Destroy()
end

local ExzetHubUI = Instance.new("ScreenGui")
ExzetHubUI.Name = "ExzetHubUI"
ExzetHubUI.Parent = CoreGui
ExzetHubUI.ResetOnSpawn = false

-------------------------------------------------------------------
-- MAIN HUB FRAME (MINIMALIS)
-------------------------------------------------------------------
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ExzetHubUI
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.BackgroundTransparency = 0.15
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -130)
MainFrame.Size = UDim2.new(0, 320, 0, 260)
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
Title.Size = UDim2.new(0, 240, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "Exzet Hub - Movement"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 13
Title.TextXAlignment = Enum.TextXAlignment.Left

-- CLOSE BUTTON
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

CloseBtn.MouseButton1Click:Connect(function()
    ExzetHubUI:Destroy()
end)

-------------------------------------------------------------------
-- CONTAINER & CONTROLS
-------------------------------------------------------------------
local ContentContainer = Instance.new("ScrollingFrame")
ContentContainer.Parent = MainFrame
ContentContainer.BackgroundTransparency = 1
ContentContainer.Position = UDim2.new(0, 15, 0, 50)
ContentContainer.Size = UDim2.new(1, -30, 1, -60)
ContentContainer.CanvasSize = UDim2.new(0, 0, 0, 250)
ContentContainer.ScrollBarThickness = 4

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = ContentContainer
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 10)

-- 1. WALKSPEED SETTINGS
local speedBox = Instance.new("TextBox")
speedBox.Size = UDim2.new(1, 0, 0, 32)
speedBox.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
speedBox.Font = Enum.Font.GothamMedium
speedBox.PlaceholderText = "WalkSpeed (default 16)"
speedBox.Text = "16"
speedBox.TextColor3 = Color3.fromRGB(255, 255, 255)
speedBox.TextSize = 12
speedBox.Parent = ContentContainer

local sbCorner = Instance.new("UICorner")
sbCorner.CornerRadius = UDim.new(0, 6)
sbCorner.Parent = speedBox

local speedActive = false
local speedBtn = Instance.new("TextButton")
speedBtn.Size = UDim2.new(1, 0, 0, 32)
speedBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
speedBtn.Font = Enum.Font.GothamBold
speedBtn.Text = "Custom WalkSpeed : OFF"
speedBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
speedBtn.TextSize = 12
speedBtn.Parent = ContentContainer

local sbBtnCorner = Instance.new("UICorner")
sbBtnCorner.CornerRadius = UDim.new(0, 6)
sbBtnCorner.Parent = speedBtn

speedBtn.MouseButton1Click:Connect(function()
    speedActive = not speedActive
    if speedActive then
        speedBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
        speedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        speedBtn.Text = "Custom WalkSpeed : ON"
    else
        speedBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
        speedBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
        speedBtn.Text = "Custom WalkSpeed : OFF"
    end
end)

task.spawn(function()
    while true do
        pcall(function()
            if speedActive and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                local spd = tonumber(speedBox.Text) or 16
                LocalPlayer.Character.Humanoid.WalkSpeed = spd
            end
        end)
        task.wait(0.1)
    end
end)

-- 2. JUMPHEIGHT SETTINGS
local jumpBox = Instance.new("TextBox")
jumpBox.Size = UDim2.new(1, 0, 0, 32)
jumpBox.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
jumpBox.Font = Enum.Font.GothamMedium
jumpBox.PlaceholderText = "JumpHeight (default 7.2)"
jumpBox.Text = "7.2"
jumpBox.TextColor3 = Color3.fromRGB(255, 255, 255)
jumpBox.TextSize = 12
jumpBox.Parent = ContentContainer

local jbCorner = Instance.new("UICorner")
jbCorner.CornerRadius = UDim.new(0, 6)
jbCorner.Parent = jumpBox

local jumpActive = false
local jumpBtn = Instance.new("TextButton")
jumpBtn.Size = UDim2.new(1, 0, 0, 32)
jumpBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
jumpBtn.Font = Enum.Font.GothamBold
jumpBtn.Text = "Custom JumpHeight : OFF"
jumpBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
jumpBtn.TextSize = 12
jumpBtn.Parent = ContentContainer

local jbBtnCorner = Instance.new("UICorner")
jbBtnCorner.CornerRadius = UDim.new(0, 6)
jbBtnCorner.Parent = jumpBtn

jumpBtn.MouseButton1Click:Connect(function()
    jumpActive = not jumpActive
    if jumpActive then
        jumpBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
        jumpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        jumpBtn.Text = "Custom JumpHeight : ON"
    else
        jumpBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
        jumpBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
        jumpBtn.Text = "Custom JumpHeight : OFF"
    end
end)

task.spawn(function()
    while true do
        pcall(function()
            if jumpActive and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                local hum = LocalPlayer.Character.Humanoid
                hum.UseJumpPower = false -- Pastikan pakai mode Height
                local jmp = tonumber(jumpBox.Text) or 7.2
                hum.JumpHeight = jmp
            end
        end)
        task.wait(0.1)
    end
end)

-- 3. INFINITE JUMP
local infJumpActive = false
local infJumpBtn = Instance.new("TextButton")
infJumpBtn.Size = UDim2.new(1, 0, 0, 32)
infJumpBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
infJumpBtn.Font = Enum.Font.GothamBold
infJumpBtn.Text = "Infinite Jump : OFF"
infJumpBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
infJumpBtn.TextSize = 12
infJumpBtn.Parent = ContentContainer

local ijCorner = Instance.new("UICorner")
ijCorner.CornerRadius = UDim.new(0, 6)
ijCorner.Parent = infJumpBtn

infJumpBtn.MouseButton1Click:Connect(function()
    infJumpActive = not infJumpActive
    if infJumpActive then
        infJumpBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
        infJumpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        infJumpBtn.Text = "Infinite Jump : ON"
    else
        infJumpBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
        infJumpBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
        infJumpBtn.Text = "Infinite Jump : OFF"
    end
end)

UserInputService.JumpRequest:Connect(function()
    if infJumpActive and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)
