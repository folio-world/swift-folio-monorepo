//
//  URLRequest+Extension.swift
//  MullingSharedUtilInterface
//
//  Created by 송영모 on 2023/08/23.
//

import Foundation

public extension URLRequest {
    func debug() {
        print("\(self.httpMethod!) \(self.url!)")
        print("Headers:")
        print(self.allHTTPHeaderFields!)
        print("Body:")
        print(String(data: self.httpBody ?? Data(), encoding: .utf8)!)
    }
}
