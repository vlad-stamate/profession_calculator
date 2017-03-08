
function round (v)
	return math.floor (v + 0.5);
end

function val2gsc (v)
	local rv = round(v)

	local g = math.floor (rv/10000);

	rv = rv - g*10000;

	local s = math.floor (rv/100);

	rv = rv - s*100;

	local c = rv;

	return g, s, c
end