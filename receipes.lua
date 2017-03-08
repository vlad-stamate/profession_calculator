number_rec = 13

PROF_ALCHEMY_FLASK = 1
PROF_COOKING_SIMPLE = 2
PROF_COOKING_NORMAL = 3

-- todo: add base cost for each item (vendor items that you have to buy)

gReceipes = {
	
	[1] = { 	product = "Flask Of The Seventh Demon" , 
				product_ah_cost = 0,
				product_count = 1,
				profession = PROF_ALCHEMY_FLASK,
				number_items = 4,
				items = {
						[1] = { count = 7, name = "Starlight Rose", ah_cost = 0}, 
						[2] = { count = 10, name = "Foxflower", ah_cost = 0}, 
						[3] = { count = 10, name = "Fjarnskaggl", ah_cost = 0} 
						}
			},
	[2] = { 	product = "Flask Of The Whispered Pact" , 
				product_ah_cost = 0,
				product_count = 1,
				profession = PROF_ALCHEMY_FLASK,
				number_items = 4,
				items = {
						[1] = { count = 7, name = "Starlight Rose", ah_cost = 0}, 
						[2] = { count = 10, name = "Dreamleaf", ah_cost = 0}, 
						[3] = { count = 10, name = "Fjarnskaggl", ah_cost = 0} 
						}
			},
	[3] = { 	product = "Flask Of The Countless Armies" , 
				product_ah_cost = 0,
				product_count = 1,
				profession = PROF_ALCHEMY_FLASK,
				number_items = 4,
				items = {
						[1] = { count = 7, name = "Starlight Rose", ah_cost = 0}, 
						[2] = { count = 10, name = "Foxflower", ah_cost = 0}, 
						[3] = { count = 10, name = "Aethril", ah_cost = 0} 
						}
			},
	[4] = { 	product = "Flask Of Ten Thousand Scars" , 
				product_ah_cost = 0,
				product_count = 1,
				profession = PROF_ALCHEMY_FLASK,
				number_items = 4,
				items = {
						[1] = { count = 7, name = "Starlight Rose", ah_cost = 0}, 
						[2] = { count = 10, name = "Dreamleaf", ah_cost = 0}, 
						[3] = { count = 10, name = "Aethril", ah_cost = 0} 
						}
			},
	[5] = { 	product = "Spiced Wildfowl Omelet" , 
				product_ah_cost = 0,
				product_count = 1,
				profession = PROF_COOKING_SIMPLE,
				number_items = 2,
				items = {
						[1] = { count = 2, name = "Falcosaur Egg", ah_cost = 0}, 
						}
				},
	[6] = { 	product = "Bear Tartare" , 
				product_ah_cost = 0,
				product_count = 1,
				profession = PROF_COOKING_NORMAL,
				number_items = 2,
				items = {
						[1] = { count = 5, name = "Fatty Bearsteak", ah_cost = 0}, 
						}
			},
	[7] = { 	product = "Dried Mackerel Strips" , 
				product_ah_cost = 0,
				product_count = 1,
				profession = PROF_COOKING_NORMAL,
				number_items = 2,
				items = {
						[1] = { count = 5, name = "Silver Mackerel", ah_cost = 0}, 
						}
			},
	[8] = { 	product = "Fighter Chow" , 
				product_ah_cost = 0,
				product_count = 1,
				profession = PROF_COOKING_NORMAL,
				number_items = 2,
				items = {
						[1] = { count = 5, name = "Cursed Queenfish", ah_cost = 0}, 
						}
			},
	[9] = { 	product = "Potion Of Deadly Grace" , 
				product_ah_cost = 0,
				product_count = 1,
				profession = PROF_ALCHEMY_FLASK,
				number_items = 4,
				items = {
						[1] = { count = 2, name = "Starlight Rose", ah_cost = 0}, 
						[2] = { count = 4, name = "Fjarnskaggl", ah_cost = 0}, 
						[3] = { count = 4, name = "Dreamleaf", ah_cost = 0} 
						}
			},
	[10] = { 	product = "Ancient Healing Potion" , 
				product_ah_cost = 0,
				product_count = 1,
				profession = PROF_ALCHEMY_FLASK,
				number_items = 2,
				items = {
						[1] = { count = 4, name = "Yseralline Seed", ah_cost = 0}, 
						}
			},
	[11] = { 	product = "Unbending Potion" , 
				product_ah_cost = 0,
				product_count = 1,
				profession = PROF_ALCHEMY_FLASK,
				number_items = 4,
				items = {
						[1] = { count = 2, name = "Starlight Rose", ah_cost = 0}, 
						[2] = { count = 4, name = "Aethril", ah_cost = 0}, 
						[3] = { count = 4, name = "Foxflower", ah_cost = 0} 
						}
			},
	[12] = { 	product = "Potion of the Old War" , 
				product_ah_cost = 0,
				product_count = 1,
				profession = PROF_ALCHEMY_FLASK,
				number_items = 4,
				items = {
						[1] = { count = 2, name = "Starlight Rose", ah_cost = 0}, 
						[2] = { count = 4, name = "Fjarnskaggl", ah_cost = 0}, 
						[3] = { count = 4, name = "Foxflower", ah_cost = 0} 
						}
			},
	[13] = { 	product = "Leytorrent Potion" , 
				product_ah_cost = 0,
				product_count = 1,
				profession = PROF_ALCHEMY_FLASK,
				number_items = 4,
				items = {
						[1] = { count = 2, name = "Starlight Rose", ah_cost = 0}, 
						[2] = { count = 4, name = "Aethril", ah_cost = 0}, 
						[3] = { count = 4, name = "Dreamleaf", ah_cost = 0} 
						}
			},
		}

function find_receipe(name)
	for i=1,number_rec,1 do
		if gReceipes[i].product == name then
			return i
		end
	end
	return 1
end