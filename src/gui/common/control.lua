return function(control)
  control.destroy = function(self)
    self.wx:Destroy()
    setmetatable(self, nil)
    
    for k in pairs(self) do
      self[k] = nil
    end
  end
end