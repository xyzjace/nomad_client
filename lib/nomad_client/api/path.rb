module NomadClient
  module Api
    class Path
      attr_accessor :client

      def initialize(client)
        @client = client
      end

      def connection
        @client.connection
      end

    end
  end
end
