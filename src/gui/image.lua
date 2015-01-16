local common = require 'gui.common'

local Image = {}
common.is_destroyable(Image)

local metatable = common.create_metatable(Image)

metatable.set_x = function(object, value)
  object.parent.wx_panel:Refresh(false, wx.wxRect(object.x, object.y, object.width, object.height))
  object.parent.wx_panel:Refresh(false, wx.wxRect(value, object.y, object.width, object.height))
end

metatable.set_y = function(object, value)
  object.parent.wx_panel:Refresh(false, wx.wxRect(object.x, object.y, object.width, object.height))
  object.parent.wx_panel:Refresh(false, wx.wxRect(object.x, value, object.width, object.height))
end

metatable.set_file_name = function(object, value)
  object.image = wx.wxImage(value)
  object.width = object.image:GetWidth()
  object.height = object.image:GetHeight()
  
  return value
end

function Image.create(parent)
  local image = {
    parent = parent,
    wx_events = {}
  }
  
  setmetatable(image, metatable)
  image.anchor = 'top left'
  
  -- Set the initial values of the image, so we don't have to check for nil in
  -- the setters all the time. See common.create_metatable() to see how this
  -- table of values is used.
  metatable[image] = {
    x = 0,
    y = 0,
    width = 0,
    height = 0
  }
  
  assert(parent.images, "Parent must be a window or a dialog.")
  table.insert(parent.images, image)
  
  return image
end

return Image