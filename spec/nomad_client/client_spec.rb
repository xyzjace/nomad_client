require 'spec_helper'
require 'pry'
module NomadClient
  describe 'Client' do
    let(:nomad_url) { 'https://nomad.local' }
    describe '#new' do
      context 'with no optional configuration passed' do
        it 'should set sensible defaults' do
          nomad_client = NomadClient::Client.new(nomad_url)

          expect(nomad_client.configuration.url).to           eq nomad_url
          expect(nomad_client.configuration.port).to          eq Configuration::DEFAULT_PORT
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

          expect(nomad_client.configuration.url).to           eq nomad_url
          expect(nomad_client.configuration.port).to          eq port
          expect(nomad_client.configuration.api_base_path).to eq api_base_path
        end
      end
    end

    # Though there are some out there who shun testing private methods, my preference
    # in this case is to make sure our configuration is ingested correctly and stays so.
    describe '#client' do
      context 'with default options' do
        it 'should configure the http client with our client configuration' do
          nomad_client = NomadClient::Client.new(nomad_url)
          nomads_client = nomad_client.send(:client)

          expect(nomad_url.end_with?(nomads_client.host)).to eq true
          expect(nomads_client.port).to                      eq Configuration::DEFAULT_PORT
          expect(nomads_client.path_prefix).to               eq Configuration::DEFAULT_API_BASE_PATH
        end
      end
    end
  end
end
