local common = require 'gui.common'

local Button = {}
local metatable = common.create_metatable(Button)
common.add_position(metatable, 'button')
common.add_size(metatable, 'button')
common.add_label(metatable, 'button', 'text')

function Button.create(wx_parent)
  local button = {}
  
  button.wx = wx.wxButton(
    wx_parent,
    wx.wxID_ANY,
    '',
    wx.wxDefaultPosition,
    wx.wxDefaultSize)
  
  common.add_event(button, 'on_click', wx.wxEVT_COMMAND_BUTTON_CLICKED)
  
  setmetatable(button, metatable)
  return button
end

return Button