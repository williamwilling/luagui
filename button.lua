local common = require 'common'

local Button = {}
local metatable = common.create_metatable(Button)

function metatable.set_text(button, value)
  if type(value) ~= 'string' and type(value) ~= 'number' then
    local message = string.format('The text of a button must be a string, not a %s.', type(value))
    error(message, 3)
  end
  
  button.wx_button:SetLabel(tostring(value))
end

function metatable.set_x(button, value)
  if type(value) ~= 'number' then
    local message = string.format('The x-coordinate of a button must be a number, not a %s.', type(value))
    error(message, 3)
  end
  
  local y = button.y or button.wx_button:GetPosition():GetY()
  button.wx_button:Move(value, y)
end

function metatable.set_y(button, value)
  if type(value) ~= 'number' then
    local message = string.format('The y-coordinate of a button must be a number, not a %s.', type(value))
    error(message, 3)
  end
  
  local x = button.x or button.wx_button:GetPosition():GetX()
  button.wx_button:Move(x, value)
end

function metatable.set_width(button, value)
  if type(value) ~= 'number' then
    local message = string.format('The width of a button must be a number, not a %s.', type(value))
    error(message, 3)
  end
  
  local height = button.height or button.wx_button:GetClientSize():GetHeight()
  button.wx_button:SetClientSize(value, height)
  
  return button.wx_button:GetClientSize():GetWidth()
end

function metatable.set_height(button, value)
  if type(value) ~= 'number' then
    local message = string.format('The height of a button must be a number, not a %s.', type(value))
    error(message, 3)
  end
  
  local width = button.width or button.wx_button:GetClientSize():GetWidth()
  button.wx_button:SetClientSize(width, value)
  
  return button.wx_button:GetClientSize():GetHeight()
end

function Button.create(wx_parent)
  local button = {}
  
  button.wx_button = wx.wxButton(
    wx_parent,
    wx.wxID_ANY,
    '',
    wx.wxDefaultPosition,
    wx.wxDefaultSize)
  
  setmetatable(button, metatable)
  metatable[button] = {}
  
  button.text = ''
  button.x = 0
  button.y = 0
  button.width = button.wx_button:GetSize():GetWidth()
  button.height = button.wx_button:GetSize():GetHeight()
  
  return button
end

return Button