require 'spec_helper'
module NomadClient
  module Api
    RSpec.describe 'Operator' do
      let!(:nomad_client) { NomadClient::Connection.new('http://nomad.local') }

      describe 'operator' do
        it 'should add the operator method to the NomadClient::Connection class' do
          expect(nomad_client).to respond_to :operator
          expect(nomad_client.operator).to be_kind_of NomadClient::Api::Operator
        end
      end

      describe 'Operator API methods' do
        let(:block_receiver) { double(:block_receiver) }
        let!(:connection)    { double(:connection) }

        before do
          allow(nomad_client).to receive(:connection).and_return(connection)
        end

        describe '#raft_configuration' do
          it 'should call get on the raft_configuration endpoint with a stale param' do
            stale = true
            params_hash = {}
            expect(connection).to receive(:get).and_yield(block_receiver)
            expect(block_receiver).to receive(:url).with("operator/raft/configuration")
            expect(block_receiver).to receive(:params).and_return(params_hash)
            expect(params_hash).to receive_message_chain(:[]=).with(:stale, stale)
            nomad_client.operator.raft_configuration(stale: stale)
          end
        end

        describe '#remove_raft_peer' do
          it 'should call delete on the peer endpoint with an address and stale param' do
            stale = true
            address = 'https://nomad.local'

            expect(connection).to receive(:delete).and_yield(block_receiver)
            expect(block_receiver).to receive(:url).with("operator/raft/peer")
            expect(block_receiver).to receive_message_chain(:body=).with({"address" => address, "stale" => stale})
            nomad_client.operator.remove_raft_peer(address, stale: stale)
          end
        end

      end
    end
  end
end
