require 'spec_helper'
module NomadClient
  module Api
    RSpec.describe 'Nodes' do
      let!(:nomad_client) { NomadClient::Connection.new('http://nomad.local') }

      describe 'nodes' do
        it 'should add the nodes method to the NomadClient::Connection class' do
          expect(nomad_client).to respond_to :nodes
          expect(nomad_client.nodes).to be_kind_of NomadClient::Api::Nodes
        end
      end

      describe 'Nodes API methods' do
        let(:block_receiver) { double(:block_receiver) }
        let!(:connection)    { double(:connection) }

        before do
          allow(nomad_client).to receive(:connection).and_return(connection)
        end

        describe '#get' do
          it 'should call get' do
            expect(connection).to receive(:get).and_yield(block_receiver)
            expect(block_receiver).to receive(:url).with("nodes")

            nomad_client.nodes.get
          end
        end
      end
    end
  end
end
