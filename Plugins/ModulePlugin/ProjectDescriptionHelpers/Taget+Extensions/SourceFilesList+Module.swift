//
//  SourceFilesList+Module.swift
//  EnviromentPlugin
//
//  Created by 송영모 on 2023/07/12.
//

import Foundation
import ProjectDescription

extension SourceFilesList {
    static func path(type: MicroTargetType) -> Self? {
        let suffix: String = "Sources/**"
        
        switch type {
        case .implement: return .init(stringLiteral: suffix)
        default: return .init(stringLiteral: type.rawValue + "/" + suffix)
        }
    }
}
