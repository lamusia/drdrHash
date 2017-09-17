-- ====== Recent File ======
-- @name            Recent File
-- @name:zh_CN      近期文件
-- @name:zh_TW      近期檔案
-- @description     find recent file
-- @author          Lamusia
-- @homepage        https://github.com/lamusia/drdrHash
-- @version         1.0

sHowManyDaysOfRecentFiles = 'How many days of recent files'
sDay = 'Days'
sDays = 'Days'
sHours = 'Hours'
sMins = 'Minutes'
sSecs = 'Seconds'

if ui.Language == 'zh_CN' then
  sHowManyDaysOfRecentFiles = '最近多少天的文件'
  sDay = '天数'
  sDays = '天'
  sHours = '时'
  sMins = '分'
  sSecs = '秒'
elseif ui.Language == 'zh_TW' then
  sHowManyDaysOfRecentFiles = '最近多少天的檔案'
  sDay = '天數'
  sDays = '天'
  sHours = '时'
  sMins = '分'
  sSecs = '秒'
end

TimeNow = os.time()
TimeRange = tonumber(ui.InputQuery(sHowManyDaysOfRecentFiles, sDay, '3'))
if TimeRange == nil then
  TimeRange = 3
end
TimeRange = TimeRange * 24 * 60 * 60

function execute(FileName)
  local FileTime = fs.FileGetTime(FileName)

  if FileTime == nil then
    return ''
  end

  local FileAge = TimeNow - FileTime
  -- print(FileName .. ' ' .. FileAge)

  if FileAge < TimeRange then
    local days = string.format("%02.f", math.floor(FileAge / (24 * 60 * 60)));
    local hours = string.format("%02.f", math.floor(FileAge % (24 * 60 * 60) / (60 * 60)));
    local mins = string.format("%02.f", math.floor(FileAge % (24 * 60 * 60) % (60 * 60) / 60));
    local secs = string.format("%02.f", math.floor(FileAge % (24 * 60 * 60) % (60 * 60) % 60));
    local text = ''
    if FileAge > 24 * 60 * 60 then
      text = days .. sDays .. ' ' .. hours .. sHours
    elseif FileAge > 60 * 60 then
      text = hours .. sHours .. ' ' .. mins .. sMins
    elseif FileAge > 60 then
      text = mins .. sMins .. ' ' .. secs .. sSecs
    else
      text = secs .. sSecs
    end
    return text
  end

  return ''
end
