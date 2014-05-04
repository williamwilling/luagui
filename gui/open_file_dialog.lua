local common = require 'gui.common'

local OpenFileDialog = {}
local metatable = common.create_metatable(OpenFileDialog)

local function create_wildcard_string(wildcards)
  if wildcards == nil then
    return ''
  end

  if type(wildcards) ~= 'table' then
    error('The wildcards-property is not in the correct format.', 3)
  end
  
  local result = ''

  for _, wildcard in ipairs(wildcards) do
    if type(wildcard) ~= 'table' or #wildcard < 2 then
      error('The wildcards-property is not in the correct format.', 3)
    end
    
    local description = wildcard[1]
    local pattern = ''
    
    for i = 2, #wildcard do
      if #pattern > 0 then
        pattern = pattern .. ';'
      end
      
      pattern = pattern .. wildcard[i]
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
    multiselect = false
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
  
  local wildcard = create_wildcard_string(self.wildcards)
  
  local wx_dialog = wx.wxFileDialog(parent_wx, '', '', '', wildcard, style)
  
  local result = wx_dialog:ShowModal() == wx.wxID_OK
  self.file_name = wx_dialog:GetPath()
  self.file_names = wx_dialog:GetPaths()
  
  return result
end

return OpenFileDialog