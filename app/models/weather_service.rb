# frozen_string_literal: true

# This class is responsible for getting the weather data for a given location.
class WeatherService
  # Initialize a new WeatherService object.
  # @param latitude [Float] the latitude of the location to get weather data for
  # @param longitude [Float] the longitude of the location to get weather data for
  # @return [WeatherService] a new WeatherService object
  def initialize(latitude, longitude)
    @latitude = latitude
    @longitude = longitude
  end

  # Gets the weather type for the location.
  # @return [String] the weather type for the location
  def weather_type
    weather_codes[forecast.dig('current_weather', 'weathercode')] || 'Unknown'
  end

  # Gets the temperature for the location in degrees Celsius.
  # @return [Float] the temperature for the location in degrees Celsius
  def temperature
    forecast.dig('current_weather', 'temperature')
  end

  # Gets the wind speed for the location in meters per second.
  # @return [Float] the wind speed for the location in meters per second
  def wind_speed
    forecast.dig('current_weather', 'windspeed')
  end

  # Gets the wind direction for the location in degrees.
  # @return [Float] the wind direction for the location in degrees
  def wind_direction
    forecast.dig('current_weather', 'winddirection')
  end

  private

  def forecast
    @forecast ||= OpenMeteoClient.new.forecast(@latitude, @longitude)
  end

  def weather_codes
    @weather_codes = YAML.load_file('config/weather_codes.yml')
  end
end
