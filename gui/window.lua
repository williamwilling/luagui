local common = require 'gui.common'
local Button = require 'gui.button'
local TextBox = require 'gui.text_box'

local Window = {}
local metatable = common.create_metatable(Window)
common.add_position(metatable, 'window')
common.add_size(metatable, 'window')
common.add_label(metatable, 'window', 'title')

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
  return window
end

function Window:add_button()
  return Button.create(self.wx_panel)
end

function Window:add_text_box()
  return TextBox.create(self)
end

return Window