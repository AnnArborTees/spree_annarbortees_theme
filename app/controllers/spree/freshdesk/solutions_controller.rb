module Spree
  module Freshdesk
    class SolutionsController < Spree::StoreController
      before_filter :prepare_data


      def index

      end

      def show

      end

      private

      def prepare_data
        @categories = Spree::Freshdesk::SolutionCategory.all
        @categories.reject! do |category|
          category.folders.reject!{|folder| folder['visibility'] != 1 }
          category.folders.count == 0
        end

        @articles = {}
        @categories.each do |category|
          category.folders.each do |folder|
            @articles[folder['id']] = Spree::Freshdesk::Article.all(category.id, folder['id'])
          end
        end
      end
    end
  end
end