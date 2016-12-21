module NomadClient
  class Connection
    def system
      Api::System.new(self)
    end
  end
  module Api
    class System < Path

      ##
      # Initiate garbage collection of jobs, evals, allocations and nodes
      # https://www.nomadproject.io/docs/http/system.html
      #
      # @return [Faraday::Response] A faraday response from Nomad
      def gc
        connection.put do |req|
          req.url "system/gc"
        end
      end

      ##
      # Reconcile the summaries of all the registered jobs based
      # https://www.nomadproject.io/docs/http/system.html
      #
      # @return [Faraday::Response] A faraday response from Nomad
      def reconcile_summaries
        connection.put do |req|
          req.url "system/reconcile/summaries"
        end
      end

    end
  end
end
