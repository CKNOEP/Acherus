--[[
	Project: Acherus WLTK Classic
	Website: http://www.wowace.com/projects/acherus/
	Rev: 7
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

local insert,remove = table.insert,table.remove
local assert,type = assert,type
local ipairs = ipairs
local floor = math.floor
local sin,cos,pi,rad,max,min = math.sin,math.cos,math.pi,math.rad,math.max,math.min

local Animate = CreateFrame("Frame",Acherus:GetName().."Animate",UIParent)
Acherus.Animate = Animate

local tables = {
	{  -- FontString Pulse In/Out 
		func = function(obj)
			if obj.__elapsed <= obj.__uptime then
				obj:SetFont(obj.__font,floor(obj.__fontmin + ((obj.__fontmax - obj.__fontmin)*obj.__elapsed/obj.__uptime)),obj.__flag1,obj.__flag2,obj.__flag3)
			elseif obj.__elapsed <= obj.__downtime then
				obj:SetFont(obj.__font,floor(obj.__fontmax - ((obj.__fontmax - obj.__fontmin)*(obj.__elapsed-obj.__uptime)/(obj.__downtime-obj.__uptime))),obj.__flag1,obj.__flag2,obj.__flag3)
			else
				obj:SetFont(obj.__font,obj.__fontmin,obj.__flag1,obj.__flag2,obj.__flag3)
				return true
			end
		end
	},
	{ -- Region Pulse In/Out
		func = function(obj)
			if obj.__elapsed <= obj.__uptime then
				local size = floor(obj.__sizemin + ((obj.__sizemax - obj.__sizemin) * obj.__elapsed / obj.__uptime))
				obj:SetWidth(size); obj:SetHeight(size)
			elseif obj.__elapsed <= obj.__downtime then
				local size = floor(obj.__sizemax - ((obj.__sizemax - obj.__sizemin) * (obj.__elapsed-obj.__uptime) / (obj.__downtime-obj.__uptime)))
				obj:SetWidth(size); obj:SetHeight(size)
			else
				obj:SetHeight(obj.__sizemin); obj:SetWidth(obj.__sizemin)
				return true
			end
		end
	},
	{ -- Texture Pulse In/Out + Spin
		func = function(obj)
			local angle = obj.__angle * (obj.__elapsed/obj.__downtime)
			if obj.__elapsed <= obj.__uptime then
				local size = floor(obj.__sizemin + ((obj.__sizemax - obj.__sizemin) * obj.__elapsed / obj.__uptime))
				obj:SetWidth(size); obj:SetHeight(size)
				obj:SetRotation(angle)
			elseif obj.__elapsed <= obj.__downtime then
				local size = floor(obj.__sizemax - ((obj.__sizemax - obj.__sizemin) * (obj.__elapsed-obj.__uptime) / (obj.__downtime-obj.__uptime)))
				obj:SetWidth(size); obj:SetHeight(size)
				obj:SetRotation(angle)
			else
				obj:SetHeight(obj.__sizemin); obj:SetWidth(obj.__sizemin)
				obj:SetTexCoord(0,1,0,1)
				return true
			end
		end
	},
	{ -- Frame Scale Up/Down
		func = function(obj)
			if obj.__elapsed <= obj.__scaletime then
				local scale = obj.__fromscale - ((obj.__fromscale-obj.__toscale)*(obj.__elapsed / obj.__scaletime))
				obj:SetScale(max(scale,0.001))
			else
				obj:SetScale(obj.__toscale)
				return true
			end
		end
	},
	{ -- Texture Spin
		func = function(obj)
			local angle = obj.__angle * (obj.__elapsed/obj.__downtime)
			if obj.__elapsed <= obj.__uptime then
				obj:SetRotation(angle)
			elseif obj.__elapsed <= obj.__downtime then
				obj:SetRotation(angle)
			else
				obj:SetTexCoord(0,1,0,1)
				return true
			end
		end
	},
}

local tn = #tables
function Animate.OnUpdate(self,elapsed)
	local go = false
	for i=1,tn do
		local t = tables[i]
		local n,i = #t,1
		if n > 0 then
			go = true
			while(i <= n) do
				local obj = t[i]
				obj.__elapsed = obj.__elapsed + elapsed
				local rem = t.func(obj)
				if rem then remove(t,i); n = n - 1
				else i = i + 1 end
			end
		end
	end
	if not go then self:SetScript("OnUpdate",nil) end
end

function Animate.StartOnUpdate()
	if not Animate:GetScript("OnUpdate") then
		Animate:SetScript("OnUpdate",Animate.OnUpdate)
	end
end

function Animate.Remove(obj)
	for _,t in ipairs(tables) do
		for i,__obj in ipairs(t) do
			if __obj == obj then remove(t,i) return end
		end
	end
end

function Animate.Start(obj,type)
	obj.__elapsed = 0
	Animate.Remove(obj)
	Animate.StartOnUpdate()
	insert(tables[type],obj)
end

-------------------------------------------------------------

function Acherus:AnimateTextPulse(obj,uptime,downtime,fontmin,fontmax)
	assert(obj:IsObjectType("FontString"),"Expected FontString object")
	assert(type(fontmin) == "number","Expected number")
	assert(type(fontmax) == "number","Expected number")
	assert(type(uptime) == "number","Expected number")
	assert(type(downtime) == "number","Expected number")
	local _
	obj.__font, _, obj.__flag1, obj.__flag2, obj.__flag3 = obj:GetFont()
	obj.__fontmin = fontmin
	obj.__fontmax = fontmax
	obj.__uptime = uptime
	obj.__downtime = uptime + downtime
	Animate.Start(obj,1)
end


function Acherus:AnimateRegionPulse(obj,uptime,downtime,sizemin,sizemax)
	assert(obj:IsObjectType("Region"),"Expected Region object")
	assert(type(sizemin) == "number","Expected number")
	assert(type(sizemax) == "number","Expected number")
	assert(type(uptime) == "number","Expected number")
	assert(type(downtime) == "number","Expected number")
	obj.__sizemin = sizemin
	obj.__sizemax = sizemax
	obj.__uptime = uptime
	obj.__downtime = uptime + downtime
	Animate.Start(obj,2)
end



function Acherus:AnimateTexturePulseSpin(obj,uptime,downtime,sizemin,sizemax,angle)
	assert(obj:IsObjectType("Texture"),"Expected Region object")
	assert(type(sizemin) == "number","Expected number")
	assert(type(sizemax) == "number","Expected number")
	assert(type(uptime) == "number","Expected number")
	assert(type(downtime) == "number","Expected number")
	assert(type(angle) == "number","Expected number")
	obj.__sizemin = sizemin
	obj.__sizemax = sizemax
	obj.__uptime = uptime
	obj.__downtime = uptime + downtime
	obj.__angle = rad(angle)
	Animate.Start(obj,3)
end



function Acherus:AnimateScale(obj,scaletime,fromscale,toscale)
	assert(obj:IsObjectType("Frame"),"Expected Frame object")
	assert(type(scaletime) == "number","Expected number")
	assert(type(fromscale) == "number","Expected number")
	assert(type(toscale) == "number","Expected number")
	obj.__scaletime = scaletime
	obj.__fromscale = fromscale
	obj.__toscale = toscale
	Animate.Start(obj,4)
end

function Acherus:AnimateTextureSpin(obj,uptime,downtime,angle)
	assert(obj:IsObjectType("Texture"),"Expected Region object")
	assert(type(uptime) == "number","Expected number")
	assert(type(downtime) == "number","Expected number")
	assert(type(angle) == "number","Expected number")
	obj.__uptime = uptime
	obj.__downtime = uptime + downtime
	obj.__angle = rad(angle)
	Animate.Start(obj,5)
end
