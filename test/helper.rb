require 'test/unit'

$LOAD_PATH.unshift(File.join(__dir__, '..', 'lib'))
$LOAD_PATH.unshift(__dir__)
require 'fluent/test'

def capture(&block)
  old = $log
  $log = StringIO.new
  yield
  return $log.string
ensure
  $log = old
end

# def capture
#   old = $stdout
#   $stdout = StringIO.new('','w')
#   yield
#   $stdout.string
# ensure
#   $stdout = old
# end
