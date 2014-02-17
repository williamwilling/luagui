local common = require 'gui.common'

local TextBox = {}
local metatable = common.create_metatable(TextBox)
common.add_position(metatable, 'text box')
common.add_size(metatable, 'text box')
common.add_anchor(metatable, 'text box')
common.add_value(metatable, 'text box', 'text')

function TextBox.create(parent)
  local text_box = {
    parent = parent
  }
  
  text_box.wx = wx.wxTextCtrl(
    parent.wx_panel or parent.wx,
    wx.wxID_ANY,
    '',
    wx.wxDefaultPosition,
    wx.wxDefaultSize)
  
  common.add_event(text_box, 'on_text_changed', wx.wxEVT_COMMAND_TEXT_UPDATED)
  parent.wx:Connect(wx.wxEVT_SIZE, function(event) metatable.update_anchor(text_box) event:Skip() end)
  
  setmetatable(text_box, metatable)
  text_box.anchor = 'top left'
  
  return text_box
end

return TextBox