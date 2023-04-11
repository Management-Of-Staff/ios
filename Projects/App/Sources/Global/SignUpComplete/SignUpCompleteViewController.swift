//
//  SignUpCompleteViewController.swift
//  App
//
//  Created by Taehwan Kim on 2023/04/03.
//  Copyright (c) 2023 Ozik. All rights reserved.
//

import UIKit
import Combine
import DesignSystem

final class SignUpCompleteViewController: UIViewController {
    
    // MARK: - Properties
    private var cancelBag = Set<AnyCancellable>()
    private let viewModel = SignUpCompleteViewModel()
    private let beginButton = UIButton()
    private let checkImage = UIImageView()
    private let welcomeLabel = UILabel()
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        createLayout()
        beginButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
    }
    
    // MARK: - Function
    @objc
    private func didTapButton() {
        // MARK: 여기 가는 ViewController 수정할 것
        let viewController = ViewController()
        self.show(viewController, sender: self)
        
    }
}

// MARK: - UI Function

extension SignUpCompleteViewController {
    
    private func configureUI() {
        
        view.backgroundColor = .doingColor(.backgroundNeutral)
        checkImage.image = DesignSystemImages.Image(assetName: "img_check")
        checkImage.contentMode = .scaleAspectFit
        
        welcomeLabel.text = "두잉 회원이 되셨어요!"
        welcomeLabel.font = .doingFont(size: .headline3, weight: .bold)
        
        beginButton.setTitle("시작하기", for: .normal)
        beginButton.backgroundColor = .mainOwner
        beginButton.setTitleColor(.doingColor(.backgroundNeutral), for: .normal)
        beginButton.layer.cornerRadius = 6
        beginButton.layer.masksToBounds = true
        beginButton.titleLabel?.font = .doingFont(size: .button, weight: .bold)
        
        checkImage.translatesAutoresizingMaskIntoConstraints = false
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        beginButton.translatesAutoresizingMaskIntoConstraints = false
    }

    private func createLayout() {
        view.addSubviews(checkImage, welcomeLabel, beginButton)
        let imageWidth: CGFloat = 153 / 375
        let imageHeight: CGFloat = 170 / 812
        let buttonWidth: CGFloat = 327 / 375
        let buttonHeight: CGFloat = 52 / 812
        
        NSLayoutConstraint.activate([
            checkImage.topAnchor.constraint(equalTo: view.topAnchor, constant: view.height * (200/812)),
            checkImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            checkImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: imageWidth),
            checkImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: imageHeight),
            
            welcomeLabel.topAnchor.constraint(equalTo: checkImage.bottomAnchor, constant: 20),
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            beginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            beginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            beginButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: buttonWidth),
            beginButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: buttonHeight)
        ])
    }
}
