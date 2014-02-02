local check = require 'gui.check'

return function(metatable, object_description)
  metatable.get_x = function(object)
    return object.wx:GetPosition():GetX()
  end
  
  metatable.get_y = function(object)
    return object.wx:GetPosition():GetY()
  end

  metatable.set_x = function(object, value)
    check.parameter_type('number', value, object_description, 'x-coordinate')
    
    local y = object.y
    object.wx:Move(value, y)
  end

  metatable.set_y = function(object, value)
    check.parameter_type('number', value, object_description, 'y-coordinate')
    
    local x = object.x
    object.wx:Move(x, value)
  end
end