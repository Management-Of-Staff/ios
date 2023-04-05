//
//  LoginViewModel.swift
//  App
//
//  Created by Taehwan Kim on 2023/03/30.
//  Copyright (c) 2023 Ozik. All rights reserved.
//

import Combine

final class LoginViewModel: ViewModelType {
    
    // MARK: - Properties
    private var cancelBag = Set<AnyCancellable>()
    @Published var phoneNumberText: String = ""
    @Published var passwordText: String = ""
    
    @Published var isValidPhoneNumber = false
    @Published var isValidPassword = false
    @Published var isValidButton = false

    struct Input {
        
    }

    struct Output {
        
    }
    
    init() {
        $phoneNumberText
            .map(checkValidPhoneNumber)
            .assign(to: \.isValidPhoneNumber, on: self)
            .store(in: &cancelBag)
        
        $passwordText
            .map(checkValidPassword)
            .assign(to: \.isValidPassword, on: self)
            .store(in: &cancelBag)
        
        $isValidPhoneNumber.combineLatest($isValidPassword)
            .map(checkValidBoth)
            .assign(to: \.isValidButton, on: self)
            .store(in: &cancelBag)
    }
}

extension LoginViewModel {

    private func checkValidPhoneNumber(number: String) -> Bool {
        return number.count > 12
    }
    
    private func checkValidPassword(password: String) -> Bool {
        return password.count > 6
    }
    
    private func checkValidBoth(number: Bool, password: Bool) -> Bool {
        return number && password
    }
    
}
