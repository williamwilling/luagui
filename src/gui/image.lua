local common = require 'gui.common'

local Image = {}
common.is_destroyable(Image)

local metatable = common.create_metatable(Image)
common.add_position(metatable, 'image')
common.add_size(metatable, 'image')
common.add_anchor(metatable, 'image')

metatable.set_file_name = function(object, value)
  object.image = wx.wxImage(value)
  object.wx:SetSize(object.image:GetWidth(), object.image:GetHeight())
  object.wx:Refresh()
  
  return value
end

function Image.create(parent)
  local image = {
    parent = parent,
    wx_events = {}
  }
  
  image.wx = wx.wxPanel(
    parent.wx_panel or parent.wx,
    wx.wxID_ANY,
    wx.wxDefaultPosition,
    wx.wxDefaultSize)
  
  common.add_anchor_event(image, function()
      image.wx:Refresh()
  end)

  image.wx:Connect(wx.wxEVT_PAINT, function(event)
    if image.image ~= nil then
      local dc = wx.wxPaintDC(image.wx)
      
      local bitmap = wx.wxBitmap(image.image:Scale(image.width, image.height))  
      dc:DrawBitmap(bitmap, 0, 0, false)
      
      bitmap:delete()
      dc:delete()
    end
  end)

  common.propagate_events(image)
  common.add_mouse_events(image)
  
  setmetatable(image, metatable)
  image.anchor = 'top left'
  
  return image
end

return Image