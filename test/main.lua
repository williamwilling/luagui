local unit_test = require 'test.unit_test'

unit_test.gather()

require 'test.window'
require 'test.button'

unit_test.run_all()