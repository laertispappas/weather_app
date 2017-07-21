def create_anuthorized_response
  json = <<-JSON
  {
    "cod": 401,
    "message":"Invalid API key. Please see http://openweathermap.org/faq#error401 for more info."
  }
  JSON

  JSON.parse(json)
end

def create_bad_request_payload
  json = <<-JSON
  {
    "cod":"400",
    "message": "Nothing to geocode"
  }
  JSON

  JSON.parse(json)
end

def create_weather_not_found
  json = <<-JSON
  {
    "cod": "404",
    "message": "city not found"
  }
  JSON

  JSON.parse(json)
end

def create_weather_payload(**kwargs)
  json = <<-JSON
  {
    "coord": {
      "lon": 23.72,
      "lat": 37.98
    },
    "weather": [
      {
        "id": 800,
        "main": "Clear",
        "description": "clear sky",
        "icon": "01d"
      }
    ],
    "base": "stations",
    "main": {
      "temp": 302.15,
      "pressure": 1012,
      "humidity": 21,
      "temp_min": 302.15,
      "temp_max": 302.15
    },
    "visibility": 10000,
    "wind": {
      "speed": 3.1,
      "deg": 340
    },
    "clouds": {
      "all": 0
    },
    "dt": 1500657600,
    "sys": {
      "type": 1,
      "id": 5675,
      "message": 0.0043,
      "country": "#{kwargs[:country] || "GR"}",
      "sunrise": 1500607183,
      "sunset": 1500658979
    },
    "id": #{kwargs[:id] || 1},
    "name": "#{kwargs[:name] || "Athens"}",
    "cod": 200
  }
  JSON

  JSON.parse(json)
end
