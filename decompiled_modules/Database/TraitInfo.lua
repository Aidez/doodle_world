-- Decompiled with the Synapse X Luau decompiler.

return function(p1)
	local l__Utilities__1 = p1.Utilities;
	local v2 = {
		["No ability"] = {
			Description = "no ability"
		}, 
		Moratorium = {
			Description = "When this Doodle's out, all Doodle's held items cannot be activated.", 
			Neutralize = true, 
			BeforeSendOut = function(p2, p3)
				p2:AddDialogue(p2.ActionList, "&DOODLENAME," .. p3.ID .. "&'s Moratorium made it so held items can't be activated!");
			end
		}, 
		Nullify = {
			Description = "When this Doodle's out, all Doodle's traits cannot be activated.", 
			Neutralize = true, 
			BeforeSendOut = function(p4, p5)
				p4:AddDialogue(p4.ActionList, "&DOODLENAME," .. p5.ID .. "& nullified all other traits!");
			end
		}, 
		Mimic = {
			Description = "When this Doodle is sent out, copies the opposing Doodle's trait.", 
			Neutralize = true, 
			SendOut = function(p6, p7, p8)
				if not (p8.currenthp > 0) or not p8.Ability or not (not table.find({ "Nullify", "Mimic" }, p8.Ability)) then
					return;
				end;
				p7.Ability = p8.Ability;
				p6:AddDialogue(p6.ActionList, "&DOODLENAME," .. p7.ID .. "&" .. " is mimicking " .. p8.Ability .. "!");
				return true;
			end
		}
	};
	local v3 = {
		Description = "Attacks that aren't the same type of this Doodle do 50% more damage, but are 20% less accurate."
	};
	function v3.ModifyDamage(p9, p10, p11, p12)
		if not l__Utilities__1:IsInTable(p12.Type, p10:GetData().Type) then
			return 1.3;
		end;
		return 1;
	end;
	function v3.AttackModifier(p13, p14, p15, p16)
		if not l__Utilities__1:IsInTable(p16.Type, p14:GetData().Type) and typeof(p16.Accuracy) == "number" then
			p16.Accuracy = p16.Accuracy * 0.8;
		end;
	end;
	v2.Savage = v3;
	v2["Hidden Strength"] = {
		Description = "Doubles this Doodle's Attack stat.", 
		DoubleAttack = true
	};
	v2.Gloomy = {
		Description = "Every Doodle's Dark-type moves do 30% more damage.", 
		ModifyDamageField = function(p17, p18, p19, p20)
			if p20.Type == "Dark" then
				return 1.3;
			end;
			return 1;
		end
	};
	v2.Spellcaster = {
		Description = "This Doodle\226\128\153s Spark, Fire, and Ice-type attacks do 25% more damage.", 
		ModifyDamage = function(p21, p22, p23, p24)
			if p24.Type ~= "Spark" and p24.Type ~= "Ice" and p24.Type ~= "Fire" then
				return 1;
			end;
			return 1.25;
		end
	};
	v2["Stabby Stabby"] = {
		Description = "This Doodle\226\128\153s Metal-type attacks do 30% more damage.", 
		ModifyDamage = function(p25, p26, p27, p28)
			if p28.Type == "Metal" then
				return 1.3;
			end;
			return 1;
		end
	};
	v2["Second Wind"] = {
		Description = "This Doodle has a 50% increased speed stat when they are below 25% health.", 
		ModifySpeed = function(p29, p30, p31)
			if not (p30.currenthp < p30.Stats.hp / 4) then
				return p31;
			end;
			return p31 + p31 * 0.5;
		end
	};
	v2.Vitality = {
		Description = "This Doodle has a 50% increased speed stat when they are over half health.", 
		ModifySpeed = function(p32, p33, p34)
			if not (p33.Stats.hp / 2 < p33.currenthp) then
				return p34;
			end;
			return p34 + p34 * 0.5;
		end
	};
	v2.Rush = {
		Description = "This Doodle has a 20% increased speed stat in battle.", 
		ModifySpeed = function(p35, p36, p37)
			return p37 + p37 * 0.2;
		end
	};
	local v4 = {
		Description = "When this Doodle uses a magical attack, they have a 20% chance to boost their magical attack."
	};
	local l__ChangeStats__1 = l__Utilities__1.ChangeStats;
	function v4.BattleFunc(p38, p39, p40, p41)
		if p41.Category == "Magical" then
			l__ChangeStats__1(p38, p39, p39, 20, {
				matk = 1
			});
		end;
	end;
	v2.Magician = v4;
	v2.Scorch = {
		Description = "When this Doodle uses a Fire-type attack, they have a 20% chance to boost their magical attack.", 
		BattleFunc = function(p42, p43, p44, p45)
			if p45.Type == "Fire" and p45.Category ~= "Passive" then
				l__ChangeStats__1(p42, p43, p43, 20, {
					matk = 1
				});
			end;
		end
	};
	v2.Scavenge = {
		Description = "At the end of every battle, you have a chance to pick up a random item."
	};
	v2.Puncture = {
		Description = "This Doodle\226\128\153s contact moves have a 30% chance to lower the target\226\128\153s defense.", 
		BattleFunc = function(p46, p47, p48, p49)
			if p49.Contact and p49.Category ~= "Passive" then
				l__ChangeStats__1(p46, p47, p48, 30, {
					def = -1
				});
			end;
		end
	};
	v2["Blinding Rocks"] = {
		Description = "When this Doodle uses an Earth-type attack, they have a 20% chance to lower the target\226\128\153s accuracy.", 
		BattleFunc = function(p50, p51, p52, p53)
			if p53.Type == "Earth" and p53.Category ~= "Passive" then
				l__ChangeStats__1(p50, p51, p52, 20, {
					acc = -1
				});
			end;
		end
	};
	v2["Oil Spill"] = {
		Description = "When this Doodle uses an Earth-type attack, they have a 50% chance to lower the target\226\128\153s speed.", 
		BattleFunc = function(p54, p55, p56, p57)
			if p57.Type == "Earth" and p57.Category ~= "Passive" then
				l__ChangeStats__1(p54, p55, p56, 50, {
					spe = -1
				});
			end;
		end
	};
	v2.Whimsical = {
		Description = "This Doodle boosts a random stat and lowers another at the end of each turn.", 
		EndTurn = function(p58, p59, p60)
			local v5 = { "atk", "def", "matk", "mdef", "spe", "acc", "eva" };
			local v6 = table.remove(v5, math.random(#v5));
			local v7 = table.remove(v5, math.random(#v5));
			if p59.Status ~= "Faint" then
				l__ChangeStats__1(p58, p59, p59, 100, {
					[v6] = 1
				});
				l__ChangeStats__1(p58, p59, p59, 100, {
					[v7] = -1
				});
			end;
		end
	};
	v2.Molt = {
		Description = "This Doodle has a 25% chance to cure their status condition at the end of each turn.", 
		EndTurn = function(p61, p62, p63)
			if p62.Status and p62.Status ~= "Faint" and math.random(1, 4) == 1 then
				p62.Status = nil;
				p61:AddDialogue(p61.ActionList, "&DOODLENAME," .. p62.ID .. "&" .. " molted its skin and cured its " .. p62.Status:lower() .. " status!");
				p61:AddAction(p61.ActionList, {
					Player = p62.Owner, 
					Doodle = p62, 
					Action = "StatusAnim", 
					Status = ""
				});
			end;
		end
	};
	v2.Accelerate = {
		Description = "This Doodle boosts their speed at the end of each turn.", 
		EndTurn = function(p64, p65, p66)
			if p65.currenthp > 0 then
				l__ChangeStats__1(p64, p65, p65, 100, {
					spe = 1
				});
			end;
		end
	};
	v2["Storm Surge"] = {
		Description = "If it\226\128\153s raining, this Doodle boosts their speed at the end of each turn.", 
		EndTurn = function(p67, p68, p69)
			if p68.currenthp > 0 and p67.Weather == "Rain" then
				l__ChangeStats__1(p67, p68, p68, 100, {
					spe = 1
				});
			end;
		end
	};
	v2["Foam Guard"] = {
		Description = "At the end of the turn, they summon a Bubble Shield that shoots a Waterbolt at any opposing Doodle that hits them with physical attack.", 
		WaterShield = true, 
		EndTurn = function(p70, p71, p72)
			p71.WaterShield = true;
			p71.OnHit = p71.OnHit or {};
			if not p71.OnHit.WaterShield then
				p70:AddDialogue(p70.ActionList, "&DOODLENAME," .. p71.ID .. "& is now surrounded by bubbles!");
				p71.OnHit.WaterShield = function(p73, p74, p75, p76)
					if p73:GetTraitInfo(p71).WaterShield and p71.WaterShield and p71.currenthp > 0 and p76.Category == "Physical" then
						p73:AddDialogue(p73.ActionList, "&DOODLENAME," .. p74.ID .. "&'s Foam Guard shoots a Waterbolt!");
						p73:UseMove(p74, { p75 }, "Waterbolt", true);
					end;
				end;
			end;
		end
	};
	v2.Firewall = {
		Description = "At the end of the turn, they summon a Flame Shield that shoots a Firebolt at any opposing Doodle that hits them with magical attack.", 
		Firewall = true, 
		EndTurn = function(p77, p78, p79)
			p78.FlameShield = true;
			p78.OnHit = p78.OnHit or {};
			if not p78.OnHit.FlameShield then
				p77:AddDialogue(p77.ActionList, "&DOODLENAME," .. p78.ID .. "& is now surrounded by a flame shield!");
				p78.OnHit.FlameShield = function(p80, p81, p82, p83)
					if p80:GetTraitInfo(p78).Firewall and p78.FlameShield and p78.currenthp > 0 and p83.Category == "Magical" and not p83.NoFirewall then
						p80:AddDialogue(p80.ActionList, "&DOODLENAME," .. p81.ID .. "&'s Flame Shield shoots a Fire Bolt!");
						p80:UseMove(p81, { p82 }, "FirewallFirebolt", true);
					end;
				end;
			end;
		end
	};
	v2.Parry = {
		Description = "This Doodle has a 10% chance to parry contact moves, avoiding damage.", 
		ModifyDefendDamage = function(p84, p85, p86, p87, p88, p89, p90)
			if p87.Contact and p87.Category == "Physical" and math.random(1, 100) > 90 and p90 == nil then
				p84:AddDialogue(p84.ActionList, "&DOODLENAME," .. p86.ID .. "& parried the attack!");
				return 0;
			end;
			return 1;
		end
	};
	v2["Sugar Coating"] = {
		Description = "If this Doodle is at full health, this Doodle takes half damage.", 
		ModifyDefendDamage = function(p91, p92, p93, p94, p95, p96, p97)
			if p92.Stats.hp == p92.currenthp then
				return 0.5;
			end;
			return 1;
		end
	};
	v2["Royal Decree"] = {
		Description = "If another Doodle is faster, this Doodle takes 30% less damage from their attacks.", 
		ModifyDefendDamage = function(p98, p99, p100, p101, p102, p103, p104)
			if p100.Stats.spe < p99.Stats.spe then
				return 0.7;
			end;
			return 1;
		end
	};
	v2["Sharp Reflexes"] = {
		Description = "If another Doodle is slower, their attacks on this Doodle miss 15% more often.", 
		AccCalc = function(p105, p106, p107, p108)
			local v8 = p108;
			if typeof(v8) == "number" and v8 < 100 and p107.Stats.spe < p106.Stats.spe then
				v8 = v8 * 0.85;
			end;
			return v8;
		end
	};
	v2["Seed Defense"] = {
		Description = "When this Doodle is hit by an attack, they use Parasitic Seeds on the attacker.", 
		OnHit = function(p109, p110, p111, p112)
			if p112.Category ~= "Passive" and p111.LeechSeed == nil then
				p109:AddDialogue(p109.ActionList, "&DOODLENAME," .. p110.ID .. "&" .. "'s used Parasitic Seeds in response to " .. "&DOODLENAME," .. p111.ID .. "&'s attack!");
				p109:UseMove(p110, { p111 }, "Parasitic Seeds", true);
			end;
		end
	};
	v2.Guilt = {
		Description = "When this Doodle is hit by an attack, lower the user's attack.", 
		OnHit = function(p113, p114, p115, p116)
			if p116.Category ~= "Passive" then
				p113:AddDialogue(p113.ActionList, "&DOODLENAME," .. p115.ID .. "&" .. " felt guilt attacking " .. "&DOODLENAME," .. p114.ID .. "&!");
				l__ChangeStats__1(p113, p114, p115, 100, {
					atk = -1
				});
			end;
		end
	};
	v2["Splintered Shards"] = {
		Description = "If this Doodle is hit with a damaging move, they do a little damage back.", 
		OnHit = function(p117, p118, p119, p120)
			local v9 = math.floor(p119.Stats.hp / 16);
			if v9 > 0 then
				p117:TakeDamage(p119, v9);
				p117:AddDialogue(p117.ActionList, "&DOODLENAME," .. p118.ID .. "&" .. "'s splintered shards hurt " .. "&DOODLENAME," .. p119.ID .. "&!");
			end;
		end
	};
	v2.Rugged = {
		Description = "If this Doodle is hit with a contact move, they do some damage back.", 
		OnHit = function(p121, p122, p123, p124)
			if p124.Contact then
				local v10 = math.floor(p123.Stats.hp / 8);
				if v10 > 0 then
					p121:TakeDamage(p123, v10);
					p121:AddDialogue(p121.ActionList, "&DOODLENAME," .. p122.ID .. "&" .. "'s rugged edges hurt " .. "&DOODLENAME," .. p123.ID .. "&!");
				end;
			end;
		end
	};
	v2.Retaliate = {
		Description = "If this Doodle is hit with a contact move, they do some damage back.", 
		OnHit = function(p125, p126, p127, p128)
			if p128.Contact then
				local v11 = math.floor(p127.Stats.hp / 8);
				if v11 > 0 then
					p125:TakeDamage(p127, v11);
					p125:AddDialogue(p125.ActionList, "&DOODLENAME," .. p126.ID .. "&" .. " hurt " .. "&DOODLENAME," .. p127.ID .. "&!");
				end;
			end;
		end
	};
	v2["Steam Guard"] = {
		Description = "If this Doodle is hit with a Water-type move, boost their evasion.", 
		OnHit = function(p129, p130, p131, p132)
			if p130.currenthp > 0 and p132.Type == "Water" then
				l__ChangeStats__1(p129, p130, p130, 100, {
					eva = 1
				});
			end;
		end
	};
	local v12 = {
		Description = "This Doodle\226\128\153s contact moves have a 20% chance to flinch."
	};
	local l__InflictStatus__2 = l__Utilities__1.InflictStatus;
	function v12.BattleFunc(p133, p134, p135, p136)
		if p136.Category ~= "Passive" and p136.Contact == true and p135.currenthp > 0 then
			l__InflictStatus__2(p133, p134, p135, 20, "Flinch", nil, AdditionalMsg);
		end;
	end;
	v2.Stinky = v12;
	v2.Kaleidoscope = {
		Description = "When this Doodle is sent out into battle, they lower the accuracy of opposing Doodles.", 
		BeforeSendOut = function(p137, p138)
			p137:AddDialogue(p137.ActionList, "&DOODLENAME," .. p138.ID .. "& emits a blinding light and tried to lower the other team's accuracy!");
		end, 
		SendOut = function(p139, p140, p141)
			l__ChangeStats__1(p139, p140, p141, 100, {
				acc = -1
			});
		end
	};
	v2.Deepfreeze = {
		Description = "This Doodle\226\128\153s moves have a 2x chance to freeze.", 
		StatusModifier = function(p142, p143, p144, p145, p146)
			if p145 ~= "Freeze" then
				return p145, p146;
			end;
			return p145, p146 * 2;
		end
	};
	v2.Contagion = {
		Description = "Whenever this Doodle would inflict Poison, inflict Diseased instead.", 
		StatusModifier = function(p147, p148, p149, p150, p151)
			if p150 ~= "Poison" then
				return p150, p151;
			end;
			return "Diseased", p151 * 2;
		end
	};
	v2.Kindling = {
		Description = "This Doodle\226\128\153s moves have a 2x chance to burn.", 
		StatusModifier = function(p152, p153, p154, p155, p156)
			if p155 ~= "Burn" then
				return p155, p156;
			end;
			return p155, p156 * 2;
		end
	};
	v2["First Degree Burns"] = {
		Description = "If an opposing Doodle is burned, they take double damage at the end of each turn.", 
		BurnModifier = true
	};
	v2["Strong Armor"] = {
		Description = "If this Doodle is hit with a contact move, boost their defense.", 
		OnHit = function(p157, p158, p159, p160)
			if p158.currenthp > 0 and p160.Contact then
				l__ChangeStats__1(p157, p158, p158, 100, {
					def = 1
				});
			end;
		end
	};
	v2.Cracked = {
		Description = "If this Doodle is hit with a physical move, lower their defense but greatly boost their speed.", 
		OnHit = function(p161, p162, p163, p164)
			if p162.currenthp > 0 and p164.Category == "Physical" then
				l__ChangeStats__1(p161, p162, p162, 100, {
					def = -1, 
					spe = 2
				});
			end;
		end
	};
	v2.Viscosity = {
		Description = "If this Doodle is hit with a contact move, they lower the attack and magical attack of the attacker.", 
		OnHit = function(p165, p166, p167, p168)
			if p168.Contact then
				l__ChangeStats__1(p165, p166, p167, 100, {
					atk = -1, 
					matk = -1
				});
			end;
		end
	};
	v2["Tar Body"] = {
		Description = "When this Doodle is hit with a contact move, they trap the user for three turns.", 
		OnHit = function(p169, p170, p171, p172)
			local v13 = p169:GetItemInfo(p171);
			if p172.Contact and p171.Trapped == nil then
				if not v13.Grease then
					p171.Trapped = 4;
					p171.TrappedBy = p170.ID;
					p169:AddDialogue(p169.ActionList, "&DOODLENAME," .. p171.ID .. "& becomes trapped due to Tar Body!");
					return;
				end;
			else
				return;
			end;
			p169:AddDialogue(p169.ActionList, "&DOODLENAME," .. p171.ID .. "& cannot be trapped due to Grease!");
		end
	};
	v2.Sticky = {
		Description = "If this Doodle is hit with a contact move, they lower the attacker\226\128\153s speed.", 
		OnHit = function(p173, p174, p175, p176)
			if p176.Contact then
				l__ChangeStats__1(p173, p174, p175, 100, {
					spe = -1
				});
			end;
		end
	};
	v2.Concentrated = {
		Description = "This Doodle's concentration is intense, preventing it from flinching.", 
		ImmuneStatus = { "Flinch" }, 
		StatusFunc = function(p177, p178, p179, p180, p181)
			if p180 ~= "Flinch" then
				return p180, p181;
			end;
			return "Flinch", 0, "&DOODLENAME," .. p179.ID .. "& is immune to flinching!";
		end
	};
	v2.Restless = {
		Description = "This Doodle can\226\128\153t fall asleep.", 
		ImmuneStatus = { "Sleep" }, 
		StatusFunc = function(p182, p183, p184, p185, p186)
			if p185 ~= "Sleep" then
				return p185, p186;
			end;
			local v14 = false;
			if p186 >= 100 then
				v14 = "&DOODLENAME," .. p184.ID .. "& can't fall asleep!";
			end;
			return "Sleep", 0, v14;
		end
	};
	v2.Nonchalant = {
		Description = "This Doodle does not rage or fall for taunts.", 
		ImmuneStatus = { "Rage" }, 
		ImmuneTaunt = true, 
		StatusFunc = function(p187, p188, p189, p190, p191)
			if p190 ~= "Rage" then
				return p190, p191;
			end;
			local v15 = nil;
			if p191 == 100 and p190.Name == "Rage" then
				v15 = "&DOODLENAME," .. p189.ID .. "& is immune to raging!";
			end;
			return p190, 0, v15;
		end
	};
	v2.Careless = {
		Description = "This Doodle can\226\128\153t be enraged or confused.", 
		ImmuneStatus = { "Confuse", "Rage" }, 
		StatusFunc = function(p192, p193, p194, p195, p196)
			if p195 ~= "Confuse" and p195 ~= "Rage" then
				return p195, p196;
			end;
			local v16 = nil;
			if p196 == 100 then
				if p195.Name == "Confuse" then
					v16 = "&DOODLENAME," .. p194.ID .. "& can't get confused!";
				elseif p195.Name == "Rage" then
					v16 = "&DOODLENAME," .. p194.ID .. "& is immune to raging!";
				end;
			end;
			return p195, 0, v16;
		end
	};
	v2["Bright Lights"] = {
		Description = "This Doodle is immune to Dark-type attacks.", 
		ModifyDefendDamage = function(p197, p198, p199, p200, p201, p202, p203)
			if p200.Type ~= "Dark" then
				return 1;
			end;
			if p203 == nil then
				p197:AddDialogue(p197.ActionList, "&DOODLENAME," .. p199.ID .. "& is immune to Dark-type attacks due to Bright Lights!");
			end;
			return 0;
		end
	};
	v2.Caliginous = {
		Description = "This Doodle is immune to Light-type attacks.", 
		ModifyDefendDamage = function(p204, p205, p206, p207, p208, p209, p210)
			if p207.Type ~= "Light" then
				return 1;
			end;
			if p210 == nil then
				p204:AddDialogue(p204.ActionList, "&DOODLENAME," .. p206.ID .. "& is immune to Light-type attacks due to Caliginous!");
			end;
			return 0;
		end
	};
	v2.Dauntless = {
		Description = "If this Doodle has a status condition, they do 50% more magical damage.", 
		OverrideBurnModifier = true, 
		ModifyDamage = function(p211, p212, p213, p214)
			if p214.Category == "Magical" and p212.Status then
				return 1.5;
			end;
			return 1;
		end
	};
	v2["Fireproof Armor"] = {
		Description = "This Doodle takes half damage from Fire-type attacks.", 
		ModifyDefendDamage = function(p215, p216, p217, p218, p219, p220, p221)
			if p218.Type == "Fire" then
				return 0.5;
			end;
			return 1;
		end
	};
	v2["Pecking Order"] = {
		Description = "Lower power attacks do 25% less damage to this Doodle.", 
		ModifyDefendDamage = function(p222, p223, p224, p225, p226, p227, p228)
			if p225.Power and typeof(p225.Power) == "number" and p225.Power <= 60 then
				return 0.75;
			end;
			return 1;
		end
	};
	v2.Nitelite = {
		Description = "This Doodle takes 50% less damage from Dark-type attacks.", 
		ModifyDefendDamage = function(p229, p230, p231, p232, p233, p234, p235)
			if p232.Type == "Dark" then
				return 0.5;
			end;
			return 1;
		end
	};
	v2["Holy Water"] = {
		Description = "This Doodle restores 25% of their health after using a Water or Light-type support move.", 
		BattleFunc = function(p236, p237, p238, p239)
			if p239.Category == "Passive" and (p239.Type == "Water" or p239.Type == "Light") then
				local v17 = math.floor(p237.Stats.hp / 4);
				if v17 > 0 and p237.currenthp < p237.Stats.hp then
					p236:AddDialogue(p236.ActionList, "&DOODLENAME," .. p237.ID .. "& restored health!");
					p236:TakeDamage(p237, -v17);
				end;
			end;
		end
	};
	v2["Air Current"] = {
		Description = "This Doodle\226\128\153s Air-type attacks do 30% more damage when this Doodle is at full health.", 
		ModifyDamage = function(p240, p241, p242, p243)
			if p243.Type == "Air" and p241.currenthp == p241.Stats.hp then
				return 1.3;
			end;
			return 1;
		end
	};
	v2["Rubber Tissue"] = {
		Description = "This Doodle is immune to Spark-type attacks.", 
		ModifyDefendDamage = function(p244, p245, p246, p247, p248, p249, p250)
			if p247.Type ~= "Spark" then
				return 1;
			end;
			if p250 == nil then
				p244:AddDialogue(p244.ActionList, "&DOODLENAME," .. p246.ID .. "& is immune to Spark-type attacks!");
			end;
			return 0;
		end
	};
	v2.Adipose = {
		Description = "This Doodle takes half damage from Fire and Ice-type attacks.", 
		ModifyDefendDamage = function(p251, p252, p253, p254, p255, p256, p257)
			if p254.Type ~= "Fire" and p254.Type ~= "Ice" then
				return 1;
			end;
			return 0.5;
		end
	};
	v2["Edible Treat"] = {
		Description = "If this Doodle faints, they fully restore their ally\226\128\153s health.", 
		SendOut = function(p258, p259, p260, p261)
			p259.OnFaint = p259.OnFaint or {};
			p259.OnFaintTargets.EdibleTreat = "Ally";
			p259.EdibleTreat = true;
			if not p259.OnFaint.EdibleTreat then
				p259.OnFaint.EdibleTreat = function(p262, p263, p264)
					if p259.EdibleTreat and p262.Format == "Doubles" and p264.currenthp > 0 and p264.currenthp < p264.Stats.hp then
						p262:AddDialogue(p262.ActionList, "&DOODLENAME," .. p259.ID .. "&" .. " healed their ally, " .. "&DOODLENAME," .. p264.ID .. "&!");
						p262:TakeDamage(p264, -math.round(p259.Stats.hp));
					end;
				end;
			end;
		end
	};
	v2["Chemical Explosion"] = {
		Description = "If this Doodle faints, damages all opposing Doodles by 25% of their max health.", 
		SendOut = function(p265, p266, p267, p268)
			p266.OnFaint = p266.OnFaint or {};
			p266.OnFaintTargets.ChemicalExplosion = "AllFoes";
			p266.ChemicalExplosion = true;
			if not p266.OnFaint.ChemicalExplosion then
				p266.OnFaint.ChemicalExplosion = function(p269, p270, p271)
					if p266.ChemicalExplosion then
						p269:AddDialogue(p269.ActionList, "&DOODLENAME," .. p266.ID .. "& exploded!");
						p269:TakeDamage(p271, math.floor(p271.Stats.hp / 4), nil, nil, true);
						p269:CheckFaint();
					end;
				end;
			end;
		end
	};
	v2["Balloon Pop"] = {
		Description = "If this Doodle faints, they lower the attack, magical attack, and speed of opposing Doodles.", 
		SendOut = function(p272, p273, p274, p275)
			p273.OnFaint = p273.OnFaint or {};
			p273.OnFaintTargets.BalloonPop = "AllFoes";
			p273.BalloonPop = true;
			if not p273.OnFaint.BalloonPop then
				p273.OnFaint.BalloonPop = function(p276, p277, p278)
					if p273.BalloonPop and p278.currenthp > 0 then
						p276:AddDialogue(p276.ActionList, "&DOODLENAME," .. p273.ID .. "& made a balloon popping noise!");
						l__ChangeStats__1(p276, p277, p278, 100, {
							matk = -1, 
							spe = -1, 
							atk = -1
						});
					end;
				end;
			end;
		end
	};
	v2.Stormwater = {
		Description = "If this Doodle is hit with a Water-type move, boost their magical attack.", 
		OnHit = function(p279, p280, p281, p282)
			if p280.currenthp > 0 and p282.Type == "Water" then
				l__ChangeStats__1(p279, p280, p280, 100, {
					matk = 1
				});
			end;
		end
	};
	v2.Tangled = {
		Description = "When this Doodle uses a Plant-type attack, they trap the target for three turns.", 
		BattleFunc = function(p283, p284, p285, p286)
			local v18 = p283:GetItemInfo(p285);
			if p286.Type == "Plant" and p285.Trapped == nil then
				if not v18.Grease then
					p285.Trapped = 4;
					p285.TrappedBy = p284.ID;
					p283:AddDialogue(p283.ActionList, "&DOODLENAME," .. p285.ID .. "& is trapped!");
					return;
				end;
			else
				return;
			end;
			p283:AddDialogue(p283.ActionList, "&DOODLENAME," .. p285.ID .. "& cannot be trapped due to Grease!");
		end
	};
	v2.Courteous = {
		Description = "This Doodle takes 25% less damage from high powered attacks, and this Doodle does 25% less damage with high powered attacks.", 
		ModifyDamage = function(p287, p288, p289, p290)
			if typeof(p290.Power) == "number" and p290.Power >= 100 then
				return 0.75;
			end;
			return 1;
		end, 
		ModifyDefendDamage = function(p291, p292, p293, p294, p295, p296, p297)
			if typeof(p294.Power) == "number" and p294.Power >= 100 then
				return 0.75;
			end;
			return 1;
		end
	};
	v2["Hard Candy"] = {
		Description = "When this Doodle uses a Food-type attack, they have a 50% chance to boost their defense.", 
		BattleFunc = function(p298, p299, p300, p301)
			if p301.Type == "Food" then
				l__ChangeStats__1(p298, p299, p299, 50, {
					def = 1
				});
			end;
		end
	};
	v2.Botulism = {
		Description = "This Doodle\226\128\153s Food-type attacks have a 30% chance to poison.", 
		BattleFunc = function(p302, p303, p304, p305)
			if p305.Category ~= "Passive" and p305.Type == "Food" and p304.currenthp > 0 then
				l__InflictStatus__2(p302, p303, p304, 30, "Poison", nil, "&DOODLENAME," .. p304.ID .. "&" .. " became poisoned because of " .. "&DOODLENAME," .. p303.ID .. "&' Botulism!");
			end;
		end
	};
	v2.Arsonist = {
		Description = "This Doodle\226\128\153s attacks have a 20% chance to burn.", 
		BattleFunc = function(p306, p307, p308, p309)
			if p309.Category ~= "Passive" and p308.currenthp > 0 then
				l__InflictStatus__2(p306, p307, p308, 20, "Burn", nil, "&DOODLENAME," .. p308.ID .. "&" .. " became burned because of " .. "&DOODLENAME," .. p307.ID .. "&' Arsonist!");
			end;
		end
	};
	v2["Mark Territory"] = {
		Description = "This Doodle\226\128\153s Beast-type attacks have a 50% chance to mark the target.", 
		BattleFunc = function(p310, p311, p312, p313)
			if p313.Type == "Beast" and p313.Category ~= "Passive" and p312.currenthp > 0 then
				l__InflictStatus__2(p310, p311, p312, 50, "Marked", nil, "&DOODLENAME," .. p312.ID .. "&" .. " became marked because of " .. "&DOODLENAME," .. p311.ID .. "&'s Mark Territory!");
			end;
		end
	};
	v2["Virulent Venom"] = {
		Description = "This Doodle\226\128\153s attacks have a 20% chance to poison.", 
		BattleFunc = function(p314, p315, p316, p317)
			if p317.Category ~= "Passive" and p316.currenthp > 0 then
				l__InflictStatus__2(p314, p315, p316, 20, "Poison", nil, "&DOODLENAME," .. p316.ID .. "&" .. " became poisoned because of " .. "&DOODLENAME," .. p315.ID .. "&'s Virulent Venom!");
			end;
		end
	};
	v2["Time Paralysis"] = {
		Description = "This Doodle\226\128\153s attacks have a 10% chance to paralyze.", 
		BattleFunc = function(p318, p319, p320, p321)
			if p321.Category ~= "Passive" and p320.currenthp > 0 and not l__Utilities__1.IsType(p320, "Earth") then
				l__InflictStatus__2(p318, p319, p320, 10, "Paralysis", nil, "&DOODLENAME," .. p320.ID .. "&" .. " became paralyzed because of " .. "&DOODLENAME," .. p319.ID .. "&'s Time Paralysis!");
			end;
		end
	};
	v2["Mind Control"] = {
		Description = "This Doodle\226\128\153s attacks have a 10% chance to enrage the target.", 
		BattleFunc = function(p322, p323, p324, p325)
			if p325.Category ~= "Passive" and p324.currenthp > 0 then
				l__InflictStatus__2(p322, p323, p324, 10, "Rage", nil, "&DOODLENAME," .. p324.ID .. "&" .. " is now angry because of " .. "&DOODLENAME," .. p323.ID .. "&'s Mind Control!");
			end;
		end
	};
	v2["Dust Dash"] = {
		Description = "This Doodle's speed is doubled during Sandstorm.", 
		ModifySpeed = function(p326, p327, p328)
			if p326.Weather ~= "Sandstorm" then
				return p328;
			end;
			return p328 * 2;
		end
	};
	v2["Scarf Down"] = {
		Description = "This Doodle's speed is doubled during Chocolate Rain.", 
		ModifySpeed = function(p329, p330, p331)
			if p329.Weather ~= "Chocolate Rain" then
				return p331;
			end;
			return p331 * 2;
		end
	};
	v2.Snailspeed = {
		Description = "In battle, this Doodle's speed is set to 1.", 
		ModifySpeed = function(p332, p333, p334)
			return 1;
		end
	};
	v2["Time Stop"] = {
		Description = "This Doodle always strikes first.", 
		PrioritySet = function(p335, p336, p337, p338)
			return p338 + 1;
		end
	};
	v2.Durable = {
		Description = "This Doodle can't be knocked out in one hit if they are at full health.", 
		DuringDamageCalc = function(p339, p340, p341, p342, p343)
			if typeof(p343) == "number" and p343 > 0 and p341.Stats.hp <= p343 and p341.Stats.hp <= p341.currenthp then
				p339:AddDialogue(p339.ActionList, "&DOODLENAME," .. p341.ID .. "& held on thanks to its Durable trait!");
				p343 = p341.Stats.hp - 1;
			end;
			return p343;
		end
	};
	v2.Fortified = {
		Description = "This Doodle is immune to critical hits.", 
		NoCrits = true
	};
	v2.Precise = {
		Description = "This Doodle is more likely to critical hit.", 
		CritApply = true
	};
	v2.Chlorokinesis = {
		Description = " If this Doodle is hit with a Plant-type attack, their next Mind-type attack does double damage.", 
		Chlorokinesis = true, 
		SendOut = function(p344, p345, p346, p347)
			p345.Chlorokinesis = true;
			p345.OnHit = p345.OnHit or {};
			p345.OnHit.Chlorokinesis = function(p348, p349, p350, p351)
				if p348:GetTraitInfo(p345).Chlorokinesis and p345.Chlorokinesis and p345.currenthp > 0 and p351.Type == "Grass" then
					p348:AddDialogue(p348.ActionList, "&DOODLENAME," .. p345.ID .. "&'s next Mind-type attack is boosted!");
					p348.BuffNextDamage = "Mind";
				end;
			end;
		end
	};
	v2.Entangle = {
		Description = "This Doodle stops attackers from switching out from damaging pivot moves such as Hit-n-Run and Takeout.", 
		DisablePivot = true
	};
	v2.Crispy = {
		Description = "This Doodle does 75% more damage while burned, but takes 25% damage from burn at the end of each turn.", 
		OverrideBurnModifier = true, 
		Crispy = true, 
		ModifyDamage = function(p352, p353, p354, p355)
			if p353.Status == "Burn" then
				return 1.75;
			end;
			return 1;
		end
	};
	v2["True Power"] = {
		Description = "When this Doodle is at low health, they do double damage.", 
		ModifyDamage = function(p356, p357, p358, p359)
			if p357.currenthp < p357.Stats.hp / 4 then
				return 2;
			end;
			return 1;
		end
	};
	v2.Stonefaced = {
		Description = "This Doodle\226\128\153s stats can\226\128\153t be lowered by other Doodles.", 
		NoStatLower = true
	};
	v2["Fire Up"] = {
		Description = "This Doodle's Fire-type moves become boosted if it's hit by one. They are also immune to Fire-type moves.", 
		DuringDamageCalc = function(p360, p361, p362, p363, p364)
			if (p364 == "Passive" or p364 > 0) and p361 ~= p362 and p363.Type == "Fire" then
				p364 = 0;
				p360:AddDialogue(p360.ActionList, "&DOODLENAME," .. p362.ID .. "& absorbed the Fire-type attack!");
				if not p362.FireUp then
					p362.FireUp = true;
					p360:AddDialogue(p360.ActionList, "&DOODLENAME," .. p362.ID .. "&'s Fire-type attacks became stronger!");
				end;
			end;
			return p364;
		end
	};
	v2.Conductor = {
		Description = "This Doodle's magical attack is boosted if hit by a Spark-type attack. They are also immune to Spark-type moves.", 
		DuringDamageCalc = function(p365, p366, p367, p368, p369)
			if (p369 == "Passive" or p369 > 0) and p366 ~= p367 and p368.Type == "Spark" then
				p369 = 0;
				p365:AddDialogue(p365.ActionList, "&DOODLENAME," .. p367.ID .. "& absorbed the Spark-type attack!");
				l__ChangeStats__1(p365, p367, p367, 100, {
					matk = 1
				});
			end;
			return p369;
		end, 
		ImmuneStatus = { "Paralysis" }
	};
	v2.Levitate = {
		Description = "This Doodle is immune to damaging Earth-type attacks.", 
		Levitate = true, 
		DuringDamageCalc = function(p370, p371, p372, p373, p374)
			if typeof(p374) == "number" and p374 > 0 and p371 ~= p372 and p373.Type == "Earth" then
				p374 = 0;
				p370:AddDialogue(p370.ActionList, "&DOODLENAME," .. p372.ID .. "& made the Earth-type move miss because of Levitate!");
			end;
			return p374;
		end
	};
	v2["Water Absorb"] = {
		Description = "This Doodle restores health if hit by a Water-type move instead of taking damage.", 
		DuringDamageCalc = function(p375, p376, p377, p378, p379)
			if (p379 == "Passive" or p379 > 0) and p376 ~= p377 and p378.Type == "Water" then
				p379 = 0;
				p375:AddDialogue(p375.ActionList, "&DOODLENAME," .. p377.ID .. "& absorbed the Water-type attack!");
				if p377.currenthp < p377.Stats.hp then
					p375:TakeDamage(p377, -math.floor(p377.Stats.hp / 2));
					p375:AddDialogue(p375.ActionList, "&DOODLENAME," .. p377.ID .. "& restored health!");
				end;
			end;
			return p379;
		end
	};
	v2["Poison Absorb"] = {
		Description = "This Doodle restores health if hit by a Poison-type move instead of taking damage.", 
		ImmuneStatus = { "Poison", "Diseased" }, 
		DuringDamageCalc = function(p380, p381, p382, p383, p384)
			if (p384 == "Passive" or p384 > 0) and p381 ~= p382 and p383.Type == "Poison" then
				p384 = 0;
				p380:AddDialogue(p380.ActionList, "&DOODLENAME," .. p382.ID .. "& absorbed the Poison-type attack!");
				if p382.currenthp < p382.Stats.hp then
					p380:TakeDamage(p382, -math.floor(p382.Stats.hp / 2));
					p380:AddDialogue(p380.ActionList, "&DOODLENAME," .. p382.ID .. "& restored health!");
				end;
			end;
			return p384;
		end
	};
	v2["Trump Card"] = {
		Description = "If this Doodle has a status condition, they do 50% more physical damage.", 
		OverrideBurnModifier = true, 
		ModifyDamage = function(p385, p386, p387, p388)
			if p388.Category == "Physical" and p386.Status then
				return 1.5;
			end;
			return 1;
		end
	};
	v2.Opportunist = {
		Description = "This Doodle does 25% more damage to targets with a status condition.", 
		ModifyDamage = function(p389, p390, p391, p392)
			if p391.Status then
				return 1.25;
			end;
			return 1;
		end
	};
	v2.Chanting = {
		Description = "This Doodle\226\128\153s sound-based moves do more damage when used consecutively.", 
		ModifyDamage = function(p393, p394, p395, p396)
			if not p396.Sound then
				return 1;
			end;
			return p394.ChantingMultiplier and 1;
		end, 
		BattleFunc = function(p397, p398, p399, p400)
			if p400.Sound then
				p398.ChantingMultiplier = p398.ChantingMultiplier and 1;
				p398.ChantingMultiplier = math.min(1.5, p398.ChantingMultiplier + 0.1);
			end;
		end
	};
	v2.Serenade = {
		Description = "This Doodle\226\128\153s sound-based moves have a 10% chance to make the target fall asleep.", 
		BattleFunc = function(p401, p402, p403, p404)
			if p404.Sound and p404.Category ~= "Passive" and p402 ~= p403 then
				l__InflictStatus__2(p401, p402, p403, 10, "Sleep", nil, "&DOODLENAME," .. p403.ID .. "&" .. " was put to sleep because of " .. "&DOODLENAME," .. p402.ID .. "&'s Serenade!");
			end;
		end
	};
	v2["Sand Surge"] = {
		Description = "This Doodle\226\128\153s attacks do 30% more damage while there is a sandstorm.", 
		ModifyDamage = function(p405, p406, p407, p408)
			if p405.Weather == "Sandstorm" then
				return 1.3;
			end;
			return 1;
		end
	};
	v2.Galvanize = {
		Description = "This Doodle\226\128\153s Basic-type moves become Spark-type, and do 30% more damage.", 
		ModifyDamage = function(p409, p410, p411, p412)
			if p412.Type ~= "Basic" then
				return 1;
			end;
			p412.Type = "Spark";
			return 1.3;
		end
	};
	v2.Routine = {
		Description = "Attack moves that are the same type as this Doodle do 50% more damage.", 
		BetterSTAB = true
	};
	v2["Jelly Enhancer"] = {
		Description = "This Doodle enhances the effects of jellies it is holding.", 
		BetterJelly = true
	};
	v2["Jelly Lover"] = {
		Description = "This Doodle has a 50% chance to create another jelly after they consume one.", 
		EndTurn = function(p413, p414)
			if math.random(1, 2) == 1 and p414.HeldItem == nil and p414.Doodle.HeldItem and (p414.Doodle.HeldItem:find("Jelly") and not p414.NoRegen) then
				local l__HeldItem__19 = p414.Doodle.HeldItem;
				p413:AddDialogue(p413.ActionList, "&DOODLENAME," .. p414.ID .. "&" .. "'s Jelly Lover created another " .. l__HeldItem__19 .. "!");
				p414.HeldItem = l__HeldItem__19;
			end;
		end
	};
	v2.Apparition = {
		Description = "This Doodle\226\128\153s sound-based moves become Spirit-type.", 
		ModifyDamage = function(p415, p416, p417, p418)
			if p418.Sound then
				p418.Type = "Spirit";
			end;
			return 1;
		end
	};
	v2.Hypothermia = {
		Description = "If an opposing Doodle is frozen, they take damage at the end of each turn.", 
		EndTurnSpecific = function(p419, p420, p421)
			if p420.currenthp > 0 and p421.Status == "Frozen" then
				p419:TakeDamage(p421, (math.floor(p421.Stats.hp / 8)));
				p419:AddDialogue(p419.ActionList, "&DOODLENAME," .. p421.ID .. "&" .. " took damage from " .. "&DOODLENAME," .. p420.ID .. "&'s Hypothermia!");
			end;
		end
	};
	v2.Stitching = {
		Description = "This Doodle restores some health after getting hit with a contact move.", 
		OnHit = function(p422, p423, p424, p425)
			if p423.currenthp > 0 and p423.currenthp < p423.Stats.hp and p425.Contact then
				p422:TakeDamage(p423, -math.floor(p423.Stats.hp / 16));
				p422:AddDialogue(p422.ActionList, "&DOODLENAME," .. p423.ID .. "& restored health from its Stitching!");
			end;
		end
	};
	v2["Caloric Deficit"] = {
		Description = "This Doodle\226\128\153s Food-type moves do 30% more damage, but at the cost of health.", 
		ModifyDamage = function(p426, p427, p428, p429)
			if p429.Type == "Food" then
				return 1.3;
			end;
			return 1;
		end, 
		BattleFunc = function(p430, p431, p432, p433)
			if p433.Category ~= "Passive" and p433.Type == "Food" then
				p430:TakeDamage(p431, (math.floor(p431.Stats.hp / 8)));
				p430:AddDialogue(p430.ActionList, "&DOODLENAME," .. p431.ID .. "& lost health!");
			end;
		end
	};
	v2.Spool = {
		Description = "This Doodle\226\128\153s Basic-type moves do more damage, but at the cost of health.", 
		ModifyDamage = function(p434, p435, p436, p437)
			if p437.Type == "Basic" then
				return 1.2;
			end;
			return 1;
		end, 
		BattleFunc = function(p438, p439, p440, p441)
			if p441.Category ~= "Passive" and p441.Type == "Basic" then
				p438:TakeDamage(p439, (math.floor(p439.Stats.hp / 8)));
				p438:AddDialogue(p438.ActionList, "&DOODLENAME," .. p439.ID .. "& lost health!");
			end;
		end
	};
	local v20 = {
		Description = "When this doodle is sent out, create a temporary wind barrier that boosts allies' speed for 5 turns.", 
		Target = "Side"
	};
	function v20.SendOut(p442, p443, p444)
		if not p442:GetSideFromDoodle(p444).Sylphid then
			p442:AddDialogue(p442.ActionList, "&DOODLENAME," .. p443.ID .. "& creates a wind barrier!");
			p1.Database.Moves.Sylphid.BattleFunc(p442, p443, p443);
		end;
	end;
	v2["Wind's Favor"] = v20;
	v2.Refresh = {
		Description = "When this doodle is sent out, they heal themselves for 30% of their health total.", 
		Target = "Side", 
		SendOut = function(p445, p446, p447)
			if p446.currenthp > 0 and p446.currenthp < p446.Stats.hp then
				local v21 = math.floor(p446.Stats.hp * 0.3);
				p445:AddDialogue(p445.ActionList, "&DOODLENAME," .. p446.ID .. "& refreshed some of their health!");
				p445:TakeDamage(p446, -v21);
			end;
		end
	};
	v2.Crystalline = {
		Description = "When this doodle is sent out, create a temporary crystal wall that halves the opponent's physical damage.", 
		Target = "Side", 
		SendOut = function(p448, p449, p450)
			if not p448:GetSideFromDoodle(p450).CrystalWall then
				p448:AddDialogue(p448.ActionList, "&DOODLENAME," .. p449.ID .. "& creates a Crystal Wall!");
				p1.Database.Moves["Crystal Wall"].BattleFunc(p448, p449, p449);
			end;
		end
	};
	v2.Ugly = {
		Description = "When this doodle is sent out, taunt all opponents for 1 turn. Taunted opponents can't use Support moves.", 
		BeforeSendOut = function(p451, p452)
			p451:AddDialogue(p451.ActionList, "&DOODLENAME," .. p452.ID .. "& is very ugly!");
		end, 
		SendOut = function(p453, p454, p455)
			if not p455.Taunt then
				p1.Database.Moves.Taunt.BattleFunc(p453, p454, p455, nil, {
					Turns = 1
				});
			end;
		end
	};
	v2["Chocolate Drizzle"] = {
		Description = "When this Doodle is sent out into battle, they summon Chocolate Rain.", 
		SendOut = function(p456, p457, p458)
			if p456.Weather ~= "Chocolate Rain" then
				p1.Database.Moves["Chocolate Rain"].BattleFunc(p456, p457, p457);
			end;
		end
	};
	v2["Poison Precipitation"] = {
		Description = "When this Doodle is sent out into battle, they summon Acid Rain.", 
		SendOut = function(p459, p460, p461)
			if p459.Weather ~= "Acid Rain" then
				p1.Database.Moves["Acid Rain"].BattleFunc(p459, p460, p460);
			end;
		end
	};
	v2["Dust Storm"] = {
		Description = "When this Doodle is sent out into battle, they summon Sandstorm.", 
		SendOut = function(p462, p463, p464)
			if p462.Weather ~= "Sandstorm" then
				p1.Database.Moves.Sandstorm.BattleFunc(p462, p463, p463);
			end;
		end
	};
	v2["Sand Screen"] = {
		Description = "During a Sandstorm, this Doodle takes half damage from all attacks.", 
		ModifyDefendDamage = function(p465, p466, p467, p468, p469, p470, p471)
			if p465.Weather == "Sandstorm" then
				return 0.5;
			end;
			return 1;
		end
	};
	v2["Spell Shield"] = {
		Description = "This Doodle takes half damage from magical attacks.", 
		Target = "Side", 
		ModifyDefendDamage = function(p472, p473, p474, p475, p476, p477, p478)
			if p475.Category == "Magical" then
				return 0.5;
			end;
			return 1;
		end
	};
	v2.Relentless = {
		Description = "This Doodle's speed can't be lowered.", 
		PreventStatDisable = { "spe" }
	};
	v2.Arid = {
		Description = "If it\226\128\153s raining when this Doodle is sent out into battle, it stops raining.", 
		SendOut = function(p479, p480, p481)
			if p479.Weather == "Acid Rain" or p479.Weather == "Rain" or p479.Weather == "Chocolate Rain" then
				p479:AddDialogue(p479.ActionList, "&DOODLENAME," .. p480.ID .. "&'s Arid trait made it stop raining!");
				p479:AddDialogue(p479.ActionList, "The rain stopped.");
				p479.Weather = nil;
				p479.WeatherTurns = 0;
				p479:AddAction(p479.ActionList, {
					Action = "StopWeather"
				});
			end;
		end
	};
	v2.Corrosion = {
		Description = "When this Doodle is sent out into battle, they clear a random entry hazard from your side of the field.", 
		Target = "Side", 
		SendOut = function(p482, p483, p484)
			local v22 = p482:GetOppositeSideFromDoodle(p484);
			local v23 = {};
			local v24 = {
				YarnSnare = "Yarn Snare", 
				EntanglingVines = "Entangling Vines"
			};
			if v22.EntryHazards then
				for v25, v26 in pairs(v22.EntryHazards) do
					if v24[v25] then
						table.insert(v23, v25);
					end;
				end;
			end;
			if #v23 > 0 then
				local v27 = v23[math.random(#v23)];
				v22.EntryHazards[v27] = nil;
				p482:AddDialogue(p482.ActionList, "&DOODLENAME," .. p483.ID .. "&" .. "'s Corrosion destroyed the enemy's " .. v24[v27] .. "!");
			end;
		end
	};
	v2.Unraveling = {
		Description = "If this Doodle is hit with a super effective attack, boost their speed.", 
		OnHit = function(p485, p486, p487, p488)
			if p486.currenthp > 0 and p1.Database.Typings:GetEffectiveness(p487, p486, p488.Type) > 1 then
				l__ChangeStats__1(p485, p486, p486, 100, {
					spe = 1
				});
			end;
		end
	};
	v2["Poisonous Skin"] = {
		Description = "If this Doodle is hit with a contact move, the attacker has a 20% chance to become poisoned.", 
		OnHit = function(p489, p490, p491, p492)
			if p492.Contact then
				l__InflictStatus__2(p489, p490, p491, 20, "Poison", nil, "&DOODLENAME," .. p491.ID .. "&" .. " became poisoned because of " .. "&DOODLENAME," .. p490.ID .. "&'s Poisonous Skin!");
			end;
		end
	};
	v2["Berry Good"] = {
		Description = "When this Doodle gets swapped out, heal the next Doodle that comes in by 15% of their health.", 
		SwapOut = function(p493, p494, p495)
			local v28 = p493:GetSideFromDoodle(p494);
			if not v28.BerryGood then
				p493:AddDialogue(p493.ActionList, "&DOODLENAME," .. p494.ID .. "& left some berries behind!");
				v28.BerryGood = true;
			end;
		end
	};
	v2.Robust = {
		Description = "This Doodle gets cured of any status effects when it gets switched out.", 
		SwapOut = function(p496, p497, p498)
			if p497.Status ~= nil and p497.Status ~= "Faint" then
				p497.Status = nil;
				p496:AddDialogue(p496.ActionList, "&DOODLENAME," .. p497.ID .. "&" .. " cured their " .. p497.Status:lower() .. " status with Robustness!");
				p496:AddAction(p496.ActionList, {
					Player = p497.Owner, 
					Doodle = p497, 
					Action = "StatusAnim", 
					Status = ""
				});
			end;
		end
	};
	v2.Gauze = {
		Description = "This Doodle gets cured of any status effects when it gets switched out.", 
		SwapOut = function(p499, p500, p501)
			if p500.Status ~= nil and p500.Status ~= "Faint" then
				p500.Status = nil;
				p499:AddDialogue(p499.ActionList, "&DOODLENAME," .. p500.ID .. "&" .. " cured their " .. p500.Status:lower() .. " status with Gauze!");
				p499:AddAction(p499.ActionList, {
					Player = p500.Owner, 
					Doodle = p500, 
					Action = "StatusAnim", 
					Status = ""
				});
			end;
		end
	};
	v2.Leech = {
		Description = "This Doodle\226\128\153s Insect-type attacks restore them for half the damage done.", 
		BattleFunc = function(p502, p503, p504, p505, p506)
			if typeof(p506) == "number" and p506 > 0 and p505.Type == "Insect" then
				local v29 = math.floor(p506 / 2);
				local v30 = p502:GetTraitInfo(p504);
				if v29 > 0 and p503.currenthp < p503.Stats.hp then
					if v30.Tainted then
						v29 = -v29;
					end;
					p502:AddAction(p502.ActionList, {
						Player = p504.Owner, 
						User = p503, 
						Doodle = p504, 
						Action = "PlayAnim", 
						Move = "Leaf Sap"
					});
					if v29 > 0 then
						p502:AddDialogue(p502.ActionList, "&DOODLENAME," .. p503.ID .. "& restored health!");
					else
						p502:AddDialogue(p502.ActionList, "&DOODLENAME," .. p503.ID .. "&" .. " took damage from &DOODLENAME," .. p504.ID .. "& Tainted trait!");
					end;
					p502:TakeDamage(p503, -v29);
				end;
			end;
		end
	};
	v2.Rejuvenator = {
		Description = "This Doodle restores 25% more health than normal.", 
		ExtraHeal = 1.25
	};
	v2.Herbivore = {
		Description = "This Doodle restores health if hit by a Plant-type move instead of taking damage.", 
		DuringDamageCalc = function(p507, p508, p509, p510, p511)
			if (p511 == "Passive" or p511 > 0) and p508 ~= p509 and p510.Type == "Plant" then
				p511 = 0;
				p507:AddDialogue(p507.ActionList, "&DOODLENAME," .. p509.ID .. "& absorbed the Plant-type attack!");
				if p509.currenthp < p509.Stats.hp then
					p507:TakeDamage(p509, -math.floor(p509.Stats.hp / 2));
					p507:AddDialogue(p507.ActionList, "&DOODLENAME," .. p509.ID .. "& restored health!");
				end;
			end;
			return p511;
		end
	};
	v2["Pollen Armor"] = {
		Description = "If this Doodle is hit with a contact move, the attacker has a 20% chance to fall asleep.", 
		OnHit = function(p512, p513, p514, p515)
			if p515.Contact then
				l__InflictStatus__2(p512, p513, p514, 20, "Sleep", nil, "&DOODLENAME," .. p514.ID .. "&" .. " fell asleep because of " .. "&DOODLENAME," .. p513.ID .. "&'s Pollen Armor!");
			end;
		end
	};
	v2["Razor Skin"] = {
		Description = "If this Doodle is hit with a contact move, the attacker becomes vulnerable.", 
		OnHit = function(p516, p517, p518, p519)
			if p519.Contact then
				l__InflictStatus__2(p516, p517, p518, 100, "Vulnerable", nil, "&DOODLENAME," .. p518.ID .. "&" .. " became Vulnerable because of " .. "&DOODLENAME," .. p517.ID .. "&'s Razor Skin!");
			end;
		end
	};
	v2.Electrocute = {
		Description = "If this Doodle is hit with a contact move, the attacker has a 30% chance to become paralyzed.", 
		OnHit = function(p520, p521, p522, p523)
			if p523.Contact and not l__Utilities__1.IsType(p522, "Earth") then
				l__InflictStatus__2(p520, p521, p522, 30, "Paralysis", nil, "&DOODLENAME," .. p522.ID .. "&" .. " became paralyzed because of " .. "&DOODLENAME," .. p521.ID .. "&'s Electrocute!");
			end;
		end
	};
	v2.Chef = {
		Description = "This Doodle does 30% more damage against Food types.", 
		ModifyDamage = function(p524, p525, p526, p527)
			if l__Utilities__1.IsType(p526, "Food") then
				return 1.3;
			end;
			return 1;
		end
	};
	v2.Spooky = {
		Description = "If this Doodle is hit with an attack, the attacker has a 25% chance to become cursed.", 
		OnHit = function(p528, p529, p530, p531)
			if p531.Category == "Physical" or p531.Category == "Magical" then
				l__InflictStatus__2(p528, p529, p530, 25, "Cursed", nil, "&DOODLENAME," .. p530.ID .. "&" .. " became cursed because of " .. "&DOODLENAME," .. p529.ID .. "&'s Spooky trait!");
			end;
		end
	};
	v2.Filament = {
		Description = "This Doodle is immune to Spark-type attacks. If this Doodle is hit by a Spark-type move, their Light-type moves do more damage.", 
		DuringDamageCalc = function(p532, p533, p534, p535, p536)
			if p535.Type == "Spark" and p533 ~= p534 and (p536 == "Passive" or p536 > 0) then
				p536 = 0;
				p534.LightBuff = 1.5;
				p532:AddDialogue(p532.ActionList, "&DOODLENAME," .. p534.ID .. "& absorbed the Spark-type attack!");
				p532:AddDialogue(p532.ActionList, "&DOODLENAME," .. p534.ID .. "&'s Light-type attacks have become stronger!");
				if not p534.ModFuncs.LightBuff then
					p534.ModFuncs.LightBuff = function(p537, p538, p539, p540)
						if p538.LightBuff and p540.Type == "Light" then
							return p538.LightBuff;
						end;
						return 1;
					end;
				end;
			end;
			return p536;
		end
	};
	v2.Hunter = {
		Description = "If this Doodle is in your party, you have an increased chance of finding the Doodle you're chaining. Doesn't stack.", 
		Hunter = true
	};
	v2.Incandescent = {
		Description = "If this Doodle is the first Doodle in your party, you are more likely to encounter higher star Doodles.", 
		HigherStar = true
	};
	v2["Iron Will"] = {
		Description = "This Doodle's attack can't be lowered.", 
		PreventStatDisable = { "atk" }
	};
	v2["Doll Eyes"] = {
		Description = "This Doodle's accuracy can't be lowered.", 
		PreventStatDisable = { "acc" }
	};
	v2["Four Eyes"] = {
		Description = "This Doodle's accuracy can't be lowered.", 
		PreventStatDisable = { "acc" }
	};
	v2["Rule of Cool"] = {
		Description = "This Doodle's not very effective attacks do double damage.", 
		Coolness = true
	};
	v2.Unbreakable = {
		Description = "This Doodle takes 25% less damage from super-effective attacks.", 
		SolidRock = true
	};
	v2.Capoeira = {
		Description = "This Doodle always hits the maximum amount of times when using multi-strike moves.", 
		SkillLink = true
	};
	v2.Lightfooted = {
		Description = "This Doodle\226\128\153s speed can\226\128\153t be lowered. If this Doodle\226\128\153s speed would be lowered, boost their speed instead.", 
		PreventStatDisable = { "spe" }, 
		PreventStatDisableFunc = function(p541, p542, p543, p544)
			p541:AddDialogue(p541.ActionList, "&DOODLENAME," .. p543.ID .. "&'s Lightfooted trait boosted its speed!");
			l__ChangeStats__1(p541, p543, p543, 100, {
				spe = -1 * p544
			});
		end
	};
	v2.Merciless = {
		Description = "When this Doodle's stats are lowered by an opponent, greatly boost this Doodle's attack.", 
		OnStatChange = function(p545, p546, p547, p548, p549)
			if p548 and p546.ID ~= p547.ID and not p545:IsAlly(p547, p546) and p547.Boosts.atk < 6 then
				l__ChangeStats__1(p545, p547, p547, 100, {
					atk = 2
				});
				p547.StatChangeLater = {
					atk = true
				};
				p547.LaterStatString = "&DOODLENAME," .. p547.ID .. "& is Merciless!";
			end;
		end
	};
	v2["Ramming Speed"] = {
		Description = "When this Doodle's speed is boosted, their defense is also boosted.", 
		OnStatSpecificChange = function(p550, p551, p552, p553, p554)
			if p550:GetTraitInfo(p552).Description and p553 and p554 == "spe" and p552.Boosts.def < 6 then
				l__ChangeStats__1(p550, p552, p552, 100, {
					def = 1
				});
				p552.StatChangeLater = {
					def = true
				};
				p552.LaterStatString = "&DOODLENAME," .. p552.ID .. "& has Ramming Speed!";
			end;
		end
	};
	v2.Vengeance = {
		Description = "This Doodle\226\128\153s attacks do 30% more damage if it was attacked this turn.", 
		ModifyDamage = function(p555, p556, p557, p558)
			if #p556.Revenge > 0 then
				return 1.3;
			end;
			return 1;
		end
	};
	v2.Tainted = {
		Description = "This Doodle damages attackers using draining moves instead of restoring their health.", 
		Tainted = true
	};
	v2.Glutton = {
		Description = "This Doodle restores health if hit by a Food-type move instead of taking damage.", 
		DuringDamageCalc = function(p559, p560, p561, p562, p563)
			if (p563 == "Passive" or p563 > 0) and p560 ~= p561 and p562.Type == "Food" then
				p563 = 0;
				p559:AddDialogue(p559.ActionList, "&DOODLENAME," .. p561.ID .. "& absorbed the Food-type attack!");
				if p561.currenthp < p561.Stats.hp then
					p559:TakeDamage(p561, -math.floor(p561.Stats.hp / 2));
					p559:AddDialogue(p559.ActionList, "&DOODLENAME," .. p561.ID .. "& restored health!");
				end;
			end;
			return p563;
		end
	};
	v2.Exoskeleton = {
		Description = "This Doodle takes 30% less damage from contact attacks.", 
		ModifyDefendDamage = function(p564, p565, p566, p567, p568, p569, p570)
			if p567.Contact then
				return 0.7;
			end;
			return 1;
		end
	};
	v2["Titanium Bucket"] = {
		Description = "When this Doodle is sent out into battle, they boost their defense or magical defense, whichever is higher.", 
		Target = "Side", 
		SendOut = function(p571, p572, p573)
			p571:AddDialogue(p571.ActionList, "&DOODLENAME," .. p572.ID .. "& has a titanium bucket!");
			local v31 = "def";
			if p572.Stats.def < p572.Stats.mdef then
				v31 = "mdef";
			end;
			l__ChangeStats__1(p571, p572, p572, 100, {
				[v31] = 1
			});
		end
	};
	v2["Bon Appetit"] = {
		Description = "When this Doodle is sent out into battle, sprinkle Seasoning on opposing Doodles. Food-type Doodles do more damage to seasoned targets.", 
		BeforeSendOut = function(p574, p575)
			p574:AddDialogue(p574.ActionList, "&DOODLENAME," .. p575.ID .. "&'s applied Seasoning to the other team!");
		end, 
		SendOut = function(p576, p577, p578)
			p578.Seasoning = true;
		end
	};
	v2.Crude = {
		Description = "When this Doodle is sent out into battle, they lower the speed of opposing Doodles.", 
		BeforeSendOut = function(p579, p580)
			p579:AddDialogue(p579.ActionList, "&DOODLENAME," .. p580.ID .. "&'s used their Crudeness to try and lower the other team's speed!");
		end, 
		SendOut = function(p581, p582, p583)
			l__ChangeStats__1(p581, p582, p583, 100, {
				spe = -1
			});
		end
	};
	v2["Menacing Snarl"] = {
		Description = "When this Doodle is sent out into battle, they lower the attack of opposing Doodles.", 
		BeforeSendOut = function(p584, p585)
			p584:AddDialogue(p584.ActionList, "&DOODLENAME," .. p585.ID .. "&'s menacing snarl tried to lower the other team's attack!");
		end, 
		SendOut = function(p586, p587, p588)
			l__ChangeStats__1(p586, p587, p588, 100, {
				atk = -1
			});
		end
	};
	v2["Sickly Sweet"] = {
		Description = "When this Doodle is sent out into battle, they lower the magical attack of opposing Doodles.", 
		BeforeSendOut = function(p589, p590)
			p589:AddDialogue(p589.ActionList, "&DOODLENAME," .. p590.ID .. "&'s sweet aroma tried to lower the other team's magic attack!");
		end, 
		SendOut = function(p591, p592, p593)
			l__ChangeStats__1(p591, p592, p593, 100, {
				matk = -1
			});
		end
	};
	v2["Anti-Paralysis"] = {
		Description = "All party members are cured of paralysis when this Doodle is sent out into battle.", 
		SendOut = function(p594, p595, p596, p597)
			local v32 = nil;
			for v33, v34 in pairs(p594:FindSide(p595) == p594.Out1 and p594.Player1Party or p594.Player2Party) do
				if v34.Status == "Paralysis" then
					v34.Status = nil;
					v32 = true;
				end;
			end;
			if v32 then
				p594:AddDialogue(p594.ActionList, "&DOODLENAME," .. p595.ID .. "&'s cured all of their party members' paralysis!");
			end;
		end
	};
	v2.Antivenom = {
		Description = "All party members are cured of poison when this Doodle is sent out into battle.", 
		SendOut = function(p598, p599, p600, p601)
			local v35 = nil;
			for v36, v37 in pairs(p598:FindSide(p599) == p598.Out1 and p598.Player1Party or p598.Player2Party) do
				if v37.Status == "Poison" then
					v37.Status = nil;
					v35 = true;
				end;
			end;
			if v35 then
				p598:AddDialogue(p598.ActionList, "&DOODLENAME," .. p599.ID .. "&'s cured all of their party members' poison!");
			end;
		end
	};
	v2["Ice Stream"] = {
		Description = "This Doodle\226\128\153s Ice-type moves always go first when this Doodle is above half health.", 
		PrioritySet = function(p602, p603, p604, p605)
			if p604.Type ~= "Ice" or not (p603.Stats.hp / 2 <= p603.currenthp) then
				return p605;
			end;
			return p605 + 1;
		end
	};
	v2.Ethereal = {
		Description = "Attacks on this Doodle miss 10% more often.", 
		AccCalc = function(p606, p607, p608, p609)
			local v38 = p609;
			if typeof(v38) == "number" then
				v38 = v38 * 0.9;
			end;
			return v38;
		end
	};
	v2.Duel = {
		Description = "This Doodle never misses or dodges.", 
		AccCalc = function(p610, p611, p612, p613)
			return true;
		end, 
		OffensiveAccCalc = function(p614, p615, p616, p617)
			return true;
		end
	};
	v2.Rapier = {
		Description = "This Doodle\226\128\153s priority moves do 20% more damage.", 
		ModifyDamage = function(p618, p619, p620, p621)
			if p621.Priority and p621.Priority >= 1 then
				return 1.2;
			end;
			return 1;
		end
	};
	v2["Insatiable Greed"] = {
		Description = "This Doodle boosts its highest stat when an opposing Doodle faints.", 
		OnOpposingFaint = function(p622, p623, p624)
			local v39 = "atk";
			for v40, v41 in pairs({ "atk", "def", "mdef", "matk", "mdef" }) do
				if p623.Stats[v39] < p623.Stats[v41] then
					v39 = v41;
				end;
			end;
			p622:AddDialogue(p622.ActionList, "&DOODLENAME," .. p623.ID .. "&'s Insatiable Greed activated!");
			l__ChangeStats__1(p622, p623, p623, 100, {
				[v39] = 1
			});
		end
	};
	v2.Reaper = {
		Description = "This Doodle restores health if an opposing Doodle faints.", 
		OnOpposingFaint = function(p625, p626, p627)
			local v42 = math.round(p626.Stats.hp * 0.3);
			if v42 > 0 and p626.currenthp > 0 and p626.currenthp < p626.Stats.hp and p627.ID ~= p626.ID then
				p625:AddDialogue(p625.ActionList, "&DOODLENAME," .. p626.ID .. "& reaped and recovered health!");
				p625:TakeDamage(p626, -v42);
			end;
		end
	};
	v2.Calm = {
		Description = "This Doodle ignores boosted attack and defense stats.", 
		IgnoreBoosts = true
	};
	v2.Ignorant = {
		Description = "This Doodle ignores boosted attack and defense stats.", 
		IgnoreBoosts = true
	};
	v2.Apathetic = {
		Description = "This Doodle ignores boosted attack and defense stats.", 
		IgnoreBoosts = true
	};
	v2.Hawkeye = {
		Description = "Ignores target's evasion boosts.", 
		IgnoreEvasion = true
	};
	v2.Graceful = {
		Description = "This Doodle never misses.", 
		NeverMiss = true
	};
	v2.Escapist = {
		Description = "Guarantees fleeing from wild Doodles.", 
		FleeGuarantee = true
	};
	v2["Heavy Storms"] = {
		Description = "If this Doodle creates rain, the rain will last 10 turns.", 
		DoubleRain = true
	};
	v2["Slash Expert"] = {
		Description = "This Doodle\226\128\153s slashing moves do 20% more damage.", 
		ModifyDamage = function(p628, p629, p630, p631)
			if p631.Slash then
				return 1.2;
			end;
			return 1;
		end
	};
	v2["Sharp Fangs"] = {
		Description = "This Doodle\226\128\153s biting moves have a 20% chance to make the target vulnerable.", 
		BattleFunc = function(p632, p633, p634, p635)
			if p635.Category ~= "Passive" and p635.Biting and p634.currenthp > 0 then
				l__InflictStatus__2(p632, p633, p634, 20, "Vulnerable", nil, "&DOODLENAME," .. p634.ID .. "&" .. " became Vulnerable because of " .. "&DOODLENAME," .. p633.ID .. "&'s Sharp Fangs!");
			end;
		end
	};
	v2.Overbite = {
		Description = "This Doodle\226\128\153s biting moves do 30% more damage but have 20% less accuracy.", 
		AttackModifier = function(p636, p637, p638, p639)
			if p639.Biting and typeof(p639.Accuracy) == "number" then
				p639.Accuracy = p639.Accuracy * 0.8;
			end;
		end, 
		ModifyDamage = function(p640, p641, p642, p643)
			if p643.Biting then
				return 1.3;
			end;
			return 1;
		end
	};
	v2.Thievery = {
		Description = "When this Doodle uses a contact move, they have a 25% chance to steal the target's held item.", 
		BattleFunc = function(p644, p645, p646, p647)
			local v43 = l__Utilities__1.GetTrait(p646);
			local v44 = p644:GetItemInfo(p646);
			if p646.HeldItem and p647.Contact then
				if math.random(1, 4) > 1 then
					return;
				end;
				if p645.HeldItem then
					p644:AddDialogue(p644.ActionList, "&DOODLENAME," .. p645.ID .. "& already has a held item!");
					return;
				end;
				if v44 and v44.Runestone then
					p644:AddDialogue(p644.ActionList, "&DOODLENAME," .. p645.ID .. "&'s runestone is not able to be stolen!");
					return;
				end;
				if v43 and v43.NoItemSteal then
					p644:AddDialogue(p644.ActionList, "&DOODLENAME," .. p646.ID .. "& is really protective of its held item!");
					return;
				end;
				p644:AddDialogue(p644.ActionList, "&DOODLENAME," .. p645.ID .. "&" .. " stole " .. p646.HeldItem .. " from " .. "&DOODLENAME," .. p646.ID .. "&!");
				p645.HeldItem = p646.HeldItem;
				p646.HeldItem = nil;
				p646.NoUpdateItem = true;
				p645.NoUpdateItem = true;
			end;
		end
	};
	v2.Ward = {
		Description = "This Doodle\226\128\153s held item can never be removed in battle.", 
		NoItemSteal = true
	};
	v2.Dimwitted = {
		Description = "This Doodle does 25% more damage, but they can only use attacks that do damage.", 
		Dimwitted = true
	};
	v2.Premonition = {
		Description = "When this Doodle is sent out into battle, they sense one of the opposing Doodle\226\128\153s moves.", 
		SendOut = function(p648, p649, p650)
			p648:AddDialogue(p648.ActionList, "&DOODLENAME," .. p649.ID .. "&" .. " discovered that " .. "&DOODLENAME," .. p650.ID .. "&" .. " can use " .. p650.Moves[math.random(1, #p650.Moves)].Name .. "!");
		end
	};
	v2.Discover = {
		Description = "When this Doodle is sent out into battle, they discover the held items of opposing Doodles.", 
		SendOut = function(p651, p652, p653)
			if p653.HeldItem then
				p651:AddDialogue(p651.ActionList, "&DOODLENAME," .. p652.ID .. "&" .. " discovered " .. "&DOODLENAME," .. p653.ID .. "&" .. " is holding " .. p653.HeldItem .. "!");
				return;
			end;
			local v45 = false;
			for v46, v47 in pairs(p653.Equip) do
				if not v45 then
					v45 = true;
					break;
				end;
			end;
			if v45 and p651.BattleType == "Wild" then
				p651:AddDialogue(p651.ActionList, "&DOODLENAME," .. p652.ID .. "&" .. " discovered " .. "&DOODLENAME," .. p653.ID .. "& has equipment!");
				return;
			end;
			p651:AddDialogue(p651.ActionList, "&DOODLENAME," .. p652.ID .. "&" .. " discovered " .. "&DOODLENAME," .. p653.ID .. "& is holding nothing!");
		end
	};
	v2.Possession = {
		Description = "This Doodle copies the trait of any Doodle they attack.", 
		BattleFunc = function(p654, p655, p656, p657)
			if p657.Category ~= "Passive" and p655.Ability ~= p656.Ability then
				p654:AddDialogue(p654.ActionList, "&DOODLENAME," .. p655.ID .. "&" .. "'s ability became " .. p656.Ability .. "!");
				p655.Ability = p656.Ability;
				local v48 = p654:GetTraitInfo(p655);
				if v48.SendOut and p655.Ability ~= "Possession" then
					v48.SendOut(p654, p655, p656, p657);
				end;
			end;
		end, 
		SendOut = function(p658, p659, p660, p661)
			p659.Possession = true;
			if not p659.SendOut.Possession then
				p659.SendOut.Possession = function(p662, p663, p664)
					if p663.Possession then
						p663.Ability = "Possession";
						p662:AddDialogue(p662.ActionList, "&DOODLENAME," .. p663.ID .. "& is ready to possess!");
					end;
				end;
			end;
		end
	};
	v2["Light Orb"] = {
		Description = "The next Dark-type attack used this battle does 50% less damage.", 
		SendOut = function(p665, p666, p667)
			if not p665.LightOrb then
				p665.LightOrb = true;
				p665:AddDialogue(p665.ActionList, "&DOODLENAME," .. p666.ID .. "&'s Light Orb trait will cause the next Dark-type attack used to do less damage!");
			end;
		end
	};
	v2["Destructive Anger"] = {
		Description = "This Doodle does 50% more damage if enraged.", 
		ModifyDamage = function(p668, p669, p670, p671)
			if p669.Status == "Rage" then
				return 1.5;
			end;
			return 1;
		end
	};
	v2.Covetous = {
		Description = "This Doodle does 25% more damage if the target has a held item.", 
		ModifyDamage = function(p672, p673, p674, p675)
			if p674.HeldItem ~= nil then
				return 1.25;
			end;
			return 1;
		end
	};
	v2.Envy = {
		Description = "This Doodle does 30% more damage if they don't have a held item.", 
		ModifyDamage = function(p676, p677, p678, p679)
			if p677.HeldItem == nil then
				return 1.3;
			end;
			return 1;
		end
	};
	v2["Direct Combatant"] = {
		Description = "This Doodle can only take damage from attacks.", 
		DirectCombatant = true
	};
	v2.Reflective = {
		Description = "If a support move is used on this Doodle, it is redirected back to the user.", 
		Reflective = true
	};
	v2.Composed = {
		Description = "Rage has no effect on this Doodle.", 
		NoRage = true
	};
	v2["Burning Beast"] = {
		Description = "This Doodle\226\128\153s Beast-type moves have a 20% chance to burn.", 
		BattleFunc = function(p680, p681, p682, p683)
			if p683.Type == "Beast" and p683.Category ~= "Passive" and p682.currenthp > 0 then
				l__InflictStatus__2(p680, p681, p682, 20, "Burn", nil, "&DOODLENAME," .. p682.ID .. "&" .. " got burned because of " .. "&DOODLENAME," .. p681.ID .. "&'s Burning Beast!");
			end;
		end
	};
	v2["Wish For Power"] = {
		Description = "When this Doodle is sent out into battle, they boost their attack or magical attack, depending on the opponent.", 
		Target = "Side", 
		SendOut = function(p684, p685, p686)
			p684:AddDialogue(p684.ActionList, "&DOODLENAME," .. p685.ID .. "& wished for power to be granted!");
			local v49 = "matk";
			if p686.Stats.def < p686.Stats.mdef then
				v49 = "atk";
			end;
			l__ChangeStats__1(p684, p685, p685, 100, {
				[v49] = 1
			});
		end
	};
	v2.Confidence = {
		Description = "This Doodle does 50% more damage to Doodles with higher base stats.", 
		Target = "Side", 
		ModifyDamage = function(p687, p688, p689, p690, p691, p692, p693)
			local v50 = p688:GetTotalBaseStats();
			local v51 = p689:GetTotalBaseStats();
			print("works");
			if v50 < v51 then
				return 1.5;
			end;
			print("no");
			return 1;
		end, 
		SendOut = function(p694, p695, p696)
			p694:AddDialogue(p694.ActionList, "&DOODLENAME," .. p695.ID .. "& has unwavering confidence!");
		end
	};
	v2["Wish For Wealth"] = {
		Description = "When this Doodle is in your party, you gain 30% more money from tamer battles.", 
		MoneyMultiplier = 1.3
	};
	v2["Wish For Experience"] = {
		Description = "This Doodle gains 30% more experience.", 
		ExpMultiplier = 1.3
	};
	v2["No trait"] = {
		Description = "This doodle doesn't have a trait."
	};
	return v2;
end;
