if SERVER then

	AddCSLuaFile("shared.lua")
	
end

if CLIENT then

	SWEP.ViewModelFlip		= true
	
	SWEP.PrintName = "P90"
	SWEP.IconLetter = "x"
	SWEP.Slot = 0
	SWEP.Slotpos = 0
	
end

SWEP.HoldType = "smg"

SWEP.Base = "rad_base"

SWEP.ViewModel				= "models/weapons/tfa_csgo/c_p90.mdl"
SWEP.WorldModel				= "models/weapons/tfa_csgo/w_p90.mdl"

SWEP.ViewModelFlip 			= false
SWEP.ViewModelFOV 			= 60
SWEP.UseHands 				= true

SWEP.IsSniper = false
SWEP.AmmoType = "SMG"

SWEP.Primary.Sound			= Sound( "tfa_csgo/p90/p90-1.wav" )
SWEP.Primary.Recoil			= 2
SWEP.Primary.Damage			= 26
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.014
SWEP.Primary.Delay			= 0.06

SWEP.Primary.Ammo           = "SMG"
SWEP.Primary.ClipSize		= 50
SWEP.Primary.Automatic		= true
