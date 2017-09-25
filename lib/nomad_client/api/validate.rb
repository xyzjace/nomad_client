module NomadClient
  class Connection
    def validate
      Api::Validate.new(self)
    end
  end
  module Api
    class Validate < Path

      ##
      # Validates a Nomad job file. The local Nomad agent forwards the request to a server.
      # In the event a server can't be reached the agent verifies the job file locally but skips validating driver configurations
      # https://www.nomadproject.io/api/validate.html
      #
      # @param [Hash|String] job A hash or json string of a valid Job payload (https://www.nomadproject.io/docs/http/job.html)
      # @return [Faraday::Response] A faraday response from Nomad
      def job(job)
        connection.post do |req|
          req.url "validate/job"
          req.body = job
        end
      end

    end
  end
end
