local white = Color.new(255,255,255)
local yellow = Color.new(255,205,66)
local red = Color.new(255,0,0)
local green = Color.new(55,255,0)
local curPos = 20
local motd = ""
local size = 0
local usersize = 0

local pad = Controls.read()
local oldpad = pad

function sleep(n)
  local timer = Timer.new()
  local t0 = Timer.getTime(timer)
  while Timer.getTime(timer) - t0 <= n do end
end

function init()
    Screen.refresh()
    Screen.clear(TOP_SCREEN)
    if Network.isWifiEnabled() then
        motd = Network.requestString("x") //insert motd
    else
   		Screen.debugPrint(5,5, "SMPatches Downloader", yellow, TOP_SCREEN)
    	Screen.debugPrint(30,200, "v1.0-B", white, TOP_SCREEN)
    	Screen.debugPrint(30,215, "by Pixilate", white, TOP_SCREEN)
        Screen.debugPrint(30,20, "Wi-Fi is disabled. Restart and try again.", red, TOP_SCREEN)
        Screen.debugPrint(30,35, "Press B to go back to Homemenu", red, TOP_SCREEN)
        Screen.waitVblankStart()
        Screen.flip()
        while true do
            pad = Controls.read()
            if Controls.check(pad,KEY_B) then
            System.exit()
            end
        end
    end
end

function main()
    Screen.refresh()
    Screen.clear(TOP_SCREEN)
    Screen.debugPrint(5,5, "SMPatches Downloader (x)", yellow, TOP_SCREEN)
    Screen.debugPrint(30,200, "v1.0b", white, TOP_SCREEN)
    Screen.debugPrint(30,215, "by Pixilate", white, TOP_SCREEN)
    Screen.debugPrint(5,5, motd, white, BOTTOM_SCREEN)
    Screen.flip()

    if Network.isWifiEnabled() then
        Screen.debugPrint(30,20, "Downloading, Please wait.", green, TOP_SCREEN)
        System.createDirectory("/luma/code_sections")
        System.createDirectory("/luma/code_sections")
        Network.downloadFile("blank", "/code.bin") // get your own code.bin :p
        if System.doesFileExist("/code.bin") then
        	if System.doesFileExist("/luma/code_sections/0004000000175E00.bin") then
        		System.deleteFile("/luma/code_sections/0004000000175E00.bin")
        	end
        	System.renameFile("/code.bin", "/luma/code_sections/0004000000175E00.bin")
        	Screen.waitVblankStart()
            Screen.flip()
            System.exit()
        else
        	Screen.debugPrint(30,35, "Failed. Returning to Homemenu", red, TOP_SCREEN)
        	Screen.debugPrint(30,50, "Press B to go back to Homemenu", red, TOP_SCREEN)
        	while true do
           	pad = Controls.read()
            	if Controls.check(pad,KEY_B) then
                	System.exit()
            	end
        	end
        end
        
    else
        Screen.debugPrint(30,20, "Wi-Fi is disabled. Restart and try again.", red, TOP_SCREEN)
        Screen.debugPrint(30,35, "Press B to go back to Homemenu", red, TOP_SCREEN)
        while true do
            pad = Controls.read()
            if Controls.check(pad,KEY_B) then
                System.exit()
            end
        end
    end
end

init()
main()
