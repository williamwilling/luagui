local check = require 'gui.check'

return function(metatable, object_description)
  metatable.get_width = function(object)
    return object.wx:GetClientSize():GetWidth()
  end
  
  metatable.get_height = function(object)
    return object.wx:GetClientSize():GetHeight()
  end

  metatable.set_width = function(object, value)
    check.parameter_type('number', value, object_description, 'width')
    
    local height = object.height
    object.wx:SetClientSize(value, height)
    
    object.anchoring.right = object.parent.width - object.x - value
    
    return object.wx:GetClientSize():GetWidth()
  end

  metatable.set_height = function(object, value)
    check.parameter_type('number', value, object_description, 'height')
    
    local width = object.width
    object.wx:SetClientSize(width, value)
    
    object.anchoring.bottom = object.parent.height - object.y - value
    
    return object.wx:GetClientSize():GetHeight()
  end
end