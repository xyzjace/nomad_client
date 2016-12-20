module NomadClient
  class Client
    def job
      Api::Job.new(self)
    end
  end
  module Api
    class Job < Path

      ##
      # Get a Job
      #
      # @param [String] id The ID of the job according to Nomad
      # @return [Faraday::Response] A faraday response from Nomad
      def get(id)
        connection.get do |req|
          req.url "job/#{id}/"
        end
      end

      ##
      # Get a Job's summary from Nomad
      #
      # @param [String] id The ID of the job according to Nomad
      # @return [Faraday::Response] A faraday response from Nomad
      def summary(id)
        connection.get do |req|
          req.url "job/#{id}/summary"
        end
      end

      ##
      # Create a Job in Nomad
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
      # Plan a Job in Nomad
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
      # Deregister a Job in Nomad
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
      # Retrieve the allocations for a Job in Nomad
      #
      # @param [String] id The ID of the job according to Nomad
      # @return [Faraday::Response] A faraday response from Nomad
      def allocations(id)
        connection.get do |req|
          req.url "job/#{id}/allocations"
        end
      end

      ##
      # Retrieve the evaluations for a Job in Nomad
      #
      # @param [String] id The ID of the job according to Nomad
      # @return [Faraday::Response] A faraday response from Nomad
      def evaluations(id)
        connection.get do |req|
          req.url "job/#{id}/evaluations"
        end
      end

    end
  end
end
