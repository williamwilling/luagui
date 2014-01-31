local Window = {}

local metatable = {
  __index = Window
}

function metatable.__newindex(window, key, value)
  local self = getmetatable(window)
  
  if key == 'title' then
    self.set_title(window, value)
  end
end

function metatable.set_title(window, value)
  window.wx_frame:SetLabel(value)
end

function Window.create()
  local window = {}
  
  window.wx_frame = wx.wxFrame(
    wx.NULL,
    wx.wxID_ANY,
    '',
    wx.wxDefaultPosition,
    wx.wxSize(640, 480),
    wx.wxDEFAULT_FRAME_STYLE)
  
  window.wx_frame:Show(true)
  
  setmetatable(window, metatable);
  
  return window
end

return Window