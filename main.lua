-----------------------------------------------------------------------------------------
--
-- main.lua
-- 本範例示範如何將資料寫入檔案中，以進行數據的永續保存。此作法只支援字串資料，而不支援Table資料。如果
-- 需要保存複雜資料建議改用Sqlite
-- 提醒:如想要檢查新增檔案的內容，可透過Corona Simulator的File>Show Project Sandbox來觀察檔案結構
--
-- Author: Zack Lin
-- Time: 2015/4/16
-----------------------------------------------------------------------------------------

--=======================================================================================
--引入各種函式庫
--=======================================================================================
display.setStatusBar( display.HiddenStatusBar )

local widget = require("widget")
--=======================================================================================
--宣告各種變數
--=======================================================================================
_SCREEN = {
	WIDTH = display.viewableContentWidth,
	HEIGHT = display.viewableContentHeight
}
_SCREEN.CENTER = {
	X = display.contentCenterX,
	Y = display.contentCenterY
}

local label
local btn1
local btn2
local fileName = "record.txt"

local initial
local handleButtonEvent
local saveFile
local loadFile
--=======================================================================================
--宣告與定義main()函式
--=======================================================================================
local main = function (  )
	initial()
end

--=======================================================================================
--定義其他函式
--=======================================================================================
initial = function (  )
	label = display.newText( "尚無資料", 0,  0, system.nativeFont, 40 )
	label.x = _SCREEN.CENTER.X
	label.y = _SCREEN.CENTER.Y - 150

	btn1 = widget.newButton{
		id = "btn1",
		width = 220,
	    height = 100,
	    defaultFile = "images/btn_normal.png",
	    overFile = "images/btn_over.png",
	    label = "儲存檔案",
	    fontSize = 30,
	    onEvent = handleButtonEvent
	}
	btn1.x = _SCREEN.CENTER.X
	btn1.y = _SCREEN.CENTER.Y + 100

	btn2 = widget.newButton{
		id = "btn2",
		width = 220,
		height = 100,
		defaultFile = "images/btn_normal.png",
	    overFile = "images/btn_over.png",
	    label = "讀取檔案",
	    fontSize = 30,
		onEvent = handleButtonEvent
	}
	btn2.x = _SCREEN.CENTER.X
	btn2.y = _SCREEN.CENTER.Y + 300
end

handleButtonEvent = function ( event )
	if ("ended" == event.phase) then
		if ("btn1" == event.target.id) then
			saveFile()
		elseif ("btn2" == event.target.id) then
			loadFile()
		end
	end
	
end

saveFile = function (  )
	--從Document資料夾找尋指定檔案
	local path = system.pathForFile( fileName, system.DocumentsDirectory )
	--以唯讀模式開啟該路徑的檔案，目的是檢查剛路徑檔案是否存在
	local fileHandle, errorString = io.open(path, "r")
	if (fileHandle) then
		print("檔案已存在")
	else
		print("發生的錯誤是" .. errorString)
	end
	--以寫入模式開啟該檔案，如果檔案已存在會覆蓋之前內容，如果不存在就新增
	fileHandle = io.open(path, "w+")
	if (fileHandle) then
		--將資料寫入檔案中
		local data = "江湖小蝦米的戰鬥力是" .. system.getTimer().."個"
		fileHandle:write(data)
		--完成之後，別忘了關閉io以節省效能
		io.close( fileHandle )
	else
		print( "找不到可供寫入的檔案" )
	end
end

loadFile = function (  )
	local path = system.pathForFile( fileName, system.DocumentsDirectory )
	local fileHandle, errorString = io.open(path, "r")
	if (fileHandle) then
		--讀取檔案裡頭的所有內容
		local content = fileHandle:read("*a")
		--完成之後，別忘了關閉io以節省效能
		io.close( fileHandle )
		if (content) then
			print( "content:".. content )
			label.text = content
		else
			print( "檔案讀取失敗" )
		end
	else
		print( "找不到可供讀取的檔案" )
	end
end
--=======================================================================================
--呼叫主函式
--=======================================================================================
main()