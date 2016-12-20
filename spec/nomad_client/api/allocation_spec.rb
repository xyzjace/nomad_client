require 'spec_helper'
module NomadClient
  module Api
    RSpec.describe 'Allocation' do
      let!(:nomad_client) { NomadClient::Client.new('http://nomad.local') }

      describe 'allocation' do
        it 'should add the evaluation method to the NomadClient::Client class' do
          expect(nomad_client).to respond_to :allocation
          expect(nomad_client.allocation).to be_kind_of NomadClient::Api::Allocation
        end
      end

      describe 'Allocation API methods' do
        let(:block_receiver) { double(:block_receiver) }
        let(:allocation_id)  { '203266e5-e0d6-9486-5e05-397ed2b184af' }
        let!(:connection)    { double(:connection) }

        before do
          allow(nomad_client).to receive(:connection).and_return(connection)
        end

        describe '#get' do
          it 'should call get with allocation_id on the allocation_id endpoint' do
            expect(connection).to receive(:get).and_yield(block_receiver)
            expect(block_receiver).to receive(:url).with("allocation/#{allocation_id}")

            nomad_client.allocation.get(allocation_id)
          end
        end
      end
    end
  end
end
