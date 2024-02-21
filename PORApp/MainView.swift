//
//  MainView.swift
//  PORApp
//
//  Created by ituser on 1/31/24.
//

import SwiftUI

struct MainView: View {
    var parkData = ParkData()
    var weatherViewModel = WeatherViewModel()
    @State var parks :  [Park] = []
    @State var weatherData : WeatherData?
    var body: some View {
        TabView {
            ParksView(parks: $parks)
                .tabItem { Label("Stations", systemImage: "figure.walk") }
            FavoritesView()
                .tabItem { Label("Favorites", systemImage: "book.fill") }
            NearestView(parks: $parks)
                .tabItem { Label("Map", systemImage: "location.fill.viewfinder") }
            WeatherView(weatherData: weatherData)
                .tabItem { Label("News", systemImage: "newspaper") }
            MyView()
                .tabItem { Label("Profile", systemImage: "person.fill") }
        }
        .onAppear() {
            parkData.fetch({
                parks in
                print("draw park informations")
                self.parks = parks
            })
            
            weatherViewModel.fetchWeatherData(completion: {
                weather in
                self.weatherData = weather
            })
        }
    }
}

struct MainView_Preview : PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
