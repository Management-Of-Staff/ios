//
//  LoginViewModel.swift
//  App
//
//  Created by Taehwan Kim on 2023/03/30.
//  Copyright (c) 2023 Ozik. All rights reserved.
//

import Combine
import UIKit

final class LoginViewModel {
    
    private var cancellable = Set<AnyCancellable>()
    
    struct Input {
         let phoneNumber: AnyPublisher<String, Never>
         let password: AnyPublisher<String, Never>
    }
    struct Output {
         let resultPhoneNumber: AnyPublisher<String, Never>
         let buttonState: AnyPublisher<Bool, Never>
    }
    
    func transform(input: Input) -> Output {
        
        let resultPhoneNumber = input.phoneNumber
            .map { text -> String in
                let filteredText = text.filter("0123456789".contains)
                if filteredText.count > 13 {
                    return String(filteredText.prefix(13))
                }
                return filteredText
            }
            .eraseToAnyPublisher()
        
        let buttonStatePublisher = input.phoneNumber.combineLatest(input.password)
            .map { phoneNumber, password in
                phoneNumber.count > 10 && password.count > 5
            }
            .eraseToAnyPublisher()
        
        return Output(resultPhoneNumber: resultPhoneNumber, buttonState: buttonStatePublisher)
    }
}
