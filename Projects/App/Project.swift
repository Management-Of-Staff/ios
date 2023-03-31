//
//  Project.swift
//  DoingManifests
//
//  Created by Taehwan Kim on 2023/03/28.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeAppModule(
    name: "App",
    platform: .iOS,
    product: .app,
    dependencies: [
        .Project.Network,
        .Project.DesignSystem,
        .external(name: "CombineMoya"),
        .external(name: "Kingfisher"),
        .external(name: "FirebaseAnalytics")
    ],
    resources: ["Resources/**"],
    infoPlist: .file(path: "Sources/Application/Info.plist"),
    entitlements: .relativeToCurrentFile("App.entitlements")
)
