local common = require 'common'

local Button = {}
local metatable = common.create_metatable(Button)
common.add_position(metatable, 'a button')
common.add_size(metatable, 'a button')

function metatable.set_text(button, value)
  if type(value) ~= 'string' and type(value) ~= 'number' then
    local message = string.format('The text of a button must be a string, not a %s.', type(value))
    error(message, 3)
  end
  
  button.wx:SetLabel(tostring(value))
end

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
  
  button.text = ''
  button.x = button.wx:GetPosition():GetX()
  button.y = button.wx:GetPosition():GetY()
  button.width = button.wx:GetSize():GetWidth()
  button.height = button.wx:GetSize():GetHeight()
  
  return button
end

return Button