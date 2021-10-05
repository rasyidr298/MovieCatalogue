//
//  FavoriteMovieInteractore.swift
//  Movie
//
//  Created by Rasyid Ridla on 27/9/21.
//

import Foundation
import Combine

public protocol FavoriteMoviesUseCase {
  func getFavoriteMovies() -> AnyPublisher<[MovieModel], Error>
}

class FavoriteMoviesInteractor: FavoriteMoviesUseCase {
  private let repository: TmdbRepository
  
  required init(repository: TmdbRepository) {
    self.repository = repository
  }
    
    // MARK: getFavoriteMovies
  func getFavoriteMovies() -> AnyPublisher<[MovieModel], Error> {
    return repository.getFavoriteMovies()
  }
}
