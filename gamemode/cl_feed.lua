surface.CreateFont( "Feed", { font = "Exo 2", size = 24 } )
surface.CreateFont( "FeedBG", { font = "Exo 2", size = 24, blursize = 3 } )
surface.CreateFont( "Acolytes", { font = "Exo 2", size = 16 } )
surface.CreateFont( "AcolytesBG", { font = "Exo 2", size = 16, blursize = 3 } )

PlayerFeed = {}
PlayerFeed.delay = 0
PlayerFeed.points = 0
PlayerFeed.display = 0

--acolyte related
PlayerFeed.current = 1
PlayerFeed.acodelay = 0

function surface.DrawScaledRect( originX, originY, width, height, scale )
	local scaledwidth, scaledheight = width * scale, height * scale
	surface.DrawRect( originX - scaledwidth / 2, originY - scaledheight / 2, scaledwidth, scaledheight )
end

net.Receive( "PlayerFeed", function()
	local toinsert = {
		text = net.ReadString(),
		col = net.ReadColor(),
		acolytes = net.ReadTable(),
	}
	toinsert[ "delay" ] = 4 / #toinsert.acolytes

	table.insert( PlayerFeed, toinsert )
	--PrintTable( PlayerFeed )
end )

hook.Add( "Think", "cl_feed_delay", function()
	if PlayerFeed[ 1 ] then
		PlayerFeed.display = math.Approach( PlayerFeed.display, PlayerFeed.points, 4 )

		if PlayerFeed.delay == 0 then
			PlayerFeed.delay = CurTime() + 6
			PlayerFeed.current = 0
			PlayerFeed.acodelay = CurTime() + 1
		end

		if PlayerFeed.acodelay <= CurTime() and PlayerFeed.acodelay ~= 0 then
			PlayerFeed.current = PlayerFeed.current + 1
			if PlayerFeed[ 1 ].acolytes[ PlayerFeed.current ] then
				PlayerFeed.acodelay = CurTime() + PlayerFeed[ 1 ].delay
				PlayerFeed.points = PlayerFeed.points + PlayerFeed[ 1 ].acolytes[ PlayerFeed.current ].points
			end
		end
	end

	if PlayerFeed.delay <= CurTime() then
		table.remove( PlayerFeed, 1 )
		PlayerFeed.delay = 0
		PlayerFeed.current = 0
		PlayerFeed.acodelay = 0
		PlayerFeed.points = 0
		PlayerFeed.display = 0
	end
end )

hook.Add( "HUDPaint", "cl_feed_draw", function()
	if PlayerFeed[ 1 ] then
		surface.SetFont( "Feed" )
		local width, height = surface.GetTextSize( PlayerFeed[ 1 ].text )
		local timedif = PlayerFeed.delay - CurTime()
		--#PlayerFeed[1].acolytes now PlayerFeed[1].delay

		--notif animations
		local bgalpha  = math.Clamp( ( -2 * ( timedif - 3 ) ^ 2 + 18 ) / 6, 0, 1 ) -- -2(a - 3)^2 + 18
		local bgscale  = math.Clamp( ( ( timedif - 5.5 ) ^ 3 * 48 ) / 6, 0, 1 ) -- (a - 5.5)^3 * 48
		local totpoint = math.Clamp( ( ( timedif - 5 ) ^ 3 * 48 ) / 6, 0, 1 ) -- (a - 5)^2 * 48

		surface.SetDrawColor( PlayerFeed[ 1 ].col.r, PlayerFeed[ 1 ].col.g, PlayerFeed[ 1 ].col.b, PlayerFeed[ 1 ].col.a * bgalpha )
		surface.DrawScaledRect( ScrW() / 2 - ( width / 2 ) - 12, ScrH() - ScrH() / 3 + ( height / 2 ), width + 12, height + 3, 1 + 2 * bgscale )

		for i = 0, 4 do
			draw.SimpleText( PlayerFeed[ 1 ].text, "FeedBG", ScrW() / 2 - 12, ScrH() - ScrH() / 3, Color( 0, 0, 0, 255 * bgalpha ), TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP )
		end
		draw.SimpleText( PlayerFeed[ 1 ].text, "Feed", ScrW() / 2 - 12, ScrH() - ScrH() / 3, Color( 255, 255, 255, 255 * bgalpha ), TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP )

		if timedif <= 5.5 then
			for i = 0, 4 do
				draw.SimpleText( PlayerFeed.display, "FeedBG", ScrW() / 2 + 12 + ( 32 * totpoint ), ScrH() - ScrH() / 3, Color( 0, 0, 0, 255 * bgalpha ), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )
			end
			draw.SimpleText( PlayerFeed.display, "Feed", ScrW() / 2 + 12 + ( 32 * totpoint ), ScrH() - ScrH() / 3, Color( 255, 255, 255, 255 * bgalpha ), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )
		end

		--acolytes
		local acodif = PlayerFeed.acodelay - CurTime()

		local acoalpha = math.Clamp( ( -1 * ( 5 - PlayerFeed[ 1 ].delay ) * ( acodif - ( PlayerFeed[ 1 ].delay / 2 ) ) ^ 2 ) + PlayerFeed[ 1 ].delay, 0, 1 )
		--weird things start happening after 5 or more acolytes
		-- -(5-b)(b2-b/2)^2+b

		if timedif <= 5 and PlayerFeed.current ~= 0 and PlayerFeed.current <= #PlayerFeed[ 1 ].acolytes then
			for i = 0, 4 do
				draw.SimpleText( PlayerFeed[ 1 ].acolytes[ PlayerFeed.current ].name, "AcolytesBG", ScrW() / 2 - 6, ScrH() - ScrH() / 3 + 28, Color( 0, 0, 0, 255 * acoalpha ), TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP )
			end
			draw.SimpleText( PlayerFeed[ 1 ].acolytes[ PlayerFeed.current ].name, "Acolytes", ScrW() / 2 - 6, ScrH() - ScrH() / 3 + 28, Color( 255, 255, 255, 255 * acoalpha ), TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP )

			for i = 0, 4 do
				draw.SimpleText( PlayerFeed[ 1 ].acolytes[ PlayerFeed.current ].points, "AcolytesBG", ScrW() / 2 + 12, ScrH() - ScrH() / 3 + 28, Color( 0, 0, 0, 255 * acoalpha ), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )
			end
			draw.SimpleText( PlayerFeed[ 1 ].acolytes[ PlayerFeed.current ].points, "Acolytes", ScrW() / 2 + 12, ScrH() - ScrH() / 3 + 28, Color( 255, 255, 255, 255 * acoalpha ), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )
		end
	end
end )