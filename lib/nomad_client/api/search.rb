module NomadClient
  class Connection
    def search
      Api::Search.new(self)
    end
  end
  module Api
    class Search < Path

      ##
      # Returns the address of the current leader in the region
      # https://www.nomadproject.io/api/search.html
      # @param [String] prefix the identifer against which matches will be found. For example, if the given prefix were "a", potential matches might be "abcd", or "aabb"
      # @param [String] context Defines the scope in which a search for a prefix operates.
      # Contexts can be: "jobs", "evals", "allocs", "nodes", "deployment" or "all", where "all" means every context will be searched
      #
      # @return [Faraday::Response] A faraday response from Nomad
      def get(prefix, context)
        connection.post do |req|
          req.url "search"
          req.params[:Prefix]  = prefix
          req.params[:Context] = context
        end
      end
    end
  end
end
