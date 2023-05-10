//
//  OwnerMyInfoViewController.swift
//  App
//
//  Created by Taehwan Kim on 2023/05/10.
//  Copyright (c) 2023 com.Ozik. All rights reserved.
//

import UIKit
import Combine

final class OwnerMyInfoViewController: UIViewController {
    
    // MARK: - Properties
    private var cancelBag = Set<AnyCancellable>()
    private let viewModel = OwnerMyInfoViewModel()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        createLayout()
    }
    
    // MARK: - Function
    
}


// MARK: - UI Function

extension OwnerMyInfoViewController {
    
    private func configureUI() {
        
    }
    
    private func createLayout() {
        
    }
    
}
