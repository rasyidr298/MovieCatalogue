//
//  FavoriteVieModel.swift
//  MovieCatalogue
//
//  Created by Rasyid Ridla on 17/9/21.
//

import Foundation
import Combine

class FavoriteViewModel: ObservableObject {
    
    private var cancellables = Set<AnyCancellable>()
    @Published private(set) var favoriteMovies: [MovieModel] = []
    
    private let favoriteUseCase: FavoriteMoviesUseCase
    init(favoriteUseCase: FavoriteMoviesUseCase) {
        self.favoriteUseCase = favoriteUseCase
    }
    
    // MARK: getFavoriteMovies
    func getFavoriteMovies() {
        self.favoriteUseCase.getFavoriteMovies()
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("finished")
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { favorites in
                self.favoriteMovies = favorites
            }
            .store(in: &cancellables)
    }
    
}
