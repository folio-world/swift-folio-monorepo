//
//  Environment.swift
//  MullingShared
//
//  Created by 송영모 on 2023/08/22.
//

import Foundation

public struct Environment {
    public static var apiKey: String {
        return Bundle.main.infoDictionary?["OPENAI_API_KEY"] as? String ?? ""
    }
}
