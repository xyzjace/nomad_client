module NomadClient
  class Client
    def agent
      Api::Agent.new(self)
    end
  end
  module Api
    class Agent < Path

      ##
      # Query the state of the target agent
      # https://www.nomadproject.io/docs/http/agent-self.html
      #
      # @return [Faraday::Response] A faraday response from Nomad
      def self
        connection.get do |req|
          req.url "agent/self"
        end
      end

      ##
      # Initiate a join between the agent and target peers
      # https://www.nomadproject.io/docs/http/agent-self.html
      #
      # @param [Array] addresses The addresses to join
      # @return [Faraday::Response] A faraday response from Nomad
      def join(addresses)
        connection.post do |req|
          req.url "agent/join"
          req.params[:address] = addresses
        end
      end

      ##
      # Lists the known members of the gossip pool
      # https://www.nomadproject.io/docs/http/agent-members.html
      #
      # @return [Faraday::Response] A faraday response from Nomad
      def members
        connection.get do |req|
          req.url "agent/members"
        end
      end

      ##
      # Force a failed gossip member into the left state
      # https://www.nomadproject.io/docs/http/agent-force-leave.html
      #
      # @param [String] node The name of the node to force leave
      # @return [Faraday::Response] A faraday response from Nomad
      def force_leave(node)
        connection.post do |req|
          req.url "agent/force-leave"
          req.params[:node] = node
        end
      end

      ##
      # Lists the known server nodes
      # https://www.nomadproject.io/docs/http/agent-servers.html
      #
      # @return [Faraday::Response] A faraday response from Nomad
      def list_servers
        connection.get do |req|
          req.url "agent/servers"
        end
      end

      ##
      # Updates the list of known servers to the provided list. Replaces all previous server addresses with the new list
      # https://www.nomadproject.io/docs/http/agent-servers.html
      #
      # @param [Array] addresses The addresses of server nodes in host:port format.
      # @return [Faraday::Response] A faraday response from Nomad
      def update_servers(addresses)
        connection.post do |req|
          req.url "agent/servers"
          req.params[:address] = addresses
        end
      end

    end
  end
end
