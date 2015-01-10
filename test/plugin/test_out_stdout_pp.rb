require_relative '../helper'
require 'fluent/plugin/out_stdout_pp'

class StdoutOutputPPTest < Test::Unit::TestCase
  def setup
    Fluent::Test.setup
  end

  CONFIG = %[
  ]

  def create_driver(conf = CONFIG)
    Fluent::Test::OutputTestDriver.new(Fluent::StdoutPPOutput).configure(conf)
  end

  def test_configure
    d = create_driver
    assert_equal Symbol, d.instance.time_color.class
    assert_equal Symbol, d.instance.tag_color.class
  end

  def test_emit
    d = create_driver
    time = Time.now
    out = capture { d.emit({'test' => 'test'}, time) }
    assert_equal "\e[1;34m#{time.localtime}\e[0;39m \e[1;33mtest\e[0;39m: {\n  \e[35m\e[1;35m\"\e[0m\e[35mtest\e[1;35m\"\e[0m\e[35m\e[0m: \e[31m\e[1;31m\"\e[0m\e[31mtest\e[1;31m\"\e[0m\e[31m\e[0m\n}\n", out
  end

  def test_emit_no_color
    d = create_driver(CONFIG + "record_colored false\n")
    time = Time.now
    record = {'test' => 'test'}
    out = capture { d.emit(record, time) }
    assert_equal "\e[1;34m#{time.localtime}\e[0;39m \e[1;33mtest\e[0;39m: #{JSON.pretty_generate(record)}\n", out
  end

  def test_emit_without_pp
    d = create_driver(CONFIG + "pp false\n")
    time = Time.now
    record = {'test' => 'test'}
    out = capture { d.emit(record, time) }

    assert_equal "\e[1;34m#{time.localtime}\e[0;39m \e[1;33mtest\e[0;39m: {\e[35m\e[1;35m\"\e[0m\e[35mtest\e[1;35m\"\e[0m\e[35m\e[0m:\e[31m\e[1;31m\"\e[0m\e[31mtest\e[1;31m\"\e[0m\e[31m\e[0m}\n", out
  end
end

