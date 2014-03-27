local common = require 'gui.common'

local Menu = {}
local metatable = common.create_metatable(Menu)

metatable.get_text = function(object)
  return object.wx:GetTitle()
end

function Menu.create(name)
  local menu = {}
  menu.wx = wx.wxMenu()
  
  setmetatable(menu, metatable)
  return menu
end

return Menu