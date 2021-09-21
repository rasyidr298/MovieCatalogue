//
//  MovieCatalogueApp.swift
//  MovieCatalogue
//
//  Created by Rasyid Ridla on 15/9/21.
//

import SwiftUI

@main
struct MovieCatalogueApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(HomeViewModel(homeUseCase: Injection().provideHome()))
                .environmentObject(FavoriteViewModel(favoriteUseCase: Injection().provideFavorite()))
                .environmentObject(SearchViewModel(searchUseCase: Injection().provideSearch()))
                .environmentObject(ViewRouter())
        }
    }
}
