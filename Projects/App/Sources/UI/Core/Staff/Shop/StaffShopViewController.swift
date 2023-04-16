//
//  StaffShopViewController.swift
//  App
//
//  Created by Taehwan Kim on 2023/04/13.
//  Copyright (c) 2023 com.Ozik. All rights reserved.
//

import UIKit
import Combine
import DesignSystem

final class StaffShopViewController: UIViewController {
    
    // MARK: - Properties
    private var cancelBag = Set<AnyCancellable>()
    private let viewModel = StaffShopViewModel()
    
    private let headerView = UIView()
    private let scrollView = UIScrollView()
    private let usernameLabel = UILabel()
    private let adviseLabel = UILabel()
    private var userName: String = "호섭"
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        createLayout()
    }
    
    // MARK: - Function
    
}

// MARK: - UI Function

extension StaffShopViewController {
    
    private func configureUI() {
        view.addSubviews(headerView, scrollView)
        headerView.addSubviews(usernameLabel, adviseLabel)
        
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        adviseLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        headerView.backgroundColor = .mainStaff
        scrollView.backgroundColor = .gray
        
        usernameLabel.text = "\(userName)님,"
        usernameLabel.textColor = .backgroundNeutral
        
        adviseLabel.text = "근무를 유연하게 관리해보세요!"
        adviseLabel.textColor = .backgroundNeutral
        
    }
    
    private func createLayout() {
        NSLayoutConstraint.activate([
            
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            usernameLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            
            adviseLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 10),
            adviseLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
    
}
