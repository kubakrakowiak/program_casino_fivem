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
	{ ['x'] = 1115.87, ['y'] = 228.72, ['z'] = -49.84 },
	{ ['x'] = 1115.97, ['y'] = 230.45, ['z'] = -49.84 },
	{ ['x'] = 1117.68, ['y'] = 230.89, ['z'] = -49.84 },
	{ ['x'] = 1118.6, ['y'] = 229.4, ['z'] = -49.84 },
	{ ['x'] = 1117.5, ['y'] = 228.07, ['z'] = -49.84 },
	{ ['x'] = 1106.14, ['y'] = 230.97, ['z'] = -49.84 },
	{ ['x'] = 1111.52, ['y'] = 237.38, ['z'] = -49.84 },
	{ ['x'] = 1112.56, ['y'] = 237.67, ['z'] = -49.84 },
	{ ['x'] = 1113.49, ['y'] = 238.21, ['z'] = -49.84 },
	{ ['x'] = 1110.44, ['y'] = 237.41, ['z'] = -49.84 },
	{ ['x'] = 1109.38, ['y'] = 237.68, ['z'] = -49.84 },
	{ ['x'] = 1108.45, ['y'] = 238.22, ['z'] = -49.84 },

	{ ['x'] = 1130.19, ['y'] = 251.7, ['z'] = -51.04 },
	{ ['x'] = 1131.22, ['y'] = 251.43, ['z'] = -51.04 },
	{ ['x'] = 1132.15, ['y'] = 250.89, ['z'] = -51.04 },
	{ ['x'] = 1132.92, ['y'] = 250.14, ['z'] = -51.04 },
	{ ['x'] = 1133.44, ['y'] = 249.18, ['z'] = -51.04 },
	{ ['x'] = 1133.74, ['y'] = 248.14, ['z'] = -51.04 },

	--penthouse
	{ ['x'] = 944.73, ['y'] = 20.86, ['z'] = 116.16 },
	{ ['x'] = 941.25, ['y'] = 8.86, ['z'] = 116.16 },
	{ ['x'] = 943.2, ['y'] = 7.67, ['z'] = 116.16 },
	{ ['x'] = 942.07, ['y'] = 5.96, ['z'] = 116.16 },
	{ ['x'] = 940.18, ['y'] = 7.06, ['z'] = 116.16 },
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

