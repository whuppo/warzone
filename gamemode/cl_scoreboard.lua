surface.CreateFont( "TeamHeader", { font = "Exo 2", size = 21 } )
surface.CreateFont( "TeamScore", { font = "Exo 2", size = 42 } )
surface.CreateFont( "PlayerHeader", { font = "Exo 2", size = 19 } )
surface.CreateFont( "PlayerHeaderBG", { font = "Exo 2", size = 19, blursize = 3 } )

local playerlistred
local playerlistblue

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

local white = Color( 255, 255, 255 )
local black = Color( 0, 0, 0 )

function team.GetSortedPlayers( tea )
	local tab = team.GetPlayers( tea )
	table.sort( tab, function( a, b ) return a:Frags() > b:Frags() end )
	return tab
end

function draw.ScoreboardTriangle( x, y )
	local tri = {}

	table.insert( tri, { x = x, y = y } )
	table.insert( tri, { x = x, y = y + 42 } )
	table.insert( tri, { x = x + 12, y = y + 24 } )

	surface.DrawPoly( tri )
end 

local function CreateScoreboard()
	blue = vgui.Create( "DFrame" )
	blue:ShowCloseButton( false )
	blue:SetDraggable( false )
	blue:SetTitle( "" )
	blue:SetSize( ScrW() * ( 9/20 ), ScrH() * ( 2/3 ) )
	blue:Center()
	blue.Paint = function()
		surface.SetDrawColor( TeamColor.blue[2] )
		surface.DrawRect( blue:GetWide() / 2, 0, blue:GetWide() / 2, 88 )
		draw.SimpleText( "BLUE", "TeamHeader", blue:GetWide() / 2 + 132, 88 / 2, white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
		draw.SimpleText( team.TotalFrags( 2 ), "TeamScore", blue:GetWide() - 24, 88 / 2, white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
		surface.SetDrawColor( TeamColor.blue[3] )
		surface.DrawRect( blue:GetWide() / 2, 6, blue:GetWide() / 2 / 10, 82 )
		surface.SetDrawColor( TeamColor.blue[1] )
		surface.DrawRect( blue:GetWide() / 2 + blue:GetWide() / 2 / 10, 0, blue:GetWide() / 2 - blue:GetWide() / 2 / 10, 6 )

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

	playerlistblue = vgui.Create( "DPanelList", blue )
	playerlistblue:SetPos( 0, 184 )
	playerlistblue:SetSize( blue:GetWide(), blue:GetTall() - 184 )	
	playerlistblue:EnableVerticalScrollbar( true )
	playerlistblue:SetSpacing( 2 )

	red = vgui.Create( "DFrame" )
	red:ShowCloseButton( false )
	red:SetDraggable( false )
	red:SetTitle( "" )
	red:SetSize( ScrW() * ( 9/20 ), ScrH() * ( 2/3 ) )
	red:Center()
	red.Paint = function()
		surface.SetDrawColor( TeamColor.red[2] )
		surface.DrawRect( 0, 0, red:GetWide() / 2, 88 )
		draw.SimpleText( "RED", "TeamHeader", red:GetWide() / 2 - 132, 88 / 2, white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
		draw.SimpleText( team.TotalFrags( 1 ), "TeamScore", 24, 88 / 2, white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
		surface.SetDrawColor( TeamColor.red[3] )
		surface.DrawRect( red:GetWide() / 2 - red:GetWide() / 2 / 10, 6, red:GetWide() / 2 / 10, 82 )
		surface.SetDrawColor( TeamColor.red[1] )
		surface.DrawRect( 0, 0, red:GetWide() / 2 - red:GetWide() / 2 / 10, 6 )

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

	playerlistred = vgui.Create( "DPanelList", red )
	playerlistred:SetPos( 0, 184 )
	playerlistred:SetSize( red:GetWide(), red:GetTall() - 184 )	
	playerlistred:EnableVerticalScrollbar( true )
	playerlistred:SetSpacing( 2 )

	for k, v in next, team.GetSortedPlayers( 1 ) do
		local p = vgui.Create( "DPanel" )
		p:SetSize( red:GetWide(), 42 )
		p.Paint = function()
			if v == LocalPlayer() then
				surface.SetDrawColor( TeamColor.red[2].r, TeamColor.red[2].g, TeamColor.red[2].b, 200 )
				surface.DrawRect( 0, 0, 42, 42 )
				surface.DrawRect( red:GetWide() / 2, 0, red:GetWide() / 2, 42 )
				surface.SetDrawColor( TeamColor.red[1].r, TeamColor.red[1].g, TeamColor.red[1].b, 200 )
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

			draw.SimpleText( k, "PlayerHeader", 42 / 2, 42 / 2 - 2, Color( 255, 255, 255, 200 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			draw.SimpleText( v:Nick(), "PlayerHeader", 94, 42 / 2 - 2, Color( 255, 255, 255, 200 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
			draw.SimpleText( v:Frags(), "PlayerHeader", red:GetWide() * ( 3 / 4 ), 42 / 2 - 2, Color( 255, 255, 255, 200 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end

		local a = p:Add( "AvatarImage" )
		a:SetPos( 42, 0 )
		a:SetSize( 45, 45 )
		a:SetPlayer( v )

		playerlistred:AddItem( p )
	end

	for k, v in next, team.GetSortedPlayers( 2 ) do
		local p = vgui.Create( "DPanel" )
		p:SetSize( blue:GetWide(), 42 )
		p.Paint = function()
			if v == LocalPlayer() then
				surface.SetDrawColor( TeamColor.blue[2].r, TeamColor.blue[2].g, TeamColor.blue[2].b, 200 )
				surface.DrawRect( 0, 0, 42, 42 )
				surface.DrawRect( blue:GetWide() / 2, 0, blue:GetWide() / 2, 42 )
				surface.SetDrawColor( TeamColor.blue[1].r, TeamColor.blue[1].g, TeamColor.blue[1].b, 200 )
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

			draw.SimpleText( k, "PlayerHeader", 42 / 2, 42 / 2 - 2, Color( 255, 255, 255, 200 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			draw.SimpleText( v:Nick(), "PlayerHeader", 94, 42 / 2 - 2, Color( 255, 255, 255, 200 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
			draw.SimpleText( v:Frags(), "PlayerHeader", blue:GetWide() * ( 3 / 4 ), 42 / 2 - 2, Color( 255, 255, 255, 200 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end

		local a = p:Add( "AvatarImage" )
		a:SetPos( 42, 0 )
		a:SetSize( 45, 45 )
		a:SetPlayer( v )

		playerlistblue:AddItem( p )
	end
end

function GM:ScoreboardShow()
	CreateScoreboard()
end

function GM:ScoreboardHide()
	if not ( red and blue ) then
		return 
	end
	red:SetVisible( false )
	blue:SetVisible( false )
end