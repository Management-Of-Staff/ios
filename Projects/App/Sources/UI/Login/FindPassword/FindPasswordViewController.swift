//
//  FindPasswordViewController.swift
//  App
//
//  Created by Taehwan Kim on 2023/04/05.
//  Copyright (c) 2023 Ozik. All rights reserved.
//

import UIKit
import Combine
import DesignSystem

final class FindPasswordViewController: UIViewController {
    
    // MARK: - Properties
    private var cancelBag = Set<AnyCancellable>()
    private let viewModel = FindPasswordViewModel()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .doingColor(.backgroundNeutral)
        configureUI()
        createLayout()
        print("여기 Find임")
    }
    
    // MARK: - Function
    
}

// MARK: - UI Function

extension FindPasswordViewController {
    
    private func configureUI() {
        
    }
    
    private func createLayout() {
        
    }
    
}
