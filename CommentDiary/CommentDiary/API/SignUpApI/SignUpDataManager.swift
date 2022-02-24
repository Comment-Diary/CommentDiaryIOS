//
//  SignUpDataManager.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/02/24.
//

import Foundation
import Alamofire

class SignUpDataManager {
    func signUpPostData() {
        let url = ""
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
                    if response.code == 1000 {
                        SignUpSuccessReponse.ResponseState = true
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}
