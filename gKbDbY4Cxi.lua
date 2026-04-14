hookfunction(require(game.ReplicatedStorage.Effect.Container.Death), function()
end)
hookfunction(require(game.ReplicatedStorage:WaitForChild("GuideModule")).ChangeDisplayedNPC, function()
end)
hookfunction(error, function()
end)
hookfunction(warn, function()
end)
if game.PlaceId == 2753915549 then
	World1 = true
elseif game.PlaceId == 4442272183 then
	World2 = true
elseif game.PlaceId == 7449423635 then
	World3 = true
end
function CheckLevel()
	local MyLevel = game.Players.LocalPlayer.Data.Level.Value
	if World1 then
		if MyLevel >= 1 and MyLevel <= 9 then
			if tostring(game.Players.LocalPlayer.Team) == "Marines" then
				Mon = "Trainee"
				NameQuest = "MarineQuest"
				LevelQuest = 1
				NameMon = "Trainee"
				CFrameMon = CFrame.new(-2709.67944, 24.5206585, 2104.24585, -0.744724929, -3.97967455e-08, -0.667371571, 4.32403588e-08, 1, -1.07884304e-07, 0.667371571, -1.09201515e-07, -0.744724929)
				CFrameQuest = CFrame.new(-2709.67944, 24.5206585, 2104.24585, -0.744724929, -3.97967455e-08, -0.667371571, 4.32403588e-08, 1, -1.07884304e-07, 0.667371571, -1.09201515e-07, -0.744724929)
			elseif tostring(game.Players.LocalPlayer.Team) == "Pirates" then
				Mon = "Bandit"
				LevelQuest = 1
				NameQuest = "BanditQuest1"
				NameMon = "Bandit"
				CFrameMon = CFrame.new(1045.962646484375, 27.00250816345215, 1560.8203125)
				CFrameQuest = CFrame.new(1045.962646484375, 27.00250816345215, 1560.8203125)
			end
		elseif MyLevel >= 10 and MyLevel <= 14 then
			Mon = "Monkey"
			LevelQuest = 1
			NameQuest = "JungleQuest"
			NameMon = "Monkey"
			CFrameQuest = CFrame.new(-1598.08911, 35.5501175, 153.377838, 0, 0, 1, 0, 1, -0, -1, 0, 0)
			CFrameMon = CFrame.new(-1448.51806640625, 67.85301208496094, 11.46579647064209)
		elseif MyLevel >= 15 and MyLevel <= 29 then
			Mon = "Gorilla"
			LevelQuest = 2
			NameQuest = "JungleQuest"
			NameMon = "Gorilla"
			CFrameQuest = CFrame.new(-1598.08911, 35.5501175, 153.377838, 0, 0, 1, 0, 1, -0, -1, 0, 0)
			CFrameMon = CFrame.new(-1129.8836669921875, 40.46354675292969, -525.4237060546875)
		elseif MyLevel >= 30 and MyLevel <= 39 then
			Mon = "Pirate"
			LevelQuest = 1
			NameQuest = "BuggyQuest1"
			NameMon = "Pirate"
			CFrameQuest = CFrame.new(-1141.07483, 4.10001802, 3831.5498, 0.965929627, -0, -0.258804798, 0, 1, -0, 0.258804798, 0, 0.965929627)
			CFrameMon = CFrame.new(-1103.513427734375, 13.752052307128906, 3896.091064453125)
		elseif MyLevel >= 40 and MyLevel <= 59 then
			Mon = "Brute"
			LevelQuest = 2
			NameQuest = "BuggyQuest1"
			NameMon = "Brute"
			CFrameQuest = CFrame.new(-1141.07483, 4.10001802, 3831.5498, 0.965929627, -0, -0.258804798, 0, 1, -0, 0.258804798, 0, 0.965929627)
			CFrameMon = CFrame.new(-1140.083740234375, 14.809885025024414, 4322.92138671875)
		elseif MyLevel >= 60 and MyLevel <= 74 then
			Mon = "Desert Bandit"
			LevelQuest = 1
			NameQuest = "DesertQuest"
			NameMon = "Desert Bandit"
			CFrameQuest = CFrame.new(894.488647, 5.14000702, 4392.43359, 0.819155693, -0, -0.573571265, 0, 1, -0, 0.573571265, 0, 0.819155693)
			CFrameMon = CFrame.new(924.7998046875, 6.44867467880249, 4481.5859375)
		elseif MyLevel >= 75 and MyLevel <= 89 then
			Mon = "Desert Officer"
			LevelQuest = 2
			NameQuest = "DesertQuest"
			NameMon = "Desert Officer"
			CFrameQuest = CFrame.new(894.488647, 5.14000702, 4392.43359, 0.819155693, -0, -0.573571265, 0, 1, -0, 0.573571265, 0, 0.819155693)
			CFrameMon = CFrame.new(1608.2822265625, 8.614224433898926, 4371.00732421875)
		elseif MyLevel >= 90 and MyLevel <= 99 then
			Mon = "Snow Bandit"
			LevelQuest = 1
			NameQuest = "SnowQuest"
			NameMon = "Snow Bandit"
			CFrameQuest = CFrame.new(1389.74451, 88.1519318, -1298.90796, -0.342042685, 0, 0.939684391, 0, 1, 0, -0.939684391, 0, -0.342042685)
			CFrameMon = CFrame.new(1354.347900390625, 87.27277374267578, -1393.946533203125)
		elseif MyLevel >= 100 and MyLevel <= 119 then
			Mon = "Snowman"
			LevelQuest = 2
			NameQuest = "SnowQuest"
			NameMon = "Snowman"
			CFrameQuest = CFrame.new(1389.74451, 88.1519318, -1298.90796, -0.342042685, 0, 0.939684391, 0, 1, 0, -0.939684391, 0, -0.342042685)
			CFrameMon = CFrame.new(6241.9951171875, 51.522083282471, -1243.9771728516)
		elseif MyLevel >= 120 and MyLevel <= 149 then
			Mon = "Chief Petty Officer"
			LevelQuest = 1
			NameQuest = "MarineQuest2"
			NameMon = "Chief Petty Officer"
			CFrameQuest = CFrame.new(-5039.58643, 27.3500385, 4324.68018, 0, 0, -1, 0, 1, 0, 1, 0, 0)
			CFrameMon = CFrame.new(-4881.23095703125, 22.65204429626465, 4273.75244140625)
		elseif MyLevel >= 150 and MyLevel <= 174 then
			Mon = "Sky Bandit"
			LevelQuest = 1
			NameQuest = "SkyQuest"
			NameMon = "Sky Bandit"
			CFrameQuest = CFrame.new(-4839.53027, 716.368591, -2619.44165, 0.866007268, 0, 0.500031412, 0, 1, 0, -0.500031412, 0, 0.866007268)
			CFrameMon = CFrame.new(-4953.20703125, 295.74420166015625, -2899.22900390625)
		elseif MyLevel >= 175 and MyLevel <= 189 then
			Mon = "Dark Master"
			LevelQuest = 2
			NameQuest = "SkyQuest"
			NameMon = "Dark Master"
			CFrameQuest = CFrame.new(-4839.53027, 716.368591, -2619.44165, 0.866007268, 0, 0.500031412, 0, 1, 0, -0.500031412, 0, 0.866007268)
			CFrameMon = CFrame.new(-5259.8447265625, 391.3976745605469, -2229.035400390625)
		elseif MyLevel >= 190 and MyLevel <= 209 then
			Mon = "Prisoner"
			LevelQuest = 1
			NameQuest = "PrisonerQuest"
			NameMon = "Prisoner"
			CFrameQuest = CFrame.new(5308.93115, 1.65517521, 475.120514, -0.0894274712, -5.00292918e-09, -0.995993316, 1.60817859e-09, 1, -5.16744869e-09, 0.995993316, -2.06384709e-09, -0.0894274712)
			CFrameMon = CFrame.new(5098.9736328125, -0.3204058110713959, 474.2373352050781)
		elseif MyLevel >= 210 and MyLevel <= 249 then
			Mon = "Dangerous Prisoner"
			LevelQuest = 2
			NameQuest = "PrisonerQuest"
			NameMon = "Dangerous Prisoner"
			CFrameQuest = CFrame.new(5308.93115, 1.65517521, 475.120514, -0.0894274712, -5.00292918e-09, -0.995993316, 1.60817859e-09, 1, -5.16744869e-09, 0.995993316, -2.06384709e-09, -0.0894274712)
			CFrameMon = CFrame.new(5654.5634765625, 15.633401870727539, 866.2991943359375)
		elseif MyLevel >= 250 and MyLevel <= 274 then
			Mon = "Toga Warrior"
			LevelQuest = 1
			NameQuest = "ColosseumQuest"
			NameMon = "Toga Warrior"
			CFrameQuest = CFrame.new(-1580.04663, 6.35000277, -2986.47534, -0.515037298, 0, -0.857167721, 0, 1, 0, 0.857167721, 0, -0.515037298)
			CFrameMon = CFrame.new(-1820.21484375, 51.68385696411133, -2740.6650390625)
		elseif MyLevel >= 275 and MyLevel <= 299 then
			Mon = "Gladiator"
			LevelQuest = 2
			NameQuest = "ColosseumQuest"
			NameMon = "Gladiator"
			CFrameQuest = CFrame.new(-1580.04663, 6.35000277, -2986.47534, -0.515037298, 0, -0.857167721, 0, 1, 0, 0.857167721, 0, -0.515037298)
			CFrameMon = CFrame.new(-1292.838134765625, 56.380882263183594, -3339.031494140625)
		elseif MyLevel >= 300 and MyLevel <= 324 then
			Boubty = false
			Mon = "Military Soldier"
			LevelQuest = 1
			NameQuest = "MagmaQuest"
			NameMon = "Military Soldier"
			CFrameQuest = CFrame.new(-5313.37012, 10.9500084, 8515.29395, -0.499959469, 0, 0.866048813, 0, 1, 0, -0.866048813, 0, -0.499959469)
			CFrameMon = CFrame.new(-5411.16455078125, 11.081554412841797, 8454.29296875)
		elseif MyLevel >= 325 and MyLevel <= 374 then
			Mon = "Military Spy"
			LevelQuest = 2
			NameQuest = "MagmaQuest"
			NameMon = "Military Spy"
			CFrameQuest = CFrame.new(-5313.37012, 10.9500084, 8515.29395, -0.499959469, 0, 0.866048813, 0, 1, 0, -0.866048813, 0, -0.499959469)
			CFrameMon = CFrame.new(-5802.8681640625, 86.26241302490234, 8828.859375)
		elseif MyLevel >= 375 and MyLevel <= 399 then
			Mon = "Fishman Warrior"
			LevelQuest = 1
			NameQuest = "FishmanQuest"
			NameMon = "Fishman Warrior"
			CFrameQuest = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734)
			CFrameMon = CFrame.new(60878.30078125, 18.482830047607422, 1543.7574462890625)
			if _G.Level and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
			end
		elseif MyLevel >= 400 and MyLevel <= 449 then
			Mon = "Fishman Commando"
			LevelQuest = 2
			NameQuest = "FishmanQuest"
			NameMon = "Fishman Commando"
			CFrameQuest = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734)
			CFrameMon = CFrame.new(61922.6328125, 18.482830047607422, 1493.934326171875)
			if _G.Level and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
			end
		elseif MyLevel >= 450 and MyLevel <= 474 then
			Mon = "God's Guard"
			LevelQuest = 1
			NameQuest = "SkyExp1Quest"
			NameMon = "God's Guard"
			CFrameQuest = CFrame.new(-4721.88867, 843.874695, -1949.96643, 0.996191859, -0, -0.0871884301, 0, 1, -0, 0.0871884301, 0, 0.996191859)
			CFrameMon = CFrame.new(-4710.04296875, 845.2769775390625, -1927.3079833984375)
			if _G.Level and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-4607.82275, 872.54248, -1667.55688))
			end
		elseif MyLevel >= 475 and MyLevel <= 524 then
			Mon = "Shanda"
			LevelQuest = 2
			NameQuest = "SkyExp1Quest"
			NameMon = "Shanda"
			CFrameQuest = CFrame.new(-7859.09814, 5544.19043, -381.476196, -0.422592998, 0, 0.906319618, 0, 1, 0, -0.906319618, 0, -0.422592998)
			CFrameMon = CFrame.new(-7678.48974609375, 5566.40380859375, -497.2156066894531)
			if _G.Level and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-7894.6176757813, 5547.1416015625, -380.29119873047))
			end
		elseif MyLevel >= 525 and MyLevel <= 549 then
			Mon = "Royal Squad"
			LevelQuest = 1
			NameQuest = "SkyExp2Quest"
			NameMon = "Royal Squad"
			CFrameQuest = CFrame.new(-7906.81592, 5634.6626, -1411.99194, 0, 0, -1, 0, 1, 0, 1, 0, 0)
			CFrameMon = CFrame.new(-7624.25244140625, 5658.13330078125, -1467.354248046875)
		elseif MyLevel >= 550 and MyLevel <= 624 then
			Mon = "Royal Soldier"
			LevelQuest = 2
			NameQuest = "SkyExp2Quest"
			NameMon = "Royal Soldier"
			CFrameQuest = CFrame.new(-7906.81592, 5634.6626, -1411.99194, 0, 0, -1, 0, 1, 0, 1, 0, 0)
			CFrameMon = CFrame.new(-7836.75341796875, 5645.6640625, -1790.6236572265625)
		elseif MyLevel >= 625 and MyLevel <= 649 then
			Mon = "Galley Pirate"
			LevelQuest = 1
			NameQuest = "FountainQuest"
			NameMon = "Galley Pirate"
			CFrameQuest = CFrame.new(5259.81982, 37.3500175, 4050.0293, 0.087131381, 0, 0.996196866, 0, 1, 0, -0.996196866, 0, 0.087131381)
			CFrameMon = CFrame.new(5551.02197265625, 78.90135192871094, 3930.412841796875)
		elseif MyLevel >= 650 then
			Mon = "Galley Captain"
			LevelQuest = 2
			NameQuest = "FountainQuest"
			NameMon = "Galley Captain"
			CFrameQuest = CFrame.new(5259.81982, 37.3500175, 4050.0293, 0.087131381, 0, 0.996196866, 0, 1, 0, -0.996196866, 0, 0.087131381)
			CFrameMon = CFrame.new(5441.95166015625, 42.50205993652344, 4950.09375)
		end
	elseif World2 then
		if MyLevel >= 700 and MyLevel <= 724 then
			Mon = "Raider"
			LevelQuest = 1
			NameQuest = "Area1Quest"
			NameMon = "Raider"
			CFrameQuest = CFrame.new(-429.543518, 71.7699966, 1836.18188, -0.22495985, 0, -0.974368095, 0, 1, 0, 0.974368095, 0, -0.22495985)
			CFrameMon = CFrame.new(-728.3267211914062, 52.779319763183594, 2345.7705078125)
		elseif MyLevel >= 725 and MyLevel <= 774 then
			Mon = "Mercenary"
			LevelQuest = 2
			NameQuest = "Area1Quest"
			NameMon = "Mercenary"
			CFrameQuest = CFrame.new(-429.543518, 71.7699966, 1836.18188, -0.22495985, 0, -0.974368095, 0, 1, 0, 0.974368095, 0, -0.22495985)
			CFrameMon = CFrame.new(-1004.3244018554688, 80.15886688232422, 1424.619384765625)
		elseif MyLevel >= 775 and MyLevel <= 799 then
			Mon = "Swan Pirate"
			LevelQuest = 1
			NameQuest = "Area2Quest"
			NameMon = "Swan Pirate"
			CFrameQuest = CFrame.new(638.43811, 71.769989, 918.282898, 0.139203906, 0, 0.99026376, 0, 1, 0, -0.99026376, 0, 0.139203906)
			CFrameMon = CFrame.new(1068.664306640625, 137.61428833007812, 1322.1060791015625)
		elseif MyLevel >= 800 and MyLevel <= 874 then
			Mon = "Factory Staff"
			NameQuest = "Area2Quest"
			LevelQuest = 2
			NameMon = "Factory Staff"
			CFrameQuest = CFrame.new(632.698608, 73.1055908, 918.666321, -0.0319722369, 8.96074881e-10, -0.999488771, 1.36326533e-10, 1, 8.92172336e-10, 0.999488771, -1.07732087e-10, -0.0319722369)
			CFrameMon = CFrame.new(73.07867431640625, 81.86344146728516, -27.470672607421875)
		elseif MyLevel >= 875 and MyLevel <= 899 then
			Mon = "Marine Lieutenant"
			LevelQuest = 1
			NameQuest = "MarineQuest3"
			NameMon = "Marine Lieutenant"
			CFrameQuest = CFrame.new(-2440.79639, 71.7140732, -3216.06812, 0.866007268, 0, 0.500031412, 0, 1, 0, -0.500031412, 0, 0.866007268)
			CFrameMon = CFrame.new(-2821.372314453125, 75.89727783203125, -3070.089111328125)
		elseif MyLevel >= 900 and MyLevel <= 949 then
			Mon = "Marine Captain"
			LevelQuest = 2
			NameQuest = "MarineQuest3"
			NameMon = "Marine Captain"
			CFrameQuest = CFrame.new(-2440.79639, 71.7140732, -3216.06812, 0.866007268, 0, 0.500031412, 0, 1, 0, -0.500031412, 0, 0.866007268)
			CFrameMon = CFrame.new(-1861.2310791015625, 80.17658233642578, -3254.697509765625)
		elseif MyLevel >= 950 and MyLevel <= 974 then
			Mon = "Zombie"
			LevelQuest = 1
			NameQuest = "ZombieQuest"
			NameMon = "Zombie"
			CFrameQuest = CFrame.new(-5497.06152, 47.5923004, -795.237061, -0.29242146, 0, -0.95628953, 0, 1, 0, 0.95628953, 0, -0.29242146)
			CFrameMon = CFrame.new(-5657.77685546875, 78.96973419189453, -928.68701171875)
		elseif MyLevel >= 975 and MyLevel <= 999 then
			Mon = "Vampire"
			LevelQuest = 2
			NameQuest = "ZombieQuest"
			NameMon = "Vampire"
			CFrameQuest = CFrame.new(-5497.06152, 47.5923004, -795.237061, -0.29242146, 0, -0.95628953, 0, 1, 0, 0.95628953, 0, -0.29242146)
			CFrameMon = CFrame.new(-6037.66796875, 32.18463897705078, -1340.6597900390625)
		elseif MyLevel >= 1000 and MyLevel <= 1049 then
			Mon = "Snow Trooper"
			LevelQuest = 1
			NameQuest = "SnowMountainQuest"
			NameMon = "Snow Trooper"
			CFrameQuest = CFrame.new(609.858826, 400.119904, -5372.25928, -0.374604106, 0, 0.92718488, 0, 1, 0, -0.92718488, 0, -0.374604106)
			CFrameMon = CFrame.new(549.1473388671875, 427.3870544433594, -5563.69873046875)
		elseif MyLevel >= 1050 and MyLevel <= 1099 then
			Mon = "Winter Warrior"
			LevelQuest = 2
			NameQuest = "SnowMountainQuest"
			NameMon = "Winter Warrior"
			CFrameQuest = CFrame.new(609.858826, 400.119904, -5372.25928, -0.374604106, 0, 0.92718488, 0, 1, 0, -0.92718488, 0, -0.374604106)
			CFrameMon = CFrame.new(1142.7451171875, 475.6398010253906, -5199.41650390625)
		elseif MyLevel >= 1100 and MyLevel <= 1124 then
			Mon = "Lab Subordinate"
			LevelQuest = 1
			NameQuest = "IceSideQuest"
			NameMon = "Lab Subordinate"
			CFrameQuest = CFrame.new(-6064.06885, 15.2422857, -4902.97852, 0.453972578, -0, -0.891015649, 0, 1, -0, 0.891015649, 0, 0.453972578)
			CFrameMon = CFrame.new(-5707.4716796875, 15.951709747314453, -4513.39208984375)
		elseif MyLevel >= 1125 and MyLevel <= 1174 then
			Mon = "Horned Warrior"
			LevelQuest = 2
			NameQuest = "IceSideQuest"
			NameMon = "Horned Warrior"
			CFrameQuest = CFrame.new(-6064.06885, 15.2422857, -4902.97852, 0.453972578, -0, -0.891015649, 0, 1, -0, 0.891015649, 0, 0.453972578)
			CFrameMon = CFrame.new(-6341.36669921875, 15.951770782470703, -5723.162109375)
		elseif MyLevel >= 1175 and MyLevel <= 1199 then
			Mon = "Magma Ninja"
			LevelQuest = 1
			NameQuest = "FireSideQuest"
			NameMon = "Magma Ninja"
			CFrameQuest = CFrame.new(-5428.03174, 15.0622921, -5299.43457, -0.882952213, 0, 0.469463557, 0, 1, 0, -0.469463557, 0, -0.882952213)
			CFrameMon = CFrame.new(-5449.6728515625, 76.65874481201172, -5808.20068359375)
		elseif MyLevel >= 1200 and MyLevel <= 1249 then
			Mon = "Lava Pirate"
			LevelQuest = 2
			NameQuest = "FireSideQuest"
			NameMon = "Lava Pirate"
			CFrameQuest = CFrame.new(-5428.03174, 15.0622921, -5299.43457, -0.882952213, 0, 0.469463557, 0, 1, 0, -0.469463557, 0, -0.882952213)
			CFrameMon = CFrame.new(-5213.33154296875, 49.73788070678711, -4701.451171875)
		elseif MyLevel >= 1250 and MyLevel <= 1274 then
			Mon = "Ship Deckhand"
			LevelQuest = 1
			NameQuest = "ShipQuest1"
			NameMon = "Ship Deckhand"
			CFrameQuest = CFrame.new(1037.80127, 125.092171, 32911.6016)
			CFrameMon = CFrame.new(1212.0111083984375, 150.79205322265625, 33059.24609375)
			if _G.Level and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 500 then
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
			end
		elseif MyLevel >= 1275 and MyLevel <= 1299 then
			Mon = "Ship Engineer"
			LevelQuest = 2
			NameQuest = "ShipQuest1"
			NameMon = "Ship Engineer"
			CFrameQuest = CFrame.new(1037.80127, 125.092171, 32911.6016)
			CFrameMon = CFrame.new(919.4786376953125, 43.54401397705078, 32779.96875)
			if _G.Level and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 500 then
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
			end
		elseif MyLevel >= 1300 and MyLevel <= 1324 then
			Mon = "Ship Steward"
			LevelQuest = 1
			NameQuest = "ShipQuest2"
			NameMon = "Ship Steward"
			CFrameQuest = CFrame.new(968.80957, 125.092171, 33244.125)
			CFrameMon = CFrame.new(919.4385375976562, 129.55599975585938, 33436.03515625)
			if _G.Level and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 500 then
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
			end
		elseif MyLevel >= 1325 and MyLevel <= 1349 then
			Mon = "Ship Officer"
			LevelQuest = 2
			NameQuest = "ShipQuest2"
			NameMon = "Ship Officer"
			CFrameQuest = CFrame.new(968.80957, 125.092171, 33244.125)
			CFrameMon = CFrame.new(1036.0179443359375, 181.4390411376953, 33315.7265625)
			if _G.Level and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 500 then
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
			end
		elseif MyLevel >= 1350 and MyLevel <= 1374 then
			Mon = "Arctic Warrior"
			LevelQuest = 1
			NameQuest = "FrostQuest"
			NameMon = "Arctic Warrior"
			CFrameQuest = CFrame.new(5667.6582, 26.7997818, -6486.08984, -0.933587909, 0, -0.358349502, 0, 1, 0, 0.358349502, 0, -0.933587909)
			CFrameMon = CFrame.new(5966.24609375, 62.97002029418945, -6179.3828125)
		elseif MyLevel >= 1375 and MyLevel <= 1424 then
			Mon = "Snow Lurker"
			LevelQuest = 2
			NameQuest = "FrostQuest"
			NameMon = "Snow Lurker"
			CFrameQuest = CFrame.new(5667.6582, 26.7997818, -6486.08984, -0.933587909, 0, -0.358349502, 0, 1, 0, 0.358349502, 0, -0.933587909)
			CFrameMon = CFrame.new(5407.07373046875, 69.19437408447266, -6880.88037109375)
		elseif MyLevel >= 1425 and MyLevel <= 1449 then
			Mon = "Sea Soldier"
			LevelQuest = 1
			NameQuest = "ForgottenQuest"
			NameMon = "Sea Soldier"
			CFrameQuest = CFrame.new(-3054.44458, 235.544281, -10142.8193, 0.990270376, -0, -0.13915664, 0, 1, -0, 0.13915664, 0, 0.990270376)
			CFrameMon = CFrame.new(-3028.2236328125, 64.67451477050781, -9775.4267578125)
		elseif MyLevel >= 1450 then
			Mon = "Water Fighter"
			LevelQuest = 2
			NameQuest = "ForgottenQuest"
			NameMon = "Water Fighter"
			CFrameQuest = CFrame.new(-3054.44458, 235.544281, -10142.8193, 0.990270376, -0, -0.13915664, 0, 1, -0, 0.13915664, 0, 0.990270376)
			CFrameMon = CFrame.new(-3352.9013671875, 285.01556396484375, -10534.841796875)
		end
	elseif World3 then
		if MyLevel >= 1500 and MyLevel <= 1524 then
			Mon = "Pirate Millionaire"
			LevelQuest = 1
			NameQuest = "PiratePortQuest"
			NameMon = "Pirate Millionaire"
			CFrameQuest = CFrame.new(-712.8272705078125, 98.5770492553711, 5711.9541015625)
			CFrameMon = CFrame.new(-712.8272705078125, 98.5770492553711, 5711.9541015625)
		elseif MyLevel >= 1525 and MyLevel <= 1574 then
			Mon = "Pistol Billionaire"
			LevelQuest = 2
			NameQuest = "PiratePortQuest"
			NameMon = "Pistol Billionaire"
			CFrameQuest = CFrame.new(-723.4331665039062, 147.42906188964844, 5931.9931640625)
			CFrameMon = CFrame.new(-723.4331665039062, 147.42906188964844, 5931.9931640625)
		elseif MyLevel >= 1575 and MyLevel <= 1599 then
			Mon = "Dragon Crew Warrior"
			LevelQuest = 1
			NameQuest = "AmazonQuest"
			NameMon = "Dragon Crew Warrior"
			CFrameQuest = CFrame.new(6779.03271484375, 111.16865539550781, -801.2130737304688)
			CFrameMon = CFrame.new(6779.03271484375, 111.16865539550781, -801.2130737304688)
		elseif MyLevel >= 1600 and MyLevel <= 1624 then
			Mon = "Dragon Crew Archer"
			NameQuest = "AmazonQuest"
			LevelQuest = 2
			NameMon = "Dragon Crew Archer"
			CFrameQuest = CFrame.new(6955.8974609375, 546.6658935546875, 309.0401306152344)
			CFrameMon = CFrame.new(6955.8974609375, 546.6658935546875, 309.0401306152344)
		elseif MyLevel >= 1625 and MyLevel <= 1649 then
			Mon = "Hydra Enforcer"
			NameQuest = "VenomCrewQuest"
			LevelQuest = 1
			NameMon = "Hydra Enforcer"
			CFrameQuest = CFrame.new(4620.61572265625, 1002.2954711914062, 399.0868835449219)
			CFrameMon = CFrame.new(4620.61572265625, 1002.2954711914062, 399.0868835449219)
		elseif MyLevel >= 1650 and MyLevel <= 1699 then
			Mon = "Venomous Assailant"
			NameQuest = "VenomCrewQuest"
			LevelQuest = 2
			NameMon = "Venomous Assailant"
			CFrameQuest = CFrame.new(4697.5918, 1100.65137, 946.401978, 0.579397917, -4.19689783e-10, 0.81504482, -1.49287818e-10, 1, 6.21053986e-10, -0.81504482, -4.81513662e-10, 0.579397917)
			CFrameMon = CFrame.new(4697.5918, 1100.65137, 946.401978, 0.579397917, -4.19689783e-10, 0.81504482, -1.49287818e-10, 1, 6.21053986e-10, -0.81504482, -4.81513662e-10, 0.579397917)
		elseif MyLevel >= 1700 and MyLevel <= 1724 then
			Mon = "Marine Commodore"
			LevelQuest = 1
			NameQuest = "MarineTreeIsland"
			NameMon = "Marine Commodore"
			CFrameQuest = CFrame.new(2180.54126, 27.8156815, -6741.5498, -0.965929747, 0, 0.258804798, 0, 1, 0, -0.258804798, 0, -0.965929747)
			CFrameMon = CFrame.new(2286.0078125, 73.13391876220703, -7159.80908203125)
		elseif MyLevel >= 1725 and MyLevel <= 1774 then
			Mon = "Marine Rear Admiral"
			NameMon = "Marine Rear Admiral"
			NameQuest = "MarineTreeIsland"
			LevelQuest = 2
			CFrameQuest = CFrame.new(2179.98828125, 28.731239318848, -6740.0551757813)
			CFrameMon = CFrame.new(3656.773681640625, 160.52406311035156, -7001.5986328125)
		elseif MyLevel >= 1775 and MyLevel <= 1799 then
			Mon = "Fishman Raider"
			LevelQuest = 1
			NameQuest = "DeepForestIsland3"
			NameMon = "Fishman Raider"
			CFrameQuest = CFrame.new(-10581.6563, 330.872955, -8761.18652, -0.882952213, 0, 0.469463557, 0, 1, 0, -0.469463557, 0, -0.882952213)
			CFrameMon = CFrame.new(-10407.5263671875, 331.76263427734375, -8368.5166015625)
		elseif MyLevel >= 1800 and MyLevel <= 1824 then
			Mon = "Fishman Captain"
			LevelQuest = 2
			NameQuest = "DeepForestIsland3"
			NameMon = "Fishman Captain"
			CFrameQuest = CFrame.new(-10581.6563, 330.872955, -8761.18652, -0.882952213, 0, 0.469463557, 0, 1, 0, -0.469463557, 0, -0.882952213)
			CFrameMon = CFrame.new(-10994.701171875, 352.38140869140625, -9002.1103515625)
		elseif MyLevel >= 1825 and MyLevel <= 1849 then
			Mon = "Forest Pirate"
			LevelQuest = 1
			NameQuest = "DeepForestIsland"
			NameMon = "Forest Pirate"
			CFrameQuest = CFrame.new(-13234.04, 331.488495, -7625.40137, 0.707134247, -0, -0.707079291, 0, 1, -0, 0.707079291, 0, 0.707134247)
			CFrameMon = CFrame.new(-13274.478515625, 332.3781433105469, -7769.58056640625)
		elseif MyLevel >= 1850 and MyLevel <= 1899 then
			Mon = "Mythological Pirate"
			LevelQuest = 2
			NameQuest = "DeepForestIsland"
			NameMon = "Mythological Pirate"
			CFrameQuest = CFrame.new(-13234.04, 331.488495, -7625.40137, 0.707134247, -0, -0.707079291, 0, 1, -0, 0.707079291, 0, 0.707134247)
			CFrameMon = CFrame.new(-13680.607421875, 501.08154296875, -6991.189453125)
		elseif MyLevel >= 1900 and MyLevel <= 1924 then
			Mon = "Jungle Pirate"
			LevelQuest = 1
			NameQuest = "DeepForestIsland2"
			NameMon = "Jungle Pirate"
			CFrameQuest = CFrame.new(-12680.3818, 389.971039, -9902.01953, -0.0871315002, 0, 0.996196866, 0, 1, 0, -0.996196866, 0, -0.0871315002)
			CFrameMon = CFrame.new(-12256.16015625, 331.73828125, -10485.8369140625)
		elseif MyLevel >= 1925 and MyLevel <= 1974 then
			Mon = "Musketeer Pirate"
			LevelQuest = 2
			NameQuest = "DeepForestIsland2"
			NameMon = "Musketeer Pirate"
			CFrameQuest = CFrame.new(-12680.3818, 389.971039, -9902.01953, -0.0871315002, 0, 0.996196866, 0, 1, 0, -0.996196866, 0, -0.0871315002)
			CFrameMon = CFrame.new(-13457.904296875, 391.545654296875, -9859.177734375)
		elseif MyLevel >= 1975 and MyLevel <= 1999 then
			Mon = "Reborn Skeleton"
			LevelQuest = 1
			NameQuest = "HauntedQuest1"
			NameMon = "Reborn Skeleton"
			CFrameQuest = CFrame.new(-9479.2168, 141.215088, 5566.09277, 0, 0, 1, 0, 1, -0, -1, 0, 0)
			CFrameMon = CFrame.new(-8763.7236328125, 165.72299194335938, 6159.86181640625)
		elseif MyLevel >= 2000 and MyLevel <= 2024 then
			Mon = "Living Zombie"
			LevelQuest = 2
			NameQuest = "HauntedQuest1"
			NameMon = "Living Zombie"
			CFrameQuest = CFrame.new(-9479.2168, 141.215088, 5566.09277, 0, 0, 1, 0, 1, -0, -1, 0, 0)
			CFrameMon = CFrame.new(-10144.1318359375, 138.62667846679688, 5838.0888671875)
		elseif MyLevel >= 2025 and MyLevel <= 2049 then
			Mon = "Demonic Soul"
			LevelQuest = 1
			NameQuest = "HauntedQuest2"
			NameMon = "Demonic Soul"
			CFrameQuest = CFrame.new(-9516.99316, 172.017181, 6078.46533, 0, 0, -1, 0, 1, 0, 1, 0, 0)
			CFrameMon = CFrame.new(-9505.8720703125, 172.10482788085938, 6158.9931640625)
		elseif MyLevel >= 2050 and MyLevel <= 2074 then
			Mon = "Posessed Mummy"
			LevelQuest = 2
			NameQuest = "HauntedQuest2"
			NameMon = "Posessed Mummy"
			CFrameQuest = CFrame.new(-9516.99316, 172.017181, 6078.46533, 0, 0, -1, 0, 1, 0, 1, 0, 0)
			CFrameMon = CFrame.new(-9582.0224609375, 6.251527309417725, 6205.478515625)
		elseif MyLevel >= 2075 and MyLevel <= 2099 then
			Mon = "Peanut Scout"
			LevelQuest = 1
			NameQuest = "NutsIslandQuest"
			NameMon = "Peanut Scout"
			CFrameQuest = CFrame.new(-2104.3908691406, 38.104167938232, -10194.21875, 0, 0, -1, 0, 1, 0, 1, 0, 0)
			CFrameMon = CFrame.new(-2143.241943359375, 47.72198486328125, -10029.9951171875)
		elseif MyLevel >= 2100 and MyLevel <= 2124 then
			Mon = "Peanut President"
			LevelQuest = 2
			NameQuest = "NutsIslandQuest"
			NameMon = "Peanut President"
			CFrameQuest = CFrame.new(-2104.3908691406, 38.104167938232, -10194.21875, 0, 0, -1, 0, 1, 0, 1, 0, 0)
			CFrameMon = CFrame.new(-1859.35400390625, 38.10316848754883, -10422.4296875)
		elseif MyLevel >= 2125 and MyLevel <= 2149 then
			Mon = "Ice Cream Chef"
			LevelQuest = 1
			NameQuest = "IceCreamIslandQuest"
			NameMon = "Ice Cream Chef"
			CFrameQuest = CFrame.new(-820.64825439453, 65.819526672363, -10965.795898438, 0, 0, -1, 0, 1, 0, 1, 0, 0)
			CFrameMon = CFrame.new(-872.24658203125, 65.81957244873047, -10919.95703125)
		elseif MyLevel >= 2150 and MyLevel <= 2199 then
			Mon = "Ice Cream Commander"
			LevelQuest = 2
			NameQuest = "IceCreamIslandQuest"
			NameMon = "Ice Cream Commander"
			CFrameQuest = CFrame.new(-820.64825439453, 65.819526672363, -10965.795898438, 0, 0, -1, 0, 1, 0, 1, 0, 0)
			CFrameMon = CFrame.new(-558.06103515625, 112.04895782470703, -11290.7744140625)
		elseif MyLevel >= 2200 and MyLevel <= 2224 then
			Mon = "Cookie Crafter"
			LevelQuest = 1
			NameQuest = "CakeQuest1"
			NameMon = "Cookie Crafter"
			CFrameQuest = CFrame.new(-2021.32007, 37.7982254, -12028.7295, 0.957576931, -8.80302053e-08, 0.288177818, 6.9301187e-08, 1, 7.51931211e-08, -0.288177818, -5.2032135e-08, 0.957576931)
			CFrameMon = CFrame.new(-2374.13671875, 37.79826354980469, -12125.30859375)
		elseif MyLevel >= 2225 and MyLevel <= 2249 then
			Mon = "Cake Guard"
			LevelQuest = 2
			NameQuest = "CakeQuest1"
			NameMon = "Cake Guard"
			CFrameQuest = CFrame.new(-2021.32007, 37.7982254, -12028.7295, 0.957576931, -8.80302053e-08, 0.288177818, 6.9301187e-08, 1, 7.51931211e-08, -0.288177818, -5.2032135e-08, 0.957576931)
			CFrameMon = CFrame.new(-1598.3070068359375, 43.773197174072266, -12244.5810546875)
		elseif MyLevel >= 2250 and MyLevel <= 2274 then
			Mon = "Baking Staff"
			LevelQuest = 1
			NameQuest = "CakeQuest2"
			NameMon = "Baking Staff"
			CFrameQuest = CFrame.new(-1927.91602, 37.7981339, -12842.5391, -0.96804446, 4.22142143e-08, 0.250778586, 4.74911062e-08, 1, 1.49904711e-08, -0.250778586, 2.64211941e-08, -0.96804446)
			CFrameMon = CFrame.new(-1887.8099365234375, 77.6185073852539, -12998.3505859375)
		elseif MyLevel >= 2275 and MyLevel <= 2299 then
			Mon = "Head Baker"
			LevelQuest = 2
			NameQuest = "CakeQuest2"
			NameMon = "Head Baker"
			CFrameQuest = CFrame.new(-1927.91602, 37.7981339, -12842.5391, -0.96804446, 4.22142143e-08, 0.250778586, 4.74911062e-08, 1, 1.49904711e-08, -0.250778586, 2.64211941e-08, -0.96804446)
			CFrameMon = CFrame.new(-2216.188232421875, 82.884521484375, -12869.2939453125)
		elseif MyLevel >= 2300 and MyLevel <= 2324 then
			Mon = "Cocoa Warrior"
			LevelQuest = 1
			NameQuest = "ChocQuest1"
			NameMon = "Cocoa Warrior"
			CFrameQuest = CFrame.new(233.22836303710938, 29.876001358032227, -12201.2333984375)
			CFrameMon = CFrame.new(-21.55328369140625, 80.57499694824219, -12352.3876953125)
		elseif MyLevel >= 2325 and MyLevel <= 2349 then
			Mon = "Chocolate Bar Battler"
			LevelQuest = 2
			NameQuest = "ChocQuest1"
			NameMon = "Chocolate Bar Battler"
			CFrameQuest = CFrame.new(233.22836303710938, 29.876001358032227, -12201.2333984375)
			CFrameMon = CFrame.new(582.590576171875, 77.18809509277344, -12463.162109375)
		elseif MyLevel >= 2350 and MyLevel <= 2374 then
			Mon = "Sweet Thief"
			LevelQuest = 1
			NameQuest = "ChocQuest2"
			NameMon = "Sweet Thief"
			CFrameQuest = CFrame.new(150.5066375732422, 30.693693161010742, -12774.5029296875)
			CFrameMon = CFrame.new(165.1884765625, 76.05885314941406, -12600.8369140625)
		elseif MyLevel >= 2375 and MyLevel <= 2399 then
			Mon = "Candy Rebel"
			LevelQuest = 2
			NameQuest = "ChocQuest2"
			NameMon = "Candy Rebel"
			CFrameQuest = CFrame.new(150.5066375732422, 30.693693161010742, -12774.5029296875)
			CFrameMon = CFrame.new(134.86563110351562, 77.2476806640625, -12876.5478515625)
		elseif MyLevel >= 2400 and MyLevel <= 2449 then
			Mon = "Candy Pirate"
			LevelQuest = 1
			NameQuest = "CandyQuest1"
			NameMon = "Candy Pirate"
			CFrameQuest = CFrame.new(-1150.0400390625, 20.378934860229492, -14446.3349609375)
			CFrameMon = CFrame.new(-1310.5003662109375, 26.016523361206055, -14562.404296875)
		elseif MyLevel >= 2450 and MyLevel <= 2474 then
			Mon = "Isle Outlaw"
			LevelQuest = 1
			NameQuest = "TikiQuest1"
			NameMon = "Isle Outlaw"
			CFrameQuest = CFrame.new(-16548.8164, 55.6059914, -172.8125, 0.213092566, -0, -0.977032006, 0, 1, -0, 0.977032006, 0, 0.213092566)
			CFrameMon = CFrame.new(-16479.900390625, 226.6117401123047, -300.3114318847656)
		elseif MyLevel >= 2475 and MyLevel <= 2499 then
			Mon = "Island Boy"
			LevelQuest = 2
			NameQuest = "TikiQuest1"
			NameMon = "Island Boy"
			CFrameQuest = CFrame.new(-16548.8164, 55.6059914, -172.8125, 0.213092566, -0, -0.977032006, 0, 1, -0, 0.977032006, 0, 0.213092566)
			CFrameMon = CFrame.new(-16849.396484375, 192.86505126953125, -150.7853240966797)
		elseif MyLevel >= 2500 and MyLevel <= 2524 then
			Mon = "Sun-kissed Warrior"
			LevelQuest = 1
			NameQuest = "TikiQuest2"
			NameMon = "kissed Warrior"
			CFrameMon = CFrame.new(-16347, 64, 984)
			CFrameQuest = CFrame.new(-16538, 55, 1049)
		elseif MyLevel >= 2525 and MyLevel <= 2549 then
			Mon = "Isle Champion"
			LevelQuest = 2
			NameQuest = "TikiQuest2"
			NameMon = "Isle Champion"
			CFrameQuest = CFrame.new(-16541.0215, 57.3082275, 1051.46118, 0.0410757065, -0, -0.999156058, 0, 1, -0, 0.999156058, 0, 0.0410757065)
			CFrameMon = CFrame.new(-16602.1015625, 130.38734436035156, 1087.24560546875)
		elseif MyLevel >= 2550 and MyLevel <= 2574 then
			Mon = "Serpent Hunter"
			LevelQuest = 1
			NameQuest = "TikiQuest3"
			NameMon = "Serpent Hunter"
			CFrameQuest = CFrame.new(-16679.478515625, 176.74737548828125, 1474.3995361328125)
			CFrameMon = CFrame.new(-16679.478515625, 176.74737548828125, 1474.3995361328125)
		elseif MyLevel >= 2575 and MyLevel <= 2599 then
			Mon = "Skull Slayer"
			LevelQuest = 2
			NameQuest = "TikiQuest3"
			NameMon = "Skull Slayer"
			CFrameQuest = CFrame.new(-16759.58984375, 71.28376770019531, 1595.3399658203125)
			CFrameMon = CFrame.new(-16759.58984375, 71.28376770019531, 1595.3399658203125)
		elseif MyLevel >= 2600 and MyLevel <= 2624 then
			Mon = "Reef Bandit"
			LevelQuest = 1
			NameQuest = "SubmergedQuest1"
			NameMon = "Reef Bandit"
			CFrameQuest = CFrame.new(10882.264, -2086.322, 10034.226)
			CFrameMon = CFrame.new(10736.6191, -2087.8439, 9338.4882)
			if _G.Level and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 1000 then
				Tween(CFrame.new(-16269.7041, 25.2288494, 1373.65955))
				wait(2)
				game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RF/SubmarineWorkerSpeak"):InvokeServer("TravelToSubmergedIsland")
			end
		elseif MyLevel >= 2625 and MyLevel <= 2649 then
			Mon = "Coral Pirate"
			LevelQuest = 2
			NameQuest = "SubmergedQuest1"
			NameMon = "Coral Pirate"
			CFrameQuest = CFrame.new(10882.264, -2086.322, 10034.226)
			CFrameMon = CFrame.new(10965.1025, -2158.8842, 9177.2597)
			if _G.Level and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 1000 then
				Tween(CFrame.new(-16269.7041, 25.2288494, 1373.65955))
				wait(2)
				game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RF/SubmarineWorkerSpeak"):InvokeServer("TravelToSubmergedIsland")
			end
		elseif MyLevel >= 2650 and MyLevel <= 2674 then
			Mon = "Sea Chanter"
			LevelQuest = 1
			NameQuest = "SubmergedQuest1"
			NameMon = "Sea Chanter"
			CFrameQuest = CFrame.new(10882.264, -2086.322, 10034.226)
			CFrameMon = CFrame.new(10621.0342, -2087.8440, 10102.0332)
			if _G.Level and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 1000 then
				Tween(CFrame.new(-16269.7041, 25.2288494, 1373.65955))
				wait(2)
				game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RF/SubmarineWorkerSpeak"):InvokeServer("TravelToSubmergedIsland")
			end
		elseif MyLevel >= 2675 and MyLevel <= 2699 then
			Mon = "Ocean Prophet"
			LevelQuest = 2
			NameQuest = "SubmergedQuest2"
			NameMon = "Ocean Prophet"
			CFrameQuest = CFrame.new(10612.3848, -2087.844, 10053.8926)
			CFrameMon = CFrame.new(11056.1445, -2001.6717, 10117.4493)
			if _G.Level and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 1000 then
				Tween(CFrame.new(-16269.7041, 25.2288494, 1373.65955))
				wait(2)
				game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RF/SubmarineWorkerSpeak"):InvokeServer("TravelToSubmergedIsland")
			end
		elseif MyLevel >= 2700 and MyLevel <= 2724 then
			Mon = "High Disciple"
			LevelQuest = 1
			NameQuest = "SubmergedQuest3"
			NameMon = "High Disciple"
			CFrameQuest = CFrame.new(9640.08789, -1992.44507, 9613.65234)
			CFrameMon = CFrame.new(9750.41602, -1966.93884, 9753.36035)
			if _G.Level and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 1000 then
				Tween(CFrame.new(-16269.7041, 25.2288494, 1373.65955))
				wait(2)
				game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RF/SubmarineWorkerSpeak"):InvokeServer("TravelToSubmergedIsland")
			end
		elseif MyLevel >= 2725 then
			Mon = "Grand Devotee"
			LevelQuest = 2
			NameQuest = "SubmergedQuest3"
			NameMon = "Grand Devotee"
			CFrameQuest = CFrame.new(9640.08789, -1992.44507, 9613.65234)
			CFrameMon = CFrame.new(9611.70508, -1993.47119, 9882.68848)
			if _G.Level and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 1000 then
				Tween(CFrame.new(-16269.7041, 25.2288494, 1373.65955))
				wait(2)
				game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RF/SubmarineWorkerSpeak"):InvokeServer("TravelToSubmergedIsland")
			end
		end
	end
end
function CheckBoss()
	if World1 then
		if _G.SelectBoss == "The Gorilla King" then
			Boss = "The Gorilla King"
			NameQuest = "JungleQuest"
			LevelQuest = 3
			CFrameQuest = CFrame.new(-1601.6553955078, 36.85213470459, 153.38809204102)
			CFrameBoss = CFrame.new(-1088.75977, 8.13463783, -488.559906, -0.707134247, 0, 0.707079291, 0, 1, 0, -0.707079291, 0, -0.707134247)
		elseif _G.SelectBoss == "Bobby" then
			Boss = "Bobby"
			NameQuest = "BuggyQuest1"
			LevelQuest = 3
			CFrameQuest = CFrame.new(-1140.1761474609, 4.752049446106, 3827.4057617188)
			CFrameBoss = CFrame.new(-1087.3760986328, 46.949409484863, 4040.1462402344)
		elseif _G.SelectBoss == "The Saw" then
			Boss = "The Saw"
			CFrameBoss = CFrame.new(-784.89715576172, 72.427383422852, 1603.5822753906)
		elseif _G.SelectBoss == "Yeti" then
			Boss = "Yeti"
			NameQuest = "SnowQuest"
			LevelQuest = 3
			CFrameQuest = CFrame.new(1386.8073730469, 87.272789001465, -1298.3576660156)
			CFrameBoss = CFrame.new(1218.7956542969, 138.01184082031, -1488.0262451172)
		elseif _G.SelectBoss == "Mob Leader" then
			Boss = "Mob Leader"
			CFrameBoss = CFrame.new(-2844.7307128906, 7.4180502891541, 5356.6723632813)
		elseif _G.SelectBoss == "Vice Admiral" then
			Boss = "Vice Admiral"
			NameQuest = "MarineQuest2"
			LevelQuest = 2
			CFrameQuest = CFrame.new(-5036.2465820313, 28.677835464478, 4324.56640625)
			CFrameBoss = CFrame.new(-5006.5454101563, 88.032081604004, 4353.162109375)
		elseif _G.SelectBoss == "Saber Expert" then
			Boss = "Saber Expert"
			CFrameBoss = CFrame.new(-1458.89502, 29.8870335, -50.633564)
		elseif _G.SelectBoss == "Warden" then
			Boss = "Warden"
			NameQuest = "ImpelQuest"
			LevelQuest = 1
			CFrameBoss = CFrame.new(5278.04932, 2.15167475, 944.101929, 0.220546961, -4.49946401e-06, 0.975376427, -1.95412576e-05, 1, 9.03162072e-06, -0.975376427, -2.10519756e-05, 0.220546961)
			CFrameQuest = CFrame.new(5191.86133, 2.84020686, 686.438721, -0.731384635, 0, 0.681965172, 0, 1, 0, -0.681965172, 0, -0.731384635)
		elseif _G.SelectBoss == "Chief Warden" then
			Boss = "Chief Warden"
			NameQuest = "ImpelQuest"
			LevelQuest = 2
			CFrameBoss = CFrame.new(5206.92578, 0.997753382, 814.976746, 0.342041343, -0.00062915677, 0.939684749, 0.00191645394, 0.999998152, -2.80422337e-05, -0.939682961, 0.00181045406, 0.342041939)
			CFrameQuest = CFrame.new(5191.86133, 2.84020686, 686.438721, -0.731384635, 0, 0.681965172, 0, 1, 0, -0.681965172, 0, -0.731384635)
		elseif _G.SelectBoss == "Swan" then
			Boss = "Swan"
			NameQuest = "ImpelQuest"
			LevelQuest = 3
			CFrameBoss = CFrame.new(5325.09619, 7.03906584, 719.570679, -0.309060812, 0, 0.951042235, 0, 1, 0, -0.951042235, 0, -0.309060812)
			CFrameQuest = CFrame.new(5191.86133, 2.84020686, 686.438721, -0.731384635, 0, 0.681965172, 0, 1, 0, -0.681965172, 0, -0.731384635)
		elseif _G.SelectBoss == "Magma Admiral" then
			Boss = "Magma Admiral"
			NameQuest = "MagmaQuest"
			LevelQuest = 3
			CFrameQuest = CFrame.new(-5314.6220703125, 12.262420654297, 8517.279296875)
			CFrameBoss = CFrame.new(-5765.8969726563, 82.92064666748, 8718.3046875)
		elseif _G.SelectBoss == "Fishman Lord" then
			Boss = "Fishman Lord"
			NameQuest = "FishmanQuest"
			LevelQuest = 3
			CFrameQuest = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734)
			CFrameBoss = CFrame.new(61260.15234375, 30.950881958008, 1193.4329833984)
		elseif _G.SelectBoss == "Wysper" then
			Boss = "Wysper"
			NameQuest = "SkyExp1Quest"
			LevelQuest = 3
			CFrameQuest = CFrame.new(-7861.947265625, 5545.517578125, -379.85974121094)
			CFrameBoss = CFrame.new(-7866.1333007813, 5576.4311523438, -546.74816894531)
		elseif _G.SelectBoss == "Thunder God" then
			Boss = "Thunder God"
			NameQuest = "SkyExp2Quest"
			LevelQuest = 3
			CFrameQuest = CFrame.new(-7903.3828125, 5635.9897460938, -1410.923828125)
			CFrameBoss = CFrame.new(-7994.984375, 5761.025390625, -2088.6479492188)
		elseif _G.SelectBoss == "Cyborg" then
			Boss = "Cyborg"
			NameQuest = "FountainQuest"
			LevelQuest = 3
			CFrameQuest = CFrame.new(5258.2788085938, 38.526931762695, 4050.044921875)
			CFrameBoss = CFrame.new(6094.0249023438, 73.770050048828, 3825.7348632813)
		elseif _G.SelectBoss == "Ice Admiral" then
			Boss = "Ice Admiral"
			LevelQuest = nil
			CFrameQuest = CFrame.new(1266.08948, 26.1757946, -1399.57678, -0.573599219, 0, -0.81913656, 0, 1, 0, 0.81913656, 0, -0.573599219)
			CFrameBoss = CFrame.new(1266.08948, 26.1757946, -1399.57678, -0.573599219, 0, -0.81913656, 0, 1, 0, 0.81913656, 0, -0.573599219)
		elseif _G.SelectBoss == "Greybeard" then
			Boss = "Greybeard"
			LevelQuest = nil
			CFrameQuest = CFrame.new(-5081.3452148438, 85.221641540527, 4257.3588867188)
			CFrameBoss = CFrame.new(-5081.3452148438, 85.221641540527, 4257.3588867188)
		end
	end
	if World2 then
		if _G.SelectBoss == "Diamond" then
			Boss = "Diamond"
			NameQuest = "Area1Quest"
			LevelQuest = 3
			CFrameQuest = CFrame.new(-427.5666809082, 73.313781738281, 1835.4208984375)
			CFrameBoss = CFrame.new(-1576.7166748047, 198.59265136719, 13.724286079407)
		elseif _G.SelectBoss == "Jeremy" then
			Boss = "Jeremy"
			NameQuest = "Area2Quest"
			LevelQuest = 3
			CFrameQuest = CFrame.new(636.79943847656, 73.413787841797, 918.00415039063)
			CFrameBoss = CFrame.new(2006.9261474609, 448.95666503906, 853.98284912109)
		elseif _G.SelectBoss == "Fajita" then
			Boss = "Fajita"
			NameQuest = "MarineQuest3"
			LevelQuest = 3
			CFrameQuest = CFrame.new(-2441.986328125, 73.359344482422, -3217.5324707031)
			CFrameBoss = CFrame.new(-2172.7399902344, 103.32216644287, -4015.025390625)
		elseif _G.SelectBoss == "Don Swan" then
			Boss = "Don Swan"
			CFrameBoss = CFrame.new(2286.2004394531, 15.177839279175, 863.8388671875)
		elseif _G.SelectBoss == "Smoke Admiral" then
			Boss = "Smoke Admiral"
			NameQuest = "IceSideQuest"
			LevelQuest = 3
			CFrameQuest = CFrame.new(-5429.0473632813, 15.977565765381, -5297.9614257813)
			CFrameBoss = CFrame.new(-5275.1987304688, 20.757257461548, -5260.6669921875)
		elseif _G.SelectBoss == "Awakened Ice Admiral" then
			Boss = "Awakened Ice Admiral"
			NameQuest = "FrostQuest"
			LevelQuest = 3
			CFrameQuest = CFrame.new(5668.9780273438, 28.519989013672, -6483.3520507813)
			CFrameBoss = CFrame.new(6403.5439453125, 340.29766845703, -6894.5595703125)
		elseif _G.SelectBoss == "Tide Keeper" then
			Boss = "Tide Keeper"
			NameQuest = "ForgottenQuest"
			LevelQuest = 3
			CFrameQuest = CFrame.new(-3053.9814453125, 237.18954467773, -10145.0390625)
			CFrameBoss = CFrame.new(-3795.6423339844, 105.88877105713, -11421.307617188)
		elseif _G.SelectBoss == "Darkbeard" then
			Boss = "Darkbeard"
			LevelQuest = nil
			CFrameQuest = CFrame.new(3677.08203125, 62.751937866211, -3144.8332519531)
			CFrameBoss = CFrame.new(3677.08203125, 62.751937866211, -3144.8332519531)
		elseif _G.SelectBoss == "Cursed Captaim" then
			Boss = "Cursed Captain"
			LevelQuest = nil
			CFrameQuest = CFrame.new(916.928589, 181.092773, 33422)
			CFrameBoss = CFrame.new(916.928589, 181.092773, 33422)
		elseif _G.SelectBoss == "Order" then
			Boss = "Order"
			LevelQuest = nil
			CFrameQuest = CFrame.new(-6217.2021484375, 28.047645568848, -5053.1357421875)
			CFrameBoss = CFrame.new(-6217.2021484375, 28.047645568848, -5053.1357421875)
		end
	end
	if World3 then
		if _G.SelectBoss == "Stone" then
			Boss = "Stone"
			NameQuest = "PiratePortQuest"
			LevelQuest = 3
			CFrameQuest = CFrame.new(-289.76705932617, 43.819011688232, 5579.9384765625)
			CFrameBoss = CFrame.new(-1027.6512451172, 92.404174804688, 6578.8530273438)
		elseif _G.SelectBoss == "Hydra Leader" then
			Boss = "Hydra Leader"
			NameQuest = "AmazonQuest2"
			LevelQuest = 3
			CFrameQuest = CFrame.new(5821.89794921875, 1019.0950927734375, -73.71923065185547)
			CFrameBoss = CFrame.new(5821.89794921875, 1019.0950927734375, -73.71923065185547)
		elseif _G.SelectBoss == "Kilo Admiral" then
			Boss = "Kilo Admiral"
			NameQuest = "MarineTreeIsland"
			LevelQuest = 3
			CFrameQuest = CFrame.new(2179.3010253906, 28.731239318848, -6739.9741210938)
			CFrameBoss = CFrame.new(2764.2233886719, 432.46154785156, -7144.4580078125)
		elseif _G.SelectBoss == "Captain Elephant" then
			Boss = "Captain Elephant"
			NameQuest = "DeepForestIsland"
			LevelQuest = 3
			CFrameQuest = CFrame.new(-13232.682617188, 332.40396118164, -7626.01171875)
			CFrameBoss = CFrame.new(-13376.7578125, 433.28689575195, -8071.392578125)
		elseif _G.SelectBoss == "Beautiful Pirate" then
			Boss = "Beautiful Pirate"
			NameQuest = "DeepForestIsland2"
			LevelQuest = 3
			CFrameQuest = CFrame.new(-12682.096679688, 390.88653564453, -9902.1240234375)
			CFrameBoss = CFrame.new(5283.609375, 22.56223487854, -110.78285217285)
		elseif _G.SelectBoss == "Cake Queen" then
			Boss = "Cake Queen"
			NameQuest = "IceCreamIslandQuest"
			LevelQuest = 3
			CFrameQuest = CFrame.new(-819.376709, 64.9259796, -10967.2832, -0.766061664, 0, 0.642767608, 0, 1, 0, -0.642767608, 0, -0.766061664)
			CFrameBoss = CFrame.new(-678.648804, 381.353943, -11114.2012, -0.908641815, 0.00149294338, 0.41757378, 0.00837114919, 0.999857843, 0.0146408929, -0.417492568, 0.0167988986, -0.90852499)
		elseif _G.SelectBoss == "Longma" then
			Boss = "Longma"
			LevelQuest = nil
			CFrameQuest = CFrame.new(-10238.875976563, 389.7912902832, -9549.7939453125)
			CFrameBoss = CFrame.new(-10238.875976563, 389.7912902832, -9549.7939453125)
		elseif _G.SelectBoss == "Soul Reaper" then
			Boss = "Soul Reaper"
			LevelQuest = nil
			CFrameQuest = CFrame.new(-9524.7890625, 315.80429077148, 6655.7192382813)
			CFrameBoss = CFrame.new(-9524.7890625, 315.80429077148, 6655.7192382813)
		end
	end
end
function Material(SelectMaterial)
	local a = game.Players.LocalPlayer
	local b = a.Character and a.Character:FindFirstChild("HumanoidRootPart")
	if not b then
		return
	end
	function shouldRequestEntrance(c, d)
		local e = (b.Position - c).Magnitude
		if e >= d then
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", c)
		end
	end
	if World1 then
		if SelectMaterial == "Angel Wings" then
			MaterialMon = {
				"Shanda",
				"Royal Squad",
				"Royal Soldier",
				"Wysper",
				"Thunder God"
			}
			MaterialPos = CFrame.new(-4698, 845, -1912)
			local c = Vector3.new(-4607.82275, 872.54248, -1667.55688)
			shouldRequestEntrance(c, 10000)
		elseif SelectMaterial == "Leather + Scrap Metal" then
			MaterialMon = {
				"Brute",
				"Pirate"
			}
			MaterialPos = CFrame.new(-1145, 15, 4350)
		elseif SelectMaterial == "Magma Ore" then
			MaterialMon = {
				"Military Soldier",
				"Military Spy",
				"Magma Admiral"
			}
			MaterialPos = CFrame.new(-5815, 84, 8820)
		elseif SelectMaterial == "Fish Tail" then
			MaterialMon = {
				"Fishman Warrior",
				"Fishman Commando",
				"Fishman Lord"
			}
			MaterialPos = CFrame.new(61123, 19, 1569)
			local c = Vector3.new(61163.8515625, 5.342342376708984, 1819.7841796875)
			shouldRequestEntrance(c, 17000)
		end
	elseif World2 then
		if SelectMaterial == "Leather + Scrap Metal" then
			MaterialMon = {
				"Marine Captain"
			}
			MaterialPos = CFrame.new(-2010.5059814453125, 73.00115966796875, -3326.620849609375)
		elseif SelectMaterial == "Magma Ore" then
			MaterialMon = {
				"Magma Ninja",
				"Lava Pirate"
			}
			MaterialPos = CFrame.new(-5428, 78, -5959)
		elseif SelectMaterial == "Ectoplasm" then
			MaterialMon = {
				"Ship Deckhand",
				"Ship Engineer",
				"Ship Steward",
				"Ship Officer"
			}
			MaterialPos = CFrame.new(911.35827636719, 125.95812988281, 33159.5390625)
			local c = Vector3.new(61163.8515625, 5.342342376708984, 1819.7841796875)
			shouldRequestEntrance(c, 18000)
		elseif SelectMaterial == "Mystic Droplet" then
			MaterialMon = {
				"Water Fighter"
			}
			MaterialPos = CFrame.new(-3385, 239, -10542)
		elseif SelectMaterial == "Radioactive Material" then
			MaterialMon = {
				"Factory Staff"
			}
			MaterialPos = CFrame.new(295, 73, -56)
		elseif SelectMaterial == "Vampire Fang" then
			MaterialMon = {
				"Vampire"
			}
			MaterialPos = CFrame.new(-6033, 7, -1317)
		end
	elseif World3 then
		if SelectMaterial == "Scrap Metal" then
			MaterialMon = {
				"Jungle Pirate",
				"Forest Pirate"
			}
			MaterialPos = CFrame.new(-11975.78515625, 331.7734069824219, -10620.0302734375)
		elseif SelectMaterial == "Fish Tail" then
			MaterialMon = {
				"Fishman Raider",
				"Fishman Captain"
			}
			MaterialPos = CFrame.new(-10993, 332, -8940)
		elseif SelectMaterial == "Conjured Cocoa" then
			MaterialMon = {
				"Chocolate Bar Battler",
				"Cocoa Warrior"
			}
			MaterialPos = CFrame.new(620.6344604492188, 78.93644714355469, -12581.369140625)
		elseif SelectMaterial == "Dragon Scale" then
			MaterialMon = {
				"Dragon Crew Archer",
				"Dragon Crew Warrior"
			}
			MaterialPos = CFrame.new(6594, 383, 139)
		elseif SelectMaterial == "Gunpowder" then
			MaterialMon = {
				"Pistol Billionaire"
			}
			MaterialPos = CFrame.new(-84.8556900024414, 85.62061309814453, 6132.0087890625)
		elseif SelectMaterial == "Mini Tusk" then
			MaterialMon = {
				"Mythological Pirate"
			}
			MaterialPos = CFrame.new(-13545, 470, -6917)
		elseif SelectMaterial == "Demonic Wisp" then
			MaterialMon = {
				"Demonic Soul"
			}
			MaterialPos = CFrame.new(-9495.6806640625, 453.58624267578125, 5977.3486328125)
		end
	end
end
function Marines()
	game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetTeam", "Marines")
end
function Pirates()
	game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetTeam", "Pirates")
end
function EquipWeapon(text)
	if not text then
		return
	end
	if game.Players.LocalPlayer.Backpack:FindFirstChild(text) then
		game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack:FindFirstChild(text))
	end
end
function weaponSc(weapon)
	for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
		if v:IsA("Tool") then
			if v.ToolTip == weapon then
				EquipWeapon(v.Name)
			end
		end
	end
end
function SafeWaitForChild(parent, childName)
	local success, result = pcall(function()
		return parent:WaitForChild(childName)
	end)
	return result
end
Net = SafeWaitForChild(SafeWaitForChild(game.ReplicatedStorage, "Modules"), "Net")
RegisterAttack = SafeWaitForChild(Net, "RE/RegisterAttack")
RegisterHit = SafeWaitForChild(Net, "RE/RegisterHit")
function IsAlive(character)
	return character and character:FindFirstChild("Humanoid") and character.Humanoid.Health > 0
end
function ProcessEnemies(OthersEnemies, Folder)
	local BasePart = nil
	for _, Enemy in pairs(Folder:GetChildren()) do
	local Head = Enemy:FindFirstChild("Head")
		if Head and IsAlive(Enemy) and game.Players.LocalPlayer:DistanceFromCharacter(Head.Position) < 120 then
			if Enemy ~= game.Players.LocalPlayer.Character then
				table.insert(OthersEnemies, {Enemy, Head})
				BasePart = Head
			end
		end
	end
	return BasePart
end
function BladeHit(BasePart, OthersEnemies)
	RegisterAttack:FireServer(0)
	RegisterHit:FireServer(BasePart, OthersEnemies)
end
function AttackNoCD()
	local OthersEnemies = {}
	Enemies = ProcessEnemies(OthersEnemies, game.Workspace:WaitForChild("Enemies"))
	SeaBeasts = ProcessEnemies(OthersEnemies, game.Workspace:WaitForChild("SeaBeasts"))
	Characters = ProcessEnemies(OthersEnemies, game.Workspace:WaitForChild("Characters"))
	local EquipWeapon = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
	if EquipWeapon and EquipWeapon:FindFirstChild("LeftClickRemote") then
		for _, enemyData in ipairs(OthersEnemies) do
			pcall(function()
				EquipWeapon.LeftClickRemote:FireServer((enemyData[1].HumanoidRootPart.Position - game.Players.LocalPlayer.Character:GetPivot().Position).Unit, 1)
			end)
		end
	elseif #OthersEnemies > 0 then
		BladeHit(Enemies or SeaBeasts or Characters, OthersEnemies)
	end
end
Attack = {}
Attack.__index = Attack
function Attack.Alive(model)
	if not model then
		return
	end
	local Humanoid = model:FindFirstChild("Humanoid")
	return Humanoid and Humanoid.Health > 0
end
function Attack.Pos(model, dist)
	return (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - mode.Position).Magnitude <= dist
end
function Attack.Dist(model, dist)
	return (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - model:FindFirstChild("HumanoidRootPart").Position).Magnitude <= dist
end
function Attack.Kill(model, Succes)
	if model and Succes then
		if not model:GetAttribute("Locked") then
			model:SetAttribute("Locked", model.HumanoidRootPart.CFrame)
		end
		PosMon = model:GetAttribute("Locked").Position
		BringEnemy(model.Name)
		EquipWeapon(_G.SelectWeapon)
		AttackNoCD()
		if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").ToolTip == "Blox Fruit" then
			Tween(model.HumanoidRootPart.CFrame * CFrame.new(0, 20, 0))
		else
			if _G.SpinPosition then
				wait(0.2)
				Tween(model.HumanoidRootPart.CFrame * CFrame.new(0, 30, 25))
				wait(0.2)
				Tween(model.HumanoidRootPart.CFrame * CFrame.new(25, 30, 0))
				wait(0.2)
				Tween(model.HumanoidRootPart.CFrame * CFrame.new(0, 30, -25))
				wait(0.2)
				Tween(model.HumanoidRootPart.CFrame * CFrame.new(-25, 30, 0))
			else
				Tween(model.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
			end
		end
	end
end
function Attack.Kill2(model, Succes)
	if model and Succes then
		if game:GetService("Workspace")._WorldOrigin:FindFirstChild("Ring") or game:GetService("Workspace")._WorldOrigin:FindFirstChild("Fist") or game:GetService("Workspace")._WorldOrigin:FindFirstChild("MochiSwirl") then
			Tween(model.HumanoidRootPart.CFrame * CFrame.new(0, 90, 0))
		else
			if not model:GetAttribute("Locked") then
				model:SetAttribute("Locked", model.HumanoidRootPart.CFrame)
			end
			PosMon = model:GetAttribute("Locked").Position
			BringEnemy(model.Name)
			EquipWeapon(_G.SelectWeapon)
			AttackNoCD()
			if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").ToolTip == "Blox Fruit" then
				Tween(model.HumanoidRootPart.CFrame * CFrame.new(0, 20, 0))
			else
				if _G.SpinPosition then
					wait(0.2)
					Tween(model.HumanoidRootPart.CFrame * CFrame.new(0, 30, 25))
					wait(0.2)
					Tween(model.HumanoidRootPart.CFrame * CFrame.new(25, 30, 0))
					wait(0.2)
					Tween(model.HumanoidRootPart.CFrame * CFrame.new(0, 30, -25))
					wait(0.2)
					Tween(model.HumanoidRootPart.CFrame * CFrame.new(-25, 30, 0))
				else
					Tween(model.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
				end
			end
		end
	end
end
function Attack.KillSea(model, Succes)
	if model and Succes then
		if game:GetService("Workspace")._WorldOrigin:FindFirstChild("Typhoon Splash") then
			Tween(model.HumanoidRootPart.CFrame * CFrame.new(0, 300, 0))
		else
			if not model:GetAttribute("Locked") then
				model:SetAttribute("Locked", model.HumanoidRootPart.CFrame)
			end
			PosMon = model:GetAttribute("Locked").Position
			BringEnemy(model.Name)
			EquipWeapon(_G.SelectWeapon)
			AttackNoCD()
			if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").ToolTip == "Blox Fruit" then
				Tween(model.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0))
			else
				Tween(model.HumanoidRootPart.CFrame * CFrame.new(0, 50, 0))
			end
		end
	end
end
function Attack.Sword(model, Succes)
	if model and Succes then
		if not model:GetAttribute("Locked") then
			model:SetAttribute("Locked", model.HumanoidRootPart.CFrame)
		end
		PosMon = model:GetAttribute("Locked").Position
		BringEnemy(model.Name)
		weaponSc("Sword")
		AttackNoCD()
		if _G.SpinPosition then
			wait(0.2)
			Tween(model.HumanoidRootPart.CFrame * CFrame.new(0, 30, 25))
			wait(0.2)
			Tween(model.HumanoidRootPart.CFrame * CFrame.new(25, 30, 0))
			wait(0.2)
			Tween(model.HumanoidRootPart.CFrame * CFrame.new(0, 30, -25))
			wait(0.2)
			Tween(model.HumanoidRootPart.CFrame * CFrame.new(-25, 30, 0))
		else
			Tween(model.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
		end
	end
end
function Attack.Mas(model, Succes)
	if model and Succes then
		if not model:GetAttribute("Locked") then
			model:SetAttribute("Locked", model.HumanoidRootPart.CFrame)
		end
		PosMon = model:GetAttribute("Locked").Position
		BringEnemy(model.Name)
		if model.Humanoid.Health <= HealthM then
			Tween(model.HumanoidRootPart.CFrame * CFrame.new(0, 20, 0))
			Useskillfruit()
		else
			weaponSc("Melee")
			AttackNoCD()
			if _G.SpinPosition then
				wait(0.2)
				Tween(model.HumanoidRootPart.CFrame * CFrame.new(0, 30, 25))
				wait(0.2)
				Tween(model.HumanoidRootPart.CFrame * CFrame.new(25, 30, 0))
				wait(0.2)
				Tween(model.HumanoidRootPart.CFrame * CFrame.new(0, 30, -25))
				wait(0.2)
				Tween(model.HumanoidRootPart.CFrame * CFrame.new(-25, 30, 0))
			else
				Tween(model.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
			end
		end
	end
end
function Attack.Masgun(model, Succes)
	if model and Succes then
		if not model:GetAttribute("Locked") then
			model:SetAttribute("Locked", model.HumanoidRootPart.CFrame)
		end
		PosMon = model:GetAttribute("Locked").Position
		BringEnemy(model.Name)
		if model.Humanoid.Health <= HealthM then
			Tween(model.HumanoidRootPart.CFrame * CFrame.new(0, 35, 0))
			Useskillgun()
		else
			weaponSc("Melee")
			AttackNoCD()
			if _G.SpinPosition then
				wait(0.2)
				Tween(model.HumanoidRootPart.CFrame * CFrame.new(0, 30, 25))
				wait(0.2)
				Tween(model.HumanoidRootPart.CFrame * CFrame.new(25, 30, 0))
				wait(0.2)
				Tween(model.HumanoidRootPart.CFrame * CFrame.new(0, 30, -25))
				wait(0.2)
				Tween(model.HumanoidRootPart.CFrame * CFrame.new(-25, 30, 0))
			else
				Tween(model.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
			end
		end
	end
end
function BringEnemy(Name)
	if _G.BringMob then
		for _, v in pairs(workspace.Enemies:GetChildren()) do
			if v.Name == Name then
				if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
					if (v.PrimaryPart.Position - PosMon).Magnitude <= 300 then
						v.PrimaryPart.CFrame = CFrame.new(PosMon)
						v.PrimaryPart.CanCollide = true
						v:FindFirstChild("Humanoid").WalkSpeed = 0
						v:FindFirstChild("Humanoid").JumpPower = 0
						if v.Humanoid:FindFirstChild("Animator") then
							v.Humanoid.Animator:Destroy()
						end
						game.Players.LocalPlayer.SimulationRadius = math.huge
					end
				end
			end
		end
	end
end
function Keyevent(key, hold)
	game:GetService("VirtualInputManager"):SendKeyEvent(true, key, false, game)
	wait(hold)
	game:GetService("VirtualInputManager"):SendKeyEvent(false, key, false, game)
end
function Useskillfruit()
	if table.find(_G.SelectSkill, "Z") then
		weaponSc("Blox Fruit")
		Keyevent("Z", _G.HoldZ)
	end
	if table.find(_G.SelectSkill, "X") then
		weaponSc("Blox Fruit")
		Keyevent("X", _G.HoldX)
	end
	if table.find(_G.SelectSkill, "C") then
		weaponSc("Blox Fruit")
		Keyevent("C", _G.HoldC)
	end
	if table.find(_G.SelectSkill, "V") then
		weaponSc("Blox Fruit")
		Keyevent("V", _G.HoldV)
	end
	if table.find(_G.SelectSkill, "F") then
		weaponSc("Blox Fruit")
		Keyevent("F", _G.HoldF)
	end
end
function Useskillgun()
	if table.find(_G.SelectSkill, "Z") then
		weaponSc("Gun")
		Keyevent("Z", _G.HoldZ)
	end
	if table.find(_G.SelectSkill, "X") then
		weaponSc("Gun")
		Keyevent("X", _G.HoldX)
	end
end
function Useskillsea()
	if not DoneSkillMelee then
		if table.find(_G.SelectSkillMelee, "Z") then
			weaponSc("Melee")
			Keyevent("Z", _G.HoldZMelee)
		end
		if table.find(_G.SelectSkillMelee, "X") then
			weaponSc("Melee")
			Keyevent("X", _G.HoldXMelee)
		end
		if table.find(_G.SelectSkillMelee, "C") then
			weaponSc("Melee")
			Keyevent("C", _G.HoldCMelee)
		end
		DoneSkillMelee = true
	end
	if not DoneSkillSword then
		if table.find(_G.SelectSkillSword, "Z") then
			weaponSc("Sword")
			Keyevent("Z", _G.HoldZSword)
		end
		if table.find(_G.SelectSkillSword, "X") then
			weaponSc("Sword")
			Keyevent("X", _G.HoldXSword)
		end
		DoneSkillSword = true
	end
	if not DoneSkillGun then
		if table.find(_G.SelectSkillGun, "Z") then
			weaponSc("Gun")
			Keyevent("Z", _G.HoldZGun)
		end
		if table.find(_G.SelectSkillGun, "X") then
			weaponSc("Gun")
			Keyevent("X", _G.HoldXGun)
		end
		DoneSkillGun = true
	end
	if not DoneSkillFruit then
		if table.find(_G.SelectSkillFruit, "Z") then
			weaponSc("Blox Fruit")
			Keyevent("Z", _G.HoldZFruit)
		end
		if table.find(_G.SelectSkillFruit, "X") then
			weaponSc("Blox Fruit")
			Keyevent("X", _G.HoldXFruit)
		end
		if table.find(_G.SelectSkillFruit, "C") then
			weaponSc("Blox Fruit")
			Keyevent("C", _G.HoldCFruit)
		end
		if table.find(_G.SelectSkillFruit, "V") then
			weaponSc("Blox Fruit")
			Keyevent("V", _G.HoldVFruit)
		end
		if table.find(_G.SelectSkillFruit, "F") then
			weaponSc("Blox Fruit")
			Keyevent("F", _G.HoldFFruit)
		end
		DoneSkillFruit = true
	end
	DoneSkillMelee = false
	DoneSkillSword = false
	DoneSkillGun = false
	DoneSkillFruit = false
end
gg = getrawmetatable(game)
old = gg.__namecall
setreadonly(gg, false)
gg.__namecall = newcclosure(function(...)
	local method = getnamecallmethod()
	local args = {
		...
	}
	if tostring(method) == "FireServer" then
		if tostring(args[1]) == "RemoteEvent" then
			if tostring(args[2]) ~= "true" and tostring(args[2]) ~= "false" then
				if (_G.MasteryGun and not SoulGuitar) or (_G.MasteryFruit) or (_G.DragonHunter) or (_G.PatchPrehistoric) or (_G.SeaBeast or _G.FishBoat or _G.PirateGrandBrigade or _G.Leviathan or _G.Trial) or (_G.AimSkill or _G.AimNearest) then
					args[2] = MousePos
					return old(unpack(args))
				end
			end
		end
	end
	return old(...)
end)
function GetConnectionEnemies(a)
	for i, v in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do
		if v:IsA("Model") and ((typeof(a) == "table" and table.find(a, v.Name)) or v.Name == a) and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
			return v
		end
	end
	for i, v in next, game.Workspace.Enemies:GetChildren() do
		if v:IsA("Model") and ((typeof(a) == "table" and table.find(a, v.Name)) or v.Name == a) and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
			return v
		end
	end
end
function FPSBooster()
	local decalsyeeted = true
	local g = game
	local w = g.Workspace
	local l = g.Lighting
	local t = w.Terrain
	t.WaterWaveSize = 0
	t.WaterWaveSpeed = 0
	t.WaterReflectance = 0
	t.WaterTransparency = 0
	l.GlobalShadows = false
	l.FogEnd = 9e9
	l.Brightness = 0
	settings().Rendering.QualityLevel = "Level01"
	for i, v in pairs(g:GetDescendants()) do
		if v:IsA("Part") or v:IsA("Union") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
			v.Material = "Plastic"
			v.Reflectance = 0
		elseif v:IsA("Decal") or v:IsA("Texture") and decalsyeeted then
			v.Transparency = 1
		elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
			v.Lifetime = NumberRange.new(0)
		elseif v:IsA("Explosion") then
			v.BlastPressure = 1
			v.BlastRadius = 1
		elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
			v.Enabled = false
		elseif v:IsA("MeshPart") then
			v.Material = "Plastic"
			v.Reflectance = 0
			v.TextureID = 10385902758728957
		end
	end
	for i, e in pairs(l:GetChildren()) do
		if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
			e.Enabled = false
		end
	end
end
function CheckBoat()
	for i, v in pairs(workspace.Boats:GetChildren()) do
		if tostring(v.Owner.Value) == tostring(game.Players.LocalPlayer.Name) then
			return v
		end
	end
	return false
end
function CheckEnemiesBoat()
	for _, v in pairs(workspace.Enemies:GetChildren()) do
		if (v.Name == "FishBoat") and v:FindFirstChild("Health").Value > 0 then
			return true
		end
	end
	return false
end
function CheckPirateGrandBrigade()
	for _, v in pairs(workspace.Enemies:GetChildren()) do
		if (v.Name == "PirateGrandBrigade" or v.Name == "PirateBrigade") and v:FindFirstChild("Health").Value > 0 then
			return true
		end
	end
	return false
end
function CheckShark()
	for _, v in pairs(workspace.Enemies:GetChildren()) do
		if v.Name == "Shark" and Attack.Alive(v) then
			return true
		end
	end
	return false
end
function CheckTerrorshark()
	for _, v in pairs(workspace.Enemies:GetChildren()) do
		if v.Name == "Terrorshark" and Attack.Alive(v) then
			return true
		end
	end
	return false
end
function CheckPiranha()
	for _, v in pairs(workspace.Enemies:GetChildren()) do
		if v.Name == "Piranha" and Attack.Alive(v) then
			return true
		end
	end
	return false
end
function CheckFishCrew()
	for _, v in pairs(workspace.Enemies:GetChildren()) do
		if (v.Name == "Fish Crew Member" or v.Name == "Haunted Crew Member") and Attack.Alive(v) then
			return true
		end
	end
	return false
end
function CheckHauntedCrew()
	for _, v in pairs(workspace.Enemies:GetChildren()) do
		if (v.Name == "Haunted Crew Member") and Attack.Alive(v) then
			return true
		end
	end
	return false
end
function CheckSeaBeast()
	if workspace.SeaBeasts:FindFirstChild("SeaBeast1") then
		return true
	end
	return false
end
function CheckLeviathan()
	if workspace.SeaBeasts:FindFirstChild("Leviathan") then
		return true
	end
	return false
end
function UpdStFruit()
	for z, x in next, game.Players.LocalPlayer.Backpack:GetChildren() do
		StoreFruit = x:FindFirstChild("EatRemote", true)
		if StoreFruit then
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", StoreFruit.Parent:GetAttribute("OriginalName"), game.Players.LocalPlayer.Backpack:FindFirstChild(x.Name))
		end
	end
end
function collectFruits(Succes)
	if Succes then
		local Character = game.Players.LocalPlayer.Character
		for _, v1 in pairs(workspace:GetChildren()) do
			if string.find(v1.Name, "Fruit") then
				v1.Handle.CFrame = Character.HumanoidRootPart.CFrame
			end
		end
	end
end
function DropFruits()
	for _, v3 in next, game.Players.LocalPlayer.Backpack:GetChildren() do
		if string.find(v3.Name, "Fruit") then
			EquipWeapon(v3.Name)
			wait(0.1)
			if game.Players.LocalPlayer.PlayerGui.Main.Dialogue.Visible then
				game.Players.LocalPlayer.PlayerGui.Main.Dialogue.Visible = false
			end
			EquipWeapon(v3.Name)
			game.Players.LocalPlayer.Character:FindFirstChild(v3.Name).EatRemote:InvokeServer("Drop")
		end
	end
	for a, b2 in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
		if string.find(b2.Name, "Fruit") then
			EquipWeapon(b2.Name)
			wait(0.1)
			if game.Players.LocalPlayer.PlayerGui.Main.Dialogue.Visible then
				game.Players.LocalPlayer.PlayerGui.Main.Dialogue.Visible = false
			end
			EquipWeapon(b2.Name)
			game.Players.LocalPlayer.Character:FindFirstChild(b2.Name).EatRemote:InvokeServer("Drop")
		end
	end
end
function GetBP(v)
	return game.Players.LocalPlayer.Backpack:FindFirstChild(v) or game.Players.LocalPlayer.Character:FindFirstChild(v)
end
function GetIn(Name)
	for _ , v1 in pairs(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("getInventory")) do
		if type(v1) == "table" then
			if v1.Name == Name or game.Players.LocalPlayer.Character:FindFirstChild(Name) or game.Players.LocalPlayer.Backpack:FindFirstChild(Name) then
				return true
			end
		end
	end
	return false
end
function GetM(Name)
	for _, tab in pairs(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("getInventory")) do
		if type(tab) == "table" then
			if tab.Type == "Material" then
				if tab.Name == Name then
					return tab.Count
				end
			end
		end
	end
	return 0
end
Energy = game.Players.LocalPlayer.Character.Energy.Value
function GetWP(nametool)
	for _, v4 in pairs(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("getInventory")) do
		if type(v4) == "table" then
			if v4.Type == "Sword" then
				if v4.Name == nametool or game.Players.LocalPlayer.Character:FindFirstChild(nametool) or game.Players.LocalPlayer.Backpack:FindFirstChild(nametool) then
					return true
				end
			end
		end
	end
	return false
end
function getInfinity_Ability(Method, Var)
	if not game.Players.LocalPlayer.Character.HumanoidRootPart then
		return
	end
	if Method == "Soru" and Var then
		for _, gc in next, getgc() do
			if game.Players.LocalPlayer.Character.Soru then
				if ((typeof(gc) == "function ") and (getfenv(gc).script == game.Players.LocalPlayer.Character.Soru)) then
					for _, v in next, getupvalues(gc) do
						if (typeof(v) == "table") then
							repeat
								wait(0.2)
								v.LastUse = 0
							until not Var or (game.Players.LocalPlayer.Character.Humanoid.Health <= 0)
						end
					end
				end
			end
		end
	elseif Method == "Energy" and Var then
		game.Players.LocalPlayer.Character.Energy.Changed:connect(function()
			if Var then
				game.Players.LocalPlayer.Character.Energy.Value = Energy
			end
		end)
	elseif Method == "Observation" and Var then
		local VisionRadius = game.Players.LocalPlayer.VisionRadius
		VisionRadius.Value = math.huge
	end
end
function Hop()
	pcall(function()
		for count = math.random(1, math.random(40, 75)), 100 do
			local remote = game:GetService("ReplicatedStorage").__ServerBrowser:InvokeServer(count)
			for _, v in next, remote do
				if tonumber(v["Count"]) < 12 then
					game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, _)
				end
			end
		end
	end)
end
function Tween(Target)
	local HumanoidRootPart = game.Players.LocalPlayer.Character.HumanoidRootPart
	local Distance = (Target.Position - HumanoidRootPart.Position).Magnitude
	local TweenInfo = TweenInfo.new(Distance / SpeedTween, Enum.EasingStyle.Linear)
	_G.Tween = game:GetService("TweenService"):Create(HumanoidRootPart, TweenInfo, {
		CFrame = Target
	})
	_G.Tween:Play()
	if Distance <= 200 then
		TP(Target)
	end
end
function StopTween(Value)
	if not Value then
		if _G.Tween then
			_G.Tween:Cancel()
			_G.Tween = nil
		end
	end
end
function TP(p)
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = p
end
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.SailHydra or _G.Warden or _G.Factory or _G.HighestMirage or _G.HauntedCrew or _G.PirateGrandBrigade or _G.Leviathan or _G.UpgradeDragoTrial or _G.Trial or _G.TPDragoTrial or _G.BuyDrago or _G.DragoV2 or _G.UpgardeDragonTalon or _G.Berry or _G.FindPrehistoric or _G.PatchPrehistoric or _G.DinoBone or _G.DragonEgg or _G.DragonHunter or _G.DojoTrainer or _G.RaidLaw or _G.TPLab or _G.UnlockPhoenix or _G.Chest or _G.HallowScythe or _G.Long or _G.BlackSpikey or _G.HolyTorch or _G.TrainDrago or _G.Saber or _G.MasteryFruit or _G.Citizen or _G.Ectoplasm or _G.RainbowHaki or _G.Observation or _G.Buddy or _G.UnlockDough or _G.AllBoss or _G.Raid or _G.Canvender or _G.TPPlayer or _G.Bartilo or _G.Level or _G.Boss or _G.EliteHunter or _G.ThirdSea or _G.Bone or _G.Material or _G.VolcanicMagnet or _G.TPFrozen or _G.TP or _G.TrainV4 or _G.Nearest or _G.PirateRaid or _G.DarkBladeV3 or _G.Dungeon or _G.CakePrince or _G.TPFruitDealer or _G.TPNpc or _G.TwinHook or _G.FindMirage or _G.MirageChest or _G.Shark or _G.Terrorshark or _G.Piranha or _G.FishCrew or _G.SeaBeast or _G.FishBoat or _G.Pole or _G.PoleV2 or _G.Superhuman or _G.DeathStep or _G.SharkmanKarate or _G.ElectricClaw or _G.DragonTalon or _G.Darkbeard or _G.Godhuman or _G.Tushita or _G.ObservationV2 or _G.SerpentBow or _G.SoulGuitar or _G.TPGear or _G.Saw or _G.DragonTrident or _G.StartRaid or _G.EvoRace or _G.MarinesCoat or _G.SecondSea or _G.KillPlayerAfterTrial or _G.ArenaTrainer or _G.Yama or _G.SwanGlasses or _G.SwanCoat or _G.MidnightBlade or _G.Mink or _G.Human or _G.Skypiea or _G.Fish or _G.CursedDualKatana or _G.DoughKing or _G.Teleport or _G.LeiAccessory or _G.UsoapHat or _G.Praying or _G.TryLucky or _G.Cyborg or _G.UnlockPuzzle or _G.UnlockDonSwan or _G.RipIndra or _G.DragoV3 or _G.DragoV1 or _G.SailBoat or _G.NextIsland or _G.Rengoku or _G.DangerLV or _G.RelicDragoTrial or _G.AzureEmber or _G.FindKitsune or _G.SanguineArt or _G.TPFruit or _G.TPMasterAura or _G.TPKitsune or _G.MasteryGun or _G.MasteryAllSword then
				if not game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip") then
					local Noclip = Instance.new("BodyVelocity")
					Noclip.Name = "BodyClip"
					Noclip.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
					Noclip.MaxForce = Vector3.new(100000, 100000, 100000)
					Noclip.Velocity = Vector3.new(0, 0, 0)
				end
				if not game.Players.LocalPlayer.Character:FindFirstChild("Highlight") then
					local Test = Instance.new("Highlight")
					Test.Name = "Highlight"
					Test.Enabled = true
					Test.FillColor = Color3.fromRGB(0, 255, 0)
					Test.OutlineColor = Color3.fromRGB(255, 255, 255)
					Test.FillTransparency = 0.5
					Test.OutlineTransparency = 0.2
					Test.Parent = game.Players.LocalPlayer.Character
				end
				for _, no in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
					if no:IsA("BasePart") then
						no.CanCollide = false
					end
				end
			else
				if game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip") then
					game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip"):Destroy()
				end
				if game.Players.LocalPlayer.Character:FindFirstChild("Highlight") then
					game.Players.LocalPlayer.Character:FindFirstChild("Highlight"):Destroy()
				end
			end
		end)
	end
end)
ScreenGui = Instance.new("ScreenGui")
TextButton = Instance.new("TextButton")
UICorner = Instance.new("UICorner")
ScreenGui.Name = "ScreenGui"
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
TextButton.Name = "TextButton"
TextButton.Parent = ScreenGui
TextButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
TextButton.Position = UDim2.new(0.120833337, 0, 0.0952890813, 0)
TextButton.Size = UDim2.new(0, 53, 0, 53)
TextButton.Font = Enum.Font.SourceSansBold
TextButton.Text = "OFF"
TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TextButton.TextSize = 21
TextButton.TextWrapped = true
TextButton.Visible = true
TextButton.Draggable = true
UICorner.Parent = TextButton
isToggle = true
TextButton.MouseButton1Click:Connect(function()
	isToggle = not isToggle
	TextButton.Text = isToggle and "OFF" or "ON"
	Window:Minimize()
end)
Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
Window = Fluent:CreateWindow({
	Title = "Nano X Hub - Evo V2",
 	SubTitle = "by q8ta0e",
	TabWidth = 120,
	Size = UDim2.fromOffset(450, 300),
	Acrylic = true,
	Theme = "Dark",
	MinimizeKey = Enum.KeyCode.LeftControl
})
Tabs = {
	Status = Window:AddTab({
		Title = "Status",
		Icon = "clock"
	}),
	Main = Window:AddTab({
		Title = "Farming",
		Icon = "home"
	}),
	Items = Window:AddTab({
		Title = "Items",
		Icon = "swords"
	}),
	Skill = Window:AddTab({
		Title = "Skill",
		Icon = "settings-2"
	}),
	Sea = Window:AddTab({
		Title = "Sea Event",
		Icon = "waves"
	}),
	Race = Window:AddTab({
		Title = "Upgrade Race",
		Icon = "activity"
	}),
	Drago = Window:AddTab({
		Title = "Drago Dojo",
		Icon = "flame"
	}),
	Volcano = Window:AddTab({
		Title = "Volcano Event",
		Icon = "mountain-snow"
	}),
	Raid = Window:AddTab({
		Title = "Dungeon",
		Icon = "sun"
	}),
	Player = Window:AddTab({
		Title = "Local Player",
		Icon = "users"
	}),
	Visual = Window:AddTab({
		Title = "Visual",
		Icon = "eye"
	}),
	Teleport = Window:AddTab({
		Title = "Teleport",
		Icon = "map"
	}),
	Shop = Window:AddTab({
		Title = "Shop",
		Icon = "shopping-cart"
	}),
	Fruit = Window:AddTab({
		Title = "Devil Fruit",
		Icon = "apple"
	}),
	Misc = Window:AddTab({
		Title = "Misc",
		Icon = "boxes"
	}),
	Setting = Window:AddTab({
		Title = "Setting",
		Icon = "settings"
	})
}
Window:SelectTab(1)
Tabs.Status:AddSection("Local")
Server = Tabs.Status:AddParagraph({
	Title = "All Players On Server",
	Content = "N/A"
})
spawn(function()
	while task.wait() do
		pcall(function()
			for i, v in pairs(game:GetService("Players"):GetPlayers()) do
				Server:SetDesc(i .. "/12")
			end
		end)
	end
end)
Bone = Tabs.Status:AddParagraph({
	Title = "Bone",
	Content = "N/A"
})
spawn(function()
	while task.wait() do
		pcall(function()
			Bone:SetDesc(GetM("Bones"))
		end)
	end
end)
FullMoon = Tabs.Status:AddParagraph({
	Title = "Full Moon",
	Content = "N/A"
})
function GetMoon()
	if World1 then
		return game:GetService("Lighting").Sky.MoonTextureId
	elseif World2 then
		return game:GetService("Lighting").FantasySky.MoonTextureId
	elseif World3 then
		return game:GetService("Lighting").Sky.MoonTextureId
	end
end
spawn(function()
	while task.wait() do
		pcall(function()
			if GetMoon() == "http://www.roblox.com/asset/?id=9709135895" then
				FullMoon:SetDesc("25%")
			elseif GetMoon() == "http://www.roblox.com/asset/?id=9709139597" then
				FullMoon:SetDesc("50%")
			elseif GetMoon() == "http://www.roblox.com/asset/?id=9709143733" then
				FullMoon:SetDesc("75%")
			elseif GetMoon() == "http://www.roblox.com/asset/?id=9709149052" then
				FullMoon:SetDesc("100%")
			elseif GetMoon() == "http://www.roblox.com/asset/?id=9709149431" then
				FullMoon:SetDesc("0%")
			elseif GetMoon() == "http://www.roblox.com/asset/?id=9709149680" then
				FullMoon:SetDesc("0%")
			elseif GetMoon() == "http://www.roblox.com/asset/?id=9709150086" then
				FullMoon:SetDesc("0%")
			elseif GetMoon() == "http://www.roblox.com/asset/?id=9709150401" then
				FullMoon:SetDesc("0%")
			end
		end)
	end
end)
Tabs.Status:AddSection("Status")
Process = Tabs.Status:AddParagraph({
	Title = "Elite Process",
	Content = "N/A"
})
spawn(function()
	while task.wait() do
		pcall(function()
			Process:SetDesc(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EliteHunter", "Progress") .. " Elite")
		end)
	end
end)
local Tyrant = Tabs.Status:AddParagraph({
	Title = "Tyrant Of The Skies",
	Content = "N/A"
})
spawn(function()
	while task.wait() do
		pcall(function()
			if game:GetService("Workspace").Enemies:FindFirstChild("Tyrant of the Skies") then
				Tyrant:SetDesc("✅️")
			else
				Tyrant:SetDesc("❌️")
			end
		end)
	end
end)
local RipIndra = Tabs.Status:AddParagraph({
	Title = "Rip Indra",
	Content = ""
})
spawn(function()
	while task.wait() do
		pcall(function()
			if game:GetService("ReplicatedStorage"):FindFirstChild("rip_indra True Form")
			or game:GetService("Workspace").Enemies:FindFirstChild("rip_indra") then
				RipIndra:SetDesc("✅️")
			else
				RipIndra:SetDesc("❌️")
			end
		end)
	end
end)
local Dough = Tabs.Status:AddParagraph({
	Title = "Dough King",
	Content = "N/A"
})
spawn(function()
	while wait() do
		pcall(function()
			if game:GetService("ReplicatedStorage"):FindFirstChild("Dough King")
			or game:GetService("Workspace").Enemies:FindFirstChild("Dough King") then
				Dough:SetDesc("✅️")
			else
				Dough:SetDesc("❌️")
			end
		end)
	end
end)
Elite = Tabs.Status:AddParagraph({
	Title = "Elite Hunter",
	Content = "N/A"
})
spawn(function()
	while task.wait() do
		pcall(function()
			local rs = game:GetService("ReplicatedStorage")
			local ws = game:GetService("Workspace").Enemies
			if rs:FindFirstChild("Diablo") or rs:FindFirstChild("Deandre") or rs:FindFirstChild("Urban")
			or ws:FindFirstChild("Diablo") or ws:FindFirstChild("Deandre") or ws:FindFirstChild("Urban") then
				Elite:SetDesc("✅")
			else
				Elite:SetDesc("❌")
			end
		end)
	end
end)
Cake = Tabs.Status:AddParagraph({
	Title = "Cake Prince",
	Content = "N/A"
})
spawn(function()
	while task.wait() do
		pcall(function()
			local CakePrinceSpawner = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner")
			if string.len(CakePrinceSpawner) >= 86 then
				local Killed = string.sub(CakePrinceSpawner, 39, 41)
				Cake:SetDesc("Killed " .. (500 - Killed))
			else
				Cake:SetDesc("✅")
			end
		end)
	end
end)
Prehistoric = Tabs.Status:AddParagraph({
	Title = "Prehistoric Island",
	Content = "N/A"
})
spawn(function()
	while task.wait() do
		if workspace.Map:FindFirstChild("PrehistoricIsland") or workspace._WorldOrigin.Locations:FindFirstChild("Prehistoric Island") then
			Prehistoric:SetDesc("✅")
		else
			Prehistoric:SetDesc("❌")
		end
	end
end)
Flozen = Tabs.Status:AddParagraph({
	Title = "Flozen Dimension",
	Content = "N/A"
})
spawn(function()
	while task.wait() do
		pcall(function()
			if workspace._WorldOrigin.Locations:FindFirstChild("Frozen Dimension") then
				Flozen:SetDesc("✅")
			else
				Flozen:SetDesc("❌")
			end
		end)
	end
end)
Kitsune = Tabs.Status:AddParagraph({
	Title = "Kitsune Island",
	Content = "N/A"
})
spawn(function()
	while task.wait() do
		if workspace.Map:FindFirstChild("KitsuneIsland") or workspace._WorldOrigin.Locations:FindFirstChild("Kitsune Island") then
			Kitsune:SetDesc("✅")
		else
			Kitsune:SetDesc("❌")
		end
	end
end)
Mirage = Tabs.Status:AddParagraph({
	Title = "Mirage Island",
	Content = "N/A"
})
spawn(function()
	while task.wait() do
		if workspace.Map:FindFirstChild("MysticIsland") or workspace._WorldOrigin.Locations:FindFirstChild("Mirage Island") then
			Mirage:SetDesc("✅")
		else
			Mirage:SetDesc("❌")
		end
	end
end)
Dropdown = Tabs.Main:AddDropdown("Dropdown", {
	Title = "Select Weapon",
	Values = {"Melee", "Sword", "Blox Fruit", "Gun"},
	Multi = false,
	Default = "Melee"
})
Dropdown:OnChanged(function(Value)
	_G.SelectWP = Value
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.SelectWP == "Melee" then
				for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
					if v.ToolTip == "Melee" then
						if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v.Name)) then
							_G.SelectWeapon = v.Name
						end
					end
				end
			elseif _G.SelectWP == "Sword" then
				for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
					if v.ToolTip == "Sword" then
						if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v.Name)) then
							_G.SelectWeapon = v.Name
						end
					end
				end
			elseif _G.SelectWP == "Gun" then
				for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
					if v.ToolTip == "Gun" then
						if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v.Name)) then
							_G.SelectWeapon = v.Name
						end
					end
				end
			elseif _G.SelectWP == "Blox Fruit" then
				for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
					if v.ToolTip == "Blox Fruit" then
						if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v.Name)) then
							_G.SelectWeapon = v.Name
						end
					end
				end
			end
		end)
	end
end)
Dropdown = Tabs.Main:AddDropdown("Dropdown", {
	Title = "Select Fast Attack",
	Values = {"Normal Attack", "Fast Attack", "Super Fast Attack"},
	Multi = false,
	Default = "Fast Attack"
})
Dropdown:OnChanged(function(Value)
	_G.SelectFastAttack = Value
	if _G.SelectFastAttack == "Normal Attack" then
		AttackDelay = 0.2
	elseif _G.SelectFastAttack == "Fast Attack" then
		AttackDelay = 0.15
	elseif _G.SelectFastAttack == "Super Fast Attack" then
		AttackDelay = 0.1
	end
end)
Tabs.Main:AddSection("Farming")
Toggle = Tabs.Main:AddToggle("Toggle", {
	Title = "Auto Farm Level",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.Level = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		if _G.Level then
			pcall(function()
				CheckLevel()
				local QuestTitle = game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text
				if not string.find(QuestTitle, NameMon) then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
				end
				if not game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible then
					Tween(CFrameQuest)
					if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - CFrameQuest.Position).Magnitude <= 5 then
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", NameQuest, LevelQuest)
					end
				elseif game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible then
					if workspace.Enemies:FindFirstChild(Mon) then
						for i, v in pairs(workspace.Enemies:GetChildren()) do
							if Attack.Alive(v) then
								if v.Name == Mon then
									if string.find(QuestTitle, NameMon) then
										repeat
											wait()
											Attack.Kill(v, _G.Level)
										until not _G.Level or v.Humanoid.Health <= 0 or not v.Parent or not game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible
										Tween(CFrameMon)
									else
										game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
									end
								end
							end
						end
					else
						Tween(CFrameMon)
						if game:GetService("ReplicatedStorage"):FindFirstChild(Mon) then
							Tween(game:GetService("ReplicatedStorage"):FindFirstChild(Mon).HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
						end
					end
				end
			end)
		end
	end
end)
Toggle = Tabs.Main:AddToggle("Toggle", {
	Title = "Auto Farm Nearest",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.Nearest = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.Nearest then
				for i, v in pairs(workspace.Enemies:GetChildren()) do
					if v:FindFirstChild("Humanoid") or v:FindFirstChild("HumanoidRootPart") then
						if v.Humanoid.Health > 0 then
							repeat
								wait()
								Attack.Kill(v, _G.Nearest)
							until not _G.Nearest or not v.Parent or v.Humanoid.Health <= 0
						end
					end
				end
			end
		end)
	end
end)
Tabs.Main:AddSection("Fishing")
Dropdown = Tabs.Main:AddDropdown("Dropdown", {
	Title = "Select Bait",
	Values = {"Basic Bait", "Kelp Bait", "Good Bait", "Abyssal Bait", "Frozen Bait", "Epic Bait", "Carnivore Bait"},
	Multi = false,
	Default = "Basic Bait"
})
Dropdown:OnChanged(function(Value)
	_G.SelectBait = Value
end)
Tabs.Main:AddButton({
	Title = "Buy Bait",
	Callback = function()
		game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RF/Craft"):InvokeServer("Craft", _G.SelectBait, {})
	end
})
Toggle = Tabs.Main:AddToggle("Toggle", {
	Title = "Auto Fishing",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.Fishing = Value
end)
spawn(function()
    while task.wait() do
        if _G.Fishing then
            pcall(function()
                local Char = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
                local hrm = Char:FindFirstChild("HumanoidRootPart")
                local Tool = Char:FindFirstChildOfClass("Tool")
                if not (hrm and Tool) then return end

                local waterHeight = require(game:GetService("ReplicatedStorage").Util.GetWaterHeightAtLocation)(hrm.Position)
                local _, hitPos = game.Workspace:FindPartOnRayWithIgnoreList(
                    Ray.new(Char.Head.Position, hrm.CFrame.LookVector * require(game:GetService("ReplicatedStorage"):WaitForChild("FishReplicated").FishingClient.Config).Rod.MaxLaunchDistance),
                    {Char, game.Workspace.Characters, game.Workspace.Enemies}
                )
                local pos = Vector3.new(hitPos.X, math.max(hitPos.Y, waterHeight), hitPos.Z)
                local State = Tool:GetAttribute("State")
                local ServerState = Tool:GetAttribute("ServerState")

                if State == "ReeledIn" or ServerState == "ReeledIn" then
                    game:GetService("ReplicatedStorage"):WaitForChild("FishReplicated"):WaitForChild("FishingRequest"):InvokeServer("StartCasting")
                    task.wait()
                    game:GetService("ReplicatedStorage"):WaitForChild("FishReplicated"):WaitForChild("FishingRequest"):InvokeServer("CastLineAtLocation", pos, 100, true)
                elseif ServerState == "Biting" then
                    game:GetService("ReplicatedStorage"):WaitForChild("FishReplicated"):WaitForChild("FishingRequest"):InvokeServer("Catching", true)
                    task.wait(0.1)
                    game:GetService("ReplicatedStorage"):WaitForChild("FishReplicated"):WaitForChild("FishingRequest"):InvokeServer("Catch", 1)
                end
            end)
        end
    end
end)
Toggle = Tabs.Main:AddToggle("Toggle", {
	Title = "Auto Fishing Quest",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.FishingQuest = Value
end)
spawn(function()
	while task.wait() do
		if _G.FishingQuest then
			pcall(function()
				local questGui = game.Players.LocalPlayer.PlayerGui:FindFirstChild("Quest") or game.Players.LocalPlayer.PlayerGui:FindFirstChild("QuestGui")
				if not questGui and not questGui:FindFirstChild("Container") and questGui.Container:FindFirstChild("QuestTitle") then
					game:GetService("ReplicatedStorage").Modules.Net:WaitForChild("RF/JobsRemoteFunction"):InvokeServer("FishingNPC", "Angler", "AskQuest")
				end
				game:GetService("ReplicatedStorage").Modules.Net["RF/JobsRemoteFunction"]:InvokeServer("FishingNPC", "FinishQuest")
			end)
		end
	end
end)
Toggle = Tabs.Main:AddToggle("Toggle", {
	Title = "Auto Sell Fish",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.SellFish = Value
end)
spawn(function()
	while task.wait() do
		if _G.SellFish then
			pcall(function()
				game:GetService("ReplicatedStorage").Modules.Net["RF/JobsRemoteFunction"]:InvokeServer("FishingNPC", "SellFish")
 			end)
		end
	end
end)
Toggle = Tabs.Main:AddToggle("Toggle", {
	Title = "Auto Skill Bait",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.SkillBait = Value
end)
spawn(function()
	while task.wait() do
		if _G.SkillBait then
			pcall(function()
				game:GetService("ReplicatedStorage").Modules.Net:WaitForChild("RF/JobToolAbilities"):InvokeServer("Z", true)
			end)
		end
	end
end)
Tabs.Main:AddSection("Boss")
BossList = {}
if World1 then
	BossList = {
		"The Gorilla King",
		"Bobby",
		"The Saw",
		"Yeti",
		"Mob Leader",
		"Vice Admiral",
		"Saber Expert",
		"Warden",
		"Chief Warden",
		"Swan",
		"Magma Admiral",
		"Fishman Lord",
		"Wysper",
		"Thunder God",
		"Cyborg",
		"Ice Admiral",
		"Greybeard"
	}
elseif World2 then
	BossList = {
		"Diamond",
		"Jeremy",
		"Fajita",
		"Don Swan",
		"Smoke Admiral",
		"Awakened Ice Admiral",
		"Tide Keeper",
		"Darkbeard",
		"Cursed Captain",
		"Order"
	}
elseif World3 then
	BossList = {
		"Stone",
		"Hydra Leader",
		"Kilo Admiral",
		"Captain Elephant",
		"Beautiful Pirate",
		"Cake Queen",
		"Longma",
		"Soul Reaper"
	}
end
Dropdown = Tabs.Main:AddDropdown("Dropdown", {
	Title = "Select Boss",
	Values = BossList,
	Multi = false,
	Default = 1
})
Dropdown:OnChanged(function(Value)
	_G.SelectBoss = Value
end)
Toggle = Tabs.Main:AddToggle("Toggle", {
	Title = "Auto Kill Boss",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.Boss = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		if _G.Boss then
			pcall(function()
				CheckBoss()
				local v = GetConnectionEnemies(Boss)
				if v then
					repeat
						wait()
						Attack.Kill(v, _G.Boss)
					until not _G.Boss or not v.Parent or v.Humanoid.Health <= 0
				end
			end)
		end
	end
end)
Tabs.Main:AddSection("Material")
MaterialList = {}
if World1 then
	MaterialList = {
		"Leather + Scrap Metal",
		"Angel Wings",
		"Magma Ore",
		"Fish Tail"
	}
elseif World2 then
	MaterialList = {
		"Leather + Scrap Metal",
		"Radioactive Material",
		"Ectoplasm",
		"Mystic Droplet",
		"Magma Ore",
		"Vampire Fang"
	}
elseif World3 then
	MaterialList = {
		"Scrap Metal",
		"Demonic Wisp",
		"Conjured Cocoa",
		"Dragon Scale",
		"Gunpowder",
		"Fish Tail",
		"Mini Tusk"
	}
end
Dropdown = Tabs.Main:AddDropdown("Dropdown", {
	Title = "Select Material",
	Values = MaterialList,
	Multi = false,
	Default = 1
})
Dropdown:OnChanged(function(Value)
	_G.SelectMaterial = Value
end)
Toggle = Tabs.Main:AddToggle("Toggle", {
	Title = "Auto Farm Material",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.Material = Value
	StopTween(Value)
end)
spawn(function()
	function processEnemy(v, EnemyName)
		if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
			if v.Name == EnemyName then
				repeat
					wait()
					Attack.Kill(v, _G.Material)
				until not _G.Material or not v.Parent or v.Humanoid.Health <= 0
			end
		end
	end
	function handleEnemySpawns()
		for _, v in pairs(game:GetService("Workspace")["_WorldOrigin"].EnemySpawns:GetChildren()) do
			for _, EnemyName in ipairs(MaterialMon) do
				if string.find(v.Name, EnemyName) then
					if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Position).Magnitude >= 10 then
						Tween(v.CFrame * Pos)
					end
				end
			end
		end
	end
	while task.wait() do
		if _G.Material then
			pcall(function()
				if _G.SelectMaterial then
					Material(_G.SelectMaterial)
					Tween(MaterialPos)
				end
				for _, EnemyName in ipairs(MaterialMon) do
					for _, v in pairs(workspace.Enemies:GetChildren()) do
						processEnemy(v, EnemyName)
					end
				end
				handleEnemySpawns()
			end)
		end
	end
end)
Toggle = Tabs.Main:AddToggle("Toggle", {
	Title = "Auto Farm Ectoplasm",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.Ectoplasm = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.Ectoplasm then
				local v = GetConnectionEnemies({"Ship Deckhand", "Ship Engineer", "Ship Steward", "Ship Officer", "Arctic Warrior"})
				if Attack.Alive(v) then
					repeat
						wait()
						Attack.Kill(v, _G.Ectoplasm)
					until not _G.Ectoplasm or not v.Parent or v.Humanoid.Health <= 0
				else
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
				end
			end
		end)
	end
end)
Tabs.Main:AddSection("Berry")
Toggle = Tabs.Main:AddToggle("Toggle", {
	Title = "Auto Collect Berry",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.Berry = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		if _G.Berry then
			local CollectionService = game:GetService("CollectionService")
			local Players = game:GetService("Players")
			local Player = Players.LocalPlayer
			local BerryBush = CollectionService:GetTagged("BerryBush")
			local Distance, Nearest = math.huge
			for i = 1, # BerryBush do
				local Bush = BerryBush[i]
				for AttributeName, BerryName in pairs(Bush:GetAttributes()) do
					if not BerryArray or table.find(BerryArray, BerryName) then
						Tween(Bush.Parent:GetPivot())
						for i = 1, # BerryBush do
							local Bush = BerryBush[i]
							for AttributeName, BerryName in pairs(Bush:GetChildren()) do
								if not BerryArray or table.find(BerryArray, BerryName) then
									Tween(BerryName.WorldPivot)
									fireproximityprompt(BerryName.ProximityPrompt, math.huge)
								end
							end
						end
					end
				end
			end
		end
	end
end)
Tabs.Main:AddSection("Chest")
Toggle = Tabs.Main:AddToggle("Toggle", {
	Title = "Auto Farm Chest",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.Chest = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		if _G.Chest then
			pcall(function()
				local CollectionService = game:GetService("CollectionService")
				local Players = game:GetService("Players")
				local Player = Players.LocalPlayer
				local Character = Player.Character or Player.CharacterAdded:Wait()
				if not Character then
					return
				end
				local Position = Character:GetPivot().Position
				local Chests = CollectionService:GetTagged("_ChestTagged")
				local Distance, Nearest = math.huge, nil
				for i = 1, # Chests do
					local Chest = Chests[i]
					local Magnitude = (Chest:GetPivot().Position - Position).Magnitude
					if not SelectIsland or Chest:IsDescendantOf(SelectIsland) then
						if not Chest:GetAttribute("IsDisabled") and Magnitude < Distance then
							Distance = Magnitude
							Nearest = Chest
						end
					end
				end
				if Nearest then
					Tween(Nearest:GetPivot())
				end
			end)
		end
	end
end)
Toggle = Tabs.Main:AddToggle("Toggle", {
	Title = "Auto Stop Chest",
	Description = "Got When God's Chalice & Fist of Darkness",
	Default = true
})
Toggle:OnChanged(function(Value)
	_G.StopChest = Value
end)
spawn(function()
	while task.wait() do
		if _G.StopChest and _G.Chest then
			pcall(function()
				if GetBP("God's Chalice") or GetBP("Sweet Chalice") or GetBP("Fist of Darkness") then
					_G.Chest = false
				end
			end)
		end
	end
end)
Tabs.Main:AddSection("Elite Hunter")
Toggle = Tabs.Main:AddToggle("Toggle", {
	Title = "Auto Kill Elite Hunter",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.EliteHunter = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.EliteHunter then
				if game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible then
					if string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Diablo") or string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Urban") or string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Deandre") then
						for i, v in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do
							if string.find(v.Name, "Diablo") or string.find(v.Name, "Urban") or string.find(v.Name, "Deandre") then
								Tween(v.HumanoidRootPart.CFrame)
							end
						end
						for i, v in pairs(workspace.Enemies:GetChildren()) do
							if (string.find(v.Name, "Diablo") or string.find(v.Name, "Urban") or string.find(v.Name, "Deandre")) and Attack.Alive(v) then
								repeat
									wait()
									Attack.Kill(v, _G.EliteHunter)
								until not _G.EliteHunter or not game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible or not v.Parent or v.Humanoid.Health <= 0
							end
						end
					end
				else
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EliteHunter")
				end
			end
		end)
	end
end)
Toggle = Tabs.Main:AddToggle("Toggle", {
	Title = "Auto Stop Elite Hunter",
	Description = "Got When God's Chalice",
	Default = true
})
Toggle:OnChanged(function(Value)
	_G.StopEliteHunter = Value
end)
spawn(function()
	while task.wait() do
		if _G.StopEliteHunter and _G.EliteHunter then
			pcall(function()
				if GetBP("God's Chalice") or GetBP("Sweet Chalice") or GetBP("Fist of Darkness") then
					_G.EliteHunter = false
				end
			end)
		end
	end
end)
Tabs.Main:AddSection("Katakuri")
Toggle = Tabs.Main:AddToggle("Toggle", {
	Title = "Accept Quest",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.AcceptQuestC = Value
end)
Toggle = Tabs.Main:AddToggle("Toggle", {
	Title = "Auto Spawner",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.CakePrinceSpawner = Value
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.CakePrinceSpawner then
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner", true)
			end
		end)
	end
end)
Toggle = Tabs.Main:AddToggle("Toggle", {
	Title = "Auto Farm Cake Prince",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.CakePrince = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		if _G.CakePrince then
			pcall(function()
				local player = game.Players.LocalPlayer
				local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
				local questUI = player.PlayerGui.Main.Quest
				local enemies = workspace.Enemies
				local bigMirror = workspace.Map.CakeLoaf.BigMirror
				if not root then
					return
				end
				if not bigMirror:FindFirstChild("Other") then
					Tween(CFrame.new(-2077, 252, -12373))
				end
				if bigMirror.Other.Transparency == 0 or enemies:FindFirstChild("Cake Prince") then
					local v = GetConnectionEnemies("Cake Prince")
					if v then
						repeat
							wait()
							Attack.Kill2(v, _G.CakePrince)
						until not _G.CakePrince or not v.Parent or v.Humanoid.Health <= 0
					else
						if bigMirror.Other.Transparency == 0 and (CFrame.new(-1990.67, 4533, -14973.67).Position - root.Position).Magnitude >= 2000 then
							Tween(CFrame.new(-2151.82, 149.32, -12404.91))
						end
					end
				else
					local v = GetConnectionEnemies({"Cookie Crafter", "Cake Guard", "Baking Staff", "Head Baker"})
					if v then
						if _G.AcceptQuestC and not questUI.Visible then
							local questPos = CFrame.new(-1927.92, 37.8, -12842.54)
							Tween(questPos)
							while (questPos.Position - root.Position).Magnitude > 50 do
								wait(0.2)
							end
							local args = {
								[1] = {"StartQuest", "CakeQuest1", 1},
								[2] = {"StartQuest", "CakeQuest1", 2},
								[3] = {"StartQuest", "CakeQuest2", 1},
								[4] = {"StartQuest", "CakeQuest2", 2}
							}
							local success, response = pcall(function()
								return game.ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack(args[math.random(1, 4)]))
							end)
						end
						repeat
							wait()
							Attack.Kill(v, _G.CakePrince)
						until not _G.CakePrince or v.Humanoid.Health <= 0 or bigMirror.Other.Transparency == 0 or (_G.AcceptQuestC and not questUI.Visible)
					else
						Tween(CFrame.new(-2077, 252, -12373))
					end
				end
			end)
		end
	end
end)
Toggle = Tabs.Main:AddToggle("Toggle", {
	Title = "Auto Kill Dough King",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.DoughKing = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		if _G.DoughKing then
			pcall(function()
				local v = GetConnectionEnemies("Dough King")
				if v then
					repeat
						wait()
						Attack.Kill2(v, _G.DoughKing)
					until not _G.DoughKing or not v.Parent or v.Humanoid.Health <= 0
				else
					Tween(CFrame.new(-1943.676513671875, 251.5095672607422, -12337.880859375))
				end
			end)
		end
	end
end)
Tabs.Main:AddSection("Bone")
Toggle = Tabs.Main:AddToggle("Toggle", {
	Title = "Accept Quest",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.AcceptQuestB = Value
end)
Toggle = Tabs.Main:AddToggle("Toggle", {
	Title = "Auto Farm Bone",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.Bone = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		if _G.Bone then
			pcall(function()
				local player = game.Players.LocalPlayer
				local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
				local questUI = player.PlayerGui.Main.Quest
				if not root then
					return
				end
				local v = GetConnectionEnemies({"Reborn Skeleton", "Living Zombie", "Demonic Soul", "Posessed Mummy"})
				if v then
					if _G.AcceptQuestB and not questUI.Visible then
						local questPos = CFrame.new(-9516.99316, 172.017181, 6078.46533, 0, 0, -1, 0, 1, 0, 1, 0, 0)
						Tween(questPos)
						while (questPos.Position - root.Position).Magnitude > 50 do
							wait(0.2)
						end
						local args = {
							[1] = {"StartQuest", "HauntedQuest2", 2},
							[2] = {"StartQuest", "HauntedQuest2", 1},
							[3] = {"StartQuest", "HauntedQuest1", 1},
							[4] = {"StartQuest", "HauntedQuest1", 2}
						}
						local success, response = pcall(function()
							return game.ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack(args[math.random(1, 4)]))
						end)
					end
					repeat
						task.wait()
						Attack.Kill(v, _G.Bone)
					until not _G.Bone or v.Humanoid.Health <= 0 or not v.Parent or (_G.AcceptQuestB and not questUI.Visible)
				else
					Tween(CFrame.new(-9495.6806640625, 453.58624267578125, 5977.3486328125))
				end
			end)
		end
	end
end)
Toggle = Tabs.Main:AddToggle("Toggle", {
	Title = "Auto Random Bone",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.RandomBone = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.RandomBone then
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Bones", "Buy", 1, 1)
			end
		end)
	end
end)
Toggle = Tabs.Main:AddToggle("Toggle", {
	Title = "Auto Try Luck",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.TryLucky = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		if _G.TryLucky then
			local try_bones_luck = CFrame.new(-8761.3154296875, 164.85829162598, 6161.1567382813)
			if (game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame ~= try_bones_luck) then
				Tween(CFrame.new(-8761.3154296875, 164.85829162598, 6161.1567382813))
			elseif (game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame == try_bones_luck) then
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("gravestoneEvent", 1)
			end
		end
	end
end)
Toggle = Tabs.Main:AddToggle("Toggle", {
	Title = "Auto Praying",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.Praying = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		if _G.Praying then
			local try_bones_luck = CFrame.new(-8761.3154296875, 164.85829162598, 6161.1567382813)
			if (game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame ~= try_bones_luck) then
				Tween(CFrame.new(-8761.3154296875, 164.85829162598, 6161.1567382813))
			elseif (game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame == try_bones_luck) then
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("gravestoneEvent", 2)
			end
		end
	end
end)
Tabs.Main:AddSection("Observation")
Toggle = Tabs.Main:AddToggle("Toggle", {
	Title = "Auto Farm Observation",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.Observation = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.Observation then
				game:GetService("ReplicatedStorage").Remotes.CommE:FireServer("Ken", true)
				if game.Players.LocalPlayer:GetAttribute("KenDodgesLeft") == 0 then
					KenTest = false
				elseif game.Players.LocalPlayer:GetAttribute("KenDodgesLeft") > 0 then
					game:GetService("ReplicatedStorage").Remotes.CommE:FireServer("Ken", true)
					KenTest = true
				end
			end
		end)
	end
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.Observation then
				if World1 then
					if workspace.Enemies:FindFirstChild("Galley Captain") then
						if KenTest then
							repeat
								wait()
								game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Enemies:FindFirstChild("Galley Captain").HumanoidRootPart.CFrame * CFrame.new(3, 0, 0)
							until not _G.Observation or not KenTest
						else
							repeat
								wait()
								game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Enemies:FindFirstChild("Galley Captain").HumanoidRootPart.CFrame * CFrame.new(0, 50, 0)
							until not _G.Observation or KenTest
						end
					else
						Tween(CFrame.new(5533.29785, 88.1079102, 4852.3916))
					end
				elseif World2 then
					if workspace.Enemies:FindFirstChild("Lava Pirate") then
						if KenTest then
							repeat
								wait()
								game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Enemies:FindFirstChild("Lava Pirate").HumanoidRootPart.CFrame * CFrame.new(3, 0, 0)
							until not _G.Observation or not KenTest
						else
							repeat
								wait()
								game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Enemies:FindFirstChild("Lava Pirate").HumanoidRootPart.CFrame * CFrame.new(0, 50, 0)
							until not _G.Observation or KenTest
						end
					else
						Tween(CFrame.new(-5478.39209, 15.9775667, -5246.9126))
					end
				elseif World3 then
					if workspace.Enemies:FindFirstChild("Venomous Assailant") then
						if KenTest then
							repeat
								wait()
								Tween(workspace.Enemies:FindFirstChild("Venomous Assailant").HumanoidRootPart.CFrame * CFrame.new(3, 0, 0))
							until not _G.Observation or not KenTest
						else
							repeat
								wait()
								Tween(workspace.Enemies:FindFirstChild("Venomous Assailant").HumanoidRootPart.CFrame * CFrame.new(0, 50, 0))
							until not _G.Observation or KenTest
						end
					else
						Tween(CFrame.new(4530.3540039063, 656.75695800781, -131.60952758789))
					end
				end
			end
		end)
	end
end)
Tabs.Main:AddSection("Mastery")
ListMastery = {}
if World1 then
	ListMastery = {
		"Level",
		"Nearest"
	}
elseif World2 then
	ListMastery = {
		"Level",
		"Nearest"
	}
elseif World3 then
	ListMastery = {
		"Level",
		"Nearest",
		"Katakuri",
		"Bone"
	}
end
Dropdown = Tabs.Main:AddDropdown("Dropdown", {
	Title = "Select Farm",
	Values = ListMastery,
	Multi = false,
	Default = 1
})
Dropdown:OnChanged(function(Value)
	_G.SelectMastery = Value
end)
Toggle = Tabs.Main:AddToggle("Toggle", {
	Title = "Auto Farm Mastery Fruit",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.MasteryFruit = Value
	StopTween(Value)
end)
spawn(function()
	game:GetService("RunService").RenderStepped:Connect(function()
		pcall(function()
			if _G.MasteryFruit or _G.MasteryGun or _G.MasteryAllSword then
				for a, b in pairs(game.Players.LocalPlayer.PlayerGui.Notifications:GetChildren()) do
					if b.Name == "NotificationTemplate" then
						if string.find(b.Text, "Skill locked!") then
							b:Destroy()
						end
					end
				end
			end
		end)
	end)
end)
spawn(function()
	while task.wait() do
		if _G.MasteryFruit then
			pcall(function()
				if _G.SelectMastery == "Level" then
					CheckLevel()
					local QuestTitle = game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text
					if not string.find(QuestTitle, NameMon) then
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
					end
					if not game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible then
						Tween(CFrameQuest)
						if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - CFrameQuest.Position).Magnitude <= 5 then
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", NameQuest, LevelQuest)
						end
					elseif game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible then
						if workspace.Enemies:FindFirstChild(Mon) then
							for i, v in pairs(workspace.Enemies:GetChildren()) do
								if Attack.Alive(v) then
									if v.Name == Mon then
										if string.find(QuestTitle, NameMon) then
											HealthM = v.Humanoid.MaxHealth * 70 / 100
											repeat
												wait()
												MousePos = v.HumanoidRootPart.Position
												Attack.Mas(v, _G.MasteryFruit)
											until not _G.MasteryFruit or v.Humanoid.Health <= 0 or not v.Parent or not game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible
										else
											game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
										end
									end
								end
							end
						else
							Tween(CFrameMon)
							if game:GetService("ReplicatedStorage"):FindFirstChild(Mon) then
								Tween(game:GetService("ReplicatedStorage"):FindFirstChild(Mon).HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
							end
						end
					end
				elseif _G.SelectMastery == "Nearest" then
					for i, v in pairs(workspace.Enemies:GetChildren()) do
						if v:FindFirstChild("Humanoid") or v:FindFirstChild("HumanoidRootPart") then
							if v.Humanoid.Health > 0 then
								HealthM = v.Humanoid.MaxHealth * 70 / 100
								repeat
									wait()
									MousePos = v.HumanoidRootPart.Position
									Attack.Mas(v, _G.MasteryFruit)
								until not _G.MasteryFruit or not v.Parent or v.Humanoid.Health <= 0
							end
						end
					end
				elseif _G.SelectMastery == "Katakuri" then
					local player = game.Players.LocalPlayer
					local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
					local questUI = player.PlayerGui.Main.Quest
					local enemies = workspace.Enemies
					local bigMirror = workspace.Map.CakeLoaf.BigMirror
					if not root then
						return
					end
					if not bigMirror:FindFirstChild("Other") then
						Tween(CFrame.new(-2077, 252, -12373))
					end
					if bigMirror.Other.Transparency == 0 or enemies:FindFirstChild("Cake Prince") then
						local v = GetConnectionEnemies("Cake Prince")
						if v then
							HealthM = v.Humanoid.MaxHealth * 5 / 100
							repeat
								wait()
								MousePos = v.HumanoidRootPart.Position
								Attack.Mas(v, _G.MasteryFruit)
							until not _G.MasteryFruit or not v.Parent or v.Humanoid.Health <= 0
						else
							if bigMirror.Other.Transparency == 0 and (CFrame.new(-1990.67, 4533, -14973.67).Position - root.Position).Magnitude >= 2000 then
								Tween(CFrame.new(-2151.82, 149.32, -12404.91))
							end
						end
					else
						local v = GetConnectionEnemies({"Cookie Crafter", "Cake Guard", "Baking Staff", "Head Baker"})
						if v then
							if _G.AcceptQuestC and not questUI.Visible then
								local questPos = CFrame.new(-1927.92, 37.8, -12842.54)
								Tween(questPos)
								while (questPos.Position - root.Position).Magnitude > 50 do
									wait(0.2)
								end
								local args = {
									[1] = {"StartQuest", "CakeQuest1", 1},
									[2] = {"StartQuest", "CakeQuest1", 2},
									[3] = {"StartQuest", "CakeQuest2", 1},
									[4] = {"StartQuest", "CakeQuest2", 2}
								}
								local success, response = pcall(function()
									return game.ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack(args[math.random(1, 4)]))
								end)
							end
							HealthM = v.Humanoid.MaxHealth * 70 / 100
							repeat
								wait()
								MousePos = v.HumanoidRootPart.Position
								Attack.Mas(v, _G.MasteryFruit)
							until not _G.MasteryFruit or v.Humanoid.Health <= 0 or bigMirror.Other.Transparency == 0 or (_G.AcceptQuestC and not questUI.Visible)
						else
							Tween(CFrame.new(-2077, 252, -12373))
						end
					end
				elseif _G.SelectMastery == "Bone" then
					local player = game.Players.LocalPlayer
					local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
					local questUI = player.PlayerGui.Main.Quest
					if not root then
						return
					end
					local v = GetConnectionEnemies({"Reborn Skeleton", "Living Zombie", "Demonic Soul", "Posessed Mummy"})
					if v then
						if _G.AcceptQuestB and not questUI.Visible then
							local questPos = CFrame.new(-9516.99316, 172.017181, 6078.46533, 0, 0, -1, 0, 1, 0, 1, 0, 0)
							Tween(questPos)
							while (questPos.Position - root.Position).Magnitude > 50 do
								wait(0.2)
							end
							local args = {
								[1] = {"StartQuest", "HauntedQuest2", 2},
								[2] = {"StartQuest", "HauntedQuest2", 1},
								[3] = {"StartQuest", "HauntedQuest1", 1},
								[4] = {"StartQuest", "HauntedQuest1", 2}
							}
							local success, response = pcall(function()
								return game.ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack(args[math.random(1, 4)]))
							end)
						end
						HealthM = v.Humanoid.MaxHealth * 70 / 100
						repeat
							task.wait()
							MousePos = v.HumanoidRootPart.Position
							Attack.Mas(v, _G.MasteryFruit)
						until not _G.MasteryFruit or v.Humanoid.Health <= 0 or not v.Parent or (_G.AcceptQuestB and not questUI.Visible)
					else
						Tween(CFrame.new(-9495.6806640625, 453.58624267578125, 5977.3486328125))
					end
				end
			end)
		end
	end
end)
Toggle = Tabs.Main:AddToggle("Toggle", {
	Title = "Auto Farm Mastery Gun",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.MasteryGun = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		if _G.MasteryGun then
			pcall(function()
				if _G.SelectMastery == "Level" then
					CheckLevel()
					local QuestTitle = game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text
					if not string.find(QuestTitle, NameMon) then
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
					end
					if not game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible then
						Tween(CFrameQuest)
						if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - CFrameQuest.Position).Magnitude <= 5 then
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", NameQuest, LevelQuest)
						end
					elseif game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible then
						if workspace.Enemies:FindFirstChild(Mon) then
							for i, v in pairs(workspace.Enemies:GetChildren()) do
								if Attack.Alive(v) then
									if v.Name == Mon then
										if string.find(QuestTitle, NameMon) then
											HealthM = v.Humanoid.MaxHealth * 70 / 100
											repeat
												wait()
												MousePos = v.HumanoidRootPart.Position
												Attack.Masgun(v, _G.MasteryGun)
												local Modules = game:GetService("ReplicatedStorage"):FindFirstChild("Modules")
												local Net = Modules:FindFirstChild("Net")
												local RE_ShootGunEvent = Net:FindFirstChild("RE/ShootGunEvent")
												if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").ToolTip ~= "Gun" then
													return
												end
												if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Name == "Skull Guitar" then
													SoulGuitar = true
													game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").RemoteEvent:FireServer("TAP", MousePos)
													if _G.MasteryGun then
														game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, true, game, 1)
														wait(0.05)
														game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, false, game, 1)
														wait(0.05)
													end
												elseif game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Name ~= "Skull Guitar" then
													SoulGuitar = false
													RE_ShootGunEvent:FireServer(MousePos, {
														v.HumanoidRootPart
													})
													if _G.MasteryGun then
														game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, true, game, 1)
														wait(0.05)
														game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, false, game, 1)
														wait(0.05)
													end
												end
											until not _G.MasteryGun or v.Humanoid.Health <= 0 or not v.Parent or not game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible
											SoulGuitar = false
										else
											game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
										end
									end
								end
							end
						else
							Tween(CFrameMon)
							if game:GetService("ReplicatedStorage"):FindFirstChild(Mon) then
								Tween(game:GetService("ReplicatedStorage"):FindFirstChild(Mon).HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
							end
						end
					end
				elseif _G.SelectMastery == "Nearest" then
					for i, v in pairs(workspace.Enemies:GetChildren()) do
						if v:FindFirstChild("Humanoid") or v:FindFirstChild("HumanoidRootPart") then
							if v.Humanoid.Health > 0 then
								HealthM = v.Humanoid.MaxHealth * 70 / 100
								repeat
									wait()
									MousePos = v.HumanoidRootPart.Position
									Attack.Masgun(v, _G.MasteryGun)
									local Modules = game:GetService("ReplicatedStorage"):FindFirstChild("Modules")
									local Net = Modules:FindFirstChild("Net")
									local RE_ShootGunEvent = Net:FindFirstChild("RE/ShootGunEvent")
									if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").ToolTip ~= "Gun" then
										return
									end
									if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Name == "Skull Guitar" then
										SoulGuitar = true
										game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").RemoteEvent:FireServer("TAP", MousePos)
										if _G.MasteryGun then
											game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, true, game, 1)
											wait(0.05)
											game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, false, game, 1)
											wait(0.05)
										end
									elseif game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Name ~= "Skull Guitar" then
										SoulGuitar = false
										RE_ShootGunEvent:FireServer(MousePos, {
											v.HumanoidRootPart
										})
										if _G.MasteryGun then
											game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, true, game, 1)
											wait(0.05)
											game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, false, game, 1)
											wait(0.05)
										end
									end
								until not _G.MasteryGun or not v.Parent or v.Humanoid.Health <= 0
								SoulGuitar = false
							end
						end
					end
				elseif _G.SelectMastery == "Katakuri" then
					local player = game.Players.LocalPlayer
					local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
					local questUI = player.PlayerGui.Main.Quest
					local enemies = workspace.Enemies
					local bigMirror = workspace.Map.CakeLoaf.BigMirror
					if not root then
						return
					end
					if not bigMirror:FindFirstChild("Other") then
						Tween(CFrame.new(-2077, 252, -12373))
					end
					if bigMirror.Other.Transparency == 0 or enemies:FindFirstChild("Cake Prince") then
						local v = GetConnectionEnemies("Cake Prince")
						if v then
							HealthM = v.Humanoid.MaxHealth * 5 / 100
							repeat
								wait()
								MousePos = v.HumanoidRootPart.Position
								Attack.Mas(v, _G.MasteryGun)
								local Modules = game:GetService("ReplicatedStorage"):FindFirstChild("Modules")
								local Net = Modules:FindFirstChild("Net")
								local RE_ShootGunEvent = Net:FindFirstChild("RE/ShootGunEvent")
								if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").ToolTip ~= "Gun" then
									return
								end
								if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Name == "Skull Guitar" then
									SoulGuitar = true
									game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").RemoteEvent:FireServer("TAP", MousePos)
									if _G.MasteryGun then
										game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, true, game, 1)
										wait(0.05)
										game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, false, game, 1)
										wait(0.05)
									end
								elseif game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Name ~= "Skull Guitar" then
									SoulGuitar = false
									RE_ShootGunEvent:FireServer(MousePos, {
										v.HumanoidRootPart
									})
									if _G.MasteryGun then
										game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, true, game, 1)
										wait(0.05)
										game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, false, game, 1)
										wait(0.05)
									end
								end
							until not _G.MasteryGun or not v.Parent or v.Humanoid.Health <= 0
							SoulGuitar = false
						else
							if bigMirror.Other.Transparency == 0 and (CFrame.new(-1990.67, 4533, -14973.67).Position - root.Position).Magnitude >= 2000 then
								Tween(CFrame.new(-2151.82, 149.32, -12404.91))
							end
						end
					else
						local v = GetConnectionEnemies({"Cookie Crafter", "Cake Guard", "Baking Staff", "Head Baker"})
						if v then
							if _G.AcceptQuestC and not questUI.Visible then
								local questPos = CFrame.new(-1927.92, 37.8, -12842.54)
								Tween(questPos)
								while (questPos.Position - root.Position).Magnitude > 50 do
									wait(0.2)
								end
								local args = {
									[1] = {"StartQuest", "CakeQuest1", 1},
									[2] = {"StartQuest", "CakeQuest1", 2},
									[3] = {"StartQuest", "CakeQuest2", 1},
									[4] = {"StartQuest", "CakeQuest2", 2}
								}
								local success, response = pcall(function()
									return game.ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack(args[math.random(1, 4)]))
								end)
							end
							HealthM = v.Humanoid.MaxHealth * 70 / 100
							repeat
								wait()
								MousePos = v.HumanoidRootPart.Position
								Attack.Masgun(v, _G.MasteryGun)
								local Modules = game:GetService("ReplicatedStorage"):FindFirstChild("Modules")
								local Net = Modules:FindFirstChild("Net")
								local RE_ShootGunEvent = Net:FindFirstChild("RE/ShootGunEvent")
								if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").ToolTip ~= "Gun" then
									return
								end
								if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Name == "Skull Guitar" then
									SoulGuitar = true
									game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").RemoteEvent:FireServer("TAP", MousePos)
									if _G.MasteryGun then
										game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, true, game, 1)
										wait(0.05)
										game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, false, game, 1)
										wait(0.05)
									end
								elseif game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Name ~= "Skull Guitar" then
									SoulGuitar = false
									RE_ShootGunEvent:FireServer(MousePos, {
										v.HumanoidRootPart
									})
									if _G.MasteryGun then
										game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, true, game, 1)
										wait(0.05)
										game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, false, game, 1)
										wait(0.05)
									end
								end
							until not _G.MasteryGun or v.Humanoid.Health <= 0 or bigMirror.Other.Transparency == 0 or (_G.AcceptQuestC and not questUI.Visible)
							SoulGuitar = false
						else
							Tween(CFrame.new(-2077, 252, -12373))
						end
					end
				elseif _G.SelectMastery == "Bone" then
					local player = game.Players.LocalPlayer
					local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
					local questUI = player.PlayerGui.Main.Quest
					if not root then
						return
					end
					local v = GetConnectionEnemies({"Reborn Skeleton", "Living Zombie", "Demonic Soul", "Posessed Mummy"})
					if v then
						if _G.AcceptQuestB and not questUI.Visible then
							local questPos = CFrame.new(-9516.99316, 172.017181, 6078.46533, 0, 0, -1, 0, 1, 0, 1, 0, 0)
							Tween(questPos)
							while (questPos.Position - root.Position).Magnitude > 50 do
								wait(0.2)
							end
							local args = {
								[1] = {"StartQuest", "HauntedQuest2", 2},
								[2] = {"StartQuest", "HauntedQuest2", 1},
								[3] = {"StartQuest", "HauntedQuest1", 1},
								[4] = {"StartQuest", "HauntedQuest1", 2}
							}
							local success, response = pcall(function()
								return game.ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack(args[math.random(1, 4)]))
							end)
						end
						HealthM = v.Humanoid.MaxHealth * 70 / 100
						repeat
							task.wait()
							MousePos = v.HumanoidRootPart.Position
							Attack.Masgun(v, _G.MasteryGun)
							local Modules = game:GetService("ReplicatedStorage"):FindFirstChild("Modules")
							local Net = Modules:FindFirstChild("Net")
							local RE_ShootGunEvent = Net:FindFirstChild("RE/ShootGunEvent")
							if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").ToolTip ~= "Gun" then
								return
							end
							if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Name == "Skull Guitar" then
								SoulGuitar = true
								game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").RemoteEvent:FireServer("TAP", MousePos)
								if _G.MasteryGun then
									game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, true, game, 1)
									wait(0.05)
									game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, false, game, 1)
									wait(0.05)
								end
							elseif game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Name ~= "Skull Guitar" then
								SoulGuitar = false
								RE_ShootGunEvent:FireServer(MousePos, {
									v.HumanoidRootPart
								})
								if _G.MasteryGun then
									game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, true, game, 1)
									wait(0.05)
									game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, false, game, 1)
									wait(0.05)
								end
							end
						until not _G.MasteryGun or v.Humanoid.Health <= 0 or not v.Parent or (_G.AcceptQuestB and not questUI.Visible)
						SoulGuitar = false
					else
						Tween(CFrame.new(-9495.6806640625, 453.58624267578125, 5977.3486328125))
					end
				end
			end)
		end
	end
end)
Toggle = Tabs.Main:AddToggle("Toggle", {
	Title = "Auto Farm Mastery All Sword",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.MasteryAllSword = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		if _G.MasteryAllSword then
			pcall(function()
				if _G.SelectMastery == "Level" then
					CheckLevel()
					local QuestTitle = game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text
					if not string.find(QuestTitle, NameMon) then
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
					end
					if not game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible then
						Tween(CFrameQuest)
						if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - CFrameQuest.Position).Magnitude <= 5 then
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", NameQuest, LevelQuest)
						end
					elseif game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible then
						if workspace.Enemies:FindFirstChild(Mon) then
							for i, v in pairs(workspace.Enemies:GetChildren()) do
								if Attack.Alive(v) then
									if v.Name == Mon then
										if string.find(QuestTitle, NameMon) then
											repeat
												wait()
												Attack.Sword(v, _G.MasteryAllSword)
											until not _G.MasteryAllSword or v.Humanoid.Health <= 0 or not v.Parent or not game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible
										else
											game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
										end
									end
								end
							end
						else
							Tween(CFrameMon)
							if game:GetService("ReplicatedStorage"):FindFirstChild(Mon) then
								Tween(game:GetService("ReplicatedStorage"):FindFirstChild(Mon).HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
							end
						end
					end
				elseif _G.SelectMastery == "Nearest" then
					for i, v in pairs(workspace.Enemies:GetChildren()) do
						if v:FindFirstChild("Humanoid") or v:FindFirstChild("HumanoidRootPart") then
							if v.Humanoid.Health > 0 then
								repeat
									wait()
									Attack.Sword(v, _G.MasteryAllSword)
								until not _G.MasteryAllSword or not v.Parent or v.Humanoid.Health <= 0
							end
						end
					end
				elseif _G.SelectMastery == "Katakuri" then
					local player = game.Players.LocalPlayer
					local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
					local questUI = player.PlayerGui.Main.Quest
					local enemies = workspace.Enemies
					local bigMirror = workspace.Map.CakeLoaf.BigMirror
					if not root then
						return
					end
					if not bigMirror:FindFirstChild("Other") then
						Tween(CFrame.new(-2077, 252, -12373))
					end
					if bigMirror.Other.Transparency == 0 or enemies:FindFirstChild("Cake Prince") then
						local v = GetConnectionEnemies("Cake Prince")
						if v then
							repeat
								wait()
								Attack.Sword(v, _G.MasteryAllSword)
							until not _G.MasteryAllSword or not v.Parent or v.Humanoid.Health <= 0
						else
							if bigMirror.Other.Transparency == 0 and (CFrame.new(-1990.67, 4533, -14973.67).Position - root.Position).Magnitude >= 2000 then
								Tween(CFrame.new(-2151.82, 149.32, -12404.91))
							end
						end
					else
						local v = GetConnectionEnemies({"Cookie Crafter", "Cake Guard", "Baking Staff", "Head Baker"})
						if v then
							if _G.AcceptQuestC and not questUI.Visible then
								local questPos = CFrame.new(-1927.92, 37.8, -12842.54)
								Tween(questPos)
								while (questPos.Position - root.Position).Magnitude > 50 do
									wait(0.2)
								end
								local args = {
									[1] = {"StartQuest", "CakeQuest1", 1},
									[2] = {"StartQuest", "CakeQuest1", 2},
									[3] = {"StartQuest", "CakeQuest2", 1},
									[4] = {"StartQuest", "CakeQuest2", 2}
								}
								local success, response = pcall(function()
									return game.ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack(args[math.random(1, 4)]))
								end)
							end
							repeat
								wait()
								Attack.Sword(v, _G.MasteryAllSword)
							until not _G.MasteryAllSword or v.Humanoid.Health <= 0 or bigMirror.Other.Transparency == 0 or (_G.AcceptQuestC and not questUI.Visible)
						else
							Tween(CFrame.new(-2077, 252, -12373))
						end
					end
				elseif _G.SelectMastery == "Bone" then
					local player = game.Players.LocalPlayer
					local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
					local questUI = player.PlayerGui.Main.Quest
					if not root then
						return
					end
					local v = GetConnectionEnemies({"Reborn Skeleton", "Living Zombie", "Demonic Soul", "Posessed Mummy"})
					if v then
						if _G.AcceptQuestB and not questUI.Visible then
							local questPos = CFrame.new(-9516.99316, 172.017181, 6078.46533, 0, 0, -1, 0, 1, 0, 1, 0, 0)
							Tween(questPos)
							while (questPos.Position - root.Position).Magnitude > 50 do
								wait(0.2)
							end
							local args = {
								[1] = {"StartQuest", "HauntedQuest2", 2},
								[2] = {"StartQuest", "HauntedQuest2", 1},
								[3] = {"StartQuest", "HauntedQuest1", 1},
								[4] = {"StartQuest", "HauntedQuest1", 2}
							}
							local success, response = pcall(function()
								return game.ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack(args[math.random(1, 4)]))
							end)
						end
						repeat
							task.wait()
							Attack.Sword(v, _G.MasteryAllSword)
						until not _G.MasteryAllSword or v.Humanoid.Health <= 0 or not v.Parent or (_G.AcceptQuestB and not questUI.Visible)
					else
						Tween(CFrame.new(-9495.6806640625, 453.58624267578125, 5977.3486328125))
					end
				end
			end)
		end
	end
end)
Tabs.Main:AddSection("Setting Mastery")
Dropdown = Tabs.Main:AddDropdown("Dropdown", {
	Title = "Select Skill",
	Values = {"Z", "X", "C", "V", "F"},
	Multi = true,
	Default = {"Z", "X", "C"}
})
Dropdown:OnChanged(function(Value)
	_G.SelectSkill = Value
end)
Slider = Tabs.Main:AddSlider("Slider", {
	Title = "Hold Z",
	Default = 0.5,
	Min = 0,
	Max = 10,
	Rounding = 1,
	Callback = function(Value)
		_G.HoldZ = Value
	end
})
Slider = Tabs.Main:AddSlider("Slider", {
	Title = "Hold X",
	Default = 0.5,
	Min = 0,
	Max = 10,
	Rounding = 1,
	Callback = function(Value)
		_G.HoldX = Value
	end
})
Slider = Tabs.Main:AddSlider("Slider", {
	Title = "Hold C",
	Default = 0.5,
	Min = 0,
	Max = 10,
	Rounding = 1,
	Callback = function(Value)
		_G.HoldC = Value
	end
})
Slider = Tabs.Main:AddSlider("Slider", {
	Title = "Hold V",
	Default = 0.5,
	Min = 0,
	Max = 10,
	Rounding = 1,
	Callback = function(Value)
		_G.HoldV = Value
	end
})
Slider = Tabs.Main:AddSlider("Slider", {
	Title = "Hold F",
	Default = 0.5,
	Min = 0,
	Max = 10,
	Rounding = 1,
	Callback = function(Value)
		_G.HoldF = Value
	end
})
Tabs.Items:AddSection("World")
Toggle = Tabs.Items:AddToggle("Toggle", {
	Title = "Auto Second Sea",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.SecondSea = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.SecondSea then
				if game.Players.LocalPlayer.Data.Level.Value >= 700 then
					if workspace.Map.Ice.Door.CanCollide and workspace.Map.Ice.Door.Transparency == 0 then
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("DressrosaQuestProgress", "Detective")
						EquipWeapon("Key")
						repeat
							wait()
							Tween(CFrame.new(1347.7124, 37.3751602, -1325.6488))
						until not _G.SecondSea or (game.Players.LocalPlayer.Character.HumanoidRootPart.Position == CFrame.new(1347.7124, 37.3751602, -1325.6488).Position)
					elseif not workspace.Map.Ice.Door.CanCollide and workspace.Map.Ice.Door.Transparency == 1 then
						if workspace.Enemies:FindFirstChild("Ice Admiral") then
							for _, xz in pairs(workspace.Enemies:GetChildren()) do
								if xz.Name == "Ice Admiral" and Attack.Alive(xz) then
									repeat
										task.wait()
										Attack.Kill(xz, _G.SecondSea)
									until not _G.SecondSea or xz.Humanoid.Health <= 0
									game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa")
								end
							end
						else
							Tween(CFrame.new(1347.7124, 37.3751602, -1325.6488))
						end
					else
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa")
					end
				end
			end
		end)
	end
end)
Toggle = Tabs.Items:AddToggle("Toggle", {
	Title = "Auto Third Sea",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.ThirdSea = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.ThirdSea then
				if game.Players.LocalPlayer.Data.Level.Value >= 1500 then
					if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress", "Bartilo") == 3 then
						if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GetUnlockables").FlamingoAccess ~= nil then
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("F_", "TravelZou")
							if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ZQuestProgress", "Check") == 0 then
								local v = GetConnectionEnemies("rip_indra")
								if v then
									repeat
										wait()
										Attack.Kill(v, _G.ThirdSea)
									until not _G.ThirdSea or not v.Parent or v.Humanoid.Health <= 0
									Check = 2
									repeat
										wait()
										game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("F_", "TravelZou")
									until Check == 1
								else
									game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("F_", "ZQuestProgress", "Check")
									wait(0.1)
									game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("F_", "ZQuestProgress", "Begin")
								end
							elseif game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("ZQuestProgress", "Check") == 1 then
								game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("F_", "TravelZou")
							else
								local v = GetConnectionEnemies("Don Swan")
								if v then
									repeat
										wait()
										Attack.Kill(v, _G.ThirdSea)
									until not _G.ThirdSea or not v.Parent or v.Humanoid.Health <= 0
								else
									repeat
										wait()
										Tween(CFrame.new(2288.802, 15.1870775, 863.034607))
									until not _G.ThirdSea or (game.Players.LocalPlayer.Character.HumanoidRootPart.Position == CFrame.new(2288.802, 15.1870775, 863.034607).Position)
									if (game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame == CFrame.new(2288.802, 15.1870775, 863.034607)) then
										TP(CFrame.new(2288.802, 15.1870775, 863.034607))
									end
								end
							end
						else
							if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GetUnlockables").FlamingoAccess == nil then
								TabelDevilFruitStore = {}
								TabelDevilFruitOpen = {}
								for i, v in pairs(game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("getInventoryFruits")) do
									for i1, v1 in pairs(v) do
										if i1 == "Name" then
											table.insert(TabelDevilFruitStore, v1)
										end
									end
								end
								for i, v in next, game.ReplicatedStorage:WaitForChild("Remotes").CommF_:InvokeServer("GetFruits") do
									if v.Price >= 1000000 then
										table.insert(TabelDevilFruitOpen, v.Name)
									end
								end
								for i, DevilFruitOpenDoor in pairs(TabelDevilFruitOpen) do
									for i1, DevilFruitStore in pairs(TabelDevilFruitStore) do
										if DevilFruitOpenDoor == DevilFruitStore and game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GetUnlockables").FlamingoAccess == nil then
											if not game.Players.LocalPlayer.Backpack:FindFirstChild(DevilFruitStore) then
												game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("F_", "LoadFruit", DevilFruitStore)
											else
												game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("F_", "TalkTrevor", "1")
												game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("F_", "TalkTrevor", "2")
												game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("F_", "TalkTrevor", "3")
											end
										end
									end
								end
								game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("F_", "TalkTrevor", "1")
								game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("F_", "TalkTrevor", "2")
								game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("F_", "TalkTrevor", "3")
							end
						end
					else
						if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress", "Bartilo") == 0 then
							if string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Swan Pirates") and string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "50") and game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible then
								local v = GetConnectionEnemies("Swan Pirate")
								if v then
									pcall(function()
										repeat
											wait()
											Attack.Kill(v, _G.ThirdSea)
										until not v.Parent or v.Humanoid.Health <= 0 or not _G.ThirdSea or not game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible
									end)
								else
									Tween(CFrame.new(1057.92761, 137.614319, 1242.08069))
								end
							else
								Tween(CFrame.new(-456.28952, 73.0200958, 299.895966))
							end
						elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress", "Bartilo") == 1 then
							local v = GetConnectionEnemies("Jeremy")
							if v then
								repeat
									wait()
									Attack.Kill(v, _G.ThirdSea)
								until not v.Parent or v.Humanoid.Health <= 0 or not _G.ThirdSea
							else
								Tween(CFrame.new(2099.88159, 448.931, 648.997375))
							end
						elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress", "Bartilo") == 2 then
							repeat
								wait()
								Tween(CFrame.new(-1836, 11, 1714))
							until not _G.ThirdSea or (game.Players.LocalPlayer.Character.HumanoidRootPart.Position == CFrame.new(-1836, 11, 1714).Position)
							if (game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame == CFrame.new(-1836, 11, 1714)) then
								TP(CFrame.new(-1836, 11, 1714))
							end
							TP(CFrame.new(-1850.49329, 13.1789551, 1750.89685))
							wait(0.1)
							TP(CFrame.new(-1858.87305, 19.3777466, 1712.01807))
							wait(0.1)
							TP(CFrame.new(-1803.94324, 16.5789185, 1750.89685))
							wait(0.1)
							TP(CFrame.new(-1858.55835, 16.8604317, 1724.79541))
							wait(0.1)
							TP(CFrame.new(-1869.54224, 15.987854, 1681.00659))
							wait(0.1)
							TP(CFrame.new(-1800.0979, 16.4978027, 1684.52368))
							wait(0.1)
							TP(CFrame.new(-1819.26343, 14.795166, 1717.90625))
							wait(0.1)
							TP(CFrame.new(-1813.51843, 14.8604736, 1724.79541))
						end
					end
				end
			end
		end)
	end
end)
Tabs.Items:AddSection("Fighting Style")
Toggle = Tabs.Items:AddToggle("Toggle", {
	Title = "Auto Superhuman",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.Superhuman = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.Superhuman then
				local M_Beli = game.Players.LocalPlayer.Data.Beli.Value
				local M_Frag = game.Players.LocalPlayer.Data.Fragments.Value
				if game.Players.LocalPlayer:FindFirstChild("WeaponAssetCache") then
					if not GetBP("Superhuman") then
						if not GetBP("Black Leg") then
							if (M_Beli >= 150000) then
								game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBlackLeg")
							end
						elseif GetBP("Black Leg") and GetBP("Black Leg").Level.Value < 299 then
							_G.Level = true
						elseif GetBP("Black Leg") and GetBP("Black Leg").Level.Value >= 300 then
							_G.Level = false
						end
						if not GetBP("Electro") then
							if (M_Beli >= 500000) then
								game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectro")
							end
						elseif GetBP("Electro") and GetBP("Electro").Level.Value < 299 then
							_G.Level = true
						elseif GetBP("Electro") and GetBP("Electro").Level.Value >= 300 then
							_G.Level = false
						end
						if not GetBP("Fishman Karate") then
							if (M_Beli >= 750000) then
								game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyFishmanKarate")
							end
						elseif GetBP("Fishman Karate") and GetBP("Fishman Karate").Level.Value < 299 then
							_G.Level = true
						elseif GetBP("Fishman Karate") and GetBP("Fishman Karate").Level.Value >= 300 then
							_G.Level = false
						end
						if not GetBP("Dragon Claw") then
							if (M_Frag >= 1500) then
								game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "DragonClaw", "2")
							end
						elseif GetBP("Dragon Claw") and GetBP("Dragon Claw").Level.Value < 299 then
							_G.Level = true
						elseif GetBP("Dragon Claw") and GetBP("Dragon Claw").Level.Value >= 300 then
							_G.Level = false
						end
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySuperhuman")
					end
				end
			end
		end)
	end
end)
Toggle = Tabs.Items:AddToggle("Toggle", {
	Title = "Auto Death Step",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.DeathStep = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		if _G.DeathStep then
			pcall(function()
				if game.Players.LocalPlayer:FindFirstChild("WeaponAssetCache") then
					if not GetBP("Death Step") then
						if not GetBP("Black Leg") then
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBlackLeg")
						end
						if GetBP("Black Leg") and GetBP("Black Leg").Level.Value >= 400 then
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDeathStep")
							_G.Level = false
						elseif GetBP("Black Leg") and GetBP("Black Leg").Level.Value < 399 then
							_G.Level = true
						end
						if GetBP("Black Leg") or GetBP("Black Leg").Level.Value >= 400 then
							if workspace.Map.IceCastle.Hall.LibraryDoor.PhoeyuDoor.Transparency == 0 then
								if GetBP("Library Key") then
									repeat
										wait()
										Tween(CFrame.new(6371.2001953125, 296.63433837890625, -6841.18115234375))
									until not _G.DeathStep or (game.Players.LocalPlayer.Character.HumanoidRootPart.Position == CFrame.new(6371.2001953125, 296.63433837890625, -6841.18115234375).Position)
									if (game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame == CFrame.new(6371.2001953125, 296.63433837890625, -6841.18115234375)) then
										game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDeathStep")
									end
								elseif not GetBP("Library Key") then
									local v = GetConnectionEnemies("Awakened Ice Admiral")
									if v then
										repeat
											wait()
											Attack.Kill(v, _G.DeathStep)
										until not v.Parent or v.Humanoid.Health <= 0 or not _G.DeathStep or GetBP("Library Key") or GetBP("Death Step")
									else
										Tween(CFrame.new(5668.9780273438, 28.519989013672, -6483.3520507813))
									end
								end
							end
						end
					end
				end
			end)
		end
	end
end)
Toggle = Tabs.Items:AddToggle("Toggle", {
	Title = "Auto Sharkman Karate",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.SharkmanKarate = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		if _G.SharkmanKarate then
			pcall(function()
				if game.Players.LocalPlayer:FindFirstChild("WeaponAssetCache") then
					if not GetBP("Sharkman Karate") then
						if not GetBP("Fishman Karate") then
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyFishmanKarate")
						end
						if GetBP("Fishman Karate") and GetBP("Fishman Karate").Level.Value >= 400 then
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkmanKarate")
							_G.Level = false
						elseif GetBP("Fishman Karate") and GetBP("Fishman Karate").Level.Value < 399 then
							_G.Level = true
						end
						if GetBP("Fishman Karate") or GetBP("Fishman Karate").Level.Value >= 400 then
							if GetBP("Water Key") then
								if string.find(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkmanKarate"), "keys") then
									if GetBP("Water Key") then
										repeat
											wait()
											Tween(CFrame.new(-2604.6958, 239.432526, -10315.1982, 0.0425701365, 0, -0.999093413, 0, 1, 0, 0.999093413, 0, 0.0425701365))
										until not _G.SharkmanKarate or (game.Players.LocalPlayer.Character.HumanoidRootPart.Position == CFrame.new(-2604.6958, 239.432526, -10315.1982, 0.0425701365, 0, -0.999093413, 0, 1, 0, 0.999093413, 0, 0.0425701365).Position)
										game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkmanKarate")
									end
								end
							elseif not GetBP("Water Key") then
								local v = GetConnectionEnemies("Tide Keeper")
								if v then
									repeat
										wait()
										Attack.Kill(v, _G.SharkmanKarate)
									until not v.Parent or v.Humanoid.Health <= 0 or not _G.SharkmanKarate or GetBP("Water Key") or GetBP("Sharkman Karate")
								else
									Tween(CFrame.new(-3053.9814453125, 237.18954467773, -10145.0390625))
								end
							end
						end
					end
				end
			end)
		end
	end
end)
Toggle = Tabs.Items:AddToggle("Toggle", {
	Title = "Auto Electric Claw",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.ElectricClaw = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		if _G.ElectricClaw then
			pcall(function()
				if game.Players.LocalPlayer:FindFirstChild("WeaponAssetCache") then
					if not GetBP("Electro") then
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectro")
					end
					if GetBP("Electro") and GetBP("Electro").Level.Value >= 400 then
						if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectricClaw", "Start") == nil then
							TP(CFrame.new(-12548, 337, -7481))
						end
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectricClaw")
					elseif GetBP("Electro") and GetBP("Electro").Level.Value < 400 then
						repeat
							_G.Bone = true
							wait()
						until not _G.ElectricClaw or GetBP("Electric Claw")
						_G.Bone = false
					end
				end
			end)
		end
	end
end)
Toggle = Tabs.Items:AddToggle("Toggle", {
	Title = "Auto Dragon Talon",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.DragonTalon = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		if _G.DragonTalon then
			pcall(function()
				if game.Players.LocalPlayer:FindFirstChild("WeaponAssetCache") then
					if not GetBP("Dragon Claw") then
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "DragonClaw", "2")
					end
					if GetBP("Dragon Claw") and GetBP("Dragon Claw").Level.Value >= 400 then
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Bones", "Buy", 1, 1)
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDragonTalon")
					elseif GetBP("Dragon Claw") and GetBP("Dragon Claw").Level.Value < 400 then
						repeat
							_G.Bone = true
							wait()
						until not _G.DragonTalon or GetBP("Dragon Talon")
						_G.Bone = false
					end
				end
			end)
		end
	end
end)
Toggle = Tabs.Items:AddToggle("Toggle", {
	Title = "Auto Godhuman",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.Godhuman = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.GodHuman then
				if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyGodhuman", true) == "Bring me 20 Fish Tails, 20 Magma Ore, 10 Dragon Scales and 10 Mystic Droplets." then
					if not GetM("Dragon Scale") or GetM("Dragon Scale") < 10 then
						if World3 then
							game.Players.LocalPlayer.Data.Level.Value = 1575
							_G.Level = true
						else
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelZou")
						end
					elseif not GetM("Fish Tail") or GetM("Fish Tail") < 20 then
						if World3 then
							game.Players.LocalPlayer.Data.Level.Value = 1775
							_G.Level = true
						else
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelZou")
						end
					elseif not GetM("Mystic Droplet") or GetM("Mystic Droplet") < 10 then
						if World2 then
							game.Players.LocalPlayer.Data.Level.Value = 1425
							_G.Level = true
						else
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa")
						end
					elseif not GetM("Magma Ore") or GetM("Magma Ore") < 20 then
						if World2 then
							game.Players.LocalPlayer.Data.Level.Value = 1175
							_G.Level = true
						else
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa")
						end
					end
				elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyGodhuman", true) == 3 then
					return nil
				else
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyGodhuman")
				end
			end
		end)
	end
end)
Toggle = Tabs.Items:AddToggle("Toggle", {
	Title = "Auto Sanguine Art",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.SanguineArt = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		if _G.SanguineArt then
			pcall(function()
				if not GetBP("Sanguine Art") then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Sanguine Art")
				end
				if not GetBP("Sanguine Art") then
					if GetM("Leviathan Heart") >= 1 then
					else
						if World3 then
							_G.SelectZone = "Lv Infinite"
							_G.SailBoat = true
						else
							_G.SailBoat = false
						end
					end
					if GetM("Vampire Fang") <= 19 then
						if World2 then
							local n = GetConnectionEnemies("Vampire")
							if n then
								repeat
									task.wait()
									Attack.Kill(n, _G.SanguineArt)
								until not _G.SanguineArt or n.Humanoid.Health <= 0 or not n.Parent
							else
								Tween(CFrame.new(-6041.29248046875, 6.402710914611816, -1304.63330078125))
							end
						else
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa")
						end
					end
					if GetM("Vampire Fang") >= 20 and GetM("Demonic Wisp") <= 19 then
						if World3 then
							local n = GetConnectionEnemies("Demonic Soul")
							if n then
								repeat
									task.wait()
									Attack.Kill(n, _G.SanguineArt)
								until not _G.SanguineArt or n.Humanoid.Health <= 0 or not n.Parent
							else
								Tween(CFrame.new(-9495.6806640625, 453.58624267578125, 5977.3486328125))
							end
						else
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelZou")
						end
					end
					if GetM("Vampire Fang") >= 20 and GetM("Demonic Wisp") >= 20 and GetM("Dark Fragment") <= 1 then
						if World2 then
							local n = GetConnectionEnemies("Darkbeard")
							if n then
								repeat
									task.wait()
									Attack.Kill(black, _G.SanguineArt)
								until _G.SanguineArt or black.Humanoid.Health <= 0 or not black.Parent
							else
								Tween(CFrame.new(3798.4575195313, 13.826690673828, -3399.806640625))
							end
						else
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa")
						end
					end
				else
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySanguineArt")
				end
			end)
		end
	end
end)
Tabs.Items:AddSection("Items And Quest")
Toggle = Tabs.Items:AddToggle("Toggle", {
	Title = "Auto Saber Sword",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.Saber = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.Saber and game.Players.LocalPlayer.Data.Level.Value >= 200 and not game.Players.LocalPlayer.Backpack:FindFirstChild("Saber") and not game.Players.LocalPlayer.Character:FindFirstChild("Saber") then
				if workspace.Map.Jungle.Final.Part.Transparency == 0 then
					if workspace.Map.Jungle.QuestPlates.Door.Transparency == 0 then
						if (CFrame.new(-1612.55884, 36.9774132, 148.719543, 0.37091279, 3.0717151e-09, -0.928667724, 3.97099491e-08, 1, 1.91679348e-08, 0.928667724, -4.39869794e-08, 0.37091279).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 100 then
							Tween(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
							wait(0.5)
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Map.Jungle.QuestPlates.Plate1.Button.CFrame
							wait(0.5)
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Map.Jungle.QuestPlates.Plate2.Button.CFrame
							wait(0.5)
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Map.Jungle.QuestPlates.Plate3.Button.CFrame
							wait(0.5)
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Map.Jungle.QuestPlates.Plate4.Button.CFrame
							wait(0.5)
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Map.Jungle.QuestPlates.Plate5.Button.CFrame
							wait(0.5)
						else
							Tween(CFrame.new(-1612.55884, 36.9774132, 148.719543, 0.37091279, 3.0717151e-09, -0.928667724, 3.97099491e-08, 1, 1.91679348e-08, 0.928667724, -4.39869794e-08, 0.37091279))
						end
					else
						if workspace.Map.Desert.Burn.Part.Transparency == 0 then
							if game.Players.LocalPlayer.Backpack:FindFirstChild("Torch") or game.Players.LocalPlayer.Character:FindFirstChild("Torch") then
								EquipWeapon("Torch")
								firetouchinterest(game.Players.LocalPlayer.Character.Torch.Handle, workspace.Map.Desert.Burn.Fire, 0)
								firetouchinterest(game.Players.LocalPlayer.Character.Torch.Handle, workspace.Map.Desert.Burn.Fire, 1)
								Tween(CFrame.new(1114.61475, 5.04679728, 4350.22803, -0.648466587, -1.28799094e-09, 0.761243105, -5.70652914e-10, 1, 1.20584542e-09, -0.761243105, 3.47544882e-10, -0.648466587))
							else
								Tween(CFrame.new(-1610.00757, 11.5049858, 164.001587, 0.984807551, -0.167722285, -0.0449818149, 0.17364943, 0.951244235, 0.254912198, 3.42372805e-05, -0.258850515, 0.965917408))
							end
						else
							if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress", "SickMan") ~= 0 then
								game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress", "GetCup")
								wait(0.5)
								EquipWeapon("Cup")
								wait(0.5)
								game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress", "FillCup", game.Players.LocalPlayer.Character.Cup)
								wait(0.2)
								game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress", "SickMan")
							else
								if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress", "RichSon") == nil then
									game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress", "RichSon")
								elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress", "RichSon") == 0 then
									if workspace.Enemies:FindFirstChild("Mob Leader") or game:GetService("ReplicatedStorage"):FindFirstChild("Mob Leader") then
										Tween(CFrame.new(-2967.59521, -4.91089821, 5328.70703, 0.342208564, -0.0227849055, 0.939347804, 0.0251603816, 0.999569714, 0.0150796166, -0.939287126, 0.0184739735, 0.342634559))
										for i, v in pairs(workspace.Enemies:GetChildren()) do
											if v.Name == "Mob Leader" and Attack.Alive(v) then
												repeat
													task.wait()
													Attack.Kill(v, _G.Saber)
												until v.Humanoid.Health <= 0 or not _G.Saber
											end
										end
									end
								elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress", "RichSon") == 1 then
									game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress", "RichSon")
									EquipWeapon("Relic")
									Tween(CFrame.new(-1404.91504, 29.9773273, 3.80598116, 0.876514494, 5.66906877e-09, 0.481375456, 2.53851997e-08, 1, -5.79995607e-08, -0.481375456, 6.30572643e-08, 0.876514494))
								end
							end
						end
					end
				else
					if workspace.Enemies:FindFirstChild("Saber Expert") or game:GetService("ReplicatedStorage"):FindFirstChild("Saber Expert") then
						for _, v in pairs(workspace.Enemies:GetChildren()) do
							if v.Name == "Saber Expert" and Attack.Alive(v) then
								repeat
									task.wait()
									Attack.Kill(v, _G.Saber)
								until v.Humanoid.Health <= 0 or not _G.Saber
								if v.Humanoid.Health <= 0 then
									game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress", "PlaceRelic")
								end
							end
						end
					else
						Tween(CFrame.new(-1401.85046, 29.9773273, 8.81916237, 0.85820812, 8.76083845e-08, 0.513301849, -8.55007443e-08, 1, -2.77243419e-08, -0.513301849, -2.00944328e-08, 0.85820812))
					end
				end
			end
		end)
	end
end)
Toggle = Tabs.Items:AddToggle("Toggle", {
	Title = "Auto Saw Sword",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.Saw = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.Saw then
				local v = GetConnectionEnemies("The Saw")
				if v then
					repeat
						task.wait()
						Attack.Kill(v, _G.Saw)
					until not _G.Saw or v.Humanoid.Health <= 0
				else
					Tween(CFrame.new(-784.89715576172, 72.427383422852, 1603.5822753906))
				end
			end
		end)
	end
end)
Toggle = Tabs.Items:AddToggle("Toggle", {
	Title = "Auto Warden Sword",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.Warden = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		if _G.Warden then
			pcall(function()
				local v = GetConnectionEnemies("Chief Warden")
				if v then
					repeat
						wait()
						Attack.Kill(v, _G.Warden)
					until not _G.Warden or not v.Parent or v.Humanoid.Health <= 0
				else
					Tween(CFrame.new(5206.92578, 0.997753382, 814.976746, 0.342041343, -0.00062915677, 0.939684749, 0.00191645394, 0.999998152, -2.80422337e-05, -0.939682961, 0.00181045406, 0.342041939))
				end
			end)
		end
	end
end)
Toggle = Tabs.Items:AddToggle("Toggle", {
	Title = "Auto Pole V1",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.Pole = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		if _G.Pole then
			pcall(function()
				local v = GetConnectionEnemies("Thunder God")
				if v then
					repeat
						task.wait()
						Attack.Kill(v, _G.Pole)
					until not _G.Pole or not v.Parent or v.Humanoid.Health <= 0
				else
					Tween(CFrame.new(-7994.984375, 5761.025390625, -2088.6479492188))
				end
			end)
		end
	end
end)
Toggle = Tabs.Items:AddToggle("Toggle", {
	Title = "Auto Cyborg",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.Cyborg = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		if _G.Cyborg then
			pcall(function()
				local v = GetConnectionEnemies("Cyborg")
				if v then
					repeat
						task.wait()
						Attack.Kill(v, _G.Cyborg)
					until not _G.Cyborg or not v.Parent or v.Humanoid.Health <= 0
				else
					Tween(CFrame.new(6094.0249023438, 73.770050048828, 3825.7348632813))
				end
			end)
		end
	end
end)
Toggle = Tabs.Items:AddToggle("Toggle", {
	Title = "Auto Usoap's Hat",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.UsoapHat = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.UsoapHat then
				for _, v in pairs(workspace.Characters:GetChildren()) do
					if v.Name ~= game.Players.LocalPlayer.Name then
						if v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart") and v.Parent and (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude <= 230 then
							repeat
								task.wait()
								EquipWeapon(_G.SelectWeapon)
								Tween(v.HumanoidRootPart.CFrame * CFrame.new(1, 1, 2))
							until not _G.UsoapHat or v.Humanoid.Health <= 0 or not v.Parent or not v:FindFirstChild("HumanoidRootPart") or not v:FindFirstChild("Humanoid")
						end
					end
				end
			end
		end)
	end
end)
Toggle = Tabs.Items:AddToggle("Toggle", {
	Title = "Auto Greybeard",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.Greybeard = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		if _G.Greybeard then
			pcall(function()
				if not GetWP("Bisento") then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Bisento")
				elseif GetWP("Bisento") then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LoadItem", "Bisento")
					local v = GetConnectionEnemies("Greybeard")
					if v then
						repeat
							wait()
							Attack.Kill(v, _G.Greybeard)
						until not _G.Greybeard or not v.Parent or v.Humanoid.Health <= 0
					else
						Tween(CFrame.new(-5023.38330078125, 28.65203285217285, 4332.3818359375))
					end
				end
			end)
		end
	end
end)
Toggle = Tabs.Items:AddToggle("Toggle", {
	Title = "Auto Marine Coat",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.MarinesCoat = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		if _G.MarinesCoat then
			pcall(function()
				local v = GetConnectionEnemies("Vice Admiral")
				if v then
					repeat
						wait()
						Attack.Kill(v, _G.MarinesCoat)
					until not _G.MarinesCoat or not v.Parent or v.Humanoid.Health <= 0
				else
					Tween(CFrame.new(-5006.5454101563, 88.032081604004, 4353.162109375))
				end
			end)
		end
	end
end)
Toggle = Tabs.Items:AddToggle("Toggle", {
	Title = "Auto Swan Coat",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.SwanCoat = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		if _G.SwanCoat then
			pcall(function()
				local v = GetConnectionEnemies("Swan")
				if v then
					repeat
						wait()
						Attack.Kill(v, _G.SwanCoat)
					until not _G.SwanCoat or not v.Parent or v.Humanoid.Health <= 0
				else
					Tween(CFrame.new(5325.09619, 7.03906584, 719.570679, -0.309060812, 0, 0.951042235, 0, 1, 0, -0.951042235, 0, -0.309060812))
				end
			end)
		end
	end
end)
Toggle = Tabs.Items:AddToggle("Toggle", {
	Title = "Auto Rengoku Sword",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.Rengoku = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.Rengoku then
				if game.Players.LocalPlayer.Backpack:FindFirstChild("Hidden Key") or game.Players.LocalPlayer.Character:FindFirstChild("Hidden Key") then
					EquipWeapon("Hidden Key")
					wait(0.1)
					Tween(CFrame.new(6571.1201171875, 299.23028564453, -6967.841796875))
				else
					local v = GetConnectionEnemies({"Snow Lurker", "Arctic Warrior", "Awakened Ice Admiral"})
					if v then
						repeat
							task.wait()
							Attack.Kill(v, _G.Rengoku)
						until game.Players.LocalPlayer.Backpack:FindFirstChild("Hidden Key") or not _G.Rengoku or not v.Parent or v.Humanoid.Health <= 0
					else
						Tween(CFrame.new(5439.716796875, 84.420944213867, -6715.1635742188))
					end
				end
			end
		end)
	end
end)
Toggle = Tabs.Items:AddToggle("Toggle", {
	Title = "Auto Dragon Trident",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.DragonTrident = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.DragonTrident then
				local v = GetConnectionEnemies("Tide Keeper")
				if v then
					repeat
						task.wait()
						Attack.Kill(v, _G.DragonTrident)
					until not _G.DragonTrident or not v.Parent or v.Humanoid.Health <= 0
				else
					Tween(CFrame.new(-3795.6423339844, 105.88877105713, -11421.307617188))
				end
			end
		end)
	end
end)
Toggle = Tabs.Items:AddToggle("Toggle", {
	Title = "Auto Long Sword",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.Long = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.Long then
				local v = GetConnectionEnemies("Diamond")
				if v then
					repeat
						task.wait()
						Attack.Kill(v, _G.Long)
					until not _G.Long or not v.Parent or v.Humanoid.Health <= 0
				else
					Tween(CFrame.new(-1576.7166748047, 198.59265136719, 13.724286079407))
				end
			end
		end)
	end
end)
Toggle = Tabs.Items:AddToggle("Toggle", {
	Title = "Auto Black Spikey",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.BlackSpikey = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		if _G.BlackSpikey then
			pcall(function()
				local v = GetConnectionEnemies("Jeremy")
				if v then
					repeat
						wait()
						Attack.Kill(v, _G.BlackSpikey)
					until not _G.BlackSpikey or not v.Parent or v.Humanoid.Health <= 0
				else
					Tween(CFrame.new(2006.9261474609, 448.95666503906, 853.98284912109))
				end
			end)
		end
	end
end)
Toggle = Tabs.Items:AddToggle("Toggle", {
	Title = "Auto Buy Legendary Sword",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.BuyLegendarySword = Value
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.BuyLegendarySword then
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LegendarySwordDealer", "1")
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LegendarySwordDealer", "2")
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LegendarySwordDealer", "3")
			end
		end)
	end
end)
Toggle = Tabs.Items:AddToggle("Toggle", {
	Title = "Auto Midnight Blade",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.MidnightBlade = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.MidnightBlade then
				if GetM("Ectoplasm") >= 99 then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Ectoplasm", "Buy", 3)
				elseif GetM("Ectoplasm") <= 99 then
					local v = GetConnectionEnemies("Cursed Captain")
					if v then
						repeat
							wait()
							Attack.Kill(v, _G.MidnightBlade)
						until not _G.MidnightBlade or not v.Parent or v.Humanoid.Health <= 0
					else
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
						wait(0.5)
						Tween(CFrame.new(916.928589, 181.092773, 33422))
					end
				end
			end
		end)
	end
end)
Toggle = Tabs.Items:AddToggle("Toggle", {
	Title = "Auto Pole V2",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.PoleV2 = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.PoleV2 then
				if not GetBP("Pole (1st Form)") then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LoadItem", "Pole (1st Form)")
				end
				if not GetBP("Pole (2nd Form)") then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LoadItem", "Pole (2nd Form)")
				end
				if GetBP("Pole (1st Form)") and GetBP("Pole (1st Form)").Level.Value <= 179 then
					_G.Level = true
				elseif GetBP("Pole (1st Form)") and GetBP("Pole (1st Form)").Level.Value >= 180 then
					_G.Level = false
				end
				if not GetBP("Rumble Fruit") then
					return
				end
				if GetBP("Rumble Fruit").AwakenedMoves:FindFirstChild("Z") and GetBP("Rumble Fruit").AwakenedMoves:FindFirstChild("X") and GetBP("Rumble Fruit").AwakenedMoves:FindFirstChild("C") and GetBP("Rumble Fruit").AwakenedMoves:FindFirstChild("V") and GetBP("Rumble Fruit").AwakenedMoves:FindFirstChild("F") then
					_G.SelectChip = nil
					_G.Raid = false
					_G.Awakener = false
					if game.Players.LocalPlayer.Data.Fragments.Value >= 5000 then
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Thunder God", "Talk")
						wait(0.2)
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Thunder God", "Sure")
					end
				elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Awakener", "Check") == nil or game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Awakener", "Check") == 0 then
					_G.SelectChip = "Rumble"
					local Buying = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("RaidsNpc", "Select", _G.SelectChip)
					if Buying then
						Buying:Stop()
					end
					_G.Raid = true
					_G.Awakener = true
				end
			end
		end)
	end
end)
Toggle = Tabs.Items:AddToggle("Toggle", {
	Title = "Auto Dark Blade V3",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.DarkBladeV3 = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.DarkBladeV3 and World2 then
				if not GetBP("Dark Blade") then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LoadItem", "Dark Blade")
				end
				if GetBP("Fist of Darkness") > 1 then
					if not workspace.Enemies:FindFirstChild("Darkbeard") then
						Tween(CFrame.new(3677.08203125, 62.751937866211, -3144.8332519531))
					elseif GetConnectionEnemies("Darkbeard") and GetBP("Fist of Darkness") >= 1 then
						repeat
							wait()
							Tween(CFrame.new(-5719.36376953125, 48.50590515136719, -782.9759521484375))
						until not _G.DarkBladeV3 or (game.Players.LocalPlayer.Character.HumanoidRootPart.Position == CFrame.new(-5719.36376953125, 48.50590515136719, -782.9759521484375).Position)
						fireclickdetector(workspace.Map.GraveIsland.Mountain.Rocks.Button.ClickDetector)
					end
				else
					_G.Chest = true
				end
			end
		end)
	end
end)
Toggle = Tabs.Items:AddToggle("Toggle", {
	Title = "Auto Factory Raid",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.Factory = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.Factory then
				local v = GetConnectionEnemies("Core")
				if v then
					repeat
						wait()
						EquipWeapon(_G.SelectWeapon)
						Tween(CFrame.new(448.46756, 199.356781, -441.389252))
					until v.Humanoid.Health <= 0 or not _G.Factory
				else
					Tween(CFrame.new(448.46756, 199.356781, -441.389252))
				end
			end
		end)
	end
end)
Toggle = Tabs.Items:AddToggle("Toggle", {
	Title = "Auto Darkbeard",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.Darkbeard = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		if _G.Darkbeard then
			pcall(function()
				if GetBP("Fist of Darkness") and not workspace.Enemies:FindFirstChild("Darkbeard") then
					Tween(CFrame.new(3677.08203125, 62.751937866211, -3144.8332519531))
				elseif GetConnectionEnemies("Darkbeard") then
					local v = GetConnectionEnemies("Darkbeard")
					if v then
						repeat
							wait()
							Attack.Kill(v, _G.Darkbeard)
						until not _G.Darkbeard or not v.Parent or v.Humanoid.Helath <= 0
					end
				elseif not GetBP("Fist of Darkness") and not GetConnectionEnemies("Darkbeard") then
					repeat
						wait(0.1)
						_G.Chest = true
					until not _G.Darkbeard or GetBP("Fist of Darkness") or GetConnectionEnemies("Darkbeard")
					_G.Chest = false
				end
			end)
		end
	end
end)
Toggle = Tabs.Items:AddToggle("Toggle", {
	Title = "Auto Unlock Don Swan",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.UnlockDonSwan = Value
end)
spawn(function()
	while task.wait() do
		if _G.UnlockDonSwan then
			pcall(function()
				if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GetUnlockables").FlamingoAccess == nil and game.Players.LocalPlayer.Data.Level.Value >= 1500 then
					FruitPrice = {}
					FruitStore = {}
					for i, v in next, game:GetService("ReplicatedStorage"):WaitForChild("Remotes").CommF_:InvokeServer("GetFruits") do
						if v.Price >= 1000000 then
							table.insert(FruitPrice, v.Name)
						end
					end
					for i, v in pairs(game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("getInventoryFruits")) do
						for _, x in pairs(v) do
							if _ == "Name" then
								table.insert(FruitStore, x)
							end
						end
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Cousin", "Buy")
						for _, y in pairs(FruitPrice) do
							for _, z in pairs(FruitStore) do
								if y == z and game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GetUnlockables").FlamingoAccess == nil then
									_G.StoreF = false
									if not game.Players.LocalPlayer.Backpack:FindFirstChild(FruitStore) then
										game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LoadFruit", tostring(y))
									else
										game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TalkTrevor", "1")
										game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TalkTrevor", "2")
										game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TalkTrevor", "3")
									end
								end
							end
						end
						if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GetUnlockables").FlamingoAccess ~= nil then
							_G.StoreF = true
							_G.UnlockDonSwan = false
						end
					end
				end
			end)
		end
	end
end)
Toggle = Tabs.Items:AddToggle("Toggle", {
	Title = "Auto Swan Glasses",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.SwanGlasses = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		if _G.SwanGlasses then
			pcall(function()
				local v = GetConnectionEnemies("Don Swan")
				if v then
					repeat
						wait()
						Attack.Kill(v, _G.SwanGlasses)
					until not _G.SwanGlasses or not v.Parent or v.Humanoid.Health <= 0
				else
					Tween(CFrame.new(2286.2004394531, 15.177839279175, 863.8388671875))
				end
			end)
		end
	end
end)
Toggle = Tabs.Items:AddToggle("Toggle", {
	Title = "Auto Bartilo Quest",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.Bartilo = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.Bartilo and game.Players.LocalPlayer.Data.Level.Value >= 850 then
				local Qbart = game.Players.LocalPlayer.PlayerGui.Main.Quest
				if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress", "Bartilo") == 0 then
					_G.Level = false
					if Qbart.Visible then
						local v = GetConnectionEnemies("Swan Pirate")
						if v then
							local x = GetConnectionEnemies({"Swan Pirate", "Jeremy"})
							if x then
								repeat
									task.wait()
									if not string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Swan Pirate") then
										game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
									else
										Attack.Kill(x, _G.Bartilo)
									end
								until not _G.Bartilo or not x.Parent or x.Humanoid.Health <= 0 or not Qbart.Visible or not x:FindFirstChild("HumanoidRootPart")
							end
						else
							Tween(CFrame.nee(970.369446, 142.653198, 1217.3667, 0.162079468, -4.85452638e-08, -0.986777723, 1.03357589e-08, 1, -4.74980872e-08, 0.986777723, -2.50063148e-09, 0.162079468))
						end
					else
						repeat
							wait()
							Tween(CFrame.new(-461.533203, 72.3478546, 300.311096, 0.050853312, -0, -0.998706102, 0, 1, -0, 0.998706102, 0, 0.050853312))
						until (CFrame.new(-461.533203, 72.3478546, 300.311096, 0.050853312, -0, -0.998706102, 0, 1, -0, 0.998706102, 0, 0.050853312).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 20 or not _G.Bartilo
						if (CFrame.new(-461.533203, 72.3478546, 300.311096, 0.050853312, -0, -0.998706102, 0, 1, -0, 0.998706102, 0, 0.050853312).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 1 then
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", "BartiloQuest", 1)
						end
					end
				elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress", "Bartilo") == 1 then
					_G.Level = false
					local je = GetConnectionEnemies("Jeremy")
					if je then
						repeat
							task.wait()
							Attack.Kill(je, _G.Bartilo)
						until not _G.Bartilo or not je.Parent or je.Humanoid.Health <= 0 or not Qbart.Visible or not je:FindFirstChild("HumanoidRootPart")
					else
						Tween(CFrame.new(2158.97412, 449.056244, 705.411682, -0.754199564, -4.17389057e-09, -0.656645238, -4.47752875e-08, 1, 4.50709301e-08, 0.656645238, 6.3393955e-08, -0.754199564))
					end
				elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress", "Bartilo") == 2 then
					repeat
						wait()
						Tween(CFrame.new(-1830.83972, 10.5578213, 1680.60229, 0.979988456, -2.02152783e-08, -0.199054286, 2.20792113e-08, 1, 7.1442483e-09, 0.199054286, -1.13962431e-08, 0.979988456))
					until (CFrame.new(-1830.83972, 10.5578213, 1680.60229, 0.979988456, -2.02152783e-08, -0.199054286, 2.20792113e-08, 1, 7.1442483e-09, 0.199054286, -1.13962431e-08, 0.979988456).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 1 or not _G.Bartilo
					wait(0.5)
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Map.Dressrosa.BartiloPlates.Plate1.CFrame
					wait(0.5)
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Map.Dressrosa.BartiloPlates.Plate2.CFrame
					wait(0.5)
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Map.Dressrosa.BartiloPlates.Plate3.CFrame
					wait(0.5)
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Map.Dressrosa.BartiloPlates.Plate4.CFrame
					wait(0.5)
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Map.Dressrosa.BartiloPlates.Plate5.CFrame
					wait(0.5)
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Map.Dressrosa.BartiloPlates.Plate6.CFrame
					wait(0.5)
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Map.Dressrosa.BartiloPlates.Plate7.CFrame
					wait(0.5)
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Map.Dressrosa.BartiloPlates.Plate8.CFrame
					wait(2.5)
				end
			end
		end)
	end
end)
Toggle = Tabs.Items:AddToggle("Toggle", {
	Title = "Auto Buddy Sword",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.Buddy = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		if _G.Buddy then
			pcall(function()
				local bx = GetConnectionEnemies("Cake Queen")
				if bx then
					repeat
						task.wait()
						Attack.Kill(bx, _G.Buddy)
					until not _G.Buddy or not bx.Parent or bx.Humanoid.Health <= 0
				else
					Tween(CFrame.new(-709.3132934570312, 381.6005859375, -11011.396484375))
				end
			end)
		end
	end
end)
Toggle = Tabs.Items:AddToggle("Toggle", {
	Title = "Auto Canvender Sword",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.Canvender = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.Canvender then
				local v = GetConnectionEnemies("Beautiful Pirate")
				if v then
					repeat
						wait()
						Attack.Kill(v, _G.Canvender)
					until not _G.Canvender or v.Humanoid.Health <= 0
				else
					Tween(CFrame.new(5283.609375, 22.56223487854, -110.78285217285))
				end
			end
		end)
	end
end)
Toggle = Tabs.Items:AddToggle("Toggle", {
	Title = "Auto Twin Hook",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.TwinHook = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.TwinHook then
				local v = GetConnectionEnemies("Captain Elephant")
				if v then
					repeat
						wait()
						Attack.Kill(v, _G.TwinHook)
					until not _G.TwinHook or v.Humanoid.Health <= 0
				else
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-12471.169921875, 374.94024658203, -7551.677734375))
					wait(0.2)
					Tween(CFrame.new(-13376.7578125, 433.28689575195, -8071.392578125))
				end
			end
		end)
	end
end)
Toggle = Tabs.Items:AddToggle("Toggle", {
	Title = "Auto Serpent Bow",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.SerpentBow = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		if _G.SerpentBow then
			local v = GetConnectionEnemies("Hydra Leader")
			if v then
				repeat
					wait()
					Attack.Kill(v, _G.SerpentBow)
				until not _G.SerpentBow or not v.Parent or v.Humanoid.Health <= 0
			else
				Tween(CFrame.new(5821.89794921875, 1019.0950927734375, -73.71923065185547))
			end
		end
	end
end)
Toggle = Tabs.Items:AddToggle("Toggle", {
	Title = "Auto Hallow Scythe",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.HallowScythe = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		if _G.HallowScythe then
			pcall(function()
				local v = GetConnectionEnemies("Soul Reaper")
				if v then
					repeat
						task.wait()
						Attack.Kill(v, _G.HallowScythe)
					until v.Humanoid.Health <= 0 or not _G.HallowScythe
				else
					if not GetBP("Hallow Essence") then
						repeat
							task.wait(0.1)
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Bones", "Buy", 1, 1)
						until not _G.HallowScythe or GetBP("Hallow Essence")
					else
						repeat
							wait(0.1)
							Tween(CFrame.new(-8932.322265625, 146.83154296875, 6062.55078125))
						until not _G.HallowScythe or (game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame == CFrame.new(-8932.322265625, 146.83154296875, 6062.55078125))
						EquipWeapon("Hallow Essence")
					end
				end
			end)
		end
	end
end)
Toggle = Tabs.Items:AddToggle("Toggle", {
	Title = "Auto Tushita",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.Tushita = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.Tushita then
				if workspace.Map.Turtle:FindFirstChild("TushitaGate") then
					if not GetBP("Holy Torch") then
						Tween(CFrame.new(5148.03613, 162.352493, 910.548218))
						wait(0.7)
					else
						EquipWeapon("Holy Torch")
						task.wait(1)
						repeat
							task.wait()
							Tween(CFrame.new(-10752, 417, -9366))
						until not _G.Tushita or (CFrame.new(-10752, 417, -9366).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 10
						wait(0.7)
						repeat
							task.wait()
							Tween(CFrame.new(-11672, 334, -9474))
						until not _G.Tushita or (CFrame.new(-11672, 334, -9474).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 10
						wait(0.7)
						repeat
							task.wait()
							Tween(CFrame.new(-12132, 521, -10655))
						until not _G.Tushita or (CFrame.new(-12132, 521, -10655).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 10
						wait(0.7)
						repeat
							task.wait()
							Tween(CFrame.new(-13336, 486, -6985))
						until not _G.Tushita or (CFrame.new(-13336, 486, -6985).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 10
						wait(0.7)
						repeat
							task.wait()
							Tween(CFrame.new(-13489, 332, -7925))
						until not _G.Tushita or (CFrame.new(-13489, 332, -7925).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 10
					end
				else
					local v = GetConnectionEnemies("Longma")
					if v then
						repeat
							task.wait()
							Attack.Kill(v, _G.Tushita)
						until v.Humanoid.Health <= 0 or not _G.Tushita or not v.Parent
					else
						if game:GetService("ReplicatedStorage"):FindFirstChild("Longma") then
							Tween(game:GetService("ReplicatedStorage"):FindFirstChild("Longma").HumanoidRootPart.CFrame * CFrame.new(0, 40, 0))
						end
					end
				end
			end
		end)
	end
end)
Toggle = Tabs.Items:AddToggle("Toggle", {
	Title = "Auto Yama",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.Yama = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.Yama then
				if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EliteHunter", "Progress") < 30 then
					_G.EliteHunter = true
				elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EliteHunter", "Progress") > 30 then
					_G.EliteHunter = false
					if (workspace.Map.Waterfall.SealedKatana.Handle.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude >= 20 then
						Tween(workspace.Map.Waterfall.SealedKatana.Handle.CFrame)
						local zx = GetConnectionEnemies("Ghost")
						if zx then
							repeat
								wait()
								Attack.Kill(zx, _G.Yama)
							until zx.Humanoid.Health <= 0 or not zx.Parent or not _G.Yama
							fireclickdetector(workspace.Map.Waterfall.SealedKatana.Handle.ClickDetector)
						end
					end
				end
			end
		end)
	end
end)
Toggle = Tabs.Items:AddToggle("Toggle", {
	Title = "Auto Cursed Dual Katana",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.CursedDualKatana = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.CursedDualKatana then
				if (_G.T1Yama and _G.T2Yama and _G.T3Yama) and (_G.DoneT1 and _G.DoneT2 and _G.DoneT3) then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "Progress", "Good")
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "Progress", "Evil")
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "StartTrial", "Boss")
					local v = GetConnectionEnemies("Cursed Skeleton Boss")
					if v then
						repeat
							wait()
							if game.Players.LocalPlayer.Character:FindFirstChild("Yama") or game.Players.LocalPlayer.Backpack:FindFirstChild("Yama") then
								EquipWeapon("Yama")
							elseif game.Players.LocalPlayer.Character:FindFirstChild("Tushita") or game.Players.LocalPlayer.Backpack:FindFirstChild("Tushita") then
								EquipWeapon("Tushita")
							end
							Tween(v.HumanoidRootPart.CFrame * CFrame.new(0, 20, 0))
						until not _G.CursedDualKatana or not v.Parent or v.Humanoid.Health <= 0
					else
						Tween(CFrame.new(-12318.193359375, 601.9518432617188, -6538.662109375))
						wait(0.5)
						Tween(workspace.Map.Turtle.Cursed.BossDoor.CFrame)
					end
				end
			end
		end)
	end
end)
PosMsList = {
	["Pirate Millionaire"] = CFrame.new(-712.8272705078125, 98.5770492553711, 5711.9541015625),
	["Pistol Billionaire"] = CFrame.new(-723.4331665039062, 147.42906188964844, 5931.9931640625),
	["Dragon Crew Warrior"] = CFrame.new(7021.50439453125, 55.76270294189453, - 730.1290893554688),
	["Dragon Crew Archer"] = CFrame.new(6625, 378, 244),
	["Female Islander"] = CFrame.new(4692.7939453125, 797.9766845703125, 858.8480224609375),
	["Venomous Assailant"] = CFrame.new(4902, 670, 39),
	["Marine Commodore"] = CFrame.new(2401, 123, - 7589),
	["Marine Rear Admiral"] = CFrame.new(3588, 229, - 7085),
	["Fishman Raider"] = CFrame.new(-10941, 332, - 8760),
	["Fishman Captain"] = CFrame.new(-11035, 332, - 9087),
	["Forest Pirate"] = CFrame.new(-13446, 413, - 7760),
	["Mythological Pirate"] = CFrame.new(-13510, 584, - 6987),
	["Jungle Pirate"] = CFrame.new(-11778, 426, - 10592),
	["Musketeer Pirate"] = CFrame.new(-13282, 496, - 9565),
	["Reborn Skeleton"] = CFrame.new(-8764, 142, 5963),
	["Living Zombie"] = CFrame.new(-10227, 421, 6161),
	["Demonic Soul"] = CFrame.new(-9579, 6, 6194),
	["Posessed Mummy"] = CFrame.new(-9579, 6, 6194),
	["Peanut Scout"] = CFrame.new(-1993, 187, - 10103),
	["Peanut President"] = CFrame.new(-2215, 159, - 10474),
	["Ice Cream Chef"] = CFrame.new(-877, 118, - 11032),
	["Ice Cream Commander"] = CFrame.new(-877, 118, - 11032),
	["Cookie Crafter"] = CFrame.new(-2021, 38, - 12028),
	["Cake Guard"] = CFrame.new(-2024, 38, - 12026),
	["Baking Staff"] = CFrame.new(-1932, 38, - 12848),
	["Head Baker"] = CFrame.new(-1932, 38, - 12848),
	["Cocoa Warrior"] = CFrame.new(95, 73, - 12309),
	["Chocolate Bar Battler"] = CFrame.new(647, 42, - 12401),
	["Sweet Thief"] = CFrame.new(116, 36, - 12478),
	["Candy Rebel"] = CFrame.new(47, 61, - 12889),
	["Ghost"] = CFrame.new(5251, 5, 1111)
}
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.CursedDualKatana then
				if not (_G.T1Yama or _G.T2Yama or _G.T3Yama) then
					if tostring(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "OpenDoor")) ~= "opened" then
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "OpenDoor")
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "OpenDoor", true)
					else
						if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "Progress")["Finished"] == nil then
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "StartTrial", "Evil")
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "StartTrial", "Evil")
						elseif not game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "Progress")["Finished"] then
							if tonumber(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "Progress")["Evil"]) == - 3 then
								repeat
									task.wait()
									if not workspace.Enemies:FindFirstChild("Forest Pirate") then
										Tween(CFrame.new(-13223.521484375, 428.1938171386719, -7766.06787109375))
									else
										local v = GetConnectionEnemies("Forest Pirate")
										if v then
											Tween(workspace.Enemies:FindFirstChild("Forest Pirate").HumanoidRootPart.CFrame)
										end
									end
								until tonumber(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "Progress")["Evil"]) == 1 or not _G.CursedDualKatana
							elseif tonumber(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "Progress")["Evil"]) == - 4 then
								for ix, HitMon in pairs(game:GetService("Players").LocalPlayer.QuestHaze:GetChildren()) do
									for NameMonHaze, CFramePos in pairs(PosMsList) do
										if string.find(NameMonHaze, HitMon.Name) and HitMon.Value > 0 then
											if (CFramePos.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 1000 and workspace.Enemies:FindFirstChild(NameMonHaze) then
												for i, v in pairs(workspace.Enemies:GetChildren()) do
													if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v:FindFirstChild("Humanoid").Health > 0 and v:FindFirstChild("HazeESP") then
														repeat
															wait()
															Attack.Kill(v, _G.CursedDualKatana)
														until not _G.CursedDualKatana or tonumber(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "Progress")["Evil"]) == 2 or not v:FindFirstChild("HazeESP") or v.Humanoid.Health <= 0
													end
												end
											else
												Tween(CFramePos)
											end
										end
									end
								end
							elseif tonumber(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "Progress")["Evil"]) == - 5 then
								if workspace.Map:FindFirstChild("HellDimension") then
									if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - workspace.Map.HellDimension.Spawn.Position).Magnitude <= 1000 then
										for gg, ez in pairs(workspace.Map.HellDimension.Exit:GetChildren()) do
											if tonumber(gg) == 2 then
												repeat
													task.wait()
													game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Map.HellDimension.Exit.CFrame
												until not _G.CursedDualKatana or tonumber(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "Progress")["Evil"]) == 3
											end
										end
										EquipWeapon(_G.SelectWeapon)
										if tonumber(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "Progress")["Evil"]) ~= 3 then
											repeat
												task.wait()
												repeat
													task.wait()
													Tween(workspace.Map.HellDimension.Torch1.Particles.CFrame)
													for i, v in pairs(workspace.Map.HellDimension:GetDescendants()) do
														if v:IsA("ProximityPrompt") then
															fireproximityprompt(v)
														end
													end
												until (workspace.Map.HellDimension.Torch1.Particles.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 5
												wait(2)
												_G.T1Yama = true
											until not _G.CursedDualKatana or _G.T1Yama or tonumber(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "Progress")["Evil"]) == 3
											repeat
												task.wait()
												repeat
													task.wait()
													Tween(workspace.Map.HellDimension.Torch2.Particles.CFrame)
													for i, v in pairs(workspace.Map.HellDimension:GetDescendants()) do
														if v:IsA("ProximityPrompt") then
															fireproximityprompt(v)
														end
													end
												until (workspace.Map.HellDimension.Torch2.Particles.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 5
												wait(2)
												_G.T2Yama = true
											until _G.T2Yama or not _G.CursedDualKatana or tonumber(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "Progress")["Evil"]) == 3
											repeat
												wait()
												repeat
													task.wait()
													Tween(workspace.Map.HellDimension.Torch3.Particles.CFrame)
													for i, v in pairs(workspace.Map.HellDimension:GetDescendants()) do
														if v:IsA("ProximityPrompt") then
															fireproximityprompt(v)
														end
													end
												until (workspace.Map.HellDimension.Torch3.Particles.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 5
												wait(2)
												_G.T3Yama = true
											until _G.T3Yama or not _G.CursedDualKatana or tonumber(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "Progress")["Evil"]) == 3
										end
										for i, v in pairs(workspace.Enemies:GetChildren()) do
											if (v:FindFirstChild("HumanoidRootPart").Position - workspace.Map.HellDimension.Spawn.Position).Magnitude <= 300 then
												if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v:FindFirstChild("Humanoid").Health > 0 then
													repeat
														task.wait()
														Attack.Kill(v, _G.CursedDualKatana)
													until not _G.CursedDualKatana or v.Humanoid.Health <= 0 or not v.Parent or tonumber(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "Progress")["Evil"]) == 3
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end)
	end
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.CursedDualKatana then
				if not (_G.T1Yama or _G.T2Yama or _G.T3Yama) then
					if tonumber(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "Progress")["Evil"]) == - 5 then
						if not workspace.Map:FindFirstChild("HellDimension") or (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - workspace.Map.HellDimension.Spawn.Position).Magnitude > 1000 then
							local v = GetConnectionEnemies("Soul Reaper")
							if v then
								repeat
									task.wait()
									Tween(v.HumanoidRootPart.CFrame)
								until v.Humanoid.Health <= 0 or not _G.CursedDualKatana or not v.Parent or tonumber(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "Progress")["Evil"]) == 3 or (workspace.Map:FindFirstChild("HellDimension") and (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - workspace.Map.HellDimension.Spawn.Position).Magnitude <= 1000)
							elseif game.Players.LocalPlayer.Backpack:FindFirstChild("Hallow Essence") or game.Players.LocalPlayer.Character:FindFirstChild("Hallow Essence") then
								repeat
									Tween(CFrame.new(-8932.322265625, 146.83154296875, 6062.55078125))
									task.wait()
								until (CFrame.new(-8932.322265625, 146.83154296875, 6062.55078125).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 8
								EquipWeapon("Hallow Essence")
							elseif game:GetService("ReplicatedStorage"):FindFirstChild("Soul Reaper") and game:GetService("ReplicatedStorage"):FindFirstChild("Soul Reaper").Humanoid.Health > 0 then
								Tween(game:GetService("ReplicatedStorage"):FindFirstChild("Soul Reaper").HumanoidRootPart.CFrame)
							else
								if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Bones", "Check") < 50 and not workspace.Enemies:FindFirstChild("Soul Reaper") and not game:GetService("ReplicatedStorage"):FindFirstChild("Soul Reaper") and not workspace.Map:FindFirstChild("HellDimension") then
									if workspace.Enemies:FindFirstChild("Reborn Skeleton") or workspace.Enemies:FindFirstChild("Living Zombie") or workspace.Enemies:FindFirstChild("Domenic Soul") or workspace.Enemies:FindFirstChild("Posessed Mummy") then
										for i, v in pairs(workspace.Enemies:GetChildren()) do
											if v.Name == "Reborn Skeleton" or v.Name == "Living Zombie" or v.Name == "Demonic Soul" or v.Name == "Posessed Mummy" then
												if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v:FindFirstChild("Humanoid").Health > 0 then
													repeat
														task.wait()
														Attack.Kill(v, _G.CursedDualKatana)
													until not _G.CursedDualKatana or v.Humanoid.Health <= 0 or not v.Parent
												end
											end
										end
									else
										Tween(CFrame.new(-9515.2255859375, 164.0062255859375, 5785.38330078125))
									end
								else
									game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Bones", "Buy", 1, 1)
								end
							end
						end
					end
				end
			end
		end)
	end
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.CursedDualKatana then
				if not (_G.DoneT1 or _G.DoneT2 or _G.DoneT3) then
					if tostring(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "OpenDoor")) ~= "opened" then
						wait(0.7)
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "OpenDoor")
						wait(0.3)
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "OpenDoor", true)
					else
						if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "Progress")["Finished"] == nil then
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "StartTrial", "Good")
						elseif not game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "Progress")["Finished"] then
							if tonumber(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "Progress")["Good"]) == - 3 then
								repeat
									wait()
									Tween(CFrame.new(-4602.5107421875, 16.446542739868164, -2880.998046875))
								until (CFrame.new(-4602.5107421875, 16.446542739868164, -2880.998046875).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 3 or not _G.CursedDualKatana or tonumber(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "Progress")["Good"]) == 1
								if (CFrame.new(-4602.5107421875, 16.446542739868164, -2880.998046875).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 10 then
									wait(0.7)
									game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "BoatQuest", workspace.NPCs:FindFirstChild("Luxury Boat Dealer"), "Check")
									wait(0.5)
									game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "BoatQuest", workspace.NPCs:FindFirstChild("Luxury Boat Dealer"))
								end
								wait(1)
								repeat
									wait()
									Tween(CFrame.new(4001.185302734375, 10.089399337768555, -2654.86328125))
								until (CFrame.new(4001.185302734375, 10.089399337768555, -2654.86328125).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 3 or not _G.CursedDualKatana or tonumber(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "Progress")["Good"]) == 1
								if (CFrame.new(4001.185302734375, 10.089399337768555, -2654.86328125).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 10 then
									wait(0.7)
									game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "BoatQuest", workspace.NPCs:FindFirstChild("Luxury Boat Dealer"), "Check")
									wait(0.5)
									game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "BoatQuest", workspace.NPCs:FindFirstChild("Luxury Boat Dealer"))
								end
								wait(1)
								repeat
									wait()
									Tween(CFrame.new(-9530.763671875, 7.245208740234375, -8375.5087890625))
								until (CFrame.new(-9530.763671875, 7.245208740234375, -8375.5087890625).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 3 or not _G.CursedDualKatana or tonumber(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "Progress")["Good"]) == 1
								if (CFrame.new(-9530.763671875, 7.245208740234375, -8375.5087890625).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 10 then
									wait(0.7)
									game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "BoatQuest", workspace.NPCs:FindFirstChild("Luxury Boat Dealer"), "Check")
									wait(0.5)
									game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "BoatQuest", workspace.NPCs:FindFirstChild("Luxury Boat Dealer"))
								end
								wait(1)
							elseif tonumber(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "Progress")["Good"]) == - 4 then
								repeat
									wait()
									_G.PirateRaid = true
								until not _G.CursedDualKatana or tonumber(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "Progress")["Good"]) == 2
								_G.PirateRaid = false
							elseif tonumber(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "Progress")["Good"]) == - 5 then
								if workspace.Enemies:FindFirstChild("Cake Queen") then
									for i, v in pairs(workspace.Enemies:GetChildren()) do
										if v.Name == "Cake Queen" then
											if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
												repeat
													wait()
													Attack.Kill(v, _G.CursedDualKatana)
												until not _G.CursedDualKatana or not v.Parent or v.Humanoid.Health <= 0 or tonumber(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "Progress")["Good"]) == 3
											end
										end
									end
								elseif game:GetService("ReplicatedStorage"):FindFirstChild("Cake Queen") and game:GetService("ReplicatedStorage"):FindFirstChild("Cake Queen").Humanoid.Health > 0 then
									Tween(game:GetService("ReplicatedStorage"):FindFirstChild("Cake Queen").HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
								else
									if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - workspace.Map.HeavenlyDimension.Spawn.Position).Magnitude <= 1000 then
										for i, v in pairs(workspace.Map.HeavenlyDimension.Exit:GetChildren()) do
											Ex = i
										end
										if Ex == 2 then
											repeat
												wait()
												game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Map.HeavenlyDimension.Exit.CFrame
											until not _G.CursedDualKatana or tonumber(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "Progress")["Good"]) == 3
										end
										repeat
											wait()
											repeat
												wait()
												Tween(CFrame.new(-22529.6171875, 5275.77392578125, 3873.5712890625))
												for i, v in pairs(workspace.Map.HeavenlyDimension:GetDescendants()) do
													if v:IsA("ProximityPrompt") then
														fireproximityprompt(v)
													end
												end
											until (CFrame.new(-22529.6171875, 5275.77392578125, 3873.5712890625).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 5
											wait(2)
											_G.DoneT1 = true
										until not _G.CursedDualKatana or _G.DoneT1
										repeat
											wait()
											repeat
												wait()
												Tween(CFrame.new(-22637.291015625, 5281.365234375, 3749.28857421875))
												for i, v in pairs(workspace.Map.HeavenlyDimension:GetDescendants()) do
													if v:IsA("ProximityPrompt") then
														fireproximityprompt(v)
													end
												end
											until (CFrame.new(-22637.291015625, 5281.365234375, 3749.28857421875).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 5
											wait(2)
											_G.DoneT2 = true
										until _G.DoneT2 or not _G.CursedDualKatana
										repeat
											wait()
											repeat
												task.wait()
												Tween(CFrame.new(-22791.14453125, 5277.16552734375, 3764.570068359375))
												for i, v in pairs(workspace.Map.HeavenlyDimension:GetDescendants()) do
													if v:IsA("ProximityPrompt") then
														fireproximityprompt(v)
													end
												end
											until (CFrame.new(-22791.14453125, 5277.16552734375, 3764.570068359375).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 5
											wait(2)
											_G.DoneT3 = true
										until _G.DoneT3 or not _G.CursedDualKatana
										for i, v in pairs(workspace.Enemies:GetChildren()) do
											if (v:FindFirstChild("HumanoidRootPart").Position - CFrame.new(-22695.7012, 5270.93652, 3814.42847, 0.11794927, 3.32185834e-08, 0.99301964, -8.73070718e-08, 1, -2.30819008e-08, -0.99301964, -8.3975138e-08, 0.11794927).Position).Magnitude <= 300 then
												if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v:FindFirstChild("Humanoid").Health > 0 then
													repeat
														wait()
														Attack.Kill(v, _G.CursedDualKatana)
													until not _G.CursedDualKatana or v.Humanoid.Health <= 0 or not v.Parent
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end)
	end
end)
Toggle = Tabs.Items:AddToggle("Toggle", {
	Title = "Auto Soul Guitar",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.SoulGuitar = Value
	StopTween(Value)
end)
task.spawn(function()
	while task.wait() do
		if _G.SoulGuitar then
			pcall(function()
				if GetM("Bones") >= 500 and GetM("Ectoplasm") >= 250 and GetM("Dark Fragment") >= 1 then
					local v = GetConnectionEnemies("Living Zombie")
					if v then
						v.HumanoidRootPart.CFrame = CFrame.new(-10138.3974609375, 138.6524658203125, 5902.89208984375)
						v.Head.CanCollide = false
						v.Humanoid.Sit = false
						v.HumanoidRootPart.CanCollide = false
						v.Humanoid.JumpPower = 0
						v.Humanoid.WalkSpeed = 0
						if v.Humanoid:FindFirstChild("Animator") then
							v.Humanoid:FindFirstChild("Animator"):Destroy()
						end
					end
				end
			end)
		end
	end
end)
function getT(num)
	local rotation
	if num == 1 then
		rotation = workspace.Map["Haunted Castle"].Tablet.Segment1.Line.Rotation
	elseif num == 3 then
		rotation = workspace.Map["Haunted Castle"].Tablet.Segment3.Line.Rotation
	elseif num == 4 then
		rotation = workspace.Map["Haunted Castle"].Tablet.Segment4.Line.Rotation
	elseif num == 7 then
		rotation = workspace.Map["Haunted Castle"].Tablet.Segment7.Line.Rotation
	elseif num == 10 then
		rotation = workspace.Map["Haunted Castle"].Tablet.Segment10.Line.Rotation
	end
	if rotation then
		return rotation.Z
	end
end
function getRT(num)
	local Trophy_Q = workspace.Map["Haunted Castle"].Trophies.Quest
	local Trophy_Pos
	for _, v in pairs(Trophy_Q:GetChildren()) do
		if num == 1 and v.Name == "Trophy1" and v:FindFirstChild("Handle") then
			Trophy_Pos = v.Handle.Rotation
		elseif num == 2 and v.Name == "Trophy2" and v:FindFirstChild("Handle") then
			Trophy_Pos = v.Handle.Rotation			elseif num == 3 and v.Name == "Trophy3" and v:FindFirstChild("Handle") then
			Trophy_Pos = v.Handle.Rotation		elseif num == 4 and v.Name == "Trophy4" and v:FindFirstChild("Handle") then
			Trophy_Pos = v.Handle.Rotation
		elseif num == 5 and v.Name == "Trophy5" and v:FindFirstChild("Handle") then
			Trophy_Pos = v.Handle.Rotation		end			if Trophy_Pos then
			return Trophy_Pos.Z
		end
	end
end
function GetFirePlacard(Number, Side)
	if tostring(workspace.Map["Haunted Castle"]["Placard" .. Number][Side].Indicator.BrickColor) ~= "Pearl" then
		fireclickdetector(workspace.Map["Haunted Castle"]["Placard" .. Number][Side].ClickDetector)
	end
end
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.SoulGuitar then
				if World3 then
					if GetM("Bones") >= 500 and GetM("Ectoplasm") >= 250 and GetM("Dark Fragment") >= 1 then
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("gravestoneEvent", 2)
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("gravestoneEvent", 2, true)
						if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GuitarPuzzleProgress", "Check") == nil then
							Tween(CFrame.new(-8655.0166015625, 141.3166961669922, 6160.0224609375))
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("gravestoneEvent", 2)
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("gravestoneEvent", 2, true)
						elseif not game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GuitarPuzzleProgress", "Check").Swamp then
							local v = GetConnectionEnemies("Living Zombie")
							if v then
								repeat
									task.wait()
									Attack.Kill(v, _G.SoulGuitar)
								until not _G.SoulGuitar or v.Humanoid.Health <= 0 or not v.Parent or workspace.Map["Haunted Castle"].SwampWater.Color ~= Color3.fromRGB(117, 0, 0)
							else
								Tween(CFrame.new(-10170.7275390625, 138.6524658203125, 5934.26513671875))
							end
						elseif not game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GuitarPuzzleProgress", "Check").Gravestones then
							GetFirePlacard("7", "Left")
							GetFirePlacard("6", "Left")
							GetFirePlacard("5", "Left")
							GetFirePlacard("4", "Right")
							GetFirePlacard("3", "Left")
							GetFirePlacard("2", "Right")
							GetFirePlacard("1", "Right")
						elseif not game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GuitarPuzzleProgress", "Check").Ghost then
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GuitarPuzzleProgress", "Ghost")
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GuitarPuzzleProgress", "Ghost", true)
						elseif not game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GuitarPuzzleProgress", "Check").Trophies then
							Tween(CFrame.new(-9532.8232421875, 6.471667766571045, 6078.068359375))
							repeat
								wait()
								local z1 = getRT(1)
								local _z1 = getT(1)
								if z1 and _z1 then
									fireclickdetector(workspace.Map["Haunted Castle"].Tablet.Segment1:FindFirstChild("ClickDetector"))
								end
							until z1 == _z1
							repeat
								wait()
								local z2 = getRT(2)
								local _z2 = getT(3)
								if z2 and _z2 then
									fireclickdetector(workspace.Map["Haunted Castle"].Tablet.Segment3:FindFirstChild("ClickDetector"))
								end
							until z2 == _z2
							repeat
								wait()
								local z3 = getRT(3)
								local _z3 = getT(4)
								if z3 and _z3 then
									fireclickdetector(workspace.Map["Haunted Castle"].Tablet.Segment4:FindFirstChild("ClickDetector"))
								end
							until z3 == _z3
							repeat
								wait()
								local z4 = getRT(4)
								local _z4 = getT(7)
								if z4 and _z4 then
									fireclickdetector(workspace.Map["Haunted Castle"].Tablet.Segment7:FindFirstChild("ClickDetector"))
								end
							until z4 == _z4
							repeat
								wait()
								local z5 = getRT(5)
								local _z5 = getT(10)
								if z5 and _z5 then
									fireclickdetector(workspace.Map["Haunted Castle"].Tablet.Segment10:FindFirstChild("ClickDetector"))
								end
							until z5 == _z5
							repeat
								wait()
								fireclickdetector(workspace.Map["Haunted Castle"].Tablet.Segment2:FindFirstChild("ClickDetector"))
								fireclickdetector(workspace.Map["Haunted Castle"].Tablet.Segment5:FindFirstChild("ClickDetector"))
								fireclickdetector(workspace.Map["Haunted Castle"].Tablet.Segment6:FindFirstChild("ClickDetector"))
								fireclickdetector(workspace.Map["Haunted Castle"].Tablet.Segment8:FindFirstChild("ClickDetector"))
								fireclickdetector(workspace.Map["Haunted Castle"].Tablet.Segment9:FindFirstChild("ClickDetector"))
							until workspace.Map["Haunted Castle"].Tablet.Segment2.Line.Rotation.Z == 0 or workspace.Map["Haunted Castle"].Tablet.Segment5.Line.Rotation.Z == 0 or workspace.Map["Haunted Castle"].Tablet.Segment6.Line.Rotation.Z == 0 or workspace.Map["Haunted Castle"].Tablet.Segment8.Line.Rotation.Z == 0 or workspace.Map["Haunted Castle"].Tablet.Segment9.Line.Rotation.Z == 0
						elseif not game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GuitarPuzzleProgress", "Check").Pipes then
							Tween(workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part3.CFrame)
							fireclickdetector(workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part3.ClickDetector)
							Tween(workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part4.CFrame)
							fireclickdetector(workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part4.ClickDetector)
							fireclickdetector(workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part4.ClickDetector)
							fireclickdetector(workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part4.ClickDetector)
							Tween(workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part6.CFrame)
							fireclickdetector(workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part6.ClickDetector)
							fireclickdetector(workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part6.ClickDetector)
							Tween(workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part8.CFrame)
							fireclickdetector(workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part8.ClickDetector)
							Tween(workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part10.CFrame)
							fireclickdetector(workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part10.ClickDetector)
							fireclickdetector(workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part10.ClickDetector)
							fireclickdetector(workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part10.ClickDetector)
						end
					end
				end
			end
		end)
	end
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.SoulGuitar and not GetWP("Skull Guitar") then
				if GetM("Bones") < 500 and GetM("Ectoplasm") < 250 and GetM("Dark Fragment") < 1 then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("soulGuitarBuy", true)
				else
					if GetM("Ectoplasm") <= 250 then
						if _G.SoulGuitar and World2 then
							local xz = GetConnectionEnemies({"Ship Deckhand", "Ship Engineer", "Ship Steward", "Ship Officer", "Arctic Warrior"})
							if xz then
								repeat
									task.wait()
									Attack.Kill(xz, _G.SoulGuitar)
								until not _G.SoulGuitar or not xz.Parent or xz.Humanoid.Health <= 0
							else
								game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
							end
						else
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa")
						end
					elseif GetM("Dark Fragment") < 1 then
						if _G.SoulGuitar and World2 then
							local black = GetConnectionEnemies("Darkbeard")
							if black then
								repeat
									task.wait()
									Attack.Kill(black, _G.SoulGuitar)
								until _G.SoulGuitar or black.Humanoid.Health <= 0
							else
								Tween(CFrame.new(3798.4575195313, 13.826690673828, -3399.806640625))
							end
						else
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa")
						end
						if not GetConnectionEnemies("Darkbeard") then
							Hop()
						end
					elseif GetM("Bones") <= 500 then
						if _G.SoulGuitar and World3 then
							local zx = GetConnectionEnemies({"Reborn Skeleton", "Living Zombie", "Demonic Soul", "Posessed Mummy"})
							if zx then
								repeat
									task.wait()
									Attack.Kill(zx, _G.SoulGuitar)
								until not _G.SoulGuitar or zx.Humanoid.Health <= 0 or not zx.Parent or zx.Humanoid.Health <= 0
							else
								Tween(CFrame.new(-9504.8564453125, 172.14292907714844, 6057.259765625))
							end
						else
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelZou")
						end
					end
				end
			end
		end)
	end
end)
Toggle = Tabs.Items:AddToggle("Toggle", {
	Title = "Auto Lei Accessory",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.LeiAccessory = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		if _G.LeiAccessory then
			pcall(function()
				local v = GetConnectionEnemies("Kilo Admiral")
				if v then
					repeat
						task.wait()
						Attack.Kill(v, _G.LeiAccessory)
					until not _G.LeiAccessory or not v.Parent or v.Humanoid.Health <= 0
				else
					Tween(CFrame.new(2764.2233886719, 432.46154785156, -7144.4580078125))
				end
			end)
		end
	end
end)
Toggle = Tabs.Items:AddToggle("Toggle", {
	Title = "Auto Pirate Raid",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.PirateRaid = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		if _G.PirateRaid then
			pcall(function()
				local CFrameCastleRaid = CFrame.new(-5496.17432, 313.768921, -2841.53027, 0.924894512, 7.37058015e-09, 0.380223751, 3.5881019e-08, 1, -1.06665446e-07, -0.380223751, 1.12297109e-07, 0.924894512)
				if (CFrame.new(-5539.3115234375, 313.800537109375, -2972.372314453125).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 500 then
					for i, v in pairs(workspace.Enemies:GetChildren()) do
						if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
							if v.Name then
								if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 2000 then
									repeat
										wait()
										Attack.Kill(v, _G.PirateRaid)
									until not _G.PirateRaid or not v.Parent or v.Humanoid.Health <= 0 or not workspace.Enemies:FindFirstChild(v.Name)
								end
							end
						end
					end
				else
					local Castle_Mob = {
						"Galley Pirate",
						"Galley Captain",
						"Raider",
						"Mercenary",
						"Vampire",
						"Zombie",
						"Snow Trooper",
						"Winter Warrior",
						"Lab Subordinate",
						"Horned Warrior",
						"Magma Ninja",
						"Lava Pirate",
						"Ship Deckhand",
						"Ship Engineer",
						"Ship Steward",
						"Ship Officer",
						"Arctic Warrior",
						"Snow Lurker",
						"Sea Soldier",
						"Water Fighter"
					}
					for i = 1, # Castle_Mob do
						if game:GetService("ReplicatedStorage"):FindFirstChild(Castle_Mob[i]) then
							for _, v in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do
								if table.find(Castle_Mob, v.Name) then
									Tween(CFrameCastleRaid)
								end
							end
						end
					end
				end
			end)
		end
	end
end)
Toggle = Tabs.Items:AddToggle("Toggle", {
	Title = "Auto Observation V2",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.ObservationV2 = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		if _G.ObservationV2 then
			pcall(function()
				local Kv2Pos1 = CFrame.new(-12444.78515625, 332.40396118164, -7673.1806640625)
				local Kv2Pos2 = "Kuy"
				local Kv2Pos3 = CFrame.new(-10920.125, 624.20275878906, -10266.995117188)
				local Kv2Pos4 = CFrame.new(-13277.568359375, 370.34185791016, -7821.1572265625)
				local Kv2Pos5 = CFrame.new(-13493.12890625, 318.89553833008, -8373.7919921875)
				if game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible and string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Defeat 50 Forest Pirates") then
					local v = GetConnectionEnemies("Forest Pirate")
					if v then
						repeat
							wait()
							Attack.Kill(v, _G.ObservationV2)
						until not _G.ObservationV2 or v.Humanoid.Health <= 0 or not game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible
					else
						Tween(Kv2Pos4)
					end
				elseif game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible then
					local v = GetConnectionEnemies("Captain Elephant")
					if v then
						repeat
							wait()
							Attack.Kill(v, _G.ObservationV2)
						until not _G.ObservationV2 or v.Humanoid.Health <= 0 or not game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible
					else
						Tween(Kv2Pos5)
					end
				elseif not game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CitizenQuestProgress", "Citizen")
					wait(0.1)
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", "CitizenQuest", 1)
				end
				if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CitizenQuestProgress", "Citizen") == 2 then
					Tween(CFrame.new(-12513.51953125, 340.1137390136719, -9873.048828125))
				end
				if not game.Players.LocalPlayer.Backpack:FindFirstChild("Fruit Bowl") or not game.Players.LocalPlayer.Character:FindFirstChild("Fruit Bowl") then
					if not GetBP("Fruit Bowl") then
						if not GetBP("Apple") then
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-12471.169921875, 374.94024658203, -7551.677734375))
							for i, v in pairs(workspace:GetDescendants()) do
								if v.Name == "Apple" then
									v.Handle.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 1, 10)
									wait()
									firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Handle, 0)
									wait()
								end
							end
						elseif not GetBP("Banana") then
							Tween(CFrame.new(2286.0078125, 73.13391876220703, -7159.80908203125))
							for i, v in pairs(workspace:GetDescendants()) do
								if v.Name == "Banana" then
									v.Handle.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 1, 10)
									wait()
									firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Handle, 0)
									wait()
								end
							end
						elseif not GetBP("Pineapple") then
							Tween(CFrame.new(-712.8272705078125, 98.5770492553711, 5711.9541015625))
							for i, v in pairs(workspace:GetDescendants()) do
								if v.Name == "Pineapple" then
									v.Handle.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 1, 10)
									wait()
									firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Handle, 0)
									wait()
								end
							end
						end
					end
					if game.Players.LocalPlayer.Backpack:FindFirstChild("Banana") and game.Players.LocalPlayer.Backpack:FindFirstChild("Apple") and game.Players.LocalPlayer.Backpack:FindFirstChild("Pineapple") or game.Players.LocalPlayer:FindFirstChild("Banana") and game.Players.LocalPlayer:FindFirstChild("Apple") and game.Players.LocalPlayer:FindFirstChild("Pineapple") then
						repeat
							wait()
							Tween(Kv2Pos1)
						until _G.ObservationV2 or game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame == Kv2Pos1
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CitizenQuestProgress", "Citizen")
					end
					if game.Players.LocalPlayer.Backpack:FindFirstChild("Fruit Bowl") or game.Players.LocalPlayer.Character:FindFirstChild("Fruit Bowl") then
						if game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame ~= Kv2Pos3 then
							Tween(Kv2Pos3)
						elseif game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame == Kv2Pos3 then
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("KenTalk2", "Start")
							wait(0.1)
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("KenTalk2", "Buy")
						end
					end
				end
			end)
		end
	end
end)
Toggle = Tabs.Items:AddToggle("Toggle", {
	Title = "Auto Citizen Quest",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.Citizen = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.Citizen then
				if game.Players.LocalPlayer.Data.Level.Value >= 1800 and not game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CitizenQuestProgress").KilledBandits then
					if string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Forest Pirate") and string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "50") and game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible then
						local v = GetConnectionEnemies("Forest Pirate")
						if v then
							repeat
								task.wait()
								Attack.Kill(v, _G.Citizen)
							until not _G.Citizen or not v.Parent or v.Humanoid.Health <= 0 or not game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible
						else
							Tween(CFrame.new(-13206.452148438, 425.89199829102, -7964.5537109375))
						end
					else
						Tween(CFrame.new(-12443.8671875, 332.40396118164, -7675.4892578125))
						if (Vector3.new(-12443.8671875, 332.40396118164, -7675.4892578125) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 30 then
							wait(1.5)
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", "CitizenQuest", 1)
						end
					end
				elseif game.Players.LocalPlayer.Data.Level.Value >= 1800 and not game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CitizenQuestProgress").KilledBoss then
					local v = GetConnectionEnemies("Captain Elephant")
					if game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible and string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Captain Elephant") and game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible then
						if v then
							repeat
								task.wait()
								Attack.Kill(v, _G.Citizen)
							until not _G.Citizen or v.Humanoid.Health <= 0 or not v.Parent or not game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible
						else
							Tween(CFrame.new(-13374.889648438, 421.27752685547, -8225.208984375))
						end
					else
						Tween(CFrame.new(-12443.8671875, 332.40396118164, -7675.4892578125))
						if (CFrame.new(-12443.8671875, 332.40396118164, -7675.4892578125).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 4 then
							wait(1.5)
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CitizenQuestProgress", "Citizen")
						end
					end
				elseif game.Players.LocalPlayer.Data.Level.Value >= 1800 and game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CitizenQuestProgress", "Citizen") == 2 then
					Tween(CFrame.new(-12512.138671875, 340.39279174805, -9872.8203125))
				end
			end
		end)
	end
end)
Toggle = Tabs.Items:AddToggle("Toggle", {
	Title = "Auto Kill Rip Indra",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.RipIndra = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.RipIndra then
				local v = GetConnectionEnemies("rip_indra")
				if not GetWP("Dark Dagger") or not GetIn("Valkyrie") and v then
					repeat
						wait()
						Attack.Kill(v, _G.RipIndra)
					until not _G.RipIndra or not v.Parent or v.Humanoid.Health <= 0
				else
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-5097.93164, 316.447021, -3142.66602, -0.405007899, -4.31682743e-08, 0.914313197, -1.90943332e-08, 1, 3.8755779e-08, -0.914313197, -1.76180437e-09, -0.405007899))
					wait(0.1)
					Tween(CFrame.new(-5344.822265625, 423.98541259766, -2725.0930175781))
				end
			end
		end)
	end
end)
Toggle = Tabs.Items:AddToggle("Toggle", {
	Title = "Auto Unlock Puzzle",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.UnlockPuzzle = Value
	StopTween(Value)
end)
function AuraSkin(HakiID)
	local args = {
		[1] = {
			["StorageName"] = HakiID,
			["Type"] = "AuraSkin",
			["Context"] = "Equip"
		}
	}
	game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RF/FruitCustomizerRF"):InvokeServer(unpack(args))
end
function VaildColor(Part)
	if Part and Part.BrickColor then
		return (tostring(Part.BrickColor) == "Lime green")
	end
end
function HakiCalculate(Part)
	local ID = {
		["Really red"] = "Pure Red",
		["Oyster"] = "Snow White",
		["Hot pink"] = "Winter Sky"
	}
	if Part and Part.BrickColor then
		return (ID[tostring(Part.BrickColor)])
	end
end
spawn(function()
	while task.wait() do
		if _G.UnlockPuzzle then
			pcall(function()
				local Summoner = workspace.Map["Boat Castle"]:FindFirstChild("Summoner")
				if Summoner and Summoner:FindFirstChild("Circle") then
					for i, v in pairs(Summoner:FindFirstChild("Circle"):GetChildren()) do
						if v.Name == "Part" then
							TogglesPart = v:FindFirstChild("Part")
							if not VaildColor(TogglesPart) then
								AuraSkin(HakiCalculate(v))
								repeat
									wait()
									Tween(v.CFrame)
								until VaildColor(TogglesPart) or not _G.UnlockPuzzle
							end
						end
					end
				end
			end)
		end
	end
end)
Toggle = Tabs.Items:AddToggle("Toggle", {
	Title = "Auto Arena Trainer",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.ArenaTrainer = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		if _G.ArenaTrainer then
			pcall(function()
				if not game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible then
					game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("ArenaTrainer")
				else
					local v = GetConnectionEnemies("Training Dummy")
					if v then
						repeat
							wait()
							Attack.Kill(v, _G.ArenaTrainer)
						until not _G.ArenaTrainer or not v.Parent or v.Humanoid.Health <= 0
					else
						Tween(CFrame.new(3688.005126953125, 12.746943473815918, 170.20953369140625))
					end
				end
			end)
		end
	end
end)
Toggle = Tabs.Items:AddToggle("Toggle", {
	Title = "Auto Rainbow Haki",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.RainbowHaki = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.RainbowHaki then
				if not game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible then
					if _G.GetQFast then
						if not game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible then
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("HornedMan", "Bet")
						end
					else
						Rainbow1 = CFrame.new(-11892.0703125, 930.57672119141, -8760.1591796875)
						if (game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame ~= Rainbow1) then
							Tween(Rainbow1)
						elseif (game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame == Rainbow1) then
							wait(1)
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("HornedMan", "Bet")
						end
					end
				elseif game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible and string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Stone") then
					local v = GetConnectionEnemies("Stone")
					if v then
						repeat
							wait()
							Attack.Kill(v, _G.RainbowHaki)
						until not _G.RainbowHaki or v.Humanoid.Health <= 0 or not v.Parent or not game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible
					else
						Tween(CFrame.new(-1086.11621, 38.8425903, 6768.71436, 0.0231462717, -0.592676699, 0.805107772, 2.03251839e-05, 0.805323839, 0.592835128, -0.999732077, -0.0137055516, 0.0186523199))
					end
				elseif game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible and string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Hydra Leader") then
					local v = GetConnectionEnemies("Hydra Leader")
					if v then
						repeat
							task.wait()
							Attack.Kill(v, _G.RainbowHaki)
						until not _G.RainbowHaki or v.Humanoid.Health <= 0 or not v.Parent or not game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible
					else
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(5643.45263671875, 1013.0858154296875, -340.51025390625))
						local framelong1 = Vector3.new(5643.45263671875, 1013.0858154296875, -340.51025390625)
						local framelong2 = CFrame.new(5821.89794921875, 1019.0950927734375, -73.71923065185547)
						if (game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Position == framelong1) then
							Tween(framelong2)
						end
					end
				elseif game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible and string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Kilo Admiral") then
					local v = GetConnectionEnemies("Kilo Admiral")
					if v then
						repeat
							task.wait()
							Attack.Kill(v, _G.RainbowHaki)
						until not _G.RainbowHaki or v.Humanoid.Health <= 0 or not v.Parent or not game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible
					else
						Tween(CFrame.new(2877.61743, 423.558685, -7207.31006, -0.989591599, -0, -0.143904909, -0, 1.00000012, -0, 0.143904924, 0, -0.989591479))
					end
				elseif game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible and string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Captain Elephant") then
					local v = GetConnectionEnemies("Captain Elephant")
					if v then
						repeat
							task.wait()
							Attack.Kill(v, _G.RainbowHaki)
						until not _G.RainbowHaki or v.Humanoid.Health <= 0 or not v.Parent or not game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible
					else
						local gamergayror1 = Vector3.new(-12471.169921875, 374.94024658203, -7551.677734375)
						local gamergayror2 = CFrame.new(-13376.7578125, 433.28689575195, -8071.392578125)
						if (game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Position ~= gamergayror1) then
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-12471.169921875, 374.94024658203, -7551.677734375))
						elseif (game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Position == gamergayror1) then
							Tween(gamergayror2)
						end
					end
				elseif game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible and string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Beautiful Pirate") then
					local v = GetConnectionEnemies("Captain Elephant")
					if v then
						repeat
							task.wait()
							Attack.Kill(v, _G.RainbowHaki)
						until not _G.RainbowHaki or v.Humanoid.Health <= 0 or not v.Parent or not game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible
					else
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(5314.54638671875, 22.562219619750977, -127.06755065917969))
					end
				end
			end
		end)
	end
end)
Toggle = Tabs.Items:AddToggle("Toggle", {
	Title = "Accept Rainbow Quest Faster",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.GetQFast = Value
end)
Tabs.Race:AddSection("Race V3")
Toggle = Tabs.Race:AddToggle("Toggle", {
	Title = "Auto Evo Mink",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.Mink = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.Mink then
				if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Alchemist", "1") ~= 2 then
					if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Alchemist", "1") == 0 then
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Alchemist", "2")
					elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Alchemist", "1") == 1 then
						if not game.Players.LocalPlayer.Backpack:FindFirstChild("Flower 1") and not game.Players.LocalPlayer.Character:FindFirstChild("Flower 1") then
							Tween(workspace.Flower1.CFrame)
						elseif not game.Players.LocalPlayer.Backpack:FindFirstChild("Flower 2") and not game.Players.LocalPlayer.Character:FindFirstChild("Flower 2") then
							Tween(workspace.Flower2.CFrame)
						elseif not game.Players.LocalPlayer.Backpack:FindFirstChild("Flower 3") and not game.Players.LocalPlayer.Character:FindFirstChild("Flower 3") then
							local v = GetConnectionEnemies("Swan Pirate")
							if v then
								repeat
									wait()
									Attack.Kill(v, _G.Mink)
								until GetBP("Flower 3") or not v.Parent or v.Humanoid.Health <= 0 or not _G.Mink
							else
								Tween(CFrame.new(980.0985107421875, 121.331298828125, 1287.2093505859375))
							end
						end
					elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Alchemist", "1") == 2 then
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Alchemist", "3")
					end
				elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Wenlocktoad", "1") == 0 then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Wenlocktoad", "2")
				elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Wenlocktoad", "1") == 1 then
					_G.Chest = true
				else
					_G.Chest = false
				end
			end
		end)
	end
end)
Tabs.Skill:AddSection("Melee")
Dropdown = Tabs.Skill:AddDropdown("Dropdown", {
	Title = "Select Skill",
	Values = {"Z", "X", "C"},
	Multi = true,
	Default = {"Z", "X", "C"}
})
Dropdown:OnChanged(function(Value)
	_G.SelectSkillMelee = Value
end)
Slider = Tabs.Skill:AddSlider("Slider", {
	Title = "Hold Z",
	Default = 0.5,
	Min = 0,
	Max = 10,
	Rounding = 1,
	Callback = function(Value)
		_G.HoldZMelee = Value
	end
})
Slider = Tabs.Skill:AddSlider("Slider", {
	Title = "Hold X",
	Default = 0.5,
	Min = 0,
	Max = 10,
	Rounding = 1,
	Callback = function(Value)
		_G.HoldXMelee = Value
	end
})
Slider = Tabs.Skill:AddSlider("Slider", {
	Title = "Hold C",
	Default = 0.5,
	Min = 0,
	Max = 10,
	Rounding = 1,
	Callback = function(Value)
		_G.HoldCMelee = Value
	end
})
Tabs.Skill:AddSection("Sword")
Dropdown = Tabs.Skill:AddDropdown("Dropdown", {
	Title = "Select Skill",
	Values = {"Z", "X"},
	Multi = true,
	Default = {"Z", "X"}
})
Dropdown:OnChanged(function(Value)
	_G.SelectSkillSword = Value
end)
Slider = Tabs.Skill:AddSlider("Slider", {
	Title = "Hold Z",
	Default = 0.5,
	Min = 0,
	Max = 10,
	Rounding = 1,
	Callback = function(Value)
		_G.HoldZSword = Value
	end
})
Slider = Tabs.Skill:AddSlider("Slider", {
	Title = "Hold X",
	Default = 0.5,
	Min = 0,
	Max = 10,
	Rounding = 1,
	Callback = function(Value)
		_G.HoldXSword = Value
	end
})
Tabs.Skill:AddSection("Gun")
Tabs.Skill:AddDropdown("Dropdown", {
	Title = "Select Skill",
	Values = {"Z", "X"},
	Multi = true,
	Default = {"Z", "X"}
})
Dropdown:OnChanged(function(Value)
	_G.SelectSkillGun = Value
end)
Slider = Tabs.Skill:AddSlider("Slider", {
	Title = "Hold Z",
	Default = 0.5,
	Min = 0,
	Max = 10,
	Rounding = 1,
	Callback = function(Value)
		_G.HoldZGun = Value
	end
})
Slider = Tabs.Skill:AddSlider("Slider", {
	Title = "Hold X",
	Default = 0.5,
	Min = 0,
	Max = 10,
	Rounding = 1,
	Callback = function(Value)
		_G.HoldXGun = Value
	end
})
Tabs.Skill:AddSection("Blox Fruit")
Tabs.Skill:AddDropdown("Dropdown", {
	Title = "Select Skill",
	Values = {"Z", "X", "C", "V", "F"},
	Multi = true,
	Default = {"Z", "X", "C"}
})
Dropdown:OnChanged(function(Value)
	_G.SelectSkillFruit = Value
end)
Slider = Tabs.Skill:AddSlider("Slider", {
	Title = "Hold Z",
	Default = 0.5,
	Min = 0,
	Max = 10,
	Rounding = 1,
	Callback = function(Value)
		_G.HoldZFruit = Value
	end
})
Slider = Tabs.Skill:AddSlider("Slider", {
	Title = "Hold X",
	Default = 0.5,
	Min = 0,
	Max = 10,
	Rounding = 1,
	Callback = function(Value)
		_G.HoldXFruit = Value
	end
})
Slider = Tabs.Skill:AddSlider("Slider", {
	Title = "Hold C",
	Default = 0.5,
	Min = 0,
	Max = 10,
	Rounding = 1,
	Callback = function(Value)
		_G.HoldCFruit = Value
	end
})
Slider = Tabs.Skill:AddSlider("Slider", {
	Title = "Hold V",
	Default = 0.5,
	Min = 0,
	Max = 10,
	Rounding = 1,
	Callback = function(Value)
		_G.HoldVFruit = Value
	end
})
Slider = Tabs.Skill:AddSlider("Slider", {
	Title = "Hold F",
	Default = 0.5,
	Min = 0,
	Max = 10,
	Rounding = 1,
	Callback = function(Value)
		_G.HoldFFruit = Value
	end
})
Tabs.Sea:AddSection("Sea Event")
Dropdown = Tabs.Sea:AddDropdown("Dropdown", {
	Title = "Select Boat",
	Values = {"Guardian", "PirateGrandBrigade", "MarineGrandBrigade", "PirateBrigade", "MarineBrigade", "PirateSloop", "MarineSloop", "Beast Hunter"},
	Multi = false,
	Default = "Guardian"
})
Dropdown:OnChanged(function(Value)
	_G.SelectBoat = Value
end)
Tabs.Sea:AddButton({
	Title = "Buy Boat",
	Callback = function()
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBoat", _G.SelectBoat)
	end
})
Dropdown = Tabs.Sea:AddDropdown("Dropdown", {
	Title = "Select Zone",
	Values = {"Zone 1", "Zone 2", "Zone 3", "Zone 4", "Zone 5", "Zone 6", "Infinite"},
	Multi = false,
	Default = "Zone 5"
})
Dropdown:OnChanged(function(Value)
	_G.SelectZone = Value
	if _G.SelectZone == "Zone 1" then
		CFrameSelectZone = CFrame.new(-21998.375, 30.0006084, -682.309143)
	elseif _G.SelectZone == "Zone 2" then
		CFrameSelectZone = CFrame.new(-26779.5215, 30.0005474, -822.858032)
	elseif _G.SelectZone == "Zone 3" then
		CFrameSelectZone = CFrame.new(-31171.957, 30.0001011, -2256.93774)
	elseif _G.SelectZone == "Zone 4" then
		CFrameSelectZone = CFrame.new(-34054.6875, 30.2187767, -2560.12012)
	elseif _G.SelectZone == "Zone 5" then
		CFrameSelectZone = CFrame.new(-38887.5547, 30.0004578, -2162.99023)
	elseif _G.SelectZone == "Zone 6" then
		CFrameSelectZone = CFrame.new(-44541.7617, 30.0003204, -1244.8584)
	elseif _G.SelectZone == "Infinite" then
		CFrameSelectZone = CFrame.new(-10000000, 31, 37016.25)
	end
end)
Toggle = Tabs.Sea:AddToggle("Toggle", {
	Title = "Auto Sail Boat",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.SailBoat = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		if _G.SailBoat then
			pcall(function()
				local myBoat = CheckBoat()
				if not myBoat and not (CheckShark() and _G.Shark or CheckTerrorshark() and _G.Terrorshark or CheckFishCrew() and _G.FishCrew or CheckPiranha() and _G.Piranha) and not (CheckEnemiesBoat() and _G.FishBoat) and not (CheckSeaBeast() and _G.SeaBeast) and not (_G.PirateGrandBrigade and CheckPirateGrandBrigade()) and not (_G.HauntedCrew and CheckHauntedCrew()) and not (_G.Leviathan and CheckLeviathan()) then
					local buyBoatCFrame = CFrame.new(-16927.451, 9.086, 433.864)
					Tween(buyBoatCFrame)
					if (buyBoatCFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 10 then
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBoat", _G.SelectBoat)
					end
				elseif myBoat and not (CheckShark() and _G.Shark or CheckTerrorshark() and _G.Terrorshark or CheckFishCrew() and _G.FishCrew or CheckPiranha() and _G.Piranha) and not (CheckEnemiesBoat() and _G.FishBoat) and not (CheckSeaBeast() and _G.SeaBeast) and not (_G.PirateGrandBrigade and CheckPirateGrandBrigade()) and not (_G.HauntedCrew and CheckHauntedCrew()) and not (_G.Leviathan and CheckLeviathan()) then
					if not game.Players.LocalPlayer.Character.Humanoid.Sit then
						local boatSeatCFrame = myBoat.VehicleSeat.CFrame * CFrame.new(0, 1, 0)
						Tween(boatSeatCFrame)
					else
						repeat
							wait()
							if (not _G.FishBoat and CheckEnemiesBoat()) or (not _G.PirateGrandBrigade and CheckPirateGrandBrigade()) or (not _G.Terrorshark and CheckTerrorshark()) then
								Tween(CFrameSelectZone * CFrame.new(0, 150, 0))
							else
								Tween(CFrameSelectZone)
							end
						until not _G.SailBoat or (CheckShark() and _G.Shark or CheckTerrorshark() and _G.Terrorshark or CheckFishCrew() and _G.FishCrew or CheckPiranha() and _G.Piranha) or CheckSeaBeast() and _G.SeaBeast or CheckEnemiesBoat() and _G.FishBoat or _G.Leviathan and CheckLeviathan() or _G.HauntedCrew and CheckHauntedCrew() or _G.PirateGrandBrigade and CheckPirateGrandBrigade() or not game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Sit
						game.Players.LocalPlayer.Character.Humanoid.Sit = false
					end
				end
			end)
		end
	end
end)
spawn(function()
	while task.wait() do
		pcall(function()
			for a, b in pairs(workspace.Boats:GetChildren()) do
				for c, d in pairs(workspace.Boats[b.Name]:GetDescendants()) do
					if d:IsA("BasePart") then
						if _G.SailBoat or _G.FindPrehistoric or _G.FindMirage or _G.SailHydra or _G.FindKitsune or _G.FindFrozen then
							d.CanCollide = false
						else
							d.CanCollide = true
						end
					end
				end
			end
		end)
	end
end)
Tabs.Sea:AddSection("Enemies")
Toggle = Tabs.Sea:AddToggle("Toggle", {
	Title = "Auto Kill Shark",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.Shark = Value
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.Shark then
				if CheckShark() then
					for b, c in pairs(workspace.Enemies:GetChildren()) do
						if table.find("Shark", c.Name) then
							if Attack.Alive(c) then
								repeat
									task.wait()
									Attack.Kill(c, _G.Shark)
								until not _G.Shark or not c.Parent or c.Humanoid.Health <= 0
							end
						end
					end
				end
			end
		end)
	end
end)
Toggle = Tabs.Sea:AddToggle("Toggle", {
	Title = "Auto Kill Piranha",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.Piranha = Value
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.Piranha then
				if CheckPiranha() then
					for b, c in pairs(workspace.Enemies:GetChildren()) do
						if table.find("Piranha", c.Name) then
							if Attack.Alive(c) then
								repeat
									task.wait()
									Attack.Kill(c, _G.Piranha)
								until not _G.Piranha or not c.Parent or c.Humanoid.Health <= 0
							end
						end
					end
				end
			end
		end)
	end
end)
Toggle = Tabs.Sea:AddToggle("Toggle", {
	Title = "Auto Kill Terror Shark",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.Terrorshark = Value
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.Terrorshark then
				if CheckTerrorshark() then
					for b, c in pairs(workspace.Enemies:GetChildren()) do
						if table.find("Terrorshark", c.Name) then
							if Attack.Alive(c) then
								repeat
									task.wait()
									Attack.KillSea(c, _G.Terrorshark)
								until not _G.Terrorshark or not c.Parent or c.Humanoid.Health <= 0
							end
						end
					end
				end
			end
		end)
	end
end)
Toggle = Tabs.Sea:AddToggle("Toggle", {
	Title = "Auto Kill Fish Crew Member",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.FishCrew = Value
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.FishCrew then
				if CheckFishCrew() then
					for b, c in pairs(workspace.Enemies:GetChildren()) do
						if table.find("Fish Crew Member", c.Name) then
							if Attack.Alive(c) then
								repeat
									task.wait()
									Attack.Kill(c, _G.FishCrew)
								until not _G.FishCrew or not c.Parent or c.Humanoid.Health <= 0
							end
						end
					end
				end
			end
		end)
	end
end)
Toggle = Tabs.Sea:AddToggle("Toggle", {
	Title = "Auto Kill Haunted Crew Member",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.HauntedCrew = Value
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.HauntedCrew then
				if CheckHauntedCrew() then
					for b, c in pairs(workspace.Enemies:GetChildren()) do
						if table.find("Haunted Crew Member", c.Name) then
							if Attack.Alive(c) then
								repeat
									task.wait()
									Attack.Kill(c, _G.HauntedCrew)
								until not _G.HauntedCrew or not c.Parent or c.Humanoid.Health <= 0
							end
						end
					end
				end
			end
		end)
	end
end)
Toggle = Tabs.Sea:AddToggle("Toggle", {
	Title = "Auto Kill Pirate Grand Brigade",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.PirateGrandBrigade = Value
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.PirateGrandBrigade then
				if CheckPirateGrandBrigade() then
					for a, b in pairs(workspace.Enemies:GetChildren()) do
						if b:FindFirstChild("Health") and b.Health.Value > 0 and b:FindFirstChild("VehicleSeat") then
							repeat
								task.wait()
								spawn(function()
									if b.Name == "PirateBrigade" then
										Tween(b.Engine.CFrame * CFrame.new(0, -30, -10))
									elseif b.Name == "PirateGrandBrigade" then
										Tween(b.Engine.CFrame * CFrame.new(0, -50, -50))
									end
								end)
								if game.Players.LocalPlayer:DistanceFromCharacter(b.Engine.CFrame.Position) <= 150 then
									AitSeaSkill_Custom = b.Engine.CFrame
									MousePos = AitSeaSkill_Custom.Position
									Useskillsea()
								end
							until not _G.PirateGrandBrigade or not b:FindFirstChild("VehicleSeat") or b.Health.Value <= 0
						end
					end
				end
			end
		end)
	end
end)
Toggle = Tabs.Sea:AddToggle("Toggle", {
	Title = "Auto Kill Fish Boat",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.FishBoat = Value
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.FishBoat then
				if CheckEnemiesBoat() then
					for a, b in pairs(workspace.Enemies:GetChildren()) do
						if b:FindFirstChild("Health") and b.Health.Value > 0 and b:FindFirstChild("VehicleSeat") then
							repeat
								task.wait()
								spawn(function()
									if b.Name == "FishBoat" then
										Tween(b.Engine.CFrame * CFrame.new(0, -50, -25))
									end
								end)
								if game.Players.LocalPlayer:DistanceFromCharacter(b.Engine.CFrame.Position) <= 150 then
									AitSeaSkill_Custom = b.Engine.CFrame
									MousePos = AitSeaSkill_Custom.Position
									Useskillsea()
								end
							until not _G.FishBoat or not b:FindFirstChild("VehicleSeat") or b.Health.Value <= 0
						end
					end
				end
			end
		end)
	end
end)
Toggle = Tabs.Sea:AddToggle("Toggle", {
	Title = "Auto Kill Sea Beast",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.SeaBeast = Value
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.SeaBeast then
				if workspace.SeaBeasts:FindFirstChild("SeaBeast1") then
					for a, b in pairs(workspace.SeaBeasts:GetChildren()) do
						if b:FindFirstChild("HumanoidRootPart") and b:FindFirstChild("Health") and b.Health.Value > 0 then
							repeat
								task.wait()
								spawn(function()
									Tween(CFrame.new(b.HumanoidRootPart.Position.X, game:GetService("Workspace").Map["WaterBase-Plane"].Position.Y + 200, b.HumanoidRootPart.Position.Z))
								end)
								if game.Players.LocalPlayer:DistanceFromCharacter(b.HumanoidRootPart.CFrame.Position) <= 500 then
									AitSeaSkill_Custom = b.HumanoidRootPart.CFrame
									MousePos = AitSeaSkill_Custom.Position
									Useskillsea()
								end
							until not _G.SeaBeast or not b:FindFirstChild("HumanoidRootPart") or not b.Parent or b.Health.Value <= 0
						end
					end
				end
			end
		end)
	end
end)
Tabs.Sea:AddSection("Kitsune Island")
Toggle = Tabs.Sea:AddToggle("Toggle", {
	Title = "Auto Find Kitsune Island",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.FindKitsune = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		if _G.FindKitsune then
			pcall(function()
				if not workspace["_WorldOrigin"].Locations:FindFirstChild("Kitsune Island", true) then
					local myBoat = CheckBoat()
					if not myBoat then
						local buyBoatCFrame = CFrame.new(-16927.451, 9.086, 433.864)
						Tween(buyBoatCFrame)
						if (buyBoatCFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 10 then
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBoat", _G.SelectBoat)
						end
					else
						if not game.Players.LocalPlayer.Character.Humanoid.Sit then
							local boatSeatCFrame = myBoat.VehicleSeat.CFrame * CFrame.new(0, 1, 0)
							Tween(boatSeatCFrame)
						else
							local targetDestination = CFrame.new(-10000000, 31, 37016.25)
							repeat
								wait()
								if CheckEnemiesBoat() or CheckTerrorshark() or CheckPirateGrandBrigade() then
									Tween(CFrame.new(-10000000, 150, 37016.25))
								else
									Tween(CFrame.new(-10000000, 31, 37016.25))
								end
							until not _G.FindKitsune or (targetDestination.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 10 or workspace["_WorldOrigin"].Locations:FindFirstChild("Kitsune Island") or not game.Players.LocalPlayer.Character.Humanoid.Sit
							game.Players.LocalPlayer.Character.Humanoid.Sit = false
						end
					end
				else
					Tween(workspace._WorldOrigin.Locations:FindFirstChild("Kitsune Island").CFrame * CFrame.new(0, 500, 0))
				end
			end)
		end
	end
end)
Toggle = Tabs.Sea:AddToggle("Toggle", {
	Title = "Auto Teleport To Kitsune Island",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.TPKitsune = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		if _G.TPKitsune then
			pcall(function()
				local kit_is = workspace.Map:FindFirstChild("KitsuneIsland") or game.Workspace._WorldOrigin.Locations:FindFirstChild("Kitsune Island")
				local shrineActive = kit_is:FindFirstChild("ShrineActive")
				if shrineActive then
					for _, v in next, shrineActive:GetDescendants() do
						if v:IsA("BasePart") and v.Name:find("NeonShrinePart") then
							game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RE/TouchKitsuneStatue"):FireServer()
							repeat
								wait()
								Tween(v.CFrame * CFrame.new(0, 2, 0))
							until not _G.TPKitsune or not kit_is
						end
					end
				else
					Tween(workspace._WorldOrigin.Locations:FindFirstChild("Kitsune Island").CFrame * CFrame.new(0, 500, 0))
				end
			end)
		end
	end
end)
Toggle = Tabs.Sea:AddToggle("Toggle", {
	Title = "Auto Collect Azure Ember",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.AzureEmber = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		if _G.AzureEmber then
			pcall(function()
				if workspace:WaitForChild("AttachedAzureEmber") or workspace:WaitForChild("EmberTemplate") then
					TP(workspace:WaitForChild("EmberTemplate"):FindFirstChild("Part").CFrame)
				else
					Tween(workspace._WorldOrigin.Locations:FindFirstChild("Kitsune Island").CFrame * CFrame.new(0, 500, 0))
					game:GetService("ReplicatedStorage").Modules.Net["RF/KitsuneStatuePray"]:InvokeServer()
				end
			end)
		end
	end
end)
Toggle = Tabs.Sea:AddToggle("Toggle", {
	Title = "Auto Trade Azure Ember",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.Trade_Ember = Value
end)
spawn(function()
	while task.wait() do
		if _G.Trade_Ember then
			pcall(function()
				if workspace["_WorldOrigin"].Locations:FindFirstChild("Kitsune Island", true) then
					game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RF/KitsuneStatuePray"):InvokeServer()
				end
			end)
		end
	end
end)
Tabs.Sea:AddButton({
	Title = "Trade Azure Ember",
	Callback = function()
		game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RF/KitsuneStatuePray"):InvokeServer()
	end
})
Tabs.Sea:AddButton({
	Title = "Touch Kitsune Statue",
	Callback = function()
		game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RE/TouchKitsuneStatue"):FireServer()
	end
})
Tabs.Sea:AddSection("Frozen Dimension")
Spy = Tabs.Sea:AddParagraph({
	Title = "Spy",
	Content = "N/A"
})
spawn(function()
	while task.wait() do
		pcall(function()
			local spycheck = string.match(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("InfoLeviathan", "1"), "%d+")
			Spy:SetDesc(tostring(spycheck) .. "/5")
		end)
	end
end)
Tabs.Sea:AddButton({
	Title = "Buy Spy",
	Callback = function()
		game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("InfoLeviathan", "2")
	end
})
Toggle = Tabs.Sea:AddToggle("Toggle", {
	Title = "Auto Find Frozen Dimension",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.FindFrozen = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		if _G.FindFrozen then
			pcall(function()
				if not workspace["_WorldOrigin"].Locations:FindFirstChild("Frozen Dimension", true) then
					local myBoat = CheckBoat()
					if not myBoat then
						local buyBoatCFrame = CFrame.new(-16927.451, 9.086, 433.864)
						Tween(buyBoatCFrame)
						if (buyBoatCFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 10 then
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBoat", _G.SelectBoat)
						end
					else
						if not game.Players.LocalPlayer.Character.Humanoid.Sit then
							local boatSeatCFrame = myBoat.VehicleSeat.CFrame * CFrame.new(0, 1, 0)
							Tween(boatSeatCFrame)
						else
							local targetDestination = CFrame.new(-10000000, 31, 37016.25)
							repeat
								wait()
								if CheckEnemiesBoat() or CheckTerrorshark() or CheckPirateGrandBrigade() then
									Tween(CFrame.new(-10000000, 150, 37016.25))
								else
									Tween(CFrame.new(-10000000, 31, 37016.25))
								end
							until not _G.FindFrozen or (targetDestination.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 10 or workspace["_WorldOrigin"].Locations:FindFirstChild("Frozen Dimension") or not game.Players.LocalPlayer.Character.Humanoid.Sit
							game.Players.LocalPlayer.Character.Humanoid.Sit = false
						end
					end
				else
					Tween(workspace._WorldOrigin.Locations:FindFirstChild("Frozen Dimension").CFrame)
				end
			end)
		end
	end
end)
Toggle = Tabs.Sea:AddToggle("Toggle", {
	Title = "Auto Teleport To Frozen Dimension",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.TPFrozen = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		if _G.TPFrozen then
			pcall(function()
				if workspace.Map:FindFirstChild("LeviathanGate") then
					Tween(workspace.Map.LeviathanGate.CFrame)
					game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("OpenLeviathanGate")
				end
			end)
		end
	end
end)
Toggle = Tabs.Sea:AddToggle("Toggle", {
	Title = "Auto Kill Leviathan",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.Leviathan = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.Leviathan then
				if workspace.SeaBeasts:FindFirstChild("Leviathan") then
					for a, b in pairs(workspace.SeaBeasts:GetChildren()) do
						if b:FindFirstChild("HumanoidRootPart") and b:FindFirstChild("Leviathan Segment") and b:FindFirstChild("Health") and b.Health.Value > 0 then
							repeat
								task.wait()
								spawn(function()
								game.Players.LocalPlayer.Character.Humanoid.Sit = false
									Tween(CFrame.new(b.HumanoidRootPart.Position.X, game:GetService("Workspace").Map["WaterBase-Plane"].Position.Y + 200, b.HumanoidRootPart.Position.Z))
								end)
								if game.Players.LocalPlayer:DistanceFromCharacter(b.HumanoidRootPart.CFrame.Position) <= 500 then
									MousePos = b:FindFirstChild("Leviathan Segment").Position
									Useskillsea()
								end
							until not _G.Leviathan or not b:FindFirstChild("HumanoidRootPart") or not b.Parent or b.Health.Value <= 0
						end
					end
				end
			end
		end)
	end
end)
Toggle = Tabs.Sea:AddToggle("Toggle", {
	Title = "Auto Drive To Hydra Island",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.SailHydra = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		if _G.SailHydra then
			pcall(function()
				local myBoat = CheckBoat()
				if not myBoat then
					local buyBoatCFrame = CFrame.new(-16927.451, 9.086, 433.864)
					Tween(buyBoatCFrame)
					if (buyBoatCFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 10 then
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBoat", _G.SelectBoat)
					end
				elseif myBoat then
					if not game.Players.LocalPlayer.Character.Humanoid.Sit then
						local boatSeatCFrame = myBoat.VehicleSeat.CFrame * CFrame.new(0, 1, 0)
						Tween(boatSeatCFrame)
					else
						repeat
							wait()
							if CheckEnemiesBoat() or CheckPirateGrandBrigade() or CheckTerrorshark() then
								Tween(CFrame.new(5433, 150, 290))
							else
								Tween(CFrame.new(5433, 35, 290))
							end
						until not _G.SailHydra or not game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Sit
						game.Players.LocalPlayer.Character.Humanoid.Sit = false
					end
				end
			end)
		end
	end
end)
Tabs.Sea:AddSection("Mirage Island")
Toggle = Tabs.Sea:AddToggle("Toggle", {
	Title = "Auto Find Mirage Island",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.FindMirage = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		if _G.FindMirage then
			pcall(function()
				if not workspace["_WorldOrigin"].Locations:FindFirstChild("Mirage Island", true) then
					local myBoat = CheckBoat()
					if not myBoat then
						local buyBoatCFrame = CFrame.new(-16927.451, 9.086, 433.864)
						Tween(buyBoatCFrame)
						if (buyBoatCFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 10 then
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBoat", _G.SelectBoat)
						end
					else
						if not game.Players.LocalPlayer.Character.Humanoid.Sit then
							local boatSeatCFrame = myBoat.VehicleSeat.CFrame * CFrame.new(0, 1, 0)
							Tween(boatSeatCFrame)
						else
							repeat
								wait()
								local targetDestination = CFrame.new(-10000000, 31, 37016.25)
								if CheckEnemiesBoat() or CheckTerrorshark() or CheckPirateGrandBrigade() then
									Tween(CFrame.new(-10000000, 150, 37016.25))
								else
									Tween(CFrame.new(-10000000, 31, 37016.25))
								end
							until not _G.FindMirage or (targetDestination.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 10 or workspace["_WorldOrigin"].Locations:FindFirstChild("Mirage Island") or not game.Players.LocalPlayer.Character.Humanoid.Sit
							game.Players.LocalPlayer.Character.Humanoid.Sit = false
						end
					end
				else
					Tween(workspace.Map.MysticIsland.Center.CFrame * CFrame.new(0, 300, 0))
				end
			end)
		end
	end
end)
Toggle = Tabs.Sea:AddToggle("Toggle", {
	Title = "Auto Teleport To Highest Point",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.HighestMirage = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		if _G.HighestMirage then
			pcall(function()
				if workspace["_WorldOrigin"].Locations:FindFirstChild("Mirage Island", true) then
					Tween(workspace.Map.MysticIsland.Center.CFrame * CFrame.new(0, 400, 0))
				end
			end)
		end
	end
end)
Toggle = Tabs.Sea:AddToggle("Toggle", {
	Title = "Auto Collect Gear",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.TPGear = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.TPGear then
				for i, v in pairs(workspace.Map:FindFirstChild("MysticIsland"):GetChildren()) do
					if v.Name == "Part" then
						if v.ClassName == "MeshPart" then
							Tween(v.CFrame)
						end
					end
				end
			end
		end)
	end
end)
Toggle = Tabs.Sea:AddToggle("Toggle", {
	Title = "Change Transparency Can See",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.can = Value
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.can then
				for i, v in pairs(workspace.Map:FindFirstChild("MysticIsland"):GetChildren()) do
					if v.Name == "Part" then
						if v.ClassName == "MeshPart" then
							v.Transparency = 0
						else
							v.Transparency = 1
						end
					end
				end
			end
		end)
	end
end)
Toggle = Tabs.Sea:AddToggle("Toggle", {
	Title = "Auto Teleport To Advanced Fruit Dealer",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.TPFruitDealer = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		if _G.TPFruitDealer then
			pcall(function()
				for _, v in pairs(game:GetService("ReplicatedStorage").NPCs:GetChildren()) do
					if v.Name == "Advanced Fruit Dealer" then
						Tween(v.HumanoidRootPart.CFrame)
					end
				end
			end)
		end
	end
end)
Toggle = Tabs.Sea:AddToggle("Toggle", {
	Title = "Auto Farm Mirage Chest",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.MirageChest = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		if _G.MirageChest then
			pcall(function()
				if workspace.Map.MysticIsland.Chests:FindFirstChild("DiamondChest") or workspace.Map.MysticIsland.Chests:FindFirstChild("FragChest") then
					local CollectionService = game:GetService("CollectionService")
					local Players = game:GetService("Players")
					local Player = Players.LocalPlayer
					local Character = Player.Character or Player.CharacterAdded:Wait()
					if not Character then
						return
					end
					local Position = Character:GetPivot().Position
					local Chests = CollectionService:GetTagged("_ChestTagged")
					local Distance, Nearest = math.huge, nil
					for i = 1, # Chests do
						local Chest = Chests[i]
						local Magnitude = (Chest:GetPivot().Position - Position).Magnitude
						if not SelectIsland or Chest:IsDescendantOf(SelectIsland) then
							if not Chest:GetAttribute("IsDisabled") and Magnitude < Distance then
								Distance = Magnitude
								Nearest = Chest
							end
						end
					end
					if Nearest then
						Tween(Nearest:GetPivot())
					end
				end
			end)
		end
	end
end)
Tabs.Sea:AddButton({
	Title = "Talk With Stone",
	Callback = function()
		game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("RaceV4Progress", "Begin")
		game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("RaceV4Progress", "Check")
		game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("RaceV4Progress", "Teleport")
		game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("RaceV4Progress", "Continue")
	end
})
Toggle = Tabs.Sea:AddToggle("Toggle", {
	Title = "Auto Look At Moon",
	Default = false
})
Toggle:OnChanged(function(Value)
	LookM = Value
end)
function MoveCamtoMoon()
	workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, game:GetService("Lighting"):GetMoonDirection() + workspace.CurrentCamera.CFrame.Position)
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position, game:GetService("Lighting"):GetMoonDirection() + game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Position)
end
task.spawn(function()
	while task.wait() do
		if LookM then
			MoveCamtoMoon()
			wait(0.1)
			game:GetService("ReplicatedStorage").Remotes.CommE:FireServer("ActivateAbility")
		end
	end
end)
Toggle = Tabs.Race:AddToggle("Toggle", {
	Title = "Auto Evo Human",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.Human = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.Human then
				if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Alchemist", "1") ~= - 2 then
					if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Alchemist", "1") == 0 then
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Alchemist", "2")
					elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Alchemist", "1") == 1 then
						if not game.Players.LocalPlayer.Backpack:FindFirstChild("Flower 1") and not game.Players.LocalPlayer.Character:FindFirstChild("Flower 1") then
							Tween(workspace.Flower1.CFrame)
						elseif not game.Players.LocalPlayer.Backpack:FindFirstChild("Flower 2") and not game.Players.LocalPlayer.Character:FindFirstChild("Flower 2") then
							Tween(workspace.Flower2.CFrame)
						elseif not game.Players.LocalPlayer.Backpack:FindFirstChild("Flower 3") and not game.Players.LocalPlayer.Character:FindFirstChild("Flower 3") then
							local v = GetConnectionEnemies("Swan Pirate")
							if v then
								repeat
									wait()
									Attack.Kill(v, _G.Human)
								until game.Players.LocalPlayer.Backpack:FindFirstChild("Flower 3") or not v.Parent or v.Humanoid.Health <= 0 or not _G.Human
							else
								Tween(CFrame.new(980.0985107421875, 121.331298828125, 1287.2093505859375))
							end
						end
					elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Alchemist", "1") == 2 then
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Alchemist", "3")
					end
				elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Wenlocktoad", "1") == 0 then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Wenlocktoad", "2")
				elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Wenlocktoad", "1") == 1 then
					local v = GetConnectionEnemies("Fajita")
					if v then
						repeat
							wait()
							Attack.Kill(v, _G.Human)
						until v.Humanoid.Health <= 0 or not v.Parent or not _G.Human
					else
						Tween(CFrame.new(-2172.7399902344, 103.32216644287, -4015.025390625))
					end
					local v = GetConnectionEnemies("Jeremy")
					if v then
						repeat
							wait()
							Attack.Kill(v, _G.Human)
						until v.Humanoid.Health <= 0 or not v.Parent or not _G.Human
					else
						Tween(CFrame.new(2006.9261474609, 448.95666503906, 853.98284912109))
					end
					local v = GetConnectionEnemies("Diamond")
					if v then
						repeat
							wait()
							Attack.Kill(v, _G.Human)
						until v.Humanoid.Health <= 0 or not v.Parent or not _G.Human
					else
						Tween(CFrame.new(-1576.7166748047, 198.59265136719, 13.724286079407))
					end
				end
			end
		end)
	end
end)
Toggle = Tabs.Race:AddToggle("Toggle", {
	Title = "Auto Evo Skypiea",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.Skypiea = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.Skypiea then
				if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Alchemist", "1") ~= - 2 then
					if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Alchemist", "1") == 0 then
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Alchemist", "2")
					elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Alchemist", "1") == 1 then
						if not game.Players.LocalPlayer.Backpack:FindFirstChild("Flower 1") and not game.Players.LocalPlayer.Character:FindFirstChild("Flower 1") then
							Tween(workspace.Flower1.CFrame)
						elseif not game.Players.LocalPlayer.Backpack:FindFirstChild("Flower 2") and not game.Players.LocalPlayer.Character:FindFirstChild("Flower 2") then
							Tween(workspace.Flower2.CFrame)
						elseif not game.Players.LocalPlayer.Backpack:FindFirstChild("Flower 3") and not game.Players.LocalPlayer.Character:FindFirstChild("Flower 3") then
							local v = GetConnectionEnemies("Swan Pirate")
							if v then
								repeat
									wait()
									Attack.Kill(v, _G.Skypiea)
								until game.Players.LocalPlayer.Backpack:FindFirstChild("Flower 3") or not v.Parent or v.Humanoid.Health <= 0 or not _G.Skypiea
							else
								Tween(CFrame.new(980.0985107421875, 121.331298828125, 1287.2093505859375))
							end
						end
					elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Alchemist", "1") == 2 then
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Alchemist", "3")
					end
				elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Wenlocktoad", "1") == 0 then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Wenlocktoad", "2")
				elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Wenlocktoad", "1") == 1 then
					for i, v in pairs(game.Players:GetChildren()) do
						if v.Name ~= game.Players.LocalPlayer.Name and tostring(v.Data.Race.Value) == "Skypiea" then
							repeat
								task.wait()
								Tween(v.HumanoidRootPart.CFrame * CFrame.new(0, 8, 0) * CFrame.Angles(math.rad(-45), 0, 0))
							until v.Humanoid.Health <= 0 or not _G.Skypiea
						end
					end
				end
			end
		end)
	end
end)
Toggle = Tabs.Race:AddToggle("Toggle", {
	Title = "Auto Evo FishMan",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.Fish = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.Fish then
				if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Alchemist", "1") ~= - 2 then
					if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Alchemist", "1") == 0 then
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Alchemist", "2")
					elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Alchemist", "1") == 1 then
						if not game.Players.LocalPlayer.Backpack:FindFirstChild("Flower 1") and not game.Players.LocalPlayer.Character:FindFirstChild("Flower 1") then
							Tween(workspace.Flower1.CFrame)
						elseif not game.Players.LocalPlayer.Backpack:FindFirstChild("Flower 2") and not game.Players.LocalPlayer.Character:FindFirstChild("Flower 2") then
							Tween(workspace.Flower2.CFrame)
						elseif not game.Players.LocalPlayer.Backpack:FindFirstChild("Flower 3") and not game.Players.LocalPlayer.Character:FindFirstChild("Flower 3") then
							local v = GetConnectionEnemies("Swan Pirate")
							if v then
								repeat
									wait()
									Attack.Kill(v, _G.Fish)
								until game.Players.LocalPlayer.Backpack:FindFirstChild("Flower 3") or not v.Parent or v.Humanoid.Health <= 0 or not _G.Fish
							else
								Tween(CFrame.new(980.0985107421875, 121.331298828125, 1287.2093505859375))
							end
						end
					elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Alchemist", "1") == 2 then
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Alchemist", "3")
					end
				elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Wenlocktoad", "1") == 0 then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Wenlocktoad", "2")
				elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Wenlocktoad", "1") == 1 then
					warn("Sea Beast Soon")
				end
			end
		end)
	end
end)
Tabs.Race:AddSection("Race V4")
Tiers = Tabs.Race:AddParagraph({
	Title = "Tiers V4",
	Content = "N/A"
})
spawn(function()
	while task.wait() do
		pcall(function()
			local Tiers = game.Players.LocalPlayer.Data.Race.C.Value
			Tiers:SetDesc(Tiers .. "/4")
		end)
	end
end)
Toggle = Tabs.Race:AddToggle("Toggle", {
	Title = "Auto Pull Lever",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.Lver = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		if _G.Lver then
			pcall(function()
				for x, c in pairs(workspace.Map["Temple of Time"]:GetDescendants()) do
					if c.Name == "ProximityPrompt" then
						fireproximityprompt(c, math.huge)
					end
				end
			end)
		end
	end
end)
Toggle = Tabs.Race:AddToggle("Toggle", {
	Title = "Auto Train V4",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.TrainV4 = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.TrainV4 then
				for i = 1, # BonesTable do
					if game.Players.LocalPlayer.Character:FindFirstChild("RaceEnergy").Value == 1 then
						game:GetService("VirtualInputManager"):SendKeyEvent(true, "Y", false, game)
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("UpgradeRace", "Buy")
						Tween(CFrame.new(-8987.041015625, 215.862060546875, 5886.71044921875))
					elseif not game.Players.LocalPlayer.Character:FindFirstChild("RaceTransformed").Value then
						local v = GetConnectionEnemies({"Reborn Skeleton", "Living Zombie", "Demonic Soul", "Posessed Mummy"})
						if v then
							repeat
								wait()
								Attack.Kill(v, _G.TrainV4)
							until not _G.TrainV4 or v.Humanoid.Health <= 0 or not v.Parent
						else
							Tween(CFrame.new(-9495.6806640625, 453.58624267578125, 5977.3486328125))
						end
					end
				end
			end
		end)
	end
end)
Tabs.Race:AddButton({
	Title = "Teleport To Temple Of Time",
	Callback = function()
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(28286.35546875, 14895.3017578125, 102.62469482421875))
	end
})
Tabs.Race:AddButton({
	Title = "Teleport To Ancient One",
	Callback = function()
		local AncientOnePos = CFrame.new(28981.552734375, 14888.4267578125, -120.245849609375)
		_G.TP = true
		repeat
			task.wait()
			Tween(AncientOnePos)
		until (AncientOnePos.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 3
		_G.TP = false
	end
})
Tabs.Race:AddButton({
	Title = "Teleport To Ancient Clock",
	Callback = function()
		local AncientClockPos = CFrame.new(29549, 15069, -88)
		_G.TP = true
		repeat
			task.wait()
			Tween(AncientClockPos)
		until (AncientClockPos.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 3
		_G.TP = false
	end
})
Tabs.Race:AddButton({
	Title = "Teleport To Race Door",
	Callback = function()
		if tostring(game.Players.LocalPlayer.Data.Race.Value) == "Mink" then
			DoorRacePos = CFrame.new(29020.66015625, 14889.4267578125, -379.2682800292969)
		elseif tostring(game.Players.LocalPlayer.Data.Race.Value) == "Fishman" then
			DoorRacePos = CFrame.new(28224.056640625, 14889.4267578125, -210.5872039794922)
		elseif tostring(game.Players.LocalPlayer.Data.Race.Value) == "Cyborg" then
			DoorRacePos = CFrame.new(28492.4140625, 14894.4267578125, -422.1100158691406)
		elseif tostring(game.Players.LocalPlayer.Data.Race.Value) == "Skypiea" then
			DoorRacePos = CFrame.new(28967.408203125, 14918.0751953125, 234.31198120117188)
		elseif tostring(game.Players.LocalPlayer.Data.Race.Value) == "Ghoul" then
			DoorRacePos = CFrame.new(28672.720703125, 14889.1279296875, 454.5961608886719)
		elseif tostring(game.Players.LocalPlayer.Data.Race.Value) == "Human" then
			DoorRacePos = CFrame.new(29237.294921875, 14889.4267578125, -206.94955444335938)
		end
		_G.TP = true
		repeat
			task.wait()
			Tween(DoorRacePos)
		until (DoorRacePos.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 3
		_G.TP = false
	end
})
Toggle = Tabs.Race:AddToggle("Toggle", {
	Title = "Auto Complete Trial Race",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.Trial = Value
	StopTween(Value)
end)
function GetSeaBeastTrial()
	if not workspace.Map:FindFirstChild("FishmanTrial") then
		return nil
	end
	if workspace["_WorldOrigin"].Locations:FindFirstChild("Trial of Water") then
		FishmanTrial = workspace["_WorldOrigin"].Locations:FindFirstChild("Trial of Water")
	end
	if FishmanTrial then
		for _, v in next, workspace.SeaBeasts:GetChildren() do
			if v:FindFirstChild("HumanoidRootPart") and (v.HumanoidRootPart.Position - FishmanTrial.Position).Magnitude <= 1500 then
				if v.Health.Value > 0 then
					return v
				end
			end
		end
	end
end
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.Trial then
				if tostring(game.Players.LocalPlayer.Data.Race.Value) == "Mink" then
					TP(workspace.Map.MinkTrial.Ceiling.CFrame * CFrame.new(0, -20, 0))
				end
			end
		end)
	end
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.Trial then
				if tostring(game.Players.LocalPlayer.Data.Race.Value) == "Fishman" then
					if GetSeaBeastTrial() then
						repeat
							task.wait()
							spawn(function()
								Tween(CFrame.new(GetSeaBeastTrial().HumanoidRootPart.Position.X, game:GetService("Workspace").Map["WaterBase-Plane"].Position.Y + 300, GetSeaBeastTrial().HumanoidRootPart.Position.Z))
							end)
							MousePos = GetSeaBeastTrial().HumanoidRootPart.Position
							Useskillsea()
						until not _G.Trial or not GetSeaBeastTrial()
					end
				end
			end
		end)
	end
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.Trial then
				if tostring(game.Players.LocalPlayer.Data.Race.Value) == "Cyborg" then
					Tween(workspace.Map.CyborgTrial.Floor.CFrame * CFrame.new(0, 500, 0))
				end
			end
		end)
	end
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.Trial then
				if tostring(game.Players.LocalPlayer.Data.Race.Value) == "Skypiea" then
					TP(workspace.Map.SkyTrial.Model.FinishPart.CFrame)
				end
			end
		end)
	end
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.Trial then
				if tostring(game.Players.LocalPlayer.Data.Race.Value) == "Human" or tostring(game.Players.LocalPlayer.Data.Race.Value) == "Ghoul" then
					local v = GetConnectionEnemies({"Ancient Vampire", "Ancient Zombie"})
					if v then
						repeat
							wait()
							Attack.Kill(v, _G.Trial)
						until not _G.Trial or not v.Parent or v.Humanoid.Health <= 0
					end
				end
			end
		end)
	end
end)
Toggle = Tabs.Race:AddToggle("Toggle", {
	Title = "Auto Kill Player After Trial",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.KillPlayerAfterTrial = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.KillPlayerAfterTrial then
				for _, v in pairs(workspace.Characters:GetChildren()) do
					if v.Name ~= game.Players.LocalPlayer.Name then
						if v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart") and v.Parent and (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude <= 250 then
							repeat
								task.wait()
								EquipWeapon(_G.SelectWeapon)
								Tween(v.HumanoidRootPart.CFrame * CFrame.new(0, 0, 15))
								sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
							until not _G.KillPlayerAfterTrial or v.Humanoid.Health <= 0 or not v.Parent or not v:FindFirstChild("HumanoidRootPart") or not v:FindFirstChild("Humanoid")
						end
					end
				end
			end
		end)
	end
end)
Toggle = Tabs.Drago:AddToggle("Toggle", {
	Title = "Auto Dojo Trainer",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.DojoTrainer = Value
	StopTween(Value)
end)
function printBeltName(data)
	if type(data) == "table" and data.Quest["BeltName"] then
		return data.Quest["BeltName"]
	end
end
spawn(function()
	while task.wait() do
		if _G.DojoTrainer then
			pcall(function()
				local args = {
					[1] = {
						["NPC"] = "Dojo Trainer",
						["Command"] = "RequestQuest"
					}
				}
				local progress = game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RF/InteractDragonQuest"):InvokeServer(unpack(args))
				local NameBelt = printBeltName(progress)
				if not debug and not progress and not NameBelt then
					Tween(CFrame.new(5865.0234375, 1208.3154296875, 871.15185546875))
					debug = true
				elseif debug and (CFrame.new(5865.0234375, 1208.3154296875, 871.15185546875).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 50 then
					if NameBelt == "White" then
						local v = GetConnectionEnemies("Skull Slayer")
						if v then
							repeat
								task.wait()
								Attack.Kill(v, _G.DojoTrainer)
							until not progress or not _G.DojoTrainer or not Attack.Alive(v)
						else
							Tween(CFrame.new(-16759.58984375, 71.28376770019531, 1595.3399658203125))
						end
					elseif NameBelt == "Yellow" then
						repeat
							task.wait()
							_G.SeaBeast = true
							_G.Terrorshark = true
							_G.Shark = true
							_G.Piranha = true
							_G.FishCrew = true
							_G.FishBoat = true
							_G.SailBoat = true
						until not _G.DojoTrainer or not progress
						_G.SeaBeast = false
						_G.Terrorshark = false
						_G.Shark = false
						_G.Piranha = false
						_G.FishCrew = false
						_G.FishBoat = false
						_G.SailBoat = false
					elseif NameBelt == "Green" then
						repeat
							task.wait()
							_G.SailBoat = true
						until not _G.DojoTrainer or not progress
						_G.SailBoat = false
					elseif NameBelt == "Purple" then
						repeat
							task.wait()
							_G.EliteHunter = true
						until not _G.DojoTrainer or not progress
						_G.EliteHunter = false
					elseif NameBelt == "Red" then
						repeat
							task.wait()
							_G.SailBoat = true
							_G.FishBoat = true
						until not _G.DojoTrainer or not progress
						_G.SailBoat = false
						_G.FishBoat = false
					elseif NameBelt == "Black" then
						repeat
							task.wait()
							if workspace.Map:FindFirstChild("PrehistoricIsland") or workspace._WorldOrigin.Locations:FindFirstChild("Prehistoric Island") then
								_G.FindPrehistoric = true
								if workspace.Map.PrehistoricIsland.Core.ActivationPrompt:FindFirstChild("ProximityPrompt", true) then
									_G.PatchPrehistoric = false
									_G.FindPrehistoric = true
								else
									_G.PatchPrehistoric = true
									_G.FindPrehistoric = false
								end
							else
								_G.FindPrehistoric = true
								_G.PatchPrehistoric = false
							end
						until not _G.DojoTrainer or not progress
						_G.FindPrehistoric = false
						_G.PatchPrehistoric = false
					elseif NameBelt == "Orange" or NameBelt == "Blue" then
						return nil
					end
				end
				if not progress then
					debug = false
					local args = {
						[1] = {
							["NPC"] = "Dojo Trainer",
							["Command"] = "ClaimQuest"
						}
					}
					game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RF/InteractDragonQuest"):InvokeServer(unpack(args))
				end
			end)
		end
	end
end)
Toggle = Tabs.Drago:AddToggle("Toggle", {
	Title = "Auto Dragon Hunter",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.DragonHunter = Value
	StopTween(Value)
end)
function checkQuesta()
	local args1 = {
		[1] = {
			["Context"] = "Check"
		}
	}
	local b = nil
	pcall(function()
		local args2 = {
			[1] = {
				["Context"] = "RequestQuest"
			}
		}
		game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RF/DragonHunter"):InvokeServer(unpack(args2))
	end)
	local d, e = pcall(function()
		b = game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RF/DragonHunter"):InvokeServer(unpack(args1))
	end)
	local f = false
	local g
	local h
	local i
	if b then
		if b.Text then
			f = true
			local j = b.Text
			if string.find(tostring(j), "Defeat") then
				i = 1
				g = string.sub(tostring(j), 8, 9)
				g = tonumber(g)
				local k = {
					"Hydra Enforcer",
					"Venomous Assailant"
				}
				for l, m in pairs(k) do
					if string.find(j, m) then
						h = m
						break
					end
				end
			elseif string.find(tostring(j), "Destroy") then
				g = 10
				i = 2
				h = nil
			end
		end
	end
	return f, h, g, i
end
function BackTODoJo()
	for a, b in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Notifications:GetChildren()) do
		if b.Name == "NotificationTemplate" then
			if string.find(b.Text, "Head back to the Dojo to complete more tasks") then
				return true
			end
		end
	end
	return false
end
function DragonMobClear(a, b, c)
	if workspace.Enemies:FindFirstChild(b) then
		for d, e in pairs(workspace.Enemies:GetChildren()) do
			if e.Name == b and Attack.Alive(e) then
				if a then
					Attack.Kill(e, a)
				end
			end
		end
	else
		Tween(c)
	end
end
spawn(function()
	while task.wait() do
		if _G.DragonHunter then
			pcall(function()
				local a, v, h, x = checkQuesta()
				if a and not BackTODoJo() then
					if x == 1 then
						if v == "Hydra Enforcer" or v == "Venomous Assailant" then
							repeat
								wait()
								DragonMobClear(true, v, CFrame.new(4620.61572265625, 1002.2954711914062, 399.0868835449219))
							until not _G.DragonHunter or not a or BackTODoJo()
						end
					elseif x == 2 then
						if workspace.Map.Waterfall.IslandModel:FindFirstChild("Meshes/bambootree", true) then
							repeat
								wait()
								spawn(function()
									Tween(workspace.Map.Waterfall.IslandModel:FindFirstChild("Meshes/bambootree", true).CFrame * CFrame.new(4, 0, 0))
								end)
								if (workspace.Map.Waterfall.IslandModel:FindFirstChild("Meshes/bambootree", true).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 200 then
									MousePos = workspace.Map.Waterfall.IslandModel:FindFirstChild("Meshes/bambootree", true).Position
									Useskillsea()
								end
							until not _G.DragonHunter or not a or BackTODoJo()
						end
					end
				else
					Tween(CFrame.new(5813, 1208, 884))
					DragonMobClear(false, nil, nil)
				end
			end)
		end
	end
end)
spawn(function()
	while task.wait() do
		if _G.DragonHunter then
			pcall(function()
				if workspace.EmberTemplate:FindFirstChild("Part") then
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.EmberTemplate.Part.CFrame
				end
			end)
		end
	end
end)
Tabs.Drago:AddSection("Drago Trial")
function GetQuestDragoLevel()
	local args = {
		[1] = {
			["NPC"] = "Dragon Wizard",
			["Command"] = "Upgrade"
		}
	}
	return game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RF/InteractDragonQuest"):InvokeServer(unpack(args))
end
Toggle = Tabs.Drago:AddToggle("Toggle", {
	Title = "Auto Upgrade Drago Trial",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.UpgradeDragoTrial = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.UpgradeDragoTrial then
				if not GetQuestDragoLevel() then
					return nil
				elseif GetQuestDragoLevel() then
					if (CFrame.new(5814.42724609375, 1208.3267822265625, 884.5785522460938).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude >= 300 then
						Tween(CFrame.new(5814.42724609375, 1208.3267822265625, 884.5785522460938))
					else
						Tween(CFrame.new(5814.42724609375, 1208.3267822265625, 884.5785522460938))
						local args = {
							[1] = {
								["NPC"] = "Dragon Wizard",
								["Command"] = "Upgrade"
							}
						}
						game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RF/InteractDragonQuest"):InvokeServer(unpack(args))
					end
				end
			end
		end)
	end
end)
Toggle = Tabs.Drago:AddToggle("Toggle", {
	Title = "Auto Drago V1",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.DragoV1 = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.DragoV1 then
				if GetM("Dragon Egg") <= 0 then
					repeat
						wait()
						_G.FindPrehistoric = true
						_G.PatchPrehistoric = true
						_G.DragonEgg = true
					until not _G.DragoV1 or GetM("Dragon Egg") >= 1
					_G.FindPrehistoric = false
					_G.PatchPrehistoric = false
					_G.DragonEgg = false
				end
			end
		end)
	end
end)
Toggle = Tabs.Drago:AddToggle("Toggle", {
	Title = "Auto Drago V2",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.DragoV2 = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		if _G.DragoV2 then
			local FireFlower = workspace:FindFirstChild("FireFlowers")
			local v = GetConnectionEnemies("Forest Pirate")
			if v then
				repeat
					wait()
					Attack.Kill(v, _G.DragoV2)
				until not _G.DragoV2 or not v.Parent or v.Humanoid.Health <= 0 or FireFlower
			else
				Tween(CFrame.new(-13206.452148438, 425.89199829102, -7964.5537109375))
			end
			if FireFlower then
				for i, v in pairs(FireFlower:GetChildren()) do
					if (v:IsA("Model") and v.PrimaryPart) then
						local FlowerPos = v.PrimaryPart.Position
						local playerRoot = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
						local Magnited = (FlowerPos - playerRoot).Magnitude
						if (Magnited <= 100) then
							game:GetService("VirtualInputManager"):SendKeyEvent(true, "E", false, game)
							wait(1.5)
							game:GetService("VirtualInputManager"):SendKeyEvent(false, "E", false, game)
						else
							Tween(CFrame.new(FlowerPos))
						end
					end
				end
			end
		end
	end
end)
Toggle = Tabs.Drago:AddToggle("Toggle", {
	Title = "Auto Drago V3",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.DragoV3 = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.DragoV3 then
				repeat
					wait()
					_G.SelectZone = "Lv Infinite"
					_G.SailBoat = true
					_G.Terrorshark = true
				until not _G.DragoV3
				_G.SelectZone = "Lv 1"
				_G.SailBoat = false
				_G.Terrorshark = false
			end
		end)
	end
end)
Toggle = Tabs.Drago:AddToggle("Toggle", {
	Title = "Auto Relic Drago Trial",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.RelicDragoTrial = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		if _G.RelicDragoTrial then
			pcall(function()
				if workspace.Map:FindFirstChild("DracoTrial") then
					game:GetService("ReplicatedStorage").Remotes.DracoTrial:InvokeServer()
					wait(0.5)
					repeat
						wait()
						Tween(CFrame.new(-39934.9765625, 10685.359375, 22999.34375))
					until not _G.RelicDragoTrial or (game.Players.LocalPlayer.Character.HumanoidRootPart.Position == CFrame.new(-39934.9765625, 10685.359375, 22999.34375).Position)
					repeat
						wait()
						Tween(CFrame.new(-40511.25390625, 9376.4013671875, 23458.37890625))
					until not _G.RelicDragoTrial or (game.Players.LocalPlayer.Character.HumanoidRootPart.Position == CFrame.new(-40511.25390625, 9376.4013671875, 23458.37890625).Position)
					wait(2.5)
					repeat
						wait()
						Tween(CFrame.new(-39914.65625, 10685.384765625, 23000.177734375))
					until not _G.RelicDragoTrial or (game.Players.LocalPlayer.Character.HumanoidRootPart.Position == CFrame.new(-39914.65625, 10685.384765625, 23000.177734375).Position)
					repeat
						wait()
						Tween(CFrame.new(-40045.83203125, 9376.3984375, 22791.287109375))
					until not _G.RelicDragoTrial or (game.Players.LocalPlayer.Character.HumanoidRootPart.Position == CFrame.new(-40045.83203125, 9376.3984375, 22791.287109375).Position)
					wait(2.5)
					repeat
						wait()
						Tween(CFrame.new(-39908.5, 10685.4052734375, 22990.04296875))
					until not _G.RelicDragoTrial or (game.Players.LocalPlayer.Character.HumanoidRootPart.Position == CFrame.new(-39908.5, 10685.4052734375, 22990.04296875).Position)
					repeat
						wait()
						Tween(CFrame.new(-39609.5, 9376.400390625, 23472.94335975))
					until not _G.RelicDragoTrial or (game.Players.LocalPlayer.Character.HumanoidRootPart.Position == CFrame.new(-39609.5, 9376.400390625, 23472.94335975).Position)
				else
					local drago = workspace.Map.PrehistoricIsland:FindFirstChild("TrialTeleport")
					if drago and drago:IsA("Part") then
						Tween(CFrame.new(drago.Position))
					end
				end
			end)
		end
	end
end)
Toggle = Tabs.Drago:AddToggle("Toggle", {
	Title = "Auto Train Drago V4",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.TrainDrago = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.TrainDrago then
				for i = 1, # DragoM do
					if game.Players.LocalPlayer.Character:FindFirstChild("RaceEnergy").Value == 1 then
						game:GetService("VirtualInputManager"):SendKeyEvent(true, "Y", false, game)
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("UpgradeRace", "Buy", 2)
						Tween(CFrame.new(4620.61572265625, 1002.2954711914062, 399.0868835449219))
					elseif not game.Players.LocalPlayer.Character:FindFirstChild("RaceTransformed").Value then
						local v = GetConnectionEnemies({"Venomous Assailant", "Hydra Enforcer"})
						if v then
							repeat
								wait()
								Attack.Kill(v, _G.TrainDrago)
							until not _G.TrainDrago or v.Humanoid.Health <= 0 or not v.Parent
						else
							Tween(CFrame.new(4620.61572265625, 1002.2954711914062, 399.0868835449219))
						end
					end
				end
			end
		end)
	end
end)
Toggle = Tabs.Drago:AddToggle("Toggle", {
	Title = "Auto Teleport To Drago Trial",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.TPDragoTrial = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		if _G.TPDragoTrial then
			local v748 = workspace.Map.PrehistoricIsland:FindFirstChild("TrialTeleport")
			if (v748 and v748:IsA("Part")) then
				Tween(CFrame.new(v748.Position))
			end
		end
	end
end)
Toggle = Tabs.Drago:AddToggle("Toggle", {
	Title = "Auto Buy Drago Race",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.BuyDrago = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		if _G.BuyDrago then
			pcall(function()
				if (CFrame.new(5814.42724609375, 1208.3267822265625, 884.5785522460938).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude >= 300 then
					Tween(CFrame.new(5814.42724609375, 1208.3267822265625, 884.5785522460938))
				else
					Tween(CFrame.new(5814.42724609375, 1208.3267822265625, 884.5785522460938))
					local args = {
						[1] = {
							["NPC"] = "Dragon Wizard",
							["Command"] = "DragonRace"
						}
					}
					game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RF/InteractDragonQuest"):InvokeServer(unpack(args))
				end
			end)
		end
	end
end)
Toggle = Tabs.Drago:AddToggle("Toggle", {
	Title = "Auto Upgrade Dragon Talon With Uzoth",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.UpgardeDragonTalon = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		if _G.UpgardeDragonTalon then
			local Uz_POS = CFrame.new(5661.89014, 1211.31909, 864.836731, 0.811413169, -1.36805838e-08, -0.584473014, 4.75227395e-08, 1, 4.25682458e-08, 0.584473014, -6.23161966e-08, 0.811413169)
			Tween(Uz_POS)
			if (Uz_POS.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 25 then
				local ohTable1 = {
					["NPC"] = "Uzoth",
					["Command"] = "Upgrade"
				}
				game:GetService("ReplicatedStorage").Modules.Net["RF/InteractDragonQuest"]:InvokeServer(ohTable1)
			end
		end
	end
end)
Tabs.Volcano:AddSection("Volcanic Magnet")
Toggle = Tabs.Volcano:AddToggle("Toggle", {
	Title = "Auto Craft Volcanic Magnet",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.VolcanicMagnet = Value
	StopTween(Value)
end)
Tabs.Volcano:AddButton({
	Title = "Craft Volcanic Magnet",
	Callback = function()
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CraftItem", "Craft", "Volcanic Magnet")
	end
})
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.VolcanicMagnet then
				if GetM("Volcanic Magnet") < 1 then
					if GetM("Scrap Metal") >= 10 and GetM("Blaze Ember") >= 15 then
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CraftItem", "Craft", "Volcanic Magnet")
					elseif GetM("Scrap Metal") < 10 then
						local v = GetConnectionEnemies("Forest Pirate")
						if v then
							repeat
								wait()
								Attack.Kill(v, _G.VolcanicMagnet)
							until not _G.VolcanicMagnet or not v.Parent or v.Humanoid.Health <= 0 or GetM("Scrap Metal") >= 10
						else
							Tween(CFrame.new(-13206.452148438, 425.89199829102, -7964.5537109375))
						end
					elseif GetM("Blaze Ember") < 15 then
						repeat
							wait()
							_G.DragonHunter = true
						until not _G.VolcanicMagnet or GetM("Blaze Ember") >= 15
						_G.DragonHunter = false
					end
				end
			end
		end)
	end
end)
Tabs.Volcano:AddSection("Prehistoric Island")
Toggle = Tabs.Volcano:AddToggle("Toggle", {
	Title = "Auto Find Prehistoric Island",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.FindPrehistoric = Value
	StopTween(Value)
end)
targetDestination = nil
spawn(function()
	while task.wait() do
		if _G.FindPrehistoric then
			pcall(function()
				if not workspace["_WorldOrigin"].Locations:FindFirstChild("Prehistoric Island", true) then
					local myBoat = CheckBoat()
					if not myBoat then
						local buyBoatCFrame = CFrame.new(-16927.451, 9.086, 433.864)
						Tween(buyBoatCFrame)
						if (buyBoatCFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 10 then
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBoat", _G.SelectBoat)
						end
					else
						if not game.Players.LocalPlayer.Character.Humanoid.Sit then
							local boatSeatCFrame = myBoat.VehicleSeat.CFrame * CFrame.new(0, 1, 0)
							Tween(boatSeatCFrame)
						else
							repeat
								wait()
								local targetDestination = CFrame.new(-10000000, 31, 37016.25)
								if CheckEnemiesBoat() or CheckTerrorshark() or CheckPirateGrandBrigade() then
									Tween(CFrame.new(-10000000, 150, 37016.25))
								else
									Tween(CFrame.new(-10000000, 31, 37016.25))
								end
							until not _G.FindPrehistoric or (targetDestination.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 10 or workspace["_WorldOrigin"].Locations:FindFirstChild("Prehistoric Island") or not game.Players.LocalPlayer.Character.Humanoid.Sit
							game.Players.LocalPlayer.Character.Humanoid.Sit = false
						end
					end
				else
					if (workspace["_WorldOrigin"].Locations:FindFirstChild("Prehistoric Island").CFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude >= 2000 then
						Tween(workspace["_WorldOrigin"].Locations:FindFirstChild("Prehistoric Island").CFrame)
					end
					if workspace.Map:FindFirstChild("PrehistoricIsland", true) or workspace["_WorldOrigin"].Locations:FindFirstChild("Prehistoric Island", true) then
						if workspace.Map.PrehistoricIsland.Core.ActivationPrompt:FindFirstChild("ProximityPrompt", true) then
							if game.Players.LocalPlayer:DistanceFromCharacter(workspace.Map.PrehistoricIsland.Core.ActivationPrompt.CFrame.Position) <= 150 then
								fireproximityprompt(workspace.Map.PrehistoricIsland.Core.ActivationPrompt.ProximityPrompt, math.huge)
								game:GetService("VirtualInputManager"):SendKeyEvent(true, "E", false, game)
								wait(1.5)
								game:GetService("VirtualInputManager"):SendKeyEvent(false, "E", false, game)
							end
							Tween(workspace.Map.PrehistoricIsland.Core.ActivationPrompt.CFrame)
						end
					end
				end
			end)
		end
	end
end)
Toggle = Tabs.Volcano:AddToggle("Toggle", {
	Title = "Auto Patch Prehistoric Event",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.PatchPrehistoric = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		if _G.PatchPrehistoric then
			local prehistoricIsland = game.Workspace.Map:FindFirstChild("PrehistoricIsland")
			if prehistoricIsland then
				for _, obj in pairs(prehistoricIsland:GetDescendants()) do
					if obj:IsA("Part") and obj.Name:lower():find("lava") then
						obj:Destroy()
					end
					if obj:IsA("MeshPart") and obj.Name:lower():find("lava") then
						obj:Destroy()
					end
				end
				local lavaModel = game.Workspace.Map.PrehistoricIsland.Core:FindFirstChild("InteriorLava")
				if lavaModel and lavaModel:IsA("Model") then
					lavaModel:Destroy()
				end
				local Island = workspace.Map:FindFirstChild("PrehistoricIsland")
				if Island then
					local trialTeleport = workspace.Map.PrehistoricIsland:FindFirstChild("TrialTeleport")
					for _, v in pairs(Island:GetDescendants()) do
						if v.Name == "TouchInterest" then
							if not (trialTeleport and v:IsDescendantOf(trialTeleport)) then
								v.Parent:Destroy()
							end
						end
					end
				end
			end
		end
	end
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.PatchPrehistoric then
				if workspace.Enemies:FindFirstChild("Lava Golem") then
					local v = GetConnectionEnemies("Lava Golem")
					if v then
						repeat
							wait()
							Attack.Kill(v, _G.PatchPrehistoric)
							v.Humanoid:ChangeState(15)
						until not _G.PatchPrehistoric or not v.Parent or v.Humanoid.Health <= 0
					end
				end
				for i, v in pairs(game.Workspace.Map.PrehistoricIsland.Core.VolcanoRocks:GetChildren()) do
					if v:FindFirstChild("VFXLayer") then
						if v:FindFirstChild("VFXLayer").At0.Glow.Enabled or v.VFXLayer.At0.Glow.Enabled then
							repeat
								wait()
								Tween(v.VFXLayer.CFrame)
								if v.VFXLayer.At0.Glow.Enabled and game.Players.LocalPlayer:DistanceFromCharacter(v.VFXLayer.CFrame.Position) <= 150 then
									MousePos = v.VFXLayer.CFrame.Position
									Useskillsea()
								end
							until not _G.PatchPrehistoric or not v:FindFirstChild("VFXLayer").At0.Glow.Enabled or not v.VFXLayer.At0.Glow.Enabled
						end
					end
				end
			end
		end)
	end
end)
Toggle = Tabs.Volcano:AddToggle("Toggle", {
	Title = "Auto Collect Dino Bone",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.DinoBone = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.DinoBone then
				if workspace:FindFirstChild("DinoBone") then
					for i, v in pairs(workspace:GetChildren()) do
						if v.Name == "DinoBone" then
							Tween(v.CFrame)
						end
					end
				end
			end
		end)
	end
end)
Toggle = Tabs.Volcano:AddToggle("Toggle", {
	Title = "Auto Collect Dragon Egg",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.DragonEgg = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.DragonEgg then
				if workspace.Map.PrehistoricIsland.Core.SpawnedDragonEggs:FindFirstChild("DragonEgg") then
					Tween(workspace.Map.PrehistoricIsland.Core.SpawnedDragonEggs:FindFirstChild("DragonEgg").Molten.CFrame)
					fireproximityprompt(workspace.Map.PrehistoricIsland.Core.SpawnedDragonEggs.DragonEgg.Molten.ProximityPrompt, 30)
				end
			end
		end)
	end
end)
Toggle = Tabs.Volcano:AddToggle("Toggle", {
	Title = "Auto Reset When Complete Volcano",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.ResetPH = Value
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.ResetPH then
				local v748 = workspace.Map.PrehistoricIsland:FindFirstChild("TrialTeleport")
				if (v748 and v748:FindFirstChild("TouchInterest")) then
					game.Players.LocalPlayer.Character.Humanoid.Health = 0
				else
					if workspace:FindFirstChild("DinoBone") then
						for i, v in pairs(workspace:GetChildren()) do
							if v.Name == "DinoBone" then
								Tween(v.CFrame)
							end
						end
					end
				end
			end
		end)
	end
end)
Tabs.Raid:AddSection("Raid")
Raid = Tabs.Raid:AddParagraph({
	Title = "Raiding",
	Content = "N/A"
})
spawn(function()
	while task.wait() do
		pcall(function()
			if game.Players.LocalPlayer.PlayerGui.Main.Timer.Visible then
				Raid:SetDesc("✅")
			else
				Raid:SetDesc("❌")
			end
		end)
	end
end)
DungeonTables = {
	"Flame",
	"Ice",
	"Quake",
	"Light",
	"Dark",
	"String",
	"Rumble",
	"Magma",
	"Human: Buddha",
	"Sand",
	"Bird: Phoenix",
	"Dough"
}
Dropdown = Tabs.Raid:AddDropdown("Dropdown", {
	Title = "Select Chip",
	Values = DungeonTables,
	Multi = false,
	Default = 1
})
Dropdown:OnChanged(function(Value)
	_G.SelectChip = Value
end)
Toggle = Tabs.Raid:AddToggle("Toggle", {
	Title = "Auto Select Dungeon Chip",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.SelectDungeon = Value
end)
spawn(function()
	while task.wait() do
		if _G.SelectDungeon then
			pcall(function()
				if GetBP("Flame-Flame") then
					_G.SelectChip = "Flame"
				elseif GetBP("Ice-Ice") then
					_G.SelectChip = "Ice"
				elseif GetBP("Quake-Quake") then
					_G.SelectChip = "Quake"
				elseif GetBP("Light-Light") then
					_G.SelectChip = "Light"
				elseif GetBP("Dark-Dark") then
					_G.SelectChip = "Dark"
				elseif GetBP("String-String") then
					_G.SelectChip = "String"
				elseif GetBP("Rumble-Rumble") then
					_G.SelectChip = "Rumble"
				elseif GetBP("Magma-Magma") then
					_G.SelectChip = "Magma"
				elseif GetBP("Human-Human: Buddha Fruit") then
					_G.SelectChip = "Human: Buddha"
				elseif GetBP("Dough-Dough") then
					_G.SelectChip = "Dough"
				elseif GetBP("Sand-Sand") then
					_G.SelectChip = "Sand"
				elseif GetBP("Bird-Bird: Phoenix") then
					_G.SelectChip = "Bird: Phoenix"
				else
					_G.SelectChip = "Ice"
				end
			end)
		end
	end
end)
Tabs.Raid:AddButton({
	Title = "Buy Chip With Beli",
	Callback = function()
		if not GetBP("Special Microchip") then
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("RaidsNpc", "Select", _G.SelectChip)
		end
	end
})
Tabs.Raid:AddButton({
	Title = "Buy Chip With Fruit",
	Callback = function()
		if GetBP("Special Microchip") then
			return
		end
		local FruitPrice = {}
		local FruitStore = {}
		for i, v in next, game:GetService("ReplicatedStorage"):WaitForChild("Remotes").CommF_:InvokeServer("GetFruits") do
			if v.Price <= 490000 then
				table.insert(FruitPrice, v.Name)
			end
		end
		for _, y in pairs(FruitPrice) do
			for i, v in pairs(DungeonTables) do
				if not GetBP("Special Microchip") then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LoadFruit", tostring(y))
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("RaidsNpc", "Select", _G.SelectChip)
				end
			end
		end
	end
})
Tabs.Raid:AddSection("Option")
Toggle = Tabs.Raid:AddToggle("Toggle", {
	Title = "Auto Start Raid",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.StartRaid = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.StartRaid then
				if not game.Players.LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible then
					if GetBP("Special Microchip") then
						if World2 then
							Tween(CFrame.new(-6438.73535, 250.645355, -4501.50684))
							fireclickdetector(workspace.Map["CircleIsland"].RaidSummon2.Button.Main.ClickDetector)
						elseif World3 then
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-5097.93164, 316.447021, -3142.66602, -0.405007899, -4.31682743e-08, 0.914313197, -1.90943332e-08, 1, 3.8755779e-08, -0.914313197, -1.76180437e-09, -0.405007899))
							fireclickdetector(workspace.Map["Boat Castle"].RaidSummon2.Button.Main.ClickDetector)
						end
					end
				end
			end
		end)
	end
end)
Toggle = Tabs.Raid:AddToggle("Toggle", {
	Title = "Auto Teleport To Lab",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.TPLab = Value
	while _G.TPLab do
		wait(0.2)
		if _G.TPLab then
			if World2 and _G.TPLab then
				Tween(CFrame.new(-6438.73535, 250.645355, -4501.50684))
			elseif World3 and _G.TPLab then
				Tween(CFrame.new(-5017.40869, 314.844055, -2823.0127, -0.925743818, 4.48217499e-08, -0.378151238, 4.55503146e-09, 1, 1.07377559e-07, 0.378151238, 9.7681621e-08, -0.925743818))
			end
		end
	end
end)
Toggle = Tabs.Raid:AddToggle("Toggle", {
	Title = "Auto Complete Raid",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.Raid = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.Raid then
				if game.Players.LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible then
					local islands = {
						"Island5",
						"Island 4",
						"Island 3",
						"Island 2",
						"Island 1"
					}
					for _, island in ipairs(islands) do
						local location = game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild(island)
						if location then
							for i, v in pairs(workspace.Enemies:GetChildren()) do
								if v:FindFirstChild("Humanoid") or v:FindFirstChild("HumanoidRootPart") then
									if v.Humanoid.Health > 0 then
										repeat
											wait()
											Attack.Kill(v, _G.Raid)
											_G.NextIsland = false
										until not _G.Raid or not v.Parent or v.Humanoid.Health <= 0
										_G.NextIsland = true
									end
								end
							end
						end
					end
				else
					_G.NextIsland = false
				end
			else
				_G.NextIsland = false
			end
		end)
	end
end)
Toggle = Tabs.Raid:AddToggle("Toggle", {
	Title = "Auto Next Island",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.NextIsland = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		if _G.NextIsland then
			if game.Players.LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible then
				if workspace["_WorldOrigin"].Locations:FindFirstChild("Island 5") then
					Tween(workspace["_WorldOrigin"].Locations:FindFirstChild("Island 5").CFrame * CFrame.new(0, 50, 100))
				elseif workspace["_WorldOrigin"].Locations:FindFirstChild("Island 4") then
					Tween(workspace["_WorldOrigin"].Locations:FindFirstChild("Island 4").CFrame * CFrame.new(0, 50, 100))
				elseif workspace["_WorldOrigin"].Locations:FindFirstChild("Island 3") then
					Tween(workspace["_WorldOrigin"].Locations:FindFirstChild("Island 3").CFrame * CFrame.new(0, 50, 100))
				elseif workspace["_WorldOrigin"].Locations:FindFirstChild("Island 2") then
					Tween(workspace["_WorldOrigin"].Locations:FindFirstChild("Island 2").CFrame * CFrame.new(0, 50, 100))
				elseif workspace["_WorldOrigin"].Locations:FindFirstChild("Island 1") then
					Tween(workspace["_WorldOrigin"].Locations:FindFirstChild("Island 1").CFrame * CFrame.new(0, 50, 100))
				end
			end
		end
	end
end)
Toggle = Tabs.Raid:AddToggle("Toggle", {
	Title = "Auto Awakening",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.Awakener = Value
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.Awakener then
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Awakener", "Check")
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Awakener", "Awaken")
			end
		end)
	end
end)
Tabs.Raid:AddSection("Raid Law")
Toggle = Tabs.Raid:AddToggle("Toggle", {
	Title = "Auto Raid Law",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.RaidLaw = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		if _G.RaidLaw then
			pcall(function()
				local v = GetConnectionEnemies("Order")
				if v then
					repeat
						task.wait()
						Attack.Kill(v, _G.RaidLaw)
					until not _G.RaidLaw or not v.Parent or v.Humanoid.Health <= 0
				else
					Tween(CFrame.new(-6217.2021484375, 28.047645568848, -5053.1357421875))
				end
			end)
		end
	end
end)
Tabs.Raid:AddButton({
	Title = "Buy Chip Law",
	Callback = function()
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "Microchip", "2")
	end
})
Tabs.Raid:AddButton({
	Title = "Start Law Raid",
	Callback = function()
		fireclickdetector(workspace.Map.CircleIsland.RaidSummon.Button.Main.ClickDetector)
	end
})
Tabs.Raid:AddSection("Dungeon")
Tabs.Raid:AddButton({
	Title = "Telpeort To Dungeon Hub",
	Callback = function()
		Net:WaitForChild("RF/DungeonNPCFunction"):InvokeServer("TeleportToDungeonHub", false)
	end
})
Toggle = Tabs.Raid:AddToggle("Toggle", {
	Title = "Auto Complete Dungeon",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.Dungeon = Value
	StopTween(Value)
end)
function getHighestFloor()
	local highest = 1
	local highestFloor = nil
	for _, v in pairs(workspace.Map.Dungeon:GetChildren()) do
		local num = tonumber(v.Name)
		if num and num > highest then
			highest = num
			highestFloor = v
		end
	end
	return highestFloor
end
function getCurrentFloor()
	local highest = 1
	for _, v in pairs(workspace.Map.Dungeon:GetChildren()) do
		local num = tonumber(v.Name)
		if num and num > highest then
			highest = num
		end
	end
	local targetFloor = tostring(highest - 2)
	return workspace.Map.Dungeon:FindFirstChild(targetFloor)
end
spawn(function()
	while task.wait() do
		if _G.Dungeon then
			pcall(function()
				if (getHighestFloor().HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 9000 then
					for i, v in pairs(workspace.Enemies:GetChildren()) do
						if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
							if not string.find(v.Name, "Blank Buddy") then
								repeat
									task.wait()
									Attack.Kill(v, _G.Dungeon)
								until v.Humanoid.Health <= 0 or not v.Humanoid or not v.HumanoidRootPart or not _G.Dungeon
							end
						end
					end
				else
					firetouchinterest(getCurrentFloor().ExitTeleporter.HumanoidRootPart, HumanoidRootPart, 0)
					firetouchinterest(getCurrentFloor().ExitTeleporter.HumanoidRootPart, HumanoidRootPart, 1)
					wait(0.5)
				end
			end)
		end
	end
end)
Toggle = Tabs.Raid:AddToggle("Toggle", {
	Title = "Auto Choose Card",
	Description = "Prioritize Choosing Melee & Lifestyle",
	Default = true
})
Toggle:OnChanged(function(Value)
	_G.Card = Value
end)
function findTextButton(obj)
	for _, v in ipairs(obj:GetDescendants()) do
		if v:IsA("TextButton") then
			return v
		end
	end
	return nil
end
spawn(function()
	while task.wait() do
		if _G.Card then
			pcall(function()
				for i, v in pairs(game.Players.LocalPlayer.PlayerGui:GetChildren()) do
					if v.Name == "Gui" and #v:GetChildren() > 0 then
						local btn = findTextButton(v)
						local DisplayName = v:FindFirstChild("DisplayName").Text
						if string.find(displayName, "Melee") or DisplayName == "Lifestyle" then
							firesignal(btn.Activated)
						else
							firesignal(btn.Activated)
						end
					end
				end
			end)
		end
	end
end)
PlrList = {}
for _, v in pairs(game:GetService("Players"):GetChildren()) do
	table.insert(PlrList, v.Name)
end
Dropdown = Tabs.Player:AddDropdown("Dropdown", {
	Title = "Select Player",
	Values = PlrList,
	Multi = false,
	Default = 1
})
Dropdown:OnChanged(function(Value)
	_G.SelectPlayer = Value
end)
Toggle = Tabs.Player:AddToggle("Toggle", {
	Title = "Auto Teleport To Player",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.TPPlayer = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		if _G.TPPlayer then
			pcall(function()
				Tween(game:GetService("Players")[_G.SelectPlayer].Character.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
			end)
		end
	end
end)
Toggle = Tabs.Player:AddToggle("Toggle", {
	Title = "Spectate Select Player",
	Default = false
})
Toggle:OnChanged(function(Value)
	SpectatePlys = Value
	repeat
		task.wait(0.1)
		workspace.Camera.CameraSubject = game:GetService("Players"):FindFirstChild(_G.SelectPlayer).Character.Humanoid
	until not SpectatePlys
	workspace.Camera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
end)
Toggle = Tabs.Player:AddToggle("Toggle", {
	Title = "Auto Skill Aimbot",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.AimSkill = Value
end)
task.spawn(function()
	while task.wait() do
		pcall(function()
			if _G.AimSkill then
				for i, v in pairs(game:GetService("Players"):GetPlayers()) do
					if v.Name == _G.SelectPlayer and v.Team ~= game.Players.LocalPlayer.Team then
						MousePos = v.Character:FindFirstChild("HumanoidRootPart").Position
					end
				end
			end
		end)
	end
end)
Toggle = Tabs.Player:AddToggle("Toggle", {
	Title = "Auto Aimbot Nearest",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.AimNearest = Value
end)
task.spawn(function()
	while task.wait() do
		pcall(function()
			if _G.AimNearest then
				local MaxDistance = math.huge
				for i, v in pairs(game:GetService("Players"):GetPlayers()) do
					if v.Name ~= game.Players.LocalPlayer.Name and v.Team ~= game.Players.LocalPlayer.Team then
						local Distance = v:DistanceFromCharacter(game.Players.LocalPlayer.Character.HumanoidRootPart.Position)
						if Distance < MaxDistance then
							MaxDistance = Distance
							MousePos = v.Character:FindFirstChild("HumanoidRootPart").Position
						end
					end
				end
			end
		end)
	end
end)
Toggle = Tabs.Player:AddToggle("Toggle", {
	Title = "Auto Look Camera Closet Player",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.LockCam = Value
end)
task.spawn(function()
	while task.wait() do
		pcall(function()
			if _G.LockCam then
				local camera = workspace.CurrentCamera
				function closestplayer()
					local dist = math.huge
					local target = nil
					for _, v in next, game.Players:GetPlayers() do
						if v ~= game.Players.LocalPlayer then
							if v.Character and v.Character:FindFirstChild("Head") and _G.LockCam and v.Character.Humanoid.Health > 0 then
								local Mag = (v.Character.Head.Position - game.Players.LocalPlayer.Character.Head.Position).Magnitude
								if Mag < dist then
									dist = Mag
									target = v
								end
							end
						end
					end
					return target
				end
				repeat
					task.wait()
					camera.CFrame = CFrame.new(camera.CFrame.Position, closestplayer().Character.HumanoidRootPart.Position)
				until not _G.LockCam or Mag > dist
			end
		end)
	end
end)
Toggle = Tabs.Player:AddToggle("Toggle", {
	Title = "Accept Ally",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.AcceptAlly = Value
end)
spawn(function()
	while task.wait() do
		if _G.AcceptAlly then
			pcall(function()
				for _, v in pairs(game.Players:GetChildren()) do
					if v.Name ~= game.Players.LocalPlayer.Name and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
						game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("AcceptAlly", v.Name)
					end
				end
			end)
		end
	end
end)
Tabs.Player:AddSection("Local Player")
Toggle = Tabs.Player:AddToggle("Toggle", {
	Title = "Infinity Ablitie",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.InfAblitie = Value
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.InfAblitie then
				if not game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("Agility") then
					local agility = game:GetService("ReplicatedStorage").FX["Agility"]:Clone()
					agility.Name = "Agility"
					agility.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
				end
			else
				game.Players.LocalPlayer.Character.HumanoidRootPart["Agility"]:Destroy()
			end
		end)
	end
end)
Toggle = Tabs.Player:AddToggle("Toggle", {
	Title = "Infinity Energy",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.InfEnergy = Value
	if Value then
		getInfinity_Ability("Energy", _G.InfEnergy)
	end
end)
Toggle = Tabs.Player:AddToggle("Toggle", {
	Title = "Infinity Soru",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.InfSoru = Value
	if Value then
		getInfinity_Ability("Soru", _G.InfSoru)
	end
end)
Toggle = Tabs.Player:AddToggle("Toggle", {
	Title = "Infinity Observation Range",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.InfObs = Value
	if Value then
		getInfinity_Ability("Observation", _G.InfObs)
	end
end)
Tabs.Player:AddSection("Stats")
Slider = Tabs.Player:AddSlider("Slider", {
	Title = "Stats Value",
	Default = 10,
	Min = 0,
	Max = 100,
	Rounding = 0.5,
	Callback = function(Value)
		_G.StatsValue = Value
	end
})
Toggle = Tabs.Player:AddToggle("Toggle", {
	Title = "Auto Melee",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.Melee = Value
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.Melee then
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Melee", _G.StatsValue)
			end
		end)
	end
end)
Toggle = Tabs.Player:AddToggle("Toggle", {
	Title = "Auto Defense",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.Defense = Value
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.Defense then
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Defense", _G.StatsValue)
			end
		end)
	end
end)
Toggle = Tabs.Player:AddToggle("Toggle", {
	Title = "Auto Sword",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.Sword = Value
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.Sword then
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Sword", _G.StatsValue)
			end
		end)
	end
end)
Toggle = Tabs.Player:AddToggle("Toggle", {
	Title = "Auto Gun",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.Gun = Value
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.Gun then
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Gun", _G.StatsValue)
			end
		end)
	end
end)
Toggle = Tabs.Player:AddToggle("Toggle", {
	Title = "Auto Demon Fruit",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.DemonFruit = Value
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.DemonFruit then
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Demon Fruit", _G.StatsValue)
			end
		end)
	end
end)
Tabs.Visual:AddSection("Esp")
function isnil(thing)
	return (thing == nil)
end
function round(n)
	return math.floor(tonumber(n) + 0.5)
end
Number = math.random(1, 1000000)
function EspPly()
	for _, v in next, game.Players:GetChildren() do
		pcall(function()
			if not isnil(v.Character) then
				if PlayerEsp then
					if not isnil(v.Character.Head) and not v.Character.Head:FindFirstChild("NameEsp" .. Number) then
						local bill = Instance.new("BillboardGui", v.Character.Head)
						bill.Name = "NameEsp" .. Number
						bill.ExtentsOffset = Vector3.new(0, 1, 0)
						bill.Size = UDim2.new(1, 200, 1, 30)
						bill.Adornee = v.Character.Head
						bill.AlwaysOnTop = true
						local name = Instance.new("TextLabel", bill)
						name.Font = Enum.Font.Code
						name.FontSize = "Size14"
						name.TextWrapped = true
						name.Text = (v.Name .. "\n" .. round((game:GetService("Players").LocalPlayer.Character.Head.Position - v.Character.Head.Position).Magnitude / 3) .. " Distance")
						name.Size = UDim2.new(1, 0, 1, 0)
						name.TextYAlignment = "Top"
						name.BackgroundTransparency = 1
						name.TextStrokeTransparency = 0.5
						if v.Team == game.Players.LocalPlayer.Team then
							name.TextColor3 = Color3.new(0, 0, 254)
						else
							name.TextColor3 = Color3.new(255, 0, 0)
						end
					else
						v.Character.Head["NameEsp" .. Number].TextLabel.Text = (v.Data.Level.Value .. " | " .. v.Name .. "\n" .. round((game:GetService("Players").LocalPlayer.Character.Head.Position - v.Character.Head.Position).Magnitude / 3) .. " Distance\nHealth : " .. round(v.Character.Humanoid.Health * 100 / v.Character.Humanoid.MaxHealth) .. "%")
					end
				else
					if v.Character.Head:FindFirstChild("NameEsp" .. Number) then
						v.Character.Head:FindFirstChild("NameEsp" .. Number):Destroy()
					end
				end
			end
		end)
	end
end
function LocationEsp()
	for _, v in next, workspace["_WorldOrigin"].Locations:GetChildren() do
		pcall(function()
			if IslandESP then
				if (v.Name ~= "Sea") then
					if not v:FindFirstChild("NameEsp") then
						local bill = Instance.new("BillboardGui", v)
						bill.Name = "NameEsp"
						bill.ExtentsOffset = Vector3.new(0, 1, 0)
						bill.Size = UDim2.new(1, 200, 1, 30)
						bill.Adornee = v
						bill.AlwaysOnTop = true
						local name = Instance.new("TextLabel", bill)
						name.Font = Enum.Font.Code
						name.FontSize = "Size14"
						name.TextWrapped = true
						name.Size = UDim2.new(1, 0, 1, 0)
						name.TextYAlignment = "Top"
						name.BackgroundTransparency = 1
						name.TextStrokeTransparency = 0.5
						name.TextColor3 = Color3.fromRGB(98, 252, 252)
					else
						v["NameEsp"].TextLabel.Text = (v.Name .. "\n" .. round((game:GetService("Players").LocalPlayer.Character.Head.Position - v.Position).Magnitude / 3) .. " Distance")
					end
				end
			else
				if v:FindFirstChild("NameEsp") then
					v:FindFirstChild("NameEsp"):Destroy()
				end
			end
		end)
	end
end
function DevEsp()
	for i, v in next, workspace:GetChildren() do
		pcall(function()
			if DevilFruitESP then
				if string.find(v.Name, "Fruit") then
					if not v.Handle:FindFirstChild("NameEsp" .. Number) then
						local bill = Instance.new("BillboardGui", v.Handle)
						bill.Name = "NameEsp" .. Number
						bill.ExtentsOffset = Vector3.new(0, 1, 0)
						bill.Size = UDim2.new(1, 200, 1, 30)
						bill.Adornee = v.Handle
						bill.AlwaysOnTop = true
						local name = Instance.new("TextLabel", bill)
						name.Font = Enum.Font.Code
						name.FontSize = "Size14"
						name.TextWrapped = true
						name.Size = UDim2.new(1, 0, 1, 0)
						name.TextYAlignment = "Top"
						name.BackgroundTransparency = 1
						name.TextStrokeTransparency = 0.5
						name.TextColor3 = Color3.fromRGB(255, 255, 255)
						name.Text = (v.Name .. "\n" .. round((game:GetService("Players").LocalPlayer.Character.Head.Position - v.Handle.Position).Magnitude / 3) .. " Distance")
					else
						v.Handle["NameEsp" .. Number].TextLabel.Text = (v.Name .. "\n" .. round((game:GetService("Players").LocalPlayer.Character.Head.Position - v.Handle.Position).Magnitude / 3) .. " Distance")
					end
				end
			else
				if v.Handle:FindFirstChild("NameEsp" .. Number) then
					v.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
				end
			end
		end)
	end
end
function flowerEsp()
	for i, v in pairs(workspace:GetChildren()) do
		pcall(function()
			if v.Name == "Flower2" or v.Name == "Flower1" then
				if FlowerESP then
					if not v:FindFirstChild("NameEsp" .. Number) then
						local bill = Instance.new("BillboardGui", v)
						bill.Name = "NameEsp" .. Number
						bill.ExtentsOffset = Vector3.new(0, 1, 0)
						bill.Size = UDim2.new(1, 200, 1, 30)
						bill.Adornee = v
						bill.AlwaysOnTop = true
						local name = Instance.new("TextLabel", bill)
						name.Font = Enum.Font.Code
						name.FontSize = "Size14"
						name.TextWrapped = true
						name.Size = UDim2.new(1, 0, 1, 0)
						name.TextYAlignment = "Top"
						name.BackgroundTransparency = 1
						name.TextStrokeTransparency = 0.5
						name.TextColor3 = Color3.fromRGB(88, 214, 252)
						if v.Name == "Flower1" then
							name.Text = ("Flower1\n" .. round((game:GetService("Players").LocalPlayer.Character.Head.Position - v.Position).Magnitude / 3) .. " Distance")
							name.TextColor3 = Color3.fromRGB(88, 214, 252)
						end
						if v.Name == "Flower2" then
							name.Text = ("Flower2\n" .. round((game:GetService("Players").LocalPlayer.Character.Head.Position - v.Position).Magnitude / 3) .. " Distance")
							name.TextColor3 = Color3.fromRGB(88, 214, 252)
						end
					else
						v["NameEsp" .. Number].TextLabel.Text = (v.Name .. "\n" .. round((game:GetService("Players").LocalPlayer.Character.Head.Position - v.Position).Magnitude / 3) .. " Distance")
					end
				else
					if v:FindFirstChild("NameEsp" .. Number) then
						v:FindFirstChild("NameEsp" .. Number):Destroy()
					end
				end
			end
		end)
	end
end
function EventIslandEsp()
	for i, v in pairs(workspace._WorldOrigin.Locations:GetChildren()) do
		pcall(function()
			if EspEventIsland then
				if (v.Name == "Mirage Island" or v.Name == "Prehistoric Island" or v.Name == "Kitsune Island") then
					if not v:FindFirstChild("NameEsp") then
						local bill = Instance.new("BillboardGui", v)
						bill.Name = "NameEsp"
						bill.ExtentsOffset = Vector3.new(0, 1, 0)
						bill.Size = UDim2.new(1, 200, 1, 30)
						bill.Adornee = v
						bill.AlwaysOnTop = true
						local name = Instance.new("TextLabel", bill)
						name.Font = "Code"
						name.FontSize = "Size14"
						name.TextWrapped = true
						name.Size = UDim2.new(1, 0, 1, 0)
						name.TextYAlignment = "Top"
						name.BackgroundTransparency = 1
						name.TextStrokeTransparency = 0.5
						name.TextColor3 = Color3.fromRGB(80, 245, 245)
					else
						v.NameEsp.TextLabel.Text = v.Name .. "\n" .. round((game.Players.LocalPlayer.Character.Head.Position - v.Position).Magnitude / 3) .. " Distance"
					end
				end
			elseif v:FindFirstChild("NameEsp") then
				v:FindFirstChild("NameEsp"):Destroy()
			end
		end)
	end
end
function gearEsp()
	for _, v in pairs(workspace.Map.MysticIsland:GetDescendants()) do
		pcall(function()
			if ESPGear then
				if v.Name == "Part" and v.Material == Enum.Material.Neon then
					if not v:FindFirstChild("NameEsp") then
						local bill = Instance.new("BillboardGui", v)
						bill.Name = "NameEsp"
						bill.ExtentsOffset = Vector3.new(0, 1, 0)
						bill.Size = UDim2.new(1, 200, 1, 30)
						bill.Adornee = v
						bill.AlwaysOnTop = true
						local name = Instance.new("TextLabel", bill)
						name.Font = "Code"
						name.FontSize = "Size14"
						name.TextWrapped = true
						name.Size = UDim2.new(1, 0, 1, 0)
						name.TextYAlignment = "Top"
						name.BackgroundTransparency = 1
						name.TextStrokeTransparency = 0.5
						name.TextColor3 = Color3.fromRGB(80, 245, 245)
					else
						v["NameEsp"].TextLabel.Text = ("Gear" .. "\n" .. round((game.Players.LocalPlayer.Character.Head.Position - v.Position).Magnitude / 3) .. " Distance")
					end
				end
			else
				if v:FindFirstChild("NameEsp") then
					v:FindFirstChild("NameEsp"):Destroy()
				end
			end
		end)
	end
end
function AdvanFruitEsp()
	if advanEsp then
		for _, v in pairs(game:GetService("ReplicatedStorage").NPCs:GetChildren()) do
			if v.Name == "Advanced Fruit Dealer" then
				if not workspace:FindFirstChild("Adv") then
					Adv = Instance.new("Part")
					Adv.Name = "Adv"
					Adv.Transparency = 1
					Adv.Size = Vector3.new(1, 1, 1)
					Adv.Anchored = true
					Adv.CanCollide = false
					Adv.Parent = workspace
					Adv.CFrame = v.HumanoidRootPart.CFrame
				elseif workspace:FindFirstChild("Adv") then
					if not Adv:FindFirstChild("NameEsp") then
						local bill = Instance.new("BillboardGui", Adv)
						bill.Name = "NameEsp"
						bill.ExtentsOffset = Vector3.new(0, 1, 0)
						bill.Size = UDim2.new(1, 200, 1, 30)
						bill.Adornee = Adv
						bill.AlwaysOnTop = true
						local name = Instance.new("TextLabel", bill)
						name.Font = "Code"
						name.FontSize = "Size14"
						name.TextWrapped = true
						name.Size = UDim2.new(1, 0, 1, 0)
						name.TextYAlignment = "Top"
						name.BackgroundTransparency = 1
						name.TextStrokeTransparency = 0.5
						name.TextColor3 = Color3.fromRGB(80, 245, 245)
					else
						Adv["NameEsp"].TextLabel.Text = (v.Name .. "\n" .. round((game.Players.LocalPlayer.Character.Head.Position - v.HumanoidRootPart.Position).Magnitude / 3) .. " Distance")
					end
				end
			end
		end
	else
		if workspace:FindFirstChild("Adv") then
			workspace:FindFirstChild("Adv"):Destroy()
		end
	end
end
function HakiClorEsp()
	if ColorEsp then
		for _, v in pairs(game:GetService("ReplicatedStorage").NPCs:GetChildren()) do
			if v.Name == "Barista Cousin" then
				if not workspace:FindFirstChild("Gay") then
					Gay = Instance.new("Part")
					Gay.Name = "Gay"
					Gay.Transparency = 1
					Gay.Size = Vector3.new(1, 1, 1)
					Gay.Anchored = true
					Gay.CanCollide = false
					Gay.Parent = workspace
					Gay.CFrame = v.HumanoidRootPart.CFrame
				elseif workspace:FindFirstChild("Gay") then
					if not Gay:FindFirstChild("NameEsp") then
						local bill = Instance.new("BillboardGui", Gay)
						bill.Name = "NameEsp"
						bill.ExtentsOffset = Vector3.new(0, 1, 0)
						bill.Size = UDim2.new(1, 200, 1, 30)
						bill.Adornee = Gay
						bill.AlwaysOnTop = true
						local name = Instance.new("TextLabel", bill)
						name.Font = "Code"
						name.FontSize = "Size14"
						name.TextWrapped = true
						name.Size = UDim2.new(1, 0, 1, 0)
						name.TextYAlignment = "Top"
						name.BackgroundTransparency = 1
						name.TextStrokeTransparency = 0.5
						name.TextColor3 = Color3.fromRGB(80, 245, 245)
					else
						Gay["NameEsp"].TextLabel.Text = (v.Name .. "\n" .. round((game.Players.LocalPlayer.Character.Head.Position - v.HumanoidRootPart.Position).Magnitude / 3) .. " Distance")
					end
				end
			end
		end
	else
		if workspace:FindFirstChild("Gay") then
			workspace:FindFirstChild("Gay"):Destroy()
		end
	end
end
function LegenSword()
	if LegenS then
		for _, v in pairs(game:GetService("ReplicatedStorage").NPCs:GetChildren()) do
			if v.Name == "Legendary Sword Dealer " then
				if not workspace:FindFirstChild("Lgd") then
					Lgd = Instance.new("Part")
					Lgd.Name = "Lgd"
					Lgd.Transparency = 1
					Lgd.Size = Vector3.new(1, 1, 1)
					Lgd.Anchored = true
					Lgd.CanCollide = false
					Lgd.Parent = workspace
					Lgd.CFrame = v.HumanoidRootPart.CFrame
				elseif workspace:FindFirstChild("Lgd") then
					if not Lgd:FindFirstChild("NameEsp") then
						local bill = Instance.new("BillboardGui", Lgd)
						bill.Name = "NameEsp"
						bill.ExtentsOffset = Vector3.new(0, 1, 0)
						bill.Size = UDim2.new(1, 200, 1, 30)
						bill.Adornee = Lgd
						bill.AlwaysOnTop = true
						local name = Instance.new("TextLabel", bill)
						name.Font = "Code"
						name.FontSize = "Size14"
						name.TextWrapped = true
						name.Size = UDim2.new(1, 0, 1, 0)
						name.TextYAlignment = "Top"
						name.BackgroundTransparency = 1
						name.TextStrokeTransparency = 0.5
						name.TextColor3 = Color3.fromRGB(80, 245, 245)
					else
						Lgd["NameEsp"].TextLabel.Text = (v.Name .. "\n" .. round((game.Players.LocalPlayer.Character.Head.Position - v.HumanoidRootPart.Position).Magnitude / 3) .. " Distance")
					end
				end
			end
		end
	else
		if workspace:FindFirstChild("Lgd") then
			workspace:FindFirstChild("Lgd"):Destroy()
		end
	end
end
function ChestEsp()
	if ChestESP then
		local CollectionService = game:GetService("CollectionService")
		local Players = game:GetService("Players")
		local Player = Players.LocalPlayer
		local Character = Player.Character or Player.CharacterAdded:Wait()
		local playerPos = Character:GetPivot().Position
		local Chests = CollectionService:GetTagged("_ChestTagged")
		for _, Chest in ipairs(Chests) do
			local DARKLUA_CONTINUE_507 = false
			repeat
				if not SelectIsland or Chest:IsDescendantOf(SelectIsland) then
					if not Chest:GetAttribute("IsDisabled") then
						local chestPos
						local success, result = pcall(function()
							return Chest:GetPivot().Position
						end)
						if success then
							chestPos = result
						elseif Chest:IsA("BasePart") then
							chestPos = Chest.Position
						else
							DARKLUA_CONTINUE_507 = true
							break
						end
						local distanceMagnitude = (chestPos - playerPos).Magnitude
						local sanitizedFullName = Chest:GetFullName():gsub("[^%w_]", "_")
						local existingEsp = Chest:FindFirstChild("ChestEspAttachment")
						if not existingEsp then
							local attachment = Instance.new("Attachment")
							attachment.Name = "ChestEspAttachment"
							attachment.Parent = Chest
							attachment.Position = Vector3.new(0, 3, 0)
							local nameEsp = Instance.new("BillboardGui")
							nameEsp.Name = "NameEsp"
							nameEsp.Size = UDim2.new(0, 200, 0, 30)
							nameEsp.Adornee = attachment
							nameEsp.ExtentsOffset = Vector3.new(0, 1, 0)
							nameEsp.AlwaysOnTop = true
							nameEsp.Parent = attachment
							local nameLabel = Instance.new("TextLabel")
							nameLabel.Font = Enum.Font.Code
							nameLabel.TextSize = 14
							nameLabel.TextWrapped = true
							nameLabel.Size = UDim2.new(1, 0, 1, 0)
							nameLabel.TextYAlignment = Enum.TextYAlignment.Top
							nameLabel.BackgroundTransparency = 1
							nameLabel.TextStrokeTransparency = 0.5
							nameLabel.TextColor3 = Color3.fromRGB(80, 245, 245)
							nameLabel.Parent = nameEsp
						end
						local nameEsp = existingEsp and existingEsp:FindFirstChild("NameEsp")
						if nameEsp then
							local displayDistance = math.floor(distanceMagnitude / 3)
							local chestName = Chest.Name:gsub("Label", "")
							nameEsp.TextLabel.Text = string.format("[%s] %d Distance", chestName, displayDistance)
						end
						if _G_AutoFarmChest and distanceMagnitude <= 20 then
							if existingEsp then
								existingEsp:Destroy()
							end
						end
					end
				end
				DARKLUA_CONTINUE_507 = true
			until true
			if not DARKLUA_CONTINUE_507 then
				break
			end
		end
	else
		for _, Chest in ipairs(game:GetService("CollectionService"):GetTagged("_ChestTagged")) do
			local espAttachment = Chest:FindFirstChild("ChestEspAttachment")
			if espAttachment then
				espAttachment:Destroy()
			end
		end
	end
end
function berriesEsp()
	if BerryEsp then
		local CollectionService = game:GetService("CollectionService")
		local Players = game:GetService("Players")
		local Player = Players.LocalPlayer
		local BerryBushes = CollectionService:GetTagged("BerryBush")
		for _, Bush in ipairs(BerryBushes) do
			local bushPosition = Bush.Parent:GetPivot().Position
			for _, BerryName in pairs(Bush:GetAttributes()) do
				if BerryName and (not BerryArray or table.find(BerryArray, BerryName)) then
					local espPartName = "BerryEspPart_" .. BerryName .. "_" .. tostring(bushPosition)
					local existingEsp = workspace:FindFirstChild(espPartName)
					if not existingEsp then
						existingEsp = Instance.new("Part")
						existingEsp.Name = espPartName
						existingEsp.Transparency = 1
						existingEsp.Size = Vector3.new(1, 1, 1)
						existingEsp.Anchored = true
						existingEsp.CanCollide = false
						existingEsp.Parent = workspace
						existingEsp.CFrame = CFrame.new(bushPosition)
					end
					if not existingEsp:FindFirstChild("NameEsp") then
						local nameEsp = Instance.new("BillboardGui", existingEsp)
						nameEsp.Name = "NameEsp"
						nameEsp.ExtentsOffset = Vector3.new(0, 1, 0)
						nameEsp.Size = UDim2.new(0, 200, 0, 30)
						nameEsp.Adornee = existingEsp
						nameEsp.AlwaysOnTop = true
						local nameLabel = Instance.new("TextLabel", nameEsp)
						nameLabel.Font = Enum.Font.Code
						nameLabel.TextSize = 14
						nameLabel.TextWrapped = true
						nameLabel.Size = UDim2.new(1, 0, 1, 0)
						nameLabel.TextYAlignment = Enum.TextYAlignment.Top
						nameLabel.BackgroundTransparency = 1
						nameLabel.TextStrokeTransparency = 0.5
						nameLabel.TextColor3 = Color3.fromRGB(80, 245, 245)
						nameLabel.Parent = nameEsp
					end
					local nameEsp = existingEsp:FindFirstChild("NameEsp")
					local distance = (Player.Character.Head.Position - bushPosition).Magnitude / 3
					nameEsp.TextLabel.Text = (BerryName .. "\n" .. math.round(distance) .. " Distance")
					if _G.Berry and math.round(distance) <= 20 then
						existingEsp:Destroy()
					end
				end
			end
		end
	else
		for _, v in ipairs(workspace:GetChildren()) do
			if v:IsA("Part") and v.Name:match("BerryEspPart_.*") then
				v:Destroy()
			end
		end
	end
end
Toggle = Tabs.Visual:AddToggle("Toggle", {
	Title = "Esp Berry",
	Default = false
})
Toggle:OnChanged(function(Value)
	BerryEsp = Value
	while BerryEsp do
		wait()
		berriesEsp()
	end
end)
Toggle = Tabs.Visual:AddToggle("Toggle", {
	Title = "Esp Player",
	Default = false
})
Toggle:OnChanged(function(Value)
	PlayerEsp = Value
	while PlayerEsp do
		wait()
		EspPly()
	end
end)
Toggle = Tabs.Visual:AddToggle("Toggle", {
	Title = "Esp Chest",
	Default = false
})
Toggle:OnChanged(function(Value)
	ChestESP = Value
	while ChestESP do
		wait()
		ChestEsp()
	end
end)
Toggle = Tabs.Visual:AddToggle("Toggle", {
	Title = "Esp Devid Fruit",
	Default = false
})
Toggle:OnChanged(function(Value)
	DevilFruitESP = Value
	while DevilFruitESP do
		wait()
		DevEsp()
	end
end)
Toggle = Tabs.Visual:AddToggle("Toggle", {
	Title = "Esp Island",
	Default = false
})
Toggle:OnChanged(function(Value)
	IslandESP = Value
	while IslandESP do
		wait()
		LocationEsp()
	end
end)
if World2 then
	Toggle = Tabs.Visual:AddToggle("Toggle", {
		Title = "Esp Flower",
		Default = false
	})
	Toggle:OnChanged(function(Value)
		FlowerESP = Value
		while FlowerESP do
			wait()
			flowerEsp()
		end
	end)
	Toggle = Tabs.Visual:AddToggle("Toggle", {
		Title = "Esp Legendary Sword",
		Default = false
	})
	Toggle:OnChanged(function(Value)
		LegenS = Value
		while LegenS do
			wait()
			LegenSword()
		end
	end)
end
if World2 or World3 then
	Toggle = Tabs.Visual:AddToggle("Toggle", {
		Title = "Esp Haki Colour Dealer",
		Default = false
	})
	Toggle:OnChanged(function(Value)
		ColorEsp = Value
		while ColorEsp do
			wait()
			HakiClorEsp()
		end
	end)
end
if World3 then
	Toggle = Tabs.Visual:AddToggle("Toggle", {
		Title = "Esp Gears",
		Default = false
	})
	Toggle:OnChanged(function(Value)
		ESPGear = Value
		while ESPGear do
			wait()
			gearEsp()
		end
	end)
	Toggle = Tabs.Visual:AddToggle("Toggle", {
		Title = "Esp Event Island",
		Default = false
	})
	Toggle:OnChanged(function(Value)
		EspEventIsland = Value
		while EspEventIsland do
			wait()
			EventIslandEsp()
		end
	end)
	Toggle = Tabs.Visual:AddToggle("Toggle", {
		Title = "Esp Advanced Fruit Dealer",
		Default = false
	})
	Toggle:OnChanged(function(Value)
		advanEsp = Value
		while advanEsp do
			wait()
			AdvanFruitEsp()
		end
	end)
end
Tabs.Teleport:AddSection("World")
Tabs.Teleport:AddButton({
	Title = "Teleport First Sea",
	Callback = function()
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelMain")
	end
})
Tabs.Teleport:AddButton({
	Title = "Teleport Second Sea",
	Callback = function()
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa")
	end
})
Tabs.Teleport:AddButton({
	Title = "Teleport Third Sea",
	Callback = function()
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelZou")
	end
})
Tabs.Teleport:AddSection("Island")
if World1 then
	IslandList = {
		"WindMill",
		"Marine",
		"Middle Town",
		"Jungle",
		"Pirate Village",
		"Desert",
		"Snow Island",
		"MarineFord",
		"Colosseum",
		"Sky Island 1",
		"Sky Island 2",
		"Sky Island 3",
		"Prison",
		"Magma Village",
		"Under Water Island",
		"Fountain City",
		"Shank Room",
		"Mob Island"
	}
elseif World2 then
	IslandList = {
		"The Cafe",
		"Frist Spot",
		"Dark Area",
		"Flamingo Mansion",
		"Flamingo Room",
		"Green Zone",
		"Factory",
		"Colossuim",
		"Zombie Island",
		"Two Snow Mountain",
		"Punk Hazard",
		"Cursed Ship",
		"Ice Castle",
		"Forgotten Island",
		"Ussop Island",
		"Mini Sky Island"
	}
elseif World3 then
	IslandList = {
		"Mansion",
		"Port Town",
		"Great Tree",
		"Castle On The Sea",
		"MiniSky",
		"Hydra Island",
		"Floating Turtle",
		"Haunted Castle",
		"Ice Cream Island",
		"Peanut Island",
		"Cake Island",
		"Cocoa Island",
		"Candy Island",
		"Tiki Outpost",
		"Submerged Island"
	}
end
Dropdown = Tabs.Teleport:AddDropdown("Dropdown", {
	Title = "Select Island",
	Values = IslandList,
	Multi = false,
	Default = 1
})
Dropdown:OnChanged(function(Value)
	_G.SelectIsland = Value
end)
ToggleTP = Tabs.Teleport:AddToggle("Toggle", {
	Title = "Auto Teleport To Island",
	Default = false
})
ToggleTP:OnChanged(function(Value)
	_G.Teleport = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		if _G.Teleport then
			pcall(function()
				if _G.SelectIsland == "WindMill" then
					Tween(CFrame.new(979.79895019531, 16.516613006592, 1429.0466308594))
				elseif _G.SelectIsland == "Marine" then
					Tween(CFrame.new(-2566.4296875, 6.8556680679321, 2045.2561035156))
				elseif _G.SelectIsland == "Middle Town" then
					Tween(CFrame.new(-690.33081054688, 15.09425163269, 1582.2380371094))
				elseif _G.SelectIsland == "Jungle" then
					Tween(CFrame.new(-1612.7957763672, 36.852081298828, 149.12843322754))
				elseif _G.SelectIsland == "Pirate Village" then
					Tween(CFrame.new(-1181.3093261719, 4.7514905929565, 3803.5456542969))
				elseif _G.SelectIsland == "Desert" then
					Tween(CFrame.new(944.15789794922, 20.919729232788, 4373.3002929688))
				elseif _G.SelectIsland == "Snow Island" then
					Tween(CFrame.new(1347.8067626953, 104.66806030273, -1319.7370605469))
				elseif _G.SelectIsland == "MarineFord" then
					Tween(CFrame.new(-4914.8212890625, 50.963626861572, 4281.0278320313))
				elseif _G.SelectIsland == "Colosseum" then
					Tween(CFrame.new(-1427.6203613281, 7.2881078720093, -2792.7722167969))
				elseif _G.SelectIsland == "Sky Island 1" then
					Tween(CFrame.new(-4869.1025390625, 733.46051025391, -2667.0180664063))
				elseif _G.SelectIsland == "Sky Island 2" then
					Tween(CFrame.new(-4607.82275, 872.54248, -1667.55688))
				elseif _G.SelectIsland == "Sky Island 3" then
					Tween(CFrame.new(-7894.6176757813, 5547.1416015625, -380.29119873047))
				elseif _G.SelectIsland == "Prison" then
					Tween(CFrame.new(4875.330078125, 5.6519818305969, 734.85021972656))
				elseif _G.SelectIsland == "Magma Village" then
					Tween(CFrame.new(-5247.7163085938, 12.883934020996, 8504.96875))
				elseif _G.SelectIsland == "Under Water Island" then
					Tween(CFrame.new(61163.8515625, 11.6796875, 1819.7841796875))
				elseif _G.SelectIsland == "Fountain City" then
					Tween(CFrame.new(5127.1284179688, 59.501365661621, 4105.4458007813))
				elseif _G.SelectIsland == "Shank Room" then
					Tween(CFrame.new(-1442.16553, 29.8788261, -28.3547478))
				elseif _G.SelectIsland == "Mob Island" then
					Tween(CFrame.new(-2850.20068, 7.39224768, 5354.99268))
				elseif _G.SelectIsland == "The Cafe" then
					Tween(CFrame.new(-380.47927856445, 77.220390319824, 255.82550048828))
				elseif _G.SelectIsland == "Frist Spot" then
					Tween(CFrame.new(-11.311455726624, 29.276733398438, 2771.5224609375))
				elseif _G.SelectIsland == "Dark Area" then
					Tween(CFrame.new(3780.0302734375, 22.652164459229, -3498.5859375))
				elseif _G.SelectIsland == "Flamingo Mansion" then
					Tween(CFrame.new(-483.73370361328, 332.0383605957, 595.32708740234))
				elseif _G.SelectIsland == "Flamingo Room" then
					Tween(CFrame.new(2284.4140625, 15.152037620544, 875.72534179688))
				elseif _G.SelectIsland == "Green Zone" then
					Tween(CFrame.new(-2448.5300292969, 73.016105651855, -3210.6306152344))
				elseif _G.SelectIsland == "Factory" then
					Tween(CFrame.new(424.12698364258, 211.16171264648, -427.54049682617))
				elseif _G.SelectIsland == "Colossuim" then
					Tween(CFrame.new(-1503.6224365234, 219.7956237793, 1369.3101806641))
				elseif _G.SelectIsland == "Zombie Island" then
					Tween(CFrame.new(-5622.033203125, 492.19604492188, -781.78552246094))
				elseif _G.SelectIsland == "Two Snow Mountain" then
					Tween(CFrame.new(753.14288330078, 408.23559570313, -5274.6147460938))
				elseif _G.SelectIsland == "Punk Hazard" then
					Tween(CFrame.new(-6127.654296875, 15.951762199402, -5040.2861328125))
				elseif _G.SelectIsland == "Cursed Ship" then
					Tween(CFrame.new(923.40197753906, 125.05712890625, 32885.875))
				elseif _G.SelectIsland == "Ice Castle" then
					Tween(CFrame.new(6148.4116210938, 294.38687133789, -6741.1166992188))
				elseif _G.SelectIsland == "Forgotten Island" then
					Tween(CFrame.new(-3032.7641601563, 317.89672851563, -10075.373046875))
				elseif _G.SelectIsland == "Ussop Island" then
					Tween(CFrame.new(4816.8618164063, 8.4599885940552, 2863.8195800781))
				elseif _G.SelectIsland == "Mini Sky Island" then
					Tween(CFrame.new(-288.74060058594, 49326.31640625, -35248.59375))
				elseif _G.SelectIsland == "Great Tree" then
					Tween(CFrame.new(2681.2736816406, 1682.8092041016, -7190.9853515625))
				elseif _G.SelectIsland == "Castle On The Sea" then
					Tween(CFrame.new(-5074.45556640625, 314.5155334472656, -2991.054443359375))
				elseif _G.SelectIsland == "MiniSky" then
					Tween(CFrame.new(-260.65557861328, 49325.8046875, -35253.5703125))
				elseif _G.SelectIsland == "Port Town" then
					Tween(CFrame.new(-95, 11, 5455))
				elseif _G.SelectIsland == "Hydra Island" then
					Tween(CFrame.new(5433, 1062, 290))
				elseif _G.SelectIsland == "Floating Turtle" then
					Tween(CFrame.new(-13274.528320313, 531.82073974609, -7579.22265625))
				elseif _G.SelectIsland == "Mansion" then
					Tween(CFrame.new(-12551, 337, -7476))
				elseif _G.SelectIsland == "Haunted Castle" then
					Tween(CFrame.new(-9516, 142, 5537))
				elseif _G.SelectIsland == "Ice Cream Island" then
					Tween(CFrame.new(-874, 66, -10915))
				elseif _G.SelectIsland == "Peanut Island" then
					Tween(CFrame.new(-2062.7475585938, 50.473892211914, -10232.568359375))
				elseif _G.SelectIsland == "Cake Island" then
					Tween(CFrame.new(-1884.7747802734375, 19.327526092529297, -11666.8974609375))
				elseif _G.SelectIsland == "Cocoa Island" then
					Tween(CFrame.new(87.94276428222656, 73.55451202392578, -12319.46484375))
				elseif _G.SelectIsland == "Candy Island" then
					Tween(CFrame.new(-1014.4241943359375, 149.11068725585938, -14555.962890625))
				elseif _G.SelectIsland == "Tiki Outpost" then
					Tween(CFrame.new(-16101.1885, 12.8422165, 380.942291))
				elseif _G.SelectIsland == "Submerged Island" then
					Tween(CFrame.new(-16269.7041, 25.2288494, 1373.65955))
					wait(2)
					game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RF/SubmarineWorkerSpeak"):InvokeServer("TravelToSubmergedIsland")
				end
			end)
		end
	end
end)
Tabs.Teleport:AddSection("Portal")
PortalList = {}
if World1 then
	PortalList = {
		"Sky",
		"UnderWater"
	}
elseif World2 then
	PortalList = {
		"SwanRoom",
		"Cursed Ship"
	}
elseif World3 then
	PortalList = {
		"Castle On The Sea",
		"Mansion Cafe",
		"Hydra Teleport",
		"Canvendish Room",
		"Temple of Time"
	}
end
Dropdown = Tabs.Teleport:AddDropdown("Dropdown", {
	Title = "Select Portal",
	Values = PortalList,
	Multi = false,
	Default = 1
})
Dropdown:OnChanged(function(Value)
	_G.SelectPortal = Value
end)
Tabs.Teleport:AddButton({
	Title = "Request Entrance",
	Callback = function()
		if _G.SelectPortal == "Sky" then
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-7894, 5547, -380))
		elseif _G.SelectPortal == "UnderWater" then
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(61163, 11, 1819))
		elseif _G.SelectPortal == "SwanRoom" then
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(2285, 15, 905))
		elseif _G.SelectPortal == "Cursed Ship" then
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923, 126, 32852))
		elseif _G.SelectPortal == "Castle On The Sea" then
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-5097.93164, 316.447021, -3142.66602, -0.405007899, -4.31682743e-08, 0.914313197, -1.90943332e-08, 1, 3.8755779e-08, -0.914313197, -1.76180437e-09, -0.405007899))
		elseif _G.SelectPortal == "Mansion Cafe" then
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-12471.169921875, 374.94024658203, -7551.677734375))
		elseif _G.SelectPortal == "Hydra Teleport" then
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(5643.45263671875, 1013.0858154296875, -340.51025390625))
		elseif _G.SelectPortal == "Canvendish Room" then
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(5314.54638671875, 22.562219619750977, -127.06755065917969))
		elseif _G.SelectPortal == "Temple of Time" then
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(28310.0234, 14895.1123, 109.456741, -0.469690144, -2.85620132e-08, -0.882831335, -3.23509219e-08, 1, -1.51411736e-08, 0.882831335, 2.14487486e-08, -0.469690144))
		end
	end
})
Tabs.Shop:AddButton({
	Title = "Buy Buso",
	Callback = function()
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki", "Buso")
	end
})
Tabs.Shop:AddButton({
	Title = "Buy Geppo",
	Callback = function()
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki", "Geppo")
	end
})
Tabs.Shop:AddButton({
	Title = "Buy Soru",
	Callback = function()
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki", "Soru")
	end
})
Tabs.Shop:AddButton({
	Title = "Buy Ken Talk",
	Callback = function()
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("KenTalk", "Buy")
	end
})
Tabs.Shop:AddButton({
	Title = "Buy Haki Color",
	Callback = function()
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ColorsDealer", "2")
	end
})
Tabs.Shop:AddSection("Fighting Style")
Tabs.Shop:AddButton({
	Title = "Buy Black Leg",
	Callback = function()
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBlackLeg")
	end
})
Tabs.Shop:AddButton({
	Title = "Buy Electro",
	Callback = function()
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectro")
	end
})
Tabs.Shop:AddButton({
	Title = "Buy Fishman Karate",
	Callback = function()
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyFishmanKarate")
	end
})
Tabs.Shop:AddButton({
	Title = "Buy Dragon Claw",
	Callback = function()
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "DragonClaw", "2")
	end
})
Tabs.Shop:AddButton({
	Title = "Buy Superhuman",
	Callback = function()
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySuperhuman")
	end
})
Tabs.Shop:AddButton({
	Title = "Buy Death Step",
	Callback = function()
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDeathStep")
	end
})
Tabs.Shop:AddButton({
	Title = "Buy Sharkman Karate",
	Callback = function()
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkmanKarate")
	end
})
Tabs.Shop:AddButton({
	Title = "Buy Electric Claw",
	Callback = function()
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectricClaw")
	end
})
Tabs.Shop:AddButton({
	Title = "Buy Dragon Talon",
	Callback = function()
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDragonTalon")
	end
})
Tabs.Shop:AddButton({
	Title = "Buy Godhuman",
	Callback = function()
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyGodhuman")
	end
})
Tabs.Shop:AddButton({
	Title = "Buy Sanguine Art",
	Callback = function()
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySanguineArt")
	end
})
Tabs.Shop:AddSection("Accessory")
Tabs.Shop:AddButton({
	Title = "Buy Tomoe Ring",
	Callback = function()
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Tomoe Ring")
	end
})
Tabs.Shop:AddButton({
	Title = "Buy Black Cape",
	Callback = function()
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Black Cape")
	end
})
Tabs.Shop:AddButton({
	Title = "Buy Swordsman Hat",
	Callback = function()
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Swordsman Hat")
	end
})
Tabs.Shop:AddButton({
	Title = "Buy Bizarre Rifle",
	Callback = function()
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Ectoplasm", "Buy", 1)
	end
})
Tabs.Shop:AddButton({
	Title = "Buy Ghoul Mask",
	Callback = function()
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Ectoplasm", "Buy", 2)
	end
})
Tabs.Shop:AddSection("Accessory Sea Event")
Tabs.Shop:AddButton({
	Title = "Craft Dragon Heart",
	Callback = function()
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CraftItem", "Craft", "Dragonheart")
	end
})
Tabs.Shop:AddButton({
	Title = "Craft Dragon Storm",
	Callback = function()
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CraftItem", "Craft", "Dragonstorm")
	end
})
Tabs.Shop:AddButton({
	Title = "Craft Dino Hood",
	Callback = function()
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CraftItem", "Craft", "DinoHood")
	end
})
Tabs.Shop:AddButton({
	Title = "Craft Shark Tooth",
	Callback = function()
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CraftItem", "Craft", "SharkTooth")
	end
})
Tabs.Shop:AddButton({
	Title = "Craft Terror Jaw",
	Callback = function()
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CraftItem", "Craft", "TerrorJaw")
	end
})
Tabs.Shop:AddButton({
	Title = "Craft Shark Anchor",
	Callback = function()
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CraftItem", "Craft", "SharkAnchor")
	end
})
Tabs.Shop:AddButton({
	Title = "Craft Leviathan Crown",
	Callback = function()
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CraftItem", "Craft", "LeviathanCrown")
	end
})
Tabs.Shop:AddButton({
	Title = "Craft Leviathan Shield",
	Callback = function()
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CraftItem", "Craft", "LeviathanShield")
	end
})
Tabs.Shop:AddButton({
	Title = "Craft Leviathan Boat",
	Callback = function()
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CraftItem", "Craft", "LeviathanBoat")
	end
})
Tabs.Shop:AddButton({
	Title = "Craft Legendary Scroll",
	Callback = function()
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CraftItem", "Craft", "LegendaryScroll")
	end
})
Tabs.Shop:AddButton({
	Title = "Craft Mythical Scroll",
	Callback = function()
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CraftItem", "Craft", "MythicalScroll")
	end
})
Tabs.Shop:AddSection("Weapon")
Tabs.Shop:AddButton({
	Title = "Buy Cutlass",
	Callback = function()
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Cutlass")
	end
})
Tabs.Shop:AddButton({
	Title = "Buy Katana",
	Callback = function()
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Katana")
	end
})
Tabs.Shop:AddButton({
	Title = "Buy Iron Mace",
	Callback = function()
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Iron Mace")
	end
})
Tabs.Shop:AddButton({
	Title = "Buy Duel Katana",
	Callback = function()
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Duel Katana")
	end
})
Tabs.Shop:AddButton({
	Title = "Buy Triple Katana",
	Callback = function()
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Triple Katana")
	end
})
Tabs.Shop:AddButton({
	Title = "Buy Pipe",
	Callback = function()
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Pipe")
	end
})
Tabs.Shop:AddButton({
	Title = "Buy Dual-Headed Blade",
	Callback = function()
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Dual-Headed Blade")
	end
})
Tabs.Shop:AddButton({
	Title = "Buy Bisento",
	Callback = function()
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Bisento")
	end
})
Tabs.Shop:AddButton({
	Title = "Buy Soul Cane",
	Callback = function()
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Soul Cane")
	end
})
Tabs.Shop:AddButton({
	Title = "Buy Slingshot",
	Callback = function()
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Slingshot")
	end
})
Tabs.Shop:AddButton({
	Title = "Buy Musket",
	Callback = function()
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Musket")
	end
})
Tabs.Shop:AddButton({
	Title = "Buy Dual Flintlock",
	Callback = function()
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Dual Flintlock")
	end
})
Tabs.Shop:AddButton({
	Title = "Buy Flintlock",
	Callback = function()
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Flintlock")
	end
})
Tabs.Shop:AddButton({
	Title = "Buy Refined Flintlock",
	Callback = function()
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Refined Flintlock")
	end
})
Tabs.Shop:AddButton({
	Title = "Buy Cannon",
	Callback = function()
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Cannon")
	end
})
Tabs.Shop:AddButton({
	Title = "Buy Kabucha",
	Callback = function()
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "Slingshot", "2")
	end
})
Tabs.Shop:AddSection("Fragment")
Tabs.Shop:AddButton({
	Title = "Buy Refund Stats",
	Callback = function()
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "Refund", "2")
	end
})
Tabs.Shop:AddButton({
	Title = "Buy Reroll Race",
	Callback = function()
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "Reroll", "2")
	end
})
Tabs.Shop:AddButton({
	Title = "Buy Ghoul Race",
	Callback = function()
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Ectoplasm", " Change", 4)
	end
})
Tabs.Shop:AddButton({
	Title = "Buy Cyborg Race",
	Callback = function()
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CyborgTrainer", " Buy")
	end
})
Tabs.Fruit:AddSection("Fruit")
fruitsOnSale = {}
function addCommas(number)
	local formatted = tostring(number)
	while true do
		formatted, k = formatted:gsub("^(-?%d+)(%d%d%d)", "%1,%2")
		if k == 0 then
			break
		end
	end
	return formatted
end
for _, fruitData in pairs(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GetFruits", true)) do
	if fruitData["OnSale"] then
		local priceWithCommas = addCommas(fruitData["Price"])
		local fruitInfo = fruitData["Name"]
		table.insert(fruitsOnSale, fruitInfo)
	end
end
Nms = {}
for _, fruitData in pairs(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GetFruits", false)) do
	if fruitData["OnSale"] then
		local price = addCommas(fruitData["Price"])
		local NormalInFO = fruitData["Name"]
		table.insert(Nms, NormalInFO)
	end
end
Dropdown = Tabs.Fruit:AddDropdown("Dropdown", {
	Title = "Select Fruit",
	Values = Nms,
	Multi = false,
	Default = 1
})
Dropdown:OnChanged(function(Value)
	_G.SelectFruit = Value
end)
Tabs.Fruit:AddButton({
	Title = "Buy Normal Stock",
	Callback = function()
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("PurchaseRawFruit", _G.SelectFruit)
	end
})
Dropdown = Tabs.Fruit:AddDropdown("Dropdown", {
	Title = "Select Fruit",
	Values = fruitsOnSale,
	Multi = false,
	Default = 1
})
Dropdown:OnChanged(function(Value)
	SelectF_Adv = Value
end)
Nms = {}
for _, fruitData in pairs(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GetFruits", false)) do
	if fruitData["OnSale"] then
		local price = addCommas(fruitData["Price"])
		local NormalInFO = fruitData["Name"]
		table.insert(Nms, NormalInFO)
	end
end
Tabs.Fruit:AddButton({
	Title = "Buy Mirage Stock",
	Callback = function()
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("PurchaseRawFruit", SelectF_Adv)
	end
})
Toggle = Tabs.Fruit:AddToggle("Toggle", {
	Title = "Auto Random Fruit",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.RandomFruit = Value
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.RandomFruit then
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Cousin", "Buy")
			end
		end)
	end
end)
Toggle = Tabs.Fruit:AddToggle("Toggle", {
	Title = "Auto Drop Fruit",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.DropFruit = Value
end)
spawn(function()
	while task.wait() do
		if _G.DropFruit then
			pcall(function()
				DropFruits()
			end)
		end
	end
end)
Toggle = Tabs.Fruit:AddToggle("Toggle", {
	Title = "Auto Store Fruit",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.StoreF = Value
end)
spawn(function()
	while task.wait() do
		if _G.StoreF then
			pcall(function()
				UpdStFruit()
			end)
		end
	end
end)
Toggle = Tabs.Fruit:AddToggle("Toggle", {
	Title = "Auto Teleport To Fruit",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.TPFruit = Value
	StopTween(Value)
end)
spawn(function()
	while task.wait() do
		if _G.TPFruit then
			pcall(function()
				for _, x1 in pairs(workspace:GetChildren()) do
					if string.find(x1.Name, "Fruit") then
						Tween(x1.Handle.CFrame)
					end
				end
			end)
		end
	end
end)
Tabs.Misc:AddSection("Server")
Tabs.Misc:AddButton({
	Title = "Rejoin Server",
	Callback = function()
		game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
	end
})
Tabs.Misc:AddButton({
	Title = "Hop Server",
	Callback = function()
		Hop()
	end
})
Tabs.Misc:AddButton({
	Title = "Hop Server Low Player",
	Callback = function()
		local Http = game:GetService("HttpService")
		local TPS = game:GetService("TeleportService")
		local Api = "https://games.roblox.com/v1/games/"
		local _place = game.PlaceId
		local _servers = Api .. _place .. "/servers/Public?sortOrder = Asc&limit = 100"
		function ListServers(cursor)
			local Raw = game:HttpGet(_servers .. ((cursor and "&cursor = " .. cursor) or ""))
			return Http:JSONDecode(Raw)
		end
		local Server, Next
		repeat
			local Servers = ListServers(Next)
			Server = Servers.data[1]
			Next = Servers.nextPageCursor
		until Server
		TPS:TeleportToPlaceInstance(_place, Server.id, game.Players.LocalPlayer)
	end
})
Tabs.Misc:AddButton({
	Title = "Hop Server Low Ping",
	Callback = function()
		local HTTPService = game:GetService("HttpService")
		local TeleportService = game:GetService("TeleportService")
		local StatsService = game:GetService("Stats")
		function fetchServersData(placeId, limit)
			local url = string.format("https://games.roblox.com/v1/games/%d/servers/Public?limit = %d", placeId, limit)
			local success, response = pcall(function()
				return HTTPService:JSONDecode(game:HttpGet(url))
			end)
			if success and response and response.data then
				return response.data
			end
			return nil
		end
		local placeId = game.PlaceId
		local serverLimit = 100
		local servers = fetchServersData(placeId, serverLimit)
		if not servers then
			return
		end
		local lowestPingServer = servers[1]
		for _, server in pairs(servers) do
			if server["ping"] < lowestPingServer["ping"] and server.maxPlayers > server.playing then
				lowestPingServer = server
			end
		end
		local commonLoadTime = 0.5
		task.wait(commonLoadTime)
		local pingThreshold = 100
		local serverStats = StatsService.Network.ServerStatsItem
		local dataPing = serverStats["Data Ping"]:GetValueString()
		local pingValue = tonumber(dataPing:match("(%d+)"))
		if pingValue >= pingThreshold then
			game:GetService("TeleportService"):TeleportToPlaceInstance(placeId, lowestPingServer.id)
		end
	end
})
Input = Tabs.Misc:AddInput("Input", {
	Title = "Job ID",
	Default = "",
	Placeholder = "",
	Numeric = false,
	Finished = false,
	Callback = function(Value)
		_G.JobId = Value
	end
})
spawn(function()
	while task.wait() do
		if _G.JobId then
			pcall(function()
				local Connection
				Connection = game.Players.LocalPlayer.OnTeleport:Connect(function(br)
					if br == Enum.TeleportState.Failed then
						Connection:Disconnect()
						if workspace:FindFirstChild("Message") then
							workspace.Message:Destroy()
						end
					end
				end)
			end)
		end
	end
end)
Tabs.Misc:AddButton({
	Title = "Join",
	Callback = function()
		game:GetService("ReplicatedStorage")["__ServerBrowser"]:InvokeServer("teleport", _G.JobId)
	end
})
Tabs.Misc:AddButton({
	Title = "Copy Job ID",
	Callback = function()
		setclipboard(tostring(game.JobId))
	end
})
Tabs.Misc:AddSection("Misc")
Tabs.Misc:AddButton({
	Title = "Open Awakening Expert",
	Callback = function()
		game.Players.LocalPlayer.PlayerGui.Main.AwakeningToggler.Visible = true
	end
})
Tabs.Misc:AddButton({
	Title = "Open Title Selection",
	Callback = function()
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("getTitles", true)
		game.Players.LocalPlayer.PlayerGui.Main.Titles.Visible = true
	end
})
Toggle = Tabs.Misc:AddToggle("Toggle", {
	Title = "Hide Chat",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.Rechat = Value
	if _G.Rechat then
		local StarterGui = game:GetService("StarterGui")
		StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)
	elseif not _G.chat then
		local StarterGui = game:GetService("StarterGui")
		StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true)
	end
end)
Toggle = Tabs.Misc:AddToggle("Toggle", {
	Title = "Hide Leaderboard",
	Default = false
})
Toggle:OnChanged(function(Value)
	ReLeader = Value
	if ReLeader then
		local StarterGui = game:GetService("StarterGui")
		StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)
	elseif not ReLeader then
		local StarterGui = game:GetService("StarterGui")
		StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, true)
	end
end)
Tabs.Misc:AddButton({
	Title = "Pirate Team",
	Callback = function()
		Pirates()
	end
})
Tabs.Misc:AddButton({
	Title = "Marine Team",
	Callback = function()
		Marines()
	end
})
Toggle = Tabs.Misc:AddToggle("Toggle", {
	Title = "Auto Unlock All Portal",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.SelectPortalUnLock = Value
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.SelectPortalUnLock then
				if Attack.Pos(CstlePos_Miti, 8) then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-12471.169921875, 374.94024658203, -7551.677734375))
				elseif Attack.Pos(Man3Pos_Miti, 8) then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-5072.08984375, 314.5412902832, -3151.1098632812))
				elseif Attack.Pos(HydraPos_Miti, 8) then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(5748.7587890625, 610.44982910156, -267.81704711914))
				elseif Attack.Pos(HydratoCastle, 8) then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-5072.08984375, 314.5412902832, -3151.1098632812))
				end
			end
		end)
	end
end)
Dropdown = Tabs.Misc:AddDropdown("Dropdown", {
	Title = "Select State Haki",
	Values = {"0", "1", "2", "3", "4", "5"},
	Multi = false,
	Default = "0"
})
Dropdown:OnChanged(function(Value)
	if Value == "0" then
		_G.SelectStateHaki = 0
	elseif Value == "1" then
		_G.SelectStateHaki = 1
	elseif Value == "2" then
		_G.SelectStateHaki = 2
	elseif Value == "3" then
		_G.SelectStateHaki = 3
	elseif Value == "4" then
		_G.SelectStateHaki = 4
	elseif Value == "5" then
		_G.SelectStateHaki = 5
	end
end)
Tabs.Misc:AddButton({
	Title = "Change Stage Haki",
	Callback = function()
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ChangeBusoStage", _G.SelectStateHaki)
	end
})
Toggle = Tabs.Misc:AddToggle("Toggle", {
	Title = "Turn On RTX Mode",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.RTXMode = Value
	local a = game.Lighting
	local c = Instance.new("ColorCorrectionEffect", a)
	local e = Instance.new("ColorCorrectionEffect", a)
	OldAmbient = a.Ambient
	OldBrightness = a.Brightness
	OldColorShift_Top = a.ColorShift_Top
	OldBrightnessc = c.Brightness
	OldContrastc = c.Contrast
	OldTintColorc = c.TintColor
	OldTintColore = e.TintColor
	if not _G.RTXMode then
		return
	end
	while _G.RTXMode do
		wait()
		a.Ambient = Color3.fromRGB(33, 33, 33)
		a.Brightness = 0.3
		c.Brightness = 0.176
		c.Contrast = 0.39
		c.TintColor = Color3.fromRGB(217, 145, 57)
		game.Lighting.FogEnd = 999
		if not game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("PointLight") then
			local a2 = Instance.new("PointLight")
			a2.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
			a2.Range = 15
			a2.Color = Color3.fromRGB(217, 145, 57)
		end
		if not _G.RTXMode then
			a.Ambient = OldAmbient
			a.Brightness = OldBrightness
			a.ColorShift_Top = OldColorShift_Top
			c.Contrast = OldContrastc
			c.Brightness = OldBrightnessc
			c.TintColor = OldTintColorc
			e.TintColor = OldTintColore
			game.Lighting.FogEnd = 2500
			game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("PointLight"):Destroy()
		end
	end
end)
Tabs.Misc:AddButton({
	Title = "Turn On Fast Mode",
	Callback = function()
		for _, zx in next, workspace:GetDescendants() do
			if table.find({"Part", "SpawnLocation", "Terrain", "WedgePart", "MeshPart"}, v.ClassName) then
				zx.Material = "Plastic"
			end
		end
	end
})
Tabs.Misc:AddButton({
	Title = "FPS Booster",
	Callback = function()
		FPSBooster()
	end
})
Tabs.Misc:AddButton({
	Title = "Turn On Speed Boat",
	Callback = function()
		for i, v in pairs(workspace.Boats:GetDescendants()) do
			if table.find({"Guardian", "PirateGrandBrigade", "MarineGrandBrigade", "PirateBrigade", "MarineBrigade", "PirateSloop", "MarineSloop", "Beast Hunter"}, v.Name) and tostring(v.Owner.Value) == tostring(game.Players.LocalPlayer.Name) then
				v.VehicleSeat.MaxSpeed = 350
				v.VehicleSeat.Torque = 0.2
				v.VehicleSeat.TurnSpeed = 5
				v.VehicleSeat.HeadsUpDisplay = true
			end
		end
	end
})
Tabs.Misc:AddButton({
	Title = "Remove Fog",
	Callback = function()
		if game:GetService("Lighting"):FindFirstChild("LightingLayers") then
			game:GetService("Lighting").LightingLayers:Destroy()
		end
		if game:GetService("Lighting"):FindFirstChild("SeaTerrorCC") then
			game:GetService("Lighting").SeaTerrorCC:Destroy()
		end
		if game:GetService("Lighting"):FindFirstChild("FantasySky") then
			game:GetService("Lighting").FantasySky:Destroy()
		end
	end
})
Tabs.Misc:AddButton({
	Title = "Rain Fruit",
	Callback = function()
		for i, v in pairs(game:GetObjects("rbxassetid://14759368201")[1]:GetChildren()) do
			v.Parent = game.Workspace.Map
			v:MoveTo(game.Players.LocalPlayer.Character.PrimaryPart.Position + Vector3.new(math.random(-50, 50), 100, math.random(-50, 50)))
			if v.Fruit:FindFirstChild("AnimationController") then
				v.Fruit:FindFirstChild("AnimationController"):LoadAnimation(v.Fruit:FindFirstChild("Idle")):Play()
			end
			v.Handle.Touched:Connect(function(otherPart)
				if otherPart.Parent == game.Players.LocalPlayer.Character then
					v.Parent = game.Players.LocalPlayer.Backpack
					game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
				end
			end)
		end
	end
})
Toggle = Tabs.Misc:AddToggle("Toggle", {
	Title = "Turn On Full Bright",
	Default = false
})
Toggle:OnChanged(function(Value)
	if Value then
		game:GetService("Lighting").Ambient = Color3.new(1, 1, 1)
		game:GetService("Lighting").ColorShift_Bottom = Color3.new(1, 1, 1)
		game:GetService("Lighting").ColorShift_Top = Color3.new(1, 1, 1)
	else
		game:GetService("Lighting").Ambient = Color3.new(0, 0, 0)
		game:GetService("Lighting").ColorShift_Bottom = Color3.new(0, 0, 0)
		game:GetService("Lighting").ColorShift_Top = Color3.new(0, 0, 0)
	end
end)
Dropdown = Tabs.Misc:AddDropdown("Dropdown", {
	Title = "Select Time",
	Values = {"Day", "Night"},
	Multi = false,
	Default = "Day"
})
Dropdown:OnChanged(function(Value)
	_G.SelectTime = Value
end)
Toggle = Tabs.Misc:AddToggle("Toggle", {
	Title = "Turn On Time",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.TurnOnTime = Value
end)
task.spawn(function()
	while task.wait() do
		if _G.TurnOnTime then
			if _G.SelectTime == "Day" then
				game:GetService("Lighting").ClockTime = 12
			elseif _G.SelectTime == "Night" then
				game:GetService("Lighting").ClockTime = 0
			end
		end
	end
end)
Toggle = Tabs.Misc:AddToggle("Toggle", {
	Title = "Turn On Walk On Water",
	Default = true
})
Toggle:OnChanged(function(Value)
	_G.WalkWater_Part = Value
	if _G.WalkWater_Part then
		game:GetService("Workspace").Map["WaterBase-Plane"].Size = Vector3.new(1000, 112, 1000)
	else
		game:GetService("Workspace").Map["WaterBase-Plane"].Size = Vector3.new(1000, 80, 1000)
	end
end)
Toggle = Tabs.Misc:AddToggle("Toggle", {
	Title = "Turn On Ice Walk",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.WalkWater = Value
end)
spawn(function()
	while task.wait() do
		if _G.WalkWater then
			pcall(function()
				if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("LeftFoot") then
					local upval0 = game:GetService("ReplicatedStorage").Assets.Models.IceSpikes4:Clone()
					upval0.Parent = workspace
					upval0.Size = Vector3.new(3 + math.random(10, 12), 1.7, 3 + math.random(10, 12))
					upval0.Color = Color3.fromRGB(128, 187, 219)
					upval0.CFrame = CFrame.new(game.Players.LocalPlayer.Character.Head.Position.X, -3.8, game.Players.LocalPlayer.Character.Head.Position.Z) * CFrame.Angles((math.random() - 0.5) * 0.06, math.random() * 7, (math.random() - 0.5) * 0.07)
					local var85 = {}
					var85.Size = Vector3.new(0, 0.3, 0)
					local var3 = game:GetService("TweenService"):Create(upval0, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), var85)
					var3.Completed:Connect(function()
						upval0:Destroy()
					end)
					var3:Play()
				end
			end)
		end
	end
end)
Dropdown = Tabs.Setting:AddDropdown("Dropdown", {
	Title = "Speed Tween",
	Values = {"180", "200", "250", "300", "350"},
	Multi = false,
	Default = "300"
})
Dropdown:OnChanged(function(Value)
	_G.SpeedTween = Value
	if _G.SpeedTween == "180" then
		SpeedTween = 180
	elseif _G.SpeedTween == "200" then
		SpeedTween = 200
	elseif _G.SpeedTween == "250" then
		SpeedTween = 250
	elseif _G.SpeedTween == "300" then
		SpeedTween = 300
	elseif _G.SpeedTween == "350" then
		SpeedTween = 350
	end
end)
Toggle = Tabs.Setting:AddToggle("Toggle", {
	Title = "Auto Click",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.Click = Value
end)
spawn(function()
	while task.wait() do
		if _G.Click then
			pcall(function()
				AttackNoCD()
			end)
		end
	end
end)
Toggle = Tabs.Setting:AddToggle("Toggle", {
	Title = "Bring Mob",
	Default = true
})
Toggle:OnChanged(function(Value)
	_G.BringMob = Value
end)
Toggle = Tabs.Setting:AddToggle("Toggle", {
	Title = "Auto Turn On Buso",
	Default = true
})
Toggle:OnChanged(function(Value)
	Boud = Value
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if Boud then
				local _HasBuso = {
					"HasBuso",
					"Buso"
				}
				if not game.Players.LocalPlayer.Character:FindFirstChild(_HasBuso[1]) then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(_HasBuso[2])
				end
			end
		end)
	end
end)
Toggle = Tabs.Setting:AddToggle("Toggle", {
	Title = "Auto Turn On Race V3",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.TurnOnRaceV3 = Value
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.TurnOnRaceV3 then
				repeat
					game:GetService("ReplicatedStorage").Remotes.CommE:FireServer("ActivateAbility")
					wait(30)
				until not _G.TurnOnRaceV3
			end
		end)
	end
end)
Toggle = Tabs.Setting:AddToggle("Toggle", {
	Title = "Auto Turn On Race V4",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.TurnOnRaceV4 = Value
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.TurnOnRaceV4 then
				if game.Players.LocalPlayer.Character:FindFirstChild("RaceEnergy") then
					if game.Players.LocalPlayer.Character:FindFirstChild("RaceEnergy").Value == 1 then
						Keyevent("Y", 0)
					end
				end
			end
		end)
	end
end)
Toggle = Tabs.Setting:AddToggle("Toggle", {
	Title = "Auto Spin Position",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.SpinPosition = Value
end)
Toggle = Tabs.Setting:AddToggle("Toggle", {
	Title = "Anti AFK",
	Default = true
})
Toggle:OnChanged(function(Value)
	_G.AntiAFK = Value
end)
game.Players.LocalPlayer.Idled:connect(function()
	game:GetService("VirtualUser"):Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
	wait()
	game:GetService("VirtualUser"):Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
end)
Toggle = Tabs.Setting:AddToggle("Toggle", {
	Title = "Remove Hit VFX",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.HitVFX = Value
end)
spawn(function()
	while task.wait() do
		if _G.HitVFX then
			pcall(function()
				local Efeect = {
					"SlashHit",
					"CurvedRing",
					"SwordSlash",
					"SlashTail"
				}
				for _, x in pairs(workspace["_WorldOrigin"]:GetChildren()) do
					if table.find(Effect, x.Name) then
						x:Destroy()
					end
				end
			end)
		end
	end
end)
Toggle = Tabs.Setting:AddToggle("Toggle", {
	Title = "Remove Death And Respawn VFX",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.DeathRespawn = Value
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.DeathRespawn then
				if game:GetService("ReplicatedStorage").Effect.Container:FindFirstChild("Death") then
					game:GetService("ReplicatedStorage").Effect.Container.Death:Destroy()
				end
				if game:GetService("ReplicatedStorage").Effect.Container:FindFirstChild("Respawn") then
					game:GetService("ReplicatedStorage").Effect.Container.Respawn:Destroy()
				end
			end
		end)
	end
end)
Toggle = Tabs.Setting:AddToggle("Toggle", {
	Title = "Hide Notify",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.HideNotify = Value
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.HideNotify then
				game.Players.LocalPlayer.PlayerGui.Notifications.Enabled = false
			else
				game.Players.LocalPlayer.PlayerGui.Notifications.Enabled = true
			end
		end)
	end
end)
Toggle = Tabs.Setting:AddToggle("Toggle", {
	Title = "Hide Damage",
	Default = false
})
Toggle:OnChanged(function(Value)
	_G.HideDamage = Value
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.HideDamage then
				game:GetService("ReplicatedStorage").Assets.GUI.DamageCounter.Enabled = false
			else
				game:GetService("ReplicatedStorage").Assets.GUI.DamageCounter.Enabled = true
			end
		end)
	end
end)