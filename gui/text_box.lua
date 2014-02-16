local common = require 'gui.common'

local TextBox = {}
local metatable = common.create_metatable(TextBox)
common.add_position(metatable, 'textbox')
common.add_size(metatable, 'textbox')
common.add_value(metatable, 'textbox', 'text')

function metatable.update_anchor(object)
  local x, y, width, height
  
  local anchor_left = string.find(object.anchor, 'left') or string.find(object.anchor, 'all')
  local anchor_right = string.find(object.anchor, 'right') or string.find(object.anchor, 'all')
  local anchor_top = string.find(object.anchor, 'top') or string.find(object.anchor, 'all')
  local anchor_bottom = string.find(object.anchor, 'bottom') or string.find(object.anchor, 'all')
  
  if anchor_left and anchor_right then
    x = object.x
    width = object.parent.width - object.x - object.anchoring.right
  elseif anchor_right and not anchor_left then
    x = object.parent.width - object.anchoring.right - object.width
    width = object.width
  end
  
  if anchor_top and anchor_bottom then
    y = object.y
    height = object.parent.height - object.y - object.anchoring.bottom
  elseif not anchor_top and anchor_bottom then
    y = object.parent.height - object.anchoring.bottom - object.height
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
  
  text_box.anchoring = {
    left = text_box.x,
    right = parent.width - text_box.x - text_box.width,
    top = text_box.y,
    bottom = parent.height - text_box.y - text_box.height
  }
  
  return text_box
end

return TextBox