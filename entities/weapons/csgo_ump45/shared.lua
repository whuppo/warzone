if SERVER then

	AddCSLuaFile("shared.lua")
	
end

if CLIENT then

	SWEP.ViewModelFlip		= true
	
	SWEP.PrintName = "HK UMP45"
	SWEP.IconLetter = "q"
	SWEP.Slot = 0
	SWEP.Slotpos = 0
	
end

SWEP.HoldType = "smg"

SWEP.Base = "rad_base"

SWEP.ViewModel				= "models/weapons/tfa_csgo/c_ump45.mdl"
SWEP.WorldModel				= "models/weapons/tfa_csgo/w_ump45.mdl"

SWEP.ViewModelFlip 			= false
SWEP.ViewModelFOV 			= 60
SWEP.UseHands 				= true

SWEP.IsSniper = false
SWEP.AmmoType = "SMG"

SWEP.Primary.Sound			= Sound( "tfa_csgo/ump45/ump45-1.wav" )
SWEP.Primary.Recoil			= 6
SWEP.Primary.Damage			= 35
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.1343
SWEP.Primary.Delay			= 0.089955022488755

SWEP.Primary.Ammo           = "SMG"
SWEP.Primary.ClipSize		= 25
SWEP.Primary.Automatic		= true
