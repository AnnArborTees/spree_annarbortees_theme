require 'spec_helper'

feature "Spreadsheets" do
  context 'as an admin' do
    scenario 'you can create a spreadsheet and assign it to a store'
    scenario 'you can edit a spreadsheet'
  end

  context 'without a spreadsheet' do
    scenario 'the store uses the default stylesheet'
  end

  context 'with a spreadsheet' do
    scenario 'the store uses the first spreadsheet assigned to it'
  end

  context 'when a spreadsheet is changed' do
    scenario 'it resets the cached view'
  end
end