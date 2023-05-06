//
//  TermsAndCondtionsViewModel.swift
//  AppTests
//
//  Created by 이범준 on 4/29/23.
//  Copyright © 2023 com.Ozik. All rights reserved.
//

import Foundation
import Combine

final class TermsAndCondtionsViewModel: ViewModelType {
    
    struct Input {
        let firstAgree: AnyPublisher<Bool, Never>
        let secondAgree: AnyPublisher<Bool, Never>
        let thirdAgree: AnyPublisher<Bool, Never>
        let allAgree: AnyPublisher<Bool, Never>
//        let dismissAgree: AnyPublisher<Bool, Never>
        
    }
    
    struct Output {
//        let firstAgreeIsPressed: AnyPublisher<Bool, Never>
        let remainAgreeIsPressed: AnyPublisher<Bool, Never>
        let allAgreeIsPressed: AnyPublisher<Bool, Never>
    }
    
    func transform(input: Input) -> Output {
//        let firstAgreeIsPressed = input.firstAgree
//            .map { state in
//                return state
//            }
//            .eraseToAnyPublisher()
//        let secondAgreeIsPressed = input.firstAgree
//            .map { state in
//                return state
//            }
//            .eraseToAnyPublisher()
//        let thirdAgreeIsPressed = input.firstAgree
//            .map { state in
//                return state
//            }
//            .eraseToAnyPublisher()

        let remainAgreeIsPressed = input.firstAgree.combineLatest(input.secondAgree, input.thirdAgree)
            .map { first, second, third in
                first == true && second == true && third == true
            }
            .eraseToAnyPublisher()
        
        let allAgreeIsPressed = input.allAgree
            .map { state in
                return state
            }
            .eraseToAnyPublisher()
        
        return Output(remainAgreeIsPressed: remainAgreeIsPressed, allAgreeIsPressed: allAgreeIsPressed)
    }
    
}
