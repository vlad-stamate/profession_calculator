function barOnDragStart(self)
	self:StartMoving()
end

function barOnDragStop(self)
	self:StopMovingOrSizing()
end

function create_prof_check_button(mainf, name, func, x, y)
	local prof_check = CreateFrame("CheckButton","prof_check",mainf, "ChatConfigCheckButtonTemplate")
	prof_check:SetPoint("BOTTOM",x,y)
	prof_check:SetWidth(25)
	prof_check:SetHeight(25)
	prof_check:SetText(name)
	prof_check:SetScript("OnClick",
		func)
	prof_check:SetChecked(true)
	prof_check:Show()

	local label_prof_check = mainframe:CreateFontString("ARTWORK")
	label_prof_check:SetFontObject("GameFontNormal")
	label_prof_check:SetPoint("BOTTOM",x+50,y)
	label_prof_check:SetHeight(25)
	label_prof_check:SetText(name)

	if name == "Cooking" or name == "Alchemy" then
	else
		prof_check:Hide(true)
		label_prof_check:Hide(true)
	end
end

function create_frame()
	mainframe = CreateFrame("Frame","VLAD_core",UIParent)
	mainframe:SetPoint("CENTER",200,0)
	mainframe:SetWidth(400)
	mainframe:SetHeight(400)
	mainframe:SetBackdrop{
		bgFile="Interface\\DialogFrame\\UI-DialogBox-Background" ,
		edgeFile="Interface\\DialogFrame\\UI-DialogBox-Border",
		tile = true,
		insets = {left = 11, right = 12, top = 12, bottom = 11},
		tileSize = 32,
		edgeSize = 32,
	}
	mainframe:EnableMouse(true)
	mainframe:SetMovable(true)
	mainframe:RegisterForDrag('LeftButton')
	mainframe:SetScript("OnDragStart", barOnDragStart)
	mainframe:SetScript("OnDragStop", barOnDragStop)

	-- professions

	create_prof_check_button(mainframe, "Cooking", cooking_check_box, -110, 300)
	create_prof_check_button(mainframe, "Alchemy", alchemy_check_box, 50, 300)
	create_prof_check_button(mainframe, "Jewelcrafting", cooking_check_box, -110, 260)
	create_prof_check_button(mainframe, "Blacksmithing", cooking_check_box, 50, 260)
	create_prof_check_button(mainframe, "Enchanting", cooking_check_box, -110, 220)
	create_prof_check_button(mainframe, "Leatherworking", cooking_check_box, 50, 220)
	create_prof_check_button(mainframe, "Inscription", cooking_check_box, -110, 180)
	create_prof_check_button(mainframe, "Tailoring", cooking_check_box, 50, 180)

	-- show losing

	local button_show_losing = CreateFrame("CheckButton","button_show_losing",mainframe, "ChatConfigCheckButtonTemplate")
	button_show_losing:SetPoint("BOTTOM",0,80)
	button_show_losing:SetWidth(25)
	button_show_losing:SetHeight(25)
	button_show_losing:SetText("Show losing")
	button_show_losing:SetScript("OnClick",
		function(self, event, ...)
			if show_losing_receipes then
				show_losing_receipes = false
			else
				show_losing_receipes = true
			end
		end)
	button_show_losing:Show()

	local label_show_losing = mainframe:CreateFontString("ARTWORK")
	label_show_losing:SetFontObject("GameFontNormal")
	label_show_losing:SetPoint("BOTTOM",50,80)
	label_show_losing:SetHeight(25)
	label_show_losing:SetText("Show Losing")
	
	-- Buttons
	local button_scan_all = CreateFrame("Button","button_scan_all",mainframe, "UIPanelButtonTemplate")
	button_scan_all:SetPoint("BOTTOM",100,50)
	button_scan_all:SetWidth(100)
	button_scan_all:SetHeight(25)
	button_scan_all:SetText("Scan All")
	button_scan_all:SetScript("OnClick",
		start_scan_all)
	button_scan_all:Show()

	local button_stop_scan = CreateFrame("Button","button_stop_scan",mainframe, "UIPanelButtonTemplate")
	button_stop_scan:SetPoint("BOTTOM",-100,50)
	button_stop_scan:SetWidth(100)
	button_stop_scan:SetHeight(25)
	button_stop_scan:SetText("Stop Scan")
	button_stop_scan:SetScript("OnClick",
		stop_scan_all)
	button_stop_scan:Show()

	local button_close = CreateFrame("Button","button_close",mainframe, "UIPanelButtonTemplate")
	button_close:SetPoint("BOTTOM",0,20)
	button_close:SetWidth(80)
	button_close:SetHeight(25)
	button_close:SetText("Close")
	button_close:SetScript("OnClick",
		function(self, event, ...)
			button_close:Hide()
			mainframe:Hide()
		end)
	button_close:Show()


	local header = mainframe:CreateTexture(nil, "ARTWORK")
	header:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Header")
	header:SetWidth(300); header:SetHeight(64)
	header:SetPoint("TOP", 0, 12)
	local title = mainframe:CreateFontString("ARTWORK")
	title:SetFontObject("GameFontNormal")
	title:SetPoint("TOP", header, "TOP", 0, -14)
	title:SetText("Profession Calculator")

	mainframe:Show()
end