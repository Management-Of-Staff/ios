//
//  Font.swift
//  DesignSystem
//
//  Created by Taehwan Kim on 2023/03/31.
//  Copyright © 2023 Ozik. All rights reserved.
//

import Foundation

public enum Font {
    // MARK: 영문 JOST가 존재하긴 하는데 지금 화면상에서 영어를 어디서 썼는지 모르겠어서 일단 한국어 기준으로 만들었습니다.
    // subtitle 2를 원하는 경우 body을 Bold로
    // body 2를 원하는 경우 button을 Regular로
    public enum Size: CGFloat {
        case headline1 = 48
        case headline2 = 34
        case headline3 = 24
        case subtitle = 20
        case body = 16
        case button = 14 // 버튼은 Medium
        case caption = 12 // Regular
    }
    
    public enum Weight {
        case regular
        case medium
        case bold
        
        var value: UIFont.Weight {
            switch self {
            case .regular:
                return .regular
            case .medium:
                return .medium
            case .bold:
                return .bold
            }
        }
    }
}
