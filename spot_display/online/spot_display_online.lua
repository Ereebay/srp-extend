
-- creadit: takeyoh(app version), eree(online version)
local textView = true
local screen = {}
screen.position = vec2(ac.getSim().windowWidth - 500, 0)
screen.sizeOriginal = vec2(500, 100)
screen.size = screen.sizeOriginal
screen.ratio = 1
--todo
--support modify window size and posistion 

local image_remote_path = "GITHUB" --remote file path
local image_local_path
local function imagecallback(err, folder)
    image_local_path = folder
    end

web.loadRemoteAssets(image_remote_path, imagecallback)


--todo
--add multi-language support and save in ini file
local spot_json = {
	["001_tatsumi"] = { position = vec3(6012.77, 25.3407, -4734.69), distance = 300, text = "Tatsumi", desc = "辰巳枢纽&停车场", sign = { "B", "9" } },
	["003_oiw"] = { position = vec3(957.802, 6.20322, -241.709), distance = 20, text = "Oi West", desc = '大井停车场(西)', sign = { "B" } },
	["004_daikoku"] = { position = vec3(-5762.29, 37.5254, 13899.1), distance = 500, text = "Daikoku", desc = "大黑枢纽&停车场", sign = { "B", "K5" } },
	["006_heiwajiman"] = { position = vec3(-248.728, 6.14233, 1335.42), distance = 50, text = "Heiwajima North", desc = "平和岛停车场(北)", sign = { "1-Haneda" } },
	["007_heiwajimas"] = { position = vec3(-134.202, 6.14233, 1505.93), distance = 50, text = "Heiwajima South", desc = "平和岛停车场(南)", sign = { "1-Haneda" } },
	["008_shibaura"] = { position = vec3(1111.85, 24.6933, -4671.34), distance = 100, text = "Shibaura", desc = "芝浦停车场", sign = { "11" } },
	["009_yoyogi"] = { position = vec3(-4312.81, 36.1041, -8863.79), distance = 100, text = "Yoyogi", desc = "代代木停车场", sign = { "4" } },
	["010_hakozaki"] = { position = vec3(3736.02, 25.2367, -8896.6), distance = 200, text = "Hakozaki", desc = "箱崎枢纽&停车场", sign = { "6", "9" } },
	["011_oigate"] = { position = vec3(890.153, 5.93044, -21.5081), distance = 50, text = "Oi Gate", desc = '大井收费站', sign = { "B" } },
	["012_heiwajimagate"] = { position = vec3(-201.221, 6.14233, 1420.25), distance = 50, text = "Heiwajima Gate", desc = "平和岛收费站", sign = { "1-Haneda" } },
	["013_daishigate"] = { position = vec3(-330.267, 15.2987, 6106.98), distance = 300, text = "Daishi Gate&PA", desc = "大师收费站&停车场", sign = { "K1" } },
	["014_ukishimagate"] = { position = vec3(4017.07, -6.61236, 8667.47), distance = 300, text = "Wangan Ukishima Gate & JCT", desc = '湾岸浮岛收费站&箱崎浮岛枢纽', sign = { "B", "K6", "CA" } },
	["015_shiodomegate"] = { position = vec3(1589.36, 13, -7178.67), distance = 100, text = "Shiodome Gate", desc = '汐留收费站', sign = { "KK" } },
	["016_shirauobashigate"] = { position = vec3(2374.46, 12.3989, -8090.31), distance = 60, text = "Shirauobashi Gate", desc = "白鱼桥收费站", sign = { "KK" } },
	["101_shinonome"] = { position = vec3(4606.73, 4.73252, -3997.69), distance = 200, text = "Shinonome", desc = "东云枢纽", sign = { "B", "10" } },
	["102_ariake"] = { position = vec3(3499.14, 11.3702, -3272.78), distance = 300, text = "Ariake", desc = "有明枢纽", sign = { "B", "11" } },
	["103_oi"] = { position = vec3(924.81, -1.75569, -682.871), distance = 300, text = "Oi", desc = "大井枢纽", sign = { "B", "1-Haneda" } },
	["104_tokai"] = { position = vec3(1040.94, 9.43539, 1937.55), distance = 300, text = "Tokai", desc = "东海枢纽", sign = { "B", "1-Haneda" } },
	["106_honmoku"] = { position = vec3(-7089.07, 36.7278, 16144.3), distance = 300, text = "Honmoku", desc = "本牧枢纽", sign = { "B", "K3" } },
	["107_ishikawamachi"] = { position = vec3(-8953.52, 12.9601, 16298.2), distance = 300, text = "Ishikawa-cho", desc = "石川町枢纽", sign = { "K1", "K3" } },
	["108_kinkou"] = { position = vec3(-10928.5, 15.7634, 13530.2), distance = 300, text = "Kinkou", desc = "金港枢纽", sign = { "K1", "K2" } },
	["109_namamugi"] = { position = vec3(-6693, 23.4684, 11055), distance = 300, text = "Namamugi", desc = "生麦枢纽", sign = { "K1", "K5" } },
	["111_showajima"] = { position = vec3(357.458, 6.17978, 2860.75), distance = 300, text = "Showajima", desc = "昭和岛枢纽", sign = { "1-Haneda", "B" } },
	["112_shibaura"] = { position = vec3(1120.36, 18.9591, -5105.35), distance = 200, text = "Shibaura", desc = "芝浦枢纽", sign = { "1-Haneda", "11" } },
	["113_hamazaki"] = { position = vec3(1248.5, 3.68874, -5677.64), distance = 200, text = "Hamazaki-bashi", desc = "滨崎桥枢纽", sign = { "C1", "1-Haneda" } },
	["114_ichinohashi"] = { position = vec3(-691.654, 14.2413, -6034.87), distance = 200, text = "Ichino-hashi", desc = "一之桥枢纽", sign = { "C1", "2" } },
	["115_tanimachi"] = { position = vec3(-631.591, 29.9587, -7205.63), distance = 200, text = "Tanimachi", desc = "谷町枢纽", sign = { "C1", "3" } },
	["116_miyakezaka"] = { position = vec3(-93.3564, 12.9984, -8861.91), distance = 300, text = "Miyakezaka", desc = "三宅坂枢纽", sign = { "C1", "4" } },
	["117_takebashi"] = { position = vec3(1043.65, 21.2163, -10015), distance = 200, text = "Takebashi", desc = "竹桥枢纽", sign = { "C1", "5" } },
	["118_kandabashi"] = { position = vec3(1942.82, 12.8168, -9730.01), distance = 200, text = "Kandabashi", desc = "神田桥枢纽", sign = { "C1", "Y" } },
	["119_edobashi"] = { position = vec3(3017.92, 17.9275, -9180.99), distance = 200, text = "Edobashi", desc = "江户桥枢纽", sign = { "C1", "1-Ueno", "6" } },
	["120_kyobashi"] = { position = vec3(2610.89, -1.45341, -8375.66), distance = 200, text = "Kyobashi", desc = "京桥枢纽", sign = { "C1", "KK" } },
	["121_shiodome"] = { position = vec3(1375.11, 9.62679, -6582.45), distance = 200, text = "Shiodome", desc = "汐留枢纽", sign = { "C1", "KK" } },
	["122_nishiginza"] = { position = vec3(1799.37, 11.5908, -8228.01), distance = 200, text = "Nishi-ginza", desc = "西银座枢纽", sign = { "KK", "Y" } },
	["201_tokyokou"] = { position = vec3(1715.62, -14.0811, -1912.65), distance = 400, text = "Tokyo Port Tunnel", desc = "东京港隧道", sign = { "B" } },
	["202_kukokita"] = { position = vec3(2412.73, -2.06087, 3725.83), distance = 400, text = "Airport North Tunnel", desc = "成田机场隧道(北)", sign = { "B" } },
	["203_haneda"] = { position = vec3(3579.28, 2.41074, 4773.05), distance = 400, text = "Haneda Airport", desc = "羽田机场", sign = { "B" } },
	["204_kukominami"] = { position = vec3(4106.48, 7.52677, 5599.55), distance = 200, text = "Airport South Tunnel", desc = "成田机场隧道(南)", sign = { "B" } },
	["205_tamagawa"] = { position = vec3(4508.9, -16.4857, 7413.77), distance = 500, text = "Tama River Tunnel", desc = "多摩川隧道", sign = { "B" } },
	["206_kawasaki"] = { position = vec3(3017.29, -17.3941, 9390.21), distance = 400, text = "Kawasaki Sea Route Tunnel", desc = "川崎航路隧道", sign = { "B" } },
	["207_ogijima"] = { position = vec3(-627.484, 19.4299, 11279.9), distance = 500, text = "Ohgi-jima", desc = "扇岛", sign = { "B" } },
	["208_tsubasabashi"] = { position = vec3(-4167.09, 57.8988, 13031), distance = 400, text = "Tsurumi Tsubasa Bridge", desc = "鹤见翼大桥", sign = { "B" } },
	["209_baybridge"] = { position = vec3(-6456.47, 70.6993, 14800.3), distance = 400, text = "Yokohama Bay Bridge", desc = "横滨湾大桥", sign = { "B" } },
	["210_minatomirai"] = { position = vec3(-10257.4, -11.5322, 15271), distance = 500, text = "Minato Mirai", desc = "港未来", sign = { "K1" } },
	["211_yokohama"] = { position = vec3(-11029.8, 7.71466, 13981.7), distance = 200, text = "Yokohama Station", desc = "横滨站", sign = { "K1" } },
	["212_hamakawasaki"] = { position = vec3(-2306.39, 9.57236, 8772.42), distance = 300, text = "Hama-Kawasaki", desc = "滨川崎", sign = { "K1" } },
	["213_hanedatun"] = { position = vec3(781.334, -2.49223, 3785.7), distance = 200, text = "Haneda Tunnel", desc = "羽田隧道", sign = { "1-Haneda" } },
	["214_rainbow"] = { position = vec3(1615.39, 68.4292, -3886.03), distance = 400, text = "Rainbow Bridge", desc = "彩虹大桥", sign = { "11" } },
	["215_shibuya"] = { position = vec3(-4562.9, 44.1738, -6043.4), distance = 200, text = "Shibuya", desc = "涉谷", sign = { "3" } },
	["216_shibuyast"] = { position = vec3(-4069.96, 16.2501, -6314.1), distance = 50, text = "Shibuya Station", desc = "涉谷站", sign = {} },
	["217_kasumigaseki"] = { position = vec3(144.441, 12.5388, -7959.09), distance = 300, text = "Kasumigaseki Tunnel", desc = "霞关隧道", sign = { "C1" } },
	["218_shinjyuku"] = { position = vec3(-4951.75, 55.7387, -9219.09), distance = 200, text = "Shinjuku", desc = "新宿", sign = { "4" } },
	["219_shinjyukust"] = { position = vec3(-4291.22, 32.5538, -10000.9), distance = 200, text = "Shinjuku Station", desc = "新宿站", sign = {} },
	["220_akasaka"] = { position = vec3(-1463.47, 27.3732, -8932.84), distance = 200, text = "Akasaka Tunnel", desc = "赤坂隧道", sign = { "4" } },
	["221_chiyoda"] = { position = vec3(-47.26, 19.3487, -9435.2), distance = 200, text = "Chiyoda Tunnel", desc = "千代田隧道", sign = { "C1" } },
	["222_shintomi"] = { position = vec3(2025.38, -3.08133, -7355.03), distance = 200, text = "Shintomi-cho", desc = "新冨町", sign = { "C1" } },
	["223_ginza"] = { position = vec3(1205.57, 11.9002, -7433.28), distance = 200, text = "Ginza", desc = "银座", sign = { "KK" } },
	["225_fukagawa"] = { position = vec3(4547.76, 11.9811, -8158.71), distance = 200, text = "Fukagawa", desc = "深川", sign = { "9" } },
	["226_kiba"] = { position = vec3(5449.12, 16.8871, -7146.18), distance = 200, text = "Kiba", desc = "木场", sign = { "9" } },
	["227_koyasu"] = { position = vec3(-8102.54, 2.31987, 11619.2), distance = 100, text = "Koyasu", desc = "子安", sign = { "K1" } },
	["228_jrtsurumi"] = { position = vec3(-5714.91, 11.7512, 10596.6), distance = 100, text = "JR Tsurumi Line", desc = "JR鹤见线", sign = { "K1" } },
	["229_oikeiba"] = { position = vec3(-481.87, 10.3684, 717.932), distance = 100, text = "Oikei Racecourse", desc = "大井赛马场", sign = { "1-Haneda" } },
	["230_monorail"] = { position = vec3(568.884, 3.13706, -1456.1), distance = 100, text = "Tokyo Monorail", desc = "东京单轨电车", sign = { "1-Haneda" } },
	["231_tennoz"] = { position = vec3(475.66, 9.86598, -2424.25), distance = 200, text = "Tennoz Isle", desc = "天王洲岛", sign = { "1-Haneda" } },
	["232_shiba"] = { position = vec3(157.842, 12.0166, -5762.68), distance = 200, text = "Shiba Park & Tokyo Tower", desc = "芝公园&东京塔", sign = { "C1" } },
	["233_roppongi"] = { position = vec3(-1202.48, 39.3356, -6872.51), distance = 100, text = "Roppongi", desc = "六本木", sign = { "3" } },
	["234_nishiazabu"] = { position = vec3(-2001.8, 35.933, -6487.58), distance = 100, text = "Nishi-Azabu", desc = "西麻布", sign = { "3" } },
	["235_aoyama"] = { position = vec3(-3001.54, 32.1418, -6373.94), distance = 100, text = "Minami-Aoyama", desc = "南青山", sign = { "3" } },
	["236_scramble"] = { position = vec3(-4099.68, 16.2501, -6454.4), distance = 50, text = "Scramble Intersection", desc = "涉谷十字路口", sign = {} },
	["237_shinanomachi"] = { position = vec3(-2280.45, 26.3273, -8722.63), distance = 100, text = "Shinano-Machi Station", desc = "信浓町站", sign = { "4" } },
	["238_sendagaya"] = { position = vec3(-3188, 39.0325, -8878.68), distance = 100, text = "Sendagaya Station", desc = "千驮谷站", sign = { "4" } },
	["239_meijijingu"] = { position = vec3(-4028.47, 39.3714, -8750.32), distance = 100, text = "Meiji Jingu", desc = "明治神宫", sign = { "4" } },
	["240_koenmae"] = { position = vec3(-4988.04, 34.5371, -9899.07), distance = 100, text = "Shinjuku Central Park", desc = "新宿中央公园", sign = {} },
	["241_chidorigafutchi"] = { position = vec3(170.301, 19.0781, -9783.31), distance = 50, text = "Chidorigafuchi", desc = "千鸟渊", sign = { "C1" } },
	["242_kitanomaru"] = { position = vec3(548.193, 11.3379, -9819.29), distance = 50, text = "Kitano-maru tunnel", desc = "北之丸隧道", sign = { "C1" } },
	["243_tatsumimori"] = { position = vec3(6027.71, 21.9626, -5593.23), distance = 200, text = "Tatsumi-no-mori", desc = "辰巳之森海滨公园", sign = { "9" } },
	["244_ogijimae"] = { position = vec3(719.902, 4.96745, 10607.1), distance = 300, text = "Higashi-ohgi-jima", desc = "东扇岛", sign = { "B" } },
	["245_heiwajima"] = { position = vec3(87.9044, 5.73247, 2013.19), distance = 100, text = "Heiwajima", desc = "平和岛", sign = { "1-Haneda" } },
	["246_chukagai"] = { position = vec3(-8702.04, 13.9963, 16158.3), distance = 100, text = "Yokohama China Town", desc = '横滨唐人街', sign = { "K3" } },
	["247_daiba"] = { position = vec3(2766.2, -2.30561, -2781.22), distance = 100, text = "Daiba", desc = "台场", sign = { "B" } },
	["248_yaesuparking"] = { position = vec3(2147.12, -6.675, -8774.81), distance = 200, text = "Tokyo Yaesu Parking", desc = "东京站八重洲停车场", sign = { "Y" } }
}

local spots
spots = spot_json

local time = 0
local transparent = 0
local text, desc
local sign ={}
function script.update(dt)
	for spot in pairs(spots) do
		if spots[spot].distance > math.sqrt((spots[spot].position.x - ac.getCar(0).position.x) ^ 2 + (spots[spot].position.y - ac.getCar().position.y) ^ 2 + (spots[spot].position.z - ac.getCar().position.z) ^ 2) then
			time = 3
			text = spots[spot].text
			desc = spots[spot].desc
			sign = spots[spot].sign
		end
	end
	if time > 0 then
		time = time - dt
		if transparent <= 1 and time > 1 then
			transparent = transparent + dt
		elseif time <= 1 then
			transparent = transparent - dt
		end
	elseif time < 0 then
		time = 0
		transparent = 0
		text = nil
	end

	ac.debug("time", time)
	ac.debug("transparent", transparent)
	ac.debug("spot", text)
	ac.debug("screen", screen.position)
end

local signPos, i
function script.drawUI()
	ui.pushDWriteFont('Segoe UI;Weight=Bold')
	if textView and time > 0 then
		ui.drawRectFilled(screen.position, screen.position + screen.size, rgbm(0, 0, 0, 0.2 * transparent))

		local topText = text or ""
		local bottomText = desc or ""

		local areaWidth = screen.size.x
		local topAreaHeight = screen.size.y * 0.5
		local bottomAreaHeight = screen.size.y * 0.5

		local topFontSize = 28
		local bottomFontSize = 35

		local topTextSize = ui.measureDWriteText(topText, topFontSize)
		local bottomTextSize = ui.measureDWriteText(bottomText, bottomFontSize)

		if topTextSize.x > areaWidth * 0.9 or topTextSize.y > topAreaHeight * 0.9 then
			local widthRatio = areaWidth * 0.9 / topTextSize.x
			local heightRatio = topAreaHeight * 0.9 / topTextSize.y
			local scaleFactor = math.min(widthRatio, heightRatio)
			topFontSize = math.max(18, math.floor(topFontSize * scaleFactor))
		end

		if bottomTextSize.x > areaWidth * 0.9 or bottomTextSize.y > bottomAreaHeight * 0.9 then
			local widthRatio = areaWidth * 0.9 / bottomTextSize.x
			local heightRatio = bottomAreaHeight * 0.9 / bottomTextSize.y
			local scaleFactor = math.min(widthRatio, heightRatio)
			bottomFontSize = math.max(20, math.floor(bottomFontSize * scaleFactor))
		end

		topFontSize = topFontSize * screen.ratio
		bottomFontSize = bottomFontSize * screen.ratio

		ui.dwriteDrawTextClipped(text, topFontSize, screen.position,
			screen.position + screen.size + vec2(0, -screen.size.y * 0.65), ui.Alignment.Center,
			ui.Alignment.Center, false, rgbm(1, 1, 1, transparent))

		ui.dwriteDrawTextClipped(desc, bottomFontSize,
			screen.position + vec2(0, screen.size.y * 0.35),
			screen.position + screen.size, ui.Alignment.Center,
			ui.Alignment.Center, false, rgbm(1, 1, 1, transparent))
		signPos = screen.position + vec2(screen.size.x / 2, screen.size.y) + vec2(-50 * screen.ratio * #sign, 0)

		if #sign > 0 then
			for i = 1, #sign do
				ac.debug('sign',sign[i])
				ui.drawImage(image_local_path .. "\\Shuto_Urban_Expwy_Sign_" .. sign[i] .. ".png",
					signPos + vec2(100 * (i - 1) * screen.ratio, 0),
					signPos + vec2(100 * i * screen.ratio, 80 * screen.ratio),
					rgbm(1, 1, 1, transparent), vec2(0, 0), vec2(1, 1), ui.ImageFit.Fit)
			end
		end
	end
	ui.popDWriteFont()
end
