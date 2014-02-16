require 'gui'

local window = gui.create_window()
local button = window:add_button()
button.y = window.height / 2
button.width = window.width / 2
button.anchor = 'bottom right'

gui.run()