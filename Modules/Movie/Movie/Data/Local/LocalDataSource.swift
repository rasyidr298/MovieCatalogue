//
//  LocalDataSource.swift
//  Movie
//
//  Created by Rasyid Ridla on 27/9/21.
//

import Foundation
import RealmSwift
import Combine
import Core

protocol LocaleDataSourceProtocol: AnyObject {
    
    func getFavoriteMovies() -> AnyPublisher<[MovieEntity], Error>
    func addMovieToFavorite(from movie: MovieEntity) -> AnyPublisher<Bool, Error>
    func deleteMovieFromFavorite(from movie: MovieEntity) -> AnyPublisher<Bool, Error>
    func movieIsFavorite(from movie: MovieEntity) -> AnyPublisher<Bool, Error>
}

final class LocaleDataSource: NSObject {
    
    private let realm: Realm?
    private init(realm: Realm?) {
        self.realm = realm
    }
    
    static let sharedInstance: (Realm?) -> LocaleDataSource = { realmDatabase in
        return LocaleDataSource(realm: realmDatabase)
    }
}

extension LocaleDataSource: LocaleDataSourceProtocol {
    
    // MARK: getFavoriteMovies
    func getFavoriteMovies() -> AnyPublisher<[MovieEntity], Error> {
        return Future<[MovieEntity], Error> { completion in
            if let realm = self.realm {
                let movies: Results<MovieEntity> = {
                    realm.objects(MovieEntity.self)
                        .sorted(byKeyPath: "id", ascending: true)
                }()
                completion(.success(movies.toArray(ofType: MovieEntity.self)))
            } else {
                completion(.failure(DatabaseErrorEnum.errorRequestFailed))
            }
        }.eraseToAnyPublisher()
    }
    
    // MARK: addMovieToFavorite
    func addMovieToFavorite(from movie: MovieEntity) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                do {
                    try realm.write {
                        realm.add(movie, update: .modified)
                    }
                    completion(.success(true))
                } catch {
                    completion(.failure(DatabaseErrorEnum.errorRequestFailed))
                }
            } else {
                completion(.failure(DatabaseErrorEnum.errorRequestFailed))
            }
        }.eraseToAnyPublisher()
    }
    
    // MARK: deleteMovieFromFavorite
    func deleteMovieFromFavorite(from movie: MovieEntity) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                do {
                    let movieEntity = realm.objects(MovieEntity.self).filter("id == \(movie.id)")
                    try realm.write {
                        realm.delete(movieEntity)
                    }
                    completion(.success(true))
                } catch {
                    completion(.failure(DatabaseErrorEnum.errorRequestFailed))
                }
            } else {
                completion(.failure(DatabaseErrorEnum.errorRequestFailed))
            }
        }.eraseToAnyPublisher()
    }
    
    // MARK: movieIsFavorite
    func movieIsFavorite(from movie: MovieEntity) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                let movies = realm.objects(MovieEntity.self).filter("id == \(movie.id)")
                if !movies.isEmpty {
                    completion(.success(true))
                }
            } else {
                completion(.failure(DatabaseErrorEnum.errorRequestFailed))
            }
        }.eraseToAnyPublisher()
    }
}

// MARK: extension Results
extension Results {
    
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for index in 0..<count {
            if let result = self[index] as? T {
                array.append(result)
            }
        }
        return array
    }
}
