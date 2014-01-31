local Window = {}

local metatable = {}

function metatable.__newindex(window, key, value)
  local self = getmetatable(window)
  
  if key == 'title' then
    self[window].title = self.set_title(window, value) or value
  elseif key == 'width' then
    self[window].width = self.set_width(window, value) or value
  elseif key == 'height' then
    self[window].height = self.set_height(window, value) or value
  else
    rawset(window, key, value)
  end
end

function metatable.__index(window, key)
  local self = getmetatable(window)
  
  if key == 'title' then
    return self[window].title
  elseif key == 'width' then
    return self[window].width
  elseif key == 'height' then
    return self[window].height
  end
  
  return rawget(window, key) or Window[key]
end

function metatable.set_title(window, value)
  window.wx_frame:SetLabel(value)
end

function metatable.set_width(window, value)
  local height = window.height or window.wx_frame:GetClientSize():GetHeight()
  window.wx_frame:SetClientSize(value, height)
end

function metatable.set_height(window, value)
  local width = window.width or window.wx_frame:GetClientSize():GetWidth()
  window.wx_frame:SetClientSize(width, value)
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
  
  window.width = 640
  window.height = 480
  
  return window
end

return Window