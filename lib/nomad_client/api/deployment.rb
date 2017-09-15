module NomadClient
  class Connection
    def deployment
      Api::Deployment.new(self)
    end
  end
  module Api
    class Deployment < Path

      ##
      # Query a specific deployment
      # https://www.nomadproject.io/api/deployments.html
      #
      # @param [String] id The ID of the deployment according to Nomad
      # @return [Faraday::Response] A faraday response from Nomad
      def get(id)
        connection.get do |req|
          req.url "deployment/#{id}"
        end
      end

      ##
      # Query the allocations created or modified for the given deployment
      # https://www.nomadproject.io/api/deployments.html
      #
      # @param [String] id The ID of the deployment according to Nomad
      # @return [Faraday::Response] A faraday response from Nomad
      def allocations(id)
        connection.get do |req|
          req.url "deployment/allocations/#{id}"
        end
      end

      ##
      # Mark a deployment as failed.
      # This should be done to force the scheduler to stop creating allocations as part of the deployment or to cause a rollback to a previous job version.
      # https://www.nomadproject.io/api/deployments.html
      #
      # @param [String] id The ID of the deployment according to Nomad
      # @return [Faraday::Response] A faraday response from Nomad
      def fail(id)
        connection.post do |req|
          req.url "deployment/fail/#{id}"
        end
      end

      ##
      # Pause or unpause a deployment. This is done to pause a rolling upgrade or resume it.
      # https://www.nomadproject.io/api/deployments.html
      #
      # @param [String] id The ID of the deployment according to Nomad
      # @param [Boolean] pause True if pausing, false if unpausing
      # @return [Faraday::Response] A faraday response from Nomad
      def pause(id, pause)
        connection.post do |req|
          req.url "deployment/pause/#{id}"
          req.params[:Pause] = pause
        end
      end

      ##
      # Promote task groups that have canaries for a deployment. This should be done when the placed canaries are healthy and the rolling upgrade of the remaining allocations should begin.
      # https://www.nomadproject.io/api/deployments.html
      #
      # @param [String] id The ID of the deployment according to Nomad
      # @param [Boolean] all Whether all task groups should be promoted
      # @param [Array[String]] groups A particular set of task groups that should be promoted
      # @return [Faraday::Response] A faraday response from Nomad
      def promote(id, all: false, groups: nil)
        connection.post do |req|
          req.url "deployment/promote/#{id}"
          req.params[:All] = all
          req.params[:Groups] = groups
        end
      end

      ##
      # Set the health of an allocation that is in the deployment manually. In some use cases, automatic detection of allocation health may not be desired.
      # As such those task groups can be marked with an upgrade policy that uses health_check = "manual". Those allocations must have their health marked manually using this endpoint.
      # Marking an allocation as healthy will allow the rolling upgrade to proceed. Marking it as failed will cause the deployment to fail.
      # https://www.nomadproject.io/api/deployments.html
      #
      # @param [String] id The ID of the deployment according to Nomad
      # @param [Array[String]] healthy_allocation_ids Specifies the set of allocation that should be marked as healthy
      # @param [Array[String]] unhealthy_allocation_ids Specifies the set of allocation that should be marked as unhealthy
      # @return [Faraday::Response] A faraday response from Nomad
      def allocation_health(id, healthy_allocation_ids: nil, unhealthy_allocation_ids: nil)
        connection.post do |req|
          req.url "deployment/allocation-health/#{id}"
          req.params[:HealthyAllocationIDs]   = healthy_allocation_ids
          req.params[:UnhealthyAllocationIDs] = unhealthy_allocation_ids
        end
      end
    end
  end
end
