//
//  LoginViewController.swift
//  App
//
//  Created by Taehwan Kim on 2023/03/30.
//  Copyright (c) 2023 Ozik. All rights reserved.
//

import UIKit
import Combine
import DesignSystem

final class LoginViewController: UIViewController {
    
    // MARK: - Properties
    private var cancelBag = Set<AnyCancellable>()
    private let viewModel = LoginViewModel()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        scrollView.backgroundColor = .backgroundNeutral
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        // 디자인 시스템이 있긴한데 현재 작동 안 됨. 원인 파악해야함
        imageView.image = DesignSystemImages.Image(assetName: "img_logo")
//        imageView.image = UIImage(.imgLogo)
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .lightGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["오너 로그인", "직원 로그인"])
        let attribute = [NSAttributedString.Key.foregroundColor: UIColor.black4, NSAttributedString.Key.font: UIFont.doingFont(size: .caption, weight: .regular)]
        control.setTitleTextAttributes(attribute as [NSAttributedString.Key: Any], for: .normal)
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    private let loginStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let phoneNumberField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.keyboardType = .numberPad
        field.returnKeyType = .continue
        field.layer.cornerRadius = 6
        field.placeholder = "휴대폰 번호를 입력해주세요"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        field.leftViewMode = .always
        field.clearButtonMode = .whileEditing
        field.textColor = .disabledText
        field.backgroundColor = .neutral2
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .done
        field.layer.cornerRadius = 6
        field.placeholder = "비밀번호를 입력해주세요"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        field.leftViewMode = .always
        field.clearButtonMode = .whileEditing
        field.isSecureTextEntry = true
        field.textColor = .disabledText
        field.backgroundColor = .neutral2
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그인", for: .normal)
        button.backgroundColor = .mainOwner
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 6
        button.layer.masksToBounds = true
        button.titleLabel?.font = .doingFont(size: .button, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let bottomStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let findPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("비밀번호 찾기", for: .normal)
        button.titleLabel?.font = .doingFont(size: .button, weight: .medium)
        button.setTitleColor(.black4, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("회원가입", for: .normal)
        button.titleLabel?.font = .doingFont(size: .button, weight: .medium)
        button.setTitleColor(.mainOwner, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundNeutral
        configureUI()
        createLayout()
        hideKeyboardWhenTappedBackground()
        self.segmentedControl.selectedSegmentIndex = 0
    }
    
    // MARK: - Function
    
}

// MARK: - UI Function

extension LoginViewController {
    
    private func configureUI() {
        view.addSubview(scrollView)
        scrollView.addSubviews(logoImageView, segmentedControl, loginStackView, bottomStackView)
        loginStackView.addArrangedSubviews(phoneNumberField, passwordField, loginButton)
        bottomStackView.addArrangedSubviews(findPasswordButton, signInButton)
    }
    
    private func createLayout() {
        let loginStackWidth: CGFloat = 327/375
        let loginStackHeight: CGFloat = 204/812
        let loginButtonHeight: CGFloat = 52/812
        let textFieldHeight: CGFloat = 56/812
        
        let segmentWidth: CGFloat = 327/375
        let segmentHeight: CGFloat = 43/812
        let logoHeight: CGFloat = 201/812
        
        let bottomStackWidth: CGFloat = 220/375
        let bottomStackHeight: CGFloat = 40/812
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            logoImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.topAnchor, constant: 0),
            logoImageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            logoImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: logoHeight),
            
            segmentedControl.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 10),
            segmentedControl.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            segmentedControl.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: segmentWidth),
            segmentedControl.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: segmentHeight),
            
            loginStackView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 30),
            loginStackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            loginStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: loginStackWidth),
            loginStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: loginStackHeight),
            
            phoneNumberField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: textFieldHeight),
            passwordField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: textFieldHeight),
            loginButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: loginButtonHeight),
            
            bottomStackView.topAnchor.constraint(equalTo: loginStackView.bottomAnchor, constant: 30),
            bottomStackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            bottomStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: bottomStackWidth),
            bottomStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: bottomStackHeight),
            
            findPasswordButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: bottomStackHeight),
            signInButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: bottomStackHeight)
        ])
    }
    
}
