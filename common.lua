local common = {}

function common.create_metatable(class)
  return {
    __newindex = function(object, key, value)
      local self = getmetatable(object)
      local setter = self['set_' .. key]
      
      if setter ~= nil then
        self[object][key] = setter(object, value) or value
      else
        rawset(object, key, value)
      end
    end,

    __index = function(object, key)
      local self = getmetatable(object)
      local setter = self['set_' .. key]
      
      if setter ~= nil then
        return self[object][key]
      end
      
      return rawget(object, key) or class[key]
    end
  }
end

return common