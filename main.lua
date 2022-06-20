
-- returns the players ranked by laps and times.
-- we do this by first ranking players by their laps,
-- and then ranking them by times within each lap 'group'.
-- Copyright (c) 2022 Lion Kortlepel. Use under MIT license.
function rankPlayers(players, laps, times)
    -- this function will be used later to sort
    -- players by their times. 
    -- lower time = better
    local sortByTime = function(p1, p2) 
        return times[p1] < times[p2]
    end
    
    -- inverted "laps" table - has a table of players per
    -- lap time, like so:
    -- 1: {player1, player3}
    -- 2: {player2}
    -- ...
    local playersPerLap = {}
    -- number of laps, we count this so we can 
    -- use it to iterate over the laps later.
    -- we can't iterate with ipairs, because 
    -- laps with no players will break that kind of loop.
    local maxLap = 0

    -- first we sort by laps - each lap gets a list of players in that lap
    -- creating an inverted 'laps' table.

    for name,lap in pairs(laps) do
        -- we need to create a table to insert into it
        if not playersPerLap[lap] then
            playersPerLap[lap] = {}
        end
        -- insert a player into the lap's table
        table.insert(playersPerLap[lap], name)
        -- update maxLap for later
        if lap > maxLap then
            maxLap = lap
        end
    end

    -- here we use maxLap: since some laps will have no players
    -- we need to iterate like this in order to skip the 'nil' values
    -- and keep iterating. ipairs() or pairs() would break at nil values.
    -- we sort each lap's players by their time, so that each lap table
    -- ends up with a list of players from best time to worst time (in that lap).
    for i=0,maxLap do
        -- since we dont use pairs() or similar, we need to check for nil
        if playersPerLap[i] then
            table.sort(playersPerLap[i], sortByTime)
        end
    end
    
    -- finally, we put all these lap tables into one big player table.
    -- after this step, all players will be sorted by lap, and then by time, 
    -- and we are done.
    -- again, we have to iterate with maxLap, due to the nils in playersPerLap,
    -- but we also iterate from the back to the front. 
    -- we need to do this, because: higher lap = better.
    local result = {}
    for i=maxLap,0,-1 do
        if playersPerLap[i] then
            -- these tables are already sorted in the right order, so we can 
            -- just add the players in there as-is.
            for _,v in ipairs(playersPerLap[i]) do
                table.insert(result, v)
            end
        end
    end
    -- we finally return the table. it has just player names, in the right order.
    return result
end

local players = {"caitex", "deer", "lion"}
local laps = {lion=4, caitex=3, deer=3}
local times = {lion=20, caitex=16.1, deer=16.2}

print(times)
print(laps)
print("before:")
print(players)

local res = rankPlayers(players, laps, times)

print("after:")
print(res)


