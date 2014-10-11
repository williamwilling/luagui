local common = require 'gui.common'
local Button = require 'gui.button'
local Label = require 'gui.label'
local MenuBar = require 'gui.menu_bar'
local TextBox = require 'gui.text_box'
local Dialog = require 'gui.dialog'
local FileDialog = require 'gui.file_dialog'
local Image = require 'gui.image'

local Window = {}
local metatable = common.create_metatable(Window)
common.add_position(metatable, 'window')
common.add_client_size(metatable, 'window')
common.add_label(metatable, 'window', 'title')
common.add_color(metatable, 'window')

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
  
  window.menu_bar = MenuBar.create()
  window.wx:SetMenuBar(window.menu_bar.wx)
  
  window.wx_panel:Connect(wx.wxEVT_SIZE, function()
    if type(window.on_resize) == 'function' then
      window:on_resize()
    end
  end)
  
  window.wx:Show(true)
  
  common.forward_mouse_events(window)
  common.add_mouse_events(window)
  common.add_keyboard_events(window)
  
  setmetatable(window, metatable)
  return window
end

function Window:create_file_dialog()
  return FileDialog.create(self)
end

function Window:create_dialog()
  return Dialog.create(self)
end

function Window:add_button()
  return Button.create(self)
end

function Window:add_label()
  return Label.create(self)
end

function Window:add_image()
  return Image.create(self)
end

function Window:add_text_box()
  return TextBox.create(self)
end

function Window:close()
  self.wx:Close()
end

return Window