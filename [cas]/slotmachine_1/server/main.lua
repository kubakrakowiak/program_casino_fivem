ESX = nil
local timer = nil
local maksut = 0
local saannit = 0

TriggerEvent('esx:getSharedObject', function(obj) 
  ESX = obj
end)


RegisterServerEvent('payforplayer2')
AddEventHandler('payforplayer2',function(winnings)
	
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
	xPlayer.addMoney(winnings)

	local societyAccount = nil
	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_casino', function(account)
		societyAccount = account
	end)
	--if societyAccount < winnings then
		
	--else
		--societyAccount.removeMoney(winnings)
	--end

end)

RegisterServerEvent('playerpays2')
AddEventHandler('playerpays2',function(bet)

	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(_source)

	if xPlayer.get('money') >= bet then
		local societyAccount = nil
		TriggerEvent('esx_addonaccount:getSharedAccount', 'society_casino', function(account)
			societyAccount = account
		end)
		xPlayer.removeMoney(bet)
		societyAccount.addMoney(bet)
		TriggerClientEvent('spinit2',_source)
	else
		TriggerClientEvent('errormessage2',_source)
	end
end)
