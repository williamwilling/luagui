local check = require 'gui.check'

return function(metatable, object_description)
  metatable.set_resizable = function(object, value)
    check.parameter_type('boolean', value, object_description, 'resizable property')
    
    if value ~= object.resizable then
      local width = object.width
      local height = object.height
      
      if value then
        object.wx:SetWindowStyleFlag(wx.wxDEFAULT_DIALOG_STYLE + wx.wxRESIZE_BORDER)
      else
        object.wx:SetWindowStyleFlag(wx.wxDEFAULT_DIALOG_STYLE)
      end
      
      object.wx:Refresh()
      object.width = width
      object.height = height
    end
    
    return value
  end
end