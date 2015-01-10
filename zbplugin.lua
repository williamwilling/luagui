return {
  name = "Lua GUI",
  description = "An easy-to-use library for creating GUIs with Lua.",
  author = "William Willing",
  version = 3,
  
  install = function()
    local remotePath = "http://zerobranestore.blob.core.windows.net/luagui/"
    
    download(remotePath .. "LICENSE", idePath .. "lualibs/gui/LICENSE")
    download(remotePath .. "plugin.lua", idePath.. "packages/luagui.lua")
    download(remotePath .. "gui.lua", idePath.. "lualibs/gui.lua")
    download(remotePath .. "button.lua", idePath.. "lualibs/gui/button.lua")
    download(remotePath .. "check.lua", idePath.. "lualibs/gui/check.lua")
    download(remotePath .. "common.lua", idePath.. "lualibs/gui/common.lua")
    download(remotePath .. "dialog.lua", idePath.. "lualibs/gui/dialog.lua")
    download(remotePath .. "file_dialog.lua", idePath.. "lualibs/gui/file_dialog.lua")
    download(remotePath .. "image.lua", idePath.. "lualibs/gui/image.lua")
    download(remotePath .. "keyboard.lua", idePath.. "lualibs/gui/keyboard.lua")
    download(remotePath .. "label.lua", idePath.. "lualibs/gui/label.lua")
    download(remotePath .. "menu.lua", idePath.. "lualibs/gui/menu.lua")
    download(remotePath .. "menu_bar.lua", idePath.. "lualibs/gui/menu_bar.lua")
    download(remotePath .. "menu_item.lua", idePath.. "lualibs/gui/menu_item.lua")
    download(remotePath .. "mouse.lua", idePath.. "lualibs/gui/mouse.lua")
    download(remotePath .. "text_box.lua", idePath.. "lualibs/gui/text_box.lua")
    download(remotePath .. "timer.lua", idePath.. "lualibs/gui/timer.lua")
    download(remotePath .. "window.lua", idePath.. "lualibs/gui/window.lua")
    download(remotePath .. "common.anchor.lua", idePath.. "lualibs/gui/common/anchor.lua")
    download(remotePath .. "common.client_size.lua", idePath.. "lualibs/gui/common/client_size.lua")
    download(remotePath .. "common.color.lua", idePath.. "lualibs/gui/common/color.lua")
    download(remotePath .. "common.destroyable.lua", idePath .. "lualibs/gui/common/destroyable.lua")
    download(remotePath .. "common.label.lua", idePath.. "lualibs/gui/common/label.lua")
    download(remotePath .. "common.position.lua", idePath.. "lualibs/gui/common/position.lua")
    download(remotePath .. "common.resizable.lua", idePath.. "lualibs/gui/common/resizable.lua")
    download(remotePath .. "common.size.lua", idePath.. "lualibs/gui/common/size.lua")
    download(remotePath .. "common.text_color.lua", idePath.. "lualibs/gui/common/text_color.lua")
    download(remotePath .. "common.value.lua", idePath.. "lualibs/gui/common/value.lua")
  end
}