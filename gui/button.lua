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
  
  local on_click = function()
    if type(button.on_click) == 'function' then
      button.on_click(button)
    end
  end
  
  button.wx:Connect(wx.wxEVT_COMMAND_BUTTON_CLICKED, on_click)
  
  setmetatable(button, metatable)
  metatable[button] = {}
  
  return button
end

return Button