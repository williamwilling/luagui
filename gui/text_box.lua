local common = require 'gui.common'

local TextBox = {}
local metatable = common.create_metatable(TextBox)
common.add_position(metatable, 'a textbox')
common.add_size(metatable, 'a textbox')

function metatable.get_text(object)
  return object.wx:GetValue()
end

function metatable.set_text(object, value)
  if type(value) ~= 'string' and type(value) ~= 'number' then
    local message = string.format('The %s of %s must be a string, not a %s.', property_name, object_description, type(value))
    error(message, 3)
  end
  
  object.wx:SetValue(tostring(value))
end

function TextBox.create(wx_parent)
  local text_box = {}
  
  text_box.wx = wx.wxTextCtrl(
    wx_parent,
    wx.wxID_ANY,
    '',
    wx.wxDefaultPosition,
    wx.wxDefaultSize)
  
  setmetatable(text_box, metatable)
  metatable[text_box] = {}
  
  return text_box
end

return TextBox