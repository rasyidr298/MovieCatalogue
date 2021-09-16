//
//  MovieMapper.swift
//  MovieCatalogue
//
//  Created by Rasyid Ridla on 16/9/21.
//

import Foundation

final class MovieMapper {
    
    // MARK: mapMovieResponsesToDomains
    static func mapMovieToDomains(input response: [Movie]) -> [MovieModel] {
        
        return response.map {result in
            return MovieModel(
                id: result.id ?? 0,
                title: result.title ?? "",
                overview: result.overview ?? "",
                voteAverage: result.voteAverage ?? 0,
                posterPath: result.posterPath ?? "",
                backdropPath: result.backdropPath ?? "",
                releaseDate: result.releaseDate ?? ""
            )
        }
    }
    
    // MARK: mapDetailMovieResponseToDomains
    static func mapDetailMovieResponseToDomains(movieResponse: DetailMovieResponse, creditResponse: CreditsResponse) -> DetailMovieModel {
        let genres = mapGenresResponseToDomains(input: movieResponse)
        let productionCompanies = mapCompaiesResponseToDomains(input: movieResponse)
        let casts = mapCastsResponseToDomains(input: creditResponse)
        let crews = mapCrewsResponseToDomains(input: creditResponse)
        
        return DetailMovieModel(
            id: movieResponse.id ?? 0,
            genres: genres ,
            homepage: movieResponse.homepage ?? "",
            imdbID: movieResponse.imdbId ?? "",
            originalLanguage: movieResponse.originalLanguage ?? "",
            originalTitle: movieResponse.originalTitle ?? "",
            overview: movieResponse.overview ?? "",
            popularity: movieResponse.popularity ?? 0,
            posterPath: movieResponse.posterPath ?? "",
            backdropPath: movieResponse.backdropPath ?? "",
            releaseDate: movieResponse.releaseDate ?? "",
            runtime: movieResponse.runtime ?? 0,
            status: movieResponse.status ?? "",
            tagline: movieResponse.tagline ?? "",
            title: movieResponse.title ?? "",
            video: movieResponse.video ?? false,
            voteAverage: movieResponse.voteAverage ?? 0,
            voteCount: movieResponse.voteCount ?? 0,
            casts: casts, crews: crews ,
            productionCompanies: productionCompanies 
        )
    }
    
    static func mapGenresResponseToDomains(input response: DetailMovieResponse) -> [GenreModel] {
        return response.genres!.map { GenreModel(id: $0.id ?? 0, name: $0.name ?? "") }
    }
    
    static func mapCompaiesResponseToDomains(input response: DetailMovieResponse) -> [ProductionCompaniesModel] {
        return response.productionCompanies!.map { ProductionCompaniesModel(id: $0.id ?? 0, logoPath: $0.logoPath ?? "", name: $0.name ?? "", originalCountry: $0.originalCountry ?? "")}
    }
    
    static func mapCastsResponseToDomains(input response: CreditsResponse) -> [CastModel] {
        return response.cast!.map { CastModel(id: $0.id ?? 0, character: $0.character ?? "", name: $0.name ?? "", order: 0, profilePath: $0.profilePath ?? "")}
    }
    
    static func mapCrewsResponseToDomains(input response: CreditsResponse) -> [CrewModel] {
        return response.crew!.map { CrewModel(id: $0.id ?? 0, job: $0.job ?? "", name: $0.name ?? "", departement: $0.department ?? "", order: 0)}
    }
}
