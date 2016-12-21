module NomadClient
  class Connection
    def job
      Api::Job.new(self)
    end
  end
  module Api
    class Job < Path

      ##
      # Query a single job for its specification and status
      # https://www.nomadproject.io/docs/http/job.html
      #
      # @param [String] id The ID of the job according to Nomad
      # @return [Faraday::Response] A faraday response from Nomad
      def get(id)
        connection.get do |req|
          req.url "job/#{id}"
        end
      end

      ##
      # Query the summary of a job
      # https://www.nomadproject.io/docs/http/job.html
      #
      # @param [String] id The ID of the job according to Nomad
      # @return [Faraday::Response] A faraday response from Nomad
      def summary(id)
        connection.get do |req|
          req.url "job/#{id}/summary"
        end
      end

      ##
      # Registers a new job
      # https://www.nomadproject.io/docs/http/job.html
      #
      # @param [String] id The ID of the job according to Nomad
      # @param [Hash|String] job A hash or json string of a valid Job payload (https://www.nomadproject.io/docs/http/job.html)
      # @return [Faraday::Response] A faraday response from Nomad
      def create(id, job)
        connection.post do |req|
          req.url "job/#{id}"
          req.body = job
        end
      end

      ##
      # Update a Job in Nomad
      #
      # @param [String] id The ID of the job according to Nomad
      # @param [Hash|String] job A hash or json string of a valid Job payload (https://www.nomadproject.io/docs/http/job.html)
      # @return [Faraday::Response] A faraday response from Nomad
      def update(id, job)
        connection.put do |req|
          req.url "job/#{id}"
          req.body = job
        end
      end

      ##
      # Invoke a dry-run of the scheduler for the job
      # https://www.nomadproject.io/docs/http/job.html
      #
      # @param [String] id The ID of the job according to Nomad
      # @param [Hash|String] job A hash or json string of a valid Job payload (https://www.nomadproject.io/docs/http/job.html)
      # @return [Faraday::Response] A faraday response from Nomad
      def plan(id, job)
        connection.post do |req|
          req.url "job/#{id}/plan"
          req.body = job
        end
      end

      ##
      # Deregisters a job, and stops all allocations part of it.
      # https://www.nomadproject.io/docs/http/job.html
      #
      # @param [String] id The ID of the job according to Nomad
      # @return [Faraday::Response] A faraday response from Nomad
      def delete(id)
        connection.delete do |req|
          req.url "job/#{id}"
        end
      end
      alias_method :deregister, :delete

      ##
      # Query the allocations belonging to a single job
      # https://www.nomadproject.io/docs/http/job.html
      #
      # @param [String] id The ID of the job according to Nomad
      # @return [Faraday::Response] A faraday response from Nomad
      def allocations(id)
        connection.get do |req|
          req.url "job/#{id}/allocations"
        end
      end

      ##
      # Query the evaluations belonging to a single job
      # https://www.nomadproject.io/docs/http/job.html
      #
      # @param [String] id The ID of the job according to Nomad
      # @return [Faraday::Response] A faraday response from Nomad
      def evaluations(id)
        connection.get do |req|
          req.url "job/#{id}/evaluations"
        end
      end

      ##
      # Creates a new evaluation for the given job. This can be used to force run the scheduling logic if necessary
      # https://www.nomadproject.io/docs/http/job.html
      #
      # @param [String] id The ID of the job according to Nomad
      # @return [Faraday::Response] A faraday response from Nomad
      def evaluate(id)
        connection.post do |req|
          req.url "job/#{id}/evaluate"
        end
      end

      ##
      # Forces a new instance of the periodic job. A new instance will be created even if it violates the job's prohibit_overlap settings.
      # As such, this should be only used to immediately run a periodic job
      # https://www.nomadproject.io/docs/http/job.html
      #
      # @param [String] id The ID of the job according to Nomad
      # @return [Faraday::Response] A faraday response from Nomad
      def periodic_force(id)
        connection.post do |req|
          req.url "job/#{id}/periodic/force"
        end
      end

    end
  end
end
