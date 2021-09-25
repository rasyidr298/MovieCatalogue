//
//  CustomString.swift
//  MovieCatalogue
//
//  Created by Rasyid Ridla on 16/9/21.
//

import Foundation

// MARK: extension String
extension String {
  func toDate(withFormat format: String = "yyyy-MM-dd") -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    guard let date = dateFormatter.date(from: self) else {
      preconditionFailure("Take a look to your format")
    }
    return date
  }
}

// MARK: extension Date
extension Date {
  func toString(format: String = "yyyy-MM-dd") -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.dateFormat = format
    return formatter.string(from: self)
  }
}
