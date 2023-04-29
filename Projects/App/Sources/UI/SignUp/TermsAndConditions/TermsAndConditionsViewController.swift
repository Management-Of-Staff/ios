//
//  TermsAndConditionsViewController.swift
//  AppTests
//
//  Created by 이범준 on 4/29/23.
//  Copyright © 2023 com.Ozik. All rights reserved.
//

import Foundation

import UIKit
import DesignSystem
import Combine

class TermsAndConditionsViewController: UIViewController {
    
    private var cancellables = Set<AnyCancellable>()
    private let viewModel = TermsAndCondtionsViewModel()
    let privacyAgreeVC = PrivacyAgreeViewController()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
//        scrollView.backgroundColor = .backgroundNeutral
        scrollView.backgroundColor = .white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private let allAgreeTermsView: UIView = { // 수정 예정
        let view = UIView()
//        view.backgroundColor = .backgroundNeutral
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.gray.cgColor // 수정 예정 및 테두리 둥글게 수정
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let allAgreeCheckMarkButton: UIButton = {
        let button = UIButton()

        button.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        button.tintColor = .gray
//        button.tintColor = .disabledText
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let allAgreeLabel: UILabel = {
        let label = UILabel()

        label.text = "전체 약관 동의"
//        label.font = .doingFont(size: .body, weight: .medium)
        label.font = .boldSystemFont(ofSize: 15)
//        label.tintColor = .black4
        label.tintColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let termsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let firstTermsView: UIView = {
        let view = UIView()

        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private let secondTermsView: UIView = {
        let view = UIView()

        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private let thirdTermsView: UIView = {
        let view = UIView()

        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()
    // test
    private let firstTermsCheckMarkButton: UIButton = {
        let button = UIButton()

        button.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
//        button.tintColor = .disabledText
        button.tintColor = .gray
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()

    private let firstTermsLabel: UILabel = {
        let label = UILabel()

        label.font = .systemFont(ofSize: 15)
        label.text = "(필수) 개인정보 수집 및 이용 동의"
//        label.font = .doingFont(size: .caption, weight: .medium)
        label.font = .boldSystemFont(ofSize: 15)
//        label.tintColor = .black4
        label.tintColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let firstTermsChevronButton: UIButton = {
        let button = UIButton()

        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
//        button.tintColor = .black1
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let secondTermsCheckMarkButton: UIButton = {
        let button = UIButton()

        button.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
//        button.tintColor = .disabledText
        button.tintColor = .gray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let secondTermsLabel: UILabel = {
        let label = UILabel()

        label.font = .systemFont(ofSize: 15)
        label.text = "(필수) 만 14세 이상 이용"
//        button.titleLa /bel?.font = .doingFont(size: .button, weight: .medium)
//        label.font = .doingFont(size: .caption, weight: .medium)
        label.font = .boldSystemFont(ofSize: 15)
//        label.tintColor = .black4
        label.tintColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let secondTermsChevronButton: UIButton = {
        let button = UIButton()

        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
//        button.tintColor = .black1
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let thirdTermsCheckMarkButton: UIButton = {
        let button = UIButton()

        button.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
//        button.tintColor = .disabledText
        button.tintColor = .gray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let thirdTermsLabel: UILabel = {
        let label = UILabel()
        label.text = "(필수) '오직' 이용약관"
//        label.font = .doingFont(size: .caption, weight: .medium)
        label.font = .boldSystemFont(ofSize: 15)
//        label.tintColor = .black4
        label.tintColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("다음", for: .normal)
        button.setTitleColor(.white, for: .normal) // .disabletext로 수정해야함
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
//        button.titleLabel?.font = .doingFont(size: .button, weight: .bold)
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
//        button.backgroundColor = .disabledText // disable1으로 수정해야함
        button.backgroundColor = .gray
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let thirdTermsChevronButton: UIButton = {
        let button = UIButton()

        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
//        button.tintColor = .black1
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .backgroundNeutral
        view.backgroundColor = .gray
        configureUI()
        createLayout()
        bind(to: viewModel)
    }
    
    // MARK: - ViewModel 바인딩
    private func bind(to viewModel: TermsAndCondtionsViewModel) {
        
        let input = TermsAndCondtionsViewModel.Input(
            firstAgree: firstTermsCheckMarkButton.touchPublisher.eraseToAnyPublisher(),
            secondAgree: secondTermsCheckMarkButton.touchPublisher.eraseToAnyPublisher(),
            thirdAgree: thirdTermsCheckMarkButton.touchPublisher.eraseToAnyPublisher(),
            allAgree: allAgreeCheckMarkButton.touchPublisher.eraseToAnyPublisher(),
            privacyAgreeButton: privacyAgreeVC.allAgreeButton.touchPublisher.eraseToAnyPublisher()
        )
        
        let output = viewModel.transform(input: input)
        
        output.remainAgreeIsPressed
            .sink { [weak self] state in
                self?.allAgreeCheckMarkButton.tintColor = state ? .blue : .gray
                self?.nextButton.backgroundColor = state ? .blue : .gray
            }
            .store(in: &cancellables)
        
        output.allAgreeIsPressed
            .sink { [weak self] state in
                self?.firstTermsCheckMarkButton.tintColor = state ? .blue : .gray
                self?.secondTermsCheckMarkButton.tintColor = state ? .blue : .gray
                self?.thirdTermsCheckMarkButton.tintColor = state ? .blue : .gray
                // TODO: -색 뿐만 아니라 isEnabled 설정 추가
                self?.nextButton.backgroundColor = state ? .blue: .gray
            }
            .store(in: &cancellables)
        
        output.privacyAgreeButtonIsPressed
            .sink { [weak self] state in
                self?.allAgreeCheckMarkButton.tintColor = state ? .blue : .gray
                self?.firstTermsCheckMarkButton.tintColor = state ? .blue : .gray
                self?.secondTermsCheckMarkButton.tintColor = state ? .blue : .gray
                self?.thirdTermsCheckMarkButton.tintColor = state ? .blue : .gray
                self?.nextButton.backgroundColor = state ? .blue: .gray
            }
            .store(in: &cancellables)
    }
}

extension TermsAndConditionsViewController {

    private func configureUI() {
        view.addSubview(scrollView)
        scrollView.addSubviews(allAgreeTermsView, termsStackView, nextButton)
        termsStackView.addArrangedSubViews(firstTermsView, secondTermsView, thirdTermsView)
        
        allAgreeTermsView.addSubviews(allAgreeCheckMarkButton, allAgreeLabel)

        firstTermsView.addSubviews(firstTermsCheckMarkButton, firstTermsLabel, firstTermsChevronButton)
        firstTermsChevronButton.addTarget(self, action: #selector(firstChevronButtonAction), for: .touchUpInside)

        secondTermsView.addSubviews(secondTermsCheckMarkButton, secondTermsLabel, secondTermsChevronButton)
        secondTermsChevronButton.addTarget(self, action: #selector(secondChevronButtonAction), for: .touchUpInside)
        
        thirdTermsView.addSubviews(thirdTermsCheckMarkButton, thirdTermsLabel, thirdTermsChevronButton)
        thirdTermsChevronButton.addTarget(self, action: #selector(thirdChevronButtonAction), for: .touchUpInside)
        
        nextButton.addTarget(self, action: #selector(nextButtonAction), for: .touchUpInside)
    }
    
    @objc func firstChevronButtonAction(sender: UIButton!) {
        privacyAgreeVC.termNumber = 0
        privacyAgreeVC.modalPresentationStyle = .fullScreen
        self.present(privacyAgreeVC, animated: true, completion: nil)
    }
    
    @objc func secondChevronButtonAction(sender: UIButton!) {
        privacyAgreeVC.termNumber = 1
        privacyAgreeVC.modalPresentationStyle = .fullScreen
        self.present(privacyAgreeVC, animated: true, completion: nil)
    }
    
    @objc func thirdChevronButtonAction(sender: UIButton!) {
        privacyAgreeVC.termNumber = 2
        privacyAgreeVC.modalPresentationStyle = .fullScreen
        self.present(privacyAgreeVC, animated: true, completion: nil)
    }
    
    @objc func nextButtonAction(sender: UIButton!) {
        print("다음 버튼이 눌렸습니다")
    }
    
    private func createLayout() {

        let allAgreeStackHeight: CGFloat = 57/812
        let termsStackWidth: CGFloat = 327/375
        let termsStackHeight: CGFloat = 112/812
        let segmentHeight: CGFloat = 24/812

        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            allAgreeTermsView.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 44),
            allAgreeTermsView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            allAgreeTermsView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: termsStackWidth),
            allAgreeTermsView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: allAgreeStackHeight),

            allAgreeCheckMarkButton.centerYAnchor.constraint(equalTo: allAgreeTermsView.centerYAnchor),
            allAgreeCheckMarkButton.leadingAnchor.constraint(equalTo: allAgreeTermsView.leadingAnchor, constant: 12),
            allAgreeLabel.centerYAnchor.constraint(equalTo: allAgreeTermsView.centerYAnchor),
            allAgreeLabel.leadingAnchor.constraint(equalTo: allAgreeCheckMarkButton.trailingAnchor, constant: 11),

            termsStackView.topAnchor.constraint(equalTo: allAgreeTermsView.bottomAnchor, constant: 32),
            termsStackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            termsStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: termsStackWidth),
            termsStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: termsStackHeight),

            firstTermsView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: segmentHeight),

            firstTermsCheckMarkButton.centerYAnchor.constraint(equalTo: firstTermsView.centerYAnchor),
            firstTermsLabel.centerYAnchor.constraint(equalTo: firstTermsView.centerYAnchor),
            firstTermsLabel.leadingAnchor.constraint(equalTo: firstTermsView.leadingAnchor, constant: 30),
            firstTermsChevronButton.centerYAnchor.constraint(equalTo: firstTermsView.centerYAnchor),
            firstTermsChevronButton.trailingAnchor.constraint(equalTo: firstTermsView.trailingAnchor, constant: 0),

            secondTermsView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: segmentHeight),

            secondTermsCheckMarkButton.centerYAnchor.constraint(equalTo: secondTermsView.centerYAnchor),
            secondTermsLabel.centerYAnchor.constraint(equalTo: secondTermsView.centerYAnchor),
            secondTermsLabel.leadingAnchor.constraint(equalTo: secondTermsView.leadingAnchor, constant: 30),
            secondTermsChevronButton.centerYAnchor.constraint(equalTo: secondTermsView.centerYAnchor),
            secondTermsChevronButton.trailingAnchor.constraint(equalTo: secondTermsView.trailingAnchor, constant: 0),

            thirdTermsView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: segmentHeight),

            thirdTermsCheckMarkButton.centerYAnchor.constraint(equalTo: thirdTermsView.centerYAnchor),
            thirdTermsLabel.centerYAnchor.constraint(equalTo: thirdTermsView.centerYAnchor),
            thirdTermsLabel.leadingAnchor.constraint(equalTo: thirdTermsView.leadingAnchor, constant: 30),
            thirdTermsChevronButton.centerYAnchor.constraint(equalTo: thirdTermsView.centerYAnchor),
            thirdTermsChevronButton.trailingAnchor.constraint(equalTo: thirdTermsView.trailingAnchor, constant: 0),

            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16), // 수정
            nextButton.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: termsStackWidth),
            nextButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            nextButton.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 52/812)
        ])
    }

}
