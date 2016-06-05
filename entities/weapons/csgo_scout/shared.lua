if SERVER then

	AddCSLuaFile("shared.lua")
	
end

if CLIENT then

	SWEP.ViewModelFlip		= true
	
	SWEP.PrintName = "Steyr Scout"
	SWEP.IconLetter = "n"
	SWEP.Slot = 0
	SWEP.Slotpos = 0
	
end

SWEP.HoldType = "ar2"

SWEP.Base = "rad_base"

SWEP.ViewModel 			= "models/weapons/tfa_csgo/c_scout.mdl"
SWEP.WorldModel 		= "models/weapons/tfa_csgo/w_scout.mdl"

SWEP.ViewModelFlip 			= false
SWEP.ViewModelFOV 			= 60
SWEP.UseHands 				= true

SWEP.ZoomModes = { 0, 40, 10 }
SWEP.ZoomSpeeds = { 0.25, 0.40, 0.40 }

SWEP.IsSniper = true
SWEP.AmmoType = "Sniper"

SWEP.Primary.Sound			= Sound( "tfa_csgo/ssg08/ssg08-1.wav" )
SWEP.Primary.Recoil			= 6
SWEP.Primary.Damage			= 88
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.005
SWEP.Primary.SniperCone		= 0.317
SWEP.Primary.Delay			= 1.25

SWEP.Primary.Ammo           = "Sniper"
SWEP.Primary.ClipSize		= 10
SWEP.Primary.Automatic		= false
