--[[
	Project: Acherus WLTK Classic
	Website: https://www.curseforge.com/wow/addons/acherus-wltk-classic
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

--[[
	The contents of this file are auto-generated using the WoWAce localization application
	Please go to https://www.curseforge.com/wow/addons/acherus-wltk-classiclocalization/ to update translations.
	Anyone with a wowace/curseforge account can edit them. 
]] 

local AL = LibStub("AceLocale-3.0")
local debug = true
--[===[@debug@
debug = true
--@end-debug@]===]

local L = AL:NewLocale("Acherus", "enUS", true, debug)
if L then
L["20 > RP >= 0"] = true
L["40 > RP >= 20"] = true
L["60 > RP >= 40"] = true
L["80 >= RP"] = true
L["80 > RP >= 60"] = true
L["About"] = true
L["Acherus"] = true
L["Acherus by Kollektiv.& Lancestre. Type /ac or /acherus to open options"] = true
L["Acherus is now locked"] = true
L["Acherus is now unlocked"] = true
L[ [=[A proc will start maximized and then minimize.
 |cff00ff00Step 1|r: Initial size is |cffffd200From scale|r. Fades in from 0 to |cffffd200Fade in alpha|r taking |cffffd200Fade in time|r (seconds) and is anchored to |cffffd200From|r.
 |cff00ff00Step 2|r: Moves linearly from |cffffd200From|r to |cffffd200To|r using |cffffd200Move time|r (seconds), sizes from |cffffd200From scale|r to |cffffd200To scale|r, and fades from |cffffd200Fade in alpha|r to |cffffd200To alpha|r
 |cff00ff00Step 3|r: Cooldown displays.
 |cff00ff00Step 4|r: Cooldown is done. Fades from |cffffd200To alpha|r to 0 and shrinks to nothing over |cffffd200Fade out time|r (seconds)]=] ] = true
L["Attributes"] = true
L["Author"] = true
L["Backdrop alpha"] = true
L["Background color"] = true
L["Bar"] = true
L["Bar and rune spacing"] = true
L["Bar background"] = true
L["Bar border"] = true
L["Bar color"] = true
L["Bar fill method"] = true
L["Bar height"] = true
L["Bar orientation"] = true
L["Bars"] = true
L["Bar texture"] = true
L["Bar width"] = true
L["Base timer on rune"] = true
L["Behavior"] = true
L["Blood"] = true
L["Blood rune"] = true
L["Border color"] = true
L["Button Facade skins"] = true
L["|cff00CC00Version:|r"] = true
L["|cff99ff33Click|r to toggle the config"] = true
L["|cff99ff33Right-Click|r to toggle locking"] = true
L[ [=[|cffffd200Horizontal|r: %s
|cffffd200Vertical|r: %s]=] ] = true
L["Colors"] = true
L["Columns"] = true
L["Constant color"] = true
L["Credits"] = true
L["Custom order"] = true
L["Death"] = true
L["Death rune"] = true
L["Death to normal"] = true
L["Deplete"] = true
L["Determines if diseases are overlapping by taking the absolute value of the time differences and seeing if it's <= Overlap time"] = true
L["Diseases"] = true
L["Edge length"] = true
L["Enable"] = true
L["Enabled"] = true
L["Enable hundreths"] = true
L["Enable usable pulse"] = true
L["End alpha"] = true
L["End time"] = true
L["Extend distance"] = true
L["Fade in alpha"] = true
L["Fade in time"] = true
L["Fade out time"] = true
L["Fill alpha"] = true
L["Fills"] = true
L["Find updates at"] = true
L["Font"] = true
L["Font pulse down time"] = true
L["Font pulse size"] = true
L["Font pulse up time"] = true
L["Font size"] = true
L["French translations"] = true
L["From 10 seconds (the moment a rune is used) to End Time the alpha of the bar fades from Start Alpha to End Alpha"] = true
L["From 10 seconds (the moment a rune is used) to End Time the alpha of the icon fades from Start Alpha to End Alpha"] = true
L["From scale"] = true
L["Frost"] = true
L["Frost rune"] = true
L["General"] = true
L["German translations"] = true
L["Global scale"] = true
L["Gradual Fade In"] = true
L["Grow"] = true
L["Hide bars when ready"] = true
L["Hide Blizzard Rune Frame"] = true
L["Horizontal"] = true
L["How big the rune icon pulses. Keep this bigger than icon size"] = true
L["How long it takes to scale down to icon size after it pulses"] = true
L["How long it takes to scale up to icon pulse size"] = true
L["How many degrees the icon spins"] = true
L["Hundreths font size"] = true
L["Hundreths position"] = true
L["Hundreths position 2"] = true
L["Icon alpha"] = true
L["Icon pulse size"] = true
L["Icons"] = true
L["Icon scale down time"] = true
L["Icon scale up time"] = true
L["Icon size"] = true
L["If you are using the runes + runic power triangle layouts and adjust this scale the runes will not position correctly. Adjust the triangle edge length instead"] = true
L["Imprint alpha"] = true
L["In combat alpha"] = true
L["Individual"] = true
L[ [=[Input a list of rune ids separated by commas. It will only accept six numbers from 1 to 6. Each number must be |cffff0000different|r from the rest.

Rune ids are as followed:
   1 - Blood rune 1
   2 - Blood rune 2
   3 - Unholy rune 1
   4 - Unholy rune 2
   5 - Frost rune 1
   6 - Frost rune 2]=] ] = true
L["Inspiration, ideas, and testing"] = true
L["Invalid value for rune id. Expecting a number from 1 to 6 for each value"] = true
L["Invert"] = true
L["Layouts"] = true
L["Linear animation"] = true
L["Locked"] = true
L["Minimap"] = true
L["Move method"] = true
L["Move time"] = true
L["None"] = true
L["Normal positions"] = true
L["Normal to death"] = true
L["Not a valid table"] = true
L["On unusable"] = true
L["On usable"] = true
L["OOC Fading Enabled"] = true
L["Origin to out"] = true
L["Out combat alpha"] = true
L["Out of combat fading"] = true
L["Out to origin"] = true
L["Overlap time"] = true
L["Pipe"] = true
L["Preset order"] = true
L["Presets"] = true
L["Procs"] = true
L["Pulse"] = true
L["Pulse and spin"] = true
L["Ready"] = true
L["Release"] = true
L["Requires OmniCC to be installed. If this is checked and OmniCC is not installed there will be no timer. The default timer will display if this is unchecked"] = true
L["Reverse"] = true
L["Reversed Columns"] = true
L["Reversed positions"] = true
L["Reversed Six Pack"] = true
L["Reversed Stacking"] = true
L["Rune icons"] = true
L["Rune ids are not all different"] = true
L["Rune Order"] = true
L["Runes"] = true
L["Rune set"] = true
L["Rune spacing"] = true
L["Runic Power"] = true
L["Scale"] = true
L["Seconds position"] = true
L["Seconds position 2"] = true
L["Select proc"] = true
L["Set"] = true
L["Settings"] = true
L["Show imprint"] = true
L["Show spark"] = true
L["Simplified Chinese translations"] = true
L["Six Pack"] = true
L["Six values required"] = true
L["Skin"] = true
L["Sound on proc"] = true
L["Spacing"] = true
L["Spacing scale"] = true
L["Spin"] = true
L["Spin degree"] = true
L["Stacking"] = true
L["Start alpha"] = true
L["Starts all rune bars"] = true
L["Status bar alpha"] = true
L["Stop all procs if they're running"] = true
L["Table"] = true
L["Target nothing while testing. If you target something while testing the bar will clear."] = true
L["Test"] = true
L["Test all procs"] = true
L["Text"] = true
L["Text color"] = true
L["Text position x"] = true
L["Text position y"] = true
L["The bar's background color can be adjusted in the Colors tab -> Background color. Also note that for colored backgrounds, such as Blizzard Parchment, set the Background color to completely white or else the colors won't show up"] = true
L["The distance between each rune"] = true
L["The distance between each rune and bar"] = true
L["Timer color"] = true
L["To alpha"] = true
L["To scale"] = true
L["Traditional Chinese translations"] = true
L["Triangle"] = true
L["Triangle texture"] = true
L["Unholy"] = true
L["Unholy rune"] = true
L["Usable position"] = true
L["Usable position 2"] = true
L["Usable/Seconds text font size"] = true
L["Use custom order"] = true
L["Use fill colors"] = true
L["Use OmniCC timer"] = true
L["Vertical"] = true
L["X direction for horizontal layouts. Y direction for vertical layouts"] = true
L["Y direction for horizontal layouts. X direction for vertical layouts"] = true
L["2-digit offset"] = true
L["X adjustment right for hundreths, when seconds are 2 digits."] = true
L["X adjustment left, when seconds are 2 digits."] = true

if GetLocale() == "enUS" or GetLocale() == "enGB" then return end
end

local L = AL:NewLocale("Acherus", "deDE")
if L then
L["20 > RP >= 0"] = "20 > RP >= 0"
L["40 > RP >= 20"] = "40 > RP >= 20"
L["60 > RP >= 40"] = "60 > RP >= 40"
L["80 >= RP"] = "80 >= RP"
L["80 > RP >= 60"] = "80 > RP >= 60"
L["About"] = "Über"
L["Acherus"] = "Acherus"
L["Acherus by Kollektiv.& Lancestre. Type /ac or /acherus to open options"] = "Acherus von Kollektiv.& Lancestre. Gib /ac oder /acherus ein, um ins Optionsmen\\195\\188 zu gelangen"
L["Acherus is now locked"] = "Acherus ist jetzt fixiert"
L["Acherus is now unlocked"] = "Acherus ist jetzt frei gegeben"
L[ [=[A proc will start maximized and then minimize.
 |cff00ff00Step 1|r: Initial size is |cffffd200From scale|r. Fades in from 0 to |cffffd200Fade in alpha|r taking |cffffd200Fade in time|r (seconds) and is anchored to |cffffd200From|r.
 |cff00ff00Step 2|r: Moves linearly from |cffffd200From|r to |cffffd200To|r using |cffffd200Move time|r (seconds), sizes from |cffffd200From scale|r to |cffffd200To scale|r, and fades from |cffffd200Fade in alpha|r to |cffffd200To alpha|r
 |cff00ff00Step 3|r: Cooldown displays.
 |cff00ff00Step 4|r: Cooldown is done. Fades from |cffffd200To alpha|r to 0 and shrinks to nothing over |cffffd200Fade out time|r (seconds)]=] ] = [=[Das Procicon ist am Anfang maximiert und dann minimiert.
|cff00ff00schritt 1|r: Ausgangsgröße ist |cffffd200Ausgangsskalierung|r. Blendet von 0 bis |cffffd200Einblendalphawert|r ein, braucht |cffffd200Einblenddauer|r (Sekunden) und ist verankert mit |cffffd200Ausgangsort|r.]=]
L["Attributes"] = "Werte"
L["Author"] = "Autor"
L["Backdrop alpha"] = "Hintergrundtransparenz"
L["Background color"] = "Hintergrundfarbe"
L["Bar"] = "Leiste"
L["Bar and rune spacing"] = "Leiste und Runenabstand"
L["Bar background"] = "Hintergrund der Balken"
L["Bar border"] = "Rahmen der Balken"
L["Bar color"] = "Farbe der Balken"
L["Bar fill method"] = "Leistenfüllmethode"
L["Bar height"] = "Leistenhöhe"
-- L["Bar orientation"] = ""
L["Bars"] = "Leisten"
L["Bar texture"] = "Leistentextur"
L["Bar width"] = "Leistenbreite"
L["Base timer on rune"] = "Standard Runentimer"
L["Behavior"] = "Verhalten"
L["Blood"] = "Blut"
L["Blood rune"] = "Blutrune"
L["Border color"] = "Rahmenfarbe"
L["Button Facade skins"] = "Button Facade Aussehen"
L["|cff00CC00Version:|r"] = "|cff00CC00Version:|r"
L["|cff99ff33Click|r to toggle the config"] = "|cff99ff33Klicken|r um Optionen zu öffnen."
L["|cff99ff33Right-Click|r to toggle locking"] = "|cff99ff33Rechtsklicken|r um fixieren umzuschalten"
L[ [=[|cffffd200Horizontal|r: %s
|cffffd200Vertical|r: %s]=] ] = [=[|cffffd200Horizontal|r: %s
|cffffd200Vertikal|r: %s]=]
L["Colors"] = "Farben"
L["Columns"] = "Spalten"
L["Constant color"] = "Dauerfarbe"
L["Credits"] = "Mitwirkende"
L["Custom order"] = "Individuelle Reihnfolge"
L["Death"] = "Tod"
L["Death rune"] = "Todesrune"
L["Death to normal"] = "Tod zu Normal"
L["Deplete"] = "verschwinden"
L["Determines if diseases are overlapping by taking the absolute value of the time differences and seeing if it's <= Overlap time"] = "Stellt fest ob sich Krankheiten überlappen durch Heranziehen der Zeitdifferenz und Vergleich mit der Überlappzeit."
L["Diseases"] = "Krankheiten"
L["Edge length"] = "Kantenlänge"
L["Enable"] = "Aktivieren"
L["Enabled"] = "Aktivieren"
L["Enable hundreths"] = "Hundertstel aktivieren"
L["Enable usable pulse"] = "Aktiviere benutzbare Pulsierung"
L["End alpha"] = "Endalphawert"
L["End time"] = "Endzeit"
L["Extend distance"] = "Abstand vergr\\195\\182ßern"
L["Fade in alpha"] = "Einblendalphawert"
L["Fade in time"] = "Einblenddauer"
L["Fade out time"] = "Ausblenddauer"
L["Fill alpha"] = "Füllalphawert"
L["Fills"] = "Füllen"
L["Find updates at"] = "Updates gibt es auf"
L["Font"] = "Schriftart"
L["Font pulse down time"] = "Dauer der Schriftgrößenabnahme"
L["Font pulse size"] = "Schriftpulsiergröße"
L["Font pulse up time"] = "Dauer der Schriftgrößenzunahme"
L["Font size"] = "Schriftgröße"
L["French translations"] = "Französische Übersetzung"
L["From 10 seconds (the moment a rune is used) to End Time the alpha of the bar fades from Start Alpha to End Alpha"] = "Von 10 Sekunden (der Zeitpunkt an dem die Rune verbraucht wird) abwärts wechselt die Leiste vom Anfangsalphawert zum Endalphawert"
-- L["From 10 seconds (the moment a rune is used) to End Time the alpha of the icon fades from Start Alpha to End Alpha"] = ""
L["From scale"] = "Ausgangsgröße"
L["Frost"] = "Frost"
L["Frost rune"] = "Frostrune"
L["General"] = "Allgemein"
L["German translations"] = "Deutsche Übersetzung"
L["Global scale"] = "Allgemeine Skalierung"
L["Gradual Fade In"] = "Gradienteneinblendung"
L["Grow"] = "Wachsen"
L["Hide bars when ready"] = "Leisten verstecken wenn bereit."
L["Hide Blizzard Rune Frame"] = "Blizzard Runenfenster verstecken"
-- L["Horizontal"] = ""
L["How big the rune icon pulses. Keep this bigger than icon size"] = "Größe des pulsierenden Icons. Sollte größer sein als die normale Icongröße"
L["How long it takes to scale down to icon size after it pulses"] = "Dauer bis Icongröße nach dem Pulsieren wieder erreicht ist."
L["How long it takes to scale up to icon pulse size"] = "Dauer bist maximale pulsierende icongröße erreicht ist."
L["How many degrees the icon spins"] = "Wieviel Grad sich das Icon dreht"
L["Hundreths font size"] = "Hundertstel Schriftgröße"
L["Hundreths position"] = "Hundertstelposition"
L["Hundreths position 2"] = "Hundertstelposition 2"
L["Icon alpha"] = "Sichtbarkeit Symbol"
L["Icon pulse size"] = "pulsierende Icongröße"
L["Icons"] = "Icons"
L["Icon scale down time"] = "Abnahmedauer der Iconskalierung"
L["Icon scale up time"] = "Zunahmedauer der Iconskalierung"
L["Icon size"] = "Icongröße"
-- L["If you are using the runes + runic power triangle layouts and adjust this scale the runes will not position correctly. Adjust the triangle edge length instead"] = ""
-- L["Imprint alpha"] = ""
L["In combat alpha"] = "Im Kampf Alphawert"
L["Individual"] = "Individuell"
L[ [=[Input a list of rune ids separated by commas. It will only accept six numbers from 1 to 6. Each number must be |cffff0000different|r from the rest.

Rune ids are as followed:
   1 - Blood rune 1
   2 - Blood rune 2
   3 - Unholy rune 1
   4 - Unholy rune 2
   5 - Frost rune 1
   6 - Frost rune 2]=] ] = [=[Füge eine Liste aus Runen-IDs, getrennt durch Kommas, ein. Es werden nur Nummern von 1-6 akzeptiert. Jede nummer muss vom Rest |cffff0000verschieden|r sein.

Runen-IDs sind wie folgt :
1 - Blutrune 1
2 - Blutrune 2
3 - Unheilige Rune 1
4 - Unheilige Rune 2
5 - Frostrune 1
6 - Frostrune 2]=]
L["Inspiration, ideas, and testing"] = "Anregungen, Ideen und Testen"
L["Invalid value for rune id. Expecting a number from 1 to 6 for each value"] = "Ungültiger Runen-ID Wert. Akzeptiert werden nur Nummern von 1-6."
L["Invert"] = "Umgekehrt"
L["Layouts"] = "Layouts"
L["Linear animation"] = "Geradlinige Animation"
L["Locked"] = "Gesperrt"
L["Minimap"] = "Minimap"
L["Move method"] = "Bewegungsmethode"
L["Move time"] = "Bewegungsdauer"
L["None"] = "Keine"
L["Normal positions"] = "Standard Position"
L["Normal to death"] = "Normal zu Tod"
L["Not a valid table"] = "Keine gültige Tabelle."
L["On unusable"] = "Sobald unnutzbar"
L["On usable"] = "Sobald benutzbar"
L["OOC Fading Enabled"] = "Blenden ausserhalb des Kampfes aktiviert"
L["Origin to out"] = "Vom Ursprung bis Außen"
L["Out combat alpha"] = "Alphawert ausserhalb des Kampfes"
L["Out of combat fading"] = "Ausblenden ausserhalb des Kampfes"
L["Out to origin"] = "Von Außen zum Ursprung"
L["Overlap time"] = "Zeit \\195\\188berschneiden"
L["Pipe"] = "Leitung"
L["Preset order"] = "Vorgegebene Reihnfolge"
L["Presets"] = "Vorgegeben"
L["Procs"] = "Procs"
L["Pulse"] = "Pulsieren"
L["Pulse and spin"] = "Pulsierend und drehend"
L["Ready"] = "Bereit"
L["Release"] = "Freigeben"
L["Requires OmniCC to be installed. If this is checked and OmniCC is not installed there will be no timer. The default timer will display if this is unchecked"] = "OmniCC muss installiert sein. Wenn ausgewählt und OmniCC nicht installiert ist, werden keine Timer dargestellt. Der Standarttimer wird dargestellt wenn nicht aktiviert."
-- L["Reverse"] = ""
L["Reversed Columns"] = "Umgedrehte Spalten"
L["Reversed positions"] = "Umgekehrte Position"
L["Reversed Six Pack"] = "umgekehrtes Sechserpack"
L["Reversed Stacking"] = "Umgedreht Gestapelt"
L["Rune icons"] = "Runen Icon"
L["Rune ids are not all different"] = "Runen-IDs sind nicht alle verschieden."
L["Rune Order"] = "Runenreihnfolge"
L["Runes"] = "Runen"
L["Rune set"] = "Runenanordnung"
L["Rune spacing"] = "Runenabstand"
L["Runic Power"] = "Runenmacht"
L["Scale"] = "Ma\\195\\159stab"
L["Seconds position"] = "Sekundenposition"
L["Seconds position 2"] = "Sekundenposition 2"
L["Select proc"] = "Proc auswählen"
L["Set"] = "Zusammenstellung"
L["Settings"] = "Einstellungen"
L["Show imprint"] = "Zeige Aufdruck"
L["Show spark"] = "Zeige Funken"
L["Simplified Chinese translations"] = "Vereinfachte Chinesische Übersetzung"
L["Six Pack"] = "Sechserpack"
L["Six values required"] = "Sechs Werte benötigat"
L["Skin"] = "Aussehen"
L["Sound on proc"] = "Ton beim Proc"
L["Spacing"] = "Abstand"
L["Spacing scale"] = "Abstandsgröße"
L["Spin"] = "Drehung"
L["Spin degree"] = "Drehwinkel"
L["Stacking"] = "Gestapelt"
L["Start alpha"] = "Alphastartwert"
L["Starts all rune bars"] = "Startet alle Runenleisten"
L["Status bar alpha"] = "Alphawert der Statusleiste"
L["Stop all procs if they're running"] = "Stoppt alle Procs die am Laufen sind."
L["Table"] = "Tabelle"
L["Target nothing while testing. If you target something while testing the bar will clear."] = "Kein Ziel anw\\195\\164hlen beim testen. Wenn ein Zeil angew\\195\\164hlt wird, wird die Leiste gel\\195\\182scht"
L["Test"] = "Test"
L["Test all procs"] = "Alle Procs testen"
L["Text"] = "Text"
L["Text color"] = "Textfarbe"
L["Text position x"] = "Textposition X"
L["Text position y"] = "Textposition Y"
-- L["The bar's background color can be adjusted in the Colors tab -> Background color. Also note that for colored backgrounds, such as Blizzard Parchment, set the Background color to completely white or else the colors won't show up"] = ""
L["The distance between each rune"] = "Abstand zwischen den Runen"
L["The distance between each rune and bar"] = "Abstand zwischen jeder Rune und Leiste"
L["Timer color"] = "Timerfarbe"
L["To alpha"] = "Endalphawert"
L["To scale"] = "Endskalierung"
L["Traditional Chinese translations"] = "Traditionelle Chinesische Übersetzung"
L["Triangle"] = "Dreieck"
L["Triangle texture"] = "Dreiecktextur"
L["Unholy"] = "Unheilig"
L["Unholy rune"] = "Unheilige Rune"
L["Usable position"] = "Verwendbare Position"
L["Usable position 2"] = "Verwendbare Position 2"
L["Usable/Seconds text font size"] = "Benutzbare / Sekunden Schriftgröße"
L["Use custom order"] = "Eigene Reihenfolge verwenden"
L["Use fill colors"] = "Füllfarbe verwenden"
L["Use OmniCC timer"] = "OmniCC Timer benutzen"
-- L["Vertical"] = ""
L["X direction for horizontal layouts. Y direction for vertical layouts"] = "X Richtung für horizontales Layout. Y Richtung für vertikeles Layout"
L["Y direction for horizontal layouts. X direction for vertical layouts"] = "Y Richtung für horizontales Layout. X Richtung für vertikeles Layout"

return
end

local L = AL:NewLocale("Acherus", "esES")
if L then
-- L["20 > RP >= 0"] = ""
-- L["40 > RP >= 20"] = ""
-- L["60 > RP >= 40"] = ""
-- L["80 >= RP"] = ""
-- L["80 > RP >= 60"] = ""
-- L["About"] = ""
-- L["Acherus"] = ""
-- L["Acherus by Kollektiv.& Lancestre. Type /ac or /acherus to open options"] = ""
-- L["Acherus is now locked"] = ""
-- L["Acherus is now unlocked"] = ""
--[==[ L[ [=[A proc will start maximized and then minimize.
 |cff00ff00Step 1|r: Initial size is |cffffd200From scale|r. Fades in from 0 to |cffffd200Fade in alpha|r taking |cffffd200Fade in time|r (seconds) and is anchored to |cffffd200From|r.
 |cff00ff00Step 2|r: Moves linearly from |cffffd200From|r to |cffffd200To|r using |cffffd200Move time|r (seconds), sizes from |cffffd200From scale|r to |cffffd200To scale|r, and fades from |cffffd200Fade in alpha|r to |cffffd200To alpha|r
 |cff00ff00Step 3|r: Cooldown displays.
 |cff00ff00Step 4|r: Cooldown is done. Fades from |cffffd200To alpha|r to 0 and shrinks to nothing over |cffffd200Fade out time|r (seconds)]=] ] = "" ]==]
-- L["Attributes"] = ""
-- L["Author"] = ""
-- L["Backdrop alpha"] = ""
-- L["Background color"] = ""
-- L["Bar"] = ""
-- L["Bar and rune spacing"] = ""
-- L["Bar background"] = ""
-- L["Bar border"] = ""
-- L["Bar color"] = ""
-- L["Bar fill method"] = ""
-- L["Bar height"] = ""
-- L["Bar orientation"] = ""
-- L["Bars"] = ""
-- L["Bar texture"] = ""
-- L["Bar width"] = ""
-- L["Base timer on rune"] = ""
-- L["Behavior"] = ""
-- L["Blood"] = ""
-- L["Blood rune"] = ""
-- L["Border color"] = ""
-- L["Button Facade skins"] = ""
-- L["|cff00CC00Version:|r"] = ""
-- L["|cff99ff33Click|r to toggle the config"] = ""
-- L["|cff99ff33Right-Click|r to toggle locking"] = ""
--[==[ L[ [=[|cffffd200Horizontal|r: %s
|cffffd200Vertical|r: %s]=] ] = "" ]==]
-- L["Colors"] = ""
-- L["Columns"] = ""
-- L["Constant color"] = ""
-- L["Credits"] = ""
-- L["Custom order"] = ""
-- L["Death"] = ""
-- L["Death rune"] = ""
-- L["Death to normal"] = ""
-- L["Deplete"] = ""
-- L["Determines if diseases are overlapping by taking the absolute value of the time differences and seeing if it's <= Overlap time"] = ""
-- L["Diseases"] = ""
-- L["Edge length"] = ""
-- L["Enable"] = ""
-- L["Enabled"] = ""
-- L["Enable hundreths"] = ""
-- L["Enable usable pulse"] = ""
-- L["End alpha"] = ""
-- L["End time"] = ""
-- L["Extend distance"] = ""
-- L["Fade in alpha"] = ""
-- L["Fade in time"] = ""
-- L["Fade out time"] = ""
-- L["Fill alpha"] = ""
-- L["Fills"] = ""
-- L["Find updates at"] = ""
-- L["Font"] = ""
-- L["Font pulse down time"] = ""
-- L["Font pulse size"] = ""
-- L["Font pulse up time"] = ""
-- L["Font size"] = ""
-- L["French translations"] = ""
-- L["From 10 seconds (the moment a rune is used) to End Time the alpha of the bar fades from Start Alpha to End Alpha"] = ""
-- L["From 10 seconds (the moment a rune is used) to End Time the alpha of the icon fades from Start Alpha to End Alpha"] = ""
-- L["From scale"] = ""
-- L["Frost"] = ""
-- L["Frost rune"] = ""
-- L["General"] = ""
-- L["German translations"] = ""
-- L["Global scale"] = ""
-- L["Gradual Fade In"] = ""
-- L["Grow"] = ""
-- L["Hide bars when ready"] = ""
-- L["Hide Blizzard Rune Frame"] = ""
-- L["Horizontal"] = ""
-- L["How big the rune icon pulses. Keep this bigger than icon size"] = ""
-- L["How long it takes to scale down to icon size after it pulses"] = ""
-- L["How long it takes to scale up to icon pulse size"] = ""
-- L["How many degrees the icon spins"] = ""
-- L["Hundreths font size"] = ""
-- L["Hundreths position"] = ""
-- L["Hundreths position 2"] = ""
-- L["Icon alpha"] = ""
-- L["Icon pulse size"] = ""
-- L["Icons"] = ""
-- L["Icon scale down time"] = ""
-- L["Icon scale up time"] = ""
-- L["Icon size"] = ""
-- L["If you are using the runes + runic power triangle layouts and adjust this scale the runes will not position correctly. Adjust the triangle edge length instead"] = ""
-- L["Imprint alpha"] = ""
-- L["In combat alpha"] = ""
-- L["Individual"] = ""
--[==[ L[ [=[Input a list of rune ids separated by commas. It will only accept six numbers from 1 to 6. Each number must be |cffff0000different|r from the rest.

Rune ids are as followed:
   1 - Blood rune 1
   2 - Blood rune 2
   3 - Unholy rune 1
   4 - Unholy rune 2
   5 - Frost rune 1
   6 - Frost rune 2]=] ] = "" ]==]
-- L["Inspiration, ideas, and testing"] = ""
-- L["Invalid value for rune id. Expecting a number from 1 to 6 for each value"] = ""
-- L["Invert"] = ""
-- L["Layouts"] = ""
-- L["Linear animation"] = ""
-- L["Locked"] = ""
-- L["Minimap"] = ""
-- L["Move method"] = ""
-- L["Move time"] = ""
-- L["None"] = ""
-- L["Normal positions"] = ""
-- L["Normal to death"] = ""
-- L["Not a valid table"] = ""
-- L["On unusable"] = ""
-- L["On usable"] = ""
-- L["OOC Fading Enabled"] = ""
-- L["Origin to out"] = ""
-- L["Out combat alpha"] = ""
-- L["Out of combat fading"] = ""
-- L["Out to origin"] = ""
-- L["Overlap time"] = ""
-- L["Pipe"] = ""
-- L["Preset order"] = ""
-- L["Presets"] = ""
-- L["Procs"] = ""
-- L["Pulse"] = ""
-- L["Pulse and spin"] = ""
-- L["Ready"] = ""
-- L["Release"] = ""
-- L["Requires OmniCC to be installed. If this is checked and OmniCC is not installed there will be no timer. The default timer will display if this is unchecked"] = ""
-- L["Reverse"] = ""
-- L["Reversed Columns"] = ""
-- L["Reversed positions"] = ""
-- L["Reversed Six Pack"] = ""
-- L["Reversed Stacking"] = ""
-- L["Rune icons"] = ""
-- L["Rune ids are not all different"] = ""
-- L["Rune Order"] = ""
-- L["Runes"] = ""
-- L["Rune set"] = ""
-- L["Rune spacing"] = ""
-- L["Runic Power"] = ""
-- L["Scale"] = ""
-- L["Seconds position"] = ""
-- L["Seconds position 2"] = ""
-- L["Select proc"] = ""
-- L["Set"] = ""
-- L["Settings"] = ""
-- L["Show imprint"] = ""
-- L["Show spark"] = ""
-- L["Simplified Chinese translations"] = ""
-- L["Six Pack"] = ""
-- L["Six values required"] = ""
-- L["Skin"] = ""
-- L["Sound on proc"] = ""
-- L["Spacing"] = ""
-- L["Spacing scale"] = ""
-- L["Spin"] = ""
-- L["Spin degree"] = ""
-- L["Stacking"] = ""
-- L["Start alpha"] = ""
-- L["Starts all rune bars"] = ""
-- L["Status bar alpha"] = ""
-- L["Stop all procs if they're running"] = ""
-- L["Table"] = ""
-- L["Target nothing while testing. If you target something while testing the bar will clear."] = ""
-- L["Test"] = ""
-- L["Test all procs"] = ""
-- L["Text"] = ""
-- L["Text color"] = ""
-- L["Text position x"] = ""
-- L["Text position y"] = ""
-- L["The bar's background color can be adjusted in the Colors tab -> Background color. Also note that for colored backgrounds, such as Blizzard Parchment, set the Background color to completely white or else the colors won't show up"] = ""
-- L["The distance between each rune"] = ""
-- L["The distance between each rune and bar"] = ""
-- L["Timer color"] = ""
-- L["To alpha"] = ""
-- L["To scale"] = ""
-- L["Traditional Chinese translations"] = ""
-- L["Triangle"] = ""
-- L["Triangle texture"] = ""
-- L["Unholy"] = ""
-- L["Unholy rune"] = ""
-- L["Usable position"] = ""
-- L["Usable position 2"] = ""
-- L["Usable/Seconds text font size"] = ""
-- L["Use custom order"] = ""
-- L["Use fill colors"] = ""
-- L["Use OmniCC timer"] = ""
-- L["Vertical"] = ""
-- L["X direction for horizontal layouts. Y direction for vertical layouts"] = ""
-- L["Y direction for horizontal layouts. X direction for vertical layouts"] = ""

return
end

local L = AL:NewLocale("Acherus", "esMX")
if L then
-- L["20 > RP >= 0"] = ""
-- L["40 > RP >= 20"] = ""
-- L["60 > RP >= 40"] = ""
-- L["80 >= RP"] = ""
-- L["80 > RP >= 60"] = ""
-- L["About"] = ""
-- L["Acherus"] = ""
-- L["Acherus by Kollektiv.& Lancestre. Type /ac or /acherus to open options"] = ""
-- L["Acherus is now locked"] = ""
-- L["Acherus is now unlocked"] = ""
--[==[ L[ [=[A proc will start maximized and then minimize.
 |cff00ff00Step 1|r: Initial size is |cffffd200From scale|r. Fades in from 0 to |cffffd200Fade in alpha|r taking |cffffd200Fade in time|r (seconds) and is anchored to |cffffd200From|r.
 |cff00ff00Step 2|r: Moves linearly from |cffffd200From|r to |cffffd200To|r using |cffffd200Move time|r (seconds), sizes from |cffffd200From scale|r to |cffffd200To scale|r, and fades from |cffffd200Fade in alpha|r to |cffffd200To alpha|r
 |cff00ff00Step 3|r: Cooldown displays.
 |cff00ff00Step 4|r: Cooldown is done. Fades from |cffffd200To alpha|r to 0 and shrinks to nothing over |cffffd200Fade out time|r (seconds)]=] ] = "" ]==]
-- L["Attributes"] = ""
-- L["Author"] = ""
-- L["Backdrop alpha"] = ""
-- L["Background color"] = ""
-- L["Bar"] = ""
-- L["Bar and rune spacing"] = ""
-- L["Bar background"] = ""
-- L["Bar border"] = ""
-- L["Bar color"] = ""
-- L["Bar fill method"] = ""
-- L["Bar height"] = ""
-- L["Bar orientation"] = ""
-- L["Bars"] = ""
-- L["Bar texture"] = ""
-- L["Bar width"] = ""
-- L["Base timer on rune"] = ""
-- L["Behavior"] = ""
-- L["Blood"] = ""
-- L["Blood rune"] = ""
-- L["Border color"] = ""
-- L["Button Facade skins"] = ""
-- L["|cff00CC00Version:|r"] = ""
-- L["|cff99ff33Click|r to toggle the config"] = ""
-- L["|cff99ff33Right-Click|r to toggle locking"] = ""
--[==[ L[ [=[|cffffd200Horizontal|r: %s
|cffffd200Vertical|r: %s]=] ] = "" ]==]
-- L["Colors"] = ""
-- L["Columns"] = ""
-- L["Constant color"] = ""
-- L["Credits"] = ""
-- L["Custom order"] = ""
-- L["Death"] = ""
-- L["Death rune"] = ""
-- L["Death to normal"] = ""
-- L["Deplete"] = ""
-- L["Determines if diseases are overlapping by taking the absolute value of the time differences and seeing if it's <= Overlap time"] = ""
-- L["Diseases"] = ""
-- L["Edge length"] = ""
-- L["Enable"] = ""
-- L["Enabled"] = ""
-- L["Enable hundreths"] = ""
-- L["Enable usable pulse"] = ""
-- L["End alpha"] = ""
-- L["End time"] = ""
-- L["Extend distance"] = ""
-- L["Fade in alpha"] = ""
-- L["Fade in time"] = ""
-- L["Fade out time"] = ""
-- L["Fill alpha"] = ""
-- L["Fills"] = ""
-- L["Find updates at"] = ""
-- L["Font"] = ""
-- L["Font pulse down time"] = ""
-- L["Font pulse size"] = ""
-- L["Font pulse up time"] = ""
-- L["Font size"] = ""
-- L["French translations"] = ""
-- L["From 10 seconds (the moment a rune is used) to End Time the alpha of the bar fades from Start Alpha to End Alpha"] = ""
-- L["From 10 seconds (the moment a rune is used) to End Time the alpha of the icon fades from Start Alpha to End Alpha"] = ""
-- L["From scale"] = ""
-- L["Frost"] = ""
-- L["Frost rune"] = ""
-- L["General"] = ""
-- L["German translations"] = ""
-- L["Global scale"] = ""
-- L["Gradual Fade In"] = ""
-- L["Grow"] = ""
-- L["Hide bars when ready"] = ""
-- L["Hide Blizzard Rune Frame"] = ""
-- L["Horizontal"] = ""
-- L["How big the rune icon pulses. Keep this bigger than icon size"] = ""
-- L["How long it takes to scale down to icon size after it pulses"] = ""
-- L["How long it takes to scale up to icon pulse size"] = ""
-- L["How many degrees the icon spins"] = ""
-- L["Hundreths font size"] = ""
-- L["Hundreths position"] = ""
-- L["Hundreths position 2"] = ""
-- L["Icon alpha"] = ""
-- L["Icon pulse size"] = ""
-- L["Icons"] = ""
-- L["Icon scale down time"] = ""
-- L["Icon scale up time"] = ""
-- L["Icon size"] = ""
-- L["If you are using the runes + runic power triangle layouts and adjust this scale the runes will not position correctly. Adjust the triangle edge length instead"] = ""
-- L["Imprint alpha"] = ""
-- L["In combat alpha"] = ""
-- L["Individual"] = ""
--[==[ L[ [=[Input a list of rune ids separated by commas. It will only accept six numbers from 1 to 6. Each number must be |cffff0000different|r from the rest.

Rune ids are as followed:
   1 - Blood rune 1
   2 - Blood rune 2
   3 - Unholy rune 1
   4 - Unholy rune 2
   5 - Frost rune 1
   6 - Frost rune 2]=] ] = "" ]==]
-- L["Inspiration, ideas, and testing"] = ""
-- L["Invalid value for rune id. Expecting a number from 1 to 6 for each value"] = ""
-- L["Invert"] = ""
-- L["Layouts"] = ""
-- L["Linear animation"] = ""
-- L["Locked"] = ""
-- L["Minimap"] = ""
-- L["Move method"] = ""
-- L["Move time"] = ""
-- L["None"] = ""
-- L["Normal positions"] = ""
-- L["Normal to death"] = ""
-- L["Not a valid table"] = ""
-- L["On unusable"] = ""
-- L["On usable"] = ""
-- L["OOC Fading Enabled"] = ""
-- L["Origin to out"] = ""
-- L["Out combat alpha"] = ""
-- L["Out of combat fading"] = ""
-- L["Out to origin"] = ""
-- L["Overlap time"] = ""
-- L["Pipe"] = ""
-- L["Preset order"] = ""
-- L["Presets"] = ""
-- L["Procs"] = ""
-- L["Pulse"] = ""
-- L["Pulse and spin"] = ""
-- L["Ready"] = ""
-- L["Release"] = ""
-- L["Requires OmniCC to be installed. If this is checked and OmniCC is not installed there will be no timer. The default timer will display if this is unchecked"] = ""
-- L["Reverse"] = ""
-- L["Reversed Columns"] = ""
-- L["Reversed positions"] = ""
-- L["Reversed Six Pack"] = ""
-- L["Reversed Stacking"] = ""
-- L["Rune icons"] = ""
-- L["Rune ids are not all different"] = ""
-- L["Rune Order"] = ""
-- L["Runes"] = ""
-- L["Rune set"] = ""
-- L["Rune spacing"] = ""
-- L["Runic Power"] = ""
-- L["Scale"] = ""
-- L["Seconds position"] = ""
-- L["Seconds position 2"] = ""
-- L["Select proc"] = ""
-- L["Set"] = ""
-- L["Settings"] = ""
-- L["Show imprint"] = ""
-- L["Show spark"] = ""
-- L["Simplified Chinese translations"] = ""
-- L["Six Pack"] = ""
-- L["Six values required"] = ""
-- L["Skin"] = ""
-- L["Sound on proc"] = ""
-- L["Spacing"] = ""
-- L["Spacing scale"] = ""
-- L["Spin"] = ""
-- L["Spin degree"] = ""
-- L["Stacking"] = ""
-- L["Start alpha"] = ""
-- L["Starts all rune bars"] = ""
-- L["Status bar alpha"] = ""
-- L["Stop all procs if they're running"] = ""
-- L["Table"] = ""
-- L["Target nothing while testing. If you target something while testing the bar will clear."] = ""
-- L["Test"] = ""
-- L["Test all procs"] = ""
-- L["Text"] = ""
-- L["Text color"] = ""
-- L["Text position x"] = ""
-- L["Text position y"] = ""
-- L["The bar's background color can be adjusted in the Colors tab -> Background color. Also note that for colored backgrounds, such as Blizzard Parchment, set the Background color to completely white or else the colors won't show up"] = ""
-- L["The distance between each rune"] = ""
-- L["The distance between each rune and bar"] = ""
-- L["Timer color"] = ""
-- L["To alpha"] = ""
-- L["To scale"] = ""
-- L["Traditional Chinese translations"] = ""
-- L["Triangle"] = ""
-- L["Triangle texture"] = ""
-- L["Unholy"] = ""
-- L["Unholy rune"] = ""
-- L["Usable position"] = ""
-- L["Usable position 2"] = ""
-- L["Usable/Seconds text font size"] = ""
-- L["Use custom order"] = ""
-- L["Use fill colors"] = ""
-- L["Use OmniCC timer"] = ""
-- L["Vertical"] = ""
-- L["X direction for horizontal layouts. Y direction for vertical layouts"] = ""
-- L["Y direction for horizontal layouts. X direction for vertical layouts"] = ""

return
end

local L = AL:NewLocale("Acherus", "frFR")
if L then
L["20 > RP >= 0"] = "20 > RP >= 0"
L["40 > RP >= 20"] = "Copy  \00940 > RP >= 20"
L["60 > RP >= 40"] = "Copy  \00960 > RP >= 40"
L["80 >= RP"] = "80 >= RP"
L["80 > RP >= 60"] = "80 > RP >= 60"
L["About"] = "A Propos"
L["Acherus"] = "Acherus"
L["Acherus by Kollektiv.& Lancestre. Type /ac or /acherus to open options"] = "Acherus par Kollektiv"
L["Acherus is now locked"] = "Acherus est maintenant verrouillé."
L["Acherus is now unlocked"] = "Acherus est maintenant dévérouillé."
--[==[ L[ [=[A proc will start maximized and then minimize.
 |cff00ff00Step 1|r: Initial size is |cffffd200From scale|r. Fades in from 0 to |cffffd200Fade in alpha|r taking |cffffd200Fade in time|r (seconds) and is anchored to |cffffd200From|r.
 |cff00ff00Step 2|r: Moves linearly from |cffffd200From|r to |cffffd200To|r using |cffffd200Move time|r (seconds), sizes from |cffffd200From scale|r to |cffffd200To scale|r, and fades from |cffffd200Fade in alpha|r to |cffffd200To alpha|r
 |cff00ff00Step 3|r: Cooldown displays.
 |cff00ff00Step 4|r: Cooldown is done. Fades from |cffffd200To alpha|r to 0 and shrinks to nothing over |cffffd200Fade out time|r (seconds)]=] ] = "" ]==]
L["Attributes"] = "Attributs"
L["Author"] = "Auteur"
-- L["Backdrop alpha"] = ""
L["Background color"] = "Couleur d'arrière-plan"
L["Bar"] = "Barre"
L["Bar and rune spacing"] = "Barres et espace runique"
L["Bar background"] = "Arrière-plan des barres."
L["Bar border"] = "Bordure des barres"
L["Bar color"] = "Couleur des barres"
L["Bar fill method"] = "Methode de remplissage des barres"
L["Bar height"] = "Hauteur de la barre"
-- L["Bar orientation"] = ""
L["Bars"] = "Barres"
L["Bar texture"] = "Texture de la barre"
L["Bar width"] = "Largeur de la barre"
L["Base timer on rune"] = "Timer de base des runes"
L["Behavior"] = "Comportement"
L["Blood"] = "Sang"
L["Blood rune"] = "Rune de sang"
L["Border color"] = "Couleur de bordure"
-- L["Button Facade skins"] = ""
-- L["|cff00CC00Version:|r"] = ""
-- L["|cff99ff33Click|r to toggle the config"] = ""
-- L["|cff99ff33Right-Click|r to toggle locking"] = ""
--[==[ L[ [=[|cffffd200Horizontal|r: %s
|cffffd200Vertical|r: %s]=] ] = "" ]==]
L["Colors"] = "Couleurs"
L["Columns"] = "Colonnes"
L["Constant color"] = "couleur constante"
-- L["Credits"] = ""
L["Custom order"] = "Ordre personnalisé"
L["Death"] = "Mort"
L["Death rune"] = "Rune de mort"
-- L["Death to normal"] = ""
-- L["Deplete"] = ""
-- L["Determines if diseases are overlapping by taking the absolute value of the time differences and seeing if it's <= Overlap time"] = ""
L["Diseases"] = "Maladies"
-- L["Edge length"] = ""
L["Enable"] = "Activer"
L["Enabled"] = "Active"
L["Enable hundreths"] = "Activer les centaines."
-- L["Enable usable pulse"] = ""
-- L["End alpha"] = ""
-- L["End time"] = ""
L["Extend distance"] = "Etendre la distance"
-- L["Fade in alpha"] = ""
-- L["Fade in time"] = ""
-- L["Fade out time"] = ""
-- L["Fill alpha"] = ""
-- L["Fills"] = ""
-- L["Find updates at"] = ""
L["Font"] = "Police"
-- L["Font pulse down time"] = ""
-- L["Font pulse size"] = ""
-- L["Font pulse up time"] = ""
L["Font size"] = "Taille Police"
L["French translations"] = "Traductions française."
-- L["From 10 seconds (the moment a rune is used) to End Time the alpha of the bar fades from Start Alpha to End Alpha"] = ""
-- L["From 10 seconds (the moment a rune is used) to End Time the alpha of the icon fades from Start Alpha to End Alpha"] = ""
-- L["From scale"] = ""
L["Frost"] = "Givre"
L["Frost rune"] = "Rune de givre"
L["General"] = "Generale"
L["German translations"] = "Traductions Allemande."
L["Global scale"] = "Taille globale"
-- L["Gradual Fade In"] = ""
-- L["Grow"] = ""
-- L["Hide bars when ready"] = ""
-- L["Hide Blizzard Rune Frame"] = ""
-- L["Horizontal"] = ""
-- L["How big the rune icon pulses. Keep this bigger than icon size"] = ""
-- L["How long it takes to scale down to icon size after it pulses"] = ""
-- L["How long it takes to scale up to icon pulse size"] = ""
-- L["How many degrees the icon spins"] = ""
-- L["Hundreths font size"] = ""
-- L["Hundreths position"] = ""
-- L["Hundreths position 2"] = ""
-- L["Icon alpha"] = ""
-- L["Icon pulse size"] = ""
-- L["Icons"] = ""
-- L["Icon scale down time"] = ""
-- L["Icon scale up time"] = ""
-- L["Icon size"] = ""
-- L["If you are using the runes + runic power triangle layouts and adjust this scale the runes will not position correctly. Adjust the triangle edge length instead"] = ""
-- L["Imprint alpha"] = ""
-- L["In combat alpha"] = ""
-- L["Individual"] = ""
--[==[ L[ [=[Input a list of rune ids separated by commas. It will only accept six numbers from 1 to 6. Each number must be |cffff0000different|r from the rest.

Rune ids are as followed:
   1 - Blood rune 1
   2 - Blood rune 2
   3 - Unholy rune 1
   4 - Unholy rune 2
   5 - Frost rune 1
   6 - Frost rune 2]=] ] = "" ]==]
-- L["Inspiration, ideas, and testing"] = ""
-- L["Invalid value for rune id. Expecting a number from 1 to 6 for each value"] = ""
-- L["Invert"] = ""
-- L["Layouts"] = ""
-- L["Linear animation"] = ""
-- L["Locked"] = ""
-- L["Minimap"] = ""
-- L["Move method"] = ""
-- L["Move time"] = ""
-- L["None"] = ""
-- L["Normal positions"] = ""
-- L["Normal to death"] = ""
-- L["Not a valid table"] = ""
-- L["On unusable"] = ""
-- L["On usable"] = ""
-- L["OOC Fading Enabled"] = ""
-- L["Origin to out"] = ""
-- L["Out combat alpha"] = ""
-- L["Out of combat fading"] = ""
-- L["Out to origin"] = ""
-- L["Overlap time"] = ""
-- L["Pipe"] = ""
-- L["Preset order"] = ""
-- L["Presets"] = ""
-- L["Procs"] = ""
-- L["Pulse"] = ""
-- L["Pulse and spin"] = ""
-- L["Ready"] = ""
-- L["Release"] = ""
-- L["Requires OmniCC to be installed. If this is checked and OmniCC is not installed there will be no timer. The default timer will display if this is unchecked"] = ""
-- L["Reverse"] = ""
-- L["Reversed Columns"] = ""
-- L["Reversed positions"] = ""
-- L["Reversed Six Pack"] = ""
-- L["Reversed Stacking"] = ""
-- L["Rune icons"] = ""
-- L["Rune ids are not all different"] = ""
L["Rune Order"] = "Ordre des runes"
L["Runes"] = "Runes"
-- L["Rune set"] = ""
-- L["Rune spacing"] = ""
-- L["Runic Power"] = ""
-- L["Scale"] = ""
-- L["Seconds position"] = ""
-- L["Seconds position 2"] = ""
-- L["Select proc"] = ""
-- L["Set"] = ""
-- L["Settings"] = ""
-- L["Show imprint"] = ""
-- L["Show spark"] = ""
-- L["Simplified Chinese translations"] = ""
-- L["Six Pack"] = ""
-- L["Six values required"] = ""
-- L["Skin"] = ""
-- L["Sound on proc"] = ""
-- L["Spacing"] = ""
-- L["Spacing scale"] = ""
-- L["Spin"] = ""
-- L["Spin degree"] = ""
-- L["Stacking"] = ""
-- L["Start alpha"] = ""
L["Starts all rune bars"] = "Lancement des barres runiques"
-- L["Status bar alpha"] = ""
-- L["Stop all procs if they're running"] = ""
L["Table"] = "Table"
-- L["Target nothing while testing. If you target something while testing the bar will clear."] = ""
L["Test"] = "Test"
-- L["Test all procs"] = ""
L["Text"] = "Texte"
-- L["Text color"] = ""
L["Text position x"] = "Position du texte x"
L["Text position y"] = "Position du texte y"
-- L["The bar's background color can be adjusted in the Colors tab -> Background color. Also note that for colored backgrounds, such as Blizzard Parchment, set the Background color to completely white or else the colors won't show up"] = ""
L["The distance between each rune"] = "Distance entre chaque rune"
L["The distance between each rune and bar"] = "Distance entre chaque rune et barre."
L["Timer color"] = "Couleur du timer"
-- L["To alpha"] = ""
-- L["To scale"] = ""
-- L["Traditional Chinese translations"] = ""
L["Triangle"] = "Triangle"
-- L["Triangle texture"] = ""
L["Unholy"] = "Impie"
L["Unholy rune"] = "Rune impie"
L["Usable position"] = "Position utilisable"
L["Usable position 2"] = "Position utilisable 2"
-- L["Usable/Seconds text font size"] = ""
-- L["Use custom order"] = ""
-- L["Use fill colors"] = ""
L["Use OmniCC timer"] = "Utilise timer OmniCC"
-- L["Vertical"] = ""
-- L["X direction for horizontal layouts. Y direction for vertical layouts"] = ""
-- L["Y direction for horizontal layouts. X direction for vertical layouts"] = ""

return
end

local L = AL:NewLocale("Acherus", "koKR")
if L then
-- L["20 > RP >= 0"] = ""
-- L["40 > RP >= 20"] = ""
-- L["60 > RP >= 40"] = ""
-- L["80 >= RP"] = ""
-- L["80 > RP >= 60"] = ""
-- L["About"] = ""
-- L["Acherus"] = ""
-- L["Acherus by Kollektiv.& Lancestre. Type /ac or /acherus to open options"] = ""
-- L["Acherus is now locked"] = ""
-- L["Acherus is now unlocked"] = ""
--[==[ L[ [=[A proc will start maximized and then minimize.
 |cff00ff00Step 1|r: Initial size is |cffffd200From scale|r. Fades in from 0 to |cffffd200Fade in alpha|r taking |cffffd200Fade in time|r (seconds) and is anchored to |cffffd200From|r.
 |cff00ff00Step 2|r: Moves linearly from |cffffd200From|r to |cffffd200To|r using |cffffd200Move time|r (seconds), sizes from |cffffd200From scale|r to |cffffd200To scale|r, and fades from |cffffd200Fade in alpha|r to |cffffd200To alpha|r
 |cff00ff00Step 3|r: Cooldown displays.
 |cff00ff00Step 4|r: Cooldown is done. Fades from |cffffd200To alpha|r to 0 and shrinks to nothing over |cffffd200Fade out time|r (seconds)]=] ] = "" ]==]
-- L["Attributes"] = ""
-- L["Author"] = ""
-- L["Backdrop alpha"] = ""
-- L["Background color"] = ""
-- L["Bar"] = ""
-- L["Bar and rune spacing"] = ""
-- L["Bar background"] = ""
-- L["Bar border"] = ""
-- L["Bar color"] = ""
-- L["Bar fill method"] = ""
-- L["Bar height"] = ""
-- L["Bar orientation"] = ""
-- L["Bars"] = ""
-- L["Bar texture"] = ""
-- L["Bar width"] = ""
-- L["Base timer on rune"] = ""
-- L["Behavior"] = ""
-- L["Blood"] = ""
-- L["Blood rune"] = ""
-- L["Border color"] = ""
-- L["Button Facade skins"] = ""
-- L["|cff00CC00Version:|r"] = ""
-- L["|cff99ff33Click|r to toggle the config"] = ""
-- L["|cff99ff33Right-Click|r to toggle locking"] = ""
--[==[ L[ [=[|cffffd200Horizontal|r: %s
|cffffd200Vertical|r: %s]=] ] = "" ]==]
-- L["Colors"] = ""
-- L["Columns"] = ""
-- L["Constant color"] = ""
-- L["Credits"] = ""
-- L["Custom order"] = ""
-- L["Death"] = ""
-- L["Death rune"] = ""
-- L["Death to normal"] = ""
-- L["Deplete"] = ""
-- L["Determines if diseases are overlapping by taking the absolute value of the time differences and seeing if it's <= Overlap time"] = ""
-- L["Diseases"] = ""
-- L["Edge length"] = ""
-- L["Enable"] = ""
-- L["Enabled"] = ""
-- L["Enable hundreths"] = ""
-- L["Enable usable pulse"] = ""
-- L["End alpha"] = ""
-- L["End time"] = ""
-- L["Extend distance"] = ""
-- L["Fade in alpha"] = ""
-- L["Fade in time"] = ""
-- L["Fade out time"] = ""
-- L["Fill alpha"] = ""
-- L["Fills"] = ""
-- L["Find updates at"] = ""
-- L["Font"] = ""
-- L["Font pulse down time"] = ""
-- L["Font pulse size"] = ""
-- L["Font pulse up time"] = ""
-- L["Font size"] = ""
-- L["French translations"] = ""
-- L["From 10 seconds (the moment a rune is used) to End Time the alpha of the bar fades from Start Alpha to End Alpha"] = ""
-- L["From 10 seconds (the moment a rune is used) to End Time the alpha of the icon fades from Start Alpha to End Alpha"] = ""
-- L["From scale"] = ""
-- L["Frost"] = ""
-- L["Frost rune"] = ""
-- L["General"] = ""
-- L["German translations"] = ""
-- L["Global scale"] = ""
-- L["Gradual Fade In"] = ""
-- L["Grow"] = ""
-- L["Hide bars when ready"] = ""
-- L["Hide Blizzard Rune Frame"] = ""
-- L["Horizontal"] = ""
-- L["How big the rune icon pulses. Keep this bigger than icon size"] = ""
-- L["How long it takes to scale down to icon size after it pulses"] = ""
-- L["How long it takes to scale up to icon pulse size"] = ""
-- L["How many degrees the icon spins"] = ""
-- L["Hundreths font size"] = ""
-- L["Hundreths position"] = ""
-- L["Hundreths position 2"] = ""
-- L["Icon alpha"] = ""
-- L["Icon pulse size"] = ""
-- L["Icons"] = ""
-- L["Icon scale down time"] = ""
-- L["Icon scale up time"] = ""
-- L["Icon size"] = ""
-- L["If you are using the runes + runic power triangle layouts and adjust this scale the runes will not position correctly. Adjust the triangle edge length instead"] = ""
-- L["Imprint alpha"] = ""
-- L["In combat alpha"] = ""
-- L["Individual"] = ""
--[==[ L[ [=[Input a list of rune ids separated by commas. It will only accept six numbers from 1 to 6. Each number must be |cffff0000different|r from the rest.

Rune ids are as followed:
   1 - Blood rune 1
   2 - Blood rune 2
   3 - Unholy rune 1
   4 - Unholy rune 2
   5 - Frost rune 1
   6 - Frost rune 2]=] ] = "" ]==]
-- L["Inspiration, ideas, and testing"] = ""
-- L["Invalid value for rune id. Expecting a number from 1 to 6 for each value"] = ""
-- L["Invert"] = ""
-- L["Layouts"] = ""
-- L["Linear animation"] = ""
-- L["Locked"] = ""
-- L["Minimap"] = ""
-- L["Move method"] = ""
-- L["Move time"] = ""
-- L["None"] = ""
-- L["Normal positions"] = ""
-- L["Normal to death"] = ""
-- L["Not a valid table"] = ""
-- L["On unusable"] = ""
-- L["On usable"] = ""
-- L["OOC Fading Enabled"] = ""
-- L["Origin to out"] = ""
-- L["Out combat alpha"] = ""
-- L["Out of combat fading"] = ""
-- L["Out to origin"] = ""
-- L["Overlap time"] = ""
-- L["Pipe"] = ""
-- L["Preset order"] = ""
-- L["Presets"] = ""
-- L["Procs"] = ""
-- L["Pulse"] = ""
-- L["Pulse and spin"] = ""
-- L["Ready"] = ""
-- L["Release"] = ""
-- L["Requires OmniCC to be installed. If this is checked and OmniCC is not installed there will be no timer. The default timer will display if this is unchecked"] = ""
-- L["Reverse"] = ""
-- L["Reversed Columns"] = ""
-- L["Reversed positions"] = ""
-- L["Reversed Six Pack"] = ""
-- L["Reversed Stacking"] = ""
-- L["Rune icons"] = ""
-- L["Rune ids are not all different"] = ""
-- L["Rune Order"] = ""
-- L["Runes"] = ""
-- L["Rune set"] = ""
-- L["Rune spacing"] = ""
-- L["Runic Power"] = ""
-- L["Scale"] = ""
-- L["Seconds position"] = ""
-- L["Seconds position 2"] = ""
-- L["Select proc"] = ""
-- L["Set"] = ""
-- L["Settings"] = ""
-- L["Show imprint"] = ""
-- L["Show spark"] = ""
-- L["Simplified Chinese translations"] = ""
-- L["Six Pack"] = ""
-- L["Six values required"] = ""
-- L["Skin"] = ""
-- L["Sound on proc"] = ""
-- L["Spacing"] = ""
-- L["Spacing scale"] = ""
-- L["Spin"] = ""
-- L["Spin degree"] = ""
-- L["Stacking"] = ""
-- L["Start alpha"] = ""
-- L["Starts all rune bars"] = ""
-- L["Status bar alpha"] = ""
-- L["Stop all procs if they're running"] = ""
-- L["Table"] = ""
-- L["Target nothing while testing. If you target something while testing the bar will clear."] = ""
-- L["Test"] = ""
-- L["Test all procs"] = ""
-- L["Text"] = ""
-- L["Text color"] = ""
-- L["Text position x"] = ""
-- L["Text position y"] = ""
-- L["The bar's background color can be adjusted in the Colors tab -> Background color. Also note that for colored backgrounds, such as Blizzard Parchment, set the Background color to completely white or else the colors won't show up"] = ""
-- L["The distance between each rune"] = ""
-- L["The distance between each rune and bar"] = ""
-- L["Timer color"] = ""
-- L["To alpha"] = ""
-- L["To scale"] = ""
-- L["Traditional Chinese translations"] = ""
-- L["Triangle"] = ""
-- L["Triangle texture"] = ""
-- L["Unholy"] = ""
-- L["Unholy rune"] = ""
-- L["Usable position"] = ""
-- L["Usable position 2"] = ""
-- L["Usable/Seconds text font size"] = ""
-- L["Use custom order"] = ""
-- L["Use fill colors"] = ""
-- L["Use OmniCC timer"] = ""
-- L["Vertical"] = ""
-- L["X direction for horizontal layouts. Y direction for vertical layouts"] = ""
-- L["Y direction for horizontal layouts. X direction for vertical layouts"] = ""

return
end

local L = AL:NewLocale("Acherus", "ruRU")
if L then
-- L["20 > RP >= 0"] = ""
-- L["40 > RP >= 20"] = ""
-- L["60 > RP >= 40"] = ""
-- L["80 >= RP"] = ""
-- L["80 > RP >= 60"] = ""
-- L["About"] = ""
-- L["Acherus"] = ""
-- L["Acherus by Kollektiv.& Lancestre. Type /ac or /acherus to open options"] = ""
-- L["Acherus is now locked"] = ""
-- L["Acherus is now unlocked"] = ""
--[==[ L[ [=[A proc will start maximized and then minimize.
 |cff00ff00Step 1|r: Initial size is |cffffd200From scale|r. Fades in from 0 to |cffffd200Fade in alpha|r taking |cffffd200Fade in time|r (seconds) and is anchored to |cffffd200From|r.
 |cff00ff00Step 2|r: Moves linearly from |cffffd200From|r to |cffffd200To|r using |cffffd200Move time|r (seconds), sizes from |cffffd200From scale|r to |cffffd200To scale|r, and fades from |cffffd200Fade in alpha|r to |cffffd200To alpha|r
 |cff00ff00Step 3|r: Cooldown displays.
 |cff00ff00Step 4|r: Cooldown is done. Fades from |cffffd200To alpha|r to 0 and shrinks to nothing over |cffffd200Fade out time|r (seconds)]=] ] = "" ]==]
-- L["Attributes"] = ""
-- L["Author"] = ""
-- L["Backdrop alpha"] = ""
-- L["Background color"] = ""
-- L["Bar"] = ""
-- L["Bar and rune spacing"] = ""
-- L["Bar background"] = ""
-- L["Bar border"] = ""
-- L["Bar color"] = ""
-- L["Bar fill method"] = ""
-- L["Bar height"] = ""
-- L["Bar orientation"] = ""
-- L["Bars"] = ""
-- L["Bar texture"] = ""
-- L["Bar width"] = ""
-- L["Base timer on rune"] = ""
-- L["Behavior"] = ""
-- L["Blood"] = ""
-- L["Blood rune"] = ""
-- L["Border color"] = ""
-- L["Button Facade skins"] = ""
-- L["|cff00CC00Version:|r"] = ""
-- L["|cff99ff33Click|r to toggle the config"] = ""
-- L["|cff99ff33Right-Click|r to toggle locking"] = ""
--[==[ L[ [=[|cffffd200Horizontal|r: %s
|cffffd200Vertical|r: %s]=] ] = "" ]==]
-- L["Colors"] = ""
-- L["Columns"] = ""
-- L["Constant color"] = ""
-- L["Credits"] = ""
-- L["Custom order"] = ""
-- L["Death"] = ""
-- L["Death rune"] = ""
-- L["Death to normal"] = ""
-- L["Deplete"] = ""
-- L["Determines if diseases are overlapping by taking the absolute value of the time differences and seeing if it's <= Overlap time"] = ""
-- L["Diseases"] = ""
-- L["Edge length"] = ""
-- L["Enable"] = ""
-- L["Enabled"] = ""
-- L["Enable hundreths"] = ""
-- L["Enable usable pulse"] = ""
-- L["End alpha"] = ""
-- L["End time"] = ""
-- L["Extend distance"] = ""
-- L["Fade in alpha"] = ""
-- L["Fade in time"] = ""
-- L["Fade out time"] = ""
-- L["Fill alpha"] = ""
-- L["Fills"] = ""
-- L["Find updates at"] = ""
-- L["Font"] = ""
-- L["Font pulse down time"] = ""
-- L["Font pulse size"] = ""
-- L["Font pulse up time"] = ""
-- L["Font size"] = ""
-- L["French translations"] = ""
-- L["From 10 seconds (the moment a rune is used) to End Time the alpha of the bar fades from Start Alpha to End Alpha"] = ""
-- L["From 10 seconds (the moment a rune is used) to End Time the alpha of the icon fades from Start Alpha to End Alpha"] = ""
-- L["From scale"] = ""
-- L["Frost"] = ""
-- L["Frost rune"] = ""
-- L["General"] = ""
-- L["German translations"] = ""
-- L["Global scale"] = ""
-- L["Gradual Fade In"] = ""
-- L["Grow"] = ""
-- L["Hide bars when ready"] = ""
-- L["Hide Blizzard Rune Frame"] = ""
-- L["Horizontal"] = ""
-- L["How big the rune icon pulses. Keep this bigger than icon size"] = ""
-- L["How long it takes to scale down to icon size after it pulses"] = ""
-- L["How long it takes to scale up to icon pulse size"] = ""
-- L["How many degrees the icon spins"] = ""
-- L["Hundreths font size"] = ""
-- L["Hundreths position"] = ""
-- L["Hundreths position 2"] = ""
-- L["Icon alpha"] = ""
-- L["Icon pulse size"] = ""
-- L["Icons"] = ""
-- L["Icon scale down time"] = ""
-- L["Icon scale up time"] = ""
-- L["Icon size"] = ""
-- L["If you are using the runes + runic power triangle layouts and adjust this scale the runes will not position correctly. Adjust the triangle edge length instead"] = ""
-- L["Imprint alpha"] = ""
-- L["In combat alpha"] = ""
-- L["Individual"] = ""
--[==[ L[ [=[Input a list of rune ids separated by commas. It will only accept six numbers from 1 to 6. Each number must be |cffff0000different|r from the rest.

Rune ids are as followed:
   1 - Blood rune 1
   2 - Blood rune 2
   3 - Unholy rune 1
   4 - Unholy rune 2
   5 - Frost rune 1
   6 - Frost rune 2]=] ] = "" ]==]
-- L["Inspiration, ideas, and testing"] = ""
-- L["Invalid value for rune id. Expecting a number from 1 to 6 for each value"] = ""
-- L["Invert"] = ""
-- L["Layouts"] = ""
-- L["Linear animation"] = ""
-- L["Locked"] = ""
-- L["Minimap"] = ""
-- L["Move method"] = ""
-- L["Move time"] = ""
-- L["None"] = ""
-- L["Normal positions"] = ""
-- L["Normal to death"] = ""
-- L["Not a valid table"] = ""
-- L["On unusable"] = ""
-- L["On usable"] = ""
-- L["OOC Fading Enabled"] = ""
-- L["Origin to out"] = ""
-- L["Out combat alpha"] = ""
-- L["Out of combat fading"] = ""
-- L["Out to origin"] = ""
-- L["Overlap time"] = ""
-- L["Pipe"] = ""
-- L["Preset order"] = ""
-- L["Presets"] = ""
-- L["Procs"] = ""
-- L["Pulse"] = ""
-- L["Pulse and spin"] = ""
-- L["Ready"] = ""
-- L["Release"] = ""
-- L["Requires OmniCC to be installed. If this is checked and OmniCC is not installed there will be no timer. The default timer will display if this is unchecked"] = ""
-- L["Reverse"] = ""
-- L["Reversed Columns"] = ""
-- L["Reversed positions"] = ""
-- L["Reversed Six Pack"] = ""
-- L["Reversed Stacking"] = ""
-- L["Rune icons"] = ""
-- L["Rune ids are not all different"] = ""
-- L["Rune Order"] = ""
-- L["Runes"] = ""
-- L["Rune set"] = ""
-- L["Rune spacing"] = ""
-- L["Runic Power"] = ""
-- L["Scale"] = ""
-- L["Seconds position"] = ""
-- L["Seconds position 2"] = ""
-- L["Select proc"] = ""
-- L["Set"] = ""
-- L["Settings"] = ""
-- L["Show imprint"] = ""
-- L["Show spark"] = ""
-- L["Simplified Chinese translations"] = ""
-- L["Six Pack"] = ""
-- L["Six values required"] = ""
-- L["Skin"] = ""
-- L["Sound on proc"] = ""
-- L["Spacing"] = ""
-- L["Spacing scale"] = ""
-- L["Spin"] = ""
-- L["Spin degree"] = ""
-- L["Stacking"] = ""
-- L["Start alpha"] = ""
-- L["Starts all rune bars"] = ""
-- L["Status bar alpha"] = ""
-- L["Stop all procs if they're running"] = ""
-- L["Table"] = ""
-- L["Target nothing while testing. If you target something while testing the bar will clear."] = ""
-- L["Test"] = ""
-- L["Test all procs"] = ""
-- L["Text"] = ""
-- L["Text color"] = ""
-- L["Text position x"] = ""
-- L["Text position y"] = ""
-- L["The bar's background color can be adjusted in the Colors tab -> Background color. Also note that for colored backgrounds, such as Blizzard Parchment, set the Background color to completely white or else the colors won't show up"] = ""
-- L["The distance between each rune"] = ""
-- L["The distance between each rune and bar"] = ""
-- L["Timer color"] = ""
-- L["To alpha"] = ""
-- L["To scale"] = ""
-- L["Traditional Chinese translations"] = ""
-- L["Triangle"] = ""
-- L["Triangle texture"] = ""
-- L["Unholy"] = ""
-- L["Unholy rune"] = ""
-- L["Usable position"] = ""
-- L["Usable position 2"] = ""
-- L["Usable/Seconds text font size"] = ""
-- L["Use custom order"] = ""
-- L["Use fill colors"] = ""
-- L["Use OmniCC timer"] = ""
-- L["Vertical"] = ""
-- L["X direction for horizontal layouts. Y direction for vertical layouts"] = ""
-- L["Y direction for horizontal layouts. X direction for vertical layouts"] = ""

return
end

local L = AL:NewLocale("Acherus", "zhCN")
if L then
L["20 > RP >= 0"] = "20>当前符文能量>=0"
L["40 > RP >= 20"] = "40>当前符文能量>=0"
L["60 > RP >= 40"] = "60>当前符文能量>=40"
L["80 >= RP"] = "80>=当前符文能量 i think it should be rp>=80?"
L["80 > RP >= 60"] = "80>当前符文能量>=60"
L["About"] = "关于"
L["Acherus"] = "Acherus符文监控插件"
L["Acherus by Kollektiv.& Lancestre. Type /ac or /acherus to open options"] = "Acherus符文监控插件by Kollektiv.& Lancestre. 输入 /ac 或 /acherus 进行配置"
L["Acherus is now locked"] = "Acherus符文监控插件的所有框体已被锁定."
L["Acherus is now unlocked"] = "Acherus符文监控插件的所有框体已被解锁."
L[ [=[A proc will start maximized and then minimize.
 |cff00ff00Step 1|r: Initial size is |cffffd200From scale|r. Fades in from 0 to |cffffd200Fade in alpha|r taking |cffffd200Fade in time|r (seconds) and is anchored to |cffffd200From|r.
 |cff00ff00Step 2|r: Moves linearly from |cffffd200From|r to |cffffd200To|r using |cffffd200Move time|r (seconds), sizes from |cffffd200From scale|r to |cffffd200To scale|r, and fades from |cffffd200Fade in alpha|r to |cffffd200To alpha|r
 |cff00ff00Step 3|r: Cooldown displays.
 |cff00ff00Step 4|r: Cooldown is done. Fades from |cffffd200To alpha|r to 0 and shrinks to nothing over |cffffd200Fade out time|r (seconds)]=] ] = "触发特效将会最大化然后最小化。  |cff00ff00Step 1|r: 初始大小为|cffffd200From scale|r. 从0淡入到|cffffd200Fade in alpha|r taking |cffffd200Fade in time|r (秒) 并抛向|cffffd200From|r.  |cff00ff00Step 2|r: 线性的从|cffffd200From|r 移动到 |cffffd200To|r 使用|cffffd200Move time|r (秒), 大小从 |cffffd200From scale|r 到|cffffd200To scale|r, 并淡入从|cffffd200Fade in alpha|r 到 |cffffd200To alpha|r  |cff00ff00Step 3|r: 冷却显示  |cff00ff00Step 4|r: 冷却完成。淡入从 |cffffd200To alpha|r 到0并收缩至|cffffd200Fade out time|r (seconds)"
L["Attributes"] = "属性"
L["Author"] = "作者"
L["Backdrop alpha"] = "背景透明度"
L["Background color"] = "背景颜色"
L["Bar"] = "状态条"
L["Bar and rune spacing"] = "状态条与符文间距"
L["Bar background"] = "状态条背景"
L["Bar border"] = "状态条边框"
L["Bar color"] = "状态条颜色"
L["Bar fill method"] = "状态条填充方式"
L["Bar height"] = "状态条高度"
L["Bar orientation"] = "状态条方向"
L["Bars"] = "状态条"
L["Bar texture"] = "状态条纹理"
L["Bar width"] = "状态条宽度"
L["Base timer on rune"] = "符文上的计时器"
L["Behavior"] = "行为"
L["Blood"] = "鲜血"
L["Blood rune"] = "鲜血符文"
L["Border color"] = "边框颜色"
L["Button Facade skins"] = "Button Facade 皮肤"
L["|cff00CC00Version:|r"] = "|cff00CC00版本:|r"
L["|cff99ff33Click|r to toggle the config"] = "cff99ff33Click|r 切换设置"
L["|cff99ff33Right-Click|r to toggle locking"] = "|cff99ff33右键点击|r 以切换锁定状态"
L[ [=[|cffffd200Horizontal|r: %s
|cffffd200Vertical|r: %s]=] ] = [=[|cffffd200水平的|r: %s
|cffffd200垂直的|r: %s]=]
L["Colors"] = "颜色"
L["Columns"] = "柱型"
L["Constant color"] = "固定颜色"
L["Credits"] = "鸣谢"
L["Custom order"] = "自定义顺序"
L["Death"] = "死亡"
L["Death rune"] = "死亡符文"
L["Death to normal"] = "死亡到正常"
L["Deplete"] = "消耗"
L["Determines if diseases are overlapping by taking the absolute value of the time differences and seeing if it's <= Overlap time"] = "当采取的绝对值有差异的时候，确定是否有重叠的疾病并观察它是否有重叠<=重叠时间"
L["Diseases"] = "疾病"
L["Edge length"] = "边缘长度"
L["Enable"] = "开启"
L["Enabled"] = "已被开启"
L["Enable hundreths"] = "启用毫秒显示"
L["Enable usable pulse"] = "激活使用闪烁效果"
L["End alpha"] = "结束透明度"
L["End time"] = "结束时间"
L["Extend distance"] = "扩展距离"
L["Fade in alpha"] = "透明度淡入"
L["Fade in time"] = "时间淡入"
L["Fade out time"] = "时间淡出"
L["Fill alpha"] = "填充透明度"
L["Fills"] = "填充"
L["Find updates at"] = "在 查找最新"
L["Font"] = "字体"
L["Font pulse down time"] = "字体闪烁结束时间"
L["Font pulse size"] = "字体闪烁大小"
L["Font pulse up time"] = "字体闪烁时间"
L["Font size"] = "字体大小"
L["French translations"] = "法语翻译"
L["From 10 seconds (the moment a rune is used) to End Time the alpha of the bar fades from Start Alpha to End Alpha"] = "在接下来的十秒（符分刚使用时）到结束的时间动作条的透明度从起始的设定值淡入到最终的透明度"
L["From 10 seconds (the moment a rune is used) to End Time the alpha of the icon fades from Start Alpha to End Alpha"] = "在接下来的十秒（符分刚使用时）图标的透明度从起始设定的透明度淡入到最终的透明度"
L["From scale"] = "从缩放"
L["Frost"] = "冰霜"
L["Frost rune"] = "冰霜符文"
L["General"] = "常规"
L["German translations"] = "德语翻译"
L["Global scale"] = "全局缩放"
L["Gradual Fade In"] = "慢速淡入"
L["Grow"] = "增长"
L["Hide bars when ready"] = "就绪时隐藏状态条"
L["Hide Blizzard Rune Frame"] = "隐藏游戏默认符文框架"
L["Horizontal"] = "横向"
L["How big the rune icon pulses. Keep this bigger than icon size"] = "闪烁时增大此图标"
L["How long it takes to scale down to icon size after it pulses"] = "闪烁后图标缩小时间"
L["How long it takes to scale up to icon pulse size"] = "图标增大至闪烁大小所需时间"
L["How many degrees the icon spins"] = "图标旋转有多少度"
L["Hundreths font size"] = "毫秒字体尺寸"
L["Hundreths position"] = "毫秒位置"
L["Hundreths position 2"] = "毫秒位置2"
L["Icon alpha"] = "图标透明度"
L["Icon pulse size"] = "图标闪烁尺寸"
L["Icons"] = "图标"
L["Icon scale down time"] = "图标缩小时间"
L["Icon scale up time"] = "图标放大时间"
L["Icon size"] = "图标尺寸"
L["If you are using the runes + runic power triangle layouts and adjust this scale the runes will not position correctly. Adjust the triangle edge length instead"] = "注意:如果你正在使用符文/符文能量的三角形布局,调整这个缩放设置将导致符文位置错误.你应该去调整\"三角形边缘长度\""
L["Imprint alpha"] = "标记透明度"
L["In combat alpha"] = "战斗中透明度"
L["Individual"] = "独立"
L[ [=[Input a list of rune ids separated by commas. It will only accept six numbers from 1 to 6. Each number must be |cffff0000different|r from the rest.

Rune ids are as followed:
   1 - Blood rune 1
   2 - Blood rune 2
   3 - Unholy rune 1
   4 - Unholy rune 2
   5 - Frost rune 1
   6 - Frost rune 2]=] ] = [=[输入一个以半角逗号作为分割符的符文id列表.(例如:1,2,3,4,5,6)
只接受数字1-6作为符文id.每个数字只能使用1次.
符文id如下:
1-鲜血符文1
2-鲜血符文2
3-邪恶符文1
4-邪恶符文2
5-冰霜符文1
6-冰霜符文2]=]
L["Inspiration, ideas, and testing"] = "启示，想法和测试"
L["Invalid value for rune id. Expecting a number from 1 to 6 for each value"] = "符文id非法.必须为1-6的数字"
L["Invert"] = "反向"
L["Layouts"] = "布局"
L["Linear animation"] = "线性动画"
L["Locked"] = "锁定"
L["Minimap"] = "小地图"
L["Move method"] = "移动方法"
L["Move time"] = "移动时间"
L["None"] = "无"
L["Normal positions"] = "正常位置"
L["Normal to death"] = "正常到死亡"
L["Not a valid table"] = "不是一个合法的表"
L["On unusable"] = "正在不可用的"
L["On usable"] = "正在可用的"
L["OOC Fading Enabled"] = "战斗外渐隐开启"
L["Origin to out"] = "初始到外面"
L["Out combat alpha"] = "战斗外透明度"
L["Out of combat fading"] = "战斗外渐隐"
L["Out to origin"] = "外面到初始"
L["Overlap time"] = "重叠时间"
L["Pipe"] = "管"
L["Preset order"] = "预设顺序"
L["Presets"] = "预设值"
L["Procs"] = "特效"
L["Pulse"] = "闪烁"
L["Pulse and spin"] = "闪烁和旋转"
L["Ready"] = "准备就绪"
L["Release"] = "发行"
L["Requires OmniCC to be installed. If this is checked and OmniCC is not installed there will be no timer. The default timer will display if this is unchecked"] = "必须安装了OmniCC插件.如果这个选项被选中,但并没有安装OmniCC,将会不出现任何计时器. 取消这个选项将会显示默认的计时器."
L["Reverse"] = "反转"
L["Reversed Columns"] = "反转柱型"
L["Reversed positions"] = "反转位置"
L["Reversed Six Pack"] = "反转符文次序"
L["Reversed Stacking"] = "反转堆叠"
L["Rune icons"] = "符文图标"
L["Rune ids are not all different"] = "符文id有重复."
L["Rune Order"] = "符文顺序"
L["Runes"] = "符文"
L["Rune set"] = "符文设置"
L["Rune spacing"] = "符文间隔"
L["Runic Power"] = "符文能量"
L["Scale"] = "缩放"
L["Seconds position"] = "秒钟位置"
L["Seconds position 2"] = "秒钟位置2"
L["Select proc"] = "选择特效"
L["Set"] = "设置"
L["Settings"] = "设置"
L["Show imprint"] = "显示标记"
L["Show spark"] = "显示闪烁"
L["Simplified Chinese translations"] = "简体中文翻译"
L["Six Pack"] = "6个封装"
L["Six values required"] = "需要6个数值"
L["Skin"] = "皮肤"
L["Sound on proc"] = "特效发动时发出声音"
L["Spacing"] = "间距"
L["Spacing scale"] = "间隔缩放"
L["Spin"] = "旋转"
L["Spin degree"] = "旋转角度"
L["Stacking"] = "堆叠"
L["Start alpha"] = "起始透明度"
L["Starts all rune bars"] = "启用所有符文条"
L["Status bar alpha"] = "状态条透明度"
L["Stop all procs if they're running"] = "在触发特效消失后停止所有特效"
L["Table"] = "表格"
L["Target nothing while testing. If you target something while testing the bar will clear."] = "测试时没有目标。如果测试时选定一个目标，状态条会被清除。"
L["Test"] = "测试"
L["Test all procs"] = "测试所有触发特效显示"
L["Text"] = "文字"
L["Text color"] = "文本颜色"
L["Text position x"] = "文字位置x坐标"
L["Text position y"] = "文字位置y坐标"
L["The bar's background color can be adjusted in the Colors tab -> Background color. Also note that for colored backgrounds, such as Blizzard Parchment, set the Background color to completely white or else the colors won't show up"] = "状态条背景颜色可以在 颜色->背景颜色 这个选项中被调节.同时需要注意的是,如果使用带颜色的背景,比如Blizzard Parchment,请将背景颜色设置为白色否则彩色背景本身将不会显示出来"
L["The distance between each rune"] = "各符文间的距离"
L["The distance between each rune and bar"] = "各符文和状态条间的距离"
L["Timer color"] = "计时器颜色"
L["To alpha"] = "透明度"
L["To scale"] = "缩放"
L["Traditional Chinese translations"] = "繁体语言翻译"
L["Triangle"] = "三角形"
L["Triangle texture"] = "三角材质"
L["Unholy"] = "邪恶"
L["Unholy rune"] = "邪恶符文"
L["Usable position"] = "可用符文位置"
L["Usable position 2"] = "可用符文位置2"
L["Usable/Seconds text font size"] = "可用/秒钟文本字体大小"
L["Use custom order"] = "使用自定义顺序"
L["Use fill colors"] = "使用填充颜色"
L["Use OmniCC timer"] = "使用OmniCC冷却计时器"
L["Vertical"] = "纵向"
L["X direction for horizontal layouts. Y direction for vertical layouts"] = "x方向是横向显示,y方向是纵向显示"
L["Y direction for horizontal layouts. X direction for vertical layouts"] = "y方向是横向显示,x方向是纵向显示"

return
end

local L = AL:NewLocale("Acherus", "zhTW")
if L then
L["20 > RP >= 0"] = "20>符能>=0"
L["40 > RP >= 20"] = "40>符能>=20"
L["60 > RP >= 40"] = "60>符能>=40"
L["80 >= RP"] = "80 >= 符能"
L["80 > RP >= 60"] = "80 > 符能 >= 60"
L["About"] = "關于"
L["Acherus"] = "╬亞榭洛╬"
L["Acherus by Kollektiv.& Lancestre. Type /ac or /acherus to open options"] = "╬亞榭洛╬由.Kollektiv.& Lancestre.編寫. 鍵入: /ac 或者 /acherus 來開啟選項"
L["Acherus is now locked"] = "╬亞榭洛╬已鎖定"
L["Acherus is now unlocked"] = "╬亞榭洛╬已解鎖"
L[ [=[A proc will start maximized and then minimize.
 |cff00ff00Step 1|r: Initial size is |cffffd200From scale|r. Fades in from 0 to |cffffd200Fade in alpha|r taking |cffffd200Fade in time|r (seconds) and is anchored to |cffffd200From|r.
 |cff00ff00Step 2|r: Moves linearly from |cffffd200From|r to |cffffd200To|r using |cffffd200Move time|r (seconds), sizes from |cffffd200From scale|r to |cffffd200To scale|r, and fades from |cffffd200Fade in alpha|r to |cffffd200To alpha|r
 |cff00ff00Step 3|r: Cooldown displays.
 |cff00ff00Step 4|r: Cooldown is done. Fades from |cffffd200To alpha|r to 0 and shrinks to nothing over |cffffd200Fade out time|r (seconds)]=] ] = [=[觸發特效將會最大化然後最小化。
 |cff00ff00Step 1|r: 初始大小為|cffffd200From scale|r. 從0漸隱到|cffffd200Fade in alpha|r taking |cffffd200Fade in time|r (秒) 并拋向|cffffd200From|r.
 |cff00ff00Step 2|r: 線性的從|cffffd200From|r 移動到 |cffffd200To|r 使用|cffffd200Move time|r (秒), 大小從 |cffffd200From scale|r 到|cffffd200To scale|r, 并漸隱從|cffffd200Fade in alpha|r 到 |cffffd200To alpha|r
 |cff00ff00Step 3|r: 冷卻顯示
 |cff00ff00Step 4|r: 冷卻完成。漸隱從 |cffffd200To alpha|r 到0并收縮至|cffffd200Fade out time|r (seconds)]=]
L["Attributes"] = "屬性"
L["Author"] = "作者"
L["Backdrop alpha"] = "背景透明度"
L["Background color"] = "背景顏色"
L["Bar"] = "條"
L["Bar and rune spacing"] = "條跟符文間距"
L["Bar background"] = "條背景"
L["Bar border"] = "條邊界"
L["Bar color"] = "條顏色"
L["Bar fill method"] = "條填充方案"
L["Bar height"] = "條高"
L["Bar orientation"] = "條方向"
L["Bars"] = "條"
L["Bar texture"] = "條材質"
L["Bar width"] = "條寬"
L["Base timer on rune"] = "計時器於符文"
L["Behavior"] = "行為"
L["Blood"] = "血魄"
L["Blood rune"] = "血魄符文"
L["Border color"] = "邊界顏色"
L["Button Facade skins"] = "Button Facade 皮膚"
L["|cff00CC00Version:|r"] = "|cff00CC00版本:|r"
L["|cff99ff33Click|r to toggle the config"] = "|cff99ff33點擊|r 開啟/關閉配置菜單"
L["|cff99ff33Right-Click|r to toggle locking"] = "|cff99ff33右擊|r 來切換鎖定狀態"
L[ [=[|cffffd200Horizontal|r: %s
|cffffd200Vertical|r: %s]=] ] = "|cffffd200水平|r: %s|cffffd200垂直|r: %s"
L["Colors"] = "顏色"
L["Columns"] = "圓柱"
L["Constant color"] = "固定顏色"
L["Credits"] = "工作人員"
L["Custom order"] = "自定順序"
L["Death"] = "死亡"
L["Death rune"] = "死亡符文"
L["Death to normal"] = "死亡到正常"
L["Deplete"] = "衰竭"
L["Determines if diseases are overlapping by taking the absolute value of the time differences and seeing if it's <= Overlap time"] = "用“疾病之間的時間差的絕對值”是否小於等於“重疊時間” 來 判斷疾病是否重疊"
L["Diseases"] = "疾病"
L["Edge length"] = "邊緣長度"
L["Enable"] = "啟用"
L["Enabled"] = "啟用"
L["Enable hundreths"] = "啟用毫秒"
L["Enable usable pulse"] = "啟用閃爍"
L["End alpha"] = "結束時透明度"
L["End time"] = "停止時間"
L["Extend distance"] = "延展距離"
L["Fade in alpha"] = "淡入透明度"
L["Fade in time"] = "淡入時間"
L["Fade out time"] = "淡出時間"
L["Fill alpha"] = "填充透明度"
L["Fills"] = "填充"
L["Find updates at"] = "查找更新"
L["Font"] = "字體"
L["Font pulse down time"] = "字體閃爍停留時間"
L["Font pulse size"] = "字體閃爍尺寸"
L["Font pulse up time"] = "字體閃爍時間"
L["Font size"] = "字體尺寸"
L["French translations"] = "法語翻譯"
L["From 10 seconds (the moment a rune is used) to End Time the alpha of the bar fades from Start Alpha to End Alpha"] = "在10秒內（使用符文的那一刻）條從开始到結束逐渐透明"
L["From 10 seconds (the moment a rune is used) to End Time the alpha of the icon fades from Start Alpha to End Alpha"] = "在10秒內（使用符文的那一刻）圖標從开始到結束逐渐透明"
L["From scale"] = "開始位置比例"
L["Frost"] = "冰霜"
L["Frost rune"] = "冰霜符文"
L["General"] = "一般"
L["German translations"] = "德語翻譯"
L["Global scale"] = "整體比例"
L["Gradual Fade In"] = "緩慢淡入"
L["Grow"] = "延伸"
L["Hide bars when ready"] = "準備完成時隱藏條"
L["Hide Blizzard Rune Frame"] = "隱藏暴雪符文框架"
L["Horizontal"] = "水平"
L["How big the rune icon pulses. Keep this bigger than icon size"] = "符文圖標閃爍後，總是大過原尺寸"
L["How long it takes to scale down to icon size after it pulses"] = "圖標閃爍後變回原尺寸的時間"
L["How long it takes to scale up to icon pulse size"] = "圖標閃爍放大的時間"
L["How many degrees the icon spins"] = "圖標旋轉多少度"
L["Hundreths font size"] = "毫秒字體尺寸"
L["Hundreths position"] = "毫秒位置"
L["Hundreths position 2"] = "毫秒位置2"
L["Icon alpha"] = "圖標透明度"
L["Icon pulse size"] = "圖標閃爍尺寸"
L["Icons"] = "圖標"
L["Icon scale down time"] = "圖標變化停留時間"
L["Icon scale up time"] = "圖標變化運行時間"
L["Icon size"] = "圖標尺寸"
L["If you are using the runes + runic power triangle layouts and adjust this scale the runes will not position correctly. Adjust the triangle edge length instead"] = [=[如果你使用符文+符能三角形布局 并 同時調整其比例 將會導致符文位置錯誤。
請改為調整三角開口長度]=]
L["Imprint alpha"] = "印記透明度"
L["In combat alpha"] = "戰鬥中透明"
L["Individual"] = "特效"
L[ [=[Input a list of rune ids separated by commas. It will only accept six numbers from 1 to 6. Each number must be |cffff0000different|r from the rest.

Rune ids are as followed:
   1 - Blood rune 1
   2 - Blood rune 2
   3 - Unholy rune 1
   4 - Unholy rune 2
   5 - Frost rune 1
   6 - Frost rune 2]=] ] = [=[鍵入符文代碼并用逗號分開 只接受數字1到6 每個數字必須是|cffff0000different|r 從剩下的開始
符文代碼如下：
1 血魄符文1
2 血魄符文2
3 穢邪符文1
4 穢邪符文2
5 冰霜符文1
6 冰霜符文2]=]
L["Inspiration, ideas, and testing"] = "靈感，創意和測試"
L["Invalid value for rune id. Expecting a number from 1 to 6 for each value"] = "無效的符文代碼 每個值需要1到6的數字"
L["Invert"] = "顛倒"
L["Layouts"] = "布局"
L["Linear animation"] = "線性動畫"
L["Locked"] = "鎖定"
L["Minimap"] = "微型地圖"
L["Move method"] = "移動方案"
L["Move time"] = "移動時間"
L["None"] = "無"
L["Normal positions"] = "正向位置"
L["Normal to death"] = "正常到死亡"
L["Not a valid table"] = "非有效表格"
L["On unusable"] = "在無法使用"
L["On usable"] = "在可用"
L["OOC Fading Enabled"] = "非戰鬥時漸隱"
L["Origin to out"] = "初始到外面"
L["Out combat alpha"] = "非戰鬥透明"
L["Out of combat fading"] = "非戰鬥漸隱"
L["Out to origin"] = "外面到初始"
L["Overlap time"] = "重疊時間"
L["Pipe"] = "管子"
L["Preset order"] = "邊框順序"
L["Presets"] = "邊框"
L["Procs"] = "觸發"
L["Pulse"] = "閃爍"
L["Pulse and spin"] = "閃爍和旋轉"
L["Ready"] = "準備就緒"
L["Release"] = "解除"
L["Requires OmniCC to be installed. If this is checked and OmniCC is not installed there will be no timer. The default timer will display if this is unchecked"] = [=[需要安裝OmniCC  如果選此項但是無OmniCC 將沒有計時器
如果不選此項默認計時器將顯示]=]
L["Reverse"] = "逆向"
L["Reversed Columns"] = "逆向圓柱"
L["Reversed positions"] = "逆向位置"
L["Reversed Six Pack"] = "逆向六個包裹"
L["Reversed Stacking"] = "逆向堆疊"
L["Rune icons"] = "符文圖標"
L["Rune ids are not all different"] = "有相同的符文代碼"
L["Rune Order"] = "符文順序"
L["Runes"] = "符文"
L["Rune set"] = "符文設置"
L["Rune spacing"] = "符文間距"
L["Runic Power"] = "符能"
L["Scale"] = "尺寸"
L["Seconds position"] = "秒鐘位置"
L["Seconds position 2"] = "秒鐘位置2"
L["Select proc"] = "選擇觸發技能"
L["Set"] = "設置"
L["Settings"] = "設置"
L["Show imprint"] = "顯示印記"
L["Show spark"] = "顯示閃爍"
L["Simplified Chinese translations"] = "簡體中文翻譯"
L["Six Pack"] = "六個包裹"
L["Six values required"] = "需要六個數值"
L["Skin"] = "皮膚"
L["Sound on proc"] = "觸發音效"
L["Spacing"] = "間距"
L["Spacing scale"] = "間隔距離"
L["Spin"] = "旋轉"
L["Spin degree"] = "旋轉角度"
L["Stacking"] = "堆疊"
L["Start alpha"] = "使用時透明度"
L["Starts all rune bars"] = "開啟所有符文條"
L["Status bar alpha"] = "狀態條透明度"
L["Stop all procs if they're running"] = "觸發存在時停止再顯示觸發"
L["Table"] = "表格"
L["Target nothing while testing. If you target something while testing the bar will clear."] = "測試時無目標 如果測試時你有目標 條會清空"
L["Test"] = "測試"
L["Test all procs"] = "測試所有觸發"
L["Text"] = "文字"
L["Text color"] = "文字顏色"
L["Text position x"] = "文字位置x"
L["Text position y"] = "文字位置y"
L["The bar's background color can be adjusted in the Colors tab -> Background color. Also note that for colored backgrounds, such as Blizzard Parchment, set the Background color to completely white or else the colors won't show up"] = "條的背景顏色可以在顏色選項->背景顏色調整。還要注意著色背景，如暴雪材質，設置背景顏色為純白色或其他顏色將不會顯示"
L["The distance between each rune"] = "符文間距"
L["The distance between each rune and bar"] = "每個符文與符文條間距"
L["Timer color"] = "計時器顏色"
L["To alpha"] = "目標位置透明度"
L["To scale"] = "目標位置比例"
L["Traditional Chinese translations"] = "繁體中文翻譯"
L["Triangle"] = "三角形"
L["Triangle texture"] = "三角形紋理"
L["Unholy"] = "穢邪"
L["Unholy rune"] = "穢邪符文"
L["Usable position"] = "可用位置"
L["Usable position 2"] = "可用位置2"
L["Usable/Seconds text font size"] = "可用/秒鐘文本字體尺寸"
L["Use custom order"] = "使用自定順序"
L["Use fill colors"] = "使用填充顏色"
L["Use OmniCC timer"] = "使用OmniCC計時器"
L["Vertical"] = "垂直"
L["X direction for horizontal layouts. Y direction for vertical layouts"] = "X方向為水平布局。Y方向為垂直布局"
L["Y direction for horizontal layouts. X direction for vertical layouts"] = "Y方向為水平布局。X方向為垂直布局"

return
end
