//
//  Endpoint.swift
//  MullingCore
//
//  Created by 송영모 on 2023/08/22.
//

import Foundation

public protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var header: [String: String]? { get }
    var body: [String: Any]? { get }
}

public extension Endpoint {
    var scheme: String {
        return "https"
    }
    
    var host: String {
        return "api.themoviedb.org"
    }
}
