//
//  DetailViewModel.swift
//  MovieCatalogue
//
//  Created by Rasyid Ridla on 17/9/21.
//

import Foundation
import Combine

class DetailMovieViewModel: ObservableObject {
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published private(set) var movie: MovieModel
    @Published private(set) var detailMovie: DetailMovieModel = DetailMovieModel.default
    @Published private(set) var isLoading = false
    @Published private(set) var isFavorite = false
    @Published private(set) var messageInfo = ""
    @Published private(set) var sfSymbolInfo = ""
    @Published var showingInfo = false
    
    private let detailMovieUseCase: DetailUseCase
    init(detailUseCase: DetailUseCase) {
        self.detailMovieUseCase = detailUseCase
        movie = detailUseCase.getMovie()
    }
    
    // MARK: getDetailMovie
    func getDetailMovie() {
        isLoading = true
        self.detailMovieUseCase.getDetailMovie(idMovie: movie.id)
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case .finished:
                    self.isLoading = false
                case .failure(let error):
                    print("error \(error.localizedDescription)")
                }
            } receiveValue: { value in
                self.detailMovie = value
            }
            .store(in: &cancellables)
    }
    
    // MARK: addMovieToFavorite
    func addMovieToFavorite() {
        self.detailMovieUseCase.addMovieToFavorite(movie: movie)
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case .finished:
                    self.showingInfo = true
                    self.messageInfo = "Added to Favorite"
                    self.sfSymbolInfo = "checkmark"
                case .failure:
                    self.showingInfo = true
                    self.messageInfo = "Failed add Favorite"
                    self.sfSymbolInfo = "xmark.circle"
                }
            } receiveValue: { value in
                self.isFavorite = value
            }
            .store(in: &cancellables)
    }
    
    // MARK: deleteFavorite
    func deleteFavorite() {
        self.detailMovieUseCase.deleteMovieFromFavorite(movie: movie)
            .sink { completion in
                switch completion {
                case .finished:
                    print("Finished")
                case .failure(let error):
                    assertionFailure(error.localizedDescription)
                }
            } receiveValue: { value in
                self.isFavorite = !value
            }
            .store(in: &cancellables)
    }
    
    // MARK: checkIsFavorite
    func checkIsFavorite() {
        self.detailMovieUseCase.movieIsFavorite(movie: movie)
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("Finished")
                case .failure(let error):
                    assertionFailure(error.localizedDescription)
                }
            } receiveValue: { value in
                self.isFavorite = value
            }
            .store(in: &cancellables)
    }
}
