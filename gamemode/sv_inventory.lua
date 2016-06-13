util.AddNetworkString( "wz_loadout" )

local meta = FindMetaTable( "Player" )

loadouts = loadouts or {}
preloadouts = preloadouts or {}

function GM:ShowHelp( ply )
	ply:ConCommand( "wz_inventory" )
end	

net.Receive( "wz_loadout", function( len, ply )
	local primary   = net.ReadString() // first weapon
	local secondary = net.ReadString() // second weapon

	if ply:IsValid() then
		preloadouts[ ply ] = {
			primary   = primary,
			secondary = secondary
		}
		if not loadouts[ ply ] or not ply:Alive() then
			loadouts[ ply ] = {
				primary   = primary,
				secondary = secondary
			}
		end
	end
end )

hook.Add( "PlayerDeath", "FixLoadoutExploit", function( ply )
	local pl = preloadouts[ ply ]
	if pl then
		loadout[ ply ] = {
			primary   = primary,
			secondary = secondary
		}
	end
end )

function meta:GiveLoadout()
	self:StripWeapons()
	local l = loadouts[ self ]
	if l then
		self:Give( l.primary )
		self:Give( l.secondary )
	end
end

hook.Add( "PlayerSpawn", "GiveLoadout", function( ply ) ply:GiveLoadout() end )