local common = require 'gui.common'

local MenuItem = {}
local metatable = common.create_metatable(MenuItem)

metatable.get_text = function(object)
  return object.wx:GetItemLabelText()
end

function MenuItem.create(parent, text)
  local menu_item = {
    parent = parent
  }

  menu_item.wx = wx.wxMenuItem(parent.wx, wx.wxID_ANY, text)

  setmetatable(menu_item, metatable)
  return menu_item
end

function MenuItem:select()
  local event = wx.wxCommandEvent(wx.wxEVT_COMMAND_MENU_SELECTED, self.wx:GetId())
  self.parent.wx:ProcessEvent(event)
end

return MenuItem