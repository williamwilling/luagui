local unit_test = require 'test.unit_test'
local assert = unit_test.assert
local test = unit_test.add_test

require 'gui'

test('a window has a size', function()
  local window = gui.create_window()
  window.width = 500
  window.height = 200
  
  assert.equal(500, window.width)
  assert.equal(200, window.height)
end)

test('a window has a position', function()
  local window = gui.create_window()
  window.x = 20
  window.y = 120
  
  assert.equal(20, window.x)
  assert.equal(120, window.y)
end)

test('a window has a title', function()
  local window = gui.create_window()
  window.title = 'my fine gui window'
  
  assert.equal(window.title, 'my fine gui window')
end)

unit_test.run()