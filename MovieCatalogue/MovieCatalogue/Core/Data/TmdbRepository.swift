//
//  TmdbRepository.swift
//  MovieCatalogue
//
//  Created by Rasyid Ridla on 16/9/21.
//

import Foundation
import Combine

protocol TmdbRepositoryProtocol {
    
    // MARK: Remote
    func getPopularMovie(page: Int) -> AnyPublisher<[MovieModel], Error>
    func getNowPlayingMovie(page: Int) -> AnyPublisher<[MovieModel], Error>
    func getTopRatedMovie(page: Int) -> AnyPublisher<[MovieModel], Error>
    func searchMovie(page: Int, query: String) -> AnyPublisher<[MovieModel], Error>
    func getDetailMovie(idMovie: Int) -> AnyPublisher<DetailMovieModel, Error>
    
    // MARK: Locale
    func getFavoriteMovies() -> AnyPublisher<[MovieModel], Error>
    func addMovieToFavorite(from movie: MovieModel) -> AnyPublisher<Bool, Error>
    func deleteMovieFromFavorite(from movie: MovieModel) -> AnyPublisher<Bool, Error>
    func movieIsFavorite(from movie: MovieModel) -> AnyPublisher<Bool, Error>
}

final class TmdbRepository: NSObject {
    
    typealias TmdbInstance = (RemoteDataSource, LocaleDataSource) -> TmdbRepository
    
    fileprivate let local: LocaleDataSource
    fileprivate let remote: RemoteDataSource
    
    private init(remote: RemoteDataSource, local: LocaleDataSource) {
        self.remote = remote
        self.local = local
    }
    
    static let sharedInstance: TmdbInstance = { remoteRepo, localRepo in
        return TmdbRepository(remote: remoteRepo, local: localRepo)
    }
}

extension TmdbRepository: TmdbRepositoryProtocol {
    
    // MARK: Remote - getPopularMovie
    func getPopularMovie(page: Int) -> AnyPublisher<[MovieModel], Error> {
        return self.remote.getPopularMovie(page: page).map {
            MovieMapper.mapMovieToDomains(input: $0)
        }.eraseToAnyPublisher()
    }
    
    // MARK: Remote - getNowPlayingMovie
    func getNowPlayingMovie(page: Int) -> AnyPublisher<[MovieModel], Error> {
        return self.remote.getNowPlayingMovie(page: page).map {
            MovieMapper.mapMovieToDomains(input: $0)
        }.eraseToAnyPublisher()
    }
    
    // MARK: Remote - getTopRatedMovie
    func getTopRatedMovie(page: Int) -> AnyPublisher<[MovieModel], Error> {
        return self.remote.getTopRatedMovie(page: page).map {
            MovieMapper.mapMovieToDomains(input: $0)
        }.eraseToAnyPublisher()
    }
    
    // MARK: Remote - getDetailMovie
    func getDetailMovie(idMovie: Int) -> AnyPublisher<DetailMovieModel, Error> {
        return Publishers.Zip(self.remote.getDetailMovie(idMovie: idMovie), self.remote.getCreditMovie(idMovie: idMovie))
            .map { (detailResponse, creditResponse) in
                DetailMovieMapper.mapDetailMovieResponseToDomains(movieResponse: detailResponse, creditResponse: creditResponse)
            }.eraseToAnyPublisher()
    }
    
    // MARK: Remote - searchMovie
    func searchMovie(page: Int, query: String) -> AnyPublisher<[MovieModel], Error> {
        return self.remote.searchMovie(page: page, query: query).map {
            MovieMapper.mapMovieToDomains(input: $0)
        }.eraseToAnyPublisher()
    }
    
    // MARK: Local - getFavoriteMovies
    func getFavoriteMovies() -> AnyPublisher<[MovieModel], Error> {
        return self.local.getFavoriteMovies()
            .map {MovieMapper.mapMovieEntitiesToDomains(input: $0)
            }.eraseToAnyPublisher()
    }
    
    // MARK: Local - addMovieToFavorite
    func addMovieToFavorite(from movie: MovieModel) -> AnyPublisher<Bool, Error> {
        return self.local.addMovieToFavorite(from: MovieMapper.mapMovieDomainsToEntities(input: movie)
        ).eraseToAnyPublisher()
    }
    
    // MARK: Local - deleteMovieFromFavorite
    func deleteMovieFromFavorite(from movie: MovieModel) -> AnyPublisher<Bool, Error> {
        return self.local.deleteMovieFromFavorite(from: MovieMapper.mapMovieDomainsToEntities(input: movie)
        ).eraseToAnyPublisher()
    }
    
    // MARK: Local - movieIsFavorite
    func movieIsFavorite(from movie: MovieModel) -> AnyPublisher<Bool, Error> {
        return self.local.movieIsFavorite(from: MovieMapper.mapMovieDomainsToEntities(input: movie)
        ).eraseToAnyPublisher()
    }
}
