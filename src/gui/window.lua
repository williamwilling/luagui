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
  
  -- Since event propagation for mouse events doesn't work properly in wxLua, the window has
  -- to take care of raising mouse events on interested controls.
  local function send_mouse_event(wx_event, handler_name, param)
    return function(event)
      for _, mouse_listener in ipairs(common.mouse_listeners) do
        if mouse_listener[handler_name] ~= nil then
          local x, y = mouse_listener.wx:ScreenToClient(wx.wxGetMousePosition()):GetXY()
          local width = mouse_listener.wx:GetSize():GetWidth()
          local height = mouse_listener.wx:GetSize():GetHeight()
          
          if x >= 0 and y >= 0 and x < width and y < height then
            if param == nil then
              mouse_listener[handler_name](mouse_listener, x, y)
            else
              mouse_listener[handler_name](mouse_listener, param, x, y)
            end
          end
        end
      end
    end
  end
  
  window.wx_panel:Connect(wx.wxEVT_LEFT_UP, send_mouse_event(wx.wxEVT_LEFT_DOWN, 'on_mouse_up', 'left'))
  window.wx_panel:Connect(wx.wxEVT_LEFT_DOWN, send_mouse_event(wx.wxEVT_LEFT_DOWN, 'on_mouse_down', 'left'))
  window.wx_panel:Connect(wx.wxEVT_MIDDLE_UP, send_mouse_event(wx.wxEVT_MIDDLE_DOWN, 'on_mouse_up', 'middle'))
  window.wx_panel:Connect(wx.wxEVT_MIDDLE_DOWN, send_mouse_event(wx.wxEVT_MIDDLE_DOWN, 'on_mouse_down', 'middle'))
  window.wx_panel:Connect(wx.wxEVT_RIGHT_UP, send_mouse_event(wx.wxEVT_RIGHT_DOWN, 'on_mouse_up', 'right'))
  window.wx_panel:Connect(wx.wxEVT_RIGHT_DOWN, send_mouse_event(wx.wxEVT_RIGHT_DOWN, 'on_mouse_down', 'right'))
  
  -- Tell the global mouse object its coordinates relative to this window. Otherwise, the mouse
  -- object can only know the screen coordinates.
  window.wx_panel:Connect(wx.wxEVT_MOTION, function(event)
    gui.mouse.x, gui.mouse.y = window.wx:ScreenToClient(wx.wxGetMousePosition()):GetXY()
    send_mouse_event(wx.wxEVT_MOTION, 'on_mouse_move')(event)
  end)

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