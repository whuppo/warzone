surface.CreateFont( "Health",          { font = "Exo 2", size = 18 } )
surface.CreateFont( "HealthBG",        { font = "Exo 2", size = 18, blursize = 2 } )
surface.CreateFont( "PrimaryAmmo",     { font = "Exo 2", size = 80 } )
surface.CreateFont( "PrimaryAmmoBG",   { font = "Exo 2", size = 80, blursize = 6 } )
surface.CreateFont( "SecondaryAmmo",   { font = "Exo 2", size = 40 } )
surface.CreateFont( "SecondaryAmmoBG", { font = "Exo 2", size = 40, blursize = 6 } )

local gradientV = Material( "gui/gradient_up" )
local gradientV2 = Material( "gui/gradient_down" )

local HideHUD = {
	CHudHealth = true,
	CHudBattery = true,
	CHudAmmo = true,
	CHudSecondaryAmmo = true,
	CHudDamageIndicator = true
}

local hpdrain = {
	h = 0,
	w = 0,
	delay = 50,
	regen = 0
}

local ardrain = {
	h = 0,
	w = 0,
	delay = 50,
	regen = 0
}

local currentammo = {
	clip = 0,
	clipsize = 0,
	reserve = 0,
	warning = "RELOAD"
}

usermessage.Hook( "damage", function( msg )
	local dmg = msg:ReadShort()
	ardrain.delay = dmg * 5/3
	hpdrain.delay = dmg * 5/3
end )

hook.Add( "HUDShouldDraw", "HideHUD", function( name )
	if ( HideHUD[ name ] ) then return false end
end )

hook.Add( "HUDPaint", "cl_hud", function()
	--Health Bar
	local currenthp = LocalPlayer():Health()
	currenthp = math.Clamp( currenthp, 0, 100 )

	if hpdrain.w > currenthp then
		if hpdrain.delay <= 0 then
			hpdrain.w = Lerp( FrameTime() * 2, hpdrain.w, currenthp )
		else
		    hpdrain.delay = hpdrain.delay - 1
		end
	elseif hpdrain.w > currenthp + 0.1 then
		hpdrain.w = currenthp
		hpdrain.delay = 50
	else
	    hpdrain.w = currenthp
		hpdrain.delay = 50
	end

	if hpdrain.w > currenthp + 1 then
		hpdrain.h = 20
	else
	    hpdrain.h = Lerp( FrameTime() * 5, hpdrain.h, 0 )
	end

	surface.SetDrawColor( Color( 0, 0, 0, 200 ) )
	surface.DrawRect( ScrW() - 303, ScrH() - 106, 232, 10 )

	surface.SetDrawColor( Color( 255, 255, 255, 255 ) )
	surface.DrawRect( ScrW() - 303 + ( 232 - ( 232 * ( currenthp / 100 ) ) ), ScrH() - 106, 232 - ( 232 - ( 232 * ( currenthp / 100 ) ) ), 10 )
	
	if hpdrain.w > currenthp then
		surface.SetDrawColor( Color( 200, 0, 0, 255 ) )
		surface.SetMaterial( gradientV )
		surface.DrawTexturedRect( ScrW() - 303 + ( 232 - ( 232 * ( hpdrain.w / 100 ) ) ), ScrH() - 96 - hpdrain.h, 232 - ( 232 - ( 232 * ( hpdrain.w / 100 ) ) ) - ( 232 * ( currenthp / 100 ) ), hpdrain.h )
	end

	//Armor
	local currentar = LocalPlayer():Armor()
	currentar = math.Clamp( currentar, 0, 100 )

	if ardrain.w > currentar then
		if ardrain.delay <= 0 then
			ardrain.w = Lerp( FrameTime() * 2, ardrain.w, currentar )
		else
		    ardrain.delay = ardrain.delay - 1
		end
	elseif ardrain.w > currentar + 0.1 then
		ardrain.w = currentar
		ardrain.delay = 50
	else
	    ardrain.w = currentar
		ardrain.delay = 50
	end

	if ardrain.w > currentar + 1 then
		ardrain.h = 20
	else
	    ardrain.h = Lerp( FrameTime() * 5, ardrain.h, 0 )
	end

	surface.SetDrawColor( Color( 0, 255, 255, 200 ) )
	surface.DrawRect( ScrW() - 303 + ( 232 - ( 232 * ( currentar / 100 ) ) ), ScrH() - 106, 232 - ( 232 - ( 232 * ( currentar / 100 ) ) ), 10 )
	
	if ardrain.w > currentar then
		surface.SetDrawColor( Color( 200, 0, 0, 255 ) )
		surface.SetMaterial( gradientV )
		surface.DrawTexturedRect( ScrW() - 303 + ( 232 - ( 232 * ( ardrain.w / 100 ) ) ), ScrH() - 96 - ardrain.h, 232 - ( 232 - ( 232 * ( ardrain.w / 100 ) ) ) - ( 232 * ( currenthp / 100 ) ), hpdrain.h )
	end

	//measuring thing
	surface.SetDrawColor( Color( 255, 255, 255, 255 ) )
	surface.DrawRect( ScrW() - 303, ScrH() - 96, 232, 2 )

	for i = 0, 4 do
		draw.SimpleText( LocalPlayer():Health() .. " HEALTH", "HealthBG", ScrW() - 74, ScrH() - 94, Color( 0, 0, 0, 255 ), TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP )
	end
	draw.SimpleText( LocalPlayer():Health() .. " HEALTH", "Health", ScrW() - 74, ScrH() - 94, Color( 255, 255, 255, 200 ), TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP )

	--draw.SimpleText( LocalPlayer():GetNWFloat( "NextRegen" ), "Health", ScrW() / 2, ScrH() / 2, Color( 255, 255, 255, 200 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

	if LocalPlayer():GetNWFloat( "NextRegen" ) then
		surface.SetDrawColor( Color( 0, 255, 255, 255 ) )
		surface.SetMaterial( gradientV2 )
		surface.DrawTexturedRect( ScrW() - 303 + ( 232 - ( 232 * ( ( LocalPlayer():GetNWFloat( "NextRegen" )- CurTime() ) / 5 ) ) ), ScrH() - 96, 232 - ( 232 - ( 232 * ( ( LocalPlayer():GetNWFloat( "NextRegen" ) - CurTime() ) / 5 ) ) ), 20 )
	end

	if LocalPlayer():GetNWFloat( "NextRegen" ) ~= 0 and LocalPlayer():GetNWFloat( "NextRegen" ) <= CurTime() then
		hpdrain.regen = 1
	end

	surface.SetDrawColor( Color( 0, 255, 255, 255 * hpdrain.regen ) )
	hpdrain.regen = Lerp( FrameTime() * 10/3, hpdrain.regen, 0 )
	surface.DrawRect( ScrW() - 303, ScrH() - 106, 232, 12 )

	--Ammo Counter (version 1)
	/*
	if IsValid( LocalPlayer():GetActiveWeapon() ) then
		currentammo.clip = LocalPlayer():GetActiveWeapon():Clip1()
		currentammo.reserve = LocalPlayer():GetAmmoCount( LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType() )
	end
	for i = 0, 2 do
		draw.SimpleText( currentammo.clip, "PrimaryAmmoBG", ScrW() - 150, ScrH() - 104, Color( 0, 0, 0, 255 ), TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM )
	end
	draw.SimpleText( currentammo.clip, "PrimaryAmmo", ScrW() - 150, ScrH() - 104, Color( 255, 255, 255, 200 ), TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM )

	for i = 0, 4 do
		draw.SimpleText( "/ " .. currentammo.reserve, "SecondaryAmmoBG", ScrW() - 150, ScrH() - 110, Color( 0, 0, 0, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM )
	end
	draw.SimpleText( "/ " .. currentammo.reserve, "SecondaryAmmo", ScrW() - 150, ScrH() - 110, Color( 255, 255, 255, 200 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM )
	*/

	--Ammo Counter (version 2)
	if IsValid( LocalPlayer():GetActiveWeapon() ) then
		currentammo.clip = LocalPlayer():GetActiveWeapon():Clip1()
		currentammo.clipsize = LocalPlayer():GetActiveWeapon():GetMaxClip1()
		currentammo.reserve = LocalPlayer():GetAmmoCount( LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType() )

		for i = 0, 4 do
			draw.SimpleText( currentammo.clip .. " / " .. currentammo.reserve, "HealthBG", ScrW() - 74, ScrH() - 144, Color( 0, 0, 0, 255 ), TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP )
		end
		draw.SimpleText( currentammo.clip .. " / " .. currentammo.reserve, "Health", ScrW() - 74, ScrH() - 144, Color( 255, 255, 255, 200 ), TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP )
	
		for i = 0, currentammo.clipsize - 1 do
			surface.SetDrawColor( Color( 0, 0, 0, 200 ) )
			surface.DrawRect( ScrW() - 306 + ( i * ( 232 / currentammo.clipsize ) ) + ( ( 232 / currentammo.clipsize ) / 2 ), ScrH() - 160, ( 232 / currentammo.clipsize ) / 2, 16 )
		end

		surface.SetDrawColor( Color( 255, 255, 255, 255 ) )
		for i = currentammo.clipsize - currentammo.clip, currentammo.clipsize - 1 do
			if currentammo.clip < currentammo.clipsize / 2 then
				surface.SetDrawColor( Color( 255, 128 * ( math.sin( RealTime() * 4 + ( i / 2 ) ) * 0.5 + 0.5 ), 128 * ( math.sin( RealTime() * 4 + ( i / 2 ) ) * 0.5 + 0.5 ), 255 ) )
			end
			surface.DrawRect( ScrW() - 306 + ( i * ( 232 / currentammo.clipsize ) ) + ( ( 232 / currentammo.clipsize ) / 2 ), ScrH() - 160, ( 232 / currentammo.clipsize ) / 2, 16 )
		end

		if currentammo.reserve <= 0 && currentammo.clip <= 0 then
			currentammo.warning = "OUT OF AMMO"
		elseif currentammo.reserve <= 0 then
			currentammo.warning = "ALMOST OUT OF AMMO"
		else
			currentammo.warning = "RELOAD"
		end

		if currentammo.clip < currentammo.clipsize / 2 then
			for i = 0, 1 do
				draw.SimpleText( currentammo.warning, "HealthBG", ScrW() - 306, ScrH() - 144, Color( 0, 0, 0, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )
			end
			draw.SimpleText( currentammo.warning, "Health", ScrW() - 306, ScrH() - 144, Color( 255, 128 * ( math.sin( RealTime() * 6 ) * 0.5 + 0.5 ), 128 * ( math.sin( RealTime() * 6 ) * 0.5 + 0.5 ), 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )
		end
	end

end )