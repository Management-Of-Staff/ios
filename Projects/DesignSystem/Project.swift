//
//  Project.swift
//  DoingManifests
//
//  Created by Taehwan Kim on 2023/03/28.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeDesignSystemModule(
    name: "DesignSystem",
    product: .staticFramework,
    packages: [],
    dependencies: [],
    resources: ["Resources/**"]
)
