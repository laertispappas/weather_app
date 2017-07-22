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
    "name": "#{kwargs[:city] || "Athens"}",
    "cod": 200
  }
  JSON

  JSON.parse(json)
end

def create_forecast_response(**kwargs)
  json = <<-JSON
  {
    "city": {
      "id": 1851632,
      "name": "#{kwargs[:city] || "Shuzenji"}",
      "coord": {
        "lon": 138.933334,
        "lat": 34.966671
      },
     "country": "#{kwargs[:country] || "JS"}"
     },
      "cod": "200",
      "message": 0.0045,
      "cnt": 38,
      "list": [
      {
        "dt": 1406106000,
        "main": {
        "temp": 298.77,
        "temp_min": 298.77,
        "temp_max": 298.774,
        "pressure": 1005.93,
        "sea_level": 1018.18,
        "grnd_level": 1005.93,
        "humidity": "87",
        "temp_kf": 0.26
      },
      "weather": [
        {
          "id": 804,
          "main": "Clouds",
          "description": "overcast clouds",
          "icon": "04d"
        }
      ],
      "clouds": {
        "all": 88
      },
      "wind": {
        "speed": 5.71,
        "deg": 229.501
      },
      "sys": {
        "pod": "d"
      },
      "dt_txt": "2014-07-23 09:00:00"
      },
      {
        "dt": 1406106000,
        "main": {
        "temp": 298.77,
        "temp_min": 298.77,
        "temp_max": 298.774,
        "pressure": 1005.93,
        "sea_level": 1018.18,
        "grnd_level": 1005.93,
        "humidity": "87",
        "temp_kf": 0.26
      },
      "weather": [
        {
          "id": 804,
          "main": "Clouds2",
          "description": "overcast clouds2",
          "icon": "05d"
        }
      ],
      "clouds": {
        "all": 88
      },
      "wind": {
        "speed": 5.71,
        "deg": 229.501
      },
      "sys": {
        "pod": "d"
      },
      "dt_txt": "2014-07-23 12:00:00"
      }
    ]
    }
  JSON

  JSON.parse(json)
end
