require 'gui'

local window = gui.create_window()
local button = window:add_button()

function button:on_click()
  self.click_count = (self.click_count or 0) + 1
  button.text = self.click_count
end

gui.run()