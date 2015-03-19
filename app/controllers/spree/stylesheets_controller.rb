module Spree
  class StylesheetsController < Spree::StoreController
    before_filter :load_stylesheet, :only => :show



    def show
    end

    private

    def load_stylesheet
      @stylesheet = Spree::Stylesheet.find(params[:id])
    end
  end
end