-- by JackEyeKL



local repo
if UIStyle == "LinoriaLib" then
repo = 'https://raw.githubusercontent.com/mstudio45/LinoriaLib/main/'
else
repo = 'https://raw.githubusercontent.com/javaKL666/Obsidian/main/'
end






local Library
if UIStyle == "LinoriaLib" then
Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
else
Library = loadstring(game:HttpGet(repo .. "DearReg.lua"))()
end

Executor = identifyexecutor() or getexecutorname() or "Unknown"

local ThemeManager 
if UIStyle == "LinoriaLib" then
ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
else
ThemeManager = loadstring(game:HttpGet(repo .. "ThemeManager.lua"))()
end

local SaveManager
if UIStyle == "LinoriaLib" then
SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()
else
SaveManager = loadstring(game:HttpGet(repo .. "SaveManager.lua"))()
end

Library:SetWatermarkVisibility(true)

    local function updateWatermark()
        local fps = 60
        local frameTimer = tick()
        local frameCounter = 0

        game:GetService('RunService').RenderStepped:Connect(function()
            frameCounter = frameCounter + 1

            if ((tick() - frameTimer) >= 1) then
                fps = frameCounter
                frameTimer = tick()
                frameCounter = 0
            end

            Library:SetWatermark(string.format('LightStar | %d FPS | JackEyeKL | %d ping ', math.floor(fps), math.floor(game:GetService('Stats').Network.ServerStatsItem['Data Ping']:GetValue())))
        end)
    end

    updateWatermark()

local Options = Library.Options
local Toggles = Library.Toggles

-- 准备就读
--[[
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local localPlayer = localPlayer
local Workspace = game:GetService("Workspace")
local localPlayer = Players.LocalPlayer
local PathfindingService = game:GetService("PathfindingService")
local replicatedStorage = game:GetService("ReplicatedStorage")
local Network = replicatedStorage:WaitForChild("Modules"):WaitForChild("Network")
local gameMap = workspace.Map
local actor = Network:WaitForChild("RemoteEvent")
--]]

if not table.clone then
    table.clone = function(t)
        local nt = {}
        for k,v in pairs(t) do nt[k] = v end
        return nt
    end
end

local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
local gameMap = workspace.Map
local replicatedStorage = game:GetService("ReplicatedStorage")
local Network = replicatedStorage:WaitForChild("Modules"):WaitForChild("Network")

Library.ForceCheckbox = false -- 默认点击开关盒子 (false / true)
Library.ShowToggleFrameInKeybinds = true 

local Window = Library:CreateWindow({
	Title = "LightStar",
	Footer = "LightStar团队脚本-discord.gg/BW55cR7Z [来源Nolsaken]",
	Icon = 17261823399,
})
--biohazard
local Tabs = {
    new = Window:AddTab('主持','external-link','公告&信息'),
    Esp = Window:AddTab('ESP','scan-eye','让你能够透视他们!!!'),
    Aimbot = Window:AddTab('自瞄','cross','让你自瞄的更准!!!'),
    NotificationListen = Window:AddTab('通知提示','mails','让你帮助你监听杀手!!!'),
    BanEffect = Window:AddTab('反效果&角色','cpu','让你无法受到效果!!!'),
    Main = Window:AddTab('杂项','user','这是主要的!!!'),
    FightingKilling = Window:AddTab('战斗&杀戮','swords','让变得打击更轻松!!!'),
    Block = Window:AddTab('格挡','target','让你自动抵御杀手的攻击!!!'),
    Mess = Window:AddTab('杂乱','biohazard','很多功能杂乱在这里'),
    PhysicalStrength = Window:AddTab('体力','zap','让你奔跑体力最大!!!'),
    Generator = Window:AddTab('发动机','printer','让你修发动机更快!!!'),
    Settings = Window:AddTab("设置","settings",'设置&调试'),
    --Addons = Window:AddTab("插件","boxes",'这是功能添加!!!'),
}

--Addons = Tabs.Addons:AddLeftGroupbox('插件&附加','blocks')

local _env = getgenv and getgenv() or {}

task.spawn(function()
    while task.wait() do
        local _isKiller = false

        if workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Killers") then
            for _, v in pairs(workspace.Players.Killers:GetChildren()) do
                if v:GetAttribute("Username") and game.Players:FindFirstChild(v:GetAttribute("Username")) then
                    killerModel = v
                end

                if v:GetAttribute("Username") == localPlayer.Name then
                    killerModel = v
                    _isKiller = true
                end
            end

            isSurvivor = not _isKiller
            isKiller = _isKiller
        end
    end
end)

local function hasAbility(name)
    return localPlayer.PlayerGui.MainUI:FindFirstChild("AbilityContainer")
        and localPlayer.PlayerGui.MainUI.AbilityContainer:FindFirstChild(name)
end

local function hasAbilityReady(name)
    if not hasAbility(name) then
        return false
    end

    return hasAbility(name).CooldownTime.Text == ""
end

function killerAttack()
    if hasAbilityReady("\x03\x05\x00\x00\x00Slash") then
        Network.RemoteEvent:FireServer("UseActorAbility", {buffer.fromstring("\x03\x05\x00\x00\x00Slash")})
    elseif hasAbilityReady("\x03\x04\x00\x00\x00Stab") then
        Network.RemoteEvent:FireServer("UseActorAbility", {buffer.fromstring("\x03\x04\x00\x00\x00Stab")})
    elseif hasAbilityReady("Carving Slash") then
        Network.RemoteEvent:FireServer("UseActorAbility", {buffer.fromstring("\"Carving Slash\"")})
    end
end

pcall(function()
    if workspace.Players.Spectating:FindFirstChild(localPlayer.Name) then
        playingState = "Spectating"
    else
        playingState = "Playing"
    end

    workspace.Players.Spectating.ChildAdded:Connect(function(v)
        if v.Name == localPlayer.Name then
            playingState = "Spectating"
            Library:Notify("LightStar-提示\n下局初始化 请你等待", 3)
        end
    end)

    workspace.Players.Spectating.ChildRemoved:Connect(function(v)
        if v.Name == localPlayer.Name then
            playingState = "Playing"
            Library:Notify("LightStar-提示\n初始化对局游戏", 3)
        end
    end)
end)

--[[
local new = Tabs.new:AddLeftGroupbox('新闻','rocket')

new:AddLabel("[+]开发 JackEyeKL")
new:AddLabel("支持是我们的最大的贡献😜")
new:AddLabel("脚本更新于1.31 晚上 10:42 时间")
--]]

--[[
local information = Tabs.new:AddLeftGroupbox('玩家 信息','info')

information:AddLabel("执行器 : " ..identifyexecutor())
information:AddLabel("用户名 : " ..game.Players.LocalPlayer.Name)
information:AddLabel("用户Id : "..game.Players.LocalPlayer.UserId)
information:AddLabel("昵称 : "..game.Players.LocalPlayer.DisplayName)
information:AddLabel("用户年龄 : "..game.Players.LocalPlayer.AccountAge.." 天")
--]]

local UpdateText = 
"新更新<b><font color=\"rgb(0, 255, 255)\">LightStar脚本</font></b>内容\n=======新更新=======\n"

-- 添加<b><font color=\"rgb(0, 255, 0)\">功能</font></b>功能了

local Update = Tabs.new

Update:UpdateWarningBox({
    Title = "=====<b><font color=\"rgb(0, 255, 0)\">更新&日志&脚本</font></b>======",
    Text = UpdateText,
    IsNormal = true, -- 错误盒子 = false, 正常盒子 = true
    Visible = true,
    LockSize = true,
})

local profile = Tabs.new:AddLeftGroupbox('个人资料','info')

    local Players = game:GetService('Players')
    local player = Players.LocalPlayer
    local avatarImage = profile:AddImage('AvatarThumbnail', {
        Image = 'rbxassetid://0',
        Callback = function(image)
            print('Image changed!', image)
        end,
    })

    task.spawn(function()
        repeat
            task.wait()
        until player

        task.wait(1)

        local success, thumbnail = pcall(function()
            return Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size180x180)
        end)

        if (success and thumbnail) then
            avatarImage:SetImage(thumbnail)
        else
            local alternatives = {
                Enum.ThumbnailType.AvatarThumbnail,
                Enum.ThumbnailType.AvatarBust,
                Enum.ThumbnailType.Avatar,
            }

            for _, thumbnailType in ipairs(alternatives)do
                local altSuccess, altThumbnail = pcall(function()
                    return Players:GetUserThumbnailAsync(player.UserId, thumbnailType, Enum.ThumbnailSize.Size180x180)
                end)

                if (altSuccess and altThumbnail) then
                    avatarImage:SetImage(altThumbnail)

                    break
                end
            end
        end
    end)
    
profile:AddLabel("Good 嘿起来！"..game.Players.LocalPlayer.Name..".")
profile:AddLabel("Solo1...")
profile:AddLabel("支持是我们的最大的贡献😜")

profile:AddDivider()

profile:AddLabel("注入器 : " ..identifyexecutor())

--[[
local information = Tabs.new:AddRightGroupbox('信息','info')

information:AddLabel("Welcome来到<b><font color=\"rgb(0, 255, 0)\">LightStar</font></b> 玩的高兴")

information:AddDivider()

information:AddLabel("🟢 脚本已更新")
--]]

local Contributor = Tabs.new:AddRightGroupbox('鸣谢&贡献者','handshake')

Contributor:AddLabel("[<b><font color=\"rgb(0, 0, 255)\">JackEyeKL</font></b>] - 脚本所有者")

Contributor:AddLabel("[<b><font color=\"rgb(128, 0, 128)\">Yuxingchen</font></b>] - 提供Nol原脚本终极源码")

local Visual = Tabs.Esp:AddRightGroupbox("高亮ESP",'ratio')

-- 高亮ESP设置
local HighlightSettings = {
    ShowSurvivorHighlights = true,
    ShowKillerHighlights = true,
    FillTransparency = 0.5,
    OutlineTransparency = 0,
    connection = nil,
    highlights = {}  -- 存储所有高亮对象
}

-- 更新颜色预设
HighlightSettings.SurvivorColors = {
    ["绿色"] = Color3.fromRGB(0, 255, 0),
    ["白色"] = Color3.fromRGB(255, 255, 255),
    ["紫色"] = Color3.fromRGB(128, 0, 128),
    ["青色"] = Color3.fromRGB(0, 255, 255),
    ["橙色"] = Color3.fromRGB(255, 165, 0),
    ["柠檬绿"] = Color3.fromRGB(173, 255, 47)  -- 新增柠檬绿
}

HighlightSettings.KillerColors = {
    ["红色"] = Color3.fromRGB(255, 0, 0),
    ["粉色"] = Color3.fromRGB(255, 105, 180),
    ["黑色"] = Color3.fromRGB(0, 0, 0),
    ["蓝色"] = Color3.fromRGB(0, 0, 255),
    ["猩红色"] = Color3.fromRGB(220, 20, 60),  -- 新增猩红色
    ["杏色"] = Color3.fromRGB(251, 206, 177)   -- 新增杏色
}

-- 边缘颜色使用与填充颜色相同的选项
HighlightSettings.SurvivorOutlineColors = table.clone(HighlightSettings.SurvivorColors)
HighlightSettings.KillerOutlineColors = table.clone(HighlightSettings.KillerColors)

-- 默认颜色
HighlightSettings.SelectedSurvivorColor = "青色"
HighlightSettings.SelectedKillerColor = "红色"
HighlightSettings.SelectedSurvivorOutlineColor = "青色"
HighlightSettings.SelectedKillerOutlineColor = "红色"

-- 清理高亮对象
local function cleanupHighlights()
    for _, highlight in pairs(HighlightSettings.highlights) do
        if highlight and highlight.Parent then
            highlight:Destroy()
        end
    end
    HighlightSettings.highlights = {}
end

-- 更新高亮显示
local function updateHighlights()
    local players = game:GetService("Players")
    local localPlayer = players.LocalPlayer
    
    -- 获取幸存者和杀手文件夹
    local survivorsFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Survivors")
    local killersFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Killers")
    
    -- 只处理幸存者和杀手
    local function processFolder(folder, isKiller)
        if not folder then return end
        
        for _, model in ipairs(folder:GetChildren()) do
            if model:IsA("Model") then
                -- 确定颜色
                local fillColor = isKiller and HighlightSettings.KillerColors[HighlightSettings.SelectedKillerColor] 
                                          or HighlightSettings.SurvivorColors[HighlightSettings.SelectedSurvivorColor]
                
                local outlineColor = isKiller and HighlightSettings.KillerOutlineColors[HighlightSettings.SelectedKillerOutlineColor] 
                                              or HighlightSettings.SurvivorOutlineColors[HighlightSettings.SelectedSurvivorOutlineColor]
                
                -- 根据设置决定是否显示
                if (isKiller and HighlightSettings.ShowKillerHighlights) or 
                   (not isKiller and HighlightSettings.ShowSurvivorHighlights) then
                    
                    if not HighlightSettings.highlights[model] then
                        local highlight = Instance.new("Highlight")
                        highlight.Parent = game.CoreGui
                        HighlightSettings.highlights[model] = highlight
                    end
                    
                    local highlight = HighlightSettings.highlights[model]
                    highlight.Adornee = model
                    highlight.FillColor = fillColor
                    highlight.OutlineColor = outlineColor
                    highlight.FillTransparency = HighlightSettings.FillTransparency
                    highlight.OutlineTransparency = HighlightSettings.OutlineTransparency
                elseif HighlightSettings.highlights[model] then
                    HighlightSettings.highlights[model].Adornee = nil
                end
            end
        end
    end
    
    -- 处理幸存者
    processFolder(survivorsFolder, false)
    
    -- 处理杀手
    processFolder(killersFolder, true)
    
    -- 清理不再存在的模型的高亮
    for model, highlight in pairs(HighlightSettings.highlights) do
        if not model or not model.Parent then
            highlight:Destroy()
            HighlightSettings.highlights[model] = nil
        end
    end
end

-- 主开关
Visual:AddCheckbox("HighlightToggle", {
    Text = "启用高亮ESP",
    Default = false,
    Callback = function(enabled)
        if enabled then
            -- 初始化连接
            if not HighlightSettings.connection then
                HighlightSettings.connection = game:GetService("RunService").RenderStepped:Connect(updateHighlights)
            end
        else
            -- 关闭连接
            if HighlightSettings.connection then
                HighlightSettings.connection:Disconnect()
                HighlightSettings.connection = nil
            end
            -- 清理高亮对象
            cleanupHighlights()
        end
    end
})

-- 幸存者开关
Visual:AddToggle("ShowSurvivorHighlights", {
    Text = "ESP幸存者高亮",
    Default = true,
    Callback = function(enabled)
        HighlightSettings.ShowSurvivorHighlights = enabled
    end
})

-- 杀手开关
Visual:AddToggle("ShowKillerHighlights", {
    Text = "ESP杀手高亮",
    Default = true,
    Callback = function(enabled)
        HighlightSettings.ShowKillerHighlights = enabled
    end
})

-- 幸存者填充颜色选择
Visual:AddDropdown("SurvivorFillColor", {
    Values = {"绿色", "白色", "紫色", "青色", "橙色", "柠檬绿"},
    Default = "青色",
    Text = "幸存者填充颜色",
    Callback = function(value)
        HighlightSettings.SelectedSurvivorColor = value
    end
})

-- 杀手填充颜色选择
Visual:AddDropdown("KillerFillColor", {
    Values = {"红色", "粉色", "黑色", "蓝色", "猩红色", "杏色"},
    Default = "红色",
    Text = "杀手填充颜色",
    Callback = function(value)
        HighlightSettings.SelectedKillerColor = value
    end
})

-- 幸存者边缘颜色选择
Visual:AddDropdown("SurvivorOutlineColor", {
    Values = {"绿色", "白色", "紫色", "青色", "橙色", "柠檬绿"},
    Default = "青色",
    Text = "幸存者边缘颜色",
    Callback = function(value)
        HighlightSettings.SelectedSurvivorOutlineColor = value
    end
})

-- 杀手边缘颜色选择
Visual:AddDropdown("KillerOutlineColor", {
    Values = {"红色", "粉色", "黑色", "蓝色", "猩红色", "杏色"},
    Default = "红色",
    Text = "杀手边缘颜色",
    Callback = function(value)
        HighlightSettings.SelectedKillerOutlineColor = value
    end
})

-- 填充透明度调节滑块
Visual:AddSlider("FillTransparency", {
    Text = "填充透明度",
    Min = 0,
    Max = 1,
    Default = 0.5,
    Rounding = 1,
    Compact = false,
    Callback = function(value)
        HighlightSettings.FillTransparency = value
    end
})

-- 边缘透明度调节滑块
Visual:AddSlider("OutlineTransparency", {
    Text = "边缘透明度",
    Min = 0,
    Max = 1,
    Default = 0,
    Rounding = 1,
    Compact = false,
    Callback = function(value)
        HighlightSettings.OutlineTransparency = value
    end
})

local Visual = Tabs.Esp:AddLeftGroupbox("角色名称ESP","proportions")

local NameTagSettings = {
    ShowSurvivorNames = true,
    ShowKillerNames = true,
    BaseTextSize = 14,
    MinTextSize = 10,
    MaxTextSize = 20,
    TextOffset = Vector3.new(0, 3, 0),
    DistanceScale = {
        MinDistance = 10,
        MaxDistance = 50
    },
    SurvivorColor = Color3.fromRGB(0, 191, 255),
    KillerColor = Color3.fromRGB(255, 0, 0),
    OutlineColor = Color3.fromRGB(0, 0, 0),
    ShowDistance = true
}

local NameTagDrawings = {}

local function createNameTagDrawing()
    local drawing = Drawing.new("Text")
    drawing.Size = NameTagSettings.BaseTextSize
    drawing.Center = true
    drawing.Outline = true
    drawing.OutlineColor = NameTagSettings.OutlineColor
    drawing.Font = 2
    return drawing
end

local function getHeadPosition(character)
    local head = character:FindFirstChild("Head")
    if head then
        local headHeight = head.Size.Y
        return head.Position + Vector3.new(0, headHeight + 0.5, 0)
    end
    return character:GetPivot().Position
end

local function cleanupInvalidDrawings()
    local players = game:GetService("Players")
    local survivors = workspace.Players:FindFirstChild("Survivors")
    local killers = workspace.Players:FindFirstChild("Killers")
    
    local validCharacters = {}
    if survivors then
        for _, survivor in ipairs(survivors:GetChildren()) do
            if survivor:IsA("Model") then
                validCharacters[survivor] = true
            end
        end
    end
    if killers then
        for _, killer in ipairs(killers:GetChildren()) do
            if killer:IsA("Model") then
                validCharacters[killer] = true
            end
        end
    end
    
    for model, drawing in pairs(NameTagDrawings) do
        if not validCharacters[model] then
            drawing:Remove()
            NameTagDrawings[model] = nil
        end
    end
end

local function updateNameTags()
    local camera = workspace.CurrentCamera
    local players = game:GetService("Players")
    local localPlayer = players.LocalPlayer
    local localCharacter = localPlayer.Character
    local localRoot = localCharacter and localCharacter:FindFirstChild("HumanoidRootPart")

    if not localRoot then return end
    
    cleanupInvalidDrawings()

    if NameTagSettings.ShowSurvivorNames then
        local survivors = workspace.Players:FindFirstChild("Survivors")
        if survivors then
            for _, survivor in ipairs(survivors:GetChildren()) do
                if survivor:IsA("Model") and survivor ~= localCharacter then
                    local humanoid = survivor:FindFirstChildOfClass("Humanoid")
                    
                    if not NameTagDrawings[survivor] then
                        NameTagDrawings[survivor] = createNameTagDrawing()
                    end
                    
                    local drawing = NameTagDrawings[survivor]
                    
                    if not humanoid or humanoid.Health <= 0 then
                        drawing.Visible = false
                        continue
                    end
                    
                    local headPos = getHeadPosition(survivor)
                    local screenPos, onScreen = camera:WorldToViewportPoint(headPos + NameTagSettings.TextOffset)
                    
                    if onScreen then
                        local distance = (headPos - localRoot.Position).Magnitude
                        local scale = math.clamp(
                            1 - (distance - NameTagSettings.DistanceScale.MinDistance) / 
                            (NameTagSettings.DistanceScale.MaxDistance - NameTagSettings.DistanceScale.MinDistance), 
                            0.3, 1
                        )
                        
                        local textSize = math.floor(NameTagSettings.BaseTextSize * scale)
                        textSize = math.clamp(textSize, NameTagSettings.MinTextSize, NameTagSettings.MaxTextSize)
                        
                        local displayText = survivor.Name
                        if NameTagSettings.ShowDistance then
                            displayText = string.format("%s [%d]", survivor.Name, math.floor(distance))
                        end
                        
                        drawing.Text = displayText
                        drawing.Color = NameTagSettings.SurvivorColor
                        drawing.Size = textSize
                        drawing.Position = Vector2.new(screenPos.X, screenPos.Y)
                        drawing.Visible = true
                    else
                        drawing.Visible = false
                    end
                end
            end
        end
    end

    if NameTagSettings.ShowKillerNames then
        local killers = workspace.Players:FindFirstChild("Killers")
        if killers then
            for _, killer in ipairs(killers:GetChildren()) do
                if killer:IsA("Model") then
                    local humanoid = killer:FindFirstChildOfClass("Humanoid")
                    
                    if not NameTagDrawings[killer] then
                        NameTagDrawings[killer] = createNameTagDrawing()
                    end
                    
                    local drawing = NameTagDrawings[killer]
                    
                    if not humanoid or humanoid.Health <= 0 then
                        drawing.Visible = false
                        continue
                    end
                    
                    local headPos = getHeadPosition(killer)
                    local screenPos, onScreen = camera:WorldToViewportPoint(headPos + NameTagSettings.TextOffset)
                    
                    if onScreen then
                        local distance = (headPos - localRoot.Position).Magnitude
                        local scale = math.clamp(
                            1 - (distance - NameTagSettings.DistanceScale.MinDistance) / 
                            (NameTagSettings.DistanceScale.MaxDistance - NameTagSettings.DistanceScale.MinDistance), 
                            0.3, 1
                        )
                        
                        local textSize = math.floor(NameTagSettings.BaseTextSize * scale)
                        textSize = math.clamp(textSize, NameTagSettings.MinTextSize, NameTagSettings.MaxTextSize)
                        
                        local displayText = killer.Name
                        if NameTagSettings.ShowDistance then
                            displayText = string.format("%s [%dm]", killer.Name, math.floor(distance))
                        end
                        
                        drawing.Text = displayText
                        drawing.Color = NameTagSettings.KillerColor
                        drawing.Size = textSize
                        drawing.Position = Vector2.new(screenPos.X, screenPos.Y)
                        drawing.Visible = true
                    else
                        drawing.Visible = false
                    end
                end
            end
        end
    end
end

local function cleanupNameTags()
    for _, drawing in pairs(NameTagDrawings) do
        if drawing then
            drawing:Remove()
        end
    end
    NameTagDrawings = {}
end

Visual:AddCheckbox("NameTagsToggle", {
    Text = "启用角色名称ESP",
    Default = false,
    Callback = function(enabled)
        if enabled then
            if not NameTagSettings.connection then
                NameTagSettings.connection = game:GetService("RunService").RenderStepped:Connect(updateNameTags)
            end
            
            if not NameTagSettings.removedConnection then
                NameTagSettings.removedConnection = game:GetService("Players").PlayerRemoving:Connect(function(player)
                    for model, drawing in pairs(NameTagDrawings) do
                        if model.Name == player.Name then
                            drawing:Remove()
                            NameTagDrawings[model] = nil
                        end
                    end
                end)
            end
        else
            if NameTagSettings.connection then
                NameTagSettings.connection:Disconnect()
                NameTagSettings.connection = nil
            end
            
            if NameTagSettings.removedConnection then
                NameTagSettings.removedConnection:Disconnect()
                NameTagSettings.removedConnection = nil
            end
            
            cleanupNameTags()
        end
    end
})

Visual:AddToggle("ShowSurvivorNames", {
    Text = "显示幸存者名称",
    Default = true,
    Callback = function(enabled)
        NameTagSettings.ShowSurvivorNames = enabled
    end
})

Visual:AddToggle("ShowKillerNames", {
    Text = "显示杀手名称",
    Default = true,
    Callback = function(enabled)
        NameTagSettings.ShowKillerNames = enabled
    end
})

Visual:AddCheckbox("ShowDistance", {
    Text = "显示距离",
    Default = true,
    Callback = function(enabled)
        NameTagSettings.ShowDistance = enabled
    end
})

local Visual = Tabs.Esp:AddLeftGroupbox("血量条ESP","heart-pulse")

-- 血量条设置
local HealthBarSettings = {
    ShowSurvivorBars = true,
    ShowKillerBars = true,
    BarWidth = 100,      -- 固定宽度
    BarHeight = 5,       -- 固定高度
    TextSize = 14,       -- 固定文字大小
    BarOffset = Vector2.new(0, -30), -- 基础偏移
    TextOffset = Vector2.new(0, -40)  -- 文字偏移
}

-- 预设颜色方案（修改后的幸存者颜色）
local ColorPresets = {
    Survivor = {
        FullHealth = Color3.fromRGB(0, 255, 255),    -- 青色(满血)
        HalfHealth = Color3.fromRGB(0, 255, 0),      -- 绿色(半血)
        LowHealth = Color3.fromRGB(255, 165, 0)      -- 橙色(低血)
    },
    Killer = {
        FullHealth = Color3.fromRGB(255, 0, 0),      -- 红色(满血)
        HalfHealth = Color3.fromRGB(255, 165, 0),    -- 橙色(半血)
        LowHealth = Color3.fromRGB(255, 255, 0)      -- 黄色(低血)
    },
    Common = {
        Background = Color3.fromRGB(50, 50, 50),
        Outline = Color3.fromRGB(0, 0, 0),
        Text = Color3.fromRGB(255, 255, 255)        -- 白色文字
    }
}

-- 存储所有ESP对象
local HealthBarDrawings = {}

-- 创建血量条ESP对象
local function createHealthBarDrawing()
    local drawing = {
        background = Drawing.new("Square"),
        bar = Drawing.new("Square"),
        outline = Drawing.new("Square"),
        text = Drawing.new("Text")
    }
    
    -- 背景设置
    drawing.background.Thickness = 1
    drawing.background.Filled = true
    drawing.background.Color = ColorPresets.Common.Background
    
    -- 血量条设置
    drawing.bar.Thickness = 1
    drawing.bar.Filled = true
    
    -- 边框设置
    drawing.outline.Thickness = 2
    drawing.outline.Filled = false
    drawing.outline.Color = ColorPresets.Common.Outline
    
    -- 文字设置
    drawing.text.Center = true
    drawing.text.Outline = true
    drawing.text.Font = 2
    drawing.text.Color = ColorPresets.Common.Text
    
    return drawing
end

-- 根据血量获取颜色（修改后的阈值）
local function getHealthColor(humanoid, isKiller)
    local healthPercent = (humanoid.Health / humanoid.MaxHealth) * 100
    
    if isKiller then
        if healthPercent > 50 then
            return ColorPresets.Killer.FullHealth
        elseif healthPercent > 25 then
            return ColorPresets.Killer.HalfHealth
        else
            return ColorPresets.Killer.LowHealth
        end
    else
        -- 幸存者新颜色阈值
        if healthPercent > 75 then
            return ColorPresets.Survivor.FullHealth    -- 满血(75%以上): 青色
        elseif healthPercent > 35 then
            return ColorPresets.Survivor.HalfHealth    -- 半血(35%-75%): 绿色
        else
            return ColorPresets.Survivor.LowHealth     -- 低血(35%以下): 橙色
        end
    end
end

-- 更新血量条（优化后不显示自身血条）
local function updateHealthBars()
    local camera = workspace.CurrentCamera
    local players = game:GetService("Players")
    local localPlayer = players.LocalPlayer
    
    -- 处理幸存者
    if HealthBarSettings.ShowSurvivorBars then
        local survivors = workspace.Players:FindFirstChild("Survivors")
        if survivors then
            for _, survivor in ipairs(survivors:GetChildren()) do
                if survivor:IsA("Model") and survivor ~= localPlayer.Character then  -- 不显示自身血条
                    local humanoid = survivor:FindFirstChildOfClass("Humanoid")
                    local head = survivor:FindFirstChild("Head")
                    
                    if humanoid and head then
                        -- 获取或创建ESP对象
                        if not HealthBarDrawings[survivor] then
                            HealthBarDrawings[survivor] = createHealthBarDrawing()
                        end
                        
                        local drawing = HealthBarDrawings[survivor]
                        local screenPos, onScreen = camera:WorldToViewportPoint(head.Position)
                        
                        if onScreen then
                            -- 计算血量百分比
                            local healthPercent = math.floor((humanoid.Health / humanoid.MaxHealth) * 100)
                            local healthBarWidth = HealthBarSettings.BarWidth * (healthPercent / 100)
                            
                            -- 设置位置
                            local barPos = Vector2.new(
                                screenPos.X + HealthBarSettings.BarOffset.X - (HealthBarSettings.BarWidth / 2),
                                screenPos.Y + HealthBarSettings.BarOffset.Y
                            )
                            
                            -- 背景和边框
                            drawing.background.Size = Vector2.new(HealthBarSettings.BarWidth, HealthBarSettings.BarHeight)
                            drawing.background.Position = barPos
                            drawing.background.Visible = true
                            
                            drawing.outline.Size = Vector2.new(HealthBarSettings.BarWidth, HealthBarSettings.BarHeight)
                            drawing.outline.Position = barPos
                            drawing.outline.Visible = true
                            
                            -- 血量条（使用新颜色方案）
                            drawing.bar.Color = getHealthColor(humanoid, false)
                            drawing.bar.Size = Vector2.new(healthBarWidth, HealthBarSettings.BarHeight)
                            drawing.bar.Position = barPos
                            drawing.bar.Visible = true
                            
                            -- 文字
                            drawing.text.Text = tostring(healthPercent) .. "%"
                            drawing.text.Size = HealthBarSettings.TextSize
                            drawing.text.Position = Vector2.new(
                                screenPos.X + HealthBarSettings.TextOffset.X,
                                screenPos.Y + HealthBarSettings.TextOffset.Y
                            )
                            drawing.text.Visible = true
                        else
                            -- 不在屏幕内则隐藏
                            for _, obj in pairs(drawing) do
                                obj.Visible = false
                            end
                        end
                    end
                end
            end
        end
    end
    
    -- 处理杀手
    if HealthBarSettings.ShowKillerBars then
        local killers = workspace.Players:FindFirstChild("Killers")
        if killers then
            for _, killer in ipairs(killers:GetChildren()) do
                if killer:IsA("Model") then
                    local humanoid = killer:FindFirstChildOfClass("Humanoid")
                    local head = killer:FindFirstChild("Head")
                    
                    if humanoid and head then
                        -- 获取或创建ESP对象
                        if not HealthBarDrawings[killer] then
                            HealthBarDrawings[killer] = createHealthBarDrawing()
                        end
                        
                        local drawing = HealthBarDrawings[killer]
                        local screenPos, onScreen = camera:WorldToViewportPoint(head.Position)
                        
                        if onScreen then
                            -- 计算血量百分比
                            local healthPercent = math.floor((humanoid.Health / humanoid.MaxHealth) * 100)
                            local healthBarWidth = HealthBarSettings.BarWidth * (healthPercent / 100)
                            
                            -- 设置位置
                            local barPos = Vector2.new(
                                screenPos.X + HealthBarSettings.BarOffset.X - (HealthBarSettings.BarWidth / 2),
                                screenPos.Y + HealthBarSettings.BarOffset.Y
                            )
                            
                            -- 背景和边框
                            drawing.background.Size = Vector2.new(HealthBarSettings.BarWidth, HealthBarSettings.BarHeight)
                            drawing.background.Position = barPos
                            drawing.background.Visible = true
                            
                            drawing.outline.Size = Vector2.new(HealthBarSettings.BarWidth, HealthBarSettings.BarHeight)
                            drawing.outline.Position = barPos
                            drawing.outline.Visible = true
                            
                            -- 血量条
                            drawing.bar.Color = getHealthColor(humanoid, true)
                            drawing.bar.Size = Vector2.new(healthBarWidth, HealthBarSettings.BarHeight)
                            drawing.bar.Position = barPos
                            drawing.bar.Visible = true
                            
                            -- 文字
                            drawing.text.Text = tostring(healthPercent) .. "%"
                            drawing.text.Size = HealthBarSettings.TextSize
                            drawing.text.Position = Vector2.new(
                                screenPos.X + HealthBarSettings.TextOffset.X,
                                screenPos.Y + HealthBarSettings.TextOffset.Y
                            )
                            drawing.text.Visible = true
                        else
                            -- 不在屏幕内则隐藏
                            for _, obj in pairs(drawing) do
                                obj.Visible = false
                            end
                        end
                    end
                end
            end
        end
    end
end

-- 清理血量条
local function cleanupHealthBars()
    for _, drawing in pairs(HealthBarDrawings) do
        for _, obj in pairs(drawing) do
            if obj then
                obj:Remove()
            end
        end
    end
    HealthBarDrawings = {}
end

-- 主开关
Visual:AddCheckbox("HealthBarsToggle", {
    Text = "启用血量条",
    Default = false,
    Callback = function(enabled)
        if enabled then
            -- 初始化连接
            if not HealthBarSettings.connection then
                HealthBarSettings.connection = game:GetService("RunService").RenderStepped:Connect(updateHealthBars)
            end
            
            -- 监听角色移除
            if not HealthBarSettings.removedConnection then
                HealthBarSettings.removedConnection = workspace.DescendantRemoving:Connect(function(descendant)
                    if HealthBarDrawings[descendant] then
                        for _, obj in pairs(HealthBarDrawings[descendant]) do
                            obj:Remove()
                        end
                        HealthBarDrawings[descendant] = nil
                    end
                end)
            end
        else
            -- 关闭连接
            if HealthBarSettings.connection then
                HealthBarSettings.connection:Disconnect()
                HealthBarSettings.connection = nil
            end
            
            if HealthBarSettings.removedConnection then
                HealthBarSettings.removedConnection:Disconnect()
                HealthBarSettings.removedConnection = nil
            end
            
            -- 清理ESP对象
            cleanupHealthBars()
        end
    end
})

-- 幸存者开关
Visual:AddToggle("ShowSurvivorBars", {
    Text = "显示幸存者血量条",
    Default = true,
    Callback = function(enabled)
        HealthBarSettings.ShowSurvivorBars = enabled
    end
})

-- 杀手开关
Visual:AddToggle("ShowKillerBars", {
    Text = "显示杀手血量条",
    Default = true,
    Callback = function(enabled)
        HealthBarSettings.ShowKillerBars = enabled
    end
})

-- 大小设置
Visual:AddSlider("BarWidth", {
    Text = "血量条宽度",
    Min = 50,
    Max = 200,
    Default = 100,
    Rounding = 0,
    Callback = function(value)
        HealthBarSettings.BarWidth = value
    end
})

Visual:AddSlider("BarHeight", {
    Text = "血量条高度",
    Min = 3,
    Max = 15,
    Default = 5,
    Rounding = 0,
    Callback = function(value)
        HealthBarSettings.BarHeight = value
    end
})

Visual:AddSlider("TextSize", {
    Text = "文字大小",
    Min = 10,
    Max = 20,
    Default = 14,
    Rounding = 0,
    Callback = function(value)
        HealthBarSettings.TextSize = value
    end
})

-- 位置调整
Visual:AddSlider("BarOffsetY", {
    Text = "垂直偏移",
    Min = -50,
    Max = 50,
    Default = -30,
    Rounding = 0,
    Callback = function(value)
        HealthBarSettings.BarOffset = Vector2.new(HealthBarSettings.BarOffset.X, value)
        HealthBarSettings.TextOffset = Vector2.new(HealthBarSettings.TextOffset.X, value - 10)
    end
})

Visual = Tabs.Esp:AddLeftGroupbox("血量ESP[备用]","heart-pulse")

local camera = workspace.CurrentCamera
local localPlayer = game:GetService("Players").LocalPlayer

Visual:AddCheckbox("SurvivorHealth", {
    Text = "ESP幸存者血量(文字)",
    Default = false,
    Callback = function(v)
        if v then
            local sur = workspace.Players.Survivors
            
            local function survivoresp(char)
                local billboard = Instance.new("BillboardGui")
                billboard.Size = UDim2.new(3, 0, 1, 0)
                billboard.StudsOffset = Vector3.new(0, 1.5, 0)
                billboard.Adornee = char.Head
                billboard.Parent = char.Head
                billboard.AlwaysOnTop = true
                
                local textLabel = Instance.new("TextLabel")
                textLabel.Size = UDim2.new(1, 0, 1, 0)
                textLabel.Position = UDim2.new(0, 0, 0, 0)
                textLabel.BackgroundTransparency = 1
                textLabel.TextScaled = false
                textLabel.Text = "血量: "..char.Humanoid.Health.."/"..char.Humanoid.MaxHealth
                textLabel.TextColor3 = Options.SurvivorHealthColor.Value
                textLabel.Font = Enum.Font.Arcade
                textLabel.Parent = billboard

              
                local distanceUpdate
                distanceUpdate = game:GetService("RunService").RenderStepped:Connect(function()
                    if char:FindFirstChild("Head") and localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        local distance = (char.Head.Position - localPlayer.Character.HumanoidRootPart.Position).Magnitude
                        
                        local textSize = math.clamp(30 - (distance / 2), 12, 20)
                        textLabel.TextSize = textSize
                    end
                end)

                local healthUpdate = char:FindFirstChild("Humanoid").HealthChanged:Connect(function()
                    textLabel.Text = "血量: "..char:FindFirstChild("Humanoid").Health.."/"..char:FindFirstChild("Humanoid").MaxHealth
                end)

                char:FindFirstChild("Humanoid").Died:Connect(function()
                    distanceUpdate:Disconnect()
                    healthUpdate:Disconnect()
                    textLabel.Text = ""
                end)

                return {billboard = billboard, connections = {distanceUpdate, healthUpdate}}
            end

            getgenv().SurvivorHealthConnections = {
                Added = sur.DescendantAdded:Connect(function(v)
                    if v:IsA("Model") and v:FindFirstChild("Humanoid") then
                        repeat wait() until v:FindFirstChild("Humanoid")
                        survivoresp(v)
                    end
                end)
            }

            for _,v in pairs(sur:GetDescendants()) do
                if v:IsA("Model") and v:FindFirstChild("Humanoid") then
                    repeat wait() until v:FindFirstChild("Humanoid")
                    survivoresp(v)
                end
            end
        else
            if getgenv().SurvivorHealthConnections then
                getgenv().SurvivorHealthConnections.Added:Disconnect()
            end
            
            for _,v in pairs(workspace.Players.Survivors:GetDescendants()) do
                if v:IsA("Model") and v:FindFirstChild("Head") then
                    for _,child in pairs(v.Head:GetChildren()) do
                        if child:IsA("BillboardGui") then
                            child:Destroy()
                        end
                    end
                end
            end
        end
    end
}):AddColorPicker("SurvivorHealthColor", {
    Default = Color3.fromRGB(0, 255, 0),
    Title = "幸存者血量(文字)颜色",
})

Visual:AddCheckbox("KillerHealth", {
    Text = "ESP杀手血量(文字)",
    Default = false,
    Callback = function(v)
        if v then
            local kil = workspace.Players.Killers
            
            local function killeresp(char)
                local billboard = Instance.new("BillboardGui")
                billboard.Size = UDim2.new(3, 0, 1, 0)
                billboard.StudsOffset = Vector3.new(0, 1.5, 0)
                billboard.Adornee = char.Head
                billboard.Parent = char.Head
                billboard.AlwaysOnTop = true
                
                local textLabel = Instance.new("TextLabel")
                textLabel.Size = UDim2.new(1, 0, 1, 0)
                textLabel.Position = UDim2.new(0, 0, 0, 0)
                textLabel.BackgroundTransparency = 1
                textLabel.TextScaled = false
                textLabel.Text = "血量: "..char.Humanoid.Health.."/"..char.Humanoid.MaxHealth
                textLabel.TextColor3 = Options.KillerHealthColor.Value
                textLabel.Font = Enum.Font.Arcade
                textLabel.Parent = billboard

                -- 添加距离检测更新
                local distanceUpdate
                distanceUpdate = game:GetService("RunService").RenderStepped:Connect(function()
                    if char:FindFirstChild("Head") and localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        local distance = (char.Head.Position - localPlayer.Character.HumanoidRootPart.Position).Magnitude
                        -- 根据距离动态调整文字大小 (10-30米范围内变化)
                        local textSize = math.clamp(30 - (distance / 2), 12, 20)
                        textLabel.TextSize = textSize
                    end
                end)

                local healthUpdate = char:FindFirstChild("Humanoid").HealthChanged:Connect(function()
                    textLabel.Text = "血量: "..char:FindFirstChild("Humanoid").Health.."/"..char:FindFirstChild("Humanoid").MaxHealth
                end)

                char:FindFirstChild("Humanoid").Died:Connect(function()
                    distanceUpdate:Disconnect()
                    healthUpdate:Disconnect()
                    textLabel.Text = ""
                end)

                return {billboard = billboard, connections = {distanceUpdate, healthUpdate}}
            end

            getgenv().KillerHealthConnections = {
                Added = kil.DescendantAdded:Connect(function(v)
                    if v:IsA("Model") and v:FindFirstChild("Humanoid") then
                        repeat wait() until v:FindFirstChild("Humanoid")
                        killeresp(v)
                    end
                end)
            }

            for _,v in pairs(kil:GetDescendants()) do
                if v:IsA("Model") and v:FindFirstChild("Humanoid") then
                    repeat wait() until v:FindFirstChild("Humanoid")
                    killeresp(v)
                end
            end
        else
            if getgenv().KillerHealthConnections then
                getgenv().KillerHealthConnections.Added:Disconnect()
            end
            
            for _,v in pairs(workspace.Players.Killers:GetDescendants()) do
                if v:IsA("Model") and v:FindFirstChild("Head") then
                    for _,child in pairs(v.Head:GetChildren()) do
                        if child:IsA("BillboardGui") then
                            child:Destroy()
                        end
                    end
                end
            end
        end
    end
}):AddColorPicker("KillerHealthColor", {
    Default = Color3.fromRGB(255, 255, 0),
    Title = "杀手血量(文字)颜色",
})

local Visual = Tabs.Esp:AddLeftGroupbox('发动机ESP[可能有卡顿]','printer')

-- 真发动机ESP
Visual:AddToggle("RealGeneratorESP", {
    Text = "ESP真发动机",
    Default = false,
    Callback = function(enabled)
        if not _G.RealGeneratorESP then
            _G.RealGeneratorESP = {
                Active = false,
                Data = {},
                Connections = {}
            }
        end
        
        if not enabled then
            if _G.RealGeneratorESP.Active then
                for _, connection in pairs(_G.RealGeneratorESP.Connections) do
                    if connection and connection.Connected then
                        connection:Disconnect()
                    end
                end
                
                for gen, data in pairs(_G.RealGeneratorESP.Data) do
                    if type(data) == "table" then
                        if data.Billboard and data.Billboard.Parent then
                            data.Billboard:Destroy()
                        end
                        if data.DistanceBillboard and data.DistanceBillboard.Parent then
                            data.DistanceBillboard:Destroy()
                        end
                        if data.Highlight and data.Highlight.Parent then
                            data.Highlight:Destroy()
                        end
                    end
                end
                
                _G.RealGeneratorESP.Data = {}
                _G.RealGeneratorESP.Connections = {}
                _G.RealGeneratorESP.Active = false
            end
            return
        end
        
        if _G.RealGeneratorESP.Active then
            return
        end
        
        _G.RealGeneratorESP.Active = true
        
        local scanInterval = 1.0
        local lastScanTime = 0
        local maxGenerators = 20
        
        local distanceSettings = {
            MinDistance = 5,
            MaxDistance = 500,
            MinScale = 0.8,
            MaxScale = 1.5,
            MinTextSize = 8,
            MaxTextSize = 10
        }
        
        local function updateGeneratorESP(gen, data)
            if not gen or not gen.Parent or not gen:FindFirstChild("Main") then
                return false
            end
            
            if table.getn(_G.RealGeneratorESP.Data) > maxGenerators then
                return false
            end
            
            if gen:FindFirstChild("Progress") then
                local progress = gen.Progress.Value
                if progress >= 99 then
                    return false
                end
                
                if data.TextLabel then
                    data.TextLabel.Text = string.format("真发动机: %d%%", progress)
                end
                
                local character = game:GetService("Players").LocalPlayer.Character
                local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
                
                if humanoidRootPart and data.DistanceLabel then
                    local distance = (gen.Main.Position - humanoidRootPart.Position).Magnitude
                    
                    data.DistanceLabel.Text = string.format("距离: %d米", math.floor(distance))
                    
                    local distanceRatio = math.clamp(
                        (distance - distanceSettings.MinDistance) / 
                        (distanceSettings.MaxDistance - distanceSettings.MinDistance),
                        0, 1
                    )
                    
                    local scale = distanceSettings.MinScale + 
                        distanceRatio * (distanceSettings.MaxScale - distanceSettings.MinScale)
                    
                    local textSize = distanceSettings.MinTextSize + 
                        distanceRatio * (distanceSettings.MaxTextSize - distanceSettings.MinTextSize)
                    
                    if data.Billboard then 
                        data.Billboard.Size = UDim2.new(4 * scale, 0, 1 * scale, 0)
                        data.Billboard.Enabled = true
                    end
                    
                    if data.DistanceBillboard then 
                        data.DistanceBillboard.Size = UDim2.new(4 * scale, 0, 1 * scale, 0)
                        data.DistanceBillboard.Enabled = true
                    end
                    
                    if data.TextLabel then 
                        data.TextLabel.TextSize = textSize
                        data.TextLabel.Visible = true
                    end
                    
                    if data.DistanceLabel then 
                        data.DistanceLabel.TextSize = textSize
                        data.DistanceLabel.Visible = true
                    end
                    
                    if data.Highlight then
                        data.Highlight.Enabled = true
                        local transparency = math.clamp((distance - 50) / 100, 0, 0.4)
                        data.Highlight.FillTransparency = 0.85 + (transparency * 0.5)
                        data.Highlight.OutlineColor = Options.RealGeneratorESPedgeColor.Value
                        data.Highlight.FillColor = Options.RealGeneratorESPColor.Value
                    end
                end
            end
            
            return true
        end
        
        local function createGeneratorESP(gen)
            if not gen or not gen:FindFirstChild("Main") or _G.RealGeneratorESP.Data[gen] then 
                return 
            end
            
            if table.getn(_G.RealGeneratorESP.Data) >= maxGenerators then
                return
            end
            
            local billboard = Instance.new("BillboardGui")
            billboard.Name = "RealGeneratorESP"
            billboard.Size = UDim2.new(4, 0, 1, 0)
            billboard.StudsOffset = Vector3.new(0, 2.5, 0)
            billboard.Adornee = gen.Main
            billboard.Parent = gen.Main
            billboard.AlwaysOnTop = true
            billboard.Enabled = true
            
            local textLabel = Instance.new("TextLabel")
            textLabel.Size = UDim2.new(1, 0, 0.5, 0)
            textLabel.BackgroundTransparency = 1
            textLabel.TextScaled = false
            textLabel.Text = "真发动机加载中..."
            textLabel.TextColor3 = Color3.fromRGB(0, 255, 0) -- 绿色
            textLabel.Font = Enum.Font.Arcade
            textLabel.TextStrokeTransparency = 0
            textLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
            textLabel.TextSize = 8
            textLabel.Parent = billboard
            
            local distanceBillboard = Instance.new("BillboardGui")
            distanceBillboard.Name = "RealGeneratorDistanceESP"
            distanceBillboard.Size = UDim2.new(4, 0, 1, 0)
            distanceBillboard.StudsOffset = Vector3.new(0, 3.5, 0)
            distanceBillboard.Adornee = gen.Main
            distanceBillboard.Parent = gen.Main
            distanceBillboard.AlwaysOnTop = true
            distanceBillboard.Enabled = true
            
            local distanceLabel = Instance.new("TextLabel")
            distanceLabel.Size = UDim2.new(1, 0, 0.5, 0)
            distanceLabel.BackgroundTransparency = 1
            distanceLabel.TextScaled = false
            distanceLabel.Text = "计算距离中..."
            distanceLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
            distanceLabel.Font = Enum.Font.Arcade
            distanceLabel.TextStrokeTransparency = 0
            distanceLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
            distanceLabel.TextSize = 8
            distanceLabel.Parent = distanceBillboard
            
            local highlight = Instance.new("Highlight")
            highlight.Name = "RealGeneratorHighlight"
            highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            highlight.Enabled = true
            highlight.OutlineColor = Color3.fromRGB(0, 255, 0)
            highlight.FillColor = Color3.fromRGB(0, 255, 0)
            highlight.FillTransparency = 0.9
            highlight.OutlineTransparency = 0
            highlight.Parent = gen
            
            _G.RealGeneratorESP.Data[gen] = {
                Billboard = billboard,
                DistanceBillboard = distanceBillboard,
                TextLabel = textLabel,
                DistanceLabel = distanceLabel,
                Highlight = highlight
            }
            
            local destroyConnection
            destroyConnection = gen.Destroying:Connect(function()
                if _G.RealGeneratorESP.Data[gen] then
                    if _G.RealGeneratorESP.Data[gen].Billboard then 
                        _G.RealGeneratorESP.Data[gen].Billboard:Destroy() 
                    end
                    if _G.RealGeneratorESP.Data[gen].DistanceBillboard then 
                        _G.RealGeneratorESP.Data[gen].DistanceBillboard:Destroy() 
                    end
                    if _G.RealGeneratorESP.Data[gen].Highlight then 
                        _G.RealGeneratorESP.Data[gen].Highlight:Destroy() 
                    end
                    _G.RealGeneratorESP.Data[gen] = nil
                end
                if destroyConnection then
                    destroyConnection:Disconnect()
                end
            end)
            
            table.insert(_G.RealGeneratorESP.Connections, destroyConnection)
        end
        
        local function scanGenerators()
            local mapFolder = workspace:FindFirstChild("Map")
            if mapFolder then
                local ingameFolder = mapFolder:FindFirstChild("Ingame")
                if ingameFolder then
                    local mapSubFolder = ingameFolder:FindFirstChild("Map")
                    if mapSubFolder then
                        local generators = mapSubFolder:GetDescendants()
                        for _, gen in pairs(generators) do
                            if gen:IsA("Model") and gen:FindFirstChild("Main") and gen.Name == "Generator" then
                                createGeneratorESP(gen)
                            end
                        end
                    end
                end
            end
        end
        
        local mainConnection
        local mapFolder = workspace:FindFirstChild("Map")
        if mapFolder then
            local ingameFolder = mapFolder:FindFirstChild("Ingame")
            if ingameFolder then
                local mapSubFolder = ingameFolder:FindFirstChild("Map")
                if mapSubFolder then
                    mainConnection = mapSubFolder.DescendantAdded:Connect(function(v)
                        if v:IsA("Model") and v:FindFirstChild("Main") and v.Name == "Generator" then
                            createGeneratorESP(v)
                        end
                    end)
                end
            end
        end
        
        if mainConnection then
            table.insert(_G.RealGeneratorESP.Connections, mainConnection)
        end
        
        local heartbeatConnection = game:GetService("RunService").Heartbeat:Connect(function(deltaTime)
            lastScanTime = lastScanTime + deltaTime
            if lastScanTime >= scanInterval then
                lastScanTime = 0
                scanGenerators()
            end
            
            local gensToRemove = {}
            for gen, data in pairs(_G.RealGeneratorESP.Data) do
                if not gen or not gen.Parent then
                    table.insert(gensToRemove, gen)
                else
                    if not updateGeneratorESP(gen, data) then
                        table.insert(gensToRemove, gen)
                    end
                end
            end
            
            for _, gen in ipairs(gensToRemove) do
                if _G.RealGeneratorESP.Data[gen] then
                    if _G.RealGeneratorESP.Data[gen].Billboard then 
                        _G.RealGeneratorESP.Data[gen].Billboard:Destroy() 
                    end
                    if _G.RealGeneratorESP.Data[gen].DistanceBillboard then 
                        _G.RealGeneratorESP.Data[gen].DistanceBillboard:Destroy() 
                    end
                    if _G.RealGeneratorESP.Data[gen].Highlight then 
                        _G.RealGeneratorESP.Data[gen].Highlight:Destroy() 
                    end
                    _G.RealGeneratorESP.Data[gen] = nil
                end
            end
        end)
        
        table.insert(_G.RealGeneratorESP.Connections, heartbeatConnection)
        
        scanGenerators()
    end
}):AddColorPicker("RealGeneratorESPColor", {
    Default = Color3.fromRGB(0, 255, 0),
    Title = "真发动机高亮颜色",
}):AddColorPicker("RealGeneratorESPedgeColor", {
    Default = Color3.fromRGB(0, 255, 0),
    Title = "真发动机边缘颜色",
})

-- 假发动机ESP
Visual:AddToggle("FakeGeneratorESP", {
    Text = "ESP假发动机",
    Default = false,
    Callback = function(enabled)
        if not _G.FakeGeneratorESP then
            _G.FakeGeneratorESP = {
                Active = false,
                Data = {},
                Connections = {}
            }
        end
        
        if not enabled then
            if _G.FakeGeneratorESP.Active then
                for _, connection in pairs(_G.FakeGeneratorESP.Connections) do
                    if connection and connection.Connected then
                        connection:Disconnect()
                    end
                end
                
                for gen, data in pairs(_G.FakeGeneratorESP.Data) do
                    if type(data) == "table" then
                        if data.Highlight and data.Highlight.Parent then
                            data.Highlight:Destroy()
                        end
                        if data.NameLabel and data.NameLabel.Parent then
                            data.NameLabel:Destroy()
                        end
                    end
                end
                
                _G.FakeGeneratorESP.Data = {}
                _G.FakeGeneratorESP.Connections = {}
                _G.FakeGeneratorESP.Active = false
            end
            return
        end
        
        if _G.FakeGeneratorESP.Active then
            _G.FakeGeneratorESP.Callback(false)
        end
        
        _G.FakeGeneratorESP.Active = true
        
        local scanInterval = 1.0
        local lastScanTime = 0
        
        local function createFakeGeneratorESP(gen)
            if not gen or not gen:FindFirstChild("Main") or _G.FakeGeneratorESP.Data[gen] then 
                return 
            end
            
            local highlight = Instance.new("Highlight")
            highlight.Name = "FakeGeneratorHighlight"
            highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            highlight.Enabled = true
            highlight.OutlineColor = Options.FakeGeneratorESPedgeColor.Value
            highlight.FillColor = Options.FakeGeneratorESPColor.Value
            highlight.FillTransparency = 0.9
            highlight.OutlineTransparency = 0
            highlight.Parent = gen
            
            local nameBillboard = Instance.new("BillboardGui")
            nameBillboard.Name = "FakeGeneratorNameESP"
            nameBillboard.Size = UDim2.new(4, 0, 1, 0)
            nameBillboard.StudsOffset = Vector3.new(0, 2.5, 0)
            nameBillboard.Adornee = gen.Main
            nameBillboard.Parent = gen.Main
            nameBillboard.AlwaysOnTop = true
            nameBillboard.Enabled = true
            
            local nameLabel = Instance.new("TextLabel")
            nameLabel.Size = UDim2.new(1, 0, 1, 0)
            nameLabel.BackgroundTransparency = 1
            nameLabel.TextScaled = false
            nameLabel.Text = "假发动机"
            nameLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
            nameLabel.Font = Enum.Font.Arcade
            nameLabel.TextStrokeTransparency = 0
            nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
            nameLabel.TextSize = 12
            nameLabel.Parent = nameBillboard
            
            _G.FakeGeneratorESP.Data[gen] = {
                Highlight = highlight,
                NameLabel = nameLabel,
                NameBillboard = nameBillboard
            }
            
            local destroyConnection
            destroyConnection = gen.Destroying:Connect(function()
                if _G.FakeGeneratorESP.Data[gen] then
                    if _G.FakeGeneratorESP.Data[gen].Highlight then 
                        _G.FakeGeneratorESP.Data[gen].Highlight:Destroy() 
                    end
                    if _G.FakeGeneratorESP.Data[gen].NameLabel then 
                        _G.FakeGeneratorESP.Data[gen].NameLabel:Destroy() 
                    end
                    if _G.FakeGeneratorESP.Data[gen].NameBillboard then 
                        _G.FakeGeneratorESP.Data[gen].NameBillboard:Destroy() 
                    end
                    _G.FakeGeneratorESP.Data[gen] = nil
                end
                if destroyConnection then
                    destroyConnection:Disconnect()
                end
            end)
            
            table.insert(_G.FakeGeneratorESP.Connections, destroyConnection)
        end
        
        local function scanGenerators()
            local mapFolder = workspace:FindFirstChild("Map")
            if mapFolder then
                local ingameFolder = mapFolder:FindFirstChild("Ingame")
                if ingameFolder then
                    local mapSubFolder = ingameFolder:FindFirstChild("Map")
                    if mapSubFolder then
                        local generators = mapSubFolder:GetDescendants()
                        for _, gen in pairs(generators) do
                            if gen:IsA("Model") and gen:FindFirstChild("Main") and gen.Name == "FakeGenerator" then
                                createFakeGeneratorESP(gen)
                            end
                        end
                    end
                end
            end
        end
        
        local mainConnection
        local mapFolder = workspace:FindFirstChild("Map")
        if mapFolder then
            local ingameFolder = mapFolder:FindFirstChild("Ingame")
            if ingameFolder then
                local mapSubFolder = ingameFolder:FindFirstChild("Map")
                if mapSubFolder then
                    mainConnection = mapSubFolder.DescendantAdded:Connect(function(v)
                        if v:IsA("Model") and v:FindFirstChild("Main") and v.Name == "FakeGenerator" then
                            createFakeGeneratorESP(v)
                        end
                    end)
                end
            end
        end
        
        if mainConnection then
            table.insert(_G.FakeGeneratorESP.Connections, mainConnection)
        end
        
        local heartbeatConnection = game:GetService("RunService").Heartbeat:Connect(function(deltaTime)
            lastScanTime = lastScanTime + deltaTime
            if lastScanTime >= scanInterval then
                lastScanTime = 0
                scanGenerators()
            end
            
            local gensToRemove = {}
            for gen, data in pairs(_G.FakeGeneratorESP.Data) do
                if not gen or not gen.Parent then
                    table.insert(gensToRemove, gen)
                end
            end
            
            for _, gen in ipairs(gensToRemove) do
                if _G.FakeGeneratorESP.Data[gen] then
                    if _G.FakeGeneratorESP.Data[gen].Highlight then 
                        _G.FakeGeneratorESP.Data[gen].Highlight:Destroy() 
                    end
                    if _G.FakeGeneratorESP.Data[gen].NameLabel then 
                        _G.FakeGeneratorESP.Data[gen].NameLabel:Destroy() 
                    end
                    if _G.FakeGeneratorESP.Data[gen].NameBillboard then 
                        _G.FakeGeneratorESP.Data[gen].NameBillboard:Destroy() 
                    end
                    _G.FakeGeneratorESP.Data[gen] = nil
                end
            end
        end)
        
        table.insert(_G.FakeGeneratorESP.Connections, heartbeatConnection)
        
        scanGenerators()
    end
}):AddColorPicker("FakeGeneratorESPColor", {
    Default = Color3.fromRGB(255, 0, 0),
    Title = "假发动机高亮颜色",
}):AddColorPicker("FakeGeneratorESPedgeColor", {
    Default = Color3.fromRGB(255, 0, 0),
    Title = "假动机边缘颜色",
})

-- 特殊发动机ESP
Visual:AddToggle("NoliWarningESP", {
    Text = "ESPNoli传送发动机",
    Default = false,
    Callback = function(enabled)
        if not _G.NoliWarningESP then
            _G.NoliWarningESP = {
                Active = false,
                Data = {},
                Connections = {}
            }
        end
        
        if not enabled then
            if _G.NoliWarningESP.Active then
                for _, connection in pairs(_G.NoliWarningESP.Connections) do
                    if connection and connection.Connected then
                        connection:Disconnect()
                    end
                end
                
                for gen, data in pairs(_G.NoliWarningESP.Data) do
                    if type(data) == "table" then
                        if data.Highlight and data.Highlight.Parent then
                            data.Highlight:Destroy()
                        end
                        if data.Label and data.Label.Parent then
                            data.Label:Destroy()
                        end
                    end
                end
                
                _G.NoliWarningESP.Data = {}
                _G.NoliWarningESP.Connections = {}
                _G.NoliWarningESP.Active = false
            end
            return
        end
        
        if _G.NoliWarningESP.Active then
            return
        end
        
        _G.NoliWarningESP.Active = true
        
        local scanInterval = 1.0
        local lastScanTime = 0
        
        local function hasNoliWarning(gen)
            if string.find(gen.Name, "NoliWarningIncoming") then
                return true
            end
            
            for _, child in pairs(gen:GetDescendants()) do
                if (child:IsA("StringValue") or child:IsA("ObjectValue")) and 
                   string.find(tostring(child.Value), "NoliWarningIncoming") then
                    return true
                elseif child:IsA("BasePart") and string.find(child.Name, "NoliWarningIncoming") then
                    return true
                end
            end
            
            return false
        end
        
        local function createNoliWarningESP(gen)
            if not gen or not gen:FindFirstChild("Main") or _G.NoliWarningESP.Data[gen] then 
                return 
            end
            
            if not hasNoliWarning(gen) then
                return
            end
            
            local highlight = Instance.new("Highlight")
            highlight.Name = "NoliWarningHighlight"
            highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            highlight.Enabled = true
            highlight.OutlineColor = Options.NoliWarningGeneratorESPedgeColor.Value
            highlight.FillColor = Options.NoliWarningGeneratorESPColor.Value
            highlight.FillTransparency = 0.7
            highlight.OutlineTransparency = 0
            highlight.Parent = gen
            
            local billboard = Instance.new("BillboardGui")
            billboard.Name = "NoliWarningBillboard"
            billboard.Size = UDim2.new(6, 0, 2, 0)
            billboard.StudsOffset = Vector3.new(0, 3, 0)
            billboard.Adornee = gen.Main
            billboard.Parent = gen.Main
            billboard.AlwaysOnTop = true
            
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, 0, 1, 0)
            label.BackgroundTransparency = 1
            label.Text = "[Noli即将传送]"
            label.TextColor3 = Color3.fromRGB(255, 0, 255)
            label.Font = Enum.Font.Arcade
            label.TextSize = 14
            label.TextStrokeTransparency = 0
            label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
            label.Parent = billboard
            
            _G.NoliWarningESP.Data[gen] = {
                Highlight = highlight,
                Label = label,
                Billboard = billboard,
                LastCheck = os.time()
            }
            
            local destroyConnection
            destroyConnection = gen.Destroying:Connect(function()
                if _G.NoliWarningESP.Data[gen] then
                    if _G.NoliWarningESP.Data[gen].Highlight then 
                        _G.NoliWarningESP.Data[gen].Highlight:Destroy() 
                    end
                    if _G.NoliWarningESP.Data[gen].Label then 
                        _G.NoliWarningESP.Data[gen].Label:Destroy() 
                    end
                    if _G.NoliWarningESP.Data[gen].Billboard then 
                        _G.NoliWarningESP.Data[gen].Billboard:Destroy() 
                    end
                    _G.NoliWarningESP.Data[gen] = nil
                end
                if destroyConnection then
                    destroyConnection:Disconnect()
                end
            end)
            
            table.insert(_G.NoliWarningESP.Connections, destroyConnection)
        end
        
        local function scanGenerators()
            local generators = workspace:GetDescendants()
            for _, gen in pairs(generators) do
                if gen:IsA("Model") and gen:FindFirstChild("Main") and 
                   (gen.Name == "Generator" or gen.Name == "FakeGenerator") then
                    createNoliWarningESP(gen)
                end
            end
        end
        
        local function updateExistingGenerators()
            local gensToRemove = {}
            for gen, data in pairs(_G.NoliWarningESP.Data) do
                if not gen or not gen.Parent then
                    table.insert(gensToRemove, gen)
                else
                    if os.time() - data.LastCheck > 5 then
                        if not hasNoliWarning(gen) then
                            table.insert(gensToRemove, gen)
                        else
                            data.LastCheck = os.time()
                        end
                    end
                end
            end
            
            for _, gen in ipairs(gensToRemove) do
                if _G.NoliWarningESP.Data[gen] then
                    if _G.NoliWarningESP.Data[gen].Highlight then 
                        _G.NoliWarningESP.Data[gen].Highlight:Destroy() 
                    end
                    if _G.NoliWarningESP.Data[gen].Label then 
                        _G.NoliWarningESP.Data[gen].Label:Destroy() 
                    end
                    if _G.NoliWarningESP.Data[gen].Billboard then 
                        _G.NoliWarningESP.Data[gen].Billboard:Destroy() 
                    end
                    _G.NoliWarningESP.Data[gen] = nil
                end
            end
        end
        
        local mainConnection = workspace.DescendantAdded:Connect(function(v)
            if v:IsA("Model") and v:FindFirstChild("Main") and 
               (v.Name == "Generator" or v.Name == "FakeGenerator") then
                createNoliWarningESP(v)
            end
        end)
        
        table.insert(_G.NoliWarningESP.Connections, mainConnection)
        
        local heartbeatConnection = game:GetService("RunService").Heartbeat:Connect(function(deltaTime)
            lastScanTime = lastScanTime + deltaTime
            if lastScanTime >= scanInterval then
                lastScanTime = 0
                scanGenerators()
                updateExistingGenerators()
            end
        end)
        
        table.insert(_G.NoliWarningESP.Connections, heartbeatConnection)
        
        scanGenerators()
    end
}):AddColorPicker("NoliWarningGeneratorESPColor", {
    Default = Color3.fromRGB(255, 0, 255),
    Title = "Noli传送发动机高亮颜色",
}):AddColorPicker("NoliWarningGeneratorESPedgeColor", {
    Default = Color3.fromRGB(255, 0, 255),
    Title = "Noli传送发动机边缘颜色",
})

local Visual = Tabs.Esp:AddRightGroupbox("2D方框","vector-square")

Visual:AddCheckbox("2dEspSurvivorbox", {
    Text = "ESP幸存者方框",
    Default = false,
    Callback = function(v)
        if v then
            local a = workspace:WaitForChild("Players")
            local c = a:WaitForChild("Survivors")
            local d = game:GetService("RunService")
            local e = game:GetService("Players").LocalPlayer
            
            local function f(g, h)
                if not g:IsA("Model") then return end
                if g == e.Character then return end
                local i = g:FindFirstChild("HumanoidRootPart")
                if not i then return end
                if i:FindFirstChild("playeresp") then return end
                
                local j = Instance.new("BillboardGui")
                j.Name = "playeresp"
                j.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
                j.Active = true
                j.AlwaysOnTop = true
                j.LightInfluence = 1.000
                j.Size = UDim2.new(3, 0, 5, 0)
                j.Adornee = i
                j.Parent = i
                
                local k = Instance.new("Frame")
                k.Name = "playershow"
                k.BackgroundColor3 = Color3.fromRGB(255, 25, 25)
                k.BackgroundTransparency = 1
                k.Size = UDim2.new(1, 0, 1, 0)
                k.Parent = j
                
                local l = Instance.new("UIStroke")
                l.Color = h
                l.Thickness = 2
                l.Transparency = 0.2
                l.Parent = k
            end
            
            SurvivorESPConnection = d.RenderStepped:Connect(function()
                for m, o in ipairs(c:GetChildren()) do
                    f(o, Color3.fromRGB(0, 255, 255))
                end
            end)
            
            -- 添加新加入的幸存者
            SurvivorAddedConnection = c.ChildAdded:Connect(function(o)
                f(o, Color3.fromRGB(0, 255, 255))
            end)
        else
            if SurvivorESPConnection then
                SurvivorESPConnection:Disconnect()
            end
            if SurvivorAddedConnection then
                SurvivorAddedConnection:Disconnect()
            end
            
            -- 清除所有幸存者ESP
            local a = workspace:WaitForChild("Players")
            local c = a:WaitForChild("Survivors")
            for _, o in ipairs(c:GetChildren()) do
                if o:IsA("Model") then
                    local i = o:FindFirstChild("HumanoidRootPart")
                    if i and i:FindFirstChild("playeresp") then
                        i.playeresp:Destroy()
                    end
                end
            end
        end
    end
})

Visual:AddCheckbox("2dEspKillerbox", {
    Text = "ESP杀手方框",
    Default = false,
    Callback = function(v)
        if v then
            local a = workspace:WaitForChild("Players")
            local b = a:WaitForChild("Killers")
            local d = game:GetService("RunService")
            local e = game:GetService("Players").LocalPlayer
            
            local function f(g, h)
                if not g:IsA("Model") then return end
                if g == e.Character then return end
                local i = g:FindFirstChild("HumanoidRootPart")
                if not i then return end
                if i:FindFirstChild("playeresp") then return end
                
                local j = Instance.new("BillboardGui")
                j.Name = "playeresp"
                j.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
                j.Active = true
                j.AlwaysOnTop = true
                j.LightInfluence = 1.000
                j.Size = UDim2.new(3, 0, 5, 0)
                j.Adornee = i
                j.Parent = i
                
                local k = Instance.new("Frame")
                k.Name = "playershow"
                k.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                k.BackgroundTransparency = 1
                k.Size = UDim2.new(1, 0, 1, 0)
                k.Parent = j
                
                local l = Instance.new("UIStroke")
                l.Color = h
                l.Thickness = 2
                l.Transparency = 0.2
                l.Parent = k
            end
            
            KillerESPConnection = d.RenderStepped:Connect(function()
                for m, o in ipairs(b:GetChildren()) do
                    f(o, Color3.fromRGB(255, 0, 0))
                end
            end)
            
            -- 添加新加入的杀手
            KillerAddedConnection = b.ChildAdded:Connect(function(o)
                f(o, Color3.fromRGB(255, 0, 0))
            end)
        else
            if KillerESPConnection then
                KillerESPConnection:Disconnect()
            end
            if KillerAddedConnection then
                KillerAddedConnection:Disconnect()
            end
            
            -- 清除所有杀手ESP
            local a = workspace:WaitForChild("Players")
            local b = a:WaitForChild("Killers")
            for _, o in ipairs(b:GetChildren()) do
                if o:IsA("Model") then
                    local i = o:FindFirstChild("HumanoidRootPart")
                    if i and i:FindFirstChild("playeresp") then
                        i.playeresp:Destroy()
                    end
                end
            end
        end
    end
})

local Visual = Tabs.Esp:AddLeftGroupbox("特殊ESP","shopping-basket")

local LibESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/ImamGV/Script/main/ESP"))()

Visual:AddCheckbox("KillerRobotsESP",{
    Text = "杀手机器人ESP",
    Callback = function(v)
        if v then
            for _, v in ipairs(workspace:GetDescendants()) do
                      if v:IsA("Model") and 
                      v.Name == "PizzaDeliveryRig" or 
                      v.Name == "Bunny" or 
                      v.Name == "Mafiaso1" or 
                      v.Name == "Mafiaso2" or 
                      v.Name == "Mafiaso3" then
                    LibESP:AddESP(v, "c00lkidd小弟", Color3.fromRGB(255, 52, 179), 14, "Other_ESP")
                elseif v:IsA("Model") and v.Name == "1x1x1x1Zombie" then
                    LibESP:AddESP(v, "1x1x1x1 (僵尸)", Color3.fromRGB(224, 102, 255), 14, "Other_ESP")
                end
            end
            OtherESP = workspace.DescendantAdded:Connect(function(v)
                     if v:IsA("Model") and 
                     v.Name == "PizzaDeliveryRig" or
                     v.Name == "Bunny" or 
                     v.Name == "Mafia1" or 
                     v.Name == "Mafia2" or
                     v.Name == "Mafia3" or
                     v.Name == "Mafia4" then
                    LibESP:AddESP(v, "c00lkidd小弟", Color3.fromRGB(255, 52, 179), 14, "Other_ESP")
                elseif v:IsA("Model") and v.Name == "1x1x1x1Zombie" then
                    LibESP:AddESP(v, "1x1x1x1 (僵尸)", Color3.fromRGB(224, 102, 255), 14, "Other_ESP")
                end
            end)
        else
            OtherESP:Disconnect()
            LibESP:Delete("Other_ESP")
        end
    end
})

Visual:AddCheckbox("ShadowESP", {
    Text = "数码足迹ESP",
    Default = false,
    Callback = function(Value)
        local currentShadows = {}
        local checkingConnection = nil
        local isRunning = false
        local scriptConnection = nil

        local function findAllShadowsInFolder(folder)
            local shadows = {}
            for _, child in ipairs(folder:GetChildren()) do
                if child.Name == "Shadow" then
                    table.insert(shadows, child)
                elseif child:IsA("Folder") or child:IsA("Model") then
                    local foundShadows = findAllShadowsInFolder(child)
                    for _, foundShadow in ipairs(foundShadows) do
                        table.insert(shadows, foundShadow)
                    end
                end
            end
            return shadows
        end

        local function createShadowMarker(shadow)
            local player = game.Players.LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()
            local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
            
            local function getObjectSize(obj)
                if obj:IsA("BasePart") then
                    return obj.Size
                elseif obj:IsA("Model") and obj.PrimaryPart then
                    local cf = obj:GetBoundingBox()
                    return (cf[2] - cf[1]).Magnitude
                else
                    return Vector3.new(5, 5, 5)
                end
            end
            
            local objectSize = getObjectSize(shadow)
            
            local highlight = Instance.new("Highlight")
            highlight.Name = "ShadowRangeIndicator"
            highlight.FillColor = Color3.fromRGB(255, 0, 0)
            highlight.FillTransparency = 0.8
            highlight.OutlineColor = Color3.fromRGB(255, 100, 100)
            highlight.OutlineTransparency = 0.5
            highlight.Parent = shadow
            
            local billboard = Instance.new("BillboardGui")
            billboard.Name = "ShadowNameDisplay"
            billboard.AlwaysOnTop = true
            billboard.Size = UDim2.new(0, 180, 0, 60)
            billboard.StudsOffset = Vector3.new(0, objectSize.Y/2 + 2, 0)
            billboard.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
            
            local textLabel = Instance.new("TextLabel")
            textLabel.Name = "TrapLabel"
            textLabel.Text = "数码足迹"
            textLabel.Size = UDim2.new(1, 0, 0.5, 0)
            textLabel.Position = UDim2.new(0, 0, 0, 0)
            textLabel.Font = Enum.Font.Arcade
            textLabel.TextSize = 18
            textLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
            textLabel.BackgroundTransparency = 1
            textLabel.TextStrokeTransparency = 0
            textLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
            textLabel.TextXAlignment = Enum.TextXAlignment.Center
            textLabel.TextYAlignment = Enum.TextYAlignment.Center
            
            local distanceLabel = Instance.new("TextLabel")
            distanceLabel.Name = "DistanceLabel"
            distanceLabel.Text = "距离: 计算中..."
            distanceLabel.Size = UDim2.new(1, 0, 0.5, 0)
            distanceLabel.Position = UDim2.new(0, 0, 0.5, 0)
            distanceLabel.Font = Enum.Font.Arcade
            distanceLabel.TextSize = 14
            distanceLabel.TextColor3 = Color3.fromRGB(0, 255, 255)
            distanceLabel.BackgroundTransparency = 1
            distanceLabel.TextStrokeTransparency = 0
            distanceLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
            distanceLabel.TextXAlignment = Enum.TextXAlignment.Center
            distanceLabel.TextYAlignment = Enum.TextYAlignment.Center
            
            textLabel.Parent = billboard
            distanceLabel.Parent = billboard
            billboard.Parent = shadow
            
            if shadow:IsA("BasePart") then
                local boxHandleAdornment = Instance.new("BoxHandleAdornment")
                boxHandleAdornment.Name = "SizeIndicator"
                boxHandleAdornment.Adornee = shadow
                boxHandleAdornment.AlwaysOnTop = true
                boxHandleAdornment.Size = shadow.Size
                boxHandleAdornment.Transparency = 0.7
                boxHandleAdornment.Color3 = Color3.fromRGB(255, 50, 50)
                boxHandleAdornment.ZIndex = 10
                boxHandleAdornment.Parent = shadow
            end
            
            local heartbeatConnection
            heartbeatConnection = game:GetService("RunService").Heartbeat:Connect(function()
                if not shadow or not shadow.Parent then 
                    if heartbeatConnection then
                        heartbeatConnection:Disconnect()
                        heartbeatConnection = nil
                    end
                    return 
                end
                if not humanoidRootPart or not humanoidRootPart.Parent then return end
                
                local distance = (humanoidRootPart.Position - shadow.Position).Magnitude
                distanceLabel.Text = string.format("距离: %.1f m", distance)
                
                local baseScale = math.clamp(40 / math.max(1, distance), 0.4, 1.8)
                textLabel.TextSize = 18 * baseScale
                distanceLabel.TextSize = 14 * baseScale
                
                local overallTransparency = math.clamp(distance / 80, 0.1, 0.4)
                local strokeTransparency = overallTransparency * 0.1
                textLabel.TextStrokeTransparency = strokeTransparency
                distanceLabel.TextStrokeTransparency = strokeTransparency
                highlight.FillTransparency = math.clamp(distance/70, 0.3, 0.8)
            end)
            
            currentShadows[shadow] = {
                heartbeat = heartbeatConnection,
                marker = {
                    highlight = highlight,
                    billboard = billboard,
                    textLabel = textLabel,
                    distanceLabel = distanceLabel,
                    boxHandle = shadow:IsA("BasePart") and shadow:FindFirstChild("SizeIndicator")
                }
            }
        end

        local function removeShadowMarker(shadow)
            local markerData = currentShadows[shadow]
            if markerData then
                if markerData.heartbeat then
                    markerData.heartbeat:Disconnect()
                end
                
                if markerData.marker then
                    if markerData.marker.highlight and markerData.marker.highlight.Parent then
                        markerData.marker.highlight:Destroy()
                    end
                    if markerData.marker.billboard and markerData.marker.billboard.Parent then
                        markerData.marker.billboard:Destroy()
                    end
                    if markerData.marker.boxHandle and markerData.marker.boxHandle.Parent then
                        markerData.marker.boxHandle:Destroy()
                    end
                end
                
                currentShadows[shadow] = nil
            end
        end

        local function checkAndUpdateShadows()
            local allFolders = {workspace.Map.Ingame}
            local foundShadows = {}
            
            for _, folder in ipairs(allFolders) do
                if folder and (folder:IsA("Folder") or folder:IsA("Model")) then
                    local shadowsInFolder = findAllShadowsInFolder(folder)
                    for _, shadow in ipairs(shadowsInFolder) do
                        table.insert(foundShadows, shadow)
                    end
                end
            end
            
            for _, shadow in ipairs(foundShadows) do
                if not currentShadows[shadow] then
                    createShadowMarker(shadow)
                end
            end
            
            local shadowsToRemove = {}
            for shadow, _ in pairs(currentShadows) do
                local stillExists = false
                for _, foundShadow in ipairs(foundShadows) do
                    if shadow == foundShadow then
                        stillExists = true
                        break
                    end
                end
                
                if not stillExists then
                    table.insert(shadowsToRemove, shadow)
                end
            end
            
            for _, shadow in ipairs(shadowsToRemove) do
                removeShadowMarker(shadow)
            end
        end

        local function startShadowChecking()
            if isRunning then return end
            isRunning = true
            
            checkAndUpdateShadows()
            
            checkingConnection = game:GetService("RunService").Heartbeat:Connect(function()
            end)
            
            scriptConnection = game:GetService("RunService").Stepped:Connect(function()
                local success, _ = pcall(function()
                    local test = script.Name
                end)
                
                if not success then
                    stopShadowChecking()
                    if scriptConnection then
                        scriptConnection:Disconnect()
                        scriptConnection = nil
                    end
                end
            end)
            
            task.spawn(function()
                while isRunning do
                    checkAndUpdateShadows()
                    task.wait(2)
                end
            end)
        end

        -- Stop the detection system
        local function stopShadowChecking()
            if not isRunning then return end
            isRunning = false
            
            if checkingConnection then
                checkingConnection:Disconnect()
                checkingConnection = nil
            end
            
            if scriptConnection then
                scriptConnection:Disconnect()
                scriptConnection = nil
            end
            
            for shadow, _ in pairs(currentShadows) do
                removeShadowMarker(shadow)
            end
            
            currentShadows = {}
        end

        if Value then
            startShadowChecking()
        else
            stopShadowChecking()
        end
    end
})

Visual:AddCheckbox("tweESP", {
    Text = "绊线ESP",
    Default = false,
    Callback = function(state)
        if state then
            -- 存储所有高亮对象的连接
            _G.TWE_HighlightedObjects = _G.TWE_HighlightedObjects or {}
            
            -- 高亮现有绊线
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj.Name:match("TaphTripwire") and not obj:FindFirstChild("TWE_Highlight") then
                    local highlight = Instance.new("Highlight")
                    highlight.Name = "TWE_Highlight"
                    highlight.FillColor = Color3.fromRGB(102, 0, 153) -- 深紫色
                    highlight.OutlineColor = Color3.fromRGB(102, 0, 153)
                    highlight.FillTransparency = 0.5
                    highlight.OutlineTransparency = 0
                    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    highlight.Parent = obj
                    
                    -- 监听对象移除
                    _G.TWE_HighlightedObjects[obj] = obj.AncestryChanged:Connect(function(_, parent)
                        if not parent and highlight and highlight.Parent then
                            highlight:Destroy()
                            if _G.TWE_HighlightedObjects[obj] then
                                _G.TWE_HighlightedObjects[obj]:Disconnect()
                                _G.TWE_HighlightedObjects[obj] = nil
                            end
                        end
                    end)
                end
            end

            -- 监听新增绊线
            _G.TWE_Connection = workspace.DescendantAdded:Connect(function(obj)
                if obj.Name:match("TaphTripwire") and not obj:FindFirstChild("TWE_Highlight") then
                    local highlight = Instance.new("Highlight")
                    highlight.Name = "TWE_Highlight"
                    highlight.FillColor = Color3.fromRGB(102, 0, 153)
                    highlight.OutlineColor = Color3.fromRGB(102, 0, 153)
                    highlight.FillTransparency = 0.5
                    highlight.OutlineTransparency = 0
                    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    highlight.Parent = obj
                    
                    -- 监听对象移除
                    _G.TWE_HighlightedObjects[obj] = obj.AncestryChanged:Connect(function(_, parent)
                        if not parent and highlight and highlight.Parent then
                            highlight:Destroy()
                            if _G.TWE_HighlightedObjects[obj] then
                                _G.TWE_HighlightedObjects[obj]:Disconnect()
                                _G.TWE_HighlightedObjects[obj] = nil
                            end
                        end
                    end)
                end
            end)
        else
            -- 禁用时清除所有高亮和连接
            if _G.TWE_Connection then
                _G.TWE_Connection:Disconnect()
            end
            
            -- 清理所有高亮对象
            for obj, connection in pairs(_G.TWE_HighlightedObjects or {}) do
                if connection then
                    connection:Disconnect()
                end
                if obj:FindFirstChild("TWE_Highlight") then
                    obj.TWE_Highlight:Destroy()
                end
            end
            _G.TWE_HighlightedObjects = {}
        end
    end
})

Visual:AddCheckbox("SubspaceTripmineESP",{
Text = "空间炸弹ESP",
Callback = function(v)
      if v then
             for _, v in ipairs(workspace:GetDescendants()) do
        if v:IsA("Model") and v.Name == "SubspaceTripmine" and       not v:FindFirstChild("SubspaceTripmine_ESP") then
       LibESP:AddESP(v, "", Color3.fromRGB(255, 0, 255), 14,      "SubspaceTripmine_ESP")
   end
end
     SubspaceTripmineESP = workspace.   DescendantAdded:Connect(function(v)
     if v:IsA("Model") and v.Name == "SubspaceTripmine" and not    v:FindFirstChild("SubspaceTripmine_ESP") then
        LibESP:AddESP(v, "", Color3.fromRGB(255, 0, 255), 14,  "SubspaceTripmine_ESP")
  end
end)
     else
   SubspaceTripmineESP:Disconnect()
        LibESP:Delete("SubspaceTripmine_ESP")
  end
end
})

Visual:AddCheckbox("ME",{
Text = "医疗箱ESP",
Callback = function(v)
         if v then
     for _, v in ipairs(workspace:GetDescendants()) do
        if v:IsA("Model") and v.Name == "Medkit" and not v:FindFirstChild("Medkit_ESP") then
       LibESP:AddESP(v, "Medkit", Color3.fromRGB(187, 255, 255), 14, "Medkit_ESP")
   end
end
      MedkitESP = workspace.DescendantAdded:Connect(function(v)
     if v:IsA("Model") and v.Name == "Medkit" and not    v:FindFirstChild("Medkit_ESP") then
          LibESP:AddESP(v, "Medkit", Color3.fromRGB(187, 255, 255), 14, "Medkit_ESP")
    end
end)
    else
        Medkit:Disconnect()
     LibESP:Delete("Medkit_ESP")
    end
end
})

Visual:AddCheckbox("BCE",{
Text = "可乐ESP",
Callback = function(v)
      if v then
      for _, v in ipairs(workspace:GetDescendants()) do
   if v:IsA("Model") and v.Name == "BloxyCola" and not    v:FindFirstChild("BloxyCola_ESP") then
        LibESP:AddESP(v, "Bloxy Cola", Color3.fromRGB(131, 111, 255), 14, "BloxyCola_ESP")
   end
end
     ColaESP = workspace.DescendantAdded:Connect(function(v)
        if v:IsA("Model") and v.Name == "BloxyCola" and not v:FindFirstChild("BloxyCola_ESP") then
     LibESP:AddESP(v, "Bloxy Cola", Color3.fromRGB(131, 111, 255), 14, "BloxyCola_ESP")
    end
end)
      else
    ColaESP:Disconnect()
         LibESP:Delete("BloxyCola_ESP")
end
end
})

--[[
local ChanceJudgmentAimbot = Tabs.Aimbot:AddLeftGroupbox('机会预判自瞄')

local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer

local PredictionAim = {
    Enabled = false,
    Prediction = 4,
    Duration = 1.7,
    Targets = { "Jason", "c00lkidd", "JohnDoe", "1x1x1x1", "Noli", "Slasher", "Sixer" },
    TrackedAnimations = {
        ["103601716322988"] = true, ["133491532453922"] = true, ["86371356500204"] = true,
        ["76649505662612"] = true, ["81698196845041"] = true
    },
    Humanoid = nil,
    HRP = nil,
    LastTriggerTime = 0,
    IsAiming = false,
    OriginalState = nil
}

local function getValidTarget()
    local killersFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Killers")
    if killersFolder then
        for _, name in ipairs(PredictionAim.Targets) do
            local target = killersFolder:FindFirstChild(name)
            if target and target:FindFirstChild("HumanoidRootPart") then
                return target.HumanoidRootPart
            end
        end
    end
    return nil
end

local function getPlayingAnimationIds()
    local ids = {}
    if PredictionAim.Humanoid then
        for _, track in ipairs(PredictionAim.Humanoid:GetPlayingAnimationTracks()) do
            if track.Animation and track.Animation.AnimationId then
                local id = track.Animation.AnimationId:match("%d+")
                if id then ids[id] = true end
            end
        end
    end
    return ids
end

local function setupCharacter(char)
    PredictionAim.Humanoid = char:WaitForChild("Humanoid")
    PredictionAim.HRP = char:WaitForChild("HumanoidRootPart")
end

local function OnRenderStep()
    if not PredictionAim.Enabled or not PredictionAim.Humanoid or not PredictionAim.HRP then return end
    local playing = getPlayingAnimationIds()
    local triggered = false
    for id in pairs(PredictionAim.TrackedAnimations) do
        if playing[id] then triggered = true; break end
    end

    if triggered then
        PredictionAim.LastTriggerTime = tick()
        PredictionAim.IsAiming = true
    end

    if PredictionAim.IsAiming and tick() - PredictionAim.LastTriggerTime <= PredictionAim.Duration then
        if not PredictionAim.OriginalState then
            PredictionAim.OriginalState = {
                WalkSpeed = PredictionAim.Humanoid.WalkSpeed,
                JumpPower = PredictionAim.Humanoid.JumpPower,
                AutoRotate = PredictionAim.Humanoid.AutoRotate
            }
            PredictionAim.Humanoid.AutoRotate = false
            PredictionAim.HRP.AssemblyAngularVelocity = Vector3.zero
        end
        local targetHRP = getValidTarget()
        if targetHRP then
            local predictedPos = targetHRP.Position + (targetHRP.CFrame.LookVector * PredictionAim.Prediction)
            local direction = (predictedPos - PredictionAim.HRP.Position).Unit
            local yRot = math.atan2(-direction.X, -direction.Z)
            PredictionAim.HRP.CFrame = CFrame.new(PredictionAim.HRP.Position) * CFrame.Angles(0, yRot, 0)
        end
    elseif PredictionAim.IsAiming then
        PredictionAim.IsAiming = false
        if PredictionAim.OriginalState then
            PredictionAim.Humanoid.WalkSpeed = PredictionAim.OriginalState.WalkSpeed
            PredictionAim.Humanoid.JumpPower = PredictionAim.OriginalState.JumpPower
            PredictionAim.Humanoid.AutoRotate = PredictionAim.OriginalState.AutoRotate
            PredictionAim.OriginalState = nil
        end
    end
end

local function OnRemoteEvent(eventName, eventArg)
    if not PredictionAim.Enabled then return end
    if eventName == "UseActorAbility" and type(eventArg) == "table" and eventArg[1] and tostring(eventArg[1]) == buffer.fromstring("\"Shoot\"") then
        PredictionAim.LastTriggerTime = tick()
        PredictionAim.IsAiming = true
    end
end

if LocalPlayer.Character then setupCharacter(LocalPlayer.Character) end
LocalPlayer.CharacterAdded:Connect(setupCharacter)
RunService.RenderStepped:Connect(OnRenderStep)
game:GetService("ReplicatedStorage").Modules.Network.RemoteEvent.OnClientEvent:Connect(OnRemoteEvent)

ChanceJudgmentAimbot:AddToggle("ChanceJudgmentAimbotToggle", {
    Text = "预判瞄准[Chance]",
    Default = false,
    Callback = function(Value)
           PredictionAim.Enabled = Value
    end
})

ChanceJudgmentAimbot:AddSlider("ChanceJudgmentAimbotPredictionSlider", {
    Text = "预判系数",
     Default = 4,
     Min = 0,
     Max = 15,
     Rounding = 1,
     Callback = function(Value)
          PredictionAim.Prediction = Value
     end
})
--]]

local JudgmentAimbot = Tabs.Aimbot:AddRightGroupbox('1x4远程预判')

local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer

local JudgmentAimbotPrediction = {
    Enabled = false,
    Prediction = 4,
    Duration = 1.7,
    Targets = { "Guest1337", "007n7", "Builderman", "Chance", "Dusekkar", "Elliot", "Noob", "Shedletsky", "Taph", "TwoTime" },
    TrackedAnimations = {
        ["131430497821198"] = true,
        ["119181003138006"] = true,
        ["70447634862911"] = true,
        ["93491748129367"] = true
    },
    Humanoid = nil,
    HRP = nil,
    LastTriggerTime = 1,
    IsAiming = false,
    OriginalState = nil
}

local function getValidTarget()
    local killersFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Survivors")
    if killersFolder then
        for _, name in ipairs(JudgmentAimbotPrediction.Targets) do
            local target = killersFolder:FindFirstChild(name)
            if target and target:FindFirstChild("HumanoidRootPart") then
                return target.HumanoidRootPart
            end
        end
    end
    return nil
end

local function getPlayingAnimationIds()
    local ids = {}
    if JudgmentAimbotPrediction.Humanoid then
        for _, track in ipairs(JudgmentAimbotPrediction.Humanoid:GetPlayingAnimationTracks()) do
            if track.Animation and track.Animation.AnimationId then
                local id = track.Animation.AnimationId:match("%d+")
                if id then ids[id] = true end
            end
        end
    end
    return ids
end

local function setupCharacter(char)
    JudgmentAimbotPrediction.Humanoid = char:WaitForChild("Humanoid")
    JudgmentAimbotPrediction.HRP = char:WaitForChild("HumanoidRootPart")
end

local function OnRenderStep()
    if not JudgmentAimbotPrediction.Enabled or not JudgmentAimbotPrediction.Humanoid or not JudgmentAimbotPrediction.HRP then return end
    local playing = getPlayingAnimationIds()
    local triggered = false
    for id in pairs(JudgmentAimbotPrediction.TrackedAnimations) do
        if playing[id] then triggered = true; break end
    end

    if triggered then
        JudgmentAimbotPrediction.LastTriggerTime = tick()
        JudgmentAimbotPrediction.IsAiming = true
    end

    if JudgmentAimbotPrediction.IsAiming and tick() - JudgmentAimbotPrediction.LastTriggerTime <= JudgmentAimbotPrediction.Duration then
        if not JudgmentAimbotPrediction.OriginalState then
            JudgmentAimbotPrediction.OriginalState = {
                WalkSpeed = JudgmentAimbotPrediction.Humanoid.WalkSpeed,
                JumpPower = JudgmentAimbotPrediction.Humanoid.JumpPower,
                AutoRotate = JudgmentAimbotPrediction.Humanoid.AutoRotate
            }
            JudgmentAimbotPrediction.Humanoid.AutoRotate = false
            JudgmentAimbotPrediction.HRP.AssemblyAngularVelocity = Vector3.zero
        end
        local targetHRP = getValidTarget()
        if targetHRP then
            local predictedPos = targetHRP.Position + (targetHRP.CFrame.LookVector * JudgmentAimbotPrediction.Prediction)
            local direction = (predictedPos - JudgmentAimbotPrediction.HRP.Position).Unit
            local yRot = math.atan2(-direction.X, -direction.Z)
            JudgmentAimbotPrediction.HRP.CFrame = CFrame.new(JudgmentAimbotPrediction.HRP.Position) * CFrame.Angles(0, yRot, 0)
        end
    elseif JudgmentAimbotPrediction.IsAiming then
        JudgmentAimbotPrediction.IsAiming = false
        if JudgmentAimbotPrediction.OriginalState then
            JudgmentAimbotPrediction.Humanoid.WalkSpeed = JudgmentAimbotPrediction.OriginalState.WalkSpeed
            JudgmentAimbotPrediction.Humanoid.JumpPower = JudgmentAimbotPrediction.OriginalState.JumpPower
            JudgmentAimbotPrediction.Humanoid.AutoRotate = JudgmentAimbotPrediction.OriginalState.AutoRotate
            JudgmentAimbotPrediction.OriginalState = nil
        end
    end
end

if LocalPlayer.Character then setupCharacter(LocalPlayer.Character) end
LocalPlayer.CharacterAdded:Connect(setupCharacter)

RunService.RenderStepped:Connect(OnRenderStep)

JudgmentAimbot:AddToggle("JudgmentAimbotToggle", {
    Text = "预判瞄准",
    Default = false,
    Callback = function(Value)
        JudgmentAimbotPrediction.Enabled = Value
    end
})

JudgmentAimbot:AddSlider("JudgmentAimbotPredictionSlider", {
    Text = "预判强度",
    Default = 4,
    Min = 0,
    Max = 15,
    Rounding = 1,
    Callback = function(Value)
        JudgmentAimbotPrediction.Prediction = Value
    end
})

local aimbotNoilsounds = {
    "rbxassetid://90768093259753"
}
local NoliStarBombAimbotLoopHook

local NoliAimbotSettings = {
    maxDistance = 50, 
    lockTime = 3.3    
}

local NoliAimbot = Tabs.Aimbot:AddRightGroupbox('Noli自瞄')

NoliAimbot:AddSlider('AimDistance', {
    Text = '自瞄距离',
    Default = NoliAimbotSettings.maxDistance,
    Min = 10,
    Max = 100,
    Rounding = 0,
    Compact = false,
    Callback = function(value)
        NoliAimbotSettings.maxDistance = value
    end
})

NoliAimbot:AddSlider('LockTime', {
    Text = '自瞄锁定时长 (秒)',
    Default = NoliAimbotSettings.lockTime,
    Min = 0.5,
    Max = 5,
    Rounding = 1,
    Compact = false,
    Callback = function(value)
        NoliAimbotSettings.lockTime = value
    end
})


NoliAimbot:AddCheckbox('NoilStarBombAimbotToggle', {
    Text = 'Noil星炸弹自瞄',
    Default = false,
    Callback = function(state)
     johnaim = state
    if game:GetService("Players").LocalPlayer.Character.Name ~= "Noli" and state then
        Library:Notify("LightStar\n嘿 请你把杀手角色换成Noli 再打开",3)
        Toggles.NoilStarBombAimbotToggle:SetValue(false)
        return 
    end
    if state then
        NoliStarBombAimbotLoopHook = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.ChildAdded:Connect(function(child)
            if not johnaim then return end
            for _, v in pairs(aimbotNoilsounds) do
                if child.Name == v then
                   
                    local survivors = {}
                    for _, player in pairs(game:GetService("Players"):GetPlayers()) do
                        if player ~= game:GetService("Players").LocalPlayer then
                            local character = player.Character
                            if character and character:FindFirstChild("HumanoidRootPart") then
                                table.insert(survivors, character)
                            end
                        end
                    end
    
                   
                    local nearestSurvivor = nil
                    local shortestDistance = math.huge  
                    
                    for _, survivor in pairs(survivors) do
                        local survivorHRP = survivor.HumanoidRootPart
                        local playerHRP = game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        
                        if playerHRP then
                            local distance = (survivorHRP.Position - playerHRP.Position).Magnitude
                            if distance < shortestDistance and distance <= NoliAimbotSettings.maxDistance then
                                shortestDistance = distance
                                nearestSurvivor = survivor
                            end
                        end
                    end
                    
                  
                    if nearestSurvivor then
                        local nearestHRP = nearestSurvivor.HumanoidRootPart
                        local playerHRP = game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        local maxIterations = math.floor(NoliAimbotSettings.lockTime / 0.01)  -- Convert seconds to iterations
                        if playerHRP then
                            local direction = (nearestHRP.Position - playerHRP.Position).Unit
                            local num = 1
                           
                            while num <= maxIterations do
                                task.wait(0.01)
                                num = num + 1
                                workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, nearestHRP.Position)
                                playerHRP.CFrame = CFrame.lookAt(playerHRP.Position, Vector3.new(nearestHRP.Position.X, nearestHRP.Position.Y, nearestHRP.Position.Z))
                            end
                        end
                    end
                end
            end
        end)
    else
        if NoliStarBombAimbotLoopHook then
            NoliStarBombAimbotLoopHook:Disconnect()
            NoliStarBombAimbotLoopHook = nil
        end
    end
end
})

local ZZ = Tabs.BanEffect:AddLeftGroupbox("通用版效果")

ZZ:AddCheckbox("AntiSlow", {
    Text = "无减速",
    Default = false,
    Callback = function()
        task.spawn(function()
            while Toggles.AntiSlow.Value and task.wait() do
                if localPlayer.Character and localPlayer.Character:FindFirstChild("SpeedMultipliers") then
                    for i, v in localPlayer.Character.SpeedMultipliers:GetChildren() do
                        if v.Value < 1 then
                            v.Value = 1
                        end
                    end
                end
            end
        end)
    end
})

ZZ:AddCheckbox("AntiStun", {
    Text = "无眩晕",
    Default = false,
    Callback = function()
        task.spawn(function()
            while Toggles.AntiStun.Value and task.wait() do
                if localPlayer.Character and localPlayer.Character:FindFirstChild("SpeedMultipliers") then
                    if localPlayer.Character.SpeedMultipliers:FindFirstChild("Stunned") then
                        localPlayer.Character.SpeedMultipliers:FindFirstChild("Stunned").Value = 1
                    end
                end
            end
        end)
    end
})

local Disabled = Tabs.BanEffect:AddLeftGroupbox("约翰 多反效果")

local function safeDestroy(obj)
    if obj and obj.Parent then
        obj:Destroy()
    end
end

-- Helper function to remove touch interests
local function removeTouchInterests(object)
    for _, child in ipairs(object:GetDescendants()) do
        if child:IsA("TouchTransmitter") or child.Name == "TouchInterest" then
            safeDestroy(child)
        end
    end
end

Disabled:AddLabel("<b><font color=\"rgb(255, 0, 0)\">[注意]</font></b> 开启下面 功能 会造成卡顿")

-- Anti John Doe Trail
Disabled:AddToggle("AJDT", {
    Text = "反约翰 多乱码路径", 
    Default = false,
    Callback = function(v)
        if DisabledJohnDoeTrail then
            DisabledJohnDoeTrail:Disconnect()
            DisabledJohnDoeTrail = nil
        end

        if v then
            local function RemoveTouchInterests()
                local playersFolder = workspace:FindFirstChild("Players")
                if not playersFolder then return end
                
                local killers = playersFolder:FindFirstChild("Killers")
                if not killers then return end

                for _, killer in ipairs(killers:GetChildren()) do
                    if killer:FindFirstChild("JohnDoeTrail") then
                        for _, trail in ipairs(killer.JohnDoeTrail:GetDescendants()) do
                            if trail.Name == "Trail" then
                                removeTouchInterests(trail)
                            end
                        end
                    end
                end
            end

            RemoveTouchInterests()

            DisabledJohnDoeTrail = game:GetService("RunService").Heartbeat:Connect(function()
                RemoveTouchInterests()
            end)

            -- Setup descendant added listeners
            local killers = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Killers")
            if killers then
                for _, killer in ipairs(killers:GetChildren()) do
                    if killer:FindFirstChild("JohnDoeTrail") then
                        killer.JohnDoeTrail.DescendantAdded:Connect(function(newObj)
                            if newObj.Name == "Trail" then
                                removeTouchInterests(newObj)
                            end
                        end)
                    end
                end
            end
        end
    end
})

-- Anti John Doe Spikes
Disabled:AddToggle("AJDSp", {
    Text = "反约翰 多尖刺",
    Default = false,
    Callback = function(v)
        if AntiJohnDoeSpike then
            AntiJohnDoeSpike:Disconnect()
            AntiJohnDoeSpike = nil
        end

        if v then
            local function RemoveSpikes()
                local map = workspace:FindFirstChild("Map")
                if not map then return end
                
                for _, spike in ipairs(map:GetDescendants()) do
                    if spike.Name == "Spike" then
                        safeDestroy(spike)
                    end
                end
            end

            RemoveSpikes()

            AntiJohnDoeSpike = game:GetService("RunService").Heartbeat:Connect(RemoveSpikes)

            local map = workspace:FindFirstChild("Map")
            if map then
                map.DescendantAdded:Connect(function(obj)
                    if obj.Name == "Spike" then
                        safeDestroy(obj)
                    end
                end)
            end
        end
    end
})

-- Anti John Doe Stomp
Disabled:AddToggle("AJDS", {
    Text = "反约翰 多陷阱",
    Default = false,
    Callback = function(v)
        if AntiJohnDoeStomp then
            AntiJohnDoeStomp:Disconnect()
            AntiJohnDoeStomp = nil
        end

        if v then
            local function CleanShadows()
                local map = workspace:FindFirstChild("Map")
                if not map then return end
                
                local ingame = map:FindFirstChild("Ingame")
                if not ingame then return end
                
                for _, shadow in ipairs(ingame:GetDescendants()) do
                    if shadow.Name == "Shadow" then
                        removeTouchInterests(shadow)
                        safeDestroy(shadow)
                    end
                end
            end

            CleanShadows()

            AntiJohnDoeStomp = game:GetService("RunService").Heartbeat:Connect(function()
                CleanShadows()
            end)

            local map = workspace:FindFirstChild("Map")
            if map then
                local ingame = map:FindFirstChild("Ingame")
                if ingame then
                    ingame.DescendantAdded:Connect(function(obj)
                        if obj.Name == "Shadow" then
                            removeTouchInterests(obj)
                            safeDestroy(obj)
                        end
                    end)
                end
            end
        end
    end
})

local ZZ = Tabs.BanEffect:AddLeftGroupbox('Noli反效果')


local RunService = game:GetService("RunService")
local Players = game:GetService("Players")


local noliDeleterActive = false
local deletionConnection = nil
local allowedNoli = nil


local function deleteNewNoli()
    local killersFolder = workspace:WaitForChild("Players")
    local killers = killersFolder:WaitForChild("Killers")
    
    allowedNoli = killers:FindFirstChild("Noli")
    if not allowedNoli then
        return
    end
    
    if deletionConnection then
        deletionConnection:Disconnect()
        deletionConnection = nil
    end
    
    deletionConnection = RunService.Heartbeat:Connect(function()
        allowedNoli = killers:FindFirstChild("Noli")
        
        if not allowedNoli then
            if deletionConnection then
                deletionConnection:Disconnect()
                deletionConnection = nil
            end
            return
        end
        
        for _, child in killers:GetChildren() do
            if child.Name == "Noli" and child ~= allowedNoli then
                child:Destroy()
            end
        end
    end)
end

ZZ:AddCheckbox("AntiFakeNoliDeleter", {
    Text = "反假Noli",
    Default = false,
    Tooltip = "如果你的杀手角色是Noli 杀手快到你的时候 你必须关闭此功能",
    Callback = function(enabled)
        noliDeleterActive = enabled
        
        if enabled then
            if deletionConnection then
                deletionConnection:Disconnect()
                deletionConnection = nil
            end
            
            local success, err = pcall(function()
                deleteNewNoli()
            end)
            
            if not success then
                noliDeleterActive = false
            end
        else
            if deletionConnection then
                deletionConnection:Disconnect()
                deletionConnection = nil
            end
            allowedNoli = nil
        end
    end
})

ZZ:AddToggle('NoliVoidRushNoclip', {
    Text = "VoidRush穿墙"
})

task.spawn(function()
    function isNoliVoidRush()
        return isKiller and localPlayer.Character and localPlayer.Character.Name == "Noli" and "Dashing" == localPlayer.Character:GetAttribute("VoidRushState")
    end
    while true do
        if isNoliVoidRush() and Toggles.NoliVoidRushNoclip.Value and (not Toggles.EnableNoclip.Value) then
            enableNoclip()
        elseif (not isNoliVoidRush()) and (not Toggles.EnableNoclip.Value) then
            disableNoclip()
        end
        task.wait()
    end
end)

ZZ:AddToggle('NoliVoidRushCollision', {
    Text = "VoidRush反碰撞"
})

pcall(function()
    local old
    old = hookmetamethod(game, "__namecall", function(self, ...)
        local args = {...}
        if type(args[1]) == "string" and string.find(args[1], localPlayer.Name) then
            if string.find(args[1], "VoidRushCollision") then
                if Toggles.NoliVoidRushCollision.Value then
                    return
                end
            elseif string.find(args[1], "C00lkiddCollision") then
                if Toggles.WalkspeedAntiCollision.Value then
                    return
                end
            end
        end
        return old(self, ...)
    end)
end)

local player = game:GetService("Players").LocalPlayer
local isVoidRushCrashed = false
local characterCheckLoop = nil

local function manageVoidRushState(character)
    while isVoidRushCrashed and character and character.Parent do
        character:SetAttribute("VoidRushState", "Crashed")
        task.wait(0.5)  
    end
end

ZZ:AddToggle("VoidRushOverride", {
    Text = "VoidRush无视碰撞",
    Default = false,
    Tooltip = "需要锁定视角",
    Callback = function(enabled)
        local RunService = game:GetService("RunService")
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        
        local Character
        local Humanoid
        local HumanoidRootPart
        local monitorTask
        local overrideConnection
        local characterAddedConnection
        
        local ORIGINAL_DASH_SPEED = 60
        local DEFAULT_WALK_SPEED = 16
        
        local function setupCharacter()
            if LocalPlayer.Character then
                Character = LocalPlayer.Character
                Humanoid = Character:WaitForChild("Humanoid")
                HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
                Humanoid.WalkSpeed = DEFAULT_WALK_SPEED
                Humanoid.AutoRotate = true
            end
        end
        
        local function startOverride()
            if overrideConnection then return end
            
            overrideConnection = RunService.RenderStepped:Connect(function()
                if not Character or not Humanoid or not HumanoidRootPart then
                    return
                end
                
                Humanoid.WalkSpeed = ORIGINAL_DASH_SPEED
                Humanoid.AutoRotate = false
                
                local direction = HumanoidRootPart.CFrame.LookVector
                local horizontalDirection = Vector3.new(direction.X, 0, direction.Z).Unit
                Humanoid:Move(horizontalDirection)
            end)
        end
        
        local function stopOverride()
            if overrideConnection then
                overrideConnection:Disconnect()
                overrideConnection = nil
            end
            
            if Humanoid then
                Humanoid.WalkSpeed = DEFAULT_WALK_SPEED
                Humanoid.AutoRotate = true
                Humanoid:Move(Vector3.new(0, 0, 0))
            end
        end
        
        local function monitorVoidRush()
            while enabled and task.wait() do
                if not Character or not Humanoid or not HumanoidRootPart then
                    setupCharacter()
                    if not Character then continue end
                end
                
                local voidRushState = Character:GetAttribute("VoidRushState")
                if voidRushState == "Dashing" then
                    startOverride()
                else
                    stopOverride()
                end
            end
            stopOverride()
        end
        
        local function cleanup()
            if monitorTask then
                task.cancel(monitorTask)
                monitorTask = nil
            end
            
            if characterAddedConnection then
                characterAddedConnection:Disconnect()
                characterAddedConnection = nil
            end
            
            stopOverride()
            setupCharacter()
        end
        
        if enabled then
            cleanup()
            setupCharacter()
            monitorTask = task.spawn(monitorVoidRush)
            
            characterAddedConnection = LocalPlayer.CharacterAdded:Connect(function(newChar)
                Character = newChar
                Humanoid = Character:WaitForChild("Humanoid")
                HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
                if not enabled then
                    Humanoid.WalkSpeed = DEFAULT_WALK_SPEED
                    Humanoid.AutoRotate = true
                end
            end)
        else
            cleanup()
        end
    end
})

local ZZ = Tabs.BanEffect:AddRightGroupbox('1x4反效果')

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local RemoteEvent = ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("RemoteEvent")

local AutoPopup = {
    Enabled = false,
    Task = nil,
    Connections = {},
    Interval = 0.5
}

local function deletePopups()
    if not LocalPlayer or not LocalPlayer:FindFirstChild("PlayerGui") then
        return false
    end
    
    local tempUI = LocalPlayer.PlayerGui:FindFirstChild("TemporaryUI")
    if not tempUI then
        return false
    end
    
    local deleted = false
    for _, popup in ipairs(tempUI:GetChildren()) do
        if popup.Name == "1x1x1x1Popup" then
            popup:Destroy()
            deleted = true
        end
    end
    return deleted
end

local function triggerEntangled()
    local args = { [1] = "Entangled" }
    pcall(function()
        RemoteEvent:FireServer(unpack(args))
    end)
end

local function setupPopupListener()
    if not LocalPlayer or not LocalPlayer:FindFirstChild("PlayerGui") then return end
    
    local tempUI = LocalPlayer.PlayerGui:FindFirstChild("TemporaryUI")
    if not tempUI then
        tempUI = Instance.new("Folder")
        tempUI.Name = "TemporaryUI"
        tempUI.Parent = LocalPlayer.PlayerGui
    end
    
    if AutoPopup.Connections.ChildAdded then
        AutoPopup.Connections.ChildAdded:Disconnect()
    end
    
    AutoPopup.Connections.ChildAdded = tempUI.ChildAdded:Connect(function(child)
        if AutoPopup.Enabled and child.Name == "1x1x1x1Popup" then
            task.defer(function()
                child:Destroy()
            end)
        end
    end)
end

local function runMainTask()
    while AutoPopup.Enabled do
        deletePopups()
        triggerEntangled()
        task.wait(AutoPopup.Interval) -- 使用设置的间隔时间
    end
end

local function startAutoPopup()
    if AutoPopup.Enabled then return end
    
    AutoPopup.Enabled = true
    setupPopupListener()
    
    if AutoPopup.Task then
        task.cancel(AutoPopup.Task)
    end
    AutoPopup.Task = task.spawn(runMainTask)
end

local function stopAutoPopup()
    if not AutoPopup.Enabled then return end
    
    AutoPopup.Enabled = false
    
    if AutoPopup.Task then
        task.cancel(AutoPopup.Task)
        AutoPopup.Task = nil
    end
    
    for _, connection in pairs(AutoPopup.Connections) do
        connection:Disconnect()
    end
    AutoPopup.Connections = {}
end

-- 添加间隔时间调整滑块
ZZ:AddSlider('AutoPopupInterval', {
    Text = '执行间隔(秒)',
    Default = 0.5,
    Min = 0.5,
    Max = 2,
    Rounding = 0,
    Tooltip = '设置自动执行的间隔时间(1-5秒)',
    Callback = function(value)
        AutoPopup.Interval = value
    end
})

ZZ:AddCheckbox('AutoPopupToggle', {
    Text = '反弹窗',
    Default = false,
    Tooltip = '去除弹窗和懒惰效果',
    Callback = function(state)
        if state then
            startAutoPopup()
        else
            stopAutoPopup()
        end
    end
})

if LocalPlayer then
    LocalPlayer:GetPropertyChangedSignal("Parent"):Connect(function()
        if not LocalPlayer.Parent then
            stopAutoPopup()
        end
    end)
end

ZZ:AddToggle("RemoveUnstableEye", {
    Text = "反不稳定之眼不能移动", 
    Default = false,
    Callback = function(v)
        if not _G.UnstableEyeCleanup then _G.UnstableEyeCleanup = {} end
        local connections = _G.UnstableEyeCleanup

        -- 先清理现有的连接
        for _, conn in pairs(connections) do
            if typeof(conn) == "RBXScriptConnection" then
                conn:Disconnect()
            end
        end
        _G.UnstableEyeCleanup = {}

        -- 如果关闭按钮，直接返回
        if not v then return end

        local function CleanUnstableEyeEffects()
            local killersFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Killers")
            if not killersFolder then return end
            
            for _, killer in ipairs(killersFolder:GetDescendants()) do
                if killer.Name == "UnstableEye" then
                    killer:Destroy()
                end
            end
        end

        -- 初始清理
        task.spawn(CleanUnstableEyeEffects)

        -- 设置定期清理
        connections.heartbeat = game:GetService("RunService").Heartbeat:Connect(function()
            task.wait(1.5)
            CleanUnstableEyeEffects()
        end)

        -- 设置新对象添加时的监听
        local killersFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Killers")
        if killersFolder then
            connections.descendantAdded = killersFolder.DescendantAdded:Connect(function(descendant)
                if descendant.Name == "UnstableEye" then
                    descendant:Destroy()
                end
            end)
        end
    end
})

ZZ:AddToggle("RemoveBlindness", {
    Text = "反失明效果", 
    Default = false,
    Callback = function(v)
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        
        -- 获取 Modules.StatusEffects 路径
        local modulesFolder = ReplicatedStorage:FindFirstChild("Modules")
        local statusEffects = modulesFolder and modulesFolder:FindFirstChild("StatusEffects")
        
        if v then
            -- 确保路径存在
            if not statusEffects then
                warn("未找到 ReplicatedStorage.Modules.StatusEffects 路径")
                return
            end
            
            -- 查找并删除 Blindness 模块
            local blindness = statusEffects:FindFirstChild("Blindness")
            if blindness then
                blindness:Destroy()
                print("已删除 Blindness 模块")
            else
                print("未找到 Blindness 模块")
            end
            
            -- 设置持续检查
            if not _G.BlindnessCleanup then _G.BlindnessCleanup = {} end
            local connections = _G.BlindnessCleanup
            
            -- 定期检查
            connections.heartbeat = game:GetService("RunService").Heartbeat:Connect(function()
                task.wait(1.5)
                local blindness = statusEffects:FindFirstChild("Blindness")
                if blindness then
                    blindness:Destroy()
                end
            end)
            
            -- 监听新增模块
            connections.descendantAdded = statusEffects.DescendantAdded:Connect(function(descendant)
                if descendant.Name == "Blindness" then
                    task.wait(0.1) -- 确保模块完全加载
                    descendant:Destroy()
                end
            end)
        else
            -- 关闭时清理连接
            if _G.BlindnessCleanup then
                for _, conn in pairs(_G.BlindnessCleanup) do
                    conn:Disconnect()
                end
                _G.BlindnessCleanup = {}
            end
        end
    end
})

getgenv().Players = game:GetService("Players")
getgenv().RunService = game:GetService("RunService")
getgenv().LocalPlayer = getgenv().Players.LocalPlayer
getgenv().ReplicatedStorage = game:GetService("ReplicatedStorage")
getgenv().buffer = buffer or require(getgenv().ReplicatedStorage.Buffer)
getgenv().RemoteEvent = getgenv().ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("RemoteEvent")

if not getgenv().originalNamecall then
   getgenv().HookRules = {}
   getgenv().originalNamecall = hookmetamethod(game, "__namecall", function(self, ...)
       local method = getnamecallmethod()
       local args = {...}
       if method == "FireServer" then
           for _, rule in ipairs(getgenv().HookRules) do
               if (not rule.remoteName or self.Name == rule.remoteName) then
                   if not rule.blockedFirstArg or args[1] == rule.blockedFirstArg then
                       if rule.block then
                           return
                       end
                   end
               end
           end
       end
       return getgenv().originalNamecall(self, ...)
   end)
end

getgenv().activateRemoteHook = function(remoteName, blockedFirstArg)
   for _, rule in ipairs(getgenv().HookRules) do
       if rule.remoteName == remoteName and rule.blockedFirstArg == blockedFirstArg then
           return
       end
   end
   table.insert(getgenv().HookRules, {
       remoteName = remoteName,
       blockedFirstArg = blockedFirstArg,
       block = true
   })
end

getgenv().deactivateRemoteHook = function(remoteName, blockedFirstArg)
   for i, rule in ipairs(getgenv().HookRules) do
       if rule.remoteName == remoteName and rule.blockedFirstArg == blockedFirstArg then
           table.remove(getgenv().HookRules, i)
           break
       end
   end
end

local ZZ = Tabs.BanEffect:AddRightGroupbox('c00lkidd')

local globalEnv = getgenv()
globalEnv.walkSpeed = 100
globalEnv.toggle = false
globalEnv.connection = nil

function globalEnv.getCharacter()
   return globalEnv.LocalPlayer.Character or globalEnv.LocalPlayer.CharacterAdded:Wait()
end

function globalEnv.onHeartbeat()
   local player = globalEnv.LocalPlayer
   local character = globalEnv.getCharacter()
   if character.Name ~= "c00lkidd" then return end
   
   local char = globalEnv.getCharacter()
   local rootPart = char:FindFirstChild("HumanoidRootPart")
   local humanoid = char:FindFirstChildOfClass("Humanoid")
   local lv = rootPart and rootPart:FindFirstChild("LinearVelocity")
   
   if not rootPart or not humanoid or not lv then return end
   
   if lv then
       lv.VectorVelocity = Vector3.new(math.huge, math.huge, math.huge)
       lv.Enabled = false
   end

   local stopMovement = false
   local validValues = {
       Timeout = true,
       Collide = true,
       Hit = true
   }

   if not stopMovement then
       local lookVector = workspace.CurrentCamera.CFrame.LookVector
       local moveDir = Vector3.new(lookVector.X, 0, lookVector.Z)
       if moveDir.Magnitude > 0 then
           moveDir = moveDir.Unit
           rootPart.Velocity = Vector3.new(moveDir.X * globalEnv.walkSpeed, rootPart.Velocity.Y, moveDir.Z * globalEnv.walkSpeed)
           rootPart.CFrame = CFrame.new(rootPart.Position, rootPart.Position + moveDir)
       end
   end
end

ZZ:AddCheckbox("c00lkiddSpurtspeedController", {
    Text = "速度覆盖控制器[大运出击]",
    Default = false,
    Callback = function(value)
        if value then
            globalEnv.connection = globalEnv.RunService.Heartbeat:Connect(globalEnv.onHeartbeat)
        else
            if globalEnv.connection then
                globalEnv.connection:Disconnect()
            end
        end
    end
})

ZZ:AddSlider("c00lkiddSpurtSpeed", {
    Text = "移动速度[大运速度]",
    Default = 100,
    Min = 16,
    Max = 200,
    Rounding = 1,
    Callback = function(Value)
        globalEnv.walkSpeed = Value
    end
})

ZZ:AddCheckbox("c00lkiddIgnoreObjectables", {
    Text = "无视障碍物",
    Default = false,
    Callback = function(Value)
        if Value then
   getgenv().activateRemoteHook("RemoteEvent", game.Players.LocalPlayer.Name .. "C00lkiddCollision")
        else
   getgenv().deactivateRemoteHook("RemoteEvent", game.Players.LocalPlayer.Name .. "C00lkiddCollision")
        end
    end
})

local ZZ = Tabs.BanEffect:AddRightGroupbox('其他反效果')

ZZ:AddToggle("AntiHealthGlitch", {
    Text = "反血量故障",
    Default = false,
    Callback = function()
        task.spawn(function()
            local Players = game:GetService("Players")
            local LocalPlayer = Players.LocalPlayer

            while Toggles.AntiHealthGlitch.Value and task.wait(0.1) do
                -- 安全获取 UI
                local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui")
                if not PlayerGui then continue end

                local TemporaryUI = PlayerGui:FindFirstChild("TemporaryUI")
                if not TemporaryUI then continue end

                -- 清理异常血条
                for _, v in pairs(TemporaryUI:GetChildren()) do
                    if v.Name == "Frame" and v:FindFirstChild("Glitched") then
                        v:Destroy()
                    end
                end
            end
        end)
    end
})

getgenv().isFiringDusekkar = false

ZZ:AddToggle("ProtectionDusekkar", {
   Text = "反Dusekkar取消保护",
   Default = false,
   Tooltip = "防止护盾被取消",
   Callback = function(Value)
       if Value then
           getgenv().activateRemoteHook("RemoteEvent", game.Players.LocalPlayer.Name .. "DusekkarCancel")
   if not getgenv().isFiringDusekkar then
       getgenv().isFiringDusekkar = true
       task.spawn(function()
           task.wait(4)
           local ReplicatedStorage = game:GetService("ReplicatedStorage")
           local RemoteEvent = ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("RemoteEvent")
           RemoteEvent:FireServer({game.Players.LocalPlayer.Name .. "DusekkarCancel"})
           getgenv().isFiringDusekkar = false
       end)
   end
       else
           getgenv().deactivateRemoteHook("RemoteEvent", game.Players.LocalPlayer.Name .. "DusekkarCancel")
       end
   end
})

ZZ:AddToggle("RemoveNoobSlateskin", {
    Text = "反菜鸟石板速度", 
    Default = false,
    Callback = function(v)
        if not _G.SlateskinCleanup then _G.SlateskinCleanup = {} end
        local connections = _G.SlateskinCleanup

        for _, conn in pairs(connections) do
            if typeof(conn) == "RBXScriptConnection" then
                conn:Disconnect()
            end
        end
        _G.SlateskinCleanup = {}

        if not v then return end

        local function CleanSlateskins()
            local survivorsFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Survivors")
            if not survivorsFolder then return end
            
            local survivorList = survivorsFolder:GetChildren()
            for i = 1, #survivorList, 5 do
                task.spawn(function()
                    for j = i, math.min(i + 4, #survivorList) do
                        local survivor = survivorList[j]
                        local slateskin = survivor:FindFirstChild("SlateskinStatus")
                        if slateskin then
                            slateskin:Destroy()
                        end
                    end
                end)
            end
        end

        task.spawn(CleanSlateskins)

        connections.heartbeat = game:GetService("RunService").Heartbeat:Connect(function()
            task.wait(2)
            CleanSlateskins()
        end)

        local survivorsFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Survivors")
        if survivorsFolder then
            connections.descendantAdded = survivorsFolder.DescendantAdded:Connect(function(descendant)
                if descendant.Name == "SlateskinStatus" then
                    descendant:Destroy()
                end
            end)
        end
    end
})

ZZ:AddToggle("AntiSubspace", {
    Text = "反塔夫模糊和颜色反转效果",
    Default = false,
    Callback = function()
        task.spawn(function()
            while Toggles.AntiSubspace.Value and task.wait() do
                local subspace = {
                    "SubspaceVFXBlur",
                    "SubspaceVFXColorCorrection"
                }

                for i, v in pairs(subspace) do
                    if game.Lighting:FindFirstChild(v) then
                        game.Lighting[v]:Destroy()
                    end
                end
            end
        end)
    end
})

local originalPlayerValues = {}
hiddenStats = false

ZZ:AddToggle("AntiHiddenStats", {
    Text = "反隐藏数据",
    Tooltip = "开启后强制显示玩家的胜负、时长等隐私数据",
    Default = false,
    Callback = function(state)
        hiddenStats = state
        
        for _, player in ipairs(Players:GetPlayers()) do
            pcall(function()
                if not player.PlayerData or not player.PlayerData.Settings or not player.PlayerData.Settings.Privacy then return end
                
                if state then
                    -- 保存原始值
                    if not originalPlayerValues[player.UserId] then
                        originalPlayerValues[player.UserId] = {}
                    end
                    
                    local privacy = player.PlayerData.Settings.Privacy
                    for _, key in ipairs({"HideKillerWins", "HidePlaytime", "HideSurvivorWins"}) do
                        local value = privacy:FindFirstChild(key)
                        if value then
                            originalPlayerValues[player.UserId][key] = value.Value
                            value.Value = false
                        end
                    end
                else
                    -- 恢复原始值
                    if originalPlayerValues[player.UserId] then
                        local privacy = player.PlayerData.Settings.Privacy
                        for key, val in pairs(originalPlayerValues[player.UserId]) do
                            local value = privacy:FindFirstChild(key)
                            if value then value.Value = val end
                        end
                    end
                end
            end)
        end
        
        -- 监听新玩家加入
        if state then
            Players.PlayerAdded:Connect(function(player)
                if hiddenStats then
                    task.wait(1)
                    pcall(function()
                        if player.PlayerData and player.PlayerData.Settings and player.PlayerData.Settings.Privacy then
                            local privacy = player.PlayerData.Settings.Privacy
                            for _, key in ipairs({"HideKillerWins", "HidePlaytime", "HideSurvivorWins"}) do
                                local value = privacy:FindFirstChild(key)
                                if value then value.Value = false end
                            end
                        end
                    end)
                end
            end)
        end
    end
})

local Disabled = Tabs.BanEffect:AddLeftGroupbox('访客1337反效果')

Disabled:AddCheckbox("RemoveSlowed", {
    Text = "反缓慢", 
    Default = false,
    Callback = function(v)
        if not _G.SlowedCleanup then _G.SlowedCleanup = {} end
        local connections = _G.SlowedCleanup

        for _, conn in pairs(connections) do
            if typeof(conn) == "RBXScriptConnection" then
                conn:Disconnect()
            end
        end
        _G.SlowedCleanup = {}

        if not v then return end

        local function CleanSlowedStatuses()
            local survivorsFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Survivors")
            if not survivorsFolder then return end
            
            for _, survivor in ipairs(survivorsFolder:GetDescendants()) do
                if survivor.Name == "SlowedStatus" then
                    survivor:Destroy()
                end
            end
        end

        task.spawn(CleanSlowedStatuses)

        connections.heartbeat = game:GetService("RunService").Heartbeat:Connect(function()
            task.wait(1.5)
            CleanSlowedStatuses()
        end)

        local survivorsFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Survivors")
        if survivorsFolder then
            connections.descendantAdded = survivorsFolder.DescendantAdded:Connect(function(descendant)
                if descendant.Name == "SlowedStatus" then
                    descendant:Destroy()
                end
            end)
        end
    end
})

Disabled:AddCheckbox("RemoveBlockingSlow", {
    Text = "反格挡速度", 
    Default = false,
    Callback = function(v)
        if not _G.BlockingCleanup then _G.BlockingCleanup = {} end
        local connections = _G.BlockingCleanup

        for _, conn in pairs(connections) do
            if typeof(conn) == "RBXScriptConnection" then
                conn:Disconnect()
            end
        end
        _G.BlockingCleanup = {}

        if not v then return end

        local function CleanStatuses()
            local survivorsFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Survivors")
            if not survivorsFolder then return end
            
            for _, survivor in ipairs(survivorsFolder:GetDescendants()) do
                if survivor.Name == "ResistanceStatus" or survivor.Name == "GuestBlocking" then
                    survivor:Destroy()
                end
            end
        end

        task.spawn(CleanStatuses)

        connections.heartbeat = game:GetService("RunService").Heartbeat:Connect(function()
            task.wait(1.5)
            CleanStatuses()
        end)

        local survivorsFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Survivors")
        if survivorsFolder then
            connections.descendantAdded = survivorsFolder.DescendantAdded:Connect(function(descendant)
                if descendant.Name == "ResistanceStatus" or descendant.Name == "GuestBlocking" then
                    descendant:Destroy()
                end
            end)
        end
    end
})

Disabled:AddCheckbox("RemovePunchSlow", {
    Text = "反拳击速度", 
    Default = false,
    Callback = function(v)
        if not _G.PunchCleanup then _G.PunchCleanup = {} end
        local connections = _G.PunchCleanup

        for _, conn in pairs(connections) do
            if typeof(conn) == "RBXScriptConnection" then
                conn:Disconnect()
            end
        end
        _G.PunchCleanup = {}

        if not v then return end

        local function CleanStatuses()
            local survivorsFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Survivors")
            if not survivorsFolder then return end
            
            for _, survivor in ipairs(survivorsFolder:GetDescendants()) do
                if survivor.Name == "ResistanceStatus" or survivor.Name == "PunchAbility" then
                    survivor:Destroy()
                end
            end
        end

        task.spawn(CleanStatuses)

        connections.heartbeat = game:GetService("RunService").Heartbeat:Connect(function()
            task.wait(1.5)
            CleanStatuses()
        end)

        local survivorsFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Survivors")
        if survivorsFolder then
            connections.descendantAdded = survivorsFolder.DescendantAdded:Connect(function(descendant)
                if descendant.Name == "ResistanceStatus" or descendant.Name == "PunchAbility" then
                    descendant:Destroy()
                end
            end)
        end
    end
})

Disabled:AddCheckbox("RemoveChargeEnded", {
    Text = "反冲刺结束后效果", 
    Default = false,
    Callback = function(v)
        if not _G.ChargeEndedCleanup then _G.ChargeEndedCleanup = {} end
        local connections = _G.ChargeEndedCleanup

        for _, conn in pairs(connections) do
            if typeof(conn) == "RBXScriptConnection" then
                conn:Disconnect()
            end
        end
        _G.ChargeEndedCleanup = {}

        if not v then return end

        local function CleanChargeEndedEffects()
            local survivorsFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Survivors")
            if not survivorsFolder then return end
            
            for _, survivor in ipairs(survivorsFolder:GetDescendants()) do
                if survivor.Name == "GuestChargeEnded" then
                    survivor:Destroy()
                end
            end
        end

        task.spawn(CleanChargeEndedEffects)

        connections.heartbeat = game:GetService("RunService").Heartbeat:Connect(function()
            task.wait(1.5)
            CleanChargeEndedEffects()
        end)

        local survivorsFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Survivors")
        if survivorsFolder then
            connections.descendantAdded = survivorsFolder.DescendantAdded:Connect(function(descendant)
                if descendant.Name == "GuestChargeEnded" then
                    descendant:Destroy()
                end
            end)
        end
    end
})

local Warning = Tabs.NotificationListen:AddLeftGroupbox("杀手靠近提示","bell")

-- 杀手靠近提示设置
local KillerWarningSettings = {
    Enabled = false,
    WarningDistance = 100, -- 警告距离(米)
    WarningColor = Color3.fromRGB(255, 0, 0), -- 警告颜色(红色)
    TextSize = 20, -- 文字大小
    BlinkInterval = 0.5, -- 闪烁间隔(秒)
    LastWarningTime = 0, -- 上次警告时间
    WarningCooldown = 5, -- 警告冷却时间(秒)
}

-- 存储ESP对象
local warningLabel = Drawing.new("Text")
warningLabel.Visible = false
warningLabel.Center = true
warningLabel.Outline = true
warningLabel.Font = 2 -- 粗体字体
warningLabel.Color = KillerWarningSettings.WarningColor
warningLabel.Size = KillerWarningSettings.TextSize

-- 更新警告显示
local function updateKillerWarning()
    local player = game.Players.LocalPlayer
    local character = player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end
    
    local killersFolder = workspace.Players:FindFirstChild("Killers")
    if not killersFolder then return end
    
    local closestDistance = math.huge
    local closestKiller = nil
    
    -- 寻找最近的杀手
    for _, killer in ipairs(killersFolder:GetChildren()) do
        if killer:IsA("Model") and killer:FindFirstChild("HumanoidRootPart") then
            local distance = (character.HumanoidRootPart.Position - killer.HumanoidRootPart.Position).Magnitude
            if distance < closestDistance then
                closestDistance = distance
                closestKiller = killer
            end
        end
    end
    
    -- 检查距离并显示警告
    if closestKiller and closestDistance <= KillerWarningSettings.WarningDistance then
        local currentTime = tick()
        
        -- 闪烁效果
        if currentTime - KillerWarningSettings.LastWarningTime >= KillerWarningSettings.BlinkInterval then
            warningLabel.Visible = not warningLabel.Visible
            KillerWarningSettings.LastWarningTime = currentTime
        end
        
        -- 设置警告文本
        warningLabel.Text = string.format("警告! 杀手 %s 在 %d 米内!", closestKiller.Name, math.floor(closestDistance))
        warningLabel.Position = Vector2.new(
            workspace.CurrentCamera.ViewportSize.X / 2,
            workspace.CurrentCamera.ViewportSize.Y * 0.2
        )
        
        -- 播放警告音效(冷却时间内只播放一次)
        if currentTime - KillerWarningSettings.LastWarningTime >= KillerWarningSettings.WarningCooldown then
            warningSound:Play()
            KillerWarningSettings.LastWarningTime = currentTime
        end
    else
        warningLabel.Visible = false
    end
end

-- 主开关
Warning:AddCheckbox("KillerWarningToggle", {
    Text = "杀手靠近提示",
    Default = false,
    Callback = function(enabled)
        KillerWarningSettings.Enabled = enabled
        if enabled then
            -- 初始化连接
            if not KillerWarningSettings.connection then
                KillerWarningSettings.connection = game:GetService("RunService").RenderStepped:Connect(updateKillerWarning)
            end
        else
            -- 关闭连接
            if KillerWarningSettings.connection then
                KillerWarningSettings.connection:Disconnect()
                KillerWarningSettings.connection = nil
            end
            warningLabel.Visible = false
        end
    end
})

-- 距离设置
Warning:AddSlider("WarningDistance", {
    Text = "警告距离(米)",
    Min = 10,
    Max = 200,
    Default = 100,
    Rounding = 0,
    Callback = function(value)
        KillerWarningSettings.WarningDistance = value
    end
})

-- 文字大小设置
Warning:AddSlider("WarningTextSize", {
    Text = "文字大小",
    Min = 10,
    Max = 30,
    Default = 20,
    Rounding = 0,
    Callback = function(value)
        KillerWarningSettings.TextSize = value
        warningLabel.Size = value
    end
})

-- 闪烁速度设置
Warning:AddSlider("BlinkSpeed", {
    Text = "闪烁速度",
    Min = 0.1,
    Max = 1,
    Default = 0.5,
    Rounding = 1,
    Callback = function(value)
        KillerWarningSettings.BlinkInterval = value
    end
})

-- 警告颜色选择
Warning:AddDropdown("WarningColor", {
    Values = {"红色", "橙色", "黄色", "粉色", "紫色"},
    Default = "红色",
    Text = "警告颜色",
    Callback = function(value)
        local colorMap = {
            ["红色"] = Color3.fromRGB(255, 0, 0),
            ["橙色"] = Color3.fromRGB(255, 165, 0),
            ["黄色"] = Color3.fromRGB(255, 255, 0),
            ["粉色"] = Color3.fromRGB(255, 192, 203),
            ["紫色"] = Color3.fromRGB(128, 0, 128)
        }
        KillerWarningSettings.WarningColor = colorMap[value] or Color3.fromRGB(255, 0, 0)
        warningLabel.Color = KillerWarningSettings.WarningColor
    end
})

local Visual = Tabs.NotificationListen:AddRightGroupbox("Noli监听","drone")

Visual:AddToggle("NoliTeleportAlertNotify", {
    Text = "Noli传送提示",
    Default = false,
    Callback = function(v)
        if v then
            local activeConnections = {}
            local lastNotifyTime = 0
            local COOLDOWN = 2
            local TARGET_SOUND_ID = "rbxassetid://125253972523701"

            local function safeNotify()
                local currentTime = tick()
                if currentTime - lastNotifyTime > COOLDOWN then
                    Library:Notify("LightStar-警告\nNoli正在传送")
                    lastNotifyTime = currentTime
                end
            end

            local function checkSoundPlaying(sound)
                return sound and sound.IsPlaying or false
            end

            local function monitorSound(sound)
                task.spawn(function()
                    while sound.Parent and checkSoundPlaying(sound) do
                        safeNotify()
                        task.wait(COOLDOWN)
                    end
                end)
            end

            local function setupKiller(killer)
                local humanoidRootPart = killer:WaitForChild("HumanoidRootPart", 5)
                if humanoidRootPart then
                   
                    for _, child in ipairs(humanoidRootPart:GetChildren()) do
                        if child:IsA("Sound") and child.SoundId == TARGET_SOUND_ID then
                            monitorSound(child)
                        end
                    end

                
                    local connection = humanoidRootPart.ChildAdded:Connect(function(child)
                        if child:IsA("Sound") and child.SoundId == TARGET_SOUND_ID then
                            monitorSound(child)
                        end
                    end)
                    
                    table.insert(activeConnections, connection)
                end
            end

        
            table.insert(activeConnections, workspace.Players.Killers.ChildAdded:Connect(setupKiller))

          
            for _, killer in ipairs(workspace.Players.Killers:GetChildren()) do
                task.spawn(setupKiller, killer)
            end
        else
           
            for _, conn in ipairs(activeConnections) do
                conn:Disconnect()
            end
            activeConnections = {}
        end
    end
})

Visual:AddToggle("NoliTeleportCancelNotify", {
    Text = "Noli传送取消提示",
    Default = false,
    Callback = function(v)
        if v then
            local activeConnections = {}
            local lastNotifyTime = 0
            local COOLDOWN = 2 
            
            local function checkSound(humanoidRootPart)
                for _, child in ipairs(humanoidRootPart:GetChildren()) do
                    if child:IsA("Sound") and child.SoundId == "rbxassetid://9125639499" and child.IsPlaying then
                        local currentTime = tick()
                        if currentTime - lastNotifyTime > COOLDOWN then
                            Library:Notify("LightStar-警告\nNoli取消了传送")
                            lastNotifyTime = currentTime
                        end
                        return true
                    end
                end
                return false
            end

            local function setupKiller(killer)
                local humanoidRootPart = killer:WaitForChild("HumanoidRootPart", 5)
                if humanoidRootPart then
                    local connection
                    connection = humanoidRootPart.ChildAdded:Connect(function(child)
                        if child:IsA("Sound") and child.SoundId == "rbxassetid://9125639499" then
                            task.spawn(function()
                                while child.Parent and child.IsPlaying do
                                    local currentTime = tick()
                                    if currentTime - lastNotifyTime > COOLDOWN then
                                        Library:Notify("LightStar-警告\nNoli取消了传送")
                                        lastNotifyTime = currentTime
                                    end
                                    task.wait(0.1)
                                end
                            end)
                        end
                    end)
                    
                    table.insert(activeConnections, connection)
                    
                    -- 初始检查
                    task.spawn(function()
                        while killer.Parent do
                            if checkSound(humanoidRootPart) then
                                task.wait(COOLDOWN)
                            else
                                task.wait(0.1)
                            end
                        end
                        connection:Disconnect()
                    end)
                end
            end

            -- 监听新杀手
            table.insert(activeConnections, workspace.Players.Killers.ChildAdded:Connect(setupKiller))
            
            -- 检查现有杀手
            for _, killer in ipairs(workspace.Players.Killers:GetChildren()) do
                task.spawn(setupKiller, killer)
            end
        else
            for _, conn in ipairs(activeConnections) do
                conn:Disconnect()
            end
            activeConnections = {}
        end
    end
})

Visual:AddToggle("NoliMotorSelectNotify", {
    Text = "Noli电机选择提示",
    Default = false,
    Callback = function(v)
        local soundId = "rbxassetid://124468317999247"
        local notificationMessage = "LightStar-警告\nNoli正在选择电机"
        local connections = {}
        local cooldown = 2 -- 通知冷却时间(秒)
        local lastNotifyTime = 0

        local function disconnectAll()
            for _, conn in pairs(connections) do
                conn:Disconnect()
            end
            connections = {}
        end

        local function safeNotify()
            local now = os.time()
            if now - lastNotifyTime >= cooldown then
                Library:Notify(notificationMessage)
                lastNotifyTime = now
            end
        end

        local function setupSoundListener(humanoidRootPart)
            local function onChildAdded(child)
                if child:IsA("Sound") and child.SoundId == soundId then
                    safeNotify()
                end
            end

            local conn = humanoidRootPart.ChildAdded:Connect(onChildAdded)
            table.insert(connections, conn)

            -- 检查已存在的音频
            for _, child in ipairs(humanoidRootPart:GetChildren()) do
                if child:IsA("Sound") and child.SoundId == soundId then
                    safeNotify()
                    break
                end
            end
        end

        local function onKillerAdded(killer)
            local humanoidRootPart = killer:FindFirstChild("HumanoidRootPart") or killer:WaitForChild("HumanoidRootPart", 3)
            if humanoidRootPart then
                setupSoundListener(humanoidRootPart)
            end
        end

        if v then
            -- 监听新杀手
            local mainConn = workspace.Players.Killers.ChildAdded:Connect(onKillerAdded)
            table.insert(connections, mainConn)

            -- 初始化现有杀手
            for _, killer in ipairs(workspace.Players.Killers:GetChildren()) do
                task.spawn(onKillerAdded, killer)
            end
        else
            disconnectAll()
        end
    end
})

Visual:AddToggle("NoliMotorSelectNotify", {
    Text = "Noli冲刺提示",
    Default = false,
    Callback = function(v)
        local soundId = "rbxassetid://126318185932771"
        local notificationMessage = "LightStar-警告\nNoli正在冲刺"
        local endNotificationMessage = "LightStar-警告\nNoli冲刺结束"
        local connections = {}
        local cooldown = 2
        local lastNotifyTime = 0

        local function disconnectAll()
            for _, conn in pairs(connections) do
                conn:Disconnect()
            end
            connections = {}
        end

        local function safeNotify(message)
            local now = os.time()
            if now - lastNotifyTime >= cooldown then
                Library:Notify(message)
                lastNotifyTime = now
            end
        end

        local function setupSoundListener(humanoidRootPart)
            local function onChildAdded(child)
                if child:IsA("Sound") and child.SoundId == soundId then
                    safeNotify(notificationMessage)
                    local endedConn = child.Ended:Connect(function()
                        safeNotify(endNotificationMessage)
                        endedConn:Disconnect()
                    end)
                    table.insert(connections, endedConn)
                end
            end

            local conn = humanoidRootPart.ChildAdded:Connect(onChildAdded)
            table.insert(connections, conn)

            for _, child in ipairs(humanoidRootPart:GetChildren()) do
                if child:IsA("Sound") and child.SoundId == soundId then
                    safeNotify(notificationMessage)
                    if child.IsPlaying then
                        local endedConn = child.Ended:Connect(function()
                            safeNotify(endNotificationMessage)
                            endedConn:Disconnect()
                        end)
                        table.insert(connections, endedConn)
                    end
                    break
                end
            end
        end

        local function onKillerAdded(killer)
            local humanoidRootPart = killer:FindFirstChild("HumanoidRootPart") or killer:WaitForChild("HumanoidRootPart", 3)
            if humanoidRootPart then
                setupSoundListener(humanoidRootPart)
            end
        end

        if v then
            local mainConn = workspace.Players.Killers.ChildAdded:Connect(onKillerAdded)
            table.insert(connections, mainConn)
            for _, killer in ipairs(workspace.Players.Killers:GetChildren()) do
                task.spawn(onKillerAdded, killer)
            end
        else
            disconnectAll()
        end
    end
})

local Visual = Tabs.NotificationListen:AddRightGroupbox('其他监听',"bell-ring")

Visual:AddCheckbox("007n7Notify",{
        Text = "007n7分身生成提示",
        Default = false,
        Callback = function(v)
            if v then
                Notify007n7 =
                    workspace.Map.Ingame.DescendantAdded:Connect(
                    function(v)
                        if v.Name == "007n7" then
                            Library:Notify("LightStar-提示\n'007n7分身' 已生成！")
                        end
                    end
                )
            else
                Notify007n7:Disconnect()
            end
        end
})

Visual:AddCheckbox("BuildermanSentryNotify",{
        Text = "哨兵生成提示",
        Default = false,
        Callback = function(v)
            if v then
                NotifyBuildermanSentry =
                    workspace.Map.Ingame.DescendantAdded:Connect(
                    function(v)
                        if v.Name == "BuildermanSentry" then
                            Library:Notify("LightStar-提示\n'哨兵' 已生成！")
                        end
                    end
                )
            else
                NotifyBuildermanSentry:Disconnect()
            end
        end
})

Visual:AddCheckbox("BuildermanDispenserNotify",{
        Text = "分配器生成提示",
        Default = false,
        Callback = function(v)
            if v then
                NotifyBuildermanDispenser =
                    workspace.Map.Ingame.DescendantAdded:Connect(
                    function(v)
                        if v.Name == "BuildermanDispenser" then
                            Library:Notify("LightStar-提示\n'分配器' 已生成！")
                        end
                    end
                )
            else
                NotifyBuildermanDispenser:Disconnect()
            end
        end
})


Visual:AddCheckbox("SubspaceTripmineNotify",{
        Text = "三角炸弹生成提示",
        Default = false,
        Callback = function(v)
            if v then
                NotifySubspaceTripmine =
                    workspace.Map.Ingame.DescendantAdded:Connect(
                    function(v)
                        if v.Name == "SubspaceTripmine" then
                            Library:Notify("LightStar-提示\n'三角炸弹' 已生成！")
                        end
                    end
                )
            else
                NotifySubspaceTripmine:Disconnect()
            end
        end
})

Visual:AddCheckbox("PizzaNotify",{
        Text = "披萨生成提示",
        Default = false,
        Callback = function(v)
            if v then
                NotifyPizza =
                    workspace.Map.Ingame.DescendantAdded:Connect(
                    function(v)
                        if v.Name == "Pizza" then
                            Library:Notify("LightStar-提示\n'披萨' 已生成！")
                        end
                    end
                )
            else
                NotifyPizza:Disconnect()
            end
        end
})

Visual:AddCheckbox("ShadowNotify",{
        Text = "数码足迹提示",
        Default = false,
        Callback = function(v)
            if v then
                NotifyShadows =
                    workspace.Map.Ingame.DescendantAdded:Connect(
                    function(v)
                        if v.Name == "Shadow" then
                            Library:Notify("LightStar-提示\n'数码足迹' 已生成！")
                        end
                    end
                )
            else
                NotifyShadows:Disconnect()
            end
        end
})

Visual:AddCheckbox("EntityKillersNotify",{
        Text = "实体生成提示",
        Default = false,
        Callback = function(v)
            if v then
                NotifyEntityKillers =
                    workspace.DescendantAdded:Connect(
                    function(v)
                        if
                            v:IsA("Model") and 
                                v.Name == "PizzaDeliveryRig" or          
                                v.Name == "Bunny" or 
                                v.Name == "Mafia1" or
                                v.Name == "Mafia2" or
                                v.Name == "Mafia3" or
                                v.Name == "Mafia4"
                         then
                            Library:Notify("LightStar-警告\n实体 '" .. v.Name .. "' 生成了！")
                        elseif v:IsA("Model") and v.Name == "1x1x1x1Zombie" then
                            Library:Notify("LightStar-警告\n实体 '1x1x1x1 (僵尸)' 生成了！")
                        end
                    end
                )
            else
                NotifyEntityKillers:Disconnect()
            end
        end
})

--[
getgenv().Players = game:GetService("Players")
getgenv().RunService = game:GetService("RunService")
getgenv().LocalPlayer = getgenv().Players.LocalPlayer
getgenv().ReplicatedStorage = game:GetService("ReplicatedStorage")
getgenv().buffer = buffer or require(getgenv().ReplicatedStorage.Buffer)
getgenv().RemoteEvent = getgenv().ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("RemoteEvent")
local Plrs = getgenv().Players
local RSvc = getgenv().RunService
local LocalP = getgenv().LocalPlayer
local RS = getgenv().ReplicatedStorage

getgenv().AutoBlockSounds = {
    ["102228729296384"]=true,["140242176732868"]=true,["112809109188560"]=true,
    ["136323728355613"]=true,["115026634746636"]=true,["84116622032112"]=true,
    ["108907358619313"]=true,["127793641088496"]=true,["86174610237192"]=true,
    ["95079963655241"]=true,["101199185291628"]=true,["119942598489800"]=true,
    ["84307400688050"]=true,["113037804008732"]=true,["105200830849301"]=true,
    ["75330693422988"]=true,["82221759983649"]=true,["81702359653578"]=true,
    ["108610718831698"]=true,["112395455254818"]=true,["109431876587852"]=true,
    ["109348678063422"]=true,["85853080745515"]=true,["12222216"]=true,
    ["105840448036441"]=true,["114742322778642"]=true,["119583605486352"]=true,
    ["79980897195554"]=true,["71805956520207"]=true,["79391273191671"]=true,
    ["89004992452376"]=true,["101553872555606"]=true,["101698569375359"]=true,
    ["106300477136129"]=true,["116581754553533"]=true,["117231507259853"]=true,
    ["119089145505438"]=true,["121954639447247"]=true,["125213046326879"]=true,
    ["131406927389838"]=true,["117173212095661"]=true,["104910828105172"]=true,
    ["128856426573270"]=true,["131123355704017"]=true,["80516583309685"]=true,
    ["99829427721752"]=true,["71834552297085"]=true,["75467546215199"]=true,
    ["121369993837377"]=true,["109700476007435"]=true,["89315669689903"]=true,
    ["79222929114377"]=true,["70845653728841"]=true,["107444859834748"]=true,
    ["110372418055226"]=true,["86833981571073"]=true,["86494585504534"]=true,
    ["76959687420003"]=true,["90878551190839"]=true,["77245770579014"]=true,
    ["85810983952228"]=true,["110115912768379"]=true,["94043596324983"]=true
}

getgenv().AutoBlockAnims = {
    ["126830014841198"]=true,["126355327951215"]=true,["121086746534252"]=true,
    ["18885909645"]=true,["98456918873918"]=true,["105458270463374"]=true,
    ["83829782357897"]=true,["125403313786645"]=true,["118298475669935"]=true,
    ["82113744478546"]=true,["70371667919898"]=true,["99135633258223"]=true,
    ["97167027849946"]=true,["109230267448394"]=true,["139835501033932"]=true,
    ["126896426760253"]=true,["109667959938617"]=true,["126681776859538"]=true,
    ["129976080405072"]=true,["121293883585738"]=true,["81639435858902"]=true,
    ["137314737492715"]=true,["92173139187970"]=true,["114506382930939"]=true,
    ["94162446513587"]=true,["93069721274110"]=true,["97433060861952"]=true,
    ["106847695270773"]=true,["120112897026015"]=true,["74707328554358"]=true,
    ["133336594357903"]=true,["86204001129974"]=true,["131543461321709"]=true,
    ["106776364623742"]=true,["114356208094580"]=true,["106538427162796"]=true,
    ["131430497821198"]=true,["100592913030351"]=true,["70447634862911"]=true,
    ["83685305553364"]=true,["126171487400618"]=true,["83251433279852"]=true,
    ["122709416391891"]=true,["87989533095285"]=true,["139309647473555"]=true,
    ["133363345661032"]=true,["128414736976503"]=true,["88451353906104"]=true,
    ["81299297965542"]=true,["99829427721752"]=true,["101031946095087"]=true,
    ["96571077893813"]=true,["109700476007435"]=true,["92645737884601"]=true,
    ["126830014841198"]=true,["121086746534252"]=true,["126355327951215"]=true
}

getgenv().KillersFolder = workspace:WaitForChild("Players"):WaitForChild("Killers")

getgenv().FireBlockRemote = function()
    local args = {"UseActorAbility",{getgenv().buffer.fromstring("\x03\x05\x00\x00\x00Block")}}
    RS:WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
end

getgenv().IsPlayerFacingKiller = function(myRoot,killerRoot)
    if not getgenv().AutoBlockConfig.FacingCheck then return true end
    if not myRoot or not killerRoot then return false end
    local dirToKiller = (killerRoot.Position - myRoot.Position).Unit
    local playerLookDir = myRoot.CFrame.LookVector
    local dotProduct = playerLookDir:Dot(dirToKiller)
    local angleInDegrees = math.deg(math.acos(math.clamp(dotProduct,-1,1)))
    return angleInDegrees <= getgenv().AutoBlockConfig.PlayerFacingAngle
end

getgenv().IsKillerFacingPlayer = function(myRoot,killerRoot)
    if not getgenv().AutoBlockConfig.KillerFacingCheckEnabled then return true end
    if not myRoot or not killerRoot then return false end
    local dirToPlayer = (myRoot.Position - killerRoot.Position).Unit
    local killerLookDir = killerRoot.CFrame.LookVector
    local dotProduct = killerLookDir:Dot(dirToPlayer)
    local angleInDegrees = math.deg(math.acos(math.clamp(dotProduct,-1,1)))
    return angleInDegrees <= getgenv().AutoBlockConfig.KillerFacingAngle
end

getgenv().HasLineOfSight = function(targetRoot)
    if not getgenv().AutoBlockConfig.wallCheckEnabled then return true end
    local myRoot = LocalP.Character and LocalP.Character:FindFirstChild("HumanoidRootPart")
    if not myRoot then return false end
    local rayParams = RaycastParams.new()
    rayParams.FilterType = Enum.RaycastFilterType.Exclude
    rayParams.IgnoreWater = true
    rayParams.FilterDescendantsInstances = {LocalP.Character}
    local origin = myRoot.Position
    local direction = targetRoot.Position - origin
    local result = workspace:Raycast(origin,direction,rayParams)
    return not result or result.Instance:IsDescendantOf(targetRoot.Parent)
end

getgenv().CheckAllBlockConditions = function(myRoot, killerRoot)
    if not myRoot or not killerRoot then return false end
    
    local dvec = killerRoot.Position - myRoot.Position
    local distSq = dvec.X^2 + dvec.Y^2 + dvec.Z^2
    if distSq > getgenv().AutoBlockConfig.SenseRangeSq then return false end
    
    if not getgenv().HasLineOfSight(killerRoot) then return false end
    
    if not getgenv().IsPlayerFacingKiller(myRoot, killerRoot) then return false end
    
    if not getgenv().IsKillerFacingPlayer(myRoot, killerRoot) then return false end
    
    return true
end

getgenv().ExtractSoundId = function(sound)
    if not sound or not sound.SoundId then return nil end
    local sid = tostring(sound.SoundId)
    return sid:match("%d+")
end

getgenv().ExtractAnimId = function(animTrack)
    if not animTrack or not animTrack.Animation then return nil end
    local aid = tostring(animTrack.Animation.AnimationId)
    return aid:match("%d+")
end

getgenv().GetSoundPosition = function(sound)
    if not sound then return nil, nil end
    if sound.Parent and sound.Parent:IsA("BasePart") then
        return sound.Parent.Position, sound.Parent
    end
    if sound.Parent and sound.Parent:IsA("Attachment") and sound.Parent.Parent and sound.Parent.Parent:IsA("BasePart") then
        return sound.Parent.Parent.Position, sound.Parent.Parent
    end
    local found = sound.Parent and sound.Parent:FindFirstChildWhichIsA("BasePart", true)
    return found and found.Position or nil, found or nil
end

getgenv().GetCharacterFromDescendant = function(inst)
    if not inst then return nil end
    local model = inst:FindFirstAncestorOfClass("Model")
    return model and model:FindFirstChildOfClass("Humanoid") and model or nil
end

getgenv().CanBlockKiller = function(killer)
    if not getgenv().AutoBlockConfig.Enabled then return false end
    local myRoot = getgenv().LocalPlayer.Character and getgenv().LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not myRoot then return false end
    local hrp = killer:FindFirstChild("HumanoidRootPart")
    if not hrp then return false end
    return getgenv().CheckAllBlockConditions(myRoot, hrp)
end

getgenv().ProcessSoundAutoBlock = function(sound)
    if not getgenv().AutoBlockConfig.Enabled or not getgenv().AutoBlockConfig.SoundDetectionEnabled then return end
    if not sound or not sound:IsA("Sound") or not sound.IsPlaying then return end
    
    local id = getgenv().ExtractSoundId(sound)
    if not id or not getgenv().AutoBlockSounds[id] then return end
    
    local now = tick()
    
    if getgenv().AutoBlockConfig.IgnoreDelay > 0 then
        if not getgenv().AutoBlockConfig.SoundStartTime[sound] then
            getgenv().AutoBlockConfig.SoundStartTime[sound] = now
        end
        local elapsed = now - getgenv().AutoBlockConfig.SoundStartTime[sound]
        if elapsed < getgenv().AutoBlockConfig.IgnoreDelay then return end
    end
    
    if getgenv().AutoBlockConfig.SoundBlockedUntil[sound] and now < getgenv().AutoBlockConfig.SoundBlockedUntil[sound] then return end
    
    local pos, part = getgenv().GetSoundPosition(sound)
    if not pos or not part then return end
    local char = getgenv().GetCharacterFromDescendant(part)
    local plr = char and getgenv().Players:GetPlayerFromCharacter(char)
    if not plr or plr == getgenv().LocalPlayer then return end
    
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local myRoot = getgenv().LocalPlayer.Character and getgenv().LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not hrp or not myRoot then return end
    
    if getgenv().CheckAllBlockConditions(myRoot, hrp) then
        getgenv().FireBlockRemote()
        getgenv().AutoBlockConfig.SoundBlockedUntil[sound] = now + 1.2
    end
end

getgenv().ProcessAnimAutoBlock = function(animTrack)
    if not getgenv().AutoBlockConfig.Enabled or not getgenv().AutoBlockConfig.AnimDetectionEnabled then return end
    if not animTrack or not animTrack.IsPlaying then return end
    
    local id = getgenv().ExtractAnimId(animTrack)
    if not id or not getgenv().AutoBlockAnims[id] then return end
    
    local now = tick()
    
    if getgenv().AutoBlockConfig.IgnoreDelay > 0 then
        if not getgenv().AutoBlockConfig.AnimStartTime[animTrack] then
            getgenv().AutoBlockConfig.AnimStartTime[animTrack] = now
        end
        local elapsed = now - getgenv().AutoBlockConfig.AnimStartTime[animTrack]
        if elapsed < getgenv().AutoBlockConfig.IgnoreDelay then return end
    end
    
    if getgenv().AutoBlockConfig.AnimBlockedUntil[animTrack] and now < getgenv().AutoBlockConfig.AnimBlockedUntil[animTrack] then return end
    
    local animator = animTrack.Parent
    if not animator or not animator:IsA("Animator") then return end
    local char = getgenv().GetCharacterFromDescendant(animator)
    if not char then return end
    local plr = getgenv().Players:GetPlayerFromCharacter(char)
    if not plr or plr == getgenv().LocalPlayer then return end
    
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local myRoot = getgenv().LocalPlayer.Character and getgenv().LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not hrp or not myRoot then return end
    
    if getgenv().CheckAllBlockConditions(myRoot, hrp) then
        getgenv().FireBlockRemote()
        getgenv().AutoBlockConfig.AnimBlockedUntil[animTrack] = now + 1.2
    end
end

getgenv().HookSound = function(sound)
    if not sound or not sound:IsA("Sound") then return end
    if getgenv().AutoBlockConfig.SoundHooks[sound] then return end
    
    local playConn = sound.Played:Connect(function()
        getgenv().AutoBlockConfig.SoundStartTime[sound] = tick()
        pcall(getgenv().ProcessSoundAutoBlock, sound)
    end)
    
    local propConn = sound:GetPropertyChangedSignal("IsPlaying"):Connect(function()
        if sound.IsPlaying then 
            getgenv().AutoBlockConfig.SoundStartTime[sound] = tick()
            pcall(getgenv().ProcessSoundAutoBlock, sound) 
        else
            getgenv().AutoBlockConfig.SoundStartTime[sound] = nil
        end
    end)
    
    local destroyConn
    destroyConn = sound.Destroying:Connect(function()
        if playConn.Connected then playConn:Disconnect() end
        if propConn.Connected then propConn:Disconnect() end
        if destroyConn.Connected then destroyConn:Disconnect() end
        getgenv().AutoBlockConfig.SoundHooks[sound] = nil
        getgenv().AutoBlockConfig.SoundBlockedUntil[sound] = nil
        getgenv().AutoBlockConfig.SoundStartTime[sound] = nil
    end)
    
    getgenv().AutoBlockConfig.SoundHooks[sound] = {playConn, propConn, destroyConn}
    
    if sound.IsPlaying then
        getgenv().AutoBlockConfig.SoundStartTime[sound] = tick()
        task.spawn(function() pcall(getgenv().ProcessSoundAutoBlock, sound) end)
    end
end

getgenv().HookAnimator = function(animator)
    if not animator or not animator:IsA("Animator") then return end
    if getgenv().AutoBlockConfig.AnimHooks[animator] then return end
    
    local trackConn = animator.AnimationPlayed:Connect(function(animTrack)
        getgenv().AutoBlockConfig.AnimStartTime[animTrack] = tick()
        
        local playedConn = animTrack:GetPropertyChangedSignal("IsPlaying"):Connect(function()
            if animTrack.IsPlaying then
                getgenv().AutoBlockConfig.AnimStartTime[animTrack] = tick()
                pcall(getgenv().ProcessAnimAutoBlock, animTrack)
            else
                getgenv().AutoBlockConfig.AnimStartTime[animTrack] = nil
            end
        end)
        
        local stoppedConn
        stoppedConn = animTrack.Stopped:Connect(function()
            if playedConn.Connected then playedConn:Disconnect() end
            if stoppedConn.Connected then stoppedConn:Disconnect() end
            getgenv().AutoBlockConfig.AnimBlockedUntil[animTrack] = nil
            getgenv().AutoBlockConfig.AnimStartTime[animTrack] = nil
        end)
    end)
    
    local destroyConn
    destroyConn = animator.Destroying:Connect(function()
        if trackConn.Connected then trackConn:Disconnect() end
        if destroyConn.Connected then destroyConn:Disconnect() end
        getgenv().AutoBlockConfig.AnimHooks[animator] = nil
    end)
    
    getgenv().AutoBlockConfig.AnimHooks[animator] = {trackConn, destroyConn}
    
    for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
        getgenv().AutoBlockConfig.AnimStartTime[track] = tick()
        task.spawn(function() pcall(getgenv().ProcessAnimAutoBlock, track) end)
    end
end

getgenv().InitializeHooks = function()
    for _, desc in ipairs(game:GetDescendants()) do
        if desc:IsA("Sound") then 
            pcall(getgenv().HookSound, desc) 
        elseif desc:IsA("Animator") then
            pcall(getgenv().HookAnimator, desc)
        end
    end
    
    game.DescendantAdded:Connect(function(desc)
        if desc:IsA("Sound") then 
            pcall(getgenv().HookSound, desc) 
        elseif desc:IsA("Animator") then
            pcall(getgenv().HookAnimator, desc)
        end
    end)
end

getgenv().CreateDetectionCircle = function(killer)
    if not killer:FindFirstChild("HumanoidRootPart") then return end
    if getgenv().AutoBlockConfig.DetectionCircles[killer] then return end
    
    local hrp = killer.HumanoidRootPart
    local circle = Instance.new("CylinderHandleAdornment")
    circle.Name = "DetectionCircle"
    circle.Adornee = hrp
    circle.Color3 = Color3.fromRGB(255, 0, 0)
    circle.AlwaysOnTop = true
    circle.ZIndex = 0
    circle.Transparency = 0.7
    circle.Radius = getgenv().AutoBlockConfig.SenseRange / 1.5
    circle.Height = 0.1
    circle.CFrame = CFrame.new(0, -2, 0) * CFrame.Angles(math.rad(90), 0, 0)
    circle.Parent = hrp
    
    getgenv().AutoBlockConfig.DetectionCircles[killer] = circle
end

getgenv().RemoveDetectionCircle = function(killer)
    if getgenv().AutoBlockConfig.DetectionCircles[killer] then
        getgenv().AutoBlockConfig.DetectionCircles[killer]:Destroy()
        getgenv().AutoBlockConfig.DetectionCircles[killer] = nil
    end
end

getgenv().UpdateDetectionCircles = function()
    for _, killer in ipairs(getgenv().KillersFolder:GetChildren()) do
        if getgenv().AutoBlockConfig.ShowRadius then
            getgenv().CreateDetectionCircle(killer)
        else
            getgenv().RemoveDetectionCircle(killer)
        end
    end
end

getgenv().AutoBlockConfig = {
    Enabled = false,
    AnimDetectionEnabled = true,
    SoundDetectionEnabled = true,
    SenseRange = 18,
    FacingCheck = false,
    ShowRadius = false,
    IgnoreDelay = 0,
    SenseRangeSq = 18 * 18,
    SoundHooks = {},
    AnimHooks = {},
    SoundBlockedUntil = {},
    AnimBlockedUntil = {},
    SoundStartTime = {},
    AnimStartTime = {},
    DetectionCircles = {},
    PlayerFacingAngle = 90,
    KillerFacingAngle = 90,
    KillerFacingCheckEnabled = false,
    wallCheckEnabled = false
}

local function updateSenseRangeSq()
    getgenv().AutoBlockConfig.SenseRangeSq = getgenv().AutoBlockConfig.SenseRange * getgenv().AutoBlockConfig.SenseRange
end

getgenv().RunService.RenderStepped:Connect(function()
    for killer, circle in pairs(getgenv().AutoBlockConfig.DetectionCircles) do
        if circle and circle.Parent then
            circle.Radius = getgenv().AutoBlockConfig.SenseRange / 1.5
            circle.CFrame = CFrame.new(0, -2, 0) * CFrame.Angles(math.rad(90), 0, 0)
            circle.Color3 = getgenv().CanBlockKiller(killer) and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
        end
    end
end)

getgenv().KillersFolder.ChildAdded:Connect(function(killer)
    task.spawn(function()
        local hrp = killer:WaitForChild("HumanoidRootPart", 5)
        if hrp and getgenv().AutoBlockConfig.ShowRadius then
            getgenv().CreateDetectionCircle(killer)
        end
    end)
end)

getgenv().KillersFolder.ChildRemoved:Connect(function(killer)
    getgenv().RemoveDetectionCircle(killer)
end)

local AutoBlockGroup = Tabs.Block:AddLeftGroupbox("访客自动格挡")

AutoBlockGroup:AddToggle("AutoBlockToggle", {
    Text = "自动格挡",
    Default = false,
    Callback = function(Value)
        getgenv().AutoBlockConfig.Enabled = Value
    end
})

AutoBlockGroup:AddToggle("AutoBlockAnimDetection", {
    Text = "动画检测",
    Default = true,
    Callback = function(Value)
        getgenv().AutoBlockConfig.AnimDetectionEnabled = Value
    end
})

AutoBlockGroup:AddToggle("AutoBlockSoundDetection", {
    Text = "音频检测",
    Default = true,
    Callback = function(Value)
        getgenv().AutoBlockConfig.SoundDetectionEnabled = Value
    end
})

AutoBlockGroup:AddSlider("AutoBlockIgnoreDelay", {
    Text = "忽略延迟 (秒)",
    Default = 0,
    Min = 0,
    Max = 2,
    Rounding = 2,
    Suffix = "s",
    Callback = function(Value)
        getgenv().AutoBlockConfig.IgnoreDelay = Value
    end
})

AutoBlockGroup:AddDivider()

AutoBlockGroup:AddSlider("AutoBlockRange", {
    Text = "感应范围",
    Default = 18,
    Min = 5,
    Max = 50,
    Rounding = 1,
    Callback = function(Value)
        getgenv().AutoBlockConfig.SenseRange = Value
        updateSenseRangeSq()
    end
})

AutoBlockGroup:AddToggle("AutoBlockShowBlockRange", {
    Text = "显示格挡范围圆圈",
    Default = false,
    Callback = function(Value)
        getgenv().AutoBlockConfig.ShowRadius = Value
        getgenv().UpdateDetectionCircles()
    end
})

AutoBlockGroup:AddLabel("绿色 = 可格挡 红色 = 不可格挡")

AutoBlockGroup:AddDivider()

AutoBlockGroup:AddToggle("AutoBlockFacingCheck", {
    Text = "玩家面向检测",
    Default = false,
    Callback = function(Value)
        getgenv().AutoBlockConfig.FacingCheck = Value
    end
})

AutoBlockGroup:AddSlider("AutoBlockPlayerFacingAngle", {
    Text = "玩家面向角度",
    Default = 90,
    Min = 30,
    Max = 180,
    Rounding = 1,
    Tooltip = "玩家面向杀手的角度检测",
    Callback = function(Value)
        getgenv().AutoBlockConfig.PlayerFacingAngle = Value
    end
})

AutoBlockGroup:AddToggle("AutoBlockKillerFacingCheck", {
    Text = "杀手面向检测",
    Default = false,
    Tooltip = "仅在杀手面向玩家时格挡",
    Callback = function(Value)
        getgenv().AutoBlockConfig.KillerFacingCheckEnabled = Value
    end
})

AutoBlockGroup:AddSlider("AutoBlockKillerFacingAngle", {
    Text = "杀手面向角度",
    Default = 90,
    Min = 30,
    Max = 180,
    Rounding = 1,
    Tooltip = "杀手面向玩家的角度检测",
    Callback = function(Value)
        getgenv().AutoBlockConfig.KillerFacingAngle = Value
    end
})

AutoBlockGroup:AddToggle("AutoBlockWallCheck", {
    Text = "墙体检测",
    Default = false,
    Tooltip = "检测是否有墙体遮挡",
    Callback = function(Value)
        getgenv().AutoBlockConfig.wallCheckEnabled = Value
    end,
})

Library.OnUnload = function()
    for killer, _ in pairs(getgenv().AutoBlockConfig.DetectionCircles) do
        getgenv().RemoveDetectionCircle(killer)
    end
    
    for sound, hooks in pairs(getgenv().AutoBlockConfig.SoundHooks) do
        for _, conn in ipairs(hooks) do
            if conn and conn.Connected then 
                pcall(function() conn:Disconnect() end)
            end
        end
    end
    
    for animator, hooks in pairs(getgenv().AutoBlockConfig.AnimHooks) do
        for _, conn in ipairs(hooks) do
            if conn and conn.Connected then 
                pcall(function() conn:Disconnect() end)
            end
        end
    end
end

getgenv().InitializeHooks()

getgenv().Players = game:GetService("Players")
getgenv().RunService = game:GetService("RunService")
getgenv().LocalPlayer = getgenv().Players.LocalPlayer
getgenv().ReplicatedStorage = game:GetService("ReplicatedStorage")
getgenv().buffer = buffer or require(getgenv().ReplicatedStorage.Buffer)
getgenv().RemoteEvent = getgenv().ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("RemoteEvent")
local Plrs = getgenv().Players
local RSvc = getgenv().RunService
local LocalP = getgenv().LocalPlayer
local RS = getgenv().ReplicatedStorage

getgenv().fireRemotePunch = function()
    local args = {"UseActorAbility",{getgenv().buffer.fromstring("\x03\x05\x00\x00\x00Punch")}}
    getgenv().RemoteEvent:FireServer(unpack(args))
end

getgenv().autoPunchOn = false
getgenv().aimbotPunchOn = false
getgenv().punchRange = 50
getgenv().aimbotDelay = 0.1
getgenv().lastAimbotTime = 0
getgenv().KnownKillers = {"c00lkidd","Jason","JohnDoe","1x1x1x1","Noli","Slasher","Sixer","Nosferatu"}
getgenv().CachedGui = getgenv().LocalPlayer:WaitForChild("PlayerGui")
getgenv().CachedPunchBtn = nil
getgenv().CachedCharges = nil
getgenv().CachedBlockBtn = nil
getgenv().CachedCooldown = nil
getgenv().HDPullEnabled = false
getgenv().HDSpeed = 12
getgenv().pulling = false
getgenv().punchAnimIds = {
    "108911997126897","82137285150006","129843313690921",
    "140703210927645","136007065400978","86096387000557",
    "87259391926321","86709774283672","108807732150251",
    "138040001965654"
}
getgenv().killerNames = {"c00lkidd","Jason","JohnDoe","1x1x1x1","Noli","Slasher"}
getgenv().autoFallPunchOn = false
getgenv().autoDashEnabled = false
getgenv().DASH_SPEED = 100
getgenv().MIN_TARGET_MAXHP = 300
getgenv().KillersFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Killers")

getgenv().DoHDPull = function(targetPos)
    if getgenv().pulling then return end
    local hrp = LocalP.Character and LocalP.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then getgenv().pulling = false return end
    local bv = Instance.new("BodyVelocity")
    bv.MaxForce = Vector3.new(40000,0,40000)
    bv.Velocity = Vector3.zero
    bv.Parent = hrp
    local conn = RSvc.Heartbeat:Connect(function()
        if not bv.Parent then conn:Disconnect() getgenv().pulling = false return end
        local vec = targetPos - hrp.Position
        if vec.Magnitude < 5 then bv:Destroy() conn:Disconnect() getgenv().pulling = false return end
        bv.Velocity = vec.Unit * (getgenv().HDSpeed * 20)
    end)
    task.delay(0.5,function()
        if bv and bv.Parent then bv:Destroy() end
        if conn then conn:Disconnect() end
        getgenv().pulling = false
    end)
end

getgenv().getClosestKiller = function()
    local myChar = getgenv().LocalPlayer.Character
    local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
    if not myRoot or not getgenv().KillersFolder then return nil end
    local closest,closestDist = nil,math.huge
    for _,name in ipairs(getgenv().KnownKillers) do
        local killer = getgenv().KillersFolder:FindFirstChild(name)
        if killer and killer:FindFirstChild("HumanoidRootPart") then
            local root = killer.HumanoidRootPart
            local dist = (root.Position - myRoot.Position).Magnitude
            if dist < closestDist and dist <= getgenv().punchRange then
                closest = killer
                closestDist = dist
            end
        end
    end
    return closest
end

getgenv().RefreshUI = function()
    getgenv().CachedGui = getgenv().LocalPlayer:FindFirstChild("PlayerGui") or getgenv().CachedGui
    local mainUI = getgenv().CachedGui and getgenv().CachedGui:FindFirstChild("MainUI")
    if mainUI then
        local abilityContainer = mainUI:FindFirstChild("AbilityContainer")
        getgenv().CachedPunchBtn = abilityContainer and abilityContainer:FindFirstChild("Punch")
        getgenv().CachedCharges = getgenv().CachedPunchBtn and getgenv().CachedPunchBtn:FindFirstChild("Charges")
    else
        getgenv().CachedPunchBtn,getgenv().CachedCharges = nil,nil
    end
end
getgenv().RefreshUI()
if getgenv().CachedGui then
    getgenv().CachedGui.ChildAdded:Connect(function(child)
        if child.Name == "MainUI" then task.delay(0.02,getgenv().RefreshUI) end
    end)
end
getgenv().LocalPlayer.CharacterAdded:Connect(function() task.delay(0.5,getgenv().RefreshUI) end)

if not getgenv().originalNamecall then
    getgenv().HookRules = {}
    getgenv().originalNamecall = hookmetamethod(game, "__namecall", function(self, ...)
        local method = getnamecallmethod()
        local args = {...}
        if method == "FireServer" then
            for _, rule in ipairs(getgenv().HookRules) do
                if (not rule.remoteName or self.Name == rule.remoteName) then
                    if not rule.blockedFirstArg or args[1] == rule.blockedFirstArg then
                        if rule.block then return end
                    end
                end
            end
        end
        return getgenv().originalNamecall(self, ...)
    end)
end
getgenv().activateRemoteHook = function(remoteName, blockedFirstArg)
    for _, rule in ipairs(getgenv().HookRules) do
        if rule.remoteName == remoteName and rule.blockedFirstArg == blockedFirstArg then return end
    end
    table.insert(getgenv().HookRules, {remoteName = remoteName, blockedFirstArg = blockedFirstArg, block = true})
end
getgenv().deactivateRemoteHook = function(remoteName, blockedFirstArg)
    for i, rule in ipairs(getgenv().HookRules) do
        if rule.remoteName == remoteName and rule.blockedFirstArg == blockedFirstArg then
            table.remove(getgenv().HookRules, i)
            break
        end
    end
end

local function validTarget(player)
    if not player or player == getgenv().LocalPlayer then return false end
    local char = player.Character
    if not char then return false end
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not humanoid or not hrp or humanoid.Health <= 0 then return false end
    if humanoid.MaxHealth < getgenv().MIN_TARGET_MAXHP then return false end
    local myChar = getgenv().LocalPlayer.Character
    local myHrp = myChar and myChar:FindFirstChild("HumanoidRootPart")
    if not myHrp then return false end
    return (hrp.Position - myHrp.Position).Magnitude <= getgenv().punchRange
end
local function findClosestValidTarget()
    local best, bestDist = nil, math.huge
    local myChar = getgenv().LocalPlayer.Character
    local myHrp = myChar and myChar:FindFirstChild("HumanoidRootPart")
    if not myHrp then return nil end
    for _, p in pairs(getgenv().Players:GetPlayers()) do
        if validTarget(p) then
            local targetHrp = p.Character:FindFirstChild("HumanoidRootPart")
            local d = (targetHrp.Position - myHrp.Position).Magnitude
            if d < bestDist then
                bestDist = d
                best = p
            end
        end
    end
    return best
end

local function isPunchAnimationPlaying()
    local char = getgenv().LocalPlayer.Character
    if not char then return false end
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if not humanoid then return false end
    local trackList = humanoid:GetPlayingAnimationTracks()
    for _, track in ipairs(trackList) do
        local animId = tostring(track.Animation.AnimationId)
        for _, id in ipairs(getgenv().punchAnimIds) do
            if animId == "rbxassetid://" .. id then return true end
        end
    end
    return false
end

getgenv().RunService.RenderStepped:Connect(function()
    if not getgenv().autoPunchOn and not getgenv().aimbotPunchOn then return end
    local myChar = getgenv().LocalPlayer.Character
    local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
    local gui = getgenv().CachedGui:FindFirstChild("MainUI")
    local punchBtn = gui and gui:FindFirstChild("AbilityContainer") and gui.AbilityContainer:FindFirstChild("Punch")
    local charges = punchBtn and punchBtn:FindFirstChild("Charges")
    if punchBtn and charges and myRoot then
        local chargeCount = tonumber(charges.Text) or 0
        if chargeCount >= 1 then
            local killer = getgenv().getClosestKiller()
            if killer and killer:FindFirstChild("HumanoidRootPart") then
                if getgenv().aimbotPunchOn then
                    local currentTime = tick()
                    if currentTime - getgenv().lastAimbotTime >= getgenv().aimbotDelay then
                        local killerRoot = killer.HumanoidRootPart
                        local camera = workspace.CurrentCamera
                        camera.CFrame = CFrame.new(camera.CFrame.Position,killerRoot.Position)
                        getgenv().fireRemotePunch()
                        getgenv().lastAimbotTime = currentTime
                    end
                elseif getgenv().autoPunchOn then
                    getgenv().fireRemotePunch()
                end
            end
        end
    end
end)

getgenv().RunService.Heartbeat:Connect(function()
    local myChar = getgenv().LocalPlayer.Character
    local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
    local gui = getgenv().LocalPlayer.PlayerGui:FindFirstChild("MainUI")
    local punchBtn = gui and gui:FindFirstChild("AbilityContainer") and gui.AbilityContainer:FindFirstChild("Punch")
    local charges = punchBtn and punchBtn:FindFirstChild("Charges")
    
    -- 空中连拳
    if getgenv().autoFallPunchOn and punchBtn and charges and myRoot and getgenv().KillersFolder then
        local chargeCount = tonumber(charges.Text) or 0
        if chargeCount >= 1 then
            for _, name in ipairs(getgenv().killerNames) do
                local killer = getgenv().KillersFolder:FindFirstChild(name)
                if killer and killer:FindFirstChild("HumanoidRootPart") then
                    local root = killer.HumanoidRootPart
                    if (root.Position - myRoot.Position).Magnitude <= getgenv().punchRange then
                        myRoot.CFrame = myRoot.CFrame + Vector3.new(0, 8, 0)
                        getgenv().fireRemotePunch()
                        task.wait(0.01)
                    end
                end
            end
        end
    end
    
    
    if not getgenv().autoDashEnabled then return end
    local char = getgenv().LocalPlayer.Character
    if not char or char.Name ~= "Guest1337" then return end
    if not isPunchAnimationPlaying() then return end
    local rootPart = char:FindFirstChild("HumanoidRootPart")
    if not rootPart then return end
    local target = findClosestValidTarget()
    if target and target.Character then
        local tgtHrp = target.Character:FindFirstChild("HumanoidRootPart")
        if tgtHrp then
            local dir = (tgtHrp.Position - rootPart.Position)
            local horiz = Vector3.new(dir.X, 0, dir.Z)
            local dist = horiz.Magnitude
            if dist > 3 then
                local unit = horiz.Unit
                local vel = unit * getgenv().DASH_SPEED
                local currentY = rootPart.AssemblyLinearVelocity.Y
                rootPart.AssemblyLinearVelocity = Vector3.new(vel.X, currentY, vel.Z)
            end
        end
    end
end)

local CombatGroup = Tabs.Block:AddRightGroupbox('拳击')

CombatGroup:AddToggle("AutoPunch", {
    Text = "自动拳击",
    Default = false,
    Tooltip = "自动检测范围内的敌人并拳击",
    Callback = function(Value)
        getgenv().autoPunchOn = Value
    end
})

CombatGroup:AddToggle("AimbotPunch", {
    Text = "自瞄拳击",
    Default = false,
    Tooltip = "自动对准目标进行拳击",
    Callback = function(Value)
        getgenv().aimbotPunchOn = Value
    end
})

CombatGroup:AddSlider("PunchRange", {
    Text = "拳击范围",
    Default = 50,
    Min = 10,
    Max = 100,
    Rounding = 1,
    Tooltip = "拳击检测距离",
    Callback = function(Value)
        getgenv().punchRange = Value
    end
})

CombatGroup:AddSlider("AimbotDelay", {
    Text = "自瞄拳击间隔",
    Default = 0.1,
    Min = 0.01,
    Max = 1,
    Rounding = 2,
    Tooltip = "自瞄拳击之间的延迟时间（秒）",
    Callback = function(Value)
        getgenv().aimbotDelay = Value
    end
})

CombatGroup:AddToggle("AutoFallPunch", {
    Text = "空中连拳",
    Default = false,
    Tooltip = "在空中自动触发拳击",
    Callback = function(Value)
        getgenv().autoFallPunchOn = Value
    end
})

local AdvancedGroup = Tabs.Block:AddRightGroupbox('高级')

AdvancedGroup:AddToggle("HDPullToggle", {
    Text = "格挡拉近（HDPull）",
    Default = false,
    Tooltip = "向目标拉近",
    Callback = function(Value)
        getgenv().HDPullEnabled = Value
    end
})

AdvancedGroup:AddSlider("HDSpeed", {
    Text = "拉近速度",
    Default = 12,
    Min = 5,
    Max = 50,
    Rounding = 1,
    Tooltip = "向目标移动的速度",
    Callback = function(Value)
        getgenv().HDSpeed = Value
    end
})

AdvancedGroup:AddToggle("AutoDash", {
    Text = "自动冲向",
    Default = false,
    Tooltip = "拳击时自动向敌人冲刺",
    Callback = function(Value)
        getgenv().autoDashEnabled = Value
    end
})

AdvancedGroup:AddSlider("DashSpeed", {
    Text = "冲向速度",
    Default = 100,
    Min = 50,
    Max = 500,
    Rounding = 1,
    Tooltip = "自动冲刺时的速度",
    Callback = function(Value)
        getgenv().DASH_SPEED = Value
    end
})

--]]

--[[
local ZZ = Tabs.Main:AddLeftGroupbox('自动狂暴[杰森]')

local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local savedRange = lp:FindFirstChild("RagingPaceRange")
local replicatedStorage = game:GetService("ReplicatedStorage")
local Network = replicatedStorage:WaitForChild("Modules"):WaitForChild("Network")
if not savedRange then
    savedRange = Instance.new("NumberValue")
    savedRange.Name = "RagingPaceRange"
    savedRange.Value = 19
    savedRange.Parent = lp
end

ZZ:AddToggle("JasonAutoRagingPace", {
    Text = "自动狂暴",
    Default = false,
    Callback = function(enabled)
        local threadId = tostring(math.random(1, 99999))
        _G.RagingPaceThreadId = threadId
        
        local function shouldContinue()
            return _G.RagingPaceThreadId == threadId and enabled
        end
        
        local RunService = game:GetService("RunService")
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local RANGE = savedRange.Value
        local SPAM_DURATION = 3
        local COOLDOWN_TIME = 5
        local activeCooldowns = {}

        local animsToDetect = {
            ["116618003477002"] = true,
            ["119462383658044"] = true,
            ["131696603025265"] = true,
            ["121255898612475"] = true,
            ["133491532453922"] = true,
            ["103601716322988"] = true,
            ["86371356500204"] = true,
            ["72722244508749"] = true,
            ["87259391926321"] = true,
            ["96959123077498"] = true,
        }

        local function fireRagingPace()
            local args = {
                "UseActorAbility",
                {
                    buffer.fromstring("\"RagingPace\"")
                }
            }
            ReplicatedStorage:WaitForChild("Modules")
                :WaitForChild("Network")
                :WaitForChild("RemoteEvent")
                :FireServer(unpack(args))
        end

        local function isAnimationMatching(anim)
            local id = tostring(anim.Animation and anim.Animation.AnimationId or "")
            local numId = id:match("%d+")
            return animsToDetect[numId] or false
        end

        local function runDetection()
            local connection
            connection = RunService.Heartbeat:Connect(function()
                if not shouldContinue() then
                    connection:Disconnect()
                    return
                end
                
                for _, player in ipairs(Players:GetPlayers()) do
                    if not shouldContinue() then break end
                    
                    if player ~= lp and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        local targetHRP = player.Character.HumanoidRootPart
                        local myChar = lp.Character
                        if myChar and myChar:FindFirstChild("HumanoidRootPart") then
                            local dist = (targetHRP.Position - myChar.HumanoidRootPart.Position).Magnitude
                            if dist <= RANGE and (not activeCooldowns[player] or tick() - activeCooldowns[player] >= COOLDOWN_TIME) then
                                local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                                if humanoid then
                                    for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
                                        if not shouldContinue() then break end
                                        
                                        if isAnimationMatching(track) then
                                            activeCooldowns[player] = tick()
                                            task.spawn(function()
                                                local startTime = tick()
                                                while shouldContinue() and tick() - startTime < SPAM_DURATION do
                                                    fireRagingPace()
                                                    task.wait(0.05)
                                                end
                                            end)
                                            break
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end)
            
            return connection
        end

        if enabled then
            if _G.RagingPaceConnection then
                _G.RagingPaceConnection:Disconnect()
                _G.RagingPaceConnection = nil
            end
            
            _G.RagingPaceConnection = runDetection()
        else
            if _G.RagingPaceConnection then
                _G.RagingPaceConnection:Disconnect()
                _G.RagingPaceConnection = nil
            end
        end
    end
})

ZZ:AddSlider("JasonAutoRagingPaceRange", {
    Text = "狂暴触发距离",
    Default = savedRange.Value,
    Min = 1,
    Max = 50,
    Rounding = 0,
    Compact = true,
    Callback = function(value)
        savedRange.Value = value
    end
})
--]]

local MainTabbox = Tabs.Main:AddLeftTabbox()
local Lighting = MainTabbox:AddTab("亮度","sun")

Lighting:AddSlider("BrightnessValue",{
    Text = "亮度数值",
    Min = 0,
    Default = 0,
    Max = 3,
    Rounding = 1,
    Compact = true,
    Callback = function(v)
        _env.Brightness = v
    end
})

Lighting:AddToggle("NoGlobalShadows",{
    Text = "无阴影",
    Default = false,
    Callback = function(v)
        _env.GlobalShadows = v
    end
})

Lighting:AddToggle("NoFog",{
    Text = "除雾",
    Default = false,
    Callback = function(v)
        _env.NoFog = v
    end
})

Lighting:AddDivider()

Lighting:AddCheckbox("启用功能",{
    Text = "启用",
    Default = false,
    Callback = function(v)
        _env.Fullbright = v
        game:GetService("RunService").RenderStepped:Connect(function()
            if not game.Lighting:GetAttribute("FogStart") then 
                game.Lighting:SetAttribute("FogStart", game.Lighting.FogStart) 
            end
            if not game.Lighting:GetAttribute("FogEnd") then 
                game.Lighting:SetAttribute("FogEnd", game.Lighting.FogEnd) 
            end
            game.Lighting.FogStart = _env.NoFog and 0 or game.Lighting:GetAttribute("FogStart")
            game.Lighting.FogEnd = _env.NoFog and math.huge or game.Lighting:GetAttribute("FogEnd")
            
            local fog = game.Lighting:FindFirstChildOfClass("Atmosphere")
            if fog then
                if not fog:GetAttribute("Density") then 
                    fog:SetAttribute("Density", fog.Density) 
                end
                fog.Density = _env.NoFog and 0 or fog:GetAttribute("Density")
            end
            
            if _env.Fullbright then
                game.Lighting.OutdoorAmbient = Color3.new(1,1,1)
                game.Lighting.Brightness = _env.Brightness or 0
                game.Lighting.GlobalShadows = not _env.GlobalShadows
            else
                game.Lighting.OutdoorAmbient = Color3.fromRGB(55,55,55)
                game.Lighting.Brightness = 0
                game.Lighting.GlobalShadows = true
            end
        end)
    end
})

local Camera = MainTabbox:AddTab("相机","camera")

Camera:AddToggle('FreeZoom', {
    Text = "自由缩放",
    Callback = function(state)
        localPlayer.CameraMaxZoomDistance = state and math.huge or 12
    end
})

Camera:AddToggle('CameraNoclip', {
    Text = "相机穿墙",
    Callback = function(state)
        localPlayer.DevCameraOcclusionMode = Enum.DevCameraOcclusionMode[state and "Invisicam" or "Zoom"]
    end
})

Camera:AddToggle("SpectateKiller", {
    Text = "旁观杀手",
    Default = false,
    Callback = function (state)
        if state then
            local killer = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Killers") and workspace.Players.Killers:GetChildren()[1]
            if killer then
                workspace.CurrentCamera.CameraSubject = killer
            end
        else
            pcall(function()
                workspace.CurrentCamera.CameraSubject = localPlayer.Character
            end)
        end
    end
})

Camera:AddSlider("PlayerFieldOfView",{
    Text = "视野调节",
    Min = 70,
    Default = workspace.Camera.FieldOfView,
    Max = 120,
    Rounding = 1,
    Compact = true,
    Callback = function(v)
        if game.Players.LocalPlayer:FindFirstChild("PlayerData") then
            if game.Players.LocalPlayer.PlayerData:FindFirstChild("Settings") and game.Players.LocalPlayer.PlayerData.Settings:FindFirstChild("Game") then
                if game.Players.LocalPlayer.PlayerData.Settings.Game:FindFirstChild("FieldOfView") then
                    game.Players.LocalPlayer.PlayerData.Settings.Game:FindFirstChild("FieldOfView").Value = v
                end
            end
        end
    end
})

local ZZ = Tabs.Main:AddLeftGroupbox("聊天可视化","message-square-text")

ZZ:AddToggle('AlwaysShowChat', {
        Text = "显示聊天框",
        Callback = function(state)
            if state then
                _G.showChat = true
                task.spawn(function()
                    while _G.showChat and task.wait() do                        game:GetService("TextChatService"):FindFirstChildOfClass("ChatWindowConfiguration").Enabled = true
                    end
                end)
            else
                _G.showChat = false
                if playingState ~= "Spectating" then                   game:GetService("TextChatService"):FindFirstChildOfClass("ChatWindowConfiguration").Enabled = false
                end
            end
        end
})

--[
local But = Tabs.Main:AddLeftGroupbox("按钮")

But:AddButton({
    Text = "低画质",
    Func = function()
            loadstring(game:HttpGet('https://raw.githubusercontent.com/vexroxd/My-Script-/main/roblox%20fps%20unlocker%20script.lua'))()
   end
})

But:AddButton({
    Text = "<font color=\"rgb(0, 0, 255)\">欺骗伪造用户模式</font>",
    Tooltip = "拍视频和直播时点击它 你的信息 的 昵称 和 用户名 改变了!!!可以让别人挂不了你 相当于欺骗!",
    Func = function()
local HttpService = game:GetService("HttpService")
local players = game:GetService('Players')

if not getgenv().Config then
    getgenv().Config = {
        Headless = false,
        FakeDisplayName = "c00lkidd",
        FakeName = "c00lkidd",
        FakeId = 39348582,
    }
end

local lp = players.LocalPlayer
local oldUserId = tostring(lp.UserId)
local oldName = lp.Name
local oldDisplayName = lp.DisplayName

local function fatty(len)
    local charset = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
    local s = ""
    for i = 1, len do
        local rand = math.random(1, #charset)
        s = s .. charset:sub(rand, rand)
    end
    return s
end

local Gay = {}

for _, player in ipairs(players:GetPlayers()) do
    game:GetService("Players").LocalPlayer.NameDisplayDistance = 1
    if player ~= lp then
        local fake = fatty(#player.DisplayName)
        Gay[player.Name] = fatty(#player.Name)
        Gay[player.DisplayName] = fake

        pcall(function()
            player.DisplayName = fake
        end)
    end
end

task.spawn(function()
    while task.wait() do
        players.LocalPlayer.NameDisplayDistance = 0
        players.LocalPlayer.NameDisplayDistance = 1
    end
end)

players.PlayerAdded:Connect(function(player)
    if player ~= lp then
        player.CharacterAdded:Connect(function()
            local fake = fatty(#player.DisplayName)
            Gay[player.Name] = fatty(#player.Name)
            Gay[player.DisplayName] = fake

            pcall(function()
                player.DisplayName = fake
            end)
        end)
    end
end)

local function processtext(text)
    if not text or type(text) ~= "string" then
        return ""
    end

    text = text:gsub(oldName, Config.FakeName)
    text = text:gsub(oldUserId, tostring(Config.FakeId))
    text = text:gsub(oldDisplayName, Config.FakeDisplayName)

    for realName, fakeName in pairs(Gay) do
        text = text:gsub(realName, fakeName)
    end

    return text
end

for i,v in next, game:GetDescendants() do
    if v:IsA("TextBox") or v:IsA("TextLabel") or v:IsA("TextButton") then
        v.Text = processtext(v.Text)
        v.Name = processtext(v.Name)
        v.Changed:Connect(function(property)
            v.Text = processtext(v.Text)
            v.Name = processtext(v.Name)
        end)
    end
end

game.DescendantAdded:Connect(function(descendant)
    if descendant:IsA("TextBox") or descendant:IsA("TextLabel") or descendant:IsA("TextButton") then
        descendant.Text = processtext(descendant.Text)
        descendant.Name = processtext(descendant.Name)
        descendant.Changed:Connect(function()
            descendant.Text = processtext(descendant.Text)
            descendant.Name = processtext(descendant.Name)
        end)
    end
end)

lp.DisplayName = Config.FakeDisplayName
lp.CharacterAppearanceId = Config.FakeId

if Config.Headless == true then
    task.spawn(function()
        while task.wait() do
            local char = lp.Character or lp.CharacterAdded:Wait()
            if char:FindFirstChild("Head") then
                char.Head.Transparency = 1
                local decal = char.Head:FindFirstChildOfClass("Decal")
                if decal then
                    decal:Destroy()
                   end
               end
           end
       end)
   end
end
})

But:AddButton({
    Text = "访客假格挡",
    Tooltip = "骗杀手技能🤫😈杀手当场吓哭😭",
    Func = function()
local player = game:GetService("Players").LocalPlayer
local UserInputService = game:GetService("UserInputService")
local PlayerGui = player:WaitForChild("PlayerGui")

local function createButton()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "ParryScreenGui"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = PlayerGui

    local button = Instance.new("TextButton")
    button.Name = "FakeParryButton"
    button.Text = "假格挡"
    button.Size = UDim2.new(0, 150, 0, 50)
    button.Position = UDim2.new(0.5, -75, 0.8, -25)
    button.BackgroundColor3 = Color3.new(1, 0, 0)
    button.TextColor3 = Color3.new(1, 1, 1)
    button.TextScaled = true
    button.Parent = screenGui

    return button
end

local button = createButton()

local animationTrack

local function loadAnim()
    local char = player.Character or player.CharacterAdded:Wait()
    local hum = char:WaitForChild("Humanoid")
    local anim = Instance.new("Animation")
    anim.AnimationId = "rbxassetid://72722244508749"
    animationTrack = hum:LoadAnimation(anim)
    animationTrack.Looped = false
end

loadAnim()
player.CharacterAdded:Connect(loadAnim)

local isPlaying = false
local isHolding = false
local canDrag = false
local dragStart = Vector2.new()
local startPos = UDim2.new()

button.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        isHolding = true
        dragStart = input.Position
        startPos = button.Position
        
        task.wait(0.3)
        
        if isHolding then
            canDrag = true
        end
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if canDrag and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        button.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        isHolding = false
        canDrag = false
    end
end)

button.MouseButton1Click:Connect(function()
    if canDrag or isPlaying then return end

    isPlaying = true
    button.BackgroundColor3 = Color3.new(0, 1, 0)

    animationTrack:Play()
    animationTrack.Stopped:Wait()

    button.BackgroundColor3 = Color3.new(1, 0, 0)
    isPlaying = false
  end)
end
})
--]]

local ZZ = Tabs.Main:AddLeftGroupbox('物品','shopping-basket')

ZZ:AddCheckbox("ItemsAura", {
    Text = "物品光环",
    Default = false,
    Callback = function (call)
        _G.pickUpNear = call
        task.spawn(function()
            while _G.pickUpNear and task.wait() do
                pcall(function()
                    if isKiller then return end
                    local items = {}
                    if workspace:FindFirstChild("Map") and gameMap:FindFirstChild("Ingame") then
                        for _, v in pairs(gameMap.Ingame:GetChildren()) do
                            if v:IsA("Tool") and v:FindFirstChild("ItemRoot") then
                                table.insert(items, v.ItemRoot)
                            end
                        end
                        for _, v in pairs(gameMap.Ingame.Map:GetChildren()) do
                            if v:IsA("Tool") and v:FindFirstChild("ItemRoot") then
                                table.insert(items, v.ItemRoot)
                            end
                        end
                    end
                    for _, itemRoot in pairs(items) do
                        local lp = localPlayer
                        if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
                            local magnitude = (lp.Character.HumanoidRootPart.Position - itemRoot.Position).Magnitude
                            if magnitude <= 10 then
                                if itemRoot:FindFirstChild("ProximityPrompt") then
                                    fireproximityprompt(itemRoot.ProximityPrompt)
                                end
                            end
                        end
                    end
                end)
            end
        end)
    end
})

ZZ:AddButton({
    Text = "传送物品",
    Func = function()
        pcall(function()
            if isKiller then return end
            local items = {}
            if workspace:FindFirstChild("Map") and gameMap:FindFirstChild("Ingame") then
                for _, v in pairs(gameMap.Ingame:GetDescendants()) do
                    if v:IsA("Tool") and v:FindFirstChild("ItemRoot") then
                        table.insert(items, v.ItemRoot)
                    end
                end
            end
            for _, itemRoot in pairs(items) do
                local toolName = itemRoot.Parent and itemRoot.Parent.Name
                if toolName and not localPlayer.Backpack:FindFirstChild(toolName) then
                    localPlayer.Character.HumanoidRootPart.CFrame = itemRoot.CFrame
                    task.wait(0.5)
                    if itemRoot:FindFirstChild("ProximityPrompt") then
                        fireproximityprompt(itemRoot.ProximityPrompt)
                    end
                end
            end
        end)
    end
})

local Time = Tabs.Main:AddRightGroupbox("时间","clock-3")

-- 先记录原始位置（只在脚本首次加载时读取一次）
local originalPosition = nil

Time:AddSlider("TimeLocationX", {
    Text = "时间位置X偏移调节",
    Min = 0,
    Max = 1,
    Default = 0.5,
    Compact = true,
    Rounding = 3,
    Callback = function(v)
        _env.TimeLocationX = v
    end
})

_env.TimeLocationX = 0.5

Time:AddCheckbox("EnableTimePosition", {
    Text = "启用时间位置",
    Callback = function(enabled)
        _env.EnableTimePosition = enabled

        if enabled then
            -- 开启时：先记录原始位置，然后开始实时修改
            task.spawn(function()
                local lp = game.Players.LocalPlayer
                local pg = lp.PlayerGui
                if not pg then return end

                local RoundTimer = pg:FindFirstChild("RoundTimer")
                if not RoundTimer then return end

                local Main = RoundTimer:FindFirstChild("Main")
                if Main and Main:IsA("GuiObject") then
                    -- 首次开启时，记录原始位置
                    if not originalPosition then
                        originalPosition = Main.Position
                    end
                end

                while _env.EnableTimePosition do
                    if Main and Main:IsA("GuiObject") then
                        Main.Position = UDim2.new(
                            _env.TimeLocationX,
                            Main.Position.X.Offset,
                            Main.Position.Y.Scale,
                            Main.Position.Y.Offset
                        )
                    end
                    task.wait()
                end
            end)
        else
            -- 关闭时：恢复到原始位置
            task.spawn(function()
                local lp = game.Players.LocalPlayer
                local pg = lp.PlayerGui
                if not pg then return end

                local RoundTimer = pg:FindFirstChild("RoundTimer")
                if not RoundTimer then return end

                local Main = RoundTimer:FindFirstChild("Main")
                if Main and Main:IsA("GuiObject") and originalPosition then
                    Main.Position = originalPosition
                end
            end)
        end
    end
})

local KillerSurvival = Tabs.Main:AddRightGroupbox("玩家移动","move")

game.Players.LocalPlayer.Character.Humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
    if _env.NoStun == true and game.Players.LocalPlayer.Character.Humanoid.WalkSpeed < 16 then
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
    end
end)

game.Players.LocalPlayer.CharacterAdded:Connect(function()
    game.Players.LocalPlayer.Character.Humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
        if _env.NoStun == true and game.Players.LocalPlayer.Character.Humanoid.WalkSpeed < 16 then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
        end
    end)
end)

KillerSurvival:AddCheckbox("AlwaysSprint", {
    Text = "一直保持奔跑状态",
    Default = false,
    Callback = function (call)
        _G.alwaysSprint = call
        task.spawn(function()
            while _G.alwaysSprint and task.wait() do
                local sprint = require(game:GetService("ReplicatedStorage").Systems.Character.Game.Sprinting)
                if not sprint.IsSprinting then
                    sprint.IsSprinting = true
                    sprint.__sprintedEvent:Fire(true)
                end
            end
        end)
    end
})

KillerSurvival:AddDivider()

KillerSurvival:AddSlider("SpeedBoostValue",{
    Text = "速度调节",
    Min = 0, Max = 3,
    Default = 1, 
    Compact = true,
    Rounding = 1,
    Callback = function(v)
        _env.SpeedBoostValue = v
    end
})

_env.SpeedBoostValue = 1

KillerSurvival:AddToggle("EnableSpeedBoost",{
    Text = "启用速度",
    Callback = function(v)
        _env.SpeedBoost = v
        while _env.SpeedBoost do
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame += game.Players.LocalPlayer.Character.Humanoid.MoveDirection * _env.SpeedBoostValue
            game.Players.LocalPlayer.Character.HumanoidRootPart.CanCollide = true
            task.wait()
        end
    end
})

KillerSurvival:AddToggle('AllowJump', {
    Text = '启用跳跃',
    Default = false,
    Callback = function(value)
        restoringJump = value        
      Library:Notify("LightStar-警告\n反复跳跃会踢你 因为游戏会认为你正在飞行！",9)
        if value then
            task.spawn(function()
                while restoringJump do
                    local player = game:GetService("Players").LocalPlayer
                    local char = player.Character or player.CharacterAdded:Wait()
                    local humanoid = char:FindFirstChildOfClass("Humanoid")
                    local jumpBtn = player:FindFirstChild("PlayerGui") and player.PlayerGui:FindFirstChild("TouchGui") and player.PlayerGui.TouchGui:FindFirstChild("TouchControlFrame") and player.PlayerGui.TouchGui.TouchControlFrame:FindFirstChild("JumpButton")

                    if humanoid then
                        humanoid.JumpPower = 50
                    end

                    if jumpBtn then
                        jumpBtn.Visible = true
                    end

                    task.wait(1) 
                end
            end)
        else
            local player = game:GetService("Players").LocalPlayer
            local char = player.Character
            local humanoid = char and char:FindFirstChildOfClass("Humanoid")
            local jumpBtn = player:FindFirstChild("PlayerGui") and player.PlayerGui:FindFirstChild("TouchGui") and player.PlayerGui.TouchGui:FindFirstChild("TouchControlFrame") and player.PlayerGui.TouchGui.TouchControlFrame:FindFirstChild("JumpButton")

            if humanoid then
                humanoid.JumpPower = 0
            end

            if jumpBtn then
                jumpBtn.Visible = false
            end
        end
    end
})

local cachedParts = {}
function enableNoclip()
    if localPlayer.Character then
        for _, v in pairs(localPlayer.Character.GetChildren(localPlayer.Character)) do
            if v:IsA("BasePart") then
                cachedParts[v] = v
                v.CanCollide = false
            end
        end
    end
end
function disableNoclip()
    for _, v in pairs(cachedParts) do
        v.CanCollide = true
    end
end

KillerSurvival:AddToggle("EnableNoclip", {
    Text = "启用穿墙",
    Default = false,
    Callback = function (s)
        _G.noclipState = s
        task.spawn(function ()
            while task.wait() do
                if not _G.noclipState then
                    disableNoclip()
                    break
                end

                enableNoclip()
            end
        end)
    end
}):AddKeyPicker("KeyPicker", {
    Default = "N",
    SyncToggleState = true,
    Mode = "Toggle", 
    Text = "穿墙",
    NoUI = false,  
})

--[[
local AutoChanceCoinFlip = Tabs.Main:AddRightGroupbox('自动Chance硬币')

_G.auto_coin = false
_G.coin_delay = 2

AutoChanceCoinFlip:AddSlider("AutoChanceCoinFlipmew",{
    Text = "#秒抛1次硬币",
    Min = 1,
    Default = 2, 
    Max = 15,  
    Rounding = 1,
    Callback = function(val)
        _G.coin_delay = val
    end
})

AutoChanceCoinFlip:AddToggle("AutoChanceCoinFlip", {
    Text = "自动Chance抛硬币",
    Default = false,
    Callback = function(cool)
        _G.auto_coin = cool
    end
})

task.spawn(function()
    while true do
        if _G.auto_coin then
            Network:FireServer("UseActorAbility", {buffer.fromstring("\"CoinFlip\"")})
        end
        task.wait(_G.coin_delay)
    end
end)
--]]

local SM = Tabs.FightingKilling:AddLeftGroupbox('杀戮功能[杀手]')

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")

local silentAimEnabled = false
local targetPlayer = nil
local maxDistance = 100
local silentAimConnection = nil

local function isKiller()
    local killersFolder = Workspace:FindFirstChild("Players") and Workspace.Players:FindFirstChild("Killers")
    if killersFolder and LocalPlayer.Character and table.find(killersFolder:GetChildren(), LocalPlayer.Character) then
        return true
    end
    return false
end

local function getClosestSurvivor()
    local survivorsFolder = Workspace:FindFirstChild("Players") and Workspace.Players:FindFirstChild("Survivors")
    if not survivorsFolder then return nil end

    local myChar = LocalPlayer.Character
    if not myChar or not myChar:FindFirstChild("HumanoidRootPart") then return nil end
    local myPos = myChar.HumanoidRootPart.Position

    local closest = nil
    local shortest = math.huge

    for _, model in ipairs(survivorsFolder:GetChildren()) do
        if model:IsA("Model") and model:FindFirstChild("HumanoidRootPart") then
            local dist = (model.HumanoidRootPart.Position - myPos).Magnitude
            if dist < shortest and dist <= maxDistance then
                shortest = dist
                closest = model
            end
        end
    end

    return closest
end

local function faceTarget(model)
    if not model or not model:FindFirstChild("HumanoidRootPart") then return end
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end

    local root = char.HumanoidRootPart
    local targetPos = model.HumanoidRootPart.Position
    local look = CFrame.new(root.Position, Vector3.new(targetPos.X, root.Position.Y, targetPos.Z))
    root.CFrame = look
end

getgenv().GetSilentAimTargetPosition = function()
    if silentAimEnabled and isKiller() then
        local target = getClosestSurvivor()
        if target and target:FindFirstChild("Head") then
            return target.Head.Position
        end
    end
    return nil
end

SM:AddToggle("KillerSilentAimbot", {
    Text = "静默瞄准",
    Callback = function(state)
        silentAimEnabled = state
       
        if state then
            if not silentAimConnection then
                silentAimConnection = RunService.Heartbeat:Connect(function()
                    if not isKiller() then return end
                    targetPlayer = getClosestSurvivor()
                    if targetPlayer then
                        faceTarget(targetPlayer)
                    end
                end)
            end
        else
   
            if silentAimConnection then
                silentAimConnection:Disconnect()
                silentAimConnection = nil
            end
            targetPlayer = nil
        end
    end
})

-- 创建全局连接管理表
if not _G.HitboxTracking then
    _G.HitboxTracking = {
        Connection = nil,
        Active = false
    }
end

SM:AddToggle("HitboxTrackingToggle", {
    Text = "吸附杀戮光环",
    Tooltip = "启用/禁用命中框追踪",
    Default = false,
    Disabled = false,
    Visible = true,
    Risky = false,

    Callback = function(state)
        -- 关闭功能
        if not state then
            if _G.HitboxTracking.Connection then
                _G.HitboxTracking.Connection:Disconnect()
                _G.HitboxTracking.Connection = nil
            end
            _G.HitboxTracking.Active = false
            return
        end

        -- 确保游戏加载完成
        repeat task.wait() until game:IsLoaded()

        -- 初始化服务
        local Players = game:GetService('Players')
        local RunService = game:GetService('RunService')
        local Player = Players.LocalPlayer

        -- 初始化角色部件
        local Character = Player.Character or Player.CharacterAdded:Wait()
        local Humanoid = Character:WaitForChild("Humanoid")
        local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

        -- 角色变化处理
        Player.CharacterAdded:Connect(function(NewCharacter)
            Character = NewCharacter
            Humanoid = Character:WaitForChild("Humanoid")
            HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
        end)

local AttackAnimations = {
        'rbxassetid://131430497821198',
        'rbxassetid://83829782357897',
        'rbxassetid://126830014841198',
        'rbxassetid://126355327951215',
        'rbxassetid://121086746534252',
        'rbxassetid://105458270463374',
        'rbxassetid://18885919947',
        'rbxassetid://18885909645',
        'rbxassetid://87259391926321',
        'rbxassetid://106014898528300',
        'rbxassetid://86545133269813',
        'rbxassetid://89448354637442',
        'rbxassetid://90499469533503',
        'rbxassetid://116618003477002',
        'rbxassetid://106086955212611',
        'rbxassetid://107640065977686',
        'rbxassetid://77124578197357',
        'rbxassetid://101771617803133',
        'rbxassetid://134958187822107',
        'rbxassetid://111313169447787',
        'rbxassetid://71685573690338',
        'rbxassetid://129843313690921',
        'rbxassetid://97623143664485',
        'rbxassetid://136007065400978',
        'rbxassetid://86096387000557',
        'rbxassetid://108807732150251',
        'rbxassetid://138040001965654',
        'rbxassetid://73502073176819',
        'rbxassetid://86709774283672',
        'rbxassetid://140703210927645',
        'rbxassetid://96173857867228',
        'rbxassetid://121255898612475',
        'rbxassetid://98031287364865',
        'rbxassetid://119462383658044',
        'rbxassetid://77448521277146',
        'rbxassetid://103741352379819',
        'rbxassetid://131696603025265',
        'rbxassetid://122503338277352',
        'rbxassetid://97648548303678',
        'rbxassetid://94162446513587',
        'rbxassetid://84426150435898',
        'rbxassetid://93069721274110',
        'rbxassetid://114620047310688',
        'rbxassetid://97433060861952',
        'rbxassetid://82183356141401',
        'rbxassetid://100592913030351',
        'rbxassetid://121293883585738',
        'rbxassetid://70447634862911',
        'rbxassetid://92173139187970',
        'rbxassetid://106847695270773',
        'rbxassetid://125403313786645',
        'rbxassetid://81639435858902',
        'rbxassetid://137314737492715',
        'rbxassetid://120112897026015',
        'rbxassetid://82113744478546',
        'rbxassetid://118298475669935',
        'rbxassetid://126681776859538',
        'rbxassetid://129976080405072',
        'rbxassetid://109667959938617',
        'rbxassetid://74707328554358',
        'rbxassetid://133336594357903',
        'rbxassetid://86204001129974',
        'rbxassetid://124243639579224',
        'rbxassetid://70371667919898',
        'rbxassetid://131543461321709',
        'rbxassetid://136323728355613',
        'rbxassetid://109230267448394',
        'rbxassetid://139835501033932',
        'rbxassetid://106538427162796',
        'rbxassetid://81803417290685',
        'rbxassetid://110400453990786',
        'rbxassetid://83685305553364',
        'rbxassetid://126171487400618',
        'rbxassetid://122709416391891',
        'rbxassetid://87989533095285',
        'rbxassetid://119326397274934',
        'rbxassetid://140365014326125',
        'rbxassetid://139309647473555',
        'rbxassetid://133363345661032',
        'rbxassetid://128414736976503',
        'rbxassetid://121808371053483',
        'rbxassetid://88451353906104',
        'rbxassetid://81299297965542',
        'rbxassetid://99829427721752',
        'rbxassetid://126896426760253',
        'rbxassetid://77375846492436',
        'rbxassetid://94634594529334',
        'rbxassetid://101031946095087',
        'rbxassetid://94958041603347',
        'rbxassetid://110702884830060',
        'rbxassetid://131642454238375',
        'rbxassetid://126830014841198',
        'rbxassetid://91509234639766',
        'rbxassetid://126654961540956',
        'rbxassetid://106860049270347',
        'rbxassetid://126727756047566',
        'rbxassetid://70483423693126'
};
        local RNG = Random.new()

        -- 清除旧连接
        if _G.HitboxTracking.Connection then
            _G.HitboxTracking.Connection:Disconnect()
        end

        -- 标记为活动状态
        _G.HitboxTracking.Active = true

        -- 创建新连接
        _G.HitboxTracking.Connection = RunService.Heartbeat:Connect(function()
            -- 双重活动检查
            if not _G.HitboxTracking.Active then return end
            if not HumanoidRootPart or not HumanoidRootPart:IsDescendantOf(workspace) then return end

            -- 攻击动画检测
            local isAttacking = false
            for _, track in pairs(Humanoid:GetPlayingAnimationTracks()) do
                if track.Animation and table.find(AttackAnimations, track.Animation.AnimationId) then
                    if (track.TimePosition / track.Length) < 0.75 then
                        isAttacking = true
                        break
                    end
                end
            end

            if not isAttacking then return end

            -- 目标查找
            local target, nearestDist = nil, 12

            local function findTargets(targets)
                for _, entity in pairs(targets) do
                    if entity == Character or not entity:FindFirstChild("HumanoidRootPart") then
                        continue
                    end

                    local distance = (entity.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude
                    if distance < nearestDist then
                        nearestDist = distance
                        target = entity
                    end
                end
            end

            -- 检查玩家
            if workspace:FindFirstChild("Players") then
                findTargets(workspace.Players:GetDescendants())
            end
            
            -- 检查NPC
            local npcsFolder = workspace.Map:FindFirstChild("NPCs", true)
            if npcsFolder then
                findTargets(npcsFolder:GetChildren())
            end

            if not target then return end

            -- 计算移动向量
            local ping = Player:GetNetworkPing()
            local randomOffset = Vector3.new(
                RNG:NextNumber(-1.5, 1.5),
                0,
                RNG:NextNumber(-1.5, 1.5)
            )
            
            local requiredVelocity = (target.HumanoidRootPart.Position + randomOffset + 
                                    (target.HumanoidRootPart.Velocity * (ping * 1.25)) - 
                                    HumanoidRootPart.Position) / (ping * 2)

            -- 应用移动
            local originalVelocity = HumanoidRootPart.Velocity
            HumanoidRootPart.Velocity = requiredVelocity
            task.wait()
            HumanoidRootPart.Velocity = originalVelocity
        end)
    end
})



local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer
local playerName = player.Name
local hitbox = nil
local updateConnection = nil

local hitboxesFolder = Workspace:FindFirstChild("Hitboxes")
if not hitboxesFolder then
    hitboxesFolder = Instance.new("Folder")
    hitboxesFolder.Name = "Hitboxes"
    hitboxesFolder.Parent = Workspace
end

local function createHitbox()
    local part = Instance.new("Part")
    part.Name = playerName .. "_Hitbox"
    part.Size = Vector3.new(4, 7, 4)
    part.Anchored = true
    part.CanCollide = false
    part.Transparency = 0.5
    part.Material = Enum.Material.ForceField
    part.Color = Color3.fromRGB(255, 255, 200)
    part.Parent = hitboxesFolder
    return part
end

local function updateHitbox()
    local character = player.Character
    if character and character:FindFirstChild("HumanoidRootPart") and hitbox then
        local root = character.HumanoidRootPart
        local offset = root.CFrame.LookVector * 4
        hitbox.CFrame = CFrame.new(root.Position + offset, root.Position + root.CFrame.LookVector)
    end
end

SM:AddToggle("ShowHitbox", {
    Text = "显示碰撞箱",
    Default = false,
    Callback = function(state)
        if state then
       
            hitbox = createHitbox()
            updateConnection = RunService.RenderStepped:Connect(updateHitbox)
         
            player.CharacterAdded:Connect(function(char)
                task.wait(1)
                if hitbox then
                    hitbox:Destroy()
                end
                hitbox = createHitbox()
            end)
        else
            
            if updateConnection then
                updateConnection:Disconnect()
                updateConnection = nil
            end
            if hitbox then
                hitbox:Destroy()
                hitbox = nil
            end
        end
    end
})

-- 【核心修复】用一个表集中管理所有配置和大数组，只占用1个局部变量名额
local HitboxConfig = {
    -- 阵营列表（从大量局部变量合并为表）
    Killers = {
        ["Slasher"] = true, ["1x1x1x1"] = true, ["c00lkidd"] = true,
        ["Noli"] = true, ["JohnDoe"] = true, ["Guest 666"] = true,
        ["Sixer"] = true
    },
    Survivors = {
        ["Noob"] = true, ["Guest1337"] = true, ["Elliot"] = true,
        ["Shedletsky"] = true, ["TwoTime"] = true, ["007n7"] = true,
        ["Chance"] = true, ["Builderman"] = true, ["Taph"] = true,
        ["Dusekkar"] = true, ["Veeronica"] = true
    },
    -- 攻击动画（合并为表，避免大量局部变量）
    AttackAnimations = {
        'rbxassetid://131430497821198',
        'rbxassetid://83829782357897',
        'rbxassetid://126830014841198',
        'rbxassetid://126355327951215',
        'rbxassetid://121086746534252',
        'rbxassetid://105458270463374',
        'rbxassetid://18885919947',
        'rbxassetid://18885909645',
        'rbxassetid://87259391926321',
        'rbxassetid://106014898528300',
        'rbxassetid://86545133269813',
        'rbxassetid://89448354637442',
        'rbxassetid://90499469533503',
        'rbxassetid://116618003477002',
        'rbxassetid://106086955212611',
        'rbxassetid://107640065977686',
        'rbxassetid://77124578197357',
        'rbxassetid://101771617803133',
        'rbxassetid://134958187822107',
        'rbxassetid://111313169447787',
        'rbxassetid://71685573690338',
        'rbxassetid://129843313690921',
        'rbxassetid://97623143664485',
        'rbxassetid://136007065400978',
        'rbxassetid://86096387000557',
        'rbxassetid://108807732150251',
        'rbxassetid://138040001965654',
        'rbxassetid://73502073176819',
        'rbxassetid://86709774283672',
        'rbxassetid://140703210927645',
        'rbxassetid://96173857867228',
        'rbxassetid://121255898612475',
        'rbxassetid://98031287364865',
        'rbxassetid://119462383658044',
        'rbxassetid://77448521277146',
        'rbxassetid://103741352379819',
        'rbxassetid://131696603025265',
        'rbxassetid://122503338277352',
        'rbxassetid://97648548303678',
        'rbxassetid://94162446513587',
        'rbxassetid://84426150435898',
        'rbxassetid://93069721274110',
        'rbxassetid://114620047310688',
        'rbxassetid://97433060861952',
        'rbxassetid://82183356141401',
        'rbxassetid://100592913030351',
        'rbxassetid://121293883585738',
        'rbxassetid://70447634862911',
        'rbxassetid://92173139187970',
        'rbxassetid://106847695270773',
        'rbxassetid://125403313786645',
        'rbxassetid://81639435858902',
        'rbxassetid://137314737492715',
        'rbxassetid://120112897026015',
        'rbxassetid://82113744478546',
        'rbxassetid://118298475669935',
        'rbxassetid://126681776859538',
        'rbxassetid://129976080405072',
        'rbxassetid://109667959938617',
        'rbxassetid://74707328554358',
        'rbxassetid://133336594357903',
        'rbxassetid://86204001129974',
        'rbxassetid://124243639579224',
        'rbxassetid://70371667919898',
        'rbxassetid://131543461321709',
        'rbxassetid://136323728355613',
        'rbxassetid://109230267448394',
        'rbxassetid://139835501033932',
        'rbxassetid://106538427162796',
        'rbxassetid://81803417290685',
        'rbxassetid://110400453990786',
        'rbxassetid://83685305553364',
        'rbxassetid://126171487400618',
        'rbxassetid://122709416391891',
        'rbxassetid://87989533095285',
        'rbxassetid://119326397274934',
        'rbxassetid://140365014326125',
        'rbxassetid://139309647473555',
        'rbxassetid://133363345661032',
        'rbxassetid://128414736976503',
        'rbxassetid://121808371053483',
        'rbxassetid://88451353906104',
        'rbxassetid://81299297965542',
        'rbxassetid://99829427721752',
        'rbxassetid://126896426760253',
        'rbxassetid://77375846492436',
        'rbxassetid://94634594529334',
        'rbxassetid://101031946095087',
        'rbxassetid://94958041603347',
        'rbxassetid://110702884830060',
        'rbxassetid://131642454238375',
        'rbxassetid://126830014841198',
        'rbxassetid://91509234639766',
        'rbxassetid://126654961540956',
        'rbxassetid://106860049270347',
        'rbxassetid://126727756047566',
        'rbxassetid://70483423693126'
    },
    -- 追踪设置
    MaxDistance = 120,
    FilterSurvivors = false,
    FilterKillers = false,
    WallCheckEnabled = false,
    HitboxTrackingEnabled = false,
    HeartbeatConnection = nil
}

-- 【修复】拆分大函数，把逻辑拆成独立小函数，减少单个作用域的局部变量
local function isTargetVisible(targetCharacter, localHRP, wallCheck)
    if not wallCheck or not targetCharacter or not targetCharacter:FindFirstChild("HumanoidRootPart") then
        return true
    end
    
    local targetHRP = targetCharacter.HumanoidRootPart
    local origin = localHRP.Position
    local direction = (targetHRP.Position - origin).Unit
    local distance = (targetHRP.Position - origin).Magnitude
    
    local rayParams = RaycastParams.new()
    rayParams.FilterType = Enum.RaycastFilterType.Blacklist
    rayParams.FilterDescendantsInstances = {game.Players.LocalPlayer.Character, targetCharacter}
    rayParams.IgnoreWater = true
    
    local rayResult = workspace:Raycast(origin, direction * distance, rayParams)
    return not rayResult or rayResult.Instance:IsDescendantOf(targetCharacter)
end

local function getCharacterRole(character, config)
    local modelName = character.Name
    if config.Killers[modelName] then return "Killer" end
    if config.Survivors[modelName] then return "Survivor" end
    return "Unknown"
end

local function findOppositeTarget(oppTable, localHRP, maxDist, wallCheck, config)
    local nearestTarget = nil
    local nearestDist = maxDist
    
    local function scanFolder(folder)
        for _,v in pairs(folder:GetDescendants()) do
            if not v:IsA("Model") or v == game.Players.LocalPlayer.Character then continue end
            local hrp = v:FindFirstChild("HumanoidRootPart")
            if not hrp or not v:FindFirstChild("Humanoid") then continue end
            if wallCheck and not isTargetVisible(v, localHRP, wallCheck) then continue end
            
            -- 【全程生效过滤】这里加上过滤，对立目标也会被过滤
            local role = getCharacterRole(v, config)
            if config.FilterSurvivors and role == "Survivor" then continue end
            if config.FilterKillers and role == "Killer" then continue end
            
            if oppTable[role] then
                local dist = (hrp.Position - localHRP.Position).Magnitude
                if dist < nearestDist then
                    nearestDist = dist
                    nearestTarget = v
                end
            end
        end
    end
    
    scanFolder(workspace.Players)
    local npcs = workspace.Map:FindFirstChild("NPCs", true)
    if npcs then scanFolder(npcs) end
    
    return nearestTarget
end

local function startTracking(config, ui)
    if config.HeartbeatConnection then
        config.HeartbeatConnection:Disconnect()
        config.HeartbeatConnection = nil
    end
    
    repeat task.wait() until game:IsLoaded()
    local player = game.Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local humanoid = char:WaitForChild("Humanoid")
    local hrp = char:WaitForChild("HumanoidRootPart")
    local rng = Random.new()
    
    player.CharacterAdded:Connect(function(newChar)
        char = newChar
        humanoid = char:WaitForChild("Humanoid")
        hrp = char:WaitForChild("HumanoidRootPart")
    end)
    
    config.HeartbeatConnection = game:GetService("RunService").Heartbeat:Connect(function()
        if not config.HitboxTrackingEnabled or not hrp then return end
        
        -- 检查攻击动画
        local isAttacking = false
        for _,track in pairs(humanoid:GetPlayingAnimationTracks()) do
            if table.find(config.AttackAnimations, track.Animation.AnimationId) and (track.TimePosition / track.Length < 0.75) then
                isAttacking = true
                break
            end
        end
        if not isAttacking then return end
        
        -- 找对立阵营目标
        local selfRole = getCharacterRole(char, config)
        local oppTable = selfRole == "Killer" and config.Survivors or selfRole == "Survivor" and config.Killers or nil
        local target = oppTable and findOppositeTarget(oppTable, hrp, config.MaxDistance, config.WallCheckEnabled, config)
        
        if not target then
            -- 备选：找所有符合过滤条件的目标
            local nearest = nil
            local nearestDist = config.MaxDistance
            local function scanAll(folder)
                for _,v in pairs(folder:GetDescendants()) do
                    if not v:IsA("Model") or v == char then continue end
                    local targetHRP = v:FindFirstChild("HumanoidRootPart")
                    if not targetHRP or not v:FindFirstChild("Humanoid") then continue end
                    if config.WallCheckEnabled and not isTargetVisible(v, hrp, config.WallCheckEnabled) then continue end
                    
                    local role = getCharacterRole(v, config)
                    if (config.FilterSurvivors and role == "Survivor") or (config.FilterKillers and role == "Killer") then continue end
                    if (selfRole == "Killer" and role == "Killer") or (selfRole == "Survivor" and role == "Survivor") then continue end
                    
                    local dist = (targetHRP.Position - hrp.Position).Magnitude
                    if dist < nearestDist then
                        nearestDist = dist
                        nearest = v
                    end
                end
            end
            scanAll(workspace.Players)
            local npcs = workspace.Map:FindFirstChild("NPCs", true)
            if npcs then scanAll(npcs) end
            target = nearest
        end
        
        if not target then return end
        
        -- 执行追踪
        local oldVel = hrp.Velocity
        local targetHRP = target.HumanoidRootPart
        local ping = player:GetNetworkPing()
        local neededVel = (
            targetHRP.Position + Vector3.new(rng:NextNumber(-1.5,1.5), 0, rng:NextNumber(-1.5,1.5))
            + (targetHRP.Velocity * (ping * 1.25))
            - hrp.Position
        ) / (ping * 2)
        
        hrp.Velocity = neededVel
        game:GetService("RunService").RenderStepped:Wait()
        hrp.Velocity = oldVel
    end)
end

local function stopTracking(config)
    if config.HeartbeatConnection then
        config.HeartbeatConnection:Disconnect()
        config.HeartbeatConnection = nil
    end
    config.HitboxTrackingEnabled = false
end

-- 【UI部分】只负责设置配置，不包含复杂逻辑
local SM = Tabs.FightingKilling:AddLeftGroupbox('自调Hitbox追踪')

SM:AddSlider("DistanceSlider", {
    Text = "追踪范围",
    Default = 120,
    Min = 1,
    Max = 300,
    Rounding = 0,
    Callback = function(value) 
    HitboxConfig.MaxDistance = value 
  end
})

SM:AddToggle("FilterSurvivorsToggle", {
    Text = "过滤[不追踪]幸存者",
    Default = false,
    Callback = function(state) 
    HitboxConfig.FilterSurvivors = state 
  end
})

SM:AddToggle("FilterKillersToggle", {
    Text = "过滤[不追踪]杀手",
    Default = false,
    Callback = function(state) 
    HitboxConfig.FilterKillers = state 
  end
})

SM:AddCheckbox("WallCheck", {
    Text = "墙壁检测",
    Default = false,
    Callback = function(state) 
HitboxConfig.WallCheckEnabled = state 
  end
})

SM:AddCheckbox("HitboxTracking", {
    Text = "Hitbox追踪",
    Default = false,
    Callback = function(state)
        HitboxConfig.HitboxTrackingEnabled = state
        if state then
            startTracking(HitboxConfig, SM)
        else
            stopTracking(HitboxConfig)
        end
    end
})

--[[
local SM = Tabs.FightingKilling:AddLeftGroupbox('自调碰撞箱追踪')

SM:AddLabel("<b><font color=\"rgb(0, 0, 255)\">[注意]</font></b> 每1局要开1次")

SM:AddSlider("DistanceSlider", {
    Text = "距离范围",
    Tooltip = "调整自动攻击的最大距离",
    Default = 8,
    Min = 1,
    Max = 120,
    Rounding = 0,
    Compact = false,
    Callback = function(value)
        MaxDistance = value
    end
})

SM:AddToggle("InfiniteJumpToggle", {
    Text = "自调追踪",
    Default = false,
    Disabled = false,
    Visible = true,
    Risky = false,

    Callback = function(state)
        repeat task.wait() until game:IsLoaded();

        local Players = game:GetService('Players');
        local Player = Players.LocalPlayer;
        local PlayerGui = Player:WaitForChild("PlayerGui");
        local Character = Player.Character or Player.CharacterAdded:Wait();
        local Humanoid = Character:WaitForChild("Humanoid");
        local Animator = Humanoid:WaitForChild("Animator");
        local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart");

        Player.CharacterAdded:Connect(function(NewCharacter)
            Character = NewCharacter;
            Humanoid = Character:WaitForChild("Humanoid");
            Animator = Humanoid:WaitForChild("Animator");
            HumanoidRootPart = Character:WaitForChild("HumanoidRootPart");
        end);

local AttackAnimations = {
	'rbxassetid://131430497821198', --// MassInfection, 1x1x1x1
	'rbxassetid://83829782357897', --// Slash, 1x1x1x1
	'rbxassetid://126830014841198', --// Slash, Jason
	'rbxassetid://126355327951215', --// Behead, Jason
	'rbxassetid://121086746534252', --// GashingWoundStart, Jason
	'rbxassetid://105458270463374', --// Slash, JohnDoe
	'rbxassetid://127172483138092', --// CorruptEnergy, JohnDoe
	'rbxassetid://18885919947', --// CorruptNature, c00lkidd
	'rbxassetid://18885909645', --// Attack, c00lkidd
	'rbxassetid://87259391926321', --// ParryPunch, Guest1337
	'rbxassetid://106014898528300', --// Charge, Guest1337
	'rbxassetid://87259391926321', --// Punch, Guest1337
	'rbxassetid://86545133269813', --// Stab, TwoTime
	'rbxassetid://89448354637442', --// LungeStart, TwoTime
	'rbxassetid://90499469533503', --// GunFire, Chance
	'rbxassetid://116618003477002', --// Slash, Shedletsky
	'rbxassetid://106086955212611', --// Stab, TwoTime, Skin: PhilosopherTwotime
	'rbxassetid://107640065977686', --// LungeStart, TwoTime, Skin: PhilosopherTwotime
	'rbxassetid://77124578197357', --// GunFire, Chance, Skin: OutlawChance
	'rbxassetid://101771617803133', --// GunFire, Chance, Skin: #CassidyChance
	'rbxassetid://134958187822107', --// GunFire, Chance, Skin: RetroChance
	'rbxassetid://111313169447787', --// GunFire, Chance, Skin: MLGChance
	'rbxassetid://71685573690338', --// GunFire, Chance, Skin: Milestone100Chance
	'rbxassetid://71685573690338', --// GunFire, Chance, Skin: Milestone75Chance
	'rbxassetid://129843313690921', --// ParryPunch, Guest1337, Skin: #NerfedDemomanGuest
	'rbxassetid://97623143664485', --// Charge, Guest1337, Skin: #NerfedDemomanGuest
	'rbxassetid://129843313690921', --// Punch, Guest1337, Skin: #NerfedDemomanGuest
	'rbxassetid://136007065400978', --// ParryPunch, Guest1337, Skin: LittleBrotherGuest
	'rbxassetid://136007065400978', --// Punch, Guest1337, Skin: LittleBrotherGuest
	'rbxassetid://86096387000557', --// ParryPunch, Guest1337, Skin: Milestone100Guest
	'rbxassetid://86096387000557', --// ParryPunch, Guest1337, Skin: Milestone75Guest
	'rbxassetid://108807732150251', --// ParryPunch, Guest1337, Skin: GreenbeltGuest
	'rbxassetid://138040001965654', --// Punch, Guest1337, Skin: GreenbeltGuest
	'rbxassetid://73502073176819', --// Charge, Guest1337, Skin: GreenbeltGuest
	'rbxassetid://129843313690921', --// ParryPunch, Guest1337, Skin: #DemomanGuest
	'rbxassetid://97623143664485', --// Charge, Guest1337, Skin: #DemomanGuest
	'rbxassetid://129843313690921', --// Punch, Guest1337, Skin: #DemomanGuest
	'rbxassetid://97623143664485', --// Charge, Guest1337, Skin: GunnerGuest
	'rbxassetid://97623143664485', --// Charge, Guest1337, Skin: BobbyGuest
	'rbxassetid://97623143664485', --// Charge, Guest1337, Skin: !JuggernautGuest
	'rbxassetid://86709774283672', --// ParryPunch, Guest1337, Skin: SorcererGuest
	'rbxassetid://106014898528300', --// Charge, Guest1337, Skin: SorcererGuest
	'rbxassetid://87259391926321', --// Punch, Guest1337, Skin: SorcererGuest
	'rbxassetid://140703210927645', --// ParryPunch, Guest1337, Skin: DragonGuest
	'rbxassetid://96173857867228', --// Charge, Guest1337, Skin: AllyGuest
	'rbxassetid://121255898612475', --// Slash, Shedletsky, Skin: RetroShedletsky
	'rbxassetid://98031287364865', --// Slash, Shedletsky, Skin: BrightEyesShedletsky
	'rbxassetid://119462383658044', --// Slash, Shedletsky, Skin: NessShedletsky
	'rbxassetid://77448521277146', --// Slash, Shedletsky, Skin: Milestone100Shedletsky
	'rbxassetid://77448521277146', --// Slash, Shedletsky, Skin: Milestone75Shedletsky
	'rbxassetid://103741352379819', --// Slash, Shedletsky, Skin: #RolandShedletsky
	'rbxassetid://119462383658044', --// Slash, Shedletsky, Skin: HeartbrokenShedletsky
	'rbxassetid://131696603025265', --// Slash, Shedletsky, Skin: JamesSunderlandShedletsky
	'rbxassetid://122503338277352', --// Slash, Shedletsky, Skin: SkiesShedletsky
	'rbxassetid://97648548303678', --// Slash, Shedletsky, Skin: #JohnWardShedletsky
	'rbxassetid://94162446513587', --// Slash, JohnDoe, Skin: !Joner
	'rbxassetid://84426150435898', --// CorruptEnergy, JohnDoe, Skin: !Joner
	'rbxassetid://93069721274110', --// Slash, JohnDoe, Skin: AnnihilationJohnDoe
	'rbxassetid://114620047310688', --// CorruptEnergy, JohnDoe, Skin: AnnihilationJohnDoe
	'rbxassetid://97433060861952', --// Slash, JohnDoe, Skin: #SK
	'rbxassetid://82183356141401', --// CorruptEnergy, JohnDoe, Skin: #SK
	'rbxassetid://100592913030351', --// MassInfection, 1x1x1x1, Skin: Fleskhjerta1x1x1x1
	'rbxassetid://121293883585738', --// Slash, 1x1x1x1, Skin: Fleskhjerta1x1x1x1
	'rbxassetid://100592913030351', --// MassInfection, 1x1x1x1, Skin: AceOfSpades1x1x1x1
	'rbxassetid://121293883585738', --// Slash, 1x1x1x1, Skin: AceOfSpades1x1x1x1
	'rbxassetid://100592913030351', --// MassInfection, 1x1x1x1, Skin: Lancer1x1x1x1
	'rbxassetid://121293883585738', --// Slash, 1x1x1x1, Skin: Lancer1x1x1x1
	'rbxassetid://70447634862911', --// MassInfection, 1x1x1x1, Skin: Hacklord1x1x1x1
	'rbxassetid://92173139187970', --// Slash, 1x1x1x1, Skin: Hacklord1x1x1x1
	'rbxassetid://106847695270773', --// GashingWoundStart, Jason, Skin: Subject0Jason
	'rbxassetid://125403313786645', --// Slash, Jason, Skin: Subject0Jason
	'rbxassetid://81639435858902', --// Behead, Jason, Skin: WhitePumpkinJason
	'rbxassetid://137314737492715', --// GashingWoundStart, Jason, Skin: WhitePumpkinJason
	'rbxassetid://120112897026015', --// Slash, Jason, Skin: WhitePumpkinJason
	'rbxassetid://82113744478546', --// Behead, Jason, Skin: KillerKyleJason
	'rbxassetid://118298475669935', --// Slash, Jason, Skin: KillerKyleJason
	'rbxassetid://82113744478546', --// Behead, Jason, Skin: #SmartestJason
	'rbxassetid://118298475669935', --// Slash, Jason, Skin: #SmartestJason
	'rbxassetid://126681776859538', --// Behead, Jason, Skin: PursuerJason
	'rbxassetid://129976080405072', --// GashingWoundStart, Jason, Skin: PursuerJason
	'rbxassetid://109667959938617', --// Slash, Jason, Skin: PursuerJason
	'rbxassetid://74707328554358', --// Slash, Jason, Skin: #DeadRabbitsJason
	'rbxassetid://133336594357903', --// Behead, Jason, Skin: #DeadRabbitsJason
	'rbxassetid://86204001129974', --// GashingWoundStart, Jason, Skin: #DeadRabbitsJason
	'rbxassetid://82113744478546', --// Behead, Jason, Skin: RetroJason
	'rbxassetid://118298475669935', --// Slash, Jason, Skin: RetroJason
	'rbxassetid://124243639579224', --// CorruptNature, c00lkidd, Skin: MafiosoC00l
	'rbxassetid://70371667919898', --// Attack, c00lkidd, Skin: MafiosoC00l
	'rbxassetid://131543461321709', --// Attack, c00lkidd, Skin: SaviorC00l
	'rbxassetid://136323728355613', --// Swing, Noli
    'rbxassetid://109230267448394', --// Swing, Noli, Skin: Devesto
    'rbxassetid://109230267448394', --// Swing, Noli, Skin: Yourself
    'rbxassetid://109230267448394', --// Swing, Noli, Skin: YAAI
    'rbxassetid://109230267448394', --// Swing, Noli, Skin: Toolbox
    'rbxassetid://109230267448394', --// Swing, Noli, Skin: ASPX
    'rbxassetid://109230267448394', --// Swing, Noli, Skin: RedRoomCurse
    'rbxassetid://109230267448394', --// Swing, Noli, Skin: Saggitial
    'rbxassetid://109230267448394', --// Swing, Noli, Skin: Quimera
    'rbxassetid://109230267448394', --// Swing, Noli, Skin: 035
    'rbxassetid://109230267448394', --// Swing, Noli, Skin: Artful
    'rbxassetid://109230267448394', --// Swing, Noli, Skin: Robert
    'rbxassetid://109230267448394', --// Swing, Noli, Skin: Ephialtes
    'rbxassetid://109230267448394' --// Swing, Noli, Skin: Umbra
};


        local RNG = Random.new();
        game:GetService('RunService').Heartbeat:Connect(function()
            if not HumanoidRootPart then
                return;
            end

            local Playing = false;
            for _,v in Humanoid:GetPlayingAnimationTracks() do
                if table.find(AttackAnimations, v.Animation.AnimationId) and (v.TimePosition / v.Length < 0.75) then
                    Playing = true;
                end
            end

            if not Playing then
                return;
            end

            local Target;
            local NearestDist = MaxDistance; -- 使用滑块设置的距离

            local function loop(t)
                for _,v in t do
                    if v == Character or not v:FindFirstChild("HumanoidRootPart") then
                        continue;
                    end

                    local Dist = (v.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude;

                    if Dist < NearestDist then
                        NearestDist = Dist;
                        Target = v;
                    end
                end
            end

            loop(workspace.Players:GetDescendants());
            loop(workspace.Map:FindFirstChild("NPCs", true):GetChildren());

            if not Target then
                return;
            end

            local OldVelocity = HumanoidRootPart.Velocity;
            local NeededVelocity =
            (Target.HumanoidRootPart.Position + vector.create(
                RNG:NextNumber(-1.5, 1.5),
                0,
                RNG:NextNumber(-1.5, 1.5)
            ) + (Target.HumanoidRootPart.Velocity * (Player:GetNetworkPing() * 1.25))
                - HumanoidRootPart.Position
            ) / (Player:GetNetworkPing() * 2);

            HumanoidRootPart.Velocity = NeededVelocity;
            game:GetService('RunService').RenderStepped:Wait();
            HumanoidRootPart.Velocity = OldVelocity;
        end);
    end,
})
--]]

local SM = Tabs.FightingKilling:AddRightGroupbox('暴力','angry')

-- 直接写成全局函数，不占 local 寄存器！
getASurvivor = function(dist)
    local c = localPlayer.Character
    local h = c and c:FindFirstChild("HumanoidRootPart")
    if not h then return end

    -- 修复：把 .FindFirstChild 改成 :FindFirstChild
    local s = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Survivors")
    if not s then return end

    for _, v in ipairs(s:GetChildren()) do
        local t = v:FindFirstChild("HumanoidRootPart")
        if t and (h.Position - t.Position).Magnitude < dist then
            return v
        end
    end
end

getClosestSurvivor = function()
    local c = localPlayer.Character
    local h = c and c:FindFirstChild("HumanoidRootPart")
    if not h then return nil, nil end

    local s = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Survivors")
    if not s then return nil, nil end

    local closest, dist = nil, math.huge
    for _, v in ipairs(s:GetChildren()) do
        local t = v:FindFirstChild("HumanoidRootPart")
        if t then
            local d = (h.Position - t.Position).Magnitude
            if d < dist then
                closest = v
                dist = d
            end
        end
    end
    return closest, dist
end

SM:AddToggle("SlashAura", { 
    Text = "攻击光环",
    Default = false,
    Callback = function(Value)
        -- 修复：使用传入的 Value 来控制循环，而不是 Toggles.SlashAura.Value
        if not Value then return end
        task.spawn(function()
            while Value do
                local hrp = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    if isKiller then
                        local yh = getASurvivor(Options.SlashAuraRange.Value)
                        if yh then
                            killerAttack()
                        end
                    else
                        if killerModel and killerModel:FindFirstChild("HumanoidRootPart") then
                            -- 修复：把 .magnitude 改成 .Magnitude（大写M）
                            local dist = (hrp.Position - killerModel.HumanoidRootPart.Position).Magnitude
                            if dist <= Options.SlashAuraRange.Value then
                                killerAttack()
                            end
                        end
                    end
                end
                task.wait(0.1)
            end
        end)
    end
})

SM:AddSlider("SlashAuraRange", {
    Text = "攻击光环范围",
    Default = 7,
    Min = 4,
    Max = 11,
    Rounding = 0,
})

SM:AddDivider()

SM:AddToggle('KillAll', {
    Text = "自动攻击所有玩家",
    Callback = function(s)
        -- 关闭时直接退出，无残留逻辑
        if not s then return end

        -- 前置条件检查（仅执行1次，确保环境有效）
        if playingState == "Spectating" then
            Library:Notify("LightStar-提示\n窥视时无法使用此功能", 3)
            Toggles.KillAll:SetValue(false)
            return
        end
        if isSurvivor then
            Library:Notify("LightStar-提示\n要使用此功能 您必须是杀手", 4)
            Toggles.KillAll:SetValue(false)
            return
        end
        if not (workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Survivors")) then
            Library:Notify("LightStar-提示\n未找到幸存者容器", 5)
            Toggles.KillAll:SetValue(false)
            return
        end
        local gameMap = workspace:FindFirstChild("Map")
        if not (gameMap and gameMap:FindFirstChild("Ingame") and gameMap.Ingame:FindFirstChild("Map")) then
            Library:Notify("LightStar-提示\n对局游戏地图未加载", 5)
            Toggles.KillAll:SetValue(false)
            return
        end
        -- 校验本地玩家角色是否加载（防空引用）
        if not (localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")) then
            Library:Notify("LightStar-提示\n本地角色未加载完成", 5)
            Toggles.KillAll:SetValue(false)
            return
        end

        -- 缓存本地玩家根部件（避免重复查找）
        local localHRP = localPlayer.Character.HumanoidRootPart
        
        -- 独立协程执行，避免阻塞UI
        task.spawn(function()
            while Toggles.KillAll.Value do
                -- 遍历所有幸存者（定义变量v，解决未定义错误）
                for _, v in pairs(workspace.Players.Survivors:GetChildren()) do
                    if not Toggles.KillAll.Value then return end -- 开关关闭，立即退出

                    -- 获取幸存者绑定的玩家对象
                    local name = v:GetAttribute("Username")
                    local plr = game.Players:FindFirstChild(name)
                    if not plr then continue end -- 未找到玩家，跳过

                    -- 目标幸存者状态校验
                    local surChar = plr.Character
                    if not surChar then continue end
                    local surHum = surChar:FindFirstChild("Humanoid")
                    if not surHum or surHum.Health <= 0 then continue end
                    local surHRP = surChar:FindFirstChild("HumanoidRootPart")
                    if not surHRP then continue end

                    -- 核心攻击循环：按滑块间隔持续追击当前目标
                    local skipTimeout = tick()
                    -- 修复：移除多余的end，循环体正确包裹逻辑
                    while tick() - skipTimeout <= Options.KillAllTeleportTime.Value do
                        -- 退出条件1：目标玩家已离开游戏
                        if game.Players:FindFirstChild(name) == nil then
                            break
                        end
                        -- 退出条件2：目标玩家角色异常/死亡
                        if not surChar or not surHum or surHum.Health <= 0 or not surHRP then
                            break
                        end
                        -- 退出条件3：功能开关已关闭
                        if not Toggles.KillAll.Value then
                            return
                        end

                        -- 执行传送+攻击
                        enableNoclip()
                        localHRP.CFrame = surHRP.CFrame + Vector3.new(0, 1, 0) -- 防穿模
                        localHRP.Velocity = Vector3.zero -- 清空速度
                        killerAttack()

                        task.wait() -- 帧延迟，避免阻塞
                    end
                end
                -- 一轮遍历完，短暂停顿再循环
                task.wait(1)
            end

            -- 开关关闭后，关闭穿墙（避免残留）
            if _G.noclipEnabled then
                disableNoclip()
            end
        end)
    end
})

SM:AddSlider("KillAllTeleportTime", {
    Text = "#秒传送另1个幸存者",
    Default = 25,
    Min = 5,
    Max = 60,
    Rounding = 0,
})

local SM = Tabs.Mess:AddLeftGroupbox('背刺[TweTime]','volleyball')

local replicatedStorage = game:GetService("ReplicatedStorage")
local Network = replicatedStorage:WaitForChild("Modules"):WaitForChild("Network")

function hasNotification(text)
    for i, v in pairs(localPlayer.PlayerGui.Notis:GetChildren()) do
        if string.find(v.Text:lower(), text) then
            return true
        end
    end
end
local function backstab(model)
    if not model then
        return
    else
        local stabbing = tick()
        local oldCf = localPlayer.Character.HumanoidRootPart.CFrame
        task.spawn(function()
            task.wait(0.2)
            Network:WaitForChild("RemoteEvent"):FireServer("UseActorAbility", {buffer.fromstring("\"Dagger\"")})
        end)
        repeat
            localPlayer.Character.HumanoidRootPart.CFrame = model.HumanoidRootPart.CFrame - (model.HumanoidRootPart.CFrame.LookVector * 1)
            task.wait()
        until (tick() - stabbing >= 3.5) or hasNotification("stab")
        task.wait(0.5)
        localPlayer.Character.HumanoidRootPart.CFrame = oldCf
    end
end
local function backstabClose(model)
    if not model then
        return
    else
        if (localPlayer.Character.HumanoidRootPart.Position - model.HumanoidRootPart.Position).magnitude <= Options.BackstabRange.Value then
            backstab(model)
        end
    end
end

SM:AddCheckbox("TweTimeAutoDagger", {
    Text = "自动传送背刺",
    Default = false,
    Callback = function(cool)
        task.spawn(function()
            while Toggles.TweTimeAutoDagger.Value and task.wait(0.1) do
                if hasAbilityReady("Dagger") and isSurvivor then
                    local suc, res = pcall(backstab, killerModel)
                    if not suc then
                        warn("error when backstabbing:", res)
                    end
                end
            end
        end)
    end
})

SM:AddToggle("TweTimeDaggerAura", {
    Text = "背刺光环",
    Default = false,
    Callback = function(cool)
        task.spawn(function()
            while Toggles.TweTimeDaggerAura.Value and task.wait(0.1) do
                if not Toggles.TweTimeAutoDagger.Value and hasAbilityReady("Dagger") and isSurvivor then
                    local suc, res = pcall(backstabClose, killerModel)
                    if not suc then
                        warn("error when backstabbing near killer:", res)
                    end
                end
            end
        end)
    end
})


SM:AddSlider("TweTimeBackstabRange", {
    Text = "背刺光环范围",
    Default = 20,
    Min = 7,
    Max = 99,
    Rounding = 0
})

local ZZ = Tabs.Mess:AddLeftGroupbox('<b><font color=\"rgb(255, 0, 0)\">飞行[最危险]</font></b>','plane')

local RunService = game:GetService("RunService") --获取玩家操控位置函数
local CFSpeed = 50
local CFLoop = nil

ZZ:AddLabel("<b><font color=\"rgb(255, 0, 0)\">[危险]</font></b> 你可能会被挂到Discord 可能会被封禁")

ZZ:AddToggle("CFly", {
    Text = "<b><font color=\"rgb(255, 0, 0)\">飞行</font></b>",
    Default = false,
    Callback = function(Value)
        if Value then
    local speaker = game.Players.LocalPlayer
    local character = speaker.Character
    if not character then return end
    
    local humanoid = character:FindFirstChildOfClass('Humanoid')
    local head = character:WaitForChild("Head")
    
    if not humanoid or not head then return end
    
    humanoid.PlatformStand = true
    head.Anchored = true
    
    if CFLoop then 
        CFLoop:Disconnect() 
        CFLoop = nil
    end
    
    CFLoop = RunService.Heartbeat:Connect(function(deltaTime)
        if not character or not humanoid or not head then 
            if CFLoop then 
                CFLoop:Disconnect() 
                CFLoop = nil
            end
            return 
        end
        
        local moveDirection = humanoid.MoveDirection * (CFSpeed * deltaTime)
        local headCFrame = head.CFrame
        local camera = workspace.CurrentCamera
        local cameraCFrame = camera.CFrame
        local cameraOffset = headCFrame:ToObjectSpace(cameraCFrame).Position
        cameraCFrame = cameraCFrame * CFrame.new(-cameraOffset.X, -cameraOffset.Y, -cameraOffset.Z + 1)
        local cameraPosition = cameraCFrame.Position
        local headPosition = headCFrame.Position

        local objectSpaceVelocity = CFrame.new(cameraPosition, Vector3.new(headPosition.X, cameraPosition.Y, headPosition.Z)):VectorToObjectSpace(moveDirection)
        head.CFrame = CFrame.new(headPosition) * (cameraCFrame - cameraPosition) * CFrame.new(objectSpaceVelocity)
    end)
        else
            local speaker = game.Players.LocalPlayer
    local character = speaker.Character
    
    if CFLoop then
        CFLoop:Disconnect()
        CFLoop = nil
    end
    
    if character then
        local humanoid = character:FindFirstChildOfClass('Humanoid')
        local head = character:FindFirstChild("Head")
        
        if humanoid then
            humanoid.PlatformStand = false
        end
        if head then
            head.Anchored = false
        end
    end
        end
    end
}):AddKeyPicker("KeyPicker", {
    Default = "F",
    SyncToggleState = true,
    Mode = "Toggle", 
    Text = "飞行",
    NoUI = false,  
})

ZZ:AddSlider("CFlySpeed", {
    Text = "<font color=\"rgb(255, 0, 0)\">飞行速度</font>",
    Default = 50,
    Min = 1,
    Max = 200,
    Rounding = 1,
    Callback = function(Value)
        CFSpeed = Value
    end
})

--[[
local Game = Tabs.Mess:AddLeftGroupbox('对局游戏','gamepad-2')

local hideBarConnection = nil
local customIconId = "12549056837" 

Game:AddInput('CustomIconInput', {
    Default = '12549056837',
    Numeric = false,
    Finished = true,
    ClearTextOnFocus = false,
    Text = '替换玩家对局虚拟形象图标id',
    Tooltip = '用于替换隐藏时显示的图标',
    Placeholder = '请输入图片id',
    Callback = function(value)
        if tonumber(value) then
            customIconId = value
            Library:Notify("LightStar-提示\n图片更改成功",3)
        else
            Library:Notify("LightStar-提示\n图片更改无效",3)
        end
    end
})

Game:AddToggle('ChangeGamePlayerInput', {
    Text = '替换玩家对局虚拟形象图标',
    Default = false,
    Callback = function(state)
    if state then
        local player = game:GetService("Players").LocalPlayer
        local playergui = player:WaitForChild("PlayerGui")
        local playerinfo = playergui:WaitForChild("TemporaryUI"):WaitForChild("PlayerInfo")
        local icon = playerinfo:FindFirstChild("PlayerIcon")
                    if icon and icon.Image ~= ("rbxassetid://" .. customIconId) then
                        icon.Image = "rbxassetid://".. customIconId
                    end
                end
             end
})

Game:AddToggle('HiddenGamePlayerColumn', {
    Text = '隐藏游戏对局玩家列表',
    Default = false,
    Tooltip = '隐藏玩家列表以及自己玩家虚拟形象头像 拍脚本视频最必用的',
    Callback = function(state)
        local player = game:GetService("Players").LocalPlayer
        local playergui = player:WaitForChild("PlayerGui")
        local playerinfo = playergui:WaitForChild("TemporaryUI"):WaitForChild("PlayerInfo")
        if state then
            if not hideBarConnection then
                hideBarConnection = game:GetService("RunService").RenderStepped:Connect(function()
                    local survivors = playerinfo:FindFirstChild("CurrentSurvivors")
                    if survivors and survivors.Visible then
                        survivors.Visible = false
                        end
                end)
             end
        else
            if hideBarConnection then
                hideBarConnection:Disconnect()
                hideBarConnection = nil
            end
            local survivors = playerinfo:FindFirstChild("CurrentSurvivors")
            if survivors then
                survivors.Visible = true
            end
        end
    end
})
--]]

local FunGroup = Tabs.Mess:AddRightGroupbox("后空翻","rbxthumb://type=Asset&id=2714338264&w=150&h=150")

local ff_connection = nil
local ff_enabled = false
local ff_cd = false
local jumpHeight = 72  -- 默认高度: 6 * 12 = 72
local jumpDistance = 35  -- 默认距离

local function Flip()
    if ff_cd then
        return
    end
    ff_cd = true
    local character = game.Players.LocalPlayer.Character
    if not character then
        ff_cd = false
        return
    end
    local hrp = character:FindFirstChild("HumanoidRootPart")
    local Humanoid = character:FindFirstChildOfClass("Humanoid")
    local animator = Humanoid and Humanoid:FindFirstChildOfClass("Animator")
    if not hrp or not Humanoid then
        ff_cd = false
        return
    end
    local savedTracks = {}
    if animator then
        for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
            savedTracks[#savedTracks + 1] = { track = track, time = track.TimePosition }
            track:Stop(0)
        end
    end
    Humanoid:ChangeState(Enum.HumanoidStateType.Physics)
    Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
    Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, false)
    Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running, false)
    Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
    Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, false)
    local duration = 0.45
    local steps = 120
    local startCFrame = hrp.CFrame
    local forwardVector = startCFrame.LookVector
    local upVector = Vector3.new(0, 1, 0)
    task.spawn(function()
        local startTime = tick()
        for i = 1, steps do
            local t = i / steps
            local height = jumpHeight * (t - t ^ 2)  -- 使用滑块调节的高度
            local nextPos = startCFrame.Position + forwardVector * (jumpDistance * t) + upVector * height    
            local rotation = startCFrame.Rotation * CFrame.Angles(-math.rad(i * (360 / steps)), 0, 0)

            hrp.CFrame = CFrame.new(nextPos) * rotation
            local elapsedTime = tick() - startTime
            local expectedTime = (duration / steps) * i
            local waitTime = expectedTime - elapsedTime
            if waitTime > 0 then
                task.wait(waitTime)
            end
        end

        hrp.CFrame = CFrame.new(startCFrame.Position + forwardVector * jumpDistance) * startCFrame.Rotation
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, true)
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running, true)
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, true)
        Humanoid:ChangeState(Enum.HumanoidStateType.Running)

        if animator then
            for _, data in ipairs(savedTracks) do
                local track = data.track
                track:Play()
                track.TimePosition = data.time
            end
        end
        task.wait(0.25)
        ff_cd = false
    end)
end

local sausageHolder = nil
local originalSize = nil
local ff_button = nil

local function SetFrontFlip(bool)
    ff_enabled = bool
    if ff_enabled == true then
        pcall(function()
            sausageHolder = game.CoreGui.TopBarApp.TopBarApp.UnibarLeftFrame.UnibarMenu["2"]
            originalSize = sausageHolder.Size.X.Offset
            ff_button = Instance.new("Frame", sausageHolder)
            ff_button.Size = UDim2.new(0, 48, 0, 44)
            ff_button.BackgroundTransparency = 1
            ff_button.BorderSizePixel = 0
            ff_button.Position = UDim2.new(0, sausageHolder.Size.X.Offset - 48, 0, 0)
            
            local imageButton = Instance.new("ImageButton", ff_button)
            imageButton.BackgroundTransparency = 1
            imageButton.BorderSizePixel = 0
            imageButton.Size = UDim2.new(0, 36, 0, 36)
            imageButton.AnchorPoint = Vector2.new(0.5, 0.5)
            imageButton.Position = UDim2.new(0.5, 0, 0.5, 0)
            imageButton.Image = "rbxthumb://type=Asset&id=2714338264&w=150&h=150"
            
            ff_connection = imageButton.Activated:Connect(Flip)
            sausageHolder.Size = UDim2.new(0, originalSize + 48, 0, sausageHolder.Size.Y.Offset)
            task.wait()
            ff_button.Position = UDim2.new(0, sausageHolder.Size.X.Offset - 48, 0, 0)
            
            task.spawn(function()
                pcall(function()
                    repeat
                        sausageHolder.Size = UDim2.new(0, originalSize + 48, 0, sausageHolder.Size.Y.Offset)
                        task.wait()
                        ff_button.Position = UDim2.new(0, sausageHolder.Size.X.Offset - 48, 0, 0)
                    until ff_enabled == false
                end)
            end)
        end)
    elseif ff_enabled == false then
        if ff_connection then
            ff_connection:Disconnect()
            ff_connection = nil
        end
        if ff_button then
            ff_button:Destroy()
            ff_button = nil
        end
        if sausageHolder then
            sausageHolder.Size = UDim2.new(0, originalSize, 0, sausageHolder.Size.Y.Offset)
        end
    end
end

FunGroup:AddCheckbox("FrontFlipButton", {
    Text = "显示按钮",
    Default = false,
    Callback = function(Value)
        SetFrontFlip(Value)
    end
})

FunGroup:AddSlider("FrontFlipJumpHeight", {
    Text = "跳跃高度",
    Default = 72,
    Min = 20,
    Max = 200,
    Rounding = 0,
    Compact = false,
    Callback = function(Value)
        jumpHeight = Value
    end
})

FunGroup:AddSlider("FrontFlipJumpDistance", {
    Text = "跳跃距离",
    Default = 35,
    Min = 10,
    Max = 100,
    Rounding = 0,
    Compact = false,
    Callback = function(Value)
        jumpDistance = Value
    end
})

--[[
local AntiBan = Tabs.Mess:AddRightGroupbox("绕过反作弊","heater")

do
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local LocalizationService = game:GetService("LocalizationService")
    local RunService = game:GetService("RunService")

    shared.AntiBanSafe = shared.AntiBanSafe or {running = false, hooks = {}}
    local data = shared.AntiBanSafe

    local oldNamecall, oldIndex
    local protectionThread

    -- 初始化hooks表
    data.hooks = data.hooks or {
        requestHooked = false,
        findHooked = false,
        bypassHooked = false
    }

    local function safe(func, ...)
        local ok, res = pcall(func, ...)
        if ok then return res end
        return nil
    end

    local function disableReportFlags()
        if type(setfflag) == "function" then
            pcall(function()
                setfflag("AbuseReportScreenshot", "False")
                setfflag("AbuseReportScreenshotPercentage", "0")
                setfflag("AbuseReportEnabled", "False")
                setfflag("ReportAbuseMenu", "False")
                setfflag("EnableAbuseReportScreenshot", "False")
                setfflag("AbuseReportVideo", "False")
                setfflag("AbuseReportVideoPercentage", "0")
                setfflag("VideoCaptureEnabled", "False")
                setfflag("RecordVideo", "False")
            end)
        end
    end

    local function hookRequests()
        if data.hooks.requestHooked then return true end
        
        local oldRequest = (syn and syn.request) or (request and request) or (http_request and http_request)
        if type(oldRequest) == "function" and type(hookfunction) == "function" then
            local success = pcall(function()
                hookfunction(oldRequest, function(req)
                    if req and req.Url and tostring(req.Url):lower():find("abuse") then
                        return {StatusCode = 200, Body = "Blocked"}
                    end
                    return oldRequest(req)
                end)
            end)
            
            if success then
                data.hooks.requestHooked = true
                return true
            end
        end
        return false
    end

    local function hookFindFirstChild()
        if data.hooks.findHooked then return true end
        
        local oldFind = workspace.FindFirstChild
        if type(oldFind) == "function" and type(hookfunction) == "function" then
            local success = pcall(function()
                hookfunction(oldFind, function(self, name, ...)
                    if checkcaller and checkcaller() then 
                        return oldFind(self, name, ...) 
                    end
                    if name and tostring(name):lower():find("screenshot") then 
                        return nil 
                    end
                    if name and tostring(name):lower():find("video") then 
                        return nil 
                    end
                    return oldFind(self, name, ...)
                end)
            end)
            
            if success then
                data.hooks.findHooked = true
                return true
            end
        end
        return false
    end

    local function setupMetatableHooks()
        if data.hooks.bypassHooked then return true end
        
        if getrawmetatable and hookmetamethod and newcclosure then
            local success = pcall(function()
                local mt = getrawmetatable(game)
                if not mt then return false end
                
                setreadonly(mt, false)
                
                -- 保存原始方法
                oldNamecall = oldNamecall or mt.__namecall
                oldIndex = oldIndex or mt.__index

                -- 设置namecall hook
                mt.__namecall = newcclosure(function(self, ...)
                    if checkcaller and checkcaller() then
                        return oldNamecall(self, ...)
                    end
                    
                    local method = getnamecallmethod()
                    local args = {...}

                    if (method == "Kick" or method == "Ban") and self == LocalPlayer then 
                        return nil 
                    end

                    if (method == "FireServer" or method == "InvokeServer") and args[1] then
                        local msg = tostring(args[1]):lower()
                        if msg:find("kick") or msg:find("ban") or msg:find("report") then 
                            return nil 
                        end
                    end

                    if self == LocalizationService and method == "GetCountryRegionForPlayerAsync" then
                        local success, result = pcall(function()
                            return LocalizationService:GetCountryRegionForPlayerAsync(LocalPlayer)
                        end)
                        if success then return result else return "US" end
                    end

                    return oldNamecall(self, ...)
                end)

                -- 设置index hook
                mt.__index = newcclosure(function(t, k)
                    if checkcaller and checkcaller() then
                        return oldIndex(t, k)
                    end
                    
                    local key = tostring(k):lower()
                    if key:find("kick") or key:find("ban") or key:find("report") then 
                        return function() return nil end 
                    end
                    return oldIndex(t, k)
                end)

                setreadonly(mt, true)
            end)
            
            if success then
                data.hooks.bypassHooked = true
                return true
            end
        end
        return false
    end

    local function restoreMetatableHooks()
        if getrawmetatable and oldNamecall and oldIndex then
            pcall(function()
                local mt = getrawmetatable(game)
                if mt then
                    setreadonly(mt, false)
                    mt.__namecall = oldNamecall
                    mt.__index = oldIndex
                    setreadonly(mt, true)
                end
            end)
        end
    end

    local function startProtectionLoop()
        if protectionThread then
            task.cancel(protectionThread)
        end
        
        protectionThread = task.spawn(function()
            local lastCheck = os.clock()
            local checkCount = 0
            
            while data.running do
                local currentTime = os.clock()
                
                -- 每2秒执行一次完整的flag检查
                if currentTime - lastCheck >= 2 then
                    disableReportFlags()
                    lastCheck = currentTime
                    checkCount = checkCount + 1
                    
                    -- 每10次检查（20秒）输出一次调试信息
                    if checkCount % 10 == 0 then
                        print(string.format("[绕过反作弊] 保护循环运行 - 检查 #%d", checkCount))
                    end
                end
                
                -- 使用小延迟避免占用过多CPU
                task.wait(0.1)
            end
            print("[绕过反作弊] 保护循环停止")
        end)
    end

    local function startAntiBanSafe()
        if data.running then 
            Library:Notify("LightStar-提示\n反作弊绕过已在运行中")
            return true
        end
        
        -- 检查必要的exploit函数
        if not (getrawmetatable and hookmetamethod and newcclosure) then
            Library:Notify("LightStar-提示\nExploit不支持必要的函数")
            return false
        end

        data.running = true

        -- 异步执行避免卡顿
        task.spawn(function()
            local hooksApplied = 0
            local totalHooks = 3
            
            -- 应用hooks
            if hookRequests() then hooksApplied = hooksApplied + 1 end
            if hookFindFirstChild() then hooksApplied = hooksApplied + 1 end
            if setupMetatableHooks() then hooksApplied = hooksApplied + 1 end
            
            -- 启动保护循环
            startProtectionLoop()

            if hooksApplied > 0 then
                Library:Notify(string.format("LightStar-提示\n绕过反作弊已开启！(%d/%d hooks)", hooksApplied, totalHooks))
                print("[绕过反作弊] 绕过反作弊保护成功激活")
            
                Library:Notify("LightStar-警告\n部分hook应用失败")
            end
        end)
        
        return true
    end

    local function stopAntiBanSafe()
        if not data.running then return end
        
        print("[绕过反作弊] 停止绕过反作弊...")
        data.running = false
        
        -- 停止保护线程
        if protectionThread then
            task.cancel(protectionThread)
            protectionThread = nil
        end
        
        -- 异步恢复hooks
        task.spawn(function()
            restoreMetatableHooks()
            
            -- 重置hook状态
            data.hooks.requestHooked = false
            data.hooks.findHooked = false
            data.hooks.bypassHooked = false
            oldNamecall = nil
            oldIndex = nil
            
            Library:Notify("LightStar-提示\n反作弊绕过已关闭")
            print("[绕过反作弊] 绕过反作弊完全停止")
        end)
    end

    local function toggleAntiBan(enabled)
        if enabled then
            return startAntiBanSafe()
        else
            stopAntiBanSafe()
            return true
        end
    end

    
AntiBan:AddToggle("AntiBanAC", {
        Text = "绕过AC",
        Default = data.running or false,
        Callback = function(enabled)
            local success = toggleAntiBan(enabled)
            if not success and enabled then
           
                task.spawn(function()
                    wait(0.1)
                    if AntiBan:GetToggle("AntiBanToggle") then
                        AntiBan:GetToggle("AntiBanToggle"):SetValue(false)
                    end
                end)
            end
        end
})

   
if data.running then
    task.spawn(function()
        wait(1)
        -- 假设 AntiBan 模块有一个 isEnabled 属性
        if AntiBan.isEnabled then
            print("[绕过反作弊] 恢复以前的绕过反作弊保护状态")
            -- 这里可以写你需要执行的逻辑
        end
    end)
end


  
    print(string.format("[绕过反作弊] 初始化 - 运行: %s", tostring(data.running)))
end

do
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local LocalizationService = game:GetService("LocalizationService")

    shared.AntiBanSafe = shared.AntiBanSafe or {running = false, hooks = {}}
    local data = shared.AntiBanSafe

    local oldNamecall, oldIndex
    local protectionThread

    local function safe(func, ...)
        local ok, res = pcall(func, ...)
        if ok then return res end
    end

    local function disableReportFlags()
        if typeof(setfflag) == "function" then
            pcall(function()
                setfflag("AbuseReportScreenshot", "False")
                setfflag("AbuseReportScreenshotPercentage", "0")
                setfflag("AbuseReportEnabled", "False")
                setfflag("ReportAbuseMenu", "False")
                setfflag("EnableAbuseReportScreenshot", "False")
                setfflag("AbuseReportVideo", "False")
                setfflag("AbuseReportVideoPercentage", "0")
                setfflag("VideoCaptureEnabled", "False")
                setfflag("RecordVideo", "False")
            end)
        end
    end

    local function setFlagsOn()
        if typeof(setfflag) == "function" then
            pcall(function()
                setfflag("AbuseReportScreenshot", "True")
                setfflag("AbuseReportScreenshotPercentage", "100")
            end)
        end
    end

    local function hookRequests()
        if data.hooks.requestHooked then return end
        local oldRequest = (syn and syn.request) or request or http_request
        if typeof(oldRequest) == "function" and typeof(hookfunction) == "function" then
            hookfunction(oldRequest, function(req)
                if req and req.Url and tostring(req.Url):lower():find("abuse") then
                    return {StatusCode = 200, Body = "Blocked"}
                end
                return oldRequest(req)
            end)
            data.hooks.requestHooked = true
        end
    end

    local function hookFindFirstChild()
        if data.hooks.findHooked then return end
        local oldFind = workspace.FindFirstChild
        if typeof(oldFind) == "function" and typeof(hookfunction) == "function" then
            hookfunction(oldFind, function(self, name, ...)
                if name and tostring(name):lower():find("screenshot") then return nil end
                if name and tostring(name):lower():find("video") then return nil end
                return oldFind(self, name, ...)
            end)
            data.hooks.findHooked = true
        end
    end

    local function safeBypass()
        if getrawmetatable and hookmetamethod and newcclosure then
            local mt = getrawmetatable(game)
            setreadonly(mt, false)
            oldNamecall = oldNamecall or mt.__namecall
            oldIndex = oldIndex or mt.__index

            mt.__namecall = newcclosure(function(self, ...)
                local method = getnamecallmethod()
                local args = {...}

                if (method == "Kick" or method == "Ban") and self == LocalPlayer then return nil end

                if (method == "FireServer" or method == "InvokeServer") and args[1] then
                    local msg = tostring(args[1]):lower()
                    if msg:find("kick") or msg:find("ban") then return nil end
                end

                if self == LocalizationService and method == "GetCountryRegionForPlayerAsync" then
                    local success, result = pcall(function()
                        return LocalizationService:GetCountryRegionForPlayerAsync(LocalPlayer)
                    end)
                    if success then return result else return "US" end
                end

                return oldNamecall(self, ...)
            end)

            mt.__index = newcclosure(function(t, k)
                local key = tostring(k):lower()
                if key:find("kick") or key:find("ban") then return function() return nil end end
                return oldIndex(t, k)
            end)

            setreadonly(mt, true)
        end
    end

    local function restoreHooks()
        if getrawmetatable then
            local mt = getrawmetatable(game)
            setreadonly(mt, false)
            if oldNamecall then mt.__namecall = oldNamecall end
            if oldIndex then mt.__index = oldIndex end
            setreadonly(mt, true)
            oldNamecall, oldIndex = nil, nil
        end
    end

    local function startAntiBanSafe()
        if data.running then return end
        data.running = true

        safe(hookRequests)
        safe(hookFindFirstChild)
        safe(safeBypass)

        protectionThread = task.spawn(function()
            while data.running do
                safe(disableReportFlags)
                task.wait(0.2)
            end
        end)
    end

    local function stopAntiBanSafe()
        data.running = false
        protectionThread = nil
        restoreHooks()
        setFlagsOn()
    end

AntiBan:AddToggle("AntiBanV2", {
        Text = "绕过反作弊V2",
        Description = "保护您免受封禁和举报",
        Default = false,
        Callback = function(state)
            if state then
                startAntiBanSafe()
            else
                stopAntiBanSafe()
            end
        end
})
end
--]]

local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local MVP = Tabs.PhysicalStrength:AddLeftGroupbox("体力")

-- 体力系统设置
local StaminaSettings = {
    MaxStamina = 100,      -- 最大体力值
    StaminaGain = 25,      -- 体力恢复速度
    StaminaLoss = 10,      -- 体力消耗速度
    SprintSpeed = 28,      -- 奔跑速度
    InfiniteGain = 9999    -- 无限体力恢复速度
}

-- 体力控制开关
local SettingToggles = {
    MaxStamina = true,
    StaminaGain = true,
    StaminaLoss = true,
    SprintSpeed = true
}

-- 获取游戏体力模块
local SprintingModule = ReplicatedStorage:WaitForChild("Systems"):WaitForChild("Character"):WaitForChild("Game"):WaitForChild("Sprinting")
local GetModule = function() return require(SprintingModule) end

-- 实时更新体力设置
task.spawn(function()
    while true do
        local m = GetModule()
        for key, value in pairs(StaminaSettings) do
            if SettingToggles[key] then
                m[key] = value
            end
        end
        task.wait(0.5)
    end
end)

local bai = {Spr = false}
local connection

MVP:AddToggle('InfiniteStamina', {
    Text = '无限体力',
    Default = false,
    Callback = function(state)
        bai.Spr = state
        local Sprinting = GetModule()

        if state then
            Sprinting.StaminaLoss = 0
            Sprinting.StaminaGain = StaminaSettings.InfiniteGain or 9999

            if connection then connection:Disconnect() end
            connection = RunService.Heartbeat:Connect(function()
                if not bai.Spr then return end
                Sprinting.StaminaLoss = 0
                Sprinting.StaminaGain = StaminaSettings.InfiniteGain or 9999
            end)
        else
            Sprinting.StaminaLoss = StaminaSettings.StaminaLoss or 10
            Sprinting.StaminaGain = StaminaSettings.StaminaGain or 25

            if connection then
                connection:Disconnect()
                connection = nil
            end
        end
    end
})

MVP:AddToggle('MaxStaminaToggle', {
    Text = '启用体力大小调节',
    Default = true,
    Callback = function(Value)
        SettingToggles.MaxStamina = Value
    end
})


MVP:AddToggle('StaminaGainToggle', {
    Text = '启用体力恢复调节',
    Default = true,
    Callback = function(Value)
        SettingToggles.StaminaGain = Value
    end
})

MVP:AddToggle('StaminaLossToggle', {
    Text = '启用体力消耗调节',
    Default = true,
    Callback = function(Value)
        SettingToggles.StaminaLoss = Value
    end
})

MVP:AddToggle('SprintSpeedToggle', {
    Text = '启用奔跑速度调节',
    Default = true,
    Callback = function(Value)
        SettingToggles.SprintSpeed = Value
    end
})

local MVP = Tabs.PhysicalStrength:AddRightGroupbox("调试")

MVP:AddSlider('InfStaminaGainSlider', {
    Text = '无限体力恢复速度',
    Default = 9999,
    Min = 0,
    Max = 50000,
    Rounding = 0,
    Callback = function(Value)
        StaminaSettings.InfiniteGain = Value
    end
})


MVP:AddSlider('MySlider1', {
    Text = '体力大小',
    Default = 100,
    Min = 100,
    Max = 10000,
    Rounding = 0,
    Callback = function(Value)
        StaminaSettings.MaxStamina = Value
    end
})


MVP:AddSlider('MySlider2', {
    Text = '体力恢复',
    Default = 25,
    Min = 0,
    Max = 250,
    Rounding = 0,
    Callback = function(Value)
        StaminaSettings.StaminaGain = Value
    end
})


MVP:AddSlider('MySlider3', {
    Text = '体力消耗',
    Default = 10,
    Min = 0,
    Max = 100,
    Rounding = 0,
    Callback = function(Value)
        StaminaSettings.StaminaLoss = Value
    end
})


MVP:AddSlider('MySlider4', {
    Text = '奔跑速度',
    Default = 28,
    Min = 0,
    Max = 200,
    Rounding = 0,
    Callback = function(Value)
        StaminaSettings.SprintSpeed = Value
    end
})

local ZZ = Tabs.Generator:AddLeftGroupbox("自动修机/演戏(事件)")


local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

ZZ:AddDropdown('GeneratorFixMode1', {
    Values = {'危险模式', '安全模式', '自调模式'},
    Default = 2,
    Multi = false,
    Text = '修机模式',
    Searchable = false,
    Callback = function(v)
        _G.FixMode = v
        if v == "危险模式" then
            Generator:SetValue("RepairSpeed", 1)
        elseif v == "安全模式" then
            Generator:SetValue("RepairSpeed", 3)
        end
    end
})

ZZ:AddSlider("GeneratorRepairSpeed1", {
    Text = "修机速度",
    Default = 4,
    Min = 1,
    Max = 15,
    Rounding = 1,
    Compact = false,
    Callback = function(v)
        _G.CustomSpeed = v
    end
})

ZZ:AddToggle("AutoFixGenerator1",{
    Text = "自动修机",
    Default = false,
    Callback = function(v)
        _G.AutoGen = v
        task.spawn(function()
            while _G.AutoGen do
                if game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("PuzzleUI") then
                    local delayTime = _G.CustomSpeed or 3
                    
                    if _G.GeneratorFixMode == "危险模式" then
                        delayTime = 2.5
                    elseif _G.GeneratorFixMode == "安全模式" then
                        delayTime = 5
                    end
                    
                    wait(delayTime)
                    
                    for _,v in ipairs(workspace["Map"]["Ingame"]["Map"]:GetChildren()) do
                        if v.Name == "Generator" then
                            v["Remotes"]["RE"]:FireServer()
                        end
                    end
                end
                wait()
            end
        end)
    end
})

local ZZ = Tabs.Generator:AddLeftGroupbox("自动修机/快速(事件)")

getgenv().AutoGenEnabled = false
getgenv().TimePerGenPhase = 1.25
getgenv().plr = LocalP

RSvc.RenderStepped:Connect(function()
	if not getgenv().AutoGenEnabled then return end
	if not plr.PlayerGui:FindFirstChild("PuzzleUI") then return end
	
	local char = plr.Character or plr.CharacterAdded:Wait()
	local root = char and char:FindFirstChild("HumanoidRootPart")
	if not root then return end
	
	local closest, dist = nil, math.huge
	local mapFolder = workspace:FindFirstChild("Map")
		and workspace.Map:FindFirstChild("Ingame")
		and workspace.Map.Ingame:FindFirstChild("Map")
		
	if mapFolder then
		for _, gen in ipairs(mapFolder:GetChildren()) do
			if gen:IsA("Model") and gen.Name == "Generator" and gen.PrimaryPart then
				local d = (root.Position - gen.PrimaryPart.Position).Magnitude
				if d < dist then
					closest, dist = gen, d
				end
			end
		end
	end
	
	if closest and closest:FindFirstChild("Remotes") and closest.Remotes:FindFirstChild("RE") then
		if not getgenv()._lastFire or tick() - getgenv()._lastFire >= getgenv().TimePerGenPhase then
			getgenv()._lastFire = tick()
			pcall(function() closest.Remotes.RE:FireServer() end)
		end
	end
end)

ZZ:AddToggle("AutoFixGenerator2", {
	Text = "自动修机",
	Default = false,
	Callback = function(Value)
		getgenv().AutoGenEnabled = Value
	end,
})

ZZ:AddSlider("GeneratorRepairSpeed2", {
	Text = "修机速度",
	Default = 1.25,
	Min = 1,
	Max = 15,
	Rounding = 2,
	Compact = false,
	Callback = function(Value)
		getgenv().TimePerGenPhase = Value
	end
})

local Generator = Tabs.Generator:AddRightGroupbox("发动机")

Generator:AddToggle("AutoStartGenerator", {
    Text = "自动互动发动机",
    Default = false,
    Callback = function(bool)
    local gameMap = workspace.Map
        _G.autoGen = bool
        task.spawn(function()
            while _G.autoGen and task.wait() do
                if gameMap:FindFirstChild("Ingame") and gameMap.Ingame:FindFirstChild("Map") then
                    pcall(function()
                        for _, v in pairs(gameMap.Ingame.Map:GetChildren()) do
                            if v.Name == "Generator" then
                                pcall(function()
                                    local function nextStep()
                                        if localPlayer.PlayerGui:FindFirstChild("PuzzleUI") then return end
                                        if activelyAutoing then return end

                                        if v.Main:FindFirstChild("Prompt") then
                                            fireproximityprompt(v.Main.Prompt)
                                        end
                                        task.wait(1)
                                    end

                                    local hello = v.Positions.Center.Position
                                    local hello2 = v.Positions.Right.Position
                                    local hello3 = v.Positions.Left.Position

                                    if not localPlayer.Character or not localPlayer.Character:FindFirstChild("HumanoidRootPart") then return end

                                    local pos = localPlayer.Character.HumanoidRootPart.Position
                                    if (pos - hello).Magnitude <= 4 then
                                        nextStep()
                                    elseif (pos - hello2).Magnitude <= 4 then
                                        nextStep()
                                    elseif (pos - hello3).Magnitude <= 4 then
                                        nextStep()
                                    end
                                end)
                            end
                        end
                    end)
                end
            end
        end)
    end
})

Generator:AddButton({
    Text = '传送到发动机',
    Func = function()
        local player = game.Players.LocalPlayer
        local character = player.Character
        if not character or not character:FindFirstChild("HumanoidRootPart") then return end
        
        local generators = workspace.Map.Ingame.Map:GetChildren()
        for _, generator in ipairs(generators) do
            if generator.Name == "Generator" and 
               generator:FindFirstChild("Progress") and 
               generator.Progress.Value < 100 then
                
                local generatorPart = generator:FindFirstChild("Main") or  
                                     generator:FindFirstChild("Model") or
                                     generator:FindFirstChild("Base")
                
                if generatorPart then
                    character.HumanoidRootPart.CFrame = generatorPart.CFrame + Vector3.new(0, 10, 0)
                    return  
                end
            end
        end
        Library:Notify("LightStar-提示\n没有找到可修理的发动机",3)
    end
})

Generator:AddDivider()

-- 第1种：逐个修理发电机，直到单台修满再换下一台，循环直到全部修完
Generator:AddCheckbox("AutoGeneratorTeleportFix1", {
    Text = "自动轮换修理发动机[第1种]",
    Default = false,
    Callback = function(enabled)
        -- 生成随机线程ID，用于安全关闭，防止多开冲突
        local threadId = tostring(math.random(1, 99999))
        _G.AutoFixThreadId = threadId

        -- 判断函数：当前功能是否应该继续运行
        local function shouldContinue()
            return _G.AutoFixThreadId == threadId and enabled
        end

        -- 判断函数：所有发电机是否都已修完
        local function allGeneratorsFixed()
            for _, v in ipairs(game.Workspace.Map.Ingame.Map:GetChildren()) do
                -- 检查是否为发电机且进度未满100
                if v.Name == "Generator" and v:FindFirstChild("Progress") and v.Progress.Value < 100 then
                    return false -- 还有未修完的发电机
                end
            end
            return true -- 全部发电机已修完
        end

        -- 主要：逐个修理发电机
        local function runGenerator()
            -- 只要功能开启且未修完，就一直循环
            while shouldContinue() and not allGeneratorsFixed() do
                -- 收集所有【未修满】的发电机
                local generators = {}
                for i, v in ipairs(game.Workspace.Map.Ingame.Map:GetChildren()) do
                    if v.Name == "Generator" and v:FindFirstChild("Progress") and v.Progress.Value < 100 then
                        table.insert(generators, v)
                    end
                end

                -- 遍历每一台发电机，逐个修理
                for _, generator in ipairs(generators) do
                    -- 如果关闭功能或全部修完，直接退出
                    if not shouldContinue() or allGeneratorsFixed() then return end
                    -- 这台已经修完，跳过
                    if generator.Progress.Value >= 100 then continue end

                    -- 记录发电机三个位置：左/右/中 是否有人 目前没制作 没什么用
                    local availablePositions = { Left = true, Right = true, Center = true }

                    for _, player in ipairs(game.Players:GetPlayers()) do
                        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                            local hrp = player.Character.HumanoidRootPart
                            -- 检查发电机的每个交互点
                            for _, pos in ipairs(generator.Positions:GetChildren()) do
                                -- 距离小于4，视为有人占用该位置
                                if (hrp.Position - pos.Position).Magnitude < 4 then
                                    availablePositions[pos.Name] = false
                                end
                            end
                        end
                    end

                    -- 选择第一个可用的空位
                    local positionToUse
                    for posName, isAvailable in pairs(availablePositions) do
                        if isAvailable then
                            positionToUse = posName
                            break
                        end
                    end

                    -- 找到空位 开始传送修理
                    if positionToUse and shouldContinue() then
                        local char = game.Players.LocalPlayer.Character
                        -- 角色不存在，等待1秒再继续
                        if not char or not char.PrimaryPart then
                            task.wait(1)
                            continue
                        end
                        
                        -- 传送过去（轻微抬高，防卡地面、防检测）
                        local targetPos = generator.Positions[positionToUse].CFrame
                        char.PrimaryPart.CFrame = targetPos * CFrame.new(0, 0.5, 0)
                        task.wait(0.58) -- 传送后稳定延迟

                        -- 尝试进入修机交互
                        local entered = false
                        pcall(function()
                            generator.Remotes.RF:InvokeServer("Enter")
                            entered = true
                        end)
                        if not entered then continue end -- 进不去就跳过这台

                        task.wait(0.93) -- 进入后的真人延迟

                        -- 循环修机 直到这台修好
                        while shouldContinue() and generator.Progress.Value < 100 do
                            pcall(function()
                                generator.Remotes.RE:FireServer() -- 发送修机进度包
                            end)
                            task.wait(1.6)
                        end

                        -- 修完 离开发电机
                        pcall(function()
                            generator.Remotes.RF:InvokeServer("Leave")
                        end)

                        task.wait(0.5)
                    end
                end

                -- 一轮遍历完准备换下一轮发电机前，强制退出当前可能未退出的发电机（新增逻辑）
                pcall(function()
                    -- 遍历所有发电机，检测是否还处于进入状态，若有则强制退出
                    for _, v in ipairs(game.Workspace.Map.Ingame.Map:GetChildren()) do
                        if v.Name == "Generator" then
                            v.Remotes.RF:InvokeServer("Leave")
                        end
                    end
                end)
                -- 一轮遍历完，休息一下再继续
                if shouldContinue() and not allGeneratorsFixed() then
                    task.wait(2)
                end
            end

            -- 全部发电机修完提示
            if allGeneratorsFixed() then
                Library:Notify("LightStar-提示\n全部发动机已修理完成", 3)
                Toggles.AutoGeneratorTeleportFix1:SetValue(false)
            end
        end

        -- 开启功能：启动新线程
        if enabled then
            if _G.AutoFixThread then
                _G.AutoFixThreadId = tostring(math.random(1,99999))
                task.cancel(_G.AutoFixThread) -- 关掉旧线程
            end
            _G.AutoFixThread = task.spawn(runGenerator)
        else
            -- 关闭功能：停止线程
            _G.AutoFixThreadId = tostring(math.random(1,99999))
            if _G.AutoFixThread then
                task.cancel(_G.AutoFixThread)
                _G.AutoFixThread = nil
            end
            -- 关闭功能时，强制退出所有发电机（新增兜底）
            pcall(function()
                for _, v in ipairs(game.Workspace.Map.Ingame.Map:GetChildren()) do
                    if v.Name == "Generator" then
                        v.Remotes.RF:InvokeServer("Leave")
                    end
                end
            end)
        end
    end
})

-- 第2种：按顺序轮流修，每台修一下就换下一台，循环直到全部修完
Generator:AddCheckbox("AutoGeneratorTeleportFix2", {
    Text = "自动轮换修理发动机[第2种]",
    Default = false,
    Callback = function(enabled)
        -- 生成随机线程ID，用于安全关闭，防止多开冲突
        local threadId = tostring(math.random(1,99999))
        _G.AutoFixThreadId = threadId

        -- 轮询发电机的序号，从第1台开始
        local index = 1

        -- 判断函数：当前功能是否应该继续运行
        local function shouldContinue()
            return _G.AutoFixThreadId == threadId and enabled
        end

        -- 当开关开启时
        if enabled then
            -- 开启独立协程，不卡主界面
            task.spawn(function()
                while shouldContinue() do
                    -- 收集地图中所有【未修满】的发电机
                    local gens = {}
                    for _, v in ipairs(workspace.Map.Ingame.Map:GetChildren()) do
                        if v.Name == "Generator" and v:FindFirstChild("Progress") and v.Progress.Value < 100 then
                            table.insert(gens, v)
                        end
                    end

                    -- 如果没有可修理的发电机
                    if #gens == 0 then
                        Library:Notify("LightStar-提示\n全部发动机已修理完成", 3)
                        Toggles.AutoGeneratorTeleportFix2:SetValue(false)
                        break
                    end

                    -- 轮询逻辑：序号超过总数则重置为1，实现循环
                    if index > #gens then
                        index = 1
                    end
                    local gen = gens[index]
                    index = index + 1

                    -- 获取发电机的交互点位
                    local pos = nil
                    if gen and gen:FindFirstChild("Positions") then
                        local pts = gen.Positions:GetChildren()
                        if #pts > 0 then
                            pos = pts[1]
                        end
                    end

                    -- 获取本地玩家角色和根节点
                    local char = game.Players.LocalPlayer.Character
                    local hrp = char and char:FindFirstChild("HumanoidRootPart")

                    -- 所有条件满足才执行传送+修机
                    if pos and hrp and gen then
                    
                    -- 准备传送下一台发电机前，强制退出当前正在修理的发电机（新增核心逻辑）
                    pcall(function()
                        gen.Remotes.RF:InvokeServer("Leave")
                    end)
                    task.wait(0.1) -- 退出后短暂延迟，防止服务器同步冲突

                        -- 超快瞬移
                        hrp.CFrame = pos.CFrame * CFrame.new(0, 0.2, 0)
                        task.wait(0.2)

                        -- 进入修机
                        pcall(function()
                            gen.Remotes.RF:InvokeServer("Enter")
                        end)
                        task.wait(0.6)

                        -- 触发修理
                        pcall(function()
                            gen.Remotes.RE:FireServer()
                        end)

                        -- 正常修理节奏
                        task.wait(0.5)

                        -- 修理完成离开
                        pcall(function()
                            gen.Remotes.RF:InvokeServer("Leave")
                        end)
                    end
                end
            end)
        else
            -- 关闭功能：更换线程ID，让循环安全退出
            _G.AutoFixThreadId = tostring(math.random(1,99999))
            -- 关闭功能时，强制退出所有发电机（新增兜底逻辑）
            pcall(function()
                for _, v in ipairs(workspace.Map.Ingame.Map:GetChildren()) do
                    if v.Name == "Generator" then
                        v.Remotes.RF:InvokeServer("Leave")
                    end
                end
            end)
        end
    end
})

--[[    
local TeleportGenerator = Tabs.Generator:AddRightGroupbox('传送')

for a = 1, 5 do
TeleportGenerator:AddButton({
        Text = "传送发动机 " .. a,
        Func = function ()
            if playingState == "Spectating" then
                return Notify("LightStar-提示", "必须在一轮 窥视时无法使用此功能", 7)
            end

            pcall(function ()
                if not (gameMap and gameMap.Ingame and gameMap.Ingame.Map) then return end
                local gens = {}

                for _, v in pairs(gameMap.Ingame.Map:GetChildren()) do
                    if v.Name == "Generator" then
                        table.insert(gens, v)
                    end
                end

                if gens[a] and gens[a]:FindFirstChild("Positions") and gens[a].Positions:FindFirstChild("Center") then
                    localPlayer.Character.HumanoidRootPart.CFrame = gens[a].Positions.Center.CFrame + Vector3.new(0, 10, 0)
                end
            end)
        end
})
end
--]]

--[
local MenuGroup = Tabs.Settings:AddLeftGroupbox("调试","wrench")

-- 1. 显示/隐藏快捷键菜单
MenuGroup:AddToggle("KeybindMenuOpen", {
    Default = Library.KeybindFrame.Visible,  -- 默认显示快捷键菜单
    Text = "键盘菜单",
    Callback = function(value)
        Library.KeybindFrame.Visible = value  -- 控制快捷键菜单的显示/隐藏
    end,
})

-- 3. 设置通知位置（左/右）
MenuGroup:AddDropdown("NotificationSide", {
    Values = { "Left", "Right" },
    Default = "Right",  -- 默认右侧显示通知
    Text = "通知位置",
    Callback = function(Value)
        Library:SetNotifySide(Value)  -- 设置通知位置
    end,
})

-- 4. 调整UI缩放比例（DPI）
MenuGroup:AddDropdown("DPIDropdown", {
    Values = { "25%", "50%", "75%", "100%", "125%", "150%", "175%", "200%" },
    Default = "100%",  -- 默认100%大小
    Text = "DPI菜单大小",
    Callback = function(Value)
        Value = Value:gsub("%%", "")  -- 移除百分号
        local DPI = tonumber(Value)   -- 转换为数字
        Library:SetDPIScale(DPI)      -- 调整UI缩放
    end,
})

MenuGroup:AddDivider()  

MenuGroup:AddLabel("界面打开")  
    :AddKeyPicker("MenuKeybind", { 
        Default = "RightShift",  
        NoUI = true,            
        Text = "Menu keybind"    
})

MenuGroup:AddButton("摧毁界面", function()
    Library:Unload()  
end)
--]]

--[[

local AddonsWarningText = "小心!您放入(LightStar/Addons)目录的任何脚本都会被执行器执行 我们建议您仅使用来自可信来源或开源的插件 对于播件造成的任何损害 我们概不负责 特此警告!"

local AddonsWarning = Tabs.Addons

AddonsWarning:UpdateWarningBox({
    Title = "LightStar",
    Text = AddonsWarningText,
    IsNormal = false, -- 错误盒子 = false, 正常盒子 = true
    Visible = true,
    LockSize = true,
})

local HubFolder = "LightStar"
local addonFolder = HubFolder.."/Addons"

if not isfolder(HubFolder) then
    makefolder(HubFolder)
end

if not isfolder(addonFolder) then
    makefolder(addonFolder)
end

AddonsFolder = AddonsFolder or {}
AddonsFolder.Addons = {}

for _, file in ipairs(listfiles(addonFolder)) do
    if file:sub(-4) == ".lua" or file:sub(-4) == ".txt" then
        local success, addon = pcall(function()
            return loadstring(readfile(file))()
        end)
        if success and type(addon) == "table" then
            table.insert(AddonsFolder.Addons, addon)
            
                Addons:AddToggle(addon.Text, {
                    Text = addon.Text,
                    Default = addon.Default,
                    Tooltip = addon.Tooltip.Text,
                    Callback = addon.Callback
                })
                

                Addons:AddButton(addon.Text, {
	             Text = addon.Text,
	             Tooltip = addon.Tooltip.Text,
	             Func = addon.Function
                })
                
                Addons:AddLabel(addon.Text)
                
                Addons:AddDivider(addon.Text)
                
                Addons:AddSlider(addon.Text, {
	            Text = addon.Text,
	            Default = addon.Default.Value,
	            Min = addon.Min.Value,
	            Max = addon.Max.Value,
	            Rounding = addon.Rounding.Value,
	            Tooltip = addon.Tooltip.Text,
	            Callback = addon.Callback
                })
                
                Addons:AddInput(addon.Text, {
	            Default = addon.Text,
	            Numeric = addon.Numeric,
	            Finished = addon.Finished,
	            ClearTextOnFocus = addon.ClearTextOnFocus,
	            Text = addon.Text,
	            Tooltip = addon.Tooltip.Text,
	            Placeholder = addon.Placeholder.Text,
	            Callback = addon.Callback
                })
                
                Addons:AddDropdown(addon.Text, {
	            Values = addon.Values,
	            Default = addon.Values.Default,
	            Multi = addon.Multi,
	            Text = addon.Text,
	            Tooltip = addon.Tooltip.Text,
	            Searchable = addon.Searchable,
	            Callback = addon.Callback
                })
      
            end
        
    end
end
--]]

function CreateFolder(f)
if not isfolder(f) then makefolder(f) repeat task.wait() until isfolder(f) end
end
function CreateFile(f,d)
if not isfile(f) then writefile(f,d) repeat task.wait() until isfile(f) end
end
CreateFolder("LightStar/Addons")

ThemeManager:SetLibrary(Library)  
SaveManager:SetLibrary(Library)   
SaveManager:IgnoreThemeSettings() 


SaveManager:SetIgnoreIndexes({ "MenuKeybind" })  
ThemeManager:SetFolder("LightStar")            
SaveManager:SetFolder("LightStar/Game")  
SaveManager:SetSubFolder("Forsaken")       
SaveManager:BuildConfigSection(Tabs.Settings)  

ThemeManager:ApplyToTab(Tabs.Settings)

SaveManager:LoadAutoloadConfig()

