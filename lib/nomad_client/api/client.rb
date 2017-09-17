module NomadClient
  class Connection
    def client
      Api::Client.new(self)
    end
  end
  module Api
    class Client < Path

      ##
      # Query the actual resource usage of a Nomad client
      # https://www.nomadproject.io/docs/http/client-stats.html
      #
      # @return [Faraday::Response] A faraday response from Nomad
      def stats
        connection.get do |req|
          req.url "client/stats"
        end
      end

      ##
      # Query the actual resource usage of a Nomad client
      # https://www.nomadproject.io/docs/http/client-stats.html
      #
      # @param [String] id The ID of the allocation
      # @return [Faraday::Response] A faraday response from Nomad
      def allocation(id)
        connection.get do |req|
          req.url "client/allocation/#{id}/stats"
        end
      end

      ##
      # Reads the contents of a file in an allocation directory
      # https://www.nomadproject.io/docs/http/client-stats.html
      #
      # @param [String] alloc_id The allocation ID to query. This is specified as part of the URL.
      # Note, this must be the full allocation ID, not the short 8-character one. This is specified as part of the path.
      # @param [String] path The path of the file to read, relative to the root of the allocation directory
      # @return [Faraday::Response] A faraday response from Nomad
      def read_file(alloc_id, path: '/')
        connection.get do |req|
          req.url "client/fs/cat/#{alloc_id}"
          req.params[:path] = path
        end
      end

      ##
      # Reads the contents of a file in an allocation directory at a particular offset and limit.
      # https://www.nomadproject.io/docs/http/client-stats.html
      #
      # @param [String] alloc_id The allocation ID to query. This is specified as part of the URL.
      # Note, this must be the full allocation ID, not the short 8-character one. This is specified as part of the path.
      # @param [Integer] offset The byte offset from where content will be read
      # @param [Integer] limit The number of bytes to read from the offset
      # @param [String] path The path of the file to read, relative to the root of the allocation directory
      # @return [Faraday::Response] A faraday response from Nomad
      def read_file_at_offset(alloc_id, offset, limit, path: '/')
        connection.get do |req|
          req.url "client/fs/readat/#{alloc_id}"
          req.params[:offset] = offset
          req.params[:limit]  = limit
          req.params[:path]   = path
        end
      end

      ##
      # Streams the contents of a file in an allocation directory.
      # https://www.nomadproject.io/docs/http/client-stats.html
      #
      # @param [String] alloc_id The allocation ID to query. This is specified as part of the URL.
      # Note, this must be the full allocation ID, not the short 8-character one. This is specified as part of the path.
      # @param [Integer] offset The byte offset from where content will be read
      # @param [String] origin Applies the relative offset to either the start or end of the file
      # @param [String] path The path of the file to read, relative to the root of the allocation directory
      # @return [Faraday::Response] A faraday response from Nomad
      def stream_file(alloc_id, offset, origin: 'start', path: '/')
        connection.get do |req|
          req.url "client/fs/stream/#{alloc_id}"
          req.params[:offset] = offset
          req.params[:origin] = origin
          req.params[:path]   = path
        end
      end

      ##
      # Streams a task's stderr/stdout logs
      # https://www.nomadproject.io/docs/http/client-stats.html
      #
      # @param [String] alloc_id The allocation ID to query. This is specified as part of the URL.
      # Note, this must be the full allocation ID, not the short 8-character one. This is specified as part of the path.
      # @param [String] task the name of the task inside the allocation to stream logs from
      # @param [Boolean] follow Whether to tail the logs
      # @param [String] type Specifies the stream to stream
      # @param [Integer] offset The byte offset from where content will be read
      # @param [String] origin Applies the relative offset to either the start or end of the file
      # @param [Boolean] plain Return just the plain text without framing. This can be useful when viewing logs in a browser
      # @return [Faraday::Response] A faraday response from Nomad
      def stream_logs(alloc_id, task, follow: false, type: 'stdout', offset: 0, origin: 'start', plain: false)
        connection.get do |req|
          req.url "client/fs/stream/#{alloc_id}"
          req.params[:task]   = task
          req.params[:follow] = follow
          req.params[:type]   = type
          req.params[:offset] = offset
          req.params[:origin] = origin
          req.params[:plain]  = plain
        end
      end

      ##
      # Lists files in an allocation directory
      # https://www.nomadproject.io/docs/http/client-stats.html
      #
      # @param [String] alloc_id The allocation ID to query. This is specified as part of the URL.
      # Note, this must be the full allocation ID, not the short 8-character one. This is specified as part of the path.
      # @param [String] path The path of the file to read, relative to the root of the allocation directory
      # @return [Faraday::Response] A faraday response from Nomad
      def list_files(alloc_id, path: '/')
        connection.get do |req|
          req.url "client/fs/ls/#{alloc_id}"
          req.params[:path]   = path
        end
      end

      ##
      # Stats a file in an allocation
      # https://www.nomadproject.io/docs/http/client-stats.html
      #
      # @param [String] alloc_id The allocation ID to query. This is specified as part of the URL.
      # Note, this must be the full allocation ID, not the short 8-character one. This is specified as part of the path.
      # @param [String] path The path of the file to read, relative to the root of the allocation directory
      # @return [Faraday::Response] A faraday response from Nomad
      def stat_file(alloc_id, path: '/')
        connection.get do |req|
          req.url "client/fs/stat/#{alloc_id}"
          req.params[:path]   = path
        end
      end

    end
  end
end
