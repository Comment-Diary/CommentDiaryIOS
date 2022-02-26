//
//  LoginDataManager.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/02/21.
//

import Foundation
import Alamofire

class LoginDataManager {
    func loginPostData() {
        let url = "" //채우기
        let params = ["email" : LoginRequest.email,
                      "password" : LoginRequest.password]
        
        AF.request(url,
                   method: .post,
                   parameters: params,
                   encoder: JSONParameterEncoder(),
                   headers: nil)
            .validate()
            .responseDecodable(of: LoginResponse.self) { response in
                switch response.result {
                case .success(let response):
                    print("DEBUG >> Success \(response)")

                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}
