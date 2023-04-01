//
//  UIViewController+Extension.swift
//  App
//
//  Created by Taehwan Kim on 2023/04/01.
//  Copyright © 2023 Ozik. All rights reserved.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedBackground() {
         let tapEvent = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
         tapEvent.cancelsTouchesInView = false
         view.addGestureRecognizer(tapEvent)
    }
    
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
