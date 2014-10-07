local common = require 'gui.common'

local Image = {}
local metatable = common.create_metatable(Image)
common.add_position(metatable, 'image')
common.add_size(metatable, 'image')
common.add_anchor(metatable, 'image')

metatable.set_file = function(object, value)
  object.image = wx.wxImage(value)
  object.wx:SetSize(object.image:GetWidth(), object.image:GetHeight())
  
  return value
end

function Image.create(parent)
  local image = {
    parent = parent
  }
  
  image.wx = wx.wxPanel(
    parent.wx_panel or parent.wx,
    wx.wxID_ANY,
    wx.wxDefaultPosition,
    wx.wxDefaultSize)
  
  parent.wx:Connect(wx.wxEVT_SIZE, function(event)
    metatable.update_anchor(image)
    image.wx:Refresh()
    event:Skip()
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

  common.add_event(image, 'on_mouse_up', wx.wxEVT_LEFT_UP, 'left')
  common.add_event(image, 'on_mouse_up', wx.wxEVT_RIGHT_UP, 'right')
  common.add_event(image, 'on_mouse_up', wx.wxEVT_MIDDLE_UP, 'middle')
  common.add_event(image, 'on_mouse_down', wx.wxEVT_LEFT_DOWN, 'left')
  common.add_event(image, 'on_mouse_down', wx.wxEVT_RIGHT_DOWN, 'right')
  common.add_event(image, 'on_mouse_down', wx.wxEVT_MIDDLE_DOWN, 'middle')
  
  setmetatable(image, metatable)
  image.anchor = 'top left'
  
  return image
end

return Image