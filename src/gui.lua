local print_backup = print

require 'wx'
local Window = require 'gui.window'
local FileDialog = require 'gui.file_dialog'
local Timer = require 'gui.timer'

gui = {
  mouse = require 'gui.mouse',
  keyboard = require 'gui.keyboard',
  garbage = {},
  version = 4
}

wx.wxGetApp():Connect(wx.wxEVT_IDLE, function()
  for _, control in ipairs(gui.garbage) do
    control:Destroy()
  end
  
  gui.garbage = {}
end)

function gui.create_window()
  return Window.create()
end

function gui.create_file_dialog()
  return FileDialog.create()
end

function gui.create_timer()
  return Timer.create()
end

function gui.run()
  wx.wxGetApp():MainLoop()
end

print = print_backup

function gui.reload()
  package.loaded.gui = nil
  
  for name,_ in pairs(package.loaded) do
    if string.match(name, 'gui%..+') then
      package.loaded[name] = nil
    end
  end
  
  return require 'gui'
end