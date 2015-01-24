local common = require 'gui.common'

local TextBox = {}
common.is_destroyable(TextBox)
common.is_focusable(TextBox)

local metatable = common.create_metatable(TextBox)
common.add_position(metatable, 'text box')
common.add_size(metatable, 'text box')
common.add_anchor(metatable, 'text box')
common.add_value(metatable, 'text box', 'text')
common.add_color(metatable, 'text box')
common.add_text_color(metatable, 'text box')
common.add_selection(metatable, 'text box')

local function create_text_box(text_box)
  local style = wx.wxTE_NOHIDESEL
  
  if text_box.multiline then
    style = style + wx.wxTE_MULTILINE
  end
  
  if text_box.word_wrap then
    style = style + wx.wxTE_BESTWRAP
  elseif text_box.multiline then
    style = style + wx.wxTE_DONTWRAP
  end
  
  text_box.wx = wx.wxTextCtrl(
    text_box.parent.wx_panel or text_box.parent.wx,
    wx.wxID_ANY,
    text_box.text or '',
    wx.wxDefaultPosition,
    wx.wxDefaultSize,
    style or 0)
  
  common.propagate_events(text_box)
  common.add_mouse_events(text_box)
  common.add_anchor_event(text_box)
  common.add_event(text_box, 'on_text_changed', wx.wxEVT_COMMAND_TEXT_UPDATED)
  
  setmetatable(text_box, metatable)
  text_box.anchor = 'top left'
end

local function recreate_text_box(text_box)
  local values = getmetatable(text_box)[text_box]
  
  local copy = {}
  for k,v in pairs(values) do
    if k ~= 'multiline' and k ~= 'word_wrap' then
      copy[k] = v
    end
  end
  
  local from, to = text_box.wx:GetSelection()
  local wx = text_box.wx
  create_text_box(text_box)
  wx:Destroy()
  text_box.wx:SetSelection(from, to)
  
  for k,v in pairs(copy) do
    text_box[k] = v
  end
end

function metatable.set_multiline(object, value)
  local values = getmetatable(object)[object]
  values.multiline = value
  
  recreate_text_box(object)
end

function metatable.set_word_wrap(object, value)
  local values = getmetatable(object)[object]
  values.word_wrap = value
  
  recreate_text_box(object)
end

function TextBox.create(parent)
  local text_box = {
    parent = parent,
    wx_events = {}
  }
  
  create_text_box(text_box)
  return text_box
end

return TextBox