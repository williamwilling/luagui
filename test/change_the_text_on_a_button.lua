require 'gui'

local window = gui.create_window()
local button = window:add_button()
button.text = 'Click me'

gui.run()