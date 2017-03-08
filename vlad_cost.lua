
show_losing_receipes = false

-- this takes into account 1,2 and 3 star food
function cooking_estimate(total_mat_cost, product_ah_cost)

	local rank1_cost = product_ah_cost * 5
	local rank2_cost = product_ah_cost * 7
	local rank3_cost = product_ah_cost * 10

	if total_mat_cost < rank1_cost then
		local profit = rank1_cost-total_mat_cost
		gold, silver, copper = val2gsc(profit)
		print("|cff55FF55 Detected profit at rank 1 on "..gReceipes[receipe_id].product.." of "..gold.."g "..silver.."s "..copper.."c")
	elseif show_losing_receipes then
		local loss = total_mat_cost - rank1_cost
		gold, silver, copper = val2gsc(loss)
		print("|cffFF5555 Detected loss at rank 1 on "..gReceipes[receipe_id].product.." of "..gold.."g "..silver.."s "..copper.."c")
	end
	if total_mat_cost < rank2_cost then
		local profit = rank2_cost-total_mat_cost
		gold, silver, copper = val2gsc(profit)
		print("|cff55FF55 Detected profit at rank 2 on "..gReceipes[receipe_id].product.." of "..gold.."g "..silver.."s "..copper.."c")
	elseif show_losing_receipes then
		local loss = total_mat_cost - rank2_cost
		gold, silver, copper = val2gsc(loss)
		print("|cffFF5555 Detected loss at rank 2 on "..gReceipes[receipe_id].product.." of "..gold.."g "..silver.."s "..copper.."c")
	end
	if total_mat_cost < rank3_cost then
		local profit = rank3_cost-total_mat_cost
		gold, silver, copper = val2gsc(profit)
		print("|cff55FF55 Detected profit at rank 3 on "..gReceipes[receipe_id].product.." of "..gold.."g "..silver.."s "..copper.."c")
	elseif show_losing_receipes then
		local loss = total_mat_cost - rank3_cost
		gold, silver, copper = val2gsc(loss)
		print("|cffFF5555 Detected loss at rank 3 on "..gReceipes[receipe_id].product.." of "..gold.."g "..silver.."s "..copper.."c")
	end

end

function cooking_estimate_simple(total_mat_cost, product_ah_cost)

	local rank1_cost = product_ah_cost * 1

	if total_mat_cost < rank1_cost then
		local profit = rank1_cost-total_mat_cost
		gold, silver, copper = val2gsc(profit)
		print("|cff55FF55 Detected profit on "..gReceipes[receipe_id].product.." of "..gold.."g "..silver.."s "..copper.."c")
	elseif show_losing_receipes then
		local loss = total_mat_cost - rank1_cost
		gold, silver, copper = val2gsc(loss)
		print("|cffFF5555 Detected loss on "..gReceipes[receipe_id].product.." of "..gold.."g "..silver.."s "..copper.."c")
	end
end

function alchemy_estimate(total_mat_cost, product_ah_cost)
	local rank2_cost = product_ah_cost * 1
	local rank3_cost = product_ah_cost * 1.5
	if total_mat_cost < rank2_cost then
		local profit = rank2_cost-total_mat_cost
		gold, silver, copper = val2gsc(profit)
		print("|cff55FF55 Detected profit at rank 2 on "..gReceipes[receipe_id].product.." of "..gold.."g "..silver.."s "..copper.."c")
	elseif show_losing_receipes then
		local loss = total_mat_cost - rank2_cost
		gold, silver, copper = val2gsc(loss)
		print("|cffFF5555 Detected loss at rank 2 on "..gReceipes[receipe_id].product.." of "..gold.."g "..silver.."s "..copper.."c")
	end
	if total_mat_cost < rank3_cost then
		local profit = rank3_cost-total_mat_cost
		gold, silver, copper = val2gsc(profit)
		print("|cff55FF55 Detected profit at rank 3 on "..gReceipes[receipe_id].product.." of "..gold.."g "..silver.."s "..copper.."c")
	elseif show_losing_receipes then
		local loss = total_mat_cost - rank3_cost
		gold, silver, copper = val2gsc(loss)
		print("|cffFF5555 Detected loss at rank 3 on "..gReceipes[receipe_id].product.." of "..gold.."g "..silver.."s "..copper.."c")
	end

end