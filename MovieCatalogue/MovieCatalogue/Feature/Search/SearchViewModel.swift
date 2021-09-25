//
//  SearchViewModel.swift
//  MovieCatalogue
//
//  Created by Rasyid Ridla on 17/9/21.
//

import Foundation
import Combine
import SwiftUI

class SearchViewModel: ObservableObject {
    
    enum State {
        case idle
        case loading
        case error(Error)
        case loaded
    }
    
    private var cancellables = Set<AnyCancellable>()
    private var searchMovieTemp : [MovieModel] = []
    
    @Published private(set) var state = State.idle
    @Published private(set) var searchMovies: [MovieModel] = []
    @Published var searchQueryText = String()
    @Published var pageSearch = 1
    
    private let searchUseCase: SearchUseCase
    init(searchUseCase: SearchUseCase) {
        self.searchUseCase = searchUseCase
        
        doSearchMovie()
    }
    
    // MARK: check if last page
    func isLastPage() -> Bool {
        if pageSearch == 2 && searchMovieTemp.count != 40 {
            return true
        } else if pageSearch == 3 && searchMovieTemp.count != 60 {
            return true
        }
        return false
    }
    
    // MARK: check if result is empty
    func isResultEmpty() -> Bool {
        if searchMovies.isEmpty && !searchQueryText.isEmpty {
            return true
        }
        return false
    }
    
    // MARK: check to show next page
    func isShowNextPage() -> Bool {
        if searchMovieTemp.count >= 20 {
            return true
        }
        return false
    }
    
    // MARK: doSearchMovie and map
    func doSearchMovie() {
        let searchQueryTemp = self.searchQueryText
        $searchQueryText
            .debounce(for: .milliseconds(800), scheduler: RunLoop.main)
            .removeDuplicates()
            .map({ (string) -> String? in
                if string.count < 1 {
                    self.searchMovies = []
                    return nil
                }
                
                return string
            })
            .compactMap {$0}
            .sink { (_) in
            } receiveValue: { [self] (searchField) in
                
                // MARK: check if query change
                if searchQueryTemp != searchField {
                    self.searchMovieTemp.removeAll()
                    self.searchMovies.removeAll()
                    self.pageSearch = 1
                }
                
                searchMovies(page: pageSearch, query: searchField)
            }.store(in: &cancellables)
    }
    
    // MARK: searchMoviesFrom Remote
    func searchMovies(page: Int, query: String) {
        self.state = .loading
        searchUseCase.searchMovie(page: page, query: query)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: {completion in
                switch completion {
                case .failure(let error):
                    self.state = .error(error)
                case .finished:
                    self.state = .loaded
                }
            }, receiveValue: {movies in
                
                self.searchMovieTemp.append(contentsOf: movies)
                
                if self.searchMovieTemp.count > 20 {
                    self.searchMovies.append(contentsOf: movies)
                } else {
                    self.searchMovies = movies
                }
                
            }).store(in: &cancellables)
    }
}
