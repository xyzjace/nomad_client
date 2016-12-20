require 'spec_helper'
module NomadClient
  module Api
    RSpec.describe 'Evaluation' do
      let!(:nomad_client) { NomadClient::Client.new('http://nomad.local') }

      describe 'evaluation' do
        it 'should add the evaluation method to the NomadClient::Client class' do
          expect(nomad_client).to respond_to :evaluation
          expect(nomad_client.evaluation).to be_kind_of NomadClient::Api::Evaluation
        end
      end

      describe 'Evaluation API methods' do
        let(:block_receiver) { double(:block_receiver) }
        let(:evaluation_id)  { 'e89f26a2-fb86-3e4c-d248-9dc5138e4b53' }
        let!(:connection)    { double(:connection) }

        before do
          allow(nomad_client).to receive(:connection).and_return(connection)
        end

        describe '#get' do
          it 'should call get with evaluation_id on the evaluation_id endpoint' do
            expect(connection).to receive(:get).and_yield(block_receiver)
            expect(block_receiver).to receive(:url).with("evaluation/#{evaluation_id}/")

            nomad_client.evaluation.get(evaluation_id)
          end
        end
      end
    end
  end
end
