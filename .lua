-- [[ EXZET HUB - CUSTOM GRADIENT UI (PERFECT CORNER FIX) ]] --

local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

-- Hapus UI lama jika ada
if CoreGui:FindFirstChild("ExzetHubUI") then
    CoreGui.ExzetHubUI:Destroy()
end

-- ScreenGui Utama
local ExzetHubUI = Instance.new("ScreenGui")
ExzetHubUI.Name = "ExzetHubUI"
ExzetHubUI.Parent = CoreGui
ExzetHubUI.ResetOnSpawn = false

-- CanvasGroup Utama (Memotong SEMUA sudut child dengan sempurna tanpa bocor)
local MainFrame = Instance.new("CanvasGroup")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ExzetHubUI
MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
MainFrame.GroupTransparency = 0 -- Transparansi global CanvasGroup
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -150)
MainFrame.Size = UDim2.new(0, 450, 0, 300)
MainFrame.Active = true
MainFrame.Draggable = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

-- Gradient Merah ke Hitam untuk MainFrame
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
-- TOPBAR / HEADER (HITAM DAN IKUT MELENGKUNG)
-------------------------------------------------------------------
local Topbar = Instance.new("Frame")
Topbar.Name = "Topbar"
Topbar.Parent = MainFrame
Topbar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Topbar.BackgroundTransparency = 0.5 -- Transparansi Hitam Topbar
Topbar.BorderSizePixel = 0
Topbar.Size = UDim2.new(1, 0, 0, 40)
Topbar.ZIndex = 2

-- Title "Exzet Hub" di kiri atas
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

-- PAGE INFO
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

-- PAGE MAIN (KOSONG)
local MainPage = Instance.new("Frame")
MainPage.Parent = ContentContainer
MainPage.BackgroundTransparency = 1
MainPage.Size = UDim2.new(1, 0, 1, 0)
MainPage.Visible = false

local EmptyLabel = Instance.new("TextLabel")
EmptyLabel.Parent = MainPage
EmptyLabel.BackgroundTransparency = 1
EmptyLabel.Position = UDim2.new(0, 0, 0, 10)
EmptyLabel.Size = UDim2.new(1, 0, 0, 30)
EmptyLabel.Font = Enum.Font.Gotham
EmptyLabel.Text = "Fitur Main masih kosong..."
EmptyLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
EmptyLabel.TextSize = 14
EmptyLabel.TextXAlignment = Enum.TextXAlignment.Left

-- TABS SWITCHING LOGIC
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
-- CONTROL BUTTONS (MINIMIZE DENGAN TEKS XZ & CLOSE CONFIRMATION)
-------------------------------------------------------------------

-- Floating Button Minimize (Lengkap dengan teks XZ)
local MinimizeBox = Instance.new("TextButton")
MinimizeBox.Name = "MinimizeBox"
MinimizeBox.Parent = ExzetHubUI
MinimizeBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
MinimizeBox.Position = UDim2.new(0.02, 0, 0.2, 0)
MinimizeBox.Size = UDim2.new(0, 42, 0, 42)
MinimizeBox.Font = Enum.Font.GothamBold
MinimizeBox.Text = "XZ"
MinimizeBox.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeBox.TextSize = 16
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

-- Tombol Minimize (-) di Topbar
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

-- Tombol Close (X) di Topbar
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
