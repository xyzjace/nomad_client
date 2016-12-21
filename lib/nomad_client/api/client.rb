module NomadClient
  class Connection
    def client
      Api::Client.new(self)
    end
  end
  module Api
    class Client < Path

      ##
      # Query the actual resource usage of a Nomad client
      # https://www.nomadproject.io/docs/http/client-stats.html
      #
      # @return [Faraday::Response] A faraday response from Nomad
      def stats
        connection.get do |req|
          req.url "client/stats"
        end
      end

    end
  end
end
