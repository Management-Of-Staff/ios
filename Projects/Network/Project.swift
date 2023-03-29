//
//  Project.swift
//  DoingManifests
//
//  Created by Taehwan Kim on 2023/03/28.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeNetworkModule(
    name: "Network",
    product: .staticFramework,
    dependencies: [
//        .external(name: "AWSS3")
    ]
)
