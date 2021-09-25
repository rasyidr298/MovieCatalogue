//
//  CustomError.swift
//  MovieCatalogue
//
//  Created by Rasyid Ridla on 16/9/21.
//

import Foundation

// MARK: URLError
enum URLError: LocalizedError {
    
    case invalidResponse
    case addressUnreachable(URL)
    
    var errorDescription: String? {
        switch self {
        case .invalidResponse: return "Please Check your Internet Connection"
        case .addressUnreachable(let url): return "\(url.absoluteString) is unreachable."
        }
    }
    
}

// MARK: DatabaseError
enum DatabaseError: LocalizedError {
    
    case invalidInstance
    case requestFailed
    
    var errorDescription: String? {
        switch self {
        case .invalidInstance: return "Database can't instance."
        case .requestFailed: return "Your request failed."
        }
    }
    
}
