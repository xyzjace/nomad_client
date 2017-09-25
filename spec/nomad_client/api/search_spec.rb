require 'spec_helper'
module NomadClient
  module Api
    RSpec.describe 'Search' do
      let!(:nomad_client) { NomadClient::Connection.new('http://nomad.local') }

      describe 'search' do
        it 'should add the search method to the NomadClient::Connection class' do
          expect(nomad_client).to respond_to :search
          expect(nomad_client.search).to be_kind_of NomadClient::Api::Search
        end
      end

      describe 'Search API methods' do
        let(:block_receiver) { double(:block_receiver) }
        let!(:connection)    { double(:connection) }

        before do
          allow(nomad_client).to receive(:connection).and_return(connection)
        end

        describe '#get' do
          it 'should call get on the search endpoint with a prefix and context param' do
            prefix        = 'mycoo'
            context_param = 'jobs'
            params_hash = {}
            expect(connection).to receive(:post).and_yield(block_receiver)
            expect(block_receiver).to receive(:url).with("search")
            allow(block_receiver).to receive(:params).and_return(params_hash)
            expect(params_hash).to receive_message_chain(:[]=).with(:Prefix, prefix)
            expect(params_hash).to receive_message_chain(:[]=).with(:Context, context_param)
            nomad_client.search.get(prefix, context_param)
          end
        end
      end
    end
  end
end
