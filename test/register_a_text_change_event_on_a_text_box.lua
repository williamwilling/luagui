require 'gui'

local window = gui.create_window()
local text_box = window:add_text_box()

function text_box:on_text_changed()
  window.title = self.text
end

gui.run()