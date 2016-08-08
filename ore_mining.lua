ore_mining = {

click = async(function(player, npc)

-- test comment for GITHUB

	local dispoIncreasePersecond = (100 / 604800)

	local currentbronsonTalkTime = os.time()
	local bronsonLastTalkTime = player.registy["bronsonLastTalkTime"]
	local miningTrainerBronsonDispo = player.registry["miningTrainerBronsonDispo"]

	local bronsonDeltaTalkTime = bronsonLastTalkTime - currentbronsonTalkTime

	local name = "<b>["..npc.name.."]\n\n"

	-- Set the graphic to "t"
	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	-- set the pickaxe graphic
	local pickaxe = {graphic = convertGraphic(3359, "item"), color = 0}
	--- set graphics
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
	-- other local initializations

	local npcName = npc.name
	local playerName = player.name

	local dispoOffsetFromNeutral = 100 - miningTrainerBronsonDispo
	-- dispoOffsetFromNeutral = (100 - 175) = -75
	-- bronsonDeltaTalkTime = (1470608460 - 147060876) = 16 Seconds
	-- 1 Full week to recover from 0 Dispo back to 100.
		-- 604800 is number of seconds in a week.

	-- positive values will mean you were on bad terms.  These need to creep up to 100
	if dispoOffsetFromNeutral > 0 then
		miningTrainerBronsonDispo = miningTrainerBronsonDispo - (bronsonDeltaTalkTime * dispoIncreasePersecond)
	end if
	if dispoOffsetFromNeutral == 0 then
		miningTrainerBronsonDispo = miningTrainerBronsonDispo
	end if
	-- negative values for dispoOffsetFromNeutral means you were on good terms.  This will slowly slide down to 100
	if dispoOffsetFromNeutral < 0 then
	miningTrainerBronsonDispo = miningTrainerBronsonDispo + (bronsonDeltaTalkTime * dispoIncreasePersecond)


	local keywordDreLoc = player.Registry["keywordDreLoc"] == 1
	local keywordHon = player.Registry["keywordHon"] == 1
	local playerGender = player.sex
	local playerBaseClass = player.baseclass
	local ability = "Mining"
	-- intialize menu table
	local opts = {}
	local optsBronsonFirst = {}
	local talkOpts = {}

	--[[ New variable bronsonDispo introduced here.  Used to track the NPCs affinity for the player.
	-- Chart of values
		- 0 To 25 = Loathes your existance.  Will not talk to you.
		- 26 to 75 = Tolerates you, but does not enjoy you being around.
		- 76 to 125 = Nuetral to you
		- 126 to 175 = Likes you a good bit, a good aquantince.
		- 176 to 200 = Your best friend!!!
	-- We first talk to Bronson, initial thoughts of you are neutral (100)
	]]--
	if bronsonLastTalkTime == 0 then

		miningTrainerBronsonDispo = 100
		-- Set your response choices.
		table.insert(optsBronsonFirst, ..playerName)
		table.insert(optsBronsonFirst, "Why would I tell you?")
		table.insert(optsBronsonFirst, "**** off")
		-- Bronson likes warriors, you get bonus dispo if you are one when you first talk to him.
		if playerBaseClass == 1 then
			player:dialogSeq({t, npcName.."Oh?  A warrior huh?!  Well, I am a miner and if you are interested, I certainly would be happy to teach you!"}, 1)
			miningTrainerBronsonDispo = miningTrainerBronsonDispo + 10
		end if
		-- normal greeting everyone sees.
		menu = player:menuString("Howdy there, have not seen your face around these parts before, what is your name?", optsBronsonFirst)
		firstEncounterBronson = 1

		-- responses to your initial encounter.
		if optsBronsonFirst == ..playerName then
			player:dialogSeq({t, npcName.."Ahh, well I will try and remember that.  Stop on by from time to time and say hello!\n  What can I get for you today?"}, 1)
			miningTrainerBronsonDispo = miningTrainerBronsonDispo + 10
		end
		if optsBronsonFirst == "Why would I tell you?" then
			player:dialogSeq({t, npcName.."Oh, well then...how can I help you???"}, 1)
			miningTrainerBronsonDispo = miningTrainerBronsonDispo
		end
		if optsBronsonFirst == "**** off" then
			player:dialogSeq({t, npcName.."Get out of my store!!!"}, 1)
			miningTrainerBronsonDispo = miningTrainerBronsonDispo - 90
			-- Kick player--
			return
		end

	end

	table.insert(opts, "Talk")
	table.insert(opts, "Buy tools")
	table.insert(opts, "Exit")

	menu = player:menuString("", opts)

	if menu == "Talk" then
		table.insert(talkOpts, "Jobs (Not Implemented)")
		table.insert(talkOpts, "Skills")
		if keywordDreLoc == 1 then
			table.insert(talkOpts, "Dre Loc (Not Implemented")
		end if
		if keywordHon == 1 then
			table.insert(talkOpts, "Hon (Not Implemented")
		end if
		if miningTrainerBronsonDispo >= 190 then
			table.insert(talkOpts, "Gossip (Not Implemented")
		end if


		if bronsonDispo >= 0 and bronsonDispo < 26
			player:dialogSeq({t, npcName.."What the hell do you want you little ****ing miscreant!!!!!\n Get the hell out!!!"}, 1)
			-- kick player
			return
		End
		if bronsonDispo > 25 and bronsonDispo < 76
			player:dialogSeq({t, npcName.."What are you doing in my store???  I have nothing to say to you!"}, 1)
		End
		if bronsonDispo > 75 and bronsonDispo < 126
			player:dialogSeq({t, npcName.."Oh, "..playerName.." was it?\n  How are you today?"}, 1)
			miningTrainerBronsonDispo = miningTrainerBronsonDispo + 1
		End
		if bronsonDispo > 125 and bronsonDispo < 176
				player:dialogSeq({t, npcName.. playerName.."!  How have you been!!!  What can I do for you today?"}, 1)
				miningTrainerBronsonDispo = miningTrainerBronsonDispo + 2
		End
		if bronsonDispo > 176 and bronsonDispo
			player:dialogSeq({t, npcName.."Well how the hell are you "..playerName.."!!!\n What can I get for ya!!!!"}, 1)
			miningTrainerBronsonDispo = miningTrainerBronsonDispo + 3
		End

		menu = player:menuString("", talkOpts)

		if menu == "Skills" then

		if playerBaseClass == 1 then
					player:dialogSeq({t, name.."Hah!  A mighty warrior like yourself will benefit greatly from working the mines!"}, 1)
		end if
		if playerBaseClass == 2 then
					player:dialogSeq({t, name.."A little scoundrel like you?  Heh, you will hardly be able to lift a Pick!!!!"}, 1)
		end if
		if playerBaseClass == 3 then
					player:dialogSeq({t, name.."Why don't you get back to your books or potions and leave this work to the real men?"}, 1)
		end if
		if playerBaseClass == 4 then
					player:dialogSeq({t, name.."Charlie Church here?  You don't belong in the mines, go back to the pulpit."}, 1)
		end if

		player:dialogSeq({t, name.."Well, before you get into this, let me tell you a little bit about mining.\n","Miners work underground, gathering ores and gems from different nodes found througout the land."}, 1)
		player:dialogSeq({t, name.."These nodes, they are worked with pickaxes.  There are a number of different pickaxes you can weild, benefits to each."}, 1)
		player:dialogSeq({t, name.."Once you have gathered ore from the node, you will then need to smelt it down."}, 1)
		player:dialogSeq({t, name.."Smelting is the second step on the way to becoming a Blacksmith.  When you smelt, you will need access to a furnace.  With this you will be able to create Ingots!"}, 1)
		player:dialogSeq({t, name.."Lastly, once you have smelted your ores into Ingots, you can then fashion the ingots into  a variety of different arms, armors accessories and more!"}, 1)
		player:dialogSeq({t, name.."Once you start down this path, you will only eventually be able to master one crafting skill.  Think about what you want that to be!"}, 1)
		choice = player:menuString("<b>[Mining]\n\nSo, are you interested in becoming an Miner?", {"Yes, I am", "Not really."})

		if choice == "Yes, I am" and player.registry["ore_Mining"] == 0 then
			player:dialogSeq({pickaxe, "<b>[Ore Mining]\n\nIn order be an Ore Miner, you will need tools to break the rocks.",
								"<b>[Ore Mining]\n\nI can sell you the basic tools, but they break easily. If you want a higher-quality tool, you'll need to look elsewhere.",
							t, "<b>["..ability.."]\n\nI think I've talked long enough, so take this pick and and try it for yourself."}, 1)
			if player:hasLegend("beginner_mining") then player:removeLegendbyName("beginner_mining") end
			player:addLegend("Beginner Ore miner", "beginner_ore_mining", 125, 108)
			player:msg(4, "=== New legend added! ===", player.ID)
			player.registry["learned_mining"] = 1
			player.registry["mining_level"] = 1
			player.registry["mining_tnl"] = 500
			player:sendMinitext("You've learned the Mining ability!")
			player:addItem("basic_pickaxe", 1)
			player.registry["bronsonDispo"] = miningTrainerBronsonDispo
			player.registyy["bronsonLastTalkTime"] = bronsonLastTalkTime
		end

	elseif menu == "Buy tools" then
		tools = player:menuString("<b>["..ability.."]\n\nWhich type of tools do you want?", {"Common tools", "Exit"})
		if tools == "Common tools" then
			player:buyExtend("<b>["..ability.."]\n\nWhat item do you wish to buy?", {Item("basic_pickaxe").id, Item("bronze_pickaxe").id})
		end
	end
end),

--[[
say = function(player, npc)

	if string.lower(player.speech) == "reset" then
		player.registry["learned_ore_mining"] = 0
		player.registry["ore_mining_level"] = 0
		player.registry["ore_mining_tnl"] = 0
		npc:talk(2, "Reset done for "..player.name)
		player:removeLegendbyName("beginner_ore_mining")
	end
end,
]]--
cast = function(player)

	local weap = player:getEquippedItem(EQ_WEAP)
	local dura

	if not player:canCast(1,1,0) then return end
	if player:hasDuration("ore_mining") then return end
	if player:hasDuration("ability") then return end

	if weap ~= nil then
		dura = math.ceil(weap.dura*1825)
		player:setDuration("ore_mining", dura)
		ability.cast(player)
	end
end,

while_cast = function(player)

	local weap = player:getEquippedItem(EQ_WEAP)
	local dura = 0
	local ore = getTargetFacing(player, BL_MOB)

	if ore == nil then
		player:setDuration("ore_mining", 0)
		player:setDuration("ability", 0)
	else
		if player:hasDuration("ability") then return else
			ability.cast(player)
		end
	end

	--if weap.yname ~= "basic_pickaxe" or weap.yname ~= "bronze_pickaxe" or weap.yname ~= "silver_pickaxe" or weap.yname ~= "golden_pickaxe" then player:setDuration("ore_mining", 0) player:setDuration("ability", 0) end


	if weap == nil then
		player:setDuration("ore_mining", 0)
		player:setDuration("ability", 0)
	end
end,

while_cast_250 = function(player)

local weap = player:getEquippedItem(EQ_WEAP)


	if weap.yname ~= "basic_pickaxe" and weap.yname ~= "bronze_pickaxe" and weap.yname ~= "silver_pickaxe" and weap.yname ~= "golden_pickaxe" then
		player:setDuration("ore_mining", 0)
		player:setDuration("ability", 0)
	end



end,



uncast = function(player)

	player:calcStat()
end
}

