local Window = {}

local metatable = {}

function metatable.__newindex(window, key, value)
  local self = getmetatable(window)
  
  if key == 'title' then
    self[window].title = self.set_title(window, value) or value
  else
    rawset(window, key, value)
  end
end

function metatable.__index(window, key)
  local self = getmetatable(window)
  
  if key == 'title' then
    return self[window].title
  end
  
  return rawget(window, key) or Window[key]
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
  metatable[window] = {}
  
  return window
end

return Window