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

-- This function is publicly available, because when you create a timer, the
-- the timer overrides the idle event handler and needs to call this function.
function gui.collect_garbage()
  for _, control in ipairs(gui.garbage) do
    control:Destroy()
  end
  
  gui.garbage = {}
end

wx.wxGetApp():Connect(wx.wxEVT_IDLE, gui.collect_garbage)

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