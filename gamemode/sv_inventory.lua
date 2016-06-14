util.AddNetworkString( "wz_loadout" )
util.AddNetworkString( "RequestWeapons" )
util.AddNetworkString( "RequestWeaponsCallback" )

local meta = FindMetaTable( "Player" )

loadouts = loadouts or {}
preloadouts = preloadouts or {}

local DEFAULTPRIMARY   = "csgo_ak47"
local DEFAULTSECONDARY = "csgo_deagle"

local defaultweps = defaultweps or {}

RARITY = {
	DEFAULT = 1,
	COMMON = 2,
	RARE = 3,
	EPIC = 4,
	LEGENDARY = 5
}

function DefaultWeaponRegister( tbl )
	tbl.rarity    = tbl.rarity or RARITY.DEFAULT

	table.insert( defaultweps, tbl )
	util.PrecacheModel( tbl.model )
end

DefaultWeaponRegister( {
	name = "AK-47",
	class = "csgo_ak47",
	model = "models/weapons/tfa_csgo/w_ak47.mdl"
} )

DefaultWeaponRegister( {
	name = "M4A1-S",
	class = "csgo_m4a1s",
	model = "models/weapons/tfa_csgo/w_m4a1.mdl"
} )

DefaultWeaponRegister( {
	name = "AWP",
	class = "csgo_awp",
	model = "models/weapons/tfa_csgo/w_awp.mdl"
} )

DefaultWeaponRegister( {
	name = "P2000",
	class = "csgo_p2000",
	model = "models/weapons/tfa_csgo/w_p2000.mdl"
} )

DefaultWeaponRegister( {
	name = "Tec-9",
	class = "csgo_tec9",
	model = "models/weapons/tfa_csgo/w_tec9.mdl"
} )

DefaultWeaponRegister( {
	name = "P250",
	class = "csgo_p250",
	model = "models/weapons/tfa_csgo/w_p250.mdl"
} )

DefaultWeaponRegister( {
	name = "Desert Eagle",
	class = "csgo_deagle",
	model = "models/weapons/tfa_csgo/w_deagle.mdl"
} )

DefaultWeaponRegister( {
	name = "USP-S",
	class = "csgo_usp",
	model = "models/weapons/tfa_csgo/w_usp.mdl"
} )

DefaultWeaponRegister( {
	name = "Whispered Truth",
	class = "csgo_usp",
	model = "models/weapons/tfa_csgo/w_usp.mdl",
	rarity = RARITY.LEGENDARY,
	mods = {
		damage = 100,
		cone   = 0,
		recoil = 0
	}
} )

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
	local slot   = net.ReadString() // get weapon type
	local weapon = net.ReadString() // weapon
	local mods   = net.ReadTable() // mods if they exist

	if ply:IsValid() then
		if slot == "primary" then
			preloadouts[ ply ].primary = weapon
			preloadouts[ ply ].primarymods = mods or {}
		elseif slot == "secondary" then
			preloadouts[ ply ].secondary = weapon
			preloadouts[ ply ].secondarymods = mods or {}
		end
		if not loadouts[ ply ] or not ply:Alive() then
			if slot == "primary" then
				loadouts[ ply ].primary = weapon
				loadouts[ ply ].primarymods = mods or {}
			elseif slot == "secondary" then
				loadouts[ ply ].secondary = weapon
				loadouts[ ply ].secondarymods = mods or {}
			end
		end
	end
end )

hook.Add( "PlayerDeath", "FixLoadoutExploit", function( ply )
	local pl = preloadouts[ ply ]
	if pl then
		loadouts[ ply ] = {
			primary   = pl.primary or loadouts[ ply ].primary,
			secondary = pl.secondary or loadouts[ ply ].secondary,
			primarymods = pl.primarymods or {},
			secondarymods = pl.secondarymods or {}
		}
	end
end )

function meta:GiveLoadout()
	self:StripWeapons()
	local l = loadouts[ self ]
	if l then
		local pri = self:Give( l.primary )
		local sec = self:Give( l.secondary )

		if l.primarymods then
			PrintTable( l.primarymods )
			local primod = l.primarymods

			if primod.damage   then pri.Primary.Damage    = primod.damage end
			if primod.accuracy then pri.Primary.Cone      = primod.accuracy end
			if primod.recoil   then pri.Primary.Recoil    = primod.recoil end
		end

		if l.secondarymods then
			PrintTable( l.secondarymods )
			local secmod = l.secondarymods

			if secmod.damage   then sec.Primary.Damage    = secmod.damage end
			if secmod.accuracy then sec.Primary.Cone      = secmod.accuracy end
			if secmod.recoil   then sec.Primary.Recoil    = secmod.recoil end
		end
	end
end

hook.Add( "PlayerInitialSpawn", "SetLoadout", function( ply )
	preloadouts[ ply ] = {
		primary   = DEFAULTPRIMARY,
		secondary = DEFAULTSECONDARY
	}
	loadouts[ ply ] = {
		primary   = DEFAULTPRIMARY,
		secondary = DEFAULTSECONDARY
	}
end )

hook.Add( "PlayerSpawn", "GiveLoadout", function( ply ) ply:GiveLoadout() end )