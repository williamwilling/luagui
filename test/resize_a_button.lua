require 'gui'

local window = gui.create_window()
local button = window:add_button()
button.width = 100
button.height = 100

gui.run()