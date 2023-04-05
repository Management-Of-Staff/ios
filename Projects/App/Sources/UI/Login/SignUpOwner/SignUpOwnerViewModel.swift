//
//  SignUpOwnerViewModel.swift
//  App
//
//  Created by Taehwan Kim on 2023/04/05.
//  Copyright (c) 2023 Ozik. All rights reserved.
//

import Combine

final class SignUpOwnerViewModel: ViewModelType {
    
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
