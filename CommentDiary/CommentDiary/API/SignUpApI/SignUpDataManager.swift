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
        let url = "http://comment-diary.shop/api/v1/members/sign-up"
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
                    if let httpStatusCOde = response.response?.statusCode {
                        switch(httpStatusCOde) {
                        case 409:
                            viewController.dismissIndicator()
                            viewController.presentBottomAlert(message: "이미 가입되어 있는 이메일입니다.")
                            
                        default:
                            viewController.presentBottomAlert(message: "이미 가입되어 있는 이메일입니다.")
                        }
                    }
                    
                }
            }
    }
}
