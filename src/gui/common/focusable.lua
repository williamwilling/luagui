return function(object)
  object.focus = function(self)
    self.wx:SetFocus()
  end
end