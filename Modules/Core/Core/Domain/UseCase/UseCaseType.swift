//
//  UseCaseType.swift
//  Core
//
//  Created by Rasyid Ridla on 30/9/21.
//

import Foundation
import Combine

public protocol UseCaseType {
    associatedtype Request
    associatedtype Response

    func execute(request: Request?) -> AnyPublisher<Response, Error>
}
