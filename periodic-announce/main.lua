-- Copyright (c) 2022 Lion Kortlepel. Use allowed under MIT license.
--
-- periodic-announce will pick a random message from a list of messages,
-- and send that message to chat every few minutes.
-- It also uses an algorithm to ensure that no message is repeated immediately
-- after itself. For example, if you have two messages, it will print 1, then 2,
-- then 1, and so on. Its still random, it just will never pick the same number twice
-- in a row.

-- time between messages
local minutes = 5
-- put messages here.
-- you can put only one message, or multiple messages, from which it will choose randomly
local messages = {
    "this is lionkor's periodic announcement plugin",
    "another announcement",
    "this is one more message"
}

local lastIndex = nil

local function getRandomIntNot(from, to, notvalue)
    print(from, to, notvalue)
    if to == notvalue then
        return Util.RandomIntRange(from, notvalue - 1)
    elseif from == notvalue then
        return Util.RandomIntRange(notvalue + 1, to)
    else
        -- 50/50
        local pick = Util.RandomIntRange(1, 2)
        if pick == 1 then
            return Util.RandomIntRange(from, notvalue - 1)
        else
            return Util.RandomIntRange(notvalue + 1, to)
        end
    end
end

function periodicAnnouncement()
    local index = 1
    if lastIndex and #messages > 1 then
        index = getRandomIntNot(1, #messages, lastIndex)
    end
	MP.SendChatMessage(-1, messages[index])
    lastIndex = index
end

MP.CancelEventTimer("nMinTimer")

MP.CreateEventTimer("nMinTimer", 1000 * 60 * minutes)

MP.RegisterEvent("nMinTimer", "periodicAnnouncement")


