require 'gui'

window = gui.create_window()

file_menu = window.menu_bar:add_menu('&File')

text_box = window:add_text_box()

text_box.x = 0
text_box.y = 0
text_box.width = window.width
text_box.height = window.height
text_box.multiline = true
text_box.anchor = 'all'

gui.run()