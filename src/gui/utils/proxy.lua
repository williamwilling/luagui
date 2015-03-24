local proxy = {}
local read = {}
local write = {}
local private = {}

local metatable = {
  __index = function(table, key)
    table[read](table, key)
    return table[private][key]
  end,
  
  __newindex = function(table, key, value)
    table[write](table, key, value)
    table[private][key] = value
  end,
  
  __ipairs = function(table)
    return ipairs(table[private])
  end,
  
  __pairs = function(table)
    return pairs(table[private])
  end
}

local __ipairs = ipairs
function ipairs(t)
  local metatable = getmetatable(t)
  if metatable ~= nil and type(metatable.__ipairs) == 'function' then
    return metatable.__ipairs(t)
  end
  
  return __ipairs(t)
end

local __pairs = pairs
function pairs(t)
  local metatable = getmetatable(t)
  if metatable ~= nil and type(metatable.__pairs) == 'function' then
    return metatable.__pairs(t)
  end
  
  return __pairs(t)
end

local __insert = table.insert
function table.insert(table, value)
  if proxy.is_proxy(table) then
    local length = proxy.length(table)
    table[length + 1] = value
  else
    __insert(table, value)
  end
end


function proxy.monitor(table, on_write, on_read)
  local values = {}
  
  for key, value in pairs(table) do
    values[key] = value
    table[key] = nil
  end
  
  table[read] = on_read or function() end
  table[write] = on_write or function() end
  table[private] = values
  setmetatable(table, metatable)
end

function proxy.is_proxy(table)
  return getmetatable(table) == metatable
end

function proxy.length(table)
  return #table[private]
end

return proxy