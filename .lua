local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
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
-- MAIN HUB FRAME (MINIMALIS DENGAN MINIMIZE)
-------------------------------------------------------------------
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ExzetHubUI
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.BackgroundTransparency = 0.15
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -145)
MainFrame.Size = UDim2.new(0, 320, 0, 180)
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
Title.Size = UDim2.new(0, 200, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "Exzet Hub - Auto Egg"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 13
Title.TextXAlignment = Enum.TextXAlignment.Left

-- CONTAINER UTAMA
local ContentContainer = Instance.new("ScrollingFrame")
ContentContainer.Parent = MainFrame
ContentContainer.BackgroundTransparency = 1
ContentContainer.Position = UDim2.new(0, 15, 0, 50)
ContentContainer.Size = UDim2.new(1, -30, 1, -60)
ContentContainer.CanvasSize = UDim2.new(0, 0, 0, 120)
ContentContainer.ScrollBarThickness = 4

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = ContentContainer
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 10)

-- CLOSE BUTTON
local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = Topbar
CloseBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
CloseBtn.Position = UDim2.new(1, -34, 0, 6)
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

-- MINIMIZE BUTTON (-)
local isMinimized = false
local MinBtn = Instance.new("TextButton")
MinBtn.Parent = Topbar
MinBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
MinBtn.Position = UDim2.new(1, -66, 0, 6)
MinBtn.Size = UDim2.new(0, 26, 0, 26)
MinBtn.Font = Enum.Font.GothamBold
MinBtn.Text = "-"
MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinBtn.TextSize = 14

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 6)
MinCorner.Parent = MinBtn

MinBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    ContentContainer.Visible = not isMinimized
    if isMinimized then
        MainFrame.Size = UDim2.new(0, 320, 0, 38)
        MinBtn.Text = "+"
    else
        MainFrame.Size = UDim2.new(0, 320, 0, 180)
        MinBtn.Text = "-"
    end
end)

-------------------------------------------------------------------
-- TOMBOL OTOMATIS AUTO COLLECT & PLANT
-------------------------------------------------------------------

-- Auto Collect Egg Toggle
local autoCollectActive = false
local autoCollectBtn = Instance.new("TextButton")
autoCollectBtn.Size = UDim2.new(1, 0, 0, 32)
autoCollectBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
autoCollectBtn.Font = Enum.Font.GothamBold
autoCollectBtn.Text = "Auto Collect Eggs : OFF"
autoCollectBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
autoCollectBtn.TextSize = 12
autoCollectBtn.Parent = ContentContainer

local acCorner = Instance.new("UICorner")
acCorner.CornerRadius = UDim.new(0, 6)
acCorner.Parent = autoCollectBtn

autoCollectBtn.MouseButton1Click:Connect(function()
    autoCollectActive = not autoCollectActive
    if autoCollectActive then
        autoCollectBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
        autoCollectBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        autoCollectBtn.Text = "Auto Collect Eggs : ON"
    else
        autoCollectBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
        autoCollectBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
        autoCollectBtn.Text = "Auto Collect Eggs : OFF"
    end
end)

-- Auto Plant Toggle
local autoPlantActive = false
local autoPlantBtn = Instance.new("TextButton")
autoPlantBtn.Size = UDim2.new(1, 0, 0, 32)
autoPlantBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
autoPlantBtn.Font = Enum.Font.GothamBold
autoPlantBtn.Text = "Auto Plant / Save : OFF"
autoPlantBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
autoPlantBtn.TextSize = 12
autoPlantBtn.Parent = ContentContainer

local aptCorner = Instance.new("UICorner")
aptCorner.CornerRadius = UDim.new(0, 6)
aptCorner.Parent = autoPlantBtn

autoPlantBtn.MouseButton1Click:Connect(function()
    autoPlantActive = not autoPlantActive
    if autoPlantActive then
        autoPlantBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
        autoPlantBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        autoPlantBtn.Text = "Auto Plant / Save : ON"
    else
        autoPlantBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
        autoPlantBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
        autoPlantBtn.Text = "Auto Plant / Save : OFF"
    end
end)

-------------------------------------------------------------------
-- BACKGROUND AUTOMATIC LOOPS
-------------------------------------------------------------------

-- Loop Scan Folder Workspace untuk mengambil semua telur otomatis
task.spawn(function()
    while true do
        if autoCollectActive then
            pcall(function()
                -- Sesuaikan nama folder tempat telur berada di Workspace (misal: "Eggs" atau "EggSpawns")
                local targetFolder = Workspace:FindFirstChild("Eggs") or Workspace:FindFirstChild("EggSpawns")
                if targetFolder then
                    for _, egg in pairs(targetFolder:GetChildren()) do
                        -- Mengambil nama/ID objek telur secara otomatis sebagai argumen
                        local args = {
                            [1] = egg.Name
                        }
                        ReplicatedStorage.Remotes.Game.EggPickup:FireServer(unpack(args))
                    end
                end
            end)
        end
        task.wait(0.5)
    end
end)

-- Loop untuk PlantHint otomatis
task.spawn(function()
    while true do
        if autoPlantActive then
            pcall(function()
                ReplicatedStorage.Remotes.Game.PlantHint:FireServer()
            end)
        end
        task.wait(0.5)
    end
end)
