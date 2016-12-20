module NomadClient
  class Client
    def nodes
      Api::Nodes.new(self)
    end
  end
  module Api
    class Nodes < Path

      ##
      # Get client nodes from Nomad
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
