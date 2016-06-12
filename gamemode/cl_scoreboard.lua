surface.CreateFont( "TeamHeader", { font = "Exo 2", size = 28 } )
surface.CreateFont( "TeamHeaderBG", { font = "Exo 2", size = 28, blursize = 6 } )
surface.CreateFont( "TeamScore", { font = "Exo 2", size = 42 } )
surface.CreateFont( "TeamScoreBG", { font = "Exo 2", size = 42, blursize = 6 } )
surface.CreateFont( "PlayerHeader", { font = "Exo 2", size = 19 } )
surface.CreateFont( "PlayerHeaderBG", { font = "Exo 2", size = 19, blursize = 3 } )

local playerlistred
local playerlistblue

local blueteamico = Material( "warzone/blueteam.png", "smooth mips" )
local redteamico  = Material( "warzone/redteam.png", "smooth mips" )
local warzoneico  = Material( "warzone/warzone.png", "smooth mips" )
local blurTex = Material( "pp/blurscreen" )

local TeamColor = {}
TeamColor.red = {
	Color( 135, 62, 47 ),
	Color( 58, 25, 20 ),
	Color( 25, 9, 9 )
}
TeamColor.blue = {
	Color( 48, 92, 137 ),
	Color( 22, 39, 57 ),
	Color( 10, 17, 25 )
}

function team.GetSortedPlayers( tea )
	local tab = team.GetPlayers( tea )
	table.sort( tab, function( a, b ) return a:Frags() > b:Frags() end )
	return tab
end

function draw.ScoreboardTriangle( x, y )
	local tri = {}

	table.insert( tri, { x = x, y = y } )
	table.insert( tri, { x = x + 21, y = y + 21 } )
	table.insert( tri, { x = x, y = y + 42 } )

	surface.DrawPoly( tri )
end 

local function CreateScoreboard()
	caption = vgui.Create( "DFrame" )
	caption:ShowCloseButton( false )
	caption:SetDraggable( false )
	caption:SetTitle( "" )
	caption:SetSize( ScrW(), ScrH() * 0.15 )
	caption.Paint = function()
		local captiontext = "DEVELOPER MODE" .. " | " .. string.upper( game.GetMap() )
		surface.SetFont( "PlayerHeader" )
		local width = surface.GetTextSize( captiontext )
		surface.SetFont( "TeamHeader" )
		width = width + surface.GetTextSize( "WARZONE" )
		width = width + 24 + 12 + 50

		for i = 0, 4 do
			draw.SimpleText( captiontext, "PlayerHeaderBG", caption:GetWide() / 2 + width / 2, caption:GetTall() - 25, Color( 0, 0, 0, 255 ), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
			draw.SimpleText( "WARZONE", "TeamHeaderBG", caption:GetWide() / 2 - width / 2 + 50 + 12, caption:GetTall() - 25, Color( 0, 0, 0, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
		end
		draw.SimpleText( captiontext, "PlayerHeader", caption:GetWide() / 2 + width / 2, caption:GetTall() - 25, Color( 200, 200, 200, 200 ), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
		draw.SimpleText( "WARZONE", "TeamHeader", caption:GetWide() / 2 - width / 2 + 50 + 12, caption:GetTall() - 25, Color( 225, 225, 225, 200 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.SetMaterial( warzoneico )
		surface.DrawTexturedRect( caption:GetWide() / 2 - width / 2, caption:GetTall() - 50, 50, 50 )
	end

	blue = vgui.Create( "DFrame" )
	blue:ShowCloseButton( false )
	blue:SetDraggable( false )
	blue:SetTitle( "" )
	blue:SetSize( ScrW() * ( 9/20 ), ScrH() * ( 2/3 ) )
	blue:Center()
	function blue:Init()
		self.startTime = SysTime()
	end
	function blue:Paint()
		Derma_DrawBackgroundBlur( self, self.startTime )

		surface.SetDrawColor( TeamColor.blue[2] )
		surface.DrawRect( blue:GetWide() / 2, 0, blue:GetWide() / 2, 88 )
		for i = 0, 6 do
			draw.SimpleText( "BLUE", "TeamHeaderBG", blue:GetWide() / 2 + 132, 88 / 2, Color( 0, 0, 0, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
			draw.SimpleText( team.TotalFrags( 2 ), "TeamScoreBG", blue:GetWide() - 24, 88 / 2, Color( 0, 0, 0, 255 ), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
		end
		draw.SimpleText( "BLUE", "TeamHeader", blue:GetWide() / 2 + 132, 88 / 2, Color( 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
		draw.SimpleText( team.TotalFrags( 2 ), "TeamScore", blue:GetWide() - 24, 88 / 2, Color( 255, 255, 255 ), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
		surface.SetDrawColor( TeamColor.blue[3] )
		surface.DrawRect( blue:GetWide() / 2, 6, blue:GetWide() / 2 / 10, 82 )
		surface.SetDrawColor( TeamColor.blue[1] )
		surface.DrawRect( blue:GetWide() / 2 + blue:GetWide() / 2 / 10, 0, math.Round( blue:GetWide() / 2 - blue:GetWide() / 2 / 10 ), 6 )
		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.SetMaterial( blueteamico )
		surface.DrawTexturedRect( blue:GetWide() / 2 + blue:GetWide() / 2 / 10 + 12, 14, 60, 60 )

		for i = 0, 4 do
			draw.SimpleText( "#", "PlayerHeaderBG", 42 / 2, 176 - 42 / 2, Color( 0, 0, 0, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM )
			draw.SimpleText( "PLAYER", "PlayerHeaderBG", 96, 176 - 42 / 2, Color( 0, 0, 0, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM )
			draw.SimpleText( "FRAGS", "PlayerHeaderBG", blue:GetWide() * ( 3 / 4 ), 176 - 42 / 2, Color( 0, 0, 0, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM )
		end
		draw.SimpleText( "#", "PlayerHeader", 42 / 2, 176 - 42 / 2, Color( 255, 255, 255, 200 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM )
		draw.SimpleText( "PLAYER", "PlayerHeader", 96, 176 - 42 / 2, Color( 255, 255, 255, 200 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM )
		draw.SimpleText( "FRAGS", "PlayerHeader", blue:GetWide() * ( 3 / 4 ), 176 - 42 / 2, Color( 255, 255, 255, 200 ),TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM )

		surface.SetDrawColor( TeamColor.blue[2] )
		surface.DrawRect( 0, 176, blue:GetWide(), 6 )
		surface.SetDrawColor( TeamColor.blue[1] )
		surface.DrawRect( 42, 176, blue:GetWide() / 2 - 42, 6 )
	end

	blue:ParentToHUD()
	local pos = Vector( blue:GetPos() )
	blue:SetPos( pos.x - ( blue:GetWide() / 2 ) - 12, pos.y )

	blue.Think = function()
		if input.IsMouseDown( MOUSE_RIGHT ) then
			blue:MakePopup()
			red:MakePopup()
		end
	end

	playerlistblue = vgui.Create( "DListLayout", blue )
	playerlistblue:SetPos( 0, 184 )
	playerlistblue:SetSize( blue:GetWide(), blue:GetTall() - 184 )

	red = vgui.Create( "DFrame" )
	red:ShowCloseButton( false )
	red:SetDraggable( false )
	red:SetTitle( "" )
	red:SetSize( ScrW() * ( 9/20 ), ScrH() * ( 2/3 ) )
	red:Center()
	red.Paint = function()
		surface.SetDrawColor( TeamColor.red[2] )
		surface.DrawRect( 0, 0, red:GetWide() / 2, 88 )
		for i = 0, 6 do
			draw.SimpleText( "RED", "TeamHeaderBG", red:GetWide() / 2 - 132, 88 / 2, Color( 0, 0, 0, 255 ), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
			draw.SimpleText( team.TotalFrags( 1 ), "TeamScoreBG", 24, 88 / 2, Color( 0, 0, 0, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
		end
		draw.SimpleText( "RED", "TeamHeader", red:GetWide() / 2 - 132, 88 / 2, Color( 255, 255, 255 ), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
		draw.SimpleText( team.TotalFrags( 1 ), "TeamScore", 24, 88 / 2, Color( 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
		surface.SetDrawColor( TeamColor.red[3] )
		surface.DrawRect( math.Round( red:GetWide() / 2 - red:GetWide() / 2 / 10 ), 6, red:GetWide() / 2 / 10, 82 )
		surface.SetDrawColor( TeamColor.red[1] )
		surface.DrawRect( 0, 0, math.Round( red:GetWide() / 2 - red:GetWide() / 2 / 10 ), 6 )
		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.SetMaterial( redteamico )
		surface.DrawTexturedRect( red:GetWide() / 2 - red:GetWide() / 2 / 10 - 72, 14, 60, 60 )

		for i = 0, 4 do
			draw.SimpleText( "#", "PlayerHeaderBG", 42 / 2, 176 - 42 / 2, Color( 0, 0, 0, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM )
			draw.SimpleText( "PLAYER", "PlayerHeaderBG", 96, 176 - 42 / 2, Color( 0, 0, 0, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM )
			draw.SimpleText( "FRAGS", "PlayerHeaderBG", red:GetWide() * ( 3 / 4 ), 176 - 42 / 2, Color( 0, 0, 0, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM )
		end
		draw.SimpleText( "#", "PlayerHeader", 42 / 2, 176 - 42 / 2, Color( 255, 255, 255, 200 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM )
		draw.SimpleText( "PLAYER", "PlayerHeader", 96, 176 - 42 / 2, Color( 255, 255, 255, 200 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM )
		draw.SimpleText( "FRAGS", "PlayerHeader", red:GetWide() * ( 3 / 4 ), 176 - 42 / 2, Color( 255, 255, 255, 200 ),TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM )

		surface.SetDrawColor( TeamColor.red[2] )
		surface.DrawRect( 0, 176, red:GetWide(), 6 )
		surface.SetDrawColor( TeamColor.red[1] )
		surface.DrawRect( 42, 176, red:GetWide() / 2 - 42, 6 )
	end

	red:ParentToHUD()
	local pos = Vector( red:GetPos() )
	red:SetPos( pos.x + ( red:GetWide() / 2 ) + 12, pos.y )

	playerlistred = vgui.Create( "DListLayout", red )
	playerlistred:SetPos( 0, 184 )
	playerlistred:SetSize( red:GetWide(), red:GetTall() - 184 )

	for k, v in next, team.GetSortedPlayers( 1 ) do
		local p = vgui.Create( "DPanel" )
		p:SetSize( red:GetWide(), 44 )
		p.Paint = function()
			if v == LocalPlayer() then
				surface.SetDrawColor( TeamColor.red[2].r, TeamColor.red[2].g, TeamColor.red[2].b, 200 )
				surface.DrawRect( 0, 0, 42, 42 )
				surface.DrawRect( red:GetWide() / 2, 0, red:GetWide() / 2, 42 )
				surface.SetDrawColor( TeamColor.red[1].r, TeamColor.red[1].g, TeamColor.red[1].b, 255 )
				surface.DrawRect( 42, 0, red:GetWide() / 2 - 42, 42 )
				draw.NoTexture()
				draw.ScoreboardTriangle( red:GetWide() / 2, 0 )
			else
				surface.SetDrawColor( 0, 0, 0, 200 )
				surface.DrawRect( 0, 0, 42, 42 )
				surface.DrawRect( red:GetWide() / 2, 0, red:GetWide() / 2, 42 )
				surface.SetDrawColor( 32, 32, 32, 200 )
				surface.DrawRect( 42, 0, red:GetWide() / 2 - 42, 42 )
			end

			for i = 0, 4 do
				draw.SimpleText( k, "PlayerHeader", 42 / 2, 42 / 2 - 2, Color( 0, 0, 0, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
				draw.SimpleText( v:Nick(), "PlayerHeaderBG", 94, 42 / 2 - 2, Color( 0, 0, 0, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
				draw.SimpleText( v:Frags(), "PlayerHeaderBG", red:GetWide() * ( 3 / 4 ), 42 / 2 - 2, Color( 0, 0, 0, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			end
			draw.SimpleText( k, "PlayerHeader", 42 / 2, 42 / 2 - 2, Color( 255, 255, 255, 200 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			draw.SimpleText( v:Nick(), "PlayerHeader", 94, 42 / 2 - 2, Color( 255, 255, 255, 200 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
			draw.SimpleText( v:Frags(), "PlayerHeader", red:GetWide() * ( 3 / 4 ), 42 / 2 - 2, Color( 255, 255, 255, 200 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end

		if !v:IsBot() then
			local a = p:Add( "AvatarImage" )
			a:SetPos( 42, 0 )
			a:SetSize( 42, 42 )
			a:SetPlayer( v )
		end

		playerlistred:Add( p )
	end

	for k, v in next, team.GetSortedPlayers( 2 ) do
		local p = vgui.Create( "DPanel" )
		p:SetSize( blue:GetWide(), 44 )
		p.Paint = function()
			if v == LocalPlayer() then
				surface.SetDrawColor( TeamColor.blue[2].r, TeamColor.blue[2].g, TeamColor.blue[2].b, 200 )
				surface.DrawRect( 0, 0, 42, 42 )
				surface.DrawRect( blue:GetWide() / 2, 0, blue:GetWide() / 2, 42 )
				surface.SetDrawColor( TeamColor.blue[1].r, TeamColor.blue[1].g, TeamColor.blue[1].b, 255 )
				surface.DrawRect( 42, 0, blue:GetWide() / 2 - 42, 42 )
				draw.NoTexture()
				draw.ScoreboardTriangle( blue:GetWide() / 2, 0 )
			else
				surface.SetDrawColor( 0, 0, 0, 200 )
				surface.DrawRect( 0, 0, 42, 42 )
				surface.DrawRect( blue:GetWide() / 2, 0, blue:GetWide() / 2, 42 )
				surface.SetDrawColor( 32, 32, 32, 200 )
				surface.DrawRect( 42, 0, blue:GetWide() / 2 - 42, 42 )
			end

			for i = 0, 4 do
				draw.SimpleText( k, "PlayerHeader", 42 / 2, 42 / 2 - 2, Color( 0, 0, 0, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
				draw.SimpleText( v:Nick(), "PlayerHeaderBG", 94, 42 / 2 - 2, Color( 0, 0, 0, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
				draw.SimpleText( v:Frags(), "PlayerHeaderBG", blue:GetWide() * ( 3 / 4 ), 42 / 2 - 2, Color( 0, 0, 0, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			end
			draw.SimpleText( k, "PlayerHeader", 42 / 2, 42 / 2 - 2, Color( 255, 255, 255, 200 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			draw.SimpleText( v:Nick(), "PlayerHeader", 94, 42 / 2 - 2, Color( 255, 255, 255, 200 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
			draw.SimpleText( v:Frags(), "PlayerHeader", blue:GetWide() * ( 3 / 4 ), 42 / 2 - 2, Color( 255, 255, 255, 200 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end

		if !v:IsBot() then
			local a = p:Add( "AvatarImage" )
			a:SetPos( 42, 0 )
			a:SetSize( 42, 42 )
			a:SetPlayer( v )
		end

		playerlistblue:Add( p )
	end
end

function GM:ScoreboardShow()
	CreateScoreboard()
end

function GM:ScoreboardHide()
	if not ( red and blue and caption ) then
		return 
	end
	red:SetVisible( false )
	blue:SetVisible( false )
	caption:SetVisible( false )
end