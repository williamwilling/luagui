require 'wx'

gui = {}

function gui.create_window()
  wx.wxFrame(
    wx.NULL,
    wx.wxID_ANY,
    '',
    wx.wxDefaultPosition,
    wx.wxSize(640, 480),
    wx.wxDEFAULT_FRAME_STYLE):Show(true)
end

function gui.run()
  wx.wxGetApp():MainLoop()
end