local common = require 'gui.common'

local Label = {}
local metatable = common.create_metatable(Label)
common.add_position(metatable, 'label')
common.add_size(metatable, 'label')
common.add_label(metatable, 'label', 'text')

local function word_wrap(label)
  if label.word_wrap and label.width ~= nil then
    local width = label.width
    label.wx:Wrap(label.width)
    label.width = width
  end
end

local base_set_text = metatable.set_text
function metatable.set_text(object, value)
  local width = object.width
  base_set_text(object, value)
  metatable[object].original_text = value
  object.width = width
  
  word_wrap(object)
end

local base_set_width = metatable.set_width
function metatable.set_width(object, value)
  if object.word_wrap then
    object.wx:SetLabel(metatable[object].original_text or '')
    object.wx:Wrap(value)
  end
  
  base_set_width(object, value)
end

function metatable.set_word_wrap(object, value)
  local values = getmetatable(object)[object]
  values.word_wrap = value
  
  word_wrap(object)
end

function Label.create(parent)
  local label = {
    parent = parent
  }
  
  label.wx = wx.wxStaticText(
    parent.wx_panel or parent.wx,
    wx.wxID_ANY,
    '',
    wx.wxDefaultPosition,
    wx.wxDefaultSize
  )
  
  common.propagate_events(label)
  common.add_mouse_events(label)
  
  setmetatable(label, metatable)
  label.anchor = 'top left'
  
  return label
end

return Label