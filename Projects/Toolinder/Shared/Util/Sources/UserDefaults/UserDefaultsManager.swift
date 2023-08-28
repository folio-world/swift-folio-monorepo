//
//  UserDefaultsManager.swift
//  MullingSharedUtil
//
//  Created by 송영모 on 2023/08/24.
//

import Foundation

public extension UserDefaults {
    static func fetch(key: String) -> Any? {
        return UserDefaults.standard.object(forKey: key)
    }
    
    static func save(key: String, value: Any) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    static func remove(key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
