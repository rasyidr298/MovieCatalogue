//
//  RemoteDataSource.swift
//  Movie
//
//  Created by Rasyid Ridla on 27/9/21.
//

import Foundation
import Combine
import Alamofire
import Core

protocol RemoteDataSourceProtocol: AnyObject {
    func getPopularMovie(page: Int) -> AnyPublisher<[Movie], Error>
    func getNowPlayingMovie(page: Int) -> AnyPublisher<[Movie], Error>
    func getTopRatedMovie(page: Int) -> AnyPublisher<[Movie], Error>
    func searchMovie(page: Int, query: String) -> AnyPublisher<[Movie], Error>
    func getDetailMovie(idMovie: Int) -> AnyPublisher<DetailMovieResponse, Error>
    func getCreditMovie(idMovie: Int) -> AnyPublisher<CreditsResponse, Error>
}

final class RemoteDataSource : NSObject {
    override init() {}
    
    static let sharedInstance: RemoteDataSource = RemoteDataSource()
}

extension RemoteDataSource: RemoteDataSourceProtocol {
    
    // MARK: getPopularMovie
    func getPopularMovie(page: Int) -> AnyPublisher<[Movie], Error> {
        
        let params: Parameters = [
            "api_key": TMDB.apiKey,
            "page": page
        ]
        
        return Future <[Movie], Error> { completion in
            if let requestURL = URL(string: "\(TMDB.tmdbURLV3+TMDB.popularMovies)") {
                
                AF.request(requestURL, method: .get, parameters: params)
                    .validate()
                    .responseDecodable(of: MovieResponse.self) {response in
                        
                        switch response.result {
                        case .success(let value):
                            completion(
                                .success(value.movie ?? [])
                            )
                        case .failure:
                            completion(
                                .failure(URLErrorEnum.errorInvalidResponse)
                            )
                        }
                    }
                print("\(requestURL)\(params)")
            }
        }.eraseToAnyPublisher()
    }
    
    // MARK: getNowPlayingMovie
    func getNowPlayingMovie(page: Int) -> AnyPublisher<[Movie], Error> {
        
        let params: Parameters = [
            "api_key": TMDB.apiKey,
            "page": page
        ]
        
        return Future <[Movie], Error> { completion in
            if let requestURL = URL(string: "\(TMDB.tmdbURLV3+TMDB.nowPlayingMovies)") {
                
                AF.request(requestURL, method: .get, parameters: params)
                    .validate()
                    .responseDecodable(of: MovieResponse.self) {response in
                        
                        switch response.result {
                        case .success(let value):
                            completion(
                                .success(value.movie ?? [])
                            )
                        case .failure:
                            completion(
                                .failure(URLErrorEnum.errorInvalidResponse)
                            )
                        }
                    }
                print("\(requestURL)\(params)")
            }
        }.eraseToAnyPublisher()
    }
    
    // MARK: getTopRatedMovie
    func getTopRatedMovie(page: Int) -> AnyPublisher<[Movie], Error> {
        
        let params: Parameters = [
            "api_key": TMDB.apiKey,
            "page": page
        ]
        
        return Future <[Movie], Error> { completion in
            if let requestURL = URL(string: "\(TMDB.tmdbURLV3+TMDB.topRatedMovies)") {
                
                AF.request(requestURL, method: .get, parameters: params)
                    .validate()
                    .responseDecodable(of: MovieResponse.self) {response in
                        
                        switch response.result {
                        case .success(let value):
                            completion(
                                .success(value.movie ?? [])
                            )
                        case .failure:
                            completion(
                                .failure(URLErrorEnum.errorInvalidResponse)
                            )
                        }
                    }
                print("\(requestURL)\(params)")
            }
        }.eraseToAnyPublisher()
    }
    
    // MARK: searchMovie
    func searchMovie(page: Int, query: String) -> AnyPublisher<[Movie], Error> {
        
        let params: Parameters = [
            "api_key": TMDB.apiKey,
            "query": query,
            "page": page
        ]
        
        return Future <[Movie], Error> { completion in
            if let requestURL = URL(string: "\(TMDB.tmdbURLV3+TMDB.searchMovie)") {
                
                AF.request(requestURL, method: .get, parameters: params)
                    .validate()
                    .responseDecodable(of: MovieResponse.self) {response in
                        
                        switch response.result {
                        case .success(let value):
                            completion(
                                .success(value.movie ?? [])
                            )
                        case .failure:
                            completion(
                                .failure(URLErrorEnum.errorInvalidResponse)
                            )
                        }
                    }
                print("\(requestURL)\(params)")
            }
        }.eraseToAnyPublisher()
    }
    
    // MARK: getDetailMovie
    func getDetailMovie(idMovie: Int) -> AnyPublisher<DetailMovieResponse, Error> {
        
        let params: Parameters = [
            "api_key": TMDB.apiKey
        ]
        
        return Future <DetailMovieResponse, Error> { completion in
            if let requestURL = URL(string: "\(TMDB.tmdbURLV3+detailMovie(idMovie: idMovie))") {
                
                AF.request(requestURL, method: .get, parameters: params)
                    .validate()
                    .responseDecodable(of: DetailMovieResponse.self) {response in
                        
                        switch response.result {
                        case .success(let value):
                            completion(
                                .success(value)
                            )
                        case .failure:
                            completion(
                                .failure(URLErrorEnum.errorInvalidResponse)
                            )
                        }
                    }
                print("\(requestURL)\(params)")
            }
        }.eraseToAnyPublisher()
    }
    
    // MARK: getCreditMovie
    func getCreditMovie(idMovie: Int) -> AnyPublisher<CreditsResponse, Error> {
        
        let params: Parameters = [
            "api_key": TMDB.apiKey
        ]
        
        return Future <CreditsResponse, Error> { completion in
            if let requestURL = URL(string: "\(TMDB.tmdbURLV3+creditsMovie(idMovie: idMovie))") {
                
                AF.request(requestURL, method: .get, parameters: params)
                    .validate()
                    .responseDecodable(of: CreditsResponse.self) {response in
                        
                        switch response.result {
                        case .success(let value):
                            completion(
                                .success(value)
                            )
                        case .failure:
                            completion(
                                .failure(URLErrorEnum.errorInvalidResponse)
                            )
                        }
                    }
                print("\(requestURL)\(params)")
            }
        }.eraseToAnyPublisher()
    }
    
}
