local common = require 'gui.common'

local DropDownList = {}
common.is_destroyable(DropDownList)
common.is_focusable(DropDownList)

local metatable = common.create_metatable(DropDownList)
common.add_position(metatable, 'drop down list')
common.add_size(metatable, 'drop down list')
common.add_anchor(metatable, 'drop down list')
common.add_value(metatable, 'drop down list')
common.add_color(metatable, 'drop down list')
common.add_text_color(metatable, 'drop down list')
common.add_selection(metatable, 'drop down list')
common.add_items(metatable, 'drop down list')

function DropDownList.create(parent)
  local drop_down_list = {
    parent = parent,
    wx_events = {}
  }
  
  drop_down_list.wx = wx.wxComboBox(
    parent.wx_panel or parent.wx,
    wx.wxID_ANY,
    '',
    wx.wxDefaultPosition,
    wx.wxDefaultSize
  )
  
  common.propagate_events(drop_down_list)
  common.add_mouse_events(drop_down_list)
  common.add_anchor_event(drop_down_list)
  
  setmetatable(drop_down_list, metatable)
  drop_down_list.anchor = 'top left'
  
  return drop_down_list
end

return DropDownList