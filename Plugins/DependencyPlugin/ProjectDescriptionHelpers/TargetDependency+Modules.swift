//
//  TargetDependency+Modules.swift
//  DependencyPlugin
//
//  Created by 송영모 on 2023/04/27.
//

import Foundation
import ProjectDescription

// MARK: TargetDependency + App

public extension TargetDependency {
    static func app(project: ModulePath.Project) -> Self {
        return .project(target: project.rawValue + ModulePath.App.name, path: .app(project: project))
    }
    
    static func app(project: ModulePath.Project, implement module: ModulePath.App) -> Self {
        return .target(name: project.rawValue + ModulePath.App.name + module.rawValue)
    }
}

// MARK: TargetDependency + Feature

public extension TargetDependency {
    static func feature(project: ModulePath.Project) -> Self {
        return .project(target: project.rawValue + ModulePath.Feature.name, path: .feature(project: project))
    }
    
    static func feature(project: ModulePath.Project, module: ModulePath.Feature, microType: MicroType) -> Self {
        return .project(target: project.rawValue + ModulePath.Feature.name + module.rawValue + microType.rawValue, path: .feature(project: project, implement: module))
    }
}

// MARK: TargetDependency + Domain

public extension TargetDependency {
    static func domain(project: ModulePath.Project) -> Self {
        return .project(target: project.rawValue + ModulePath.Domain.name, path: .domain(project: project))
    }
    
    static func domain(project: ModulePath.Project, module: ModulePath.Domain, microType: MicroType) -> Self {
        return .project(target: project.rawValue + ModulePath.Domain.name + module.rawValue + microType.rawValue, path: .domain(project: project, implement: module))
    }
}

// MARK: TargetDependency + Core

public extension TargetDependency {
    static func core(project: ModulePath.Project) -> Self {
        return .project(target: project.rawValue + ModulePath.Core.name, path: .core(project: project))
    }
    
    static func core(project: ModulePath.Project, module: ModulePath.Core, microType: MicroType) -> Self {
        return .project(target: project.rawValue + ModulePath.Core.name + module.rawValue + microType.rawValue, path: .core(project: project, implement: module))
    }
}

// MARK: TargetDependency + Shared

public extension TargetDependency {
    static func shared(project: ModulePath.Project) -> Self {
        return .project(target: project.rawValue + ModulePath.Shared.name, path: .shared(project: project))
    }
    
    static func shared(project: ModulePath.Project, module: ModulePath.Shared, microType: MicroType) -> Self {
        return .project(target: project.rawValue + ModulePath.Shared.name + module.rawValue + microType.rawValue, path: .shared(project: project, implement: module))
    }
}

// MARK: TargetDependency + WatchShared

public extension TargetDependency {
    static func watchShared(project: ModulePath.Project) -> Self {
        return .project(target: project.rawValue + ModulePath.WatchShared.name, path: .watchShared(project: project))
    }
    
    static func watchShared(project: ModulePath.Project, module: ModulePath.WatchShared, microType: MicroType) -> Self {
        return .project(target: project.rawValue + ModulePath.WatchShared.name + module.rawValue + microType.rawValue, path: .watchShared(project: project, implement: module))
    }}
