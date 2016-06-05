if SERVER then

	AddCSLuaFile("shared.lua")
	
end

if CLIENT then

	SWEP.ViewModelFlip		= true
	
	SWEP.PrintName = "AWP"
	SWEP.IconLetter = "r"
	SWEP.Slot = 0
	SWEP.Slotpos = 0
	
end

SWEP.HoldType = "ar2"

SWEP.Base = "rad_base"

SWEP.ViewModel 				= "models/weapons/tfa_csgo/c_awp.mdl"
SWEP.WorldModel 			= "models/weapons/tfa_csgo/w_awp.mdl"

SWEP.ViewModelFlip 			= false
SWEP.ViewModelFOV 			= 60
SWEP.UseHands 				= true

SWEP.ZoomModes = { 0, 35, 5 }
SWEP.ZoomSpeeds = { 0.25, 0.30, 0.30 }

SWEP.IsSniper = true
SWEP.AmmoType = "Sniper"

SWEP.Primary.Sound 			= Sound( "tfa_csgo/awp/awp1.wav" )
SWEP.Primary.Recoil			= 6
SWEP.Primary.Damage			= 25000
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.005
SWEP.Primary.SniperCone     = 0.8080
SWEP.Primary.Delay			= 1.463414634146341

SWEP.Primary.Ammo           = "Sniper"
SWEP.Primary.ClipSize		= 10
SWEP.Primary.Automatic		= false

SWEP.MinShellDelay = 0.8
SWEP.MaxShellDelay = 1.0
