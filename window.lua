local common = require 'common'
local Button = require 'button'

local Window = {}
local metatable = common.create_metatable(Window)
common.add_position(metatable, 'a window')
common.add_size(metatable, 'a window')

function metatable.get_title(window, value)
  return window.wx:GetLabel()
end

function metatable.set_title(window, value)
  if type(value) ~= 'string' and type(value) ~= 'number' then
    local message = string.format('The title of a window must be a string, not a %s.', type(value))
    error(message, 3)
  end
  
  window.wx:SetLabel(tostring(value))
end

function Window.create()
  local window = {}
  
  window.wx = wx.wxFrame(
    wx.NULL,
    wx.wxID_ANY,
    '',
    wx.wxDefaultPosition,
    wx.wxSize(640, 480),
    wx.wxDEFAULT_FRAME_STYLE)
  
  window.wx_panel = wx.wxPanel(
    window.wx,
    wx.wxID_ANY,
    wx.wxDefaultPosition,
    wx.wxDefaultSize)
  
  window.wx:Show(true)
  
  setmetatable(window, metatable);
  metatable[window] = {}
  
  return window
end

function Window:add_button()
  return Button.create(self.wx_panel)
end

return Window