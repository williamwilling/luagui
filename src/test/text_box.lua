local unit_test = require 'test.unit_test'
local assert = unit_test.assert

require 'gui'

local window, text_box

local suite = {
  set_up = function()
    window = gui.create_window()
    text_box = window:add_text_box()
  end,
  
  ['a text box raises a text changed event'] = function()
    text_box.on_text_changed = unit_test.count_calls_to()
    text_box.text = 'hello'
    
    assert.was_called(text_box.on_text_changed)
  end,
  
  ['a text box can be anchored to all sides of a window'] = function()
    text_box.x = 0
    text_box.y = 0
    text_box.width = window.width
    text_box.height = window.height
    text_box.anchor = 'all'
    
    window.width = 400
    window.height = 345
    
    assert.are_equal(400, text_box.width)
    assert.are_equal(345, text_box.height)
  end,
  
  ['a text box can be anchored to the top left of a window'] = function()
    text_box.x = 39
    text_box.y = 46
    text_box.width = 100
    text_box.height = 25
    text_box.anchor = 'top left'
    
    window.x = 0
    window.y = 0
    window.width = 160
    window.height = 583
    
    assert.are_equal(39, text_box.x)
    assert.are_equal(46, text_box.y)
    assert.are_equal(100, text_box.width)
    assert.are_equal(25, text_box.height)
  end,
  
  ['a text box can be anchored to the bottom right of a window'] = function()
    window.width = 400
    window.height = 300
    text_box.x = 200
    text_box.width = 200
    text_box.y = 100
    text_box.height = 100
    text_box.anchor = 'bottom right'
    
    window.width = 200
    window.height = 450
    
    assert.are_equal(0, text_box.x)
    assert.are_equal(200, text_box.width)
    assert.are_equal(250, text_box.y)
    assert.are_equal(100, text_box.height)
  end,
  
  ['a text box can be unanchored from all sides of a window'] = function()
    window.width = 400
    window.height = 300
    text_box.x = 200
    text_box.width = 200
    text_box.y = 100
    text_box.height = 100
    text_box.anchor = 'none'
    
    window.width = 600
    window.height = 200
    
    assert.are_equal(300, text_box.x)
    assert.are_equal(200, text_box.width)
    assert.are_equal(50, text_box.y)
    assert.are_equal(100, text_box.height)
  end,
  
  ['enabling word wrap does not change any of the other properties'] = function()
    text_box.x = 20
    text_box.y = 30
    text_box.width = 40
    text_box.height = 50
    text_box.anchor = 'bottom right'
    text_box.multiline = true
    text_box.text = 'foo bar'
    text_box.word_wrap = true
    
    assert.are_equal(20, text_box.x)
    assert.are_equal(30, text_box.y)
    assert.are_equal(40, text_box.width)
    assert.are_equal(50, text_box.height)
    assert.are_equal('bottom right', text_box.anchor)
    assert.are_equal(true, text_box.multiline)
    assert.are_equal('foo bar', text_box.text)
  end
}

unit_test.run(suite)