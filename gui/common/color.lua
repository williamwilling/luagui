local check = require 'gui.check'

return function(metatable, object_description)
  metatable.get_background_color = function(object)
    local color = object.wx:GetBackgroundColour()
    return {
      red = color:Red() / 255,
      green = color:Green() / 255,
      blue = color:Blue() / 255,
      alpha = color:Alpha() / 255
    }
  end
  
  metatable.set_background_color = function(object, value)
    check.parameter_type('table', value, object_description, 'background color')
    
    local red, green, blue, alpha
    
    if value.red ~= nil or value.blue ~= nil or value.green ~= nil or value.alpha ~= nil then
      red = value.red or 0
      green = value.green or 0
      blue = value.blue or 0
      alpha = value.alpha or 1
    else
      red = value[1] or 0
      green = value[2] or 0
      blue = value[3] or 0
      alpha = value[4] or 1
    end
    
    local color = wx.wxColour(
      math.ceil(red * 255),
      math.ceil(green * 255),
      math.ceil(blue * 255),
      math.ceil(alpha * 255))
    
    object.wx:SetBackgroundColour(color)
    object.wx:Refresh()
  end
end