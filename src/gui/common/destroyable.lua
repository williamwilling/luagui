return function(object)
  object.destroy = function(self)
    -- Unregister the control's event handlers.
    for _, unregister_event_handler in ipairs(self.wx_events) do
      unregister_event_handler()
    end
    
    -- Mark the control for destruction
    table.insert(gui.garbage, self.wx)
    
    -- Make sure that you can't inadvertently do anything with the destroyed
    -- control anymore.
    setmetatable(self, nil)
    
    for k in pairs(self) do
      self[k] = nil
    end
  end
end