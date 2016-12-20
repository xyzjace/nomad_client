# NomadClient

Client gem for interacting with Hashicorp's [Nomad HTTP API](https://www.nomadproject.io/docs/http/).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'nomad_client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nomad_client

## Usage

### Initialisation
For a default client

```ruby
NomadClient::Client.new('https://nomad.local')
```

Or to override default configuration

```ruby
NomadClient::Client.new('https://nomad.local') do |config|
  config.port = 4647
  config.api_base_path = '/v2'
end
```

## Development

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/xyzjace/nomad_client.

