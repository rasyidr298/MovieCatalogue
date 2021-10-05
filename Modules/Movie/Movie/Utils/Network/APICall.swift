//
//  APICall.swift
//  Movie
//
//  Created by Rasyid Ridla on 27/9/21.
//

import Foundation

struct TMDB {
    // MARK: Bash
    static public let tmdbURLV3 = "https://api.themoviedb.org/3/"
    static public let tvdbURLV4 = "https://api.themoviedb.org/4/"
    static public let apiKey = "967ad60bd20b9b2102526183323e3c3b"
    static public let imageUrl = "https://image.tmdb.org/t/p/w500"
    
    // MARK: Endpoints Movies
    static public let topRatedMovies = "movie/top_rated"
    static public let nowPlayingMovies = "movie/now_playing"
    static public let popularMovies = "movie/popular"
    static public let upcomingMovies = "movie/upcoming"
    static public let searchMovie = "search/movie"
}

func detailMovie(idMovie: Int) -> String { return "movie/\(idMovie)"}
func creditsMovie(idMovie: Int) -> String { return "movie/\(idMovie)/credits"}

// MARK: Endpoints Person
func detailPerson(idPerson: Int) -> String { return "person/\(idPerson)"}
func imagesPerson(idPerson: Int) -> String { return "person/\(idPerson)/images"}
