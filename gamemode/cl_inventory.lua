surface.CreateFont( "ItemName", { font = "Exo 2", size = 19 } )
surface.CreateFont( "ItemNameBG", { font = "Exo 2", size = 19, blursize = 3 } )

local raritycol = {
	Color( 128, 128, 128 ), --default, grey
	Color( 255, 255, 255 ), --common, white
	Color( 80, 168, 255 ),  --rare, blue
	Color( 181, 70, 211 ),  --epic, purple
	Color( 255, 175, 57 )   --legendary, orange
}

function InventoryMenu()
	--if main then return end
	
	main = vgui.Create( "DFrame" )
	main:SetSize( ScrW(), ScrH() )
	main:SetTitle( "" )
	main:SetVisible( true )
	main:SetDraggable( false )
	main:ShowCloseButton( true )
	main:MakePopup()
	function main:Init()
		self.startTime = SysTime()
	end
	function main:Paint()
		Derma_DrawBackgroundBlur( self, self.startTime )
	end

	inventory = vgui.Create( "DScrollPanel", main )
	inventory:SetSize( ScrW(), ScrH() * ( 3/4 ) * 0.9 )
	inventory:SetPos( 0, ScrH() * ( 1/4 ) )

	inventorylist = vgui.Create( "DIconLayout", inventory )
	inventorylist:SetSize( ScrW() * 0.9, inventory:GetTall() )
	inventorylist:SetPos( ScrW() * 0.05, 0 )
	inventorylist:SetSpaceY( ScrW() * 0.05 )
	inventorylist:SetSpaceX( ScrW() * 0.05 )

	net.Start( "RequestWeapons" )
	net.SendToServer()
	net.Receive( "RequestWeaponsCallback", function()
		local curr = net.ReadTable()
		local weps = net.ReadTable()

		for k, v in pairs( weps ) do
			local item = inventorylist:Add( "DButton" )
			item:SetSize( 256, 512 )
			item:SetText( "" )

			item.name   = v.name
			item.rarity = v.rarity
			item.class  = v.class
			item.mods   = v.mods or nil

			function item:Paint()
				surface.SetDrawColor( 0, 0, 0, 200 )
				surface.DrawRect( 0, 0, item:GetSize() )

				surface.SetDrawColor( raritycol[ item.rarity ] )
				surface.DrawRect( 0, item:GetTall() / 2, item:GetWide(), 42 )

				for i = 0, 4 do
					draw.SimpleText( item.name, "ItemNameBG", item:GetWide() / 2, item:GetWide() + ( 42 / 2 ), Color( 0, 0, 0, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
				end
				draw.SimpleText( item.name, "ItemName", item:GetWide() / 2, item:GetWide() + ( 42 / 2 ), Color( 255, 255, 255, 200 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			end

			item.DoClick = function()

				itemdetail = vgui.Create( "DFrame" )
				itemdetail:SetSize( 256, 512 )
				itemdetail:SetTitle( "" )
				itemdetail:SetVisible( true )
				itemdetail:SetDraggable( false )
				itemdetail:ShowCloseButton( true )
				itemdetail:Center()
				itemdetail:MakePopup()
				function itemdetail:Init()
					self.startTime = SysTime()
				end
				function itemdetail:Paint()
					Derma_DrawBackgroundBlur( self, self.startTime )

					surface.SetDrawColor( 0, 0, 0, 200 )
					surface.DrawRect( 0, 0, itemdetail:GetSize() )

					surface.SetDrawColor( raritycol[ item.rarity ] )
					surface.DrawRect( 0, itemdetail:GetTall() / 2, itemdetail:GetWide(), 42 )

					for i = 0, 4 do
						draw.SimpleText( item.name, "ItemNameBG", itemdetail:GetWide() / 2, itemdetail:GetWide() + ( 42 / 2 ), Color( 0, 0, 0, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
					end
					draw.SimpleText( item.name, "ItemName", itemdetail:GetWide() / 2, itemdetail:GetWide() + ( 42 / 2 ), Color( 255, 255, 255, 200 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
				end

				replacepri = itemdetail:Add( "DButton" )
				replacepri:SetSize( itemdetail:GetWide(), 42 )
				replacepri:SetPos( 0, itemdetail:GetTall() * ( 2/3 ) )
				replacepri:SetText( "Replace " .. curr.primary .. " with " .. item.name )
				replacepri.DoClick = function()
					curr.primary = item.class
					curr.primarymods = item.mods or {}

					net.Start( "wz_loadout" )
						net.WriteString( "primary" )
						net.WriteString( curr.primary )
						net.WriteTable( curr.primarymods )
					net.SendToServer()
					itemdetail:Close()
				end

				replacesec = itemdetail:Add( "DButton" )
				replacesec:SetSize( itemdetail:GetWide(), 42 )
				replacesec:SetPos( 0, itemdetail:GetTall() * ( 2/3 ) + 44 )
				replacesec:SetText( "Replace " .. curr.secondary .. " with " .. item.name )
				replacesec.DoClick = function()
					curr.secondary = item.class
					curr.secondarymods = item.mods or {}

					net.Start( "wz_loadout" )
						net.WriteString( "secondary" )
						net.WriteString( curr.secondary )
						net.WriteTable( curr.secondarymods )
					net.SendToServer()
					itemdetail:Close()
				end

				if curr.secondary == item.class or curr.primary == item.class then
					replacepri:SetEnabled( false )
					replacesec:SetEnabled( false )
				end

			end

			local model = item:Add( "DModelPanel" )
			model:SetSize( item:GetWide(), item:GetTall() / 2 )
			model:SetCamPos( Vector( 32, 0, 0 ) )
			model:SetLookAt( Vector( 0, -3, 0 ) )
			model:SetModel( v.model )

			-- lol it's drawn over the clickable area
			model.DoClick = item.DoClick

			function model:LayoutEntity( ent )
				ent:SetAngles( Angle( 90, 0, 90 ) )
			end
		end
	end )
end

concommand.Add( "wz_inventory", InventoryMenu )