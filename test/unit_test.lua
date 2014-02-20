local unit_test = {
  tests = {},
  assert = {},
  deferred = false,
  suites = {}
}

local function format_value(value)
  if type(value) == 'string' then
    return string.format("'%s'", value)
  else
    return tostring(value)
  end
end

local function create_test_environment(t)
  local environment = {}
  
  for k,v in pairs(_G) do
    if type(v) == 'function' or type(v) == 'table' then
      environment[k] = v
    end
  end
  
  for k,v in pairs(unit_test) do
    if type(v) == 'function' or type(v) == 'table' then
      environment[k] = v
    end
  end
  
  for k,v in pairs(t or {}) do
    environment[k] = v
  end
  
  return environment
end

function unit_test.assert.equal(expected, actual)
  if expected ~= actual then
    local caller_info = debug.getinfo(2)
    
    local result = {}
    result.message = string.format('expected %s but got %s.', format_value(expected), format_value(actual))
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

function unit_test.set_up(func)
  unit_test.set_up_func = func
end

function unit_test.run(suite)
  table.insert(unit_test.suites, suite)
    
  if unit_test.deferred then
    return
  end
  
  io.write('\nRunning unit tests...\n')
  
  local failed_test_count = 0
  
  for _, suite in ipairs(unit_test.suites) do
    for test_name, test in pairs(suite) do
      if test_name ~= 'set_up' and test_name ~= 'tear_down' then
        unit_test.results = {}
        
        if type(suite.set_up) == 'function' then
          suite.set_up()
        end
        
        test()
        
        if type(suite.tear_down) == 'function' then
          suite.set_up()
        end
        
        for _, result in ipairs(unit_test.results) do
          failed_test_count = failed_test_count + 1
          io.write(string.format('%s:%i: [%s] %s\n', result.file, result.line, test_name, result.message))
        end
      end
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