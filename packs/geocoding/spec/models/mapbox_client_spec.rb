# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MapboxClient, type: :model do
  describe '#geocode', :vcr do
    it 'returns geocoding data for a location' do
      client = MapboxClient.new
      result = client.geocode('Copenhagen, Denmark')
      expect(result['features'][0]['place_name']).to eq('København, Capital Region of Denmark, Denmark')
    end
  end
end
