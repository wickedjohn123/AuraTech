

--[[Skynet Nuclear ABM Defense Program by Andrew2060]]--
--[ABM Server, use with http://pastebin.com/fZ5xeB99]]--
--[System requires atleast 5 CC's with Modems and ABMs]]--
--[System has 5% chance of failure in killing missiles]]--
 
--[[Settings]]--
local waitDelay = 2
local countersPerMissile = 1
local missileDelay = 3
 
--[[Initialization]]--
local data, curSilo = {}, 1
local silos = {}
peripheral.find("modem", rednet.open)
term.setBackgroundColor(colors.blue)
 
local function red()
term.setBackgroundColor(colors.red)
print("                                                   ")
term.setBackgroundColor(colors.blue)
end
 
rednet.broadcast("ABM1")
 
repeat
        local id, msg = rednet.receive(waitDelay)
        
        if type(msg) == "table" and msg.Msg == "ABM" then
                table.insert(silos, msg)
                table.insert(data, msg.ID)
                
        end
until not id
 
 
 
--[[Main Programs]]--
while true do
    if not redstone.getInput("back") then
        term.clear()
        term.setCursorPos(1,1)
        red()
        print("        SKYNET DEFENSE SYSTEMS ACTIVATED           ")
        red()
        print("      ANTI-BALLISTIC MISSILE SHIELD ONLINE         ")
        red()
        red()
        print("               [STANDBY ABM Silos]                 ")
 
for k, v in ipairs(silos) do
        print("[S#:".. k .."] [ID:" .. v.ID .."] [Type:".. v.Missile .. "] [Target:".. v.Target .. "]")
end
        red()
       
        repeat os.pullEvent("redstone") until redstone.getInput("back")
    end
   
    term.clear()
    term.setCursorPos(1, 1)
    term.setTextColor(colors.red)
   
    print("Incoming Missiles:")
    print("Firing CounterMeasures\n")
   
 maptab = peripheral.call("back","getEntities")
 maptxt = textutils.serialize(maptab)
 if maptxt ~= "{}" then
 allDat = 0
 for num in pairs(maptab) do
 allDat = allDat+1
 end
 targets = allDat/3
 for i=0,targets-1 do
        local msg = {["x"] = math.floor(maptab["x_"..i]), ["y"] = math.floor(maptab["y_"..i]), ["z"] = math.floor(maptab["z_"..i])}
 
        print("Incoming Missile Threat #" .. i .. " at X:" .. msg.x .. " Y:" .. msg.y .. " Z:" .. msg.z)
        print("Launching " .. countersPerMissile .. " of ABM Missile CounterMeasures...\n")
 
        for i = 1, countersPerMissile do
            rednet.send(data[curSilo], msg)
            curSilo = (curSilo == #data) and 1 or (curSilo + 1)
            sleep(missileDelay)
            end
        sleep(0)
        end
     sleep(0)
    end
   sleep(2)
end
sleep(1)

