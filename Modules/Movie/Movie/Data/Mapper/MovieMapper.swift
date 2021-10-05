//
//  MovieMapper.swift
//  Movie
//
//  Created by Rasyid Ridla on 27/9/21.
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
    
    // MARK: mapMovieDomainsToEntities
    static func mapMovieDomainsToEntities(input movieModel: MovieModel) -> MovieEntity {
        let newMovie = MovieEntity()
        newMovie.id = movieModel.id
        newMovie.title = movieModel.title
        newMovie.overview = movieModel.overview
        newMovie.voteAverage = movieModel.voteAverage
        newMovie.posterPath = movieModel.posterPath
        newMovie.backdropPath = movieModel.backdropPath
        newMovie.releaseDate = movieModel.releaseDate
        return newMovie
    }
    
    // MARK: mapMovieEntitiesToDomains
    static func mapMovieEntitiesToDomains(input movieEntity: [MovieEntity]) -> [MovieModel] {
        return movieEntity.map { result in
            return MovieModel(
                id: result.id,
                title: result.title,
                overview: result.overview,
                voteAverage: result.voteAverage,
                posterPath: result.posterPath,
                backdropPath: result.backdropPath,
                releaseDate: result.releaseDate
            )
        }
    }
}
