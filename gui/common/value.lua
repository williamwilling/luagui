local check = require 'gui.check'

return function(metatable, object_description, property_name)
  metatable.get_text = function(object)
    return object.wx:GetValue()
  end

  metatable.set_text = function(object, value)
    check.parameter_type({ 'string', 'number' }, value, object_description, property_name)
    
    object.wx:SetValue(tostring(value))
  end
end