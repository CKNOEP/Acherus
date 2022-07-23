--[[
	Project: Acherus WLTK Classic
	Website: https://www.curseforge.com/wow/addons/acherus-wltk-classic
	Rev: 6
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

local Acherus = LibStub("AceAddon-3.0"):NewAddon("Acherus","AceEvent-3.0","AceConsole-3.0")
Acherus.frame = CreateFrame("Frame","AcherusFrame",UIParent)
Acherus.frame:SetAllPoints(UIParent)
Acherus.anchor = CreateFrame("Frame",Acherus.frame:GetName().."Anchor",UIParent)
Acherus.version = GetAddOnMetadata("Acherus","Version")
local	L, SM = LibStub("AceLocale-3.0"):GetLocale("Acherus", true), LibStub("LibSharedMedia-3.0")
Acherus.L, Acherus.SM = L,SM
local ACD = LibStub("AceConfigDialog-3.0")
local LDB = LibStub("LibDataBroker-1.1")
local LDBIcon = LibStub("LibDBIcon-1.0",true)

local db
local _G,unpack,error,UIParent,format,print = _G,unpack,error,UIParent,string.format,print

Acherus.backdrop = {bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background"}
Acherus.tooltip = "Interface\\Tooltips\\UI-Tooltip-Border"

local UIFrameFadeOut = UIFrameFadeOut
local UIFrameFadeRemoveFrame = UIFrameFadeRemoveFrame
local InCombatLockdown = InCombatLockdown
local RuneFrame, RuneFrame_OnEvent = RuneFrame, RuneFrame_OnEvent

function Acherus:LoadSettings()
	self.frame:SetScale(db.globalscale)

	if self.db.global.locked or not self:IsEnabled() then self.anchor:Hide() 
	else self.anchor:Show() end
	
	if not self.db.global.minimap.show then LDBIcon:Hide("Acherus")
	else LDBIcon:Show("Acherus") end

	if db.oocfadingenabled then
		self:RegisterEvent("PLAYER_REGEN_DISABLED") 
		self:RegisterEvent("PLAYER_REGEN_ENABLED")
		if InCombatLockdown() then 
			self.frame:SetAlpha(db.oocfadeinalpha)
		else 
			self.frame:SetAlpha(db.oocfadeoutalpha) 
		end
	else
		self:UnregisterEvent("PLAYER_REGEN_DISABLED")
		self:UnregisterEvent("PLAYER_REGEN_ENABLED")
		self.frame:SetAlpha(1)
	end
	
	if db.hideblizzardruneframe then 
		RuneFrame:Hide()
		RuneFrame:UnregisterAllEvents()		
	else
		RuneFrame:Show()
		RuneFrame:RegisterEvent("RUNE_POWER_UPDATE")
		RuneFrame:RegisterEvent("RUNE_TYPE_UPDATE")
		RuneFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
		RuneFrame:SetScript("OnEvent", RuneFrame_OnEvent)
	end
	self:LoadPositions()
end


function Acherus:OnInitialize()
	self:InitializeDefaults()
	self.db = LibStub("AceDB-3.0"):New("AcherusDB",self.defaults,"Default")
	
	self:InitializeOptions()
	Acherus:AddToSettings("general",self:GetSettingsTable())
	
	self:UpdatePointers()

	LibStub("AceConfig-3.0"):RegisterOptionsTable("Acherus", self.options)

	self.db.RegisterCallback(self,"OnProfileChanged","ProfileChanged")
	self.db.RegisterCallback(self,"OnProfileCopied","ProfileChanged")
	self.db.RegisterCallback(self,"OnProfileReset","ProfileChanged")
	self.db.RegisterCallback(self,"OnProfileDeleted","ProfileChanged")

	self:RegisterChatCommand("acherus",self.OpenConfig)
	self:RegisterChatCommand("ac",self.OpenConfig)
	
	self.anchors = {}
	self.anchorcache = {}
	self.anchor:Hide()

	self:SetEnabledState(self.db.global.enabled)
	self.frame:Hide()
	
	self.launcher = LDB:NewDataObject("Acherus", 
	{
		type = "launcher",
		icon = "Interface\\Icons\\INV_Sword_62",
		OnClick = function(_, button)
			if button == "LeftButton" then 
				if ACD.OpenFrames.Acherus then Acherus:CloseConfig()
				else Acherus:OpenConfig() end
			else
				Acherus:ToggleLock(true) 
				ACD:ConfigTableChanged(nil,"Acherus") 
			end
		end,
		OnTooltipShow = function(tooltip)
			tooltip:AddLine("Acherus")
			tooltip:AddLine(L["|cff99ff33Click|r to toggle the config"])
			tooltip:AddLine(L["|cff99ff33Right-Click|r to toggle locking"])
		end,
	})
	if LDBIcon then LDBIcon:Register("Acherus",self.launcher,self.db.global.minimap) end

	self:print(L["Acherus by Kollektiv.& Lancestre. Type /ac or /acherus to open options"])
end

function Acherus:print(s,...)
	if not s then return end
	print(format("|cff99ff33%s|r",s))
	return self:print(...)
end

function Acherus:OnEnable()
	self.frame:Show()
	self:LoadSettings()
end

function Acherus:OnDisable()
	self:UnregisterAllEvents()
	self.frame:Hide()
	self.anchor:Hide()
end

function Acherus:ToggleLock(showmsg)
	self.db.global.locked = not self.db.global.locked
	if showmsg then
		if self.db.global.locked then self:print(L["Acherus is now locked"])
		else self:print(L["Acherus is now unlocked"]) end
	end
	self:LoadSettings()
end

function Acherus:UpdatePointers()
	db = self.db.profile.settings.general
	self.positions = self.db.profile.positions
	for name,mod in self:IterateModules() do
		if mod.UpdateSettingsPointer then mod:UpdateSettingsPointer() end
	end
end

function Acherus:ProfileChanged()
	self:UpdatePointers()
	self:LoadAllSettings()
end

function Acherus:OpenConfig()
	ACD:Open("Acherus")
end

function Acherus:CloseConfig()
	ACD:Close("Acherus")
end

function Acherus:LoadAllSettings()
	self:LoadSettings()
	for _,mod in self:IterateModules() do
		mod:LoadSettings()
		mod:SetEnabledState(mod.db.enabled)
		if mod.db.enabled then mod:Enable() else mod:Disable() end
		self:HideDisabledModAnchors()
	end
end

function Acherus:HideDisabledModAnchors()
	for anchor, name in pairs(self.anchorcache) do
		if not self:GetModule(name).db.enabled then
			anchor:Hide()
		end
	end
end

function Acherus:GetModuleNameBased(modname)
	if modname == "general" then return self end
	for name,mod in self:IterateModules() do
		if name:lower() == modname then 
			return mod
		end
	end
end

function Acherus:SettingsChanged(info)
	local modname = info[2]
	if modname == "general" then self:LoadSettings() return end
	local mod = self:GetModuleNameBased(modname)
	if mod and mod.LoadSettings then mod:LoadSettings() end
end

function Acherus:LoadPosition(name,position)
	local f = _G[name]
	if not f then return end
	if not position then 
		self.positions[f:GetName()] = self.positions[f:GetName()] or {}
		position = self.positions[f:GetName()]
	end
	f:ClearAllPoints()
	if #position == 0 then
		f:SetPoint("CENTER",UIParent,"CENTER")
	else	
		local point,relativeTo,relativePoint,xOfs,yOfs = unpack(position)
		f:SetPoint(point,relativeTo or UIParent,relativePoint,xOfs,yOfs)
	end
end


function Acherus:LoadPositions()
	self:ProcessAnchors(self.anchor:GetChildren())
end


function Acherus:ProcessAnchors(anchor,...)
	if not anchor then return end
	self:LoadPosition(anchor:GetName())
	return self:ProcessAnchors(...)
end

function Acherus:RegisterMoveSaving(f)
	f:SetScript("OnMouseDown",Acherus.Move)
	f:SetScript("OnMouseUp",Acherus.StopMove)
	self.positions[f:GetName()] = self.positions[f:GetName()] or {}
end


function Acherus:CreateAnchor(name,modulename)
	local anchor = CreateFrame("Button","Acherus"..name.."Anchor",self.anchor,BackdropTemplateMixin and "BackdropTemplate")
	anchor:EnableMouse(true)
	anchor:SetMovable(true)
	anchor:SetWidth(20); anchor:SetHeight(20)
	anchor:SetBackdrop(self.backdrop)
	anchor:SetBackdropColor(1,1,1,.6)
	self:RegisterMoveSaving(anchor)
	anchor.text = anchor:CreateFontString(nil,"ARTWORK")
	anchor.text:SetFont(GameFontNormal:GetFont(),8,"OUTLINE")
	anchor.text:SetText(name)
	anchor.text:SetPoint("TOP",anchor,"BOTTOM")
	self.anchors[name] = anchor
	self:LoadPosition(anchor:GetName())

	self.anchorcache[anchor] = modulename
	return anchor
end

function Acherus:Move()
	self:StartMoving()
end

function Acherus:StopMove()
	self:StopMovingOrSizing()
	Acherus:SavePosition(self)
end

function Acherus:SavePosition(f)
	local name = f:GetName()
	self.positions[name] = {f:GetPoint()}
end

function Acherus:PLAYER_REGEN_ENABLED()
	UIFrameFadeOut(self.frame,db.oocfadeouttime,db.oocfadeinalpha,db.oocfadeoutalpha)
end

function Acherus:PLAYER_REGEN_DISABLED()
	UIFrameFadeIn(self.frame,db.oocfadeintime,db.oocfadeoutalpha,db.oocfadeinalpha)
end

--[[
	Options
]]

function Acherus:GetSettingsTable()
	return {
			type = "group",
			name = L["General"],
			order = 1,
			get = function (info) return db[info[#info]] end,
			set = function (info,value) db[info[#info]] = value; self:LoadSettings() end,
			args = {
				globalscale = {
					type = "range",
					name = L["Global scale"],
					order = 5,
					min = 0.1,
					max = 3,
					step = 0.1,
				},
				hideblizzardruneframe = {
					type = "toggle",
					name = L["Hide Blizzard Rune Frame"],
					order = 10,
					width = "full",
				},
				blank = {type = "description", order = 30, name = ""},
				oocfadingenabled = {
					type = "toggle",
					name = L["OOC Fading Enabled"],
					order = 50,
				},
				oocfadinggroup = {
					type = "group",
					name = L["Out of combat fading"],
					order = 100,
					disabled = function() return not db.oocfadingenabled end,
					inline = true,
					args = {
						blank = {
							type = "description",
							name = "",
							order = 155,
						},
						oocfadeintime = {
							type = "range",
							name = L["Fade in time"],
							order = 200,
							min = 0,
							max = 3,
							step = 0.1,
						},
						oocfadeouttime = {
							type = "range",
							name = L["Fade out time"],
							order = 300,
							min = 0,
							max = 3,
							step = 0.1,
						},
						oocfadeinalpha = {
							type = "range",
							name = L["In combat alpha"],
							order = 400,
							min = 0,
							max = 1,
							step = 0.05,
						},
						oocfadeoutalpha = {
							type = "range",
							name = L["Out combat alpha"],
							order = 500,
							min = 0,
							max = 1,
							step = 0.05,
						},
					},
				},
			},
	}
end

_G.Acherus = Acherus

