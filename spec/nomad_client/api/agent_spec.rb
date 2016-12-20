require 'spec_helper'
module NomadClient
  module Api
    RSpec.describe 'Agent' do
      let!(:nomad_client) { NomadClient::Client.new('http://nomad.local') }

      describe 'agent' do
        it 'should add the agent method to the NomadClient::Client class' do
          expect(nomad_client).to respond_to :agent
          expect(nomad_client.agent).to be_kind_of NomadClient::Api::Agent
        end
      end

      describe 'Agent API methods' do
        let(:block_receiver) { double(:block_receiver) }
        let!(:connection)    { double(:connection) }

        before do
          allow(nomad_client).to receive(:connection).and_return(connection)
        end

        describe '#self' do
          it 'should call get with on the self endpoint' do
            expect(connection).to receive(:get).and_yield(block_receiver)
            expect(block_receiver).to receive(:url).with("agent/self")

            nomad_client.agent.self
          end
        end

        describe '#join' do
          it 'should call post with on the join endpoint with one or more addresses' do
            params_hash = {}
            addresses = ['http://nomad.2.local', 'http://nomad.3.local']
            expect(connection).to receive(:post).and_yield(block_receiver)
            expect(block_receiver).to receive(:url).with("agent/join")
            expect(block_receiver).to receive(:params).and_return(params_hash)
            expect(params_hash).to receive_message_chain(:[]=).with(:address, addresses)
            nomad_client.agent.join(addresses)
          end
        end
      end
    end
  end
end
