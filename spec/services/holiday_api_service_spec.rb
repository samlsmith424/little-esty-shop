require 'rails_helper'
# require 'rubygems'
# require 'test/unit'
require 'vcr'

RSpec.describe 'holiday api services' do
  it 'can find the next three US holidays' do
    VCR.use_cassette('holiday api') do
      holidays = HolidayApiService.holidays

      expect(holidays).to be_a(Array)
    end
  end
end
