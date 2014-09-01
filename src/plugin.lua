local api = {
  gui = {
    type = 'lib',
    description = 'Allows you to create a graphical user interface in Lua.',
    
    childs = {
      create_window = {
        type = 'function',
        description = 'Creates a new window.',
        args = '()',
        returns = '(window)',
        valuetype = 'window'
      }
    }
  },
  
  button = {
    type = 'class',
    description = 'A button.',
    
    childs = {
      click = {
        type = 'method',
        description = 'Simulates a click on the button.',
        args = '()',
        returns = '()'
      },
      
      on_click = {
        type = 'method',
        description = 'The event handler that is called when the user clicks on the button.',
        args = '()',
        returns = '()'
      },
      
      anchor = {
        type = 'value',
        description = "The sides of the button's parent to which the button is anchored. When the button is anchored to a side, the distance between the button and the parent's side don't change when you resize the parent. Valid values are 'left', 'right', 'top', 'bottom', or combinations thereof separated by a space. 'all' is a shortcut for 'top left bottom right'."
      },
      
      background_color = {
        type = 'value',
        description = 'The background color of the button. You can specify the color as a list of numbers in the order red, green, blue, or as a table with the fields red, green and blue. So, the color orange would be either { 1.0, 0.4, 0 } or { red = 1.0, green = 0.4, blue = 0 }. When you read the background color, it is always specified in the second format. This property is not supported under MacOS.'
      },
      
      height = {
        type = 'value',
        description = 'The height of the button in pixels.'
      },
      
      text = {
        type = 'value',
        description = 'The text on the button.'
      },
      
      text_color = {
        type = 'value',
        description = 'The color of the text on the button. You can specify the color as a list of numbers in the order red, green, blue, or as a table with the fields red, green and blue. So, the color orange would be either { 1.0, 0.4, 0 } or { red = 1.0, green = 0.4, blue = 0 }. When you read the text color, it is always specified in the second format. This property is not supported under MacOS.'
      },
      
      width = {
        type = 'value',
        description = 'The width of the button in pixels.'      
      },
      
      x = {
        type = 'value',
        description = 'The x-position of the button in pixels.'
      },
      
      y = {
        type = 'value',
        description = 'The y-position of the button in pixels.'
      }
    }
  },
  
  dialog = {
    type = 'class',
    description = 'A dialog box.',
    
    childs = {
      add_button = {
          type = 'method',
          description = 'Creates a new button and adds it to the dialog box.',
          args = '()',
          returns = '(button)',
          valuetype = 'button'
        },
        
        add_label = {
          type = 'method',
          description = 'Creates new text label and adds it to the dialog box.',
          args = '()',
          returns = '(label)',
          valuetype = 'label'
        },
        
        add_text_box = {
          type = 'method',
          description = 'Creates a new text box and adds it to the dialog box.',
          args = '()',
          returns = '(text_box)',
          value_type = 'text_box'
        },
        
        close = {
          type = 'method',
          description = 'Closes the dialog box.'
        },
        
        background_color = {
          type = 'value',
          description = 'The background color of the dialog box. You can specify the color as a list of numbers in the order red, green, blue, or as a table with the fields red, green and blue. So, the color orange would be either { 1.0, 0.4, 0 } or { red = 1.0, green = 0.4, blue = 0 }. When you read the background color, it is always specified in the second format. This property is not supported under MacOS.'
        },
        
        height = {
          type = 'value',
          description = 'The height of the dialog box in pixels. The height does not include borders or the title bar.'
        },
        
        show_modal = {
          type = 'value',
          description = "Shows the dialog box. While the dialog box is visible, the user can't activate the parent window.",
          args = '()',
          returns = '()'
        },
        
        show_modeless = {
          type = 'value',
          description = 'Shows the dialog box. The user can still activate the parent window while the dialog box is visible.',
          args = '()',
          returns = '()'
        },
        
        title = {
          type = 'value',
          description = 'The text that is displayed in the title bar of the dialog box.'
        },
        
        width = {
          type = 'value',
          description = 'The width of the dialog box in pixels. The width does not include borders.'        
        },
        
        x = {
          type = 'value',
          description = 'The x-coordinate of the dialog box in pixels.'
        },
        
        y = {
          type = 'value',
          description = 'The y-coordinate of the dialog box in pixels.'
        }
    }
  },
  
  file_dialog = {
    type = 'class',
    description = 'A file dialog with which the user can select a file to open or save.',
    
    childs = {
      default_folder = {
        type = 'value',
        description = 'The path of the folder the user starts in when the file dialog opens.'
      },
      
      default_file = {
        type = 'value',
        description = 'The name of the file that is selected when the file dialog opens.'
      },
      
      file_name = {
        type = 'value',
        description = 'The name of the file the user has selected. The file name includes the full path of the file. If multiselect is true, you should use file_names instead of file_name.'
      },
      
      file_names = {
        type = 'value',
        description = 'A list of names of the files the user has selected. The file names include the full path of the file. If multiselect is false, you should use file_name instead of file_names.'
      },
      
      filters = {
        type = 'value',
        description = "A list of file filters that are available in the file dialog. Every filter in the list is of itself a list with two values: the description and the wildcard filter itself. For example: { { 'Text files', '*.txt' }, { 'All files', '*.*' } }"
      },
      
      multiselect = {
        type = 'value',
        description = 'true if the user can select multiple files in the file dialog, or false when the user can select only a single file.'
      },
      
      open = {
        type = 'method',
        description = 'Shows a dialog for opening a file. Returns true if the user has selected a file, or false when the user has cancelled the dialog.',
        args = '()',
        returns = '(bool)'
      },
      
      save = {
        type = 'method',
        description = 'Shows a dialog for saving a file. Returns true if the user has selected a file, or false when the user has cancelled the dialog.',
        args = '()',
        returns = '(bool)'
      },
      
      title = {
        type = 'value',
        description = 'The text that is displayed in the title bar of the file dialog.'
      }
    }
  },
  
  window = {
    type = 'class',
    description = 'A window with a title bar.',
    
    childs = {
      add_button = {
        type = 'method',
        description = 'Creates a new button and adds it to the window.',
        args = '()',
        returns = '(button)',
        valuetype = 'button'
      },
      
      add_label = {
        type = 'method',
        description = 'Creates new text label and adds it to the window.',
        args = '()',
        returns = '(label)',
        valuetype = 'label'
      },
      
      add_text_box = {
        type = 'method',
        description = 'Creates a new text box and adds it to the window.',
        args = '()',
        returns = '(text_box)',
        value_type = 'text_box'
      },
      
      close = {
        type = 'method',
        description = 'Closes the window. If there are no other open windows, the application will close.'
      },
      
      create_dialog = {
        type = 'method',
        description = "Creates a dialog box. A dialog box is a separate window with its own controls. Unlike a window, a dialog box doesn't show up in the task bar.",
        args = '()',
        returns = '(dialog)',
        value_type = 'dialog'
      },
      
      create_file_dialog = {
        type = 'method',
        description = 'Creates a file dialog that you can use to specify a file to open or save.',
        args = '()',
        returns = '(file_dialog)',
        value_type = 'file_dialog'
      },
      
      background_color = {
        type = 'value',
        description = 'The background color of the window. You can specify the color as a list of numbers in the order red, green, blue, or as a table with the fields red, green and blue. So, the color orange would be either { 1.0, 0.4, 0 } or { red = 1.0, green = 0.4, blue = 0 }. When you read the background color, it is always specified in the second format. This property is not supported under MacOS.'
      },
      
      height = {
        type = 'value',
        description = 'The height of the window in pixels. The height does not include borders, scroll bars, the title bar, the menu bar, or the status bar.'
      },
      
      title = {
        type = 'value',
        description = 'The text that is displayed in the title bar of the window.'
      },
      
      width = {
        type = 'value',
        description = 'The width of the window in pixels. The width does not include borders and scroll bars.'        
      },
      
      x = {
        type = 'value',
        description = 'The x-coordinate of the window in pixels.'
      },
      
      y = {
        type = 'value',
        description = 'The y-coordinate of the window in pixels.'
      }
    }
  }
}

return {
  name = "Lua GUI",
  description = "A GUI library for Lua that is simple to use.",
  author = "William Willing",
  version = 1,
  
  onRegister = function()
    ide:AddAPI("lua", "gui", api)
    table.insert(ide.interpreters.luadeb.api, "gui")
    ReloadLuaAPI()
  end,
  
  onUnRegister = function()
    ide:RemoveAPI("lua", "gui")

    for i, v in ipairs(ide.interpreters.luadeb.api) do
      if v == "gui" then
        table.remove(ide.interpreters.luadeb.api, i)
        break
      end
    end
  end
}