# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WeatherService, type: :model do
  subject(:service) { described_class.new(latitude, longitude) }

  let(:latitude) { 55.676098 }
  let(:longitude) { 12.568337 }
  let(:client) { instance_double(OpenMeteoClient) }
  let(:forecast) do
    {
      'current_weather' => {
        'weathercode' => 2,
        'temperature' => 0.6,
        'windspeed' => 9.4,
        'winddirection' => 44.0
      }
    }
  end

  before do
    allow(OpenMeteoClient).to receive(:new).and_return(client)
    allow(client).to receive(:forecast).with(latitude, longitude).and_return(forecast)
  end

  describe '#weather_type' do
    it 'returns the weather type' do
      expect(service.weather_type).to eq('Partly Cloudy')
    end
  end

  describe '#temperature' do
    it 'returns the temperature' do
      expect(service.temperature).to eq(0.6)
    end
  end

  describe '#wind_speed' do
    it 'returns the wind speed' do
      expect(service.wind_speed).to eq(9.4)
    end
  end

  describe '#wind_direction' do
    it 'returns the wind direction' do
      expect(service.wind_direction).to eq(44.0)
    end
  end
end
