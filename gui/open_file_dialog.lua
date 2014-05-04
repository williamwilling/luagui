local common = require 'gui.common'

local OpenFileDialog = {}
local metatable = common.create_metatable(OpenFileDialog)

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
  
  local wx_dialog = wx.wxFileDialog(parent_wx, '', '', '', '', style)
  
  local result = wx_dialog:ShowModal() == wx.wxID_OK
  self.file_name = wx_dialog:GetPath()
  self.file_names = wx_dialog:GetPaths()
  
  return result
end

return OpenFileDialog