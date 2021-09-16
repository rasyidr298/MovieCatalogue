//
//  MovieResponse.swift
//  MovieCatalogue
//
//  Created by Rasyid Ridla on 15/9/21.
//

import Foundation

// MARK: MovieResponses
struct MovieResponse: Decodable {
    let movie: [Movie]?
    
    internal enum CodingKeys: String, CodingKey {
        case movie = "results"
    }
}

// MARK: Movie
struct Movie: Decodable {
    let id: Int?
    let title, overview, posterPath, backdropPath, releaseDate: String?
    let voteAverage: Double?
    
    internal enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case overview = "overview"
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
    }
}
