if SERVER then

	AddCSLuaFile("shared.lua")
	
end

if CLIENT then

	SWEP.ViewModelFlip		= true
	
	SWEP.PrintName = "Glock 18"
	SWEP.IconLetter = "c"
	SWEP.Slot = 1
	SWEP.Slotpos = 0
	
end

SWEP.HoldType = "pistol"

SWEP.Base = "rad_base"

SWEP.ViewModel				= "models/weapons/tfa_csgo/c_glock18.mdl"
SWEP.WorldModel				= "models/weapons/tfa_csgo/w_glock18.mdl"

SWEP.ViewModelFlip 			= false
SWEP.ViewModelFOV 			= 60
SWEP.UseHands 				= true

SWEP.IsSniper = false
SWEP.AmmoType = "Pistol"

SWEP.Primary.Sound			= Sound( "tfa_csgo/glock18/glock18-1.wav" )
SWEP.Primary.Recoil			= 3
SWEP.Primary.Damage			= 28
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.0280
SWEP.Primary.Delay			= 0.15

SWEP.Primary.Ammo           = "Pistol"
SWEP.Primary.ClipSize		= 20
SWEP.Primary.Automatic		= false
