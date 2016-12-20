require 'spec_helper'
module NomadClient
  module Api
    RSpec.describe 'Evaluations' do
      let!(:nomad_client) { NomadClient::Client.new('http://nomad.local') }

      describe 'evaluations' do
        it 'should add the evaluations method to the NomadClient::Client class' do
          expect(nomad_client).to respond_to :evaluations
          expect(nomad_client.evaluations).to be_kind_of NomadClient::Api::Evaluations
        end
      end

      describe 'Evaluations API methods' do
        let(:block_receiver) { double(:block_receiver) }
        let!(:connection)    { double(:connection) }

        before do
          allow(nomad_client).to receive(:connection).and_return(connection)
        end

        describe '#get' do
          it 'should call get on the evaluations endpoint' do
            expect(connection).to receive(:get).and_yield(block_receiver)
            expect(block_receiver).to receive(:url).with("evaluations")

            nomad_client.evaluations.get
          end
        end
      end
    end
  end
end
