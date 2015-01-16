local check = require 'gui.check'

return function(metatable, object_description)
  if metatable.set_x == nil or metatable.set_y == nil then
    error('You must give a control position capabilities before you can give it anchor capabilities.', 2)
  end
  
  if metatable.set_width == nil or metatable.set_height == nil then
    error('You must give a control size capabilities before you can give it anchor capabilities.', 2)
  end
  
  local set_x = metatable.set_x
  local set_y = metatable.set_y
  local set_width = metatable.set_width
  local set_height = metatable.set_height
  
  metatable.set_x = function(object, value)
    check.parameter_type('number', value, object_description, 'x-coordinate')
    
    object.anchoring.left = value
    object.anchoring.right = object.parent.width - object.width - object.anchoring.left
    
    return set_x(object, value)
  end

  metatable.set_y = function(object, value)
    check.parameter_type('number', value, object_description, 'y-coordinate')
    
    object.anchoring.top = value
    object.anchoring.bottom = object.parent.height - object.height - object.anchoring.top
    
    return set_y(object, value)
  end

  metatable.set_width = function(object, value)
    check.parameter_type('number', value, object_description, 'width')
    
    object.anchoring.right = object.parent.width - object.x - value
    object.anchoring.left = object.x
    
    return set_width(object, value)
  end

  metatable.set_height = function(object, value)
    check.parameter_type('number', value, object_description, 'height')
    
    object.anchoring.bottom = object.parent.height - object.y - value
    object.anchoring.top = object.y
    
    return set_height(object, value)
  end

  metatable.set_anchor = function(object, value)
    check.parameter_type('string', value, object_description, 'anchor')
    
    object.anchoring = {
      left = object.x,
      right = object.parent.width - object.x - object.width,
      top = object.y,
      bottom = object.parent.height - object.y - object.height
    }
  end

  metatable.update_anchor = function(object)
    local x, y, width, height
    
    local anchor_left = string.find(object.anchor, 'left') or string.find(object.anchor, 'all')
    local anchor_right = string.find(object.anchor, 'right') or string.find(object.anchor, 'all')
    local anchor_top = string.find(object.anchor, 'top') or string.find(object.anchor, 'all')
    local anchor_bottom = string.find(object.anchor, 'bottom') or string.find(object.anchor, 'all')
    
    if anchor_left and anchor_right then
      x = object.x
      width = object.parent.width - object.x - object.anchoring.right
    elseif anchor_left and not anchor_right then
      x = object.x
      width = object.width
    elseif not anchor_left and anchor_right then
      x = object.parent.width - object.anchoring.right - object.width
      width = object.width
    else
      local difference = (object.parent.width - object.width) - (object.anchoring.left + object.anchoring.right)
      x = object.anchoring.left + difference / 2
      width = object.width
    end
    
    if anchor_top and anchor_bottom then
      y = object.y
      height = object.parent.height - object.y - object.anchoring.bottom
    elseif anchor_top and not anchor_bottom then
      y = object.y
      height = object.height
    elseif not anchor_top and anchor_bottom then
      y = object.parent.height - object.anchoring.bottom - object.height
      height = object.height
    else
      local difference = (object.parent.height - object.height) - (object.anchoring.top + object.anchoring.bottom)
      y = object.anchoring.top + difference / 2
      height = object.height
    end
    
    if object.wx == nil then  -- is the object an image? images don't wrap a wx control
      object.x = x
      object.y = y
      object.width = width
      object.height = height
    else
      object.wx:Move(x, y)
      object.wx:SetSize(width, height)  -- NOTE: this line assumes that anchored controls are always
                                        -- sized based on the entire control, not just the client
                                        -- area. If this ever becomes not true, we'll have to figure
                                        -- out whether to call SetSize() or SetClientSize().
    end
  end
end