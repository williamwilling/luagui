return function(metatable, object_description, property_name)
  metatable.get_text = function(object)
    return object.wx:GetValue()
  end

  metatable.set_text = function(object, value)
    if type(value) ~= 'string' and type(value) ~= 'number' then
      local message = string.format('The %s of %s must be a string, not a %s.', property_name, object_description, type(value))
      error(message, 3)
    end
    
    object.wx:SetValue(tostring(value))
  end
end