//
//  Settings+Module.swift
//  EnviromentPlugin
//
//  Created by 송영모 on 2023/07/06.
//

import Foundation
import ProjectDescription

//MARK: App

public extension Settings {
    static func app(_ product: Module.Product) -> Self {
        let base = SettingsDictionary()
            .otherLinkerFlags(["-ObjC"])
        
        return .settings(
            base: base,
            configurations: [
                .debug(name: "Debug", xcconfig: .relativeToRoot("\(Path.app(product, module: .IOS).pathString)/Sources/Config/Debug.xcconfig")),
                .release(name: "Release", xcconfig: .relativeToRoot("\(Path.app(product, module: .IOS).pathString)/Sources/Config/Release.xcconfig")),
            ]
        )
    }
}

//MARK: Feature

public extension Settings {
    static func feature(_ product: Module.Product) -> Self {
        return .settings()
    }
}

//MARK: Domain

public extension Settings {
    static func domain(_ product: Module.Product) -> Self {
        return .settings()
    }
}

//MARK: Core

public extension Settings {
    static func core(_ product: Module.Product) -> Self {
        return .settings()
    }
}

//MARK: Shared

public extension Settings {
    static func shared(_ product: Module.Product) -> Self {
        return .settings()
    }
}
