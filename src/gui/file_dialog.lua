local common = require 'gui.common'

local FileDialog = {}
local metatable = common.create_metatable(FileDialog)

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

function FileDialog.create(parent)
  local file_dialog = {
    parent = parent,
    multiselect = false,
    title = '',
    default_folder = '',
    default_file = ''
  }
  
  setmetatable(file_dialog, metatable)
  return file_dialog
end

local function show_dialog(dialog, style)
  if dialog.multiselect then
    style = style + wx.wxFD_MULTIPLE
  end
  
  local parent_wx = wx.NULL
  if parent ~= nil then
    parent_wx = parent.wx
  end
  
  local filter = create_filter_string(dialog.filters)
  
  local wx_dialog = wx.wxFileDialog(parent_wx, dialog.title, dialog.default_folder, dialog.default_file, filter, style)
  
  local result = wx_dialog:ShowModal() == wx.wxID_OK
  dialog.file_name = wx_dialog:GetPath()
  dialog.file_names = wx_dialog:GetPaths()
  
  return result
end

function FileDialog:open()
  return show_dialog(self, wx.wxFD_OPEN)
end

function FileDialog:save()
  return show_dialog(self, wx.wxFD_SAVE)
end

return FileDialog