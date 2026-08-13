-- [[ EXZET HUB UI SCRIPT ]] --

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
-- CUSTOMIZATION: Warna Red-Black Gradient & Transparansi UI
-------------------------------------------------------------------
local CoreGui = game:GetService("CoreGui")
task.spawn(function()
    task.wait(0.5) -- Tunggu UI ter-load sepenuhnya
    
    -- Mencari UI Orion di CoreGui
    local OrionUI = CoreGui:FindFirstChild("Orion") or CoreGui:FindFirstChild("OrionLibrary")
    if OrionUI then
        for _, v in pairs(OrionUI:GetDescendants()) do
            -- Mengubah Frame utama menjadi semi-transparan dengan tema Hitam & Merah
            if v:IsA("Frame") or v:IsA("ScrollingFrame") then
                v.BackgroundTransparency = 0.35 -- Transparansi background
                
                -- Memberikan warna dasarnya hitam/gelap
                if v.BackgroundColor3 == Color3.fromRGB(25, 25, 25) or v.BackgroundColor3 == Color3.fromRGB(35, 35, 35) then
                    v.BackgroundColor3 = Color3.fromRGB(15, 0, 0) -- Hitam ke-merahan
                end
            end
            
            -- Menyesuaikan border / stroke warna merah terang
            if v:IsA("UIStroke") then
                v.Color = Color3.fromRGB(220, 20, 60) -- Merah crimson
            end
            
            -- Menyesuaikan warna gradasi jika ada
            if v:IsA("UIGradient") then
                v.Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(180, 0, 0)), -- Merah
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 10, 10))  -- Hitam
                }
            end
        end
    end
end)

-------------------------------------------------------------------
-- NAVIGATION TABS
-------------------------------------------------------------------

-- Tab Info
local InfoTab = Window:MakeTab({
    Name = "Info",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- Tab Main (Kosong)
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

InfoTab:AddParagraph("Discord Community", "Join Discord resmi kami untuk mendapatkan link script terbaru dan update mendatang!")

InfoTab:AddButton({
    Name = "Salin Link Discord",
    Callback = function()
        setclipboard("https://discord.gg/yourlinkhere") -- Ganti dengan link Discord kamu
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
-- MINIMIZE LOGO (XZ) & TOMBOL CLOSE CONFIRMATION
-------------------------------------------------------------------

-- Membuat ScreenGui terpisah untuk Logo Minimize 'XZ'
local MinimizeGui = Instance.new("ScreenGui")
local MinimizeBtn = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")
local UIStroke = Instance.new("UIStroke")

MinimizeGui.Name = "ExzetMinimizeGui"
MinimizeGui.Parent = game:GetService("CoreGui")
MinimizeGui.Enabled = false -- Default tersembunyi

MinimizeBtn.Parent = MinimizeGui
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(20, 0, 0)
MinimizeBtn.Position = UDim2.new(0.02, 0, 0.2, 0)
MinimizeBtn.Size = UDim2.new(0, 45, 0, 45)
MinimizeBtn.Font = Enum.Font.SourceSansBold
MinimizeBtn.Text = "XZ"
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 30, 30)
MinimizeBtn.TextSize = 22.000
MinimizeBtn.Active = true
MinimizeBtn.Draggable = true -- BISA DIGESER DILAYAR

UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MinimizeBtn

UIStroke.Parent = MinimizeBtn
UIStroke.Color = Color3.fromRGB(255, 0, 0)
UIStroke.Thickness = 2

-- Kustomisasi tombol bawaan Orion (Minimize & Close)
task.spawn(function()
    task.wait(0.6)
    local OrionUI = CoreGui:FindFirstChild("Orion") or CoreGui:FindFirstChild("OrionLibrary")
    if OrionUI then
        local MainFrame = OrionUI:FindFirstChild("Main", true) or OrionUI:FindFirstChild("Container", true)
        
        -- Event ketika Minimize ditekan
        MinimizeBtn.MouseButton1Click:Connect(function()
            if MainFrame then
                MainFrame.Visible = true
                MinimizeGui.Enabled = false
            end
        end)
        
        -- Override tombol close default dengan dialog konfirmasi
        -- (Menggunakan dialog bawaan Orion atau sistem Bindable)
    end
end)

-- Menambahkan tombol Exit manual di Tab Info untuk Konfirmasi Re-execute
InfoTab:AddButton({
    Name = "Tutup Script (Close UI)",
    Callback = function()
        -- Dialog Konfirmasi
        OrionLib:MakeNotification({
            Name = "Konfirmasi Peringatan",
            Content = "Jika Anda menutup UI ini, Anda harus mere-execute script agar dapat berjalan kembali!",
            Image = "rbxassetid://4483345998",
            Time = 5
        })
        
        task.wait(1)
        
        -- Unload / Hapus UI
        OrionLib:Destroy()
        if game:GetService("CoreGui"):FindFirstChild("ExzetMinimizeGui") then
            game:GetService("CoreGui").ExzetMinimizeGui:Destroy()
        end
    end    
})

-- Memastikan Orion UI siap
OrionLib:Init()
