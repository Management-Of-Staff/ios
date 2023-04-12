//
//  SignUpOwnerViewController.swift
//  App
//
//  Created by 이범준 on 4/6/23.
//  Copyright © 2023 Ozik. All rights reserved.
//

import UIKit
import Combine

// 글자 수 20자 제한
// 텍스트 필드 밑줄 생성
// 레이아웃 조정
// 색 조정
// 글꼴 조정

class SignUpOwnerViewController: UIViewController {
    
    private var cancellables = Set<AnyCancellable>()
    private let viewModel = MainViewModel()
    
    private func bind(to viewModel: MainViewModel) {
        
        let input = MainViewModel.Input(
            userName: nameTextField.textPublisher.eraseToAnyPublisher(),
//            ownerNumber: ownerNumberTextField.textPublisher.eraseToAnyPublisher(),
            password: passwordTextField.textPublisher.eraseToAnyPublisher(),
            passwordAgaing: passwordCheckTextField.textPublisher.eraseToAnyPublisher()
        )

        let output = viewModel.transform(input: input)
        
//        output
//            .ownerNumberIsValid
//            .sink { [weak self] state in
//                if state == true {
//                    print("사업자 등록 번호 유효")
//                } else {
//                    print("없는 사업자 번호")
//                }
//            }
//            .store(in: &cancellables)
        
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
                self?.passwordCountLabel.text = "\(String($0.count)) / 20" }
            .store(in: &cancellables)
        
        output
            .passwordCheckIsValid
            .sink { [weak self] state in
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
        
        
//            .sink { [weak self] in
//                self?.passwordCheckAlertLabel.text = $0 }
//            .store(in: &cancellables)
        
        output
            .passwordCheckCount
            .sink { [weak self] in
                self?.passwordCheckCountLabel.text = "\(String($0.count)) / 20" }
            .store(in: &cancellables)

        output
            .buttonIsValid
            .sink(receiveValue: { [weak self] state in
                print(state)
                self?.completeButton.isEnabled = state
                self?.completeButton.backgroundColor = state ? .systemOrange : .systemGray
            })
            .store(in: &cancellables)
        
    }
    
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
    
    private let passwordAlertImage: UIImageView = {
        let imageView = UIImageView()
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
    
    private let passwordCheckAlertImage: UIImageView = {
        let imageView = UIImageView()
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
        button.backgroundColor = .systemGray
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 6
        button.layer.masksToBounds = true
//        button.isEnabled = false
        button.titleLabel?.font = .doingFont(size: .button, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func ownerNumberButtonAction(sender: UIButton!) {
        print("버튼이 눌렸습니다")
        let vc = OwnerNumberPopUpViewController()
        
        if ownerNumberIsValid(ownerNumber: ownerNumberTextField.text ?? "") {
            vc.contentLabel.text = "올바른 사업자 정보입니다."
        } else {
            vc.contentLabel.text = "사업자 정보를 찾을 수 없습니다."
        }
        vc.modalPresentationStyle = .overCurrentContext
        
        present(vc, animated: false, completion: nil)
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
        scrollView.addSubviews(signUpContentsStackView, passwordAlertLabel, passwordAlertImage, passwordCheckAlertLabel, passwordCheckAlertImage, passwordCountLabel, passwordCheckCountLabel, completeButton)
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
            
            passwordAlertImage.topAnchor.constraint(equalTo: passwordView.bottomAnchor),
            passwordAlertImage.leadingAnchor.constraint(equalTo: passwordView.leadingAnchor),
            
            passwordAlertLabel.topAnchor.constraint(equalTo: passwordView.bottomAnchor),
            passwordAlertLabel.leadingAnchor.constraint(equalTo: passwordAlertImage.trailingAnchor),
            
            passwordCountLabel.topAnchor.constraint(equalTo: passwordView.bottomAnchor),
            passwordCountLabel.trailingAnchor.constraint(equalTo: passwordView.trailingAnchor),
            
            passwordCheckAlertImage.topAnchor.constraint(equalTo: passwordCheckView.bottomAnchor),
            passwordCheckAlertImage.leadingAnchor.constraint(equalTo: passwordCheckView.leadingAnchor),
            
            passwordCheckAlertLabel.topAnchor.constraint(equalTo: passwordCheckView.bottomAnchor),
            passwordCheckAlertLabel.leadingAnchor.constraint(equalTo: passwordCheckAlertImage.trailingAnchor),
            
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

// var regExpPw = /(?=.*\d{1,50})(?=.*[~`!@#$%\^&*()-+=]{1,50})(?=.*[a-zA-Z]{2,50}).{8,50}$/;

// 모든 ViewModel이 채택할 protocol입니다

// 저는 모든 이벤트를 Input과 Ouput으로 구분지을꺼에요

// 예를들어 UserAction들은 다 Input에 속할꺼고, 그걸로 인해서 일어나야하는 결과 (button이 바뀐다던가..) 는 다 Output에 속하겠죠?

protocol ViewModelType {
    associatedtype Input
    associatedtype Output

    func transform(input: Input) -> Output
}

final class MainViewModel: ViewModelType {
    struct Input { // textField.text를 방출하는 publisher들
        let userName: AnyPublisher<String, Never>
//        let ownerNumber: AnyPublisher<String, Never>
        let password: AnyPublisher<String, Never>
        let passwordAgaing: AnyPublisher<String, Never>
    }
    
    struct Output { // input들을 CombineLatest로 조합한 후, map을 통해서 유효한지 아닌지를 나타내는 Bool값으로 방출할 publisher
//        let ownerNumberIsValid: AnyPublisher<Bool, Never>
        let passwordIsValid: AnyPublisher<Bool, Never>
        let passwordCheckIsValid: AnyPublisher<Bool, Never>
        let buttonIsValid: AnyPublisher<Bool, Never>
        let passwordCount: AnyPublisher<String, Never>
        let passwordCheckCount: AnyPublisher<String, Never>
//        let testIsValid: AnyPublisher<Bool, Never>
    }
    
    func transform(input: Input) -> Output {
        // 이거 수정해야함
//        let ownerNumberButtonStatePublisher = input.ownerNumber
//            .map { ownerNumber in
//                let veriNum: String = "137137135"// 검증 대응숫자
//                var checkSum: Int = 0 // 검증 번호
//
//                var bizNumArr: [Int] = []
//                for char in ownerNumber {
//                    bizNumArr.append(Int(String(char)) ?? 0)
//                }
//
//                var veriNumArr: [Int] = []
//                for char in ownerNumber {
//                    veriNumArr.append(Int(String(char)) ?? 0)
//                }
//
//                // 1. 검증 대응숫자 기준으로 두 값을 곱하여 1의 자리 숫자를 추출
//                var addValueArr: [Int] = []
//                var sum: Int = 0;
//                for num in 0...veriNumArr.count-1 {
//                    var tmp = bizNumArr[num] * veriNumArr[num]
//
//                    // 1~8 자리의 곱이 10 이상일 경우는 1자리의 숫자만 사용한다.
//                    if num < veriNumArr.count-1 {
//                        if tmp > 10 {
//                            tmp = tmp%10
//                        }
//                        sum += tmp
//                    }
//                    addValueArr.append(tmp)
//                    //print(tmp)
//                }
//
//                // 2. 마지막 9번번째 자리의 경우 10 이상일 경우 십의 자리와 일의 자리를 따로 숫자로 떼어서 합한다.
//                if addValueArr[addValueArr.count-1] >= 10 {
//                    var lastNumStr = String(addValueArr[addValueArr.count-1])
//                    var lastNumArr: [Int] = []
//                    for char in lastNumStr {
//                        lastNumArr.append(Int(String(char)) ?? 0)
//                    }
//                    sum += lastNumArr[0]
//                    sum += lastNumArr[1]
//                }
//                else {
//                    sum += addValueArr[addValueArr.count-1]
//                }
//
//                // 3. 검증 숫자 검출
//                checkSum = 10 - sum%10
//                if checkSum==10 {checkSum=0}
//
//                // 4. 검증
//                if checkSum == bizNumArr[bizNumArr.count-1] {
//                    return true // 검증 성공
//                }
//                else {
//                    return false // 검증 실패
//                }
//            }
//            .eraseToAnyPublisher()
        
        let passwordNumber = input.password
            .map { password in
                let idPattern = #"^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,15}$"#
                let isVaildPattern = (password.range(of: idPattern, options: .regularExpression) != nil)
                return isVaildPattern
            }
            .eraseToAnyPublisher()
        
        let passwordCheckNumber = input.passwordAgaing.combineLatest(input.password)
            .map { password, passwordAgaging in
                password == passwordAgaging
            }
            .eraseToAnyPublisher()
        
        let passwordCount = input.password
            .map { text -> String in
                let filteredText = text
                return filteredText
            }
            .eraseToAnyPublisher()
        
        let passwordCheckCount = input.passwordAgaing
            .map { text -> String in
                let filteredText = text
                return filteredText
            }
            .eraseToAnyPublisher()
        
        let buttonStatePublisher = input.userName.combineLatest(input.password, input.passwordAgaing)
            .map { user, password, passwordAgaing in
                user.count >= 4 &&
                password.count >= 6 &&
                password == passwordAgaing
            }
            .eraseToAnyPublisher()
        
        return Output(passwordIsValid: passwordNumber, passwordCheckIsValid: passwordCheckNumber, buttonIsValid: buttonStatePublisher, passwordCount: passwordCount, passwordCheckCount: passwordCheckCount)
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

