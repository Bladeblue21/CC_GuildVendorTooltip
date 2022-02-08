--[[
Move guild name to be underneath the player name.
Change guild name color to be White

Have vendor price take stacks into account.
	Currently only the sell price is displaying as if the player has one item.
Handle vendor price on quest objectives and loot rolls.
	Or just fix it so it doesn't lua error.

]]--
itemCount = nil
currItem = nil
currMouseover = nil
tooltipGuild = nil
SELL_PRICE_TEXT = format("%s:", SELL_PRICE)


function GetCurrentItemName()
	if currItem ~= GameTooltip:GetItem() then
		itemName, itemLink = GameTooltip:GetItem()
		currItem = GameTooltip:GetItem()
		
	end
	
	if currItem ~= nil then
		GetItemVendorPrice(itemName, count)
	end
end

function GetItemStackCount(tooltip, bag, slot)
		_, count = GetContainerItemInfo(bag, slot)
end

function GetItemVendorPrice(itemName, count)
		sellPrice = select(11, GetItemInfo(itemName))
		if sellPrice ~= nil and sellPrice > 1 and count ~= nil then
			local totalSellPrice = sellPrice * count
			SetTooltipMoney(GameTooltip, totalSellPrice, nil, SELL_PRICE_TEXT)
		end
end

function GetUnitPlayerName()
	if UnitPlayerControlled("mouseover") then
		name, server = UnitName("mouseover")
		tooltipGuild = select(1, GetGuildInfo("mouseover"))
		if tooltipGuild ~= nil then
			AddGuildName(tooltipGuild)
		end
	end
end

function AddGuildName(guildName)
	GameTooltip_AddColoredLine(GameTooltip, ("<".. guildName ..">"), NORMAL_FONT_COLOR, wrap)
end





GameTooltip:HookScript("OnTooltipSetItem", GetCurrentItemName)
GameTooltip:HookScript("OnTooltipSetUnit", GetUnitPlayerName)
hooksecurefunc(GameTooltip, "SetBagItem", GetItemStackCount)












