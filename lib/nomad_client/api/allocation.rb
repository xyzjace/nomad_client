module NomadClient
  class Connection
    def allocation
      Api::Allocation.new(self)
    end
  end
  module Api
    class Allocation < Path

      ##
      # Query a specific allocation
      # https://www.nomadproject.io/docs/http/alloc.html
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
