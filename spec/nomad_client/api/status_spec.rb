require 'spec_helper'
module NomadClient
  module Api
    RSpec.describe 'Status' do
      let!(:nomad_client) { NomadClient::Connection.new('http://nomad.local') }

      describe 'status' do
        it 'should add the status method to the NomadClient::Connection class' do
          expect(nomad_client).to respond_to :status
          expect(nomad_client.status).to be_kind_of NomadClient::Api::Status
        end
      end

      describe 'Status API methods' do
        let(:block_receiver) { double(:block_receiver) }
        let!(:connection)    { double(:connection) }

        before do
          allow(nomad_client).to receive(:connection).and_return(connection)
        end

        describe '#leader' do
          it 'should call get on the leader endpoint' do
            expect(connection).to receive(:get).and_yield(block_receiver)
            expect(block_receiver).to receive(:url).with("status/leader")

            nomad_client.status.leader
          end
        end

        describe '#peers' do
          it 'should call get on the peers endpoint' do
            expect(connection).to receive(:get).and_yield(block_receiver)
            expect(block_receiver).to receive(:url).with("status/peers")

            nomad_client.status.peers
          end
        end

      end
    end
  end
end
