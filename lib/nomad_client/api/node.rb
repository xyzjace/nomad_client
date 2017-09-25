module NomadClient
  class Connection
    def node
      Api::Node.new(self)
    end
  end
  module Api
    class Node < Path

      ##
      # Query the status of a client node registered with Nomad
      # https://www.nomadproject.io/docs/http/node.html
      #
      # @param [String] id ID of the node
      # @return [Faraday::Response] A faraday response from Nomad
      def get(id)
        connection.get do |req|
          req.url "node/#{id}"
        end
      end

      ##
      # Query the allocations belonging to a single node
      # https://www.nomadproject.io/docs/http/node.html
      #
      # @param [String] id ID of the node
      # @return [Faraday::Response] A faraday response from Nomad
      def allocations(id)
        connection.get do |req|
          req.url "node/#{id}/allocations"
        end
      end

      ##
      # Toggle the drain mode of the node. When enabled, no further allocations will be assigned
      # and existing allocations will be migrated.
      # https://www.nomadproject.io/docs/http/node.html
      #
      # @param [String] id ID of the node to drain
      # @param [Boolean] enable Boolean value provided as a query parameter to either set enabled to true or false
      # @return [Faraday::Response] A faraday response from Nomad
      def drain(id, enable: true)
        connection.post do |req|
          req.url "node/#{id}/drain"
          req.params[:enable] = enable
        end
      end

      ##
      # Creates a new evaluation for the given node. This can be used to force a run of the scheduling logic
      # https://www.nomadproject.io/api/nodes.html
      #
      # @param [String] id Specifies the UUID of the node. This must be the full UUID, not the short 8-character one. This is specified as part of the path
      # @return [Faraday::Response] A faraday response from Nomad
      def evaluate(id)
        connection.post do |req|
          req.url "node/#{id}/evaluate"
        end
      end
    end
  end
end
