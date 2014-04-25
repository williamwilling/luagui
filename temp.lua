require 'gui'

local window = gui.create_window()
local menu = window.menu_bar:add_menu('File')
local menu_item = menu:add_item('New')


--[[
window.menu_bar = wx.wxMenuBar()

local file_menu = wx.wxMenu()
file_menu:Append(wx.wxID_EXIT, '&Quit')
window.menu_bar:Append(file_menu, '&File')
window.wx:SetMenuBar(window.menu_bar)
--]]
gui.run()