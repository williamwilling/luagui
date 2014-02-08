local common = require 'gui.common'

local TextBox = {}
local metatable = common.create_metatable(TextBox)
common.add_position(metatable, 'textbox')
common.add_size(metatable, 'textbox')
common.add_value(metatable, 'textbox', 'text')

function TextBox.create(wx_parent)
  local text_box = {}
  
  text_box.wx = wx.wxTextCtrl(
    wx_parent,
    wx.wxID_ANY,
    '',
    wx.wxDefaultPosition,
    wx.wxDefaultSize)
  
  local on_text_changed = function()
    if type(text_box.on_text_changed) == 'function' then
      text_box.on_text_changed(text_box)
    end
  end
  
  text_box.wx:Connect(wx.wxEVT_COMMAND_TEXT_UPDATED, on_text_changed)
  
  setmetatable(text_box, metatable)
  return text_box
end

return TextBox