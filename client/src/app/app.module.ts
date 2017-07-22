import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { AppRoutingModule } from './app-routing.module';
import { HttpModule } from '@angular/http';

import { MaterializeModule } from 'angular2-materialize';

import { WeatherService } from './services/weather.service'
import { AlertService } from './services/alert.service'

import { AppComponent } from './app.component';
import { HomeComponent } from './home/home.component';
import { ToolbarComponent } from './toolbar/toolbar.component';
import { SearchCityComponent } from './search-city/search-city.component';
import { CityWeatherComponent } from './city-weather/city-weather.component';
import { CitiesListComponent } from './cities-list/cities-list.component';
import { AlertComponent } from './alert/alert.component';
import { PreloaderComponent } from './preloader/preloader.component';

@NgModule({
  declarations: [
    AppComponent,
    HomeComponent,
    ToolbarComponent,
    SearchCityComponent,
    CityWeatherComponent,
    CitiesListComponent,
    AlertComponent,
    PreloaderComponent
  ],
  imports: [
    BrowserModule,
    FormsModule,
    HttpModule,
    AppRoutingModule,
    MaterializeModule
  ],
  providers: [WeatherService, AlertService],
  bootstrap: [AppComponent]
})
export class AppModule { }
