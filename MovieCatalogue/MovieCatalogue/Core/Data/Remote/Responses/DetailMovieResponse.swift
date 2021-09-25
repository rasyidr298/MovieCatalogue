//
//  DetailMovieResponse.swift
//  MovieCatalogue
//
//  Created by Rasyid Ridla on 15/9/21.
//

import Foundation

// MARK: DetailMovieResponse
struct DetailMovieResponse: Decodable {
    let id: Int?
    let originalTitle,homepage, overview, posterPath, backdropPath, releaseDate, title, imdbId, originalLanguage, status, tagline: String?
    let popularity, voteAverage: Double?
    let video: Bool?
    let voteCount, runtime: Int?
    let genres: [Genre]?
    let productionCompanies: [ProductionCompanies]?
    
    internal enum CodingKeys: String, CodingKey {
        case id = "id"
        case originalTitle = "original_title"
        case homepage = "homepage"
        case overview = "overview"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case title = "title"
        case imdbId = "imdb_id"
        case originalLanguage = "original_language"
        case runtime = "runtime"
        case status = "status"
        case tagline = "tagline"
        case popularity = "popularity"
        case voteAverage = "vote_average"
        case video = "video"
        case voteCount = "voteCount"
        case genres = "genres"
        case productionCompanies = "production_companies"
    }
}

// MARK: Genre
struct Genre: Decodable {
    let id: Int?
    let name: String?
    
    internal enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}

// MARK: ProductionCompanies
struct ProductionCompanies: Decodable {
    let id: Int?
    let logoPath, name, originalCountry: String?
    
    internal enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originalCountry = "original_country"
    }
}
