import { Component, OnInit } from '@angular/core';

import {WeatherService} from '../services/weather.service';
import {AlertService} from '../services/alert.service';

@Component({
  selector: 'app-cities-list',
  templateUrl: './cities-list.component.html',
  styleUrls: ['./cities-list.component.css']
})
export class CitiesListComponent implements OnInit {
  cities: Array<any>;
  loading: boolean;

  constructor(private _weatherService: WeatherService,
              private _alertService: AlertService) {
  }

  ngOnInit() {
    this.loading = true;
    this._weatherService.getCities().subscribe((cities) => {
      this.cities = cities;
      this.loading = false;
    }, (error) => {
      this.loading = false;
      this._alertService.error(error.json().error);
    })
  }

}
