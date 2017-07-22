import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent implements OnInit {
  current: any;
  cities: any[] = [];

  constructor() {
  }

  ngOnInit() {
  }

  searchEvent(current) {
    this.current = current
  }
}
