require 'faraday'
require 'faraday_middleware'
module NomadClient
  class Client

    attr_accessor :configuration

    def self.new(url, config = Configuration.new)
      config.url = url
      yield(config) if block_given?
      super(config)
    end

    def initialize(config)
      @configuration = config
    end

    private

    def client
      ::Faraday.new(url: "#{configuration.url}:#{configuration.port}#{configuration.api_base_path}") do |faraday|
        faraday.request(:json)
        faraday.use(FaradayMiddleware::Mashify)
        faraday.response(:json, :content_type => /\bjson$/)
        faraday.adapter(Faraday.default_adapter)
      end
    end
  end
end
