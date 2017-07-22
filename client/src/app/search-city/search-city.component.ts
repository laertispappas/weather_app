import { Component, OnInit, Output, EventEmitter } from '@angular/core';

import {WeatherService} from '../services/weather.service';

@Component({
  selector: 'app-search-city',
  templateUrl: './search-city.component.html',
  styleUrls: ['./search-city.component.css']
})

export class SearchCityComponent implements OnInit {
  @Output() searchResult: EventEmitter<any> = new EventEmitter<any>();

  search;

  constructor(private _weatherService: WeatherService) {
    this.search = {
      city: "",
      country: ""
    }
  }

  ngOnInit() {
  }

  fetchWeather() {
    this._weatherService.getForecast(this.search).subscribe((weather) => {
      console.log(weather);
      this.searchResult.emit(weather)
    }, (error) => {
      // TODO handle error here with a notification service
      this.searchResult.emit(null)
      console.log(error);
    })
  }

}
