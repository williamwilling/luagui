local check = {}

local articles = { a = 'an', e = 'an', i = 'an', o = 'an' }
local article_exceptions = {}

local function add_article(word)
  local first_letter = string.sub(word, 1, 1)
  local article = article_exceptions[word] or articles[first_letter] or 'a'
  return article .. ' ' .. word
end

local function describe_type(type_name)
  if type_name == 'nil' then
    return 'a nil value'
  else
    return add_article(type_name)
  end
end

local function contains(table, value)
  for _,v in ipairs(table) do
    if v == value then
      return true
    end
  end

  return false
end

function check.parameter_type(expected, value, object_description, property_name)
  if type(expected) == 'string' then
    expected = { expected }
  end
  
  if not contains(expected, type(value)) then
    local message = string.format('The %s of %s must be %s, not %s.',
      property_name,
      add_article(object_description),
      describe_type(expected[1]),
      describe_type(type(value)))
    
    error(message, 4)
  end
end

return check