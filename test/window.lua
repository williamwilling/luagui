local unit_test = require 'test.unit_test'
local assert = unit_test.assert

require 'gui'

local window

local suite = {
  set_up = function()
    window = gui.create_window()
  end,
  
  ['a window has a size'] = function()
    window.width = 500
    window.height = 200
    
    assert.are_equal(500, window.width)
    assert.are_equal(200, window.height)
  end,
  
  ['a window has a position'] = function()
    window.x = 20
    window.y = 120
    
    assert.are_equal(20, window.x)
    assert.are_equal(120, window.y)
  end,

  ['a window has a title'] = function()
    window.title = 'my fine gui window'
    
    assert.are_equal(window.title, 'my fine gui window')
  end
}

unit_test.run(suite)