//
//  FavoriteVieModel.swift
//  MovieCatalogue
//
//  Created by Rasyid Ridla on 17/9/21.
//

import Foundation

class FavoriteViewModel: ObservableObject {
    
    let favoriteUseCase: FavoriteMoviesUseCase

    init(favoriteUseCase: FavoriteMoviesUseCase) {
        self.favoriteUseCase = favoriteUseCase
    }
    
}
