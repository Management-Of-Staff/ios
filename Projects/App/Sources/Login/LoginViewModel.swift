//
//  LoginViewModel.swift
//  App
//
//  Created by Taehwan Kim on 2023/03/30.
//  Copyright (c) 2023 Ozik. All rights reserved.
//

import Combine

protocol LoginViewModelType {
    associatedtype Input
    associatedtype Output
    func transform(input: Input) -> Output
}

final class LoginViewModel: LoginViewModelType {
    
    // MARK: - Properties
    private var cancelBag = Set<AnyCancellable>()
    @Published var phoneNumberInput: String = ""
    @Published var passwordInput: String = ""
    
    lazy var isValid: AnyPublisher<Bool, Never> = Publishers
        .CombineLatest($phoneNumberInput, $passwordInput)
        .map({ (phoneNumber: String, password: String) in
            if phoneNumber == "" || password == "" {
                return false
            }
            if phoneNumber == password {
                return true
            } else {
                return false
            }
        })
        .print()
        .eraseToAnyPublisher()

    struct Input {
        
    }

    struct Output {
        
    }
    
    // MARK: - Functions
    
    func transform(input: Input) -> Output {
        
        return Output()
    }
    
}
