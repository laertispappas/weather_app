import { Injectable }    from '@angular/core';
import { Headers, Http } from '@angular/http';

import {environment} from "../..//environments/environment";

import 'rxjs/add/operator/map'

@Injectable()
export class WeatherService {
    private url = environment.apiBase + 'weather'
    private forecastUrl = environment.apiBase + 'forecast'
    private citiesUrl = environment.apiBase + 'cities'

    constructor(private _http: Http){
    }

    // @return Observable
    getWeather(search){
      return this._http.get(this.url, { search: search })
        .map(res => res.json())
    }

    search(object) {
      return this._http.get(this.forecastUrl, { params: object })
        .map(res => res.json())
    }

    getCities() {
      return this._http.get(this.citiesUrl).
        map(res => res.json());
    }
}
