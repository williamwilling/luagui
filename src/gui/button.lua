local common = require 'gui.common'

local Button = {}
common.is_destroyable(Button)
common.is_focusable(Button)

local metatable = common.create_metatable(Button)
common.add_position(metatable, 'button')
common.add_size(metatable, 'button')
common.add_label(metatable, 'button', 'text')
common.add_anchor(metatable, 'button')
common.add_color(metatable, 'button')
common.add_text_color(metatable, 'button')

function metatable.set_word_wrap(object, value)
  if value and string.sub(object.text, -1) ~= '\n' then
    object.wx:SetLabel(object.text .. '\n')
  end
  
  if not value and string.sub(object.text, -1) == '\n' then
    object.wx:SetLabel(string.sub(object.text, 1, -2))
  end
end

function metatable.set_alignment(object, value)
  local flags = {
    left = wx.wxBU_LEFT,
    right = wx.wxBU_RIGHT,
    top = wx.wxBU_TOP,
    bottom = wx.wxBU_BOTTOM
  }
  
  local style = 0
  for k, v in pairs(flags) do
    if string.match(value, k) then
      style = style + v
    end
  end
  
  object.wx:SetWindowStyleFlag(style)
end

local base_set_text = metatable.set_text
function metatable.set_text(object, value)
  local result = base_set_text(object, value)
  object.word_wrap = object.word_wrap
  
  return result
end

function Button.create(parent)
  local button = {
    parent = parent,
    wx_events = {}
  }
  
  button.wx = wx.wxButton(
    parent.wx_panel or parent.wx,
    wx.wxID_ANY,
    '',
    wx.wxDefaultPosition,
    wx.wxDefaultSize)
  
  common.propagate_events(button)
  common.add_mouse_events(button)
  common.add_anchor_event(button)
  common.add_event(button, 'on_click', wx.wxEVT_COMMAND_BUTTON_CLICKED)
  
  setmetatable(button, metatable)
  button.anchor = 'top left'
  button.alignment = 'center'
  
  return button
end

function Button:click()
  local event = wx.wxCommandEvent(wx.wxEVT_COMMAND_BUTTON_CLICKED)
  self.wx:ProcessEvent(event)
end

return Button