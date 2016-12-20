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
  end
end
