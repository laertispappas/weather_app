import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent implements OnInit {
  current: any;

  constructor() {
  }

  ngOnInit() {
    // TODO: Fetch a list weather on random cities
  }

  searchEvent(current) {
    this.current = current
    console.log(current)
  }

}
