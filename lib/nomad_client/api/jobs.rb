module NomadClient
  class Client
    def jobs
      Api::Jobs.new(self)
    end
  end
  module Api
    class Jobs < Path

      ##
      # Get all Job
      #
      # @return [Faraday::Response] A faraday response from Nomad
      def get
        connection.get do |req|
          req.url "jobs"
        end
      end

      ##
      # Create a Job in Nomad
      #
      # @param [String] id The ID of the job according to Nomad
      # @param [Hash|String] job A hash or json string of a valid Job payload (https://www.nomadproject.io/docs/http/job.html)
      # @return [Faraday::Response] A faraday response from Nomad
      def create(id, job)
        client.job.create(id, job)
      end
    end
  end
end
