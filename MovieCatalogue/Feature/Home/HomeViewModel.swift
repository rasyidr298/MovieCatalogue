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
    
    private let homeUseCase: HomeUseCase
    
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var movies: [MovieModel] = []
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    
    init(homeUseCase: HomeUseCase) {
        self.homeUseCase = homeUseCase
    }
    
    func getPopularMovie(page: Int) {
        loadingState = true
        homeUseCase.getPopularMovie(page: page)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: {completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    self.loadingState = false
                }
            }, receiveValue: { movies in
                self.movies = movies
                print("popular movies : \(movies.count)")
            })
            .store(in: &cancellables)
    }
}
