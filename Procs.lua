--[[
	Project: Acherus WLTK Classic
	Website: http://www.wowace.com/projects/acherus/
	Rev: 2
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

local Acherus = Acherus
local L,SM = Acherus.L,Acherus.SM
local Procs = Acherus:NewModule("Procs","AceEvent-3.0")
local LBF = LibStub("LibButtonFacade", true)
Procs.frame = CreateFrame("Frame",Acherus.frame:GetName().."Procs",Acherus.frame) 
Procs.frame:SetAllPoints(UIParent)
Acherus.Procs = Procs
local db

local UIParent,UnitGUID,UnitBuff = UIParent,UnitGUID,UnitBuff
local ipairs, pairs, unpack, next = ipairs, pairs, unpack, next
local insert,remove,wipe = table.insert, table.remove, table.wipe
local UIFrameFadeIn,UIFrameFadeOut,UIFrameFadeRemoveFrame = UIFrameFadeIn,UIFrameFadeOut,UIFrameFadeRemoveFrame
local GetTime, GetSpellInfo, PlaySoundFile = GetTime, GetSpellInfo, PlaySoundFile
local floor,select,GetTime = math.floor, select,GetTime
local tostring,tonumber = tostring,tonumber

local active = {}

--[[
		local name,_,icon,_,_,_,expTime,isMine = UnitBuff("player",proc.name)
		tex.timeleft = -1*(GetTime() - expTime)
]]
function Procs:UpdateSettingsPointer()
	db = Acherus.db.profile.settings.procs
	self.db = db
end

function Procs:LoadSettings()
	if db.enabled then self.frame:Show() else self.frame:Hide() return end
	self.frame:SetScale(db.scale)
	self:ApplyProcAttributes()
	self:DestroyAll()
	if self.group then
		db.skinid = self.group.SkinID
		db.gloss = self.group.Gloss
		db.backdrop = self.group.Backdrop
	end
end

function Procs:OnInitialize()
	Acherus:AddToSettings("procs",self:GetSettingsTable())
	self:UpdateSettingsPointer()
	if LBF then 
		self.group = LBF:Group("Acherus","Procs") 
		self.group.SkinID = db.skinid
		self.group.Gloss = db.gloss
		self.group.Backdrop = db.backdrop
	 	LBF:RegisterSkinCallback("Acherus", self.LoadSettings, self)
	end
	self.procs = {}
	self.frame:Hide()
	self:SetEnabledState(db.enabled)
end

function Procs:OnEnable()
	wipe(active)
	self.pGUID = UnitGUID("player")
	self:CreateProcs()
	self:ShowHideAnchors("Show")
	self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	self:LoadSettings()
	Acherus:LoadPositions()
end

function Procs:OnDisable()
	self.frame:Hide()
	self:UnregisterAllEvents()
	self:ShowHideAnchors("Hide")
end

function Procs:ShowHideAnchors(func)
	for _,proc in pairs(self.procs) do
		proc.toanchor[func](proc.toanchor); proc.fromanchor[func](proc.fromanchor)
	end
end

function Procs:COMBAT_LOG_EVENT_UNFILTERED(_, _, eventtype, _, _, _, dstGUID, _, _, spellID)


	if dstGUID == self.pGUID then
		local proc = self.procs[spellID]
		if proc and proc.enabled then
			if eventtype == "SPELL_AURA_APPLIED" or eventtype == "SPELL_AURA_REFRESH" then
				self:Activate(proc)
			elseif eventtype == "SPELL_AURA_REMOVED" then
				self:Release(proc)
			end
		end
	end
end


function Procs:OnUpdate(elapsed)
	local n,i = #active,1
	if n == 0 then self:SetScript("OnUpdate",nil) end
	while i <= n do
		local proc, rem = active[i], false
		proc.ran = proc.ran + elapsed
		proc.timeleft = proc.timeleft - elapsed
		if proc.ran <= proc.step1 then -- Fade in
			if not proc.fadedIn then
				UIFrameFadeIn(proc,db.fadeintime,0,db.fadeinalpha)
				proc.fadedIn = true
			end
		elseif proc.ran <= proc.step2 then -- Moving
			if not proc.moveFaded then
				UIFrameFadeIn(proc,db.movetime,db.fadeinalpha,db.fadetoalpha)
				proc.moveFaded = true
			end
			proc.t0 = proc.t0 - elapsed
			local perc = (proc.dt - proc.t0) / proc.dt
			if perc >= 0 and perc <= 1 then  
				local x = proc.fx + ((proc.tox - proc.fx) * (perc))
				local y = proc.fy + ((proc.toy - proc.fy) * (perc))
				proc.anchor:ClearAllPoints()
				proc.anchor:SetPoint("BOTTOMLEFT",UIParent,"BOTTOMLEFT",x,y)
				local scale = db.toscale + ((db.fromscale-db.toscale) * (1-perc))
				proc:SetScale(scale)
			end
		elseif proc.ran <= proc.step3 then -- Duration countdown
			if not proc.cooldownSet then
				proc.cooldown:SetCooldown(proc.startTime,proc.duration)
				proc.cooldown:Show()
				Procs:AnchorOnTo(proc)
				proc.cooldownSet = true
				proc:SetScale(db.toscale)
			end
			if not db.enableomnicc and proc.timeleft >= 0 then
				local ftimeleft = floor(proc.timeleft)
				proc.onestext:SetText(ftimeleft)
				proc.hundrethstext:SetFormattedText(db.hundrethsformat,(proc.timeleft - ftimeleft) * 100)
			else
				proc.onestext:SetText(""); proc.hundrethstext:SetText("")
			end
		elseif proc.ran <= proc.step4 then -- Fade out
			if not proc.fadedOut then
				proc.onestext:SetText(""); proc.hundrethstext:SetText("")
				Acherus:AnimateScale(proc,db.fadeouttime,proc:GetScale(),0.001)
				UIFrameFadeOut(proc,db.fadeouttime,db.toalpha,0)
				proc.fadedOut = true
			end
		else rem = true end
		if rem then
			Procs:Destroy(remove(active,i)); 
			n = n - 1; 
		else i = i + 1 end
	end
end

function Procs:AnchorOnFrom(proc)
	proc.anchor:ClearAllPoints()
	proc.anchor:SetPoint("CENTER",proc.fromanchor,"CENTER")
end

function Procs:AnchorOnTo(proc)
	proc.anchor:ClearAllPoints()
	proc.anchor:SetPoint("CENTER",proc.toanchor,"CENTER")
end

function Procs:DestroyAll()
	for _,proc in pairs(self.procs) do self:Destroy(proc) end
end

function Procs:Remove(proc)
	for i,obj in ipairs(active) do
		if obj == proc then
			remove(active,i) 
			break 
		end
	end
end

function Procs:Release(proc)
	if proc.active and not proc.fadedOut then  
		proc.ran = proc.step3 
	end
end

function Procs:Destroy(proc)
	UIFrameFadeRemoveFrame(proc)
	self:AnchorOnFrom(proc)
	self:Remove(proc)
	Acherus.Animate.Remove(proc)
	proc.cooldown:Hide() 
	proc:SetScale(db.fromscale)
	proc:SetAlpha(0)
	proc.onestext:SetText(""); proc.hundrethstext:SetText("")
	proc.step1,proc.step2,proc.step3,proc.step4 = nil,nil,nil,nil
	proc.fadedIn,proc.fadedOut,proc.moveFaded = nil,nil,nil
	proc.cooldownSet,proc.active,proc.ran = nil,nil,nil
	proc.timeleft,proc.startTime = nil,nil
end

function Procs:Activate(proc)
	self:Destroy(proc)
	proc.active = true
	proc.ran = 0
	proc.step1 = db.fadeintime
	proc.step2 = proc.step1 + db.movetime
	proc.step3 = proc.step2 + proc.duration
	proc.step4 = proc.step3 + db.fadeouttime
	proc.timeleft = proc.duration
	proc.startTime = GetTime()
	proc.fx,proc.fy = proc.fromanchor:GetLeft(), proc.fromanchor:GetBottom()
	proc.tox, proc.toy = proc.toanchor:GetLeft(), proc.toanchor:GetBottom()
	proc.t0, proc.dt = db.movetime, db.movetime
	insert(active,proc)
	PlaySoundFile(proc.sound)
	self:StartProcUpdating()
end

function Procs:StartProcUpdating()
	if not self.frame:GetScript("OnUpdate") then self.frame:SetScript("OnUpdate",self.OnUpdate) end
end

function Procs:ApplyProcAttributes()
	for spellid,proc in pairs(self.procs) do
		proc.onestext:SetFont(SM:Fetch("font",db.font),db.fontsize,unpack(db.fontflags))
		proc.hundrethstext:SetFont(SM:Fetch("font",db.font),db.fontsizehundreths, unpack(db.fontflags))
		proc.duration = db.data[spellid].duration
		proc.sound = SM:Fetch("sound", db.data[spellid].sound)
		proc.enabled = db.data[spellid].enabled
		
		if db.enableomnicc then proc.cooldown.noCooldownCount = false
		else proc.cooldown.noCooldownCount = true end
		proc.toanchor:Show(); proc.fromanchor:Show()
	end
end

function Procs:CreateProc(name,texture,spellid)
	local proc = CreateFrame("Button",self.frame:GetName()..name,self.frame,"ActionButtonTemplate")
	proc.name = name
	proc:SetWidth(30); proc:SetHeight(30)
	proc:EnableMouse(false)
	if self.group then self.group:AddButton(proc) end
	proc.spellid = spellid
	
	proc.anchor = CreateFrame("Frame",proc:GetName().."Anchor",UIParent)
	proc.anchor:SetWidth(20); proc.anchor:SetHeight(20)

	_G[proc:GetName().."Icon"]:SetTexture(texture)

	proc.fromanchor = Acherus:CreateAnchor(name.."From","Procs")
	proc.toanchor = Acherus:CreateAnchor(name.."To","Procs")

	proc.cooldown = _G[proc:GetName().."Cooldown"]
	
	proc.onestext = proc.cooldown:CreateFontString(nil,"OVERLAY")
	proc.onestext:SetPoint("BOTTOMRIGHT",proc,"BOTTOM",3,3)

	proc.hundrethstext = proc.cooldown:CreateFontString(nil,"OVERLAY")
	proc.hundrethstext:SetPoint("BOTTOMLEFT",proc.onestext,"BOTTOMRIGHT",-3,0)
	
	proc:SetPoint("CENTER",proc.anchor,"CENTER")
	return proc
end

function Procs:CreateProcs()
	self.procs = self.procs or {}
	for spellid in pairs(db.data) do
		local name,_,texture = GetSpellInfo(spellid)
		if not self.procs[spellid] then self.procs[spellid] = self:CreateProc(name,texture,spellid) end
	end
end


--[[
	Options
]]

local function IsDisabled()
	return not Procs.db.enabled
end

function Procs:GetSettingsTable()
	return {
		type = "group",
		name = L["Procs"],
		order = 2000,
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
			proctest = {
				type = "execute",
				name = L["Test"],
				desc = L["Test all procs"],
				order = 20,
				func = function() for _,proc in pairs(self.procs) do self:Activate(proc) end end,
				width = "half",
				disabled = IsDisabled,
			},
			releasetest = {
				type = "execute",
				name = L["Release"],
				desc = L["Stop all procs if they're running"],
				order = 22,
				width = "half",
				func = function() for _,proc in pairs(self.procs) do self:Release(proc) end end,
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
			generalgroup = {
				type = "group",
				name = L["General"],
				order = 300,
				disabled = IsDisabled,
				args = {
					skinid = {
						type = "select",
						name = L["Skin"],
						desc = L["Button Facade skins"],
						order = 100,
						set = function(info,value) self.group:Skin(value,db.gloss,db.backdrop) end,
						values = function() return LBF:ListSkins() end,
						disabled = function() return not LBF end,
					},
					skinspacer = { type="description",name="",order = 105},
					procsdescription = {
						type = "description",
						name = L["A proc will start maximized and then minimize.\n |cff00ff00Step 1|r: Initial size is |cffffd200From scale|r. Fades in from 0 to |cffffd200Fade in alpha|r taking |cffffd200Fade in time|r (seconds) and is anchored to |cffffd200From|r.\n |cff00ff00Step 2|r: Moves linearly from |cffffd200From|r to |cffffd200To|r using |cffffd200Move time|r (seconds), sizes from |cffffd200From scale|r to |cffffd200To scale|r, and fades from |cffffd200Fade in alpha|r to |cffffd200To alpha|r\n |cff00ff00Step 3|r: Cooldown displays.\n |cff00ff00Step 4|r: Cooldown is done. Fades from |cffffd200To alpha|r to 0 and shrinks to nothing over |cffffd200Fade out time|r (seconds)"],
						order = 250,
					},
					fadeintime = {
						type = "range",
						name = L["Fade in time"],
						order = 300,
						min = 0.1,
						max = 2,
						step = 0.1,
					},
					fadeinalpha = {
						type = "range",
						name = L["Fade in alpha"],
						order = 410,
						min = 0.05,
						max = 1,
						step = 0.05,					
					},
					fromscale = {
						type = "range",
						name = L["From scale"],
						order = 500,
						min = 1,
						max = 20,
						step = 0.1,
					},

					movetime = {
						type = "range",
						name = L["Move time"],
						order = 600,
						min = 0.1,
						max = 3,
						step = 0.1,
					},

					toscale = {
						type = "range",
						name = L["To scale"],
						order = 700,
						min = 0.5,
						max = 6,
						step = 0.1,
					},
					toalpha = {
						type = "range",
						name = L["To alpha"],
						order = 850,
						min = 0.05,
						max = 1,
						step = 0.05,
					},
					fadeouttime = {
						type = "range",
						name = L["Fade out time"],
						order = 950,
						min = 0.1,
						max = 3,
						step = 0.05
					},
					enableomnicc = {
						type = "toggle",
						name = L["Use OmniCC timer"],
						order = 1000,
						desc = L["Requires OmniCC to be installed. If this is checked and OmniCC is not installed there will be no timer. The default timer will display if this is unchecked"],
					},
				},
			},
			individual = {
				type = "group",
				name = L["Individual"],
				order = 400,
				disabled = IsDisabled,
				args = {
					indvselect = {
						type = "select",
						name = L["Select proc"],
						order = 200,
						values = function()
							self.getprocs = self.getprocs or {}
							wipe(self.getprocs)
							for spellid in pairs(self.procs) do self.getprocs[spellid] = GetSpellInfo(spellid) end
							return self.getprocs
						end,
					},
					enabled = {
						type = "toggle",
						name = L["Enabled"],
						order = 300,
						-- FIXME: We don't have to create frames for disabled procs at all, but then
						-- the get/set logic here has to create them dynamically when enabled.
						get = function(info) return db.data[db.indvselect].enabled end,
						set = function(info,value) db.data[db.indvselect].enabled = value; self:LoadSettings() end, 
					},
					soundselect = {
						type = "select",
						name = L["Sound on proc"],
						order = 400,
						dialogControl = "LSM30_Sound",
						values = "GetSounds",
						get = function(info) return db.data[db.indvselect].sound end,
						set = function(info,value) db.data[db.indvselect].sound = value; self:LoadSettings() end, 
					},
				},
			},
		},
	}
end
