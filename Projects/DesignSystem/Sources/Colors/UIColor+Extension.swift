//
//  UIColor+Extension.swift
//  DesignSystem
//
//  Created by Taehwan Kim on 2023/03/31.
//  Copyright © 2023 Ozik. All rights reserved.
//

import UIKit

public extension UIColor {
    static func doingColor(_ color: Color) -> UIColor? {
        return UIColor(named: color.rawValue, in: Bundle.module, compatibleWith: nil)
    }
}

public extension UIColor {
    
    // MARK: Background
    static let backgroundNeutral = doingColor(.backgroundNeutral)
    static let mainOwner = doingColor(.mainOwner)
}
