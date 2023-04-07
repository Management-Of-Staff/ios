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
import SwiftUI

final class LoginViewController: UIViewController {
    
    // MARK: - Properties
    private var cancellables = Set<AnyCancellable>()
    private let viewModel = LoginViewModel()
    private var keyboardEndFrameHeight: CGFloat?
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        scrollView.backgroundColor = .backgroundNeutral
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        // MARK: 디자인 시스템이 있긴한데 현재 작동 안 됨. 원인 파악해야함
        imageView.image = DesignSystemImages.Image(assetName: "img_logo")
//        imageView.image = UIImage(.imgLogo)
        imageView.contentMode = .scaleAspectFit
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
        button.backgroundColor = .gray
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 6
        button.layer.masksToBounds = true
        button.isEnabled = false
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
    
    private let signUpButton: UIButton = {
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
        bind(to: viewModel)
    }
    
    // MARK: - Function
    
    private func remakeConstraintsByKeyboard(_ state: KeyboardState) {
        guard self.keyboardEndFrameHeight != nil else {
            return
        }
        switch state {
        case .show:
            self.view.frame.origin.y = -100
        case .hide:
            self.view.frame.origin.y = 0
        }
    }

    private func bind(to viewModel: LoginViewModel) {
        
        let input = LoginViewModel.Input(
            phoneNumber: phoneNumberField.textPublisher.eraseToAnyPublisher(),
            password: passwordField.textPublisher.eraseToAnyPublisher()
        )

        let output = viewModel.transform(input: input)
        
        output.resultPhoneNumber
            .sink { [weak self] in
                self?.phoneNumberField.text = $0 }
            .store(in: &cancellables)
        
        output.buttonState
            .sink { [weak self] state in
                self?.loginButton.isEnabled = state
                self?.loginButton.backgroundColor = state ? .doingColor(.mainOwner) : .gray
            }
            .store(in: &cancellables)

        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        
        findPasswordButton.addTarget(self, action: #selector(didTapFindPasswordButton), for: .touchUpInside)
        
        signUpButton.addTarget(self, action: #selector(didTapSignUpButton), for: .touchUpInside)
        NotificationCenter.default
            .publisher(for: UIApplication.keyboardWillShowNotification)
            .sink { [weak self] notification in
                guard let self = self else { return }
                if self.keyboardEndFrameHeight == nil {
                    guard let endFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
                    self.keyboardEndFrameHeight = endFrame.cgRectValue.height
                }
                self.remakeConstraintsByKeyboard(.show)
                self.view.layoutIfNeeded()
            }
            .store(in: &cancellables)
        
        NotificationCenter.default
            .publisher(for: UIApplication.keyboardWillHideNotification)
            .sink { [weak self ] _ in
                guard let self = self else { return }
                self.remakeConstraintsByKeyboard(.hide)
                self.view.layoutIfNeeded()
            }
            .store(in: &cancellables)
    }
}

// MARK: - UI Function

extension LoginViewController {
    
    private func configureUI() {
        view.addSubview(scrollView)
        scrollView.addSubviews(logoImageView, segmentedControl, loginStackView, bottomStackView)
        loginStackView.addArrangedSubviews(phoneNumberField, passwordField, loginButton)
        bottomStackView.addArrangedSubviews(findPasswordButton, signUpButton)
    }
    
    @objc
    private func didTapLoginButton() {
        // MARK: 임시 Alert 나중에 커스텀으로 만들어 줘야함.
        // 기본 틀은 대충 만들었는데 나중에 수정할것 -> ConfirmViewController (Alert으로 할까 생각중)
        print(phoneNumberField.text!)
        print(passwordField.text!)
        show(TabViewController(), sender: self)
//        let alert = UIAlertController(title: "", message: "전화번호 또는 비밀번호가 일치하지 않습니다.", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "예", style: .default))
//        present(alert, animated: true)
    }
    
    @objc
    private func didTapFindPasswordButton() {
        show(FindPasswordViewController(), sender: self)
    }
    
    @objc
    private func didTapSignUpButton() {
        show(SignUpOwnerViewController(), sender: self)
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
            signUpButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: bottomStackHeight)
        ])
    }
}

extension LoginViewController {
    private enum KeyboardState {
        case show
        case hide
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct ViewController_Preview: PreviewProvider {
    static var previews: some View {
        LoginViewController()
            .showPreview(.iPhone12Pro)
            
    }
}
#endif


enum DeviceType {
    case iPhoneSE2
    case iPhone8
    case iPhone12Pro
    case iPhone12ProMax

    func name() -> String {
        switch self {
        case .iPhoneSE2:
            return "iPhone SE"
        case .iPhone8:
            return "iPhone 8"
        case .iPhone12Pro:
            return "iPhone 12 Pro"
        case .iPhone12ProMax:
            return "iPhone 12 Pro Max"
        }
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI


extension UIViewController {

    private struct Preview: UIViewControllerRepresentable {
        let viewController: UIViewController

        func makeUIViewController(context: Context) -> UIViewController {
            return viewController
        }

        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        }
    }

    func showPreview(_ deviceType: DeviceType = .iPhone12Pro) -> some View {
        Preview(viewController: self).previewDevice(PreviewDevice(rawValue: deviceType.name()))
    }
}
#endif
