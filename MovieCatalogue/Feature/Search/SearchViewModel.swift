//
//  SearchViewModel.swift
//  MovieCatalogue
//
//  Created by Rasyid Ridla on 17/9/21.
//

import Foundation

class SearchViewModel: ObservableObject {
    
    let searchUseCase: SearchUseCase
    
    init(searchUseCase: SearchUseCase) {
        self.searchUseCase = searchUseCase
    }
}
