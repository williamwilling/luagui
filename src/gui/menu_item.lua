local common = require 'gui.common'
local check = require 'gui.check'

local MenuItem = {}
local metatable = common.create_metatable(MenuItem)

metatable.get_text = function(object)
  return object.wx:GetItemLabelText()
end

metatable.set_text = function(object, value)
  check.parameter_type('string', value, 'menu item', 'shortcut')
  
  local text = string.match(value, '(.*)\t')
  if object.shortcut ~= nil then
    text = text .. '\t' .. object.shortcut
  end
  
  object.wx:SetItemLabel(text)
  object.parent.parent.wx:SetAcceleratorTable(wx.wxNullAcceleratorTable)
end

metatable.get_checked = function(object)
  return object.wx:IsChecked()
end

metatable.set_checked = function(object, value)
  check.parameter_type('boolean', value, 'menu item', 'shortcut')
  return object.wx:Check(value)
end

metatable.set_shortcut = function(object, value)
  check.parameter_type({ 'string', 'nil' }, value, 'menu item', 'shortcut')
  
  local text = object.wx:GetItemLabelText()
  if value ~= nil then
    text = text ..'\t' .. value
  end
  
  object.wx:SetItemLabel(text)
  object.parent.parent.wx:SetAcceleratorTable(wx.wxNullAcceleratorTable)
end

function MenuItem.create(parent, text)
  local menu_item = {
    parent = parent
  }

  text = string.match(text, '(.*)\t')
  menu_item.wx = wx.wxMenuItem(parent.wx, wx.wxID_ANY, text, '', wx.wxITEM_CHECK)

  setmetatable(menu_item, metatable)
  return menu_item
end

function MenuItem:select()
  local event = wx.wxCommandEvent(wx.wxEVT_COMMAND_MENU_SELECTED, self.wx:GetId())
  self.parent.wx:ProcessEvent(event)
end

return MenuItem