//
//  LoginDataManager.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/02/21.
//

import Foundation
import Alamofire

class LoginDataManager {
    func loginPostData(_ viewController: LoginViewController) {
        let url = "http://jwyang.shop:8080/api/v1/members/login"
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
//                    //AccessToken 저장
                    UserDefaults.standard.set(response.result.accessToken, forKey: "AccessToken")
                    print(response.result.accessToken, "어세스토큰")
//                    //RefreshToken 저장
                    UserDefaults.standard.set(response.result.refreshToken, forKey: "RefreshToken")
//                    UserDefaultManager.shared.setTokens(accessToken: response.result.accessToken, refreshToken: response.result.refreshToken) //access refresh

                    
                    viewController.loginSuccessResponse()

                case .failure(let error):
                    print(error.localizedDescription)
                    viewController.loginFailResponse()
                }
            }
    }
}

class LoginAPIDataManager {
    func loginPostData(_ viewController: SignUpCompletionViewController) {
        let url = "http://jwyang.shop:8080/api/v1/members/login"
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
                    viewController.loginSuccessResponse()

                case .failure(let error):
                    print(error.localizedDescription)
                    viewController.loginFailResponse()
                }
            }
    }
}
