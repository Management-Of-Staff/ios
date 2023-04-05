//
//  LoginViewModel.swift
//  App
//
//  Created by Taehwan Kim on 2023/03/30.
//  Copyright (c) 2023 Ozik. All rights reserved.
//

import Combine

//final class LoginViewModel {
//    
//    // MARK: - Properties
//    private var cancellables = Set<AnyCancellable>()
//    //    @Published var phoneNumberText: String = ""
//    //    @Published var passwordText: String = ""
//    
//    //    @Published var isValidPhoneNumber = false
//    //    @Published var isValidPassword = false
//    //    @Published var isValidButton = false
//    
//    struct Input {
//        let phoneNumber: AnyPublisher<String, Never>
//        let password: AnyPublisher<String, Never>
//        let tapLoginButton: AnyPublisher<Void, Never>
//    }
//    
//    private let phoneNumber = CurrentValueSubject<String, Never>("")
//    private let password = CurrentValueSubject<String, Never>("")
//    private var isValidButton: AnyPublisher<Bool, Never>
//    
//    struct Output {
//        let resultPhoneNumber: AnyPublisher<String, Never>
//        let resultPassword: AnyPublisher<String, Never>
//        let isButtonEnabled: AnyPublisher<Bool, Never>
//    }
//    
//    //    init(){
//    //        
//    //    }
//    
//    //    func transform(input: Input) -> Output {
//    //        return Output(resultPhoneNumber: AnyPublisher<String, Never>, resultPassword: AnyPublisher<String, Never>, isButtonEnabled: AnyPublisher<Bool, Never>)
//    //        input.phoneNumber
//    //            .map { text -> String in
//    //                let filteredText = text.filter("0123456789".contains)
//    //                if filteredText.count > 13 {
//    //                    return String(filteredText.prefix(13))
//    //                }
//    //                return filteredText
//    //            }
//    //            .assign(to: \.value, on: phoneNumber)
//    //            .store(in: &cancellables)
//    //
//    //        input.password
//    //            .map { $0 }
//    //            .assign(to: \.value, on: password)
//    //            .store(in: &cancellables)
//    //
//    //        let buttonState = input.phoneNumber.combineLatest(input.password)
//    //            .map({ phone, pass in
//    //                !phone.isEmpty && !pass.isEmpty && phone.count > 12 && pass.count > 6
//    //            })
//    //            .eraseToAnyPublisher()
//    //
//    //        return Output(
//    //            resultPhoneNumber: phoneNumber.eraseToAnyPublisher(),
//    //            resultPassword: password.eraseToAnyPublisher(),
//    //            isButtonEnabled: buttonState
//    //        )
////}
//}
//
//
//extension LoginViewModel {
//
//    private func checkValidPhoneNumber(number: String) -> Bool {
//        return number.count > 12
//    }
//    
//    private func checkValidPassword(password: String) -> Bool {
//        return password.count > 6
//    }
//    
//    private func checkValidBoth(number: Bool, password: Bool) -> Bool {
//        return number && password
//    }
//    
//}
