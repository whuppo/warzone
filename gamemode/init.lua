AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "hud.lua" )
AddCSLuaFile( "cl_feed.lua" )
AddCSLuaFile( "cl_scoreboard.lua" )

include( "shared.lua" )
include( "resources.lua" )
include( "sv_feed.lua" )

function GM:GetFallDamage( ply, speed )
	return 0
end

hook.Add( "PlayerSpawn", "PlayerSpawn", function( ply )
	ply:SetModel( "models/player/group03/male_01.mdl" )
	ply:SetArmor(100)
end )

hook.Add( "PlayerSay", "chat_debug", function( ply, txt, teamChat )
	if txt == "feedtest" then
		print( "feedtest" )
		ply:SendNotice( "Testing Notification", Color( 0, 128, 64, 200 ), {
			{ name = "Acolyte, Common", points = 100, epic = 0 },
			{ name = "Acolyte, Rare", points = 200, epic = 1 },
			{ name = "Acolyte, Epic", points = 400, epic = 2 }
		} )
	end

	if txt == "feedtest2" then
		print( "feedtest" )
		ply:SendNotice( "Spam Notification", Color( 0, 128, 64, 200 ), {
			{ name = "Acolyte, Common", points = 100, epic = 0 },
			{ name = "Acolyte, Rare", points = 200, epic = 1 },
			{ name = "Acolyte, Epic", points = 400, epic = 2 },
			{ name = "Filler Acolyte", points = 100, epic = 0 },
			{ name = "Another Acolyte", points = 100, epic = 0 },
			{ name = "I just want to see how broken this is", points = 100, epic = 2 },
			{ name = "It probably is", points = 100, epic = 0 }
		} )
	end

	if txt == "feedtest_nodata" then
		ply:SendNotice()
	end

	if txt == "redteam" then
		ply:SetTeam( 1 )
		ULib.tsayColor( nil, false, Color( 255, 255, 255 ), "Player ", team.GetColor( ply:Team() ), ply:Nick(), Color( 255, 255, 255 ), " is now on Red." )
	end

	if txt == "blueteam" then
		ply:SetTeam( 2 )
		ULib.tsayColor( nil, false, Color( 255, 255, 255 ), "Player ", team.GetColor( ply:Team() ), ply:Nick(), Color( 255, 255, 255 ), " is now on Blue." )
	end
end )

hook.Add( "EntityTakeDamage", "ArmorRegen", function( vic, dmg )
	if vic:IsValid() and vic:IsPlayer() then
		vic:SetNWFloat( "NextRegen", CurTime() + 5 )
	end
end )

hook.Add( "PlayerPostThink", "ArmorRegen", function( ply )
	if ply:GetNWFloat( "NextRegen" ) ~= 0 and ply:GetNWFloat( "NextRegen" ) <= CurTime() then	
		ply:SetNWFloat( "NextRegen", 0 )
		if ply:Alive() then
			ply:SetArmor(100)
		end
	end
end )

hook.Add( "EntityTakeDamage", "ArmorDrainDelay", function( vic, dmg )
	if vic:IsValid() and vic:IsPlayer() then
		umsg.Start( "damage", vic )
			umsg.Short( dmg:GetDamage() )
		umsg.End()
	end
end )

hook.Add( "EntityTakeDamage", "ArmorDrain", function( vic, dmg )
	if vic:IsValid() and vic:IsPlayer() then
		vic:SetArmor(vic:Armor() - dmg:GetDamage())
		if vic:Armor() <= 0 then
			vic.SetArmor(0)
		else
			dmg:SetDamage(0)
		end
	end
end )