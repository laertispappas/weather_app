import { Component, OnInit, OnDestroy, Output, EventEmitter } from '@angular/core';
import { Router } from "@angular/router";
import { ActivatedRoute } from '@angular/router';

import {WeatherService} from '../services/weather.service';
import {AlertService} from '../services/alert.service';

@Component({
  selector: 'app-search-city',
  templateUrl: './search-city.component.html',
  styleUrls: ['./search-city.component.css']
})

export class SearchCityComponent implements OnInit, OnDestroy {
  private sub: any;
  search;
  result: any;
  loading: boolean;

  constructor(private _weatherService: WeatherService,
              private _alertService: AlertService,
              private router: Router,
              private route: ActivatedRoute) {
    this.search = {
      city: "",
      country: ""
    }
  }

  ngOnInit() {
    this.sub = this.route.params.subscribe(params => {
      this.search.city = params['city'];
      this.search.country = params['country'];

      if(this.search.city || this.search.country) {
        this.loading = true;

        this._weatherService.search(this.search).subscribe((city) => {
          this.result = city;
          this.loading = false;
        },(error) => {
          this.result = null;
          this.loading = false;
          this._alertService.error(error.json().error);
        });
      }
    })
  }

  ngOnDestroy() {
    this.sub.unsubscribe();
  }

  navigate() {
    this.router.navigate(["/search", this.search.country, this.search.city]);
  }

}
