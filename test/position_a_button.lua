require 'gui'

local window = gui.create_window()
local button = window:add_button()
button.x = 100
button.y = 50

local button2 = window:add_button()
button2.x = 500
button2.y = 10

gui.run()