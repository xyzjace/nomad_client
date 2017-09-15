require 'spec_helper'
module NomadClient
  module Api
    RSpec.describe 'Deployment' do
      let!(:nomad_client) { NomadClient::Connection.new('http://nomad.local') }

      describe 'deployment' do
        it 'should add the deployment method to the NomadClient::Connection class' do
          expect(nomad_client).to respond_to :deployment
          expect(nomad_client.deployment).to be_kind_of NomadClient::Api::Deployment
        end
      end

      describe 'Deployment API methods' do
        let(:block_receiver)   { double(:block_receiver) }
        let(:deployment_id)    { 'deployment-id' }
        let(:nomad_deployment) { { "ID" => deployment_id } }
        let!(:connection)      { double(:connection) }

        before do
          allow(nomad_client).to receive(:connection).and_return(connection)
        end

        describe '#get' do
          it 'should call get with deployment_id on the deployment_id endpoint' do
            expect(connection).to receive(:get).and_yield(block_receiver)
            expect(block_receiver).to receive(:url).with("deployment/#{deployment_id}")

            nomad_client.deployment.get(deployment_id)
          end
        end


        describe '#allocations' do
          it 'should call get with deployment_id on the deployment allocations endpoint' do
            expect(connection).to receive(:get).and_yield(block_receiver)
            expect(block_receiver).to receive(:url).with("deployment/allocations/#{deployment_id}")

            nomad_client.deployment.allocations(deployment_id)
          end
        end

        describe '#fail' do
          it 'should call post with deployment_id on the deployment_id fail endpoint' do
            expect(connection).to receive(:post).and_yield(block_receiver)
            expect(block_receiver).to receive(:url).with("deployment/fail/#{deployment_id}")

            nomad_client.deployment.fail(deployment_id)
          end
        end

        describe '#pause' do
          it 'should call post with deployment_id and a pause boolean set to true on the deployment_id pause endpoint' do
            pause_params = {}
            expect(connection).to receive(:post).and_yield(block_receiver)
            expect(block_receiver).to receive(:url).with("deployment/pause/#{deployment_id}")
            expect(block_receiver).to receive(:params).and_return(pause_params)
            expect(pause_params).to receive(:[]=).with(:Pause, true)

            nomad_client.deployment.pause(deployment_id)
          end
        end

        describe '#unpause' do
          it 'should call post with deployment_id and a pause boolean set to true on the deployment_id pause endpoint' do
            pause_params = {}
            expect(connection).to receive(:post).and_yield(block_receiver)
            expect(block_receiver).to receive(:url).with("deployment/pause/#{deployment_id}")
            expect(block_receiver).to receive(:params).and_return(pause_params)
            expect(pause_params).to receive(:[]=).with(:Pause, false)

            nomad_client.deployment.unpause(deployment_id)
          end
        end

        describe '#promote' do
          context 'when promoting all' do
            it 'should call post with deployment_id and an All boolean set to true on the deployment_id promote endpoint' do
              promote_params = {}
              expect(connection).to receive(:post).and_yield(block_receiver)
              expect(block_receiver).to receive(:url).with("deployment/promote/#{deployment_id}")
              allow(block_receiver).to receive(:params).and_return(promote_params)
              expect(promote_params).to receive(:[]=).with(:All, true)
              expect(promote_params).to receive(:[]=).with(:Groups, nil)

              nomad_client.deployment.promote(deployment_id, all: true)
            end
          end
          context 'when promoting a subset' do
            it 'should call post with deployment_id and an All boolean set to false and a set of groups on the deployment_id pause endpoint' do
              promote_params = {}
              expect(connection).to receive(:post).and_yield(block_receiver)
              expect(block_receiver).to receive(:url).with("deployment/promote/#{deployment_id}")
              allow(block_receiver).to receive(:params).and_return(promote_params)
              expect(promote_params).to receive(:[]=).with(:All, false)
              expect(promote_params).to receive(:[]=).with(:Groups, ['a-task-group'])


              nomad_client.deployment.promote(deployment_id, all: false, groups: ['a-task-group'])
            end
          end
        end


        describe '#allocation_health' do
          context 'when setting allocations to healthy' do
            it 'should call post with deployment_id and a set of unhealthy allocation ids on the deployment_id allocation-health endpoint' do
              promote_params = {}
              expect(connection).to receive(:post).and_yield(block_receiver)
              expect(block_receiver).to receive(:url).with("deployment/allocation-health/#{deployment_id}")
              allow(block_receiver).to receive(:params).and_return(promote_params)
              expect(promote_params).to receive(:[]=).with(:HealthyAllocationIDs, ['an-allocation-id-to-set-to-healthy'])
              expect(promote_params).to receive(:[]=).with(:UnhealthyAllocationIDs, nil)

              nomad_client.deployment.allocation_health(deployment_id, healthy_allocation_ids: ['an-allocation-id-to-set-to-healthy'])
            end
          end
          context 'when setting allocations to unhealthy' do
            it 'should call post with deployment_id and a set of healthy allocation ids on the deployment_id allocation-health endpoint' do
              promote_params = {}
              expect(connection).to receive(:post).and_yield(block_receiver)
              expect(block_receiver).to receive(:url).with("deployment/allocation-health/#{deployment_id}")
              allow(block_receiver).to receive(:params).and_return(promote_params)
              expect(promote_params).to receive(:[]=).with(:HealthyAllocationIDs, nil)
              expect(promote_params).to receive(:[]=).with(:UnhealthyAllocationIDs, ['an-allocation-id-to-set-to-unhealthy'])

              nomad_client.deployment.allocation_health(deployment_id, unhealthy_allocation_ids: ['an-allocation-id-to-set-to-unhealthy'])
            end
          end
        end
      end
    end
  end
end
