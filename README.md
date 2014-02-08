# fluent-plugin-stdout-pp, a plugin for [Fluentd](http://fluentd.org)

A fluentd plugin to pretty print json with color to stdout

## Installation

Add this line to your application's Gemfile:

    gem 'fluent-plugin-stdout-pp'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fluent-plugin-stdout-pp

## Configuration

```
<match **>
  type stdout_pp
  time_color blue
  tag_color yellow
</match>
```

## Parameters

|parameter|description|default|
|---|---|---|
|pp| prety print json or not | true |
|time_color| color name to print time | blue |
|tag_color| color name to print tag | yellow |
|record_colored| print json with color or not | true |

Available colors:
- normal
- red
- green
- yellow
- magenta
- white

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Copyright

<table>
  <tr>
    <td>Author</td><td>Masahiro Sano <sabottenda@gmail.com></td>
  </tr>
  <tr>
    <td>Copyright</td><td>Copyright (c) 2013- Masahiro Sano</td>
  </tr>
  <tr>
    <td>License</td><td>MIT License</td>
  </tr>
</table>
