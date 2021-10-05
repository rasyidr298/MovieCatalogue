//
//  MovieModel.swift
//  Movie
//
//  Created by Rasyid Ridla on 27/9/21.
//

import Foundation
import Core

// MARK: MovieModel
public struct MovieModel: Equatable, Identifiable {
    
    public let id: Int
    public let title: String
    public let overview: String
    public let voteAverage: Double
    public var rating: Float16 { Float16(voteAverage * 10) }
    public let posterPath: String
    public var poster: String { TMDB.imageUrl + posterPath }
    public let backdropPath: String
    public var backdrop: String { TMDB.imageUrl + backdropPath }
    public let releaseDate: String
    public var releaseDateFormatted: String {
        let date = releaseDate.toDate()
        return date.toString(format: "MMM dd,yyyy")
    }
    
    public static var `default`: MovieModel { MovieModel(id: 0, title: "Roald Dahl", overview: "", voteAverage: 7.1, posterPath: "/betExZlgK0l7CZ9CsCBVcwO1OjL.jpg", backdropPath: "", releaseDate: "")}
    
}
