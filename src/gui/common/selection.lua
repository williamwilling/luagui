local check = require 'gui.check'
local create_metatable = require 'gui.common.metatable'

local Selection = create_metatable(Selection)

function Selection.get_from(object)
  local from, to = object.control.wx:GetSelection()
  return from + 1
end

function Selection.get_to(object)
  local from, to = object.control.wx:GetSelection()
  
  if to <= from then
    return nil
  else
    return to
  end
end

function Selection.get_text(object)
  return object.control.wx:GetStringSelection()
end

function Selection.set_from(object, value)
  check.parameter_type('number', value, 'selection', 'start index')
  
  local from, to = object.control.wx:GetSelection()
  if from == to or value - 1 > to then
    object.control.wx:SetSelection(value - 1, value - 1)
  else
    object.control.wx:SetSelection(value - 1, to)
  end
end

function Selection.set_to(object, value)
  check.parameter_type({ 'number', 'nil' }, value, 'selection', 'end index')
  
  local from, to = object.control.wx:GetSelection()
  if value == nil then
    object.control.wx:SetSelection(from, from)
  elseif value < from then
    object.control.wx:SetSelection(value, value)
  else
    object.control.wx:SetSelection(from, value)
  end
end

function Selection.set_text(object, value)
  check.parameter_type('string', value, 'selection', 'text')
  
  local from, to = object.control.wx:GetSelection()
  if from < to then
    object.control.wx:Replace(from, to, value)
    _, to = object.control.wx:GetSelection()
    object.control.wx:SetSelection(from, to)
  end
end

return function(metatable, object_description)
  metatable.get_selection = function(object)
    local selection = { control = object }
    return setmetatable(selection, Selection)
  end
end