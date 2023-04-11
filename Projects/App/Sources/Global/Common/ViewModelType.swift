//
//  ViewModelType.swift
//  App
//
//  Created by Taehwan Kim on 2023/04/05.
//  Copyright © 2023 Ozik. All rights reserved.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
