local common = require 'gui.common'
local check = require 'gui.check'

local Image = {}
local metatable = common.create_metatable(Image)

metatable.set_x = function(object, value)
  object.parent.wx_panel:Refresh(true, wx.wxRect(object.x, object.y, object.width, object.height))
  object.parent.wx_panel:Refresh(true, wx.wxRect(value, object.y, object.width, object.height))
end

metatable.set_y = function(object, value)
  object.parent.wx_panel:Refresh(true, wx.wxRect(object.x, object.y, object.width, object.height))
  object.parent.wx_panel:Refresh(true, wx.wxRect(object.x, value, object.width, object.height))
end

metatable.set_width = function(object, value)
  object.parent.wx_panel:Refresh(true, wx.wxRect(object.x, object.y, object.width, object.height))
  object.parent.wx_panel:Refresh(true, wx.wxRect(object.x, object.y, value, object.height))
end

metatable.set_height = function(object, value)
  object.parent.wx_panel:Refresh(true, wx.wxRect(object.x, object.y, object.width, object.height))
  object.parent.wx_panel:Refresh(true, wx.wxRect(object.x, object.y, object.width, value))
end

metatable.set_file_name = function(object, value)
  check.parameter_type({ 'string', 'nil' }, value, 'image', 'file name')
  
  if value == nil then
    object.image = nil
  else
    object.image = wx.wxImage(value)
    object.width = object.image:GetWidth()
    object.height = object.image:GetHeight()
  end
  
  return value
end

common.add_anchor(metatable, 'image')

function Image.create(parent)
  local image = {
    parent = parent,
    wx_events = {}
  }
  
  common.add_mouse_events(image)
  
  setmetatable(image, metatable)
  
  -- Set the initial values of the image, so we don't have to check for nil in
  -- the setters all the time. See common.create_metatable() to see how this
  -- table of values is used.
  metatable[image] = {
    x = 0,
    y = 0,
    width = 0,
    height = 0
  }
  
  image.anchor = 'top left'
  common.add_anchor_event(image)
  
  assert(parent.images, "Parent must be a window or a dialog.")
  table.insert(parent.images, image)
  
  return image
end

function Image:destroy()
  for i, image in ipairs(self.parent.images) do
    if image == self then
      table.remove(self.parent.images, i)
      break
    end
  end
  
  self.parent.wx_panel:Refresh(false, wx.wxRect(self.x, self.y, self.width, self.height))
  setmetatable(self, nil)
end

return Image