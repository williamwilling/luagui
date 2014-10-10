local common = require 'gui.common'

local timers = {}
local Timer = {}
local metatable = common.create_metatable(Timer)

local stop_watch

local function initialize()
  stop_watch = wx.wxStopWatch()
  stop_watch:Start()
  
  wx:wxGetApp():Connect(wx.wxEVT_IDLE, function(event)
    local current_time = stop_watch:Time()
    
    for _, timer in ipairs(timers) do
      local delta_time = current_time - timer.last_time
      if type(timer.on_tick) == 'function' and delta_time >= timer.interval * 1000 then
        timer.last_time = current_time
        timer:on_tick(delta_time)
      end
    end
  
    event:RequestMore()
  end)
end

function Timer.create()
  if not stop_watch then
    initialize()
  end
  
  local timer = {
    interval = 1,
    last_time = stop_watch:Time()
  }

  table.insert(timers, timer)
  return timer
end

return Timer