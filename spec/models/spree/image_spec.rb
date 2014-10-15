require 'spec_helper'

describe Spree::Image, image_spec: true, story_142: true do
  it { is_expected.to belong_to :option_value }
end