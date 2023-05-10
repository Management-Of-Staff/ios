//
//  OwnerShopViewController.swift
//  App
//
//  Created by Taehwan Kim on 2023/05/10.
//  Copyright (c) 2023 com.Ozik. All rights reserved.
//

import UIKit
import Combine
import DesignSystem

final class OwnerShopViewController: UIViewController {
    
    // MARK: - Properties
    private var cancelBag = Set<AnyCancellable>()
    private let viewModel = OwnerShopViewModel()
    private let headerView = UIView()
    private let scrollView = UIScrollView()
    private let usernameLabel = UILabel()
    private let adviseLabel = UILabel()
    private var userName: String = "메가커피"
    private let toDoButton = UIButton()
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        createLayout()
    }
    
    // MARK: - Function
    @objc
    private func toDoNavigation() {
        show(OwnerTodoViewController(), sender: self)
    }
}

// MARK: - UI Function

extension OwnerShopViewController {
    
    private func configureUI() {
        view.addSubviews(headerView, scrollView)
        headerView.addSubviews(usernameLabel, adviseLabel)
        scrollView.addSubviews(toDoButton)
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        adviseLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        toDoButton.translatesAutoresizingMaskIntoConstraints = false
        
        headerView.backgroundColor = .mainOwner
        scrollView.backgroundColor = .systemGray
        toDoButton.backgroundColor = .blue
        
        usernameLabel.text = "\(userName)"
        usernameLabel.textColor = .backgroundNeutral
        
        adviseLabel.text = "서울대학교 병원 2호점"
        adviseLabel.textColor = .backgroundNeutral
        
        toDoButton.setTitle("해야할 일", for: .normal)
        toDoButton.tintColor = .black
        toDoButton.addTarget(self, action: <#T##Selector#>, for: <#T##UIControl.Event#>)
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
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            toDoButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            toDoButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            toDoButton.bottomAnchor.constraint(equalTo: toDoButton.topAnchor, constant: 30)
        ])
    }
    
}
