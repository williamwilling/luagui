return function(metatable, object_description)
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