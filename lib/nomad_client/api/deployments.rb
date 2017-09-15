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
      # @param [String] prefix Specifies a string to filter deployments on based on an index prefix. This is specified as a querystring parameter.
      #
      # @return [Faraday::Response] A faraday response from Nomad
      def get(prefix: nil)
        connection.get do |req|
          req.url "deployments"
          req.params[:prefix] = prefix
        end
      end
    end
  end
end
