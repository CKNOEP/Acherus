 --[[
	Project.: LibButtonFacade
	File....: LibButtonFacade.lua
	Version.: 343
	Author..: StormFX, JJ Sheets
]]

-- [ Set Up ] --

local LBF
local assert = assert
do
	local major, minor = "LibButtonFacade", 40000
	local LS = assert(LibStub,major.." requires LibStub.")
	LBF = LS:NewLibrary(major,minor)
end
if not LBF then return end

-- [ Locals ] --

local error, pairs, print, setmetatable, type, unpack = error, pairs, print, setmetatable, type, unpack

-- [ Error Handling ] -- 

local E_PRE = "|cffffff99<LBF Debug>|r "
local E_ARG = "Bad argument to method '%s'. '%s' must be a %s."
local E_TPL = "Invalid template reference by skin '%s'. Skin '%s' does not exist."

local debug = false

-- Throws an error if debug mode is enabled.
local function Debug(e,...)
	if debug == true then
		local msg = (E_PRE..e):format(...)
		error(msg,3)
	end
end

function LBF:Debug()
	if not debug then
		debug = true
		print(E_PRE.."|cff00ff00enabled|r.")
	else
		debug = false
		print(E_PRE.."|cffff0000disabled|r.")
	end
end

-- [ Call Backs ] --

local FireGuiCB

do
	local callbacks = {}
	-- Fires all registered GUI call-backs.
	function FireGuiCB(Addon,Group,Button)
		for i = 1, #callbacks do
			local v = callbacks[i]
			v.cb(v.arg,Addon,Group,Button)
		end
	end
	-- Registers a GUI call-back.
	function LBF:RegisterGuiCallback(callback,arg)
		callbacks[#callbacks+1] = {cb = callback, arg = arg}
	end
end

local FireSkinCB

do
	local callbacks = {}
	-- Fires all call-backs registered for the specified add-on.
	function FireSkinCB(Addon,SkinID,Gloss,Backdrop,Group,Button,Colors)
		Addon = Addon or "ButtonFacade"
		local args = callbacks[Addon]
		if args then
			for arg, callback in pairs(args) do
				callback(arg and arg,SkinID,Gloss,Backdrop,Group,Button,Colors)
			end
		end
	end
	-- Registers a skin call-back for the specified add-on.
	function LBF:RegisterSkinCallback(Addon,callback,arg)
		local arg = callback and arg or false
		callbacks[Addon] = callbacks[Addon] or {}
		callbacks[Addon][arg] = callback
	end
end

-- [ Skins ] --

local Skins = {}
local SkinList = {}

do
	local hidden = {Hide = true}
	local layers = {"Backdrop","Icon","Flash","Cooldown","Pushed","Normal","Disabled","Checked","Border","Gloss","AutoCastable","Highlight","Name","Count","HotKey","AutoCast"}
	-- Adds a skin to the skin tables.
	function LBF:AddSkin(SkinID,SkinData,Replace)
		if type(SkinID) ~= "string" then
			Debug(E_ARG,"AddSkin","SkinID","string")
			return
		end
		if Skins[SkinID] and not Replace then
			return
		end
		if type(SkinData) ~= "table" then
			Debug(E_ARG,"AddSkin","SkinData","table")
			return
		end
		if SkinData.Template then
			if Skins[SkinData.Template] then
				setmetatable(SkinData,{__index=Skins[SkinData.Template]})
			else
				Debug(E_TPL,SkinID,SkinData.Template)
				return
			end
		end
		for _, layer in pairs(layers) do
			if type(SkinData[layer]) ~= "table" then
				SkinData[layer] = hidden
			end
		end
		Skins[SkinID] = SkinData
		SkinList[SkinID] = SkinID
	end
	-- Returns the specified skin.
	function LBF:GetSkin(SkinID)
		return Skins[SkinID]
	end
	-- Returns the skin data table.
	function LBF:GetSkins()
		return Skins
	end
	-- Returns the skin list.
	function LBF:ListSkins()
		return SkinList
	end
end

-- [ Colors ] --

-- Returns the layer's color table.
local function GetLayerColor(SkinLayer,Colors,Layer,Alpha)
	local color = Colors[Layer] or SkinLayer.Color
	if type(color) == "table" then
		return color[1] or 1, color[2] or 1, color[3] or 1, Alpha or color[4] or 1
	else
		return 1, 1, 1, Alpha or 1
	end
end

-- [ Default Settings ] --

local TexCoords = {0,1,0,1}

-- Standard Layers
local Layers = {
	Icon = "Texture",
	Flash = "Texture",
	Pushed = "Special",
	Disabled = "Special",
	Checked = "Special",
	Border = "Texture",
	AutoCastable = "Texture",
	Highlight = "Special",
}
-- Draw Layers
local Levels = {
	Backdrop = {"BACKGROUND",0},
	Icon = {"BORDER",0},
	Flash = {"ARTWORK",0},
	Pushed = {"BACKGROUND",0},
	Normal = {"BORDER",0},
	Disabled = {"BORDER",1},
	Checked = {"BORDER",2},
	Border = {"ARTWORK",0},
	Gloss = {"OVERLAY",0},
	AutoCastable = {"OVERLAY",1},
	Highlight = {"HIGHLIGHT",0},
}
-- Reparent
local Parent = {
	Backdrop = true,
	Icon = true,
}

-- [ Custom Layers ] --

-- [ Normal ] --

local SkinNormalLayer

do
	local base = {}
	local hooked = {}
	-- Hook to catch changes to the Normal texture.
	local function Hook_SetNormalTexture(Button,Texture)
		local region = Button.__LBF_Normal
		local normal = Button:GetNormalTexture()
		if Button.__LBF_NoNormal then
				normal:SetTexture("")
				normal:Hide()
			return
		end
		local skin = Button.__LBF_NormalSkin
		if Texture == "Interface\\Buttons\\UI-Quickslot2" then
			if normal ~= region then
				normal:SetTexture("")
				normal:Hide()
			end
			region:SetTexture(skin.Texture)
			region:SetTexCoord(unpack(skin.TexCoords or TexCoords))
			region.__LBF_UseEmpty = nil
		elseif Texture == "Interface\\Buttons\\UI-Quickslot" then
			if normal ~= region then
				normal:SetTexture("")
				normal:Hide()
			end
			if skin.EmptyTexture then
				region:SetTexture(skin.EmptyTexture)
				region:SetTexCoord(unpack(skin.EmptyCoords or TexCoords))
			else
				region:SetTexture(skin.Texture)
				region:SetTexCoord(unpack(skin.TexCoords or TexCoords))
			end
			region.__LBF_UseEmpty = true
		end
	end
	-- Skins the Normal layer.
	function SkinNormalLayer(Skin,Button,ButtonData,xScale,yScale,Colors)
		if ButtonData.Normal == false then return end
		local skin = Skin.Normal
		local region = ButtonData.Normal or Button:GetNormalTexture()
		if skin.Static then
			if region then
				region:SetTexture("")
				region:Hide()
				Button.__LBF_NoNormal = true
			end
			region = base[Button] or Button:CreateTexture()
			base[Button] = region
		else
			if base[Button] then base[Button]:Hide() end
		end
		if not region then return end
		Button.__LBF_Normal = region
		if (region:GetTexture() == "Interface\\Buttons\\UI-Quickslot" or region.__LBF_UseEmpty) and skin.EmptyTexture then
			region:SetTexture(skin.EmptyTexture)
			region:SetTexCoord(unpack(skin.EmptyCoords or TexCoords))
		else
			region:SetTexture(skin.Texture)
			region:SetTexCoord(unpack(skin.TexCoords or TexCoords))
		end
		if not hooked[Button] then
			hooksecurefunc(Button,"SetNormalTexture",Hook_SetNormalTexture)
			hooked[Button] = true
		end
		Button.__LBF_NormalSkin = skin
		region:Show()
		if skin.Hide then
			region:SetTexture("")
			region:Hide()
			return
		end
		region:SetDrawLayer(unpack(Levels.Normal))
		region:SetBlendMode(skin.BlendMode or "BLEND")
		region:SetVertexColor(GetLayerColor(skin,Colors,"Normal"))
		region:SetWidth((skin.Width or 36) * (skin.Scale or 1) * xScale)
		region:SetHeight((skin.Height or 36) * (skin.Scale or 1) * yScale)
		region:ClearAllPoints()
		region:SetPoint("CENTER",Button,"CENTER",skin.OffsetX or 0,skin.OffsetY or 0)
	end
	-- Gets the Normal texture.
	function LBF:GetNormalTexture(Button)
		return Button.__LBF_Normal or Button:GetNormalTexture()
	end
	-- Gets the Normal vertex color.
	function LBF:GetNormalVertexColor(Button)
		local region = self:GetNormalTexture(Button)
		if region then return region:GetVertexColor() end
	end
	-- Sets the Normal vertex color.
	function LBF:SetNormalVertexColor(Button,r,g,b,a)
		local region = self:GetNormalTexture(Button)
		if region then region:SetVertexColor(r,g,b,a) end
	end
end

-- [ Backdrop ] --

local SkinBackdropLayer,RemoveBackdropLayer

do
	local backdrop = {}
	local cache = {}
	-- Removes the Backdrop layer.
	function RemoveBackdropLayer(Button)
		local region = backdrop[Button]
		backdrop[Button] = nil
		if region then
			region:Hide()
			cache[#cache+1] = region
		end
	end
	-- Skins the Backdrop layer.
	function SkinBackdropLayer(Skin,Button,xScale,yScale,Colors)
		local region
		local index = #cache
		if backdrop[Button] then
			region = backdrop[Button]
		elseif index > 0 then
			region = cache[index]
			cache[index] = nil
		else
			region = Button:CreateTexture()
		end
		backdrop[Button] = region
		local skin = Skin.Backdrop
		region:SetParent(Button.__LBF_Level[1] or Button)
		region:SetTexture(skin.Texture)
		region:SetTexCoord(unpack(skin.TexCoords or TexCoords))
		region:SetDrawLayer(unpack(Levels.Backdrop))
		region:SetBlendMode(skin.BlendMode or "BLEND")
		region:SetVertexColor(GetLayerColor(skin,Colors,"Backdrop"))
		region:SetWidth((skin.Width or 36) * (skin.Scale or 1) * xScale)
		region:SetHeight((skin.Height or 36) * (skin.Scale or 1) * yScale)
		region:ClearAllPoints()
		region:SetPoint("CENTER",Button,"CENTER",skin.OffsetX or 0,skin.OffsetY or 0)
		region:Show()
	end
	-- Gets the Backdrop layer.
	function LBF:GetBackdropLayer(Button)
		return backdrop[Button]
	end
end

-- [ Gloss ] --

local SkinGlossLayer,RemoveGlossLayer

do
	local gloss = {}
	local cache = {}
	-- Removes the Gloss layer.
	function RemoveGlossLayer(Button)
		local layer = gloss[Button]
		gloss[Button] = nil
		if layer then
			layer:Hide()
			cache[#cache+1] = layer
		end
	end
	-- Skins the Gloss layer.
	function SkinGlossLayer(Skin,Button,xScale,yScale,Colors,Alpha)
		local region
		local index = #cache
		if gloss[Button] then
			region = gloss[Button]
		elseif index > 0 then
			region = cache[index]
			cache[index] = nil
		else
			region = Button:CreateTexture()
		end
		gloss[Button] = region
		local skin = Skin.Gloss
		region:SetParent(Button)
		region:SetTexture(skin.Texture)
		region:SetTexCoord(unpack(skin.TexCoords or TexCoords))
		region:SetDrawLayer(unpack(Levels.Gloss))
		region:SetVertexColor(GetLayerColor(skin,Colors,"Gloss",Alpha))
		region:SetBlendMode(skin.BlendMode or "BLEND")
		region:SetWidth((skin.Width or 36) * (skin.Scale or 1) * xScale)
		region:SetHeight((skin.Height or 36) * (skin.Scale or 1) * yScale)
		region:ClearAllPoints()
		region:SetPoint("CENTER",Button,"CENTER",skin.OffsetX or 0,skin.OffsetY or 0)
		region:Show()
	end
	-- Gets the Gloss layer.
	function LBF:GetGlossLayer(Button)
		return gloss[Button]
	end
end

-- [ Special Layers ] --

local function SkinSpecialLayer(Skin,Button,Region,Layer,xScale,yScale,Colors)
	local skin = Skin[Layer]
	if skin.Hide then
		Region:SetTexture("")
		Region:Hide()
		return
	end
	local texture = skin.Texture or Region:GetTexture()
	Region:SetTexture(texture)
	Region:SetTexCoord(unpack(skin.TexCoords or TexCoords))
	Region:SetDrawLayer(unpack(Levels[Layer]))
	Region:SetBlendMode(skin.BlendMode or "BLEND")
	Region:SetVertexColor(GetLayerColor(skin,Colors,Layer))
	Region:SetWidth((skin.Width or 36) * (skin.Scale or 1) * xScale)
	Region:SetHeight((skin.Height or 36) * (skin.Scale or 1) * yScale)
	Region:ClearAllPoints()
	Region:SetPoint("CENTER",Button,"CENTER",skin.OffsetX or 0,skin.OffsetY or 0)
end

-- [ Texture Layers ] --

local function SkinTextureLayer(Skin,Button,Region,Layer,xScale,yScale,Colors)
	local skin = Skin[Layer]
	if skin.Hide then
		Region:SetTexture("")
		Region:Hide()
		return
	end
	if Parent[Layer] then
		Region:SetParent(Button.__LBF_Level[1] or Button)
	end
	if Layer ~= "Icon" then
		local texture = skin.Texture or Region:GetTexture()
		Region:SetTexture(texture)
		if Layer ~= "Border" then
			Region:SetVertexColor(GetLayerColor(skin,Colors,Layer))
		end
	end
	Region:SetTexCoord(unpack(skin.TexCoords or TexCoords))
	Region:SetDrawLayer(unpack(Levels[Layer]))
	Region:SetBlendMode(skin.BlendMode or "BLEND")
	Region:SetWidth((skin.Width or 36) * (skin.Scale or 1) * xScale)
	Region:SetHeight((skin.Height or 36) * (skin.Scale or 1) * yScale)
	Region:ClearAllPoints()
	Region:SetPoint("CENTER",Button,"CENTER",skin.OffsetX or 0,skin.OffsetY or 0)
end

-- [ Text Layers ] --

-- Skins a text layer. Temporary function for backward compatibility.
local function SkinTextLayer(Skin,Button,ButtonData,Layer,xScale,yScale,Colors)
	if ButtonData[Layer] == nil then
		local name = Button:GetName()
		ButtonData[Layer] = (name and _G[name..Layer]) or false
	end
	local region = ButtonData[Layer]
	local skin = Skin[Layer]
	if not region or skin.Hide then return end
	region:SetDrawLayer("OVERLAY")
	region:SetWidth((skin.Width or 36) * (skin.Scale or 1) * xScale)
	region:SetHeight((skin.Height or 10) * (skin.Scale or 1) * yScale)
	region:ClearAllPoints()
	if Layer == "HotKey" then
		if not region.__LBF_SetPoint then
			region.__LBF_SetPoint = region.SetPoint
			region.SetPoint = function() end
		end
		region:__LBF_SetPoint("CENTER",Button,"CENTER",skin.OffsetX or 0,skin.OffsetY or 0)
	else
		region:SetPoint("CENTER",Button,"CENTER",skin.OffsetX or 0,skin.OffsetY or 0)
		region:SetVertexColor(GetLayerColor(skin,Colors,Layer))
	end
end


-- Skins the Name text.
local function SkinNameText(Skin,Button,ButtonData,xScale,yScale,Colors)
	if ButtonData.Name == nil then
		local name = Button:GetName()
		ButtonData.Name = (name and _G[name.."Name"]) or false
	end
	local region = ButtonData.Name
	local skin = Skin.Name
	if not region or skin.Hide then return end
	local font, _, flags = region:GetFont()
	region:SetFont(skin.Font or font,skin.FontSize or 11,flags)
	region:SetJustifyH(skin.JustifyH or "CENTER")
	region:SetJustifyV(skin.JustifyV or "MIDDLE")
	region:SetDrawLayer("OVERLAY")
	region:SetWidth((skin.Width or 36) * (skin.Scale or 1) * xScale)
	region:SetHeight((skin.Height or 10) * (skin.Scale or 1) * yScale)
	region:ClearAllPoints()
	region:SetPoint("BOTTOM",Button,"BOTTOM",skin.OffsetX or 0,skin.OffsetY or 0)
	region:SetVertexColor(GetLayerColor(skin,Colors,"Name"))
end

-- Skins the Count text.
local function SkinCountText(Skin,Button,ButtonData,xScale,yScale,Colors)
	if ButtonData.Count == nil then
		local name = Button:GetName()
		ButtonData.Count = (name and _G[name.."Count"]) or false
	end
	local region = ButtonData.Count
	local skin = Skin.Count
	if not region or skin.Hide then return end
	local font, _, flags = region:GetFont()
	region:SetFont(skin.Font or font,skin.FontSize or 15,flags)
	region:SetJustifyH(skin.JustifyH or "RIGHT")
	region:SetJustifyV(skin.JustifyV or "MIDDLE")
	region:SetDrawLayer("OVERLAY")
	region:SetWidth((skin.Width or 36) * (skin.Scale or 1) * xScale)
	region:SetHeight((skin.Height or 10) * (skin.Scale or 1) * yScale)
	region:ClearAllPoints()
	region:SetPoint("BOTTOMRIGHT",Button,"BOTTOMRIGHT",skin.OffsetX or 0,skin.OffsetY or 0)
	region:SetVertexColor(GetLayerColor(skin,Colors,"Count"))
end

-- Skins the HotKey text.
local function SkinHotKeyText(Skin,Button,ButtonData,xScale,yScale)
	if ButtonData.HotKey == nil then
		local name = Button:GetName()
		ButtonData.HotKey = (name and _G[name.."HotKey"]) or false
	end
	local region = ButtonData.HotKey
	local skin = Skin.HotKey
	if not region or skin.Hide then return end
	local font, _, flags = region:GetFont()
	region:SetFont(skin.Font or font,skin.FontSize or 13,flags)
	region:SetJustifyH(skin.JustifyH or "RIGHT")
	region:SetJustifyV(skin.JustifyV or "MIDDLE")
	region:SetDrawLayer("OVERLAY")
	region:SetWidth((skin.Width or 36) * (skin.Scale or 1) * xScale)
	region:SetHeight((skin.Height or 10) * (skin.Scale or 1) * yScale)
	region:ClearAllPoints()
	if not region.__LBF_SetPoint then
		region.__LBF_SetPoint = region.SetPoint
		region.SetPoint = function() end
	end
	region:__LBF_SetPoint("TOPLEFT",Button,"TOPLEFT",skin.OffsetX or 0,skin.OffsetY or 0)
end

-- [ Frame Layers ] --

-- [ Cooldown ] --

-- Skins the Cooldown frame.
local function SkinCooldownFrame(Skin,Button,Region,xScale,yScale)
	local skin = Skin.Cooldown
	if skin.Hide then
		Region:Hide()
		return
	end
	Region:SetWidth((skin.Width or 36) * (skin.Scale or 1) * xScale)
	Region:SetHeight((skin.Height or 36) * (skin.Scale or 1) * yScale)
	Region:ClearAllPoints()
	Region:SetPoint("CENTER",Button,"CENTER",skin.OffsetX or 0,skin.OffsetY or 0)
end

-- [ AutoCast ] --

-- Skins the AutoCast frame.
local function SkinAutoCastFrame(Skin,Button,Region,xScale,yScale)
	local skin = Skin.AutoCast
	if skin.Hide then
		Region:Hide()
		return
	end
	Region:SetWidth((skin.Width or 36) * (skin.Scale or 1) * xScale)
	Region:SetHeight((skin.Height or 36) * (skin.Scale or 1) * yScale)
	Region:ClearAllPoints()
	Region:SetPoint("CENTER",Button,"CENTER",skin.OffsetX or 0,skin.OffsetY or 0)
end

-- [ Skin Function ] --

local ApplySkin

do
	local hooked = {}
	local empty = {}
	local offsets = {
		[1] = -2,
		[2] = -1,
		[4] = 1,
	}
	-- Hook to automatically adjust the button's additional frames.
	local function Hook_SetFrameLevel(Button,Level)
		local base = Level or Button:GetFrameLevel()
		if base < 3 then base = 3 end
		for k,v in pairs(offsets) do
			local f = Button.__LBF_Level[k]
			if f then
				local level = base + v
				f:SetFrameLevel(level)
			end
		end
	end
	-- Applies a skin to a button and its associated layers.
	function ApplySkin(SkinID,Gloss,Backdrop,Colors,Button,ButtonData)
		if not Button then return end
		Button.__LBF_Level = Button.__LBF_Level or {}
		if not Button.__LBF_Level[1] then
			local frame1 = CreateFrame("Frame",nil,Button)
			Button.__LBF_Level[1] = frame1 -- Frame Level 1
		end
		Button.__LBF_Level[3] = Button -- Frame Level 3
		Colors = Colors or empty
		if type(Gloss) ~= "number" then
			Gloss = (Gloss and 1) or 0
		end
		local xScale = (Button:GetWidth() or 36) / 36
		local yScale = (Button:GetHeight() or 36) / 36
		local skin = Skins[SkinID or "Blizzard"] or Skins["Blizzard"]
		local name = Button:GetName()
		if Backdrop and not skin.Backdrop.Hide then
			SkinBackdropLayer(skin,Button,xScale,yScale,Colors)
		else
			RemoveBackdropLayer(Button)
		end
		for layer, type in pairs(Layers) do
			if ButtonData[layer] == nil then
				if type == "Special" then
					local f = Button["Get"..layer.."Texture"]
					ButtonData[layer] = (f and f(Button)) or false
				else
					ButtonData[layer] = (name and _G[name..layer]) or false
				end
			end
			local region = ButtonData[layer]
			if region then
				if type == "Special" then
					SkinSpecialLayer(skin,Button,region,layer,xScale,yScale,Colors)
				else
					SkinTextureLayer(skin,Button,region,layer,xScale,yScale,Colors)
				end
			end
		end
		SkinNormalLayer(skin,Button,ButtonData,xScale,yScale,Colors)
		if ButtonData.Cooldown == nil then
			ButtonData.Cooldown = (name and _G[name.."Cooldown"]) or false
		end
		if Gloss > 0 and not skin.Gloss.Hide then
			SkinGlossLayer(skin,Button,xScale,yScale,Colors,Gloss)
		else
			RemoveGlossLayer(Button)
		end
		if ButtonData.Cooldown then
			Button.__LBF_Level[2] = ButtonData.Cooldown -- Frame Level 2
			SkinCooldownFrame(skin,Button,ButtonData.Cooldown,xScale,yScale)
		end
		local version = skin.LBF_Version
		if type(version) == "number" and version >= 40000 then
			SkinNameText(skin,Button,ButtonData,xScale,yScale,Colors)
			SkinCountText(skin,Button,ButtonData,xScale,yScale,Colors)
			SkinHotKeyText(skin,Button,ButtonData,xScale,yScale)
		else
			SkinTextLayer(skin,Button,ButtonData,"Name",xScale,yScale,Colors)
			SkinTextLayer(skin,Button,ButtonData,"Count",xScale,yScale,Colors)
			SkinTextLayer(skin,Button,ButtonData,"HotKey",xScale,yScale,Colors)
		end
		if ButtonData.AutoCast == nil then
			ButtonData.AutoCast = (name and _G[name.."Shine"]) or false
		end
		if ButtonData.AutoCast then
			Button.__LBF_Level[4] = ButtonData.AutoCast -- Frame Level 4
			SkinAutoCastFrame(skin,Button,ButtonData.AutoCast,xScale,yScale)
		end
		if not hooked[Button] then
			hooksecurefunc(Button,"SetFrameLevel",Hook_SetFrameLevel)
			hooked[Button] = true
		end
		-- Reorder the frames.
		local level = Button:GetFrameLevel()
		if level < 4 then
			level = 4
		end
		Button:SetFrameLevel(level)
	end
end

-- [ Groups ] --

-- Returns a group ID. IE: Addon, Addon_Group or Addon_Group_Button.
local function RegID(Addon,Group,Button)
	local id = "ButtonFacade"
	if Addon then
		id = Addon
		if Group then
			id = id.."_"..Group
			if Button then
				id = id.."_"..Button
			end
		end
	end
	return id
end

local Groups = {}
local GroupMT

-- Creates and returns a group.
local function NewGroup(Addon,Group,Button)
	if not Group then Button = nil end
	local o = {
		Addon = Addon,
		Group = Group,
		Button = Button,
		RegID = RegID(Addon,Group,Button),
		SkinID = "Blizzard",
		Gloss = false,
		Backdrop = false,
		Colors = {},
		Buttons = {},
		SubList = not Button and {} or nil,
	}
	setmetatable(o,GroupMT)
	Groups[o.RegID] = o
	if Addon then
		local a = Groups["ButtonFacade"] or NewGroup()
		o.Parent = a
		a:AddSubGroup(Addon)
	end
	if Group then
		local a = Groups[Addon] or NewGroup(Addon)
		o.Parent = a
		a:AddSubGroup(Group)
		if Button then
			local ag = Groups[Addon.."_"..Group] or NewGroup(Addon,Group)
			o.Parent = ag
			ag:AddSubGroup(Button)
		end
	end
	return o
end

-- Returns a group.
function LBF:Group(Addon,Group,Button)
	local group = Groups[RegID(Addon,Group,Button)] or NewGroup(Addon,Group,Button)
	return group
end

-- Returns a list of add-ons.
function LBF:ListAddons()
	local group = self:Group()
	return group.SubList
end

-- Returns a list of groups registered to an add-on.
function LBF:ListGroups(Addon)
	return Groups[Addon].SubList
end

-- Returns a list of buttons registered to a group.
function LBF:ListButtons(Addon,Group)
	return Groups[Addon.."_"..Group].SubList
end
do
	local reverse = {}
	-- Group Metatable
	GroupMT = {
		__index = {
			-- [ Button ] --
			-- Adds a button to the group.
			AddButton = function(self,Button,ButtonData)
				if type(Button) ~= "table" then
					Debug(E_ARG,"AddButton","Button","table")
					return
				end
				if reverse[Button] == self then return end
				if reverse[Button] then
					reverse[Button]:RemoveButton(Button,true)
				end
				reverse[Button] = self
				ButtonData = ButtonData or {}
				self.Buttons[Button] = ButtonData
				ApplySkin(self.SkinID,self.Gloss,self.Backdrop,self.Colors,Button,ButtonData)
			end,
			-- Removes a button from the group and optionally reskins it.
			RemoveButton = function(self,Button,noReskin)
				if not Button then return end
				local btndata = self.Buttons[Button]
				reverse[Button] = nil
				if btndata and not noReskin then
					ApplySkin("Blizzard",false,false,nil,Button,btndata)
				end
				self.Buttons[Button] = nil
			end,
			-- Deletes the current group.
			Delete = function(self,noReskin)
				local sl = self.SubList
				if sl then
					for k in pairs(sl) do
						Groups[k]:Delete()
					end
				end
				for k in pairs(self.Buttons) do
					reverse[k] = nil
					if not noReskin then
						ApplySkin("Blizzard",false,false,nil,k,self.Buttons[k])
					end
					self.Buttons[k] = nil
				end
				self.Parent:RemoveSubGroup(self)
				Groups[self.RegID] = nil
			end,
			-- [ Skin ] --
			-- Updates the groups's skin with the new data and then applies it.
			Skin = function(self,SkinID,Gloss,Backdrop,Colors)
				self.SkinID = SkinID and SkinList[SkinID] or self.SkinID
				if type(Gloss) ~= "number" then
					Gloss = (Gloss and 1) or 0
				end
				self.Gloss = Gloss
				self.Backdrop = (Backdrop and true) or false
				if type(Colors) == "table" then
					self.Colors = Colors
				end
				for k in pairs(self.Buttons) do
					ApplySkin(self.SkinID,self.Gloss,self.Backdrop,self.Colors,k,self.Buttons[k])
				end
				FireSkinCB(self.Addon,self.SkinID,self.Gloss,self.Backdrop,self.Group,self.Button,self.Colors)
				local sl = self.SubList
				if sl then
					for k in pairs(sl) do
						Groups[k]:Skin(SkinID,Gloss,Backdrop,Colors)
					end
				end
			end,
			-- Reskins the group.
			ReSkin = function(self)
				self:Skin(self.SkinID,self.Gloss,self.Backdrop,self.Colors)
			end,
			-- [ Internal ] --
			-- Adds a sub-group to a group.
			AddSubGroup = function(self,SubGroup)
				if self.RegID == "ButtonFacade" then
					self.SubList[SubGroup] = SubGroup
				else
					self.SubList[self.RegID.."_"..SubGroup] = SubGroup
				end
				FireGuiCB(self.Addon,self.Group,self.Button)
			end,
			-- Removes a sub-group from a group.
			RemoveSubGroup = function(self,SubGroup)
				local r = SubGroup.RegID
				self.SubList[r] = nil
				FireGuiCB(self.Addon,self.Group,self.Button)
			end,
			-- [ GUI ] --
			-- Updates only the specified group's skin data and doesn't apply it.
			SetSkin = function(self,SkinID,Gloss,Backdrop,Colors)
				self.SkinID = SkinID and SkinList[SkinID] or self.SkinID
				if type(Gloss) ~= "number" then
					Gloss = (Gloss and 1) or 0
				end
				self.Gloss = Gloss
				self.Backdrop = (Backdrop and true) or false
				if type(Colors) == "table" then
					self.Colors = Colors
				end
				FireSkinCB(self.Addon,self.SkinID,self.Gloss,self.Backdrop,self.Group,self.Button,self.Colors)
			end,
			-- Returns a layer's color.
			GetLayerColor = function(self,Layer)
				local skin = Skins[self.SkinID or "Blizzard"] or Skins["Blizzard"]
				return GetLayerColor(skin[Layer],self.Colors,Layer)
			end,
			-- Sets a layer's color and optionally reskins the group.
			SetLayerColor = function(self,Layer,r,g,b,a)
				if r then
					self.Colors[Layer] = {r,g,b,a}
				else
					self.Colors[Layer] = nil
				end
				if not noReskin then self:ReSkin() end
			end,
			-- Resets a layer's colors.
			ResetColors = function(self,noReskin)
				local c = self.Colors
				for k in pairs(c) do c[k] = nil end
				local sl = self.SubList
				if sl then
					for k in pairs(sl) do
						Groups[k]:ResetColors(true)
					end
				end
				if not noReskin then self:Skin() end
			end,
		}
	}
end

-- [ Default Skin ] --

SkinList.Blizzard = "Blizzard"
Skins.Blizzard = {
	LBF_Version = 40000,
	Backdrop = {
		Width = 34,
		Height = 35,
		Texture = [[Interface\Buttons\UI-EmptySlot]],
		OffsetY = -0.5,
		TexCoords = {0.2,0.8,0.2,0.8},
	},
	Icon = {
		Width = 36,
		Height = 36,
	},
	Flash = {
		Width = 36,
		Height = 36,
		Texture = [[Interface\Buttons\UI-QuickslotRed]],
	},
	Cooldown = {
		Width = 36,
		Height = 36,
	},
	Pushed = {
		Width = 36,
		Height = 36,
		Texture = [[Interface\Buttons\UI-Quickslot-Depress]],
	},
	Normal = {
		Width = 66,
		Height = 66,
		Texture = [[Interface\Buttons\UI-Quickslot2]],
		EmptyTexture = [[Interface\Buttons\UI-Quickslot]],
		OffsetY = -1,
	},
	Disabled = {
		Width = 66,
		Height = 66,
		Texture = [[Interface\Buttons\UI-Quickslot2]],
		OffsetY = -1,
	},
	Checked = {
		Width = 36,
		Height = 36,
		Texture = [[Interface\Buttons\CheckButtonHilight]],
		BlendMode = "ADD",
	},
	Border = {
		Width = 62,
		Height = 62,
		Texture = [[Interface\Buttons\UI-ActionButton-Border]],
		BlendMode = "ADD",
	},
	Gloss = {
		Hide = true
	},
	AutoCastable = {
		Width = 58,
		Height = 58,
		Texture = [[Interface\Buttons\UI-AutoCastableOverlay]],
	},
	Highlight = {
		Width = 36,
		Height = 36,
		Texture = [[Interface\Buttons\ButtonHilight-Square]],
		BlendMode = "ADD",
	},
	Name = {
		Width = 36,
		Height = 10,
		OffsetY = 2,
	},
	Count = {
		Width = 36,
		Height = 10,
		OffsetY = 2,
	},
	HotKey = {
		Width = 36,
		Height = 10,
		OffsetY = -3,
	},
	AutoCast = {
		Width = 36,
		Height = 36,
	},
}
