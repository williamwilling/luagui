local common = require 'gui.common'

local Button = {}
local metatable = common.create_metatable(Button)
common.add_position(metatable, 'a button')
common.add_size(metatable, 'a button')
common.add_text(metatable, 'a button')

function Button.create(wx_parent)
  local button = {}
  
  button.wx = wx.wxButton(
    wx_parent,
    wx.wxID_ANY,
    '',
    wx.wxDefaultPosition,
    wx.wxDefaultSize)
  
  setmetatable(button, metatable)
  metatable[button] = {}
  
  return button
end

return Button