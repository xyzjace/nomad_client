require 'spec_helper'
module NomadClient
  module Api
    RSpec.describe 'Client' do
      let!(:nomad_client) { NomadClient::Connection.new('http://nomad.local') }

      describe 'client' do
        it 'should add the client method to the NomadClient::Connection class' do
          expect(nomad_client).to respond_to :client
          expect(nomad_client.client).to be_kind_of NomadClient::Api::Client
        end
      end

      describe 'Client API methods' do
        let(:block_receiver) { double(:block_receiver) }
        let!(:connection)    { double(:connection) }

        before do
          allow(nomad_client).to receive(:connection).and_return(connection)
        end

        describe '#status' do
          it 'should call get with on the stats endpoint' do
            expect(connection).to receive(:get).and_yield(block_receiver)
            expect(block_receiver).to receive(:url).with("client/stats")

            nomad_client.client.stats
          end
        end

      end
    end
  end
end
