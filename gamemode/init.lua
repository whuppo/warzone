AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "hud.lua" )

include( "shared.lua" )
include( "resources.lua" )

hook.Add( "PlayerSay", "sweptest", function( ply, txt, teamChat )
	if txt == "dmgbuff" then
		local wep = ply:GetActiveWeapon()

		if IsValid( wep ) then
			wep.Primary.Recoil = wep.Primary.Recoil + 20
			print( "weapon stats changed" )
		end
	end
end )

hook.Add( "EntityTakeDamage", "HealthDrainDelay", function( vic, dmg )
	local ply = dmg:GetAttacker()
	if vic:IsValid() and vic:IsPlayer() and ply:IsValid() and ply:IsPlayer() then
		umsg.Start( "damage", vic )
			umsg.Short( dmg:GetDamage() )
		umsg.End()
	end
end )