if SERVER then

	AddCSLuaFile("shared.lua")
	
end

if CLIENT then

	SWEP.ViewModelFlip		= true
	
	SWEP.PrintName = "Tec-9"
	SWEP.IconLetter = "c"
	SWEP.Slot = 1
	SWEP.Slotpos = 0
	
end

SWEP.HoldType = "pistol"

SWEP.Base = "rad_base"

SWEP.ViewModel				= "models/weapons/tfa_csgo/c_tec9.mdl"
SWEP.WorldModel				= "models/weapons/tfa_csgo/w_tec9.mdl"

SWEP.ViewModelFlip 			= false
SWEP.ViewModelFOV 			= 60
SWEP.UseHands 				= true

SWEP.IsSniper = false
SWEP.AmmoType = "Pistol"

SWEP.Primary.Sound			= Sound( "tfa_csgo/tec9/tec9-1.wav" )
SWEP.Primary.Recoil			= 6
SWEP.Primary.Damage			= 33
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.04715
SWEP.Primary.Delay			= 0.12

SWEP.Primary.Ammo           = "Pistol"
SWEP.Primary.ClipSize		= 32
SWEP.Primary.Automatic		= false
