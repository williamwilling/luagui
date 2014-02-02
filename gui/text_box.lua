local common = require 'gui.common'

local TextBox = {}
local metatable = common.create_metatable(TextBox)
common.add_position(metatable, 'a textbox')
common.add_size(metatable, 'a textbox')
common.add_value(metatable, 'a textbox', 'text')

function TextBox.create(wx_parent)
  local text_box = {}
  
  text_box.wx = wx.wxTextCtrl(
    wx_parent,
    wx.wxID_ANY,
    '',
    wx.wxDefaultPosition,
    wx.wxDefaultSize)
  
  setmetatable(text_box, metatable)
  return text_box
end

return TextBox