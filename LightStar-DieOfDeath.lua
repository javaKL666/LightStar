-- by JackEyeKL




local repo = 'https://raw.githubusercontent.com/javaKL666/Obsidian/main/'






local Library = loadstring(game:HttpGet(repo .. "UseLibrary.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()

Library:Notify("Loading LightStar for Die of Death",5,4590657391)

local Options = Library.Options
local Toggles = Library.Toggles

Library.ForceCheckbox = false -- 默认点击开关盒子 (false / true)
Library.ShowToggleFrameInKeybinds = true 

local Window = Library:CreateWindow({
	Title = "LightStar",
	Footer = "LightStar团队脚本-discord.gg/BW55cR7Z [来源Nolsaken]",
	Icon = 106397684977541,
	NotifySide = "Top-Right",
	ShowCrosshair = false,
	Center = true,
    AutoShow = true,
    Resizable = true,
    TabPadding = 8,
    MenuFadeTime = 0
})

local Tabs = {
    new = Window:AddTab('公告','external-link','公告&信息'),
    Main = Window:AddTab('玩家','user','这是主要的!!!'),
    Esp = Window:AddTab('ESP','scan-eye','让你能够透视他们!!!'),
    --[[
    BanEffect = Window:AddTab('反效果','cpu','让你无法受到效果!!!'),
    --]]
   --[[
    PhysicalStrength = Window:AddTab('体力','zap','让你奔跑体力最大!!!'),
    --]]
    Settings = Window:AddTab("设置","settings",'设置&调试'),
}

local _env = getgenv and getgenv() or {}
local _hrp = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")

local new = Tabs.new:AddLeftGroupbox('新闻','rocket')

new:AddLabel("[+]开发 JackEyeKL")
new:AddLabel("支持是我们的最大的贡献💩")
new:AddLabel("脚本更新于1.31 晚上 10:42 时间")

--[[
local information = Tabs.new:AddLeftGroupbox('玩家 信息','info')

information:AddLabel("执行器 : " ..identifyexecutor())
information:AddLabel("用户名 : " ..game.Players.LocalPlayer.Name)
information:AddLabel("用户Id : "..game.Players.LocalPlayer.UserId)
information:AddLabel("昵称 : "..game.Players.LocalPlayer.DisplayName)
information:AddLabel("用户年龄 : "..game.Players.LocalPlayer.AccountAge.." 天")
--]]

--[[
local Team = Tabs.new:AddLeftGroupbox('聊','external-link')

Team:AddButton({
    Text = "复制 LightStar Discord 链接",
    Func = function ()
setclipboard("https://discord.gg/BW55cR7Z")
       end
})

Team:AddDivider()

Team:AddButton({
    Text = "复制 LightStar 企鹅群 ①",
    Func = function ()
setclipboard("798979110")
       end
})

--]]

local information = Tabs.new:AddRightGroupbox('信息','info')

information:AddLabel("Hello亲爱的使用LightStar者")
information:AddLabel("这个服务器脚本停更")
information:AddLabel("我不是跑路了")
information:AddLabel("我的账号已封禁")
information:AddLabel("我正在制作其他新的服务器脚本")
information:AddLabel("谢谢你的观看！！！")

--[[
local Contributor = Tabs.new:AddRightGroupbox('贡献者')

Contributor:AddLabel("[<b><font color=\"rgb(0, 0, 255)\">JackEyeKL</font></b>] - 脚本所有者")

Contributor:AddLabel("[<b><font color=\"rgb(128, 0, 128)\">宇星辰丫</font></b>] - 提供Nol原脚本终极源码")

local LightStar = Tabs.new:AddRightGroupbox('日志','users')

LightStar:AddLabel("新更新<b><font color=\"rgb(0, 255, 0)\">LightStar脚本</font></b>内容 * 0")

LightStar:AddDivider()

--LightStar:AddLabel("添加<b><font color=\"rgb(0, 255, 0)\">功能</font></b>功能了")
--]]

local KillerSurvival = Tabs.Main:AddLeftGroupbox("玩家","user")

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

KillerSurvival:AddToggle("EnableNoclip", {
    Text = "启用穿墙",
    Default = false,
    Callback = function (s)
  local Workspace = game:GetService("Workspace") local Players = game:GetService("Players") if NC then Clipon = true else Clipon = false end Stepped = game:GetService("RunService").Stepped:Connect(function() if not Clipon == false then for a, b in pairs(Workspace:GetChildren()) do if b.Name == Players.LocalPlayer.Name then for i, v in pairs(Workspace[Players.LocalPlayer.Name]:GetChildren()) do if v:IsA("BasePart") then v.CanCollide = false end end end end else Stepped:Disconnect() end end)
})

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")

local silentAimEnabled = false
local targetPlayer = nil
local maxDistance = 100
local silentAimConnection = nil

local function isKiller()
    local killersFolder = Workspace:WaitForChild("GameAssets"):WaitForChild("Teams"):WaitForChild("Killer")
    if killersFolder and LocalPlayer.Character and table.find(killersFolder:GetChildren(), LocalPlayer.Character) then
        return true
    end
    return false
end

local function getClosestSurvivor()
    local survivorsFolder = Workspace:WaitForChild("GameAssets"):WaitForChild("Teams"):WaitForChild("Survivor")
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

KillerSurvival:AddToggle("SilentAimbot(Killer)", {
    Text = "静默瞄准[杀手]",
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

KillerSurvival:AddButton("FixLag", {
    Text = "低画质",
    Func = function()
            loadstring(game:HttpGet('https://raw.githubusercontent.com/vexroxd/My-Script-/main/roblox%20fps%20unlocker%20script.lua'))()
   end
})

local Warning = Tabs.Main:AddLeftGroupbox("杀手靠近提示")

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
    
    local killersFolder = Workspace:WaitForChild("GameAssets"):WaitForChild("Teams"):WaitForChild("Killer")
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
Warning:AddToggle("KillerWarningToggle", {
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

local MainTabbox = Tabs.Main:AddRightTabbox()
local Camera = MainTabbox:AddTab("相机")

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

Camera:AddDivider()

Camera:AddSlider("FieldOfViewValue",{
    Text = "视野调节",
    Min = 70,
    Default = 70,
    Max = 120,
    Rounding = 1,
    Compact = true,
    Callback = function(v)
        _env.FieldOfViewValue = v
    end
})

_G.FieldOfViewValue = 70

Camera:AddToggle("EnableFieldOfView",{
    Text = "应用视野",
    Callback = function(v)
        _env.FOV = v
        game:GetService("RunService").RenderStepped:Connect(function()
            if _env.FOV then
                workspace.Camera.FieldOfView = _env.FieldOfViewValue
            end
        end)
    end
})

local Lighting = MainTabbox:AddTab("亮度")

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

Lighting:AddToggle("启用功能",{
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

local Visual = Tabs.Esp:AddRightGroupbox("高亮ESP")

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
    local survivorsFolder = Workspace:WaitForChild("GameAssets"):WaitForChild("Teams"):WaitForChild("Survivor")
    local killersFolder = Workspace:WaitForChild("GameAssets"):WaitForChild("Teams"):WaitForChild("Killer")
    
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
Visual:AddToggle("HighlightToggle", {
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

local Visual = Tabs.Esp:AddLeftGroupbox("角色名称ESP")

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
    local survivors = Workspace:WaitForChild("GameAssets"):WaitForChild("Teams"):WaitForChild("Survivor")
    local killers = Workspace:WaitForChild("GameAssets"):WaitForChild("Teams"):WaitForChild("Killer")
    
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
        local survivors = Workspace:WaitForChild("GameAssets"):WaitForChild("Teams"):WaitForChild("Survivor")
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
        local killers = Workspace:WaitForChild("GameAssets"):WaitForChild("Teams"):WaitForChild("Killer")
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

Visual:AddToggle("NameTagsToggle", {
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

Visual:AddToggle("ShowDistance", {
    Text = "显示距离",
    Default = true,
    Callback = function(enabled)
        NameTagSettings.ShowDistance = enabled
    end
})

local Visual = Tabs.Esp:AddLeftGroupbox("血量条ESP")

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
        local survivors = Workspace:WaitForChild("GameAssets"):WaitForChild("Teams"):WaitForChild("Survivor")
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
        local killers = Workspace:WaitForChild("GameAssets"):WaitForChild("Teams"):WaitForChild("Killer")
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
Visual:AddToggle("HealthBarsToggle", {
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

Visual = Tabs.Esp:AddLeftGroupbox("血量ESP[备用]")

local camera = workspace.CurrentCamera
local localPlayer = game:GetService("Players").LocalPlayer

Visual:AddToggle("SurvivorHealth", {
    Text = "ESP幸存者血量(文字)",
    Default = false,
    Callback = function(v)
        if v then
            local sur = Workspace:WaitForChild("GameAssets"):WaitForChild("Teams"):WaitForChild("Survivor")
            
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

Visual:AddToggle("KillerHealth", {
    Text = "ESP杀手血量(文字)",
    Default = false,
    Callback = function(v)
        if v then
            local kil = Workspace:WaitForChild("GameAssets"):WaitForChild("Teams"):WaitForChild("Killer")
            
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

local Visual = Tabs.Esp:AddRightGroupbox("2D方框")

Visual:AddToggle("2dEspSurvivorbox", {
    Text = "ESP幸存者方框",
    Default = false,
    Callback = function(v)
        if v then
            local a = Workspace:WaitForChild("GameAssets")
            local c = a:WaitForChild("Teams"):WaitForChild("Survivor")
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
            local a = Workspace:WaitForChild("GameAssets")
            local c = a:WaitForChild("Teams"):WaitForChild("Survivor")
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

Visual:AddToggle("2dEspKillerbox", {
    Text = "ESP杀手方框",
    Default = false,
    Callback = function(v)
        if v then
            local a = Workspace:WaitForChild("GameAssets")
            local b = a:WaitForChild("Teams"):WaitForChild("Killer")
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
            local a = Workspace:WaitForChild("GameAssets")
            local b = a:WaitForChild("Teams"):WaitForChild("Killer")
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

local Visual = Tabs.Esp:AddRightGroupbox("3D方框ESP")

-- 3D方框ESP设置
local Box3DSettings = {
    -- 基本设置
    Enabled = false,
    ShowSurvivorBoxes = true,
    ShowKillerBoxes = true,
    
    -- 颜色设置
    SurvivorColor = Color3.fromRGB(0, 255, 255), -- 青色
    KillerColor = Color3.fromRGB(255, 0, 0),     -- 红色
    UseTeamColor = true,
    
    -- 样式设置
    Thickness = 1,
    Transparency = 0.7,
    BoxHeightOffset = 0.5,
    
    -- 比例设置
    SurvivorBoxScale = 1.0,
    KillerBoxScale = 1.2,
    
    -- 宽度调节
    LeftWidthScale = 1.0,
    RightWidthScale = 1.0,
    
    -- 深度调节 (加强版)
    FrontExtend = 1.0,
    BackExtend = 1.0,
    FrontExtendMultiplier = 1.0,  -- 前延伸倍数
    BackExtendMultiplier = 1.0,   -- 后延伸倍数
    
    -- 高度调节
    HeadOffset = 1.5,
    FootOffset = 0.2,
    BoxHeightScale = 1.0,         -- 方框高度比例
    VerticalOffset = 0,           -- 垂直偏移
    
    -- 连接线
    connection = nil,
    removedConnection = nil
}

-- 存储所有3D方框ESP对象
local Box3DDrawings = {}

-- 创建3D方框ESP对象
local function create3DBoxDrawing()
    local drawing = {
        lines = {},
        visible = false
    }
    
    for i = 1, 12 do
        drawing.lines[i] = Drawing.new("Line")
        drawing.lines[i].Thickness = Box3DSettings.Thickness
        drawing.lines[i].Transparency = Box3DSettings.Transparency
        drawing.lines[i].Visible = false
    end
    
    return drawing
end

-- 计算模型的3D边界框（全方位调节）
local function calculateModelBoundingBox(model, isKiller)
    local rootPart = model:FindFirstChild("HumanoidRootPart") or model:FindFirstChild("Torso") or model:FindFirstChild("UpperTorso")
    local head = model:FindFirstChild("Head")
    
    if rootPart then
        local size = rootPart.Size
        local cframe = rootPart.CFrame
        
        -- 应用比例调整
        local scale = isKiller and Box3DSettings.KillerBoxScale or Box3DSettings.SurvivorBoxScale
        size = size * scale
        
        -- 计算基础高度并应用高度比例
        local baseHeight = 5
        if head then
            baseHeight = (head.Position.Y - rootPart.Position.Y) * 2
        end
        local height = (baseHeight + Box3DSettings.HeadOffset + Box3DSettings.FootOffset) * Box3DSettings.BoxHeightScale
        
        -- 调整左右宽度
        local leftOffset = (size.X/2) * Box3DSettings.LeftWidthScale
        local rightOffset = (size.X/2) * Box3DSettings.RightWidthScale
        
        -- 调整前后延伸 (加强版)
        local frontOffset = (size.Z/2) * Box3DSettings.FrontExtend * Box3DSettings.FrontExtendMultiplier
        local backOffset = (size.Z/2) * Box3DSettings.BackExtend * Box3DSettings.BackExtendMultiplier
        
        -- 计算最小和最大点
        local min = Vector3.new(
            cframe.Position.X - leftOffset,
            cframe.Position.Y - height/2 + Box3DSettings.FootOffset,
            cframe.Position.Z - backOffset
        )
        
        local max = Vector3.new(
            cframe.Position.X + rightOffset,
            cframe.Position.Y + height/2 + Box3DSettings.HeadOffset,
            cframe.Position.Z + frontOffset
        )
        
        -- 应用高度偏移和垂直偏移
        min = Vector3.new(min.X, min.Y + Box3DSettings.BoxHeightOffset + Box3DSettings.VerticalOffset, min.Z)
        max = Vector3.new(max.X, max.Y + Box3DSettings.BoxHeightOffset + Box3DSettings.VerticalOffset, max.Z)
        
        return min, max
    else
        -- 回退到遍历所有部件的方法
        local min = Vector3.new(math.huge, math.huge, math.huge)
        local max = Vector3.new(-math.huge, -math.huge, -math.huge)
        
        for _, part in ipairs(model:GetDescendants()) do
            if part:IsA("BasePart") then
                local cframe = part.CFrame
                local size = part.Size
                
                local scale = isKiller and Box3DSettings.KillerBoxScale or Box3DSettings.SurvivorBoxScale
                size = size * scale
                
                -- 调整左右宽度
                local leftOffset = (size.X/2) * Box3DSettings.LeftWidthScale
                local rightOffset = (size.X/2) * Box3DSettings.RightWidthScale
                
                -- 调整前后延伸 (加强版)
                local frontOffset = (size.Z/2) * Box3DSettings.FrontExtend * Box3DSettings.FrontExtendMultiplier
                local backOffset = (size.Z/2) * Box3DSettings.BackExtend * Box3DSettings.BackExtendMultiplier
                
                -- 计算顶点（考虑前后延伸）
                local vertices = {
                    cframe * Vector3.new(rightOffset, (size.Y/2) * Box3DSettings.BoxHeightScale, frontOffset),
                    cframe * Vector3.new(-leftOffset, (size.Y/2) * Box3DSettings.BoxHeightScale, frontOffset),
                    cframe * Vector3.new(rightOffset, (-size.Y/2) * Box3DSettings.BoxHeightScale, frontOffset),
                    cframe * Vector3.new(-leftOffset, (-size.Y/2) * Box3DSettings.BoxHeightScale, frontOffset),
                    cframe * Vector3.new(rightOffset, (size.Y/2) * Box3DSettings.BoxHeightScale, -backOffset),
                    cframe * Vector3.new(-leftOffset, (size.Y/2) * Box3DSettings.BoxHeightScale, -backOffset),
                    cframe * Vector3.new(rightOffset, (-size.Y/2) * Box3DSettings.BoxHeightScale, -backOffset),
                    cframe * Vector3.new(-leftOffset, (-size.Y/2) * Box3DSettings.BoxHeightScale, -backOffset)
                }
                
                -- 更新最小和最大点
                for _, vertex in ipairs(vertices) do
                    min = Vector3.new(
                        math.min(min.X, vertex.X),
                        math.min(min.Y, vertex.Y),
                        math.min(min.Z, vertex.Z)
                    )
                    max = Vector3.new(
                        math.max(max.X, vertex.X),
                        math.max(max.Y, vertex.Y),
                        math.max(max.Z, vertex.Z)
                    )
                end
            end
        end
        
        -- 应用高度偏移和垂直偏移
        min = Vector3.new(min.X, min.Y + Box3DSettings.BoxHeightOffset + Box3DSettings.VerticalOffset, min.Z)
        max = Vector3.new(max.X, max.Y + Box3DSettings.BoxHeightOffset + Box3DSettings.VerticalOffset, max.Z)
        
        return min, max
    end
end

-- 更新单个3D方框
local function updateSingle3DBox(model, drawing, color, isKiller)
    local camera = workspace.CurrentCamera
    local min, max = calculateModelBoundingBox(model, isKiller)
    
    -- 计算立方体的8个顶点
    local vertices = {
        Vector3.new(max.X, max.Y, max.Z), -- 右上后
        Vector3.new(min.X, max.Y, max.Z), -- 左上后
        Vector3.new(max.X, min.Y, max.Z), -- 右下后
        Vector3.new(min.X, min.Y, max.Z), -- 左下后
        Vector3.new(max.X, max.Y, min.Z), -- 右上前
        Vector3.new(min.X, max.Y, min.Z), -- 左上前
        Vector3.new(max.X, min.Y, min.Z), -- 右下前
        Vector3.new(min.X, min.Y, min.Z)  -- 左下前
    }
    
    -- 转换顶点到屏幕空间
    local screenVertices = {}
    local anyVisible = false
    
    for i, vertex in ipairs(vertices) do
        local screenPos, onScreen = camera:WorldToViewportPoint(vertex)
        screenVertices[i] = Vector2.new(screenPos.X, screenPos.Y)
        if onScreen then anyVisible = true end
    end
    
    -- 设置线条属性
    for _, line in pairs(drawing.lines) do
        line.Color = color
        line.Thickness = Box3DSettings.Thickness
        line.Transparency = Box3DSettings.Transparency
    end
    
    -- ESP立方体边线
    if anyVisible then
        -- 前面4条边
        drawing.lines[1].From = screenVertices[5] drawing.lines[1].To = screenVertices[6] -- 上面前
        drawing.lines[2].From = screenVertices[6] drawing.lines[2].To = screenVertices[8] -- 左边前
        drawing.lines[3].From = screenVertices[8] drawing.lines[3].To = screenVertices[7] -- 下面前
        drawing.lines[4].From = screenVertices[7] drawing.lines[4].To = screenVertices[5] -- 右边前
        
        -- 后面4条边
        drawing.lines[5].From = screenVertices[1] drawing.lines[5].To = screenVertices[2] -- 上面后
        drawing.lines[6].From = screenVertices[2] drawing.lines[6].To = screenVertices[4] -- 左边后
        drawing.lines[7].From = screenVertices[4] drawing.lines[7].To = screenVertices[3] -- 下面后
        drawing.lines[8].From = screenVertices[3] drawing.lines[8].To = screenVertices[1] -- 右边后
        
        -- 连接前后面的4条边
        drawing.lines[9].From = screenVertices[1] drawing.lines[9].To = screenVertices[5] -- 右上
        drawing.lines[10].From = screenVertices[2] drawing.lines[10].To = screenVertices[6] -- 左上
        drawing.lines[11].From = screenVertices[3] drawing.lines[11].To = screenVertices[7] -- 右下
        drawing.lines[12].From = screenVertices[4] drawing.lines[12].To = screenVertices[8] -- 左下
        
        -- 显示所有线条
        for _, line in pairs(drawing.lines) do
            line.Visible = true
        end
        
        drawing.visible = true
    else
        if drawing.visible then
            for _, line in pairs(drawing.lines) do
                line.Visible = false
            end
            drawing.visible = false
        end
    end
end

-- 更新所有3D方框
local function update3DBoxes()
    local players = game:GetService("Players")
    local localPlayer = players.LocalPlayer
    local camera = workspace.CurrentCamera
    
    -- 先隐藏所有现有的方框
    for model, drawing in pairs(Box3DDrawings) do
        if not model or not model.Parent then
            -- 模型已不存在，清理ESP对象
            for _, line in pairs(drawing.lines) do
                line:Remove()
            end
            Box3DDrawings[model] = nil
        else
            -- 暂时隐藏
            for _, line in pairs(drawing.lines) do
                line.Visible = false
            end
            drawing.visible = false
        end
    end
    
    -- 处理幸存者方框
    if Box3DSettings.ShowSurvivorBoxes then
        local survivors = Workspace:WaitForChild("GameAssets"):WaitForChild("Teams"):WaitForChild("Survivor")
        if survivors then
            for _, survivor in ipairs(survivors:GetChildren()) do
                if survivor:IsA("Model") and survivor ~= localPlayer.Character then
                    -- 获取或创建ESP对象
                    if not Box3DDrawings[survivor] then
                        Box3DDrawings[survivor] = create3DBoxDrawing()
                    end
                    
                    updateSingle3DBox(survivor, Box3DDrawings[survivor], Box3DSettings.SurvivorColor, false)
                end
            end
        end
        
        -- 额外检查玩家列表中的幸存者
        for _, player in ipairs(players:GetPlayers()) do
            if player ~= localPlayer and player.Character and not player.Character:FindFirstChild("IsKiller") then
                if not Box3DDrawings[player.Character] then
                    Box3DDrawings[player.Character] = create3DBoxDrawing()
                end
                
                updateSingle3DBox(player.Character, Box3DDrawings[player.Character], Box3DSettings.SurvivorColor, false)
            end
        end
    end
    
    -- 处理杀手方框
    if Box3DSettings.ShowKillerBoxes then
        local killers = Workspace:WaitForChild("GameAssets"):WaitForChild("Teams"):WaitForChild("Killer")
        if killers then
            for _, killer in ipairs(killers:GetChildren()) do
                if killer:IsA("Model") and killer ~= localPlayer.Character then
                    -- 获取或创建ESP对象
                    if not Box3DDrawings[killer] then
                        Box3DDrawings[killer] = create3DBoxDrawing()
                    end
                    
                    updateSingle3DBox(killer, Box3DDrawings[killer], Box3DSettings.KillerColor, true)
                end
            end
        end
        
        -- 额外检查玩家列表中的杀手
        for _, player in ipairs(players:GetPlayers()) do
            if player ~= localPlayer and player.Character and player.Character:FindFirstChild("IsKiller") then
                if not Box3DDrawings[player.Character] then
                    Box3DDrawings[player.Character] = create3DBoxDrawing()
                end
                
                updateSingle3DBox(player.Character, Box3DDrawings[player.Character], Box3DSettings.KillerColor, true)
            end
        end
    end
end

-- 清理3D方框
local function cleanup3DBoxes()
    for _, drawing in pairs(Box3DDrawings) do
        if drawing then
            for _, line in pairs(drawing.lines) do
                line:Remove()
            end
        end
    end
    Box3DDrawings = {}
end

-- 主开关
Visual:AddToggle("Box3DToggle", {
    Text = "启用3D方框",
    Default = false,
    Callback = function(enabled)
        Box3DSettings.Enabled = enabled
        if enabled then
            -- 初始化连接
            if not Box3DSettings.connection then
                Box3DSettings.connection = game:GetService("RunService").RenderStepped:Connect(update3DBoxes)
            end
            
            -- 监听角色移除
            if not Box3DSettings.removedConnection then
                Box3DSettings.removedConnection = workspace.DescendantRemoving:Connect(function(descendant)
                    if Box3DDrawings[descendant] then
                        for _, line in pairs(Box3DDrawings[descendant].lines) do
                            line:Remove()
                        end
                        Box3DDrawings[descendant] = nil
                    end
                end)
            end
        else
            -- 关闭连接
            if Box3DSettings.connection then
                Box3DSettings.connection:Disconnect()
                Box3DSettings.connection = nil
            end
            
            if Box3DSettings.removedConnection then
                Box3DSettings.removedConnection:Disconnect()
                Box3DSettings.removedConnection = nil
            end
            
            -- 清理ESP对象
            cleanup3DBoxes()
        end
    end
})

-- 幸存者开关
Visual:AddToggle("ShowSurvivorBoxes", {
    Text = "显示幸存者方框",
    Default = true,
    Callback = function(enabled)
        Box3DSettings.ShowSurvivorBoxes = enabled
    end
})

-- 杀手开关
Visual:AddToggle("ShowKillerBoxes", {
    Text = "显示杀手方框",
    Default = true,
    Callback = function(enabled)
        Box3DSettings.ShowKillerBoxes = enabled
    end
})

-- 样式设置
Visual:AddSlider("BoxThickness", {
    Text = "线条粗细",
    Min = 1,
    Max = 5,
    Default = 1,
    Rounding = 0,
    Callback = function(value)
        Box3DSettings.Thickness = value
    end
})

Visual:AddSlider("BoxTransparency", {
    Text = "透明度",
    Min = 0,
    Max = 1,
    Default = 0.7,
    Rounding = 1,
    Callback = function(value)
        Box3DSettings.Transparency = value
    end
})

Visual:AddSlider("BoxHeightOffset", {
    Text = "高度偏移",
    Min = 0,
    Max = 2,
    Default = 0.5,
    Rounding = 1,
    Callback = function(value)
        Box3DSettings.BoxHeightOffset = value
    end
})


Visual:AddSlider("BoxHeightScale", {
    Text = "方框高度比例",
    Min = 0.5,
    Max = 2.5,
    Default = 1.2,
    Rounding = 1,
    Callback = function(value)
        Box3DSettings.BoxHeightScale = value
    end
})

Visual:AddSlider("VerticalOffset", {
    Text = "垂直偏移",
    Min = -5,
    Max = 5,
    Default = -1,
    Rounding = 1,
    Callback = function(value)
        Box3DSettings.VerticalOffset = value
    end
})


Visual:AddSlider("SurvivorBoxScale", {
    Text = "幸存者方框比例",
    Min = 1.7,
    Max = 2,
    Default = 1.7,
    Rounding = 1,
    Callback = function(value)
        Box3DSettings.SurvivorBoxScale = value
    end
})

Visual:AddSlider("KillerBoxScale", {
    Text = "杀手方框比例",
    Min = 1.7,
    Max = 2,
    Default = 1.7,
    Rounding = 1,
    Callback = function(value)
        Box3DSettings.KillerBoxScale = value
    end
})

Visual:AddSlider("LeftWidthScale", {
    Text = "左侧宽度比例",
    Min = 1.0,
    Max = 2,
    Default = 1.0,
    Rounding = 1,
    Callback = function(value)
        Box3DSettings.LeftWidthScale = value
    end
})

Visual:AddSlider("RightWidthScale", {
    Text = "右侧宽度比例",
    Min = 0.9,
    Max = 2,
    Default = 0.9,
    Rounding = 1,
    Callback = function(value)
        Box3DSettings.RightWidthScale = value
    end
})


Visual:AddSlider("FrontExtend", {
    Text = "前延伸基础值",
    Min = 1.9,
    Max = 2,
    Default = 1.9,
    Rounding = 1,
    Callback = function(value)
        Box3DSettings.FrontExtend = value
    end
})

Visual:AddSlider("BackExtend", {
    Text = "后延伸基础值",
    Min = 1.8,
    Max = 2,
    Default = 1.8,
    Rounding = 1,
    Callback = function(value)
        Box3DSettings.BackExtend = value
    end
})

Visual:AddSlider("FrontExtendMultiplier", {
    Text = "前延伸倍数",
    Min = 1.0,
    Max = 3.0,
    Default = 1.0,
    Rounding = 1,
    Callback = function(value)
        Box3DSettings.FrontExtendMultiplier = value
    end
})

Visual:AddSlider("BackExtendMultiplier", {
    Text = "后延伸倍数",
    Min = 1.0,
    Max = 3.0,
    Default = 1.0,
    Rounding = 1,
    Callback = function(value)
        Box3DSettings.BackExtendMultiplier = value
    end
})

-- 高度调节
Visual:AddSlider("HeadOffset", {
    Text = "头部偏移",
    Min = 1.5,
    Max = 3,
    Default = 1.5,
    Rounding = 1,
    Callback = function(value)
        Box3DSettings.HeadOffset = value
    end
})

Visual:AddSlider("FootOffset", {
    Text = "脚部偏移",
    Min = 0.2,
    Max = 1,
    Default = 0.2,
    Rounding = 1,
    Callback = function(value)
        Box3DSettings.FootOffset = value
    end
})

--[[]
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

-- 无限体力功能
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
    Min = 0,
    Max = 99999,
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
--]]

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

ThemeManager:SetFolder("LightStar")
SaveManager:SetFolder("LightStar/Game")
SaveManager:SetSubFolder("Die of Death")

SaveManager:BuildConfigSection(Tabs.Settings)
ThemeManager:ApplyToTab(Tabs.Settings)
SaveManager:LoadAutoloadConfig()

