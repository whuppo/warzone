if SERVER then

	AddCSLuaFile("shared.lua")
	
end

if CLIENT then
	
	SWEP.PrintName = "AK-47"
	SWEP.IconLetter = "b"
	SWEP.Slot = 0
	SWEP.Slotpos = 0
	
end

SWEP.HoldType = "ar2"

SWEP.Base = "rad_base"

SWEP.ViewModel				= "models/weapons/tfa_csgo/c_ak47.mdl"
SWEP.WorldModel				= "models/weapons/tfa_csgo/w_ak47.mdl"

SWEP.ViewModelFlip 			= false
SWEP.ViewModelFOV 			= 60
SWEP.UseHands 				= true

SWEP.IsSniper = false
SWEP.AmmoType = "Rifle"

SWEP.Primary.Sound 			= Sound( "tfa_csgo/ak47/ak47-1.wav" )
SWEP.Primary.Recoil			= 6
SWEP.Primary.Damage			= 36
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.0641
SWEP.Primary.Delay			= 0.100

SWEP.Primary.Ammo           = "Rifle"
SWEP.Primary.ClipSize		= 30
SWEP.Primary.Automatic		= true
