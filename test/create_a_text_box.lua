require 'gui'

local window = gui.create_window()
local text_box = window:add_text_box()
text_box.x = 10
text_box.y = 10
text_box.width = 200
text_box.height = 50
text_box.text = 'Hello, world!'

gui.run()