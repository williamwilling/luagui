local common = require 'gui.common'

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

return Menu