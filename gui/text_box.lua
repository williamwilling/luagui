local common = require 'gui.common'

local TextBox = {}
local metatable = common.create_metatable(TextBox)
common.add_position(metatable, 'textbox')
common.add_size(metatable, 'textbox')
common.add_value(metatable, 'textbox', 'text')

local set_x = metatable.set_x
local set_y = metatable.set_y
local set_width = metatable.set_width
local set_height = metatable.set_height

function metatable.set_x(object, value)
  object.anchoring.left = value
  object.anchoring.right = object.parent.width - object.width - object.anchoring.left
  
  return set_x(object, value)
end

function metatable.set_y(object, value)
  object.anchoring.top = value
  object.anchoring.bottom = object.parent.height - object.height - object.anchoring.top
  
  return set_y(object, value)
end

function metatable.set_width(object, value)
  object.anchoring.right = object.parent.width - object.x - value
  object.anchoring.left = object.x
  
  return set_width(object, value)
end

function metatable.set_height(object, value)
  object.anchoring.bottom = object.parent.height - object.y - value
  object.anchoring.top = object.y
  
  return set_height(object, value)
end

function metatable.set_anchor(object, value)
  object.anchoring = {
    left = object.x,
    right = object.parent.width - object.x - object.width,
    top = object.y,
    bottom = object.parent.height - object.y - object.height
  }
end

function metatable.update_anchor(object)
  local x, y, width, height
  
  local anchor_left = string.find(object.anchor, 'left') or string.find(object.anchor, 'all')
  local anchor_right = string.find(object.anchor, 'right') or string.find(object.anchor, 'all')
  local anchor_top = string.find(object.anchor, 'top') or string.find(object.anchor, 'all')
  local anchor_bottom = string.find(object.anchor, 'bottom') or string.find(object.anchor, 'all')
  
  if anchor_left and anchor_right then
    x = object.x
    width = object.parent.width - object.x - object.anchoring.right
  elseif anchor_left and not anchor_right then
    x = object.x
    width = object.width
  elseif not anchor_left and anchor_right then
    x = object.parent.width - object.anchoring.right - object.width
    width = object.width
  else
    local difference = (object.parent.width - object.width) - (object.anchoring.left + object.anchoring.right)
    x = object.anchoring.left + difference / 2
    width = object.width
  end
  
  if anchor_top and anchor_bottom then
    y = object.y
    height = object.parent.height - object.y - object.anchoring.bottom
  elseif anchor_top and not anchor_bottom then
    y = object.y
    height = object.height
  elseif not anchor_top and anchor_bottom then
    y = object.parent.height - object.anchoring.bottom - object.height
    height = object.height
  else
    local difference = (object.parent.height - object.height) - (object.anchoring.top + object.anchoring.bottom)
    y = object.anchoring.top + difference / 2
    height = object.height
  end
  
  object.wx:Move(x, y)
  object.wx:SetClientSize(width, height)
end

function TextBox.create(parent)
  local text_box = {
    parent = parent,
  }
  
  local wx_parent = parent.wx_panel or parent.wx
  
  text_box.wx = wx.wxTextCtrl(
    wx_parent,
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