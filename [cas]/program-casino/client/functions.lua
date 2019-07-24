


function OpenCasinoCloak()
	PlayerData = ESX.GetPlayerData()
	local elements = {
		{label = "Ubrania Robocze",  value = 'cloakroom'},
		{label = "Ubrania Cywilne", value = "cloakroom2"}
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'CasinoCloak', {
		title    = "Casino Przebieralnia",
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'cloakroom' then

			menu.close()
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				if skin.sex == 0 then
					TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_male)
				else
					TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_female)
				end
			end)

		elseif data.current.value == 'cloakroom2' then

			menu.close()
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				TriggerEvent('skinchanger:loadSkin', skin)
			end)
		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'CasinoCloak'
		CurrentActionMsg  = "~r~[E]~p~ Przebieralnia Kasyna"
		CurrentActionData = {}
	end)

end

