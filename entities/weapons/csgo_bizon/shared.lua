if SERVER then

	AddCSLuaFile("shared.lua")
	
end

if CLIENT then

	SWEP.ViewModelFlip		= true
	
	SWEP.PrintName = "PP-Bizon"
	SWEP.IconLetter = "x"
	SWEP.Slot = 0
	SWEP.Slotpos = 0
	
end

SWEP.HoldType = "smg"

SWEP.Base = "rad_base"

SWEP.ViewModel				= "models/weapons/tfa_csgo/c_bizon.mdl"
SWEP.WorldModel				= "models/weapons/tfa_csgo/w_bizon.mdl"

SWEP.ViewModelFlip 			= false
SWEP.ViewModelFOV 			= 60
SWEP.UseHands 				= true

SWEP.IsSniper = false
SWEP.AmmoType = "SMG"

SWEP.Primary.Sound			= Sound( "tfa_csgo/bizon/bizon-1.wav" )
SWEP.Primary.Recoil			= 6
SWEP.Primary.Damage			= 27
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.014
SWEP.Primary.Delay			= 0.08

SWEP.Primary.Ammo           = "SMG"
SWEP.Primary.ClipSize		= 64
SWEP.Primary.Automatic		= true
