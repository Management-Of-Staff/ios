//
//  StaffShopViewModel.swift
//  App
//
//  Created by Taehwan Kim on 2023/04/13.
//  Copyright (c) 2023 com.Ozik. All rights reserved.
//

import Combine

final class StaffShopViewModel: ViewModelType {
    
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
