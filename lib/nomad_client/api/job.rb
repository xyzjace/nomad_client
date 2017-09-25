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

      ##
      # Reads information about all versions of a job
      # https://www.nomadproject.io/docs/http/job.html
      #
      # @param [String] id The ID of the job according to Nomad
      # @return [Faraday::Response] A faraday response from Nomad
      def versions(id)
        connection.get do |req|
          req.url "job/#{id}/versions"
        end
      end

      ##
      # Lists a single job's deployments
      # https://www.nomadproject.io/docs/http/job.html
      #
      # @param [String] id The ID of the job according to Nomad
      # @return [Faraday::Response] A faraday response from Nomad
      def deployments(id)
        connection.get do |req|
          req.url "job/#{id}/deployments"
        end
      end

      ##
      # Returns a single job's most recent deployment
      # https://www.nomadproject.io/docs/http/job.html
      #
      # @param [String] id The ID of the job according to Nomad
      # @return [Faraday::Response] A faraday response from Nomad
      def most_recent_deployment(id)
        connection.get do |req|
          req.url "job/#{id}/deployment"
        end
      end

      ##
      # Dispatches a new instance of a parameterized job
      # https://www.nomadproject.io/docs/http/job.html
      #
      # @param [String] id The ID of the job according to Nomad
      # @param [String] payload Base64 encoded string containing the payload. This is limited to 15 KB
      # @param [Hash] meta Arbitrary metadata to pass to the job
      # @return [Faraday::Response] A faraday response from Nomad
      def dispatch(id, payload: '', meta: nil)
        connection.post do |req|
          req.url "job/#{id}/dispatch"
          req.params[:Payload] = payload
          req.params[:Meta]    = meta
        end
      end

      ##
      # Reverts the job to an older version.
      # https://www.nomadproject.io/docs/http/job.html
      #
      # @param [String] id The ID of the job according to Nomad
      # @param [Integer] job_version The job version to revert to
      # @param [Integer] enforce_prior_version Value specifying the current job's version.
      # This is checked and acts as a check-and-set value before reverting to the specified job
      # @return [Faraday::Response] A faraday response from Nomad
      def revert(id, job_version: 0, enforce_prior_version: nil)
        connection.post do |req|
          req.url "job/#{id}/revert"
          req.params[:JobVersion]          = job_version
          req.params[:EnforcePriorVersion] = enforce_prior_version
        end
      end

      ##
      # Sets the job's stability
      # https://www.nomadproject.io/docs/http/job.html
      #
      # @param [String] id The ID of the job according to Nomad
      # @param [Integer] job_version The job version to set the stability on
      # @param [Integer] enforce_prior_version Whether the job should be marked as stable or not
      # @return [Faraday::Response] A faraday response from Nomad
      def stable(id, job_version: 0, stable: false)
        connection.post do |req|
          req.url "job/#{id}/stable"
          req.params[:JobVersion] = job_version
          req.params[:Stable]     = stable
        end
      end

    end
  end
end
