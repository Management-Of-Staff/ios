//
//  UIFont+Extension.swift
//  DesignSystem
//
//  Created by Taehwan Kim on 2023/03/31.
//  Copyright © 2023 Ozik. All rights reserved.
//

import UIKit

public extension UIFont {
    static func doingFont(size: Font.Size, weight: Font.Weight) -> UIFont {
        return .systemFont(ofSize: size.rawValue, weight: weight.value)
    }
    
    private func withTraits(traits: UIFontDescriptor.SymbolicTraits) -> UIFont {
        let descriptor = fontDescriptor.withSymbolicTraits(traits)
        return UIFont(descriptor: descriptor!, size: 0)
    }
    
    func bold() -> UIFont {
        return withTraits(traits: .traitBold)
    }

    func italic() -> UIFont {
        return withTraits(traits: .traitItalic)
    }
}
