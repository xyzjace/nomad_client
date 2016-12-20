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
nomad_client = NomadClient::Client.new('https://nomad.local')
```

Or to override default configuration

```ruby
nomad_client = NomadClient::Client.new('https://nomad.local') do |config|
  config.port = 4647
  config.api_base_path = '/v2'
end
```

### Querying endpoints

```ruby
job = nomad_client.job.get('my-job-id') # returns a Faraday::Response

if job.success?
  job.body # A Hashie::Mash of the JSON payload returning from the job/my-job-id API endpoint
else
  # handling of errors here
end
```


## Development

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/xyzjace/nomad_client.

