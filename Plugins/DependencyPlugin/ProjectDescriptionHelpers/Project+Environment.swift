//
//  Environment.swift
//  DependencyPlugin
//
//  Created by 송영모 on 2023/04/27.
//

import Foundation
import ProjectDescription

public extension Project {
    struct Environment {
        public static func deploymentTarget(project: ModulePath.Project) -> DeploymentTarget {
            switch project {
            case .Dying: return self.deploymentTarget(project: project, app: .IOS)
            }
        }
        
        public static func namePrefix(project: ModulePath.Project) -> String {
            switch project {
            case .Dying: return "Diebeing"
            }
        }
        
        public static func productNamePrefix(project: ModulePath.Project) -> String {
            switch project {
            case .Dying: return "Diebeing"
            }
        }
        
        public static func bundleIdPrefix(project: ModulePath.Project) -> String {
            switch project {
            case .Dying: return "com.annapo.diebeing"
            }
        }
    }
}


//MARK: Project.Environment + App

public extension Project.Environment {
    static func name(project: ModulePath.Project, app: ModulePath.App) -> String {
        switch project {
        case .Dying:
            switch app {
            case .IOS: return self.namePrefix(project: project)
            case .Watch: return self.namePrefix(project: project) + "Watch"
            case .WatchExtension: return self.namePrefix(project: project) + "WatchExtension"
            }
        }
    }
    
    static func deploymentTarget(project: ModulePath.Project, app: ModulePath.App) -> DeploymentTarget {
        switch project {
        case .Dying:
            switch app {
            case .IOS: return DeploymentTarget.iOS(targetVersion: "16.0", devices: [.iphone])
            case .Watch: return DeploymentTarget.watchOS(targetVersion: "9.0")
            case .WatchExtension: return DeploymentTarget.watchOS(targetVersion: "9.0")
            }
        }
    }
    
    static func product(project: ModulePath.Project, app: ModulePath.App) -> Product {
        switch project {
        case .Dying:
            switch app {
            case .IOS: return .app
            case .Watch: return .watch2App
            case .WatchExtension: return .watch2Extension
            }
        }
    }
    
    static func bundleId(project: ModulePath.Project, app: ModulePath.App) -> String {
        return self.bundleIdPrefix(project: project) + "." + ModulePath.App.name.lowercased() + "." + app.rawValue.lowercased()
    }
}

//MARK: Project.Environment + Feature

public extension Project.Environment {
    static func name(project: ModulePath.Project, feature module: ModulePath.Feature, microType: MicroType) -> String {
        return self.namePrefix(project: project) + ModulePath.Feature.name + module.rawValue + microType.rawValue
    }
    
    static func deploymentTarget(project: ModulePath.Project, feature: ModulePath.Feature) -> DeploymentTarget {
        switch project {
        case .Dying: return self.deploymentTarget(project: project, app: .IOS)
        }
    }
    
    static func product(project: ModulePath.Project, feature: ModulePath.Feature) -> Product {
        switch project {
        case .Dying: return self.product(project: project, app: .IOS)
        }
    }
    
    static func bundleId(project: ModulePath.Project, feature: ModulePath.Feature) -> String {
        return self.bundleIdPrefix(project: project) + "." + ModulePath.Feature.name.lowercased() + "." + feature.rawValue.lowercased()
    }
}

//MARK: Project.Environment + Domain

public extension Project.Environment {
    static func name(project: ModulePath.Project, domain module: ModulePath.Domain, microType: MicroType) -> String {
        return self.namePrefix(project: project) + ModulePath.Domain.name + module.rawValue + microType.rawValue
    }
    
    static func deploymentTarget(project: ModulePath.Project, domain: ModulePath.Domain) -> DeploymentTarget {
        switch project {
        case .Dying: return self.deploymentTarget(project: project, app: .IOS)
        }
    }
    
    static func product(project: ModulePath.Project, domain: ModulePath.Domain) -> Product {
        switch project {
        case .Dying: return self.product(project: project, app: .IOS)
        }
    }
    
    static func bundleId(project: ModulePath.Project, domain: ModulePath.Domain) -> String {
        return self.bundleIdPrefix(project: project) + "." + ModulePath.Domain.name.lowercased() + "." + domain.rawValue.lowercased()
    }
}

//MARK: Project.Environment + Core

public extension Project.Environment {
    static func name(project: ModulePath.Project, core module: ModulePath.Core, microType: MicroType) -> String {
        return self.namePrefix(project: project) + ModulePath.Core.name + module.rawValue + microType.rawValue
    }
    
    static func deploymentTarget(project: ModulePath.Project, core: ModulePath.Core) -> DeploymentTarget {
        switch project {
        case .Dying: return self.deploymentTarget(project: project, app: .IOS)
        }
    }
    
    static func product(project: ModulePath.Project, core: ModulePath.Core) -> Product {
        switch project {
        case .Dying: return self.product(project: project, app: .IOS)
        }
    }
    
    static func bundleId(project: ModulePath.Project, core: ModulePath.Core) -> String {
        return self.bundleIdPrefix(project: project) + "." + ModulePath.Core.name.lowercased() + "." + core.rawValue.lowercased()
    }
}

//MARK: Project.Environment + Shared

public extension Project.Environment {
    static func name(project: ModulePath.Project, shared module: ModulePath.Shared, microType: MicroType) -> String {
        return self.namePrefix(project: project) + ModulePath.Shared.name + module.rawValue + microType.rawValue
    }
    
    static func deploymentTarget(project: ModulePath.Project, shared: ModulePath.Shared) -> DeploymentTarget {
        switch project {
        case .Dying: return self.deploymentTarget(project: project, app: .IOS)
        }
    }
    
    static func product(project: ModulePath.Project, shared: ModulePath.Shared) -> Product {
        switch project {
        case .Dying: return self.product(project: project, app: .IOS)
        }
    }
    
    static func bundleId(project: ModulePath.Project, shared: ModulePath.Core) -> String {
        return self.bundleIdPrefix(project: project) + "." + ModulePath.Core.name.lowercased() + "." + shared.rawValue.lowercased()
    }
}
