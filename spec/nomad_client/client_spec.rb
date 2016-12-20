require 'spec_helper'
require 'pry'
module NomadClient
  describe 'Client' do
    let(:nomad_url) { 'https://nomad.local' }
    describe '#initialize' do
      context 'with no optional configuration passed' do
        it 'should set sensible defaults' do
          nomad_client = NomadClient::Client.new(nomad_url)

          expect(nomad_client.configuration.url).to eq nomad_url
          expect(nomad_client.configuration.port).to eq Configuration::DEFAULT_PORT
          expect(nomad_client.configuration.api_base_path).to eq Configuration::DEFAULT_API_BASE_PATH
        end
      end
      context 'with a configuration block passed' do
        it 'should override default configration' do
          port = 4647
          api_base_path = '/v2'
          nomad_client = NomadClient::Client.new(nomad_url) do |config|
            config.port          = port
            config.api_base_path = api_base_path
          end

          expect(nomad_client.configuration.url).to eq nomad_url
          expect(nomad_client.configuration.port).to eq port
          expect(nomad_client.configuration.api_base_path).to eq api_base_path
        end
      end
    end
  end
end
