module NomadClient
  class Connection
    def jobs
      Api::Jobs.new(self)
    end
  end
  module Api
    class Jobs < Path

      ##
      # Lists all the jobs registered with Nomad
      # https://www.nomadproject.io/docs/http/jobs.html
      #
      # @return [Faraday::Response] A faraday response from Nomad
      def get
        connection.get do |req|
          req.url "jobs"
        end
      end

      ##
      # Registers a new job
      # https://www.nomadproject.io/docs/http/jobs.html
      #
      # @param [String] id The ID of the job according to Nomad
      # @param [Hash|String] job A hash or json string of a valid Job payload (https://www.nomadproject.io/docs/http/job.html)
      # @return [Faraday::Response] A faraday response from Nomad
      def create(id, job)
        nomad_connection.job.create(id, job)
      end
    end
  end
end
