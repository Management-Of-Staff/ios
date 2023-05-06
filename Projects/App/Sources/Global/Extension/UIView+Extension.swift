//
//  UIView+Extension.swift
//  DesignSystem
//
//  Created by Taehwan Kim on 2023/03/31.
//  Copyright © 2023 Ozik. All rights reserved.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach {
            addSubview($0)
        }
    }
}
    
extension UIView {
    var width: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    var height: CGFloat {
        return UIScreen.main.bounds.height
    }
}

// MARK: - Animation

extension UIView {
    
    func willHide(with duration: CGFloat) {
        UIView.animateKeyframes(withDuration: duration, delay: 0) {
            self.alpha = 0
        } completion: { _ in
            self.alpha = 1
            self.isHidden = true
        }
    }

    func willShow(with duration: CGFloat) {
        self.isHidden = false
        self.alpha = 0
        UIView.animateKeyframes(withDuration: duration, delay: 0) {
            self.alpha = 1
        } completion: { _ in
        }
    }
}

// MARK: - Design

extension UIView {
    func addShadow() {
        self.layer.cornerRadius = 4
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowOpacity = 0.7
        self.layer.shadowRadius = 1
    }
}
