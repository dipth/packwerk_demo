# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OpenMeteoClient, type: :model do
  describe '#forecast', :vcr do
    it 'returns forecast data for a location with the given coordinates' do
      client = OpenMeteoClient.new
      result = client.forecast(55.676098, 12.568337)
      expect(result.dig('current_weather', 'weathercode')).to eq(2)
      expect(result.dig('current_weather', 'temperature')).to eq(0.6)
      expect(result.dig('current_weather', 'windspeed')).to eq(9.4)
      expect(result.dig('current_weather', 'winddirection')).to eq(44.0)
    end
  end
end
