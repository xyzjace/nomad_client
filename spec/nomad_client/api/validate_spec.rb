require 'spec_helper'
module NomadClient
  module Api
    RSpec.describe 'Validate' do
      let!(:nomad_client) { NomadClient::Connection.new('http://nomad.local') }

      describe 'validate' do
        it 'should add the validate method to the NomadClient::Connection class' do
          expect(nomad_client).to respond_to :validate
          expect(nomad_client.validate).to be_kind_of NomadClient::Api::Validate
        end
      end

      describe 'Validate API methods' do
        let(:block_receiver) { double(:block_receiver) }
        let(:nomad_job)      { { "Job" => {} } }
        let!(:connection)    { double(:connection) }

        before do
          allow(nomad_client).to receive(:connection).and_return(connection)
        end

        describe '#job' do
          it 'should call post on the validate job endpoint' do
            expect(connection).to receive(:post).and_yield(block_receiver)
            expect(block_receiver).to receive(:url).with("validate/job")
            expect(block_receiver).to receive(:body=).with(nomad_job)

            nomad_client.validate.job(nomad_job)
          end
        end
      end
    end
  end
end
