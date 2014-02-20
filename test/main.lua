local unit_test = require 'test.unit_test'
unit_test.deferred = true

require 'test.window'

unit_test.deferred = false
unit_test.run()