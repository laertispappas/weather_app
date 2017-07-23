import { Component, OnInit, OnDestroy } from '@angular/core';
import { Router } from "@angular/router";
import { ActivatedRoute } from '@angular/router';

import {WeatherService} from '../services/weather.service';
import {AlertService} from '../services/alert.service';

@Component({
  selector: 'app-city',
  templateUrl: './city.component.html',
  styleUrls: ['./city.component.css']
})
export class CityComponent implements OnInit, OnDestroy {
  private sub: any;
  city: any;

  constructor(private _weatherService: WeatherService,
              private _alertService: AlertService,
              private router: Router,
              private route: ActivatedRoute) {
  }

  ngOnInit() {
    this.sub = this.route.params.subscribe(params => {
      this._weatherService.search({id: params['id']}).subscribe((city) => {
        this.city = city;
      },(error) => {
        this.city = null;
        this._alertService.error(error.json().error);
      });
    })
  }

  ngOnDestroy() {
    this.sub.unsubscribe();
  }

}
