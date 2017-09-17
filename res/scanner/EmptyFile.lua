-- ====== Empty File ======
-- @name            Empty File
-- @name:zh_CN      空文件
-- @name:zh_TW      空檔案
-- @description     check empty file
-- @author          Lamusia
-- @homepage        https://github.com/lamusia/drdrHash
-- @version         1.0

sEmptyFile = 'Empty File'

if ui.Language == 'zh_CN' then
  sEmptyFile = '空文件'
elseif ui.Language == 'zh_TW' then
  sEmptyFile = '空檔案'
end

function execute(FileName)
  local Handle = fs.FileOpen(FileName, bit.bor(fs.fmOpenRead, fs.fmShareDenyWrite))
  local FileLength = fs.FileSeek(Handle, 0, fs.fsFromEnd)
  fs.FileClose(Handle)

  if FileLength == 0 then
    return sEmptyFile
  end

  return ''
end
