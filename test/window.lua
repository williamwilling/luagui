local unit_test = require 'test.unit_test'
local assert = unit_test.assert
local test = unit_test.add_test

require 'gui'

test('window has a size', function()
  local window = gui.create_window()
  window.width = 500
  window.height = 200
  
  assert.equal(500, window.width)
  assert.equal(200, window.height)
end)
