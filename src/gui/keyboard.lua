local Keyboard = {}

Keyboard.key_up = {}
setmetatable(Keyboard.key_up, {
  __index = function(table, key)
    local key_code = Keyboard.key_codes[key]
    
    if key_code then
      return not wx.wxGetKeyState(key_code)
    end
  end
})

Keyboard.key_down = {}
setmetatable(Keyboard.key_down, {
  __index = function(table, key)
    local key_code = Keyboard.key_codes[key]
    
    if key_code then
      return wx.wxGetKeyState(key_code)
    end
  end
})

Keyboard.key_names = {
  [wx.WXK_BACK] = 'backspace',
  [wx.WXK_TAB] = 'tab',
  [wx.WXK_RETURN] = 'enter',
  [wx.WXK_ESCAPE] = 'escape',
  [wx.WXK_SPACE] = 'space',
  [wx.WXK_DELETE] = 'delete',
  [wx.WXK_SHIFT] = 'shift',
  [wx.WXK_ALT] = 'alt',
  [wx.WXK_CONTROL] = 'ctrl',
  [wx.WXK_MENU] = 'menu',
  [wx.WXK_START] = 'start',
  [wx.WXK_PAUSE] = 'pause',
  [wx.WXK_CAPITAL] = 'caps lock',
  [wx.WXK_END] = 'end',
  [wx.WXK_HOME] = 'home',
  [wx.WXK_LEFT] = 'left',
  [wx.WXK_RIGHT] = 'right',
  [wx.WXK_UP] = 'up',
  [wx.WXK_DOWN] = 'down',
  [321] = 'print screen',
  [wx.WXK_INSERT] = 'insert',
  [wx.WXK_NUMPAD0] = 'numpad 0',
  [wx.WXK_NUMPAD1] = 'numpad 1',
  [wx.WXK_NUMPAD2] = 'numpad 2',
  [wx.WXK_NUMPAD3] = 'numpad 3',
  [wx.WXK_NUMPAD4] = 'numpad 4',
  [wx.WXK_NUMPAD5] = 'numpad 5',
  [wx.WXK_NUMPAD6] = 'numpad 6',
  [wx.WXK_NUMPAD7] = 'numpad 7',
  [wx.WXK_NUMPAD8] = 'numpad 8',
  [wx.WXK_NUMPAD9] = 'numpad 9',
  [wx.WXK_NUMPAD_MULTIPLY] = 'numpad *',
  [wx.WXK_NUMPAD_ADD] = 'numpad +',
  [wx.WXK_NUMPAD_SUBTRACT] = 'numpad -',
  [wx.WXK_NUMPAD_DECIMAL] = 'numpad .',
  [wx.WXK_NUMPAD_DIVIDE] = 'numpad /',
  [wx.WXK_NUMPAD_HOME] = 'numpad 7',
  [wx.WXK_NUMPAD_LEFT] = 'numpad 4',
  [wx.WXK_NUMPAD_UP] = 'numpad 8',
  [wx.WXK_NUMPAD_RIGHT] = 'numpad 6',
  [wx.WXK_NUMPAD_DOWN] = 'numpad 2',
  [wx.WXK_NUMPAD_PAGEUP] = 'numpad 9',
  [wx.WXK_NUMPAD_PAGEDOWN] = 'numpad 3',
  [wx.WXK_NUMPAD_END] = 'numpad 1',
  [wx.WXK_NUMPAD_DELETE] = 'numpad .',
  [wx.WXK_NUMPAD_INSERT] = 'numpad 0',
  [wx.WXK_NUMPAD_ENTER] = 'numpad enter',
  [305] = 'numpad 5',
  [wx.WXK_F1] = 'f1',
  [wx.WXK_F2] = 'f2',
  [wx.WXK_F3] = 'f3',
  [wx.WXK_F4] = 'f4',
  [wx.WXK_F5] = 'f5',
  [wx.WXK_F6] = 'f6',
  [wx.WXK_F7] = 'f7',
  [wx.WXK_F8] = 'f8',
  [wx.WXK_F9] = 'f9',
  [wx.WXK_F10] = 'f10',
  [wx.WXK_F11] = 'f11',
  [wx.WXK_F12] = 'f12',
  [wx.WXK_NUMLOCK] = 'num lock',
  [wx.WXK_SCROLL] = 'scroll lock',
  [wx.WXK_PAGEUP] = 'page up',
  [wx.WXK_PAGEDOWN] = 'page down',
  [96] = '~',
  [49] = '1',
  [50] = '2',
  [51] = '3',
  [52] = '4',
  [53] = '5',
  [54] = '6',
  [55] = '7',
  [56] = '8',
  [57] = '9',
  [48] = '0',
  [45] = '-',
  [61] = '+',
  [65] = 'a',
  [66] = 'b',
  [67] = 'c',
  [68] = 'd',
  [69] = 'e',
  [70] = 'f',
  [71] = 'g',
  [72] = 'h',
  [73] = 'i',
  [74] = 'j',
  [75] = 'k',
  [76] = 'l',
  [77] = 'm',
  [78] = 'n',
  [79] = 'o',
  [80] = 'p',
  [81] = 'q',
  [82] = 'r',
  [83] = 's',
  [84] = 't',
  [85] = 'u',
  [86] = 'v',
  [87] = 'w',
  [88] = 'x',
  [89] = 'y',
  [90] = 'z',
  [91] = '[',
  [93] = ']',
  [92] = '\\',
  [59] = ';',
  [39] = '\'',
  [44] = ',',
  [46] = '.',
  [47] = '/'
}

Keyboard.key_codes = {}

for code, name in pairs(Keyboard.key_names) do
  Keyboard.key_codes[name] = code
end

return Keyboard