module NomadClient
  class Configuration
    # FQDN of the Nomad you're talking to, e.g: https://nomad.local
    attr_accessor :url

    # Nomad's bound port, by default this is 4646
    attr_accessor :port

    # Nomad's HTTP API base path, as of writing this is /v1
    attr_accessor :api_base_path

    DEFAULT_PORT          = 4646.freeze
    DEFAULT_API_BASE_PATH = '/v1'.freeze

    def initialize
      @port          = DEFAULT_PORT
      @api_base_path = DEFAULT_API_BASE_PATH
    end
  end
end
