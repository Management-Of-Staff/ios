//
//  UIImage+Extension.swift
//  DesignSystemTests
//
//  Created by Taehwan Kim on 2023/03/31.
//  Copyright © 2023 Ozik. All rights reserved.
//

import UIKit

public extension UIImage {
    convenience init?(_ asset: Asset) {
        self.init(named: asset.rawValue, in: Bundle.module, with: nil)
    }
    convenience init?(assetName: String) {
        self.init(named: assetName, in: Bundle.module, with: nil)
    }
}
