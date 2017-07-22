import { Component, OnInit, Input } from '@angular/core';

@Component({
  selector: 'app-city-weather',
  templateUrl: './city-weather.component.html',
  styleUrls: ['./city-weather.component.css']
})
export class CityWeatherComponent implements OnInit {
  @Input() current:any;

  constructor() { }

  ngOnInit() {
  }

}
