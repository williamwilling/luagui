local common = require 'gui.common'

local TextBox = {}
local metatable = common.create_metatable(TextBox)
common.add_position(metatable, 'a textbox')
common.add_size(metatable, 'a textbox')
common.add_text(metatable, 'a textbox')

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