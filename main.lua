

-- message('HelloWorld')

SLASH_VLAD1 = '/profcalc';

current_page   = -1;

should_do_next_search = 0;

gAtr_ptime = 0;   -- a more precise timer but may not be updated very frequently

do_scan=0;
scan_count=3;
scan_current=0;
to_scan = 3;
-- scan_items = {}
-- scan_items[0] = "Foxflower";
-- scan_items[1] = "Fjarnskaggl";
-- scan_items[2] = "Starlight Rose";

-- what receipe are we currently scanning
receipe_id = 1

--stages
DO_NOTHING = 0;
SCAN_INGREDIENTS=1;
PROCESS_INGREDIENTS=2;
SCAN_PRODUCT=3;
CALCULATE_PROFIT=4;

-- are we doing all receipes or just one
MODE_ALL=1
MODE_ONE=2

local current_stage = DO_NOTHING;
local current_mode = MODE_ONE

mainframe = nil

function start_scan_all()
	print("Initiating all scan. Receipes "..number_rec);
	receipe_id = 1
	do_scan = 1
	scan_current = 1
	to_scan = gReceipes[receipe_id].number_items
	current_stage = SCAN_INGREDIENTS
	current_mode = MODE_ALL
	print("|cff5555FF Scanning receipe "..receipe_id.."/"..number_rec.." - "..gReceipes[receipe_id].product)
end

function stop_scan_all()
	receipe_id = number_rec
end

should_scan_receipe = {}

should_scan_receipe[PROF_ALCHEMY_FLASK] = true
should_scan_receipe[PROF_COOKING_NORMAL] = true
should_scan_receipe[PROF_COOKING_NORMAL] = true

function cooking_check_box()
	if should_scan_receipe[PROF_COOKING_SIMPLE] == true then
		should_scan_receipe[PROF_COOKING_SIMPLE] = false
	else
		should_scan_receipe[PROF_COOKING_SIMPLE] = true
	end
	if should_scan_receipe[PROF_COOKING_NORMAL] == true then
		should_scan_receipe[PROF_COOKING_NORMAL] = false
	else
		should_scan_receipe[PROF_COOKING_NORMAL] = true
	end
end

function alchemy_check_box()
	if should_scan_receipe[PROF_ALCHEMY_FLASK] == true then
		should_scan_receipe[PROF_ALCHEMY_FLASK] = false
	else
		should_scan_receipe[PROF_ALCHEMY_FLASK] = true
	end
end

local function handler(msg, editbox)
	if msg == 'all' then
	elseif msg == nil then
		receipe_id = find_receipe(msg)
		print("Initiating scan "..gReceipes[receipe_id].product);
		do_scan = 1
		scan_current = 1
		to_scan = gReceipes[receipe_id].number_items
		current_stage = SCAN_INGREDIENTS
		current_mode = MODE_ONE
	else
		create_frame()
	end
end

function VLAD_Close(v)
	mainframe:Hide();
end

SlashCmdList["VLAD"] = handler; -- Also a valid assignment strategy


function nextStage(v)
	if(current_stage==CALCULATE_PROFIT) then
		current_stage = DO_NOTHING
	else
		current_stage = current_stage + 1
	end
	-- print("next stage"..current_stage)
end

-- cache for scanned items
scanned_item = {}

-- cost_flower = {}
-- cost_flower["Foxflower"] = 0;
-- cost_flower["Dreamleaf"] = 0;
-- cost_flower["Fjarnskaggl"] = 0;
-- cost_flower["Starlight Rose"] = 0;

-- print(cost_flower["Foxflower"])
-- print("rec"..gReceipes[receipe_id].product)
-- print("rec1"..number_rec)

function FiveSecondDelay()
	local delay
	delay=time()+2
	while time()<delay do
	end
end

function VLAD_RegisterEvents(self)
  self:RegisterEvent("AUCTION_ITEM_LIST_UPDATE");
end

function VLAD_EventHandler(self, event, ...)
	-- Auctionator.Debug.Message( 'Atr_EventHandler', event, ... )

	if (event == "AUCTION_ITEM_LIST_UPDATE")  then  VLAD_OnAuctionUpdate(...);       end;

end

local total_items_of_a_kind = 0

function VLAD_OnAuctionUpdate (...)
	-- print( 'Atr_OnAuctionUpdate' )

	local numBatchAuctions, totalAuctions = GetNumAuctionItems("list");

	--print("number "..totalAuctions.." batch "..numBatchAuctions )

	-- if this is the first time we get called
	if current_stage == SCAN_INGREDIENTS then
		total_items_of_a_kind = totalAuctions
		current_stage = PROCESS_INGREDIENTS
	end

	current_item_in_page = 1

	local name, texture, count, quality, canUse, level, huh, minBid,
			minIncrement, buyoutPrice, bidAmount, highBidder, bidderFullName,
			owner, ownerFullName, saleStatus = GetAuctionItemInfo( "list", current_item_in_page )
	
	if name == nil then
		-- we could not find this item
		to_scan = to_scan - 1
		if current_stage == PROCESS_INGREDIENTS or current_stage == SCAN_INGREDIENTS then
			scan_current = scan_current + 1
			-- are we done with all ingredients
			if (scan_current == gReceipes[receipe_id].number_items ) then
				-- print("next stage")
				nextStage(current_stage)
			else
				-- next ingredient
				-- print("next ing")
				current_stage = SCAN_INGREDIENTS
			end
		elseif current_stage == SCAN_PRODUCT then
			nextStage(current_stage)
		elseif current_stage == CALCULATE_PROFIT then
			-- do_scan = 0
		end		
		return
	end

	while buyoutPrice == 0 do
		-- print("No buyout price!")
		current_item_in_page = current_item_in_page + 1
		name, texture, count, quality, canUse, level, huh, minBid,
			minIncrement, buyoutPrice, bidAmount, highBidder, bidderFullName,
			owner, ownerFullName, saleStatus = GetAuctionItemInfo( "list", current_item_in_page )
	end

	-- print("Name"..name)
	local perItemPrice = buyoutPrice / count

	if current_stage == PROCESS_INGREDIENTS or current_stage == SCAN_INGREDIENTS then
		-- cost_flower[name] = perItemPrice
		scanned_item[name] = perItemPrice
		gReceipes[receipe_id].items[scan_current].ah_cost = perItemPrice
	elseif current_stage == SCAN_PRODUCT then
		gReceipes[receipe_id].product_ah_cost = perItemPrice
	end

	local gold, silver, copper = val2gsc(perItemPrice)

	-- print(name.." price is "..gold.." "..silver.." "..copper)

	-- mark that we process some
	total_items_of_a_kind = total_items_of_a_kind - numBatchAuctions
	-- print("Remaining "..total_items_of_a_kind)
	-- if total_items_of_a_kind <= 0 then
	if true then
		-- print("Done with item")
		to_scan = to_scan - 1
		if current_stage == PROCESS_INGREDIENTS or current_stage == SCAN_INGREDIENTS then
			scan_current = scan_current + 1
			-- are we done with all ingredients
			if (scan_current == gReceipes[receipe_id].number_items ) then
				-- print("next stage")
				nextStage(current_stage)
			else
				-- next ingredient
				-- print("next ing")
				current_stage = SCAN_INGREDIENTS
			end
		elseif current_stage == SCAN_PRODUCT then
			nextStage(current_stage)
		elseif current_stage == CALCULATE_PROFIT then
			-- do_scan = 0
		end		
	end

end

function in_cache(table, element)
  for name, value in pairs(table) do
    if name == element then
  	--print("Found name.."..name.."..value.."..value)
      return true
    end
  end
  return false
end

function VLAD_OnUpdate(self, elapsed)

  -- update the global "precision" timer
	gAtr_ptime = gAtr_ptime + elapsed;
	-- do we have work to do?
	if (gAtr_ptime > 4 and do_scan == 1) then
		-- print("Stage "..current_stage)
		-- print("VLAD_OnUpdate "..gAtr_ptime.." "..scan_items[scan_current])
		if current_stage == SCAN_INGREDIENTS or current_stage == PROCESS_INGREDIENTS then
			-- should we scan this?
			if should_scan_receipe[gReceipes[receipe_id].profession] == false then
				-- no, skip it
				print("Skipping "..gReceipes[receipe_id].product)
				receipe_id = receipe_id + 1
				-- are we done?
				if receipe_id == number_rec then
					do_scan = 0
					print("|cff5555FF DONE!")
				end
			else
			-- local canQuery, canQueryAll
		    -- canQuery,canQueryAll=CanSendAuctionQuery("list")
		     -- while CanDoWholeQuery~=1 do
		     --       FiveSecondDelay() -- just prevents hammering the CanSendAuctionQuery
		     --       _,CanDoWholeQuery=CanSendAuctionQuery("list")
		     -- end
			-- if(canQuery == 1) then
				-- print("Scanning for "..gReceipes[receipe_id].items[scan_current].name..".")

				-- have looked up this item before?
				--if scan_current == gReceipes[receipe_id].number_items then
					-- QueryAuctionItems (gReceipes[receipe_id].items[scan_current].name, 0, 110, 0, nil, nil, false, false, nil )
				--else
					-- print("id "..scan_current.." name "..gReceipes[receipe_id].items[scan_current].name)
					-- if(gReceipes[receipe_id] == nil) then
					-- 	scan_current = scan_current + 1
					-- 	return
					-- end

					if not in_cache(scanned_item, gReceipes[receipe_id].items[scan_current].name) then
					--if true then
					--if type(scanned_item[gReceipes[receipe_id].items[scan_current].name]) == nil then
						QueryAuctionItems (gReceipes[receipe_id].items[scan_current].name, 0, 110, 0, nil, nil, false, false, nil )
					else
						-- we scanned this before
						gReceipes[receipe_id].items[scan_current].ah_cost = scanned_item[gReceipes[receipe_id].items[scan_current].name]
						-- print("Cache hit "..gReceipes[receipe_id].items[scan_current].name.." "..scanned_item[gReceipes[receipe_id].items[scan_current].name])
						scan_current = scan_current + 1
						-- are we done with all ingredients
						if (scan_current == gReceipes[receipe_id].number_items ) then
							-- print("next stage cache")
							--nextStage(current_stage)
							current_stage = SCAN_PRODUCT
						else
							-- next ingredient
							-- print("next ing cache")
							current_stage = SCAN_INGREDIENTS
						end
					end
				--end
			end
		elseif current_stage == SCAN_PRODUCT then
			-- print("Scanning for "..gReceipes[receipe_id].product)
			QueryAuctionItems (gReceipes[receipe_id].product, 0, 110, 0, nil, nil, false, false, nil )
			-- nextStage(current_stage)
		elseif current_stage == CALCULATE_PROFIT then
			local total_mat_cost = 0
			local limit = gReceipes[receipe_id].number_items - 1
			for i=1,limit,1
			do
				total_mat_cost = total_mat_cost + (gReceipes[receipe_id].items[i].ah_cost * gReceipes[receipe_id].items[i].count)
			end
			local gold, silver, copper = val2gsc(total_mat_cost)
			print("Cost to make "..gold.." "..silver.." "..copper)
			gold, silver, copper = val2gsc(gReceipes[receipe_id].product_ah_cost)
			print("Item cost "..gold.." "..silver.." "..copper)
			-- what proffesion
			if gReceipes[receipe_id].profession == PROF_COOKING_NORMAL then
				cooking_estimate(total_mat_cost, gReceipes[receipe_id].product_ah_cost)
			elseif gReceipes[receipe_id].profession == PROF_COOKING_SIMPLE then
				cooking_estimate_simple(total_mat_cost, gReceipes[receipe_id].product_ah_cost)
			elseif gReceipes[receipe_id].profession == PROF_ALCHEMY_FLASK then
				alchemy_estimate(total_mat_cost, gReceipes[receipe_id].product_ah_cost)
			end
			do_scan = 0
			-- are we in all mode?
			if current_mode == MODE_ALL then
				-- are we done?
				if receipe_id ~= number_rec then
					-- no, next one
					receipe_id = receipe_id + 1
					print("|cff5555FF Scanning receipe "..receipe_id.."/"..number_rec.." - "..gReceipes[receipe_id].product)
					do_scan = 1
					scan_current = 1
					to_scan = gReceipes[receipe_id].number_items
					current_stage = SCAN_INGREDIENTS
				else
					-- we are done done done
					print("|cff5555FF DONE!")
				end
			end

		end
		-- QueryAuctionItems (scan_items[scan_current], 0, 110, 1, nil, nil, false, true, nil )
		-- scan_current = scan_current + 1;
		-- are we done
		-- if (scan_current == 3) then
		-- 	do_scan = 0;
		-- end
		gAtr_ptime = 0;
	end
end