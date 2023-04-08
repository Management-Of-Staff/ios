//
//  SignUpOwnerViewController.swift
//  App
//
//  Created by 이범준 on 4/6/23.
//  Copyright © 2023 Ozik. All rights reserved.
//

import UIKit

class SignUpOwnerViewController: UIViewController {
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        scrollView.backgroundColor = .backgroundNeutral
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let signUpContentsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let nameView: UIView = {
        let view = UIView()
        view.backgroundColor = .backgroundNeutral
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "이름"
        label.textColor = .black
        label.font = .doingFont(size: .button, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nameTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "이름을 입력해 주세요."
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        field.font = .doingFont(size: .button, weight: .regular)
        field.borderStyle = .none
        field.leftViewMode = .always
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private let ownerNumberView: UIView = {
       
        let view = UIView()
        view.backgroundColor = .backgroundNeutral
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let ownerNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "사업자 등록 번호"
        label.textColor = .black
        label.font = .doingFont(size: .button, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ownerNumberTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "사업자 등록 번호를 입력해 주세요."
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        field.font = .doingFont(size: .button, weight: .regular)
        field.borderStyle = .none
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private let ownerNumberButton: UIButton = {
        let button = UIButton()
        button.setTitle("조회", for: .normal)
        button.backgroundColor = .mainOwner
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        button.titleLabel?.font = .doingFont(size: .button, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let passwordView: UIView = {
        let view = UIView()
        view.backgroundColor = .backgroundNeutral
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호"
        label.textColor = .black
        label.font = .doingFont(size: .button, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let passwordAlertLabel: UILabel = {
        let label = UILabel()
        label.text = "영문,숫자 포함 8자리 이상"
        label.textColor = .disabledText
        label.font = .doingFont(size: .caption, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let passwordTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "비밀번호를 입력해 주세요."
        field.font = .doingFont(size: .button, weight: .regular)
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private let passwordShowImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "eye.fill")
        imageView.tintColor = .black1
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let passwordErrorImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "x.circle")
        imageView.tintColor = .black1
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let passwordCheckView: UIView = {
        let view = UIView()
        view.backgroundColor = .backgroundNeutral
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let passwordCheckLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호 재확인"
        label.textColor = .black
        label.font = .doingFont(size: .button, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let passwordCheckAlertLabel: UILabel = {
        let label = UILabel()
        label.text = "영문,숫자 포함 8자리 이상"
        label.textColor = .disabledText
        label.font = .doingFont(size: .caption, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let passwordCountLabel: UILabel = {
        let label = UILabel()
        label.text = "0 / 20"
        label.textColor = .disabledText
        label.font = .doingFont(size: .caption, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let passwordCheckCountLabel: UILabel = {
        let label = UILabel()
        label.text = "0 / 20"
        label.textColor = .disabledText
        label.font = .doingFont(size: .caption, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let passwordCheckTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "비밀번호를 입력해 주세요."
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        field.font = .doingFont(size: .button, weight: .regular)
        field.borderStyle = .none
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private let passwordCheckShowImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "eye.fill")
        imageView.tintColor = .black1
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let passwordCheckErrorImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "x.circle")
        imageView.tintColor = .black1
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let completeButton: UIButton = {
        let button = UIButton()
        button.setTitle("가입 완료", for: .normal)
        button.backgroundColor = .mainOwner
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 6
        button.layer.masksToBounds = true
        button.titleLabel?.font = .doingFont(size: .button, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func ownerNumberButtonAction(sender: UIButton!) {
        print("버튼이 눌렸습니다")
        
        let vc = OwnerNumberPopUpViewController()
        vc.modalPresentationStyle = .overCurrentContext
        
        present(vc, animated: false, completion: nil)
    }

    
//
//    func moreDescriptionButtonTapped(contentView: UIView, profileImage: UIImage, userId: String, feedDescription: String) {
//        let alert = self.storyboard?.instantiateViewController(withIdentifier: "DimmedViewController") as! DimmedViewController
//        alert.modalPresentationStyle = .overCurrentContext
//
//        present(alert, animated: false, completion: nil)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundNeutral
        configureUI()
        createLayout()
        hideKeyboardWhenTappedBackground()
    }
}


// MARK: - UI Function

extension SignUpOwnerViewController {
    
    private func configureUI() {
        view.addSubview(scrollView)
        scrollView.addSubviews(signUpContentsStackView, passwordAlertLabel, passwordCheckAlertLabel, passwordCountLabel, passwordCheckCountLabel, completeButton)
        signUpContentsStackView.addArrangedSubviews(nameView, ownerNumberView, passwordView, passwordCheckView)
        nameView.addSubviews(nameLabel, nameTextField)
        passwordView.addSubviews(passwordLabel, passwordTextField, passwordErrorImage, passwordShowImage)
        passwordCheckView.addSubviews(passwordCheckLabel, passwordCheckTextField, passwordCheckShowImage, passwordCheckErrorImage)
        ownerNumberView.addSubviews(ownerNumberLabel, ownerNumberTextField, ownerNumberButton)
        
        ownerNumberButton.addTarget(self, action: #selector(ownerNumberButtonAction), for: .touchUpInside)

    }
    
    private func createLayout() {

        let stackWidth: CGFloat = 327 / 375
        let stackHeight: CGFloat = 517/812
        let viewHeight: CGFloat = 82/812
        let textFieldHeight: CGFloat = 56/812
        let shortTextFieldWidth: CGFloat = 217/375
        let buttonWidth: CGFloat = 99/375
        let buttonHeight: CGFloat = 31/812
        let completeButtonHeight: CGFloat = 52/812
        
        let phoneCertificationStackHeight: CGFloat = 210/812
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            signUpContentsStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 24),
            signUpContentsStackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            signUpContentsStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: stackWidth),
            signUpContentsStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: stackHeight),
            
//            nameView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: stackWidth),
            nameView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: viewHeight),
            
            nameLabel.topAnchor.constraint(equalTo: nameView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: nameView.leadingAnchor),
            
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            nameTextField.leadingAnchor.constraint(equalTo: nameView.leadingAnchor),
            nameTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: textFieldHeight),
            nameTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: shortTextFieldWidth),
            
            ownerNumberView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: viewHeight),
            
            ownerNumberLabel.topAnchor.constraint(equalTo: ownerNumberView.topAnchor),
            ownerNumberLabel.leadingAnchor.constraint(equalTo: ownerNumberView.leadingAnchor),
            
            ownerNumberTextField.topAnchor.constraint(equalTo: ownerNumberLabel.bottomAnchor, constant: 8),
            ownerNumberTextField.leadingAnchor.constraint(equalTo: ownerNumberView.leadingAnchor),
            ownerNumberTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: textFieldHeight),
            ownerNumberTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: shortTextFieldWidth),
            
            ownerNumberButton.bottomAnchor.constraint(equalTo: ownerNumberView.bottomAnchor, constant: -14),
            ownerNumberButton.trailingAnchor.constraint(equalTo: ownerNumberView.trailingAnchor),
            ownerNumberButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: buttonWidth),
            ownerNumberButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: buttonHeight),
            
            passwordView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: viewHeight),
            
            passwordLabel.topAnchor.constraint(equalTo: passwordView.topAnchor),
            passwordLabel.leadingAnchor.constraint(equalTo: passwordView.leadingAnchor),
            
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 8),
            passwordTextField.leadingAnchor.constraint(equalTo: passwordView.leadingAnchor),
            passwordTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: textFieldHeight),
            passwordTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: stackWidth),
            
            passwordErrorImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 40/812),
            passwordErrorImage.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 40/812),
            passwordErrorImage.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor),
            passwordErrorImage.trailingAnchor.constraint(equalTo: passwordShowImage.leadingAnchor, constant: -8),
            
            passwordShowImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 40/812),
            passwordShowImage.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 40/812),
            passwordShowImage.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor),
            passwordShowImage.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor, constant: 0),
            
            passwordAlertLabel.topAnchor.constraint(equalTo: passwordView.bottomAnchor),
            passwordAlertLabel.leadingAnchor.constraint(equalTo: passwordView.leadingAnchor),
            
            passwordCountLabel.topAnchor.constraint(equalTo: passwordView.bottomAnchor),
            passwordCountLabel.trailingAnchor.constraint(equalTo: passwordView.trailingAnchor),
            
            passwordCheckAlertLabel.topAnchor.constraint(equalTo: passwordCheckView.bottomAnchor),
            passwordCheckAlertLabel.leadingAnchor.constraint(equalTo: passwordCheckView.leadingAnchor),
            
            passwordCheckCountLabel.topAnchor.constraint(equalTo: passwordCheckView.bottomAnchor),
            passwordCheckCountLabel.trailingAnchor.constraint(equalTo: passwordCheckView.trailingAnchor),
            
            passwordCheckView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: viewHeight),
            
            passwordCheckLabel.topAnchor.constraint(equalTo: passwordCheckView.topAnchor),
            passwordCheckLabel.leadingAnchor.constraint(equalTo: passwordCheckView.leadingAnchor),
            
            passwordCheckTextField.topAnchor.constraint(equalTo: passwordCheckLabel.bottomAnchor, constant: 8),
            passwordCheckTextField.leadingAnchor.constraint(equalTo: passwordCheckView.leadingAnchor),
            passwordCheckTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: textFieldHeight),
            passwordCheckTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: stackWidth),
            
            passwordCheckErrorImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 40/812),
            passwordCheckErrorImage.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 40/812),
            passwordCheckErrorImage.centerYAnchor.constraint(equalTo: passwordCheckTextField.centerYAnchor),
            passwordCheckErrorImage.trailingAnchor.constraint(equalTo: passwordCheckShowImage.leadingAnchor, constant: -8),
            
            passwordCheckShowImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 40/812),
            passwordCheckShowImage.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 40/812),
            passwordCheckShowImage.centerYAnchor.constraint(equalTo: passwordCheckTextField.centerYAnchor),
            passwordCheckShowImage.trailingAnchor.constraint(equalTo: passwordCheckTextField.trailingAnchor, constant: 0),
            
            completeButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: completeButtonHeight),
            completeButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: stackWidth),
            completeButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            completeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
            
        ])
    }
    
}
//
//extension UITextField {
//    func useUnderline() {
//        print("underlin 실행")
//        let border = CALayer()
//        let borderWidth = CGFloat(1.0)
//        border.borderColor = UIColor.black.cgColor
//        border.frame = CGRectMake(0, self.frame.size.height - borderWidth, self.frame.size.width, self.frame.size.height)
//        border.borderWidth = borderWidth
//        self.layer.addSublayer(border)
//        self.layer.masksToBounds = true
//    }
//}
//
//class CustomTextFields: UITextField {
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//
//        setupUnderlinedTextField()
//    }
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
//    func setupUnderlinedTextField() {
//        let bottomLayer = CALayer()
//        bottomLayer.frame = CGRect(x: 0, y: self.frame.height, width: self.frame.width - 35, height: 1)
//        bottomLayer.backgroundColor = UIColor.black.cgColor
//        self.layer.addSublayer(bottomLayer)
//    }
//}
