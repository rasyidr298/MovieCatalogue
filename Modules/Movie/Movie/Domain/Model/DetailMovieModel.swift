//
//  DetailMovieModel.swift
//  Movie
//
//  Created by Rasyid Ridla on 27/9/21.
//

import Foundation

// MARK: DetailMovieModel
public struct DetailMovieModel {
    public let id: Int
    public let genres: [GenreModel]
    public let homepage: String
    public let imdbID, originalLanguage, originalTitle, overview: String
    public let popularity: Double
    public let posterPath, backdropPath: String
    public let releaseDate: String
    public let runtime: Int
    public let status, tagline, title: String
    public let video: Bool
    public let voteAverage: Double
    public let voteCount: Int
    public let casts: [CastModel]
    public var crews: [CrewModel]
    public var productionCompanies: [ProductionCompaniesModel]
    public var poster: String { TMDB.imageUrl + posterPath }
    public var backdrop: String { TMDB.imageUrl + backdropPath }
    public var genre: String {
        return genres.map { $0.name }.joined(separator: ",")
    }
    
    public static var `default`: DetailMovieModel { DetailMovieModel(
        id: 531219, genres: [GenreModel(id: 11, name: ""),
                             GenreModel(id: 12, name: "")],
        homepage: "",
        imdbID: "",
        originalLanguage: "",
        originalTitle: "",
        overview: "",
        popularity: 1768.318,
        posterPath: "",
        backdropPath: "",
        releaseDate: "",
        runtime: 106,
        status: "",
        tagline: "",
        title: "",
        video: false,
        voteAverage: 7.1,
        voteCount: 492,
        casts: [CastModel(id: 1, character: "", name: "", order: 1, profilePath: ""),
                CastModel(id: 1, character: "", name: "", order: 1, profilePath: "")],
        crews: [CrewModel(id: 1, job: "", name: "", departement: "", order: 1)],
        productionCompanies: [ProductionCompaniesModel(id: 1, logoPath: "", name: "", originalCountry: "")]
    )}
}

// MARK: GenreModel
public struct GenreModel: Identifiable {
    public let id: Int
    public let name: String
}

// MARK: CastModel
public struct CastModel: Identifiable {
    public let id: Int
    public let character, name: String
    public let order: Int
    public let profilePath: String?
    public var profile: String { TMDB.imageUrl + (profilePath ?? "") }
}

// MARK: CrewModel
public struct CrewModel: Identifiable {
    public let id: Int
    public let job, name, departement: String
    public let order: Int
}

// MARK: ProductionCompaniesModel
public struct ProductionCompaniesModel: Identifiable {
    public let id: Int
    public let logoPath, name, originalCountry: String
}
