require 'spec_helper'
module NomadClient
  module Api
    RSpec.describe 'System' do
      let!(:nomad_client) { NomadClient::Connection.new('http://nomad.local') }

      describe 'status' do
        it 'should add the system method to the NomadClient::Connection class' do
          expect(nomad_client).to respond_to :system
          expect(nomad_client.system).to be_kind_of NomadClient::Api::System
        end
      end

      describe 'System API methods' do
        let(:block_receiver) { double(:block_receiver) }
        let!(:connection)    { double(:connection) }

        before do
          allow(nomad_client).to receive(:connection).and_return(connection)
        end

        describe '#gc' do
          it 'should call put on the gc endpoint' do
            expect(connection).to receive(:put).and_yield(block_receiver)
            expect(block_receiver).to receive(:url).with("system/gc")

            nomad_client.system.gc
          end
        end

        describe '#reconcile_summaries' do
          it 'should call put on the reconcile/summaries endpoint' do
            expect(connection).to receive(:put).and_yield(block_receiver)
            expect(block_receiver).to receive(:url).with("system/reconcile/summaries")

            nomad_client.system.reconcile_summaries
          end
        end

      end
    end
  end
end
