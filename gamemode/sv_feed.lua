util.AddNetworkString( "PlayerFeed" )

local meta = FindMetaTable( "Player" )

function meta:SendNotice( text, col, acolytes )
	if !text then text = "Dart, please fix this error." end
	if !col then col = Color( 0, 0, 0, 200 ) end
	if !acolytes then acolytes = {} end

	net.Start( "PlayerFeed" )
		net.WriteString( text )
		net.WriteColor( col )
		net.WriteTable( acolytes )
	net.Send( self )
end

hook.Add( "OnNPCKilled", "NPCNotifciation", function( npc, ply, inf )
	if npc:IsValid() and ply:IsValid() and ply:IsPlayer() then
		ply:SendNotice( npc:GetClass(), Color( 0, 64, 128, 200 ), {
			{ name = "NPC Kill", points = 50, epic = 0 }
		} )
	end
end )

hook.Add( "PlayerDeath", "PlyKillNotification", function( plyV, wep, plyA)
	if plyV:IsPlayer() and wep:IsValid() and plyA:IsPlayer() and plyV != plyA then
		plyA:SendNotice( plyV:Name(), Color( 0, 64, 128, 200 ), {
			{ name = "Player Kill", points = 100, epic = 0 }
		} )
	end
end )