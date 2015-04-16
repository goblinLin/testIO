-----------------------------------------------------------------------------------------
--
-- io.lua
-- 本檔案可以用來將字串存到指定的檔案中，也可讀回來
-- 
-- Author: Zack Lin
-- Time: 2015/4/16
-----------------------------------------------------------------------------------------
--所要儲存的檔名
local fileName = "record.txt"

--將text存到檔案中
function saveFile( text )
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
		fileHandle:write(text)
		--完成之後，別忘了關閉io以節省效能
		io.close( fileHandle )
	else
		print( "找不到可供寫入的檔案" )
	end
end

--將內容從資料中讀取出來
function loadFile(  )
	local path = system.pathForFile( fileName, system.DocumentsDirectory )
	local fileHandle, errorString = io.open(path, "r")
	local content
	if (fileHandle) then
		--讀取檔案裡頭的所有內容
		content = fileHandle:read("*a")

		--完成之後，別忘了關閉io以節省效能
		io.close( fileHandle )
		if (content) then
			print( "content:".. content )
		else
			print( "檔案讀取失敗" )
		end
	else
		print( "找不到可供讀取的檔案" )
	end
	return content, errorString
end