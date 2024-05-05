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
local unpack, assert, ipairs, pairs = unpack, assert, ipairs, pairs

local SettingsHandler = {}
Acherus.SettingsHandler = SettingsHandler

--[[
	Options
]]

function Acherus:InitializeOptions()
	self.options = {
		name = L["Acherus WOTLK Classic"],
		type = "group",
		args = {
			enabled = {
				type = "toggle",
				name = L["Enabled"],
				order = 100,
				handler = self,
				get = "IsEnabled",
				set = function() self.db.global.enabled = not self.db.global.enabled
				if self.db.global.enabled then self:Enable() else self:Disable() end
				width = "half"
				end,
			},
			locked = {
				type = "toggle",
				name = L["Locked"],
				order = 200,
				disabled = function() return not self:IsEnabled() end,
				get = function(info) return self.db.global.locked end,
				set = function(info,value) Acherus:ToggleLock() end,
				width = "half",
			},
			minimap = {
				type = "toggle",
				name = L["Minimap"],
				order = 230,
				disabled = function() return not self:IsEnabled() end,
				get = function(info) return self.db.global.minimap.show end,
				set = function(info,value) self.db.global.minimap.show = value; self:LoadSettings() end,
				width = "half",
			},
			version = {
				type = "description",
				name = format("%s %s",L["|cff00CC00Version:|r"],self.version),
				order = 250,
			},
			settings = {
				type="group",
				name=L["Settings"],
				order = 300,
				disabled = function() return not self:IsEnabled() end,
				handler = SettingsHandler,
				get = "Get",
				set = "Set",
				width = "half",
				args = {}, -- Add settings to this
			},
			about = {
				type = "group",
				name = L["About"],
				order = 500,
				args = {
					author = {
						type="description",
name = format(
[=[%s: |cffffd200%s|r

%s:
  |cffffd200%s|r - %s
  |cffffd200%s|r - %s
  |cffffd200%s|r - %s
  |cffffd200%s|r - %s
  |cffffd200%s|r - %s
  |cffffd200%s|r - %s
  |cffffd200%s|r - %s


%s |cffffff78%s|r]=]
,
L["Author"],"Kollektiv, lancestre, moosetraxftw",
L["Credits"],
"lancestre",L["WOTLK classic version"],
"moosetraxftw",L["CATA classic version"],
"Kassay",L["Triangle texture"], -- 1
"Nathyrra",L["Inspiration, ideas, and testing"], -- 2
"DKI, Ebon Blade",L["Rune icons"], -- 3
"Ategia, Lojan",L["German translations"], -- 4
"Psyquest",L["French translations"], -- 5
"Defia, Masodcn, Cimmerie, Cache82",L["Simplified Chinese translations"], -- 6
"Tushiyang, MusicOnline",L["Traditional Chinese translations"], -- 7
L["Find updates at"],"https://www.curseforge.com/wow/addons/acherus-wltk-classic"),
						order = 200,
					},
				},
			},
		},
	}

	self.options.args.profile = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
	self.options.args.profile.order = 400
end

--[[
	Defaults
]]

function Acherus:InitializeDefaults()
	self.defaults =  {
		global = {
			enabled = true,
			locked = false,
			minimap = {
				show = true,
			},
		},
		profile = {
			positions = {
				["AcherusTriangleAnchor"] = {"CENTER",nil,"CENTER",-62,-203},
				["AcherusRPTextAnchor"] = {"CENTER", nil, "CENTER", -21, -235, },
				["AcherusKilling MachineToAnchor"] = {"CENTER", nil, "CENTER", -101, -148},
				["AcherusKilling MachineFromAnchor"] = {"CENTER", nil, "CENTER", -98, 107},
				["AcherusDiseasesAnchor"] = {"CENTER", nil, "CENTER", -158, -123},
				["AcherusFreezing FogFromAnchor"] = {"CENTER", nil, "CENTER", -3, 107},
				["AcherusFreezing FogToAnchor"] = {"CENTER", nil, "CENTER", -1, -147},
				["AcherusRPBarAnchor"] = {"BOTTOM", nil, "BOTTOM", -143, 165},
				["AcherusBarsAnchor"] = {"CENTER", nil, "CENTER", 86, -188},
			},
			settings = {
				general = {
					globalscale = 1,
					oocfadingenabled = false,
					oocfadeintime = 0.5,
					oocfadeouttime = 0.5,
					oocfadeinalpha = 1,
					oocfadeoutalpha = 0.5,
					hideblizzardruneframe = true,
				},
				runes = {
					enabled = true,
					scale = 1,
					enablebars = true,
					enableicons = true,
					enabletexts = true,
					usabletext = L["Ready"],
					barfillmethod = "DEPLETE",
					layout = "Triangle",  
					barwidth = 115, 
					barheight = 14,
					iconsize = 17, 
					iconsizepulse = 40, 
					bartexture = "Smooth",
					font = SM:GetDefault("font"),
					fontsize = 10, 
					fontsizepulse = 20,
					fontsizehundreths = 7,
					fontflags = {"OUTLINE"},
					iconpulseuptime = 0.2,
					iconpulsedowntime = 0.2,
					fontpulseuptime = 0.2,
					fontpulsedowntime = 0.2,
					barbloodrunecolor = {1.0, 0.0, 0.0}, 
					barunholyrunecolor = {0.0, 0.5, 0.0}, 
					barfrostrunecolor = {0.0, 1.0, 1.0}, 
					bardeathrunecolor = {0.8, 0.1, 1.0}, 
					textbloodrunecolor = {1.0, 0.0, 0.0}, 
					textunholyrunecolor = {0.0, 0.5, 0.0}, 
					textfrostrunecolor = {0.0, 1.0, 1.0}, 
					textdeathrunecolor = {0.8, 0.1, 1.0},
					timercolor = {1,1,1},
					basedonrune = false,
					runespacing = 0,
					runeset = "DKI",
					barrunespacing = 0,
					presetruneorder = {5,6,3,4,1,2},
					customruneorder = {5,6,3,4,1,2},
					usecustomruneorder = false,
					hundrethsformat = "%02d",
					spindegree = 360,
					hidebarswhendone = true,
					usableposition = 0,
					usableposition2 = 0,
					onesposition = 5,
					onesposition2 = 0,
					hundrethsposition = 18,
					hundrethsposition2 = 0,
					twodigitoffset = 6,
					reversedusableposition = 0,
					reversedusableposition2 = 0,
					reversedonesposition = 5,
					reversedonesposition2 = 0,
					reversedhundrethsposition = 18,
					reversedhundrethsposition2 = 0,
					reversedtwodigitoffset = 5,					
					backdropalpha = 0.4,
					statusbaralpha = 0.6,
					usehundreths = true,
					enablegradualfadein = false, -- For bars
					gradualstartalpha = 0.5,
					gradualendalpha = 1,
					gradualendtime = 5,
					moveout = false, 
					moveoutdistance = 200, 
					enableicongradualfadein = false, -- For runes
					icongradualstartalpha = 0.5,
					icongradualendalpha = 1,
					icongradualendtime = 5,
					movemethod = "OUT_TO_ORIGIN",
					showimprint = false,
					showspark = true,
					iconalpha = 1,
					imprintalpha = 1,
					behaviordeathtonormal = "PULSEANDSPIN",
					behaviornormaltodeath = "PULSE",
					behavioronusable = "NONE",
					behavioronunusable = "NONE",
					enableusablepulse = true,
					bordercolor = {1,1,1,1},
					border = "None",
				},
				runicpower = {
					enabled = true,
					scale = 1,
					rpcolor80 = {1,0,1},
					rpcolor60 = {1,0.65,0},
					rpcolor40 = {1,1,0},
					rpcolor20 = {0,1,1},
					rpcolor0 = {1,1,1},
					t_edgelength = 100, 
					fillalpha = 0.8, 
					bgcolor = {0,0,0,.3}, 
					font = SM:GetDefault("font"),
					fontsize = 15,
					layout = "triangle",
					textpositionx = 0,
					textpositiony = 0,
					barwidth = 230,
					barheight = 14,
					invert = false,
					bartexture = SM:GetDefault("statusbar"),
					usefillclr = true,
					currvaluecolor = {1,1,1},
					justify = "CENTER",
					bordercolor = {1,1,1,1},
					border = "None",
					background = "Blizzard Tooltip",
					barorientation = "HORIZONTAL",
					isreversed = false,
				},
				procs = {
					enabled = false,
					scale = 1,
					data = {
						[59052] = { -- Freezing Fog <= Rime
							sound = "None",
							duration = 15,
							enabled = true,
						}, 
						[51124] = { -- Killing Machine <= Killing Machine
							sound = "None",
							duration = 30,
							enabled = true,
						},
					},
					toscale = 1,
					toalpha = 0.8,
					fromscale = 2,
					movetime = 0.2,
					fadeintime = 0.5,
					fadeinalpha = 0.5,
					fadeouttime = 1,
					indvselect = 59052,
					soundenabled = true,
					enableomnicc = false,
					font = SM:GetDefault("font"),
					fontsize = 10,
					fontsizehundreths = 7,
					fontflags = {"OUTLINE"},
					hundrethsformat = "%02d",
					gloss = false,
					backdrop = false,
					skinid = "Dream Layout",
				},
				diseases = {
					enabled = false,
					scale = 1,
					spacingscale = 1,
					font = "Franklin Gothic Medium",
					fontsize = 8,
					iconsize = 17,
					iconalpha = 1,
					textcolor = {1,1,0},
					overlaptime = 0.2,
					barcolor = {0,0,0,0.3},
					bordercolor = {1,1,1,1},
					border = "None",
					background = "Blizzard Tooltip",
				},
			},
		}
	}
end

function Acherus:AddToSettings(name,tbl)
	self.options.args.settings.args[name] = tbl
end

function SettingsHandler:Get(info)
	local mod = Acherus:GetModuleNameBased(info[2])
	if info[#info]:find("color") then 
		return unpack(mod.db[info[#info]])
	else
		return mod.db[info[#info]]
	end
end

function SettingsHandler:Set(info,v1,v2,v3,v4)
	local mod = Acherus:GetModuleNameBased(info[2])
	if info[#info]:find("color") then
		mod.db[info[#info]][1] = v1
		mod.db[info[#info]][2] = v2
		mod.db[info[#info]][3] = v3
		mod.db[info[#info]][4] = v4
	else 
		mod.db[info[#info]] = v1
	end 
	Acherus:SettingsChanged(info)
end

function SettingsHandler:GetStatusBarTextures()
	self.sbtextures = self.sbtextures or {}
	wipe(self.sbtextures)
	for _, name in pairs(SM:List("statusbar")) do self.sbtextures[name] = name end
	return self.sbtextures
end

function SettingsHandler:GetFonts()
	self.fonts = self.fonts or {}
	wipe(self.fonts)
	for _, name in pairs(SM:List("font")) do self.fonts[name] = name end
	return self.fonts
end

function SettingsHandler:GetSounds()
	self.sounds = self.sounds or {}
	wipe(self.sounds)
	for _, name in pairs(SM:List("sound")) do self.sounds[name] = name end
	print (self.sounds[name])
	return self.sounds
end

function SettingsHandler:GetBorders()
	self.borders = self.borders or {}
	wipe(self.borders)
	for _,name in pairs(SM:List("border")) do self.borders[name] = name end
	return self.borders
end

function SettingsHandler:GetBackgrounds()
	self.backgrounds = self.backgrounds or {}
	wipe(self.backgrounds)
	for _,name in pairs(SM:List("background")) do self.backgrounds[name] = name end
	return self.backgrounds
end
