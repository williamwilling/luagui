local unit_test = require 'test.unit_test'
local assert = unit_test.assert

require 'gui'

local suite = {
  ['a menu has text'] = function()
    local window = gui.create_window()
    local menu = window.menu_bar:add_menu('File')
    
    assert.are_equal('File', menu.text)
  end,
  
  ["a menu's text does not include the ampersand"] = function()
    local window = gui.create_window()
    local menu = window.menu_bar:add_menu('&File')
    
    assert.are_equal('File', menu.text)
  end
}

unit_test.run(suite)