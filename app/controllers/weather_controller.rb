# frozen_string_literal: true

# This controller is responsible for showing the weather for a given location.
# It uses the GeocodingService and WeatherService classes to get the weather data.
class WeatherController < ApplicationController
  def new; end

  def create
    redirect_to weather_path(params[:location].downcase)
  end

  def show
    @place_name = geocoding_service.place_name
    @weather_type = weather_service.weather_type
    @temperature = weather_service.temperature
    @wind_speed = weather_service.wind_speed
    @wind_direction = weather_service.wind_direction
  end

  private

  def geocoding_service
    @geocoding_service ||= GeocodingService.new(params[:id])
  end

  def weather_service
    latitude = geocoding_service.latitude
    longitude = geocoding_service.longitude

    @weather_service ||= WeatherService.new(latitude, longitude)
  end
end
