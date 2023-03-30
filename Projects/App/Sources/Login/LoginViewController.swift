//
//  LoginViewController.swift
//  App
//
//  Created by Taehwan Kim on 2023/03/30.
//  Copyright (c) 2023 Ozik. All rights reserved.
//

import UIKit
import Combine

final class LoginViewController: UIViewController {
    
    // MARK: - Properties
    private var cancelBag = Set<AnyCancellable>()
    private let viewModel = LoginViewModel()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        createLayout()
    }
    
    // MARK: - Function
    
}


// MARK: - UI Function

extension LoginViewController {
    
    private func configureUI() {
        
    }
    
    private func createLayout() {
        
    }
    
}
