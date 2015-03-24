local common = require 'gui.common'

local Timer = {}
local timers = {}
local stop_watch

local function initialize()
  stop_watch = wx.wxStopWatch()
  stop_watch:Start()
  
  
  wx:wxGetApp():Connect(wx.wxEVT_IDLE, function(event)
    gui.collect_garbage()
    
    if #timers == 0 then
      return
    end
      
    local current_time = stop_watch:Time()
    
    for _, timer in ipairs(timers) do
      local delta_time = (current_time - timer.last_time)
      if type(timer.on_tick) == 'function' and delta_time >= timer.interval * 1000 then
        timer.last_time = current_time
        timer:on_tick(delta_time / 1000)
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
  
  function timer:start()
    table.insert(timers, self)
  end
  
  function timer:stop()
    for i, t in ipairs(timers) do
      if t == timer then
        table.remove(timers, i)
        break
      end
    end
  end

  return timer
end

return Timer