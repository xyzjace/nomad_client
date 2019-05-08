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
      # @param [String] prefix Specifies a string to filter jobs on based on an index prefix. This is specified as a querystring parameter.
      # @return [Faraday::Response] A faraday response from Nomad
      def get(prefix: nil)
        connection.get do |req|
          req.url "jobs"
          req.params[:prefix] = prefix
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

      ##
      # Parses provided HCL formatted job spec to JSON
      # https://www.nomadproject.io/docs/http/jobs.html
      #
      # @param [Hash|String] job A hash or json string of a valid Job payload (https://www.nomadproject.io/docs/http/job.html)
      # @return [Faraday::Response] A faraday response from Nomad
      def parse(job)
        connection.post do |req|
          req.url "jobs/parse"
          req.body = {
            "JobHCL": job
          }
        end
      end
    end
  end
end
