//
//  SignUpCompleteViewModel.swift
//  App
//
//  Created by Taehwan Kim on 2023/04/03.
//  Copyright (c) 2023 Ozik. All rights reserved.
//

import Combine

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    func transform(input: Input) -> Output
}

final class SignUpCompleteViewModel: ViewModelType {
    
    // MARK: - Properties
    private var cancelBag = Set<AnyCancellable>()
    
    struct Input {
        
    }

    struct Output {
        
    }
    
    // MARK: - Functions
    
    func transform(input: Input) -> Output {
        
        return Output()
    }
    
}
