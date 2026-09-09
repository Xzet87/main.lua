local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
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
MainFrame.Position = UDim2.new(0.5, -230, 0.5, -185)
MainFrame.Size = UDim2.new(0, 460, 0, 380)
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
Title.Size = UDim2.new(0, 280, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "Exzet Hub v1.6 (Anime Dice - Touch Fix)"
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

-------------------------------------------------------------------
-- 3. CONFIRMATION POPUP (WARNING CLOSE)
-------------------------------------------------------------------
local ConfirmOverlay = Instance.new("Frame")
ConfirmOverlay.Name = "ConfirmOverlay"
ConfirmOverlay.Parent = ExzetHubUI
ConfirmOverlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ConfirmOverlay.BackgroundTransparency = 0.5
ConfirmOverlay.Size = UDim2.new(1, 0, 1, 0)
ConfirmOverlay.Visible = false
ConfirmOverlay.Active = true

local ConfirmBox = Instance.new("Frame")
ConfirmBox.Parent = ConfirmOverlay
ConfirmBox.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
ConfirmBox.Position = UDim2.new(0.5, -150, 0.5, -75)
ConfirmBox.Size = UDim2.new(0, 300, 0, 130)

local BoxCorner = Instance.new("UICorner")
BoxCorner.CornerRadius = UDim.new(0, 8)
BoxCorner.Parent = ConfirmBox

local BoxStroke = Instance.new("UIStroke")
BoxStroke.Parent = ConfirmBox
BoxStroke.Color = Color3.fromRGB(255, 50, 50)
BoxStroke.Thickness = 1.5

local WarningText = Instance.new("TextLabel")
WarningText.Parent = ConfirmBox
WarningText.BackgroundTransparency = 1
WarningText.Position = UDim2.new(0, 10, 0, 15)
WarningText.Size = UDim2.new(1, -20, 0, 50)
WarningText.Font = Enum.Font.GothamMedium
WarningText.Text = "Yakin ingin menutup Hub?\nKamu harus Re-Execute script jika ingin membukanya kembali!"
WarningText.TextColor3 = Color3.fromRGB(255, 255, 255)
WarningText.TextSize = 12
WarningText.TextWrapped = true

local YesBtn = Instance.new("TextButton")
YesBtn.Parent = ConfirmBox
YesBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
YesBtn.Position = UDim2.new(0, 20, 1, -45)
YesBtn.Size = UDim2.new(0, 120, 0, 30)
YesBtn.Font = Enum.Font.GothamBold
YesBtn.Text = "Ya, Tutup"
YesBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
YesBtn.TextSize = 12

local YesCorner = Instance.new("UICorner")
YesCorner.CornerRadius = UDim.new(0, 6)
YesCorner.Parent = YesBtn

local NoBtn = Instance.new("TextButton")
NoBtn.Parent = ConfirmBox
NoBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
NoBtn.Position = UDim2.new(1, -140, 1, -45)
NoBtn.Size = UDim2.new(0, 120, 0, 30)
NoBtn.Font = Enum.Font.GothamBold
NoBtn.Text = "Batal"
NoBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
NoBtn.TextSize = 12

local NoCorner = Instance.new("UICorner")
NoCorner.CornerRadius = UDim.new(0, 6)
NoCorner.Parent = NoBtn

-- Button Event Logic
MinimizeBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    ToggleIconBtn.Visible = true
end)

ToggleIconBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    ToggleIconBtn.Visible = false
end)

CloseBtn.MouseButton1Click:Connect(function()
    ConfirmOverlay.Visible = true
end)

YesBtn.MouseButton1Click:Connect(function()
    ExzetHubUI:Destroy()
end)

NoBtn.MouseButton1Click:Connect(function()
    ConfirmOverlay.Visible = false
end)

-------------------------------------------------------------------
-- TAB NAVIGATION (MAIN, SHOP, MISC)
-------------------------------------------------------------------
local TabBar = Instance.new("Frame")
TabBar.Parent = MainFrame
TabBar.BackgroundTransparency = 1
TabBar.Position = UDim2.new(0, 8, 0, 45)
TabBar.Size = UDim2.new(0, 100, 1, -50)

local UIListLayoutTab = Instance.new("UIListLayout")
UIListLayoutTab.Parent = TabBar
UIListLayoutTab.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayoutTab.Padding = UDim.new(0, 6)

local function createTabButton(name, defaultActive)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 32)
    btn.Font = Enum.Font.GothamBold
    btn.Text = name
    btn.TextSize = 13
    btn.Parent = TabBar
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn
    
    if defaultActive then
        btn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    else
        btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        btn.TextColor3 = Color3.fromRGB(180, 180, 180)
    end
    return btn
end

local MainTabBtn = createTabButton("Main", true)
local ShopTabBtn = createTabButton("Shop", false)
local MiscTabBtn = createTabButton("Misc", false)

-- PAGES CONTAINER
local ContentContainer = Instance.new("Frame")
ContentContainer.Parent = MainFrame
ContentContainer.BackgroundTransparency = 1
ContentContainer.Position = UDim2.new(0, 115, 0, 45)
ContentContainer.Size = UDim2.new(1, -125, 1, -50)

local function createPage()
    local page = Instance.new("ScrollingFrame")
    page.Parent = ContentContainer
    page.BackgroundTransparency = 1
    page.Size = UDim2.new(1, 0, 1, 0)
    page.Visible = false
    page.CanvasSize = UDim2.new(0, 0, 0, 500)
    page.ScrollBarThickness = 4
    
    local layout = Instance.new("UIListLayout")
    layout.Parent = page
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 8)
    return page
end

local MainPage = createPage()
local ShopPage = createPage()
local MiscPage = createPage()

MainPage.Visible = true

-- Tab Switching Logic
local function switchTab(activeBtn, activePage)
    MainTabBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35); MainTabBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
    ShopTabBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35); ShopTabBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
    MiscTabBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35); MiscTabBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
    
    MainPage.Visible = false
    ShopPage.Visible = false
    MiscPage.Visible = false
    
    activeBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
    activeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    activePage.Visible = true
end

MainTabBtn.MouseButton1Click:Connect(function() switchTab(MainTabBtn, MainPage) end)
ShopTabBtn.MouseButton1Click:Connect(function() switchTab(ShopTabBtn, ShopPage) end)
MiscTabBtn.MouseButton1Click:Connect(function() switchTab(MiscTabBtn, MiscPage) end)

-------------------------------------------------------------------
-- HELPER FUNGSI TOGGLE
-------------------------------------------------------------------
local activeFeatures = {}

local function createFeatureToggle(parentPage, name, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -5, 0, 32)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    btn.Font = Enum.Font.GothamBold
    btn.Text = name .. " : OFF"
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.TextSize = 12
    btn.Parent = parentPage

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn

    activeFeatures[name] = false

    btn.MouseButton1Click:Connect(function()
        activeFeatures[name] = not activeFeatures[name]
        local state = activeFeatures[name]
        
        if state then
            btn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            btn.Text = name .. " : ON"
        else
            btn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
            btn.TextColor3 = Color3.fromRGB(200, 200, 200)
            btn.Text = name .. " : OFF"
        end
        
        callback(state, function()
            return activeFeatures[name]
        end)
    end)
end

-------------------------------------------------------------------
-- TAB 1: MAIN (FULL AUTO)
-------------------------------------------------------------------

-- Auto Roll Dice
createFeatureToggle(MainPage, "Auto Roll Dice", function(state, isRunning)
    if not state then return end
    task.spawn(function()
        while isRunning() do
            pcall(function()
                local network = ReplicatedStorage:FindFirstChild("Network")
                if network and network:FindFirstChild("RollService") then
                    local rollService = network.RollService
                    if rollService:FindFirstChild("RF") and rollService.RF:FindFirstChild("RollDice") then
                        rollService.RF.RollDice:InvokeServer()
                    end
                    if rollService:FindFirstChild("RE") and rollService.RE:FindFirstChild("Roll") then
                        rollService.RE.Roll:FireServer()
                    end
                end
            end)
            task.wait(0.2)
        end
    end)
end)

-- Auto Collect Cash (Fixed: Menyentuh/menginjak kotak hijau collector di map secara otomatis)
createFeatureToggle(MainPage, "Auto Collect Cash", function(state, isRunning)
    if not state then return end
    task.spawn(function()
        while isRunning() do
            pcall(function()
                local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    for _, obj in pairs(Workspace:GetDescendants()) do
                        if obj:IsA("BasePart") then
                            local name = obj.Name:lower()
                            -- Deteksi kotak hijau tempat kumpul cash/income di game
                            if name:find("collect") or name:find("cash") or name:find("money") or name:find("balance") or (obj.Color and obj.Color.G > 0.5 and obj.Color.R < 0.3) then
                                local oldPos = hrp.CFrame
                                hrp.CFrame = obj.CFrame + Vector3.new(0, 3, 0)
                                task.wait(0.05)
                                if firetouchinterest then
                                    firetouchinterest(hrp, obj, 0)
                                    firetouchinterest(hrp, obj, 1)
                                end
                                task.wait(0.1)
                                hrp.CFrame = oldPos
                                break
                            end
                        end
                    end
                end
            end)
            task.wait(1.5)
        end
    end)
end)

-- Auto Claim Rewards
createFeatureToggle(MainPage, "Auto Claim Rewards", function(state, isRunning)
    if not state then return end
    task.spawn(function()
        while isRunning() do
            pcall(function()
                local network = ReplicatedStorage:FindFirstChild("Network")
                if network then
                    local services = {"DailyRewardService", "GroupRewardService", "QuestService", "OfflineEarningsService", "RewardService"}
                    for _, sName in ipairs(services) do
                        local serv = network:FindFirstChild(sName)
                        if serv then
                            if serv:FindFirstChild("RE") and serv.RE:FindFirstChild("Claim") then
                                serv.RE.Claim:FireServer()
                            elseif serv:FindFirstChild("RF") and serv.RF:FindFirstChild("Claim") then
                                serv.RF.Claim:InvokeServer()
                            end
                        end
                    end
                end
            end)
            task.wait(3)
        end
    end)
end)


-------------------------------------------------------------------
-- TAB 2: SHOP & BEST EQUIPPED
-------------------------------------------------------------------

-- Auto Sell Equipped
createFeatureToggle(ShopPage, "Auto Sell Equipped", function(state, isRunning)
    if not state then return end
    task.spawn(function()
        while isRunning() do
            pcall(function()
                local network = ReplicatedStorage:FindFirstChild("Network")
                if network and network:FindFirstChild("SellService") then
                    local sellService = network.SellService
                    if sellService:FindFirstChild("RE") and sellService.RE:FindFirstChild("SellEquipped") then
                        sellService.RE.SellEquipped:FireServer()
                    end
                end
            end)
            task.wait(1.5)
        end
    end)
end)

-- Auto Best Equipped
createFeatureToggle(ShopPage, "Auto Best Equipped", function(state, isRunning)
    if not state then return end
    task.spawn(function()
        while isRunning() do
            pcall(function()
                local network = ReplicatedStorage:FindFirstChild("Network")
                if network then
                    local equipServices = {"InventoryService", "EquipmentService", "DiceService", "CardService", "ItemService"}
                    for _, sName in ipairs(equipServices) do
                        local serv = network:FindFirstChild(sName)
                        if serv then
                            if serv:FindFirstChild("RE") then
                                if serv.RE:FindFirstChild("EquipBest") then serv.RE.EquipBest:FireServer() end
                                if serv.RE:FindFirstChild("EquipBestRarity") then serv.RE.EquipBestRarity:FireServer() end
                            end
                            if serv:FindFirstChild("RF") then
                                if serv.RF:FindFirstChild("EquipBest") then serv.RF.EquipBest:InvokeServer() end
                            end
                        end
                    end
                end
            end)
            task.wait(3)
        end
    end)
end)

-- Auto Buy Upgrade Dice
createFeatureToggle(ShopPage, "Auto Buy Upgrade Dice", function(state, isRunning)
    if not state then return end
    task.spawn(function()
        while isRunning() do
            pcall(function()
                local network = ReplicatedStorage:FindFirstChild("Network")
                if network and network:FindFirstChild("BuyUpgrade") then
                    network.BuyUpgrade:FireServer("DiceSpeed")
                end
            end)
            task.wait(1.5)
        end
    end)
end)

-- Auto Buy Dice
createFeatureToggle(ShopPage, "Auto Buy Dice", function(state, isRunning)
    if not state then return end
    task.spawn(function()
        while isRunning() do
            pcall(function()
                local network = ReplicatedStorage:FindFirstChild("Network")
                if network and network:FindFirstChild("DiceShopService") then
                    local shop = network.DiceShopService
                    if shop:FindFirstChild("RE") and shop.RE:FindFirstChild("BuyDice") then
                        shop.RE.BuyDice:FireServer(1)
                    end
                end
            end)
            task.wait(1)
        end
    end)
end)


-------------------------------------------------------------------
-- TAB 3: MISC & WEBHOOK SETTINGS
-------------------------------------------------------------------

-- WalkSpeed Input & Toggle
local speedBox = Instance.new("TextBox")
speedBox.Size = UDim2.new(1, -5, 0, 30)
speedBox.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
speedBox.Font = Enum.Font.GothamMedium
speedBox.PlaceholderText = "Masukkan WalkSpeed (default 16)"
speedBox.Text = "16"
speedBox.TextColor3 = Color3.fromRGB(255, 255, 255)
speedBox.TextSize = 12
speedBox.Parent = MiscPage

local boxCorner = Instance.new("UICorner")
boxCorner.CornerRadius = UDim.new(0, 6)
boxCorner.Parent = speedBox

createFeatureToggle(MiscPage, "Custom WalkSpeed", function(state, isRunning)
    task.spawn(function()
        while isRunning() do
            pcall(function()
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                    local speed = tonumber(speedBox.Text) or 16
                    LocalPlayer.Character.Humanoid.WalkSpeed = speed
                end
            end)
            task.wait(0.1)
        end
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = 16
        end
    end)
end)

-- Infinite Jump
local infJumpActive = false
createFeatureToggle(MiscPage, "Infinite Jump", function(state)
    infJumpActive = state
end)

UserInputService.JumpRequest:Connect(function()
    if infJumpActive and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

-- Anti AFK
createFeatureToggle(MiscPage, "Anti AFK", function(state, isRunning)
    if not state then return end
    task.spawn(function()
        local vu = game:GetService("VirtualUser")
        local connection
        connection = LocalPlayer.Idled:Connect(function()
            if isRunning() then
                vu:Button2Down(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
                task.wait(1)
                vu:Button2Up(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
            end
        end)
        while isRunning() do
            task.wait(1)
        end
        if connection then
            connection:Disconnect()
        end
    end)
end)

-- Webhook Inputs & Mode Config
local webhookBox = Instance.new("TextBox")
webhookBox.Size = UDim2.new(1, -5, 0, 30)
webhookBox.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
webhookBox.Font = Enum.Font.GothamMedium
webhookBox.PlaceholderText = "Paste Discord Webhook URL..."
webhookBox.Text = ""
webhookBox.TextColor3 = Color3.fromRGB(255, 255, 255)
webhookBox.TextSize = 11
webhookBox.Parent = MiscPage

local wbCorner = Instance.new("UICorner")
wbCorner.CornerRadius = UDim.new(0, 6)
wbCorner.Parent = webhookBox

local rarityBox = Instance.new("TextBox")
rarityBox.Size = UDim2.new(1, -5, 0, 30)
rarityBox.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
rarityBox.Font = Enum.Font.GothamMedium
rarityBox.PlaceholderText = "Filter Rarity (cth: Secret,Mythical)"
rarityBox.Text = "Secret,Mythical"
rarityBox.TextColor3 = Color3.fromRGB(255, 255, 255)
rarityBox.TextSize = 11
rarityBox.Parent = MiscPage

local rbCorner = Instance.new("UICorner")
rbCorner.CornerRadius = UDim.new(0, 6)
rbCorner.Parent = rarityBox

local testWebhookBtn = Instance.new("TextButton")
testWebhookBtn.Size = UDim2.new(1, -5, 0, 32)
testWebhookBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 180)
testWebhookBtn.Font = Enum.Font.GothamBold
testWebhookBtn.Text = "Test Webhook & Filter Rarity"
testWebhookBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
testWebhookBtn.TextSize = 12
testWebhookBtn.Parent = MiscPage

local twCorner = Instance.new("UICorner")
twCorner.CornerRadius = UDim.new(0, 6)
twCorner.Parent = testWebhookBtn

local function sendWebhook(url, itemName, itemRarity)
    if not url or url == "" then return end
    local filters = rarityBox.Text:lower()
    if filters ~= "" and not filters:find(itemRarity:lower()) then
        return
    end

    local data = {
        ["content"] = "@everyone Hoki Besar! Dapat item langka!",
        ["embeds"] = {{
            ["title"] = "⭐ Exzet Hub - Drop Alert",
            ["description"] = "**Player:** " .. LocalPlayer.Name .. "\n**Item:** " .. itemName .. "\n**Rarity:** `" .. itemRarity .. "`",
            ["color"] = 16766720,
            ["footer"] = {["text"] = "Anime Dice - Auto Notifier"}
        }}
    }
    local body = HttpService:JSONEncode(data)
    local headers = {["content-type"] = "application/json"}
    local request = http_request or request or syn.request
    if request then
        pcall(function()
            request({Url = url, Body = body, Method = "POST", Headers = headers})
        end)
    end
end

testWebhookBtn.MouseButton1Click:Connect(function()
    local url = webhookBox.Text
    if url ~= "" and url:find("discord.com/api/webhooks") then
        sendWebhook(url, "Gojo / Anime God (Test)", "Secret")
        testWebhookBtn.Text = "Webhook Berhasil di-Test!"
        task.wait(2)
        testWebhookBtn.Text = "Test Webhook & Filter Rarity"
    else
        testWebhookBtn.Text = "URL Webhook Salah!"
        task.wait(2)
        testWebhookBtn.Text = "Test Webhook & Filter Rarity"
    end
end)
