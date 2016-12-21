require 'spec_helper'
module NomadClient
  module Api
    RSpec.describe 'Allocations' do
      let!(:nomad_client) { NomadClient::Connection.new('http://nomad.local') }

      describe 'allocations' do
        it 'should add the allocations method to the NomadClient::Connection class' do
          expect(nomad_client).to respond_to :allocations
          expect(nomad_client.allocations).to be_kind_of NomadClient::Api::Allocations
        end
      end

      describe 'Allocations API methods' do
        let(:block_receiver) { double(:block_receiver) }
        let!(:connection)    { double(:connection) }

        before do
          allow(nomad_client).to receive(:connection).and_return(connection)
        end

        describe '#get' do
          it 'should call get on the allocations endpoint' do
            expect(connection).to receive(:get).and_yield(block_receiver)
            expect(block_receiver).to receive(:url).with("allocations")

            nomad_client.allocations.get
          end
        end
      end
    end
  end
end
