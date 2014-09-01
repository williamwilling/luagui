local common = require 'gui.common'
local Menu = require 'gui.menu'

local MenuBar = {}
local metatable = common.create_metatable(MenuBar)

function MenuBar.create()
  local menuBar = {}
  menuBar.wx = wx.wxMenuBar()
  
  setmetatable(menuBar, metatable)
  return menuBar
end

function MenuBar:add_menu(name)
  local menu = Menu.create(name)
  self.wx:Append(menu.wx, name)
  return menu
end

return MenuBar