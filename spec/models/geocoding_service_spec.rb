# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GeocodingService, type: :model do
  subject(:service) { described_class.new(location) }

  let(:location) { 'Copenhagen, Denmark' }
  let(:client) { instance_double(MapboxClient) }
  let(:mapbox_data) do
    {
      'features' => [
        {
          'center' => [12.568337, 55.676098],
          'place_name' => 'Copenhagen, Denmark'
        }
      ]
    }
  end

  before do
    allow(MapboxClient).to receive(:new).and_return(client)
    allow(client).to receive(:geocode).with(location).and_return(mapbox_data)
  end

  describe '#latitude' do
    it 'returns the latitude of the location' do
      expect(service.latitude).to eq(55.676098)
    end
  end

  describe '#longitude' do
    it 'returns the longitude of the location' do
      expect(service.longitude).to eq(12.568337)
    end
  end

  describe '#place_name' do
    it 'returns the name of the location' do
      expect(service.place_name).to eq('Copenhagen, Denmark')
    end
  end
end
