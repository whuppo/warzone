if SERVER then

	AddCSLuaFile("shared.lua")
	
end

if CLIENT then

	SWEP.ViewModelFlip		= true
	
	SWEP.PrintName = "MAG-7"
	SWEP.IconLetter = "k"
	SWEP.Slot = 0
	SWEP.Slotpos = 0
	
end

SWEP.HoldType = "pistol"

SWEP.Base = "rad_base"

SWEP.ViewModel				= "models/weapons/tfa_csgo/c_mag7.mdl"
SWEP.WorldModel				= "models/weapons/tfa_csgo/w_mag7.mdl"

SWEP.ViewModelFlip 			= false
SWEP.ViewModelFOV 			= 60
SWEP.UseHands 				= true

SWEP.IsSniper = false
SWEP.AmmoType = "Buckshot"

SWEP.Primary.Sound			= Sound( "tfa_csgo/mag7/mag7-1.wav" )
SWEP.Primary.Recoil			= 9
SWEP.Primary.Damage			= 30
SWEP.Primary.NumShots		= 8
SWEP.Primary.Cone			= 0.07
SWEP.Primary.Delay			= 0.845070422535211

SWEP.Primary.Ammo           = "Buckshot"
SWEP.Primary.ClipSize		= 5
SWEP.Primary.Automatic		= false

function SWEP:PrimaryAttack()

	if not self.Weapon:CanPrimaryAttack() then 
		
		self.Weapon:SetNextPrimaryFire( CurTime() + 0.5 )
		return 
		
	end

	self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
	self.Weapon:EmitSound( self.Primary.Sound, 100, math.random(95,105) )
	self.Weapon:ShootBullets( self.Primary.Damage, self.Primary.NumShots, self.Primary.Cone, self.Weapon:GetZoomMode() )
	self.Weapon:TakePrimaryAmmo( 1 )
	self.Weapon:ShootEffects()

end