local component = require("component")
local serialization = require("serialization")
local unicode = require("unicode")
local eeprom = component.eeprom

if not component.isAvailable("internet") then
    io.stderr:write("ShalavaEFI is unable to proceed with the installation on this computer due to an Internet Card not being installed. Please install an Internet Card and restart the installation.")
end

local config = ""

local function read()
    return io.read() or os.exit()
end

local function QA(text, yesByDefault)
    io.write(("%s %s "):format(text, yesByDefault and "[Y/n]" or "[y/N]"))
    local data = read()

    if unicode.lower(data) == "y" or yesByDefault and data == "" then
        return true
    end
end

if QA("Would you like to create a Whitelist?") then
    while true do
        io.write('A whitelist protects your computer from unauthorized users. Please type your username to continue.\nWhitelist: ')
        local rawWhitelist, parsedWhitelist, n = read(), "", 0

        for substring in rawWhitelist:gmatch("[^%,%s]+") do
            parsedWhitelist = parsedWhitelist .. substring .. "|"
            n = n + 1
        end

        if #rawWhitelist > 0 and n > 0 then
            config = 'cyan="' .. parsedWhitelist .. (QA("Would you like to enforce the Whitelist and require user interaction on boot?") and "+" or "") .. '"'

            print(config, #config)
            if #config > 64 then
                io.stderr:write("Config is too big.\n")
            else
                break
            end
        else
            io.stderr:write("Malformed string.\n")
        end
    end
end

local readOnly = QA("Would you like to enable EEPROM Flash Protection?")
os.execute("wget -f https://github.com/BOPCorp/ShalavaEFI/blob/master/stuff/cyan.bin?raw=true /tmp/cyan.bin")
local file = io.open("/tmp/cyan.bin", "r")
local data = file:read("*a")
file:close()
io.write("Installing ShalavaEFI...")
local success, reason = eeprom.set(config .. data)

if not reason then
    eeprom.setLabel("Shalava BIOS")
    eeprom.setData(require("computer").getBootAddress())
    if readOnly then
        eeprom.makeReadonly(eeprom.getChecksum())
    end
    io.write(" success.\n")
    if QA("Would you like to restart your computer?", true) then
        os.execute("reboot")
    end
elseif reason == "storage is readonly" then
    io.stderr:write("This EEPROM is write protected. Please insert an EEPROM that is not write protected.")
else
    io.stderr:write(reason or "ошибка какаят хз")
end
