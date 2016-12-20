module NomadClient
  class Client
    def evaluation
      Api::Evaluation.new(self)
    end
  end
  module Api
    class Evaluation < Path

      ##
      # Get an Evaluation
      #
      # @param [String] id The ID of the evaluation according to Nomad
      # @return [Faraday::Response] A faraday response from Nomad
      def get(id)
        connection.get do |req|
          req.url "evaluation/#{id}"
        end
      end
    end
  end
end
