local Button = {}
local metatable = {}

function metatable.__newindex(button, key, value)
  local self = getmetatable(button)
  local setter = self['set_' .. key]
  
  if setter ~= nil then
    self[button][key] = setter(button, value) or value
  else
    rawset(button, key, value)
  end
end

function metatable.__index(button, key)
  local self = getmetatable(button)
  local setter = self['set_' .. key]
  
  if setter ~= nil then
    return self[button][key]
  end
  
  return rawget(button, key) or Button[key]
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
  
  return button
end

return Button