if SERVER then

	AddCSLuaFile("shared.lua")
	
end

if CLIENT then

	SWEP.ViewModelFlip		= false
	
	SWEP.PrintName = "FAMAS"
	SWEP.IconLetter = "v"
	SWEP.Slot = 0
	SWEP.Slotpos = 0

end

SWEP.HoldType = "ar2"

SWEP.Base = "rad_base"

SWEP.ViewModel				= "models/weapons/tfa_csgo/c_famas.mdl"
SWEP.WorldModel				= "models/weapons/tfa_csgo/w_famas.mdl"

SWEP.ViewModelFlip 			= false
SWEP.ViewModelFOV 			= 60
SWEP.UseHands 				= true

SWEP.IsSniper = false
SWEP.AmmoType = "Rifle"

SWEP.Primary.Sound			= Sound( "csgo/famas/famas-1.wav" )
SWEP.Primary.Recoil			= 6
SWEP.Primary.Damage			= 30
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.0685
SWEP.Primary.Delay			= 0.089955022488755

SWEP.Primary.Ammo           = "Rifle"
SWEP.Primary.ClipSize		= 25
SWEP.Primary.Automatic		= true
