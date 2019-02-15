require 'spec_helper'
module NomadClient
  module Api
    RSpec.describe 'Jobs' do
      let!(:nomad_client) { NomadClient::Connection.new('http://nomad.local') }

      describe 'jobs' do
        it 'should add the jobs method to the NomadClient::Connection class' do
          expect(nomad_client).to respond_to :jobs
          expect(nomad_client.jobs).to be_kind_of NomadClient::Api::Jobs
        end
      end

      describe 'Jobs API methods' do
        let(:block_receiver) { double(:block_receiver) }
        let(:job_id)         { 'nomad-job' }
        let(:nomad_job)      { { "Job" => {} } }
        let!(:connection)    { double(:connection) }

        before do
          allow(nomad_client).to receive(:connection).and_return(connection)
        end

        describe '#get' do
          let(:prefix_params) { {} }
          let(:block_receiver) { double(:block_receiver, params: prefix_params) }
          
          context 'with no prefix' do
            it 'should call get on the jobs endpoint with a nil prefix' do
              expect(connection).to receive(:get).and_yield(block_receiver)
              expect(block_receiver).to receive(:url).with('jobs')
              expect(prefix_params).to receive(:[]=).with(:prefix, nil)

              nomad_client.jobs.get
            end
          end
          context 'with a prefix' do
            it 'should call get on the deployments jobs with a prefix supplied' do
              expect(connection).to receive(:get).and_yield(block_receiver)
              expect(block_receiver).to receive(:url).with('jobs')
              expect(prefix_params).to receive(:[]=).with(:prefix, 'parent-job')

              nomad_client.jobs.get(prefix: 'parent-job')
            end
          end
        end

        describe '#create' do
          it 'should call post with job_id and a job json blob on the jobs endpoint, but use the job#create method' do
            expect(nomad_client).to receive_message_chain(:job, :create).with(job_id, nomad_job)

            nomad_client.jobs.create(job_id, nomad_job)
          end
        end

        describe '#parse' do
          let(:nomad_hcl) { 'job "example" { }' }
          it 'should call post with a job HCL blob on the jobs endpoint' do
            expect(connection).to receive(:post).and_yield(block_receiver)
            expect(block_receiver).to receive(:url).with("jobs/parse")
            expect(block_receiver).to receive(:body=).with({"JobHCL": "job \"example\" { }"})

            nomad_client.jobs.parse(nomad_hcl)
          end
        end

      end
    end
  end
end
