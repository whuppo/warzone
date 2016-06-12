GM.Name = "Warzone"
GM.Author = "whuppo"
GM.Email = "whuppo@whuppo.com"
GM.Website = "whuppo.com"

game.AddAmmoType( { name = "Pistol", dmgtype = DMG_BULLET } )
game.AddAmmoType( { name = "SMG", dmgtype = DMG_BULLET } )
game.AddAmmoType( { name = "Rifle", dmgtype = DMG_BULLET } )
game.AddAmmoType( { name = "Sniper", dmgtype = DMG_BULLET } )
game.AddAmmoType( { name = "Buckshot", dmgtype = DMG_BULLET } )

team.SetUp( 0, "Spectators", Color( 0, 0, 0 ) )
team.SetUp( 1, "Red", Color( 255, 0, 0 ) )
team.SetUp( 2, "Blue", Color( 0, 0, 255 ) )

function GM:Initialize()
end