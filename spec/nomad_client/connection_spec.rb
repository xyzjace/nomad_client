require 'spec_helper'
module NomadClient
  describe 'Client' do
    let(:nomad_url) { 'https://nomad.local' }
    describe '#new' do
      context 'with no optional configuration passed' do
        it 'should set sensible defaults' do
          nomad_client = NomadClient::Connection.new(nomad_url)

          expect(nomad_client.configuration.url).to           eq nomad_url
          expect(nomad_client.configuration.port).to          eq Configuration::DEFAULT_PORT
          expect(nomad_client.configuration.api_base_path).to eq Configuration::DEFAULT_API_BASE_PATH
          expect(nomad_client.configuration.ssl).to           be_empty
        end
      end
      context 'with a configuration block passed' do
        it 'should override default configration' do
          port          = 4647
          api_base_path = '/v2'
          ssl_config    = { client_cert: '/tmp/my.crt',  client_key: '/tmp/my.key' }
          nomad_client = NomadClient::Connection.new(nomad_url) do |config|
            config.port          = port
            config.api_base_path = api_base_path
            config.ssl           = ssl_config
          end

          expect(nomad_client.configuration.url).to           eq nomad_url
          expect(nomad_client.configuration.port).to          eq port
          expect(nomad_client.configuration.api_base_path).to eq api_base_path
          expect(nomad_client.configuration.ssl).to           eq ssl_config
          expect(nomad_client.connection.ssl).to_not          be_empty
        end
      end
    end

    describe '#connection' do
      context 'with default options' do
        it 'should configure the http client with our client configuration' do
          nomad_client = NomadClient::Connection.new(nomad_url)
          connection = nomad_client.connection

          expect(nomad_url.end_with?(connection.host)).to eq true
          expect(connection.port).to                      eq Configuration::DEFAULT_PORT
          expect(connection.path_prefix).to               eq Configuration::DEFAULT_API_BASE_PATH
        end
      end
    end
  end
end
