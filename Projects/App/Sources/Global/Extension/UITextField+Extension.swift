//
//  UITextField+Extension.swift
//  App
//
//  Created by Taehwan Kim on 2023/04/04.
//  Copyright © 2023 Ozik. All rights reserved.
//

import Combine
import UIKit

extension UITextField {
    var publisher: AnyPublisher<String, Never> {
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: self)
            .compactMap { $0.object as? UITextField }
            .compactMap { $0.text }
            .eraseToAnyPublisher()
    }
}
