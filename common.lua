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
      local getter = self['get_' .. key]
      local setter = self['set_' .. key]
      
      if getter ~= nil then
        return getter(object)
      elseif setter ~= nil then
        return self[object][key]
      end
      
      return rawget(object, key) or class[key]
    end
  }
end

function common.add_position(metatable, object_description)
  metatable.get_x = function(object)
    return object.wx:GetPosition():GetX()
  end
  
  metatable.get_y = function(object)
    return object.wx:GetPosition():GetY()
  end

  metatable.set_x = function(object, value)
    if type(value) ~= 'number' then
      local message = string.format('The x-coordinate of %s must be a number, not a %s.', object_description, type(value))
      error(message, 3)
    end
    
    local y = object.y
    object.wx:Move(value, y)
  end

  metatable.set_y = function(object, value)
    if type(value) ~= 'number' then
      local message = string.format('The y-coordinate of %s must be a number, not a %s.', object_description, type(value))
      error(message, 3)
    end
    
    local x = object.x
    object.wx:Move(x, value)
  end
end

function common.add_size(metatable, object_description)
  metatable.get_width = function(object)
    return object.wx:GetSize():GetWidth()
  end
  
  metatable.get_height = function(object)
    return object.wx:GetSize().GetHeight()
  end

  metatable.set_width = function(object, value)
    if type(value) ~= 'number' then
      local message = string.format('The width of a window must be a number, not a %s.', type(value))
      error(message, 3)
    end
    
    local height = object.height or object.wx:GetClientSize():GetHeight()
    object.wx:SetClientSize(value, height)
    
    return object.wx:GetClientSize():GetWidth()
  end

  metatable.set_height = function(object, value)
    if type(value) ~= 'number' then
      local message = string.format('The height of a window must be a number, not a %s.', type(value))
      error(message, 3)
    end
    
    local width = object.width or object.wx_frame:GetClientSize():GetWidth()
    object.wx:SetClientSize(width, value)
    
    return object.wx:GetClientSize():GetHeight()
  end
end

function common.add_text(metatable, object_description, property_name)
  property_name = property_name or 'text'
  
  metatable['get_' .. property_name] = function(object, value)
    return object.wx:GetLabel()
  end

  metatable['set_' .. property_name] = function(object, value)
    if type(value) ~= 'string' and type(value) ~= 'number' then
      local message = string.format('The %s of %s must be a string, not a %s.', property_name, object_description, type(value))
      error(message, 3)
    end
    
    object.wx:SetLabel(tostring(value))
  end
end

return common