local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}
local PlayerData = {}
local playerPed = PlayerPedId()
local HasAlreadyEnteredMarker = false
local isDead = false
local hasAlreadyJoined = false
local CurrentAction = nil
local CurrentActionMsg  = ''
local CurrentActionData = {}
local society = 'casino'
local LastStation, LastPart, LastPartNum, LastEntity
local isInShopMenu = {}, false
local isBlackStarted=false
local game = false
local platiniumTicket = false
local goldTicket = false
local classicTicket = false
local blips = {
	{title="State Casino", colour=81, id=490, x = 930.17, y = 41.8, z = 37.3}
}


ESX = nil


Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()

end)





Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

			if IsControlJustReleased(0, Keys['F6']) and not isDead and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'casino_actions') and PlayerData.job ~= nil and PlayerData.job.name == 'casino' then
				OpenCasinoActionsMenu()
			end
			if CurrentAction then
				ESX.ShowHelpNotification(CurrentActionMsg)
				if IsControlJustReleased(0, Keys['E']) and PlayerData.job ~= nil and PlayerData.job.name == 'casino' then
					if CurrentAction == 'casino_mgmt' then
						OpenCasinoActionsMenu()
					elseif CurrentAction == 'CasinoCloak' then
						OpenCasinoCloak()
					elseif CurrentAction == 'CasinoBar' and PlayerData.job ~= nil and PlayerData.job.name == 'casino' then
						OpenBarMenu()
					elseif CurrentAction == 'CasinoFridge' and PlayerData.job ~= nil and PlayerData.job.name == 'casino' then
						OpenGetFridgeStocksMenu()
					end
				end
			end
	end
end)



Citizen.CreateThread(function()
	Citizen.Wait(1000)
    for _, info in pairs(blips) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 1.5)
      SetBlipColour(info.blip, info.colour)
      SetBlipAsShortRange(info.blip, true)
	  BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
    end
end)


-- Enter / Exit marker events
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)

		if PlayerData.job and PlayerData.job.name == 'casino' then

			local coords      = GetEntityCoords(PlayerPedId())
			local isInMarker  = false
			local currentZone = nil

			for k,v in pairs(Config.CasinoSites) do
				if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
					isInMarker  = true
					currentZone = k
				end
			end

			if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
				HasAlreadyEnteredMarker = true
				LastZone                = currentZone
				TriggerEvent('program-casino:hasEnteredMarker', currentZone)
			end

			if not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('program-casino:hasExitedMarker', LastZone)
			end

		end
	end
end)


--Show markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if PlayerData.job and PlayerData.job.name == 'casino' then
			local coords, letSleep = GetEntityCoords(PlayerPedId()), true

			for k,v in pairs(Config.CasinoSites) do
				if v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance then
					DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, nil, nil, false)
					letSleep = false
				end
			end

			if letSleep then
				Citizen.Wait(2000)
			end
		else
			Citizen.Wait(2000)
		end
	end
end)



	-------------------------------------------------------Poczatek TP
positions = {
    {{930.11, 41.24, 80.7, 0}, {907.26, -942.96, 44.2, 0}},} --
	local player = GetPlayerPed(-1)
Citizen.CreateThread(function ()
	while true do
		Citizen.Wait(5)
		local player = GetPlayerPed(-1)
		local playerLoc = GetEntityCoords(player)
		for i,location in ipairs(positions) do
			teleport_text = location[3]
			loc1 = {
				x=location[1][1],
				y=location[1][2],
				z=location[1][3],
				heading=location[1][4]
			}
			loc2 = {
				x=location[2][1],
				y=location[2][2],
				z=location[2][3],
				heading=location[2][4]
			}

			DrawMarker(29, loc1.x, loc1.y, loc1.z+0.5, 0, 0, 0, 0, 0, 0, 1.501, 1.5001, 1.5001, 0, 0, 255, 200, 1, 1, 0, 0)
			DrawMarker(29, loc2.x, loc2.y, loc2.z+0.5, 0, 0, 0, 0, 0, 0, 1.501, 1.5001, 1.5001, 0, 0, 255, 200, 1, 1, 0, 0)

			if CheckPos(playerLoc.x, playerLoc.y, playerLoc.z, loc1.x, loc1.y, loc1.z, 2) then
				alert("Wejdź do centrum kasyna")

				if IsControlJustReleased(1, 38) then
					if IsPedInAnyVehicle(player, true) then
						PlayerData = ESX.GetPlayerData()
						local elements = {
							{label = "ClassicTicket",  value = 'classicTicket'},
							{label = "GoldTicket",  value = 'goldTicket'},
							{label = "PlatiniumTicket", value = "platiniumTicket"},
							{label = "Bramka Pracownicza", value = "worker"}
						}

						ESX.UI.Menu.CloseAll()

						ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'CasinoCloak', {
							title    = "Casino Bramka",
							align    = 'center',
							elements = elements
						}, function(data, menu)
							if data.current.value == 'classicTicket' then
								menu.close()
								SetEntityCoords(GetVehiclePedIsUsing(player), loc2.x, loc2.y, loc2.z)
								SetEntityHeading(GetVehiclePedIsUsing(player), loc2.heading)
								classicTicket = true
							elseif data.current.value == 'goldTicket' then
								menu.close()
								SetEntityCoords(GetVehiclePedIsUsing(player), loc2.x, loc2.y, loc2.z)
								SetEntityHeading(GetVehiclePedIsUsing(player), loc2.heading)
								goldTicket = true
							elseif data.current.value == 'platiniumTicket' then
								menu.close()
								SetEntityCoords(GetVehiclePedIsUsing(player), loc2.x, loc2.y, loc2.z)
								SetEntityHeading(GetVehiclePedIsUsing(player), loc2.heading)
								platiniumTicket = true
							elseif data.current.value == 'worker' then
								if PlayerData.job.name=='casino' then
									menu.close()
									SetEntityCoords(player, loc2.x, loc2.y, loc2.z)
									SetEntityHeading(player, loc2.heading)
								else
									menu.close()
									ESX.ShowNotification('~r~Nie jesteś pracownikiem Kasyna')
								end
							end

						end, function(data, menu)
							menu.close()

							CurrentAction     = ''
							CurrentActionMsg  = ""
							CurrentActionData = {}
						end)
					else
						PlayerData = ESX.GetPlayerData()
						local elements = {
							{label = "Classic Ticket ["..Config.classicPrice.."$]",  value = 'classicTicket'},
							{label = "Gold Ticket ["..Config.goldenPrice.."$]",  value = 'goldTicket'},
							{label = "Platinium Ticket ["..Config.platiniumPrice.."$]", value = "platiniumTicket"},
							{label = "Bramka Pracownicza", value = "worker"}
						}

						ESX.UI.Menu.CloseAll()

						ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'CasinoCloak', {
							title    = "Casino Bramka",
							align    = 'center',
							elements = elements
						}, function(data, menu)
							if data.current.value == 'classicTicket' then
								ESX.TriggerServerCallback('program-casino:checkMoney', function(result)
									if result>=Config.classicPrice then
										SetEntityCoords(player, loc2.x, loc2.y, loc2.z)
										SetEntityHeading(player, loc2.heading)
										classicTicket = true
										TriggerServerEvent('program-casino:removeMoney',Config.classicPrice)
									else
										ESX.ShowNotification('~r~Nie masz wysarczająco pieniędzy')
									end
								end)
								menu.close()
								wyzeruj()
							elseif data.current.value == 'goldTicket' then
								menu.close()
								ESX.TriggerServerCallback('program-casino:checkMoney', function(result)
									if result>=Config.goldenPrice then
										SetEntityCoords(player, loc2.x, loc2.y, loc2.z)
										SetEntityHeading(player, loc2.heading)
										goldTicket = true
										TriggerServerEvent('program-casino:removeMoney',Config.goldenPrice)
									else
										ESX.ShowNotification('~r~Nie masz wysarczająco pieniędzy')
									end
								end)
								wyzeruj()
							elseif data.current.value == 'platiniumTicket' then
								menu.close()
								ESX.TriggerServerCallback('program-casino:checkMoney', function(result)
									if result>=Config.platiniumPrice then
										SetEntityCoords(player, loc2.x, loc2.y, loc2.z)
										SetEntityHeading(player, loc2.heading)
										platiniumTicket = true
										TriggerServerEvent('program-casino:removeMoney',Config.platiniumPrice)
										TriggerServerEvent('program-casino:sendPlatinium')
									else
										ESX.ShowNotification('~r~Nie masz wysarczająco pieniędzy')
									end
								end)
								wyzeruj()
							elseif data.current.value == 'worker' then
								if PlayerData.job.name=='casino' then
									menu.close()
									SetEntityCoords(player, loc2.x, loc2.y, loc2.z)
									SetEntityHeading(player, loc2.heading)
								else
									menu.close()
									ESX.ShowNotification('~r~Nie jesteś pracownikiem Kasyna')
								end
								wyzeruj()
							end

						end, function(data, menu)
							menu.close()

							CurrentAction     = ''
							CurrentActionMsg  = ""
							CurrentActionData = {}
						end)
					end
				end

			elseif CheckPos(playerLoc.x, playerLoc.y, playerLoc.z, loc2.x, loc2.y, loc2.z, 2) then
				alert("Wyjdź z centrum kasyna")

				if IsControlJustReleased(1, 38) then
					if IsPedInAnyVehicle(player, true) then
						SetEntityCoords(GetVehiclePedIsUsing(player), loc1.x, loc1.y, loc1.z)
						SetEntityHeading(GetVehiclePedIsUsing(player), loc1.heading)
						platiniumTicket = false
						TriggerServerEvent('program-casino:sendOffPlatinium')
						goldTicket = false
						classicTicket = false
						wyzeruj()
					else
						SetEntityCoords(player, loc1.x, loc1.y, loc1.z)
						SetEntityHeading(player, loc1.heading)
						platiniumTicket = false
						TriggerServerEvent('program-casino:sendOffPlatinium')
						goldTicket = false
						classicTicket = false
						wyzeruj()
					end
				end
			end
		end
	end
end)

function wyzeruj()
	CurrentAction     = ''
	CurrentActionMsg  = ""
	CurrentActionData = {}
end

AddEventHandler('program-casino:hasEnteredMarker', function(zone)
	if zone =='CasinoActions' then
		CurrentAction     = 'casino_mgmt'
		CurrentActionMsg  = "~r~[E] ~b~Otworz menu zarządzania kasynem"
		CurrentActionData = {}
	elseif zone == "CasinoCloak" then
		CurrentAction     = 'CasinoCloak'
		CurrentActionMsg  = "~r~[E] ~p~Przebieralnia Kasyna"
		CurrentActionData = {}
	elseif zone == "CasinoFridge" then
		CurrentAction     = 'CasinoFridge'
		CurrentActionMsg  = "~r~[E] ~p~Lodówka"
		CurrentActionData = {}
	elseif zone == "CasinoBar" then
		CurrentAction     = 'CasinoBar'
		CurrentActionMsg  = "~r~[E] ~p~Bar"
		CurrentActionData = {}
	end
end)

AddEventHandler('program-casino:hasExitedMarker', function(zone)
	CurrentAction = nil
	ESX.UI.Menu.CloseAll()
end)

	function CheckPos(x, y, z, cx, cy, cz, radius)
		local t1 = x - cx
		local t12 = t1^2

		local t2 = y-cy
		local t21 = t2^2

		local t3 = z - cz
		local t31 = t3^2

		return (t12 + t21 + t31) <= radius^2
	end

	function alert(msg)
		SetTextComponentFormat("STRING")
		AddTextComponentString(msg)
		DisplayHelpTextFromStringLabel(0,0,1,-1)
	end

	-------------------------------------------------------Koniec TP
	AddEventHandler('esx:onPlayerDeath', function(data)
		isDead = true
	end)

	AddEventHandler('playerSpawned', function(spawn)
		isDead = false
	end)

RegisterNetEvent('program-casino:openTicketMenuClient')
AddEventHandler('program-casino:openTicketMenuClient', function(worker)
	print(worker)
	local elements = {
		{label = "Nie pokazuj",  value = 'notShow'}
	}
	if goldTicket then
		table.insert(elements, {label = "Pokaż złoty bilet", value = 'showGolden'})
	end
	if platiniumTicket then
		table.insert(elements, {label = "Pokaż Platynowy bilet", value = 'showPlatinium'})
	end
	if classicTicket then
		table.insert(elements, {label = "Pokaż bilet", value = 'showClassic'})
	end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'pokazTicket', {
		title    = "Casino",
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'notShow' then

		elseif data.current.value == 'showGolden' then
			TriggerServerEvent('program-casino:sendTicket', "Klient posiada złoty bilet", worker)
		elseif data.current.value == 'showPlatinium' then
			TriggerServerEvent('program-casino:sendTicket', "Klient posiada platynowy bilet", worker)
		elseif data.current.value == 'showClassic' then
			TriggerServerEvent('program-casino:sendTicket', "Klient posiada klasyczny bilet", worker)
		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = ''
		CurrentActionMsg  = ""
		CurrentActionData = {}
	end)
end)


function OpenCasinoActionsMenu()
	PlayerData = ESX.GetPlayerData()
	local elements = {
		{label = "Popros o bilet",  value = 'ticket'}
	}
	if PlayerData.job.grade_name == 'boss' then
	 	table.insert(elements, {label = "Akcje szefa", value = 'boss_actions'})
	end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'casino_mgmt', {
		title    = "Casino",
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'ticket' then
			local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
			print(GetPlayerServerId(closestPlayer))
			if closestPlayer ~= -1 and closestDistance <= 3.0 then
				TriggerServerEvent('program-casino:openTicketMenu', GetPlayerServerId(closestPlayer), GetPlayerServerId(playerPed))
			else
				ESX.ShowNotification('~r~Nie ma nikogo w pobliżu')
			end
		elseif data.current.value == 'boss_actions' then
			TriggerEvent('esx_society:openBossMenu', 'casino', function (data, menu)
				menu.close()
			end, {wash = true})
		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = ''
		CurrentActionMsg  = ""
		CurrentActionData = {}
	end)

end

function OpenBarMenu()
	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'menu_crafting',
		{
			title = "Drinki",
			align = 'center',
			elements = {
				{label = 'JagerBomba',     value = 'jagerbomb'},
				{label = 'Golem',         value = 'golem'},
				{label = 'Whiskycoca',    value = 'whiskycoca'},
				{label = 'Vodkaenergy',   value = 'vodkaenergy'},
				{label = 'Vodkafruit',    value = 'vodkafruit'},
				{label = 'Rumfruit',     value = 'rhumfruit'},
				{label = 'Teqpaf',        value = 'teqpaf'},
				{label = 'Rumcoca',      value = 'rhumcoca'},
				{label = 'Mojito',        value = 'mojito'},
				{label = 'Mixapero',      value = 'mixapero'},
				{label = 'Metreshooter',  value = 'metreshooter'},
				{label = 'Jagercerbere',  value = 'jagercerbere'},
			}
		},
		function(data2, menu2)
			  
		    TriggerServerEvent('program-casino:craftingCoktails', data2.current.value)
			animsAction({ lib = "mini@drinking", anim = "shots_barman_b" })
		
			end,
			function(data2, menu2)
				menu2.close()
			end
		)
end


function OpenGetFridgeStocksMenu()

	ESX.TriggerServerCallback('program-casino:getFridgeStockItems', function(items)
  
		print(json.encode(items))
  
	  local elements = {}
  
	  for i=1, #items, 1 do
		table.insert(elements, {label = 'x' .. items[i].count .. ' ' .. items[i].label, value = items[i].name})
	  end
  
	  ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'fridge_menu',
		{
		  title    = "Lodówka",
		  elements = elements
		},
		function(data, menu)
  
		  local itemName = data.current.value
  
		  ESX.UI.Menu.Open(
			'dialog', GetCurrentResourceName(), 'fridge_menu_get_item_count',
			{
			  title = "Ilość"
			},
			function(data2, menu2)
  
			  local count = tonumber(data2.value)
  
			  if count == nil then
				ESX.ShowNotification("Zła ilość")
			  else
				menu2.close()
				menu.close()
				OpenGetStocksMenu()
  
				TriggerServerEvent('program-casino:getFridgeStockItem', itemName, count)
			  end
  
			end,
			function(data2, menu2)
			  menu2.close()
			end
		  )
  
		end,
		function(data, menu)
		  menu.close()
		end
	  )
  
	end)
  
  end



  

function animsAction(animObj)
    Citizen.CreateThread(function()
        if not playAnim then
            local playerPed = GetPlayerPed(-1);
            if DoesEntityExist(playerPed) then -- Check if ped exist
                dataAnim = animObj

                -- Play Animation
                RequestAnimDict(dataAnim.lib)
                while not HasAnimDictLoaded(dataAnim.lib) do
                    Citizen.Wait(0)
                end
                if HasAnimDictLoaded(dataAnim.lib) then
                    local flag = 0
                    if dataAnim.loop ~= nil and dataAnim.loop then
                        flag = 1
                    elseif dataAnim.move ~= nil and dataAnim.move then
                        flag = 49
                    end

                    TaskPlayAnim(playerPed, dataAnim.lib, dataAnim.anim, 8.0, -8.0, -1, flag, 0, 0, 0, 0)
                    playAnimation = true
                end

                -- Wait end animation
                while true do
                    Citizen.Wait(0)
                    if not IsEntityPlayingAnim(playerPed, dataAnim.lib, dataAnim.anim, 3) then
                        playAnim = false
                        TriggerEvent('ft_animation:ClFinish')
                        break
                    end
                end
            end -- end ped exist
        end
    end)
end

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job

	Citizen.Wait(5000)
end)

function OpenGetStocksMenu()

	ESX.TriggerServerCallback('esx_unicornjob:getStockItems', function(items)
  
	  print(json.encode(items))
  
	  local elements = {}
  
	  for i=1, #items, 1 do
		table.insert(elements, {label = 'x' .. items[i].count .. ' ' .. items[i].label, value = items[i].name})
	  end
  
	  ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'stocks_menu',
		{
		  title    = "Casino",
		  elements = elements
		},
		function(data, menu)
  
		  local itemName = data.current.value
  
		  ESX.UI.Menu.Open(
			'dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count',
			{
			  title = _U('quantity')
			},
			function(data2, menu2)
  
			  local count = tonumber(data2.value)
  
			  if count == nil then
				ESX.ShowNotification(_U('invalid_quantity'))
			  else
				menu2.close()
				menu.close()
				OpenGetStocksMenu()
  
				TriggerServerEvent('program-casino:getStockItem', itemName, count)
			  end
  
			end,
			function(data2, menu2)
			  menu2.close()
			end
		  )
  
		end,
		function(data, menu)
		  menu.close()
		end
	  )
  
	end)
  
end


function OpenGetStocksMenu()

	ESX.TriggerServerCallback('program-casino:getStockItems', function(items)
  
	  print(json.encode(items))
  
	  local elements = {}
  
	  for i=1, #items, 1 do
		table.insert(elements, {label = 'x' .. items[i].count .. ' ' .. items[i].label, value = items[i].name})
	  end
  
	  ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'stocks_menu',
		{
		  title    = "Szafka",
		  elements = elements
		},
		function(data, menu)
  
		  local itemName = data.current.value
  
		  ESX.UI.Menu.Open(
			'dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count',
			{
			  title = "Ilosc"
			},
			function(data2, menu2)
  
			  local count = tonumber(data2.value)
  
			  if count == nil then
				ESX.ShowNotification("Zla ilosc")
			  else
				menu2.close()
				menu.close()
				OpenGetStocksMenu()
  
				TriggerServerEvent('program-casino:getStockItem', itemName, count)
			  end
  
			end,
			function(data2, menu2)
			  menu2.close()
			end
		  )
  
		end,
		function(data, menu)
		  menu.close()
		end
	  )
  
	end)
  
  end