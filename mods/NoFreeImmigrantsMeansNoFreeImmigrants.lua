print("NoFreeImmigrantsMeansNoFreeImmigrants.lua loaded!")

OnMsg.GameTimeStart = function()
	print("game settings")
	print(GameSettings.ImmigrantsOut)
	if GameSettings.ImmigrantsOut then
		local timeline_event_subindexes_to_remove = {}
		local timeline_event_index = 0
		local ministry_event_subindexes_to_remove = {}
		local ministry_event_index = 0
		k_0 = 1
		k_1 = 1
		for i = 1, #DataInstances.SequenceList do
			local seq_list = DataInstances.SequenceList[i]
			for j = 1, #seq_list do
				local seq = seq_list[j]
				if seq.name == "Allende Elected" or seq.name == "Pinochett Ousts Allende" or  seq.name == "Che Guevara Exports Revolutions" or seq.name == "Economic crisis in Asia" or seq.name == "The Argentinian Junta drives out criminals" then
					timeline_event_subindexes_to_remove[k_0] = j
					k_0 = k_0 + 1
					timeline_event_index = i
				elseif seq.name == "Education high leadership - low" or seq.name == "Education high leadership - medium" or seq.name == "Education high leadership - high" then
					ministry_event_subindexes_to_remove[k_1] = j
					k_1 = k_1 + 1
					ministry_event_index = i
				end
			end
		end
		local reverse = {5, 4, 3, 2, 1}
		for i = 1, #reverse do
			local index = timeline_event_subindexes_to_remove[reverse[i]]
			print("removing...", DataInstances.SequenceList[timeline_event_index][index].name)
			table.remove(DataInstances.SequenceList[timeline_event_index], index)
		end
		local reverse = {3, 2, 1}
		for i = 1, #reverse do
			local index = ministry_event_subindexes_to_remove[reverse[i]]
			print("removing...", DataInstances.SequenceList[ministry_event_index][index].name)
			table.remove(DataInstances.SequenceList[ministry_event_index], index)
		end
	end
	-- I have no idea how to append or prepend to functions. 
	if IsDeveloper() and GameType == false then
		ApplyGameSettings() -- the map is started without main menu (developer mode)
	end
end