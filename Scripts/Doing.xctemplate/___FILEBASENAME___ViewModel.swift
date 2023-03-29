//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import RxSwift
import RxCocoa

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    func transform(input: Input) -> Output
}

final class ___VARIABLE_sceneName___ViewModel: ViewModelType {
    
    // MARK: - Properties
    private let disposeBag = DisposeBag()
    
    struct Input {
        
    }

    struct Output {
        
    }
    
    // MARK: - Functions
    
    func transform(input: Input) -> Output {
        
        return Output()
    }
    
}
