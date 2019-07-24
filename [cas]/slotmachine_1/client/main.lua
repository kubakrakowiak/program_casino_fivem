local input = {["E"] = 38,["DOWN"] = 173,["TOP"] = 27,["NENTER"] =  201}
ESX                           = nil
local PlayerData                = {}



Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(1)
  end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  	PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)


Citizen.CreateThread(function()
SetNuiFocus(false, false)
end)


RegisterNetEvent('errormessage2')
AddEventHandler('errormessage2', function()
PlaySound(GetPlayerServerId(GetPlayerPed(-1)), "CHECKPOINT_MISSED", "HUD_MINI_GAME_SOUNDSET", 0, 0, 1)
end)


RegisterNetEvent('spinit2')
AddEventHandler('spinit2', function()
	PlaySound(GetPlayerServerId(GetPlayerPed(-1)), "Apt_Style_Purchase", "DLC_APT_Apartment_SoundSet", 0, 0, 1)

	SendNUIMessage({
			canspin = true
		})
	Citizen.Wait(100)

		SendNUIMessage({
			canspin = false
		})

end)


RegisterNUICallback('close', function(data, cb)

	SetNuiFocus(false, false)
	SendNUIMessage({
		show = false
	})
	cb("ok")
	PlaySound(GetPlayerServerId(GetPlayerPed(-1)), "Apt_Style_Purchase", "DLC_APT_Apartment_SoundSet", 0, 0, 1)

end)




RegisterNUICallback('payforplayer', function(winnings, cb)
	PlaySound(GetPlayerServerId(GetPlayerPed(-1)), "ROBBERY_MONEY_TOTAL", "HUD_FRONTEND_CUSTOM_SOUNDSET", 0, 0, 1)
	TriggerServerEvent('payforplayer2',winnings)
end)


RegisterNUICallback('playerpays', function(bet, cb)
	TriggerServerEvent('playerpays2',bet)
end)

local moneymachine_slot = {
	{ ['x'] = 929.61, ['y'] = -947.12, ['z'] = 44.66 },
	{ ['x'] = 929.61, ['y'] = -948.52, ['z'] = 44.66 },
	{ ['x'] = 929.61, ['y'] = -950.32, ['z'] = 44.66 },
	{ ['x'] = 929.61, ['y'] = -952.02, ['z'] = 44.66 },
	{ ['x'] = 929.61, ['y'] = -953.62, ['z'] = 44.66 },
	{ ['x'] = 929.61, ['y'] = -955.22, ['z'] = 44.66 },
	{ ['x'] = 929.61, ['y'] = -956.92, ['z'] = 44.66 },
	{ ['x'] = 929.61, ['y'] = -958.62, ['z'] = 44.66 },

	{ ['x'] = 934.91, ['y'] = -947.12, ['z'] = 44.66 },
	{ ['x'] = 934.91, ['y'] = -948.52, ['z'] = 44.66 },
	{ ['x'] = 934.91, ['y'] = -950.32, ['z'] = 44.66 },
	{ ['x'] = 934.91, ['y'] = -952.02, ['z'] = 44.66 },
	{ ['x'] = 934.91, ['y'] = -953.62, ['z'] = 44.66 },
	{ ['x'] = 934.91, ['y'] = -955.22, ['z'] = 44.66 },
	{ ['x'] = 934.91, ['y'] = -956.92, ['z'] = 44.66 },
	{ ['x'] = 934.91, ['y'] = -958.62, ['z'] = 44.66 },

	{ ['x'] = 938.91, ['y'] = -947.22, ['z'] = 44.66 },
	{ ['x'] = 938.91, ['y'] = -948.52, ['z'] = 44.66 },
	{ ['x'] = 938.91, ['y'] = -950.22, ['z'] = 44.66 },
	{ ['x'] = 938.91, ['y'] = -951.52, ['z'] = 44.66 },
	{ ['x'] = 938.91, ['y'] = -952.99, ['z'] = 44.66 },
	{ ['x'] = 938.91, ['y'] = -954.62, ['z'] = 44.66 },
	{ ['x'] = 938.91, ['y'] = -956.25, ['z'] = 44.66 },
	{ ['x'] = 938.91, ['y'] = -957.52, ['z'] = 44.66 },

}



Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local pos = GetEntityCoords(GetPlayerPed(-1), false)
		for k,v in ipairs(moneymachine_slot) do
			if(Vdist(v.x, v.y, v.z, pos.x, pos.y, pos.z) < 20.0)then
				DrawMarker(29, v.x, v.y, v.z + 0.2, 0, 0, 0, 0, 0, 0, 0.6001, 1.0001, 0.6, 0, 255, 5, 90, 1,0, 0,1)
				if(Vdist(v.x, v.y, v.z, pos.x, pos.y, pos.z) < 1.0)then
						DisplayHelpText("Wcisnij ~INPUT_CONTEXT~   ~y~aby zagrać w sloty")
					if IsControlJustPressed(1,input["E"]) then
						SendNUIMessage({
							show = true
						})
						SetNuiFocus(true,true)
						PlaySound(GetPlayerServerId(GetPlayerPed(-1)), "Apt_Style_Purchase", "DLC_APT_Apartment_SoundSet", 0, 0, 1)
					end
				end
			end
		end
	end
end)

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

