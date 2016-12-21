require 'spec_helper'
module NomadClient
  module Api
    RSpec.describe 'Regions' do
      let!(:nomad_client) { NomadClient::Connection.new('http://nomad.local') }

      describe 'regions' do
        it 'should add the regions method to the NomadClient::Connection class' do
          expect(nomad_client).to respond_to :regions
          expect(nomad_client.regions).to be_kind_of NomadClient::Api::Regions
        end
      end

      describe 'Regions API methods' do
        let(:block_receiver) { double(:block_receiver) }
        let!(:connection)    { double(:connection) }

        before do
          allow(nomad_client).to receive(:connection).and_return(connection)
        end

        describe '#get' do
          it 'should call get on the regions endpoint' do
            expect(connection).to receive(:get).and_yield(block_receiver)
            expect(block_receiver).to receive(:url).with("regions")

            nomad_client.regions.get
          end
        end

      end
    end
  end
end
