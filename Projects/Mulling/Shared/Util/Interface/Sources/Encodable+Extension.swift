//
//  Encodable+Extension.swift
//  MullingSharedUtilInterface
//
//  Created by 송영모 on 2023/08/22.
//

import Foundation

extension Encodable {
    public func toDictionary() throws -> [String : Any]? {
        let data = try JSONEncoder().encode(self)
        let jsonObject = try JSONSerialization.jsonObject(with: data)
        return jsonObject as? [String : Any]
    }
}
