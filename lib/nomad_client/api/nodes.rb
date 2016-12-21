module NomadClient
  class Connection
    def nodes
      Api::Nodes.new(self)
    end
  end
  module Api
    class Nodes < Path

      ##
      # Lists all the client nodes registered with Nomad
      # https://www.nomadproject.io/docs/http/nodes.html
      #
      # @return [Faraday::Response] A faraday response from Nomad
      def get
        connection.get do |req|
          req.url "nodes"
        end
      end
    end
  end
end
