local unit_test = require 'test.unit_test'

unit_test.gather()

require 'test.window'

unit_test.run_all()