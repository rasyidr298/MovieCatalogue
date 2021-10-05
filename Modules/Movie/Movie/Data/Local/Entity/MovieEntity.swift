//
//  MovieEntity.swift
//  Movie
//
//  Created by Rasyid Ridla on 27/9/21.
//

import Foundation
import RealmSwift

// MARK: MovieEntity
class MovieEntity: Object {
  
  @objc dynamic var id: Int = 0
  @objc dynamic var title: String = ""
  @objc dynamic var overview: String = ""
  @objc dynamic var voteAverage: Double = 0
  @objc dynamic var posterPath: String = ""
  @objc dynamic var backdropPath: String = ""
  @objc dynamic var releaseDate: String = ""
  
  override class func primaryKey() -> String? {
    return "id"
  }
  
}
