--[[
	Project: Acherus WLTK Classic
	Website: https://www.curseforge.com/wow/addons/acherus-wltk-classic
	Rev: 10
	Author: kollektiv, lancestre

	Copyright 2009 Timothy Yen
	This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
	(at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with this program.  If not, see <http://www.gnu.org/licenses/>.
]]
if select(2,UnitClass("player")) ~= "DEATHKNIGHT" then return end
local Acherus = Acherus
local L,SM = Acherus.L, Acherus.SM
local Runes = Acherus:NewModule("Runes","AceEvent-3.0")
Acherus.Runes = Runes
Runes.frame = CreateFrame("Frame",Acherus.frame:GetName().."Runes",Acherus.frame,BackdropTemplateMixin and "BackdropTemplate")
Runes.frame:SetAllPoints(UIParent)
Runes.barparent = CreateFrame("Frame",Runes.frame:GetName().."BarParent",Runes.frame,BackdropTemplateMixin and "BackdropTemplate")
Runes.barparent:SetFrameLevel(Runes.frame:GetFrameLevel()-1)

local db

local assert,type,unpack = assert,type,unpack
local format,gsub = string.format, string.gsub
local ceil,floor,pi,max,min,sin,cos,tan = math.ceil,math.floor,math.pi,math.max,math.min,math.sin,math.cos,math.tan
local ipairs, pairs = ipairs, pairs
local concat,wipe,insert,sort = table.concat, table.wipe,table.insert,table.sort
local loadstring = loadstring
local GetRuneType,GetRuneCooldown = GetRuneType, GetRuneCooldown
local GetRuneCooldown = GetRuneCooldown
local UnitGUID,GetTime = UnitGUID, GetTime

local RUNETYPE_BLOOD  = 1
local RUNETYPE_UNHOLY = 3
local RUNETYPE_FROST  = 2
local RUNETYPE_DEATH  = 4

local EDGESIZE = 7

-- Upvalues for optimization
local layoutorientation
local barwidth, barheight

local runeorderoptionvalues = {				
	[{5,6,3,4,1,2}] = format("%s %s %s",L["Frost"],L["Unholy"],L["Blood"]),
	[{1,2,3,4,5,6}] = format("%s %s %s",L["Blood"],L["Unholy"],L["Frost"]),
	[{1,2,5,6,3,4}] = format("%s %s %s",L["Blood"],L["Frost"],L["Unholy"]),
	[{3,4,1,2,5,6}] = format("%s %s %s",L["Unholy"],L["Blood"],L["Frost"]),
	[{3,4,5,6,1,2}] = format("%s %s %s",L["Unholy"],L["Frost"],L["Blood"]),
	[{5,6,1,2,3,4}] = format("%s %s %s",L["Frost"],L["Blood"],L["Unholy"]),
}

local meta = {__lt = function(a,b) return a[1] < b[1] end,}
for tbl in pairs(runeorderoptionvalues) do setmetatable(tbl,meta) end

local defaultrunecolors = {
	[RUNETYPE_BLOOD] = {1.0, 0.0, 0.0},
	[RUNETYPE_UNHOLY] = {0.0, 0.5, 0.0}, 
	[RUNETYPE_FROST] = {0.0, 1.0, 1.0}, 
	[RUNETYPE_DEATH] = {0.8, 0.1, 1.0},
}

local icon_behaviors_values = {
	["PULSE"] = L["Pulse"],
	["PULSEANDSPIN"] = L["Pulse and spin"],
	["SPIN"] = L["Spin"],
	["NONE"] = L["None"],
}

local icon_behaviors = {
	["PULSE"] = function(icon) Acherus:AnimateRegionPulse(icon,db.iconpulseuptime,db.iconpulsedowntime,db.iconsize,db.iconsizepulse) end,
	["PULSEANDSPIN"] = function(icon) Acherus:AnimateTexturePulseSpin(icon,db.iconpulseuptime,db.iconpulsedowntime,db.iconsize,db.iconsizepulse,db.spindegree) end,
	["SPIN"] = function(icon) Acherus:AnimateTextureSpin(icon,db.iconpulseuptime,db.iconpulsedowntime,db.spindegree) end,
	["NONE"] = function(icon) --[[Do nothing]] end,
}

function Runes:UpdateSettingsPointer()
	db = Acherus.db.profile.settings.runes
	self.db = db
end

function Runes:LoadSettings()
	if db.enabled then self.frame:Show() else self.frame:Hide() return end
	self.frame:SetScale(db.scale)
	self:UpdateColorDB()
	self:UpdateLayoutAttributes()
	self:UpdateRuneOrder()
	self:UpdateLeftRunes()
	self:UpdateIconTextures()

	self:UpdateBarAttributes()
	self:UpdateRuneAttributes()

	self:ClearPointsForLayout()
	self[gsub(format("Apply%sLayout",db.layout)," ","")](self)
	self:UpdateBarTexts()
	self:UpdateAllRunes()
	self:SetLayoutOrientationUpValue()
	self:UpdateEnabled()
end

function Runes:OnInitialize()
	Acherus:AddToSettings("runes",self:GetSettingsTable())
	self.texturepath = "Interface\\Addons\\Acherus\\Textures\\"
	self:UpdateSettingsPointer()
	self.RunicPower = Acherus.RunicPower -- RunicPower module
	self:RegisterLayout("Triangle",L["Triangle"],"horizontal")
	self:RegisterLayout("Stacking",L["Stacking"],"horizontal")
	self:RegisterLayout("Reversed Stacking",L["Reversed Stacking"],"horizontal")
	self:RegisterLayout("Columns",L["Columns"],"vertical")
	self:RegisterLayout("Reversed Columns",L["Reversed Columns"],"vertical")
	self:RegisterLayout("Six Pack",L["Six Pack"],"horizontal")
	self:RegisterLayout("Reversed Six Pack",L["Reversed Six Pack"],"vertical")
	self:RegisterLayout("Pipe",L["Pipe"],"horizontal")
	self:RegisterIcons("DKI")
	self:RegisterIcons("Blizzard")
	self:RegisterIcons("Ebon Blade")
	self.frame:Hide()
	self:SetEnabledState(db.enabled)
end

function Runes:OnEnable()
	self.frame:Show()
	self:CreateRunes()
	self:CreateBars()
		
 	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("RUNE_POWER_UPDATE")
	self:RegisterEvent("RUNE_TYPE_UPDATE")

	self:LoadSettings()
	Acherus:LoadPositions()
end

function Runes:OnDisable()
	self:UnregisterAllEvents()
	self.frame:Hide()
	self.baranchor:Hide()
end

function Runes:SetLayoutOrientationUpValue()
	if self.horizontal_layouts[db.layout] then layoutorientation = "HORIZONTAL"
	else layoutorientation = "VERTICAL" end
end

function Runes:UpdateLeftRunes()
	self.leftrunes = self.leftrunes or {}
	wipe(self.leftrunes)
	self.leftrunes[self.runeorder[1]] = true 
	self.leftrunes[self.runeorder[2]] = true 
	self.leftrunes[self.runeorder[5]] = true
end

function Runes:UpdateRuneOrder()
	if db.usecustomruneorder then 
		self.runeorder = db.customruneorder
	else 
		self.runeorder = db.presetruneorder 
	end
end

function Runes:UpdateLayoutAttributes()
	if self.horizontal_layouts[db.layout] then
		self.usabletext = db.usabletext
		barwidth = db.barwidth
		barheight = db.barheight
	elseif self.vertical_layouts[db.layout] then
		self.usabletext = gsub(db.usabletext,"(.)","%1\n")
		barwidth = db.barheight
		barheight = db.barwidth
	end
end

function Runes:UpdateIconTextures()
	self.icontextures = self.icondb[db.runeset]
end

function Runes:UpdateColorDB()
	self.barcolordb = self.barcolordb or {}
	self.textcolordb = self.textcolordb or {}
	wipe(self.barcolordb); wipe(self.textcolordb)
	self.barcolordb[RUNETYPE_BLOOD] = db.barbloodrunecolor
	self.barcolordb[RUNETYPE_UNHOLY] = db.barunholyrunecolor
	self.barcolordb[RUNETYPE_FROST] = db.barfrostrunecolor
	self.barcolordb[RUNETYPE_DEATH] = db.bardeathrunecolor
	self.textcolordb[RUNETYPE_BLOOD] = db.textbloodrunecolor
	self.textcolordb[RUNETYPE_UNHOLY] = db.textunholyrunecolor
	self.textcolordb[RUNETYPE_FROST] = db.textfrostrunecolor
	self.textcolordb[RUNETYPE_DEATH] = db.textdeathrunecolor
end

function Runes:UpdateBarTexts()
	for _,bar in pairs(self.bars) do
		self:UpdateBarText(bar)
	end
end

function Runes:UpdateEnabled()
	for i=1,6 do
		if db.enablebars then
			self.barparent:Show()
		else
			self.barparent:Hide()
		end

		if db.enableicons then self.runes[i]:Show()
		else self.runes[i]:Hide() end

		if db.enabletexts then
			self.bars[i].usabletext:Show()
			self.bars[i].onestext:Show()
			self.bars[i].hundrethstext:Show()
		else
			self.bars[i].usabletext:Hide()
			self.bars[i].onestext:Hide()
			self.bars[i].hundrethstext:Hide()
		end
	end
end

function Runes:RegisterIcons(name)
	assert(type(name) == "string")
	self.icondb = self.icondb or {}
	local pname = gsub(name," ","")
	if self.icondb[pname] then return end
	self.iconoptionvalues = self.iconoptionvalues or {}
	self.iconoptionvalues[pname] = name
	self.icondb[pname] = {
		[RUNETYPE_BLOOD] 	= format("%s%s%s",self.texturepath,pname,"Blood"),
		[RUNETYPE_UNHOLY] = format("%s%s%s",self.texturepath,pname,"Unholy"),
		[RUNETYPE_FROST] 	= format("%s%s%s",self.texturepath,pname,"Frost"),
		[RUNETYPE_DEATH] 	= format("%s%s%s",self.texturepath,pname,"Death"),
	}
end

function Runes:RegisterLayout(name,localeName,orientation)
	self.layoutsoptionvalues = self.layoutsoptionvalues or {}
	if self.layoutsoptionvalues[name] then return end
	self.layoutsoptionvalues[name] = localeName
	if orientation == "vertical" then
		self.vertical_layouts = self.vertical_layouts or {}
		self.vertical_layouts[name] = true
	elseif orientation == "horizontal" then
		self.horizontal_layouts = self.horizontal_layouts or {}
		self.horizontal_layouts[name] = true
	else --[[Do nothing]] end
end

function Runes:CreateSpark(bar)
	local spark = bar:CreateTexture(nil, "OVERLAY");
	spark:SetTexture("Interface\\CastingBar\\UI-CastingBar-Spark");
	spark:SetBlendMode("ADD")
	spark:Hide()
	return spark
end

function Runes:UpdateBarText(bar)
	bar.usabletext:SetFont(SM:Fetch("font",db.font),db.fontsize,unpack(db.fontflags))
	bar.onestext:SetFont(SM:Fetch("font",db.font),db.fontsize,unpack(db.fontflags))
	bar.hundrethstext:SetFont(SM:Fetch("font",db.font),db.fontsizehundreths,unpack(db.fontflags))
	bar.onestext:SetText("")
	bar.hundrethstext:SetText("")
	bar.usabletext:SetText(self.usabletext)
	bar.usabletext:SetVertexColor(unpack(self.textcolordb[GetRuneType(bar.id) or bar.type]))
	if db.basedonrune then
		bar.onestext:SetVertexColor(unpack(self.textcolordb[GetRuneType(bar.id) or bar.type]))
		bar.hundrethstext:SetVertexColor(unpack(self.textcolordb[GetRuneType(bar.id) or bar.type]))
	else
		bar.onestext:SetVertexColor(unpack(db.timercolor))
		bar.hundrethstext:SetVertexColor(unpack(db.timercolor))
	end
end

local border = {edgeFile="",edgeSize=7,insets={left=0,right=0,top=0,bottom=0}}

function Runes:UpdateBarAttributes()
	for i,bar in ipairs(self.bars) do
		bar:SetStatusBarTexture(SM:Fetch("statusbar",db.bartexture))
		bar:SetBackdropColor(1,1,1,db.backdropalpha)
		border.edgeFile = SM:Fetch("border",db.border)
		bar.border:SetBackdrop(border)
		bar.border:SetBackdropBorderColor(unpack(db.bordercolor))
		if self.horizontal_layouts[db.layout] then
			bar:SetOrientation("HORIZONTAL")
			bar:SetWidth(barwidth); 
			bar:SetHeight(barheight); 
			bar.spark:SetHeight(barheight * 3)
			bar.spark:SetWidth(20)
			bar.spark:SetTexCoord(0,1,0,1)
		elseif self.vertical_layouts[db.layout] then
			bar:SetOrientation("VERTICAL")
			bar:SetWidth(barwidth)
			bar:SetHeight(barheight)
			bar.spark:SetHeight(20)
			bar.spark:SetWidth(barwidth * 3)
			bar.spark:SetTexCoord(1,0,0,0,1,1,0,1)
		end
		bar:SetValue(db.barfillmethod == "DEPLETE" and 0 or 1)
		bar:SetAlpha(db.hidebarswhendone and 0 or (db.enablegradualfadein and db.gradualendalpha or 1))
		bar.spark:Hide(); 
	end
end

function Runes:SetBarTextJustification(bar,justification)
	bar.usabletext:SetJustifyH(justification)
	bar.onestext:SetJustifyH(justification)
	bar.hundrethstext:SetJustifyH(justification)
end

function Runes:CreateBars()
	if self.bars then return end
	self.bars = {}
	self.baranchor = Acherus:CreateAnchor("Bars","Runes")
	for id=1,6 do
		local bar = Acherus:CreateEnhancedStatusBar(self.frame:GetName().."Bar"..id,self.barparent,BackdropTemplateMixin and "BackdropTemplate")
		bar.id = id
		--rune.type = ceil(id/2)
		--rune.type = GetRuneType(id)
		bar.type = tonumber(GetRuneType(id))
		
		bar:SetFrameStrata("LOW")
		bar:SetBackdrop(Acherus.backdrop)

		bar.border = CreateFrame("Frame",nil,bar,BackdropTemplateMixin and "BackdropTemplate")
		local hes = EDGESIZE/2
		bar.border:SetPoint("TOPLEFT",bar,"TOPLEFT",-hes+1,hes-1)
		bar.border:SetPoint("BOTTOMRIGHT",bar,"BOTTOMRIGHT",hes-1,-hes+1)

		self.fontstringframe = self.fontstringframe or CreateFrame("Frame",nil,self.frame,BackdropTemplateMixin and "BackdropTemplate")
		bar.usabletext = self.fontstringframe:CreateFontString(nil,"OVERLAY")
		bar.onestext = self.fontstringframe:CreateFontString(nil,"OVERLAY")
		bar.onestext:SetWidth(20)
		bar.hundrethstext = self.fontstringframe:CreateFontString(nil,"OVERLAY")
		bar.hundrethstext:SetWidth(15)

		bar.spark = self:CreateSpark(bar)
		self.bars[id] = bar
	end
end

function Runes:UpdateRuneAttributes()
	for i,rune in ipairs(self.runes) do
		rune:SetWidth(db.iconsize); rune:SetHeight(db.iconsize)
		rune.icon:SetWidth(db.iconsize); rune.icon:SetHeight(db.iconsize)
		rune.icon:SetAlpha(db.iconalpha)
		rune.imprint:SetWidth(db.iconsize); rune.imprint:SetHeight(db.iconsize)
		if db.showimprint then rune.imprint:SetAlpha(db.imprintalpha); rune.imprint:Show() else rune.imprint:Hide() end
		rune.anchor:ClearAllPoints()
		rune.anchor:SetPoint("CENTER",rune,"CENTER")
	end
end

function Runes:CreateRunes()
	if self.runes then return end
	self.runes = {}
	for id=1,6 do
		local rune = CreateFrame("Frame",self.frame:GetName().."Rune"..id,self.frame,BackdropTemplateMixin and "BackdropTemplate")
		rune.id = id
		--rune.type = ceil(id/2)
		
		rune.type = tonumber(GetRuneType(id))
		
		local anchor = CreateFrame("Frame",nil,rune,BackdropTemplateMixin and "BackdropTemplate")
		anchor:SetWidth(1); anchor:SetHeight(1)
		anchor:SetPoint("CENTER")
		rune.anchor = anchor

		local imprint = rune:CreateTexture(nil,"ARTWORK")
		imprint:SetPoint("CENTER")
		imprint:SetVertexColor(0.33,0.33,0.33)
		rune.imprint = imprint

		local icon = rune:CreateTexture(nil,"OVERLAY")
		icon:SetPoint("CENTER",anchor,"CENTER")
		rune.icon = icon

		
		self.runes[id] = rune
	end
end

--[[
	Layouts
		Creating a layout
			1. Show or hide the bar anchor (for anchoring to other objects ie Triangle)
			2. Iterate runeorder
			3. Anchor runes to bars
			4. Anchor bars
			5. Anchor text positions
			6. Set text justification
]]

function Runes:ClearPointsForLayout()
	for i=1,6 do 
		local bar = self.bars[i]
		bar:ClearAllPoints()
		bar.usabletext:ClearAllPoints(); bar.onestext:ClearAllPoints(); bar.hundrethstext:ClearAllPoints()
		self.runes[i]:ClearAllPoints()
		bar.was10plus = false		
	end
end

function Runes:ApplyPipeLayout()
	self.baranchor:Show()
	local first = true
	local point1, point2, x, y = "LEFT", "RIGHT",(1 + db.runespacing) + db.iconsize,0
	for i,id in ipairs(self.runeorder) do
		local bar,rune = self.bars[id],self.runes[id]
		bar:SetReversed(false)
		rune:SetPoint("RIGHT",bar,"LEFT",-db.barrunespacing,0)
		bar:SetPoint(point1, first and self.baranchor or self.bars[self.runeorder[i-1]], point2, x, y)
		bar.usabletext:ClearAllPoints(); bar.onestext:ClearAllPoints(); bar.hundrethstext:ClearAllPoints()

		bar.usabletext:SetPoint("LEFT",bar,"LEFT",db.usableposition - 2,db.usableposition2)
		bar.hundrethstext:SetPoint("LEFT",bar,"LEFT",db.hundrethsposition - 5,db.hundrethsposition2 + (-1*(barheight- db.fontsize)/2))
		bar.onestext:SetPoint("LEFT",bar,"LEFT",db.onesposition - 2,db.onesposition2)
		self:SetBarTextJustification(bar,"LEFT")
		first = nil
	end
end

function Runes:ApplyReversedSixPackLayout()
	self.baranchor:Show()
	local first = true
	local prev
	for i,id in ipairs(self.runeorder) do
		local bar,rune = self.bars[id],self.runes[id]
		if i % 2 == 1 then
			bar:SetReversed(false)
			rune:SetPoint("TOP",bar,"BOTTOM",0,db.barrunespacing)
		else
			bar:SetReversed(true)
			rune:SetPoint("BOTTOM",bar,"TOP",0,-db.barrunespacing)
		end
		if bar:IsReversed() then
			bar:SetPoint("TOP",prev,"BOTTOM",0,-2 * db.iconsize)
			bar.usabletext:SetPoint("TOP",bar,"TOP",db.reversedusableposition2,db.reversedusableposition)
			bar.hundrethstext:SetPoint("TOP",bar,"TOP",db.reversedhundrethsposition2,-db.reversedhundrethsposition)
			bar.onestext:SetPoint("TOP",bar,"TOP",db.reversedonesposition2,-db.reversedonesposition)
		else
			bar:SetPoint("LEFT",first and self.baranchor or prev,"RIGHT",db.runespacing,0)
			bar.usabletext:SetPoint("BOTTOM",bar,"BOTTOM",db.usableposition2,db.usableposition)
			bar.hundrethstext:SetPoint("BOTTOM",bar,"BOTTOM",db.hundrethsposition2,db.hundrethsposition - 13)
			bar.onestext:SetPoint("BOTTOM",bar,"BOTTOM",db.onesposition2,db.onesposition + 8)
			prev = bar
		end
		self:SetBarTextJustification(bar,"CENTER")
		first = nil
	end
end

function Runes:ApplySixPackLayout()
	self.baranchor:Show()
	local first = true
	local prev
	for i,id in ipairs(self.runeorder) do
		local bar,rune = self.bars[id],self.runes[id]
		if i % 2 == 1 then
			bar:SetReversed(true)
			rune:SetPoint("LEFT",bar,"RIGHT",-db.barrunespacing,0)
		else
			bar:SetReversed(false)
			rune:SetPoint("RIGHT",bar,"LEFT",db.barrunespacing,0)
		end
		if bar:IsReversed() then
			bar:SetPoint("TOPRIGHT",first and self.baranchor or prev,"BOTTOMRIGHT",0,-db.runespacing-1)
			bar.usabletext:SetPoint("RIGHT",bar,"RIGHT",-db.reversedusableposition,db.reversedusableposition2)
			bar.hundrethstext:SetPoint("RIGHT",bar,"RIGHT",-db.reversedhundrethsposition + 17,db.reversedhundrethsposition2 + (-1*(barheight- db.fontsize)/2))
			bar.onestext:SetPoint("RIGHT",bar,"RIGHT",-db.reversedonesposition,db.reversedonesposition2)
			prev = bar
		else
			bar:SetPoint("LEFT",prev,"RIGHT",2*db.iconsize,0)
			bar.usabletext:SetPoint("LEFT",bar,"LEFT",db.usableposition,db.usableposition2)
			bar.hundrethstext:SetPoint("LEFT",bar,"LEFT",db.hundrethsposition - 7,db.hundrethsposition2 + (-1*(barheight- db.fontsize)/2))
			bar.onestext:SetPoint("LEFT",bar,"LEFT",db.onesposition - 2,db.onesposition2)
		end
		self:SetBarTextJustification(bar,"LEFT")
		bar:Show()
		first = nil
	end
end


function Runes:ApplyReversedColumnsLayout()
	self.baranchor:Show()
	local first = true
	local point1, point2, x, y = "BOTTOMLEFT", "BOTTOMRIGHT",(1+db.runespacing),0
	for i,id in ipairs(self.runeorder) do
		local bar,rune = self.bars[id],self.runes[id]
		bar:SetReversed(true)
		rune:SetPoint("BOTTOM",bar,"TOP",0,-db.barrunespacing)
		bar:SetPoint(point1, first and self.baranchor or self.bars[self.runeorder[i-1]], point2, x, y)
		bar.usabletext:ClearAllPoints(); bar.onestext:ClearAllPoints(); bar.hundrethstext:ClearAllPoints()
		self:SetBarTextJustification(bar,"CENTER")
		bar.usabletext:SetPoint("TOP",bar,"TOP",db.reversedusableposition2,db.reversedusableposition)
		bar.hundrethstext:SetPoint("TOP",bar,"TOP",db.reversedhundrethsposition2,-db.reversedhundrethsposition)
		bar.onestext:SetPoint("TOP",bar,"TOP",db.reversedonesposition2,-db.reversedonesposition)
		first = nil
	end
end

function Runes:ApplyReversedStackingLayout()
	self.baranchor:Show()
	local first = true
	local point1, point2, x, y = "TOPLEFT", "BOTTOMLEFT",0,-(1 + db.runespacing)
	for i,id in ipairs(self.runeorder) do
		local bar,rune = self.bars[id],self.runes[id]
		bar:SetReversed(true)
		rune:SetPoint("LEFT",bar,"RIGHT",db.barrunespacing,0)
		bar:SetPoint(point1, first and self.baranchor or self.bars[self.runeorder[i-1]], point2, x, y)
		bar.usabletext:SetPoint("RIGHT",bar,"RIGHT",-db.reversedusableposition,db.reversedusableposition2)
		bar.hundrethstext:SetPoint("RIGHT",bar,"RIGHT",-db.reversedhundrethsposition + 17,db.reversedhundrethsposition2 + (-1*(barheight- db.fontsize)/2))
		bar.onestext:SetPoint("RIGHT",bar,"RIGHT",-db.reversedonesposition,db.reversedonesposition2)
		self:SetBarTextJustification(bar,"LEFT")
		first = nil
	end
end

function Runes:ApplyColumnsLayout()
	self.baranchor:Show()
	local first = true
	local point1, point2, x, y = "BOTTOMLEFT", "BOTTOMRIGHT",(1+db.runespacing),0
	for i,id in ipairs(self.runeorder) do
		local bar,rune = self.bars[id],self.runes[id]
		bar:SetReversed(false)
		rune:SetPoint("TOP",bar,"BOTTOM",0,-db.barrunespacing)
		bar:SetPoint(point1, first and self.baranchor or self.bars[self.runeorder[i-1]], point2, x, y)
		bar.usabletext:SetPoint("BOTTOM",bar,"BOTTOM",db.usableposition2,db.usableposition)
		bar.hundrethstext:SetPoint("BOTTOM",bar,"BOTTOM",db.hundrethsposition2,db.hundrethsposition - 13)
		bar.onestext:SetPoint("BOTTOM",bar,"BOTTOM",db.onesposition2,db.onesposition + 8)
		self:SetBarTextJustification(bar,"CENTER")
		first = nil
	end
end


function Runes:ApplyStackingLayout()
	self.baranchor:Show()
	local first = true
	local point1, point2, x, y = "TOPLEFT", "BOTTOMLEFT",0,-(1 + db.runespacing)
	for i,id in ipairs(self.runeorder) do
		local bar,rune = self.bars[id],self.runes[id]
		bar:SetReversed(false)
		rune:SetPoint("RIGHT",bar,"LEFT",-db.barrunespacing,0)
		bar:SetPoint(point1, first and self.baranchor or self.bars[self.runeorder[i-1]], point2, x, y)
		bar.usabletext:SetPoint("LEFT",bar,"LEFT",db.usableposition - 2,db.usableposition2)
		bar.hundrethstext:SetPoint("LEFT",bar,"LEFT",db.hundrethsposition - 5,db.hundrethsposition2 + (-1*(barheight- db.fontsize)/2))
		bar.onestext:SetPoint("LEFT",bar,"LEFT",db.onesposition - 2,db.onesposition2)
		self:SetBarTextJustification(bar,"LEFT")
		first = nil
	end
end

-- For triangle layout
-- TODO: Don't rely on TOPLEFT as origin. Convert points to correct locations so that scaling the runes or triangle doesn't offset the positions.
function Runes:GetTriangleRunePoints(i)
	local t_edgelength = Acherus.db.profile.settings.runicpower.t_edgelength
	local t_e_half = t_edgelength / 2
	local x = t_e_half * cos(pi / 3)
	local y = t_e_half * sin(pi / 3) * -1
	local xOff = .5 * (db.iconsize/ tan(pi/3))
	local yOff = .5 * db.iconsize
	local triangle = self.RunicPower.triangle
	if i == 1 then
		return "TOPRIGHT",triangle,"TOPLEFT",x - xOff - (db.runespacing/ tan(pi / 3)), y + yOff + db.runespacing
	elseif i == 2 then
		return "TOPRIGHT",triangle,"TOPLEFT",x + xOff + (db.runespacing / tan(pi / 3)), y - yOff - db.runespacing
	elseif i == 3 then
		return "TOPLEFT",triangle,"TOPLEFT",t_edgelength - x + xOff + (db.runespacing/ tan(pi / 3)), y + yOff + db.runespacing
	elseif i == 4 then
		return "TOPLEFT",triangle,"TOPLEFT",t_edgelength - x - xOff - (db.runespacing/ tan(pi / 3)), y - yOff - db.runespacing
	elseif i == 5 then
		return "BOTTOMRIGHT",triangle,"TOPLEFT",t_e_half - db.runespacing, 0
	elseif i == 6 then
		return "BOTTOMLEFT",triangle,"TOPLEFT",t_e_half + db.runespacing, 0
	end
end

function Runes:ApplyTriangleLayout()
	self.baranchor:Hide()
	for i,id in ipairs(self.runeorder) do
		local bar,rune = self.bars[id],self.runes[id]
		if self.leftrunes[id] then
			bar:SetReversed(true)
		else
			bar:SetReversed(false)
		end
		rune:SetPoint(self:GetTriangleRunePoints(i))
		if self.leftrunes[id] then
			bar:SetPoint("RIGHT",rune,"LEFT",-db.barrunespacing,0)
			bar.usabletext:SetPoint("RIGHT",bar,"RIGHT",-db.reversedusableposition,db.reversedusableposition2)
			bar.hundrethstext:SetPoint("RIGHT",bar,"RIGHT",-db.reversedhundrethsposition + 17,db.reversedhundrethsposition2 + (-1*(barheight- db.fontsize)/2))
			bar.onestext:SetPoint("RIGHT",bar,"RIGHT",-db.reversedonesposition,db.reversedonesposition2)
		else
			bar:SetPoint("LEFT",rune,"RIGHT",db.barrunespacing,0)
			bar.usabletext:SetPoint("LEFT",bar,"LEFT",db.usableposition,db.usableposition2)
			bar.hundrethstext:SetPoint("LEFT",bar,"LEFT",db.hundrethsposition - 7,db.hundrethsposition2 + (-1*(barheight- db.fontsize)/2))
			bar.onestext:SetPoint("LEFT",bar,"LEFT",db.onesposition - 2,db.onesposition2)
		end
		self:SetBarTextJustification(bar,"LEFT")
	end
end

function Runes:OnUpdate(elapsed)
	local go
	for i=1,6 do
		local bar,rune = Runes.bars[i],Runes.runes[i]
		if bar.active or bar.testactive then
			local sec,timeleft,start,duration,ready
			if bar.active then
				start, duration, ready = GetRuneCooldown(bar.id)
				timeleft = start + duration - GetTime()
			elseif bar.testactive then
				bar.testtimeleft = bar.testtimeleft - elapsed
				timeleft = bar.testtimeleft
				duration = 10
			end
			sec = floor(timeleft)
			bar.onestext:SetText(max(sec,0))
			if db.enablegradualfadein then
				local alpha = timeleft >= db.gradualendtime and db.gradualstartalpha+(db.gradualendalpha-db.gradualstartalpha)*(1-((timeleft - db.gradualendtime)/(10 - db.gradualendtime))) or db.gradualendalpha
					if tonumber(alpha) then
						
						
						if alpha > 1 then
						--print("Alpha",alpha)
						alpha = 1
						end
						
						if alpha < 0 then
						alpha = 0
						--print("Alpha",alpha)
						end
						bar:SetAlpha(alpha)	
					
					else
						--print("Alpha",alpha)
					end
				
			
			else bar:SetAlpha(1) end

			if db.enableicongradualfadein then
				local alpha = timeleft >= db.icongradualendtime and db.icongradualstartalpha+(db.icongradualendalpha-db.icongradualstartalpha)*(1-((timeleft - db.icongradualendtime)/(10 - db.icongradualendtime))) or db.icongradualendalpha
				rune.icon:SetAlpha(alpha)
			else rune.icon:SetAlpha(1) end

			local barperc = db.barfillmethod == "DEPLETE" and timeleft / duration or 1 - (timeleft / duration)
			local moveperc = db.movemethod == "OUT_TO_ORIGIN" and timeleft / duration or 1 - (timeleft / duration)
			bar:SetValue(barperc)
			
			bar.spark:ClearAllPoints()
			if (barperc <= 1.0) and db.showspark then bar.spark:Show() end

			local IsReversed = bar:IsReversed()
			local sparkpoint = layoutorientation == "HORIZONTAL" and barperc * barwidth or barperc * barheight
			sparkpoint = IsReversed and sparkpoint * -1 or sparkpoint
			local moveoutdistance = IsReversed and db.moveoutdistance * -1 or db.moveoutdistance
			if layoutorientation == "HORIZONTAL" then
				bar.spark:SetPoint("CENTER",bar,IsReversed and "RIGHT" or "LEFT",sparkpoint,-1) 
				if db.moveout then
					rune.anchor:ClearAllPoints()
					rune.anchor:SetPoint("CENTER",rune,"CENTER",moveoutdistance * moveperc,0)
				end
			else
				bar.spark:SetPoint("CENTER",bar,IsReversed and "TOP" or "BOTTOM",1,sparkpoint) 
				if db.moveout then
					rune.anchor:ClearAllPoints()
					rune.anchor:SetPoint("CENTER",rune,"CENTER",0,moveoutdistance* moveperc)
				end
			end

			if db.usehundreths then bar.hundrethstext:SetFormattedText(db.hundrethsformat, (timeleft - sec) * 100) end
			local is10plus = (sec >= 10)
			if is10plus ~= bar.was10plus then
				local property, textframe, adjustLeft
				if bar:IsReversed() then
					property = "reversedtwodigitoffset"
					textframe = bar.onestext
					adjustLeft = true
				else
					property = "twodigitoffset"
					textframe = bar.hundrethstext
					adjustLeft = false
				end
				local point, relTo, relPoint, x, y = textframe:GetPoint(1)
				local offset = db[property]
				if adjustLeft then offset = -offset end -- left movement is negation
				if (not is10plus) then offset = -offset end -- restoring from 10+ to normal is negation
				x = x + offset
				textframe:SetPoint(point, relTo, relPoint, x, y)
			end
			bar.was10plus = is10plus
			bar.usabletext:SetText("")
			if ready or timeleft < 0 then Runes:OnRuneUsable(bar)
			else go = true end
		end
	end
	if not go then Runes.frame:SetScript("OnUpdate",nil) end
end

function Runes:OnRuneUsable(bar)
	bar.active = false
	bar.testactive = false
	bar.spark:Hide()
	bar.usabletext:SetText(self.usabletext)
	if db.enableusablepulse then Acherus:AnimateTextPulse(bar.usabletext,db.fontpulseuptime,db.fontpulsedowntime,db.fontsize,db.fontsizepulse) end
	bar.hundrethstext:SetText("")
	bar.onestext:SetText("")
	bar:SetAlpha(db.enablegradualfadein and db.gradualendalpha or 1)

	local rune = self.runes[bar.id]
	rune.anchor:ClearAllPoints()
	rune.anchor:SetPoint("CENTER",rune,"CENTER")
	rune.icon:SetAlpha(db.iconalpha)
	icon_behaviors[db.behavioronusable](rune.icon)

	if db.enablebars and bar:GetAlpha() > 0 and db.hidebarswhendone then UIFrameFadeOut(bar,1,db.statusbaralpha,0) end -- add option for this
end

function Runes:OnRuneUnusable(bar,testupdate)
	UIFrameFadeRemoveFrame(bar)
	bar:SetAlpha(db.enablegradualfadein and db.gradualstartalpha or 1)
	bar.usabletext:SetText("")

	if testupdate then bar.testactive = true; bar.active = false
	else bar.active = true; bar.testactive = false end
	icon_behaviors[db.behavioronunusable](self.runes[bar.id].icon)
	if not self.frame:GetScript("OnUpdate") then self.frame:SetScript("OnUpdate",self.OnUpdate) end
end

function Runes:UpdateRunePower(rune,usable)
	if usable or not rune or not self.runes[rune] then return end
	self:OnRuneUnusable(self.bars[rune])
end

function Runes:RUNE_POWER_UPDATE(_,rune,usable)
--print (_,rune,"type ", GetRuneType(rune),usable)
	self:UpdateRunePower(rune,usable)
end

function Runes:UpdateRuneType(rune)
	rune = self.runes[rune]
	local runeType = GetRuneType(rune.id)
	local t_r,t_g,t_b = unpack(self.textcolordb[runeType or rune.type])
	local b_r,b_g,b_b = unpack(self.barcolordb[runeType or rune.type])

	rune.icon:SetTexture(self.icontextures[runeType])
	rune.icon:SetWidth(db.iconsize); rune.icon:SetHeight(db.iconsize)
	rune.imprint:SetTexture(self.icontextures[runeType])
	if runeType == RUNETYPE_DEATH then
		rune.icon:SetTexCoord(0,1,0,1)
		icon_behaviors[db.behaviornormaltodeath](rune.icon)
		rune.isDeath = true
	elseif rune.isDeath then
		icon_behaviors[db.behaviordeathtonormal](rune.icon)
		rune.isDeath = nil
	end

	local bar = self.bars[rune.id]
	bar:SetStatusBarColor(b_r,b_g,b_b,db.statusbaralpha)
	bar.usabletext:SetVertexColor(t_r,t_g,t_b)
	if db.basedonrune then
		bar.onestext:SetVertexColor(t_r,t_g,t_b)
		bar.hundrethstext:SetVertexColor(t_r,t_g,t_b)
	end
end

function Runes:RUNE_TYPE_UPDATE(_,rune)
--print (_,rune,usable)
	self:UpdateRuneType(rune)
end

function Runes:UpdateAllRunes()
	for id=1,6 do self:UpdateRuneType(id)
	self:UpdateRunePower(id,select(3,GetRuneCooldown(id))) end
end

-- Quick hack
Runes.UpdateType = CreateFrame("Frame",nil,Runes.frame,BackdropTemplateMixin and "BackdropTemplate")
local time
local UpdateTypeFunc = function(self,elapsed)
	time = time + elapsed
	for id=1,6 do Runes:UpdateRuneType(id) end
	if time > 2 then self:SetScript("OnUpdate",nil) end
end

function Runes:PLAYER_ENTERING_WORLD()
	for id=1,6 do self:UpdateRuneType(id) end
	time = 0
	self.UpdateType:SetScript("OnUpdate",UpdateTypeFunc)
	self.pGUID = UnitGUID("player")
end

--[[
	Options
]]

local function IsDisabled()
	return not db.enabled
end

function Runes:GetSettingsTable()
	return {
		type = "group",
		name = L["Runes"],
		order = 100,
		childGroups = "tab",
		args = {
			enabled = {
				type = "toggle",
				name = L["Enabled"],
				order = 1,
				handler = self,
				width = "half",
				get = "IsEnabled",
				set = function() db.enabled = not db.enabled
						if db.enabled then self:Enable() else self:Disable() end
				end,
			},
			testrunes = {
				type = "execute",
				name = L["Test"],
				desc = L["Starts all rune bars"],
				order = 51,
				disabled = IsDisabled,
				width = "half",
				func = function() for k,bar in ipairs(Runes.bars) do self:OnRuneUnusable(bar,true); bar.testtimeleft = 10; end end,
			},
			layout = {
				type = "select",
				name = L["Layouts"],
				desc = function()
					self.temp = self.temp or {}
					wipe(self.temp)
					for name in pairs(self.horizontal_layouts) do insert(self.temp,name) end
					sort(self.temp)
					self.temp2 = self.temp2 or {}
					wipe(self.temp2)
					for name in pairs(self.vertical_layouts) do insert(self.temp2,name) end
					sort(self.temp2)
					return format(L["|cffffd200Horizontal|r: %s\n|cffffd200Vertical|r: %s"],concat(self.temp,", "),concat(self.temp2,", ")) end,
				order = 50,
				values = function() return self.layoutsoptionvalues end,
				disabled = IsDisabled,
			},
			scale = {
				type = "range",
				name = L["Scale"],
				order = 55,
				min = 0.1,
				max = 3,
				step = 0.1,
				width = "half",
				disabled = IsDisabled,
			},
			bars = {
				type = "group",
				name = L["Bars"],
				disabled = IsDisabled,
				args = {
					enablebars = {
						type = "toggle",
						name = L["Enabled"],
						order = 25,
					},
					barsgroup = {
						type = "group",
						name = "",
						order = 35,
						inline = true,
						disabled = function() return not db.enablebars end,
						args = {
							barheader = {
								type = "header",
								name = L["General"],
								order = 50,
							},
							barwidth = {
								type="range",
								name = L["Bar width"],
								order = 100,
								min = 20,
								max = 500,
								step = 1,
							},
							barheight = {
								type = "range",
								name = L["Bar height"],
								order = 200,
								min = 5,
								max = 30,
								step = 1,
							},
							barfillmethod = {
								type = "select",
								name = L["Bar fill method"],
								order = 300,
								values = {
									["GROW"] = L["Grow"],
									["DEPLETE"] = L["Deplete"],
								}
							},
							bartexture = {
								type = "select",
								name = L["Bar texture"],
								order = 400,
								dialogControl = "LSM30_Statusbar",
								values = "GetStatusBarTextures",
							},
							statusbaralpha = {
								type = "range",
								name = L["Status bar alpha"],
								order = 430,
								min = 0,
								max = 1,
								step = 0.01
							}, 
							backdropalpha = {
								type = "range",
								name = L["Backdrop alpha"],
								order = 450,
								min = 0,
								max = 1,
								step = 0.01,
							},
							hidebarswhendone = {
								type = "toggle",
								name = L["Hide bars when ready"],
								order = 500,
							},
							showspark = {
								type = "toggle",
								name = L["Show spark"],
								order = 550,
							},
							border = {
								type = "select",
								name = L["Bar border"],
								order = 560,
								dialogControl = "LSM30_Border",
								values = "GetBorders",
							},
							bordercolor = {
								type = "color",
								name = L["Border color"],
								order = 570,
								hasAlpha = true,
							},
							colorsheader = {
								type = "header",
								name = L["Colors"],
								order = 600,
							},
							barbloodrunecolor = {
								type = "color",
								name = L["Blood rune"],
								order = 700,
							},
							barunholyrunecolor = {
								type = "color",
								name = L["Unholy rune"],
								order = 800,
							},
							barfrostrunecolor = {
								type = "color",
								name = L["Frost rune"],
								order = 900,
							},
							bardeathrunecolor = {
								type = "color",
								name = L["Death rune"],
								order = 1000,
							},
							gradualfadein_header = {
								type = "header",
								name = L["Gradual Fade In"],
								order = 1100,
							},
							gradualfadein_desc = {
								type = "description",
								name = L["From 10 seconds (the moment a rune is used) to End Time the alpha of the bar fades from Start Alpha to End Alpha"],
								order = 1150,
							},
							enablegradualfadein = {
								type = "toggle",
								name = L["Enable"],
								order = 1200,
							},
							gradualstartalpha = {
								type = "range",
								name = L["Start alpha"],
								order = 1300,
								min = 0,
								max = 1,
								step = 0.1,
								disabled = function() return not db.enablegradualfadein end,
							},
							gradualendalpha = {
								type = "range",
								name = L["End alpha"],
								order = 1400,
								min = 0,
								max = 1,
								step = 0.1,
								disabled = function() return not db.enablegradualfadein end,
							},
							gradualendtime = {
								type = "range",
								name = L["End time"],
								order = 1500,
								min = 1,
								max = 10,
								step = 1,
								disabled = function() return not db.enablegradualfadein end,
							},
						},
					},
				},
			},
			icons = {
				type = "group",
				name = L["Icons"],
				disabled = IsDisabled,
				args = {
					enableicons = {
						type = "toggle",
						name = L["Enabled"],
						order = 30,
					},
					iconsgroup = {
						type = "group",
						order = 35,
						name = "",
						inline = true,
						disabled = function() return not db.enableicons end,
						args = {
							iconheader = {
								type = "header",
								name = L["General"],
								order = 40,
							},
							showimprint = {
								type = "toggle",
								name = L["Show imprint"],
								order = 50,
							},
							iconsize = {
							 	type = "range",
								name = L["Icon size"],
								order = 100,
								min = 10,
								max = 50,
								step = 1,
							},
							iconsizepulse = {
								type = "range",
								name = L["Icon pulse size"],
								desc = L["How big the rune icon pulses. Keep this bigger than icon size"],
								order = 200,
								min = 40,
								max = 300,
								step = 5,
							},
							iconpulseuptime = {
								type = "range",
								name = L["Icon scale up time"],
								desc = L["How long it takes to scale up to icon pulse size"],
								order = 300,
								min = 0.1,
								max = 1,
								step = 0.1,
							},
							iconpulsedowntime = {
								type = "range",
								name = L["Icon scale down time"],
								desc = L["How long it takes to scale down to icon size after it pulses"],
								order = 400,
								min = 0.1,
								max = 1,
								step = 0.1,
							},
							spindegree = {
								type = "range",
								name = L["Spin degree"],
								desc = L["How many degrees the icon spins"],
								order = 450,
								min = -2000,
								max = 2000,
								step = 10,
							},
							iconalpha = {
								type = "range",
								name = L["Icon alpha"],
								order = 460,
								min = 0.1,
								max = 1,
								step = 0.1,
							},
							imprintalpha = {
								type = "range",
								name = L["Imprint alpha"],
								order = 465,
								min = 0.1,
								max = 1,
								step = 0.1,
								disabled = function() return not db.showimprint end,
							},
							behaviorheader = {
								type = "header",
								name = L["Behavior"],
								order = 466,
							},
							behaviordeathtonormal = {
								type = "select",
								name = L["Death to normal"],
								order = 470,
								values = icon_behaviors_values,
							},
							behaviornormaltodeath = {
								type = "select",
								name = L["Normal to death"],
								order = 475,
								values = icon_behaviors_values,
							},
							behavioronusable = {
								type = "select",
								name = L["On usable"],
								order = 480,
								values = icon_behaviors_values,
							},
							behavioronunusable = { 
								type = "select",
								name = L["On unusable"],
								order = 485,
								values = icon_behaviors_values,
							},
							linearheader = {
								type = "header",
								name = L["Linear animation"],
								order = 500,
							},
							moveout = {
								type = "toggle",
								name = L["Enable"],
								order = 510,
							},
							movemethod = {
								type = "select",
								name = L["Move method"],
								order = 520,
								values = {["OUT_TO_ORIGIN"] = L["Out to origin"],["ORIGIN_TO_OUT"] = L["Origin to out"]},
								disabled = function() return not db.moveout end,
							},
							moveoutdistance = {
								type = "range",
								name = L["Extend distance"],
								order = 530,
								min = 10,
								max = 500,
								step = 1,
								disabled = function() return not db.moveout end,
							},
							gradualfadein_header = {
								type = "header",
								name = L["Gradual Fade In"],
								order = 575,
							},
							gradualfadein_desc = {
								type = "description",
								name = L["From 10 seconds (the moment a rune is used) to End Time the alpha of the icon fades from Start Alpha to End Alpha"],
								order = 576,
							},
							enableicongradualfadein = {
								type = "toggle",
								name = L["Enable"],
								order = 577,
							},
							icongradualstartalpha = {
								type = "range",
								name = L["Start alpha"],
								order = 578,
								min = 0,
								max = 1,
								step = 0.1,
								disabled = function() return not db.enableicongradualfadein end,
							},
							icongradualendalpha = {
								type = "range",
								name = L["End alpha"],
								order = 579,
								min = 0,
								max = 1,
								step = 0.1,
								disabled = function() return not db.enableicongradualfadein end,
							},
							icongradualendtime = {
								type = "range",
								name = L["End time"],
								order = 580,
								min = 1,
								max = 10,
								step = 1,
								disabled = function() return not db.enableicongradualfadein end,
							},
							runeset_header = {
								type = "header",
								name = L["Rune set"],
								order = 590,
							},
							runeset = {
								type = "select",
								name = L["Set"],
								order = 600,
								values = function() return self.iconoptionvalues end,
							},
							bloodicon = {
								type = "description",
								name = L["Blood"],
								order = 700,
								image = function() return self.icontextures[RUNETYPE_BLOOD] end,
								imageWidth = 22,
								imageHeight = 22,
							},
							unholyicon = {
								type = "description",
								name = L["Unholy"],
								order = 800,
								image = function() return self.icontextures[RUNETYPE_UNHOLY] end,
								imageWidth = 22,
								imageHeight = 22,
							},
							frosticon = {
								type = "description",
								name = L["Frost"],
								order = 900,
								image = function() return self.icontextures[RUNETYPE_FROST] end,
								imageWidth = 22,
								imageHeight = 22,
							},
							deathicon = {
								type = "description",
								name = L["Death"],
								order = 1000,
								image = function() return self.icontextures[RUNETYPE_DEATH] end,
								imageWidth = 22,
								imageHeight = 22,
							},
						},
					},
				},
			},
			text = {
				type = "group",
				name = L["Text"],
				disabled = IsDisabled,
				args = {
					enabletexts = {
						type = "toggle",
						name = L["Enabled"],
						order = 30,
					},
					textsgroup = {
						type = "group",
						name = "",
						order = 40,
						inline = true,
						disabled = function() return not db.enabletexts end,
						args = {
							textheader = {
								type = "header",
								name = L["General"],
								order = 40,
							},
							usabletext = {
								type = "input",
								name = "Usable text",
								order = 50,
							},
							enableusablepulse = {
								type = "toggle",
								name = L["Enable usable pulse"],
								order = 75,
							},
							usehundreths = {
								type = "toggle",
								name = L["Enable hundreths"],
								order = 80,
							},
							fontsizehundreths = {
								type = "range",
								name = L["Hundreths font size"],
								order = 90,
								min = 1,
								max = 7,
								step = 1,
							},
							fontsize = {
								type = "range",
								name = L["Font size"],
								desc = L["Usable/Seconds text font size"],
								order = 100,
								min = 1,
								max = 40,
								step = 1,
							},
							fontsizepulse = {
								type = "range",
								name = L["Font pulse size"],
								order = 200,
								min = 7,
								max = 40,
								step = 1,
								disabled = function() return not db.enableusablepulse end,
							},
							fontpulseuptime = {
								type = "range",
								name = L["Font pulse up time"],
								order = 300,
								min = 0.1,
								max = 1,
								step = 0.1,
								disabled = function() return not db.enableusablepulse end,
							},
							fontpulsedowntime = {
								type = "range",
								name = L["Font pulse down time"],
								order = 400,
								min = 0.1,
								max = 1,
								step = 0.1,
								disabled = function() return not db.enableusablepulse end,
							},
							normalposition_group = {
								name = L["Normal positions"],
								type = "group",
								order = 420,
								args = {
									usableposition = {
										type = "range",
										name = L["Usable position"],
										desc = L["X direction for horizontal layouts. Y direction for vertical layouts"],
										order = 450,
										min = -500,
										max = 500,
										step = 1,
									},
									usableposition2 = {
										type = "range",
										name = L["Usable position 2"],
										desc = L["Y direction for horizontal layouts. X direction for vertical layouts"],
										order = 451,
										min = -500,
										max = 500,
										step = 1,
									},
									onesposition = {
										type = "range",
										name = L["Seconds position"],
										desc = L["X direction for horizontal layouts. Y direction for vertical layouts"],
										order = 460,
										min = -500,
										max = 500,
										step = 1,
									},
									onesposition2 = {
										type = "range",
										name = L["Seconds position 2"],
										desc = L["Y direction for horizontal layouts. X direction for vertical layouts"],
										order = 461,
										min = -500,
										max = 500,
										step = 1,
									},
									hundrethsposition = {
										type = "range",
										name = L["Hundreths position"],
										desc = L["X direction for horizontal layouts. Y direction for vertical layouts"],
										order = 480,
										min = -500,
										max = 500,
										step = 1,
										disabled = function() return not db.usehundreths end,
									},
									hundrethsposition2 = {
										type = "range",
										name = L["Hundreths position 2"],
										desc = L["Y direction for horizontal layouts. X direction for vertical layouts"],
										order = 481,
										min = -500,
										max = 500,
										step = 1,
										disabled = function() return not db.usehundreths end,
									},
									twodigitoffset = {
										type = "range",
										name = L["2-digit offset"],
										desc = L["X adjustment right for hundreths, when seconds are 2 digits."],
										order = 482,
										min = -250,
										max = 250,
										step = 0.5,
										disabled = function() return not db.usehundreths end,
									},
								},
							},
							reversedposition_group = {
								type = "group",
								name = L["Reversed positions"],
								order = 595,
								args = {
									reversedusableposition = {
										type = "range",
										name = L["Usable position"],
										desc = L["X direction for horizontal layouts. Y direction for vertical layouts"],
										order = 450,
										min = -500,
										max = 500,
										step = 1,
									},
									reversedusableposition2 = {
										type = "range",
										name = L["Usable position 2"],
										desc = L["Y direction for horizontal layouts. X direction for vertical layouts"],
										order = 451,
										min = -500,
										max = 500,
										step = 1,
									},
									reversedonesposition = {
										type = "range",
										name = L["Seconds position"],
										desc = L["X direction for horizontal layouts. Y direction for vertical layouts"],
										order = 460,
										min = -500,
										max = 500,
										step = 1,
									},
									reversedonesposition2 = {
										type = "range",
										name = L["Seconds position 2"],
										desc = L["Y direction for horizontal layouts. X direction for vertical layouts"],
										order = 461,
										min = -500,
										max = 500,
										step = 1,
									},
									reversedhundrethsposition = {
										type = "range",
										name = L["Hundreths position"],
										desc = L["X direction for horizontal layouts. Y direction for vertical layouts"],
										order = 480,
										min = -500,
										max = 500,
										step = 1,
										disabled = function() return not db.usehundreths end,
									},
									reversedhundrethsposition2 = {
										type = "range",
										name = L["Hundreths position 2"],
										desc = L["Y direction for horizontal layouts. X direction for vertical layouts"],
										order = 481,
										min = -500,
										max = 500,
										step = 1,
										disabled = function() return not db.usehundreths end,
									},
									reversedtwodigitoffset = {
										type = "range",
										name = L["2-digit offset"],
										desc = L["X adjustment left, when seconds are 2 digits."],
										order = 482,
										min = -250,
										max = 250,
										step = 0.5,
									},									
								},
							},
							font = {
								type = "select",
								name = L["Font"],
								order = 600,
								dialogControl = "LSM30_Font",
								values = "GetFonts",
							},
							colorsheader = {
								type = "header",
								name = L["Colors"],
								order = 800,
							},
							textbloodrunecolor = {
								type = "color",
								name = L["Blood rune"],
								order = 900,
							},
							textunholyrunecolor = {
								type = "color",
								name = L["Unholy rune"],
								order = 1000,
							},
							textfrostrunecolor = {
								type = "color",
								name = L["Frost rune"],
								order = 1100,
							},
							textdeathrunecolor = {
								type = "color",
								name = L["Death rune"],
								order = 1200,
							},
							basedonrune = {
								type = "toggle",
								order = 1300,
								name = L["Base timer on rune"],
							},
							timercolor = {
								type = "color",
								name = L["Timer color"],
								order = 1400,
								disabled = function() return db.basedonrune end,
							},
						},
					},
				},
			},
			spacing = {
				type = "group",
				name = L["Spacing"],
				disabled = IsDisabled,
				args = {
					runespacing = {
						type = "range",
						name = L["Rune spacing"],
						desc = L["The distance between each rune"],
						order = 100,
						min = -150,
						max = 150,
						step = 1,
					},
					barrunespacing = {
						type = "range",
						name = L["Bar and rune spacing"],
						desc = L["The distance between each rune and bar"],
						order = 200,
						min = -200,
						max = 200,
						step = 1,
					},
				},
			},
			runeorder = {
				type = "group",
				name = L["Rune Order"],
				disabled = IsDisabled,
				args = {
					presetruneorderheader = {
						type = "header",
						name = L["Preset order"],
						order = 100,
					},
					presetruneorder = {
						type = "select",
						name = L["Presets"],
						order = 150,
						values = runeorderoptionvalues,
						get = function()
									for tbl in pairs(runeorderoptionvalues) do
										local want = true
										for k,v in ipairs(tbl) do
											if db.presetruneorder[k] ~= v then want = false break end
										end
										if want then return tbl end
									end
								end,
						disabled = function() return db.usecustomruneorder end,
					},
					customruneorderheader = {
						type = "header",
						name = L["Custom order"],
						order = 300,
					},
					usecustomruneorder = {
						type = "toggle",
						name = L["Use custom order"],
						order = 310,
					},
					customruneorder_desc = {
						type ="description",
						name = L["Input a list of rune ids separated by commas. It will only accept six numbers from 1 to 6. Each number must be |cffff0000different|r from the rest.\n\nRune ids are as followed:\n   1 - Blood rune 1\n   2 - Blood rune 2\n   3 - Unholy rune 1\n   4 - Unholy rune 2\n   5 - Frost rune 1\n   6 - Frost rune 2"],
						order = 400,
					},
					customruneorder = {
						type = "input",
						name = L["Table"],
						order = 500,
						validate = 	function(info,value)
											self.temp = self.temp or {}
											wipe(self.temp)
											local t = loadstring("return {"..value.."}")()
											if type(t) ~= "table" then return L["Not a valid table"] end
											if #t ~= 6 then return L["Six values required"] end
											for k,v in ipairs(t) do
												if v > 6 or v < 1 then return L["Invalid value for rune id. Expecting a number from 1 to 6 for each value"] end
													if self.temp[v] then
														return L["Rune ids are not all different"]
													else
														self.temp[v] = true
													end
												end
											return true
										end,
						get = function(info)
							return concat(db.customruneorder,", ") 
						end,
						set = function(info,value)
							db.customruneorder = loadstring("return {"..value.."}")()
							self:LoadSettings() 
						end,
						disabled = function() return not db.usecustomruneorder end,
					}
				},
			},
		},
	}
end
