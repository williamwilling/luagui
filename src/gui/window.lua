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
  
  window.wx:Show(true)
  
  -- Since event propagation for mouse events doesn't work properly in wxLua, the window has
  -- to take care of raising mouse events on interested controls.
  window.wx_panel:Connect(wx.wxEVT_MOTION, function(event)
    for _, mouse_listener in ipairs(common.mouse_listeners) do
      if mouse_listener.on_mouse_move ~= nil then
        local x, y = mouse_listener.wx:ScreenToClient(wx.wxGetMousePosition()):GetXY()
        local width = mouse_listener.wx:GetSize():GetWidth()
        local height = mouse_listener.wx:GetSize():GetHeight()
        
        if x >= 0 and y >= 0 and x < width and y < height then
          mouse_listener:on_mouse_move(x, y)
        end
      end
    end
  end)

  common.add_mouse_events(window)
  
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