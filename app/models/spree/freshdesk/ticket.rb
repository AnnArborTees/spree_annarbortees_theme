module Spree
  module Freshdesk
    class Ticket < Spree::Freshdesk::Base

      def self.new(params)
        action = "/helpdesk/tickets.json"
        Rails.cache.fetch(action, :expires => 1.hour) do
          response = post(action, basic_auth: {username: @@username, password: @@password }, body: params)

          if response.code == 200
            puts response.body, response.code, response.message, response.headers.inspect

            if JSON.parse(response.body)['require_login'] == true
              raise ActiveRecord::RecordNotSaved
            end

            return true
          else
            raise ActiveRecord::RecordNotSaved
          end
        end
      end

    end
  end
end