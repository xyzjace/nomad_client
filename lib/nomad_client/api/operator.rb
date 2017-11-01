module NomadClient
  class Connection
    def operator
      Api::Operator.new(self)
    end
  end
  module Api
    class Operator < Path

      ##
      # Queries the status of a client node registered with Nomad
      # https://www.nomadproject.io/api/operator.html#read-raft-configuration
      # @param [Boolean] stale Specifies if the cluster should respond without an active leader
      #
      # @return [Faraday::Response] A faraday response from Nomad
      def raft_configuration(stale: false)
        connection.get do |req|
          req.url "operator/raft/configuration"
          req.params[:stale] = stale
        end
      end

      ##
      # removes a Nomad server with given address from the Raft configuration. The return code signifies success or failure
      # https://www.nomadproject.io/api/operator.html#remove-raft-peer
      # @param [Array[String]] address A list of servers to remove as [ip:port, ip:port]
      # @param [Boolean] stale Specifies if the cluster should respond without an active leader
      #
      # @return [Faraday::Response] A faraday response from Nomad
      def remove_raft_peer(address, stale: false)
        connection.delete do |req|
          req.url "operator/raft/peer"
          req.body = {
            "address" => address,
            "stale" => stale
          }
        end
      end
    end
  end
end
