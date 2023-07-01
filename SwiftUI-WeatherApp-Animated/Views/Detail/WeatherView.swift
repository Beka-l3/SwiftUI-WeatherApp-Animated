//
//  WeatherView.swift
//  SwiftUI-WeatherApp-Animated
//
//  Created by Bekzhan Talgat on 01.07.2023.
//

import SwiftUI

struct WeatherView: View {
    @State private var searchText: String = ""
    var searchResults: [Forecast] {
        searchText.isEmpty ? Forecast.cities : Forecast.cities.filter {
            $0.location.contains(searchText)
        }
    }
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    ForEach(searchResults) { forecast in
                        WeatherWidget(forecast: forecast)
                    }
                }
            }
            .safeAreaInset(edge: .top) {
                EmptyView()
                    .frame(height: 110)
            }
        }
        .overlay {
            NavigationBar(searchText: $searchText)
        }
        .toolbar(.hidden)
//        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search for a city or airport")
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WeatherView()
                .preferredColorScheme(.dark)
        }
    }
}
