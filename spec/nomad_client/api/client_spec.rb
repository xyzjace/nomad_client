require 'spec_helper'
module NomadClient
  module Api
    RSpec.describe 'Client' do
      let!(:nomad_client) { NomadClient::Connection.new('http://nomad.local') }

      describe 'client' do
        it 'should add the client method to the NomadClient::Connection class' do
          expect(nomad_client).to respond_to :client
          expect(nomad_client.client).to be_kind_of NomadClient::Api::Client
        end
      end

      describe 'Client API methods' do
        let(:block_receiver) { double(:block_receiver) }
        let!(:connection)    { double(:connection) }

        before do
          allow(nomad_client).to receive(:connection).and_return(connection)
        end

        describe '#status' do
          it 'should call get with on the stats endpoint' do
            expect(connection).to receive(:get).and_yield(block_receiver)
            expect(block_receiver).to receive(:url).with("client/stats")

            nomad_client.client.stats
          end
        end

        describe '#allocation' do
          it 'should call get with on the allocation endpoint' do
            allocation_id = '203266e5-e0d6-9486-5e05-397ed2b184af'

            expect(connection).to receive(:get).and_yield(block_receiver)
            expect(block_receiver).to receive(:url).with("client/allocation/#{allocation_id}/stats")

            nomad_client.client.allocation(allocation_id)
          end
        end

        describe '#read_file' do
          it 'should call get on the fs/cat endpoint with the alloc id and a path' do
            allocation_id    = '203266e5-e0d6-9486-5e05-397ed2b184af'
            read_file_params = {}
            path             = '/file.json'

            expect(connection).to receive(:get).and_yield(block_receiver)
            expect(block_receiver).to receive(:url).with("client/fs/cat/#{allocation_id}")
            allow(block_receiver).to receive(:params).and_return(read_file_params)
            expect(read_file_params).to receive(:[]=).with(:path, path)

            nomad_client.client.read_file(allocation_id, path: path)
          end
        end

        describe '#read_file_at_offset' do
          it 'should call get on the fs/readat endpoint with the alloc id, limit, offset, and a path' do
            allocation_id    = '203266e5-e0d6-9486-5e05-397ed2b184af'
            read_file_params = {}
            offset           = 10
            limit            = 100
            path             = '/file.json'

            expect(connection).to receive(:get).and_yield(block_receiver)
            expect(block_receiver).to receive(:url).with("client/fs/readat/#{allocation_id}")
            allow(block_receiver).to receive(:params).and_return(read_file_params)
            expect(read_file_params).to receive(:[]=).with(:limit, limit)
            expect(read_file_params).to receive(:[]=).with(:offset, offset)
            expect(read_file_params).to receive(:[]=).with(:path, path)

            nomad_client.client.read_file_at_offset(allocation_id, offset, limit, path: path)
          end
        end

        describe '#stream_file' do
          it 'should call get on the fs/stream endpoint with the alloc id, offset, origin, and a path' do
            allocation_id    = '203266e5-e0d6-9486-5e05-397ed2b184af'
            read_file_params = {}
            offset           = 10
            origin           = 'end'
            path             = '/file.json'

            expect(connection).to receive(:get).and_yield(block_receiver)
            expect(block_receiver).to receive(:url).with("client/fs/stream/#{allocation_id}")
            allow(block_receiver).to receive(:params).and_return(read_file_params)
            expect(read_file_params).to receive(:[]=).with(:offset, offset)
            expect(read_file_params).to receive(:[]=).with(:origin, origin)
            expect(read_file_params).to receive(:[]=).with(:path, path)

            nomad_client.client.stream_file(allocation_id, offset, origin: origin, path: path)
          end
        end

        describe '#stream_logs' do
          it 'should call get on the fs/logs endpoint with the alloc_id, task, follow, type, offset, origin, and plain param' do
            allocation_id    = '203266e5-e0d6-9486-5e05-397ed2b184af'
            task             = 'web'
            follow           = true
            plain            = true
            read_file_params = {}
            offset           = 10
            type             = 'stdout'
            origin           = 'start'

            expect(connection).to receive(:get).and_yield(block_receiver)
            expect(block_receiver).to receive(:url).with("client/fs/logs/#{allocation_id}")
            allow(block_receiver).to receive(:params).and_return(read_file_params)
            expect(read_file_params).to receive(:[]=).with(:task, task)
            expect(read_file_params).to receive(:[]=).with(:follow, follow)
            expect(read_file_params).to receive(:[]=).with(:type, type)
            expect(read_file_params).to receive(:[]=).with(:offset, offset)
            expect(read_file_params).to receive(:[]=).with(:origin, origin)
            expect(read_file_params).to receive(:[]=).with(:plain, plain)

            nomad_client.client.stream_logs(
              allocation_id,
              task,
              follow: follow,
              type: type,
              offset: offset,
              origin: origin,
              plain: plain
            )
          end
        end

      end
    end
  end
end
