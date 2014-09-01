local unit_test = {
  tests = {},
  assert = {},
  deferred = false,
  suites = {}
}

local current_test_name
local failed_test_count = 0

local function format_value(value)
  if type(value) == 'string' then
    return string.format("'%s'", value)
  else
    return tostring(value)
  end
end

local function report_assertion_failure(message)
  failed_test_count = failed_test_count + 1
  
  local caller_info = debug.getinfo(3)
  local file_name  = string.sub(caller_info.source, 2)
  local line_number = caller_info.currentline
  
  io.write(string.format(
      '%s:%i: [%s] %s\n',
      file_name,
      line_number,
      current_test_name,
      message))
end

local function report_result()
  if failed_test_count == 0 then
    io.write('All tests passed.\n')
  elseif failed_test_count == 1 then
    io.write('1 test failed.\n')
  else
    io.write(string.format('%i tests failed.\n', failed_test_count))
  end
  
  io.write('\n')
end

local function add_test_suite(suite)
  table.insert(unit_test.suites, suite)
end

function unit_test.assert.are_equal(expected, actual)
  if expected ~= actual then
    local message = string.format('expected %s but got %s.', format_value(expected), format_value(actual))
    report_assertion_failure(message)
  end
end

function unit_test.assert.is_true(expression)
  if not expression then
    report_assertion_failure('expected expression to be true, but was false.')
  end
end

function unit_test.assert.was_called(func)
  local name, value = debug.getupvalue(func, 1)
  
  if name ~= 'counter' or type(value) ~= 'number' then
    report_assertion_failure('function was not wrapped by unit_test.call_counter.')
  elseif value == 0 then
    report_assertion_failure("expected function to have been called, but it wasn't.")
  end
end

function unit_test.count_calls_to(func)
  local counter = 0
  local f = func or function() end
  
  return function(...)
    counter = counter + 1
    return f(...)
  end
end

function unit_test.gather()
  unit_test.run = add_test_suite
end

function unit_test.run(suite)
  add_test_suite(suite)
  unit_test.run_all()
end    
  
function unit_test.run_all()
  io.write('\nRunning unit tests...\n')
  
  for _, suite in ipairs(unit_test.suites) do
    local set_up = suite.set_up or function() end
    local tear_down = suite.tear_down or function() end
    
    for test_name, run_test in pairs(suite) do
      if test_name ~= 'set_up' and test_name ~= 'tear_down' then
        current_test_name = test_name
        
        set_up()
        run_test()
        tear_down()        
      end
    end
  end
  
  report_result()
end

return unit_test