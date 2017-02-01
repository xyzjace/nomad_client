module NomadClient
  class Configuration
    # FQDN of the Nomad you're talking to, e.g: https://nomad.local
    attr_accessor :url

    # Nomad's bound port, by default this is 4646
    attr_accessor :port

    # Nomad's HTTP API base path, as of writing this is /v1
    attr_accessor :api_base_path

    # SSL configuration hash, specifically the one Faraday expects,
    # see https://gist.github.com/mislav/938183 for a quick example
    attr_accessor :ssl

    DEFAULT_PORT          = 4646.freeze
    DEFAULT_API_BASE_PATH = '/v1'.freeze
    DEFAULT_SSL           = {}.freeze

    def initialize
      @port          = DEFAULT_PORT
      @api_base_path = DEFAULT_API_BASE_PATH
      @ssl           = DEFAULT_SSL
    end
  end
end
