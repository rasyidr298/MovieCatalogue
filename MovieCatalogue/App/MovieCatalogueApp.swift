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
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(HomeViewModel(homeUseCase: homeUseCase))
        }
    }
}
