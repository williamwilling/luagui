local common = {}
common.add_position = require 'gui.common.position'
common.add_size = require 'gui.common.size'
common.add_label = require 'gui.common.label'
common.add_value = require 'gui.common.value'
common.add_anchor = require 'gui.common.anchor'

function common.create_metatable(class)
  return {
    __newindex = function(object, key, value)
      local self = getmetatable(object)
      local setter = self['set_' .. key]
      
      if setter ~= nil then
        self[key] = setter(object, value) or value
      else
        rawset(object, key, value)
      end
    end,

    __index = function(object, key)
      local self = getmetatable(object)
      local getter = self['get_' .. key]
      local setter = self['set_' .. key]
      
      if getter ~= nil then
        return getter(object)
      elseif setter ~= nil then
        return self[key]
      end
      
      return rawget(object, key) or class[key]
    end
  }
end

function common.add_event(object, event_name, wx_event)
  local trigger_event = function()
    if type(object[event_name]) == 'function' then
      object[event_name](object)
    end
  end
  
  object.wx:Connect(wx_event, trigger_event)
end

return common