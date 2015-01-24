local check = require 'gui.check'
local create_metatable = require 'gui.common.metatable'

local Selection = create_metatable(Selection)

function Selection.get_from(object)
  local from, to = object.control.wx:GetSelection()
  return from + 1
end

function Selection.get_to(object)
  local from, to = object.control.wx:GetSelection()
  return to
end

function Selection.get_text(object)
  local from, to = object.control.wx:GetSelection()
  return object.control.wx:GetRange(from, to)
end

return function(metatable, object_description)
  metatable.get_selection = function(object)
    local selection = { control = object }
    return setmetatable(selection, Selection)
  end
end