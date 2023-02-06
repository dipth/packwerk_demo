# frozen_string_literal: true

# This class is responsible for making requests to the Open-Meteo API.
class OpenMeteoClient
  include HTTParty
  base_uri 'https://api.open-meteo.com'

  # Gets the current weather data for a given latitude and longitude.
  # @param latitude [Float] the latitude of the location
  # @param longitude [Float] the longitude of the location
  # @return [Hash] the weather data for the location
  def forecast(latitude, longitude)
    self.class.get("/v1/forecast?latitude=#{latitude}&longitude=#{longitude}&current_weather=true")
  end
end
