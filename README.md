# Yunpian

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'yunpian'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install yunpian

## Usage

### Config

```ruby
Yunpian.apikey    = 'apikey'
Yunpian.signature = '【签名】'

# or, use dynamic signatures:
Yunpian.signature = ->{ I18n.locale == :en ? "【SIGNATURE】" : "【签名】" }
```

### Send sms

```ruby
Yunpian.send_to('10086', '流量唔够用啊') # => { code: 0, msg: "OK", result: {...} }
# Yunpian.send_to(['10086', '10010'], '信号好差啊')
Yunpian.send_with_template "13800138000", 1269729, params1: "value1"

Yunpian.send_to!('10086', '流量唔够用啊')  # => will raise Yunpian::RequestException
Yunpian.send_with_template! "13800138000", 1269729, params1: "value1"

# 覆盖签名
Yunpian.send_to!('10086', '流量唔够用啊', '【其他签名】')
```

### Get account info
```ruby
Yunpian.account_info # => {"code"=>0, "msg"=>"OK", "user"=>{...}}
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/yunpian. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

