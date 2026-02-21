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
	Icon = 17261823399,
})

local Tabs = {
    new = Window:AddTab('主持','external-link','公告&信息'),
    Main = Window:AddTab('吃掉','house','这是主要功能的!!!'),
    Settings = Window:AddTab("设置","settings",'设置&调试'),
    --Addons = Window:AddTab("插件","boxes",'这是功能添加!!!'),
}

--Addons = Tabs.Addons:AddLeftGroupbox('插件&附加','blocks')

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
    teleportThread = nil,
    RemoveMap = false
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
end, tonumber(Options.AutoEatInterval.Value) or 0.1)
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
end, tonumber(Options.AutoThrowInterval.Value) or 0.1)
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
            end, tonumber(Options.AutoBoxInterval.Value) or 0.1)
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
    Text = "自动传送",
    Default = main.AutoTeleport,
    Callback = function(state)
        main.AutoTeleport = state
        
        if main.teleportThread then
            task.cancel(main.teleportThread)
            main.teleportThread = nil
        end
        
        if state then
            main.teleportThread = task.spawn(function()
                local teleportPoints = {
                    CFrame.new(67.5105209350586, 2.617709159851074, 49.95643615722656),
                    CFrame.new(66.61660766601562, 2.617709159851074, 27.347152709960938),
                    CFrame.new(62.12251281738281, 2.617709159851074, 11.004171371459961),
                    CFrame.new(57.77750778198242, 2.617709159851074, -3.3018038272857666),
                    CFrame.new(52.71255874633789, 2.617709159851074, -17.906509399414062),
                    CFrame.new(38.93976593017578, 2.617709159851074, -35.72473907470703),
                    CFrame.new(25.061079025268555, 2.617709159851074, -46.44431686401367),
                    CFrame.new(7.925309658050537, 2.617709159851074, -58.25339889526367),
                    CFrame.new(-13.032307624816895, 2.617709159851074, -62.51304626464844),
                    CFrame.new(-28.29254150390625, 2.617709159851074, -54.87309265136719),
                    CFrame.new(-56.19231414794922, 2.617709159851074, -32.02164840698242),
                    CFrame.new(-64.64066314697266, 2.617709159851074, -20.583925247192383),
                    CFrame.new(-91.2260513305664, 2.617709159851074, -12.719565391540527),
                    CFrame.new(-116.47618103027344, 2.6177096366882324, -9.312110900878906),
                    CFrame.new(-139.49990844726562, 2.6177096366882324, 23.60348892211914),
                    CFrame.new(-139.42808532714844, 2.6177096366882324, 55.475135803222656),
                    CFrame.new(-137.9814453125, 2.6177096366882324, 78.55432891845703),
                    CFrame.new(-136.70278930664062, 2.6177096366882324, 95.68263244628906),
                    CFrame.new(-38.68806838989258, 2.617709159851074, -48.66199493408203)
                }
                
                local currentIndex = 1
                
                while main.AutoTeleport do
                    local character = _LocalPlayer.Character or _LocalPlayer.CharacterAdded:Wait()
                    local hrp = character:FindFirstChild("HumanoidRootPart")
                    
                    if hrp and main.AutoTeleport then
                        hrp.CFrame = teleportPoints[currentIndex]
                        currentIndex = currentIndex + 1
                        if currentIndex > #teleportPoints then
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

-- 存储反AFK的连接对象，用于关闭时断开
local afkConnection = nil

world:AddToggle("AFKAntiKick", {
    Text = "反AFK🛡️[反挂机踢出]",
    Default = false,
    Callback = function(state)
        -- 开启功能
        if state then
            -- 防止重复绑定事件
            if afkConnection then return end

            -- 当玩家挂机（ idle ）时，自动模拟点击，避免被系统踢出
            afkConnection = _LocalPlayer.Idled:Connect(function()
                -- 模拟鼠标右键按下
                game:GetService("VirtualUser"):Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
                task.wait(0.1)
                -- 模拟鼠标右键松开
                game:GetService("VirtualUser"):Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
            end)

        -- 关闭功能
        else
            -- 如果有绑定的事件，就断开连接，停止反AFK
            if afkConnection then
                afkConnection:Disconnect()
                afkConnection = nil
            end
        end
    end
})


local _LocalPlayer = game:GetService("Players").LocalPlayer
local _TweenService = game:GetService("TweenService")

world:AddToggle("CollectCube", {
    Text = "吸附方块",
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
workspace.Map.Fragmentable:Destroy()
workspace.Chunks:Destroy() 
end)
end, 1)
else
showMap = Value
  end
end
})

-- 安全获取 LocalPlayer
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer or Players.PlayerAdded:Wait()

world:AddToggle("AutoFarm", {
    Text = "自动农场",
    Default = false,
    Callback = function(enabled)
        autofarm = enabled
        
        if not autofarm then
            return
        end

        coroutine.wrap(function()
            -- 先补全缺失的函数定义，避免报错
            local function sizeGrowth(maxSize)
                -- 假设 sizeGrowth 是计算大小增长的函数，这里给一个合理的默认实现
                return maxSize * 100 -- 可根据实际游戏逻辑修改
            end

            local function changeMap()
                -- 切换地图/区块的核心逻辑，这里是一个空实现，你可以根据游戏实际情况补充
                -- 例如：重新生成区块、重置位置、重新开始循环等
                print("切换地图/区块")
            end

            local text = Drawing.new("Text")
            text.Outline = true
            text.OutlineColor = Color3.new(0, 0, 0)
            text.Color = Color3.new(1, 1, 1)
            text.Center = false
            text.Position = Vector2.new(64, 64)
            text.Text = ""
            text.Size = 14
            text.Visible = true
            
            local startTime = tick()
            local eatTime = 0
            local lastEatTime = tick()
            
            local timer = 0
            local grabTimer = 0
            local sellDebounce = false
            local sellCount = 0
            
            local bedrock = Instance.new("Part")
            bedrock.Anchored = true
            bedrock.Size = Vector3.new(2048, 10, 2048)
            bedrock.Position = Vector3.new(0, -5, 0)
            -- bedrock.Transparency = 1
            bedrock.BrickColor = BrickColor.Black()
            bedrock.Parent = workspace

            local map, chunks = workspace:FindFirstChild("Map"), workspace:FindFirstChild("Chunks")
            if map and chunks then
                map.Parent, chunks.Parent = nil, nil
            end

            local numChunks = 0
            
            local hum,
                root,
                size,
                events,
                eat,
                grab,
                sell,
                sendTrack,
                chunk,
                radius,
                autoConn,
                sizeConn,
                charAddConn
            
            local function onCharAdd(char)
                numChunks = 0
                
                hum = char:WaitForChild("Humanoid")
                root = char:WaitForChild("HumanoidRootPart")
                size = char:WaitForChild("Size")
                events = char:WaitForChild("Events")
                eat = events:WaitForChild("Eat")
                grab = events:WaitForChild("Grab")
                sell = events:WaitForChild("Sell")
                chunk = char:WaitForChild("CurrentChunk")
                sendTrack = char:WaitForChild("SendTrack")
                radius = char:WaitForChild("Radius")
                
                -- 断开旧连接，避免重复连接
                if autoConn then
                    autoConn:Disconnect()
                end
                autoConn = game["Run Service"].Heartbeat:Connect(function(dt)
                    if not autofarm then
                        autoConn:Disconnect()
                        return
                    end
                    
                    -- 空值检查，防止角色消失后报错
                    if not hum or not root or not size or not eat or not grab or not sell or not sendTrack or not chunk or not radius then
                        return
                    end
                    
                    local ran = tick() - startTime
                    local hours = math.floor(ran / 60 / 60)
                    local minutes = math.floor(ran / 60)
                    local seconds = math.floor(ran)
                    
                    local eatMinutes = math.floor(eatTime / 60)
                    local eatSeconds = math.floor(eatTime)
                    
                    local y = bedrock.Position.Y + bedrock.Size.Y / 2 + hum.HipHeight + root.Size.Y / 2

                    -- 空值检查，防止升级模块不存在报错
                    local maxSizeUpgrade = LocalPlayer.Upgrades and LocalPlayer.Upgrades.MaxSize and LocalPlayer.Upgrades.MaxSize.Value or 100
                    local multiplierUpgrade = LocalPlayer.Upgrades and LocalPlayer.Upgrades.Multiplier and LocalPlayer.Upgrades.Multiplier.Value or 1
                    local sizeAdd = multiplierUpgrade / 100
                    local addAmount = maxSizeUpgrade / sizeAdd
                    
                    local sellTime = addAmount / 2
                    local sellMinutes = math.floor(sellTime / 60)
                    local sellSeconds = math.floor(sellTime)
                    
                    local secondEarn = math.floor(sizeGrowth(maxSizeUpgrade) / sellTime)
                    local minuteEarn = secondEarn * 60
                    local hourEarn = minuteEarn * 60
                    local dayEarn = hourEarn * 24
                    
                    text.Text = ""
                        .. "\n运行时间: " .. string.format("%ih%im%is", hours, minutes % 60, seconds % 60)
                        .. "\n实际时间: " .. string.format("%im%is", eatMinutes % 60, eatSeconds % 60)
                        .. "\n大约吃完: " .. string.format("%im%is", sellMinutes % 60, sellSeconds % 60)
                        .. "\n吃掉方块: " .. numChunks
                    
                    hum:ChangeState(Enum.HumanoidStateType.Physics)
                    grab:FireServer()
                    root.Anchored = false
                    eat:FireServer()
                    sendTrack:FireServer()
                    
                    if chunk.Value then
                        if timer > 0 then
                            numChunks += 1
                        end
                        timer = 0
                        grabTimer += dt
                    else
                        timer += dt
                        grabTimer = 0
                    end
                    
                    if timer > 60 then
                        hum.Health = 0
                        timer = 0
                        numChunks = 0
                    end
                    
                    if grabTimer > 15 then
                        size.Value = maxSizeUpgrade
                    end
                    
                    if (size.Value >= maxSizeUpgrade) or timer > 8 then
                        if timer < 8 then
                            sell:FireServer()
                            
                            if not sellDebounce then
                                changeMap()
                            end
                            
                            sellDebounce = true
                        else
                            changeMap()
                        end
                        numChunks = 0
                    elseif size.Value == 0 then
                        if sellDebounce then
                            local currentEatTime = tick()
                            eatTime = currentEatTime - lastEatTime
                            lastEatTime = currentEatTime
                            
                            sellCount += 1
                        end
                        sellDebounce = false
                    end
                    
                    -- 空值检查，防止 radius 不存在报错
                    local farmMoving = false -- 这里根据你的需求设置为 true/false
                    if farmMoving then
                        local bound = 300
                        local startPos = CFrame.new(-bound/2, y, -bound/2)
                        
                        local r = radius.Value * 1.1
                        local dist = (r * numChunks)
                        local x = dist % bound
                        local z = math.floor(dist / bound) * r
                        local offset = CFrame.new(x, 0, z + r * 2)
                        
                        if z > bound then
                            changeMap()
                            numChunks = 0
                        end
                        
                        root.CFrame = startPos * offset
                    else
                        root.CFrame = CFrame.new(0, y, 0)
                    end
                end)
                
                hum.Died:Connect(function()
                    if autoConn then
                        autoConn:Disconnect()
                    end
                    changeMap()
                end)
                
                -- 空值检查，防止脚本不存在报错
                local localChunkManager = char:FindFirstChild("LocalChunkManager")
                if localChunkManager then
                    localChunkManager.Enabled = false
                end
                local animate = char:FindFirstChild("Animate")
                if animate then
                    animate.Enabled = false
                end
            end
            
            -- 安全处理角色
            local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
            if char then
                task.spawn(onCharAdd, char)
            end
            charAddConn = LocalPlayer.CharacterAdded:Connect(onCharAdd)
            
            while autofarm do
                local dt = task.wait()
                local loading = workspace:FindFirstChild("Loading")
                if loading then
                    loading:Destroy()
                end
                if map and chunks then
                    local showMap = false -- 这里根据你的需求设置为 true/false
                    if showMap then
                        map.Parent, chunks.Parent = workspace, workspace
                    else
                        map.Parent, chunks.Parent = nil, nil
                    end
                end
            end
            
            -- 清理资源
            if charAddConn then
                charAddConn:Disconnect()
            end
            if autoConn then
                autoConn:Disconnect()
            end
            if map and chunks then
                map.Parent, chunks.Parent = workspace, workspace
            end
            if hum then
                hum:ChangeState(Enum.HumanoidStateType.GettingUp)
            end
            bedrock:Destroy()
            -- 安全恢复角色脚本
            local endChar = LocalPlayer.Character
            if endChar then
                local localChunkManager = endChar:FindFirstChild("LocalChunkManager")
                if localChunkManager then
                    localChunkManager.Enabled = true
                end
                local animate = endChar:FindFirstChild("Animate")
                if animate then
                    animate.Enabled = true
                end
            end
            text:Destroy()
        end)()
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
local AutoSell = Tabs.Main:AddRightGroupbox('自动卖','wand')

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

-- 普通移动速度变量
local Speedname = 1

-- 普通移动速度滑块
player:AddSlider("WalkSpeedSlider", {
    Text = "速度滑块",
    Default = 1,
    Min = 1,
    Max = 15,
    Rounding = 1,
    Compact = false,
    Callback = function(Value)
        -- 滑块值改变时，更新速度变量
        Speedname = Value
    end
})

-- 普通移动速度开关
player:AddToggle("EnableWalkSpeed", {
    Text = "启用速度",
    Default = false,
    Callback = function(Value)
        _G.WalkSpeed = Value
        
        if Value then
            spawn(function()
                -- 开启时持续设置人物移动速度
                while _G.WalkSpeed do
                    task.wait()
                    pcall(function()
                        local plr = game.Players.LocalPlayer
                        if not plr or not plr.Character then return end
                        local hum = plr.Character:FindFirstChildWhichIsA("Humanoid")
                        if hum then
                            -- 基础速度16 × 滑块倍数
                            hum.WalkSpeed = 16 * Speedname
                        end
                    end)
                end
            end)
        end
    end
})

-- 瞬移速度变量（注意：和上面共用 Speedname，会互相覆盖）
local Speedname = 1

-- 瞬移速度滑块
player:AddSlider("TeleportWalkSpeedSlider", {
    Text = "瞬速滑块",
    Default = 1,
    Min = 1,
    Max = 15,
    Rounding = 1,
    Compact = false,
    Callback = function(Value)
        -- 修改瞬移速度变量
        Speedname = Value
    end
})

local speedLoopRunning = false

-- 瞬移移动函数
local function Speed()
    -- 防止重复开启循环
    if speedLoopRunning then return end
    speedLoopRunning = true

    spawn(function()
        -- 开启状态下持续执行瞬移位移
        while _G.TeleportWalkSpeed do
            task.wait()
            pcall(function()
                local plr = game:GetService("Players").LocalPlayer
                local char = plr.Character
                if not char then return end

                local hum = char:FindFirstChildWhichIsA("Humanoid")
                if not hum then return end

                local root = char:FindFirstChild("HumanoidRootPart")
                if not root then return end

                local dir = hum.MoveDirection
                -- 有人物移动输入时才位移
                if dir.Magnitude > 0 then
                    root.CFrame = root.CFrame + dir * Speedname * 0.2
                end
            end)
        end
        speedLoopRunning = false
    end)
end

player:AddToggle("EnableTeleportSpeed", {
    Text = "启用瞬速",
    Default = false,
    Callback = function(Value)
        -- 设置全局开关状态
        _G.TeleportWalkSpeed = Value
        -- 开启时启动速度功能
        if Value then
            Speed()
        end
    end
})

-- 获取角色默认跳跃力，若角色未加载则使用 50 作为默认值
local defaultJumpPower = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character.Humanoid.JumpPower or 50

-- 初始化跳跃高度变量，使用默认跳跃力，避免一开始跳不高
local JumpPower = defaultJumpPower

-- 跳跃高度调节滑块
player:AddSlider("JumpHeightSlider", {
    Text = "跳跃高度滑块",
    Default = defaultJumpPower,
    Min = defaultJumpPower,
    Max = 500,
    Rounding = 1,
    Compact = false,
    Callback = function(Value)
        -- 滑块数值改变时，同步更新跳跃高度变量
        JumpPower = Value
    end
})

-- 跳跃循环运行标记，防止重复开循环
local JumpLoopRunning = false

-- 跳跃高度主功能函数
local function Jump()
    -- 如果循环已经在运行，直接退出，避免重复启动
    if JumpLoopRunning then return end
    JumpLoopRunning = true

    -- 新开一个线程运行循环，不阻塞主线程
    spawn(function()
        -- 当 _G.JumpHeight 为 true 时持续运行
        while _G.JumpHeight do
            task.wait()
            -- 包裹 pcall 防止角色未加载报错
            pcall(function()
                local plr = game:GetService("Players").LocalPlayer
                local char = plr.Character
                -- 角色不存在则跳过
                if not char then return end

                local hum = char:FindFirstChildWhichIsA("Humanoid")
                -- 人形对象不存在则跳过
                if not hum then return end

                -- 实时设置跳跃力为滑块的值
                hum.JumpPower = JumpPower
            end)
        end

        -- 循环结束（关闭功能）时，恢复默认跳跃力
        pcall(function()
            local plr = game:GetService("Players").LocalPlayer
            local char = plr.Character
            if char then
                local hum = char:FindFirstChildWhichIsA("Humanoid")
                if hum then
                    hum.JumpPower = defaultJumpPower
                end
            end
        end)

        -- 循环结束，重置运行标记
        JumpLoopRunning = false
    end)
end

-- 跳跃高度功能开关
player:AddToggle("EnableJumpHeight", {
    Text = "启用跳跃高度",
    Default = false,
    Callback = function(Value)
        -- 设置全局开关状态
        _G.JumpHeight = Value
        -- 开启时启动跳跃功能
        if Value then
            Jump()
        end
    end
})

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
SaveManager:SetSubFolder("Eat the world")       
SaveManager:BuildConfigSection(Tabs.Settings)  

ThemeManager:ApplyToTab(Tabs.Settings)

SaveManager:LoadAutoloadConfig()

