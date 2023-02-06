# frozen_string_literal: true

# This class is responsible for making requests to the Mapbox API.
class MapboxClient
  include HTTParty
  base_uri 'https://api.mapbox.com'

  # Initialize a new MapboxClient object.
  def initialize
    @token = Rails.application.credentials.mapbox.token
  end

  # Gets the geocoding data for a location.
  # @param location [String] the location to geocode
  # @return [Hash] the geocoding data for the location
  def geocode(location)
    encoded_location = ERB::Util.url_encode(location)
    result = self.class.get("/geocoding/v5/mapbox.places/#{encoded_location}.json?access_token=#{@token}")
    JSON.parse result
  end
end
