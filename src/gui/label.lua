local common = require 'gui.common'

local Label = {}
common.is_destroyable(Label)

local metatable = common.create_metatable(Label)
common.add_position(metatable, 'label')
common.add_color(metatable, 'label')
common.add_text_color(metatable, 'label')

local function word_wrap(label)
  local width, height = label.width, label.height
  
  label.wx:SetLabel(metatable[label].original_text)
  label.wx:Wrap(width)
  
  if label.width < width then
    label.wx:SetSize(width, label.height)
  end
  
  if metatable[label].fixed_height then
    label.wx:SetSize(label.width, height)
  end
end

function metatable.get_text(object)
  return object.wx:GetLabel()
end

function metatable.set_text(object, value)
  metatable[object].original_text = value
  local width, height = object.width, object.height
  
  object.wx:SetLabel(value)
  
  if metatable[object].fixed_width then
    object.wx:SetSize(width, object.height)
  end
  
  if metatable[object].fixed_height then
    object.wx:SetSize(object.width, height)
  end
  
  if object.word_wrap then
    if object.x + object.width > object.parent.width then
      object.width = object.parent.width - object.x
    end
    
    word_wrap(object)
  end
end

function metatable.set_word_wrap(object, value)
  if value == true then
    if object.x + object.width > object.parent.width then
      object.width = object.parent.width - object.x
    end
    
    word_wrap(object)
  end
end

function metatable.get_width(object)
  return object.wx:GetSize():GetWidth()
end

function metatable.set_width(object, value)
  metatable[object].fixed_width = true
  object.wx:SetSize(value, object.height)
  
  if object.word_wrap then
    word_wrap(object)
  end
  
  return object.wx:GetSize():GetWidth()
end

function metatable.get_height(object)
  return object.wx:GetSize():GetHeight()
end

function metatable.set_height(object, value)
  metatable[object].fixed_height = true
  object.wx:SetSize(object.width, value)
  return object.wx:GetSize():GetHeight()
end

common.add_anchor(metatable, 'label')

function Label.create(parent)
  local label = {
    parent = parent,
    wx_events = {}
  }
  
  metatable[label] = {
    size = {}
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
  common.add_anchor_event(label, function()
    if label.word_wrap then
      word_wrap(label)
    end
  end)
  
  setmetatable(label, metatable)
  label.anchor = 'top left'
  
  return label
end

return Label