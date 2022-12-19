-- Decompiled with the Synapse X Luau decompiler.

local u1 = {};
return function(p1)
	local l__Utilities__1 = p1.Utilities;
	u1.ShopRequirements = {
		["Basic Capsule"] = { "Starter", 1 }, 
		["Striped Capsule"] = { "1stKey", 2 }, 
		["Medical Capsule"] = { "CapsuleQuest", 3 }, 
		["Heart Capsule"] = { "CapsuleQuest", 4 }, 
		["Dense Capsule"] = { "CapsuleQuest", 5 }, 
		["Gold Capsule"] = { "Starter", 6 }, 
		Bandage = { "Starter", 7 }, 
		["Super Bandage"] = { "1stKey", 8 }, 
		Antidote = { "Starter", 9 }, 
		["Anti-Paralysis Spray"] = { "Starter", 10 }, 
		["Anti-Sleep Spray"] = { "1stKey", 11 }, 
		["Tint Scraper"] = { "1stKey", 12 }, 
		["Stat Candy"] = { "Starter", 13 }, 
		["Level-Down Cube"] = { "Starter", 14 }, 
		["Level-Up Cube"] = { "Starter", 15 }, 
		["Swarm Snack"] = { "Starter", 16 }, 
		["Lesser Chain Ticket"] = { "Starter", 17 }, 
		["Greater Chain Ticket"] = { "Starter", 18 }, 
		["Doodle Unlocker"] = { "Starter", 19 }
	};
	local v2 = {
		Description = "These bandages heal a Doodle by 25 HP.", 
		Target = "Party", 
		Category = "Medicine", 
		Price = 400, 
		Image = "http://www.roblox.com/asset/?id=8736096006"
	};
	function v2.Function(p2, p3, p4)
		local v3 = l__Utilities__1:GetStats(p2);
		if p2.currenthp == v3.hp then
			return (p2.Nickname or p2.Name) .. " is already at full health!";
		end;
		if p2.currenthp == 0 then
			return "You can't use Bandage on a fainted doodle!";
		end;
		if not game:GetService("RunService"):IsServer() then
			return "You used Bandage on " .. (p2.Nickname or p2.Name) .. ".", true;
		end;
		p2.currenthp = math.min(p2.currenthp + 25, v3.hp);
		if p3 then
			p3:AddAction(p3.ActionList, {
				Player = p2.Owner, 
				Doodle = p2, 
				Action = "PlayAnim", 
				Move = "GenericHeal"
			});
			p3:AddAction(p3.ActionList, {
				Action = "UpdateHealth", 
				currenthp = p2.currenthp, 
				Doodle = p2, 
				Player = p4
			});
			p3:AddDialogue(p3.ActionList, (p2.Nickname or p2.Name) .. " was healed!");
		end;
		return true;
	end;
	u1.Bandage = v2;
	u1["Super Bandage"] = {
		Description = "These bandages heal a Doodle by 60 HP.", 
		Target = "Party", 
		Category = "Medicine", 
		Price = 1000, 
		Image = "http://www.roblox.com/asset/?id=9685180454", 
		Function = function(p5, p6, p7)
			local v4 = l__Utilities__1:GetStats(p5);
			if p5.currenthp == v4.hp then
				return (p5.Nickname or p5.Name) .. " is already at full health!";
			end;
			if p5.currenthp == 0 then
				return "You can't use Super Bandage on a fainted doodle!";
			end;
			if not game:GetService("RunService"):IsServer() then
				return "You used Super Bandage on " .. (p5.Nickname or p5.Name) .. ".", true;
			end;
			p5.currenthp = math.min(p5.currenthp + 60, v4.hp);
			if p6 then
				p6:AddAction(p6.ActionList, {
					Player = p5.Owner, 
					Doodle = p5, 
					Action = "PlayAnim", 
					Move = "GenericHeal"
				});
				p6:AddAction(p6.ActionList, {
					Action = "UpdateHealth", 
					currenthp = p5.currenthp, 
					Doodle = p5, 
					Player = p7
				});
				p6:AddDialogue(p6.ActionList, (p5.Nickname or p5.Name) .. " was healed!");
			end;
			return true;
		end
	};
	u1["Ice Cream Pop"] = {
		Description = "Feed this item to a Doodle to replenish all of their Moves' Uses by 10.", 
		Target = "Party", 
		Category = "Medicine", 
		Image = "http://www.roblox.com/asset/?id=9425430888", 
		Color3 = Color3.fromRGB(102, 97, 147), 
		Function = function(p8, p9, p10)
			if not game:GetService("RunService"):IsServer() then
				return "You fed Ice Cream Pop to " .. (p8.Nickname or p8.Name) .. ".", true;
			end;
			for v5, v6 in pairs(p8.Moves) do
				p8.Moves[v5].Uses = math.min(l__Utilities__1.GetMaxUses(v6.Name), v6.Uses + 10);
			end;
			if p9 then
				p9:AddAction(p9.ActionList, {
					Player = p8.Owner, 
					Doodle = p8, 
					Action = "PlayAnim", 
					Move = "GenericHeal"
				});
				p9:AddDialogue(p9.ActionList, (p8.Nickname or p8.Name) .. " had their moves replenished!");
			end;
			return true;
		end
	};
	u1["Anti-Burn Spray"] = {
		Description = "Use this spray on a Doodle to cure their burn.", 
		Target = "Party", 
		Category = "Medicine", 
		Price = 400, 
		CureStatus = true, 
		Image = "http://www.roblox.com/asset/?id=8974960723", 
		Function = function(p11, p12, p13)
			if p11.Status ~= "Burn" then
				return (p11.Nickname or p11.Name) .. " isn't burned!";
			end;
			if not game:GetService("RunService"):IsServer() or p11.Status ~= "Burn" then
				return "You used Anti-Burn Spray on " .. (p11.Nickname or p11.Name) .. ".", true;
			end;
			p11.Status = nil;
			if p12 then
				p12:AddAction(p12.ActionList, {
					Player = p11.Owner, 
					Doodle = p11, 
					Action = "PlayAnim", 
					Move = "GenericHeal"
				});
				p12:AddAction(p12.ActionList, {
					Player = p11.Owner, 
					Doodle = p11, 
					Action = "ClearStatus"
				});
				p12:AddDialogue(p12.ActionList, (p11.Nickname or p11.Name) .. " was cured of their Burn!");
			end;
			return true;
		end
	};
	u1["Anti-Freeze Spray"] = {
		Description = "Use this spray on a Doodle to cure their freeze.", 
		Target = "Party", 
		Category = "Medicine", 
		Price = 400, 
		CureStatus = true, 
		Image = "http://www.roblox.com/asset/?id=8974962320", 
		Function = function(p14, p15, p16)
			if p14.Status ~= "Frozen" then
				return (p14.Nickname or p14.Name) .. " isn't frozen!";
			end;
			if not game:GetService("RunService"):IsServer() or p14.Status ~= "Frozen" then
				return "You used Anti-Freeze Spray on " .. (p14.Nickname or p14.Name) .. ".", true;
			end;
			p14.Status = nil;
			if p15 then
				p15:AddAction(p15.ActionList, {
					Player = p14.Owner, 
					Doodle = p14, 
					Action = "PlayAnim", 
					Move = "GenericHeal"
				});
				p15:AddAction(p15.ActionList, {
					Player = p14.Owner, 
					Doodle = p14, 
					Action = "ClearStatus"
				});
				p15:AddDialogue(p15.ActionList, (p14.Nickname or p14.Name) .. " was cured of their freeze!");
			end;
			return true;
		end
	};
	u1["Anti-Sleep Spray"] = {
		Description = "Use this item to throw it at a Doodle to wake them up.", 
		Target = "Party", 
		Category = "Medicine", 
		Price = 400, 
		CureStatus = true, 
		Image = "http://www.roblox.com/asset/?id=8974962769", 
		Function = function(p17, p18, p19)
			if p17.Status ~= "Sleep" then
				return (p17.Nickname or p17.Name) .. " isn't asleep!";
			end;
			if not game:GetService("RunService"):IsServer() or p17.Status ~= "Sleep" then
				return "You threw Anti-Sleep Spray at " .. (p17.Nickname or p17.Name) .. ".", true;
			end;
			p17.Status = nil;
			if p18 then
				p18:AddAction(p18.ActionList, {
					Player = p17.Owner, 
					Doodle = p17, 
					Action = "PlayAnim", 
					Move = "GenericHeal"
				});
				p18:AddAction(p18.ActionList, {
					Player = p17.Owner, 
					Doodle = p17, 
					Action = "ClearStatus"
				});
				p18:AddDialogue(p18.ActionList, (p17.Nickname or p17.Name) .. " was awakened!");
			end;
			return true;
		end
	};
	u1.Antidote = {
		Description = "Use this spray on a Doodle to cure their poisoning.", 
		Target = "Party", 
		Category = "Medicine", 
		Price = 400, 
		CureStatus = true, 
		Image = "http://www.roblox.com/asset/?id=8974963169", 
		Function = function(p20, p21, p22)
			if p20.Status ~= "Poison" then
				return (p20.Nickname or p20.Name) .. " isn't poisoned!";
			end;
			if not game:GetService("RunService"):IsServer() or p20.Status ~= "Poison" then
				return "You used Antidote on " .. (p20.Nickname or p20.Name) .. ".", true;
			end;
			p20.Status = nil;
			if p21 then
				p21:AddAction(p21.ActionList, {
					Player = p20.Owner, 
					Doodle = p20, 
					Action = "PlayAnim", 
					Move = "GenericHeal"
				});
				p21:AddAction(p21.ActionList, {
					Player = p20.Owner, 
					Doodle = p20, 
					Action = "ClearStatus"
				});
				p21:AddDialogue(p21.ActionList, (p20.Nickname or p20.Name) .. " was cured of their poisoning!");
			end;
			return true;
		end
	};
	u1.Disinfectant = {
		Description = "Use this spray on a Doodle to cure their disease.", 
		Target = "Party", 
		Category = "Medicine", 
		Price = 400, 
		CureStatus = true, 
		Image = "http://www.roblox.com/asset/?id=8974961687", 
		Function = function(p23, p24, p25)
			if p23.Status ~= "Diseased" then
				return (p23.Nickname or p23.Name) .. " isn't diseased!";
			end;
			if not game:GetService("RunService"):IsServer() or p23.Status ~= "Diseased" then
				return "You used Disinfectant on " .. (p23.Nickname or p23.Name) .. ".", true;
			end;
			p23.Status = nil;
			if p24 then
				p24:AddAction(p24.ActionList, {
					Player = p23.Owner, 
					Doodle = p23, 
					Action = "PlayAnim", 
					Move = "GenericHeal"
				});
				p24:AddAction(p24.ActionList, {
					Player = p23.Owner, 
					Doodle = p23, 
					Action = "ClearStatus"
				});
				p24:AddDialogue(p24.ActionList, (p23.Nickname or p23.Name) .. " was cured of their disease!");
			end;
			return true;
		end
	};
	u1["Anti-Paralysis Spray"] = {
		Description = "Use this spray on a Doodle to cure their paralysis.", 
		Target = "Party", 
		Category = "Medicine", 
		Price = 400, 
		CureStatus = true, 
		Image = "http://www.roblox.com/asset/?id=8974961170", 
		Function = function(p26, p27, p28)
			if p26.Status ~= "Paralysis" then
				return (p26.Nickname or p26.Name) .. " isn't paralyzed!";
			end;
			if not game:GetService("RunService"):IsServer() or p26.Status ~= "Paralysis" then
				return "You used Anti-Paralysis Spray on " .. (p26.Nickname or p26.Name) .. ".", true;
			end;
			p26.Status = nil;
			if p27 then
				p27:AddAction(p27.ActionList, {
					Player = p26.Owner, 
					Doodle = p26, 
					Action = "PlayAnim", 
					Move = "GenericHeal"
				});
				p27:AddAction(p27.ActionList, {
					Player = p26.Owner, 
					Doodle = p26, 
					Action = "ClearStatus"
				});
				p27:AddDialogue(p27.ActionList, (p26.Nickname or p26.Name) .. " was cured of their paralysis!");
			end;
			return true;
		end
	};
	u1["Orb of Darkness"] = {
		Description = "This strange orb of darkness allows certain Doodles to evolve.", 
		Type = "OverworldOnly", 
		Target = "Party", 
		Category = "Items", 
		EvolveItem = true, 
		Color3 = Color3.fromRGB(21, 21, 21), 
		DontCloseImmediately = true, 
		Image = "http://www.roblox.com/asset/?id=8463940065", 
		Function = function(p29, p30, p31)
			if p30 then
				return false;
			end;
			local v7 = p1.DoodleInfo[p29.Name];
			if v7.Evolve and v7.Evolve.Item and v7.Evolve.Item["Orb of Darkness"] then
				local v8 = true;
			else
				v8 = false;
			end;
			if not v8 then
				return (p29.Nickname or p29.Name) .. " cannot evolve using the Orb of Darkness!";
			end;
			if game:GetService("RunService"):IsServer() then
				p29:EvolveItem(p31, "Orb of Darkness");
				return true;
			end;
			return "Evolving " .. (p29.Nickname or p29.Name) .. "...", true;
		end
	};
	u1["Strange Catalyst"] = {
		Description = "A strange, reactive item that may make a certain Doodle evolve. It doesn't seem safe to touch. ", 
		Type = "OverworldOnly", 
		Target = "Party", 
		Category = "Items", 
		EvolveItem = true, 
		Color3 = Color3.fromRGB(91, 59, 135), 
		DontCloseImmediately = true, 
		Image = "http://www.roblox.com/asset/?id=8789994663", 
		Function = function(p32, p33, p34)
			if p33 then
				return false;
			end;
			local v9 = p1.DoodleInfo[p32.Name];
			if v9.Evolve and v9.Evolve.Item and v9.Evolve.Item["Strange Catalyst"] then
				local v10 = true;
			else
				v10 = false;
			end;
			if not v10 then
				return (p32.Nickname or p32.Name) .. " cannot evolve using the Strange Catalyst!";
			end;
			if game:GetService("RunService"):IsServer() then
				p32:EvolveItem(p34, "Strange Catalyst");
				return true;
			end;
			return "Evolving " .. (p32.Nickname or p32.Name) .. "...", true;
		end
	};
	u1["Strange Substance"] = {
		Description = "A strange, reactive substance allows certain Doodles to evolve. It's oddly warm to the touch.", 
		Type = "OverworldOnly", 
		Target = "Party", 
		Category = "Items", 
		EvolveItem = true, 
		Color3 = Color3.fromRGB(97, 24, 47), 
		DontCloseImmediately = true, 
		Image = "http://www.roblox.com/asset/?id=8789995239", 
		Function = function(p35, p36, p37)
			if p36 then
				return false;
			end;
			local v11 = p1.DoodleInfo[p35.Name];
			if v11.Evolve and v11.Evolve.Item and v11.Evolve.Item["Strange Substance"] then
				local v12 = true;
			else
				v12 = false;
			end;
			if not v12 then
				return (p35.Nickname or p35.Name) .. " cannot evolve using the Strange Substance!";
			end;
			if game:GetService("RunService"):IsServer() then
				p35:EvolveItem(p37, "Strange Substance");
				return true;
			end;
			return "Evolving " .. (p35.Nickname or p35.Name) .. "...", true;
		end
	};
	u1["Strange Solution"] = {
		Description = "A strange, reactive liquid that may make a certain Doodle evolve. It's cool to the touch.", 
		Type = "OverworldOnly", 
		Target = "Party", 
		Category = "Items", 
		EvolveItem = true, 
		Color3 = Color3.fromRGB(33, 117, 187), 
		DontCloseImmediately = true, 
		Image = "http://www.roblox.com/asset/?id=8789994917", 
		Function = function(p38, p39, p40)
			if p39 then
				return false;
			end;
			local v13 = p1.DoodleInfo[p38.Name];
			if v13.Evolve and v13.Evolve.Item and v13.Evolve.Item["Strange Solution"] then
				local v14 = true;
			else
				v14 = false;
			end;
			if not v14 then
				return (p38.Nickname or p38.Name) .. " cannot evolve using the Strange Solution!";
			end;
			if game:GetService("RunService"):IsServer() then
				p38:EvolveItem(p40, "Strange Solution");
				return true;
			end;
			return "Evolving " .. (p38.Nickname or p38.Name) .. "...", true;
		end
	};
	local v15 = {
		Description = "Give this item to a Doodle to have it cure a status effect when the Doodle is inflicted with one. This item is consumed after one use.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(65, 175, 238), 
		Image = "http://www.roblox.com/asset/?id=7325480728"
	};
	local u2 = {
		Paralysis = "Paralysis", 
		Poison = "Poison", 
		Rage = "Rage", 
		Burn = "Burn", 
		Sleep = "Sleep", 
		Frozen = "Freeze", 
		Marked = "Mark", 
		Vulnerable = "Vulnerable", 
		Cursed = "Curse", 
		Diseased = "Disease"
	};
	function v15.OnStatus(p41, p42, p43)
		if not p42.Status or not u2[p42.Status] then
			return false;
		end;
		p42.Status = nil;
		local v16 = p41:GetTraitInfo(p42);
		p41:AddDialogue(p41.ActionList, "The Cure Jelly got rid of " .. "&DOODLENAME," .. p42.ID .. "&" .. "'s " .. u2[p42.Status] .. "!");
		p41:AddAction(p41.ActionList, {
			Player = p42.Owner, 
			Doodle = p42, 
			Action = "ClearStatus"
		});
		if v16.BetterJelly and not p42.UsedJelly then
			p42.UsedJelly = true;
			p41:AddDialogue(p41.ActionList, "The Cure Jelly wasn't consumed because of " .. p42.ID .. "&'s Jelly Enhancer!");
		else
			p42.HeldItem = nil;
		end;
		return true;
	end;
	u1["Cure Jelly"] = v15;
	u1["Sniper Scope"] = {
		Description = "Give this item to a Doodle. The holder, if they haven't taken damage yet this turn, has a boosted critical hit rate.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(133, 129, 129), 
		Image = "http://www.roblox.com/asset/?id=10006059298", 
		CritRate = function(p44, p45, p46, p47, p48)
			if p45.Revenge and #p45.Revenge ~= 0 then
				return p48;
			end;
			print("Has crit");
			return p48 / 3;
		end
	};
	u1["Running Shoes"] = {
		Description = "Give this item to a Doodle so it can flee from any wild Doodle without fail.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(205, 64, 44), 
		Image = "http://www.roblox.com/asset/?id=9575744399", 
		RunningShoes = true
	};
	u1["Frozen TV Dinner"] = {
		Description = "Give this item to a Doodle. They will be so distracted snacking on a delicious dinner that they will always attack last.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(130, 186, 237), 
		Image = "http://www.roblox.com/asset/?id=7325464936", 
		AttackLast = true
	};
	u1["Wake-up Jelly"] = {
		Description = "Give this item to a Doodle to wake it up when it gets put to sleep. This item is consumed after use.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(87, 31, 189), 
		Image = "http://www.roblox.com/asset/?id=7325464058", 
		OnStatus = function(p49, p50, p51)
			if not p50.Status or p50.Status ~= "Sleep" or not u2[p50.Status] then
				return false;
			end;
			local l__Status__17 = p50.Status;
			p50.Status = nil;
			p49:AddDialogue(p49.ActionList, "The Wake-up Jelly woke up " .. "&DOODLENAME," .. p50.ID .. "&!");
			if p49:GetTraitInfo(p50).BetterJelly and not p50.UsedJelly then
				p50.UsedJelly = true;
				p49:AddDialogue(p49.ActionList, "The Wake-up Jelly wasn't consumed because of " .. p50.ID .. "&'s Jelly Enhancer!");
			else
				p50.HeldItem = nil;
			end;
			p50.Resting = nil;
			return true;
		end
	};
	u1["Heal Jelly"] = {
		Description = "Give this item to a Doodle to have them heal after their health drops below half.  This item is consumed after use.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(211, 54, 107), 
		Image = "http://www.roblox.com/asset/?id=7325470567", 
		AfterDamage = function(p52, p53, p54)
			local l__hp__18 = p53.Stats.hp;
			local v19 = math.floor(l__hp__18 * 0.25);
			if p52:GetTraitInfo(p53).BetterJelly then
				v19 = v19 * 3;
			end;
			if p53.currenthp <= l__hp__18 / 2 then
				p52:AddDialogue(p52.ActionList, p53.Name .. " used its Heal Jelly!");
				p52:TakeDamage(p53, -v19);
				p53.HeldItem = nil;
				p52:AddDialogue(p52.ActionList, p53.Name .. " restored health!");
			end;
		end
	};
	u1["Speed Jelly"] = {
		Description = "Give this item to a Doodle to have them boost their speed when their health gets low. This item is consumed after use.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(0, 145, 40), 
		Image = "http://www.roblox.com/asset/?id=7325462367", 
		AfterDamage = function(p55, p56, p57)
			local v20 = p56.Stats.hp / 4;
			if p55:GetTraitInfo(p56).BetterJelly then
				v20 = v20 * 3 / 4;
			end;
			if p56.currenthp <= v20 and p56.Boosts.spe < 6 then
				p55:AddDialogue(p55.ActionList, "&DOODLENAME," .. p56.ID .. "& used their Speed Jelly!");
				l__Utilities__1.ChangeStats(p55, p56, p56, 100, {
					spe = 1
				});
				p56.HeldItem = nil;
			end;
		end
	};
	u1["Strength Jelly"] = {
		Description = "Give this item to a Doodle to increase the power of one of their weak attacks. This item is consumed after use.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(185, 19, 26), 
		Image = "http://www.roblox.com/asset/?id=7325464522", 
		OffensiveDamageCalc = function(p58, p59, p60, p61, p62)
			local v21 = 0;
			if p58:GetTraitInfo(p59).BetterJelly then
				v21 = 1;
			end;
			if not (p62 < p60.Stats.hp / 4) or not (p62 > 0) then
				return p62;
			end;
			p59.HeldItem = nil;
			p58:AddDialogue(p58.ActionList, "&DOODLENAME," .. p59.ID .. "& used their Strength Jelly! This next attack is doing more damage!");
			return p62 * (2 + v21);
		end
	};
	u1["Plant Taffy"] = {
		Description = "A taffy made in Von Sweets' Factory. Give this item to boost the damage of one Plant-type attack. This item is consumed after use.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(57, 137, 30), 
		Image = "http://www.roblox.com/asset/?id=9552698960", 
		OffensiveDamageCalc = function(p63, p64, p65, p66, p67)
			if p66.Type ~= "Plant" then
				return p67;
			end;
			p64.HeldItem = nil;
			p63:AddDialogue(p63.ActionList, "&DOODLENAME," .. p64.ID .. "& consumed their Plant Taffy! This attack is doing more damage!");
			return p67 * 1.5;
		end
	};
	u1["Plant Candy Cube"] = {
		Description = "Some candy made in von Sweets' factory. Give this item to a Doodle to reduce the power of a Plant-type attack. This item is consumed after use.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(57, 137, 30), 
		Image = "http://www.roblox.com/asset/?id=9918371596", 
		DuringDamageCalc = function(p68, p69, p70, p71, p72)
			if p71.Type ~= "Plant" then
				return p72;
			end;
			p68:AddDialogue(p68.ActionList, "&DOODLENAME," .. p70.ID .. "&'s Plant Candy Cube reduced the damage of this attack!");
			p70.HeldItem = nil;
			return math.floor(p72 * 0.5);
		end
	};
	u1["Mind Taffy"] = {
		Description = "A taffy made in Von Sweets' Factory. Give this item to boost the damage of one Mind-type attack. This item is consumed after use.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(173, 89, 97), 
		Image = "http://www.roblox.com/asset/?id=9553024865", 
		OffensiveDamageCalc = function(p73, p74, p75, p76, p77)
			if p76.Type ~= "Mind" then
				return p77;
			end;
			p74.HeldItem = nil;
			p73:AddDialogue(p73.ActionList, "&DOODLENAME," .. p74.ID .. "& consumed their Mind Taffy! This attack is doing more damage!");
			return p77 * 1.5;
		end
	};
	u1["Mind Candy Cube"] = {
		Description = "Some candy made in von Sweets' factory. Give this item to a Doodle to reduce the power of a Mind-type attack. This item is consumed after use.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(119, 60, 46), 
		Image = "http://www.roblox.com/asset/?id=9918370444", 
		DuringDamageCalc = function(p78, p79, p80, p81, p82)
			if p81.Type ~= "Mind" then
				return p82;
			end;
			p78:AddDialogue(p78.ActionList, "&DOODLENAME," .. p80.ID .. "&'s Mind Candy Cube reduced the damage of this attack!");
			p80.HeldItem = nil;
			return math.floor(p82 * 0.5);
		end
	};
	u1["Air Taffy"] = {
		Description = "A taffy made in Von Sweets' Factory. Give this item to boost the damage of one Air-type attack. This item is consumed after use.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(169, 212, 227), 
		Image = "http://www.roblox.com/asset/?id=9552702093", 
		OffensiveDamageCalc = function(p83, p84, p85, p86, p87)
			if p86.Type ~= "Air" then
				return p87;
			end;
			p84.HeldItem = nil;
			p83:AddDialogue(p83.ActionList, "&DOODLENAME," .. p84.ID .. "& consumed their Air Taffy! This attack is doing more damage!");
			return p87 * 1.5;
		end
	};
	u1["Air Candy Cube"] = {
		Description = "Some candy made in von Sweets' factory. Give this item to a Doodle to reduce the power of an Air-type attack. This item is consumed after use.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(169, 212, 227), 
		Image = "http://www.roblox.com/asset/?id=9918363418", 
		DuringDamageCalc = function(p88, p89, p90, p91, p92)
			if p91.Type ~= "Air" then
				return p92;
			end;
			p88:AddDialogue(p88.ActionList, "&DOODLENAME," .. p90.ID .. "&'s Air Candy Cube reduced the damage of this attack!");
			p90.HeldItem = nil;
			return math.floor(p92 * 0.5);
		end
	};
	u1["Basic Taffy"] = {
		Description = "A taffy made in Von Sweets' Factory. Give this item to boost the damage of one Basic-type attack. This item is consumed after use.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(136, 136, 136), 
		Image = "http://www.roblox.com/asset/?id=9552701606", 
		OffensiveDamageCalc = function(p93, p94, p95, p96, p97)
			if p96.Type ~= "Basic" then
				return p97;
			end;
			p94.HeldItem = nil;
			p93:AddDialogue(p93.ActionList, "&DOODLENAME," .. p94.ID .. "& consumed their Basic Taffy! This attack is doing more damage!");
			return p97 * 1.5;
		end
	};
	u1["Basic Candy Cube"] = {
		Description = "Some candy made in von Sweets' factory. Give this item to a Doodle to reduce the power of a Basic-type attack. This item is consumed after use.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(136, 136, 136), 
		Image = "http://www.roblox.com/asset/?id=9918363973", 
		DuringDamageCalc = function(p98, p99, p100, p101, p102)
			if p101.Type ~= "Basic" then
				return p102;
			end;
			p98:AddDialogue(p98.ActionList, "&DOODLENAME," .. p100.ID .. "&'s Basic Candy Cube reduced the damage of this attack!");
			p100.HeldItem = nil;
			return math.floor(p102 * 0.5);
		end
	};
	u1["Insect Taffy"] = {
		Description = "A taffy made in Von Sweets' Factory. Give this item to boost the damage of one Insect-type attack. This item is consumed after use.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(169, 209, 84), 
		Image = "http://www.roblox.com/asset/?id=9552701242", 
		OffensiveDamageCalc = function(p103, p104, p105, p106, p107)
			if p106.Type ~= "Insect" then
				return p107;
			end;
			p104.HeldItem = nil;
			p103:AddDialogue(p103.ActionList, "&DOODLENAME," .. p104.ID .. "& consumed their Insect Taffy! This attack is doing more damage!");
			return p107 * 1.5;
		end
	};
	u1["Insect Candy Cube"] = {
		Description = "Some candy made in von Sweets' factory. Give this item to a Doodle to reduce the power of a Insect-type attack. This item is consumed after use.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(169, 209, 84), 
		Image = "http://www.roblox.com/asset/?id=9918368279", 
		DuringDamageCalc = function(p108, p109, p110, p111, p112)
			if p111.Type ~= "Insect" then
				return p112;
			end;
			p108:AddDialogue(p108.ActionList, "&DOODLENAME," .. p110.ID .. "&'s Insect Candy Cube reduced the damage of this attack!");
			p110.HeldItem = nil;
			return math.floor(p112 * 0.5);
		end
	};
	u1["Pocket Storage"] = {
		Description = "Access your Doodle Storage remotely.", 
		Type = "OverworldOnly", 
		Category = "Key Items", 
		InfiniteUses = true, 
		Color3 = Color3.fromRGB(234, 172, 158), 
		Image = "http://www.roblox.com/asset/?id=10649026745", 
		SpecialFunction = function(p113, p114)
			local v22 = p113.Dialogue:SaySimpleYesNo("Do you want to access your Doodle Storage?");
			p113.Dialogue:Hide();
			if v22 == "Yes" then
				p114.ItemUI.Visible = false;
				local v23 = p113.PC.new();
				p113.PCClosed:Wait();
				p113.Controls:ToggleWalk(true);
			end;
			p113.Talky.Visible = false;
		end
	};
	u1["Swarm Snack"] = {
		Description = "These treats may be a little too tasty. Sprinkle these around and watch the Doodles swarm!", 
		Type = "OverworldOnly", 
		Category = "Items", 
		GemPrice = 600, 
		Color3 = Color3.fromRGB(110, 167, 215), 
		Image = "http://www.roblox.com/asset/?id=10778778895", 
		NonPartyFunc = function(p115, p116)
			local v24 = nil;
			p115.Process = true;
			local v25 = nil;
			local v26 = nil;
			v25, v24, v26 = p115.Network:get("GetSwarm");
			if v25 then
				p115.Gui:SayText("", "There is already a swarm of " .. v25.Name .. " " .. v24[v25.Chunk] .. "! There are " .. v26 .. " seconds left of this swarm.", nil, true);
				p115.Talky.Visible = false;
			elseif not v25 then
				local l__Name__27 = p115.CurrentChunk.Name;
				if not v24[l__Name__27] then
					p115.Gui:SayText("", "You can't start a swarm here.", nil, true);
					p115.Talky.Visible = false;
				else
					local v28 = p115.Dialogue:SaySimpleYesNo("Do you want to start a swarm " .. v24[l__Name__27] .. "?");
					p115.Dialogue:Hide();
					if v28 == "Yes" then
						p116:Destroy();
						p115.Controls:ToggleWalk(true);
						p115.Network:get("StartSwarm", l__Name__27);
					end;
				end;
			end;
			p115.Process = false;
		end
	};
	u1["Haunted Tome"] = {
		Description = "The next house you trick or treat at will have a Halloween Doodle guaranteed!", 
		Type = "OverworldOnly", 
		Category = "Items", 
		Color3 = Color3.fromRGB(185, 142, 134), 
		Image = "http://www.roblox.com/asset/?id=11277917582", 
		NonPartyFunc = function(p117, p118)
			p117.Process = true;
			local v29, v30 = p117.ClientDatabase:PDSFunc("HauntedTome");
			p118:Update(nil, v30, true);
			p117.Dialogue:SaySimple(v29);
			p117.Process = false;
		end
	};
	u1["Chain Preserver"] = {
		Description = "Stores a chain for later use. ", 
		Type = "OverworldOnly", 
		Category = "Key Items", 
		InfiniteUses = true, 
		Color3 = Color3.fromRGB(255, 66, 87), 
		Image = "http://www.roblox.com/asset/?id=11329163227", 
		SpecialFunction = function(p119, p120)
			p119.Process = true;
			local v31, v32 = p119.ClientDatabase:PDSFunc("ChainPreserver");
			local v33 = "Do you want to store your current chain?";
			if v32.Name then
				if v31.Name then
					v33 = "Do you want to switch your current chain with your stored chain? Current stored chain: #" .. v32.Number .. " for " .. v32.Name .. ".";
				else
					v33 = "Do you want to take out your current preserved chain? Current stored chain: #" .. v32.Number .. " for " .. v32.Name .. ".";
				end;
			end;
			local v34 = nil;
			if p119.Dialogue:SaySimpleYesNo(v33) == "Yes" then
				p119.Network:post("PreserveChain");
				if v31.Name then
					v34 = "New stored chain: #" .. v31.Number .. " for " .. v31.Name .. ".";
				end;
			end;
			if v34 then
				p119.Gui:SayText("", v34, nil, true);
			end;
			p119.Talky.Visible = false;
			p119.Process = false;
		end
	};
	u1["Crystal Taffy"] = {
		Description = "A taffy made in Von Sweets' Factory. Give this item to boost the damage of one Crystal-type attack. This item is consumed after use.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(65, 195, 205), 
		Image = "http://www.roblox.com/asset/?id=9552700861", 
		OffensiveDamageCalc = function(p121, p122, p123, p124, p125)
			if p124.Type ~= "Crystal" then
				return p125;
			end;
			p122.HeldItem = nil;
			p121:AddDialogue(p121.ActionList, "&DOODLENAME," .. p122.ID .. "& consumed their Crystal Taffy! This attack is doing more damage!");
			return p125 * 1.5;
		end
	};
	u1["Crystal Candy Cube"] = {
		Description = "Some candy made in von Sweets' factory. Give this item to a Doodle to reduce the power of a Crystal-type attack. This item is consumed after use.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(65, 195, 205), 
		Image = "http://www.roblox.com/asset/?id=9918365054", 
		DuringDamageCalc = function(p126, p127, p128, p129, p130)
			if p129.Type ~= "Crystal" then
				return p130;
			end;
			p126:AddDialogue(p126.ActionList, "&DOODLENAME," .. p128.ID .. "&'s Crystal Candy Cube reduced the damage of this attack!");
			p128.HeldItem = nil;
			return math.floor(p130 * 0.5);
		end
	};
	u1["Food Taffy"] = {
		Description = "A taffy made in Von Sweets' Factory. Give this item to boost the damage of one Food-type attack. This item is consumed after use.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(209, 131, 87), 
		Image = "http://www.roblox.com/asset/?id=9552699828", 
		OffensiveDamageCalc = function(p131, p132, p133, p134, p135)
			if p134.Type ~= "Food" then
				return p135;
			end;
			p132.HeldItem = nil;
			p131:AddDialogue(p131.ActionList, "&DOODLENAME," .. p132.ID .. "& consumed their Food Taffy! This attack is doing more damage!");
			return p135 * 1.5;
		end
	};
	u1["Food Candy Cube"] = {
		Description = "Some candy made in von Sweets' factory. Give this item to a Doodle to reduce the power of a Food-type attack. This item is consumed after use.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(209, 131, 87), 
		Image = "http://www.roblox.com/asset/?id=9918367440", 
		DuringDamageCalc = function(p136, p137, p138, p139, p140)
			if p139.Type ~= "Food" then
				return p140;
			end;
			p136:AddDialogue(p136.ActionList, "&DOODLENAME," .. p138.ID .. "&'s Food Candy Cube reduced the damage of this attack!");
			p138.HeldItem = nil;
			return math.floor(p140 * 0.5);
		end
	};
	u1["Water Taffy"] = {
		Description = "A taffy made in Von Sweets' Factory. Give this item to boost the damage of one Water-type attack. This item is consumed after use.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(45, 84, 179), 
		Image = "http://www.roblox.com/asset/?id=9552699458", 
		OffensiveDamageCalc = function(p141, p142, p143, p144, p145)
			if p144.Type ~= "Water" then
				return p145;
			end;
			p142.HeldItem = nil;
			p141:AddDialogue(p141.ActionList, "&DOODLENAME," .. p142.ID .. "& consumed their Water Taffy! This attack is doing more damage!");
			return p145 * 1.5;
		end
	};
	u1["Water Candy Cube"] = {
		Description = "Some candy made in von Sweets' factory. Give this item to a Doodle to reduce the power of a Water-type attack. This item is consumed after use.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(45, 84, 179), 
		Image = "http://www.roblox.com/asset/?id=9918373556", 
		DuringDamageCalc = function(p146, p147, p148, p149, p150)
			if p149.Type ~= "Water" then
				return p150;
			end;
			p146:AddDialogue(p146.ActionList, "&DOODLENAME," .. p148.ID .. "&'s Water Candy Cube reduced the damage of this attack!");
			p148.HeldItem = nil;
			return math.floor(p150 * 0.5);
		end
	};
	u1["Spirit Taffy"] = {
		Description = "A taffy made in Von Sweets' Factory. Give this item to boost the damage of one Spirit-type attack. This item is consumed after use.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(50, 37, 83), 
		Image = "http://www.roblox.com/asset/?id=9553014795", 
		OffensiveDamageCalc = function(p151, p152, p153, p154, p155)
			if p154.Type ~= "Spirit" then
				return p155;
			end;
			p152.HeldItem = nil;
			p151:AddDialogue(p151.ActionList, "&DOODLENAME," .. p152.ID .. "& consumed their Spirit Taffy! This attack is doing more damage!");
			return p155 * 1.5;
		end
	};
	u1["Spirit Candy Cube"] = {
		Description = "Some candy made in von Sweets' factory. Give this item to a Doodle to reduce the power of a Spirit-type attack. This item is consumed after use.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(50, 37, 83), 
		Image = "http://www.roblox.com/asset/?id=9918373034", 
		DuringDamageCalc = function(p156, p157, p158, p159, p160)
			if p159.Type ~= "Spirit" then
				return p160;
			end;
			p156:AddDialogue(p156.ActionList, "&DOODLENAME," .. p158.ID .. "&'s Spirit Candy Cube reduced the damage of this attack!");
			p158.HeldItem = nil;
			return math.floor(p160 * 0.5);
		end
	};
	u1["Spark Taffy"] = {
		Description = "A taffy made in Von Sweets' Factory. Give this item to boost the damage of one Spark-type attack. This item is consumed after use.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(241, 173, 30), 
		Image = "http://www.roblox.com/asset/?id=9553013394", 
		OffensiveDamageCalc = function(p161, p162, p163, p164, p165)
			if p164.Type ~= "Spark" then
				return p165;
			end;
			p162.HeldItem = nil;
			p161:AddDialogue(p161.ActionList, "&DOODLENAME," .. p162.ID .. "& consumed their Spark Taffy! This attack is doing more damage!");
			return p165 * 1.5;
		end
	};
	u1["Spark Candy Cube"] = {
		Description = "Some candy made in von Sweets' factory. Give this item to a Doodle to reduce the power of a Spark-type attack. This item is consumed after use.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(241, 173, 30), 
		Image = "http://www.roblox.com/asset/?id=9918372658", 
		DuringDamageCalc = function(p166, p167, p168, p169, p170)
			if p169.Type ~= "Spark" then
				return p170;
			end;
			p166:AddDialogue(p166.ActionList, "&DOODLENAME," .. p168.ID .. "&'s Spark Candy Cube reduced the damage of this attack!");
			p168.HeldItem = nil;
			return math.floor(p170 * 0.5);
		end
	};
	u1["Poison Taffy"] = {
		Description = "A taffy made in Von Sweets' Factory. Give this item to boost the damage of one Poison-type attack. This item is consumed after use.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(129, 93, 174), 
		Image = "http://www.roblox.com/asset/?id=9553012344", 
		OffensiveDamageCalc = function(p171, p172, p173, p174, p175)
			if p174.Type ~= "Poison" then
				return p175;
			end;
			p172.HeldItem = nil;
			p171:AddDialogue(p171.ActionList, "&DOODLENAME," .. p172.ID .. "& consumed their Poison Taffy! This attack is doing more damage!");
			return p175 * 1.5;
		end
	};
	u1["Poison Candy Cube"] = {
		Description = "Some candy made in von Sweets' factory. Give this item to a Doodle to reduce the power of a Poison-type attack. This item is consumed after use.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(129, 93, 174), 
		Image = "http://www.roblox.com/asset/?id=9918372062", 
		DuringDamageCalc = function(p176, p177, p178, p179, p180)
			if p179.Type ~= "Poison" then
				return p180;
			end;
			p176:AddDialogue(p176.ActionList, "&DOODLENAME," .. p178.ID .. "&'s Poison Candy Cube reduced the damage of this attack!");
			p178.HeldItem = nil;
			return math.floor(p180 * 0.5);
		end
	};
	u1["Mythic Taffy"] = {
		Description = "A taffy made in Von Sweets' Factory. Give this item to boost the damage of one Mythic-type attack. This item is consumed after use.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(34, 48, 119), 
		Image = "http://www.roblox.com/asset/?id=9553011102", 
		OffensiveDamageCalc = function(p181, p182, p183, p184, p185)
			if p184.Type ~= "Mythic" then
				return p185;
			end;
			p182.HeldItem = nil;
			p181:AddDialogue(p181.ActionList, "&DOODLENAME," .. p182.ID .. "& consumed their Mythic Taffy! This attack is doing more damage!");
			return p185 * 1.5;
		end
	};
	u1["Mythic Candy Cube"] = {
		Description = "Some candy made in von Sweets' factory. Give this item to a Doodle to reduce the power of a Mythic-type attack. This item is consumed after use.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(34, 48, 119), 
		Image = "http://www.roblox.com/asset/?id=9918371058", 
		DuringDamageCalc = function(p186, p187, p188, p189, p190)
			if p189.Type ~= "Mythic" then
				return p190;
			end;
			p186:AddDialogue(p186.ActionList, "&DOODLENAME," .. p188.ID .. "&'s Mythic Candy Cube reduced the damage of this attack!");
			p188.HeldItem = nil;
			return math.floor(p190 * 0.5);
		end
	};
	u1["Metal Taffy"] = {
		Description = "A taffy made in Von Sweets' Factory. Give this item to boost the damage of one Metal-type attack. This item is consumed after use.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(77, 99, 100), 
		Image = "http://www.roblox.com/asset/?id=9553009871", 
		OffensiveDamageCalc = function(p191, p192, p193, p194, p195)
			if p194.Type ~= "Metal" then
				return p195;
			end;
			p192.HeldItem = nil;
			p191:AddDialogue(p191.ActionList, "&DOODLENAME," .. p192.ID .. "& consumed their Metal Taffy! This attack is doing more damage!");
			return p195 * 1.5;
		end
	};
	u1["Metal Candy Cube"] = {
		Description = "Some candy made in von Sweets' factory. Give this item to a Doodle to reduce the power of a Metal-type attack. This item is consumed after use.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(77, 99, 100), 
		Image = "http://www.roblox.com/asset/?id=9918369974", 
		DuringDamageCalc = function(p196, p197, p198, p199, p200)
			if p199.Type ~= "Metal" then
				return p200;
			end;
			p196:AddDialogue(p196.ActionList, "&DOODLENAME," .. p198.ID .. "&'s Metal Candy Cube reduced the damage of this attack!");
			p198.HeldItem = nil;
			return math.floor(p200 * 0.5);
		end
	};
	u1["Light Taffy"] = {
		Description = "A taffy made in Von Sweets' Factory. Give this item to boost the damage of one Light-type attack. This item is consumed after use.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(245, 213, 125), 
		Image = "http://www.roblox.com/asset/?id=9553007659", 
		OffensiveDamageCalc = function(p201, p202, p203, p204, p205)
			if p204.Type ~= "Light" then
				return p205;
			end;
			p202.HeldItem = nil;
			p201:AddDialogue(p201.ActionList, "&DOODLENAME," .. p202.ID .. "& consumed their Light Taffy! This attack is doing more damage!");
			return p205 * 1.5;
		end
	};
	u1["Light Candy Cube"] = {
		Description = "Some candy made in von Sweets' factory. Give this item to a Doodle to reduce the power of a Light-type attack. This item is consumed after use.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(245, 213, 125), 
		Image = "http://www.roblox.com/asset/?id=9918368731", 
		DuringDamageCalc = function(p206, p207, p208, p209, p210)
			if p209.Type ~= "Light" then
				return p210;
			end;
			p206:AddDialogue(p206.ActionList, "&DOODLENAME," .. p208.ID .. "&'s Light Candy Cube reduced the damage of this attack!");
			p208.HeldItem = nil;
			return math.floor(p210 * 0.5);
		end
	};
	u1["Melee Taffy"] = {
		Description = "A taffy made in Von Sweets' Factory. Give this item to boost the damage of one Melee-type attack. This item is consumed after use.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(191, 57, 49), 
		Image = "http://www.roblox.com/asset/?id=9553008930", 
		OffensiveDamageCalc = function(p211, p212, p213, p214, p215)
			if p214.Type ~= "Melee" then
				return p215;
			end;
			p212.HeldItem = nil;
			p211:AddDialogue(p211.ActionList, "&DOODLENAME," .. p212.ID .. "& consumed their Melee Taffy! This attack is doing more damage!");
			return p215 * 1.5;
		end
	};
	u1["Melee Candy Cube"] = {
		Description = "Some candy made in von Sweets' factory. Give this item to a Doodle to reduce the power of a Melee-type attack. This item is consumed after use.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(191, 57, 49), 
		Image = "http://www.roblox.com/asset/?id=9918369396", 
		DuringDamageCalc = function(p216, p217, p218, p219, p220)
			if p219.Type ~= "mELEE" then
				return p220;
			end;
			p216:AddDialogue(p216.ActionList, "&DOODLENAME," .. p218.ID .. "&'s Melee Candy Cube reduced the damage of this attack!");
			p218.HeldItem = nil;
			return math.floor(p220 * 0.5);
		end
	};
	u1["Ice Taffy"] = {
		Description = "A taffy made in Von Sweets' Factory. Give this item to boost the damage of one Ice-type attack. This item is consumed after use.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(107, 187, 213), 
		Image = "http://www.roblox.com/asset/?id=9553006558", 
		OffensiveDamageCalc = function(p221, p222, p223, p224, p225)
			if p224.Type ~= "Ice" then
				return p225;
			end;
			p222.HeldItem = nil;
			p221:AddDialogue(p221.ActionList, "&DOODLENAME," .. p222.ID .. "& consumed their Ice Taffy! This attack is doing more damage!");
			return p225 * 1.5;
		end
	};
	u1["Ice Candy Cube"] = {
		Description = "Some candy made in von Sweets' factory. Give this item to a Doodle to reduce the power of a Ice-type attack. This item is consumed after use.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(107, 187, 213), 
		Image = "http://www.roblox.com/asset/?id=9918367861", 
		DuringDamageCalc = function(p226, p227, p228, p229, p230)
			if p229.Type ~= "Ice" then
				return p230;
			end;
			p226:AddDialogue(p226.ActionList, "&DOODLENAME," .. p228.ID .. "&'s Ice Candy Cube reduced the damage of this attack!");
			p228.HeldItem = nil;
			return math.floor(p230 * 0.5);
		end
	};
	u1["Fire Taffy"] = {
		Description = "A taffy made in Von Sweets' Factory. Give this item to boost the damage of one Fire-type attack. This item is consumed after use.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(213, 67, 5), 
		Image = "http://www.roblox.com/asset/?id=9553005518", 
		OffensiveDamageCalc = function(p231, p232, p233, p234, p235)
			if p234.Type ~= "Fire" then
				return p235;
			end;
			p232.HeldItem = nil;
			p231:AddDialogue(p231.ActionList, "&DOODLENAME," .. p232.ID .. "& consumed their Fire Taffy! This attack is doing more damage!");
			return p235 * 1.5;
		end
	};
	u1["Fire Candy Cube"] = {
		Description = "Some candy made in von Sweets' factory. Give this item to a Doodle to reduce the power of a Fire-type attack. This item is consumed after use.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(213, 67, 5), 
		Image = "http://www.roblox.com/asset/?id=9918366463", 
		DuringDamageCalc = function(p236, p237, p238, p239, p240)
			if p239.Type ~= "Fire" then
				return p240;
			end;
			p236:AddDialogue(p236.ActionList, "&DOODLENAME," .. p238.ID .. "&'s Fire Candy Cube reduced the damage of this attack!");
			p238.HeldItem = nil;
			return math.floor(p240 * 0.5);
		end
	};
	u1["Earth Taffy"] = {
		Description = "A taffy made in Von Sweets' Factory. Give this item to boost the damage of one Earth-type attack. This item is consumed after use.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(164, 116, 91), 
		Image = "http://www.roblox.com/asset/?id=9553004221", 
		OffensiveDamageCalc = function(p241, p242, p243, p244, p245)
			if p244.Type ~= "Earth" then
				return p245;
			end;
			p242.HeldItem = nil;
			p241:AddDialogue(p241.ActionList, "&DOODLENAME," .. p242.ID .. "& consumed their Earth Taffy! This attack is doing more damage!");
			return p245 * 1.5;
		end
	};
	u1["Earth Candy Cube"] = {
		Description = "Some candy made in von Sweets' factory. Give this item to a Doodle to reduce the power of a Earth-type attack. This item is consumed after use.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(164, 116, 91), 
		Image = "http://www.roblox.com/asset/?id=9918365803", 
		DuringDamageCalc = function(p246, p247, p248, p249, p250)
			if p249.Type ~= "Earth" then
				return p250;
			end;
			p246:AddDialogue(p246.ActionList, "&DOODLENAME," .. p248.ID .. "&'s Earth Candy Cube reduced the damage of this attack!");
			p248.HeldItem = nil;
			return math.floor(p250 * 0.5);
		end
	};
	u1["Dark Taffy"] = {
		Description = "A taffy made in Von Sweets' Factory. Give this item to boost the damage of one Dark-type attack. This item is consumed after use.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(61, 62, 63), 
		Image = "http://www.roblox.com/asset/?id=9553003459", 
		OffensiveDamageCalc = function(p251, p252, p253, p254, p255)
			if p254.Type ~= "Dark" then
				return p255;
			end;
			p252.HeldItem = nil;
			p251:AddDialogue(p251.ActionList, "&DOODLENAME," .. p252.ID .. "& consumed their Dark Taffy! This attack is doing more damage!");
			return p255 * 1.5;
		end
	};
	u1["Dark Candy Cube"] = {
		Description = "Some candy made in von Sweets' factory. Give this item to a Doodle to reduce the power of a Dark-type attack. This item is consumed after use.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(61, 62, 63), 
		Image = "http://www.roblox.com/asset/?id=9918365362", 
		DuringDamageCalc = function(p256, p257, p258, p259, p260)
			if p259.Type ~= "Dark" then
				return p260;
			end;
			p256:AddDialogue(p256.ActionList, "&DOODLENAME," .. p258.ID .. "&'s Dark Candy Cube reduced the damage of this attack!");
			p258.HeldItem = nil;
			return math.floor(p260 * 0.5);
		end
	};
	u1["Beast Taffy"] = {
		Description = "A taffy made in Von Sweets' Factory. Give this item to boost the damage of one Beast-type attack. This item is consumed after use.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(119, 60, 46), 
		Image = "http://www.roblox.com/asset/?id=9553001420", 
		OffensiveDamageCalc = function(p261, p262, p263, p264, p265)
			if p264.Type ~= "Beast" then
				return p265;
			end;
			p262.HeldItem = nil;
			p261:AddDialogue(p261.ActionList, "&DOODLENAME," .. p262.ID .. "& consumed their Beast Taffy! This attack is doing more damage!");
			return p265 * 1.5;
		end
	};
	u1["Beast Candy Cube"] = {
		Description = "Some candy made in von Sweets' factory. Give this item to a Doodle to reduce the power of a Beast-type attack. This item is consumed after use.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(119, 60, 46), 
		Image = "http://www.roblox.com/asset/?id=9918364486", 
		DuringDamageCalc = function(p266, p267, p268, p269, p270)
			if p269.Type ~= "Beast" then
				return p270;
			end;
			p266:AddDialogue(p266.ActionList, "&DOODLENAME," .. p268.ID .. "&'s Beast Candy Cube reduced the damage of this attack!");
			p268.HeldItem = nil;
			return math.floor(p270 * 0.5);
		end
	};
	u1["Magical Jelly"] = {
		Description = "Give this item to a Doodle to increase the power of one of their magical attacks. This item is consumed  after use.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(185, 19, 26), 
		Image = "http://www.roblox.com/asset/?id=7325462966", 
		OffensiveDamageCalc = function(p271, p272, p273, p274, p275)
			if p274.Category ~= "Magical" then
				return p275;
			end;
			local v35 = 1.2;
			if p271:GetTraitInfo(p272).BetterJelly then
				v35 = 1.6;
			end;
			p272.HeldItem = nil;
			p271:AddDialogue(p271.ActionList, "&DOODLENAME," .. p272.ID .. "& used their Magical Jelly! This next attack is doing more damage!");
			return p275 * v35;
		end
	};
	u1["Defensive Jelly"] = {
		Description = "Give this item to a Doodle to reduce the power of a super-effective attack. This item is consumed after use.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(51, 11, 153), 
		Image = "http://www.roblox.com/asset/?id=7325543224", 
		DuringDamageCalc = function(p276, p277, p278, p279, p280)
			if not (p1.Database.Typings:GetEffectiveness(p277, p278, p279.Type) > 1) then
				return p280;
			end;
			p276:AddDialogue(p276.ActionList, "&DOODLENAME," .. p278.ID .. "&'s Defensive Jelly reduced the damage of this attack!");
			p278.HeldItem = nil;
			local v36 = 0.85;
			if p276:GetTraitInfo(p278).BetterJelly then
				v36 = 0.3;
			end;
			return math.floor(p280 * v36);
		end
	};
	u1["Weird Jelly"] = {
		Description = "Give this item to a Doodle to boost their attack and magic attack after they are hit with a super effective attack. This item is consumed after use.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(44, 44, 44), 
		Image = "http://www.roblox.com/asset/?id=8864653270", 
		AfterDamage = function(p281, p282, p283, p284)
			if not p283 then
				return;
			end;
			if p1.Database.Typings:GetEffectiveness(p283, p282, p284.Type) > 1 then
				p281:AddDialogue(p281.ActionList, "&DOODLENAME," .. p282.ID .. "&'s Weird Jelly activated!");
				local v37 = 1;
				if p281:GetTraitInfo(p282).BetterJelly then
					v37 = 2;
				end;
				l__Utilities__1.ChangeStats(p281, p282, p282, 100, {
					atk = v37, 
					matk = v37
				});
				p282.HeldItem = nil;
			end;
		end
	};
	u1["Power Jelly"] = {
		Description = "Give this item to a Doodle to restore their stats when they are lowered.  This item is consumed after use.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(175, 175, 174), 
		Image = "http://www.roblox.com/asset/?id=8864653882", 
		OnStatChange = function(p285, p286, p287, p288, p289)
			local v38 = nil;
			for v39, v40 in pairs(p286.Boosts) do
				if p286.Boosts[v39] < 0 then
					v38 = true;
					p286.Boosts[v39] = 0;
				end;
			end;
			if v38 then
				p285:AddDialogue(p285.ActionList, "&DOODLENAME," .. p286.ID .. "&'s Power Jelly prevented their stats from lowering!");
				if not p285:GetTraitInfo(p286).BetterJelly or not (not p286.UsedJelly) then
					p286.HeldItem = nil;
					return;
				end;
			else
				return;
			end;
			p286.BetterJelly = true;
			p285:AddDialogue(p285.ActionList, "The Power Jelly wasn't consumed because of " .. p286.ID .. "&'s Jelly Enhancer!");
		end
	};
	u1["Candy Heart"] = {
		Description = "This weird object made of candy fits snugly in your hand, and feels as though it'll start beating.  Allows a certain Doodle to evolve.", 
		Type = "OverworldOnly", 
		Target = "Party", 
		Category = "Items", 
		EvolveItem = true, 
		Color3 = Color3.fromRGB(255, 255, 255), 
		DontCloseImmediately = true, 
		Image = "http://www.roblox.com/asset/?id=8830143801", 
		Function = function(p290, p291, p292)
			if p291 then
				return false;
			end;
			local v41 = p1.DoodleInfo[p290.Name];
			if v41.Evolve and v41.Evolve.Item and v41.Evolve.Item["Candy Heart"] then
				local v42 = true;
			else
				v42 = false;
			end;
			if not v42 then
				return (p290.Nickname or p290.Name) .. " cannot evolve using the Candy Heart!";
			end;
			if game:GetService("RunService"):IsServer() then
				p290:EvolveItem(p292, "Candy Heart");
				return true;
			end;
			return "Evolving " .. (p290.Nickname or p290.Name) .. "...", true;
		end
	};
	u1["Orb of Light"] = {
		Description = "This strange orb of light allows certain Doodles to evolve.", 
		Type = "OverworldOnly", 
		Target = "Party", 
		Category = "Items", 
		EvolveItem = true, 
		Color3 = Color3.fromRGB(255, 255, 127), 
		DontCloseImmediately = true, 
		Image = "http://www.roblox.com/asset/?id=8463939552", 
		Function = function(p293, p294, p295)
			if p294 then
				return false;
			end;
			local v43 = p1.DoodleInfo[p293.Name];
			if v43.Evolve and v43.Evolve.Item and v43.Evolve.Item["Orb of Light"] then
				local v44 = true;
			else
				v44 = false;
			end;
			if not v44 then
				return (p293.Nickname or p293.Name) .. " cannot evolve using the Orb of Light!";
			end;
			if game:GetService("RunService"):IsServer() then
				p293:EvolveItem(p295, "Orb of Light");
				return true;
			end;
			return "Evolving " .. (p293.Nickname or p293.Name) .. "...", true;
		end
	};
	u1["Gold Capsule"] = {
		Description = "Use this on a wild Doodle to capture it. This capsule will never fail on a wild doodle.", 
		Target = "Capsule", 
		CaptureRate = "Gold", 
		Price = 50, 
		RobuxOnly = true, 
		DevProduct = 1251977223, 
		Category = "Capsules", 
		BattleOnly = true, 
		Color3 = Color3.fromRGB(255, 224, 79), 
		CapsuleName = "Gold", 
		Image = "http://www.roblox.com/asset/?id=10007156625", 
		Function = function(p296, p297, p298)

		end
	};
	u1["Striped Capsule"] = {
		Description = "Use this on a wild Doodle in an attempt to capture it. Has a higher chance to capture than Basic Capsules.", 
		Target = "Capsule", 
		CaptureRate = 1.5, 
		Price = 1000, 
		Category = "Capsules", 
		BattleOnly = true, 
		CapsuleName = "Striped", 
		Image = "http://www.roblox.com/asset/?id=10007174600", 
		Color3 = Color3.fromRGB(52, 93, 191), 
		Function = function(p299, p300, p301)

		end
	};
	u1["Cauldron Capsule"] = {
		Description = "Use this on a wild Doodle in an attempt to capture it. Has a higher chance to capture Doodles encountered while trick-or-treating.", 
		Target = "Capsule", 
		CaptureRate = 1, 
		Category = "Capsules", 
		BattleOnly = true, 
		CapsuleName = "Cauldron", 
		Image = "http://www.roblox.com/asset/?id=11323980554", 
		Color3 = Color3.fromRGB(174, 212, 186), 
		CatchModifier = function(p302)
			if p302 and p302.Halloween then
				return 4;
			end;
			return 1;
		end
	};
	u1["Witch Capsule"] = {
		Description = "Use this on a wild Doodle in an attempt to capture it. Has a higher chance to capture Doodles encountered while trick-or-treating.", 
		Target = "Capsule", 
		CaptureRate = 1, 
		Category = "Capsules", 
		BattleOnly = true, 
		CapsuleName = "Witch", 
		Image = "http://www.roblox.com/asset/?id=11324048113", 
		Color3 = Color3.fromRGB(45, 92, 86), 
		CatchModifier = function(p303)
			if p303 and p303.Halloween then
				return 4;
			end;
			return 1;
		end
	};
	u1["Winged Capsule"] = {
		Description = "Use this on a wild Doodle in an attempt to capture it. Has a higher chance to capture Doodles encountered while trick-or-treating.", 
		Target = "Capsule", 
		CaptureRate = 1, 
		Category = "Capsules", 
		BattleOnly = true, 
		CapsuleName = "Winged", 
		Image = "http://www.roblox.com/asset/?id=11323888628", 
		Color3 = Color3.fromRGB(33, 17, 54), 
		CatchModifier = function(p304)
			if p304 then
				print(p304);
				if p304.Halloween then
					print("works");
					return 4;
				end;
			end;
			return 1;
		end
	};
	u1["Dense Capsule"] = {
		Description = "Use this on a wild Doodle in an attempt to capture it. Has a higher chance to capture heavier Doodles.", 
		Target = "Capsule", 
		CaptureRate = 1, 
		Category = "Capsules", 
		Price = 1000, 
		BattleOnly = true, 
		CapsuleName = "Dense", 
		Image = "http://www.roblox.com/asset/?id=10006233658", 
		Color3 = Color3.fromRGB(51, 49, 49), 
		CatchModifier = function(p305)
			if not p305 then
				return 1;
			end;
			local v45 = p1.DoodleInfo[p305.Name];
			if v45.Weight < 30 then
				return 0.25;
			end;
			if v45.Weight < 80 then
				return 0.75;
			end;
			if v45.Weight < 130 then
				return 1.25;
			end;
			if v45.Weight < 180 then
				return 1.75;
			end;
			if v45.Weight < 230 then
				return 2.25;
			end;
			if v45.Weight < 280 then
				return 2.5;
			end;
			return 3;
		end
	};
	u1["Polkadot Capsule"] = {
		Description = "Use this on a wild Doodle in an attempt to capture it. Has a higher chance to capture than Striped Capsules.", 
		Target = "Capsule", 
		CaptureRate = 2, 
		Price = 2000, 
		Category = "Capsules", 
		BattleOnly = true, 
		CapsuleName = "Polkadot", 
		Image = "http://www.roblox.com/asset/?id=10006345035", 
		Color3 = Color3.fromRGB(224, 82, 86), 
		Function = function(p306, p307, p308)

		end
	};
	u1["Heart Capsule"] = {
		Description = "Use this on a wild Doodle in an attempt to capture it. Doodles caught in this capsule will become friendlier faster.", 
		Target = "Capsule", 
		CaptureRate = 1, 
		Category = "Capsules", 
		BattleOnly = true, 
		Price = 1000, 
		CapsuleName = "Heart", 
		Image = "http://www.roblox.com/asset/?id=10006572228", 
		Color3 = Color3.fromRGB(224, 82, 86), 
		AfterCaught = function(p309)
			p309.Friendship = 128;
		end
	};
	u1["Medical Capsule"] = {
		Description = "Use this on a wild Doodle in an attempt to capture it. After being captured, the Doodle's health is fully restored .", 
		Target = "Capsule", 
		CaptureRate = 1, 
		Category = "Capsules", 
		BattleOnly = true, 
		Price = 1000, 
		CapsuleName = "Medical", 
		Image = "http://www.roblox.com/asset/?id=10006436146", 
		Color3 = Color3.fromRGB(137, 203, 255), 
		AfterCaught = function(p310)
			p310:Heal();
		end
	};
	u1["Basic Capsule"] = {
		Description = "Use this on a wild Doodle in an attempt to capture it.", 
		Target = "Capsule", 
		CaptureRate = 1, 
		Price = 400, 
		Category = "Capsules", 
		BattleOnly = true, 
		CapsuleName = "Basic", 
		Color3 = Color3.fromRGB(255, 255, 255), 
		Image = "http://www.roblox.com/asset/?id=10007141516", 
		Function = function(p311, p312, p313)

		end
	};
	u1["Magical Banana"] = {
		Description = "Use this on a Doodle in battle to temporarily raise its magic attack.", 
		Target = "Out", 
		Price = 1000, 
		BattleOnly = true, 
		Category = "Items", 
		Color3 = Color3.fromRGB(0, 255, 255), 
		Image = "http://www.roblox.com/asset/?id=5723459665", 
		Function = function(p314, p315, p316)
			p314.Boosts.matk = p314.Boosts.matk + 2;
			return true;
		end
	};
	u1["Power Banana"] = {
		Description = "Use this on a Doodle in battle to temporarily raise its attack.", 
		Target = "Out", 
		BattleOnly = true, 
		Price = 1000, 
		Category = "Items", 
		Color3 = Color3.fromRGB(255, 255, 0), 
		Image = "http://www.roblox.com/asset/?id=5723501902", 
		Function = function(p317, p318, p319)
			p317.Boosts.atk = p317.Boosts.atk + 2;
			return true;
		end
	};
	u1["Speed Soda"] = {
		Description = "Use this on a Doodle in battle to temporarily raise its speed.", 
		Target = "Out", 
		BattleOnly = true, 
		Price = 1000, 
		Category = "Items", 
		Color3 = Color3.fromRGB(0, 255, 255), 
		Image = "http://www.roblox.com/asset/?id=5721610564", 
		Function = function(p320, p321, p322)
			p320.Boosts.spe = p320.Boosts.spe + 2;
			return true;
		end
	};
	u1["Defense Orange"] = {
		Description = "Use this on a Doodle in battle to temporarily raise its defense.", 
		Target = "Out", 
		BattleOnly = true, 
		Price = 1000, 
		Category = "Items", 
		Color3 = Color3.fromRGB(255, 85, 0), 
		Image = "http://www.roblox.com/asset/?id=5723467215", 
		Function = function(p323, p324, p325)
			p323.Boosts.def = p323.Boosts.def + 2;
			return true;
		end
	};
	u1["Resist Grapes"] = {
		Description = "Use this on a Doodle in battle to temporarily raise its magical defense.", 
		Target = "Out", 
		BattleOnly = true, 
		Price = 1000, 
		Category = "Items", 
		Color3 = Color3.fromRGB(170, 85, 255), 
		Image = "http://www.roblox.com/asset/?id=5721610847", 
		Function = function(p326, p327, p328)
			p326.Boosts.mdef = p326.Boosts.mdef + 2;
			return true;
		end
	};
	u1["Sandstorm in a Bottle"] = {
		Description = "Once per battle, when this Doodle gets sent out, summons Sandstorm if there isn't sandstorm already.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(250, 208, 86), 
		Image = "http://www.roblox.com/asset/?id=10753735920", 
		SendOut = function(p329, p330, p331)
			if not p330.BottleUse and p329.Weather ~= "Sandstorm" then
				p329:AddDialogue(p329.ActionList, "&DOODLENAME," .. p330.ID .. "& unleashed their Sandstorm in a Bottle!");
				p330.BottleUse = true;
				p1.Database.Moves.Sandstorm.BattleFunc(p329, p330, p330);
			end;
		end
	};
	u1["Acid Storm in a Bottle"] = {
		Description = "Once per battle, when this Doodle gets sent out, summons Acid Rain if there isn't Acid Rain already.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(117, 155, 91), 
		Image = "http://www.roblox.com/asset/?id=10753580988", 
		SendOut = function(p332, p333, p334)
			if not p333.BottleUse and p332.Weather ~= "Chocolate Rain" then
				p332:AddDialogue(p332.ActionList, "&DOODLENAME," .. p333.ID .. "& unleashed their Acid Storm in a Bottle!");
				p333.BottleUse = true;
				p1.Database.Moves["Acid Rain"].BattleFunc(p332, p333, p333);
			end;
		end
	};
	u1["Edible Storm in a Bottle"] = {
		Description = "Once per battle, when this Doodle gets sent out, summons Chocolate Rain if there isn't Chocolate Rain already.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(159, 128, 80), 
		Image = "http://www.roblox.com/asset/?id=10753581726", 
		SendOut = function(p335, p336, p337)
			if not p336.BottleUse and p335.Weather ~= "Chocolate Rain" then
				p335:AddDialogue(p335.ActionList, "&DOODLENAME," .. p336.ID .. "& unleashed their Edible Storm in a Bottle!");
				p336.BottleUse = true;
				p1.Database.Moves["Chocolate Rain"].BattleFunc(p335, p336, p336);
			end;
		end
	};
	u1["Starry Glasses"] = {
		Description = "Give this item to a Doodle and when it gets sent out, identifies the stars the opponents have.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(250, 208, 86), 
		Image = "http://www.roblox.com/asset/?id=9443817615", 
		SendOut = function(p338, p339, p340)
			local v46 = "Stars";
			if p340.Star == 1 then
				v46 = "Star";
			end;
			p338:AddDialogue(p338.ActionList, "&DOODLENAME," .. p340.ID .. "&" .. " has " .. p340.Star .. " " .. v46 .. "!");
		end
	};
	u1.Glasses = {
		Description = "Give this item to a Doodle to improve its accuracy of all its moves by 20%.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(0, 255, 255), 
		Image = "http://www.roblox.com/asset/?id=5721611157", 
		AttackModifier = function(p341, p342, p343, p344)
			if typeof(p344.Accuracy) == "number" then
				p344.Accuracy = math.floor(p344.Accuracy * 1.2);
			end;
		end
	};
	u1["Ice Pack"] = {
		Description = "Give this item to a Doodle to improve the damage of its Ice-type attacks.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(84, 120, 201), 
		Image = "http://www.roblox.com/asset/?id=9136451114", 
		ModifyDamage = function(p345, p346, p347, p348)
			local v47 = 1;
			if p348.Type == "Ice" then
				v47 = 1.2;
			end;
			return v47;
		end
	};
	u1["Lucky Pebble"] = {
		Description = "Give this item to a Doodle to improve the damage of its Earth-type attacks.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(84, 120, 201), 
		Image = "http://www.roblox.com/asset/?id=9135923816", 
		ModifyDamage = function(p349, p350, p351, p352)
			local v48 = 1;
			if p352.Type == "Earth" then
				v48 = 1.2;
			end;
			return v48;
		end
	};
	u1.Battery = {
		Description = "Give this item to a Doodle to improve the damage of its Spark-type attacks.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(236, 201, 98), 
		Image = "http://www.roblox.com/asset/?id=9136628337", 
		ModifyDamage = function(p353, p354, p355, p356)
			local v49 = 1;
			if p356.Type == "Spark" then
				v49 = 1.2;
			end;
			return v49;
		end
	};
	u1["Delicate Wing"] = {
		Description = "Give this item to a Doodle to improve the damage of its Insect-type attacks.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(133, 229, 248), 
		Image = "http://www.roblox.com/asset/?id=9927426456", 
		ModifyDamage = function(p357, p358, p359, p360)
			local v50 = 1;
			if p360.Type == "Insect" then
				v50 = 1.25;
			end;
			return v50;
		end
	};
	u1["Pretty Seashell"] = {
		Description = "Give this item to a Doodle to improve the damage of its Water-type attacks.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(246, 199, 207), 
		Image = "http://www.roblox.com/asset/?id=9927650899", 
		ModifyDamage = function(p361, p362, p363, p364)
			local v51 = 1;
			if p364.Type == "Water" then
				v51 = 1.25;
			end;
			return v51;
		end
	};
	u1["Moon Charm"] = {
		Description = "Give this item to a Doodle to improve the damage of its Dark-type attacks.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(232, 217, 182), 
		Image = "http://www.roblox.com/asset/?id=11607464437", 
		ModifyDamage = function(p365, p366, p367, p368)
			local v52 = 1;
			if p368.Type == "Dark" then
				v52 = 1.25;
			end;
			return v52;
		end
	};
	u1["Refractive Prism"] = {
		Description = "Give this item to a Doodle to improve the damage of its Light-type attacks.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(219, 229, 238), 
		Image = "http://www.roblox.com/asset/?id=11573518034", 
		ModifyDamage = function(p369, p370, p371, p372)
			local v53 = 1;
			if p372.Type == "Light" then
				v53 = 1.25;
			end;
			return v53;
		end
	};
	u1["Crooked Talon"] = {
		Description = "Give this item to a Doodle to improve the damage of its Beast-type attacks.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(193, 171, 146), 
		Image = "http://www.roblox.com/asset/?id=11570491300", 
		ModifyDamage = function(p373, p374, p375, p376)
			local v54 = 1;
			if p376.Type == "Beast" then
				v54 = 1.25;
			end;
			return v54;
		end
	};
	u1["Perfect Alloy"] = {
		Description = "Give this item to a Doodle to improve the damage of its Metal-type attacks.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(233, 155, 120), 
		Image = "http://www.roblox.com/asset/?id=11570228995", 
		ModifyDamage = function(p377, p378, p379, p380)
			local v55 = 1;
			if p380.Type == "Metal" then
				v55 = 1.25;
			end;
			return v55;
		end
	};
	u1["Small Sprout"] = {
		Description = "Give this item to a Doodle to improve the damage of its Plant-type attacks.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(118, 147, 68), 
		Image = "http://www.roblox.com/asset/?id=9927929408", 
		ModifyDamage = function(p381, p382, p383, p384)
			local v56 = 1;
			if p384.Type == "Plant" then
				v56 = 1.25;
			end;
			return v56;
		end
	};
	u1.Bubblegum = {
		Description = "Give this item to a Doodle to improve the damage of its Food-type attacks.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(230, 104, 167), 
		Image = "http://www.roblox.com/asset/?id=9717440683", 
		ModifyDamage = function(p385, p386, p387, p388)
			local v57 = 1;
			if p388.Type == "Food" then
				v57 = 1.25;
			end;
			return v57;
		end
	};
	local v58 = {
		Description = "Give this item to a Doodle. At the end of each turn, it inflicts a disease on the user.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(178, 172, 127), 
		Image = "http://www.roblox.com/asset/?id=11599582626"
	};
	local l__InflictStatus__3 = l__Utilities__1.InflictStatus;
	function v58.EndTurn(p389, p390, p391)
		if p390.currenthp > 0 and p390.Status == nil then
			l__InflictStatus__3(p389, p390, p390, 100, "Diseased", nil, "&DOODLENAME," .. p390.ID .. "& is holding the unwashed plushie!");
			p390.NoBurn = true;
			p390.NoExtra = true;
		end;
	end;
	u1["Unwashed Plushie"] = v58;
	u1.Lighter = {
		Description = "Give this item to a Doodle. At the end of each turn, it inflicts a burn on the user.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(250, 179, 66), 
		Image = "http://www.roblox.com/asset/?id=10006277376", 
		EndTurn = function(p392, p393, p394)
			if p393.currenthp > 0 and p393.Status == nil then
				l__InflictStatus__3(p392, p393, p393, 100, "Burn", nil, "&DOODLENAME," .. p393.ID .. "& is holding a lighter!");
				p393.NoBurn = true;
				p393.NoExtra = true;
			end;
		end
	};
	u1["Used Timber"] = {
		Description = "Give this item to a Doodle to improve the damage of its Fire-type attacks.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(68, 47, 45), 
		Image = "http://www.roblox.com/asset/?id=9136096252", 
		ModifyDamage = function(p395, p396, p397, p398)
			local v59 = 1;
			if p398.Type == "Fire" then
				v59 = 1.25;
			end;
			return v59;
		end
	};
	u1["Champion Belt"] = {
		Description = "Give this item to a Doodle to improve its physical attacks.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(248, 196, 100), 
		Image = "http://www.roblox.com/asset/?id=6830108296", 
		ModifyDamage = function(p399, p400, p401, p402)
			local v60 = 1;
			if p402.Category == "Physical" then
				v60 = 1.1;
			end;
			return v60;
		end
	};
	u1["Determination Jelly"] = {
		Description = "Give this item to a Doodle. If they have full HP, the holder will survive an attack that would otherwise cause it to faint. This item is consumed after use.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(224, 84, 3), 
		Image = "http://www.roblox.com/asset/?id=7325471960", 
		DuringDamageCalc = function(p403, p404, p405, p406, p407)
			local v61 = false;
			if typeof(p407) == "number" and p407 > 0 and p405.Stats.hp <= p407 and (p405.Stats.hp <= p405.currenthp or p403:GetTraitInfo(p405).BetterJelly) then
				p403:AddDialogue(p403.ActionList, "&DOODLENAME," .. p405.ID .. "& held on thanks to its Determination Jelly!");
				p407 = p405.currenthp - 1;
				v61 = true;
				p405.HeldItem = nil;
			end;
			return p407, v61;
		end
	};
	u1["Determination Headband"] = {
		Description = "Give this item to a Doodle. The Doodle may survive attacks that would otherwise cause it to faint.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(193, 80, 58), 
		Image = "http://www.roblox.com/asset/?id=6832985197", 
		DuringDamageCalc = function(p408, p409, p410, p411, p412)
			local v62 = false;
			if typeof(p412) == "number" and p412 > 0 and math.random(1, 8) == 1 and p410.currenthp <= p412 then
				p408:AddDialogue(p408.ActionList, "&DOODLENAME," .. p410.ID .. "& held on thanks to its Determination!");
				p412 = p410.currenthp - 1;
				v62 = true;
			end;
			return p412, v62;
		end
	};
	u1.Grease = {
		Description = "Give this item to a Doodle to prevent it from getting trapped or wrapped", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(207, 187, 127), 
		Image = "http://www.roblox.com/asset/?id=9135977089", 
		Grease = true
	};
	u1["Used Crayons"] = {
		Description = "Give this item to a Doodle to have it restore a little bit of its health at the end of every turn.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(255, 255, 255), 
		Image = "http://www.roblox.com/asset/?id=6852190534", 
		EndTurn = function(p413, p414, p415)
			if p414.currenthp > 0 and p414.currenthp < p414.Stats.hp then
				p413:TakeDamage(p414, -math.floor(p414.Stats.hp / 16));
				p413:AddDialogue(p413.ActionList, "&DOODLENAME," .. p414.ID .. "& restored health from its Used Crayons!");
			end;
		end
	};
	u1["Dark Chocolate"] = {
		Description = "Give this item to a Doodle. If they're a Food-type, they gain health at the end of each turn. If not, they take damage at the end of each turn.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(84, 54, 46), 
		Image = "http://www.roblox.com/asset/?id=10005745096", 
		EndTurn = function(p416, p417, p418)
			if p417.currenthp > 0 then
				if l__Utilities__1.IsType(p417, "Food") and p417.currenthp < p417.Stats.hp then
					p416:TakeDamage(p417, -math.floor(p417.Stats.hp / 16));
					p416:AddDialogue(p416.ActionList, "&DOODLENAME," .. p417.ID .. "& restored health from its Dark Chocolate!");
					return;
				end;
				if not l__Utilities__1.IsType(p417, "Food") then
					p416:TakeDamage(p417, (math.floor(p417.Stats.hp / 16)));
					p416:AddDialogue(p416.ActionList, "&DOODLENAME," .. p417.ID .. "& took damage from its Dark Chocolate!");
				end;
			end;
		end
	};
	u1.Espresso = {
		Description = "Give this item to a Doodle. This Doodle has a 25% chance to move first each turn.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(173, 104, 61), 
		Image = "http://www.roblox.com/asset/?id=10743059479", 
		Espresso = true
	};
	u1["Riot Shield"] = {
		Description = "Give this item to a Doodle. It protects them from effects caused by attacking the target.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(173, 104, 61), 
		Image = "http://www.roblox.com/asset/?id=11667891264", 
		DisableOnHit = true
	};
	u1["Mawthra Rune"] = {
		Description = "A strange rune from long ago researched by DoodleCo. Give this item to Mawthra to have it awaken its true power.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Runestone = true, 
		Awakening = {
			Requirement = "Mawthra", 
			Awakened = "Mawthra-A"
		}, 
		Color3 = Color3.fromRGB(247, 230, 255), 
		Image = "http://www.roblox.com/asset/?id=11702233589"
	};
	u1["Spiky Thorns"] = {
		Description = "Give this item to a Doodle. If the holder is hit with a contact move, the attacker will also be damaged.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(118, 103, 118), 
		Image = "http://www.roblox.com/asset/?id=10779923969", 
		OnHit = function(p419, p420, p421, p422)
			if p422.Contact then
				local v63 = math.floor(p421.Stats.hp / 6);
				if v63 > 0 then
					p419:TakeDamage(p421, v63);
					p419:AddDialogue(p419.ActionList, "&DOODLENAME," .. p420.ID .. "&" .. "'s Spiky Thorns hurt " .. "&DOODLENAME," .. p421.ID .. "&!");
				end;
			end;
		end
	};
	u1["Sickly Ooze"] = {
		Description = "Whenever this Doodle would inflict Poison, inflict Diseased instead.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(164, 182, 113), 
		Image = "http://www.roblox.com/asset/?id=10615712182", 
		StatusModifier = function(p423, p424, p425, p426, p427)
			if p426 ~= "Poison" then
				return p426, p427;
			end;
			return "Diseased", p427 * 2;
		end
	};
	u1["Cursed Cloak"] = {
		Description = "Give this item to a Doodle. Disables the use of Support moves, but boosts Magical Defense by 50%.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(190, 165, 213), 
		Image = "http://www.roblox.com/asset/?id=10651317784", 
		ModifyDefense = function(p428, p429, p430, p431, p432)
			if p432 == "mdef" then
				return 1.5;
			end;
			return 1;
		end
	};
	u1["Gold Laminate"] = {
		Description = "Give this item to a Doodle to preserve it, stopping it from evolving. If the Doodle is able to evolve, boost its Defense and Magical Defense by 50%.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(254, 241, 203), 
		Image = "http://www.roblox.com/asset/?id=10663681148", 
		NoEvolve = true, 
		ModifyDefense = function(p433, p434, p435, p436, p437)
			if p1.DoodleInfo[p435.RealName].Evolve then
				return 1.5;
			end;
			return 1;
		end
	};
	u1.Laminate = {
		Description = "Give this item to a Doodle to preserve it, stopping it from evolving.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(214, 216, 236), 
		Image = "http://www.roblox.com/asset/?id=10663680220", 
		NoEvolve = true
	};
	u1["Level-Down Cube"] = {
		Description = "When this item is used on a Doodle, the Doodle levels down.", 
		Type = "OverworldOnly", 
		Target = "Party", 
		Category = "Items", 
		Price = 200, 
		LevelupItem = true, 
		DontCloseImmediately = true, 
		Color3 = Color3.fromRGB(85, 111, 121), 
		Image = "http://www.roblox.com/asset/?id=9283898560", 
		Function = function(p438, p439, p440)
			if p439 then
				return false;
			end;
			if p438.Level <= 5 then
				return (p438.Nickname or p438.Name) .. " is too low level!";
			end;
			if game:GetService("RunService"):IsServer() then
				p438:LevelDown(p440, true, false, true);
				return true;
			end;
			return (p438.Nickname or p438.Name) .. " leveled down!", true, "Levelup";
		end
	};
	u1["Doodle Unlocker"] = {
		Description = "Lets you un-tradelock a Doodle obtained from using a Roulette ticket.", 
		Type = "OverworldOnly", 
		Target = "Party", 
		Category = "Items", 
		Price = 40, 
		RobuxOnly = true, 
		Unlocker = true, 
		DevProduct = 1305015576, 
		Color3 = Color3.fromRGB(237, 196, 105), 
		Image = "http://www.roblox.com/asset/?id=10736808597", 
		Function = function(p441, p442, p443)
			if p442 then
				return false;
			end;
			if p441.NR then
				return (p441.Nickname or p441.Name) .. " is your beginner Doodle!";
			end;
			if not p441.TL then
				return "You can't unlock " .. (p441.Nickname or p441.Name) .. ", they aren't trade locked!";
			end;
			if game:GetService("RunService"):IsServer() then
				p441:Unlock();
				return true;
			end;
			return (p441.Nickname or p441.Name) .. " was unlocked!", true, "Lockpick";
		end
	};
	u1["Level-Up Cube"] = {
		Description = "When this item is used on a Doodle, the Doodle levels up!", 
		Type = "OverworldOnly", 
		Target = "Party", 
		Category = "Items", 
		Price = 20, 
		RobuxOnly = true, 
		LevelupItem = true, 
		DevProduct = 1197967011, 
		DontCloseImmediately = true, 
		Color3 = Color3.fromRGB(65, 29, 2), 
		Image = "http://www.roblox.com/asset/?id=8951230295", 
		Function = function(p444, p445, p446)
			if p445 then
				return false;
			end;
			local v64 = l__Utilities__1.LevelCap(p446);
			if v64 < p444.Level + 1 then
				return (p444.Nickname or p444.Name) .. " is already past the level cap (" .. v64 .. ")!";
			end;
			if game:GetService("RunService"):IsServer() then
				p444:Levelup(p446, true, false, true);
				return true;
			end;
			return (p444.Nickname or p444.Name) .. " leveled up!", true, "Levelup";
		end
	};
	u1["Halloween Tintbrush"] = {
		Description = "Replaces a Doodle's tint with the Halloween tint.", 
		Type = "OverworldOnly", 
		Target = "Party", 
		Category = "Items", 
		Color3 = Color3.fromRGB(230, 143, 72), 
		Image = "http://www.roblox.com/asset/?id=11218982487", 
		Function = function(p447, p448, p449)
			if p448 then
				return false;
			end;
			local v65 = p447.Nickname or p447.Name;
			if p447.Tint ~= 0 and p447.Tint[1] == 15 then
				return v65 .. " already has the Halloween tint!";
			end;
			if game:GetService("RunService"):IsServer() then
				p447:ChangeTint(15);
				return true;
			end;
			if p447.Tint == 0 then
				return v65 .. " now has the Halloween tint!", true;
			end;
			return v65 .. " has its current tint replaced with the Halloween Tint!", true;
		end
	};
	u1["Christmas Tintbrush"] = {
		Description = "Replaces a Doodle's tint with the Christmas tint.", 
		Type = "OverworldOnly", 
		Target = "Party", 
		Category = "Items", 
		Color3 = Color3.fromRGB(232, 209, 163), 
		Image = "http://www.roblox.com/asset/?id=11768064360", 
		Function = function(p450, p451, p452)
			if p451 then
				return false;
			end;
			local v66 = p450.Nickname or p450.Name;
			if p450.Tint ~= 0 and p450.Tint[1] == 16 then
				return v66 .. " already has the Christmas tint!";
			end;
			if game:GetService("RunService"):IsServer() then
				p450:ChangeTint(16);
				return true;
			end;
			if p450.Tint == 0 then
				return v66 .. " now has the Christmas tint!", true;
			end;
			return v66 .. " has its current tint replaced with the Christmas Tint!", true;
		end
	};
	u1["Tint Scraper"] = {
		Description = "Removes a Doodle's tint(s).", 
		Type = "OverworldOnly", 
		Target = "Party", 
		Category = "Items", 
		Price = 500, 
		Color3 = Color3.fromRGB(162, 176, 226), 
		Image = "http://www.roblox.com/asset/?id=11328515165", 
		Function = function(p453, p454, p455)
			if p454 then
				return false;
			end;
			local v67 = p453.Nickname or p453.Name;
			if p453.Tint == 0 then
				return v67 .. " has no tint!";
			end;
			if game:GetService("RunService"):IsServer() then
				p453:ChangeTint(0);
				return true;
			end;
			if p453.Tint == 0 then
				return v67 .. " has no tint to remove!";
			end;
			if #p453.Tint == 1 then
				return v67 .. "'s tint has been removed!", true;
			end;
			if not (#p453.Tint > 1) then
				return;
			end;
			return v67 .. "'s tints have been removed!", true;
		end
	};
	u1["Speed Token"] = {
		Description = "Use this on a Doodle that doesn't have 6 stars to give them a bit more speed.", 
		Type = "OverworldOnly", 
		Target = "Party", 
		Category = "Items", 
		LevelupItem = true, 
		Color3 = Color3.fromRGB(167, 215, 252), 
		Image = "http://www.roblox.com/asset/?id=10715266359", 
		Function = function(p456, p457, p458)
			if p457 then
				return false;
			end;
			if p456.NStar + p456.Star >= 6 then
				return "You can't use any more speed tokens on " .. (p456.Nickname or p456.Name) .. "!";
			end;
			if game:GetService("RunService"):IsServer() then
				p456:SpeedToken(p458);
				return true;
			end;
			return (p456.Nickname or p456.Name) .. " gained a little bit of speed!", true, "Levelup";
		end
	};
	u1["Silver Level-Up Cube"] = {
		Description = "When this item is used on a Doodle, the Doodle levels up three times!", 
		Type = "OverworldOnly", 
		LevelupItem = true, 
		Target = "Party", 
		Category = "Items", 
		DontCloseImmediately = true, 
		Color3 = Color3.fromRGB(208, 208, 208), 
		Image = "http://www.roblox.com/asset/?id=8951231016", 
		Function = function(p459, p460, p461)
			if p460 then
				return false;
			end;
			if l__Utilities__1.LevelCap(p461) < p459.Level + 3 then
				return (p459.Nickname or p459.Name) .. " is too high level...";
			end;
			if not game:GetService("RunService"):IsServer() then
				return (p459.Nickname or p459.Name) .. " leveled up thrice!", true, "Levelup";
			end;
			local v68 = p459:Levelup(p461, true, true, true, (p459:Levelup(p461, true, true, false, (p459:Levelup(p461, true, true, false, {})))));
			return true;
		end
	};
	u1["Master Cube"] = {
		Description = "[DEV ITEM] When this item is used on a Doodle, the Doodle levels up to 100!", 
		Type = "OverworldOnly", 
		LevelupItem = true, 
		Target = "Party", 
		Category = "Items", 
		DontCloseImmediately = true, 
		Color3 = Color3.fromRGB(120, 120, 120), 
		Image = "http://www.roblox.com/asset/?id=8962603595", 
		Function = function(p462, p463, p464, p465)
			if p463 then
				return false;
			end;
			if p462.Level >= 100 then
				return (p462.Nickname or p462.Name) .. " is already level 100!";
			end;
			if not game:GetService("RunService"):IsServer() then
				return (p462.Nickname or p462.Name) .. " is now level 100!", true, "Levelup";
			end;
			local v69 = {};
			local v70 = 100 - p462.Level;
			for v71 = 1, v70 do
				v69 = p462:Levelup(p464, true, true, v71 == v70, v69);
			end;
			return true;
		end
	};
	u1["Training Helper"] = {
		Description = "If this item is on, every Doodle in your party gets experience in each battle.", 
		Type = "Toggleable", 
		Category = "Key Items", 
		Color3 = Color3.fromRGB(255, 255, 255), 
		Image = "http://www.roblox.com/asset/?id=5755227686"
	};
	u1["Spectator Camera"] = {
		Description = "This camera allows you to spectate other people's battles.", 
		Type = "OverworldOnly", 
		InfiniteUses = true, 
		Category = "Key Items", 
		Color3 = Color3.fromRGB(255, 255, 255), 
		Image = "http://www.roblox.com/asset/?id=5786118191", 
		SpecialFunction = function(p466, p467)
			p467:Destroy();
			p466.SpectateBattle.new({});
		end
	};
	u1["Skin Trunk"] = {
		Description = "This leather briefcase lets you see all your un-equipped skins.", 
		Type = "OverworldOnly", 
		InfiniteUses = true, 
		Category = "Key Items", 
		Color3 = Color3.fromRGB(255, 255, 255), 
		Image = "http://www.roblox.com/asset/?id=8734085982", 
		SpecialFunction = function(p468, p469)
			p469.ItemUI.Visible = false;
			p468.SkinInventory.new({
				Bag = p469
			});
			p468.Talky.Visible = false;
		end
	};
	u1["Tally Counter"] = {
		Description = "Allows to see your current Doodle chain.", 
		Type = "OverworldOnly", 
		InfiniteUses = true, 
		Category = "Key Items", 
		Color3 = Color3.fromRGB(255, 255, 255), 
		Image = "http://www.roblox.com/asset/?id=6832985555", 
		SpecialFunction = function(p470, p471, p472)
			p470.Process = true;
			local v72, v73 = p470.ClientDatabase:PDSFunc("GetChain", false);
			local v74 = tonumber(string.format("%." .. 2 .. "f", (math.min(100, v73.Misprint * 100)))) .. "%";
			local v75 = tonumber(string.format("%." .. 2 .. "f", (math.min(100, v73.Skin * 100)))) .. "%";
			local v76 = tonumber(string.format("%." .. 2 .. "f", (math.min(100, v73.HT * 100)))) .. "%";
			if v73.Prestige then
				local v77 = "Yes";
			else
				v77 = "No";
			end;
			if v72.Name then
				if not p472 then
					p470.Gui:SayText("", v72.Name .. " chances at #" .. v72.Number .. ": Misprint chance: " .. v74 .. ". Skin chance: " .. v75 .. ". Hidden trait chance: " .. v76 .. ". Prestige unlocked: " .. v77 .. ".", nil, true);
				else
					p470.Gui:SayText("", v72.Name .. " chances at #" .. v72.Number .. ": Misprint chance: " .. v74 .. ". Skin chance: " .. v75 .. ". Hidden trait chance: " .. v76 .. ". Prestige unlocked: " .. v77 .. ". Chain to raise all these numbers!", nil, true);
				end;
			else
				p470.Gui:SayText("", "You are currently not chaining anything.", nil, true);
			end;
			p470.Talky.Visible = false;
			p470.Process = false;
		end
	};
	u1["Opal Orb"] = {
		Description = "An Opal Orb containing the soul of Craig. Also allows you to encounter Maelzuri in the Crystal Caverns.", 
		Type = "OverworldOnly", 
		InfiniteUses = true, 
		Category = "Key Items", 
		Color3 = Color3.fromRGB(236, 232, 234), 
		Image = "http://www.roblox.com/asset/?id=9423140689", 
		SpecialFunction = function(p473, p474)
			p473.Process = true;
			p473.Gui:SayText("", "There's a time and place for everything.", nil, true);
			p473.Talky.Visible = false;
			p473.Process = false;
		end
	};
	u1["Data Chip"] = {
		Description = "A data chip containing the blueprint of a mythical Doodle.", 
		Type = "OverworldOnly", 
		InfiniteUses = true, 
		Category = "Key Items", 
		Color3 = Color3.fromRGB(135, 214, 191), 
		Image = "http://www.roblox.com/asset/?id=9983897528", 
		SpecialFunction = function(p475, p476)
			p475.Process = true;
			p475.Gui:SayText("", "There's a time and place for everything.", nil, true);
			p475.Talky.Visible = false;
			p475.Process = false;
		end
	};
	u1["Choc Rocks"] = {
		Description = "A very addictive candy created by von Sweets.", 
		Type = "OverworldOnly", 
		InfiniteUses = true, 
		Category = "Key Items", 
		Color3 = Color3.fromRGB(224, 129, 142), 
		Image = "http://www.roblox.com/asset/?id=9989773017", 
		SpecialFunction = function(p477, p478)
			p477.Process = true;
			p477.Gui:SayText("", "Better not consume this...", nil, true);
			p477.Talky.Visible = false;
			p477.Process = false;
		end
	};
	u1.Memento = {
		Description = "A memento from the good old days.", 
		Type = "OverworldOnly", 
		InfiniteUses = true, 
		Category = "Key Items", 
		Color3 = Color3.fromRGB(255, 255, 255), 
		Image = "http://www.roblox.com/asset/?id=7297929502", 
		SpecialFunction = function(p479, p480)
			p479.Process = true;
			p479.Gui:SayText("", "There's a time and place for everything.", nil, true);
			p479.Talky.Visible = false;
			p479.Process = false;
		end
	};
	u1["Pristine Axe"] = {
		Description = "An axe used to chop down trees and wooden doors.", 
		Type = "OverworldOnly", 
		InfiniteUses = true, 
		Category = "Key Items", 
		Color3 = Color3.fromRGB(131, 160, 183), 
		Image = "http://www.roblox.com/asset/?id=9552475405", 
		SpecialFunction = function(p481, p482)
			p481.Process = true;
			p481.Gui:SayText("", "There's a time and place for everything.", nil, true);
			p481.Talky.Visible = false;
			p481.Process = false;
		end
	};
	u1["Money Trinket"] = {
		Description = "Allows you to get double money from tamer battles and help center requests.", 
		Type = "OverworldOnly", 
		InfiniteUses = true, 
		Category = "Key Items", 
		Color3 = Color3.fromRGB(255, 255, 255), 
		Image = "http://www.roblox.com/asset/?id=9145190706", 
		SpecialFunction = function(p483, p484)
			p483.Process = true;
			p483.Gui:SayText("", "There's a time and place for everything.", nil, true);
			p483.Talky.Visible = false;
			p483.Process = false;
		end
	};
	u1["Magnifying Glass"] = {
		Description = "Allows you to view wild Doodle's stats.", 
		InfiniteUses = true, 
		Category = "Key Items", 
		BattleOnly = true, 
		Color3 = Color3.fromRGB(255, 255, 255), 
		Image = "http://www.roblox.com/asset/?id=9137034166", 
		LocalFunction = function(p485, p486)
			local l__Battle__78 = p486.Battle;
			if not l__Battle__78 then
				p485.Process = true;
				p485.Gui:SayText("", "There's a time and place for everything.", nil, true);
				p485.Talky.Visible = false;
				p485.Process = false;
				return;
			end;
			if l__Battle__78.BattleType ~= "Wild" then
				p485.Gui:SayText("", "You can only use the Magnifying Glass against Wild Doodles!", nil, true);
				p485.Talky.Visible = false;
				p485.Process = false;
				return;
			end;
			p486:Hide();
			local v79 = l__Battle__78.BattleData.Out2[1];
			v79.OriginalOwner = "Unknown";
			local v80 = {
				NoTamer = true, 
				NoMoveSwap = true, 
				Battle = l__Battle__78.BattleData
			};
			function v80.CloseFunc()
				p485.guiholder.MainBattle.Visible = true;
			end;
			p485.Stats.new(v80, v79);
		end
	};
	u1["Hidden Trait Trinket"] = {
		Description = "You are more likely to meet Doodles who have their hidden trait.", 
		Type = "OverworldOnly", 
		InfiniteUses = true, 
		Category = "Key Items", 
		Color3 = Color3.fromRGB(255, 255, 255), 
		Image = "http://www.roblox.com/asset/?id=9205213322", 
		SpecialFunction = function(p487, p488)
			p487.Process = true;
			p487.Gui:SayText("", "There's a time and place for everything.", nil, true);
			p487.Talky.Visible = false;
			p487.Process = false;
		end
	};
	u1["Worn-Out Misprint Trinket"] = {
		Description = "You are more likely to meet misprinted Doodles. However, because it's worn out, the effect isn't as potent.", 
		Type = "OverworldOnly", 
		InfiniteUses = true, 
		Category = "Key Items", 
		Color3 = Color3.fromRGB(255, 255, 255), 
		Image = "http://www.roblox.com/asset/?id=9205804692", 
		SpecialFunction = function(p489, p490)
			p489.Process = true;
			p489.Gui:SayText("", "There's a time and place for everything.", nil, true);
			p489.Talky.Visible = false;
			p489.Process = false;
		end
	};
	u1["Misprint Trinket"] = {
		Description = "You are more likely to meet misprinted Doodles.", 
		Type = "OverworldOnly", 
		InfiniteUses = true, 
		Category = "Key Items", 
		Color3 = Color3.fromRGB(255, 255, 255), 
		Image = "http://www.roblox.com/asset/?id=8964981590", 
		SpecialFunction = function(p491, p492)
			p491.Process = true;
			p491.Gui:SayText("", "There's a time and place for everything.", nil, true);
			p491.Talky.Visible = false;
			p491.Process = false;
		end
	};
	u1["Worn-Out Mythical Trinket"] = {
		Description = "You are more likely to meet doodles of Legend. However, because it's worn out, the effect isn't as potent.", 
		Type = "OverworldOnly", 
		InfiniteUses = true, 
		Category = "Key Items", 
		Color3 = Color3.fromRGB(255, 255, 255), 
		Image = "http://www.roblox.com/asset/?id=9205534035", 
		SpecialFunction = function(p493, p494)
			p493.Process = true;
			p493.Gui:SayText("", "There's a time and place for everything.", nil, true);
			p493.Talky.Visible = false;
			p493.Process = false;
		end
	};
	u1["Mythical Trinket"] = {
		Description = "You are more likely to meet doodles of Legend.", 
		Type = "OverworldOnly", 
		InfiniteUses = true, 
		Category = "Key Items", 
		Color3 = Color3.fromRGB(255, 255, 255), 
		Image = "http://www.roblox.com/asset/?id=9205212570", 
		SpecialFunction = function(p495, p496)
			p495.Process = true;
			p495.Gui:SayText("", "There's a time and place for everything.", nil, true);
			p495.Talky.Visible = false;
			p495.Process = false;
		end
	};
	u1["Equipment Case"] = {
		Description = "A case that holds all your equipment.", 
		Type = "OverworldOnly", 
		InfiniteUses = true, 
		Category = "Key Items", 
		Color3 = Color3.fromRGB(255, 255, 255), 
		Image = "http://www.roblox.com/asset/?id=7657468277", 
		SpecialFunction = function(p497, p498)
			p498.ItemUI.Visible = false;
			p497.Equip.new({
				Bag = p498, 
				ForcePage = "Helmet"
			});
			p497.Talky.Visible = false;
		end
	};
	local v81 = {
		Description = "You can use this item for a free Roulette spin! However, the Doodle you get will be trade-locked.", 
		Type = "OverworldOnly", 
		Target = "Party", 
		Category = "Items", 
		Color3 = Color3.fromRGB(29, 124, 212), 
		Image = "http://www.roblox.com/asset/?id=9407500752"
	};
	local u4 = false;
	function v81.NonPartyFunc(p499, p500)
		if u4 then
			return;
		end;
		u4 = true;
		if not p499.ClientDatabase:PDSFunc("IsMaximum") then
			p499.Sound:Play("BasicClick", 0.8);
			p500:Destroy();
			p499.ClientDatabase:PDSFunc("RouletteSpin", true);
		else
			p499.Gui:TextAnnouncement("You have no space for any more Doodles.");
		end;
		u4 = nil;
	end;
	u1["Roulette Ticket"] = v81;
	u1["Greater Chain Ticket"] = {
		Description = "You can use this item to increase your current chain by 50! If it's a Mythical Doodle, it will only increase by 5. (Not tradable)", 
		Type = "OverworldOnly", 
		Target = "Party", 
		Category = "Items", 
		Price = 200, 
		RobuxOnly = true, 
		DevProduct = 1272071097, 
		Color3 = Color3.fromRGB(255, 213, 111), 
		Image = "http://www.roblox.com/asset/?id=9872855638", 
		NonPartyFunc = function(p501, p502)
			p501.Process = true;
			local v82, v83, v84 = p501.ClientDatabase:PDSFunc("ChainTicketString", "greater");
			if v83 then
				local v85 = p501.Dialogue:SaySimpleYesNo(v82);
				if v85 == "Yes" then
					p501.Network:BindEvent("AddChain", function(p503)
						p501.Network:UnbindEvent("AddChain");
						p502:Update(nil, p503);
					end);
					p501.Network:post("AddChain", "Greater Chain Ticket");
					p501.Gui:SayText("", v84, nil, true);
				elseif v85 == "No" then

				end;
			else
				p501.Gui:SayText("", "You don't have an active chain!", nil, true);
			end;
			p501.Talky.Visible = false;
			p501.Process = false;
		end
	};
	u1["Lesser Chain Ticket"] = {
		Description = "You can use this item to increase your current chain by 10! If it's a Mythical Doodle, it will only increase by 1. (Not tradable)", 
		Type = "OverworldOnly", 
		Target = "Party", 
		Category = "Items", 
		Price = 40, 
		RobuxOnly = true, 
		DevProduct = 1272071098, 
		Color3 = Color3.fromRGB(74, 63, 131), 
		Image = "http://www.roblox.com/asset/?id=9872854717", 
		NonPartyFunc = function(p504, p505)
			p504.Process = true;
			local v86, v87, v88 = p504.ClientDatabase:PDSFunc("ChainTicketString", "lesser");
			if v87 then
				local v89 = p504.Dialogue:SaySimpleYesNo(v86);
				if v89 == "Yes" then
					p504.Network:BindEvent("AddChain", function(p506)
						p504.Network:UnbindEvent("AddChain");
						p505:Update(nil, p506);
					end);
					p504.Network:post("AddChain", "Lesser Chain Ticket");
					p504.Gui:SayText("", v88, nil, true);
				elseif v89 == "No" then

				end;
			else
				p504.Gui:SayText("", "You don't have an active chain!", nil, true);
			end;
			p504.Talky.Visible = false;
			p504.Process = false;
		end
	};
	u1["Stat Candy"] = {
		Description = "This item lets you change the stat bonuses of a Doodle.", 
		Type = "OverworldOnly", 
		Target = "Party", 
		Category = "Items", 
		Price = 1000, 
		Color3 = Color3.fromRGB(255, 255, 255), 
		Image = "http://www.roblox.com/asset/?id=8734086723", 
		StatCandy = true
	};
	u1["Candy Bag"] = {
		Description = "A candy bag with treats selected by Bonbon. Opening this bag gives you a random taffy and candy cube!", 
		Type = "OverworldOnly", 
		Target = "Party", 
		Category = "Items", 
		Color3 = Color3.fromRGB(147, 119, 98), 
		Image = "http://www.roblox.com/asset/?id=9808177002", 
		NonPartyFunc = function(p507, p508)
			p507.Process = true;
			local u5 = nil;
			l__Utilities__1.FastSpawn(function()
				p507.Gui:SayText("", "Opening candy bag, please wait...", nil, true);
				u5 = true;
			end);
			local v90, v91, v92 = p507.ClientDatabase:PDSFunc("OpenCandyBag");
			while true do
				l__Utilities__1.Halt(0.05);
				if u5 then
					break;
				end;			
			end;
			if v90 then
				p508:Update(nil, v92, true);
				p507.Gui:SayText("", "You got 1 " .. v90 .. " and 1 " .. v91 .. " from the Candy Bag!", nil, true);
			else
				p507.Gui:SayText("", "Error.", nil, true);
			end;
			p507.Talky.Visible = false;
			p507.Process = false;
		end
	};
	u1["Hidden Trait Badge"] = {
		Description = "[DEV ITEM] Changes Doodle's Trait to Hidden Trait", 
		Type = "OverworldOnly", 
		Target = "Party", 
		Category = "Items", 
		Color3 = Color3.fromRGB(208, 208, 208), 
		Image = "http://www.roblox.com/asset/?id=7244408626", 
		Function = function(p509, p510, p511)
			local v93 = nil;
			if p510 then
				return false;
			end;
			local v94 = p509.Nickname or p509.Name;
			if game:GetService("RunService"):IsServer() then
				return p509:ChangeAbility("Hidden");
			end;
			local v95 = p1.DoodleInfo[p509.Name];
			v93 = v95.HiddenAbility;
			if p509.Ability == v95.HiddenAbility then
				return v94 .. " already has its hidden trait (" .. v93 .. ")!";
			end;
			return v94 .. "'s trait changed to " .. v93 .. "!", true;
		end
	};
	u1["Trait Badge"] = {
		Description = "This badge allows you to swap a Doodle's trait.", 
		Type = "OverworldOnly", 
		Target = "Party", 
		Category = "Items", 
		Color3 = Color3.fromRGB(208, 208, 208), 
		Image = "http://www.roblox.com/asset/?id=6833202115", 
		Function = function(p512, p513, p514)
			if p513 then
				return false;
			end;
			local v96 = p512.Nickname or p512.Name;
			if game:GetService("RunService"):IsServer() then
				return p512:ChangeAbility();
			end;
			local v97 = p1.DoodleInfo[p512.Name];
			local l__Abilities__98 = v97.Abilities;
			local v99 = l__Abilities__98[1];
			if #l__Abilities__98 == 1 and p512.Ability == v97.HiddenAbility then
				v99 = l__Abilities__98[1];
			else
				if #l__Abilities__98 == 1 then
					return v96 .. " only has 1 normal trait.";
				end;
				if p512.Ability == l__Abilities__98[1] then
					v99 = l__Abilities__98[2];
				end;
			end;
			return v96 .. " changed trait to " .. v99 .. "!", true;
		end
	};
	u1["Friendship Ribbon"] = {
		Description = "A doodle holding this item becomes friendlier faster.", 
		Type = "HeldItem", 
		Category = "Held Items", 
		Color3 = Color3.fromRGB(255, 255, 255), 
		Image = "http://www.roblox.com/asset/?id=6832984941", 
		FriendshipModifier = 2
	};
	u1.Scroll = {
		Description = "PLACEHOLDER TEXT - REPORT IF YOU CAN SEE THIS.", 
		Type = "OverworldOnly", 
		InfiniteUses = true, 
		Category = "Scrolls", 
		Color3 = Color3.fromRGB(255, 255, 255), 
		Image = "http://www.roblox.com/asset/?id=5806222018"
	};
	return u1;
end;
