util.AddNetworkString( "wz_loadout" )
util.AddNetworkString( "RequestWeapons" )
util.AddNetworkString( "RequestWeaponsCallback" )

local meta = FindMetaTable( "Player" )

loadouts = loadouts or {}
preloadouts = preloadouts or {}

local DEFAULTPRIMARY   = "csgo_ak47"
local DEFAULTSECONDARY = "csgo_deagle"

local defaultweps = {
	{ name = "AK-47", class = "csgo_ak47", model = "models/weapons/tfa_csgo/w_ak47.mdl", rarity = 1 },
	{ name = "AWP", class = "csgo_awp", model = "models/weapons/tfa_csgo/w_awp.mdl", rarity = 1 },
	{ name = "Desert Eagle", class = "csgo_deagle", model = "models/weapons/tfa_csgo/w_deagle.mdl", rarity = 1 }
}

function GM:ShowHelp( ply )
	ply:ConCommand( "wz_inventory" )
end	

net.Receive( "RequestWeapons", function( len, ply )
	net.Start( "RequestWeaponsCallback" )
		--current loadout
		local l = loadouts[ ply ]
		if l then
			net.WriteTable( loadouts[ ply ] )
		end
		--default weapons
		net.WriteTable( defaultweps )

		--players inventory
		--net.WriteTable( fetched_weapons )
	net.Send( ply )
end )

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
		loadouts[ ply ] = {
			primary   = pl.primary,
			secondary = pl.secondary
		}
	end
end )

function meta:GiveLoadout()
	self:StripWeapons()
	local l = loadouts[ self ]
	if l then
		self:Give( l.primary )
		self:Give( l.secondary )
	else
		self:Give( DEFAULTPRIMARY )
		self:Give( DEFAULTSECONDARY )

		loadouts[ self ] = {
			primary   = DEFAULTPRIMARY,
			secondary = DEFAULTSECONDARY
		}
	end
end

hook.Add( "PlayerInitialSpawn", "SetLoadout", function( ply )
	loadouts[ ply ] = {
		primary   = DEFAULTPRIMARY,
		secondary = DEFAULTSECONDARY
	}
end )

hook.Add( "PlayerSpawn", "GiveLoadout", function( ply ) ply:GiveLoadout() end )