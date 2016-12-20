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
      # @param [Array] addresses The address to join. Can be provided multiple times to attempt joining multiple peers.
      # @return [Faraday::Response] A faraday response from Nomad
      def join(addresses)
        connection.post do |req|
          req.url "agent/join"
          req.params[:address] = addresses
        end
      end
    end
  end
end
