# [Weather App](https://arcane-plateau-13728.herokuapp.com/)

A simple Rails / Angular2 weather application that consumes data from [OpenWeatherMap API](http://openweathermap.org/API)

## Tasks

- [x] Display the weather at random geographic locations
- [x] Search city weather
- [x] Cache the fetched weather data

## Improvements

* Add more tests (API + Frontend)
* Improve API enpoint names and refactor front end as well
* Change search form to a dropdown select box with autocomplete of available cities
* Add memcache
* Dockerize the application
* Allow users to subscribe for weather notifications (via Email / Push / SMS) so they get alerts for weather conditions
* Documentation

## Installation

* Clone and change directory to the project

```bash
git clone https://github.com/laertispappas/weather_app
cd weather_app
```

* Bundle the project

```bash
bundle install
```

* Install JS dependencies in client folder

```bash
cd client
npm install
```

## Run locally

* Run rails application as usual
`rails s`

* Run angular application using ng cli
`cd client && ng serve`

* Navgate to `localhost:4200`

