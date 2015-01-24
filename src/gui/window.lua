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
common.add_resizable(metatable, 'window')

function metatable.set_cursor(object, value)
  local cursors = {
    ["arrow"] = wx.wxCURSOR_ARROW,
    ["right arrow"] = wx.wxCURSOR_RIGHT_ARROW,
    ["hand"] = wx.wxCURSOR_HAND,
    ["magnifier"] = wx.wxCURSOR_MAGNIFIER,
    ["no entry"] = wx.wxCURSOR_NO_ENTRY,
    ["question"] = wx.wxCURSOR_QUESTION_ARROW,
    ["size sinister"] = wx.wxCURSOR_SIZENESW,
    ["size baroque"] = wx.wxCURSOR_SIZENWSE,
    ["size horizontal"] = wx.wxCURSOR_SIZEWE,
    ["size vertical"] = wx.wxCURSOR_SIZENS,
    ["move"] = wx.wxCURSOR_SIZING,
    ["wait"] = wx.wxCURSOR_WAIT,
    ["wait arrow"] = wx.wxCURSOR_ARROWWAIT
  }
  
  object.wx:SetCursor(wx.wxCursor(cursors[value] or wx.wxCURSOR_ARROW))
end

function Window.create()
  local window = {
    images = {}
  }
  
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

  window.wx:Connect(wx.wxEVT_CLOSE_WINDOW, function(event)
    if type(window.on_closing) ~= 'function' or window:on_closing() ~= false or not event:CanVeto() then
      window.wx:Destroy()
    end
  end)

  window.wx_panel:Connect(wx.wxEVT_PAINT, function(event)
    common.paint_images(window)
  end)

  window.wx:Show(true)
  
  common.forward_mouse_events(window)
  common.add_mouse_events(window)
  common.add_keyboard_events(window)
  common.add_event(window, 'on_resize', wx.wxEVT_SIZE)
  common.add_event(window, 'on_move', wx.wxEVT_MOVE)
  
  setmetatable(window, metatable)
  window.cursor = "arrow"
  
  -- If the first control you create on a window is a text box and you change the selection
  -- of the text box before calling gui.run(), the selection will not stick. (The text box
  -- will select all of the text instead.) Giving focus to another control first will prevent
  -- this problem.
  local dummy = window:add_text_box()
  dummy:focus()
  dummy:destroy()
  
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