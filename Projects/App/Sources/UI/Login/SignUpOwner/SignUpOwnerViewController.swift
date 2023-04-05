//
//  SignUpOwnerViewController.swift
//  App
//
//  Created by Taehwan Kim on 2023/04/05.
//  Copyright (c) 2023 Ozik. All rights reserved.
//

import UIKit
import Combine
import DesignSystem

final class SignUpOwnerViewController: UIViewController {
    
    // MARK: - Properties
    private var cancelBag = Set<AnyCancellable>()
    private let viewModel = SignUpOwnerViewModel()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .doingColor(.backgroundNeutral)
        configureUI()
        createLayout()
    }
    
    // MARK: - Function
    
}

// MARK: - UI Function

extension SignUpOwnerViewController {
    
    private func configureUI() {
        
    }
    
    private func createLayout() {
        
    }
    
}
