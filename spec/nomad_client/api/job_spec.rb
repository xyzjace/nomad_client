require 'spec_helper'
require 'base64'
module NomadClient
  module Api
    RSpec.describe 'Job' do
      let!(:nomad_client) { NomadClient::Connection.new('http://nomad.local') }

      describe 'job' do
        it 'should add the job method to the NomadClient::Connection class' do
          expect(nomad_client).to respond_to :job
          expect(nomad_client.job).to be_kind_of NomadClient::Api::Job
        end
      end

      describe 'Job API methods' do
        let(:block_receiver) { double(:block_receiver) }
        let(:job_id)         { 'nomad-job' }
        let(:nomad_job)      { { "Job" => {} } }
        let!(:connection)    { double(:connection) }

        before do
          allow(nomad_client).to receive(:connection).and_return(connection)
        end

        describe '#get' do
          it 'should call get with job_id on the job_id endpoint' do
            expect(connection).to receive(:get).and_yield(block_receiver)
            expect(block_receiver).to receive(:url).with("job/#{job_id}")

            nomad_client.job.get(job_id)
          end
        end

        describe '#summary' do
          it 'should call get with job_id on the job_id summary endpoint' do
            expect(connection).to receive(:get).and_yield(block_receiver)
            expect(block_receiver).to receive(:url).with("job/#{job_id}/summary")

            nomad_client.job.summary(job_id)
          end
        end

        describe '#create' do
          it 'should call post with job_id and a job json blob on the job_id endpoint' do
            expect(connection).to receive(:post).and_yield(block_receiver)
            expect(block_receiver).to receive(:url).with("job/#{job_id}")
            expect(block_receiver).to receive(:body=).with(nomad_job)

            nomad_client.job.create(job_id, nomad_job)
          end
        end

        describe '#update' do
          it 'should call put with job_id and a job json blob on the job_id endpoint' do
            expect(connection).to receive(:put).and_yield(block_receiver)
            expect(block_receiver).to receive(:url).with("job/#{job_id}")
            expect(block_receiver).to receive(:body=).with(nomad_job)

            nomad_client.job.update(job_id, nomad_job)
          end
        end

        describe '#plan' do
          it 'should call post with job_id and a job json blob on the plan endpoint' do
            expect(connection).to receive(:post).and_yield(block_receiver)
            expect(block_receiver).to receive(:url).with("job/#{job_id}/plan")
            expect(block_receiver).to receive(:body=).with(nomad_job)

            nomad_client.job.plan(job_id, nomad_job)
          end
        end

        [:deregister, :delete].each do |method_name|
          describe "##{method_name.to_s}" do
            it 'should call delete with job_id on the job_id endpoint' do
              expect(connection).to receive(:delete).and_yield(block_receiver)
              expect(block_receiver).to receive(:url).with("job/#{job_id}")

              nomad_client.job.send(method_name, job_id)
            end
          end
        end

        describe '#allocations' do
          it 'should call get with job_id on the job allocations endpoint' do
            expect(connection).to receive(:get).and_yield(block_receiver)
            expect(block_receiver).to receive(:url).with("job/#{job_id}/allocations")

            nomad_client.job.allocations(job_id)
          end
        end

        describe '#evaluations' do
          it 'should call get with job_id on the job evaluations endpoint' do
            expect(connection).to receive(:get).and_yield(block_receiver)
            expect(block_receiver).to receive(:url).with("job/#{job_id}/evaluations")

            nomad_client.job.evaluations(job_id)
          end
        end

        describe '#evaluate' do
          it 'should call post with job_id on the job_id evaluate endpoint' do
            expect(connection).to receive(:post).and_yield(block_receiver)
            expect(block_receiver).to receive(:url).with("job/#{job_id}/evaluate")

            nomad_client.job.evaluate(job_id)
          end
        end

        describe '#periodic_force' do
          it 'should call post with job_id on the job_id periodic force endpoint' do
            expect(connection).to receive(:post).and_yield(block_receiver)
            expect(block_receiver).to receive(:url).with("job/#{job_id}/periodic/force")

            nomad_client.job.periodic_force(job_id)
          end
        end

        describe '#plan' do
          it 'should call post with job_id and a job json blob on the plan endpoint' do
            expect(connection).to receive(:post).and_yield(block_receiver)
            expect(block_receiver).to receive(:url).with("job/#{job_id}/plan")
            expect(block_receiver).to receive(:body=).with(nomad_job)

            nomad_client.job.plan(job_id, nomad_job)
          end
        end

        describe '#versions' do
          it 'should call get with job_id and on the versions endpoint' do
            expect(connection).to receive(:get).and_yield(block_receiver)
            expect(block_receiver).to receive(:url).with("job/#{job_id}/versions")

            nomad_client.job.versions(job_id)
          end
        end

        describe '#deployments' do
          it 'should call get with job_id and on the deployments endpoint' do
            expect(connection).to receive(:get).and_yield(block_receiver)
            expect(block_receiver).to receive(:url).with("job/#{job_id}/deployments")

            nomad_client.job.deployments(job_id)
          end
        end

        describe '#most_recent_deployment' do
          it 'should call get with job_id and on the deployment endpoint' do
            expect(connection).to receive(:get).and_yield(block_receiver)
            expect(block_receiver).to receive(:url).with("job/#{job_id}/deployment")

            nomad_client.job.most_recent_deployment(job_id)
          end
        end

        describe '#dispatch' do
          it 'should call post on the dispatch endpoint with the job_id, payload, and meta hash' do
            payload         = ::Base64.encode64('some-payload')
            meta            = { 'key' => 'value' }

            expect(connection).to receive(:post).and_yield(block_receiver)
            expect(block_receiver).to receive(:url).with("job/#{job_id}/dispatch")
            expect(block_receiver).to receive(:body=).with({"Payload" => payload, "Meta" => meta})

            nomad_client.job.dispatch(job_id, payload: payload, meta: meta)
          end
        end

        describe '#revert' do
          it 'should call post on the revert endpoint with the job_id, job_version, and an enforce_prior_version param' do
            job_version           = 1
            enforce_prior_version = true

            expect(connection).to receive(:post).and_yield(block_receiver)
            expect(block_receiver).to receive(:url).with("job/#{job_id}/revert")
            expect(block_receiver).to receive(:body=).with({"JobVersion" => job_version, "EnforcePriorVersion" => enforce_prior_version})

            nomad_client.job.revert(job_id, job_version: job_version, enforce_prior_version: enforce_prior_version)
          end
        end

        describe '#stable' do
          it 'should call post on the stable endpoint with the job_id, job_version, and a stable param' do
            job_version   = 2
            stable        = false

            expect(connection).to receive(:post).and_yield(block_receiver)
            expect(block_receiver).to receive(:url).with("job/#{job_id}/stable")
            expect(block_receiver).to receive(:body=).with({"JobVersion" => job_version, "Stable" => stable})

            nomad_client.job.stable(job_id, job_version: job_version, stable: stable)
          end
        end
      end
    end
  end
end
