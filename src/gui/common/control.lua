return function(control)
  control.destroy = function(self)
    self.wx:Destroy()
  end
end