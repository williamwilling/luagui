local common = require 'gui.common'

local Mouse = {}
local metatable = common.create_metatable(Mouse)

function metatable.get_screen_x()
  return wx.wxGetMousePosition():GetX()
end

function metatable.get_screen_y()
  return wx.wxGetMousePosition():GetY()
end

function metatable.get_button_down()
  local buttons = {}
  local state = wx.wxGetMouseState()
  
  buttons.left = state:LeftDown()
  buttons.right = state:RightDown()
  buttons.middle = state:MiddleDown()
  buttons.any = buttons.left or buttons.right or buttons.middle
  buttons.all = buttons.left and buttons.right and buttons.middle
  
  return buttons
end

function metatable.get_button_up()
  local buttons = {}
  local state = wx.wxGetMouseState()
  
  buttons.left = not state:LeftDown()
  buttons.right = not state:RightDown()
  buttons.middle = not state:MiddleDown()
  buttons.any = buttons.left or buttons.right or buttons.middle
  buttons.all = buttons.left and buttons.right and buttons.middle
  
  return buttons
end

local mouse = {}
setmetatable(mouse, metatable)

return mouse