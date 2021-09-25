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
    
    @Published var pageTopRated = 1
    @Published private(set) var state = State.idle
    @Published var popularMovies: [MovieModel] = []
    @Published var nowPlayingMovies: [MovieModel] = []
    @Published var topRatedMovies: [MovieModel] = []
    
    private var cancellables: Set<AnyCancellable> = []
    
    private let homeUseCase: HomeUseCase
    init(homeUseCase: HomeUseCase) {
        self.homeUseCase = homeUseCase
        
        getPopularMovie(page: 1)
        getNowPlaingMovie(page: 1)
        getTopRatedMovie(page: pageTopRated)
    }
    
    // MARK: check if last page
    func isLastPage() -> Bool {
        if pageTopRated == 1 && topRatedMovies.count != 20 {
            return true
        } else if pageTopRated == 2 && topRatedMovies.count != 40 {
            return true
        } else if pageTopRated == 3 && topRatedMovies.count != 60 {
            return true
        } else if pageTopRated == 4 && topRatedMovies.count != 80 {
            return true
        } else {
            return false
        }
    }
    
    // MARK: getPopularMovie
    func getPopularMovie(page: Int) {
        self.state = .loading
        homeUseCase.getPopularMovie(page: page)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: {completion in
                switch completion {
                case .failure(let error):
                    self.state = .error(error)
                case .finished:
                    self.state = .loaded
                }
            }, receiveValue: { movies in
                self.popularMovies = movies.shuffled()
            })
            .store(in: &cancellables)
    }
    
    // MARK: getNowPlaingMovie
    func getNowPlaingMovie(page: Int) {
        self.state = .loading
        homeUseCase.getPopularMovie(page: page)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: {completion in
                switch completion {
                case .failure(let error):
                    self.state = .error(error)
                case .finished:
                    self.state = .loaded
                }
            }, receiveValue: { movies in
                self.nowPlayingMovies = movies.shuffled()
            })
            .store(in: &cancellables)
    }
    
    // MARK: getTopRatedMovie
    func getTopRatedMovie(page: Int) {
        self.state = .loading
        homeUseCase.getPopularMovie(page: page)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: {completion in
                switch completion {
                case .failure(let error):
                    self.state = .error(error)
                case .finished:
                    self.state = .loaded
                }
            }, receiveValue: { movies in
                self.topRatedMovies.append(contentsOf: movies)
            })
            .store(in: &cancellables)
    }
}
