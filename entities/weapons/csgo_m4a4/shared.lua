if SERVER then

	AddCSLuaFile("shared.lua")
	
end

if CLIENT then
	
	SWEP.PrintName = "M4A4"
	SWEP.IconLetter = "b"
	SWEP.Slot = 0
	SWEP.Slotpos = 0
	
end

SWEP.HoldType = "ar2"

SWEP.Base = "rad_base"

SWEP.ViewModel				= "models/weapons/tfa_csgo/c_m4a4.mdl"
SWEP.WorldModel				= "models/weapons/tfa_csgo/w_m4a4.mdl"

SWEP.ViewModelFlip 			= false
SWEP.ViewModelFOV 			= 60
SWEP.UseHands 				= true

SWEP.IsSniper = false
SWEP.AmmoType = "Rifle"

SWEP.Primary.Sound 			= Sound( "tfa_csgo/m4a4/m4a4-1.wav" )
SWEP.Primary.Recoil			= 6
SWEP.Primary.Damage			= 33
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.0490
SWEP.Primary.Delay			= 0.089955022488755

SWEP.Primary.Ammo           = "Rifle"
SWEP.Primary.ClipSize		= 30
SWEP.Primary.Automatic		= true
