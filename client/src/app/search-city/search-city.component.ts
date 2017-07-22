import { Component, OnInit, OnDestroy, Output, EventEmitter } from '@angular/core';
import { Router } from "@angular/router";
import { ActivatedRoute } from '@angular/router';

import {WeatherService} from '../services/weather.service';

@Component({
  selector: 'app-search-city',
  templateUrl: './search-city.component.html',
  styleUrls: ['./search-city.component.css']
})

export class SearchCityComponent implements OnInit, OnDestroy {
  private sub: any;
  search;
  result: any;

  constructor(private _weatherService: WeatherService, private router: Router, private route: ActivatedRoute) {
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
        this._weatherService.search(this.search).subscribe((city) => {
          this.result = city;
        },(error) => {
          // TODO: Notification service here
          console.log(error);
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
