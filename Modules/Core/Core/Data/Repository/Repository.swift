//
//  Repository.swift
//  Core
//
//  Created by Rasyid Ridla on 30/9/21.
//

import Foundation
import Combine

public protocol Repository {
    associatedtype Request
    associatedtype Response

    func execute(request: Request?) -> AnyPublisher<Response, Error>
}
