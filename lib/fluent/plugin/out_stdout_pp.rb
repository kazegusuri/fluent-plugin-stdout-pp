require 'coderay'

module Fluent
  class StdoutPPOutput < Output
    Fluent::Plugin.register_output('stdout_pp', self)

    config_param :pp, :bool, default: true
    config_param :time_color, :string, default: 'blue'
    config_param :tag_color, :string, default: 'yellow'
    config_param :record_colored, :bool, default: true

    TTY_COLOR = {
      normal:  "\033[0;39m",
      red:     "\033[1;31m",
      green:   "\033[1;32m",
      yellow:  "\033[1;33m",
      blue:    "\033[1;34m",
      magenta: "\033[1;35m",
      cyan:    "\033[1;36m",
      white:   "\033[1;37m",
    }

    def configure(conf)
      super

      @time_color = @time_color.intern
      if TTY_COLOR[@time_color].nil?
        raise ConfigError, "stdout_pp: unknown color name #{@time_color} in time_color"
      end

      @tag_color = @tag_color.intern
      if TTY_COLOR[@tag_color].nil?
        raise ConfigError, "stdout_pp: unknown color name #{@tag_color} in tag_color"
      end
    end

    def emit(tag, es, chain)
      tag_colored = TTY_COLOR[@tag_color] + tag + TTY_COLOR[:normal]
      es.each do |time, record|
        time_colored = TTY_COLOR[@time_color] + Time.at(time).localtime.to_s + TTY_COLOR[:normal]
        if @pp
          json = JSON.pretty_generate(record)
        else
          json = Yajl.dump(record)
        end
        json = CodeRay.scan(json, :json).terminal if @record_colored
        $log.write "#{time_colored} #{tag_colored}: #{json}\n"
      end
      $log.flush
      chain.next
    end
  end
end
