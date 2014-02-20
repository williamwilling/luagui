local unit_test = {
  tests = {},
  assert = {}
}

function unit_test.assert.equal(expected, actual)
  if expected ~= actual then
    local caller_info = debug.getinfo(2)
    
    local result = {}
    result.message = string.format('expected [%s] but got [%s].', expected, actual)
    result.file = string.sub(caller_info.source, 2)
    result.line = caller_info.currentline
    
    table.insert(unit_test.results, result)
  end
end

function unit_test.add_test(name, test)
  table.insert(unit_test.tests, {
    name = name,
    run = test,
  })
end

function unit_test.run()
  io.write('\nRunning unit tests...\n')
  
  local failed_test_count = 0
  
  for _, test in ipairs(unit_test.tests) do
    unit_test.results = {}
    test.run()
    
    for _, result in ipairs(unit_test.results) do
      failed_test_count = failed_test_count + 1
      io.write(string.format('%s:%i: %s\n', result.file, result.line, result.message))
    end
  end
  
  if failed_test_count > 0 then
    io.write(string.format('%i tests failed.\n', failed_test_count))
  else
    io.write('All tests passed.\n')
  end
  
  io.write('\n')
end

return unit_test