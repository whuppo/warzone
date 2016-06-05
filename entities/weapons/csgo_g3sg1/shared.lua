if SERVER then

	AddCSLuaFile("shared.lua")
	
end

if CLIENT then

	SWEP.ViewModelFlip		= true
	
	SWEP.PrintName = "G3SG1"
	SWEP.IconLetter = "i"
	SWEP.Slot = 0
	SWEP.Slotpos = 0
	
end

SWEP.HoldType = "ar2"

SWEP.Base = "rad_base"

SWEP.ViewModel 				= "models/weapons/tfa_csgo/c_g3sg1.mdl"
SWEP.WorldModel 			= "models/weapons/tfa_csgo/w_g3sg1.mdl"

SWEP.ViewModelFlip 			= false
SWEP.ViewModelFOV 			= 60
SWEP.UseHands 				= true

SWEP.ZoomModes = { 0, 35, 10 }
SWEP.ZoomSpeeds = { 0.25, 0.40, 0.40 }

SWEP.IsSniper = true
SWEP.AmmoType = "Sniper"

SWEP.Primary.Sound			= Sound( "tfa_csgo/g3sg1/g3sg1-1.wav" )
SWEP.Primary.Recoil			= 6
SWEP.Primary.Damage			= 80
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.005
SWEP.Primary.SniperCone		= 0.2580
SWEP.Primary.Delay			= 0.25

SWEP.Primary.Ammo           = "Sniper"
SWEP.Primary.ClipSize		= 20
SWEP.Primary.Automatic		= true

function SWEP:PrimaryAttack()

	if not self.Weapon:CanPrimaryAttack() then 
		
		self.Weapon:SetNextPrimaryFire( CurTime() + 0.25 )
		
		return 
		
	end

	self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
	self.Weapon:EmitSound( self.Primary.Sound, 100, math.random(95,105) )
	self.Weapon:SetClip1( self.Weapon:Clip1() - self.Primary.NumShots )
	self.Weapon:ShootEffects()
	
	if self.IsSniper and self.Weapon:GetZoomMode() == 1 then
	
		self.Weapon:ShootBullets( self.Primary.Damage, self.Primary.NumShots, self.Primary.SniperCone, 1 )
	
	else
	
		self.Weapon:ShootBullets( self.Primary.Damage, self.Primary.NumShots, self.Primary.Cone, self.Weapon:GetZoomMode() )
	
	end

end