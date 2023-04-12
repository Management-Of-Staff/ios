//
//  OwnerNumberPopUpViewController.swift
//  App
//
//  Created by 이범준 on 4/9/23.
//  Copyright © 2023 Ozik. All rights reserved.
//

import UIKit

class OwnerNumberPopUpViewController: UIViewController {

    private let backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let contentLabel: UILabel = {
        let label = UILabel()
        label.text = "올바른 사업자 정보입니다."
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let contentButton: UIButton = {
        let button = UIButton()
        button.setTitle("확인", for: .normal)
        button.backgroundColor = .mainOwner  //수정
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 6
        button.layer.masksToBounds = true
        button.titleLabel?.font = .doingFont(size: .button, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        createLayout()
        view.backgroundColor = UIColor(rgb: 0xE6E6E6) // 임시 색 수정해야함
    }
    
    @objc func dismissButtonAction(sender: UIButton!) {
        print("버튼이 눌렸습니다")
        dismiss(animated: false)
    }
}

extension OwnerNumberPopUpViewController {
    
    private func configureUI() {
        view.addSubview(backgroundView)
        backgroundView.addSubview(contentView)
        contentView.addSubviews(contentLabel, contentButton)
        contentButton.addTarget(self, action: #selector(dismissButtonAction), for: .touchUpInside)
    }
    
    private func createLayout() {
        let contentWidth: CGFloat = 327/375
        let contentHeight: CGFloat = 180/812  //위에는 286 아래는 346
        let buttonWidth: CGFloat = 139/375
        let buttonHeight: CGFloat = 44/812
        
        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.widthAnchor.constraint(equalTo: backgroundView.widthAnchor, multiplier: contentWidth),
            contentView.heightAnchor.constraint(equalTo: backgroundView.heightAnchor, multiplier: contentHeight),
            contentView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            
            contentLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            contentLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            
            contentButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            contentButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),
            contentButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: buttonWidth),
            contentButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: buttonHeight)
        ])
    }
    
}

extension UIColor {
    convenience init(rgb: UInt) {
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: CGFloat(0.5)
        )
    }
}
