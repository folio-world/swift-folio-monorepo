//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 송영모 on 2023/04/21.
//

import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: ModulePath.Project.name+ModulePath.App.name,
    targets: [
        .app(implements: .IOS, factory: .init())
        .feature(
            interface: .Workout,
            factory: .init(
                dependencies: [
                    .domain
                ]
            )
        ),
        .feature(
            implements: .Workout,
            factory: .init(
                dependencies: [
                    .feature(interface: .Workout)
                ]
            )
        ),
        .feature(
            testing: .Workout,
            factory: .init(
                dependencies: [
                    .feature(interface: .Workout)
                ]
            )
        ),
        .feature(
            tests: .Workout,
            factory: .init(
                dependencies: [
                    .feature(testing: .Workout)
                ]
            )
        ),
        .feature(
            example: .Workout,
            factory: .init(
                infoPlist: .extendingDefault(
                    with: [
                        "CFBundleShortVersionString": "1.0",
                        "CFBundleVersion": "1",
                        "UILaunchStoryboardName": "LaunchScreen",
                        "UIApplicationSceneManifest": [
                            "UIApplicationSupportsMultipleScenes": false,
                            "UISceneConfigurations": []
                        ]
                    ]),
                dependencies: [
                    .feature(interface: .Workout),
                    .feature(implements: .Workout)
                ]
            )
        )
    ]
)


let targets: [Target] = [
    .app(
        implements: .IOS,
        factory: .init(
            infoPlist: .extendingDefault(
                with: [
                    "CFBundleShortVersionString": "1.0",
                    "CFBundleVersion": "1",
                    "UILaunchStoryboardName": "LaunchScreen",
                    "UIApplicationSceneManifest": [
                        "UIApplicationSupportsMultipleScenes": false,
                        "UISceneConfigurations": []
                    ],
                    "NSHealthShareUsageDescription" : "이 앱은 운동, 수면 및 건강 정보를 추적하고 관리하기 위해 HealthKit 데이터를 공유할 수 있습니다.",
                    "NSHealthUpdateUsageDescription" : "이 앱은 운동, 수면 및 건강 정보를 추적하고 관리하기 위해 HealthKit 데이터를 기록할 수 있습니다.",
                ]),
            entitlements: "Pumping.entitlements",
            dependencies: [
                .feature(project: .Diebeing)
            ]
        )
    )
]

let project: Project = .makeModule(
    name: "Pumping",
    targets: targets
)
