require 'gui'

window = gui.create_window()
window.title = 'Untitled'

file_menu = window.menu_bar:add_menu('&File')
new_file = file_menu:add_item('&New')
open_file = file_menu:add_item('&Open')
save_file = file_menu:add_item('&Save')

text_box = window:add_text_box()

text_box.x = 0
text_box.y = 0
text_box.width = window.width
text_box.height = window.height
text_box.multiline = true
text_box.anchor = 'all'

function new_file:on_select()
  text_box.text = ''
end

function save_file:on_select()
  file_dialog = window:create_file_dialog()
  file_dialog.filters = {
    { 'Text files', '*.txt' },
    { 'All files', '*.*' }
  }
  
  if file_dialog:save() then
    file = io.open(file_dialog.file_name, 'w')
    file:write(text_box.text)
    file:close()
    
    window.title = file_dialog.file_name
  end
end

function open_file:on_select()
  file_dialog = window:create_file_dialog()
  file_dialog.filters = {
    { 'Text files', '*.txt' },
    { 'All files', '*.*' }
  }
  
  if file_dialog:open() then
    file = io.open(file_dialog.file_name, 'r')
    text_box.text = file:read('*a')
    file:close()
    
    window.title = file_dialog.file_name
  end
end

function text_box:on_text_changed()
  if string.sub(window.title, -1) ~= '*' then
    window.title = window.title .. '*'
  end
end

gui.run()