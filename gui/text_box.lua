local common = require 'gui.common'

local TextBox = {}
local metatable = common.create_metatable(TextBox)
common.add_position(metatable, 'textbox')
common.add_size(metatable, 'textbox')
common.add_value(metatable, 'textbox', 'text')

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
  parent.wx:Connect(wx.wxEVT_SIZE, function(event) text_box:update_anchor(parent.wx) event:Skip() end)
  
  setmetatable(text_box, metatable)
  
  text_box.anchoring = {
    left = text_box.x,
    right = parent.width - text_box.x - text_box.width,
    top = text_box.y,
    bottom = parent.height - text_box.y - text_box.height
  }
  
  return text_box
end

function TextBox:update_anchor(wx_parent)
  local width = self.width
  local height = self.height
  
  if string.find(self.anchor, 'right') or string.find(self.anchor, 'all') then
    width = self.parent.width - self.x - self.anchoring.right
  end
  
  if string.find(self.anchor, 'bottom') or string.find(self.anchor, 'all') then
    height = self.parent.height - self.y - self.anchoring.bottom
  end
  
  self.wx:SetClientSize(width, height)
end

return TextBox