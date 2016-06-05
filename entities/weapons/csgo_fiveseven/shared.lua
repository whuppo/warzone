if SERVER then

	AddCSLuaFile("shared.lua")
	
end

if CLIENT then

	SWEP.ViewModelFlip		= true
	
	SWEP.PrintName = "FN Five-Seven"
	SWEP.IconLetter = "y"
	SWEP.Slot = 1
	SWEP.Slotpos = 0
	
end

SWEP.HoldType = "pistol"

SWEP.Base = "rad_base"

SWEP.ViewModel				= "models/weapons/tfa_csgo/c_fiveseven.mdl"
SWEP.WorldModel				= "models/weapons/tfa_csgo/w_fiveseven.mdl"

SWEP.ViewModelFlip 			= false
SWEP.ViewModelFOV 			= 60
SWEP.UseHands 				= true

SWEP.IsSniper = false
SWEP.AmmoType = "Pistol"

SWEP.Primary.Sound			= Sound( "tfa_csgo/fiveseven/fiveseven-1.wav")
SWEP.Primary.Recoil			= 3
SWEP.Primary.Damage			= 32
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.0455
SWEP.Primary.Delay			= 0.15

SWEP.Primary.Ammo           = "Pistol"
SWEP.Primary.ClipSize		= 20
SWEP.Primary.Automatic		= false
