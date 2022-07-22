--[[
	Project: Acherus WLTK Classic
	Website: http://www.wowace.com/projects/acherus/
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

local SM = LibStub("LibSharedMedia-3.0")
local path = "Interface\\Addons\\Acherus\\Textures\\" 

-- StatusBars
SM:Register("statusbar", "Ace", path.."Ace")
SM:Register("statusbar", "Banto", path.."Banto")
SM:Register("statusbar", "Charcoal", path.."Charcoal")
SM:Register("statusbar", "Charcoal", path.."Perl")
SM:Register("statusbar", "Cool", path.."Cool")
SM:Register("statusbar", "Futuristic", path.."Futuristic")
SM:Register("statusbar", "Glaze", path.."Glaze")
SM:Register("statusbar", "Gloss", path.."Gloss")
SM:Register("statusbar", "Grunge", path.."Grunge")
SM:Register("statusbar", "Halycon", path.."Halycon")
SM:Register("statusbar", "LiteStep", path.."LiteStep")
SM:Register("statusbar", "Metal", path.."Metal")
SM:Register("statusbar", "Smooth", path.."Smooth")
SM:Register("statusbar", "Steel", path.."Steel")
SM:Register("statusbar", "Stone", path.."Stone")
SM:Register("statusbar", "Striped", path.."Striped")
SM:Register("statusbar", "Water", path.."Water")

-- Sounds - Taken from Omen Threat Meter
SM:Register("Sound", "Bell Toll Alliance", "Sound\\Doodad\\BellTollAlliance.wav")
SM:Register("Sound", "Bell Toll Horde", "Sound\\Doodad\\BellTollHorde.wav")
SM:Register("sound", "Rubber Ducky", "Sound\\Doodad\\Goblin_Lottery_Open01.wav")
SM:Register("sound", "Cartoon FX", "Sound\\Doodad\\Goblin_Lottery_Open03.wav")
SM:Register("sound", "Explosion", "Sound\\Doodad\\Hellfire_Raid_FX_Explosion05.wav")
SM:Register("sound", "Shing!", "Sound\\Doodad\\PortcullisActive_Closed.wav")
SM:Register("sound", "Wham!", "Sound\\Doodad\\PVP_Lordaeron_Door_Open.wav")
SM:Register("sound", "Simon Chime", "Sound\\Doodad\\SimonGame_LargeBlueTree.wav")
SM:Register("sound", "War Drums", "Sound\\Event Sounds\\Event_wardrum_ogre.wav")
SM:Register("sound", "Cheer", "Sound\\Event Sounds\\OgreEventCheerUnique.wav")
SM:Register("sound", "Humm", "Sound\\Spells\\SimonGame_Visual_GameStart.wav")
SM:Register("sound", "Short Circuit", "Sound\\Spells\\SimonGame_Visual_BadPress.wav")
SM:Register("sound", "Fel Portal", "Sound\\Spells\\Sunwell_Fel_PortalStand.wav")
SM:Register("sound", "Fel Nova", "Sound\\Spells\\SeepingGaseous_Fel_Nova.wav")
SM:Register("sound", "You Will Die!", "Sound\\Creature\\CThun\\CThunYouWillDIe.wav")

-- Fonts
SM:Register("Font","Bastardus Sans","Interface\\AddOns\\Acherus\\fonts\\bs.ttf")
SM:Register("Font","Franklin Gothic Medium","Interface\\AddOns\\Acherus\\fonts\\framd.ttf")
