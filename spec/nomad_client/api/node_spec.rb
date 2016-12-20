require 'spec_helper'
module NomadClient
  module Api
    RSpec.describe 'Node' do
      let!(:nomad_client) { NomadClient::Client.new('http://nomad.local') }

      describe 'node' do
        it 'should add the node method to the NomadClient::Client class' do
          expect(nomad_client).to respond_to :node
          expect(nomad_client.node).to be_kind_of NomadClient::Api::Node
        end
      end

      describe 'Node API methods' do
        let(:block_receiver) { double(:block_receiver) }
        let(:node_id)         { 'c9972143-861d-46e6-df73-1d8287bc3e66' }
        let!(:connection)    { double(:connection) }

        before do
          allow(nomad_client).to receive(:connection).and_return(connection)
        end

        describe '#get' do
          it 'should call get with a node_id' do
            expect(connection).to receive(:get).and_yield(block_receiver)
            expect(block_receiver).to receive(:url).with("node/#{node_id}")

            nomad_client.node.get(node_id)
          end
        end

        describe '#allocations' do
          it 'should call get with a node_id on the allocations endpoint' do
            expect(connection).to receive(:get).and_yield(block_receiver)
            expect(block_receiver).to receive(:url).with("node/#{node_id}/allocations")

            nomad_client.node.allocations(node_id)
          end
        end

        describe '#drain' do
          context 'without supplying enable' do
            it 'should call post with a node_id and an enable flag set to true' do
              params_hash = {}
              expect(connection).to receive(:post).and_yield(block_receiver)
              expect(block_receiver).to receive(:url).with("node/#{node_id}/drain")
              expect(block_receiver).to receive(:params).and_return(params_hash)
              expect(params_hash).to receive_message_chain(:[]=).with(:enable, true)
              nomad_client.node.drain(node_id)
            end
          end
          context 'when supplying enable' do
            it 'should call post with a node_id and an enable flag set to false' do
              params_hash = {}
              expect(connection).to receive(:post).and_yield(block_receiver)
              expect(block_receiver).to receive(:url).with("node/#{node_id}/drain")
              expect(block_receiver).to receive(:params).and_return(params_hash)
              expect(params_hash).to receive_message_chain(:[]=).with(:enable, false)
              nomad_client.node.drain(node_id, false)
            end
          end
        end
      end
    end
  end
end
