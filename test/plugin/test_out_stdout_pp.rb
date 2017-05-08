require_relative '../helper'
require 'fluent/plugin/out_stdout_pp'

class StdoutOutputPPTest < Test::Unit::TestCase
  def setup
    Fluent::Test.setup
  end

  CONFIG = %[
  ]

  def create_driver(conf = CONFIG)
    Fluent::Test::Driver::Output.new(Fluent::Plugin::StdoutPPOutput).configure(conf)
  end

  def test_configure
    d = create_driver
    assert_equal Symbol, d.instance.time_color.class
    assert_equal Symbol, d.instance.tag_color.class
  end

  def test_process
    d = create_driver
    time = event_time
    localtime = time2str(time, localtime: true, format: '%Y-%m-%d %H:%M:%S %z')
    d.run(default_tag: 'test') do
      d.feed(time, {'test' => 'test'})
    end
    assert_equal "\e[1;34m#{localtime}\e[0;39m \e[1;33mtest\e[0;39m: {\n  \e[35m\e[1;35m\"\e[0m\e[35mtest\e[1;35m\"\e[0m\e[35m\e[0m: \e[31m\e[1;31m\"\e[0m\e[31mtest\e[1;31m\"\e[0m\e[31m\e[0m\n}\n", d.logs.first
  end

  def test_process_no_color
    d = create_driver(CONFIG + "record_colored false\n")
    time = event_time
    localtime = time2str(time, localtime: true, format: '%Y-%m-%d %H:%M:%S %z')
    record = {'test' => 'test'}
    d.run(default_tag: 'test') do
      d.feed(time, record)
    end
    assert_equal "\e[1;34m#{localtime}\e[0;39m \e[1;33mtest\e[0;39m: #{JSON.pretty_generate(record)}\n", d.logs.first
  end

  def test_process_without_pp
    d = create_driver(CONFIG + "pp false\n")
    time = event_time
    localtime = time2str(time, localtime: true, format: '%Y-%m-%d %H:%M:%S %z')
    record = {'test' => 'test'}
    d.run(default_tag: 'test') do
      d.feed(time, record)
    end

    assert_equal "\e[1;34m#{localtime}\e[0;39m \e[1;33mtest\e[0;39m: {\e[35m\e[1;35m\"\e[0m\e[35mtest\e[1;35m\"\e[0m\e[35m\e[0m:\e[31m\e[1;31m\"\e[0m\e[31mtest\e[1;31m\"\e[0m\e[31m\e[0m}\n", d.logs.first
  end
end

