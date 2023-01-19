function fixPrisonModeDescriptions()
    Prison["modes"] = {
        {
            id = "ConvictLabor",
            name = "[[Prison mode1_name][Use Convict Labor][Prison name]]",
            param1 = 3,
            rollover = "Work, you dogs! Every prisoner will generate $3 profit per month and will be released in 3 years."
        },
        {
            id = "Reeducation",
            name = "[[Prison mode2_name][Reeducation][Prison name]]",
            param1 = 20,
            rollover = "A wide range of re-educational \"I love Presidente\" courses are offered. The respect of all prisoners is raised by 20% and will be released in 20 years."
        }
    }
end

function fixArrestDescription()
    EdictArrest["rollover"] = "A policeman will arrest and detain the target for 3 or 20 years if sent to regular prison, or a million years if sent to labor camp. Sentence only begins as soon as arrestee enters the prison. This will decrease the respect of the target's family. May or may not decrease respect of target depending on building mode chosen if sent to regular prison."
end

function fixImmigrationOfficeModeDescriptions()
    ImmigrationOffice["modes"] = {
        {
          id = "OpenDoorImmigration",
          name = "[[ImmigrationOffice mode1_name][Open Doors][ImmigrationOffice name]]",
          param1 = 30,
          param2 = 16,
          rollover = "[[ImmigrationOffice mode1_rollover][Attracts more immigrants. Increases the total population over time, depending on the skill of the workers. %d4][ImmigrationOffice name]]"
        },
        {
          id = "SkilledWorkersWelcome",
          name = "[[ImmigrationOffice mode2_name][Skilled Workers][ImmigrationOffice name]]",
          param1 = 2,
          param2 = 15,
          param3 = 25,
          rollover = "[[ImmigrationOffice mode2_rollover][Attracts more high-school and college-educated immigrants. %d4][WorkModeWrapper rollover]]"
        },
        {
          id = "TropicoFirst",
          name = "[[ImmigrationOffice mode3_name][Tropico First][ImmigrationOffice name]]",
          rollover = "Immigration is forbidden, except for hired specialists. Does not prevent immigration caused by timeline events or minister events."
        },
        {
          id = "LoveItOrLeaveIt",
          name = "[[ImmigrationOffice mode4_name][Love It or Leave It][ImmigrationOffice name]]",
          param1 = 30,
          param2 = 30,
          rollover = "[[ImmigrationOffice mode4_rollover][Increases emigration, depending on the skill of the workers. Unhappy citizens leave the island first. %d4][ImmigrationOffice name]]"
        },
        {
          id = "NoEmmigration",
          name = "[[ImmigrationOffice mode5_name][No Emigration][ImmigrationOffice name]]",
          rollover = "[[ImmigrationOffice mode5_rollover][Nobody gets out of here alive - emigration is forbidden][ImmigrationOffice name]]"
        }
    }
end

local FiredOnce = false
OnMsg.UASetMode = function(actions,mode)
    if not FiredOnce then
        if(mode == "Boot") then
            FiredOnce = true
            CreateRealTimeThread(function()
                fixPrisonModeDescriptions()
                fixArrestDescription()
                fixImmigrationOfficeModeDescriptions()
            end)
        end
    end
end