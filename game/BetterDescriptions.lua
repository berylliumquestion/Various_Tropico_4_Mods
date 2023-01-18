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

local FiredOnce = false
OnMsg.UASetMode = function(actions,mode)
    if not FiredOnce then
        if(mode == "Boot") then
            FiredOnce = true
            CreateRealTimeThread(function()
                fixPrisonModeDescriptions()
                fixArrestDescription()
            end)
        end
    end
end