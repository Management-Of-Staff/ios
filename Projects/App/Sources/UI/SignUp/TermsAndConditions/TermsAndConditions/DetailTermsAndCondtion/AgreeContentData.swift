//
//  AgreeContentData.swift
//  App
//
//  Created by 이범준 on 4/29/23.
//  Copyright © 2023 com.Ozik. All rights reserved.
//

import Foundation

struct TermsContentDataObject {
    let title: String
    let subtitle: String
}

class TermsContentDataSet {
    static let data0: [TermsContentDataObject] = [
        TermsContentDataObject(title: "제 1 조 (목적",
                   subtitle: "본 약관은 오직(이하 '회사'라 함)이 제공하는 두잉(doing)에 관한 모든 제품 및 서비스(이하 '서비스'라 함)의 이용에 관한 조건에 대해 서비스를 이용하는 회원(이하 '회원'이라 함)과 회사간의 권리, 의무 및 책임사항, 기타 필요사항을 규정함을 목적으로 합니다."),
        TermsContentDataObject(title: "Why does Appreciation matter?",
                   subtitle: "It motivates me to keep creating content, and helps improve the reach of the article. It also lets me know wether the quality of the content is decent or not"),
        TermsContentDataObject(title: "Why am I writing this article?",
                   subtitle: "Right now as of 28th Aug,2021 i dont see any article or stackoverflow answering the question about making the UIlabels dynamically resize programatically. The issue is that we can easily do this with XiB, but the same implementation programatically is not giving the desired affect and the cells wont resize."),
        TermsContentDataObject(title: "Is there any other way to do this if I dont wannt use a container view",
                   subtitle: "I think there is another way to do this by calculating the number of lines you require and deciding the height appropriately."),
        TermsContentDataObject(title: "What is the advantage of this method?",
                   subtitle: "Quite a few of the folks complain that they cant use numberOfLines property in UILabel inside a TableViewCell but this shall allow you to do that.")
    ]
    
    static let data1: [TermsContentDataObject] = [
        TermsContentDataObject(title: "2번째 약관",
                   subtitle: "본 약관은 오직(이하 '회사'라 함)이 제공하는 두잉(doing)에 관한 모든 제품 및 서비스(이하 '서비스'라 함)의 이용에 관한 조건에 대해 서비스를 이용하는 회원(이하 '회원'이라 함)과 회사간의 권리, 의무 및 책임사항, 기타 필요사항을 규정함을 목적으로 합니다."),
        TermsContentDataObject(title: "Why does Appreciation matter?",
                   subtitle: "It motivates me to keep creating content, and helps improve the reach of the article. It also lets me know wether the quality of the content is decent or not"),
        TermsContentDataObject(title: "Why am I writing this article?",
                   subtitle: "Right now as of 28th Aug,2021 i dont see any article or stackoverflow answering the question about making the UIlabels dynamically resize programatically. The issue is that we can easily do this with XiB, but the same implementation programatically is not giving the desired affect and the cells wont resize."),
        TermsContentDataObject(title: "Is there any other way to do this if I dont wannt use a container view",
                   subtitle: "I think there is another way to do this by calculating the number of lines you require and deciding the height appropriately."),
        TermsContentDataObject(title: "What is the advantage of this method?",
                   subtitle: "Quite a few of the folks complain that they cant use numberOfLines property in UILabel inside a TableViewCell but this shall allow you to do that.")
    ]
    
    static let data2: [TermsContentDataObject] = [
        TermsContentDataObject(title: "3번째 약관",
                   subtitle: "본 약관은 오직(이하 '회사'라 함)이 제공하는 두잉(doing)에 관한 모든 제품 및 서비스(이하 '서비스'라 함)의 이용에 관한 조건에 대해 서비스를 이용하는 회원(이하 '회원'이라 함)과 회사간의 권리, 의무 및 책임사항, 기타 필요사항을 규정함을 목적으로 합니다."),
        TermsContentDataObject(title: "Why does Appreciation matter?",
                   subtitle: "It motivates me to keep creating content, and helps improve the reach of the article. It also lets me know wether the quality of the content is decent or not"),
        TermsContentDataObject(title: "Why am I writing this article?",
                   subtitle: "Right now as of 28th Aug,2021 i dont see any article or stackoverflow answering the question about making the UIlabels dynamically resize programatically. The issue is that we can easily do this with XiB, but the same implementation programatically is not giving the desired affect and the cells wont resize."),
        TermsContentDataObject(title: "Is there any other way to do this if I dont wannt use a container view",
                   subtitle: "I think there is another way to do this by calculating the number of lines you require and deciding the height appropriately."),
        TermsContentDataObject(title: "What is the advantage of this method?",
                   subtitle: "Quite a few of the folks complain that they cant use numberOfLines property in UILabel inside a TableViewCell but this shall allow you to do that.")
    ]
}
