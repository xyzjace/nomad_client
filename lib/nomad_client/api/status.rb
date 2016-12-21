module NomadClient
  class Connection
    def status
      Api::Status.new(self)
    end
  end
  module Api
    class Status < Path

      ##
      # Returns the address of the current leader in the region
      # https://www.nomadproject.io/docs/http/status.html
      #
      # @return [Faraday::Response] A faraday response from Nomad
      def leader
        connection.get do |req|
          req.url "status/leader"
        end
      end

      ##
      # Returns the set of raft peers in the region
      # https://www.nomadproject.io/docs/http/status.html
      #
      # @return [Faraday::Response] A faraday response from Nomad
      def peers
        connection.get do |req|
          req.url "status/peers"
        end
      end

    end
  end
end
