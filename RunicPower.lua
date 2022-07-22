--[[
	Project: Acherus WLTK Classic
	Website: http://www.wowace.com/projects/acherus/
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
local RunicPower = Acherus:NewModule("RunicPower","AceEvent-3.0")
RunicPower.frame = CreateFrame("Frame",Acherus.frame:GetName().."RunicPower",Acherus.frame,BackdropTemplateMixin and "BackdropTemplate") 
RunicPower.frame:SetAllPoints(UIParent)
Acherus.RunicPower = RunicPower

local db,cd,curr
local triangle,bar,text

local UnitPower,UnitPowerMax = UnitPower,UnitPowerMax
local tan,pi = math.tan, math.pi
local unpack,type,pairs = unpack,type,pairs
local powertype = 6 -- Runic power

local EDGESIZE = 7

function RunicPower:UpdateSettingsPointer()
	db = Acherus.db.profile.settings.runicpower
	self.db = db
end

function RunicPower:LoadSettings()
	if db.enabled then self.frame:Show() else self.frame:Hide() return end
	self.frame:SetScale(db.scale)
	self:UpdateLayout()
	self:UpdateRunicPower(true)
end

function RunicPower:OnInitialize()
	Acherus:AddToSettings("runicpower",self:GetSettingsTable())
	self:UpdateSettingsPointer()
	self.texturepath = "Interface\\Addons\\Acherus\\textures\\"
	self:CreateText()
	self:CreateBar()
	self:CreateTriangle()
	self:UpdateTriangleHeight()
	self:UpdateTriangle()
	self:RegisterLayout("triangle",L["Triangle"])
	self:RegisterLayout("bar",L["Bar"])
	self:RegisterLayout("text",L["Text"])
	self.frame:Hide()
	self:SetEnabledState(db.enabled)
end

function RunicPower:OnEnable()
	self:LoadSettings()
	Acherus:LoadPositions()
	self:RegisterEvent("UNIT_POWER_UPDATE")
	self.frame:SetScript("OnUpdate",self.UpdateRunicPower)
end

function RunicPower:OnDisable()
	self.frame:Hide()
	self:HideAnchors()
	self:UnregisterAllEvents()
end

function RunicPower:RegisterLayout(name,lname)
	self.layoutsoptionvalues = self.layoutsoptionvalues or {}
	self.layoutsoptionvalues[name] = lname
end

function RunicPower:HideAnchors()
	triangle.anchor:Hide()
	bar.anchor:Hide()
	text.anchor:Hide()
end

function RunicPower:UpdateLayout()
	text:SetFont(SM:Fetch("font",db.font),db.fontsize,"OUTLINE")
	text:SetVertexColor(unpack(db.currvaluecolor))
	if db.layout == "triangle" then
		triangle:Show(); triangle.anchor:Show()
		bar:Hide(); bar.anchor:Hide()
		text:Show(); text.anchor:Hide()
		self:UpdateTriangle()
		cd = triangle
	elseif db.layout == "bar" then
		triangle:Hide(); triangle.anchor:Hide()
		bar:Show(); bar.anchor:Show()
		text:Show(); text.anchor:Hide()
		self:UpdateBar()
		cd = bar
	elseif db.layout == "text" then
		triangle:Hide(); triangle.anchor:Hide()
		bar:Hide(); bar.anchor:Hide()
		text:Show(); text.anchor:Show()
		self:UpdateText()
		cd = text
	end
end

local border = {edgeFile="",edgeSize=7,insets={left=0,right=0,top=0,bottom=0}}

function RunicPower:UpdateBar()
	text:ClearAllPoints()
	bar:SetOrientation(db.barorientation)
	if db.barorientation == "HORIZONTAL" then
		bar:SetWidth(db.barwidth); bar:SetHeight(db.barheight)
		text:SetPoint("LEFT",bar,"RIGHT",db.textpositionx + 4,db.textpositiony)
	else
		bar:SetWidth(db.barheight); bar:SetHeight(db.barwidth)
		text:SetPoint("TOP",bar,"BOTTOM",db.textpositionx,db.textpositiony - 4)
	end
	bar:SetReversed(db.isreversed)
	bar:SetStatusBarTexture(SM:Fetch("statusbar",db.bartexture))
	bar.backdrop:SetTexture(SM:Fetch("background",db.background))
	bar.backdrop:SetVertexColor(unpack(db.bgcolor))
	border.edgeFile = SM:Fetch("border",db.border)
	bar.border:SetBackdrop(border)
	bar.border:SetBackdropBorderColor(unpack(db.bordercolor))
end

function RunicPower:UpdateText()
	text:ClearAllPoints()
	text:SetPoint("LEFT",text.anchor,"RIGHT")
end

-- Triangle
function RunicPower:UpdateTriangleHeight()
	db.t_height = (tan(pi / 3) * db.t_edgelength) / 2
end

function RunicPower:UpdateTriangle()
	self:UpdateTriangleHeight()
	triangle:SetWidth(db.t_edgelength)
	triangle:SetHeight(db.t_height)
	triangle.bg:SetWidth(db.t_edgelength)
	triangle.bg:SetHeight(db.t_height)
	triangle.bg:SetVertexColor(unpack(db.bgcolor))
	triangle.fill:SetWidth(db.t_edgelength)

	text:ClearAllPoints()
	text:SetPoint("TOP",self.triangle,"BOTTOM",db.textpositionx,db.textpositiony)
end

function RunicPower:CreateTriangle()
	if self.triangle then return end
	local anchor = Acherus:CreateAnchor("Triangle","RunicPower")
	local t = CreateFrame("Frame",self.frame:GetName().."Triangle",self.frame,BackdropTemplateMixin and "BackdropTemplate")
	t:SetFrameLevel(self.frame:GetFrameLevel()-1)
	self.triangle = t
	local bg = t:CreateTexture(nil,"BACKGROUND")
	bg:SetTexture(self.texturepath.."TriangleBGPlain")
	bg:SetTexCoord(0,1,0.005859375,0.875)
	bg:SetPoint("BOTTOM",t,"BOTTOM")
	t.bg = bg
	
	local fill = t:CreateTexture(nil,"ARTWORK")
	fill:SetTexture(self.texturepath.."TriangleBG")
	fill:SetPoint("BOTTOM",t,"BOTTOM")
	t.fill = fill
	
	t:SetPoint("TOPLEFT",anchor,"TOPRIGHT")
	t.anchor = anchor
	
	t.SetValue = function(self,power)
		curr = power
		local powerMax = UnitPowerMax("player",powertype)
		local perc = power / powerMax
		local y0 = (448 - (perc * 445)) / 512
		fill:SetTexCoord(0,1,y0,0.875)
		fill:SetHeight(db.t_height * perc)
	end
	
	t.SetColor = function(self,r,g,b,a)
		fill:SetVertexColor(r,g,b,a)
	end
	t.SetRPValue = function(self,value)
		self:SetValue(db.invert and 100 - value or value)
		text:SetText(value)
	end

	t:Hide()
	t.anchor:Hide()
	triangle = t
end

-- Bar
function RunicPower:CreateBar()
	if self.bar then return end
	self.bar = Acherus:CreateEnhancedStatusBar(self.frame:GetName().."Bar",self.frame,BackdropTemplateMixin and "BackdropTemplate")
	self.bar:SetFrameLevel(self.frame:GetFrameLevel()-1)
	self.bar.anchor = Acherus:CreateAnchor("RPBar","RunicPower")
	self.bar:SetPoint("LEFT",self.bar.anchor,"RIGHT")
	self.bar:Hide()
	self.bar.anchor:Hide()
	self.bar.border = CreateFrame("Frame",nil,self.bar,BackdropTemplateMixin and "BackdropTemplate")
	local hes = EDGESIZE/2
	self.bar.border:SetPoint("TOPLEFT",self.bar,"TOPLEFT",-hes+1,hes-1)
	self.bar.border:SetPoint("BOTTOMRIGHT",self.bar,"BOTTOMRIGHT",hes-1,-hes+1)
	self.bar.backdrop = self.bar:CreateTexture(nil,"BACKGROUND")
	self.bar.backdrop:SetAllPoints(true)
	bar = self.bar
	self.bar.SetColor = function(self,r,g,b,a)
		self:SetStatusBarColor(r,g,b,a)
	end
	self.bar.SetRPValue = function(self,value)
		local perc = value / UnitPowerMax("player",6)
		self:SetValue(db.invert and 1 - perc or perc)
		text:SetText(value)
	end
end

-- Text
function RunicPower:CreateText()
	if self.text then return end
	self.text = self.frame:CreateFontString(nil,"ARTWORK")
	self.text.anchor = Acherus:CreateAnchor("RPText","RunicPower")
	self.text:Hide()
	self.text.anchor:Hide()
	text = self.text
	self.text.SetRPValue = function(self,value)
		text:SetText(value)
	end
end

function RunicPower:UpdateRunicPower(forceUpdate)
	
	--print ("forceUpdate ",forceUpdate)
	local power = UnitPower("player",powertype)
	if forceUpdate or curr ~= power then
		cd:SetRPValue(power)
		local color
		if power >= 80 then color = db.rpcolor80
		elseif power >= 60 then color = db.rpcolor60
		elseif power >= 40 then color = db.rpcolor40
		elseif power >= 20 then color = db.rpcolor20
		else color =  db.rpcolor0 end
		local r,g,b = unpack(color)
		if db.layout ~= "text" then cd:SetColor(r,g,b,db.fillalpha) end
		if db.usefillclr then text:SetVertexColor(r,g,b) end
	end
end

function RunicPower:UNIT_POWER_UPDATE(_,unit)
	--print (event,unit)
	if unit == "player" then self:UpdateRunicPower() end
end

--[[
	Options
]]

local function IsDisabled()
	return not db.enabled
end

local function IsBarDisabled()
	return db.layout ~= "bar"
end

function RunicPower:GetSettingsTable()
	return {
		type = "group",
		name = L["Runic Power"],
		order = 100,
		childGroups = "tab",
		args = {
			enabled = {
				type = "toggle",
				name = L["Enabled"],
				order = 1,
				handler = self,
				get = "IsEnabled",
				set = function() db.enabled = not db.enabled
						if db.enabled then self:Enable() else self:Disable() end
				end,
				width = "half",
			},
			layout = {
				type = "select",
				name = L["Layouts"],
				order = 2,
				values = function() return self.layoutsoptionvalues end,
				disabled = IsDisabled,
			},
			scale = {
				type = "range",
				name = L["Scale"],
				desc = L["If you are using the runes + runic power triangle layouts and adjust this scale the runes will not position correctly. Adjust the triangle edge length instead"],
				order = 3,
				min = 0.1,
				max = 3,
				step = 0.1,
				width = "half",
				disabled = IsDisabled,
			},
			attributes = {
				type = "group",
				name = L["Attributes"],
				disabled = IsDisabled,
				args = {
					general = {
						type = "header",
						name = L["General"],
						order = 1,
					},
					font = {
						type = "select",
						name = L["Font"],
						order = 50,
						dialogControl = "LSM30_Font",
						values = "GetFonts",
					},
					fontsize = {
						type = "range",
						name = L["Font size"],
						order = 100,
						min = 10,
						max = 40,
						step = 1,
					},
					textpositionx = {
						type = "range",
						name = L["Text position x"],
						order = 120,
						min = -500,
						max = 500,
						step = 0.1,
						disabled = function() return db.layout == "text" end,
					},
					textpositiony = {
						type = "range",
						name = L["Text position y"],
						order = 130,
						min = -500,
						max = 500,
						step = 0.1,
						disabled = function() return db.layout == "text" end,
					},
					invert = {
						type = "toggle",
						name = L["Invert"],
						order = 140,
						disabled = function() return db.layout == "text" end,
					},
					triangleheader = {
						type = "header",
						name = L["Triangle"],
						order = 500,
					},
					t_edgelength = {
						type = "range",
						name = L["Edge length"],
						set = function(info,value) Acherus.SettingsHandler:Set(info,value) if Acherus.db.profile.settings.runes.layout == "Triangle" then Acherus.Runes:ApplyTriangleLayout() end end,
						order = 600,
						min = 50,
						max = 300,
						step = 1,
						disabled = function() return db.layout ~= "triangle" end,
					},
					barheader = {
						type = "header",
						name = L["Bar"],
						order = 700,
					},
					bar_desc = {
						type = "description",
						name = L["The bar's background color can be adjusted in the Colors tab -> Background color. Also note that for colored backgrounds, such as Blizzard Parchment, set the Background color to completely white or else the colors won't show up"],
						order = 750,
					},
					barwidth = {
						type = "range",
						name = L["Bar width"],
						order = 800,
						min = 10,
						max = 1000,
						step = 1,
						disabled = IsBarDisabled,
					},
					barheight = {
						type = "range",
						name = L["Bar height"],
						order = 900,
						min = 10,
						max = 1000,
						step = 1,
						disabled = IsBarDisabled,
					},
					bartexture = {
						type = "select",
						name = L["Bar texture"],
						order = 950,
						dialogControl = "LSM30_Statusbar",
						values = "GetStatusBarTextures",
						disabled = IsBarDisabled,
					},
					background = {
						type = "select",
						name = L["Bar background"],
						order = 960,
						dialogControl = "LSM30_Background",
						values = "GetBackgrounds",
						disabled = IsBarDisabled,
					},
					border = {
						type = "select",
						name = L["Bar border"],
						order = 980,
						dialogControl = "LSM30_Border",
						values = "GetBorders",
						disabled = IsBarDisabled,
					},
					bordercolor = {
						type = "color",
						name = L["Border color"],
						order = 1000,
						hasAlpha = true,
						disabled = IsBarDisabled,
					},
					barorientation = {
						type = "select",
						name = L["Bar orientation"],
						order = 1100,
						values = {HORIZONTAL = L["Horizontal"], VERTICAL = L["Vertical"]},
						disabled = IsBarDisabled,
					},
					isreversed = {
						type = "toggle",
						name = L["Reverse"],
						order = 1200,
						disabled = IsBarDisabled,
					},

				},
			},
			colors = {
				type = "group",
				name = L["Colors"],
				disabled = IsDisabled,
				args = {
					fillcolorgroup = {
						type = "group",
						name = L["Fills"],
						order = 100,
						inline = true,
						disabled = function() return db.layout == "text" end,
						args = {
							rpcolor0 = {
								type = "color",
								name = L["20 > RP >= 0"],
								order = 100,
							},
							rpcolor20 = {
								type = "color",
								name = L["40 > RP >= 20"],
								order = 200,
							},
							rpcolor40 = {
								type = "color",
								name = L["60 > RP >= 40"],
								order = 300,
							},
							rpcolor60 = {
								type = "color",
								name = L["80 > RP >= 60"],
								order = 400,
							},
							rpcolor80 = {
								type = "color",
								name = L["80 >= RP"],
								order = 500,
							},
							bgcolor = {
								type = "color",
								name = L["Background color"],
								order = 600,						
								hasAlpha = true,
							},
							fillalpha = {
								type = "range",
								name = L["Fill alpha"],
								order = 700,
								min = 0,
								max = 1,
								step = 0.05,
							},
						},
					},
					textgroup = {
						type = "group",
						name = L["Text"],
						order = 200,
						inline = true,
						args = {
							usefillclr = {
								type = "toggle",
								name = L["Use fill colors"],
								order = 900,
							},
							currvaluecolor = {
								type = "color",
								name = L["Constant color"],
								order = 1000,
								disabled = function() return db.usefillclr end,
							},
						},
					},
				},
			},
		},
	}
end
