-- ====== Broken Picture ======
-- @name            Broken Picture
-- @name:zh_CN      损坏的图片
-- @name:zh_TW      損壞的圖片
-- @description     check broken png and jpeg
-- @author          Lamusia
-- @homepage        https://github.com/lamusia/drdrHash
-- @version         1.0

sBroken = 'Broken'

if ui.Language == 'zh_CN' then
  sBroken = '损坏的'
elseif ui.Language == 'zh_TW' then
  sBroken = '損壞的'
end

function execute(FileName)
  local Handle = fs.FileOpen(FileName, bit.bor(fs.fmOpenRead, fs.fmShareDenyWrite))
  local FileLength = fs.FileSeek(Handle, 0, fs.fsFromEnd)

  -- print(FileName .. " - " .. FileLength)

  -- PNG
  if FileName:match("[^.]+$"):upper() == 'PNG' then
    if FileLength < 80 then
      fs.FileClose(Handle)
      return sBroken .. ' PNG'
    end

    local Str = "\0\0\0\0\73\69\78\68\174\66\96\130"
    fs.FileSeek(Handle, -Str:len(), fs.fsFromEnd)
    local Bytes, ReadCount = fs.FileRead(Handle, Str:len())

    if Bytes ~= Str then
      fs.FileClose(Handle)
      return sBroken .. ' PNG'
    end
  end

  -- JPG
  if FileName:match("[^.]+$"):upper() == 'JPG'
    or FileName:match("[^.]+$"):upper() == 'JPEG' then
    if FileLength < 80 then
      fs.FileClose(Handle)
      return sBroken .. ' JPG'
    end

    local Str = "\255\217"
    fs.FileSeek(Handle, -66, fs.fsFromEnd)
    local Bytes, ReadCount = fs.FileRead(Handle, 66)

    local n = Bytes:find(Str)
    if not n then
      fs.FileClose(Handle)
      return sBroken .. ' JPG'
    end

    n = n + 2
    for i = n, 66, 1 do
      if Bytes:sub(i, i) ~= "\0" then
        fs.FileClose(Handle)
        return sBroken .. ' JPG'
      end
    end
  end

  fs.FileClose(Handle)
  return ''
end
