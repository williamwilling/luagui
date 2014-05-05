local common = require 'gui.common'

local TextBox = {}
local metatable = common.create_metatable(TextBox)
common.add_position(metatable, 'text box')
common.add_size(metatable, 'text box')
common.add_anchor(metatable, 'text box')
common.add_value(metatable, 'text box', 'text')

function create_text_box(text_box, parent)
  local style = 0
  
  if text_box.multiline then
    style = style + wx.wxTE_MULTILINE
  end
  
  text_box.wx = wx.wxTextCtrl(
    text_box.parent.wx_panel or text_box.parent.wx,
    wx.wxID_ANY,
    text_box.text or '',
    wx.wxDefaultPosition,
    wx.wxDefaultSize,
    style or 0)
  
  common.add_event(text_box, 'on_text_changed', wx.wxEVT_COMMAND_TEXT_UPDATED)
  text_box.parent.wx:Connect(wx.wxEVT_SIZE, function(event) metatable.update_anchor(text_box) event:Skip() end)
  
  setmetatable(text_box, metatable)
  text_box.anchor = 'top left'
end

function metatable.set_multiline(object, value)
  rawset(object, 'multiline', value)
  
  local wx = object.wx
  create_text_box(object)
  wx:Destroy()
end

function TextBox.create(parent)
  local text_box = {
    parent = parent
  }
  
  create_text_box(text_box)
  return text_box
end

return TextBox