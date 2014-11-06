module Spree
  module Freshdesk
    class SolutionCategory < Spree::Freshdesk::Base

      def self.all
        action = '/solution/categories.json'
        Rails.cache.fetch(action, :expires => 1.hour) do
          response = get(action, options)

          if response.code == 200
            # puts response.body, response.code, response.message, response.headers.inspect
          else
            raise ActiveRecord::RecordNotFound
          end

          body = JSON.parse(response.body)
          body.map{|category| OpenStruct.new(category['category']) }
        end
      end

      def self.find(id)
        action = "/solution/categories/#{id}.json"
        Rails.cache.fetch(action, :expires => 1.hour) do
          response = get(action, options)

          if response.code == 200
            # puts response.body, response.code, response.message, response.headers.inspect
          else
            raise ActiveRecord::RecordNotFound
          end

          body = JSON.parse(response.body)
          OpenStruct.new(body['category'])
        end
      end

    end
  end
end