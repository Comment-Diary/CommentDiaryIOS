//
//  AuthAPIService.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/03.
//

import Foundation
import Alamofire
import Combine
//인증 관련 api 호출

//enum AuthApiService {
//    static func login(email: String, password: String) ->
//
//    static func register(name: String, email: String, password: String) -> AnyPublisher<UserData, AFError> {
//        print("AuthApiService")
//
//    return ApiClient.shared.session
//        .request(AuthRouter.register(name: name, email: <#T##String#>, password: <#T##String#>))
//        .publishDecodable(type: AuthResposne.self)
//        .value()
//        .map { receivedValue in
//            return receivedValue.user
//        }.eraseToAnyPublisher()
//
////    유저데이터 없음
//    }
//}
