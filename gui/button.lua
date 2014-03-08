local common = require 'gui.common'

local Button = {}
local metatable = common.create_metatable(Button)
common.add_position(metatable, 'button')
common.add_size(metatable, 'button')
common.add_label(metatable, 'button', 'text')
common.add_anchor(metatable, 'button')

function Button.create(parent)
  local button = {
    parent = parent
  }
  
  button.wx = wx.wxButton(
    parent.wx_panel or parent.wx,
    wx.wxID_ANY,
    '',
    wx.wxDefaultPosition,
    wx.wxDefaultSize)
  
  common.add_event(button, 'on_click', wx.wxEVT_COMMAND_BUTTON_CLICKED)
  parent.wx:Connect(wx.wxEVT_SIZE, function(event) metatable.update_anchor(button) event:Skip() end)
  
  setmetatable(button, metatable)
  button.anchor = 'top left'
  
  return button
end

function Button:click()
  local event = wx.wxCommandEvent(wx.wxEVT_COMMAND_BUTTON_CLICKED)
  self.wx:GetEventHandler():ProcessEvent(event)
end

return Button