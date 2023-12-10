local function DoProgress(cb, progressData, amount)
    if not amount then amount = 1 end
    if Config.Progress == "qb" then
        QBCore.Functions.Progressbar("wig-crafting-progress", progressData.progressbar,  (progressData.progresstime * amount), false, true, {
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict =  progressData.dictionary,
            anim = progressData.animname,
            flags = 49,
        }, {}, {}, function() -- Done
            cb(true)
        end, function()
            cb(false)
        end)
    else
        if lib.progressCircle({
			duration = (progressData.progresstime * amount),
			label = progressData.progressbar,
			useWhileDead = false,
			canCancel = true,
			disable = {
				car = true,
			},
			position= 'bottom',
			anim = {
				dict = progressData.dictionary,
				clip =  progressData.animname,
			},
		}) then 
			-- ClearPedTasksImmediately(PlayerPedId())
            StopAnimTask(PlayerPedId(), progressData.dictionary, progressData.animname, 1.0)
            cb(true)
		else 
			cb(false)
		end
    end
end

exports('DoProgress', DoProgress)