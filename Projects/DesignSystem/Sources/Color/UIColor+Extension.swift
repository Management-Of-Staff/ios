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
    static let neutral1 = doingColor(.neutral1)
    static let neutral2 = doingColor(.neutral2)
    static let neutral3 = doingColor(.neutral3)
    
    static let black1 = doingColor(.black1)
    static let black2 = doingColor(.black2)
    static let black3 = doingColor(.black3)
    static let black4 = doingColor(.black4)
    
    static let disabledText = doingColor(.disabledText)
}
