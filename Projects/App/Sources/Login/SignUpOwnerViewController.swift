//
//  SignUpOwnerViewController.swift
//  App
//
//  Created by 이범준 on 4/6/23.
//  Copyright © 2023 Ozik. All rights reserved.
//

import UIKit
import Combine

// 텍스트 필드 밑줄 생성
// 레이아웃 조정
// 색 조정
// 글꼴 조정

class SignUpOwnerViewController: UIViewController {
    
    private var cancellables = Set<AnyCancellable>()
    private let viewModel = MainViewModel()
    var ownerNumberState: Bool = false
    
    
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
    
    private let passwordAlertStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let passwordCheckAlertStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
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
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.keyboardType = .numberPad
        field.returnKeyType = .continue
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        field.leftViewMode = .always
        field.font = .doingFont(size: .button, weight: .regular)
        field.borderStyle = .none
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private let ownerNumberButton: UIButton = {
        let button = UIButton()
        button.setTitle("조회", for: .normal)
        button.backgroundColor = .systemGray
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
    
    private let passwordAlertImage: UIImageView = {
        let imageView = UIImageView()
        imageView.isHidden = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        field.borderStyle = .line
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        field.leftViewMode = .always
        field.font = .doingFont(size: .button, weight: .regular)
        field.isSecureTextEntry = true
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private let passwordShowButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        button.isHidden = true
        button.tintColor = .black1
        button.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let passwordDeleteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "x.circle"), for: .normal)
        button.isHidden = true
        button.tintColor = .black1
        button.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let passwordCheckView: UIView = {
        let view = UIView()
        view.backgroundColor = .backgroundNeutral
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let passwordCheckAlertImage: UIImageView = {
        let imageView = UIImageView()
        imageView.isHidden = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        field.borderStyle = .line
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        field.leftViewMode = .always
        field.isSecureTextEntry = true
        field.font = .doingFont(size: .button, weight: .regular)
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private let passwordCheckShowButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        button.isHidden = true
        button.tintColor = .black1
        button.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let passwordCheckDeleteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "x.circle"), for: .normal)
        button.isHidden = true
        button.tintColor = .black1
        button.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let completeButton: UIButton = {
        let button = UIButton()
        button.setTitle("가입 완료", for: .normal)
        button.backgroundColor = .systemGray
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 6
        button.layer.masksToBounds = true
        button.isEnabled = false
        button.titleLabel?.font = .doingFont(size: .button, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
}

extension SignUpOwnerViewController {
    private func bind(to viewModel: MainViewModel) {
        
        let input = MainViewModel.Input(
            userName: nameTextField.textPublisher.eraseToAnyPublisher(),
            ownerNumber: ownerNumberTextField.textPublisher.eraseToAnyPublisher(),
            password: passwordTextField.textPublisher.eraseToAnyPublisher(),
            passwordCheck: passwordCheckTextField.textPublisher.eraseToAnyPublisher()
        )

        let output = viewModel.transform(input: input)
        
        output
            .ownerNumberLimit
            .sink { [weak self] in
                self?.ownerNumberTextField.text = $0
                if self?.ownerNumberTextField.text?.count == 10 {
                    self?.ownerNumberButton.backgroundColor = .mainOwner
                    self?.ownerNumberButton.isEnabled = true
                    print("클릭됨")
                } else {
                    self?.ownerNumberButton.backgroundColor = .disabledText // 수정 필요
                    self?.ownerNumberButton.isEnabled = false
                }
            }
            .store(in: &cancellables)
        
        output
            .passwordLimit
            .sink { [weak self] in
                self?.passwordTextField.text = $0 }
            .store(in: &cancellables)
        
        output
            .passwordCheckLimit
            .sink { [weak self] in
                self?.passwordCheckTextField.text = $0 }
            .store(in: &cancellables)
        
        output
            .passwordIsValid
            .sink { [weak self] state in
                if state == true {
                    self?.passwordAlertLabel.text = "비밀번호가 일치합니다"
                    self?.passwordAlertLabel.textColor = .green
                    self?.passwordAlertImage.image = UIImage(systemName: "checkmark.circle.fill")
                    self?.passwordAlertImage.tintColor = .green
                } else {
                    self?.passwordAlertLabel.text = "비밀번호가 일치하지 않습니다"
                    self?.passwordAlertLabel.textColor = .red
                    self?.passwordAlertImage.image = UIImage(systemName: "exclamationmark.circle.fill")
                    self?.passwordAlertImage.tintColor = .red
                }
                
            }
            .store(in: &cancellables)
        
        output
            .passwordCount
            .sink { [weak self] in
                self?.passwordCountLabel.text = "\(String($0.count)) / 20"
                if $0.count != 0 {
                    self?.passwordDeleteButton.isHidden = false
                    self?.passwordShowButton.isHidden = false
                    self?.passwordAlertImage.isHidden = false
                } else {
                    self?.passwordDeleteButton.isHidden = true
                    self?.passwordShowButton.isHidden = true
                    self?.passwordAlertLabel.text = "영문, 숫자 포함 8자리 이상"
                    self?.passwordAlertLabel.textColor = .disabledText
                    self?.passwordAlertImage.isHidden = true
                }
            }
            .store(in: &cancellables)
        
        output
            .passwordCheckIsValid
            .sink { [weak self] state in
                print("현재 \(state)")
                if state == true {
                    self?.passwordCheckAlertLabel.text = "비밀번호가 일치합니다"
                    self?.passwordCheckAlertLabel.textColor = .green
                    self?.passwordCheckAlertImage.image = UIImage(systemName: "checkmark.circle.fill")
                    self?.passwordCheckAlertImage.tintColor = .green
                } else {
                    self?.passwordCheckAlertLabel.text = "비밀번호가 일치하지 않습니다"
                    self?.passwordCheckAlertLabel.textColor = .red
                    self?.passwordCheckAlertImage.image = UIImage(systemName: "exclamationmark.circle.fill")
                    self?.passwordCheckAlertImage.tintColor = .red
                }
                
            }
            .store(in: &cancellables)
        
        output
            .passwordCheckCount
            .sink { [weak self] in
                self?.passwordCheckCountLabel.text = "\(String($0.count)) / 20"
                if $0.count != 0 {
                    self?.passwordCheckDeleteButton.isHidden = false
                    self?.passwordCheckShowButton.isHidden = false
                    self?.passwordCheckAlertImage.isHidden = false
                } else {
                    self?.passwordCheckDeleteButton.isHidden = true
                    self?.passwordCheckShowButton.isHidden = true
                    self?.passwordCheckAlertLabel.text = "영문, 숫자 포함 8자리 이상"
                    self?.passwordCheckAlertLabel.textColor = .disabledText
                    self?.passwordCheckAlertImage.isHidden = true
                }
            }
            .store(in: &cancellables)

        output
            .buttonIsValid
            .sink(receiveValue: { [weak self] state in
                print(state)
                self?.completeButton.isEnabled = state
                self?.completeButton.backgroundColor = state ? .mainOwner : .systemGray
            })
            .store(in: &cancellables)
        
    }
}

extension SignUpOwnerViewController {
    
    @objc func ownerNumberButtonAction(sender: UIButton!) {
        print("버튼이 눌렸습니다")
        let vc = OwnerNumberPopUpViewController()
        
        if ownerNumberIsValid(ownerNumber: ownerNumberTextField.text ?? "") {
            vc.contentLabel.text = "올바른 사업자 정보입니다."
//            self.ownerNumberState = true
        } else {
            vc.contentLabel.text = "사업자 정보를 찾을 수 없습니다."
//            self.ownerNumberState = false
        }
        vc.modalPresentationStyle = .overCurrentContext
        
        present(vc, animated: false, completion: nil)
    }
    
    @objc func showPasswordButtonAction(sender: UIButton!) {
        passwordTextField.isSecureTextEntry.toggle()
        passwordTextField.isSecureTextEntry ? passwordShowButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal) : passwordShowButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        print("비밀번호 보여주기")
    }
    
    @objc func deletePasswordButtonAction(sender: UIButton!) {
        viewModel
        passwordTextField.text = ""
        print("비밀번호 전체 삭제하기")
    }
    
    @objc func showPasswordCheckButtonAction(sender: UIButton!) {
        passwordCheckTextField.isSecureTextEntry.toggle()
        print("비밀번호 보여주기")
    }
    
    @objc func deletePasswordCheckButtonAction(sender: UIButton!) {
        passwordCheckTextField.text = ""
        print("비밀번호 전체 삭제하기")
    }
    
    @objc func completeButtonAction(sender: UIButton!) {
        print("회원가입을 완료했습니다")
    }
    // 사업자 검증 함수
    func ownerNumberIsValid(ownerNumber: String) -> Bool {
        let veriNum: String = "137137135"           // 검증 대응숫자
        var checkSum: Int = 0                       // 검증번호

        var bizNumArr: [Int] = []
        for char in ownerNumber {
            bizNumArr.append(Int(String(char)) ?? 0)
        }

        var veriNumArr: [Int] = []
        for char in veriNum {
            veriNumArr.append(Int(String(char)) ?? 0)
        }

        // 1. 검증 대응숫자 기준으로 두 값을 곱하여 1의 자리 숫자를 추출
        var addValueArr: [Int] = []
        var sum: Int = 0;
        for num in 0...veriNumArr.count-1 {
            var tmp = bizNumArr[num] * veriNumArr[num]
            
            // 1~8 자리의 곱이 10 이상일 경우는 1자리의 숫자만 사용한다.
            if num < veriNumArr.count-1 {
                if tmp > 10 {
                    tmp = tmp%10
                }
                sum += tmp
            }
            addValueArr.append(tmp)
        }

        // 2. 마지막 9번번째 자리의 경우 10 이상일 경우 십의 자리와 일의 자리를 따로 숫자로 떼어서 합한다.
        if addValueArr[addValueArr.count-1] >= 10 {
            var lastNumStr = String(addValueArr[addValueArr.count-1])
            var lastNumArr: [Int] = []
            for char in lastNumStr {
                lastNumArr.append(Int(String(char)) ?? 0)
            }
            sum += lastNumArr[0]
            sum += lastNumArr[1]
        }
        else {
            sum += addValueArr[addValueArr.count-1]
        }

        // 3. 검증 숫자 검출
        checkSum = 10 - sum%10
        if checkSum==10 {checkSum=0}

        // 4. 검증
        if checkSum == bizNumArr[bizNumArr.count-1] {
            print("검증 성공!")
            return true
        }
        else {
            print("검증 실패!")
            return false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundNeutral
        configureUI()
        createLayout()
        hideKeyboardWhenTappedBackground()
        bind(to: viewModel)
    }
}

// MARK: - UI Function

extension SignUpOwnerViewController {
    
    private func configureUI() {
        view.addSubview(scrollView)
        scrollView.addSubviews(signUpContentsStackView, passwordAlertStackView, passwordCheckAlertStackView, passwordCountLabel, passwordCheckCountLabel, completeButton)
        signUpContentsStackView.addArrangedSubviews(nameView, ownerNumberView, passwordView, passwordCheckView)
        nameView.addSubviews(nameLabel, nameTextField)
        passwordView.addSubviews(passwordLabel, passwordTextField, passwordDeleteButton, passwordShowButton)
        passwordAlertStackView.addArrangedSubviews(passwordAlertImage, passwordAlertLabel)
        passwordCheckAlertStackView.addArrangedSubviews(passwordCheckAlertImage, passwordCheckAlertLabel)
        passwordCheckView.addSubviews(passwordCheckLabel, passwordCheckTextField, passwordCheckShowButton, passwordCheckDeleteButton)
        ownerNumberView.addSubviews(ownerNumberLabel, ownerNumberTextField, ownerNumberButton)
        
        ownerNumberButton.addTarget(self, action: #selector(ownerNumberButtonAction), for: .touchUpInside)
        
        passwordShowButton.addTarget(self, action: #selector(showPasswordButtonAction), for: .touchUpInside)
        passwordDeleteButton.addTarget(self, action: #selector(deletePasswordButtonAction), for: .touchUpInside)
        passwordCheckShowButton.addTarget(self, action: #selector(showPasswordCheckButtonAction), for: .touchUpInside)
        passwordCheckDeleteButton.addTarget(self, action: #selector(deletePasswordCheckButtonAction), for: .touchUpInside)
        completeButton.addTarget(self, action: #selector(completeButtonAction), for: .touchUpInside)

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
        let alertStackHeight: CGFloat = 23/812
        
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
            
            passwordDeleteButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 40/812),
            passwordDeleteButton.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 40/812),
            passwordDeleteButton.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor),
            passwordDeleteButton.trailingAnchor.constraint(equalTo: passwordShowButton.leadingAnchor, constant: -8),
            
            passwordShowButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 40/812),
            passwordShowButton.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 40/812),
            passwordShowButton.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor),
            passwordShowButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor, constant: 0),
            
            passwordAlertStackView.leadingAnchor.constraint(equalTo: passwordView.leadingAnchor, constant: 15),
            passwordAlertStackView.topAnchor.constraint(equalTo: passwordView.bottomAnchor),
            passwordAlertStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: alertStackHeight),
            passwordAlertStackView.widthAnchor.constraint(equalTo: passwordView.widthAnchor),

            passwordAlertLabel.leadingAnchor.constraint(equalTo: passwordAlertImage.trailingAnchor),

            passwordAlertImage.leadingAnchor.constraint(equalTo: passwordAlertStackView.leadingAnchor),
            passwordAlertImage.widthAnchor.constraint(equalToConstant: 14),
            passwordAlertImage.heightAnchor.constraint(equalToConstant: 14),
            
            
            passwordCheckAlertStackView.leadingAnchor.constraint(equalTo: passwordCheckView.leadingAnchor, constant: 15),
            passwordCheckAlertStackView.topAnchor.constraint(equalTo: passwordCheckView.bottomAnchor),
            passwordCheckAlertStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: alertStackHeight),
            passwordCheckAlertStackView.widthAnchor.constraint(equalTo: passwordCheckView.widthAnchor),

            passwordCheckAlertLabel.leadingAnchor.constraint(equalTo: passwordCheckAlertImage.trailingAnchor),

            passwordCheckAlertImage.leadingAnchor.constraint(equalTo: passwordCheckAlertStackView.leadingAnchor),
            passwordCheckAlertImage.widthAnchor.constraint(equalToConstant: 14),
            passwordCheckAlertImage.heightAnchor.constraint(equalToConstant: 14),
            
            
            passwordCountLabel.topAnchor.constraint(equalTo: passwordView.bottomAnchor),
            passwordCountLabel.trailingAnchor.constraint(equalTo: passwordView.trailingAnchor),
            
            passwordCheckCountLabel.topAnchor.constraint(equalTo: passwordCheckView.bottomAnchor),
            passwordCheckCountLabel.trailingAnchor.constraint(equalTo: passwordCheckView.trailingAnchor),
            
            passwordCheckView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: viewHeight),
            
            passwordCheckLabel.topAnchor.constraint(equalTo: passwordCheckView.topAnchor),
            passwordCheckLabel.leadingAnchor.constraint(equalTo: passwordCheckView.leadingAnchor),
            
            passwordCheckTextField.topAnchor.constraint(equalTo: passwordCheckLabel.bottomAnchor, constant: 8),
            passwordCheckTextField.leadingAnchor.constraint(equalTo: passwordCheckView.leadingAnchor),
            passwordCheckTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: textFieldHeight),
            passwordCheckTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: stackWidth),
            
            passwordCheckDeleteButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 40/812),
            passwordCheckDeleteButton.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 40/812),
            passwordCheckDeleteButton.centerYAnchor.constraint(equalTo: passwordCheckTextField.centerYAnchor),
            passwordCheckDeleteButton.trailingAnchor.constraint(equalTo: passwordCheckShowButton.leadingAnchor, constant: -8),
            
            passwordCheckShowButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 40/812),
            passwordCheckShowButton.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 40/812),
            passwordCheckShowButton.centerYAnchor.constraint(equalTo: passwordCheckTextField.centerYAnchor),
            passwordCheckShowButton.trailingAnchor.constraint(equalTo: passwordCheckTextField.trailingAnchor, constant: 0),
            
            completeButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: completeButtonHeight),
            completeButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: stackWidth),
            completeButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            completeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
            
        ])
    }
    
}

extension UITextField {
    var textPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: self)
            .compactMap { $0.object as? UITextField }
            .compactMap { $0.text }
            .eraseToAnyPublisher()
    }
}
