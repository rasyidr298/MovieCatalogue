//
//  Injection.swift
//  MovieCatalogue
//
//  Created by Rasyid Ridla on 16/9/21.
//

import Foundation

final class Injection: NSObject {
    
    // MARK: provideRepository
    func provideRepository() -> TmdbRepository {
        let remote: RemoteDataSource = RemoteDataSource.sharedInstance
        
        return TmdbRepository.sharedInstance(remote)
    }
    
    // MARK: provideHome
    func provideHome() -> HomeUseCase {
        let repository = provideRepository()
        return HomeInteractor(repository: repository)
    }
    
}
