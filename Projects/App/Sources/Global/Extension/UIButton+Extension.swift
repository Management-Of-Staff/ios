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
            .map { button in
                if button.tintColor == .mainOwner {
                    button.tintColor = .disabledText
                    return false
                } else {
                    button.tintColor = .mainOwner
                    return true
                }
            }
            .eraseToAnyPublisher()
    }
}
