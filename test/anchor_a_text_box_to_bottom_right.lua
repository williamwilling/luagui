require 'gui'

local window = gui.create_window()
local text_box = window:add_text_box()
text_box.x = window.width / 2 - 5
text_box.width = window.width / 2
text_box.anchor = 'bottom right'

gui.run()