local common = require 'gui.common'

local OpenFileDialog = {}
local metatable = common.create_metatable(OpenFileDialog)

function metatable.set_filters(object, value)
  if (type(value) ~= 'table' and value ~= nil) then
    error('The filters are not specified in the correct format.', 3)
  end
  
  for _, filter in ipairs(value) do
    if type(filter) ~= 'table' or #filter < 2 then
      error('The filters are not specified in the correct format.', 3)
    end
  end
  
  return value
end

local function create_filter_string(filters)
  if filters == nil then
    return ''
  end
    
  local result = ''

  for _, filter in ipairs(filters) do
    local description = filter[1]
    local pattern = ''
    
    for i = 2, #filter do
      if #pattern > 0 then
        pattern = pattern .. ';'
      end
      
      pattern = pattern .. filter[i]
    end
    
    if #result > 0 then
      result = result .. '|'
    end
    
    result = result .. description .. '|' .. pattern 
  end
  
  return result
end

function OpenFileDialog.create(parent)
  local open_file_dialog = {
    parent = parent,
    multiselect = false,
    title = '',
    default_folder = '',
    default_file = ''
  }
  
  setmetatable(open_file_dialog, metatable)
  return open_file_dialog
end

function OpenFileDialog:show()
  local style = wx.wxFD_OPEN
  if self.multiselect then
    style = style + wx.wxFD_MULTIPLE
  end
  
  local parent_wx = wx.NULL
  if parent ~= nil then
    parent_wx = parent.wx
  end
  
  local filter = create_filter_string(self.filters)
  
  local wx_dialog = wx.wxFileDialog(parent_wx, self.title, self.default_folder, self.default_file, filter, style)
  
  local result = wx_dialog:ShowModal() == wx.wxID_OK
  self.file_name = wx_dialog:GetPath()
  self.file_names = wx_dialog:GetPaths()
  
  return result
end

return OpenFileDialog