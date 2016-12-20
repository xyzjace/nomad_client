module NomadClient
  class Client
    def allocation
      Api::Allocation.new(self)
    end
  end
  module Api
    class Allocation < Path

      ##
      # Get an Allocation
      #
      # @param [String] id The ID of the allocation according to Nomad
      # @return [Faraday::Response] A faraday response from Nomad
      def get(id)
        connection.get do |req|
          req.url "allocation/#{id}"
        end
      end
    end
  end
end
