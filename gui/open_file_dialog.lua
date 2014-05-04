local common = require 'gui.common'

local OpenFileDialog = {}
local metatable = common.create_metatable(OpenFileDialog)

function OpenFileDialog.create(parent)
  local open_file_dialog = {
    parent = parent
  }
  
  setmetatable(open_file_dialog, metatable)
  return open_file_dialog
end

function OpenFileDialog:show()
  local style = wx.wxFD_OPEN
  if self.multi_select then
    style = style + wx.wxFD_MULTIPLE
  end
  
  local parent_wx = wx.NULL
  if parent ~= nil then
    parent_wx = parent.wx
  end
  
  local wx_dialog = wx.wxFileDialog(parent_wx, '', '', '', '', style)
  
  local result = wx_dialog:ShowModal() == wx.wxID_OK
  self.fileName = wx_dialog:GetPath()
  self.fileNames = wx_dialog:GetPaths()
  
  return result
end

return OpenFileDialog