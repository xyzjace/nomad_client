require 'spec_helper'
module NomadClient
  module Api
    RSpec.describe 'Job' do
      let!(:nomad_client) { NomadClient::Client.new('http://nomad.local') }

      describe 'job' do
        it 'should add the job method to the NomadClient::Client class' do
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
            expect(block_receiver).to receive(:url).with("job/#{job_id}/")

            nomad_client.job.get(job_id)
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
      end

    end
  end
end
