module Spree
  module Freshdesk
    class Article < Spree::Freshdesk::Base

      def self.all(category, folder)
        action = "/solution/categories/#{category}/folders/#{folder}.json"
        Rails.cache.fetch(action, :expires => 1.hour) do
          response = get(action, options)

          if response.code == 200
            # puts response.body, response.code, response.message, response.headers.inspect
          else
            raise ActiveRecord::RecordNotFound
          end

          body = JSON.parse(response.body)
          body['folder']['articles'].map{ |article| OpenStruct.new(article) }
        end
      end

      def self.find(category, folder, id)
        action = "/solution/categories/#{category}/folders/#{folder}/#{id}.json"
        Rails.cache.fetch(action, :expires => 1.hour) do
          response = get(action, options)

          if response.code == 200
            # puts response.body, response.code, response.message, response.headers.inspect
          else
            raise ActiveRecord::RecordNotFound
          end

          body = JSON.parse(response.body)
          OpenStruct.new(body['article'])
        end
      end

    end
  end
end