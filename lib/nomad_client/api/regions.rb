module NomadClient
  class Connection
    def regions
      Api::Regions.new(self)
    end
  end
  module Api
    class Regions < Path

      ##
      # Returns the known region names
      # https://www.nomadproject.io/docs/http/regions.html
      #
      # @return [Faraday::Response] A faraday response from Nomad
      def get
        connection.get do |req|
          req.url "regions"
        end
      end

    end
  end
end
