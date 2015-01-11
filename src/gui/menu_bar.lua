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

function MenuBar:add_menu(text)
  local menu = Menu.create(text, self)
  self.wx:Append(menu.wx, text)
  return menu
end

return MenuBar