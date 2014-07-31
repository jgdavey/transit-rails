require 'spec_helper'
require 'transit/rails/version'

describe Transit::Rails do
  it 'has a version number' do
    expect(Transit::Rails::VERSION).not_to be nil
  end
end
