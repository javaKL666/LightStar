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

local autoLoops = {}
local function startLoop(name, callback, delay)
    if autoLoops[name] then return end
    autoLoops[name] = coroutine.wrap(function()
        while autoLoops[name] do
            pcall(callback)
            task.wait(delay)
        end
    end)
    task.spawn(autoLoops[name])
end

local function stopLoop(name)
    if not autoLoops[name] then return end
    autoLoops[name] = nil
end

Library.ForceCheckbox = false -- 默认点击开关盒子 (false / true)
Library.ShowToggleFrameInKeybinds = true 

local Window = Library:CreateWindow({
	Title = "LightStar",
	Footer = "LightStar团队脚本-discord.gg/BW55cR7Z [来源Nolsaken]",
	Icon = 106397684977541,
})

local Tabs = {
    new = Window:AddTab('主持','external-link','公告&信息'),
    Main = Window:AddTab('吃掉','house','这是主要功能的!!!'),
    Settings = Window:AddTab("设置","settings",'设置&调试'),
    Addons = Window:AddTab("插件","boxes",'这是功能添加!!!'),
}

Addons = Tabs.Addons:AddLeftGroupbox('插件&附加','blocks')

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

local information = Tabs.new:AddLeftGroupbox('信息','info')

    local Players = game:GetService('Players')
    local player = Players.LocalPlayer
    local avatarImage = information:AddImage('AvatarThumbnail', {
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
    
information:AddDivider()

information:AddLabel("欢迎用户"..game.Players.LocalPlayer.DisplayName.." ("..game.Players.LocalPlayer.Name..")")
information:AddLabel("支持是我们的最大的贡献😜")

information:AddDivider()

information:AddLabel("执行器 : " ..identifyexecutor())
--[[

local information = Tabs.new:AddRightGroupbox('信息','info')

information:AddLabel("Hello亲爱的使用LightStar者")
information:AddLabel("这个服务器脚本停更")
information:AddLabel("我不是跑路了")
information:AddLabel("我的账号已封禁")
information:AddLabel("我正在制作其他新的服务器脚本")
information:AddLabel("谢谢你的观看！！！")

--]]

local Contributor = Tabs.new:AddRightGroupbox('鸣谢&贡献者','handshake')

Contributor:AddLabel("[<b><font color=\"rgb(0, 0, 255)\">JackEyeKL</font></b>] - 脚本所有者")

Contributor:AddLabel("[<b><font color=\"rgb(128, 0, 128)\">Yuxingchen</font></b>] - 提供Nol原脚本终极源码")

local world = Tabs.Main:AddLeftGroupbox('杂项','cpu')

local main = {
    AutoGrab = false,
    AutoGrabInterval = 2,
    AutoEat = false,
    AutoEatInterval = 0.1,
    AutoThrow = false,
    AutoThrowInterval = 0.1,
    AutoSell = false,
    AutoSellInterval = 60,
    AutoBox = false,
    AutoBoxInterval = 0.1,
    AutoTeleport = false,
    AutoTeleportInterval = 2,
    RemoveMap = false,
    teleThread = nil
}

world:AddToggle("AutoGrab", {
     Text = "自动抓",
     Default = main.AutoGrab,
     Callback = function(Value)
 main.AutoGrab = Value
if Value then
startLoop("AutoGrab", function()
game:GetService("Players").LocalPlayer.Character.Events.Grab:FireServer(false,false,false)
end, tonumber(Options.AutoGrabInterval.Value) or 2)
else
stopLoop("AutoGrab")
end
  end
})

world:AddInput("AutoGrabInterval", {
        Default = "2",
        Numeric = true,
        Finished = false,
        ClearTextOnFocus = false,
        Text = "设置抓间隔时间",
        Placeholder = "请输入间隔秒数...",
        Callback = function(Value)
local num = tonumber(Value)
if num then
main.AutoGrabInterval = num
if main.AutoGrab then
stopLoop("AutoGrab")
startLoop("AutoGrab", function()
game:GetService("Players").LocalPlayer.Character.Events.Grab:FireServer(false,false,false)
end, num)
end
end
  end
})

world:AddDivider()

world:AddToggle("AutoEat", {
      Text = "自动吃",
      Default = main.AutoEat,
      Callback = function(Value)
 main.AutoEat = Value
if Value then
startLoop("AutoEat", function()
game:GetService("Players").LocalPlayer.Character.Events.Eat:FireServer()
end, tonumber(Options.AutoEatInterval.Value))
else
stopLoop("AutoEat")
end
  end
})

world:AddInput("AutoEatInterval", {
        Default = "0.1",
        Numeric = true,
        Finished = false,
        ClearTextOnFocus = false,
        Text = "设置吃间隔时间",
        Placeholder = "请输入间隔秒数...",
        Callback = function(Value)
local num = tonumber(Value)
if num then
main.AutoEatInterval = num
if main.AutoEat then
stopLoop("AutoEat")
startLoop("AutoEat", function()
game:GetService("Players").LocalPlayer.Character.Events.Eat:FireServer()
end, num)
end
end
  end
})

world:AddDivider()

world:AddToggle("AutoThrow", {
     Text = "自动扔",
     Default = main.AutoThrow,
     Callback = function(Value)
 main.AutoThrow = Value
if Value then
startLoop("AutoThrow", function()
game:GetService("Players").LocalPlayer.Character.Events.Throw:FireServer()
end, tonumber(Options.AutoThrowInterval.Value))
else
stopLoop("AutoThrow")
end
  end
})

world:AddInput("AutoThrowInterval", {
        Default = "0.1",
        Numeric = true,
        Finished = false,
        ClearTextOnFocus = false,
        Text = "设置扔间隔时间",
        Placeholder = "请输入间隔秒数...",
        Callback = function(Value)
local num = tonumber(Value)
if num then
main.AutoThrowInterval = num
if main.AutoThrow then
stopLoop("AutoThrow")
startLoop("AutoThrow", function()
game:GetService("Players").LocalPlayer.Character.Events.Throw:FireServer()
end, num)
end
end
  end
})

world:AddDivider()

world:AddToggle("AutoBox", {
    Text = "自动领箱子",
    Tooltip = "自动领取箱子1~9号奖励",
    Default = false,
    Callback = function(Value)
        main.AutoBox = Value
        if Value then
            startLoop("AutoBox", function()
                local plr = game:GetService("Players").LocalPlayer
                local event = game:GetService("ReplicatedStorage").Events.RewardEvent
                local rewards = plr:FindFirstChild("TimedRewards")
                if rewards then
                    for i = 1, 9 do
                        local child = rewards:GetChildren()[i]
                        if child then
                            pcall(function()
                                event:FireServer(child)
                            end)
                        end
                    end
                end
            end, tonumber(Options.AutoBoxInterval.Value))
        else
            stopLoop("AutoBox")
        end
    end
})

world:AddInput("AutoBoxInterval", {
        Default = "0.1",
        Numeric = true,
        Finished = false,
        ClearTextOnFocus = false,
        Text = "设置领箱子间隔时间",
        Placeholder = "请输入间隔秒数...",
        Callback = function(Value)
local num = tonumber(Value)
if num then
main.AutoBoxInterval = num
if main.AutoBox then
stopLoop("AutoBox")
startLoop("AutoBox", function()
end, num)
end
end
  end
})

world:AddDivider()

local _LocalPlayer = game:GetService("Players").LocalPlayer

world:AddToggle("AutoTeleport", {
    Text = "自动传送[玻璃屋]",
    Default = main.AutoTele,
    Callback = function(state)
        main.AutoTele = state
        
        if main.teleThread then
            task.cancel(main.teleThread)
            main.teleThread = nil
        end
        
        if state then
            main.teleThread = task.spawn(function()
                -- 玻璃屋地面坐标（全部在地面，无高处）
                local telePoints = {
                    CFrame.new(67.51, 2.62, 49.96),
                    CFrame.new(66.62, 2.62, 27.35),
                    CFrame.new(62.12, 2.62, 11.00),
                    CFrame.new(57.78, 2.62, -3.30),
                    CFrame.new(52.71, 2.62, -17.91),
                    CFrame.new(38.94, 2.62, -35.72),
                    CFrame.new(25.06, 2.62, -46.44),
                    CFrame.new(7.93, 2.62, -58.25),
                    CFrame.new(-13.03, 2.62, -62.51),
                    CFrame.new(-28.29, 2.62, -54.87),
                    CFrame.new(-38.69, 2.62, -48.66),
                    CFrame.new(-56.19, 2.62, -32.02),
                    CFrame.new(-64.64, 2.62, -20.58),
                    CFrame.new(-91.23, 2.62, -12.72),
                    CFrame.new(-116.48, 2.62, -9.31),
                    CFrame.new(-139.50, 2.62, 23.60),
                    CFrame.new(-139.43, 2.62, 55.48),
                    CFrame.new(-137.98, 2.62, 78.55),
                    CFrame.new(-136.70, 2.62, 95.68)
                }
                
                local currentIndex = 1
                
                while main.AutoTele do
                    local character = _LocalPlayer.Character or _LocalPlayer.CharacterAdded:Wait()
                    local hrp = character:FindFirstChild("HumanoidRootPart")
                    
                    if hrp and main.AutoTele then
                        hrp.CFrame = telePoints[currentIndex]
                        currentIndex = currentIndex + 1
                        if currentIndex > #telePoints then
                            currentIndex = 1
                        end
                    end
                    
                    task.wait(Options.AutoTeleportInterval.Value)
                end
            end)
        end
    end
})

world:AddInput("AutoTeleportInterval", {
        Default = "2",
        Numeric = true,
        Finished = false,
        ClearTextOnFocus = false,
        Text = "设置传送间隔时间",
        Placeholder = "请输入间隔秒数...",
        Callback = function(Value)
local num = tonumber(Value)
if num then
main.AutoTeleportInterval = num
if main.AutoTeleport then
stopLoop("AutoTeleport")
startLoop("AutoTeleport", function()
end, num)
end
end
  end
})

world:AddDivider()

world:AddToggle("AFKAntiKick", {
    Text = "AFK🛡️[反挂机踢出]",
    Default = true,
    Callback = function(state)
        if state then
            _LocalPlayer.Idled:Connect(function()
                game:GetService('VirtualUser'):Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
                task.wait(0.1)
                game:GetService('VirtualUser'):Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
            end)
        end
    end,
})

local _LocalPlayer = game:GetService("Players").LocalPlayer
local _TweenService = game:GetService("TweenService")

world:AddToggle("CollectCube", {
    Text = "收集方块",
    Default = false,
    Callback = function(state)
        _G.collectCubes = state
        if state then
            local function GetCube()
                return (_LocalPlayer.Character or _LocalPlayer.CharacterAdded:Wait()):WaitForChild('HumanoidRootPart')
            end
            while _G.collectCubes do
                local v1, v2, v3 = ipairs(workspace:GetChildren())
                while true do
                    local v4
                    v3, v4 = v1(v2, v3)
                    if v3 == nil then
                        break
                    end
                    if v4:IsA('Part') and v4.Name == 'Cube' then
                        _TweenService:Create(v4, TweenInfo.new(0), {
                            Position = GetCube().Position,
                        }):Play()
                    end
                end
                task.wait()
            end
        end
    end
})

world:AddToggle("RemoveMap", {
     Text = "移除地图",
     Default = main.RemoveMap,
     Callback = function(Value)
 main.RemoveMap = Value
if Value then
startLoop("RemoveMap", function()
pcall(function() 
workspace.Map.Buildings:Destroy() 
end)
pcall(function() 
workspace.Map.Fragmentable:Destroy() 
end)
pcall(function() 
workspace.Chunks:Destroy() 
end)
end, 1)
else
stopLoop("RemoveMap")
end
  end
})

local ZZ = Tabs.Main:AddLeftGroupbox('飞行[仅限自己可见]','plane')

local RunService = game:GetService("RunService") --获取玩家操控位置函数
local CFSpeed = 50
local CFLoop = nil
local function StartCFly()
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
end
local function StopCFly()
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

ZZ:AddToggle("CFly", {
    Text = "飞行",
    Default = false,
    Callback = function(Value)
        if Value then
            StartCFly()
        else
            StopCFly()
        end
    end
})

ZZ:AddSlider("CFlySpeed", {
    Text = "飞行速度",
    Default = 50,
    Min = 1,
    Max = 200,
    Rounding = 1,
    Callback = function(Value)
        CFSpeed = Value
    end
})
local AutoSell = Tabs.Main:AddRightGroupbox('自动卖','user')

AutoSell:AddToggle("AutoSell", {
       Text = "自动卖",
       Default = main.AutoSell,
       Callback = function(Value)
 main.AutoSell = Value
if Value then
startLoop("AutoSell", function()
game:GetService("Players").LocalPlayer.Character.Events.Sell:FireServer()
end, tonumber(Options.AutoSellInterval.Value))
else
stopLoop("AutoSell")
end
  end
})

AutoSell:AddInput("AutoSellInterval", {
        Default = "60",
        Numeric = true,
        Finished = false,
        ClearTextOnFocus = false,
        Text = "设置间隔时间",
        Placeholder = "请输入间隔秒数...",
        Callback = function(Value)
local num = tonumber(Value)
if num then
main.AutoSellInterval = num
if main.AutoSell then
stopLoop("AutoSell")
startLoop("AutoSell", function()
game:GetService("Players").LocalPlayer.Character.Events.Sell:FireServer()
end, num)
end
end
  end
})

AutoSell:AddLabel("<b><font color=\"rgb(0, 255, 0)\">1分钟</font></b> = <b><font color=\"rgb(0, 255, 0)\">60秒</font></b>")
AutoSell:AddLabel("<b><font color=\"rgb(0, 255, 0)\">2分钟</font></b> = <b><font color=\"rgb(0, 255, 0)\">120秒</font></b>")
AutoSell:AddLabel("<b><font color=\"rgb(0, 255, 0)\">3分钟</font></b> = <b><font color=\"rgb(0, 255, 0)\">180秒</font></b>")
AutoSell:AddLabel("<b><font color=\"rgb(0, 255, 0)\">4分钟</font></b> = <b><font color=\"rgb(0, 255, 0)\">240秒</font></b>")
AutoSell:AddLabel("<b><font color=\"rgb(0, 255, 0)\">5分钟</font></b> = <b><font color=\"rgb(0, 255, 0)\">300秒</font></b>")

local Shop = Tabs.Main:AddRightGroupbox('商店','store')

local shop = {
     AutoMaxSize = false,
     AutoSpeed = false,
     AutoMultiplier = false,
     AutoEatSpeed = false,
     AutoSmallTokenPack = false,
     AutoMoneyRain = false,
     AutoMediumTokenPack = false,
     AutoLargeTokenPack = false
}

Shop:AddLabel("确保您有这么多钱")

Shop:AddToggle("AutoMaxSize", {
     Text = "自动尺寸",
     Default = shop.AutoMaxSize,
     Callback = function(Value)
 shop.AutoMaxSize = Value
if Value then
startLoop("AutoMaxSize", function()
game:GetService("ReplicatedStorage").Events.PurchaseEvent:FireServer("MaxSize")
end, 1)
else
stopLoop("AutoMaxSize")
end
  end
})

Shop:AddToggle("AutoMaxSize", {
     Text = "自动速度",
     Default = shop.AutoSpeed,
     Callback = function(Value)
 shop.AutoSpeed = Value
if Value then
startLoop("AutoSpeed", function()
game:GetService("ReplicatedStorage").Events.PurchaseEvent:FireServer("Speed")
end, 1)
else
stopLoop("AutoSpeed")
end
  end
})

Shop:AddToggle("AutoMultiplier", {
     Text = "自动尺寸倍速",
     Default = shop.AutoMultiplier,
     Callback = function(Value)
 shop.AutoMultiplier = Value
if Value then
startLoop("AutoMultiplier", function()
game:GetService("ReplicatedStorage").Events.PurchaseEvent:FireServer("Multiplier")
end, 1)
else
stopLoop("AutoMultiplier")
end
  end
})

Shop:AddToggle("AutoEatSpeed", {
     Text = "自动吃速度",
     Default = shop.AutoEatSpeed,
     Callback = function(Value)
 shop.AutoEatSpeed = Value
if Value then
startLoop("AutoEatSpeed", function()
game:GetService("ReplicatedStorage").Events.PurchaseEvent:FireServer("EatSpeed")
end, 1)
else
stopLoop("AutoEatSpeed")
end
  end
})

Shop:AddDivider()

Shop:AddToggle("AutoSmallTokenPack", {
     Text = "自动低重力",
     Default = shop.AutoSmallTokenPack,
     Callback = function(Value)
 shop.AutoSmallTokenPack = Value
if Value then
startLoop("AutoSmallTokenPack", function()
game:GetService("ReplicatedStorage").Events.PurchaseEvent:FireServer("Small Token Pack")
end, 1)
else
stopLoop("AutoSmallTokenPack")
end
  end
})

Shop:AddToggle("AutoMoneyRain", {
     Text = "自动金钱雨",
     Default = shop.AutoMoneyRain,
     Callback = function(Value)
 shop.AutoMoneyRain = Value
if Value then
startLoop("AutoMoneyRain", function()
game:GetService("ReplicatedStorage").Events.PurchaseEvent:FireServer("Money Rain")
end, 1)
else
stopLoop("AutoMoneyRain")
end
  end
})

Shop:AddToggle("AutoMediumTokenPack", {
     Text = "自动机器人",
     Default = shop.AutoMediumTokenPack,
     Callback = function(Value)
 shop.AutoMediumTokenPack = Value
if Value then
startLoop("AutoMediumTokenPack", function()
game:GetService("ReplicatedStorage").Events.PurchaseEvent:FireServer("Medium Token Pack")
end, 1)
else
stopLoop("AutoMediumTokenPack")
end
  end
})

Shop:AddToggle("AutoLargeTokenPack", {
     Text = "自动核弹",
     Default = shop.AutoLargeTokenPack,
     Callback = function(Value)
 shop.AutoLargeTokenPack = Value
if Value then
startLoop("AutoLargeTokenPack", function()
game:GetService("ReplicatedStorage").Events.PurchaseEvent:FireServer("Large Token Pack")
end, 1)
else
stopLoop("AutoLargeTokenPack")
end
  end
})

local player = Tabs.Main:AddRightGroupbox('玩家','user')

local Speedname = 1

player:AddSlider("WalkSpeedSlider", {
    Text = "速度滑块",
    Default = 1,
    Min = 1,
    Max = 15,
    Rounding = 1,
    Compact = false,
    Callback = function(Value)
        Speedname = Value
    end
})

player:AddToggle("EnableWalkSpeed", {
    Text = "启用速度",
    Default = false,
    Callback = function(Value)
        _G.WalkSpeed = Value
        
        if Value then
            spawn(function()
                while _G.WalkSpeed do
                    task.wait()
                    pcall(function()
                        local plr = game.Players.LocalPlayer
                        if not plr or not plr.Character then return end
                        local hum = plr.Character:FindFirstChildWhichIsA("Humanoid")
                        if hum then
                            hum.WalkSpeed = 16 * Speedname
                        end
                    end)
                end
            end)
        end
    end
})

--[[
player:AddSlider("TeleportWalkSpeedSlider", {
    Text = "瞬速滑块",
    Default = 1,
    Min = 1,
    Max = 15,
    Rounding = 1,
    Compact = false,
    Callback = function(Value)
        Speedname = Value

        function Speed()
            spawn(function()
                _G.TeleportWalkSpeed = true

                while _G.TeleportWalkSpeed do
                    wait()
                    pcall(function()
                        while true do
                            task.wait()

                            local _Character2 = game.Players.LocalPlayer.Character
                            local _TranslateBy = _Character2.TranslateBy
                            local _Character3 = game.Players.LocalPlayer.Character

                            if _Character3 then
                                _Character3 = game.Players.LocalPlayer.Character:FindFirstChildWhichIsA('Humanoid').MoveDirection * tonumber(Speedname) * 0.2
                            end

                            _TranslateBy(_Character2, _Character3)

                            if _G.TeleportWalkSpeed == false then
                                wait(1)
                                return
                            end
                        end
                    end)
                end
            end)
        end
    end
})

player:AddToggle("EnableTeleportWalkSpeed", {
    Text = "启用瞬速",
    Default = false,
    Callback = function(Value)
        _G.TeleportWalkSpeed = Value
        
        if Value then
            Speed()
            _G.TeleportWalkSpeed = true
        else
            _G.TeleportWalkSpeed = false
        end
    end
})
--]]

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
SaveManager:SetSubFolder("Eat the world")       
SaveManager:BuildConfigSection(Tabs.Settings)  

ThemeManager:ApplyToTab(Tabs.Settings)

SaveManager:LoadAutoloadConfig()

