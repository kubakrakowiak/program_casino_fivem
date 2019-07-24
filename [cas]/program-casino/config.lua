Config                            = {}

Config.DrawDistance               = 15.0
Config.MarkerType                 = 1
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 0.5 }
Config.MarkerColor                = { r = 50, g = 50, b = 204 }
Config.classicPrice				  = 50
Config.goldenPrice				  = 500
Config.platiniumPrice			  = 2000
Config.MissCraft                  = 10 -- %


Config.CasinoSites = {

	CasinoActions = {
		Pos   = { x = 924.69, y = -941.53, z = 44.75 },
		Size  = { x = 1.5, y = 1.5, z = 1.5 },
		Color = { r = 204, g = 204, b = 0 },
		Type  = 22,
	},
	CasinoCloak = {
		Pos   = { x = 946.88, y = -954.53, z = 44.0 },
		Size  = { x = 0.8, y = 0.8, z = 0.8 },
		Color = { r = 110, g = 110, b = 244 },
		Type  = 24,
	},
	CasinoBar = {
		Pos	  = { x = 910.55,   y = -962.72, z = 44.780},
		Size  = { x = 1.0, y = 1.0, z = 1.0 },
		Color = { r = 204, g = 204, b = 0 },
		Type  = 22,
	},
	CasinoFridge = {
		Pos	  = { x = 910.97,   y = -959.71, z = 44.780},
		Size  = { x = 1.0, y = 1.0, z = 1.0 },
		Color = { r = 204, g = 204, b = 0 },
		Type  = 22,
	}

}
Config.JobBlip = {
	coord = vector3(930.17, 41.57, 30.7),
	sprite = 500,
	display = 4,
	scale = 1.2,
	colour = 63,
	name = 'State Casino'
}