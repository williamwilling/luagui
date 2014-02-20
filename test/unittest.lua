require 'gui'

unittest = {
  tests = {}
}

function assert_equal(expected, actual)
  if expected ~= actual then
    local message = string.format('expected [%s] but got [%s].', expected, actual)
    table.insert(unittest.results, message)
  end
end

function test(name, test)
  local caller_info = debug.getinfo(2)
  
  table.insert(unittest.tests, {
    name = name,
    test = test,
    line = caller_info.currentline,
    file = string.sub(caller_info.source, 2)
  })
end

test('window has a size', function()
  local window = gui.create_window()
  window.width = 100
  window.height = 200
  
  assert_equal(100, window.width)
  assert_equal(200, window.height)
end)

for _, test in ipairs(unittest.tests) do
  unittest.results = {}
  test.test()
  
  for _, result in ipairs(unittest.results) do
    io.write(string.format('%s:%i: %s\n', test.file, test.line, result))
  end
end