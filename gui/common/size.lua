return function(metatable, object_description)
  metatable.get_width = function(object)
    return object.wx:GetSize():GetWidth()
  end
  
  metatable.get_height = function(object)
    return object.wx:GetSize():GetHeight()
  end

  metatable.set_width = function(object, value)
    if type(value) ~= 'number' then
      local message = string.format('The width of a window must be a number, not a %s.', type(value))
      error(message, 3)
    end
    
    local height = object.height
    object.wx:SetClientSize(value, height)
    
    return object.wx:GetClientSize():GetWidth()
  end

  metatable.set_height = function(object, value)
    if type(value) ~= 'number' then
      local message = string.format('The height of a window must be a number, not a %s.', type(value))
      error(message, 3)
    end
    
    local width = object.width
    object.wx:SetClientSize(width, value)
    
    return object.wx:GetClientSize():GetHeight()
  end
end