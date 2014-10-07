local common = require 'gui.common'

local Image = {}
local metatable = common.create_metatable(Image)
common.add_position(metatable, 'image')

metatable.set_file = function(object, value)
  local image = wx.wxImage(value)
  object.bitmap = wx.wxBitmap(image)
  
  object.wx:SetClientSize(image:GetWidth(), image:GetHeight())
  
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
  
  image.wx:Connect(wx.wxEVT_PAINT, function(event)
    local dc = wx.wxPaintDC(image.wx)
    
    if image.bitmap ~= nil then
      dc:DrawBitmap(image.bitmap, 0, 0, false)
    end
    
    dc:delete()
  end)
  
  setmetatable(image, metatable)
  
  return image
end

return Image