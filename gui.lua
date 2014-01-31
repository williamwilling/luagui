require 'wx'
local Window = require 'window'

gui = {}

function gui.create_window()
  return Window.create()
end

function gui.run()
  wx.wxGetApp():MainLoop()
end

function gui.reload()
  package.loaded.window = nil
  package.loaded.gui = nil
  
  return require 'gui'
end