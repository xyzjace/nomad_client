module NomadClient
  class Connection
    def evaluation
      Api::Evaluation.new(self)
    end
  end
  module Api
    class Evaluation < Path

      ##
      # Query a specific evaluation
      # https://www.nomadproject.io/docs/http/eval.html
      #
      # @param [String] id The ID of the evaluation according to Nomad
      # @return [Faraday::Response] A faraday response from Nomad
      def get(id)
        connection.get do |req|
          req.url "evaluation/#{id}"
        end
      end

      ##
      # Query the allocations created or modified by an evaluation
      # https://www.nomadproject.io/docs/http/eval.html
      #
      # @param [String] id The ID of the evaluation according to Nomad
      # @return [Faraday::Response] A faraday response from Nomad
      def allocations(id)
        connection.get do |req|
          req.url "evaluation/#{id}/allocations"
        end
      end
    end
  end
end
