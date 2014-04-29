local common = require 'gui.common'
local MenuItem = require 'gui.menu_item'

local Menu = {}
local metatable = common.create_metatable(Menu)

metatable.get_text = function(object)
  local text = object.wx:GetTitle()
  return wx.wxMenuItem.GetLabelText(text)
end

function Menu.create(name)
  local menu = {}
  menu.wx = wx.wxMenu()
  
  setmetatable(menu, metatable)
  return menu
end

function Menu:add_item(text)
  local item = MenuItem.create(self, text)
  self.wx:Append(item.wx)
  return item
end

return Menu