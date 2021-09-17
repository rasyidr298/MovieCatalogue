//
//  MovieCatalogueApp.swift
//  MovieCatalogue
//
//  Created by Rasyid Ridla on 15/9/21.
//

import SwiftUI

@main
struct MovieCatalogueApp: App {
    
    private let homeUseCase = Injection().provideHome()
    private let favUseCase = Injection().provideFavorite()
    private let searchViewModel = Injection().provideSearch()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(HomeViewModel(homeUseCase: homeUseCase))
                .environmentObject(FavoriteViewModel(favoriteUseCase: favUseCase))
                .environmentObject(SearchViewModel(searchUseCase: searchViewModel))
        }
    }
}
