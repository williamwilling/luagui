return function(metatable, object_description, property_name)
  property_name = property_name or 'label'
  
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