
local LMB = LibStub("Masque", true) or (LibMasque and LibMasque("Button"))
if not LMB then return end

local f = CreateFrame("Frame")

local addonName = ...
local _G, strfind, type, hooksecurefunc = 
	  _G, strfind, type, hooksecurefunc
	  
local db, group, queueUpdate

local noop = function() return end


local group = LMB:Group("XPerl")

local nextAuraIndex = 1
local nextBuffIndex = 1
local nextDebuffIndex = 1
f:SetScript("OnUpdate", function()
	while _G["XPerlBuff" .. nextAuraIndex] do
		local name = "XPerlBuff" .. nextAuraIndex
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
		--if button:IsProtected() then
			button.cooldown:SetFrameLevel(button:GetFrameLevel()-1)
		--end
		
		button.SetFrameLevel = restore


		nextAuraIndex = nextAuraIndex + 1
	end


	for i = nextBuffIndex, 1000 do
		local name = "XPerl_PlayerbuffFrameAuraButton"..i
		local frame = _G[name]
		if not frame then
			nextBuffIndex = i
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


	for i = nextDebuffIndex, 1000 do
		local name = "XPerl_PlayerdebuffFrameAuraButton"..i
		local frame = _G[name]
		if not frame then
			nextDebuffIndex = i
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
end)

