//
//  SignUpDataManager.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/02/24.
//

import Foundation
import Alamofire

class SignUpDataManager {
    func signUpPostData(_ viewController: SignUpViewController) {
        let url = "http://jwyang.shop:8080/api/v1/members"
        let params = ["email" : SignUpRequest.email,
                      "password" : SignUpRequest.password,
                      "checkPassword" : SignUpRequest.checkPassword]
        AF.request(url,
                   method: .post,
                   parameters: params,
                   encoder: JSONParameterEncoder(),
                   headers: nil)
            .validate()
            .responseDecodable(of: SignUpResponse.self) { response in
                switch response.result {
                case .success(let response):
                    print("DEBUG >> Success \(response)")
                    viewController.signUpResponse()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}
