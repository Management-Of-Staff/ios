//
//  PopUpViewController.swift
//  App
//
//  Created by Taehwan Kim on 2023/04/02.
//  Copyright © 2023 Ozik. All rights reserved.
//

import UIKit
import DesignSystem

enum ConfirmLabelTypes {
    case notMatched
    case vertifyCompleted
    case alreadySignedUp
    case rightOwnerInfomation
    case wrongOwnerInfomation
    case vertifyFailed
    
    func getMessage() -> String {
        switch self {
        case .notMatched:
            return "작업이 성공적으로 완료되었습니다."
        default:
            return "Wrong"
        }
    }
}

final class ConfirmViewController: UIViewController {
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = ""
        return label
    }()
    
    let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    let confirmButton = UIButton(type: .system)

//    init(type: ConfirmLabelTypes) {
//        label.text = type.getMessage()
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view = containerView
        preferredContentSize.width = self.view.frame.width
        preferredContentSize.height = self.view.frame.height
        view.backgroundColor = .doingColor(.backgroundNeutral)

        // 확인 버튼을 추가
        confirmButton.setTitle("확인", for: .normal)
        confirmButton.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        view.addSubview(confirmButton)
        view.addSubview(label)
        // 확인 버튼의 크기와 위치를 설정
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            confirmButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            confirmButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16)
        ])
        
        // 배경을 회색 반투명으로 설정
//        view.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
        // 컨텐츠 뷰를 추가
//        let contentView = UIView()
//        contentView.backgroundColor = .doingColor(.backgroundNeutral)
//        contentView.layer.cornerRadius = 8.0
//        view.addSubview(contentView)
        configureUI()
        createLayout()
    }

    // 확인 버튼을 눌렀을 때 호출되는 액션 메서드
    @objc func confirmButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UI Function

extension ConfirmViewController {
    
    private func configureUI() {
        
    }
    
    private func createLayout() {
        
    }
    
}
