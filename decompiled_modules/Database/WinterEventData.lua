-- Decompiled with the Synapse X Luau decompiler.

local v1 = {
	Skins = {
		Common = {
			Octonut = {
				Name = "Cocosquid", 
				Skin = 10
			}, 
			Jellupy = {
				Name = "Jellupy", 
				Skin = 7
			}, 
			Squonk = {
				Name = "Squonk", 
				Skin = 11
			}, 
			Junipyro = {
				Name = "Junipyro", 
				Skin = 6
			}, 
			Bionotic = {
				Name = "Squelly", 
				Skin = 11
			}, 
			Owol = {
				Name = "Owol", 
				Skin = 2
			}, 
			Polargeist = {
				Name = "Wisp", 
				Skin = 9
			}, 
			Groato = {
				Name = "Plipo", 
				Skin = 12
			}, 
			Klydaskunk = {
				Name = "Klydaskunk", 
				Skin = 12
			}, 
			Wolfreeze = {
				Name = "Pupskey", 
				Skin = 10
			}, 
			Zapoeira = {
				Name = "Tabbolt", 
				Skin = 8
			}, 
			Roadterra = {
				Name = "Fledgeo", 
				Skin = 4
			}, 
			Spunny = {
				Name = "Spunny", 
				Skin = 11
			}, 
			Kelpimer = {
				Name = "Kelpie", 
				Skin = 9
			}, 
			Bunswirl = {
				Name = "Bunsweet", 
				Skin = 12
			}, 
			Antenaflight = {
				Name = "Larvennae", 
				Skin = 10
			}, 
			Cacmeow = {
				Name = "Cacmeow", 
				Skin = 12
			}, 
			Thornet = {
				Name = "Rosebug", 
				Skin = 7
			}, 
			Marigrimm = {
				Name = "Wydling", 
				Skin = 10
			}, 
			Humbiscus = {
				Name = "Flittum", 
				Skin = 9
			}, 
			Malotrick = {
				Name = "Malotrick", 
				Skin = 7
			}, 
			Fruitoad = {
				Name = "Tadappole", 
				Skin = 10
			}, 
			Louis = {
				Name = "Louis", 
				Skin = 12
			}, 
			Partybug = {
				Name = "Partybug", 
				Skin = 11
			}, 
			Henchum = {
				Name = "Riffrat", 
				Skin = 11
			}, 
			Moyai = {
				Name = "Squed", 
				Skin = 11
			}, 
			Potterfiend = {
				Name = "Potunk", 
				Skin = 2
			}, 
			Grufflin = {
				Name = "Appluff", 
				Skin = 11
			}
		}, 
		Rare = {
			Hattrix = {
				Name = "Hattrix", 
				Skin = 7
			}, 
			Swoptar = {
				Name = "Swoptar", 
				Skin = 12
			}, 
			Horbeast = {
				Name = "Shelldo", 
				Skin = 13
			}, 
			Hollihare = {
				Name = "Hollihare", 
				Skin = 2
			}, 
			Vuliable = {
				Name = "Flaskit", 
				Skin = 9
			}, 
			Lumiline = {
				Name = "Glimmew", 
				Skin = 11
			}, 
			Cryotera = {
				Name = "Snobat", 
				Skin = 8
			}, 
			Staligant = {
				Name = "Staligant", 
				Skin = 9
			}, 
			Taryonix = {
				Name = "Grunkul", 
				Skin = 2
			}, 
			Vixalor = {
				Name = "Kitsen", 
				Skin = 8
			}, 
			Voltenchant = {
				Name = "Aspark", 
				Skin = 8
			}, 
			Mourveil = {
				Name = "Glummish", 
				Skin = 10
			}, 
			Xenoxious = {
				Name = "Xenoxious", 
				Skin = 11
			}, 
			Calamander = {
				Name = "Calamander", 
				Skin = 11
			}, 
			Tufflaze = {
				Name = "Ruffire", 
				Skin = 11
			}, 
			Skadean = {
				Name = "Schiwi", 
				Skin = 9
			}, 
			Kibara = {
				Name = "Shyce", 
				Skin = 7
			}, 
			["Skorpirul\195\173"] = {
				Name = "Az\195\186pion", 
				Skin = 5
			}, 
			Ostigon = {
				Name = "Ostigon", 
				Skin = 1
			}, 
			Moss = {
				Name = "Moss", 
				Skin = 12
			}, 
			Girasera = {
				Name = "Dewaffe", 
				Skin = 5
			}, 
			Metalytra = {
				Name = "Klicki", 
				Skin = 7
			}
		}, 
		Mythic = {
			Maelzuri = {
				Name = "Maelzuri", 
				Skin = 10
			}, 
			Qilintel = {
				Name = "Qilintel", 
				Skin = 3
			}, 
			Chronos = {
				Name = "Chronos", 
				Skin = 7
			}
		}
	}, 
	Common = {}, 
	Rare = {}, 
	Mythic = {}
};
local l__Common__2 = v1.Common;
for v3, v4 in pairs(v1.Skins.Common) do
	table.insert(l__Common__2, v3);
end;
local l__Rare__5 = v1.Rare;
for v6, v7 in pairs(v1.Skins.Rare) do
	table.insert(l__Rare__5, v6);
end;
local l__Mythic__8 = v1.Mythic;
for v9, v10 in pairs(v1.Skins.Mythic) do
	table.insert(l__Mythic__8, v9);
end;
v1.OtherChances = {
	Misprint = {
		[3] = 100, 
		[4] = 50, 
		[5] = 10
	}, 
	HT = {
		[3] = 24, 
		[4] = 16, 
		[5] = 8
	}, 
	MaxStars = {
		[3] = 20, 
		[4] = 10, 
		[5] = 5
	}, 
	Tint = {
		[3] = 80, 
		[4] = 40, 
		[5] = 20
	}, 
	Size = {
		[3] = 80, 
		[4] = 40, 
		[5] = 20
	}
};
v1.Equipment = {
	Garbage = { {
			Val = 15, 
			Name = "Coal", 
			Type = "Artifact"
		} }, 
	Uncommon = { {
			Val = 3, 
			Name = "Computer Mouse", 
			Type = "Artifact"
		}, {
			Val = 1, 
			Name = "Oakwood Staff", 
			Type = "Artifact"
		}, {
			Val = 4, 
			Name = "Amber Trapped Fly", 
			Type = "Artifact"
		}, {
			Val = 5, 
			Name = "Thingamajig", 
			Type = "Artifact"
		}, {
			Val = 7, 
			Name = "Sad Pebblett", 
			Type = "Artifact"
		}, {
			Val = 8, 
			Name = "Faunsprout Tail", 
			Type = "Artifact"
		}, {
			Val = 10, 
			Name = "Stick", 
			Type = "Artifact"
		}, {
			Val = 11, 
			Name = "Pizza Slice", 
			Type = "Artifact"
		}, {
			Val = 1, 
			Name = "Sapphire Amulet", 
			Type = "Amulet"
		}, {
			Val = 2, 
			Name = "Mini Camera", 
			Type = "Amulet"
		}, {
			Val = 4, 
			Name = "Whatchamacallit", 
			Type = "Amulet"
		}, {
			Val = 6, 
			Name = "Swag Juice", 
			Type = "Amulet"
		}, {
			Val = 10, 
			Name = "Ruby Pendant", 
			Type = "Amulet"
		}, {
			Val = 9, 
			Name = "Rock Candy", 
			Type = "Amulet"
		}, {
			Val = 1, 
			Name = "Magnificent Tophat", 
			Type = "Helmet"
		}, {
			Val = 3, 
			Name = "Doodad", 
			Type = "Helmet"
		}, {
			Val = 6, 
			Name = "Feathered Hat", 
			Type = "Helmet"
		}, {
			Val = 7, 
			Name = "Epic Shades", 
			Type = "Helmet"
		}, {
			Val = 8, 
			Name = "Glummish Cap", 
			Type = "Helmet"
		}, {
			Val = 10, 
			Name = "Theatre Mask", 
			Type = "Helmet"
		}, {
			Val = 11, 
			Name = "Horned Headband", 
			Type = "Helmet"
		}, {
			Val = 12, 
			Name = "Marshmallow Fedora", 
			Type = "Helmet"
		}, {
			Val = 13, 
			Name = "Smoldering Hood", 
			Type = "Helmet"
		}, {
			Val = 14, 
			Name = "Candy Headphones", 
			Type = "Helmet"
		} }
};
v1.HeldItems = { "Empowered Ring", "Jetpack", "Magic Wand", "Lethal Ornament", "Perfect Alloy", "Christmas Tintbrush", "Refractive Prism", "Crooked Talon", "Moon Charm", "Bubblegum", "Small Sprout", "Pretty Seashell", "Delicate Wing", "Used Timber", "Unwashed Plushie", "Riot Shield", "Champion Belt", "Ice Pack", "Battery", "Lucky Pebble", "Glasses", "Espresso", "Used Crayons", "Determination Headband", "Sickly Ooze" };
return v1;
