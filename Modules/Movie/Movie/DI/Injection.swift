//
//  Injection.swift
//  Movie
//
//  Created by Rasyid Ridla on 27/9/21.
//

import Foundation
import RealmSwift

public final class Injection: NSObject {
    
    // MARK: provideRepository
    func provideRepository() -> TmdbRepository {
        let realm = try? Realm()
        let remote: RemoteDataSource = RemoteDataSource.sharedInstance
        let local: LocaleDataSource = LocaleDataSource.sharedInstance(realm)
        
        return TmdbRepository.sharedInstance(remote, local)
    }
    
    // MARK: provideHome
    public func provideHome() -> HomeUseCase {
        let repository = provideRepository()
        return HomeInteractor(repository: repository)
    }
    
    // MARK: provideDetail
    public func provideDetail(movie: MovieModel) -> DetailUseCase {
        let repository = provideRepository()
        return DetailInteractor(repository: repository, movie: movie)
    }
    
    // MARK: provideFavorite
    public func provideFavorite() -> FavoriteMoviesUseCase {
        let repository = provideRepository()
        return FavoriteMoviesInteractor(repository: repository)
    }
    
    // MARK: provideSearch
    public func provideSearch() -> SearchUseCase {
        let repository = provideRepository()
        return SearchInteractor(repository: repository)
    }
    
}
