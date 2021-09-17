//
//  HomeViewModel.swift
//  MovieCatalogue
//
//  Created by Rasyid Ridla on 16/9/21.
//

import Foundation
import Combine
import SwiftUI

class HomeViewModel: ObservableObject {
    
    enum State {
      case idle
      case loading
      case error(Error)
      case loaded
    }
    
    @Published private(set) var state = State.idle
    @Published var popularMovies: [MovieModel] = []
    @Published var nowPlayingMovies: [MovieModel] = []
    @Published var topRatedMovies: [MovieModel] = []
    
    private var homeRouter = HomeRouter()
    private var cancellables: Set<AnyCancellable> = []
    
    private let homeUseCase: HomeUseCase
    init(homeUseCase: HomeUseCase) {
        self.homeUseCase = homeUseCase
    }
    
    func getPopularMovie(page: Int) {
//        loadingState = true
        homeUseCase.getPopularMovie(page: page)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: {completion in
                switch completion {
                case .failure:
//                    self.errorMessage = String(describing: completion)
                case .finished:
//                    self.loadingState = false
                }
            }, receiveValue: { movies in
                self.movies = movies
                print("popular movies : \(movies.count)")
            })
            .store(in: &cancellables)
    }
}
