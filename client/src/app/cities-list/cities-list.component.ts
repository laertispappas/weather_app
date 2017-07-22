import { Component, OnInit } from '@angular/core';

import {WeatherService} from '../services/weather.service';

@Component({
  selector: 'app-cities-list',
  templateUrl: './cities-list.component.html',
  styleUrls: ['./cities-list.component.css']
})
export class CitiesListComponent implements OnInit {
  cities: Array<any>;

  constructor(private _weatherService: WeatherService) {
  }

  ngOnInit() {
    this._weatherService.getCities().subscribe((cities) => {
      this.cities = cities;
    }, (error) => {
      // TODO: handle error here with notification service
      console.log(error);
    })
  }

}
