require 'httparty'

module Spree
  module Freshdesk
    class Base
      include HTTParty
      base_uri  Rails.configuration.freshdesk_base_uri
      @@username = Rails.configuration.freshdesk_api_key
      @@password = 'X'

      def initialize
        @options = options
      end

      def options
        Spree::Freshdesk::Base.options
      end

      def self.options
        { basic_auth: {username: @@username, password: @@password } }
      end

    end
  end
end