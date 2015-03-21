require 'rails_helper'

describe Spree::BaseHelper, type: :helper do

  describe '#theme_class' do
    context 'current_store has a stylesheet' do
      it 'returns the stylesheets style class'
    end

    context 'current_store has no stylesheets' do
      it 'returns default'
    end
  end

  describe '#theme_logo' do
    context 'current_store has a stylesheet' do
      it 'returns the stylesheets logo path'
    end

    context 'current_store has no stylesheets' do
      it 'returns logo.png'
    end
  end

end
