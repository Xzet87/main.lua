-- [[ EXZET HUB UI SCRIPT - REVISED ]] --

local OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/jensonhirst/Orion/main/source'))()

-- Membuat Window Utama
local Window = OrionLib:MakeWindow({
    Name = "exzet hub", 
    HidePremium = true, 
    SaveConfig = false, 
    ConfigFolder = "ExzetHubConfig",
    IntroEnabled = true,
    IntroText = "exzet hub Loading...",
    IntroIcon = "rbxassetid://4483345998"
})

-------------------------------------------------------------------
-- NAVIGATION TABS
-------------------------------------------------------------------

local InfoTab = Window:MakeTab({
    Name = "Info",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local MainTab = Window:MakeTab({
    Name = "Main",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-------------------------------------------------------------------
-- ISI TAB INFO
-------------------------------------------------------------------

InfoTab:AddSection({
    Name = "Informasi Pembuat"
})

InfoTab:AddLabel("Pembuat: exzet")

InfoTab:AddParagraph("Discord Community", "Join Discord resmi kami untuk mendapatkan link script terbaru!")

InfoTab:AddButton({
    Name = "Salin Link Discord",
    Callback = function()
        setclipboard("https://discord.gg/yourlinkhere") -- Ganti link Discord di sini
        OrionLib:MakeNotification({
            Name = "Sukses!",
            Content = "Link Discord berhasil disalin ke clipboard!",
            Image = "rbxassetid://4483345998",
            Time = 3
        })
    end    
})

-------------------------------------------------------------------
-- ISI TAB MAIN (KOSONG)
-------------------------------------------------------------------

MainTab:AddSection({
    Name = "Main Features (Segera Hadir)"
})

MainTab:AddLabel("Fitur akan ditambahkan di sini...")

-------------------------------------------------------------------
-- MINIMIZE SYSTEM (KOTAK XZ SAJA) & GRADIENT RED-BLACK
-------------------------------------------------------------------

local CoreGui = game:GetService("CoreGui")

-- Membuat Tombol Floating Box XZ untuk Minimize
local MinimizeGui = Instance.new("ScreenGui")
local MinimizeBtn = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")
local UIStroke = Instance.new("UIStroke")
local UIGradient = Instance.new("UIGradient")

MinimizeGui.Name = "ExzetMinimizeGui"
MinimizeGui.Parent = CoreGui
MinimizeGui.Enabled = false -- Sembunyi sampai UI utama di-minimize

MinimizeBtn.Parent = MinimizeGui
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
MinimizeBtn.Position = UDim2.new(0.02, 0, 0.2, 0)
MinimizeBtn.Size = UDim2.new(0, 50, 0, 50) -- Ukuran kotak presisi
MinimizeBtn.Font = Enum.Font.SourceSansBold
MinimizeBtn.Text = "XZ"
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeBtn.TextSize = 22.000
MinimizeBtn.Active = true
MinimizeBtn.Draggable = true -- BISA DIGESER DI LAYAR

UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MinimizeBtn

UIStroke.Parent = MinimizeBtn
UIStroke.Color = Color3.fromRGB(255, 0, 0)
UIStroke.Thickness = 2

-- Gradasi Merah-Hitam untuk Tombol XZ
UIGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(200, 0, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 0, 0))
}
UIGradient.Rotation = 45
UIGradient.Parent = MinimizeBtn

-- System Inject Gradient & Hide Orion Native Buttons
task.spawn(function()
    task.wait(0.6)
    local OrionUI = CoreGui:FindFirstChild("Orion") or CoreGui:FindFirstChild("OrionLibrary")
    if OrionUI then
        local MainFrame = OrionUI:FindFirstChild("Main", true) or OrionUI:FindFirstChild("Container", true)
        
        -- Paksa UI Utama Berwarna Gradasi Merah-Hitam & Transparan
        if MainFrame then
            MainFrame.BackgroundTransparency = 0.25
            
            -- Buat Gradient di Background Utama
            local MainGrad = Instance.new("UIGradient")
            MainGrad.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0, Color3.fromRGB(160, 0, 0)), -- Merah
                ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 10, 10))  -- Hitam
            }
            MainGrad.Rotation = 135
            MainGrad.Parent = MainFrame

            -- Cari dan Sembunyikan Tombol Minimize/Close Bawaan Library agar tidak memanjang
            for _, child in pairs(MainFrame:GetDescendants()) do
                if child:IsA("ImageButton") or child:IsA("TextButton") then
                    if child.Name == "Close" or child.Name == "Minimize" or child.Name == "More" then
                        child.Visible = false
                    end
                end
            end
        end

        -- Fungsi Klik Kotak XZ untuk Membuka Kembali UI
        MinimizeBtn.MouseButton1Click:Connect(function()
            if MainFrame then
                MainFrame.Visible = true
                MinimizeGui.Enabled = false
            end
        end)
    end
end)

-- Tombol Minimize Manual & Close di dalam Tab Info
InfoTab:AddButton({
    Name = "Minimize UI (Sembunyikan ke Logo XZ)",
    Callback = function()
        local OrionUI = CoreGui:FindFirstChild("Orion") or CoreGui:FindFirstChild("OrionLibrary")
        if OrionUI then
            local MainFrame = OrionUI:FindFirstChild("Main", true) or OrionUI:FindFirstChild("Container", true)
            if MainFrame then
                MainFrame.Visible = false
                MinimizeGui.Enabled = true -- Munculkan hanya tombol kotak XZ
            end
        end
    end
})

InfoTab:AddButton({
    Name = "Tutup Script (Close UI)",
    Callback = function()
        OrionLib:MakeNotification({
            Name = "Konfirmasi Peringatan",
            Content = "Jika ditutup, Anda harus mere-execute script agar dapat berjalan kembali!",
            Image = "rbxassetid://4483345998",
            Time = 4
        })
        
        task.wait(0.8)
        
        OrionLib:Destroy()
        if CoreGui:FindFirstChild("ExzetMinimizeGui") then
            CoreGui.ExzetMinimizeGui:Destroy()
        end
    end    
})

OrionLib:Init()
