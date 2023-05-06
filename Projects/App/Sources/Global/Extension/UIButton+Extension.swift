//
//  UIButton+Extension.swift
//  App
//
//  Created by 이범준 on 4/29/23.
//  Copyright © 2023 com.Ozik. All rights reserved.
//

import Foundation

import UIKit
import Combine

extension UIButton {
    var touchPublisher: AnyPublisher<Bool, Never> {
        controlPublisher(for: .touchUpInside)
            .compactMap { button in
                button.isSelected.toggle()
                return button.isSelected
            }
            .eraseToAnyPublisher()
    }
}

class ToggleButton: UIButton { // 폴더 이동 필요
     override open var isSelected: Bool {
         didSet {
             tintColor = isSelected ? .mainOwner : .disabledText
         }
     }
}
