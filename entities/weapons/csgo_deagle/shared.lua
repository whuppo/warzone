if SERVER then

	AddCSLuaFile("shared.lua")
	
end

if CLIENT then

	SWEP.ViewModelFlip		= true
	
	SWEP.PrintName = "Desert Eagle"
	SWEP.IconLetter = "f"
	SWEP.Slot = 1
	SWEP.Slotpos = 0
	
end

SWEP.HoldType = "revolver"

SWEP.Base = "rad_base"

SWEP.ViewModel				= "models/weapons/tfa_csgo/c_deagle.mdl"
SWEP.WorldModel				= "models/weapons/tfa_csgo/w_deagle.mdl"

SWEP.ViewModelFlip 			= false
SWEP.ViewModelFOV 			= 60
SWEP.UseHands 				= true

SWEP.IsSniper = false
SWEP.AmmoType = "Pistol"

SWEP.Primary.Sound			= Sound( "tfa_csgo/deagle/deagle-1.wav" )
SWEP.Primary.Recoil			= 12
SWEP.Primary.Damage			= 63
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.042
SWEP.Primary.Delay			= 0.224719101123595

SWEP.Primary.Ammo           = "Pistol"
SWEP.Primary.ClipSize		= 7
SWEP.Primary.Automatic		= false