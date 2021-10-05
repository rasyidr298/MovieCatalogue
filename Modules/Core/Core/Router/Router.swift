//
//  Router.swift
//  Core
//
//  Created by Rasyid Ridla on 30/9/21.
//

import Foundation
import SwiftUI

public protocol Router {
    associatedtype Request
    associatedtype Destination: View
    
    func navigate(with request: Request?) -> Destination
}
