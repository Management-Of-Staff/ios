//
//  SignUpOwnerViewModel.swift
//  App
//
//  Created by 이범준 on 4/12/23.
//  Copyright © 2023 Ozik. All rights reserved.
//

import Combine

protocol ViewModelType {
    associatedtype Input
    associatedtype Output

    func transform(input: Input) -> Output
}

final class MainViewModel: ViewModelType {
    struct Input { // textField.text를 방출하는 publisher들
//        let acceptedTerms: AnyPublisher<Bool, Never>
        let userName: AnyPublisher<String, Never>
        let ownerNumber: AnyPublisher<String, Never>
        let password: AnyPublisher<String, Never>
        let passwordCheck: AnyPublisher<String, Never>
    }
    
    struct Output { // input들을 CombineLatest로 조합한 후, map을 통해서 유효한지 아닌지를 나타내는 Bool값으로 방출할 publisher
//        let ownerNumberIsValid: AnyPublisher<Bool, Never>
        let passwordIsValid: AnyPublisher<Bool, Never>
        let passwordCheckIsValid: AnyPublisher<Bool, Never>
        let buttonIsValid: AnyPublisher<Bool, Never>
        let passwordCount: AnyPublisher<String, Never>
        let passwordCheckCount: AnyPublisher<String, Never>
        let ownerNumberLimit: AnyPublisher<String, Never>
        let passwordLimit: AnyPublisher<String, Never>
        let passwordCheckLimit: AnyPublisher<String, Never>
//        let testIsValid: AnyPublisher<Bool, Never>
    }
    
    func transform(input: Input) -> Output {
        
        let ownerNumberLimitPulisher = input.ownerNumber
            .map { text -> String in
                if text.count > 10 {
                    return String(text.prefix(10))
                }
                return text
            }
            .eraseToAnyPublisher()
        
        let passwordLimitPublisher = input.password
            .map { text -> String in
                if text.count > 20 {
                    return String(text.prefix(20))
                }
                return text
            }
            .eraseToAnyPublisher()
        
        let passwordCheckLimitPublisher = input.passwordCheck
            .map { text -> String in
                if text.count > 20 {
                    return String(text.prefix(20))
                }
                return text
            }
            .eraseToAnyPublisher()
        
        let passwordNumber = input.password
            .map { password in
                let idPattern = #"^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,15}$"#
                let isVaildPattern = (password.range(of: idPattern, options: .regularExpression) != nil)
                return isVaildPattern
            }
            .eraseToAnyPublisher()
        
        let passwordCheckNumber = input.passwordCheck.combineLatest(input.password)
            .map { password, passwordCheck in
                password == passwordCheck && password.count != 0  
            }
            .eraseToAnyPublisher()
        
        let passwordCount = input.password
            .map { text -> String in
                let filteredText = text
                return filteredText
            }
            .eraseToAnyPublisher()
        
        let passwordCheckCount = input.passwordCheck
            .map { text -> String in
                let filteredText = text
                return filteredText
            }
            .eraseToAnyPublisher()
        
        let buttonStatePublisher = input.userName.combineLatest(input.password, input.passwordCheck)
            .map { user, password, passwordCheck in
                user.count >= 1 &&
                password.count >= 6 &&
                password == passwordCheck
            }
            .eraseToAnyPublisher()
        
        return Output(passwordIsValid: passwordNumber, passwordCheckIsValid: passwordCheckNumber, buttonIsValid: buttonStatePublisher, passwordCount: passwordCount, passwordCheckCount: passwordCheckCount, ownerNumberLimit: ownerNumberLimitPulisher, passwordLimit: passwordLimitPublisher, passwordCheckLimit: passwordCheckLimitPublisher)
    }
}
