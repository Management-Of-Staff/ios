//
//  NetworkService.swift
//  ProjectDescriptionHelpers
//
//  Created by Taehwan Kim on 2023/03/28.
//

import Foundation
import Moya
enum UserAPI {
    case login
}

public struct Service {
    public static let shared = Service()
    public static let doingProvider = MoyaProvider<DoingAPI>()
    public enum DoingAPI {
        case login(phoneNumber: String, password: String)
    }
}

extension Service.DoingAPI: TargetType {
    public var baseURL: URL {
        return URL(string: "https://port-0-api-9z2ygb26lcfy0xn8.gksl2.cloudtype.app/rest/v1/member-account/sign-in/owner")!
    }

    public var path: String {
        switch self {
        case .login:
            return "/login"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .login:
            return .post
        }
    }

    public var task: Moya.Task {
        switch self {
        case let .login(phoneNumber, password):
            let parameter: [String: String] = [
                "phoneNum": phoneNumber,
                "password": password
            ]
            return .requestParameters(parameters: parameter, encoding: JSONEncoding.default)
        }
    }

    public var headers: [String: String]? {
        return ["Accept": "*/*", "Content-Type": "application/json"]
    }
}
