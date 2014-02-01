local common = {}

function common.create_metatable(class)
  return {
    __newindex = function(object, key, value)
      local self = getmetatable(object)
      local setter = self['set_' .. key]
      
      if setter ~= nil then
        self[object][key] = setter(object, value) or value
      else
        rawset(object, key, value)
      end
    end,

    __index = function(object, key)
      local self = getmetatable(object)
      local setter = self['set_' .. key]
      
      if setter ~= nil then
        return self[object][key]
      end
      
      return rawget(object, key) or class[key]
    end
  }
end

function common.add_position(metatable, object_description)
  metatable.set_x = function(object, value)
    if type(value) ~= 'number' then
      local message = string.format('The x-coordinate of %s must be a number, not a %s.', object_description, type(value))
      error(message, 3)
    end
    
    local y = object.y or object.wx:GetPosition():GetY()
    object.wx:Move(value, y)
  end

  metatable.set_y = function(object, value)
    if type(value) ~= 'number' then
      local message = string.format('The y-coordinate of %s must be a number, not a %s.', object_description, type(value))
      error(message, 3)
    end
    
    local x = object.x or object.wx:GetPosition():GetX()
    object.wx:Move(x, value)
  end
end

function common.add_size(metatable, object_description)
  metatable.set_width = function(window, value)
    if type(value) ~= 'number' then
      local message = string.format('The width of a window must be a number, not a %s.', type(value))
      error(message, 3)
    end
    
    local height = window.height or window.wx:GetClientSize():GetHeight()
    window.wx:SetClientSize(value, height)
    
    return window.wx:GetClientSize():GetWidth()
  end

  metatable.set_height = function(window, value)
    if type(value) ~= 'number' then
      local message = string.format('The height of a window must be a number, not a %s.', type(value))
      error(message, 3)
    end
    
    local width = window.width or window.wx_frame:GetClientSize():GetWidth()
    window.wx:SetClientSize(width, value)
    
    return window.wx:GetClientSize():GetHeight()
  end
end

return common