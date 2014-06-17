local common = require 'gui.common'
local Button = require 'gui.button'
local TextBox = require 'gui.text_box'

local Dialog = {}
local metatable = common.create_metatable(Dialog)
common.add_position(metatable, 'dialog box')
common.add_client_size(metatable, 'dialog box')
common.add_label(metatable, 'dialog box', 'title')
common.add_color(metatable, 'dialog box')

function Dialog.create(parent)
  local dialog = {}
  
  dialog.wx = wx.wxDialog(
    parent.wx,
    wx.wxID_ANY,
    '')
  
  dialog.wx_panel = wx.wxPanel(
    dialog.wx,
    wx.wxID_ANY,
    wx.wxDefaultPosition,
    wx.wxDefaultSize)
  
  setmetatable(dialog, metatable)
  return dialog
end

function Dialog:add_button()
  return Button.create(self)
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