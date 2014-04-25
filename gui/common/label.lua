local check = require 'gui.check'

return function(metatable, object_description, property_name)
  property_name = property_name or 'label'
  
  metatable['get_' .. property_name] = function(object)
    return object.wx:GetLabel()
  end

  metatable['set_' .. property_name] = function(object, value)
    check.parameter_type({ 'string', 'number' }, value, object_description, property_name)
    
    object.wx:SetLabel(tostring(value))
  end
end