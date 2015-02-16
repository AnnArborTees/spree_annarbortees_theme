FactoryGirl.define do
  # Define your Spree extensions Factories within this file to enable applications, and other extensions to use and override them.
  #
  # Example adding this to your spec_helper will load these Factories for use:
  # require 'spree_annarbortees_theme/factories'

  factory :default_store_for_theme_testing, class: Spree::Store do
    name 'Test Store'
    code 'test'
    domains 'test.aatc.com'
    default 1
    email 'support@aatc.com'
    default_currency 'USD'
  end
end
