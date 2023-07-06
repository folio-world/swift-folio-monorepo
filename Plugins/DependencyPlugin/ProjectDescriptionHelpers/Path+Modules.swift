//
//  ProjectDescription+Path.swift
//  DependencyPlugin
//
//  Created by 송영모 on 2023/04/27.
//

import Foundation
import ProjectDescription

// MARK: ProjectDescription.Path + App

public extension ProjectDescription.Path {
    static func app(project: ModulePath.Project) -> Self {
        return .relativeToRoot("Projects/\(project.rawValue)/\(ModulePath.App.name)")
    }
}

// MARK: ProjectDescription.Path + Feature

public extension ProjectDescription.Path {
    static func feature(project: ModulePath.Project) -> Self {
        return .relativeToRoot("Projects/\(project.rawValue)/\(ModulePath.Feature.name)")
    }
    
    static func feature(project: ModulePath.Project, implement module: ModulePath.Feature) -> Self {
        return .relativeToRoot("Projects/\(project.rawValue)/\(ModulePath.Feature.name)/\(module.rawValue)")
    }
}

// MARK: ProjectDescription.Path + Domain

public extension ProjectDescription.Path {
    static func domain(project: ModulePath.Project) -> Self {
        return .relativeToRoot("Projects/\(project.rawValue)/\(ModulePath.Domain.name)")
    }
    
    static func domain(project: ModulePath.Project, implement module: ModulePath.Domain) -> Self {
        return .relativeToRoot("Projects/\(project.rawValue)/\(ModulePath.Domain.name)/\(module.rawValue)")
    }
}

// MARK: ProjectDescription.Path + Core

public extension ProjectDescription.Path {
    static func core(project: ModulePath.Project) -> Self {
        return .relativeToRoot("Projects/\(project.rawValue)/\(ModulePath.Core.name)")
    }
    
    static func core(project: ModulePath.Project, implement module: ModulePath.Core) -> Self {
        return .relativeToRoot("Projects/\(project.rawValue)/\(ModulePath.Core.name)/\(module.rawValue)")
    }
}

// MARK: ProjectDescription.Path + Shared

public extension ProjectDescription.Path {
    static func shared(project: ModulePath.Project) -> Self {
        return .relativeToRoot("Projects/\(project.rawValue)/\(ModulePath.Shared.name)")
    }
    
    static func shared(project: ModulePath.Project, implement module: ModulePath.Shared) -> Self {
        return .relativeToRoot("Projects/\(project.rawValue)/\(ModulePath.Shared.name)/\(module.rawValue)")
    }
}

// MARK: ProjectDescription.Path + WatchShared

public extension ProjectDescription.Path {
    static func watchShared(project: ModulePath.Project) -> Self {
        return .relativeToRoot("Projects/\(project.rawValue)/\(ModulePath.WatchShared.name)")
    }
    
    static func watchShared(project: ModulePath.Project, implement module: ModulePath.WatchShared) -> Self {
        return .relativeToRoot("Projects/\(project.rawValue)/\(ModulePath.WatchShared.name)/\(module.rawValue)")
    }
}
