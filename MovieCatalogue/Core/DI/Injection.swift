//
//  Injection.swift
//  MovieCatalogue
//
//  Created by Rasyid Ridla on 16/9/21.
//

import Foundation
import RealmSwift

final class Injection: NSObject {
    
    // MARK: provideRepository
    func provideRepository() -> TmdbRepository {
        let realm = try? Realm()
        let remote: RemoteDataSource = RemoteDataSource.sharedInstance
        let local: LocaleDataSource = LocaleDataSource.sharedInstance(realm)
        
        return TmdbRepository.sharedInstance(remote, local)
    }
    
    // MARK: provideHome
    func provideHome() -> HomeUseCase {
        let repository = provideRepository()
        return HomeInteractor(repository: repository)
    }
    
    // MARK: provideDetail
    func provideDetail(movie: MovieModel) -> DetailUseCase {
        let repository = provideRepository()
        return DetailInteractor(repository: repository, movie: movie)
    }
    
    // MARK: provideFavorite
    func provideFavorite() -> FavoriteMoviesUseCase {
        let repository = provideRepository()
        return FavoriteMoviesInteractor(repository: repository)
    }
    
    // MARK: provideSearch
    func provideSearch() -> SearchUseCase {
        let repository = provideRepository()
        return SearchInteractor(repository: repository)
    }
    
}
