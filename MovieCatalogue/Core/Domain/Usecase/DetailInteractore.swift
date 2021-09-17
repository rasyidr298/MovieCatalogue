//
//  DetailUseCase.swift
//  MovieCatalogue
//
//  Created by Rasyid Ridla on 17/9/21.
//

import Foundation
import Combine

protocol DetailUseCase {
    // MARK: Remote
    func getMovie() -> MovieModel
    func getDetailMovie(idMovie: Int) -> AnyPublisher<DetailMovieModel, Error>
    
    // MARK: Locale
    func addMovieToFavorite(movie: MovieModel) -> AnyPublisher<Bool, Error>
    func deleteMovieFromFavorite(movie: MovieModel) -> AnyPublisher<Bool, Error>
    func movieIsFavorite(movie: MovieModel) -> AnyPublisher<Bool, Error>
}

class DetailInteractor: DetailUseCase {
    
    private let repository: TmdbRepository
    private let movie: MovieModel
    
    required init(repository: TmdbRepository, movie: MovieModel) {
        self.repository = repository
        self.movie = movie
    }
    
    // MARK: Remote - getMovie
    func getMovie() -> MovieModel {
        return movie
    }
    
    // MARK: Remote - getDetailMovie
    func getDetailMovie(idMovie: Int) -> AnyPublisher<DetailMovieModel, Error> {
        return repository.getDetailMovie(idMovie: idMovie)
    }
    
    // MARK: Locale - addMovieToFavorite
    func addMovieToFavorite(movie: MovieModel) -> AnyPublisher<Bool, Error> {
        return repository.addMovieToFavorite(from: movie)
    }
    
    // MARK: Locale - deleteMovieFromFavorite
    func deleteMovieFromFavorite(movie: MovieModel) -> AnyPublisher<Bool, Error> {
        return repository.deleteMovieFromFavorite(from: movie)
    }
    
    // MARK: Locale - movieIsFavorite
    func movieIsFavorite(movie: MovieModel) -> AnyPublisher<Bool, Error> {
        return repository.movieIsFavorite(from: movie)
    }
    
}
