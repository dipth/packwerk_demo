# frozen_string_literal: true

# This class is responsible for geocoding a location
# using the Mapbox API.
class GeocodingService
  # Initialize a new Geocoder object.
  # @param location [String] the location to geocode
  # @return [GeocodingService] a new GeocodingService instance
  def initialize(location)
    @location = location
    @client = MapboxClient.new
  end

  # Gets the latitude of the location.
  # @return [Float] the latitude of the location
  def latitude
    mapbox_data['features'][0]['center'].last
  end

  # Gets the longitude of the location.
  # @return [Float] the longitude of the location
  def longitude
    mapbox_data['features'][0]['center'].first
  end

  # Gets the name of the location.
  # @return [String] the name of the location
  def place_name
    mapbox_data['features'][0]['place_name']
  end

  private

  def mapbox_data
    @mapbox_data ||= @client.geocode(@location)
  end
end
