//
//  CreditsResponse.swift
//  Movie
//
//  Created by Rasyid Ridla on 27/9/21.
//

import Foundation

// MARK: - CreditsResponse
struct CreditsResponse: Decodable {
    let id: Int
    let cast: [Cast]?
    let crew: [Crew]?
    
    internal enum CodingKeys: String, CodingKey {
        case id
        case cast
        case crew
    }
}

// MARK: - Cast
struct Cast: Decodable {
    let id: Int?
    let character, name, profilePath: String?
    
    internal enum CodingKeys: String, CodingKey {
        case id
        case character
        case name
        case profilePath = "profile_path"
    }
}

// MARK: - Crew
struct Crew: Codable {
  let id: Int?
  let department, job, name: String?
    
    internal enum CodingKeys: String, CodingKey {
        case id
        case department
        case job
        case name
    }
}
