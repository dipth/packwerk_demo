# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WeatherController, type: :controller do
  describe 'GET #new' do
    it 'returns a successful response' do
      get :new
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    it 'redirects to the weather page with the posted location' do
      post :create, params: { location: 'Copenhagen' }
      expect(response).to redirect_to(weather_path('copenhagen'))
    end

    it 'correctly handles complex locations' do
      post :create, params: { location: 'Sønderborg, Denmark' }
      expect(response).to redirect_to('http://test.host/weather/s%C3%B8nderborg,%20denmark')
    end
  end

  describe 'GET #show' do
    let(:weather_service) { instance_double(WeatherService) }
    let(:geocoding_service) { instance_double(GeocodingService) }
    let(:location) { 's%25c3%25b8nderborg%252c%2520denmark' }
    let(:latitude) { 54.9 }
    let(:longitude) { 9.8 }

    before do
      allow(GeocodingService).to receive(:new).with(location).and_return(geocoding_service)
      allow(WeatherService).to receive(:new).with(latitude, longitude).and_return(weather_service)
      allow(geocoding_service).to receive(:latitude).and_return(latitude)
      allow(geocoding_service).to receive(:longitude).and_return(longitude)
      allow(geocoding_service).to receive(:place_name).and_return('Sønderborg, Denmark')
      allow(weather_service).to receive(:weather_type).and_return('Partly Cloudy')
      allow(weather_service).to receive(:temperature).and_return(0.6)
      allow(weather_service).to receive(:wind_speed).and_return(9.4)
      allow(weather_service).to receive(:wind_direction).and_return(44.0)
    end

    it 'returns a successful response' do
      get :show, params: { id: location }
      expect(response).to be_successful
    end

    it 'assigns the place name' do
      get :show, params: { id: location }
      expect(assigns(:place_name)).to eq('Sønderborg, Denmark')
    end

    it 'assigns the weather type' do
      get :show, params: { id: location }
      expect(assigns(:weather_type)).to eq('Partly Cloudy')
    end

    it 'assigns the temperature' do
      get :show, params: { id: location }
      expect(assigns(:temperature)).to eq(0.6)
    end

    it 'assigns the wind speed' do
      get :show, params: { id: location }
      expect(assigns(:wind_speed)).to eq(9.4)
    end

    it 'assigns the wind direction' do
      get :show, params: { id: location }
      expect(assigns(:wind_direction)).to eq(44.0)
    end
  end
end
