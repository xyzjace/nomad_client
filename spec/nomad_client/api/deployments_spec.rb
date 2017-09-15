require 'spec_helper'
module NomadClient
  module Api
    RSpec.describe 'Deployments' do
      let!(:nomad_client) { NomadClient::Connection.new('http://nomad.local') }

      describe 'deployments' do
        it 'should add the deployments method to the NomadClient::Connection class' do
          expect(nomad_client).to respond_to :deployments
          expect(nomad_client.deployments).to be_kind_of NomadClient::Api::Deployments
        end
      end

      describe 'Deployments API methods' do
        let(:block_receiver)   { double(:block_receiver) }
        let(:deployment_id)    { 'deployment-job' }
        let(:nomad_deployment) { { "ID" => deployment_id } }
        let!(:connection)      { double(:connection) }

        before do
          allow(nomad_client).to receive(:connection).and_return(connection)
        end

        describe '#get' do
          context 'with no prefix' do
            it 'should call get on the deployments endpoint with a nil prefix' do
              prefix_params = {}
              expect(connection).to receive(:get).and_yield(block_receiver)
              expect(block_receiver).to receive(:url).with("deployments")
              allow(block_receiver).to receive(:params).and_return(prefix_params)
              expect(prefix_params).to receive(:[]=).with(:prefix, nil)

              nomad_client.deployments.get
            end
          end
          context 'with a prefix' do
            it 'should call get on the deployments endpoint with a prefix supplied' do
              prefix_params = {}
              expect(connection).to receive(:get).and_yield(block_receiver)
              expect(block_receiver).to receive(:url).with("deployments")
              allow(block_receiver).to receive(:params).and_return(prefix_params)
              expect(prefix_params).to receive(:[]=).with(:prefix, 'my-cool')

              nomad_client.deployments.get('my-cool')
            end
          end
        end
      end
    end
  end
end
