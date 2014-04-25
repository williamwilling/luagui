local unit_test = require 'test.unit_test'
local assert = unit_test.assert

require 'gui'

local window

local suite = {
  set_up = function()
    window = gui.create_window()
  end,
  
  ['a menu has text'] = function()
    local menu = window.menu_bar:add_menu('File')
    
    assert.are_equal('File', menu.text)
  end,
  
  ["a menu's text does not include the ampersand"] = function()
    local menu = window.menu_bar:add_menu('&File')
    
    assert.are_equal('File', menu.text)
  end,
  
  ['a menu can have a menu item'] = function()
    local menu = window.menu_bar:add_menu('File')
    local menu_item = menu:add_item('New')
    
    assert.are_equal('New', menu_item.text)
  end
}

unit_test.run(suite)