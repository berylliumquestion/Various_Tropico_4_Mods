print("NoFreeImmigrantsMeansNoFreeImmigrants.lua loaded!")

OnMsg.UASetMode = function(actions,mode)
	if(mode == "Pre-Game") then
		function GetTimelineEventTemplates()
			local templates = {}
			for i = 1, #DataInstances.SequenceList do
				local seq_list = DataInstances.SequenceList[i]
				if seq_list ~= DataInstances.SequenceList.Help then
					for j = 1, #seq_list do
						local seq = seq_list[j]
						if seq:IsKindOf("SequenceTimeline") then
							if GameSettings.ImmigrantsOut then
								if seq.name ~= "Allende Elected" and seq.name ~= "Pinochett Ousts Allende" and seq.name ~= "Che Guevara Exports Revolutions" and seq.name ~= "Economic crisis in Asia" and seq.name ~= "The Argentinian Junta drives out criminals" then
									templates[seq.name] = seq
								end
							else
								templates[seq.name] = seq
							end
						end
					end
				end
			end
			return templates
		end
	end
end