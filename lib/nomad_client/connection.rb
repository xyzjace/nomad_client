require 'faraday'
require 'faraday_middleware'
module NomadClient
  class Connection

    attr_accessor :configuration

    def initialize(url, config = Configuration.new)
      config.url = url
      yield(config) if block_given?
      @configuration = config
    end

    def connection
      ::Faraday.new({ url: connection_url, ssl: configuration.ssl }) do |faraday|
        faraday.request(:json)
        faraday.use(FaradayMiddleware::Mashify)
        faraday.response(:json, :content_type => /\bjson$/)
        faraday.adapter(Faraday.default_adapter)
      end
    end

    def connection_url
      "#{configuration.url}:#{configuration.port}#{configuration.api_base_path}"
    end
  end
end
