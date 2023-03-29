//
//  Dependency+Project.swift
//  DoingManifests
//
//  Created by Taehwan Kim on 2023/03/28.
//

import ProjectDescription

public extension TargetDependency {
    enum Projcet {}
}

public extension TargetDependency.Projcet {
    static let Network = TargetDependency.project(target: "Network", path: .relativeToRoot("Projects/Network"))
    static let DesignSystem = TargetDependency.project(target: "DesignSystem", path: .relativeToRoot("Projects/DesignSystem"))
}
