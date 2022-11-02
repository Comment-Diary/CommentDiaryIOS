//
//  SignUpDataManager.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/02/24.
//

import Foundation
import Alamofire
class SignUpDataManager {
    func signUpPostData(completion: @escaping (Int) -> (Void)) {
        let url = "\(Constant.CODA_URL)/members/sign-up"
        let params = ["email" : SignUpRequest.email,
                      "password" : SignUpRequest.password,
                      "checkPassword" : SignUpRequest.checkPassword,
                      "loginType" : SignUpRequest.loginType,
                      "pushyn" : SignUpRequest.pushYn]
        AF.request(url,
                   method: .post,
                   parameters: params,
                   encoder: JSONParameterEncoder(),
                   headers: nil)
            .validate()
            .responseDecodable(of: SignUpResponse.self) { response in
                completion(response.response?.statusCode ?? 0)
                switch response.result {
                case .success(let response):
                    print("DEBUG >> Success \(response)")

                case .failure(let error):
                    print(error.localizedDescription)

                }
            }
    }
}


class CodaSignUpDataManager {
    func signUpPostData(_ viewController: SignUpViewController) {
        let url = "\(Constant.CODA_URL)/members/sign-up"
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
                            
                        case 500:
                            viewController.dismissIndicator()
                            viewController.presentBottomAlert(message: "서버 내부에 에러가 발생했습니다.")
                        default:
                            viewController.dismissIndicator()
                            viewController.presentBottomAlert(message: "서버 내부에 에러가 발생했습니다.")
                        }
                    }
                    
                }
            }
    }
}
