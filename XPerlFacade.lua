
local LBF = LibStub("LibButtonFacade", true)
local LMB = LibStub("Masque", true) or (LibMasque and LibMasque("Button"))
local Stub = (LBF or LMB)
if not Stub then return end

local f = CreateFrame("Frame")

local addonName = ...
local _G, strfind, type, hooksecurefunc = 
	  _G, strfind, type, hooksecurefunc
	  
local db, group, queueUpdate

local noop = function() return end


local function DoStuff(self, event, addon)
	if event == "ADDON_LOADED" and addon == addonName then
		XPerlFacade = XPerlFacade or {}
		db = XPerlFacade;
		group = Stub:Group("XPerl")
		group:Skin(db.S,db.G,db.B,db.C);
		for i=1,40 do
			local name = "XPerl_PlayerbuffFrameAuraButton"..i
			local frame = _G[name]
			if not frame then
				break 
			else
				group:AddButton(frame,{
					Icon		= _G[name.."icon"],
					Cooldown 	= _G[name.."cooldown"],
					Count 		= _G[name.."count"],
					Border 		= _G[name.."border"],
				})
			end
		end
		for i=1,40 do
			local name = "XPerl_PlayerdebuffFrameAuraButton"..i
			local frame = _G[name]
			if not frame then
				break 
			else
				group:AddButton(frame,{
					Icon		= _G[name.."icon"],
					Cooldown 	= _G[name.."cooldown"],
					Count 		= _G[name.."count"],
					Border 		= _G[name.."border"],
				})
			end
		end
		for i=1,3 do
			local name = "XPerl_PlayerbuffFrameTempEnchant"..i
			local frame = _G[name]
			if not frame then
				break 
			else
				group:AddButton(frame,{
					Icon		= _G[name.."icon"],
					Cooldown 	= _G[name.."cooldown"],
					Count 		= _G[name.."count"],
					Border 		= _G[name.."border"],
				})
			end
		end
		if not LMB then
			Stub:RegisterSkinCallback("XPerl", function(arg, SkinID, Gloss, Backdrop, Group, Button, Colors)
				if db then
					db.S = SkinID
					db.G = Gloss
					db.B = Backdrop
					db.C = Colors
				end
			end)
		end
		f:UnregisterEvent(event)
	end
end


hooksecurefunc("CreateFrame", function (_, name)	
	if type(name) ~= "string" then return end
	if strfind(name,"^XPerlBuff") or strfind(name,"^XPerl_Player.*FrameAuraButton") then
		local button = _G[name]
		
		local restore = button.SetFrameLevel
		if button:CanChangeProtectedState() then
			button.SetFrameLevel = noop
		end
		
		group:AddButton(button,{
			Icon		= _G[name.."icon"],
			Cooldown 	= _G[name.."cooldown"],
			Count 		= _G[name.."count"],
			Border 		= _G[name.."border"],
		})
		if button:IsProtected() then
			button.cooldown:SetFrameLevel(button:GetFrameLevel()-1)
		end
		
		button.SetFrameLevel = restore
	end
end
)
	
f:SetScript("OnEvent", DoStuff)
f:RegisterEvent("ADDON_LOADED")

