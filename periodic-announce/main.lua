-- Copyright (c) 2022 Lion Kortlepel. Use allowed under MIT license.

local minutes = 5
local message = "this is lionkor's periodic announcement plugin"

function discordReminder()
	MP.SendChatMessage(-1, message)
end

MP.CancelEventTimer("nMinTimer")

MP.CreateEventTimer("nMinTimer", 1000 * 60 * minutes)

MP.RegisterEvent("nMinTimer", "discordReminder")

