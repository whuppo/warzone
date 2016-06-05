if SERVER then

	AddCSLuaFile("shared.lua")
	
end

if CLIENT then

	SWEP.ViewModelFlip		= true
	
	SWEP.PrintName = "CZ75 Auto"
	SWEP.IconLetter = "a"
	SWEP.Slot = 1
	SWEP.Slotpos = 0
	
end

SWEP.HoldType = "pistol"

SWEP.Base = "rad_base"

SWEP.ViewModel				= "models/weapons/tfa_csgo/c_cz75.mdl"
SWEP.WorldModel				= "models/weapons/tfa_csgo/w_cz75.mdl"

SWEP.ViewModelFlip 			= false
SWEP.ViewModelFOV 			= 60
SWEP.UseHands 				= true

SWEP.IsSniper = false
SWEP.AmmoType = "Pistol"

SWEP.Primary.Sound			= Sound( "tfa_csgo/cz75a/cz75a-1.wav" )
SWEP.Primary.Recoil			= 3
SWEP.Primary.Damage			= 33
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.05215
SWEP.Primary.Delay			= 0.100

SWEP.Primary.Ammo           = "Pistol"
SWEP.Primary.ClipSize		= 12
SWEP.Primary.Automatic		= true
