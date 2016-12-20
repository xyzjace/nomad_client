require 'spec_helper'
module NomadClient
  module Api
    RSpec.describe 'Jobs' do
      let!(:nomad_client) { NomadClient::Client.new('http://nomad.local') }

      describe 'jobs' do
        it 'should add the jobs method to the NomadClient::Client class' do
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
          it 'should call get with jobs endpoint' do
            expect(connection).to receive(:get).and_yield(block_receiver)
            expect(block_receiver).to receive(:url).with("jobs")

            nomad_client.jobs.get
          end
        end

        describe '#create' do
          it 'should call post with job_id and a job json blob on the jobs endpoint, but use the job#create method' do
            expect(nomad_client).to receive_message_chain(:job, :create).with(job_id, nomad_job)

            nomad_client.jobs.create(job_id, nomad_job)
          end
        end

      end
    end
  end
end
