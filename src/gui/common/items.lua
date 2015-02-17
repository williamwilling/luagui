local check = require 'gui.check'

return function(metatable, object_description, property_name)
  metatable.set_items = function(object, value)
    check.parameter_type('table', value, object_description, property_name)
    
    object.wx:Clear()
    for _, value in ipairs(value) do
      object.wx:Append(tostring(value))
    end
  end
end