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

local Contributor = Tabs.new:AddRightGroupbox('鸣谢&贡献者','handshake')

Contributor:AddLabel("[<b><font color=\"rgb(0, 0, 255)\">JackEyeKL</font></b>] - 脚本所有者")

Contributor:AddLabel("[<b><font color=\"rgb(128, 0, 128)\">Yuxingchen</font></b>] - 提供Nol原脚本终极源码")