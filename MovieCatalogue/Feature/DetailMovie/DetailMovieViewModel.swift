//
//  DetailViewModel.swift
//  MovieCatalogue
//
//  Created by Rasyid Ridla on 17/9/21.
//

import Foundation

class DetailMovieViewModel: ObservableObject {
    
    let detailMovieUseCase: DetailUseCase
    
    init(detailUseCase: DetailUseCase) {
        self.detailMovieUseCase = detailUseCase
    }
    
}
