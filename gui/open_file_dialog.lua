local common = require 'gui.common'

local OpenFileDialog = {}
local metatable = common.create_metatable(OpenFileDialog)

function OpenFileDialog.create(parent)
  local open_file_dialog = {
    parent = parent
  }
  
  local parent_wx = wx.NULL
  if parent ~= nil then
    parent_wx = parent.wx
  end
  
  open_file_dialog.wx = wx.wxFileDialog(parent_wx, '', '', '', '', wx.wxFD_OPEN)
  
  setmetatable(open_file_dialog, metatable)
  return open_file_dialog
end

function OpenFileDialog:show()
  return self.wx:ShowModal() == wx.wxID_OK
end

return OpenFileDialog