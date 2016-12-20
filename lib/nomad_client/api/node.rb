module NomadClient
  class Client
    def node
      Api::Node.new(self)
    end
  end
  module Api
    class Node < Path

      ##
      # Get a client node from Nomad
      #
      # @return [Faraday::Response] A faraday response from Nomad
      def get(id)
        connection.get do |req|
          req.url "node/#{id}"
        end
      end

      ##
      # Get all allocations belonging to a single node
      #
      # @return [Faraday::Response] A faraday response from Nomad
      def allocations(id)
        connection.get do |req|
          req.url "node/#{id}/allocations"
        end
      end

      ##
      # Toggle the drain mode of the node. When enabled, no further allocations will be assigned
      # and existing allocations will be migrated.
      #
      # @return [Faraday::Response] A faraday response from Nomad
      def drain(id, enable = true)
        connection.post do |req|
          req.url "node/#{id}/drain"
          req.params[:enable] = enable
        end
      end
    end
  end
end
