module NomadClient
  class Connection
    def deployments
      Api::Deployments.new(self)
    end
  end
  module Api
    class Deployments < Path

      ##
      # Lists all the deployments
      # https://www.nomadproject.io/api/deployments.html
      #
      # @return [Faraday::Response] A faraday response from Nomad
      def get
        connection.get do |req|
          req.url "deployments"
        end
      end
    end
  end
end
