module NomadClient
  class Client
    def evaluations
      Api::Evaluations.new(self)
    end
  end
  module Api
    class Evaluations < Path

      ##
      # Lists all the evaluations
      # https://www.nomadproject.io/docs/http/evals.html
      #
      # @return [Faraday::Response] A faraday response from Nomad
      def get
        connection.get do |req|
          req.url "evaluations"
        end
      end
    end
  end
end
