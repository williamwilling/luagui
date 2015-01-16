local common = require 'gui.common'
local Button = require 'gui.button'
local Image = require 'gui.image'
local Label = require 'gui.label'
local TextBox = require 'gui.text_box'

local Dialog = {}
local metatable = common.create_metatable(Dialog)
common.add_position(metatable, 'dialog')
common.add_client_size(metatable, 'dialog')
common.add_label(metatable, 'dialog', 'title')
common.add_color(metatable, 'dialog')
common.add_resizable(metatable, 'dialog')

function Dialog.create(parent)
  local dialog = {
    parent = parent,
    resizable = true,
    images = {}
  }
  
  -- The delay prevents the dialog window from being created before the creation of its parent has
  -- finished. Without the delay, it sometimes happens that the dialog is shown immediately,
  -- without a call to show_modal() or show_modeless().
  wx.wxMilliSleep(50)
  
  dialog.wx = wx.wxDialog()
  dialog.wx:Create(
    dialog.parent.wx,
    wx.wxID_ANY,
    '',
    wx.wxDefaultPosition,
    wx.wxDefaultSize,
    wx.wxDEFAULT_DIALOG_STYLE + wx.wxRESIZE_BORDER)
  
  dialog.wx_panel = wx.wxPanel(
    dialog.wx,
    wx.wxID_ANY,
    wx.wxDefaultPosition,
    wx.wxDefaultSize)
  
  common.forward_mouse_events(dialog)
  common.add_mouse_events(dialog)
  common.add_keyboard_events(dialog)
  common.add_event(dialog, 'on_resize', wx.wxEVT_SIZE)
  common.add_event(dialog, 'on_move', wx.wxEVT_MOVE)
  
  dialog.wx:Connect(wx.wxEVT_CLOSE_WINDOW, function(event)
    if type(dialog.on_closing) ~= 'function' or dialog:on_closing() ~= false or not event:CanVeto() then
      dialog.wx:Destroy()
    end
  end)

  dialog.wx_panel:Connect(wx.wxEVT_PAINT, function(event)
    common.paint_images(dialog)
  end)
  
  setmetatable(dialog, metatable)
  return dialog
end

function Dialog:add_button()
  return Button.create(self)
end

function Dialog:add_image()
  return Image.create(self)
end

function Dialog:add_label()
  return Label.create(self)
end

function Dialog:add_text_box()
  return TextBox.create(self)
end

function Dialog:show_modal()
  self.wx:ShowModal()
end

function Dialog:show_modeless()
  self.wx:Show()
end

function Dialog:close()
  self.wx:Close()
end

return Dialog