//
//  TmdbRepository.swift
//  MovieCatalogue
//
//  Created by Rasyid Ridla on 16/9/21.
//

import Foundation
import Combine

protocol TmdbRepositoryProtocol {
    func getPopularMovie(page: Int) -> AnyPublisher<[MovieModel], Error>
    func getNowPlayingMovie(page: Int) -> AnyPublisher<[MovieModel], Error>
    func getTopRatedMovie(page: Int) -> AnyPublisher<[MovieModel], Error>
    func searchMovie(page: Int, query: String) -> AnyPublisher<[MovieModel], Error>
    func getDetailMovie(idMovie: Int) -> AnyPublisher<DetailMovieModel, Error>
}

final class TmdbRepository: NSObject {
    
    typealias TmdbInstance = (RemoteDataSource) -> TmdbRepository
    
    fileprivate let remote: RemoteDataSource
    
    private init(remote: RemoteDataSource) {
        self.remote = remote
    }
    
    static let sharedInstance: TmdbInstance = { remoteRepo in
        return TmdbRepository(remote: remoteRepo)
    }
}

extension TmdbRepository: TmdbRepositoryProtocol {
    
    // MARK: getPopularMovie
    func getPopularMovie(page: Int) -> AnyPublisher<[MovieModel], Error> {
        return self.remote.getPopularMovie(page: page).map {
            MovieMapper.mapMovieToDomains(input: $0)
        }.eraseToAnyPublisher()
    }
    
    // MARK: getNowPlayingMovie
    func getNowPlayingMovie(page: Int) -> AnyPublisher<[MovieModel], Error> {
        return self.remote.getNowPlayingMovie(page: page).map {
            MovieMapper.mapMovieToDomains(input: $0)
        }.eraseToAnyPublisher()
    }
    
    // MARK: getTopRatedMovie
    func getTopRatedMovie(page: Int) -> AnyPublisher<[MovieModel], Error> {
        return self.remote.getTopRatedMovie(page: page).map {
            MovieMapper.mapMovieToDomains(input: $0)
        }.eraseToAnyPublisher()
    }
    
    // MARK: getDetailMovie
    func getDetailMovie(idMovie: Int) -> AnyPublisher<DetailMovieModel, Error> {
        Publishers.Zip(self.remote.getDetailMovie(idMovie: idMovie), self.remote.getCreditMovie(idMovie: idMovie))
          .map { (detailResponse, creditResponse) in
            MovieMapper.mapDetailMovieResponseToDomains(movieResponse: detailResponse, creditResponse: creditResponse)
          }
          .eraseToAnyPublisher()
    }
    
    // MARK: searchMovie
    func searchMovie(page: Int, query: String) -> AnyPublisher<[MovieModel], Error> {
        return self.remote.searchMovie(page: page, query: query).map {
            MovieMapper.mapMovieToDomains(input: $0)
        }.eraseToAnyPublisher()
    }
    
}
