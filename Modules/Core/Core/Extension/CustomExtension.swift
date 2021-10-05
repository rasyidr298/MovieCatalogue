//
//  CustomExtension.swift
//  Core
//
//  Created by Rasyid Ridla on 5/10/21.
//

import Foundation

// MARK: extension String
public extension String {
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
public extension Date {
    func toString(format: String = "yyyy-MM-dd") -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.dateFormat = format
    return formatter.string(from: self)
  }
}
