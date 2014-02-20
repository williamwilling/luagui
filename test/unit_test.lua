local unit_test = {
  tests = {},
  assert = {}
}

function unit_test.assert.equal(expected, actual)
  if expected ~= actual then
    local message = string.format('expected [%s] but got [%s].', expected, actual)
    table.insert(unit_test.results, message)
  end
end

function unit_test.add_test(name, test)
  local caller_info = debug.getinfo(2)
  
  table.insert(unit_test.tests, {
    name = name,
    run = test,
    line = caller_info.currentline,
    file = string.sub(caller_info.source, 2)
  })
end

function unit_test.run()
  for _, test in ipairs(unit_test.tests) do
    unit_test.results = {}
    test.run()
    
    for _, result in ipairs(unit_test.results) do
      io.write(string.format('%s:%i: %s\n', test.file, test.line, result))
    end
  end
end

return unit_test