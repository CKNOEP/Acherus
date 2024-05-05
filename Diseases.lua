--[[
	Project: Acherus Cataclysm Classic
	Website: https://www.curseforge.com/wow/addons/acherus-wltk-classic
	Rev: 16
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
local Diseases = Acherus:NewModule("Diseases","AceEvent-3.0") 
Acherus.Diseases = Diseases
Diseases.frame = CreateFrame("Frame",Acherus.frame:GetName().."Diseases",Acherus.frame,BackdropTemplateMixin and "BackdropTemplate")
Diseases.frame:SetAllPoints(UIParent)

local db,bar
local wipe,pairs,next,select,sort,unpack = table.wipe,pairs,next,select,table.sort,unpack
local ceil,floor,abs,random = math.ceil,math.floor,math.abs,math.random
local UnitDebuff,UnitExists = UnitDebuff,UnitExists
local GetTalentInfo,GetTime = GetTalentInfo,GetTime
local UIFrameFadeOut,UIFrameFadeRemoveFrame = UIFrameFadeOut,UIFrameFadeRemoveFrame

local maxtime,font
local INTERVAL = 1
local EDGESIZE = 7

local temp = {}
local data = {}
local spellids = {
	55078, -- Blood Plague
	59921, -- Frost Fever
	65142, -- Ebon Plague
	81130, -- Scarlet Fever
}
for k,v in ipairs(spellids) do data[k] = GetSpellInfo(v) end

local fscache = {}
local fontstrings, textures = {},{} -- Used ones

function Diseases:UpdateSettingsPointer()
	db = Acherus.db.profile.settings.diseases
	self.db = db
end

function Diseases:LoadSettings()
	if db.enabled then self.frame:Show() else self.frame:Hide(); return end
	self.frame:SetScale(db.scale)
	self:UpdateDiseaseBar()
	self:UpdateTextureAttributes()
	self:FindOverlaps()
end

function Diseases:OnInitialize()
	Acherus:AddToSettings("diseases",self:GetSettingsTable())
	self:UpdateSettingsPointer()
	self.frame:Hide()
	self:SetEnabledState(db.enabled)
end

function Diseases:OnEnable()
	self:CountEpidemicPoints()
	self:CreateDiseaseBar()
	self:CreateTextures()
	self:LoadSettings()
	self.anchor:Show()
	Acherus:LoadPositions()
	self:RegisterEvent("PLAYER_TARGET_CHANGED")
	self:RegisterEvent("UNIT_AURA")
	self:RegisterEvent("CHARACTER_POINTS_CHANGED","UpdateDiseaseBar")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:ClearDiseaseTimers()
	self:PLAYER_TARGET_CHANGED()
end

function Diseases:OnDisable()
	self.frame:Hide()
	self.anchor:Hide()
	self:ClearDiseaseTimers()
	self:UnregisterAllEvents()
end

local fix = CreateFrame("Frame")
fix.elapsed = 0
function Diseases:PLAYER_ENTERING_WORLD()
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	fix:SetScript("OnUpdate",function(self,elapsed)
		fix.elapsed = fix.elapsed + elapsed
		if fix.elapsed > 2 then
			Diseases:UpdateDiseaseBar()
			self:SetScript("OnUpdate",nil)
		end
	end)
end

function Diseases:CountEpidemicPoints()
	maxtime = 21 + 4 * select(5,GetTalentInfo(3,3)) -- Epidemic talent
end

local border = {edgeFile="",edgeSize=EDGESIZE,insets={left=0,right=0,top=0,bottom=0}}

function Diseases:UpdateDiseaseBar()
	font = SM:Fetch("font",db.font)
	self:CountEpidemicPoints()
	bar:SetHeight(db.iconsize)
	bar:SetWidth(db.iconsize * maxtime * db.spacingscale)
	bar.backdrop:SetTexture(SM:Fetch("background",db.background))
	bar.backdrop:SetVertexColor(unpack(db.barcolor))
	border.edgeFile = SM:Fetch("border",db.border)
	bar.border:SetBackdrop(border)
	bar.border:SetBackdropBorderColor(unpack(db.bordercolor))
	while next(fontstrings) do
		local t,fs = next(fontstrings)
		fs:ClearAllPoints(); fs:SetText("")
		fscache[fs] = true
		fontstrings[t] = nil
	end
	for t=0,maxtime,INTERVAL do 
		local fs = next(fscache) or bar:CreateFontString(nil,"ARTWORK")
		fscache[fs] = nil
		fontstrings[t] = fs
		fs:SetFont(font,db.fontsize)
		fs:SetVertexColor(unpack(db.textcolor))
		fs:SetAlpha(0)
		fs:SetText(t)
		local point = ((t/maxtime) * (bar:GetWidth()) + db.iconsize/2)
		fs:SetPoint("CENTER",bar,"LEFT",point,0)
	end
	bar:SetWidth(bar:GetWidth() + db.iconsize)
end

function Diseases:CreateDiseaseBar()
	if bar then return end
	bar = CreateFrame("Frame",self.frame:GetName().."DiseaseBar",self.frame)
	bar.backdrop = bar:CreateTexture(nil,"BACKGROUND")
	bar.backdrop:SetAllPoints(true)
	bar.border = CreateFrame("Frame",nil,bar,BackdropTemplateMixin and "BackdropTemplate")
	local hes = EDGESIZE/2
	bar.border:SetPoint("TOPLEFT",bar,"TOPLEFT",-hes+1,hes-1)
	bar.border:SetPoint("BOTTOMRIGHT",bar,"BOTTOMRIGHT",hes-1,-hes+1)
	self.anchor = Acherus:CreateAnchor("Diseases","Diseases")
	bar:SetPoint("LEFT",self.anchor,"RIGHT",5,0)
	bar:SetAlpha(0)
end

function Diseases:UpdateTextureAttributes()
	for _,tex in pairs(textures) do
		tex:SetSize(db.iconsize) 
	end
end

local function SetSize(self,size)
	self:SetWidth(size); self:SetHeight(size)
end

function Diseases:CreateTextures()
	if #textures > 0 then return end
	for i,disease in ipairs(data) do 
		textures[i] = bar:CreateTexture(nil,"OVERLAY"); 
		textures[i]:SetAlpha(0) 
		textures[i].disease = disease
		textures[i]:SetTexCoord(0.07,0.93,0.07,0.93)
		textures[i].SetSize = SetSize
	end
end

function Diseases:ReleaseTexture(tex,na)
	fontstrings[0]:SetAlpha(0)
	if tex:GetAlpha() > 0 then UIFrameFadeOut(tex,0.5,tex:GetAlpha(),0) end
	tex.active = false
	tex.timeleft = nil
	tex.point = "THIRDMIDDLE"
end

function Diseases:UpdateFontStrings(t)
	local diff = t-floor(t)
	local ct = ceil(t) - 1
	for i=0,#fontstrings do
		local fs = fontstrings[i]
		local ca,na = fs:GetAlpha()
		if ct + 1 == i then -- [0,0.5]  0.5 -> 0
			na = diff/2
			if ca > na then fs:SetAlpha(na); end
		elseif ct == i then -- [0.5,1]  1 -> 0.5
			na = (1+diff)/2
			if ca < na then fs:SetAlpha(na); end
		elseif ct - 1 == i then -- [0.5,1]  0.5 -> 1
			na = 1-(diff/2)
			if ca < na then fs:SetAlpha(na); end
		elseif ct - 2 == i then -- [0,0.5]  0 -> 0.5
			na = 0.5-(diff/2)
			if ca < na then fs:SetAlpha(na); end
		end
	end
end

function Diseases:ResetFontStringAlphas()
	for _,fs in pairs(fontstrings) do fs:SetAlpha(0) end
end

local getPoint = {
	THIRDTOP = function() return db.iconsize*3/8 end,
	THIRDMIDDLE = function() return 0 end,
	THIRDBOTTOM = function() return -1*db.iconsize*3/8 end,
	HALFUPPER = function() return db.iconsize / 4 end,
	HALFLOWER = function() return -1*db.iconsize/4 end,
}

function Diseases:OnUpdate(elapsed)
	local go = false
	for _,tex in ipairs(textures) do
		if tex.active then
			go = true
			tex.timeleft = tex.timeleft - elapsed
			if tex.timeleft >= 0 then
				local xPos = (((bar:GetWidth()-db.iconsize) * (tex.timeleft / maxtime)) + (db.iconsize / 2))
				Diseases:UpdateFontStrings(tex.timeleft)
				tex:ClearAllPoints()
				tex:SetPoint("CENTER",bar,"LEFT",xPos,getPoint[tex.point]())
			else 
			Diseases:ReleaseTexture(tex) 
			end
		end
	end
	if not go then Diseases:UpdateDiseaseTimers() end
end

local function overlapSortFunc(a,b)
	return a.disease < b.disease
end

function Diseases:FindOverlaps()
	wipe(temp)
	local icon1 = textures[1].timeleft and textures[1]
	local icon2 = textures[2].timeleft and textures[2]
	local icon3 = textures[3].timeleft and textures[3]
	if icon1 and icon2 and icon3 and (abs(icon1.timeleft - icon2.timeleft) + abs(icon2.timeleft - icon3.timeleft)) <= db.overlaptime then
		icon1:SetSize(db.iconsize/3); icon2:SetSize(db.iconsize/3); icon3:SetSize(db.iconsize/3)
		temp[1] = icon1; temp[2] = icon2; temp[3] = icon3;
		sort(temp,overlapSortFunc)
		temp[1].point = "THIRDTOP"
		temp[2].point = "THIRDMIDDLE"
		temp[3].point = "THIRDBOTTOM"
	elseif icon1 and icon2 and abs(icon1.timeleft - icon2.timeleft) <= db.overlaptime then
		icon1:SetSize(db.iconsize/2); icon2:SetSize(db.iconsize/2)
		temp[1] = icon1; temp[2] = icon2
		sort(temp,overlapSortFunc)
		temp[1].point = "HALFUPPER"
		temp[2].point = "HALFLOWER"
	elseif icon2 and icon3 and abs(icon2.timeleft - icon3.timeleft) <= db.overlaptime then
		icon2:SetSize(db.iconsize/2); icon3:SetSize(db.iconsize/2)
		temp[1] = icon2; temp[2] = icon3
		sort(temp,overlapSortFunc)
		temp[1].point = "HALFUPPER"
		temp[2].point = "HALFLOWER"
	end
end

function Diseases:UpdateDiseaseTimers()
	if maxtime ~= (12 + 3 * select(5,GetTalentInfo(3,4))) then self:UpdateDiseaseBar() end
	self:ClearDiseaseTimers()
	local go = self:ScanTargetDebuffs()
	if go then 
		if bar:GetAlpha() < 1 then bar:SetAlpha(1) end
		self:FindOverlaps()
		self.frame:SetScript("OnUpdate",self.OnUpdate) 
	else 
		if bar:GetAlpha() > 0 then
			UIFrameFadeOut(bar,0.5,bar:GetAlpha(),0) 
		end 
	end
end

function Diseases:ClearDiseaseTimers()
	self.frame:SetScript("OnUpdate",nil)
	self:ResetFontStringAlphas()
	for _,tex in pairs(textures) do self:ReleaseTexture(tex) end
end

local function timeSortFunc(a,b)
	return (a.timeleft or 10000) < (b.timeleft or 10000)
end

function Diseases:Test()
	self:ClearDiseaseTimers()
	UIFrameFadeRemoveFrame(bar)
	for i,spellid in ipairs(spellids) do
		if i == 4 then break end -- Only show three
		local tex = textures[i]
		tex:SetTexture(select(3,GetSpellInfo(spellid)))
		tex:SetAlpha(db.iconalpha)
		tex.timeleft = random(5,maxtime)
		tex.active = true
		tex:SetSize(db.iconsize)
		UIFrameFadeRemoveFrame(tex)
	end
	sort(textures,timeSortFunc)
	if bar:GetAlpha() < 1 then bar:SetAlpha(1) end
	self:FindOverlaps()
	self.frame:SetScript("OnUpdate",self.OnUpdate) 
end

function Diseases:ScanTargetDebuffs()
	local go = false
	for _,tex in ipairs(textures) do
	for i=1,40 do	
				--print ("i = ",i)

		local name, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId  = UnitDebuff("target", i);
		--local name,_,icon,_,_,_,expTime,owner = UnitDebuff("target",tex.disease)
		--if name then print (name,"-",i,tex.disease) end
			if name and unitCaster and unitCaster == "player" and tex.disease == name then
				tex:SetAlpha(db.iconalpha)
				tex:SetTexture(icon)
				tex:SetSize(db.iconsize)
				tex.timeleft = -1*(GetTime() - expirationTime)
				tex.active = true
				UIFrameFadeRemoveFrame(tex)
				go = true
			end
		end
	end
	sort(textures,timeSortFunc)
	return go
end

function Diseases:UNIT_AURA(_,unit)
	if unit == "target" and UnitExists(unit) then self:UpdateDiseaseTimers() end
end

function Diseases:PLAYER_TARGET_CHANGED()
	if UnitExists("target") then
		UIFrameFadeRemoveFrame(bar)
		self:UpdateDiseaseTimers()
	else 
		UIFrameFadeOut(bar,0.5,bar:GetAlpha(),0)
		self:ClearDiseaseTimers()
	end
end

--[[
	Options
]]

local function IsDisabled()
	return not db.enabled
end

function Diseases:GetSettingsTable()
	return {
		type = "group",
		name = L["Diseases"],
		args = {
			enabled = {
				type = "toggle",
				name = L["Enabled"],
				order = 1,
				handler = self,
				get = "IsEnabled",
				set = function() db.enabled = not db.enabled
						if db.enabled then self:Enable() else self:Disable() end end,
				width = "half",
			},
			test = {
				type = "execute",
				name = L["Test"],
				order = 2,
				desc = L["Target nothing while testing. If you target something while testing the bar will clear."],
				func = function() Diseases:Test() end,
				disabled = IsDisabled,
				width = "half",
			},
			scale = {
				type = "range",
				name = L["Scale"],
				order = 3,
				min = 0.1,
				max = 3,
				step = 0.1,
				width = "half",
				disabled = IsDisabled,
			},
			diseases_group = {
				type = "group",
				name = "",
				order = 20,
				disabled = IsDisabled,
				inline = true,
				args = {
					general = {
						type = "header",
						name = L["General"],
						order = 1,
					},
					scale = {
						type = "range",
						name = L["Scale"],
						order = 2,
						min = 0.1,
						max = 3,
						step = 0.1,
					},
					spacingscale = {
						type = "range",
						name = L["Spacing scale"],
						order = 10,
						min = 0.1,
						max = 2,
						step = 0.1
					},
					font = {
						type = "select",
						name = L["Font"],
						order = 100,
						dialogControl = "LSM30_Font",
						values = "GetFonts",
					},
					background = {
						type = "select",
						name = L["Bar background"],
						order = 110,
						dialogControl = "LSM30_Background",
						values = "GetBackgrounds",
					},
					border = {
						type = "select",
						name = L["Bar border"],
						order = 120,
						dialogControl = "LSM30_Border",
						values = "GetBorders",
					},
					iconsize = {
						type = "range",
						name = L["Icon size"],
						order = 200,
						min = 10,
						max = 100,
						step = 1,
					},				
					fontsize = {
						type = "range",
						name = L["Font size"],
						order = 350,
						min = 2,
						max = 40,
						step = 1,
					},
					iconalpha = {
						type = "range",
						name = L["Icon alpha"],
						order = 370,
						min = 0.1,
						max = 1,
						step = 0.1,
					},
					overlaptime = {
						type = "range",
						name = L["Overlap time"],
						desc = L["Determines if diseases are overlapping by taking the absolute value of the time differences and seeing if it's <= Overlap time"],
						order = 380,
						min = 0.01,
						max = 1,
						step = 0.01,
					},
					textcolor = {
						type = "color",
						name = L["Text color"],
						order = 400,
					},
					barcolor = {
						type = "color",
						name = L["Bar color"],
						order = 420,
						hasAlpha = true,
					},
					bordercolor = {
						type = "color",
						name = L["Border color"],
						order = 430,
						hasAlpha = true,
					},
				},
			},
		},
	}
end

