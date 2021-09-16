//
//  HomeUseCase.swift
//  MovieCatalogue
//
//  Created by Rasyid Ridla on 16/9/21.
//

import Foundation
import Combine

protocol HomeUseCase {
    func getPopularMovie(page: Int) -> AnyPublisher<[MovieModel], Error>
    func getNowPlayingMovie(page: Int) -> AnyPublisher<[MovieModel], Error>
    func getTopRatedMovie(page: Int) -> AnyPublisher<[MovieModel], Error>
    func searchMovie(page: Int, query: String) -> AnyPublisher<[MovieModel], Error>
    func getDetailMovie(idMovie: Int) -> AnyPublisher<DetailMovieModel, Error>
}

class HomeInteractor: HomeUseCase {
    
    private let repository: TmdbRepository
    
    required init(repository: TmdbRepository) {
      self.repository = repository
    }
    
    // MARK: getPopularMovie
    func getPopularMovie(page: Int) -> AnyPublisher<[MovieModel], Error> {
        return repository.getPopularMovie(page: page)
    }
    
    // MARK: getNowPlayingMovie
    func getNowPlayingMovie(page: Int) -> AnyPublisher<[MovieModel], Error> {
        return repository.getNowPlayingMovie(page: page)
    }
    
    // MARK: getTopRatedMovie
    func getTopRatedMovie(page: Int) -> AnyPublisher<[MovieModel], Error> {
        return repository.getTopRatedMovie(page: page)
    }
    
    // MARK: getDetailMovie
    func getDetailMovie(idMovie: Int) -> AnyPublisher<DetailMovieModel, Error> {
        return repository.getDetailMovie(idMovie: idMovie)
    }
    
    // MARK: searchMovie
    func searchMovie(page: Int, query: String) -> AnyPublisher<[MovieModel], Error> {
        return repository.searchMovie(page: page, query: query)
    }
    
}
