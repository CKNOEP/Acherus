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

--[[
	Rotates textures on orientations and adds a reversal function
	SetValue clamped to [0,1]
	Keep fields prefixed with '_'. It's unlikely authors will modify them.
]]
local EnhancedStatusBar = {}

function EnhancedStatusBar:SetStatusBarTexture(texture)
	self._texture:SetTexture(texture)
end

function EnhancedStatusBar:IsReversed()
	return self._reversed
end

function EnhancedStatusBar:SetReversed(isReversed)
	isReversed = not not isReversed -- Convert to boolean
	self._reversed = isReversed
	self:SetOrientation(self._orientation)
end

function EnhancedStatusBar:GetOrientation()
	return self._orientation
end

function EnhancedStatusBar:SetOrientation(orientation)
	self._orientation = orientation or "HORIZONTAL"
	self._texture:ClearAllPoints()
	if self._orientation == "VERTICAL" then
		if self._reversed then
			self._texture:SetPoint("TOPLEFT",self,"TOPLEFT")
			self._texture:SetPoint("TOPRIGHT",self,"TOPRIGHT")
		else
			self._texture:SetPoint("BOTTOMLEFT",self,"BOTTOMLEFT")
			self._texture:SetPoint("BOTTOMRIGHT",self,"BOTTOMRIGHT")
		end
	elseif self._orientation == "HORIZONTAL" then
		if self._reversed then
			self._texture:SetPoint("TOPRIGHT",self,"TOPRIGHT") 
			self._texture:SetPoint("BOTTOMRIGHT",self,"BOTTOMRIGHT")
		else
			self._texture:SetPoint("BOTTOMLEFT",self,"BOTTOMLEFT")
			self._texture:SetPoint("TOPLEFT",self,"TOPLEFT")
		end
	end
	self:SetValue(self._value)
end

function EnhancedStatusBar:GetValue()
	return self._value
end

function EnhancedStatusBar:SetValue(value)
	value = value <= 0 and 1e-6 or value
	value = value > 1 and 1 or value
	self._value = value
	if self._orientation == "HORIZONTAL" then
		self._texture:SetWidth(self:GetWidth() * value)
		if self._reversed then
			self._texture:SetTexCoord(1-value,1,0,1)
		else
			self._texture:SetTexCoord(0,value,0,1)
		end
	elseif self._orientation == "VERTICAL" then
		self._texture:SetHeight(self:GetHeight() * value)
		if self._reversed then
			self._texture:SetTexCoord(1,0,1-value,0,1,1,1-value,1)
		else
			self._texture:SetTexCoord(value,0,0,0,value,1,0,1)
		end
	end
end

function EnhancedStatusBar:SetStatusBarColor(r,g,b,a)
	self._texture:SetVertexColor(r,g,b,a)
end

local function OnSizeChanged(self)
	self:SetValue(self._value)
end

-- Add to Acherus
function Acherus:CreateEnhancedStatusBar(name,parent)
	local sb = CreateFrame("Frame",name,parent,BackdropTemplateMixin and "BackdropTemplate")
	-- Embed
	for k,v in pairs(EnhancedStatusBar) do sb[k] = v end
	-- Initialization
	sb._texture = sb:CreateTexture(nil,"ARTWORK")
	sb._value = 0
	sb:SetOrientation("HORIZONTAL")
	sb:SetScript("OnSizeChanged",OnSizeChanged)
	return sb
end

